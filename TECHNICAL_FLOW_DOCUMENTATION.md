# 🔧 Tài Liệu Kỹ Thuật - Luồng Hoạt Động & Code Architecture

## 📑 Mục Lục

- [1. Kiến Trúc Tổng Quan](#1-kiến-trúc-tổng-quan)
- [2. Luồng Quản Lý Category](#2-luồng-quản-lý-category)
- [3. Luồng Quản Lý Product](#3-luồng-quản-lý-product)
- [4. Soft Delete System](#4-soft-delete-system)
- [5. Data Flow & Processing](#5-data-flow--processing)
- [6. Error Handling & Validation](#6-error-handling--validation)

---

## 1. Kiến Trúc Tổng Quan

### 🏗️ Architecture Pattern: MVC + DAO

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   JSP Views     │◄───┤   Controllers   │◄───┤   Services      │
│   (Presentation)│    │   (Web Layer)   │    │   (Business)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                ▲                       ▲
                                │                       │
                       ┌─────────────────┐    ┌─────────────────┐
                       │   Model/Entity  │    │   DAO Layer     │
                       │   (Data Model)  │    │   (Data Access) │
                       └─────────────────┘    └─────────────────┘
                                                       ▲
                                              ┌─────────────────┐
                                              │   Database      │
                                              │   (MySQL)       │
                                              └─────────────────┘
```

### 🔄 Request Processing Flow

```
1. HTTP Request → Spring DispatcherServlet
2. DispatcherServlet → Controller Method
3. Controller → DAO Layer
4. DAO → Database Query
5. Database → Result Set
6. DAO → Entity Objects
7. Controller → Model Attributes
8. Controller → View Name
9. ViewResolver → JSP Page
10. JSP → HTML Response
```

---

## 2. Luồng Quản Lý Category

### 2.1 Entity Structure - Category.java

```java
@Entity
@Table(name = "categories")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;                    // Primary Key, Auto Increment

    @Column(name = "name")
    String name;                   // Category Name

    @Column(name = "created_at")
    @Temporal(TemporalType.TIMESTAMP)
    Date createdAt;               // Creation Timestamp

    @Column(name = "updated_at")
    @Temporal(TemporalType.TIMESTAMP)
    Date updatedAt;               // Last Update Timestamp

    @Column(name = "deleted_at")
    @Temporal(TemporalType.TIMESTAMP)
    Date deletedAt;               // Soft Delete Timestamp (NULL = Active)

    @OneToMany(mappedBy="category")
    List<Product> products;       // Related Products
}
```

**🔍 Phân Tích Code:**

- **Soft Delete Pattern**: `deletedAt` field để đánh dấu xóa mềm
- **Lifecycle Hooks**: `@PrePersist`, `@PreUpdate` tự động set timestamp
- **Relationship**: One-to-Many với Product entity
- **Helper Methods**: `isDeleted()`, `isActive()`, `getDaysSinceDeleted()`

### 2.2 DAO Layer - CategoryDAO Interface

```java
public interface CategoryDAO {
    // CRUD Operations
    Category findById(Integer id);
    List<Category> findAll();
    List<Category> findAllActive();      // WHERE deleted_at IS NULL
    List<Category> findAllDeleted();     // WHERE deleted_at IS NOT NULL
    Category create(Category entity);
    void update(Category entity);

    // Soft Delete Operations
    void softDelete(Integer id);         // SET deleted_at = NOW()
    void restore(Integer id);            // SET deleted_at = NULL
    void permanentDelete(Integer id);    // DELETE FROM categories

    // Statistics
    Long countProductsByCategory(Integer categoryId);
    Long countAll();
    Long countActive();
    Long countDeleted();
}
```

### 2.3 Controller Layer - CategoryMangerController

#### 2.3.1 Hiển Thị Danh Sách Categories

```java
@RequestMapping(value = {"/index", "/"}, method = RequestMethod.GET)
public String index(Model model, @RequestParam(value = "filter", defaultValue = "all") String filter) {
    // 1. Tạo entity trống cho form
    Category entity = new Category();
    model.addAttribute("entity", entity);

    // 2. Lấy danh sách theo filter
    List<Category> list;
    switch(filter) {
        case "active":
            list = dao.findAllActive();    // SQL: WHERE deleted_at IS NULL
            break;
        case "deleted":
            list = dao.findAllDeleted();   // SQL: WHERE deleted_at IS NOT NULL
            break;
        default:
            list = dao.findAll();          // SQL: SELECT * FROM categories
    }
    model.addAttribute("list", list);

    // 3. Thêm thống kê
    Map<Integer, Long> productCounts = new HashMap<>();
    for (Category category : list) {
        Long count = dao.countProductsByCategory(category.getId());
        productCounts.put(category.getId(), count);
    }
    model.addAttribute("productCounts", productCounts);

    // 4. Thống kê tổng quan
    model.addAttribute("totalCategories", dao.countAll());
    model.addAttribute("activeCategories", dao.countActive());
    model.addAttribute("deletedCategories", dao.countDeleted());

    return "admin/category/index";  // Forward to JSP
}
```

**🔍 Luồng Xử Lý:**

1. **Parameter Binding**: Spring tự động bind `filter` parameter
2. **Data Retrieval**: Gọi DAO methods tương ứng với filter
3. **Statistics Calculation**: Tính toán số sản phẩm cho mỗi category
4. **Model Population**: Đưa data vào Model để JSP sử dụng
5. **View Resolution**: Return view name để ViewResolver xử lý

#### 2.3.2 Thêm Category Mới

```java
@RequestMapping(value = "/insert", method = RequestMethod.POST)
public String insert(RedirectAttributes redirectAttributes,
                    @ModelAttribute("entity") Category entity) {
    try {
        // 1. Validation (Spring tự động validate dựa trên annotations)
        // 2. Gọi DAO để lưu vào database
        dao.create(entity);  // INSERT INTO categories (name, created_at, updated_at)

        // 3. Thêm success message
        redirectAttributes.addFlashAttribute("message", "Thêm mới loại sản phẩm thành công!");
        redirectAttributes.addFlashAttribute("messageType", "success");

    } catch (Exception e) {
        // 4. Error handling
        redirectAttributes.addFlashAttribute("error", "Có lỗi xảy ra khi thêm loại sản phẩm!");
        redirectAttributes.addFlashAttribute("messageType", "error");
    }

    // 5. Redirect để tránh duplicate submission
    return "redirect:/admin/category/index";
}
```

**🔍 Luồng Xử Lý:**

1. **Model Binding**: `@ModelAttribute` tự động bind form data vào entity
2. **Validation**: Spring validation dựa trên entity annotations
3. **Database Operation**: DAO.create() thực hiện INSERT
4. **Flash Attributes**: Lưu message để hiển thị sau redirect
5. **PRG Pattern**: Post-Redirect-Get để tránh duplicate submission

#### 2.3.3 Soft Delete Category

```java
@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
public String delete(RedirectAttributes model, @PathVariable("id") Integer id) {
    try {
        // 1. Kiểm tra category có tồn tại không
        Category category = dao.findById(id);
        if (category == null || category.isDeleted()) {
            model.addFlashAttribute("error", "Không tìm thấy loại sản phẩm!");
            return "redirect:/admin/category/index";
        }

        // 2. Kiểm tra có sản phẩm đang sử dụng không
        Long productCount = dao.countProductsByCategory(id);
        if (productCount > 0) {
            model.addFlashAttribute("error",
                "Không thể xóa loại sản phẩm đang có " + productCount + " sản phẩm!");
            return "redirect:/admin/category/index";
        }

        // 3. Thực hiện soft delete
        dao.softDelete(id);  // UPDATE categories SET deleted_at = NOW() WHERE id = ?

        model.addFlashAttribute("message", "Đã chuyển loại sản phẩm vào thùng rác!");
        model.addFlashAttribute("messageType", "success");

    } catch (DataIntegrityViolationException e) {
        // 4. Handle foreign key constraint
        model.addFlashAttribute("error", "Không thể xóa loại sản phẩm đang được sử dụng!");
    } catch (Exception e) {
        model.addFlashAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
    }

    return "redirect:/admin/category/index";
}
```

---

## 3. Luồng Quản Lý Product

### 3.1 Entity Structure - Product.java

```java
@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    String name;                    // Product Name
    Double unitPrice;              // Original Price
    String image;                  // Image Path
    Date productDate;              // Production Date
    Boolean available;             // Available for Sale
    Integer quantity;              // Stock Quantity
    String description;            // Product Description
    Double discount;               // Discount Percentage (0-100)
    Integer viewCount;             // View Counter
    Boolean special;               // Special Product Flag

    // Soft Delete Fields
    Date createdAt;
    Date updatedAt;
    Date deletedAt;

    // Relationships
    @ManyToOne
    @JoinColumn(name="category_id")
    Category category;

    @OneToMany(mappedBy = "product")
    List<OrderDetail> orderDetails;

    // Business Logic Methods
    public Double getFinalPrice() {
        return unitPrice * (1 - discount/100);
    }

    public boolean isOnSale() {
        return discount != null && discount > 0;
    }
}
```

### 3.2 Product Controller - Complex Operations

#### 3.2.1 Thêm Product với Image Upload

```java
@PostMapping("/insert")
public String insert(@ModelAttribute("product") Product product,
                    @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                    RedirectAttributes redirectAttributes) {
    try {
        // 1. Validate business rules
        if (product.getUnitPrice() <= 0) {
            throw new IllegalArgumentException("Giá sản phẩm phải lớn hơn 0");
        }

        if (product.getDiscount() < 0 || product.getDiscount() > 100) {
            throw new IllegalArgumentException("Giảm giá phải từ 0-100%");
        }

        // 2. Handle image upload
        handleImageUpload(product, imageFile);

        // 3. Set default values
        if (product.getProductDate() == null) {
            product.setProductDate(new Date());
        }

        // 4. Save to database
        productDAO.create(product);

        redirectAttributes.addFlashAttribute("message",
            "Thêm sản phẩm '" + product.getName() + "' thành công!");
        return "redirect:/admin/product/index";

    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("error",
            "Có lỗi xảy ra khi thêm sản phẩm: " + e.getMessage());
        return "redirect:/admin/product/insert";
    }
}

private void handleImageUpload(Product product, MultipartFile imageFile) throws IOException {
    if (imageFile != null && !imageFile.isEmpty()) {
        // 1. Validate file type
        String contentType = imageFile.getContentType();
        if (!contentType.startsWith("image/")) {
            throw new IllegalArgumentException("File phải là hình ảnh");
        }

        // 2. Generate unique filename
        String originalFilename = imageFile.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String newFilename = System.currentTimeMillis() + "_" +
                           UUID.randomUUID().toString().substring(0, 8) + extension;

        // 3. Save file to disk
        String uploadPath = servletContext.getRealPath("/static/images/products/");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        File destinationFile = new File(uploadDir, newFilename);
        imageFile.transferTo(destinationFile);

        // 4. Set image path in entity
        product.setImage(newFilename);
    } else {
        // Set default image if no upload
        product.setImage("default-product.jpg");
    }
}
```

**🔍 Luồng Upload Image:**

1. **File Validation**: Kiểm tra file type và size
2. **Unique Naming**: Tạo tên file unique để tránh conflict
3. **Directory Creation**: Tạo thư mục nếu chưa tồn tại
4. **File Transfer**: Lưu file vào disk
5. **Path Storage**: Lưu đường dẫn vào database

#### 3.2.2 Update Product với Image Handling

```java
@PostMapping("/edit/{id}")
public String update(@PathVariable("id") Integer id,
                    @ModelAttribute("product") Product product,
                    @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                    RedirectAttributes redirectAttributes) {
    try {
        // 1. Get existing product from database
        Product existingProduct = productDAO.findById(id);
        if (existingProduct == null || existingProduct.isDeleted()) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy sản phẩm để cập nhật");
            return "redirect:/admin/product/index";
        }

        // 2. Update editable fields only
        updateProductFields(existingProduct, product);

        // 3. Handle image update
        handleImageUpdate(existingProduct, imageFile);

        // 4. Save changes
        productDAO.update(existingProduct);

        redirectAttributes.addFlashAttribute("message",
            "Cập nhật sản phẩm '" + existingProduct.getName() + "' thành công!");
        return "redirect:/admin/product/index";

    } catch (Exception e) {
        redirectAttributes.addFlashAttribute("error",
            "Có lỗi xảy ra khi cập nhật sản phẩm: " + e.getMessage());
        return "redirect:/admin/product/edit/" + id;
    }
}

private void updateProductFields(Product existingProduct, Product newProduct) {
    // Only update editable fields, preserve timestamps and relationships
    existingProduct.setName(newProduct.getName());
    existingProduct.setUnitPrice(newProduct.getUnitPrice());
    existingProduct.setDiscount(newProduct.getDiscount());
    existingProduct.setQuantity(newProduct.getQuantity());
    existingProduct.setDescription(newProduct.getDescription());
    existingProduct.setAvailable(newProduct.getAvailable());
    existingProduct.setSpecial(newProduct.getSpecial());
    existingProduct.setCategory(newProduct.getCategory());
    // createdAt, updatedAt will be handled by @PreUpdate
}
```

---

## 4. Soft Delete System

### 4.1 Soft Delete Pattern Implementation

```java
// Entity Level - Soft Delete Support
public class Category {
    @Column(name = "deleted_at")
    @Temporal(TemporalType.TIMESTAMP)
    Date deletedAt;  // NULL = Active, NOT NULL = Deleted

    public boolean isDeleted() {
        return deletedAt != null;
    }

    public boolean isActive() {
        return deletedAt == null;
    }
}

// DAO Level - Query Methods
public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public List<Category> findAllActive() {
        String jpql = "SELECT c FROM Category c WHERE c.deletedAt IS NULL ORDER BY c.createdAt DESC";
        return entityManager.createQuery(jpql, Category.class).getResultList();
    }

    @Override
    public List<Category> findAllDeleted() {
        String jpql = "SELECT c FROM Category c WHERE c.deletedAt IS NOT NULL ORDER BY c.deletedAt DESC";
        return entityManager.createQuery(jpql, Category.class).getResultList();
    }

    @Override
    public void softDelete(Integer id) {
        String jpql = "UPDATE Category c SET c.deletedAt = :now WHERE c.id = :id";
        entityManager.createQuery(jpql)
                   .setParameter("now", new Date())
                   .setParameter("id", id)
                   .executeUpdate();
    }

    @Override
    public void restore(Integer id) {
        String jpql = "UPDATE Category c SET c.deletedAt = NULL WHERE c.id = :id";
        entityManager.createQuery(jpql)
                   .setParameter("id", id)
                   .executeUpdate();
    }
}
```

### 4.2 Trash Management System

```java
// Controller - Trash Operations
@RequestMapping(value = "/trash", method = RequestMethod.GET)
public String trash(Model model) {
    // 1. Get all deleted items
    List<Category> trashedList = dao.findAllDeleted();
    model.addAttribute("trashedList", trashedList);

    // 2. Calculate expiration info
    Long expiringSoonCount = trashedList.stream()
        .filter(c -> c.getDaysSinceDeleted() > 25)  // Expiring in 5 days
        .count();

    model.addAttribute("expiringSoonCount", expiringSoonCount);
    model.addAttribute("recoverableCount", (long) trashedList.size());

    return "admin/category/trash";
}

// Auto-cleanup expired items (scheduled job)
@Scheduled(cron = "0 0 2 * * ?")  // Run daily at 2 AM
public void autoCleanupExpiredItems() {
    List<Category> expiredCategories = dao.findExpiredCategories();
    for (Category category : expiredCategories) {
        if (category.getDaysSinceDeleted() > 30) {
            dao.permanentDelete(category.getId());
        }
    }
}
```

---

## 5. Data Flow & Processing

### 5.1 Request-Response Cycle

```
┌─────────────────┐
│   User Action   │ (Click "Add Category")
└─────────┬───────┘
          │
          ▼
┌─────────────────┐
│   HTTP Request  │ POST /admin/category/insert
└─────────┬───────┘
          │
          ▼
┌─────────────────┐
│ Spring MVC      │ DispatcherServlet
│ DispatcherServlet│ → HandlerMapping
└─────────┬───────┘ → HandlerAdapter
          │
          ▼
┌─────────────────┐
│   Controller    │ CategoryMangerController.insert()
│   Method        │ - Validate input
└─────────┬───────┘ - Call DAO
          │
          ▼
┌─────────────────┐
│   DAO Layer     │ CategoryDAOImpl.create()
│                 │ - Build JPQL query
└─────────┬───────┘ - Execute query
          │
          ▼
┌─────────────────┐
│   Database      │ INSERT INTO categories
│   Operation     │ (name, created_at, updated_at)
└─────────┬───────┘ VALUES (?, ?, ?)
          │
          ▼
┌─────────────────┐
│   Response      │ Redirect to /admin/category/index
│   Generation    │ with flash message
└─────────────────┘
```

### 5.2 Error Handling Flow

```java
// Controller Level Error Handling
try {
    dao.create(entity);
    redirectAttributes.addFlashAttribute("message", "Success!");
} catch (DataIntegrityViolationException e) {
    // Handle database constraint violations
    redirectAttributes.addFlashAttribute("error", "Duplicate entry!");
} catch (ValidationException e) {
    // Handle validation errors
    redirectAttributes.addFlashAttribute("error", "Invalid data!");
} catch (Exception e) {
    // Handle unexpected errors
    logger.error("Unexpected error: ", e);
    redirectAttributes.addFlashAttribute("error", "System error occurred!");
}

// Global Exception Handler
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(DataIntegrityViolationException.class)
    public String handleDataIntegrityViolation(DataIntegrityViolationException e,
                                              RedirectAttributes redirectAttributes) {
        redirectAttributes.addFlashAttribute("error", "Data integrity violation!");
        return "redirect:/admin/error";
    }
}
```

---

## 6. Performance Optimization

### 6.1 Database Query Optimization

```java
// Efficient Pagination
@Override
public List<Product> findActiveProducts(int page, int size) {
    String jpql = "SELECT p FROM Product p WHERE p.deletedAt IS NULL " +
                  "ORDER BY p.createdAt DESC";
    return entityManager.createQuery(jpql, Product.class)
                       .setFirstResult(page * size)
                       .setMaxResults(size)
                       .getResultList();
}

// Batch Operations
@Override
public void softDeleteMultiple(List<Integer> ids) {
    String jpql = "UPDATE Product p SET p.deletedAt = :now WHERE p.id IN :ids";
    entityManager.createQuery(jpql)
                 .setParameter("now", new Date())
                 .setParameter("ids", ids)
                 .executeUpdate();
}

// Lazy Loading with JOIN FETCH
@Override
public List<Product> findWithCategories() {
    String jpql = "SELECT p FROM Product p JOIN FETCH p.category " +
                  "WHERE p.deletedAt IS NULL";
    return entityManager.createQuery(jpql, Product.class).getResultList();
}
```

### 6.2 Caching Strategy

```java
// Service Layer Caching
@Service
public class CategoryService {

    @Cacheable(value = "categories", key = "'active'")
    public List<Category> getActiveCategories() {
        return categoryDAO.findAllActive();
    }

    @CacheEvict(value = "categories", allEntries = true)
    public void createCategory(Category category) {
        categoryDAO.create(category);
    }
}
```

---

_Tài liệu kỹ thuật này cung cấp cái nhìn sâu sắc về implementation details và best practices được sử dụng trong hệ thống._
