<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<style>
.dashboard-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 2rem 0;
    margin-bottom: 2rem;
    border-radius: 10px;
}

.stats-card {
    background: white;
    border-radius: 15px;
    padding: 1.5rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
    border-left: 4px solid;
    margin-bottom: 1.5rem;
}

.stats-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 15px rgba(0, 0, 0, 0.15);
}

.stats-card.users { border-left-color: #4e73df; }
.stats-card.products { border-left-color: #1cc88a; }
.stats-card.orders { border-left-color: #36b9cc; }
.stats-card.revenue { border-left-color: #f6c23e; }

.stats-number {
    font-size: 2rem;
    font-weight: bold;
    margin-bottom: 0.5rem;
}

.stats-label {
    color: #858796;
    font-size: 0.9rem;
    text-transform: uppercase;
    font-weight: 600;
    letter-spacing: 0.5px;
}

.stats-icon {
    font-size: 2.5rem;
    opacity: 0.8;
}

.table-card {
    background: white;
    border-radius: 15px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    margin-bottom: 2rem;
}

.table-header {
    background: #f8f9fc;
    padding: 1.5rem;
    border-radius: 15px 15px 0 0;
    border-bottom: 1px solid #e3e6f0;
}

.table-title {
    font-size: 1.1rem;
    font-weight: 700;
    color: #5a5c69;
    margin: 0;
}

.status-badge {
    padding: 0.25rem 0.5rem;
    border-radius: 50px;
    font-size: 0.75rem;
    font-weight: 600;
}

.status-pending { background-color: #ffeaa7; color: #fdcb6e; }
.status-completed { background-color: #00b894; color: white; }
.status-cancelled { background-color: #e17055; color: white; }

.stock-low { color: #e74a3b; font-weight: bold; }
.stock-medium { color: #f39c12; font-weight: bold; }
.stock-good { color: #27ae60; font-weight: bold; }

.btn-view {
    padding: 0.25rem 0.75rem;
    font-size: 0.8rem;
    border-radius: 15px;
}
</style>

<!-- Dashboard Header -->
<div class="dashboard-header text-center">
    <h1 class="mb-2">Dashboard - Trang điều khiển</h1>
    <p class="mb-0">Tổng quan hệ thống quản lý HappyShop</p>
    <small>Cập nhật: <span id="current-time"></span> 
        <span class="badge bg-success ms-2">Hoạt động bình thường</span>
    </small>
</div>

<!-- Statistics Cards -->
<div class="row">
    <!-- Users Card -->
    <div class="col-xl-3 col-md-6">
        <div class="stats-card users">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="stats-label">Tổng người dùng</div>
                    <div class="stats-number text-primary">${totalUsers}</div>
                    <small class="text-muted">${activeUsers} hoạt động</small>
                </div>
                <div class="stats-icon text-primary">
                    <i class="fas fa-users"></i>
                </div>
            </div>
            <div class="mt-3">
                <a href="/admin/user" class="btn btn-primary btn-sm btn-view">
                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                </a>
            </div>
        </div>
    </div>

    <!-- Products Card -->
    <div class="col-xl-3 col-md-6">
        <div class="stats-card products">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="stats-label">Tổng sản phẩm</div>
                    <div class="stats-number text-success">${totalProducts}</div>
                    <small class="text-muted">${activeProducts} đang bán</small>
                </div>
                <div class="stats-icon text-success">
                    <i class="fas fa-box"></i>
                </div>
            </div>
            <div class="mt-3">
                <a href="/admin/product" class="btn btn-success btn-sm btn-view">
                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                </a>
            </div>
        </div>
    </div>

    <!-- Orders Card -->
    <div class="col-xl-3 col-md-6">
        <div class="stats-card orders">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="stats-label">Tổng đơn hàng</div>
                    <div class="stats-number text-info">${totalOrders}</div>
                    <small class="text-muted">${completedOrders} hoàn thành</small>
                </div>
                <div class="stats-icon text-info">
                    <i class="fas fa-shopping-cart"></i>
                </div>
            </div>
            <div class="mt-3">
                <a href="/admin/order" class="btn btn-info btn-sm btn-view">
                    <i class="fas fa-eye me-1"></i>Xem chi tiết
                </a>
            </div>
        </div>
    </div>

    <!-- Revenue Card -->
    <div class="col-xl-3 col-md-6">
        <div class="stats-card revenue">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <div class="stats-label">Tổng doanh thu</div>
                    <div class="stats-number text-warning">
                        <f:formatNumber value="${totalRevenue}" pattern="#,### VNĐ"/>
                    </div>
                    <small class="text-muted">${completedOrders} đơn hoàn thành</small>
                </div>
                <div class="stats-icon text-warning">
                    <i class="fas fa-dollar-sign"></i>
                </div>
            </div>
            <div class="mt-3">
                <a href="/admin/report" class="btn btn-warning btn-sm btn-view">
                    <i class="fas fa-chart-line me-1"></i>Xem báo cáo
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Tables Row -->
<div class="row">
    <!-- Recent Orders Table -->
    <div class="col-xl-8">
        <div class="table-card">
            <div class="table-header">
                <h5 class="table-title">
                    <i class="fas fa-clock me-2 text-primary"></i>
                    Đơn hàng gần đây
                </h5>
            </div>
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="bg-light">
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
                                <td>${order.user.fullname}</td>
                                <td>
                                    <f:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>
                                    <strong>
                                        <f:formatNumber value="${order.amount}" pattern="#,### VNĐ"/>
                                    </strong>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status eq 'Chờ xử lý'}">
                                            <span class="status-badge status-pending">Chờ xử lý</span>
                                        </c:when>
                                        <c:when test="${order.status eq 'Hoàn thành'}">
                                            <span class="status-badge status-completed">Hoàn thành</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-cancelled">${order.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="/admin/order/detail/${order.id}" class="btn btn-outline-primary btn-sm">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty recentOrders}">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-3">
                                    <i class="fas fa-inbox fa-2x mb-2"></i>
                                    <br>Chưa có đơn hàng nào
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Low Stock Products Table -->
    <div class="col-xl-4">
        <div class="table-card">
            <div class="table-header">
                <h5 class="table-title">
                    <i class="fas fa-exclamation-triangle me-2 text-warning"></i>
                    Sản phẩm sắp hết hàng
                </h5>
            </div>
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="bg-light">
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
                                             class="rounded me-2" width="30" height="30" 
                                             style="object-fit: cover;">
                                        <div>
                                            <div class="fw-bold">${product.name}</div>
                                            <small class="text-muted">${product.category.name}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${product.quantity <= 3}">
                                            <span class="stock-low">${product.quantity}</span>
                                        </c:when>
                                        <c:when test="${product.quantity <= 6}">
                                            <span class="stock-medium">${product.quantity}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="stock-good">${product.quantity}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="/admin/product/edit/${product.id}" class="btn btn-outline-warning btn-sm">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty lowStockProducts}">
                            <tr>
                                <td colspan="3" class="text-center text-muted py-3">
                                    <i class="fas fa-check-circle fa-2x mb-2 text-success"></i>
                                    <br>Tất cả sản phẩm đều có đủ hàng
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
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