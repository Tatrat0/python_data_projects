-- Case Study: User Funnel Analysis

-- Objective:
-- Analyze user conversion funnel:
-- visit → signup → payment


with user_steps as (
    select 
        user_id,
        -- use max to check if user had at least one 'visit' event
        max(case when event_type = 'visit' then 1 else 0 end) as visit,
        max(case when event_type = 'signup' then 1 else 0 end) as signup,
        max(case when event_type = 'payment' then 1 else 0 end) as payment
    from events
    group by user_id
)

select 
    sum(visit) as visit_users,
    sum(signup) as signup_users,
    sum(payment) as payment_users,
    round(sum(signup) * 100.0 / nullif(sum(visit), 0), 2) as visit_to_signup,
    round(sum(payment) * 100.0 / nullif(sum(signup), 0), 2) as signup_to_payment
from user_steps;

-- Insight:
-- Major drop-off occurs between signup and payment