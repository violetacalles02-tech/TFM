-- location

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_location') }}