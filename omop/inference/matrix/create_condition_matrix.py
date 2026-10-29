import numpy as np
import pandas as pd

A_CSV = "data_extract/camda_infer.csv"      # patient_id, sexo, edad, condition_id, edad_al_diagnostico
B_CSV = "data_extract/granada_infer.csv"    # patient_id, sexo, edad, condition_id
MAP_CSV = "ancestor/mapeo_condiciones.csv"

a = pd.read_csv(A_CSV)
b = pd.read_csv(B_CSV)

# Mapeo Granada -> CAMDA; las condiciones sin relación (0 / unknown) se descartan
m = pd.read_csv(MAP_CSV, dtype={"a_concept": str})
m["a_concept"] = pd.to_numeric(m.a_concept, errors="coerce")
m = m[m.a_concept.notna() & (m.a_concept != 0)]
# m = m[m.direccion != "B_padre_de_A"]   # descomenta para excluir las "más generales"
mapa = dict(zip(m.b_concept.astype(int), m.a_concept.astype(int)))

# Columnas = las condiciones de CAMDA (mismo orden en las dos matrices)
cols = sorted(int(c) for c in a.condition_id.unique())
col_idx = {c: i for i, c in enumerate(cols)}

def build_matrix(df, cond_col):
    pac = (df.drop_duplicates("patient_id")[["patient_id", "sexo", "edad"]]
             .sort_values("patient_id").reset_index(drop=True))
    row_idx = {p: i for i, p in enumerate(pac.patient_id)}
    X = np.zeros((len(pac), len(cols)), dtype=np.uint8)
    d = df.dropna(subset=[cond_col])
    d = d[d[cond_col].isin(cols)]
    X[d.patient_id.map(row_idx).to_numpy().astype(int),
      d[cond_col].astype(int).map(col_idx).to_numpy()] = 1
    return pac, X

# CAMDA: sus propias condiciones
pac_a, X_a = build_matrix(a.assign(cond_A=a.condition_id), "cond_A")

# Granada: condiciones traducidas a CAMDA
b["cond_A"] = b.condition_id.map(mapa)
pac_b, X_b = build_matrix(b, "cond_A")

# Guardar
np.savez_compressed("matriz_camda.npz", X=X_a, patient_id=pac_a.patient_id.to_numpy(),
                    edad=pac_a.edad.to_numpy(), sexo=pac_a.sexo.to_numpy(), cols=np.array(cols))
np.savez_compressed("matriz_granada.npz", X=X_b, patient_id=pac_b.patient_id.to_numpy(),
                    edad=pac_b.edad.to_numpy(), sexo=pac_b.sexo.to_numpy(), cols=np.array(cols))
pd.concat([pac_b, pd.DataFrame(X_b, columns=cols)], axis=1).to_csv("matriz_granada.csv", index=False)

n = X_b.sum(axis=1)
print(f"CAMDA:   {X_a.shape[0]:,} pacientes x {X_a.shape[1]} condiciones")
print(f"Granada: {X_b.shape[0]:,} pacientes x {X_b.shape[1]} condiciones")
print(f"Granada con 0 condiciones mapeadas: {(n == 0).sum()} | 1: {(n == 1).sum()} | >=2: {(n >= 2).sum()}")
print(f"Edad -> CAMDA {pac_a.edad.min():.0f}-{pac_a.edad.max():.0f} | Granada {pac_b.edad.min():.0f}-{pac_b.edad.max():.0f}")