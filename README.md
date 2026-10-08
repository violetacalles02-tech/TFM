# TFM: Gemelo virtual para la diabetes

Repositorio del Trabajo Fin de Máster (TFM) orientado a construir un **gemelo virtual (digital twin) para la diabetes** a partir de datos de salud sintéticos.

El trabajo consiste en el análisis de tres datasets de orígenes distintos: **CAMDA**, **NHANES** y **T1DiabetesGranada**; su transformación a **OMOP-CDM** y la combinación de los tres datasets en un único conjunto de datos.

A partir de ese conjunto creamos datos sintéticos con **Synthea** y con un modelado propio, para poder generar pacientes con características determinadas de nuestro interés, y desde esos datos crear el gemelo virtual.

> Autora: Violeta Calles · [Máster en Bioinformática y Ciencia de Datos en Medicina Personalizada y de Precisión - Escuela de Sanidad Carlos III & CNIO] · Tutor/a: [Alberto Labarga]

## Pipeline del proyecto

```
CAMDA ─────────┐
NHANES ────────┼──► Transformación a OMOP-CDM ──► Dataset unificado ──► Datos sintéticos ──► Gemelo virtual
T1DiabetesGranada ┘                                                     (Synthea + modelado propio)
```

1. **Análisis** de los tres datasets de origen.
2. **Transformación a OMOP-CDM** de cada dataset.
3. **Combinación** de los tres en un único conjunto de datos.
4. **Generación de datos sintéticos** con Synthea y con un modelado propio, para crear pacientes con las características deseadas.
5. **Gemelo virtual** de la diabetes construido sobre esos datos.

## Datasets

| Dataset | Origen | Descripción |
|---|---|---|
| **CAMDA** | Reto CAMDA (DualAAE-EHR, diabetes GEN3) | Historias clínicas electrónicas sintéticas de en torno a 1 millón de pacientes, como lista ordenada de visitas con diagnósticos crónicos (81 códigos de patologías, sexo y edad codificados). |
| **NHANES** | Encuesta nacional de salud de EE. UU. (ciclo 2021-2023) | Datos de cuestionarios, exámenes y laboratorio, con diccionarios de variables en CSV y valores en archivos `.xpt`. |
| **T1DiabetesGranada** | Cohorte de diabetes tipo 1 de Granada | Información de pacientes, diagnósticos, mediciones de glucosa y parámetros bioquímicos. |

Sobre CAMDA se ha trabajado además una parte exploratoria de modelado predictivo (complicaciones de la diabetes) y de grafo causal de comorbilidades, disponible en la carpeta `omop/databases/camda/analysis`.

## Transformación a OMOP-CDM

Las transformaciones se construyen con las herramientas habituales del ecosistema OHDSI:

- **PostgreSQL** en contenedores **Docker** como base de datos.
- **dbt** para el ETL (lógica de transformación en `staging`, `cdm` como capa final).
- Vocabularios estándar descargados de **Athena** (SNOMED, LOINC, ICD9CM...).
- **WhiteRabbit / Rabbit-in-a-Hat** para el análisis y diseño del ETL, y **Usagi** para el mapeo de códigos a conceptos estándar.

## Estructura del repositorio

```
TFM/
├── .vscode/       # Configuración del editor
├── omop/          # Transformación y análisis de las tres bases de datos
├── papers/        # Artículos y documentación de referencia
├── testing/       # Pruebas y scripts exploratorios
└── .gitignore
```

> Los archivos de datos pesados (CSV) **no se incluyen** en el repositorio y están excluidos mediante `.gitignore`. Hay que obtenerlos por separado desde las fuentes originales de cada dataset.

## Requisitos

- Linux (probado en este entorno)
- [Conda](https://docs.conda.io/) con un entorno dedicado (`tfm_env`)
- Python (Jupyter notebooks) y R
- Docker y PostgreSQL para las bases de datos OMOP

```bash
git clone https://github.com/violetacalles02-tech/TFM.git
cd TFM
conda activate tfm_env
```

> Si tienes un `environment.yml` o `requirements.txt`, enlázalo aquí para que el entorno se pueda recrear con un solo comando.

## Estado del proyecto

Trabajo en curso. El repositorio se actualiza a medida que avanzan la transformación de los datasets, la generación de datos sintéticos y la construcción del gemelo virtual.

## Licencia

[Pendiente de definir]
