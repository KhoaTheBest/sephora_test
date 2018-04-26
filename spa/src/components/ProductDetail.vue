/* eslint-disable */
<template>
  <section>
    <div class="row">
      <div class="columns large-3 medium-6">
        <img :src="processedProduct.image_url">
      </div>
      <div class="columns large-9 medium-6" style="text-align: left;">
        <h4>{{processedProduct.name}}</h4>
        <strong>{{processedProduct.category}}</strong>
        <br>
        <strong class="text-danger" v-if="processedProduct.sold_out">SOLD OUT</strong>
        <div v-else>
          <span v-bind:class="{'sale-text': processedProduct.under_sale }">{{(processedProduct.price/ 10) | currency}}</span>
          <span class="text-danger" v-if="processedProduct.under_sale">{{(processedProduct.sale_price / 10) | currency}} ({{processedProduct.sale_text}})</span>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  data() {
    return {
      product: {}
    };
  },
  mounted() {
    this.getProductById(this.$route.params.productId);
  },
  methods: {
    getProductById(productId) {
      axios
        .get("http://206.189.38.24:8888/api/v1/products/" + productId)
        .then(response => {
          this.product = response.data.product;
        })
        .catch(error => {
          console.error(error);
        });
    }
  },
  computed: {
    processedProduct() {
      this.product.image_url = "http://placehold.it/300x200?text=N/A";
      return this.product;
    }
  }
};
</script>

<style>
.sale-text {
  text-decoration: line-through;
}
.text-danger {
  color: red;
}
</style>

