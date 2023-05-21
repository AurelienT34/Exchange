<template>
    <div>
        <p>ETH on the DEX : {{ this.ethAmount / 10**18}}</p>
        <p>USDT on the DEX : {{ this.usdtAmount / 10**18}}</p>
        <form @submit.prevent="addETH">
            <label class="label" for="prix">Number of ETH : </label>
            <input class="input" type="number" id="prix" v-model="ethToAdd" required>
            <button class="button" type="submit">Add ETH</button>
        </form>
        <form @submit.prevent="addUSDT">
            <label class="label" for="prix">Number of USDT : </label>
            <input class="input" type="number" id="prix" v-model="usdtToAdd" required>
            <button class="button" type="submit">Add USDT</button>
        </form>
    </div>
</template>

<script>
import { ethers } from 'ethers';
import Wallet from '../artifacts/contracts/Wallet.sol/Wallet.json';

export default {
  data() {
    return {
      WalletAddress : "0x5FbDB2315678afecb367f032d93F642f64180aa3", // Adresse du contract
      ethAmount: null,
      usdtAmount: null,
      ethToAdd: null,
      usdtToAdd: null,
    };
  },
  methods: {
    async getBalances() {
    if(typeof window.ethereum !== 'undefined') {
      const accounts = await window.ethereum.request({method:'eth_requestAccounts'});
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const contract = new ethers.Contract(this.WalletAddress, Wallet.abi, provider);
      try {
        let overrides = {
          from: accounts[0]
        }
        const data = await contract.getBalanceETH(overrides);
        this.ethAmount = (String(data));
        this.usdtAmount = (String (await contract.getBalanceUSDT(overrides)));
      }
      catch(error) {
        console.error('Une erreur est survenue : ',error);
      }
    }
  },

  async addETH() {
    if(typeof window.ethereum !== 'undefined') {
      const accounts = await window.ethereum.request({method:'eth_requestAccounts'});
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      try {
        const tx = {
          from: accounts[0],
          to: this.WalletAddress,
          value: ethers.utils.parseEther((String(this.ethToAdd)))
        }
        const transaction = await signer.sendTransaction(tx);
        await transaction.wait();
        console.log('Vos eth ont bien été transféré sur le portefeuille ! ')
        this.getBalances();
        this.ethToAdd = 0;
      }
      catch(error) {
        console.error('Une erreur est survenue :', error);
      }
    }
  },

  async addUSDT() {
    if(typeof window.ethereum !== 'undefined') {
      const accounts = await window.ethereum.request({method:'eth_requestAccounts'});
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(this.WalletAddress, Wallet.abi, signer);
      try {
        let overrides = {
          from: accounts[0]
        }
        
        const transaction = await contract.setUSDT(ethers.utils.parseEther((String(this.usdtToAdd))));
        await transaction.wait();
        console.log('Vos usdt ont bien été transféré sur le portefeuille ! ')
        this.getBalances();
        this.usdtToAdd = 0;
      }
      catch(error) {
        console.error('Une erreur est survenue : ',error);
      }
    }
  }

  },
  async mounted() {
    await this.getBalances();
  }
};


</script>
