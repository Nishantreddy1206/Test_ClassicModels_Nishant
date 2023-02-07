

{{ config(materialized='table') }}

with customers_dim as (
    select 
        customernumber as customer_id,
        salesrepemployeenumber as employee_id
    from public.Customers
),
orders_dim as (
    select 
        customernumber as customer_id,
        max(orderdate) as last_order,
        min(orderdate) as first_order
    from public.Orders
    group by customernumber
),
dim as (
    select
        cd.customer_id,
        cd.employee_id,
        od.first_order,
        od.last_order
    from customers_dim cd 
    join orders_dim od using (customer_id)
)
select * from dim