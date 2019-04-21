import axios from '@/axios'

const api = {
  // 登录，传账号和密码
  login(params) {
    return axios.get('/login', {
      params
    })
  },
  // 注册，传账号和密码
  register(params) {
    return axios.get('/register', {
      params
    })
  },
  // 根据用户名获取昵称
  getName(params) {
    return axios.get('/getName', {
      params
    })
  },
  modifyName(params) {
    return axios.get('/modifyName', {
      params
    })
  },
  refreshfiles(params) {
    return axios.post('/refreshFiles.api', params)
  },
  refreshfolders(params) {
    return axios.post('/refreshFolders.api', params)
  },
  getFiles(params) {
    return axios.post('/getFiles.api', params)
  },
  getFolders(params) {
    return axios.post('/getFolders.api', params)
  },

  //新添加的7个接口
  addFolder(params) {
    return axios.post('/addFolder.api', params)
  },
  addFile(params) {
    return axios.post('/addFile.api', params)
  },
  editFolderName(params) {
    return axios.post('/editFolderName.api', params)
  },
  deleteFolder(params) {
    return axios.post('/deleteFolder.api', params)
  },
  deleteFile(params) {
    return axios.post('/deleteFile.api', params)
  },
  modifyContent(params) {
    return axios.post('/modifyContent.api', params)
  },
  editFileName(params) {
    return axios.post('/editFileName.api', params)
  },



  addFriend(params) {
    return axios.post('/addFriend.api', params)
  },
  deleteFriend(params) {
    return axios.post('/deleteFriend.api', params)
  },
  isGetName(params) {
    return axios.post('/isGetName.api', params);
  },
  getFriend(params) {
    return axios.post('/getFriend.api', params);
  },
  createCrowd(params) {
    return axios.post('/creatCrowd.api', params);
  },
  getCrowd(params) {
    return axios.post('/getCrowd.api', params);
  },
  deleteCrowd(params) {
    return axios.post('/deleteCrowd.api', params);
  },

  //获取消息
  getMessage(params) {
    return axios.post('/getMessage.api', params);
  },
  //发送消息
  sendMessage(params) {
    return axios.post('/sendMessage.api', params);
  },
  getAllMessage(params) {
    return axios.post('/getAllMessage.api', params);
  },


  saveMessageLen(params) {
    return axios.post('/saveMessageLen.api', params);
  },
  getMessageLen(params) {
    return axios.post('/getMessageLen.api', params);
  },

  getAuthFiles(params) {
    return axios.post('/getAuthFiles.api', params);
  },
  shareFile(params) {
    return axios.post('/shareFile.api', params);
  },
  changeState(params) {
    return axios.post('/changeState.api', params);
  },
  getState(params) {
    return axios.post('/getState.api', params);
  },
  // api.saveMessageLen(JSON.stringify({username:localStorage.username,preMessageLen:66})).then(res=>{
  // api.getMessageLen(JSON.stringify({username:localStorage.username}))
  // })
  // let params=JSON.stringify({username:'111',name:'bb',folder:'物理',beshareUser:'222',authority:'writeAble'})
  // api.shareFile(params);
  // api.getAuthFiles(JSON.stringify({username:localStorage.username}));

  // let params = JSON.stringify({
  //   username: '111',
  //   name: 'bb',
  //   folder: '物理'
  // });
  // api.getState(params);
  // api.changeState(params)
}

export default api
