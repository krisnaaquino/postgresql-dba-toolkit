/*
===============================================================================
 PostgreSQL DBA Toolkit
 Script: sessions.sql
 Purpose: Monitor PostgreSQL sessions, activity and wait events
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
    backend_start,
    xact_start,
    query_start,
    now() - query_start AS query_duration,
    LEFT(query, 150) AS query
FROM pg_stat_activity
WHERE pid <> pg_backend_pid()
ORDER BY query_start NULLS LAST;
