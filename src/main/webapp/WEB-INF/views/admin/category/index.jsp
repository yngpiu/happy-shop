<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

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
  <a href="${base}/add" class="btn btn-success">
    <i class="bi bi-plus-circle me-2"></i>
    Thêm loại sản phẩm
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

<c:if test="${not empty error}">
  <div class="alert alert-danger alert-dismissible fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}${param.error}
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
  </div>
</c:if>

<!-- Statistics Cards -->
<div class="row mb-4">
  <div class="col-12 col-md-4 mb-3">
    <div class="card bg-primary text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Tổng số loại</h6>
            <h3 class="mb-0">${list.size()}</h3>
            <small class="text-white-50">loại sản phẩm</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-tags display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-4 mb-3">
    <div class="card bg-success text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Có sản phẩm</h6>
            <h3 class="mb-0">
              <c:set var="categoriesWithProducts" value="0" />
              <c:forEach var="category" items="${list}">
                <c:if test="${productCounts[category.id] > 0}">
                  <c:set
                    var="categoriesWithProducts"
                    value="${categoriesWithProducts + 1}"
                  />
                </c:if>
              </c:forEach>
              ${categoriesWithProducts}
            </h3>
            <small class="text-white-50">loại có sản phẩm</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-check-circle display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-12 col-md-4 mb-3">
    <div class="card bg-warning text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white-50 mb-1">Không có sản phẩm</h6>
            <h3 class="mb-0">
              <c:set var="categoriesWithoutProducts" value="0" />
              <c:forEach var="category" items="${list}">
                <c:if
                  test="${empty productCounts[category.id] || productCounts[category.id] == 0}"
                >
                  <c:set
                    var="categoriesWithoutProducts"
                    value="${categoriesWithoutProducts + 1}"
                  />
                </c:if>
              </c:forEach>
              ${categoriesWithoutProducts}
            </h3>
            <small class="text-white-50">loại trống</small>
          </div>
          <div class="text-white-50">
            <i class="bi bi-exclamation-triangle display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Category List Card -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <div
      class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center"
    >
      <h5 class="card-title mb-2 mb-sm-0">
        <i class="bi bi-list-ul text-primary me-2"></i>
        Danh sách loại sản phẩm
      </h5>
      <div class="d-flex align-items-center">
        <span class="badge bg-primary me-2">${list.size()} loại</span>
        <div class="btn-group" role="group" aria-label="View options">
          <input
            type="radio"
            class="btn-check"
            name="viewType"
            id="tableView"
            autocomplete="off"
            checked
          />
          <label class="btn btn-outline-secondary btn-sm" for="tableView">
            <i class="bi bi-table"></i>
          </label>
          <input
            type="radio"
            class="btn-check"
            name="viewType"
            id="cardView"
            autocomplete="off"
          />
          <label class="btn btn-outline-secondary btn-sm" for="cardView">
            <i class="bi bi-grid-3x3-gap"></i>
          </label>
        </div>
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
                <th width="8%" class="text-center">ID</th>
                <th width="25%">Tên loại</th>
                <th width="25%">Tên hãng</th>
                <th width="15%" class="text-center">Sản phẩm</th>
                <th width="12%" class="text-center">Trạng thái</th>
                <th width="15%" class="text-center">Thao tác</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="category" items="${list}">
                <tr>
                  <td class="text-center">
                    <span class="badge bg-light text-dark fw-semibold"
                      >#${category.id}</span
                    >
                  </td>
                  <td>
                    <div class="fw-semibold text-primary">${category.name}</div>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty category.nameVN}">
                        <span class="text-muted">${category.nameVN}</span>
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted fst-italic"
                          >Chưa có thông tin</span
                        >
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <c:choose>
                      <c:when test="${productCounts[category.id] > 0}">
                        <span class="badge bg-info"
                          >${productCounts[category.id]} sản phẩm</span
                        >
                      </c:when>
                      <c:otherwise>
                        <span class="badge bg-light text-muted"
                          >0 sản phẩm</span
                        >
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <c:choose>
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
                    <div class="btn-group" role="group">
                      <a
                        href="${base}/edit/${category.id}"
                        class="btn btn-sm btn-outline-primary"
                        title="Chỉnh sửa"
                      >
                        <i class="bi bi-pencil"></i>
                      </a>
                      <c:choose>
                        <c:when test="${productCounts[category.id] > 0}">
                          <button
                            type="button"
                            class="btn btn-sm btn-outline-secondary"
                            disabled
                            title="Không thể xóa do có sản phẩm"
                          >
                            <i class="bi bi-trash"></i>
                          </button>
                        </c:when>
                        <c:otherwise>
                          <button
                            type="button"
                            class="btn btn-sm btn-outline-danger"
                            onclick="confirmDelete('${category.id}', '${category.name}')"
                            title="Xóa"
                          >
                            <i class="bi bi-trash"></i>
                          </button>
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- Card View -->
        <div id="cardViewContainer" class="p-3" style="display: none">
          <div class="row">
            <c:forEach var="category" items="${list}">
              <div class="col-12 col-md-6 col-lg-4 mb-3">
                <div class="card h-100 border-0 shadow-sm">
                  <div class="card-body">
                    <div
                      class="d-flex justify-content-between align-items-start mb-3"
                    >
                      <div>
                        <h6 class="card-title text-primary mb-1">
                          ${category.name}
                        </h6>
                        <p class="card-text text-muted small mb-1">
                          <c:choose>
                            <c:when test="${not empty category.nameVN}">
                              <i class="bi bi-building me-1"></i
                              >${category.nameVN}
                            </c:when>
                            <c:otherwise>
                              <i class="bi bi-building me-1"></i>Chưa có thông
                              tin hãng
                            </c:otherwise>
                          </c:choose>
                        </p>
                        <small class="text-muted">ID: #${category.id}</small>
                      </div>
                      <c:choose>
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
                          <i class="bi bi-box me-1"></i
                          >${productCounts[category.id]} sản phẩm
                        </small>
                      </div>
                    </c:if>

                    <div class="d-flex justify-content-between">
                      <a
                        href="${base}/edit/${category.id}"
                        class="btn btn-sm btn-outline-primary"
                      >
                        <i class="bi bi-pencil me-1"></i>Sửa
                      </a>
                      <c:choose>
                        <c:when test="${productCounts[category.id] > 0}">
                          <button
                            class="btn btn-sm btn-outline-secondary"
                            disabled
                            title="Không thể xóa do có sản phẩm"
                          >
                            <i class="bi bi-trash me-1"></i>Xóa
                          </button>
                        </c:when>
                        <c:otherwise>
                          <button
                            class="btn btn-sm btn-outline-danger"
                            onclick="confirmDelete('${category.id}', '${category.name}')"
                          >
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

<!-- Delete Confirmation Modal -->
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
          <strong id="categoryName"></strong>?
        </p>
        <div class="alert alert-warning">
          <i class="bi bi-info-circle me-1"></i>
          <strong>Lưu ý:</strong> Hành động này không thể hoàn tác!
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          <i class="bi bi-x-circle me-2"></i>Hủy
        </button>
        <a href="#" id="deleteLink" class="btn btn-danger">
          <i class="bi bi-trash me-2"></i>Xác nhận xóa
        </a>
      </div>
    </div>
  </div>
</div>

<script>
  function confirmDelete(id, name) {
    document.getElementById('categoryName').textContent = name;
    document.getElementById('deleteLink').href = '${base}/delete/' + id;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
  }

  // Initialize DataTable with full functionality
  $(document).ready(function () {
    var table = $('#dataTable').DataTable({
      responsive: true,
      language: {
        url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json',
      },
      pageLength: 25,
      lengthMenu: [
        [10, 25, 50, -1],
        [10, 25, 50, 'Tất cả'],
      ],
      order: [[0, 'asc']],
      columnDefs: [
        { orderable: false, targets: [5] }, // Disable sorting for action column
        { className: 'text-center', targets: [0, 3, 4, 5] },
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

    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(
      document.querySelectorAll('[data-bs-toggle="tooltip"]')
    );
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl);
    });
  });
</script>
