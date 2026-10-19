{{ config(materialized='table') }}

SELECT
NULL::INTEGER AS metadata_id,
NULL::INTEGER AS metadata_concept_id,
NULL::INTEGER AS metadata_type_concept_id,
NULL::TEXT AS name,
NULL::TEXT AS value_as_string,
NULL::INTEGER AS value_as_concept_id,
NULL::DOUBLE PRECISION AS value_as_number,
NULL::DATE AS metadata_date,
NULL::TIMESTAMP AS metadata_datetime

WHERE
    FALSE