-- every title_id and player_id in fact_order resolves to its dimension
SELECT f.order_id, f.title_id, f.player_id FROM fact_order f
LEFT JOIN dim_title  t ON t.title_id  = f.title_id
LEFT JOIN dim_player p ON p.player_id = f.player_id
WHERE t.title_id IS NULL OR p.player_id IS NULL;
