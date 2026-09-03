-- fact_order must not contain an order more times than the landing table does
SELECT f.order_id, COUNT(*) AS in_fact, (SELECT COUNT(*) FROM raw_orders o WHERE o.order_id = f.order_id) AS in_raw
FROM fact_order f
GROUP BY f.order_id
HAVING COUNT(*) > (SELECT COUNT(*) FROM raw_orders o WHERE o.order_id = f.order_id);
