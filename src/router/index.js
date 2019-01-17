import Vue from 'vue'
import Router from 'vue-router'
// 这里如果里面是index.vue 写了会报错
import Login from '@/pages/login'
import Index from '@/pages/index'


Vue.use(Router)

const router = new Router({
  routes: [{
    path: '/',
    name: 'login',
    component: Login,
  }, {
    path: '/index',
    name: 'index',
    component: Index,
    children: []
  }]
})
// router.beforeEach(function (to, from, next) {
//   // next()
//   if (to.path == "/login/nav-fir" || to.path == "/login/nav-sec" || to.path == "/login/nav-thi") {
//     if (to.matched[0].meta.is_login) {
//       next()
//     } else {
//       next({
//         name: 'home'
//       });
//     }
//   } else {
//     next();
//   }
// })
export default router
