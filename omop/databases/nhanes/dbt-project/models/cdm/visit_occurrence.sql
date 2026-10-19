-- visit_occurrence

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_visit_occurrence') }}