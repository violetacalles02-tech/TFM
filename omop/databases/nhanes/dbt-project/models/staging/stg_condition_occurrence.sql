-- Fuente unica: stg_mapping (o stg_mapping, segun como lo hayas
-- llamado tu), filtrado a domain_id = 'Condition'.
--
-- Solo se genera fila cuando el valor coincide con expected_value (el
-- codigo que representa el diagnostico positivo para esa variable).

with usagi as (

    select * from {{ ref('stg_mapping') }}
    where domain_id = 'Condition'
      and is_numeric = true
      and expected_value is not null
      and value_as_number = expected_value

),

mapped as (

    select
        row_number() over (order by person_id, target_concept_id)::integer as condition_occurrence_id,
        person_id                                                as person_id,
        target_concept_id                                        as condition_concept_id,
        '2021-08-01'::date                                       as condition_start_date,
        null::timestamp                                          as condition_start_datetime,
        null::date                                                as condition_end_date,
        null::timestamp                                          as condition_end_datetime,
        45905770::integer                                        as condition_type_concept_id,  -- Patient Self-Reported Condition
        null::integer                                             as condition_status_concept_id,
        null::text                                                as stop_reason,
        null::integer                                             as provider_id,
        null::integer                                             as visit_occurrence_id,
        null::integer                                             as visit_detail_id,
        source_code || '_' || value_raw                          as condition_source_value,
        null::integer                                             as condition_source_concept_id,
        null::text                                                as condition_status_source_value

    from usagi

)

select * from mapped