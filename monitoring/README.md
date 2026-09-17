# PostgreSQL Monitoring Scripts 🔍

This directory contains SQL scripts for monitoring PostgreSQL sessions,
query execution and blocking situations.

These scripts are intended to support day-to-day database administration
and production troubleshooting.

## Available Scripts

### 1. `sessions.sql`

Displays current PostgreSQL sessions and their activity.

Information includes:

- Process ID (PID)
- Database and username
- Client application and IP address
- Session state
- Wait events
- Transaction start time
- Query start time
- Query duration
- Current SQL statement

### 2. `long_running_queries.sql`

Identifies active queries running for more than five minutes.

This script can help investigate:

- Long-running SQL statements
- Performance degradation
- Resource-intensive operations
- Unexpected application workloads

The five-minute threshold can be adjusted according to the environment.

### 3. `blocking_sessions.sql`

Identifies blocked sessions and the PostgreSQL sessions responsible for
blocking them.

The output correlates:

- Blocked PID
- Blocking PID
- Users
- Client applications
- Client addresses
- Query duration
- Blocked SQL
- Blocking SQL

This is useful when investigating lock contention and database concurrency
problems.

## Example Troubleshooting Workflow

When investigating database slowness:

1. Run `sessions.sql` to inspect overall database activity.
2. Run `long_running_queries.sql` to identify unusually long operations.
3. Run `blocking_sessions.sql` to determine whether lock contention is involved.
4. Analyze the identified sessions before taking corrective action.

> **Important:** These scripts are diagnostic tools. Always investigate the
> application and transaction context before terminating a database session.

## Requirements

The scripts use PostgreSQL system views and functions such as:

- `pg_stat_activity`
- `pg_blocking_pids()`

Access to some session information may depend on the privileges of the
connected PostgreSQL role.
