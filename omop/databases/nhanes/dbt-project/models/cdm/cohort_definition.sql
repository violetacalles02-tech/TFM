-- cohort_definition

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_cohort_definition') }}