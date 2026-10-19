{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS payer_plan_period_id,
    NULL::INTEGER AS person_id,
    NULL::DATE AS payer_plan_period_start_date,
    NULL::DATE AS payer_plan_period_end_date,
    NULL::INTEGER AS payer_concept_id,
    NULL::TEXT AS payer_source_value,
    NULL::INTEGER AS payer_source_concept_id,
    NULL::INTEGER AS plan_concept_id,
    NULL::TEXT AS plan_source_value,
    NULL::INTEGER AS plan_source_concept_id,
    NULL::INTEGER AS sponsor_concept_id,
    NULL::TEXT AS sponsor_source_value,
    NULL::INTEGER AS sponsor_source_concept_id,
    NULL::TEXT AS family_source_value,
    NULL::INTEGER AS stop_reason_concept_id,
    NULL::TEXT AS stop_reason_source_value,
    NULL::INTEGER AS stop_reason_source_concept_id
WHERE
    FALSE