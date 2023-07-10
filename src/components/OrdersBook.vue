<template>
  <!-- Chart Component -->
  <MyLine
    :key="chartKey"
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />

  <!-- Forms -->
  <div class="form-row">
    <!-- Buy Form -->
    <form @submit.prevent="addBuy" class="form-container">
      <div class="form-group">
        <label class="label" for="achat-prix">Price:</label>
        <input class="input" type="number" id="achat-prix" v-model="nouvelleAchat.prix" required>
      </div>
      <div class="form-group">
        <label class="label" for="achat-quantite">Quantity:</label>
        <input class="input" type="number" id="achat-quantite" v-model="nouvelleAchat.quantite" required step="1">
      </div>
      <div class="form-group">
        <button class="button" type="submit">Buy ETH</button>
      </div>
    </form>

    <!-- Sell Form -->
    <form @submit.prevent="addSell" class="form-container">
      <div class="form-group">
        <label class="label" for="vente-prix">Price:</label>
        <input class="input" type="number" id="vente-prix" v-model="nouvelleVente.prix" required>
      </div>
      <div class="form-group">
        <label class="label" for="vente-quantite">Quantity:</label>
        <input class="input" type="number" id="vente-quantite" v-model="nouvelleVente.quantite" required step="1">
      </div>
      <div class="form-group">
        <button class="button" type="submit">Sell ETH</button>
      </div>
    </form>
  </div>

  <!-- Proposals Component -->
  <Proposals :ventes="ventes" :achats="achats"></Proposals>
</template>

<script>
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend } from 'chart.js'
import { Line as MyLine } from 'vue-chartjs'
import Proposals from './Proposals.vue'

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend)

export default {
  name: 'App',
  components: {
    MyLine,
    Proposals
  },
  props: {
    ethAmount: {
      type: String,
      required: true
    },
    usdtAmount: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      // Chart Data
      chartData: {
        labels: [],
        datasets: [{
          label: 'ETH price',
          backgroundColor: 'green',
          data: [],
          borderColor: 'green'
        }]
      },
      // Chart Options
      chartOptions: {
        responsive: true
      },
      chartKey: 0,
      // Form data for Sell
      nouvelleVente: {
        crypto: '',
        prix: 0,
      },
      // Form data for Buy
      nouvelleAchat: {
        crypto: '',
        prix: 0,
      },
      // Sell proposals
      ventes: [],
      // Buy proposals
      achats: []
    }
  },
  methods: {
    // Add a sell proposal
    addSell() {
      if ((parseFloat(this.ethAmount) / 10**18) >= this.nouvelleVente.quantite) {
        this.updateChartData(this.nouvelleVente.prix);
        this.ventes.push(this.nouvelleVente);
        this.nouvelleVente = {
          crypto: '',
          prix: 0,
        };
      } else {
        alert('ethAmount > quantité');
      }
    },
    // Add a buy proposal
    addBuy() {
      if ((parseFloat(this.usdtAmount) / 10**18) >= this.nouvelleAchat.quantite * this.nouvelleAchat.prix) {
        this.updateChartData(this.nouvelleAchat.prix);
        this.achats.push(this.nouvelleAchat);
        this.nouvelleAchat = {
          crypto: '',
          prix: 0,
        };
      } else {
        alert('usdtAmount < quantité * prix');
      }
    },
    // Update chart data
    updateChartData(price) {
      const newLabels = [...this.chartData.labels];
      const newData = [...this.chartData.datasets[0].data];
      const now = new Date();
      newLabels.push(now.getHours().toString().concat(":", now.getMinutes().toString(), ":", now.getSeconds().toString()));
      newData.push(price);

      // Check if the number of data exceeds 5 and adjust if necessary
      if (newLabels.length > 5) {
        newLabels.shift(); // Remove the first value
        newData.shift(); // Remove the first value
      }

      // Calculate the average of the last 5 values
      const lastFiveData = newData.slice(-5);
      const average = lastFiveData.reduce((acc, curr) => acc + curr, 0) / lastFiveData.length;

      // Update the last value in newData with the average
      newData[newData.length - 1] = average;

      this.chartData = {
        labels: newLabels,
        datasets: [{
          label: 'ETH price',
          backgroundColor: 'green',
          data: newData,
          borderColor: 'green'
        }]
      };

      this.chartKey++;
    }
  }
}
</script>

<style>
/* Form styling */
.form-row {
  display: flex;
  justify-content: center;
  gap: 20px;
}

.form-container {
  width: 50%;
}

/* Chart styling */
#my-chart-id {
  max-width: 600px;
  margin: 40px auto;
}
</style>