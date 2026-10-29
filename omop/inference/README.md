# Inferencia de fechas de diagnóstico: CAMDA → diabetes_granada

Pipeline para transferir información temporal (edad de diagnóstico) desde un
dataset longitudinal (**CAMDA**, Dataset A) a otro que tiene los diagnósticos
pero no cuándo ocurrieron (**diabetes_granada**, Dataset B). Ambos datasets
están transformados a OMOP-CDM y cargados en contenedores Docker de Postgres.

## Idea general

```
CAMDA ──┐
        ├─► 1. Relacionar códigos Granada → CAMDA ─► 2. Matrices de condiciones (1/0) + EDAD
Granada ┘                                                    │
                                                             ▼
        4. Edad de diagnóstico inferida  ◄─ 3. Por cada paciente de Granada:
           (mediana de los CAMDA parecidos)     filtrar CAMDA por edad y calcular similitud
```

## Estructura de la carpeta

```
inference/
├── data_extract/     Paso 0: extracción de los datasets desde las BBDD OMOP
├── ancestor/         Paso 1: relación de condiciones Granada → CAMDA (jerarquía SNOMED)
├── matrix/           Paso 2: matrices paciente × condición
├── similitud/        Paso 3: similitud entre pacientes e inferencia de edades
└── validation/       Diagnóstico de los resultados
```

## Paso 0 · Extracción de datos (`data_extract/`)

| Script | Origen | Salida |
|---|---|---|
| `extract_camda_dataset.py` | BBDD `camda` (contenedor, puerto 5435), esquema `cdm` | `camda_infer.csv` |
| `extract_granada_dataset.py` | BBDD `omop_cdm` de diabetes_granada (puerto 5434), esquema `cdm` | `granada_infer.csv` |

Columnas de los CSV:

- **Dataset A (CAMDA):** `patient_id, sexo, edad, condition_id, edad_al_diagnostico`
- **Dataset B (Granada):** `patient_id, sexo, edad, condition_id`

Convenciones:

- `condition_id` = `condition_concept_id` estándar de OMOP (se excluye el 0).
- `sexo` = `M` / `F` a partir de `gender_concept_id` (8507 / 8532).
- `edad` = `2022 − year_of_birth` en ambos datasets (2022 es el año de referencia).
- `edad_al_diagnostico` (solo CAMDA) = `año(condition_start_date) − year_of_birth`.
  Si un paciente tiene la misma condición varias veces, se conserva la primera.

Las credenciales se pasan por argumentos (`--port`, `--db`, `--user`, `--password`)
o por las variables `PGHOST`, `PGPORT`, `PGDATABASE`, `PGUSER`, `PGPASSWORD`.

## Paso 1 · Relación de condiciones Granada → CAMDA (`ancestor/`)

`jerarqy_mapping.py` busca, para cada condición de Granada, la condición de CAMDA
equivalente usando `vocabularies.concept_ancestor` (jerarquía de SNOMED), **sin límite
de nivel**. Genera `mapeo_condiciones.csv` con una fila por condición de Granada,
ordenada por número de pacientes.

Orden de prioridad de la relación recomendada:

1. `directa`: el mismo `concept_id` existe en CAMDA (nivel 0).
2. `B_hijo_de_A`: la condición de Granada es un subtipo de una de CAMDA (el caso seguro).
3. `B_padre_de_A`: la condición de Granada es más general que una de CAMDA (caso delicado).
4. `sin_relacion`: sin ninguna relación jerárquica. En `a_concept` se marca
   `0` (*No matching concept* de OMOP) o `unknown`, según la versión del script.

Columnas principales: `b_concept`, `b_nombre`, `b_n_pacientes`, `a_concept`,
`a_nombre`, `direccion`, `lvl` (nivel de separación), `n_empate` (candidatas al mismo
nivel; si es > 1 se elige la de `concept_id` más bajo, sin criterio clínico),
`todas_las_candidatas` y `revision` (columna vacía para anotar si la relación tiene sentido).

Resultado:

| Tipo | Condiciones |
|---|---|
| Directa | 23 |
| Granada subtipo de CAMDA | 117 |
| Granada más general que CAMDA | 22 |
| Sin relación | 413 |

La cobertura es del **39,3 % de las filas de Granada**. Casi todo se resuelve en niveles bajos
(23 directas, 49 a nivel 1, 47 a nivel 2 y solo 43 de nivel 3 o superior).
Las 413 sin relación suman el 60,7 % de las filas, pero las 40 con más pacientes
concentran el 26,6 %.

> El parentesco lateral (condiciones que cuelgan de un mismo padre) se probó y **no se
> usa**: de las 65 condiciones que salían, solo una minoría tiene sentido clínico
> (p. ej. hiperlipidemia → dislipidemia) y el resto emparejaría enfermedades distintas
> (p. ej. rinitis alérgica → psoriasis, neoplasia benigna → maligna).

## Paso 2 · Matrices de condiciones (`matrix/`)

`create_condition_matrix.py` construye una matriz binaria paciente × condición donde las
columnas son las condiciones de CAMDA. Los pacientes de Granada se proyectan sobre esas
columnas con el mapeo del paso 1 (las condiciones sin relación se descartan).

Salidas:

- `matriz_camda.npz`, `matriz_granada.npz`: ficheros NumPy comprimidos con `X` (matriz
  1/0), `patient_id`, `edad`, `sexo` y `cols` (los `concept_id` de las columnas).
- `matriz_granada.csv`: la matriz de Granada en CSV, para inspeccionarla.

Para leerlos:

```python
import numpy as np
d = np.load("matriz_granada.npz", allow_pickle=True)
X, edad, ids, cols = d["X"], d["edad"], d["patient_id"], d["cols"]
```

Los tiempos (`edad_al_diagnostico`) no están en la matriz: se cruzan después por
`patient_id` y `condition_id` desde `camda_infer.csv`.

## Paso 3 · Similitud e inferencia de edades (`similitud/`)

`infer_age.py` hace, para cada paciente de Granada:

1. **Filtro por edad:** se queda con los pacientes de CAMDA con edad dentro de
   `±--age-window` años (5 por defecto). Opcionalmente exige el mismo sexo (`--sex-match`).
2. **Similitud:** Jaccard entre el vector de condiciones del paciente y el de cada candidato.
   Se queda con los `--k` más similares (50 por defecto) con similitud mayor que 0.
3. **Edad de diagnóstico:** para cada condición del paciente, la **mediana** de la
   `edad_al_diagnostico` entre esos vecinos que la tienen, limitada a la edad actual
   del paciente.

Opciones: `--k`, `--age-window`, `--sex-match`, `--exclude-padres`, `--out`.

Salidas:

- `inferencia_similitud_condiciones.csv`: una fila por paciente y condición, con
  `condition_id_B`, `condition_id_A`, `edad_dx_inferida`, `n_vecinos_con_condicion`,
  `n_vecinos` y `sim_media`.
- `inferencia_similitud_pacientes.csv`: estado de cada paciente (`ok`,
  `sin_condiciones_mapeadas`, `sin_candidatos_por_edad`, `sin_vecinos_similares`),
  vecinos usados y similitud media.
- `inferencia_similitud_secuencias.csv`: condiciones de cada paciente ordenadas por
  edad inferida.

Resultado de la ejecución actual: de 505 pacientes de Granada, **368 con al menos una
condición mapeada** (`ok`) y **137 sin ninguna** (27 %). Se infiere edad para 760 de 765
condiciones.

## Diagnóstico de resultados (`validation/`)

`validation_similitud.py` imprime estadísticas para valorar la calidad de la inferencia:
condiciones mapeadas por paciente, similitud media de los vecinos, vecinos que sustentan
cada edad y cuántas estimaciones coinciden con la edad actual del paciente.


## Limitaciones conocidas

- **Cobertura:** solo el 39,3 % de las filas de Granada tiene una condición relacionada
  con CAMDA (que solo tiene 79 patologías crónicas), y el 27 % de los pacientes se queda
  sin ninguna condición mapeada.
- **Pacientes con una sola condición:** 178 de los 368 pacientes con inferencia tienen 1
  condición mapeada. Con Jaccard hay cientos de vecinos con la misma similitud (mediana
  0,50), y el desempate lo decide el orden de la matriz (por edad).
- **Significado de `edad` en CAMDA:** el dataset original no tiene fechas. Al convertirlo a
  OMOP se fijó `year_of_birth = 2022 − edad máxima` y los diagnósticos caen el 1 de enero
  de `year_of_birth + edad`. Por construcción, en todos los pacientes de CAMDA el último
  diagnóstico coincide con su `edad` (100 %), y el 46,6 % de todos los diagnósticos caen
  en esa última edad. `edad` en CAMDA es, por tanto, la edad de la última visita, no una
  edad actual real.
- **Efecto en la inferencia:** 370 de las 765 estimaciones (48 %) salen iguales a la edad
  actual del paciente, porque la mediana de los vecinos supera su edad y se recorta con el
  límite superior. Esas estimaciones no son informativas.
- **Posibles mejoras:** estimar en *años antes del final* (`edad_vecino − edad_dx`) en lugar
  de edad absoluta, desempatar la similitud por cercanía de edad y usar como vecinos solo
  pacientes de CAMDA con al menos 2 edades distintas de diagnóstico.
- **Relaciones débiles:** las relaciones `B_padre_de_A` y las de nivel 3 o superior son las más
  dudosas y conviene revisarlas una a una (columna `revision`).
- **Edades enteras:** al caer los diagnósticos de CAMDA el 1 de enero, las edades son
  años enteros y las medianas pueden salir con .5.

## Ejecución

Desde `inference/`, con el entorno `tfm_env` activado y los contenedores en marcha:

```bash
python data_extract/extract_camda_dataset.py --db camda --port 5435 --password <pwd>
python data_extract/extract_granada_dataset.py --db omop_cdm --port 5434 --ref-year 2022 --password <pwd>
python ancestor/jerarqy_mapping.py
python matrix/create_condition_matrix.py
python similitud/infer_age.py --k 50 --age-window 5
python validation/validation_similitud.py
```

Las rutas de entrada y salida de los scripts son relativas al directorio desde el que se
ejecutan: ajústalas si cambias de carpeta.

## Referencia

El script de inferencia del orden temporal que sirvió de punto de partida
(`infer_temporal_diagnoses.py`, modelo pairwise P(A antes que B)) dio, con cobertura
directa, una validación interna en CAMDA de pairwise accuracy 78,9 % y exact sequence
accuracy 56,7 %, pero solo 15 de 505 pacientes de Granada con secuencia inferida.