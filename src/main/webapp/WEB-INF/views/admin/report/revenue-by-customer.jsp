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
  .customer-card {
    transition: transform 0.2s;
  }
  .customer-card:hover {
    transform: translateY(-3px);
  }
</style>

<!-- Page Header -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
  <div>
    <h1 class="h3 mb-0 text-gray-800">
      <i class="fas fa-users text-info me-2"></i>
      Báo cáo Doanh thu theo Khách hàng
    </h1>
    <p class="text-muted mb-0">
      Phân tích doanh thu và hành vi mua hàng của từng khách hàng
    </p>
  </div>
  <div class="d-flex gap-2">
    <button class="btn btn-outline-info btn-sm" onclick="exportChart()">
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
  <c:set var="totalQuantity" value="0" />
  <c:set var="customerCount" value="0" />
  <c:set var="maxRevenue" value="0" />
  <c:forEach var="e" items="${data}">
    <c:set var="totalRevenue" value="${totalRevenue + e[2]}" />
    <c:set var="totalQuantity" value="${totalQuantity + e[1]}" />
    <c:set var="customerCount" value="${customerCount + 1}" />
    <c:if test="${e[2] > maxRevenue}">
      <c:set var="maxRevenue" value="${e[2]}" />
      <c:set var="topCustomer" value="${e[0]}" />
    </c:if>
  </c:forEach>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-info shadow h-100 py-2 customer-card">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
              Tổng khách hàng
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              ${customerCount}
            </div>
          </div>
          <div class="col-auto">
            <i class="fas fa-users fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-success shadow h-100 py-2 customer-card">
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
    <div class="card border-left-warning shadow h-100 py-2 customer-card">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-warning text-uppercase mb-1"
            >
              DT TB/khách hàng
            </div>
            <div class="h5 mb-0 font-weight-bold text-gray-800">
              <f:formatNumber
                value="${totalRevenue / customerCount}"
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
    <div class="card border-left-primary shadow h-100 py-2 customer-card">
      <div class="card-body">
        <div class="row no-gutters align-items-center">
          <div class="col mr-2">
            <div
              class="text-xs font-weight-bold text-primary text-uppercase mb-1"
            >
              KH có DT cao nhất
            </div>
            <div class="h6 mb-0 font-weight-bold text-gray-800">
              ID: ${topCustomer}
            </div>
            <small class="text-muted">
              <f:formatNumber value="${maxRevenue}" pattern="#,###" /> VNĐ
            </small>
          </div>
          <div class="col-auto">
            <i class="fas fa-star fa-2x text-gray-300"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Charts Row -->
<div class="row mb-4">
  <!-- Top Customers Chart -->
  <div class="col-xl-8 col-lg-8">
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">
          <i class="fas fa-chart-bar me-2"></i>Top 10 Khách hàng có Doanh thu
          cao nhất
        </h6>
      </div>
      <div class="card-body">
        <div class="chart-container" style="position: relative; height: 400px">
          <canvas id="topCustomersChart"></canvas>
        </div>
      </div>
    </div>
  </div>

  <!-- Customer Distribution -->
  <div class="col-xl-4 col-lg-4">
    <div class="card shadow mb-4">
      <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary">
          <i class="fas fa-chart-pie me-2"></i>Phân khúc Khách hàng
        </h6>
      </div>
      <div class="card-body">
        <div class="chart-container" style="position: relative; height: 400px">
          <canvas id="customerSegmentChart"></canvas>
        </div>
        <div class="mt-3">
          <div class="small">
            <i class="fas fa-circle text-primary me-1"></i> VIP (>10M VNĐ)
          </div>
          <div class="small">
            <i class="fas fa-circle text-success me-1"></i> Thường xuyên (5-10M
            VNĐ)
          </div>
          <div class="small">
            <i class="fas fa-circle text-warning me-1"></i> Thông thường (1-5M
            VNĐ)
          </div>
          <div class="small">
            <i class="fas fa-circle text-secondary me-1"></i> Mới (<1M VNĐ)
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Data Table -->
<div class="card shadow mb-4">
  <div class="card-header py-3">
    <h6 class="m-0 font-weight-bold text-primary">
      <i class="fas fa-table me-2"></i>Bảng dữ liệu chi tiết theo khách hàng
    </h6>
  </div>
  <div class="card-body">
    <div class="table-responsive">
      <table
        class="table table-bordered table-hover"
        id="customerDataTable"
        width="100%"
        cellspacing="0"
      >
        <thead class="table-dark">
          <tr>
            <th>ID Khách hàng</th>
            <th>Tổng số lượng mua</th>
            <th>Tổng doanh thu</th>
            <th>Giá thấp nhất</th>
            <th>Giá cao nhất</th>
            <th>Giá trung bình</th>
            <th>Phân khúc</th>
            <th>% Đóng góp DT</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="e" items="${data}">
            <tr>
              <td>
                <strong class="text-primary">KH-${e[0]}</strong>
              </td>
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
                <c:choose>
                  <c:when test="${e[2] >= 10000000}">
                    <span class="badge bg-primary">VIP</span>
                  </c:when>
                  <c:when test="${e[2] >= 5000000}">
                    <span class="badge bg-success">Thường xuyên</span>
                  </c:when>
                  <c:when test="${e[2] >= 1000000}">
                    <span class="badge bg-warning">Thông thường</span>
                  </c:when>
                  <c:otherwise>
                    <span class="badge bg-secondary">Mới</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:set
                  var="percentage"
                  value="${(e[2] / totalRevenue) * 100}"
                />
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
  const customerData = {
    labels: [
      <c:forEach var="e" items="${data}" varStatus="status">
        'KH-${e[0]}'<c:if test="${!status.last}">,</c:if>
      </c:forEach>,
    ],
    revenues: [
      <c:forEach var="e" items="${data}" varStatus="status">
        ${e[2]}
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

  // Top Customers Bar Chart
  const topCustomersCtx = document
    .getElementById('topCustomersChart')
    .getContext('2d');
  const topCustomersData = customerData.revenues
    .map((revenue, index) => ({ revenue, label: customerData.labels[index] }))
    .sort((a, b) => b.revenue - a.revenue)
    .slice(0, 10);

  new Chart(topCustomersCtx, {
    type: 'bar',
    data: {
      labels: topCustomersData.map(item => item.label),
      datasets: [
        {
          label: 'Doanh thu (VNĐ)',
          data: topCustomersData.map(item => item.revenue),
          backgroundColor: colors[0] + '80',
          borderColor: colors[0],
          borderWidth: 2,
          borderRadius: 4,
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

  // Customer Segment Chart
  const segmentCtx = document
    .getElementById('customerSegmentChart')
    .getContext('2d');
  let vipCount = 0,
    regularCount = 0,
    normalCount = 0,
    newCount = 0;

  customerData.revenues.forEach(revenue => {
    if (revenue >= 10000000) vipCount++;
    else if (revenue >= 5000000) regularCount++;
    else if (revenue >= 1000000) normalCount++;
    else newCount++;
  });

  new Chart(segmentCtx, {
    type: 'doughnut',
    data: {
      labels: ['VIP', 'Thường xuyên', 'Thông thường', 'Mới'],
      datasets: [
        {
          data: [vipCount, regularCount, normalCount, newCount],
          backgroundColor: ['#4e73df', '#1cc88a', '#f6c23e', '#858796'],
          borderColor: '#fff',
          borderWidth: 2,
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
              const total = context.dataset.data.reduce((a, b) => a + b, 0);
              const percentage = ((context.raw / total) * 100).toFixed(1);
              return (
                context.label + ': ' + context.raw + ' KH (' + percentage + '%)'
              );
            },
          },
        },
      },
      cutout: '60%',
    },
  });

  // Export functions
  function exportChart() {
    const link = document.createElement('a');
    link.download = 'bao-cao-doanh-thu-khach-hang.png';
    link.href = document.getElementById('topCustomersChart').toDataURL();
    link.click();
  }

  function printReport() {
    window.print();
  }

  // DataTable initialization
  $(document).ready(function () {
    $('#customerDataTable').DataTable({
      language: {
        url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json',
      },
      order: [[2, 'desc']],
      pageLength: 25,
      responsive: true,
      dom: 'Bfrtip',
      buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
    });
  });
</script>
