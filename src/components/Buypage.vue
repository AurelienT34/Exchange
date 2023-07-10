<script>
import Web3 from 'web3';

export default {
  data() {
    return {
      nouvelleAchat: {
        crypto: '',
        prix: 0,
      },
      achats: [], // Contains all buy proposals
      adresseWallet: null, // Variable to store the currently connected wallet address
    };
  },
  computed: {
    achatsTriees() {
      return this.achats.sort((a, b) => a.prix - b.prix);
    },
  },
  methods: {
    // Add a buy proposal
    async ajouterAchat() {
      try {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.enable();

        const accounts = await web3.eth.getAccounts();
        const adresseVendeur = accounts[0];
        this.adresseWallet = accounts[0];

        // Check the seller's account balance
        const soldeWei = await web3.eth.getBalance(adresseVendeur);
        const soldeEth = web3.utils.fromWei(soldeWei, 'ether');

        // Convert the price to a number and check if the buyer has enough ETH
        const prixEth = parseFloat(this.nouvelleAchat.prix);
        if (isNaN(prixEth) || prixEth <= 0) {
          throw new Error("Le prix n'est pas un nombre valide");
        }

        if (parseFloat(soldeEth) < parseFloat(this.nouvelleAchat.quantite)) {
          throw new Error("L'acheteur ne possède pas suffisamment d'ETH");
        }

        if (typeof web3 !== 'undefined') {
          web3.eth.requestAccounts()
            .then((accounts) => {
              const adresseWallet = accounts[0]; // Connected wallet address
              const id = Date.now();

              this.achats.push({
                id,
                crypto: this.nouvelleAchat.crypto,
                prix: this.nouvelleAchat.prix,
                quantite: this.nouvelleAchat.quantite,
                vendeur: adresseWallet,
                date: new Date(),
              });

              this.nouvelleAchat.crypto = '';
              this.nouvelleAchat.prix = 0;
              this.nouvelleAchat.quantite = 0;
            })
            .catch((error) => {
              console.error('Erreur de connexion à MetaMask:', error);
            });
        } else {
          console.error('MetaMask non détecté');
        }
      } catch (error) {
        console.error('Erreur lors de la création de l achat:', error);
      }
    },
    // Get the logo of the crypto
    getLogoCrypto(crypto) {
      if (crypto === 'BTC') {
        return 'https://upload.wikimedia.org/wikipedia/commons/4/46/Bitcoin.svg';
      } else if (crypto === 'ETH') {
        return 'https://cryptologos.cc/logos/ethereum-eth-logo.png?v=025';
      } else {
        return '';
      }
    },
    // Format the date
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
    // Sell Crypto
    async VendreSaCrypto(id, prix, adresseVendeur, montantEth) {
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
          // The buy transaction is confirmed, trigger the purchase
          this.acheterCrypto(id, adresseAcheteur, adresseVendeur, montantEth);
        } else {
          console.error('La transaction d\'achat a échoué');
        }
      } catch (error) {
        console.error('Erreur de transaction:', error);
      }
    },

    // Buy Crypto
    async acheterCrypto(id, adresseAcheteur, adresseVendeur, montantEth) {
      try {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
        const montantWei = web3.utils.toWei(montantEth.toString(), 'ether');

        const transaction = await web3.eth.sendTransaction({
          from: adresseAcheteur,
          to: adresseVendeur, // Replace with the buyer's address
          value: montantWei,
        });

        console.log('Transaction hash:', transaction.transactionHash);
        this.supprimerTicket(id);

      } catch (error) {
        console.error('Erreur de transaction:', error);
      }
    },

    // Remove a ticket
    async supprimerTicket(id) {
      try {
        const web3 = new Web3(window.ethereum);
        await window.ethereum.enable();
        const accounts = await web3.eth.getAccounts();
        this.adresseWallet = accounts[0];

        const index = this.achats.findIndex(achat => achat.id === id);
        if (index !== -1 && this.achats[index].vendeur === this.adresseWallet) {
          this.achats.splice(index, 1);
        }
      } catch (error) {
        console.error('Erreur suppression:', error);
      }
    },
  },
};
</script>

  

<template>
  <div>
    <h2>Add a buy offer</h2>
    <form @submit.prevent="ajouterAchat">
      <div class="form-container">
        <div class="form-group">
          <label class="label" for="crypto">Crypto:</label>
          <select class="input" id="crypto" v-model="nouvelleAchat.crypto" required>
            <option value="BTC">BTC</option>
            <option value="ETH">ETH</option>
          </select>
        </div>
        <div class="form-group">
          <label class="label" for="prix">Price:</label>
          <input class="input" type="number" id="prix" v-model="nouvelleAchat.prix" required>
        </div>
        <div class="form-group">
          <label class="label" for="quantite">Quantity:</label>
          <input class="input" type="number" id="quantite" v-model="nouvelleAchat.quantite" required step="0.00000001">
        </div>
        <div class="form-group">
          <button class="button" type="submit">Buy</button>
        </div>
      </div>
    </form>

    <h2>Buy Offers</h2>
    <div class="achats-liste">
      <div v-for="achat in achatsTriees" :key="achat.id" class="achat-ticket">
        <img :src="getLogoCrypto(achat.crypto)" :alt="achat.crypto" class="crypto-logo">
        <div class="close-btn" @click="supprimerTicket(achat.id)" v-if="achat.vendeur === adresseWallet">&#10006;</div>
        <div class="ticket-info">
          <div class="pair">{{ achat.crypto }}/USDT</div>
          <div class="prix">Price: {{ achat.prix }} $</div>
          <div class="quantite">Quantity: {{ achat.quantite }}</div>
          <div class="total_price">Total value: {{ achat.quantite * achat.prix }} $</div>
          <div class="date">{{ formatDate(achat.date) }}</div>
          <button @click="VendreSaCrypto(achat.id, achat.prix, achat.vendeur, achat.quantite)">SELL</button>
        </div>
      </div>
    </div>
  </div>
</template>



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


  .achats-liste {
    display: flex;
    flex-wrap: wrap;
  }
  
  .achat-ticket {
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