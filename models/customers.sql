
/*
    Model Customers
    
    Removendo linhas duplicadas
        O select a seguir cria uma coluna result
        na qual sempre sera preenchida pelo primeiro customer_id
        encontrado para cada contact_name e company name 
        duplicados

        Após isso o modelo seleciona apenas com os customer_id
        iguais ao gerados
*/

with tab as (

    select
        *,
        first_value(customer_id)
        over(partition by company_name, contact_name
        order by company_name
        rows between unbounded preceding and unbounded following) as result
    from
        -- nome_da_source, nome_da_tabela
        {{source('sources','customers')}}

), removed as (

    select distinct 
        result
    from tab

), final as(

    select 
        *
    from  
        {{source('sources','customers')}}
    where
        customer_id in (select result from removed)
)

select 
    *
from 
    final