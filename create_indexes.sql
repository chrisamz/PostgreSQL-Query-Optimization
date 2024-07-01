-- create_indexes.sql
-- This script creates indexes to improve query performance

-- Example: Creating an index on a frequently queried column
CREATE INDEX idx_example_column
ON your_table_name (example_column);

-- Example: Creating a composite index on multiple columns
CREATE INDEX idx_example_composite
ON your_table_name (column1, column2);

-- Example: Creating a unique index
CREATE UNIQUE INDEX idx_example_unique
ON your_table_name (unique_column);

-- Example: Creating an index with included columns (PostgreSQL 11+)
CREATE INDEX idx_example_included
ON your_table_name (column1)
INCLUDE (column2, column3);

-- Example: Creating a partial index with a filter condition
CREATE INDEX idx_example_partial
ON your_table_name (filter_column)
WHERE filter_column IS NOT NULL;

-- Example: Creating a GiST index for full-text search
CREATE INDEX idx_example_gist
ON your_table_name USING gist (tsvector_column);

-- Example: Creating a B-tree index on a JSONB column
CREATE INDEX idx_example_jsonb
ON your_table_name ((jsonb_column->>'key'));

-- Example: Creating a BRIN index for large tables
CREATE INDEX idx_example_brin
ON your_table_name USING brin (brin_column);

-- Example: Creating a hash index (PostgreSQL 10+)
CREATE INDEX idx_example_hash
ON your_table_name USING hash (hash_column);

-- Example: Creating a multi-column index for better performance in JOIN operations
CREATE INDEX idx_example_multicolumn
ON your_table_name (column1, column2, column3);

-- Example: Dropping an existing index if necessary
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_indexes WHERE schemaname = 'public' AND indexname = 'idx_old_example') THEN
        DROP INDEX idx_old_example;
    END IF;
END $$;

-- Example: Creating an index on a frequently queried column in another table
CREATE INDEX idx_another_table_example_column
ON another_table_name (another_example_column);

-- Example: Creating a composite index on multiple columns in another table
CREATE INDEX idx_another_table_composite
ON another_table_name (another_column1, another_column2);

-- Example: Creating a unique index in another table
CREATE UNIQUE INDEX idx_another_table_unique
ON another_table_name (another_unique_column);

-- Example: Creating an index with included columns in another table (PostgreSQL 11+)
CREATE INDEX idx_another_table_included
ON another_table_name (another_column1)
INCLUDE (another_column2, another_column3);

-- Example: Creating a partial index with a filter condition in another table
CREATE INDEX idx_another_table_partial
ON another_table_name (another_filter_column)
WHERE another_filter_column IS NOT NULL;

-- Example: Creating a GiST index for full-text search in another table
CREATE INDEX idx_another_table_gist
ON another_table_name USING gist (another_tsvector_column);

-- Example: Creating a B-tree index on a JSONB column in another table
CREATE INDEX idx_another_table_jsonb
ON another_table_name ((another_jsonb_column->>'key'));

-- Example: Creating a BRIN index for large tables in another table
CREATE INDEX idx_another_table_brin
ON another_table_name USING brin (another_brin_column);

-- Example: Creating a hash index in another table (PostgreSQL 10+)
CREATE INDEX idx_another_table_hash
ON another_table_name USING hash (another_hash_column);

-- Example: Creating a multi-column index in another table for better performance in JOIN operations
CREATE INDEX idx_another_table_multicolumn
ON another_table_name (another_column1, another_column2, another_column3);

-- Example: Dropping an existing index if necessary in another table
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_indexes WHERE schemaname = 'public' AND indexname = 'idx_another_old_example') THEN
        DROP INDEX idx_another_old_example;
    END IF;
END $$;
