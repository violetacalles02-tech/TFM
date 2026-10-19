-- note_nlp

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_note_nlp') }}