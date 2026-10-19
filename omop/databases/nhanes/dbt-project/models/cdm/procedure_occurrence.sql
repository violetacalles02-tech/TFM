-- procedure_occurrence

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_procedure_occurrence') }}