{{ config(materialized='table') }}

With SKUs as 
(select distinct SKU,CATEGORY,ASIN,Size,Style from AMAZON_DB.PUBLIC.AMAZON_DATASET)
select * from SKUs