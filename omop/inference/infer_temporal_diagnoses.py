#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
INFERENCIA DEL ORDEN TEMPORAL DE DIAGNOSTICOS
==============================================

Este script transfiere informacion temporal desde un Dataset A longitudinal
a un Dataset B que contiene diagnosticos sin edad de diagnostico.

DATASET A (entrenamiento)
-------------------------
Columnas obligatorias:
    patient_id
    sexo
    edad
    condition_id
    edad_al_diagnostico

DATASET B (objetivo)
--------------------
Columnas obligatorias:
    patient_id
    sexo
    edad
    condition_id

IDEA DEL MODELO
---------------
Para cada pareja de diagnosticos A y B observada en Dataset A aprendemos:

    P(A ocurre antes que B | A y B estan presentes)

Tambien almacenamos:
    - numero de pacientes que soportan la relacion
    - diagnosticos simultaneos
    - mediana del intervalo temporal
    - percentiles 25 y 75 del intervalo temporal

Para un paciente del Dataset B con diagnosticos:

    {A, B, C, D}

calculamos todas las comparaciones:

    A vs B
    A vs C
    A vs D
    B vs C
    B vs D
    C vs D

y obtenemos un ranking temporal global.

CODIGOS NO PRESENTES EN DATASET A
---------------------------------
Los condition_id de Dataset B que nunca aparecen en Dataset A se excluyen
de la inferencia, porque el modelo no tiene informacion temporal sobre ellos.

Se guardan en:
    excluded_conditions.csv

Tambien se calcula coverage por paciente:

    coverage = diagnosticos conocidos / diagnosticos originales

SALIDAS
-------
El directorio indicado en --output contendra:

    pairwise_model.csv
        Modelo temporal aprendido.

    inferred_conditions.csv
        Una fila por diagnostico conocido del Dataset B con su posicion
        temporal inferida.

    inferred_sequences.csv
        Una fila por paciente con la secuencia inferida.

    excluded_conditions.csv
        Diagnosticos de B no presentes en A.

    patient_coverage.csv
        Cobertura de diagnosticos conocidos por paciente.

    validation_metrics.csv
        Metricas obtenidas ocultando la temporalidad de una fraccion de A,
        si se usa --validate.

DEPENDENCIAS
------------
    pip install pandas numpy

EJEMPLO
-------
    python infer_temporal_diagnoses.py \
        --train dataset_a.csv \
        --target dataset_b.csv \
        --output resultados \
        --validate 0.20

NOTA
----
Este es un baseline estadistico interpretable. La secuencia inferida es la
secuencia mas compatible con los patrones observados en Dataset A; no debe
interpretarse como la historia clinica real del paciente.
"""

import argparse
from itertools import combinations
from pathlib import Path

import numpy as np
import pandas as pd


# ============================================================================
# 1. COLUMNAS OBLIGATORIAS
# ============================================================================

TRAIN_COLUMNS = {
    "patient_id",
    "sexo",
    "edad",
    "condition_id",
    "edad_al_diagnostico",
}

TARGET_COLUMNS = {
    "patient_id",
    "sexo",
    "edad",
    "condition_id",
}


# ============================================================================
# 2. FUNCIONES DE LECTURA
# ============================================================================

def read_table(path):
    """
    Lee CSV, TSV o Parquet segun la extension del fichero.
    """
    path = Path(path)
    extension = path.suffix.lower()

    if extension == ".csv":
        return pd.read_csv(path)

    if extension in {".tsv", ".txt"}:
        return pd.read_csv(path, sep="\t")

    if extension == ".parquet":
        return pd.read_parquet(path)

    raise ValueError(
        f"Formato no soportado: {extension}. "
        "Usa .csv, .tsv, .txt o .parquet"
    )


def check_columns(df, required, dataset_name):
    """
    Comprueba que existen todas las columnas obligatorias.
    """
    missing = required - set(df.columns)

    if missing:
        raise ValueError(
            f"{dataset_name}: faltan columnas obligatorias: "
            f"{sorted(missing)}"
        )


# ============================================================================
# 3. LIMPIEZA DEL DATASET A
# ============================================================================

def clean_train(df):
    """
    Limpia Dataset A.

    Decisiones:
    - condition_id se trata como string para evitar problemas entre int/string.
    - sexo desconocido se convierte en 'UNKNOWN'.
    - si un paciente tiene varias apariciones del mismo condition_id,
      conservamos la primera edad de diagnostico.
    """

    check_columns(df, TRAIN_COLUMNS, "Dataset A")

    df = df.copy()

    df["condition_id"] = df["condition_id"].astype(str)
    df["sexo"] = df["sexo"].fillna("UNKNOWN").astype(str)

    df["edad"] = pd.to_numeric(
        df["edad"],
        errors="coerce",
    )

    df["edad_al_diagnostico"] = pd.to_numeric(
        df["edad_al_diagnostico"],
        errors="coerce",
    )

    # Sin paciente, diagnostico o edad de diagnostico no podemos entrenar.
    df = df.dropna(
        subset=[
            "patient_id",
            "condition_id",
            "edad_al_diagnostico",
        ]
    )

    # Ordenamos y conservamos la primera aparicion de cada diagnostico.
    df = (
        df.sort_values(
            ["patient_id", "edad_al_diagnostico"]
        )
        .drop_duplicates(
            ["patient_id", "condition_id"],
            keep="first",
        )
    )

    return df


# ============================================================================
# 4. LIMPIEZA DEL DATASET B
# ============================================================================

def clean_target(df):
    """
    Limpia Dataset B.

    En este dataset no conocemos edad_al_diagnostico.
    Solo necesitamos saber que condition_id estan presentes.
    """

    check_columns(df, TARGET_COLUMNS, "Dataset B")

    df = df.copy()

    df["condition_id"] = df["condition_id"].astype(str)
    df["sexo"] = df["sexo"].fillna("UNKNOWN").astype(str)

    df["edad"] = pd.to_numeric(
        df["edad"],
        errors="coerce",
    )

    df = df.dropna(
        subset=["patient_id", "condition_id"]
    )

    # Eliminamos diagnosticos duplicados por paciente.
    df = df.drop_duplicates(
        ["patient_id", "condition_id"]
    )

    return df


# ============================================================================
# 5. FILTRADO DE CONDITION_ID NO CONOCIDOS
# ============================================================================

def filter_unknown_conditions(train, target):
    """
    El modelo solo puede inferir temporalidad para condition_id observados
    en Dataset A.

    Devuelve:
        target_known:
            filas de B cuyo condition_id existe en A

        excluded:
            filas de B cuyo condition_id NO existe en A

        coverage:
            estadisticas de cobertura por paciente
    """

    known_conditions = set(
        train["condition_id"].unique()
    )

    target = target.copy()

    target["known_condition"] = (
        target["condition_id"].isin(known_conditions)
    )

    excluded = target[
        ~target["known_condition"]
    ].copy()

    target_known = target[
        target["known_condition"]
    ].copy()

    # ----------------------------------------------------------------------
    # Cobertura por paciente.
    #
    # Ejemplo:
    #   paciente tiene 10 diagnosticos
    #   8 existen en Dataset A
    #
    #   coverage = 8 / 10 = 0.80
    # ----------------------------------------------------------------------

    original_counts = (
        target.groupby("patient_id")["condition_id"]
        .nunique()
        .rename("n_conditions_original")
    )

    known_counts = (
        target_known.groupby("patient_id")["condition_id"]
        .nunique()
        .rename("n_conditions_known")
    )

    coverage = (
        original_counts
        .to_frame()
        .join(known_counts, how="left")
        .fillna({"n_conditions_known": 0})
        .reset_index()
    )

    coverage["n_conditions_known"] = (
        coverage["n_conditions_known"].astype(int)
    )

    coverage["n_conditions_excluded"] = (
        coverage["n_conditions_original"]
        - coverage["n_conditions_known"]
    )

    coverage["coverage"] = (
        coverage["n_conditions_known"]
        / coverage["n_conditions_original"]
    )

    return target_known, excluded, coverage


# ============================================================================
# 6. UTILIDAD PARA REPRESENTAR UNA PAREJA DE DIAGNOSTICOS
# ============================================================================

def canonical_pair(a, b):
    """
    Devuelve una representacion unica de una pareja.

    Por ejemplo:

        (DIABETES, CKD)
        (CKD, DIABETES)

    se almacenan bajo la misma clave.
    """

    return (a, b) if a <= b else (b, a)


# ============================================================================
# 7. CREACION DE OBSERVACIONES TEMPORALES PAIRWISE
# ============================================================================

def build_pairwise_observations(
    df,
    same_tolerance=0.0,
):
    """
    Construye las relaciones temporales entre todas las parejas de
    diagnosticos de cada paciente.

    Ejemplo:

        HTN       edad 45
        DIABETES  edad 52
        CKD       edad 61

    genera:

        HTN -> DIABETES   delta = 7
        HTN -> CKD        delta = 16
        DIABETES -> CKD   delta = 9

    IMPORTANTE:
    No usamos solo transiciones consecutivas.

    Esto es util porque Dataset B puede tener historias incompletas.
    """

    observations = {}

    def add_observation(
        stratum,
        c1,
        age1,
        c2,
        age2,
    ):
        """
        Anade una observacion a una pareja.

        stratum puede ser:
            '__ALL__'  -> modelo global
            'M'/'F'/... -> modelo por sexo
        """

        x, y = canonical_pair(c1, c2)

        key = (
            stratum,
            x,
            y,
        )

        if key not in observations:

            observations[key] = {
                "x_before_y": 0,
                "y_before_x": 0,
                "same": 0,
                "delta_x_to_y": [],
                "delta_y_to_x": [],
            }

        info = observations[key]

        # Diagnosticos simultaneos o suficientemente cercanos.
        if abs(age1 - age2) <= same_tolerance:

            info["same"] += 1
            return

        # Determinamos cual ocurrio primero.
        if age1 < age2:

            before = c1
            delta = age2 - age1

        else:

            before = c2
            delta = age1 - age2

        if before == x:

            info["x_before_y"] += 1
            info["delta_x_to_y"].append(delta)

        else:

            info["y_before_x"] += 1
            info["delta_y_to_x"].append(delta)

    # ----------------------------------------------------------------------
    # Recorremos los pacientes.
    # ----------------------------------------------------------------------

    for _, patient in df.groupby(
        "patient_id",
        sort=False,
    ):

        records = patient[
            [
                "condition_id",
                "edad_al_diagnostico",
                "sexo",
            ]
        ].to_dict("records")

        # Con un solo diagnostico no existen parejas.
        if len(records) < 2:
            continue

        sexo = records[0]["sexo"]

        # Todas las combinaciones de dos diagnosticos.
        for r1, r2 in combinations(
            records,
            2,
        ):

            c1 = r1["condition_id"]
            c2 = r2["condition_id"]

            if c1 == c2:
                continue

            age1 = float(
                r1["edad_al_diagnostico"]
            )

            age2 = float(
                r2["edad_al_diagnostico"]
            )

            # Modelo global.
            add_observation(
                "__ALL__",
                c1,
                age1,
                c2,
                age2,
            )

            # Modelo especifico por sexo.
            add_observation(
                sexo,
                c1,
                age1,
                c2,
                age2,
            )

    return observations


# ============================================================================
# 8. CONVERTIR OBSERVACIONES EN MODELO ESTADISTICO
# ============================================================================

def summarize_pairwise_model(
    observations,
    alpha=1.0,
):
    """
    Convierte los conteos en una tabla de probabilidades.

    Utilizamos Laplace smoothing:

        P(X antes Y) =
            (N_XY + alpha)
            -------------------------
            (N_XY + N_YX + 2*alpha)

    Esto evita probabilidades exactamente 0 o 1 cuando el soporte es pequeno.

    Para el tiempo guardamos:
        mediana
        percentil 25
        percentil 75

    Son mas robustos que media/std para distribuciones temporales asimetricas.
    """

    rows = []

    def safe_stat(values, func):

        if len(values) == 0:
            return np.nan

        return float(
            func(np.asarray(values, dtype=float))
        )

    for (
        stratum,
        x,
        y,
    ), info in observations.items():

        nx = info["x_before_y"]
        ny = info["y_before_x"]
        nsame = info["same"]

        n_ordered = nx + ny

        p_x_before_y = (
            (nx + alpha)
            /
            (n_ordered + 2 * alpha)
        )

        dx = info["delta_x_to_y"]
        dy = info["delta_y_to_x"]

        rows.append({

            "stratum": stratum,

            "condition_x": x,
            "condition_y": y,

            "n_total": (
                nx
                + ny
                + nsame
            ),

            "n_ordered": n_ordered,

            "n_same": nsame,

            "n_x_before_y": nx,
            "n_y_before_x": ny,

            "p_x_before_y": p_x_before_y,

            "median_delta_x_to_y":
                safe_stat(dx, np.median),

            "p25_delta_x_to_y":
                safe_stat(
                    dx,
                    lambda z: np.quantile(
                        z,
                        0.25,
                    ),
                ),

            "p75_delta_x_to_y":
                safe_stat(
                    dx,
                    lambda z: np.quantile(
                        z,
                        0.75,
                    ),
                ),

            "median_delta_y_to_x":
                safe_stat(dy, np.median),

            "p25_delta_y_to_x":
                safe_stat(
                    dy,
                    lambda z: np.quantile(
                        z,
                        0.25,
                    ),
                ),

            "p75_delta_y_to_x":
                safe_stat(
                    dy,
                    lambda z: np.quantile(
                        z,
                        0.75,
                    ),
                ),
        })

    return pd.DataFrame(rows)


def create_lookup(model_df):
    """
    Convierte el DataFrame del modelo en un diccionario para consultas rapidas.
    """

    return {
        (
            row.stratum,
            row.condition_x,
            row.condition_y,
        ): row

        for row in model_df.itertuples(
            index=False
        )
    }


# ============================================================================
# 9. CONSULTAR P(A ANTES QUE B)
# ============================================================================

def probability_in_stratum(
    a,
    b,
    stratum,
    lookup,
):
    """
    Devuelve:

        P(A ocurre antes que B)

    para un estrato determinado.
    """

    x, y = canonical_pair(
        a,
        b,
    )

    row = lookup.get(
        (
            stratum,
            x,
            y,
        )
    )

    if row is None:
        return None, 0

    p_xy = float(
        row.p_x_before_y
    )

    # Si preguntamos X antes Y:
    if a == x:
        return (
            p_xy,
            int(row.n_ordered),
        )

    # Si preguntamos Y antes X:
    return (
        1.0 - p_xy,
        int(row.n_ordered),
    )


def probability_before(
    a,
    b,
    sexo,
    lookup,
    shrinkage_k=100.0,
):
    """
    Combina:

        P(A antes B | todos)
        P(A antes B | sexo)

    usando shrinkage.

    Esto evita confiar demasiado en subgrupos pequenos.

        weight =
            n_sexo / (n_sexo + k)

    Ejemplo con k=100:

        n_sexo = 10
            -> principalmente modelo global

        n_sexo = 100
            -> aproximadamente 50/50

        n_sexo = 1000
            -> principalmente modelo por sexo
    """

    p_global, n_global = (
        probability_in_stratum(
            a,
            b,
            "__ALL__",
            lookup,
        )
    )

    p_sex, n_sex = (
        probability_in_stratum(
            a,
            b,
            sexo,
            lookup,
        )
    )

    # Nunca hemos observado esta pareja.
    if (
        p_global is None
        and p_sex is None
    ):
        return 0.5, 0

    # Solo existe informacion por sexo.
    if p_global is None:
        return p_sex, n_sex

    # Solo existe informacion global.
    if p_sex is None:
        return p_global, n_global

    weight = (
        n_sex
        /
        (n_sex + shrinkage_k)
    )

    probability = (
        weight * p_sex
        +
        (1.0 - weight)
        * p_global
    )

    return (
        probability,
        n_global,
    )


# ============================================================================
# 10. RANKING TEMPORAL DE LOS DIAGNOSTICOS
# ============================================================================

def rank_conditions(
    conditions,
    sexo,
    lookup,
    shrinkage_k=100.0,
):
    """
    Ordena los diagnosticos de un paciente.

    Para cada pareja A/B calculamos:

        P(A antes B)

    y transformamos la probabilidad en log-odds:

        log(P / (1-P))

    Una comparacion:

        P = 0.95

    aporta mucha mas evidencia que:

        P = 0.52

    El score final de cada diagnostico combina todas sus comparaciones
    con el resto de diagnosticos del paciente.
    """

    # Eliminar posibles duplicados conservando orden.
    conditions = list(
        dict.fromkeys(conditions)
    )

    scores = {
        condition: 0.0
        for condition in conditions
    }

    evidence = {
        condition: 0
        for condition in conditions
    }

    # Todas las parejas.
    for a, b in combinations(
        conditions,
        2,
    ):

        probability, support = (
            probability_before(
                a,
                b,
                sexo,
                lookup,
                shrinkage_k,
            )
        )

        # Evitamos log(0).
        probability = np.clip(
            probability,
            1e-6,
            1 - 1e-6,
        )

        log_odds = np.log(
            probability
            /
            (1.0 - probability)
        )

        # Si A suele ocurrir antes:
        #   A gana score
        #   B pierde score
        scores[a] += log_odds
        scores[b] -= log_odds

        if support > 0:

            evidence[a] += 1
            evidence[b] += 1

    # Mayor score = diagnostico estimado mas temprano.
    ordered = sorted(
        conditions,
        key=lambda c: scores[c],
        reverse=True,
    )

    return (
        ordered,
        scores,
        evidence,
    )


# ============================================================================
# 11. INFERENCIA DEL DATASET B
# ============================================================================

def infer_target(
    target_known,
    coverage,
    lookup,
    shrinkage_k=100.0,
):
    """
    Aplica el modelo a todos los pacientes de Dataset B.

    Produce:
        inferred_conditions:
            una fila por condition_id

        inferred_sequences:
            una fila por paciente
    """

    condition_rows = []
    sequence_rows = []

    coverage_lookup = (
        coverage
        .set_index("patient_id")
        .to_dict("index")
    )

    # Procesamos todos los pacientes originales.
    all_patient_ids = coverage["patient_id"].tolist()

    grouped = {
        patient_id: group
        for patient_id, group
        in target_known.groupby(
            "patient_id",
            sort=False,
        )
    }

    for patient_id in all_patient_ids:

        cov = coverage_lookup[
            patient_id
        ]

        patient = grouped.get(
            patient_id
        )

        # ------------------------------------------------------------------
        # Caso 1: ningun diagnostico conocido.
        # ------------------------------------------------------------------

        if patient is None or len(patient) == 0:

            sequence_rows.append({

                "patient_id":
                    patient_id,

                "inference_status":
                    "no_known_conditions",

                "n_conditions_original":
                    cov["n_conditions_original"],

                "n_conditions_known":
                    0,

                "n_conditions_excluded":
                    cov["n_conditions_excluded"],

                "coverage":
                    cov["coverage"],

                "inferred_sequence":
                    "",
            })

            continue

        sexo = patient["sexo"].iloc[0]

        conditions = (
            patient["condition_id"]
            .astype(str)
            .tolist()
        )

        # ------------------------------------------------------------------
        # Caso 2: solo queda un diagnostico.
        # No existe orden temporal que inferir.
        # ------------------------------------------------------------------

        if len(conditions) == 1:

            ordered = conditions
            scores = {
                conditions[0]: 0.0
            }

            evidence = {
                conditions[0]: 0
            }

            status = (
                "single_known_condition"
            )

        # ------------------------------------------------------------------
        # Caso 3: dos o mas diagnosticos.
        # ------------------------------------------------------------------

        else:

            (
                ordered,
                scores,
                evidence,
            ) = rank_conditions(
                conditions,
                sexo,
                lookup,
                shrinkage_k,
            )

            status = "inferred"

        # Guardamos una fila por diagnostico.
        for position, condition in enumerate(
            ordered,
            start=1,
        ):

            condition_rows.append({

                "patient_id":
                    patient_id,

                "sexo":
                    sexo,

                "edad":
                    patient["edad"].iloc[0],

                "condition_id":
                    condition,

                "inferred_position":
                    position,

                "temporal_score":
                    scores[condition],

                "n_pairwise_evidence":
                    evidence[condition],

                "coverage":
                    cov["coverage"],
            })

        # Secuencia completa como texto.
        sequence_rows.append({

            "patient_id":
                patient_id,

            "inference_status":
                status,

            "n_conditions_original":
                cov["n_conditions_original"],

            "n_conditions_known":
                cov["n_conditions_known"],

            "n_conditions_excluded":
                cov["n_conditions_excluded"],

            "coverage":
                cov["coverage"],

            "inferred_sequence":
                " -> ".join(ordered),
        })

    return (
        pd.DataFrame(condition_rows),
        pd.DataFrame(sequence_rows),
    )


# ============================================================================
# 12. VALIDACION INTERNA
# ============================================================================

def validate_model(
    train,
    validation_fraction,
    random_state,
    shrinkage_k,
):
    """
    Validacion tipo knowledge-transfer.

    1. Separamos pacientes de Dataset A en train/test.
    2. Entrenamos el modelo temporal solo con train.
    3. En test ocultamos edad_al_diagnostico.
    4. Inferimos el orden usando solo los condition_id.
    5. Comparamos el orden predicho con el orden verdadero.

    Metrica principal:
        pairwise_accuracy

    Para cada pareja de diagnosticos comprobamos si el modelo recupera
    correctamente cual ocurrio primero.
    """

    rng = np.random.default_rng(
        random_state
    )

    patient_ids = (
        train["patient_id"]
        .drop_duplicates()
        .to_numpy()
    )

    rng.shuffle(patient_ids)

    n_test = max(
        1,
        int(
            len(patient_ids)
            * validation_fraction
        ),
    )

    test_ids = set(
        patient_ids[:n_test]
    )

    validation_train = train[
        ~train["patient_id"].isin(
            test_ids
        )
    ]

    validation_test = train[
        train["patient_id"].isin(
            test_ids
        )
    ]

    observations = (
        build_pairwise_observations(
            validation_train
        )
    )

    model_df = (
        summarize_pairwise_model(
            observations
        )
    )

    lookup = create_lookup(
        model_df
    )

    correct_pairs = 0
    total_pairs = 0

    patients_evaluated = 0
    exact_sequences = 0

    for _, patient in (
        validation_test.groupby(
            "patient_id"
        )
    ):

        patient = (
            patient
            .sort_values(
                "edad_al_diagnostico"
            )
        )

        # No evaluamos empates temporales en este baseline.
        patient = (
            patient
            .drop_duplicates(
                "edad_al_diagnostico",
                keep="first",
            )
        )

        if len(patient) < 2:
            continue

        sexo = patient["sexo"].iloc[0]

        true_order = (
            patient["condition_id"]
            .astype(str)
            .tolist()
        )

        predicted_order, _, _ = (
            rank_conditions(
                true_order,
                sexo,
                lookup,
                shrinkage_k,
            )
        )

        patients_evaluated += 1

        if predicted_order == true_order:
            exact_sequences += 1

        predicted_position = {
            condition: i
            for i, condition
            in enumerate(
                predicted_order
            )
        }

        # Comparacion pairwise.
        for a, b in combinations(
            true_order,
            2,
        ):

            total_pairs += 1

            if (
                predicted_position[a]
                <
                predicted_position[b]
            ):
                correct_pairs += 1

    pairwise_accuracy = (
        correct_pairs / total_pairs
        if total_pairs
        else np.nan
    )

    exact_sequence_accuracy = (
        exact_sequences
        / patients_evaluated
        if patients_evaluated
        else np.nan
    )

    return pd.DataFrame([{

        "validation_fraction":
            validation_fraction,

        "n_validation_patients":
            patients_evaluated,

        "n_evaluated_pairs":
            total_pairs,

        "pairwise_accuracy":
            pairwise_accuracy,

        "exact_sequence_accuracy":
            exact_sequence_accuracy,
    }])


# ============================================================================
# 13. PROGRAMA PRINCIPAL
# ============================================================================

def main():

    parser = argparse.ArgumentParser(
        description=(
            "Transferencia de temporalidad "
            "entre datasets de diagnosticos."
        )
    )

    parser.add_argument(
        "--train",
        required=True,
        help=(
            "Dataset A con "
            "edad_al_diagnostico."
        ),
    )

    parser.add_argument(
        "--target",
        required=True,
        help=(
            "Dataset B sin "
            "edad_al_diagnostico."
        ),
    )

    parser.add_argument(
        "--output",
        default="resultados_temporales",
        help=(
            "Directorio donde guardar "
            "los resultados."
        ),
    )

    parser.add_argument(
        "--validate",
        type=float,
        default=0.0,
        help=(
            "Fraccion de pacientes de A "
            "para validacion. "
            "Ejemplo: 0.20"
        ),
    )

    parser.add_argument(
        "--shrinkage-k",
        type=float,
        default=100.0,
        help=(
            "Fuerza del shrinkage del "
            "modelo por sexo hacia el global."
        ),
    )

    parser.add_argument(
        "--same-tolerance",
        type=float,
        default=0.0,
        help=(
            "Diferencia maxima de edad para "
            "considerar dos diagnosticos simultaneos. "
            "La unidad debe ser la misma que "
            "edad_al_diagnostico."
        ),
    )

    parser.add_argument(
        "--random-state",
        type=int,
        default=42,
    )

    args = parser.parse_args()

    output_dir = Path(
        args.output
    )

    output_dir.mkdir(
        parents=True,
        exist_ok=True,
    )

    # ----------------------------------------------------------------------
    # Leer datasets.
    # ----------------------------------------------------------------------

    print("Leyendo Dataset A...")

    train = clean_train(
        read_table(args.train)
    )

    print("Leyendo Dataset B...")

    target = clean_target(
        read_table(args.target)
    )

    print(
        f"Dataset A: "
        f"{train['patient_id'].nunique():,} pacientes, "
        f"{train['condition_id'].nunique():,} condition_id"
    )

    print(
        f"Dataset B: "
        f"{target['patient_id'].nunique():,} pacientes, "
        f"{target['condition_id'].nunique():,} condition_id"
    )

    # ----------------------------------------------------------------------
    # Filtrar condition_id de B no presentes en A.
    # ----------------------------------------------------------------------

    (
        target_known,
        excluded,
        coverage,
    ) = filter_unknown_conditions(
        train,
        target,
    )

    excluded.to_csv(
        output_dir
        / "excluded_conditions.csv",
        index=False,
    )

    coverage.to_csv(
        output_dir
        / "patient_coverage.csv",
        index=False,
    )

    print()
    print("Cobertura Dataset B")
    print("-------------------")

    print(
        f"Diagnosticos originales: "
        f"{len(target):,}"
    )

    print(
        f"Diagnosticos conocidos:  "
        f"{len(target_known):,}"
    )

    print(
        f"Diagnosticos excluidos:  "
        f"{len(excluded):,}"
    )

    if len(target) > 0:

        print(
            f"Cobertura global:       "
            f"{len(target_known)/len(target):.2%}"
        )

    # ----------------------------------------------------------------------
    # Entrenar modelo temporal con TODO Dataset A.
    # ----------------------------------------------------------------------

    print()
    print(
        "Construyendo modelo temporal pairwise..."
    )

    observations = (
        build_pairwise_observations(
            train,
            same_tolerance=args.same_tolerance,
        )
    )

    pairwise_model = (
        summarize_pairwise_model(
            observations
        )
    )

    pairwise_model.to_csv(
        output_dir
        / "pairwise_model.csv",
        index=False,
    )

    lookup = create_lookup(
        pairwise_model
    )

    print(
        f"Relaciones temporales aprendidas: "
        f"{len(pairwise_model):,}"
    )

    # ----------------------------------------------------------------------
    # Inferencia sobre Dataset B.
    # ----------------------------------------------------------------------

    print()
    print(
        "Infiriendo secuencias en Dataset B..."
    )

    (
        inferred_conditions,
        inferred_sequences,
    ) = infer_target(
        target_known,
        coverage,
        lookup,
        shrinkage_k=args.shrinkage_k,
    )

    inferred_conditions.to_csv(
        output_dir
        / "inferred_conditions.csv",
        index=False,
    )

    inferred_sequences.to_csv(
        output_dir
        / "inferred_sequences.csv",
        index=False,
    )

    # ----------------------------------------------------------------------
    # Validacion opcional.
    # ----------------------------------------------------------------------

    if (
        args.validate > 0
        and args.validate < 1
    ):

        print()
        print(
            "Realizando validacion interna..."
        )

        metrics = validate_model(
            train,
            args.validate,
            args.random_state,
            args.shrinkage_k,
        )

        metrics.to_csv(
            output_dir
            / "validation_metrics.csv",
            index=False,
        )

        print()
        print("Resultados validacion:")
        print(
            metrics.to_string(
                index=False
            )
        )

    # ----------------------------------------------------------------------
    # Resumen final.
    # ----------------------------------------------------------------------

    print()
    print("Proceso terminado.")
    print(
        f"Resultados guardados en: "
        f"{output_dir.resolve()}"
    )

    print()
    print("Ficheros principales:")
    print(
        "  pairwise_model.csv"
    )
    print(
        "  inferred_conditions.csv"
    )
    print(
        "  inferred_sequences.csv"
    )
    print(
        "  excluded_conditions.csv"
    )
    print(
        "  patient_coverage.csv"
    )

    if args.validate > 0:
        print(
            "  validation_metrics.csv"
        )


# ============================================================================
# 14. ENTRY POINT
# ============================================================================

if __name__ == "__main__":
    main()
