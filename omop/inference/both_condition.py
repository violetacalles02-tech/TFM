import pandas as pd

a = pd.read_csv("camda_infer.csv", usecols=["patient_id", "condition_id"])
b = pd.read_csv("granada_infer.csv", usecols=["patient_id", "condition_id"])

ca, cb = set(a.condition_id), set(b.condition_id)
comunes = ca & cb

print(f"Condiciones distintas -> A: {len(ca)} | B: {len(cb)} | comunes: {len(comunes)}")

# Qué parte de las filas de B quedaría cubierta por condiciones presentes en A
cobertura = b.condition_id.isin(ca).mean()
print(f"Filas de B con condición presente en A: {cobertura:.1%}")

# Condiciones de B sin equivalente en A, ordenadas por frecuencia
sin_cobertura = (b[~b.condition_id.isin(ca)]
                 .condition_id.value_counts().head(20))
print("\nTop condiciones de B sin cobertura en A:")
print(sin_cobertura)