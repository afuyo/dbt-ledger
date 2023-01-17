{% macro generate_category(beskrivning) -%}
 case
    when "{{ beskrivning }}" like '%ICA%'
    then 'FOOD'
    when "{{ beskrivning }}" like '%COOP%'
    then 'FOOD'
    when "{{ beskrivning }}" like '%WILLYS%'
    then 'FOOD'
    --räkningar
     when "{{ beskrivning }}" like '%Centrala Studiestödsnämde%'
          or "{{ beskrivning }}" like '%BG 867-4152 Arrie Städ och Kon%'
          or "{{ beskrivning }}" like '%BG 786-9365 Bengt Glemvik Psyk%'
          or "{{ beskrivning }}" like '%BG 630-2699 Framtidskompassen%'
          or "{{ beskrivning }}" like '%BG 5923-6844 VELLINGE KOMMUN V%'
          or "{{ beskrivning }}" like '%BG 5607-3703 VISMA FINANCIAL S%'
          or "{{ beskrivning }}" like '%BG 5051-6822 FORDONSSKATT TRAN%'
          or "{{ beskrivning }}" like '%Autogiro TRYGG-HANSA%'
          or "{{ beskrivning }}" like '%BG 5014-0045 EON Kundsupport S%'
          or "{{ beskrivning }}" like '%BG 5608-9840 Telge Energi / Bi%'
          or "{{ beskrivning }}" like '%TELGE ENERGI%'
          or "{{ beskrivning }}" like '%BG 5728-3301 Svenska Garantier%'
          or "{{ beskrivning }}" like '%Autogiro TELIA%'
          or "{{ beskrivning }}" like '%Bredband2 %'
          or "{{ beskrivning }}" like '%Månadsavgift BankkortExtra%'
          or "{{ beskrivning }}" like '%Månadsavgift Bankkort%'
          or "{{ beskrivning }}" like '%Autogiro TELIA%'
          or "{{ beskrivning }}" like '%Autogiro DIK-förbund%'
          or "{{ beskrivning }}" like '%Hi3G Access AB%'
          or "{{ beskrivning }}" like '%Autogiro Akad.a-kassa%'
          or "{{ beskrivning }}" like '%Autogiro UNHCR%'
          or "{{ beskrivning }}" like '%Autogiro FOLKTANDVÅRD%'
          or "{{ beskrivning }}" like '%Dagens Nyheter, Prenumera%'
          or "{{ beskrivning }}" like '%Autogiro AKADEMIKERFÖ%'
          or "{{ beskrivning }}" like '%Autogiro LÄKARE UTAN%'
          or "{{ beskrivning }}" like '%Akavia%'
          or "{{ beskrivning }}" like '%Ränta på skuld%'
          or "{{ beskrivning }}" like '%PG 4959102-7 TRYGG HANSA FÖRSÄ%'
          or "{{ beskrivning }}" like '%BG 51842169 FÖRSÄKRINGS AB SKA%'
          or "{{ beskrivning }}" like '%BG 5786-2690 FOLKSAM ÖMSESIDIG%'
          or "{{ beskrivning }}" like '%BG 842-8146 MV Polering ApS%'
          or "{{ beskrivning }}" like '%BG 109-2329 SYDSVENSKA DAGBLAD%'
          or "{{ beskrivning }}" like '%PG 4959102-7 TRYGG-HANSA FÖRSÄ%'
          or "{{ beskrivning }}" like '%BG 109-2329 Bonnier News AB -%'
          or "{{ beskrivning }}" like '%BG 5976-6287 VELLINGE KOMMUN%'
          or "{{ beskrivning }}" like '%BG 5580-3084 CENTRALA STUDIEST%'
          or "{{ beskrivning }}" like '%BG 5608-9840 Telge Energi / Bi%'
          or "{{ beskrivning }}" like '%BG 5608-9840 Telge Energi / Bi%'
          or "{{ beskrivning }}" like '%BG 5608-9840 Telge Energi / Bi%'
          or "{{ beskrivning }}" like '%BG 5608-9840 Telge Energi / Bi%'
          or "{{ beskrivning }}" like '%BG 5608-9840 Telge Energi / Bi%'
          --BG 5786-2690 FOLKSAM ÖMSESIDIG
          --Autogiro Akad.a-kassa
          --BG 5923-6844 VELLINGE KOMMUN V
          -- BG 630-2699 Framtidskompassen
          --BG 5607-3703 VISMA FINANCIAL S
          --BG 5051-6822 FORDONSSKATT TRAN
          --Månadsavgift BankkortExtra
    then 'Räkningar'
   --lån  
   --Autogiro SBAB
       when "{{ beskrivning }}" like '%Autogiro SBAB%' 
       or   "{{ beskrivning }}" like '%Omsättning lån 3992 42 63669%' 
       or  "{{ beskrivning }}" like '%Omsättning lån 3992 42 63650%' 
    then 'Lån'
     when "{{ beskrivning }}" like '%BG 413-3260 SBAB%'
     then 'ExtraLån'
    --Lön
    --Utlandsinsättning 2680137
        when "{{ beskrivning }}" like '%Utlandsinsättning%'
        or "{{ beskrivning }}" like '%Utlandsinsättning%'
        or "{{ beskrivning }}" like '%Skatt%'
        or "{{ beskrivning }}" like '%TOVELÖN%'
        or "{{ beskrivning }}" like '%TOVES LÖN%'
        or "{{ beskrivning }}" like '%SKATT TOVE%'
        or "{{ beskrivning }}" like '%TOVE%'
        or "{{ beskrivning }}" like '%BARNBIDRAG%'
        --Insättning från annan bank SKATT TOVE
        --Insättning från annan bank TOVELÖN
        --Insättning från annan bank TOVES LÖN
        then 'Lön' 
   --undantag
   when "{{ beskrivning }}" like '%Kortköp 220826 FORENADE BIL AB I MA%' 
    then 'BILKÖP'
   when "{{ beskrivning }}" like '%91508831221%' 
    then 'TRANSFER'
   when "{{ beskrivning }}" like '%95507905047%' 
    or "{{ beskrivning}}" like '%AVANZA%'
    then 'AVANZA'
     when "{{ beskrivning }}" like '%BG 456-4951 SKÅNSK TRÄDGÅRDSSE%' 
     or "{{ beskrivning }}" like '%4103234903 A 4238 13 06680%' 
    then 'HUS'
   when "{{ beskrivning }}" like '%FORENADE BIL SERV%' 
    then 'BIL'
   when "{{ beskrivning }}" like '%U C P A RESOR%' 
    then 'RESOR'
--4103234903 A 4238 13 06680
--BG 5976-6287 VELLINGE KOMMUN
--Betalning BG 225-4324 U C P A RESOR
--91508831221
--95507905047
--BG 456-4951 SKÅNSK TRÄDGÅRDSSE
   --bensin 

    when "{{ beskrivning }}" like '%INGO %' --INGO and whitespace exlude HELSINGOER for example
    then 'FUEL'
    when "{{ beskrivning }}" like '%OKQ8%'
    then 'FUEL'
    when "{{ beskrivning }}" like '%QSTAR%'
    then 'FUEL'
    when "{{ beskrivning }}" like '%CIRCLE%'
    then 'FUEL'
    when "{{ beskrivning }}" like '%UNO-X%'
    then 'FUEL'
    when "{{ beskrivning }}" like '%PREEM%'
    then 'FUEL'
    when "{{ beskrivning }}" like '%TANKA SOLVESBORG%'
    then 'FUEL'
     when "{{ beskrivning }}" like '%UNO X%'
    then 'FUEL'
    when "{{ beskrivning }}" like '%SHELL%'
    then 'FUEL'
    --avanza
   
    else 
          'Unknown'
      
end
{%- endmacro %}

