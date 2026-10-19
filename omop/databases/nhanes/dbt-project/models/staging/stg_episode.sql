{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS episode_id,
    NULL::INTEGER AS person_id,
    NULL::INTEGER AS episode_concept_id,
    NULL::DATE AS episode_start_date,
    NULL::TIMESTAMP AS episode_start_datetime,
    NULL::DATE AS episode_end_date,
    NULL::TIMESTAMP AS episode_end_datetime,
    NULL::INTEGER AS episode_parent_id,
    NULL::INTEGER AS episode_number,
    NULL::INTEGER AS episode_object_concept_id,
    NULL::INTEGER AS episode_type_concept_id,
    NULL::TEXT AS episode_source_value,
    NULL::INTEGER AS episode_source_concept_id
WHERE FALSE