-- Ticket medio por cliente

with soma_total as (
    select
        sum(t2.price) as total_por_cliente
    from tb_orders as t1

    inner join tb_order_items as t2
        on t1.order_id = t2.order_id

    where t1.order_status = 'delivered'

    group by t1.customer_id
)

select
    round(avg(tb.total_por_cliente), 2) as ticket_medio_cliente
from soma_total as tb