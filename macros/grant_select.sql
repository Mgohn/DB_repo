{% macro grant_select(schema=target.schema, role=target.role) %}

    {% set sql %}
        grant usage on schema {{ schema }} to role {{ role }};
        grant select on all tables in schema {{ schema }} to role {{ role }};
        grant select on all views in schema {{ schema }} to role {{ role }};
    {% endset %}

    {{ log('Granting select privileges to all tables and views in the ' ~ schema ~ ' schema to the ' ~ role ~ ' role.', info=True) }}
    {% do run_query(sql) %}
    {{ log('Privileges granted.', info=True) }}

{% endmacro %}