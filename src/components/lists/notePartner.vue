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
      <el-dialog
        title=""
        :visible.sync="dialogVisible2"
        width="30%"
      >
        <el-select
          v-model="qunMember"
          placeholder="添加群成员"
          multiple="multiple"
        >
          <el-option
            v-for="item in partners"
            :key="item.account"
            :label="item.name"
            :value="item.account"
            :disabled="(partnerAndcrowds[ind].account.split(';')).indexOf(item.account)>=0"
          >
          </el-option>
        </el-select>
        <span
          slot="footer"
          class="dialog-footer"
        >
          <el-button @click="dialogVisible2 = false">取 消</el-button>
          <el-button
            type="primary"
            @click="confirmAddMember()"
          >确 定</el-button>
        </span>
      </el-dialog>

      <el-dialog
        title=""
        :visible.sync="dialogVisible3"
        width="30%"
      >
        <el-select
          v-model="qunMember"
          placeholder="移除群成员"
          multiple="multiple"
        >
          <el-option
            v-for="item in partners"
            :key="item.account"
            :label="item.name"
            :value="item.account"
            :disabled="(partnerAndcrowds[ind].account.split(';')).indexOf(item.account)<0"
          >
          </el-option>
        </el-select>
        <span
          slot="footer"
          class="dialog-footer"
        >
          <el-button @click="dialogVisible3 = false">取 消</el-button>
          <el-button
            type="primary"
            @click="confirmRemoveMember()"
          >确 定</el-button>
        </span>
      </el-dialog>

      <div class="send-message-title">
        <span v-if="partnerAndcrowds[ind]">{{partnerAndcrowds[ind].name+'('+partnerAndcrowds[ind].account+')'}}
          <span
            class="addMember"
            @click="addMember"
            v-if="partnerAndcrowds[ind].account.split(';').length>1"
          >
            <i class="el-icon-circle-plus"></i>
          </span>

          <span
            class="removeMember"
            @click="removeMember"
            v-if="partnerAndcrowds[ind].account.split(';').length>1"
          >
            <i class="el-icon-remove"></i>
          </span>

        </span>
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
            @mousedown.right="showMenu1(item,index)"
            @click="openFileDialog(item.share)"
          >
            <div
              class="actionFile"
              ref="fileAction"
              v-document-click="documentClick"
              v-if="index==activeIndex"
            >
              <ul>
                <li @click="openFileDialog(item.share)">保存到桌面</li>
              </ul>
            </div>
            <span class="file-name"> {{item.share.name}}</span>
            <i class="iconfont icon-wenjian1"></i>
          </div>

          <el-dialog
            :visible.sync="viewFileMask"
            class="add-file-dialog"
          >
            <div class="folder-box">
              <div class="fold-input">
                <span>笔记名称：</span>
                <el-input v-model="fileName"></el-input>
              </div>
              <div class="select-fold">
                <span>笔记本：</span>
                <el-select
                  v-model="fileFolderName"
                  clearable
                  placeholder="请选择笔记本"
                >
                  <el-option
                    v-for="item in folders"
                    :key="item"
                    :label="item"
                    :value="item"
                  ></el-option>
                </el-select>
              </div>
              <div class="fold-btn">
                <el-button
                  type="primary"
                  @click="addFile(item.share)"
                  class="addFolder-btn"
                >确定</el-button>
                <el-button @click="cancelAddfile">取消</el-button>
              </div>
            </div>
          </el-dialog>

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
        <span>笔记记录</span>
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
          <div class="share">
            <!-- @mousedown.right="showMenu2(item,index)" -->
            <div
              class="actionFile"
              v-document-click="documentClick"
              v-if="index==activeIndex2"
            >
              <ul>
                <li>保存到桌面</li>
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
      dialogVisible2: false,
      dialogVisible3: false,
      viewFileMask: false,
      folders: [],
      files: [],
      fileFolderName: '',
      fileName: '',
      time: '',
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
      messPerson: [],       // 对比新旧消息的数组---新消息的发送者
      preMessPerson: [],    // 旧消息的发送者
    }
  },
  computed: {
    partnerAndcrowds() {
      return this.partners.concat(this.crowds)
    }
  },
  watch: {
    partnerAndcrowds() {
    }
  },
  beforeDestroy() {
    // 卸载定时器
    clearInterval(this.timer);
    let that = this;
    // 离开之前更新一下这个，下次回来可以继续显示新消息
    that.getAllMessagePers().then(function (resolve, reject) {
      api.saveMessageLen(JSON.stringify({ username: localStorage.username, preMessageLen: that.messPerson.length })).then();
    })
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

    that.getAllMessagePers().then(function (resolve, reject) {      // mount的时候，是让新旧消息相等，后面有新消息才有提示
      api.getMessageLen(JSON.stringify({ username: localStorage.username })).then((res) => {
        if (res.data.reason == 'OK') {
          for (var i = 0; i < res.data.data.preMessageLen; i++) {
            that.preMessPerson[i] = i;
          }
        }
        that.findNewMessPers();
      });
    })
    that.rollPoling();

    document.onkeydown = function (event) {
      var e = event || window.event || arguments.callee.caller.arguments[0];
      if (e && e.keyCode == 13) {
        e.preventDefault();
        that.sendMessage()
      }
    };
  },

  methods: {
    cancelAddfile() {
      this.toggleFileMask();
      this.fileName = "";
      this.fileFolderName = "";
      this.time = "";
    },
    getFolders() {
      let params = JSON.stringify({ username: localStorage.username });
      return api.getFolders(params).then(res => {
        let data = res.data.data.map(el => el.name);
        this.folders = data;
      });
    },
    openFileDialog(item) {
      this.viewFileMask = true;
      let that = this;
      new Promise(function (resolve, reject) {
        that.getFolders().then(resolve);
      })
        .then(function (resolve, reject) {
          that.getFiles()
          that.fileName = item.name;
        })
    },
    addFile(item) {
      if (this.fileName != "") {
        this.getTime();
        if (!this.fileFolderName) {
          this.$message({
            showClose: true,
            message: "请选择笔记本",
            type: "error"
          });
          return;
        }
        let file = this.files;
        for (let i = 0; i < file.length; i++) {
          if (file[i].name == this.fileName && file[i].folder == this.fileFolderName) {
            this.$message({
              showClose: true,
              message: "该文件夹已有相同的文本名称，请修改名称",
              type: "error"
            });
            return
          }
        }
        let params = JSON.stringify({ username: localStorage.username, name: this.fileName, folder: this.fileFolderName, content: item.content, time: this.time });
        api.addFile(params).then(res => {
          this.getFiles();
        })
        this.toggleFileMask();
        this.fileName = "";
        this.fileFolderName = "";
        this.time = "";
        this.$router.push({ name: "notes" });
      }
    },
    getTime() {
      let myDate = new Date();
      let [y, m, d, h, f, s] = [
        myDate.getFullYear(),
        myDate.getMonth() + 1,
        myDate.getDate(),
        myDate.getHours(),
        myDate.getMinutes(),
        myDate.getSeconds()
      ];
      m = m >= 10 ? m : "0" + m;
      d = d >= 10 ? d : "0" + d;
      h = h >= 10 ? h : "0" + h;
      f = f >= 10 ? f : "0" + f;
      s = s >= 10 ? s : "0" + s;
      this.time = y + "/" + m + "/" + d + " " + h + ":" + f + ":" + s;
    },
    addMember() {
      if (localStorage.username == (this.partnerAndcrowds[this.ind].account.split(';'))[0]) {
        this.dialogVisible2 = true;
      }
      else {
        this.$message({
          type: 'warning',
          message: '您不是群主不能修改群成员!',
          duration: 2000
        });
      }
    },
    removeMember() {
      if (localStorage.username == (this.partnerAndcrowds[this.ind].account.split(';'))[0]) {
        this.dialogVisible3 = true;
      }
      else {
        this.$message({
          type: 'warning',
          message: '您不是群主不能修改群成员!',
          duration: 2000
        });
      }
    },
    confirmAddMember() {
      this.dialogVisible2 = false;
      let menbs = (this.partnerAndcrowds[this.ind].account.split(';'));
      menbs.shift();
      this.qunMember = menbs.concat(this.qunMember);
      this.qunName = this.partnerAndcrowds[this.ind].name;
      this.createCrowd();
    },
    confirmRemoveMember() {
      this.dialogVisible3 = false;
      let menbs = (this.partnerAndcrowds[this.ind].account.split(';'));
      menbs.shift();
      this.qunMember.forEach((item, index) => {
        if (menbs.indexOf(item) >= 0) {
          menbs.splice(menbs.indexOf(item), menbs.indexOf(item) + 1);
        }
      })
      this.qunMember = menbs;
      this.qunName = this.partnerAndcrowds[this.ind].name;
      this.createCrowd();
    },
    rollPoling() {    // 轮询访问数据库
      let that = this;
      that.timer = setInterval(() => {
        new Promise((resolve, reject) => {
          that.getAllMessagePers().then(resolve);
        })
          .then((resolve, reject) => {
            that.findNewMessPers();
          })
      }, 6000)

    },
    findNewMessPers() {
      if (this.messPerson.length >= this.preMessPerson.length) {
        let newMesPers = this.messPerson.slice(this.preMessPerson.length);
        let nowPartnerHasNew = false;
        newMesPers.forEach((itemPers, indexMes) => {
          this.partnerAndcrowds.forEach((item, index) => {
            if (item.name == itemPers || item.account == itemPers) {   // 群名或者好友账号跟多出来的消息返回的名字相同
              if (this.ind == index) {                                 // 若当前ind指向的好友有新消息，标记一下
                nowPartnerHasNew = true;
              }
              else {
                this.partnerAndcrowds[index].hasNew = true;            // 点击的时候再把新消息去掉
              }
            }
          })
        })
        if (nowPartnerHasNew) {                                        // 当前ind指向的好友有新消息，不显示新消息提示，但消息列表刷新
          this.getMessage()
        }
        this.preMessPerson = [];
        this.preMessPerson = this.messPerson;
      }
    },
    getAllMessagePers() {
      // 发起请求获取全部的好友/或者群 --- 就是每一条消息，只要是发给username的，都把好友/群返回保存进数组
      let that = this;
      let params = JSON.stringify({ username: localStorage.username });
      return api.getAllMessage(params).then(res => {
        if (res.data.reason == 'OK') {
          this.messPerson = res.data.data.data;
          if (res.data.data.hasNewFriOrCrowd == 1) {
            this.$message({
              showClose: true,
              message: "有新好友/群添加,已刷新列表",
              type: "success"
            });
            new Promise(function (resolve, reject) {
              that.getFriend().then(resolve);
            })
              .then(function (resolve, reject) {
                that.getCrowd().then(resolve);
              })
              .then(function (resolve, reject) {
                that.getMessage().then(resolve);
              });
          }
        }
      })
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
      this.partnerAndcrowds[this.ind].hasNew = false;
      this.datePicker = '';
      this.getMessage();
    },
    selectDate() {
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
    getFiles() {
      let params = JSON.stringify({ username: localStorage.username });
      api.getFiles(params).then(res => {
        this.files = res.data.data;
      });
    },
    toggleFileMask() {
      this.viewFileMask = !this.viewFileMask;
    },
    createCrowd() {
      if (this.qunName == '') {
        this.$message({
          type: 'warning',
          message: '群名不能为空!',
          duration: 2000
        });
        return;
      }
      else if (this.qunMember.length < 1) {
        this.$message({
          type: 'warning',
          message: '请至少添加一位群成员!',
          duration: 1000
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
            this.partners.push({ account: item.username, name: item.name, hasNew: false })
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
      if (this.$refs.messageText.value == '') {
        this.$message({
          type: 'warning',
          message: '不能发送空消息!'
        });
        return;
      }
      else {
        api.sendMessage(editMessage).then(res => {
          if (res.data.reason == 'OK') {
            this.getMessage();
          }
        });
        this.$refs.messageText.value = ''
        this.$nextTick(function () {
          this.scrollToBottom();
        })
      }
    },
    getMessage() {
      let recP = this.partnerAndcrowds[this.ind];
      let params = JSON.stringify({ sendPerson: localStorage.username, recPerson: (recP.account && recP.account.split(';').length > 1) ? recP.name : recP.account }); // 个人
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
