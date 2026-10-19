#!/usr/bin/env python
"""
Carga todos los archivos .xpt de NHANES en el esquema `nhanes_raw`
de una base Postgres, una tabla por componente (DEMO_L -> demo_l, etc.)

Requisitos: pandas, sqlalchemy, psycopg2-binary, python-dotenv
    pip install pandas sqlalchemy psycopg2-binary python-dotenv --break-system-packages

Configura la conexion y la carpeta de origen via variables de entorno
(en un .env junto al script, o exportadas en la shell):

    PG_HOST=localhost
    PG_PORT=5433
    PG_DB=nhanes_db
    PG_USER=postgres
    PG_PASSWORD=tu_password
    XPT_DIR=./data/xpt
"""

import os
import glob

import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv

load_dotenv()

PG_HOST = os.getenv("PG_HOST", "localhost")
PG_PORT = os.getenv("PG_PORT", "5433")
PG_DB = os.getenv("PG_DB", "nhanes_db")
PG_USER = os.getenv("PG_USER", "postgres")
PG_PASSWORD = os.getenv("PG_PASSWORD", "postgres")

SCHEMA = "raw"
XPT_DIR = os.getenv("XPT_DIR", "/home/vant/Documentos/Master/TFM/omop/databases/nhanes_dev/NHANES_data/raw/")

engine = create_engine(
    f"postgresql+psycopg2://{PG_USER}:{PG_PASSWORD}@{PG_HOST}:{PG_PORT}/{PG_DB}"
)


def read_xpt(filepath: str) -> pd.DataFrame:
    """Lee un .xpt intentando utf-8 y cayendo a latin-1 si hace falta."""
    try:
        df = pd.read_sas(filepath, format="xport", encoding="utf-8")
    except UnicodeDecodeError:
        df = pd.read_sas(filepath, format="xport", encoding="latin-1")

    # nombres de columna en minuscula (evita problemas de comillas en Postgres/dbt)
    df.columns = [c.lower() for c in df.columns]

    # algunas columnas categoricas pueden llegar como bytes segun la version de pandas
    for col in df.select_dtypes(include=["object"]).columns:
        df[col] = df[col].apply(
            lambda x: x.decode("utf-8", errors="replace") if isinstance(x, bytes) else x
        )

    return df


def load_xpt_files():
    with engine.begin() as conn:
        conn.execute(text(f"CREATE SCHEMA IF NOT EXISTS {SCHEMA}"))

    xpt_files = sorted(glob.glob(os.path.join(XPT_DIR, "*.xpt")))
    if not xpt_files:
        print(f"No se encontraron archivos .xpt en {XPT_DIR}")
        return

    print(f"Encontrados {len(xpt_files)} archivos .xpt en {XPT_DIR}\n")

    errores = []
    for filepath in xpt_files:
        table_name = os.path.splitext(os.path.basename(filepath))[0].lower()
        print(f"Cargando {os.path.basename(filepath):20s} -> {SCHEMA}.{table_name} ...", end=" ")
        try:
            df = read_xpt(filepath)
            df.to_sql(
                table_name,
                engine,
                schema=SCHEMA,
                if_exists="replace",
                index=False,
                chunksize=5000,
                method="multi",
            )
            print(f"OK ({len(df)} filas, {len(df.columns)} columnas)")
        except Exception as exc:
            print(f"ERROR: {exc}")
            errores.append((filepath, str(exc)))

    print("\nResumen:")
    print(f"  Tablas cargadas: {len(xpt_files) - len(errores)}/{len(xpt_files)}")
    if errores:
        print("  Fallos:")
        for filepath, msg in errores:
            print(f"    - {os.path.basename(filepath)}: {msg}")


if __name__ == "__main__":
    load_xpt_files()