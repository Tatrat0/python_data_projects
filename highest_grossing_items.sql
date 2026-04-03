-- source: DataLemur
-- problem: Highest Grossing Items

-- Assume you're given a table containing data on Amazon customers and their spending on products in different category,
-- identify the top two highest-grossing products within each category in the year 2022.



with group_cata as (
select category, product, sum(spend) as total_spend
from product_spend
where EXTRACT(YEAR from transaction_date) = 2022
group by product, category

),

ranked as (select category, product, total_spend,
row_number() over(PARTITION by category order by total_spend desc) as ranked_categ
from group_cata)

select category, product, total_spend
from ranked
where ranked_categ <= 2

;