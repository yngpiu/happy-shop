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
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    fullname VARCHAR(255) NOT NULL,
    telephone VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    photo VARCHAR(500),
    activated BOOLEAN DEFAULT TRUE,
    admin BOOLEAN DEFAULT FALSE,
    is_banned BOOLEAN DEFAULT FALSE,
    
    -- Indexes for performance
    INDEX idx_users_email (email),
    INDEX idx_users_activated (activated),
    INDEX idx_users_admin (admin)
);

-- ===== CATEGORIES TABLE =====
CREATE TABLE categories (
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
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    unit_price DECIMAL(15,2) NOT NULL,
    image VARCHAR(500),
    product_date DATE,
    available BOOLEAN DEFAULT TRUE,
    quantity INT DEFAULT 0,
    description TEXT,
    discount DECIMAL(5,2) DEFAULT 0.00,
    view_count INT DEFAULT 0,
    special BOOLEAN DEFAULT FALSE,
    category_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    
    -- Indexes for performance
    INDEX idx_products_name (name),
    INDEX idx_products_category (category_id),
    INDEX idx_products_available (available),
    INDEX idx_products_special (special),
    INDEX idx_products_deleted_at (deleted_at),
    INDEX idx_products_active (deleted_at), -- For soft delete queries
    INDEX idx_products_price (unit_price),
    INDEX idx_products_view_count (view_count),
    INDEX idx_products_discount (discount)
);

-- ===== ORDERS TABLE =====
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    telephone VARCHAR(50),
    address TEXT,
    amount DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    description TEXT,
    status INT DEFAULT 0, -- -1: Cancelled, 0: Pending, 1: Processing, 2: Shipping, 3: Completed
    user_id VARCHAR(50) NOT NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    
    -- Indexes for performance
    INDEX idx_orders_user (user_id),
    INDEX idx_orders_date (order_date),
    INDEX idx_orders_status (status),
    INDEX idx_orders_amount (amount)
);

-- ===== ORDER DETAILS TABLE =====
CREATE TABLE order_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    unit_price DECIMAL(15,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    discount DECIMAL(5,2) DEFAULT 0.00,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    
    -- Indexes for performance
    INDEX idx_order_details_order (order_id),
    INDEX idx_order_details_product (product_id),
    INDEX idx_order_details_combo (order_id, product_id) -- For unique constraint and performance
);

-- ===== SAMPLE DATA =====

-- Insert sample categories
INSERT INTO categories (name) VALUES 
('Điện thoại'),
('Laptop'),
('Tablet'),
('Phụ kiện'),
('Smartwatch');

-- Insert sample user (admin)
INSERT INTO users (id, password, fullname, telephone, email, admin, activated) VALUES 
('admin', '123456', 'Administrator', '0123456789', 'admin@tech-shop.com', TRUE, TRUE),
('user1', '123456', 'Nguyễn Văn A', '0987654321', 'user1@gmail.com', FALSE, TRUE);

-- Insert sample products
INSERT INTO products (name, unit_price, image, product_date, available, quantity, description, discount, special, category_id) VALUES 
('iPhone 14 Pro Max', 25000000, 'iphone14.jpg', '2023-01-15', TRUE, 50, 'iPhone 14 Pro Max 128GB - Màu Đen', 5.0, TRUE, 1),
('Samsung Galaxy S23', 20000000, 'samsung-s23.jpg', '2023-02-01', TRUE, 30, 'Samsung Galaxy S23 256GB - Màu Trắng', 10.0, TRUE, 1),
('MacBook Pro M2', 45000000, 'macbook-pro-m2.jpg', '2023-01-20', TRUE, 20, 'MacBook Pro 13" M2 256GB', 0.0, FALSE, 2),
('Dell XPS 13', 25000000, 'dell-xps13.jpg', '2023-02-10', TRUE, 15, 'Dell XPS 13 Intel i7 16GB RAM', 8.0, FALSE, 2),
('iPad Pro M2', 22000000, 'ipad-pro-m2.jpg', '2023-01-25', TRUE, 25, 'iPad Pro 11" M2 128GB', 0.0, TRUE, 3);

-- Insert sample orders
INSERT INTO orders (order_date, telephone, address, amount, description, status, user_id) VALUES 
('2023-03-01', '0123456789', '123 Nguyễn Văn Cừ, Q1, TP.HCM', 25000000, 'Đơn hàng test', 3, 'user1'),
('2023-03-02', '0987654321', '456 Lê Văn Việt, Q9, TP.HCM', 45000000, 'Mua laptop', 1, 'user1');

-- Insert sample order details
INSERT INTO order_details (unit_price, quantity, discount, order_id, product_id) VALUES 
(25000000, 1, 5.0, 1, 1),
(45000000, 1, 0.0, 2, 3);

-- ===== PERFORMANCE OPTIMIZATION =====

-- Add composite indexes for common queries
ALTER TABLE products ADD INDEX idx_products_category_active (category_id, deleted_at);
ALTER TABLE products ADD INDEX idx_products_special_active (special, deleted_at);
ALTER TABLE orders ADD INDEX idx_orders_user_status (user_id, status);
ALTER TABLE orders ADD INDEX idx_orders_user_date (user_id, order_date);

-- ===== STORED PROCEDURES =====

-- Procedure to get revenue by category
DELIMITER $$
CREATE PROCEDURE GetRevenueByCategory()
BEGIN
    SELECT 
        c.name AS category_name,
        SUM(od.quantity) AS total_quantity,
        SUM(od.unit_price * od.quantity * (1 - od.discount/100)) AS total_revenue,
        MIN(od.unit_price) AS min_price,
        MAX(od.unit_price) AS max_price,
        AVG(od.unit_price) AS avg_price
    FROM order_details od
    JOIN products p ON od.product_id = p.id
    JOIN categories c ON p.category_id = c.id
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
        SUM(p.unit_price * p.quantity) AS total_value,
        MIN(p.unit_price) AS min_price,
        MAX(p.unit_price) AS max_price,
        AVG(p.unit_price) AS avg_price,
        COUNT(p.id) AS product_count
    FROM products p
    JOIN categories c ON p.category_id = c.id
    WHERE p.deleted_at IS NULL
    GROUP BY c.id, c.name
    ORDER BY total_value DESC;
END$$
DELIMITER ;

-- ===== TRIGGERS =====

-- Trigger to update order amount when order details change
DELIMITER $$
CREATE TRIGGER tr_update_order_amount
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
    UPDATE orders 
    SET amount = (
        SELECT SUM(unit_price * quantity * (1 - discount/100))
        FROM order_details 
        WHERE order_id = NEW.order_id
    )
    WHERE id = NEW.order_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_update_order_amount_on_update
AFTER UPDATE ON order_details
FOR EACH ROW
BEGIN
    UPDATE orders 
    SET amount = (
        SELECT SUM(unit_price * quantity * (1 - discount/100))
        FROM order_details 
        WHERE order_id = NEW.order_id
    )
    WHERE id = NEW.order_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER tr_update_order_amount_on_delete
AFTER DELETE ON order_details
FOR EACH ROW
BEGIN
    UPDATE orders 
    SET amount = COALESCE((
        SELECT SUM(unit_price * quantity * (1 - discount/100))
        FROM order_details 
        WHERE order_id = OLD.order_id
    ), 0)
    WHERE id = OLD.order_id;
END$$
DELIMITER ;

-- ===== VIEWS =====

-- View for active products
CREATE VIEW v_active_products AS
SELECT p.*, c.name AS category_name
FROM products p
JOIN categories c ON p.category_id = c.id
WHERE p.deleted_at IS NULL;

-- View for active categories
CREATE VIEW v_active_categories AS
SELECT * FROM categories
WHERE deleted_at IS NULL;

-- View for order summary
CREATE VIEW v_order_summary AS
SELECT 
    o.id,
    o.order_date,
    o.user_id,
    u.fullname AS customer_name,
    o.amount,
    o.status,
    COUNT(od.id) AS item_count
FROM orders o
JOIN users u ON o.user_id = u.id
LEFT JOIN order_details od ON o.id = od.order_id
GROUP BY o.id, o.order_date, o.user_id, u.fullname, o.amount, o.status;

-- ===== COMPLETION MESSAGE =====
SELECT 'Happy Shop Database Created Successfully!' AS message;
SELECT 'Database Name: tech_shop' AS info;
SELECT 'Default Admin User: admin / 123456' AS admin_info;
SELECT 'Default Test User: user1 / 123456' AS user_info; 