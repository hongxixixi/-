import axios from 'axios'

var instance = axios.create({
  baseURL: 'http://120.78.188.192/'
  // baseURL: 'http://localhost:8090'
})

instance.interceptors.request.use(function (config) {
  config.params = {
    ...config.params,
  }
  // 在发送请求之前做些什么
  return config
}, function (error) {
// 对请求错误做些什么
  return Promise.reject(error)
})

export default instance