<template>
  <div class="flex flex-wrap mt-4">
    <!-- <div class="w-full mb-12 px-4">
      <card-table />
    </div> -->
    <div class="w-full mb-12 px-4">
      <inspection-orders color="dark" />
    </div>
  </div>
</template>

<script>
import InspectionOrders from "@/components/Cards/InspectionOrders.vue";

export default {
  components: {
    InspectionOrders,
  },
};
</script>
