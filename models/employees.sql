/* 
    Model Employees a
    
    Calcular a idade
    Calcular o tempo de serviço
    Juntar segundo e primeiro nome

*/

with calc_employees as (

    select
        *,
        year(getdate()) - year(birth_date) age,
        year(getdate()) - year(hire_date) service_time,
        concat(first_name, ' ', last_name) full_name
    from 
        {{source('sources','employees')}}

)

select
    *
from 
    calc_employees