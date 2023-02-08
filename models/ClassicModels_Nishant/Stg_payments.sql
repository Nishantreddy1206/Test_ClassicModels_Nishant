
WITH Payments_fact as (
    SELECT 
        customernumber as customer_id,
        SUM(Amount) as payment_amount
    FROM public.Payments
    GROUP BY 1
)

SELECT * FROM Payments_fact