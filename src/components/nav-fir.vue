<template>
  <div class="nav1">
    <el-container>
      <el-aside width="200px"></el-aside>
      <el-container>
        <el-header>我是：{{title}}</el-header>
        <el-main></el-main>
      </el-container>
    </el-container>
    <!-- <i class="el-icon-plus"></i> -->
  </div>
</template>
<script>
export default {
  data() {
    return {
      title: "导航1"
    };
  }
};
</script>

<style scoped>
.el-header,
.el-footer {
  background-color: #b3c0d1;
  color: #333;
  text-align: center;
  line-height: 60px;
}

.el-aside {
  background-color: #d3dce6;
  color: #333;
  text-align: center;
  line-height: 200px;
}

.el-main {
  background-color: #e9eef3;
  color: #333;
  text-align: center;
  line-height: 160px;
}
</style>
