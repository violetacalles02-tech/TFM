import pandas as pd

c = pd.read_csv("similitud/inferencia_similitud_condiciones.csv")
p = pd.read_csv("similitud/inferencia_similitud_pacientes.csv")
ok = p[p.estado == "ok"]

n_cond = c.groupby("patient_id").size()
print("Condiciones mapeadas por paciente:")
print(n_cond.value_counts().sort_index().to_string())

print("\nSimilitud media de los vecinos:")
print(ok.sim_media.describe().round(2).to_string())

print("\nVecinos que sustentan cada edad (n_vecinos_con_condicion):")
print(c.n_vecinos_con_condicion.describe().round(1).to_string())
print(f"Estimaciones con menos de 10 vecinos: {(c.n_vecinos_con_condicion < 10).sum()} de {len(c)}")

print("\nEdad inferida frente a edad actual (la inferida no puede superar la actual):")
print(f"  igual a la edad actual: {(c.edad_dx_inferida == c.edad).sum()}")



a = pd.read_csv("data_extract/camda_infer.csv", usecols=["patient_id", "edad", "condition_id", "edad_al_diagnostico"])
ultimo = a.groupby("patient_id").edad_al_diagnostico.max()
edad = a.drop_duplicates("patient_id").set_index("patient_id").edad
print(f"Pacientes cuyo último diagnóstico = su edad: {(ultimo == edad.reindex(ultimo.index)).mean():.1%}")
print(f"Diagnósticos con edad_al_diagnostico == edad: {(a.edad_al_diagnostico == a.edad).mean():.1%}")