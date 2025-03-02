<template>
  <div class="flex flex-wrap">
    <div class="w-full lg:w-8/12 px-4">
      <OrderForms />
    </div>
    <div class="w-full lg:w-4/12 px-4">
      <CardProfile />
    </div>
  </div>
</template>
<script>
import OrderForms from "@/components/Cards/OrderForms.vue";
import CardProfile from "@/components/Cards/CardProfile.vue";

export default {
  components: {
    OrderForms,
    CardProfile,
  },
};
</script>
