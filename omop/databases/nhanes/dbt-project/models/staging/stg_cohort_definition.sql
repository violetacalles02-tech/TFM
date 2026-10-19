{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS cohort_definition_id,
    NULL::TEXT AS cohort_definition_name,
    NULL::TEXT AS cohort_definition_description,
    NULL::INTEGER AS definition_type_concept_id,
    NULL::TEXT AS cohort_definition_syntax,
    NULL::INTEGER AS subject_concept_id,
    NULL::DATE AS cohort_initiation_date
WHERE
    FALSE