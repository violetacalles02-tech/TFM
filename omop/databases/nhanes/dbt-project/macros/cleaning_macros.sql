--------------------------
--   ~~ DATA TYPES   ~~ --
--------------------------
-- Macro to check if a column has integer-type values and if not, set it as NULL
{% macro str_to_int(num) %}
(CASE WHEN {{ num }} ~ '^[0-9]+$' THEN {{ num }}::int
      ELSE null::int
      END)
{% endmacro %}

-- Macro to check if a column has float-type values and if not, set it as NULL
{% macro str_to_dec(num) %}
(CASE WHEN {{ num }} ~ '^-?[0-9]\d*(\.\d+)?$' THEN {{ num }}::decimal
      ELSE null::int
      END)
{% endmacro %}


--------------------------
-- ~~ DATES AND TIME ~~ --
--------------------------

-- Macro to transform string-type date ('YYYYMMMDD') to date data-type
{% macro str_to_date(fecha) %}
(CASE WHEN {{ fecha }} ~ '^(19|20)\d\d(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$'
      THEN to_date({{ fecha }},'YYYYMMDD')
      ELSE null::date
      END)
{% endmacro %}

-- Macro to transform string-type date and time columns to timestamp format
{% macro str_to_timestamp(fecha, hora) %}
(CASE WHEN {{ fecha }} ~ '^(19|20)\d\d(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$'
      AND  {{ hora }} ~ '^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$'
      THEN to_timestamp({{ fecha }} || ' ' || {{ hora }}, 'YYYYMMDD HH24:MI')
      WHEN {{ fecha }} ~ '^(19|20)\d\d(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])$'
      THEN to_timestamp({{ fecha }} || ' 00:00', 'YYYYMMDD HH24:MI')
      ELSE null::timestamp
      END)
{% endmacro %}


--------------------------
--     ~~ OTHERS ~~     --
--------------------------

-- Macro to transform not-null empty values (e.g. '') to NULL
{% macro null_conversion(column_name, null_value)  %}
(CASE WHEN {{ column_name }} = {{ null_value }} THEN NULL
      ELSE {{ column_name }}
      END)
{% endmacro %}

-- Macro to clean age column from strings (e.g. 80 años, 79E...)
{% macro clean_age(age) %}
(CASE WHEN {{ age }} != '' THEN substring({{age}} from '(\d*).*')::int
      ELSE null::int
      END)
{% endmacro %}


--------------------------
--   ~~ CLEANUP ~~      --
--------------------------

-- Macro to clean up all temporary quality models (leaving only final target tables/views)
{% macro clean_temp_quality_models() %}
    {% if execute %}
        {% set search_schema = env_var('OMOP_DQ_RESULTS_SCHEMA') %}
        
        {{ log("Starting cleanup of all temporary quality models in schema: " ~ search_schema, info=True) }}
        
        {% set query %}
            SELECT table_name, table_type
            FROM information_schema.tables
            WHERE table_schema = '{{ search_schema }}'
              AND table_name NOT IN (
                'achilles_analysis',
                'achilles_results',
                'achilles_results_dist',
                'dqdashboard_results',
                'achilles_performance'
              )
        {% endset %}
        
        {% set results = run_query(query) %}
        
        {% if results and results.rows | length > 0 %}
            {{ log("Found " ~ results.rows | length ~ " temporary relations to drop.", info=True) }}
            {% for row in results.rows %}
                {% set rel_name = row[0] %}
                {% set rel_type = row[1] %}
                
                {% if rel_type == 'VIEW' %}
                    {% set drop_cmd = 'DROP VIEW IF EXISTS ' ~ search_schema ~ '.' ~ rel_name ~ ' CASCADE' %}
                {% else %}
                    {% set drop_cmd = 'DROP TABLE IF EXISTS ' ~ search_schema ~ '.' ~ rel_name ~ ' CASCADE' %}
                {% endif %}
                
                {{ log("Dropping temporary " ~ rel_type ~ ": " ~ rel_name, info=True) }}
                {% do run_query(drop_cmd) %}
            {% endfor %}
            {{ log("Cleanup completed successfully.", info=True) }}
        {% else %}
            {{ log("No temporary relations found to clean up in " ~ search_schema, info=True) }}
        {% endif %}
    {% endif %}
{% endmacro %}