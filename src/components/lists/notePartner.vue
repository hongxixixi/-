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
            @mousedown.right="showMenu1(item,index)"
          >
            <div
              class="action"
              v-document-click="documentClick"
              v-if="index==activeIndex"
            >
              <ul>
                <li @click="openFile(item.share)">保存到桌面并打开</li>
              </ul>
            </div>
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
      <div class='show-file-title'>
        <span>文件分享记录</span>
      </div>
      <el-date-picker
        v-model="datePicker"
        type="date"
        placeholder="点击选择日期"
        @change="selectDate"
        value-format="yyyy/MM/dd"
        :picker-options="pickerOptions1"
      >
        >
      </el-date-picker>
      <div class='show-flie-record'>
        <div
          v-for="(item,index) in fileRecord"
          :key="index"
          :class="item.user?'user-style':'partner-style'"
          @dblclick="openFile(item.share)"
        >
          <div
            v-if="item.user"
            class="userName"
          ><span>{{item.user}}</span></div>
          <div
            v-else-if="item.partner"
            class="partnerName"
          ><span>{{item.partner}}</span></div>
          <div class="time"><span>{{item.time}}</span></div>
          <div
            class="share"
            @mousedown.right="showMenu2(item,index)"
          >
            <div
              class="action"
              v-document-click="documentClick"
              v-if="index==activeIndex2"
            >
              <ul>
                <li @click="openFile(item.share)">保存到桌面并打开</li>
              </ul>
            </div>
            <span class="file-name"> {{item.share.name}}</span>
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
      timer: '',
      datePicker: '',
      qunMember: [],
      qunName: '',
      partnersAccount: '',
      getNameSucc: true,
      timeNow: new Date(),
      activeIndex: -1,
      activeIndex2: -1,
      pickerOptions1: {
        disabledDate(time) {
          return time.getTime() > new Date();
        }
      },
      ind: 0,//选中的用户index
      fileRecord: [
        // { user: "222" , say: "早上好", share: { content: "<p>大大&nbsp;&nbsp;</p>", folder: "",name: "111",time: "2019-4-11 20:55:36"}, time: "2019/04/15  14:38:34"}
        // { partner: "222" ,say: "早上好", share: { content: "<p>大大&nbsp;&nbsp;</p>", folder: "",name: "111",time: "2019-4-11 20:55:36"}, time: "2019/04/15  14:38:34"}

      ],
      partners: [
        // { name: '小张', account: '3434;2132565323' },
        // { name: '小敏一', account: '3434;2132323' },
        // { name: '群聊1', account: '3434;2323' },
      ],
      crowds: [],
      messages: [
        // { user: "222", say: "早上好", share: "", time: "2019/04/15  14:38:34", user: "222"}
        // { partner: "222", say: "早上好", share: "", time: "2019/04/15  14:38:34"}
        // { user: "222" , say: "早上好", share: { content: "<p>大大&nbsp;&nbsp;</p>", folder: "",name: "111",time: "2019-4-11 20:55:36"}, time: "2019/04/15  14:38:34" }
      ],
      preAllMessages: [], //对比新旧消息的数组
      allMessages: [],
    }
  },
  computed: {
    partnerAndcrowds() {
      return this.partners.concat(this.crowds)
    }
  },
  beforeDestroy() {
    // 卸载定时器
    clearInterval(this.timer)
  },
  mounted() {
    let that = this;

    new Promise(function (resolve, reject) {
      that.getFriend().then(resolve);
    })
      .then(function (resolve, reject) {
        that.getCrowd().then(resolve);
      })
      .then(function (resolve, reject) {
        that.getMessage().then(resolve);
      });
    // that.rollPoling();
    document.onkeydown = function (event) {
      var e = event || window.event || arguments.callee.caller.arguments[0];
      if (e && e.keyCode == 13) {
        event.preventDefault();
        that.sendMessage()
      }
    };
  },

  methods: {
    rollPoling() {    // 轮询访问数据库
      let that = this;
      that.timer = setInterval(() => {
        that.getAllMessage().then(function (resolve, reject) {
          if (that.allMessages.length > that.preAllMessages.length) {
            let newMes = that.allMessages.slice(that.preAllMessages.length);
            console.log(newMes)
            let nowPartnerHasNew = false;
            newMes.forEach((itemMes, indexMes) => {
              that.partnerAndcrowds.forEach((item, index) => {
                if (item.name == itemMes.send || item.name == itemMes.sendPerson) {
                  if (that.ind == index) {                          // 若当前ind指向的好友有新消息，标记一下
                    nowPartnerHasNew = true;
                  }
                  else {
                    that.partnerAndcrowds[index].hasNew = true;     // 点击的时候再把新消息去掉
                  }
                }
              })
            })
            if (nowPartnerHasNew) {                                 // 当前ind指向的好友有新消息，不显示新消息提示，但消息列表刷新
              that.getMessage()
            }
            resolve();
          }
        })      }, 1000)

    },
    getAllMessage() {
      // 发起请求获取全部消息 --- 保存进allMessages
      // return promise对象
    },
    documentClick() {
      this.activeIndex = -1;
      this.activeIndex2 = -1;

    },
    showMenu1(item, index) {
      document.oncontextmenu = function (e) {
        e.preventDefault();
      };
      this.activeIndex = index;
    },
    showMenu2(item, index) {
      document.oncontextmenu = function (e) {
        e.preventDefault();
      };
      this.activeIndex2 = index;
    },
    scrollToBottom() {
      let sendHeight = this.$refs.showBox.scrollHeight;
      this.$refs.showBox.scrollTo(0, sendHeight)
    },

    changePartnerIndex(index) {
      this.ind = index;
      this.partnerAndcrowds[index].hasNew = false;
      this.datePicker = '';
      this.getMessage();
    },
    selectDate() {
      console.log(this.datePicker)
      if (this.datePicker == null) {                              // 不选择时间的时候全部显示
        this.messages.forEach((item, index) => {
          if (item.share != '' && item.user) {
            this.fileRecord.push({ user: item.user, share: item.share, time: item.time })
          }
          else if (item.share != '' && item.partner) {
            this.fileRecord.push({ partner: item.partner, share: item.share, time: item.time })
          }
        })
        return;
      }
      this.fileRecord = [];
      this.messages.forEach((item, index) => {                   // 把消息遍历一遍，如果是分享文件的而且日期对的上，就push进去
        if (item.time.slice(0, 10) == this.datePicker && item.share != '' && item.user) {
          this.fileRecord.push({ user: item.user, share: item.share, time: item.time })
        }
        else if (item.time.slice(0, 10) == this.datePicker && item.share != '' && item.partner) {
          this.fileRecord.push({ partner: item.partner, share: item.share, time: item.time })
        }
      })

    },
    openFile(item) {
      // 如果文件里面已经有这个内容，名字后面截图三位，如果是‘（num）’的格式，就把‘ （num+1） ’这个加在名字后面再保存
      let flag = true;
      this.$store.state.myfiles.forEach((itemFile, index) => {        //如果列表中已经保存过这个文件，则不弹出信息，且不添加文件
        if (itemFile.name == item.name) {
          flag = false;

        }
      })
      if (flag) {
        item.folder = '';
        this.$store.commit("addMyFiles", item);
        this.$message({
          type: 'success',
          message: '已保存到我的桌面!'
        });
      }
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
      if (this.partnersAccount == localStorage.username) {
        this.$message({
          type: 'warning',
          message: '不能添加自己为好友!'
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
      this.fileRecord = [];
      if (recP.account.split(';').length > 1) {         // 群 
        return api.getMessage(params).then(res => {
          res.data.data.forEach((item, index) => {
            if (item.sendPerson == localStorage.username) {
              this.messages.push({ user: item.sendPerson, say: item.message.startsWith("#") ? '' : item.message, share: item.message.startsWith("#") ? JSON.parse(item.message.slice(1)) : '', time: item.time })
              if (item.message.startsWith("#")) {
                this.fileRecord.push({ user: item.sendPerson, share: JSON.parse(item.message.slice(1)), time: item.time })
              }
            }
            else {
              this.messages.push({ partner: item.sendPerson, say: item.message.startsWith("#") ? '' : item.message, share: item.message.startsWith("#") ? JSON.parse(item.message.slice(1)) : '', time: item.time })
              if (item.message.startsWith("#")) {
                this.fileRecord.push({ partner: item.sendPerson, share: JSON.parse(item.message.slice(1)), time: item.time })
              }
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
              if (item.mes.startsWith("#")) {
                this.fileRecord.push({ user: item.send, share: JSON.parse(item.mes.slice(1)), time: item.time })
              }

            }
            else {
              this.messages.push({ partner: item.send, say: item.mes.startsWith("#") ? '' : item.mes, share: item.mes.startsWith("#") ? JSON.parse(item.mes.slice(1)) : '', time: item.time })
              if (item.mes.startsWith("#")) {
                this.fileRecord.push({ partner: item.send, share: JSON.parse(item.mes.slice(1)), time: item.time })
              }
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
