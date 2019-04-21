<template>
  <div class="content-box">
    <!-- 左边导航栏 -->
    <div
      class="left-side-box"
      @click="closeTheFolderOuter"
    >
      <div class="userAccount">
        <img src="@/assets/pic.png">
        <!-- <span>账户名</span> -->
        <el-dropdown style="margin-left: 12px;">
          <span class="el-dropdown-link">
            {{name}}
            <i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <!-- <el-dropdown-item>上传头像</el-dropdown-item> -->
            <el-dropdown-item>
              <div @click="changeName">修改昵称</div>
            </el-dropdown-item>
            <el-dropdown-item divided>
              <router-link :to="{path:'/'}">注销</router-link>
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
            <el-dropdown-item @click.native="toggleFolderMask()">创建笔记本</el-dropdown-item>
            <el-dropdown-item @click.native="toggleFileMask()">创建笔记</el-dropdown-item>
            <!-- <el-dropdown-item>
              <router-link :to="{'name':'addEdit'}">创建笔记本</router-link>
            </el-dropdown-item>-->
          </el-dropdown-menu>
        </el-dropdown>
      </div>
      <el-tree
        :data="data"
        :props="defaultProps"
        @node-click="handleNodeClick"
        draggable
        :allow-drop="allowDrop"
        :allow-drag="allowDrag"
        @node-drop="handleDrop"
        @node-contextmenu="rightClick"
      ></el-tree>
      <!-- <div
        class="menuList"
        @click='chooseIndex(1)'
        :class="{clickStyle:index==1}"
      >
        <router-link :to="{name:'notes'}">
          <i class="el-icon-document"></i>我的桌面
        </router-link>
        
      </div>-->
      <div
        class="menuList"
        @click="chooseIndex(2)"
        :class="{clickStyle:index==2}"
      >
        <router-link :to="{name:'partner'}">
          <i class="el-icon-goods"></i>好友及群聊
        </router-link>
      </div>
      <div
        class="menuList"
        @click="chooseIndex(3)"
        :class="{clickStyle:index==3}"
      >
        <router-link :to="{name:'shareToMe'}">
          <i class="el-icon-document"></i>共享给我的
        </router-link>
      </div>

      <!-- <div class="menuList" @click="chooseIndex(4)" :class="{clickStyle:index==4}">
        <router-link :to="{name:'recover'}">
          <i class="el-icon-delete"></i>废纸篓
        </router-link>
      </div> -->
      <div class="menuList">
        <a
          href="javascript:void(0);"
          @click="Synch"
        >
          <i class="el-icon-refresh"></i>同步
        </a>
      </div>
      <div
        class="action"
        style="display:none;position:absolute;"
        ref="menu1"
        v-document-click="documentClick"
      >
        <ul>
          <li @click="dialogVisible3=true;fileVisible = false;shareMyFile('分享')">分享</li>
          <li @click="dialogVisible3=true;fileVisible = false;shareMyFile('共享')">共享</li>
          <li @click="moreDetail()">查看</li>
          <li @click="editMyFile()">重命名</li>
          <li @click="deleteMyFile()">删除</li>
        </ul>
      </div>
      <div
        class="action"
        v-document-click="documentClick"
        style="display:none;position:absolute;"
        ref="menu2"
      >
        <ul>
          <li @click="editMyFolder()">重命名</li>
          <li @click="deleteMyFolder()">删除</li>
        </ul>
      </div>
    </div>
    <!-- 右边显示 -->
    <div
      class="right-side-box"
      @click="closeTheFolderInner"
    >
      <!-- 1.添加笔记本名（文件夹）弹出框 -->
      <div
        class="view-add-folder"
        v-if="viewFolderMask"
      >
        <div class="folder-box">
          <div class="fold-input">
            <span>笔记本名称：</span>
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
              <span>请填写笔记本名称</span>
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

      <!-- 2.添加笔记（文本）弹出框 -->
      <div
        class="view-add-folder"
        v-if="viewFileMask"
      >
        <div class="folder-box">
          <div class="fold-input">
            <span>笔记名称：</span>
            <el-input v-model="fileName"></el-input>
          </div>
          <div class="select-fold">
            <span>笔记本：</span>
            <el-select
              v-model="fileFolderName"
              clearable
              placeholder="请选择笔记本"
            >
              <el-option
                v-for="item in folders"
                :key="item"
                :label="item"
                :value="item"
              ></el-option>
            </el-select>
          </div>
          <div class="fold-btn">
            <el-button
              type="primary"
              @click="addfile"
              class="addFolder-btn"
            >确定</el-button>
            <el-button @click="cancelAddfile">取消</el-button>

            <el-dialog
              title="提示"
              :visible.sync="dialogVisible2"
              width="30%"
            >
              <span>请填写笔记本名称</span>
              <span
                slot="footer"
                class="dialog-footer"
              >
                <el-button
                  type="primary"
                  @click="dialogVisible2 = false"
                >确定</el-button>
              </span>
            </el-dialog>
          </div>
        </div>
      </div>
      <!-- 3.分享文件的弹出框 -->
      <el-dialog
        title
        :visible.sync="dialogVisible3"
        width="40%"
        class="share-file-dialog"
      >
        <span>{{type}}至：</span>
        <el-select
          v-model="shareMumber"
          placeholder
          multiple="multiple"
        >
          <el-option
            v-for="item in partnerAndcrowds"
            :key="item.account"
            :label="item.name"
            :value="item.account.split(';').length>1?item.name:item.account"
            :disabled="type=='共享' && item.account.split(';').length>1"
          ></el-option>
        </el-select>
        <div v-if="type=='共享'">
          <span>共享权限：</span>
          <el-select
            v-model="shareAuth"
            placeholder
          >
            <el-option
              v-for="item in auths"
              :key="item.auth"
              :label="item.label"
              :value="item.auth"
            ></el-option>
          </el-select>
        </div>
        <span
          slot="footer"
          class="dialog-footer"
        >
          <el-button @click="dialogVisible3 = false;">取 消</el-button>
          <el-button
            type="primary"
            @click="confirmShareFlie()"
          >确 定</el-button>
        </span>
      </el-dialog>
      <!-- 4.修改名字弹出框 -->
      <div
        class="view-change-name"
        v-if="viewChangeName"
      >
        <div class="name-box">
          <div class="name-input">
            <span>昵称：</span>
            <el-input v-model="myChangeName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button
              type="primary"
              @click="conFirmChangeName"
            >确定</el-button>
            <el-button @click="cancelChangeName">取消</el-button>
          </div>
        </div>
      </div>
      <!-- 确认弹出框 -->
      <div
        class="view-confirm-save"
        v-if="viewConfirmMask"
      >
        <div class="confirm-box">
          <h1>确认保存？</h1>
          <el-button
            type="primary"
            @click="confirmSaveFile"
          >确定</el-button>
          <el-button @click="cancelSaveFile">取消</el-button>
        </div>
      </div>
      <!-- 修改笔记（文本）名字弹出框 -->
      <div
        class="view-change-name"
        v-if="viewFileName"
      >
        <div class="name-box">
          <div class="name-input">
            <span>文本名称:</span>
            <el-input v-model="myChangeName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button
              type="primary"
              @click="conFirmChangeFileName"
            >确定</el-button>
            <el-button @click="cancelChangeFileName">取消</el-button>
          </div>
        </div>
      </div>
      <!-- 修改笔记本 （文件夹）名字弹出框-->
      <div
        class="view-change-name"
        v-if="viewChangeName2"
      >
        <div class="name-box">
          <div class="name-input">
            <span>文件夹名称:</span>
            <el-input v-model="myChangeName"></el-input>
          </div>
          <div class="fold-btn">
            <el-button
              type="primary"
              @click="conFirmChangeFileName2"
            >确定</el-button>
            <el-button @click="cancelChangeFileName2">取消</el-button>
          </div>
        </div>
      </div>
      <!-- 路由 -->
      <router-view
        @toggleConfirmSave="toggleConfirmSave"
        @FileContent="FileContent"
      ></router-view>
    </div>
  </div>
</template>

<script>
import api from "@/api/index.js";
import store from "@/store/store.js";
import Bus from "@/pages/common/eventBus.js";
export default {
  mounted() {
    this.getName();
    this.getFiles();//获取文本
    this.getFolders();//获取文件夹
    console.log(this.data);
    let params = JSON.stringify({ username: localStorage.username });
    this.getCrowd(params);
    this.getFriend(params);
    this.$router.push({ name: "notes" });
  },
  data() {
    return {
      rightItem: "",
      dialogVisible: false,//笔记本弹出框
      dialogVisible2: false,//笔记
      dialogVisible3: false,//分享
      viewFolderMask: false,
      viewFileMask: false,
      viewChangeName: false,//修改昵称
      viewConfirmMask: false,
      viewChangeName2: false,
      viewFileName: false,//重命名
      fileContent: "",
      foldName: "",
      fileName: "",
      fileFolderName: "",
      shareAuth: 'readAble',
      auths: [{ auth: 'readAble', label: '可查看' }, { auth: 'writeAble', label: '可编辑' }],
      // username: this.$store.state.username, //登录用户名
      name: "", //用户名
      myChangeName: "", //修改昵称
      files: [],
      folders: [],
      index: 0,
      defaultProps: {
        children: "children",
        label: "label"
      },
      data: [],
      shareMumber: [],
      shareItemName: "",
      crowds: [],
      partners: [],
      editName: '',
      type: '分享',
    };
  },
  computed: {
    partnerAndcrowds() {
      return this.partners.concat(this.crowds);
    }
  },
  store,
  watch: {
    files(val) {
      // console.log(val)
      // this.files = val;
      this.data = this.handleData(val);
    },
    folders(val) {
      // this.folders = val;
      // this.data = this.handleData(this.files);
    },
    $route(to, from) {
      let params = JSON.stringify({ username: localStorage.username });
      if (to.path == '/content/notes' && from.path == '/content/partner') {
        this.getFiles();//获取文本
        this.getFolders();//获取文件夹
        this.getCrowd(params);
        this.getFriend(params);
      }
    }
  },
  beforeCreate() {
    console.log(localStorage.sharePers);
    console.log(localStorage.filename);
    console.log(localStorage.foldername);
    let params = JSON.stringify({
      username: localStorage.sharePers,
      name: localStorage.filename,
      folder: localStorage.foldername
    })
    api.changeState(params).then(res => {
      api.getState(params).then((res) => {
        console.log(res.data.data.status + params + '销毁之后的文件状态')
      })
    });
  },
  beforeDestroy() {
    localStorage.setItem('sharePers', '');
    localStorage.setItem('filename', '');
    localStorage.setItem('foldername', '');
  },
  methods: {

    //获取笔记
    getFiles() {
      let params = JSON.stringify({ username: localStorage.username });
      api.getFiles(params).then(res => {
        // console.log(res);
        this.files = res.data.data;

        // console.log(this.files);
        this.data = this.handleData(this.files);
        //1-1.vuex==>获取之后处理
        // store.commit("getFiles", res.data.data);
        //  console.log(this.myFiles)
      });
    },
    //获取笔记本
    getFolders() {
      let params = JSON.stringify({ username: localStorage.username });
      api.getFolders(params).then(res => {
        let data = res.data.data.map(el => el.name);
        // 1-2.vuex==>获取之后处理
        // store.commit("getFolders", data);

        this.folders = data;
        this.data = this.handleData(this.files);
        // console.log(this.folders)
      });
    },
    //获取群
    getCrowd(params) {
      api.getCrowd(params).then(res => {
        if (res.data.reason == "OK") {
          this.crowds = [];
          let data = res.data.data;
          data.forEach((item, index) => {
            this.crowds.push({ account: item.people, name: item.name });
          });
        }
      });
    },
    //获取好友
    getFriend(params) {
      api.getFriend(params).then(res => {
        if (res.data.reason == "OK") {
          this.partners = [];
          let data = res.data.data;
          data.forEach((item, index) => {
            this.partners.push({ account: item.username, name: item.name });
          });
        }
      });
    },
    //分享笔记
    shareMyFile(type) {
      this.shareItemName = this.rightItem;
      this.type = type;
    },
    //确定分享
    confirmShareFlie() {
      if (this.shareMumber.length <= 0) {
        this.$message({
          type: "warning",
          message: "至少选择一个好友/群!"
        });
        return;
      }
      this.dialogVisible3 = false;
      this.sendMessage();
    },
    //分享笔记内容
    sendMessage() {
      let timeNow = new Date();
      let time =
        timeNow.getFullYear() +
        "/" +
        ("0" + (timeNow.getMonth() + 1)).slice(-2) +
        "/" +
        ("0" + timeNow.getDate()).slice(-2) +
        "  " +
        timeNow.getHours() +
        ":" +
        timeNow.getMinutes() +
        ":" +
        ("0" + timeNow.getSeconds()).slice(-2);
      this.shareMumber.forEach((item, index) => {
        let editMessage = JSON.stringify({
          sendPerson: localStorage.username,
          recPerson: item,
          message: "#" + JSON.stringify(this.shareItemName),
          time: time
        });
        api.sendMessage(editMessage).then(res => {
          if (res.data.reason == "OK") {
            let that = this;
            this.$message({
              type: "success",
              message: that.type + "成功!"
            });
          }
        });
        if (this.type == '共享') {
          let param = JSON.stringify({ username: localStorage.username, folder: this.shareItemName.folder, name: this.shareItemName.name, beshareUser: item, authority: this.shareAuth })
          console.log(param)
          api.shareFile(param).then(res => {
            if (res.data.reason != "OK") {
              let that = this;
              this.$message({
                type: "error",
                message: that.type + "失败!"
              });
            }
          });
        }
      });
      this.shareAuth = '';
      this.shareMumber = [];
    },
    //重命名笔记本
    editMyFolder() {
      let item = this.rightItem;
      this.viewChangeName2 = !this.viewChangeName2;
    },
    //删除笔记本
    deleteMyFolder() {
      this.$confirm("此操作将永久删除该笔记本及其笔记, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.folderVisible = false;
          let folder = this.rightItem;
          // 1-3.删除vuex处理
          //新添加一个方法
          let params = JSON.stringify({
            username: localStorage.username,
            name: folder,
          });
          //删除文件夹和文本的folder是这个的==>返回删除后的myfolder信息和myfiles信息
          api.deleteFolder(params).then(res => {

            this.getFiles();
            this.getFolders();
            this.$message({
              type: "success",
              message: "删除成功!"
            });
          })
          // this.$store.commit("deleteMyFolder", folder);
          Bus.$emit("fresh");
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    //确认修改笔记本名
    conFirmChangeFileName2() {
      // this.rightItem = this.rightItem + "-" + this.myChangeName;
      //1-4修改文件夹名称=>获取文本
      let params = JSON.stringify({ username: localStorage.username, pre: this.rightItem, now: this.myChangeName });
      api.editFolderName(params).then(res => {

        this.getFiles();
        this.getFolders();
        Bus.$emit("fresh");
      })

      // this.$store.commit("editmyFolder", this.rightItem);
      this.viewChangeName2 = !this.viewChangeName2;
      this.data = this.handleData(this.files);
    },
    //取消修改笔记本名
    cancelChangeFileName2() {
      this.myChangeName = this.rightItem.name;
      this.viewChangeName2 = !this.viewChangeName2;
    },
    //查看内容
    moreDetail() {
      let item = this.rightItem;
      this.$refs.menu1.style.display = "none";
      this.$alert(item.content, "文件名：" + item.name, {
        dangerouslyUseHTMLString: true
      });
    },
    //重命名笔记
    editMyFile() {
      this.$refs.menu1.style.display = "none";
      let item = this.rightItem;
      this.viewFileName = !this.viewFileName;
    },
    conFirmChangeFileName() {

      //1-9.修改文本名
      // vuex
      // this.$store.commit("editmyFile", this.rightItem);
      // 新增加一个方法修改相应的文本名称为文件名
      let params = JSON.stringify({ username: localStorage.username, pre: this.rightItem.name, folder: this.rightItem.folder, now: this.myChangeName });
      this.rightItem.name = this.myChangeName;
      api.editFileName(params).then(res => {
        this.getFiles();
      })

      this.viewFileName = !this.viewFileName;
      this.data = this.handleData(this.files);
      Bus.$emit("change-content", this.rightItem);
      Bus.$emit("fresh");
      // this.$router.push({ name: "addEdit", params: { item: this.rightItem } });
    },
    cancelChangeFileName() {
      this.myChangeName = this.rightItem.name;
      this.viewFileName = !this.viewFileName;
    },
    //删除文本
    deleteMyFile() {
      let item = this.rightItem;
      // console.log(item);
      this.$confirm("此操作将永久删除该文件, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.fileVisible = false;
          let files = { ...item };
          //1-5.删除文本，
          let params = JSON.stringify({ username: localStorage.username, name: item.name, folder: item.folder });
          api.deleteFile(params).then(res => {
            // 返回删除成功即可
            this.getFiles();
          })
          // this.$store.commit("deleteMyFile", files);
          this.$message({
            type: "success",
            message: "删除成功!"
          });
          Bus.$emit("fresh");
          this.$router.push({ name: "notes" });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    //隐藏菜单
    documentClick() {
      if (this.$refs.menu1) {
        this.$refs.menu1.style.display = "none";
      }
      if (this.$refs.menu2) {
        this.$refs.menu2.style.display = "none";
      }
    },
    //右键节点事件
    rightClick(data, data1, data2) {
      if (this.folders.indexOf(data1.label) != -1) {
        this.rightItem = data1.label;
        this.myChangeName = this.rightItem;
        let left = data.clientX;
        let top = data.clientY;
        this.$refs.menu2.style.left = left + "px";
        this.$refs.menu2.style.top = top + "px";
        this.$refs.menu2.style.display = "block";
        if (this.$refs.menu1) {
          this.$refs.menu1.style.display = "none";
        }
      } else {
        if (data1.label != "我的笔记本") {
          this.rightItem = data1.data;
          this.myChangeName = this.rightItem.label;
          let left = data.clientX;
          let top = data.clientY;
          this.$refs.menu1.style.left = left + "px";
          this.$refs.menu1.style.top = top + "px";
          this.$refs.menu1.style.display = "block";
          if (this.$refs.menu2) {
            this.$refs.menu2.style.display = "none";
          }
        }
      }
    },
    //拖拽成功触发函数
    handleDrop(draggingNode, dropNode, dropType, ev) {
      // console.log(draggingNode);
      //修改文件夹
      let params = JSON.stringify({ username: localStorage.username, name: draggingNode.data.label, folder: draggingNode.data.data.folder });
      api.deleteFile(params).then(res => {
        //       // 返回删除成功即可
        let params1 = JSON.stringify({ username: localStorage.username, name: draggingNode.data.label, folder: dropNode.label, content: draggingNode.data.data.content, time: draggingNode.data.data.time });
        api.addFile(params1).then(res => {

        })
        //       this.getFiles();
      })
      draggingNode.data.data.folder = dropNode.label;
      // console.log(this.files);
    },
    //允许拖拽放置
    allowDrop(draggingNode, dropNode, type) {
      if (type == "inner") {
        if (this.folders.indexOf(dropNode.data.label) == -1) {
          return type !== "inner";
        } else {
          let labels = dropNode.data.children.map(el => el.label);
          // 文本同名不允许拖拽
          if (labels.indexOf(draggingNode.data.label) != -1) {
            return type !== "inner";
          } else {
            return true;
          }
        }
      }
    },
    //允许呗拖拽
    allowDrag(draggingNode) {
      return this.folders.indexOf(draggingNode.data.label) == -1;
    },
    //处理数据为树节点结构
    handleData(data) {
      // console.log(data);
      // let myData = [{label:'我的笔记本',children:[]},{label:'全部笔记',children:[]}];
      let myData = [{ label: "我的笔记本", children: [] }];
      let bb = this.folders;
      // console.log(bb);

      for (let i = 0; i < bb.length; i++) {
        let cc = data.filter(el => {
          return el.folder == bb[i];
        });

        let child = [];
        for (let j = 0; j < cc.length; j++) {
          child.push({ label: cc[j].name, data: cc[j] });
        }

        //  if(child.length==0){
        //    child.push({label:'(空)',data:''});
        //  }
        //  this.$set(myData,children,)
        myData[0].children.push({ label: bb[i], children: child });

        //  myData[1].children.push(label:)
      }
      // for(let k =0 ;k < data.length;k++){
      //     myData[1].children.push({label:data[k].name,data:data[k]})
      //  }

      return myData;
    },
    //点击节点触发函数
    handleNodeClick(data) {
      this.index = 0;
      this.documentClick();
      if (data.label == "我的笔记本") {
        this.$router.push({ name: "notes" });
      }
      if (data.data) {
        Bus.$emit("change-content", data.data);
        this.$router.push({ name: "addEdit", params: { item: data.data } });
      }
      // this.$router.push({path:'/'})
    },
    chooseIndex(index) {
      this.index = index;
    },

    //确认保存（修改笔记内容）
    confirmSaveFile() {
      // 1-6修改文本内容
      let params = JSON.stringify({
        username: this.editName ? this.editName : localStorage.username,
        name: this.fileName,
        folder: this.fileFolderName,
        content: this.fileContent,
        time: this.time      });
      console.log(params)
      api.modifyContent(params).then(res => {
        this.getFiles();
        //  this.data = this.handleData(this.files);
        // 将内容和时间修改
      })
      // this.$store.commit("modifyMyFileContent", {
      //   name: this.fileName,
      //   folder: this.fileFolderName,
      //   content: this.fileContent,
      //   time: this.time
      // });
      this.viewConfirmMask = !this.viewConfirmMask;
      this.fileName = "";
      this.fileFolderName = "";
      this.time = "";
      // this.$router.push({ name: "notes" });
    },
    cancelSaveFile() {
      this.toggleConfirmSave();
    },
    //获取当前用户的昵称
    getName() {
      let username = localStorage.username;
      api.getName({ userName: username }).then(res => {
        this.name = res.data.name;
      });
    },
    // 添加文件的弹出罩切换
    toggleFileMask() {
      this.viewFileMask = !this.viewFileMask;
    },
    //确认保存弹出框显示切换
    toggleConfirmSave() {
      this.viewConfirmMask = !this.viewConfirmMask;
    },
    //获取编辑器文件内容和文件名称
    FileContent(text, filename, foldername, time, editName) {
      this.fileContent = text;
      this.fileName = filename;
      this.fileFolderName = foldername;
      this.time = time;
      this.editName = editName;
    },
    cancelAddfile() {
      this.toggleFileMask();
      this.fileName = "";
      this.fileFolderName = "";
      this.time = "";
    },
    // 添加笔记本的弹出罩切换
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
    //添加笔记本
    // addFolder() {
    //   if (this.foldName != "") {
    //     this.$store.commit("addFolder", { name: this.foldName, files: [] });
    //     this.toggleFolderMask();
    //     this.foldName = "";
    //     this.$router.push({ name: "notes" });
    //   } else {
    //     this.dialogVisible = true;
    //   }
    // },
    addFolder() {
      if (this.foldName != "") {
        // 1-7添加文件夹
        let params = JSON.stringify({ username: localStorage.username, name: this.foldName });
        api.addFolder(params).then(res => {
          this.getFolders();
          this.handleData(this.files);
        })
        // this.$store.commit("addMyFolder", this.foldName);
        this.toggleFolderMask();
        Bus.$emit("fresh");
        this.foldName = "";
        this.$router.push({ name: "notes" });
      } else {
        this.dialogVisible = true;
      }
    },
    //添加笔记
    addfile() {
      if (this.fileName != "") {
        // this.$store.commit("addFile", {
        //   name: this.fileName,
        //   content: ""
        // });
        this.getTime();
        if (!this.fileFolderName) {
          this.$message({
            showClose: true,
            message: "请选择笔记本",
            // duration: 4000,
            type: "error"
          });
          return;
        }
        // console.log("2222");
        // console.log(this.$store.state.myfiles);
        let file = this.files;
        // let flag = false;
        for (let i = 0; i < file.length; i++) {
          if (file[i].name == this.fileName && file[i].folder == this.fileFolderName) {

            this.$message({
              showClose: true,
              message: "该文件夹已有相同的文本名称，请修改名称",
              // durati1on: 4000,
              type: "error"
            });
            return
          }
        }
        // 1-8-添加文本
        let params = JSON.stringify({ username: localStorage.username, name: this.fileName, folder: this.fileFolderName, content: '', time: this.time });
        api.addFile(params).then(res => {

          this.getFiles();


        })
        // this.$store.commit("addMyFiles", {
        //   name: this.fileName,
        //   folder: this.fileFolderName,
        //   content: "",
        //   time: this.time
        // });
        Bus.$emit("fresh");
        this.toggleFileMask();
        this.fileName = "";
        this.fileFolderName = "";
        this.time = "";
        this.$router.push({ name: "notes" });
      } else {
        this.dialogVisible2 = true;
      }
    },
    cancelAddFolder() {
      this.toggleFolderMask();
    },
    getTime() {
      let myDate = new Date();
      let [y, m, d, h, f, s] = [
        myDate.getFullYear(),
        myDate.getMonth() + 1,
        myDate.getDate(),
        myDate.getHours(),
        myDate.getMinutes(),
        myDate.getSeconds()
      ];
      m = m >= 10 ? m : "0" + m;
      d = d >= 10 ? d : "0" + d;
      h = h >= 10 ? h : "0" + h;
      f = f >= 10 ? f : "0" + f;
      s = s >= 10 ? s : "0" + s;
      this.time = y + "/" + m + "/" + d + " " + h + ":" + f + ":" + s;
    },
    //修改用户名
    changeName() {
      this.myChangeName = this.name;
      this.viewChangeName = !this.viewChangeName;
    },
    //确认修改用户名
    conFirmChangeName() {
      let username = localStorage.username;
      // this.name = this.myChangeName;
      api
        .modifyName({ userName: username, name: this.myChangeName })
        .then(res => {
          this.getName();
        });
      this.viewChangeName = !this.viewChangeName;
      this.$router.push({ name: "notes" });
    },
    //取消修改
    cancelChangeName() {
      (this.myChangeName = this.name),
        (this.viewChangeName = !this.viewChangeName);
      this.$router.push({ name: "notes" });
    },
    Synch() {
      // console.log("同步");
      this.getFiles();
      this.getFolders();
      Bus.$emit('synch')
      this.$message({
        showClose: true,
        message: "同步成功",
        // duration: 4000,
        type: "success"
      })
    }
  }
};
</script>
<style lang="less">
.el-message-box__wrapper {
  z-index: 99999;
}
.el-tree {
  width: 100%;
  /* height: 50px; */
  /* line-height: 50px; */
  min-width: 100px;

  /* padding-left: 5%; */
  /* -webkit-box-sizing: border-box; */
  box-sizing: border-box;
  // padding-left: 40px;
  /* position: relative; */
  text-align: left;
  margin-top: 10px;
  position: relative;
  cursor: default;
  background: #2f3941;
  color: #b5babe;
  & > .el-tree-node > .el-tree-node__content {
    background: #2f3941;
    height: 50px;
    line-height: 50px;
  }
  .el-tree-node__content:hover {
    background: transparent;
    color: #b5babe;
  }
  .el-tree-node:focus > .el-tree-node__content {
    background: #a4a4a4;
    color: #000;
    font-size: 16px;
  }
  .el-tree-node__label {
    font-size: 16px;
    padding-left: 10px;
  }
}
.action {
  position: absolute;
  // left: 20px;
  // top: 20px;
  width: 80px;
  z-index: 999999;
  display: none;

  ul {
    background: #ffffff;
    box-shadow: 2px 2px 2px #888888;
    padding: 0;
    border: 1px solid #d5dae0;
    color: #333;
    font-size: 12px;

    li {
      cursor: pointer;
      list-style: none;
      padding: 10px 0px;
    }

    li:hover {
      background: #d5dae0;
    }
  }
}
.el-message-box__wrapper {
  z-index: 999999 !important;
}
</style>
