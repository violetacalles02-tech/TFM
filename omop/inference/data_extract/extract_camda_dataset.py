#!/usr/bin/env python3
"""
Extrae el DATASET A (entrenamiento) desde la BBDD OMOP de CAMDA.

Salida (CSV): patient_id, sexo, edad, condition_id, edad_al_diagnostico

Convenciones (las mismas usadas en el ETL CAMDA -> OMOP):
  - year_of_birth = 2022 - edad maxima, condition_start_date = 1 de enero de (year_of_birth + edad)
  - edad (actual)         = ref_year - year_of_birth            (ref_year = 2022 por defecto)
  - edad_al_diagnostico   = year(condition_start_date) - year_of_birth
  - sexo                  = 'M' / 'F' a partir de gender_concept_id (8507 / 8532)
  - condition_id          = condition_concept_id (estandar OMOP)

Uso:
  python extract_camda_dataset_a.py --port 5432 --db omop_cdm --user postgres \
      --password XXXX --out dataset_A_camda.csv
(Tambien se leen PGHOST, PGPORT, PGDATABASE, PGUSER, PGPASSWORD del entorno / .env)
"""
import argparse
import os

import pandas as pd
from sqlalchemy import create_engine, text

try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    pass


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--host", default=os.getenv("PGHOST", "localhost"))
    ap.add_argument("--port", default=os.getenv("PGPORT", "5432"))
    ap.add_argument("--db", default=os.getenv("PGDATABASE", "omop_cdm"))
    ap.add_argument("--user", default=os.getenv("PGUSER", "postgres"))
    ap.add_argument("--password", default=os.getenv("PGPASSWORD", ""))
    ap.add_argument("--schema", default="cdm")
    ap.add_argument("--ref-year", type=int, default=2022)
    ap.add_argument("--out", default="dataset_A_camda.csv")
    ap.add_argument("--chunksize", type=int, default=500_000)
    args = ap.parse_args()

    url = f"postgresql+psycopg2://{args.user}:{args.password}@{args.host}:{args.port}/{args.db}"
    engine = create_engine(url)

    query = text(f"""
        SELECT
            p.person_id                                              AS patient_id,
            CASE p.gender_concept_id
                 WHEN 8507 THEN 'M'
                 WHEN 8532 THEN 'F'
            END                                                      AS sexo,
            (:ref_year - p.year_of_birth)::int                       AS edad,
            co.condition_concept_id                                  AS condition_id,
            (EXTRACT(YEAR FROM MIN(co.condition_start_date))::int
                 - p.year_of_birth)                                  AS edad_al_diagnostico
        FROM {args.schema}.person p
        JOIN {args.schema}.condition_occurrence co USING (person_id)
        WHERE co.condition_concept_id <> 0
        GROUP BY p.person_id, p.gender_concept_id, p.year_of_birth, co.condition_concept_id
        ORDER BY p.person_id, edad_al_diagnostico
    """)

    first = True
    total = 0
    with engine.connect().execution_options(stream_results=True) as conn:
        for chunk in pd.read_sql(query, conn, params={"ref_year": args.ref_year},
                                 chunksize=args.chunksize):
            chunk.to_csv(args.out, mode="w" if first else "a", header=first, index=False)
            first = False
            total += len(chunk)
            print(f"  {total:,} filas escritas...")

    print(f"Hecho: {total:,} filas -> {args.out}")


if __name__ == "__main__":
    main()
