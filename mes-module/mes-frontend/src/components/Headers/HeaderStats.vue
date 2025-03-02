<template>
  <!-- Header -->
  <div class="relative bg-emerald-600 md:pt-32 pb-32 pt-12">
    <div class="px-4 md:px-10 mx-auto w-full">
      <div>
        <!-- Card stats -->
        <div class="flex flex-wrap">
          <div class="w-full lg:w-6/12 xl:w-3/12 px-4">
            <card-stats
              statSubtitle="MACHINE AVERAGE UTILIZATION"
              :statTitle="averageUtilization"
              statArrow="up"
              statPercent="3.48"
              statPercentColor="text-emerald-500"
              statDescripiron="Since last month"
              statIconName="far fa-chart-bar"
              statIconColor="bg-red-500"
            />
          </div>
          <div class="w-full lg:w-6/12 xl:w-3/12 px-4">
            <card-stats
              statSubtitle="PENDING ORDERS"
              :statTitle="pendingOrders"
              statArrow="down"
              statPercent="3.48"
              statPercentColor="text-red-500"
              statDescripiron="Since last week"
              statIconName="fas fa-chart-pie"
              statIconColor="bg-orange-500"
            />
          </div>
          <div class="w-full lg:w-6/12 xl:w-3/12 px-4">
            <card-stats
              statSubtitle="INCOMPLETE STEPS"
              :statTitle="incompleteSteps"
              statArrow="down"
              statPercent="1.10"
              statPercentColor="text-orange-500"
              statDescripiron="Since yesterday"
              statIconName="fas fa-users"
              statIconColor="bg-pink-500"
            />
          </div>
          <div class="w-full lg:w-6/12 xl:w-3/12 px-4">
            <card-stats
              statSubtitle="PERFORMANCE"
              statTitle="49.65%"
              statArrow="up"
              statPercent="12"
              statPercentColor="text-emerald-500"
              statDescripiron="Since last month"
              statIconName="fas fa-percent"
              statIconColor="bg-emerald-500"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import CardStats from "@/components/Cards/CardStats.vue";

export default {
  components: {
    CardStats,
  },
  data() {
    return {
      averageUtilization: "0.00",
      pendingOrders: "0",
      incompleteSteps: "0", // Add new data property
    };
  },
  async mounted() {
    try {
      // Fetch average machine utilization data
      const avgUtilizationResponse = await axios.get('http://localhost:3001/metrics/average-machine-utilization');
      this.averageUtilization = avgUtilizationResponse.data.average_utilization;

      // Fetch total pending orders count
      const pendingOrdersResponse = await axios.get('http://localhost:3001/production/orders/pending-sum');
      this.pendingOrders = pendingOrdersResponse.data.total_pending_order_number;

      // Fetch count of incomplete production steps
      const incompleteStepsResponse = await axios.get('http://localhost:3001/production/steps/incomplete-count');
      this.incompleteSteps = incompleteStepsResponse.data.incomplete_count; // Update new data property
    } catch (fetchError) {
      console.error('Error fetching data:', fetchError);
    }
  },
};
</script>
