/* eslint-disable */
<template>
  <section>
    <div class="row">
      <div class="columns large-3 medium-6">
        <div style="text-align: left">
          <h4>Categories</h4>
          <div v-for="(category,index) in categories" :key="index">  
             <p-check class="p-icon p-rotate" color="success" v-bind:class="{'p-locked': category.locked}" v-model="category.selected" v-on:change="onCategoryChange(category)">
                <i slot="extra" class="icon mdi mdi-check"></i>
                {{category.title}}
            </p-check>
          </div>
        </div>
        <div style="text-align: left">
          <h4>Price Range</h4>
          <div v-for="(priceRange,index) in priceRanges" :key="index">  
             <p-check class="p-icon p-round" name="priceRange" v-on:change="onPriceChange(priceRange)" color="success" v-model="priceRange.selected" >
                <i slot="extra" class="icon mdi mdi-check"></i>
                {{priceRange.title}}
            </p-check>
          </div>
        </div>
      </div>
      <div class="columns large-9 medium-6">
        <div style="text-align: right; margin-bottom: 20px;">
          <p-check class="p-icon p-plain" color="success-o" off-color="success-o" toggle v-on:change="onPriceOrderChange()" v-model="isAscendOrder"> 
              <i class="icon mdi mdi-sort-ascending" slot="extra"></i>
              Price: Low to High
              <i class="icon mdi mdi-sort-descending" slot="off-extra"></i>
              <label slot="off-label">Price: High to Low</label>
          </p-check>
        </div>
        <div class="row" v-for="(products,index) in processedProducts" :key="index">
          <div class="columns large-3 medium-6" v-for="(product,index) in products" :key="index">
            <router-link :to="{ name: 'productDetail', params: { productId: product.id }}">
              <div class="card">
                <div class="card-divider">
                {{ product.name }}
                <br>
                <strong>{{ product.category }}</strong>
                </div>
                <a :href="product.url" target="_blank"><img :src="product.image_url"></a>
                <div class="card-section">
                  <p>{{ (product.price/100) | currency }}</p>
                </div>
              </div>
            </router-link>
          </div>
        </div>

        <pagination :records="totalRecords" :per-page="10" @paginate="setPage"></pagination>
      </div>
    </div>
  </section>
</template>


<script>
import queryString from "query-string";
import { Pagination } from "vue-pagination-2";

var queryParams = {
  c: "makeup,hair,face,body",
  min_pr: 0,
  max_pr: 2000,
  sort: "asc",
  page: 1
};

export default {
  data() {
    return {
      currentPage: 1,
      totalRecords: 0,
      productList: [],
      categories: [
        {
          title: "Make-up",
          value: "makeup",
          selected: true,
          locked: false
        },
        {
          title: "Hair",
          value: "hair",
          selected: true,
          locked: false
        },
        {
          title: "Face",
          value: "face",
          selected: true,
          locked: false
        },
        {
          title: "Body",
          value: "body",
          selected: true,
          locked: false
        }
      ],
      isAscendOrder: true,
      priceRanges: [
        {
          title: "0 - 20$",
          selected: true,
          values: {
            from: 0,
            to: 2000
          }
        },
        {
          title: "10$ - 30$",
          values: {
            from: 1000,
            to: 3000
          }
        },
        {
          title: "20$ - 40$",
          values: {
            from: 2000,
            to: 4000
          }
        },
        {
          title: "40$ - 60$",
          values: {
            from: 4000,
            to: 6000
          }
        }
      ]
    };
  },
  mounted() {
    this.getProducts();
  },
  components: {
    Pagination
  },
  methods: {
    setPage: function(page) {
      queryParams.page = page;
      this.getProducts();
    },
    getProducts() {
      let queryParts = queryString.stringify(queryParams);
      let url = "http://206.189.38.24:8888/api/v1/products?" + queryParts;

      axios
        .get(url)
        .then(response => {
          this.productList = response.data.products;
          this.currentPage = response.data.current_page;
          this.totalRecords = response.data.total_records;
        })
        .catch(error => {
          console.error(error);
        });
    },
    onCategoryChange(category) {
      let arrayCategories = queryParams.c.split(",");
      if (category.selected) {
        queryParams.c += "," + category.value;
      } else {
        var foundIndex;
        arrayCategories.forEach((categoryItem, index) => {
          if (categoryItem === category.value) {
            foundIndex = index;
            return;
          }
        });
        if (foundIndex !== undefined) {
          arrayCategories.splice(foundIndex, 1);
        }

        queryParams.c = arrayCategories.join(",");
      }

      // Locked and Unlocked last selected item.
      this.categories.forEach(categoryItem => {
        if (
          arrayCategories.length === 1 &&
          categoryItem.value === arrayCategories[0]
        ) {
          categoryItem.locked = true;
        } else {
          categoryItem.locked = false;
        }
      });

      queryParams.page = 1;
      this.getProducts();
    },
    onPriceChange(priceRange) {
      queryParams.min_pr = priceRange.values.from;
      queryParams.max_pr = priceRange.values.to;
      queryParams.page = 1;

      this.priceRanges.forEach(priceItem => {
        if (priceItem.title === priceRange.title) {
          priceItem.selected = true;
        } else {
          priceItem.selected = false;
        }
      });

      this.getProducts();
    },
    onPriceOrderChange() {
      queryParams.sort = this.isAscendOrder ? "asc" : "desc";
      this.getProducts();
    }
  },
  computed: {
    processedProducts() {
      let products = this.productList;

      // Add image_url attribute
      products.map(product => {
        product.image_url = "http://placehold.it/300x200?text=N/A";
      });

      // Put Array into Chunks
      let i,
        j,
        chunkedArray = [],
        chunk = 4;
      for (i = 0, j = 0; i < products.length; i += chunk, j++) {
        chunkedArray[j] = products.slice(i, i + chunk);
      }
      return chunkedArray;
    }
  }
};
</script>

<style>
.pretty.p-icon .state .icon,
.pretty .state label:after,
.pretty .state label:before {
  top: 0;
}
</style>