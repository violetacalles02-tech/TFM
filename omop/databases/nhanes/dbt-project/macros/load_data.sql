{% macro load_data(source_data_path='/data') %}
{% set create_sql %}

  drop schema if exists raw cascade;

  create schema raw;

--   create table raw.allergies
--   (
--       start       date,
--       stop        date,
--       patient     text,
--       encounter   text,
--       code        text,
--       system      text,
--       description text,
--       type        text,
--       category  text,
--       reaction1   text,
--       description1 text,
--       severity1   text,
--       reaction2   text,
--       description2 text,
--       severity2   text
--   );

{% endset %}

{% set copy_sql %}

-- COPY raw.patients ("id", "birthdate", "deathdate", "ssn", "drivers", "passport", "prefix", "first", "middle", "last", "suffix", "maiden", "marital", "race", "ethnicity", "gender", "birthplace", "address", "city", "state", "county", "fips", "zip", "lat", "lon", "healthcare_expenses", "healthcare_coverage", "income")
-- FROM '{{ source_data_path }}/patients.csv'
-- WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE E'\b', ESCAPE E'\\');

{% endset %}

{% do run_query(create_sql) %}
{% do log("Source data tables created!", info=True) %}

{% do run_query(copy_sql) %}
{% do log("Source data loaded!", info=True) %}
{% endmacro %}
