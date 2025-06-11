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
      <i class="bi bi-pencil-square me-2"></i>
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
            <c:otherwise>Chỉnh sửa #${entity.id}</c:otherwise>
          </c:choose>
        </li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="/admin/category/index" class="btn btn-secondary">
      <i class="bi bi-arrow-left me-2"></i>
      Quay lại danh sách
    </a>
    <c:if test="${not empty entity.id}">
      <a href="/admin/category/add" class="btn btn-success">
        <i class="bi bi-plus-circle me-2"></i>
        Thêm mới
      </a>
    </c:if>
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
          <i class="bi bi-tag text-primary me-2"></i>
          Thông tin loại sản phẩm
        </h5>
      </div>
      <div class="card-body">
        <form:form
          action="${base}/update"
          modelAttribute="entity"
          method="post"
          class="needs-validation"
          novalidate="true"
          id="categoryForm"
        >
          <!-- Hidden ID field for edit mode -->
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
                placeholder="Nhập tên loại sản phẩm (ví dụ: Smartphone, Laptop...)"
                required="true"
                minlength="2"
                maxlength="100"
              />
              <div class="invalid-feedback">
                Tên loại sản phẩm phải từ 2-100 ký tự
              </div>
              <div class="form-text">
                Sử dụng tên rõ ràng và dễ hiểu để phân loại sản phẩm
              </div>
            </div>

            <div class="col-12 mb-4">
              <label for="nameVN" class="form-label fw-semibold">
                <i class="bi bi-building me-1"></i>
                Tên hãng/Thương hiệu
              </label>
              <form:input
                path="nameVN"
                class="form-control form-control-lg"
                id="nameVN"
                placeholder="Nhập tên hãng hoặc thương hiệu (ví dụ: Apple, Samsung...)"
                maxlength="100"
              />
              <div class="form-text">
                Thông tin này có thể để trống nếu không có thương hiệu cụ thể
              </div>
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center gap-3">
            <div class="d-flex flex-wrap gap-2">
              <c:choose>
                <c:when test="${empty entity.id}">
                  <!-- Add Mode -->
                  <button type="submit" formaction="${base}/create" class="btn btn-success btn-lg">
                    <i class="bi bi-plus-circle me-2"></i>
                    Thêm loại sản phẩm
                  </button>
                </c:when>
                <c:otherwise>
                  <!-- Edit Mode -->
                  <button type="submit" class="btn btn-primary btn-lg">
                    <i class="bi bi-check-circle me-2"></i>
                    Cập nhật thông tin
                  </button>
                  <c:if test="${empty productCounts[entity.id] || productCounts[entity.id] == 0}">
                    <button type="button" class="btn btn-danger" onclick="confirmDelete()">
                      <i class="bi bi-trash me-2"></i>
                      Xóa loại sản phẩm
                    </button>
                  </c:if>
                </c:otherwise>
              </c:choose>
              
              <a href="${base}/index" class="btn btn-secondary">
                <i class="bi bi-x-circle me-2"></i>
                Hủy bỏ
              </a>
            </div>

            <button type="reset" class="btn btn-outline-secondary">
              <i class="bi bi-arrow-clockwise me-2"></i>
              Đặt lại form
            </button>
          </div>
        </form:form>
      </div>
    </div>
  </div>

  <!-- Info & Help Section -->
  <div class="col-12 col-lg-4">
    <!-- Current Category Info (Edit Mode Only) -->
    <c:if test="${not empty entity.id}">
      <div class="card shadow-sm mb-4">
        <div class="card-header bg-info text-white">
          <h6 class="card-title mb-0">
            <i class="bi bi-info-circle me-2"></i>
            Thông tin hiện tại
          </h6>
        </div>
        <div class="card-body">
          <div class="mb-3">
            <small class="text-muted d-block">ID Loại sản phẩm</small>
            <span class="badge bg-primary">#${entity.id}</span>
          </div>
          
          <div class="mb-3">
            <small class="text-muted d-block">Tên hiện tại</small>
            <strong>${entity.name}</strong>
          </div>
          
          <c:if test="${not empty entity.nameVN}">
            <div class="mb-3">
              <small class="text-muted d-block">Thương hiệu</small>
              <strong>${entity.nameVN}</strong>
            </div>
          </c:if>
          
          <div class="mb-0">
            <small class="text-muted d-block">Số sản phẩm</small>
            <c:choose>
              <c:when test="${productCounts[entity.id] > 0}">
                <span class="badge bg-success">${productCounts[entity.id]} sản phẩm</span>
                <div class="mt-2">
                  <small class="text-warning">
                    <i class="bi bi-exclamation-triangle me-1"></i>
                    Không thể xóa do có sản phẩm
                  </small>
                </div>
              </c:when>
              <c:otherwise>
                <span class="badge bg-light text-muted">Chưa có sản phẩm</span>
                <div class="mt-2">
                  <small class="text-success">
                    <i class="bi bi-check-circle me-1"></i>
                    Có thể xóa loại này
                  </small>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </c:if>

    <!-- Help Card -->
    <div class="card shadow-sm">
      <div class="card-header bg-light">
        <h6 class="card-title mb-0">
          <i class="bi bi-lightbulb text-warning me-2"></i>
          Hướng dẫn và lưu ý
        </h6>
      </div>
      <div class="card-body">
        <h6 class="text-primary">Quy tắc đặt tên:</h6>
        <ul class="small mb-3">
          <li>Tên loại phải từ 2-100 ký tự</li>
          <li>Sử dụng tên rõ ràng, dễ hiểu</li>
          <li>Tránh sử dụng ký tự đặc biệt</li>
          <li>Nên viết hoa chữ cái đầu</li>
        </ul>
        
        <h6 class="text-primary">Về thương hiệu:</h6>
        <ul class="small mb-3">
          <li>Có thể để trống nếu không có</li>
          <li>Giúp phân loại chi tiết hơn</li>
          <li>Hỗ trợ tìm kiếm và lọc sản phẩm</li>
        </ul>

        <div class="alert alert-info mb-0">
          <small>
            <i class="bi bi-info-circle me-1"></i>
            <strong>Mẹo:</strong> Sau khi cập nhật thành công, bạn sẽ được chuyển về trang danh sách để xem kết quả.
          </small>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<c:if test="${not empty entity.id}">
  <div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-danger text-white">
          <h5 class="modal-title">
            <i class="bi bi-exclamation-triangle me-2"></i>
            Xác nhận xóa loại sản phẩm
          </h5>
          <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="text-center mb-3">
            <i class="bi bi-trash display-1 text-danger"></i>
          </div>
          <p class="text-center">
            Bạn có chắc chắn muốn xóa loại sản phẩm<br>
            <strong class="text-danger">"${entity.name}"</strong>?
          </p>
          <div class="alert alert-warning">
            <i class="bi bi-info-circle me-1"></i>
            <strong>Cảnh báo:</strong> Hành động này không thể hoàn tác và sẽ xóa vĩnh viễn loại sản phẩm này khỏi hệ thống.
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            <i class="bi bi-x-circle me-2"></i>
            Hủy bỏ
          </button>
          <a href="${base}/delete/${entity.id}" class="btn btn-danger">
            <i class="bi bi-trash me-2"></i>
            Xóa vĩnh viễn
          </a>
        </div>
      </div>
    </div>
  </div>
</c:if>

<script>
  // Enhanced form validation
  (function() {
    'use strict';
    
    window.addEventListener('load', function() {
      var forms = document.getElementsByClassName('needs-validation');
      var validation = Array.prototype.filter.call(forms, function(form) {
        form.addEventListener('submit', function(event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
            
            // Focus on first invalid field
            var firstInvalid = form.querySelector(':invalid');
            if (firstInvalid) {
              firstInvalid.focus();
            }
          } else {
            // Show loading state
            var submitBtn = form.querySelector('button[type="submit"]');
            if (submitBtn) {
              submitBtn.disabled = true;
              submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Đang xử lý...';
            }
          }
          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  })();

  // Delete confirmation with enhanced UX
  function confirmDelete() {
    var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
    modal.show();
  }

  // Auto-focus and enhanced UX
  $(document).ready(function() {
    // Auto-focus first input
    $('#name').focus();
    
    // Real-time character counter for name field
    $('#name').on('input', function() {
      var length = $(this).val().length;
      var maxLength = 100;
      var remaining = maxLength - length;
      
      if (remaining < 20) {
        $(this).next('.invalid-feedback').text(`Còn lại ${remaining} ký tự`);
      }
    });
    
    // Smart form reset
    $('button[type="reset"]').on('click', function(e) {
      e.preventDefault();
      if (confirm('Bạn có chắc chắn muốn đặt lại tất cả thông tin?')) {
        document.getElementById('categoryForm').reset();
        $('.was-validated').removeClass('was-validated');
        $('#name').focus();
      }
    });
    
    // Auto-save draft (optional enhancement)
    var saveTimer;
    $('#name, #nameVN').on('input', function() {
      clearTimeout(saveTimer);
      saveTimer = setTimeout(function() {
        // You could implement auto-save to localStorage here
        console.log('Auto-saving draft...');
      }, 2000);
    });
  });
</script>
