{{
    config(
        materialized='incremental',
        unique_key=['bokfdatum', 'beskrivning', 'belopp']
    )
}}


with tmp_ledger as 
/**(

    select * from public.raw_ledger --- make sure existing records will be incorporated at full refresh

    {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where Bokfdatum > (select max(Bokfdatum) from {{ this }})

    {% endif %}
) , raw_skandia as  --most recent records insert/truncate**/

(
    select 
        bokfdatum, 
        beskrivning, 
        belopp, 
        saldo,
        bokfdatum::timestamp+
             EXTRACT(HOUR FROM created_at) * INTERVAL '1 HOUR' +
             EXTRACT(MINUTE FROM  created_at) * INTERVAL '1 MINUTE' +
             EXTRACT(SECOND FROM  created_at) * INTERVAL '1 SECOND' as created_at
    from raw_skandia
           

), raw_ledger as 
(

    select 
        bokfdatum, 
        beskrivning, 
        belopp, 
        saldo,
        bokfdatum::timestamp+
             EXTRACT(HOUR FROM created_at) * INTERVAL '1 HOUR' +
             EXTRACT(MINUTE FROM  created_at) * INTERVAL '1 MINUTE' +
             EXTRACT(SECOND FROM  created_at) * INTERVAL '1 SECOND' as created_at
     from public.raw_ledger --- make sure existing records will be incorporated at full refresh

    {% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where Bokfdatum > (select max(Bokfdatum) from {{ this }})

    {% endif %}
) 

  /**  select * from stg_ledger
    union all 
    select * from raw_skandia**/
    select * from raw_ledger
    union all 
    select * from tmp_ledger