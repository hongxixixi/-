<template>
  <div class="content-box">
    <div class="left-side-box" @click="closeTheFolderOuter">
      <div class="userAccount">
        <img src="@/assets/pic.png">
        <!-- <span>账户名</span> -->
        <el-dropdown style="
    margin-left: 12px;">
          <span class="el-dropdown-link">
            {{userName}}
            <i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item>上传头像</el-dropdown-item>
            <el-dropdown-item ><div @click="changeName">  修改昵称</div></el-dropdown-item>
            <el-dropdown-item divided>
              <router-link :to="{path:'/'}">退出登录</router-link>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>

      <div class="menuList">
        <el-dropdown>
          <span class="el-dropdown-link">
            <i class="el-icon-plus"></i>创建
            <i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="toggleFolderMask()">创建文件夹</el-dropdown-item>
            <el-dropdown-item>
              <router-link :to="{'name':'addEdit'}">创建笔记本</router-link>
            </el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>

      <div class="menuList">
        <router-link :to="{'name':'notes'}">
          <i class="el-icon-document"></i>我的桌面
        </router-link>
      </div>

      <div class="menuList">
        <router-link :to="{'name':'myshare'}">
          <i class="el-icon-news"></i>我的分享
        </router-link>
      </div>

      <div class="menuList">
        <router-link :to="{'name':'shareList'}">
          <i class="el-icon-tickets"></i>分享给我的
        </router-link>
      </div>

      <div class="menuList">
        <router-link :to="{'name':'partner'}">
          <i class="el-icon-goods"></i>笔记好友
        </router-link>
      </div>

      <div class="menuList">
        <router-link :to="{'name':'recover'}">
          <i class="el-icon-delete"></i>回收站
        </router-link>
      </div>
    </div>

    <div class="right-side-box" @click="closeTheFolderInner">
      <!-- 添加文件夹名弹出框 -->
      <div class="view-add-folder" v-if="viewFolderMask">
        <div class="folder-box">
          <div class="fold-input">
            <span>文件夹名称：</span>
            <el-input v-model="foldName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button type="primary" @click="addFolder" class="addFolder-btn">确定</el-button>
            <el-button @click="cancelAddFolder">取消</el-button>

            <el-dialog title="提示" :visible.sync="dialogVisible" width="30%">
              <span>请填写文件夹名称</span>
              <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
              </span>
            </el-dialog>
          </div>
        </div>
      </div>

      <!-- 添加文件名弹出框 -->
      <div class="view-add-folder" v-if="viewFileMask">
        <div class="folder-box">
          <div class="fold-input">
            <span>文件名称：</span>
            <el-input v-model="fileName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button type="primary" @click="addfile" class="addFolder-btn">确定</el-button>
            <el-button @click="cancelAddfile">取消</el-button>

            <el-dialog title="提示" :visible.sync="dialogVisible2" width="30%">
              <span>请填写文件夹名称</span>
              <span slot="footer" class="dialog-footer">
                <el-button type="primary" @click="dialogVisible2 = false">确定</el-button>
              </span>
            </el-dialog>
          </div>
        </div>
      </div>
      <div class="view-change-name" v-if="viewChangeName">
         <div class="name-box">
          <div class="name-input">
            <span>用户名：</span>
            <el-input v-model="myChangeName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button type="primary" @click="conFirmChangeUserName">确定</el-button>
            <el-button @click="cancelChangeUserName">取消</el-button>
          </div>
        </div>
      </div>
      <router-view @toggleFileMask="toggleFileMask" @FileContent = "FileContent"></router-view>
    </div>
  </div>
</template>

<script>
import store from "@/store/store.js";
export default {
  data() {
    return {
      dialogVisible: false,
      dialogVisible2: false,
      viewFolderMask: false,
      viewFileMask: false,
      viewChangeName:false,
      fileContent:'',
      foldName: "",
      fileName: "",
      userName: "微微",//用户名
      myChangeName:'',//修改用户名

    };
  },
  store,
  methods: {
    // 添加文件的弹出罩切换
    toggleFileMask() {
      this.viewFileMask = !this.viewFileMask;
    },
    FileContent(text,filename){
      this.fileContent = text;
      this.fileName = filename;
    },
    addfile() {
      if (this.fileName != "") {

        // this.$store.commit("modifyFileContent",this.fileName);

        this.$store.commit("addFile", {name:this.fileName,content:this.fileContent});
        console.log(this.$store);
        this.toggleFileMask();
        this.fileName = "";
        this.$router.push({name:"notes"});
        
        
        // 判断一下当前是否有文件名相同,相同直接修改
        // for(let i = 0; i <this.$store.state.fileLists.length;i++){
        //   if(this.$store.state.fileLists[i].name ==this.fileName ){
        //     // this.$store.state.fileLists[i].content = this.fileContent;
        //   }
        // }
        
      } else {
        this.dialogVisible2 = true;
      }
    },
    cancelAddfile() {
      this.toggleFileMask();
    },

    // 添加文件夹的弹出罩切换
    toggleFolderMask() {
      this.viewFolderMask = !this.viewFolderMask;
    },
    closeTheFolderInner(event) {
      if (
        this.viewFolderMask &&
        event.srcElement.classList.contains("view-add-folder")
      ) {
        this.viewFolderMask = !this.viewFolderMask;
      }
    },
    closeTheFolderOuter() {
      if (this.viewFolderMask) {
        this.viewFolderMask = !this.viewFolderMask;
      }
    },
    addFolder() {
      if (this.foldName != "") {
        this.$store.commit("addFolder", this.foldName);
        this.toggleFolderMask();
        this.foldName = "";
        this.$router.push({name:"notes"});
      } else {
        this.dialogVisible = true;
      }
    },
    cancelAddFolder() {
      this.toggleFolderMask();
    },
    //修改用户名
    changeName() {
      this.myChangeName = this.userName;
      this.viewChangeName = !this.viewChangeName
    },
    //确认修改用户名
    conFirmChangeUserName(){
      this.userName = this.myChangeName;
      this.viewChangeName = !this.viewChangeName;
      this.$router.push({name:"notes"});
    },
    //取消修改
    cancelChangeUserName(){
      this.myChangeName = this.userName,
      this.viewChangeName = !this.viewChangeName;
      this.$router.push({name:"notes"});
    }
  }
};
</script>

