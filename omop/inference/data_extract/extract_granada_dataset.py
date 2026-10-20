#!/usr/bin/env python3
"""
Extrae el DATASET B (objetivo) desde la BBDD OMOP de diabetes_granada.

Salida (CSV): patient_id, sexo, edad, condition_id
(sin edad de diagnostico: es lo que se va a inferir a partir del Dataset A)

Convenciones:
  - edad      = ref_year - year_of_birth
  - sexo      = 'M' / 'F' a partir de gender_concept_id (8507 / 8532), igual que en el Dataset A
  - condition_id = condition_concept_id (estandar OMOP), mismo espacio de IDs que en A

OJO: ajusta --ref-year a la fecha de referencia con la que se construyo year_of_birth
en stg_person (p. ej. el anio de la medicion/extraccion de patient_info).

Uso:
  python extract_granada_dataset_b.py --port 5434 --db omop_cdm --user postgres \
      --password XXXX --ref-year 2022 --out dataset_B_granada.csv
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
    ap.add_argument("--port", default=os.getenv("PGPORT", "5434"))
    ap.add_argument("--db", default=os.getenv("PGDATABASE", "omop_cdm"))
    ap.add_argument("--user", default=os.getenv("PGUSER", "postgres"))
    ap.add_argument("--password", default=os.getenv("PGPASSWORD", ""))
    ap.add_argument("--schema", default="cdm")
    ap.add_argument("--ref-year", type=int, required=True,
                    help="Anio de referencia para calcular la edad actual")
    ap.add_argument("--out", default="dataset_B_granada.csv")
    args = ap.parse_args()

    url = f"postgresql+psycopg2://{args.user}:{args.password}@{args.host}:{args.port}/{args.db}"
    engine = create_engine(url)

    query = text(f"""
        SELECT DISTINCT
            p.person_id                                  AS patient_id,
            CASE p.gender_concept_id
                 WHEN 8507 THEN 'M'
                 WHEN 8532 THEN 'F'
            END                                          AS sexo,
            (:ref_year - p.year_of_birth)::int           AS edad,
            co.condition_concept_id                      AS condition_id
        FROM {args.schema}.person p
        JOIN {args.schema}.condition_occurrence co USING (person_id)
        WHERE co.condition_concept_id <> 0
        ORDER BY p.person_id, co.condition_concept_id
    """)

    with engine.connect() as conn:
        df = pd.read_sql(query, conn, params={"ref_year": args.ref_year})

    df.to_csv(args.out, index=False)
    print(f"Hecho: {len(df):,} filas, {df['patient_id'].nunique():,} pacientes -> {args.out}")


if __name__ == "__main__":
    main()
