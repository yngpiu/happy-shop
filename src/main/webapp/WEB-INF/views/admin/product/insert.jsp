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
      const reader = new FileReader();
      
      reader.onload = function(e) {
        document.getElementById('previewImg').src = e.target.result;
        document.getElementById('imagePreview').style.display = 'block';
      };
      
      reader.readAsDataURL(input.files[0]);
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

  // ========== FORM VALIDATION ==========
  document.addEventListener('DOMContentLoaded', function() {
    // Bootstrap form validation
    const forms = document.querySelectorAll('.needs-validation');
    
    Array.from(forms).forEach(form => {
      form.addEventListener('submit', event => {
        if (!form.checkValidity()) {
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