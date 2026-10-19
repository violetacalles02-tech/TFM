{%- macro vocabulary_version() -%}
 (select vocabulary_version
    from vocabularies.vocabulary
    where vocabulary_id = 'None')
{%- endmacro -%}