<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="base" value="/admin/order" scope="request" />

<!-- Page Header -->
<div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4">
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-receipt me-2"></i>
      Chi tiết đơn hàng #${order.id}
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/order/index">Đơn hàng</a>
        </li>
        <li class="breadcrumb-item active">Chi tiết #${order.id}</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="/admin/order/index" class="btn btn-outline-secondary">
      <i class="bi bi-arrow-left me-2"></i>Quay lại
    </a>
    <button class="btn btn-outline-primary" onclick="window.print()">
      <i class="bi bi-printer me-2"></i>In đơn hàng
    </button>
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

<div class="row">
  <!-- Thông tin đơn hàng -->
  <div class="col-lg-8">
    <div class="card shadow-sm mb-4">
      <div class="card-header bg-light">
        <h5 class="card-title mb-0">
          <i class="bi bi-info-circle text-primary me-2"></i>
          Thông tin đơn hàng
        </h5>
      </div>
      <div class="card-body">
        <div class="row">
          <div class="col-md-6">
            <table class="table table-borderless">
              <tr>
                <td width="40%" class="fw-semibold text-muted">Mã đơn hàng:</td>
                <td>
                  <span class="badge bg-primary fs-6">#${order.id}</span>
                </td>
              </tr>
              <tr>
                <td class="fw-semibold text-muted">Ngày đặt hàng:</td>
                <td>
                  <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                </td>
              </tr>
              <tr>
                <td class="fw-semibold text-muted">Trạng thái:</td>
                <td>
                  <c:choose>
                    <c:when test="${order.status == null || order.status == 0}">
                      <span class="badge bg-warning text-dark fs-6">
                        <i class="bi bi-clock me-1"></i>Chờ xử lý
                      </span>
                    </c:when>
                    <c:when test="${order.status == 1}">
                      <span class="badge bg-info fs-6">
                        <i class="bi bi-gear me-1"></i>Đang xử lý
                      </span>
                    </c:when>
                    <c:when test="${order.status == 2}">
                      <span class="badge bg-primary fs-6">
                        <i class="bi bi-truck me-1"></i>Đang giao
                      </span>
                    </c:when>
                    <c:when test="${order.status == 3}">
                      <span class="badge bg-success fs-6">
                        <i class="bi bi-check-circle me-1"></i>Hoàn thành
                      </span>
                    </c:when>
                    <c:when test="${order.status == -1}">
                      <span class="badge bg-danger fs-6">
                        <i class="bi bi-x-circle me-1"></i>Đã hủy
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge bg-secondary fs-6">Không xác định</span>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </table>
          </div>
          <div class="col-md-6">
            <table class="table table-borderless">
              <tr>
                <td width="40%" class="fw-semibold text-muted">Tổng tiền:</td>
                <td>
                  <span class="fs-5 fw-bold text-success">
                    <fmt:formatNumber value="${order.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                  </span>
                </td>
              </tr>
              <tr>
                <td class="fw-semibold text-muted">Số điện thoại:</td>
                <td>
                  <i class="bi bi-telephone me-1"></i>${order.telephone}
                </td>
              </tr>
              <tr>
                <td class="fw-semibold text-muted">Ghi chú:</td>
                <td>
                  <c:choose>
                    <c:when test="${not empty order.description}">
                      ${order.description}
                    </c:when>
                    <c:otherwise>
                      <span class="text-muted fst-italic">Không có ghi chú</span>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </table>
          </div>
        </div>
        
        <div class="mt-3 p-3 bg-light rounded">
          <h6 class="fw-semibold mb-2">
            <i class="bi bi-geo-alt me-1"></i>Địa chỉ giao hàng:
          </h6>
          <p class="mb-0">${order.address}</p>
        </div>
      </div>
    </div>

    <!-- Chi tiết sản phẩm -->
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <h5 class="card-title mb-0">
          <i class="bi bi-box-seam text-primary me-2"></i>
          Sản phẩm đã đặt (${orderDetails.size()} sản phẩm)
        </h5>
      </div>
      <div class="card-body p-0">
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead class="table-light">
              <tr>
                <th width="15%" class="text-center">Hình ảnh</th>
                <th width="35%">Sản phẩm</th>
                <th width="15%" class="text-center">Đơn giá</th>
                <th width="10%" class="text-center">Số lượng</th>
                <th width="15%" class="text-center">Giảm giá</th>
                <th width="20%" class="text-center">Thành tiền</th>
              </tr>
            </thead>
            <tbody>
              <c:set var="totalAmount" value="0" />
              <c:forEach var="detail" items="${orderDetails}">
                <c:set var="itemTotal" value="${detail.unitPrice * detail.quantity * (1 - detail.discount / 100)}" />
                <c:set var="totalAmount" value="${totalAmount + itemTotal}" />
                <tr>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${not empty detail.product.image}">
                        <img src="/static/images/products/${detail.product.image}" 
                             alt="${detail.product.name}" 
                             class="img-thumbnail" 
                             style="width: 60px; height: 60px; object-fit: cover;">
                      </c:when>
                      <c:otherwise>
                        <div class="bg-light border rounded d-flex align-items-center justify-content-center" 
                             style="width: 60px; height: 60px;">
                          <i class="bi bi-image text-muted"></i>
                        </div>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div class="fw-semibold text-primary">${detail.product.name}</div>
                    <c:if test="${not empty detail.product.category}">
                      <small class="text-muted">
                        <i class="bi bi-tag me-1"></i>${detail.product.category.name}
                      </small>
                    </c:if>
                  </td>
                  <td class="text-center">
                    <fmt:formatNumber value="${detail.unitPrice}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                  </td>
                  <td class="text-center">
                    <span class="badge bg-info">${detail.quantity}</span>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${detail.discount > 0}">
                        <span class="text-danger fw-semibold">-${detail.discount}%</span>
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted">-</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <div class="fw-bold text-success">
                      <fmt:formatNumber value="${itemTotal}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
            <tfoot class="table-light">
              <tr>
                <td colspan="5" class="text-end fw-bold">Tổng cộng:</td>
                <td class="text-center">
                  <div class="fs-5 fw-bold text-success">
                    <fmt:formatNumber value="${order.amount}" type="currency" currencySymbol="₫" groupingUsed="true"/>
                  </div>
                </td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Thông tin khách hàng & Actions -->
  <div class="col-lg-4">
    <!-- Thông tin khách hàng -->
    <div class="card shadow-sm mb-4">
      <div class="card-header bg-light">
        <h5 class="card-title mb-0">
          <i class="bi bi-person text-primary me-2"></i>
          Thông tin khách hàng
        </h5>
      </div>
      <div class="card-body">
        <div class="text-center mb-3">
          <img src="/static/images/customers/${order.user.photo}" 
               alt="${order.user.fullname}" 
               class="rounded-circle mb-2"
               style="width: 80px; height: 80px; object-fit: cover;"
               onerror="this.src='/static/images/customers/user.png'">
          <h6 class="fw-bold mb-1">${order.user.fullname}</h6>
          <small class="text-muted">ID: ${order.user.id}</small>
        </div>
        
        <table class="table table-borderless table-sm">
          <tr>
            <td class="fw-semibold text-muted">
              <i class="bi bi-envelope me-1"></i>Email:
            </td>
            <td>${order.user.email}</td>
          </tr>
          <tr>
            <td class="fw-semibold text-muted">
              <i class="bi bi-telephone me-1"></i>Phone:
            </td>
            <td>${order.user.telephone}</td>
          </tr>
          <tr>
            <td class="fw-semibold text-muted">
              <i class="bi bi-shield me-1"></i>Vai trò:
            </td>
            <td>
              <c:choose>
                <c:when test="${order.user.admin}">
                  <span class="badge bg-warning">Admin</span>
                </c:when>
                <c:otherwise>
                  <span class="badge bg-info">Khách hàng</span>
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
          <tr>
            <td class="fw-semibold text-muted">
              <i class="bi bi-activity me-1"></i>Trạng thái:
            </td>
            <td>
              <c:choose>
                <c:when test="${order.user.isBanned}">
                  <span class="badge bg-danger">Bị cấm</span>
                </c:when>
                <c:otherwise>
                  <span class="badge bg-success">Hoạt động</span>
                </c:otherwise>
              </c:choose>
            </td>
          </tr>
        </table>
      </div>
    </div>

    <!-- Thao tác với đơn hàng -->
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <h5 class="card-title mb-0">
          <i class="bi bi-gear text-primary me-2"></i>
          Thao tác
        </h5>
      </div>
      <div class="card-body">
        <c:choose>
          <c:when test="${order.status == null || order.status == 0}">
            <!-- Đơn hàng chờ xử lý -->
            <div class="d-grid gap-2">
              <button class="btn btn-success" 
                      onclick="changeStatus('${order.id}', 'process', 'Duyệt đơn hàng này')">
                <i class="bi bi-check-circle me-2"></i>Duyệt đơn hàng
              </button>
              <button class="btn btn-outline-danger" 
                      onclick="changeStatus('${order.id}', 'cancel', 'Hủy đơn hàng này')">
                <i class="bi bi-x-circle me-2"></i>Hủy đơn hàng
              </button>
            </div>
            <div class="alert alert-warning mt-3">
              <i class="bi bi-info-circle me-2"></i>
              <small>Đơn hàng đang chờ xác nhận. Bạn có thể duyệt hoặc hủy đơn hàng.</small>
            </div>
          </c:when>
          
          <c:when test="${order.status == 1}">
            <!-- Đơn hàng đang xử lý -->
            <div class="d-grid gap-2">
              <button class="btn btn-primary" 
                      onclick="changeStatus('${order.id}', 'ship', 'Chuyển đơn hàng sang giao hàng')">
                <i class="bi bi-truck me-2"></i>Chuyển giao hàng
              </button>
              <button class="btn btn-outline-danger" 
                      onclick="changeStatus('${order.id}', 'cancel', 'Hủy đơn hàng này')">
                <i class="bi bi-x-circle me-2"></i>Hủy đơn hàng
              </button>
            </div>
            <div class="alert alert-info mt-3">
              <i class="bi bi-gear me-2"></i>
              <small>Đơn hàng đang được xử lý. Bạn có thể chuyển sang giao hàng hoặc hủy.</small>
            </div>
          </c:when>
          
          <c:when test="${order.status == 2}">
            <!-- Đơn hàng đang giao -->
            <div class="d-grid gap-2">
              <button class="btn btn-success" 
                      onclick="changeStatus('${order.id}', 'complete', 'Hoàn thành đơn hàng này')">
                <i class="bi bi-check-circle me-2"></i>Hoàn thành
              </button>
            </div>
            <div class="alert alert-primary mt-3">
              <i class="bi bi-truck me-2"></i>
              <small>Đơn hàng đang được giao. Xác nhận hoàn thành khi khách hàng đã nhận hàng.</small>
            </div>
          </c:when>
          
          <c:when test="${order.status == 3}">
            <!-- Đơn hàng hoàn thành -->
            <div class="alert alert-success">
              <i class="bi bi-check-circle me-2"></i>
              <strong>Đơn hàng đã hoàn thành</strong><br>
              <small>Khách hàng đã nhận hàng thành công.</small>
            </div>
          </c:when>
          
          <c:when test="${order.status == -1}">
            <!-- Đơn hàng đã hủy -->
            <div class="alert alert-danger">
              <i class="bi bi-x-circle me-2"></i>
              <strong>Đơn hàng đã bị hủy</strong><br>
              <small>Đơn hàng này đã được hủy và không thể thay đổi.</small>
            </div>
          </c:when>
          
          <c:otherwise>
            <div class="alert alert-secondary">
              <i class="bi bi-question-circle me-2"></i>
              <small>Trạng thái đơn hàng không xác định.</small>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
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
    
    if (confirm('Bạn có chắc chắn muốn ' + actionName.toLowerCase() + '?')) {
      // Tạo form và submit
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = '/admin/order/' + action + '/' + orderId;
      document.body.appendChild(form);
      form.submit();
    }
  }

  // Auto-hide alerts
  document.addEventListener('DOMContentLoaded', function() {
    const autoHideAlerts = document.querySelectorAll('.auto-hide-alert');
    autoHideAlerts.forEach(function(alert) {
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
  @media print {
    .btn, .alert, nav {
      display: none !important;
    }
    .card {
      border: none !important;
      box-shadow: none !important;
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