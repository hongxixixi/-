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
    </div>
    <div class="sava-edit">
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
      showSavaBotton: true
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
      return { sharePers: this.sharePers, filename: this.filename, foldername: this.foldername };
    }
  },
  methods: {
    change(item) {
      this.editor.txt.html(item.content);
      this.filename = item.name;
      this.foldername = item.folder;
      this.time = item.time;
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
        this.editName = this.$route.params.item.editName;
        this.auth = this.$route.params.item.auth ? this.$route.params.item.auth : '';
        this.sharePers = this.$route.params.item.username;
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
    $route(to, from) {
      this.flag = true;
      this.init();
    },
    foldername(val) {
    },
    forState(val, oldval) {

      if (!this.auth || this.auth.indexOf('writeAble') != -1) {
        let params1 = JSON.stringify({                   // 无论是不是第一次切换进来都要改变当前编辑的文件的状态
          username: val.sharePers,
          name: val.filename,
          folder: val.foldername
        });
        api.getState(params1).then(res => {
          this.state = res.data.data.status;
          console.log(this.state + '拿到的当前文件的状态')
          if (this.state == 0) {
            api.changeState(params1).then(res => {
              this.mark = true;
              api.getState(params1).then((res) => {
                console.log(res.data.data.status + '拿到的修改后的当前的文件状态')
              })
            });
          }
          else {
            this.showSavaBotton = false;
            this.$message({
              showClose: true,
              message: "当前文件正在被其他用户编辑，修改将无法保存",
              type: "error"
            });
          }
        });

        if (oldval) {                                    // 不是第一次切换进来，要把原来编辑的文件的状态改变     
          let params = JSON.stringify({
            username: oldval.sharePers,
            name: oldval.filename,
            folder: oldval.foldername
          });
          api.changeState(params).then(res => {
            api.getState(params).then((res) => {
              console.log(res.data.data.status + '旧的文件状态')
            })
          });
        }
      }
    },
  },
  beforeDestroy() {
    if (!this.auth || this.auth.indexOf('writeAble') != -1 && this.mark) {
      let params = JSON.stringify({
        username: this.sharePers,
        name: this.filename,
        folder: this.foldername
      });
      api.changeState(params).then(res => {
        console.log(res.data.data.status + '销毁之后的文件状态')
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
