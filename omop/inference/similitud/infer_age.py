import argparse
import numpy as np
import pandas as pd

ap = argparse.ArgumentParser()
ap.add_argument("--k", type=int, default=50, help="vecinos de CAMDA por paciente")
ap.add_argument("--age-window", type=float, default=5, help="+- años de diferencia de edad")
ap.add_argument("--sex-match", action="store_true", help="exigir mismo sexo")
ap.add_argument("--exclude-padres", action="store_true", help="no usar relaciones B_padre_de_A")
ap.add_argument("--out", default="inferencia_similitud")
args = ap.parse_args()

# ---------- CAMDA: matriz ordenada por edad (permite filtrar por edad con un slice) ----------
da = np.load("matrix/matriz_camda.npz", allow_pickle=True)
cols = da["cols"].astype(int)
order = np.argsort(da["edad"].astype(float), kind="stable")
Xa = da["X"][order].astype(np.float32)
ida = da["patient_id"][order]
edad_a = da["edad"].astype(float)[order]
sexo_a = da["sexo"].astype(str)[order]
rows_a = Xa.sum(axis=1)

# Edad al diagnóstico de cada paciente y condición (NaN si no la tiene)
camda = pd.read_csv("data_extract/camda_infer.csv", usecols=["patient_id", "condition_id", "edad_al_diagnostico"])
r = pd.Index(ida).get_indexer(camda.patient_id)
c = pd.Index(cols).get_indexer(camda.condition_id)
ok = (r >= 0) & (c >= 0)
T = np.full(Xa.shape, np.nan, dtype=np.float32)
T[r[ok], c[ok]] = camda.edad_al_diagnostico.to_numpy()[ok]

# ---------- Granada ----------
db = np.load("matrix/matriz_granada.npz", allow_pickle=True)
Xb, idb = db["X"].astype(np.float32), db["patient_id"]
edad_b, sexo_b = db["edad"].astype(float), db["sexo"].astype(str)

m = pd.read_csv("ancestor/mapeo_condiciones.csv", dtype={"a_concept": str})
m["a_concept"] = pd.to_numeric(m.a_concept, errors="coerce")
m = m[m.a_concept.notna() & (m.a_concept != 0)]
if args.exclude_padres:
    m = m[m.direccion != "B_padre_de_A"]
mapa = dict(zip(m.b_concept.astype(int), m.a_concept.astype(int)))

granada = pd.read_csv("data_extract/granada_infer.csv", usecols=["patient_id", "condition_id"]).drop_duplicates()
granada["cond_A"] = granada.condition_id.map(mapa)
granada = granada.dropna(subset=["cond_A"])
granada["cond_A"] = granada.cond_A.astype(int)
orig = {p: g for p, g in granada.groupby("patient_id")}

# ---------- Inferencia ----------
res, resumen = [], []
for i, pid in enumerate(idb):
    v = Xb[i]
    nv = v.sum()
    if nv == 0:
        resumen.append((pid, "sin_condiciones_mapeadas", 0, np.nan))
        continue
    lo = np.searchsorted(edad_a, edad_b[i] - args.age_window, side="left")
    hi = np.searchsorted(edad_a, edad_b[i] + args.age_window, side="right")
    cand = np.arange(lo, hi)
    if args.sex_match:
        cand = cand[sexo_a[cand] == sexo_b[i]]
    if len(cand) == 0:
        resumen.append((pid, "sin_candidatos_por_edad", 0, np.nan))
        continue

    inter = Xa[cand] @ v
    sim = inter / (rows_a[cand] + nv - inter)          # Jaccard
    sim[inter == 0] = 0
    top = np.argsort(-sim)[: args.k]
    top = top[sim[top] > 0]
    if len(top) == 0:
        resumen.append((pid, "sin_vecinos_similares", 0, np.nan))
        continue
    vec = cand[top]
    resumen.append((pid, "ok", len(vec), float(sim[top].mean())))

    for _, row in orig.get(pid, pd.DataFrame(columns=["condition_id", "cond_A"])).iterrows():
        col = int(np.where(cols == row.cond_A)[0][0])
        ages = T[vec, col]
        ages = ages[~np.isnan(ages)]
        est = np.nan
        if len(ages):
            est = float(np.clip(np.median(ages), 0, edad_b[i]))   # no puede ser mayor que su edad actual
        res.append({"patient_id": pid, "sexo": sexo_b[i], "edad": edad_b[i],
                    "condition_id_B": row.condition_id, "condition_id_A": row.cond_A,
                    "edad_dx_inferida": est, "n_vecinos_con_condicion": len(ages),
                    "n_vecinos": len(vec), "sim_media": float(sim[top].mean())})

res = pd.DataFrame(res)
resumen = pd.DataFrame(resumen, columns=["patient_id", "estado", "n_vecinos", "sim_media"])
res.to_csv(f"{args.out}_condiciones.csv", index=False)
resumen.to_csv(f"{args.out}_pacientes.csv", index=False)

seq = (res.dropna(subset=["edad_dx_inferida"]).sort_values(["patient_id", "edad_dx_inferida"])
          .groupby("patient_id").condition_id_A.agg(lambda s: " -> ".join(map(str, s))))
seq.rename("secuencia_inferida").to_csv(f"{args.out}_secuencias.csv")

print(resumen.estado.value_counts().to_string())
print(f"\nCondiciones con edad inferida: {res.edad_dx_inferida.notna().sum()} de {len(res)}")
print(f"Vecinos por paciente (mediana): {resumen[resumen.estado == 'ok'].n_vecinos.median():.0f}")