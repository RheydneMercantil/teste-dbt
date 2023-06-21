
select
    a.order_id, 
    a.product_id, 
    a.unit_price, 
    a.quantity, 
    b.product_name, 
    b.supplier_id, 
    b.category_id,
    a.unit_price * a.quantity total,
    (b.unit_price * a.quantity) - total discount
from 
    {{source('sources','order_details')}} a
    left join
    {{source('sources','products')}} b
    on a.product_id = b.product_id
