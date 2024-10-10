
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

select index as order_item_id,Order_id,TO_DATE(date, 'MM-DD-YY') as order_date,Status,Fulfilment,Sales_Channel,ship_service_level,SKU,QTY,Currency
        ,Amount,promotion_ids,B2B,fulfilled_by,ship_postal_code from AMAZON_DB.PUBLIC.AMAZON_DATASET 

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
