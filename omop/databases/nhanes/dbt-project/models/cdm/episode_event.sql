-- episode_event

{{
    config(
        materialized="table",
    )
}}


SELECT * 
FROM {{ ref('stg_episode_event') }}