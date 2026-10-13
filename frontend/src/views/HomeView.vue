<script setup>
import { ref, onMounted } from 'vue'
import axios from 'axios'

const tasks = ref([])

onMounted(async () => {
  try {
    const response = await axios.get(`${import.meta.env.VITE_API_URL}/tasks`)
    tasks.value = response.data
  } catch (error) {
    console.error('Gagal mengambil data:', error)
  }
})
</script>

<template>
  <main>
    <h1>Daftar Tugas</h1>
    <ul>
      <li v-for="task in tasks" :key="task.id">
        {{ task.title }} - {{ task.completed ? 'Selesai' : 'Belum' }}
      </li>
    </ul>
  </main>
</template>