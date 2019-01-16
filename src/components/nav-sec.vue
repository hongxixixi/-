<template>
  <div class="edit">
    <div class="left">
      <list-item :content="dataArray"></list-item>
    </div>
    <div class="right">
      <keep-alive>
        <editor-bar v-model="editor.info" :isClear="isClear" @change="change"></editor-bar>
      </keep-alive>
    </div>
  </div>
</template>

<script>
import EditorBar from "./EditorBar";
import ListItem from "./ListItem";
export default {
  data() {
    return {
      editor: {
        info: ""
      },
      isClear: false,
      dataArray: []
    };
  },
  methods: {
    change(val) {
      this.editor.info = val;
      this.dataArray.push(this.editor.info);
    }
  },
  components: {
    EditorBar,
    ListItem
  }
};
</script>
<style>
.edit {
  width: 100%;
}
.left {
  float: left;
  width: 30%;
}
.right {
  float: right;
  width: 70%;
}
.footer {
  float: right;
}
</style>


