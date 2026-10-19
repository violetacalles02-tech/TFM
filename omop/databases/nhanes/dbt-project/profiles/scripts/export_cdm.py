#!/usr/bin/env python3
"""
Export all tables from the CDM schema to CSV files and zip them.
Reads connection details from dbt profiles.yml file.
"""
import os
import sys
import yaml
import zipfile
import datetime
import tempfile
import psycopg2
from pathlib import Path

def load_dbt_profile(profiles_path="../profiles/profiles.yml", profile_name="yemaachi_taca1", target_name="yemaachi_taca1"):
    """Load and parse dbt profile, resolving environment variables."""
    profiles_path = Path(profiles_path)
    
    if not profiles_path.exists():
        raise FileNotFoundError(f"Profiles file not found: {profiles_path}")
    
    with open(profiles_path, 'r') as f:
        profiles = yaml.safe_load(f)
    
    if profile_name not in profiles:
        raise ValueError(f"Profile '{profile_name}' not found in profiles.yml")
    
    profile = profiles[profile_name]
    target = profile.get('target', target_name)
    
    if 'outputs' not in profile or target not in profile['outputs']:
        raise ValueError(f"Target '{target}' not found in profile '{profile_name}'")
    
    output = profile['outputs'][target]
    
    # Resolve environment variables in the profile
    def resolve_env_var(value):
        """Resolve dbt-style env_var() calls."""
        if isinstance(value, str) and 'env_var' in value:
            # Simple parsing for {% raw %}{{ env_var('VAR_NAME') }} or {{ env_var('VAR_NAME') | as_number }}{% endraw %}
            import re
            match = re.search(r"env_var\(['\"]([^'\"]+)['\"]\)", value)
            if match:
                var_name = match.group(1)
                env_value = os.getenv(var_name)
                if env_value is None:
                    raise ValueError(f"Environment variable '{var_name}' not set")
                
                # Check if it needs to be converted to number
                if 'as_number' in value:
                    try:
                        return int(env_value)
                    except ValueError:
                        return float(env_value)
                return env_value
        return value
    
    # Extract connection details
    config = {
        'host': resolve_env_var(output.get('host', 'localhost')),
        'port': resolve_env_var(output.get('port', 5432)),
        'user': resolve_env_var(output.get('user', 'postgres')),
        'password': resolve_env_var(output.get('pass', '')),
        'dbname': resolve_env_var(output.get('dbname', '')),
        'schema': resolve_env_var(output.get('schema', 'cdm')),
    }
    
    return config


def export_cdm_tables_to_zip(profiles_path="./profiles/profiles.yml", 
                              profile_name="yemaachi_taca1", 
                              target_name="yemaachi_taca1",
                              cdm_schema=None):
    """Export all tables from CDM schema to CSV files and zip them."""
    
    # Load connection details from profiles.yml
    config = load_dbt_profile(profiles_path, profile_name, target_name)
    
    # Use provided schema or default from profile
    schema = cdm_schema or config.get('schema', 'cdm')
    
    # Generate zip filename with date
    today = datetime.date.today().strftime("%Y%m%d")
    zip_name = f"{target_name}_omop_cdm_{today}.zip"
    
    print(f"Connecting to database: {config['host']}:{config['port']}/{config['dbname']}")
    print(f"Exporting tables from schema: {schema}")
    
    # Connect to database
    conn = psycopg2.connect(
        host=config['host'],
        port=config['port'],
        user=config['user'],
        password=config['password'],
        dbname=config['dbname'],
    )
    conn.autocommit = True
    
    try:
        with conn.cursor() as cur:
            # Get list of tables in the CDM schema
            cur.execute("""
                SELECT table_name
                FROM information_schema.tables
                WHERE table_schema = %s
                  AND table_type = 'BASE TABLE'
                ORDER BY table_name;
            """, (schema,))
            tables = [row[0] for row in cur.fetchall()]
        
        if not tables:
            print(f"No tables found in schema '{schema}'.")
            return
        
        print(f"Found {len(tables)} tables to export")
        
        # Create temporary directory for CSV files
        with tempfile.TemporaryDirectory() as tmpdir:
            csv_paths = []
            
            # Export each table to CSV using COPY
            for table in tables:
                csv_filename = f"{table}.csv"
                csv_path = os.path.join(tmpdir, csv_filename)
                print(f"  Exporting {schema}.{table} -> {csv_filename}")
                
                try:
                    with open(csv_path, 'w', encoding='utf-8', newline='') as f:
                        with conn.cursor() as cur:
                            # Use COPY TO STDOUT for efficient export
                            cur.copy_expert(
                                f'COPY "{schema}"."{table}" TO STDOUT WITH CSV HEADER',
                                f
                            )
                    csv_paths.append((csv_path, csv_filename))
                except Exception as e:
                    print(f"    ERROR exporting {table}: {e}")
                    continue
            
            # Create zip file with all CSVsyemaachi_taca1
            print(f"\nCreating zip archive: {zip_name}")
            with zipfile.ZipFile(zip_name, 'w', compression=zipfile.ZIP_DEFLATED) as zf:
                for csv_path, csv_filename in csv_paths:
                    zf.write(csv_path, csv_filename)
                    print(f"  Added {csv_filename} to archive")
            
            print(f"\n✓ Successfully created {zip_name} with {len(csv_paths)} tables")
            print(f"  File size: {os.path.getsize(zip_name) / (1024*1024):.2f} MB")
    
    finally:
        conn.close()


if __name__ == "__main__":
    import argparse
    
    parser = argparse.ArgumentParser(
        description="Export CDM schema tables to CSV and zip them",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Use default profiles.yml location and settings
  python export_cdm.py
  
  # Specify custom schema name
  python export_cdm.py --schema cdm
  
  # Use different profiles file
  python export_cdm.py --profiles-path custom/profiles.yml
        """
    )
    parser.add_argument(
        '--profiles-path',
        default='../profiles/profiles.yml',
        help='Path to dbt profiles.yml file (default: ../profiles/profiles.yml)'
    )
    parser.add_argument(
        '--profile-name',
        default='yemaachi_taca1',
        help='Profile name to use (default: yemaachi_taca1)'
    )
    parser.add_argument(
        '--target-name',
        default='yemaachi_taca1',
        help='Target name to use (default: yemaachi_taca1)'
    )
    parser.add_argument(
        '--schema',
        help='CDM schema name (default: profile schema or cdm)'
    )
    
    args = parser.parse_args()
    
    try:
        export_cdm_tables_to_zip(
            profiles_path=args.profiles_path,
            profile_name=args.profile_name,
            target_name=args.target_name,
            cdm_schema=args.schema
        )
    except Exception as e:
        print(f"ERROR: {e}", file=sys.stderr)
        sys.exit(1)

