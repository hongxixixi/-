/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : note_project

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2019-04-14 00:16:11
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
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crowd_table
-- ----------------------------
INSERT INTO `crowd_table` VALUES ('111', 'qunming', 'xiao;2233');
INSERT INTO `crowd_table` VALUES ('112', '12321', '223333');
INSERT INTO `crowd_table` VALUES ('113', 'ze', 'xiao;2622');

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
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of files_table
-- ----------------------------
INSERT INTO `files_table` VALUES ('1', 'aaa', 'aaa', 'aaa', 'aaa', '2019-4-6 21:36:42');
INSERT INTO `files_table` VALUES ('2', '22', '笔记1', '文件夹1', '啊啊啊啊1', '2019-4-6 21:36:42');
INSERT INTO `files_table` VALUES ('161', '222', '111', '', '<p>大大&nbsp;&nbsp;</p>', '2019-4-11 20:55:36');
INSERT INTO `files_table` VALUES ('162', '222', '大大大', '', '', '2019-4-11 20:56:16');
INSERT INTO `files_table` VALUES ('183', 'xiao', '我问问 ', '11', '<p>大把市场 等等&nbsp; 想嘻嘻嘻&nbsp; &nbsp;打啊&nbsp; 你是谁</p>', '2019-4-11 21:0:48');
INSERT INTO `files_table` VALUES ('184', 'xiao', '222', '', '<p>啊啊女v&nbsp;&nbsp;</p>', '2019-4-6 21:38:4');
INSERT INTO `files_table` VALUES ('185', 'xiao', '你好', '', '<p>我是你好</p>', '2019-4-11 20:59:1');
INSERT INTO `files_table` VALUES ('215', '88', '77', '', '', '2019-4-13 23:54:41');

-- ----------------------------
-- Table structure for folders_table
-- ----------------------------
DROP TABLE IF EXISTS `folders_table`;
CREATE TABLE `folders_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of folders_table
-- ----------------------------
INSERT INTO `folders_table` VALUES ('1', '2222', '2222');
INSERT INTO `folders_table` VALUES ('60', '222', 'ww');
INSERT INTO `folders_table` VALUES ('71', 'xiao', '11');
INSERT INTO `folders_table` VALUES ('72', 'xiao', '44');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_table
-- ----------------------------
INSERT INTO `message_table` VALUES ('1', 'xiao', '222', '我是xiao', '2018');
INSERT INTO `message_table` VALUES ('2', 'xiao', '666', 'zezezswe', '2018');
INSERT INTO `message_table` VALUES ('3', '222', 'xiao', '我是222', '2018');
INSERT INTO `message_table` VALUES ('4', 'xiao', 'qunming', 'xiao发给群qunming', '2018');
INSERT INTO `message_table` VALUES ('5', 'xiao', '222', 'xiao发给222的一条消息', '2019');
INSERT INTO `message_table` VALUES ('6', '222', 'xiao', '222发给肖', '2019');

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
INSERT INTO `user_table` VALUES ('1', '2262', '2666', '699', '');
INSERT INTO `user_table` VALUES ('2', '222', '222', '666', 'xiao;');
INSERT INTO `user_table` VALUES ('3', '26342676572', '2666', '2', '');
INSERT INTO `user_table` VALUES ('4', 'xiao', '22', 'xiao2', '222;');
INSERT INTO `user_table` VALUES ('5', '88', '88', '88', null);
