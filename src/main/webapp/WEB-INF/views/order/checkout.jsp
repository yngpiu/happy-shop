<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<c:set var="cart" value="${sessionScope['scopedTarget.cartService']}" />

<!-- Modern Checkout Page -->
<div class="container my-5">
	<div class="checkout-section">
		<!-- Page Header -->
		<div class="checkout-header text-center mb-4">
			<h2 class="checkout-title">
				<i class="bi bi-credit-card me-3"></i>
				Thanh Toán Đơn Hàng
			</h2>
			<p class="checkout-subtitle text-muted">
				Vui lòng kiểm tra thông tin và hoàn tất đơn hàng của bạn
			</p>
		</div>

		<div class="row">
			<!-- Order Summary -->
			<div class="col-lg-7">
				<div class="order-summary-card">
					<div class="card-header">
						<h4 class="mb-0">
							<i class="bi bi-list-check me-2"></i>
							Chi Tiết Đơn Hàng
						</h4>
					</div>
					
					<div class="order-items">
						<c:forEach var="p" items="${sessionScope['scopedTarget.cartService'].items}">
							<div class="order-item">
								<div class="row align-items-center">
									<div class="col-md-2 col-sm-3">
										<div class="item-image">
											<img src="/static/images/products/${p.image}" 
												 alt="${p.name}" class="img-fluid">
										</div>
									</div>
									<div class="col-md-4 col-sm-9">
										<div class="item-info">
											<h6 class="item-name">${p.name}</h6>
											<p class="item-sku text-muted">SKU: ${p.id}</p>
										</div>
									</div>
									<div class="col-md-2 col-sm-4">
										<div class="item-price">
											<c:choose>
												<c:when test="${p.discount > 0}">
													<div class="original-price">
														<f:formatNumber value="${p.unitPrice}" pattern="#,###"/>đ
													</div>
													<div class="sale-price">
														<f:formatNumber value="${p.unitPrice * (1 - p.discount / 100)}" pattern="#,###"/>đ
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
									<div class="col-md-2 col-sm-4">
										<div class="item-quantity text-center">
											<span class="quantity-label">SL:</span>
											<span class="quantity-value">${p.quantity}</span>
										</div>
									</div>
									<div class="col-md-2 col-sm-4">
										<div class="item-total text-end">
											<strong>
												<f:formatNumber value="${p.quantity * p.unitPrice * (1 - p.discount / 100)}" pattern="#,###"/>đ
											</strong>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					
					<!-- Order Total -->
					<div class="order-total">
						<div class="total-row">
							<span>Tạm tính:</span>
							<span><f:formatNumber value="${cart.amount}" pattern="#,###"/>đ</span>
						</div>
						<div class="total-row">
							<span>Phí vận chuyển:</span>
							<span>
								<c:choose>
									<c:when test="${cart.amount >= 500000}">
										<span class="text-success">Miễn phí</span>
									</c:when>
									<c:otherwise>30,000đ</c:otherwise>
								</c:choose>
							</span>
						</div>
						<hr class="total-divider">
						<div class="total-row final-total">
							<span class="total-label">Tổng cộng:</span>
							<span class="total-amount">
								<c:choose>
									<c:when test="${cart.amount >= 500000}">
										<f:formatNumber value="${cart.amount}" pattern="#,###"/>đ
									</c:when>
									<c:otherwise>
										<f:formatNumber value="${cart.amount + 30000}" pattern="#,###"/>đ
									</c:otherwise>
								</c:choose>
							</span>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Checkout Form -->
			<div class="col-lg-5">
				<div class="checkout-form-card">
					<div class="card-header">
						<h4 class="mb-0">
							<i class="bi bi-person-fill me-2"></i>
							Thông Tin Giao Hàng
						</h4>
					</div>
					
					<div class="form-container">
						<c:if test="${not empty message}">
							<div class="alert alert-info">
								<i class="bi bi-info-circle me-2"></i>
								${message}
							</div>
						</c:if>
						
						<c:if test="${not empty error}">
							<div class="alert alert-danger">
								<i class="bi bi-exclamation-triangle me-2"></i>
								${error}
							</div>
						</c:if>
						
						<form:form action="/order/checkout" modelAttribute="order" method="post" class="checkout-form">
							<form:hidden path="user.id" />
							<form:hidden path="status" />
							<form:hidden path="amount" />
							
							<div class="form-group">
								<label class="form-label">
									<i class="bi bi-calendar me-2"></i>Ngày đặt hàng
								</label>
								<form:input path="orderDate" class="form-control" readonly="true" />
							</div>
							
							<div class="form-group">
								<label class="form-label required">
									<i class="bi bi-telephone me-2"></i>Số điện thoại
								</label>
								<form:input path="telephone" class="form-control" placeholder="Nhập số điện thoại" required="true" />
							</div>
							
							<div class="form-group">
								<label class="form-label required">
									<i class="bi bi-geo-alt me-2"></i>Địa chỉ giao hàng
								</label>
								<form:input path="address" class="form-control" placeholder="Nhập địa chỉ chi tiết" required="true" />
							</div>
							
							<div class="form-group">
								<label class="form-label">
									<i class="bi bi-chat-text me-2"></i>Ghi chú đơn hàng
								</label>
								<form:textarea path="description" rows="3" class="form-control" 
											   placeholder="Ghi chú thêm cho đơn hàng (tùy chọn)" />
							</div>
							
							<!-- Payment Method -->
							<!-- <div class="form-group">
								<label class="form-label">
									<i class="bi bi-credit-card me-2"></i>Phương thức thanh toán
								</label>
								<div class="payment-methods">
									<div class="payment-option">
										<input type="radio" id="cod" name="paymentMethod" value="cod" checked>
										<label for="cod" class="payment-label">
											<i class="bi bi-cash me-2"></i>
											Thanh toán khi nhận hàng (COD)
										</label>
									</div>
									<div class="payment-option">
										<input type="radio" id="bank" name="paymentMethod" value="bank">
										<label for="bank" class="payment-label">
											<i class="bi bi-bank me-2"></i>
											Chuyển khoản ngân hàng
										</label>
									</div>
								</div>
							</div>
							 -->
							<!-- Order Summary in Form -->
							<div class="order-summary-mobile d-lg-none">
								<div class="summary-header">
									<h5>Tóm tắt đơn hàng</h5>
								</div>
								<div class="summary-content">
									<div class="summary-row">
										<span>Tạm tính:</span>
										<span><f:formatNumber value="${cart.amount}" pattern="#,###"/>đ</span>
									</div>
									<div class="summary-row">
										<span>Vận chuyển:</span>
										<span>
											<c:choose>
												<c:when test="${cart.amount >= 500000}">Miễn phí</c:when>
												<c:otherwise>30,000đ</c:otherwise>
											</c:choose>
										</span>
									</div>
									<hr>
									<div class="summary-row total">
										<span>Tổng cộng:</span>
										<span class="total-price">
											<c:choose>
												<c:when test="${cart.amount >= 500000}">
													<f:formatNumber value="${cart.amount}" pattern="#,###"/>đ
												</c:when>
												<c:otherwise>
													<f:formatNumber value="${cart.amount + 30000}" pattern="#,###"/>đ
												</c:otherwise>
											</c:choose>
										</span>
									</div>
								</div>
							</div>
							
							<div class="form-actions">
								<a href="/cart/view" class="btn btn-outline-secondary">
									<i class="bi bi-arrow-left me-2"></i>Quay lại giỏ hàng
								</a>
								<button type="submit" class="btn btn-success btn-place-order">
									<i class="bi bi-check-circle me-2"></i>Đặt hàng
								</button>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<style>
/* Modern Checkout Styling */
.checkout-section {
	background: white;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0,0,0,0.08);
	padding: 2rem;
	margin: 2rem 0;
}

.checkout-header {
	margin-bottom: 2rem;
}

.checkout-title {
	font-size: 2.2rem;
	font-weight: 700;
	color: #2c3e50;
	margin-bottom: 0.5rem;
}

.checkout-subtitle {
	font-size: 1.1rem;
}

/* Order Summary Card */
.order-summary-card {
	background: #f8f9fa;
	border-radius: 15px;
	overflow: hidden;
	margin-bottom: 2rem;
}

.card-header {
	background: #2c3e50;
	color: white;
	padding: 1.5rem;
	border-bottom: none;
}

.card-header h4 {
	margin: 0;
	font-weight: 600;
}

/* Order Items */
.order-items {
	padding: 1.5rem;
}

.order-item {
	background: white;
	border-radius: 10px;
	padding: 1.5rem;
	margin-bottom: 1rem;
	box-shadow: 0 2px 8px rgba(0,0,0,0.05);
	transition: all 0.3s ease;
}

.order-item:hover {
	transform: translateY(-2px);
	box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

.order-item:last-child {
	margin-bottom: 0;
}

.item-image img {
	width: 100%;
	height: 80px;
	object-fit: contain;
	border-radius: 8px;
	background: #f8f9fa;
	padding: 5px;
}

.item-info {
	padding-left: 1rem;
}

.item-name {
	font-size: 1rem;
	font-weight: 600;
	color: #2c3e50;
	margin-bottom: 0.25rem;
	line-height: 1.3;
}

.item-sku {
	font-size: 0.85rem;
	margin: 0;
}

.item-price .original-price {
	color: #999;
	text-decoration: line-through;
	font-size: 0.85rem;
}

.item-price .sale-price,
.item-price .current-price {
	color: #dc3545;
	font-weight: 600;
}

.item-quantity {
	font-size: 0.9rem;
}

.quantity-label {
	color: #6c757d;
}

.quantity-value {
	font-weight: 600;
	color: #2c3e50;
}

.item-total {
	font-size: 1.1rem;
	color: #2c3e50;
}

/* Order Total */
.order-total {
	background: white;
	padding: 1.5rem;
	border-top: 1px solid #dee2e6;
}

.total-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 0.75rem;
	font-size: 1rem;
}

.total-divider {
	border-color: #dee2e6;
	margin: 1rem 0;
}

.final-total {
	font-size: 1.2rem;
	font-weight: 700;
	color: #2c3e50;
	padding-top: 0.5rem;
}

.total-amount {
	color: #dc3545;
}

/* Checkout Form Card */
.checkout-form-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 5px 20px rgba(0,0,0,0.08);
	overflow: hidden;
	position: sticky;
	top: 2rem;
}

.form-container {
	padding: 1.5rem;
}

/* Form Styling */
.checkout-form .form-group {
	margin-bottom: 1.5rem;
}

.form-label {
	font-weight: 600;
	color: #2c3e50;
	margin-bottom: 0.5rem;
	display: block;
}

.form-label.required::after {
	content: " *";
	color: #dc3545;
}

.form-control {
	border: 2px solid #e9ecef;
	border-radius: 10px;
	padding: 0.75rem 1rem;
	font-size: 1rem;
	transition: all 0.3s ease;
}

.form-control:focus {
	border-color: #007bff;
	box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

/* Payment Methods */
.payment-methods {
	border: 2px solid #e9ecef;
	border-radius: 10px;
	padding: 1rem;
	background: #f8f9fa;
}

.payment-option {
	margin-bottom: 0.75rem;
}

.payment-option:last-child {
	margin-bottom: 0;
}

.payment-option input[type="radio"] {
	margin-right: 0.5rem;
}

.payment-label {
	font-weight: 500;
	color: #2c3e50;
	cursor: pointer;
	display: flex;
	align-items: center;
	padding: 0.5rem;
	border-radius: 8px;
	transition: background-color 0.2s ease;
}

.payment-label:hover {
	background: rgba(0,123,255,0.1);
}

/* Mobile Order Summary */
.order-summary-mobile {
	background: #f8f9fa;
	border-radius: 10px;
	padding: 1rem;
	margin-bottom: 1.5rem;
}

.summary-header h5 {
	color: #2c3e50;
	font-weight: 600;
	margin-bottom: 1rem;
}

.summary-content .summary-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 0.5rem;
}

.summary-content .total {
	font-weight: 700;
	font-size: 1.1rem;
	color: #2c3e50;
}

.total-price {
	color: #dc3545;
}

/* Form Actions */
.form-actions {
	display: flex;
	gap: 1rem;
	margin-top: 2rem;
}

.form-actions .btn {
	flex: 1;
	padding: 0.75rem 1.5rem;
	font-weight: 600;
	border-radius: 10px;
	transition: all 0.3s ease;
}

.btn-place-order {
	background: #28a745;
	border-color: #28a745;
	font-size: 1.1rem;
}

.btn-place-order:hover {
	background: #218838;
	border-color: #218838;
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(40, 167, 69, 0.4);
}

/* Alert Styling */
.alert {
	border-radius: 10px;
	border: none;
	padding: 1rem;
	margin-bottom: 1.5rem;
}

.alert-info {
	background: #e3f2fd;
	color: #1976d2;
}

.alert-danger {
	background: #ffebee;
	color: #c62828;
}

/* Responsive Design */
@media (max-width: 991.98px) {
	.checkout-form-card {
		position: static;
		margin-top: 2rem;
	}
	
	.item-info {
		padding-left: 0;
		margin-top: 1rem;
	}
	
	.item-price,
	.item-quantity,
	.item-total {
		text-align: center;
		margin-top: 0.5rem;
	}
}

@media (max-width: 767.98px) {
	.checkout-section {
		padding: 1rem;
	}
	
	.checkout-title {
		font-size: 1.8rem;
	}
	
	.order-item {
		padding: 1rem;
	}
	
	.form-actions {
		flex-direction: column;
	}
	
	.form-actions .btn {
		margin-bottom: 0.5rem;
	}
}

@media (max-width: 575.98px) {
	.checkout-section {
		margin: 1rem 0;
		border-radius: 15px;
	}
	
	.item-image img {
		height: 60px;
	}
	
	.order-items,
	.form-container {
		padding: 1rem;
	}
}

/* Loading States */
.checkout-form.loading {
	opacity: 0.7;
	pointer-events: none;
}

.btn-place-order:disabled {
	background: #6c757d;
	border-color: #6c757d;
	cursor: not-allowed;
}
</style>

<script>
$(document).ready(function() {
	// Form validation
	$('.checkout-form').on('submit', function(e) {
		var isValid = true;
		var requiredFields = $(this).find('[required]');
		
		requiredFields.each(function() {
			if (!$(this).val().trim()) {
				$(this).addClass('is-invalid');
				isValid = false;
			} else {
				$(this).removeClass('is-invalid');
			}
		});
		
		if (!isValid) {
			e.preventDefault();
			alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
		} else {
			$(this).addClass('loading');
			$('.btn-place-order').prop('disabled', true).html('<i class="bi bi-hourglass-split me-2"></i>Đang xử lý...');
		}
	});
	
	// Real-time validation
	$('[required]').on('blur', function() {
		if (!$(this).val().trim()) {
			$(this).addClass('is-invalid');
		} else {
			$(this).removeClass('is-invalid');
		}
	});
	
	// Phone number formatting
	$('input[name="telephone"]').on('input', function() {
		var value = $(this).val().replace(/\D/g, '');
		$(this).val(value);
	});
});
</script>
