<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <header>
    <nav>
      <RouterLink to="/">Daftar Tugas</RouterLink> | 
      <RouterLink to="/about">Tentang</RouterLink>
    </nav>
  </header>

  <RouterView />
</template>