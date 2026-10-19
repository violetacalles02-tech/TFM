-- stg_procedure_occurrence

{{ config(materialized='table') }}

SELECT
NULL::INTEGER AS procedure_occurrence_id,
NULL::INTEGER AS person_id,
NULL::INTEGER AS procedure_concept_id,
NULL::DATE AS procedure_date,
NULL::TIMESTAMP AS procedure_datetime,
NULL::DATE AS procedure_end_date,
NULL::TIMESTAMP AS procedure_end_datetime,  
NULL::INTEGER AS procedure_type_concept_id,
NULL::INTEGER AS modifier_concept_id,
NULL::DOUBLE PRECISION AS quantity,
NULL::INTEGER AS provider_id,
NULL::INTEGER AS visit_occurrence_id,
NULL::INTEGER AS visit_detail_id,
NULL::TEXT AS procedure_source_value,
NULL::INTEGER AS procedure_source_concept_id,
NULL::TEXT AS modifier_source_value

WHERE
    FALSE
