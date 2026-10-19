-- cdm_source

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_cdm_source') }}