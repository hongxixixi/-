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
  // 获取昵称，返回20条数据
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
  }

  

  
}

export default api
