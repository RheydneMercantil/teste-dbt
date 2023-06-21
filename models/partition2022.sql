
select 
    *
from 
    {{ref('joins')}}
where
    year(order_date) = 2022