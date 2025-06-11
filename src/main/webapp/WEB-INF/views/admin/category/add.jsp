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
      <i class="bi bi-plus-circle me-2"></i>
      Thêm loại sản phẩm mới
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/category/index">Loại sản phẩm</a>
        </li>
        <li class="breadcrumb-item active">Thêm mới</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="/admin/category/index" class="btn btn-secondary">
      <i class="bi bi-arrow-left me-2"></i>
      Quay lại danh sách
    </a>
    <a href="/admin/category/index" class="btn btn-outline-primary">
      <i class="bi bi-list-ul me-2"></i>
      Xem tất cả
    </a>
  </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    ${message}${param.message}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}${param.error}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<!-- Main Content -->
<div class="row">
  <!-- Form Section -->
  <div class="col-12 col-lg-8">
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <h5 class="card-title mb-0">
          <i class="bi bi-tag text-success me-2"></i>
          Thông tin loại sản phẩm mới
        </h5>
      </div>
      <div class="card-body">
        <form:form
          action="${base}/create"
          modelAttribute="entity"
          method="post"
          class="needs-validation"
          novalidate="true"
          id="categoryForm"
        >
          <!-- Hidden ID field -->
          <form:hidden path="id" />

          <div class="row">
            <div class="col-12 mb-3">
              <label for="name" class="form-label fw-semibold">
                <i class="bi bi-tag me-1"></i>
                Tên loại sản phẩm <span class="text-danger">*</span>
              </label>
              <form:input
                path="name"
                class="form-control form-control-lg"
                id="name"
                placeholder="Nhập tên loại sản phẩm (ví dụ: Smartphone, Laptop, Tablet...)"
                required="true"
                minlength="2"
                maxlength="100"
                autofocus="true"
              />
              <div class="invalid-feedback">
                Tên loại sản phẩm phải từ 2-100 ký tự
              </div>
              <div class="form-text">
                <i class="bi bi-lightbulb me-1"></i>
                Sử dụng tên rõ ràng và dễ hiểu để phân loại sản phẩm hiệu quả
              </div>
            </div>

            <div class="col-12 mb-4">
              <label for="nameVN" class="form-label fw-semibold">
                <i class="bi bi-building me-1"></i>
                Tên hãng/Thương hiệu
                <span class="badge bg-light text-muted ms-2">Tùy chọn</span>
              </label>
              <form:input
                path="nameVN"
                class="form-control form-control-lg"
                id="nameVN"
                placeholder="Nhập tên hãng hoặc thương hiệu (ví dụ: Apple, Samsung, Dell...)"
                maxlength="100"
              />
              <div class="form-text">
                <i class="bi bi-info-circle me-1"></i>
                Thông tin này giúp phân loại chi tiết hơn, có thể để trống nếu
                không có thương hiệu cụ thể
              </div>
            </div>
          </div>

          <!-- Action Buttons -->
          <div
            class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center gap-3"
          >
            <div class="d-flex flex-wrap gap-2">
              <button type="submit" class="btn btn-success btn-lg">
                <i class="bi bi-plus-circle me-2"></i>
                Thêm loại sản phẩm
              </button>

              <a href="${base}/index" class="btn btn-secondary">
                <i class="bi bi-x-circle me-2"></i>
                Hủy bỏ
              </a>
            </div>

            <div class="d-flex gap-2">
              <button type="reset" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-clockwise me-2"></i>
                Đặt lại form
              </button>

              <button
                type="button"
                class="btn btn-outline-info"
                id="previewBtn"
              >
                <i class="bi bi-eye me-2"></i>
                Xem trước
              </button>
            </div>
          </div>
        </form:form>
      </div>
    </div>
  </div>

  <!-- Info & Help Section -->
  <div class="col-12 col-lg-4">
    <!-- Quick Stats -->
    <div class="card shadow-sm mb-4">
      <div class="card-header bg-primary text-white">
        <h6 class="card-title mb-0">
          <i class="bi bi-graph-up me-2"></i>
          Thống kê nhanh
        </h6>
      </div>
      <div class="card-body">
        <div class="row text-center">
          <div class="col-6">
            <div class="border-end">
              <h4 class="text-primary mb-1">${totalCategories}</h4>
              <small class="text-muted">Loại hiện có</small>
            </div>
          </div>
          <div class="col-6">
            <h4 class="text-success mb-1">${categoriesWithProducts}</h4>
            <small class="text-muted">Có sản phẩm</small>
          </div>
        </div>
        <hr />
        <div class="text-center">
          <p class="small text-muted mb-1">
            <i class="bi bi-plus-circle text-success me-1"></i>
            Bạn đang thêm loại sản phẩm thứ
            <strong>${totalCategories + 1}</strong>
          </p>
        </div>
      </div>
    </div>

    <!-- Preview Card -->
    <div class="card shadow-sm mb-4" id="previewCard" style="display: none">
      <div class="card-header bg-info text-white">
        <h6 class="card-title mb-0">
          <i class="bi bi-eye me-2"></i>
          Xem trước
        </h6>
      </div>
      <div class="card-body">
        <div class="mb-2">
          <small class="text-muted d-block">Tên loại sẽ hiển thị:</small>
          <strong id="previewName" class="text-primary">--</strong>
        </div>
        <div class="mb-2">
          <small class="text-muted d-block">Thương hiệu:</small>
          <span id="previewBrand" class="text-muted fst-italic"
            >Chưa có thông tin</span
          >
        </div>
        <div class="mb-0">
          <small class="text-muted d-block">Trạng thái:</small>
          <span class="badge bg-warning">
            <i class="bi bi-exclamation-triangle me-1"></i>Mới tạo
          </span>
        </div>
      </div>
    </div>

    <!-- Help Card -->
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <h6 class="card-title mb-0">
          <i class="bi bi-question-circle text-info me-2"></i>
          Hướng dẫn thêm loại sản phẩm
        </h6>
      </div>
      <div class="card-body">
        <div class="mb-3">
          <h6 class="text-primary">Bước 1: Đặt tên loại</h6>
          <ul class="small mb-0">
            <li>Tên phải từ 2-100 ký tự</li>
            <li>Sử dụng tên rõ ràng, dễ hiểu</li>
            <li>Ví dụ: "Smartphone", "Laptop Gaming"</li>
          </ul>
        </div>

        <div class="mb-3">
          <h6 class="text-primary">Bước 2: Thêm thương hiệu (tùy chọn)</h6>
          <ul class="small mb-0">
            <li>Giúp phân loại chi tiết hơn</li>
            <li>Hỗ trợ tìm kiếm sản phẩm</li>
            <li>Có thể để trống</li>
          </ul>
        </div>

        <div class="alert alert-success small mb-0">
          <i class="bi bi-check-circle me-1"></i>
          <strong>Mẹo:</strong> Sau khi thêm thành công, bạn sẽ được chuyển về
          trang danh sách để xem kết quả.
        </div>
      </div>
    </div>

    <!-- Examples Card -->
    <div class="card shadow-sm mt-4">
      <div class="card-header bg-light">
        <h6 class="card-title mb-0">
          <i class="bi bi-lightbulb text-warning me-2"></i>
          Ví dụ loại sản phẩm
        </h6>
      </div>
      <div class="card-body">
        <div class="mb-2">
          <strong class="text-primary">Điện tử:</strong>
          <small class="text-muted d-block"
            >Smartphone, Laptop, Tablet, Tai nghe</small
          >
        </div>
        <div class="mb-2">
          <strong class="text-primary">Thời trang:</strong>
          <small class="text-muted d-block">Áo, Quần, Giày dép, Phụ kiện</small>
        </div>
        <div class="mb-0">
          <strong class="text-primary">Gia dụng:</strong>
          <small class="text-muted d-block"
            >Tủ lạnh, Máy giặt, Lò vi sóng</small
          >
        </div>
      </div>
    </div>
  </div>
</div>

<script>
  // Enhanced form validation and UX
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

                // Focus on first invalid field
                var firstInvalid = form.querySelector(':invalid');
                if (firstInvalid) {
                  firstInvalid.focus();

                  // Scroll to invalid field
                  firstInvalid.scrollIntoView({
                    behavior: 'smooth',
                    block: 'center',
                  });
                }
              } else {
                // Show loading state
                var submitBtn = form.querySelector('button[type="submit"]');
                if (submitBtn) {
                  submitBtn.disabled = true;
                  submitBtn.innerHTML =
                    '<i class="bi bi-hourglass-split me-2"></i>Đang thêm...';
                }
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

  $(document).ready(function () {
    // Auto-focus first input
    $('#name').focus();

    // Real-time preview functionality
    function updatePreview() {
      var name = $('#name').val().trim();
      var brand = $('#nameVN').val().trim();

      $('#previewName').text(name || '--');
      $('#previewBrand').text(brand || 'Chưa có thông tin');

      if (brand) {
        $('#previewBrand')
          .removeClass('fst-italic')
          .addClass('fw-semibold text-info');
      } else {
        $('#previewBrand')
          .addClass('fst-italic')
          .removeClass('fw-semibold text-info');
      }
    }

    // Live preview updates
    $('#name, #nameVN').on('input', updatePreview);

    // Preview toggle
    $('#previewBtn').on('click', function () {
      $('#previewCard').slideToggle();
      updatePreview();

      var isVisible = $('#previewCard').is(':visible');
      $(this).html(
        isVisible
          ? '<i class="bi bi-eye-slash me-2"></i>Ẩn xem trước'
          : '<i class="bi bi-eye me-2"></i>Xem trước'
      );
    });

    // Real-time character counter
    $('#name').on('input', function () {
      var length = $(this).val().length;
      var maxLength = 100;
      var remaining = maxLength - length;

      if (remaining < 20) {
        var feedback = $(this).siblings('.invalid-feedback');
        if (remaining > 0) {
          feedback.text(`Còn lại ${remaining} ký tự`);
          feedback.removeClass('text-danger').addClass('text-warning');
        } else {
          feedback.text('Đã vượt quá giới hạn ký tự!');
          feedback.removeClass('text-warning').addClass('text-danger');
        }
      }
    });

    // Smart form reset with confirmation
    $('button[type="reset"]').on('click', function (e) {
      e.preventDefault();
      if (confirm('Bạn có chắc chắn muốn đặt lại tất cả thông tin đã nhập?')) {
        document.getElementById('categoryForm').reset();
        $('.was-validated').removeClass('was-validated');
        $('#previewCard').hide();
        $('#previewBtn').html('<i class="bi bi-eye me-2"></i>Xem trước');
        updatePreview();
        $('#name').focus();

        // Show success message
        showToast('Đã đặt lại form thành công!', 'info');
      }
    });

    // Auto-save to localStorage for recovery
    var saveTimer;
    $('#name, #nameVN').on('input', function () {
      clearTimeout(saveTimer);
      saveTimer = setTimeout(function () {
        var formData = {
          name: $('#name').val(),
          nameVN: $('#nameVN').val(),
          timestamp: new Date().getTime(),
        };
        localStorage.setItem('categoryFormDraft', JSON.stringify(formData));
      }, 1000);
    });

    // Load draft if exists
    var draft = localStorage.getItem('categoryFormDraft');
    if (draft) {
      try {
        var data = JSON.parse(draft);
        var timeDiff = new Date().getTime() - data.timestamp;

        // Only restore if draft is less than 1 hour old
        if (timeDiff < 3600000 && (data.name || data.nameVN)) {
          if (
            confirm('Phát hiện bản nháp đã lưu. Bạn có muốn khôi phục không?')
          ) {
            $('#name').val(data.name || '');
            $('#nameVN').val(data.nameVN || '');
            updatePreview();
          }
        }
      } catch (e) {
        localStorage.removeItem('categoryFormDraft');
      }
    }

    // Clear draft on successful submit
    $('#categoryForm').on('submit', function () {
      if (this.checkValidity()) {
        localStorage.removeItem('categoryFormDraft');
      }
    });

    // Simple toast notification function
    function showToast(message, type = 'info') {
      var toastHtml = `
        <div class="toast align-items-center text-white bg-${type} border-0" role="alert" style="position: fixed; top: 20px; right: 20px; z-index: 9999;">
          <div class="d-flex">
            <div class="toast-body">${message}</div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
          </div>
        </div>
      `;

      $('body').append(toastHtml);
      var toast = new bootstrap.Toast($('.toast').last());
      toast.show();

      setTimeout(() => $('.toast').last().remove(), 5000);
    }
  });
</script>
