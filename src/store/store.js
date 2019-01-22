import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

const store = new Vuex.Store({
  state: {
    notesLists: [],
    folderLists: [],
  },
  mutations: {
    increment(listItem) {
      state.notesLists.push(listItem);
    }
  }
})

export default store;
