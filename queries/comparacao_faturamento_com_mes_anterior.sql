-- Comparação de faturamento mensal com o mês anterior (crescimento absoluto e %)

WITH faturamento_mensal AS (
    SELECT
        -- Extrai AAAA-MM para agrupar por mês calendário
        strftime('%Y-%m', t1.order_approved_at) AS ano_mes,

        -- Faturamento do mês (somente itens). não está incluso frete
        SUM(t2.price) AS faturamento,

        -- Número de pedidos únicos no mês
        COUNT(DISTINCT t1.order_id) AS pedidos
    FROM tb_orders AS t1
    INNER JOIN tb_order_items AS t2
        ON t1.order_id = t2.order_id
    WHERE 
        t1.order_status = 'delivered'        -- considera apenas pedidos concluídos
        AND t1.order_approved_at IS NOT NULL -- evita strftime em NULL
    GROUP BY 
        strftime('%Y-%m', t1.order_approved_at)
),

com_lag AS (
    SELECT
        ano_mes,
        faturamento,
        pedidos,
        -- Pega t1 faturamento do mês anterior
        LAG(faturamento, 1) OVER (ORDER BY ano_mes) AS faturamento_anterior
    FROM faturamento_mensal
)

SELECT
    ano_mes,                  
    pedidos,                  
    faturamento,              
    faturamento_anterior,     

    -- Crescimento absoluto em R$
    ROUND(faturamento - faturamento_anterior, 2) AS crescimento_absoluto,

    -- Crescimento percentual mês a mês:
    ROUND(
        (faturamento - faturamento_anterior) * 100.0 / NULLIF(faturamento_anterior, 0),
        2
    ) AS crescimento_percentual
FROM com_lag
ORDER BY ano_mes;
