<template>
  <div class="note-lists">
    <div class="block">
      <el-button @click="back">返回主页面</el-button>
      <span class="demonstration">根据时间筛选文本:</span>
      <el-date-picker v-model="value1" type="date" placeholder="选择日期" value-format="yyyy/MM/dd"></el-date-picker>
      <el-button @click="filterTime">确定</el-button>
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
        <div v-if="index==activeIndex" class="action" v-document-click="documentClick">
          <ul>
            <li @click="dialogVisible=true;fileVisible = false;shareMyFile(item)">分享</li>
            <li @click="moreDetail(item)">查看</li>
            <li @click="editMyFile(item)">编辑</li>
            <li @click="deleteMyFile(item)">删除</li>
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
      files: "",
      folders: "",
      flag: true,
      myFiles:'',
      myFolders:'',
      time:''
    };
  },
  computed: {
    partnerAndcrowds() {
      return this.partners.concat(this.crowds);
    }
  },
  beforeDestroy() {
    this.time = '';
    // 这里最好有个离开之前询问是否需要保存当前文件的，不然忘记同步文件不就没有了
  },
  mounted() {
    console.log("222");
    //每次进来这个页面都获取一次当前的群列表和好友列表
    let params = JSON.stringify({ username: localStorage.username });;
    // this.getCrowd(params);
    // this.getFriend(params);
   this.getFiles();//获取文本
    this.getFolders();//获取文件夹
    this.flag = true;
    // this.time=setInterval(el=>{
    //   this.getFolders();
    //   setTimeout(e=>{

    //     this.myFolders = this.folders;
    //   },3000)
    // },2000)
    // this.back();
    // this.myFiles = this.files;
    //     this.myFolders = this.folders;
    // console.log(this.myFiles);
    // console.log(this.myFloders);
    setTimeout(el=>{
          this.myFiles = this.files;
    this.myFolders = this.folders;
    },200)
  },
  methods: {
     getFiles() {
      let params = JSON.stringify({ username: localStorage.username });
      api.getFiles(params).then(res => {
        console.log(res);
        this.files = res.data.data;
         
        console.log(this.files );
        // this.data = this.handleData(this.files);
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
        // this.data = this.handleData(this.files);
        console.log(this.folders)
      });
    },
    back() {
      this.value1 = "";
      this.FolderFile = "";
      this.filterTime();
      this.flag = true;
    },
    filterTime() {
      if (!this.value1) {
        this.myFiles = this.files;
        this.myFolders = this.folders;
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
        console.log(this.myFiles);
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
      let params=JSON.stringify({username:localStorage.username,pre:this.item.name,folder:this.item.folder,now:this.myChangeName});
    this.item.name = this.myChangeName;
    api.editFileName(params).then(res=>{
      this.getFiles();
    })
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
      this.moreDetail(item);
      // this.$router.push({ name: "addEdit", params: { item: item } });
    },
    openFolder(item) {
      let files = this.files.filter(function(file) {
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


