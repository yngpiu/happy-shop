<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="base" value="/admin/category" scope="request" />

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-tags me-2"></i>
      Quản lý loại sản phẩm
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item active">Loại sản phẩm</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="${base}/add" class="btn btn-success">
      <i class="bi bi-plus-circle me-2"></i>
      Thêm loại sản phẩm
    </a>
    <a href="${base}/trash" class="btn btn-outline-danger">
      <i class="bi bi-trash me-2"></i>
      Thùng rác <span class="badge bg-danger">${deletedCategories}</span>
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

<!-- Statistics Cards -->
<div class="row mb-4">
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-primary text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Tổng số loại</h6>
            <h3 class="mb-0">${totalCategories}</h3>
            <small class="text-white-50">loại sản phẩm</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-tags display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-success text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Đang hoạt động</h6>
            <h3 class="mb-0">${activeCategories}</h3>
            <small class="text-white-50">loại đang sử dụng</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-check-circle display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-info text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Có sản phẩm</h6>
            <h3 class="mb-0">${categoriesWithProducts}</h3>
            <small class="text-white-50">loại có sản phẩm</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-box display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-3 mb-3">
    <div class="card bg-warning text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Thùng rác</h6>
            <h3 class="mb-0">${deletedCategories}</h3>
            <small class="text-white-50">đã xóa tạm thời</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-trash display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Filter and View Options -->
<div class="card shadow-sm mb-3">
  <div class="card-body py-3">
    <div class="row align-items-center">
      <div class="col-12 col-md-6">
        <div class="d-flex align-items-center gap-3">
          <label class="form-label mb-0 fw-semibold">Hiển thị:</label>
          <div class="btn-group" role="group">
            <input type="radio" class="btn-check" name="statusFilter" id="activeFilter" value="active" checked>
            <label class="btn btn-outline-success btn-sm" for="activeFilter">
              <i class="bi bi-check-circle me-1"></i>Đang hoạt động (${activeCategories})
            </label>
            <input type="radio" class="btn-check" name="statusFilter" id="allFilter" value="all">
            <label class="btn btn-outline-primary btn-sm" for="allFilter">
              <i class="bi bi-list me-1"></i>Tất cả (${totalCategories})
            </label>
          </div>
        </div>
      </div>
      <div class="col-12 col-md-6 mt-2 mt-md-0">
        <div class="d-flex justify-content-md-end align-items-center gap-2">
          <div class="btn-group" role="group" aria-label="View options">
            <input type="radio" class="btn-check" name="viewType" id="tableView" autocomplete="off" checked>
            <label class="btn btn-outline-secondary btn-sm" for="tableView">
              <i class="bi bi-table"></i> Bảng
            </label>
            <input type="radio" class="btn-check" name="viewType" id="cardView" autocomplete="off">
            <label class="btn btn-outline-secondary btn-sm" for="cardView">
              <i class="bi bi-grid-3x3-gap"></i> Thẻ
            </label>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Category List Card -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center">
      <h5 class="card-title mb-2 mb-sm-0">
        <i class="bi bi-list-ul text-primary me-2"></i>
        Danh sách loại sản phẩm
      </h5>
      <div class="d-flex align-items-center gap-2">
        <span class="badge bg-primary" id="categoryCount">${list.size()} loại</span>
        <button class="btn btn-sm btn-outline-secondary" onclick="refreshData()">
          <i class="bi bi-arrow-clockwise"></i>
        </button>
      </div>
    </div>
  </div>
  
  <div class="card-body p-0">
    <c:choose>
      <c:when test="${empty list}">
        <div class="text-center py-5">
          <i class="bi bi-inbox display-1 text-muted"></i>
          <h4 class="text-muted mt-3">Chưa có loại sản phẩm nào</h4>
          <p class="text-muted">Hãy thêm loại sản phẩm đầu tiên của bạn</p>
          <a href="${base}/add" class="btn btn-primary">
            <i class="bi bi-plus-circle me-2"></i>
            Thêm loại sản phẩm
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <!-- Table View -->
        <div id="tableViewContainer" class="table-responsive">
          <table class="table table-hover mb-0" id="dataTable">
            <thead class="table-light">
              <tr>
                <th width="10%" class="text-center">ID</th>
                <th width="35%">Tên loại sản phẩm</th>
                <th width="15%" class="text-center">Số sản phẩm</th>
                <th width="15%" class="text-center">Ngày tạo</th>
                <th width="10%" class="text-center">Trạng thái</th>
                <th width="15%" class="text-center">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="category" items="${list}">
                <tr data-category-id="${category.id}" data-status="${category.deletedAt != null ? 'deleted' : 'active'}">
                  <td class="text-center">
                    <span class="badge bg-light text-dark fw-semibold">#${category.id}</span>
                  </td>
                  <td>
                    <div class="d-flex align-items-center">
                      <c:if test="${category.deletedAt != null}">
                        <i class="bi bi-trash text-muted me-2"></i>
                      </c:if>
                      <div>
                        <div class="fw-semibold ${category.deletedAt != null ? 'text-muted text-decoration-line-through' : 'text-primary'}">
                          ${category.name}
                        </div>
                        <c:if test="${category.deletedAt != null}">
                          <small class="text-danger">
                            <i class="bi bi-clock me-1"></i>
                            Xóa ngày: <fmt:formatDate value="${category.deletedAt}" pattern="dd/MM/yyyy HH:mm"/>
                          </small>
                        </c:if>
                      </div>
                    </div>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${productCounts[category.id] > 0}">
                        <span class="badge bg-info">${productCounts[category.id]} sản phẩm</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-light text-muted">0 sản phẩm</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <small class="text-muted">
                      <fmt:formatDate value="${category.createdAt}" pattern="dd/MM/yyyy"/>
                    </small>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${category.deletedAt != null}">
                        <span class="badge bg-danger">
                          <i class="bi bi-trash me-1"></i>Đã xóa
                        </span>
                      </c:when>
                      <c:when test="${productCounts[category.id] > 0}">
                        <span class="badge bg-success">
                          <i class="bi bi-check-circle me-1"></i>Có sản phẩm
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-warning">
                          <i class="bi bi-exclamation-triangle me-1"></i>Trống
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${category.deletedAt != null}">
                        <!-- Trashed item actions -->
                        <div class="btn-group" role="group">
                          <button type="button" class="btn btn-sm btn-outline-success restore-btn" 
                                  data-id="${category.id}"
                                  data-name="${category.name}"
                                  title="Khôi phục">
                            <i class="bi bi-arrow-clockwise"></i>
                          </button>
                          <button type="button" class="btn btn-sm btn-outline-danger permanent-delete-btn" 
                                  data-id="${category.id}"
                                  data-name="${category.name}"
                                  title="Xóa vĩnh viễn">
                            <i class="bi bi-x-circle"></i>
                          </button>
                        </div>
                      </c:when>
                      <c:otherwise>
                        <!-- Active item actions -->
                        <div class="btn-group" role="group">
                          <a href="${base}/edit/${category.id}" 
                             class="btn btn-sm btn-outline-primary" 
                             title="Chỉnh sửa">
                            <i class="bi bi-pencil"></i>
                          </a>
                          <button type="button" 
                                  class="btn btn-sm btn-outline-danger move-to-trash-btn" 
                                  data-id="${category.id}"
                                  data-name="${category.name}"
                                  data-product-count="${productCounts[category.id] != null ? productCounts[category.id] : 0}"
                                  title="Chuyển vào thùng rác">
                            <i class="bi bi-trash"></i>
                          </button>
                        </div>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- Card View -->
        <div id="cardViewContainer" class="p-3" style="display: none;">
          <div class="row">
            <c:forEach var="category" items="${list}">
              <div class="col-12 col-md-6 col-lg-4 mb-3" data-category-id="${category.id}" data-status="${category.deletedAt != null ? 'deleted' : 'active'}">
                <div class="card h-100 border-0 shadow-sm ${category.deletedAt != null ? 'bg-light' : ''}">
                  <div class="card-body">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                      <div class="flex-grow-1">
                        <div class="d-flex align-items-center mb-2">
                          <c:if test="${category.deletedAt != null}">
                            <i class="bi bi-trash text-muted me-2"></i>
                          </c:if>
                          <h6 class="card-title mb-0 ${category.deletedAt != null ? 'text-muted text-decoration-line-through' : 'text-primary'}">
                            ${category.name}
                          </h6>
                        </div>
                        <small class="text-muted">ID: #${category.id}</small>
                        <c:if test="${category.deletedAt != null}">
                          <br><small class="text-danger">
                            <i class="bi bi-clock me-1"></i>
                            Xóa: <fmt:formatDate value="${category.deletedAt}" pattern="dd/MM/yyyy"/>
                          </small>
                        </c:if>
                      </div>
                      <c:choose>
                        <c:when test="${category.deletedAt != null}">
                          <span class="badge bg-danger">Đã xóa</span>
                        </c:when>
                        <c:when test="${productCounts[category.id] > 0}">
                          <span class="badge bg-success">Có SP</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-warning">Trống</span>
                        </c:otherwise>
                      </c:choose>
                    </div>
                    
                    <c:if test="${productCounts[category.id] > 0}">
                      <div class="mb-3">
                        <small class="text-info">
                          <i class="bi bi-box me-1"></i>${productCounts[category.id]} sản phẩm
                        </small>
                      </div>
                    </c:if>
                    
                    <div class="d-flex justify-content-between">
                      <c:choose>
                        <c:when test="${category.deletedAt != null}">
                          <button class="btn btn-sm btn-outline-success restore-btn"
                                  data-id="${category.id}"
                                  data-name="${category.name}">
                            <i class="bi bi-arrow-clockwise me-1"></i>Khôi phục
                          </button>
                          <button class="btn btn-sm btn-outline-danger permanent-delete-btn"
                                  data-id="${category.id}"
                                  data-name="${category.name}">
                            <i class="bi bi-x-circle me-1"></i>Xóa vĩnh viễn
                          </button>
                        </c:when>
                        <c:otherwise>
                          <a href="${base}/edit/${category.id}" class="btn btn-sm btn-outline-primary">
                            <i class="bi bi-pencil me-1"></i>Sửa
                          </a>
                          <button class="btn btn-sm btn-outline-danger move-to-trash-btn"
                                  data-id="${category.id}"
                                  data-name="${category.name}"
                                  data-product-count="${productCounts[category.id] != null ? productCounts[category.id] : 0}">
                            <i class="bi bi-trash me-1"></i>Xóa
                          </button>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<!-- Move to Trash Modal -->
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
          <i class="bi bi-trash display-4 text-warning"></i>
        </div>
        <p class="text-center">Bạn có muốn chuyển loại sản phẩm <strong id="trashCategoryName"></strong> vào thùng rác?</p>
        <div class="alert alert-info">
          <i class="bi bi-info-circle me-1"></i>
          <strong>Lưu ý:</strong> Loại sản phẩm sẽ được lưu trong thùng rác 30 ngày và có thể khôi phục. Sau 30 ngày sẽ bị xóa vĩnh viễn.
        </div>
        <div id="productWarning" class="alert alert-warning" style="display: none;">
          <i class="bi bi-exclamation-triangle me-1"></i>
          <strong>Cảnh báo:</strong> Loại này đang có <span id="productCount"></span> sản phẩm. Các sản phẩm sẽ không bị ảnh hưởng.
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          <i class="bi bi-x-circle me-2"></i>Hủy
        </button>
        <a href="#" id="trashLink" class="btn btn-warning">
          <i class="bi bi-trash me-2"></i>Chuyển vào thùng rác
        </a>
      </div>
    </div>
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
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="text-center mb-3">
          <i class="bi bi-arrow-clockwise display-4 text-success"></i>
        </div>
        <p class="text-center">Bạn có muốn khôi phục loại sản phẩm <strong id="restoreCategoryName"></strong>?</p>
        <div class="alert alert-success">
          <i class="bi bi-check-circle me-1"></i>
          Sau khi khôi phục, loại sản phẩm sẽ trở lại hoạt động bình thường.
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
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="text-center mb-3">
          <i class="bi bi-x-circle display-4 text-danger"></i>
        </div>
        <p class="text-center">Bạn có chắc chắn muốn xóa vĩnh viễn loại sản phẩm <strong id="permanentDeleteCategoryName"></strong>?</p>
        <div class="alert alert-danger">
          <i class="bi bi-exclamation-triangle me-1"></i>
          <strong>Cảnh báo:</strong> Hành động này không thể hoàn tác! Loại sản phẩm sẽ bị xóa khỏi hệ thống vĩnh viễn.
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

<script>
  // Event handlers using event delegation
  $(document).on('click', '.move-to-trash-btn', function() {
    const id = $(this).data('id');
    const name = $(this).data('name');
    const productCount = $(this).data('product-count');
    
    document.getElementById('trashCategoryName').textContent = name;
    document.getElementById('trashLink').href = '${base}/move-to-trash/' + id;
    
    const productWarning = document.getElementById('productWarning');
    if (productCount > 0) {
      document.getElementById('productCount').textContent = productCount;
      productWarning.style.display = 'block';
    } else {
      productWarning.style.display = 'none';
    }
    
    new bootstrap.Modal(document.getElementById('trashModal')).show();
  });

  $(document).on('click', '.restore-btn', function() {
    const id = $(this).data('id');
    const name = $(this).data('name');
    
    document.getElementById('restoreCategoryName').textContent = name;
    document.getElementById('restoreLink').href = '${base}/restore/' + id;
    new bootstrap.Modal(document.getElementById('restoreModal')).show();
  });

  $(document).on('click', '.permanent-delete-btn', function() {
    const id = $(this).data('id');
    const name = $(this).data('name');
    
    document.getElementById('permanentDeleteCategoryName').textContent = name;
    document.getElementById('permanentDeleteLink').href = '${base}/delete-permanent/' + id;
    new bootstrap.Modal(document.getElementById('permanentDeleteModal')).show();
  });

  function refreshData() {
    location.reload();
  }

  // Initialize DataTable with full functionality
  $(document).ready(function () {
    var table = $('#dataTable').DataTable({
      responsive: true,
      language: {
        url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json',
      },
      pageLength: 25,
      lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "Tất cả"]],
      order: [[0, 'asc']],
      columnDefs: [
        { orderable: false, targets: [5] }, // Disable sorting for action column
        { className: "text-center", targets: [0, 2, 3, 4, 5] }
      ],
      dom: '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>' +
           '<"row"<"col-sm-12"tr>>' +
           '<"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>',
      searching: true,
      paging: true,
      info: true,
      autoWidth: false
    });

    // Status filter functionality
    $('input[name="statusFilter"]').change(function() {
      const filterValue = $(this).val();
      
      if (filterValue === 'active') {
        // Show only active categories
        $('tr[data-status="deleted"]').hide();
        $('div[data-status="deleted"]').hide();
        $('#categoryCount').text($('tr[data-status="active"]').length + ' loại');
      } else {
        // Show all categories
        $('tr[data-status], div[data-status]').show();
        $('#categoryCount').text('${list.size()} loại');
      }
      
      table.draw();
    });

    // View toggle
    $('input[name="viewType"]').change(function () {
      if ($(this).attr('id') === 'tableView') {
        $('#tableViewContainer').show();
        $('#cardViewContainer').hide();
        // Redraw table to handle any layout issues
        table.columns.adjust().draw();
      } else {
        $('#tableViewContainer').hide();
        $('#cardViewContainer').show();
      }
    });

    // Initialize with active filter
    $('input[name="statusFilter"][value="active"]').trigger('change');
  });
</script>
