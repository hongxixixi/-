import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    username:'',
    fileLists: [{name:'笔记1',content:'11'},{name: '笔记2',content:'33'}],
    // folderLists: ['文件夹1', '文件夹2'],
    folderLists:[{name:'文件夹1',files:[{name:'aa',content:'啊啊啊啊1'},{name: 'bb',content:'巴巴爸爸'}]},{name:'文件夹2',files:[{name:'bb',content:'bbbb1'},{name: 'cc',content:'asadas'}]}],
    sharefiles: [],
    sharefolders: [],
    deletefiles:[],
    deletefolders:[],
  },
  mutations: {
    addFile(state,file) {
      state.fileLists.push({name:file.name,content:file.content});
    },
    getUserName(state,name){
      state.username = name;
    },
    modifyFileContent(state,file){
      for(var i = 0;i <state.fileLists.length;i++ ){
        if(state.fileLists[i].name == file.name){
          state.fileLists[i].content = file.content;
        }
      }
    },
    addFolder(state, folder) {
      state.folderLists.push({name:folder.name,files:folder.content});
    },
    addShare(state, shareItem) {
      let flag = true;
      for (let i = 0; i < state.fileLists.length; i++) {
        if (shareItem == state.fileLists[i].name) {
          state.sharefiles.push(shareItem);
          flag = false;
        }
      }
      if (flag) {
        state.sharefolders.push(shareItem);
      }
    },
    delete(state,deleteItem){
      let flag = true;
      let index;
      for (let i = 0; i < state.fileLists.length; i++) {
        if (deleteItem == state.fileLists[i].name) {
          state.deletefiles.push(deleteItem);
          index = i;
          state.fileLists.splice(i,1);
          flag = false;
        }
      }
      if (flag) {
        state.deletefolders.push(deleteItem);
        state.folderLists.splice(index,1);
      }
    }
  }
})

export default store;
