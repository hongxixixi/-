import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    fileLists: ['笔记1', '笔记2'],
    folderLists: ['文件夹1', '文件夹2'],
    sharefiles: [],
    sharefolders: [],
  },
  mutations: {
    addFile(state, fileItem) {
      state.fileLists.push(fileItem);
    },
    addFolder(state, folderItem) {
      state.folderLists.push(folderItem);
    },
    addShare(state, shareItem) {
      let flag = true;
      for (let i = 0; i < state.fileLists.length; i++) {
        if (shareItem == state.fileLists[i]) {
          state.sharefiles.push(shareItem);
          flag = false;
        }
      }
      if (flag) {
        state.sharefolders.push(shareItem);
      }
    }
  }
})

export default store;
