-- cohort

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_cohort') }}