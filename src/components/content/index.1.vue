<template>
  <div class="content-box">
    <div
      class="left-side-box"
      @click="closeTheFolderOuter"
    >
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
            <el-dropdown-item @click.native='toggleFolderMask()'>创建文件夹</el-dropdown-item>
            <el-dropdown-item>
              <router-link to='/index/addEdit'> 创建笔记本</router-link>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>

      <div class="menuList">
        <router-link to='/index/notes'><i class='el-icon-document'></i>我的桌面</router-link>
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

    <div
      class="right-side-box"
      @click="closeTheFolderInner"
    >

      <!-- 添加文件夹名弹出框 -->
      <div
        class="view-add-folder"
        v-if="viewFolderMask"
      >
        <div class="folder-box">
          <div class="fold-input">
            <span>文件夹名称：</span>
            <el-input v-model="foldName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button
              type="primary"
              @click="addFolder"
              class="addFolder-btn"
            >确定</el-button>
            <el-button @click="cancelAddFolder">取消</el-button>

            <el-dialog
              title="提示"
              :visible.sync="dialogVisible"
              width="30%"
            >
              <span>请填写文件夹名称</span>
              <span
                slot="footer"
                class="dialog-footer"
              >
                <el-button
                  type="primary"
                  @click="dialogVisible = false"
                >确 定</el-button>
              </span>
            </el-dialog>

          </div>
        </div>
      </div>

      <!-- 添加文件名弹出框 -->
      <div
        class="view-add-folder"
        v-if="viewFileMask"
      >
        <div class="folder-box">
          <div class="fold-input">
            <span>文件名称：</span>
            <el-input v-model="foldName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button
              type="primary"
              @click="addFolder"
              class="addFolder-btn"
            >确定</el-button>
            <el-button @click="cancelAddFolder">取消</el-button>

            <el-dialog
              title="提示"
              :visible.sync="dialogVisible"
              width="30%"
            >
              <span>请填写文件名称</span>
              <span
                slot="footer"
                class="dialog-footer"
              >
                <el-button
                  type="primary"
                  @click="dialogVisible = false"
                >确 定</el-button>
              </span>
            </el-dialog>
          </div>
        </div>
      </div>

      <router-view @toggleFileMask='toggleFileMask'></router-view>
    </div>
  </div>

</template>

<script>

import store from '@/store/store.js';
export default {
  data() {
    return {
      dialogVisible: false,
      viewFolderMask: false,
      viewFileMask: false,
      foldName: '',
    }
  },
  store,
  methods: {
    toggleFolderMask() {
      this.viewFolderMask = !this.viewFolderMask;
    },
    closeTheFolderInner(event) {
      if (this.viewFolderMask && event.srcElement.classList.contains('view-add-folder')) {
        this.viewFolderMask = !this.viewFolderMask;
      }
    },
    closeTheFolderOuter() {
      if (this.viewFolderMask) {
        this.viewFolderMask = !this.viewFolderMask;
      }
    },
    addFolder() {
      if (this.foldName != '') {
        this.$store.commit('addFolder', this.foldName);
        this.toggleFolderMask();
        this.foldName = '';
        this.$router.push('/index/notes');
      }
      else {
        this.dialogVisible = true;
      }
    },
    cancelAddFolder() {
      this.toggleFolderMask();
    },
  },
}
</script>

