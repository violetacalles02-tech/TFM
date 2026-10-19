{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS cohort_definition_id,
    NULL::INTEGER AS subject_id,
    NULL::DATE AS cohort_start_date,
    NULL::DATE AS cohort_end_date

WHERE
    FALSE