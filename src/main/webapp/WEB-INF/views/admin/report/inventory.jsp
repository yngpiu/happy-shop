<%@ page pageEncoding="utf-8"%> <%@ taglib
uri="http://java.sun.com/jstl/core_rt" prefix="c"%> <%@ taglib
uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

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
  .color-indicator {
    display: inline-block;
  }
  @media print {
    .card {
      border: 1px solid #dee2e6 !important;
      break-inside: avoid;
    }
  }
</style>

<!-- Page Header -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
  <div>
    <h1 class="h3 mb-0 text-gray-800">
      <i class="fas fa-warehouse text-primary me-2"></i>
      Báo cáo Tồn kho theo Loại sản phẩm
    </h1>
    <p class="text-muted mb-0">
      Phân tích tình trạng tồn kho và giá trị hàng hóa theo từng loại sản phẩm
    </p>
  </div>
  <div class="d-flex gap-2">
    <button class="btn btn-outline-primary btn-sm" onclick="exportChart()">
      <i class="fas fa-download me-1"></i>Xuất biểu đồ
    </button>
    <button class="btn btn-outline-secondary btn-sm" onclick="printReport()">
      <i class="fas fa-print me-1"></i>In báo cáo
    </button>
  </div>
</div>

<!-- Statistics Cards -->
<div class="row mb-4">
  <c:set var="totalQuantity" value="0" />
  <c:set var="totalValue" value="0" />
  <c:set var="categoryCount" value="0" />
  <c:forEach var="e" items="${data}">
    <c:set var="totalQuantity" value="${totalQuantity + e[1]}" />
    <c:set var="totalValue" value="${totalValue + e[2]}" />
    <c:set var="categoryCount" value="${categoryCount + 1}" />
  </c:forEach>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-primary shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-primary text-uppercase mb-1"
            >
              Tổng số loại
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              ${categoryCount}
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-tags fa-2x text-gray-300"></i>
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
              Tổng số lượng
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <f:formatNumber value="${totalQuantity}" pattern="#,###" />
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-boxes fa-2x text-gray-300"></i>
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
              Tổng giá trị
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <f:formatNumber value="${totalValue}" pattern="#,###" /> VNĐ
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
    <div class="card border-left-warning shadow h-100 py-2">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-warning text-uppercase mb-1"
            >
              Giá trị TB/loại
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <f:formatNumber
                value="${totalValue / categoryCount}"
                pattern="#,###"
              />
              VNĐ
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-chart-bar fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Charts Row -->
<div class="row mb-4">
  <!-- Pie Chart -->
  <div class="col-xl-6 col-lg-6">
    <div class="card shadow mb-4">
      <div
        class="card-header py-3 d-flex flex-row align-items-center justify-content-between"
      >
        <h6 class="m-0 font-weight-bold text-primary">
          <i class="fas fa-chart-pie me-2"></i>Phân bố Giá trị Tồn kho
        </h6>
        <div class="dropdown no-arrow">
          <a
            class="dropdown-toggle"
            href="#"
            role="button"
            id="dropdownMenuLink1"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
          </a>
          <div
            class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
            aria-labelledby="dropdownMenuLink1"
          >
            <div class="dropdown-header">Tùy chọn biểu đồ:</div>
            <a class="dropdown-item" href="#" onclick="toggleChartType('pie')"
              >Biểu đồ tròn</a
            >
            <a
              class="dropdown-item"
              href="#"
              onclick="toggleChartType('doughnut')"
              >Biểu đồ donut</a
            >
          </div>
        </div>
      </div>
      <div class="card-body">
        <div class="chart-container" style="position: relative; height: 350px">
          <canvas id="inventoryPieChart"></canvas>
        </div>
      </div>
    </div>
  </div>

  <!-- Bar Chart -->
  <div class="col-xl-6 col-lg-6">
    <div class="card shadow mb-4">
      <div
        class="card-header py-3 d-flex flex-row align-items-center justify-content-between"
      >
        <h6 class="m-0 font-weight-bold text-primary">
          <i class="fas fa-chart-bar me-2"></i>So sánh Số lượng Tồn kho
        </h6>
        <div class="dropdown no-arrow">
          <a
            class="dropdown-toggle"
            href="#"
            role="button"
            id="dropdownMenuLink2"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >
            <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
          </a>
          <div
            class="dropdown-menu dropdown-menu-right shadow animated--fade-in"
            aria-labelledby="dropdownMenuLink2"
          >
            <div class="dropdown-header">Tùy chọn biểu đồ:</div>
            <a class="dropdown-item" href="#" onclick="toggleBarChart('bar')"
              >Biểu đồ cột</a
            >
            <a
              class="dropdown-item"
              href="#"
              onclick="toggleBarChart('horizontalBar')"
              >Biểu đồ ngang</a
            >
          </div>
        </div>
      </div>
      <div class="card-body">
        <div class="chart-container" style="position: relative; height: 350px">
          <canvas id="inventoryBarChart"></canvas>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Data Table -->
<div class="card shadow mb-4">
  <div class="card-header py-3">
    <h6 class="m-0 font-weight-bold text-primary">
      <i class="fas fa-table me-2"></i>Bảng dữ liệu chi tiết
    </h6>
  </div>
  <div class="card-body">
    <div class="table-responsive">
      <table
        class="table table-bordered table-hover"
        id="inventoryDataTable"
        width="100%"
        cellspacing="0"
      >
        <thead class="table-dark">
          <tr>
            <th><i class="fas fa-tag me-1"></i>Loại sản phẩm</th>
            <th><i class="fas fa-boxes me-1"></i>Số lượng</th>
            <th><i class="fas fa-dollar-sign me-1"></i>Tổng giá trị</th>
            <th><i class="fas fa-arrow-down me-1"></i>Giá thấp nhất</th>
            <th><i class="fas fa-arrow-up me-1"></i>Giá cao nhất</th>
            <th><i class="fas fa-chart-line me-1"></i>Giá trung bình</th>
            <th><i class="fas fa-percentage me-1"></i>% Tổng giá trị</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="e" items="${data}">
            <tr>
              <td>
                <div class="d-flex align-items-center">
                  <div
                    class="color-indicator me-2"
                    style="
                      width: 12px;
                      height: 12px;
                      border-radius: 50%;
                      background-color: #4e73df;
                    "
                  ></div>
                  <strong>${e[0]}</strong>
                </div>
              </td>
              <td>
                <span class="badge bg-primary rounded-pill">
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
                <c:set var="percentage" value="${(e[2] / totalValue) * 100}" />
                <div class="progress" style="height: 20px">
                  <div
                    class="progress-bar bg-info"
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
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Chart.js and Custom Scripts -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<script>
  // Data preparation
  const inventoryData = {
    labels: [
      <c:forEach var="e" items="${data}" varStatus="status">
        '${e[0]}'<c:if test="${!status.last}">,</c:if>
      </c:forEach>,
    ],
    values: [
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

  // Color palette
  const colors = [
    '#4e73df',
    '#1cc88a',
    '#36b9cc',
    '#f6c23e',
    '#e74a3b',
    '#858796',
    '#fd7e14',
    '#6f42c1',
    '#e83e8c',
    '#20c997',
  ];

  // Pie Chart
  const pieCtx = document.getElementById('inventoryPieChart').getContext('2d');
  let pieChart = new Chart(pieCtx, {
    type: 'pie',
    data: {
      labels: inventoryData.labels,
      datasets: [
        {
          data: inventoryData.values,
          backgroundColor: colors,
          borderColor: colors.map(color => color + '80'),
          borderWidth: 2,
          hoverOffset: 4,
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
              const value = context.raw;
              const total = context.dataset.data.reduce((a, b) => a + b, 0);
              const percentage = ((value / total) * 100).toFixed(1);
              return (
                context.label +
                ': ' +
                value.toLocaleString() +
                ' VNĐ (' +
                percentage +
                '%)'
              );
            },
          },
        },
      },
    },
  });

  // Bar Chart
  const barCtx = document.getElementById('inventoryBarChart').getContext('2d');
  let barChart = new Chart(barCtx, {
    type: 'bar',
    data: {
      labels: inventoryData.labels,
      datasets: [
        {
          label: 'Số lượng tồn kho',
          data: inventoryData.quantities,
          backgroundColor: colors.map(color => color + '80'),
          borderColor: colors,
          borderWidth: 2,
          borderRadius: 4,
          borderSkipped: false,
        },
      ],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: false,
        },
        tooltip: {
          callbacks: {
            label: function (context) {
              return (
                context.dataset.label +
                ': ' +
                context.raw.toLocaleString() +
                ' sản phẩm'
              );
            },
          },
        },
      },
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            callback: function (value) {
              return value.toLocaleString();
            },
          },
        },
      },
    },
  });

  // Chart toggle functions
  function toggleChartType(type) {
    pieChart.config.type = type;
    pieChart.update();
  }

  function toggleBarChart(type) {
    barChart.config.type = type;
    barChart.update();
  }

  // Export functions
  function exportChart() {
    const link = document.createElement('a');
    link.download = 'bao-cao-ton-kho.png';
    link.href = pieChart.toBase64Image();
    link.click();
  }

  function printReport() {
    window.print();
  }

  // DataTable initialization
  $(document).ready(function () {
    $('#inventoryDataTable').DataTable({
      language: {
        url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json',
      },
      order: [[2, 'desc']], // Sort by total value descending
      pageLength: 25,
      responsive: true,
      dom: 'Bfrtip',
      buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
    });
  });
</script>
