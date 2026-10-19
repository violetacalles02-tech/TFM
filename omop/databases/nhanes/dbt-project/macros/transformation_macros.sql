--------------------------
--    ~~ GENERAL ~~     --
--------------------------

-- Macro to create a bigint type ID from a string in absolute value
{% macro bigint_id_from_str(text) %}
    abs(('x' || substr(md5({{ text }}), 1, 16))::bit(64)::bigint)
{% endmacro %}

-- Macro to create a int type ID from a string in absolute value
{% macro int_id_from_str(text) %}
    abs(('x' || substr(md5({{ text }}),1,16))::bit(32)::int)
{% endmacro %}


----------------------------------
--   ~~ DATE FUNCTIONS ~~   --
----------------------------------

-- Macro to calculate the death date from patient's birthdate and age at exitus
{% macro calculate_death_date(birthdate, age_exitus) %}
(CASE WHEN {{ birthdate }} IS NOT NULL AND {{ age_exitus }} IS NOT NULL
      THEN CONCAT(EXTRACT(year from {{ birthdate }}::date) + {{ age_exitus }},'-12-31')
      END)
{% endmacro %}


-----------------------------------
-- ~~ MEASUREMENTS ~~ --
-----------------------------------

-- Macro to add the concept_id for each operator from the value result column for lab tests (if any)
{% macro extract_operator_concept_id(val) %}
(CASE WHEN {{ val }} like '>%' THEN 4172704::int -- ">"  operator
      WHEN {{ val }} like '<%' THEN 4171756::int -- "<"operator
      WHEN {{ val }} like '<=%' THEN 4171754::int -- "<=" operator
      WHEN {{ val }} like '>=%' THEN 4171755::int -- ">=" operator
      WHEN {{ val }} is null THEN 0::int -- No data
      ELSE 4172703::int -- "=" operator
      END)
{% endmacro %}

-- Macro to extract the numerical value from the value result column for lab tests
{% macro extract_numerical_value(val) %}
(CASE
      WHEN {{ val }} similar to '(> |< )%' AND (right({{ val }},  length({{ val }}) - 2)) ~ '^-?[0-9]\d*(\.\d+)?$'
        THEN (right({{ val }},  length({{ val }}) - 1))::decimal -- Remove first two characters
      WHEN {{ val }} similar to '(<= |>= )%' AND (right({{ val }},  length({{ val }}) - 2)) ~ '^-?[0-9]\d*(\.\d+)?$'
        THEN (right({{ val }},  length({{ val }}) - 3))::decimal -- Remove first three characters
      WHEN {{ val }} similar to '(>|<)%' AND (right({{ val }},  length({{ val }}) - 1)) ~ '^-?[0-9]\d*(\.\d+)?$'
        THEN (right({{ val }},  length({{ val }}) - 1))::decimal -- Remove the first character
      WHEN {{ val }} similar to '(<=|>=)%' AND (right({{ val }},  length({{ val }}) - 2)) ~ '^-?[0-9]\d*(\.\d+)?$'
        THEN (right({{ val }},  length({{ val }}) - 2))::decimal -- Remove first two characters
      WHEN {{ val }} ~ '^-?[0-9]\d*(\.\d+)?$'
        THEN {{ val }}::decimal
      ELSE null::decimal -- Categorial/string type values to null
      END)
{% endmacro %}
