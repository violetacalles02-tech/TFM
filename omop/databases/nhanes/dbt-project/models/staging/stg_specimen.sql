{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS specimen_id,
    NULL::INTEGER AS person_id,
    NULL::INTEGER AS specimen_concept_id,
    NULL::INTEGER AS specimen_type_concept_id,
    NULL::DATE AS specimen_date,
    NULL::TIMESTAMP AS specimen_datetime,
    NULL::DOUBLE PRECISION AS quantity,
    NULL::INTEGER AS unit_concept_id,
    NULL::INTEGER AS anatomic_site_concept_id,
    NULL::INTEGER AS disease_status_concept_id,
    NULL::TEXT AS specimen_source_id,
    NULL::TEXT AS specimen_source_value,
    NULL::TEXT AS unit_source_value,
    NULL::TEXT AS anatomic_site_source_value,
    NULL::TEXT AS disease_status_source_value
WHERE
    FALSE