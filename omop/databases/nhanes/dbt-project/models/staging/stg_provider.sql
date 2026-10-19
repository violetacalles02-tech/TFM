{{ config(materialized='table') }}

SELECT

    NULL::INTEGER AS provider_id,
    NULL::TEXT AS provider_name,
    NULL::TEXT AS npi,
    NULL::TEXT AS dea,
    NULL::INTEGER AS specialty_concept_id,
    NULL::INTEGER AS care_site_id,
    NULL::INTEGER AS year_of_birth,
    NULL::INTEGER AS gender_concept_id,
    NULL::TEXT AS provider_source_value,
    NULL::TEXT AS specialty_source_value,
    NULL::INTEGER AS specialty_source_concept_id,
    NULL::TEXT AS gender_source_value,
    NULL::INTEGER AS gender_source_concept_id

WHERE
    FALSE