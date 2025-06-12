<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

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
            <div class="col-12 mb-4">
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
                    <button type="button" class="btn btn-warning" onclick="moveToTrash()">
                      <i class="bi bi-trash me-2"></i>
                      Chuyển vào thùng rác
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
          
          <c:if test="${not empty entity.createdAt}">
            <div class="mb-3">
              <small class="text-muted d-block">Ngày tạo</small>
              <strong><fmt:formatDate value="${entity.createdAt}" pattern="dd/MM/yyyy HH:mm"/></strong>
            </div>
          </c:if>
          
          <c:if test="${not empty entity.updatedAt}">
            <div class="mb-3">
              <small class="text-muted d-block">Cập nhật lần cuối</small>
              <strong><fmt:formatDate value="${entity.updatedAt}" pattern="dd/MM/yyyy HH:mm"/></strong>
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
                    Không thể xóa vĩnh viễn do có sản phẩm
                  </small>
                </div>
              </c:when>
              <c:otherwise>
                <span class="badge bg-light text-muted">Chưa có sản phẩm</span>
                <div class="mt-2">
                  <small class="text-success">
                    <i class="bi bi-check-circle me-1"></i>
                    Có thể chuyển vào thùng rác
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
        
        <h6 class="text-primary">Về việc xóa:</h6>
        <ul class="small mb-3">
          <li>Xóa sẽ chuyển vào thùng rác 30 ngày</li>
          <li>Có thể khôi phục trong 30 ngày</li>
          <li>Sau 30 ngày sẽ xóa vĩnh viễn tự động</li>
          <li>Loại có sản phẩm không thể xóa</li>
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

<!-- Move to Trash Confirmation Modal -->
<c:if test="${not empty entity.id}">
  <div class="modal fade" id="trashModal" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header bg-warning text-dark">
          <h5 class="modal-title">
            <i class="bi bi-trash me-2"></i>
            Chuyển vào thùng rác
          </h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <div class="text-center mb-3">
            <i class="bi bi-trash display-1 text-warning"></i>
          </div>
          <p class="text-center">
            Bạn có muốn chuyển loại sản phẩm<br>
            <strong class="text-warning">"${entity.name}"</strong> vào thùng rác?
          </p>
          <div class="alert alert-info">
            <i class="bi bi-info-circle me-1"></i>
            <strong>Lưu ý:</strong> Loại sản phẩm sẽ được lưu trong thùng rác 30 ngày và có thể khôi phục. Sau 30 ngày sẽ bị xóa vĩnh viễn tự động.
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            <i class="bi bi-x-circle me-2"></i>
            Hủy bỏ
          </button>
          <form action="${base}/delete/${entity.id}" method="post" style="display: inline;">
            <button type="submit" class="btn btn-warning">
              <i class="bi bi-trash me-2"></i>
              Chuyển vào thùng rác
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</c:if>

<script>
  // ========== XÁC THỰC FORM NÂNG CAO ==========
  (function() {
    'use strict';
    
    window.addEventListener('load', function() {
      // Lấy tất cả form cần validate
      var forms = document.getElementsByClassName('needs-validation');
      
      // Áp dụng validation cho từng form
      var validation = Array.prototype.filter.call(forms, function(form) {
        form.addEventListener('submit', function(event) {
          if (form.checkValidity() === false) {
            // Form không hợp lệ - ngăn submit
            event.preventDefault();
            event.stopPropagation();
            
            // Focus vào field đầu tiên bị lỗi
            var firstInvalid = form.querySelector(':invalid');
            if (firstInvalid) {
              firstInvalid.focus();
            }
          } else {
            // Form hợp lệ - hiển thị trạng thái loading
            var submitBtn = form.querySelector('button[type="submit"]');
            if (submitBtn) {
              submitBtn.disabled = true;
              submitBtn.innerHTML = '<i class="bi bi-hourglass-split me-2"></i>Đang xử lý...';
            }
          }
          // Thêm class để hiển thị validation feedback
          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  })();

  // ========== XÁC NHẬN CHUYỂN VÀO THÙNG RÁC ==========
  /**
   * Hiển thị modal xác nhận chuyển category vào thùng rác
   */
  function moveToTrash() {
    new bootstrap.Modal(document.getElementById('trashModal')).show();
  }

  // ========== TÍNH NĂNG UX NÂNG CAO ==========
  $(document).ready(function() {
    // ========== TỰ ĐỘNG FOCUS INPUT ĐẦU TIÊN ==========
    $('#name').focus();
    
    // ========== ĐẾM KÝ TỰ THỜI GIAN THỰC ==========
    $('#name').on('input', function() {
      var length = $(this).val().length;
      var maxLength = 100;
      var remaining = maxLength - length;
      
      // Hiển thị cảnh báo khi còn ít ký tự
      if (remaining < 20) {
        $(this).next('.invalid-feedback').text(`Còn lại ${remaining} ký tự`);
      }
    });
    
    // ========== XÁC NHẬN RESET FORM ==========
    $('button[type="reset"]').on('click', function(e) {
      e.preventDefault();
      
      // Xác nhận trước khi reset
      if (confirm('Bạn có chắc chắn muốn đặt lại tất cả thông tin?')) {
        document.getElementById('categoryForm').reset();
        $('.was-validated').removeClass('was-validated');
        $('#name').focus();
      }
    });
    
    // ========== NGĂN THOÁT TRANG KHI CÓ THAY ĐỔI ==========
    var formChanged = false;
    
    // Theo dõi thay đổi trong form
    $('#name').on('input', function() {
      formChanged = true;
    });
    
    // Cảnh báo khi thoát trang có thay đổi chưa lưu
    $(window).on('beforeunload', function() {
      if (formChanged) {
        return 'Bạn có những thay đổi chưa được lưu. Bạn có chắc chắn muốn rời khỏi trang?';
      }
    });
    
    // Reset trạng thái khi submit form thành công
    $('#categoryForm').on('submit', function() {
      formChanged = false;
    });
    
    // ========== DEBUG CONSOLE ==========
    console.log('Category Edit Page - JavaScript initialized successfully');
  });
</script>
