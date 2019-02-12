<template>
  <div class="note-lists">
    <div
      v-for="(item,index) in this.$store.state.fileLists"
      :key="index"
      class="flie-box"
    >
      <i class="iconfont icon-wenjian1"></i>
      {{item}}
    </div>

    <div
      v-for="(item,index) in this.$store.state.folderLists"
      :key="index+2"
      class="folder-box"
    >
      <i class="iconfont icon-wenjianjia"></i>
      {{item}}
    </div>
  </div>
</template>

<script>


export default {
  components: {}
}
</script>
