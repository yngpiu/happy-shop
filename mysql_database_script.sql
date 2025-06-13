-- ===== HAPPY SHOP E-COMMERCE DATABASE =====
-- MySQL Database Script
-- Compatible with MySQL 8.0+
-- Created for Happy Shop project migration from SQL Server

USE mysql;
DROP DATABASE IF EXISTS tech_shop;
CREATE DATABASE tech_shop 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

USE tech_shop;

-- ===== USERS TABLE =====
CREATE TABLE Users (
    Id VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(255) NOT NULL,
    Fullname VARCHAR(255) NOT NULL,
    Telephone VARCHAR(50) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Photo VARCHAR(500),
    Activated BOOLEAN DEFAULT TRUE,
    Admin BOOLEAN DEFAULT FALSE,
    isBanned BOOLEAN DEFAULT FALSE,
    
    -- Indexes for performance
    INDEX idx_users_email (Email),
    INDEX idx_users_activated (Activated),
    INDEX idx_users_admin (Admin)
);

-- ===== CATEGORIES TABLE =====
CREATE TABLE Categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    -- Indexes for performance
    INDEX idx_categories_name (name),
    INDEX idx_categories_deleted_at (deleted_at),
    INDEX idx_categories_active (deleted_at) -- For soft delete queries
);

-- ===== PRODUCTS TABLE =====
CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unitPrice DECIMAL(15,2) NOT NULL,
    image VARCHAR(500),
    productDate DATE,
    available BOOLEAN DEFAULT TRUE,
    quantity INT DEFAULT 0,
    description TEXT,
    discount DECIMAL(5,2) DEFAULT 0.00,
    viewCount INT DEFAULT 0,
    special BOOLEAN DEFAULT FALSE,
    categoryId INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (categoryId) REFERENCES Categories(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    
    -- Indexes for performance
    INDEX idx_products_name (name),
    INDEX idx_products_category (categoryId),
    INDEX idx_products_available (available),
    INDEX idx_products_special (special),
    INDEX idx_products_deleted_at (deleted_at),
    INDEX idx_products_active (deleted_at), -- For soft delete queries
    INDEX idx_products_price (unitPrice),
    INDEX idx_products_view_count (viewCount),
    INDEX idx_products_discount (discount)
);

-- ===== ORDERS TABLE =====
CREATE TABLE Orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orderDate DATE NOT NULL,
    telephone VARCHAR(50),
    address TEXT,
    amount DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    description TEXT,
    status INT DEFAULT 0, -- -1: Cancelled, 0: Pending, 1: Processing, 2: Shipping, 3: Completed
    userId VARCHAR(50) NOT NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (userId) REFERENCES Users(Id) ON DELETE RESTRICT ON UPDATE CASCADE,
    
    -- Indexes for performance
    INDEX idx_orders_user (userId),
    INDEX idx_orders_date (orderDate),
    INDEX idx_orders_status (status),
    INDEX idx_orders_amount (amount)
);

-- ===== ORDER DETAILS TABLE =====
CREATE TABLE OrderDetails (
    id INT AUTO_INCREMENT PRIMARY KEY,
    unitPrice DECIMAL(15,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    discount DECIMAL(5,2) DEFAULT 0.00,
    orderId INT NOT NULL,
    productId INT NOT NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (orderId) REFERENCES Orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (productId) REFERENCES Products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    
    -- Indexes for performance
    INDEX idx_order_details_order (orderId),
    INDEX idx_order_details_product (productId),
    INDEX idx_order_details_combo (orderId, productId) -- For unique constraint and performance
);

-- ===== SAMPLE DATA =====

-- Insert sample categories
INSERT INTO Categories (name) VALUES 
('Điện thoại'),
('Laptop'),
('Tablet'),
('Phụ kiện'),
('Smartwatch');

-- Insert sample user (admin)
INSERT INTO Users (Id, Password, Fullname, Telephone, Email, Admin, Activated) VALUES 
('admin', '123456', 'Administrator', '0123456789', 'admin@tech-shop.com', TRUE, TRUE),
('user1', '123456', 'Nguyễn Văn A', '0987654321', 'user1@gmail.com', FALSE, TRUE);

-- Insert sample products
INSERT INTO Products (name, unitPrice, image, productDate, available, quantity, description, discount, special, categoryId) VALUES 
('iPhone 14 Pro Max', 25000000, 'iphone14.jpg', '2023-01-15', TRUE, 50, 'iPhone 14 Pro Max 128GB - Màu Đen', 5.0, TRUE, 1),
('Samsung Galaxy S23', 20000000, 'samsung-s23.jpg', '2023-02-01', TRUE, 30, 'Samsung Galaxy S23 256GB - Màu Trắng', 10.0, TRUE, 1),
('MacBook Pro M2', 45000000, 'macbook-pro-m2.jpg', '2023-01-20', TRUE, 20, 'MacBook Pro 13" M2 256GB', 0.0, FALSE, 2),
('Dell XPS 13', 25000000, 'dell-xps13.jpg', '2023-02-10', TRUE, 15, 'Dell XPS 13 Intel i7 16GB RAM', 8.0, FALSE, 2),
('iPad Pro M2', 22000000, 'ipad-pro-m2.jpg', '2023-01-25', TRUE, 25, 'iPad Pro 11" M2 128GB', 0.0, TRUE, 3);

-- Insert sample orders
INSERT INTO Orders (orderDate, telephone, address, amount, description, status, userId) VALUES 
('2023-03-01', '0123456789', '123 Nguyễn Văn Cừ, Q1, TP.HCM', 25000000, 'Đơn hàng test', 3, 'user1'),
('2023-03-02', '0987654321', '456 Lê Văn Việt, Q9, TP.HCM', 45000000, 'Mua laptop', 1, 'user1');

-- Insert sample order details
INSERT INTO OrderDetails (unitPrice, quantity, discount, orderId, productId) VALUES 
(25000000, 1, 5.0, 1, 1),
(45000000, 1, 0.0, 2, 3);

-- ===== PERFORMANCE OPTIMIZATION =====

-- Add composite indexes for common queries
ALTER TABLE Products ADD INDEX idx_products_category_active (categoryId, deleted_at);
ALTER TABLE Products ADD INDEX idx_products_special_active (special, deleted_at);
ALTER TABLE Orders ADD INDEX idx_orders_user_status (userId, status);
ALTER TABLE Orders ADD INDEX idx_orders_user_date (userId, orderDate);

-- ===== STORED PROCEDURES =====

-- Procedure to get revenue by category
DELIMITER $$
CREATE PROCEDURE GetRevenueByCategory()
BEGIN
    SELECT 
        c.name AS category_name,
        SUM(od.quantity) AS total_quantity,
        SUM(od.unitPrice * od.quantity * (1 - od.discount/100)) AS total_revenue,
        MIN(od.unitPrice) AS min_price,
        MAX(od.unitPrice) AS max_price,
        AVG(od.unitPrice) AS avg_price
    FROM OrderDetails od
    JOIN Products p ON od.productId = p.id
    JOIN Categories c ON p.categoryId = c.id
    GROUP BY c.id, c.name
    ORDER BY total_revenue DESC;
END$$
DELIMITER ;

-- Procedure to get inventory report
DELIMITER $$
CREATE PROCEDURE GetInventoryReport()
BEGIN
    SELECT 
        c.name AS category_name,
        SUM(p.quantity) AS total_quantity,
        SUM(p.unitPrice * p.quantity) AS total_value,
        MIN(p.unitPrice) AS min_price,
        MAX(p.unitPrice) AS max_price,
        AVG(p.unitPrice) AS avg_price,
        COUNT(p.id) AS product_count
    FROM Products p
    JOIN Categories c ON p.categoryId = c.id
    WHERE p.deleted_at IS NULL
    GROUP BY c.id, c.name
    ORDER BY total_value DESC;
END$$
DELIMITER ;

-- ===== TRIGGERS =====

-- Trigger to update order amount when order details change
DELIMITER $$
CREATE TRIGGER tr_update_order_amount
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Orders 
    SET amount = (
        SELECT SUM(unitPrice * quantity * (1 - discount/100))
        FROM OrderDetails 
        WHERE orderId = NEW.orderId
    )
    WHERE id = NEW.orderId;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_update_order_amount_on_update
AFTER UPDATE ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Orders 
    SET amount = (
        SELECT SUM(unitPrice * quantity * (1 - discount/100))
        FROM OrderDetails 
        WHERE orderId = NEW.orderId
    )
    WHERE id = NEW.orderId;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_update_order_amount_on_delete
AFTER DELETE ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Orders 
    SET amount = COALESCE((
        SELECT SUM(unitPrice * quantity * (1 - discount/100))
        FROM OrderDetails 
        WHERE orderId = OLD.orderId
    ), 0)
    WHERE id = OLD.orderId;
END$$
DELIMITER ;

-- ===== VIEWS =====

-- View for active products
CREATE VIEW v_active_products AS
SELECT p.*, c.name AS category_name
FROM Products p
JOIN Categories c ON p.categoryId = c.id
WHERE p.deleted_at IS NULL;

-- View for active categories
CREATE VIEW v_active_categories AS
SELECT * FROM Categories
WHERE deleted_at IS NULL;

-- View for order summary
CREATE VIEW v_order_summary AS
SELECT 
    o.id,
    o.orderDate,
    o.userId,
    u.Fullname AS customer_name,
    o.amount,
    o.status,
    COUNT(od.id) AS item_count
FROM Orders o
JOIN Users u ON o.userId = u.Id
LEFT JOIN OrderDetails od ON o.id = od.orderId
GROUP BY o.id, o.orderDate, o.userId, u.Fullname, o.amount, o.status;

-- ===== COMPLETION MESSAGE =====
SELECT 'Happy Shop Database Created Successfully!' AS message;
SELECT 'Database Name: tech_shop' AS info;
SELECT 'Default Admin User: admin / 123456' AS admin_info;
SELECT 'Default Test User: user1 / 123456' AS user_info; 