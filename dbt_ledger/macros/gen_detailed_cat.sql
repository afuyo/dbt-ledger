{% macro generate_detailed_cat(beskrivning) -%}
 case
    --mat
    when "{{ beskrivning }}" like '%ICA%'
    then 'FOOD'
    when "{{ beskrivning }}" like '%COOP%'
    then 'FOOD'
    when "{{ beskrivning }}" like '%WILLYS%'
    then 'FOOD'
    when "{{ beskrivning }}" like '%LUCU%'
    then 'FOOD'
    when "{{ beskrivning }}" like '%BAGERIET%'
    then 'FOOD'
    when "{{ beskrivning }}" like '%EMMERYS%'
    then 'FOOD'
    --el 
    when "{{ beskrivning }}" like '%Telge%'
    then 'EL'
    when "{{ beskrivning }}" like '%EON%'
    then 'EL'
    when "{{ beskrivning }}" like '%TELGE ENERGI%'
    then 'EL'

    --PG 943102-4 TELGE ENERGI AB
    --bränsle 
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
    --2021-05-29 TANKA SOLVESBORG, SOLVESBORG
    else 
          'Unknown'
end
{%- endmacro %}