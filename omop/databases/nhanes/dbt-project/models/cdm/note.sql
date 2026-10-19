-- note

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_note') }}