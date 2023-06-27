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
      const newLabels = [...this.chartData.labels]; // Create a copy of the existing labels
      const newData = [...this.chartData.datasets[0].data]; // Create a copy of the existing data

      newLabels.push('April');
      newData.push(25);

      // Check if the number of data exceeds 5 and adjust if necessary
      if (newLabels.length > 5) {
        newLabels.shift(); // Remove the first value
        newData.shift(); // Remove the first value
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
