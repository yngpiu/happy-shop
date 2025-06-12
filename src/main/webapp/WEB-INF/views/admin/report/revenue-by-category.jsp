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
  .revenue-card {
    transition: transform 0.2s;
  }
  .revenue-card:hover {
    transform: translateY(-5px);
  }
</style>

<!-- Page Header -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
  <div>
    <h1 class="h3 mb-0 text-gray-800">
      <i class="fas fa-chart-line text-success me-2"></i>
      Báo cáo Doanh thu theo Loại sản phẩm
    </h1>
    <p class="text-muted mb-0">
      Phân tích doanh thu bán hàng và hiệu suất kinh doanh theo từng loại sản
      phẩm
    </p>
  </div>
  <div class="d-flex gap-2">
    <button class="btn btn-outline-success btn-sm" onclick="exportChart()">
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
  <c:set var="categoryCount" value="0" />
  <c:set var="maxRevenue" value="0" />
  <c:forEach var="e" items="${data}">
    <c:set var="totalRevenue" value="${totalRevenue + e[2]}" />
    <c:set var="totalQuantity" value="${totalQuantity + e[1]}" />
    <c:set var="categoryCount" value="${categoryCount + 1}" />
    <c:if test="${e[2] > maxRevenue}">
      <c:set var="maxRevenue" value="${e[2]}" />
      <c:set var="topCategory" value="${e[0]}" />
    </c:if>
  </c:forEach>

  <div class="col-xl-3 col-md-6 mb-4">
    <div class="card border-left-success shadow h-100 py-2 revenue-card">
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
          <div>
            <h1 class="h3 mb-0 text-gray-800">
              <i class="fas fa-chart-line text-success me-2"></i>
              Báo cáo Doanh thu theo Loại sản phẩm
            </h1>
            <p class="text-muted mb-0">
              Phân tích doanh thu bán hàng và hiệu suất kinh doanh theo từng
              loại sản phẩm
            </p>
          </div>
          <div class="d-flex gap-2">
            <button
              class="btn btn-outline-success btn-sm"
              onclick="exportChart()"
            >
              <i class="fas fa-download me-1"></i>Xuất báo cáo
            </button>
            <button
              class="btn btn-outline-primary btn-sm"
              onclick="printReport()"
            >
              <i class="fas fa-print me-1"></i>In báo cáo
            </button>
          </div>
        </div>

        <!-- Summary Statistics -->
        <div class="row mb-4">
          <c:set var="totalRevenue" value="0" />
          <c:set var="totalQuantity" value="0" />
          <c:set var="categoryCount" value="0" />
          <c:set var="maxRevenue" value="0" />
          <c:forEach var="e" items="${data}">
            <c:set var="totalRevenue" value="${totalRevenue + e[2]}" />
            <c:set var="totalQuantity" value="${totalQuantity + e[1]}" />
            <c:set var="categoryCount" value="${categoryCount + 1}" />
            <c:if test="${e[2] > maxRevenue}">
              <c:set var="maxRevenue" value="${e[2]}" />
              <c:set var="topCategory" value="${e[0]}" />
            </c:if>
          </c:forEach>

          <div class="col-xl-3 col-md-6 mb-4">
            <div
              class="card border-left-success shadow h-100 py-2 revenue-card"
            >
              <div class="card-body">
                <div class="row no-gutters align-items-center">
                  <div class="col mr-2">
                    <div
                      class="text-xs font-weight-bold text-success text-uppercase mb-1"
                    >
                      Tổng doanh thu
                    </div>
                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                      <f:formatNumber value="${totalRevenue}" pattern="#,###" />
                      VNĐ
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
            <div class="card border-left-info shadow h-100 py-2 revenue-card">
              <div class="card-body">
                <div class="row no-gutters align-items-center">
                  <div class="col mr-2">
                    <div
                      class="text-xs font-weight-bold text-info text-uppercase mb-1"
                    >
                      Số sản phẩm bán
                    </div>
                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                      <f:formatNumber
                        value="${totalQuantity}"
                        pattern="#,###"
                      />
                    </div>
                  </div>
                  <div class="col-auto">
                    <i class="fas fa-shopping-cart fa-2x text-gray-300"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="col-xl-3 col-md-6 mb-4">
            <div
              class="card border-left-warning shadow h-100 py-2 revenue-card"
            >
              <div class="card-body">
                <div class="row no-gutters align-items-center">
                  <div class="col mr-2">
                    <div
                      class="text-xs font-weight-bold text-warning text-uppercase mb-1"
                    >
                      Doanh thu TB/loại
                    </div>
                    <div class="h5 mb-0 font-weight-bold text-gray-800">
                      <f:formatNumber
                        value="${totalRevenue / categoryCount}"
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

          <div class="col-xl-3 col-md-6 mb-4">
            <div
              class="card border-left-primary shadow h-100 py-2 revenue-card"
            >
              <div class="card-body">
                <div class="row no-gutters align-items-center">
                  <div class="col mr-2">
                    <div
                      class="text-xs font-weight-bold text-primary text-uppercase mb-1"
                    >
                      Loại bán chạy nhất
                    </div>
                    <div class="h6 mb-0 font-weight-bold text-gray-800">
                      ${topCategory}
                    </div>
                    <small class="text-muted">
                      <f:formatNumber value="${maxRevenue}" pattern="#,###" />
                      VNĐ
                    </small>
                  </div>
                  <div class="col-auto">
                    <i class="fas fa-crown fa-2x text-gray-300"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Charts Row -->
        <div class="row mb-4">
          <!-- Doughnut Chart -->
          <div class="col-xl-6 col-lg-6">
            <div class="card shadow mb-4">
              <div
                class="card-header py-3 d-flex flex-row align-items-center justify-content-between"
              >
                <h6 class="m-0 font-weight-bold text-primary">
                  <i class="fas fa-chart-pie me-2"></i>Phân bố Doanh thu theo
                  Loại
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
                    <a
                      class="dropdown-item"
                      href="#"
                      onclick="toggleChartType('doughnut')"
                      >Biểu đồ donut</a
                    >
                    <a
                      class="dropdown-item"
                      href="#"
                      onclick="toggleChartType('pie')"
                      >Biểu đồ tròn</a
                    >
                    <a
                      class="dropdown-item"
                      href="#"
                      onclick="toggleChartType('polarArea')"
                      >Biểu đồ cực</a
                    >
                  </div>
                </div>
              </div>
              <div class="card-body">
                <div
                  class="chart-container"
                  style="position: relative; height: 350px"
                >
                  <canvas id="revenueChart"></canvas>
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
                  <i class="fas fa-chart-column me-2"></i>So sánh Doanh thu & Số
                  lượng
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
                    <a
                      class="dropdown-item"
                      href="#"
                      onclick="toggleBarChart('bar')"
                      >Biểu đồ cột</a
                    >
                    <a
                      class="dropdown-item"
                      href="#"
                      onclick="toggleBarChart('line')"
                      >Biểu đồ đường</a
                    >
                  </div>
                </div>
              </div>
              <div class="card-body">
                <div
                  class="chart-container"
                  style="position: relative; height: 350px"
                >
                  <canvas id="revenueBarChart"></canvas>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Performance Analysis -->
        <div class="row mb-4">
          <div class="col-12">
            <div class="card shadow">
              <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">
                  <i class="fas fa-analytics me-2"></i>Phân tích Hiệu suất theo
                  Loại sản phẩm
                </h6>
              </div>
              <div class="card-body">
                <div class="row">
                  <c:forEach var="e" items="${data}" varStatus="status">
                    <div class="col-xl-6 col-lg-6 mb-3">
                      <div class="card border-left-info h-100">
                        <div class="card-body py-3">
                          <div
                            class="d-flex justify-content-between align-items-center"
                          >
                            <div>
                              <h6 class="font-weight-bold text-primary mb-1">
                                ${e[0]}
                              </h6>
                              <div class="row text-xs">
                                <div class="col-6">
                                  <span class="text-muted">Doanh thu:</span>
                                  <strong class="text-success d-block">
                                    <f:formatNumber
                                      value="${e[2]}"
                                      pattern="#,###"
                                    />
                                    VNĐ
                                  </strong>
                                </div>
                                <div class="col-6">
                                  <span class="text-muted">Số lượng:</span>
                                  <strong class="text-info d-block">
                                    <f:formatNumber
                                      value="${e[1]}"
                                      pattern="#,###"
                                    />
                                  </strong>
                                </div>
                              </div>
                            </div>
                            <div class="text-right">
                              <c:set
                                var="revenuePercent"
                                value="${(e[2] / totalRevenue) * 100}"
                              />
                              <div class="text-xs text-muted">% Tổng DT</div>
                              <div
                                class="h6 mb-0 font-weight-bold text-gray-800"
                              >
                                <f:formatNumber
                                  value="${revenuePercent}"
                                  pattern="##.#"
                                />%
                              </div>
                            </div>
                          </div>
                          <div class="progress mt-2" style="height: 8px">
                            <div
                              class="progress-bar bg-gradient-success"
                              role="progressbar"
                              style="width: ${revenuePercent}%"
                              aria-valuenow="${revenuePercent}"
                              aria-valuemin="0"
                              aria-valuemax="100"
                            ></div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
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
                id="revenueDataTable"
                width="100%"
                cellspacing="0"
              >
                <thead class="table-dark">
                  <tr>
                    <th><i class="fas fa-tag me-1"></i>Loại sản phẩm</th>
                    <th>
                      <i class="fas fa-shopping-cart me-1"></i>Số lượng bán
                    </th>
                    <th>
                      <i class="fas fa-dollar-sign me-1"></i>Tổng doanh thu
                    </th>
                    <th><i class="fas fa-arrow-down me-1"></i>Giá thấp nhất</th>
                    <th><i class="fas fa-arrow-up me-1"></i>Giá cao nhất</th>
                    <th>
                      <i class="fas fa-chart-line me-1"></i>Giá trung bình
                    </th>
                    <th><i class="fas fa-percentage me-1"></i>% Doanh thu</th>
                    <th><i class="fas fa-calculator me-1"></i>DT/SP</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="e" items="${data}">
                    <tr>
                      <td>
                        <div class="d-flex align-items-center">
                          <div
                            class="me-2"
                            style="
                              width: 12px;
                              height: 12px;
                              border-radius: 50%;
                              background-color: #1cc88a;
                            "
                          ></div>
                          <strong>${e[0]}</strong>
                        </div>
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
                      <td>
                        <f:formatNumber value="${e[3]}" pattern="#,###" /> VNĐ
                      </td>
                      <td>
                        <f:formatNumber value="${e[4]}" pattern="#,###" /> VNĐ
                      </td>
                      <td>
                        <f:formatNumber value="${e[5]}" pattern="#,###" /> VNĐ
                      </td>
                      <td>
                        <c:set
                          var="percentage"
                          value="${(e[2] / totalRevenue) * 100}"
                        />
                        <div class="progress" style="height: 20px">
                          <div
                            class="progress-bar bg-success"
                            role="progressbar"
                            style="width: ${percentage}%"
                            aria-valuenow="${percentage}"
                            aria-valuemin="0"
                            aria-valuemax="100"
                          >
                            <f:formatNumber
                              value="${percentage}"
                              pattern="##.#"
                            />%
                          </div>
                        </div>
                      </td>
                      <td>
                        <c:set var="revenuePerItem" value="${e[2] / e[1]}" />
                        <span class="text-primary font-weight-bold">
                          <f:formatNumber
                            value="${revenuePerItem}"
                            pattern="#,###"
                          />
                          VNĐ
                        </span>
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
          const revenueData = {
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

          // Color palette
          const colors = [
            '#1cc88a',
            '#4e73df',
            '#36b9cc',
            '#f6c23e',
            '#e74a3b',
            '#858796',
            '#fd7e14',
            '#6f42c1',
            '#e83e8c',
            '#20c997',
          ];

          // Doughnut Chart
          const doughnutCtx = document
            .getElementById('revenueChart')
            .getContext('2d');
          let revenueChart = new Chart(doughnutCtx, {
            type: 'doughnut',
            data: {
              labels: revenueData.labels,
              datasets: [
                {
                  data: revenueData.revenues,
                  backgroundColor: colors,
                  borderColor: '#fff',
                  borderWidth: 3,
                  hoverOffset: 8,
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
                    font: {
                      size: 12,
                    },
                  },
                },
                tooltip: {
                  callbacks: {
                    label: function (context) {
                      const value = context.raw;
                      const total = context.dataset.data.reduce(
                        (a, b) => a + b,
                        0
                      );
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
              cutout: '50%',
            },
          });

          // Mixed Bar Chart
          const barCtx = document
            .getElementById('revenueBarChart')
            .getContext('2d');
          let revenueBarChart = new Chart(barCtx, {
            type: 'bar',
            data: {
              labels: revenueData.labels,
              datasets: [
                {
                  label: 'Doanh thu (triệu VNĐ)',
                  data: revenueData.revenues.map(r => r / 1000000), // Convert to millions
                  backgroundColor: colors.map(color => color + '80'),
                  borderColor: colors,
                  borderWidth: 2,
                  yAxisID: 'y',
                },
                {
                  label: 'Số lượng bán',
                  data: revenueData.quantities,
                  type: 'line',
                  borderColor: '#e74a3b',
                  backgroundColor: '#e74a3b20',
                  borderWidth: 3,
                  fill: false,
                  tension: 0.4,
                  yAxisID: 'y1',
                },
              ],
            },
            options: {
              responsive: true,
              maintainAspectRatio: false,
              interaction: {
                mode: 'index',
                intersect: false,
              },
              plugins: {
                legend: {
                  position: 'top',
                },
                tooltip: {
                  callbacks: {
                    label: function (context) {
                      let label = context.dataset.label || '';
                      if (label) {
                        label += ': ';
                      }
                      if (context.datasetIndex === 0) {
                        label +=
                          (context.raw * 1000000).toLocaleString() + ' VNĐ';
                      } else {
                        label += context.raw.toLocaleString() + ' sản phẩm';
                      }
                      return label;
                    },
                  },
                },
              },
              scales: {
                y: {
                  type: 'linear',
                  display: true,
                  position: 'left',
                  title: {
                    display: true,
                    text: 'Doanh thu (triệu VNĐ)',
                  },
                  ticks: {
                    callback: function (value) {
                      return value.toLocaleString();
                    },
                  },
                },
                y1: {
                  type: 'linear',
                  display: true,
                  position: 'right',
                  title: {
                    display: true,
                    text: 'Số lượng bán',
                  },
                  grid: {
                    drawOnChartArea: false,
                  },
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
            revenueChart.config.type = type;
            if (type === 'polarArea') {
              revenueChart.config.options.cutout = 0;
            } else if (type === 'doughnut') {
              revenueChart.config.options.cutout = '50%';
            } else {
              revenueChart.config.options.cutout = 0;
            }
            revenueChart.update();
          }

          function toggleBarChart(type) {
            if (type === 'line') {
              revenueBarChart.config.data.datasets[0].type = 'line';
              revenueBarChart.config.data.datasets[0].fill = false;
              revenueBarChart.config.data.datasets[0].tension = 0.4;
            } else {
              revenueBarChart.config.data.datasets[0].type = 'bar';
              revenueBarChart.config.data.datasets[0].fill = false;
            }
            revenueBarChart.update();
          }

          // Export functions
          function exportChart() {
            const link = document.createElement('a');
            link.download = 'bao-cao-doanh-thu-theo-loai.png';
            link.href = revenueChart.toBase64Image();
            link.click();
          }

          function printReport() {
            window.print();
          }

          // DataTable initialization
          $(document).ready(function () {
            $('#revenueDataTable').DataTable({
              language: {
                url: '//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json',
              },
              order: [[2, 'desc']], // Sort by revenue descending
              pageLength: 25,
              responsive: true,
              dom: 'Bfrtip',
              buttons: ['copy', 'csv', 'excel', 'pdf', 'print'],
            });
          });
        </script>
      </div>
    </div>
  </div>
</div>
