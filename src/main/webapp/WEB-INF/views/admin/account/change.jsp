<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib
uri="http://www.springframework.org/tags" prefix="s"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-key me-2"></i>
      Thay đổi mật khẩu
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/profile">Hồ sơ cá nhân</a>
        </li>
        <li class="breadcrumb-item active">Đổi mật khẩu</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="/admin/profile" class="btn btn-outline-primary">
      <i class="bi bi-person-gear me-2"></i>
      Hồ sơ cá nhân
    </a>
    <a href="/admin/home/index" class="btn btn-outline-secondary">
      <i class="bi bi-arrow-left me-2"></i>
      Quay lại
    </a>
  </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
  <c:choose>
    <c:when
      test="${fn:contains(message, 'thành công') or fn:contains(message, 'Thành công')}"
    >
      <div class="alert alert-success auto-hide-alert fade show" role="alert">
        <i class="bi bi-check-circle me-2"></i>
        ${message}${param.message}
      </div>
    </c:when>
    <c:otherwise>
      <div class="alert alert-danger auto-hide-alert fade show" role="alert">
        <i class="bi bi-exclamation-triangle me-2"></i>
        ${message}${param.message}
      </div>
    </c:otherwise>
  </c:choose>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger auto-hide-alert fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}${param.error}
  </div>
</c:if>

<!-- Change Password Form -->
<div class="row justify-content-center">
  <div class="col-12 col-lg-8">
    <div class="card shadow-sm">
      <div class="card-header bg-warning text-dark">
        <h5 class="card-title mb-0">
          <i class="bi bi-shield-lock me-2"></i>
          Cập nhật mật khẩu bảo mật
        </h5>
      </div>
      <div class="card-body">
        <form:form
          action="/admin/change"
          modelAttribute="form"
          method="post"
          enctype="multipart/form-data"
          class="needs-validation"
          novalidate="true"
        >
          <!-- Username (readonly) -->
          <div class="row mb-4">
            <div class="col-sm-4">
              <label for="id" class="form-label fw-semibold">
                <i class="bi bi-person-circle me-1"></i>
                Tên đăng nhập:
              </label>
            </div>
            <div class="col-sm-8">
              <form:input
                path="id"
                class="form-control"
                id="id"
                readonly="true"
                style="background-color: #f8f9fa"
              />
            </div>
          </div>

          <!-- Current Password -->
          <div class="row mb-4">
            <div class="col-sm-4">
              <label for="currentPassword" class="form-label fw-semibold">
                <i class="bi bi-lock me-1"></i>
                Mật khẩu hiện tại: <span class="text-danger">*</span>
              </label>
            </div>
            <div class="col-sm-8">
              <div class="input-group">
                <input
                  name="pw"
                  type="password"
                  class="form-control"
                  id="currentPassword"
                  required
                  placeholder="Nhập mật khẩu hiện tại"
                />
                <button
                  class="btn btn-outline-secondary"
                  type="button"
                  id="toggleCurrentPassword"
                >
                  <i class="bi bi-eye"></i>
                </button>
              </div>
              <div class="invalid-feedback">
                Vui lòng nhập mật khẩu hiện tại.
              </div>
            </div>
          </div>

          <!-- New Password -->
          <div class="row mb-4">
            <div class="col-sm-4">
              <label for="newPassword" class="form-label fw-semibold">
                <i class="bi bi-shield-lock me-1"></i>
                Mật khẩu mới: <span class="text-danger">*</span>
              </label>
            </div>
            <div class="col-sm-8">
              <div class="input-group">
                <input
                  name="pw1"
                  type="password"
                  class="form-control"
                  id="newPassword"
                  required
                  minlength="6"
                  placeholder="Nhập mật khẩu mới (ít nhất 6 ký tự)"
                />
                <button
                  class="btn btn-outline-secondary"
                  type="button"
                  id="toggleNewPassword"
                >
                  <i class="bi bi-eye"></i>
                </button>
              </div>
              <div class="invalid-feedback">
                Mật khẩu mới phải có ít nhất 6 ký tự.
              </div>
              <div class="form-text">
                <i class="bi bi-info-circle me-1"></i>
                Mật khẩu nên chứa ít nhất 6 ký tự, bao gồm chữ và số.
              </div>
            </div>
          </div>

          <!-- Confirm New Password -->
          <div class="row mb-4">
            <div class="col-sm-4">
              <label for="confirmPassword" class="form-label fw-semibold">
                <i class="bi bi-shield-check me-1"></i>
                Xác nhận mật khẩu mới: <span class="text-danger">*</span>
              </label>
            </div>
            <div class="col-sm-8">
              <div class="input-group">
                <input
                  name="pw2"
                  type="password"
                  class="form-control"
                  id="confirmPassword"
                  required
                  minlength="6"
                  placeholder="Nhập lại mật khẩu mới"
                />
                <button
                  class="btn btn-outline-secondary"
                  type="button"
                  id="toggleConfirmPassword"
                >
                  <i class="bi bi-eye"></i>
                </button>
              </div>
              <div class="invalid-feedback" id="confirmPasswordFeedback">
                Vui lòng xác nhận mật khẩu mới.
              </div>
            </div>
          </div>

          <!-- Submit Buttons -->
          <div class="row">
            <div class="col-sm-4"></div>
            <div class="col-sm-8">
              <div class="d-flex gap-2">
                <button
                  type="submit"
                  class="btn btn-warning"
                  id="updatePasswordBtn"
                >
                  <i class="bi bi-shield-check me-2"></i>
                  Cập nhật mật khẩu
                </button>
                <a href="/admin/profile" class="btn btn-outline-secondary">
                  <i class="bi bi-x-circle me-2"></i>
                  Hủy bỏ
                </a>
              </div>
            </div>
          </div>
        </form:form>
      </div>
    </div>
  </div>

  <!-- Security Tips Panel -->
  <div class="col-12 col-lg-4">
    <div class="card shadow-sm">
      <div class="card-header bg-info text-white">
        <h6 class="card-title mb-0">
          <i class="bi bi-shield-exclamation me-2"></i>
          Lời khuyên bảo mật
        </h6>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <h6 class="fw-semibold text-primary">
            <i class="bi bi-check-circle me-1"></i>
            Mật khẩu mạnh nên có:
          </h6>
          <ul class="list-unstyled ms-3">
            <li>
              <i class="bi bi-arrow-right text-muted me-1"></i> Ít nhất 8 ký tự
            </li>
            <li>
              <i class="bi bi-arrow-right text-muted me-1"></i> Chữ hoa và chữ
              thường
            </li>
            <li>
              <i class="bi bi-arrow-right text-muted me-1"></i> Ít nhất 1 số
            </li>
            <li>
              <i class="bi bi-arrow-right text-muted me-1"></i> Ký tự đặc biệt
              (@, #, $, %)
            </li>
          </ul>
        </div>

        <div class="mb-3">
          <h6 class="fw-semibold text-warning">
            <i class="bi bi-exclamation-triangle me-1"></i>
            Tránh sử dụng:
          </h6>
          <ul class="list-unstyled ms-3">
            <li><i class="bi bi-x text-danger me-1"></i> Thông tin cá nhân</li>
            <li><i class="bi bi-x text-danger me-1"></i> Mật khẩu dễ đoán</li>
            <li>
              <i class="bi bi-x text-danger me-1"></i> Cùng 1 mật khẩu nhiều nơi
            </li>
          </ul>
        </div>

        <div class="alert alert-light border">
          <small class="text-muted">
            <i class="bi bi-lightbulb me-1"></i>
            <strong>Mẹo:</strong> Sử dụng cụm từ dễ nhớ kết hợp với số và ký tự
            đặc biệt.
          </small>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- JavaScript for Password Validation and Toggle -->
<script>
  document.addEventListener('DOMContentLoaded', function () {
    // Password toggle functionality
    function togglePasswordVisibility(toggleBtn, passwordInput) {
      toggleBtn.addEventListener('click', function () {
        const type =
          passwordInput.getAttribute('type') === 'password'
            ? 'text'
            : 'password';
        passwordInput.setAttribute('type', type);

        const icon = this.querySelector('i');
        icon.classList.toggle('bi-eye');
        icon.classList.toggle('bi-eye-slash');
      });
    }

    // Initialize password toggles
    togglePasswordVisibility(
      document.getElementById('toggleCurrentPassword'),
      document.getElementById('currentPassword')
    );

    togglePasswordVisibility(
      document.getElementById('toggleNewPassword'),
      document.getElementById('newPassword')
    );

    togglePasswordVisibility(
      document.getElementById('toggleConfirmPassword'),
      document.getElementById('confirmPassword')
    );

    // Password confirmation validation
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    const confirmPasswordFeedback = document.getElementById(
      'confirmPasswordFeedback'
    );

    function validatePasswordMatch() {
      if (confirmPassword.value !== newPassword.value) {
        confirmPassword.setCustomValidity('Mật khẩu xác nhận không khớp');
        confirmPasswordFeedback.textContent =
          'Mật khẩu xác nhận không khớp với mật khẩu mới.';
        confirmPassword.classList.add('is-invalid');
      } else {
        confirmPassword.setCustomValidity('');
        confirmPasswordFeedback.textContent = 'Vui lòng xác nhận mật khẩu mới.';
        confirmPassword.classList.remove('is-invalid');
      }
    }

    newPassword.addEventListener('input', validatePasswordMatch);
    confirmPassword.addEventListener('input', validatePasswordMatch);

    // Form validation
    const form = document.querySelector('.needs-validation');
    form.addEventListener(
      'submit',
      function (event) {
        validatePasswordMatch();

        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      },
      false
    );

    // Auto-hide alerts
    const alerts = document.querySelectorAll('.auto-hide-alert');
    alerts.forEach(function (alert) {
      setTimeout(function () {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }, 5000);
    });

    // Password strength indicator
    newPassword.addEventListener('input', function () {
      const password = this.value;
      const updateBtn = document.getElementById('updatePasswordBtn');

      if (
        password.length >= 8 &&
        /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(password)
      ) {
        this.classList.remove('is-invalid');
        this.classList.add('is-valid');
      } else if (password.length > 0) {
        this.classList.remove('is-valid');
        if (password.length < 6) {
          this.classList.add('is-invalid');
        }
      }
    });
  });
</script>
