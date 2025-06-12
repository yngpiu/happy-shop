-- =====================================================
-- UPDATE SCRIPT FOR PRODUCT SOFT DELETE FEATURE
-- Adds timestamp columns for soft delete functionality
-- =====================================================

USE HappyShop;

-- Add soft delete columns to Products table
ALTER TABLE Products 
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
ADD COLUMN deleted_at TIMESTAMP NULL DEFAULT NULL;

-- Update existing products with current timestamp for created_at and updated_at
UPDATE Products 
SET created_at = CURRENT_TIMESTAMP, 
    updated_at = CURRENT_TIMESTAMP 
WHERE created_at IS NULL;

-- Create index for better performance on soft delete queries
CREATE INDEX idx_products_deleted_at ON Products(deleted_at);
CREATE INDEX idx_products_active ON Products(deleted_at, id);

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- Check if columns were added successfully
DESCRIBE Products;

-- Count active products (not deleted)
SELECT COUNT(*) as 'Active Products' FROM Products WHERE deleted_at IS NULL;

-- Count deleted products
SELECT COUNT(*) as 'Deleted Products' FROM Products WHERE deleted_at IS NOT NULL;

-- Show all products with new timestamp columns
SELECT id, name, created_at, updated_at, deleted_at 
FROM Products 
ORDER BY id 
LIMIT 10; 