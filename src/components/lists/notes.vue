<template>
  <div class="note-lists">
    <div class="block">
      <el-button @click="back">返回主页面</el-button>
      <span class="demonstration">根据时间筛选文本:</span>
      <el-date-picker v-model="value1" type="date" placeholder="选择日期"></el-date-picker>
      <el-button @click="filterTime">确定</el-button>
    </div>
    <template v-for="(item,index) in myFiles">
      <div
        v-if="!item.folder&&!FolderFile"
        class="flie-box"
        @dblclick="openFile(item)"
        :key="index+'file'"
        @mousedown.right="showMenu1(item,index)"
      >
        <i class="iconfont icon-wenjian1"></i>
        {{item.name}}
        <div v-if="index==activeIndex" class="action" v-document-click="documentClick">
          <ul>
            <li @click="dialogVisible=true;fileVisible = false;shareMyFile(item)">分享</li>
            <li @click="moreDetail(item)">查看</li>
            <li @click="editMyFile(item)">编辑</li>
            <li @click="deleteMyFile(item)">删除</li>
          </ul>
        </div>
      </div>
    </template>
    <!-- 分享文件的弹出框 -->
    <el-dialog title :visible.sync="dialogVisible" width="40%" class="share-file-dialog">
      分享至：
      <el-select v-model="shareMumber" placeholder multiple="multiple">
        <el-option
          v-for="item in partnerAndcrowds"
          :key="item.account"
          :label="item.name"
          :value="item.account.split(';').length>1?item.name:item.account"
        ></el-option>
      </el-select>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="confirmShareFlie()">确 定</el-button>
      </span>
    </el-dialog>
    <template v-for="(item,index) in FolderFile">
      <div
        class="flie-box"
        @dblclick="openFile(item)"
        :key="index+'file'"
        @mousedown.right="showMenu1(item,index)"
      >
        <i class="iconfont icon-wenjian1"></i>
        {{item.name}}
        <div v-if="index==activeIndex" class="action" v-document-click="documentClick">
          <ul>
            <li @click="dialogVisible=true;fileVisible = false;shareMyFile(item)">分享</li>
            <li @click="moreDetail(item)">查看</li>
            <li @click="editMyFile(item)">编辑</li>
            <li @click="deleteMyFile(item)">删除</li>
          </ul>
        </div>
      </div>
    </template>
    <template v-for="(item,index) in myFolders">
      <div
        v-if="item"
        class="folder-box"
        :key="index+'folder'"
        @dblclick="openFolder(item)"
        @mousedown.right="showMenu2(item,index)"
      >
        <i class="iconfont icon-wenjianjia"></i>
        {{item}}
        <div v-if="index==activeIndex2" class="action" v-document-click="documentClick">
          <ul>
            <!-- <li @click="folderVisible = false">分享</li> -->
            <!-- <li>复制</li>-->
            <li @click="editMyFolder(item)">编辑</li>
            <li @click="deleteMyFolder(item)">删除</li>
          </ul>
        </div>
      </div>
    </template>
    <div class="view-change-name" v-if="viewChangeName2">
      <div class="name-box">
        <div class="name-input">
          <span>文件夹名称:</span>
          <el-input v-model="myChangeName"></el-input>
        </div>
        <div class="fold-btn">
          <el-button type="primary" @click="conFirmChangeFileName2">确定</el-button>
          <el-button @click="cancelChangeFileName2">取消</el-button>
        </div>
      </div>
    </div>
    <div class="view-change-name" v-if="viewChangeName">
      <div class="name-box">
        <div class="name-input">
          <span>文本名称:</span>
          <el-input v-model="myChangeName"></el-input>
        </div>
        <div class="fold-btn">
          <el-button type="primary" @click="conFirmChangeFileName">确定</el-button>
          <el-button @click="cancelChangeFileName">取消</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import api from "@/api/index.js";
import store from "@/store/store.js";

export default {
  components: {},
  data() {
    return {
      value1: "",
      FolderFile: "",
      activeIndex: -1,
      activeIndex2: -1,
      show: true,
      fileVisible: false,
      shareItem: "",
      folderVisible: false,
      deleteFolder: "",
      viewChangeName: false,
      viewChangeName2: false,
      myChangeName: "",
      item: "",
      dialogVisible: false,
      shareMumber: [],
      crowds: [],
      partners: [],
      shareItemName: "",
      timeFile: "",
      myFiles: "",
      myFolders: ""
    };
  },
  computed: {
    partnerAndcrowds() {
      return this.partners.concat(this.crowds);
    }
  },
  created() {
    //每次进来这个页面都获取一次当前的群列表和好友列表

    // setTimeout(el => {
      let params = JSON.stringify({ username: localStorage.username });
      this.getCrowd(params);
      this.getFriend(params);
      this.myFiles = this.$store.state.myfiles;
      this.myFolders = this.$store.state.myfolders;
    // }, 0);
  },
  methods: {
    back() {
      this.value1 = "";
      this.FolderFile = "";
      this.filterTime();
    },
    filterTime() {
      if (!this.value1) {
        this.myFiles = this.$store.state.myfiles;
        this.myFolders = this.$store.state.myfolders;
      } else {
        let myDate = new Date(this.value1);
        let [y, m, d] = [
          myDate.getFullYear(),
          myDate.getMonth() + 1,
          myDate.getDate()
        ];
        m = m >= 10 ? m : "0" + m;
        d = d >= 10 ? d : "0" + d;

        let time = y + "-" + m + "-" + d;
        let timeFile = [];
        for (let i = 0; i < this.$store.state.myfiles.length; i++) {
          if (this.$store.state.myfiles[i].time.slice(0, 10) == time) {
            timeFile.push(this.$store.state.myfiles[i]);
          }
        }
        this.myFiles = [...timeFile];
        if (this.myFiles.length == 0) {
          this.$notify({
            title: "提示",
            message: "筛选时间没有文件记录！",
            duration: 2000
          });
        }
        this.myFolders = "";
        this.FolderFile = "";
      }
    },

    moreDetail(item) {
      this.$alert(item.content, "文件名：" + item.name, {
        dangerouslyUseHTMLString: true
      });
    },
    shareMyFile(item) {
      this.shareItemName = item;
    },
    getFiles() {
      let params = JSON.stringify({ username: localStorage.username });
      api.getFiles(params).then(res => {
        store.commit("getFiles", res.data.data);
      });
    },
    getFolders() {
      let params = JSON.stringify({ username: localStorage.username });
      api.getFolders(params).then(res => {
        let data = res.data.data.map(el => el.name);
        store.commit("getFolders", data);
      });
    },

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

    confirmShareFlie() {
      if (this.shareMumber.length <= 0) {
        this.$message({
          type: "warning",
          message: "至少选择一个好友/群!"
        });
        return;
      }
      this.dialogVisible = false;
      this.sendMessage();
    },

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
            this.$message({
              type: "success",
              message: "分享成功!"
            });
          }
        });
      });
      this.shareMumber = [];
    },

    conFirmChangeFileName() {
      this.item.name = this.myChangeName;
      this.$store.commit("editmyFile", this.item);
      this.viewChangeName = !this.viewChangeName;
    },
    cancelChangeFileName() {
      this.myChangeName = this.item.name;
      this.viewChangeName = !this.viewChangeName;
    },
    conFirmChangeFileName2() {
      this.item = this.item + "-" + this.myChangeName;
      this.$store.commit("editmyFolder", this.item);
      this.viewChangeName2 = !this.viewChangeName2;
    },
    cancelChangeFileName2() {
      this.myChangeName = this.item.name;
      this.viewChangeName2 = !this.viewChangeName2;
    },
    documentClick() {
      this.activeIndex = -1;
      this.activeIndex2 = -1;
    },
    //删除文本
    deleteMyFile(item) {
      this.$confirm("此操作将永久删除该文件, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.fileVisible = false;
          let files = { ...item };
          this.$store.commit("deleteMyFile", files);
          this.$message({
            type: "success",
            message: "删除成功!"
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    //弹出框，操作
    showMenu1(item, index) {
      document.oncontextmenu = function(e) {
        e.preventDefault();
      };
      this.fileVisible = true;
      this.activeIndex = index;
      this.activeIndex2 = -1;
      this.myChangeName = item.name;
    },
    deleteMyFolder() {
      this.$confirm("此操作将永久删除该文件, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.folderVisible = false;
          let folder = this.deleteFolder;
          this.$store.commit("deleteMyFolder", folder);
          this.$message({
            type: "success",
            message: "删除成功!"
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    showMenu2(item, index) {
      document.oncontextmenu = function(e) {
        e.preventDefault();
      };
      this.folderVisible = true;
      this.activeIndex2 = index;
      this.activeIndex = -1;
      this.myChangeName = item;
      this.deleteFolder = item;
    },
    editMyFile(item) {
      this.item = item;
      this.viewChangeName = !this.viewChangeName;
    },
    editMyFolder(item) {
      this.item = item;
      this.viewChangeName2 = !this.viewChangeName2;
    },
    share() {
      this.$store.commit("addMyShare", this.shareItem.outerText);
      this.shareItem = "";
    },
    openFile(item) {
      this.$router.push({ name: "addEdit", params: { item: item } });
    },
    openFolder(item) {
      let files = this.$store.state.myfiles.filter(function(file) {
        // console.log(file);
        return file.folder == item;
      });
      this.FolderFile = [...files];
      this.myFolders = "";
      // console.log(this.myFiles);
      // this.$router.push({ name: "myFiles", params: { item } });
    }
  }
};
</script>
<style>
.note-lists {
  overflow: hidden;
}
</style>


