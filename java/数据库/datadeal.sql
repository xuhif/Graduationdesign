/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : datadeal

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-04-06 16:28:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for classify
-- ----------------------------
DROP TABLE IF EXISTS `classify`;
CREATE TABLE `classify` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `HoeffdingTree` varchar(255) DEFAULT NULL,
  `DecisionStump` varchar(255) DEFAULT NULL,
  `J48` varchar(255) DEFAULT NULL,
  `LMT` varchar(255) DEFAULT NULL,
  `RandomForest` varchar(255) DEFAULT NULL,
  `RandomTree` varchar(255) DEFAULT NULL,
  `REPTree` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for dataurl
-- ----------------------------
DROP TABLE IF EXISTS `dataurl`;
CREATE TABLE `dataurl` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `urlname` varchar(255) NOT NULL,
  `urlpath` varchar(255) NOT NULL,
  `utime` varchar(255) NOT NULL,
  `utype` varchar(255) NOT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM AUTO_INCREMENT=161 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for menus
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `mname` varchar(255) DEFAULT NULL,
  `mpid` int(11) NOT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for selectattr
-- ----------------------------
DROP TABLE IF EXISTS `selectattr`;
CREATE TABLE `selectattr` (
  `sid` int(5) NOT NULL AUTO_INCREMENT,
  `uid` int(5) DEFAULT NULL,
  `CorrelationAttributeEval` varchar(255) DEFAULT NULL,
  `GreedyStepwise` varchar(255) DEFAULT NULL,
  `GainRatioAttributeEval` varchar(255) DEFAULT NULL,
  `InfoGainAttributeEval` varchar(255) DEFAULT NULL,
  `OneRAttributeEval` varchar(255) DEFAULT NULL,
  `PrincpailComPonents` varchar(255) DEFAULT NULL,
  `ReliefFAttributeEval` varchar(255) DEFAULT NULL,
  `SymmetricalUncertAttributeEval` varchar(255) DEFAULT NULL,
  `WrapperSubsetEval` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `userid` int(5) NOT NULL AUTO_INCREMENT,
  `usernumber` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `type` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
