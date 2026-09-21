/*
 * PostgreSQL DBA Toolkit
 * Script: top_queries_pg_stat_statements.sql
 * Purpose: Identify expensive SQL statements using pg_stat_statements
 * Author: Krisna de Aquino Lira
 *
 * Requirement:
 * pg_stat_statements extension must be installed and enabled.
 */

SELECT
    d.datname AS database_name,
    r.rolname AS username,

    p.calls,

    ROUND(p.total_exec_time::numeric, 2) AS total_exec_time_ms,
    ROUND(p.mean_exec_time::numeric, 2) AS mean_exec_time_ms,
    ROUND(p.max_exec_time::numeric, 2) AS max_exec_time_ms,

    p.rows,

    p.shared_blks_hit,
    p.shared_blks_read,
    p.shared_blks_dirtied,
    p.shared_blks_written,

    ROUND(
        100.0 * p.shared_blks_hit /
        NULLIF(p.shared_blks_hit + p.shared_blks_read, 0),
        2
    ) AS cache_hit_pct,

    LEFT(p.query, 300) AS query

FROM pg_stat_statements AS p

JOIN pg_database AS d
    ON d.oid = p.dbid

JOIN pg_roles AS r
    ON r.oid = p.userid

ORDER BY
    p.total_exec_time DESC

LIMIT 50;
