<template>
  <!-- <div class="note-lists" @mousedown="chooseShare">

    <div
      v-for="(item,index) in this.$store.state.fileLists"
      :key="index"
      class="flie-box"
      @dblclick="openFile(item)"
    >
      <i class="iconfont icon-wenjian1"></i>
      {{item.name}}
    </div>

    <div
      v-for="(item,index) in this.$store.state.folderLists"
      :key="index+'folder'"
      class="folder-box"
      @dblclick="openFolder(item)"
    >
      <i class="iconfont icon-wenjianjia"></i>
      {{item.name}}
    </div>

    <div ref="menu" class="menu" style="display:none;position:absolute;">
      <ul>
        <li class="shareClick">分享</li>
        <li>复制</li>
        <li>编辑</li>
        <li class="deleteClick">删除</li>
      </ul>
    </div>

   
  </div>  -->
    <!-- <div class="note-lists" @mousedown="chooseShare"> -->
    <div class="note-lists">

    <template
      v-for="(item,index) in this.$store.state.myfiles"

      
      
    >
    <div v-if="!item.folder" class="flie-box" @dblclick="openFile(item) " :key="index+'file'" @mousedown.right="showMenu1(item)">
      <i class="iconfont icon-wenjian1"></i>
      {{item.name}} <el-dialog
      title="操作"
      :visible.sync="fileVisible"
      width="30%"
      center>
      <!-- <span>需要注意的是内容是默认不居中的</span> -->
      <span slot="footer" class="dialog-footer">
        <el-button type="danger" @click="deleteMyFile(item)">删除</el-button>
        <el-button type="primary" @click="fileVisible = false">分享</el-button>
      </span>
    </el-dialog>
      </div>
       
    </template>

    <template
      v-for="(item,index) in this.$store.state.myfolders"
      
     
    >
    <div v-if="item"  class="folder-box" :key="index+'folder'"
      @dblclick="openFolder(item)" @mousedown.right="showMenu2(item)">
      <i class="iconfont icon-wenjianjia"></i>
      {{item}}
    <el-dialog
      title="操作"
      :visible.sync="folderVisible"
      width="30%"
      center>
      <!-- <span>需要注意的是内容是默认不居中的</span> -->
      <span slot="footer" class="dialog-footer">
        <el-button type="danger" @click="deleteMyFolder()">删除</el-button>
        <el-button type="primary" @click="folderVisible = false">分享</el-button>
      </span>
    </el-dialog>
      </div>
    </template>
    

    <div ref="menu" class="menu" style="display:none;position:absolute;">
      <ul>
        <li class="shareClick">分享</li>
        <li>复制</li>
        <li>编辑</li>
        <li class="deleteClick">删除</li>
      </ul>
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
      fileVisible: false,
      shareItem: "",
      folderVisible:false,
      deleteFolder:'',
    };
  },

  methods: {
    //删除文本
    deleteMyFile(item){
        this.fileVisible = false;
        let files = {...item};
        this.$store.commit('deleteMyFile',files)
      console.log(files);

    },
    //弹出框，操作
    showMenu1(item){
       document.oncontextmenu = function(e){
                e.preventDefault();
          };
    this.fileVisible = true
    
      console.log(item);
      console.log("222");
    },
     deleteMyFolder(){
        this.folderVisible = false;
        let folder = this.deleteFolder;
        console.log(this.deleteFolder);
        this.$store.commit('deleteMyFolder',folder);
        // console.log(folder);
    },
    showMenu2(item){
       document.oncontextmenu = function(e){
                e.preventDefault();
          };
      this.folderVisible = true;
      this.deleteFolder = item;
      console.log(item);
      console.log("222");
    },
    chooseShare(event) {
      var menu = this.$refs.menu;
      event = window.event || event;
      if (
        event.target.parentNode.classList.contains("flie-box") ||
        event.target.parentNode.classList.contains("folder-box") ||
        event.target.classList.contains("flie-box") ||
        event.target.classList.contains("folder-box")
      ) {
        if (event.button == 2) {
          if (
            event.target.parentNode.classList.contains("flie-box") ||
            event.target.parentNode.classList.contains("folder-box")
          ) {
            this.shareItem = event.target.parentNode;
          } else {
            this.shareItem = event.target;
          }

          document.oncontextmenu = function(ev) {
            var ev = ev || event;
            var scrollTop =
              document.documentElement.scrollTop || document.body.scrollTop;
            menu.style.display = "block";
            menu.style.left = ev.clientX + "px";
            menu.style.top = ev.clientY + scrollTop - 12 + "px";
            return false;
          };
        } else {
          menu.style.display = "none";
        }
      } else {
        if (event.target.classList.contains("shareClick")) {
          this.share();
        }
        if (event.target.classList.contains("deleteClick")) {
          this.delete();
        }
        menu.style.display = "none";
        document.oncontextmenu = function(ev) {
          // 如果点击的是其他区域，恢复默认事件
          return true;
        };
      }
    },
    // share() {
    //   this.$store.commit("addShare", this.shareItem.outerText);
    //   this.shareItem = "";
    // },
    share() {
      this.$store.commit("addMyShare", this.shareItem.outerText);
      console.log(this.shareItem);
      this.shareItem = "";
    },
    delete() {
      // console.log(this.shareItem.outerText);
      this.$store.commit("delete", this.shareItem.outerText);
      // console.log(this.shareItem.outerText);
      //根据文本名称删除文本（或者文件夹名称删除文件夹）
      this.shareItem = "";
    },
    openFile(item) {
      console.log(item);
      console.log(item.content);//将内容添加到编辑器中
  
      // this.$router.push({path:'/content/addEdit',query:{item:item}});
      this.$router.push({name:'addEdit',params:{item:item}});

      // alert("跳转到打开文件页面，读取数据库中对应的文件的内容显示在页面");
    },
    openFolder(item) {
      // this.$router.push({name:'openFolder',params:{item:item}});
      this.$router.push({name:'myFiles',params:{item}});

      // 跳转到新路由，显示文件夹的文件
      // this.$router.push({'name':'openFolder'});
    }
  },
  // computed:{
  //   item:function(){
  //     console.log(this.$route);
  //     return this.$route.query;
  //         }
  // },
  // watch:{
  // item(){
  //   console.log(item);
  // }
  // },
};
</script>
<style>
.note-lists{
  overflow:hidden;
}
</style>


