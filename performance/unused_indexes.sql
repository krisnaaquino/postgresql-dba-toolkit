/*
 * PostgreSQL DBA Toolkit
 * Script: unused_indexes.sql
 * Purpose: Identify potentially unused indexes
 * Author: Krisna de Aquino Lira
 *
 * Important:
 * An index with idx_scan = 0 should NOT automatically be dropped.
 * Statistics may have been reset, and some indexes may support
 * constraints or infrequent but critical workloads.
 */

SELECT
    s.schemaname,
    s.relname AS table_name,
    s.indexrelname AS index_name,
    pg_size_pretty(pg_relation_size(s.indexrelid)) AS index_size,
    pg_relation_size(s.indexrelid) AS index_size_bytes,
    s.idx_scan,
    s.idx_tup_read,
    s.idx_tup_fetch
FROM pg_stat_user_indexes AS s
JOIN pg_index AS i
    ON i.indexrelid = s.indexrelid
WHERE s.idx_scan = 0
  AND NOT i.indisprimary
  AND NOT i.indisunique
ORDER BY
    pg_relation_size(s.indexrelid) DESC;
