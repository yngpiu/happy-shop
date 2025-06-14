<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<c:set var="cart" value="${sessionScope['scopedTarget.cartService']}" />

<!-- Modern Shopping Cart -->
<div class="container my-5">
	<div class="cart-section">
		<!-- Cart Header -->
		<div class="cart-header text-center mb-4">
			<h2 class="cart-title">
				<i class="bi bi-cart3 me-3"></i>
				Giỏ Hàng Của Bạn
			</h2>
			<p class="cart-subtitle text-muted">
				<c:choose>
					<c:when test="${cart.count > 0}">
						Bạn có <span class="fw-bold text-primary cart-cnt">${cart.count}</span> sản phẩm trong giỏ hàng
					</c:when>
					<c:otherwise>
						Giỏ hàng của bạn đang trống
					</c:otherwise>
				</c:choose>
			</p>
		</div>

		<div class="row">
			<!-- Cart Items -->
			<div class="col-lg-8">
				<div class="cart-items-container">
					<c:choose>
						<c:when test="${cart.count > 0}">
							<c:forEach var="p" items="${sessionScope['scopedTarget.cartService'].items}">
								<div class="cart-item" data-id="${p.id}" data-price="${p.unitPrice}" data-discount="${p.discount}">
									<div class="row align-items-center">
										<!-- Product Image -->
										<div class="col-md-3 col-sm-4">
											<div class="product-image-wrapper">
												<img src="/static/images/products/${p.image}" 
													 alt="${p.name}" 
													 class="product-image">
											</div>
										</div>
										
										<!-- Product Info -->
										<div class="col-md-4 col-sm-8">
											<div class="product-info">
												<h5 class="product-name">${p.name}</h5>
												<p class="product-sku text-muted">
													<i class="bi bi-tag me-1"></i>SKU: ${p.id}
												</p>
												
												<!-- Price -->
												<div class="price-info">
													<c:choose>
														<c:when test="${p.discount > 0}">
															<div class="price-with-discount">
																<span class="original-price">
																	<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
																</span>
																<span class="discount-badge">
																	-${p.discount}%
																</span>
																<div class="sale-price">
																	<f:formatNumber value="${p.unitPrice * (1 - p.discount / 100)}" pattern="#,###"/>đ
																</div>
															</div>
														</c:when>
														<c:otherwise>
															<div class="current-price">
																<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
															</div>
														</c:otherwise>
													</c:choose>
												</div>
											</div>
										</div>
										
										<!-- Quantity Controls -->
										<div class="col-md-3 col-sm-6">
											<div class="quantity-controls">
												<label class="form-label">Số lượng</label>
												<div class="quantity-input-group">
													<button class="btn-quantity btn-decrease" type="button">
														<i class="bi bi-dash"></i>
													</button>
													<input type="number" class="quantity-input" 
														   value="${p.quantity}" min="1" max="99">
													<button class="btn-quantity btn-increase" type="button">
														<i class="bi bi-plus"></i>
													</button>
												</div>
											</div>
										</div>
										
										<!-- Item Total & Remove -->
										<div class="col-md-2 col-sm-6">
											<div class="item-actions text-end">
												<div class="item-total amt">
													<f:formatNumber value="${p.quantity * p.unitPrice * (1 - p.discount / 100)}" pattern="#,###"/>đ
												</div>
												<button class="btn btn-remove btn-cart-remove" title="Xóa sản phẩm">
													<i class="bi bi-trash"></i>
												</button>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<!-- Empty Cart State -->
							<div class="empty-cart text-center py-5">
								<div class="empty-cart-icon">
									<i class="bi bi-cart-x"></i>
								</div>
								<h4 class="empty-cart-title">Giỏ hàng trống</h4>
								<p class="empty-cart-text text-muted">
									Bạn chưa có sản phẩm nào trong giỏ hàng.<br>
									Hãy khám phá các sản phẩm tuyệt vời của chúng tôi!
								</p>
								<a href="/" class="btn btn-primary btn-lg">
									<i class="bi bi-shop me-2"></i>Tiếp tục mua sắm
								</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			
			<!-- Cart Summary -->
			<div class="col-lg-4">
				<div class="cart-summary">
					<h4 class="summary-title">
						<i class="bi bi-receipt me-2"></i>Tóm tắt đơn hàng
					</h4>
					
					<div class="summary-content">
						<div class="summary-row">
							<span>Tạm tính:</span>
							<span class="subtotal">
								<c:choose>
									<c:when test="${cart.amount > 0}">
										<f:formatNumber value="${cart.amount}" pattern="#,###"/>đ
									</c:when>
									<c:otherwise>0đ</c:otherwise>
								</c:choose>
							</span>
						</div>
						
						<div class="summary-row">
							<span>Phí vận chuyển:</span>
							<span class="shipping-fee">
								<c:choose>
									<c:when test="${cart.amount >= 500000}">
										<span class="text-success">Miễn phí</span>
									</c:when>
									<c:otherwise>30,000đ</c:otherwise>
								</c:choose>
							</span>
						</div>
						
						<hr class="summary-divider">
						
						<div class="summary-row total-row">
							<span class="total-label">Tổng cộng:</span>
							<span class="total-amount">
								<c:choose>
									<c:when test="${cart.amount > 0}">
										<c:choose>
											<c:when test="${cart.amount >= 500000}">
												<f:formatNumber value="${cart.amount}" pattern="#,###"/>đ
											</c:when>
											<c:otherwise>
												<f:formatNumber value="${cart.amount + 30000}" pattern="#,###"/>đ
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>0đ</c:otherwise>
								</c:choose>
							</span>
						</div>
						
						<c:if test="${cart.amount < 500000 && cart.amount > 0}">
							<div class="shipping-notice">
								<i class="bi bi-info-circle me-2"></i>
								Mua thêm <strong><f:formatNumber value="${500000 - cart.amount}" pattern="#,###"/>đ</strong> 
								để được miễn phí vận chuyển
							</div>
						</c:if>
					</div>
					
					<!-- Action Buttons -->
					<div class="cart-actions">
						<c:if test="${cart.count > 0}">
							<button class="btn btn-outline-danger btn-clear btn-cart-clear">
								<i class="bi bi-trash me-2"></i>Xóa giỏ hàng
							</button>
						</c:if>
						
						<a href="/" class="btn btn-outline-primary btn-continue">
							<i class="bi bi-arrow-left me-2"></i>Tiếp tục mua sắm
						</a>
						
						<c:if test="${cart.count > 0}">
							<a href="/order/checkout" class="btn btn-success btn-checkout">
								<i class="bi bi-credit-card me-2"></i>Thanh toán
							</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<style>
/* Modern Cart Styling */
.cart-section {
	background: white;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0,0,0,0.1);
	padding: 2rem;
	margin: 2rem 0;
}

.cart-header {
	margin-bottom: 2rem;
}

.cart-title {
	font-size: 2.2rem;
	font-weight: 700;
	color: #2c3e50;
	margin-bottom: 0.5rem;
}

.cart-subtitle {
	font-size: 1.1rem;
}

/* Cart Items Container */
.cart-items-container {
	background: #f8f9fa;
	border-radius: 15px;
	padding: 1.5rem;
	margin-bottom: 2rem;
}

.cart-item {
	background: white;
	border-radius: 12px;
	padding: 1.5rem;
	margin-bottom: 1rem;
	box-shadow: 0 2px 10px rgba(0,0,0,0.05);
	transition: all 0.3s ease;
}

.cart-item:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}

.cart-item:last-child {
	margin-bottom: 0;
}

/* Product Image */
.product-image-wrapper {
	position: relative;
	border-radius: 10px;
	overflow: hidden;
	background: #f8f9fa;
}

.product-image {
	width: 100%;
	height: 120px;
	object-fit: contain;
	padding: 10px;
}

/* Product Info */
.product-info {
	padding-left: 1rem;
}

.product-name {
	font-size: 1.1rem;
	font-weight: 600;
	color: #2c3e50;
	margin-bottom: 0.5rem;
	line-height: 1.3;
}

.product-sku {
	font-size: 0.9rem;
	margin-bottom: 1rem;
}

/* Price Info */
.price-with-discount {
	display: flex;
	flex-direction: column;
	gap: 0.25rem;
}

.original-price {
	color: #999;
	text-decoration: line-through;
	font-size: 0.9rem;
}

.discount-badge {
	background: #dc3545;
	color: white;
	padding: 2px 6px;
	border-radius: 8px;
	font-size: 0.75rem;
	font-weight: 600;
	align-self: flex-start;
}

.sale-price, .current-price {
	color: #dc3545;
	font-weight: 700;
	font-size: 1.1rem;
}

/* Quantity Controls */
.quantity-controls {
	text-align: center;
}

.quantity-controls .form-label {
	font-size: 0.9rem;
	font-weight: 600;
	color: #6c757d;
	margin-bottom: 0.5rem;
}

.quantity-input-group {
	display: flex;
	align-items: center;
	justify-content: center;
	background: white;
	border: 2px solid #e9ecef;
	border-radius: 10px;
	overflow: hidden;
}

.btn-quantity {
	background: none;
	border: none;
	padding: 0.5rem;
	color: #6c757d;
	transition: all 0.2s ease;
	display: flex;
	align-items: center;
	justify-content: center;
}

.btn-quantity:hover {
	background: #f8f9fa;
	color: #007bff;
}

.quantity-input {
	border: none;
	text-align: center;
	width: 60px;
	padding: 0.5rem 0;
	font-weight: 600;
	background: transparent;
}

.quantity-input:focus {
	outline: none;
	background: #f8f9fa;
}

/* Item Actions */
.item-actions {
	display: flex;
	flex-direction: column;
	align-items: flex-end;
	gap: 1rem;
}

.item-total {
	font-size: 1.2rem;
	font-weight: 700;
	color: #2c3e50;
}

.btn-remove {
	background: #dc3545;
	color: white;
	border: none;
	border-radius: 8px;
	padding: 0.5rem;
	transition: all 0.3s ease;
}

.btn-remove:hover {
	background: #c82333;
	transform: scale(1.1);
}

/* Empty Cart */
.empty-cart {
	padding: 3rem 1rem;
}

.empty-cart-icon {
	font-size: 4rem;
	color: #dee2e6;
	margin-bottom: 1rem;
}

.empty-cart-title {
	color: #6c757d;
	margin-bottom: 1rem;
}

.empty-cart-text {
	font-size: 1.1rem;
	margin-bottom: 2rem;
}

/* Cart Summary */
.cart-summary {
	background: #2c3e50;
	color: white;
	border-radius: 15px;
	padding: 2rem;
	position: sticky;
	top: 2rem;
	border: 1px solid #34495e;
}

.summary-title {
	font-size: 1.3rem;
	font-weight: 600;
	margin-bottom: 1.5rem;
	text-align: center;
}

.summary-content {
	margin-bottom: 2rem;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1rem;
	font-size: 1rem;
}

.summary-divider {
	border-color: rgba(255,255,255,0.3);
	margin: 1.5rem 0;
}

.total-row {
	font-size: 1.2rem;
	font-weight: 700;
	padding-top: 0.5rem;
}

.shipping-notice {
	background: rgba(255,255,255,0.1);
	padding: 1rem;
	border-radius: 10px;
	font-size: 0.9rem;
	margin-top: 1rem;
	text-align: center;
}

/* Action Buttons */
.cart-actions {
	display: flex;
	flex-direction: column;
	gap: 0.75rem;
}

.cart-actions .btn {
	border-radius: 10px;
	padding: 0.75rem 1.5rem;
	font-weight: 600;
	transition: all 0.3s ease;
}

.btn-clear {
	background: transparent;
	border: 2px solid rgba(255,255,255,0.3);
	color: white;
}

.btn-clear:hover {
	background: rgba(255,255,255,0.1);
	border-color: rgba(255,255,255,0.5);
	color: white;
}

.btn-continue {
	background: transparent;
	border: 2px solid rgba(255,255,255,0.3);
	color: white;
}

.btn-continue:hover {
	background: rgba(255,255,255,0.1);
	border-color: rgba(255,255,255,0.5);
	color: white;
}

.btn-checkout {
	background: #28a745;
	border: 2px solid #28a745;
	color: white;
	font-size: 1.1rem;
}

.btn-checkout:hover {
	background: #218838;
	border-color: #218838;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
}

/* Responsive Design */
@media (max-width: 991.98px) {
	.cart-summary {
		position: static;
		margin-top: 2rem;
	}
	
	.item-actions {
		align-items: center;
		flex-direction: row;
		justify-content: space-between;
	}
}

@media (max-width: 767.98px) {
	.cart-section {
		padding: 1rem;
	}
	
	.cart-title {
		font-size: 1.8rem;
	}
	
	.cart-item {
		padding: 1rem;
	}
	
	.product-info {
		padding-left: 0;
		margin-top: 1rem;
	}
	
	.quantity-controls {
		margin-top: 1rem;
	}
	
	.item-actions {
		margin-top: 1rem;
		flex-direction: column;
		align-items: stretch;
	}
	
	.cart-actions .btn {
		font-size: 0.9rem;
	}
}

@media (max-width: 575.98px) {
	.cart-section {
		margin: 1rem 0;
		border-radius: 15px;
	}
	
	.quantity-input-group {
		max-width: 150px;
		margin: 0 auto;
	}
}

/* Loading and Animation States */
.cart-item.updating {
	opacity: 0.7;
	pointer-events: none;
}

.btn-quantity:active {
	transform: scale(0.95);
}

.quantity-input::-webkit-outer-spin-button,
.quantity-input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

.quantity-input[type=number] {
	-moz-appearance: textfield;
}
</style>

<script>
// Enhanced cart functionality
$(document).ready(function() {
	// Quantity controls
	$('.btn-increase').click(function() {
		var input = $(this).siblings('.quantity-input');
		var currentVal = parseInt(input.val());
		if (currentVal < 99) {
			input.val(currentVal + 1);
			updateCartItem($(this).closest('.cart-item'));
		}
	});
	
	$('.btn-decrease').click(function() {
		var input = $(this).siblings('.quantity-input');
		var currentVal = parseInt(input.val());
		if (currentVal > 1) {
			input.val(currentVal - 1);
			updateCartItem($(this).closest('.cart-item'));
		}
	});
	
	// Direct input change
	$('.quantity-input').change(function() {
		var val = parseInt($(this).val());
		if (val < 1) $(this).val(1);
		if (val > 99) $(this).val(99);
		updateCartItem($(this).closest('.cart-item'));
	});
	
	function updateCartItem(cartItem) {
		cartItem.addClass('updating');
		var id = cartItem.data('id');
		var quantity = cartItem.find('.quantity-input').val();
		
		// Simulate API call - replace with actual cart update logic
		setTimeout(function() {
			cartItem.removeClass('updating');
			// Update item total and cart summary here
		}, 500);
	}
});
</script>