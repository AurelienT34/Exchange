<script>
  import BuyPage from './Buypage.vue'
  import SellPage from './Sellpage.vue'
  import Spot from './Spot.vue'

  export default {
    data() {
      return {
        activeTab: 'buy',
      };
    },
    components: {
      BuyPage,
      SellPage,
      Spot,
    },
    methods: {
      // Change the active tab
      changeTab(tab) {
        this.activeTab = tab;
      },
    },
  };
</script>
  
<template>
  <div>
    <div class="tabs">
      <!-- Buy tab -->
      <button :class="{ active: activeTab === 'buy' }" @click="changeTab('buy')">Buy (P2P)</button>
      <!-- Sell tab -->
      <button :class="{ active: activeTab === 'sell' }" @click="changeTab('sell')">Sell (P2P)</button>
      <!-- Spot tab -->
      <button :class="{ active: activeTab === 'SPOT' }" @click="changeTab('spot')">Spot</button>
    </div>

    <!-- Buy section -->
    <div v-show="activeTab === 'buy'">
      <h2>Buy Section</h2>
      <!-- Content of the Buy section -->
      <BuyPage/>
    </div>

    <!-- Sell section -->
    <div v-show="activeTab === 'sell'">
      <h2>Sell Section</h2>
      <!-- Content of the Sell section -->
      <SellPage/>
    </div>

    <!-- Spot section -->
    <div v-show="activeTab === 'spot'">
      <h2>Spot Section</h2>
      <!-- Content of the Spot section -->
      <Spot/>
    </div>

  </div>
</template>

<style>
.tabs {
  display: flex;
  justify-content: center;
}

.tabs button {
  padding: 10px 20px;
  background-color: #eee;
  border: none;
  cursor: pointer;
}

.tabs button.active {
  background-color: #ccc;
}

h2 {
  margin-top: 20px;
}
</style>