/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : note_project

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

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
INSERT INTO `crowd_table` VALUES ('111', 'qunming', 'xiao;2233');
INSERT INTO `crowd_table` VALUES ('112', '12321', '223333');
INSERT INTO `crowd_table` VALUES ('113', 'ze', 'xiao');
INSERT INTO `crowd_table` VALUES ('114', '888', 'xiao;2262;222');
INSERT INTO `crowd_table` VALUES ('115', '333', 'xiao;2262');

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
INSERT INTO `files_table` VALUES ('1', 'aaa', 'aaa', 'aaa', 'aaa', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('2', '22', '笔记1', '文件夹1', '啊啊啊啊1', '2019/04/14  13:23:18');
INSERT INTO `files_table` VALUES ('215', '88', '77', '', '', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('255', '222', '111', '', '<p>大大&nbsp;&nbsp;</p>', '2019/04/14  13:23:18');
INSERT INTO `files_table` VALUES ('256', '222', '大大大', '', '', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('257', '222', '你好', '', '<p>我是你好</p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('258', 'xiao', '你好', '', '<ol><li>对于我来书，你也许是最该的的&nbsp;</li><li>对于我来书，你也许是最该的的对于我来书，你也许是最该的的</li><li>对于我来书，你也许是最该的的</li><li>对于我来书，你也许是最该的的</li><li>对于我来书，你也许是最该的的对于我来书，你也许是最该的的</li><li>对于我来书，你也许是最该的的&nbsp;</li></ol>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('259', 'xiao', '大大大', '', '<table border=\"0\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\"><tbody><tr><th>&nbsp;1</th><th>&nbsp;2</th><th>&nbsp;</th><th>&nbsp;</th><th>&nbsp;</th></tr><tr><td>&nbsp;2</td><td>&nbsp;3</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;3</td><td>&nbsp;3</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;4</td><td>&nbsp;4</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;5</td><td>&nbsp;4</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></tbody></table><p><br></p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('260', 'xiao', '是是是', '我问问', '<p>阿萨&nbsp;</p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('261', 'xiao', '777', '', '', '2019/04/18  13:23:18');
INSERT INTO `files_table` VALUES ('262', 'xiao', '也一样', '', '<p>sf&nbsp; &nbsp;f</p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('263', 'xiao', '5555', '我问问', '<p>sdasa&nbsp;&nbsp;</p>', '2019/04/15  13:23:18');
INSERT INTO `files_table` VALUES ('264', 'xiao', 'www', 'ee', '<p>阿萨&nbsp;&nbsp;</p>', '2019/04/16 16:43:18');
INSERT INTO `files_table` VALUES ('265', 'xiao', '666', '我问问', '', '2019/04/16 16:44:27');

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
INSERT INTO `folders_table` VALUES ('1', '2222', '2222');
INSERT INTO `folders_table` VALUES ('83', '222', 'ww');
INSERT INTO `folders_table` VALUES ('84', 'xiao', '我问问');
INSERT INTO `folders_table` VALUES ('85', 'xiao', 'ee');

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
INSERT INTO `message_table` VALUES ('1', 'xiao', '222', '我是xiao', '2019/03/14  13:23:18');
INSERT INTO `message_table` VALUES ('2', 'xiao', '666', 'zezezswe', '2019/04/12  13:12:18');
INSERT INTO `message_table` VALUES ('3', '222', 'xiao', '我是222', '2019/04/13  13:23:18');
INSERT INTO `message_table` VALUES ('4', 'xiao', 'qunming', 'xiao发给群qunming', '2019/04/14  13:23:50');
INSERT INTO `message_table` VALUES ('5', 'xiao', '222', 'xiao发给222的一条消息', '2019/04/14  13:33:18');
INSERT INTO `message_table` VALUES ('6', '222', 'xiao', '222发给肖', '2019/04/14  13:34:18');
INSERT INTO `message_table` VALUES ('16', '222', '5555555', '222toxiao', '2019/04/14  13:44:18');
INSERT INTO `message_table` VALUES ('17', 'xiao', '222', '#{\"folder\":\"\",\"name\":\"你好\",\"time\":\"2019-4-11 20:59:1\",\"content\":\"<p>我是你好</p>\"}', '2019/04/15  13:10:18');
INSERT INTO `message_table` VALUES ('18', '222', 'xiao', '#{\"folder\":\"\",\"name\":\"大大大\",\"time\":\"2019-4-11 20:56:16\",\"content\":\"\"}', '2019/04/15  13:38:40');
INSERT INTO `message_table` VALUES ('19', 'xiao', '222', '问问', '2019/04/15  13:49:09');
INSERT INTO `message_table` VALUES ('20', 'xiao', '222', '六六六', '2019/04/15  13:49:15');
INSERT INTO `message_table` VALUES ('21', 'xiao', '222', '么', '2019/04/15  13:49:20');
INSERT INTO `message_table` VALUES ('22', '222', 'xiao', '#{\"name\":\"444\",\"folder\":\"ww\",\"content\":\"\",\"time\":\"2019-04-16 16:20:11\"}', '2019/04/16  16:20:22');
INSERT INTO `message_table` VALUES ('23', '222', '888', '#{\"name\":\"444\",\"folder\":\"ww\",\"content\":\"<p>大沙发啊啊啊啊&nbsp;</p>\",\"time\":\"2019-04-16 16:22:21\"}', '2019/04/16  16:22:34');
INSERT INTO `message_table` VALUES ('24', '222', 'xiao', '我发送了一个邮件给你', '2019/04/16  17:10:28');
INSERT INTO `message_table` VALUES ('25', 'xiao', '222', '收到', '2019/04/16  17:10:51');

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
INSERT INTO `user_table` VALUES ('1', '2262', '2666', '699', 'xiao;');
INSERT INTO `user_table` VALUES ('2', '222', '222', '666', 'xiao;');
INSERT INTO `user_table` VALUES ('3', '26342676572', '2666', '2', '');
INSERT INTO `user_table` VALUES ('4', 'xiao', '22', 'xiao2', '2262;222;');
INSERT INTO `user_table` VALUES ('5', '88', '88', '88', null);
