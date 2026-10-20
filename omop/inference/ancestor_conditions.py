import pandas as pd
from sqlalchemy import create_engine, text

MAX_LEVELS = 3  # distancia máxima en la jerarquía; sube para más cobertura, baja para más precisión

a = pd.read_csv("camda_infer.csv", usecols=["condition_id"])
b = pd.read_csv("granada_infer.csv", usecols=["patient_id", "condition_id"])
a_ids = sorted(set(a.condition_id))
b_ids = sorted(set(b.condition_id) - set(a_ids))  # solo las que no tienen match directo

engine = create_engine("postgresql+psycopg2://postgres:postgres@localhost:5434/omop_cdm")

q = text("""
    SELECT b_concept, a_concept, lvl, direccion FROM (
        -- la condición de B es más específica que una de A (B descendiente de A)
        SELECT descendant_concept_id AS b_concept, ancestor_concept_id AS a_concept,
               min_levels_of_separation AS lvl, 'B_hijo_de_A' AS direccion
        FROM vocabularies.concept_ancestor
        WHERE descendant_concept_id = ANY(:b_ids) AND ancestor_concept_id = ANY(:a_ids)
          AND min_levels_of_separation BETWEEN 1 AND :maxl
        UNION ALL
        -- la condición de B es más general que una de A (B ancestro de A)
        SELECT ancestor_concept_id, descendant_concept_id,
               min_levels_of_separation, 'B_padre_de_A'
        FROM vocabularies.concept_ancestor
        WHERE ancestor_concept_id = ANY(:b_ids) AND descendant_concept_id = ANY(:a_ids)
          AND min_levels_of_separation BETWEEN 1 AND :maxl
    ) t
""")
with engine.connect() as conn:
    rel = pd.read_sql(q, conn, params={"b_ids": b_ids, "a_ids": a_ids, "maxl": MAX_LEVELS})

# Una relación por concepto de B: la más cercana (prefiere B_hijo_de_A si empatan)
rel["prio"] = (rel.direccion != "B_hijo_de_A").astype(int)
best = rel.sort_values(["b_concept", "lvl", "prio"]).drop_duplicates("b_concept")

print(f"Conceptos de B sin match directo: {len(b_ids)} | con relación jerárquica a A: {len(best)}")
print(best.direccion.value_counts().to_string())

cubiertas = b.condition_id.isin(a_ids) | b.condition_id.isin(best.b_concept)
print(f"\nCobertura de filas de B: directa 7.5% -> con jerarquía {cubiertas.mean():.1%}")

best.to_csv("mapeo_B_a_A_jerarquia.csv", index=False)

b = pd.read_csv("granada_infer.csv", usecols=["condition_id"])
m = pd.read_csv("mapeo_B_a_A_jerarquia.csv")
a_ids = set(pd.read_csv("camda_infer.csv", usecols=["condition_id"]).condition_id)

print(f"Directa: {b.condition_id.isin(a_ids).mean():.1%}")
for direccion in ["B_hijo_de_A", "B_padre_de_A"]:
    for lvl in [1, 2, 3]:
        ids = m[(m.direccion == direccion) & (m.lvl <= lvl)].b_concept
        print(f"{direccion} hasta nivel {lvl}: +{b.condition_id.isin(ids).mean():.1%}")