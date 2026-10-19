-- drug_exposure

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_drug_exposure') }}