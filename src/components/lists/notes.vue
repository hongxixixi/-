<template>
  <div class="note-lists">
    <div class="block">
      <el-button @click="back">显示所有笔记本</el-button>
      <span class="demonstration">笔记排序方式:</span>
      <el-select v-model="sort" placeholder="请选择">
        <el-option
          v-for="item in options"
          :key="item.value"
          :label="item.label"
          :value="item.value"
        ></el-option>
      </el-select>

      <span class="demonstration">根据时间筛选笔记:</span>
      <el-date-picker v-model="value1" type="date" placeholder="选择日期" value-format="yyyy/MM/dd"></el-date-picker>
        <span class="demonstration">关键字筛选:</span>
        <el-input v-model="name" style="width:200px;" placeholder="输入关键字"></el-input>
        <el-button @click="search">搜索</el-button>
    </div>
    <template v-for="(item,index) in myFiles">
      <div
        v-if="flag"
        v-show="!item.folder&&!FolderFile"
        class="flie-box"
        @dblclick="openFile(item)"
        :key="index+'file1'"
        @mousedown.right="showMenu1(item,index)"
      >
        <i class="iconfont icon-wenjian1"></i>
        {{item.name}}
        <div v-if="index==activeIndex" class="action1" v-document-click="documentClick">
          <ul>
            <!-- <li @click="dialogVisible=true;fileVisible = false;shareMyFile(item)">分享</li> -->
            <li @click="moreDetail(item)">查看</li>
            <!-- <li @click="editMyFile(item)">编辑</li> -->
            <li @click="openFile(item)">编辑笔记</li>
            <!-- <li @click="deleteMyFile(item)">删除</li> -->
          </ul>
        </div>
      </div>
      <div
        v-if="!flag"
        class="flie-box"
        @dblclick="openFile(item)"
        :key="index+'file2'"
        @mousedown.right="showMenu1(item,index)"
      >
        <i class="iconfont icon-wenjian1" :title="item.folder"></i>
        {{item.name}}
        <div v-if="index==activeIndex" class="action1" v-document-click="documentClick">
          <ul>
            <!-- <li @click="dialogVisible=true;fileVisible = false;shareMyFile(item)">分享</li> -->
            <li @click="moreDetail(item)">查看</li>
            <!-- <li @click="editMyFile(item)">编辑</li> -->
            <li @click="openFile(item)">编辑笔记</li>
            <!-- <li @click="deleteMyFile(item)">删除</li> -->
          </ul>
        </div>
      </div>
    </template>
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
        <i class="iconfont icon-wenjian1" :title="item.folder"></i>
        {{item.name}}
        <div v-if="index==activeIndex" class="action1" v-document-click="documentClick">
          <ul>
            <!-- <li @click="dialogVisible=true;fileVisible = false;shareMyFile(item)">分享</li> -->
            <li @click="moreDetail(item)">查看</li>
            <!-- <li @click="editMyFile(item)">编辑</li> -->
            <li @click="openFile(item)">编辑笔记</li>
            <!-- <li @click="deleteMyFile(item)">删除</li> -->
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
            <li @click="editMyFolder(item)">编辑笔记</li>
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
import Bus from "@/pages/common/eventBus.js";
export default {
  data() {
    return {
      sort: "",
      options: [
        {
          value: "更新",
          label: "更新时间"
        },
        {
          value: "创建",
          label: "创建时间"
        }
      ],
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
      files: "",
      folders: "",
      flag: true,
      myFiles: "",
      myFolders: "",
      count: 0, //计数
      name:''
    };
  },
  watch: {
    sort(val) {
      this.name="";
      if (val == "更新") {
        this.getTime();
      } else if (val == "创建") {
        this.getTime2();
      }
    },
    count(val) {
      if (val == 2) {
        this.count = 0;
        this.myFiles = [...this.files];
        this.myFolders = [...this.folders];
      }
    },
    value1(val) {
      this.name="";
      this.sort = "";
      if (!val) {
        this.back();
      } else {
        this.filterTime();
      }
    }
  },
  computed: {
    partnerAndcrowds() {
      return this.partners.concat(this.crowds);
    }
  },
  beforeDestroy() {},
  mounted() {
    let params = JSON.stringify({ username: localStorage.username });
    this.getFiles(); //获取文本
    this.getFolders(); //获取文件夹
    this.flag = true;
    Bus.$on("fresh", this.fresh);
  },
  methods: {
    fresh() {
      this.getFiles(); //获取文本
      this.getFolders(); //获取文件夹
      this.flag = true;
      this.value1 = "";
      this.sort = "";
    },
    getTime() {
      let that = this;
      this.myFiles = [...this.files];
      this.myFiles.sort(function(a, b) {
        return Number(that.toTime(a.time)) - Number(that.toTime(b.time));
      });
    },
    toTime(time) {
      let date = time.replace(/-/g, "/");
      this.flag = false;
      this.myFolders = "";
      this.FolderFile = "";
      return new Date(date).getTime();
    },
    getTime2() {
      this.myFiles = [...this.files];
      this.myFolders = "";
      this.FolderFile = "";
      this.flag = false;
    },
    search(){
     this.myFiles=  this.files.filter(el=>{
         return el.name.search(this.name)!=-1;
      })
       this.myFolders = "";
      this.FolderFile = "";
      this.sort=""
      this.flag = false;
   
    },
    getFiles() {
      let params = JSON.stringify({ username: localStorage.username });
      api.getFiles(params).then(res => {
        this.files = res.data.data;
        this.count++;
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
        this.count++;
        // this.data = this.handleData(this.files);
      });
    },
    back() {
      this.value1 = "";
      this.FolderFile = "";
      this.sort = "";
      this.filterTime();
      this.flag = true;
    },
    filterTime() {
      if (!this.value1) {
        this.myFiles = [...this.files];
        this.myFolders = [...this.folders];
      } else {
        let myDate = new Date(this.value1);
        let [y, m, d] = [
          myDate.getFullYear(),
          myDate.getMonth() + 1,
          myDate.getDate()
        ];
        m = m >= 10 ? m : "0" + m;
        d = d >= 10 ? d : "0" + d;

        let time = y + "/" + m + "/" + d;
        let timeFile = [];
        for (let i = 0; i < this.files.length; i++) {
          if (this.files[i].time.slice(0, 10) == time) {
            timeFile.push(this.files[i]);
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
        this.flag = false;
      }
    },

    moreDetail(item) {
      this.showContent= item.content;
      this.$alert(item.content, "文件名：" + item.name, {
        dangerouslyUseHTMLString: true
      });
    },
    shareMyFile(item) {
      this.shareItemName = item;
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
      // this.item.name = this.myChangeName;
      // this.$store.commit("editmyFile", this.item);
      let params = JSON.stringify({
        username: localStorage.username,
        pre: this.item.name,
        folder: this.item.folder,
        now: this.myChangeName
      });
      this.item.name = this.myChangeName;
      api.editFileName(params).then(res => {
        this.getFiles();
      });
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
      this.$confirm("此操作将永久删除该笔记本, 是否继续?", "提示", {
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
      let files = this.files.filter(function(file) {

        return file.folder == item;
      });
      this.FolderFile = [...files];
      this.myFolders = "";
    }
  }
};
</script>
<style>
.note-lists {
  overflow: hidden;
}
</style>


