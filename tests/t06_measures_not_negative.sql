-- gross revenue is never negative
SELECT order_id, gross_usd FROM fact_order WHERE gross_usd < 0;
