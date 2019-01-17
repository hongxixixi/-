<template>
  <div class="note_header">
    <el-row class="note_header_row">
      <el-col :span="4" class="left">
        <i class="el-icon-edit-outline"></i>
        <span>爱笔记</span>
      </el-col>
      <!-- <el-col :span="15" class="mid">mid</el-col> -->
      <el-col :span="5" :offset="15" class="right">
        <span class="login">
          <router-link :to="{path:'/'}">登录</router-link>
        </span>
        <i class="el-icon-arrow-down"></i>
        <el-breadcrumb separator="|">
          <el-breadcrumb-item>官网</el-breadcrumb-item>
          <el-breadcrumb-item>
            <a href="/">会员</a>
          </el-breadcrumb-item>
          <el-breadcrumb-item>客户端下载</el-breadcrumb-item>
        </el-breadcrumb>
      </el-col>
    </el-row>
  </div>
</template>
<script>
export default {};
</script>

