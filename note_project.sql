/*
Navicat MySQL Data Transfer

Source Server         : mysql2
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : note_project

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2019-03-05 18:31:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for user_table
-- ----------------------------
DROP TABLE IF EXISTS `user_table`;
CREATE TABLE `user_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_table
-- ----------------------------
INSERT INTO `user_table` VALUES ('1', '2262', '2666', null);
INSERT INTO `user_table` VALUES ('2', '2634262', '2666', 0x3232333132);
INSERT INTO `user_table` VALUES ('3', '26342676572', '2666', 0x3232333132);
INSERT INTO `user_table` VALUES ('4', '11', '11', 0x3131);
INSERT INTO `user_table` VALUES ('5', 'xiao', '22', 0x7869616F);
INSERT INTO `user_table` VALUES ('6', '111111', '11', 0x3131);
