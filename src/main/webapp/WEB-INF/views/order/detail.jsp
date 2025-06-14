<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<!-- Modern Order Detail Page -->
<div class="container my-5">
	<div class="order-detail-section">
		<!-- Page Header -->
		<div class="order-header text-center mb-4">
			<h2 class="order-title">
				<i class="bi bi-receipt me-3"></i>
				Chi Tiết Đơn Hàng
			</h2>
			<p class="order-subtitle text-muted">
				Thông tin chi tiết về đơn hàng #${order.id}
			</p>
		</div>

		<div class="row">
			<!-- Order Information -->
			<div class="col-lg-4">
				<div class="order-info-card">
					<div class="card-header">
						<h4 class="mb-0">
							<i class="bi bi-info-circle me-2"></i>
							Thông Tin Đơn Hàng
						</h4>
					</div>
					
					<div class="order-info-content">
						<div class="info-item">
							<div class="info-label">
								<i class="bi bi-hash me-2"></i>Mã đơn hàng
							</div>
							<div class="info-value">#${order.id}</div>
						</div>
						
						<div class="info-item">
							<div class="info-label">
								<i class="bi bi-calendar me-2"></i>Ngày đặt hàng
							</div>
							<div class="info-value">
								<f:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
							</div>
						</div>
						
						<div class="info-item">
							<div class="info-label">
								<i class="bi bi-cash me-2"></i>Tổng tiền
							</div>
							<div class="info-value total-amount">
								<f:formatNumber value="${order.amount}" pattern="#,###"/>đ
							</div>
						</div>
						
						<div class="info-item">
							<div class="info-label">
								<i class="bi bi-truck me-2"></i>Trạng thái
							</div>
							<div class="info-value">
								<c:choose>
									<c:when test="${order.status == 0}">
										<span class="status-badge status-pending">Chờ xử lý</span>
									</c:when>
									<c:when test="${order.status == 1}">
										<span class="status-badge status-confirmed">Đã xác nhận</span>
									</c:when>
									<c:when test="${order.status == 2}">
										<span class="status-badge status-shipping">Đang giao</span>
									</c:when>
									<c:when test="${order.status == 3}">
										<span class="status-badge status-delivered">Đã giao</span>
									</c:when>
									<c:otherwise>
										<span class="status-badge status-cancelled">Đã hủy</span>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						
						<c:if test="${not empty order.description}">
							<div class="info-item">
								<div class="info-label">
									<i class="bi bi-chat-text me-2"></i>Ghi chú
								</div>
								<div class="info-value">${order.description}</div>
							</div>
						</c:if>
					</div>
				</div>
				
				<!-- Customer Information -->
				<div class="customer-info-card">
					<div class="card-header">
						<h4 class="mb-0">
							<i class="bi bi-person me-2"></i>
							Thông Tin Khách Hàng
						</h4>
					</div>
					
					<div class="customer-info-content">
						<div class="info-item">
							<div class="info-label">
								<i class="bi bi-person-fill me-2"></i>Họ và tên
							</div>
							<div class="info-value">${order.user.fullname}</div>
						</div>
						
						<div class="info-item">
							<div class="info-label">
								<i class="bi bi-telephone me-2"></i>Số điện thoại
							</div>
							<div class="info-value">${order.user.telephone}</div>
						</div>
						
						<div class="info-item">
							<div class="info-label">
								<i class="bi bi-geo-alt me-2"></i>Địa chỉ giao hàng
							</div>
							<div class="info-value">${order.address}</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- Order Items -->
			<div class="col-lg-8">
				<div class="order-items-card">
					<div class="card-header">
						<h4 class="mb-0">
							<i class="bi bi-bag me-2"></i>
							Sản Phẩm Đã Đặt
							<span class="item-count">(${details.size()} sản phẩm)</span>
						</h4>
					</div>
					
					<div class="order-items-content">
						<c:forEach var="d" items="${details}">
							<div class="order-item">
								<div class="row align-items-center">
									<div class="col-md-2 col-sm-3">
										<div class="item-image">
											<img src="/static/images/products/${d.product.image}" 
												 alt="${d.product.name}" class="img-fluid">
										</div>
									</div>
									<div class="col-md-4 col-sm-9">
										<div class="item-info">
											<h6 class="item-name">${d.product.name}</h6>
											<p class="item-sku text-muted">SKU: ${d.product.id}</p>
										</div>
									</div>
									<div class="col-md-2 col-sm-4">
										<div class="item-price">
											<c:choose>
												<c:when test="${d.discount > 0}">
													<div class="original-price">
														<f:formatNumber value="${d.unitPrice}" pattern="#,###"/>đ
													</div>
													<div class="sale-price">
														<f:formatNumber value="${d.unitPrice * (1 - d.discount/100)}" pattern="#,###"/>đ
													</div>
													<div class="discount-info">
														<span class="discount-badge">-<f:formatNumber value="${d.discount}" pattern="#.#"/>%</span>
													</div>
												</c:when>
												<c:otherwise>
													<div class="current-price">
														<f:formatNumber value="${d.unitPrice}" pattern="#,###"/>đ
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="col-md-2 col-sm-4">
										<div class="item-quantity text-center">
											<span class="quantity-label">Số lượng:</span>
											<span class="quantity-value">${d.quantity}</span>
										</div>
									</div>
									<div class="col-md-2 col-sm-4">
										<div class="item-total text-end">
											<strong>
												<f:formatNumber value="${d.quantity * d.unitPrice * (1 - d.discount/100)}" pattern="#,###"/>đ
											</strong>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					
					<!-- Order Summary -->
					<div class="order-summary">
						<div class="summary-row">
							<span>Tạm tính:</span>
							<span><f:formatNumber value="${order.amount}" pattern="#,###"/>đ</span>
						</div>
						<div class="summary-row">
							<span>Phí vận chuyển:</span>
							<span>
								<c:choose>
									<c:when test="${order.amount >= 500000}">
										<span class="text-success">Miễn phí</span>
									</c:when>
									<c:otherwise>30,000đ</c:otherwise>
								</c:choose>
							</span>
						</div>
						<hr class="summary-divider">
						<div class="summary-row final-total">
							<span class="total-label">Tổng cộng:</span>
							<span class="total-amount">
								<c:choose>
									<c:when test="${order.amount >= 500000}">
										<f:formatNumber value="${order.amount}" pattern="#,###"/>đ
									</c:when>
									<c:otherwise>
										<f:formatNumber value="${order.amount + 30000}" pattern="#,###"/>đ
									</c:otherwise>
								</c:choose>
							</span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Action Buttons -->
		<div class="order-actions text-center mt-4">
			<a href="/order/list" class="btn btn-outline-primary">
				<i class="bi bi-arrow-left me-2"></i>Quay lại danh sách đơn hàng
			</a>
			<c:if test="${order.status == 0}">
				<button class="btn btn-outline-danger" onclick="cancelOrder(${order.id})">
					<i class="bi bi-x-circle me-2"></i>Hủy đơn hàng
				</button>
			</c:if>
			<button class="btn btn-success" onclick="printOrder()">
				<i class="bi bi-printer me-2"></i>In đơn hàng
			</button>
		</div>
	</div>
</div>

<style>
/* Modern Order Detail Styling */
.order-detail-section {
	background: white;
	border-radius: 20px;
	box-shadow: 0 10px 40px rgba(0,0,0,0.08);
	padding: 2rem;
	margin: 2rem 0;
}

.order-header {
	margin-bottom: 2rem;
}

.order-title {
	font-size: 2.2rem;
	font-weight: 700;
	color: #2c3e50;
	margin-bottom: 0.5rem;
}

.order-subtitle {
	font-size: 1.1rem;
}

/* Card Styling */
.order-info-card,
.customer-info-card,
.order-items-card {
	background: #f8f9fa;
	border-radius: 15px;
	overflow: hidden;
	margin-bottom: 2rem;
	box-shadow: 0 5px 15px rgba(0,0,0,0.05);
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

.item-count {
	font-size: 0.9rem;
	opacity: 0.8;
	font-weight: 400;
}

/* Order Info Content */
.order-info-content,
.customer-info-content {
	padding: 1.5rem;
}

.info-item {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	margin-bottom: 1.25rem;
	padding-bottom: 1rem;
	border-bottom: 1px solid #e9ecef;
}

.info-item:last-child {
	margin-bottom: 0;
	border-bottom: none;
	padding-bottom: 0;
}

.info-label {
	font-weight: 600;
	color: #6c757d;
	flex: 0 0 40%;
	font-size: 0.9rem;
}

.info-value {
	flex: 1;
	text-align: right;
	color: #2c3e50;
	font-weight: 500;
}

.total-amount {
	color: #dc3545;
	font-weight: 700;
	font-size: 1.2rem;
}

/* Status Badges */
.status-badge {
	padding: 0.25rem 0.75rem;
	border-radius: 20px;
	font-size: 0.8rem;
	font-weight: 600;
	text-transform: uppercase;
}

.status-pending {
	background: #fff3cd;
	color: #856404;
}

.status-confirmed {
	background: #d1ecf1;
	color: #0c5460;
}

.status-shipping {
	background: #d4edda;
	color: #155724;
}

.status-delivered {
	background: #d1ecf1;
	color: #0c5460;
}

.status-cancelled {
	background: #f8d7da;
	color: #721c24;
}

/* Order Items */
.order-items-content {
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

.discount-badge {
	background: #dc3545;
	color: white;
	padding: 2px 6px;
	border-radius: 8px;
	font-size: 0.7rem;
	font-weight: 600;
}

.item-quantity {
	font-size: 0.9rem;
}

.quantity-label {
	color: #6c757d;
	display: block;
	font-size: 0.8rem;
}

.quantity-value {
	font-weight: 600;
	color: #2c3e50;
	font-size: 1.1rem;
}

.item-total {
	font-size: 1.1rem;
	color: #2c3e50;
}

/* Order Summary */
.order-summary {
	background: white;
	padding: 1.5rem;
	border-top: 1px solid #dee2e6;
	border-radius: 0 0 10px 10px;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 0.75rem;
	font-size: 1rem;
}

.summary-divider {
	border-color: #dee2e6;
	margin: 1rem 0;
}

.final-total {
	font-size: 1.2rem;
	font-weight: 700;
	color: #2c3e50;
	padding-top: 0.5rem;
}

.final-total .total-amount {
	color: #dc3545;
}

/* Action Buttons */
.order-actions {
	margin-top: 2rem;
}

.order-actions .btn {
	margin: 0 0.5rem;
	padding: 0.75rem 1.5rem;
	font-weight: 600;
	border-radius: 10px;
	transition: all 0.3s ease;
}

.order-actions .btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* Responsive Design */
@media (max-width: 991.98px) {
	.info-item {
		flex-direction: column;
		align-items: flex-start;
	}
	
	.info-label {
		flex: none;
		margin-bottom: 0.5rem;
	}
	
	.info-value {
		text-align: left;
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
	.order-detail-section {
		padding: 1rem;
	}
	
	.order-title {
		font-size: 1.8rem;
	}
	
	.order-item {
		padding: 1rem;
	}
	
	.order-actions .btn {
		display: block;
		width: 100%;
		margin: 0.5rem 0;
	}
}

@media (max-width: 575.98px) {
	.order-detail-section {
		margin: 1rem 0;
		border-radius: 15px;
	}
	
	.item-image img {
		height: 60px;
	}
	
	.order-info-content,
	.customer-info-content,
	.order-items-content {
		padding: 1rem;
	}
}

/* Print Styles */
@media print {
	.order-actions {
		display: none;
	}
	
	.order-detail-section {
		box-shadow: none;
		border: 1px solid #ddd;
	}
}
</style>

<script>
function cancelOrder(orderId) {
	if (confirm('Bạn có chắc chắn muốn hủy đơn hàng này?')) {
		// Implement cancel order logic here
		alert('Chức năng hủy đơn hàng đang được phát triển');
	}
}

function printOrder() {
	window.print();
}

$(document).ready(function() {
	// Add smooth animations
	$('.order-item').each(function(index) {
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
