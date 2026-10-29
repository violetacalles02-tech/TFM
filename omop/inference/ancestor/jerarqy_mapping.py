import pandas as pd
from sqlalchemy import create_engine, text

MAX_LVL = 100  # prácticamente sin límite

a = pd.read_csv("data_extract/camda_infer.csv", usecols=["patient_id", "condition_id"]).drop_duplicates()
b = pd.read_csv("data_extract/granada_infer.csv", usecols=["patient_id", "condition_id"]).drop_duplicates()
a_ids = sorted(int(x) for x in a.condition_id.unique())
b_ids = sorted(int(x) for x in b.condition_id.unique())

engine = create_engine("postgresql+psycopg2://postgres:postgres@localhost:5434/omop_cdm")

q = text("""
    SELECT descendant_concept_id AS b_concept, ancestor_concept_id AS a_concept,
           min_levels_of_separation AS lvl, 'B_hijo_de_A' AS direccion
    FROM vocabularies.concept_ancestor
    WHERE descendant_concept_id = ANY(:b_ids) AND ancestor_concept_id = ANY(:a_ids)
      AND min_levels_of_separation BETWEEN 1 AND :maxl
    UNION ALL
    SELECT ancestor_concept_id, descendant_concept_id, min_levels_of_separation, 'B_padre_de_A'
    FROM vocabularies.concept_ancestor
    WHERE ancestor_concept_id = ANY(:b_ids) AND descendant_concept_id = ANY(:a_ids)
      AND min_levels_of_separation BETWEEN 1 AND :maxl
""")
names_q = text("SELECT concept_id, concept_name FROM vocabularies.concept WHERE concept_id = ANY(:ids)")

with engine.connect() as conn:
    rel = pd.read_sql(q, conn, params={"b_ids": b_ids, "a_ids": a_ids, "maxl": MAX_LVL})
    names = pd.read_sql(names_q, conn, params={"ids": sorted(set(a_ids) | set(b_ids))}) \
              .set_index("concept_id").concept_name

directas = pd.DataFrame({"b_concept": sorted(set(b_ids) & set(a_ids))})
directas["a_concept"] = directas.b_concept
directas["lvl"] = 0
directas["direccion"] = "directa"

cand = pd.concat([directas, rel], ignore_index=True)
cand["b_nombre"] = cand.b_concept.map(names)
cand["a_nombre"] = cand.a_concept.map(names)
prio = {"directa": 0, "B_hijo_de_A": 1, "B_padre_de_A": 2}
cand["prio"] = cand.direccion.map(prio)
cand = cand.sort_values(["b_concept", "prio", "lvl", "a_concept"])

# Recomendada: directa > hijo (más cercano) > padre (más cercano)
mejor = cand.drop_duplicates("b_concept").copy()
mejor["n_empate"] = mejor.merge(
    cand.groupby(["b_concept", "prio", "lvl"]).size().rename("n").reset_index(),
    on=["b_concept", "prio", "lvl"]).n.values

# Todas las candidatas de cada condición, en texto, para la revisión
cand["txt"] = cand.a_nombre.fillna("?") + " [" + cand.a_concept.astype(str) + ", " \
              + cand.direccion + ", nivel " + cand.lvl.astype(str) + "]"
todas = cand.groupby("b_concept").txt.agg(" | ".join).rename("todas_las_candidatas")

res = pd.DataFrame({"b_concept": b_ids})
res["b_nombre"] = res.b_concept.map(names)
res["b_n_pacientes"] = res.b_concept.map(b.groupby("condition_id").patient_id.nunique())
res = res.merge(mejor[["b_concept", "a_concept", "a_nombre", "direccion", "lvl", "n_empate"]],
                on="b_concept", how="left").merge(todas, on="b_concept", how="left")
res["direccion"] = res.direccion.fillna("sin_relacion")
res["n_candidatas_total"] = res.b_concept.map(cand.groupby("b_concept").size()).fillna(0).astype(int)
res["revision"] = ""  # columna vacía para anotar si el emparejamiento tiene sentido

# NUEVO: las condiciones sin relación en CAMDA se marcan como unknown
sin = res.direccion == "sin_relacion"
res.loc[sin, "a_concept"] = 0
res["a_concept"] = res.a_concept.astype(int)
res.loc[sin, "a_nombre"] = "Unknown"

res = res.sort_values("b_n_pacientes", ascending=False)
res.to_csv("mapeo_condiciones.csv", index=False)

print(res.direccion.value_counts().to_string())
print("\nCobertura de filas de B con alguna relación:",
      f"{b.condition_id.isin(res[res.direccion != 'sin_relacion'].b_concept).mean():.1%}")
print("Distribución por nivel de la recomendada:")
print(res[res.direccion != "sin_relacion"].lvl.value_counts().sort_index().to_string())