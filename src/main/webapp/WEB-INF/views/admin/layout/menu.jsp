<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<!-- Sidebar Navigation -->
<div class="sidebar">
	<!-- Brand -->
	<div class="text-center py-3 border-bottom border-secondary">
		<h5 class="text-white fw-bold mb-0">
			<i class="bi bi-shop"></i> HappyShop Admin
		</h5>
	</div>
	
	<!-- User Info -->
	<div class="p-3 border-bottom border-secondary">
		<div class="d-flex align-items-center">
			<div class="bg-secondary rounded-circle p-2 me-3">
				<i class="bi bi-person-fill text-white"></i>
			</div>
			<div>
				<c:choose>
					<c:when test="${empty sessionScope.user}">
						<small class="text-light">Chưa đăng nhập</small>
					</c:when>
					<c:otherwise>
						<div class="text-white fw-semibold">${sessionScope.user.id}</div>
						<small class="text-light">Administrator</small>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	
	<!-- Navigation Menu -->
	<nav class="nav flex-column py-2">
		<c:choose>
			<c:when test="${empty sessionScope.user}">
				<a class="nav-link" href="/admin/login">
					<i class="bi bi-box-arrow-in-right me-2"></i>
					Đăng nhập
				</a>
			</c:when>
			<c:otherwise>
				<!-- Dashboard -->
				<a class="nav-link" href="/admin/home/index">
					<i class="bi bi-house-door me-2"></i>
					Dashboard
				</a>
				
				<!-- Category Management -->
				<a class="nav-link" href="/admin/category/index">
					<i class="bi bi-tags me-2"></i>
					Quản lý loại sản phẩm
				</a>
				
				<!-- Product Management -->
				<a class="nav-link" href="/admin/product/index">
					<i class="bi bi-box me-2"></i>
					Quản lý sản phẩm
				</a>
				
				<!-- Customer Management -->
				<a class="nav-link" href="/admin/user/index">
					<i class="bi bi-people me-2"></i>
					Quản lý người dùng
				</a>
				
				<!-- Order Management -->
				<a class="nav-link" href="/admin/order/index">
					<i class="bi bi-cart me-2"></i>
					Quản lý đơn hàng
				</a>
				
				<!-- Reports -->
				<div class="nav-item">
					<a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-target="#reportsSubmenu" aria-expanded="false">
						<i class="bi bi-bar-chart me-2"></i>
						Báo cáo thống kê
						<i class="bi bi-chevron-down ms-auto"></i>
					</a>
					<div class="collapse" id="reportsSubmenu">
						<div class="ps-4">
							<a class="nav-link py-2" href="/admin/inventory/index">
								<i class="bi bi-boxes me-2"></i>
								Tồn kho theo loại
							</a>
							<a class="nav-link py-2" href="/admin/revenue/category">
								<i class="bi bi-currency-dollar me-2"></i>
								Doanh thu theo loại
							</a>
							<a class="nav-link py-2" href="/admin/revenue/customer">
								<i class="bi bi-person-check me-2"></i>
								Doanh thu theo khách hàng
							</a>
							<a class="nav-link py-2" href="/admin/revenue/month">
								<i class="bi bi-calendar-month me-2"></i>
								Doanh thu theo tháng
							</a>
							<a class="nav-link py-2" href="/admin/revenue/quarter">
								<i class="bi bi-calendar3 me-2"></i>
								Doanh thu theo quý
							</a>
							<a class="nav-link py-2" href="/admin/revenue/year">
								<i class="bi bi-calendar-year me-2"></i>
								Doanh thu theo năm
							</a>
						</div>
					</div>
				</div>
				
				<hr class="border-secondary my-3">
				
				<!-- User Menu -->
				<a class="nav-link" href="/admin/profile">
					<i class="bi bi-person-gear me-2"></i>
					Thông tin cá nhân
				</a>
				
				<a class="nav-link" href="/admin/change">
					<i class="bi bi-key me-2"></i>
					Thay đổi mật khẩu
				</a>
				
				<a class="nav-link" href="/admin/logout">
					<i class="bi bi-box-arrow-right me-2"></i>
					Đăng xuất
				</a>
			</c:otherwise>
		</c:choose>
	</nav>
</div>

<script>
$(document).ready(function() {
	// Highlight active menu item
	var currentPath = window.location.pathname;
	$('.sidebar .nav-link').each(function() {
		if ($(this).attr('href') === currentPath) {
			$(this).addClass('active');
		}
	});
});
</script>



