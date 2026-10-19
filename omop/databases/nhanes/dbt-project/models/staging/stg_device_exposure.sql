{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS device_exposure_id,
    NULL::INTEGER AS person_id,
    NULL::INTEGER AS device_concept_id,
    NULL::DATE AS device_exposure_start_date,
    NULL::TIMESTAMP AS device_exposure_start_datetime,
    NULL::DATE AS device_exposure_end_date,
    NULL::TIMESTAMP AS device_exposure_end_datetime,
    NULL::INTEGER AS device_type_concept_id,
    NULL::TEXT AS unique_device_id,
    NULL::TEXT AS production_id,
    NULL::INTEGER AS quantity,
    NULL::INTEGER AS provider_id,
    NULL::INTEGER AS visit_occurrence_id,
    NULL::INTEGER AS visit_detail_id,
    NULL::TEXT AS device_source_value,
    NULL::INTEGER AS device_source_concept_id,
    NULL::INTEGER AS unit_concept_id,
    NULL::TEXT AS unit_source_value,
    NULL::INTEGER AS unit_source_concept_id
WHERE
    FALSE