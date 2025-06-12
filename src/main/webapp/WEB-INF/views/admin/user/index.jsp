<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="base" value="/admin/user" scope="request" />

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-people me-2"></i>
      Quản lý người dùng
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item active">Người dùng</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="${base}/insert" class="btn btn-success">
      <i class="bi bi-plus-circle me-2"></i>
      Thêm người dùng
    </a>
  </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
  <div class="alert alert-success auto-hide-alert fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    ${message}${param.message}
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger auto-hide-alert fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}${param.error}
  </div>
</c:if>

<!-- Statistics Cards -->
<div class="row mb-4">
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-primary text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Tổng người dùng</h6>
            <h3 class="mb-0">${totalUsers}</h3>
            <small class="text-white">người dùng</small>
          </div>
          <div class="text-white">
            <i class="bi bi-people display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-success text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Đang hoạt động</h6>
            <h3 class="mb-0">${activeUsers}</h3>
            <small class="text-white">hoạt động</small>
          </div>
          <div class="text-white">
            <i class="bi bi-check-circle display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-warning text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Quản trị viên</h6>
            <h3 class="mb-0">${adminUsers}</h3>
            <small class="text-white">admin</small>
          </div>
          <div class="text-white">
            <i class="bi bi-shield-check display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-info text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Người dùng thường</h6>
            <h3 class="mb-0">${regularUsers}</h3>
            <small class="text-white">thành viên</small>
          </div>
          <div class="text-white">
            <i class="bi bi-person display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-danger text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Bị cấm</h6>
            <h3 class="mb-0">${bannedUsers}</h3>
            <small class="text-white">tạm khóa</small>
          </div>
          <div class="text-white">
            <i class="bi bi-person-x display-6"></i>
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
              <i class="bi bi-check-circle me-1"></i>Đang hoạt động (${activeUsers})
            </label>
            <input type="radio" class="btn-check" name="statusFilter" id="allFilter" value="all">
            <label class="btn btn-outline-primary btn-sm" for="allFilter">
              <i class="bi bi-list me-1"></i>Tất cả (${totalUsers})
            </label>
            <input type="radio" class="btn-check" name="statusFilter" id="bannedFilter" value="banned">
            <label class="btn btn-outline-danger btn-sm" for="bannedFilter">
              <i class="bi bi-person-x me-1"></i>Bị cấm (${bannedUsers})
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

<!-- User List Card -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center">
      <h5 class="card-title mb-2 mb-sm-0">
        <i class="bi bi-list-ul text-primary me-2"></i>
        Danh sách người dùng
      </h5>
      <div class="d-flex align-items-center gap-2">
        <span class="badge bg-primary" id="userCount">${list.size()} người dùng</span>
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
          <i class="bi bi-person-x display-1 text-muted"></i>
          <h4 class="text-muted mt-3">Chưa có người dùng nào</h4>
          <p class="text-muted">Bấm nút "Thêm người dùng" để tạo tài khoản mới</p>
          <a href="${base}/insert" class="btn btn-success">
            <i class="bi bi-plus-circle me-2"></i>
            Thêm người dùng đầu tiên
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <!-- Table View -->
        <div id="tableViewContainer">
          <div class="table-responsive">
            <table class="table table-hover mb-0" id="dataTable">
              <thead class="table-light">
                <tr>
                  <th scope="col" width="100px">Avatar</th>
                  <th scope="col">Thông tin</th>
                  <th scope="col">Liên hệ</th>
                  <th scope="col" width="120px">Trạng thái</th>
                  <th scope="col" width="100px">Vai trò</th>
                  <th scope="col" width="200px">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="user" items="${list}">
                  <tr class="user-row" data-status="${user.isBanned ? 'banned' : 'active'}" data-role="${user.admin ? 'admin' : 'user'}">
                    <td>
                      <div class="d-flex align-items-center">
                        <img src="/static/images/customers/${user.photo}" 
                             alt="${user.fullname}" 
                             class="rounded-circle me-2"
                             style="width: 50px; height: 50px; object-fit: cover;"
                             onerror="this.src='/static/images/customers/user.png'">
                      </div>
                    </td>
                    <td>
                      <div>
                        <h6 class="mb-1 fw-semibold">${user.fullname}</h6>
                        <small class="text-muted">@${user.id}</small>
                      </div>
                    </td>
                    <td>
                      <div>
                        <div class="mb-1">
                          <i class="bi bi-envelope me-1"></i>
                          <small>${user.email}</small>
                        </div>
                        <div>
                          <i class="bi bi-telephone me-1"></i>
                          <small>${user.telephone}</small>
                        </div>
                      </div>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${user.isBanned}">
                          <span class="badge bg-danger">
                            <i class="bi bi-x-circle me-1"></i>Bị cấm
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-success">
                            <i class="bi bi-check-circle me-1"></i>Hoạt động
                          </span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${user.admin}">
                          <span class="badge bg-warning">
                            <i class="bi bi-shield-check me-1"></i>Admin
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-info">
                            <i class="bi bi-person me-1"></i>User
                          </span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <div class="btn-group" role="group">
                        <a href="${base}/edit/${user.id}" 
                           class="btn btn-outline-primary btn-sm"
                           title="Chỉnh sửa">
                          <i class="bi bi-pencil"></i>
                        </a>
                        
                        <c:choose>
                          <c:when test="${user.isBanned}">
                            <button type="button" 
                                    class="btn btn-outline-success btn-sm"
                                    title="Mở cấm người dùng"
                                    onclick="confirmUnban('${user.id}', '${user.fullname}')">
                              <i class="bi bi-person-check"></i>
                            </button>
                          </c:when>
                          <c:otherwise>
                            <button type="button" 
                                    class="btn btn-outline-danger btn-sm"
                                    title="Cấm người dùng"
                                    onclick="confirmBan('${user.id}', '${user.fullname}')">
                              <i class="bi bi-person-x"></i>
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
        
        <!-- Card View -->
        <div id="cardViewContainer" style="display: none;">
          <div class="row p-3">
            <c:forEach var="user" items="${list}">
              <div class="col-12 col-md-6 col-lg-4 mb-3 user-card" data-status="${user.isBanned ? 'banned' : 'active'}" data-role="${user.admin ? 'admin' : 'user'}">
                <div class="card h-100 shadow-sm">
                  <div class="card-body">
                    <div class="d-flex align-items-start mb-3">
                      <img src="/static/images/customers/${user.photo}" 
                           alt="${user.fullname}" 
                           class="rounded-circle me-3"
                           style="width: 60px; height: 60px; object-fit: cover;"
                           onerror="this.src='/static/images/customers/user.png'">
                      <div class="flex-grow-1">
                        <h6 class="card-title mb-1">${user.fullname}</h6>
                        <small class="text-muted">@${user.id}</small>
                        <div class="mt-2">
                          <c:choose>
                            <c:when test="${user.isBanned}">
                              <span class="badge bg-danger">Bị cấm</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge bg-success">Hoạt động</span>
                            </c:otherwise>
                          </c:choose>
                          <c:choose>
                            <c:when test="${user.admin}">
                              <span class="badge bg-warning">Admin</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge bg-info">User</span>
                            </c:otherwise>
                          </c:choose>
                        </div>
                      </div>
                    </div>
                    
                    <div class="mb-3">
                      <div class="mb-2">
                        <i class="bi bi-envelope me-2"></i>
                        <small>${user.email}</small>
                      </div>
                      <div>
                        <i class="bi bi-telephone me-2"></i>
                        <small>${user.telephone}</small>
                      </div>
                    </div>
                    
                    <div class="d-flex gap-2">
                      <a href="${base}/edit/${user.id}" 
                         class="btn btn-outline-primary btn-sm flex-fill">
                        <i class="bi bi-pencil me-1"></i>Sửa
                      </a>
                      
                      <c:choose>
                        <c:when test="${user.isBanned}">
                          <button type="button" 
                                  class="btn btn-outline-success btn-sm flex-fill"
                                  onclick="confirmUnban('${user.id}', '${user.fullname}')">
                            <i class="bi bi-person-check me-1"></i>Mở cấm
                          </button>
                        </c:when>
                        <c:otherwise>
                          <button type="button" 
                                  class="btn btn-outline-danger btn-sm flex-fill"
                                  onclick="confirmBan('${user.id}', '${user.fullname}')">
                            <i class="bi bi-person-x me-1"></i>Cấm
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

<!-- Hidden Forms for Actions -->
<form id="banUserForm" method="post" style="display: none;">
  <input type="hidden" name="id" id="banUserId">
</form>

<form id="unbanUserForm" method="post" style="display: none;">
  <input type="hidden" name="id" id="unbanUserId">
</form>

<script>
  /**
   * Xác nhận cấm người dùng
   * @param {string} userId - ID của người dùng
   * @param {string} userName - Tên của người dùng
   */
  function confirmBan(userId, userName) {
    console.log('Cấm người dùng:', userId, userName); // Debug
    
    if (confirm('Bạn có chắc chắn muốn cấm người dùng "' + userName + '"?\n\nNgười dùng sẽ không thể đăng nhập vào hệ thống.')) {
      document.getElementById('banUserId').value = userId;
      document.getElementById('banUserForm').action = '${base}/ban/' + userId;
      document.getElementById('banUserForm').submit();
    }
  }

  /**
   * Xác nhận mở cấm người dùng
   * @param {string} userId - ID của người dùng  
   * @param {string} userName - Tên của người dùng
   */
  function confirmUnban(userId, userName) {
    console.log('Mở cấm người dùng:', userId, userName); // Debug
    
    if (confirm('Bạn có chắc chắn muốn mở cấm cho người dùng "' + userName + '"?\n\nNgười dùng sẽ có thể đăng nhập trở lại.')) {
      document.getElementById('unbanUserId').value = userId;
      document.getElementById('unbanUserForm').action = '${base}/unban/' + userId;
      document.getElementById('unbanUserForm').submit();
    }
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
          order: [[1, 'asc']], // Sắp xếp theo tên user tăng dần
          columnDefs: [
            { orderable: false, targets: [0, 5] }, // Cột avatar và hành động không sort được
            { className: "text-center", targets: [0, 3, 4, 5] } // Căn giữa các cột
          ],
          // Layout của các control với padding
          dom: '<"row px-3 py-2"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
               '<"row"<"col-sm-12"tr>>' +
               '<"row px-3 py-2"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
          searching: true, // Cho phép tìm kiếm
          paging: true,    // Cho phép phân trang
          info: true,      // Hiển thị thông tin
          autoWidth: false // Không tự động điều chỉnh width
        });

        // ========== BỘ LỌC TRẠNG THÁI ==========
        $('input[name="statusFilter"]').change(function() {
          const filterValue = $(this).val();
          
          if (filterValue === 'active') {
            // Chỉ hiển thị người dùng đang hoạt động
            $('tr[data-status="banned"]').hide();
            $('div[data-status="banned"]').hide();
            $('#userCount').text($('tr[data-status="active"]').length + ' người dùng');
          } else if (filterValue === 'banned') {
            // Chỉ hiển thị người dùng bị cấm
            $('tr[data-status="active"]').hide();
            $('div[data-status="active"]').hide();
            $('#userCount').text($('tr[data-status="banned"]').length + ' người dùng');
          } else {
            // Hiển thị tất cả người dùng
            $('tr[data-status], div[data-status]').show();
            $('#userCount').text('${list.size()} người dùng');
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
        // Mặc định hiển thị người dùng đang hoạt động
        $('input[name="statusFilter"][value="active"]').trigger('change');
        
      } else {
        // jQuery chưa load xong, thử lại sau 100ms
        setTimeout(initializeDataTable, 100);
      }
    }
    
    // Bắt đầu khởi tạo DataTable
    initializeDataTable();
  });
</script>

<!-- Custom CSS for 5 column layout & Alert Animations -->
<style>
  @media (min-width: 768px) {
    .col-md-2-4 {
      flex: 0 0 20%;
      max-width: 20%;
    }
  }
  
  /* Alert Animations */
  @keyframes fadeInBounce {
    0% {
      opacity: 0;
      transform: translateY(-30px) scale(0.95);
    }
    50% {
      opacity: 0.8;
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