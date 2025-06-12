-- SQL Server Script to update Users table structure
-- Run this script to fix data type issues and add new column

-- 1. Ensure telephone column is nvarchar type (fix the conversion error)
-- First check if we need to alter the column type
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Users') AND name = 'telephone' AND system_type_id != 231)
BEGIN
    -- If telephone is not nvarchar, alter it
    ALTER TABLE Users ALTER COLUMN telephone NVARCHAR(50);
    PRINT 'Updated telephone column to NVARCHAR(50)';
END
ELSE
BEGIN
    PRINT 'Telephone column is already NVARCHAR type';
END

-- 2. Add isBanned column if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Users') AND name = 'isBanned')
BEGIN
    ALTER TABLE Users ADD isBanned BIT DEFAULT 0;
    PRINT 'Added isBanned column';
    
    -- Set default value for existing records
    UPDATE Users SET isBanned = 0 WHERE isBanned IS NULL;
    PRINT 'Set default isBanned = 0 for existing users';
END
ELSE
BEGIN
    PRINT 'isBanned column already exists';
END

-- 3. Ensure other boolean columns have proper default values
UPDATE Users SET activated = 1 WHERE activated IS NULL;
UPDATE Users SET admin = 0 WHERE admin IS NULL;

PRINT 'Database schema update completed successfully!'; 