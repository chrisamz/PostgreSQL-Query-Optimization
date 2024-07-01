-- performance_benchmarking.sql
-- This script captures performance metrics for benchmarking

-- Step 1: Enable pg_stat_statements extension if not already enabled
-- You need to be a superuser to enable the extension
-- CREATE EXTENSION pg_stat_statements;

-- Step 2: Capture query execution statistics before optimization

-- Clear the statistics to start fresh
SELECT pg_stat_statements_reset();

-- Example: Run your workload here to gather initial statistics
-- Replace this with your actual workload
-- SELECT * FROM your_table_name WHERE example_column = 'some_value';
-- SELECT a.column1, b.column3 FROM table_a a JOIN table_b b ON a.id = b.a_id WHERE a.status = 'active';

-- Capture the initial performance metrics
WITH metrics_before AS (
    SELECT
        query,
        calls,
        total_exec_time AS total_time,
        mean_exec_time AS mean_time,
        rows
    FROM
        pg_stat_statements
    ORDER BY
        total_time DESC
    LIMIT 10
)
SELECT 'Before Optimization' AS phase, * FROM metrics_before;

-- Step 3: Apply your optimization techniques here
-- This might include creating indexes, rewriting queries, etc.
-- Example:
-- CREATE INDEX idx_example_column ON your_table_name (example_column);
-- CREATE INDEX idx_example_composite ON your_table_name (column1, column2);

-- Step 4: Capture query execution statistics after optimization

-- Clear the statistics to start fresh
SELECT pg_stat_statements_reset();

-- Example: Run your optimized workload here to gather new statistics
-- Replace this with your actual optimized workload
-- SELECT * FROM your_table_name WHERE example_column = 'some_value';
-- SELECT a.column1, b.column3 FROM table_a a JOIN table_b b ON a.id = b.a_id WHERE a.status = 'active';

-- Capture the performance metrics after optimization
WITH metrics_after AS (
    SELECT
        query,
        calls,
        total_exec_time AS total_time,
        mean_exec_time AS mean_time,
        rows
    FROM
        pg_stat_statements
    ORDER BY
        total_time DESC
    LIMIT 10
)
SELECT 'After Optimization' AS phase, * FROM metrics_after;

-- Step 5: Compare the performance metrics before and after optimization

WITH
    metrics_before AS (
        SELECT
            query,
            calls,
            total_exec_time AS total_time,
            mean_exec_time AS mean_time,
            rows
        FROM
            pg_stat_statements
        WHERE phase = 'Before Optimization'
    ),
    metrics_after AS (
        SELECT
            query,
            calls,
            total_exec_time AS total_time,
            mean_exec_time AS mean_time,
            rows
        FROM
            pg_stat_statements
        WHERE phase = 'After Optimization'
    )
SELECT
    COALESCE(before.query, after.query) AS query,
    COALESCE(before.calls, 0) AS calls_before,
    COALESCE(after.calls, 0) AS calls_after,
    COALESCE(before.total_time, 0) AS total_time_before,
    COALESCE(after.total_time, 0) AS total_time_after,
    COALESCE(before.mean_time, 0) AS mean_time_before,
    COALESCE(after.mean_time, 0) AS mean_time_after,
    COALESCE(before.rows, 0) AS rows_before,
    COALESCE(after.rows, 0) AS rows_after
FROM
    metrics_before before
FULL OUTER JOIN
    metrics_after after
ON
    before.query = after.query
ORDER BY
    COALESCE(before.total_time, after.total_time) DESC;
