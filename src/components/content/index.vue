<template>
  <div class="contont-box">
    <div class="left-side-box">
      <div class="userAccount menuList">
        <span>头像</span>
        <span>账户名</span>
      </div>

      <div class="menuList addEdit">
        <router-link to='/index/addEdit'><i class='el-icon-plus'></i>新建</router-link>
      </div>

      <div class="menuList">
        <router-link to='/index/myshare'><i class='el-icon-document'></i>笔记本</router-link>
      </div>

      <div class="menuList">
        <router-link to='/index/shareList'><i class='el-icon-news'></i>我的分享 </router-link>
      </div>

      <div class="menuList">
        <router-link to='/index/notes'><i class='el-icon-tickets'></i>分享给我的 </router-link>
      </div>

      <div class="menuList">
        <router-link to='/index/recover'><i class='el-icon-delete'></i>回收</router-link>
      </div>
    </div>

    <div class="right-side-box">
      <router-view></router-view>
    </div>
  </div>

</template>

<script>
export default {
}
</script>

<style scoped lang="less">
</style>
