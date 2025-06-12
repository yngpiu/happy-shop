<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:set var="base" value="/admin/user" scope="request" />

<!-- Page Header -->
<div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4">
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-person-plus me-2"></i>
      Thêm người dùng mới
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="${base}/index">Người dùng</a>
        </li>
        <li class="breadcrumb-item active">Thêm mới</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="${base}/index" class="btn btn-outline-secondary">
      <i class="bi bi-arrow-left me-2"></i>
      Quay lại
    </a>
  </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
  <div class="alert alert-success auto-hide-alert fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    ${message}${param.message}
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger auto-hide-alert fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}${param.error}
  </div>
</c:if>

<!-- User Form -->
<div class="row">
  <div class="col-12 col-lg-8">
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <h5 class="card-title mb-0">
          <i class="bi bi-person-lines-fill text-primary me-2"></i>
          Thông tin người dùng
        </h5>
      </div>
      <div class="card-body">
        <form:form modelAttribute="user" method="post" action="${base}/insert" enctype="multipart/form-data" class="needs-validation" novalidate="true" id="userForm">
          <div class="row">
            <!-- Username -->
            <div class="col-12 col-md-6 mb-3">
              <label for="id" class="form-label fw-semibold">
                <i class="bi bi-person-circle me-1"></i>
                Tên đăng nhập <span class="text-danger">*</span>
              </label>
              <form:input path="id" class="form-control" id="id" placeholder="Nhập tên đăng nhập" required="true" minlength="3" maxlength="50" pattern="^[a-zA-Z0-9_-]+$" />
              <div class="invalid-feedback">
                Tên đăng nhập phải có 3-50 ký tự, chỉ chứa chữ cái, số, dấu gạch dưới và gạch ngang.
              </div>
              <div class="form-text">
                Tên đăng nhập không thể thay đổi sau khi tạo.
              </div>
            </div>
            
            <!-- Password -->
            <div class="col-12 col-md-6 mb-3">
              <label for="password" class="form-label fw-semibold">
                <i class="bi bi-lock me-1"></i>
                Mật khẩu <span class="text-danger">*</span>
              </label>
              <div class="input-group">
                <form:password path="password" class="form-control" id="password" placeholder="Nhập mật khẩu" required="true" minlength="6" maxlength="100" />
                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                  <i class="bi bi-eye"></i>
                </button>
              </div>
              <div class="invalid-feedback">
                Mật khẩu phải có từ 6-100 ký tự.
              </div>
            </div>
            
            <!-- Full Name -->
            <div class="col-12 mb-3">
              <label for="fullname" class="form-label fw-semibold">
                <i class="bi bi-person me-1"></i>
                Họ và tên <span class="text-danger">*</span>
              </label>
              <form:input path="fullname" class="form-control" id="fullname" placeholder="Nhập họ và tên đầy đủ" required="true" maxlength="100" />
              <div class="invalid-feedback">
                Vui lòng nhập họ và tên (tối đa 100 ký tự).
              </div>
            </div>
            
            <!-- Email -->
            <div class="col-12 col-md-6 mb-3">
              <label for="email" class="form-label fw-semibold">
                <i class="bi bi-envelope me-1"></i>
                Email <span class="text-danger">*</span>
              </label>
              <form:input path="email" type="email" class="form-control" id="email" placeholder="Nhập địa chỉ email" required="true" maxlength="100" />
              <div class="invalid-feedback">
                Vui lòng nhập email hợp lệ (tối đa 100 ký tự).
              </div>
            </div>
            
            <!-- Phone -->
            <div class="col-12 col-md-6 mb-3">
              <label for="telephone" class="form-label fw-semibold">
                <i class="bi bi-telephone me-1"></i>
                Số điện thoại <span class="text-danger">*</span>
              </label>
              <form:input path="telephone" class="form-control" id="telephone" placeholder="Nhập số điện thoại" required="true" maxlength="20" pattern="[0-9+\-\s\(\)]{10,20}" />
              <div class="invalid-feedback">
                Vui lòng nhập số điện thoại hợp lệ (10-20 ký tự, chỉ số và ký tự +, -, (), khoảng trắng).
              </div>
            </div>
            
            <!-- Avatar Upload -->
            <div class="col-12 mb-3">
              <label for="imageFile" class="form-label fw-semibold">
                <i class="bi bi-image me-1"></i>
                Avatar
              </label>
              <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
              <div class="form-text">
                Chọn ảnh đại diện cho người dùng. Nếu không chọn, sẽ sử dụng ảnh mặc định.
              </div>
              
              <!-- Preview -->
              <div id="imagePreview" class="mt-3" style="display: none;">
                <img id="previewImg" src="" alt="Preview" class="img-thumbnail" style="max-width: 150px;">
              </div>
            </div>
            
            <!-- User Settings -->
            <div class="col-12 mb-4">
              <h6 class="fw-semibold mb-3">
                <i class="bi bi-gear me-1"></i>
                Cài đặt tài khoản
              </h6>
              
              <div class="row">
                <div class="col-12 col-md-4 mb-3">
                  <div class="form-check form-switch">
                    <form:checkbox path="activated" class="form-check-input" id="activated" />
                    <label class="form-check-label" for="activated">
                      <i class="bi bi-check-circle me-1"></i>
                      Kích hoạt tài khoản
                    </label>
                  </div>
                  <div class="form-text">
                    Tài khoản được kích hoạt có thể đăng nhập vào hệ thống.
                  </div>
                </div>
                
                <div class="col-12 col-md-4 mb-3">
                  <div class="form-check form-switch">
                    <form:checkbox path="isBanned" class="form-check-input" id="isBanned" />
                    <label class="form-check-label" for="isBanned">
                      <i class="bi bi-person-x me-1"></i>
                      Cấm người dùng
                    </label>
                  </div>
                  <div class="form-text">
                    Người dùng bị cấm không thể đăng nhập.
                  </div>
                </div>
                
                <div class="col-12 col-md-4 mb-3">
                  <div class="form-check form-switch">
                    <form:checkbox path="admin" class="form-check-input" id="admin" />
                    <label class="form-check-label" for="admin">
                      <i class="bi bi-shield-check me-1"></i>
                      Quyền quản trị viên
                    </label>
                  </div>
                  <div class="form-text">
                    Quản trị viên có thể truy cập vào trang quản lý.
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- Form Actions -->
          <div class="d-flex gap-2 justify-content-end pt-3 border-top">
            <a href="${base}/index" class="btn btn-outline-secondary">
              <i class="bi bi-x-circle me-2"></i>
              Hủy bỏ
            </a>
            <button type="reset" class="btn btn-outline-warning">
              <i class="bi bi-arrow-clockwise me-2"></i>
              Đặt lại
            </button>
            <button type="submit" class="btn btn-success">
              <i class="bi bi-check-circle me-2"></i>
              Tạo tài khoản
            </button>
          </div>
        </form:form>
      </div>
    </div>
  </div>
  
  <!-- Help Panel -->
  <div class="col-12 col-lg-4">
    <div class="card shadow-sm">
      <div class="card-header bg-info text-white">
        <h6 class="card-title mb-0">
          <i class="bi bi-info-circle me-2"></i>
          Hướng dẫn
        </h6>
      </div>
      <div class="card-body">
        <h6 class="fw-semibold">Lưu ý khi tạo tài khoản:</h6>
        <ul class="list-unstyled">
          <li class="mb-2">
            <i class="bi bi-check text-success me-2"></i>
            Tên đăng nhập phải duy nhất trong hệ thống
          </li>
          <li class="mb-2">
            <i class="bi bi-check text-success me-2"></i>
            Mật khẩu tối thiểu 6 ký tự
          </li>
          <li class="mb-2">
            <i class="bi bi-check text-success me-2"></i>
            Email phải có định dạng hợp lệ
          </li>
          <li class="mb-2">
            <i class="bi bi-check text-success me-2"></i>
            Avatar nên có kích thước nhỏ hơn 2MB
          </li>
        </ul>
        
        <hr>
        
        <h6 class="fw-semibold">Phân quyền:</h6>
        <div class="mb-2">
          <span class="badge bg-info">User thường</span>
          <small class="d-block text-muted">Chỉ có thể mua hàng và quản lý đơn hàng của mình</small>
        </div>
        <div class="mb-2">
          <span class="badge bg-warning">Admin</span>
          <small class="d-block text-muted">Có thể truy cập trang quản trị và quản lý toàn bộ hệ thống</small>
        </div>
      </div>
    </div>
    
    <div class="card shadow-sm mt-3">
      <div class="card-header bg-warning text-dark">
        <h6 class="card-title mb-0">
          <i class="bi bi-exclamation-triangle me-2"></i>
          Cảnh báo bảo mật
        </h6>
      </div>
      <div class="card-body">
        <p class="mb-2">
          <strong>Lưu ý quan trọng:</strong>
        </p>
        <ul class="list-unstyled">
          <li class="mb-1">
            <i class="bi bi-shield-exclamation text-warning me-2"></i>
            Không chia sẻ thông tin đăng nhập
          </li>
          <li class="mb-1">
            <i class="bi bi-shield-exclamation text-warning me-2"></i>
            Tạo mật khẩu mạnh và khó đoán
          </li>
          <li class="mb-1">
            <i class="bi bi-shield-exclamation text-warning me-2"></i>
            Cẩn thận khi cấp quyền admin
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
// Auto-hide alerts
setTimeout(function() {
  $('.auto-hide-alert').fadeOut();
}, 5000);

// Form validation
(function() {
  'use strict';
  window.addEventListener('load', function() {
    var forms = document.getElementsByClassName('needs-validation');
    var validation = Array.prototype.filter.call(forms, function(form) {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }, false);
})();

// Toggle password visibility
document.getElementById('togglePassword').addEventListener('click', function() {
  const passwordField = document.getElementById('password');
  const toggleIcon = this.querySelector('i');
  
  if (passwordField.type === 'password') {
    passwordField.type = 'text';
    toggleIcon.classList.remove('bi-eye');
    toggleIcon.classList.add('bi-eye-slash');
  } else {
    passwordField.type = 'password';
    toggleIcon.classList.remove('bi-eye-slash');
    toggleIcon.classList.add('bi-eye');
  }
});

// Image preview
document.getElementById('imageFile').addEventListener('change', function(event) {
  const file = event.target.files[0];
  const preview = document.getElementById('imagePreview');
  const previewImg = document.getElementById('previewImg');
  
  if (file) {
    const reader = new FileReader();
    reader.onload = function(e) {
      previewImg.src = e.target.result;
      preview.style.display = 'block';
    };
    reader.readAsDataURL(file);
  } else {
    preview.style.display = 'none';
  }
});

// Phone number validation and formatting
document.getElementById('telephone').addEventListener('input', function(e) {
  let value = e.target.value;
  // Remove any characters that are not numbers, +, -, (), or spaces
  let cleaned = value.replace(/[^0-9+\-\s\(\)]/g, '');
  
  // Limit length
  if (cleaned.length > 20) {
    cleaned = cleaned.substring(0, 20);
  }
  
  e.target.value = cleaned;
  
  // Custom validation message
  if (cleaned.length > 0) {
    let numbersOnly = cleaned.replace(/[^0-9]/g, '');
    if (numbersOnly.length < 10 || numbersOnly.length > 15) {
      e.target.setCustomValidity('Số điện thoại phải có từ 10-15 chữ số');
    } else {
      e.target.setCustomValidity('');
    }
  }
});

// Username validation
document.getElementById('id').addEventListener('input', function(e) {
  let value = e.target.value;
  // Remove any invalid characters
  let cleaned = value.replace(/[^a-zA-Z0-9_-]/g, '');
  e.target.value = cleaned;
});

// Additional form validation before submit
document.getElementById('userForm').addEventListener('submit', function(e) {
  const telephone = document.getElementById('telephone').value;
  const telephoneNumbers = telephone.replace(/[^0-9]/g, '');
  
  if (telephoneNumbers.length < 10 || telephoneNumbers.length > 15) {
    e.preventDefault();
    document.getElementById('telephone').setCustomValidity('Số điện thoại phải có từ 10-15 chữ số');
    document.getElementById('telephone').reportValidity();
    return false;
  }
});

// Set default values
document.addEventListener('DOMContentLoaded', function() {
  // Set activated to true by default
  document.getElementById('activated').checked = true;
  
  // Set isBanned to false by default
  document.getElementById('isBanned').checked = false;
  
  // Set admin to false by default
  document.getElementById('admin').checked = false;
});
</script> 