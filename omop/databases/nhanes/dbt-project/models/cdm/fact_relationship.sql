-- fact_relationship

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_fact_relationship') }}