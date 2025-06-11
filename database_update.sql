-- SQL Server Script to add soft delete columns to Categories table
-- Run this script to update your database schema

-- Add new columns to Categories table
ALTER TABLE Categories 
ADD created_at DATETIME2 DEFAULT GETDATE(),
    updated_at DATETIME2 DEFAULT GETDATE(),
    deleted_at DATETIME2 NULL;

-- Drop the old 'name' column and rename 'nameVN' to 'name'
-- First, copy data if needed
UPDATE Categories SET nameVN = name WHERE nameVN IS NULL OR nameVN = '';

-- Drop the name column
ALTER TABLE Categories DROP COLUMN name;

-- Rename nameVN to name (SQL Server method)
EXEC sp_rename 'Categories.nameVN', 'name', 'COLUMN';

-- Update existing records to set created_at and updated_at for existing records
UPDATE Categories 
SET created_at = GETDATE(), 
    updated_at = GETDATE() 
WHERE created_at IS NULL;

-- Add index for better performance on deleted_at queries
CREATE INDEX idx_categories_deleted_at ON Categories(deleted_at);

-- Optional: View to show only active categories
CREATE VIEW active_categories AS
SELECT * FROM Categories WHERE deleted_at IS NULL;

-- Optional: View to show only deleted categories
CREATE VIEW deleted_categories AS
SELECT * FROM Categories WHERE deleted_at IS NOT NULL; 