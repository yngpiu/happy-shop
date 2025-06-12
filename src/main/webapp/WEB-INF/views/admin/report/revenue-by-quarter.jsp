<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
      <i class="fas fa-chart-bar text-warning me-2"></i>
      Báo cáo Doanh thu theo Quý
    </h1>
    <p class="text-muted mb-0">Phân tích doanh thu theo từng quý trong năm</p>
  </div>
  <div class="d-flex gap-2">
    <button class="btn btn-outline-warning btn-sm" onclick="exportChart()">
      <i class="fas fa-download me-1"></i>Xuất báo cáo
    </button>
    <button class="btn btn-outline-primary btn-sm" onclick="printReport()">
      <i class="fas fa-print me-1"></i>In báo cáo
    </button>
  </div>
</div>

<!-- Summary Statistics -->
<div class="row mb-4">
  <c:set var="totalRevenue" value="0" />
  <c:set var="maxRevenue" value="0" />
  <c:set var="bestQuarter" value="" />
  <c:forEach var="e" items="${data}">
    <c:set var="totalRevenue" value="${totalRevenue + e[2]}" />
    <c:if test="${e[2] > maxRevenue}">
      <c:set var="maxRevenue" value="${e[2]}" />
      <c:set var="bestQuarter" value="${e[0]}" />
    </c:if>
  </c:forEach>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-warning shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-warning text-uppercase mb-1"
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
    <div class="card border-left-success shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-success text-uppercase mb-1"
            >
              DT TB/quý
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <f:formatNumber value="${totalRevenue / 4}" pattern="#,###" /> VNĐ
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
    <div class="card border-left-primary shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-primary text-uppercase mb-1"
            >
              Quý cao nhất
            </div>
            <div class="h6 mb-0 font-weight-bold text-gray-800">
              Quý ${bestQuarter}
            </div>
            <small class="text-muted">
              <f:formatNumber value="${maxRevenue}" pattern="#,###" /> VNĐ
            </small>
          </div>
          <div class="col-auto">
            <i class="fas fa-award fa-2x text-gray-300"></i>
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
              Số quý có DT
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              ${fn:length(data)}
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-calendar-alt fa-2x text-gray-300"></i>
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
          <i class="fas fa-chart-area me-2"></i>Xu hướng Doanh thu theo Quý
        </h6>
      </div>
      <div class="card-body">
        <div class="chart-container" style="position: relative; height: 400px">
          <canvas id="quarterChart"></canvas>
        </div>
      </div>
    </div>
  </div>

  <div class="col-xl-4 col-lg-5">
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">
          <i class="fas fa-chart-pie me-2"></i>Phân bố theo Quý
        </h6>
      </div>
      <div class="card-body">
        <div class="chart-container" style="position: relative; height: 400px">
          <canvas id="quarterPieChart"></canvas>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Data Table -->
<div class="card shadow mb-4">
  <div class="card-header py-3">
    <h6 class="m-0 font-weight-bold text-primary">
      <i class="fas fa-table me-2"></i>Bảng dữ liệu chi tiết theo quý
    </h6>
  </div>
  <div class="card-body">
    <div class="table-responsive">
      <table
        class="table table-bordered table-hover"
        id="quarterDataTable"
        width="100%"
        cellspacing="0"
      >
        <thead class="table-dark">
          <tr>
            <th>Quý</th>
            <th>Số lượng bán</th>
            <th>Tổng doanh thu</th>
            <th>Giá thấp nhất</th>
            <th>Giá cao nhất</th>
            <th>Giá trung bình</th>
            <th>% Tổng DT</th>
            <th>Thời gian</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="e" items="${data}">
            <tr>
              <td><strong class="text-primary">Quý ${e[0]}</strong></td>
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
                    class="progress-bar bg-warning"
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
                <c:choose>
                  <c:when test="${e[0] == 1}">
                    <small class="text-muted">T1 - T3</small>
                  </c:when>
                  <c:when test="${e[0] == 2}">
                    <small class="text-muted">T4 - T6</small>
                  </c:when>
                  <c:when test="${e[0] == 3}">
                    <small class="text-muted">T7 - T9</small>
                  </c:when>
                  <c:otherwise>
                    <small class="text-muted">T10 - T12</small>
                  </c:otherwise>
                </c:choose>
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
  const quarterData = {
    labels: [
      <c:forEach var="e" items="${data}" varStatus="status">
        'Quý ${e[0]}'<c:if test="${!status.last}">,</c:if>
      </c:forEach>,
    ],
    revenues: [
      <c:forEach var="e" items="${data}" varStatus="status">
        ${e[2]}
        <c:if test="${!status.last}">,</c:if>
      </c:forEach>,
    ],
  };

  const colors = ['#f6c23e', '#1cc88a', '#36b9cc', '#4e73df'];

  // Line/Area Chart
  const lineCtx = document.getElementById('quarterChart').getContext('2d');
  new Chart(lineCtx, {
    type: 'line',
    data: {
      labels: quarterData.labels,
      datasets: [
        {
          label: 'Doanh thu',
          data: quarterData.revenues,
          borderColor: '#f6c23e',
          backgroundColor: 'rgba(246, 194, 62, 0.2)',
          borderWidth: 4,
          fill: true,
          tension: 0.4,
          pointBackgroundColor: colors,
          pointBorderColor: '#fff',
          pointBorderWidth: 3,
          pointRadius: 8,
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

  // Pie Chart
  const pieCtx = document.getElementById('quarterPieChart').getContext('2d');
  new Chart(pieCtx, {
    type: 'doughnut',
    data: {
      labels: quarterData.labels,
      datasets: [
        {
          data: quarterData.revenues,
          backgroundColor: colors,
          borderColor: '#fff',
          borderWidth: 3,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          position: 'bottom',
          labels: {
            usePointStyle: true,
            padding: 15,
          },
        },
        tooltip: {
          callbacks: {
            label: function (context) {
              const total = context.dataset.data.reduce((a, b) => a + b, 0);
              const percentage = ((context.raw / total) * 100).toFixed(1);
              return (
                context.label +
                ': ' +
                context.raw.toLocaleString() +
                ' VNĐ (' +
                percentage +
                '%)'
              );
            },
          },
        },
      },
      cutout: '50%',
    },
  });

  function exportChart() {
    const link = document.createElement('a');
    link.download = 'bao-cao-doanh-thu-theo-quy.png';
    link.href = document.getElementById('quarterChart').toDataURL();
    link.click();
  }

  function printReport() {
    window.print();
  }

  $(document).ready(function () {
    $('#quarterDataTable').DataTable({
      language: {
        url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json',
      },
      order: [[2, 'desc']],
      pageLength: 4,
      responsive: true,
      dom: 'Bfrtip',
      buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
    });
  });
</script>
