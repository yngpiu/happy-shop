<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="base" value="/admin/category" scope="request" />

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-tags me-2"></i>
      Quản lý loại sản phẩm
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item active">Loại sản phẩm</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="${base}/insert" class="btn btn-success">
      <i class="bi bi-plus-circle me-2"></i>
      Thêm loại sản phẩm
    </a>
    <a href="${base}/trash" class="btn btn-outline-danger">
      <i class="bi bi-trash me-2"></i>
      Thùng rác <span class="badge bg-danger">${deletedCategories}</span>
    </a>
  </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
  <div class="alert alert-success auto-hide-alert fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    ${message}
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger auto-hide-alert fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}
  </div>
</c:if>

<!-- Statistics Cards -->
<div class="row mb-4">
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-primary text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Tổng số loại</h6>
            <h3 class="mb-0">${totalCategories}</h3>
            <small class="text-white-50">loại sản phẩm</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-tags display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-success text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Đang hoạt động</h6>
            <h3 class="mb-0">${activeCategories}</h3>
            <small class="text-white-50">loại đang sử dụng</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-check-circle display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-info text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Có sản phẩm</h6>
            <h3 class="mb-0">${categoriesWithProducts}</h3>
            <small class="text-white-50">loại có sản phẩm</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-box display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-warning text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Thùng rác</h6>
            <h3 class="mb-0">${deletedCategories}</h3>
            <small class="text-white-50">đã xóa tạm thời</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-trash display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Filter and View Options -->
<div class="card shadow-sm mb-3">
  <div class="card-body py-3">
    <div class="row align-items-center">
      <div class="col-12 col-md-6">
        <div class="d-flex align-items-center gap-3">
          <label class="form-label mb-0 fw-semibold">Hiển thị:</label>
          <div class="btn-group" role="group">
            <input type="radio" class="btn-check" name="statusFilter" id="activeFilter" value="active" checked>
            <label class="btn btn-outline-success btn-sm" for="activeFilter">
              <i class="bi bi-check-circle me-1"></i>Đang hoạt động (${activeCategories})
            </label>
            <input type="radio" class="btn-check" name="statusFilter" id="allFilter" value="all">
            <label class="btn btn-outline-primary btn-sm" for="allFilter">
              <i class="bi bi-list me-1"></i>Tất cả (${totalCategories})
            </label>
          </div>
        </div>
      </div>
      <div class="col-12 col-md-6 mt-2 mt-md-0">
        <div class="d-flex justify-content-md-end align-items-center gap-2">
          <div class="btn-group" role="group" aria-label="View options">
            <input type="radio" class="btn-check" name="viewType" id="tableView" autocomplete="off" checked>
            <label class="btn btn-outline-secondary btn-sm" for="tableView">
              <i class="bi bi-table"></i> Bảng
            </label>
            <input type="radio" class="btn-check" name="viewType" id="cardView" autocomplete="off">
            <label class="btn btn-outline-secondary btn-sm" for="cardView">
              <i class="bi bi-grid-3x3-gap"></i> Thẻ
            </label>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Category List Card -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center">
      <h5 class="card-title mb-2 mb-sm-0">
        <i class="bi bi-list-ul text-primary me-2"></i>
        Danh sách loại sản phẩm
      </h5>
      <div class="d-flex align-items-center gap-2">
        <span class="badge bg-primary" id="categoryCount">${list.size()} loại</span>
        <button class="btn btn-sm btn-outline-secondary" onclick="refreshData()">
          <i class="bi bi-arrow-clockwise"></i>
        </button>
      </div>
    </div>
  </div>
  
  <div class="card-body p-0">
    <c:choose>
      <c:when test="${empty list}">
        <div class="text-center py-5">
          <i class="bi bi-inbox display-1 text-muted"></i>
          <h4 class="text-muted mt-3">Chưa có loại sản phẩm nào</h4>
          <p class="text-muted">Hãy thêm loại sản phẩm đầu tiên của bạn</p>
          <a href="${base}/insert" class="btn btn-primary">
            <i class="bi bi-plus-circle me-2"></i>
            Thêm loại sản phẩm
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <!-- Table View -->
        <div id="tableViewContainer" class="table-responsive pt-1">
          <table class="table table-hover mb-0" id="dataTable">
            <thead class="table-light">
              <tr>
                <th width="10%" class="text-center">ID</th>
                <th width="35%">Tên loại sản phẩm</th>
                <th width="15%" class="text-center">Số sản phẩm</th>
                <th width="15%" class="text-center">Ngày tạo</th>
                <th width="10%" class="text-center">Trạng thái</th>
                <th width="15%" class="text-center">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="category" items="${list}">
                <tr data-category-id="${category.id}" data-status="${category.deletedAt != null ? 'deleted' : 'active'}">
                  <td class="text-center">
                    <span class="badge bg-light text-dark fw-semibold">#${category.id}</span>
                  </td>
                  <td>
                    <div class="d-flex align-items-center">
                      <c:if test="${category.deletedAt != null}">
                        <i class="bi bi-trash text-muted me-2"></i>
                      </c:if>
                      <div>
                        <div class="fw-semibold ${category.deletedAt != null ? 'text-muted text-decoration-line-through' : 'text-primary'}">
                          ${category.name}
                        </div>
                        <c:if test="${category.deletedAt != null}">
                          <small class="text-danger">
                            <i class="bi bi-clock me-1"></i>
                            Xóa ngày: <fmt:formatDate value="${category.deletedAt}" pattern="dd/MM/yyyy HH:mm"/>
                          </small>
                        </c:if>
                      </div>
                    </div>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${productCounts[category.id] > 0}">
                        <span class="badge bg-info">${productCounts[category.id]} sản phẩm</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-light text-muted">0 sản phẩm</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <small class="text-muted">
                      <fmt:formatDate value="${category.createdAt}" pattern="dd/MM/yyyy"/>
                    </small>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${category.deletedAt != null}">
                        <span class="badge bg-danger">
                          <i class="bi bi-trash me-1"></i>Đã xóa
                        </span>
                      </c:when>
                      <c:when test="${productCounts[category.id] > 0}">
                        <span class="badge bg-success">
                          <i class="bi bi-check-circle me-1"></i>Có sản phẩm
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-warning">
                          <i class="bi bi-exclamation-triangle me-1"></i>Trống
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${category.deletedAt != null}">
                        <!-- Trashed item actions -->
                        <div class="btn-group" role="group">
                          <button type="button" class="btn btn-sm btn-outline-success" 
                                  onclick="restoreCategory('${category.id}', '${category.name}')"
                                  title="Khôi phục">
                            <i class="bi bi-arrow-clockwise"></i>
                          </button>
                          <button type="button" class="btn btn-sm btn-outline-danger" 
                                  onclick="permanentDeleteCategory('${category.id}', '${category.name}')"
                                  title="Xóa vĩnh viễn">
                            <i class="bi bi-x-circle"></i>
                          </button>
                        </div>
                      </c:when>
                      <c:otherwise>
                        <!-- Active item actions -->
                        <div class="btn-group" role="group">
                          <a href="${base}/edit/${category.id}" 
                             class="btn btn-sm btn-outline-primary" 
                             title="Chỉnh sửa">
                            <i class="bi bi-pencil"></i>
                          </a>
                          <button type="button" 
                                  class="btn btn-sm btn-outline-danger" 
                                  onclick="moveToTrash('${category.id}', '${category.name}', '${productCounts[category.id] != null ? productCounts[category.id] : 0}')"
                                  title="Chuyển vào thùng rác">
                            <i class="bi bi-trash"></i>
                          </button>
                        </div>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- Card View -->
        <div id="cardViewContainer" class="p-3" style="display: none;">
          <div class="row">
            <c:forEach var="category" items="${list}">
              <div class="col-12 col-md-6 col-lg-4 mb-3" data-category-id="${category.id}" data-status="${category.deletedAt != null ? 'deleted' : 'active'}">
                <div class="card h-100 border-0 shadow-sm ${category.deletedAt != null ? 'bg-light' : ''}">
                  <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                      <div class="flex-grow-1">
                        <div class="d-flex align-items-center mb-2">
                          <c:if test="${category.deletedAt != null}">
                            <i class="bi bi-trash text-muted me-2"></i>
                          </c:if>
                          <h6 class="card-title mb-0 ${category.deletedAt != null ? 'text-muted text-decoration-line-through' : 'text-primary'}">
                            ${category.name}
                          </h6>
                        </div>
                        <small class="text-muted">ID: #${category.id}</small>
                        <c:if test="${category.deletedAt != null}">
                          <br><small class="text-danger">
                            <i class="bi bi-clock me-1"></i>
                            Xóa: <fmt:formatDate value="${category.deletedAt}" pattern="dd/MM/yyyy"/>
                          </small>
                        </c:if>
                      </div>
                      <c:choose>
                        <c:when test="${category.deletedAt != null}">
                          <span class="badge bg-danger">Đã xóa</span>
                        </c:when>
                        <c:when test="${productCounts[category.id] > 0}">
                          <span class="badge bg-success">Có SP</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-warning">Trống</span>
                        </c:otherwise>
                      </c:choose>
                    </div>
                    
                    <c:if test="${productCounts[category.id] > 0}">
                      <div class="mb-3">
                        <small class="text-info">
                          <i class="bi bi-box me-1"></i>${productCounts[category.id]} sản phẩm
                        </small>
                      </div>
                    </c:if>
                    
                    <div class="d-flex justify-content-between">
                      <c:choose>
                        <c:when test="${category.deletedAt != null}">
                          <button class="btn btn-sm btn-outline-success"
                                  onclick="restoreCategory('${category.id}', '${category.name}')">
                            <i class="bi bi-arrow-clockwise me-1"></i>Khôi phục
                          </button>
                          <button class="btn btn-sm btn-outline-danger"
                                  onclick="permanentDeleteCategory('${category.id}', '${category.name}')">
                            <i class="bi bi-x-circle me-1"></i>Xóa vĩnh viễn
                          </button>
                        </c:when>
                        <c:otherwise>
                          <a href="${base}/edit/${category.id}" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-pencil me-1"></i>Sửa
                          </a>
                          <button class="btn btn-sm btn-outline-danger"
                                  onclick="moveToTrash('${category.id}', '${category.name}', '${productCounts[category.id] != null ? productCounts[category.id] : 0}')">
                            <i class="bi bi-trash me-1"></i>Xóa
                          </button>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<!-- Move to Trash Modal -->
<div class="modal fade" id="trashModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-warning text-dark">
        <h5 class="modal-title">
          <i class="bi bi-trash me-2"></i>
          Chuyển vào thùng rác
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="text-center mb-3">
          <i class="bi bi-trash display-4 text-warning"></i>
        </div>
        <p class="text-center">Bạn có muốn chuyển loại sản phẩm <strong id="trashCategoryName"></strong> vào thùng rác?</p>
        <div class="alert alert-info">
          <i class="bi bi-info-circle me-1"></i>
          <strong>Lưu ý:</strong> Loại sản phẩm sẽ được lưu trong thùng rác 30 ngày và có thể khôi phục. Sau 30 ngày sẽ bị xóa vĩnh viễn.
        </div>
        <div id="productWarning" class="alert alert-warning" style="display: none;">
          <i class="bi bi-exclamation-triangle me-1"></i>
          <strong>Cảnh báo:</strong> Loại này đang có <span id="productCount"></span> sản phẩm. Các sản phẩm sẽ không bị ảnh hưởng.
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          <i class="bi bi-x-circle me-2"></i>Hủy
        </button>
        <form id="trashForm" method="post" style="display: inline;">
          <button type="submit" class="btn btn-warning">
          <i class="bi bi-trash me-2"></i>Chuyển vào thùng rác
        </button>
        </form>
      </div>
    </div>
  </div>
</div>



<script>
  // ========== GLOBAL FUNCTIONS - KHÔNG PHỤ THUỘC JQUERY ==========
  
  /**
   * Hiển thị modal xác nhận chuyển category vào thùng rác
   * @param {number} id - ID của category
   * @param {string} name - Tên category
   * @param {number} productCount - Số lượng sản phẩm của category
   */
  function moveToTrash(id, name, productCount) {
    console.log('Chuyển vào thùng rác:', id, name); // Debug
    
    // Cập nhật tên category vào modal
    document.getElementById('trashCategoryName').textContent = name;
    // Cập nhật form action với URL đúng
    document.getElementById('trashForm').action = '/admin/category/delete/' + id;
    
    // Hiển thị cảnh báo nếu category có sản phẩm
    const productWarning = document.getElementById('productWarning');
    if (productCount > 0) {
      document.getElementById('productCount').textContent = productCount;
      productWarning.style.display = 'block';
    } else {
      productWarning.style.display = 'none';
    }
    
    // Hiển thị modal xác nhận
    new bootstrap.Modal(document.getElementById('trashModal')).show();
  }



  /**
   * Làm mới dữ liệu trang
   */
  function refreshData() {
    location.reload();
  }

  // ========== KHỞI TẠO KHI TRANG TẢI XONG ==========
  document.addEventListener('DOMContentLoaded', function() {
    console.log('Trang đã tải, đang chờ jQuery...'); // Debug
    
    /**
     * Hàm khởi tạo DataTable - chờ jQuery load xong
     * Sử dụng retry pattern để đảm bảo jQuery đã sẵn sàng
     */
    function initializeDataTable() {
      if (typeof $ !== 'undefined') {
        console.log('jQuery đã tải, khởi tạo DataTable...'); // Debug
        
        // ========== CẤU HÌNH DATATABLE ==========
        $('#dataTable').DataTable({
          responsive: true, // Responsive cho mobile
      language: {
            // Ngôn ngữ tiếng Việt
            "sProcessing": "Đang xử lý...",
            "sLengthMenu": "Hiển thị _MENU_ mục",
            "sZeroRecords": "Không tìm thấy dữ liệu",
            "sInfo": "Hiển thị _START_ đến _END_ trong tổng số _TOTAL_ mục",
            "sInfoEmpty": "Hiển thị 0 đến 0 trong tổng số 0 mục",
            "sInfoFiltered": "(được lọc từ _MAX_ mục)",
            "sSearch": "Tìm kiếm:",
            "oPaginate": {
              "sFirst": "Đầu",
              "sPrevious": "Trước",
              "sNext": "Tiếp",
              "sLast": "Cuối"
            }
      },
          pageLength: 25, // Hiển thị 25 dòng mỗi trang
          lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "Tất cả"]], // Tùy chọn số dòng
          order: [[0, 'asc']], // Sắp xếp theo ID tăng dần
      columnDefs: [
            { orderable: false, targets: [5] }, // Cột thao tác không sort được
            { className: "text-center", targets: [0, 2, 3, 4, 5] } // Căn giữa các cột
      ],
          // Layout của các control
      dom: '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
           '<"row"<"col-sm-12"tr>>' +
           '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
          searching: true, // Cho phép tìm kiếm
          paging: true,    // Cho phép phân trang
          info: true,      // Hiển thị thông tin
          autoWidth: false // Không tự động điều chỉnh width
    });

        // ========== BỘ LỌC TRẠNG THÁI ==========
    $('input[name="statusFilter"]').change(function() {
      const filterValue = $(this).val();
      
      if (filterValue === 'active') {
            // Chỉ hiển thị category đang hoạt động
        $('tr[data-status="deleted"]').hide();
        $('div[data-status="deleted"]').hide();
        $('#categoryCount').text($('tr[data-status="active"]').length + ' loại');
      } else {
            // Hiển thị tất cả category
        $('tr[data-status], div[data-status]').show();
        $('#categoryCount').text('${list.size()} loại');
      }
    });

        // ========== CHUYỂN ĐỔI CHẾ ĐỘ HIỂN THỊ ==========
    $('input[name="viewType"]').change(function () {
      if ($(this).attr('id') === 'tableView') {
            // Hiển thị dạng bảng
        $('#tableViewContainer').show();
        $('#cardViewContainer').hide();
      } else {
            // Hiển thị dạng thẻ (card)
        $('#tableViewContainer').hide();
        $('#cardViewContainer').show();
      }
    });

        // ========== KHỞI TẠO MẶC ĐỊNH ==========
        // Mặc định hiển thị category đang hoạt động
    $('input[name="statusFilter"][value="active"]').trigger('change');
        
      } else {
        // jQuery chưa load xong, thử lại sau 100ms
        setTimeout(initializeDataTable, 100);
      }
    }
    
    // Bắt đầu khởi tạo DataTable
    initializeDataTable();
    
    // ========== XỬ LÝ AUTO-HIDE ALERT MESSAGES ==========
    const autoHideAlerts = document.querySelectorAll('.auto-hide-alert');
    autoHideAlerts.forEach(function(alert) {
      // Thêm hiệu ứng bounce nhẹ khi xuất hiện
      alert.style.animation = 'fadeInBounce 0.5s ease-out';
      
      // Thêm hiệu ứng hover
      alert.addEventListener('mouseenter', function() {
        this.style.transform = 'scale(1.01)';
        this.style.boxShadow = '0 4px 15px rgba(0,0,0,0.1)';
      });
      
      alert.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
        this.style.boxShadow = '0 2px 8px rgba(0,0,0,0.05)';
      });
      
      // Tự động ẩn sau 4 giây
      setTimeout(function() {
        if (alert && alert.parentNode) {
          alert.style.transition = 'all 0.6s ease-out';
          alert.style.opacity = '0';
          alert.style.transform = 'translateY(-20px) scale(0.95)';
          
          setTimeout(function() {
            if (alert && alert.parentNode) {
              alert.remove();
            }
          }, 600);
        }
      }, 4000); // 4 giây
    });
  });
</script>

<style>
  @keyframes fadeInBounce {
    0% {
      opacity: 0;
      transform: translateY(-30px) scale(0.9);
    }
    60% {
      opacity: 1;
      transform: translateY(5px) scale(1.02);
    }
    100% {
      opacity: 1;
      transform: translateY(0) scale(1);
    }
  }
  
  .auto-hide-alert {
    transition: all 0.3s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    border: none;
    border-left: 4px solid;
    padding: 1rem 1.25rem;
  }
  
  .auto-hide-alert.alert-success {
    border-left-color: #28a745;
    background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
    color: #155724;
  }
  
  .auto-hide-alert.alert-danger {
    border-left-color: #dc3545;
    background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
    color: #721c24;
  }
</style>
