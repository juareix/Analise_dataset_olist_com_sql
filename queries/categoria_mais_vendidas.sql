SELECT 
    COALESCE(p.product_category_name, 'Outros') AS nome_categoria,
    COUNT(*) AS qtd_vendas
FROM tb_products AS p
INNER JOIN tb_order_items AS oi
    ON p.product_id = oi.product_id
INNER JOIN tb_orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY nome_categoria
ORDER BY qtd_vendas DESC;

