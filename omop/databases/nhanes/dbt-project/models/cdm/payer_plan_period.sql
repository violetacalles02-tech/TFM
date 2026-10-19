-- payer_plan_period

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_payer_plan_period') }}