{{ config(materialized='table') }}

With location_details as 
(select  
ship_postal_code,ship_city,ship_state,ship_country,count(*) as cnt  from AMAZON_DB.PUBLIC.AMAZON_DATASET
    group by 1,2,3,4 order by 3 desc),
Accurate_details as(
select * from (
select ship_postal_code,ship_city,row_number() over (partition by ship_postal_code order by cnt desc) as rn
from 
location_details) where rn=1)
select distinct ld.ship_postal_code,ad.ship_city,ld.ship_state,ld.ship_country
    from location_details ld
        left join Accurate_details ad on ld.ship_postal_code=ad.ship_postal_code