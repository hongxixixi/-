<template>
  <div class="note-lists">
    <template v-for="(item,index) in this.$store.state.myfiles">
      <div
        v-if="!item.folder"
        class="flie-box"
        @dblclick="openFile(item)"
        :key="index+'file'"
        @mousedown.right="showMenu1(item,index)"
      >
        <i class="iconfont icon-wenjian1"></i>
        {{item.name}}
        <div v-if="index==activeIndex" class="action" v-document-click="documentClick">
          <ul>
            <li @click="fileVisible = false">分享</li>
            <!-- <li>复制</li>-->
            <li @click="editMyFile(item)">编辑</li>
            <li @click="deleteMyFile(item)">删除</li>
          </ul>
        </div>
      </div>
    </template>

    <template v-for="(item,index) in this.$store.state.myfolders">
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
            <li @click="folderVisible = false">分享</li>
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
export default {
  // mounted(){
  //   console.log(this.$route.params.item);
  // },
  components: {},
  data() {
    return {
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
      item: ""
    };
  },
  methods: {
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
       this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
           this.fileVisible = false;
      let files = { ...item };
      this.$store.commit("deleteMyFile", files);
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
      this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
           this.folderVisible = false;
      let folder = this.deleteFolder;
      this.$store.commit("deleteMyFolder", folder);
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
      console.log(this.shareItem);
      this.shareItem = "";
    },
    openFile(item) {
      this.$router.push({ name: "addEdit", params: { item: item } });
    },
    openFolder(item) {
      this.$router.push({ name: "myFiles", params: { item } });
    }
  }
};
</script>
<style>
.note-lists {
  overflow: hidden;
}
</style>


