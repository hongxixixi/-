<template>
  <div
    class="note-lists"
    @mousedown="chooseShare"
  >
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
      :key="index+'folder'"
      class="folder-box"
    >
      <i class="iconfont icon-wenjianjia"></i>
      {{item}}
    </div>

    <div
      ref="menu"
      class="menu"
      style="display:none;position:absolute;"
      @click="share"
    >
      <ul>
        <li class="shareClick">分享</li>
        <li>复制</li>
        <li>编辑</li>
        <li>删除</li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  data() {
    return {
      shareItem: '',
    }
  },
  methods: {
    chooseShare(event) {
      var menu = this.$refs.menu;
      event = window.event || event;
      if ((event.target.parentNode.classList.contains('flie-box')) || (event.target.parentNode.classList.contains('folder-box'))
        || event.target.classList.contains('flie-box') || (event.target.classList.contains('folder-box'))) {
        if (event.button == 2) {
          if ((event.target.parentNode.classList.contains('flie-box')) || (event.target.parentNode.classList.contains('folder-box'))) {
            this.shareItem = event.target.parentNode;
          }
          else {
            this.shareItem = event.target;
          }

          document.oncontextmenu = function (ev) {
            var ev = ev || event;
            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            menu.style.display = "block";
            menu.style.left = ev.clientX + "px";
            menu.style.top = ev.clientY + scrollTop - 12 + "px";
            return false;
          }
        }
        else {
          menu.style.display = "none";
        }
      }
      else {
        if (event.target.classList.contains('shareClick')) {
          this.share();
        }
        menu.style.display = "none";
        document.oncontextmenu = function (ev) {       // 如果点击的是其他区域，恢复默认事件
          return true;
        }
      }
    },
    share() {
      this.$store.commit('addShare', this.shareItem.outerText);
      this.shareItem = '';
    },
  }
}
</script>

<style lang="less" scoped>
</style>
