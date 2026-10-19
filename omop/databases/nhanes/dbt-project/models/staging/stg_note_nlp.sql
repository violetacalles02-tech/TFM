{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS note_nlp_id,
    NULL::INTEGER AS note_id,
    NULL::INTEGER AS section_concept_id,
    NULL::TEXT AS snippet,
    NULL::TEXT AS lexical_variant,
    NULL::INTEGER AS note_nlp_concept_id,
    NULL::INTEGER AS note_nlp_source_concept_id,
    NULL::TEXT AS nlp_system,
    NULL::DATE AS nlp_date,
    NULL::TIMESTAMP AS nlp_datetime,
    NULL::TEXT AS term_exists,
    NULL::TEXT AS term_temporal,
    NULL::TEXT AS term_modifiers
WHERE
    FALSE