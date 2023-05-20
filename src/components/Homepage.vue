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

    checkMetamaskConnection() {
      if (window.ethereum && window.ethereum.selectedAddress) {
        this.isConnected = true;
      }
    },
  },

  mounted() {
    this.checkMetamaskConnection();
  },

};

</script>


<template>
  <div>
    <div class="HomePage" v-if="!isConnected">
      <h1>Bienvenue sur la page d'accueil</h1>
      <p>Connectez votre portefeuille Metamask pour commencer à acheter et vendre des crypto-monnaies.</p>
     <button v-if="!isConnected" @click="connectMetamask">Connecter Metamask</button>
    </div>
    <Market v-if="isConnected"/>
</div>
  
</template>