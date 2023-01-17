{% set my_list= ['activity_id', 'ts']%}
select 
activity
{%- for col_name in my_list %}
{{col_name}}
{%- if not loop.last -%}, {%- endif -%}
{% endfor %}
from {{ ref('int_account_stream') }}




