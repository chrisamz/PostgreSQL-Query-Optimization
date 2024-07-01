-- explain_analyze.sql
-- This script gathers initial performance metrics using EXPLAIN and ANALYZE commands

-- Example Query 1: Analyze this query to understand its execution plan
EXPLAIN ANALYZE
SELECT
    column1,
    column2
FROM
    your_table_name
WHERE
    example_column = 'some_value';

-- Example Query 2: Analyze this query to understand its execution plan
EXPLAIN ANALYZE
SELECT
    a.column1,
    a.column2,
    b.column3,
    b.column4
FROM
    table_a a
JOIN
    table_b b ON a.id = b.a_id
WHERE
    a.status = 'active';

-- Example Query 3: Analyze this query to understand its execution plan
EXPLAIN ANALYZE
SELECT
    yt.column1,
    yt.column2
FROM
    your_table_name yt
WHERE
    EXISTS (SELECT 1 FROM another_table at WHERE at.column3 = yt.column3 AND at.column4 = 'some_value');

-- Example Query 4: Analyze this query to understand its execution plan
EXPLAIN ANALYZE
SELECT
    column1,
    column2,
    column3
FROM
    your_table_name
WHERE
    column1 = 'value1'
    AND column2 = 'value2'
    AND column3 = 'value3';

-- Example Query 5: Analyze this query to understand its execution plan
EXPLAIN ANALYZE
SELECT
    a.id,
    a.name,
    b.amount,
    c.date
FROM
    orders a
JOIN
    payments b ON a.id = b.order_id
JOIN
    deliveries c ON a.id = c.order_id
WHERE
    a.status = 'completed'
    AND c.date >= '2023-01-01';

-- Example Query 6: Analyze this query to understand its execution plan
EXPLAIN ANALYZE
SELECT
    t1.id,
    t1.name,
    t2.description,
    t3.value
FROM
    table1 t1
JOIN
    table2 t2 ON t1.id = t2.t1_id
LEFT JOIN
    table3 t3 ON t1.id = t3.t1_id
WHERE
    t1.active = true;
