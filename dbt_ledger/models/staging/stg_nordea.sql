{{
    config(
        materialized='incremental',
        unique_key=['bokfdatum', 'beskrivning', 'belopp']
    )
}}
with stage_test2 as (

    select 
    Bokfdatum , 
    Belopp , 
    Avsändare,
    Mottagare ,
    Namn,
    Beskrivning ,  
    Saldo , 
    Valuta ,
      bokfdatum::timestamp+
             EXTRACT(HOUR FROM created_at) * INTERVAL '1 HOUR' +
             EXTRACT(MINUTE FROM  created_at) * INTERVAL '1 MINUTE' +
             EXTRACT(SECOND FROM  created_at) * INTERVAL '1 SECOND' as created_at 
             
             from public.raw_nordea
) 

    select * from stage_test2