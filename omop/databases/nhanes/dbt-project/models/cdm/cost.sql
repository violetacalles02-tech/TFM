-- cost

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_cost') }}