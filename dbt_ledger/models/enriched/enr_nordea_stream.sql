with nordea_stream as (
    
select case 
		when is_date(substring(beskrivning,8,7)) then substring(beskrivning,16) 
		else beskrivning 
		end as activity_id,
        beskrivning,
		created_at::timestamp as ts,
		'3030 03 65756' as account,-- nice to have kortnummer /customer
	/**	case when belopp < 0 then 'DEBIT' 
			 else 'CREDIT' 
			 end as activity,**/
			 --null anonymous_customer_id,
             {{ generate_category('beskrivning') }} as activity,
          {{ generate_category('beskrivning') }} as feature_1,
          {{ generate_detailed_cat('beskrivning')}} as feature_2,
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
           end feature_3,
			 belopp as revenue_impact,
			 --null as link,
		     'NORDEA' as _activity_source
             

		     from {{ ref('enr_nordea') }}
) select activity_id,
        ts,
        beskrivning,
        account,
        activity,
        feature_1,
        feature_2,
        feature_3,
        revenue_impact,
        _activity_source,
        rank() over (partition by activity_id order by ts) activity_occurence,
        lead(ts,1 ) over (partition by activity_id) activity_repeated_at

   from nordea_stream
