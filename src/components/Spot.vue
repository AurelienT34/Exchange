<template>
  <div>
    <p>ETH on the DEX: {{ this.ethAmount / 10**18 }}</p>
    <p>USDT on the DEX: {{ this.usdtAmount / 10**18 }}</p>
    <h2 id="Manage" @click="toggleForm">Manage Your Profile</h2>
    <div class="form-container" v-show="isFormVisible">
      <!-- Form to add ETH to the DEX account -->
      <form @submit.prevent="addETH">
        <label class="label" for="prix">Number of ETH:</label>
        <input class="input" type="number" id="prix" v-model="ethToAdd" required>
        <button class="button" type="submit">Add ETH to your dex account</button>
      </form>
      <!-- Form to add USDT to the DEX account -->
      <form @submit.prevent="addUSDT">
        <label class="label" for="prix">Number of USDT:</label>
        <input class="input" type="number" id="prix" v-model="usdtToAdd" required>
        <button class="button" type="submit">Add USDT to your dex account</button>
      </form>
      <!-- Form to withdraw ETH from the DEX account -->
      <form @submit.prevent="withdrawMyETH(this.adresseWallet)">
        <label class="label" for="prix">Withdraw my ETH:</label>
        <input class="input" type="number" id="prix" v-model="withdrawAmount" required>
        <button class="button" type="submit">Withdraw</button>
      </form>
    </div>
    <br>
    <OrdersBook :ethAmount="ethAmount" :usdtAmount="usdtAmount"/>
  </div>
</template>

<script>
import { ethers } from 'ethers';
import Wallet from '../artifacts/contracts/Wallet.sol/Wallet.json';
import OrdersBook from './OrdersBook.vue'

export default {
  data() {
    return {
      adresseWallet: null,
      WalletAddress: "0x5FbDB2315678afecb367f032d93F642f64180aa3", // Adresse du contract
      ethAmount: null,
      usdtAmount: null,
      ethToAdd: null,
      usdtToAdd: null,
      withdrawAmount: null,
      isFormVisible: false,
    };
  },
  components: {
    OrdersBook,
  },
  methods: {
    toggleForm() {
      this.isFormVisible = !this.isFormVisible;
    },

    async getBalances() {
      if (typeof window.ethereum !== 'undefined') {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const contract = new ethers.Contract(this.WalletAddress, Wallet.abi, provider);
        try {
          let overrides = {
            from: accounts[0]
          }
          const data = await contract.getBalanceETH(overrides);
          this.ethAmount = String(data);
          this.usdtAmount = String(await contract.getBalanceUSDT(overrides));
          this.adresseWallet = accounts[0];
        }
        catch (error) {
          console.error('Une erreur est survenue:', error);
        }
      }
    },

    async addETH() {
      if (typeof window.ethereum !== 'undefined') {
        const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        try {
          const tx = {
            from: accounts[0],
            to: this.WalletAddress,
            value: ethers.utils.parseEther(String(this.ethToAdd))
          }
          const transaction = await signer.sendTransaction(tx);
          await transaction.wait();
          console.log('Vos eth ont bien été transférés sur le portefeuille ! ')
          this.getBalances();
          this.ethToAdd = 0;
        }
        catch (error) {
          console.error('Une erreur est survenue:', error);
        }
      }
    },

    async addUSDT() {
      if (this.usdtToAdd <= 0) {
        console.error('Le montant est incorrect');
        return;
      }
      if (typeof window.ethereum !== 'undefined') {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(this.WalletAddress, Wallet.abi, signer);
        try {
          const transaction = await contract.setUSDT(ethers.utils.parseEther(String(this.usdtToAdd)));
          await transaction.wait();
          console.log('Vos usdt ont bien été transférés sur le portefeuille ! ')
          this.getBalances();
          this.usdtToAdd = 0;
        }
        catch (error) {
          console.error('Une erreur est survenue:', error);
        }
      }
    },

    async withdrawMyETH(adresseWallet) {
      if (this.withdrawAmount > this.ethAmount) {
        console.error('Le montant ETH choisi est supérieur à ce que vous avez sur votre compte')
        return;
      }
      if (typeof window.ethereum !== 'undefined') {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(this.WalletAddress, Wallet.abi, signer);
        try {
          const transaction = await contract.withdrawETH(adresseWallet, ethers.utils.parseEther(String(this.withdrawAmount)));
          await transaction.wait();
          console.log('Vos eth ont bien été transférés sur votre metamask ! ')
          this.getBalances();
          this.withdrawAmount = 0;
        }
        catch (error) {
          console.error('Une erreur est survenue:', error);
        }
      }
    },
  },
  async mounted() {
    await this.getBalances();
  }
};
</script>

<style>
.form-container {
 width: 600px;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  margin: 0 auto;
}

#Manage {
  cursor: pointer;
  color: rgba(255, 217, 0, 0.5);
}
</style>