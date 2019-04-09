import axios from '@/axios'

const api = {
  // 登录，传账号和密码
  login(params) {
    return axios.get('/login', {params})
  },
  // 注册，传账号和密码
  register(params){
    return axios.get('/register',{params})
  },
  // 根据用户名获取昵称
  getName(params){
    return axios.get('/getName',{params})
  },
  modifyName(params){
    return axios.get('/modifyName',{params})
  },
  refreshfiles(params){
    return axios.post('/refreshFiles.api',params)
  },
  refreshfolders(params){
    return axios.post('/refreshFolders.api',params)
  },
  getFiles(params){
    return axios.post('/getFiles.api',params)
  },
  getFolders(params){
    return axios.post('/getFolders.api',params)
  },
  addFriend(params){
    return axios.post('/addFriend.api',params)
  },
  deleteFriend(params){
    return axios.post('/deleteFriend.api',params)
  },
  isGetName(params){
    return axios.post('/isGetName.api',params);
  },
  getFriend(params){
    return axios.post('/getFriend.api',params);
  },
  createCrowd(params){
    return axios.post('/creatCrowd.api',params);
  },
  getCrowd(params){
    return axios.post('/getCrowd.api',params);
  },
  

  
}

export default api
