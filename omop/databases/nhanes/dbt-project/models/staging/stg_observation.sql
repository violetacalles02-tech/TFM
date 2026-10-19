-- Fuente unica: stg_mapping (o stg_mapping), filtrado a domain_id = 'Observation'.
--
-- A diferencia de condition, aqui NO se filtra por expected_value: se
-- incluyen todas las respuestas (numericas o no) 

with usagi as (

    select * from {{ ref('stg_mapping') }}
    where domain_id = 'Observation'

),

mapped as (

    select
        row_number() over (order by person_id, target_concept_id)::integer as observation_id,
        person_id                                                as person_id,
        target_concept_id                                        as observation_concept_id,
        '2021-08-01'::date                                       as observation_date,
        null::timestamp                                          as observation_datetime,
        45905771::integer                                        as observation_type_concept_id,  -- Observation Recorded from a Survey
        value_as_number                                           as value_as_number,
        case when not is_numeric then value_raw else null end   as value_as_string,
        null::integer                                             as value_as_concept_id,
        null::integer                                             as qualifier_concept_id,
        null::integer                                             as unit_concept_id,
        null::integer                                             as provider_id,
        null::integer                                             as visit_occurrence_id,
        null::integer                                             as visit_detail_id,
        source_code                                               as observation_source_value,
        null::integer                                             as observation_source_concept_id,
        null::text                                                as unit_source_value,
        null::text                                                as qualifier_source_value,
        value_raw                                                 as value_source_value,
        null::integer                                             as observation_event_id,
        null::integer                                             as obs_event_field_concept_id

    from usagi

)

select * from mapped