-- orders that never completed must not be in the revenue fact
SELECT order_id, order_status FROM fact_order WHERE order_status = 'pending' GROUP BY order_id;
