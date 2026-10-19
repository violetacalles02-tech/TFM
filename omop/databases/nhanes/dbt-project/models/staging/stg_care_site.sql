-- stg_care_site

{{
    config(
        materialized="table",
    )
}}

SELECT 
    NULL::INTEGER AS care_site_id, 
    NULL::TEXT AS care_site_name, 
    NULL::INTEGER AS place_of_service_concept_id, 
    NULL::INTEGER AS location_id, 
    NULL::TEXT AS care_site_source_value, 
    NULL::TEXT AS place_of_service_source_value 
    
WHERE
    FALSE
