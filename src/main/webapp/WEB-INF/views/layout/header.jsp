<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<c:set var="cart" value="${sessionScope['scopedTarget.cartService']}" />

<!-- Modern Header with Bootstrap 5 -->
<header class="header-modern">
	<!-- Top Bar -->
	<div class="top-bar bg-dark text-white py-2 d-none d-md-block">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6">
					<small>
						<i class="bi bi-telephone me-2"></i>Hotline: 0987.654.321
						<span class="mx-3">|</span>
						<i class="bi bi-envelope me-2"></i>support@happyshop.vn
					</small>
				</div>
				<div class="col-md-6 text-end">
					<small>Miễn phí vận chuyển cho đơn hàng từ 500.000đ</small>
				</div>
			</div>
		</div>
	</div>

	<!-- Main Header -->
	<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
		<div class="container">
			<!-- Logo -->
			<a class="navbar-brand me-4" href="/">
				<img src="/static/images/logo1.png" alt="HappyShop" height="50" class="d-inline-block align-text-top">
			</a>

			<!-- Mobile Toggle -->
			<button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
				<span class="navbar-toggler-icon"></span>
			</button>

			<!-- Search Bar -->
			<div class="search-container flex-grow-1 mx-4 d-none d-lg-block">
				<form action="/product/list-by-keywords" method="post" class="position-relative">
					<div class="input-group">
						<input type="text" class="form-control form-control-lg border-end-0" 
							   name="keywords" value="${param.keywords}" 
							   placeholder="Tìm kiếm sản phẩm..." 
							   style="border-radius: 25px 0 0 25px;">
						<button class="btn btn-primary px-4" type="submit" 
								style="border-radius: 0 25px 25px 0;">
							<i class="bi bi-search"></i>
						</button>
					</div>
				</form>
			</div>

			<!-- Header Actions -->
			<div class="header-actions d-flex align-items-center">
				<!-- Wishlist -->
				<a href="/product/favo" class="btn btn-outline-danger me-3 position-relative">
					<i class="fa-solid fa-heart"></i>
					<span class="d-none d-md-inline ms-2">Yêu thích</span>
				</a>

				<!-- Cart -->
				<div class="dropdown">
					<button class="btn btn-primary position-relative" type="button" data-bs-toggle="dropdown">
						<i class="fa-solid fa-cart-shopping"></i>
						<span class="d-none d-md-inline ms-2">Giỏ hàng</span>
						<c:if test="${cart.count > 0}">
							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
								${cart.count}
							</span>
						</c:if>
					</button>
					
					<!-- Cart Dropdown -->
					<div class="dropdown-menu dropdown-menu-end cart-dropdown p-0" style="width: 350px;">
						<div class="dropdown-header bg-light">
							<h6 class="mb-0">Giỏ hàng của bạn</h6>
						</div>
						
						<div class="cart-items" style="max-height: 300px; overflow-y: auto;">
							<c:choose>
								<c:when test="${cart.count > 0}">
									<c:forEach var="item" items="${cart.items}">
										<div class="cart-item p-3 border-bottom">
											<div class="row g-2 align-items-center">
												<div class="col-3">
													<img src="/static/images/products/${item.image}" 
														 class="img-fluid rounded" alt="${item.name}">
												</div>
												<div class="col-9">
													<h6 class="mb-1 text-truncate">${item.name}</h6>
													<div class="text-primary fw-bold">
														<f:formatNumber value="${item.unitPrice * (1 - item.discount)}" pattern="#,###" />đ
													</div>
													<small class="text-muted">Số lượng: ${item.quantity}</small>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="text-center py-4">
										<i class="bi bi-cart-x fs-1 text-muted"></i>
										<p class="text-muted mt-2">Giỏ hàng trống</p>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
						
						<c:if test="${cart.count > 0}">
							<div class="dropdown-footer p-3 bg-light">
								<div class="d-flex justify-content-between mb-2">
									<strong>Tổng cộng:</strong>
									<strong class="text-primary">
										<f:formatNumber value="${cart.amount}" pattern="#,###" />đ
									</strong>
								</div>
								<a href="/cart/view" class="btn btn-primary w-100">Xem giỏ hàng</a>
							</div>
						</c:if>
					</div>
				</div>
			</div>

			<!-- Mobile Search (Collapsible) -->
			<div class="collapse navbar-collapse mt-3" id="navbarMain">
				<div class="d-lg-none w-100">
					<form action="/product/list-by-keywords" method="post">
						<div class="input-group">
							<input type="text" class="form-control" name="keywords" 
								   value="${param.keywords}" placeholder="Tìm kiếm sản phẩm...">
							<button class="btn btn-primary" type="submit">
								<i class="bi bi-search"></i>
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</nav>
</header>

<style>
/* Modern Header Styles */
.header-modern {
	position: relative;
	z-index: 1000;
}

.top-bar {
	font-size: 0.875rem;
}

.search-container .form-control:focus {
	border-color: #0d6efd;
	box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
}

.header-actions .btn {
	border-radius: 25px;
	padding: 0.5rem 1rem;
	transition: all 0.3s ease;
}

.header-actions .btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.cart-dropdown {
	border: none;
	box-shadow: 0 10px 30px rgba(0,0,0,0.15);
	border-radius: 15px;
	overflow: hidden;
}

.cart-item:hover {
	background-color: #f8f9fa;
}

.cart-item img {
	width: 100%;
	height: 60px;
	object-fit: cover;
}

/* Responsive adjustments */
@media (max-width: 991.98px) {
	.navbar-brand img {
		height: 40px;
	}
	
	.header-actions .btn {
		padding: 0.4rem 0.8rem;
		font-size: 0.9rem;
	}
}

@media (max-width: 767.98px) {
	.header-actions .btn span {
		display: none !important;
	}
	
	.cart-dropdown {
		width: 300px !important;
	}
}
</style>

