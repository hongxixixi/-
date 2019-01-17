<template>
  <div id="app">
    <video
      id="video"
      muted
      src="@/assets/login.mp4"
      autoplay
      loop
    >您的浏览器不支持\&lt; video&gt;元素</video>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  name: "App"
};
</script>

<style>
</style>
