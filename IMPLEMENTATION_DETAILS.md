# 💻 Implementation Details - Deep Dive Code Analysis

## 📑 Mục Lục

- [1. Database Schema & Relationships](#1-database-schema--relationships)
- [2. DAO Implementation Deep Dive](#2-dao-implementation-deep-dive)
- [3. Controller Logic Breakdown](#3-controller-logic-breakdown)
- [4. Frontend Integration](#4-frontend-integration)
- [5. Security & Validation](#5-security--validation)
- [6. Advanced Features](#6-advanced-features)

---

## 1. Database Schema & Relationships

### 1.1 Categories Table Structure

```sql
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    INDEX idx_deleted_at (deleted_at),
    INDEX idx_created_at (created_at)
);
```

### 1.2 Products Table Structure

```sql
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    image VARCHAR(255),
    product_date DATE,
    available BOOLEAN DEFAULT TRUE,
    quantity INT DEFAULT 0,
    description TEXT,
    discount DECIMAL(5,2) DEFAULT 0,
    view_count INT DEFAULT 0,
    special BOOLEAN DEFAULT FALSE,
    category_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP NULL,

    FOREIGN KEY (category_id) REFERENCES categories(id),
    INDEX idx_category_id (category_id),
    INDEX idx_deleted_at (deleted_at),
    INDEX idx_available (available),
    INDEX idx_special (special)
);
```

### 1.3 Relationship Mapping Analysis

```java
// Category Entity - One-to-Many Relationship
@Entity
public class Category {
    @OneToMany(mappedBy="category")
    List<Product> products;  // Lazy loading by default

    // Hibernate sẽ generate query:
    // SELECT * FROM products WHERE category_id = ? AND deleted_at IS NULL
}

// Product Entity - Many-to-One Relationship
@Entity
public class Product {
    @ManyToOne
    @JoinColumn(name="category_id")
    Category category;  // Eager loading by default for @ManyToOne

    // Hibernate sẽ generate query với JOIN:
    // SELECT p.*, c.* FROM products p LEFT JOIN categories c ON p.category_id = c.id
}
```

---

## 2. DAO Implementation Deep Dive

### 2.1 CategoryDAOImpl - Complete Implementation

```java
@Repository
@Transactional
public class CategoryDAOImpl implements CategoryDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public Category findById(Integer id) {
        // Sử dụng EntityManager.find() - tự động cache trong session
        Category category = entityManager.find(Category.class, id);

        // Kiểm tra soft delete
        if (category != null && category.isDeleted()) {
            return null;  // Treat deleted items as not found
        }

        return category;
    }

    @Override
    public List<Category> findAllActive() {
        // JPQL Query với explicit ordering
        String jpql = "SELECT c FROM Category c " +
                     "WHERE c.deletedAt IS NULL " +
                     "ORDER BY c.createdAt DESC";

        TypedQuery<Category> query = entityManager.createQuery(jpql, Category.class);

        // Hibernate sẽ generate SQL:
        // SELECT c.id, c.name, c.created_at, c.updated_at, c.deleted_at
        // FROM categories c
        // WHERE c.deleted_at IS NULL
        // ORDER BY c.created_at DESC

        return query.getResultList();
    }

    @Override
    public Category create(Category entity) {
        // Validation trước khi persist
        if (entity.getName() == null || entity.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Category name cannot be empty");
        }

        // Check duplicate name
        String checkDuplicateJpql = "SELECT COUNT(c) FROM Category c " +
                                   "WHERE c.name = :name AND c.deletedAt IS NULL";
        Long count = entityManager.createQuery(checkDuplicateJpql, Long.class)
                                 .setParameter("name", entity.getName())
                                 .getSingleResult();

        if (count > 0) {
            throw new DataIntegrityViolationException("Category name already exists");
        }

        // Persist entity - @PrePersist sẽ tự động set timestamps
        entityManager.persist(entity);

        // Flush để get generated ID
        entityManager.flush();

        return entity;
    }

    @Override
    public void softDelete(Integer id) {
        // Bulk update query - hiệu quả hơn load entity rồi update
        String jpql = "UPDATE Category c SET c.deletedAt = :now " +
                     "WHERE c.id = :id AND c.deletedAt IS NULL";

        int updatedRows = entityManager.createQuery(jpql)
                                     .setParameter("now", new Date())
                                     .setParameter("id", id)
                                     .executeUpdate();

        if (updatedRows == 0) {
            throw new EntityNotFoundException("Category not found or already deleted");
        }

        // Clear cache để đảm bảo consistency
        entityManager.clear();
    }

    @Override
    public Long countProductsByCategory(Integer categoryId) {
        // Native query cho performance tốt hơn
        String sql = "SELECT COUNT(*) FROM products " +
                    "WHERE category_id = ? AND deleted_at IS NULL";

        Query nativeQuery = entityManager.createNativeQuery(sql);
        nativeQuery.setParameter(1, categoryId);

        BigInteger result = (BigInteger) nativeQuery.getSingleResult();
        return result.longValue();
    }
}
```

### 2.2 ProductDAOImpl - Advanced Queries

```java
@Repository
@Transactional
public class ProductDAOImpl implements ProductDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Product> findByKeywords(String keywords) {
        // Full-text search với LIKE patterns
        String jpql = "SELECT p FROM Product p " +
                     "WHERE p.deletedAt IS NULL " +
                     "AND (LOWER(p.name) LIKE LOWER(:keywords) " +
                     "OR LOWER(p.description) LIKE LOWER(:keywords)) " +
                     "ORDER BY p.createdAt DESC";

        return entityManager.createQuery(jpql, Product.class)
                           .setParameter("keywords", "%" + keywords + "%")
                           .getResultList();
    }

    @Override
    public List<Product> findSpecialProducts(int limit) {
        // Query với JOIN FETCH để tránh N+1 problem
        String jpql = "SELECT p FROM Product p JOIN FETCH p.category " +
                     "WHERE p.deletedAt IS NULL " +
                     "AND p.special = true " +
                     "AND p.available = true " +
                     "ORDER BY p.createdAt DESC";

        return entityManager.createQuery(jpql, Product.class)
                           .setMaxResults(limit)
                           .getResultList();
    }

    @Override
    public void create(Product entity) {
        // Business logic validation
        validateProduct(entity);

        // Set default values nếu null
        if (entity.getViewCount() == null) {
            entity.setViewCount(0);
        }

        if (entity.getAvailable() == null) {
            entity.setAvailable(true);
        }

        // Auto-set availability based on quantity
        if (entity.getQuantity() != null && entity.getQuantity() <= 0) {
            entity.setAvailable(false);
        }

        entityManager.persist(entity);
        entityManager.flush();
    }

    private void validateProduct(Product product) {
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Product name is required");
        }

        if (product.getUnitPrice() == null || product.getUnitPrice() <= 0) {
            throw new IllegalArgumentException("Unit price must be greater than 0");
        }

        if (product.getDiscount() != null &&
            (product.getDiscount() < 0 || product.getDiscount() > 100)) {
            throw new IllegalArgumentException("Discount must be between 0 and 100");
        }

        if (product.getCategory() == null) {
            throw new IllegalArgumentException("Category is required");
        }
    }
}
```

---

## 3. Controller Logic Breakdown

### 3.1 Request Processing Pipeline

```java
@Controller
@RequestMapping("/admin/category")
public class CategoryMangerController {

    @Autowired
    CategoryDAO dao;

    // 1. GET Request Handler - Display Form
    @RequestMapping(value = "/insert", method = RequestMethod.GET)
    public String insert(Model model) {
        // Tạo empty entity cho form binding
        Category entity = new Category();
        model.addAttribute("entity", entity);

        // Thêm metadata cho view
        addStatisticsToModel(model);

        return "admin/category/insert";
    }

    // 2. POST Request Handler - Process Form
    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    public String insert(RedirectAttributes redirectAttributes,
                        @ModelAttribute("entity") Category entity,
                        BindingResult bindingResult) {

        // Step 1: Validation
        if (bindingResult.hasErrors()) {
            // Có lỗi validation - return về form
            redirectAttributes.addFlashAttribute("entity", entity);
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());
            return "redirect:/admin/category/insert";
        }

        try {
            // Step 2: Business Logic
            preprocessCategory(entity);

            // Step 3: Database Operation
            dao.create(entity);

            // Step 4: Success Response
            redirectAttributes.addFlashAttribute("message",
                "Thêm mới loại sản phẩm '" + entity.getName() + "' thành công!");
            redirectAttributes.addFlashAttribute("messageType", "success");

            // Step 5: Redirect (PRG Pattern)
            return "redirect:/admin/category/index";

        } catch (DataIntegrityViolationException e) {
            // Handle specific database errors
            handleDatabaseError(e, redirectAttributes);
            return "redirect:/admin/category/insert";

        } catch (Exception e) {
            // Handle general errors
            handleGeneralError(e, redirectAttributes);
            return "redirect:/admin/category/insert";
        }
    }

    private void preprocessCategory(Category entity) {
        // Trim whitespace
        if (entity.getName() != null) {
            entity.setName(entity.getName().trim());
        }

        // Additional business logic
        // e.g., capitalize first letter, validate format, etc.
    }

    private void handleDatabaseError(DataIntegrityViolationException e,
                                   RedirectAttributes redirectAttributes) {
        String message;
        if (e.getMessage().contains("Duplicate entry")) {
            message = "Tên loại sản phẩm đã tồn tại!";
        } else if (e.getMessage().contains("foreign key constraint")) {
            message = "Không thể thực hiện do ràng buộc dữ liệu!";
        } else {
            message = "Lỗi cơ sở dữ liệu!";
        }

        redirectAttributes.addFlashAttribute("error", message);
        redirectAttributes.addFlashAttribute("messageType", "error");
    }
}
```

### 3.2 Advanced Controller Features

```java
// Bulk Operations Support
@RequestMapping(value = "/bulk-delete", method = RequestMethod.POST)
public String bulkDelete(@RequestParam("selectedIds") List<Integer> ids,
                        RedirectAttributes redirectAttributes) {

    if (ids == null || ids.isEmpty()) {
        redirectAttributes.addFlashAttribute("error", "Vui lòng chọn ít nhất một mục!");
        return "redirect:/admin/category/index";
    }

    try {
        int successCount = 0;
        int errorCount = 0;
        List<String> errorMessages = new ArrayList<>();

        for (Integer id : ids) {
            try {
                // Check if category has products
                Long productCount = dao.countProductsByCategory(id);
                if (productCount > 0) {
                    errorCount++;
                    errorMessages.add("ID " + id + " có " + productCount + " sản phẩm");
                    continue;
                }

                dao.softDelete(id);
                successCount++;

            } catch (Exception e) {
                errorCount++;
                errorMessages.add("ID " + id + ": " + e.getMessage());
            }
        }

        // Build result message
        StringBuilder message = new StringBuilder();
        if (successCount > 0) {
            message.append("Đã xóa thành công ").append(successCount).append(" mục. ");
        }
        if (errorCount > 0) {
            message.append("Có ").append(errorCount).append(" mục không thể xóa: ")
                   .append(String.join(", ", errorMessages));
        }

        redirectAttributes.addFlashAttribute(successCount > 0 ? "message" : "error",
                                           message.toString());

    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
    }

    return "redirect:/admin/category/index";
}

// AJAX Support for Dynamic Updates
@RequestMapping(value = "/ajax/count-products/{id}", method = RequestMethod.GET)
@ResponseBody
public Map<String, Object> getProductCount(@PathVariable("id") Integer id) {
    Map<String, Object> response = new HashMap<>();

    try {
        Long count = dao.countProductsByCategory(id);
        response.put("success", true);
        response.put("count", count);
        response.put("canDelete", count == 0);

    } catch (Exception e) {
        response.put("success", false);
        response.put("error", e.getMessage());
    }

    return response;
}
```

---

## 4. Frontend Integration

### 4.1 JSP Template Structure

```jsp
<%-- admin/category/index.jsp --%>
<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý loại sản phẩm</title>
    <!-- Bootstrap CSS -->
    <link href="/static/bower_components/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="/static/css/admin.css" rel="stylesheet">
</head>
<body>
    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <h3 class="mb-0">${totalCategories}</h3>
                    <small>Tổng số loại</small>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <h3 class="mb-0">${activeCategories}</h3>
                    <small>Đang hoạt động</small>
                </div>
            </div>
        </div>
        <!-- More cards... -->
    </div>

    <!-- Data Table -->
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h5 class="mb-0">Danh sách loại sản phẩm</h5>
            <div>
                <!-- Filter Buttons -->
                <div class="btn-group" role="group">
                    <a href="?filter=all" class="btn btn-outline-secondary ${currentFilter == 'all' ? 'active' : ''}">
                        Tất cả
                    </a>
                    <a href="?filter=active" class="btn btn-outline-success ${currentFilter == 'active' ? 'active' : ''}">
                        Hoạt động
                    </a>
                    <a href="?filter=deleted" class="btn btn-outline-danger ${currentFilter == 'deleted' ? 'active' : ''}">
                        Đã xóa
                    </a>
                </div>

                <!-- Action Buttons -->
                <a href="/admin/category/insert" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> Thêm mới
                </a>
            </div>
        </div>

        <div class="card-body">
            <table class="table table-striped table-hover" id="categoryTable">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" class="form-check-input">
                        </th>
                        <th>ID</th>
                        <th>Tên loại sản phẩm</th>
                        <th>Số sản phẩm</th>
                        <th>Ngày tạo</th>
                        <th>Trạng thái</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="category" items="${list}">
                        <tr data-id="${category.id}" class="${category.deleted ? 'table-secondary' : ''}">
                            <td>
                                <input type="checkbox" name="selectedIds" value="${category.id}"
                                       class="form-check-input row-checkbox">
                            </td>
                            <td>${category.id}</td>
                            <td>
                                <strong>${category.name}</strong>
                                <c:if test="${category.deleted}">
                                    <span class="badge bg-danger ms-2">Đã xóa</span>
                                </c:if>
                            </td>
                            <td>
                                <span class="badge bg-info">${productCounts[category.id]}</span>
                            </td>
                            <td>
                                <f:formatDate value="${category.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${category.deleted}">
                                        <span class="badge bg-danger">Đã xóa</span>
                                        <small class="text-muted d-block">
                                            ${category.daysSinceDeleted} ngày trước
                                        </small>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-success">Hoạt động</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="btn-group btn-group-sm" role="group">
                                    <c:choose>
                                        <c:when test="${category.deleted}">
                                            <!-- Restore Button -->
                                            <button type="button" class="btn btn-outline-success"
                                                    onclick="restoreCategory(${category.id})"
                                                    title="Khôi phục">
                                                <i class="bi bi-arrow-clockwise"></i>
                                            </button>
                                            <!-- Permanent Delete Button -->
                                            <button type="button" class="btn btn-outline-danger"
                                                    onclick="permanentDeleteCategory(${category.id})"
                                                    title="Xóa vĩnh viễn">
                                                <i class="bi bi-trash3"></i>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Edit Button -->
                                            <a href="/admin/category/edit/${category.id}"
                                               class="btn btn-outline-primary" title="Chỉnh sửa">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <!-- Delete Button -->
                                            <button type="button" class="btn btn-outline-danger"
                                                    onclick="deleteCategory(${category.id}, '${category.name}', ${productCounts[category.id]})"
                                                    title="Xóa">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- JavaScript -->
    <script src="/static/bower_components/jquery/jquery.min.js"></script>
    <script src="/static/bower_components/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        // Category Management JavaScript
        function deleteCategory(id, name, productCount) {
            if (productCount > 0) {
                if (!confirm(`Loại sản phẩm "${name}" có ${productCount} sản phẩm. Bạn có chắc muốn xóa?`)) {
                    return;
                }
            } else {
                if (!confirm(`Bạn có chắc muốn xóa loại sản phẩm "${name}"?`)) {
                    return;
                }
            }

            // Create form and submit
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = `/admin/category/delete/${id}`;

            // Add CSRF token if needed
            const csrfToken = document.querySelector('meta[name="_csrf"]');
            if (csrfToken) {
                const csrfInput = document.createElement('input');
                csrfInput.type = 'hidden';
                csrfInput.name = '_csrf';
                csrfInput.value = csrfToken.getAttribute('content');
                form.appendChild(csrfInput);
            }

            document.body.appendChild(form);
            form.submit();
        }

        function restoreCategory(id) {
            if (confirm('Bạn có chắc muốn khôi phục loại sản phẩm này?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = `/admin/category/restore/${id}`;
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Bulk operations
        document.getElementById('selectAll').addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.row-checkbox');
            checkboxes.forEach(cb => cb.checked = this.checked);
        });

        // Auto-hide alerts
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                alert.style.transition = 'opacity 0.5s';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 5000);
    </script>
</body>
</html>
```

---

## 5. Security & Validation

### 5.1 Input Validation

```java
// Entity Level Validation
@Entity
public class Category {
    @NotEmpty(message = "Tên loại sản phẩm không được để trống")
    @Size(min = 2, max = 100, message = "Tên loại sản phẩm phải từ 2-100 ký tự")
    @Pattern(regexp = "^[\\p{L}\\p{N}\\s\\-_]+$",
             message = "Tên loại sản phẩm chỉ được chứa chữ cái, số, khoảng trắng, dấu gạch ngang và gạch dưới")
    String name;
}

// Controller Level Validation
@RequestMapping(value = "/insert", method = RequestMethod.POST)
public String insert(@Valid @ModelAttribute("entity") Category entity,
                    BindingResult bindingResult,
                    RedirectAttributes redirectAttributes) {

    // Check validation errors
    if (bindingResult.hasErrors()) {
        StringBuilder errorMessage = new StringBuilder("Dữ liệu không hợp lệ: ");
        bindingResult.getAllErrors().forEach(error -> {
            errorMessage.append(error.getDefaultMessage()).append("; ");
        });

        redirectAttributes.addFlashAttribute("error", errorMessage.toString());
        redirectAttributes.addFlashAttribute("entity", entity);
        return "redirect:/admin/category/insert";
    }

    // Custom business validation
    if (isDuplicateName(entity.getName())) {
        redirectAttributes.addFlashAttribute("error", "Tên loại sản phẩm đã tồn tại!");
        return "redirect:/admin/category/insert";
    }

    // Proceed with creation...
}

private boolean isDuplicateName(String name) {
    try {
        String jpql = "SELECT COUNT(c) FROM Category c WHERE LOWER(c.name) = LOWER(:name) AND c.deletedAt IS NULL";
        Long count = entityManager.createQuery(jpql, Long.class)
                                 .setParameter("name", name.trim())
                                 .getSingleResult();
        return count > 0;
    } catch (Exception e) {
        return false;  // Assume no duplicate on error
    }
}
```

### 5.2 Security Implementation

```java
// Method Level Security
@PreAuthorize("hasRole('ADMIN')")
@RequestMapping("/admin/category/**")
public class CategoryMangerController {

    // CSRF Protection
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public String delete(@PathVariable("id") Integer id,
                        HttpServletRequest request,
                        RedirectAttributes redirectAttributes) {

        // Verify CSRF token
        String token = request.getParameter("_csrf");
        if (!csrfTokenRepository.loadToken(request).getToken().equals(token)) {
            throw new AccessDeniedException("Invalid CSRF token");
        }

        // Additional security checks
        if (!hasPermissionToDelete(id)) {
            throw new AccessDeniedException("Insufficient permissions");
        }

        // Proceed with deletion...
    }

    private boolean hasPermissionToDelete(Integer categoryId) {
        // Check if current user has permission to delete this category
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();

        // Custom permission logic
        return userService.hasAdminRole(username) &&
               !categoryService.isSystemCategory(categoryId);
    }
}

// SQL Injection Prevention
@Repository
public class CategoryDAOImpl {

    // Always use parameterized queries
    @Override
    public List<Category> findByNamePattern(String pattern) {
        // SAFE - Using parameter binding
        String jpql = "SELECT c FROM Category c WHERE LOWER(c.name) LIKE LOWER(:pattern)";
        return entityManager.createQuery(jpql, Category.class)
                           .setParameter("pattern", "%" + pattern + "%")
                           .getResultList();
    }

    // NEVER do this - vulnerable to SQL injection
    // String jpql = "SELECT c FROM Category c WHERE c.name LIKE '%" + pattern + "%'";
}
```

---

## 6. Advanced Features

### 6.1 Audit Trail Implementation

```java
// Audit Entity
@Entity
@Table(name = "audit_logs")
public class AuditLog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String entityType;      // "Category", "Product"
    private Integer entityId;       // ID of the affected entity
    private String action;          // "CREATE", "UPDATE", "DELETE", "RESTORE"
    private String oldValues;       // JSON of old values
    private String newValues;       // JSON of new values
    private String userId;          // Who performed the action
    private Date timestamp;         // When it happened
    private String ipAddress;       // From where
}

// Audit Service
@Service
public class AuditService {

    @Autowired
    private AuditLogRepository auditLogRepository;

    @Autowired
    private ObjectMapper objectMapper;

    public void logCategoryChange(String action, Category oldCategory, Category newCategory,
                                 String userId, String ipAddress) {
        try {
            AuditLog log = new AuditLog();
            log.setEntityType("Category");
            log.setEntityId(newCategory != null ? newCategory.getId() : oldCategory.getId());
            log.setAction(action);
            log.setUserId(userId);
            log.setIpAddress(ipAddress);
            log.setTimestamp(new Date());

            if (oldCategory != null) {
                log.setOldValues(objectMapper.writeValueAsString(oldCategory));
            }

            if (newCategory != null) {
                log.setNewValues(objectMapper.writeValueAsString(newCategory));
            }

            auditLogRepository.save(log);

        } catch (Exception e) {
            // Log error but don't fail the main operation
            logger.error("Failed to create audit log", e);
        }
    }
}

// Integration in Controller
@RequestMapping(value = "/update", method = RequestMethod.POST)
public String update(@ModelAttribute("entity") Category entity,
                    HttpServletRequest request,
                    RedirectAttributes redirectAttributes) {
    try {
        // Get old values for audit
        Category oldCategory = dao.findById(entity.getId());

        // Perform update
        dao.update(entity);

        // Log the change
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        String ipAddress = getClientIpAddress(request);
        auditService.logCategoryChange("UPDATE", oldCategory, entity, userId, ipAddress);

        redirectAttributes.addFlashAttribute("message", "Cập nhật thành công!");

    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
    }

    return "redirect:/admin/category/index";
}
```

### 6.2 Caching Strategy

```java
// Redis Cache Configuration
@Configuration
@EnableCaching
public class CacheConfig {

    @Bean
    public CacheManager cacheManager() {
        RedisCacheManager.Builder builder = RedisCacheManager
            .RedisCacheManagerBuilder
            .fromConnectionFactory(redisConnectionFactory())
            .cacheDefaults(cacheConfiguration());

        return builder.build();
    }

    private RedisCacheConfiguration cacheConfiguration() {
        return RedisCacheConfiguration.defaultCacheConfig()
            .entryTtl(Duration.ofMinutes(30))  // 30 minutes TTL
            .serializeKeysWith(RedisSerializationContext.SerializationPair
                .fromSerializer(new StringRedisSerializer()))
            .serializeValuesWith(RedisSerializationContext.SerializationPair
                .fromSerializer(new GenericJackson2JsonRedisSerializer()));
    }
}

// Service Layer with Caching
@Service
@Transactional
public class CategoryService {

    @Autowired
    private CategoryDAO categoryDAO;

    @Cacheable(value = "categories", key = "'active'")
    public List<Category> getActiveCategories() {
        return categoryDAO.findAllActive();
    }

    @Cacheable(value = "categories", key = "#id")
    public Category getCategoryById(Integer id) {
        return categoryDAO.findById(id);
    }

    @CacheEvict(value = "categories", allEntries = true)
    public void createCategory(Category category) {
        categoryDAO.create(category);
    }

    @CacheEvict(value = "categories", allEntries = true)
    public void updateCategory(Category category) {
        categoryDAO.update(category);
    }

    @CacheEvict(value = "categories", allEntries = true)
    public void deleteCategory(Integer id) {
        categoryDAO.softDelete(id);
    }
}
```

---

_Tài liệu implementation này cung cấp cái nhìn chi tiết về cách code được tổ chức và hoạt động trong thực tế, bao gồm các best practices và advanced features._
