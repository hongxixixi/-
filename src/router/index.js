import Vue from 'vue'
import Router from 'vue-router'
import Login from '@/pages/login'
import Index from '@/pages/index'
import Nav1 from '@/components/nav-fir'
import Nav2 from '@/components/nav-sec'
import Nav3 from '@/components/nav-thi'

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
    children: [{
        path: 'nav-fir',
        name: 'nav1',
        component: Nav1
      },
      {
        path: 'nav-sec',
        name: 'nav2',
        component: Nav2,
        meta: {
          keepAlive: true // 不需要缓存
        }
      },
      {
        path: 'nav-thi',
        name: 'nav3',
        component: Nav3
      }
    ]
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
