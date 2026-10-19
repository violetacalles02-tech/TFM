-- device_exposure

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_device_exposure') }}