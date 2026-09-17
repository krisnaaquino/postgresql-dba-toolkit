/*
===============================================================================
 PostgreSQL DBA Toolkit
 Script: blocking_sessions.sql
 Purpose: Identify blocked sessions and their blocking sessions
 Author: Krisna Aquino
===============================================================================
*/

SELECT
    blocked.pid AS blocked_pid,
    blocked.usename AS blocked_user,
    blocked.application_name AS blocked_application,
    blocked.client_addr AS blocked_client,
    now() - blocked.query_start AS blocked_duration,
    LEFT(blocked.query, 300) AS blocked_query,

    blocker.pid AS blocking_pid,
    blocker.usename AS blocking_user,
    blocker.application_name AS blocking_application,
    blocker.client_addr AS blocking_client,
    blocker.state AS blocking_state,
    now() - blocker.query_start AS blocking_duration,
    LEFT(blocker.query, 300) AS blocking_query

FROM pg_stat_activity AS blocked

CROSS JOIN LATERAL
    unnest(pg_blocking_pids(blocked.pid)) AS blocking_pid

JOIN pg_stat_activity AS blocker
    ON blocker.pid = blocking_pid

WHERE blocked.pid <> pg_backend_pid()

ORDER BY blocked.query_start;
