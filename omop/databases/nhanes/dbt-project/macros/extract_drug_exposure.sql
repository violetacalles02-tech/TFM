{% macro extract_drug_exposure_sql(relation, triplets) %}

{%- for triplet in triplets %}

select
    participant_id,
    encounterat,
    '{{ triplet.prefix }}' as exposure_type,
    max(case
        when variable_name = '{{ triplet.start_var }}'
        then to_date(response_value, 'MM/DD/YYYY')
    end) as start_date,
    max(case
        when variable_name = '{{ triplet.source_var }}'
        then response_value
    end) as source_value,
    max(case
        when variable_name = '{{ triplet.end_var }}'
        then to_date(response_value, 'MM/DD/YYYY')
    end) as end_date
from {{ relation }}
where variable_name in (
    '{{ triplet.start_var }}',
    '{{ triplet.source_var }}',
    '{{ triplet.end_var }}'
)
group by participant_id, encounterat

{%- if not loop.last %}
union all
{%- endif %}

{%- endfor %}

{% endmacro %}