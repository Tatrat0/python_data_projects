WITH base AS (
    SELECT 
        payment_value,
        EXTRACT(month FROM order_approved_at) AS month_approved,
        EXTRACT(year FROM order_approved_at) AS year_approved
    FROM olist_orders_dataset o
    JOIN olist_order_payments_dataset p 
        ON o.order_id = p.order_id
    WHERE payment_value IS NOT NULL 
      AND order_approved_at IS NOT NULL
),

agg AS (
    SELECT
        year_approved,
        month_approved,
        percentile_cont(0.5) WITHIN GROUP (ORDER BY payment_value) AS revenue_median_month,
        SUM(payment_value) AS revenue_month
    FROM base
    GROUP BY year_approved, month_approved
)

SELECT
    year_approved,
    month_approved,
    round(revenue_median_month) as revenue_median_month,
    round(revenue_month * 100.0 / SUM(revenue_month) OVER (PARTITION BY year_approved)) AS revenue_perc
FROM agg
ORDER BY year_approved, month_approved;