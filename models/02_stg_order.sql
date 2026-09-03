-- Staging: one row per order out of the landing table.

DROP TABLE IF EXISTS stg_order;
CREATE TABLE stg_order AS
SELECT o.order_id,
       o.player_id,
       o.title_id,
       o.platform_code,
       substr(o.order_ts, 1, 10)            AS order_date,
       o.order_ts,
       o.currency_code,
       CAST(o.gross_amount_local AS REAL)   AS gross_local,
       o.order_status,
       o.ingested_at
FROM raw_orders o;

CREATE INDEX ix_stg_order ON stg_order(order_id);
