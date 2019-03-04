import Vue from 'vue'
import Router from 'vue-router'
// 这里如果里面是index.vue 写了会报错
import Login from '@/pages/login'
import Index from '@/pages/index'
import Register from '@/pages/register'


Vue.use(Router)

const router = new Router({
  mode: 'history', //去掉井号
  routes: [{
    path: '/',
    name: 'login',
    component: Login,
    children: [{
        path: '/',
        name: 'forgetCode',
        component: Login,
      }, 
      {
        path: '/',
        name: 'suggest',
        component: Login,
      }
    ]
  },
  {
    path: '/registered',
    name: 'registered',
    component: Register,
  },
   {
    path: '/index',
    name: 'index',
    component: Index,
    children: [{
        path: '/index/addEdit',
        name: 'addEdit',
        component: resolve => {
          require(['@/components/lists/addEdit.vue'], resolve)
        },
      },
      {
        path: '/index/myshare',
        name: 'myshare',
        component: resolve => {
          require(['@/components/lists/myshare.vue'], resolve)
        },
      }, {
        path: '/index/shareList',
        name: 'shareList',
        component: resolve => {
          require(['@/components/lists/shareList.vue'], resolve)
        },
      }, {
        path: '/index/notes',
        name: 'notes',
        component: resolve => {
          require(['@/components/lists/notes.vue'], resolve)
        },
        children: [{
          path: '/index/notes/openFolder',
          name: 'openFolder',
          component: resolve => {
            require(['@/components/content/openFolder.vue'], resolve)
          },
        }, ]
      }, {
        path: '/index/partner',
        name: 'partner',
        component: resolve => {
          require(['@/components/lists/notePartner.vue'], resolve)
        },
      },
      {
        path: '/index/recover',
        name: 'recover',
        component: resolve => {
          require(['@/components/lists/recover.vue'], resolve)
        },
      },


    ]
  }]
})

export default router
