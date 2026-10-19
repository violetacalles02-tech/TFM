{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS episode_id,
    NULL::INTEGER AS event_id,
    NULL::INTEGER AS episode_event_field_concept_id
WHERE
    FALSE