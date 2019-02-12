import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    fileLists: ['笔记1', '笔记2'],
    folderLists: ['文件夹1', '文件夹2'],
  },
  mutations: {
    addFile(state, fileItem) {
      state.fileLists.push(fileItem);
    },
    addFolder(state, folderItem) {
      state.folderLists.push(folderItem);
    }
  }
})

export default store;
