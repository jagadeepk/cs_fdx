
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (
    select 
        od.order_id
        ,od.order_date
        ,dd.month_of_year
        ,ld.ship_city
        -- ,count(skud.sku) as num_of_skus
        ,count(od.order_item_id) as ordered_items
        ,sum(qty) as overall_qty
        ,sum(amount) as ordered_amount
    from {{ref('order_items_dim')}} od
        left join {{ref('date_dim')}} dd on od.Order_date =dd.date_dim
        left join {{ref('location_dim')}} ld on od.Ship_postal_code  =ld.Ship_postal_code 
        left join {{ref('sku_dim')}} skud on od.sku  =skud.sku 
            group by 1,2,3,4

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
