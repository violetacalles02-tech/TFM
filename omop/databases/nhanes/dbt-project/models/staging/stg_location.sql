{{ config(materialized='table') }}

SELECT
NULL::INTEGER AS location_id,
NULL::TEXT AS address_1,
NULL::TEXT AS address_2,
NULL::TEXT AS city,
NULL::TEXT AS state,
NULL::TEXT AS zip,
NULL::TEXT AS county,
NULL::TEXT AS location_source_value,
NULL::INTEGER AS country_concept_id,
NULL::TEXT AS country_source_value,
NULL::DOUBLE PRECISION AS latitude,
NULL::DOUBLE PRECISION AS longitude

WHERE
    FALSE