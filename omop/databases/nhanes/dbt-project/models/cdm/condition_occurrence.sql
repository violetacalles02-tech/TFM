-- condition_occurrence

{{
    config(
        materialized="table",
    )
}}


select * from {{ ref('stg_condition_occurrence') }}