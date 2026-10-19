-- Fuente: 39 tablas de base (pivotadas) + el seed unico usagi_approved_mapping

-- Detecta automaticamente si el valor es numerico (regex) y trae el
-- domain_id del concepto destino desde vocabularies.concept -- eso decide
-- a que tabla CDM va cada fila (Measurement/Condition/Observation).

with seeds as (

    select source_code, target_concept_id, source_code_description, source_domain, source_table, expected_value
    from {{ ref('usagi_approved_mapping') }}

),

combined_long as (

    select person_id, variable, value from {{ source('base', 'agp_l') }}
    union all select person_id, variable, value from {{ source('base', 'alb_cr_l') }}
    union all select person_id, variable, value from {{ source('base', 'alq_l') }}
    union all select person_id, variable, value from {{ source('base', 'bax_l') }}
    union all select person_id, variable, value from {{ source('base', 'biopro_l') }}
    union all select person_id, variable, value from {{ source('base', 'bmx_l') }}
    union all select person_id, variable, value from {{ source('base', 'bpq_l') }}
    union all select person_id, variable, value from {{ source('base', 'bpxo_l') }}
    union all select person_id, variable, value from {{ source('base', 'cbc_l') }}
    union all select person_id, variable, value from {{ source('base', 'diq_l') }}
    union all select person_id, variable, value from {{ source('base', 'far_l') }}
    union all select person_id, variable, value from {{ source('base', 'fertin_l') }}
    union all select person_id, variable, value from {{ source('base', 'ffmr_l') }}
    union all select person_id, variable, value from {{ source('base', 'folate_l') }}
    union all select person_id, variable, value from {{ source('base', 'folfms_l') }}
    union all select person_id, variable, value from {{ source('base', 'ghb_l') }}
    union all select person_id, variable, value from {{ source('base', 'glu_l') }}
    union all select person_id, variable, value from {{ source('base', 'hdl_l') }}
    union all select person_id, variable, value from {{ source('base', 'hepa_l') }}
    union all select person_id, variable, value from {{ source('base', 'hepb_s_l') }}
    union all select person_id, variable, value from {{ source('base', 'hepbd_l') }}
    union all select person_id, variable, value from {{ source('base', 'hepc_l') }}
    union all select person_id, variable, value from {{ source('base', 'hepe_l') }}
    union all select person_id, variable, value from {{ source('base', 'hscrp_l') }}
    union all select person_id, variable, value from {{ source('base', 'huq_l') }}
    union all select person_id, variable, value from {{ source('base', 'ihgem_l') }}
    union all select person_id, variable, value from {{ source('base', 'ins_l') }}
    union all select person_id, variable, value from {{ source('base', 'lux_l') }}
    union all select person_id, variable, value from {{ source('base', 'mcq_l') }}
    union all select person_id, variable, value from {{ source('base', 'paq_l') }}
    union all select person_id, variable, value from {{ source('base', 'pbcd_l') }}
    union all select person_id, variable, value from {{ source('base', 'rhq_l') }}
    union all select person_id, variable, value from {{ source('base', 'smq_l') }}
    union all select person_id, variable, value from {{ source('base', 'tchol_l') }}
    union all select person_id, variable, value from {{ source('base', 'tfr_l') }}
    union all select person_id, variable, value from {{ source('base', 'trigly_l') }}
    union all select person_id, variable, value from {{ source('base', 'tst_l') }}
    union all select person_id, variable, value from {{ source('base', 'vid_l') }}
    union all select person_id, variable, value from {{ source('base', 'vocwb_l') }}

),

concepts as (

    select concept_id, domain_id, standard_concept
    from {{ source('vocabularies', 'concept') }}

),

joined as (

    select
        l.person_id                                              as person_id,
        s.target_concept_id::integer                             as target_concept_id,
        c.domain_id                                               as domain_id,
        s.source_code                                             as source_code,
        s.source_code_description                                 as source_code_description,
        s.expected_value                                          as expected_value,
        l.value                                                   as value_raw,
        l.value ~ '^-?[0-9]+(\.[0-9]+)?$'                        as is_numeric

    from combined_long as l
    inner join seeds as s
        on upper(l.variable) = upper(s.source_code)
    inner join concepts as c
        on c.concept_id = s.target_concept_id
    where c.standard_concept = 'S'

),

mapped as (

    select
        person_id,
        target_concept_id,
        domain_id,
        source_code,
        source_code_description,
        expected_value,
        value_raw,
        is_numeric,
        case when is_numeric then value_raw::numeric else null end as value_as_number

    from joined

)

select * from mapped