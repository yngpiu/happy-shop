<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <title>HappyShop - Điện thoại di động giá rẻ - uy tín - chất lượng</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <tiles:insertAttribute name="head" />
    <!-- DataTables CSS với Bootstrap 5 -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css"
    />

    <!-- DataTables Responsive CSS -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.bootstrap5.min.css"
    />
  </head>

  <!-- DataTables JavaScript với Bootstrap 5 -->
  <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
  <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>
  <script src="https://cdn.datatables.net/responsive/2.5.0/js/responsive.bootstrap5.min.js"></script>

  <script>
    $(document).ready(function () {
      $('#dataTables-example').DataTable({
        responsive: true,
        language: {
          sProcessing: 'Đang xử lý...',
          sLengthMenu: 'Hiển thị _MENU_ mục',
          sZeroRecords: 'Không tìm thấy dữ liệu',
          sInfo: 'Hiển thị _START_ đến _END_ trong tổng số _TOTAL_ mục',
          sInfoEmpty: 'Hiển thị 0 đến 0 trong tổng số 0 mục',
          sInfoFiltered: '(được lọc từ _MAX_ mục)',
          sSearch: 'Tìm kiếm:',
          oPaginate: {
            sFirst: 'Đầu',
            sPrevious: 'Trước',
            sNext: 'Tiếp',
            sLast: 'Cuối',
          },
        },
      });
    });
  </script>

  <style>
    /* Main Content Styling */
    .main-content {
      min-height: 60vh;
      background-color: #f8f9fa;
    }

    /* Responsive padding */
    @media (min-width: 768px) {
      .main-content .container-fluid {
        padding-left: 5rem;
        padding-right: 5rem;
      }
    }

    /* Card and component styling */
    .card {
      border: none;
      border-radius: 15px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
      transition: all 0.3s ease;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
    }
  </style>

  <body>
    <tiles:insertAttribute name="header" />

    <tiles:insertAttribute name="menu" />

    <!-- Main Content Area -->
    <main class="main-content">
      <div class="container-fluid px-4 py-3">
        <tiles:insertAttribute name="body" />
      </div>
      <div class="container-fluid">
        <tiles:insertAttribute name="aside" />
      </div>
    </main>

    <tiles:insertAttribute name="footer" />
  </body>
</html>
