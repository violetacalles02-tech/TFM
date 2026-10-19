-- stg_visit_occurrence

{{ config(materialized='table') }}

SELECT
NULL::INTEGER AS visit_occurrence_id,
NULL::INTEGER AS person_id,
NULL::INTEGER AS visit_concept_id,
NULL::DATE AS visit_start_date,
NULL::TIMESTAMP AS visit_start_datetime,
NULL::DATE AS visit_end_date,
NULL::TIMESTAMP AS visit_end_datetime,
NULL::INTEGER AS visit_type_concept_id,
NULL::INTEGER AS provider_id,
NULL::INTEGER AS care_site_id,
NULL::TEXT AS visit_source_value,
NULL::INTEGER AS visit_source_concept_id,
NULL::INTEGER AS admitted_from_concept_id,
NULL::TEXT AS admitted_from_source_value,
NULL::INTEGER AS discharged_to_concept_id,
NULL::TEXT AS discharged_to_source_value,
NULL::INTEGER AS preceding_visit_occurrence_id
WHERE
    FALSE