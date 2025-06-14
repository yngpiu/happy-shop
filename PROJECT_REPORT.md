# 📱 BÁO CÁO DỰ ÁN HỆ THỐNG BÁN ĐIỆN THOẠI HAPPYSHOP

## 1. PHÂN TÍCH VÀ THIẾT KẾ HỆ THỐNG

### 1.1 Giới thiệu chung

HappyShop là hệ thống thương mại điện tử chuyên bán điện thoại và phụ kiện di động, được phát triển dựa trên nền tảng Java Spring Boot với kiến trúc MVC. Hệ thống cung cấp giải pháp toàn diện cho việc quản lý cửa hàng điện thoại trực tuyến, từ quản lý sản phẩm, đơn hàng đến báo cáo doanh thu.

**Mục tiêu chính của hệ thống:**

- Cung cấp nền tảng bán hàng trực tuyến chuyên nghiệp cho ngành điện thoại di động
- Quản lý hiệu quả kho hàng và tồn kho các sản phẩm điện thoại
- Hỗ trợ khách hàng trong việc tìm kiếm, so sánh và mua sắm điện thoại
- Cung cấp công cụ quản trị mạnh mẽ cho admin quản lý toàn bộ hệ thống
- Đảm bảo trải nghiệm người dùng mượt mà trên mọi thiết bị

**Đối tượng sử dụng:**

- **Khách hàng**: Người dùng cuối muốn mua điện thoại và phụ kiện
- **Admin**: Quản trị viên hệ thống quản lý sản phẩm, đơn hàng, khách hàng
- **Nhân viên**: Xử lý đơn hàng, hỗ trợ khách hàng

**Phạm vi ứng dụng:**

- Cửa hàng điện thoại trực tuyến
- Hệ thống quản lý kho hàng điện thoại
- Nền tảng thương mại điện tử B2C trong lĩnh vực công nghệ

### 1.2 Kiến trúc phát triển

Hệ thống HappyShop được thiết kế theo mô hình kiến trúc 3 tầng (3-tier architecture) kết hợp với pattern MVC, đảm bảo tính module hóa, dễ bảo trì và khả năng mở rộng cao.

```
┌─────────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                           │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │   Customer UI   │  │    Admin UI     │  │   Mobile UI     │ │
│  │   (JSP/HTML)    │  │   (JSP/HTML)    │  │  (Responsive)   │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                    APPLICATION LAYER                            │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │   Controllers   │  │    Services     │  │   Interceptors  │ │
│  │  (Web Layer)    │  │ (Business Logic)│  │   (Security)    │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                     DATA ACCESS LAYER                           │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │      DAO        │  │    Entities     │  │   Repositories  │ │
│  │ (Data Access)   │  │  (Data Model)   │  │   (JPA/ORM)     │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                                │
                                ▼
┌─────────────────────────────────────────────────────────────────┐
│                      DATABASE LAYER                             │
│                    ┌─────────────────┐                         │
│                    │   MySQL Server  │                         │
│                    │   (Data Store)  │                         │
│                    └─────────────────┘                         │
└─────────────────────────────────────────────────────────────────┘
```

#### 1.2.1 Các thành phần

**A. Presentation Layer (Tầng Giao Diện)**

Tầng giao diện của HappyShop được thiết kế với trọng tâm là trải nghiệm người dùng tối ưu cho việc mua sắm điện thoại trực tuyến:

- **Customer Frontend**: Giao diện khách hàng chuyên biệt cho ngành điện thoại

  - Trang chủ với slideshow các mẫu điện thoại hot nhất, deal khuyến mãi
  - Catalog sản phẩm với filter theo thương hiệu (iPhone, Samsung, Xiaomi, Oppo, Vivo)
  - Filter theo mức giá (dưới 5 triệu, 5-10 triệu, 10-20 triệu, trên 20 triệu)
  - Filter theo tính năng (camera, RAM, bộ nhớ, pin)
  - Chi tiết sản phẩm với gallery hình ảnh, thông số kỹ thuật chi tiết
  - So sánh sản phẩm giữa các mẫu điện thoại
  - Giỏ hàng với tính năng lưu để mua sau
  - Quy trình thanh toán đơn giản với nhiều phương thức

- **Admin Dashboard**: Hệ thống quản trị chuyên nghiệp

  - Dashboard tổng quan với KPI: doanh thu, số đơn hàng, sản phẩm bán chạy
  - Quản lý sản phẩm điện thoại với upload multiple images
  - Quản lý thông số kỹ thuật (màn hình, chip, camera, pin, hệ điều hành)
  - Quản lý danh mục theo thương hiệu và phân khúc giá
  - Quản lý kho hàng với cảnh báo hết hàng
  - Quản lý đơn hàng với workflow xử lý (chờ xác nhận, đang giao, hoàn thành)
  - Báo cáo doanh thu theo sản phẩm, thương hiệu, thời gian

- **Responsive Design**: Tối ưu cho thiết bị di động
  - Mobile-first cho việc duyệt và mua điện thoại trên smartphone
  - Touch-friendly interface với swipe gestures
  - Optimized product images cho mobile viewing
  - Quick view và quick add to cart

**B. Application Layer (Tầng Ứng Dụng)**

Tầng ứng dụng chứa toàn bộ business logic của hệ thống bán điện thoại:

- **Controllers**: Xử lý các yêu cầu HTTP

  - `HomeController`: Trang chủ với featured phones, deals
  - `ProductController`: Catalog, search, filter, product details
  - `CategoryController`: Quản lý danh mục thương hiệu
  - `CartController`: Shopping cart với session management
  - `OrderController`: Checkout process, order management
  - `AccountController`: User registration, login, profile
  - `AdminProductController`: Admin product management
  - `AdminOrderController`: Order processing workflow
  - `ReportController`: Sales reports và analytics

- **Services**: Business Logic Layer

  - `ProductService`: Logic nghiệp vụ sản phẩm điện thoại
    - Tính giá sau khuyến mãi
    - Kiểm tra tồn kho
    - Recommend sản phẩm tương tự
  - `CartService`: Xử lý giỏ hàng
    - Session-based cart management
    - Price calculation với tax và shipping
    - Inventory validation
  - `OrderService`: Xử lý đơn hàng
    - Order workflow management
    - Inventory deduction
    - Email notifications
  - `InventoryService`: Quản lý kho hàng
    - Stock level monitoring
    - Low stock alerts
    - Automatic reorder points

- **Security & Interceptors**:
  - Admin authentication interceptor
  - Session timeout management
  - CSRF protection cho sensitive operations
  - Input validation cho product data

**C. Data Access Layer (Tầng Truy Cập Dữ Liệu)**

Tầng này quản lý tất cả các thao tác với cơ sở dữ liệu:

- **Entities**: Mô hình dữ liệu cho hệ thống bán điện thoại

  - `Product`: Thông tin điện thoại (tên, giá, specs, images)
  - `Category`: Danh mục (iPhone, Android, Accessories)
  - `ProductSpecification`: Thông số kỹ thuật chi tiết
  - `User`: Thông tin khách hàng và admin
  - `Order`: Đơn hàng với trạng thái
  - `OrderDetail`: Chi tiết sản phẩm trong đơn hàng
  - `Inventory`: Quản lý tồn kho

- **DAO Pattern**: Data Access Objects
  - Interface-based design cho flexibility
  - JPA/Hibernate implementation
  - Soft delete support
  - Optimized queries cho performance
  - Transaction management

**D. Database Layer (Tầng Cơ Sở Dữ Liệu)**

- **MySQL Database**: Thiết kế schema tối ưu cho e-commerce
  - Normalized design giảm redundancy
  - Indexes cho search performance
  - Foreign key constraints đảm bảo data integrity
  - Backup strategy với point-in-time recovery

#### 1.2.2 Các cấu hình và phát triển hệ thống

**A. Spring Boot Configuration**

Hệ thống sử dụng Spring Boot với các cấu hình tối ưu cho ứng dụng thương mại điện tử:

```
├── Application Properties
│   ├── Database Configuration
│   │   ├── MySQL connection settings
│   │   ├── Connection pool configuration (HikariCP)
│   │   └── JPA/Hibernate properties
│   ├── Server Configuration
│   │   ├── Port và context path
│   │   ├── Session timeout settings
│   │   └── File upload limits
│   └── Logging Configuration
│       ├── Log levels cho different packages
│       └── File appenders cho audit logs
│
├── Bean Configuration
│   ├── Data Source với connection pooling
│   ├── Transaction Manager cho data consistency
│   ├── View Resolver cho JSP rendering
│   ├── Multipart Resolver cho image uploads
│   └── Message Source cho internationalization
│
└── Security Configuration
    ├── Session management settings
    ├── CSRF protection configuration
    ├── Admin area security rules
    └── Password encoding configuration
```

**B. Development Environment**

- **IDE Setup**: IntelliJ IDEA/Eclipse với Spring Tools Suite
- **Build Tool**: Maven với dependency management
  - Spring Boot starters
  - Database drivers
  - Testing frameworks
  - Frontend libraries
- **Database**: MySQL 8.0 với MySQL Workbench
- **Version Control**: Git với feature branch workflow
- **Testing Tools**: JUnit, Mockito, Postman

**C. Technology Stack Chi Tiết**

```
Backend Framework:
├── Spring Boot 2.7.x
│   ├── Spring MVC (Web layer)
│   ├── Spring Data JPA (Data access)
│   ├── Spring Security (Authentication)
│   └── Spring Boot Actuator (Monitoring)
│
├── Database & ORM:
│   ├── MySQL 8.0 (Primary database)
│   ├── Hibernate 5.x (ORM framework)
│   └── HikariCP (Connection pooling)
│
└── Build & Deployment:
    ├── Maven 3.x (Build automation)
    ├── Embedded Tomcat (Development server)
    └── External Tomcat (Production deployment)

Frontend Technologies:
├── JSP với JSTL (Server-side rendering)
├── Bootstrap 5 (Responsive UI framework)
├── jQuery 3.x (JavaScript library)
├── Font Awesome (Icon library)
└── Custom CSS (Brand styling)

Development Tools:
├── Git (Version control)
├── MySQL Workbench (Database design)
├── Postman (API testing)
└── Browser DevTools (Frontend debugging)
```

#### 1.2.3 Khả năng mở rộng

**A. Horizontal Scaling (Mở rộng theo chiều ngang)**

- **Load Balancing**: Triển khai multiple application instances
  - Nginx/Apache load balancer
  - Session clustering với Redis
  - Database read replicas
- **Microservices Migration Path**:

  - Product Service (catalog management)
  - Order Service (order processing)
  - User Service (authentication)
  - Inventory Service (stock management)
  - Notification Service (emails, SMS)

- **CDN Integration**:
  - Static content delivery
  - Image optimization và caching
  - Global content distribution

**B. Vertical Scaling (Mở rộng theo chiều dọc)**

- **Database Optimization**:

  - Query optimization với proper indexing
  - Database partitioning cho large datasets
  - Connection pooling tuning
  - Query caching strategies

- **Application Performance**:
  - JVM tuning cho memory management
  - Garbage collection optimization
  - Thread pool configuration
  - Caching layers (Redis, Ehcache)

**C. Feature Extensibility**

- **API Development**: RESTful APIs cho mobile apps
- **Third-party Integrations**:

  - Payment gateways (VNPay, MoMo, ZaloPay)
  - Shipping providers (Giao Hàng Nhanh, Viettel Post)
  - SMS services cho OTP verification
  - Social login (Facebook, Google)

- **Advanced Features**:
  - Real-time notifications
  - Live chat support
  - Product recommendation engine
  - Advanced analytics và reporting

### 1.3 Các cơ chế bảo mật của Spring Boot

Hệ thống HappyShop triển khai comprehensive security measures để bảo vệ dữ liệu khách hàng và đảm bảo an toàn giao dịch:

**A. Authentication & Authorization**

- **Multi-level Authentication**:

  - Customer authentication với email/password
  - Admin authentication với enhanced security
  - Session-based authentication với secure cookies
  - Remember me functionality với encrypted tokens

- **Role-based Access Control (RBAC)**:

  ```java
  // Admin area protection
  @Component
  public class AdminInterceptor implements HandlerInterceptor {
      @Override
      public boolean preHandle(HttpServletRequest request,
                              HttpServletResponse response,
                              Object handler) {
          User user = (User) request.getSession().getAttribute("user");
          if (user == null || !user.getAdmin()) {
              response.sendRedirect("/account/login?admin=true");
              return false;
          }
          return true;
      }
  }
  ```

- **Session Management**:
  - Secure session configuration
  - Session timeout cho security
  - Session fixation protection
  - Concurrent session control

**B. Input Validation & Data Protection**

- **Comprehensive Input Validation**:

  ```java
  @Entity
  public class Product {
      @NotEmpty(message = "Tên sản phẩm không được để trống")
      @Size(min = 2, max = 255, message = "Tên sản phẩm từ 2-255 ký tự")
      private String name;

      @DecimalMin(value = "0.0", message = "Giá phải lớn hơn 0")
      @DecimalMax(value = "999999999.99", message = "Giá không hợp lệ")
      private Double unitPrice;

      @Min(value = 0, message = "Số lượng không được âm")
      private Integer quantity;
  }
  ```

- **XSS Prevention**:

  - Output encoding trong JSP
  - Input sanitization
  - Content Security Policy headers

- **SQL Injection Protection**:
  - Parameterized queries với JPA
  - Input validation
  - Stored procedures cho sensitive operations

**C. CSRF Protection**

- **Token-based CSRF Protection**:

  ```jsp
  <form method="post" action="/admin/product/insert">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <!-- form fields -->
  </form>
  ```

- **Same-Origin Policy enforcement**
- **Secure headers configuration**

**D. File Upload Security**

- **Secure File Upload cho product images**:

  ```java
  public class FileUploadService {
      private static final List<String> ALLOWED_TYPES =
          Arrays.asList("image/jpeg", "image/png", "image/gif");

      public String uploadProductImage(MultipartFile file) {
          // Validate file type
          if (!ALLOWED_TYPES.contains(file.getContentType())) {
              throw new IllegalArgumentException("Invalid file type");
          }

          // Validate file size (max 5MB)
          if (file.getSize() > 5 * 1024 * 1024) {
              throw new IllegalArgumentException("File too large");
          }

          // Generate secure filename
          String filename = UUID.randomUUID().toString() +
                           getFileExtension(file.getOriginalFilename());

          // Save to secure directory
          Path uploadPath = Paths.get(UPLOAD_DIR, filename);
          Files.copy(file.getInputStream(), uploadPath);

          return filename;
      }
  }
  ```

**E. Error Handling & Logging**

- **Secure Error Handling**:

  - Custom error pages không expose system info
  - Proper exception handling
  - Security event logging

- **Audit Logging**:
  - Login/logout events
  - Admin actions
  - Order transactions
  - Data modifications

### 1.4 Mô hình phát triển được áp dụng

**A. Agile Development với Scrum Framework**

Dự án HappyShop áp dụng Agile methodology với Scrum framework:

- **Sprint Structure**:

  - Sprint 1: User Management & Authentication
  - Sprint 2: Product Catalog & Categories
  - Sprint 3: Shopping Cart & Checkout
  - Sprint 4: Admin Dashboard & Product Management
  - Sprint 5: Order Management & Reporting
  - Sprint 6: UI/UX Enhancement & Testing

- **Scrum Events**:
  - Sprint Planning: Định nghĩa sprint goals và tasks
  - Daily Standups: Sync tiến độ và blockers
  - Sprint Reviews: Demo features cho stakeholders
  - Sprint Retrospectives: Process improvement

**B. Feature-Driven Development (FDD)**

- **Feature Breakdown**:

  ```
  1. User Management Feature
     ├── User Registration
     ├── User Authentication
     ├── Profile Management
     └── Password Reset

  2. Product Catalog Feature
     ├── Product Listing
     ├── Product Search & Filter
     ├── Product Details
     └── Product Comparison

  3. Shopping Cart Feature
     ├── Add to Cart
     ├── Cart Management
     ├── Price Calculation
     └── Cart Persistence

  4. Order Management Feature
     ├── Checkout Process
     ├── Order Placement
     ├── Order Tracking
     └── Order History

  5. Admin Management Feature
     ├── Product CRUD
     ├── Category Management
     ├── Order Processing
     └── User Management
  ```

**C. Test-Driven Development (TDD)**

- **Testing Strategy**:

  - Unit Tests cho business logic
  - Integration Tests cho database operations
  - Controller Tests cho web layer
  - End-to-end Tests cho user workflows

- **Test Coverage**:

  ```java
  @Test
  public void testAddToCart() {
      // Given
      Product product = new Product("iPhone 14", 25000000.0);
      CartService cartService = new CartService();

      // When
      cartService.add(product, 1);

      // Then
      assertEquals(1, cartService.getCount());
      assertEquals(25000000.0, cartService.getAmount(), 0.01);
  }
  ```

**D. Version Control Strategy**

- **Git Workflow**:

  ```
  main branch (production-ready)
  ├── develop branch (integration)
  ├── feature/user-management
  ├── feature/product-catalog
  ├── feature/shopping-cart
  └── hotfix/security-patch
  ```

- **Code Review Process**:
  - Pull request reviews
  - Code quality checks
  - Security review cho sensitive changes

### 1.5 Đánh giá và áp dụng

**A. Ưu điểm của hệ thống**

1. **Kiến trúc Robust và Scalable**:

   - Layered architecture với clear separation of concerns
   - MVC pattern đảm bảo maintainability
   - Spring Boot framework cung cấp production-ready features
   - Database design tối ưu cho e-commerce workflows

2. **Tính năng Comprehensive**:

   - Complete e-commerce functionality từ catalog đến checkout
   - Advanced admin dashboard với comprehensive management tools
   - Responsive design tối ưu cho mobile commerce
   - Soft delete system bảo vệ data integrity
   - Inventory management với real-time stock tracking

3. **Security Implementation**:

   - Multi-layer security với authentication và authorization
   - Input validation và output encoding chống XSS
   - CSRF protection cho forms
   - Secure file upload cho product images
   - Audit logging cho compliance

4. **Performance Optimization**:
   - Database indexing strategy cho fast queries
   - Connection pooling cho database efficiency
   - Image optimization cho fast loading
   - Session management cho user experience

**B. Hạn chế và Areas for Improvement**

1. **Architecture Limitations**:

   - Monolithic architecture có thể gặp scaling bottlenecks
   - Single database instance tạo single point of failure
   - Session-based authentication không ideal cho distributed systems

2. **Technology Stack Considerations**:

   - JSP technology hơi outdated so với modern frontend frameworks
   - Lack of real-time features (live chat, notifications)
   - Limited API support cho mobile app integration
   - No caching layer cho improved performance

3. **Improvement Recommendations**:
   - Migration sang microservices architecture
   - Implementation của RESTful APIs
   - Integration với modern frontend frameworks (React/Vue.js)
   - Addition của caching layer (Redis)
   - Implementation của message queues cho async processing

**C. Real-world Application Assessment**

1. **Ideal Use Cases**:

   - Small to medium-sized phone retail businesses
   - Startups trong e-commerce space
   - Educational projects và prototyping
   - Businesses cần rapid time-to-market
   - Companies với limited technical resources

2. **Not Suitable For**:

   - Large-scale enterprise applications (>100k users)
   - High-traffic websites với complex requirements
   - Real-time applications requiring instant updates
   - Multi-tenant SaaS platforms
   - Applications requiring advanced AI/ML features

3. **Market Positioning**:
   - Competitive với các platform như Shopify cho small businesses
   - Cost-effective alternative cho custom e-commerce solutions
   - Good foundation cho businesses muốn scale up gradually

**D. Technical Debt và Future Roadmap**

1. **Current Technical Debt**:

   - Legacy JSP templates cần modernization
   - Lack of comprehensive test coverage
   - Manual deployment process
   - Limited monitoring và observability

2. **Future Enhancement Roadmap**:
   - **Phase 1**: API development cho mobile apps
   - **Phase 2**: Frontend modernization với React/Vue.js
   - **Phase 3**: Microservices migration
   - **Phase 4**: Cloud deployment với containerization
   - **Phase 5**: AI/ML integration cho recommendations

**E. Conclusion và Recommendations**

Hệ thống HappyShop đại diện cho một implementation thành công của Spring Boot trong việc xây dựng e-commerce platform. Với architecture vững chắc, security tốt, và feature set comprehensive, hệ thống đáp ứng được requirements của một cửa hàng điện thoại trực tuyến quy mô vừa và nhỏ.

**Key Strengths**:

- Solid technical foundation với proven technologies
- Comprehensive business logic implementation
- Good security practices
- User-friendly interface design
- Maintainable codebase với clear structure

**Strategic Recommendations**:

1. **Short-term**: Focus on performance optimization và bug fixes
2. **Medium-term**: API development và mobile app support
3. **Long-term**: Architecture modernization và cloud migration

**Business Impact**:

- Enables digital transformation cho traditional phone retailers
- Provides competitive advantage trong online marketplace
- Scalable foundation cho business growth
- Cost-effective solution với good ROI potential

Nhìn chung, HappyShop là một excellent case study cho việc áp dụng Spring Boot trong real-world e-commerce development, demonstrating best practices trong software architecture, security implementation, và user experience design. Hệ thống cung cấp solid foundation cho future enhancements và business expansion.

## 2. THIẾT KẾ VÀ XÂY DỰNG HỆ THỐNG QUẢN LÝ BÁN HÀNG TRỰC TUYẾN

### 2.1 Thiết kế hệ thống quản lý xóa loại sản phẩm và thùng rác

#### 2.1.1 Biểu đồ ca sử dụng mức hệ thống

Hệ thống quản lý xóa loại sản phẩm và thùng rác bao gồm các tác nhân chính và các ca sử dụng cốt lõi như sau:

**Các Actor (Tác nhân):**

- **Admin**: Quản trị viên hệ thống có quyền quản lý toàn bộ loại sản phẩm
- **Manager**: Người quản lý có quyền xóa và khôi phục loại sản phẩm
- **System**: Hệ thống tự động thực hiện các tác vụ định kỳ

**Các Use Case chính:**

- **UC01: Xóa loại sản phẩm**: Thực hiện xóa mềm loại sản phẩm vào thùng rác
- **UC02: Quản lý thùng rác**: Xem danh sách các loại sản phẩm đã xóa
- **UC03: Khôi phục loại sản phẩm**: Khôi phục loại sản phẩm từ thùng rác
- **UC04: Xóa vĩnh viễn**: Xóa hoàn toàn loại sản phẩm khỏi hệ thống
- **UC05: Tự động dọn dẹp**: Tự động xóa vĩnh viễn các mục cũ trong thùng rác

#### 2.1.2 Các mô đun nghiệp vụ trong hệ thống

##### 2.1.2.1 Biểu đồ ca sử dụng mức 2, 3, 4

**Mức 2 - Chi tiết ca sử dụng chính:**

**UC01: Xóa loại sản phẩm**

- UC01.1: Kiểm tra ràng buộc dữ liệu
- UC01.2: Thực hiện xóa mềm
- UC01.3: Ghi log hoạt động
- UC01.4: Thông báo kết quả

**UC02: Quản lý thùng rác**

- UC02.1: Hiển thị danh sách đã xóa
- UC02.2: Tìm kiếm trong thùng rác
- UC02.3: Sắp xếp theo tiêu chí
- UC02.4: Phân trang dữ liệu

**UC03: Khôi phục loại sản phẩm**

- UC03.1: Chọn mục cần khôi phục
- UC03.2: Kiểm tra tính hợp lệ
- UC03.3: Thực hiện khôi phục
- UC03.4: Cập nhật trạng thái

**UC04: Xóa vĩnh viễn**

- UC04.1: Xác nhận xóa vĩnh viễn
- UC04.2: Kiểm tra quyền hạn
- UC04.3: Thực hiện xóa khỏi database
- UC04.4: Xóa file liên quan

##### 2.1.2.2 Đặc tả ca sử dụng

**UC01: Xóa loại sản phẩm**

| Thuộc tính           | Mô tả                                                                                 |
| -------------------- | ------------------------------------------------------------------------------------- |
| Tên ca sử dụng       | Xóa loại sản phẩm                                                                     |
| Mã ca sử dụng        | UC01                                                                                  |
| Tác nhân chính       | Admin, Manager                                                                        |
| Mô tả                | Thực hiện xóa mềm loại sản phẩm, chuyển vào thùng rác thay vì xóa vĩnh viễn           |
| Điều kiện tiên quyết | - Người dùng đã đăng nhập với quyền quản lý<br>- Loại sản phẩm tồn tại và chưa bị xóa |
| Điều kiện kết thúc   | Loại sản phẩm được chuyển vào thùng rác với trạng thái "deleted"                      |

**Luồng sự kiện chính:**

1. Admin/Manager chọn loại sản phẩm cần xóa
2. Hệ thống hiển thị xác nhận xóa
3. Người dùng xác nhận thực hiện xóa
4. Hệ thống kiểm tra ràng buộc dữ liệu (sản phẩm con, đơn hàng liên quan)
5. Hệ thống cập nhật trạng thái deleted = true, deleted_date = hiện tại
6. Hệ thống ghi log hoạt động
7. Hiển thị thông báo xóa thành công

**Luồng sự kiện thay thế:**

- 4a. Có ràng buộc dữ liệu: Hiển thị cảnh báo và yêu cầu xử lý trước
- 6a. Lỗi hệ thống: Rollback và hiển thị thông báo lỗi

**UC03: Khôi phục loại sản phẩm**

| Thuộc tính           | Mô tả                                                                   |
| -------------------- | ----------------------------------------------------------------------- |
| Tên ca sử dụng       | Khôi phục loại sản phẩm                                                 |
| Mã ca sử dụng        | UC03                                                                    |
| Tác nhân chính       | Admin, Manager                                                          |
| Mô tả                | Khôi phục loại sản phẩm từ thùng rác về trạng thái hoạt động            |
| Điều kiện tiên quyết | - Người dùng có quyền quản lý<br>- Loại sản phẩm đang ở trong thùng rác |
| Điều kiện kết thúc   | Loại sản phẩm được khôi phục về trạng thái hoạt động                    |

**Luồng sự kiện chính:**

1. Người dùng truy cập thùng rác
2. Chọn loại sản phẩm cần khôi phục
3. Hệ thống hiển thị thông tin chi tiết
4. Người dùng xác nhận khôi phục
5. Hệ thống kiểm tra tính hợp lệ (tên không trùng với mục đang hoạt động)
6. Cập nhật deleted = false, deleted_date = null, restored_date = hiện tại
7. Ghi log hoạt động khôi phục
8. Hiển thị thông báo thành công

##### 2.1.2.3 Biểu đồ trình tự

**Trình tự xóa loại sản phẩm:**

```
Admin -> CategoryController: deleteCategory(id)
CategoryController -> CategoryService: softDelete(id)
CategoryService -> CategoryRepository: findById(id)
CategoryRepository -> CategoryService: category
CategoryService -> CategoryService: checkConstraints(category)
CategoryService -> CategoryRepository: updateDeletedStatus(id, true)
CategoryRepository -> Database: UPDATE categories SET deleted=true, deleted_date=NOW()
Database -> CategoryRepository: success
CategoryRepository -> CategoryService: updated
CategoryService -> LogService: logActivity("DELETE", category)
LogService -> CategoryService: logged
CategoryService -> CategoryController: result
CategoryController -> Admin: success message
```

**Trình tự khôi phục loại sản phẩm:**

```
Admin -> TrashController: restoreCategory(id)
TrashController -> CategoryService: restore(id)
CategoryService -> CategoryRepository: findDeletedById(id)
CategoryRepository -> CategoryService: deletedCategory
CategoryService -> CategoryService: validateRestore(category)
CategoryService -> CategoryRepository: updateDeletedStatus(id, false)
CategoryRepository -> Database: UPDATE categories SET deleted=false, deleted_date=NULL
Database -> CategoryRepository: success
CategoryRepository -> CategoryService: restored
CategoryService -> LogService: logActivity("RESTORE", category)
LogService -> CategoryService: logged
CategoryService -> TrashController: result
TrashController -> Admin: success message
```

##### 2.1.2.4 Biểu đồ hoạt động / quy trình nghiệp vụ

**Quy trình xóa loại sản phẩm:**

```
[Bắt đầu] -> [Chọn loại sản phẩm] -> [Nhấn nút xóa]
-> [Hiển thị xác nhận] -> {Người dùng xác nhận?}
   |-- Không -> [Hủy bỏ] -> [Kết thúc]
   |-- Có -> [Kiểm tra ràng buộc] -> {Có ràng buộc?}
        |-- Có -> [Hiển thị cảnh báo] -> [Kết thúc]
        |-- Không -> [Cập nhật trạng thái deleted] -> [Ghi log]
                   -> [Hiển thị thông báo thành công] -> [Kết thúc]
```

**Quy trình tự động dọn dẹp thùng rác:**

```
[Bắt đầu định kỳ] -> [Tìm mục đã xóa > 30 ngày]
-> {Có mục cần xóa?}
   |-- Không -> [Ghi log "Không có mục cần dọn"] -> [Kết thúc]
   |-- Có -> [Duyệt từng mục] -> [Kiểm tra thời gian]
          -> [Xóa vĩnh viễn khỏi DB] -> [Xóa file liên quan]
          -> [Ghi log xóa vĩnh viễn] -> [Tiếp tục mục tiếp theo]
          -> [Hoàn thành] -> [Gửi báo cáo] -> [Kết thúc]
```

##### 2.1.2.5 Biểu đồ trạng thái

**Trạng thái của Loại sản phẩm:**

```
[Tạo mới] -> [Active] -> [Chỉnh sửa] -> [Active]
[Active] -> [Xóa mềm] -> [In Trash]
[In Trash] -> [Khôi phục] -> [Active]
[In Trash] -> [Xóa vĩnh viễn] -> [Permanently Deleted]
[In Trash] -> [Tự động xóa sau 30 ngày] -> [Permanently Deleted]
```

**Mô tả các trạng thái:**

- **Active**: Loại sản phẩm đang hoạt động, có thể sử dụng bình thường
- **In Trash**: Đã bị xóa mềm, nằm trong thùng rác
- **Permanently Deleted**: Đã bị xóa vĩnh viễn khỏi hệ thống

##### 2.1.2.6 Biểu đồ lớp / lớp chi tiết

**Các lớp chính trong hệ thống:**

```java
// Entity Class
public class Category {
    private Long id;
    private String name;
    private String description;
    private Boolean deleted;
    private LocalDateTime deletedDate;
    private LocalDateTime restoredDate;
    private String deletedBy;
    private String restoredBy;
}

// Repository Interface
public interface CategoryRepository extends JpaRepository<Category, Long> {
    List<Category> findByDeletedFalse();
    List<Category> findByDeletedTrue();
    List<Category> findByDeletedTrueAndDeletedDateBefore(LocalDateTime date);
}

// Service Class
public class CategoryService {
    public void softDelete(Long id);
    public void restore(Long id);
    public void permanentDelete(Long id);
    public List<Category> getTrashCategories();
    public void autoCleanup();
}

// Controller Class
public class CategoryController {
    @PostMapping("/delete/{id}")
    public ResponseEntity<?> deleteCategory(@PathVariable Long id);
}

public class TrashController {
    @PostMapping("/restore/{id}")
    public ResponseEntity<?> restoreCategory(@PathVariable Long id);

    @DeleteMapping("/permanent/{id}")
    public ResponseEntity<?> permanentDelete(@PathVariable Long id);
}
```

### Các Use Case chính trong hệ thống quản lý xóa loại sản phẩm:

1. **Xóa mềm loại sản phẩm**: Chuyển loại sản phẩm vào thùng rác thay vì xóa hoàn toàn
2. **Quản lý thùng rác**: Hiển thị và quản lý các loại sản phẩm đã bị xóa
3. **Khôi phục loại sản phẩm**: Khôi phục loại sản phẩm từ thùng rác về trạng thái hoạt động
4. **Xóa vĩnh viễn**: Xóa hoàn toàn loại sản phẩm khỏi hệ thống
5. **Tự động dọn dẹp**: Tự động xóa vĩnh viễn các mục đã ở trong thùng rác quá lâu
