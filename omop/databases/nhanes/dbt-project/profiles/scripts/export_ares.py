#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Combined ARES Exporter.
Retrieves database credentials and schemas from dbt project configuration,
copies the static ARES web assets, exports DQD results, and exports Achilles
statistics directly to target/ares/ ready to be served.
"""

from __future__ import annotations

import json
import math
import os
import re
import shutil
import sys
from decimal import Decimal
from datetime import datetime, date, timezone
from pathlib import Path
from typing import Any, Dict, List, Optional
import zipfile
import click
import yaml
import pandas as pd
import numpy as np
import sqlalchemy
from sqlalchemy import text
from sqlalchemy.engine import Engine, URL
def snake_to_camel(name: str) -> str:
    if "_" not in name:
        return name
    parts = [p for p in name.split("_") if p]
    if not parts:
        return name
    return parts[0].lower() + "".join(p[:1].upper() + p[1:] for p in parts[1:])


def df_snake_to_camel(df: pd.DataFrame) -> pd.DataFrame:
    return df.rename(columns={c: snake_to_camel(c) for c in df.columns})


# ---------------------------------------------------------------------------
# Jinja env_var resolver for profiles.yml
# ---------------------------------------------------------------------------

def resolve_env_vars(obj: Any) -> Any:
    """Recursively resolve dbt-style env_var() expressions in configuration dictionary."""
    if isinstance(obj, dict):
        return {k: resolve_env_vars(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [resolve_env_vars(v) for v in obj]
    elif isinstance(obj, str):
        if 'env_var' in obj:
            match = re.search(r"env_var\(['\"]([^'\"]+)['\"]\)", obj)
            if match:
                var_name = match.group(1)
                val = os.getenv(var_name)
                if val is None:
                    raise ValueError(
                        f"Environment variable '{var_name}' is required by profiles.yml but not set in the environment. "
                        "Please verify your .env file or environment variables."
                    )
                if 'as_number' in obj:
                    try:
                        return int(val)
                    except ValueError:
                        return float(val)
                return val
    return obj


def load_env_file(project_root: str) -> None:
    """Load environment variables from .env file into os.environ if present."""
    env_path = os.path.join(project_root, ".env")
    if os.path.isfile(env_path):
        print(f"Loading environment variables from {env_path}...")
        with open(env_path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue
                if line.startswith("export "):
                    line = line[7:]
                parts = line.split("=", 1)
                if len(parts) == 2:
                    k = parts[0].strip()
                    v = parts[1].strip()
                    if (v.startswith('"') and v.endswith('"')) or (v.startswith("'") and v.endswith("'")):
                        v = v[1:-1]
                    os.environ[k] = v


def load_db_credentials(project_root: str, target_override: Optional[str] = None) -> Dict[str, Any]:
    """Load project config and profile target connection credentials, resolving environment variables."""
    # 1. Load env vars
    load_env_file(project_root)

    # 2. Try loading credentials using the real dbt library
    try:
        from dbt.config.profile import Profile
        from dbt.config.renderer import ProfileRenderer
        from dbt.context.base import generate_base_context
        from dbt_common.context import set_invocation_context
        from argparse import Namespace
        import dbt.flags as flags
        
        # Determine profiles directory
        profiles_dir = os.path.join(project_root, "profiles")
        if not os.path.exists(os.path.join(profiles_dir, "profiles.yml")):
            profiles_dir = os.path.expanduser("~/.dbt")
            
        # Initialize invocation context
        set_invocation_context(dict(os.environ))
        
        # Load dbt_project.yml to get project and profile name
        project_path = os.path.join(project_root, "dbt_project.yml")
        with open(project_path, "r", encoding="utf-8") as f:
            project_dict = yaml.safe_load(f)
        project_name = project_dict.get("name")
        profile_name = project_dict.get("profile", project_name)
        
        # Initialize dbt flags
        args = Namespace(
            profiles_dir=profiles_dir,
            project_dir=project_root,
            target=target_override,
            profile=None,
            threads=None,
        )
        flags.set_from_args(args, {})
        
        # Read profile
        profiles_path = os.path.join(profiles_dir, "profiles.yml")
        with open(profiles_path, "r", encoding="utf-8") as f:
            raw_profiles = yaml.safe_load(f)
            
        renderer = ProfileRenderer(generate_base_context({}))
        profile = Profile.from_raw_profiles(
            raw_profiles=raw_profiles,
            profile_name=profile_name,
            target_override=target_override,
            renderer=renderer
        )
        
        creds = profile.credentials
        dialect = getattr(creds, "type", "postgresql")
        if dialect == "postgres":
            dialect = "postgresql"
            
        print(f"Loaded credentials programmatically via dbt library (Target: {profile.target_name})")
        return {
            "project_name": project_name,
            "profile_name": profile_name,
            "target_name": profile.target_name,
            "dialect": dialect,
            "host": getattr(creds, "host", "localhost"),
            "port": getattr(creds, "port", 5432),
            "user": getattr(creds, "user", "postgres"),
            "password": getattr(creds, "password", getattr(creds, "pass", "")),
            "dbname": getattr(creds, "database", getattr(creds, "dbname", "")),
            "schema": getattr(creds, "schema", "cdm"),
        }
    except Exception as e:
        print(f"Warning: Loading credentials via dbt library failed ({e}). Falling back to manual YAML parsing.")

    # 3. Fallback: Manual YAML parsing
    project_path = os.path.join(project_root, "dbt_project.yml")
    if not os.path.exists(project_path):
        raise FileNotFoundError(f"dbt_project.yml not found at {project_path}")

    with open(project_path, "r", encoding="utf-8") as f:
        project_dict = yaml.safe_load(f)
    project_name = project_dict.get("name")
    profile_name = project_dict.get("profile", project_name)

    profiles_path = os.path.join(project_root, "profiles", "profiles.yml")
    if not os.path.exists(profiles_path):
        profiles_path = os.path.expanduser("~/.dbt/profiles.yml")
    if not os.path.exists(profiles_path):
        raise FileNotFoundError(f"profiles.yml not found in project profiles/ or ~/.dbt/")

    with open(profiles_path, "r", encoding="utf-8") as f:
        profiles_dict = yaml.safe_load(f)

    if profile_name not in profiles_dict:
        raise ValueError(f"Profile '{profile_name}' not found in profiles.yml")

    profile_data = profiles_dict[profile_name]
    target_name = target_override or profile_data.get("target", "default")
    
    if "outputs" not in profile_data or target_name not in profile_data["outputs"]:
        outputs = profile_data.get("outputs", {})
        if outputs:
            target_name = list(outputs.keys())[0]
            print(f"Target '{target_override}' not found. Falling back to target: '{target_name}'")
        else:
            raise ValueError(f"No outputs found in profile '{profile_name}'")

    output_config = profile_data["outputs"][target_name]

    resolved_config = resolve_env_vars(output_config)

    return {
        "project_name": project_name,
        "profile_name": profile_name,
        "target_name": target_name,
        "dialect": resolved_config.get("type", "postgresql"),
        "host": resolved_config.get("host", "localhost"),
        "port": resolved_config.get("port", 5432),
        "user": resolved_config.get("user", "postgres"),
        "password": resolved_config.get("pass", ""),
        "dbname": resolved_config.get("dbname", ""),
        "schema": resolved_config.get("schema", "cdm"),
    }


def resolve_schemas(project_root: str, project_name: str) -> tuple[str, str, str]:
    """Parse schema targets from manifest.json (or fallback to raw project configuration)."""
    manifest_path = os.path.join(project_root, "target", "manifest.json")
    cdm_schema = None
    results_schema = None
    vocab_schema = None
    
    if os.path.exists(manifest_path):
        try:
            with open(manifest_path, "r", encoding="utf-8") as f:
                data = json.load(f)
            nodes = data.get("nodes", {})
            for key, node in nodes.items():
                res_type = node.get("resource_type")
                fqn = node.get("fqn", [])
                schema = node.get("schema")
                if res_type in ("model", "seed"):
                    if "cdm" in fqn:
                        cdm_schema = schema
                    elif "achilles" in fqn or "dqd" in fqn:
                        results_schema = schema
            sources = data.get("sources", {})
            for key, source in sources.items():
                if source.get("source_name") == "vocabularies":
                    vocab_schema = source.get("schema")
            print(f"Extracted resolved schemas from target/manifest.json: cdm={cdm_schema}, results={results_schema}, vocab={vocab_schema}")
        except Exception as e:
            print(f"Warning: could not parse manifest.json: {e}")
            
    # Fallback to dbt_project.yml
    if not cdm_schema or not results_schema:
        try:
            with open(os.path.join(project_root, "dbt_project.yml"), "r", encoding="utf-8") as f:
                project_dict = yaml.safe_load(f)
            models_config = project_dict.get("models", {}).get(project_name, {})
            
            if not cdm_schema:
                cdm_config = models_config.get("cdm", {})
                cdm_schema = cdm_config.get("schema") or cdm_config.get("+schema") or "cdm"
                
            if not results_schema:
                ach_config = models_config.get("achilles", {})
                results_schema = ach_config.get("schema") or ach_config.get("+schema")
                if not results_schema:
                    dqd_config = models_config.get("dqd", {})
                    results_schema = dqd_config.get("schema") or dqd_config.get("+schema") or "results"
        except Exception as e:
            print(f"Warning: could not parse dbt_project.yml for schemas: {e}")
            
    if not cdm_schema:
        cdm_schema = "cdm"
    if not results_schema:
        results_schema = "results"
    if not vocab_schema:
        vocab_schema = "vocabularies"
        
    return cdm_schema, results_schema, vocab_schema


# ---------------------------------------------------------------------------
# JSON/CSV helpers
# ---------------------------------------------------------------------------

class DecimalEncoder(json.JSONEncoder):
    """JSON encoder for Decimal, date, datetime, NaN, Infinity."""
    def default(self, obj):
        if isinstance(obj, Decimal):
            return float(obj)
        if isinstance(obj, date):
            return obj.isoformat()
        if isinstance(obj, datetime):
            return obj.isoformat()
        if isinstance(obj, (float, np.floating)) and (math.isnan(obj) or math.isinf(obj)):
            return None
        return super().default(obj)


def _df_to_json_serializable(df: pd.DataFrame) -> List[Dict[str, Any]]:
    """Convert DataFrame to list of dicts with NaN/Inf -> None and uppercase keys."""
    df2 = df.replace([np.nan, pd.NA], None)
    for col in df2.columns:
        if df2[col].dtype in ("float64", "float32"):
            df2[col] = df2[col].replace([np.nan, np.inf, -np.inf], None)
    return [{k.upper(): (None if (isinstance(v, float) and (math.isnan(v) or math.isinf(v))) else v)
            for k, v in row.items()} for row in df2.to_dict(orient="records")]


def _write_csv(df: pd.DataFrame, path: str, uppercase_cols: bool = True) -> None:
    os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
    df2 = df.copy()
    if uppercase_cols:
        df2.columns = [c.upper() for c in df2.columns]
    df2.to_csv(path, index=False, date_format="%Y-%m-%d")


def _write_json(obj: Any, path: str) -> None:
    os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, cls=DecimalEncoder)


def _row_val(row: Any, *keys: str, default: str = "") -> str:
    """Get value from a pandas row with fallback keys (snake_case or UPPER)."""
    for k in keys:
        try:
            if k not in row:
                continue
            v = row[k]
            if pd.isna(v):
                return default
            if hasattr(v, "strftime"):
                return v.strftime("%Y-%m-%d")
            return str(v)
        except (KeyError, TypeError):
            continue
    return default


def format_calendar_month(val: Any) -> Any:
    """Convert YYYYMM calendar month values into standard ARES ISO format."""
    if pd.isna(val):
        return val
    if hasattr(val, "strftime"):
        return val.strftime("%Y-%m-%dT00:00:00Z")
    s = str(val).strip()
    if s.endswith(".0"):
        s = s[:-2]
    if len(s) == 6 and s.isdigit():
        return f"{s[:4]}-{s[4:6]}-01T00:00:00Z"
    if "-" in s:
        if s.endswith("Z") or "T" in s:
            return s
        if len(s) == 10:
            return f"{s}T00:00:00Z"
        return s
    return val


def _write_ares_index(
    output_path: str,
    source_key: str,
    release_date_key: str,
    release_name: str = "",
    cdm_source_row: Any = None,
    count_person: int = 0,
    count_data_quality_checks: int = 0,
    count_data_quality_issues: int = 0,
    dqd_execution_date: str = "",
    dqd_version: str = "",
    obs_period_start: str = "",
    obs_period_end: str = "",
) -> None:
    """Write or merge data/index.json so ARES frontend can list sources/releases."""
    data_dir = os.path.join(output_path, "data")
    index_path = os.path.join(data_dir, "index.json")
    os.makedirs(data_dir, exist_ok=True)

    release_obj: Dict[str, Any] = {
        "release_id": release_date_key,
        "release_name": release_name or release_date_key,
        "cdm_version": _row_val(cdm_source_row, "cdm_version", "CDM_VERSION"),
        "vocabulary_version": _row_val(cdm_source_row, "vocabulary_version", "VOCABULARY_VERSION"),
        "count_data_quality_checks": count_data_quality_checks,
        "count_data_quality_issues": count_data_quality_issues,
        "count_person": count_person,
        "dqd_execution_date": dqd_execution_date,
        "dqd_version": dqd_version,
        "obs_period_start": obs_period_start,
        "obs_period_end": obs_period_end,
    }

    source_obj: Dict[str, Any] = {
        "cdm_source_key": source_key,
        "cdm_source_abbreviation": _row_val(cdm_source_row, "cdm_source_abbreviation", "CDM_SOURCE_ABBREVIATION", default=source_key),
        "cdm_source_name": _row_val(cdm_source_row, "cdm_source_name", "CDM_SOURCE_NAME", default=source_key),
        "cdm_holder": _row_val(cdm_source_row, "cdm_holder", "CDM_HOLDER"),
        "source_description": _row_val(cdm_source_row, "source_description", "SOURCE_DESCRIPTION"),
        "count_releases": 1,
        "releases": [release_obj],
        "average_update_interval_days": "n/a",
    }

    sources: List[Dict[str, Any]] = []
    if os.path.isfile(index_path):
        try:
            with open(index_path, "r", encoding="utf-8") as f:
                data = json.load(f)
                if isinstance(data, dict) and "sources" in data:
                    sources = data["sources"]
                elif isinstance(data, list):
                    sources = data
        except (json.JSONDecodeError, OSError):
            pass

    found = False
    for i, s in enumerate(sources):
        if s.get("cdm_source_key") == source_key:
            rels = [r for r in s.get("releases", []) if r.get("release_id") != release_date_key]
            rels.append(release_obj)
            sources[i] = {**source_obj, "releases": rels, "count_releases": len(rels)}
            found = True
            break
    if not found:
        sources.append(source_obj)

    with open(index_path, "w", encoding="utf-8") as f:
        json.dump({"sources": sources}, f, indent=2, ensure_ascii=False)


def _write_achillesweb_datasources(
    output_path: str,
    source_key: str,
    release_date_key: str,
    cdm_source_row: Any,
) -> None:
    """Write or merge data/datasources.json so AchillesWeb can list data sources."""
    data_dir = os.path.join(output_path, "data")
    datasources_path = os.path.join(data_dir, "datasources.json")
    os.makedirs(data_dir, exist_ok=True)

    folder = f"{source_key}/{release_date_key}"
    name = _row_val(cdm_source_row, "cdm_source_name", "CDM_SOURCE_NAME", default=source_key)
    if name == source_key:
        name = f"{source_key} ({release_date_key})"
    else:
        name = f"{name} ({release_date_key})"
    cdm_ver_str = _row_val(cdm_source_row, "cdm_version", "CDM_VERSION")
    try:
        cdm_version = 5 if cdm_ver_str and str(cdm_ver_str).strip().startswith("5") else 4
    except (TypeError, ValueError):
        cdm_version = 4

    entry: Dict[str, Any] = {
        "name": name,
        "folder": folder,
        "cdmVersion": cdm_version,
    }

    root: Dict[str, List[Dict[str, Any]]] = {"datasources": []}
    if os.path.isfile(datasources_path):
        try:
            with open(datasources_path, "r", encoding="utf-8") as f:
                root = json.load(f)
            if not isinstance(root.get("datasources"), list):
                root["datasources"] = []
        except (json.JSONDecodeError, OSError):
            pass

    found = False
    for i, ds in enumerate(root["datasources"]):
        if ds.get("folder") == folder:
            root["datasources"][i] = entry
            found = True
            break
    if not found:
        root["datasources"].append(entry)

    with open(datasources_path, "w", encoding="utf-8") as f:
        json.dump(root, f, indent=2, ensure_ascii=False)


def _write_dashboard_json(base: str, summary: Dict[str, Any]) -> None:
    """Write dashboard.json for AchillesWeb by merging person + observation period."""
    person_path = os.path.join(base, "person.json")
    op_path = os.path.join(base, "observationperiod.json")
    dashboard_path = os.path.join(base, "dashboard.json")
    out: Dict[str, Any] = {}
    if os.path.isfile(person_path):
        try:
            with open(person_path, "r", encoding="utf-8") as f:
                person = json.load(f)
            out["SUMMARY"] = person.get("SUMMARY", [])
            out["GENDER_DATA"] = person.get("GENDER_DATA", [])
        except (json.JSONDecodeError, OSError) as e:
            click.echo(f"Warning: reading person.json for dashboard: {e}", err=True)
    if os.path.isfile(op_path):
        try:
            with open(op_path, "r", encoding="utf-8") as f:
                op = json.load(f)
            out["AGE_AT_FIRST_OBSERVATION_HISTOGRAM"] = op.get("AGE_AT_FIRST_OBSERVATION_HISTOGRAM")
            out["CUMULATIVE_DURATION"] = op.get("CUMULATIVE_DURATION", [])
            out["OBSERVED_BY_MONTH"] = op.get("OBSERVED_BY_MONTH", [])
        except (json.JSONDecodeError, OSError) as e:
            click.echo(f"Warning: reading observationperiod.json for dashboard: {e}", err=True)
    _write_json(out, dashboard_path)
    summary["files"].append("dashboard.json")


# ---------------------------------------------------------------------------
# SQL Loader (handles stripped paths for compiled dbt analyses)
# ---------------------------------------------------------------------------

def _load_sql(
    base_dir: Optional[str],
    relative_path: str,
    results_database_schema: str,
    cdm_database_schema: str,
    vocab_database_schema: str,
) -> str:
    """Load SQL from file and substitute placeholders.

    Optionally strips 'export/' prefix to read from compiled dbt analyses dir.
    """
    if not base_dir:
        raise FileNotFoundError("SQL base directory not set.")
    
    full_path = Path(base_dir) / relative_path
    
    # Fallback: strip 'export/' prefix if needed (for compiled dbt folders)
    if not full_path.exists() and relative_path.startswith("export/"):
        stripped_path = relative_path[len("export/"):]
        full_path = Path(base_dir) / stripped_path
        
    if not full_path.exists():
        raise FileNotFoundError(f"SQL file not found: {full_path}")
        
    return full_path.read_text(encoding="utf-8")


def _run_sql(engine: Engine, sql: str) -> pd.DataFrame:
    with engine.connect() as conn:
        result = conn.execute(text(sql))
        return pd.DataFrame(result.fetchall(), columns=result.keys())


# ---------------------------------------------------------------------------
# DQD Exporter
# ---------------------------------------------------------------------------

class DqdExporter:
    def __init__(self, engine: Engine):
        self.engine = engine

    def _read_table(self, schema: str, table: str) -> pd.DataFrame:
        fq = f'"{schema}"."{table}"' if schema else f'"{table}"'
        with self.engine.connect() as connection:
            result = connection.execute(text(f"SELECT * FROM {fq}"))
            return pd.DataFrame(result.fetchall(), columns=result.keys())

    @staticmethod
    def _apply_quick_patches(check_results: pd.DataFrame) -> pd.DataFrame:
        df = check_results.copy()
        def empty_to_na(col: str):
            if col in df.columns:
                df.loc[df[col].astype(str) == "", col] = pd.NA
        empty_to_na("error")
        empty_to_na("warning")
        if "executionTime" in df.columns:
            df.loc[df["executionTime"].astype(str) == "", "executionTime"] = "0 secs"
        if "queryText" in df.columns:
            df.loc[df["queryText"].astype(str) == "", "queryText"] = "[Generated via SQL Only]"
        return df

    @staticmethod
    def _rename_checkid_column(check_results: pd.DataFrame) -> pd.DataFrame:
        df = check_results.copy()
        if "checkid" in df.columns and "checkId" not in df.columns:
            df = df.rename(columns={"checkid": "checkId"})
        return df

    @staticmethod
    def _df_to_records(df: pd.DataFrame) -> List[Dict[str, Any]]:
        df2 = df.replace([np.nan, pd.NA], None)
        df2 = df2.where(pd.notnull(df2), None)
        for col in df2.columns:
            if df2[col].dtype == 'object':
                sample = df2[col].dropna()
                if len(sample) > 0:
                    first_val = sample.iloc[0]
                    if isinstance(first_val, Decimal):
                        df2[col] = df2[col].apply(lambda x: float(x) if isinstance(x, Decimal) else x)
                    elif isinstance(first_val, (date, datetime)):
                        df2[col] = df2[col].apply(lambda x: x.isoformat() if isinstance(x, (date, datetime)) else x)
            elif df2[col].dtype in ['float64', 'float32']:
                df2[col] = df2[col].replace([np.nan, np.inf, -np.inf], None)
        records = df2.to_dict(orient="records")
        return [{k: (None if (isinstance(v, float) and (math.isnan(v) or math.isinf(v))) else v) 
                for k, v in record.items()} for record in records]

    @staticmethod
    def _df_to_single_record(df: pd.DataFrame) -> Dict[str, Any]:
        if len(df) == 0:
            return {}
        df2 = df.iloc[[0]].replace([np.nan, pd.NA], None)
        df2 = df2.where(pd.notnull(df2), None)
        for col in df2.columns:
            if df2[col].dtype in ['float64', 'float32']:
                df2[col] = df2[col].replace([np.nan, np.inf, -np.inf], None)
        record = df2.to_dict(orient="records")[0]
        return {k: (None if (isinstance(v, float) and (math.isnan(v) or math.isinf(v))) else v) 
                for k, v in record.items()}

    @staticmethod
    def summarize_results(check_results: pd.DataFrame) -> Dict[str, Any]:
        def _col(name: str, default):
            return check_results[name] if name in check_results.columns else default

        n = len(check_results)
        failed = _col("failed", pd.Series([0] * n))
        passed = _col("passed", pd.Series([0] * n))
        category = _col("category", pd.Series([""] * n))
        error = _col("error", pd.Series([None] * n))

        count_total = int(n)
        count_threshold_failed = int(((failed == 1) & (error.isna())).sum())
        count_error_failed = int((~error.isna()).sum())
        count_overall_failed = int((failed == 1).sum())
        count_passed = int(count_total - count_overall_failed)

        count_total_plausibility = int((category == "Plausibility").sum())
        count_total_conformance = int((category == "Conformance").sum())
        count_total_completeness = int((category == "Completeness").sum())

        count_failed_plausibility = int(((category == "Plausibility") & (failed == 1)).sum())
        count_failed_conformance = int(((category == "Conformance") & (failed == 1)).sum())
        count_failed_completeness = int(((category == "Completeness") & (failed == 1)).sum())

        count_passed_plausibility = int(((category == "Plausibility") & (passed == 1)).sum())
        count_passed_conformance = int(((category == "Conformance") & (passed == 1)).sum())
        count_passed_completeness = int(((category == "Completeness") & (passed == 1)).sum())

        denom = count_passed + count_overall_failed
        percent_passed = round((count_passed / denom) * 100, 2) if denom else 0.0
        percent_failed = round((count_overall_failed / denom) * 100, 2) if denom else 0.0

        return {
            "countTotal": count_total,
            "countPassed": count_passed,
            "countErrorFailed": count_error_failed,
            "countThresholdFailed": count_threshold_failed,
            "countOverallFailed": count_overall_failed,
            "percentPassed": percent_passed,
            "percentFailed": percent_failed,
            "countTotalPlausibility": count_total_plausibility,
            "countTotalConformance": count_total_conformance,
            "countTotalCompleteness": count_total_completeness,
            "countFailedPlausibility": count_failed_plausibility,
            "countFailedConformance": count_failed_conformance,
            "countFailedCompleteness": count_failed_completeness,
            "countPassedPlausibility": count_passed_plausibility,
            "countPassedConformance": count_passed_conformance,
            "countPassedCompleteness": count_passed_completeness,
        }

    def export(
        self,
        results_database_schema: str,
        cdm_database_schema: str,
        write_table_name: str,
        output_file_path: str,
    ) -> None:
        """Export DQD database results to ARES dq-result.json format."""
        metadata = self._read_table(cdm_database_schema, "cdm_source")
        if len(metadata) < 1:
            raise ValueError("cdm_source is empty; populate it before exporting.")
        if len(metadata) > 1:
            metadata = metadata.iloc[[0]]
            
        # Rename to camelCase to match DQD expected keys
        metadata = df_snake_to_camel(metadata)

        check_results = self._read_table(results_database_schema, write_table_name)
        check_results = df_snake_to_camel(check_results)
        check_results = self._apply_quick_patches(check_results)
        overview = self.summarize_results(check_results)
        check_results = self._rename_checkid_column(check_results)
        metadata_dict = self._df_to_single_record(metadata)

        all_results: Dict[str, Any] = {
            "startTimestamp": datetime.now(timezone.utc).isoformat(),
            "endTimestamp": datetime.now(timezone.utc).isoformat(),
            "executionTime": "0 secs",
            "CheckResults": self._df_to_records(check_results),
            "Metadata": [metadata_dict],
            "Overview": overview,
        }

        os.makedirs(os.path.dirname(output_file_path), exist_ok=True)
        if os.path.exists(output_file_path):
            os.remove(output_file_path)

        with open(output_file_path, "w", encoding="utf-8") as f:
            json.dump(all_results, f, ensure_ascii=False, cls=DecimalEncoder)


# ---------------------------------------------------------------------------
# Achilles Exporter
# ---------------------------------------------------------------------------

class AchillesAresExporter:
    def __init__(self, engine: Engine, achilles_sql_dir: Optional[str] = None):
        self.engine = engine
        self.achilles_sql_dir = achilles_sql_dir

    def _run(self, sql: str) -> pd.DataFrame:
        return _run_sql(self.engine, sql)

    def export(
        self,
        cdm_database_schema: str,
        results_database_schema: str,
        vocab_database_schema: str,
        output_path: str,
        source_key: str,
        release_date_key: str,
        release_name: str,
        cdm_source_row: Any,
        dq_result_file: Optional[str] = None,
    ) -> Dict[str, Any]:
        source_output_path = os.path.join(output_path, "data", source_key, release_date_key)
        os.makedirs(source_output_path, exist_ok=True)

        summary: Dict[str, Any] = {"outputPath": output_path, "dataPath": source_output_path, "files": []}

        # ---- Density ----
        self._export_density(source_output_path, results_database_schema, summary)

        # ---- Metadata ----
        self._export_metadata_and_domain(
            source_output_path,
            cdm_database_schema,
            results_database_schema,
            vocab_database_schema,
            summary,
        )

        # ---- Person, observation period & death (JSON) ----
        self._export_person(
            source_output_path,
            results_database_schema,
            cdm_database_schema,
            vocab_database_schema,
            summary,
            cdm_source_row=cdm_source_row,
        )
        self._export_observation_period(
            source_output_path,
            results_database_schema,
            cdm_database_schema,
            vocab_database_schema,
            summary,
        )
        _write_dashboard_json(source_output_path, summary)
        self._export_death(
            source_output_path,
            results_database_schema,
            vocab_database_schema,
            summary,
        )
        self._export_location(source_output_path, results_database_schema, summary)

        # ---- Domain summaries (CSV) ----
        self._export_domain_summaries(
            source_output_path,
            results_database_schema,
            vocab_database_schema,
            summary,
        )

        # ---- Provider (always) ----
        self._export_provider(source_output_path, results_database_schema, vocab_database_schema, summary)

        # ---- Cohorts (always) ----
        self._export_cohorts(source_output_path, cdm_database_schema, summary)

        # ---- Quality ----
        self._export_quality(source_output_path, results_database_schema, summary)

        # ---- Performance ----
        self._export_performance(
            source_output_path,
            cdm_database_schema,
            results_database_schema,
            vocab_database_schema,
            summary,
        )

        # Count persons
        count_person = 0
        try:
            person_df = self._run(
                f'SELECT count_value FROM "{results_database_schema}".achilles_results WHERE analysis_id = 1 LIMIT 1'
            )
            if not person_df.empty:
                count_person = int(person_df.iloc[0].get("count_value", 0))
        except Exception as e:
            click.echo(f"Warning: could not fetch person count: {e}", err=True)

        obs_period_start = ""
        obs_period_end = ""
        try:
            obs_df = self._run(
                f'SELECT MIN(observation_period_start_date) as start_date, MAX(observation_period_end_date) as end_date FROM "{cdm_database_schema}".observation_period'
            )
            if not obs_df.empty:
                s_date = obs_df.iloc[0].get("start_date")
                e_date = obs_df.iloc[0].get("end_date")
                if s_date:
                    obs_period_start = pd.Timestamp(s_date).strftime("%Y-%m")
                if e_date:
                    obs_period_end = pd.Timestamp(e_date).strftime("%Y-%m")
        except Exception as e:
            click.echo(f"Warning: could not fetch observation period dates: {e}", err=True)

        # Parse DQD outputs for ARES index and domain-issues.csv
        count_dq_checks = 0
        count_dq_issues = 0
        dq_exec_date = ""
        dq_version = ""
        
        target_dqd_path = os.path.join(source_output_path, "dq-result.json")
        if dq_result_file and os.path.isfile(dq_result_file):
            if os.path.abspath(dq_result_file) != os.path.abspath(target_dqd_path):
                try:
                    shutil.copyfile(dq_result_file, target_dqd_path)
                    summary["files"].append("dq-result.json")
                except Exception as e:
                    click.echo(f"Warning: copying dq-result.json: {e}", err=True)

        if os.path.isfile(target_dqd_path):
            try:
                with open(target_dqd_path, "r", encoding="utf-8") as f:
                    dqd_data = json.load(f)
                    metadata = dqd_data.get("Metadata") or dqd_data.get("metadata")
                    if metadata and isinstance(metadata, list) and len(metadata) > 0:
                        m_row = metadata[0]
                        dq_version = m_row.get("Version") or m_row.get("version") or ""
                        dq_exec_date = m_row.get("ExecutionDate") or m_row.get("executionDate") or ""
                    elif isinstance(metadata, dict):
                        dq_version = metadata.get("Version") or metadata.get("version") or ""
                        dq_exec_date = metadata.get("ExecutionDate") or metadata.get("executionDate") or ""
                    
                    results = dqd_data.get("CheckResults") or dqd_data.get("checkResults")
                    if isinstance(results, list):
                        count_dq_checks = len(results)
                        
                        def is_failed(r):
                            val = r.get("FAILED")
                            if val is None:
                                val = r.get("failed")
                            if isinstance(val, bool):
                                return val
                            return str(val) == "1"
                            
                        count_dq_issues = sum(1 for r in results if is_failed(r))
                        
                        failed_by_table = {}
                        for r in results:
                            if is_failed(r):
                                table = str(r.get("cdmTableName") or r.get("CDM_TABLE_NAME") or "").lower()
                                if table:
                                    failed_by_table[table] = failed_by_table.get(table, 0) + 1
                        
                        df_issues = pd.DataFrame(
                            [{"cdm_table_name": k, "count_failed": v} for k, v in failed_by_table.items()]
                        )
                        if df_issues.empty:
                            df_issues = pd.DataFrame(columns=["cdm_table_name", "count_failed"])
                        _write_csv(df_issues, os.path.join(source_output_path, "domain-issues.csv"), uppercase_cols=False)
                        summary["files"].append("domain-issues.csv")
            except Exception as e:
                click.echo(f"Warning: generating domain-issues.csv: {e}", err=True)

        _write_ares_index(
            output_path=output_path,
            source_key=source_key,
            release_date_key=release_date_key,
            release_name=release_name,
            cdm_source_row=cdm_source_row,
            count_person=count_person,
            count_data_quality_checks=count_dq_checks,
            count_data_quality_issues=count_dq_issues,
            dqd_execution_date=dq_exec_date,
            dqd_version=dq_version,
            obs_period_start=obs_period_start,
            obs_period_end=obs_period_end,
        )

        _write_achillesweb_datasources(
            output_path=output_path,
            source_key=source_key,
            release_date_key=release_date_key,
            cdm_source_row=cdm_source_row,
        )

        return summary

    def _export_density(self, base: str, results_schema: str, summary: Dict[str, Any]) -> None:
        try:
            sql = _load_sql(self.achilles_sql_dir, "export/datadensity/datadensity_totalrecords.sql", results_schema, "", "")
            df = self._run(sql)
            if not df.empty:
                df.columns = [c.upper() for c in df.columns]
                df = df.rename(columns={"SERIES_NAME": "domain", "X_CALENDAR_MONTH": "date", "Y_RECORD_COUNT": "records"})
                if "date" in df.columns:
                    df["date"] = df["date"].apply(format_calendar_month)
                _write_csv(df, os.path.join(base, "datadensity-total.csv"), uppercase_cols=False)
                
                agg = df.groupby("domain", as_index=False)["records"].sum()
                agg.columns = ["domain", "count_records"]
                _write_csv(agg, os.path.join(base, "records-by-domain.csv"), uppercase_cols=False)
                summary["files"].extend(["datadensity-total.csv", "records-by-domain.csv"])
        except Exception as e:
            click.echo(f"Warning: density total: {e}", err=True)

        for rel_path, out_name in [
            ("export/datadensity/datadensity_recordsperperson.sql", "datadensity-records-per-person.csv"),
            ("export/datadensity/datadensity_conceptsperperson.sql", "datadensity-concepts-per-person.csv"),
            ("export/datadensity/datadensity_domainsperperson.sql", "datadensity-domains-per-person.csv"),
        ]:
            try:
                sql = _load_sql(self.achilles_sql_dir, rel_path, results_schema, "", "")
                df = self._run(sql)
                if out_name == "datadensity-records-per-person.csv":
                    df.columns = [c.upper() for c in df.columns]
                    df = df.rename(columns={"SERIES_NAME": "domain", "X_CALENDAR_MONTH": "date", "Y_RECORD_COUNT": "records"})
                    if "date" in df.columns:
                        df["date"] = df["date"].apply(format_calendar_month)
                    _write_csv(df, os.path.join(base, out_name), uppercase_cols=False)
                else:
                    _write_csv(df, os.path.join(base, out_name), uppercase_cols=True)
                summary["files"].append(out_name)
            except Exception as e:
                click.echo(f"Warning: density {out_name}: {e}", err=True)

    def _export_metadata_and_domain(
        self,
        base: str,
        cdm_schema: str,
        results_schema: str,
        vocab_schema: str,
        summary: Dict[str, Any],
    ) -> None:
        try:
            meta = self._run(f'SELECT * FROM "{cdm_schema}".metadata')
            if not meta.empty:
                _write_csv(meta, os.path.join(base, "metadata.csv"), uppercase_cols=True)
                summary["files"].append("metadata.csv")
        except Exception as e:
            click.echo(f"Warning: metadata: {e}", err=True)
        try:
            cdm = self._run(f'SELECT * FROM "{cdm_schema}".cdm_source')
            if not cdm.empty:
                _write_csv(cdm, os.path.join(base, "cdmsource.csv"), uppercase_cols=True)
                summary["files"].append("cdmsource.csv")
        except Exception as e:
            click.echo(f"Warning: cdm_source: {e}", err=True)

    def _export_person(
        self,
        base: str,
        results_schema: str,
        cdm_schema: str,
        vocab_schema: str,
        summary: Dict[str, Any],
        cdm_source_row: Any = None,
    ) -> None:
        out = {"SUMMARY": [], "AGE_GENDER_DATA": [], "GENDER_DATA": [], "RACE_DATA": [], "ETHNICITY_DATA": [], "BIRTH_YEAR_DATA": []}
        try:
            sql = _load_sql(self.achilles_sql_dir, "export/person/person_population.sql", results_schema, cdm_schema, vocab_schema)
            summary_data = _df_to_json_serializable(self._run(sql))
            if cdm_source_row is not None:
                src_name = _row_val(cdm_source_row, "cdm_source_name", "CDM_SOURCE_NAME")
                for item in summary_data:
                    if item.get("ATTRIBUTE_NAME") == "Source name" and not item.get("ATTRIBUTE_VALUE"):
                        item["ATTRIBUTE_VALUE"] = src_name
            out["SUMMARY"] = summary_data
        except Exception as e:
            click.echo(f"Warning: person population: {e}", err=True)
        
        for key, rel in [
            ("GENDER_DATA", "export/person/person_gender.sql"),
            ("AGE_GENDER_DATA", "export/person/person_population_age_gender.sql"),
            ("RACE_DATA", "export/person/person_race.sql"),
            ("ETHNICITY_DATA", "export/person/person_ethnicity.sql"),
            ("BIRTH_YEAR_DATA", "export/person/person_yearofbirth.sql"),
        ]:
            try:
                sql = _load_sql(self.achilles_sql_dir, rel, results_schema, cdm_schema, vocab_schema)
                out[key] = _df_to_json_serializable(self._run(sql))
            except Exception as e:
                click.echo(f"Warning: person {key}: {e}", err=True)

        _write_json(out, os.path.join(base, "person.json"))
        summary["files"].append("person.json")

    def _export_observation_period(
        self,
        base: str,
        results_schema: str,
        cdm_schema: str,
        vocab_schema: str,
        summary: Dict[str, Any],
    ) -> None:
        out = {}
        try:
            sql = _load_sql(self.achilles_sql_dir, "export/observationperiod/observationperiod_ageatfirst.sql", results_schema, cdm_schema, vocab_schema)
            age_at_first = _df_to_json_serializable(self._run(sql))
            out["AGE_AT_FIRST_OBSERVATION"] = age_at_first
            out["AGE_AT_FIRST_OBSERVATION_HISTOGRAM"] = {
                "MIN": 0, "MAX": 100, "INTERVAL_SIZE": 1, "INTERVALS": 100, "DATA": age_at_first
            }
        except Exception as e:
            click.echo(f"Warning: op ageatfirst: {e}", err=True)

        try:
            sql = _load_sql(self.achilles_sql_dir, "export/observationperiod/observationperiod_agebygender.sql", results_schema, cdm_schema, vocab_schema)
            out["AGE_BY_GENDER"] = _df_to_json_serializable(self._run(sql))
        except Exception as e:
            click.echo(f"Warning: op agebygender: {e}", err=True)

        try:
            sql_stats = _load_sql(self.achilles_sql_dir, "export/observationperiod/observationperiod_observationlength_stats.sql", results_schema, cdm_schema, vocab_schema)
            stats = self._run(sql_stats)
            if not stats.empty:
                r0 = stats.iloc[0]
                min_v = r0.get("min_value", r0.get("MIN_VALUE"))
                max_v = r0.get("max_value", r0.get("MAX_VALUE"))
                int_sz = r0.get("interval_size", r0.get("INTERVAL_SIZE"))
                hist = {
                    "MIN": float(min_v) if min_v is not None else None,
                    "MAX": float(max_v) if max_v is not None else None,
                    "INTERVAL_SIZE": int(int_sz) if int_sz is not None else None,
                }
                if min_v is not None and max_v is not None and int_sz and int(int_sz) != 0:
                    hist["INTERVALS"] = (float(max_v) - float(min_v)) / float(int_sz)
                sql_data = _load_sql(self.achilles_sql_dir, "export/observationperiod/observationperiod_observationlength_data.sql", results_schema, cdm_schema, vocab_schema)
                hist["DATA"] = _df_to_json_serializable(self._run(sql_data))
                out["OBSERVATION_LENGTH_HISTOGRAM"] = hist
        except Exception as e:
            click.echo(f"Warning: op length: {e}", err=True)

        try:
            sql = _load_sql(self.achilles_sql_dir, "export/observationperiod/observationperiod_cumulativeduration.sql", results_schema, cdm_schema, vocab_schema)
            cum = self._run(sql)
            if not cum.empty and "x_length_of_observation" in cum.columns:
                cum = cum.copy()
                cum["x_length_of_observation"] = cum["x_length_of_observation"] / 365.25
                cum = cum.rename(columns={"x_length_of_observation": "YEARS"})
                if "y_percent_persons" in cum.columns:
                    cum = cum.rename(columns={"y_percent_persons": "PERCENT_PEOPLE"})
                cum = cum.drop(columns=[c for c in cum.columns if c == "series_name"], errors="ignore")
                out["CUMULATIVE_DURATION"] = _df_to_json_serializable(cum)
        except Exception as e:
            click.echo(f"Warning: op cumulativeduration: {e}", err=True)

        try:
            sql = _load_sql(self.achilles_sql_dir, "export/observationperiod/observationperiod_observedbymonth.sql", results_schema, cdm_schema, vocab_schema)
            out["OBSERVED_BY_MONTH"] = _df_to_json_serializable(self._run(sql))
        except Exception as e:
            click.echo(f"Warning: op observedbymonth: {e}", err=True)

        _write_json(out, os.path.join(base, "observationperiod.json"))
        summary["files"].append("observationperiod.json")

    def _export_death(self, base: str, results_schema: str, vocab_schema: str, summary: Dict[str, Any]) -> None:
        out = {}
        for key, rel in [
            ("PREVALENCE_BY_GENDER_AGE_YEAR", "export/death/death_sql_prevalence_by_gender_age_year.sql"),
            ("PREVALENCE_BY_MONTH", "export/death/death_sql_prevalence_by_month.sql"),
            ("DEATH_BY_TYPE", "export/death/death_sql_death_by_type.sql"),
            ("AGE_AT_DEATH", "export/death/death_sql_age_at_death.sql"),
        ]:
            try:
                sql = _load_sql(self.achilles_sql_dir, rel, results_schema, "", vocab_schema)
                out[key] = _df_to_json_serializable(self._run(sql))
            except Exception as e:
                click.echo(f"Warning: death {key}: {e}", err=True)
        _write_json(out, os.path.join(base, "death.json"))
        summary["files"].append("death.json")

    def _export_location(self, base: str, results_schema: str, summary: Dict[str, Any]) -> None:
        try:
            sql = _load_sql(self.achilles_sql_dir, "export/location/location_sql_location_table.sql", results_schema, "", "")
            df = self._run(sql)
            _write_csv(df, os.path.join(base, "location.csv"), uppercase_cols=True)
            summary["files"].append("location.csv")
        except Exception as e:
            click.echo(f"Warning: location: {e}", err=True)

    def _export_domain_summaries(
        self,
        base: str,
        results_schema: str,
        vocab_schema: str,
        summary: Dict[str, Any],
    ) -> None:
        domain_sql = [
            ("domain-summary-condition_occurrence.csv", "export/condition/condition_sql_condition_table.sql"),
            ("domain-summary-condition_era.csv", "export/conditionera/conditionera_sql_condition_era_table.sql"),
            ("domain-summary-drug_exposure.csv", "export/drug/drug_sql_drug_table.sql"),
            ("domain-drug-stratification.csv", "export/drug/drug_sql_domain_drug_stratification.sql"),
            ("domain-summary-drug_era.csv", "export/drugera/drugera_sql_drug_era_table.sql"),
            ("domain-summary-measurement.csv", "export/measurement/measurement_sql_measurement_table.sql"),
            ("domain-summary-observation.csv", "export/observation/observation_sql_observation_table.sql"),
            ("domain-summary-visit_detail.csv", "export/visitdetail/visitdetail_sql_visit_detail_treemap.sql"),
            ("domain-summary-visit_occurrence.csv", "export/visit/visit_sql_visit_treemap.sql"),
            ("domain-visit-stratification.csv", "export/visit/visit_sql_domain_visit_stratification.sql"),
            ("domain-summary-procedure_occurrence.csv", "export/procedure/procedure_sql_procedure_table.sql"),
            ("domain-summary-device_exposure.csv", "export/device/device_sql_device_table.sql"),
        ]
        for out_name, rel_path in domain_sql:
            try:
                sql = _load_sql(self.achilles_sql_dir, rel_path, results_schema, "", vocab_schema)
                df = self._run(sql)
                
                df.columns = [c.upper() for c in df.columns]
                if "CONCEPT_PATH" in df.columns:
                    df = df.rename(columns={"CONCEPT_PATH": "CONCEPT_NAME"})
                    
                if out_name.startswith("domain-summary-") and out_name != "domain-summary-provider.csv":
                    if not df.empty:
                        if "PERCENT_PERSONS" in df.columns:
                            df["PERCENT_PERSONS"] = df["PERCENT_PERSONS"].astype(float).round(4)
                            r_pct = df["PERCENT_PERSONS"].rank(method='first', ascending=False)
                            df["PERCENT_PERSONS_NTILE"] = (10 * (r_pct - 1) / len(df)).apply(math.floor) + 1
                        if "RECORDS_PER_PERSON" in df.columns:
                            df["RECORDS_PER_PERSON"] = df["RECORDS_PER_PERSON"].astype(float).round(1)
                            r_rec = df["RECORDS_PER_PERSON"].rank(method='first', ascending=False)
                            df["RECORDS_PER_PERSON_NTILE"] = (10 * (r_rec - 1) / len(df)).apply(math.floor) + 1
                    else:
                        df["PERCENT_PERSONS_NTILE"] = pd.Series(dtype='int')
                        df["RECORDS_PER_PERSON_NTILE"] = pd.Series(dtype='int')
                        
                _write_csv(df, os.path.join(base, out_name), uppercase_cols=False)
                summary["files"].append(out_name)
            except Exception as e:
                click.echo(f"Warning: domain {out_name}: {e}", err=True)

    def _export_provider(self, base: str, results_schema: str, vocab_schema: str, summary: Dict[str, Any]) -> None:
        try:
            sql = _load_sql(self.achilles_sql_dir, "export/provider/provider_sql_provider_specialty.sql", results_schema, "", vocab_schema)
            df = self._run(sql)
            if not df.empty and "PERCENT_PERSONS" in df.columns:
                df["PERCENT_PERSONS"] = df["PERCENT_PERSONS"].astype(float).round(4)
            _write_csv(df, os.path.join(base, "domain-summary-provider.csv"), uppercase_cols=True)
            summary["files"].append("domain-summary-provider.csv")
        except Exception as e:
            click.echo(f"Warning: provider: {e}", err=True)

    def _export_cohorts(self, base: str, cdm_schema: str, summary: Dict[str, Any]) -> None:
        df = pd.DataFrame(columns=["cohort_id", "cohort_name", "cohort_subjects"])
        try:
            sql = f"""
                SELECT 
                  cd.cohort_definition_id AS cohort_id,
                  cd.cohort_definition_name AS cohort_name,
                  COUNT(DISTINCT c.subject_id) AS cohort_subjects
                FROM "{cdm_schema}".cohort_definition cd
                LEFT JOIN "{cdm_schema}".cohort c ON cd.cohort_definition_id = c.cohort_definition_id
                GROUP BY cd.cohort_definition_id, cd.cohort_definition_name
            """
            df_db = self._run(sql)
            if not df_db.empty:
                df = df_db
                df.columns = [c.lower() for c in df.columns]
        except Exception:
            pass
        _write_csv(df, os.path.join(base, "cohort_index.csv"), uppercase_cols=False)
        summary["files"].append("cohort_index.csv")

    def _export_quality(self, base: str, results_schema: str, summary: Dict[str, Any]) -> None:
        try:
            sql = _load_sql(self.achilles_sql_dir, "export/quality/quality_sql_completeness_table.sql", results_schema, "", "")
            df = self._run(sql)
            if len(df) > 100000:
                df = df.head(100000)
            _write_csv(df, os.path.join(base, "quality-completeness.csv"), uppercase_cols=True)
            summary["files"].append("quality-completeness.csv")
        except Exception as e:
            click.echo(f"Warning: quality: {e}", err=True)

    def _export_performance(
        self,
        base: str,
        cdm_schema: str,
        results_schema: str,
        vocab_schema: str,
        summary: Dict[str, Any],
    ) -> None:
        try:
            sql = _load_sql(self.achilles_sql_dir, "export/performance/performance_sql_achilles_performance.sql", results_schema, cdm_schema, vocab_schema)
            df = self._run(sql)
            _write_csv(df, os.path.join(base, "achilles-performance.csv"), uppercase_cols=True)
            summary["files"].append("achilles-performance.csv")
        except Exception as e:
            err_msg = str(e).lower()
            if "achilles_performance" in err_msg and ("does not exist" in err_msg or "undefinedtable" in err_msg):
                click.echo("Warning: achilles performance skipped (results.achilles_performance not present).", err=True)
            else:
                click.echo(f"Warning: achilles performance: {e}", err=True)


# ---------------------------------------------------------------------------
# static files copy tree helper
# ---------------------------------------------------------------------------

def copy_ares_frontend(src: str, dest: str) -> None:
    """Safely copy the static ARES web assets to target/ares/, preserving existing data."""
    os.makedirs(dest, exist_ok=True)
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dest, item)
        if os.path.isdir(s):
            if item == "data":
                continue  # skip copying the local release data directory to prevent overwriting
            if os.path.exists(d):
                shutil.rmtree(d)
            shutil.copytree(s, d)
        else:
            shutil.copy2(s, d)


# ---------------------------------------------------------------------------
# CLI Command
# ---------------------------------------------------------------------------

@click.command()
@click.option("--project-dir", "project_dir_opt", default=None, help="Root folder of the dbt project")
@click.option("--profiles-dir", "profiles_dir_opt", default=None, help="Directory containing profiles.yml")
@click.option("--target", "target_opt", default=None, help="dbt target override")
@click.option("--results-schema", "results_schema_opt", default=None, help="Results schema name override")
@click.option("--cdm-schema", "cdm_schema_opt", default=None, help="CDM schema name override")
@click.option("--vocab-schema", "vocab_schema_opt", default=None, help="Vocabulary schema name override")
@click.option("--dqd-table", default="dqdashboard_results", help="Name of the DQD results table")
@click.option("--skip-dqd", is_flag=True, help="Skip DQD results export")
@click.option("--skip-achilles", is_flag=True, help="Skip Achilles export")
@click.option("--host", "host_opt", default=None, help="Database host override")
@click.option("--port", "port_opt", default=None, type=int, help="Database port override")
@click.option("--user", "user_opt", default=None, help="Database user override")
@click.option("--password", "password_opt", default=None, help="Database password override")
@click.option("--database", "database_opt", default=None, help="Database name override")
@click.option("--output-path", "output_path", default=None, help="Output path override")
def main(
    project_dir_opt: Optional[str],
    profiles_dir_opt: Optional[str],
    target_opt: Optional[str],
    results_schema_opt: Optional[str],
    cdm_schema_opt: Optional[str],
    vocab_schema_opt: Optional[str],
    dqd_table: str,
    skip_dqd: bool,
    skip_achilles: bool,
    host_opt: Optional[str],
    port_opt: Optional[int],
    user_opt: Optional[str],
    password_opt: Optional[str],
    database_opt: Optional[str],
    output_path: Optional[str],
) -> None:
    # 1. Resolve Project Root
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = project_dir_opt or os.path.abspath(os.path.join(script_dir, ".."))
    
    print(f"Initializing export process. Project Root: {project_root}")
    
    # 2. Load DB Connection Details from dbt configurations
    try:
        creds = load_db_credentials(project_root, target_override=target_opt)
    except Exception as e:
        click.echo(f"Error loading dbt credentials: {e}", err=True)
        sys.exit(1)
        
    project_name = creds["project_name"]
    
    # Override credentials if explicitly passed via CLI
    host = host_opt or creds["host"]
    port = port_opt or creds["port"]
    user = user_opt or creds["user"]
    password = password_opt or creds["password"]
    dbname = database_opt or creds["dbname"]
    dialect = creds["dialect"]
    
    # 3. Resolve Schemas
    cdm_schema, results_schema, vocab_schema = resolve_schemas(project_root, project_name)
    cdm_schema = cdm_schema_opt or cdm_schema
    results_schema = results_schema_opt or results_schema
    vocab_schema = vocab_schema_opt or vocab_schema

    print(f"Target connection details resolved:")
    print(f"  Database: {host}:{port}/{dbname}")
    print(f"  Profile: {creds['profile_name']}, Target: {creds['target_name']}")
    print(f"  Schemas: CDM='{cdm_schema}', Results='{results_schema}', Vocab='{vocab_schema}'")

    # Setup database engine
    drivername = f"{dialect}+psycopg2" if dialect == "postgresql" else dialect
    url = URL.create(
        drivername=drivername,
        username=user,
        password=password,
        host=host,
        port=port,
        database=dbname,
    )
    engine = sqlalchemy.create_engine(url)

    # Resolve source abbreviation and date from cdm_source
    try:
        cdm_source_df = _run_sql(engine, f'SELECT * FROM "{cdm_schema}".cdm_source LIMIT 1')
        if cdm_source_df.empty:
            raise ValueError(f"cdm_source table in '{cdm_schema}' schema is empty; populate it first.")
        row = cdm_source_df.iloc[0]
        source_key = str(row.get("cdm_source_abbreviation", row.get("CDM_SOURCE_ABBREVIATION", "source"))).replace(" ", "_")
        release_val = row.get("cdm_release_date", row.get("CDM_RELEASE_DATE"))
        if hasattr(release_val, "strftime"):
            release_date_key = release_val.strftime("%Y%m%d")
            release_name = release_val.strftime("%Y-%m-%d")
        else:
            release_date_key = pd.Timestamp(release_val).strftime("%Y%m%d")
            release_name = pd.Timestamp(release_val).strftime("%Y-%m-%d")
    except Exception as e:
        click.echo(f"Error querying cdm_source table: {e}", err=True)
        sys.exit(1)

    print(f"Target ARES release key: {source_key}/{release_date_key} (Release Name: {release_name})")

    # Setup directories
    ares_dest = output_path or os.path.join(project_root, "target", "ares")
    ares_src = os.path.join(script_dir, "ares")
    
    if os.path.exists(ares_src):
        print(f"Copying static frontend assets to {ares_dest}...")
        copy_ares_frontend(ares_src, ares_dest)
    else:
        print(f"Warning: Static ARES web directory not found at {ares_src}. Web layout will not be copied.")

    release_data_dir = os.path.join(ares_dest, "data", source_key, release_date_key)
    os.makedirs(release_data_dir, exist_ok=True)
    
    dqd_result_file = os.path.join(release_data_dir, "dq-result.json")

    # 4. Run DQD Export if requested
    if not skip_dqd:
        print("Exporting DQD results...")
        try:
            dqd_exporter = DqdExporter(engine)
            dqd_exporter.export(
                results_database_schema=results_schema,
                cdm_database_schema=cdm_schema,
                write_table_name=dqd_table,
                output_file_path=dqd_result_file,
            )
            print(f"Successfully exported DQD JSON results to {dqd_result_file}")
        except Exception as e:
            click.echo(f"Warning: DQD export failed: {e}. Check if DQD results table exists.", err=True)
            dqd_result_file = None
    else:
        print("Skipping DQD export.")
        dqd_result_file = None

    # 5. Run Achilles Export if requested
    if not skip_achilles:
        print("Exporting Achilles statistics...")
        achilles_sql_dir = os.path.join(project_root, "target", "compiled", project_name, "analyses", "achilles")
        if not os.path.exists(achilles_sql_dir):
            click.echo(
                f"Error: Compiled Achilles SQL folder not found at: {achilles_sql_dir}. "
                "Please run 'dbt compile' first to compile the analyses SQL scripts.",
                err=True
            )
            sys.exit(1)

        try:
            achilles_exporter = AchillesAresExporter(engine, achilles_sql_dir=achilles_sql_dir)
            summary = achilles_exporter.export(
                cdm_database_schema=cdm_schema,
                results_database_schema=results_schema,
                vocab_database_schema=vocab_schema,
                output_path=ares_dest,
                source_key=source_key,
                release_date_key=release_date_key,
                release_name=release_name,
                cdm_source_row=row,
                dq_result_file=dqd_result_file,
            )
            print(f"Successfully exported Achilles statistics. Summary:\n{json.dumps(summary, indent=2)}")

        except Exception as e:
            click.echo(f"Error executing Achilles statistics export: {e}", err=True)
            sys.exit(1)

    else:
        print("Skipping Achilles export.")

    # Create zip file with everything under ares_dest

    zip_name = 'ares-data.zip'
    print(f"\nCreating zip archive: {zip_name}")

    with zipfile.ZipFile(zip_name, "w", compression=zipfile.ZIP_DEFLATED) as zf:

        for root, dirs, files in os.walk(ares_dest):

            for filename in files:

                file_path = os.path.join(root, filename)

                # Preserve directory structure relative to ares_dest

                archive_path = os.path.relpath(file_path, ares_dest)

                zf.write(file_path, archive_path)

                print(f"  Added {archive_path} to archive")

if __name__ == "__main__":
    main()
