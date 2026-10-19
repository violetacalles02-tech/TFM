-- Fuente unica: stg_mapping, filtrado a domain_id = 'Measurement'.
--
-- Solo se incluyen filas con valor numerico (is_numeric = true); las que
-- no lo son se descartan 

with usagi as (

    select * from {{ ref('stg_mapping') }}
    where domain_id = 'Measurement'
      and is_numeric = true

),

mapped as (

    select
        row_number() over (order by person_id, target_concept_id)::integer as measurement_id,
        person_id                                                as person_id,
        target_concept_id                                        as measurement_concept_id,
        '2021-08-01'::date                                       as measurement_date,
        null::timestamp                                          as measurement_datetime,
        null::text                                                as measurement_time,
        44818702::integer                                        as measurement_type_concept_id,  -- Lab result
        null::integer                                             as operator_concept_id,
        value_as_number                                           as value_as_number,
        null::integer                                             as value_as_concept_id,
        null::integer                                             as unit_concept_id,
        null::numeric                                             as range_low,
        null::numeric                                             as range_high,
        null::integer                                             as provider_id,
        null::integer                                             as visit_occurrence_id,
        null::integer                                             as visit_detail_id,
        source_code                                               as measurement_source_value,
        null::integer                                             as measurement_source_concept_id,
        null::text                                                as unit_source_value,
        null::integer                                             as unit_source_concept_id,
        value_raw                                                 as value_source_value,
        null::integer                                             as measurement_event_id,
        null::integer                                             as meas_event_field_concept_id

    from usagi

)

select * from mapped