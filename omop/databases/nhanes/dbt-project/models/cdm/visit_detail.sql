-- visit_detail

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_visit_detail') }}