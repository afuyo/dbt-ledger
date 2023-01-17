with skandia_stream as (
select *
        
        from {{ ref('enr_skandia_stream') }}
), nordea_stream as (
    
select  

case when activity_id_nordea is null then activity_id else activity_id_skandia end as activity_id,--harmonizing activity 
        ts,
        beskrivning,
        account,
        activity,
        feature_1,
        feature_2,
        feature_3,
        revenue_impact,
        _activity_source,
        activity_occurence,
        activity_repeated_at
         from {{ ref('enr_nordea_stream') }} ens
                 left join {{ ref('int_master_account') }} ima
                 on ens.activity_id = ima.activity_id_nordea 
), unified_account as (
select * from skandia_stream
union all 
select * from nordea_stream)
select * from unified_account

