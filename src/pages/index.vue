<template>
  <div class="home" height="50px">
   <el-container>
  <el-header>Header</el-header>
  <el-main>Main</el-main>
</el-container>
    <!-- <ul>
      <router-link :to="{name:'login'}" tag="li">Login</router-link>
      <router-link :to="{name:'nav1'}" tag="li">Nav1</router-link>
      <router-link :to="{name:'nav2'}" tag="li">Nav2</router-link>
      <router-link :to="{name:'nav3'}" tag="li">Nav3</router-link>
      <li>新增</li>
      <router-link :to="{name:'login'}">注销</router-link>
    </ul> -->
    <keep-alive>
      <router-view></router-view>
    </keep-alive>
  </div>
</template>
<script>
// 添加一个新增功能，点击就多一个到导航标签
export default {
  data() {
    return {
      title: "主页Home",
      activeIndex: "1",
      activeIndex2: "1"
    };
  },
  methods: {
    handleSelect(key, keyPath) {
      console.log(key, keyPath);
    }
  }
};
</script>
<style scoped>
/* .home {
  height: 400px;
}
ul {
  list-style: none;
}
li {
  display: inline-block;
  padding: 5px 10px;
  cursor: pointer;
} */
/* .home {
  float: left;
  width: 30%;
}
ul {
  list-style: none;
}
li {
  box-sizing: border-box;
}
a {
  display: inline-block;
  width: 100%;
  height: 100%;
}
.right {
  float: right;
} */
.el-header {
    background-color: #B3C0D1;
    color: #333;
    text-align: center;
    line-height: 50px;
    height:50px;
  }
  .el-main {
    margin-top:50px;
    background-color: #E9EEF3;
    color: #333;
    text-align: center;
    height: 100%;
  }
</style>


