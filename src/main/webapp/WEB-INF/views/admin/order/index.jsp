<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="base" value="/admin/order" scope="request" />

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-cart-check me-2"></i>
      Quản lý đơn hàng
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item active">Đơn hàng</li>
      </ol>
    </nav>
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
            <h6 class="card-title text-white mb-1">Tổng đơn hàng</h6>
            <h3 class="mb-0">${totalOrders}</h3>
            <small class="text-white">đơn hàng</small>
          </div>
          <div class="text-white">
            <i class="bi bi-cart-check display-6"></i>
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
            <h6 class="card-title text-white mb-1">Chờ xử lý</h6>
            <h3 class="mb-0">${pendingOrders}</h3>
            <small class="text-white">cần duyệt</small>
          </div>
          <div class="text-white">
            <i class="bi bi-clock display-6"></i>
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
            <h6 class="card-title text-white mb-1">Đang xử lý</h6>
            <h3 class="mb-0">${processingOrders}</h3>
            <small class="text-white">đang chuẩn bị</small>
          </div>
          <div class="text-white">
            <i class="bi bi-gear display-6"></i>
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
            <h6 class="card-title text-white mb-1">Hoàn thành</h6>
            <h3 class="mb-0">${completedOrders}</h3>
            <small class="text-white">đã giao</small>
          </div>
          <div class="text-white">
            <i class="bi bi-check-circle display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-dark text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Doanh thu</h6>
            <h3 class="mb-0">
              <fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="" maxFractionDigits="0"/>₫
            </h3>
            <small class="text-white">đã hoàn thành</small>
          </div>
          <div class="text-white">
            <i class="bi bi-cash-coin display-6"></i>
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
            <input type="radio" class="btn-check" name="statusFilter" id="allFilter" value="all" checked>
            <label class="btn btn-outline-primary btn-sm" for="allFilter">
              <i class="bi bi-list me-1"></i>Tất cả (${totalOrders})
            </label>
            <input type="radio" class="btn-check" name="statusFilter" id="pendingFilter" value="pending">
            <label class="btn btn-outline-warning btn-sm" for="pendingFilter">
              <i class="bi bi-clock me-1"></i>Chờ xử lý (${pendingOrders})
            </label>
            <input type="radio" class="btn-check" name="statusFilter" id="completedFilter" value="completed">
            <label class="btn btn-outline-success btn-sm" for="completedFilter">
              <i class="bi bi-check-circle me-1"></i>Hoàn thành (${completedOrders})
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

<!-- Order List Card -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center">
      <h5 class="card-title mb-2 mb-sm-0">
        <i class="bi bi-list-ul text-primary me-2"></i>
        Danh sách đơn hàng
      </h5>
      <div class="d-flex align-items-center gap-2">
        <span class="badge bg-primary" id="orderCount">${list.size()} đơn hàng</span>
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
          <i class="bi bi-cart-x display-1 text-muted"></i>
          <h4 class="text-muted mt-3">Chưa có đơn hàng nào</h4>
          <p class="text-muted">Các đơn hàng sẽ hiển thị ở đây khi khách hàng đặt hàng</p>
        </div>
      </c:when>
      <c:otherwise>
        <!-- Table View -->
        <div id="tableViewContainer">
          <div class="table-responsive">
            <table class="table table-hover mb-0" id="dataTable">
              <thead class="table-light">
                <tr>
                  <th width="8%" class="text-center">ID</th>
                  <th width="20%">Khách hàng</th>
                  <th width="15%" class="text-center">Ngày đặt</th>
                  <th width="15%" class="text-center">Tổng tiền</th>
                  <th width="10%" class="text-center">Số SP</th>
                  <th width="12%" class="text-center">Trạng thái</th>
                  <th width="20%" class="text-center">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="order" items="${list}">
                  <tr data-order-id="${order.id}" 
                      data-status="${order.status != null ? order.status : 0}">
                    <td class="text-center">
                      <span class="badge bg-light text-dark fw-semibold">#${order.id}</span>
                    </td>
                    <td>
                      <div class="d-flex align-items-center">
                        <div>
                          <div class="fw-semibold text-primary">
                            ${order.user.fullname}
                          </div>
                          <small class="text-muted">
                            <i class="bi bi-telephone me-1"></i>${order.telephone}
                          </small>
                        </div>
                      </div>
                    </td>
                    <td class="text-center">
                      <small class="text-muted">
                        <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/>
                      </small>
                    </td>
                    <td class="text-center">
                      <div class="fw-bold text-success">
                        <fmt:formatNumber value="${order.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                      </div>
                    </td>
                    <td class="text-center">
                      <span class="badge bg-info">${itemCounts[order.id]}</span>
                    </td>
                    <td class="text-center">
                      <c:choose>
                        <c:when test="${order.status == null || order.status == 0}">
                          <span class="badge bg-warning text-dark">
                            <i class="bi bi-clock me-1"></i>Chờ xử lý
                          </span>
                        </c:when>
                        <c:when test="${order.status == 1}">
                          <span class="badge bg-info">
                            <i class="bi bi-gear me-1"></i>Đang xử lý
                          </span>
                        </c:when>
                        <c:when test="${order.status == 2}">
                          <span class="badge bg-primary">
                            <i class="bi bi-truck me-1"></i>Đang giao
                          </span>
                        </c:when>
                        <c:when test="${order.status == 3}">
                          <span class="badge bg-success">
                            <i class="bi bi-check-circle me-1"></i>Hoàn thành
                          </span>
                        </c:when>
                        <c:when test="${order.status == -1}">
                          <span class="badge bg-danger">
                            <i class="bi bi-x-circle me-1"></i>Đã hủy
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-secondary">Không xác định</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td class="text-center">
                      <div class="btn-group btn-group-sm" role="group">
                        <!-- Xem chi tiết -->
                        <a href="${base}/details/${order.id}" class="btn btn-sm btn-outline-info" title="Xem chi tiết">
                          <i class="bi bi-eye"></i>
                        </a>
                        
                        <!-- Actions theo trạng thái -->
                        <c:choose>
                          <c:when test="${order.status == null || order.status == 0}">
                            <!-- Chờ xử lý: có thể duyệt hoặc hủy -->
                            <button class="btn btn-sm btn-outline-success" title="Duyệt đơn hàng"
                                    onclick="changeStatus('${order.id}', 'process', 'Duyệt đơn hàng')">
                              <i class="bi bi-check"></i>
                            </button>
                            <button class="btn btn-sm btn-outline-danger" title="Hủy đơn hàng"
                                    onclick="changeStatus('${order.id}', 'cancel', 'Hủy đơn hàng')">
                              <i class="bi bi-x"></i>
                            </button>
                          </c:when>
                          <c:when test="${order.status == 1}">
                            <!-- Đang xử lý: có thể chuyển sang giao hoặc hủy -->
                            <button class="btn btn-sm btn-outline-primary" title="Chuyển giao hàng"
                                    onclick="changeStatus('${order.id}', 'ship', 'Chuyển giao hàng')">
                              <i class="bi bi-truck"></i>
                            </button>
                            <button class="btn btn-sm btn-outline-danger" title="Hủy đơn hàng"
                                    onclick="changeStatus('${order.id}', 'cancel', 'Hủy đơn hàng')">
                              <i class="bi bi-x"></i>
                            </button>
                          </c:when>
                          <c:when test="${order.status == 2}">
                            <!-- Đang giao: có thể hoàn thành -->
                            <button class="btn btn-sm btn-outline-success" title="Hoàn thành đơn hàng"
                                    onclick="changeStatus('${order.id}', 'complete', 'Hoàn thành đơn hàng')">
                              <i class="bi bi-check-circle"></i>
                            </button>
                          </c:when>
                          <c:otherwise>
                            <!-- Hoàn thành hoặc đã hủy: chỉ xem -->
                            <span class="text-muted">-</span>
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
        <div id="cardViewContainer" style="display: none;" class="p-3">
          <div class="row">
            <c:forEach var="order" items="${list}">
              <div class="col-12 col-md-6 col-lg-4 mb-3" data-status="${order.status != null ? order.status : 0}">
                <div class="card h-100">
                  <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                      <h6 class="card-title text-primary">
                        Đơn hàng #${order.id}
                      </h6>
                      <c:choose>
                        <c:when test="${order.status == null || order.status == 0}">
                          <span class="badge bg-warning text-dark">Chờ xử lý</span>
                        </c:when>
                        <c:when test="${order.status == 1}">
                          <span class="badge bg-info">Đang xử lý</span>
                        </c:when>
                        <c:when test="${order.status == 2}">
                          <span class="badge bg-primary">Đang giao</span>
                        </c:when>
                        <c:when test="${order.status == 3}">
                          <span class="badge bg-success">Hoàn thành</span>
                        </c:when>
                        <c:when test="${order.status == -1}">
                          <span class="badge bg-danger">Đã hủy</span>
                        </c:when>
                      </c:choose>
                    </div>
                    
                    <div class="mb-2">
                      <strong class="text-success">
                        <fmt:formatNumber value="${order.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                      </strong>
                    </div>
                    
                    <div class="mb-2">
                      <small class="text-muted">
                        Khách hàng: <span class="fw-semibold">${order.user.fullname}</span><br>
                        Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy"/><br>
                        Số SP: ${itemCounts[order.id]} sản phẩm
                      </small>
                    </div>
                    
                    <div class="d-flex gap-1">
                      <a href="${base}/details/${order.id}" class="btn btn-outline-info btn-sm flex-fill">
                        <i class="bi bi-eye me-1"></i>Chi tiết
                      </a>
                      
                      <c:choose>
                        <c:when test="${order.status == null || order.status == 0}">
                          <button class="btn btn-outline-success btn-sm"
                                  onclick="changeStatus('${order.id}', 'process', 'Duyệt đơn hàng')">
                            <i class="bi bi-check"></i>
                          </button>
                        </c:when>
                        <c:when test="${order.status == 1}">
                          <button class="btn btn-outline-primary btn-sm"
                                  onclick="changeStatus('${order.id}', 'ship', 'Chuyển giao hàng')">
                            <i class="bi bi-truck"></i>
                          </button>
                        </c:when>
                        <c:when test="${order.status == 2}">
                          <button class="btn btn-outline-success btn-sm"
                                  onclick="changeStatus('${order.id}', 'complete', 'Hoàn thành đơn hàng')">
                            <i class="bi bi-check-circle"></i>
                          </button>
                        </c:when>
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

<script>
  /**
   * Thay đổi trạng thái đơn hàng
   * @param {string} orderId - ID của đơn hàng
   * @param {string} action - Hành động cần thực hiện (process, ship, complete, cancel)
   * @param {string} actionName - Tên hành động để hiển thị
   */
  function changeStatus(orderId, action, actionName) {
    console.log('Thay đổi trạng thái đơn hàng:', orderId, action); // Debug
    
    if (confirm('Bạn có chắc chắn muốn ' + actionName.toLowerCase() + ' #' + orderId + '?')) {
      // Tạo form và submit
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = '/admin/order/' + action + '/' + orderId;
      document.body.appendChild(form);
      form.submit();
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
          order: [[2, 'desc']], // Sắp xếp theo ngày đặt giảm dần (mới nhất trước)
          columnDefs: [
            { orderable: false, targets: [6] }, // Cột thao tác không sort được
            { className: "text-center", targets: [0, 2, 3, 4, 5, 6] } // Căn giữa các cột
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
          
          if (filterValue === 'pending') {
            // Chỉ hiển thị đơn hàng chờ xử lý (status = 0 hoặc null)
            $('tr[data-status]:not([data-status="0"])').hide();
            $('div[data-status]:not([data-status="0"])').hide();
            $('#orderCount').text($('tr[data-status="0"]').length + ' đơn hàng');
          } else if (filterValue === 'completed') {
            // Chỉ hiển thị đơn hàng hoàn thành (status = 3)
            $('tr[data-status]:not([data-status="3"])').hide();
            $('div[data-status]:not([data-status="3"])').hide();
            $('#orderCount').text($('tr[data-status="3"]').length + ' đơn hàng');
          } else {
            // Hiển thị tất cả đơn hàng
            $('tr[data-status], div[data-status]').show();
            $('#orderCount').text('${list.size()} đơn hàng');
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
        // Mặc định hiển thị tất cả đơn hàng
        $('input[name="statusFilter"][value="all"]').trigger('change');
        
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
