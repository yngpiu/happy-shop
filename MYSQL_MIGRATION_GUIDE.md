# Happy Shop - MySQL Migration Guide

## Tổng quan

Hướng dẫn này sẽ giúp bạn migrate từ SQL Server sang MySQL cho project Happy Shop E-commerce.

## Các thay đổi đã thực hiện

### 1. Dependencies (pom.xml)

```xml
<!-- Thay thế SQL Server driver -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <scope>runtime</scope>
</dependency>
```

### 2. Database Configuration (datasource.properties)

```properties
# MySQL Configuration
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/tech_shop?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=root
db.password=123123
hb.show-sql=false
hb.ddl-auto=update
hb.dialect=org.hibernate.dialect.MySQL8Dialect
hb.session=org.springframework.orm.hibernate5.SpringSessionContext
```

## Các bước thực hiện Migration

### Bước 1: Cài đặt MySQL Server

1. Tải và cài đặt MySQL Server 8.0+
2. Thiết lập root password là `123123` hoặc thay đổi trong `datasource.properties`
3. Khởi động MySQL service

### Bước 2: Tạo Database

1. Mở MySQL Workbench hoặc MySQL Command Line
2. Chạy script `mysql_database_script.sql`

```bash
mysql -u root -p < mysql_database_script.sql
```

### Bước 3: Kiểm tra kết nối

1. Restart ứng dụng
2. Kiểm tra log không có lỗi database connection
3. Truy cập admin panel để verify data

## Cấu trúc Database

### Bảng chính:

- **Users**: Quản lý người dùng và admin
- **Categories**: Danh mục sản phẩm (có soft delete)
- **Products**: Sản phẩm (có soft delete)
- **Orders**: Đơn hàng
- **OrderDetails**: Chi tiết đơn hàng

### Tính năng đặc biệt:

- **Soft Delete**: Categories và Products hỗ trợ xóa mềm
- **Auto Timestamps**: Tự động cập nhật created_at, updated_at
- **Triggers**: Tự động tính toán tổng tiền đơn hàng
- **Views**: Simplified queries cho frontend
- **Stored Procedures**: Báo cáo doanh thu và tồn kho

## Sample Data

### Admin User:

- **Username**: admin
- **Password**: 123456

### Test User:

- **Username**: user1
- **Password**: 123456

### Sample Products:

- iPhone 14 Pro Max (25,000,000 VND)
- Samsung Galaxy S23 (20,000,000 VND)
- MacBook Pro M2 (45,000,000 VND)
- Dell XPS 13 (25,000,000 VND)
- iPad Pro M2 (22,000,000 VND)

## Khác biệt chính giữa SQL Server và MySQL

### 1. Data Types

- `NVARCHAR` → `VARCHAR` với `utf8mb4` charset
- `BIT` → `BOOLEAN`
- `MONEY` → `DECIMAL(15,2)`
- `DATETIME` → `TIMESTAMP`

### 2. Identity/Auto Increment

- SQL Server: `IDENTITY(1,1)`
- MySQL: `AUTO_INCREMENT`

### 3. Schema

- SQL Server: sử dụng schema `dbo`
- MySQL: sử dụng database trực tiếp

### 4. String Functions

- SQL Server: `LEN()`, `SUBSTRING()`
- MySQL: `LENGTH()`, `SUBSTR()`

## Performance Optimizations

### Indexes được tạo:

- Primary keys và foreign keys
- Indexes cho các trường thường search (name, email, category)
- Composite indexes cho các query phức tạp
- Indexes cho soft delete queries

### Views được tạo:

- `v_active_products`: Sản phẩm active với tên category
- `v_active_categories`: Categories active
- `v_order_summary`: Tổng quan đơn hàng

## Troubleshooting

### Lỗi kết nối MySQL:

1. Kiểm tra MySQL service đang chạy
2. Verify username/password
3. Kiểm tra port 3306 không bị block
4. Thêm `allowPublicKeyRetrieval=true` vào connection string

### Lỗi Character Set:

1. Đảm bảo database được tạo với `utf8mb4`
2. Kiểm tra connection string có charset parameter

### Lỗi Timezone:

1. Thêm `serverTimezone=UTC` vào connection string
2. Hoặc set timezone cho MySQL server

## Migration Checklist

- [ ] Cài đặt MySQL Server 8.0+
- [ ] Update pom.xml với MySQL connector
- [ ] Update datasource.properties
- [ ] Chạy mysql_database_script.sql
- [ ] Test database connection
- [ ] Verify all CRUD operations
- [ ] Test admin panel functionality
- [ ] Verify reports and statistics
- [ ] Test ordering process
- [ ] Check soft delete functionality

## Backup và Rollback

### Tạo backup MySQL:

```bash
mysqldump -u root -p tech_shop > tech_shop_backup.sql
```

### Restore từ backup:

```bash
mysql -u root -p tech_shop < tech_shop_backup.sql
```

### Rollback về SQL Server:

1. Restore old pom.xml
2. Restore old datasource.properties
3. Restart SQL Server service
4. Restore SQL Server database

## Support

Nếu gặp vấn đề trong quá trình migration, vui lòng:

1. Kiểm tra log file chi tiết
2. Verify tất cả configuration files
3. Test từng component một cách riêng lẻ
4. Tham khảo MySQL documentation

## Performance Monitoring

### Query để monitor performance:

```sql
-- Check slow queries
SELECT * FROM mysql.slow_log;

-- Check table sizes
SELECT
    table_name,
    round(((data_length + index_length) / 1024 / 1024), 2) "DB Size in MB"
FROM information_schema.tables
WHERE table_schema = "tech_shop";

-- Check index usage
SELECT * FROM sys.schema_unused_indexes WHERE object_schema = 'tech_shop';
```

---

**Lưu ý**: Migration này đã được test với MySQL 8.0 và Spring Boot 2.2.2. Đảm bảo backup data trước khi thực hiện migration production.
