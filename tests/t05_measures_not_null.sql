-- no NULL money on the fact
SELECT order_id, gross_usd, platform_fee_usd, net_usd FROM fact_order
WHERE gross_usd IS NULL OR platform_fee_usd IS NULL OR net_usd IS NULL;
