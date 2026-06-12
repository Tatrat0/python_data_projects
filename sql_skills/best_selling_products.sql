-- Problem: Best Selling Products
-- Source: DataLemur

-- Task:
-- Find the best-selling product in each category based on:
-- 1. Highest sales_quantity
-- 2. Highest rating (tie-breaker)

-- Approach:
-- 1. Join products with product_sales
-- 2. Rank products within each category
-- 3. Select top-ranked product

WITH ranked_products AS (
  SELECT
    p.category_name,
    p.product_name,
    ROW_NUMBER() OVER (
      PARTITION BY p.category_name
      ORDER BY ps.sales_quantity DESC, ps.rating DESC
    ) AS rn
  FROM products p
  JOIN product_sales ps
    ON p.product_id = ps.product_id
)

SELECT
  category_name,
  product_name
FROM ranked_products
WHERE rn = 1
ORDER BY category_name;