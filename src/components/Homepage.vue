<template>
  <div>
    <!-- Home Page -->
    <div class="HomePage" v-if="!isConnected">
      <h1>Welcome to the Home Page</h1>
      <p>Connect your Metamask wallet to start buying and selling cryptocurrencies.</p>
      <button v-if="!isConnected" @click="connectMetamask">Connect Metamask</button>
    </div>
    <!-- Market Component -->
    <Market v-if="isConnected" />
  </div>
</template>

<script>
import Market from './Market.vue'

export default {
  data() {
    return {
      isConnected: false,
    };
  },
  components: {
    Market
  },
  methods: {
    // Connect to Metamask
    async connectMetamask() {
      if (window.ethereum) {
        try {
          await window.ethereum.request({ method: 'eth_requestAccounts' });
          this.isConnected = true;
        } catch (error) {
          console.error(error);
        }
      } else {
        console.error('Metamask not found');
      }
    },

    // Check Metamask connection
    checkMetamaskConnection() {
      if (window.ethereum && window.ethereum.selectedAddress) {
        this.isConnected = true;
      }
    },
  },

  mounted() {
    // Check Metamask connection on component mount
    this.checkMetamaskConnection();
  },
};
</script>