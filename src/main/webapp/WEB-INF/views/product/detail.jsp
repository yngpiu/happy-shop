<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<c:set var="cart" value="${sessionScope['scopedTarget.cartService']}" />

<!-- Modern Product Detail Page -->
<div class="container my-5">
	<div class="product-detail-section">
		<!-- Product Main Info -->
		<div class="row">
			<!-- Product Image -->
			<div class="col-lg-5">
				<div class="product-image-container">
					<div class="main-image">
						<img src="/static/images/products/${prod.image}" 
							 alt="${prod.name}" 
							 class="product-main-image">
					</div>
					
					<!-- Discount Badge -->
					<c:if test="${prod.discount > 0}">
						<div class="discount-badge">
							-<f:formatNumber value="${prod.discount}" pattern="#"/>%
						</div>
					</c:if>
				</div>
			</div>
			
			<!-- Product Info -->
			<div class="col-lg-7">
				<div class="product-info">
					<h1 class="product-title">${prod.name}</h1>
					
					<div class="product-meta">
						<span class="brand">
							<i class="bi bi-tag me-2"></i>
							Thương hiệu: <strong>${prod.category.name}</strong>
						</span>
						<span class="sku">
							<i class="bi bi-hash me-2"></i>
							SKU: <strong>${prod.id}</strong>
						</span>
					</div>
					
					<!-- Price Section -->
					<div class="price-section">
						<c:choose>
							<c:when test="${prod.discount > 0}">
								<div class="price-with-discount">
									<span class="original-price">
										<f:formatNumber value="${prod.unitPrice}" pattern="#,###"/>đ
									</span>
									<span class="current-price">
										<f:formatNumber value="${prod.unitPrice * (1 - prod.discount / 100)}" pattern="#,###"/>đ
									</span>
								</div>
							</c:when>
							<c:otherwise>
								<span class="current-price">
									<f:formatNumber value="${prod.unitPrice}" pattern="#,###"/>đ
								</span>
							</c:otherwise>
						</c:choose>
					</div>
					
					<!-- Stock Status -->
					<div class="stock-status">
						<span class="status-badge ${prod.available ? 'in-stock' : 'out-of-stock'}">
							<i class="bi ${prod.available ? 'bi-check-circle' : 'bi-x-circle'} me-2"></i>
							${prod.available ? 'Còn hàng' : 'Hết hàng'}
						</span>
						<c:if test="${prod.available && prod.quantity != null}">
							<span class="stock-quantity">
								<i class="bi bi-box me-2"></i>
								Còn lại: <strong>${prod.quantity}</strong> sản phẩm
							</span>
						</c:if>
					</div>
					
					<!-- Action Buttons -->
					<div class="product-actions">
						<button class="btn btn-add-cart btn-add-to-cart" data-id="${prod.id}">
							<i class="bi bi-cart-plus me-2"></i>
							Thêm vào giỏ hàng
						</button>
						<button class="btn btn-wishlist btn-star" data-id="${prod.id}">
							<i class="bi bi-heart me-2"></i>
							Yêu thích
						</button>
					</div>
					
					<!-- Promotions -->
					<div class="promotions">
						<h6 class="promotion-title">
							<i class="bi bi-gift me-2"></i>
							Khuyến mãi đặc biệt
						</h6>
						<ul class="promotion-list">
							<li>
								<i class="bi bi-credit-card me-2"></i>
								Trả góp 0% + 0đ qua thẻ tín dụng
							</li>
							<li>
								<i class="bi bi-battery me-2"></i>
								Pin sạc dự phòng giảm 30% khi mua kèm
							</li>
							<li>
								<i class="bi bi-truck me-2"></i>
								Miễn phí giao hàng cho đơn từ 500K
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Product Description -->
		<div class="product-description">
			<h4 class="description-title">
				<i class="bi bi-info-circle me-2"></i>
				Mô tả sản phẩm
			</h4>
			<div class="description-content">
				${prod.description}
			</div>
		</div>
		
		<!-- Policies Sidebar -->
		<div class="policies-section">
			<div class="row">
				<div class="col-lg-6">
					<div class="policy-card">
						<h6 class="policy-title">
							<i class="bi bi-shield-check me-2"></i>
							Chính sách bán hàng
						</h6>
						<ul class="policy-list">
							<li>
								<i class="bi bi-check-circle me-2"></i>
								Cam kết hàng chính hãng
							</li>
							<li>
								<i class="bi bi-truck me-2"></i>
								Miễn phí giao hàng từ 500K
							</li>
							<li>
								<i class="bi bi-arrow-repeat me-2"></i>
								Đổi trả miễn phí trong 10 ngày
							</li>
						</ul>
					</div>
				</div>
				<div class="col-lg-6">
					<div class="policy-card">
						<h6 class="policy-title">
							<i class="bi bi-tools me-2"></i>
							Dịch vụ khác
						</h6>
						<ul class="policy-list">
							<li>
								<i class="bi bi-wrench me-2"></i>
								Sửa chữa điện thoại giá rẻ
							</li>
							<li>
								<i class="bi bi-arrow-left-right me-2"></i>
								Thu cũ đổi mới
							</li>
							<li>
								<i class="bi bi-house me-2"></i>
								Bảo hành tại nhà
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Related Products Section -->
<div class="container my-5">
	<div class="related-products-section">
		<!-- Tab Navigation -->
		<ul class="nav nav-pills nav-justified product-tabs" id="productTabs" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="same-category-tab" data-bs-toggle="pill" 
						data-bs-target="#same-category" type="button" role="tab">
					<i class="bi bi-grid me-2"></i>
					Sản phẩm cùng loại
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="favorites-tab" data-bs-toggle="pill" 
						data-bs-target="#favorites" type="button" role="tab">
					<i class="bi bi-heart me-2"></i>
					Sản phẩm yêu thích
				</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="viewed-tab" data-bs-toggle="pill" 
						data-bs-target="#viewed" type="button" role="tab">
					<i class="bi bi-eye me-2"></i>
					Sản phẩm đã xem
				</button>
			</li>
		</ul>
		
		<!-- Tab Content -->
		<div class="tab-content product-tab-content" id="productTabContent">
			<!-- Same Category Products -->
			<div class="tab-pane fade show active" id="same-category" role="tabpanel">
				<div class="row">
					<c:forEach var="p" items="${list}" begin="0" end="7">
						<div class="col-lg-3 col-md-4 col-sm-6 mb-4">
							<div class="product-card">
								<div class="product-image-wrapper">
									<a href="/product/detail/${p.id}">
										<img src="/static/images/products/${p.image}" 
											 alt="${p.name}" 
											 class="product-image">
									</a>
									
									<!-- Discount Badge -->
									<c:if test="${p.discount > 0}">
										<div class="discount-badge">
											-<f:formatNumber value="${p.discount}" pattern="#"/>%
										</div>
									</c:if>
									
									<!-- Quick Actions -->
									<div class="quick-actions">
										<button class="btn btn-sm btn-add-to-cart" data-id="${p.id}" title="Thêm vào giỏ">
											<i class="bi bi-cart-plus"></i>
										</button>
										<button class="btn btn-sm btn-star" data-id="${p.id}" title="Yêu thích">
											<i class="bi bi-heart"></i>
										</button>
									</div>
								</div>
								
								<div class="product-info">
									<h6 class="product-name">
										<a href="/product/detail/${p.id}">${p.name}</a>
									</h6>
									
									<div class="product-price">
										<c:choose>
											<c:when test="${p.discount > 0}">
												<span class="original-price">
													<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
												</span>
												<span class="current-price">
													<f:formatNumber value="${p.unitPrice * (1 - p.discount / 100)}" pattern="#,###"/>đ
												</span>
											</c:when>
											<c:otherwise>
												<span class="current-price">
													<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
												</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<!-- Favorite Products -->
			<div class="tab-pane fade" id="favorites" role="tabpanel">
				<div class="row">
					<c:forEach var="p" items="${favo}" begin="0" end="7">
						<div class="col-lg-3 col-md-4 col-sm-6 mb-4">
							<div class="product-card">
								<div class="product-image-wrapper">
									<a href="/product/detail/${p.id}">
										<img src="/static/images/products/${p.image}" 
											 alt="${p.name}" 
											 class="product-image">
									</a>
									
									<!-- Discount Badge -->
									<c:if test="${p.discount > 0}">
										<div class="discount-badge">
											-<f:formatNumber value="${p.discount}" pattern="#"/>%
										</div>
									</c:if>
									
									<!-- Quick Actions -->
									<div class="quick-actions">
										<button class="btn btn-sm btn-add-to-cart" data-id="${p.id}" title="Thêm vào giỏ">
											<i class="bi bi-cart-plus"></i>
										</button>
										<button class="btn btn-sm btn-star" data-id="${p.id}" title="Yêu thích">
											<i class="bi bi-heart"></i>
										</button>
									</div>
								</div>
								
								<div class="product-info">
									<h6 class="product-name">
										<a href="/product/detail/${p.id}">${p.name}</a>
									</h6>
									
									<div class="product-price">
										<c:choose>
											<c:when test="${p.discount > 0}">
												<span class="original-price">
													<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
												</span>
												<span class="current-price">
													<f:formatNumber value="${p.unitPrice * (1 - p.discount / 100)}" pattern="#,###"/>đ
												</span>
											</c:when>
											<c:otherwise>
												<span class="current-price">
													<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
												</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<!-- Viewed Products -->
			<div class="tab-pane fade" id="viewed" role="tabpanel">
				<div class="row">
					<c:forEach var="p" items="${viewed}" begin="0" end="7">
						<div class="col-lg-3 col-md-4 col-sm-6 mb-4">
							<div class="product-card">
								<div class="product-image-wrapper">
									<a href="/product/detail/${p.id}">
										<img src="/static/images/products/${p.image}" 
											 alt="${p.name}" 
											 class="product-image">
									</a>
									
									<!-- Discount Badge -->
									<c:if test="${p.discount > 0}">
										<div class="discount-badge">
											-<f:formatNumber value="${p.discount}" pattern="#"/>%
										</div>
									</c:if>
									
									<!-- Quick Actions -->
									<div class="quick-actions">
										<button class="btn btn-sm btn-add-to-cart" data-id="${p.id}" title="Thêm vào giỏ">
											<i class="bi bi-cart-plus"></i>
										</button>
										<button class="btn btn-sm btn-star" data-id="${p.id}" title="Yêu thích">
											<i class="bi bi-heart"></i>
										</button>
									</div>
								</div>
								
								<div class="product-info">
									<h6 class="product-name">
										<a href="/product/detail/${p.id}">${p.name}</a>
									</h6>
									
									<div class="product-price">
										<c:choose>
											<c:when test="${p.discount > 0}">
												<span class="original-price">
													<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
												</span>
												<span class="current-price">
													<f:formatNumber value="${p.unitPrice * (1 - p.discount / 100)}" pattern="#,###"/>đ
												</span>
											</c:when>
											<c:otherwise>
												<span class="current-price">
													<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
												</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="dialog_cart.jsp" />

<style>
/* Modern Product Detail Styling */
.product-detail-section {
	background: white;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0,0,0,0.08);
	padding: 2rem;
	margin-bottom: 2rem;
}

/* Product Image */
.product-image-container {
	position: relative;
	background: #f8f9fa;
	border-radius: 15px;
	padding: 2rem;
	text-align: center;
}

.product-main-image {
	width: 100%;
	max-width: 400px;
	height: auto;
	object-fit: contain;
	border-radius: 10px;
}

.discount-badge {
	position: absolute;
	top: 1rem;
	right: 1rem;
	background: #dc3545;
	color: white;
	padding: 0.5rem 1rem;
	border-radius: 20px;
	font-weight: 600;
	font-size: 0.9rem;
	box-shadow: 0 2px 8px rgba(220, 53, 69, 0.3);
}

/* Product Info */
.product-info {
	padding: 1rem 0;
}

.product-title {
	font-size: 2rem;
	font-weight: 700;
	color: #2c3e50;
	margin-bottom: 1rem;
	line-height: 1.3;
}

.product-meta {
	display: flex;
	gap: 2rem;
	margin-bottom: 1.5rem;
	flex-wrap: wrap;
}

.product-meta span {
	color: #6c757d;
	font-size: 0.95rem;
}

/* Price Section */
.price-section {
	margin-bottom: 1.5rem;
}

.price-with-discount .original-price {
	color: #999;
	text-decoration: line-through;
	font-size: 1.2rem;
	margin-right: 1rem;
}

.current-price {
	color: #dc3545;
	font-size: 2rem;
	font-weight: 700;
}

/* Stock Status */
.stock-status {
	margin-bottom: 2rem;
}

.status-badge {
	padding: 0.5rem 1rem;
	border-radius: 20px;
	font-weight: 600;
	font-size: 0.9rem;
}

.status-badge.in-stock {
	background: #d4edda;
	color: #155724;
}

.status-badge.out-of-stock {
	background: #f8d7da;
	color: #721c24;
}

.stock-quantity {
	display: block;
	margin-top: 0.5rem;
	color: #6c757d;
	font-size: 0.9rem;
}

/* Action Buttons */
.product-actions {
	display: flex;
	gap: 1rem;
	margin-bottom: 2rem;
	flex-wrap: wrap;
}

.btn-add-cart {
	background: #2c3e50;
	border: none;
	color: white;
	padding: 1rem 2rem;
	border-radius: 10px;
	font-weight: 600;
	font-size: 1.1rem;
	transition: all 0.3s ease;
	flex: 1;
	min-width: 200px;
}

.btn-add-cart:hover {
	background: #34495e;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(44, 62, 80, 0.3);
	color: white;
}

.btn-wishlist {
	background: transparent;
	border: 2px solid #dc3545;
	color: #dc3545;
	padding: 1rem 2rem;
	border-radius: 10px;
	font-weight: 600;
	transition: all 0.3s ease;
}

.btn-wishlist:hover {
	background: #dc3545;
	color: white;
	transform: translateY(-2px);
}

/* Promotions */
.promotions {
	background: #f8f9fa;
	padding: 1.5rem;
	border-radius: 10px;
	margin-bottom: 2rem;
}

.promotion-title {
	color: #2c3e50;
	font-weight: 600;
	margin-bottom: 1rem;
}

.promotion-list {
	list-style: none;
	padding: 0;
	margin: 0;
}

.promotion-list li {
	padding: 0.5rem 0;
	color: #6c757d;
	border-bottom: 1px solid #e9ecef;
}

.promotion-list li:last-child {
	border-bottom: none;
}

/* Product Description */
.product-description {
	background: #f8f9fa;
	padding: 2rem;
	border-radius: 15px;
	margin: 2rem 0;
}

.description-title {
	color: #2c3e50;
	font-weight: 600;
	margin-bottom: 1rem;
}

.description-content {
	color: #6c757d;
	line-height: 1.6;
}

/* Policies Section */
.policies-section {
	margin: 2rem 0;
}

.policy-card {
	background: white;
	border: 1px solid #e9ecef;
	border-radius: 10px;
	padding: 1.5rem;
	height: 100%;
}

.policy-title {
	color: #2c3e50;
	font-weight: 600;
	margin-bottom: 1rem;
}

.policy-list {
	list-style: none;
	padding: 0;
	margin: 0;
}

.policy-list li {
	padding: 0.5rem 0;
	color: #6c757d;
}

/* Related Products Section */
.related-products-section {
	background: white;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0,0,0,0.08);
	padding: 2rem;
}

/* Product Tabs */
.product-tabs {
	margin-bottom: 2rem;
	border-bottom: 1px solid #e9ecef;
}

.product-tabs .nav-link {
	background: transparent;
	border: none;
	color: #6c757d;
	font-weight: 600;
	padding: 1rem 1.5rem;
	border-radius: 10px 10px 0 0;
	transition: all 0.3s ease;
}

.product-tabs .nav-link:hover {
	background: #f8f9fa;
	color: #2c3e50;
}

.product-tabs .nav-link.active {
	background: #2c3e50;
	color: white;
}

.product-tab-content {
	padding-top: 2rem;
}

/* Product Cards in Tabs */
.product-card {
	background: white;
	border: 1px solid #e9ecef;
	border-radius: 15px;
	overflow: hidden;
	transition: all 0.3s ease;
	height: 100%;
}

.product-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.product-image-wrapper {
	position: relative;
	background: #f8f9fa;
	padding: 1rem;
	text-align: center;
}

.product-image {
	width: 100%;
	height: 200px;
	object-fit: contain;
	border-radius: 8px;
}

.product-card .discount-badge {
	top: 0.5rem;
	right: 0.5rem;
	font-size: 0.8rem;
	padding: 0.25rem 0.5rem;
}

.quick-actions {
	position: absolute;
	bottom: 0.5rem;
	right: 0.5rem;
	display: flex;
	gap: 0.5rem;
	opacity: 0;
	transition: all 0.3s ease;
}

.product-card:hover .quick-actions {
	opacity: 1;
}

.quick-actions .btn {
	width: 35px;
	height: 35px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	background: white;
	border: 1px solid #e9ecef;
	color: #6c757d;
	transition: all 0.3s ease;
}

.quick-actions .btn:hover {
	background: #2c3e50;
	color: white;
	border-color: #2c3e50;
}

.product-card .product-info {
	padding: 1rem;
}

.product-name {
	margin-bottom: 0.5rem;
	font-weight: 600;
}

.product-name a {
	color: #2c3e50;
	text-decoration: none;
	transition: color 0.3s ease;
}

.product-name a:hover {
	color: #dc3545;
}

.product-price .original-price {
	color: #999;
	text-decoration: line-through;
	font-size: 0.9rem;
	margin-right: 0.5rem;
}

.product-price .current-price {
	color: #dc3545;
	font-weight: 600;
	font-size: 1.1rem;
}

/* Responsive Design */
@media (max-width: 991.98px) {
	.product-title {
		font-size: 1.5rem;
	}
	
	.current-price {
		font-size: 1.5rem;
	}
	
	.product-actions {
		flex-direction: column;
	}
	
	.btn-add-cart,
	.btn-wishlist {
		min-width: auto;
	}
	
	.product-meta {
		flex-direction: column;
		gap: 0.5rem;
	}
}

@media (max-width: 767.98px) {
	.product-detail-section,
	.related-products-section {
		padding: 1rem;
		border-radius: 15px;
	}
	
	.product-image-container {
		padding: 1rem;
	}
	
	.product-title {
		font-size: 1.3rem;
	}
	
	.current-price {
		font-size: 1.3rem;
	}
	
	.product-tabs .nav-link {
		padding: 0.75rem 1rem;
		font-size: 0.9rem;
	}
}

@media (max-width: 575.98px) {
	.container {
		padding-left: 1rem;
		padding-right: 1rem;
	}
	
	.product-image {
		height: 150px;
	}
	
	.quick-actions .btn {
		width: 30px;
		height: 30px;
	}
}
</style>

<script>
$(document).ready(function() {
	// Initialize Bootstrap 5 tabs
	var triggerTabList = [].slice.call(document.querySelectorAll('#productTabs button'));
	triggerTabList.forEach(function (triggerEl) {
		var tabTrigger = new bootstrap.Tab(triggerEl);
		
		triggerEl.addEventListener('click', function (event) {
			event.preventDefault();
			tabTrigger.show();
		});
	});
	
	// Product card animations
	$('.product-card').each(function(index) {
		$(this).css('animation-delay', (index * 0.1) + 's');
		$(this).addClass('fade-in');
	});
});
</script>

<style>
@keyframes fade-in {
	from {
		opacity: 0;
		transform: translateY(20px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}

.fade-in {
	animation: fade-in 0.6s ease forwards;
}
</style>