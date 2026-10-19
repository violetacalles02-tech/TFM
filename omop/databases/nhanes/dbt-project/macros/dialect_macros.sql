{% macro datediff(first_date, second_date, datepart=none) %}
  {% if datepart is not none %}
    {# 3-argument call: standard dbt datediff(first_date, second_date, datepart) #}
    {% if target.type == 'postgres' %}
      (cast({{ second_date }} as date) - cast({{ first_date }} as date))
    {% elif target.type == 'redshift' %}
      DATEDIFF({{ datepart }}, {{ first_date }}, {{ second_date }})
    {% else %}
      (cast({{ second_date }} as date) - cast({{ first_date }} as date))
    {% endif %}
  {% else %}
    {# 2-argument call: custom datediff(end_date, start_date) #}
    {% if target.type == 'postgres' %}
      (cast({{ first_date }} as date) - cast({{ second_date }} as date))
    {% elif target.type == 'redshift' %}
      DATEDIFF(day, {{ second_date }}, {{ first_date }})
    {% else %}
      (cast({{ first_date }} as date) - cast({{ second_date }} as date))
    {% endif %}
  {% endif %}
{% endmacro %}

{% macro make_date(year, month, day) %}
  {% if target.type == 'postgres' %}
    make_date({{ year }}::int, {{ month }}::int, {{ day }}::int)
  {% elif target.type == 'redshift' %}
    to_date({{ year }}::varchar || '-' || {{ month }}::varchar || '-' || {{ day }}::varchar, 'YYYY-MM-DD')
  {% else %}
    to_date({{ year }}::varchar || '-' || {{ month }}::varchar || '-' || {{ day }}::varchar, 'YYYY-MM-DD')
  {% endif %}
{% endmacro %}

{% macro last_day(d, datepart=none) %}
  {% if target.type == 'postgres' %}
    ((date_trunc('month', {{ d }}) + interval '1 month' - interval '1 day')::date)
  {% elif target.type == 'redshift' %}
    LAST_DAY({{ d }})
  {% else %}
    LAST_DAY({{ d }})
  {% endif %}
{% endmacro %}

{% macro round(val, scale=0) %}
  {% if target.type == 'postgres' %}
    round(cast({{ val }} as numeric), {{ scale }})
  {% else %}
    round({{ val }}, {{ scale }})
  {% endif %}
{% endmacro %}