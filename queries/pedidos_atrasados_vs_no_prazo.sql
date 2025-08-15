SELECT
    t3.product_category_name,
    COUNT(DISTINCT CASE 
        WHEN t1.order_delivered_customer_date <= t1.order_estimated_delivery_date 
        THEN t1.order_id 
    END) AS entregas_no_prazo,
    COUNT(DISTINCT CASE 
        WHEN t1.order_delivered_customer_date > t1.order_estimated_delivery_date 
        THEN t1.order_id 
    END) AS entregas_atrasadas
FROM tb_orders AS t1
INNER JOIN tb_order_items AS t2
    ON t1.order_id = t2.order_id
INNER JOIN tb_products AS t3
    ON t2.product_id = t3.product_id
WHERE t1.order_status = 'delivered'
GROUP BY t3.product_category_name
ORDER BY entregas_no_prazo DESC;
