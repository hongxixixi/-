<template>
  <div class="share-to-me-lists">
    <div class="file-lists">
      <div
        class="file-box"
        v-for="(item,index) in files"
        :key="index"
        @click="editFile(item)"
      >
        <i class="iconfont icon-wenjian1"></i>
        <div>{{item.name}}</div>
        <div class="auth">{{item.auth.indexOf('writeAble')==-1?'可查看':'可编辑查看'}}</div>
        <div class="auth">由用户{{item.username}}共享</div>
      </div>
    </div>
  </div>
</template>

<script>
import api from "@/api/index.js";

export default {
  components: {},
  data() {
    return {
      files: [],
    };
  },
  computed: {

  },
  beforeDestroy() {

  },
  mounted() {
    this.getAuthFiles();
  },
  methods: {
    //获取笔记
    getAuthFiles() {
      let params = JSON.stringify({ username: localStorage.username });
      api.getAuthFiles(params).then(res => {
        this.files = res.data.data;
      });
    },
    editFile(item) {
      let params = item;
      params.editName = item.username;
      params.auth = item.auth;
      this.$router.push({ name: "addEdit", params: { item: item } });
    }
  }
};
</script>



