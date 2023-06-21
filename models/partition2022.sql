
select 
    *, cast(getdate() as date) dta_rfc
from 
    {{ref('joins')}}
where
    year(order_date) = 2022