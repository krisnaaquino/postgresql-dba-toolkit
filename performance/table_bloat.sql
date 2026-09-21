
/*
 * PostgreSQL DBA Toolkit
 * Script: table_bloat.sql
 * Purpose: Identify tables with high dead tuple ratios
 * Author: Krisna de Aquino Lira
 *
 * Note:
 * This script uses PostgreSQL statistics as an initial indicator
 * of possible table bloat. It does not calculate exact physical bloat.
 */

SELECT
    schemaname,
    relname AS table_name,
    n_live_tup,
    n_dead_tup,
    ROUND(
        100.0 * n_dead_tup /
        NULLIF(n_live_tup + n_dead_tup, 0),
        2
    ) AS dead_tuple_pct,
    last_vacuum,
    last_autovacuum,
    last_analyze,
    last_autoanalyze
FROM pg_stat_user_tables
WHERE n_dead_tup > 0
ORDER BY dead_tuple_pct DESC NULLS LAST,
         n_dead_tup DESC;
