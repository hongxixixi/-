/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : note_project

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2019-04-08 14:36:10
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
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of crowd_table
-- ----------------------------
INSERT INTO `crowd_table` VALUES ('111', 'qunming', 'xiao;2233');
INSERT INTO `crowd_table` VALUES ('112', '12321', '223333');
INSERT INTO `crowd_table` VALUES ('113', 'xiao', 'xiao;222');

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
  `time` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of files_table
-- ----------------------------
INSERT INTO `files_table` VALUES ('1', 'aaa', 'aaa', 'aaa', 'aaa', '2019-4-6 21:36:42');
INSERT INTO `files_table` VALUES ('2', '22', '笔记1', '文件夹1', '啊啊啊啊1', '2019-4-6 21:36:42');
INSERT INTO `files_table` VALUES ('86', 'xiao', '22', '', '<p>啊&nbsp; 的&nbsp;&nbsp;</p>', '2019-4-6 21:36:42');
INSERT INTO `files_table` VALUES ('87', 'xiao', '我问问 ', '11', '<p>大把市场 等等&nbsp; 想嘻嘻嘻&nbsp; &nbsp;</p>', '2019-4-6 21:37:46');
INSERT INTO `files_table` VALUES ('88', 'xiao', '666', '', '<p>啊啊女v&nbsp;&nbsp;</p>', '2019-4-6 21:38:4');

-- ----------------------------
-- Table structure for folders_table
-- ----------------------------
DROP TABLE IF EXISTS `folders_table`;
CREATE TABLE `folders_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of folders_table
-- ----------------------------
INSERT INTO `folders_table` VALUES ('1', '2222', '2222');
INSERT INTO `folders_table` VALUES ('33', 'xiao', '11');
INSERT INTO `folders_table` VALUES ('34', 'xiao', '44');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_table
-- ----------------------------
INSERT INTO `user_table` VALUES ('1', '2262', '2666', '699', '222;xiao;');
INSERT INTO `user_table` VALUES ('2', '222', '222', '666', '');
INSERT INTO `user_table` VALUES ('3', '26342676572', '2666', '2', null);
INSERT INTO `user_table` VALUES ('4', 'xiao', '22', 'xiao2', '');
