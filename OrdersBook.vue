<template>
  <MyLine
    :key="chartKey"
    id="my-chart-id"
    :options="chartOptions"
    :data="chartData"
  />

  <button @click="updateChartData">Test</button>
</template>

<script>
import { Chart as ChartJS, CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend } from 'chart.js'
import { Line as MyLine } from 'vue-chartjs'

ChartJS.register(CategoryScale, LinearScale, PointElement, LineElement, Title, Tooltip, Legend)

export default {
  name: 'App',
  components: {
    MyLine
  },
  data() {
    return {
      chartData: {
        labels: ['January', 'February', 'March'],
        datasets: [{
          label: 'ETH price',
          backgroundColor: 'green',
          data: [40, 20, 12],
          borderColor: 'green'
        }]
      },
      chartOptions: {
        responsive: true
      },
      chartKey: 0
    }
  },
  methods: {
    updateChartData() {
      const newLabels = [...this.chartData.labels]; // Créer une copie des labels existants
      const newData = [...this.chartData.datasets[0].data]; // Créer une copie des données existantes

      newLabels.push('April');
      newData.push(25);

      // Vérifier si le nombre de données dépasse 5 et les ajuster si nécessaire
      if (newLabels.length > 5) {
        newLabels.shift(); // Supprimer la première valeur
        newData.shift(); // Supprimer la première valeur
      }

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
  },
}
</script>


<style>
#my-chart-id {
  max-width: 600px;
  margin: 40px auto;
}
</style>
