
-- Olist Brazilian E-Commerce Analysis
-- Monthly Order Trends and MoM Growth
-- Period: January 2017 - July 2018
-- All order statuses included

WITH monthly_orders AS (
    SELECT
        DATE_TRUNC('month', order_purchase_timestamp) AS order_month,
        COUNT(*) AS total_orders
    FROM olist_orders
    WHERE order_purchase_timestamp >= '2017-01-01'
      AND order_purchase_timestamp < '2018-08-01'
    GROUP BY 1
),

monthly_comparison AS (
    SELECT
        order_month,
        total_orders,
        LAG(total_orders) OVER (
            ORDER BY order_month
        ) AS previous_month_orders
    FROM monthly_orders
)

SELECT
    order_month,
    total_orders,
    previous_month_orders,
    ROUND(
        (total_orders - previous_month_orders) * 100.0
        / NULLIF(previous_month_orders, 0),
        2
    ) AS mom_growth
FROM monthly_comparison
ORDER BY order_month;
