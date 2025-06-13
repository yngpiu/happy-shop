<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<!-- Special Products Section -->
<div class="row g-3">
	<c:forEach var="p" items="${list}" begin="0" end="7">
		<div class="col-xl-3 col-lg-4 col-md-6 col-sm-6">
			<div class="simple-product-card h-100">
				<!-- Special Badge -->
				<div class="special-badge">
					<i class="bi bi-star-fill"></i>
					ĐẶC BIỆT
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
								-<f:formatNumber value="${p.discount * 100}" pattern="#"/>%
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
								<f:formatNumber value="${p.unitPrice * (1 - p.discount)}" pattern="#,###"/>đ
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
						<button class="btn btn-heart btn-wishlist" data-id="${p.id}">
							Yêu thích
						</button>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</div>

<style>
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

/* Special Badge */
.special-badge {
  position: absolute;
  top: 10px;
  left: 10px;
  background: #ff6b6b;
  color: white;
  padding: 4px 8px;
  border-radius: 12px;
  font-size: 0.7rem;
  font-weight: 600;
  z-index: 10;
  box-shadow: 0 2px 8px rgba(255, 107, 107, 0.3);
}

.special-badge i {
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

