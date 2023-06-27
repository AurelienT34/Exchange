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
        datasets: [
          {
            label: 'ETH price',
            backgroundColor: 'green',
            data: [40, 20, 12],
            borderColor: 'green'
          }
        ]
      },
      chartOptions: {
        responsive: true
      },
      chartKey: 0 // Ajout de la clé de graphique
    }
  },

  methods: {
    updateChartData() {
      const newLabel = 'April';
      const newData = 25;

      this.chartData.labels = [...this.chartData.labels, newLabel];
      this.chartData.datasets[0].data = [...this.chartData.datasets[0].data, newData];
      console.log(this.chartData.labels);
      console.log(this.chartData.datasets[0].data);
      this.chartKey++; // Mise à jour de la clé de graphique pour forcer la mise à jour du composant
    }
  }
}
</script>

<style>
#my-chart-id {
  max-width: 600px;
  margin: 40px auto;
}
</style>
