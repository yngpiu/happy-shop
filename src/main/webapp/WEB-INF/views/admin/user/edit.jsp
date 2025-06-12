<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:set var="base" value="/admin/user" scope="request" />

<!-- Page Header -->
<div class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4">
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-person-gear me-2"></i>
      Chỉnh sửa người dùng
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="${base}/index">Người dùng</a>
        </li>
        <li class="breadcrumb-item active">Chỉnh sửa</li>
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
        <div class="d-flex align-items-center justify-content-between">
          <h5 class="card-title mb-0">
            <i class="bi bi-person-lines-fill text-primary me-2"></i>
            Thông tin người dùng
          </h5>
          <div class="d-flex gap-2">
            <c:choose>
              <c:when test="${user.isBanned}">
                <span class="badge bg-danger">
                  <i class="bi bi-x-circle me-1"></i>Bị cấm
                </span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-success">
                  <i class="bi bi-check-circle me-1"></i>Hoạt động
                </span>
              </c:otherwise>
            </c:choose>
            <c:choose>
              <c:when test="${user.admin}">
                <span class="badge bg-warning">
                  <i class="bi bi-shield-check me-1"></i>Admin
                </span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-info">
                  <i class="bi bi-person me-1"></i>User
                </span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
      <div class="card-body">
        <form:form modelAttribute="user" method="post" action="${base}/edit/${user.id}" enctype="multipart/form-data" class="needs-validation" novalidate="true">
          <div class="row">
            <!-- Username (readonly) -->
            <div class="col-12 col-md-6 mb-3">
              <label for="id" class="form-label fw-semibold">
                <i class="bi bi-person-circle me-1"></i>
                Tên đăng nhập
              </label>
              <form:input path="id" class="form-control" id="id" readonly="true" style="background-color: #f8f9fa;" />
              <div class="form-text">
                Tên đăng nhập không thể thay đổi.
              </div>
            </div>
            
            <!-- Password -->
            <div class="col-12 col-md-6 mb-3">
              <label for="password" class="form-label fw-semibold">
                <i class="bi bi-lock me-1"></i>
                Mật khẩu mới
              </label>
              <div class="input-group">
                <form:password path="password" class="form-control" id="password" placeholder="Để trống nếu không đổi mật khẩu" minlength="6" maxlength="100" />
                <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                  <i class="bi bi-eye"></i>
                </button>
              </div>
              <div class="form-text">
                Để trống nếu không muốn thay đổi mật khẩu hiện tại.
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
            
            <!-- Current Avatar Display -->
            <div class="col-12 mb-3">
              <label class="form-label fw-semibold">
                <i class="bi bi-image me-1"></i>
                Avatar hiện tại
              </label>
              <div class="mb-3">
                <img src="/static/images/customers/${user.photo}" 
                     alt="${user.fullname}" 
                     class="img-thumbnail"
                     style="max-width: 150px; max-height: 150px; object-fit: cover;"
                     onerror="this.src='/static/images/customers/user.png'">
              </div>
              
              <!-- New Avatar Upload -->
              <label for="imageFile" class="form-label fw-semibold">
                <i class="bi bi-upload me-1"></i>
                Thay đổi avatar
              </label>
              <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*">
              <div class="form-text">
                Chọn ảnh mới để thay đổi avatar. Để trống nếu không muốn thay đổi.
              </div>
              
              <!-- Preview -->
              <div id="imagePreview" class="mt-3" style="display: none;">
                <label class="form-label fw-semibold">Xem trước:</label>
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
            <button type="submit" class="btn btn-primary">
              <i class="bi bi-check-circle me-2"></i>
              Cập nhật
            </button>
          </div>
        </form:form>
      </div>
    </div>
  </div>
  
  <!-- Info Panel -->
  <div class="col-12 col-lg-4">
    <!-- User Info -->
    <div class="card shadow-sm mb-3">
      <div class="card-header bg-primary text-white">
        <h6 class="card-title mb-0">
          <i class="bi bi-info-circle me-2"></i>
          Thông tin chi tiết
        </h6>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <label class="fw-semibold">ID người dùng:</label>
          <p class="mb-0">${user.id}</p>
        </div>
        <div class="mb-3">
          <label class="fw-semibold">Trạng thái:</label>
          <p class="mb-0">
            <c:choose>
              <c:when test="${user.isBanned}">
                <span class="text-danger">
                  <i class="bi bi-x-circle me-1"></i>Bị cấm
                </span>
              </c:when>
              <c:otherwise>
                <span class="text-success">
                  <i class="bi bi-check-circle me-1"></i>Đang hoạt động
                </span>
              </c:otherwise>
            </c:choose>
          </p>
        </div>
        <div class="mb-3">
          <label class="fw-semibold">Vai trò:</label>
          <p class="mb-0">
            <c:choose>
              <c:when test="${user.admin}">
                <span class="text-warning">
                  <i class="bi bi-shield-check me-1"></i>Quản trị viên
                </span>
              </c:when>
              <c:otherwise>
                <span class="text-info">
                  <i class="bi bi-person me-1"></i>Người dùng thường
                </span>
              </c:otherwise>
            </c:choose>
          </p>
        </div>
      </div>
    </div>
    
    <!-- Quick Actions -->
    <div class="card shadow-sm mb-3">
      <div class="card-header bg-secondary text-white">
        <h6 class="card-title mb-0">
          <i class="bi bi-lightning me-2"></i>
          Hành động nhanh
        </h6>
      </div>
      <div class="card-body">
        <div class="d-grid gap-2">
          <c:choose>
            <c:when test="${user.isBanned}">
              <button type="button" 
                      class="btn btn-outline-success"
                      onclick="confirmUnban('${user.id}', '${user.fullname}')">
                <i class="bi bi-person-check me-2"></i>
                Mở cấm người dùng
              </button>
            </c:when>
            <c:otherwise>
              <button type="button" 
                      class="btn btn-outline-danger"
                      onclick="confirmBan('${user.id}', '${user.fullname}')">
                <i class="bi bi-person-x me-2"></i>
                Cấm người dùng
              </button>
            </c:otherwise>
          </c:choose>
          
          <button type="button" class="btn btn-outline-info" onclick="resetPassword()">
            <i class="bi bi-key me-2"></i>
            Đặt lại mật khẩu
          </button>
        </div>
      </div>
    </div>
    
    <!-- Help Panel -->
    <div class="card shadow-sm">
      <div class="card-header bg-info text-white">
        <h6 class="card-title mb-0">
          <i class="bi bi-question-circle me-2"></i>
          Hướng dẫn
        </h6>
      </div>
      <div class="card-body">
        <h6 class="fw-semibold">Chỉnh sửa thông tin:</h6>
        <ul class="list-unstyled">
          <li class="mb-2">
            <i class="bi bi-check text-success me-2"></i>
            Chỉ thay đổi những trường cần thiết
          </li>
          <li class="mb-2">
            <i class="bi bi-check text-success me-2"></i>
            Để trống mật khẩu nếu không đổi
          </li>
          <li class="mb-2">
            <i class="bi bi-check text-success me-2"></i>
            Avatar mới sẽ thay thế ảnh cũ
          </li>
          <li class="mb-2">
            <i class="bi bi-check text-success me-2"></i>
            Cẩn thận khi cấp/thu quyền admin
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>

<!-- Hidden Forms for Actions -->
<form id="banUserForm" method="post" style="display: none;">
  <input type="hidden" name="id" id="banUserId">
</form>

<form id="unbanUserForm" method="post" style="display: none;">
  <input type="hidden" name="id" id="unbanUserId">
</form>

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

// Confirm ban user
function confirmBan(userId, userName) {
  if (confirm('Bạn có chắc chắn muốn cấm người dùng "' + userName + '"?\n\nNgười dùng sẽ không thể đăng nhập vào hệ thống.')) {
    document.getElementById('banUserId').value = userId;
    document.getElementById('banUserForm').action = '${base}/ban/' + userId;
    document.getElementById('banUserForm').submit();
  }
}

// Confirm unban user  
function confirmUnban(userId, userName) {
  if (confirm('Bạn có chắc chắn muốn mở cấm cho người dùng "' + userName + '"?\n\nNgười dùng sẽ có thể đăng nhập trở lại.')) {
    document.getElementById('unbanUserId').value = userId;
    document.getElementById('unbanUserForm').action = '${base}/unban/' + userId;
    document.getElementById('unbanUserForm').submit();
  }
}

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

// Password validation for edit form (optional field)
document.getElementById('password').addEventListener('input', function(e) {
  if (e.target.value.length > 0 && e.target.value.length < 6) {
    e.target.setCustomValidity('Mật khẩu phải có ít nhất 6 ký tự');
  } else {
    e.target.setCustomValidity('');
  }
});

// Reset password function
function resetPassword() {
  const newPassword = prompt('Nhập mật khẩu mới cho người dùng:');
  if (newPassword && newPassword.length >= 6) {
    document.getElementById('password').value = newPassword;
    alert('Mật khẩu đã được điền vào form. Nhấn "Cập nhật" để lưu thay đổi.');
  } else if (newPassword) {
    alert('Mật khẩu phải có ít nhất 6 ký tự!');
  }
}
</script> 