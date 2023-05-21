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
      changeTab(tab) {
        this.activeTab = tab;
      },
    },
  };
</script>
  
<template>
    <div>
      <div class="tabs">
        <button :class="{ active: activeTab === 'buy' }" @click="changeTab('buy')">Buy (P2P)</button>
        <button :class="{ active: activeTab === 'sell' }" @click="changeTab('sell')">Sell (P2P)</button>
        <button :class="{ active: activeTab === 'SPOT' }" @click="changeTab('spot')">Spot</button>
      </div>
  
      <div v-show="activeTab === 'buy'">
        <h2>Buy Section</h2>
        <!-- Contenu de la section Achat -->
        <BuyPage/>
      </div>
  
      <div v-show="activeTab === 'sell'">
        <h2>Sell Section</h2>
        <!-- Contenu de la section Vente -->
        <SellPage/>
      </div>

      <div v-if="activeTab === 'spot'">
        <h2>Spot Section</h2>
        <!-- Contenu de la section Spot -->
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