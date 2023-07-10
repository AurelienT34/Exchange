<template>
  <div>
    <h2>Add a sales offer</h2>
    <form @submit.prevent="ajouterVente">
      <div class="form-container">
        <!-- Crypto selection -->
        <div class="form-group">
          <label class="label" for="crypto">Crypto:</label>
          <select class="input" id="crypto" v-model="nouvelleVente.crypto" required>
            <option value="BTC">BTC</option>
            <option value="ETH">ETH</option>
          </select>
        </div>
        <!-- Price input -->
        <div class="form-group">
          <label class="label" for="prix">Price:</label>
          <input class="input" type="number" id="prix" v-model="nouvelleVente.prix" required>
        </div>
        <!-- Quantity input -->
        <div class="form-group">
          <label class="label" for="quantite">Quantity:</label>
          <input class="input" type="number" id="quantite" v-model="nouvelleVente.quantite" required step="0.00000001">
        </div>
        <!-- Sell button -->
        <div class="form-group">
          <button class="button" type="submit">Sell</button>
        </div>
      </div>
    </form>

    <h2>Sells List</h2>
    <div class="ventes-liste">
      <div v-for="vente in ventesTriees" :key="vente.id" class="vente-ticket">
        <!-- Close button for the seller to remove the offer -->
        <div class="close-btn" @click="supprimerTicket(vente.id)" v-if="vente.vendeur === adresseWallet">&#10006;</div>
        <!-- Crypto logo -->
        <img :src="getLogoCrypto(vente.crypto)" :alt="vente.crypto" class="crypto-logo">
        <div class="ticket-info">
          <div class="pair">{{ vente.crypto }}/USDT</div>
          <div class="prix">Price: {{ vente.prix }} $</div>
          <div class="quantite">Quantity: {{ vente.quantite }}</div>
          <div class="total_price">Total value: {{ vente.quantite * vente.prix }} $</div>
          <div class="date">{{ formatDate(vente.date) }}</div>
          <!-- Buy button -->
          <button @click="acheterCrypto(vente.id, vente.prix, vente.vendeur, vente.quantite)">BUY</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Web3 from 'web3';

export default {
  data() {
    return {
      nouvelleVente: {
        crypto: '',
        prix: 0,
      },
      ventes: [], // contient toutes les propositions de ventes
      adresseWallet: null, // Variable pour stocker l'adresse du wallet actuellement connecté
    };
  },
  computed: {
    ventesTriees() {
      return this.ventes.sort((a, b) => a.prix - b.prix);
    },
  },
  methods: {
    async ajouterVente() {
      try {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.enable();

        const accounts = await web3.eth.getAccounts();
        const adresseVendeur = accounts[0];
        this.adresseWallet = accounts[0];

        // Vérifier le solde du compte du vendeur
        const soldeWei = await web3.eth.getBalance(adresseVendeur);
        const soldeEth = web3.utils.fromWei(soldeWei, 'ether');

        // Convertir le prix en nombre et vérifier si le vendeur possède suffisamment d'ETH
        const prixEth = parseFloat(this.nouvelleVente.prix);
        if (isNaN(prixEth) || prixEth <= 0) {
          throw new Error("Le prix n'est pas un nombre valide");
        }

        if (parseFloat(soldeEth) < parseFloat(this.nouvelleVente.quantite)) {
          throw new Error("Le vendeur ne possède pas suffisamment d'ETH");
        }

        if (typeof web3 !== 'undefined') {
          web3.eth.requestAccounts()
            .then((accounts) => {
              const adresseWallet = accounts[0]; // Adresse du wallet connecté
              const id = Date.now();

              this.ventes.push({
                id,
                crypto: this.nouvelleVente.crypto,
                prix: this.nouvelleVente.prix,
                quantite: this.nouvelleVente.quantite,
                vendeur: adresseWallet,
                date: new Date(),
              });

              this.nouvelleVente.crypto = '';
              this.nouvelleVente.prix = 0;
              this.nouvelleVente.quantite = 0;
            })
            .catch((error) => {
              console.error('Erreur de connexion à MetaMask:', error);
            });
        } else {
          console.error('MetaMask non détecté');
        }
      } catch (error) {
        console.error('Erreur lors de la création de la vente:', error);
      }
    },
    getLogoCrypto(crypto) {
      if (crypto === 'BTC') {
        return 'https://upload.wikimedia.org/wikipedia/commons/4/46/Bitcoin.svg';
      } else if (crypto === 'ETH') {
        return 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025';
      } else {
        return '';
      }
    },
    formatDate(date) {
      const options = {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
      };
      return date.toLocaleString('fr-FR', options);
    },
    //-------------BUY----------------
    async acheterCrypto(id, prix, adresseVendeur, montantEth) {
      try {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.enable();

        const accounts = await web3.eth.getAccounts();
        const adresseAcheteur = accounts[0];
        const montantWei = web3.utils.toWei((prix * montantEth).toString(), 'ether');

        const transaction = await web3.eth.sendTransaction({
          from: adresseAcheteur,
          to: adresseVendeur,
          value: montantWei,
        });

        console.log('Transaction hash:', transaction.transactionHash);
        const confirmation = await web3.eth.getTransactionReceipt(transaction.transactionHash);
        if (confirmation && confirmation.status) {
          // La transaction d'achat est confirmée, déclencher la vente
          this.vendreCrypto(id, adresseAcheteur, adresseVendeur, montantEth);
        } else {
          console.error('La transaction d\'achat a échoué');
        }
      } catch (error) {
        console.error('Erreur de transaction:', error);
  }
    },
    //------------------------SELL----------------
    async vendreCrypto(id, adresseAcheteur, adresseVendeur, montantEth) {
      try {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
        const montantWei = web3.utils.toWei(montantEth.toString(), 'ether');

        const transaction = await web3.eth.sendTransaction({
          from: adresseAcheteur,
          to: adresseVendeur, // Remplacez par l'adresse de l'acheteur
          value: montantWei,
        });

        console.log('Transaction hash:', transaction.transactionHash);
        this.supprimerTicket(id);

      } catch (error) {
        console.error('Erreur de transaction:', error);
      }
    },
    async supprimerTicket(id) {
      try {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
        const accounts = await web3.eth.getAccounts();
        this.adresseWallet = accounts[0];

        const index = this.ventes.findIndex(vente => vente.id === id);
        if (index !== -1 && this.ventes[index].vendeur === this.adresseWallet) {
          this.ventes.splice(index, 1);
        }
      } catch (error) {
        console.error('Erreur suppression:', error);
      }
    },
  },
};
</script>


<style>

.form-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: flex-start;
}

.form-group {
  display: flex;
  flex-direction: column;
  margin: 10px;
}

.label {
  font-weight: bold;
  margin-bottom: 5px;
}

.input {
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-bottom: 10px;
}

.button {
  padding: 13px 15px;
  background-color: #337ab7;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  margin-top: 27px;
}

.button:hover {
  background-color: #23527c;
}

.ventes-liste {
  display: flex;
  flex-wrap: wrap;
}

.vente-ticket {
  position: relative;
  display: flex;
  align-items: center;
  margin-bottom: 10px;
  padding: 10px;
  border: 1px solid #ccc;
}

.close-btn {
  position: absolute;
  top: 0;
  right: 0;
  padding: 5px;
  color: red;
  cursor: pointer;
}

.crypto-logo {
  width: 50px;
  height: 50px;
  margin-right: 10px;
}

.ticket-info {
  display: flex;
  flex-direction: column;
  width: 200px;
}

.pair {
  font-weight: bold;
}

.date {
  font-size: 12px;
  color: #888;
}
</style>