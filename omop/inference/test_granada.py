import pandas as pd

MAX_LVL = 2  # mismo nivel que decidiste para la jerarquía

b = pd.read_csv("granada_infer.csv", usecols=["patient_id", "condition_id"])
a_ids = set(pd.read_csv("camda_infer.csv", usecols=["condition_id"]).condition_id)
m = pd.read_csv("mapeo_B_a_A_jerarquia.csv")
hijos = set(m[(m.direccion == "B_hijo_de_A") & (m.lvl <= MAX_LVL)].b_concept)
mapeable = a_ids | hijos  # directa + hijos de A (sin padres)

b["mapeable"] = b.condition_id.isin(mapeable)
pac_por_cond = b.groupby("condition_id").patient_id.nunique().rename("n_pacientes")

print(f"Total B: {len(b):,} filas | {b.patient_id.nunique():,} pacientes | "
      f"{b.condition_id.nunique()} condiciones")
print("\nDistribución de pacientes por condición:")
print(pac_por_cond.describe().round(1).to_string())

print(f"\n{'min_pac':>7} {'conds':>6} {'filas%':>7} {'pacientes':>10} {'mapeable%':>10}")
for t in [1, 2, 3, 5, 10, 20, 50]:
    keep = pac_por_cond[pac_por_cond >= t].index
    sub = b[b.condition_id.isin(keep)]
    print(f"{t:>7} {len(keep):>6} {len(sub)/len(b):>7.1%} "
          f"{sub.patient_id.nunique():>10,} {sub.mapeable.mean():>10.1%}")

# Condiciones raras que SÍ son mapeables (las que perderías por filtrar)
raras_map = pac_por_cond[(pac_por_cond < 5) & pac_por_cond.index.isin(mapeable)]
print(f"\nCondiciones con <5 pacientes que sí tienen equivalente en A: {len(raras_map)}")