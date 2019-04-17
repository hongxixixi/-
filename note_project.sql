/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : note_project

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65111

Date: 2019-04-16 17:13:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for crowd_table
-- ----------------------------
DROP TABLE IF EXISTS `crowd_table`;
CREATE TABLE `crowd_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) DEFAULT NULL,
  `people` varchar(20000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crowd_table
-- ----------------------------
INSERT INTO `crowd_table` VALUES ('006', '群聊1', '111;222');
INSERT INTO `crowd_table` VALUES ('007', '群聊2', '111;222；333');
INSERT INTO `crowd_table` VALUES ('008', '群聊3', '111;222;444');
INSERT INTO `crowd_table` VALUES ('009', '毕设讨论群', '222;444');
INSERT INTO `crowd_table` VALUES ('010', '笔记分享群', '222;444;111;333;555');

-- ----------------------------
-- Table structure for files_table
-- ----------------------------
DROP TABLE IF EXISTS `files_table`;
CREATE TABLE `files_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) CHARACTER SET utf8 NOT NULL,
  `name` varchar(40) CHARACTER SET utf8 NOT NULL,
  `folder` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `content` varchar(5000) CHARACTER SET utf8 DEFAULT NULL,
  `time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of files_table
-- ----------------------------
INSERT INTO `files_table` VALUES ('1', '111', '笔记1', '文件夹1', '111的文件夹1的笔记1的内容', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('2', '222', '笔记2', '文件夹3', '222的文件夹3里面的笔记2的内容', '2019/04/14  13:23:18');
INSERT INTO `files_table` VALUES ('3', '333', '关于毕设的笔记', '文件夹4', '关于毕设的笔记', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('4', '444', '上课笔记', '', '<p>大大&nbsp;&nbsp;</p>', '2019/04/14  13:23:18');
INSERT INTO `files_table` VALUES ('5', '555', '随笔笔记', '', '', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('6', '111', 'web笔记', '', '<p>我是你好</p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('7', '111', '记录', '', '<ol><li>对于我来书，你也许是最该的的&nbsp;</li><li>对于我来书，你也许是最该的的对于我来书，你也许是最该的的</li><li>对于我来书，你也许是最该的的</li><li>对于我来书，你也许是最该的的</li><li>对于我来书，你也许是最该的的对于我来书，你也许是最该的的</li><li>对于我来书，你也许是最该的的&nbsp;</li></ol>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('8', '222', '论文注意', '', '<table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\"><tbody><tr><th>&nbsp;1</th><th>&nbsp;2</th><th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th></tr><tr><td>&nbsp;2</td><td>&nbsp;3</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;3</td><td>&nbsp;3</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;4</td><td>&nbsp;4</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;5</td><td>&nbsp;4</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></tbody></table><p><br></p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('9', '333', '课堂笔记', '', '<p>阿萨&nbsp;</p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('10', '444', '4月15笔记', '', '', '2019/04/18  13:23:18');
INSERT INTO `files_table` VALUES ('11', '555', '用户555的笔记', '', '<p>sf&nbsp; &nbsp;f</p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('12', '111', '用户111的笔记', '', '<p>sdasa&nbsp;&nbsp;</p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('13', '222', '用户222的笔记', '', '<p>阿萨&nbsp;&nbsp;</p>', '2019/04/16 16:43:18');
INSERT INTO `files_table` VALUES ('14', '222', '笔记3', '', '', '2019/04/16 16:44:27');

-- ----------------------------
-- Table structure for folders_table
-- ----------------------------
DROP TABLE IF EXISTS `folders_table`;
CREATE TABLE `folders_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of folders_table
-- ----------------------------
INSERT INTO `folders_table` VALUES ('1', '111', '文件夹1');
INSERT INTO `folders_table` VALUES ('2', '111', '文件夹2');
INSERT INTO `folders_table` VALUES ('1', '111', '文件夹3');
INSERT INTO `folders_table` VALUES ('2', '111', '文件夹4');
INSERT INTO `folders_table` VALUES ('3', '222', '文件夹3');
INSERT INTO `folders_table` VALUES ('4', '333', '文件夹4');

-- ----------------------------
-- Table structure for message_table
-- ----------------------------
DROP TABLE IF EXISTS `message_table`;
CREATE TABLE `message_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sendPerson` varchar(40) DEFAULT NULL,
  `recPerson` varchar(40) DEFAULT NULL,
  `message` varchar(20000) DEFAULT NULL,
  `time` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_table
-- ----------------------------
INSERT INTO `message_table` VALUES ('1', '111', '222', '我是111', '2019/03/14  13:23:18');
INSERT INTO `message_table` VALUES ('2', '111', '333', 'zezezswe', '2019/04/12  13:12:18');
INSERT INTO `message_table` VALUES ('3', '222', '111', '我是222', '2019/04/13  13:23:18');
INSERT INTO `message_table` VALUES ('4', '111', '006', '111发给群qunming', '2019/04/14  13:23:50');
INSERT INTO `message_table` VALUES ('5', '111', '222', '111发给222的一条消息', '2019/04/14  13:33:18');
INSERT INTO `message_table` VALUES ('6', '222', '111', '222发给肖', '2019/04/14  13:34:18');
INSERT INTO `message_table` VALUES ('16', '222', '111', '222to111', '2019/04/14  13:44:18');
INSERT INTO `message_table` VALUES ('17', '111', '222', '#{\"folder\":\"\",\"name\":\"笔记之一\",\"time\":\"2019-4-11 20:59:1\",\"content\":\"<p>我是你好</p>\"}', '2019/04/15  13:10:18');
INSERT INTO `message_table` VALUES ('18', '222', '111', '#{\"folder\":\"\",\"name\":\"笔记1\",\"time\":\"2019-4-11 20:56:16\",\"content\":\"\"}', '2019/04/15  13:38:40');
INSERT INTO `message_table` VALUES ('19', '111', '222', '现在几点钟', '2019/04/15  13:49:09');
INSERT INTO `message_table` VALUES ('20', '111', '222', '笔记写好了吗', '2019/04/15  13:49:15');
INSERT INTO `message_table` VALUES ('21', '111', '222', '没', '2019/04/15  13:49:20');
INSERT INTO `message_table` VALUES ('22', '222', '111', '#{\"name\":\"分享的一个笔记\",\"folder\":\"ww\",\"content\":\"\",\"time\":\"2019-04-16 16:20:11\"}', '2019/04/16  16:20:22');
INSERT INTO `message_table` VALUES ('23', '222', '333', '#{\"name\":\"分享笔记\",\"folder\":\"ww\",\"content\":\"<p>大沙发啊啊啊啊&nbsp;</p>\",\"time\":\"2019-04-16 16:22:21\"}', '2019/04/16  16:22:34');
INSERT INTO `message_table` VALUES ('24', '222', '111', '我发送了一个邮件给你', '2019/04/16  17:10:28');
INSERT INTO `message_table` VALUES ('25', '111', '222', '收到', '2019/04/16  17:10:51');

-- ----------------------------
-- Table structure for user_table
-- ----------------------------
DROP TABLE IF EXISTS `user_table`;
CREATE TABLE `user_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `fname` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_table
-- ----------------------------
INSERT INTO `user_table` VALUES ('1', '111', '111', '小张', '222;333;444;555');
INSERT INTO `user_table` VALUES ('2', '222', '222', '小明', '111;444;555');
INSERT INTO `user_table` VALUES ('3', '333', '333', '小李', '111;444;');
INSERT INTO `user_table` VALUES ('4', '444', '444', '小肖', '111;222;333;');
INSERT INTO `user_table` VALUES ('5', '555', '555', '小陈', '111;222');
