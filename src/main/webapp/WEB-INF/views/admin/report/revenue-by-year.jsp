<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

<style>
  .border-left-primary {
    border-left: 0.25rem solid #4e73df !important;
  }
  .border-left-success {
    border-left: 0.25rem solid #1cc88a !important;
  }
  .border-left-info {
    border-left: 0.25rem solid #36b9cc !important;
  }
  .border-left-warning {
    border-left: 0.25rem solid #f6c23e !important;
  }
</style>

<!-- Page Header -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
  <div>
    <h1 class="h3 mb-0 text-gray-800">
      <i class="fas fa-calendar-alt text-primary me-2"></i>
      Báo cáo Doanh thu theo Năm
    </h1>
    <p class="text-muted mb-0">Phân tích xu hướng doanh thu qua các năm</p>
  </div>
  <div class="d-flex gap-2">
    <button class="btn btn-outline-primary btn-sm" onclick="exportChart()">
      <i class="fas fa-download me-1"></i>Xuất báo cáo
    </button>
    <button class="btn btn-outline-secondary btn-sm" onclick="printReport()">
      <i class="fas fa-print me-1"></i>In báo cáo
    </button>
  </div>
</div>

<!-- Summary Statistics -->
<div class="row mb-4">
  <c:set var="totalRevenue" value="0" />
  <c:set var="totalQuantity" value="0" />
  <c:set var="yearCount" value="0" />
  <c:forEach var="e" items="${data}">
    <c:set var="totalRevenue" value="${totalRevenue + e[2]}" />
    <c:set var="totalQuantity" value="${totalQuantity + e[1]}" />
    <c:set var="yearCount" value="${yearCount + 1}" />
  </c:forEach>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-primary shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-primary text-uppercase mb-1"
            >
              Số năm hoạt động
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              ${yearCount}
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-calendar fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-success shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-success text-uppercase mb-1"
            >
              Tổng doanh thu
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <f:formatNumber value="${totalRevenue}" pattern="#,###" /> VNĐ
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-info shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
              DT TB/năm
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <f:formatNumber
                value="${totalRevenue / yearCount}"
                pattern="#,###"
              />
              VNĐ
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-chart-line fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-warning shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-warning text-uppercase mb-1"
            >
              Tổng SP bán
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <f:formatNumber value="${totalQuantity}" pattern="#,###" />
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-shopping-cart fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Charts Row -->
<div class="row mb-4">
  <div class="col-xl-8 col-lg-7">
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">
          <i class="fas fa-chart-line me-2"></i>Xu hướng Doanh thu theo Năm
        </h6>
      </div>
      <div class="card-body">
        <div class="chart-container" style="position: relative; height: 400px">
          <canvas id="yearRevenueChart"></canvas>
        </div>
      </div>
    </div>
  </div>

  <div class="col-xl-4 col-lg-5">
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">
          <i class="fas fa-chart-bar me-2"></i>So sánh Doanh thu
        </h6>
      </div>
      <div class="card-body">
        <div class="chart-container" style="position: relative; height: 400px">
          <canvas id="yearBarChart"></canvas>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Data Table -->
<div class="card shadow mb-4">
  <div class="card-header py-3">
    <h6 class="m-0 font-weight-bold text-primary">
      <i class="fas fa-table me-2"></i>Bảng dữ liệu chi tiết theo năm
    </h6>
  </div>
  <div class="card-body">
    <div class="table-responsive">
      <table
        class="table table-bordered table-hover"
        id="yearDataTable"
        width="100%"
        cellspacing="0"
      >
        <thead class="table-dark">
          <tr>
            <th>Năm</th>
            <th>Số lượng bán</th>
            <th>Tổng doanh thu</th>
            <th>Giá thấp nhất</th>
            <th>Giá cao nhất</th>
            <th>Giá trung bình</th>
            <th>% Tổng DT</th>
            <th>Tăng trưởng</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="e" items="${data}" varStatus="status">
            <tr>
              <td><strong class="text-primary">${e[0]}</strong></td>
              <td>
                <span class="badge bg-info rounded-pill">
                  <f:formatNumber value="${e[1]}" pattern="#,###" />
                </span>
              </td>
              <td>
                <strong class="text-success">
                  <f:formatNumber value="${e[2]}" pattern="#,###" /> VNĐ
                </strong>
              </td>
              <td><f:formatNumber value="${e[3]}" pattern="#,###" /> VNĐ</td>
              <td><f:formatNumber value="${e[4]}" pattern="#,###" /> VNĐ</td>
              <td><f:formatNumber value="${e[5]}" pattern="#,###" /> VNĐ</td>
              <td>
                <c:set
                  var="percentage"
                  value="${(e[2] / totalRevenue) * 100}"
                />
                <div class="progress" style="height: 20px">
                  <div
                    class="progress-bar bg-primary"
                    role="progressbar"
                    style="width: ${percentage}%"
                    aria-valuenow="${percentage}"
                    aria-valuemin="0"
                    aria-valuemax="100"
                  >
                    <f:formatNumber value="${percentage}" pattern="##.#" />%
                  </div>
                </div>
              </td>
              <td>
                <c:if test="${status.index > 0}">
                  <c:set
                    var="prevRevenue"
                    value="${data[status.index - 1][2]}"
                  />
                  <c:set
                    var="growth"
                    value="${((e[2] - prevRevenue) / prevRevenue) * 100}"
                  />
                  <c:choose>
                    <c:when test="${growth > 0}">
                      <span class="text-success">
                        <i class="fas fa-arrow-up"></i>
                        <f:formatNumber value="${growth}" pattern="##.#" />%
                      </span>
                    </c:when>
                    <c:when test="${growth < 0}">
                      <span class="text-danger">
                        <i class="fas fa-arrow-down"></i>
                        <f:formatNumber
                          value="${growth * -1}"
                          pattern="##.#"
                        />%
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="text-muted">0%</span>
                    </c:otherwise>
                  </c:choose>
                </c:if>
                <c:if test="${status.index == 0}">
                  <span class="text-muted">-</span>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<script>
  // Data preparation
  const yearData = {
    labels: [
      <c:forEach var="e" items="${data}" varStatus="status">
        '${e[0]}'<c:if test="${!status.last}">,</c:if>
      </c:forEach>,
    ],
    revenues: [
      <c:forEach var="e" items="${data}" varStatus="status">
        ${e[2]}
        <c:if test="${!status.last}">,</c:if>
      </c:forEach>,
    ],
    quantities: [
      <c:forEach var="e" items="${data}" varStatus="status">
        ${e[1]}
        <c:if test="${!status.last}">,</c:if>
      </c:forEach>,
    ],
  };

  // Line Chart
  const lineCtx = document.getElementById('yearRevenueChart').getContext('2d');
  new Chart(lineCtx, {
    type: 'line',
    data: {
      labels: yearData.labels,
      datasets: [
        {
          label: 'Doanh thu (VNĐ)',
          data: yearData.revenues,
          borderColor: '#4e73df',
          backgroundColor: '#4e73df20',
          borderWidth: 3,
          fill: true,
          tension: 0.4,
          pointBackgroundColor: '#4e73df',
          pointBorderColor: '#fff',
          pointBorderWidth: 2,
          pointRadius: 6,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: {
          callbacks: {
            label: function (context) {
              return 'Doanh thu: ' + context.raw.toLocaleString() + ' VNĐ';
            },
          },
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            callback: function (value) {
              return (value / 1000000).toLocaleString() + 'M VNĐ';
            },
          },
        },
      },
    },
  });

  // Bar Chart
  const barCtx = document.getElementById('yearBarChart').getContext('2d');
  new Chart(barCtx, {
    type: 'bar',
    data: {
      labels: yearData.labels,
      datasets: [
        {
          label: 'Doanh thu',
          data: yearData.revenues,
          backgroundColor: '#1cc88a80',
          borderColor: '#1cc88a',
          borderWidth: 2,
          borderRadius: 4,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: { legend: { display: false } },
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            callback: function (value) {
              return (value / 1000000).toLocaleString() + 'M';
            },
          },
        },
      },
    },
  });

  function exportChart() {
    const link = document.createElement('a');
    link.download = 'bao-cao-doanh-thu-theo-nam.png';
    link.href = document.getElementById('yearRevenueChart').toDataURL();
    link.click();
  }

  function printReport() {
    window.print();
  }

  $(document).ready(function () {
    $('#yearDataTable').DataTable({
      language: {
        url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json',
      },
      order: [[0, 'desc']],
      pageLength: 25,
      responsive: true,
      dom: 'Bfrtip',
      buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
    });
  });
</script>
