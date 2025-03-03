<template>
  <div class="flex flex-wrap">
    <div class="w-full lg:w-8/12 px-4">
      <ProductionOrdersTable @order-selected="handleOrderSelected" @refresh-page="refreshPage" />
    </div>
    <div class="w-full lg:w-4/12 px-4">
      <OrderForms :selectedOrder="selectedOrder" @order-updated="refreshPage" />
    </div>
  </div>
</template>

<script>
import OrderForms from "@/components/Cards/OrderForms.vue";
import ProductionOrdersTable from "../../components/Cards/ProductionOrdersTable.vue";

export default {
  components: {
    OrderForms,
    ProductionOrdersTable,
  },
  data() {
    return {
      selectedOrder: null, // Store selected order
    };
  },
  methods: {
    handleOrderSelected(order) {
      this.selectedOrder = order; // Update selected order when emitted
    },
    refreshPage() {
      window.location.reload();
    },
  },
};
</script>

