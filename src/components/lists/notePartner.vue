<template>
  <div class="note-partner">
    <div class="my-partner">
      <div class="partner-title">
        <span>好友及群聊</span>
        <el-dropdown>
          <span class=" el-dropdown-link">
            <i class="el-icon-plus"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item @click.native="dialogVisible=true">添加好友</el-dropdown-item>
            <el-dropdown-item @click.native="dialogVisible1=true">创建群聊</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </div>

      <div class="partner-list">
        <div
          class="partner"
          v-for="(item,index) in partnerAndcrowds"
          :key="index"
          @click="changePartnerIndex(index)"
          :class="{'active':ind === index}"
        >
          <img
            class="portraitlist"
            src="@/assets/portraitlist.jpg"
            alt=""
          >
          <img
            class="message"
            src="@/assets/message.png"
            alt=""
            v-if="item.hasNew"
          >
          <span>{{item.name}}</span>
          <!-- <span v-if="item.account">({{item.account}})</span> -->
          <!-- <i class="el-icon-arrow-right"></i> -->
        </div>
        <el-dialog
          title=""
          :visible.sync="dialogVisible"
          width="30%"
        >
          输入账号：
          <input
            type="text"
            v-model="partnersAccount"
            @change='isGetName()'
          >
          <i
            class="el-icon-warning"
            style="color:red;"
            v-if='!getNameSucc'
          ></i>
          <span
            slot="footer"
            class="dialog-footer"
          >
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button
              type="primary"
              @click="addFriend()"
            >确 定</el-button>
          </span>
        </el-dialog>

        <el-dialog
          title=""
          :visible.sync="dialogVisible1"
          width="30%"
        >
          输入群名：
          <input
            type="text"
            v-model="qunName"
          >
          <el-select
            v-model="qunMember"
            placeholder="请添加群成员"
            multiple="multiple"
          >
            <el-option
              v-for="item in partners"
              :key="item.account"
              :label="item.name"
              :value="item.account"
            >
            </el-option>
          </el-select>
          <span
            slot="footer"
            class="dialog-footer"
          >
            <el-button @click="dialogVisible1 = false">取 消</el-button>
            <el-button
              type="primary"
              @click="createCrowd()"
            >确 定</el-button>
          </span>
        </el-dialog>
      </div>

    </div>

    <div
      class="send-message"
      ref="sendBox"
    >
      <div class="send-message-title">
        <!-- <span v-if="partnerAndcrowds[ind]">{{partnerAndcrowds[ind].name+'('+partnerAndcrowds[ind].account+')'}} </span> -->
        <span v-if="partnerAndcrowds[ind]">{{partnerAndcrowds[ind].name+'('+partnerAndcrowds[ind].account+')'}} </span>
        <span
          class="delete"
          @click="deleteFriendOrCrowd"
        >
          <i class="el-icon-delete"></i>
        </span>
      </div>
      <div
        class='show-message'
        ref="showBox"
      >
        <div
          v-for="(item,index) in messages"
          :key="index"
          :class="item.user?'user-style':'partner-style'"
        >
          <div
            v-if="item.user"
            class="userName"
          ><img
              src="@/assets/portrait.jpg"
              alt=""
            ><span>{{item.user}}</span></div>
          <div
            v-else-if="item.partner"
            class="partnerName"
          ><img
              src="@/assets/portrait.jpg"
              alt=""
            ><span>{{item.partner}}</span></div>
          <!-- 这里的时间历史部分从后台获取，新的部分自己new Date -->
          <div class="time"><span>{{item.time}}</span></div>
          <div
            class="say"
            v-if="item.say"
          ><span>{{item.say}}</span></div>
          <div
            class="share"
            v-if="item.share.name"
            @dblclick="openFile(item.share)"
          >
            <span class="file-name"> {{item.share.name}}</span>
            <i class="iconfont icon-wenjian1"></i>
          </div>
        </div>
      </div>
      <div class="edit-message">
        <div class="edit-content">
          <textarea
            class="text-area"
            ref='messageText'
          ></textarea>
          <button
            class="send-buton"
            @click="sendMessage"
          >发送</button>
        </div>
      </div>
    </div>

    <div class="show-file">
      <div class='show-file-title'><span>文件分享记录</span></div>
      <div class='show-flie-record'>
        <div
          v-for="(item,index) in fileRecord"
          :key="index"
          :class="item.user?'user-style':'partner-style'"
        >
          <div
            v-if="item.user"
            class="userName"
          ><span>{{item.user}}</span></div>
          <div
            v-else-if="item.partner"
            class="partnerName"
          ><span>{{item.partner}}</span></div>
          <!-- 这里的时间历史部分从后台获取，新的部分自己new Date -->
          <div class="time"><span>{{item.time}}</span></div>
          <div class="share">
            <span class="file-name"> {{item.share}}</span>
            <i class="iconfont icon-wenjian1"></i>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import api from "@/api/index.js";
import store from "@/store/store.js";

export default {
  data() {
    return {
      dialogVisible: false,
      dialogVisible1: false,
      qunMember: [],
      qunName: '',
      partnersAccount: '',
      getNameSucc: true,
      timeNow: new Date(),
      ind: 0,//选中的用户index
      fileRecord: [
        { partner: '小张(2132565323)', share: '文件/文件夹名称', time: ' 2019/4/6 12: 22' },
        { user: '往后', share: '文件/文件夹名称', time: '2019 / 4 / 6 13: 11' },
      ],
      partners: [
        // { name: '小张', account: '2132565323' },
        // { name: '小敏一', account: '2132323' },
        // { name: '群聊1', account: '2323' },
      ],
      fileRecord:[],
      crowds: [],
      messages: [
        // { user: '往后', say: '早上好，努力做毕设', time: '2019/4/6 12: 16 ' },
        // { partner: '小张(2132565323)', say: '其他好友说的话其他好友说的话', time: '2019/4/6 12: 18 ' },
        // { partner: '小张(2132565323)', share: '文件/文件夹名称', time: ' 2019/4/6 12: 22' },    //分享了文件或者文件夹
        // { user: '往后', share: '文件/文件夹名称', time: '2019/4/6 13: 11' },
      ],
    }
  },
  computed: {
    partnerAndcrowds() {
      return this.partners.concat(this.crowds)
    }
  },
  mounted() {
    let that = this;

    new Promise(function (resolve, reject) {      // 这里用异步之后，可以不用计算属性的，懒得改
      that.getFriend().then(resolve);
    })
      .then(function (resolve, reject) {
        that.getCrowd().then(resolve);
      })
      .then(function (resolve, reject) {
        that.getMessage().then(resolve);
      });

    document.onkeydown = function (event) {
      var e = event || window.event || arguments.callee.caller.arguments[0];
      if (e && e.keyCode == 13) {
        event.preventDefault();
        that.sendMessage()
      }
    };
  },
  methods: {
    openFile(item) {
      console.log("open");
      console.log(item);
      // 如果文件里面已经有这个内容，名字后面截图三位，如果是‘（num）’的格式，就把‘ （num+1） ’这个加在名字后面再保存
      this.$store.commit("addMyFiles", item);
      // console.log(this.$store.state.myfiles)
      this.$message({
        type: 'success',
        message: '已保存到桌面!'
      });
      this.$router.push({ name: "addEdit", params: { item: item } });
    },

    createCrowd() {
      if (this.qunName == '') {
        this.$message({
          type: 'warning',
          message: '群名不能为空!'
        });
        return;
      }
      else if (this.qunMember.length < 1) {
        this.$message({
          type: 'warning',
          message: '请至少添加一位群成员!'
        });
        return;
      }
      this.dialogVisible1 = false;
      let menbs = JSON.parse(JSON.stringify(this.qunMember));
      menbs.unshift(localStorage.username);      //第一个-群主
      let params = JSON.stringify({ name: this.qunName, people: menbs.join(';') })
      this.qunMember = [];
      this.qunName = '';
      api.createCrowd(params).then(res => {
        if (res.data.reason == 'OK') {
          this.getCrowd();
        }
      })
    },
    getCrowd() {
      let that = this;
      let params = JSON.stringify({ username: localStorage.username })
      return api.getCrowd(params).then(res => {
        if (res.data.reason == 'OK') {
          that.crowds = [];
          let data = res.data.data;
          data.forEach((item, index) => {
            that.crowds.push({ account: item.people, name: item.name, hasNew: false })
          })
        }
      })
    },
    getFriend() {
      let params = JSON.stringify({ username: localStorage.username });
      return api.getFriend(params).then(res => {
        if (res.data.reason == 'OK') {
          this.partners = [];
          let data = res.data.data;
          data.forEach((item, index) => {
            this.partners.push({ account: item.username, name: item.name, hasNew: true })
          })
        }
      })
    },

    isGetName() {
      let params = JSON.stringify({ username: this.partnersAccount });
      for (let i = 0; i < this.partners.length; i++) {
        if (this.partnersAccount == this.partners[i].account) {     // 如果好友已经在列表，直接返回
          this.$message({
            type: 'warning',
            message: '用户已在好友列表!'
          });
          return;
        }
      }
      api.isGetName(params).then(res => {
        if (res.data.data) {
          this.getNameSucc = true;
        }
        else {
          this.getNameSucc = false;
          this.partnersAccount = '';
          this.$message({
            type: 'warning',
            message: '用户不存在!'
          });
        }
      })
    },

    addFriend() {
      if (this.partnersAccount == '') {
        this.$message({
          type: 'warning',
          message: '用户不存在!'
        });
        return;
      }
      this.dialogVisible = false;
      let params = JSON.stringify({ username: localStorage.username, fname: this.partnersAccount });
      api.addFriend(params).then(res => {
        if (res.data.reason == 'OK') {

          this.getFriend();
        }
      });
      this.partnersAccount = ''
    },

    deleteFriend(params) {
      this.$confirm('此操作将删除该好友, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        api.deleteFriend(params).then(res => {
          this.ind--;
          this.getFriend();
        })
        this.$message({
          type: 'success',
          message: '删除成功!'
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },

    deleteCrowd(params) {
      this.$confirm('此操作将删除/退出该群, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        api.deleteCrowd(params).then(res => {
          this.ind--;
          this.getCrowd();
        })
        this.$message({
          type: 'success',
          message: '删除成功!'
        });
      }).catch(() => {
        this.$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    },

    deleteFriendOrCrowd() {
      let fnames = this.partnerAndcrowds[this.ind].account.split(';');
      if (fnames.length > 1) {
        let params = JSON.stringify({ username: localStorage.username, name: this.partnerAndcrowds[this.ind].name });
        this.deleteCrowd(params)
      }
      else {
        let params = JSON.stringify({ username: localStorage.username, fname: this.partnerAndcrowds[this.ind].account });
        this.deleteFriend(params);
      }
    },

    scrollToBottom() {
      let sendHeight = this.$refs.showBox.scrollHeight;
      this.$refs.showBox.scrollTo(0, sendHeight)
    },

    changePartnerIndex(index) {
      this.ind = index;
      this.getMessage();
    },
    sendMessage() {
      let timeNow = new Date()
      let time = timeNow.getFullYear() + '/' + ('0' + (timeNow.getMonth() + 1)).slice(-2) + '/' + ('0' + timeNow.getDate()).slice(-2) + '  ' +
        timeNow.getHours() + ':' + timeNow.getMinutes() + ':' + ('0' + timeNow.getSeconds()).slice(-2);
      let recP = this.partnerAndcrowds[this.ind];
      let editMessage = JSON.stringify({ sendPerson: localStorage.username, recPerson: recP.account.split(';').length > 1 ? recP.name : recP.account, message: this.$refs.messageText.value, time: time })
      if (editMessage.say == '') {
        this.$message({
          type: 'warning',
          message: '不能发送空消息!'
        });
        return;
      }
      api.sendMessage(editMessage).then(res => {
        if (res.data.reason == 'OK') {
          this.getMessage();
        }
      });
      this.$refs.messageText.value = ''
      this.$nextTick(function () {
        this.scrollToBottom();
      })
    },
    getMessage() {
      let recP = this.partnerAndcrowds[this.ind];
      let params = JSON.stringify({ sendPerson: localStorage.username, recPerson: recP.account.split(';').length > 1 ? recP.name : recP.account }); // 个人
      this.messages = [];
      if (recP.account.split(';').length > 1) {         // 群 
        return api.getMessage(params).then(res => {
          res.data.data.forEach((item, index) => {
            if (item.sendPerson == localStorage.username) {
              this.messages.push({ user: item.sendPerson, say: item.message.startsWith("#") ? '' : item.message, share: item.message.startsWith("#") ? JSON.parse(item.message.slice(1)) : '', time: item.time })
            }
            else {
              this.messages.push({ partner: item.sendPerson, say: item.message.startsWith("#") ? '' : item.message, share: item.message.startsWith("#") ? JSON.parse(item.message.slice(1)) : '', time: item.time })

            }
          })
          this.$nextTick(function () {
            this.scrollToBottom();
          })
        })
      }
      else {                                          // 个人
        return api.getMessage(params).then(res => {
          res.data.data.forEach((item, index) => {
            if (item.send == localStorage.username) {
              this.messages.push({ user: item.send, say: item.mes.startsWith("#") ? '' : item.mes, share: item.mes.startsWith("#") ? JSON.parse(item.mes.slice(1)) : '', time: item.time })
            }
            else {
              this.messages.push({ partner: item.send, say: item.mes.startsWith("#") ? '' : item.mes, share: item.mes.startsWith("#") ? JSON.parse(item.mes.slice(1)) : '', time: item.time })
            }
          })
          this.$nextTick(function () {
            this.scrollToBottom();
          })
        })
      }
    }
  }
}
</script>
