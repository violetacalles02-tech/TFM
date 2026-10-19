with source as (

    select * from {{ source('base', 'demo_l') }}

),

pivoted as (

    select
        person_id,
        max(case when upper(variable) = 'RIDAGEYR' then value end)::numeric as ridageyr,
        max(case when upper(variable) = 'RIAGENDR' then value end)::integer as riagendr,
        max(case when upper(variable) = 'RIDRETH1' then value end)::integer as ridreth1

    from source
    group by person_id

),

mapped as (

    select
        person_id::integer                                      as person_id,

        (2022 - ridageyr)::integer                              as year_of_birth,
        null::integer                                           as month_of_birth,
        null::integer                                           as day_of_birth,
        null::timestamp                                         as birth_datetime,

        case riagendr
            when 1 then 8507   -- MALE
            when 2 then 8532   -- FEMALE
            else 8551          -- UNKNOWN
        end::integer                                            as gender_concept_id,

        case ridreth1
            when 3 then 8527   -- White
            when 4 then 8516   -- Black or African American
            when 5 then 8522   -- Other Race
            else 8552          -- Unknown (incluye codigos hispanos)
        end::integer                                            as race_concept_id,

        case
            when ridreth1 in (1, 2) then 38003563  -- Hispanic or Latino
            when ridreth1 in (3, 4, 5) then 38003564 -- Not Hispanic or Latino
            else 0
        end::integer                                            as ethnicity_concept_id,

        null::integer                                           as location_id,
        null::integer                                           as provider_id,
        null::integer                                           as care_site_id,

        person_id::text                                         as person_source_value,
        riagendr::text                                          as gender_source_value,
        0::integer                                              as gender_source_concept_id,
        ridreth1::text                                          as race_source_value,
        0::integer                                              as race_source_concept_id,
        ridreth1::text                                          as ethnicity_source_value,
        0::integer                                              as ethnicity_source_concept_id

    from pivoted

)

select * from mapped