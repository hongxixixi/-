/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : note_project

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2019-04-05 14:54:32
*/

SET FOREIGN_KEY_CHECKS=0;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of files_table
-- ----------------------------
INSERT INTO `files_table` VALUES ('255', '222', '88', '88', '');
INSERT INTO `files_table` VALUES ('256', '222', '777', '88', '');
INSERT INTO `files_table` VALUES ('257', '222', '55', '', '');
INSERT INTO `files_table` VALUES ('320', '88', '999', '', '');
INSERT INTO `files_table` VALUES ('322', '22', '公司', '工作', '<p>今天组了什么，明天要做什么</p>');

-- ----------------------------
-- Table structure for folders_table
-- ----------------------------
DROP TABLE IF EXISTS `folders_table`;
CREATE TABLE `folders_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of folders_table
-- ----------------------------
INSERT INTO `folders_table` VALUES ('97', '222', '88');
INSERT INTO `folders_table` VALUES ('98', '222', '99');
INSERT INTO `folders_table` VALUES ('128', 'xiao', '99');
INSERT INTO `folders_table` VALUES ('132', '88', '88');
INSERT INTO `folders_table` VALUES ('133', '22', '工作');

-- ----------------------------
-- Table structure for user_table
-- ----------------------------
DROP TABLE IF EXISTS `user_table`;
CREATE TABLE `user_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_table
-- ----------------------------
INSERT INTO `user_table` VALUES ('1', '2262', '2666', '699');
INSERT INTO `user_table` VALUES ('2', '222', '222', '666');
INSERT INTO `user_table` VALUES ('3', '26342676572', '2666', '22');
INSERT INTO `user_table` VALUES ('4', 'xiao', '22', 'WWII');
INSERT INTO `user_table` VALUES ('5', '11', '11', '11');
INSERT INTO `user_table` VALUES ('6', '88', '88', '88');
INSERT INTO `user_table` VALUES ('7', '22', '22', '22');
