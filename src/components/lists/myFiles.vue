。<template>
  <div class="openFolderContent">
    <div
      v-for="(item,index) in files"
      :key="index"
      class="flie-box"
      @dblclick="openFile(item)"
      @mousedown.right="showMenu1(item,index)"
    >
      <i class="iconfont icon-wenjian1"></i>
      {{item.name}}
      <div
        v-if="index==activeIndex"
        class="action"
        v-document-click="documentClick"
      >
        <ul>
          <li @click="dialogVisible=true;fileVisible = false;shareMyFile(item)">分享</li>
          <li @click="shareFile(item)">共享</li>
          <li @click="moreDetail(item)">查看</li>
          <li @click="editMyFile(item)">编辑</li>
          <li @click="deleteMyFile(item)">删除</li>
        </ul>
      </div>
    </div>
    <!-- 分享文件的弹出框 -->
    <el-dialog
      title=""
      :visible.sync="dialogVisible"
      width="40%"
      class="share-file-dialog"
    >
      分享至：
      <el-select
        v-model="shareMumber"
        placeholder=""
        multiple="multiple"
      >
        <el-option
          v-for="item in partnerAndcrowds"
          :key="item.account"
          :label="item.name"
          :value="item.account.split(';').length>1?item.name:item.account"
        >
        </el-option>
      </el-select>
      <span
        slot="footer"
        class="dialog-footer"
      >
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button
          type="primary"
          @click="confirmShareFlie()"
        >确 定</el-button>
      </span>
    </el-dialog>
    <div
      class="view-change-name"
      v-if="viewChangeName"
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
    <router-view></router-view>
  </div>
</template>
<script>
import api from "@/api/index.js";
export default {
  data() {
    return {
      files: [],
      folderName: "",
      activeIndex: -1,
      viewChangeName: false,
      myChangeName: "",
      item: "",
      dialogVisible: false,
      shareMumber: [],
      crowds: [],
      partners: [],
      shareItemName: '',

    };
  },
  computed: {
    partnerAndcrowds() {
      return this.partners.concat(this.crowds)
    }
  },
  mounted() {
    let params = JSON.stringify({ username: localStorage.username })
    this.getCrowd(params);
    this.getFriend(params);
    if (this.$route.params && this.$route.params.item) {
      this.folderName = this.$route.params.item;
      this.showFiles(this.folderName);
      // this.folderName = this.$route.params.item.name;
    }

  },
  methods: {
    moreDetail(item) {
      this.$alert(item.content, '文件名：' + item.name, {
        dangerouslyUseHTMLString: true
      });
    },
    shareMyFile(item) {
      this.shareItemName = item;
    },
    shareFile(item) {
      // {username：‘aa’，name:'笔记1'，beshareUser：‘bb’，authority：‘readAble’}
      // this.sendMessage();
    },
    confirmShareFlie() {
      if (this.shareMumber.length <= 0) {
        this.$message({
          type: 'warning',
          message: '至少选择一个好友/群!'
        });
        return;
      }
      this.dialogVisible = false;
      this.sendMessage();
    },

    sendMessage() {
      let timeNow = new Date()
      let time = timeNow.getFullYear() + '/' + ('0' + (timeNow.getMonth() + 1)).slice(-2) + '/' + ('0' + timeNow.getDate()).slice(-2) + '  ' +
        timeNow.getHours() + ':' + timeNow.getMinutes() + ':' + ('0' + timeNow.getSeconds()).slice(-2);
      this.shareMumber.forEach((item, index) => {
        let editMessage = JSON.stringify({ sendPerson: localStorage.username, recPerson: item, message: '#' + this.shareItemName, time: time })
        api.sendMessage(editMessage).then(res => {
          if (res.data.reason == 'OK') {
            this.$message({
              type: 'success',
              message: '分享成功!'
            });
          }
        });
      })
      this.shareMumber = [];
    },

    getCrowd(params) {
      api.getCrowd(params).then(res => {
        if (res.data.reason == 'OK') {
          this.crowds = [];
          let data = res.data.data;
          data.forEach((item, index) => {
            this.crowds.push({ account: item.people, name: item.name })
          })
        }
      })
    },
    getFriend(params) {
      api.getFriend(params).then(res => {
        if (res.data.reason == 'OK') {
          this.partners = [];
          let data = res.data.data;
          data.forEach((item, index) => {
            this.partners.push({ account: item.username, name: item.name })
          })
        }
      })
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
    documentClick() {
      this.activeIndex = -1;
    },

    deleteMyFile(item) {
      this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.fileVisible = false;
        let files = { ...item };
        this.$store.commit("deleteMyFile", files);
        this.showFiles(this.folderName);
        this.$message({
          type: 'success',
          message: '删除成功!'
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });

    },
    showFiles(folder) {
      this.files = this.$store.state.myfiles.filter(function (item) {
        return item.folder == folder;
      });
    },
    showMenu1(item, index) {
      document.oncontextmenu = function (e) {
        e.preventDefault();
      };
      this.fileVisible = true;
      this.activeIndex = index;
      this.myChangeName = item.name;
    },
    editMyFile(item) {
      this.item = item;
      this.viewChangeName = !this.viewChangeName;
    },
    openFile(item) {
      // this.$router.push({path:'/content/addEdit',query:{item:item}});
      this.$router.push({ name: "addEdit", params: { item: item } });
      // alert("跳转到打开文件页面，读取数据库中对应的文件的内容显示在页面");
    }
  }
};
</script>

