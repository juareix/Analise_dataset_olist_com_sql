-- rank de seller por faturamento
SELECT
    t2.seller_id,
    COUNT(*) AS total_vendas,
    SUM(t2.price) AS faturamento_total,
    RANK() OVER (ORDER BY SUM(t2.price) DESC) AS posicao_rank --window function que caracteriza o ranking por faturamento e ordena 
FROM tb_orders AS t1

INNER JOIN tb_order_items AS t2
    ON t1.order_id = t2.order_id

WHERE t1.order_status = 'delivered' -- seleciona somente os pedidos entregues

GROUP BY t2.seller_id --agrupa por vendedor/seller

ORDER BY faturamento_total DESC; -- Ordena por faturamento