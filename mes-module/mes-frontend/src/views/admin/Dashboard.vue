<template>
  <div>
    <div class="flex flex-wrap">
      <div class="w-full xl:w-8/12 mb-12 xl:mb-0 px-4">
        <sales-line-chart />
      </div>
      <div class="w-full xl:w-4/12 px-4">
        <total-order-bar-chart />
      </div>
    </div>
    <div class="flex flex-wrap mt-4">
      <div class="w-full xl:w-8/12 mb-12 xl:mb-0 px-4">
        <production-orders-table />
      </div>
      <div class="w-full xl:w-4/12 px-4">
        <production-steps-breakdown />
      </div>
    </div>
  </div>
</template>
<script>
import SalesLineChart from "@/components/Cards/SalesLineChart.vue";
import TotalOrderBarChart from "@/components/Cards/TotalOrderBarChart.vue";
import ProductionOrdersTable from "@/components/Cards/ProductionOrdersTable.vue";
import ProductionStepsBreakdown from "@/components/Cards/ProductionStepsBreakdown.vue";
export default {
  name: "dashboard-page",
  components: {
    SalesLineChart,
    TotalOrderBarChart,
    ProductionOrdersTable,
    ProductionStepsBreakdown,
  },
};
</script>
