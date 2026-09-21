/*
 * PostgreSQL DBA Toolkit
 * Script: table_statistics.sql
 * Purpose: Analyze table statistics, VACUUM and ANALYZE activity
 * Author: Krisna de Aquino Lira
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

    seq_scan,
    seq_tup_read,
    idx_scan,
    idx_tup_fetch,

    n_tup_ins,
    n_tup_upd,
    n_tup_del,
    n_tup_hot_upd,

    last_vacuum,
    last_autovacuum,
    vacuum_count,
    autovacuum_count,

    last_analyze,
    last_autoanalyze,
    analyze_count,
    autoanalyze_count

FROM pg_stat_user_tables

ORDER BY
    n_dead_tup DESC,
    schemaname,
    relname;
