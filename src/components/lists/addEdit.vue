<template>
  <div
    class="editor-box"
    ref="editor"
  >
    <div class="file-title">笔记名:{{filename}}</div>
    <div class="sava-edit">
      <!-- <i class="el-icon-edit"></i>
      <i class="el-icon-upload"></i>
      <i class="el-icon-share"></i>
      <i class="el-icon-delete"></i>-->
      <span>上次更新时间 : {{time}}</span>
      <el-button
        type="primary"
        @click="addFile"
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
      flag: false
    };
  },

  mounted() {

    if (!this.flag) {
      this.init();
      Bus.$on("change-content", this.change);
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
        if (this.$route.params.item.auth == 'readAble') {
          let that = this;
          document.onkeydown = function (event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            e.returnvalue = false;                  //return false应该只是不冒泡什么的 ,e.returnvalue = false;才是输入无效
            that.$message({
              showClose: true,
              message: "您没有权限修改文件",
              type: "error"
            });
            return false;
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

    // beforeDestroy(){
    //    Bus.$off("change-content");
    // }
  },
  watch: {
    $route(to, from) {
      this.flag = true;
      this.init();
    },
    foldername(val) {
      console.log(val);
      //调用
    }
  },
  beforeDestroy() {
    //调用
    console.log("33333");
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
