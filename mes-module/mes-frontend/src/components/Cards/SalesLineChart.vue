<template>
  <div
    class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded bg-blueGray-700"
  >
    <div class="rounded-t mb-0 px-4 py-3 bg-transparent">
      <div class="flex flex-wrap items-center">
        <div class="relative w-full max-w-full flex-grow flex-1">
          <h6 class="uppercase text-blueGray-100 mb-1 text-xs font-semibold">
            Overview
          </h6>
          <h2 class="text-white text-xl font-semibold">
            Sales value
          </h2>
        </div>
      </div>
    </div>
    <div class="p-4 flex-auto">
      <!-- Chart -->
      <div class="relative h-350-px">
        <canvas id="line-chart"></canvas>
      </div>
    </div>
  </div>
</template>

<script>
import Chart from 'chart.js';
import axios from 'axios';

export default {
  data() {
    return {
      chartData: null,
    };
  },
  async mounted() {
    await this.fetchData();
    this.renderChart();
  },
  methods: {
    async fetchData() {
      try {
        const response = await axios.get('http://localhost:3001/production/orders/value-by-month-year');
        this.chartData = response.data;
      } catch (error) {
        console.error('Error fetching data', error);
      }
    },
    renderChart() {
      if (!this.chartData) return;

      const labels = this.chartData.map(item => item.month_year);
      const data = this.chartData.map(item => parseFloat(item.total_order_value));

      const config = {
        type: 'line',
        data: {
          labels,
          datasets: [
            {
              label: 'Total Order Value',
              backgroundColor: '#4c51bf',
              borderColor: '#4c51bf',
              data,
              fill: false,
            },
          ],
        },
        options: {
          maintainAspectRatio: false,
          responsive: true,
          title: {
            display: false,
            text: 'Sales Charts',
            fontColor: 'white',
          },
          legend: {
            labels: {
              fontColor: 'white',
            },
            align: 'end',
            position: 'bottom',
          },
          tooltips: {
            mode: 'index',
            intersect: false,
          },
          hover: {
            mode: 'nearest',
            intersect: true,
          },
          scales: {
            xAxes: [
              {
                ticks: {
                  fontColor: 'rgba(255,255,255,.7)',
                },
                display: true,
                scaleLabel: {
                  display: false,
                  labelString: 'Month',
                  fontColor: 'white',
                },
                gridLines: {
                  display: false,
                  borderDash: [2],
                  borderDashOffset: [2],
                  color: 'rgba(33, 37, 41, 0.3)',
                  zeroLineColor: 'rgba(0, 0, 0, 0)',
                  zeroLineBorderDash: [2],
                  zeroLineBorderDashOffset: [2],
                },
              },
            ],
            yAxes: [
              {
                ticks: {
                  fontColor: 'rgba(255,255,255,.7)',
                },
                display: true,
                scaleLabel: {
                  display: false,
                  labelString: 'Value',
                  fontColor: 'white',
                },
                gridLines: {
                  borderDash: [3],
                  borderDashOffset: [3],
                  drawBorder: false,
                  color: 'rgba(255, 255, 255, 0.15)',
                  zeroLineColor: 'rgba(33, 37, 41, 0)',
                  zeroLineBorderDash: [2],
                  zeroLineBorderDashOffset: [2],
                },
              },
            ],
          },
        },
      };
      const ctx = document.getElementById('line-chart').getContext('2d');
      new Chart(ctx, config);
    },
  },
};
</script>
