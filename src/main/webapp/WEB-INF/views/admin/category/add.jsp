<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<c:set var="base" value="/admin/category" scope="request" />

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <c:choose>
        <c:when test="${empty entity.id}">Thêm loại sản phẩm</c:when>
        <c:otherwise>Chỉnh sửa loại sản phẩm</c:otherwise>
      </c:choose>
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/category/index">Loại sản phẩm</a>
        </li>
        <li class="breadcrumb-item active">
          <c:choose>
            <c:when test="${empty entity.id}">Thêm mới</c:when>
            <c:otherwise>Chỉnh sửa</c:otherwise>
          </c:choose>
        </li>
      </ol>
    </nav>
  </div>
  <a href="/admin/category/index" class="btn btn-secondary">
    <i class="bi bi-arrow-left me-2"></i>
    Quay lại
  </a>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    ${message}${param.message}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<!-- Form Card -->
<div class="row justify-content-center">
  <div class="col-12 col-lg-8">
    <div class="card">
      <div class="card-header">
        <h5 class="card-title mb-0">
          <i class="bi bi-tag text-primary me-2"></i>
          Thông tin loại sản phẩm
        </h5>
      </div>
      <div class="card-body">
        <form:form
          action="${base}/create"
          modelAttribute="entity"
          method="post"
          class="needs-validation"
          novalidate="true"
        >
          <!-- Hidden ID field for edit mode -->
          <form:hidden path="id" />

          <div class="row">
            <div class="col-12 col-md-6 mb-3">
              <label for="name" class="form-label fw-semibold">
                <i class="bi bi-tag me-1"></i>
                Tên loại <span class="text-danger">*</span>
              </label>
              <form:input
                path="name"
                class="form-control"
                id="name"
                placeholder="Nhập tên loại sản phẩm"
                required="true"
                pattern=".{4,}"
                title="Tên loại phải từ 4 ký tự trở lên"
              />
              <div class="invalid-feedback">
                Tên loại phải từ 4 ký tự trở lên
              </div>
            </div>

            <div class="col-12 col-md-6 mb-3">
              <label for="nameVN" class="form-label fw-semibold">
                <i class="bi bi-building me-1"></i>
                Tên hãng
              </label>
              <form:input
                path="nameVN"
                class="form-control"
                id="nameVN"
                placeholder="Nhập tên hãng"
                pattern=".{4,}"
                title="Tên hãng phải từ 4 ký tự trở lên"
              />
              <div class="invalid-feedback">
                Tên hãng phải từ 4 ký tự trở lên
              </div>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="row">
            <div class="col-12">
              <div
                class="d-flex flex-column flex-sm-row justify-content-between"
              >
                <div class="mb-2 mb-sm-0">
                  <c:choose>
                    <c:when test="${empty entity.id}">
                      <!-- Add Mode -->
                      <button
                        type="submit"
                        class="btn btn-success me-2 mb-2 mb-sm-0"
                      >
                        <i class="bi bi-plus-circle me-2"></i>
                        Thêm loại sản phẩm
                      </button>
                    </c:when>
                    <c:otherwise>
                      <!-- Edit Mode -->
                      <button
                        type="submit"
                        formaction="${base}/update"
                        class="btn btn-primary me-2 mb-2 mb-sm-0"
                      >
                        <i class="bi bi-check-circle me-2"></i>
                        Cập nhật
                      </button>
                      <button
                        type="button"
                        class="btn btn-danger me-2 mb-2 mb-sm-0"
                        onclick="confirmDelete()"
                      >
                        <i class="bi bi-trash me-2"></i>
                        Xóa
                      </button>
                    </c:otherwise>
                  </c:choose>

                  <a
                    href="${base}/index"
                    class="btn btn-secondary mb-2 mb-sm-0"
                  >
                    <i class="bi bi-x-circle me-2"></i>
                    Hủy
                  </a>
                </div>

                <button type="reset" class="btn btn-outline-secondary">
                  <i class="bi bi-arrow-clockwise me-2"></i>
                  Làm mới
                </button>
              </div>
            </div>
          </div>
        </form:form>
      </div>
    </div>

    <!-- Help Card -->
    <div class="card mt-4">
      <div class="card-body">
        <h6 class="card-title">
          <i class="bi bi-info-circle text-info me-2"></i>
          Hướng dẫn
        </h6>
        <ul class="mb-0 small">
          <li>Tên loại và tên hãng phải có ít nhất 4 ký tự</li>
          <li>Tên loại là bắt buộc, tên hãng có thể để trống</li>
          <li>Sử dụng tên loại rõ ràng để dễ dàng quản lý sản phẩm</li>
        </ul>
      </div>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<c:if test="${not empty entity.id}">
  <div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">
            <i class="bi bi-exclamation-triangle text-warning me-2"></i>
            Xác nhận xóa
          </h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
          ></button>
        </div>
        <div class="modal-body">
          <p>
            Bạn có chắc chắn muốn xóa loại sản phẩm
            <strong>"${entity.name}"</strong>?
          </p>
          <p class="text-danger small">
            <i class="bi bi-info-circle me-1"></i>
            Hành động này không thể hoàn tác!
          </p>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-secondary"
            data-bs-dismiss="modal"
          >
            Hủy
          </button>
          <a href="${base}/delete/${entity.id}" class="btn btn-danger">
            <i class="bi bi-trash me-2"></i>
            Xóa
          </a>
        </div>
      </div>
    </div>
  </div>
</c:if>

<script>
  // Form validation
  (function () {
    'use strict';
    window.addEventListener(
      'load',
      function () {
        var forms = document.getElementsByClassName('needs-validation');
        var validation = Array.prototype.filter.call(forms, function (form) {
          form.addEventListener(
            'submit',
            function (event) {
              if (form.checkValidity() === false) {
                event.preventDefault();
                event.stopPropagation();
              }
              form.classList.add('was-validated');
            },
            false
          );
        });
      },
      false
    );
  })();

  // Delete confirmation
  function confirmDelete() {
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
  }

  // Auto-focus first input
  $(document).ready(function () {
    $('#name').focus();
  });
</script>
