<template>
  <div class="container-box">
    <el-container>
      <el-header>
        <m-header />
      </el-header>
      <el-main>
        <menu-list />
      </el-main>
    </el-container>
    <!-- <keep-alive>
      <router-view></router-view>
    </keep-alive> -->
  </div>
</template>
<script>
import MHeader from '@/components/header/m-header.vue'
import menuList from '@/components/content'

export default {
  components: { menuList, MHeader },
  data() {
    return {
    };
  },
  methods: {

  }
};
</script>
<style scoped>
</style>


