<template>
  <div class="wrapper">
    <!-- <div style="width：100%;text-align:center;padding:10px 0;">在线笔记系统</div> -->
    <el-form
      :model="ruleForm2"
      status-icon
      :rules="rules2"
      ref="ruleForm2"
      label-width="60px"
      class="demo-ruleForm"
    >
      <el-form-item
        label="用户名"
        prop="username"
      >
        <el-input v-model.number="ruleForm2.username"></el-input>
      </el-form-item>
      <el-form-item
        label="密码"
        prop="pass"
      >
        <el-input
          type="password"
          v-model="ruleForm2.pass"
          autocomplete="off"
        ></el-input>
      </el-form-item>
      <el-form-item class="commitLogin">
        <el-button
          type="primary"
          @click="submitForm('ruleForm2')"
        >提交</el-button>
      </el-form-item>
    </el-form>

    <div class="login-footer">
      <router-link
        tag="li"
        to="/forgetCode"
      >
        <a>忘记密码</a>
        <span>|</span>
      </router-link>

      <router-link
        tag="li"
        to="/registered"
      >
        <a>注册新账号</a>
        <span>|</span>
      </router-link>

      <router-link
        tag="li"
        to="/suggest"
      >
        <a>意见反馈</a>
      </router-link>

    </div>
  </div>
</template>

<script>
export default {
  data() {
    var checkName = (rule, value, callback) => {
      if (!value) {
        return callback(new Error("用户名不能为空"));
      } else {
        callback();
      }
    };
    var validatePass = (rule, value, callback) => {
      if (value === "") {
        callback(new Error("请输入密码"));
      } else {
        callback();
      }
    };
    return {
      ruleForm2: {
        pass: "",
        checkPass: "",
        age: ""
      },
      rules2: {
        pass: [{ validator: validatePass, trigger: "blur" }],
        username: [{ validator: checkName, trigger: "blur" }]
      }
    };
  },
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          // alert("登录成功!");
          const h = this.$createElement;
          // this.$notify({
          //   title: "提示",
          //   message: h("i", { style: "color: teal" }, "登陆成功")
          // });
          this.$route.matched[0].meta.is_login = true;
          this.$router.push("/index");
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  }
};
</script>

<style scoped>
</style>
