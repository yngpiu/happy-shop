<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-person-gear me-2"></i>
      Thông tin cá nhân
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item active">Hồ sơ cá nhân</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="/admin/change" class="btn btn-outline-warning">
      <i class="bi bi-key me-2"></i>
      Đổi mật khẩu
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

<!-- Profile Form -->
<div class="row">
  <div class="col-12 col-lg-8">
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <h5 class="card-title mb-0">
          <i class="bi bi-person-lines-fill text-primary me-2"></i>
          Cập nhật thông tin cá nhân
        </h5>
      </div>
      <div class="card-body">
        <form:form
          action="/admin/profile"
          modelAttribute="form"
          enctype="multipart/form-data"
          class="needs-validation"
          novalidate="true"
        >
          <div class="row">
            <!-- Username (readonly) -->
            <div class="col-12 col-md-6 mb-3">
              <label for="id" class="form-label fw-semibold">
                <i class="bi bi-person-circle me-1"></i>
                Tên đăng nhập
              </label>
              <form:input
                path="id"
                class="form-control"
                id="id"
                readonly="true"
                style="background-color: #f8f9fa"
              />
              <div class="form-text">
                <i class="bi bi-info-circle me-1"></i>
                Tên đăng nhập không thể thay đổi.
              </div>
            </div>

            <!-- Full Name -->
            <div class="col-12 col-md-6 mb-3">
              <label for="fullname" class="form-label fw-semibold">
                <i class="bi bi-person me-1"></i>
                Họ và tên <span class="text-danger">*</span>
              </label>
              <form:input
                path="fullname"
                class="form-control"
                id="fullname"
                required="true"
                minlength="6"
                maxlength="100"
                placeholder="Nhập họ và tên đầy đủ"
              />
              <div class="invalid-feedback">
                Vui lòng nhập họ và tên (ít nhất 6 ký tự).
              </div>
            </div>

            <!-- Phone -->
            <div class="col-12 col-md-6 mb-3">
              <label for="telephone" class="form-label fw-semibold">
                <i class="bi bi-phone me-1"></i>
                Số điện thoại <span class="text-danger">*</span>
              </label>
              <form:input
                path="telephone"
                class="form-control"
                id="telephone"
                required="true"
                pattern="[0-9]{10,11}"
                placeholder="Nhập số điện thoại"
              />
              <div class="invalid-feedback">
                Vui lòng nhập số điện thoại hợp lệ (10-11 chữ số).
              </div>
            </div>

            <!-- Email -->
            <div class="col-12 col-md-6 mb-3">
              <label for="email" class="form-label fw-semibold">
                <i class="bi bi-envelope me-1"></i>
                Email <span class="text-danger">*</span>
              </label>
              <form:input
                path="email"
                type="email"
                class="form-control"
                id="email"
                required="true"
                placeholder="Nhập địa chỉ email"
              />
              <div class="invalid-feedback">
                Vui lòng nhập địa chỉ email hợp lệ.
              </div>
            </div>

            <!-- Photo Upload -->
            <div class="col-12 mb-4">
              <label class="form-label fw-semibold">
                <i class="bi bi-image me-1"></i>
                Ảnh đại diện
              </label>
              <div class="row align-items-center">
                <div class="col-auto">
                  <img
                    src="/static/images/customers/${form.photo}"
                    id="photoPreview"
                    class="rounded-circle border"
                    style="width: 80px; height: 80px; object-fit: cover"
                    onerror="this.src='/static/images/customers/user.png'"
                  />
                </div>
                <div class="col">
                  <input
                    type="file"
                    name="photo_file"
                    class="form-control"
                    id="photoFile"
                    accept="image/*"
                  />
                  <form:hidden path="photo" />
                  <div class="form-text">
                    <i class="bi bi-info-circle me-1"></i>
                    Chọn ảnh định dạng JPG, PNG (tối đa 2MB).
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Hidden fields -->
          <form:hidden path="password" />
          <form:hidden path="activated" />
          <form:hidden path="admin" />

          <!-- Submit Button -->
          <div class="d-flex justify-content-end gap-2">
            <a href="/admin/home/index" class="btn btn-outline-secondary">
              <i class="bi bi-x-circle me-2"></i>
              Hủy bỏ
            </a>
            <button type="submit" class="btn btn-success">
              <i class="bi bi-check-circle me-2"></i>
              Cập nhật thông tin
            </button>
          </div>
        </form:form>
      </div>
    </div>
  </div>

  <!-- Info Panel -->
  <div class="col-12 col-lg-4">
    <!-- Account Info -->
    <div class="card shadow-sm mb-3">
      <div class="card-header bg-primary text-white">
        <h6 class="card-title mb-0">
          <i class="bi bi-info-circle me-2"></i>
          Thông tin tài khoản
        </h6>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <label class="fw-semibold">Tên đăng nhập:</label>
          <p class="mb-0 text-primary fw-bold">${form.id}</p>
        </div>
        <div class="mb-3">
          <label class="fw-semibold">Vai trò:</label>
          <p class="mb-0">
            <c:choose>
              <c:when test="${form.admin}">
                <span class="badge bg-warning">
                  <i class="bi bi-shield-check me-1"></i>Quản trị viên
                </span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-info">
                  <i class="bi bi-person me-1"></i>Người dùng
                </span>
              </c:otherwise>
            </c:choose>
          </p>
        </div>
        <div class="mb-3">
          <label class="fw-semibold">Trạng thái:</label>
          <p class="mb-0">
            <c:choose>
              <c:when test="${form.activated}">
                <span class="badge bg-success">
                  <i class="bi bi-check-circle me-1"></i>Đang hoạt động
                </span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-danger">
                  <i class="bi bi-x-circle me-1"></i>Chưa kích hoạt
                </span>
              </c:otherwise>
            </c:choose>
          </p>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <h6 class="card-title mb-0">
          <i class="bi bi-lightning-charge text-warning me-2"></i>
          Thao tác nhanh
        </h6>
      </div>
      <div class="card-body">
        <div class="d-grid gap-2">
          <a href="/admin/change" class="btn btn-outline-warning btn-sm">
            <i class="bi bi-key me-2"></i>
            Đổi mật khẩu
          </a>
          <a href="/admin/home/index" class="btn btn-outline-primary btn-sm">
            <i class="bi bi-speedometer2 me-2"></i>
            Về Dashboard
          </a>
          <a href="/admin/logout" class="btn btn-outline-danger btn-sm">
            <i class="bi bi-box-arrow-right me-2"></i>
            Đăng xuất
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- JavaScript for Photo Preview -->
<script>
  document.addEventListener('DOMContentLoaded', function () {
    // Photo preview
    const photoFile = document.getElementById('photoFile');
    const photoPreview = document.getElementById('photoPreview');

    if (photoFile) {
      photoFile.addEventListener('change', function (e) {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function (e) {
            photoPreview.src = e.target.result;
          };
          reader.readAsDataURL(file);
        }
      });
    }

    // Form validation
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(function (form) {
      form.addEventListener(
        'submit',
        function (event) {
          if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
          }
          form.classList.add('was-validated');
        },
        false
      );
    });

    // Auto-hide alerts
    const alerts = document.querySelectorAll('.auto-hide-alert');
    alerts.forEach(function (alert) {
      setTimeout(function () {
        const bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
      }, 5000);
    });
  });
</script>
