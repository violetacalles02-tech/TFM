{{ config(materialized='table') }}

SELECT
    NULL::INTEGER AS cost_id,
    NULL::INTEGER AS cost_event_id,
    NULL::TEXT AS cost_domain_id,
    NULL::INTEGER AS cost_type_concept_id,
    NULL::INTEGER AS currency_concept_id,
    NULL::DOUBLE PRECISION AS total_charge,
    NULL::DOUBLE PRECISION AS total_cost,
    NULL::DOUBLE PRECISION AS total_paid,
    NULL::DOUBLE PRECISION AS paid_by_payer,
    NULL::DOUBLE PRECISION AS paid_by_patient,
    NULL::DOUBLE PRECISION AS paid_patient_copay,
    NULL::DOUBLE PRECISION AS paid_patient_coinsurance,
    NULL::DOUBLE PRECISION AS paid_patient_deductible,
    NULL::DOUBLE PRECISION AS paid_by_primary,
    NULL::DOUBLE PRECISION AS paid_ingredient_cost,
    NULL::DOUBLE PRECISION AS paid_dispensing_fee,
    NULL::INTEGER AS payer_plan_period_id,
    NULL::DOUBLE PRECISION AS amount_allowed,
    NULL::INTEGER AS revenue_code_concept_id,
    NULL::TEXT AS revenue_code_source_value,
    NULL::INTEGER AS drg_concept_id,
    NULL::TEXT AS drg_source_value
WHERE
    FALSE