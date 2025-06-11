<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<c:set var="base" value="/admin/category" scope="request" />

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">Quản lý loại sản phẩm</h2>
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

<!-- Category List Card -->
<div class="card">
  <div class="card-header">
    <div
      class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center"
    >
      <h5 class="card-title mb-2 mb-sm-0">
        <i class="bi bi-tags text-primary me-2"></i>
        Danh sách loại sản phẩm
      </h5>
      <span class="badge bg-primary">${list.size()} loại</span>
    </div>
  </div>
  <div class="card-body">
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
        <!-- Mobile View (Cards) -->
        <div class="d-block d-md-none">
          <c:forEach var="category" items="${list}">
            <div class="card mb-3">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-start">
                  <div>
                    <h6 class="card-title">${category.name}</h6>
                    <p class="card-text text-muted mb-1">${category.nameVN}</p>
                                                            <small class="text-muted">ID: #${category.id}</small>
                                        <c:if test="${productCounts[category.id] > 0}">
                                            <br><small class="text-info">${productCounts[category.id]} sản phẩm</small>
                                        </c:if>
                  </div>
                  <div class="dropdown">
                    <button
                      class="btn btn-sm btn-outline-secondary"
                      type="button"
                      data-bs-toggle="dropdown"
                    >
                      <i class="bi bi-three-dots-vertical"></i>
                    </button>
                    <ul class="dropdown-menu">
                      <li>
                        <a
                          class="dropdown-item"
                          href="${base}/edit/${category.id}"
                        >
                          <i class="bi bi-pencil me-2"></i>Chỉnh sửa
                        </a>
                      </li>
                      <li>
                        <a
                          class="dropdown-item text-danger"
                          href="#"
                          onclick="confirmDelete('${category.id}', '${category.name}')"
                        >
                          <i class="bi bi-trash me-2"></i>Xóa
                        </a>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </c:forEach>
        </div>

        <!-- Desktop View (Table) -->
        <div class="d-none d-md-block">
          <div class="table-responsive">
            <table class="table table-hover" id="dataTable">
              <thead>
                <tr>
                  <th width="10%">ID</th>
                  <th width="35%">Tên loại</th>
                  <th width="35%">Tên hãng</th>
                  <th width="20%" class="text-center">Thao tác</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="category" items="${list}">
                  <tr>
                    <td>
                      <span class="badge bg-light text-dark"
                        >#${category.id}</span
                      >
                    </td>
                    <td>
                      <div class="fw-semibold">${category.name}</div>
                    </td>
                                                        <td>
                                        <span class="text-muted">${category.nameVN}</span>
                                        <c:if test="${productCounts[category.id] > 0}">
                                            <br><small class="text-info">${productCounts[category.id]} sản phẩm</small>
                                        </c:if>
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
                        <button
                          type="button"
                          class="btn btn-sm btn-outline-danger"
                          onclick="confirmDelete('${category.id}', '${category.name}')"
                          title="Xóa"
                        >
                          <i class="bi bi-trash"></i>
                        </button>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
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
        <p class="text-danger small">
          <i class="bi bi-info-circle me-1"></i>
          Hành động này không thể hoàn tác!
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Hủy
        </button>
        <a href="#" id="deleteLink" class="btn btn-danger">
          <i class="bi bi-trash me-2"></i>
          Xóa
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

  // Initialize DataTable only for desktop view
  $(document).ready(function () {
    if (window.innerWidth >= 768) {
      $('#dataTable').DataTable({
        responsive: false,
        language: {
          url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/vi.json',
        },
      });
    }
  });
</script>
