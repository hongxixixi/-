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
  // 获取昵称，返回20条数据
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
  // let params = JSON.stringify({sendPerson:"xiao",recPerson:"222"});
  // // let params1 = JSON.stringify({sendPerson:"xiao",recPerson:"qunming"});
  // api.getMessage(params).then(res=>{
  // console.log(res);
  // })
  // let params = JSON.stringify({sendPerson:"222",recPerson:"xiao",message:"222发给肖",time:"2019"});
  // api.sendMessage(params).then(res=>{
  // console.log(res);
  // })

}

export default api
