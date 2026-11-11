
-- Olist Brazilian E-Commerce Analysis
-- Order Status Distribution
-- Period: January 2017 - July 2018

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM olist_orders
WHERE order_purchase_timestamp >= '2017-01-01'
  AND order_purchase_timestamp < '2018-08-01'
GROUP BY order_status
ORDER BY total_orders DESC;
