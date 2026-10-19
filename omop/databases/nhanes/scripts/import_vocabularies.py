import os
import glob
import pandas as pd
from sqlalchemy import create_engine, text

PG_HOST = "localhost"
PG_PORT = "5433"
PG_DB = "nhanes_db"
PG_USER = "postgres"
PG_PASSWORD = "postgres"
SCHEMA = "vocabularies"
CSV_DIR = "/home/vant/Documentos/Master/TFM/omop/databases/nhanes/dbt-project/vocabularies"  # Ajusta la ruta si es necesario

engine = create_engine(f"postgresql+psycopg2://{PG_USER}:{PG_PASSWORD}@{PG_HOST}:{PG_PORT}/{PG_DB}")

with engine.begin() as conn:
    conn.execute(text(f"CREATE SCHEMA IF NOT EXISTS {SCHEMA}"))

csv_files = glob.glob(os.path.join(CSV_DIR, "*.csv"))
for filepath in csv_files:
    table_name = os.path.splitext(os.path.basename(filepath))[0].lower()
    print(f"Cargando {os.path.basename(filepath)} -> {SCHEMA}.{table_name}...")
    # Los vocabularios de OMOP suelen usar tabuladores o comas, asegúrate del separador (por defecto ',' o '\t')
    df = pd.read_csv(filepath, sep='\t', engine='python', quoting=3, on_bad_lines='skip')
    df.columns = [c.lower() for c in df.columns]
    df.to_sql(table_name, engine, schema=SCHEMA, if_exists="replace", index=False, chunksize=10000, method="multi")
print("¡Vocabularios cargados con éxito!")