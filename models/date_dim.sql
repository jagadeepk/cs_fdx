{{ config(materialized='table') }}

With dates as 
(select distinct TO_DATE(date, 'MM-DD-YY') as date_dim
             ,DATE_PART('day',date_dim) as day_of_month   
            ,DATE_PART('month',date_dim) as month_of_year
            ,DATE_PART('year',date_dim) as year
        from AMAZON_DB.PUBLIC.AMAZON_DATASET
        )

select * from dates