-- source: DataLemur
-- problem: Users' Third Transaction


-- Assume you are given the table below on Uber transactions made by users.
-- obtain the third transaction of every user


with cte as (
SELECT user_id, spend, transaction_date,
ROW_NUMBER() over(PARTITION by user_id order by transaction_date) as ranked

FROM transactions
ORDER BY transaction_date, spend
)

select user_id,	spend,	transaction_date
from cte
where ranked = 3
;