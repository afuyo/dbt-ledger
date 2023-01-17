{{
  config(
    materialized='view'
  )
}}

with ledger as (
    select * from  {{ref('stg_nordea')}}

), renamed as (
   select CAST(Bokfdatum as date) as bokfdatum,
           Beskrivning as beskrivning,
           cast(replace(Belopp,',','.') as numeric) as belopp,
           cast(replace(Saldo,',','.') as numeric) as saldo,
           created_at
           
           from ledger
)  , enriched as (
    select bokfdatum,
           beskrivning,
           belopp,
           saldo,
          {{ generate_category('beskrivning') }} as  category,
          {{ generate_detailed_cat('beskrivning')}} as cat_detail,
           case 
              --when position('ÖVERFÖRING' in beskrivning) > 0 
               --     or  position('TOVELÖN' in beskrivning) > 0 then 'SALARY'
                 when position('Utlandsinsättning' in beskrivning) > 0
                 or beskrivning like '%Skatt%'
                -- or beskrivning like '%AVANZA%'
                  then 'Inkomst'  
                 when position('Insättning' in beskrivning) > 0 then 'Lån'  
                 --Insättning      
           else 'Utgift'
           end typ,
           to_char(bokfdatum,'YYYY-MM') as YearMonth,
           to_char(bokfdatum,'YYYY-MM') as Year,
           created_at,
           'Nordea' as source
           from renamed 
)
select * from enriched