<template>
  <div class="flex flex-wrap">
    <div class="w-full lg:w-8/12 px-4">
      <ProductionOrdersTable/>
    </div>
    <div class="w-full lg:w-4/12 px-4">
      <!-- <CardProfile /> -->
      <OrderForms />
    </div>
  </div>
</template>
<script>
import OrderForms from "@/components/Cards/OrderForms.vue";
import ProductionOrdersTable from "../../components/Cards/ProductionOrdersTable.vue";
// import CardProfile from "@/components/Cards/CardProfile.vue";

export default {
  components: {
    OrderForms,
    ProductionOrdersTable,
    // CardProfile,
  },
};
</script>
