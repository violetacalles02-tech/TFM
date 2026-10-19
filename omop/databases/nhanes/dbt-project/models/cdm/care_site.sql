-- care_site

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_care_site') }}