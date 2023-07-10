<template>
  <div class="order-book">
    <!-- Ventes column -->
    <div class="proposals-container">
      <div class="proposals-column vente-column">
        <h2 class="proposals-title">Ventes</h2>
        <table class="table vente-table">
          <thead>
            <tr>
              <th>Prix</th>
              <th>Quantité</th>
              <th>Total</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(vente, index) in ventes" :key="'vente-' + index">
              <td>{{ vente.prix }}</td>
              <td>{{ vente.quantite }}</td>
              <td>{{ vente.prix * vente.quantite }}</td>
              <td>
                <button @click="removeVente(index)">Buy</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Achats column -->
      <div class="proposals-column achat-column">
        <h2 class="proposals-title">Achats</h2>
        <table class="table achat-table">
          <thead>
            <tr>
              <th>Prix</th>
              <th>Quantité</th>
              <th>Total</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(achat, index) in achats" :key="'achat-' + index">
              <td>{{ achat.prix }}</td>
              <td>{{ achat.quantite }}</td>
              <td>{{ achat.prix * achat.quantite }}</td>
              <td>
                <button @click="removeAchat(index)">Sell</button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    ventes: {
      type: Array,
      default: () => []
    },
    achats: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    // Remove a vente (sell) from the list
    removeVente(index) {
      this.ventes.splice(index, 1);
    },
    // Remove an achat (buy) from the list
    removeAchat(index) {
      this.achats.splice(index, 1);
    }
  }
};
</script>

<style>
.order-book {
  display: flex;
  justify-content: center;
}

.proposals-container {
  display: flex;
  gap: 20px;
}

.proposals-column {
  flex: 1;
}

.proposals-title {
  text-align: center;
  color: white;
  margin-bottom: 10px;
}

.table {
  width: 100%;
  border-collapse: collapse;
}

.table th,
.table td {
  padding: 8px;
  text-align: left;
  border-bottom: 1px solid #ddd;
}

.table th {
  background-color: rgba(255, 217, 0, 0.5);
}

.table tbody tr:hover {
  background-color: rgba(255, 217, 0, 0.5);
}
</style>