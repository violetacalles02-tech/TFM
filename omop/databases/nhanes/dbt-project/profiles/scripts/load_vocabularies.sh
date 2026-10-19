#!/usr/bin/env bash
set -euo pipefail

# Carga los CSV de un bundle de vocabularios de Athena en el esquema
# `vocabularies` de Postgres, via \copy (tabla por tabla).
#
# Requisito previo: las tablas ya tienen que existir (DDL oficial de
# OHDSI CommonDataModel, el mismo que usaste para crear el esquema CDM
# de diabetes_granada), apuntando al esquema vocabularies de nhanes_db.
#
# Configura estas variables antes de ejecutar (o exportalas en tu shell,
# o pon PGPASSWORD en tu .env y haz "source .env" antes de correr esto):
#
#   PGHOST=localhost
#   PGPORT=5433
#   PGDATABASE=nhanes_db
#   PGUSER=postgres
#   PGPASSWORD=postgres
#   VOCAB_DIR=/home/vant/Documentos/Master/TFM/omop/databases/nhanes/dbt-project/vocabularies   (carpeta donde descomprimiste el bundle de Athena)

: "${PGHOST:=localhost}"
: "${PGPORT:=5433}"
: "${PGDATABASE:=nhanes_db}"
: "${PGUSER:=postgres}"
: "${VOCAB_DIR:=/home/vant/Documentos/Master/TFM/omop/databases/nhanes/dbt-project/vocabularies}"

export PGHOST PGPORT PGDATABASE PGUSER
export PGPASSWORD=postgres

SCHEMA=vocabularies

# tabla destino -> nombre de archivo tal como lo genera Athena
declare -A FILES=(
  [concept]="CONCEPT.csv"
  [vocabulary]="VOCABULARY.csv"
  [domain]="DOMAIN.csv"
  [concept_class]="CONCEPT_CLASS.csv"
  [concept_relationship]="CONCEPT_RELATIONSHIP.csv"
  [relationship]="RELATIONSHIP.csv"
  [concept_synonym]="CONCEPT_SYNONYM.csv"
  [concept_ancestor]="CONCEPT_ANCESTOR.csv"
  [source_to_concept_map]="SOURCE_TO_CONCEPT_MAP.csv"
  [drug_strength]="DRUG_STRENGTH.csv"
)

echo "Cargando vocabularios en ${PGDATABASE}.${SCHEMA} desde ${VOCAB_DIR}"
echo

for table in "${!FILES[@]}"; do
    file="${VOCAB_DIR}/${FILES[$table]}"

    if [[ ! -f "$file" ]]; then
        echo "AVISO: no se encuentra ${file}, salto ${table}"
        continue
    fi

    echo "Cargando ${table} desde $(basename "$file") ..."

    psql -v ON_ERROR_STOP=1 -c "TRUNCATE TABLE ${SCHEMA}.${table};"

    # Los CSV de Athena van separados por tabulador, sin comillas para texto.
    # QUOTE se fija a un caracter que nunca aparece (backspace) para que
    # Postgres no intente interpretar comillas dobres sueltas dentro del texto.
    psql -v ON_ERROR_STOP=1 -c "\copy ${SCHEMA}.${table} FROM '${file}' WITH (FORMAT csv, DELIMITER E'\t', HEADER true, QUOTE E'\b', NULL '')"

    count=$(psql -tAc "select count(*) from ${SCHEMA}.${table};")
    echo "  -> ${count} filas cargadas"
    echo
done

echo "Carga de vocabularios completa."