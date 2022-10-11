{%- set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] -%}

with payments as (

    select * from {{ ref('stg_payments') }}

),

payment_types as (

    select  
        order_id,
        {% for paym_method in payment_methods -%}
            sum(case when payment_method = '{{ paym_method }}' then amount else 0 end) as {{ paym_method }}_amount

            {%- if not loop.last -%}
                ,
            {%- endif %}
        {% endfor -%}

    from payments

    where status = 'success'

    group by 1

)

select * from payment_types