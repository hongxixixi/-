<template>
  <dir class="openFolder">

    <div
      v-for="(item,index) in this.$store.state.fileLists"
      :key="index"
      class="flie-box"
      @dblclick="openFile(item)"
    >
      <i class="iconfont icon-wenjian1"></i>
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
    <router-view></router-view>
  </dir>
</template>
