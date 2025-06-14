<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<!-- Page Header -->
<div class="container my-4">
  <div class="row align-items-center">
    <div class="col-md-8">
      <h3 class="fw-bold text-primary mb-2">
        <i class="bi bi-grid-3x3-gap me-2"></i>
        Danh sách sản phẩm
      </h3>
      <p class="text-muted mb-0">
        Tìm thấy <strong>${list.size()}</strong> sản phẩm
      </p>
    </div>
    <div class="col-md-4 text-md-end">
      <div class="dropdown">
        <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
          <i class="bi bi-sort-down me-2"></i>Sắp xếp
        </button>
        <ul class="dropdown-menu">
          <li><a class="dropdown-item" href="#" data-sort="name">Tên A-Z</a></li>
          <li><a class="dropdown-item" href="#" data-sort="price-low">Giá thấp đến cao</a></li>
          <li><a class="dropdown-item" href="#" data-sort="price-high">Giá cao đến thấp</a></li>
          <li><a class="dropdown-item" href="#" data-sort="newest">Mới nhất</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>

<!-- Products Grid -->
<div class="container">
  <c:choose>
    <c:when test="${empty list}">
      <!-- Empty State -->
      <div class="text-center py-5">
        <i class="bi bi-inbox display-1 text-muted mb-4"></i>
        <h4 class="text-muted">Không tìm thấy sản phẩm nào</h4>
        <p class="text-muted mb-4">Hãy thử tìm kiếm với từ khóa khác</p>
        <a href="/" class="btn btn-primary">
          <i class="bi bi-house me-2"></i>Về trang chủ
        </a>
      </div>
    </c:when>
    <c:otherwise>
      <!-- Products Grid -->
      <div class="row g-3">
        <c:forEach var="p" items="${list}">
          <div class="col-xl-3 col-lg-4 col-md-6 col-sm-6 product-item" 
               data-name="${p.name}" 
               data-price="${p.unitPrice * (1 - p.discount)}"
               data-date="${p.productDate}">
            <div class="simple-product-card h-100">
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
                    -<f:formatNumber value="${p.discount}" pattern="#"/>%
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
                        <f:formatNumber value="${p.unitPrice * (1 - p.discount/100)}" pattern="#,###"/>đ
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
    </c:otherwise>
  </c:choose>
</div>

<style>
/* Simple Product Card */
.simple-product-card {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 2px 12px rgba(0,0,0,0.08);
  transition: all 0.3s ease;
  border: 1px solid #f0f0f0;
}

.simple-product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 8px 25px rgba(0,0,0,0.12);
}

/* Product Image */
.product-image-container {
  position: relative;
  height: 220px;
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

/* Empty State */
.empty-state {
  max-width: 400px;
  margin: 0 auto;
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

@media (max-width: 575.98px) {
  .simple-product-card {
    margin-bottom: 15px;
  }
  
  .container.my-4 {
    margin-top: 1rem !important;
    margin-bottom: 1rem !important;
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

/* Sort functionality */
.dropdown-menu {
  border-radius: 8px;
  box-shadow: 0 4px 15px rgba(0,0,0,0.1);
  border: none;
}

.dropdown-item {
  padding: 8px 16px;
  transition: background-color 0.2s ease;
}

.dropdown-item:hover {
  background-color: #f8f9fa;
}
</style>

<script>
$(document).ready(function() {
  // Sort functionality
  $('[data-sort]').click(function(e) {
    e.preventDefault();
    const sortBy = $(this).data('sort');
    const container = $('.row.g-3');
    const items = container.find('.product-item').get();
    
    items.sort(function(a, b) {
      let aVal, bVal;
      
      switch(sortBy) {
        case 'name':
          aVal = $(a).data('name').toLowerCase();
          bVal = $(b).data('name').toLowerCase();
          return aVal.localeCompare(bVal);
        case 'price-low':
          aVal = parseFloat($(a).data('price'));
          bVal = parseFloat($(b).data('price'));
          return aVal - bVal;
        case 'price-high':
          aVal = parseFloat($(a).data('price'));
          bVal = parseFloat($(b).data('price'));
          return bVal - aVal;
        case 'newest':
          aVal = new Date($(a).data('date'));
          bVal = new Date($(b).data('date'));
          return bVal - aVal;
        default:
          return 0;
      }
    });
    
    // Reorder items with animation
    container.fadeOut(200, function() {
      $.each(items, function(index, item) {
        container.append(item);
      });
      container.fadeIn(200);
    });
  });
  });
</script>