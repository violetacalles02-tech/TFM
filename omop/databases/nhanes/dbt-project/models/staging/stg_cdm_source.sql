-- stg_cdm_source

{{
    config(
        materialized="table",
    )
}}


SELECT 
    'Nhanes_Database'::TEXT AS cdm_source_name, 
    'Nhanes'::TEXT AS cdm_source_abbreviation, 
    'TFM'::TEXT AS cdm_holder, 
    'Nhanes Database'::TEXT AS source_description, 
    NULL::TEXT AS source_documentation_reference, 
    NULL::TEXT AS cdm_etl_reference, 
    CURRENT_DATE::DATE AS source_release_date, 
    CURRENT_DATE::DATE AS cdm_release_date, 
    'v5.4'::TEXT AS cdm_version, 
    '0'::INTEGER AS cdm_version_concept_id, 
    'v5.0 30-AUG-24'::TEXT AS vocabulary_version 
