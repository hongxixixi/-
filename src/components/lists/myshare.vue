<template>
  <div class="mid">
    <div
      v-for="(item,index) in this.$store.state.shareLists"
      :key="index"
      class="flie-box"
    >
      <i class="iconfont icon-wenjian1"></i>
      {{item}}
    </div>

  </div>
</template>