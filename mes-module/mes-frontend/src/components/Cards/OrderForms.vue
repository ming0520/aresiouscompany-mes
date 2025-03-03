<template>
  <div>
    <!-- Order Form -->
    <div class="relative flex flex-col min-w-0 break-words w-full mb-6 shadow-lg rounded-lg bg-blueGray-100 border-0">
      <div class="rounded-t bg-white mb-0 px-6 py-6">
        <div class="text-center flex justify-between">
          <h6 class="text-blueGray-700 text-xl font-bold">Create Production Order</h6>
          <button
            class="bg-yellow-500 text-white font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md"
            type="button"
            @click="saveOrUpdateOrder"
          >
            {{ selectedOrder ? "Update Order" : "Save Order" }}
          </button>
        </div>
      </div>
      <div class="flex-auto px-4 lg:px-10 py-10 pt-0">
        <form>
          <h6 class="text-blueGray-400 text-sm mt-3 mb-6 font-bold uppercase">Order Information</h6>
          <div class="flex flex-wrap">
            <div v-for="field in fields" :key="field.id" class="w-full lg:w-6/12 px-4">
              <div class="relative w-full mb-3">
                <label class="block uppercase text-blueGray-600 text-xs font-bold mb-2" :for="field.id">
                  {{ field.label }}
                </label>
                <input
                  v-if="field.type !== 'select'"
                  :type="field.type"
                  class="border-0 px-3 py-3 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-sm shadow w-full"
                  v-model="order[field.model]"
                  :id="field.id"
                />
                <select
                  v-else
                  class="border-0 px-3 py-3 bg-white rounded text-sm shadow w-full"
                  v-model="order[field.model]"
                  :id="field.id"
                >
                  <option v-for="option in field.options" :key="option" :value="option">{{ option }}</option>
                </select>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    selectedOrder: Object, // Receive selected order from parent
  },
  watch: {
  selectedOrder: {
    handler(newOrder) {
      if (newOrder) {
        this.order = { ...newOrder };
        
        // Ensure date values are in 'YYYY-MM-DD' format
        if (this.order.start_date) {
          this.order.start_date = new Date(this.order.start_date).toISOString().split('T')[0];
        }
        if (this.order.due_date) {
          this.order.due_date = new Date(this.order.due_date).toISOString().split('T')[0];
        }
      }
    },
    deep: true,
  },
},

  data() {
    return {
      order: {
        order_number: '',
        product_name: '',
        quantity: '',
        start_date: '',
        due_date: '',
        status: '',
        order_value: '',
      },
      fields: [
        { id: 'order_number', label: 'Order Number', model: 'order_number', type: 'text' },
        { id: 'product_name', label: 'Product Name', model: 'product_name', type: 'text' },
        { id: 'quantity', label: 'Quantity', model: 'quantity', type: 'number' },
        { id: 'start_date', label: 'Start Date', model: 'start_date', type: 'date' },
        { id: 'due_date', label: 'Due Date', model: 'due_date', type: 'date' },
        { 
          id: 'status', 
          label: 'Status', 
          model: 'status', 
          type: 'select', 
          options: ['Order Placed', 'Order Confirmed', 'Order Processed', 'Order Picked', 'Order Packed', 'Order Dispatched', 'In Transit', 'Out for Delivery', 'Delivered', 'Order Returned', 'Order Cancelled', 'Order Refunded']
        },
        { id: 'order_value', label: 'Order Value', model: 'order_value', type: 'number' }
      ]
    };
  },
  methods: {
    async saveOrUpdateOrder() {
      if (this.selectedOrder) {
        await this.updateOrder();
      } else {
        await this.createOrder();
      }
    },
    async createOrder() {
      try {
        await fetch('http://localhost:3001/production/orders', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(this.order),
        });
        this.$emit('order-updated'); // Notify parent if needed
      } catch (error) {
        console.error('Error creating order:', error);
      }
    },
    async updateOrder() {
      try {
        const formattedOrder = { ...this.order };

        // Convert dates to ISO format before sending
        if (formattedOrder.start_date) {
          formattedOrder.start_date = new Date(formattedOrder.start_date).toISOString();
        }
        if (formattedOrder.due_date) {
          formattedOrder.due_date = new Date(formattedOrder.due_date).toISOString();
        }

        await fetch(`http://localhost:3001/production/orders/${this.order.order_number}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify(formattedOrder),
        });
        this.$emit('order-updated'); // Notify parent if needed
      } catch (error) {
        console.error('Error updating order:', error);
      }
    },
  },
};
</script>
