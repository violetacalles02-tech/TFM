-- person

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_person') }}