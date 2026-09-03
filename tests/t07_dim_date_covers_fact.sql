-- every date used by the fact exists in dim_date
SELECT f.order_date FROM fact_order f
LEFT JOIN dim_date d ON d.date = f.order_date
WHERE d.date IS NULL GROUP BY f.order_date;
