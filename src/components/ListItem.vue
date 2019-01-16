<template>
  <div class="list">
    <ul class="item" v-for="item in content" :key="item">
      <li>{{item}}</li>
    </ul>
  </div>
</template>
<script>
export default {
  props: ["content"]
};
</script>
