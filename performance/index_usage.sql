/*
 * PostgreSQL DBA Toolkit
 * Script: index_usage.sql
 * Purpose: Analyze index usage and size across user tables
 * Author: Krisna de Aquino Lira
 */

SELECT
    s.schemaname,
    s.relname AS table_name,
    s.indexrelname AS index_name,
    pg_size_pretty(pg_relation_size(s.indexrelid)) AS index_size,
    pg_relation_size(s.indexrelid) AS index_size_bytes,
    s.idx_scan,
    s.idx_tup_read,
    s.idx_tup_fetch,
    CASE
        WHEN s.idx_scan = 0 THEN 'UNUSED'
        WHEN s.idx_scan < 100 THEN 'LOW USAGE'
        WHEN s.idx_scan < 1000 THEN 'MODERATE USAGE'
        ELSE 'HIGH USAGE'
    END AS usage_level
FROM pg_stat_user_indexes AS s
ORDER BY
    s.idx_scan ASC,
    pg_relation_size(s.indexrelid) DESC;
