-- stg_drug_exposure

{{ config(materialized='table') }}

SELECT
NULL::INTEGER AS drug_exposure_id,
NULL::INTEGER AS person_id,
NULL::INTEGER AS drug_concept_id,
NULL::DATE AS drug_exposure_start_date,
NULL::TIMESTAMP AS drug_exposure_start_datetime,
NULL::DATE AS drug_exposure_end_date,
NULL::TIMESTAMP AS drug_exposure_end_datetime,
NULL::DATE AS verbatim_end_date,
NULL::INTEGER AS drug_type_concept_id,
NULL::TEXT AS stop_reason,
NULL::INTEGER AS refills,
NULL::DOUBLE PRECISION AS quantity,
NULL::INTEGER AS days_supply,
NULL::TEXT AS sig,
NULL::INTEGER AS route_concept_id,
NULL::TEXT AS lot_number,
NULL::INTEGER AS provider_id,
NULL::INTEGER AS visit_occurrence_id,
NULL::INTEGER AS visit_detail_id,
NULL::TEXT AS drug_source_value,
NULL::INTEGER AS drug_source_concept_id,
NULL::TEXT AS route_source_value,
NULL::TEXT AS dose_unit_source_value
WHERE
    FALSE
