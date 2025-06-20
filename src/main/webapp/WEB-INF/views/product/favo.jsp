<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<!-- Page Header -->
<div class="container my-5">
	<div class="products-section">
		<div class="section-header text-center mb-4">
			<h3 class="section-title">
				<i class="bi bi-heart-fill text-danger me-2"></i>
				SẢN PHẨM ĐÃ THÍCH
			</h3>
			<p class="section-subtitle text-muted">
				Những sản phẩm bạn đã yêu thích và lưu lại
			</p>
		</div>
		
		<!-- Products Grid -->
		<div class="products-container">
			<c:choose>
				<c:when test="${empty favo}">
					<!-- Empty State -->
					<div class="text-center py-5">
						<i class="bi bi-heart display-1 text-muted mb-4"></i>
						<h4 class="text-muted">Chưa có sản phẩm yêu thích nào</h4>
						<p class="text-muted mb-4">Hãy thêm sản phẩm vào danh sách yêu thích để xem tại đây</p>
						<a href="/" class="btn btn-primary">
							<i class="bi bi-house me-2"></i>Về trang chủ
						</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="row g-3">
						<c:forEach var="p" items="${favo}">
							<div class="col-xl-3 col-lg-4 col-md-6 col-sm-6">
								<div class="simple-product-card h-100">
									<!-- Favorite Badge -->
									<div class="favorite-badge">
										<i class="bi bi-heart-fill"></i>
										YÊU THÍCH
									</div>
										
									<!-- Product Image -->
									<div class="product-image-container">
										<a href="/product/detail/${p.id}">
											<img src="/static/images/products/${p.image}" 
												 alt="${p.name}" 
												 class="product-image">
										</a>
										
										<!-- Discount Badge -->
										<c:if test="${p.discount > 0}">
											<div class="discount-badge">
												<c:choose>
													<c:when test="${p.discount < 1}">
														-<f:formatNumber value="${p.discount * 100}" pattern="#"/>%
													</c:when>
													<c:otherwise>
														-<f:formatNumber value="${p.discount}" pattern="#"/>%
													</c:otherwise>
												</c:choose>
											</div>
										</c:if>
									</div>
									
									<!-- Product Info -->
									<div class="product-info">
										<!-- Product Name -->
										<h6 class="product-name">
											<a href="/product/detail/${p.id}">${p.name}</a>
										</h6>
										
										<!-- Price -->
										<div class="price-section">
											<c:choose>
												<c:when test="${p.discount > 0}">
													<span class="original-price">
														<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
													</span>
													<span class="sale-price">
														<c:choose>
															<c:when test="${p.discount < 1}">
																<f:formatNumber value="${p.unitPrice * (1 - p.discount)}" pattern="#,###"/>đ
															</c:when>
															<c:otherwise>
																<f:formatNumber value="${p.unitPrice * (1 - p.discount/100)}" pattern="#,###"/>đ
															</c:otherwise>
														</c:choose>
													</span>
												</c:when>
												<c:otherwise>
													<span class="current-price">
														<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
													</span>
												</c:otherwise>
											</c:choose>
										</div>
										
										<!-- Action Buttons -->
										<div class="action-buttons">
											<c:choose>
												<c:when test="${p.available && p.quantity > 0}">
													<button class="btn btn-cart btn-add-to-cart" data-id="${p.id}">
														<i class="bi bi-cart-plus me-1"></i>Thêm vào giỏ
													</button>
												</c:when>
												<c:otherwise>
													<button class="btn btn-cart" disabled>
														<i class="bi bi-x-circle me-1"></i>Hết hàng
													</button>
												</c:otherwise>
											</c:choose>
											<button class="btn btn-heart btn-wishlist wishlist-active" data-id="${p.id}">
												<i class="bi bi-heart-fill me-1"></i>Đã thích
											</button>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<style>
/* Unified Products Section Styling */
.products-section {
  padding: 2rem 0;
  background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
  border-radius: 15px;
  margin: 2rem 0;
}

.section-header {
  position: relative;
}

.section-title {
  font-size: 1.8rem;
  font-weight: 700;
  color: #2c3e50;
  margin-bottom: 0.5rem;
}

.section-subtitle {
  font-size: 1rem;
  max-width: 500px;
  margin: 0 auto;
}

.products-container {
  padding: 0 1rem;
}

/* Simple Product Card - Unified Design */
.simple-product-card {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(0,0,0,0.08);
  transition: all 0.3s ease;
  border: 1px solid #f0f0f0;
  position: relative;
}

.simple-product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 25px rgba(0,0,0,0.12);
}

/* Favorite Badge */
.favorite-badge {
  position: absolute;
  top: 10px;
  left: 10px;
  background: #dc3545;
  color: white;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.7rem;
  font-weight: 600;
  z-index: 10;
  box-shadow: 0 2px 8px rgba(220, 53, 69, 0.3);
}

.favorite-badge i {
  margin-right: 2px;
  font-size: 0.6rem;
}

/* Product Image */
.product-image-container {
  position: relative;
  height: 200px;
  background: #f8f9fa;
  overflow: hidden;
}

.product-image {
  width: 100%;
  height: 100%;
  object-fit: contain;
  padding: 15px;
  transition: transform 0.3s ease;
}

.simple-product-card:hover .product-image {
  transform: scale(1.05);
}

/* Discount Badge */
.discount-badge {
  position: absolute;
  top: 10px;
  right: 10px;
  background: #dc3545;
  color: white;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: 600;
  box-shadow: 0 2px 8px rgba(220, 53, 69, 0.3);
}

/* Product Info */
.product-info {
  padding: 15px;
}

.product-name {
  margin-bottom: 10px;
  line-height: 1.3;
  height: 2.6em;
  overflow: hidden;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.product-name a {
  color: #2c3e50;
  text-decoration: none;
  font-weight: 600;
  font-size: 0.9rem;
}

.product-name a:hover {
  color: #007bff;
}

/* Price */
.price-section {
  margin-bottom: 15px;
  text-align: center;
}

.original-price {
  color: #999;
  text-decoration: line-through;
  font-size: 0.85rem;
  display: block;
  margin-bottom: 2px;
}

.sale-price {
  color: #dc3545;
  font-weight: 700;
  font-size: 1.1rem;
}

.current-price {
  color: #dc3545;
  font-weight: 700;
  font-size: 1.1rem;
}

/* Action Buttons */
.action-buttons {
  display: flex;
  gap: 8px;
}

.btn {
  border: none;
  border-radius: 8px;
  padding: 8px 12px;
  font-size: 0.85rem;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 500;
}

.btn-cart {
  flex: 2;
  background: #007bff;
  color: white;
}

.btn-cart:hover:not(:disabled) {
  background: #0056b3;
  color: white;
  transform: translateY(-1px);
}

.btn-cart:disabled {
  background: #6c757d;
  color: white;
  cursor: not-allowed;
}

.btn-heart {
  flex: 1;
  background: #f8f9fa;
  color: #6c757d;
  border: 1px solid #dee2e6;
}

.btn-heart:hover {
  background: #dc3545;
  color: white;
  border-color: #dc3545;
}

.btn-heart.wishlist-active {
  background: #dc3545;
  color: white;
  border-color: #dc3545;
}

.btn-heart.wishlist-active i {
  animation: heartbeat 0.6s ease-in-out;
}

@keyframes heartbeat {
  0% { transform: scale(1); }
  50% { transform: scale(1.2); }
  100% { transform: scale(1); }
}

/* Responsive */
@media (max-width: 767.98px) {
  .products-section {
    padding: 1.5rem 1rem;
  }
  
  .section-title {
    font-size: 1.5rem;
  }
  
  .products-container {
    padding: 0 0.5rem;
  }
  
  .product-image-container {
    height: 180px;
  }
  
  .product-info {
    padding: 12px;
  }
  
  .action-buttons {
    flex-direction: column;
  }
  
  .btn-cart,
  .btn-heart {
    flex: 1;
  }
}

@media (max-width: 575.98px) {
  .products-section {
    margin: 1rem 0;
  }
}

/* Loading state */
.simple-product-card.loading {
  opacity: 0.7;
  pointer-events: none;
}

/* Success animation */
.btn-cart.success {
  background: #28a745 !important;
  animation: successPulse 0.6s ease;
}

@keyframes successPulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.05); }
  100% { transform: scale(1); }
}
</style>