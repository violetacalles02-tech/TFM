{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS person_id,
    NULL::DATE AS death_date,
    NULL::TIMESTAMP AS death_datetime,
    NULL::INTEGER AS death_type_concept_id,
    NULL::INTEGER AS cause_concept_id,
    NULL::TEXT AS cause_source_value,
    NULL::INTEGER AS cause_source_concept_id
WHERE
    FALSE