<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:set var="base" value="/admin/product" scope="request" />

<!-- Page Header -->
<div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4">
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-plus-circle me-2"></i>
      Thêm sản phẩm mới
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/product/index">Sản phẩm</a>
        </li>
        <li class="breadcrumb-item active">Thêm mới</li>
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
  <div class="alert alert-success auto-hide-alert fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    ${message}
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger auto-hide-alert fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}
  </div>
</c:if>

<!-- Form Card -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <h5 class="card-title mb-0">
      <i class="bi bi-pencil-square text-primary me-2"></i>
      Thông tin sản phẩm
    </h5>
  </div>
  
  <div class="card-body">
    <form:form action="/admin/product/insert" method="post" modelAttribute="product" 
               enctype="multipart/form-data" class="needs-validation" novalidate="true">
      
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
                             placeholder="0" min="0" max="100" value="0"/>
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
                <form:option value="${category.id}">${category.name}</form:option>
              </c:forEach>
            </form:select>
            <div class="invalid-feedback">
              Vui lòng chọn loại sản phẩm.
            </div>
          </div>
          
          <!-- Image Upload -->
          <div class="mb-3">
            <label for="imageFile" class="form-label fw-semibold">
              <i class="bi bi-image me-1"></i>
              Hình ảnh sản phẩm
            </label>
            <input type="file" class="form-control" id="imageFile" name="imageFile" 
                   accept="image/*" onchange="previewImage(this)">
            <div class="form-text">Chọn file ảnh (JPG, PNG, GIF)</div>
            
            <!-- Image Preview -->
            <div id="imagePreview" class="mt-3" style="display: none;">
              <img id="previewImg" src="" alt="Preview" 
                   class="img-thumbnail" style="max-width: 200px; max-height: 200px;">
              <div class="mt-2">
                <button type="button" class="btn btn-sm btn-outline-danger" title="Xóa ảnh" onclick="clearImage()">
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
              <form:checkbox path="available" class="form-check-input" id="available" checked="true"/>
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
              <button type="submit" class="btn btn-success">
                <i class="bi bi-check-circle me-2"></i>
                Thêm sản phẩm
              </button>
            </div>
          </div>
        </div>
      </div>
      
    </form:form>
  </div>
</div>

<script>
  // ========== PREVIEW IMAGE FUNCTION ==========
  /**
   * Hiển thị preview ảnh khi người dùng chọn file
   * @param {HTMLInputElement} input - Input file element
   */
  function previewImage(input) {
    if (input.files && input.files[0]) {
      const file = input.files[0];
      
      // Check file size (10MB limit)
      const maxSize = 10 * 1024 * 1024; // 10MB
      if (file.size > maxSize) {
        showFieldError(input, 'File quá lớn! Kích thước tối đa là 10MB.');
        input.value = '';
        document.getElementById('imagePreview').style.display = 'none';
        return;
      }
      
      // Check file type
      const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
      if (!allowedTypes.includes(file.type)) {
        showFieldError(input, 'Chỉ chấp nhận file ảnh (JPG, PNG, GIF)!');
        input.value = '';
        document.getElementById('imagePreview').style.display = 'none';
        return;
      }
      
      // Clear previous errors
      clearFieldError(input);
      
      const reader = new FileReader();
      reader.onload = function(e) {
        document.getElementById('previewImg').src = e.target.result;
        document.getElementById('imagePreview').style.display = 'block';
        
        // Show file info
        const fileSizeKB = (file.size / 1024).toFixed(2);
        const fileSizeMB = (file.size / (1024 * 1024)).toFixed(2);
        const sizeText = file.size > 1024 * 1024 ? fileSizeMB + ' MB' : fileSizeKB + ' KB';
        
        // Update or create file info display
        let fileInfo = document.getElementById('fileInfo');
        if (!fileInfo) {
          fileInfo = document.createElement('small');
          fileInfo.id = 'fileInfo';
          fileInfo.className = 'text-muted';
          document.getElementById('imagePreview').appendChild(fileInfo);
        }
        fileInfo.innerHTML = `<i class="bi bi-info-circle"></i> ${file.name} (${sizeText})`;
      };
      
      reader.readAsDataURL(file);
    }
  }

  /**
   * Xóa ảnh đã chọn
   */
  function clearImage() {
    document.getElementById('imageFile').value = '';
    document.getElementById('imagePreview').style.display = 'none';
    document.getElementById('previewImg').src = '';
  }

  /**
   * Đặt lại form về trạng thái ban đầu
   */
  function resetForm() {
    if (confirm('Bạn có chắc chắn muốn đặt lại tất cả thông tin đã nhập?')) {
      document.querySelector('form').reset();
      clearImage();
      
      // Reset validation classes
      const inputs = document.querySelectorAll('.is-invalid, .is-valid');
      inputs.forEach(input => {
        input.classList.remove('is-invalid', 'is-valid');
      });
    }
  }

  // ========== XỬ LÝ AUTO-HIDE ALERT MESSAGES ==========
  document.addEventListener('DOMContentLoaded', function() {
    const autoHideAlerts = document.querySelectorAll('.auto-hide-alert');
    autoHideAlerts.forEach(function(alert) {
      // Thêm hiệu ứng bounce nhẹ khi xuất hiện
      alert.style.animation = 'fadeInBounce 0.5s ease-out';
      
      // Thêm hiệu ứng hover
      alert.addEventListener('mouseenter', function() {
        this.style.transform = 'scale(1.01)';
        this.style.boxShadow = '0 4px 15px rgba(0,0,0,0.1)';
      });
      
      alert.addEventListener('mouseleave', function() {
        this.style.transform = 'scale(1)';
        this.style.boxShadow = '0 2px 8px rgba(0,0,0,0.05)';
      });
      
      // Tự động ẩn sau 4 giây
      setTimeout(function() {
        if (alert && alert.parentNode) {
          alert.style.transition = 'all 0.6s ease-out';
          alert.style.opacity = '0';
          alert.style.transform = 'translateY(-20px) scale(0.95)';
          
          setTimeout(function() {
            if (alert && alert.parentNode) {
              alert.remove();
            }
          }, 600);
        }
      }, 4000); // 4 giây
    });

  // ========== FORM VALIDATION ==========
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
          submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Đang thêm...';
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
      
      // Validate file size
      const fileInput = document.getElementById('imageFile');
      if (fileInput.files.length > 0) {
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
      });
    }

    // Discount validation
    const discountInput = document.getElementById('discount');
    if (discountInput) {
      discountInput.addEventListener('input', function() {
        if (parseInt(this.value) > 100) {
          this.value = 100;
        }
        if (parseInt(this.value) < 0) {
          this.value = 0;
        }
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

    // Auto-focus on name field
    document.getElementById('name').focus();
  });
</script>

<!-- Custom CSS for Alert Animations -->
<style>
  /* Alert Animations */
  @keyframes fadeInBounce {
    0% {
      opacity: 0;
      transform: translateY(-30px) scale(0.95);
    }
    50% {
      opacity: 0.8;
      transform: translateY(5px) scale(1.02);
    }
    100% {
      opacity: 1;
      transform: translateY(0) scale(1);
    }
  }
  
  .auto-hide-alert {
    transition: all 0.3s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    border: none;
    border-left: 4px solid;
    padding: 1rem 1.25rem;
  }
  
  .auto-hide-alert.alert-success {
    border-left-color: #28a745;
    background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
    color: #155724;
  }
  
  .auto-hide-alert.alert-danger {
    border-left-color: #dc3545;
    background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
    color: #721c24;
  }
</style>

<!-- Custom CSS -->
<style>
  .form-label.fw-semibold {
    color: #495057;
  }
  
  .form-check-input:checked {
    background-color: #28a745;
    border-color: #28a745;
  }
  
  .was-validated .form-control:valid,
  .was-validated .form-select:valid {
    border-color: #28a745;
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
</style> 