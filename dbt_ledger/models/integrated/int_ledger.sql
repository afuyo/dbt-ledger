
{% set results = run_query('select 1 as id') %}

{{
  config(
    materialized='view'
  )
}}

with skandia as (
    select * from  {{ref('enr_skandia')}}

), nordea as (
    select * from {{ref('enr_nordea')}}
)
select * from skandia
union all 
select * from nordea