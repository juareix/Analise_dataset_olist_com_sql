WITH vendas_mensais AS (
    SELECT
        strftime('%Y-%m', t1.order_approved_at) AS ano_mes,
        COUNT(*) AS total_pedidos,
        SUM(t2.price) AS faturamento_total
    FROM tb_orders AS t1
    INNER JOIN tb_order_items AS t2
        ON t1.order_id = t2.order_id
    WHERE t1.order_status = 'delivered'
    GROUP BY strftime('%Y-%m', t1.order_approved_at)
)

SELECT
    ano_mes,
    total_pedidos,
    faturamento_total,
    ROUND(
        (faturamento_total - LAG(faturamento_total) OVER (ORDER BY ano_mes)) * 100.0 /
        LAG(faturamento_total) OVER (ORDER BY ano_mes), 
    2) AS crescimento_percentual
FROM vendas_mensais
ORDER BY ano_mes;