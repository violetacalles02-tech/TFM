-- Ruta sugerida: models/staging/stg_mcq_l_long.sql
-- Fuente: raw.mcq_l
--
-- Convierte las columnas Yes/No de condiciones autoinformadas (formato
-- ancho) a formato largo (person_id, variable_name, value), una fila por
-- persona y variable respondida. Solo se despivotan las 13 variables del
-- seed nhanes_mcq_condition_mapping (no todo MCQ_L).

with source as (

    select * from {{ source('raw', 'mcq_l') }}

),

unpivoted as (

    select seqn::integer as person_id, 'MCQ010'::text  as variable_name, mcq010::integer  as value from source
    union all
    select seqn::integer,              'MCQ160a'::text,                  mcq160a::integer          from source
    union all
    select seqn::integer,              'MCQ160b'::text,                  mcq160b::integer          from source
    union all
    select seqn::integer,              'MCQ160c'::text,                  mcq160c::integer          from source
    union all
    select seqn::integer,              'MCQ160d'::text,                  mcq160d::integer          from source
    union all
    select seqn::integer,              'MCQ160e'::text,                  mcq160e::integer          from source
    union all
    select seqn::integer,              'MCQ160f'::text,                  mcq160f::integer          from source
    union all
    select seqn::integer,              'MCQ160l'::text,                  mcq160l::integer          from source
    union all
    select seqn::integer,              'MCQ500'::text,                   mcq500::integer           from source
    union all
    select seqn::integer,              'MCQ160m'::text,                  mcq160m::integer          from source
    union all
    select seqn::integer,              'MCQ160p'::text,                  mcq160p::integer          from source
    union all
    select seqn::integer,              'MCQ220'::text,                   mcq220::integer           from source
    union all
    select seqn::integer,              'MCQ550'::text,                   mcq550::integer           from source

)

select * from unpivoted
where value is not null