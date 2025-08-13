-- Tempo médio de entrega
SELECT
    AVG(julianday(order_delivered_customer_date) - julianday(order_approved_at)) AS media_para_entrega
FROM tb_orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_approved_at IS NOT NULL;
