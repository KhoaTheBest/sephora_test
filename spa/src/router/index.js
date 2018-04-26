import Vue from 'vue';
import Router from 'vue-router';
import NxCard from 'nx-card';
import PrettyCheckbox from 'pretty-checkbox-vue';
import VueCurrencyFilter from 'vue-currency-filter';
import ProductList from '@/components/ProductList';
import ProductDetail from '@/components/ProductDetail';

Vue.use(Router);
Vue.use(NxCard);
Vue.use(PrettyCheckbox);
Vue.use(VueCurrencyFilter,
  {
    symbol: '$',
    thousandsSeparator: '.',
    fractionCount: 2,
    fractionSeparator: ',',
    symbolPosition: 'front',
    symbolSpacing: true,
  });

export default new Router({
  // mode: 'history',
  routes: [
    {
      path: '/products',
      component: ProductList,
    },
    {
      path: '/products/:productId',
      name: 'productDetail',
      component: ProductDetail,
    },
  ],
});
