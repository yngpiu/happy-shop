<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<!-- Page Header -->
<div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4">
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-speedometer2 me-2"></i>
      Dashboard - Trang điều khiển
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item active">Dashboard</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <span class="badge bg-success">Hoạt động bình thường</span>
    <small class="text-muted">Cập nhật: <span id="current-time"></span></small>
  </div>
</div>

<!-- Statistics Cards -->
<div class="row mb-4">
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-primary text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Tổng người dùng</h6>
            <h3 class="mb-0">${totalUsers}</h3>
            <small class="text-white">${activeUsers} hoạt động</small>
          </div>
          <div class="text-white">
            <i class="bi bi-people display-6"></i>
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
            <h6 class="card-title text-white mb-1">Tổng sản phẩm</h6>
            <h3 class="mb-0">${totalProducts}</h3>
            <small class="text-white">${activeProducts} đang bán</small>
          </div>
          <div class="text-white">
            <i class="bi bi-box-seam display-6"></i>
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
            <h6 class="card-title text-white mb-1">Tổng đơn hàng</h6>
            <h3 class="mb-0">${totalOrders}</h3>
            <small class="text-white">${completedOrders} hoàn thành</small>
          </div>
          <div class="text-white">
            <i class="bi bi-cart display-6"></i>
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
            <h6 class="card-title text-white mb-1">Tổng doanh thu</h6>
            <h3 class="mb-0">
              <f:formatNumber value="${totalRevenue / 1000000}" pattern="##.#"/>M VNĐ
            </h3>
            <small class="text-white">${completedOrders} đơn hoàn thành</small>
          </div>
          <div class="text-white">
            <i class="bi bi-currency-dollar display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Quick Actions -->
<div class="card shadow-sm mb-4">
  <div class="card-header bg-light">
    <h5 class="card-title mb-0">
      <i class="bi bi-lightning-charge text-primary me-2"></i>
      Thao tác nhanh
    </h5>
  </div>
  <div class="card-body">
    <div class="row">
      <div class="col-12 col-md-2 mb-2">
        <a href="/admin/user" class="btn btn-outline-primary w-100">
          <i class="bi bi-people me-2"></i>Quản lý Users
        </a>
      </div>
      <div class="col-12 col-md-2 mb-2">
        <a href="/admin/product/index" class="btn btn-outline-success w-100">
          <i class="bi bi-box-seam me-2"></i>Quản lý Sản phẩm
        </a>
      </div>
      <div class="col-12 col-md-2 mb-2">
        <a href="/admin/order" class="btn btn-outline-info w-100">
          <i class="bi bi-cart me-2"></i>Quản lý Đơn hàng
        </a>
      </div>
      <div class="col-12 col-md-2 mb-2">
        <a href="/admin/category" class="btn btn-outline-secondary w-100">
          <i class="bi bi-tags me-2"></i>Quản lý Danh mục
        </a>
      </div>
      <div class="col-12 col-md-2 mb-2">
        <a href="/admin/report" class="btn btn-outline-warning w-100">
          <i class="bi bi-graph-up me-2"></i>Báo cáo
        </a>
      </div>
      <div class="col-12 col-md-2 mb-2">
        <a href="/admin/profile" class="btn btn-outline-dark w-100">
          <i class="bi bi-gear me-2"></i>Cài đặt
        </a>
      </div>
    </div>
  </div>
</div>

<!-- Tables Row -->
<div class="row">
  <!-- Recent Orders Table -->
  <div class="col-12 col-xl-8 mb-4">
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <div class="d-flex justify-content-between align-items-center">
          <h5 class="card-title mb-0">
            <i class="bi bi-clock-history text-primary me-2"></i>
            Đơn hàng gần đây
          </h5>
          <div class="d-flex align-items-center gap-2">
            <span class="badge bg-primary">${recentOrders.size()} đơn hàng</span>
            <a href="/admin/order/index" class="btn btn-sm btn-outline-primary">
              <i class="bi bi-arrow-right"></i> Xem tất cả
            </a>
          </div>
        </div>
      </div>
      <div class="card-body p-0">
        <c:choose>
          <c:when test="${not empty recentOrders}">
            <div class="table-responsive">
              <table class="table table-hover mb-0">
                <thead class="table-light">
                  <tr>
                    <th>Mã đơn</th>
                    <th>Khách hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="order" items="${recentOrders}">
                    <tr>
                      <td>
                        <strong class="text-primary">#${order.id}</strong>
                      </td>
                      <td>
                        <div class="d-flex align-items-center">
                          <i class="bi bi-person-circle me-2 text-muted"></i>
                          ${order.user.fullname}
                        </div>
                      </td>
                      <td>
                        <f:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                      </td>
                      <td>
                        <strong class="text-success">
                          <f:formatNumber value="${order.amount}" pattern="#,### VNĐ"/>
                        </strong>
                      </td>
                      <td>
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
                      <td>
                        <a href="/admin/order/detail/${order.id}" class="btn btn-sm btn-outline-primary">
                          <i class="bi bi-eye"></i>
                        </a>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-center py-5">
              <i class="bi bi-inbox display-1 text-muted"></i>
              <h4 class="text-muted mt-3">Chưa có đơn hàng nào</h4>
              <p class="text-muted">Đơn hàng mới sẽ hiển thị tại đây</p>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>

  <!-- Low Stock Products Table -->
  <div class="col-12 col-xl-4 mb-4">
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <div class="d-flex justify-content-between align-items-center">
          <h5 class="card-title mb-0">
            <i class="bi bi-exclamation-triangle text-warning me-2"></i>
            Sản phẩm sắp hết hàng
          </h5>
          <div class="d-flex align-items-center gap-2">
            <span class="badge bg-warning">${lowStockProducts.size()} sản phẩm</span>
            <a href="/admin/product/index" class="btn btn-sm btn-outline-warning">
              <i class="bi bi-arrow-right"></i>
            </a>
          </div>
        </div>
      </div>
      <div class="card-body p-0">
        <c:choose>
          <c:when test="${not empty lowStockProducts}">
            <div class="table-responsive">
              <table class="table table-hover mb-0">
                <thead class="table-light">
                  <tr>
                    <th>Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Thao tác</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="product" items="${lowStockProducts}">
                    <tr>
                      <td>
                        <div class="d-flex align-items-center">
                          <img src="/static/images/products/${product.image}" 
                               class="rounded me-2" width="32" height="32" 
                               style="object-fit: cover;">
                          <div>
                            <div class="fw-bold small">${product.name}</div>
                            <small class="text-muted">${product.category.name}</small>
                          </div>
                        </div>
                      </td>
                      <td>
                        <span class="badge bg-danger">${product.quantity}</span>
                      </td>
                      <td>
                        <a href="/admin/product/edit/${product.id}" class="btn btn-sm btn-outline-warning">
                          <i class="bi bi-pencil"></i>
                        </a>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-center py-4">
              <i class="bi bi-check-circle display-4 text-success"></i>
              <h6 class="text-success mt-2">Tất cả sản phẩm đều có đủ hàng</h6>
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</div>

<script>
// Update current time
function updateTime() {
    const now = new Date();
    const timeString = now.toLocaleString('vi-VN', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
    });
    document.getElementById('current-time').textContent = timeString;
}

// Update time every second
updateTime();
setInterval(updateTime, 1000);
</script> 