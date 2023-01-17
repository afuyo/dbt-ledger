{{
  config(
    materialized='table'
  )
}}

with cartesian_product_similarity as 
(

select 
distinct a.activity_id as activity_id_skandia, 
b.activity_id as activity_id_nordea, 
LEVENSHTEIN(a.activity_id  , b.activity_id) as levenshtein, 
SIMILARITY(a.activity_id,b.activity_id) as similarity 
from {{ ref('enr_skandia_stream') }} a, 
     {{ ref('enr_nordea_stream') }} b 
)
select 
distinct activity_id_skandia, 
activity_id_nordea, levenshtein, 
similarity  from cartesian_product_similarity
where similarity > 0.48