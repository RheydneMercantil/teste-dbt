
with prod as (

    select
        c.category_name, 
        b.company_name suppliers, 
        a.product_name, 
        a.unit_price, 
        a.product_id
    from 
        {{source('sources','products')}} a 
        left join 
        {{source('sources','suppliers')}} b
            on a.supplier_id = b.supplier_id
        left join 
        {{source('sources','categories')}} c
            on a.category_id = c.category_id

), orddetai as (

    select 
        b.*, 
        a.order_id, 
        a.quantity, 
        a.discount
    from 
        {{ref('orderdetails')}} a 
        left join 
        prod b 
            on a.product_id = b.product_id

), orders as (

    select
        a.order_date,
        a.order_id,
        b.company_name customer,
        c.full_name employee,
        c.age,
        c.service_time
    from 
        {{source('sources','orders')}} a 
        left join
        {{ref('customers')}} b
            on a.customer_id = b.customer_id
        left join 
        {{ref('employees')}} c
            on a.employee_id = c.employee_id
        left join 
        {{source('sources','shippers')}} d
            on a.ship_via = d.shipper_id

), finaljoin as (

    select 
        a.*,
        b.customer,
        b.order_date,
        b.employee,
        b.age,
        b.service_time
    from 
        orddetai a
        inner join 
        orders b
            on a.order_id = b.order_id

)

select *
from finaljoin