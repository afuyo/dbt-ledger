{{
  config(
    materialized='view'
  )
}}

with ledger as (
    select * from  {{ref('stg_skandia')}}

), renamed as (
   select CAST(Bokfdatum as date) as bokfdatum,
           Beskrivning as beskrivning,
           cast(replace(regexp_replace(Belopp, '\s', '', 'g'),',','.') as numeric) as belopp,
           cast(replace(regexp_replace(Saldo, '\s', '', 'g'),',','.') as numeric) as saldo,
           created_at
           
           from ledger
), enriched as (
    select bokfdatum,
           beskrivning,
           belopp,
           saldo,
          {{ generate_category('beskrivning') }} as  category,
          {{ generate_detailed_cat('beskrivning')}} as cat_detail,
           case 
                 --when position('ÖVERFÖRING' in beskrivning) > 0 
                   --     or  position('TOVELÖN' in beskrivning) > 0 then 'SALARY'
                 when position('Insättning' in beskrivning) > 0 then 'Inkomst'  
                 when beskrivning='Överföring 3030 0365756' then 'Överföring'      
           else 'Utgift'
           end typ,
           to_char(bokfdatum,'YYYY-MM') as YearMonth,
           to_char(bokfdatum,'YYYY-MM') as Year,
           created_at,
           'SKANDIA' as source
           from renamed 
)
select * from enriched