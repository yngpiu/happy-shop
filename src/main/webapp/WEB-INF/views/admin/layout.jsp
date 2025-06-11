<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Dashboard - HappyShop</title>

    <!-- Bootstrap 5 CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <!-- Bootstrap Icons -->
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.css"
    />

    <!-- DataTables CSS with Bootstrap 5 -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css"
    />

    <!-- Custom Admin CSS -->
    <style>
      .sidebar {
        background-color: #343a40;
        color: white;
        min-height: 100vh;
        padding: 1rem 0;
      }

      .sidebar .nav-link {
        color: rgba(255, 255, 255, 0.8);
        padding: 0.75rem 1.25rem;
        border-radius: 0;
      }

      .sidebar .nav-link:hover {
        background-color: #495057;
        color: white;
      }

      .sidebar .nav-link.active {
        background-color: #0d6efd;
        color: white;
      }

      .main-content {
        background-color: #f8f9fa;
        min-height: 100vh;
        padding: 1.5rem;
      }

      .card {
        border: 1px solid #dee2e6;
        border-radius: 0.375rem;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
      }

      .table th {
        background-color: #f8f9fa;
        border-bottom: 2px solid #dee2e6;
        font-weight: 600;
      }

      @media (max-width: 767.98px) {
        .sidebar {
          position: fixed;
          top: 0;
          left: -100%;
          width: 250px;
          z-index: 1050;
          transition: left 0.25s ease-in-out;
        }

        .sidebar.show {
          left: 0;
        }

        .main-content {
          margin-left: 0;
          padding: 1rem;
        }

        .mobile-menu-btn {
          display: block !important;
        }

        .sidebar-overlay {
          position: fixed;
          top: 0;
          left: 0;
          width: 100%;
          height: 100%;
          background-color: rgba(0, 0, 0, 0.5);
          z-index: 1040;
          display: none;
        }

        .sidebar-overlay.show {
          display: block;
        }
      }

      @media (min-width: 768px) {
        .sidebar {
          position: fixed;
          top: 0;
          left: 0;
          width: 250px;
          z-index: 1000;
        }

        .main-content {
          margin-left: 250px;
        }

        .mobile-menu-btn {
          display: none !important;
        }
      }

      .mobile-menu-btn {
        position: fixed;
        top: 1rem;
        left: 1rem;
        z-index: 1060;
        background-color: #343a40;
        border: none;
        color: white;
        padding: 0.5rem;
        border-radius: 0.375rem;
      }

      .breadcrumb {
        background-color: transparent;
        padding: 0;
        margin-bottom: 1rem;
      }

      .breadcrumb-item + .breadcrumb-item::before {
        content: '>';
        color: #6c757d;
      }
    </style>
  </head>
  <body>
    <!-- Mobile Menu Button -->
    <button
      class="mobile-menu-btn d-md-none"
      type="button"
      onclick="toggleSidebar()"
    >
      <i class="bi bi-list"></i>
    </button>

    <!-- Sidebar Overlay for Mobile -->
    <div class="sidebar-overlay d-md-none" onclick="closeSidebar()"></div>

    <!-- Sidebar -->
    <tiles:insertAttribute name="menu" />

    <!-- Main Content -->
    <div class="main-content">
      <tiles:insertAttribute name="body" />
    </div>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>

    <!-- CKEditor -->
    <script src="/ckeditor/ckeditor.js"></script>

    <script>
      $(document).ready(function () {
        // Initialize DataTables
        $('#dataTable').DataTable({
          responsive: true,
          language: {
            url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json',
          },
        });

        // Initialize CKEditor if textarea exists
        if ($('#description').length) {
          CKEDITOR.replace('description');
        }

        // Auto-hide alerts after 5 seconds
        setTimeout(function () {
          $('.alert').fadeOut();
        }, 5000);
      });

      // Mobile sidebar functions
      function toggleSidebar() {
        const sidebar = document.querySelector('.sidebar');
        const overlay = document.querySelector('.sidebar-overlay');

        sidebar.classList.toggle('show');
        overlay.classList.toggle('show');
      }

      function closeSidebar() {
        const sidebar = document.querySelector('.sidebar');
        const overlay = document.querySelector('.sidebar-overlay');

        sidebar.classList.remove('show');
        overlay.classList.remove('show');
      }

      // Close sidebar when clicking on nav links on mobile
      document.addEventListener('DOMContentLoaded', function () {
        const navLinks = document.querySelectorAll('.sidebar .nav-link');
        navLinks.forEach(link => {
          link.addEventListener('click', function () {
            if (window.innerWidth < 768) {
              closeSidebar();
            }
          });
        });
      });
    </script>
  </body>
</html>
