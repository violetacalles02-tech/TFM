{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS note_id,
    NULL::INTEGER AS person_id,
    NULL::DATE AS note_date,
    NULL::TIMESTAMP AS note_datetime,
    NULL::INTEGER AS note_type_concept_id,
    NULL::INTEGER AS note_class_concept_id,
    NULL::TEXT AS note_title,
    NULL::TEXT AS note_text,
    NULL::INTEGER AS encoding_concept_id,
    NULL::INTEGER AS language_concept_id,
    NULL::INTEGER AS provider_id,
    NULL::INTEGER AS visit_occurrence_id,
    NULL::INTEGER AS visit_detail_id,
    NULL::TEXT AS note_source_value,
    NULL::INTEGER AS note_event_id,
    NULL::INTEGER AS note_event_field_concept_id
WHERE
    FALSE