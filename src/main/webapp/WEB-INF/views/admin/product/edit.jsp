<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<c:set var="base" value="/admin/product" scope="request" />

<!-- Page Header -->
<div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4">
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-pencil-square me-2"></i>
      Chỉnh sửa sản phẩm
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/product/index">Sản phẩm</a>
        </li>
        <li class="breadcrumb-item active">Chỉnh sửa #${product.id}</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="/admin/product/index" class="btn btn-secondary">
      <i class="bi bi-arrow-left me-2"></i>
      Quay lại danh sách
    </a>
  </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    ${message}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<!-- Info Card -->
<div class="row mb-4">
  <div class="col-md-6">
    <div class="card bg-light">
      <div class="card-body">
        <h6 class="card-title">
          <i class="bi bi-info-circle text-primary me-2"></i>
          Thông tin hiện tại
        </h6>
        <p class="card-text mb-1">
          <strong>ID:</strong> #${product.id}
        </p>
        <p class="card-text mb-1">
          <strong>Ngày tạo:</strong> 
          <fmt:formatDate value="${product.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
        </p>
        <c:if test="${product.updatedAt != null}">
          <p class="card-text mb-0">
            <strong>Cập nhật cuối:</strong> 
            <fmt:formatDate value="${product.updatedAt}" pattern="dd/MM/yyyy HH:mm"/>
          </p>
        </c:if>
      </div>
    </div>
  </div>
  
  <div class="col-md-6">
    <div class="card bg-light">
      <div class="card-body">
        <h6 class="card-title">
          <i class="bi bi-graph-up text-success me-2"></i>
          Thống kê
        </h6>
        <p class="card-text mb-1">
          <strong>Số đơn hàng:</strong> 
          <span class="badge bg-primary">${orderCount != null ? orderCount : 0}</span>
        </p>
        <p class="card-text mb-1">
          <strong>Trạng thái:</strong>
          <c:choose>
            <c:when test="${product.available}">
              <span class="badge bg-success">Đang bán</span>
            </c:when>
            <c:otherwise>
              <span class="badge bg-warning text-dark">Tạm ngưng</span>
            </c:otherwise>
          </c:choose>
        </p>
        <p class="card-text mb-0">
          <strong>Đặc biệt:</strong>
          <c:choose>
            <c:when test="${product.special}">
              <span class="badge bg-warning text-dark">
                <i class="bi bi-star me-1"></i>Có
              </span>
            </c:when>
            <c:otherwise>
              <span class="badge bg-secondary">Không</span>
            </c:otherwise>
          </c:choose>
        </p>
      </div>
    </div>
  </div>
</div>

<!-- Form Card -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <h5 class="card-title mb-0">
      <i class="bi bi-pencil-square text-primary me-2"></i>
      Chỉnh sửa thông tin sản phẩm
    </h5>
  </div>
  
  <div class="card-body">
    <form:form action="/admin/product/edit/${product.id}" method="post" modelAttribute="product" 
               enctype="multipart/form-data" class="needs-validation" novalidate="true">
      
      <!-- Hidden field for ID -->
      <form:hidden path="id"/>
      
      <div class="row">
        <!-- Left Column -->
        <div class="col-md-8">
          
          <!-- Product Name -->
          <div class="mb-3">
            <label for="name" class="form-label fw-semibold">
              <i class="bi bi-tag me-1"></i>
              Tên sản phẩm <span class="text-danger">*</span>
            </label>
            <form:input path="name" class="form-control" id="name" 
                       placeholder="Nhập tên sản phẩm..." maxlength="100" required="true"/>
            <div class="invalid-feedback">
              Vui lòng nhập tên sản phẩm.
            </div>
            <div class="form-text">Tối đa 100 ký tự</div>
          </div>
          
          <!-- Product Description -->
          <div class="mb-3">
            <label for="description" class="form-label fw-semibold">
              <i class="bi bi-file-text me-1"></i>
              Mô tả sản phẩm
            </label>
            <form:textarea path="description" class="form-control" id="description" 
                          rows="4" placeholder="Nhập mô tả chi tiết về sản phẩm..."/>
            <div class="form-text">Mô tả chi tiết về sản phẩm</div>
          </div>
          
          <!-- Price Information -->
          <div class="row">
            <div class="col-md-6">
              <div class="mb-3">
                <label for="unitPrice" class="form-label fw-semibold">
                  <i class="bi bi-currency-dollar me-1"></i>
                  Giá bán <span class="text-danger">*</span>
                </label>
                <div class="input-group">
                  <form:input path="unitPrice" type="number" class="form-control" id="unitPrice" 
                             placeholder="0" min="0" step="1000" required="true"/>
                  <span class="input-group-text">VNĐ</span>
                </div>
                <div class="invalid-feedback">
                  Vui lòng nhập giá bán hợp lệ.
                </div>
                <c:if test="${product.discount > 0}">
                  <div class="form-text text-success">
                    Giá sau giảm: <strong>
                      <fmt:formatNumber value="${product.unitPrice * (100 - product.discount) / 100}" 
                                       type="currency" currencySymbol="₫" groupingUsed="true"/>
                    </strong>
                  </div>
                </c:if>
              </div>
            </div>
            
            <div class="col-md-6">
              <div class="mb-3">
                <label for="discount" class="form-label fw-semibold">
                  <i class="bi bi-percent me-1"></i>
                  Giảm giá
                </label>
                <div class="input-group">
                  <form:input path="discount" type="number" class="form-control" id="discount" 
                             placeholder="0" min="0" max="100"/>
                  <span class="input-group-text">%</span>
                </div>
                <div class="form-text">Từ 0% đến 100%</div>
              </div>
            </div>
          </div>
          
          <!-- Quantity and Date -->
          <div class="row">
            <div class="col-md-6">
              <div class="mb-3">
                <label for="quantity" class="form-label fw-semibold">
                  <i class="bi bi-boxes me-1"></i>
                  Số lượng <span class="text-danger">*</span>
                </label>
                <form:input path="quantity" type="number" class="form-control" id="quantity" 
                           placeholder="0" min="0" required="true"/>
                <div class="invalid-feedback">
                  Vui lòng nhập số lượng hợp lệ.
                </div>
                <c:choose>
                  <c:when test="${product.quantity <= 0}">
                    <div class="form-text text-danger">
                      <i class="bi bi-exclamation-triangle me-1"></i>
                      Sản phẩm đang hết hàng
                    </div>
                  </c:when>
                  <c:when test="${product.quantity < 10}">
                    <div class="form-text text-warning">
                      <i class="bi bi-exclamation-circle me-1"></i>
                      Số lượng sắp hết
                    </div>
                  </c:when>
                </c:choose>
              </div>
            </div>
            
            <div class="col-md-6">
              <div class="mb-3">
                <label for="productDate" class="form-label fw-semibold">
                  <i class="bi bi-calendar me-1"></i>
                  Ngày sản xuất
                </label>
                <form:input path="productDate" type="date" class="form-control" id="productDate"/>
                <div class="form-text">Ngày sản xuất sản phẩm</div>
              </div>
            </div>
          </div>
          
        </div>
        
        <!-- Right Column -->
        <div class="col-md-4">
          
          <!-- Category Selection -->
          <div class="mb-3">
            <label for="categoryId" class="form-label fw-semibold">
              <i class="bi bi-collection me-1"></i>
              Loại sản phẩm <span class="text-danger">*</span>
            </label>
            <form:select path="category.id" class="form-select" id="categoryId" required="true">
              <form:option value="">-- Chọn loại sản phẩm --</form:option>
              <c:forEach var="category" items="${categories}">
                <form:option value="${category.id}" 
                           selected="${category.id == product.category.id ? 'selected' : ''}">
                  ${category.name}
                </form:option>
              </c:forEach>
            </form:select>
            <div class="invalid-feedback">
              Vui lòng chọn loại sản phẩm.
            </div>
          </div>
          
          <!-- Current Image Display -->
          <div class="mb-3">
            <label class="form-label fw-semibold">
              <i class="bi bi-image me-1"></i>
              Hình ảnh hiện tại
            </label>
            <div id="currentImageContainer">
              <c:choose>
                <c:when test="${not empty product.image}">
                  <img src="/static/images/products/${product.image}" 
                       alt="${product.name}" 
                       class="img-thumbnail d-block mb-2" 
                       style="max-width: 200px; max-height: 200px;"
                       id="currentImage">
                  <div class="form-text">Ảnh hiện tại: ${product.image}</div>
                </c:when>
                <c:otherwise>
                  <div class="bg-light border rounded d-flex align-items-center justify-content-center mb-2" 
                       style="width: 200px; height: 200px;" id="noImagePlaceholder">
                    <div class="text-center">
                      <i class="bi bi-image display-4 text-muted"></i>
                      <div class="text-muted">Chưa có ảnh</div>
                    </div>
                  </div>
                </c:otherwise>
              </c:choose>
            </div>
          </div>
          
          <!-- Image Upload -->
          <div class="mb-3">
            <label for="imageFile" class="form-label fw-semibold">
              <i class="bi bi-upload me-1"></i>
              Thay đổi hình ảnh
            </label>
            <input type="file" class="form-control" id="imageFile" name="imageFile" 
                   accept="image/*" onchange="previewImage(this)">
            <div class="form-text">Chọn file ảnh mới (JPG, PNG, GIF) - Để trống nếu không muốn thay đổi</div>
            
            <!-- New Image Preview -->
            <div id="imagePreview" class="mt-3" style="display: none;">
              <label class="form-label fw-semibold text-success">
                <i class="bi bi-eye me-1"></i>
                Xem trước ảnh mới
              </label>
              <img id="previewImg" src="" alt="Preview" 
                   class="img-thumbnail d-block" style="max-width: 200px; max-height: 200px;">
              <div class="mt-2">
                <button type="button" class="btn btn-sm btn-outline-danger" title="Hủy thay đổi ảnh" onclick="clearImage()">
                  <i class="bi bi-trash"></i>
                </button>
              </div>
            </div>
          </div>
          
          <!-- Product Status -->
          <div class="mb-3">
            <label class="form-label fw-semibold">
              <i class="bi bi-toggle-on me-1"></i>
              Trạng thái
            </label>
            <div class="form-check form-switch">
              <form:checkbox path="available" class="form-check-input" id="available"/>
              <label class="form-check-label" for="available">
                Có thể bán
              </label>
            </div>
            <div class="form-text">Sản phẩm có thể được bán hay không</div>
          </div>
          
          <!-- Special Product -->
          <div class="mb-3">
            <label class="form-label fw-semibold">
              <i class="bi bi-star me-1"></i>
              Sản phẩm đặc biệt
            </label>
            <div class="form-check form-switch">
              <form:checkbox path="special" class="form-check-input" id="special"/>
              <label class="form-check-label" for="special">
                Đánh dấu đặc biệt
              </label>
            </div>
            <div class="form-text">Hiển thị trong danh sách sản phẩm nổi bật</div>
          </div>
          
        </div>
      </div>
      
      <!-- Form Actions -->
      <div class="row">
        <div class="col-12">
          <hr class="my-4">
          <div class="d-flex justify-content-between">
            <div>
              <button type="button" class="btn btn-outline-secondary" title="Đặt lại" onclick="resetForm()">
                <i class="bi bi-arrow-clockwise"></i>
              </button>
            </div>
            <div class="d-flex gap-2">
              <a href="/admin/product/index" class="btn btn-secondary">
                <i class="bi bi-x-circle me-2"></i>
                Hủy
              </a>
              <button type="submit" class="btn btn-primary">
                <i class="bi bi-check-circle me-2"></i>
                Cập nhật sản phẩm
              </button>
            </div>
          </div>
        </div>
      </div>
      
    </form:form>
  </div>
</div>

<script>
  // ========== STORE ORIGINAL VALUES ==========
  let originalValues = {};

  // ========== PREVIEW IMAGE FUNCTION ==========
  /**
   * Hiển thị preview ảnh khi người dùng chọn file mới
   * @param {HTMLInputElement} input - Input file element
   */
  function previewImage(input) {
    if (input.files && input.files[0]) {
      const reader = new FileReader();
      
      reader.onload = function(e) {
        document.getElementById('previewImg').src = e.target.result;
        document.getElementById('imagePreview').style.display = 'block';
      };
      
      reader.readAsDataURL(input.files[0]);
    }
  }

  /**
   * Xóa ảnh mới đã chọn và quay về ảnh gốc
   */
  function clearImage() {
    document.getElementById('imageFile').value = '';
    document.getElementById('imagePreview').style.display = 'none';
    document.getElementById('previewImg').src = '';
  }

  /**
   * Đặt lại form về giá trị ban đầu
   */
  function resetForm() {
    if (confirm('Bạn có chắc chắn muốn đặt lại tất cả thông tin về trạng thái ban đầu?')) {
      // Reset form fields to original values
      Object.keys(originalValues).forEach(fieldName => {
        const field = document.querySelector(`[name="${fieldName}"]`);
        if (field) {
          if (field.type === 'checkbox') {
            field.checked = originalValues[fieldName];
          } else {
            field.value = originalValues[fieldName];
          }
        }
      });
      
      // Clear new image preview
      clearImage();
      
      // Reset validation classes
      const inputs = document.querySelectorAll('.is-invalid, .is-valid');
      inputs.forEach(input => {
        input.classList.remove('is-invalid', 'is-valid');
      });
    }
  }

  /**
   * Cập nhật giá sau giảm khi thay đổi giá hoặc % giảm giá
   */
  function updateFinalPrice() {
    const price = parseFloat(document.getElementById('unitPrice').value) || 0;
    const discount = parseFloat(document.getElementById('discount').value) || 0;
    const finalPrice = price * (100 - discount) / 100;
    
    const priceDisplay = document.getElementById('finalPriceDisplay');
    if (priceDisplay) {
      if (discount > 0) {
        priceDisplay.innerHTML = `Giá sau giảm: <strong>${finalPrice.toLocaleString('vi-VN')}₫</strong>`;
        priceDisplay.className = 'form-text text-success';
        priceDisplay.style.display = 'block';
      } else {
        priceDisplay.style.display = 'none';
      }
    }
  }

  // ========== FORM VALIDATION ==========
  document.addEventListener('DOMContentLoaded', function() {
    // Store original values for reset functionality
    const form = document.querySelector('form');
    const formData = new FormData(form);
    for (let [key, value] of formData.entries()) {
      originalValues[key] = value;
    }
    
    // Store checkbox states
    const checkboxes = form.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach(checkbox => {
      originalValues[checkbox.name] = checkbox.checked;
    });

    // Bootstrap form validation
    const forms = document.querySelectorAll('.needs-validation');
    
    Array.from(forms).forEach(form => {
      form.addEventListener('submit', event => {
        let isValid = true;
        
        // Custom validation checks
        isValid = validateForm() && isValid;
        
        if (!form.checkValidity() || !isValid) {
          event.preventDefault();
          event.stopPropagation();
        } else {
          // Show loading state
          const submitBtn = form.querySelector('button[type="submit"]');
          submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Đang cập nhật...';
          submitBtn.disabled = true;
        }
        
        form.classList.add('was-validated');
      });
    });
    
    /**
     * Custom validation function
     */
    function validateForm() {
      let isValid = true;
      
      // Validate file size (only if new file is selected)
      const fileInput = document.getElementById('imageFile');
      if (fileInput && fileInput.files.length > 0) {
        const file = fileInput.files[0];
        const maxSize = 10 * 1024 * 1024; // 10MB
        
        if (file.size > maxSize) {
          showFieldError(fileInput, 'File quá lớn! Kích thước tối đa là 10MB.');
          isValid = false;
        } else {
          clearFieldError(fileInput);
        }
        
        // Validate file type
        const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
        if (!allowedTypes.includes(file.type)) {
          showFieldError(fileInput, 'Chỉ chấp nhận file ảnh (JPG, PNG, GIF)!');
          isValid = false;
        }
      }
      
      // Validate price
      const priceInput = document.getElementById('unitPrice');
      const price = parseFloat(priceInput.value);
      if (price <= 0) {
        showFieldError(priceInput, 'Giá phải lớn hơn 0!');
        isValid = false;
      } else if (price > 1000000000) {
        showFieldError(priceInput, 'Giá không được vượt quá 1 tỷ!');
        isValid = false;
      } else {
        clearFieldError(priceInput);
      }
      
      // Validate quantity
      const quantityInput = document.getElementById('quantity');
      const quantity = parseInt(quantityInput.value);
      if (quantity < 0) {
        showFieldError(quantityInput, 'Số lượng không được âm!');
        isValid = false;
      } else if (quantity > 100000) {
        showFieldError(quantityInput, 'Số lượng không được vượt quá 100,000!');
        isValid = false;
      } else {
        clearFieldError(quantityInput);
      }
      
      // Validate discount
      const discountInput = document.getElementById('discount');
      const discount = parseFloat(discountInput.value);
      if (discount < 0 || discount > 100) {
        showFieldError(discountInput, 'Giảm giá phải từ 0% đến 100%!');
        isValid = false;
      } else {
        clearFieldError(discountInput);
      }
      
      // Validate product name length
      const nameInput = document.getElementById('name');
      if (nameInput.value.length > 100) {
        showFieldError(nameInput, 'Tên sản phẩm không được vượt quá 100 ký tự!');
        isValid = false;
      } else {
        clearFieldError(nameInput);
      }
      
      return isValid;
    }
    
    /**
     * Show error for a field
     */
    function showFieldError(field, message) {
      field.classList.add('is-invalid');
      field.classList.remove('is-valid');
      
      // Remove existing error message
      const existingError = field.parentNode.querySelector('.invalid-feedback.custom');
      if (existingError) {
        existingError.remove();
      }
      
      // Add new error message
      const errorDiv = document.createElement('div');
      errorDiv.className = 'invalid-feedback custom d-block';
      errorDiv.textContent = message;
      field.parentNode.appendChild(errorDiv);
    }
    
    /**
     * Clear error for a field
     */
    function clearFieldError(field) {
      field.classList.remove('is-invalid');
      const errorDiv = field.parentNode.querySelector('.invalid-feedback.custom');
      if (errorDiv) {
        errorDiv.remove();
      }
    }

    // Real-time validation for required fields
    const requiredInputs = document.querySelectorAll('input[required], select[required]');
    requiredInputs.forEach(input => {
      input.addEventListener('blur', function() {
        if (this.checkValidity()) {
          this.classList.remove('is-invalid');
          this.classList.add('is-valid');
        } else {
          this.classList.remove('is-valid');
          this.classList.add('is-invalid');
        }
      });
    });

    // Price formatting
    const priceInput = document.getElementById('unitPrice');
    if (priceInput) {
      priceInput.addEventListener('input', function() {
        // Remove non-numeric characters except numbers
        this.value = this.value.replace(/[^0-9]/g, '');
        updateFinalPrice();
      });
    }

    // Discount validation and price update
    const discountInput = document.getElementById('discount');
    if (discountInput) {
      discountInput.addEventListener('input', function() {
        if (parseInt(this.value) > 100) {
          this.value = 100;
        }
        if (parseInt(this.value) < 0) {
          this.value = 0;
        }
        updateFinalPrice();
      });
    }

    // Quantity validation
    const quantityInput = document.getElementById('quantity');
    if (quantityInput) {
      quantityInput.addEventListener('input', function() {
        if (parseInt(this.value) < 0) {
          this.value = 0;
        }
      });
    }

    // Add final price display element
    const discountContainer = document.getElementById('discount').closest('.mb-3');
    if (discountContainer && !document.getElementById('finalPriceDisplay')) {
      const finalPriceDiv = document.createElement('div');
      finalPriceDiv.id = 'finalPriceDisplay';
      finalPriceDiv.className = 'form-text text-success';
      finalPriceDiv.style.display = 'none';
      discountContainer.appendChild(finalPriceDiv);
      updateFinalPrice();
    }

    // Auto-focus on name field
    document.getElementById('name').focus();
  });
</script>

<!-- Custom CSS -->
<style>
  .form-label.fw-semibold {
    color: #495057;
  }
  
  .form-check-input:checked {
    background-color: #0d6efd;
    border-color: #0d6efd;
  }
  
  .was-validated .form-control:valid,
  .was-validated .form-select:valid {
    border-color: #198754;
  }
  
  .was-validated .form-control:invalid,
  .was-validated .form-select:invalid {
    border-color: #dc3545;
  }
  
  .img-thumbnail {
    border-radius: 8px;
  }
  
  .input-group-text {
    background-color: #f8f9fa;
    border-color: #ced4da;
  }
  
  .card.bg-light .card-body {
    background-color: #f8f9fa;
  }
  
  #imagePreview {
    border: 2px dashed #28a745;
    border-radius: 8px;
    padding: 15px;
    background-color: #f8fff8;
  }
</style> 