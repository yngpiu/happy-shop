<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="base" value="/admin/user" scope="request" />

<!-- Page Header -->
<div
  class="d-flex flex-column flex-md-row justify-content-between align-items-start align-items-md-center mb-4"
>
  <div class="mb-3 mb-md-0">
    <h2 class="fw-bold mb-1">
      <i class="bi bi-people me-2"></i>
      Quản lý người dùng
    </h2>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          <a href="/admin/home/index">Dashboard</a>
        </li>
        <li class="breadcrumb-item active">Người dùng</li>
      </ol>
    </nav>
  </div>
  <div class="d-flex gap-2">
    <a href="${base}/insert" class="btn btn-success">
      <i class="bi bi-plus-circle me-2"></i>
      Thêm người dùng
    </a>
  </div>
</div>

<!-- Success/Error Messages -->
<c:if test="${not empty message}">
  <div class="alert alert-success auto-hide-alert fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    ${message}${param.message}
  </div>
</c:if>

<c:if test="${not empty error}">
  <div class="alert alert-danger auto-hide-alert fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    ${error}${param.error}
  </div>
</c:if>

<!-- Statistics Cards -->
<div class="row mb-4">
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-primary text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Tổng người dùng</h6>
            <h3 class="mb-0">${totalUsers}</h3>
            <small class="text-white">người dùng</small>
          </div>
          <div class="text-white">
            <i class="bi bi-people display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-success text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Đang hoạt động</h6>
            <h3 class="mb-0">${activeUsers}</h3>
            <small class="text-white">hoạt động</small>
          </div>
          <div class="text-white">
            <i class="bi bi-check-circle display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-warning text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Quản trị viên</h6>
            <h3 class="mb-0">${adminUsers}</h3>
            <small class="text-white">admin</small>
          </div>
          <div class="text-white">
            <i class="bi bi-shield-check display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-info text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Người dùng thường</h6>
            <h3 class="mb-0">${regularUsers}</h3>
            <small class="text-white">thành viên</small>
          </div>
          <div class="text-white">
            <i class="bi bi-person display-6"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <div class="col-12 col-md-2-4 mb-3">
    <div class="card bg-danger text-white h-100">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center">
          <div>
            <h6 class="card-title text-white mb-1">Bị cấm</h6>
            <h3 class="mb-0">${bannedUsers}</h3>
            <small class="text-white">tạm khóa</small>
          </div>
          <div class="text-white">
            <i class="bi bi-person-x display-6"></i>
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
              <i class="bi bi-check-circle me-1"></i>Đang hoạt động (${activeUsers})
            </label>
            <input type="radio" class="btn-check" name="statusFilter" id="allFilter" value="all">
            <label class="btn btn-outline-primary btn-sm" for="allFilter">
              <i class="bi bi-list me-1"></i>Tất cả (${totalUsers})
            </label>
            <input type="radio" class="btn-check" name="statusFilter" id="bannedFilter" value="banned">
            <label class="btn btn-outline-danger btn-sm" for="bannedFilter">
              <i class="bi bi-person-x me-1"></i>Bị cấm (${bannedUsers})
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

<!-- User List Card -->
<div class="card shadow-sm">
  <div class="card-header bg-light">
    <div class="d-flex flex-column flex-sm-row justify-content-between align-items-start align-items-sm-center">
      <h5 class="card-title mb-2 mb-sm-0">
        <i class="bi bi-list-ul text-primary me-2"></i>
        Danh sách người dùng
      </h5>
      <div class="d-flex align-items-center gap-2">
        <span class="badge bg-primary" id="userCount">${list.size()} người dùng</span>
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
          <i class="bi bi-person-x display-1 text-muted"></i>
          <h4 class="text-muted mt-3">Chưa có người dùng nào</h4>
          <p class="text-muted">Bấm nút "Thêm người dùng" để tạo tài khoản mới</p>
          <a href="${base}/insert" class="btn btn-success">
            <i class="bi bi-plus-circle me-2"></i>
            Thêm người dùng đầu tiên
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <!-- Table View -->
        <div id="tableViewContent">
          <div class="table-responsive">
            <table class="table table-hover mb-0">
              <thead class="table-dark">
                <tr>
                  <th scope="col" width="80px">
                    <div class="form-check">
                      <input class="form-check-input" type="checkbox" id="selectAll">
                      <label class="form-check-label" for="selectAll">
                        <span class="visually-hidden">Chọn tất cả</span>
                      </label>
                    </div>
                  </th>
                  <th scope="col" width="100px">Avatar</th>
                  <th scope="col">Thông tin</th>
                  <th scope="col">Liên hệ</th>
                  <th scope="col" width="120px">Trạng thái</th>
                  <th scope="col" width="100px">Vai trò</th>
                  <th scope="col" width="200px">Hành động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="user" items="${list}">
                  <tr class="user-row" data-status="${user.isBanned ? 'banned' : 'active'}" data-role="${user.admin ? 'admin' : 'user'}">
                    <td>
                      <div class="form-check">
                        <input class="form-check-input user-checkbox" type="checkbox" value="${user.id}" id="user_${user.id}">
                        <label class="form-check-label" for="user_${user.id}">
                          <span class="visually-hidden">Chọn ${user.fullname}</span>
                        </label>
                      </div>
                    </td>
                    <td>
                      <div class="d-flex align-items-center">
                        <img src="/static/images/customers/${user.photo}" 
                             alt="${user.fullname}" 
                             class="rounded-circle me-2"
                             style="width: 50px; height: 50px; object-fit: cover;"
                             onerror="this.src='/static/images/customers/user.png'">
                      </div>
                    </td>
                    <td>
                      <div>
                        <h6 class="mb-1 fw-semibold">${user.fullname}</h6>
                        <small class="text-muted">@${user.id}</small>
                      </div>
                    </td>
                    <td>
                      <div>
                        <div class="mb-1">
                          <i class="bi bi-envelope me-1"></i>
                          <small>${user.email}</small>
                        </div>
                        <div>
                          <i class="bi bi-telephone me-1"></i>
                          <small>${user.telephone}</small>
                        </div>
                      </div>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${user.isBanned}">
                          <span class="badge bg-danger">
                            <i class="bi bi-x-circle me-1"></i>Bị cấm
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-success">
                            <i class="bi bi-check-circle me-1"></i>Hoạt động
                          </span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <c:choose>
                        <c:when test="${user.admin}">
                          <span class="badge bg-warning">
                            <i class="bi bi-shield-check me-1"></i>Admin
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge bg-info">
                            <i class="bi bi-person me-1"></i>User
                          </span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <div class="btn-group" role="group">
                        <a href="${base}/edit/${user.id}" 
                           class="btn btn-outline-primary btn-sm"
                           title="Chỉnh sửa">
                          <i class="bi bi-pencil"></i>
                        </a>
                        
                        <c:choose>
                          <c:when test="${user.isBanned}">
                            <button type="button" 
                                    class="btn btn-outline-success btn-sm"
                                    title="Mở cấm người dùng"
                                    onclick="confirmUnban('${user.id}', '${user.fullname}')">
                              <i class="bi bi-person-check"></i>
                            </button>
                          </c:when>
                          <c:otherwise>
                            <button type="button" 
                                    class="btn btn-outline-danger btn-sm"
                                    title="Cấm người dùng"
                                    onclick="confirmBan('${user.id}', '${user.fullname}')">
                              <i class="bi bi-person-x"></i>
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
        </div>
        
        <!-- Card View -->
        <div id="cardViewContent" style="display: none;">
          <div class="row p-3">
            <c:forEach var="user" items="${list}">
              <div class="col-12 col-md-6 col-lg-4 mb-3 user-card" data-status="${user.isBanned ? 'banned' : 'active'}" data-role="${user.admin ? 'admin' : 'user'}">
                <div class="card h-100 shadow-sm">
                  <div class="card-body">
                    <div class="d-flex align-items-start mb-3">
                      <img src="/static/images/customers/${user.photo}" 
                           alt="${user.fullname}" 
                           class="rounded-circle me-3"
                           style="width: 60px; height: 60px; object-fit: cover;"
                           onerror="this.src='/static/images/customers/user.png'">
                      <div class="flex-grow-1">
                        <h6 class="card-title mb-1">${user.fullname}</h6>
                        <small class="text-muted">@${user.id}</small>
                        <div class="mt-2">
                          <c:choose>
                            <c:when test="${user.isBanned}">
                              <span class="badge bg-danger">Bị cấm</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge bg-success">Hoạt động</span>
                            </c:otherwise>
                          </c:choose>
                          <c:choose>
                            <c:when test="${user.admin}">
                              <span class="badge bg-warning">Admin</span>
                            </c:when>
                            <c:otherwise>
                              <span class="badge bg-info">User</span>
                            </c:otherwise>
                          </c:choose>
                        </div>
                      </div>
                    </div>
                    
                    <div class="mb-3">
                      <div class="mb-2">
                        <i class="bi bi-envelope me-2"></i>
                        <small>${user.email}</small>
                      </div>
                      <div>
                        <i class="bi bi-telephone me-2"></i>
                        <small>${user.telephone}</small>
                      </div>
                    </div>
                    
                    <div class="d-flex gap-2">
                      <a href="${base}/edit/${user.id}" 
                         class="btn btn-outline-primary btn-sm flex-fill">
                        <i class="bi bi-pencil me-1"></i>Sửa
                      </a>
                      
                      <c:choose>
                        <c:when test="${user.isBanned}">
                          <button type="button" 
                                  class="btn btn-outline-success btn-sm flex-fill"
                                  onclick="confirmUnban('${user.id}', '${user.fullname}')">
                            <i class="bi bi-person-check me-1"></i>Mở cấm
                          </button>
                        </c:when>
                        <c:otherwise>
                          <button type="button" 
                                  class="btn btn-outline-danger btn-sm flex-fill"
                                  onclick="confirmBan('${user.id}', '${user.fullname}')">
                            <i class="bi bi-person-x me-1"></i>Cấm
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

<!-- Hidden Forms for Actions -->
<form id="banUserForm" method="post" style="display: none;">
  <input type="hidden" name="id" id="banUserId">
</form>

<form id="unbanUserForm" method="post" style="display: none;">
  <input type="hidden" name="id" id="unbanUserId">
</form>

<script>
// Auto-hide alerts
setTimeout(function() {
  $('.auto-hide-alert').fadeOut();
}, 5000);

// View toggle functionality
document.getElementById('tableView').addEventListener('change', function() {
  if (this.checked) {
    document.getElementById('tableViewContent').style.display = 'block';
    document.getElementById('cardViewContent').style.display = 'none';
  }
});

document.getElementById('cardView').addEventListener('change', function() {
  if (this.checked) {
    document.getElementById('tableViewContent').style.display = 'none';
    document.getElementById('cardViewContent').style.display = 'block';
  }
});

// Filter functionality
document.querySelectorAll('input[name="statusFilter"]').forEach(function(radio) {
  radio.addEventListener('change', function() {
    const filter = this.value;
    let visibleCount = 0;
    
    document.querySelectorAll('.user-row, .user-card').forEach(function(element) {
      const status = element.getAttribute('data-status');
      let show = false;
      
      if (filter === 'all') {
        show = true;
      } else if (filter === 'active' && status === 'active') {
        show = true;
      } else if (filter === 'banned' && status === 'banned') {
        show = true;
      }
      
      if (show) {
        element.style.display = '';
        visibleCount++;
      } else {
        element.style.display = 'none';
      }
    });
    
    document.getElementById('userCount').textContent = visibleCount + ' người dùng';
  });
});

// Select all functionality
document.getElementById('selectAll').addEventListener('change', function() {
  const checkboxes = document.querySelectorAll('.user-checkbox');
  checkboxes.forEach(function(checkbox) {
    checkbox.checked = this.checked;
  }.bind(this));
});

// Confirm ban user
function confirmBan(userId, userName) {
  if (confirm('Bạn có chắc chắn muốn cấm người dùng "' + userName + '"?\n\nNgười dùng sẽ không thể đăng nhập vào hệ thống.')) {
    document.getElementById('banUserId').value = userId;
    document.getElementById('banUserForm').action = '${base}/ban/' + userId;
    document.getElementById('banUserForm').submit();
  }
}

// Confirm unban user  
function confirmUnban(userId, userName) {
  if (confirm('Bạn có chắc chắn muốn mở cấm cho người dùng "' + userName + '"?\n\nNgười dùng sẽ có thể đăng nhập trở lại.')) {
    document.getElementById('unbanUserId').value = userId;
    document.getElementById('unbanUserForm').action = '${base}/unban/' + userId;
    document.getElementById('unbanUserForm').submit();
  }
}

// Refresh data
function refreshData() {
  location.reload();
}

// CSS for responsive columns
const style = document.createElement('style');
style.textContent = `
  @media (min-width: 768px) {
    .col-md-2-4 {
      flex: 0 0 auto;
      width: 20%;
    }
  }
`;
document.head.appendChild(style);
</script> 