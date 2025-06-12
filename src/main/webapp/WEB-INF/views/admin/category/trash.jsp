<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>

<c:set var="base" value="/admin/category" scope="request" />

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-trash me-2"></i>
      Thùng rác - Loại sản phẩm
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item">
          <a href="/admin/category/index">Loại sản phẩm</a>
        </li>
        <li class="breadcrumb-item active">Thùng rác</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="/admin/category/index" class="btn btn-secondary">
      <i class="bi bi-arrow-left me-2"></i>
      Quay lại danh sách
    </a>
    <c:if test="${not empty trashedList}">
      <button class="btn btn-warning" onclick="emptyTrash()">
        <i class="bi bi-trash3 me-2"></i>
        Dọn sạch thùng rác
      </button>
    </c:if>
    <!-- Debug button to test JavaScript -->
    <button class="btn btn-info" onclick="testJavaScript()">
      <i class="bi bi-bug me-2"></i>
      Test JS
    </button>
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

<!-- Info Banner -->
<div class="alert alert-info mb-4">
  <div class="d-flex align-items-center">
    <i class="bi bi-info-circle me-2 fs-4"></i>
    <div>
      <h6 class="alert-heading mb-1">Thông tin về thùng rác</h6>
      <p class="mb-0">
        Các loại sản phẩm trong thùng rác sẽ được
        <strong>tự động xóa vĩnh viễn sau 30 ngày</strong>. Bạn có thể khôi phục
        hoặc xóa vĩnh viễn bất cứ lúc nào.
      </p>
    </div>
  </div>
</div>

<!-- Statistics Cards -->
<div class="row mb-4">
  <div class="col-12 col-md-4 mb-3">
    <div class="card bg-warning text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Trong thùng rác</h6>
            <h3 class="mb-0">${trashedList.size()}</h3>
            <small class="text-white-50">loại đã xóa</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-trash display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-4 mb-3">
    <div class="card bg-danger text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Sắp hết hạn</h6>
            <h3 class="mb-0">${expiringSoonCount}</h3>
            <small class="text-white-50">còn < 7 ngày</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-clock display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-4 mb-3">
    <div class="card bg-info text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Có thể khôi phục</h6>
            <h3 class="mb-0">${recoverableCount}</h3>
            <small class="text-white-50">còn thời gian</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-arrow-clockwise display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Trash Content -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <div
      class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center"
    >
      <h5 class="card-title mb-2 mb-sm-0">
        <i class="bi bi-trash text-warning me-2"></i>
        Danh sách loại sản phẩm đã xóa
      </h5>
      <div class="d-flex align-items-center gap-2">
        <span class="badge bg-warning">${trashedList.size()} loại</span>
        <button
          class="btn btn-sm btn-outline-secondary"
          onclick="refreshTrash()"
        >
          <i class="bi bi-arrow-clockwise"></i>
        </button>
      </div>
    </div>
  </div>

  <div class="card-body p-0">
    <c:choose>
      <c:when test="${empty trashedList}">
        <div class="text-center py-5">
          <i class="bi bi-trash display-1 text-muted"></i>
          <h4 class="text-muted mt-3">Thùng rác trống</h4>
          <p class="text-muted">Chưa có loại sản phẩm nào bị xóa</p>
          <a href="${base}/index" class="btn btn-primary">
            <i class="bi bi-arrow-left me-2"></i>
            Quay lại danh sách
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-responsive">
          <table class="table table-hover mb-0" id="trashTable">
            <thead class="table-light">
              <tr>
                <th width="10%" class="text-center">ID</th>
                <th width="30%">Tên loại sản phẩm</th>
                <th width="15%" class="text-center">Ngày xóa</th>
                <th width="15%" class="text-center">Còn lại</th>
                <th width="10%" class="text-center">Trạng thái</th>
                <th width="20%" class="text-center">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="category" items="${trashedList}">
                <c:set
                  var="daysLeft"
                  value="${30 - category.daysSinceDeleted}"
                />
                <tr class="${daysLeft <= 7 ? 'table-warning' : ''}">
                  <td class="text-center">
                    <span class="badge bg-light text-dark fw-semibold"
                      >#${category.id}</span
                    >
                  </td>
                  <td>
                    <div class="d-flex align-items-center">
                      <i class="bi bi-trash text-muted me-2"></i>
                      <div>
                        <div
                          class="fw-semibold text-muted text-decoration-line-through"
                        >
                          ${category.name}
                        </div>
                        <small class="text-danger">
                          <i class="bi bi-clock me-1"></i>
                          Xóa lúc:
                          <fmt:formatDate
                            value="${category.deletedAt}"
                            pattern="dd/MM/yyyy HH:mm"
                          />
                        </small>
                      </div>
                    </div>
                  </td>
                  <td class="text-center">
                    <small class="text-muted">
                      <fmt:formatDate
                        value="${category.deletedAt}"
                        pattern="dd/MM/yyyy"
                      />
                    </small>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${daysLeft <= 0}">
                        <span class="badge bg-danger">Hết hạn</span>
                      </c:when>
                      <c:when test="${daysLeft <= 7}">
                        <span class="badge bg-warning">${daysLeft} ngày</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-info">${daysLeft} ngày</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${daysLeft <= 0}">
                        <span class="badge bg-danger">
                          <i class="bi bi-exclamation-triangle me-1"></i>Hết hạn
                        </span>
                      </c:when>
                      <c:when test="${daysLeft <= 7}">
                        <span class="badge bg-warning">
                          <i class="bi bi-clock me-1"></i>Sắp hết hạn
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-info">
                          <i class="bi bi-trash me-1"></i>Trong thùng rác
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <div class="btn-group" role="group">
                      <c:if test="${daysLeft > 0}">
                        <button
                          type="button"
                          class="btn btn-sm btn-outline-success"
                          onclick="restoreCategory('${category.id}', '${category.name}')"
                          title="Khôi phục"
                        >
                          <i class="bi bi-arrow-clockwise"></i>
                        </button>
                      </c:if>
                      <button
                        type="button"
                        class="btn btn-sm btn-outline-danger"
                        onclick="permanentDelete('${category.id}', '${category.name}')"
                        title="Xóa vĩnh viễn"
                      >
                        <i class="bi bi-x-circle"></i>
                      </button>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<!-- Restore Modal -->
<div class="modal fade" id="restoreModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-success text-white">
        <h5 class="modal-title">
          <i class="bi bi-arrow-clockwise me-2"></i>
          Khôi phục loại sản phẩm
        </h5>
        <button
          type="button"
          class="btn-close btn-close-white"
          data-bs-dismiss="modal"
        ></button>
      </div>
      <div class="modal-body">
        <div class="text-center mb-3">
          <i class="bi bi-arrow-clockwise display-4 text-success"></i>
        </div>
        <p class="text-center">
          Bạn có muốn khôi phục loại sản phẩm
          <strong id="restoreCategoryName"></strong>?
        </p>
        <div class="alert alert-success">
          <i class="bi bi-check-circle me-1"></i>
          Sau khi khôi phục, loại sản phẩm sẽ trở lại hoạt động bình thường và
          có thể được sử dụng để phân loại sản phẩm.
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          <i class="bi bi-x-circle me-2"></i>Hủy
        </button>
        <a href="#" id="restoreLink" class="btn btn-success">
          <i class="bi bi-arrow-clockwise me-2"></i>Khôi phục
        </a>
      </div>
    </div>
  </div>
</div>

<!-- Permanent Delete Modal -->
<div class="modal fade" id="permanentDeleteModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title">
          <i class="bi bi-exclamation-triangle me-2"></i>
          Xóa vĩnh viễn
        </h5>
        <button
          type="button"
          class="btn-close btn-close-white"
          data-bs-dismiss="modal"
        ></button>
      </div>
      <div class="modal-body">
        <div class="text-center mb-3">
          <i class="bi bi-x-circle display-4 text-danger"></i>
        </div>
        <p class="text-center">
          Bạn có chắc chắn muốn xóa vĩnh viễn loại sản phẩm
          <strong id="permanentDeleteCategoryName"></strong>?
        </p>
        <div class="alert alert-danger">
          <i class="bi bi-exclamation-triangle me-1"></i>
          <strong>Cảnh báo:</strong> Hành động này không thể hoàn tác! Loại sản
          phẩm sẽ bị xóa khỏi hệ thống vĩnh viễn.
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          <i class="bi bi-x-circle me-2"></i>Hủy
        </button>
        <a href="#" id="permanentDeleteLink" class="btn btn-danger">
          <i class="bi bi-trash me-2"></i>Xóa vĩnh viễn
        </a>
      </div>
    </div>
  </div>
</div>

<!-- Empty Trash Modal -->
<div class="modal fade" id="emptyTrashModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header bg-danger text-white">
        <h5 class="modal-title">
          <i class="bi bi-trash3 me-2"></i>
          Dọn sạch thùng rác
        </h5>
        <button
          type="button"
          class="btn-close btn-close-white"
          data-bs-dismiss="modal"
        ></button>
      </div>
      <div class="modal-body">
        <div class="text-center mb-3">
          <i class="bi bi-trash3 display-4 text-danger"></i>
        </div>
        <p class="text-center">
          Bạn có chắc chắn muốn xóa vĩnh viễn
          <strong>tất cả ${trashedList.size()} loại sản phẩm</strong> trong
          thùng rác?
        </p>
        <div class="alert alert-danger">
          <i class="bi bi-exclamation-triangle me-1"></i>
          <strong>Cảnh báo:</strong> Hành động này không thể hoàn tác! Tất cả
          loại sản phẩm trong thùng rác sẽ bị xóa vĩnh viễn.
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          <i class="bi bi-x-circle me-2"></i>Hủy
        </button>
        <a href="/admin/category/empty-trash" class="btn btn-danger">
          <i class="bi bi-trash3 me-2"></i>Dọn sạch thùng rác
        </a>
      </div>
    </div>
  </div>
</div>

<script>
  // Define global functions immediately (no jQuery dependency)
  console.log('Trash page script loading...'); // Debug
  console.log(
    'Defining functions: restoreCategory, permanentDelete, emptyTrash, refreshTrash'
  ); // Debug

  // Test function to verify JavaScript is working
  function testJavaScript() {
    alert('JavaScript is working! Functions are defined.');
  }

  function restoreCategory(id, name) {
    console.log('restoreCategory called:', id, name); // Debug
    document.getElementById('restoreCategoryName').textContent = name;
    document.getElementById('restoreLink').href =
      '/admin/category/restore/' + id;
    new bootstrap.Modal(document.getElementById('restoreModal')).show();
  }

  function permanentDelete(id, name) {
    console.log('permanentDelete called:', id, name); // Debug
    document.getElementById('permanentDeleteCategoryName').textContent = name;
    document.getElementById('permanentDeleteLink').href =
      '/admin/category/delete-permanent/' + id;
    new bootstrap.Modal(document.getElementById('permanentDeleteModal')).show();
  }

  function emptyTrash() {
    new bootstrap.Modal(document.getElementById('emptyTrashModal')).show();
  }

  function refreshTrash() {
    location.reload();
  }

  // Wait for jQuery to be available for DataTable only
  $(document).ready(function () {
    // Initialize DataTable
    $('#trashTable').DataTable({
      responsive: true,
      language: {
        sProcessing: 'Đang xử lý...',
        sLengthMenu: 'Hiển thị _MENU_ mục',
        sZeroRecords: 'Không tìm thấy dữ liệu',
        sInfo: 'Hiển thị _START_ đến _END_ trong tổng số _TOTAL_ mục',
        sInfoEmpty: 'Hiển thị 0 đến 0 trong tổng số 0 mục',
        sInfoFiltered: '(được lọc từ _MAX_ mục)',
        sSearch: 'Tìm kiếm:',
        oPaginate: {
          sFirst: 'Đầu',
          sPrevious: 'Trước',
          sNext: 'Tiếp',
          sLast: 'Cuối',
        },
      },
      pageLength: 25,
      lengthMenu: [
        [10, 25, 50, -1],
        [10, 25, 50, 'Tất cả'],
      ],
      order: [[2, 'desc']], // Sort by delete date descending
      columnDefs: [
        { orderable: false, targets: [5] }, // Disable sorting for action column
        { className: 'text-center', targets: [0, 2, 3, 4, 5] },
      ],
      dom:
        '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
        '<"row"<"col-sm-12"tr>>' +
        '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
      searching: true,
      paging: true,
      info: true,
      autoWidth: false,
    });

    // Auto-refresh every 5 minutes to update remaining days
    setInterval(function () {
      location.reload();
    }, 300000); // 5 minutes
  });
</script>
