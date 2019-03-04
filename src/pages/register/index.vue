<template>
  <div class="register" @keydown="lost">
    <keep-alive>
      <el-input v-model="username" placeholder="请输入账号" class="rAccount"></el-input>
    </keep-alive>
    <keep-alive>
      <el-input v-model="password" placeholder="请输入密码" class="rPassWorld" type="password"></el-input>
    </keep-alive>
    <keep-alive>
      <el-input v-model="sePassWorld" placeholder="请再次输入密码" class="sePassWorld" type="password"></el-input>
    </keep-alive>

    <el-row class="btn">
      <el-button type="primary" @click="submit">立即注册</el-button>
    </el-row>
    <el-row v-if="registerFlag" class="error">该用户已存在</el-row>
    <el-row v-if="password !== sePassWorld" class="error">两次密码不一样</el-row>
  </div>
</template>

<script>
import api from "@/api/index.js";
export default {
  data() {
    return {
      username: "",
      password: "",
      sePassWorld: "",
      registerFlag: false
    };
  },
  methods: {
    submit() {
      if (this.password === this.sePassWorld) {
        api
          .register({
            userName: this.username,
            password: this.password
          })
          .then(res => {
            console.log(res);
            if (res.data.status == "success") {
              // this.$store.dispatch('setUser', this.username);
              // this.$router.push({name:'home'});//跳转哪一个路由
              // console.log('注册成功');
              this.$message({
                showClose: true,
                message: "恭喜你，你已经成功注册,正在跳转到登录页面",
                type: "success"
              });
              let t;
              let that = this;
              clearTimeout(t);
              t = setTimeout(function() {
                console.log(that.$router);
                that.$router.push({ name: "login" }); //跳转哪一个路由
              }, 2000);
            }
            if (res.data.status == "fail") {
              this.registerFlag = true;
            }
          });
      }
    },
    lost() {
      this.registerFlag = false;
    }
  }
};
</script>

