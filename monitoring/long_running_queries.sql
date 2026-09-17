/*
===============================================================================
 PostgreSQL DBA Toolkit
 Script: long_running_queries.sql
 Purpose: Identify long-running active queries
 Author: Krisna Aquino
===============================================================================
*/

SELECT
    pid,
    usename AS username,
    datname AS database_name,
    application_name,
    client_addr,
    state,
    wait_event_type,
    wait_event,
    query_start,
    now() - query_start AS duration,
    LEFT(query, 300) AS query
FROM pg_stat_activity
WHERE state = 'active'
  AND pid <> pg_backend_pid()
  AND query_start < now() - interval '5 minutes'
ORDER BY query_start;
