<template>
  <div class="note-partner">
    <div class="my-partner">
      <div class="partner-title"><span>好友及群聊</span>
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
          v-for="(item,index) in partners"
          :key="index"
          @click="changePartnerIndex(index)"
          :class="{'active':ind === index}"
        >
          <span>{{item.name}}</span>
          <span v-if="item.account">({{item.account}})</span>
          <i class="el-icon-arrow-right"></i>
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
              class="el-icon-error"
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
                :value="item.name"
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
                @click="addMember()"
              >确 定</el-button>
            </span>
          </el-dialog>

        </div>
      </div>
    </div>
    <div
      class="send-message"
      ref="sendBox"
    >
      <div class="send-message-title">
        <span v-if="partners[ind]">{{partners[ind].name+'('+partners[ind].account+')'}} </span>
        <span
          class="delete"
          @click="deleteFriend"
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
          ><span>{{item.user}}</span></div>
          <div
            v-else-if="item.partner"
            class="partnerName"
          ><span>{{item.partner}}</span></div>
          <!-- 这里的时间历史部分从后台获取，新的部分自己new Date -->
          <div class="time"><span>{{timeNow.getFullYear() + '/' + ('0' + (timeNow.getMonth() + 1)).slice(-2) + '/' + ('0' + timeNow.getDate()).slice(-2)+' '+
              timeNow.getHours() + ':' + timeNow.getMinutes() + ':' + ('0' + timeNow.getSeconds()).slice(-2)
              }}</span></div>
          <div
            class="say"
            v-if="item.say"
          ><span>{{item.say}}</span></div>
          <div
            class="share"
            v-if="item.share"
          >
            <span class="file-name"> {{item.share}}</span>
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
      <div
        class='show-flie-record'
        ref="showBox"
      >
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
          <div class="time"><span>{{timeNow.getFullYear() + '/' + ('0' + (timeNow.getMonth() + 1)).slice(-2) + '/' + ('0' + timeNow.getDate()).slice(-2)+' '+
              timeNow.getHours() + ':' + timeNow.getMinutes() + ':' + ('0' + timeNow.getSeconds()).slice(-2)
              }}</span></div>
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

export default {
  data() {
    return {
      dialogVisible: false,
      dialogVisible1: false,
      qunMember: '',
      qunName: '',
      partnersAccount: '',
      getNameSucc: true,
      timeNow: new Date(),
      ind: 0,//选中的用户index
      fileRecord: [
        { partner: '小张(2132565323)', share: '文件/文件夹名称', time: ' 2019 / 4 / 6 12: 22' },
        { user: '往后', share: '文件/文件夹名称', time: '2019 / 4 / 6 13: 11' },
      ],
      partners: [
        { name: '小张', account: '2132565323' },
        { name: '小敏一', account: '2132323' },
        { name: '群聊1', account: '2323' },
        { name: '群聊名字比较长', account: '111' },
        { name: '小芳', account: '134343' },
        { name: '小明', account: '12' },
        { name: '小李', account: '13' },
        { name: '小敏', account: '14' },
        { name: '群聊2', account: '5' },
        { name: '小芳', account: '16' },
        { name: '小明', account: '17' },
        { name: '小李', account: '18' },
        { name: '小敏', account: '19' },
        { name: '小俊', account: '10' },
        { name: '小芳', account: '1343434' },
        { name: '小明', account: '12322' },
        { name: '小李', account: '145454' },
        { name: '小敏', account: '1565' },
        { name: '小俊', account: '1677' },
        { name: '小芳', account: '17565' },
        { name: '小明', account: '12343' },
      ],
      messages: [
        { user: '往后', say: '早上好，努力做毕设', time: '2019 / 4 / 6 12: 16 ' },
        { partner: '小张(2132565323)', say: '其他好友说的话其他好友说的话', time: '2019 / 4 / 6 12: 18 ' },
        { partner: '小张(2132565323)', share: '文件/文件夹名称', time: ' 2019 / 4 / 6 12: 22' },    //分享了文件或者文件夹
        { user: '往后', share: '文件/文件夹名称', time: '2019 / 4 / 6 13: 11' },
        { user: '往后', say: '早上好，努力做毕设' },
        { partner: '小张(2132565323)', say: '其他好友说的话其他好友说的话' },
        { partner: '小张(2132565323)', say: '其他人其他好友说的话其他好友说的话' },
        { user: '往后', say: '用户自己说的话' },
        { partner: '小张(2132565323)', say: '还是其他人' },
        { partner: '小张(2132565323)', say: '还是其他' },
        { partner: '小张(2132565323)', say: '其他人' },
        { user: '往后', say: '用户自己说的话' },
        { partner: '小张(2132565323)', say: '还是其他人' },
        { partner: '小张(2132565323)', say: '还是其他' },
      ],
    }
  },
  mounted() {
    let that = this;
    that.getFriend();
    this.scrollToBottom();
    document.onkeydown = function (event) {
      var e = event || window.event || arguments.callee.caller.arguments[0];
      if (e && e.keyCode == 13) { // enter 键
        //要做的事情
        that.sendMessage()
      }
    };
  },
  methods: {
    getFriend() {
      let params = JSON.stringify({ username: localStorage.username });
      let that = this;
      api.getFriend(params).then(res => {
        if (res.data.reason == 'OK') {
          that.partners = [];
          let data = res.data.data;
          data.forEach((item, index) => {
            that.partners.push({ account: item.name, name: item.username })
          })
        }
      })
    },

    isGetName() {
      let params = JSON.stringify({ username: this.partnersAccount });
      api.isGetName(params).then(res => {
        console.log(res.data.data)
        if (res.data.data) {
          this.getNameSucc = true;
        }
        else {
          this.getNameSucc = false;
        }
      })
    },

    addFriend() {
      this.dialogVisible = false;
      let params = JSON.stringify({ username: localStorage.username, fname: this.partnersAccount });
      api.addFriend(params).then(res => {
        console.log(params, res);
      });
      this.partnersAccount = ''
      this.getFriend();
    },

    deleteFriend() {
      this.$confirm('此操作将删除该好友, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        let params = JSON.stringify({ username: localStorage.username, fname: this.partners[this.ind].account });
        api.deleteFriend(params).then(res => {
          console.log(res)
        })
        this.ind--;
        this.getFriend();
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

    addMember() {
      this.dialogVisible1 = false;
      this.partners.unshift({ name: this.qunName, account: this.qunMember.join(',') });
    },
    scrollToBottom() {
      let sendHeight = this.$refs.showBox.scrollHeight;
      this.$refs.showBox.scrollTo(0, sendHeight)
    },

    changePartnerIndex(index) {
      this.ind = index;
    },

    sendMessage() {
      let editMessage = { user: '往后', say: '早上好，努力做毕设', time: '2019 / 4 / 6 12: 16 ' };
      editMessage.say = this.$refs.messageText.value
      if (editMessage.say) {
        this.messages.push(editMessage)
        this.$refs.messageText.value = ''

        this.$nextTick(function () {
          this.scrollToBottom();
        })
      }

    },
  }
}
</script>
