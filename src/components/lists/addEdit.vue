<template>
  <div
    class="editor-box"
    ref="editor"
  >
    <div class="file-title">笔记名:{{filename}}
      <span
        v-if="auth"
        style="margin-left:28px;font-size:16px;"
      >权限：{{auth.indexOf('writeAble')==-1?'可查看':'可编辑查看'}}</span>
      <span
        style="font-size:16px;"
        v-if="auth"
      >(由用户{{sharePers}}共享)</span>
      <span style="margin-left:28px;font-size:16px;">当前共享的用户：
        <span v-if="editPerson">可编辑:{{editPerson}}</span>
        <span v-if="readPerson">可查看:{{readPerson}}</span>
      </span>
    </div>
    <div class="
          sava-edit">
      <!-- <i class="el-icon-edit"></i>
      <i class="el-icon-upload"></i>
      <i class="el-icon-share"></i>
      <i class="el-icon-delete"></i>-->
      <span>上次更新时间 : {{time}}</span>
      <el-button
        type="primary"
        @click="addFile"
        v-if="showSavaBotton"
        ref="sava"
        style="display:block"
      >本地保存</el-button>
    </div>
    <div
      id="editorElem"
      class="editor"
      style="text-align:left"
    ></div>
  </div>
</template>

<script>
import Bus from "@/pages/common/eventBus.js";
import E from "wangeditor";
import store from "@/store/store.js";
import em from "./em.js";
import api from "@/api/index.js";

export default {
  name: "editor",
  data() {
    return {
      editorContent: "",
      filename: "",
      foldername: "",
      time: "",
      editor: "",
      editName: '',
      flag: false,
      auth: '',
      sharePers: '',
      mark: false,
      showSavaBotton: true,
      editPerson: '',
      readPerson: '',
      isBeShare: false,
    };
  },

  mounted() {
    if (!this.flag) {
      this.init();
      Bus.$on("change-content", this.change);
    }
  },
  computed: {
    forState() {
      return { sharePers: this.isBeShare ? this.sharePers : localStorage.username, filename: this.filename, foldername: this.foldername, isBeShare: this.isBeShare };
    }
  },
  methods: {
    change(item) {
      this.editor.txt.html(item.content);
      this.filename = item.name;
      this.foldername = item.folder;
      this.time = item.time;
      this.readPerson = item.readPerson;
      this.editPerson = item.editPerson;
      this.isBeShare = item.isBeShare;
    },
    init() {
      this.editor = new E("#editorElem");
      this.editor.customConfig.uploadImgShowBase64 = true;
      this.editor.customConfig.uploadImgMaxSize = 1 * 1024 * 1024;
      this.editor.customConfig.uploadImgMaxLength = 5;
      //配置字体
      this.editor.customConfig.fontNames = [
        "宋体",
        "微软雅黑",
        "Arial",
        "Tahoma",
        "Verdana",
        "DFKai-SB",
        "SimHei",
        "楷体",
        "YouYuan",
        "FZYaoti"
      ];
      //配置表情包
      this.editor.customConfig.emotions = [
        {
          title: "微博表情",
          type: "image",
          content: em.weibo.toWangEditor()
        },
        {
          title: "新浪表情",
          type: "image",
          content: em.xinlang.toWangEditor()
        }
      ];


      this.editor.customConfig.onchange = html => {
        this.editorContent = html;
      };
      this.editor.create();

      if (this.$route.params.item) {
        this.editor.txt.html(this.$route.params.item.content);
        this.filename = this.$route.params.item.name;
        this.foldername = this.$route.params.item.folder;
        this.time = this.$route.params.item.time;
        this.editName = this.$route.params.item.editName;     // 这个是文件桌面没有的属性，可以区分开修改文件内容时保存请求的username到底用哪个
        this.auth = this.$route.params.item.auth ? this.$route.params.item.auth : '';
        this.sharePers = this.$route.params.item.username;    // 
        this.readPerson = this.$route.params.item.readPerson;
        this.editPerson = this.$route.params.item.editPerson;
        this.isBeShare = this.$route.params.item.isBeShare

        if (this.auth && this.auth == 'readAble') {
          this.showSavaBotton = false;
          let that = this;
          document.onkeydown = function (event) {
            that.$message({
              showClose: true,
              message: "您没有权限修改文件,修改将无法保存",
              type: "error",
              duration: 2000
            });
            return false;
          }
        }
        else {
          document.onkeydown = function (event) {
            return true;
          }
        }
      }
    },
    addFile() {
      var text = this.editorContent; //获取编辑框内的内容
      var myDate = new Date();
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
      this.$emit(
        "FileContent",
        text,
        this.filename,
        this.foldername,
        this.time,
        this.editName,
      );
      this.$emit("toggleConfirmSave");
    },


  },
  watch: {
    mark(val) {
      // console.log(val)
    },
    $route(to, from) {
      this.flag = true;
      this.init();
    },
    foldername(val) {
    },
    forState(val, oldval) {
      // 判断一下是否存在权限，若有则说明是被分享的文件
      if (!this.auth || this.auth.indexOf('writeAble') != -1) {
        // 无论是不是第一次切换进来都要改变当前编辑的笔记的状态，除了只能查看的笔记
        let params1 = JSON.stringify({
          username: val.sharePers,
          name: val.filename,
          folder: val.foldername
        });
        api.getState(params1).then(res => {
          // 当前文件的状态
          this.state = res.data.data.status;
          // 若状态为0，即笔记当前没有被其他用户编辑，则修改笔记状态，进入编辑状态
          if (this.state == 0) {
            api.changeState(params1).then(res => {
              this.mark = true;
              localStorage.setItem('sharePers', this.sharePers);
              localStorage.setItem('filename', this.filename);
              localStorage.setItem('foldername', this.foldername);
              api.getState(params1).then((res) => {
                // 修改后的当前的笔记状态
              })
            });
          }
          // 若状态不为0，即笔记正在被编辑，只允许查看，不能修改
          else {
            this.showSavaBotton = false;
            this.$message({
              showClose: true,
              message: "当前文件正在被其他用户编辑，修改将无法保存",
              type: "error"
            });
          }
        });

        if (oldval.sharePers) {                                    // 不是第一次切换进来，要把上一个编辑的文件的状态改变     
          let params = JSON.stringify({
            username: oldval.isBeShare ? oldval.sharePers : localStorage.username,
            name: oldval.filename,
            folder: oldval.foldername
          });
          api.changeState(params).then(res => {
            // alert('b旧的文件状态')
            api.getState(params).then((res) => {
              // console.log(res.data.data.status + params + '旧的文件状态')
            })
          });
        }
      }
    },
  },

  beforeDestroy() {
    if ((!this.auth || this.auth.indexOf('writeAble') != -1) && this.mark) {
      let params = JSON.stringify({
        username: this.isBeShare ? this.sharePers : localStorage.username,
        name: this.filename,
        folder: this.foldername
      });
      api.changeState(params).then(res => {
        // alert('c销毁前的执行')
        api.getState(params).then((res) => {
          // console.log(res.data.data.status + params + '销毁之后的文件状态')
        })
      });
    }
  }
};
</script>
<style lang="less">
.w-e-text-container {
  z-index: 100 !important;
  height: 92% !important; /*!important是重点，因为原div是行内样式设置的高度300px*/
}
.w-e-toolbar {
  .w-e-menu {
    // position: relative;
    // text-align:center;
    padding: 5px 14px;
    // cursor: pointer;
  }
}
</style>
