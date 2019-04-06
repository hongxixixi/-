<template>
  <div class="note-partner">
    <div class="my-partner">
      <!-- 这里需要一个获取好友列表的接口，传参:用户账号,获取到的数据格式是好友昵称及账号 -->
      <div class="partner-title">好友及群聊<i
          class="el-icon-plus"
          @click="dialogVisible = true"
        ></i></div>
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
            :before-close="handleClose"
          >
            输入账号：
            <input type="text">
            <span
              slot="footer"
              class="dialog-footer"
            >
              <el-button @click="dialogVisible = false">取 消</el-button>
              <el-button
                type="primary"
                @click="dialogVisible = false"
              >确 定</el-button>
            </span>
          </el-dialog>
        </div>
      </div>
    </div>
    <div class="send-message">
      <div class="send-message-title">小张(2132565323)</div>
      <div class='show-message'>
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
              timeNow.getHours() + ':' + timeNow.getMinutes() + ':' + timeNow.getSeconds()
              }}</span></div>
          <div class="say"><span>{{item.say}}</span></div>
        </div>
      </div>
      <div class="edit-message">
        <div class="edit-content">
          <textarea
            class="text-area"
            ref='message'
          ></textarea>
          <button
            class="send-buton"
            @click="sendMessage"
          >发送</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
// import moment from './moment'
export default {
  data() {
    return {
      dialogVisible: false,
      timeNow: new Date(),
      ind: 0,//选中的用户index
      partners: [
        { name: '小张', account: '2132565323' },
        { name: '小敏一', account: '2132323' },
        { name: '群聊1', account: '' },
        { name: '群聊名字比较长', account: '' },
        { name: '小芳', account: '2132323' },
        { name: '小明', account: '2132323' },
        { name: '小李', account: '2132323' },
        { name: '小敏', account: '2132323' },
        { name: '群聊2', account: '' },
        { name: '小芳', account: '2132323' },
        { name: '小明', account: '2132323' },
        { name: '小李', account: '2132323' },
        { name: '小敏', account: '2132323' },
        { name: '小俊', account: '2132323' },
        { name: '小芳', account: '2132323' },
        { name: '小明', account: '2132323' },
        { name: '小李', account: '2132323' },
        { name: '小敏', account: '2132323' },
        { name: '小俊', account: '2132323' },
        { name: '小芳', account: '2132323' },
        { name: '小明', account: '2132323' },
      ],
      messages: [
        { user: '往后', say: '早上好，努力做毕设', time: '2019 / 4 / 6 12: 16 ' },
        { partner: '小张(2132565323)', say: '其他好友说的话其他好友说的话', time: '2019 / 4 / 6 12: 18 ' },
        { partner: '小张(2132565323)', say: '111', share: '文件夹或者文件夹名称', time: ' 2019 / 4 / 6 12: 22' },    //分享了文件或者文件夹
        { user: '往后', say: '用户自己说的话', time: '2019 / 4 / 6 13: 11' },
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
      ]
    }
  },
  methods: {
    changePartnerIndex(index) {
      this.ind = index;
    },
    sendMessage() {
      let thisMessage = { user: '往后', say: '早上好，努力做毕设', time: '2019 / 4 / 6 12: 16 ' };
      thisMessage.say = this.$refs.message.value
      this.messages.push(thisMessage)
      this.$refs.message.value = ''
    },
    handleClose(done) {
      this.$confirm('确认关闭？')
        .then(_ => {
          done();
        })
        .catch(_ => { });
    }
  }
}
</script>
