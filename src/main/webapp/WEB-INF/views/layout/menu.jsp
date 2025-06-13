<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!-- Modern Navigation Menu -->
<nav class="main-navigation bg-primary">
  <div class="container">
    <div class="row align-items-center">
      <!-- Categories Dropdown -->
      <div class="col-lg-3">
        <div class="dropdown categories-dropdown">
          <button class="btn btn-dark w-100 text-start d-flex align-items-center justify-content-between" 
                  type="button" data-bs-toggle="dropdown">
            <span>
              <i class="bi bi-grid-3x3-gap me-2"></i>
              DANH MỤC SẢN PHẨM
            </span>
            <i class="bi bi-chevron-down"></i>
          </button>
          <ul class="dropdown-menu categories-menu w-100 shadow-lg">
            <c:forEach var="category" items="${cates}">
              <li>
                <a class="dropdown-item d-flex align-items-center" 
                   href="/product/list-by-categorys/${category.id}">
                  <i class="bi bi-tag me-3 text-primary"></i>
                  ${category.name}
                  <i class="bi bi-chevron-right ms-auto"></i>
                </a>
              </li>
            </c:forEach>
          </ul>
        </div>
      </div>

      <!-- Main Menu -->
      <div class="col-lg-9">
        <ul class="navbar-nav d-flex flex-row justify-content-center justify-content-lg-start">
          <li class="nav-item me-4">
            <a class="nav-link text-white fw-bold" href="/">
              <i class="bi bi-house me-1"></i>
              TRANG CHỦ
            </a>
          </li>
          <li class="nav-item me-4">
            <a class="nav-link text-white fw-bold" href="/about">
              <i class="bi bi-info-circle me-1"></i>
              GIỚI THIỆU
            </a>
          </li>
          <li class="nav-item me-4">
            <a class="nav-link text-white fw-bold" href="/contact">
              <i class="bi bi-telephone me-1"></i>
              LIÊN HỆ
            </a>
          </li>
          <li class="nav-item me-4">
            <a class="nav-link text-white fw-bold" href="/faq">
              <i class="bi bi-question-circle me-1"></i>
              HỎI ĐÁP
            </a>
          </li>
          
          <!-- Account Dropdown -->
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle text-white fw-bold" href="#" 
               data-bs-toggle="dropdown">
              <i class="bi bi-person me-1"></i>
              TÀI KHOẢN
            </a>
            <ul class="dropdown-menu account-menu shadow-lg">
              <c:choose>
                <c:when test="${empty sessionScope.user}">
                  <li>
                    <a class="dropdown-item" href="/account/login">
                      <i class="bi bi-box-arrow-in-right me-2 text-success"></i>
                      Đăng nhập
                    </a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="/account/register">
                      <i class="bi bi-person-plus me-2 text-primary"></i>
                      Đăng ký
                    </a>
                  </li>
                </c:when>
                <c:otherwise>
                  <li class="dropdown-header">
                    <i class="bi bi-person-circle me-2"></i>
                    Xin chào, ${sessionScope.user.id}
                  </li>
                  <li><hr class="dropdown-divider"></li>
                  <li>
                    <a class="dropdown-item" href="/account/edit">
                      <i class="bi bi-person-gear me-2 text-info"></i>
                      Cập nhật thông tin
                    </a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="/account/change">
                      <i class="bi bi-key me-2 text-warning"></i>
                      Thay đổi mật khẩu
                    </a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="/order/list">
                      <i class="bi bi-bag-check me-2 text-success"></i>
                      Lịch sử đơn hàng
                    </a>
                  </li>
                  <li>
                    <a class="dropdown-item" href="/order/items">
                      <i class="bi bi-box-seam me-2 text-primary"></i>
                      Sản phẩm đã mua
                    </a>
                  </li>
                  <li><hr class="dropdown-divider"></li>
                  <li>
                    <a class="dropdown-item text-danger" href="/account/logout">
                      <i class="bi bi-box-arrow-right me-2"></i>
                      Đăng xuất
                    </a>
                  </li>
                </c:otherwise>
              </c:choose>
            </ul>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>

<!-- Mobile Navigation -->
<nav class="mobile-navigation d-lg-none bg-primary">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <button class="btn btn-dark w-100 mb-2" type="button" 
                data-bs-toggle="collapse" data-bs-target="#mobileMenu">
          <i class="bi bi-list me-2"></i>
          MENU
        </button>
        
        <div class="collapse" id="mobileMenu">
          <div class="card">
            <div class="card-body p-0">
              <!-- Categories -->
              <div class="accordion" id="mobileAccordion">
                <div class="accordion-item">
                  <h2 class="accordion-header">
                    <button class="accordion-button" type="button" 
                            data-bs-toggle="collapse" data-bs-target="#mobileCategories">
                      <i class="bi bi-grid-3x3-gap me-2"></i>
                      Danh mục sản phẩm
                    </button>
                  </h2>
                  <div id="mobileCategories" class="accordion-collapse collapse show">
                    <div class="accordion-body p-0">
                      <c:forEach var="category" items="${cates}">
                        <a href="/product/list-by-categorys/${category.id}" 
                           class="list-group-item list-group-item-action">
                          <i class="bi bi-tag me-2 text-primary"></i>
                          ${category.name}
                        </a>
                      </c:forEach>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- Main Menu Items -->
              <div class="list-group list-group-flush">
                <a href="/" class="list-group-item list-group-item-action">
                  <i class="bi bi-house me-2"></i>Trang chủ
                </a>
                <a href="/about" class="list-group-item list-group-item-action">
                  <i class="bi bi-info-circle me-2"></i>Giới thiệu
                </a>
                <a href="/contact" class="list-group-item list-group-item-action">
                  <i class="bi bi-telephone me-2"></i>Liên hệ
                </a>
                <a href="/faq" class="list-group-item list-group-item-action">
                  <i class="bi bi-question-circle me-2"></i>Hỏi đáp
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</nav>

<style>
/* Modern Navigation Styles */
.main-navigation {
  padding: 1rem 0;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}

.categories-dropdown .btn {
  border-radius: 8px;
  padding: 0.75rem 1rem;
  font-weight: 600;
  transition: all 0.3s ease;
}

.categories-dropdown .btn:hover {
  background-color: #495057;
  transform: translateY(-1px);
}

.categories-menu {
  border: none;
  border-radius: 12px;
  padding: 0.5rem 0;
  max-height: 400px;
  overflow-y: auto;
}

.categories-menu .dropdown-item {
  padding: 0.75rem 1.25rem;
  border-bottom: 1px solid #f8f9fa;
  transition: all 0.3s ease;
}

.categories-menu .dropdown-item:hover {
  background-color: #f8f9fa;
  padding-left: 1.5rem;
  color: #0d6efd;
}

.categories-menu .dropdown-item:last-child {
  border-bottom: none;
}

.navbar-nav .nav-link {
  padding: 0.75rem 0;
  transition: all 0.3s ease;
  position: relative;
}

.navbar-nav .nav-link:hover {
  color: #ffc107 !important;
  transform: translateY(-2px);
}

.navbar-nav .nav-link::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 2px;
  background-color: #ffc107;
  transition: width 0.3s ease;
}

.navbar-nav .nav-link:hover::after {
  width: 100%;
}

.account-menu {
  border: none;
  border-radius: 12px;
  padding: 0.5rem 0;
  min-width: 250px;
}

.account-menu .dropdown-item {
  padding: 0.75rem 1.25rem;
  transition: all 0.3s ease;
}

.account-menu .dropdown-item:hover {
  background-color: #f8f9fa;
  padding-left: 1.5rem;
}

.account-menu .dropdown-header {
  font-weight: 600;
  color: #495057;
  padding: 0.75rem 1.25rem;
}

/* Mobile Navigation */
.mobile-navigation {
  padding: 1rem 0;
}

.mobile-navigation .accordion-button {
  background-color: #f8f9fa;
  border: none;
  font-weight: 600;
}

.mobile-navigation .accordion-button:not(.collapsed) {
  background-color: #e9ecef;
  color: #0d6efd;
}

.mobile-navigation .list-group-item {
  border: none;
  padding: 0.75rem 1.25rem;
  transition: all 0.3s ease;
}

.mobile-navigation .list-group-item:hover {
  background-color: #f8f9fa;
  padding-left: 1.5rem;
  color: #0d6efd;
}

/* Responsive adjustments */
@media (max-width: 991.98px) {
  .main-navigation {
    display: none;
  }
}

@media (min-width: 992px) {
  .mobile-navigation {
    display: none !important;
  }
}

/* Custom scrollbar for categories menu */
.categories-menu::-webkit-scrollbar {
  width: 6px;
}

.categories-menu::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 3px;
}

.categories-menu::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 3px;
}

.categories-menu::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}
</style>
