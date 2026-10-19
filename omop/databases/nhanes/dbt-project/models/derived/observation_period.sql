{{ config(materialized='table') }}

-- Observation period considerations: 
--- A single observation period per person that spans all data available for that person
--- Observation period start date is the first recorded clinical event
--- Observation period end date is the last recorded clinical event
--- EHR as period_type_concept_id (32818)
--- Note: Modify as needed for other approaches

WITH all_events AS (
    -- Get min/max dates from each table separately, then combine
    SELECT person_id, MIN(visit_start_date) AS min_date, MAX(COALESCE(visit_end_date, visit_start_date)) AS max_date
    FROM {{ ref('visit_occurrence') }}
    GROUP BY person_id
    UNION ALL
    SELECT person_id, MIN(condition_start_date) AS min_date, MAX(COALESCE(condition_end_date, condition_start_date)) AS max_date
    FROM {{ ref('condition_occurrence') }}
    GROUP BY person_id
    UNION ALL
    SELECT person_id, MIN(drug_exposure_start_date) AS min_date, MAX(COALESCE(drug_exposure_end_date, drug_exposure_start_date)) AS max_date
    FROM {{ ref('drug_exposure') }}
    GROUP BY person_id
    UNION ALL
    SELECT person_id, MIN(procedure_date) AS min_date, MAX(COALESCE(procedure_end_date, procedure_date)) AS max_date
    FROM {{ ref('procedure_occurrence') }}
    GROUP BY person_id
    UNION ALL
    SELECT person_id, MIN(device_exposure_start_date) AS min_date, MAX(COALESCE(device_exposure_end_date, device_exposure_start_date)) AS max_date
    FROM {{ ref('device_exposure') }}
    GROUP BY person_id
    UNION ALL
    SELECT person_id, MIN(measurement_date) AS min_date, MAX(measurement_date) AS max_date
    FROM {{ ref('measurement') }}
    GROUP BY person_id
    --UNION ALL
    --SELECT person_id, MIN(observation_date) AS min_date, MAX(observation_date) AS max_date
    --FROM {{ ref('observation') }}
    --GROUP BY person_id
)
SELECT
    row_number() OVER (ORDER BY person_id)::BIGINT AS observation_period_id,
    person_id::BIGINT AS person_id,
    MIN(min_date)::DATE AS observation_period_start_date,
    MAX(max_date)::DATE AS observation_period_end_date,
    32818::INT AS period_type_concept_id -- EHR data source
FROM all_events
GROUP BY person_id