<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${param.title} - HappyShop Admin</title>

    <!-- Favicon -->
    <link
      rel="shortcut icon"
      href="${pageContext.request.contextPath}/static/images/favicon.ico"
      type="image/x-icon"
    />

    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <!-- Bootstrap Icons -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
    />

    <!-- Custom CSS -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/static/css/admin.css"
    />

    <!-- Responsive CSS -->
    <style>
      /* Mobile First Approach */
      :root {
        --sidebar-width: 280px;
        --header-height: 60px;
        --primary-color: #0d6efd;
        --secondary-color: #6c757d;
        --success-color: #198754;
        --danger-color: #dc3545;
        --warning-color: #ffc107;
        --info-color: #0dcaf0;
      }

      /* Layout */
      .admin-wrapper {
        display: flex;
        min-height: 100vh;
      }

      .sidebar {
        width: var(--sidebar-width);
        background: #fff;
        border-right: 1px solid #dee2e6;
        position: fixed;
        top: 0;
        left: 0;
        bottom: 0;
        z-index: 1000;
        transition: all 0.3s ease;
      }

      .main-content {
        flex: 1;
        margin-left: var(--sidebar-width);
        transition: all 0.3s ease;
      }

      .header {
        height: var(--header-height);
        background: #fff;
        border-bottom: 1px solid #dee2e6;
        position: sticky;
        top: 0;
        z-index: 999;
      }

      /* Sidebar Styles */
      .sidebar-header {
        height: var(--header-height);
        padding: 0 1.5rem;
        display: flex;
        align-items: center;
        border-bottom: 1px solid #dee2e6;
      }

      .sidebar-brand {
        font-size: 1.25rem;
        font-weight: 600;
        color: var(--primary-color);
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }

      .sidebar-menu {
        padding: 1rem 0;
        list-style: none;
        margin: 0;
      }

      .sidebar-item {
        margin: 0.25rem 0;
      }

      .sidebar-link {
        display: flex;
        align-items: center;
        padding: 0.75rem 1.5rem;
        color: var(--secondary-color);
        text-decoration: none;
        transition: all 0.2s ease;
        gap: 0.75rem;
      }

      .sidebar-link:hover,
      .sidebar-link.active {
        color: var(--primary-color);
        background: rgba(13, 110, 253, 0.1);
      }

      .sidebar-link i {
        font-size: 1.25rem;
        width: 1.5rem;
        text-align: center;
      }

      /* Header Styles */
      .header-content {
        height: 100%;
        padding: 0 1.5rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
      }

      .header-title {
        font-size: 1.25rem;
        font-weight: 600;
        margin: 0;
      }

      .header-actions {
        display: flex;
        align-items: center;
        gap: 1rem;
      }

      .user-dropdown {
        position: relative;
      }

      .user-dropdown-toggle {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem;
        border: none;
        background: none;
        color: var(--secondary-color);
        cursor: pointer;
      }

      .user-dropdown-toggle:hover {
        color: var(--primary-color);
      }

      .user-dropdown-menu {
        position: absolute;
        top: 100%;
        right: 0;
        background: #fff;
        border: 1px solid #dee2e6;
        border-radius: 0.375rem;
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        min-width: 200px;
        display: none;
      }

      .user-dropdown-menu.show {
        display: block;
      }

      .user-dropdown-item {
        display: block;
        padding: 0.5rem 1rem;
        color: var(--secondary-color);
        text-decoration: none;
        transition: all 0.2s ease;
      }

      .user-dropdown-item:hover {
        color: var(--primary-color);
        background: rgba(13, 110, 253, 0.1);
      }

      /* Content Area */
      .content {
        padding: 1.5rem;
      }

      /* Responsive Breakpoints */
      @media (max-width: 991.98px) {
        .sidebar {
          transform: translateX(-100%);
        }

        .sidebar.show {
          transform: translateX(0);
        }

        .main-content {
          margin-left: 0;
        }

        .header-toggle {
          display: block;
        }
      }

      @media (max-width: 767.98px) {
        .header-title {
          font-size: 1.1rem;
        }

        .content {
          padding: 1rem;
        }

        .card {
          margin-bottom: 1rem;
        }
      }

      @media (max-width: 575.98px) {
        .header-content {
          padding: 0 1rem;
        }

        .header-actions {
          gap: 0.5rem;
        }

        .user-dropdown-toggle span {
          display: none;
        }
      }

      /* Utility Classes */
      .text-truncate {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }

      .flex-grow-1 {
        flex-grow: 1;
      }

      .d-none {
        display: none !important;
      }

      @media (max-width: 991.98px) {
        .d-lg-none {
          display: block !important;
        }
      }

      .sidebar-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
        display: none;
      }

      .sidebar.show + .sidebar-overlay {
        display: block;
      }
    </style>
  </head>
  <body>
    <div class="admin-wrapper">
      <!-- Sidebar -->
      <aside class="sidebar">
        <div class="sidebar-header">
          <a
            href="${pageContext.request.contextPath}/admin"
            class="sidebar-brand"
          >
            <i class="bi bi-shop"></i>
            <span>HappyShop</span>
          </a>
        </div>
        <ul class="sidebar-menu">
          <li class="sidebar-item">
            <a
              href="${pageContext.request.contextPath}/admin"
              class="sidebar-link ${param.active == 'dashboard' ? 'active' : ''}"
            >
              <i class="bi bi-speedometer2"></i>
              <span>Dashboard</span>
            </a>
          </li>
          <li class="sidebar-item">
            <a
              href="${pageContext.request.contextPath}/admin/orders"
              class="sidebar-link ${param.active == 'orders' ? 'active' : ''}"
            >
              <i class="bi bi-cart"></i>
              <span>Quản lý đơn hàng</span>
            </a>
          </li>
          <li class="sidebar-item">
            <a
              href="${pageContext.request.contextPath}/admin/products"
              class="sidebar-link ${param.active == 'products' ? 'active' : ''}"
            >
              <i class="bi bi-box"></i>
              <span>Quản lý sản phẩm</span>
            </a>
          </li>
          <li class="sidebar-item">
            <a
              href="${pageContext.request.contextPath}/admin/categories"
              class="sidebar-link ${param.active == 'categories' ? 'active' : ''}"
            >
              <i class="bi bi-grid"></i>
              <span>Quản lý danh mục</span>
            </a>
          </li>
          <li class="sidebar-item">
            <a
              href="${pageContext.request.contextPath}/admin/users"
              class="sidebar-link ${param.active == 'users' ? 'active' : ''}"
            >
              <i class="bi bi-people"></i>
              <span>Quản lý người dùng</span>
            </a>
          </li>
          <li class="sidebar-item">
            <a
              href="${pageContext.request.contextPath}/admin/reports"
              class="sidebar-link ${param.active == 'reports' ? 'active' : ''}"
            >
              <i class="bi bi-graph-up"></i>
              <span>Báo cáo thống kê</span>
            </a>
          </li>
        </ul>
      </aside>

      <!-- Main Content -->
      <main class="main-content">
        <!-- Header -->
        <header class="header">
          <div class="header-content">
            <button class="btn btn-link header-toggle d-lg-none" type="button">
              <i class="bi bi-list"></i>
            </button>
            <h1 class="header-title">${param.title}</h1>
            <div class="header-actions">
              <div class="user-dropdown">
                <button class="user-dropdown-toggle" type="button">
                  <i class="bi bi-person-circle"></i>
                  <span>${sessionScope.adminUser.fullName}</span>
                </button>
                <div class="user-dropdown-menu">
                  <a
                    href="${pageContext.request.contextPath}/admin/profile"
                    class="user-dropdown-item"
                  >
                    <i class="bi bi-person me-2"></i>Thông tin cá nhân
                  </a>
                  <a
                    href="${pageContext.request.contextPath}/admin/settings"
                    class="user-dropdown-item"
                  >
                    <i class="bi bi-gear me-2"></i>Cài đặt
                  </a>
                  <div class="dropdown-divider"></div>
                  <a
                    href="${pageContext.request.contextPath}/admin/logout"
                    class="user-dropdown-item text-danger"
                  >
                    <i class="bi bi-box-arrow-right me-2"></i>Đăng xuất
                  </a>
                </div>
              </div>
            </div>
          </div>
        </header>

        <!-- Content -->
        <div class="content">
          <jsp:include page="${param.content}" />
        </div>
      </main>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

    <!-- Custom JavaScript -->
    <script>
      // Toggle Sidebar
      document
        .querySelector('.header-toggle')
        .addEventListener('click', function () {
          const sidebar = document.querySelector('.sidebar');
          sidebar.classList.toggle('show');

          // Add overlay when sidebar is shown
          if (sidebar.classList.contains('show')) {
            const overlay = document.createElement('div');
            overlay.className = 'sidebar-overlay';
            document.body.appendChild(overlay);

            // Close sidebar when clicking overlay
            overlay.addEventListener('click', function () {
              sidebar.classList.remove('show');
              overlay.remove();
            });
          } else {
            // Remove overlay when sidebar is hidden
            const overlay = document.querySelector('.sidebar-overlay');
            if (overlay) overlay.remove();
          }
        });

      // Handle Window Resize
      window.addEventListener('resize', function () {
        const sidebar = document.querySelector('.sidebar');
        const overlay = document.querySelector('.sidebar-overlay');

        if (window.innerWidth > 1024) {
          sidebar.classList.remove('show');
          if (overlay) overlay.remove();
        }
      });

      // Toggle User Dropdown
      document
        .querySelector('.user-dropdown-toggle')
        .addEventListener('click', function () {
          document
            .querySelector('.user-dropdown-menu')
            .classList.toggle('show');
        });

      // Close User Dropdown when clicking outside
      document.addEventListener('click', function (event) {
        const dropdown = document.querySelector('.user-dropdown');
        if (!dropdown.contains(event.target)) {
          document
            .querySelector('.user-dropdown-menu')
            .classList.remove('show');
        }
      });
    </script>
  </body>
</html>
