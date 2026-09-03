-- Convert to USD and attach the platform fee.
-- FX comes from the daily rate file. Fees come from the platform fee schedule.

DROP TABLE IF EXISTS stg_order_priced;
CREATE TABLE stg_order_priced AS
SELECT s.*,
       fx.rate_to_usd,
       (SELECT CAST(pf.fee_pct AS REAL)
          FROM raw_platform_fees pf
         WHERE pf.platform_code = s.platform_code
         ORDER BY pf.effective_from DESC
         LIMIT 1)                                        AS fee_pct
FROM stg_order s
LEFT JOIN raw_fx_rates fx
       ON fx.currency_code = s.currency_code
      AND fx.rate_date     = s.order_date;

CREATE INDEX ix_stg_order_priced ON stg_order_priced(order_id);
