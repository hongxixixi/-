<template>
  <div class="content-box">
    <div class="left-side-box">
      <div class="userAccount menuList">
        <img src="@/assets/pic.png">
        <!-- <span>账户名</span> -->
        <el-dropdown>
          <span class="el-dropdown-link">
            馥莹bb<i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item>上传头像</el-dropdown-item>
            <el-dropdown-item>修改昵称</el-dropdown-item>
            <el-dropdown-item divided>
              <router-link :to="{path:'/'}">退出登录</router-link>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>

      </div>

      <div class="menuList">
        <el-dropdown>
          <span class="el-dropdown-link">
            <i class='el-icon-plus'></i>创建<i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native='changeFolder()'>创建文件夹</el-dropdown-item>
            <el-dropdown-item>
              <router-link to='/index/addEdit'> 创建笔记本</router-link>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>

      </div>

      <div class="menuList">
        <router-link to='/index/notes'><i class='el-icon-document'></i>笔记本</router-link>
      </div>

      <div class="menuList">
        <router-link to='/index/myshare'><i class='el-icon-news'></i>我的分享 </router-link>
      </div>

      <div class="menuList">
        <router-link to='/index/shareList'><i class='el-icon-tickets'></i>分享给我的 </router-link>
      </div>

      <div class="menuList">
        <router-link to='/index/recover'><i class='el-icon-delete'></i>回收站</router-link>
      </div>
    </div>

    <div class="right-side-box">
      <div
        class="view-add-folder"
        v-if="addFolder"
      >
        <div class="folder-box">
          <div class="fold-input">
            <span>文件夹名称：</span>
            <el-input v-model="foldName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button
              type="primary"
              @click="submitFoldName"
            >确定</el-button>
            <el-button>取消</el-button>
          </div>
        </div>
      </div>
      <router-view></router-view>
    </div>
  </div>

</template>

<script>

import store from '@/store/store.js';
export default {
  data() {
    return {
      addFolder: false,
      foldName: '',
    }
  },
  store,          //需要声明一下
  methods: {
    changeFolder() {
      this.addFolder = !this.addFolder;
    },
    submitFoldName() {

    }
  },
}
</script>

