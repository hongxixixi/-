<template>
  <div class="container-box">
    <el-container>
      <el-header>Header</el-header>
      <el-main>
        <left-side></left-side>
        <mid-side></mid-side>
        <right-side></right-side>
      </el-main>
    </el-container>
    <keep-alive>
      <router-view></router-view>
    </keep-alive>
  </div>
</template>
<script>
import leftSide from '@/components/container/leftSide.vue'
import midSide from '@/components/container/midSide'
import rightSide from '@/components/container/rightSide'

export default {
  components: { leftSide, midSide, rightSide },
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


