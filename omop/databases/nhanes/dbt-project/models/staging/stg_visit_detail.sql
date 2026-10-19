{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS visit_detail_id,
    NULL::INTEGER AS person_id,
    NULL::INTEGER AS visit_detail_concept_id,
    NULL::DATE AS visit_detail_start_date,
    NULL::TIMESTAMP AS visit_detail_start_datetime,
    NULL::DATE AS visit_detail_end_date,
    NULL::TIMESTAMP AS visit_detail_end_datetime,
    NULL::INTEGER AS visit_detail_type_concept_id,
    NULL::INTEGER AS provider_id,
    NULL::INTEGER AS care_site_id,
    NULL::TEXT AS visit_detail_source_value,
    NULL::INTEGER AS visit_detail_source_concept_id,
    NULL::INTEGER AS admitted_from_concept_id,
    NULL::TEXT AS admitted_from_source_value,
    NULL::TEXT AS discharged_to_source_value,
    NULL::INTEGER AS discharged_to_concept_id,
    NULL::INTEGER AS preceding_visit_detail_id,
    NULL::INTEGER AS parent_visit_detail_id,
    NULL::INTEGER AS visit_occurrence_id
WHERE
    FALSE