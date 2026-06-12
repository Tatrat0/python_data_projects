-- source: DataLemur
-- problem: Best-Selling Product


with cte as (
SELECT products.product_id as main_product_id, category_name, product_sales.product_id, sales_quantity, rating,
dense_rank() over (partition by category_name order by sales_quantity desc, rating desc) as ranked

FROM products left join product_sales on products.product_id = product_sales.product_id
)

select products.category_name, products.product_name
from products inner join cte on products.product_id = cte.main_product_id
where ranked = 1
order by products.category_name
;