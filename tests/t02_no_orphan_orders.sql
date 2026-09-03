-- every order in fact_order exists in the landing table
SELECT f.order_id FROM fact_order f
LEFT JOIN raw_orders o ON o.order_id = f.order_id
WHERE o.order_id IS NULL GROUP BY f.order_id;
