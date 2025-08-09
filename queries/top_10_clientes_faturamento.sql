-- Top 10 clientes com maior valor total de compras entregues
SELECT
    t1.customer_id,
    SUM(t2.price) AS total_compras,
    COUNT(DISTINCT t1.order_id) AS qtd_pedidos
FROM tb_orders AS t1

INNER JOIN tb_order_items AS t2
    ON t1.order_id = t2.order_id

WHERE t1.order_status = 'delivered'

GROUP BY t1.customer_id

ORDER BY total_compras DESC

LIMIT 10;
