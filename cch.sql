/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : cch

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2016-12-26 15:12:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for batch_job_execution
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution`;
CREATE TABLE `batch_job_execution` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `CREATE_TIME` datetime NOT NULL,
  `START_TIME` datetime DEFAULT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  `JOB_CONFIGURATION_LOCATION` varchar(2500) DEFAULT NULL,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  KEY `JOB_INST_EXEC_FK` (`JOB_INSTANCE_ID`),
  CONSTRAINT `JOB_INST_EXEC_FK` FOREIGN KEY (`JOB_INSTANCE_ID`) REFERENCES `batch_job_instance` (`JOB_INSTANCE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_job_execution
-- ----------------------------
INSERT INTO `batch_job_execution` VALUES ('1', '2', '1', '2016-06-02 17:57:48', '2016-06-02 17:57:49', '2016-06-02 17:57:49', 'COMPLETED', 'COMPLETED', '', '2016-06-02 17:57:49', null);

-- ----------------------------
-- Table structure for batch_job_execution_context
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_context`;
CREATE TABLE `batch_job_execution_context` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_CTX_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_job_execution_context
-- ----------------------------
INSERT INTO `batch_job_execution_context` VALUES ('1', '{\"map\":[\"\"]}', null);

-- ----------------------------
-- Table structure for batch_job_execution_params
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_params`;
CREATE TABLE `batch_job_execution_params` (
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `TYPE_CD` varchar(6) NOT NULL,
  `KEY_NAME` varchar(100) NOT NULL,
  `STRING_VAL` varchar(250) DEFAULT NULL,
  `DATE_VAL` datetime DEFAULT NULL,
  `LONG_VAL` bigint(20) DEFAULT NULL,
  `DOUBLE_VAL` double DEFAULT NULL,
  `IDENTIFYING` char(1) NOT NULL,
  KEY `JOB_EXEC_PARAMS_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_PARAMS_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_job_execution_params
-- ----------------------------

-- ----------------------------
-- Table structure for batch_job_execution_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_execution_seq`;
CREATE TABLE `batch_job_execution_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_job_execution_seq
-- ----------------------------
INSERT INTO `batch_job_execution_seq` VALUES ('1', '0');

-- ----------------------------
-- Table structure for batch_job_instance
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_instance`;
CREATE TABLE `batch_job_instance` (
  `JOB_INSTANCE_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) DEFAULT NULL,
  `JOB_NAME` varchar(100) NOT NULL,
  `JOB_KEY` varchar(32) NOT NULL,
  PRIMARY KEY (`JOB_INSTANCE_ID`),
  UNIQUE KEY `JOB_INST_UN` (`JOB_NAME`,`JOB_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_job_instance
-- ----------------------------
INSERT INTO `batch_job_instance` VALUES ('1', '0', 'importUserJob', 'd41d8cd98f00b204e9800998ecf8427e');

-- ----------------------------
-- Table structure for batch_job_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_job_seq`;
CREATE TABLE `batch_job_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_job_seq
-- ----------------------------
INSERT INTO `batch_job_seq` VALUES ('1', '0');

-- ----------------------------
-- Table structure for batch_step_execution
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution`;
CREATE TABLE `batch_step_execution` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `VERSION` bigint(20) NOT NULL,
  `STEP_NAME` varchar(100) NOT NULL,
  `JOB_EXECUTION_ID` bigint(20) NOT NULL,
  `START_TIME` datetime NOT NULL,
  `END_TIME` datetime DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `COMMIT_COUNT` bigint(20) DEFAULT NULL,
  `READ_COUNT` bigint(20) DEFAULT NULL,
  `FILTER_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_COUNT` bigint(20) DEFAULT NULL,
  `READ_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `WRITE_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `PROCESS_SKIP_COUNT` bigint(20) DEFAULT NULL,
  `ROLLBACK_COUNT` bigint(20) DEFAULT NULL,
  `EXIT_CODE` varchar(2500) DEFAULT NULL,
  `EXIT_MESSAGE` varchar(2500) DEFAULT NULL,
  `LAST_UPDATED` datetime DEFAULT NULL,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  KEY `JOB_EXEC_STEP_FK` (`JOB_EXECUTION_ID`),
  CONSTRAINT `JOB_EXEC_STEP_FK` FOREIGN KEY (`JOB_EXECUTION_ID`) REFERENCES `batch_job_execution` (`JOB_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_step_execution
-- ----------------------------
INSERT INTO `batch_step_execution` VALUES ('1', '3', 'step1', '1', '2016-06-02 17:57:49', '2016-06-02 17:57:49', 'COMPLETED', '1', '0', '0', '0', '0', '0', '0', '0', 'COMPLETED', '', '2016-06-02 17:57:49');

-- ----------------------------
-- Table structure for batch_step_execution_context
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution_context`;
CREATE TABLE `batch_step_execution_context` (
  `STEP_EXECUTION_ID` bigint(20) NOT NULL,
  `SHORT_CONTEXT` varchar(2500) NOT NULL,
  `SERIALIZED_CONTEXT` text,
  PRIMARY KEY (`STEP_EXECUTION_ID`),
  CONSTRAINT `STEP_EXEC_CTX_FK` FOREIGN KEY (`STEP_EXECUTION_ID`) REFERENCES `batch_step_execution` (`STEP_EXECUTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_step_execution_context
-- ----------------------------
INSERT INTO `batch_step_execution_context` VALUES ('1', '{\"map\":[{\"entry\":[{\"string\":\"JdbcCursorItemReader.read.count\",\"int\":1},{\"string\":[\"batch.taskletType\",\"org.springframework.batch.core.step.item.ChunkOrientedTasklet\"]},{\"string\":[\"batch.stepType\",\"org.springframework.batch.core.step.tasklet.TaskletStep\"]}]}]}', null);

-- ----------------------------
-- Table structure for batch_step_execution_seq
-- ----------------------------
DROP TABLE IF EXISTS `batch_step_execution_seq`;
CREATE TABLE `batch_step_execution_seq` (
  `ID` bigint(20) NOT NULL,
  `UNIQUE_KEY` char(1) NOT NULL,
  UNIQUE KEY `UNIQUE_KEY_UN` (`UNIQUE_KEY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of batch_step_execution_seq
-- ----------------------------
INSERT INTO `batch_step_execution_seq` VALUES ('1', '0');

-- ----------------------------
-- Table structure for by_activity
-- ----------------------------
DROP TABLE IF EXISTS `by_activity`;
CREATE TABLE `by_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_time` timestamp NULL DEFAULT NULL,
  `enroll_begin_time` timestamp NULL DEFAULT NULL,
  `enroll_end_time` timestamp NULL DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  `mall_id` int(11) DEFAULT NULL,
  `cover_img` char(77) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `is_show_on_index` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mall_id` (`mall_id`) USING BTREE,
  KEY `content_id` (`content_id`) USING BTREE,
  CONSTRAINT `by_activity_ibfk_1` FOREIGN KEY (`mall_id`) REFERENCES `by_shopping_mall` (`id`),
  CONSTRAINT `by_activity_ibfk_2` FOREIGN KEY (`content_id`) REFERENCES `by_content` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_activity
-- ----------------------------

-- ----------------------------
-- Table structure for by_activity_member
-- ----------------------------
DROP TABLE IF EXISTS `by_activity_member`;
CREATE TABLE `by_activity_member` (
  `activity_id` int(11) NOT NULL DEFAULT '0',
  `member_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`activity_id`,`member_id`),
  KEY `member_id` (`member_id`) USING BTREE,
  CONSTRAINT `by_activity_member_ibfk_1` FOREIGN KEY (`activity_id`) REFERENCES `by_activity` (`id`),
  CONSTRAINT `by_activity_member_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_activity_member
-- ----------------------------

-- ----------------------------
-- Table structure for by_adv
-- ----------------------------
DROP TABLE IF EXISTS `by_adv`;
CREATE TABLE `by_adv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coverImg` char(77) DEFAULT NULL,
  `href` varchar(70) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `mall_id` int(11) DEFAULT NULL,
  `content_id` int(11) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `is_show_on_index` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mall_id` (`mall_id`) USING BTREE,
  KEY `content_id` (`content_id`) USING BTREE,
  CONSTRAINT `by_adv_ibfk_1` FOREIGN KEY (`mall_id`) REFERENCES `by_shopping_mall` (`id`),
  CONSTRAINT `by_adv_ibfk_2` FOREIGN KEY (`content_id`) REFERENCES `by_content` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_adv
-- ----------------------------

-- ----------------------------
-- Table structure for by_authority
-- ----------------------------
DROP TABLE IF EXISTS `by_authority`;
CREATE TABLE `by_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET gb2312 DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `valid` smallint(6) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_authority
-- ----------------------------
INSERT INTO `by_authority` VALUES ('1', '超级管理员', null, null, null, null, '1');
INSERT INTO `by_authority` VALUES ('2', '客服中心', 'terry', null, '2016-11-24 13:35:54', null, '1');

-- ----------------------------
-- Table structure for by_auth_menu
-- ----------------------------
DROP TABLE IF EXISTS `by_auth_menu`;
CREATE TABLE `by_auth_menu` (
  `auth_id` int(11) NOT NULL DEFAULT '0',
  `menu_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`auth_id`,`menu_id`),
  KEY `menu_id` (`menu_id`) USING BTREE,
  CONSTRAINT `by_auth_menu_ibfk_1` FOREIGN KEY (`auth_id`) REFERENCES `by_authority` (`id`),
  CONSTRAINT `by_auth_menu_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `by_menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_auth_menu
-- ----------------------------
INSERT INTO `by_auth_menu` VALUES ('1', '1');
INSERT INTO `by_auth_menu` VALUES ('1', '2');
INSERT INTO `by_auth_menu` VALUES ('1', '3');
INSERT INTO `by_auth_menu` VALUES ('1', '4');
INSERT INTO `by_auth_menu` VALUES ('1', '5');
INSERT INTO `by_auth_menu` VALUES ('1', '6');
INSERT INTO `by_auth_menu` VALUES ('2', '6');
INSERT INTO `by_auth_menu` VALUES ('1', '7');
INSERT INTO `by_auth_menu` VALUES ('2', '7');
INSERT INTO `by_auth_menu` VALUES ('1', '8');
INSERT INTO `by_auth_menu` VALUES ('2', '8');
INSERT INTO `by_auth_menu` VALUES ('1', '9');
INSERT INTO `by_auth_menu` VALUES ('1', '10');
INSERT INTO `by_auth_menu` VALUES ('1', '11');
INSERT INTO `by_auth_menu` VALUES ('1', '12');
INSERT INTO `by_auth_menu` VALUES ('1', '13');
INSERT INTO `by_auth_menu` VALUES ('1', '14');
INSERT INTO `by_auth_menu` VALUES ('1', '16');
INSERT INTO `by_auth_menu` VALUES ('1', '17');
INSERT INTO `by_auth_menu` VALUES ('1', '18');
INSERT INTO `by_auth_menu` VALUES ('1', '19');
INSERT INTO `by_auth_menu` VALUES ('1', '20');
INSERT INTO `by_auth_menu` VALUES ('1', '21');
INSERT INTO `by_auth_menu` VALUES ('1', '22');
INSERT INTO `by_auth_menu` VALUES ('1', '23');
INSERT INTO `by_auth_menu` VALUES ('1', '24');

-- ----------------------------
-- Table structure for by_batch_gift_coupon_info_per_day
-- ----------------------------
DROP TABLE IF EXISTS `by_batch_gift_coupon_info_per_day`;
CREATE TABLE `by_batch_gift_coupon_info_per_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `use_number` int(11) DEFAULT NULL,
  `exchange_number` int(11) DEFAULT NULL,
  `created_time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=636 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_batch_gift_coupon_info_per_day
-- ----------------------------
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('552', '0', '0', '2016-09-05');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('553', '0', '0', '2016-09-06');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('554', '0', '0', '2016-09-07');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('555', '0', '0', '2016-09-08');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('556', '0', '0', '2016-09-09');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('557', '0', '0', '2016-09-10');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('558', '0', '0', '2016-09-11');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('559', '0', '0', '2016-09-12');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('560', '0', '0', '2016-09-13');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('561', '0', '0', '2016-09-14');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('562', '0', '0', '2016-09-15');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('563', '0', '0', '2016-09-16');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('564', '0', '0', '2016-09-17');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('565', '0', '0', '2016-09-18');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('566', '0', '0', '2016-09-19');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('567', '0', '0', '2016-09-20');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('568', '0', '0', '2016-09-21');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('569', '0', '0', '2016-09-22');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('570', '0', '0', '2016-09-23');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('571', '0', '0', '2016-09-24');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('572', '0', '0', '2016-09-25');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('573', '0', '0', '2016-09-26');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('574', '0', '0', '2016-09-27');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('575', '0', '0', '2016-09-28');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('576', '0', '0', '2016-09-29');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('577', '0', '0', '2016-09-30');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('578', '0', '0', '2016-10-01');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('579', '0', '0', '2016-10-02');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('580', '0', '0', '2016-10-03');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('581', '0', '0', '2016-10-04');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('582', '0', '0', '2016-10-05');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('583', '0', '0', '2016-10-06');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('584', '0', '0', '2016-10-07');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('585', '0', '0', '2016-10-08');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('586', '0', '0', '2016-10-09');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('587', '0', '0', '2016-10-10');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('588', '0', '0', '2016-10-11');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('589', '0', '0', '2016-10-12');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('590', '0', '0', '2016-10-13');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('591', '0', '0', '2016-10-14');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('592', '0', '0', '2016-10-15');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('593', '0', '0', '2016-10-16');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('594', '0', '0', '2016-10-17');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('595', '0', '0', '2016-10-18');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('596', '0', '0', '2016-10-19');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('597', '0', '0', '2016-10-20');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('598', '0', '0', '2016-10-21');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('599', '0', '0', '2016-10-22');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('600', '0', '0', '2016-10-23');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('601', '0', '0', '2016-10-24');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('602', '0', '0', '2016-10-25');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('603', '0', '0', '2016-10-26');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('604', '0', '0', '2016-10-27');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('605', '0', '0', '2016-10-28');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('606', '0', '0', '2016-10-29');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('607', '0', '0', '2016-10-30');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('608', '0', '0', '2016-10-31');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('609', '0', '0', '2016-11-01');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('610', '0', '0', '2016-11-02');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('611', '0', '0', '2016-11-03');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('612', '0', '0', '2016-11-04');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('613', '0', '0', '2016-11-05');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('614', '0', '0', '2016-11-06');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('615', '0', '0', '2016-11-07');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('616', '0', '0', '2016-11-08');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('617', '0', '0', '2016-11-09');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('618', '0', '0', '2016-11-10');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('619', '0', '0', '2016-11-11');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('620', '0', '0', '2016-11-12');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('621', '0', '0', '2016-11-13');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('622', '0', '0', '2016-11-14');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('623', '0', '0', '2016-11-15');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('624', '0', '0', '2016-11-16');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('625', '0', '0', '2016-11-17');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('626', '0', '0', '2016-11-18');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('627', '0', '0', '2016-11-19');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('628', '0', '0', '2016-11-20');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('629', '0', '0', '2016-11-21');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('630', '0', '0', '2016-11-22');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('631', '0', '0', '2016-11-23');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('632', '0', '0', '2016-11-24');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('633', '0', '0', '2016-11-25');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('634', '0', '0', '2016-11-26');
INSERT INTO `by_batch_gift_coupon_info_per_day` VALUES ('635', '0', '0', '2016-11-27');

-- ----------------------------
-- Table structure for by_batch_member_inc
-- ----------------------------
DROP TABLE IF EXISTS `by_batch_member_inc`;
CREATE TABLE `by_batch_member_inc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) DEFAULT NULL,
  `created_time` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_batch_member_inc_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_batch_member_inc
-- ----------------------------
INSERT INTO `by_batch_member_inc` VALUES ('1', '0', '2016-09-05');
INSERT INTO `by_batch_member_inc` VALUES ('2', '6', '2016-09-06');
INSERT INTO `by_batch_member_inc` VALUES ('3', '10', '2016-09-07');
INSERT INTO `by_batch_member_inc` VALUES ('4', '144', '2016-09-08');
INSERT INTO `by_batch_member_inc` VALUES ('5', '52', '2016-09-09');
INSERT INTO `by_batch_member_inc` VALUES ('6', '46', '2016-09-10');
INSERT INTO `by_batch_member_inc` VALUES ('7', '97', '2016-09-11');
INSERT INTO `by_batch_member_inc` VALUES ('8', '35', '2016-09-12');
INSERT INTO `by_batch_member_inc` VALUES ('9', '12', '2016-09-13');
INSERT INTO `by_batch_member_inc` VALUES ('10', '40', '2016-09-14');
INSERT INTO `by_batch_member_inc` VALUES ('11', '23', '2016-09-15');
INSERT INTO `by_batch_member_inc` VALUES ('12', '14', '2016-09-16');
INSERT INTO `by_batch_member_inc` VALUES ('13', '14', '2016-09-17');
INSERT INTO `by_batch_member_inc` VALUES ('14', '10', '2016-09-18');
INSERT INTO `by_batch_member_inc` VALUES ('15', '7', '2016-09-19');
INSERT INTO `by_batch_member_inc` VALUES ('16', '5', '2016-09-20');
INSERT INTO `by_batch_member_inc` VALUES ('17', '2', '2016-09-21');
INSERT INTO `by_batch_member_inc` VALUES ('18', '10', '2016-09-22');
INSERT INTO `by_batch_member_inc` VALUES ('19', '13', '2016-09-23');
INSERT INTO `by_batch_member_inc` VALUES ('20', '13', '2016-09-24');
INSERT INTO `by_batch_member_inc` VALUES ('21', '15', '2016-09-25');
INSERT INTO `by_batch_member_inc` VALUES ('22', '1', '2016-09-26');
INSERT INTO `by_batch_member_inc` VALUES ('23', '6', '2016-09-27');
INSERT INTO `by_batch_member_inc` VALUES ('24', '4', '2016-09-28');
INSERT INTO `by_batch_member_inc` VALUES ('25', '21', '2016-09-29');
INSERT INTO `by_batch_member_inc` VALUES ('26', '5', '2016-09-30');
INSERT INTO `by_batch_member_inc` VALUES ('27', '18', '2016-10-01');
INSERT INTO `by_batch_member_inc` VALUES ('28', '13', '2016-10-02');
INSERT INTO `by_batch_member_inc` VALUES ('29', '4', '2016-10-03');
INSERT INTO `by_batch_member_inc` VALUES ('30', '11', '2016-10-04');
INSERT INTO `by_batch_member_inc` VALUES ('31', '8', '2016-10-05');
INSERT INTO `by_batch_member_inc` VALUES ('32', '16', '2016-10-06');
INSERT INTO `by_batch_member_inc` VALUES ('33', '13', '2016-10-07');
INSERT INTO `by_batch_member_inc` VALUES ('34', '4', '2016-10-08');
INSERT INTO `by_batch_member_inc` VALUES ('35', '4', '2016-10-09');
INSERT INTO `by_batch_member_inc` VALUES ('36', '2', '2016-10-10');
INSERT INTO `by_batch_member_inc` VALUES ('37', '2', '2016-10-11');
INSERT INTO `by_batch_member_inc` VALUES ('38', '2', '2016-10-12');
INSERT INTO `by_batch_member_inc` VALUES ('39', '5', '2016-10-13');
INSERT INTO `by_batch_member_inc` VALUES ('40', '15', '2016-10-14');
INSERT INTO `by_batch_member_inc` VALUES ('41', '11', '2016-10-15');
INSERT INTO `by_batch_member_inc` VALUES ('42', '8', '2016-10-16');
INSERT INTO `by_batch_member_inc` VALUES ('43', '4', '2016-10-17');
INSERT INTO `by_batch_member_inc` VALUES ('45', '4', '2016-10-18');
INSERT INTO `by_batch_member_inc` VALUES ('47', '2', '2016-10-19');
INSERT INTO `by_batch_member_inc` VALUES ('49', '13', '2016-10-20');
INSERT INTO `by_batch_member_inc` VALUES ('51', '2', '2016-10-21');
INSERT INTO `by_batch_member_inc` VALUES ('53', '8', '2016-10-22');
INSERT INTO `by_batch_member_inc` VALUES ('55', '11', '2016-10-23');
INSERT INTO `by_batch_member_inc` VALUES ('57', '1', '2016-10-24');
INSERT INTO `by_batch_member_inc` VALUES ('59', '5', '2016-10-25');
INSERT INTO `by_batch_member_inc` VALUES ('61', '12', '2016-10-26');
INSERT INTO `by_batch_member_inc` VALUES ('63', '2', '2016-10-27');
INSERT INTO `by_batch_member_inc` VALUES ('65', '13', '2016-10-28');
INSERT INTO `by_batch_member_inc` VALUES ('67', '4', '2016-10-29');
INSERT INTO `by_batch_member_inc` VALUES ('69', '17', '2016-10-30');
INSERT INTO `by_batch_member_inc` VALUES ('71', '0', '2016-10-31');
INSERT INTO `by_batch_member_inc` VALUES ('73', '4', '2016-11-01');
INSERT INTO `by_batch_member_inc` VALUES ('75', '3', '2016-11-02');
INSERT INTO `by_batch_member_inc` VALUES ('77', '2', '2016-11-03');
INSERT INTO `by_batch_member_inc` VALUES ('79', '1', '2016-11-04');
INSERT INTO `by_batch_member_inc` VALUES ('81', '5', '2016-11-05');
INSERT INTO `by_batch_member_inc` VALUES ('83', '6', '2016-11-06');
INSERT INTO `by_batch_member_inc` VALUES ('85', '1', '2016-11-07');
INSERT INTO `by_batch_member_inc` VALUES ('87', '0', '2016-11-08');
INSERT INTO `by_batch_member_inc` VALUES ('89', '3', '2016-11-09');
INSERT INTO `by_batch_member_inc` VALUES ('91', '3', '2016-11-10');
INSERT INTO `by_batch_member_inc` VALUES ('93', '4', '2016-11-11');
INSERT INTO `by_batch_member_inc` VALUES ('95', '2', '2016-11-12');
INSERT INTO `by_batch_member_inc` VALUES ('97', '2', '2016-11-13');
INSERT INTO `by_batch_member_inc` VALUES ('99', '2', '2016-11-14');
INSERT INTO `by_batch_member_inc` VALUES ('101', '1', '2016-11-15');
INSERT INTO `by_batch_member_inc` VALUES ('103', '1', '2016-11-16');
INSERT INTO `by_batch_member_inc` VALUES ('105', '5', '2016-11-17');
INSERT INTO `by_batch_member_inc` VALUES ('107', '4', '2016-11-18');
INSERT INTO `by_batch_member_inc` VALUES ('109', '4', '2016-11-19');
INSERT INTO `by_batch_member_inc` VALUES ('111', '4', '2016-11-20');
INSERT INTO `by_batch_member_inc` VALUES ('113', '3', '2016-11-21');
INSERT INTO `by_batch_member_inc` VALUES ('114', '2', '2016-11-22');
INSERT INTO `by_batch_member_inc` VALUES ('115', '4', '2016-11-23');
INSERT INTO `by_batch_member_inc` VALUES ('116', '1', '2016-11-24');
INSERT INTO `by_batch_member_inc` VALUES ('117', '0', '2016-11-25');
INSERT INTO `by_batch_member_inc` VALUES ('118', '2', '2016-11-26');
INSERT INTO `by_batch_member_inc` VALUES ('119', '3', '2016-11-27');

-- ----------------------------
-- Table structure for by_batch_parking_coupon_info_per_day
-- ----------------------------
DROP TABLE IF EXISTS `by_batch_parking_coupon_info_per_day`;
CREATE TABLE `by_batch_parking_coupon_info_per_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `use_number` int(11) DEFAULT NULL,
  `exchange_number` int(11) DEFAULT NULL,
  `created_time` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_batch_parking_coupon_info_per_day` (`created_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=557 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_batch_parking_coupon_info_per_day
-- ----------------------------
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('473', '0', '0', '2016-09-05');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('474', '0', '0', '2016-09-06');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('475', '0', '0', '2016-09-07');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('476', '0', '0', '2016-09-08');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('477', '0', '0', '2016-09-09');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('478', '0', '0', '2016-09-10');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('479', '0', '0', '2016-09-11');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('480', '0', '0', '2016-09-12');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('481', '0', '0', '2016-09-13');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('482', '0', '0', '2016-09-14');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('483', '0', '0', '2016-09-15');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('484', '0', '0', '2016-09-16');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('485', '0', '0', '2016-09-17');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('486', '0', '0', '2016-09-18');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('487', '0', '0', '2016-09-19');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('488', '0', '0', '2016-09-20');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('489', '0', '0', '2016-09-21');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('490', '0', '0', '2016-09-22');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('491', '0', '0', '2016-09-23');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('492', '0', '0', '2016-09-24');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('493', '0', '0', '2016-09-25');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('494', '0', '0', '2016-09-26');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('495', '0', '0', '2016-09-27');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('496', '0', '0', '2016-09-28');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('497', '0', '0', '2016-09-29');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('498', '0', '0', '2016-09-30');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('499', '0', '0', '2016-10-01');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('500', '0', '0', '2016-10-02');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('501', '0', '0', '2016-10-03');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('502', '0', '0', '2016-10-04');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('503', '0', '0', '2016-10-05');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('504', '0', '0', '2016-10-06');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('505', '0', '0', '2016-10-07');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('506', '0', '0', '2016-10-08');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('507', '0', '0', '2016-10-09');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('508', '0', '0', '2016-10-10');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('509', '0', '0', '2016-10-11');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('510', '0', '0', '2016-10-12');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('511', '0', '0', '2016-10-13');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('512', '0', '0', '2016-10-14');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('513', '0', '0', '2016-10-15');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('514', '0', '0', '2016-10-16');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('515', '0', '0', '2016-10-17');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('516', '0', '0', '2016-10-18');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('517', '0', '0', '2016-10-19');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('518', '0', '0', '2016-10-20');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('519', '0', '0', '2016-10-21');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('520', '0', '0', '2016-10-22');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('521', '0', '0', '2016-10-23');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('522', '0', '0', '2016-10-24');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('523', '0', '0', '2016-10-25');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('524', '0', '0', '2016-10-26');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('525', '0', '0', '2016-10-27');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('526', '0', '0', '2016-10-28');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('527', '0', '0', '2016-10-29');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('528', '0', '0', '2016-10-30');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('529', '0', '0', '2016-10-31');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('530', '0', '0', '2016-11-01');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('531', '0', '0', '2016-11-02');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('532', '0', '0', '2016-11-03');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('533', '0', '0', '2016-11-04');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('534', '0', '0', '2016-11-05');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('535', '0', '0', '2016-11-06');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('536', '0', '0', '2016-11-07');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('537', '0', '0', '2016-11-08');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('538', '0', '0', '2016-11-09');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('539', '0', '0', '2016-11-10');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('540', '0', '0', '2016-11-11');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('541', '0', '0', '2016-11-12');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('542', '0', '0', '2016-11-13');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('543', '0', '0', '2016-11-14');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('544', '0', '0', '2016-11-15');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('545', '0', '0', '2016-11-16');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('546', '0', '0', '2016-11-17');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('547', '0', '0', '2016-11-18');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('548', '0', '0', '2016-11-19');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('549', '0', '0', '2016-11-20');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('550', '0', '0', '2016-11-21');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('551', '0', '0', '2016-11-22');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('552', '0', '0', '2016-11-23');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('553', '0', '0', '2016-11-24');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('554', '0', '0', '2016-11-25');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('555', '0', '0', '2016-11-26');
INSERT INTO `by_batch_parking_coupon_info_per_day` VALUES ('556', '0', '0', '2016-11-27');

-- ----------------------------
-- Table structure for by_batch_shop_coupon_info_per_day
-- ----------------------------
DROP TABLE IF EXISTS `by_batch_shop_coupon_info_per_day`;
CREATE TABLE `by_batch_shop_coupon_info_per_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `use_number` int(11) DEFAULT NULL,
  `exchange_number` int(11) DEFAULT NULL,
  `created_time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=636 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_batch_shop_coupon_info_per_day
-- ----------------------------
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('552', '0', '0', '2016-09-05');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('553', '0', '0', '2016-09-06');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('554', '0', '0', '2016-09-07');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('555', '0', '0', '2016-09-08');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('556', '0', '0', '2016-09-09');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('557', '0', '0', '2016-09-10');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('558', '0', '0', '2016-09-11');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('559', '0', '0', '2016-09-12');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('560', '0', '0', '2016-09-13');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('561', '0', '0', '2016-09-14');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('562', '0', '0', '2016-09-15');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('563', '0', '0', '2016-09-16');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('564', '0', '0', '2016-09-17');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('565', '0', '0', '2016-09-18');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('566', '0', '0', '2016-09-19');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('567', '0', '0', '2016-09-20');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('568', '0', '0', '2016-09-21');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('569', '0', '0', '2016-09-22');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('570', '0', '0', '2016-09-23');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('571', '0', '0', '2016-09-24');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('572', '0', '0', '2016-09-25');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('573', '0', '0', '2016-09-26');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('574', '0', '0', '2016-09-27');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('575', '0', '0', '2016-09-28');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('576', '0', '0', '2016-09-29');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('577', '0', '0', '2016-09-30');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('578', '0', '0', '2016-10-01');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('579', '0', '0', '2016-10-02');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('580', '0', '0', '2016-10-03');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('581', '0', '0', '2016-10-04');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('582', '0', '0', '2016-10-05');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('583', '0', '0', '2016-10-06');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('584', '0', '0', '2016-10-07');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('585', '0', '0', '2016-10-08');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('586', '0', '0', '2016-10-09');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('587', '0', '0', '2016-10-10');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('588', '0', '0', '2016-10-11');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('589', '0', '0', '2016-10-12');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('590', '0', '0', '2016-10-13');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('591', '0', '0', '2016-10-14');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('592', '0', '0', '2016-10-15');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('593', '0', '0', '2016-10-16');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('594', '0', '0', '2016-10-17');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('595', '0', '0', '2016-10-18');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('596', '0', '0', '2016-10-19');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('597', '0', '0', '2016-10-20');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('598', '0', '0', '2016-10-21');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('599', '0', '0', '2016-10-22');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('600', '0', '0', '2016-10-23');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('601', '0', '0', '2016-10-24');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('602', '0', '0', '2016-10-25');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('603', '0', '0', '2016-10-26');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('604', '0', '0', '2016-10-27');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('605', '0', '0', '2016-10-28');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('606', '0', '0', '2016-10-29');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('607', '0', '0', '2016-10-30');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('608', '0', '0', '2016-10-31');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('609', '0', '0', '2016-11-01');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('610', '0', '0', '2016-11-02');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('611', '0', '0', '2016-11-03');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('612', '0', '0', '2016-11-04');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('613', '0', '0', '2016-11-05');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('614', '0', '0', '2016-11-06');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('615', '0', '0', '2016-11-07');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('616', '0', '0', '2016-11-08');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('617', '0', '0', '2016-11-09');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('618', '0', '0', '2016-11-10');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('619', '0', '0', '2016-11-11');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('620', '0', '0', '2016-11-12');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('621', '0', '0', '2016-11-13');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('622', '0', '0', '2016-11-14');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('623', '0', '0', '2016-11-15');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('624', '0', '0', '2016-11-16');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('625', '0', '0', '2016-11-17');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('626', '0', '0', '2016-11-18');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('627', '0', '0', '2016-11-19');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('628', '0', '0', '2016-11-20');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('629', '0', '0', '2016-11-21');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('630', '0', '0', '2016-11-22');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('631', '0', '0', '2016-11-23');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('632', '0', '0', '2016-11-24');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('633', '0', '0', '2016-11-25');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('634', '0', '0', '2016-11-26');
INSERT INTO `by_batch_shop_coupon_info_per_day` VALUES ('635', '0', '0', '2016-11-27');

-- ----------------------------
-- Table structure for by_batch_trading_inc
-- ----------------------------
DROP TABLE IF EXISTS `by_batch_trading_inc`;
CREATE TABLE `by_batch_trading_inc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `created_time` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_batch_trading_inc_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_batch_trading_inc
-- ----------------------------
INSERT INTO `by_batch_trading_inc` VALUES ('1', '26', '3436.01', '2016-11-21');
INSERT INTO `by_batch_trading_inc` VALUES ('2', '13', '1530', '2016-11-22');
INSERT INTO `by_batch_trading_inc` VALUES ('3', '20', '3190', '2016-11-23');
INSERT INTO `by_batch_trading_inc` VALUES ('4', '12', '1975', '2016-11-24');
INSERT INTO `by_batch_trading_inc` VALUES ('5', '51', '19413.1', '2016-11-25');
INSERT INTO `by_batch_trading_inc` VALUES ('6', '37', '12158.1', '2016-11-26');
INSERT INTO `by_batch_trading_inc` VALUES ('7', '36', '16118', '2016-11-27');

-- ----------------------------
-- Table structure for by_batch_trading_per_day
-- ----------------------------
DROP TABLE IF EXISTS `by_batch_trading_per_day`;
CREATE TABLE `by_batch_trading_per_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_key` varchar(255) DEFAULT NULL,
  `shop_name` varchar(255) DEFAULT NULL,
  `floor` char(3) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  `created_time` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of by_batch_trading_per_day
-- ----------------------------
INSERT INTO `by_batch_trading_per_day` VALUES ('1', '112', 'vero moda', '1F', '10', '5000', '2016-11-03');
INSERT INTO `by_batch_trading_per_day` VALUES ('2', '113', 'kiss Ring', '1F', '20', '100000', '2016-11-03');
INSERT INTO `by_batch_trading_per_day` VALUES ('3', '126', '卡洛特', '1F', '15', '15000', '2016-11-03');
INSERT INTO `by_batch_trading_per_day` VALUES ('4', '117-121', '优衣库', '1F', '50', '10000', '2016-11-03');
INSERT INTO `by_batch_trading_per_day` VALUES ('5', '105', '星巴克', '1F', '100', '300000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('6', '213', '热风', '2F', '20', '6000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('7', '222', '雪冰', '2F', '30', '500', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('8', '205-206', '屈臣氏', '2F', '30', '500', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('9', '212B', '科蒂美语', '2F', '10', '5000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('10', '227.228', '滨崎', '2F', '10', '5000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('11', '308', '大咀茶餐厅', '3F', '10', '5000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('12', '313', '藩茄田', '3F', '10', '5000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('13', '302', '爱婴室', '3F', '10', '5000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('14', '319', '爱乐游', '3F', '10', '5000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('15', '315', '曼都', '3F', '10', '5000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('16', '407', '什味阁', '4F', '10', '10000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('17', '401B', '回乡缘', '4F', '10', '8000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('18', '401A', 'SFC上影影城', '4F', '100', '20000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('19', '415', '快乐柠檬', '4F', '50', '600', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('20', '412', '九亭轩铁板烧', '4F', '50', '10000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('21', '502', '重庆熬家老火锅', '5F', '50', '15000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('22', 'B1F', 'G-super', 'B1F', '10', '10000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('23', 'B05', '大马榴芒', 'B1F', '10', '8000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('24', 'B08', '食其家', 'B1F', '100', '20000', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('25', 'B02、B03', '游艺城', 'B1F', '50', '600', '2016-11-08');
INSERT INTO `by_batch_trading_per_day` VALUES ('26', 'B12', '雪茄', 'B1F', '50', '10000', '2016-11-08');

-- ----------------------------
-- Table structure for by_card
-- ----------------------------
DROP TABLE IF EXISTS `by_card`;
CREATE TABLE `by_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `valid` smallint(6) DEFAULT '1',
  `img_href` varchar(77) DEFAULT NULL,
  `init_score` int(11) DEFAULT '0',
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `summary` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_card
-- ----------------------------
INSERT INTO `by_card` VALUES ('1', '普通会员卡', '1', 'http://cchdev.b0.upaiyun.com//2016/6/34fc75b0-dda8-4bf2-baea-9de59e9e9bbc.png', '0', null, null, null, null, '');

-- ----------------------------
-- Table structure for by_card_aud
-- ----------------------------
DROP TABLE IF EXISTS `by_card_aud`;
CREATE TABLE `by_card_aud` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `valid` smallint(6) DEFAULT NULL,
  `img_href` varchar(77) DEFAULT NULL,
  `init_score` int(11) DEFAULT '0',
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `summary` varchar(500) DEFAULT NULL,
  `REV` int(11) NOT NULL,
  `REVTYPE` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`,`REV`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_card_aud
-- ----------------------------
INSERT INTO `by_card_aud` VALUES ('1', '普通会员卡', '1', 'http://cchdev.b0.upaiyun.com//2016/6/34fc75b0-dda8-4bf2-baea-9de59e9e9bbc.png', '0', null, null, null, null, '', '243', '1');

-- ----------------------------
-- Table structure for by_category
-- ----------------------------
DROP TABLE IF EXISTS `by_category`;
CREATE TABLE `by_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET gb2312 NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `valid` smallint(6) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`) USING BTREE,
  CONSTRAINT `by_category_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `by_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_category
-- ----------------------------
INSERT INTO `by_category` VALUES ('1', 'icon-two', null, 'm', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('2', 'icon-three', null, 'm', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('3', 'icon-four', null, 'm', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('4', 'icon-five', null, 'm', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('5', 'icon-six', null, 'm', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('6', 'icon-seven', null, 'm', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('7', 'icon-seven', null, 'm', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('8', 'icon-eight', null, 'm', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('9', '交易规则', null, 'r', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('10', '注册规则', null, 'r', '1', null, null, null, null);
INSERT INTO `by_category` VALUES ('45', '零售', null, 's', '1', 'terry', '2016-08-16 14:57:21', null, '2016-08-16 14:57:21');
INSERT INTO `by_category` VALUES ('46', '餐饮', null, 's', '1', 'terry', '2016-08-16 14:57:41', null, '2016-08-16 14:57:41');
INSERT INTO `by_category` VALUES ('47', '服装', '45', 's', '1', null, '2016-08-16 15:16:23', null, '2016-08-16 15:16:23');
INSERT INTO `by_category` VALUES ('48', '面包西点', '46', 's', '1', null, '2016-08-16 15:19:36', null, '2016-08-16 15:19:36');
INSERT INTO `by_category` VALUES ('49', '娱乐生活', null, 's', '1', 'terry', '2016-11-21 10:28:43', null, '2016-11-21 10:34:52');
INSERT INTO `by_category` VALUES ('50', '儿童亲子', '49', 's', '1', null, '2016-11-21 10:29:00', null, '2016-11-21 10:34:52');
INSERT INTO `by_category` VALUES ('51', '儿童亲子', null, 's', '1', 'terry', '2016-11-21 10:29:30', null, '2016-11-21 10:29:30');
INSERT INTO `by_category` VALUES ('52', '娱乐生活', '49', 's', '1', null, '2016-11-21 10:34:20', null, '2016-11-21 10:34:20');

-- ----------------------------
-- Table structure for by_consumption_history
-- ----------------------------
DROP TABLE IF EXISTS `by_consumption_history`;
CREATE TABLE `by_consumption_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `shop` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  CONSTRAINT `by_consumption_history_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_consumption_history
-- ----------------------------

-- ----------------------------
-- Table structure for by_content
-- ----------------------------
DROP TABLE IF EXISTS `by_content`;
CREATE TABLE `by_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `summary` varchar(6000) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_content
-- ----------------------------
INSERT INTO `by_content` VALUES ('18', '<p>会员权益一览：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>超值优惠的会员专享折扣-百余家零售、餐饮、娱乐商户提供会员专享特惠折扣；</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>种类多样的礼券礼品兑换-会员消费积分可兑换品种繁多的礼品或者优惠券；</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>积分可用于支付抵扣-消费积分可在指定商户处，进行消费时的积分抵扣支付；</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>丰富多彩的会员活动-不论是线上、线下，会员可不定期参与各类有趣的微信互动有奖活动，并有机会获得丰厚的奖励或优惠；</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>会员专属的大型活动入场券-读书会、亲子游戏、联谊会、观影节等大型活动的会员专享入场券。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>积分规则一览：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>会员在线下指定商户处每消费RMB1.00即可赚取积分1点；参与线下或线上互动有奖活动，有机会获得一定比例的会员积分，具体规则，需以实际活动规则为准；金桥太茂会不定期赠送会员积分，具体时间及规则需以金桥太茂官方公告为准。</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>当遇到多个会员活动同时进行，会员积分按照什么规则获取？</li>\r\n	<li>会员积分的获取按照最终取获得积分最高的规则为优先。例如：</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li>规则1 : 倍率2 额外积分 200</li>\r\n	<li>规则2 : 倍率1 额外积分 500</li>\r\n	<li>&nbsp;</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>当指定商户的会员积分活动和金桥太茂的会员交易积分规则不同时，会员积分该如何获取？</li>\r\n	<li>倍率取高，额外积分可叠加。例如：</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li>规则1 : 店铺积分规则：倍率2 额外积分200</li>\r\n	<li>规则2 : 会员卡交易积分规则：倍率3 额外积分100</li>\r\n</ul>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 最终按倍率3进行交易积分的获取，同时获得额外积分300</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>其它条款一览：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>退会-持卡人如需退会，可直接在金桥太茂官方微信中，进行账户注销。如持卡人违反本章程的任何规定，或有损金桥太茂企业形象或信誉的行为，本公司有权在不发出任何通知的情况下取消其会员资格、清除卡内积分，并保留追究其法律责任的权利。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>会员通知-金桥太茂发出的任何通知或信息若有不一致的，以金桥太茂礼宾处的公告为准。如通告公布30日后，持卡人仍继续使用本卡或未提出退会申请的，将视为同意通告内的变更事项。</li>\r\n</ol>\r\n', 'h');
INSERT INTO `by_content` VALUES ('19', '<p>入会声明：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>本人自愿申请成为金桥太茂商业广场的微信会员，并同意遵守会员章程及金桥太茂商业广场所制定的各项制度和规章。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>会员同意金桥太茂商业广场保留对会员优惠、积分规则及其他会员办法的修订和最终解释权指定商户及消费优惠的权利。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>本人保证上述资料的真实性，并有责任及时通知本公司任何资料更新信息，若因未及时通知本公司任何资料更新信息而造成的损失由本人自行承担。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>本人同意金桥太茂商业广场可随时取消本人的微信会员资格并注销电子会员卡而无需给予本人任何补偿。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>本人同意免除金桥太茂商业广场就提供的奖品、礼品（包括商品或服务）质量之责任。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>本人同意金桥太茂商业广场无需就购物中心内商户所提供的商品或服务质量承担任何责任。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>本人同意消费积分数据以金桥太茂商业广场制定系统内的记录为准。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>会员须知：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>会员是指在同意会员章程的基础上，申请使用金桥太茂商业广场（以下简称&ldquo;金桥太茂&rdquo;）的电子会员卡，并得到金桥太茂认可的顾客。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>每人限办一张电子会员卡。会员卡仅限持卡人本人拥有、使用和获益，不可转让。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>会员保证向金桥太茂提供的申请资料是正确、完整、真实的，如金桥太茂出于为会员提供有关服务于的目的，有权通过金桥太茂认可的各公司向会员寄送各种宣传印刷物品及信息。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>会员持本卡在指定优惠商户处消费可享受消费优惠、会员卡优惠不得与其它优惠同时享用。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ol>\r\n	<li>请您完整填写会员申请表，如因资料不全，导致信息不能送达，所有损失自理。</li>\r\n</ol>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>免责条款：</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>金桥太茂拥有绝对酌情权和解释权，可不经事先知会而于任何时候修改本页内容及相关会员章程、会员服务内容，积分模式。金桥太茂不对手册信息及会员章程的完整性或准确性提供任何担保，任何因依赖或引用手册内容及会员章程而造成的损失，金桥太茂不承担任何责任。</p>\r\n', 'h');

-- ----------------------------
-- Table structure for by_coupon
-- ----------------------------
DROP TABLE IF EXISTS `by_coupon`;
CREATE TABLE `by_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` char(1) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `begin_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  `coupon_end_time` timestamp NULL DEFAULT NULL,
  `valid` smallint(6) DEFAULT '1',
  `total` smallint(6) DEFAULT '0',
  `duplicate` smallint(6) DEFAULT '1',
  `amount` double DEFAULT '0',
  `cover_img` char(77) DEFAULT NULL,
  `content_img` char(77) DEFAULT NULL,
  `logo` char(77) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_coupon_name_unique` (`name`) USING BTREE,
  KEY `shop_id` (`shop_id`) USING BTREE,
  CONSTRAINT `by_coupon_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `by_shop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_coupon
-- ----------------------------
INSERT INTO `by_coupon` VALUES ('1', 's', '圣诞有礼', '2016-12-12 00:00:00', '2017-01-03 23:59:59', '2016-12-05 14:23:36', 'terry', '2016-12-12 14:41:31', null, '0', '2017-01-03 23:59:59', '1', '300', '1', '20', '', '', null, '<p>圣诞有礼</p>\r\n', '30');
INSERT INTO `by_coupon` VALUES ('4', 's', '周末乐翻天', null, null, '2016-12-14 13:47:56', 'terry', null, null, '0', '2016-12-31 23:59:59', '1', '10', '0', '100', '', '', null, '', '30');

-- ----------------------------
-- Table structure for by_floor
-- ----------------------------
DROP TABLE IF EXISTS `by_floor`;
CREATE TABLE `by_floor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_floor
-- ----------------------------
INSERT INTO `by_floor` VALUES ('1', '1F');
INSERT INTO `by_floor` VALUES ('2', '2F');
INSERT INTO `by_floor` VALUES ('3', '3F');
INSERT INTO `by_floor` VALUES ('4', '4F');
INSERT INTO `by_floor` VALUES ('5', '5F');
INSERT INTO `by_floor` VALUES ('6', '6F');
INSERT INTO `by_floor` VALUES ('8', 'B1F');

-- ----------------------------
-- Table structure for by_gift_coupon_member
-- ----------------------------
DROP TABLE IF EXISTS `by_gift_coupon_member`;
CREATE TABLE `by_gift_coupon_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `code` char(17) DEFAULT NULL,
  `state` smallint(6) DEFAULT NULL,
  `exchanged_time` timestamp NULL DEFAULT NULL,
  `used_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_gift_coupon_member_code_unique` (`code`) USING BTREE,
  KEY `member_id` (`member_id`) USING BTREE,
  KEY `coupon_id` (`coupon_id`) USING BTREE,
  CONSTRAINT `by_gift_coupon_member_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`),
  CONSTRAINT `by_gift_coupon_member_ibfk_2` FOREIGN KEY (`coupon_id`) REFERENCES `by_coupon` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_gift_coupon_member
-- ----------------------------

-- ----------------------------
-- Table structure for by_license
-- ----------------------------
DROP TABLE IF EXISTS `by_license`;
CREATE TABLE `by_license` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_license
-- ----------------------------

-- ----------------------------
-- Table structure for by_member
-- ----------------------------
DROP TABLE IF EXISTS `by_member`;
CREATE TABLE `by_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` char(11) DEFAULT NULL,
  `card_id` int(11) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `sumScore` int(11) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `valid` smallint(6) DEFAULT '1',
  `invalid_time` timestamp NULL DEFAULT NULL,
  `invalid_by` varchar(20) DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `detail_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  UNIQUE KEY `by_member_name_unique` (`name`) USING BTREE,
  KEY `card_id` (`card_id`) USING BTREE,
  KEY `detail_id` (`detail_id`) USING BTREE,
  CONSTRAINT `by_member_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `by_card` (`id`),
  CONSTRAINT `by_member_ibfk_2` FOREIGN KEY (`detail_id`) REFERENCES `by_member_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=948 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_member
-- ----------------------------
INSERT INTO `by_member` VALUES ('37', '18550017886', '1', '560', '560', '2016-09-06 00:12:26', '1', null, null, '2016-12-02 11:40:11', null, null, '37');
INSERT INTO `by_member` VALUES ('38', '13818025598', '1', '0', '0', '2016-09-06 11:58:21', '1', null, null, null, null, null, '38');
INSERT INTO `by_member` VALUES ('39', '13901675808', '1', '0', '0', '2016-09-06 16:43:07', '1', null, null, null, null, null, '39');
INSERT INTO `by_member` VALUES ('40', '13917638925', '1', '0', '0', '2016-09-06 16:49:15', '1', null, null, null, null, null, '40');
INSERT INTO `by_member` VALUES ('41', '18101811358', '1', '0', '0', '2016-09-06 16:49:48', '1', null, null, null, null, null, '41');
INSERT INTO `by_member` VALUES ('42', '13671829307', '1', '0', '0', '2016-09-06 16:49:52', '1', null, null, null, null, null, '42');
INSERT INTO `by_member` VALUES ('43', '13817565893', '1', '0', '0', '2016-09-07 13:49:31', '1', null, null, null, null, null, '43');
INSERT INTO `by_member` VALUES ('44', '13641830501', '1', '0', '0', '2016-09-07 13:50:09', '1', null, null, null, null, null, '44');
INSERT INTO `by_member` VALUES ('45', '13611745913', '1', '0', '0', '2016-09-07 13:50:33', '1', null, null, null, null, null, '45');
INSERT INTO `by_member` VALUES ('46', '13817442995', '1', '0', '0', '2016-09-07 13:50:40', '1', null, null, null, null, null, '46');
INSERT INTO `by_member` VALUES ('47', '15921662616', '1', '0', '0', '2016-09-07 22:15:19', '1', null, null, null, null, null, '47');
INSERT INTO `by_member` VALUES ('48', '13818543037', '1', '0', '0', '2016-09-07 22:15:30', '1', null, null, null, null, null, '48');
INSERT INTO `by_member` VALUES ('49', '13611878871', '1', '0', '0', '2016-09-07 22:21:04', '1', null, null, null, null, null, '49');
INSERT INTO `by_member` VALUES ('50', '13621993250', '1', '0', '0', '2016-09-07 23:01:48', '1', null, null, null, null, null, '50');
INSERT INTO `by_member` VALUES ('51', '13818726011', '1', '0', '0', '2016-09-07 23:18:12', '1', null, null, null, null, null, '51');
INSERT INTO `by_member` VALUES ('52', '13916715110', '1', '0', '0', '2016-09-07 23:46:03', '1', null, null, null, null, null, '52');
INSERT INTO `by_member` VALUES ('53', '13818851703', '1', '0', '0', '2016-09-08 00:02:48', '1', null, null, null, null, null, '53');
INSERT INTO `by_member` VALUES ('54', '18817350918', '1', '0', '0', '2016-09-08 00:06:24', '1', null, null, null, null, null, '54');
INSERT INTO `by_member` VALUES ('55', '18930720036', '1', '0', '0', '2016-09-08 00:07:39', '1', null, null, null, null, null, '55');
INSERT INTO `by_member` VALUES ('56', '13701736402', '1', '0', '0', '2016-09-08 00:18:38', '1', null, null, null, null, null, '56');
INSERT INTO `by_member` VALUES ('57', '15861825532', '1', '0', '0', '2016-09-08 01:05:13', '1', null, null, null, null, null, '57');
INSERT INTO `by_member` VALUES ('58', '13818768788', '1', '0', '0', '2016-09-08 01:17:51', '1', null, null, null, null, null, '58');
INSERT INTO `by_member` VALUES ('59', '13601753886', '1', '0', '0', '2016-09-08 05:46:19', '1', null, null, null, null, null, '59');
INSERT INTO `by_member` VALUES ('60', '18651988073', '1', '0', '0', '2016-09-08 05:50:40', '1', null, null, null, null, null, '60');
INSERT INTO `by_member` VALUES ('61', '13601758157', '1', '0', '0', '2016-09-08 06:47:16', '1', null, null, null, null, null, '61');
INSERT INTO `by_member` VALUES ('62', '13816204242', '1', '0', '0', '2016-09-08 06:53:17', '1', null, null, null, null, null, '62');
INSERT INTO `by_member` VALUES ('63', '15201751067', '1', '0', '0', '2016-09-08 06:58:12', '1', null, null, null, null, null, '63');
INSERT INTO `by_member` VALUES ('64', '13816761995', '1', '0', '0', '2016-09-08 07:06:50', '1', null, null, null, null, null, '64');
INSERT INTO `by_member` VALUES ('65', '13601605245', '1', '0', '0', '2016-09-08 07:13:38', '1', null, null, null, null, null, '65');
INSERT INTO `by_member` VALUES ('66', '13651919731', '1', '0', '0', '2016-09-08 07:30:02', '1', null, null, null, null, null, '66');
INSERT INTO `by_member` VALUES ('67', '13621848733', '1', '0', '0', '2016-09-08 07:30:13', '1', null, null, null, null, null, '67');
INSERT INTO `by_member` VALUES ('68', '18016003788', '1', '0', '0', '2016-09-08 08:02:58', '1', null, null, null, null, null, '68');
INSERT INTO `by_member` VALUES ('69', '13817833217', '1', '0', '0', '2016-09-08 08:18:05', '1', null, null, null, null, null, '69');
INSERT INTO `by_member` VALUES ('70', '13386090105', '1', '0', '0', '2016-09-08 08:21:49', '1', null, null, null, null, null, '70');
INSERT INTO `by_member` VALUES ('71', '13611706507', '1', '0', '0', '2016-09-08 08:46:15', '1', null, null, null, null, null, '71');
INSERT INTO `by_member` VALUES ('72', '13651928902', '1', '0', '0', '2016-09-08 09:01:42', '1', null, null, null, null, null, '72');
INSERT INTO `by_member` VALUES ('73', '15900515970', '1', '0', '0', '2016-09-08 09:04:34', '1', null, null, null, null, null, '73');
INSERT INTO `by_member` VALUES ('74', '13918309395', '1', '0', '0', '2016-09-08 09:08:13', '1', null, null, null, null, null, '74');
INSERT INTO `by_member` VALUES ('75', '13564705251', '1', '0', '0', '2016-09-08 09:12:13', '1', null, null, null, null, null, '75');
INSERT INTO `by_member` VALUES ('76', '13482377372', '1', '0', '0', '2016-09-08 09:22:31', '1', null, null, null, null, null, '76');
INSERT INTO `by_member` VALUES ('77', '13501970340', '1', '0', '0', '2016-09-08 09:30:28', '1', null, null, null, null, null, '77');
INSERT INTO `by_member` VALUES ('78', '13918319839', '1', '0', '0', '2016-09-08 09:30:56', '1', null, null, null, null, null, '78');
INSERT INTO `by_member` VALUES ('79', '17749730540', '1', '0', '0', '2016-09-08 09:34:32', '1', null, null, null, null, null, '79');
INSERT INTO `by_member` VALUES ('80', '18616206817', '1', '0', '0', '2016-09-08 09:35:28', '1', null, null, null, null, null, '80');
INSERT INTO `by_member` VALUES ('81', '13917200952', '1', '0', '0', '2016-09-08 09:56:28', '1', null, null, null, null, null, '81');
INSERT INTO `by_member` VALUES ('82', '18621619335', '1', '0', '0', '2016-09-08 09:58:24', '1', null, null, null, null, null, '82');
INSERT INTO `by_member` VALUES ('83', '13524203280', '1', '0', '0', '2016-09-08 09:59:09', '1', null, null, null, null, null, '83');
INSERT INTO `by_member` VALUES ('84', '13816571577', '1', '0', '0', '2016-09-08 10:17:08', '1', null, null, null, null, null, '84');
INSERT INTO `by_member` VALUES ('85', '13918301033', '1', '0', '0', '2016-09-08 10:20:42', '1', null, null, null, null, null, '85');
INSERT INTO `by_member` VALUES ('86', '13512177550', '1', '0', '0', '2016-09-08 10:44:32', '1', null, null, null, null, null, '86');
INSERT INTO `by_member` VALUES ('87', '13917136917', '1', '0', '0', '2016-09-08 10:46:15', '1', null, null, null, null, null, '87');
INSERT INTO `by_member` VALUES ('88', '18321938925', '1', '0', '0', '2016-09-08 10:50:52', '1', null, null, null, null, null, '88');
INSERT INTO `by_member` VALUES ('89', '13661940330', '1', '0', '0', '2016-09-08 10:52:15', '1', null, null, null, null, null, '89');
INSERT INTO `by_member` VALUES ('90', '13916184011', '1', '0', '0', '2016-09-08 10:56:34', '1', null, null, null, null, null, '90');
INSERT INTO `by_member` VALUES ('91', '13774276810', '1', '0', '0', '2016-09-08 10:59:39', '1', null, null, null, null, null, '91');
INSERT INTO `by_member` VALUES ('92', '18918619197', '1', '0', '0', '2016-09-08 11:03:00', '1', null, null, null, null, null, '92');
INSERT INTO `by_member` VALUES ('93', '13917887129', '1', '0', '0', '2016-09-08 11:03:14', '1', null, null, null, null, null, '93');
INSERT INTO `by_member` VALUES ('94', '15801737311', '1', '0', '0', '2016-09-08 11:04:41', '1', null, null, null, null, null, '94');
INSERT INTO `by_member` VALUES ('95', '15821857881', '1', '0', '0', '2016-09-08 11:11:31', '1', null, null, null, null, null, '95');
INSERT INTO `by_member` VALUES ('96', '13816071451', '1', '0', '0', '2016-09-08 11:21:20', '1', null, null, null, null, null, '96');
INSERT INTO `by_member` VALUES ('97', '13585779111', '1', '0', '0', '2016-09-08 11:21:47', '1', null, null, null, null, null, '97');
INSERT INTO `by_member` VALUES ('98', '18721349519', '1', '0', '0', '2016-09-08 11:24:37', '1', null, null, null, null, null, '98');
INSERT INTO `by_member` VALUES ('99', '13764807189', '1', '0', '0', '2016-09-08 11:39:30', '1', null, null, null, null, null, '99');
INSERT INTO `by_member` VALUES ('100', '18221889821', '1', '0', '0', '2016-09-08 11:50:36', '1', null, null, null, null, null, '100');
INSERT INTO `by_member` VALUES ('101', '18616051457', '1', '0', '0', '2016-09-08 11:51:26', '1', null, null, null, null, null, '101');
INSERT INTO `by_member` VALUES ('102', '13817096186', '1', '0', '0', '2016-09-08 12:01:22', '1', null, null, null, null, null, '102');
INSERT INTO `by_member` VALUES ('103', '18621117282', '1', '0', '0', '2016-09-08 12:03:02', '1', null, null, null, null, null, '103');
INSERT INTO `by_member` VALUES ('104', '13621730163', '1', '0', '0', '2016-09-08 12:03:57', '1', null, null, null, null, null, '104');
INSERT INTO `by_member` VALUES ('105', '13585922015', '1', '0', '0', '2016-09-08 12:08:04', '1', null, null, null, null, null, '105');
INSERT INTO `by_member` VALUES ('106', '13818252412', '1', '0', '0', '2016-09-08 12:20:24', '1', null, null, null, null, null, '106');
INSERT INTO `by_member` VALUES ('107', '13564727203', '1', '0', '0', '2016-09-08 12:29:41', '1', null, null, null, null, null, '107');
INSERT INTO `by_member` VALUES ('108', '18049758315', '1', '0', '0', '2016-09-08 12:46:39', '1', null, null, null, null, null, '108');
INSERT INTO `by_member` VALUES ('109', '13916129711', '1', '0', '0', '2016-09-08 12:46:44', '1', null, null, null, null, null, '109');
INSERT INTO `by_member` VALUES ('110', '13524635820', '1', '0', '0', '2016-09-08 12:50:04', '1', null, null, null, null, null, '110');
INSERT INTO `by_member` VALUES ('111', '18521714142', '1', '0', '0', '2016-09-08 12:55:10', '1', null, null, null, null, null, '111');
INSERT INTO `by_member` VALUES ('112', '13817156376', '1', '0', '0', '2016-09-08 13:01:45', '1', null, null, null, null, null, '112');
INSERT INTO `by_member` VALUES ('113', '13127893778', '1', '0', '0', '2016-09-08 13:22:14', '1', null, null, null, null, null, '113');
INSERT INTO `by_member` VALUES ('114', '13501946600', '1', '0', '0', '2016-09-08 13:24:36', '1', null, null, null, null, null, '114');
INSERT INTO `by_member` VALUES ('115', '13512195755', '1', '0', '0', '2016-09-08 13:25:15', '1', null, null, null, null, null, '115');
INSERT INTO `by_member` VALUES ('116', '13636546214', '1', '0', '0', '2016-09-08 13:25:31', '1', null, null, null, null, null, '116');
INSERT INTO `by_member` VALUES ('117', '13564622922', '1', '0', '0', '2016-09-08 13:29:10', '1', null, null, null, null, null, '117');
INSERT INTO `by_member` VALUES ('118', '13774426269', '1', '0', '0', '2016-09-08 13:41:04', '1', null, null, null, null, null, '118');
INSERT INTO `by_member` VALUES ('119', '18521018205', '1', '0', '0', '2016-09-08 13:49:09', '1', null, null, null, null, null, '119');
INSERT INTO `by_member` VALUES ('120', '13916862344', '1', '0', '0', '2016-09-08 13:50:13', '1', null, null, null, null, null, '120');
INSERT INTO `by_member` VALUES ('121', '13671955774', '1', '0', '0', '2016-09-08 13:50:15', '1', null, null, null, null, null, '121');
INSERT INTO `by_member` VALUES ('122', '13701990618', '1', '0', '0', '2016-09-08 13:51:56', '1', null, null, null, null, null, '122');
INSERT INTO `by_member` VALUES ('123', '13817136968', '1', '0', '0', '2016-09-08 14:06:50', '1', null, null, null, null, null, '123');
INSERT INTO `by_member` VALUES ('124', '13661674208', '1', '0', '0', '2016-09-08 14:08:45', '1', null, null, null, null, null, '124');
INSERT INTO `by_member` VALUES ('125', '13795391818', '1', '0', '0', '2016-09-08 14:10:23', '1', null, null, null, null, null, '125');
INSERT INTO `by_member` VALUES ('126', '13918102293', '1', '0', '0', '2016-09-08 14:12:55', '1', null, null, null, null, null, '126');
INSERT INTO `by_member` VALUES ('127', '18964723423', '1', '0', '0', '2016-09-08 14:31:05', '1', null, null, null, null, null, '127');
INSERT INTO `by_member` VALUES ('128', '13917852124', '1', '0', '0', '2016-09-08 14:34:42', '1', null, null, null, null, null, '128');
INSERT INTO `by_member` VALUES ('129', '13482684774', '1', '0', '0', '2016-09-08 14:38:19', '1', null, null, null, null, null, '129');
INSERT INTO `by_member` VALUES ('130', '18916792560', '1', '0', '0', '2016-09-08 14:39:17', '1', null, null, null, null, null, '130');
INSERT INTO `by_member` VALUES ('131', '15601872379', '1', '0', '0', '2016-09-08 14:41:48', '1', null, null, null, null, null, '131');
INSERT INTO `by_member` VALUES ('132', '13564461216', '1', '0', '0', '2016-09-08 14:55:54', '1', null, null, null, null, null, '132');
INSERT INTO `by_member` VALUES ('133', '18116020504', '1', '0', '0', '2016-09-08 15:01:18', '1', null, null, null, null, null, '133');
INSERT INTO `by_member` VALUES ('134', '18621581922', '1', '0', '0', '2016-09-08 15:01:39', '1', null, null, null, null, null, '134');
INSERT INTO `by_member` VALUES ('135', '15801848516', '1', '0', '0', '2016-09-08 15:10:30', '1', null, null, null, null, null, '135');
INSERT INTO `by_member` VALUES ('136', '13651744115', '1', '0', '0', '2016-09-08 15:18:40', '1', null, null, null, null, null, '136');
INSERT INTO `by_member` VALUES ('137', '13761747384', '1', '0', '0', '2016-09-08 15:20:06', '1', null, null, null, null, null, '137');
INSERT INTO `by_member` VALUES ('138', '13641858145', '1', '0', '0', '2016-09-08 15:35:07', '1', null, null, null, null, null, '138');
INSERT INTO `by_member` VALUES ('139', '13818891595', '1', '0', '0', '2016-09-08 15:46:32', '1', null, null, null, null, null, '139');
INSERT INTO `by_member` VALUES ('140', '13501862825', '1', '0', '0', '2016-09-08 15:58:48', '1', null, null, null, null, null, '140');
INSERT INTO `by_member` VALUES ('141', '13651735980', '1', '0', '0', '2016-09-08 16:05:59', '1', null, null, null, null, null, '141');
INSERT INTO `by_member` VALUES ('142', '15800331192', '1', '0', '0', '2016-09-08 16:16:21', '1', null, null, null, null, null, '142');
INSERT INTO `by_member` VALUES ('143', '13761828125', '1', '0', '0', '2016-09-08 16:34:29', '1', null, null, null, null, null, '143');
INSERT INTO `by_member` VALUES ('144', '18516003543', '1', '0', '0', '2016-09-08 16:35:41', '1', null, null, null, null, null, '144');
INSERT INTO `by_member` VALUES ('145', '13918402062', '1', '0', '0', '2016-09-08 17:04:12', '1', null, null, null, null, null, '145');
INSERT INTO `by_member` VALUES ('146', '13761456517', '1', '0', '0', '2016-09-08 17:11:40', '1', null, null, null, null, null, '146');
INSERT INTO `by_member` VALUES ('147', '15721517193', '1', '0', '0', '2016-09-08 17:13:02', '1', null, null, null, null, null, '147');
INSERT INTO `by_member` VALUES ('148', '13917906664', '1', '0', '0', '2016-09-08 17:14:04', '1', null, null, null, null, null, '148');
INSERT INTO `by_member` VALUES ('149', '15921794388', '1', '0', '0', '2016-09-08 17:24:23', '1', null, null, null, null, null, '149');
INSERT INTO `by_member` VALUES ('150', '13817198834', '1', '0', '0', '2016-09-08 18:10:05', '1', null, null, null, null, null, '150');
INSERT INTO `by_member` VALUES ('151', '13501983370', '1', '0', '0', '2016-09-08 18:15:45', '1', null, null, null, null, null, '151');
INSERT INTO `by_member` VALUES ('152', '13916036405', '1', '0', '0', '2016-09-08 18:17:40', '1', null, null, null, null, null, '152');
INSERT INTO `by_member` VALUES ('153', '18251855133', '1', '0', '0', '2016-09-08 18:17:49', '1', null, null, null, null, null, '153');
INSERT INTO `by_member` VALUES ('154', '13636351075', '1', '0', '0', '2016-09-08 18:18:23', '1', null, null, null, null, null, '154');
INSERT INTO `by_member` VALUES ('155', '13816318853', '1', '0', '0', '2016-09-08 18:24:01', '1', null, null, null, null, null, '155');
INSERT INTO `by_member` VALUES ('156', '13816950640', '1', '0', '0', '2016-09-08 18:24:40', '1', null, null, null, null, null, '156');
INSERT INTO `by_member` VALUES ('157', '15000349105', '1', '0', '0', '2016-09-08 18:36:28', '1', null, null, null, null, null, '157');
INSERT INTO `by_member` VALUES ('158', '13918601891', '1', '0', '0', '2016-09-08 18:42:19', '1', null, null, null, null, null, '158');
INSERT INTO `by_member` VALUES ('159', '13524691312', '1', '0', '0', '2016-09-08 18:57:20', '1', null, null, null, null, null, '159');
INSERT INTO `by_member` VALUES ('160', '13916337641', '1', '0', '0', '2016-09-08 19:02:15', '1', null, null, null, null, null, '160');
INSERT INTO `by_member` VALUES ('161', '13636681985', '1', '0', '0', '2016-09-08 19:14:36', '1', null, null, null, null, null, '161');
INSERT INTO `by_member` VALUES ('162', '13044101695', '1', '0', '0', '2016-09-08 19:28:10', '1', null, null, null, null, null, '162');
INSERT INTO `by_member` VALUES ('163', '17721388452', '1', '0', '0', '2016-09-08 19:31:00', '1', null, null, null, null, null, '163');
INSERT INTO `by_member` VALUES ('164', '15201739381', '1', '0', '0', '2016-09-08 19:36:55', '1', null, null, null, null, null, '164');
INSERT INTO `by_member` VALUES ('165', '13916048489', '1', '0', '0', '2016-09-08 19:42:05', '1', null, null, null, null, null, '165');
INSERT INTO `by_member` VALUES ('166', '13501820934', '1', '0', '0', '2016-09-08 19:45:49', '1', null, null, null, null, null, '166');
INSERT INTO `by_member` VALUES ('167', '13917942276', '1', '0', '0', '2016-09-08 19:45:53', '1', null, null, null, null, null, '167');
INSERT INTO `by_member` VALUES ('168', '15618331805', '1', '0', '0', '2016-09-08 19:57:42', '1', null, null, null, null, null, '168');
INSERT INTO `by_member` VALUES ('169', '18601711411', '1', '0', '0', '2016-09-08 20:00:58', '1', null, null, null, null, null, '169');
INSERT INTO `by_member` VALUES ('170', '18767272232', '1', '0', '0', '2016-09-08 20:02:39', '1', null, null, null, null, null, '170');
INSERT INTO `by_member` VALUES ('171', '13564204390', '1', '0', '0', '2016-09-08 20:07:53', '1', null, null, null, null, null, '171');
INSERT INTO `by_member` VALUES ('172', '13621941358', '1', '0', '0', '2016-09-08 20:11:40', '1', null, null, null, null, null, '172');
INSERT INTO `by_member` VALUES ('173', '15221500396', '1', '0', '0', '2016-09-08 20:17:18', '1', null, null, null, null, null, '173');
INSERT INTO `by_member` VALUES ('174', '13764259315', '1', '0', '0', '2016-09-08 20:37:32', '1', null, null, null, null, null, '174');
INSERT INTO `by_member` VALUES ('175', '13764685139', '1', '0', '0', '2016-09-08 20:45:14', '1', null, null, null, null, null, '175');
INSERT INTO `by_member` VALUES ('176', '13816028621', '1', '0', '0', '2016-09-08 20:57:23', '1', null, null, null, null, null, '176');
INSERT INTO `by_member` VALUES ('177', '13371920805', '1', '0', '0', '2016-09-08 20:58:02', '1', null, null, null, null, null, '177');
INSERT INTO `by_member` VALUES ('178', '13764528246', '1', '0', '0', '2016-09-08 21:03:22', '1', null, null, null, null, null, '178');
INSERT INTO `by_member` VALUES ('179', '13636696528', '1', '0', '0', '2016-09-08 21:15:24', '1', null, null, null, null, null, '179');
INSERT INTO `by_member` VALUES ('180', '13764850497', '1', '0', '0', '2016-09-08 21:35:05', '1', null, null, null, null, null, '180');
INSERT INTO `by_member` VALUES ('181', '15901626362', '1', '0', '0', '2016-09-08 21:37:44', '1', null, null, null, null, null, '181');
INSERT INTO `by_member` VALUES ('182', '13661793499', '1', '0', '0', '2016-09-08 21:40:24', '1', null, null, null, null, null, '182');
INSERT INTO `by_member` VALUES ('183', '13166213942', '1', '0', '0', '2016-09-08 21:49:33', '1', null, null, null, null, null, '183');
INSERT INTO `by_member` VALUES ('184', '18930911215', '1', '0', '0', '2016-09-08 21:52:47', '1', null, null, null, null, null, '184');
INSERT INTO `by_member` VALUES ('185', '13301862311', '1', '0', '0', '2016-09-08 21:54:50', '1', null, null, null, null, null, '185');
INSERT INTO `by_member` VALUES ('186', '13818757485', '1', '0', '0', '2016-09-08 21:55:51', '1', null, null, null, null, null, '186');
INSERT INTO `by_member` VALUES ('187', '13601708009', '1', '0', '0', '2016-09-08 21:59:38', '1', null, null, null, null, null, '187');
INSERT INTO `by_member` VALUES ('188', '13636355299', '1', '0', '0', '2016-09-08 22:03:44', '1', null, null, null, null, null, '188');
INSERT INTO `by_member` VALUES ('189', '13818987668', '1', '0', '0', '2016-09-08 22:24:54', '1', null, null, null, null, null, '189');
INSERT INTO `by_member` VALUES ('190', '13795476726', '1', '0', '0', '2016-09-08 22:49:30', '1', null, null, null, null, null, '190');
INSERT INTO `by_member` VALUES ('191', '18721187175', '1', '0', '0', '2016-09-08 22:52:22', '1', null, null, null, null, null, '191');
INSERT INTO `by_member` VALUES ('192', '13524658972', '1', '0', '0', '2016-09-08 22:58:05', '1', null, null, null, null, null, '192');
INSERT INTO `by_member` VALUES ('193', '15026940885', '1', '0', '0', '2016-09-08 23:03:21', '1', null, null, null, null, null, '193');
INSERT INTO `by_member` VALUES ('194', '18217167838', '1', '0', '0', '2016-09-08 23:08:28', '1', null, null, null, null, null, '194');
INSERT INTO `by_member` VALUES ('195', '13651870775', '1', '0', '0', '2016-09-08 23:11:04', '1', null, null, null, null, null, '195');
INSERT INTO `by_member` VALUES ('196', '18802153839', '1', '0', '0', '2016-09-08 23:41:57', '1', null, null, null, null, null, '196');
INSERT INTO `by_member` VALUES ('197', '13818922558', '1', '0', '0', '2016-09-09 00:26:24', '1', null, null, null, null, null, '197');
INSERT INTO `by_member` VALUES ('198', '13774489524', '1', '0', '0', '2016-09-09 01:44:21', '1', null, null, null, null, null, '198');
INSERT INTO `by_member` VALUES ('199', '13818491314', '1', '0', '0', '2016-09-09 02:51:29', '1', null, null, null, null, null, '199');
INSERT INTO `by_member` VALUES ('200', '18516515809', '1', '0', '0', '2016-09-09 06:29:25', '1', null, null, null, null, null, '200');
INSERT INTO `by_member` VALUES ('201', '13795396076', '1', '0', '0', '2016-09-09 06:49:14', '1', null, null, null, null, null, '201');
INSERT INTO `by_member` VALUES ('202', '13917156507', '1', '0', '0', '2016-09-09 07:03:38', '1', null, null, null, null, null, '202');
INSERT INTO `by_member` VALUES ('203', '13042159951', '1', '0', '0', '2016-09-09 07:13:30', '1', null, null, null, null, null, '203');
INSERT INTO `by_member` VALUES ('204', '15692127211', '1', '0', '0', '2016-09-09 07:16:07', '1', null, null, null, null, null, '204');
INSERT INTO `by_member` VALUES ('205', '13472441105', '1', '0', '0', '2016-09-09 07:20:35', '1', null, null, null, null, null, '205');
INSERT INTO `by_member` VALUES ('206', '15821915060', '1', '0', '0', '2016-09-09 07:41:09', '1', null, null, null, null, null, '206');
INSERT INTO `by_member` VALUES ('207', '18019177209', '1', '0', '0', '2016-09-09 07:45:34', '1', null, null, null, null, null, '207');
INSERT INTO `by_member` VALUES ('208', '18521706220', '1', '0', '0', '2016-09-09 08:19:34', '1', null, null, null, null, null, '208');
INSERT INTO `by_member` VALUES ('209', '15921778232', '1', '0', '0', '2016-09-09 09:07:57', '1', null, null, null, null, null, '209');
INSERT INTO `by_member` VALUES ('210', '13818610121', '1', '0', '0', '2016-09-09 09:41:46', '1', null, null, null, null, null, '210');
INSERT INTO `by_member` VALUES ('211', '13916868757', '1', '0', '0', '2016-09-09 09:43:36', '1', null, null, null, null, null, '211');
INSERT INTO `by_member` VALUES ('212', '13818128136', '1', '0', '0', '2016-09-09 09:49:12', '1', null, null, null, null, null, '212');
INSERT INTO `by_member` VALUES ('213', '13917526755', '1', '0', '0', '2016-09-09 10:02:42', '1', null, null, null, null, null, '213');
INSERT INTO `by_member` VALUES ('214', '13817555043', '1', '0', '0', '2016-09-09 10:04:42', '1', null, null, null, null, null, '214');
INSERT INTO `by_member` VALUES ('215', '13032100729', '1', '0', '0', '2016-09-09 10:11:51', '1', null, null, null, null, null, '215');
INSERT INTO `by_member` VALUES ('216', '13661813904', '1', '0', '0', '2016-09-09 11:13:04', '1', null, null, null, null, null, '216');
INSERT INTO `by_member` VALUES ('217', '13916107182', '1', '0', '0', '2016-09-09 11:18:46', '1', null, null, null, null, null, '217');
INSERT INTO `by_member` VALUES ('218', '13801847071', '1', '0', '0', '2016-09-09 11:21:44', '1', null, null, null, null, null, '218');
INSERT INTO `by_member` VALUES ('219', '13122001905', '1', '0', '0', '2016-09-09 11:23:17', '1', null, null, null, null, null, '219');
INSERT INTO `by_member` VALUES ('220', '18616020269', '1', '0', '0', '2016-09-09 11:31:16', '1', null, null, null, null, null, '220');
INSERT INTO `by_member` VALUES ('221', '13661551912', '1', '0', '0', '2016-09-09 11:42:30', '1', null, null, null, null, null, '221');
INSERT INTO `by_member` VALUES ('222', '13918760950', '1', '0', '0', '2016-09-09 11:52:37', '1', null, null, null, null, null, '222');
INSERT INTO `by_member` VALUES ('223', '13916985086', '1', '0', '0', '2016-09-09 12:11:17', '1', null, null, null, null, null, '223');
INSERT INTO `by_member` VALUES ('224', '18917506190', '1', '0', '0', '2016-09-09 12:19:25', '1', null, null, null, null, null, '224');
INSERT INTO `by_member` VALUES ('225', '13641991934', '1', '0', '0', '2016-09-09 12:27:48', '1', null, null, null, null, null, '225');
INSERT INTO `by_member` VALUES ('226', '13818826628', '1', '0', '0', '2016-09-09 12:31:35', '1', null, null, null, null, null, '226');
INSERT INTO `by_member` VALUES ('227', '13671753133', '1', '0', '0', '2016-09-09 14:04:58', '1', null, null, null, null, null, '227');
INSERT INTO `by_member` VALUES ('228', '13818619296', '1', '0', '0', '2016-09-09 14:20:21', '1', null, null, null, null, null, '228');
INSERT INTO `by_member` VALUES ('229', '13818159462', '1', '0', '0', '2016-09-09 14:34:55', '1', null, null, null, null, null, '229');
INSERT INTO `by_member` VALUES ('230', '18019088515', '1', '0', '0', '2016-09-09 15:08:36', '1', null, null, null, null, null, '230');
INSERT INTO `by_member` VALUES ('231', '15821892631', '1', '0', '0', '2016-09-09 15:47:30', '1', null, null, null, null, null, '231');
INSERT INTO `by_member` VALUES ('232', '13917074260', '1', '0', '0', '2016-09-09 15:53:58', '1', null, null, null, null, null, '232');
INSERT INTO `by_member` VALUES ('233', '13901965811', '1', '0', '0', '2016-09-09 16:53:58', '1', null, null, null, null, null, '233');
INSERT INTO `by_member` VALUES ('234', '18601676435', '1', '0', '0', '2016-09-09 17:15:43', '1', null, null, null, null, null, '234');
INSERT INTO `by_member` VALUES ('235', '13818126718', '1', '0', '0', '2016-09-09 17:59:00', '1', null, null, null, null, null, '235');
INSERT INTO `by_member` VALUES ('236', '13262812083', '1', '0', '0', '2016-09-09 18:45:29', '1', null, null, null, null, null, '236');
INSERT INTO `by_member` VALUES ('237', '18918560390', '1', '0', '0', '2016-09-09 19:01:30', '1', null, null, null, null, null, '237');
INSERT INTO `by_member` VALUES ('238', '13917454678', '1', '0', '0', '2016-09-09 19:16:59', '1', null, null, null, null, null, '238');
INSERT INTO `by_member` VALUES ('239', '13795408876', '1', '0', '0', '2016-09-09 19:34:29', '1', null, null, null, null, null, '239');
INSERT INTO `by_member` VALUES ('240', '13061600782', '1', '0', '0', '2016-09-09 19:39:37', '1', null, null, null, null, null, '240');
INSERT INTO `by_member` VALUES ('241', '13817979433', '1', '0', '0', '2016-09-09 19:49:42', '1', null, null, null, null, null, '241');
INSERT INTO `by_member` VALUES ('242', '15001732986', '1', '0', '0', '2016-09-09 19:54:46', '1', null, null, null, null, null, '242');
INSERT INTO `by_member` VALUES ('243', '13761429396', '1', '0', '0', '2016-09-09 19:56:01', '1', null, null, null, null, null, '243');
INSERT INTO `by_member` VALUES ('244', '13564191847', '1', '0', '0', '2016-09-09 20:26:42', '1', null, null, null, null, null, '244');
INSERT INTO `by_member` VALUES ('245', '13761100699', '1', '0', '0', '2016-09-09 20:43:37', '1', null, null, null, null, null, '245');
INSERT INTO `by_member` VALUES ('246', '18017399652', '1', '0', '0', '2016-09-09 21:42:33', '1', null, null, null, null, null, '246');
INSERT INTO `by_member` VALUES ('247', '13482686355', '1', '0', '0', '2016-09-09 22:06:07', '1', null, null, null, null, null, '247');
INSERT INTO `by_member` VALUES ('248', '13916816915', '1', '0', '0', '2016-09-09 22:23:51', '1', null, null, null, null, null, '248');
INSERT INTO `by_member` VALUES ('249', '13817623881', '1', '0', '0', '2016-09-10 07:38:37', '1', null, null, null, null, null, '249');
INSERT INTO `by_member` VALUES ('250', '15900779306', '1', '0', '0', '2016-09-10 08:24:59', '1', null, null, null, null, null, '250');
INSERT INTO `by_member` VALUES ('251', '13661552855', '1', '0', '0', '2016-09-10 08:48:05', '1', null, null, null, null, null, '251');
INSERT INTO `by_member` VALUES ('252', '13816803273', '1', '0', '0', '2016-09-10 09:38:52', '1', null, null, null, null, null, '252');
INSERT INTO `by_member` VALUES ('253', '13524416890', '1', '0', '0', '2016-09-10 09:59:19', '1', null, null, null, null, null, '253');
INSERT INTO `by_member` VALUES ('254', '13917805293', '1', '0', '0', '2016-09-10 11:07:29', '1', null, null, null, null, null, '254');
INSERT INTO `by_member` VALUES ('255', '18117167867', '1', '0', '0', '2016-09-10 11:39:04', '1', null, null, null, null, null, '255');
INSERT INTO `by_member` VALUES ('256', '13916725495', '1', '0', '0', '2016-09-10 12:07:56', '1', null, null, null, null, null, '256');
INSERT INTO `by_member` VALUES ('257', '15921133541', '1', '0', '0', '2016-09-10 12:19:35', '1', null, null, null, null, null, '257');
INSERT INTO `by_member` VALUES ('258', '13661760117', '1', '0', '0', '2016-09-10 12:44:48', '1', null, null, null, null, null, '258');
INSERT INTO `by_member` VALUES ('259', '18217242592', '1', '0', '0', '2016-09-10 13:28:48', '1', null, null, null, null, null, '259');
INSERT INTO `by_member` VALUES ('260', '18717703137', '1', '0', '0', '2016-09-10 13:50:19', '1', null, null, null, null, null, '260');
INSERT INTO `by_member` VALUES ('261', '17717345933', '1', '0', '0', '2016-09-10 14:21:50', '1', null, null, null, null, null, '261');
INSERT INTO `by_member` VALUES ('262', '13761984551', '1', '0', '0', '2016-09-10 14:37:56', '1', null, null, null, null, null, '262');
INSERT INTO `by_member` VALUES ('263', '13761007647', '1', '0', '0', '2016-09-10 14:38:58', '1', null, null, null, null, null, '263');
INSERT INTO `by_member` VALUES ('264', '13651774275', '1', '0', '0', '2016-09-10 14:46:10', '1', null, null, null, null, null, '264');
INSERT INTO `by_member` VALUES ('265', '15550930553', '1', '0', '0', '2016-09-10 14:59:23', '1', null, null, null, null, null, '265');
INSERT INTO `by_member` VALUES ('266', '13524512939', '1', '0', '0', '2016-09-10 15:50:05', '1', null, null, null, null, null, '266');
INSERT INTO `by_member` VALUES ('267', '13816045385', '1', '0', '0', '2016-09-10 16:14:06', '1', null, null, null, null, null, '267');
INSERT INTO `by_member` VALUES ('268', '13482265720', '1', '0', '0', '2016-09-10 16:20:59', '1', null, null, null, null, null, '268');
INSERT INTO `by_member` VALUES ('269', '15821908890', '1', '0', '0', '2016-09-10 16:27:13', '1', null, null, null, null, null, '269');
INSERT INTO `by_member` VALUES ('270', '13918008232', '1', '0', '0', '2016-09-10 16:39:22', '1', null, null, null, null, null, '270');
INSERT INTO `by_member` VALUES ('271', '13501897841', '1', '0', '0', '2016-09-10 16:42:28', '1', null, null, null, null, null, '271');
INSERT INTO `by_member` VALUES ('272', '13764500607', '1', '0', '0', '2016-09-10 17:02:09', '1', null, null, null, null, null, '272');
INSERT INTO `by_member` VALUES ('273', '13918821062', '1', '0', '0', '2016-09-10 17:03:16', '1', null, null, null, null, null, '273');
INSERT INTO `by_member` VALUES ('274', '13817968178', '1', '0', '0', '2016-09-10 17:03:37', '1', null, null, null, null, null, '274');
INSERT INTO `by_member` VALUES ('275', '13816137843', '1', '0', '0', '2016-09-10 17:36:50', '1', null, null, null, null, null, '275');
INSERT INTO `by_member` VALUES ('276', '13817435990', '1', '0', '0', '2016-09-10 18:07:31', '1', null, null, null, null, null, '276');
INSERT INTO `by_member` VALUES ('277', '13661855651', '1', '0', '0', '2016-09-10 18:45:57', '1', null, null, null, null, null, '277');
INSERT INTO `by_member` VALUES ('278', '15242339670', '1', '0', '0', '2016-09-10 18:54:32', '1', null, null, null, null, null, '278');
INSERT INTO `by_member` VALUES ('279', '15068582332', '1', '0', '0', '2016-09-10 19:16:11', '1', null, null, null, null, null, '279');
INSERT INTO `by_member` VALUES ('280', '18910582956', '1', '0', '0', '2016-09-10 19:17:11', '1', null, null, null, null, null, '280');
INSERT INTO `by_member` VALUES ('281', '13818093882', '1', '0', '0', '2016-09-10 19:42:22', '1', null, null, null, null, null, '281');
INSERT INTO `by_member` VALUES ('282', '13311920170', '1', '0', '0', '2016-09-10 19:49:53', '1', null, null, null, null, null, '282');
INSERT INTO `by_member` VALUES ('283', '13916977933', '1', '0', '0', '2016-09-10 20:10:51', '1', null, null, null, null, null, '283');
INSERT INTO `by_member` VALUES ('284', '13621875705', '1', '0', '0', '2016-09-10 20:13:18', '1', null, null, null, null, null, '284');
INSERT INTO `by_member` VALUES ('285', '13162862972', '1', '0', '0', '2016-09-10 20:25:38', '1', null, null, null, null, null, '285');
INSERT INTO `by_member` VALUES ('286', '13023186775', '1', '0', '0', '2016-09-10 20:31:43', '1', null, null, null, null, null, '286');
INSERT INTO `by_member` VALUES ('287', '13641972053', '1', '0', '0', '2016-09-10 20:34:43', '1', null, null, null, null, null, '287');
INSERT INTO `by_member` VALUES ('288', '18916770118', '1', '0', '0', '2016-09-10 21:15:56', '1', null, null, null, null, null, '288');
INSERT INTO `by_member` VALUES ('289', '13917292305', '1', '0', '0', '2016-09-10 21:41:15', '1', null, null, null, null, null, '289');
INSERT INTO `by_member` VALUES ('290', '18616541526', '1', '0', '0', '2016-09-10 21:46:13', '1', null, null, null, null, null, '290');
INSERT INTO `by_member` VALUES ('291', '13501709216', '1', '0', '0', '2016-09-10 22:17:47', '1', null, null, null, null, null, '291');
INSERT INTO `by_member` VALUES ('292', '13918068227', '1', '0', '0', '2016-09-10 22:20:56', '1', null, null, null, null, null, '292');
INSERT INTO `by_member` VALUES ('293', '13764531944', '1', '0', '0', '2016-09-10 22:31:06', '1', null, null, null, null, null, '293');
INSERT INTO `by_member` VALUES ('294', '13391009878', '1', '0', '0', '2016-09-10 22:31:35', '1', null, null, null, null, null, '294');
INSERT INTO `by_member` VALUES ('295', '13816756511', '1', '0', '0', '2016-09-11 00:47:11', '1', null, null, null, null, null, '295');
INSERT INTO `by_member` VALUES ('296', '13611650868', '1', '0', '0', '2016-09-11 08:22:01', '1', null, null, null, null, null, '296');
INSERT INTO `by_member` VALUES ('297', '13472492337', '1', '0', '0', '2016-09-11 08:59:09', '1', null, null, null, null, null, '297');
INSERT INTO `by_member` VALUES ('298', '15021959027', '1', '0', '0', '2016-09-11 09:27:57', '1', null, null, null, null, null, '298');
INSERT INTO `by_member` VALUES ('299', '17701716212', '1', '0', '0', '2016-09-11 09:54:24', '1', null, null, null, null, null, '299');
INSERT INTO `by_member` VALUES ('300', '13661557283', '1', '0', '0', '2016-09-11 09:57:17', '1', null, null, null, null, null, '300');
INSERT INTO `by_member` VALUES ('301', '18217721503', '1', '0', '0', '2016-09-11 10:56:24', '1', null, null, null, null, null, '301');
INSERT INTO `by_member` VALUES ('302', '18801963441', '1', '0', '0', '2016-09-11 11:36:55', '1', null, null, null, null, null, '302');
INSERT INTO `by_member` VALUES ('303', '13636554871', '1', '0', '0', '2016-09-11 11:47:08', '1', null, null, null, null, null, '303');
INSERT INTO `by_member` VALUES ('304', '15221530659', '1', '0', '0', '2016-09-11 11:56:42', '1', null, null, null, null, null, '304');
INSERT INTO `by_member` VALUES ('305', '13501633390', '1', '0', '0', '2016-09-11 12:04:29', '1', null, null, null, null, null, '305');
INSERT INTO `by_member` VALUES ('306', '13901900611', '1', '0', '0', '2016-09-11 12:28:37', '1', null, null, null, null, null, '306');
INSERT INTO `by_member` VALUES ('307', '13501806761', '1', '0', '0', '2016-09-11 12:30:48', '1', null, null, null, null, null, '307');
INSERT INTO `by_member` VALUES ('308', '17701605298', '1', '0', '0', '2016-09-11 13:03:27', '1', null, null, null, null, null, '308');
INSERT INTO `by_member` VALUES ('309', '13601876593', '1', '0', '0', '2016-09-11 13:10:38', '1', null, null, null, null, null, '309');
INSERT INTO `by_member` VALUES ('310', '13641940182', '1', '0', '0', '2016-09-11 14:11:59', '1', null, null, null, null, null, '310');
INSERT INTO `by_member` VALUES ('311', '13916987806', '1', '0', '0', '2016-09-11 14:13:52', '1', null, null, null, null, null, '311');
INSERT INTO `by_member` VALUES ('312', '15921418701', '1', '0', '0', '2016-09-11 14:27:34', '1', null, null, null, null, null, '312');
INSERT INTO `by_member` VALUES ('313', '13501987354', '1', '0', '0', '2016-09-11 14:28:56', '1', null, null, null, null, null, '313');
INSERT INTO `by_member` VALUES ('314', '15821200156', '1', '0', '0', '2016-09-11 15:24:55', '1', null, null, null, null, null, '314');
INSERT INTO `by_member` VALUES ('315', '13524150750', '1', '0', '0', '2016-09-11 15:36:09', '1', null, null, null, null, null, '315');
INSERT INTO `by_member` VALUES ('316', '13636324098', '1', '0', '0', '2016-09-11 16:29:21', '1', null, null, null, null, null, '316');
INSERT INTO `by_member` VALUES ('317', '13764171527', '1', '0', '0', '2016-09-11 16:58:40', '1', null, null, null, null, null, '317');
INSERT INTO `by_member` VALUES ('318', '15921210016', '1', '0', '0', '2016-09-11 17:04:44', '1', null, null, null, null, null, '318');
INSERT INTO `by_member` VALUES ('319', '15900499943', '1', '0', '0', '2016-09-11 17:50:54', '1', null, null, null, null, null, '319');
INSERT INTO `by_member` VALUES ('320', '15800817687', '1', '0', '0', '2016-09-11 18:02:56', '1', null, null, null, null, null, '320');
INSERT INTO `by_member` VALUES ('321', '13817908136', '1', '0', '0', '2016-09-11 18:30:09', '1', null, null, null, null, null, '321');
INSERT INTO `by_member` VALUES ('322', '13636620523', '1', '0', '0', '2016-09-11 18:43:16', '1', null, null, null, null, null, '322');
INSERT INTO `by_member` VALUES ('323', '13916945112', '1', '0', '0', '2016-09-11 20:02:55', '1', null, null, null, null, null, '323');
INSERT INTO `by_member` VALUES ('324', '13386019232', '1', '0', '0', '2016-09-11 20:17:00', '1', null, null, null, null, null, '324');
INSERT INTO `by_member` VALUES ('325', '13917049114', '1', '0', '0', '2016-09-11 20:36:08', '1', null, null, null, null, null, '325');
INSERT INTO `by_member` VALUES ('326', '13795493282', '1', '0', '0', '2016-09-11 20:36:52', '1', null, null, null, null, null, '326');
INSERT INTO `by_member` VALUES ('327', '13052018489', '1', '0', '0', '2016-09-11 20:37:17', '1', null, null, null, null, null, '327');
INSERT INTO `by_member` VALUES ('328', '13501911434', '1', '0', '0', '2016-09-11 20:37:53', '1', null, null, null, null, null, '328');
INSERT INTO `by_member` VALUES ('329', '13501739681', '1', '0', '0', '2016-09-11 20:38:46', '1', null, null, null, null, null, '329');
INSERT INTO `by_member` VALUES ('330', '13564612045', '1', '0', '0', '2016-09-11 20:39:39', '1', null, null, null, null, null, '330');
INSERT INTO `by_member` VALUES ('331', '13671727033', '1', '0', '0', '2016-09-11 20:39:44', '1', null, null, null, null, null, '331');
INSERT INTO `by_member` VALUES ('332', '13816715937', '1', '0', '0', '2016-09-11 20:40:21', '1', null, null, null, null, null, '332');
INSERT INTO `by_member` VALUES ('333', '15800631393', '1', '0', '0', '2016-09-11 20:42:00', '1', null, null, null, null, null, '333');
INSERT INTO `by_member` VALUES ('334', '13918095470', '1', '0', '0', '2016-09-11 20:43:55', '1', null, null, null, null, null, '334');
INSERT INTO `by_member` VALUES ('335', '13701657159', '1', '0', '0', '2016-09-11 20:45:59', '1', null, null, null, null, null, '335');
INSERT INTO `by_member` VALUES ('336', '15000633751', '1', '0', '0', '2016-09-11 20:46:20', '1', null, null, null, null, null, '336');
INSERT INTO `by_member` VALUES ('337', '13774237828', '1', '0', '0', '2016-09-11 20:46:54', '1', null, null, null, null, null, '337');
INSERT INTO `by_member` VALUES ('338', '13818371073', '1', '0', '0', '2016-09-11 20:47:04', '1', null, null, null, null, null, '338');
INSERT INTO `by_member` VALUES ('339', '13701807390', '1', '0', '0', '2016-09-11 20:47:23', '1', null, null, null, null, null, '339');
INSERT INTO `by_member` VALUES ('340', '13472704224', '1', '0', '0', '2016-09-11 20:47:43', '1', null, null, null, null, null, '340');
INSERT INTO `by_member` VALUES ('341', '13764434672', '1', '0', '0', '2016-09-11 20:47:58', '1', null, null, null, null, null, '341');
INSERT INTO `by_member` VALUES ('342', '13564899260', '1', '0', '0', '2016-09-11 20:48:16', '1', null, null, null, null, null, '342');
INSERT INTO `by_member` VALUES ('343', '13918348107', '1', '0', '0', '2016-09-11 20:49:07', '1', null, null, null, null, null, '343');
INSERT INTO `by_member` VALUES ('344', '13482446864', '1', '0', '0', '2016-09-11 20:49:07', '1', null, null, null, null, null, '344');
INSERT INTO `by_member` VALUES ('345', '13651692327', '1', '0', '0', '2016-09-11 20:49:16', '1', null, null, null, null, null, '345');
INSERT INTO `by_member` VALUES ('346', '13795462133', '1', '0', '0', '2016-09-11 20:50:25', '1', null, null, null, null, null, '346');
INSERT INTO `by_member` VALUES ('347', '15921957489', '1', '0', '0', '2016-09-11 20:51:11', '1', null, null, null, null, null, '347');
INSERT INTO `by_member` VALUES ('348', '13524527870', '1', '0', '0', '2016-09-11 20:54:09', '1', null, null, null, null, null, '348');
INSERT INTO `by_member` VALUES ('349', '18017175678', '1', '0', '0', '2016-09-11 20:54:12', '1', null, null, null, null, null, '349');
INSERT INTO `by_member` VALUES ('350', '18621186533', '1', '0', '0', '2016-09-11 20:56:27', '1', null, null, null, null, null, '350');
INSERT INTO `by_member` VALUES ('351', '15000373619', '1', '0', '0', '2016-09-11 20:58:30', '1', null, null, null, null, null, '351');
INSERT INTO `by_member` VALUES ('352', '18916776680', '1', '0', '0', '2016-09-11 20:59:01', '1', null, null, null, null, null, '352');
INSERT INTO `by_member` VALUES ('353', '18501638772', '1', '0', '0', '2016-09-11 21:02:23', '1', null, null, null, null, null, '353');
INSERT INTO `by_member` VALUES ('354', '18918811331', '1', '0', '0', '2016-09-11 21:04:18', '1', null, null, null, null, null, '354');
INSERT INTO `by_member` VALUES ('355', '18939921513', '1', '0', '0', '2016-09-11 21:10:06', '1', null, null, null, null, null, '355');
INSERT INTO `by_member` VALUES ('356', '18621180012', '1', '0', '0', '2016-09-11 21:10:15', '1', null, null, null, null, null, '356');
INSERT INTO `by_member` VALUES ('357', '13701905362', '1', '0', '0', '2016-09-11 21:14:07', '1', null, null, null, null, null, '357');
INSERT INTO `by_member` VALUES ('358', '13564532821', '1', '0', '0', '2016-09-11 21:15:06', '1', null, null, null, null, null, '358');
INSERT INTO `by_member` VALUES ('359', '13816972428', '1', '0', '0', '2016-09-11 21:15:37', '1', null, null, null, null, null, '359');
INSERT INTO `by_member` VALUES ('360', '13916000914', '1', '0', '0', '2016-09-11 21:18:26', '1', null, null, null, null, null, '360');
INSERT INTO `by_member` VALUES ('361', '13166110852', '1', '0', '0', '2016-09-11 21:18:57', '1', null, null, null, null, null, '361');
INSERT INTO `by_member` VALUES ('362', '13818273280', '1', '0', '0', '2016-09-11 21:19:15', '1', null, null, null, null, null, '362');
INSERT INTO `by_member` VALUES ('363', '13040606045', '1', '0', '0', '2016-09-11 21:21:47', '1', null, null, null, null, null, '363');
INSERT INTO `by_member` VALUES ('364', '18939807217', '1', '0', '0', '2016-09-11 21:22:22', '1', null, null, null, null, null, '364');
INSERT INTO `by_member` VALUES ('365', '13636392882', '1', '0', '0', '2016-09-11 21:22:39', '1', null, null, null, null, null, '365');
INSERT INTO `by_member` VALUES ('366', '15921371519', '1', '0', '0', '2016-09-11 21:22:59', '1', null, null, null, null, null, '366');
INSERT INTO `by_member` VALUES ('367', '15800998543', '1', '0', '0', '2016-09-11 21:24:07', '1', null, null, null, null, null, '367');
INSERT INTO `by_member` VALUES ('368', '13122283819', '1', '0', '0', '2016-09-11 21:25:52', '1', null, null, null, null, null, '368');
INSERT INTO `by_member` VALUES ('369', '13681740912', '1', '0', '0', '2016-09-11 21:26:02', '1', null, null, null, null, null, '369');
INSERT INTO `by_member` VALUES ('370', '13917309487', '1', '0', '0', '2016-09-11 21:30:01', '1', null, null, null, null, null, '370');
INSERT INTO `by_member` VALUES ('371', '13795352410', '1', '0', '0', '2016-09-11 21:32:09', '1', null, null, null, null, null, '371');
INSERT INTO `by_member` VALUES ('372', '13701830448', '1', '0', '0', '2016-09-11 21:36:55', '1', null, null, null, null, null, '372');
INSERT INTO `by_member` VALUES ('373', '15901756225', '1', '0', '0', '2016-09-11 21:38:14', '1', null, null, null, null, null, '373');
INSERT INTO `by_member` VALUES ('374', '13818543042', '1', '0', '0', '2016-09-11 21:44:51', '1', null, null, null, null, null, '374');
INSERT INTO `by_member` VALUES ('375', '13917364789', '1', '0', '0', '2016-09-11 21:53:18', '1', null, null, null, null, null, '375');
INSERT INTO `by_member` VALUES ('376', '13795386777', '1', '0', '0', '2016-09-11 21:53:33', '1', null, null, null, null, null, '376');
INSERT INTO `by_member` VALUES ('377', '18516699068', '1', '0', '0', '2016-09-11 21:55:16', '1', null, null, null, null, null, '377');
INSERT INTO `by_member` VALUES ('378', '13795412941', '1', '0', '0', '2016-09-11 21:59:10', '1', null, null, null, null, null, '378');
INSERT INTO `by_member` VALUES ('379', '13482540161', '1', '0', '0', '2016-09-11 22:03:29', '1', null, null, null, null, null, '379');
INSERT INTO `by_member` VALUES ('380', '15021290860', '1', '0', '0', '2016-09-11 22:08:28', '1', null, null, null, null, null, '380');
INSERT INTO `by_member` VALUES ('381', '18019240767', '1', '0', '0', '2016-09-11 22:15:27', '1', null, null, null, null, null, '381');
INSERT INTO `by_member` VALUES ('382', '13916943033', '1', '0', '0', '2016-09-11 22:21:46', '1', null, null, null, null, null, '382');
INSERT INTO `by_member` VALUES ('383', '13818008710', '1', '0', '0', '2016-09-11 22:24:49', '1', null, null, null, null, null, '383');
INSERT INTO `by_member` VALUES ('384', '13564093393', '1', '0', '0', '2016-09-11 22:26:46', '1', null, null, null, null, null, '384');
INSERT INTO `by_member` VALUES ('385', '13761945390', '1', '0', '0', '2016-09-11 22:29:56', '1', null, null, null, null, null, '385');
INSERT INTO `by_member` VALUES ('386', '13004121177', '1', '0', '0', '2016-09-11 22:33:41', '1', null, null, null, null, null, '386');
INSERT INTO `by_member` VALUES ('387', '13917961933', '1', '0', '0', '2016-09-11 22:35:52', '1', null, null, null, null, null, '387');
INSERT INTO `by_member` VALUES ('388', '13761269632', '1', '0', '0', '2016-09-11 22:38:00', '1', null, null, null, null, null, '388');
INSERT INTO `by_member` VALUES ('389', '13761281757', '1', '0', '0', '2016-09-11 22:47:17', '1', null, null, null, null, null, '389');
INSERT INTO `by_member` VALUES ('390', '13524836100', '1', '0', '0', '2016-09-11 23:42:16', '1', null, null, null, null, null, '390');
INSERT INTO `by_member` VALUES ('391', '13918858360', '1', '0', '0', '2016-09-11 23:58:53', '1', null, null, null, null, null, '391');
INSERT INTO `by_member` VALUES ('392', '13795496662', '1', '0', '0', '2016-09-12 01:08:46', '1', null, null, null, null, null, '392');
INSERT INTO `by_member` VALUES ('393', '18121305820', '1', '0', '0', '2016-09-12 01:21:02', '1', null, null, null, null, null, '393');
INSERT INTO `by_member` VALUES ('394', '13501972702', '1', '0', '0', '2016-09-12 04:43:42', '1', null, null, null, null, null, '394');
INSERT INTO `by_member` VALUES ('395', '13761355356', '1', '0', '0', '2016-09-12 05:57:29', '1', null, null, null, null, null, '395');
INSERT INTO `by_member` VALUES ('396', '18701772059', '1', '0', '0', '2016-09-12 06:45:05', '1', null, null, null, null, null, '396');
INSERT INTO `by_member` VALUES ('397', '15821152245', '1', '0', '0', '2016-09-12 07:05:26', '1', null, null, null, null, null, '397');
INSERT INTO `by_member` VALUES ('398', '13764106750', '1', '0', '0', '2016-09-12 07:14:29', '1', null, null, null, null, null, '398');
INSERT INTO `by_member` VALUES ('399', '13901911212', '1', '0', '0', '2016-09-12 07:58:03', '1', null, null, null, null, null, '399');
INSERT INTO `by_member` VALUES ('400', '13817570535', '1', '0', '0', '2016-09-12 08:46:33', '1', null, null, null, null, null, '400');
INSERT INTO `by_member` VALUES ('401', '13641935930', '1', '0', '0', '2016-09-12 08:52:12', '1', null, null, null, null, null, '401');
INSERT INTO `by_member` VALUES ('402', '13681721266', '1', '0', '0', '2016-09-12 09:10:48', '1', null, null, null, null, null, '402');
INSERT INTO `by_member` VALUES ('403', '18616885291', '1', '0', '0', '2016-09-12 09:19:18', '1', null, null, null, null, null, '403');
INSERT INTO `by_member` VALUES ('404', '13916664069', '1', '0', '0', '2016-09-12 09:24:14', '1', null, null, null, null, null, '404');
INSERT INTO `by_member` VALUES ('405', '13585988363', '1', '0', '0', '2016-09-12 09:47:52', '1', null, null, null, null, null, '405');
INSERT INTO `by_member` VALUES ('406', '13917341826', '1', '0', '0', '2016-09-12 09:52:51', '1', null, null, null, null, null, '406');
INSERT INTO `by_member` VALUES ('407', '13801740205', '1', '0', '0', '2016-09-12 09:56:49', '1', null, null, null, null, null, '407');
INSERT INTO `by_member` VALUES ('408', '13524163417', '1', '0', '0', '2016-09-12 10:11:56', '1', null, null, null, null, null, '408');
INSERT INTO `by_member` VALUES ('409', '13601820420', '1', '0', '0', '2016-09-12 10:21:56', '1', null, null, null, null, null, '409');
INSERT INTO `by_member` VALUES ('410', '13636383724', '1', '0', '0', '2016-09-12 11:33:28', '1', null, null, null, null, null, '410');
INSERT INTO `by_member` VALUES ('411', '13816625053', '1', '0', '0', '2016-09-12 12:32:44', '1', null, null, null, null, null, '411');
INSERT INTO `by_member` VALUES ('412', '13524101291', '1', '0', '0', '2016-09-12 12:46:57', '1', null, null, null, null, null, '412');
INSERT INTO `by_member` VALUES ('413', '13681620665', '1', '0', '0', '2016-09-12 13:06:46', '1', null, null, null, null, null, '413');
INSERT INTO `by_member` VALUES ('414', '13817381787', '1', '0', '0', '2016-09-12 14:15:46', '1', null, null, null, null, null, '414');
INSERT INTO `by_member` VALUES ('415', '13801633684', '1', '0', '0', '2016-09-12 15:22:03', '1', null, null, null, null, null, '415');
INSERT INTO `by_member` VALUES ('416', '13651894367', '1', '0', '0', '2016-09-12 15:30:34', '1', null, null, null, null, null, '416');
INSERT INTO `by_member` VALUES ('417', '18930925455', '1', '0', '0', '2016-09-12 16:40:15', '1', null, null, null, null, null, '417');
INSERT INTO `by_member` VALUES ('418', '18621751572', '1', '0', '0', '2016-09-12 17:01:01', '1', null, null, null, null, null, '418');
INSERT INTO `by_member` VALUES ('419', '13585508365', '1', '0', '0', '2016-09-12 17:13:23', '1', null, null, null, null, null, '419');
INSERT INTO `by_member` VALUES ('420', '18918687649', '1', '0', '0', '2016-09-12 18:06:07', '1', null, null, null, null, null, '420');
INSERT INTO `by_member` VALUES ('421', '13651613507', '1', '0', '0', '2016-09-12 18:51:19', '1', null, null, null, null, null, '421');
INSERT INTO `by_member` VALUES ('422', '13661696465', '1', '0', '0', '2016-09-12 19:05:46', '1', null, null, null, null, null, '422');
INSERT INTO `by_member` VALUES ('423', '13122923009', '1', '0', '0', '2016-09-12 19:39:08', '1', null, null, null, null, null, '423');
INSERT INTO `by_member` VALUES ('424', '18019783992', '1', '0', '0', '2016-09-12 20:47:04', '1', null, null, null, null, null, '424');
INSERT INTO `by_member` VALUES ('425', '13402120322', '1', '0', '0', '2016-09-12 21:01:27', '1', null, null, null, null, null, '425');
INSERT INTO `by_member` VALUES ('426', '15000274418', '1', '0', '0', '2016-09-12 22:18:40', '1', null, null, null, null, null, '426');
INSERT INTO `by_member` VALUES ('427', '13661464614', '1', '0', '0', '2016-09-13 07:55:13', '1', null, null, null, null, null, '427');
INSERT INTO `by_member` VALUES ('428', '13701955281', '1', '0', '0', '2016-09-13 13:36:10', '1', null, null, null, null, null, '428');
INSERT INTO `by_member` VALUES ('429', '15900677520', '1', '0', '0', '2016-09-13 14:21:16', '1', null, null, null, null, null, '429');
INSERT INTO `by_member` VALUES ('430', '13816443105', '1', '0', '0', '2016-09-13 14:22:48', '1', null, null, null, null, null, '430');
INSERT INTO `by_member` VALUES ('431', '13916743705', '1', '0', '0', '2016-09-13 15:30:58', '1', null, null, null, null, null, '431');
INSERT INTO `by_member` VALUES ('432', '13671948077', '1', '0', '0', '2016-09-13 16:18:14', '1', null, null, null, null, null, '432');
INSERT INTO `by_member` VALUES ('433', '13918444776', '1', '0', '0', '2016-09-13 16:38:12', '1', null, null, null, null, null, '433');
INSERT INTO `by_member` VALUES ('434', '13764411977', '1', '0', '0', '2016-09-13 17:30:12', '1', null, null, null, null, null, '434');
INSERT INTO `by_member` VALUES ('435', '18221002496', '1', '0', '0', '2016-09-13 18:23:56', '1', null, null, null, null, null, '435');
INSERT INTO `by_member` VALUES ('436', '13917129266', '1', '0', '0', '2016-09-13 19:23:39', '1', null, null, null, null, null, '436');
INSERT INTO `by_member` VALUES ('437', '13817633972', '1', '0', '0', '2016-09-13 22:24:30', '1', null, null, null, null, null, '437');
INSERT INTO `by_member` VALUES ('438', '17321284582', '1', '0', '0', '2016-09-13 22:32:56', '1', null, null, null, null, null, '438');
INSERT INTO `by_member` VALUES ('439', '15800851125', '1', '0', '0', '2016-09-14 08:20:19', '1', null, null, null, null, null, '439');
INSERT INTO `by_member` VALUES ('440', '18621977322', '1', '0', '0', '2016-09-14 08:22:16', '1', null, null, null, null, null, '440');
INSERT INTO `by_member` VALUES ('441', '13482411354', '1', '0', '0', '2016-09-14 09:23:11', '1', null, null, null, null, null, '441');
INSERT INTO `by_member` VALUES ('442', '17321284807', '1', '0', '0', '2016-09-14 10:32:54', '1', null, null, null, null, null, '442');
INSERT INTO `by_member` VALUES ('443', '15821946209', '1', '0', '0', '2016-09-14 11:00:52', '1', null, null, null, null, null, '443');
INSERT INTO `by_member` VALUES ('444', '13917901812', '1', '0', '0', '2016-09-14 11:11:45', '1', null, null, null, null, null, '444');
INSERT INTO `by_member` VALUES ('445', '13701893612', '1', '0', '0', '2016-09-14 11:12:59', '1', null, null, null, null, null, '445');
INSERT INTO `by_member` VALUES ('446', '18116199963', '1', '0', '0', '2016-09-14 11:38:39', '1', null, null, null, null, null, '446');
INSERT INTO `by_member` VALUES ('447', '13122879337', '1', '0', '0', '2016-09-14 12:30:08', '1', null, null, null, null, null, '447');
INSERT INTO `by_member` VALUES ('448', '13917459020', '1', '0', '0', '2016-09-14 14:56:15', '1', null, null, null, null, null, '448');
INSERT INTO `by_member` VALUES ('449', '13801693544', '1', '0', '0', '2016-09-14 15:00:08', '1', null, null, null, null, null, '449');
INSERT INTO `by_member` VALUES ('450', '13524828576', '1', '0', '0', '2016-09-14 15:20:53', '1', null, null, null, null, null, '450');
INSERT INTO `by_member` VALUES ('451', '13671509960', '1', '0', '0', '2016-09-14 15:33:17', '1', null, null, null, null, null, '451');
INSERT INTO `by_member` VALUES ('452', '13764937812', '1', '0', '0', '2016-09-14 15:40:45', '1', null, null, null, null, null, '452');
INSERT INTO `by_member` VALUES ('453', '18217751227', '1', '0', '0', '2016-09-14 15:43:47', '1', null, null, null, null, null, '453');
INSERT INTO `by_member` VALUES ('454', '13764533005', '1', '0', '0', '2016-09-14 15:46:40', '1', null, null, null, null, null, '454');
INSERT INTO `by_member` VALUES ('455', '15900516456', '1', '0', '0', '2016-09-14 15:47:31', '1', null, null, null, null, null, '455');
INSERT INTO `by_member` VALUES ('456', '13564452461', '1', '0', '0', '2016-09-14 15:47:56', '1', null, null, null, null, null, '456');
INSERT INTO `by_member` VALUES ('457', '15000431180', '1', '0', '0', '2016-09-14 15:48:07', '1', null, null, null, null, null, '457');
INSERT INTO `by_member` VALUES ('458', '13817335158', '1', '0', '0', '2016-09-14 15:53:55', '1', null, null, null, null, null, '458');
INSERT INTO `by_member` VALUES ('459', '18602113493', '1', '0', '0', '2016-09-14 15:53:58', '1', null, null, null, null, null, '459');
INSERT INTO `by_member` VALUES ('460', '13764218782', '1', '0', '0', '2016-09-14 15:58:13', '1', null, null, null, null, null, '460');
INSERT INTO `by_member` VALUES ('461', '13761141635', '1', '0', '0', '2016-09-14 16:00:14', '1', null, null, null, null, null, '461');
INSERT INTO `by_member` VALUES ('462', '13916961937', '1', '0', '0', '2016-09-14 16:21:32', '1', null, null, null, null, null, '462');
INSERT INTO `by_member` VALUES ('463', '13162553415', '1', '0', '0', '2016-09-14 16:24:51', '1', null, null, null, null, null, '463');
INSERT INTO `by_member` VALUES ('464', '13818258775', '1', '0', '0', '2016-09-14 16:38:56', '1', null, null, null, null, null, '464');
INSERT INTO `by_member` VALUES ('465', '13817511042', '1', '0', '0', '2016-09-14 16:40:19', '1', null, null, null, null, null, '465');
INSERT INTO `by_member` VALUES ('466', '13671575765', '1', '0', '0', '2016-09-14 16:41:08', '1', null, null, null, null, null, '466');
INSERT INTO `by_member` VALUES ('467', '13917485497', '1', '0', '0', '2016-09-14 16:53:19', '1', null, null, null, null, null, '467');
INSERT INTO `by_member` VALUES ('468', '13564074754', '1', '0', '0', '2016-09-14 17:03:59', '1', null, null, null, null, null, '468');
INSERT INTO `by_member` VALUES ('469', '13764565534', '1', '0', '0', '2016-09-14 17:10:13', '1', null, null, null, null, null, '469');
INSERT INTO `by_member` VALUES ('470', '13917478150', '1', '0', '0', '2016-09-14 17:10:53', '1', null, null, null, null, null, '470');
INSERT INTO `by_member` VALUES ('471', '13916761452', '1', '0', '0', '2016-09-14 18:24:36', '1', null, null, null, null, null, '471');
INSERT INTO `by_member` VALUES ('472', '13482174037', '1', '0', '0', '2016-09-14 19:12:42', '1', null, null, null, null, null, '472');
INSERT INTO `by_member` VALUES ('473', '13482045090', '1', '0', '0', '2016-09-14 20:04:36', '1', null, null, null, null, null, '473');
INSERT INTO `by_member` VALUES ('474', '17717386057', '1', '0', '0', '2016-09-14 21:12:09', '1', null, null, null, null, null, '474');
INSERT INTO `by_member` VALUES ('475', '15001806700', '1', '0', '0', '2016-09-14 21:12:16', '1', null, null, null, null, null, '475');
INSERT INTO `by_member` VALUES ('476', '13564289742', '1', '0', '0', '2016-09-14 21:48:07', '1', null, null, null, null, null, '476');
INSERT INTO `by_member` VALUES ('477', '15921518184', '1', '0', '0', '2016-09-14 23:39:31', '1', null, null, null, null, null, '477');
INSERT INTO `by_member` VALUES ('478', '17749774490', '1', '0', '0', '2016-09-14 23:49:28', '1', null, null, null, null, null, '478');
INSERT INTO `by_member` VALUES ('479', '13817602083', '1', '0', '0', '2016-09-15 07:01:44', '1', null, null, null, null, null, '479');
INSERT INTO `by_member` VALUES ('480', '13501638093', '1', '0', '0', '2016-09-15 08:04:43', '1', null, null, null, null, null, '480');
INSERT INTO `by_member` VALUES ('481', '13601958754', '1', '0', '0', '2016-09-15 09:09:29', '1', null, null, null, null, null, '481');
INSERT INTO `by_member` VALUES ('482', '18602172783', '1', '0', '0', '2016-09-15 09:41:38', '1', null, null, null, null, null, '482');
INSERT INTO `by_member` VALUES ('483', '18656786120', '1', '0', '0', '2016-09-15 11:08:13', '1', null, null, null, null, null, '483');
INSERT INTO `by_member` VALUES ('484', '13916423885', '1', '0', '0', '2016-09-15 11:23:04', '1', null, null, null, null, null, '484');
INSERT INTO `by_member` VALUES ('485', '13023202096', '1', '0', '0', '2016-09-15 11:37:36', '1', null, null, null, null, null, '485');
INSERT INTO `by_member` VALUES ('486', '13918600513', '1', '0', '0', '2016-09-15 11:45:55', '1', null, null, null, null, null, '486');
INSERT INTO `by_member` VALUES ('487', '13611941893', '1', '0', '0', '2016-09-15 13:06:39', '1', null, null, null, null, null, '487');
INSERT INTO `by_member` VALUES ('488', '18321927091', '1', '0', '0', '2016-09-15 13:17:39', '1', null, null, null, null, null, '488');
INSERT INTO `by_member` VALUES ('489', '13918900869', '1', '0', '0', '2016-09-15 13:18:45', '1', null, null, null, null, null, '489');
INSERT INTO `by_member` VALUES ('490', '13651613320', '1', '0', '0', '2016-09-15 13:19:17', '1', null, null, null, null, null, '490');
INSERT INTO `by_member` VALUES ('491', '15221339036', '1', '0', '0', '2016-09-15 13:22:38', '1', null, null, null, null, null, '491');
INSERT INTO `by_member` VALUES ('492', '15601888166', '1', '0', '0', '2016-09-15 14:00:19', '1', null, null, null, null, null, '492');
INSERT INTO `by_member` VALUES ('493', '18101871149', '1', '0', '0', '2016-09-15 14:33:32', '1', null, null, null, null, null, '493');
INSERT INTO `by_member` VALUES ('494', '13818596801', '1', '0', '0', '2016-09-15 14:59:27', '1', null, null, null, null, null, '494');
INSERT INTO `by_member` VALUES ('495', '18616386915', '1', '0', '0', '2016-09-15 15:15:51', '1', null, null, null, null, null, '495');
INSERT INTO `by_member` VALUES ('496', '13916726131', '1', '0', '0', '2016-09-15 16:19:07', '1', null, null, null, null, null, '496');
INSERT INTO `by_member` VALUES ('497', '15921453940', '1', '0', '0', '2016-09-15 19:42:42', '1', null, null, null, null, null, '497');
INSERT INTO `by_member` VALUES ('498', '13916236790', '1', '0', '0', '2016-09-15 19:55:08', '1', null, null, null, null, null, '498');
INSERT INTO `by_member` VALUES ('499', '13916784253', '1', '0', '0', '2016-09-15 20:14:25', '1', null, null, null, null, null, '499');
INSERT INTO `by_member` VALUES ('500', '13671536192', '1', '0', '0', '2016-09-15 22:03:54', '1', null, null, null, null, null, '500');
INSERT INTO `by_member` VALUES ('501', '13761564974', '1', '0', '0', '2016-09-15 22:32:19', '1', null, null, null, null, null, '501');
INSERT INTO `by_member` VALUES ('502', '18817934271', '1', '0', '0', '2016-09-16 10:53:19', '1', null, null, null, null, null, '502');
INSERT INTO `by_member` VALUES ('503', '18321714980', '1', '0', '0', '2016-09-16 11:41:13', '1', null, null, null, null, null, '503');
INSERT INTO `by_member` VALUES ('504', '13918779971', '1', '0', '0', '2016-09-16 12:05:54', '1', null, null, null, null, null, '504');
INSERT INTO `by_member` VALUES ('505', '13636537007', '1', '0', '0', '2016-09-16 12:54:10', '1', null, null, null, null, null, '505');
INSERT INTO `by_member` VALUES ('506', '13916906664', '1', '0', '0', '2016-09-16 13:20:43', '1', null, null, null, null, null, '506');
INSERT INTO `by_member` VALUES ('507', '13816232990', '1', '0', '0', '2016-09-16 14:48:07', '1', null, null, null, null, null, '507');
INSERT INTO `by_member` VALUES ('508', '13641955231', '1', '0', '0', '2016-09-16 15:13:55', '1', null, null, null, null, null, '508');
INSERT INTO `by_member` VALUES ('509', '13621610605', '1', '0', '0', '2016-09-16 16:02:45', '1', null, null, null, null, null, '509');
INSERT INTO `by_member` VALUES ('510', '13818276032', '1', '0', '0', '2016-09-16 16:48:34', '1', null, null, null, null, null, '510');
INSERT INTO `by_member` VALUES ('511', '15900807117', '1', '0', '0', '2016-09-16 17:09:18', '1', null, null, null, null, null, '511');
INSERT INTO `by_member` VALUES ('512', '15618630987', '1', '0', '0', '2016-09-16 18:51:58', '1', null, null, null, null, null, '512');
INSERT INTO `by_member` VALUES ('513', '13818437189', '1', '0', '0', '2016-09-16 19:42:20', '1', null, null, null, null, null, '513');
INSERT INTO `by_member` VALUES ('514', '13788901018', '1', '0', '0', '2016-09-16 20:10:04', '1', null, null, null, null, null, '514');
INSERT INTO `by_member` VALUES ('515', '18521721508', '1', '0', '0', '2016-09-16 22:54:29', '1', null, null, null, null, null, '515');
INSERT INTO `by_member` VALUES ('516', '18101748680', '1', '0', '0', '2016-09-17 08:34:48', '1', null, null, null, null, null, '516');
INSERT INTO `by_member` VALUES ('517', '13681686956', '1', '0', '0', '2016-09-17 10:21:25', '1', null, null, null, null, null, '517');
INSERT INTO `by_member` VALUES ('518', '15801980485', '1', '0', '0', '2016-09-17 13:36:02', '1', null, null, null, null, null, '518');
INSERT INTO `by_member` VALUES ('519', '18018688522', '1', '0', '0', '2016-09-17 13:57:07', '1', null, null, null, null, null, '519');
INSERT INTO `by_member` VALUES ('520', '13761526562', '1', '0', '0', '2016-09-17 14:26:52', '1', null, null, null, null, null, '520');
INSERT INTO `by_member` VALUES ('521', '18017832221', '1', '0', '0', '2016-09-17 16:33:45', '1', null, null, null, null, null, '521');
INSERT INTO `by_member` VALUES ('522', '18017811460', '1', '0', '0', '2016-09-17 17:06:10', '1', null, null, null, null, null, '522');
INSERT INTO `by_member` VALUES ('523', '13917756420', '1', '0', '0', '2016-09-17 17:11:32', '1', null, null, null, null, null, '523');
INSERT INTO `by_member` VALUES ('524', '18001865085', '1', '0', '0', '2016-09-17 18:17:16', '1', null, null, null, null, null, '524');
INSERT INTO `by_member` VALUES ('525', '13636527835', '1', '0', '0', '2016-09-17 18:27:27', '1', null, null, null, null, null, '525');
INSERT INTO `by_member` VALUES ('526', '15201957101', '1', '0', '0', '2016-09-17 18:50:45', '1', null, null, null, null, null, '526');
INSERT INTO `by_member` VALUES ('527', '13681630660', '1', '0', '0', '2016-09-17 19:36:20', '1', null, null, null, null, null, '527');
INSERT INTO `by_member` VALUES ('528', '18630939545', '1', '0', '0', '2016-09-17 20:11:05', '1', null, null, null, null, null, '528');
INSERT INTO `by_member` VALUES ('529', '13761332573', '1', '0', '0', '2016-09-17 21:18:50', '1', null, null, null, null, null, '529');
INSERT INTO `by_member` VALUES ('530', '15208289119', '1', '0', '0', '2016-09-18 10:57:52', '1', null, null, null, null, null, '530');
INSERT INTO `by_member` VALUES ('531', '13671812823', '1', '0', '0', '2016-09-18 13:40:43', '1', null, null, null, null, null, '531');
INSERT INTO `by_member` VALUES ('532', '13122400995', '1', '0', '0', '2016-09-18 14:05:02', '1', null, null, null, null, null, '532');
INSERT INTO `by_member` VALUES ('533', '13524903658', '1', '0', '0', '2016-09-18 14:24:17', '1', null, null, null, null, null, '533');
INSERT INTO `by_member` VALUES ('534', '18019217390', '1', '0', '0', '2016-09-18 14:41:29', '1', null, null, null, null, null, '534');
INSERT INTO `by_member` VALUES ('535', '13761164191', '1', '0', '0', '2016-09-18 14:47:49', '1', null, null, null, null, null, '535');
INSERT INTO `by_member` VALUES ('536', '13701941122', '1', '0', '0', '2016-09-18 15:52:04', '1', null, null, null, null, null, '536');
INSERT INTO `by_member` VALUES ('537', '13524066932', '1', '0', '0', '2016-09-18 17:11:45', '1', null, null, null, null, null, '537');
INSERT INTO `by_member` VALUES ('538', '13585825040', '1', '0', '0', '2016-09-18 20:12:59', '1', null, null, null, null, null, '538');
INSERT INTO `by_member` VALUES ('539', '15000529103', '1', '0', '0', '2016-09-18 20:39:30', '1', null, null, null, null, null, '539');
INSERT INTO `by_member` VALUES ('540', '13585868062', '1', '0', '0', '2016-09-19 06:23:18', '1', null, null, null, null, null, '540');
INSERT INTO `by_member` VALUES ('541', '13636355720', '1', '0', '0', '2016-09-19 08:24:19', '1', null, null, null, null, null, '541');
INSERT INTO `by_member` VALUES ('542', '18017002500', '1', '0', '0', '2016-09-19 10:46:34', '1', null, null, null, null, null, '542');
INSERT INTO `by_member` VALUES ('543', '13962104109', '1', '0', '0', '2016-09-19 12:29:05', '1', null, null, null, null, null, '543');
INSERT INTO `by_member` VALUES ('544', '13917045116', '1', '0', '0', '2016-09-19 16:11:48', '1', null, null, null, null, null, '544');
INSERT INTO `by_member` VALUES ('545', '15821661636', '1', '0', '0', '2016-09-19 20:03:08', '1', null, null, null, null, null, '545');
INSERT INTO `by_member` VALUES ('546', '13040619667', '1', '0', '0', '2016-09-19 21:44:25', '1', null, null, null, null, null, '546');
INSERT INTO `by_member` VALUES ('547', '18516531211', '1', '0', '0', '2016-09-20 10:10:51', '1', null, null, null, null, null, '547');
INSERT INTO `by_member` VALUES ('548', '13585652067', '1', '0', '0', '2016-09-20 15:50:44', '1', null, null, null, null, null, '548');
INSERT INTO `by_member` VALUES ('549', '15921903457', '1', '0', '0', '2016-09-20 18:03:16', '1', null, null, null, null, null, '549');
INSERT INTO `by_member` VALUES ('550', '18616303551', '1', '0', '0', '2016-09-20 21:08:25', '1', null, null, null, null, null, '550');
INSERT INTO `by_member` VALUES ('551', '13611995873', '1', '0', '0', '2016-09-20 21:53:05', '1', null, null, null, null, null, '551');
INSERT INTO `by_member` VALUES ('552', '13917428750', '1', '0', '0', '2016-09-21 12:48:32', '1', null, null, null, null, null, '552');
INSERT INTO `by_member` VALUES ('553', '18616533089', '1', '0', '0', '2016-09-21 21:11:56', '1', null, null, null, null, null, '553');
INSERT INTO `by_member` VALUES ('554', '15901739879', '1', '0', '0', '2016-09-22 10:49:00', '1', null, null, null, null, null, '554');
INSERT INTO `by_member` VALUES ('555', '13817151604', '1', '0', '0', '2016-09-22 11:04:03', '1', null, null, null, null, null, '555');
INSERT INTO `by_member` VALUES ('556', '13816832582', '1', '0', '0', '2016-09-22 15:55:37', '1', null, null, null, null, null, '556');
INSERT INTO `by_member` VALUES ('557', '13888793118', '1', '0', '0', '2016-09-22 16:40:41', '1', null, null, null, null, null, '557');
INSERT INTO `by_member` VALUES ('558', '17717070040', '1', '0', '0', '2016-09-22 16:43:14', '1', null, null, null, null, null, '558');
INSERT INTO `by_member` VALUES ('559', '13564455352', '1', '0', '0', '2016-09-22 17:56:18', '1', null, null, null, null, null, '559');
INSERT INTO `by_member` VALUES ('560', '13501619515', '1', '0', '0', '2016-09-22 19:48:56', '1', null, null, null, null, null, '560');
INSERT INTO `by_member` VALUES ('561', '13611977868', '1', '0', '0', '2016-09-22 20:12:07', '1', null, null, null, null, null, '561');
INSERT INTO `by_member` VALUES ('562', '13774265710', '1', '0', '0', '2016-09-22 21:18:05', '1', null, null, null, null, null, '562');
INSERT INTO `by_member` VALUES ('563', '13901798652', '1', '0', '0', '2016-09-22 22:09:53', '1', null, null, null, null, null, '563');
INSERT INTO `by_member` VALUES ('564', '13636341026', '1', '0', '0', '2016-09-23 06:31:16', '1', null, null, null, null, null, '564');
INSERT INTO `by_member` VALUES ('565', '13701855509', '1', '0', '0', '2016-09-23 10:49:46', '1', null, null, null, null, null, '565');
INSERT INTO `by_member` VALUES ('566', '13918302257', '1', '0', '0', '2016-09-23 10:53:49', '1', null, null, null, null, null, '566');
INSERT INTO `by_member` VALUES ('567', '13621689771', '1', '0', '0', '2016-09-23 12:27:29', '1', null, null, null, null, null, '567');
INSERT INTO `by_member` VALUES ('568', '13817068268', '1', '0', '0', '2016-09-23 12:51:45', '1', null, null, null, null, null, '568');
INSERT INTO `by_member` VALUES ('569', '13671517065', '1', '0', '0', '2016-09-23 14:34:27', '1', null, null, null, null, null, '569');
INSERT INTO `by_member` VALUES ('570', '15618331070', '1', '0', '0', '2016-09-23 15:11:47', '1', null, null, null, null, null, '570');
INSERT INTO `by_member` VALUES ('571', '13386282330', '1', '0', '0', '2016-09-23 17:28:01', '1', null, null, null, null, null, '571');
INSERT INTO `by_member` VALUES ('572', '13918232390', '1', '0', '0', '2016-09-23 17:51:55', '1', null, null, null, null, null, '572');
INSERT INTO `by_member` VALUES ('573', '13818843359', '1', '0', '0', '2016-09-23 19:48:24', '1', null, null, null, null, null, '573');
INSERT INTO `by_member` VALUES ('574', '13774282420', '1', '0', '0', '2016-09-23 20:03:49', '1', null, null, null, null, null, '574');
INSERT INTO `by_member` VALUES ('575', '18818210980', '1', '0', '0', '2016-09-23 20:59:16', '1', null, null, null, null, null, '575');
INSERT INTO `by_member` VALUES ('576', '18717961877', '1', '0', '0', '2016-09-23 21:34:04', '1', null, null, null, null, null, '576');
INSERT INTO `by_member` VALUES ('577', '13788942119', '1', '0', '0', '2016-09-24 09:03:26', '1', null, null, null, null, null, '577');
INSERT INTO `by_member` VALUES ('578', '13621688226', '1', '0', '0', '2016-09-24 12:20:46', '1', null, null, null, null, null, '578');
INSERT INTO `by_member` VALUES ('579', '13818145120', '1', '0', '0', '2016-09-24 12:51:11', '1', null, null, null, null, null, '579');
INSERT INTO `by_member` VALUES ('580', '13501938508', '1', '0', '0', '2016-09-24 13:31:30', '1', null, null, null, null, null, '580');
INSERT INTO `by_member` VALUES ('581', '13764540281', '1', '0', '0', '2016-09-24 13:41:19', '1', null, null, null, null, null, '581');
INSERT INTO `by_member` VALUES ('582', '15051084952', '1', '0', '0', '2016-09-24 13:52:52', '1', null, null, null, null, null, '582');
INSERT INTO `by_member` VALUES ('583', '18016395680', '1', '0', '0', '2016-09-24 14:32:02', '1', null, null, null, null, null, '583');
INSERT INTO `by_member` VALUES ('584', '15000815633', '1', '0', '0', '2016-09-24 14:48:05', '1', null, null, null, null, null, '584');
INSERT INTO `by_member` VALUES ('585', '13651922787', '1', '0', '0', '2016-09-24 16:40:27', '1', null, null, null, null, null, '585');
INSERT INTO `by_member` VALUES ('586', '15921781848', '1', '0', '0', '2016-09-24 18:22:11', '1', null, null, null, null, null, '586');
INSERT INTO `by_member` VALUES ('587', '18601784966', '1', '0', '0', '2016-09-24 18:45:42', '1', null, null, null, null, null, '587');
INSERT INTO `by_member` VALUES ('588', '18049908843', '1', '0', '0', '2016-09-24 22:47:15', '1', null, null, null, null, null, '588');
INSERT INTO `by_member` VALUES ('589', '13701967627', '1', '0', '0', '2016-09-24 23:05:12', '1', null, null, null, null, null, '589');
INSERT INTO `by_member` VALUES ('590', '13917036046', '1', '0', '0', '2016-09-25 05:38:54', '1', null, null, null, null, null, '590');
INSERT INTO `by_member` VALUES ('591', '13564732990', '1', '0', '0', '2016-09-25 11:26:19', '1', null, null, null, null, null, '591');
INSERT INTO `by_member` VALUES ('592', '18701992207', '1', '0', '0', '2016-09-25 11:32:00', '1', null, null, null, null, null, '592');
INSERT INTO `by_member` VALUES ('593', '13564690795', '1', '0', '0', '2016-09-25 11:38:13', '1', null, null, null, null, null, '593');
INSERT INTO `by_member` VALUES ('594', '13601901005', '1', '0', '0', '2016-09-25 12:22:04', '1', null, null, null, null, null, '594');
INSERT INTO `by_member` VALUES ('595', '13916279565', '1', '0', '0', '2016-09-25 14:52:19', '1', null, null, null, null, null, '595');
INSERT INTO `by_member` VALUES ('596', '13361811769', '1', '0', '0', '2016-09-25 17:05:06', '1', null, null, null, null, null, '596');
INSERT INTO `by_member` VALUES ('597', '15026682796', '1', '0', '0', '2016-09-25 17:45:12', '1', null, null, null, null, null, '597');
INSERT INTO `by_member` VALUES ('598', '13918902861', '1', '0', '0', '2016-09-25 17:55:29', '1', null, null, null, null, null, '598');
INSERT INTO `by_member` VALUES ('599', '18317175758', '1', '0', '0', '2016-09-25 17:57:35', '1', null, null, null, null, null, '599');
INSERT INTO `by_member` VALUES ('600', '13761007368', '1', '0', '0', '2016-09-25 18:02:31', '1', null, null, null, null, null, '600');
INSERT INTO `by_member` VALUES ('601', '18616757752', '1', '0', '0', '2016-09-25 18:08:16', '1', null, null, null, null, null, '601');
INSERT INTO `by_member` VALUES ('602', '13916614048', '1', '0', '0', '2016-09-25 18:24:15', '1', null, null, null, null, null, '602');
INSERT INTO `by_member` VALUES ('603', '13917617392', '1', '0', '0', '2016-09-25 18:56:12', '1', null, null, null, null, null, '603');
INSERT INTO `by_member` VALUES ('604', '13816264020', '1', '0', '0', '2016-09-25 21:39:39', '1', null, null, null, null, null, '604');
INSERT INTO `by_member` VALUES ('605', '18221916957', '1', '0', '0', '2016-09-26 18:51:37', '1', null, null, null, null, null, '605');
INSERT INTO `by_member` VALUES ('606', '15921034973', '1', '0', '0', '2016-09-27 12:15:52', '1', null, null, null, null, null, '606');
INSERT INTO `by_member` VALUES ('607', '18221329878', '1', '0', '0', '2016-09-27 15:22:09', '1', null, null, null, null, null, '607');
INSERT INTO `by_member` VALUES ('608', '18717805536', '1', '0', '0', '2016-09-27 18:35:44', '1', null, null, null, null, null, '608');
INSERT INTO `by_member` VALUES ('609', '13774264273', '1', '0', '0', '2016-09-27 21:12:12', '1', null, null, null, null, null, '609');
INSERT INTO `by_member` VALUES ('610', '18017865486', '1', '0', '0', '2016-09-27 21:49:27', '1', null, null, null, null, null, '610');
INSERT INTO `by_member` VALUES ('611', '13816505999', '1', '0', '0', '2016-09-27 21:54:30', '1', null, null, null, null, null, '611');
INSERT INTO `by_member` VALUES ('612', '15901806123', '1', '0', '0', '2016-09-28 15:50:14', '1', null, null, null, null, null, '612');
INSERT INTO `by_member` VALUES ('613', '13764638257', '1', '0', '0', '2016-09-28 16:55:45', '1', null, null, null, null, null, '613');
INSERT INTO `by_member` VALUES ('614', '18601756728', '1', '0', '0', '2016-09-28 17:59:28', '1', null, null, null, null, null, '614');
INSERT INTO `by_member` VALUES ('615', '13818384601', '1', '0', '0', '2016-09-28 22:31:57', '1', null, null, null, null, null, '615');
INSERT INTO `by_member` VALUES ('616', '18116052123', '1', '0', '0', '2016-09-29 12:41:35', '1', null, null, null, null, null, '616');
INSERT INTO `by_member` VALUES ('617', '13818568905', '1', '0', '0', '2016-09-29 12:42:55', '1', null, null, null, null, null, '617');
INSERT INTO `by_member` VALUES ('618', '13301950622', '1', '0', '0', '2016-09-29 12:43:24', '1', null, null, null, null, null, '618');
INSERT INTO `by_member` VALUES ('619', '13671691989', '1', '0', '0', '2016-09-29 12:46:04', '1', null, null, null, null, null, '619');
INSERT INTO `by_member` VALUES ('620', '13564516447', '1', '0', '0', '2016-09-29 12:46:05', '1', null, null, null, null, null, '620');
INSERT INTO `by_member` VALUES ('621', '13661671099', '1', '0', '0', '2016-09-29 12:49:06', '1', null, null, null, null, null, '621');
INSERT INTO `by_member` VALUES ('622', '13524853605', '1', '0', '0', '2016-09-29 12:52:29', '1', null, null, null, null, null, '622');
INSERT INTO `by_member` VALUES ('623', '13512178695', '1', '0', '0', '2016-09-29 12:59:55', '1', null, null, null, null, null, '623');
INSERT INTO `by_member` VALUES ('624', '15861317988', '1', '0', '0', '2016-09-29 13:17:31', '1', null, null, null, null, null, '624');
INSERT INTO `by_member` VALUES ('625', '18202171075', '1', '0', '0', '2016-09-29 13:43:43', '1', null, null, null, null, null, '625');
INSERT INTO `by_member` VALUES ('626', '13818849866', '1', '0', '0', '2016-09-29 13:52:46', '1', null, null, null, null, null, '626');
INSERT INTO `by_member` VALUES ('627', '13524162328', '1', '0', '0', '2016-09-29 14:23:24', '1', null, null, null, null, null, '627');
INSERT INTO `by_member` VALUES ('628', '15618961791', '1', '0', '0', '2016-09-29 14:29:42', '1', null, null, null, null, null, '628');
INSERT INTO `by_member` VALUES ('629', '13564673031', '1', '0', '0', '2016-09-29 15:26:51', '1', null, null, null, null, null, '629');
INSERT INTO `by_member` VALUES ('630', '13818428952', '1', '0', '0', '2016-09-29 16:06:33', '1', null, null, null, null, null, '630');
INSERT INTO `by_member` VALUES ('631', '15821139282', '1', '0', '0', '2016-09-29 16:10:20', '1', null, null, null, null, null, '631');
INSERT INTO `by_member` VALUES ('632', '13818459901', '1', '0', '0', '2016-09-29 16:55:28', '1', null, null, null, null, null, '632');
INSERT INTO `by_member` VALUES ('633', '18116271166', '1', '0', '0', '2016-09-29 17:00:02', '1', null, null, null, null, null, '633');
INSERT INTO `by_member` VALUES ('634', '15821091657', '1', '0', '0', '2016-09-29 18:39:26', '1', null, null, null, null, null, '634');
INSERT INTO `by_member` VALUES ('635', '13655631371', '1', '0', '0', '2016-09-29 18:40:14', '1', null, null, null, null, null, '635');
INSERT INTO `by_member` VALUES ('636', '15221962876', '1', '0', '0', '2016-09-29 18:56:57', '1', null, null, null, null, null, '636');
INSERT INTO `by_member` VALUES ('637', '13816237039', '1', '0', '0', '2016-09-30 11:01:47', '1', null, null, null, null, null, '637');
INSERT INTO `by_member` VALUES ('638', '13262812230', '1', '0', '0', '2016-09-30 11:09:17', '1', null, null, null, null, null, '638');
INSERT INTO `by_member` VALUES ('639', '13641767882', '1', '0', '0', '2016-09-30 17:18:39', '1', null, null, null, null, null, '639');
INSERT INTO `by_member` VALUES ('640', '15618733998', '1', '0', '0', '2016-09-30 18:34:09', '1', null, null, null, null, null, '640');
INSERT INTO `by_member` VALUES ('641', '13916609023', '1', '0', '0', '2016-09-30 20:21:29', '1', null, null, null, null, null, '641');
INSERT INTO `by_member` VALUES ('642', '13801740311', '1', '0', '0', '2016-10-01 08:28:26', '1', null, null, null, null, null, '642');
INSERT INTO `by_member` VALUES ('643', '13917665071', '1', '0', '0', '2016-10-01 10:39:39', '1', null, null, null, null, null, '643');
INSERT INTO `by_member` VALUES ('644', '18521525075', '1', '0', '0', '2016-10-01 10:54:51', '1', null, null, null, null, null, '644');
INSERT INTO `by_member` VALUES ('645', '13818006425', '1', '0', '0', '2016-10-01 10:57:12', '1', null, null, null, null, null, '645');
INSERT INTO `by_member` VALUES ('646', '13917537326', '1', '0', '0', '2016-10-01 11:45:42', '1', null, null, null, null, null, '646');
INSERT INTO `by_member` VALUES ('647', '13585687179', '1', '0', '0', '2016-10-01 11:56:00', '1', null, null, null, null, null, '647');
INSERT INTO `by_member` VALUES ('648', '13020223948', '1', '0', '0', '2016-10-01 12:18:54', '1', null, null, null, null, null, '648');
INSERT INTO `by_member` VALUES ('649', '13917649543', '1', '0', '0', '2016-10-01 12:21:33', '1', null, null, null, null, null, '649');
INSERT INTO `by_member` VALUES ('650', '18918620006', '1', '0', '0', '2016-10-01 12:59:29', '1', null, null, null, null, null, '650');
INSERT INTO `by_member` VALUES ('651', '13818162840', '1', '0', '0', '2016-10-01 14:02:55', '1', null, null, null, null, null, '651');
INSERT INTO `by_member` VALUES ('652', '13795352261', '1', '0', '0', '2016-10-01 14:17:23', '1', null, null, null, null, null, '652');
INSERT INTO `by_member` VALUES ('653', '13788944073', '1', '0', '0', '2016-10-01 14:26:37', '1', null, null, null, null, null, '653');
INSERT INTO `by_member` VALUES ('654', '13917707909', '1', '0', '0', '2016-10-01 15:08:36', '1', null, null, null, null, null, '654');
INSERT INTO `by_member` VALUES ('655', '13482171320', '1', '0', '0', '2016-10-01 15:14:16', '1', null, null, null, null, null, '655');
INSERT INTO `by_member` VALUES ('656', '13611618988', '1', '0', '0', '2016-10-01 18:22:55', '1', null, null, null, null, null, '656');
INSERT INTO `by_member` VALUES ('657', '13585866127', '1', '0', '0', '2016-10-01 18:35:23', '1', null, null, null, null, null, '657');
INSERT INTO `by_member` VALUES ('658', '13764126581', '1', '0', '0', '2016-10-01 18:38:15', '1', null, null, null, null, null, '658');
INSERT INTO `by_member` VALUES ('659', '15900502190', '1', '0', '0', '2016-10-01 20:19:56', '1', null, null, null, null, null, '659');
INSERT INTO `by_member` VALUES ('660', '13585642369', '1', '0', '0', '2016-10-02 07:14:44', '1', null, null, null, null, null, '660');
INSERT INTO `by_member` VALUES ('661', '13764569344', '1', '0', '0', '2016-10-02 10:32:50', '1', null, null, null, null, null, '661');
INSERT INTO `by_member` VALUES ('662', '15221031789', '1', '0', '0', '2016-10-02 11:19:22', '1', null, null, null, null, null, '662');
INSERT INTO `by_member` VALUES ('663', '13585741943', '1', '0', '0', '2016-10-02 12:04:04', '1', null, null, null, null, null, '663');
INSERT INTO `by_member` VALUES ('664', '13817019313', '1', '0', '0', '2016-10-02 12:44:01', '1', null, null, null, null, null, '664');
INSERT INTO `by_member` VALUES ('665', '18221833721', '1', '0', '0', '2016-10-02 14:40:07', '1', null, null, null, null, null, '665');
INSERT INTO `by_member` VALUES ('666', '18516563609', '1', '0', '0', '2016-10-02 14:43:34', '1', null, null, null, null, null, '666');
INSERT INTO `by_member` VALUES ('667', '13817116915', '1', '0', '0', '2016-10-02 17:23:14', '1', null, null, null, null, null, '667');
INSERT INTO `by_member` VALUES ('668', '13701833493', '1', '0', '0', '2016-10-02 17:45:36', '1', null, null, null, null, null, '668');
INSERT INTO `by_member` VALUES ('669', '15618374181', '1', '0', '0', '2016-10-02 19:32:15', '1', null, null, null, null, null, '669');
INSERT INTO `by_member` VALUES ('670', '13918300530', '1', '0', '0', '2016-10-02 20:50:28', '1', null, null, null, null, null, '670');
INSERT INTO `by_member` VALUES ('671', '13501785677', '1', '0', '0', '2016-10-02 20:55:23', '1', null, null, null, null, null, '671');
INSERT INTO `by_member` VALUES ('672', '18701746390', '1', '0', '0', '2016-10-02 22:00:18', '1', null, null, null, null, null, '672');
INSERT INTO `by_member` VALUES ('673', '13818090660', '1', '0', '0', '2016-10-03 10:22:13', '1', null, null, null, null, null, '673');
INSERT INTO `by_member` VALUES ('674', '13818488197', '1', '0', '0', '2016-10-03 12:16:01', '1', null, null, null, null, null, '674');
INSERT INTO `by_member` VALUES ('675', '13774371969', '1', '0', '0', '2016-10-03 12:24:41', '1', null, null, null, null, null, '675');
INSERT INTO `by_member` VALUES ('676', '13817907381', '1', '0', '0', '2016-10-03 19:35:45', '1', null, null, null, null, null, '676');
INSERT INTO `by_member` VALUES ('677', '13816460417', '1', '0', '0', '2016-10-04 11:02:04', '1', null, null, null, null, null, '677');
INSERT INTO `by_member` VALUES ('678', '15921006095', '1', '0', '0', '2016-10-04 13:03:10', '1', null, null, null, null, null, '678');
INSERT INTO `by_member` VALUES ('679', '18019360927', '1', '0', '0', '2016-10-04 14:41:21', '1', null, null, null, null, null, '679');
INSERT INTO `by_member` VALUES ('680', '13564115173', '1', '0', '0', '2016-10-04 15:47:21', '1', null, null, null, null, null, '680');
INSERT INTO `by_member` VALUES ('681', '13917841191', '1', '0', '0', '2016-10-04 17:19:02', '1', null, null, null, null, null, '681');
INSERT INTO `by_member` VALUES ('682', '13818891965', '1', '0', '0', '2016-10-04 18:33:24', '1', null, null, null, null, null, '682');
INSERT INTO `by_member` VALUES ('683', '13764571982', '1', '0', '0', '2016-10-04 18:37:34', '1', null, null, null, null, null, '683');
INSERT INTO `by_member` VALUES ('684', '13817779418', '1', '0', '0', '2016-10-04 18:53:26', '1', null, null, null, null, null, '684');
INSERT INTO `by_member` VALUES ('685', '13262822660', '1', '0', '0', '2016-10-04 20:03:25', '1', null, null, null, null, null, '685');
INSERT INTO `by_member` VALUES ('686', '15921646742', '1', '0', '0', '2016-10-04 20:23:41', '1', null, null, null, null, null, '686');
INSERT INTO `by_member` VALUES ('687', '13918168622', '1', '0', '0', '2016-10-04 21:09:21', '1', null, null, null, null, null, '687');
INSERT INTO `by_member` VALUES ('688', '13818851152', '1', '0', '0', '2016-10-05 10:05:39', '1', null, null, null, null, null, '688');
INSERT INTO `by_member` VALUES ('689', '15070509415', '1', '0', '0', '2016-10-05 11:08:37', '1', null, null, null, null, null, '689');
INSERT INTO `by_member` VALUES ('690', '13916151451', '1', '0', '0', '2016-10-05 16:44:39', '1', null, null, null, null, null, '690');
INSERT INTO `by_member` VALUES ('691', '13917273209', '1', '0', '0', '2016-10-05 17:28:57', '1', null, null, null, null, null, '691');
INSERT INTO `by_member` VALUES ('692', '13917143244', '1', '0', '0', '2016-10-05 18:19:13', '1', null, null, null, null, null, '692');
INSERT INTO `by_member` VALUES ('693', '13918296543', '1', '0', '0', '2016-10-05 18:29:48', '1', null, null, null, null, null, '693');
INSERT INTO `by_member` VALUES ('694', '18516535639', '1', '0', '0', '2016-10-05 19:02:29', '1', null, null, null, null, null, '694');
INSERT INTO `by_member` VALUES ('695', '13918106508', '1', '0', '0', '2016-10-05 19:43:17', '1', null, null, null, null, null, '695');
INSERT INTO `by_member` VALUES ('696', '13917780930', '1', '0', '0', '2016-10-06 11:52:39', '1', null, null, null, null, null, '696');
INSERT INTO `by_member` VALUES ('697', '13166466729', '1', '0', '0', '2016-10-06 12:08:40', '1', null, null, null, null, null, '697');
INSERT INTO `by_member` VALUES ('698', '13761497374', '1', '0', '0', '2016-10-06 12:41:59', '1', null, null, null, null, null, '698');
INSERT INTO `by_member` VALUES ('699', '13918175577', '1', '0', '0', '2016-10-06 14:23:15', '1', null, null, null, null, null, '699');
INSERT INTO `by_member` VALUES ('700', '13310055958', '1', '0', '0', '2016-10-06 14:56:43', '1', null, null, null, null, null, '700');
INSERT INTO `by_member` VALUES ('701', '13764501782', '1', '0', '0', '2016-10-06 14:59:24', '1', null, null, null, null, null, '701');
INSERT INTO `by_member` VALUES ('702', '13585933304', '1', '0', '0', '2016-10-06 16:06:44', '1', null, null, null, null, null, '702');
INSERT INTO `by_member` VALUES ('703', '13817525359', '1', '0', '0', '2016-10-06 16:10:30', '1', null, null, null, null, null, '703');
INSERT INTO `by_member` VALUES ('704', '13701841411', '1', '0', '0', '2016-10-06 16:35:15', '1', null, null, null, null, null, '704');
INSERT INTO `by_member` VALUES ('705', '13916114087', '1', '0', '0', '2016-10-06 17:17:54', '1', null, null, null, null, null, '705');
INSERT INTO `by_member` VALUES ('706', '15000282989', '1', '0', '0', '2016-10-06 19:16:46', '1', null, null, null, null, null, '706');
INSERT INTO `by_member` VALUES ('707', '15002176144', '1', '0', '0', '2016-10-06 19:39:16', '1', null, null, null, null, null, '707');
INSERT INTO `by_member` VALUES ('708', '13651697500', '1', '0', '0', '2016-10-06 20:03:27', '1', null, null, null, null, null, '708');
INSERT INTO `by_member` VALUES ('709', '18019395672', '1', '0', '0', '2016-10-06 20:37:08', '1', null, null, null, null, null, '709');
INSERT INTO `by_member` VALUES ('710', '13918196645', '1', '0', '0', '2016-10-06 21:41:03', '1', null, null, null, null, null, '710');
INSERT INTO `by_member` VALUES ('711', '13918586683', '1', '0', '0', '2016-10-06 22:41:21', '1', null, null, null, null, null, '711');
INSERT INTO `by_member` VALUES ('712', '13482373252', '1', '0', '0', '2016-10-07 12:55:51', '1', null, null, null, null, null, '712');
INSERT INTO `by_member` VALUES ('713', '13917282989', '1', '0', '0', '2016-10-07 13:18:14', '1', null, null, null, null, null, '713');
INSERT INTO `by_member` VALUES ('714', '17717646897', '1', '0', '0', '2016-10-07 13:37:18', '1', null, null, null, null, null, '714');
INSERT INTO `by_member` VALUES ('715', '13916230936', '1', '0', '0', '2016-10-07 13:42:47', '1', null, null, null, null, null, '715');
INSERT INTO `by_member` VALUES ('716', '13402021230', '1', '0', '0', '2016-10-07 14:51:36', '1', null, null, null, null, null, '716');
INSERT INTO `by_member` VALUES ('717', '15000215720', '1', '0', '0', '2016-10-07 16:25:30', '1', null, null, null, null, null, '717');
INSERT INTO `by_member` VALUES ('718', '13585932443', '1', '0', '0', '2016-10-07 16:31:33', '1', null, null, null, null, null, '718');
INSERT INTO `by_member` VALUES ('719', '13917480364', '1', '0', '0', '2016-10-07 17:32:26', '1', null, null, null, null, null, '719');
INSERT INTO `by_member` VALUES ('720', '15900602583', '1', '0', '0', '2016-10-07 18:50:38', '1', null, null, null, null, null, '720');
INSERT INTO `by_member` VALUES ('721', '13120578496', '1', '0', '0', '2016-10-07 20:25:54', '1', null, null, null, null, null, '721');
INSERT INTO `by_member` VALUES ('722', '13795276305', '1', '0', '0', '2016-10-07 20:56:45', '1', null, null, null, null, null, '722');
INSERT INTO `by_member` VALUES ('723', '13916035940', '1', '0', '0', '2016-10-07 21:22:34', '1', null, null, null, null, null, '723');
INSERT INTO `by_member` VALUES ('724', '13818456474', '1', '0', '0', '2016-10-07 22:13:24', '1', null, null, null, null, null, '724');
INSERT INTO `by_member` VALUES ('725', '13817105220', '1', '0', '0', '2016-10-08 07:25:12', '1', null, null, null, null, null, '725');
INSERT INTO `by_member` VALUES ('726', '13916599516', '1', '0', '0', '2016-10-08 15:59:49', '1', null, null, null, null, null, '726');
INSERT INTO `by_member` VALUES ('727', '13818213367', '1', '0', '0', '2016-10-08 20:33:52', '1', null, null, null, null, null, '727');
INSERT INTO `by_member` VALUES ('728', '18019185234', '1', '0', '0', '2016-10-08 22:11:11', '1', null, null, null, null, null, '728');
INSERT INTO `by_member` VALUES ('729', '13817826207', '1', '0', '0', '2016-10-09 12:04:23', '1', null, null, null, null, null, '729');
INSERT INTO `by_member` VALUES ('730', '13764922407', '1', '0', '0', '2016-10-09 15:01:06', '1', null, null, null, null, null, '730');
INSERT INTO `by_member` VALUES ('731', '13564958570', '1', '0', '0', '2016-10-09 21:07:37', '1', null, null, null, null, null, '731');
INSERT INTO `by_member` VALUES ('732', '13611889653', '1', '0', '0', '2016-10-09 21:50:03', '1', null, null, null, null, null, '732');
INSERT INTO `by_member` VALUES ('733', '13764689917', '1', '0', '0', '2016-10-10 16:47:13', '1', null, null, null, null, null, '733');
INSERT INTO `by_member` VALUES ('734', '13817737929', '1', '0', '0', '2016-10-10 20:45:49', '1', null, null, null, null, null, '734');
INSERT INTO `by_member` VALUES ('735', '13916718922', '1', '0', '0', '2016-10-11 10:09:30', '1', null, null, null, null, null, '735');
INSERT INTO `by_member` VALUES ('736', '13636368939', '1', '0', '0', '2016-10-11 13:50:28', '1', null, null, null, null, null, '736');
INSERT INTO `by_member` VALUES ('737', '13817822335', '1', '0', '0', '2016-10-12 12:31:28', '1', null, null, null, null, null, '737');
INSERT INTO `by_member` VALUES ('738', '13601872303', '1', '0', '0', '2016-10-12 21:27:39', '1', null, null, null, null, null, '738');
INSERT INTO `by_member` VALUES ('739', '18565288035', '1', '0', '0', '2016-10-13 07:09:34', '1', null, null, null, null, null, '739');
INSERT INTO `by_member` VALUES ('740', '18261533057', '1', '8238', '8358', '2016-10-13 10:52:47', '1', null, null, '2016-11-25 17:54:28', null, null, '740');
INSERT INTO `by_member` VALUES ('741', '15312307268', '1', '0', '0', '2016-10-13 11:14:07', '1', null, null, null, null, null, '741');
INSERT INTO `by_member` VALUES ('742', '13564559221', '1', '0', '0', '2016-10-13 18:49:23', '1', null, null, null, null, null, '742');
INSERT INTO `by_member` VALUES ('743', '13764187304', '1', '0', '0', '2016-10-13 22:04:51', '1', null, null, null, null, null, '743');
INSERT INTO `by_member` VALUES ('744', '13916150308', '1', '0', '0', '2016-10-14 18:46:43', '1', null, null, null, null, null, '744');
INSERT INTO `by_member` VALUES ('745', '13681917726', '1', '0', '0', '2016-10-14 20:01:25', '1', null, null, null, null, null, '745');
INSERT INTO `by_member` VALUES ('746', '13636694423', '1', '0', '0', '2016-10-14 20:06:07', '1', null, null, null, null, null, '746');
INSERT INTO `by_member` VALUES ('747', '13816008065', '1', '0', '0', '2016-10-14 20:08:38', '1', null, null, null, null, null, '747');
INSERT INTO `by_member` VALUES ('748', '15026540716', '1', '0', '0', '2016-10-14 20:20:23', '1', null, null, null, null, null, '748');
INSERT INTO `by_member` VALUES ('749', '13916809720', '1', '0', '0', '2016-10-14 20:20:25', '1', null, null, null, null, null, '749');
INSERT INTO `by_member` VALUES ('750', '15021651817', '1', '0', '0', '2016-10-14 20:23:01', '1', null, null, null, null, null, '750');
INSERT INTO `by_member` VALUES ('751', '13817327302', '1', '0', '0', '2016-10-14 20:29:35', '1', null, null, null, null, null, '751');
INSERT INTO `by_member` VALUES ('752', '13166112559', '1', '0', '0', '2016-10-14 20:34:58', '1', null, null, null, null, null, '752');
INSERT INTO `by_member` VALUES ('753', '18616121300', '1', '0', '0', '2016-10-14 20:37:44', '1', null, null, null, null, null, '753');
INSERT INTO `by_member` VALUES ('754', '18917922738', '1', '0', '0', '2016-10-14 20:39:26', '1', null, null, null, null, null, '754');
INSERT INTO `by_member` VALUES ('755', '13701857666', '1', '0', '0', '2016-10-14 20:42:26', '1', null, null, null, null, null, '755');
INSERT INTO `by_member` VALUES ('756', '15921273717', '1', '0', '0', '2016-10-14 21:10:10', '1', null, null, null, null, null, '756');
INSERT INTO `by_member` VALUES ('757', '13918195411', '1', '0', '0', '2016-10-14 21:15:07', '1', null, null, null, null, null, '757');
INSERT INTO `by_member` VALUES ('758', '18001891998', '1', '0', '0', '2016-10-14 21:24:10', '1', null, null, null, null, null, '758');
INSERT INTO `by_member` VALUES ('759', '15034335449', '1', '0', '0', '2016-10-15 00:01:57', '1', null, null, null, null, null, '759');
INSERT INTO `by_member` VALUES ('760', '13818416761', '1', '0', '0', '2016-10-15 10:31:30', '1', null, null, null, null, null, '760');
INSERT INTO `by_member` VALUES ('761', '15901915254', '1', '0', '0', '2016-10-15 11:18:35', '1', null, null, null, null, null, '761');
INSERT INTO `by_member` VALUES ('762', '13761079862', '1', '0', '0', '2016-10-15 11:27:05', '1', null, null, null, null, null, '762');
INSERT INTO `by_member` VALUES ('763', '13020297879', '1', '0', '0', '2016-10-15 13:03:11', '1', null, null, null, null, null, '763');
INSERT INTO `by_member` VALUES ('764', '13020261678', '1', '0', '0', '2016-10-15 13:34:32', '1', null, null, null, null, null, '764');
INSERT INTO `by_member` VALUES ('765', '13971087717', '1', '0', '0', '2016-10-15 13:43:59', '1', null, null, null, null, null, '765');
INSERT INTO `by_member` VALUES ('766', '18616899983', '1', '0', '0', '2016-10-15 15:26:48', '1', null, null, null, null, null, '766');
INSERT INTO `by_member` VALUES ('767', '13817639920', '1', '0', '0', '2016-10-15 17:11:18', '1', null, null, null, null, null, '767');
INSERT INTO `by_member` VALUES ('768', '13601707225', '1', '0', '0', '2016-10-15 17:28:56', '1', null, null, null, null, null, '768');
INSERT INTO `by_member` VALUES ('769', '13761098882', '1', '0', '0', '2016-10-15 17:58:07', '1', null, null, null, null, null, '769');
INSERT INTO `by_member` VALUES ('770', '13817177028', '1', '0', '0', '2016-10-16 12:10:22', '1', null, null, null, null, null, '770');
INSERT INTO `by_member` VALUES ('771', '13701985713', '1', '0', '0', '2016-10-16 14:17:45', '1', null, null, null, null, null, '771');
INSERT INTO `by_member` VALUES ('772', '13501972029', '1', '0', '0', '2016-10-16 16:39:42', '1', null, null, null, null, null, '772');
INSERT INTO `by_member` VALUES ('773', '15800860795', '1', '0', '0', '2016-10-16 16:47:31', '1', null, null, null, null, null, '773');
INSERT INTO `by_member` VALUES ('774', '13564314906', '1', '0', '0', '2016-10-16 17:56:39', '1', null, null, null, null, null, '774');
INSERT INTO `by_member` VALUES ('775', '18520402530', '1', '0', '0', '2016-10-16 18:50:43', '1', null, null, null, null, null, '775');
INSERT INTO `by_member` VALUES ('776', '13774263230', '1', '0', '0', '2016-10-16 22:29:24', '1', null, null, null, null, null, '776');
INSERT INTO `by_member` VALUES ('777', '13917597774', '1', '0', '0', '2016-10-16 22:40:41', '1', null, null, null, null, null, '777');
INSERT INTO `by_member` VALUES ('778', '17761916991', '1', '0', '0', '2016-10-17 11:53:33', '1', null, null, null, null, null, '778');
INSERT INTO `by_member` VALUES ('779', '18918500530', '1', '0', '0', '2016-10-17 12:12:10', '1', null, null, null, null, null, '779');
INSERT INTO `by_member` VALUES ('780', '13621630484', '1', '0', '0', '2016-10-17 13:19:51', '1', null, null, null, null, null, '780');
INSERT INTO `by_member` VALUES ('781', '13764257554', '1', '0', '0', '2016-10-17 16:54:51', '1', null, null, null, null, null, '781');
INSERT INTO `by_member` VALUES ('782', '13585779822', '1', '0', '0', '2016-10-18 09:33:39', '1', null, null, null, null, null, '782');
INSERT INTO `by_member` VALUES ('783', '18516056150', '1', '0', '0', '2016-10-18 15:28:49', '1', null, null, null, null, null, '783');
INSERT INTO `by_member` VALUES ('784', '13162084926', '1', '0', '0', '2016-10-18 17:33:10', '1', null, null, null, null, null, '784');
INSERT INTO `by_member` VALUES ('785', '13917056791', '1', '0', '0', '2016-10-18 19:00:49', '1', null, null, null, null, null, '785');
INSERT INTO `by_member` VALUES ('786', '13816201037', '1', '0', '0', '2016-10-19 10:38:26', '1', null, null, null, null, null, '786');
INSERT INTO `by_member` VALUES ('787', '13917942385', '1', '0', '0', '2016-10-19 11:57:55', '1', null, null, null, null, null, '787');
INSERT INTO `by_member` VALUES ('788', '13918732609', '1', '0', '0', '2016-10-20 13:28:20', '1', null, null, null, null, null, '788');
INSERT INTO `by_member` VALUES ('789', '13801668111', '1', '0', '0', '2016-10-20 18:14:48', '1', null, null, null, null, null, '789');
INSERT INTO `by_member` VALUES ('790', '13764427987', '1', '0', '0', '2016-10-20 18:35:02', '1', null, null, null, null, null, '790');
INSERT INTO `by_member` VALUES ('791', '13524985872', '1', '0', '0', '2016-10-20 18:42:42', '1', null, null, null, null, null, '791');
INSERT INTO `by_member` VALUES ('792', '13585623542', '1', '0', '0', '2016-10-20 19:07:38', '1', null, null, null, null, null, '792');
INSERT INTO `by_member` VALUES ('793', '13918381478', '1', '0', '0', '2016-10-20 19:10:48', '1', null, null, null, null, null, '793');
INSERT INTO `by_member` VALUES ('794', '18221803727', '1', '0', '0', '2016-10-20 19:13:00', '1', null, null, null, null, null, '794');
INSERT INTO `by_member` VALUES ('795', '13761830105', '1', '0', '0', '2016-10-20 19:16:05', '1', null, null, null, null, null, '795');
INSERT INTO `by_member` VALUES ('796', '15121111299', '1', '0', '0', '2016-10-20 19:21:15', '1', null, null, null, null, null, '796');
INSERT INTO `by_member` VALUES ('797', '18918500275', '1', '0', '0', '2016-10-20 19:59:20', '1', null, null, null, null, null, '797');
INSERT INTO `by_member` VALUES ('798', '13818362451', '1', '0', '0', '2016-10-20 21:14:36', '1', null, null, null, null, null, '798');
INSERT INTO `by_member` VALUES ('799', '13917586528', '1', '0', '0', '2016-10-20 22:23:58', '1', null, null, null, null, null, '799');
INSERT INTO `by_member` VALUES ('800', '18217116506', '1', '0', '0', '2016-10-20 23:18:17', '1', null, null, null, null, null, '800');
INSERT INTO `by_member` VALUES ('801', '13701655853', '1', '0', '0', '2016-10-21 16:41:26', '1', null, null, null, null, null, '801');
INSERT INTO `by_member` VALUES ('802', '13918967731', '1', '0', '0', '2016-10-21 22:11:12', '1', null, null, null, null, null, '802');
INSERT INTO `by_member` VALUES ('803', '18502528469', '1', '0', '0', '2016-10-22 07:21:35', '1', null, null, null, null, null, '803');
INSERT INTO `by_member` VALUES ('804', '15801850563', '1', '0', '0', '2016-10-22 10:52:55', '1', null, null, null, null, null, '804');
INSERT INTO `by_member` VALUES ('805', '18817873085', '1', '0', '0', '2016-10-22 14:54:20', '1', null, null, null, null, null, '805');
INSERT INTO `by_member` VALUES ('806', '13764155582', '1', '0', '0', '2016-10-22 15:59:18', '1', null, null, null, null, null, '806');
INSERT INTO `by_member` VALUES ('807', '13761348835', '1', '0', '0', '2016-10-22 18:10:32', '1', null, null, null, null, null, '807');
INSERT INTO `by_member` VALUES ('808', '18149753496', '1', '0', '0', '2016-10-22 19:22:19', '1', null, null, null, null, null, '808');
INSERT INTO `by_member` VALUES ('809', '13621816763', '1', '0', '0', '2016-10-22 20:40:34', '1', null, null, null, null, null, '809');
INSERT INTO `by_member` VALUES ('810', '13761901566', '1', '0', '0', '2016-10-22 23:06:49', '1', null, null, null, null, null, '810');
INSERT INTO `by_member` VALUES ('811', '18221865170', '1', '0', '0', '2016-10-23 08:48:53', '1', null, null, null, null, null, '811');
INSERT INTO `by_member` VALUES ('812', '13816566590', '1', '0', '0', '2016-10-23 10:34:29', '1', null, null, null, null, null, '812');
INSERT INTO `by_member` VALUES ('813', '13817788392', '1', '0', '0', '2016-10-23 11:08:38', '1', null, null, null, null, null, '813');
INSERT INTO `by_member` VALUES ('814', '15900960041', '1', '0', '0', '2016-10-23 12:20:01', '1', null, null, null, null, null, '814');
INSERT INTO `by_member` VALUES ('815', '15921179292', '1', '0', '0', '2016-10-23 13:39:14', '1', null, null, null, null, null, '815');
INSERT INTO `by_member` VALUES ('816', '13761615573', '1', '0', '0', '2016-10-23 15:44:42', '1', null, null, null, null, null, '816');
INSERT INTO `by_member` VALUES ('817', '15800344708', '1', '0', '0', '2016-10-23 16:01:28', '1', null, null, null, null, null, '817');
INSERT INTO `by_member` VALUES ('818', '13918774728', '1', '0', '0', '2016-10-23 18:26:36', '1', null, null, null, null, null, '818');
INSERT INTO `by_member` VALUES ('819', '13818565872', '1', '0', '0', '2016-10-23 19:59:47', '1', null, null, null, null, null, '819');
INSERT INTO `by_member` VALUES ('820', '15800545306', '1', '0', '0', '2016-10-23 20:26:52', '1', null, null, null, null, null, '820');
INSERT INTO `by_member` VALUES ('821', '13917138481', '1', '0', '0', '2016-10-23 21:31:20', '1', null, null, null, null, null, '821');
INSERT INTO `by_member` VALUES ('822', '18612531203', '1', '0', '0', '2016-10-24 16:36:27', '1', null, null, null, null, null, '822');
INSERT INTO `by_member` VALUES ('823', '15021689396', '1', '0', '0', '2016-10-25 13:55:31', '1', null, null, null, null, null, '823');
INSERT INTO `by_member` VALUES ('824', '13671580229', '1', '0', '0', '2016-10-25 14:05:00', '1', null, null, null, null, null, '824');
INSERT INTO `by_member` VALUES ('825', '18736797231', '1', '0', '0', '2016-10-25 18:04:02', '1', null, null, null, null, null, '825');
INSERT INTO `by_member` VALUES ('826', '18736733057', '1', '0', '0', '2016-10-25 18:06:58', '1', null, null, null, null, null, '826');
INSERT INTO `by_member` VALUES ('827', '13482376435', '1', '0', '0', '2016-10-25 18:49:00', '1', null, null, null, null, null, '827');
INSERT INTO `by_member` VALUES ('828', '15000387934', '1', '0', '0', '2016-10-26 10:03:56', '1', null, null, null, null, null, '828');
INSERT INTO `by_member` VALUES ('829', '13816523102', '1', '0', '0', '2016-10-26 10:05:52', '1', null, null, null, null, null, '829');
INSERT INTO `by_member` VALUES ('830', '13482817833', '1', '0', '0', '2016-10-26 10:08:03', '1', null, null, null, null, null, '830');
INSERT INTO `by_member` VALUES ('831', '13917547518', '1', '0', '0', '2016-10-26 10:14:29', '1', null, null, null, null, null, '831');
INSERT INTO `by_member` VALUES ('832', '13341662613', '1', '0', '0', '2016-10-26 10:18:38', '1', null, null, null, null, null, '832');
INSERT INTO `by_member` VALUES ('833', '13818895605', '1', '0', '0', '2016-10-26 10:39:13', '1', null, null, null, null, null, '833');
INSERT INTO `by_member` VALUES ('834', '18017056849', '1', '0', '0', '2016-10-26 12:15:08', '1', null, null, null, null, null, '834');
INSERT INTO `by_member` VALUES ('835', '18301709251', '1', '0', '0', '2016-10-26 14:33:47', '1', null, null, null, null, null, '835');
INSERT INTO `by_member` VALUES ('836', '13764338496', '1', '0', '0', '2016-10-26 19:03:47', '1', null, null, null, null, null, '836');
INSERT INTO `by_member` VALUES ('837', '13564745031', '1', '0', '0', '2016-10-26 19:09:39', '1', null, null, null, null, null, '837');
INSERT INTO `by_member` VALUES ('838', '13761738416', '1', '0', '0', '2016-10-26 19:12:38', '1', null, null, null, null, null, '838');
INSERT INTO `by_member` VALUES ('839', '18964195720', '1', '0', '0', '2016-10-26 21:41:56', '1', null, null, null, null, null, '839');
INSERT INTO `by_member` VALUES ('840', '13917056658', '1', '0', '0', '2016-10-27 12:48:04', '1', null, null, null, null, null, '840');
INSERT INTO `by_member` VALUES ('841', '18918371879', '1', '0', '0', '2016-10-27 15:43:33', '1', null, null, null, null, null, '841');
INSERT INTO `by_member` VALUES ('842', '13918673548', '1', '0', '0', '2016-10-28 10:24:47', '1', null, null, null, null, null, '842');
INSERT INTO `by_member` VALUES ('843', '13991362724', '1', '0', '0', '2016-10-28 10:35:17', '1', null, null, null, null, null, '843');
INSERT INTO `by_member` VALUES ('844', '18016007636', '1', '0', '0', '2016-10-28 10:40:33', '1', null, null, null, null, null, '844');
INSERT INTO `by_member` VALUES ('845', '13901678925', '1', '0', '0', '2016-10-28 10:44:26', '1', null, null, null, null, null, '845');
INSERT INTO `by_member` VALUES ('846', '13816659346', '1', '0', '0', '2016-10-28 10:45:16', '1', null, null, null, null, null, '846');
INSERT INTO `by_member` VALUES ('847', '18516153258', '1', '0', '0', '2016-10-28 10:59:54', '1', null, null, null, null, null, '847');
INSERT INTO `by_member` VALUES ('848', '18918029397', '1', '0', '0', '2016-10-28 11:02:26', '1', null, null, null, null, null, '848');
INSERT INTO `by_member` VALUES ('849', '13916980615', '1', '0', '0', '2016-10-28 11:27:59', '1', null, null, null, null, null, '849');
INSERT INTO `by_member` VALUES ('850', '13701744126', '1', '0', '0', '2016-10-28 11:45:01', '1', null, null, null, null, null, '850');
INSERT INTO `by_member` VALUES ('851', '13761277067', '1', '0', '0', '2016-10-28 11:46:13', '1', null, null, null, null, null, '851');
INSERT INTO `by_member` VALUES ('852', '18217139206', '1', '0', '0', '2016-10-28 12:43:45', '1', null, null, null, null, null, '852');
INSERT INTO `by_member` VALUES ('853', '18602184987', '1', '0', '0', '2016-10-28 19:03:07', '1', null, null, null, null, null, '853');
INSERT INTO `by_member` VALUES ('854', '13182950763', '1', '0', '0', '2016-10-28 22:20:19', '1', null, null, null, null, null, '854');
INSERT INTO `by_member` VALUES ('855', '13916590928', '1', '0', '0', '2016-10-29 13:36:58', '1', null, null, null, null, null, '855');
INSERT INTO `by_member` VALUES ('856', '13817757313', '1', '0', '0', '2016-10-29 15:00:35', '1', null, null, null, null, null, '856');
INSERT INTO `by_member` VALUES ('857', '13761625125', '1', '0', '0', '2016-10-29 19:18:34', '1', null, null, null, null, null, '857');
INSERT INTO `by_member` VALUES ('858', '13564634301', '1', '0', '0', '2016-10-29 20:33:31', '1', null, null, null, null, null, '858');
INSERT INTO `by_member` VALUES ('859', '13512167795', '1', '0', '0', '2016-10-30 09:00:40', '1', null, null, null, null, null, '859');
INSERT INTO `by_member` VALUES ('860', '13601769348', '1', '0', '0', '2016-10-30 10:37:05', '1', null, null, null, null, null, '860');
INSERT INTO `by_member` VALUES ('861', '13641831436', '1', '0', '0', '2016-10-30 12:39:09', '1', null, null, null, null, null, '861');
INSERT INTO `by_member` VALUES ('862', '13818434312', '1', '0', '0', '2016-10-30 12:39:10', '1', null, null, null, null, null, '862');
INSERT INTO `by_member` VALUES ('863', '13761049975', '1', '0', '0', '2016-10-30 14:22:18', '1', null, null, null, null, null, '863');
INSERT INTO `by_member` VALUES ('864', '13611712515', '1', '0', '0', '2016-10-30 15:23:46', '1', null, null, null, null, null, '864');
INSERT INTO `by_member` VALUES ('865', '13636313220', '1', '0', '0', '2016-10-30 15:45:05', '1', null, null, null, null, null, '865');
INSERT INTO `by_member` VALUES ('866', '13801909540', '1', '0', '0', '2016-10-30 16:20:23', '1', null, null, null, null, null, '866');
INSERT INTO `by_member` VALUES ('867', '13918797745', '1', '0', '0', '2016-10-30 16:41:55', '1', null, null, null, null, null, '867');
INSERT INTO `by_member` VALUES ('868', '15001719784', '1', '0', '0', '2016-10-30 17:37:02', '1', null, null, null, null, null, '868');
INSERT INTO `by_member` VALUES ('869', '13564626570', '1', '0', '0', '2016-10-30 17:39:10', '1', null, null, null, null, null, '869');
INSERT INTO `by_member` VALUES ('870', '13917982393', '1', '0', '0', '2016-10-30 17:54:13', '1', null, null, null, null, null, '870');
INSERT INTO `by_member` VALUES ('871', '13917332243', '1', '0', '0', '2016-10-30 18:36:30', '1', null, null, null, null, null, '871');
INSERT INTO `by_member` VALUES ('872', '13636541169', '1', '0', '0', '2016-10-30 19:06:43', '1', null, null, null, null, null, '872');
INSERT INTO `by_member` VALUES ('873', '13795228827', '1', '0', '0', '2016-10-30 20:09:44', '1', null, null, null, null, null, '873');
INSERT INTO `by_member` VALUES ('874', '15821623029', '1', '0', '0', '2016-10-30 20:34:13', '1', null, null, null, null, null, '874');
INSERT INTO `by_member` VALUES ('875', '15900525055', '1', '0', '0', '2016-10-30 23:16:19', '1', null, null, null, null, null, '875');
INSERT INTO `by_member` VALUES ('876', '13916730975', '1', '0', '0', '2016-11-01 07:36:37', '1', null, null, null, null, null, '876');
INSERT INTO `by_member` VALUES ('877', '15821978740', '1', '0', '0', '2016-11-01 10:51:01', '1', null, null, null, null, null, '877');
INSERT INTO `by_member` VALUES ('878', '13818719118', '1', '0', '0', '2016-11-01 14:22:43', '1', null, null, null, null, null, '878');
INSERT INTO `by_member` VALUES ('879', '15800489018', '1', '0', '0', '2016-11-01 23:48:53', '1', null, null, null, null, null, '879');
INSERT INTO `by_member` VALUES ('880', '18302162895', '1', '0', '0', '2016-11-02 12:36:09', '1', null, null, null, null, null, '880');
INSERT INTO `by_member` VALUES ('881', '13671833886', '1', '0', '0', '2016-11-02 12:51:18', '1', null, null, null, null, null, '881');
INSERT INTO `by_member` VALUES ('882', '18930875977', '1', '0', '0', '2016-11-02 18:59:57', '1', null, null, null, null, null, '882');
INSERT INTO `by_member` VALUES ('883', '13671999079', '1', '0', '0', '2016-11-03 11:36:32', '1', null, null, null, null, null, '883');
INSERT INTO `by_member` VALUES ('884', '13020159376', '1', '0', '0', '2016-11-03 19:04:34', '1', null, null, null, null, null, '884');
INSERT INTO `by_member` VALUES ('885', '18616161002', '1', '0', '0', '2016-11-04 15:24:12', '1', null, null, null, null, null, '885');
INSERT INTO `by_member` VALUES ('886', '13641988959', '1', '0', '0', '2016-11-05 08:25:35', '1', null, null, null, null, null, '886');
INSERT INTO `by_member` VALUES ('887', '13866377848', '1', '0', '0', '2016-11-05 13:10:23', '1', null, null, null, null, null, '887');
INSERT INTO `by_member` VALUES ('888', '13636614368', '1', '0', '0', '2016-11-05 17:51:58', '1', null, null, null, null, null, '888');
INSERT INTO `by_member` VALUES ('889', '13636400862', '1', '0', '0', '2016-11-05 19:33:24', '1', null, null, null, null, null, '889');
INSERT INTO `by_member` VALUES ('890', '18616845866', '1', '0', '0', '2016-11-05 19:53:14', '1', null, null, null, null, null, '890');
INSERT INTO `by_member` VALUES ('891', '13166338008', '1', '0', '0', '2016-11-06 11:36:08', '1', null, null, null, null, null, '891');
INSERT INTO `by_member` VALUES ('892', '18702180082', '1', '0', '0', '2016-11-06 15:17:19', '1', null, null, null, null, null, '892');
INSERT INTO `by_member` VALUES ('893', '15000283526', '1', '0', '0', '2016-11-06 15:41:44', '1', null, null, null, null, null, '893');
INSERT INTO `by_member` VALUES ('894', '13341835989', '1', '0', '0', '2016-11-06 16:23:24', '1', null, null, null, null, null, '894');
INSERT INTO `by_member` VALUES ('895', '13585824090', '1', '0', '0', '2016-11-06 18:31:36', '1', null, null, null, null, null, '895');
INSERT INTO `by_member` VALUES ('896', '18516299360', '1', '0', '0', '2016-11-06 23:05:32', '1', null, null, null, null, null, '896');
INSERT INTO `by_member` VALUES ('897', '18516582886', '1', '0', '0', '2016-11-07 20:31:37', '1', null, null, null, null, null, '897');
INSERT INTO `by_member` VALUES ('898', '13816240939', '1', '0', '0', '2016-11-09 20:44:29', '1', null, null, null, null, null, '898');
INSERT INTO `by_member` VALUES ('899', '13916413070', '1', '0', '0', '2016-11-09 20:57:21', '1', null, null, null, null, null, '899');
INSERT INTO `by_member` VALUES ('900', '13917720729', '1', '0', '0', '2016-11-09 20:57:46', '1', null, null, null, null, null, '900');
INSERT INTO `by_member` VALUES ('901', '13918475437', '1', '0', '0', '2016-11-10 08:14:38', '1', null, null, null, null, null, '901');
INSERT INTO `by_member` VALUES ('902', '15801860361', '1', '0', '0', '2016-11-10 09:22:20', '1', null, null, null, null, null, '902');
INSERT INTO `by_member` VALUES ('903', '15002197985', '1', '0', '0', '2016-11-10 21:18:28', '1', null, null, null, null, null, '903');
INSERT INTO `by_member` VALUES ('904', '13301892987', '1', '0', '0', '2016-11-11 15:35:19', '1', null, null, null, null, null, '904');
INSERT INTO `by_member` VALUES ('905', '15905267593', '1', '0', '0', '2016-11-11 17:58:30', '1', null, null, null, null, null, '905');
INSERT INTO `by_member` VALUES ('906', '15021640322', '1', '0', '0', '2016-11-11 19:39:49', '1', null, null, null, null, null, '906');
INSERT INTO `by_member` VALUES ('907', '13764554559', '1', '0', '0', '2016-11-11 21:34:23', '1', null, null, null, null, null, '907');
INSERT INTO `by_member` VALUES ('908', '13801963150', '1', '0', '0', '2016-11-12 17:17:55', '1', null, null, null, null, null, '908');
INSERT INTO `by_member` VALUES ('909', '18918379701', '1', '0', '0', '2016-11-12 20:53:15', '1', null, null, null, null, null, '909');
INSERT INTO `by_member` VALUES ('910', '13661466520', '1', '0', '0', '2016-11-13 13:24:30', '1', null, null, null, null, null, '910');
INSERT INTO `by_member` VALUES ('911', '13601900799', '1', '0', '0', '2016-11-13 14:14:16', '1', null, null, null, null, null, '911');
INSERT INTO `by_member` VALUES ('912', '13818728574', '1', '0', '0', '2016-11-14 12:44:54', '1', null, null, null, null, null, '912');
INSERT INTO `by_member` VALUES ('913', '15921990721', '1', '0', '0', '2016-11-14 20:32:53', '1', null, null, null, null, null, '913');
INSERT INTO `by_member` VALUES ('914', '18918585201', '1', '0', '0', '2016-11-15 22:58:03', '1', null, null, null, null, null, '914');
INSERT INTO `by_member` VALUES ('915', '18521529968', '1', '0', '0', '2016-11-16 14:52:56', '1', null, null, null, null, null, '915');
INSERT INTO `by_member` VALUES ('916', '13917249220', '1', '0', '0', '2016-11-17 11:21:14', '1', null, null, null, null, null, '916');
INSERT INTO `by_member` VALUES ('917', '13761685877', '1', '0', '0', '2016-11-17 17:10:25', '1', null, null, null, null, null, '917');
INSERT INTO `by_member` VALUES ('918', '13817554791', '1', '0', '0', '2016-11-17 19:33:51', '1', null, null, null, null, null, '918');
INSERT INTO `by_member` VALUES ('919', '13524299887', '1', '0', '0', '2016-11-17 21:30:56', '1', null, null, null, null, null, '919');
INSERT INTO `by_member` VALUES ('920', '15900717546', '1', '0', '0', '2016-11-17 22:01:57', '1', null, null, null, null, null, '920');
INSERT INTO `by_member` VALUES ('921', '13661967798', '1', '0', '0', '2016-11-18 06:09:44', '1', null, null, null, null, null, '921');
INSERT INTO `by_member` VALUES ('922', '13761027358', '1', '0', '0', '2016-11-18 09:50:02', '1', null, null, null, null, null, '922');
INSERT INTO `by_member` VALUES ('923', '13761908097', '1', '0', '0', '2016-11-18 11:45:27', '1', null, null, null, null, null, '923');
INSERT INTO `by_member` VALUES ('924', '13764364672', '1', '0', '0', '2016-11-18 15:06:37', '1', null, null, null, null, null, '924');
INSERT INTO `by_member` VALUES ('925', '13816125289', '1', '0', '0', '2016-11-19 09:07:15', '1', null, null, null, null, null, '925');
INSERT INTO `by_member` VALUES ('926', '15000493905', '1', '0', '0', '2016-11-19 12:46:04', '1', null, null, null, null, null, '926');
INSERT INTO `by_member` VALUES ('927', '13818199285', '1', '0', '0', '2016-11-19 14:11:12', '1', null, null, null, null, null, '927');
INSERT INTO `by_member` VALUES ('928', '13701972715', '1', '0', '0', '2016-11-19 21:13:33', '1', null, null, null, null, null, '928');
INSERT INTO `by_member` VALUES ('929', '15121193669', '1', '0', '0', '2016-11-20 16:25:44', '1', null, null, null, null, null, '929');
INSERT INTO `by_member` VALUES ('930', '13564304879', '1', '0', '0', '2016-11-20 17:44:48', '1', null, null, null, null, null, '930');
INSERT INTO `by_member` VALUES ('931', '15921522230', '1', '0', '0', '2016-11-20 20:59:06', '1', null, null, null, null, null, '931');
INSERT INTO `by_member` VALUES ('932', '18701785969', '1', '0', '0', '2016-11-20 21:56:20', '1', null, null, null, null, null, '932');
INSERT INTO `by_member` VALUES ('933', '13235318359', '1', '0', '0', '2016-11-21 11:31:12', '1', null, null, null, null, null, '933');
INSERT INTO `by_member` VALUES ('934', '18621072148', '1', '0', '0', '2016-11-21 17:11:14', '1', null, null, null, null, null, '934');
INSERT INTO `by_member` VALUES ('935', '18221994771', '1', '0', '0', '2016-11-21 19:21:19', '1', null, null, null, null, null, '935');
INSERT INTO `by_member` VALUES ('936', '18221933298', '1', '0', '0', '2016-11-22 10:37:23', '1', null, null, null, null, null, '936');
INSERT INTO `by_member` VALUES ('937', '13661621241', '1', '0', '0', '2016-11-22 18:49:52', '1', null, null, null, null, null, '937');
INSERT INTO `by_member` VALUES ('938', '13361837930', '1', '0', '0', '2016-11-23 14:30:00', '1', null, null, null, null, null, '938');
INSERT INTO `by_member` VALUES ('939', '13774254253', '1', '0', '0', '2016-11-23 15:18:26', '1', null, null, null, null, null, '939');
INSERT INTO `by_member` VALUES ('940', '13817203482', '1', '0', '0', '2016-11-23 15:58:09', '1', null, null, null, null, null, '940');
INSERT INTO `by_member` VALUES ('941', '13816294777', '1', '0', '0', '2016-11-23 20:42:37', '1', null, null, null, null, null, '941');
INSERT INTO `by_member` VALUES ('942', '15821795855', '1', '0', '0', '2016-11-24 11:51:53', '1', null, null, null, null, null, '942');
INSERT INTO `by_member` VALUES ('943', '13601669318', '1', '0', '0', '2016-11-26 10:41:34', '1', null, null, null, null, null, '943');
INSERT INTO `by_member` VALUES ('944', '13916798702', '1', '0', '0', '2016-11-26 19:07:32', '1', null, null, null, null, null, '944');
INSERT INTO `by_member` VALUES ('945', '13917784048', '1', '0', '0', '2016-11-27 11:20:59', '1', null, null, null, null, null, '945');
INSERT INTO `by_member` VALUES ('946', '13621696756', '1', '0', '0', '2016-11-27 12:42:38', '1', null, null, null, null, null, '946');
INSERT INTO `by_member` VALUES ('947', '13817866793', '1', '0', '0', '2016-11-27 14:18:03', '1', null, null, null, null, null, '947');

-- ----------------------------
-- Table structure for by_member_detail
-- ----------------------------
DROP TABLE IF EXISTS `by_member_detail`;
CREATE TABLE `by_member_detail` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `real_name` varchar(10) CHARACTER SET gb2312 DEFAULT NULL,
  `address` varchar(225) DEFAULT NULL,
  `password` char(64) DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `ic` char(18) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=948 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_member_detail
-- ----------------------------
INSERT INTO `by_member_detail` VALUES ('37', null, null, null, null, null, '2016-09-06 00:12:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('38', null, null, null, null, null, '2016-09-06 11:58:21', null, null, null);
INSERT INTO `by_member_detail` VALUES ('39', '陈颖', '', '4bb6b108c51c31a11fae223d5a97945390b170b8065b7dc05e6984bfa8f31907', '1973-08-20 00:00:00', '310101197308204824', '2016-09-06 16:43:07', '2016-09-06 17:38:40', null, null);
INSERT INTO `by_member_detail` VALUES ('40', null, null, null, null, null, '2016-09-06 16:49:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('41', null, null, null, null, null, '2016-09-06 16:49:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('42', null, null, null, null, null, '2016-09-06 16:49:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('43', null, null, null, null, null, '2016-09-07 13:49:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('44', null, null, null, null, null, '2016-09-07 13:50:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('45', null, null, null, null, null, '2016-09-07 13:50:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('46', null, null, null, null, null, '2016-09-07 13:50:40', null, null, null);
INSERT INTO `by_member_detail` VALUES ('47', '', 'vvcvvvvcc', '14003029ffe4f2d8316531684d259b9085e4bb2efa7235c73920b16a22af0f68', '1984-10-01 00:00:00', '412723198410015991', '2016-09-07 22:15:19', '2016-09-07 22:18:36', null, null);
INSERT INTO `by_member_detail` VALUES ('48', null, null, null, null, null, '2016-09-07 22:15:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('49', null, null, null, null, null, '2016-09-07 22:21:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('50', '王小姐', '张桥', null, '1986-09-10 23:00:00', '', '2016-09-07 23:01:48', '2016-09-07 23:02:41', null, null);
INSERT INTO `by_member_detail` VALUES ('51', null, null, null, null, null, '2016-09-07 23:18:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('52', '吴方烨', '上海市浦东新区莱阳路451-22-201', null, '1994-10-08 00:00:00', '310115199410080626', '2016-09-07 23:46:03', '2016-09-07 23:46:36', null, null);
INSERT INTO `by_member_detail` VALUES ('53', '', '', null, '2016-07-03 00:00:00', '', '2016-09-08 00:02:48', '2016-09-11 18:43:20', null, null);
INSERT INTO `by_member_detail` VALUES ('54', null, null, null, null, null, '2016-09-08 00:06:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('55', '陈笛', '永宁路33弄14号303', null, '1976-06-18 00:00:00', '310224197606182811', '2016-09-08 00:07:39', '2016-09-08 00:09:50', null, null);
INSERT INTO `by_member_detail` VALUES ('56', null, null, null, null, null, '2016-09-08 00:18:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('57', null, null, null, null, null, '2016-09-08 01:05:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('58', null, null, null, null, null, '2016-09-08 01:17:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('59', null, null, null, null, null, '2016-09-08 05:46:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('60', null, null, null, null, null, '2016-09-08 05:50:40', null, null, null);
INSERT INTO `by_member_detail` VALUES ('61', null, null, null, null, null, '2016-09-08 06:47:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('62', null, null, null, null, null, '2016-09-08 06:53:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('63', null, null, null, null, null, '2016-09-08 06:58:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('64', null, null, null, null, null, '2016-09-08 07:06:50', null, null, null);
INSERT INTO `by_member_detail` VALUES ('65', null, null, '18fbe54dadcf9cffd6b307144803b7f681a4315d425908f3dc4fa91782350137', null, null, '2016-09-08 07:13:38', '2016-09-08 07:22:13', null, null);
INSERT INTO `by_member_detail` VALUES ('66', null, null, null, null, null, '2016-09-08 07:30:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('67', null, null, null, null, null, '2016-09-08 07:30:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('68', null, null, null, null, null, '2016-09-08 08:02:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('69', null, null, null, null, null, '2016-09-08 08:18:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('70', null, null, null, null, null, '2016-09-08 08:21:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('71', null, null, null, null, null, '2016-09-08 08:46:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('72', null, null, null, null, null, '2016-09-08 09:01:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('73', '王丽华', '', null, null, '', '2016-09-08 09:04:34', '2016-09-08 09:50:43', null, null);
INSERT INTO `by_member_detail` VALUES ('74', null, null, null, null, null, '2016-09-08 09:08:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('75', null, null, null, null, null, '2016-09-08 09:12:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('76', null, null, null, null, null, '2016-09-08 09:22:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('77', '张岚', '金高路2131弄2号302室', '5a58d36b723153363f67a6975971aa3addb9cffa0d2bb023e83e251708334049', '1984-11-09 00:00:00', '310115198411094427', '2016-09-08 09:30:28', '2016-09-08 09:32:38', null, null);
INSERT INTO `by_member_detail` VALUES ('78', null, null, null, null, null, '2016-09-08 09:30:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('79', null, null, null, null, null, '2016-09-08 09:34:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('80', null, null, null, null, null, '2016-09-08 09:35:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('81', '尹怡', '', null, null, '', '2016-09-08 09:56:28', '2016-09-14 17:19:38', null, null);
INSERT INTO `by_member_detail` VALUES ('82', null, null, null, null, null, '2016-09-08 09:58:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('83', '朱先生', '', '8b0f6816d4fb303d0dabb3ae80b66b86417aced94188d853ab0e518cdcd76eb1', '2016-09-29 00:00:00', '', '2016-09-08 09:59:09', '2016-09-08 12:32:42', null, null);
INSERT INTO `by_member_detail` VALUES ('84', null, null, null, null, null, '2016-09-08 10:17:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('85', '李仕俊', '闸北区西宝兴路922弄5号301室', '406960020bebb0a5a3205e7a01766c8503115357d082a34c070834e50837c7dd', '1984-05-12 00:00:00', '310109198405120011', '2016-09-08 10:20:42', '2016-09-08 10:23:30', null, null);
INSERT INTO `by_member_detail` VALUES ('86', '', '双桥路1108弄2号404室', null, '1982-11-23 00:00:00', '', '2016-09-08 10:44:32', '2016-09-08 10:46:29', null, null);
INSERT INTO `by_member_detail` VALUES ('87', '华先生', '', null, '1984-08-05 00:00:00', '', '2016-09-08 10:46:15', '2016-09-08 10:47:01', null, null);
INSERT INTO `by_member_detail` VALUES ('88', null, null, null, null, null, '2016-09-08 10:50:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('89', null, null, null, null, null, '2016-09-08 10:52:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('90', '', '永建路86弄3号401室', 'bc39d83f620cbbfc4a17a5aaf30fb575fbee04680ba72e2427034a06929f74a6', '1986-06-02 23:00:00', '', '2016-09-08 10:56:34', '2016-09-08 10:58:45', null, null);
INSERT INTO `by_member_detail` VALUES ('91', null, null, null, null, null, '2016-09-08 10:59:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('92', null, null, null, null, null, '2016-09-08 11:03:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('93', null, null, null, null, null, '2016-09-08 11:03:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('94', null, null, null, null, null, '2016-09-08 11:04:41', null, null, null);
INSERT INTO `by_member_detail` VALUES ('95', null, null, null, null, null, '2016-09-08 11:11:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('96', null, null, null, null, null, '2016-09-08 11:21:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('97', null, null, null, null, null, '2016-09-08 11:21:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('98', null, null, null, null, null, '2016-09-08 11:24:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('99', '龚黎', '张杨北路2899弄18号201室', 'fe6c77fe3dacc68a741cf8b77e190f6415629a86ed13366c652dd29b1c5315a3', '1977-11-08 00:00:00', '', '2016-09-08 11:39:30', '2016-09-08 11:42:33', null, null);
INSERT INTO `by_member_detail` VALUES ('100', '倪珍琦', '上海浦东新区金高路1740号', '04e89c71d7fc4838e7c6423c36e95b0944a17051f00c4d0c0c1f3d69959d6a1b', '2005-04-08 00:00:00', '330382200504082868', '2016-09-08 11:50:36', '2016-09-08 20:07:51', null, null);
INSERT INTO `by_member_detail` VALUES ('101', '丁丁', '', null, null, '', '2016-09-08 11:51:26', '2016-09-08 11:51:53', null, null);
INSERT INTO `by_member_detail` VALUES ('102', null, null, null, null, null, '2016-09-08 12:01:22', null, null, null);
INSERT INTO `by_member_detail` VALUES ('103', '李纲', '佳林路919弄30号201室', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1978-01-30 00:00:00', '610111197801305139', '2016-09-08 12:03:02', '2016-09-08 12:09:15', null, null);
INSERT INTO `by_member_detail` VALUES ('104', null, null, 'c6470a71212586010744706f179af7863fe6a333f0717ba87744da4ce92ba8e7', null, null, '2016-09-08 12:03:57', '2016-09-08 12:05:12', null, null);
INSERT INTO `by_member_detail` VALUES ('105', null, null, null, null, null, '2016-09-08 12:08:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('106', null, null, null, null, null, '2016-09-08 12:20:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('107', '张佳燕', '', null, null, '', '2016-09-08 12:29:41', '2016-09-08 12:30:22', null, null);
INSERT INTO `by_member_detail` VALUES ('108', '', '金高路1617弄188号5室', '245c04351a327cc36db4531d41f81327a02b92c76c8745a7326a14e9f9656663', '1982-03-15 00:00:00', '510703198203152420', '2016-09-08 12:46:39', '2016-09-08 12:49:33', null, null);
INSERT INTO `by_member_detail` VALUES ('109', null, null, null, null, null, '2016-09-08 12:46:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('110', '沈玉妹', '博兴路1383弄18号302室', 'e7fcf5624c3b1d54c28b83629f36bd4bd9a1fc2d8a0dc89049519b83316b0e1f', '1985-12-19 00:00:00', '310115198512190944', '2016-09-08 12:50:04', '2016-09-08 12:52:17', null, null);
INSERT INTO `by_member_detail` VALUES ('111', null, null, null, null, null, '2016-09-08 12:55:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('112', null, null, null, null, null, '2016-09-08 13:01:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('113', null, null, null, null, null, '2016-09-08 13:22:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('114', null, null, null, null, null, '2016-09-08 13:24:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('115', '', '东陆路1528弄9号601室', null, '1982-04-27 00:00:00', '310230198204274766', '2016-09-08 13:25:15', '2016-09-08 13:28:41', null, null);
INSERT INTO `by_member_detail` VALUES ('116', '甜妈', '', null, '1998-03-24 00:00:00', '', '2016-09-08 13:25:31', '2016-09-08 13:26:35', null, null);
INSERT INTO `by_member_detail` VALUES ('117', null, null, null, null, null, '2016-09-08 13:29:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('118', '张淑颖', '', null, '1983-02-04 00:00:00', '', '2016-09-08 13:41:04', '2016-09-08 13:48:22', null, null);
INSERT INTO `by_member_detail` VALUES ('119', null, null, null, null, null, '2016-09-08 13:49:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('120', null, null, null, null, null, '2016-09-08 13:50:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('121', null, null, null, null, null, '2016-09-08 13:50:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('122', null, null, null, null, null, '2016-09-08 13:51:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('123', 'eric', '', null, null, '', '2016-09-08 14:06:50', '2016-09-08 14:07:23', null, null);
INSERT INTO `by_member_detail` VALUES ('124', null, null, null, null, null, '2016-09-08 14:08:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('125', '', '', 'dfb120fc01c3748e6a39d123f587e9c9855866f0459b5e32621e95824d617ed7', '1992-01-30 00:00:00', '', '2016-09-08 14:10:23', '2016-09-08 14:11:27', null, null);
INSERT INTO `by_member_detail` VALUES ('126', '', '东陆路2000弄31号102室', '8dce461ae21e7d40e1335337bf5c1be135fe854c071bd37c91aacbf75a1f3387', '1987-03-07 00:00:00', '', '2016-09-08 14:12:55', '2016-09-08 14:16:04', null, null);
INSERT INTO `by_member_detail` VALUES ('127', '', '浦东新区张桥佳林路898弄9号502室', '9ef2989b6f7330b1964123816e48ffb9d8ac8af615e6a4c799c8b0392af50031', '1990-03-23 00:00:00', '310115199003234712', '2016-09-08 14:31:05', '2016-09-08 14:33:05', null, null);
INSERT INTO `by_member_detail` VALUES ('128', null, null, null, null, null, '2016-09-08 14:34:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('129', null, null, null, null, null, '2016-09-08 14:38:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('130', null, null, null, null, null, '2016-09-08 14:39:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('131', null, null, null, null, null, '2016-09-08 14:41:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('132', null, null, null, null, null, '2016-09-08 14:55:54', null, null, null);
INSERT INTO `by_member_detail` VALUES ('133', null, null, null, null, null, '2016-09-08 15:01:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('134', null, null, null, null, null, '2016-09-08 15:01:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('135', null, null, null, null, null, '2016-09-08 15:10:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('136', null, null, null, null, null, '2016-09-08 15:18:40', null, null, null);
INSERT INTO `by_member_detail` VALUES ('137', null, null, null, null, null, '2016-09-08 15:20:06', null, null, null);
INSERT INTO `by_member_detail` VALUES ('138', null, null, null, null, null, '2016-09-08 15:35:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('139', '', '', null, '1984-08-26 00:00:00', '310110198408261050', '2016-09-08 15:46:32', '2016-09-08 15:47:59', null, null);
INSERT INTO `by_member_detail` VALUES ('140', '王依雯', '五莲路1424弄56号301室', null, '1995-08-31 00:00:00', '310115199508310629', '2016-09-08 15:58:48', '2016-09-08 15:59:32', null, null);
INSERT INTO `by_member_detail` VALUES ('141', '', '利津路185弄15号302', '5f178b0e593617c7a0f10efa795c573550e7ba4c0cc28f2d4d5b6a148b34ced2', '1986-07-31 23:00:00', '310115198608010637', '2016-09-08 16:05:59', '2016-09-08 16:08:10', null, null);
INSERT INTO `by_member_detail` VALUES ('142', '盛小姐', '', null, null, '', '2016-09-08 16:16:21', '2016-09-08 16:16:59', null, null);
INSERT INTO `by_member_detail` VALUES ('143', '顾蓓', '', null, '1989-03-16 00:00:00', '', '2016-09-08 16:34:29', '2016-09-08 16:35:03', null, null);
INSERT INTO `by_member_detail` VALUES ('144', null, null, null, null, null, '2016-09-08 16:35:41', null, null, null);
INSERT INTO `by_member_detail` VALUES ('145', null, null, null, null, null, '2016-09-08 17:04:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('146', null, null, null, null, null, '2016-09-08 17:11:40', null, null, null);
INSERT INTO `by_member_detail` VALUES ('147', null, null, null, null, null, '2016-09-08 17:13:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('148', '朱李华', '永建路86弄10号201室', 'e3eb89290275874c4ff4f005e24cbd920d74388f38d46f9a57957c9236b61f47', '1979-06-10 00:00:00', '310110197906103210', '2016-09-08 17:14:04', '2016-09-08 17:17:01', null, null);
INSERT INTO `by_member_detail` VALUES ('149', null, null, null, null, null, '2016-09-08 17:24:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('150', null, null, null, null, null, '2016-09-08 18:10:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('151', '金香淑', '金高路2131弄40号501室', null, '1982-10-01 00:00:00', '232330198210011425', '2016-09-08 18:15:45', '2016-09-08 18:17:13', null, null);
INSERT INTO `by_member_detail` VALUES ('152', null, null, null, null, null, '2016-09-08 18:17:40', null, null, null);
INSERT INTO `by_member_detail` VALUES ('153', null, null, null, null, null, '2016-09-08 18:17:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('154', null, null, null, null, null, '2016-09-08 18:18:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('155', null, null, null, null, null, '2016-09-08 18:24:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('156', null, null, '7b3c8938560dc3d4f606c87e03dfc24281b42905988fe2e0660d82ad79a8f469', null, null, '2016-09-08 18:24:40', '2016-09-08 18:33:06', null, null);
INSERT INTO `by_member_detail` VALUES ('157', '李名山', '永业路94-49-203', null, null, '', '2016-09-08 18:36:28', '2016-09-08 18:56:52', null, null);
INSERT INTO `by_member_detail` VALUES ('158', null, null, null, null, null, '2016-09-08 18:42:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('159', null, null, null, null, null, '2016-09-08 18:57:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('160', null, null, null, null, null, '2016-09-08 19:02:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('161', null, null, null, null, null, '2016-09-08 19:14:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('162', null, null, null, null, null, '2016-09-08 19:28:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('163', null, null, null, null, null, '2016-09-08 19:31:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('164', null, null, null, null, null, '2016-09-08 19:36:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('165', '', '上海市浦东新区金桥镇佳乐路255弄33号302室', 'd178b6518f6dbf7c9a78ff49b0acff8ab338bac59b086136a7eedecc9f4771f3', '1986-01-02 00:00:00', '310115198601024710', '2016-09-08 19:42:05', '2016-10-03 22:37:57', null, null);
INSERT INTO `by_member_detail` VALUES ('166', null, null, null, null, null, '2016-09-08 19:45:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('167', null, null, null, null, null, '2016-09-08 19:45:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('168', '庞长俊', '上海市浦东新区永宁路33 弄阳光城市家园6号601', '287ebce8058132925807647969520ae65a1ef5f92a4516f625a9408501900745', '1981-05-05 00:00:00', '321088198105056110', '2016-09-08 19:57:42', '2016-10-20 20:01:46', null, null);
INSERT INTO `by_member_detail` VALUES ('169', null, null, null, null, null, '2016-09-08 20:00:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('170', '', '', '40ce9480da8fe78cb773ca94a4c64e3f7513ca42c51d8f1e950a49004ad7ed11', null, '', '2016-09-08 20:02:39', '2016-09-08 20:04:05', null, null);
INSERT INTO `by_member_detail` VALUES ('171', null, null, null, null, null, '2016-09-08 20:07:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('172', null, null, null, null, null, '2016-09-08 20:11:40', null, null, null);
INSERT INTO `by_member_detail` VALUES ('173', null, null, null, null, null, '2016-09-08 20:17:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('174', null, null, null, null, null, '2016-09-08 20:37:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('175', null, null, null, null, null, '2016-09-08 20:45:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('176', null, null, null, null, null, '2016-09-08 20:57:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('177', null, null, null, null, null, '2016-09-08 20:58:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('178', '', '', null, null, '', '2016-09-08 21:03:22', '2016-09-08 21:04:32', null, null);
INSERT INTO `by_member_detail` VALUES ('179', '', '', null, null, '', '2016-09-08 21:15:24', '2016-09-08 21:16:17', null, null);
INSERT INTO `by_member_detail` VALUES ('180', null, null, null, null, null, '2016-09-08 21:35:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('181', null, null, null, null, null, '2016-09-08 21:37:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('182', null, null, null, null, null, '2016-09-08 21:40:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('183', '', '', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, '', '2016-09-08 21:49:33', '2016-09-08 21:54:10', null, null);
INSERT INTO `by_member_detail` VALUES ('184', null, null, null, null, null, '2016-09-08 21:52:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('185', null, null, null, null, null, '2016-09-08 21:54:50', null, null, null);
INSERT INTO `by_member_detail` VALUES ('186', '杨威', '佳林路838弄3号602室', null, '1986-12-01 00:00:00', '310230198612010495', '2016-09-08 21:55:51', '2016-09-08 21:57:10', null, null);
INSERT INTO `by_member_detail` VALUES ('187', null, null, null, null, null, '2016-09-08 21:59:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('188', '张艳璐', '', null, null, '', '2016-09-08 22:03:44', '2016-09-08 22:04:15', null, null);
INSERT INTO `by_member_detail` VALUES ('189', null, null, null, null, null, '2016-09-08 22:24:54', null, null, null);
INSERT INTO `by_member_detail` VALUES ('190', null, null, null, null, null, '2016-09-08 22:49:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('191', null, null, null, null, null, '2016-09-08 22:52:22', null, null, null);
INSERT INTO `by_member_detail` VALUES ('192', '朱玲', '', null, '1986-10-26 00:00:00', '', '2016-09-08 22:58:05', '2016-09-08 22:58:57', null, null);
INSERT INTO `by_member_detail` VALUES ('193', null, null, null, null, null, '2016-09-08 23:03:21', null, null, null);
INSERT INTO `by_member_detail` VALUES ('194', null, null, null, null, null, '2016-09-08 23:08:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('195', null, null, null, null, null, '2016-09-08 23:11:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('196', null, null, null, null, null, '2016-09-08 23:41:57', null, null, null);
INSERT INTO `by_member_detail` VALUES ('197', null, null, null, null, null, '2016-09-09 00:26:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('198', '张瑾', '', 'd3fe9f4ff3a147e4f0c95a939007a6668c0a5ba95a9ece03d7f3acbce562d03c', '1982-08-15 00:00:00', '', '2016-09-09 01:44:21', '2016-09-29 13:26:16', null, null);
INSERT INTO `by_member_detail` VALUES ('199', null, null, null, null, null, '2016-09-09 02:51:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('200', null, null, null, null, null, '2016-09-09 06:29:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('201', '顾晓青', '', null, '1986-03-16 00:00:00', '', '2016-09-09 06:49:14', '2016-09-09 06:49:57', null, null);
INSERT INTO `by_member_detail` VALUES ('202', null, null, null, null, null, '2016-09-09 07:03:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('203', null, null, null, null, null, '2016-09-09 07:13:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('204', '张先生', '', null, '2016-09-09 00:00:00', '', '2016-09-09 07:16:07', '2016-09-09 07:17:23', null, null);
INSERT INTO `by_member_detail` VALUES ('205', null, null, null, null, null, '2016-09-09 07:20:35', null, null, null);
INSERT INTO `by_member_detail` VALUES ('206', null, null, null, null, null, '2016-09-09 07:41:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('207', null, null, null, null, null, '2016-09-09 07:45:34', null, null, null);
INSERT INTO `by_member_detail` VALUES ('208', null, null, null, null, null, '2016-09-09 08:19:34', null, null, null);
INSERT INTO `by_member_detail` VALUES ('209', 'chloe', '', null, null, '', '2016-09-09 09:07:57', '2016-09-09 09:08:33', null, null);
INSERT INTO `by_member_detail` VALUES ('210', null, null, null, null, null, '2016-09-09 09:41:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('211', '', '上海市浦东新区东波路192弄12号502室', 'a9c7768dbdc178297de29dee1f78367e2e85a89861ce31fdb51c8a13cd477cdf', '1979-07-31 00:00:00', '310115197907314724', '2016-09-09 09:43:36', '2016-09-09 09:46:13', null, null);
INSERT INTO `by_member_detail` VALUES ('212', null, null, null, null, null, '2016-09-09 09:49:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('213', null, null, null, null, null, '2016-09-09 10:02:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('214', null, null, null, null, null, '2016-09-09 10:04:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('215', '', '', '4bfa06253c49b63f1b3872acd5d5c9e8dc682e1016e79bc2e1543c8771adef26', '1992-05-19 00:00:00', '310115199205194712', '2016-09-09 10:11:51', '2016-09-09 10:13:14', null, null);
INSERT INTO `by_member_detail` VALUES ('216', '陈效忠', '佳林路', null, '1981-07-27 00:00:00', '', '2016-09-09 11:13:04', '2016-09-09 11:14:33', null, null);
INSERT INTO `by_member_detail` VALUES ('217', null, null, null, null, null, '2016-09-09 11:18:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('218', null, null, null, null, null, '2016-09-09 11:21:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('219', null, null, null, null, null, '2016-09-09 11:23:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('220', null, null, null, null, null, '2016-09-09 11:31:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('221', null, null, null, null, null, '2016-09-09 11:42:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('222', null, null, null, null, null, '2016-09-09 11:52:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('223', '李君', '', null, '1981-08-11 00:00:00', '', '2016-09-09 12:11:17', '2016-09-09 12:12:19', null, null);
INSERT INTO `by_member_detail` VALUES ('224', null, null, null, null, null, '2016-09-09 12:19:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('225', null, null, null, null, null, '2016-09-09 12:27:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('226', '胡', '', null, null, '', '2016-09-09 12:31:35', '2016-09-09 12:31:59', null, null);
INSERT INTO `by_member_detail` VALUES ('227', '邱少庆', '', null, null, '', '2016-09-09 14:04:58', '2016-09-09 14:05:34', null, null);
INSERT INTO `by_member_detail` VALUES ('228', '金滢', '', null, '1986-09-07 23:00:00', '', '2016-09-09 14:20:21', '2016-09-09 14:20:57', null, null);
INSERT INTO `by_member_detail` VALUES ('229', null, null, null, null, null, '2016-09-09 14:34:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('230', null, null, null, null, null, '2016-09-09 15:08:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('231', null, null, null, null, null, '2016-09-09 15:47:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('232', null, null, null, null, null, '2016-09-09 15:53:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('233', null, null, 'e92b23d39e4703b0c1d74c5828939f5b1189f8303a9d90bdc5dd669f77af2ade', null, null, '2016-09-09 16:53:58', '2016-09-09 16:56:59', null, null);
INSERT INTO `by_member_detail` VALUES ('234', '朱', '', null, '2016-10-13 00:00:00', '', '2016-09-09 17:15:43', '2016-09-09 17:16:31', null, null);
INSERT INTO `by_member_detail` VALUES ('235', null, null, null, null, null, '2016-09-09 17:59:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('236', null, null, null, null, null, '2016-09-09 18:45:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('237', null, null, null, null, null, '2016-09-09 19:01:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('238', null, null, null, null, null, '2016-09-09 19:16:59', null, null, null);
INSERT INTO `by_member_detail` VALUES ('239', null, null, null, null, null, '2016-09-09 19:34:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('240', null, null, null, null, null, '2016-09-09 19:39:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('241', '陆秀梅', '', null, '1980-01-06 00:00:00', '', '2016-09-09 19:49:42', '2016-09-11 21:35:00', null, null);
INSERT INTO `by_member_detail` VALUES ('242', null, null, null, null, null, '2016-09-09 19:54:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('243', null, null, null, null, null, '2016-09-09 19:56:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('244', null, null, null, null, null, '2016-09-09 20:26:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('245', null, null, null, null, null, '2016-09-09 20:43:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('246', '丁吟萍', '', null, '1989-07-07 23:00:00', '', '2016-09-09 21:42:33', '2016-09-09 21:43:27', null, null);
INSERT INTO `by_member_detail` VALUES ('247', null, null, null, null, null, '2016-09-09 22:06:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('248', null, null, null, null, null, '2016-09-09 22:23:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('249', null, null, null, null, null, '2016-09-10 07:38:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('250', '杨梓', '', null, null, '', '2016-09-10 08:24:59', '2016-09-10 08:25:49', null, null);
INSERT INTO `by_member_detail` VALUES ('251', null, null, null, null, null, '2016-09-10 08:48:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('252', null, null, null, null, null, '2016-09-10 09:38:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('253', '', '永业路佳虹路42弄', '164bf85834f775962e40a38f8dd4910ac018d2df54b5c2601234463e33338a27', '1995-07-11 00:00:00', '310230199507110456', '2016-09-10 09:59:19', '2016-09-10 10:00:38', null, null);
INSERT INTO `by_member_detail` VALUES ('254', null, null, null, null, null, '2016-09-10 11:07:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('255', null, null, null, null, null, '2016-09-10 11:39:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('256', '', '上海市浦东新区佳虹路50弄17号501室', '801bf68484a00122336f0e5d8b3bac6e58abb5e3f91885f2b3a601f4c07fbf0c', '1978-06-14 00:00:00', '510902197806149730', '2016-09-10 12:07:56', '2016-09-10 12:10:03', null, null);
INSERT INTO `by_member_detail` VALUES ('257', '沙俊峰', '金高路2131弄31号101', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1983-06-13 00:00:00', '310109198306131532', '2016-09-10 12:19:35', '2016-09-10 12:23:45', null, null);
INSERT INTO `by_member_detail` VALUES ('258', null, null, null, null, null, '2016-09-10 12:44:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('259', null, null, null, null, null, '2016-09-10 13:28:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('260', null, null, null, null, null, '2016-09-10 13:50:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('261', '', '', 'f51f2c2131d0fd27fc5a81e6f1b51a95df34a7d63fa5cc100b07da01ec970367', null, '', '2016-09-10 14:21:50', '2016-09-10 14:23:29', null, null);
INSERT INTO `by_member_detail` VALUES ('262', null, null, null, null, null, '2016-09-10 14:37:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('263', null, null, null, null, null, '2016-09-10 14:38:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('264', null, null, null, null, null, '2016-09-10 14:46:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('265', null, null, '68c881e55fa6a881d769298b18c2eda7170bbcdf61fb529c37250ebe5026a9c1', null, null, '2016-09-10 14:59:23', '2016-09-10 15:00:53', null, null);
INSERT INTO `by_member_detail` VALUES ('266', '浦素平', '', null, null, '', '2016-09-10 15:50:05', '2016-09-10 15:50:51', null, null);
INSERT INTO `by_member_detail` VALUES ('267', '', '', '1faaad5d381a89f375cce6a9e0d659c1100b3ffcabf5d9c4205be97e9bfbd654', null, '', '2016-09-10 16:14:06', '2016-09-10 16:15:31', null, null);
INSERT INTO `by_member_detail` VALUES ('268', null, null, null, null, null, '2016-09-10 16:20:59', null, null, null);
INSERT INTO `by_member_detail` VALUES ('269', null, null, null, null, null, '2016-09-10 16:27:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('270', null, null, null, null, null, '2016-09-10 16:39:22', null, null, null);
INSERT INTO `by_member_detail` VALUES ('271', '周骏杰', '', null, '1978-10-20 00:00:00', '', '2016-09-10 16:42:28', '2016-09-10 16:43:07', null, null);
INSERT INTO `by_member_detail` VALUES ('272', null, null, null, null, null, '2016-09-10 17:02:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('273', null, null, null, null, null, '2016-09-10 17:03:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('274', '刘先生', '', null, null, '', '2016-09-10 17:03:37', '2016-09-10 17:04:01', null, null);
INSERT INTO `by_member_detail` VALUES ('275', null, null, null, null, null, '2016-09-10 17:36:50', null, null, null);
INSERT INTO `by_member_detail` VALUES ('276', null, null, null, null, null, '2016-09-10 18:07:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('277', null, null, null, null, null, '2016-09-10 18:45:57', null, null, null);
INSERT INTO `by_member_detail` VALUES ('278', null, null, null, null, null, '2016-09-10 18:54:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('279', null, null, null, null, null, '2016-09-10 19:16:11', null, null, null);
INSERT INTO `by_member_detail` VALUES ('280', null, null, null, null, null, '2016-09-10 19:17:11', null, null, null);
INSERT INTO `by_member_detail` VALUES ('281', null, null, null, null, null, '2016-09-10 19:42:22', null, null, null);
INSERT INTO `by_member_detail` VALUES ('282', null, null, 'e303fd70c1cd3558f0ea2bd8ee3011137b75b0a351ddbb7e72e2514c9353f674', null, null, '2016-09-10 19:49:53', '2016-09-10 19:54:16', null, null);
INSERT INTO `by_member_detail` VALUES ('283', null, null, null, null, null, '2016-09-10 20:10:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('284', null, null, null, null, null, '2016-09-10 20:13:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('285', '', '', null, '1977-11-05 00:00:00', '', '2016-09-10 20:25:38', '2016-09-10 20:27:15', null, null);
INSERT INTO `by_member_detail` VALUES ('286', null, null, null, null, null, '2016-09-10 20:31:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('287', null, null, null, null, null, '2016-09-10 20:34:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('288', null, null, null, null, null, '2016-09-10 21:15:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('289', null, null, null, null, null, '2016-09-10 21:41:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('290', null, null, null, null, null, '2016-09-10 21:46:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('291', '冯华', '', null, '1977-02-10 00:00:00', '', '2016-09-10 22:17:47', '2016-09-10 22:18:32', null, null);
INSERT INTO `by_member_detail` VALUES ('292', null, null, null, null, null, '2016-09-10 22:20:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('293', null, null, null, null, null, '2016-09-10 22:31:06', null, null, null);
INSERT INTO `by_member_detail` VALUES ('294', '管宇清', '', null, null, '', '2016-09-10 22:31:35', '2016-10-28 10:26:40', null, null);
INSERT INTO `by_member_detail` VALUES ('295', '', '浦东新区金高路2131弄41号1101室', 'ae7f075ed0a8a9784f176053c4badd747f19b3cb3eadc5cd5b10d75005b29e38', '1974-12-30 00:00:00', '310110197412302025', '2016-09-11 00:47:11', '2016-09-11 00:50:12', null, null);
INSERT INTO `by_member_detail` VALUES ('296', 'jojo', '永宁路33弄3号601室', '9a8b134bbc43a21cf7eeec85c35f87c967a959cea3ede98caed2a3e3ec845194', '1976-06-21 00:00:00', '', '2016-09-11 08:22:01', '2016-09-14 20:37:59', null, null);
INSERT INTO `by_member_detail` VALUES ('297', null, null, null, null, null, '2016-09-11 08:59:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('298', null, null, null, null, null, '2016-09-11 09:27:57', null, null, null);
INSERT INTO `by_member_detail` VALUES ('299', '弓元植', '永业路218弄5号501', null, '1980-12-12 00:00:00', '239005198012123614', '2016-09-11 09:54:24', '2016-09-11 09:55:09', null, null);
INSERT INTO `by_member_detail` VALUES ('300', null, null, null, null, null, '2016-09-11 09:57:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('301', null, null, null, null, null, '2016-09-11 10:56:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('302', null, null, null, null, null, '2016-09-11 11:36:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('303', null, null, null, null, null, '2016-09-11 11:47:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('304', null, null, null, null, null, '2016-09-11 11:56:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('305', null, null, null, null, null, '2016-09-11 12:04:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('306', '周军', '', null, null, '', '2016-09-11 12:28:37', '2016-09-11 12:29:09', null, null);
INSERT INTO `by_member_detail` VALUES ('307', '魏文敏', '', null, '1991-09-08 23:00:00', '', '2016-09-11 12:30:48', '2016-09-11 12:31:42', null, null);
INSERT INTO `by_member_detail` VALUES ('308', null, null, null, null, null, '2016-09-11 13:03:27', null, null, null);
INSERT INTO `by_member_detail` VALUES ('309', null, null, null, null, null, '2016-09-11 13:10:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('310', '潘尧', '上海市浦东新区东陆路1182弄19号402室', '3331cf8f9c61d50160a9421af6282fdae8688e895035a5e8aa6708245f30a898', '1984-07-24 00:00:00', '310115198407240436', '2016-09-11 14:12:00', '2016-10-05 12:29:40', null, null);
INSERT INTO `by_member_detail` VALUES ('311', null, null, null, null, null, '2016-09-11 14:13:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('312', '', '', '534a2521232c38461aecc004aac4b3c5f3ca982636ca188402160ea45b0ed21d', null, '', '2016-09-11 14:27:34', '2016-09-11 14:28:39', null, null);
INSERT INTO `by_member_detail` VALUES ('313', null, null, null, null, null, '2016-09-11 14:28:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('314', null, null, null, null, null, '2016-09-11 15:24:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('315', null, null, null, null, null, '2016-09-11 15:36:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('316', null, null, null, null, null, '2016-09-11 16:29:21', null, null, null);
INSERT INTO `by_member_detail` VALUES ('317', '张旭', '', 'b4676c32adce99208cce914e339ddbf69a3f3246dd977967331b663347cbb943', '1984-12-25 00:00:00', '', '2016-09-11 16:58:40', '2016-09-11 17:00:55', null, null);
INSERT INTO `by_member_detail` VALUES ('318', '孙怡', '', null, null, '', '2016-09-11 17:04:44', '2016-09-11 17:05:04', null, null);
INSERT INTO `by_member_detail` VALUES ('319', null, null, null, null, null, '2016-09-11 17:50:54', null, null, null);
INSERT INTO `by_member_detail` VALUES ('320', null, null, null, null, null, '2016-09-11 18:02:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('321', '', '', null, '1977-01-22 00:00:00', '', '2016-09-11 18:30:09', '2016-09-11 18:30:53', null, null);
INSERT INTO `by_member_detail` VALUES ('322', null, null, null, null, null, '2016-09-11 18:43:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('323', null, null, null, null, null, '2016-09-11 20:02:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('324', null, null, null, null, null, '2016-09-11 20:17:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('325', '潘英杰', '', null, '1985-01-14 00:00:00', '', '2016-09-11 20:36:08', '2016-09-11 20:36:53', null, null);
INSERT INTO `by_member_detail` VALUES ('326', null, null, null, null, null, '2016-09-11 20:36:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('327', '', '上海浦东新区高行镇秋岚路91弄10号201室', null, '1989-10-18 00:00:00', '310115198910185024', '2016-09-11 20:37:17', '2016-09-11 20:38:36', null, null);
INSERT INTO `by_member_detail` VALUES ('328', null, null, null, null, null, '2016-09-11 20:37:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('329', null, null, null, null, null, '2016-09-11 20:38:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('330', '左巧玲', '', null, '1993-10-27 00:00:00', '', '2016-09-11 20:39:39', '2016-09-11 20:40:27', null, null);
INSERT INTO `by_member_detail` VALUES ('331', null, null, null, null, null, '2016-09-11 20:39:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('332', '陈丽华', '上海浦东新区金杨路220弄59号402室', null, null, '', '2016-09-11 20:40:21', '2016-09-11 20:41:09', null, null);
INSERT INTO `by_member_detail` VALUES ('333', '', '', 'd1715363bf443ff5146ff35d1935e6f26c7e340ac8cc2172d30cf388f7d24a20', null, '', '2016-09-11 20:42:00', '2016-09-11 20:43:33', null, null);
INSERT INTO `by_member_detail` VALUES ('334', null, null, null, null, null, '2016-09-11 20:43:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('335', '', '凌河路420弄72号302室', 'a48f45cc82c4fa67bb05603b00c1fbe181516646cd685d442afd2afbd8a05d1d', '1978-09-15 00:00:00', '310115197809156427', '2016-09-11 20:45:59', '2016-09-11 20:48:17', null, null);
INSERT INTO `by_member_detail` VALUES ('336', null, null, null, null, null, '2016-09-11 20:46:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('337', '郭军', '', null, '1977-08-01 00:00:00', '', '2016-09-11 20:46:54', '2016-09-11 20:47:56', null, null);
INSERT INTO `by_member_detail` VALUES ('338', '张洁清', '金桥镇佳林路919弄6号', null, '1979-01-06 00:00:00', '310115197901064728', '2016-09-11 20:47:04', '2016-09-11 20:55:04', null, null);
INSERT INTO `by_member_detail` VALUES ('339', null, null, null, null, null, '2016-09-11 20:47:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('340', null, null, null, null, null, '2016-09-11 20:47:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('341', '薛燕云', '浦东新区唐镇王港胜利路30弄金盛佳苑5号302室', null, '1986-09-21 00:00:00', '310115198609218421', '2016-09-11 20:47:58', '2016-09-11 20:48:48', null, null);
INSERT INTO `by_member_detail` VALUES ('342', null, null, null, null, null, '2016-09-11 20:48:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('343', null, null, null, null, null, '2016-09-11 20:49:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('344', null, null, null, null, null, '2016-09-11 20:49:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('345', '俞舒萍', '', null, null, '', '2016-09-11 20:49:16', '2016-09-11 20:49:50', null, null);
INSERT INTO `by_member_detail` VALUES ('346', null, null, null, null, null, '2016-09-11 20:50:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('347', null, null, null, null, null, '2016-09-11 20:51:11', null, null, null);
INSERT INTO `by_member_detail` VALUES ('348', null, null, null, null, null, '2016-09-11 20:54:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('349', '', '', null, null, '', '2016-09-11 20:54:12', '2016-09-11 20:54:35', null, null);
INSERT INTO `by_member_detail` VALUES ('350', null, null, null, null, null, '2016-09-11 20:56:27', null, null, null);
INSERT INTO `by_member_detail` VALUES ('351', '王虹', '长宁区仙霞西路885弄41号301室', null, '1986-08-09 23:00:00', '310115198608104721', '2016-09-11 20:58:30', '2016-09-11 20:59:22', null, null);
INSERT INTO `by_member_detail` VALUES ('352', null, null, null, null, null, '2016-09-11 20:59:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('353', null, null, null, null, null, '2016-09-11 21:02:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('354', '', '', null, '1980-02-09 00:00:00', '310230198002092913', '2016-09-11 21:04:18', '2016-09-11 21:05:34', null, null);
INSERT INTO `by_member_detail` VALUES ('355', null, null, null, null, null, '2016-09-11 21:10:06', null, null, null);
INSERT INTO `by_member_detail` VALUES ('356', '胡章荣', '永业路188弄14号302', null, '1986-08-18 23:00:00', '', '2016-09-11 21:10:15', '2016-09-11 21:13:27', null, null);
INSERT INTO `by_member_detail` VALUES ('357', null, null, null, null, null, '2016-09-11 21:14:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('358', null, null, null, null, null, '2016-09-11 21:15:06', null, null, null);
INSERT INTO `by_member_detail` VALUES ('359', null, null, null, null, null, '2016-09-11 21:15:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('360', '倪轶洲', '', null, null, '', '2016-09-11 21:18:26', '2016-09-11 21:19:25', null, null);
INSERT INTO `by_member_detail` VALUES ('361', '', '', null, null, '', '2016-09-11 21:18:57', '2016-09-11 21:19:35', null, null);
INSERT INTO `by_member_detail` VALUES ('362', null, null, null, null, null, '2016-09-11 21:19:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('363', null, null, null, null, null, '2016-09-11 21:21:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('364', '朱培忠', '上海市浦东新区凌河路188弄76号301室', 'a1c3ce358462f0503b0d460db7812cfcc5194e8e7099ca84827b65fe8481659c', '1972-06-18 00:00:00', '310224197206182812', '2016-09-11 21:22:22', '2016-09-11 21:32:00', null, null);
INSERT INTO `by_member_detail` VALUES ('365', null, null, null, null, null, '2016-09-11 21:22:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('366', null, null, null, null, null, '2016-09-11 21:22:59', null, null, null);
INSERT INTO `by_member_detail` VALUES ('367', '陆伟伟', '', null, '1983-10-17 00:00:00', '', '2016-09-11 21:24:07', '2016-09-11 21:25:10', null, null);
INSERT INTO `by_member_detail` VALUES ('368', null, null, null, null, null, '2016-09-11 21:25:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('369', null, null, null, null, null, '2016-09-11 21:26:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('370', null, null, null, null, null, '2016-09-11 21:30:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('371', null, null, null, null, null, '2016-09-11 21:32:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('372', null, null, null, null, null, '2016-09-11 21:36:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('373', '陈', '', null, null, '', '2016-09-11 21:38:14', '2016-09-11 21:39:13', null, null);
INSERT INTO `by_member_detail` VALUES ('374', null, null, null, null, null, '2016-09-11 21:44:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('375', '钱诚', '金桥镇佳林路919弄4号302室', 'b1bed578b99f0e87872cc992ae1c273f757949815fe7f9ada4216edcc3ed27c3', '1990-06-25 23:00:00', '310115199006264714', '2016-09-11 21:53:18', '2016-09-11 21:55:22', null, null);
INSERT INTO `by_member_detail` VALUES ('376', null, null, null, null, null, '2016-09-11 21:53:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('377', null, null, null, null, null, '2016-09-11 21:55:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('378', '董良', '金桥镇永业小区', null, '1978-08-25 00:00:00', '', '2016-09-11 21:59:10', '2016-09-11 22:00:11', null, null);
INSERT INTO `by_member_detail` VALUES ('379', null, null, null, null, null, '2016-09-11 22:03:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('380', null, null, null, null, null, '2016-09-11 22:08:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('381', '', '', null, '1986-12-14 00:00:00', '', '2016-09-11 22:15:27', '2016-09-11 22:15:55', null, null);
INSERT INTO `by_member_detail` VALUES ('382', null, null, null, null, null, '2016-09-11 22:21:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('383', null, null, null, null, null, '2016-09-11 22:24:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('384', null, null, null, null, null, '2016-09-11 22:26:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('385', '王佳莉', '', '52bb588ddc390e0dd995855cf95c2c75029410728890a535e8aef70fc4df91f4', '1990-09-19 00:00:00', '', '2016-09-11 22:29:56', '2016-09-11 22:33:59', null, null);
INSERT INTO `by_member_detail` VALUES ('386', null, null, '112936dd11e74880ec4a9f6643da6249527ebe86535c61c75a09cb60efdac158', null, null, '2016-09-11 22:33:41', '2016-09-11 22:36:05', null, null);
INSERT INTO `by_member_detail` VALUES ('387', null, null, null, null, null, '2016-09-11 22:35:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('388', '张招娣', '永业路', null, null, '', '2016-09-11 22:38:00', '2016-09-11 22:42:13', null, null);
INSERT INTO `by_member_detail` VALUES ('389', null, null, null, null, null, '2016-09-11 22:47:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('390', '江军', '佳林路838弄4号602', '1f5c0da2c3facbfbdd87b5a06fa8af411f9344d6db317344d2519af052005c22', '1989-10-19 00:00:00', '310115198910194713', '2016-09-11 23:42:16', '2016-09-11 23:44:24', null, null);
INSERT INTO `by_member_detail` VALUES ('391', '凌霞', '高宝路379弄14号', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1983-08-24 00:00:00', '310115198308245645', '2016-09-11 23:58:53', '2016-09-12 00:01:00', null, null);
INSERT INTO `by_member_detail` VALUES ('392', null, null, null, null, null, '2016-09-12 01:08:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('393', null, null, null, null, null, '2016-09-12 01:21:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('394', '薄梓及', '上海市浦东新区金高路2131弄45号501室', null, '1971-05-03 00:00:00', '642122197105030334', '2016-09-12 04:43:42', '2016-09-12 04:46:12', null, null);
INSERT INTO `by_member_detail` VALUES ('395', null, null, null, null, null, '2016-09-12 05:57:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('396', null, null, null, null, null, '2016-09-12 06:45:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('397', '凌寒琪', '', null, '1986-12-29 00:00:00', '', '2016-09-12 07:05:26', '2016-09-12 07:06:09', null, null);
INSERT INTO `by_member_detail` VALUES ('398', null, null, null, null, null, '2016-09-12 07:14:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('399', null, null, null, null, null, '2016-09-12 07:58:03', null, null, null);
INSERT INTO `by_member_detail` VALUES ('400', null, null, null, null, null, '2016-09-12 08:46:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('401', '陶园', '', null, null, '', '2016-09-12 08:52:12', '2016-09-12 08:54:28', null, null);
INSERT INTO `by_member_detail` VALUES ('402', null, null, null, null, null, '2016-09-12 09:10:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('403', null, null, null, null, null, '2016-09-12 09:19:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('404', '黄俊', '', null, null, '', '2016-09-12 09:24:14', '2016-09-12 09:24:43', null, null);
INSERT INTO `by_member_detail` VALUES ('405', null, null, null, null, null, '2016-09-12 09:47:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('406', null, null, null, null, null, '2016-09-12 09:52:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('407', null, null, null, null, null, '2016-09-12 09:56:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('408', '陆女士', '', null, null, '', '2016-09-12 10:11:56', '2016-09-12 10:12:26', null, null);
INSERT INTO `by_member_detail` VALUES ('409', null, null, null, null, null, '2016-09-12 10:21:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('410', null, null, null, null, null, '2016-09-12 11:33:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('411', '陆宇', '浦东新区永宁路136弄6号401室', '6ea8477b428737460aa6ad05366dd82c9425bb9d81e89b574ee2a75484627ef2', '1984-05-16 00:00:00', '310230198405164758', '2016-09-12 12:32:44', '2016-09-12 12:34:53', null, null);
INSERT INTO `by_member_detail` VALUES ('412', null, null, null, null, null, '2016-09-12 12:46:57', null, null, null);
INSERT INTO `by_member_detail` VALUES ('413', '', '', null, '1987-06-23 23:00:00', '', '2016-09-12 13:06:46', '2016-09-12 13:07:28', null, null);
INSERT INTO `by_member_detail` VALUES ('414', null, null, null, null, null, '2016-09-12 14:15:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('415', null, null, null, null, null, '2016-09-12 15:22:03', null, null, null);
INSERT INTO `by_member_detail` VALUES ('416', null, null, null, null, null, '2016-09-12 15:30:34', null, null, null);
INSERT INTO `by_member_detail` VALUES ('417', null, null, null, null, null, '2016-09-12 16:40:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('418', null, null, null, null, null, '2016-09-12 17:01:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('419', null, null, null, null, null, '2016-09-12 17:13:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('420', '陆老师', '', null, null, '', '2016-09-12 18:06:07', '2016-11-21 11:15:52', null, null);
INSERT INTO `by_member_detail` VALUES ('421', null, null, null, null, null, '2016-09-12 18:51:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('422', null, null, null, null, null, '2016-09-12 19:05:46', null, null, null);
INSERT INTO `by_member_detail` VALUES ('423', null, null, null, null, null, '2016-09-12 19:39:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('424', null, null, null, null, null, '2016-09-12 20:47:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('425', null, null, null, null, null, '2016-09-12 21:01:27', null, null, null);
INSERT INTO `by_member_detail` VALUES ('426', '谢优思', '上海市浦东新区金桥镇长岛路长岛花苑1560弄17号1903', 'c163f4931042e283bcfa528e6bb46c2d0ea2135de2b0fa90517dc832c6fae1ef', '1992-10-23 00:00:00', '441881199210231444', '2016-09-12 22:18:40', '2016-09-12 23:27:16', null, null);
INSERT INTO `by_member_detail` VALUES ('427', null, null, null, null, null, '2016-09-13 07:55:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('428', null, null, null, null, null, '2016-09-13 13:36:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('429', null, null, null, null, null, '2016-09-13 14:21:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('430', null, null, null, null, null, '2016-09-13 14:22:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('431', null, null, null, null, null, '2016-09-13 15:30:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('432', '王慧丽', '', null, null, '', '2016-09-13 16:18:14', '2016-09-13 16:18:49', null, null);
INSERT INTO `by_member_detail` VALUES ('433', null, null, null, null, null, '2016-09-13 16:38:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('434', null, null, null, null, null, '2016-09-13 17:30:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('435', '古天宇', '上海市浦东新区巨峰路716弄13号603室', null, '1986-02-04 00:00:00', '410882198602046016', '2016-09-13 18:23:56', '2016-09-13 18:25:37', null, null);
INSERT INTO `by_member_detail` VALUES ('436', null, null, null, null, null, '2016-09-13 19:23:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('437', null, null, null, null, null, '2016-09-13 22:24:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('438', null, null, null, null, null, '2016-09-13 22:32:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('439', null, null, null, null, null, '2016-09-14 08:20:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('440', '', '浦东新区博兴路1676弄21号401室', '52e3ca9a5ec3a96287247a8ee995f22bcef585382a55c5057cdbeae096596747', '1984-10-28 00:00:00', '340403198410280443', '2016-09-14 08:22:16', '2016-09-14 08:25:15', null, null);
INSERT INTO `by_member_detail` VALUES ('441', '黄伟春', '', null, '1985-02-15 00:00:00', '', '2016-09-14 09:23:11', '2016-09-14 09:24:22', null, null);
INSERT INTO `by_member_detail` VALUES ('442', null, null, null, null, null, '2016-09-14 10:32:54', null, null, null);
INSERT INTO `by_member_detail` VALUES ('443', '瞿杰', '', null, '1992-10-05 00:00:00', '', '2016-09-14 11:00:52', '2016-09-14 11:01:21', null, null);
INSERT INTO `by_member_detail` VALUES ('444', null, null, null, null, null, '2016-09-14 11:11:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('445', null, null, null, null, null, '2016-09-14 11:12:59', null, null, null);
INSERT INTO `by_member_detail` VALUES ('446', null, null, null, null, null, '2016-09-14 11:38:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('447', null, null, null, null, null, '2016-09-14 12:30:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('448', '凌迪', '', null, null, '', '2016-09-14 14:56:15', '2016-09-14 14:56:38', null, null);
INSERT INTO `by_member_detail` VALUES ('449', null, null, null, null, null, '2016-09-14 15:00:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('450', null, null, null, null, null, '2016-09-14 15:20:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('451', '詹海', '', null, null, '', '2016-09-14 15:33:17', '2016-09-14 15:34:01', null, null);
INSERT INTO `by_member_detail` VALUES ('452', '陶燕', '杨高北路5291弄22号401', null, '1979-05-05 00:00:00', '', '2016-09-14 15:40:45', '2016-09-14 15:44:01', null, null);
INSERT INTO `by_member_detail` VALUES ('453', null, null, null, null, null, '2016-09-14 15:43:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('454', null, null, null, null, null, '2016-09-14 15:46:40', null, null, null);
INSERT INTO `by_member_detail` VALUES ('455', null, null, null, null, null, '2016-09-14 15:47:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('456', null, null, null, null, null, '2016-09-14 15:47:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('457', null, null, null, null, null, '2016-09-14 15:48:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('458', null, null, null, null, null, '2016-09-14 15:53:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('459', null, null, null, null, null, '2016-09-14 15:53:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('460', null, null, null, null, null, '2016-09-14 15:58:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('461', '汤一梅', '', null, '1982-10-22 00:00:00', '310115198210225048', '2016-09-14 16:00:14', '2016-10-09 13:40:27', null, null);
INSERT INTO `by_member_detail` VALUES ('462', null, null, null, null, null, '2016-09-14 16:21:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('463', '朱雪雯', '', null, '1983-07-06 00:00:00', '', '2016-09-14 16:24:51', '2016-09-14 16:25:56', null, null);
INSERT INTO `by_member_detail` VALUES ('464', '武加华', '', null, '1981-08-02 00:00:00', '', '2016-09-14 16:38:56', '2016-09-14 16:43:19', null, null);
INSERT INTO `by_member_detail` VALUES ('465', null, null, null, null, null, '2016-09-14 16:40:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('466', null, null, null, null, null, '2016-09-14 16:41:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('467', null, null, null, null, null, '2016-09-14 16:53:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('468', null, null, null, null, null, '2016-09-14 17:03:59', null, null, null);
INSERT INTO `by_member_detail` VALUES ('469', null, null, null, null, null, '2016-09-14 17:10:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('470', null, null, null, null, null, '2016-09-14 17:10:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('471', null, null, null, null, null, '2016-09-14 18:24:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('472', null, null, null, null, null, '2016-09-14 19:12:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('473', null, null, null, null, null, '2016-09-14 20:04:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('474', null, null, null, null, null, '2016-09-14 21:12:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('475', null, null, null, null, null, '2016-09-14 21:12:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('476', null, null, null, null, null, '2016-09-14 21:48:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('477', null, null, null, null, null, '2016-09-14 23:39:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('478', null, null, null, null, null, '2016-09-14 23:49:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('479', null, null, null, null, null, '2016-09-15 07:01:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('480', '琴牛牛', '', null, null, '', '2016-09-15 08:04:43', '2016-09-15 08:05:12', null, null);
INSERT INTO `by_member_detail` VALUES ('481', null, null, null, null, null, '2016-09-15 09:09:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('482', null, null, null, null, null, '2016-09-15 09:41:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('483', null, null, null, null, null, '2016-09-15 11:08:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('484', null, null, null, null, null, '2016-09-15 11:23:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('485', '姜', '佳林路898弄11号401室', null, '1972-11-25 00:00:00', '', '2016-09-15 11:37:36', '2016-09-15 11:42:13', null, null);
INSERT INTO `by_member_detail` VALUES ('486', null, null, null, null, null, '2016-09-15 11:45:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('487', null, null, null, null, null, '2016-09-15 13:06:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('488', null, null, null, null, null, '2016-09-15 13:17:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('489', null, null, null, null, null, '2016-09-15 13:18:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('490', '王', '', null, '1987-07-31 23:00:00', '', '2016-09-15 13:19:17', '2016-09-15 13:19:59', null, null);
INSERT INTO `by_member_detail` VALUES ('491', null, null, null, null, null, '2016-09-15 13:22:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('492', null, null, null, null, null, '2016-09-15 14:00:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('493', null, null, null, null, null, '2016-09-15 14:33:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('494', '', '东陆路2000弄35号902', 'dec7a88a4f9bb8bf6d35d7f4e2aa6bb573d21a61bf1e5dda6df92fc00a8d16f0', '1975-07-29 00:00:00', '370204197507291831', '2016-09-15 14:59:27', '2016-09-15 15:01:20', null, null);
INSERT INTO `by_member_detail` VALUES ('495', null, null, null, null, null, '2016-09-15 15:15:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('496', null, null, null, null, null, '2016-09-15 16:19:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('497', '孙艳梅', '', null, null, '', '2016-09-15 19:42:42', '2016-09-15 19:43:13', null, null);
INSERT INTO `by_member_detail` VALUES ('498', '', '', 'ede93148cd7cc0ba4864d6207f1999e7ab856e6e9c8c20cf7cc84d611bc1d52d', '1981-01-27 00:00:00', '320583198101279426', '2016-09-15 19:55:08', '2016-09-15 19:56:36', null, null);
INSERT INTO `by_member_detail` VALUES ('499', null, null, null, null, null, '2016-09-15 20:14:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('500', '', '', '5fe61904bd1a402102ccc06c419525ccbc56f09360004c284a92595b184455ec', null, '', '2016-09-15 22:03:54', '2016-09-15 22:06:18', null, null);
INSERT INTO `by_member_detail` VALUES ('501', null, null, null, null, null, '2016-09-15 22:32:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('502', null, null, null, null, null, '2016-09-16 10:53:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('503', null, null, null, null, null, '2016-09-16 11:41:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('504', null, null, null, null, null, '2016-09-16 12:05:54', null, null, null);
INSERT INTO `by_member_detail` VALUES ('505', '丁文彬', '', null, null, '', '2016-09-16 12:54:10', '2016-09-16 12:54:26', null, null);
INSERT INTO `by_member_detail` VALUES ('506', null, null, null, null, null, '2016-09-16 13:20:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('507', '', '', 'df32b5516a217f671f146eb6cdd52d35a4aa69427246b732fbb7700cd38a3c0f', null, '', '2016-09-16 14:48:07', '2016-09-17 16:22:49', null, null);
INSERT INTO `by_member_detail` VALUES ('508', '卡卡', '', null, null, '', '2016-09-16 15:13:55', '2016-09-16 15:14:25', null, null);
INSERT INTO `by_member_detail` VALUES ('509', null, null, null, null, null, '2016-09-16 16:02:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('510', '陈璐', '佳林路', null, '1982-09-21 00:00:00', '310115198209210623', '2016-09-16 16:48:34', '2016-09-16 16:52:14', null, null);
INSERT INTO `by_member_detail` VALUES ('511', null, null, null, null, null, '2016-09-16 17:09:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('512', '', '', null, null, '', '2016-09-16 18:51:58', '2016-09-16 18:52:22', null, null);
INSERT INTO `by_member_detail` VALUES ('513', null, null, null, null, null, '2016-09-16 19:42:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('514', null, null, null, null, null, '2016-09-16 20:10:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('515', '唐瑜雯', '', null, null, '', '2016-09-16 22:54:29', '2016-09-29 22:05:27', null, null);
INSERT INTO `by_member_detail` VALUES ('516', '张爱丽', '', 'e1a29786531b79489854d561a489aba55d3786370069b9d5a64e0ba82b2066e3', '1982-01-16 00:00:00', '310115198201160449', '2016-09-17 08:34:48', '2016-09-17 08:36:01', null, null);
INSERT INTO `by_member_detail` VALUES ('517', null, null, null, null, null, '2016-09-17 10:21:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('518', null, null, null, null, null, '2016-09-17 13:36:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('519', null, null, null, null, null, '2016-09-17 13:57:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('520', null, null, null, null, null, '2016-09-17 14:26:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('521', null, null, null, null, null, '2016-09-17 16:33:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('522', null, null, null, null, null, '2016-09-17 17:06:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('523', null, null, null, null, null, '2016-09-17 17:11:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('524', '', '', null, '1992-03-15 00:00:00', '', '2016-09-17 18:17:16', '2016-09-17 18:34:19', null, null);
INSERT INTO `by_member_detail` VALUES ('525', null, null, null, null, null, '2016-09-17 18:27:27', null, null, null);
INSERT INTO `by_member_detail` VALUES ('526', null, null, null, null, null, '2016-09-17 18:50:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('527', null, null, null, null, null, '2016-09-17 19:36:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('528', null, null, null, null, null, '2016-09-17 20:11:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('529', null, null, null, null, null, '2016-09-17 21:18:50', null, null, null);
INSERT INTO `by_member_detail` VALUES ('530', null, null, null, null, null, '2016-09-18 10:57:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('531', null, null, null, null, null, '2016-09-18 13:40:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('532', '', '', null, null, '', '2016-09-18 14:05:02', '2016-09-20 12:28:22', null, null);
INSERT INTO `by_member_detail` VALUES ('533', '周欢', '上海市浦东新区金桥路2552弄67号202', 'b7e11f69d1eb2dfdbb8205b98f52aa8063abccb74bad741228bf53ccd14112b6', '1990-04-05 00:00:00', '321084199004055548', '2016-09-18 14:24:17', '2016-10-01 12:46:45', null, null);
INSERT INTO `by_member_detail` VALUES ('534', null, null, null, null, null, '2016-09-18 14:41:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('535', null, null, null, null, null, '2016-09-18 14:47:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('536', null, null, null, null, null, '2016-09-18 15:52:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('537', null, null, null, null, null, '2016-09-18 17:11:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('538', null, null, null, null, null, '2016-09-18 20:12:59', null, null, null);
INSERT INTO `by_member_detail` VALUES ('539', null, null, null, null, null, '2016-09-18 20:39:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('540', null, null, null, null, null, '2016-09-19 06:23:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('541', '', '', null, null, '', '2016-09-19 08:24:19', '2016-09-19 08:25:23', null, null);
INSERT INTO `by_member_detail` VALUES ('542', null, null, null, null, null, '2016-09-19 10:46:34', null, null, null);
INSERT INTO `by_member_detail` VALUES ('543', null, null, null, null, null, '2016-09-19 12:29:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('544', '', '金高路金舍苑2131弄41号1202室', '385d1ed482d4c71129f530af5c5d783e50900a7cb95158a8632eda3ef40b9f15', '1983-12-23 00:00:00', '310115198312230171', '2016-09-19 16:11:48', '2016-09-19 16:15:09', null, null);
INSERT INTO `by_member_detail` VALUES ('545', '张超', '', null, '1994-07-01 00:00:00', '412728199407014214', '2016-09-19 20:03:08', '2016-09-19 20:04:37', null, null);
INSERT INTO `by_member_detail` VALUES ('546', '马寅伟', '', null, '1982-10-08 00:00:00', '', '2016-09-19 21:44:25', '2016-09-19 21:45:55', null, null);
INSERT INTO `by_member_detail` VALUES ('547', null, null, null, null, null, '2016-09-20 10:10:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('548', null, null, null, null, null, '2016-09-20 15:50:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('549', null, null, null, null, null, '2016-09-20 18:03:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('550', null, null, null, null, null, '2016-09-20 21:08:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('551', null, null, null, null, null, '2016-09-20 21:53:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('552', null, null, null, null, null, '2016-09-21 12:48:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('553', null, null, null, null, null, '2016-09-21 21:11:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('554', '赵飞', '', null, null, '', '2016-09-22 10:49:00', '2016-09-22 10:49:25', null, null);
INSERT INTO `by_member_detail` VALUES ('555', null, null, null, null, null, '2016-09-22 11:04:03', null, null, null);
INSERT INTO `by_member_detail` VALUES ('556', null, null, null, null, null, '2016-09-22 15:55:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('557', null, null, null, null, null, '2016-09-22 16:40:41', null, null, null);
INSERT INTO `by_member_detail` VALUES ('558', null, null, null, null, null, '2016-09-22 16:43:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('559', '徐豪', '', null, '1994-09-12 00:00:00', '', '2016-09-22 17:56:18', '2016-09-22 17:56:47', null, null);
INSERT INTO `by_member_detail` VALUES ('560', '', '', null, null, '', '2016-09-22 19:48:56', '2016-09-22 19:49:53', null, null);
INSERT INTO `by_member_detail` VALUES ('561', null, null, null, null, null, '2016-09-22 20:12:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('562', null, null, null, null, null, '2016-09-22 21:18:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('563', '', '', '1814a3fa28024f49b7c01e4d96d2006a78275005345b0890e235488327f8ece6', null, '', '2016-09-22 22:09:53', '2016-09-22 22:11:22', null, null);
INSERT INTO `by_member_detail` VALUES ('564', null, null, null, null, null, '2016-09-23 06:31:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('565', '王晓苹', '浦东新区巨峰路1058弄3号1213室', null, '1980-10-26 00:00:00', '230811198010260028', '2016-09-23 10:49:46', '2016-09-23 10:52:20', null, null);
INSERT INTO `by_member_detail` VALUES ('566', '陶丽萍', '凌河路188弄83号601室', null, '1979-08-30 00:00:00', '310113197908305720', '2016-09-23 10:53:49', '2016-09-23 10:55:12', null, null);
INSERT INTO `by_member_detail` VALUES ('567', null, null, null, null, null, '2016-09-23 12:27:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('568', '', '东陆路2000弄7号1401室', null, '2016-12-31 00:00:00', '', '2016-09-23 12:51:45', '2016-09-23 12:53:21', null, null);
INSERT INTO `by_member_detail` VALUES ('569', null, null, null, null, null, '2016-09-23 14:34:27', null, null, null);
INSERT INTO `by_member_detail` VALUES ('570', null, null, null, null, null, '2016-09-23 15:11:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('571', null, null, null, null, null, '2016-09-23 17:28:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('572', null, null, null, null, null, '2016-09-23 17:51:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('573', '', '', null, '1989-01-22 00:00:00', '310107198901222516', '2016-09-23 19:48:24', '2016-09-23 19:49:01', null, null);
INSERT INTO `by_member_detail` VALUES ('574', null, null, null, null, null, '2016-09-23 20:03:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('575', null, null, null, null, null, '2016-09-23 20:59:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('576', null, null, null, null, null, '2016-09-23 21:34:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('577', '', '', null, '1987-12-24 00:00:00', '', '2016-09-24 09:03:26', '2016-09-24 09:04:51', null, null);
INSERT INTO `by_member_detail` VALUES ('578', '周红伟', '佳林路962弄', 'c8f6f7e77f6585df16f61c79f0729b2f39feaac629e40bd59d52dd5183348e1e', '1981-09-06 00:00:00', '370502198109060817', '2016-09-24 12:20:46', '2016-09-24 12:23:54', null, null);
INSERT INTO `by_member_detail` VALUES ('579', null, null, null, null, null, '2016-09-24 12:51:11', null, null, null);
INSERT INTO `by_member_detail` VALUES ('580', null, null, null, null, null, '2016-09-24 13:31:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('581', null, null, null, null, null, '2016-09-24 13:41:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('582', null, null, null, null, null, '2016-09-24 13:52:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('583', '陆燕雯', '浦东衡安路1058号', '2b40a4440c72f5396f70fc831d1f74671124dddcab6d4a18b7fc652ae8aca1e4', '1985-10-25 00:00:00', '310115198510254414', '2016-09-24 14:32:02', '2016-09-24 14:34:03', null, null);
INSERT INTO `by_member_detail` VALUES ('584', null, null, null, null, null, '2016-09-24 14:48:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('585', '沈', '', null, null, '', '2016-09-24 16:40:27', '2016-09-24 16:41:16', null, null);
INSERT INTO `by_member_detail` VALUES ('586', null, null, null, null, null, '2016-09-24 18:22:11', null, null, null);
INSERT INTO `by_member_detail` VALUES ('587', '韩羽', '', null, '1983-09-20 00:00:00', '', '2016-09-24 18:45:42', '2016-09-24 18:46:14', null, null);
INSERT INTO `by_member_detail` VALUES ('588', null, null, null, null, null, '2016-09-24 22:47:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('589', null, null, null, null, null, '2016-09-24 23:05:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('590', null, null, '2e6bc195f88bd253f4250b75ba1eb64738daffd001cdfa54763b0cac4f63f59c', null, null, '2016-09-25 05:38:54', '2016-09-25 05:43:33', null, null);
INSERT INTO `by_member_detail` VALUES ('591', null, null, null, null, null, '2016-09-25 11:26:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('592', null, null, null, null, null, '2016-09-25 11:32:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('593', null, null, null, null, null, '2016-09-25 11:38:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('594', '沈一葵', '', null, '1974-08-11 00:00:00', '310224197408114711', '2016-09-25 12:22:04', '2016-09-25 12:22:55', null, null);
INSERT INTO `by_member_detail` VALUES ('595', '', '', null, '1984-02-11 00:00:00', '', '2016-09-25 14:52:19', '2016-09-25 14:53:20', null, null);
INSERT INTO `by_member_detail` VALUES ('596', null, null, null, null, null, '2016-09-25 17:05:06', null, null, null);
INSERT INTO `by_member_detail` VALUES ('597', null, null, null, null, null, '2016-09-25 17:45:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('598', null, null, null, null, null, '2016-09-25 17:55:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('599', null, null, null, null, null, '2016-09-25 17:57:35', null, null, null);
INSERT INTO `by_member_detail` VALUES ('600', '', '', null, null, '', '2016-09-25 18:02:31', '2016-09-25 18:03:02', null, null);
INSERT INTO `by_member_detail` VALUES ('601', null, null, null, null, null, '2016-09-25 18:08:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('602', '', '东陆路2000弄18号902室', null, null, '', '2016-09-25 18:24:15', '2016-09-25 18:26:05', null, null);
INSERT INTO `by_member_detail` VALUES ('603', null, null, null, null, null, '2016-09-25 18:56:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('604', null, null, null, null, null, '2016-09-25 21:39:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('605', null, null, null, null, null, '2016-09-26 18:51:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('606', null, null, null, null, null, '2016-09-27 12:15:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('607', null, null, null, null, null, '2016-09-27 15:22:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('608', null, null, null, null, null, '2016-09-27 18:35:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('609', null, null, null, null, null, '2016-09-27 21:12:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('610', null, null, null, null, null, '2016-09-27 21:49:27', null, null, null);
INSERT INTO `by_member_detail` VALUES ('611', null, null, null, null, null, '2016-09-27 21:54:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('612', '张小姐', '', null, '1991-07-31 23:00:00', '', '2016-09-28 15:50:14', '2016-09-28 15:50:55', null, null);
INSERT INTO `by_member_detail` VALUES ('613', null, null, null, null, null, '2016-09-28 16:55:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('614', '沈军', '', null, '1985-07-28 00:00:00', '310115198507280013', '2016-09-28 17:59:28', '2016-09-28 18:00:21', null, null);
INSERT INTO `by_member_detail` VALUES ('615', '黄佳丽', '', null, '1993-11-24 00:00:00', '', '2016-09-28 22:31:57', '2016-09-28 22:33:01', null, null);
INSERT INTO `by_member_detail` VALUES ('616', '', '永业路225弄15号401', 'cf4f77699eec976a0f0e1371ad641994f03491ad4a8687f00442b2496a50feb6', '1988-08-09 23:00:00', '371322198808104933', '2016-09-29 12:41:35', '2016-09-29 12:43:37', null, null);
INSERT INTO `by_member_detail` VALUES ('617', null, null, null, null, null, '2016-09-29 12:42:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('618', null, null, null, null, null, '2016-09-29 12:43:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('619', null, null, null, null, null, '2016-09-29 12:46:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('620', '黄先', '', null, '2016-09-29 00:00:00', '', '2016-09-29 12:46:05', '2016-09-29 12:46:55', null, null);
INSERT INTO `by_member_detail` VALUES ('621', null, null, null, null, null, '2016-09-29 12:49:06', null, null, null);
INSERT INTO `by_member_detail` VALUES ('622', null, null, null, null, null, '2016-09-29 12:52:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('623', null, null, null, null, null, '2016-09-29 12:59:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('624', null, null, null, null, null, '2016-09-29 13:17:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('625', null, null, null, null, null, '2016-09-29 13:43:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('626', '张慈婕', '', null, null, '', '2016-09-29 13:52:46', '2016-09-29 13:53:15', null, null);
INSERT INTO `by_member_detail` VALUES ('627', '张晓丽', '杨高北路5291弄23号502室', null, '1973-09-03 00:00:00', '', '2016-09-29 14:23:24', '2016-09-29 14:27:51', null, null);
INSERT INTO `by_member_detail` VALUES ('628', '陈芳', '高东镇光明路', null, '1987-05-03 23:00:00', '310115198705040424', '2016-09-29 14:29:42', '2016-11-07 00:07:45', null, null);
INSERT INTO `by_member_detail` VALUES ('629', null, null, null, null, null, '2016-09-29 15:26:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('630', null, null, null, null, null, '2016-09-29 16:06:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('631', null, null, null, null, null, '2016-09-29 16:10:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('632', null, null, null, null, null, '2016-09-29 16:55:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('633', null, null, null, null, null, '2016-09-29 17:00:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('634', null, null, null, null, null, '2016-09-29 18:39:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('635', null, null, null, null, null, '2016-09-29 18:40:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('636', null, null, null, null, null, '2016-09-29 18:56:57', null, null, null);
INSERT INTO `by_member_detail` VALUES ('637', null, null, null, null, null, '2016-09-30 11:01:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('638', null, null, null, null, null, '2016-09-30 11:09:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('639', null, null, null, null, null, '2016-09-30 17:18:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('640', null, null, null, null, null, '2016-09-30 18:34:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('641', null, null, null, null, null, '2016-09-30 20:21:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('642', null, null, null, null, null, '2016-10-01 08:28:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('643', null, null, null, null, null, '2016-10-01 10:39:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('644', null, null, null, null, null, '2016-10-01 10:54:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('645', null, null, null, null, null, '2016-10-01 10:57:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('646', null, null, null, null, null, '2016-10-01 11:45:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('647', null, null, null, null, null, '2016-10-01 11:56:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('648', null, null, null, null, null, '2016-10-01 12:18:54', null, null, null);
INSERT INTO `by_member_detail` VALUES ('649', null, null, null, null, null, '2016-10-01 12:21:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('650', null, null, null, null, null, '2016-10-01 12:59:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('651', null, null, null, null, null, '2016-10-01 14:02:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('652', null, null, null, null, null, '2016-10-01 14:17:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('653', null, null, null, null, null, '2016-10-01 14:26:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('654', '', '', '32541d9629d804b37e379c6c5afea785d3bc822605bf792d6ab38205bb32a1ae', '1983-04-16 00:00:00', '310107198304167213', '2016-10-01 15:08:36', '2016-10-01 15:09:50', null, null);
INSERT INTO `by_member_detail` VALUES ('655', null, null, null, null, null, '2016-10-01 15:14:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('656', '', '', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, '', '2016-10-01 18:22:55', '2016-10-01 18:25:23', null, null);
INSERT INTO `by_member_detail` VALUES ('657', '', '', null, '1979-03-20 00:00:00', '', '2016-10-01 18:35:23', '2016-10-01 18:36:46', null, null);
INSERT INTO `by_member_detail` VALUES ('658', null, null, null, null, null, '2016-10-01 18:38:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('659', null, null, null, null, null, '2016-10-01 20:19:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('660', null, null, null, null, null, '2016-10-02 07:14:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('661', null, null, null, null, null, '2016-10-02 10:32:50', null, null, null);
INSERT INTO `by_member_detail` VALUES ('662', '', '', null, null, '', '2016-10-02 11:19:22', '2016-10-02 11:19:51', null, null);
INSERT INTO `by_member_detail` VALUES ('663', null, null, null, null, null, '2016-10-02 12:04:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('664', null, null, null, null, null, '2016-10-02 12:44:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('665', null, null, null, null, null, '2016-10-02 14:40:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('666', null, null, null, null, null, '2016-10-02 14:43:34', null, null, null);
INSERT INTO `by_member_detail` VALUES ('667', null, null, null, null, null, '2016-10-02 17:23:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('668', null, null, null, null, null, '2016-10-02 17:45:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('669', null, null, null, null, null, '2016-10-02 19:32:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('670', null, null, null, null, null, '2016-10-02 20:50:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('671', null, null, null, null, null, '2016-10-02 20:55:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('672', null, null, null, null, null, '2016-10-02 22:00:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('673', '', '', null, null, '', '2016-10-03 10:22:13', '2016-10-03 10:22:29', null, null);
INSERT INTO `by_member_detail` VALUES ('674', null, null, null, null, null, '2016-10-03 12:16:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('675', null, null, null, null, null, '2016-10-03 12:24:41', null, null, null);
INSERT INTO `by_member_detail` VALUES ('676', null, null, null, null, null, '2016-10-03 19:35:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('677', '', '金高路988弄23号501', null, '1986-04-09 00:00:00', '', '2016-10-04 11:02:04', '2016-10-04 11:03:44', null, null);
INSERT INTO `by_member_detail` VALUES ('678', null, null, null, null, null, '2016-10-04 13:03:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('679', '', '', null, '1985-06-28 00:00:00', '', '2016-10-04 14:41:21', '2016-10-04 22:41:21', null, null);
INSERT INTO `by_member_detail` VALUES ('680', '', '金高路1051弄10号501室', 'a49c8bcd665c11756dfab519ac4dc2b94603167849a27cc1a0f1642660d07d42', '1997-03-13 00:00:00', '310115199703130420', '2016-10-04 15:47:21', '2016-10-04 15:52:30', null, null);
INSERT INTO `by_member_detail` VALUES ('681', '张', '', null, null, '', '2016-10-04 17:19:02', '2016-10-04 17:19:30', null, null);
INSERT INTO `by_member_detail` VALUES ('682', null, null, null, null, null, '2016-10-04 18:33:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('683', '孙诗雯', '', null, null, '', '2016-10-04 18:37:34', '2016-10-04 18:38:05', null, null);
INSERT INTO `by_member_detail` VALUES ('684', null, null, null, null, null, '2016-10-04 18:53:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('685', null, null, null, null, null, '2016-10-04 20:03:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('686', null, null, null, null, null, '2016-10-04 20:23:41', null, null, null);
INSERT INTO `by_member_detail` VALUES ('687', null, null, null, null, null, '2016-10-04 21:09:21', null, null, null);
INSERT INTO `by_member_detail` VALUES ('688', null, null, null, null, null, '2016-10-05 10:05:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('689', '', '金桥太茂', null, '2016-10-05 00:00:00', '', '2016-10-05 11:08:37', '2016-10-05 11:09:45', null, null);
INSERT INTO `by_member_detail` VALUES ('690', null, null, null, null, null, '2016-10-05 16:44:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('691', null, null, null, null, null, '2016-10-05 17:28:57', null, null, null);
INSERT INTO `by_member_detail` VALUES ('692', null, null, null, null, null, '2016-10-05 18:19:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('693', null, null, null, null, null, '2016-10-05 18:29:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('694', '王佳炜', '', '4f212ecce2a888ca9b2ad58c5aa09426e43db2efb7c80afe4ccd99b67ee59d20', '1989-12-14 00:00:00', '310115198912140452', '2016-10-05 19:02:29', '2016-10-05 19:05:22', null, null);
INSERT INTO `by_member_detail` VALUES ('695', null, null, null, null, null, '2016-10-05 19:43:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('696', '叶琳', '', null, '1982-04-13 00:00:00', '310115198204131141', '2016-10-06 11:52:39', '2016-10-06 11:53:09', null, null);
INSERT INTO `by_member_detail` VALUES ('697', '俞晨', '', '820912db1a651265b9df4b243c7de3fa3d0f27e1f359752801a2dad05873aee4', '2000-02-24 00:00:00', '310115200002246127', '2016-10-06 12:08:40', '2016-10-06 12:10:16', null, null);
INSERT INTO `by_member_detail` VALUES ('698', '', '申江路881弄3号', '6e3da59bb00a82c3222d8dbeb62c5e0922c2ce4d9aff5b98e3f0bbaa6aba32ae', '1983-07-18 00:00:00', '310115198307186110', '2016-10-06 12:41:59', '2016-10-06 12:45:25', null, null);
INSERT INTO `by_member_detail` VALUES ('699', '徐伟灵', '佳京路99弄138号\n', null, '1984-11-15 00:00:00', '310115198411151014', '2016-10-06 14:23:15', '2016-10-06 14:26:44', null, null);
INSERT INTO `by_member_detail` VALUES ('700', null, null, null, null, null, '2016-10-06 14:56:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('701', null, null, null, null, null, '2016-10-06 14:59:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('702', '', '佳林路898弄12号502', '98765ab7605178acc7e50697d980be4568d7cf3de9114baa1574a6a093c21ff9', '1989-09-12 23:00:00', '310230198909135360', '2016-10-06 16:06:44', '2016-10-06 20:45:43', null, null);
INSERT INTO `by_member_detail` VALUES ('703', null, null, null, null, null, '2016-10-06 16:10:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('704', '', '', null, null, '', '2016-10-06 16:35:15', '2016-10-06 16:35:50', null, null);
INSERT INTO `by_member_detail` VALUES ('705', null, null, null, null, null, '2016-10-06 17:17:54', null, null, null);
INSERT INTO `by_member_detail` VALUES ('706', '王艳', '', null, '2016-10-18 00:00:00', '', '2016-10-06 19:16:46', '2016-10-06 19:17:31', null, null);
INSERT INTO `by_member_detail` VALUES ('707', null, null, null, null, null, '2016-10-06 19:39:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('708', null, null, null, null, null, '2016-10-06 20:03:27', null, null, null);
INSERT INTO `by_member_detail` VALUES ('709', null, null, null, null, null, '2016-10-06 20:37:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('710', '', '', null, '1986-09-12 23:00:00', '310115198609130649', '2016-10-06 21:41:03', '2016-10-06 21:41:48', null, null);
INSERT INTO `by_member_detail` VALUES ('711', null, null, null, null, null, '2016-10-06 22:41:21', null, null, null);
INSERT INTO `by_member_detail` VALUES ('712', null, null, null, null, null, '2016-10-07 12:55:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('713', null, null, null, null, null, '2016-10-07 13:18:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('714', null, null, null, null, null, '2016-10-07 13:37:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('715', null, null, null, null, null, '2016-10-07 13:42:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('716', null, null, null, null, null, '2016-10-07 14:51:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('717', null, null, null, null, null, '2016-10-07 16:25:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('718', null, null, null, null, null, '2016-10-07 16:31:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('719', '严蓓珏', '', null, '1982-10-23 00:00:00', '', '2016-10-07 17:32:26', '2016-10-07 17:34:53', null, null);
INSERT INTO `by_member_detail` VALUES ('720', '', '', '9f9f9907d453085263c7750e23a81aec38c91f5d4701d2c5b0731d761620e65c', '2000-05-21 00:00:00', '', '2016-10-07 18:50:38', '2016-10-07 18:52:15', null, null);
INSERT INTO `by_member_detail` VALUES ('721', '', '佳林路919弄28号201', null, '1998-12-30 00:00:00', '310115199812304418', '2016-10-07 20:25:54', '2016-10-07 20:27:04', null, null);
INSERT INTO `by_member_detail` VALUES ('722', null, null, null, null, null, '2016-10-07 20:56:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('723', null, null, null, null, null, '2016-10-07 21:22:34', null, null, null);
INSERT INTO `by_member_detail` VALUES ('724', '李明芳', '', null, null, '', '2016-10-07 22:13:24', '2016-10-07 22:14:09', null, null);
INSERT INTO `by_member_detail` VALUES ('725', null, null, null, null, null, '2016-10-08 07:25:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('726', '', '', 'edc250f46119ab8766370815652142ef3a724f934c985c5256d039a8997c101c', null, '', '2016-10-08 15:59:49', '2016-10-08 16:01:54', null, null);
INSERT INTO `by_member_detail` VALUES ('727', null, null, null, null, null, '2016-10-08 20:33:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('728', null, null, null, null, null, '2016-10-08 22:11:11', null, null, null);
INSERT INTO `by_member_detail` VALUES ('729', null, null, null, null, null, '2016-10-09 12:04:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('730', null, null, null, null, null, '2016-10-09 15:01:06', null, null, null);
INSERT INTO `by_member_detail` VALUES ('731', null, null, null, null, null, '2016-10-09 21:07:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('732', null, null, null, null, null, '2016-10-09 21:50:03', null, null, null);
INSERT INTO `by_member_detail` VALUES ('733', null, null, null, null, null, '2016-10-10 16:47:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('734', null, null, null, null, null, '2016-10-10 20:45:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('735', null, null, null, null, null, '2016-10-11 10:09:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('736', '', '', '65fec144393b0896392a1d045920f1cbe7a4fa1ee88ba1b40e42ba0e8ae429e0', '1982-09-03 00:00:00', '', '2016-10-11 13:50:28', '2016-10-11 13:52:12', null, null);
INSERT INTO `by_member_detail` VALUES ('737', null, null, null, null, null, '2016-10-12 12:31:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('738', null, null, null, null, null, '2016-10-12 21:27:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('739', '吴民强', '金钻路398弄24', '396d082c16a9ca1e41e048f8dba6f7359a6696ef3eae51791a18dd982e77114f', '1991-07-17 23:00:00', '350628199107180030', '2016-10-13 07:09:34', '2016-10-13 10:10:22', null, null);
INSERT INTO `by_member_detail` VALUES ('740', null, null, null, null, null, '2016-10-13 10:52:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('741', null, null, null, null, null, '2016-10-13 11:14:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('742', null, null, null, null, null, '2016-10-13 18:49:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('743', '卜佳妮', '', null, '1993-10-12 00:00:00', '', '2016-10-13 22:04:51', '2016-10-13 22:05:17', null, null);
INSERT INTO `by_member_detail` VALUES ('744', null, null, null, null, null, '2016-10-14 18:46:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('745', null, null, null, null, null, '2016-10-14 20:01:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('746', null, null, null, null, null, '2016-10-14 20:06:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('747', '周艳', '', null, '1983-01-25 00:00:00', '', '2016-10-14 20:08:38', '2016-10-14 20:09:30', null, null);
INSERT INTO `by_member_detail` VALUES ('748', null, null, null, null, null, '2016-10-14 20:20:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('749', null, null, null, null, null, '2016-10-14 20:20:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('750', null, null, null, null, null, '2016-10-14 20:23:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('751', null, null, null, null, null, '2016-10-14 20:29:35', null, null, null);
INSERT INTO `by_member_detail` VALUES ('752', '', '', null, '1970-10-05 00:00:00', '310224197010052821', '2016-10-14 20:34:58', '2016-10-14 20:37:26', null, null);
INSERT INTO `by_member_detail` VALUES ('753', null, null, null, null, null, '2016-10-14 20:37:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('754', null, null, null, null, null, '2016-10-14 20:39:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('755', null, null, null, null, null, '2016-10-14 20:42:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('756', null, null, null, null, null, '2016-10-14 21:10:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('757', null, null, null, null, null, '2016-10-14 21:15:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('758', null, null, null, null, null, '2016-10-14 21:24:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('759', '', '', null, null, '', '2016-10-15 00:01:57', '2016-10-15 00:03:18', null, null);
INSERT INTO `by_member_detail` VALUES ('760', '吴明伟', '', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1983-08-17 00:00:00', '', '2016-10-15 10:31:30', '2016-10-15 10:33:08', null, null);
INSERT INTO `by_member_detail` VALUES ('761', null, null, null, null, null, '2016-10-15 11:18:35', null, null, null);
INSERT INTO `by_member_detail` VALUES ('762', '蔡利峰', '', null, '1979-01-29 00:00:00', '310115197901296318', '2016-10-15 11:27:05', '2016-10-15 11:30:02', null, null);
INSERT INTO `by_member_detail` VALUES ('763', null, null, null, null, null, '2016-10-15 13:03:11', null, null, null);
INSERT INTO `by_member_detail` VALUES ('764', null, null, null, null, null, '2016-10-15 13:34:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('765', '卢鸣', '', null, null, '', '2016-10-15 13:43:59', '2016-10-15 13:44:44', null, null);
INSERT INTO `by_member_detail` VALUES ('766', null, null, null, null, null, '2016-10-15 15:26:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('767', null, null, null, null, null, '2016-10-15 17:11:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('768', null, null, null, null, null, '2016-10-15 17:28:56', null, null, null);
INSERT INTO `by_member_detail` VALUES ('769', null, null, null, null, null, '2016-10-15 17:58:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('770', null, null, null, null, null, '2016-10-16 12:10:22', null, null, null);
INSERT INTO `by_member_detail` VALUES ('771', null, null, null, null, null, '2016-10-16 14:17:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('772', '许伟国', '金沪路1099号', null, '1983-09-06 00:00:00', '310115198309060618', '2016-10-16 16:39:42', '2016-10-30 19:35:24', null, null);
INSERT INTO `by_member_detail` VALUES ('773', null, null, null, null, null, '2016-10-16 16:47:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('774', null, null, null, null, null, '2016-10-16 17:56:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('775', null, null, null, null, null, '2016-10-16 18:50:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('776', null, null, null, null, null, '2016-10-16 22:29:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('777', '大庆', '', null, null, '', '2016-10-16 22:40:41', '2016-10-16 22:41:09', null, null);
INSERT INTO `by_member_detail` VALUES ('778', null, null, null, null, null, '2016-10-17 11:53:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('779', null, null, null, null, null, '2016-10-17 12:12:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('780', null, null, null, null, null, '2016-10-17 13:19:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('781', null, null, null, null, null, '2016-10-17 16:54:51', null, null, null);
INSERT INTO `by_member_detail` VALUES ('782', null, null, null, null, null, '2016-10-18 09:33:39', null, null, null);
INSERT INTO `by_member_detail` VALUES ('783', null, null, null, null, null, '2016-10-18 15:28:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('784', null, null, null, null, null, '2016-10-18 17:33:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('785', '', '永宁路33弄19号1201室', '0b378c4f890f52055cb340edf238857d2fc51833ad2cbfd5b0ee14c394fd67d0', '1989-02-24 00:00:00', '310115198902244717', '2016-10-18 19:00:49', '2016-10-18 20:27:26', null, null);
INSERT INTO `by_member_detail` VALUES ('786', null, null, null, null, null, '2016-10-19 10:38:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('787', null, null, null, null, null, '2016-10-19 11:57:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('788', null, null, null, null, null, '2016-10-20 13:28:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('789', null, null, null, null, null, '2016-10-20 18:14:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('790', null, null, null, null, null, '2016-10-20 18:35:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('791', null, null, null, null, null, '2016-10-20 18:42:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('792', '王珏', '', null, null, '', '2016-10-20 19:07:38', '2016-10-20 19:08:07', null, null);
INSERT INTO `by_member_detail` VALUES ('793', '沈小姐', '', '21fe3165a4d308ca908e90047bced706a186ccaa5547b4805156427cf5513599', null, '', '2016-10-20 19:10:48', '2016-10-20 19:12:11', null, null);
INSERT INTO `by_member_detail` VALUES ('794', null, null, null, null, null, '2016-10-20 19:13:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('795', null, null, null, null, null, '2016-10-20 19:16:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('796', null, null, null, null, null, '2016-10-20 19:21:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('797', null, null, null, null, null, '2016-10-20 19:59:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('798', '黄筱云', '', null, null, '', '2016-10-20 21:14:36', '2016-10-20 21:15:32', null, null);
INSERT INTO `by_member_detail` VALUES ('799', null, null, null, null, null, '2016-10-20 22:23:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('800', null, null, null, null, null, '2016-10-20 23:18:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('801', null, null, null, null, null, '2016-10-21 16:41:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('802', null, null, null, null, null, '2016-10-21 22:11:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('803', null, null, null, null, null, '2016-10-22 07:21:35', null, null, null);
INSERT INTO `by_member_detail` VALUES ('804', '', '曹路镇海鸣路98弄39号1301室', 'e81ed92e72aeb2aeea457c43e5c0e156a320ea362be688bae57d15d4e1e73df2', '1977-11-04 00:00:00', '', '2016-10-22 10:52:55', '2016-10-26 10:02:34', null, null);
INSERT INTO `by_member_detail` VALUES ('805', '刘凯', '', null, '1989-02-15 00:00:00', '371324198902155270', '2016-10-22 14:54:20', '2016-10-22 14:55:04', null, null);
INSERT INTO `by_member_detail` VALUES ('806', null, null, null, null, null, '2016-10-22 15:59:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('807', null, null, null, null, null, '2016-10-22 18:10:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('808', null, null, null, null, null, '2016-10-22 19:22:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('809', '奚军梅', '', null, null, '', '2016-10-22 20:40:34', '2016-10-22 20:40:54', null, null);
INSERT INTO `by_member_detail` VALUES ('810', '高先生', '', null, null, '', '2016-10-22 23:06:49', '2016-10-22 23:13:35', null, null);
INSERT INTO `by_member_detail` VALUES ('811', null, null, null, null, null, '2016-10-23 08:48:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('812', null, null, null, null, null, '2016-10-23 10:34:29', null, null, null);
INSERT INTO `by_member_detail` VALUES ('813', null, null, null, null, null, '2016-10-23 11:08:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('814', null, null, null, null, null, '2016-10-23 12:20:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('815', null, null, null, null, null, '2016-10-23 13:39:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('816', null, null, null, null, null, '2016-10-23 15:44:42', null, null, null);
INSERT INTO `by_member_detail` VALUES ('817', '谈丽倩', '', null, null, '', '2016-10-23 16:01:28', '2016-10-23 16:01:52', null, null);
INSERT INTO `by_member_detail` VALUES ('818', null, null, null, null, null, '2016-10-23 18:26:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('819', null, null, null, null, null, '2016-10-23 19:59:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('820', null, null, null, null, null, '2016-10-23 20:26:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('821', null, null, null, null, null, '2016-10-23 21:31:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('822', null, null, null, null, null, '2016-10-24 16:36:27', null, null, null);
INSERT INTO `by_member_detail` VALUES ('823', null, null, null, null, null, '2016-10-25 13:55:31', null, null, null);
INSERT INTO `by_member_detail` VALUES ('824', null, null, null, null, null, '2016-10-25 14:05:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('825', null, null, null, null, null, '2016-10-25 18:04:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('826', null, null, null, null, null, '2016-10-25 18:06:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('827', null, null, null, null, null, '2016-10-25 18:49:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('828', 'kiki', '', null, '1993-01-19 00:00:00', '', '2016-10-26 10:03:56', '2016-10-26 10:04:44', null, null);
INSERT INTO `by_member_detail` VALUES ('829', null, null, null, null, null, '2016-10-26 10:05:52', null, null, null);
INSERT INTO `by_member_detail` VALUES ('830', null, null, null, null, null, '2016-10-26 10:08:03', null, null, null);
INSERT INTO `by_member_detail` VALUES ('831', 'alisa', '', null, '1991-12-06 00:00:00', '', '2016-10-26 10:14:29', '2016-10-26 10:14:58', null, null);
INSERT INTO `by_member_detail` VALUES ('832', null, null, null, null, null, '2016-10-26 10:18:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('833', null, null, null, null, null, '2016-10-26 10:39:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('834', null, null, null, null, null, '2016-10-26 12:15:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('835', null, null, null, null, null, '2016-10-26 14:33:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('836', null, null, null, null, null, '2016-10-26 19:03:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('837', '', '高行鎮俱進路500弄46號502', '76bc12dc4ddceca0299caf87178b8e73eaf4141fc2e0bd6c5489e1794bcd7f2e', '1989-06-26 23:00:00', '412822198906271875', '2016-10-26 19:09:39', '2016-10-26 19:11:59', null, null);
INSERT INTO `by_member_detail` VALUES ('838', '', '浦东新区高行镇俱近路紫翠苑500弄46号502室', '76bc12dc4ddceca0299caf87178b8e73eaf4141fc2e0bd6c5489e1794bcd7f2e', '1990-06-09 23:00:00', '340123199006107909', '2016-10-26 19:12:38', '2016-10-26 19:15:30', null, null);
INSERT INTO `by_member_detail` VALUES ('839', '王雯雯', '', '1602b4048b35882a346c6887360d0343cde72797314f81a36065c71320562615', '2016-09-19 00:00:00', '', '2016-10-26 21:41:56', '2016-10-26 21:44:34', null, null);
INSERT INTO `by_member_detail` VALUES ('840', null, null, null, null, null, '2016-10-27 12:48:04', null, null, null);
INSERT INTO `by_member_detail` VALUES ('841', '黄海洋', '', null, '1982-10-11 00:00:00', '', '2016-10-27 15:43:33', '2016-10-27 15:44:09', null, null);
INSERT INTO `by_member_detail` VALUES ('842', null, null, null, null, null, '2016-10-28 10:24:47', null, null, null);
INSERT INTO `by_member_detail` VALUES ('843', null, null, null, null, null, '2016-10-28 10:35:17', null, null, null);
INSERT INTO `by_member_detail` VALUES ('844', null, null, null, null, null, '2016-10-28 10:40:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('845', null, null, null, null, null, '2016-10-28 10:44:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('846', null, null, null, null, null, '2016-10-28 10:45:16', null, null, null);
INSERT INTO `by_member_detail` VALUES ('847', null, null, null, null, null, '2016-10-28 10:59:54', null, null, null);
INSERT INTO `by_member_detail` VALUES ('848', null, null, null, null, null, '2016-10-28 11:02:26', null, null, null);
INSERT INTO `by_member_detail` VALUES ('849', '', '金杨路757弄82号101室', '9870dbed8aa48862f17b5e8ab5f907239a9baee946d858d02904dec21d55b52d', '1987-08-03 23:00:00', '', '2016-10-28 11:27:59', '2016-10-28 11:35:23', null, null);
INSERT INTO `by_member_detail` VALUES ('850', null, null, null, null, null, '2016-10-28 11:45:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('851', null, null, null, null, null, '2016-10-28 11:46:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('852', null, null, null, null, null, '2016-10-28 12:43:45', null, null, null);
INSERT INTO `by_member_detail` VALUES ('853', null, null, null, null, null, '2016-10-28 19:03:07', null, null, null);
INSERT INTO `by_member_detail` VALUES ('854', null, null, null, null, null, '2016-10-28 22:20:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('855', null, null, null, null, null, '2016-10-29 13:36:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('856', null, null, null, null, null, '2016-10-29 15:00:35', null, null, null);
INSERT INTO `by_member_detail` VALUES ('857', 'Felix', '', null, null, '', '2016-10-29 19:18:34', '2016-10-29 19:19:09', null, null);
INSERT INTO `by_member_detail` VALUES ('858', '王懿', '', '294e869b7d4148c42e8c693b1b26ef6d0ec8b3b151e9e26a5277e3298120ea72', null, '', '2016-10-29 20:33:31', '2016-10-29 20:43:13', null, null);
INSERT INTO `by_member_detail` VALUES ('859', null, null, null, null, null, '2016-10-30 09:00:40', null, null, null);
INSERT INTO `by_member_detail` VALUES ('860', null, null, null, null, null, '2016-10-30 10:37:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('861', null, null, null, null, null, '2016-10-30 12:39:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('862', null, null, null, null, null, '2016-10-30 12:39:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('863', null, null, null, null, null, '2016-10-30 14:22:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('864', '陈创', '', null, null, '', '2016-10-30 15:23:46', '2016-10-30 15:25:47', null, null);
INSERT INTO `by_member_detail` VALUES ('865', null, null, null, null, null, '2016-10-30 15:45:05', null, null, null);
INSERT INTO `by_member_detail` VALUES ('866', '符军', '', '69f7f7a7f8bca9970fa6f9c0b8dad06901d3ef23fd599d3213aa5eee5621c3e3', '1978-08-01 00:00:00', '', '2016-10-30 16:20:23', '2016-10-30 16:22:24', null, null);
INSERT INTO `by_member_detail` VALUES ('867', '蔡晓俊', '', null, null, '', '2016-10-30 16:41:55', '2016-10-30 16:44:33', null, null);
INSERT INTO `by_member_detail` VALUES ('868', null, null, null, null, null, '2016-10-30 17:37:02', null, null, null);
INSERT INTO `by_member_detail` VALUES ('869', null, null, null, null, null, '2016-10-30 17:39:10', null, null, null);
INSERT INTO `by_member_detail` VALUES ('870', null, null, null, null, null, '2016-10-30 17:54:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('871', null, null, null, null, null, '2016-10-30 18:36:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('872', null, null, null, null, null, '2016-10-30 19:06:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('873', null, null, null, null, null, '2016-10-30 20:09:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('874', null, null, null, null, null, '2016-10-30 20:34:13', null, null, null);
INSERT INTO `by_member_detail` VALUES ('875', null, null, null, null, null, '2016-10-30 23:16:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('876', '金春愉', '上海市浦东新区曹路镇金睦路353弄35号1102室', null, '1977-02-26 00:00:00', '310115197702264727', '2016-11-01 07:36:37', '2016-11-01 07:38:29', null, null);
INSERT INTO `by_member_detail` VALUES ('877', null, null, null, null, null, '2016-11-01 10:51:01', null, null, null);
INSERT INTO `by_member_detail` VALUES ('878', null, null, null, null, null, '2016-11-01 14:22:43', null, null, null);
INSERT INTO `by_member_detail` VALUES ('879', null, null, null, null, null, '2016-11-01 23:48:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('880', null, null, null, null, null, '2016-11-02 12:36:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('881', null, null, null, null, null, '2016-11-02 12:51:18', null, null, null);
INSERT INTO `by_member_detail` VALUES ('882', null, null, null, null, null, '2016-11-02 18:59:57', null, null, null);
INSERT INTO `by_member_detail` VALUES ('883', null, null, null, null, null, '2016-11-03 11:36:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('884', '涂翠梅', '', null, null, '', '2016-11-03 19:04:34', '2016-11-03 19:04:59', null, null);
INSERT INTO `by_member_detail` VALUES ('885', '盛锋', '', null, '1983-04-08 00:00:00', '', '2016-11-04 15:24:12', '2016-11-04 15:25:02', null, null);
INSERT INTO `by_member_detail` VALUES ('886', '', '寿光路161弄50号501室', '291b3a5e73e01211e8ce2aa2910dbe405c95eb8d52a022c5f37e2f25af6aa614', '1978-12-09 00:00:00', '310109197812090820', '2016-11-05 08:25:35', '2016-11-05 08:27:58', null, null);
INSERT INTO `by_member_detail` VALUES ('887', null, null, null, null, null, '2016-11-05 13:10:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('888', null, null, null, null, null, '2016-11-05 17:51:58', null, null, null);
INSERT INTO `by_member_detail` VALUES ('889', '杨熙珍', '永业路', null, '1988-02-02 00:00:00', '310110198802025208', '2016-11-05 19:33:24', '2016-11-05 19:34:31', null, null);
INSERT INTO `by_member_detail` VALUES ('890', null, null, null, null, null, '2016-11-05 19:53:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('891', null, null, null, null, null, '2016-11-06 11:36:08', null, null, null);
INSERT INTO `by_member_detail` VALUES ('892', null, null, null, null, null, '2016-11-06 15:17:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('893', null, null, null, null, null, '2016-11-06 15:41:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('894', null, null, null, null, null, '2016-11-06 16:23:24', null, null, null);
INSERT INTO `by_member_detail` VALUES ('895', null, null, null, null, null, '2016-11-06 18:31:36', null, null, null);
INSERT INTO `by_member_detail` VALUES ('896', null, null, null, null, null, '2016-11-06 23:05:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('897', null, null, null, null, null, '2016-11-07 20:31:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('898', '周晓芸', '东陆路2000弄2号1402', null, '1980-10-25 00:00:00', '', '2016-11-09 20:44:29', '2016-11-09 20:46:19', null, null);
INSERT INTO `by_member_detail` VALUES ('899', null, null, null, null, null, '2016-11-09 20:57:21', null, null, null);
INSERT INTO `by_member_detail` VALUES ('900', null, null, '83916e070e7d8f0028243f64f78d95aa8513248a5c3b652e1b2713c3f65533c0', null, null, '2016-11-09 20:57:46', '2016-11-09 21:00:53', null, null);
INSERT INTO `by_member_detail` VALUES ('901', null, null, null, null, null, '2016-11-10 08:14:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('902', '张露', '', null, '1985-12-08 00:00:00', '', '2016-11-10 09:22:20', '2016-11-10 09:23:07', null, null);
INSERT INTO `by_member_detail` VALUES ('903', null, null, null, null, null, '2016-11-10 21:18:28', null, null, null);
INSERT INTO `by_member_detail` VALUES ('904', null, null, null, null, null, '2016-11-11 15:35:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('905', null, null, null, null, null, '2016-11-11 17:58:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('906', null, null, null, null, null, '2016-11-11 19:39:49', null, null, null);
INSERT INTO `by_member_detail` VALUES ('907', null, null, null, null, null, '2016-11-11 21:34:23', null, null, null);
INSERT INTO `by_member_detail` VALUES ('908', null, null, null, null, null, '2016-11-12 17:17:55', null, null, null);
INSERT INTO `by_member_detail` VALUES ('909', null, null, null, null, null, '2016-11-12 20:53:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('910', null, null, null, null, null, '2016-11-13 13:24:30', null, null, null);
INSERT INTO `by_member_detail` VALUES ('911', '', '', '5eff4324d8fb8a52468c9d52f0fb4c0d1a533e78fc9c4435df3d0ae96a1080f6', null, '', '2016-11-13 14:14:16', '2016-11-13 14:15:29', null, null);
INSERT INTO `by_member_detail` VALUES ('912', '', '佳乐路255弄38号202室', 'b27a069faff2948eb3b970c997e168d32da451815963429f7818bec51decd790', '1992-02-22 00:00:00', '310115199202224728', '2016-11-14 12:44:54', '2016-11-14 12:53:15', null, null);
INSERT INTO `by_member_detail` VALUES ('913', null, null, null, null, null, '2016-11-14 20:32:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('914', null, null, null, null, null, '2016-11-15 22:58:03', null, null, null);
INSERT INTO `by_member_detail` VALUES ('915', '岳柱', '', null, null, '', '2016-11-16 14:52:56', '2016-11-16 14:53:22', null, null);
INSERT INTO `by_member_detail` VALUES ('916', null, null, null, null, null, '2016-11-17 11:21:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('917', null, null, null, null, null, '2016-11-17 17:10:25', null, null, null);
INSERT INTO `by_member_detail` VALUES ('918', '吴征宇', '', null, null, '', '2016-11-17 19:33:51', '2016-11-17 19:34:15', null, null);
INSERT INTO `by_member_detail` VALUES ('919', '陆茹玉', '', null, '1988-01-08 00:00:00', '', '2016-11-17 21:30:56', '2016-11-17 21:31:59', null, null);
INSERT INTO `by_member_detail` VALUES ('920', null, null, null, null, null, '2016-11-17 22:01:57', null, null, null);
INSERT INTO `by_member_detail` VALUES ('921', null, null, null, null, null, '2016-11-18 06:09:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('922', '', '', 'd1fc8c39cabb5c23186ac162a5d9a9594105a6ffa64236712598404fd74c46ae', '1978-10-25 00:00:00', '310115197810251130', '2016-11-18 09:50:02', '2016-11-18 09:52:22', null, null);
INSERT INTO `by_member_detail` VALUES ('923', '', '上海市浦东新区东陆路2000弄18号501室', '8e1340a376d5715dbc2215950e1278912591ce9ef8396f09d3ae5b0ff03e9404', '1979-02-11 00:00:00', '342401197902110824', '2016-11-18 11:45:27', '2016-11-18 11:47:12', null, null);
INSERT INTO `by_member_detail` VALUES ('924', null, null, null, null, null, '2016-11-18 15:06:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('925', null, null, null, null, null, '2016-11-19 09:07:15', null, null, null);
INSERT INTO `by_member_detail` VALUES ('926', '楚玉勤', '', null, '1988-03-15 00:00:00', '', '2016-11-19 12:46:04', '2016-11-19 12:47:24', null, null);
INSERT INTO `by_member_detail` VALUES ('927', null, null, null, null, null, '2016-11-19 14:11:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('928', null, null, null, null, null, '2016-11-19 21:13:33', null, null, null);
INSERT INTO `by_member_detail` VALUES ('929', null, null, null, null, null, '2016-11-20 16:25:44', null, null, null);
INSERT INTO `by_member_detail` VALUES ('930', null, null, null, null, null, '2016-11-20 17:44:48', null, null, null);
INSERT INTO `by_member_detail` VALUES ('931', null, null, null, null, null, '2016-11-20 20:59:06', null, null, null);
INSERT INTO `by_member_detail` VALUES ('932', null, null, null, null, null, '2016-11-20 21:56:20', null, null, null);
INSERT INTO `by_member_detail` VALUES ('933', null, null, null, null, null, '2016-11-21 11:31:12', null, null, null);
INSERT INTO `by_member_detail` VALUES ('934', null, null, null, null, null, '2016-11-21 17:11:14', null, null, null);
INSERT INTO `by_member_detail` VALUES ('935', null, null, null, null, null, '2016-11-21 19:21:19', null, null, null);
INSERT INTO `by_member_detail` VALUES ('936', '', '佳林路898弄3号601', '6d19ca72de1fe7973e5a763cdbaf47af34674d4f45a8a2cacd881b751d680a4f', '1984-03-08 00:00:00', '362301198403082016', '2016-11-22 10:37:23', '2016-11-22 10:39:29', null, null);
INSERT INTO `by_member_detail` VALUES ('937', '夏惜', '', null, null, '', '2016-11-22 18:49:52', '2016-11-22 18:50:23', null, null);
INSERT INTO `by_member_detail` VALUES ('938', null, null, null, null, null, '2016-11-23 14:30:00', null, null, null);
INSERT INTO `by_member_detail` VALUES ('939', '', '', null, '1987-03-25 00:00:00', '', '2016-11-23 15:18:26', '2016-11-23 15:19:25', null, null);
INSERT INTO `by_member_detail` VALUES ('940', null, null, null, null, null, '2016-11-23 15:58:09', null, null, null);
INSERT INTO `by_member_detail` VALUES ('941', null, null, null, null, null, '2016-11-23 20:42:37', null, null, null);
INSERT INTO `by_member_detail` VALUES ('942', null, null, null, null, null, '2016-11-24 11:51:53', null, null, null);
INSERT INTO `by_member_detail` VALUES ('943', null, null, null, null, null, '2016-11-26 10:41:34', null, null, null);
INSERT INTO `by_member_detail` VALUES ('944', null, null, null, null, null, '2016-11-26 19:07:32', null, null, null);
INSERT INTO `by_member_detail` VALUES ('945', null, null, null, null, null, '2016-11-27 11:20:59', null, null, null);
INSERT INTO `by_member_detail` VALUES ('946', null, null, null, null, null, '2016-11-27 12:42:38', null, null, null);
INSERT INTO `by_member_detail` VALUES ('947', null, null, null, null, null, '2016-11-27 14:18:03', null, null, null);

-- ----------------------------
-- Table structure for by_member_detail_aud
-- ----------------------------
DROP TABLE IF EXISTS `by_member_detail_aud`;
CREATE TABLE `by_member_detail_aud` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `real_name` varchar(10) DEFAULT NULL,
  `address` varchar(225) DEFAULT NULL,
  `password` char(64) DEFAULT NULL,
  `birthday` timestamp NULL DEFAULT NULL,
  `detail_id` bigint(20) DEFAULT NULL,
  `ic` char(18) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `REV` int(11) NOT NULL,
  `REVTYPE` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`,`REV`),
  KEY `detail_id` (`detail_id`) USING BTREE,
  CONSTRAINT `by_member_detail_aud_ibfk_1` FOREIGN KEY (`detail_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=948 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_member_detail_aud
-- ----------------------------
INSERT INTO `by_member_detail_aud` VALUES ('37', null, null, null, null, null, null, '2016-09-06 00:12:26', null, null, null, '247', '0');
INSERT INTO `by_member_detail_aud` VALUES ('38', null, null, null, null, null, null, '2016-09-06 11:58:21', null, null, null, '248', '0');
INSERT INTO `by_member_detail_aud` VALUES ('39', null, null, null, null, null, null, '2016-09-06 16:43:07', null, null, null, '249', '0');
INSERT INTO `by_member_detail_aud` VALUES ('39', '陈颖', '', null, '2016-08-20 00:00:00', null, '', '2016-09-06 16:43:07', '2016-09-06 16:46:31', null, null, '250', '1');
INSERT INTO `by_member_detail_aud` VALUES ('39', '陈颖', '', '4bb6b108c51c31a11fae223d5a97945390b170b8065b7dc05e6984bfa8f31907', '2016-08-20 00:00:00', null, '', '2016-09-06 16:43:07', '2016-09-06 17:38:15', null, null, '254', '1');
INSERT INTO `by_member_detail_aud` VALUES ('39', '陈颖', '', '4bb6b108c51c31a11fae223d5a97945390b170b8065b7dc05e6984bfa8f31907', '1973-08-20 00:00:00', null, '310101197308204824', '2016-09-06 16:43:07', '2016-09-06 17:38:40', null, null, '255', '1');
INSERT INTO `by_member_detail_aud` VALUES ('40', null, null, null, null, null, null, '2016-09-06 16:49:15', null, null, null, '251', '0');
INSERT INTO `by_member_detail_aud` VALUES ('41', null, null, null, null, null, null, '2016-09-06 16:49:48', null, null, null, '252', '0');
INSERT INTO `by_member_detail_aud` VALUES ('42', null, null, null, null, null, null, '2016-09-06 16:49:52', null, null, null, '253', '0');
INSERT INTO `by_member_detail_aud` VALUES ('43', null, null, null, null, null, null, '2016-09-07 13:49:31', null, null, null, '256', '0');
INSERT INTO `by_member_detail_aud` VALUES ('44', null, null, null, null, null, null, '2016-09-07 13:50:09', null, null, null, '257', '0');
INSERT INTO `by_member_detail_aud` VALUES ('45', null, null, null, null, null, null, '2016-09-07 13:50:33', null, null, null, '258', '0');
INSERT INTO `by_member_detail_aud` VALUES ('46', null, null, null, null, null, null, '2016-09-07 13:50:40', null, null, null, '259', '0');
INSERT INTO `by_member_detail_aud` VALUES ('47', null, null, null, null, null, null, '2016-09-07 22:15:19', null, null, null, '260', '0');
INSERT INTO `by_member_detail_aud` VALUES ('47', null, null, '14003029ffe4f2d8316531684d259b9085e4bb2efa7235c73920b16a22af0f68', null, null, null, '2016-09-07 22:15:19', '2016-09-07 22:17:57', null, null, '262', '1');
INSERT INTO `by_member_detail_aud` VALUES ('47', '', 'vvcvvvvcc', '14003029ffe4f2d8316531684d259b9085e4bb2efa7235c73920b16a22af0f68', '1984-10-01 00:00:00', null, '412723198410015991', '2016-09-07 22:15:19', '2016-09-07 22:18:36', null, null, '263', '1');
INSERT INTO `by_member_detail_aud` VALUES ('48', null, null, null, null, null, null, '2016-09-07 22:15:30', null, null, null, '261', '0');
INSERT INTO `by_member_detail_aud` VALUES ('49', null, null, null, null, null, null, '2016-09-07 22:21:04', null, null, null, '264', '0');
INSERT INTO `by_member_detail_aud` VALUES ('50', null, null, null, null, null, null, '2016-09-07 23:01:48', null, null, null, '265', '0');
INSERT INTO `by_member_detail_aud` VALUES ('50', '王小姐', '张桥', null, '1986-09-10 23:00:00', null, '', '2016-09-07 23:01:48', '2016-09-07 23:02:41', null, null, '266', '1');
INSERT INTO `by_member_detail_aud` VALUES ('51', null, null, null, null, null, null, '2016-09-07 23:18:12', null, null, null, '267', '0');
INSERT INTO `by_member_detail_aud` VALUES ('52', null, null, null, null, null, null, '2016-09-07 23:46:03', null, null, null, '268', '0');
INSERT INTO `by_member_detail_aud` VALUES ('52', '吴方烨', '上海市浦东新区莱阳路451-22-201', null, '1994-10-08 00:00:00', null, '310115199410080626', '2016-09-07 23:46:03', '2016-09-07 23:46:36', null, null, '269', '1');
INSERT INTO `by_member_detail_aud` VALUES ('53', null, null, null, null, null, null, '2016-09-08 00:02:48', null, null, null, '270', '0');
INSERT INTO `by_member_detail_aud` VALUES ('53', '', '', null, '2016-07-03 00:00:00', null, '', '2016-09-08 00:02:48', '2016-09-11 18:43:20', null, null, '656', '1');
INSERT INTO `by_member_detail_aud` VALUES ('54', null, null, null, null, null, null, '2016-09-08 00:06:24', null, null, null, '271', '0');
INSERT INTO `by_member_detail_aud` VALUES ('55', null, null, null, null, null, null, '2016-09-08 00:07:39', null, null, null, '272', '0');
INSERT INTO `by_member_detail_aud` VALUES ('55', '', '永宁路33弄14号303', null, '1976-06-18 00:00:00', null, '310224197606182811', '2016-09-08 00:07:39', '2016-09-08 00:09:21', null, null, '273', '1');
INSERT INTO `by_member_detail_aud` VALUES ('55', '陈笛', '永宁路33弄14号303', null, '1976-06-18 00:00:00', null, '310224197606182811', '2016-09-08 00:07:39', '2016-09-08 00:09:50', null, null, '274', '1');
INSERT INTO `by_member_detail_aud` VALUES ('56', null, null, null, null, null, null, '2016-09-08 00:18:38', null, null, null, '275', '0');
INSERT INTO `by_member_detail_aud` VALUES ('57', null, null, null, null, null, null, '2016-09-08 01:05:13', null, null, null, '276', '0');
INSERT INTO `by_member_detail_aud` VALUES ('58', null, null, null, null, null, null, '2016-09-08 01:17:51', null, null, null, '277', '0');
INSERT INTO `by_member_detail_aud` VALUES ('59', null, null, null, null, null, null, '2016-09-08 05:46:19', null, null, null, '278', '0');
INSERT INTO `by_member_detail_aud` VALUES ('60', null, null, null, null, null, null, '2016-09-08 05:50:40', null, null, null, '279', '0');
INSERT INTO `by_member_detail_aud` VALUES ('61', null, null, null, null, null, null, '2016-09-08 06:47:16', null, null, null, '280', '0');
INSERT INTO `by_member_detail_aud` VALUES ('62', null, null, null, null, null, null, '2016-09-08 06:53:17', null, null, null, '281', '0');
INSERT INTO `by_member_detail_aud` VALUES ('63', null, null, null, null, null, null, '2016-09-08 06:58:12', null, null, null, '282', '0');
INSERT INTO `by_member_detail_aud` VALUES ('64', null, null, null, null, null, null, '2016-09-08 07:06:50', null, null, null, '283', '0');
INSERT INTO `by_member_detail_aud` VALUES ('65', null, null, null, null, null, null, '2016-09-08 07:13:38', null, null, null, '284', '0');
INSERT INTO `by_member_detail_aud` VALUES ('65', null, null, '18fbe54dadcf9cffd6b307144803b7f681a4315d425908f3dc4fa91782350137', null, null, null, '2016-09-08 07:13:38', '2016-09-08 07:22:13', null, null, '285', '1');
INSERT INTO `by_member_detail_aud` VALUES ('66', null, null, null, null, null, null, '2016-09-08 07:30:02', null, null, null, '286', '0');
INSERT INTO `by_member_detail_aud` VALUES ('67', null, null, null, null, null, null, '2016-09-08 07:30:13', null, null, null, '287', '0');
INSERT INTO `by_member_detail_aud` VALUES ('68', null, null, null, null, null, null, '2016-09-08 08:02:58', null, null, null, '288', '0');
INSERT INTO `by_member_detail_aud` VALUES ('69', null, null, null, null, null, null, '2016-09-08 08:18:05', null, null, null, '289', '0');
INSERT INTO `by_member_detail_aud` VALUES ('70', null, null, null, null, null, null, '2016-09-08 08:21:49', null, null, null, '290', '0');
INSERT INTO `by_member_detail_aud` VALUES ('71', null, null, null, null, null, null, '2016-09-08 08:46:15', null, null, null, '291', '0');
INSERT INTO `by_member_detail_aud` VALUES ('72', null, null, null, null, null, null, '2016-09-08 09:01:42', null, null, null, '292', '0');
INSERT INTO `by_member_detail_aud` VALUES ('73', null, null, null, null, null, null, '2016-09-08 09:04:34', null, null, null, '293', '0');
INSERT INTO `by_member_detail_aud` VALUES ('73', '王丽华', '', null, null, null, '', '2016-09-08 09:04:34', '2016-09-08 09:50:43', null, null, '303', '1');
INSERT INTO `by_member_detail_aud` VALUES ('74', null, null, null, null, null, null, '2016-09-08 09:08:13', null, null, null, '294', '0');
INSERT INTO `by_member_detail_aud` VALUES ('75', null, null, null, null, null, null, '2016-09-08 09:12:13', null, null, null, '295', '0');
INSERT INTO `by_member_detail_aud` VALUES ('76', null, null, null, null, null, null, '2016-09-08 09:22:31', null, null, null, '296', '0');
INSERT INTO `by_member_detail_aud` VALUES ('77', null, null, null, null, null, null, '2016-09-08 09:30:28', null, null, null, '297', '0');
INSERT INTO `by_member_detail_aud` VALUES ('77', null, null, '5a58d36b723153363f67a6975971aa3addb9cffa0d2bb023e83e251708334049', null, null, null, '2016-09-08 09:30:28', '2016-09-08 09:31:53', null, null, '299', '1');
INSERT INTO `by_member_detail_aud` VALUES ('77', '张岚', '金高路2131弄2号302室', '5a58d36b723153363f67a6975971aa3addb9cffa0d2bb023e83e251708334049', '1984-11-09 00:00:00', null, '310115198411094427', '2016-09-08 09:30:28', '2016-09-08 09:32:38', null, null, '300', '1');
INSERT INTO `by_member_detail_aud` VALUES ('78', null, null, null, null, null, null, '2016-09-08 09:30:56', null, null, null, '298', '0');
INSERT INTO `by_member_detail_aud` VALUES ('79', null, null, null, null, null, null, '2016-09-08 09:34:32', null, null, null, '301', '0');
INSERT INTO `by_member_detail_aud` VALUES ('80', null, null, null, null, null, null, '2016-09-08 09:35:28', null, null, null, '302', '0');
INSERT INTO `by_member_detail_aud` VALUES ('81', null, null, null, null, null, null, '2016-09-08 09:56:28', null, null, null, '304', '0');
INSERT INTO `by_member_detail_aud` VALUES ('81', '尹怡', '', null, null, null, '', '2016-09-08 09:56:28', '2016-09-14 17:19:38', null, null, '867', '1');
INSERT INTO `by_member_detail_aud` VALUES ('82', null, null, null, null, null, null, '2016-09-08 09:58:24', null, null, null, '305', '0');
INSERT INTO `by_member_detail_aud` VALUES ('83', null, null, null, null, null, null, '2016-09-08 09:59:09', null, null, null, '306', '0');
INSERT INTO `by_member_detail_aud` VALUES ('83', '', '', null, '2016-09-29 00:00:00', null, '', '2016-09-08 09:59:09', '2016-09-08 10:00:07', null, null, '307', '1');
INSERT INTO `by_member_detail_aud` VALUES ('83', '', '', '8b0f6816d4fb303d0dabb3ae80b66b86417aced94188d853ab0e518cdcd76eb1', '2016-09-29 00:00:00', null, '', '2016-09-08 09:59:09', '2016-09-08 10:00:58', null, null, '308', '1');
INSERT INTO `by_member_detail_aud` VALUES ('83', '朱先生', '', '8b0f6816d4fb303d0dabb3ae80b66b86417aced94188d853ab0e518cdcd76eb1', '2016-09-29 00:00:00', null, '', '2016-09-08 09:59:09', '2016-09-08 12:32:42', null, null, '349', '1');
INSERT INTO `by_member_detail_aud` VALUES ('84', null, null, null, null, null, null, '2016-09-08 10:17:08', null, null, null, '309', '0');
INSERT INTO `by_member_detail_aud` VALUES ('85', null, null, null, null, null, null, '2016-09-08 10:20:42', null, null, null, '310', '0');
INSERT INTO `by_member_detail_aud` VALUES ('85', null, null, '406960020bebb0a5a3205e7a01766c8503115357d082a34c070834e50837c7dd', null, null, null, '2016-09-08 10:20:42', '2016-09-08 10:22:33', null, null, '311', '1');
INSERT INTO `by_member_detail_aud` VALUES ('85', '', '闸北区西宝兴路922弄5号301室', '406960020bebb0a5a3205e7a01766c8503115357d082a34c070834e50837c7dd', '1984-05-12 00:00:00', null, '310109198405120011', '2016-09-08 10:20:42', '2016-09-08 10:23:10', null, null, '312', '1');
INSERT INTO `by_member_detail_aud` VALUES ('85', '李仕俊', '闸北区西宝兴路922弄5号301室', '406960020bebb0a5a3205e7a01766c8503115357d082a34c070834e50837c7dd', '1984-05-12 00:00:00', null, '310109198405120011', '2016-09-08 10:20:42', '2016-09-08 10:23:30', null, null, '313', '1');
INSERT INTO `by_member_detail_aud` VALUES ('86', null, null, null, null, null, null, '2016-09-08 10:44:32', null, null, null, '314', '0');
INSERT INTO `by_member_detail_aud` VALUES ('86', '', '双桥路1108弄2号404室', null, '1982-11-23 00:00:00', null, '', '2016-09-08 10:44:32', '2016-09-08 10:46:29', null, null, '316', '1');
INSERT INTO `by_member_detail_aud` VALUES ('87', null, null, null, null, null, null, '2016-09-08 10:46:15', null, null, null, '315', '0');
INSERT INTO `by_member_detail_aud` VALUES ('87', '华先生', '', null, '1984-08-05 00:00:00', null, '', '2016-09-08 10:46:15', '2016-09-08 10:47:01', null, null, '317', '1');
INSERT INTO `by_member_detail_aud` VALUES ('88', null, null, null, null, null, null, '2016-09-08 10:50:52', null, null, null, '318', '0');
INSERT INTO `by_member_detail_aud` VALUES ('89', null, null, null, null, null, null, '2016-09-08 10:52:15', null, null, null, '319', '0');
INSERT INTO `by_member_detail_aud` VALUES ('90', null, null, null, null, null, null, '2016-09-08 10:56:34', null, null, null, '320', '0');
INSERT INTO `by_member_detail_aud` VALUES ('90', null, null, 'bc39d83f620cbbfc4a17a5aaf30fb575fbee04680ba72e2427034a06929f74a6', null, null, null, '2016-09-08 10:56:34', '2016-09-08 10:58:09', null, null, '321', '1');
INSERT INTO `by_member_detail_aud` VALUES ('90', '', '永建路86弄3号401室', 'bc39d83f620cbbfc4a17a5aaf30fb575fbee04680ba72e2427034a06929f74a6', '1986-06-02 23:00:00', null, '', '2016-09-08 10:56:34', '2016-09-08 10:58:45', null, null, '322', '1');
INSERT INTO `by_member_detail_aud` VALUES ('91', null, null, null, null, null, null, '2016-09-08 10:59:39', null, null, null, '323', '0');
INSERT INTO `by_member_detail_aud` VALUES ('92', null, null, null, null, null, null, '2016-09-08 11:03:00', null, null, null, '324', '0');
INSERT INTO `by_member_detail_aud` VALUES ('93', null, null, null, null, null, null, '2016-09-08 11:03:14', null, null, null, '325', '0');
INSERT INTO `by_member_detail_aud` VALUES ('94', null, null, null, null, null, null, '2016-09-08 11:04:41', null, null, null, '326', '0');
INSERT INTO `by_member_detail_aud` VALUES ('95', null, null, null, null, null, null, '2016-09-08 11:11:31', null, null, null, '327', '0');
INSERT INTO `by_member_detail_aud` VALUES ('96', null, null, null, null, null, null, '2016-09-08 11:21:20', null, null, null, '328', '0');
INSERT INTO `by_member_detail_aud` VALUES ('97', null, null, null, null, null, null, '2016-09-08 11:21:47', null, null, null, '329', '0');
INSERT INTO `by_member_detail_aud` VALUES ('98', null, null, null, null, null, null, '2016-09-08 11:24:37', null, null, null, '330', '0');
INSERT INTO `by_member_detail_aud` VALUES ('99', null, null, null, null, null, null, '2016-09-08 11:39:30', null, null, null, '331', '0');
INSERT INTO `by_member_detail_aud` VALUES ('99', null, null, 'fe6c77fe3dacc68a741cf8b77e190f6415629a86ed13366c652dd29b1c5315a3', null, null, null, '2016-09-08 11:39:30', '2016-09-08 11:40:55', null, null, '332', '1');
INSERT INTO `by_member_detail_aud` VALUES ('99', '龚黎', '张杨北路2899弄18号201室', 'fe6c77fe3dacc68a741cf8b77e190f6415629a86ed13366c652dd29b1c5315a3', '1977-11-08 00:00:00', null, '', '2016-09-08 11:39:30', '2016-09-08 11:42:33', null, null, '333', '1');
INSERT INTO `by_member_detail_aud` VALUES ('100', null, null, null, null, null, null, '2016-09-08 11:50:36', null, null, null, '334', '0');
INSERT INTO `by_member_detail_aud` VALUES ('100', null, null, '04e89c71d7fc4838e7c6423c36e95b0944a17051f00c4d0c0c1f3d69959d6a1b', null, null, null, '2016-09-08 11:50:36', '2016-09-08 11:52:11', null, null, '337', '1');
INSERT INTO `by_member_detail_aud` VALUES ('100', '', '上海浦东新区金高路1740号', '04e89c71d7fc4838e7c6423c36e95b0944a17051f00c4d0c0c1f3d69959d6a1b', '2005-04-08 00:00:00', null, '', '2016-09-08 11:50:36', '2016-09-08 11:53:01', null, null, '338', '1');
INSERT INTO `by_member_detail_aud` VALUES ('100', '', '上海浦东新区金高路1740号', '04e89c71d7fc4838e7c6423c36e95b0944a17051f00c4d0c0c1f3d69959d6a1b', '2005-04-08 00:00:00', null, '330382200504082868', '2016-09-08 11:50:36', '2016-09-08 20:05:37', null, null, '441', '1');
INSERT INTO `by_member_detail_aud` VALUES ('100', '倪珍琦', '上海浦东新区金高路1740号', '04e89c71d7fc4838e7c6423c36e95b0944a17051f00c4d0c0c1f3d69959d6a1b', '2005-04-08 00:00:00', null, '330382200504082868', '2016-09-08 11:50:36', '2016-09-08 20:07:51', null, null, '442', '1');
INSERT INTO `by_member_detail_aud` VALUES ('101', null, null, null, null, null, null, '2016-09-08 11:51:26', null, null, null, '335', '0');
INSERT INTO `by_member_detail_aud` VALUES ('101', '丁丁', '', null, null, null, '', '2016-09-08 11:51:26', '2016-09-08 11:51:53', null, null, '336', '1');
INSERT INTO `by_member_detail_aud` VALUES ('102', null, null, null, null, null, null, '2016-09-08 12:01:22', null, null, null, '339', '0');
INSERT INTO `by_member_detail_aud` VALUES ('103', null, null, null, null, null, null, '2016-09-08 12:03:02', null, null, null, '340', '0');
INSERT INTO `by_member_detail_aud` VALUES ('103', null, null, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, null, null, '2016-09-08 12:03:02', '2016-09-08 12:08:19', null, null, '344', '1');
INSERT INTO `by_member_detail_aud` VALUES ('103', '李纲', '佳林路919弄30号201室', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1978-01-30 00:00:00', null, '610111197801305139', '2016-09-08 12:03:02', '2016-09-08 12:09:15', null, null, '345', '1');
INSERT INTO `by_member_detail_aud` VALUES ('104', null, null, null, null, null, null, '2016-09-08 12:03:57', null, null, null, '341', '0');
INSERT INTO `by_member_detail_aud` VALUES ('104', null, null, 'c6470a71212586010744706f179af7863fe6a333f0717ba87744da4ce92ba8e7', null, null, null, '2016-09-08 12:03:57', '2016-09-08 12:05:12', null, null, '342', '1');
INSERT INTO `by_member_detail_aud` VALUES ('105', null, null, null, null, null, null, '2016-09-08 12:08:04', null, null, null, '343', '0');
INSERT INTO `by_member_detail_aud` VALUES ('106', null, null, null, null, null, null, '2016-09-08 12:20:24', null, null, null, '346', '0');
INSERT INTO `by_member_detail_aud` VALUES ('107', null, null, null, null, null, null, '2016-09-08 12:29:41', null, null, null, '347', '0');
INSERT INTO `by_member_detail_aud` VALUES ('107', '张佳燕', '', null, null, null, '', '2016-09-08 12:29:41', '2016-09-08 12:30:22', null, null, '348', '1');
INSERT INTO `by_member_detail_aud` VALUES ('108', null, null, null, null, null, null, '2016-09-08 12:46:39', null, null, null, '350', '0');
INSERT INTO `by_member_detail_aud` VALUES ('108', null, null, '245c04351a327cc36db4531d41f81327a02b92c76c8745a7326a14e9f9656663', null, null, null, '2016-09-08 12:46:39', '2016-09-08 12:48:20', null, null, '352', '1');
INSERT INTO `by_member_detail_aud` VALUES ('108', '', '金高路1617弄188号5室', '245c04351a327cc36db4531d41f81327a02b92c76c8745a7326a14e9f9656663', '1982-03-15 00:00:00', null, '510703198203152420', '2016-09-08 12:46:39', '2016-09-08 12:49:33', null, null, '353', '1');
INSERT INTO `by_member_detail_aud` VALUES ('109', null, null, null, null, null, null, '2016-09-08 12:46:44', null, null, null, '351', '0');
INSERT INTO `by_member_detail_aud` VALUES ('110', null, null, null, null, null, null, '2016-09-08 12:50:04', null, null, null, '354', '0');
INSERT INTO `by_member_detail_aud` VALUES ('110', null, null, 'e7fcf5624c3b1d54c28b83629f36bd4bd9a1fc2d8a0dc89049519b83316b0e1f', null, null, null, '2016-09-08 12:50:04', '2016-09-08 12:51:43', null, null, '355', '1');
INSERT INTO `by_member_detail_aud` VALUES ('110', '沈玉妹', '博兴路1383弄18号302室', 'e7fcf5624c3b1d54c28b83629f36bd4bd9a1fc2d8a0dc89049519b83316b0e1f', '1985-12-19 00:00:00', null, '310115198512190944', '2016-09-08 12:50:04', '2016-09-08 12:52:17', null, null, '356', '1');
INSERT INTO `by_member_detail_aud` VALUES ('111', null, null, null, null, null, null, '2016-09-08 12:55:10', null, null, null, '357', '0');
INSERT INTO `by_member_detail_aud` VALUES ('112', null, null, null, null, null, null, '2016-09-08 13:01:45', null, null, null, '358', '0');
INSERT INTO `by_member_detail_aud` VALUES ('113', null, null, null, null, null, null, '2016-09-08 13:22:14', null, null, null, '359', '0');
INSERT INTO `by_member_detail_aud` VALUES ('114', null, null, null, null, null, null, '2016-09-08 13:24:36', null, null, null, '360', '0');
INSERT INTO `by_member_detail_aud` VALUES ('115', null, null, null, null, null, null, '2016-09-08 13:25:15', null, null, null, '361', '0');
INSERT INTO `by_member_detail_aud` VALUES ('115', '', '东陆路1528弄9号601室', null, '1982-04-27 00:00:00', null, '310230198204274766', '2016-09-08 13:25:15', '2016-09-08 13:28:41', null, null, '364', '1');
INSERT INTO `by_member_detail_aud` VALUES ('116', null, null, null, null, null, null, '2016-09-08 13:25:31', null, null, null, '362', '0');
INSERT INTO `by_member_detail_aud` VALUES ('116', '甜妈', '', null, '1998-03-24 00:00:00', null, '', '2016-09-08 13:25:31', '2016-09-08 13:26:35', null, null, '363', '1');
INSERT INTO `by_member_detail_aud` VALUES ('117', null, null, null, null, null, null, '2016-09-08 13:29:10', null, null, null, '365', '0');
INSERT INTO `by_member_detail_aud` VALUES ('118', null, null, null, null, null, null, '2016-09-08 13:41:04', null, null, null, '366', '0');
INSERT INTO `by_member_detail_aud` VALUES ('118', '张淑颖', '', null, '1983-02-04 00:00:00', null, '', '2016-09-08 13:41:04', '2016-09-08 13:48:22', null, null, '367', '1');
INSERT INTO `by_member_detail_aud` VALUES ('119', null, null, null, null, null, null, '2016-09-08 13:49:09', null, null, null, '368', '0');
INSERT INTO `by_member_detail_aud` VALUES ('120', null, null, null, null, null, null, '2016-09-08 13:50:13', null, null, null, '369', '0');
INSERT INTO `by_member_detail_aud` VALUES ('121', null, null, null, null, null, null, '2016-09-08 13:50:15', null, null, null, '370', '0');
INSERT INTO `by_member_detail_aud` VALUES ('122', null, null, null, null, null, null, '2016-09-08 13:51:56', null, null, null, '371', '0');
INSERT INTO `by_member_detail_aud` VALUES ('123', null, null, null, null, null, null, '2016-09-08 14:06:50', null, null, null, '372', '0');
INSERT INTO `by_member_detail_aud` VALUES ('123', 'eric', '', null, null, null, '', '2016-09-08 14:06:50', '2016-09-08 14:07:23', null, null, '373', '1');
INSERT INTO `by_member_detail_aud` VALUES ('124', null, null, null, null, null, null, '2016-09-08 14:08:45', null, null, null, '374', '0');
INSERT INTO `by_member_detail_aud` VALUES ('125', null, null, null, null, null, null, '2016-09-08 14:10:23', null, null, null, '375', '0');
INSERT INTO `by_member_detail_aud` VALUES ('125', null, null, 'dfb120fc01c3748e6a39d123f587e9c9855866f0459b5e32621e95824d617ed7', null, null, null, '2016-09-08 14:10:23', '2016-09-08 14:11:09', null, null, '376', '1');
INSERT INTO `by_member_detail_aud` VALUES ('125', '', '', 'dfb120fc01c3748e6a39d123f587e9c9855866f0459b5e32621e95824d617ed7', '1992-01-30 00:00:00', null, '', '2016-09-08 14:10:23', '2016-09-08 14:11:27', null, null, '377', '1');
INSERT INTO `by_member_detail_aud` VALUES ('126', null, null, null, null, null, null, '2016-09-08 14:12:55', null, null, null, '378', '0');
INSERT INTO `by_member_detail_aud` VALUES ('126', null, null, '8dce461ae21e7d40e1335337bf5c1be135fe854c071bd37c91aacbf75a1f3387', null, null, null, '2016-09-08 14:12:55', '2016-09-08 14:15:25', null, null, '379', '1');
INSERT INTO `by_member_detail_aud` VALUES ('126', '', '东陆路2000弄31号102室', '8dce461ae21e7d40e1335337bf5c1be135fe854c071bd37c91aacbf75a1f3387', '1987-03-07 00:00:00', null, '', '2016-09-08 14:12:55', '2016-09-08 14:16:04', null, null, '380', '1');
INSERT INTO `by_member_detail_aud` VALUES ('127', null, null, null, null, null, null, '2016-09-08 14:31:05', null, null, null, '381', '0');
INSERT INTO `by_member_detail_aud` VALUES ('127', null, null, '9ef2989b6f7330b1964123816e48ffb9d8ac8af615e6a4c799c8b0392af50031', null, null, null, '2016-09-08 14:31:05', '2016-09-08 14:32:24', null, null, '382', '1');
INSERT INTO `by_member_detail_aud` VALUES ('127', '', '浦东新区张桥佳林路898弄9号502室', '9ef2989b6f7330b1964123816e48ffb9d8ac8af615e6a4c799c8b0392af50031', '1990-03-23 00:00:00', null, '310115199003234712', '2016-09-08 14:31:05', '2016-09-08 14:33:05', null, null, '383', '1');
INSERT INTO `by_member_detail_aud` VALUES ('128', null, null, null, null, null, null, '2016-09-08 14:34:42', null, null, null, '384', '0');
INSERT INTO `by_member_detail_aud` VALUES ('129', null, null, null, null, null, null, '2016-09-08 14:38:19', null, null, null, '385', '0');
INSERT INTO `by_member_detail_aud` VALUES ('130', null, null, null, null, null, null, '2016-09-08 14:39:17', null, null, null, '386', '0');
INSERT INTO `by_member_detail_aud` VALUES ('131', null, null, null, null, null, null, '2016-09-08 14:41:48', null, null, null, '387', '0');
INSERT INTO `by_member_detail_aud` VALUES ('132', null, null, null, null, null, null, '2016-09-08 14:55:54', null, null, null, '388', '0');
INSERT INTO `by_member_detail_aud` VALUES ('133', null, null, null, null, null, null, '2016-09-08 15:01:18', null, null, null, '389', '0');
INSERT INTO `by_member_detail_aud` VALUES ('134', null, null, null, null, null, null, '2016-09-08 15:01:39', null, null, null, '390', '0');
INSERT INTO `by_member_detail_aud` VALUES ('135', null, null, null, null, null, null, '2016-09-08 15:10:30', null, null, null, '391', '0');
INSERT INTO `by_member_detail_aud` VALUES ('136', null, null, null, null, null, null, '2016-09-08 15:18:40', null, null, null, '392', '0');
INSERT INTO `by_member_detail_aud` VALUES ('137', null, null, null, null, null, null, '2016-09-08 15:20:06', null, null, null, '393', '0');
INSERT INTO `by_member_detail_aud` VALUES ('138', null, null, null, null, null, null, '2016-09-08 15:35:07', null, null, null, '394', '0');
INSERT INTO `by_member_detail_aud` VALUES ('139', null, null, null, null, null, null, '2016-09-08 15:46:32', null, null, null, '395', '0');
INSERT INTO `by_member_detail_aud` VALUES ('139', '', '', null, '1984-08-26 00:00:00', null, '310110198408261050', '2016-09-08 15:46:32', '2016-09-08 15:47:59', null, null, '396', '1');
INSERT INTO `by_member_detail_aud` VALUES ('140', null, null, null, null, null, null, '2016-09-08 15:58:48', null, null, null, '397', '0');
INSERT INTO `by_member_detail_aud` VALUES ('140', '王依雯', '五莲路1424弄56号301室', null, '1995-08-31 00:00:00', null, '310115199508310629', '2016-09-08 15:58:48', '2016-09-08 15:59:32', null, null, '398', '1');
INSERT INTO `by_member_detail_aud` VALUES ('141', null, null, null, null, null, null, '2016-09-08 16:05:59', null, null, null, '399', '0');
INSERT INTO `by_member_detail_aud` VALUES ('141', null, null, '5f178b0e593617c7a0f10efa795c573550e7ba4c0cc28f2d4d5b6a148b34ced2', null, null, null, '2016-09-08 16:05:59', '2016-09-08 16:07:42', null, null, '400', '1');
INSERT INTO `by_member_detail_aud` VALUES ('141', '', '利津路185弄15号302', '5f178b0e593617c7a0f10efa795c573550e7ba4c0cc28f2d4d5b6a148b34ced2', '1986-07-31 23:00:00', null, '310115198608010637', '2016-09-08 16:05:59', '2016-09-08 16:08:10', null, null, '401', '1');
INSERT INTO `by_member_detail_aud` VALUES ('142', null, null, null, null, null, null, '2016-09-08 16:16:21', null, null, null, '402', '0');
INSERT INTO `by_member_detail_aud` VALUES ('142', '盛小姐', '', null, null, null, '', '2016-09-08 16:16:21', '2016-09-08 16:16:59', null, null, '403', '1');
INSERT INTO `by_member_detail_aud` VALUES ('143', null, null, null, null, null, null, '2016-09-08 16:34:29', null, null, null, '404', '0');
INSERT INTO `by_member_detail_aud` VALUES ('143', '顾蓓', '', null, '1989-03-16 00:00:00', null, '', '2016-09-08 16:34:29', '2016-09-08 16:35:03', null, null, '405', '1');
INSERT INTO `by_member_detail_aud` VALUES ('144', null, null, null, null, null, null, '2016-09-08 16:35:41', null, null, null, '406', '0');
INSERT INTO `by_member_detail_aud` VALUES ('145', null, null, null, null, null, null, '2016-09-08 17:04:12', null, null, null, '407', '0');
INSERT INTO `by_member_detail_aud` VALUES ('146', null, null, null, null, null, null, '2016-09-08 17:11:40', null, null, null, '408', '0');
INSERT INTO `by_member_detail_aud` VALUES ('147', null, null, null, null, null, null, '2016-09-08 17:13:02', null, null, null, '409', '0');
INSERT INTO `by_member_detail_aud` VALUES ('148', null, null, null, null, null, null, '2016-09-08 17:14:04', null, null, null, '410', '0');
INSERT INTO `by_member_detail_aud` VALUES ('148', null, null, 'e3eb89290275874c4ff4f005e24cbd920d74388f38d46f9a57957c9236b61f47', null, null, null, '2016-09-08 17:14:04', '2016-09-08 17:16:13', null, null, '411', '1');
INSERT INTO `by_member_detail_aud` VALUES ('148', '朱李华', '永建路86弄10号201室', 'e3eb89290275874c4ff4f005e24cbd920d74388f38d46f9a57957c9236b61f47', '1979-06-10 00:00:00', null, '310110197906103210', '2016-09-08 17:14:04', '2016-09-08 17:17:01', null, null, '412', '1');
INSERT INTO `by_member_detail_aud` VALUES ('149', null, null, null, null, null, null, '2016-09-08 17:24:23', null, null, null, '413', '0');
INSERT INTO `by_member_detail_aud` VALUES ('150', null, null, null, null, null, null, '2016-09-08 18:10:05', null, null, null, '414', '0');
INSERT INTO `by_member_detail_aud` VALUES ('151', null, null, null, null, null, null, '2016-09-08 18:15:45', null, null, null, '415', '0');
INSERT INTO `by_member_detail_aud` VALUES ('151', '金香淑', '金高路2131弄40号501室', null, '1982-10-01 00:00:00', null, '232330198210011425', '2016-09-08 18:15:45', '2016-09-08 18:17:13', null, null, '416', '1');
INSERT INTO `by_member_detail_aud` VALUES ('152', null, null, null, null, null, null, '2016-09-08 18:17:40', null, null, null, '417', '0');
INSERT INTO `by_member_detail_aud` VALUES ('153', null, null, null, null, null, null, '2016-09-08 18:17:49', null, null, null, '418', '0');
INSERT INTO `by_member_detail_aud` VALUES ('154', null, null, null, null, null, null, '2016-09-08 18:18:23', null, null, null, '419', '0');
INSERT INTO `by_member_detail_aud` VALUES ('155', null, null, null, null, null, null, '2016-09-08 18:24:01', null, null, null, '420', '0');
INSERT INTO `by_member_detail_aud` VALUES ('156', null, null, null, null, null, null, '2016-09-08 18:24:40', null, null, null, '421', '0');
INSERT INTO `by_member_detail_aud` VALUES ('156', null, null, '7b3c8938560dc3d4f606c87e03dfc24281b42905988fe2e0660d82ad79a8f469', null, null, null, '2016-09-08 18:24:40', '2016-09-08 18:33:06', null, null, '422', '1');
INSERT INTO `by_member_detail_aud` VALUES ('157', null, null, null, null, null, null, '2016-09-08 18:36:28', null, null, null, '423', '0');
INSERT INTO `by_member_detail_aud` VALUES ('157', '李名山', '永业路94-49-203', null, null, null, '', '2016-09-08 18:36:28', '2016-09-08 18:56:52', null, null, '425', '1');
INSERT INTO `by_member_detail_aud` VALUES ('158', null, null, null, null, null, null, '2016-09-08 18:42:19', null, null, null, '424', '0');
INSERT INTO `by_member_detail_aud` VALUES ('159', null, null, null, null, null, null, '2016-09-08 18:57:20', null, null, null, '426', '0');
INSERT INTO `by_member_detail_aud` VALUES ('160', null, null, null, null, null, null, '2016-09-08 19:02:15', null, null, null, '427', '0');
INSERT INTO `by_member_detail_aud` VALUES ('161', null, null, null, null, null, null, '2016-09-08 19:14:36', null, null, null, '428', '0');
INSERT INTO `by_member_detail_aud` VALUES ('162', null, null, null, null, null, null, '2016-09-08 19:28:10', null, null, null, '429', '0');
INSERT INTO `by_member_detail_aud` VALUES ('163', null, null, null, null, null, null, '2016-09-08 19:31:00', null, null, null, '430', '0');
INSERT INTO `by_member_detail_aud` VALUES ('164', null, null, null, null, null, null, '2016-09-08 19:36:55', null, null, null, '431', '0');
INSERT INTO `by_member_detail_aud` VALUES ('165', null, null, null, null, null, null, '2016-09-08 19:42:05', null, null, null, '432', '0');
INSERT INTO `by_member_detail_aud` VALUES ('165', null, null, 'b3bcaff3c8caf02450f268106324311b03e10ec9a908bdc4ab85e88f51b9be9b', null, null, null, '2016-09-08 19:42:05', '2016-09-08 21:31:52', null, null, '454', '1');
INSERT INTO `by_member_detail_aud` VALUES ('165', '', '上海市浦东新区金桥镇佳乐路255弄33号302室', 'b3bcaff3c8caf02450f268106324311b03e10ec9a908bdc4ab85e88f51b9be9b', '1986-01-02 00:00:00', null, '310115198601024710', '2016-09-08 19:42:05', '2016-09-08 21:32:58', null, null, '455', '1');
INSERT INTO `by_member_detail_aud` VALUES ('165', '', '上海市浦东新区金桥镇佳乐路255弄33号302室', 'd178b6518f6dbf7c9a78ff49b0acff8ab338bac59b086136a7eedecc9f4771f3', '1986-01-02 00:00:00', null, '310115198601024710', '2016-09-08 19:42:05', '2016-10-03 22:37:57', null, null, '1147', '1');
INSERT INTO `by_member_detail_aud` VALUES ('166', null, null, null, null, null, null, '2016-09-08 19:45:49', null, null, null, '433', '0');
INSERT INTO `by_member_detail_aud` VALUES ('167', null, null, null, null, null, null, '2016-09-08 19:45:53', null, null, null, '434', '0');
INSERT INTO `by_member_detail_aud` VALUES ('168', null, null, null, null, null, null, '2016-09-08 19:57:42', null, null, null, '435', '0');
INSERT INTO `by_member_detail_aud` VALUES ('168', '', '', null, null, null, '', '2016-09-08 19:57:42', '2016-09-08 19:58:20', null, null, '436', '1');
INSERT INTO `by_member_detail_aud` VALUES ('168', '', '', '287ebce8058132925807647969520ae65a1ef5f92a4516f625a9408501900745', null, null, '', '2016-09-08 19:57:42', '2016-09-29 20:25:57', null, null, '1096', '1');
INSERT INTO `by_member_detail_aud` VALUES ('168', '', '上海市浦东新区永宁路33 弄阳光城市家园6号601', '287ebce8058132925807647969520ae65a1ef5f92a4516f625a9408501900745', '1981-05-05 00:00:00', null, '321088198105056110', '2016-09-08 19:57:42', '2016-09-29 20:26:55', null, null, '1097', '1');
INSERT INTO `by_member_detail_aud` VALUES ('168', '庞长俊', '上海市浦东新区永宁路33 弄阳光城市家园6号601', '287ebce8058132925807647969520ae65a1ef5f92a4516f625a9408501900745', '1981-05-05 00:00:00', null, '321088198105056110', '2016-09-08 19:57:42', '2016-10-20 20:01:46', null, null, '1318', '1');
INSERT INTO `by_member_detail_aud` VALUES ('169', null, null, null, null, null, null, '2016-09-08 20:00:58', null, null, null, '437', '0');
INSERT INTO `by_member_detail_aud` VALUES ('170', null, null, null, null, null, null, '2016-09-08 20:02:39', null, null, null, '438', '0');
INSERT INTO `by_member_detail_aud` VALUES ('170', null, null, '40ce9480da8fe78cb773ca94a4c64e3f7513ca42c51d8f1e950a49004ad7ed11', null, null, null, '2016-09-08 20:02:39', '2016-09-08 20:03:56', null, null, '439', '1');
INSERT INTO `by_member_detail_aud` VALUES ('170', '', '', '40ce9480da8fe78cb773ca94a4c64e3f7513ca42c51d8f1e950a49004ad7ed11', null, null, '', '2016-09-08 20:02:39', '2016-09-08 20:04:05', null, null, '440', '1');
INSERT INTO `by_member_detail_aud` VALUES ('171', null, null, null, null, null, null, '2016-09-08 20:07:53', null, null, null, '443', '0');
INSERT INTO `by_member_detail_aud` VALUES ('172', null, null, null, null, null, null, '2016-09-08 20:11:40', null, null, null, '444', '0');
INSERT INTO `by_member_detail_aud` VALUES ('173', null, null, null, null, null, null, '2016-09-08 20:17:18', null, null, null, '445', '0');
INSERT INTO `by_member_detail_aud` VALUES ('174', null, null, null, null, null, null, '2016-09-08 20:37:32', null, null, null, '446', '0');
INSERT INTO `by_member_detail_aud` VALUES ('175', null, null, null, null, null, null, '2016-09-08 20:45:14', null, null, null, '447', '0');
INSERT INTO `by_member_detail_aud` VALUES ('176', null, null, null, null, null, null, '2016-09-08 20:57:23', null, null, null, '448', '0');
INSERT INTO `by_member_detail_aud` VALUES ('177', null, null, null, null, null, null, '2016-09-08 20:58:02', null, null, null, '449', '0');
INSERT INTO `by_member_detail_aud` VALUES ('178', null, null, null, null, null, null, '2016-09-08 21:03:22', null, null, null, '450', '0');
INSERT INTO `by_member_detail_aud` VALUES ('178', '', '', null, null, null, '', '2016-09-08 21:03:22', '2016-09-08 21:04:32', null, null, '451', '1');
INSERT INTO `by_member_detail_aud` VALUES ('179', null, null, null, null, null, null, '2016-09-08 21:15:24', null, null, null, '452', '0');
INSERT INTO `by_member_detail_aud` VALUES ('179', '', '', null, null, null, '', '2016-09-08 21:15:24', '2016-09-08 21:16:17', null, null, '453', '1');
INSERT INTO `by_member_detail_aud` VALUES ('180', null, null, null, null, null, null, '2016-09-08 21:35:05', null, null, null, '456', '0');
INSERT INTO `by_member_detail_aud` VALUES ('181', null, null, null, null, null, null, '2016-09-08 21:37:44', null, null, null, '457', '0');
INSERT INTO `by_member_detail_aud` VALUES ('182', null, null, null, null, null, null, '2016-09-08 21:40:24', null, null, null, '458', '0');
INSERT INTO `by_member_detail_aud` VALUES ('183', null, null, null, null, null, null, '2016-09-08 21:49:33', null, null, null, '459', '0');
INSERT INTO `by_member_detail_aud` VALUES ('183', null, null, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, null, null, '2016-09-08 21:49:33', '2016-09-08 21:54:03', null, null, '461', '1');
INSERT INTO `by_member_detail_aud` VALUES ('183', '', '', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, null, '', '2016-09-08 21:49:33', '2016-09-08 21:54:10', null, null, '462', '1');
INSERT INTO `by_member_detail_aud` VALUES ('184', null, null, null, null, null, null, '2016-09-08 21:52:47', null, null, null, '460', '0');
INSERT INTO `by_member_detail_aud` VALUES ('185', null, null, null, null, null, null, '2016-09-08 21:54:50', null, null, null, '463', '0');
INSERT INTO `by_member_detail_aud` VALUES ('186', null, null, null, null, null, null, '2016-09-08 21:55:51', null, null, null, '464', '0');
INSERT INTO `by_member_detail_aud` VALUES ('186', '', '佳林路838弄3号602室', null, null, null, '', '2016-09-08 21:55:51', '2016-09-08 21:56:32', null, null, '465', '1');
INSERT INTO `by_member_detail_aud` VALUES ('186', '', '佳林路838弄3号602室', null, '1986-12-01 00:00:00', null, '310230198612010495', '2016-09-08 21:55:51', '2016-09-08 21:56:56', null, null, '466', '1');
INSERT INTO `by_member_detail_aud` VALUES ('186', '杨威', '佳林路838弄3号602室', null, '1986-12-01 00:00:00', null, '310230198612010495', '2016-09-08 21:55:51', '2016-09-08 21:57:10', null, null, '467', '1');
INSERT INTO `by_member_detail_aud` VALUES ('187', null, null, null, null, null, null, '2016-09-08 21:59:38', null, null, null, '468', '0');
INSERT INTO `by_member_detail_aud` VALUES ('188', null, null, null, null, null, null, '2016-09-08 22:03:44', null, null, null, '469', '0');
INSERT INTO `by_member_detail_aud` VALUES ('188', '张艳璐', '', null, null, null, '', '2016-09-08 22:03:44', '2016-09-08 22:04:15', null, null, '470', '1');
INSERT INTO `by_member_detail_aud` VALUES ('189', null, null, null, null, null, null, '2016-09-08 22:24:54', null, null, null, '471', '0');
INSERT INTO `by_member_detail_aud` VALUES ('190', null, null, null, null, null, null, '2016-09-08 22:49:30', null, null, null, '472', '0');
INSERT INTO `by_member_detail_aud` VALUES ('191', null, null, null, null, null, null, '2016-09-08 22:52:22', null, null, null, '473', '0');
INSERT INTO `by_member_detail_aud` VALUES ('192', null, null, null, null, null, null, '2016-09-08 22:58:05', null, null, null, '474', '0');
INSERT INTO `by_member_detail_aud` VALUES ('192', '朱玲', '', null, '1986-10-26 00:00:00', null, '', '2016-09-08 22:58:05', '2016-09-08 22:58:57', null, null, '475', '1');
INSERT INTO `by_member_detail_aud` VALUES ('193', null, null, null, null, null, null, '2016-09-08 23:03:21', null, null, null, '476', '0');
INSERT INTO `by_member_detail_aud` VALUES ('194', null, null, null, null, null, null, '2016-09-08 23:08:28', null, null, null, '477', '0');
INSERT INTO `by_member_detail_aud` VALUES ('195', null, null, null, null, null, null, '2016-09-08 23:11:04', null, null, null, '478', '0');
INSERT INTO `by_member_detail_aud` VALUES ('196', null, null, null, null, null, null, '2016-09-08 23:41:57', null, null, null, '479', '0');
INSERT INTO `by_member_detail_aud` VALUES ('197', null, null, null, null, null, null, '2016-09-09 00:26:24', null, null, null, '480', '0');
INSERT INTO `by_member_detail_aud` VALUES ('198', null, null, null, null, null, null, '2016-09-09 01:44:21', null, null, null, '481', '0');
INSERT INTO `by_member_detail_aud` VALUES ('198', '张瑾', '', null, '1982-08-15 00:00:00', null, '', '2016-09-09 01:44:21', '2016-09-09 01:45:03', null, null, '482', '1');
INSERT INTO `by_member_detail_aud` VALUES ('198', '张瑾', '', 'd3fe9f4ff3a147e4f0c95a939007a6668c0a5ba95a9ece03d7f3acbce562d03c', '1982-08-15 00:00:00', null, '', '2016-09-09 01:44:21', '2016-09-29 13:26:16', null, null, '1081', '1');
INSERT INTO `by_member_detail_aud` VALUES ('199', null, null, null, null, null, null, '2016-09-09 02:51:29', null, null, null, '483', '0');
INSERT INTO `by_member_detail_aud` VALUES ('200', null, null, null, null, null, null, '2016-09-09 06:29:25', null, null, null, '484', '0');
INSERT INTO `by_member_detail_aud` VALUES ('201', null, null, null, null, null, null, '2016-09-09 06:49:14', null, null, null, '485', '0');
INSERT INTO `by_member_detail_aud` VALUES ('201', '顾晓青', '', null, '1986-03-16 00:00:00', null, '', '2016-09-09 06:49:14', '2016-09-09 06:49:57', null, null, '486', '1');
INSERT INTO `by_member_detail_aud` VALUES ('202', null, null, null, null, null, null, '2016-09-09 07:03:38', null, null, null, '487', '0');
INSERT INTO `by_member_detail_aud` VALUES ('203', null, null, null, null, null, null, '2016-09-09 07:13:30', null, null, null, '488', '0');
INSERT INTO `by_member_detail_aud` VALUES ('204', null, null, null, null, null, null, '2016-09-09 07:16:07', null, null, null, '489', '0');
INSERT INTO `by_member_detail_aud` VALUES ('204', '张先生', '', null, '2016-09-09 00:00:00', null, '', '2016-09-09 07:16:07', '2016-09-09 07:17:23', null, null, '490', '1');
INSERT INTO `by_member_detail_aud` VALUES ('205', null, null, null, null, null, null, '2016-09-09 07:20:35', null, null, null, '491', '0');
INSERT INTO `by_member_detail_aud` VALUES ('206', null, null, null, null, null, null, '2016-09-09 07:41:09', null, null, null, '492', '0');
INSERT INTO `by_member_detail_aud` VALUES ('207', null, null, null, null, null, null, '2016-09-09 07:45:34', null, null, null, '493', '0');
INSERT INTO `by_member_detail_aud` VALUES ('208', null, null, null, null, null, null, '2016-09-09 08:19:34', null, null, null, '494', '0');
INSERT INTO `by_member_detail_aud` VALUES ('209', null, null, null, null, null, null, '2016-09-09 09:07:57', null, null, null, '495', '0');
INSERT INTO `by_member_detail_aud` VALUES ('209', 'chloe', '', null, null, null, '', '2016-09-09 09:07:57', '2016-09-09 09:08:33', null, null, '496', '1');
INSERT INTO `by_member_detail_aud` VALUES ('210', null, null, null, null, null, null, '2016-09-09 09:41:46', null, null, null, '497', '0');
INSERT INTO `by_member_detail_aud` VALUES ('211', null, null, null, null, null, null, '2016-09-09 09:43:36', null, null, null, '498', '0');
INSERT INTO `by_member_detail_aud` VALUES ('211', null, null, 'a9c7768dbdc178297de29dee1f78367e2e85a89861ce31fdb51c8a13cd477cdf', null, null, null, '2016-09-09 09:43:36', '2016-09-09 09:45:26', null, null, '499', '1');
INSERT INTO `by_member_detail_aud` VALUES ('211', '', '上海市浦东新区东波路192弄12号502室', 'a9c7768dbdc178297de29dee1f78367e2e85a89861ce31fdb51c8a13cd477cdf', '1979-07-31 00:00:00', null, '310115197907314724', '2016-09-09 09:43:36', '2016-09-09 09:46:13', null, null, '500', '1');
INSERT INTO `by_member_detail_aud` VALUES ('212', null, null, null, null, null, null, '2016-09-09 09:49:12', null, null, null, '501', '0');
INSERT INTO `by_member_detail_aud` VALUES ('213', null, null, null, null, null, null, '2016-09-09 10:02:42', null, null, null, '502', '0');
INSERT INTO `by_member_detail_aud` VALUES ('214', null, null, null, null, null, null, '2016-09-09 10:04:42', null, null, null, '503', '0');
INSERT INTO `by_member_detail_aud` VALUES ('215', null, null, null, null, null, null, '2016-09-09 10:11:51', null, null, null, '504', '0');
INSERT INTO `by_member_detail_aud` VALUES ('215', null, null, '4bfa06253c49b63f1b3872acd5d5c9e8dc682e1016e79bc2e1543c8771adef26', null, null, null, '2016-09-09 10:11:51', '2016-09-09 10:13:03', null, null, '505', '1');
INSERT INTO `by_member_detail_aud` VALUES ('215', '', '', '4bfa06253c49b63f1b3872acd5d5c9e8dc682e1016e79bc2e1543c8771adef26', '1992-05-19 00:00:00', null, '310115199205194712', '2016-09-09 10:11:51', '2016-09-09 10:13:14', null, null, '506', '1');
INSERT INTO `by_member_detail_aud` VALUES ('216', null, null, null, null, null, null, '2016-09-09 11:13:04', null, null, null, '507', '0');
INSERT INTO `by_member_detail_aud` VALUES ('216', '陈效忠', '佳林路', null, '1981-07-27 00:00:00', null, '', '2016-09-09 11:13:04', '2016-09-09 11:14:33', null, null, '508', '1');
INSERT INTO `by_member_detail_aud` VALUES ('217', null, null, null, null, null, null, '2016-09-09 11:18:46', null, null, null, '509', '0');
INSERT INTO `by_member_detail_aud` VALUES ('218', null, null, null, null, null, null, '2016-09-09 11:21:44', null, null, null, '510', '0');
INSERT INTO `by_member_detail_aud` VALUES ('219', null, null, null, null, null, null, '2016-09-09 11:23:17', null, null, null, '511', '0');
INSERT INTO `by_member_detail_aud` VALUES ('220', null, null, null, null, null, null, '2016-09-09 11:31:16', null, null, null, '512', '0');
INSERT INTO `by_member_detail_aud` VALUES ('221', null, null, null, null, null, null, '2016-09-09 11:42:30', null, null, null, '513', '0');
INSERT INTO `by_member_detail_aud` VALUES ('222', null, null, null, null, null, null, '2016-09-09 11:52:37', null, null, null, '514', '0');
INSERT INTO `by_member_detail_aud` VALUES ('223', null, null, null, null, null, null, '2016-09-09 12:11:17', null, null, null, '515', '0');
INSERT INTO `by_member_detail_aud` VALUES ('223', '李君', '', null, '1981-08-11 00:00:00', null, '', '2016-09-09 12:11:17', '2016-09-09 12:12:19', null, null, '516', '1');
INSERT INTO `by_member_detail_aud` VALUES ('224', null, null, null, null, null, null, '2016-09-09 12:19:25', null, null, null, '517', '0');
INSERT INTO `by_member_detail_aud` VALUES ('225', null, null, null, null, null, null, '2016-09-09 12:27:48', null, null, null, '518', '0');
INSERT INTO `by_member_detail_aud` VALUES ('226', null, null, null, null, null, null, '2016-09-09 12:31:35', null, null, null, '519', '0');
INSERT INTO `by_member_detail_aud` VALUES ('226', '胡', '', null, null, null, '', '2016-09-09 12:31:35', '2016-09-09 12:31:59', null, null, '520', '1');
INSERT INTO `by_member_detail_aud` VALUES ('227', null, null, null, null, null, null, '2016-09-09 14:04:58', null, null, null, '521', '0');
INSERT INTO `by_member_detail_aud` VALUES ('227', '邱少庆', '', null, null, null, '', '2016-09-09 14:04:58', '2016-09-09 14:05:34', null, null, '522', '1');
INSERT INTO `by_member_detail_aud` VALUES ('228', null, null, null, null, null, null, '2016-09-09 14:20:21', null, null, null, '523', '0');
INSERT INTO `by_member_detail_aud` VALUES ('228', '金滢', '', null, '1986-09-07 23:00:00', null, '', '2016-09-09 14:20:21', '2016-09-09 14:20:57', null, null, '524', '1');
INSERT INTO `by_member_detail_aud` VALUES ('229', null, null, null, null, null, null, '2016-09-09 14:34:55', null, null, null, '525', '0');
INSERT INTO `by_member_detail_aud` VALUES ('230', null, null, null, null, null, null, '2016-09-09 15:08:36', null, null, null, '526', '0');
INSERT INTO `by_member_detail_aud` VALUES ('231', null, null, null, null, null, null, '2016-09-09 15:47:30', null, null, null, '527', '0');
INSERT INTO `by_member_detail_aud` VALUES ('232', null, null, null, null, null, null, '2016-09-09 15:53:58', null, null, null, '528', '0');
INSERT INTO `by_member_detail_aud` VALUES ('233', null, null, null, null, null, null, '2016-09-09 16:53:58', null, null, null, '529', '0');
INSERT INTO `by_member_detail_aud` VALUES ('233', null, null, 'e92b23d39e4703b0c1d74c5828939f5b1189f8303a9d90bdc5dd669f77af2ade', null, null, null, '2016-09-09 16:53:58', '2016-09-09 16:56:59', null, null, '530', '1');
INSERT INTO `by_member_detail_aud` VALUES ('234', null, null, null, null, null, null, '2016-09-09 17:15:43', null, null, null, '531', '0');
INSERT INTO `by_member_detail_aud` VALUES ('234', '朱', '', null, '2016-10-13 00:00:00', null, '', '2016-09-09 17:15:43', '2016-09-09 17:16:31', null, null, '532', '1');
INSERT INTO `by_member_detail_aud` VALUES ('235', null, null, null, null, null, null, '2016-09-09 17:59:00', null, null, null, '533', '0');
INSERT INTO `by_member_detail_aud` VALUES ('236', null, null, null, null, null, null, '2016-09-09 18:45:29', null, null, null, '534', '0');
INSERT INTO `by_member_detail_aud` VALUES ('237', null, null, null, null, null, null, '2016-09-09 19:01:30', null, null, null, '535', '0');
INSERT INTO `by_member_detail_aud` VALUES ('238', null, null, null, null, null, null, '2016-09-09 19:16:59', null, null, null, '536', '0');
INSERT INTO `by_member_detail_aud` VALUES ('239', null, null, null, null, null, null, '2016-09-09 19:34:29', null, null, null, '537', '0');
INSERT INTO `by_member_detail_aud` VALUES ('240', null, null, null, null, null, null, '2016-09-09 19:39:37', null, null, null, '538', '0');
INSERT INTO `by_member_detail_aud` VALUES ('241', null, null, null, null, null, null, '2016-09-09 19:49:42', null, null, null, '539', '0');
INSERT INTO `by_member_detail_aud` VALUES ('241', '陆秀梅', '', null, '1980-01-06 00:00:00', null, '', '2016-09-09 19:49:42', '2016-09-11 21:35:00', null, null, '728', '1');
INSERT INTO `by_member_detail_aud` VALUES ('242', null, null, null, null, null, null, '2016-09-09 19:54:46', null, null, null, '540', '0');
INSERT INTO `by_member_detail_aud` VALUES ('243', null, null, null, null, null, null, '2016-09-09 19:56:01', null, null, null, '541', '0');
INSERT INTO `by_member_detail_aud` VALUES ('244', null, null, null, null, null, null, '2016-09-09 20:26:42', null, null, null, '542', '0');
INSERT INTO `by_member_detail_aud` VALUES ('245', null, null, null, null, null, null, '2016-09-09 20:43:37', null, null, null, '543', '0');
INSERT INTO `by_member_detail_aud` VALUES ('246', null, null, null, null, null, null, '2016-09-09 21:42:33', null, null, null, '544', '0');
INSERT INTO `by_member_detail_aud` VALUES ('246', '丁吟萍', '', null, '1989-07-07 23:00:00', null, '', '2016-09-09 21:42:33', '2016-09-09 21:43:27', null, null, '545', '1');
INSERT INTO `by_member_detail_aud` VALUES ('247', null, null, null, null, null, null, '2016-09-09 22:06:07', null, null, null, '546', '0');
INSERT INTO `by_member_detail_aud` VALUES ('248', null, null, null, null, null, null, '2016-09-09 22:23:51', null, null, null, '547', '0');
INSERT INTO `by_member_detail_aud` VALUES ('249', null, null, null, null, null, null, '2016-09-10 07:38:37', null, null, null, '548', '0');
INSERT INTO `by_member_detail_aud` VALUES ('250', null, null, null, null, null, null, '2016-09-10 08:24:59', null, null, null, '549', '0');
INSERT INTO `by_member_detail_aud` VALUES ('250', '杨梓', '', null, null, null, '', '2016-09-10 08:24:59', '2016-09-10 08:25:49', null, null, '550', '1');
INSERT INTO `by_member_detail_aud` VALUES ('251', null, null, null, null, null, null, '2016-09-10 08:48:05', null, null, null, '551', '0');
INSERT INTO `by_member_detail_aud` VALUES ('252', null, null, null, null, null, null, '2016-09-10 09:38:52', null, null, null, '552', '0');
INSERT INTO `by_member_detail_aud` VALUES ('253', null, null, null, null, null, null, '2016-09-10 09:59:19', null, null, null, '553', '0');
INSERT INTO `by_member_detail_aud` VALUES ('253', null, null, '164bf85834f775962e40a38f8dd4910ac018d2df54b5c2601234463e33338a27', null, null, null, '2016-09-10 09:59:19', '2016-09-10 10:00:13', null, null, '554', '1');
INSERT INTO `by_member_detail_aud` VALUES ('253', '', '永业路佳虹路42弄', '164bf85834f775962e40a38f8dd4910ac018d2df54b5c2601234463e33338a27', '1995-07-11 00:00:00', null, '310230199507110456', '2016-09-10 09:59:19', '2016-09-10 10:00:38', null, null, '555', '1');
INSERT INTO `by_member_detail_aud` VALUES ('254', null, null, null, null, null, null, '2016-09-10 11:07:29', null, null, null, '556', '0');
INSERT INTO `by_member_detail_aud` VALUES ('255', null, null, null, null, null, null, '2016-09-10 11:39:04', null, null, null, '557', '0');
INSERT INTO `by_member_detail_aud` VALUES ('256', null, null, null, null, null, null, '2016-09-10 12:07:56', null, null, null, '558', '0');
INSERT INTO `by_member_detail_aud` VALUES ('256', null, null, '801bf68484a00122336f0e5d8b3bac6e58abb5e3f91885f2b3a601f4c07fbf0c', null, null, null, '2016-09-10 12:07:56', '2016-09-10 12:09:13', null, null, '559', '1');
INSERT INTO `by_member_detail_aud` VALUES ('256', '', '上海市浦东新区佳虹路50弄17号501室', '801bf68484a00122336f0e5d8b3bac6e58abb5e3f91885f2b3a601f4c07fbf0c', '1978-06-14 00:00:00', null, '510902197806149730', '2016-09-10 12:07:56', '2016-09-10 12:10:03', null, null, '560', '1');
INSERT INTO `by_member_detail_aud` VALUES ('257', null, null, null, null, null, null, '2016-09-10 12:19:35', null, null, null, '561', '0');
INSERT INTO `by_member_detail_aud` VALUES ('257', '', '', null, null, null, '', '2016-09-10 12:19:35', '2016-09-10 12:20:10', null, null, '562', '1');
INSERT INTO `by_member_detail_aud` VALUES ('257', '', '', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, null, '', '2016-09-10 12:19:35', '2016-09-10 12:22:56', null, null, '563', '1');
INSERT INTO `by_member_detail_aud` VALUES ('257', '', '金高路2131弄31号101', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1983-06-13 00:00:00', null, '310109198306131532', '2016-09-10 12:19:35', '2016-09-10 12:23:23', null, null, '564', '1');
INSERT INTO `by_member_detail_aud` VALUES ('257', '沙俊峰', '金高路2131弄31号101', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1983-06-13 00:00:00', null, '310109198306131532', '2016-09-10 12:19:35', '2016-09-10 12:23:45', null, null, '565', '1');
INSERT INTO `by_member_detail_aud` VALUES ('258', null, null, null, null, null, null, '2016-09-10 12:44:48', null, null, null, '566', '0');
INSERT INTO `by_member_detail_aud` VALUES ('259', null, null, null, null, null, null, '2016-09-10 13:28:48', null, null, null, '567', '0');
INSERT INTO `by_member_detail_aud` VALUES ('260', null, null, null, null, null, null, '2016-09-10 13:50:19', null, null, null, '568', '0');
INSERT INTO `by_member_detail_aud` VALUES ('261', null, null, null, null, null, null, '2016-09-10 14:21:50', null, null, null, '569', '0');
INSERT INTO `by_member_detail_aud` VALUES ('261', null, null, 'f51f2c2131d0fd27fc5a81e6f1b51a95df34a7d63fa5cc100b07da01ec970367', null, null, null, '2016-09-10 14:21:50', '2016-09-10 14:23:11', null, null, '570', '1');
INSERT INTO `by_member_detail_aud` VALUES ('261', '', '', 'f51f2c2131d0fd27fc5a81e6f1b51a95df34a7d63fa5cc100b07da01ec970367', null, null, '', '2016-09-10 14:21:50', '2016-09-10 14:23:29', null, null, '571', '1');
INSERT INTO `by_member_detail_aud` VALUES ('262', null, null, null, null, null, null, '2016-09-10 14:37:56', null, null, null, '572', '0');
INSERT INTO `by_member_detail_aud` VALUES ('263', null, null, null, null, null, null, '2016-09-10 14:38:58', null, null, null, '573', '0');
INSERT INTO `by_member_detail_aud` VALUES ('264', null, null, null, null, null, null, '2016-09-10 14:46:10', null, null, null, '574', '0');
INSERT INTO `by_member_detail_aud` VALUES ('265', null, null, null, null, null, null, '2016-09-10 14:59:23', null, null, null, '575', '0');
INSERT INTO `by_member_detail_aud` VALUES ('265', null, null, '68c881e55fa6a881d769298b18c2eda7170bbcdf61fb529c37250ebe5026a9c1', null, null, null, '2016-09-10 14:59:23', '2016-09-10 15:00:53', null, null, '576', '1');
INSERT INTO `by_member_detail_aud` VALUES ('266', null, null, null, null, null, null, '2016-09-10 15:50:05', null, null, null, '577', '0');
INSERT INTO `by_member_detail_aud` VALUES ('266', '浦素平', '', null, null, null, '', '2016-09-10 15:50:05', '2016-09-10 15:50:51', null, null, '578', '1');
INSERT INTO `by_member_detail_aud` VALUES ('267', null, null, null, null, null, null, '2016-09-10 16:14:06', null, null, null, '579', '0');
INSERT INTO `by_member_detail_aud` VALUES ('267', null, null, '1faaad5d381a89f375cce6a9e0d659c1100b3ffcabf5d9c4205be97e9bfbd654', null, null, null, '2016-09-10 16:14:06', '2016-09-10 16:15:18', null, null, '580', '1');
INSERT INTO `by_member_detail_aud` VALUES ('267', '', '', '1faaad5d381a89f375cce6a9e0d659c1100b3ffcabf5d9c4205be97e9bfbd654', null, null, '', '2016-09-10 16:14:06', '2016-09-10 16:15:31', null, null, '581', '1');
INSERT INTO `by_member_detail_aud` VALUES ('268', null, null, null, null, null, null, '2016-09-10 16:20:59', null, null, null, '582', '0');
INSERT INTO `by_member_detail_aud` VALUES ('269', null, null, null, null, null, null, '2016-09-10 16:27:13', null, null, null, '583', '0');
INSERT INTO `by_member_detail_aud` VALUES ('270', null, null, null, null, null, null, '2016-09-10 16:39:22', null, null, null, '584', '0');
INSERT INTO `by_member_detail_aud` VALUES ('271', null, null, null, null, null, null, '2016-09-10 16:42:28', null, null, null, '585', '0');
INSERT INTO `by_member_detail_aud` VALUES ('271', '周骏杰', '', null, '1978-10-20 00:00:00', null, '', '2016-09-10 16:42:28', '2016-09-10 16:43:07', null, null, '586', '1');
INSERT INTO `by_member_detail_aud` VALUES ('272', null, null, null, null, null, null, '2016-09-10 17:02:09', null, null, null, '587', '0');
INSERT INTO `by_member_detail_aud` VALUES ('273', null, null, null, null, null, null, '2016-09-10 17:03:16', null, null, null, '588', '0');
INSERT INTO `by_member_detail_aud` VALUES ('274', null, null, null, null, null, null, '2016-09-10 17:03:37', null, null, null, '589', '0');
INSERT INTO `by_member_detail_aud` VALUES ('274', '刘先生', '', null, null, null, '', '2016-09-10 17:03:37', '2016-09-10 17:04:01', null, null, '590', '1');
INSERT INTO `by_member_detail_aud` VALUES ('275', null, null, null, null, null, null, '2016-09-10 17:36:50', null, null, null, '591', '0');
INSERT INTO `by_member_detail_aud` VALUES ('276', null, null, null, null, null, null, '2016-09-10 18:07:31', null, null, null, '592', '0');
INSERT INTO `by_member_detail_aud` VALUES ('277', null, null, null, null, null, null, '2016-09-10 18:45:57', null, null, null, '593', '0');
INSERT INTO `by_member_detail_aud` VALUES ('278', null, null, null, null, null, null, '2016-09-10 18:54:32', null, null, null, '594', '0');
INSERT INTO `by_member_detail_aud` VALUES ('279', null, null, null, null, null, null, '2016-09-10 19:16:11', null, null, null, '595', '0');
INSERT INTO `by_member_detail_aud` VALUES ('280', null, null, null, null, null, null, '2016-09-10 19:17:11', null, null, null, '596', '0');
INSERT INTO `by_member_detail_aud` VALUES ('281', null, null, null, null, null, null, '2016-09-10 19:42:22', null, null, null, '597', '0');
INSERT INTO `by_member_detail_aud` VALUES ('282', null, null, null, null, null, null, '2016-09-10 19:49:53', null, null, null, '598', '0');
INSERT INTO `by_member_detail_aud` VALUES ('282', null, null, 'e303fd70c1cd3558f0ea2bd8ee3011137b75b0a351ddbb7e72e2514c9353f674', null, null, null, '2016-09-10 19:49:53', '2016-09-10 19:54:16', null, null, '599', '1');
INSERT INTO `by_member_detail_aud` VALUES ('283', null, null, null, null, null, null, '2016-09-10 20:10:51', null, null, null, '600', '0');
INSERT INTO `by_member_detail_aud` VALUES ('284', null, null, null, null, null, null, '2016-09-10 20:13:18', null, null, null, '601', '0');
INSERT INTO `by_member_detail_aud` VALUES ('285', null, null, null, null, null, null, '2016-09-10 20:25:38', null, null, null, '602', '0');
INSERT INTO `by_member_detail_aud` VALUES ('285', '', '', null, '1977-11-05 00:00:00', null, '', '2016-09-10 20:25:38', '2016-09-10 20:27:15', null, null, '603', '1');
INSERT INTO `by_member_detail_aud` VALUES ('286', null, null, null, null, null, null, '2016-09-10 20:31:43', null, null, null, '604', '0');
INSERT INTO `by_member_detail_aud` VALUES ('287', null, null, null, null, null, null, '2016-09-10 20:34:43', null, null, null, '605', '0');
INSERT INTO `by_member_detail_aud` VALUES ('288', null, null, null, null, null, null, '2016-09-10 21:15:56', null, null, null, '606', '0');
INSERT INTO `by_member_detail_aud` VALUES ('289', null, null, null, null, null, null, '2016-09-10 21:41:15', null, null, null, '607', '0');
INSERT INTO `by_member_detail_aud` VALUES ('290', null, null, null, null, null, null, '2016-09-10 21:46:13', null, null, null, '608', '0');
INSERT INTO `by_member_detail_aud` VALUES ('291', null, null, null, null, null, null, '2016-09-10 22:17:47', null, null, null, '609', '0');
INSERT INTO `by_member_detail_aud` VALUES ('291', '冯华', '', null, '1977-02-10 00:00:00', null, '', '2016-09-10 22:17:47', '2016-09-10 22:18:32', null, null, '610', '1');
INSERT INTO `by_member_detail_aud` VALUES ('292', null, null, null, null, null, null, '2016-09-10 22:20:56', null, null, null, '611', '0');
INSERT INTO `by_member_detail_aud` VALUES ('293', null, null, null, null, null, null, '2016-09-10 22:31:06', null, null, null, '612', '0');
INSERT INTO `by_member_detail_aud` VALUES ('294', null, null, null, null, null, null, '2016-09-10 22:31:35', null, null, null, '613', '0');
INSERT INTO `by_member_detail_aud` VALUES ('294', '管宇清', '', null, null, null, '', '2016-09-10 22:31:35', '2016-10-28 10:26:40', null, null, '1380', '1');
INSERT INTO `by_member_detail_aud` VALUES ('295', null, null, null, null, null, null, '2016-09-11 00:47:11', null, null, null, '614', '0');
INSERT INTO `by_member_detail_aud` VALUES ('295', null, null, 'ae7f075ed0a8a9784f176053c4badd747f19b3cb3eadc5cd5b10d75005b29e38', null, null, null, '2016-09-11 00:47:11', '2016-09-11 00:49:13', null, null, '615', '1');
INSERT INTO `by_member_detail_aud` VALUES ('295', '', '浦东新区金高路2131弄41号1101室', 'ae7f075ed0a8a9784f176053c4badd747f19b3cb3eadc5cd5b10d75005b29e38', '1974-12-30 00:00:00', null, '310110197412302025', '2016-09-11 00:47:11', '2016-09-11 00:50:12', null, null, '616', '1');
INSERT INTO `by_member_detail_aud` VALUES ('296', null, null, null, null, null, null, '2016-09-11 08:22:01', null, null, null, '617', '0');
INSERT INTO `by_member_detail_aud` VALUES ('296', '', '永宁路33弄3号601室', null, '1976-06-21 00:00:00', null, '', '2016-09-11 08:22:01', '2016-09-11 08:24:10', null, null, '618', '1');
INSERT INTO `by_member_detail_aud` VALUES ('296', 'jojo', '永宁路33弄3号601室', null, '1976-06-21 00:00:00', null, '', '2016-09-11 08:22:01', '2016-09-14 20:34:46', null, null, '871', '1');
INSERT INTO `by_member_detail_aud` VALUES ('296', 'jojo', '永宁路33弄3号601室', '9a8b134bbc43a21cf7eeec85c35f87c967a959cea3ede98caed2a3e3ec845194', '1976-06-21 00:00:00', null, '', '2016-09-11 08:22:01', '2016-09-14 20:37:59', null, null, '872', '1');
INSERT INTO `by_member_detail_aud` VALUES ('297', null, null, null, null, null, null, '2016-09-11 08:59:09', null, null, null, '619', '0');
INSERT INTO `by_member_detail_aud` VALUES ('298', null, null, null, null, null, null, '2016-09-11 09:27:57', null, null, null, '620', '0');
INSERT INTO `by_member_detail_aud` VALUES ('299', null, null, null, null, null, null, '2016-09-11 09:54:24', null, null, null, '621', '0');
INSERT INTO `by_member_detail_aud` VALUES ('299', '弓元植', '永业路218弄5号501', null, '1980-12-12 00:00:00', null, '239005198012123614', '2016-09-11 09:54:24', '2016-09-11 09:55:09', null, null, '622', '1');
INSERT INTO `by_member_detail_aud` VALUES ('300', null, null, null, null, null, null, '2016-09-11 09:57:17', null, null, null, '623', '0');
INSERT INTO `by_member_detail_aud` VALUES ('301', null, null, null, null, null, null, '2016-09-11 10:56:24', null, null, null, '624', '0');
INSERT INTO `by_member_detail_aud` VALUES ('302', null, null, null, null, null, null, '2016-09-11 11:36:55', null, null, null, '625', '0');
INSERT INTO `by_member_detail_aud` VALUES ('303', null, null, null, null, null, null, '2016-09-11 11:47:08', null, null, null, '626', '0');
INSERT INTO `by_member_detail_aud` VALUES ('304', null, null, null, null, null, null, '2016-09-11 11:56:42', null, null, null, '627', '0');
INSERT INTO `by_member_detail_aud` VALUES ('305', null, null, null, null, null, null, '2016-09-11 12:04:29', null, null, null, '628', '0');
INSERT INTO `by_member_detail_aud` VALUES ('306', null, null, null, null, null, null, '2016-09-11 12:28:37', null, null, null, '629', '0');
INSERT INTO `by_member_detail_aud` VALUES ('306', '周军', '', null, null, null, '', '2016-09-11 12:28:37', '2016-09-11 12:29:09', null, null, '630', '1');
INSERT INTO `by_member_detail_aud` VALUES ('307', null, null, null, null, null, null, '2016-09-11 12:30:48', null, null, null, '631', '0');
INSERT INTO `by_member_detail_aud` VALUES ('307', '魏文敏', '', null, '1991-09-08 23:00:00', null, '', '2016-09-11 12:30:48', '2016-09-11 12:31:42', null, null, '632', '1');
INSERT INTO `by_member_detail_aud` VALUES ('308', null, null, null, null, null, null, '2016-09-11 13:03:27', null, null, null, '633', '0');
INSERT INTO `by_member_detail_aud` VALUES ('309', null, null, null, null, null, null, '2016-09-11 13:10:38', null, null, null, '634', '0');
INSERT INTO `by_member_detail_aud` VALUES ('310', null, null, null, null, null, null, '2016-09-11 14:12:00', null, null, null, '635', '0');
INSERT INTO `by_member_detail_aud` VALUES ('310', null, null, '3331cf8f9c61d50160a9421af6282fdae8688e895035a5e8aa6708245f30a898', null, null, null, '2016-09-11 14:12:00', '2016-09-11 14:13:27', null, null, '636', '1');
INSERT INTO `by_member_detail_aud` VALUES ('310', '', '上海市浦东新区东陆路1182弄19号402室', '3331cf8f9c61d50160a9421af6282fdae8688e895035a5e8aa6708245f30a898', '1984-07-24 00:00:00', null, '310115198407240436', '2016-09-11 14:12:00', '2016-09-11 14:14:30', null, null, '638', '1');
INSERT INTO `by_member_detail_aud` VALUES ('310', '潘尧', '上海市浦东新区东陆路1182弄19号402室', '3331cf8f9c61d50160a9421af6282fdae8688e895035a5e8aa6708245f30a898', '1984-07-24 00:00:00', null, '310115198407240436', '2016-09-11 14:12:00', '2016-10-05 12:29:40', null, null, '1168', '1');
INSERT INTO `by_member_detail_aud` VALUES ('311', null, null, null, null, null, null, '2016-09-11 14:13:52', null, null, null, '637', '0');
INSERT INTO `by_member_detail_aud` VALUES ('312', null, null, null, null, null, null, '2016-09-11 14:27:34', null, null, null, '639', '0');
INSERT INTO `by_member_detail_aud` VALUES ('312', null, null, '534a2521232c38461aecc004aac4b3c5f3ca982636ca188402160ea45b0ed21d', null, null, null, '2016-09-11 14:27:34', '2016-09-11 14:28:32', null, null, '640', '1');
INSERT INTO `by_member_detail_aud` VALUES ('312', '', '', '534a2521232c38461aecc004aac4b3c5f3ca982636ca188402160ea45b0ed21d', null, null, '', '2016-09-11 14:27:34', '2016-09-11 14:28:39', null, null, '641', '1');
INSERT INTO `by_member_detail_aud` VALUES ('313', null, null, null, null, null, null, '2016-09-11 14:28:56', null, null, null, '642', '0');
INSERT INTO `by_member_detail_aud` VALUES ('314', null, null, null, null, null, null, '2016-09-11 15:24:55', null, null, null, '643', '0');
INSERT INTO `by_member_detail_aud` VALUES ('315', null, null, null, null, null, null, '2016-09-11 15:36:09', null, null, null, '644', '0');
INSERT INTO `by_member_detail_aud` VALUES ('316', null, null, null, null, null, null, '2016-09-11 16:29:21', null, null, null, '645', '0');
INSERT INTO `by_member_detail_aud` VALUES ('317', null, null, null, null, null, null, '2016-09-11 16:58:40', null, null, null, '646', '0');
INSERT INTO `by_member_detail_aud` VALUES ('317', '张旭', '', null, '1984-12-25 00:00:00', null, '', '2016-09-11 16:58:40', '2016-09-11 16:59:36', null, null, '647', '1');
INSERT INTO `by_member_detail_aud` VALUES ('317', '张旭', '', 'b4676c32adce99208cce914e339ddbf69a3f3246dd977967331b663347cbb943', '1984-12-25 00:00:00', null, '', '2016-09-11 16:58:40', '2016-09-11 17:00:55', null, null, '648', '1');
INSERT INTO `by_member_detail_aud` VALUES ('318', null, null, null, null, null, null, '2016-09-11 17:04:44', null, null, null, '649', '0');
INSERT INTO `by_member_detail_aud` VALUES ('318', '孙怡', '', null, null, null, '', '2016-09-11 17:04:44', '2016-09-11 17:05:04', null, null, '650', '1');
INSERT INTO `by_member_detail_aud` VALUES ('319', null, null, null, null, null, null, '2016-09-11 17:50:54', null, null, null, '651', '0');
INSERT INTO `by_member_detail_aud` VALUES ('320', null, null, null, null, null, null, '2016-09-11 18:02:56', null, null, null, '652', '0');
INSERT INTO `by_member_detail_aud` VALUES ('321', null, null, null, null, null, null, '2016-09-11 18:30:09', null, null, null, '653', '0');
INSERT INTO `by_member_detail_aud` VALUES ('321', '', '', null, '1977-01-22 00:00:00', null, '', '2016-09-11 18:30:09', '2016-09-11 18:30:53', null, null, '654', '1');
INSERT INTO `by_member_detail_aud` VALUES ('322', null, null, null, null, null, null, '2016-09-11 18:43:16', null, null, null, '655', '0');
INSERT INTO `by_member_detail_aud` VALUES ('323', null, null, null, null, null, null, '2016-09-11 20:02:55', null, null, null, '657', '0');
INSERT INTO `by_member_detail_aud` VALUES ('324', null, null, null, null, null, null, '2016-09-11 20:17:00', null, null, null, '658', '0');
INSERT INTO `by_member_detail_aud` VALUES ('325', null, null, null, null, null, null, '2016-09-11 20:36:08', null, null, null, '659', '0');
INSERT INTO `by_member_detail_aud` VALUES ('325', '潘英杰', '', null, '1985-01-14 00:00:00', null, '', '2016-09-11 20:36:08', '2016-09-11 20:36:53', null, null, '661', '1');
INSERT INTO `by_member_detail_aud` VALUES ('326', null, null, null, null, null, null, '2016-09-11 20:36:52', null, null, null, '660', '0');
INSERT INTO `by_member_detail_aud` VALUES ('327', null, null, null, null, null, null, '2016-09-11 20:37:17', null, null, null, '662', '0');
INSERT INTO `by_member_detail_aud` VALUES ('327', '', '上海浦东新区高行镇秋岚路91弄10号201室', null, '1989-10-18 00:00:00', null, '310115198910185024', '2016-09-11 20:37:17', '2016-09-11 20:38:36', null, null, '664', '1');
INSERT INTO `by_member_detail_aud` VALUES ('328', null, null, null, null, null, null, '2016-09-11 20:37:53', null, null, null, '663', '0');
INSERT INTO `by_member_detail_aud` VALUES ('329', null, null, null, null, null, null, '2016-09-11 20:38:46', null, null, null, '665', '0');
INSERT INTO `by_member_detail_aud` VALUES ('330', null, null, null, null, null, null, '2016-09-11 20:39:39', null, null, null, '666', '0');
INSERT INTO `by_member_detail_aud` VALUES ('330', '左巧玲', '', null, '1993-10-27 00:00:00', null, '', '2016-09-11 20:39:39', '2016-09-11 20:40:27', null, null, '669', '1');
INSERT INTO `by_member_detail_aud` VALUES ('331', null, null, null, null, null, null, '2016-09-11 20:39:44', null, null, null, '667', '0');
INSERT INTO `by_member_detail_aud` VALUES ('332', null, null, null, null, null, null, '2016-09-11 20:40:21', null, null, null, '668', '0');
INSERT INTO `by_member_detail_aud` VALUES ('332', '陈丽华', '上海浦东新区金杨路220弄59号402室', null, null, null, '', '2016-09-11 20:40:21', '2016-09-11 20:41:09', null, null, '670', '1');
INSERT INTO `by_member_detail_aud` VALUES ('333', null, null, null, null, null, null, '2016-09-11 20:42:00', null, null, null, '671', '0');
INSERT INTO `by_member_detail_aud` VALUES ('333', null, null, 'd1715363bf443ff5146ff35d1935e6f26c7e340ac8cc2172d30cf388f7d24a20', null, null, null, '2016-09-11 20:42:00', '2016-09-11 20:43:23', null, null, '672', '1');
INSERT INTO `by_member_detail_aud` VALUES ('333', '', '', 'd1715363bf443ff5146ff35d1935e6f26c7e340ac8cc2172d30cf388f7d24a20', null, null, '', '2016-09-11 20:42:00', '2016-09-11 20:43:33', null, null, '673', '1');
INSERT INTO `by_member_detail_aud` VALUES ('334', null, null, null, null, null, null, '2016-09-11 20:43:55', null, null, null, '674', '0');
INSERT INTO `by_member_detail_aud` VALUES ('335', null, null, null, null, null, null, '2016-09-11 20:45:59', null, null, null, '675', '0');
INSERT INTO `by_member_detail_aud` VALUES ('335', null, null, 'a48f45cc82c4fa67bb05603b00c1fbe181516646cd685d442afd2afbd8a05d1d', null, null, null, '2016-09-11 20:45:59', '2016-09-11 20:47:33', null, null, '680', '1');
INSERT INTO `by_member_detail_aud` VALUES ('335', '', '凌河路420弄72号302室', 'a48f45cc82c4fa67bb05603b00c1fbe181516646cd685d442afd2afbd8a05d1d', '1978-09-15 00:00:00', null, '310115197809156427', '2016-09-11 20:45:59', '2016-09-11 20:48:17', null, null, '685', '1');
INSERT INTO `by_member_detail_aud` VALUES ('336', null, null, null, null, null, null, '2016-09-11 20:46:20', null, null, null, '676', '0');
INSERT INTO `by_member_detail_aud` VALUES ('337', null, null, null, null, null, null, '2016-09-11 20:46:54', null, null, null, '677', '0');
INSERT INTO `by_member_detail_aud` VALUES ('337', '郭军', '', null, '1977-08-01 00:00:00', null, '', '2016-09-11 20:46:54', '2016-09-11 20:47:56', null, null, '682', '1');
INSERT INTO `by_member_detail_aud` VALUES ('338', null, null, null, null, null, null, '2016-09-11 20:47:04', null, null, null, '678', '0');
INSERT INTO `by_member_detail_aud` VALUES ('338', '张洁清', '金桥镇佳林路919弄6号', null, '1979-01-06 00:00:00', null, '310115197901064728', '2016-09-11 20:47:04', '2016-09-11 20:55:04', null, null, '696', '1');
INSERT INTO `by_member_detail_aud` VALUES ('339', null, null, null, null, null, null, '2016-09-11 20:47:23', null, null, null, '679', '0');
INSERT INTO `by_member_detail_aud` VALUES ('340', null, null, null, null, null, null, '2016-09-11 20:47:43', null, null, null, '681', '0');
INSERT INTO `by_member_detail_aud` VALUES ('341', null, null, null, null, null, null, '2016-09-11 20:47:58', null, null, null, '683', '0');
INSERT INTO `by_member_detail_aud` VALUES ('341', '薛燕云', '浦东新区唐镇王港胜利路30弄金盛佳苑5号302室', null, '1986-09-21 00:00:00', null, '310115198609218421', '2016-09-11 20:47:58', '2016-09-11 20:48:48', null, null, '686', '1');
INSERT INTO `by_member_detail_aud` VALUES ('342', null, null, null, null, null, null, '2016-09-11 20:48:16', null, null, null, '684', '0');
INSERT INTO `by_member_detail_aud` VALUES ('343', null, null, null, null, null, null, '2016-09-11 20:49:07', null, null, null, '687', '0');
INSERT INTO `by_member_detail_aud` VALUES ('344', null, null, null, null, null, null, '2016-09-11 20:49:07', null, null, null, '688', '0');
INSERT INTO `by_member_detail_aud` VALUES ('345', null, null, null, null, null, null, '2016-09-11 20:49:16', null, null, null, '689', '0');
INSERT INTO `by_member_detail_aud` VALUES ('345', '俞舒萍', '', null, null, null, '', '2016-09-11 20:49:16', '2016-09-11 20:49:50', null, null, '690', '1');
INSERT INTO `by_member_detail_aud` VALUES ('346', null, null, null, null, null, null, '2016-09-11 20:50:25', null, null, null, '691', '0');
INSERT INTO `by_member_detail_aud` VALUES ('347', null, null, null, null, null, null, '2016-09-11 20:51:11', null, null, null, '692', '0');
INSERT INTO `by_member_detail_aud` VALUES ('348', null, null, null, null, null, null, '2016-09-11 20:54:09', null, null, null, '693', '0');
INSERT INTO `by_member_detail_aud` VALUES ('349', null, null, null, null, null, null, '2016-09-11 20:54:12', null, null, null, '694', '0');
INSERT INTO `by_member_detail_aud` VALUES ('349', '', '', null, null, null, '', '2016-09-11 20:54:12', '2016-09-11 20:54:35', null, null, '695', '1');
INSERT INTO `by_member_detail_aud` VALUES ('350', null, null, null, null, null, null, '2016-09-11 20:56:27', null, null, null, '697', '0');
INSERT INTO `by_member_detail_aud` VALUES ('351', null, null, null, null, null, null, '2016-09-11 20:58:30', null, null, null, '698', '0');
INSERT INTO `by_member_detail_aud` VALUES ('351', '王虹', '长宁区仙霞西路885弄41号301室', null, '1986-08-09 23:00:00', null, '310115198608104721', '2016-09-11 20:58:30', '2016-09-11 20:59:22', null, null, '700', '1');
INSERT INTO `by_member_detail_aud` VALUES ('352', null, null, null, null, null, null, '2016-09-11 20:59:01', null, null, null, '699', '0');
INSERT INTO `by_member_detail_aud` VALUES ('353', null, null, null, null, null, null, '2016-09-11 21:02:23', null, null, null, '701', '0');
INSERT INTO `by_member_detail_aud` VALUES ('354', null, null, null, null, null, null, '2016-09-11 21:04:18', null, null, null, '702', '0');
INSERT INTO `by_member_detail_aud` VALUES ('354', '', '', null, '1980-02-09 00:00:00', null, '310230198002092913', '2016-09-11 21:04:18', '2016-09-11 21:05:34', null, null, '703', '1');
INSERT INTO `by_member_detail_aud` VALUES ('355', null, null, null, null, null, null, '2016-09-11 21:10:06', null, null, null, '704', '0');
INSERT INTO `by_member_detail_aud` VALUES ('356', null, null, null, null, null, null, '2016-09-11 21:10:15', null, null, null, '705', '0');
INSERT INTO `by_member_detail_aud` VALUES ('356', '胡章荣', '永业路188弄14号302', null, '1986-08-18 23:00:00', null, '', '2016-09-11 21:10:15', '2016-09-11 21:13:27', null, null, '706', '1');
INSERT INTO `by_member_detail_aud` VALUES ('357', null, null, null, null, null, null, '2016-09-11 21:14:07', null, null, null, '707', '0');
INSERT INTO `by_member_detail_aud` VALUES ('358', null, null, null, null, null, null, '2016-09-11 21:15:06', null, null, null, '708', '0');
INSERT INTO `by_member_detail_aud` VALUES ('359', null, null, null, null, null, null, '2016-09-11 21:15:37', null, null, null, '709', '0');
INSERT INTO `by_member_detail_aud` VALUES ('360', null, null, null, null, null, null, '2016-09-11 21:18:26', null, null, null, '710', '0');
INSERT INTO `by_member_detail_aud` VALUES ('360', '倪轶洲', '', null, null, null, '', '2016-09-11 21:18:26', '2016-09-11 21:19:25', null, null, '713', '1');
INSERT INTO `by_member_detail_aud` VALUES ('361', null, null, null, null, null, null, '2016-09-11 21:18:57', null, null, null, '711', '0');
INSERT INTO `by_member_detail_aud` VALUES ('361', '', '', null, null, null, '', '2016-09-11 21:18:57', '2016-09-11 21:19:35', null, null, '714', '1');
INSERT INTO `by_member_detail_aud` VALUES ('362', null, null, null, null, null, null, '2016-09-11 21:19:15', null, null, null, '712', '0');
INSERT INTO `by_member_detail_aud` VALUES ('363', null, null, null, null, null, null, '2016-09-11 21:21:47', null, null, null, '715', '0');
INSERT INTO `by_member_detail_aud` VALUES ('364', null, null, null, null, null, null, '2016-09-11 21:22:22', null, null, null, '716', '0');
INSERT INTO `by_member_detail_aud` VALUES ('364', null, null, 'a1c3ce358462f0503b0d460db7812cfcc5194e8e7099ca84827b65fe8481659c', null, null, null, '2016-09-11 21:22:22', '2016-09-11 21:28:21', null, null, '723', '1');
INSERT INTO `by_member_detail_aud` VALUES ('364', '', '上海市浦东新区凌河路188弄76号301室', 'a1c3ce358462f0503b0d460db7812cfcc5194e8e7099ca84827b65fe8481659c', '1972-06-18 00:00:00', null, '310224197206182812', '2016-09-11 21:22:22', '2016-09-11 21:31:15', null, null, '725', '1');
INSERT INTO `by_member_detail_aud` VALUES ('364', '朱培忠', '上海市浦东新区凌河路188弄76号301室', 'a1c3ce358462f0503b0d460db7812cfcc5194e8e7099ca84827b65fe8481659c', '1972-06-18 00:00:00', null, '310224197206182812', '2016-09-11 21:22:22', '2016-09-11 21:32:00', null, null, '726', '1');
INSERT INTO `by_member_detail_aud` VALUES ('365', null, null, null, null, null, null, '2016-09-11 21:22:39', null, null, null, '717', '0');
INSERT INTO `by_member_detail_aud` VALUES ('366', null, null, null, null, null, null, '2016-09-11 21:22:59', null, null, null, '718', '0');
INSERT INTO `by_member_detail_aud` VALUES ('367', null, null, null, null, null, null, '2016-09-11 21:24:07', null, null, null, '719', '0');
INSERT INTO `by_member_detail_aud` VALUES ('367', '陆伟伟', '', null, '1983-10-17 00:00:00', null, '', '2016-09-11 21:24:07', '2016-09-11 21:25:10', null, null, '720', '1');
INSERT INTO `by_member_detail_aud` VALUES ('368', null, null, null, null, null, null, '2016-09-11 21:25:52', null, null, null, '721', '0');
INSERT INTO `by_member_detail_aud` VALUES ('369', null, null, null, null, null, null, '2016-09-11 21:26:02', null, null, null, '722', '0');
INSERT INTO `by_member_detail_aud` VALUES ('370', null, null, null, null, null, null, '2016-09-11 21:30:01', null, null, null, '724', '0');
INSERT INTO `by_member_detail_aud` VALUES ('371', null, null, null, null, null, null, '2016-09-11 21:32:09', null, null, null, '727', '0');
INSERT INTO `by_member_detail_aud` VALUES ('372', null, null, null, null, null, null, '2016-09-11 21:36:55', null, null, null, '729', '0');
INSERT INTO `by_member_detail_aud` VALUES ('373', null, null, null, null, null, null, '2016-09-11 21:38:14', null, null, null, '730', '0');
INSERT INTO `by_member_detail_aud` VALUES ('373', '陈', '', null, null, null, '', '2016-09-11 21:38:14', '2016-09-11 21:39:13', null, null, '731', '1');
INSERT INTO `by_member_detail_aud` VALUES ('374', null, null, null, null, null, null, '2016-09-11 21:44:51', null, null, null, '732', '0');
INSERT INTO `by_member_detail_aud` VALUES ('375', null, null, null, null, null, null, '2016-09-11 21:53:18', null, null, null, '733', '0');
INSERT INTO `by_member_detail_aud` VALUES ('375', null, null, 'b1bed578b99f0e87872cc992ae1c273f757949815fe7f9ada4216edcc3ed27c3', null, null, null, '2016-09-11 21:53:18', '2016-09-11 21:54:35', null, null, '735', '1');
INSERT INTO `by_member_detail_aud` VALUES ('375', '钱诚', '金桥镇佳林路919弄4号302室', 'b1bed578b99f0e87872cc992ae1c273f757949815fe7f9ada4216edcc3ed27c3', '1990-06-25 23:00:00', null, '310115199006264714', '2016-09-11 21:53:18', '2016-09-11 21:55:22', null, null, '737', '1');
INSERT INTO `by_member_detail_aud` VALUES ('376', null, null, null, null, null, null, '2016-09-11 21:53:33', null, null, null, '734', '0');
INSERT INTO `by_member_detail_aud` VALUES ('377', null, null, null, null, null, null, '2016-09-11 21:55:16', null, null, null, '736', '0');
INSERT INTO `by_member_detail_aud` VALUES ('378', null, null, null, null, null, null, '2016-09-11 21:59:10', null, null, null, '738', '0');
INSERT INTO `by_member_detail_aud` VALUES ('378', '董良', '金桥镇永业小区', null, '1978-08-25 00:00:00', null, '', '2016-09-11 21:59:10', '2016-09-11 22:00:11', null, null, '739', '1');
INSERT INTO `by_member_detail_aud` VALUES ('379', null, null, null, null, null, null, '2016-09-11 22:03:29', null, null, null, '740', '0');
INSERT INTO `by_member_detail_aud` VALUES ('380', null, null, null, null, null, null, '2016-09-11 22:08:28', null, null, null, '741', '0');
INSERT INTO `by_member_detail_aud` VALUES ('381', null, null, null, null, null, null, '2016-09-11 22:15:27', null, null, null, '742', '0');
INSERT INTO `by_member_detail_aud` VALUES ('381', '', '', null, '1986-12-14 00:00:00', null, '', '2016-09-11 22:15:27', '2016-09-11 22:15:55', null, null, '743', '1');
INSERT INTO `by_member_detail_aud` VALUES ('382', null, null, null, null, null, null, '2016-09-11 22:21:46', null, null, null, '744', '0');
INSERT INTO `by_member_detail_aud` VALUES ('383', null, null, null, null, null, null, '2016-09-11 22:24:49', null, null, null, '745', '0');
INSERT INTO `by_member_detail_aud` VALUES ('384', null, null, null, null, null, null, '2016-09-11 22:26:46', null, null, null, '746', '0');
INSERT INTO `by_member_detail_aud` VALUES ('385', null, null, null, null, null, null, '2016-09-11 22:29:56', null, null, null, '747', '0');
INSERT INTO `by_member_detail_aud` VALUES ('385', '', '', null, '1990-09-19 00:00:00', null, '', '2016-09-11 22:29:56', '2016-09-11 22:31:03', null, null, '748', '1');
INSERT INTO `by_member_detail_aud` VALUES ('385', '王佳莉', '', null, '1990-09-19 00:00:00', null, '', '2016-09-11 22:29:56', '2016-09-11 22:31:23', null, null, '749', '1');
INSERT INTO `by_member_detail_aud` VALUES ('385', '王佳莉', '', '52bb588ddc390e0dd995855cf95c2c75029410728890a535e8aef70fc4df91f4', '1990-09-19 00:00:00', null, '', '2016-09-11 22:29:56', '2016-09-11 22:33:59', null, null, '751', '1');
INSERT INTO `by_member_detail_aud` VALUES ('386', null, null, null, null, null, null, '2016-09-11 22:33:41', null, null, null, '750', '0');
INSERT INTO `by_member_detail_aud` VALUES ('386', null, null, '112936dd11e74880ec4a9f6643da6249527ebe86535c61c75a09cb60efdac158', null, null, null, '2016-09-11 22:33:41', '2016-09-11 22:36:05', null, null, '753', '1');
INSERT INTO `by_member_detail_aud` VALUES ('387', null, null, null, null, null, null, '2016-09-11 22:35:52', null, null, null, '752', '0');
INSERT INTO `by_member_detail_aud` VALUES ('388', null, null, null, null, null, null, '2016-09-11 22:38:00', null, null, null, '754', '0');
INSERT INTO `by_member_detail_aud` VALUES ('388', '张招娣', '永业路', null, null, null, '', '2016-09-11 22:38:00', '2016-09-11 22:42:13', null, null, '755', '1');
INSERT INTO `by_member_detail_aud` VALUES ('389', null, null, null, null, null, null, '2016-09-11 22:47:17', null, null, null, '756', '0');
INSERT INTO `by_member_detail_aud` VALUES ('390', null, null, null, null, null, null, '2016-09-11 23:42:16', null, null, null, '757', '0');
INSERT INTO `by_member_detail_aud` VALUES ('390', null, null, '1f5c0da2c3facbfbdd87b5a06fa8af411f9344d6db317344d2519af052005c22', null, null, null, '2016-09-11 23:42:16', '2016-09-11 23:43:31', null, null, '758', '1');
INSERT INTO `by_member_detail_aud` VALUES ('390', '', '佳林路838弄4号602', '1f5c0da2c3facbfbdd87b5a06fa8af411f9344d6db317344d2519af052005c22', '1989-10-19 00:00:00', null, '310115198910194713', '2016-09-11 23:42:16', '2016-09-11 23:44:09', null, null, '759', '1');
INSERT INTO `by_member_detail_aud` VALUES ('390', '江军', '佳林路838弄4号602', '1f5c0da2c3facbfbdd87b5a06fa8af411f9344d6db317344d2519af052005c22', '1989-10-19 00:00:00', null, '310115198910194713', '2016-09-11 23:42:16', '2016-09-11 23:44:24', null, null, '760', '1');
INSERT INTO `by_member_detail_aud` VALUES ('391', null, null, null, null, null, null, '2016-09-11 23:58:53', null, null, null, '761', '0');
INSERT INTO `by_member_detail_aud` VALUES ('391', null, null, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, null, null, '2016-09-11 23:58:53', '2016-09-12 00:00:11', null, null, '762', '1');
INSERT INTO `by_member_detail_aud` VALUES ('391', '凌霞', '高宝路379弄14号', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1983-08-24 00:00:00', null, '310115198308245645', '2016-09-11 23:58:53', '2016-09-12 00:01:00', null, null, '763', '1');
INSERT INTO `by_member_detail_aud` VALUES ('392', null, null, null, null, null, null, '2016-09-12 01:08:46', null, null, null, '764', '0');
INSERT INTO `by_member_detail_aud` VALUES ('393', null, null, null, null, null, null, '2016-09-12 01:21:02', null, null, null, '765', '0');
INSERT INTO `by_member_detail_aud` VALUES ('394', null, null, null, null, null, null, '2016-09-12 04:43:42', null, null, null, '766', '0');
INSERT INTO `by_member_detail_aud` VALUES ('394', '薄梓及', '上海市浦东新区金高路2131弄45号501室', null, '1971-05-03 00:00:00', null, '642122197105030334', '2016-09-12 04:43:42', '2016-09-12 04:46:12', null, null, '767', '1');
INSERT INTO `by_member_detail_aud` VALUES ('395', null, null, null, null, null, null, '2016-09-12 05:57:29', null, null, null, '768', '0');
INSERT INTO `by_member_detail_aud` VALUES ('396', null, null, null, null, null, null, '2016-09-12 06:45:05', null, null, null, '769', '0');
INSERT INTO `by_member_detail_aud` VALUES ('397', null, null, null, null, null, null, '2016-09-12 07:05:26', null, null, null, '770', '0');
INSERT INTO `by_member_detail_aud` VALUES ('397', '凌寒琪', '', null, '1986-12-29 00:00:00', null, '', '2016-09-12 07:05:26', '2016-09-12 07:06:09', null, null, '771', '1');
INSERT INTO `by_member_detail_aud` VALUES ('398', null, null, null, null, null, null, '2016-09-12 07:14:29', null, null, null, '772', '0');
INSERT INTO `by_member_detail_aud` VALUES ('399', null, null, null, null, null, null, '2016-09-12 07:58:03', null, null, null, '773', '0');
INSERT INTO `by_member_detail_aud` VALUES ('400', null, null, null, null, null, null, '2016-09-12 08:46:33', null, null, null, '774', '0');
INSERT INTO `by_member_detail_aud` VALUES ('401', null, null, null, null, null, null, '2016-09-12 08:52:12', null, null, null, '775', '0');
INSERT INTO `by_member_detail_aud` VALUES ('401', '陶园', '', null, null, null, '', '2016-09-12 08:52:12', '2016-09-12 08:54:28', null, null, '776', '1');
INSERT INTO `by_member_detail_aud` VALUES ('402', null, null, null, null, null, null, '2016-09-12 09:10:48', null, null, null, '777', '0');
INSERT INTO `by_member_detail_aud` VALUES ('403', null, null, null, null, null, null, '2016-09-12 09:19:18', null, null, null, '778', '0');
INSERT INTO `by_member_detail_aud` VALUES ('404', null, null, null, null, null, null, '2016-09-12 09:24:14', null, null, null, '779', '0');
INSERT INTO `by_member_detail_aud` VALUES ('404', '黄俊', '', null, null, null, '', '2016-09-12 09:24:14', '2016-09-12 09:24:43', null, null, '780', '1');
INSERT INTO `by_member_detail_aud` VALUES ('405', null, null, null, null, null, null, '2016-09-12 09:47:52', null, null, null, '781', '0');
INSERT INTO `by_member_detail_aud` VALUES ('406', null, null, null, null, null, null, '2016-09-12 09:52:51', null, null, null, '782', '0');
INSERT INTO `by_member_detail_aud` VALUES ('407', null, null, null, null, null, null, '2016-09-12 09:56:49', null, null, null, '783', '0');
INSERT INTO `by_member_detail_aud` VALUES ('408', null, null, null, null, null, null, '2016-09-12 10:11:56', null, null, null, '784', '0');
INSERT INTO `by_member_detail_aud` VALUES ('408', '陆女士', '', null, null, null, '', '2016-09-12 10:11:56', '2016-09-12 10:12:26', null, null, '785', '1');
INSERT INTO `by_member_detail_aud` VALUES ('409', null, null, null, null, null, null, '2016-09-12 10:21:56', null, null, null, '786', '0');
INSERT INTO `by_member_detail_aud` VALUES ('410', null, null, null, null, null, null, '2016-09-12 11:33:28', null, null, null, '787', '0');
INSERT INTO `by_member_detail_aud` VALUES ('411', null, null, null, null, null, null, '2016-09-12 12:32:44', null, null, null, '788', '0');
INSERT INTO `by_member_detail_aud` VALUES ('411', null, null, '6ea8477b428737460aa6ad05366dd82c9425bb9d81e89b574ee2a75484627ef2', null, null, null, '2016-09-12 12:32:44', '2016-09-12 12:33:51', null, null, '789', '1');
INSERT INTO `by_member_detail_aud` VALUES ('411', '陆宇', '浦东新区永宁路136弄6号401室', '6ea8477b428737460aa6ad05366dd82c9425bb9d81e89b574ee2a75484627ef2', '1984-05-16 00:00:00', null, '310230198405164758', '2016-09-12 12:32:44', '2016-09-12 12:34:53', null, null, '790', '1');
INSERT INTO `by_member_detail_aud` VALUES ('412', null, null, null, null, null, null, '2016-09-12 12:46:57', null, null, null, '791', '0');
INSERT INTO `by_member_detail_aud` VALUES ('413', null, null, null, null, null, null, '2016-09-12 13:06:46', null, null, null, '792', '0');
INSERT INTO `by_member_detail_aud` VALUES ('413', '', '', null, '1987-06-23 23:00:00', null, '', '2016-09-12 13:06:46', '2016-09-12 13:07:28', null, null, '793', '1');
INSERT INTO `by_member_detail_aud` VALUES ('414', null, null, null, null, null, null, '2016-09-12 14:15:46', null, null, null, '794', '0');
INSERT INTO `by_member_detail_aud` VALUES ('415', null, null, null, null, null, null, '2016-09-12 15:22:03', null, null, null, '795', '0');
INSERT INTO `by_member_detail_aud` VALUES ('416', null, null, null, null, null, null, '2016-09-12 15:30:34', null, null, null, '796', '0');
INSERT INTO `by_member_detail_aud` VALUES ('417', null, null, null, null, null, null, '2016-09-12 16:40:15', null, null, null, '797', '0');
INSERT INTO `by_member_detail_aud` VALUES ('418', null, null, null, null, null, null, '2016-09-12 17:01:01', null, null, null, '798', '0');
INSERT INTO `by_member_detail_aud` VALUES ('419', null, null, null, null, null, null, '2016-09-12 17:13:23', null, null, null, '799', '0');
INSERT INTO `by_member_detail_aud` VALUES ('420', null, null, null, null, null, null, '2016-09-12 18:06:07', null, null, null, '800', '0');
INSERT INTO `by_member_detail_aud` VALUES ('420', '陆老师', '', null, null, null, '', '2016-09-12 18:06:07', '2016-11-21 11:15:52', null, null, '1506', '1');
INSERT INTO `by_member_detail_aud` VALUES ('421', null, null, null, null, null, null, '2016-09-12 18:51:19', null, null, null, '801', '0');
INSERT INTO `by_member_detail_aud` VALUES ('422', null, null, null, null, null, null, '2016-09-12 19:05:46', null, null, null, '802', '0');
INSERT INTO `by_member_detail_aud` VALUES ('423', null, null, null, null, null, null, '2016-09-12 19:39:08', null, null, null, '803', '0');
INSERT INTO `by_member_detail_aud` VALUES ('424', null, null, null, null, null, null, '2016-09-12 20:47:04', null, null, null, '804', '0');
INSERT INTO `by_member_detail_aud` VALUES ('425', null, null, null, null, null, null, '2016-09-12 21:01:27', null, null, null, '805', '0');
INSERT INTO `by_member_detail_aud` VALUES ('426', null, null, null, null, null, null, '2016-09-12 22:18:40', null, null, null, '806', '0');
INSERT INTO `by_member_detail_aud` VALUES ('426', null, null, 'c163f4931042e283bcfa528e6bb46c2d0ea2135de2b0fa90517dc832c6fae1ef', null, null, null, '2016-09-12 22:18:40', '2016-09-12 23:25:56', null, null, '807', '1');
INSERT INTO `by_member_detail_aud` VALUES ('426', '', '上海市浦东新区金桥镇长岛路长岛花苑1560弄17号1903', 'c163f4931042e283bcfa528e6bb46c2d0ea2135de2b0fa90517dc832c6fae1ef', '1992-10-23 00:00:00', null, '441881199210231444', '2016-09-12 22:18:40', '2016-09-12 23:27:00', null, null, '808', '1');
INSERT INTO `by_member_detail_aud` VALUES ('426', '谢优思', '上海市浦东新区金桥镇长岛路长岛花苑1560弄17号1903', 'c163f4931042e283bcfa528e6bb46c2d0ea2135de2b0fa90517dc832c6fae1ef', '1992-10-23 00:00:00', null, '441881199210231444', '2016-09-12 22:18:40', '2016-09-12 23:27:16', null, null, '809', '1');
INSERT INTO `by_member_detail_aud` VALUES ('427', null, null, null, null, null, null, '2016-09-13 07:55:13', null, null, null, '810', '0');
INSERT INTO `by_member_detail_aud` VALUES ('428', null, null, null, null, null, null, '2016-09-13 13:36:10', null, null, null, '811', '0');
INSERT INTO `by_member_detail_aud` VALUES ('429', null, null, null, null, null, null, '2016-09-13 14:21:16', null, null, null, '812', '0');
INSERT INTO `by_member_detail_aud` VALUES ('430', null, null, null, null, null, null, '2016-09-13 14:22:48', null, null, null, '813', '0');
INSERT INTO `by_member_detail_aud` VALUES ('431', null, null, null, null, null, null, '2016-09-13 15:30:58', null, null, null, '814', '0');
INSERT INTO `by_member_detail_aud` VALUES ('432', null, null, null, null, null, null, '2016-09-13 16:18:14', null, null, null, '815', '0');
INSERT INTO `by_member_detail_aud` VALUES ('432', '王慧丽', '', null, null, null, '', '2016-09-13 16:18:14', '2016-09-13 16:18:49', null, null, '816', '1');
INSERT INTO `by_member_detail_aud` VALUES ('433', null, null, null, null, null, null, '2016-09-13 16:38:12', null, null, null, '817', '0');
INSERT INTO `by_member_detail_aud` VALUES ('434', null, null, null, null, null, null, '2016-09-13 17:30:12', null, null, null, '818', '0');
INSERT INTO `by_member_detail_aud` VALUES ('435', null, null, null, null, null, null, '2016-09-13 18:23:56', null, null, null, '819', '0');
INSERT INTO `by_member_detail_aud` VALUES ('435', '古天宇', '上海市浦东新区巨峰路716弄13号603室', null, '1986-02-04 00:00:00', null, '410882198602046016', '2016-09-13 18:23:56', '2016-09-13 18:25:37', null, null, '820', '1');
INSERT INTO `by_member_detail_aud` VALUES ('436', null, null, null, null, null, null, '2016-09-13 19:23:39', null, null, null, '821', '0');
INSERT INTO `by_member_detail_aud` VALUES ('437', null, null, null, null, null, null, '2016-09-13 22:24:30', null, null, null, '822', '0');
INSERT INTO `by_member_detail_aud` VALUES ('438', null, null, null, null, null, null, '2016-09-13 22:32:56', null, null, null, '823', '0');
INSERT INTO `by_member_detail_aud` VALUES ('439', null, null, null, null, null, null, '2016-09-14 08:20:19', null, null, null, '824', '0');
INSERT INTO `by_member_detail_aud` VALUES ('440', null, null, null, null, null, null, '2016-09-14 08:22:16', null, null, null, '825', '0');
INSERT INTO `by_member_detail_aud` VALUES ('440', null, null, '52e3ca9a5ec3a96287247a8ee995f22bcef585382a55c5057cdbeae096596747', null, null, null, '2016-09-14 08:22:16', '2016-09-14 08:24:34', null, null, '826', '1');
INSERT INTO `by_member_detail_aud` VALUES ('440', '', '浦东新区博兴路1676弄21号401室', '52e3ca9a5ec3a96287247a8ee995f22bcef585382a55c5057cdbeae096596747', '1984-10-28 00:00:00', null, '340403198410280443', '2016-09-14 08:22:16', '2016-09-14 08:25:15', null, null, '827', '1');
INSERT INTO `by_member_detail_aud` VALUES ('441', null, null, null, null, null, null, '2016-09-14 09:23:11', null, null, null, '828', '0');
INSERT INTO `by_member_detail_aud` VALUES ('441', '黄伟春', '', null, '1985-02-15 00:00:00', null, '', '2016-09-14 09:23:11', '2016-09-14 09:24:22', null, null, '829', '1');
INSERT INTO `by_member_detail_aud` VALUES ('442', null, null, null, null, null, null, '2016-09-14 10:32:54', null, null, null, '830', '0');
INSERT INTO `by_member_detail_aud` VALUES ('443', null, null, null, null, null, null, '2016-09-14 11:00:52', null, null, null, '831', '0');
INSERT INTO `by_member_detail_aud` VALUES ('443', '瞿杰', '', null, '1992-10-05 00:00:00', null, '', '2016-09-14 11:00:52', '2016-09-14 11:01:21', null, null, '832', '1');
INSERT INTO `by_member_detail_aud` VALUES ('444', null, null, null, null, null, null, '2016-09-14 11:11:45', null, null, null, '833', '0');
INSERT INTO `by_member_detail_aud` VALUES ('445', null, null, null, null, null, null, '2016-09-14 11:12:59', null, null, null, '834', '0');
INSERT INTO `by_member_detail_aud` VALUES ('446', null, null, null, null, null, null, '2016-09-14 11:38:39', null, null, null, '835', '0');
INSERT INTO `by_member_detail_aud` VALUES ('447', null, null, null, null, null, null, '2016-09-14 12:30:08', null, null, null, '836', '0');
INSERT INTO `by_member_detail_aud` VALUES ('448', null, null, null, null, null, null, '2016-09-14 14:56:15', null, null, null, '837', '0');
INSERT INTO `by_member_detail_aud` VALUES ('448', '凌迪', '', null, null, null, '', '2016-09-14 14:56:15', '2016-09-14 14:56:38', null, null, '838', '1');
INSERT INTO `by_member_detail_aud` VALUES ('449', null, null, null, null, null, null, '2016-09-14 15:00:08', null, null, null, '839', '0');
INSERT INTO `by_member_detail_aud` VALUES ('450', null, null, null, null, null, null, '2016-09-14 15:20:53', null, null, null, '840', '0');
INSERT INTO `by_member_detail_aud` VALUES ('451', null, null, null, null, null, null, '2016-09-14 15:33:17', null, null, null, '841', '0');
INSERT INTO `by_member_detail_aud` VALUES ('451', '詹海', '', null, null, null, '', '2016-09-14 15:33:17', '2016-09-14 15:34:01', null, null, '842', '1');
INSERT INTO `by_member_detail_aud` VALUES ('452', null, null, null, null, null, null, '2016-09-14 15:40:45', null, null, null, '843', '0');
INSERT INTO `by_member_detail_aud` VALUES ('452', '', '杨高北路5291弄22号401', null, '1979-05-05 00:00:00', null, '', '2016-09-14 15:40:45', '2016-09-14 15:43:40', null, null, '844', '1');
INSERT INTO `by_member_detail_aud` VALUES ('452', '陶燕', '杨高北路5291弄22号401', null, '1979-05-05 00:00:00', null, '', '2016-09-14 15:40:45', '2016-09-14 15:44:01', null, null, '846', '1');
INSERT INTO `by_member_detail_aud` VALUES ('453', null, null, null, null, null, null, '2016-09-14 15:43:47', null, null, null, '845', '0');
INSERT INTO `by_member_detail_aud` VALUES ('454', null, null, null, null, null, null, '2016-09-14 15:46:40', null, null, null, '847', '0');
INSERT INTO `by_member_detail_aud` VALUES ('455', null, null, null, null, null, null, '2016-09-14 15:47:31', null, null, null, '848', '0');
INSERT INTO `by_member_detail_aud` VALUES ('456', null, null, null, null, null, null, '2016-09-14 15:47:56', null, null, null, '849', '0');
INSERT INTO `by_member_detail_aud` VALUES ('457', null, null, null, null, null, null, '2016-09-14 15:48:07', null, null, null, '850', '0');
INSERT INTO `by_member_detail_aud` VALUES ('458', null, null, null, null, null, null, '2016-09-14 15:53:55', null, null, null, '851', '0');
INSERT INTO `by_member_detail_aud` VALUES ('459', null, null, null, null, null, null, '2016-09-14 15:53:58', null, null, null, '852', '0');
INSERT INTO `by_member_detail_aud` VALUES ('460', null, null, null, null, null, null, '2016-09-14 15:58:13', null, null, null, '853', '0');
INSERT INTO `by_member_detail_aud` VALUES ('461', null, null, null, null, null, null, '2016-09-14 16:00:14', null, null, null, '854', '0');
INSERT INTO `by_member_detail_aud` VALUES ('461', '', '', null, null, null, '', '2016-09-14 16:00:14', '2016-09-14 16:00:34', null, null, '855', '1');
INSERT INTO `by_member_detail_aud` VALUES ('461', '汤一梅', '', null, '1982-10-22 00:00:00', null, '310115198210225048', '2016-09-14 16:00:14', '2016-10-09 13:40:27', null, null, '1229', '1');
INSERT INTO `by_member_detail_aud` VALUES ('462', null, null, null, null, null, null, '2016-09-14 16:21:32', null, null, null, '856', '0');
INSERT INTO `by_member_detail_aud` VALUES ('463', null, null, null, null, null, null, '2016-09-14 16:24:51', null, null, null, '857', '0');
INSERT INTO `by_member_detail_aud` VALUES ('463', '朱雪雯', '', null, '1983-07-06 00:00:00', null, '', '2016-09-14 16:24:51', '2016-09-14 16:25:56', null, null, '858', '1');
INSERT INTO `by_member_detail_aud` VALUES ('464', null, null, null, null, null, null, '2016-09-14 16:38:56', null, null, null, '859', '0');
INSERT INTO `by_member_detail_aud` VALUES ('464', '武加华', '', null, '1981-08-02 00:00:00', null, '', '2016-09-14 16:38:56', '2016-09-14 16:43:19', null, null, '862', '1');
INSERT INTO `by_member_detail_aud` VALUES ('465', null, null, null, null, null, null, '2016-09-14 16:40:19', null, null, null, '860', '0');
INSERT INTO `by_member_detail_aud` VALUES ('466', null, null, null, null, null, null, '2016-09-14 16:41:08', null, null, null, '861', '0');
INSERT INTO `by_member_detail_aud` VALUES ('467', null, null, null, null, null, null, '2016-09-14 16:53:19', null, null, null, '863', '0');
INSERT INTO `by_member_detail_aud` VALUES ('468', null, null, null, null, null, null, '2016-09-14 17:03:59', null, null, null, '864', '0');
INSERT INTO `by_member_detail_aud` VALUES ('469', null, null, null, null, null, null, '2016-09-14 17:10:13', null, null, null, '865', '0');
INSERT INTO `by_member_detail_aud` VALUES ('470', null, null, null, null, null, null, '2016-09-14 17:10:53', null, null, null, '866', '0');
INSERT INTO `by_member_detail_aud` VALUES ('471', null, null, null, null, null, null, '2016-09-14 18:24:36', null, null, null, '868', '0');
INSERT INTO `by_member_detail_aud` VALUES ('472', null, null, null, null, null, null, '2016-09-14 19:12:42', null, null, null, '869', '0');
INSERT INTO `by_member_detail_aud` VALUES ('473', null, null, null, null, null, null, '2016-09-14 20:04:36', null, null, null, '870', '0');
INSERT INTO `by_member_detail_aud` VALUES ('474', null, null, null, null, null, null, '2016-09-14 21:12:09', null, null, null, '873', '0');
INSERT INTO `by_member_detail_aud` VALUES ('475', null, null, null, null, null, null, '2016-09-14 21:12:16', null, null, null, '874', '0');
INSERT INTO `by_member_detail_aud` VALUES ('476', null, null, null, null, null, null, '2016-09-14 21:48:07', null, null, null, '875', '0');
INSERT INTO `by_member_detail_aud` VALUES ('477', null, null, null, null, null, null, '2016-09-14 23:39:31', null, null, null, '876', '0');
INSERT INTO `by_member_detail_aud` VALUES ('478', null, null, null, null, null, null, '2016-09-14 23:49:28', null, null, null, '877', '0');
INSERT INTO `by_member_detail_aud` VALUES ('479', null, null, null, null, null, null, '2016-09-15 07:01:44', null, null, null, '878', '0');
INSERT INTO `by_member_detail_aud` VALUES ('480', null, null, null, null, null, null, '2016-09-15 08:04:43', null, null, null, '879', '0');
INSERT INTO `by_member_detail_aud` VALUES ('480', '琴牛牛', '', null, null, null, '', '2016-09-15 08:04:43', '2016-09-15 08:05:12', null, null, '880', '1');
INSERT INTO `by_member_detail_aud` VALUES ('481', null, null, null, null, null, null, '2016-09-15 09:09:29', null, null, null, '881', '0');
INSERT INTO `by_member_detail_aud` VALUES ('482', null, null, null, null, null, null, '2016-09-15 09:41:38', null, null, null, '882', '0');
INSERT INTO `by_member_detail_aud` VALUES ('483', null, null, null, null, null, null, '2016-09-15 11:08:13', null, null, null, '883', '0');
INSERT INTO `by_member_detail_aud` VALUES ('484', null, null, null, null, null, null, '2016-09-15 11:23:04', null, null, null, '884', '0');
INSERT INTO `by_member_detail_aud` VALUES ('485', null, null, null, null, null, null, '2016-09-15 11:37:36', null, null, null, '885', '0');
INSERT INTO `by_member_detail_aud` VALUES ('485', '姜', '佳林路898弄11号401室', null, '1972-11-25 00:00:00', null, '', '2016-09-15 11:37:36', '2016-09-15 11:42:13', null, null, '886', '1');
INSERT INTO `by_member_detail_aud` VALUES ('486', null, null, null, null, null, null, '2016-09-15 11:45:55', null, null, null, '887', '0');
INSERT INTO `by_member_detail_aud` VALUES ('487', null, null, null, null, null, null, '2016-09-15 13:06:39', null, null, null, '888', '0');
INSERT INTO `by_member_detail_aud` VALUES ('488', null, null, null, null, null, null, '2016-09-15 13:17:39', null, null, null, '889', '0');
INSERT INTO `by_member_detail_aud` VALUES ('489', null, null, null, null, null, null, '2016-09-15 13:18:45', null, null, null, '890', '0');
INSERT INTO `by_member_detail_aud` VALUES ('490', null, null, null, null, null, null, '2016-09-15 13:19:17', null, null, null, '891', '0');
INSERT INTO `by_member_detail_aud` VALUES ('490', '王', '', null, '1987-07-31 23:00:00', null, '', '2016-09-15 13:19:17', '2016-09-15 13:19:59', null, null, '892', '1');
INSERT INTO `by_member_detail_aud` VALUES ('491', null, null, null, null, null, null, '2016-09-15 13:22:38', null, null, null, '893', '0');
INSERT INTO `by_member_detail_aud` VALUES ('492', null, null, null, null, null, null, '2016-09-15 14:00:19', null, null, null, '894', '0');
INSERT INTO `by_member_detail_aud` VALUES ('493', null, null, null, null, null, null, '2016-09-15 14:33:32', null, null, null, '895', '0');
INSERT INTO `by_member_detail_aud` VALUES ('494', null, null, null, null, null, null, '2016-09-15 14:59:27', null, null, null, '896', '0');
INSERT INTO `by_member_detail_aud` VALUES ('494', null, null, 'dec7a88a4f9bb8bf6d35d7f4e2aa6bb573d21a61bf1e5dda6df92fc00a8d16f0', null, null, null, '2016-09-15 14:59:27', '2016-09-15 15:00:43', null, null, '897', '1');
INSERT INTO `by_member_detail_aud` VALUES ('494', '', '东陆路2000弄35号902', 'dec7a88a4f9bb8bf6d35d7f4e2aa6bb573d21a61bf1e5dda6df92fc00a8d16f0', '1975-07-29 00:00:00', null, '370204197507291831', '2016-09-15 14:59:27', '2016-09-15 15:01:20', null, null, '898', '1');
INSERT INTO `by_member_detail_aud` VALUES ('495', null, null, null, null, null, null, '2016-09-15 15:15:51', null, null, null, '899', '0');
INSERT INTO `by_member_detail_aud` VALUES ('496', null, null, null, null, null, null, '2016-09-15 16:19:07', null, null, null, '900', '0');
INSERT INTO `by_member_detail_aud` VALUES ('497', null, null, null, null, null, null, '2016-09-15 19:42:42', null, null, null, '901', '0');
INSERT INTO `by_member_detail_aud` VALUES ('497', '孙艳梅', '', null, null, null, '', '2016-09-15 19:42:42', '2016-09-15 19:43:13', null, null, '902', '1');
INSERT INTO `by_member_detail_aud` VALUES ('498', null, null, null, null, null, null, '2016-09-15 19:55:08', null, null, null, '903', '0');
INSERT INTO `by_member_detail_aud` VALUES ('498', null, null, 'ede93148cd7cc0ba4864d6207f1999e7ab856e6e9c8c20cf7cc84d611bc1d52d', null, null, null, '2016-09-15 19:55:08', '2016-09-15 19:56:21', null, null, '904', '1');
INSERT INTO `by_member_detail_aud` VALUES ('498', '', '', 'ede93148cd7cc0ba4864d6207f1999e7ab856e6e9c8c20cf7cc84d611bc1d52d', '1981-01-27 00:00:00', null, '320583198101279426', '2016-09-15 19:55:08', '2016-09-15 19:56:36', null, null, '905', '1');
INSERT INTO `by_member_detail_aud` VALUES ('499', null, null, null, null, null, null, '2016-09-15 20:14:25', null, null, null, '906', '0');
INSERT INTO `by_member_detail_aud` VALUES ('500', null, null, null, null, null, null, '2016-09-15 22:03:54', null, null, null, '907', '0');
INSERT INTO `by_member_detail_aud` VALUES ('500', null, null, '5fe61904bd1a402102ccc06c419525ccbc56f09360004c284a92595b184455ec', null, null, null, '2016-09-15 22:03:54', '2016-09-15 22:06:13', null, null, '908', '1');
INSERT INTO `by_member_detail_aud` VALUES ('500', '', '', '5fe61904bd1a402102ccc06c419525ccbc56f09360004c284a92595b184455ec', null, null, '', '2016-09-15 22:03:54', '2016-09-15 22:06:18', null, null, '909', '1');
INSERT INTO `by_member_detail_aud` VALUES ('501', null, null, null, null, null, null, '2016-09-15 22:32:19', null, null, null, '910', '0');
INSERT INTO `by_member_detail_aud` VALUES ('502', null, null, null, null, null, null, '2016-09-16 10:53:19', null, null, null, '911', '0');
INSERT INTO `by_member_detail_aud` VALUES ('503', null, null, null, null, null, null, '2016-09-16 11:41:13', null, null, null, '912', '0');
INSERT INTO `by_member_detail_aud` VALUES ('504', null, null, null, null, null, null, '2016-09-16 12:05:54', null, null, null, '913', '0');
INSERT INTO `by_member_detail_aud` VALUES ('505', null, null, null, null, null, null, '2016-09-16 12:54:10', null, null, null, '914', '0');
INSERT INTO `by_member_detail_aud` VALUES ('505', '丁文彬', '', null, null, null, '', '2016-09-16 12:54:10', '2016-09-16 12:54:26', null, null, '915', '1');
INSERT INTO `by_member_detail_aud` VALUES ('506', null, null, null, null, null, null, '2016-09-16 13:20:43', null, null, null, '916', '0');
INSERT INTO `by_member_detail_aud` VALUES ('507', null, null, null, null, null, null, '2016-09-16 14:48:07', null, null, null, '917', '0');
INSERT INTO `by_member_detail_aud` VALUES ('507', null, null, 'df32b5516a217f671f146eb6cdd52d35a4aa69427246b732fbb7700cd38a3c0f', null, null, null, '2016-09-16 14:48:07', '2016-09-17 16:22:45', null, null, '936', '1');
INSERT INTO `by_member_detail_aud` VALUES ('507', '', '', 'df32b5516a217f671f146eb6cdd52d35a4aa69427246b732fbb7700cd38a3c0f', null, null, '', '2016-09-16 14:48:07', '2016-09-17 16:22:49', null, null, '937', '1');
INSERT INTO `by_member_detail_aud` VALUES ('508', null, null, null, null, null, null, '2016-09-16 15:13:55', null, null, null, '918', '0');
INSERT INTO `by_member_detail_aud` VALUES ('508', '卡卡', '', null, null, null, '', '2016-09-16 15:13:55', '2016-09-16 15:14:25', null, null, '919', '1');
INSERT INTO `by_member_detail_aud` VALUES ('509', null, null, null, null, null, null, '2016-09-16 16:02:45', null, null, null, '920', '0');
INSERT INTO `by_member_detail_aud` VALUES ('510', null, null, null, null, null, null, '2016-09-16 16:48:34', null, null, null, '921', '0');
INSERT INTO `by_member_detail_aud` VALUES ('510', '陈璐', '佳林路', null, '1982-09-21 00:00:00', null, '310115198209210623', '2016-09-16 16:48:34', '2016-09-16 16:52:14', null, null, '922', '1');
INSERT INTO `by_member_detail_aud` VALUES ('511', null, null, null, null, null, null, '2016-09-16 17:09:18', null, null, null, '923', '0');
INSERT INTO `by_member_detail_aud` VALUES ('512', null, null, null, null, null, null, '2016-09-16 18:51:58', null, null, null, '924', '0');
INSERT INTO `by_member_detail_aud` VALUES ('512', '', '', null, null, null, '', '2016-09-16 18:51:58', '2016-09-16 18:52:22', null, null, '925', '1');
INSERT INTO `by_member_detail_aud` VALUES ('513', null, null, null, null, null, null, '2016-09-16 19:42:20', null, null, null, '926', '0');
INSERT INTO `by_member_detail_aud` VALUES ('514', null, null, null, null, null, null, '2016-09-16 20:10:04', null, null, null, '927', '0');
INSERT INTO `by_member_detail_aud` VALUES ('515', null, null, null, null, null, null, '2016-09-16 22:54:29', null, null, null, '928', '0');
INSERT INTO `by_member_detail_aud` VALUES ('515', '唐瑜雯', '', null, null, null, '', '2016-09-16 22:54:29', '2016-09-29 22:05:27', null, null, '1098', '1');
INSERT INTO `by_member_detail_aud` VALUES ('516', null, null, null, null, null, null, '2016-09-17 08:34:48', null, null, null, '929', '0');
INSERT INTO `by_member_detail_aud` VALUES ('516', null, null, 'e1a29786531b79489854d561a489aba55d3786370069b9d5a64e0ba82b2066e3', null, null, null, '2016-09-17 08:34:48', '2016-09-17 08:35:40', null, null, '930', '1');
INSERT INTO `by_member_detail_aud` VALUES ('516', '张爱丽', '', 'e1a29786531b79489854d561a489aba55d3786370069b9d5a64e0ba82b2066e3', '1982-01-16 00:00:00', null, '310115198201160449', '2016-09-17 08:34:48', '2016-09-17 08:36:01', null, null, '931', '1');
INSERT INTO `by_member_detail_aud` VALUES ('517', null, null, null, null, null, null, '2016-09-17 10:21:25', null, null, null, '932', '0');
INSERT INTO `by_member_detail_aud` VALUES ('518', null, null, null, null, null, null, '2016-09-17 13:36:02', null, null, null, '933', '0');
INSERT INTO `by_member_detail_aud` VALUES ('519', null, null, null, null, null, null, '2016-09-17 13:57:07', null, null, null, '934', '0');
INSERT INTO `by_member_detail_aud` VALUES ('520', null, null, null, null, null, null, '2016-09-17 14:26:52', null, null, null, '935', '0');
INSERT INTO `by_member_detail_aud` VALUES ('521', null, null, null, null, null, null, '2016-09-17 16:33:45', null, null, null, '938', '0');
INSERT INTO `by_member_detail_aud` VALUES ('522', null, null, null, null, null, null, '2016-09-17 17:06:10', null, null, null, '939', '0');
INSERT INTO `by_member_detail_aud` VALUES ('523', null, null, null, null, null, null, '2016-09-17 17:11:32', null, null, null, '940', '0');
INSERT INTO `by_member_detail_aud` VALUES ('524', null, null, null, null, null, null, '2016-09-17 18:17:16', null, null, null, '941', '0');
INSERT INTO `by_member_detail_aud` VALUES ('524', '', '', null, '1992-03-15 00:00:00', null, '', '2016-09-17 18:17:16', '2016-09-17 18:34:19', null, null, '943', '1');
INSERT INTO `by_member_detail_aud` VALUES ('525', null, null, null, null, null, null, '2016-09-17 18:27:27', null, null, null, '942', '0');
INSERT INTO `by_member_detail_aud` VALUES ('526', null, null, null, null, null, null, '2016-09-17 18:50:45', null, null, null, '944', '0');
INSERT INTO `by_member_detail_aud` VALUES ('527', null, null, null, null, null, null, '2016-09-17 19:36:20', null, null, null, '945', '0');
INSERT INTO `by_member_detail_aud` VALUES ('528', null, null, null, null, null, null, '2016-09-17 20:11:05', null, null, null, '946', '0');
INSERT INTO `by_member_detail_aud` VALUES ('529', null, null, null, null, null, null, '2016-09-17 21:18:50', null, null, null, '947', '0');
INSERT INTO `by_member_detail_aud` VALUES ('530', null, null, null, null, null, null, '2016-09-18 10:57:52', null, null, null, '948', '0');
INSERT INTO `by_member_detail_aud` VALUES ('531', null, null, null, null, null, null, '2016-09-18 13:40:43', null, null, null, '949', '0');
INSERT INTO `by_member_detail_aud` VALUES ('532', null, null, null, null, null, null, '2016-09-18 14:05:02', null, null, null, '950', '0');
INSERT INTO `by_member_detail_aud` VALUES ('532', '', '', null, null, null, '', '2016-09-18 14:05:02', '2016-09-20 12:28:22', null, null, '974', '1');
INSERT INTO `by_member_detail_aud` VALUES ('533', null, null, null, null, null, null, '2016-09-18 14:24:17', null, null, null, '951', '0');
INSERT INTO `by_member_detail_aud` VALUES ('533', null, null, 'b7e11f69d1eb2dfdbb8205b98f52aa8063abccb74bad741228bf53ccd14112b6', null, null, null, '2016-09-18 14:24:17', '2016-09-18 14:26:12', null, null, '952', '1');
INSERT INTO `by_member_detail_aud` VALUES ('533', '', '上海市浦东新区金桥路2552弄67号202', 'b7e11f69d1eb2dfdbb8205b98f52aa8063abccb74bad741228bf53ccd14112b6', '1990-04-05 00:00:00', null, '321084199004055548', '2016-09-18 14:24:17', '2016-09-18 14:26:41', null, null, '953', '1');
INSERT INTO `by_member_detail_aud` VALUES ('533', '周欢', '上海市浦东新区金桥路2552弄67号202', 'b7e11f69d1eb2dfdbb8205b98f52aa8063abccb74bad741228bf53ccd14112b6', '1990-04-05 00:00:00', null, '321084199004055548', '2016-09-18 14:24:17', '2016-10-01 12:46:45', null, null, '1112', '1');
INSERT INTO `by_member_detail_aud` VALUES ('534', null, null, null, null, null, null, '2016-09-18 14:41:29', null, null, null, '954', '0');
INSERT INTO `by_member_detail_aud` VALUES ('535', null, null, null, null, null, null, '2016-09-18 14:47:49', null, null, null, '955', '0');
INSERT INTO `by_member_detail_aud` VALUES ('536', null, null, null, null, null, null, '2016-09-18 15:52:04', null, null, null, '956', '0');
INSERT INTO `by_member_detail_aud` VALUES ('537', null, null, null, null, null, null, '2016-09-18 17:11:45', null, null, null, '957', '0');
INSERT INTO `by_member_detail_aud` VALUES ('538', null, null, null, null, null, null, '2016-09-18 20:12:59', null, null, null, '958', '0');
INSERT INTO `by_member_detail_aud` VALUES ('539', null, null, null, null, null, null, '2016-09-18 20:39:30', null, null, null, '959', '0');
INSERT INTO `by_member_detail_aud` VALUES ('540', null, null, null, null, null, null, '2016-09-19 06:23:18', null, null, null, '960', '0');
INSERT INTO `by_member_detail_aud` VALUES ('541', null, null, null, null, null, null, '2016-09-19 08:24:19', null, null, null, '961', '0');
INSERT INTO `by_member_detail_aud` VALUES ('541', '', '', null, null, null, '', '2016-09-19 08:24:19', '2016-09-19 08:25:23', null, null, '962', '1');
INSERT INTO `by_member_detail_aud` VALUES ('542', null, null, null, null, null, null, '2016-09-19 10:46:34', null, null, null, '963', '0');
INSERT INTO `by_member_detail_aud` VALUES ('543', null, null, null, null, null, null, '2016-09-19 12:29:05', null, null, null, '964', '0');
INSERT INTO `by_member_detail_aud` VALUES ('544', null, null, null, null, null, null, '2016-09-19 16:11:48', null, null, null, '965', '0');
INSERT INTO `by_member_detail_aud` VALUES ('544', null, null, '385d1ed482d4c71129f530af5c5d783e50900a7cb95158a8632eda3ef40b9f15', null, null, null, '2016-09-19 16:11:48', '2016-09-19 16:14:04', null, null, '966', '1');
INSERT INTO `by_member_detail_aud` VALUES ('544', '', '金高路金舍苑2131弄41号1202室', '385d1ed482d4c71129f530af5c5d783e50900a7cb95158a8632eda3ef40b9f15', '1983-12-23 00:00:00', null, '310115198312230171', '2016-09-19 16:11:48', '2016-09-19 16:15:09', null, null, '967', '1');
INSERT INTO `by_member_detail_aud` VALUES ('545', null, null, null, null, null, null, '2016-09-19 20:03:08', null, null, null, '968', '0');
INSERT INTO `by_member_detail_aud` VALUES ('545', '', '', null, '1994-07-01 00:00:00', null, '412728199407014214', '2016-09-19 20:03:08', '2016-09-19 20:04:25', null, null, '969', '1');
INSERT INTO `by_member_detail_aud` VALUES ('545', '张超', '', null, '1994-07-01 00:00:00', null, '412728199407014214', '2016-09-19 20:03:08', '2016-09-19 20:04:37', null, null, '970', '1');
INSERT INTO `by_member_detail_aud` VALUES ('546', null, null, null, null, null, null, '2016-09-19 21:44:25', null, null, null, '971', '0');
INSERT INTO `by_member_detail_aud` VALUES ('546', '马寅伟', '', null, '1982-10-08 00:00:00', null, '', '2016-09-19 21:44:25', '2016-09-19 21:45:55', null, null, '972', '1');
INSERT INTO `by_member_detail_aud` VALUES ('547', null, null, null, null, null, null, '2016-09-20 10:10:51', null, null, null, '973', '0');
INSERT INTO `by_member_detail_aud` VALUES ('548', null, null, null, null, null, null, '2016-09-20 15:50:44', null, null, null, '975', '0');
INSERT INTO `by_member_detail_aud` VALUES ('549', null, null, null, null, null, null, '2016-09-20 18:03:16', null, null, null, '976', '0');
INSERT INTO `by_member_detail_aud` VALUES ('550', null, null, null, null, null, null, '2016-09-20 21:08:25', null, null, null, '977', '0');
INSERT INTO `by_member_detail_aud` VALUES ('551', null, null, null, null, null, null, '2016-09-20 21:53:05', null, null, null, '978', '0');
INSERT INTO `by_member_detail_aud` VALUES ('552', null, null, null, null, null, null, '2016-09-21 12:48:32', null, null, null, '979', '0');
INSERT INTO `by_member_detail_aud` VALUES ('553', null, null, null, null, null, null, '2016-09-21 21:11:56', null, null, null, '980', '0');
INSERT INTO `by_member_detail_aud` VALUES ('554', null, null, null, null, null, null, '2016-09-22 10:49:00', null, null, null, '981', '0');
INSERT INTO `by_member_detail_aud` VALUES ('554', '赵飞', '', null, null, null, '', '2016-09-22 10:49:00', '2016-09-22 10:49:25', null, null, '982', '1');
INSERT INTO `by_member_detail_aud` VALUES ('555', null, null, null, null, null, null, '2016-09-22 11:04:03', null, null, null, '983', '0');
INSERT INTO `by_member_detail_aud` VALUES ('556', null, null, null, null, null, null, '2016-09-22 15:55:37', null, null, null, '984', '0');
INSERT INTO `by_member_detail_aud` VALUES ('557', null, null, null, null, null, null, '2016-09-22 16:40:41', null, null, null, '985', '0');
INSERT INTO `by_member_detail_aud` VALUES ('558', null, null, null, null, null, null, '2016-09-22 16:43:14', null, null, null, '986', '0');
INSERT INTO `by_member_detail_aud` VALUES ('559', null, null, null, null, null, null, '2016-09-22 17:56:18', null, null, null, '987', '0');
INSERT INTO `by_member_detail_aud` VALUES ('559', '徐豪', '', null, '1994-09-12 00:00:00', null, '', '2016-09-22 17:56:18', '2016-09-22 17:56:47', null, null, '988', '1');
INSERT INTO `by_member_detail_aud` VALUES ('560', null, null, null, null, null, null, '2016-09-22 19:48:56', null, null, null, '989', '0');
INSERT INTO `by_member_detail_aud` VALUES ('560', '', '', null, null, null, '', '2016-09-22 19:48:56', '2016-09-22 19:49:53', null, null, '990', '1');
INSERT INTO `by_member_detail_aud` VALUES ('561', null, null, null, null, null, null, '2016-09-22 20:12:07', null, null, null, '991', '0');
INSERT INTO `by_member_detail_aud` VALUES ('562', null, null, null, null, null, null, '2016-09-22 21:18:05', null, null, null, '992', '0');
INSERT INTO `by_member_detail_aud` VALUES ('563', null, null, null, null, null, null, '2016-09-22 22:09:53', null, null, null, '993', '0');
INSERT INTO `by_member_detail_aud` VALUES ('563', null, null, '1814a3fa28024f49b7c01e4d96d2006a78275005345b0890e235488327f8ece6', null, null, null, '2016-09-22 22:09:53', '2016-09-22 22:11:07', null, null, '994', '1');
INSERT INTO `by_member_detail_aud` VALUES ('563', '', '', '1814a3fa28024f49b7c01e4d96d2006a78275005345b0890e235488327f8ece6', null, null, '', '2016-09-22 22:09:53', '2016-09-22 22:11:22', null, null, '995', '1');
INSERT INTO `by_member_detail_aud` VALUES ('564', null, null, null, null, null, null, '2016-09-23 06:31:16', null, null, null, '996', '0');
INSERT INTO `by_member_detail_aud` VALUES ('565', null, null, null, null, null, null, '2016-09-23 10:49:46', null, null, null, '997', '0');
INSERT INTO `by_member_detail_aud` VALUES ('565', '王晓苹', '浦东新区巨峰路1058弄3号1213室', null, '1980-10-26 00:00:00', null, '230811198010260028', '2016-09-23 10:49:46', '2016-09-23 10:52:20', null, null, '998', '1');
INSERT INTO `by_member_detail_aud` VALUES ('566', null, null, null, null, null, null, '2016-09-23 10:53:49', null, null, null, '999', '0');
INSERT INTO `by_member_detail_aud` VALUES ('566', '陶丽萍', '凌河路188弄83号601室', null, '1979-08-30 00:00:00', null, '310113197908305720', '2016-09-23 10:53:49', '2016-09-23 10:55:12', null, null, '1000', '1');
INSERT INTO `by_member_detail_aud` VALUES ('567', null, null, null, null, null, null, '2016-09-23 12:27:29', null, null, null, '1001', '0');
INSERT INTO `by_member_detail_aud` VALUES ('568', null, null, null, null, null, null, '2016-09-23 12:51:45', null, null, null, '1002', '0');
INSERT INTO `by_member_detail_aud` VALUES ('568', '', '东陆路2000弄7号1401室', null, null, null, '', '2016-09-23 12:51:45', '2016-09-23 12:52:51', null, null, '1003', '1');
INSERT INTO `by_member_detail_aud` VALUES ('568', '', '东陆路2000弄7号1401室', null, '2016-12-31 00:00:00', null, '', '2016-09-23 12:51:45', '2016-09-23 12:53:21', null, null, '1004', '1');
INSERT INTO `by_member_detail_aud` VALUES ('569', null, null, null, null, null, null, '2016-09-23 14:34:27', null, null, null, '1005', '0');
INSERT INTO `by_member_detail_aud` VALUES ('570', null, null, null, null, null, null, '2016-09-23 15:11:47', null, null, null, '1006', '0');
INSERT INTO `by_member_detail_aud` VALUES ('571', null, null, null, null, null, null, '2016-09-23 17:28:01', null, null, null, '1007', '0');
INSERT INTO `by_member_detail_aud` VALUES ('572', null, null, null, null, null, null, '2016-09-23 17:51:55', null, null, null, '1008', '0');
INSERT INTO `by_member_detail_aud` VALUES ('573', null, null, null, null, null, null, '2016-09-23 19:48:24', null, null, null, '1009', '0');
INSERT INTO `by_member_detail_aud` VALUES ('573', '', '', null, '1989-01-22 00:00:00', null, '310107198901222516', '2016-09-23 19:48:24', '2016-09-23 19:49:01', null, null, '1010', '1');
INSERT INTO `by_member_detail_aud` VALUES ('574', null, null, null, null, null, null, '2016-09-23 20:03:49', null, null, null, '1011', '0');
INSERT INTO `by_member_detail_aud` VALUES ('575', null, null, null, null, null, null, '2016-09-23 20:59:16', null, null, null, '1012', '0');
INSERT INTO `by_member_detail_aud` VALUES ('576', null, null, null, null, null, null, '2016-09-23 21:34:04', null, null, null, '1013', '0');
INSERT INTO `by_member_detail_aud` VALUES ('577', null, null, null, null, null, null, '2016-09-24 09:03:26', null, null, null, '1014', '0');
INSERT INTO `by_member_detail_aud` VALUES ('577', '', '', null, '1987-12-24 00:00:00', null, '', '2016-09-24 09:03:26', '2016-09-24 09:04:51', null, null, '1015', '1');
INSERT INTO `by_member_detail_aud` VALUES ('578', null, null, null, null, null, null, '2016-09-24 12:20:46', null, null, null, '1016', '0');
INSERT INTO `by_member_detail_aud` VALUES ('578', null, null, 'c8f6f7e77f6585df16f61c79f0729b2f39feaac629e40bd59d52dd5183348e1e', null, null, null, '2016-09-24 12:20:46', '2016-09-24 12:22:36', null, null, '1017', '1');
INSERT INTO `by_member_detail_aud` VALUES ('578', '', '佳林路962弄', 'c8f6f7e77f6585df16f61c79f0729b2f39feaac629e40bd59d52dd5183348e1e', '1981-09-06 00:00:00', null, '370502198109060817', '2016-09-24 12:20:46', '2016-09-24 12:23:28', null, null, '1018', '1');
INSERT INTO `by_member_detail_aud` VALUES ('578', '周红伟', '佳林路962弄', 'c8f6f7e77f6585df16f61c79f0729b2f39feaac629e40bd59d52dd5183348e1e', '1981-09-06 00:00:00', null, '370502198109060817', '2016-09-24 12:20:46', '2016-09-24 12:23:54', null, null, '1019', '1');
INSERT INTO `by_member_detail_aud` VALUES ('579', null, null, null, null, null, null, '2016-09-24 12:51:11', null, null, null, '1020', '0');
INSERT INTO `by_member_detail_aud` VALUES ('580', null, null, null, null, null, null, '2016-09-24 13:31:30', null, null, null, '1021', '0');
INSERT INTO `by_member_detail_aud` VALUES ('581', null, null, null, null, null, null, '2016-09-24 13:41:19', null, null, null, '1022', '0');
INSERT INTO `by_member_detail_aud` VALUES ('582', null, null, null, null, null, null, '2016-09-24 13:52:52', null, null, null, '1023', '0');
INSERT INTO `by_member_detail_aud` VALUES ('583', null, null, null, null, null, null, '2016-09-24 14:32:02', null, null, null, '1024', '0');
INSERT INTO `by_member_detail_aud` VALUES ('583', null, null, '2b40a4440c72f5396f70fc831d1f74671124dddcab6d4a18b7fc652ae8aca1e4', null, null, null, '2016-09-24 14:32:02', '2016-09-24 14:33:23', null, null, '1025', '1');
INSERT INTO `by_member_detail_aud` VALUES ('583', '陆燕雯', '浦东衡安路1058号', '2b40a4440c72f5396f70fc831d1f74671124dddcab6d4a18b7fc652ae8aca1e4', '1985-10-25 00:00:00', null, '310115198510254414', '2016-09-24 14:32:02', '2016-09-24 14:34:03', null, null, '1026', '1');
INSERT INTO `by_member_detail_aud` VALUES ('584', null, null, null, null, null, null, '2016-09-24 14:48:05', null, null, null, '1027', '0');
INSERT INTO `by_member_detail_aud` VALUES ('585', null, null, null, null, null, null, '2016-09-24 16:40:27', null, null, null, '1028', '0');
INSERT INTO `by_member_detail_aud` VALUES ('585', '沈', '', null, null, null, '', '2016-09-24 16:40:27', '2016-09-24 16:41:16', null, null, '1029', '1');
INSERT INTO `by_member_detail_aud` VALUES ('586', null, null, null, null, null, null, '2016-09-24 18:22:11', null, null, null, '1030', '0');
INSERT INTO `by_member_detail_aud` VALUES ('587', null, null, null, null, null, null, '2016-09-24 18:45:42', null, null, null, '1031', '0');
INSERT INTO `by_member_detail_aud` VALUES ('587', '韩羽', '', null, '1983-09-20 00:00:00', null, '', '2016-09-24 18:45:42', '2016-09-24 18:46:14', null, null, '1032', '1');
INSERT INTO `by_member_detail_aud` VALUES ('588', null, null, null, null, null, null, '2016-09-24 22:47:15', null, null, null, '1033', '0');
INSERT INTO `by_member_detail_aud` VALUES ('589', null, null, null, null, null, null, '2016-09-24 23:05:12', null, null, null, '1034', '0');
INSERT INTO `by_member_detail_aud` VALUES ('590', null, null, null, null, null, null, '2016-09-25 05:38:54', null, null, null, '1035', '0');
INSERT INTO `by_member_detail_aud` VALUES ('590', null, null, '2e6bc195f88bd253f4250b75ba1eb64738daffd001cdfa54763b0cac4f63f59c', null, null, null, '2016-09-25 05:38:54', '2016-09-25 05:43:33', null, null, '1036', '1');
INSERT INTO `by_member_detail_aud` VALUES ('591', null, null, null, null, null, null, '2016-09-25 11:26:19', null, null, null, '1037', '0');
INSERT INTO `by_member_detail_aud` VALUES ('592', null, null, null, null, null, null, '2016-09-25 11:32:00', null, null, null, '1038', '0');
INSERT INTO `by_member_detail_aud` VALUES ('593', null, null, null, null, null, null, '2016-09-25 11:38:13', null, null, null, '1039', '0');
INSERT INTO `by_member_detail_aud` VALUES ('594', null, null, null, null, null, null, '2016-09-25 12:22:04', null, null, null, '1040', '0');
INSERT INTO `by_member_detail_aud` VALUES ('594', '沈一葵', '', null, '1974-08-11 00:00:00', null, '310224197408114711', '2016-09-25 12:22:04', '2016-09-25 12:22:55', null, null, '1041', '1');
INSERT INTO `by_member_detail_aud` VALUES ('595', null, null, null, null, null, null, '2016-09-25 14:52:19', null, null, null, '1042', '0');
INSERT INTO `by_member_detail_aud` VALUES ('595', '', '', null, '1984-02-11 00:00:00', null, '', '2016-09-25 14:52:19', '2016-09-25 14:53:20', null, null, '1043', '1');
INSERT INTO `by_member_detail_aud` VALUES ('596', null, null, null, null, null, null, '2016-09-25 17:05:06', null, null, null, '1044', '0');
INSERT INTO `by_member_detail_aud` VALUES ('597', null, null, null, null, null, null, '2016-09-25 17:45:12', null, null, null, '1045', '0');
INSERT INTO `by_member_detail_aud` VALUES ('598', null, null, null, null, null, null, '2016-09-25 17:55:29', null, null, null, '1046', '0');
INSERT INTO `by_member_detail_aud` VALUES ('599', null, null, null, null, null, null, '2016-09-25 17:57:35', null, null, null, '1047', '0');
INSERT INTO `by_member_detail_aud` VALUES ('600', null, null, null, null, null, null, '2016-09-25 18:02:31', null, null, null, '1048', '0');
INSERT INTO `by_member_detail_aud` VALUES ('600', '', '', null, null, null, '', '2016-09-25 18:02:31', '2016-09-25 18:03:02', null, null, '1049', '1');
INSERT INTO `by_member_detail_aud` VALUES ('601', null, null, null, null, null, null, '2016-09-25 18:08:16', null, null, null, '1050', '0');
INSERT INTO `by_member_detail_aud` VALUES ('602', null, null, null, null, null, null, '2016-09-25 18:24:15', null, null, null, '1051', '0');
INSERT INTO `by_member_detail_aud` VALUES ('602', '', '东陆路2000弄18号902室', null, null, null, '', '2016-09-25 18:24:15', '2016-09-25 18:26:05', null, null, '1052', '1');
INSERT INTO `by_member_detail_aud` VALUES ('603', null, null, null, null, null, null, '2016-09-25 18:56:12', null, null, null, '1053', '0');
INSERT INTO `by_member_detail_aud` VALUES ('604', null, null, null, null, null, null, '2016-09-25 21:39:39', null, null, null, '1054', '0');
INSERT INTO `by_member_detail_aud` VALUES ('605', null, null, null, null, null, null, '2016-09-26 18:51:37', null, null, null, '1055', '0');
INSERT INTO `by_member_detail_aud` VALUES ('606', null, null, null, null, null, null, '2016-09-27 12:15:52', null, null, null, '1056', '0');
INSERT INTO `by_member_detail_aud` VALUES ('607', null, null, null, null, null, null, '2016-09-27 15:22:09', null, null, null, '1057', '0');
INSERT INTO `by_member_detail_aud` VALUES ('608', null, null, null, null, null, null, '2016-09-27 18:35:44', null, null, null, '1058', '0');
INSERT INTO `by_member_detail_aud` VALUES ('609', null, null, null, null, null, null, '2016-09-27 21:12:12', null, null, null, '1059', '0');
INSERT INTO `by_member_detail_aud` VALUES ('610', null, null, null, null, null, null, '2016-09-27 21:49:27', null, null, null, '1060', '0');
INSERT INTO `by_member_detail_aud` VALUES ('611', null, null, null, null, null, null, '2016-09-27 21:54:30', null, null, null, '1061', '0');
INSERT INTO `by_member_detail_aud` VALUES ('612', null, null, null, null, null, null, '2016-09-28 15:50:14', null, null, null, '1062', '0');
INSERT INTO `by_member_detail_aud` VALUES ('612', '张小姐', '', null, '1991-07-31 23:00:00', null, '', '2016-09-28 15:50:14', '2016-09-28 15:50:55', null, null, '1063', '1');
INSERT INTO `by_member_detail_aud` VALUES ('613', null, null, null, null, null, null, '2016-09-28 16:55:45', null, null, null, '1064', '0');
INSERT INTO `by_member_detail_aud` VALUES ('614', null, null, null, null, null, null, '2016-09-28 17:59:28', null, null, null, '1065', '0');
INSERT INTO `by_member_detail_aud` VALUES ('614', '沈军', '', null, '1985-07-28 00:00:00', null, '310115198507280013', '2016-09-28 17:59:28', '2016-09-28 18:00:21', null, null, '1066', '1');
INSERT INTO `by_member_detail_aud` VALUES ('615', null, null, null, null, null, null, '2016-09-28 22:31:57', null, null, null, '1067', '0');
INSERT INTO `by_member_detail_aud` VALUES ('615', '黄佳丽', '', null, '1993-11-24 00:00:00', null, '', '2016-09-28 22:31:57', '2016-09-28 22:33:01', null, null, '1068', '1');
INSERT INTO `by_member_detail_aud` VALUES ('616', null, null, null, null, null, null, '2016-09-29 12:41:35', null, null, null, '1069', '0');
INSERT INTO `by_member_detail_aud` VALUES ('616', null, null, 'cf4f77699eec976a0f0e1371ad641994f03491ad4a8687f00442b2496a50feb6', null, null, null, '2016-09-29 12:41:35', '2016-09-29 12:42:56', null, null, '1071', '1');
INSERT INTO `by_member_detail_aud` VALUES ('616', '', '永业路225弄15号401', 'cf4f77699eec976a0f0e1371ad641994f03491ad4a8687f00442b2496a50feb6', '1988-08-09 23:00:00', null, '371322198808104933', '2016-09-29 12:41:35', '2016-09-29 12:43:37', null, null, '1073', '1');
INSERT INTO `by_member_detail_aud` VALUES ('617', null, null, null, null, null, null, '2016-09-29 12:42:55', null, null, null, '1070', '0');
INSERT INTO `by_member_detail_aud` VALUES ('618', null, null, null, null, null, null, '2016-09-29 12:43:24', null, null, null, '1072', '0');
INSERT INTO `by_member_detail_aud` VALUES ('619', null, null, null, null, null, null, '2016-09-29 12:46:04', null, null, null, '1074', '0');
INSERT INTO `by_member_detail_aud` VALUES ('620', null, null, null, null, null, null, '2016-09-29 12:46:05', null, null, null, '1075', '0');
INSERT INTO `by_member_detail_aud` VALUES ('620', '黄先', '', null, '2016-09-29 00:00:00', null, '', '2016-09-29 12:46:05', '2016-09-29 12:46:55', null, null, '1076', '1');
INSERT INTO `by_member_detail_aud` VALUES ('621', null, null, null, null, null, null, '2016-09-29 12:49:06', null, null, null, '1077', '0');
INSERT INTO `by_member_detail_aud` VALUES ('622', null, null, null, null, null, null, '2016-09-29 12:52:29', null, null, null, '1078', '0');
INSERT INTO `by_member_detail_aud` VALUES ('623', null, null, null, null, null, null, '2016-09-29 12:59:55', null, null, null, '1079', '0');
INSERT INTO `by_member_detail_aud` VALUES ('624', null, null, null, null, null, null, '2016-09-29 13:17:31', null, null, null, '1080', '0');
INSERT INTO `by_member_detail_aud` VALUES ('625', null, null, null, null, null, null, '2016-09-29 13:43:43', null, null, null, '1082', '0');
INSERT INTO `by_member_detail_aud` VALUES ('626', null, null, null, null, null, null, '2016-09-29 13:52:46', null, null, null, '1083', '0');
INSERT INTO `by_member_detail_aud` VALUES ('626', '张慈婕', '', null, null, null, '', '2016-09-29 13:52:46', '2016-09-29 13:53:15', null, null, '1084', '1');
INSERT INTO `by_member_detail_aud` VALUES ('627', null, null, null, null, null, null, '2016-09-29 14:23:24', null, null, null, '1085', '0');
INSERT INTO `by_member_detail_aud` VALUES ('627', '张晓丽', '杨高北路5291弄23号502室', null, '1973-09-03 00:00:00', null, '', '2016-09-29 14:23:24', '2016-09-29 14:27:51', null, null, '1086', '1');
INSERT INTO `by_member_detail_aud` VALUES ('628', null, null, null, null, null, null, '2016-09-29 14:29:42', null, null, null, '1087', '0');
INSERT INTO `by_member_detail_aud` VALUES ('628', '陈芳', '高东镇光明路', null, '1987-05-03 23:00:00', null, '310115198705040424', '2016-09-29 14:29:42', '2016-11-07 00:07:45', null, null, '1451', '1');
INSERT INTO `by_member_detail_aud` VALUES ('629', null, null, null, null, null, null, '2016-09-29 15:26:51', null, null, null, '1088', '0');
INSERT INTO `by_member_detail_aud` VALUES ('630', null, null, null, null, null, null, '2016-09-29 16:06:33', null, null, null, '1089', '0');
INSERT INTO `by_member_detail_aud` VALUES ('631', null, null, null, null, null, null, '2016-09-29 16:10:20', null, null, null, '1090', '0');
INSERT INTO `by_member_detail_aud` VALUES ('632', null, null, null, null, null, null, '2016-09-29 16:55:28', null, null, null, '1091', '0');
INSERT INTO `by_member_detail_aud` VALUES ('633', null, null, null, null, null, null, '2016-09-29 17:00:02', null, null, null, '1092', '0');
INSERT INTO `by_member_detail_aud` VALUES ('634', null, null, null, null, null, null, '2016-09-29 18:39:26', null, null, null, '1093', '0');
INSERT INTO `by_member_detail_aud` VALUES ('635', null, null, null, null, null, null, '2016-09-29 18:40:14', null, null, null, '1094', '0');
INSERT INTO `by_member_detail_aud` VALUES ('636', null, null, null, null, null, null, '2016-09-29 18:56:57', null, null, null, '1095', '0');
INSERT INTO `by_member_detail_aud` VALUES ('637', null, null, null, null, null, null, '2016-09-30 11:01:47', null, null, null, '1099', '0');
INSERT INTO `by_member_detail_aud` VALUES ('638', null, null, null, null, null, null, '2016-09-30 11:09:17', null, null, null, '1100', '0');
INSERT INTO `by_member_detail_aud` VALUES ('639', null, null, null, null, null, null, '2016-09-30 17:18:39', null, null, null, '1101', '0');
INSERT INTO `by_member_detail_aud` VALUES ('640', null, null, null, null, null, null, '2016-09-30 18:34:09', null, null, null, '1102', '0');
INSERT INTO `by_member_detail_aud` VALUES ('641', null, null, null, null, null, null, '2016-09-30 20:21:29', null, null, null, '1103', '0');
INSERT INTO `by_member_detail_aud` VALUES ('642', null, null, null, null, null, null, '2016-10-01 08:28:26', null, null, null, '1104', '0');
INSERT INTO `by_member_detail_aud` VALUES ('643', null, null, null, null, null, null, '2016-10-01 10:39:39', null, null, null, '1105', '0');
INSERT INTO `by_member_detail_aud` VALUES ('644', null, null, null, null, null, null, '2016-10-01 10:54:51', null, null, null, '1106', '0');
INSERT INTO `by_member_detail_aud` VALUES ('645', null, null, null, null, null, null, '2016-10-01 10:57:12', null, null, null, '1107', '0');
INSERT INTO `by_member_detail_aud` VALUES ('646', null, null, null, null, null, null, '2016-10-01 11:45:42', null, null, null, '1108', '0');
INSERT INTO `by_member_detail_aud` VALUES ('647', null, null, null, null, null, null, '2016-10-01 11:56:00', null, null, null, '1109', '0');
INSERT INTO `by_member_detail_aud` VALUES ('648', null, null, null, null, null, null, '2016-10-01 12:18:54', null, null, null, '1110', '0');
INSERT INTO `by_member_detail_aud` VALUES ('649', null, null, null, null, null, null, '2016-10-01 12:21:33', null, null, null, '1111', '0');
INSERT INTO `by_member_detail_aud` VALUES ('650', null, null, null, null, null, null, '2016-10-01 12:59:29', null, null, null, '1113', '0');
INSERT INTO `by_member_detail_aud` VALUES ('651', null, null, null, null, null, null, '2016-10-01 14:02:55', null, null, null, '1114', '0');
INSERT INTO `by_member_detail_aud` VALUES ('652', null, null, null, null, null, null, '2016-10-01 14:17:23', null, null, null, '1115', '0');
INSERT INTO `by_member_detail_aud` VALUES ('653', null, null, null, null, null, null, '2016-10-01 14:26:37', null, null, null, '1116', '0');
INSERT INTO `by_member_detail_aud` VALUES ('654', null, null, null, null, null, null, '2016-10-01 15:08:36', null, null, null, '1117', '0');
INSERT INTO `by_member_detail_aud` VALUES ('654', null, null, '32541d9629d804b37e379c6c5afea785d3bc822605bf792d6ab38205bb32a1ae', null, null, null, '2016-10-01 15:08:36', '2016-10-01 15:09:35', null, null, '1118', '1');
INSERT INTO `by_member_detail_aud` VALUES ('654', '', '', '32541d9629d804b37e379c6c5afea785d3bc822605bf792d6ab38205bb32a1ae', '1983-04-16 00:00:00', null, '310107198304167213', '2016-10-01 15:08:36', '2016-10-01 15:09:50', null, null, '1119', '1');
INSERT INTO `by_member_detail_aud` VALUES ('655', null, null, null, null, null, null, '2016-10-01 15:14:16', null, null, null, '1120', '0');
INSERT INTO `by_member_detail_aud` VALUES ('656', null, null, null, null, null, null, '2016-10-01 18:22:55', null, null, null, '1121', '0');
INSERT INTO `by_member_detail_aud` VALUES ('656', null, null, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, null, null, '2016-10-01 18:22:55', '2016-10-01 18:25:14', null, null, '1122', '1');
INSERT INTO `by_member_detail_aud` VALUES ('656', '', '', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, null, '', '2016-10-01 18:22:55', '2016-10-01 18:25:23', null, null, '1123', '1');
INSERT INTO `by_member_detail_aud` VALUES ('657', null, null, null, null, null, null, '2016-10-01 18:35:23', null, null, null, '1124', '0');
INSERT INTO `by_member_detail_aud` VALUES ('657', '', '', null, '1979-03-20 00:00:00', null, '', '2016-10-01 18:35:23', '2016-10-01 18:36:46', null, null, '1125', '1');
INSERT INTO `by_member_detail_aud` VALUES ('658', null, null, null, null, null, null, '2016-10-01 18:38:15', null, null, null, '1126', '0');
INSERT INTO `by_member_detail_aud` VALUES ('659', null, null, null, null, null, null, '2016-10-01 20:19:56', null, null, null, '1127', '0');
INSERT INTO `by_member_detail_aud` VALUES ('660', null, null, null, null, null, null, '2016-10-02 07:14:44', null, null, null, '1128', '0');
INSERT INTO `by_member_detail_aud` VALUES ('661', null, null, null, null, null, null, '2016-10-02 10:32:50', null, null, null, '1129', '0');
INSERT INTO `by_member_detail_aud` VALUES ('662', null, null, null, null, null, null, '2016-10-02 11:19:22', null, null, null, '1130', '0');
INSERT INTO `by_member_detail_aud` VALUES ('662', '', '', null, null, null, '', '2016-10-02 11:19:22', '2016-10-02 11:19:51', null, null, '1131', '1');
INSERT INTO `by_member_detail_aud` VALUES ('663', null, null, null, null, null, null, '2016-10-02 12:04:04', null, null, null, '1132', '0');
INSERT INTO `by_member_detail_aud` VALUES ('664', null, null, null, null, null, null, '2016-10-02 12:44:01', null, null, null, '1133', '0');
INSERT INTO `by_member_detail_aud` VALUES ('665', null, null, null, null, null, null, '2016-10-02 14:40:07', null, null, null, '1134', '0');
INSERT INTO `by_member_detail_aud` VALUES ('666', null, null, null, null, null, null, '2016-10-02 14:43:34', null, null, null, '1135', '0');
INSERT INTO `by_member_detail_aud` VALUES ('667', null, null, null, null, null, null, '2016-10-02 17:23:14', null, null, null, '1136', '0');
INSERT INTO `by_member_detail_aud` VALUES ('668', null, null, null, null, null, null, '2016-10-02 17:45:36', null, null, null, '1137', '0');
INSERT INTO `by_member_detail_aud` VALUES ('669', null, null, null, null, null, null, '2016-10-02 19:32:15', null, null, null, '1138', '0');
INSERT INTO `by_member_detail_aud` VALUES ('670', null, null, null, null, null, null, '2016-10-02 20:50:28', null, null, null, '1139', '0');
INSERT INTO `by_member_detail_aud` VALUES ('671', null, null, null, null, null, null, '2016-10-02 20:55:23', null, null, null, '1140', '0');
INSERT INTO `by_member_detail_aud` VALUES ('672', null, null, null, null, null, null, '2016-10-02 22:00:18', null, null, null, '1141', '0');
INSERT INTO `by_member_detail_aud` VALUES ('673', null, null, null, null, null, null, '2016-10-03 10:22:13', null, null, null, '1142', '0');
INSERT INTO `by_member_detail_aud` VALUES ('673', '', '', null, null, null, '', '2016-10-03 10:22:13', '2016-10-03 10:22:29', null, null, '1143', '1');
INSERT INTO `by_member_detail_aud` VALUES ('674', null, null, null, null, null, null, '2016-10-03 12:16:01', null, null, null, '1144', '0');
INSERT INTO `by_member_detail_aud` VALUES ('675', null, null, null, null, null, null, '2016-10-03 12:24:41', null, null, null, '1145', '0');
INSERT INTO `by_member_detail_aud` VALUES ('676', null, null, null, null, null, null, '2016-10-03 19:35:45', null, null, null, '1146', '0');
INSERT INTO `by_member_detail_aud` VALUES ('677', null, null, null, null, null, null, '2016-10-04 11:02:04', null, null, null, '1148', '0');
INSERT INTO `by_member_detail_aud` VALUES ('677', '', '金高路988弄23号501', null, '1986-04-09 00:00:00', null, '', '2016-10-04 11:02:04', '2016-10-04 11:03:44', null, null, '1149', '1');
INSERT INTO `by_member_detail_aud` VALUES ('678', null, null, null, null, null, null, '2016-10-04 13:03:10', null, null, null, '1150', '0');
INSERT INTO `by_member_detail_aud` VALUES ('679', null, null, null, null, null, null, '2016-10-04 14:41:21', null, null, null, '1151', '0');
INSERT INTO `by_member_detail_aud` VALUES ('679', '', '', null, '1985-06-28 00:00:00', null, '', '2016-10-04 14:41:21', '2016-10-04 22:41:21', null, null, '1164', '1');
INSERT INTO `by_member_detail_aud` VALUES ('680', null, null, null, null, null, null, '2016-10-04 15:47:21', null, null, null, '1152', '0');
INSERT INTO `by_member_detail_aud` VALUES ('680', null, null, 'a49c8bcd665c11756dfab519ac4dc2b94603167849a27cc1a0f1642660d07d42', null, null, null, '2016-10-04 15:47:21', '2016-10-04 15:51:37', null, null, '1153', '1');
INSERT INTO `by_member_detail_aud` VALUES ('680', '', '金高路1051弄10号501室', 'a49c8bcd665c11756dfab519ac4dc2b94603167849a27cc1a0f1642660d07d42', '1997-03-13 00:00:00', null, '310115199703130420', '2016-10-04 15:47:21', '2016-10-04 15:52:30', null, null, '1154', '1');
INSERT INTO `by_member_detail_aud` VALUES ('681', null, null, null, null, null, null, '2016-10-04 17:19:02', null, null, null, '1155', '0');
INSERT INTO `by_member_detail_aud` VALUES ('681', '张', '', null, null, null, '', '2016-10-04 17:19:02', '2016-10-04 17:19:30', null, null, '1156', '1');
INSERT INTO `by_member_detail_aud` VALUES ('682', null, null, null, null, null, null, '2016-10-04 18:33:24', null, null, null, '1157', '0');
INSERT INTO `by_member_detail_aud` VALUES ('683', null, null, null, null, null, null, '2016-10-04 18:37:34', null, null, null, '1158', '0');
INSERT INTO `by_member_detail_aud` VALUES ('683', '孙诗雯', '', null, null, null, '', '2016-10-04 18:37:34', '2016-10-04 18:38:05', null, null, '1159', '1');
INSERT INTO `by_member_detail_aud` VALUES ('684', null, null, null, null, null, null, '2016-10-04 18:53:26', null, null, null, '1160', '0');
INSERT INTO `by_member_detail_aud` VALUES ('685', null, null, null, null, null, null, '2016-10-04 20:03:25', null, null, null, '1161', '0');
INSERT INTO `by_member_detail_aud` VALUES ('686', null, null, null, null, null, null, '2016-10-04 20:23:41', null, null, null, '1162', '0');
INSERT INTO `by_member_detail_aud` VALUES ('687', null, null, null, null, null, null, '2016-10-04 21:09:21', null, null, null, '1163', '0');
INSERT INTO `by_member_detail_aud` VALUES ('688', null, null, null, null, null, null, '2016-10-05 10:05:39', null, null, null, '1165', '0');
INSERT INTO `by_member_detail_aud` VALUES ('689', null, null, null, null, null, null, '2016-10-05 11:08:37', null, null, null, '1166', '0');
INSERT INTO `by_member_detail_aud` VALUES ('689', '', '金桥太茂', null, '2016-10-05 00:00:00', null, '', '2016-10-05 11:08:37', '2016-10-05 11:09:45', null, null, '1167', '1');
INSERT INTO `by_member_detail_aud` VALUES ('690', null, null, null, null, null, null, '2016-10-05 16:44:39', null, null, null, '1169', '0');
INSERT INTO `by_member_detail_aud` VALUES ('691', null, null, null, null, null, null, '2016-10-05 17:28:57', null, null, null, '1170', '0');
INSERT INTO `by_member_detail_aud` VALUES ('692', null, null, null, null, null, null, '2016-10-05 18:19:13', null, null, null, '1171', '0');
INSERT INTO `by_member_detail_aud` VALUES ('693', null, null, null, null, null, null, '2016-10-05 18:29:48', null, null, null, '1172', '0');
INSERT INTO `by_member_detail_aud` VALUES ('694', null, null, null, null, null, null, '2016-10-05 19:02:29', null, null, null, '1173', '0');
INSERT INTO `by_member_detail_aud` VALUES ('694', null, null, '4f212ecce2a888ca9b2ad58c5aa09426e43db2efb7c80afe4ccd99b67ee59d20', null, null, null, '2016-10-05 19:02:29', '2016-10-05 19:05:03', null, null, '1174', '1');
INSERT INTO `by_member_detail_aud` VALUES ('694', '王佳炜', '', '4f212ecce2a888ca9b2ad58c5aa09426e43db2efb7c80afe4ccd99b67ee59d20', '1989-12-14 00:00:00', null, '310115198912140452', '2016-10-05 19:02:29', '2016-10-05 19:05:22', null, null, '1175', '1');
INSERT INTO `by_member_detail_aud` VALUES ('695', null, null, null, null, null, null, '2016-10-05 19:43:17', null, null, null, '1176', '0');
INSERT INTO `by_member_detail_aud` VALUES ('696', null, null, null, null, null, null, '2016-10-06 11:52:39', null, null, null, '1177', '0');
INSERT INTO `by_member_detail_aud` VALUES ('696', '叶琳', '', null, '1982-04-13 00:00:00', null, '310115198204131141', '2016-10-06 11:52:39', '2016-10-06 11:53:09', null, null, '1178', '1');
INSERT INTO `by_member_detail_aud` VALUES ('697', null, null, null, null, null, null, '2016-10-06 12:08:40', null, null, null, '1179', '0');
INSERT INTO `by_member_detail_aud` VALUES ('697', null, null, '820912db1a651265b9df4b243c7de3fa3d0f27e1f359752801a2dad05873aee4', null, null, null, '2016-10-06 12:08:40', '2016-10-06 12:09:37', null, null, '1180', '1');
INSERT INTO `by_member_detail_aud` VALUES ('697', '俞晨', '', '820912db1a651265b9df4b243c7de3fa3d0f27e1f359752801a2dad05873aee4', '2000-02-24 00:00:00', null, '310115200002246127', '2016-10-06 12:08:40', '2016-10-06 12:10:16', null, null, '1181', '1');
INSERT INTO `by_member_detail_aud` VALUES ('698', null, null, null, null, null, null, '2016-10-06 12:41:59', null, null, null, '1182', '0');
INSERT INTO `by_member_detail_aud` VALUES ('698', null, null, '6e3da59bb00a82c3222d8dbeb62c5e0922c2ce4d9aff5b98e3f0bbaa6aba32ae', null, null, null, '2016-10-06 12:41:59', '2016-10-06 12:44:52', null, null, '1183', '1');
INSERT INTO `by_member_detail_aud` VALUES ('698', '', '申江路881弄3号', '6e3da59bb00a82c3222d8dbeb62c5e0922c2ce4d9aff5b98e3f0bbaa6aba32ae', '1983-07-18 00:00:00', null, '310115198307186110', '2016-10-06 12:41:59', '2016-10-06 12:45:25', null, null, '1184', '1');
INSERT INTO `by_member_detail_aud` VALUES ('699', null, null, null, null, null, null, '2016-10-06 14:23:15', null, null, null, '1185', '0');
INSERT INTO `by_member_detail_aud` VALUES ('699', '徐伟灵', '佳京路99弄138号\n', null, '1984-11-15 00:00:00', null, '310115198411151014', '2016-10-06 14:23:15', '2016-10-06 14:26:44', null, null, '1186', '1');
INSERT INTO `by_member_detail_aud` VALUES ('700', null, null, null, null, null, null, '2016-10-06 14:56:43', null, null, null, '1187', '0');
INSERT INTO `by_member_detail_aud` VALUES ('701', null, null, null, null, null, null, '2016-10-06 14:59:24', null, null, null, '1188', '0');
INSERT INTO `by_member_detail_aud` VALUES ('702', null, null, null, null, null, null, '2016-10-06 16:06:44', null, null, null, '1189', '0');
INSERT INTO `by_member_detail_aud` VALUES ('702', null, null, '98765ab7605178acc7e50697d980be4568d7cf3de9114baa1574a6a093c21ff9', null, null, null, '2016-10-06 16:06:44', '2016-10-06 20:44:53', null, null, '1199', '1');
INSERT INTO `by_member_detail_aud` VALUES ('702', '', '佳林路898弄12号502', '98765ab7605178acc7e50697d980be4568d7cf3de9114baa1574a6a093c21ff9', '1989-09-12 23:00:00', null, '310230198909135360', '2016-10-06 16:06:44', '2016-10-06 20:45:43', null, null, '1200', '1');
INSERT INTO `by_member_detail_aud` VALUES ('703', null, null, null, null, null, null, '2016-10-06 16:10:30', null, null, null, '1190', '0');
INSERT INTO `by_member_detail_aud` VALUES ('704', null, null, null, null, null, null, '2016-10-06 16:35:15', null, null, null, '1191', '0');
INSERT INTO `by_member_detail_aud` VALUES ('704', '', '', null, null, null, '', '2016-10-06 16:35:15', '2016-10-06 16:35:50', null, null, '1192', '1');
INSERT INTO `by_member_detail_aud` VALUES ('705', null, null, null, null, null, null, '2016-10-06 17:17:54', null, null, null, '1193', '0');
INSERT INTO `by_member_detail_aud` VALUES ('706', null, null, null, null, null, null, '2016-10-06 19:16:46', null, null, null, '1194', '0');
INSERT INTO `by_member_detail_aud` VALUES ('706', '王艳', '', null, '2016-10-18 00:00:00', null, '', '2016-10-06 19:16:46', '2016-10-06 19:17:31', null, null, '1195', '1');
INSERT INTO `by_member_detail_aud` VALUES ('707', null, null, null, null, null, null, '2016-10-06 19:39:16', null, null, null, '1196', '0');
INSERT INTO `by_member_detail_aud` VALUES ('708', null, null, null, null, null, null, '2016-10-06 20:03:27', null, null, null, '1197', '0');
INSERT INTO `by_member_detail_aud` VALUES ('709', null, null, null, null, null, null, '2016-10-06 20:37:08', null, null, null, '1198', '0');
INSERT INTO `by_member_detail_aud` VALUES ('710', null, null, null, null, null, null, '2016-10-06 21:41:03', null, null, null, '1201', '0');
INSERT INTO `by_member_detail_aud` VALUES ('710', '', '', null, '1986-09-12 23:00:00', null, '310115198609130649', '2016-10-06 21:41:03', '2016-10-06 21:41:48', null, null, '1202', '1');
INSERT INTO `by_member_detail_aud` VALUES ('711', null, null, null, null, null, null, '2016-10-06 22:41:21', null, null, null, '1203', '0');
INSERT INTO `by_member_detail_aud` VALUES ('712', null, null, null, null, null, null, '2016-10-07 12:55:51', null, null, null, '1204', '0');
INSERT INTO `by_member_detail_aud` VALUES ('713', null, null, null, null, null, null, '2016-10-07 13:18:14', null, null, null, '1205', '0');
INSERT INTO `by_member_detail_aud` VALUES ('714', null, null, null, null, null, null, '2016-10-07 13:37:18', null, null, null, '1206', '0');
INSERT INTO `by_member_detail_aud` VALUES ('715', null, null, null, null, null, null, '2016-10-07 13:42:47', null, null, null, '1207', '0');
INSERT INTO `by_member_detail_aud` VALUES ('716', null, null, null, null, null, null, '2016-10-07 14:51:36', null, null, null, '1208', '0');
INSERT INTO `by_member_detail_aud` VALUES ('717', null, null, null, null, null, null, '2016-10-07 16:25:30', null, null, null, '1209', '0');
INSERT INTO `by_member_detail_aud` VALUES ('718', null, null, null, null, null, null, '2016-10-07 16:31:33', null, null, null, '1210', '0');
INSERT INTO `by_member_detail_aud` VALUES ('719', null, null, null, null, null, null, '2016-10-07 17:32:26', null, null, null, '1211', '0');
INSERT INTO `by_member_detail_aud` VALUES ('719', '严蓓珏', '', null, '1982-10-23 00:00:00', null, '', '2016-10-07 17:32:26', '2016-10-07 17:34:53', null, null, '1212', '1');
INSERT INTO `by_member_detail_aud` VALUES ('720', null, null, null, null, null, null, '2016-10-07 18:50:38', null, null, null, '1213', '0');
INSERT INTO `by_member_detail_aud` VALUES ('720', null, null, '9f9f9907d453085263c7750e23a81aec38c91f5d4701d2c5b0731d761620e65c', null, null, null, '2016-10-07 18:50:38', '2016-10-07 18:51:53', null, null, '1214', '1');
INSERT INTO `by_member_detail_aud` VALUES ('720', '', '', '9f9f9907d453085263c7750e23a81aec38c91f5d4701d2c5b0731d761620e65c', '2000-05-21 00:00:00', null, '', '2016-10-07 18:50:38', '2016-10-07 18:52:15', null, null, '1215', '1');
INSERT INTO `by_member_detail_aud` VALUES ('721', null, null, null, null, null, null, '2016-10-07 20:25:54', null, null, null, '1216', '0');
INSERT INTO `by_member_detail_aud` VALUES ('721', '', '佳林路919弄28号201', null, '1998-12-30 00:00:00', null, '310115199812304418', '2016-10-07 20:25:54', '2016-10-07 20:27:04', null, null, '1217', '1');
INSERT INTO `by_member_detail_aud` VALUES ('722', null, null, null, null, null, null, '2016-10-07 20:56:45', null, null, null, '1218', '0');
INSERT INTO `by_member_detail_aud` VALUES ('723', null, null, null, null, null, null, '2016-10-07 21:22:34', null, null, null, '1219', '0');
INSERT INTO `by_member_detail_aud` VALUES ('724', null, null, null, null, null, null, '2016-10-07 22:13:24', null, null, null, '1220', '0');
INSERT INTO `by_member_detail_aud` VALUES ('724', '李明芳', '', null, null, null, '', '2016-10-07 22:13:24', '2016-10-07 22:14:09', null, null, '1221', '1');
INSERT INTO `by_member_detail_aud` VALUES ('725', null, null, null, null, null, null, '2016-10-08 07:25:12', null, null, null, '1222', '0');
INSERT INTO `by_member_detail_aud` VALUES ('726', null, null, null, null, null, null, '2016-10-08 15:59:49', null, null, null, '1223', '0');
INSERT INTO `by_member_detail_aud` VALUES ('726', null, null, 'edc250f46119ab8766370815652142ef3a724f934c985c5256d039a8997c101c', null, null, null, '2016-10-08 15:59:49', '2016-10-08 16:01:38', null, null, '1224', '1');
INSERT INTO `by_member_detail_aud` VALUES ('726', '', '', 'edc250f46119ab8766370815652142ef3a724f934c985c5256d039a8997c101c', null, null, '', '2016-10-08 15:59:49', '2016-10-08 16:01:54', null, null, '1225', '1');
INSERT INTO `by_member_detail_aud` VALUES ('727', null, null, null, null, null, null, '2016-10-08 20:33:52', null, null, null, '1226', '0');
INSERT INTO `by_member_detail_aud` VALUES ('728', null, null, null, null, null, null, '2016-10-08 22:11:11', null, null, null, '1227', '0');
INSERT INTO `by_member_detail_aud` VALUES ('729', null, null, null, null, null, null, '2016-10-09 12:04:23', null, null, null, '1228', '0');
INSERT INTO `by_member_detail_aud` VALUES ('730', null, null, null, null, null, null, '2016-10-09 15:01:06', null, null, null, '1230', '0');
INSERT INTO `by_member_detail_aud` VALUES ('731', null, null, null, null, null, null, '2016-10-09 21:07:37', null, null, null, '1231', '0');
INSERT INTO `by_member_detail_aud` VALUES ('732', null, null, null, null, null, null, '2016-10-09 21:50:03', null, null, null, '1232', '0');
INSERT INTO `by_member_detail_aud` VALUES ('733', null, null, null, null, null, null, '2016-10-10 16:47:13', null, null, null, '1233', '0');
INSERT INTO `by_member_detail_aud` VALUES ('734', null, null, null, null, null, null, '2016-10-10 20:45:49', null, null, null, '1234', '0');
INSERT INTO `by_member_detail_aud` VALUES ('735', null, null, null, null, null, null, '2016-10-11 10:09:30', null, null, null, '1235', '0');
INSERT INTO `by_member_detail_aud` VALUES ('736', null, null, null, null, null, null, '2016-10-11 13:50:28', null, null, null, '1236', '0');
INSERT INTO `by_member_detail_aud` VALUES ('736', null, null, '65fec144393b0896392a1d045920f1cbe7a4fa1ee88ba1b40e42ba0e8ae429e0', null, null, null, '2016-10-11 13:50:28', '2016-10-11 13:51:48', null, null, '1237', '1');
INSERT INTO `by_member_detail_aud` VALUES ('736', '', '', '65fec144393b0896392a1d045920f1cbe7a4fa1ee88ba1b40e42ba0e8ae429e0', '1982-09-03 00:00:00', null, '', '2016-10-11 13:50:28', '2016-10-11 13:52:12', null, null, '1238', '1');
INSERT INTO `by_member_detail_aud` VALUES ('737', null, null, null, null, null, null, '2016-10-12 12:31:28', null, null, null, '1239', '0');
INSERT INTO `by_member_detail_aud` VALUES ('738', null, null, null, null, null, null, '2016-10-12 21:27:39', null, null, null, '1240', '0');
INSERT INTO `by_member_detail_aud` VALUES ('739', null, null, null, null, null, null, '2016-10-13 07:09:34', null, null, null, '1241', '0');
INSERT INTO `by_member_detail_aud` VALUES ('739', null, null, '396d082c16a9ca1e41e048f8dba6f7359a6696ef3eae51791a18dd982e77114f', null, null, null, '2016-10-13 07:09:34', '2016-10-13 10:09:26', null, null, '1242', '1');
INSERT INTO `by_member_detail_aud` VALUES ('739', '吴民强', '金钻路398弄24', '396d082c16a9ca1e41e048f8dba6f7359a6696ef3eae51791a18dd982e77114f', '1991-07-17 23:00:00', null, '350628199107180030', '2016-10-13 07:09:34', '2016-10-13 10:10:22', null, null, '1243', '1');
INSERT INTO `by_member_detail_aud` VALUES ('740', null, null, null, null, null, null, '2016-10-13 10:52:47', null, null, null, '1244', '0');
INSERT INTO `by_member_detail_aud` VALUES ('741', null, null, null, null, null, null, '2016-10-13 11:14:07', null, null, null, '1245', '0');
INSERT INTO `by_member_detail_aud` VALUES ('742', null, null, null, null, null, null, '2016-10-13 18:49:23', null, null, null, '1246', '0');
INSERT INTO `by_member_detail_aud` VALUES ('743', null, null, null, null, null, null, '2016-10-13 22:04:51', null, null, null, '1247', '0');
INSERT INTO `by_member_detail_aud` VALUES ('743', '卜佳妮', '', null, '1993-10-12 00:00:00', null, '', '2016-10-13 22:04:51', '2016-10-13 22:05:17', null, null, '1248', '1');
INSERT INTO `by_member_detail_aud` VALUES ('744', null, null, null, null, null, null, '2016-10-14 18:46:43', null, null, null, '1249', '0');
INSERT INTO `by_member_detail_aud` VALUES ('745', null, null, null, null, null, null, '2016-10-14 20:01:25', null, null, null, '1250', '0');
INSERT INTO `by_member_detail_aud` VALUES ('746', null, null, null, null, null, null, '2016-10-14 20:06:07', null, null, null, '1251', '0');
INSERT INTO `by_member_detail_aud` VALUES ('747', null, null, null, null, null, null, '2016-10-14 20:08:38', null, null, null, '1252', '0');
INSERT INTO `by_member_detail_aud` VALUES ('747', '周艳', '', null, '1983-01-25 00:00:00', null, '', '2016-10-14 20:08:38', '2016-10-14 20:09:30', null, null, '1253', '1');
INSERT INTO `by_member_detail_aud` VALUES ('748', null, null, null, null, null, null, '2016-10-14 20:20:23', null, null, null, '1254', '0');
INSERT INTO `by_member_detail_aud` VALUES ('749', null, null, null, null, null, null, '2016-10-14 20:20:25', null, null, null, '1255', '0');
INSERT INTO `by_member_detail_aud` VALUES ('750', null, null, null, null, null, null, '2016-10-14 20:23:01', null, null, null, '1256', '0');
INSERT INTO `by_member_detail_aud` VALUES ('751', null, null, null, null, null, null, '2016-10-14 20:29:35', null, null, null, '1257', '0');
INSERT INTO `by_member_detail_aud` VALUES ('752', null, null, null, null, null, null, '2016-10-14 20:34:58', null, null, null, '1258', '0');
INSERT INTO `by_member_detail_aud` VALUES ('752', '', '', null, '1970-10-05 00:00:00', null, '310224197010052821', '2016-10-14 20:34:58', '2016-10-14 20:37:26', null, null, '1259', '1');
INSERT INTO `by_member_detail_aud` VALUES ('753', null, null, null, null, null, null, '2016-10-14 20:37:44', null, null, null, '1260', '0');
INSERT INTO `by_member_detail_aud` VALUES ('754', null, null, null, null, null, null, '2016-10-14 20:39:26', null, null, null, '1261', '0');
INSERT INTO `by_member_detail_aud` VALUES ('755', null, null, null, null, null, null, '2016-10-14 20:42:26', null, null, null, '1262', '0');
INSERT INTO `by_member_detail_aud` VALUES ('756', null, null, null, null, null, null, '2016-10-14 21:10:10', null, null, null, '1263', '0');
INSERT INTO `by_member_detail_aud` VALUES ('757', null, null, null, null, null, null, '2016-10-14 21:15:07', null, null, null, '1264', '0');
INSERT INTO `by_member_detail_aud` VALUES ('758', null, null, null, null, null, null, '2016-10-14 21:24:10', null, null, null, '1265', '0');
INSERT INTO `by_member_detail_aud` VALUES ('759', null, null, null, null, null, null, '2016-10-15 00:01:57', null, null, null, '1266', '0');
INSERT INTO `by_member_detail_aud` VALUES ('759', '', '', null, null, null, '', '2016-10-15 00:01:57', '2016-10-15 00:03:18', null, null, '1267', '1');
INSERT INTO `by_member_detail_aud` VALUES ('760', null, null, null, null, null, null, '2016-10-15 10:31:30', null, null, null, '1268', '0');
INSERT INTO `by_member_detail_aud` VALUES ('760', null, null, '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', null, null, null, '2016-10-15 10:31:30', '2016-10-15 10:32:20', null, null, '1269', '1');
INSERT INTO `by_member_detail_aud` VALUES ('760', '吴明伟', '', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1983-08-17 00:00:00', null, '', '2016-10-15 10:31:30', '2016-10-15 10:33:08', null, null, '1270', '1');
INSERT INTO `by_member_detail_aud` VALUES ('761', null, null, null, null, null, null, '2016-10-15 11:18:35', null, null, null, '1271', '0');
INSERT INTO `by_member_detail_aud` VALUES ('762', null, null, null, null, null, null, '2016-10-15 11:27:05', null, null, null, '1272', '0');
INSERT INTO `by_member_detail_aud` VALUES ('762', '蔡利峰', '', null, null, null, '', '2016-10-15 11:27:05', '2016-10-15 11:29:38', null, null, '1273', '1');
INSERT INTO `by_member_detail_aud` VALUES ('762', '蔡利峰', '', null, '1979-01-29 00:00:00', null, '310115197901296318', '2016-10-15 11:27:05', '2016-10-15 11:30:02', null, null, '1274', '1');
INSERT INTO `by_member_detail_aud` VALUES ('763', null, null, null, null, null, null, '2016-10-15 13:03:11', null, null, null, '1275', '0');
INSERT INTO `by_member_detail_aud` VALUES ('764', null, null, null, null, null, null, '2016-10-15 13:34:32', null, null, null, '1276', '0');
INSERT INTO `by_member_detail_aud` VALUES ('765', null, null, null, null, null, null, '2016-10-15 13:43:59', null, null, null, '1277', '0');
INSERT INTO `by_member_detail_aud` VALUES ('765', '卢鸣', '', null, null, null, '', '2016-10-15 13:43:59', '2016-10-15 13:44:44', null, null, '1278', '1');
INSERT INTO `by_member_detail_aud` VALUES ('766', null, null, null, null, null, null, '2016-10-15 15:26:48', null, null, null, '1279', '0');
INSERT INTO `by_member_detail_aud` VALUES ('767', null, null, null, null, null, null, '2016-10-15 17:11:18', null, null, null, '1280', '0');
INSERT INTO `by_member_detail_aud` VALUES ('768', null, null, null, null, null, null, '2016-10-15 17:28:56', null, null, null, '1281', '0');
INSERT INTO `by_member_detail_aud` VALUES ('769', null, null, null, null, null, null, '2016-10-15 17:58:07', null, null, null, '1282', '0');
INSERT INTO `by_member_detail_aud` VALUES ('770', null, null, null, null, null, null, '2016-10-16 12:10:22', null, null, null, '1283', '0');
INSERT INTO `by_member_detail_aud` VALUES ('771', null, null, null, null, null, null, '2016-10-16 14:17:45', null, null, null, '1284', '0');
INSERT INTO `by_member_detail_aud` VALUES ('772', null, null, null, null, null, null, '2016-10-16 16:39:42', null, null, null, '1285', '0');
INSERT INTO `by_member_detail_aud` VALUES ('772', '', '金沪路1099号', null, '1983-09-06 00:00:00', null, '310115198309060618', '2016-10-16 16:39:42', '2016-10-16 16:40:19', null, null, '1286', '1');
INSERT INTO `by_member_detail_aud` VALUES ('772', '许伟国', '金沪路1099号', null, '1983-09-06 00:00:00', null, '310115198309060618', '2016-10-16 16:39:42', '2016-10-30 19:35:24', null, null, '1420', '1');
INSERT INTO `by_member_detail_aud` VALUES ('773', null, null, null, null, null, null, '2016-10-16 16:47:31', null, null, null, '1287', '0');
INSERT INTO `by_member_detail_aud` VALUES ('774', null, null, null, null, null, null, '2016-10-16 17:56:39', null, null, null, '1288', '0');
INSERT INTO `by_member_detail_aud` VALUES ('775', null, null, null, null, null, null, '2016-10-16 18:50:43', null, null, null, '1289', '0');
INSERT INTO `by_member_detail_aud` VALUES ('776', null, null, null, null, null, null, '2016-10-16 22:29:24', null, null, null, '1290', '0');
INSERT INTO `by_member_detail_aud` VALUES ('777', null, null, null, null, null, null, '2016-10-16 22:40:41', null, null, null, '1291', '0');
INSERT INTO `by_member_detail_aud` VALUES ('777', '大庆', '', null, null, null, '', '2016-10-16 22:40:41', '2016-10-16 22:41:09', null, null, '1292', '1');
INSERT INTO `by_member_detail_aud` VALUES ('778', null, null, null, null, null, null, '2016-10-17 11:53:33', null, null, null, '1293', '0');
INSERT INTO `by_member_detail_aud` VALUES ('779', null, null, null, null, null, null, '2016-10-17 12:12:10', null, null, null, '1294', '0');
INSERT INTO `by_member_detail_aud` VALUES ('780', null, null, null, null, null, null, '2016-10-17 13:19:51', null, null, null, '1295', '0');
INSERT INTO `by_member_detail_aud` VALUES ('781', null, null, null, null, null, null, '2016-10-17 16:54:51', null, null, null, '1296', '0');
INSERT INTO `by_member_detail_aud` VALUES ('782', null, null, null, null, null, null, '2016-10-18 09:33:39', null, null, null, '1297', '0');
INSERT INTO `by_member_detail_aud` VALUES ('783', null, null, null, null, null, null, '2016-10-18 15:28:49', null, null, null, '1298', '0');
INSERT INTO `by_member_detail_aud` VALUES ('784', null, null, null, null, null, null, '2016-10-18 17:33:10', null, null, null, '1299', '0');
INSERT INTO `by_member_detail_aud` VALUES ('785', null, null, null, null, null, null, '2016-10-18 19:00:49', null, null, null, '1300', '0');
INSERT INTO `by_member_detail_aud` VALUES ('785', null, null, '0b378c4f890f52055cb340edf238857d2fc51833ad2cbfd5b0ee14c394fd67d0', null, null, null, '2016-10-18 19:00:49', '2016-10-18 19:02:09', null, null, '1301', '1');
INSERT INTO `by_member_detail_aud` VALUES ('785', '', '永宁路33弄19号1201室', '0b378c4f890f52055cb340edf238857d2fc51833ad2cbfd5b0ee14c394fd67d0', '1989-02-24 00:00:00', null, '310115198902244717', '2016-10-18 19:00:49', '2016-10-18 20:27:26', null, null, '1302', '1');
INSERT INTO `by_member_detail_aud` VALUES ('786', null, null, null, null, null, null, '2016-10-19 10:38:26', null, null, null, '1303', '0');
INSERT INTO `by_member_detail_aud` VALUES ('787', null, null, null, null, null, null, '2016-10-19 11:57:55', null, null, null, '1304', '0');
INSERT INTO `by_member_detail_aud` VALUES ('788', null, null, null, null, null, null, '2016-10-20 13:28:20', null, null, null, '1305', '0');
INSERT INTO `by_member_detail_aud` VALUES ('789', null, null, null, null, null, null, '2016-10-20 18:14:48', null, null, null, '1306', '0');
INSERT INTO `by_member_detail_aud` VALUES ('790', null, null, null, null, null, null, '2016-10-20 18:35:02', null, null, null, '1307', '0');
INSERT INTO `by_member_detail_aud` VALUES ('791', null, null, null, null, null, null, '2016-10-20 18:42:42', null, null, null, '1308', '0');
INSERT INTO `by_member_detail_aud` VALUES ('792', null, null, null, null, null, null, '2016-10-20 19:07:38', null, null, null, '1309', '0');
INSERT INTO `by_member_detail_aud` VALUES ('792', '王珏', '', null, null, null, '', '2016-10-20 19:07:38', '2016-10-20 19:08:07', null, null, '1310', '1');
INSERT INTO `by_member_detail_aud` VALUES ('793', null, null, null, null, null, null, '2016-10-20 19:10:48', null, null, null, '1311', '0');
INSERT INTO `by_member_detail_aud` VALUES ('793', null, null, '21fe3165a4d308ca908e90047bced706a186ccaa5547b4805156427cf5513599', null, null, null, '2016-10-20 19:10:48', '2016-10-20 19:11:56', null, null, '1312', '1');
INSERT INTO `by_member_detail_aud` VALUES ('793', '沈小姐', '', '21fe3165a4d308ca908e90047bced706a186ccaa5547b4805156427cf5513599', null, null, '', '2016-10-20 19:10:48', '2016-10-20 19:12:11', null, null, '1313', '1');
INSERT INTO `by_member_detail_aud` VALUES ('794', null, null, null, null, null, null, '2016-10-20 19:13:00', null, null, null, '1314', '0');
INSERT INTO `by_member_detail_aud` VALUES ('795', null, null, null, null, null, null, '2016-10-20 19:16:05', null, null, null, '1315', '0');
INSERT INTO `by_member_detail_aud` VALUES ('796', null, null, null, null, null, null, '2016-10-20 19:21:15', null, null, null, '1316', '0');
INSERT INTO `by_member_detail_aud` VALUES ('797', null, null, null, null, null, null, '2016-10-20 19:59:20', null, null, null, '1317', '0');
INSERT INTO `by_member_detail_aud` VALUES ('798', null, null, null, null, null, null, '2016-10-20 21:14:36', null, null, null, '1319', '0');
INSERT INTO `by_member_detail_aud` VALUES ('798', '黄筱云', '', null, null, null, '', '2016-10-20 21:14:36', '2016-10-20 21:15:32', null, null, '1320', '1');
INSERT INTO `by_member_detail_aud` VALUES ('799', null, null, null, null, null, null, '2016-10-20 22:23:58', null, null, null, '1321', '0');
INSERT INTO `by_member_detail_aud` VALUES ('800', null, null, null, null, null, null, '2016-10-20 23:18:17', null, null, null, '1322', '0');
INSERT INTO `by_member_detail_aud` VALUES ('801', null, null, null, null, null, null, '2016-10-21 16:41:26', null, null, null, '1323', '0');
INSERT INTO `by_member_detail_aud` VALUES ('802', null, null, null, null, null, null, '2016-10-21 22:11:12', null, null, null, '1324', '0');
INSERT INTO `by_member_detail_aud` VALUES ('803', null, null, null, null, null, null, '2016-10-22 07:21:35', null, null, null, '1325', '0');
INSERT INTO `by_member_detail_aud` VALUES ('804', null, null, null, null, null, null, '2016-10-22 10:52:55', null, null, null, '1326', '0');
INSERT INTO `by_member_detail_aud` VALUES ('804', null, null, 'e81ed92e72aeb2aeea457c43e5c0e156a320ea362be688bae57d15d4e1e73df2', null, null, null, '2016-10-22 10:52:55', '2016-10-26 10:01:39', null, null, '1354', '1');
INSERT INTO `by_member_detail_aud` VALUES ('804', '', '曹路镇海鸣路98弄39号1301室', 'e81ed92e72aeb2aeea457c43e5c0e156a320ea362be688bae57d15d4e1e73df2', '1977-11-04 00:00:00', null, '', '2016-10-22 10:52:55', '2016-10-26 10:02:34', null, null, '1355', '1');
INSERT INTO `by_member_detail_aud` VALUES ('805', null, null, null, null, null, null, '2016-10-22 14:54:20', null, null, null, '1327', '0');
INSERT INTO `by_member_detail_aud` VALUES ('805', '刘凯', '', null, '1989-02-15 00:00:00', null, '371324198902155270', '2016-10-22 14:54:20', '2016-10-22 14:55:04', null, null, '1328', '1');
INSERT INTO `by_member_detail_aud` VALUES ('806', null, null, null, null, null, null, '2016-10-22 15:59:18', null, null, null, '1329', '0');
INSERT INTO `by_member_detail_aud` VALUES ('807', null, null, null, null, null, null, '2016-10-22 18:10:32', null, null, null, '1330', '0');
INSERT INTO `by_member_detail_aud` VALUES ('808', null, null, null, null, null, null, '2016-10-22 19:22:19', null, null, null, '1331', '0');
INSERT INTO `by_member_detail_aud` VALUES ('809', null, null, null, null, null, null, '2016-10-22 20:40:34', null, null, null, '1332', '0');
INSERT INTO `by_member_detail_aud` VALUES ('809', '奚军梅', '', null, null, null, '', '2016-10-22 20:40:34', '2016-10-22 20:40:54', null, null, '1333', '1');
INSERT INTO `by_member_detail_aud` VALUES ('810', null, null, null, null, null, null, '2016-10-22 23:06:49', null, null, null, '1334', '0');
INSERT INTO `by_member_detail_aud` VALUES ('810', '高先生', '', null, null, null, '', '2016-10-22 23:06:49', '2016-10-22 23:13:35', null, null, '1335', '1');
INSERT INTO `by_member_detail_aud` VALUES ('811', null, null, null, null, null, null, '2016-10-23 08:48:53', null, null, null, '1336', '0');
INSERT INTO `by_member_detail_aud` VALUES ('812', null, null, null, null, null, null, '2016-10-23 10:34:29', null, null, null, '1337', '0');
INSERT INTO `by_member_detail_aud` VALUES ('813', null, null, null, null, null, null, '2016-10-23 11:08:38', null, null, null, '1338', '0');
INSERT INTO `by_member_detail_aud` VALUES ('814', null, null, null, null, null, null, '2016-10-23 12:20:01', null, null, null, '1339', '0');
INSERT INTO `by_member_detail_aud` VALUES ('815', null, null, null, null, null, null, '2016-10-23 13:39:14', null, null, null, '1340', '0');
INSERT INTO `by_member_detail_aud` VALUES ('816', null, null, null, null, null, null, '2016-10-23 15:44:42', null, null, null, '1341', '0');
INSERT INTO `by_member_detail_aud` VALUES ('817', null, null, null, null, null, null, '2016-10-23 16:01:28', null, null, null, '1342', '0');
INSERT INTO `by_member_detail_aud` VALUES ('817', '谈丽倩', '', null, null, null, '', '2016-10-23 16:01:28', '2016-10-23 16:01:52', null, null, '1343', '1');
INSERT INTO `by_member_detail_aud` VALUES ('818', null, null, null, null, null, null, '2016-10-23 18:26:36', null, null, null, '1344', '0');
INSERT INTO `by_member_detail_aud` VALUES ('819', null, null, null, null, null, null, '2016-10-23 19:59:47', null, null, null, '1345', '0');
INSERT INTO `by_member_detail_aud` VALUES ('820', null, null, null, null, null, null, '2016-10-23 20:26:52', null, null, null, '1346', '0');
INSERT INTO `by_member_detail_aud` VALUES ('821', null, null, null, null, null, null, '2016-10-23 21:31:20', null, null, null, '1347', '0');
INSERT INTO `by_member_detail_aud` VALUES ('822', null, null, null, null, null, null, '2016-10-24 16:36:27', null, null, null, '1348', '0');
INSERT INTO `by_member_detail_aud` VALUES ('823', null, null, null, null, null, null, '2016-10-25 13:55:31', null, null, null, '1349', '0');
INSERT INTO `by_member_detail_aud` VALUES ('824', null, null, null, null, null, null, '2016-10-25 14:05:00', null, null, null, '1350', '0');
INSERT INTO `by_member_detail_aud` VALUES ('825', null, null, null, null, null, null, '2016-10-25 18:04:02', null, null, null, '1351', '0');
INSERT INTO `by_member_detail_aud` VALUES ('826', null, null, null, null, null, null, '2016-10-25 18:06:58', null, null, null, '1352', '0');
INSERT INTO `by_member_detail_aud` VALUES ('827', null, null, null, null, null, null, '2016-10-25 18:49:00', null, null, null, '1353', '0');
INSERT INTO `by_member_detail_aud` VALUES ('828', null, null, null, null, null, null, '2016-10-26 10:03:56', null, null, null, '1356', '0');
INSERT INTO `by_member_detail_aud` VALUES ('828', 'kiki', '', null, '1993-01-19 00:00:00', null, '', '2016-10-26 10:03:56', '2016-10-26 10:04:44', null, null, '1357', '1');
INSERT INTO `by_member_detail_aud` VALUES ('829', null, null, null, null, null, null, '2016-10-26 10:05:52', null, null, null, '1358', '0');
INSERT INTO `by_member_detail_aud` VALUES ('830', null, null, null, null, null, null, '2016-10-26 10:08:03', null, null, null, '1359', '0');
INSERT INTO `by_member_detail_aud` VALUES ('831', null, null, null, null, null, null, '2016-10-26 10:14:29', null, null, null, '1360', '0');
INSERT INTO `by_member_detail_aud` VALUES ('831', 'alisa', '', null, '1991-12-06 00:00:00', null, '', '2016-10-26 10:14:29', '2016-10-26 10:14:58', null, null, '1361', '1');
INSERT INTO `by_member_detail_aud` VALUES ('832', null, null, null, null, null, null, '2016-10-26 10:18:38', null, null, null, '1362', '0');
INSERT INTO `by_member_detail_aud` VALUES ('833', null, null, null, null, null, null, '2016-10-26 10:39:13', null, null, null, '1363', '0');
INSERT INTO `by_member_detail_aud` VALUES ('834', null, null, null, null, null, null, '2016-10-26 12:15:08', null, null, null, '1364', '0');
INSERT INTO `by_member_detail_aud` VALUES ('835', null, null, null, null, null, null, '2016-10-26 14:33:47', null, null, null, '1365', '0');
INSERT INTO `by_member_detail_aud` VALUES ('836', null, null, null, null, null, null, '2016-10-26 19:03:47', null, null, null, '1366', '0');
INSERT INTO `by_member_detail_aud` VALUES ('837', null, null, null, null, null, null, '2016-10-26 19:09:39', null, null, null, '1367', '0');
INSERT INTO `by_member_detail_aud` VALUES ('837', null, null, '76bc12dc4ddceca0299caf87178b8e73eaf4141fc2e0bd6c5489e1794bcd7f2e', null, null, null, '2016-10-26 19:09:39', '2016-10-26 19:10:50', null, null, '1368', '1');
INSERT INTO `by_member_detail_aud` VALUES ('837', '', '高行鎮俱進路500弄46號502', '76bc12dc4ddceca0299caf87178b8e73eaf4141fc2e0bd6c5489e1794bcd7f2e', '1989-06-26 23:00:00', null, '412822198906271875', '2016-10-26 19:09:39', '2016-10-26 19:11:59', null, null, '1369', '1');
INSERT INTO `by_member_detail_aud` VALUES ('838', null, null, null, null, null, null, '2016-10-26 19:12:38', null, null, null, '1370', '0');
INSERT INTO `by_member_detail_aud` VALUES ('838', null, null, '76bc12dc4ddceca0299caf87178b8e73eaf4141fc2e0bd6c5489e1794bcd7f2e', null, null, null, '2016-10-26 19:12:38', '2016-10-26 19:14:14', null, null, '1371', '1');
INSERT INTO `by_member_detail_aud` VALUES ('838', '', '浦东新区高行镇俱近路紫翠苑500弄46号502室', '76bc12dc4ddceca0299caf87178b8e73eaf4141fc2e0bd6c5489e1794bcd7f2e', '1990-06-09 23:00:00', null, '340123199006107909', '2016-10-26 19:12:38', '2016-10-26 19:15:30', null, null, '1372', '1');
INSERT INTO `by_member_detail_aud` VALUES ('839', null, null, null, null, null, null, '2016-10-26 21:41:56', null, null, null, '1373', '0');
INSERT INTO `by_member_detail_aud` VALUES ('839', null, null, '1602b4048b35882a346c6887360d0343cde72797314f81a36065c71320562615', null, null, null, '2016-10-26 21:41:56', '2016-10-26 21:43:58', null, null, '1374', '1');
INSERT INTO `by_member_detail_aud` VALUES ('839', '王雯雯', '', '1602b4048b35882a346c6887360d0343cde72797314f81a36065c71320562615', '2016-09-19 00:00:00', null, '', '2016-10-26 21:41:56', '2016-10-26 21:44:34', null, null, '1375', '1');
INSERT INTO `by_member_detail_aud` VALUES ('840', null, null, null, null, null, null, '2016-10-27 12:48:04', null, null, null, '1376', '0');
INSERT INTO `by_member_detail_aud` VALUES ('841', null, null, null, null, null, null, '2016-10-27 15:43:33', null, null, null, '1377', '0');
INSERT INTO `by_member_detail_aud` VALUES ('841', '黄海洋', '', null, '1982-10-11 00:00:00', null, '', '2016-10-27 15:43:33', '2016-10-27 15:44:09', null, null, '1378', '1');
INSERT INTO `by_member_detail_aud` VALUES ('842', null, null, null, null, null, null, '2016-10-28 10:24:47', null, null, null, '1379', '0');
INSERT INTO `by_member_detail_aud` VALUES ('843', null, null, null, null, null, null, '2016-10-28 10:35:17', null, null, null, '1381', '0');
INSERT INTO `by_member_detail_aud` VALUES ('844', null, null, null, null, null, null, '2016-10-28 10:40:33', null, null, null, '1382', '0');
INSERT INTO `by_member_detail_aud` VALUES ('845', null, null, null, null, null, null, '2016-10-28 10:44:26', null, null, null, '1383', '0');
INSERT INTO `by_member_detail_aud` VALUES ('846', null, null, null, null, null, null, '2016-10-28 10:45:16', null, null, null, '1384', '0');
INSERT INTO `by_member_detail_aud` VALUES ('847', null, null, null, null, null, null, '2016-10-28 10:59:54', null, null, null, '1385', '0');
INSERT INTO `by_member_detail_aud` VALUES ('848', null, null, null, null, null, null, '2016-10-28 11:02:26', null, null, null, '1386', '0');
INSERT INTO `by_member_detail_aud` VALUES ('849', null, null, null, null, null, null, '2016-10-28 11:27:59', null, null, null, '1387', '0');
INSERT INTO `by_member_detail_aud` VALUES ('849', null, null, '9870dbed8aa48862f17b5e8ab5f907239a9baee946d858d02904dec21d55b52d', null, null, null, '2016-10-28 11:27:59', '2016-10-28 11:33:56', null, null, '1388', '1');
INSERT INTO `by_member_detail_aud` VALUES ('849', '', '金杨路757弄82号101室', '9870dbed8aa48862f17b5e8ab5f907239a9baee946d858d02904dec21d55b52d', '1987-08-03 23:00:00', null, '', '2016-10-28 11:27:59', '2016-10-28 11:35:23', null, null, '1389', '1');
INSERT INTO `by_member_detail_aud` VALUES ('850', null, null, null, null, null, null, '2016-10-28 11:45:01', null, null, null, '1390', '0');
INSERT INTO `by_member_detail_aud` VALUES ('851', null, null, null, null, null, null, '2016-10-28 11:46:13', null, null, null, '1391', '0');
INSERT INTO `by_member_detail_aud` VALUES ('852', null, null, null, null, null, null, '2016-10-28 12:43:45', null, null, null, '1392', '0');
INSERT INTO `by_member_detail_aud` VALUES ('853', null, null, null, null, null, null, '2016-10-28 19:03:07', null, null, null, '1393', '0');
INSERT INTO `by_member_detail_aud` VALUES ('854', null, null, null, null, null, null, '2016-10-28 22:20:19', null, null, null, '1394', '0');
INSERT INTO `by_member_detail_aud` VALUES ('855', null, null, null, null, null, null, '2016-10-29 13:36:58', null, null, null, '1395', '0');
INSERT INTO `by_member_detail_aud` VALUES ('856', null, null, null, null, null, null, '2016-10-29 15:00:35', null, null, null, '1396', '0');
INSERT INTO `by_member_detail_aud` VALUES ('857', null, null, null, null, null, null, '2016-10-29 19:18:34', null, null, null, '1397', '0');
INSERT INTO `by_member_detail_aud` VALUES ('857', 'Felix', '', null, null, null, '', '2016-10-29 19:18:34', '2016-10-29 19:19:09', null, null, '1398', '1');
INSERT INTO `by_member_detail_aud` VALUES ('858', null, null, null, null, null, null, '2016-10-29 20:33:31', null, null, null, '1399', '0');
INSERT INTO `by_member_detail_aud` VALUES ('858', null, null, '294e869b7d4148c42e8c693b1b26ef6d0ec8b3b151e9e26a5277e3298120ea72', null, null, null, '2016-10-29 20:33:31', '2016-10-29 20:35:30', null, null, '1400', '1');
INSERT INTO `by_member_detail_aud` VALUES ('858', '王懿', '', '294e869b7d4148c42e8c693b1b26ef6d0ec8b3b151e9e26a5277e3298120ea72', null, null, '', '2016-10-29 20:33:31', '2016-10-29 20:43:13', null, null, '1401', '1');
INSERT INTO `by_member_detail_aud` VALUES ('859', null, null, null, null, null, null, '2016-10-30 09:00:40', null, null, null, '1402', '0');
INSERT INTO `by_member_detail_aud` VALUES ('860', null, null, null, null, null, null, '2016-10-30 10:37:05', null, null, null, '1403', '0');
INSERT INTO `by_member_detail_aud` VALUES ('861', null, null, null, null, null, null, '2016-10-30 12:39:09', null, null, null, '1404', '0');
INSERT INTO `by_member_detail_aud` VALUES ('862', null, null, null, null, null, null, '2016-10-30 12:39:10', null, null, null, '1405', '0');
INSERT INTO `by_member_detail_aud` VALUES ('863', null, null, null, null, null, null, '2016-10-30 14:22:18', null, null, null, '1406', '0');
INSERT INTO `by_member_detail_aud` VALUES ('864', null, null, null, null, null, null, '2016-10-30 15:23:46', null, null, null, '1407', '0');
INSERT INTO `by_member_detail_aud` VALUES ('864', '陈创', '', null, null, null, '', '2016-10-30 15:23:46', '2016-10-30 15:25:47', null, null, '1408', '1');
INSERT INTO `by_member_detail_aud` VALUES ('865', null, null, null, null, null, null, '2016-10-30 15:45:05', null, null, null, '1409', '0');
INSERT INTO `by_member_detail_aud` VALUES ('866', null, null, null, null, null, null, '2016-10-30 16:20:23', null, null, null, '1410', '0');
INSERT INTO `by_member_detail_aud` VALUES ('866', null, null, '69f7f7a7f8bca9970fa6f9c0b8dad06901d3ef23fd599d3213aa5eee5621c3e3', null, null, null, '2016-10-30 16:20:23', '2016-10-30 16:21:56', null, null, '1411', '1');
INSERT INTO `by_member_detail_aud` VALUES ('866', '符军', '', '69f7f7a7f8bca9970fa6f9c0b8dad06901d3ef23fd599d3213aa5eee5621c3e3', '1978-08-01 00:00:00', null, '', '2016-10-30 16:20:23', '2016-10-30 16:22:24', null, null, '1412', '1');
INSERT INTO `by_member_detail_aud` VALUES ('867', null, null, null, null, null, null, '2016-10-30 16:41:55', null, null, null, '1413', '0');
INSERT INTO `by_member_detail_aud` VALUES ('867', '蔡晓俊', '', null, null, null, '', '2016-10-30 16:41:55', '2016-10-30 16:44:33', null, null, '1414', '1');
INSERT INTO `by_member_detail_aud` VALUES ('868', null, null, null, null, null, null, '2016-10-30 17:37:02', null, null, null, '1415', '0');
INSERT INTO `by_member_detail_aud` VALUES ('869', null, null, null, null, null, null, '2016-10-30 17:39:10', null, null, null, '1416', '0');
INSERT INTO `by_member_detail_aud` VALUES ('870', null, null, null, null, null, null, '2016-10-30 17:54:13', null, null, null, '1417', '0');
INSERT INTO `by_member_detail_aud` VALUES ('871', null, null, null, null, null, null, '2016-10-30 18:36:30', null, null, null, '1418', '0');
INSERT INTO `by_member_detail_aud` VALUES ('872', null, null, null, null, null, null, '2016-10-30 19:06:43', null, null, null, '1419', '0');
INSERT INTO `by_member_detail_aud` VALUES ('873', null, null, null, null, null, null, '2016-10-30 20:09:44', null, null, null, '1421', '0');
INSERT INTO `by_member_detail_aud` VALUES ('874', null, null, null, null, null, null, '2016-10-30 20:34:13', null, null, null, '1422', '0');
INSERT INTO `by_member_detail_aud` VALUES ('875', null, null, null, null, null, null, '2016-10-30 23:16:19', null, null, null, '1423', '0');
INSERT INTO `by_member_detail_aud` VALUES ('876', null, null, null, null, null, null, '2016-11-01 07:36:37', null, null, null, '1424', '0');
INSERT INTO `by_member_detail_aud` VALUES ('876', '金春愉', '上海市浦东新区曹路镇金睦路353弄35号1102室', null, '1977-02-26 00:00:00', null, '310115197702264727', '2016-11-01 07:36:37', '2016-11-01 07:38:29', null, null, '1425', '1');
INSERT INTO `by_member_detail_aud` VALUES ('877', null, null, null, null, null, null, '2016-11-01 10:51:01', null, null, null, '1426', '0');
INSERT INTO `by_member_detail_aud` VALUES ('878', null, null, null, null, null, null, '2016-11-01 14:22:43', null, null, null, '1427', '0');
INSERT INTO `by_member_detail_aud` VALUES ('879', null, null, null, null, null, null, '2016-11-01 23:48:53', null, null, null, '1428', '0');
INSERT INTO `by_member_detail_aud` VALUES ('880', null, null, null, null, null, null, '2016-11-02 12:36:09', null, null, null, '1429', '0');
INSERT INTO `by_member_detail_aud` VALUES ('881', null, null, null, null, null, null, '2016-11-02 12:51:18', null, null, null, '1430', '0');
INSERT INTO `by_member_detail_aud` VALUES ('882', null, null, null, null, null, null, '2016-11-02 18:59:57', null, null, null, '1431', '0');
INSERT INTO `by_member_detail_aud` VALUES ('883', null, null, null, null, null, null, '2016-11-03 11:36:32', null, null, null, '1432', '0');
INSERT INTO `by_member_detail_aud` VALUES ('884', null, null, null, null, null, null, '2016-11-03 19:04:34', null, null, null, '1433', '0');
INSERT INTO `by_member_detail_aud` VALUES ('884', '涂翠梅', '', null, null, null, '', '2016-11-03 19:04:34', '2016-11-03 19:04:59', null, null, '1434', '1');
INSERT INTO `by_member_detail_aud` VALUES ('885', null, null, null, null, null, null, '2016-11-04 15:24:12', null, null, null, '1435', '0');
INSERT INTO `by_member_detail_aud` VALUES ('885', '盛锋', '', null, '1983-04-08 00:00:00', null, '', '2016-11-04 15:24:12', '2016-11-04 15:25:02', null, null, '1436', '1');
INSERT INTO `by_member_detail_aud` VALUES ('886', null, null, null, null, null, null, '2016-11-05 08:25:35', null, null, null, '1437', '0');
INSERT INTO `by_member_detail_aud` VALUES ('886', null, null, '291b3a5e73e01211e8ce2aa2910dbe405c95eb8d52a022c5f37e2f25af6aa614', null, null, null, '2016-11-05 08:25:35', '2016-11-05 08:27:11', null, null, '1438', '1');
INSERT INTO `by_member_detail_aud` VALUES ('886', '', '寿光路161弄50号501室', '291b3a5e73e01211e8ce2aa2910dbe405c95eb8d52a022c5f37e2f25af6aa614', '1978-12-09 00:00:00', null, '310109197812090820', '2016-11-05 08:25:35', '2016-11-05 08:27:58', null, null, '1439', '1');
INSERT INTO `by_member_detail_aud` VALUES ('887', null, null, null, null, null, null, '2016-11-05 13:10:23', null, null, null, '1440', '0');
INSERT INTO `by_member_detail_aud` VALUES ('888', null, null, null, null, null, null, '2016-11-05 17:51:58', null, null, null, '1441', '0');
INSERT INTO `by_member_detail_aud` VALUES ('889', null, null, null, null, null, null, '2016-11-05 19:33:24', null, null, null, '1442', '0');
INSERT INTO `by_member_detail_aud` VALUES ('889', '杨熙珍', '永业路', null, '1988-02-02 00:00:00', null, '310110198802025208', '2016-11-05 19:33:24', '2016-11-05 19:34:31', null, null, '1443', '1');
INSERT INTO `by_member_detail_aud` VALUES ('890', null, null, null, null, null, null, '2016-11-05 19:53:14', null, null, null, '1444', '0');
INSERT INTO `by_member_detail_aud` VALUES ('891', null, null, null, null, null, null, '2016-11-06 11:36:08', null, null, null, '1445', '0');
INSERT INTO `by_member_detail_aud` VALUES ('892', null, null, null, null, null, null, '2016-11-06 15:17:19', null, null, null, '1446', '0');
INSERT INTO `by_member_detail_aud` VALUES ('893', null, null, null, null, null, null, '2016-11-06 15:41:44', null, null, null, '1447', '0');
INSERT INTO `by_member_detail_aud` VALUES ('894', null, null, null, null, null, null, '2016-11-06 16:23:24', null, null, null, '1448', '0');
INSERT INTO `by_member_detail_aud` VALUES ('895', null, null, null, null, null, null, '2016-11-06 18:31:36', null, null, null, '1449', '0');
INSERT INTO `by_member_detail_aud` VALUES ('896', null, null, null, null, null, null, '2016-11-06 23:05:32', null, null, null, '1450', '0');
INSERT INTO `by_member_detail_aud` VALUES ('897', null, null, null, null, null, null, '2016-11-07 20:31:37', null, null, null, '1452', '0');
INSERT INTO `by_member_detail_aud` VALUES ('898', null, null, null, null, null, null, '2016-11-09 20:44:29', null, null, null, '1453', '0');
INSERT INTO `by_member_detail_aud` VALUES ('898', '', '', null, '1980-02-06 00:00:00', null, '', '2016-11-09 20:44:29', '2016-11-09 20:45:03', null, null, '1454', '1');
INSERT INTO `by_member_detail_aud` VALUES ('898', '章健', '', null, '1980-02-06 00:00:00', null, '', '2016-11-09 20:44:29', '2016-11-09 20:45:33', null, null, '1455', '1');
INSERT INTO `by_member_detail_aud` VALUES ('898', '周晓芸', '', null, '1980-10-25 00:00:00', null, '', '2016-11-09 20:44:29', '2016-11-09 20:46:04', null, null, '1456', '1');
INSERT INTO `by_member_detail_aud` VALUES ('898', '周晓芸', '东陆路2000弄2号1402', null, '1980-10-25 00:00:00', null, '', '2016-11-09 20:44:29', '2016-11-09 20:46:19', null, null, '1457', '1');
INSERT INTO `by_member_detail_aud` VALUES ('899', null, null, null, null, null, null, '2016-11-09 20:57:21', null, null, null, '1458', '0');
INSERT INTO `by_member_detail_aud` VALUES ('900', null, null, null, null, null, null, '2016-11-09 20:57:46', null, null, null, '1459', '0');
INSERT INTO `by_member_detail_aud` VALUES ('900', null, null, '83916e070e7d8f0028243f64f78d95aa8513248a5c3b652e1b2713c3f65533c0', null, null, null, '2016-11-09 20:57:46', '2016-11-09 21:00:53', null, null, '1460', '1');
INSERT INTO `by_member_detail_aud` VALUES ('901', null, null, null, null, null, null, '2016-11-10 08:14:38', null, null, null, '1461', '0');
INSERT INTO `by_member_detail_aud` VALUES ('902', null, null, null, null, null, null, '2016-11-10 09:22:20', null, null, null, '1462', '0');
INSERT INTO `by_member_detail_aud` VALUES ('902', '张露', '', null, '1985-12-08 00:00:00', null, '', '2016-11-10 09:22:20', '2016-11-10 09:23:07', null, null, '1463', '1');
INSERT INTO `by_member_detail_aud` VALUES ('903', null, null, null, null, null, null, '2016-11-10 21:18:28', null, null, null, '1464', '0');
INSERT INTO `by_member_detail_aud` VALUES ('904', null, null, null, null, null, null, '2016-11-11 15:35:19', null, null, null, '1465', '0');
INSERT INTO `by_member_detail_aud` VALUES ('905', null, null, null, null, null, null, '2016-11-11 17:58:30', null, null, null, '1466', '0');
INSERT INTO `by_member_detail_aud` VALUES ('906', null, null, null, null, null, null, '2016-11-11 19:39:49', null, null, null, '1467', '0');
INSERT INTO `by_member_detail_aud` VALUES ('907', null, null, null, null, null, null, '2016-11-11 21:34:23', null, null, null, '1468', '0');
INSERT INTO `by_member_detail_aud` VALUES ('908', null, null, null, null, null, null, '2016-11-12 17:17:55', null, null, null, '1469', '0');
INSERT INTO `by_member_detail_aud` VALUES ('909', null, null, null, null, null, null, '2016-11-12 20:53:15', null, null, null, '1470', '0');
INSERT INTO `by_member_detail_aud` VALUES ('910', null, null, null, null, null, null, '2016-11-13 13:24:30', null, null, null, '1471', '0');
INSERT INTO `by_member_detail_aud` VALUES ('911', null, null, null, null, null, null, '2016-11-13 14:14:16', null, null, null, '1472', '0');
INSERT INTO `by_member_detail_aud` VALUES ('911', null, null, '5eff4324d8fb8a52468c9d52f0fb4c0d1a533e78fc9c4435df3d0ae96a1080f6', null, null, null, '2016-11-13 14:14:16', '2016-11-13 14:15:21', null, null, '1473', '1');
INSERT INTO `by_member_detail_aud` VALUES ('911', '', '', '5eff4324d8fb8a52468c9d52f0fb4c0d1a533e78fc9c4435df3d0ae96a1080f6', null, null, '', '2016-11-13 14:14:16', '2016-11-13 14:15:29', null, null, '1474', '1');
INSERT INTO `by_member_detail_aud` VALUES ('912', null, null, null, null, null, null, '2016-11-14 12:44:54', null, null, null, '1475', '0');
INSERT INTO `by_member_detail_aud` VALUES ('912', null, null, 'b27a069faff2948eb3b970c997e168d32da451815963429f7818bec51decd790', null, null, null, '2016-11-14 12:44:54', '2016-11-14 12:52:32', null, null, '1476', '1');
INSERT INTO `by_member_detail_aud` VALUES ('912', '', '佳乐路255弄38号202室', 'b27a069faff2948eb3b970c997e168d32da451815963429f7818bec51decd790', '1992-02-22 00:00:00', null, '310115199202224728', '2016-11-14 12:44:54', '2016-11-14 12:53:15', null, null, '1477', '1');
INSERT INTO `by_member_detail_aud` VALUES ('913', null, null, null, null, null, null, '2016-11-14 20:32:53', null, null, null, '1478', '0');
INSERT INTO `by_member_detail_aud` VALUES ('914', null, null, null, null, null, null, '2016-11-15 22:58:03', null, null, null, '1479', '0');
INSERT INTO `by_member_detail_aud` VALUES ('915', null, null, null, null, null, null, '2016-11-16 14:52:56', null, null, null, '1480', '0');
INSERT INTO `by_member_detail_aud` VALUES ('915', '岳柱', '', null, null, null, '', '2016-11-16 14:52:56', '2016-11-16 14:53:22', null, null, '1481', '1');
INSERT INTO `by_member_detail_aud` VALUES ('916', null, null, null, null, null, null, '2016-11-17 11:21:14', null, null, null, '1482', '0');
INSERT INTO `by_member_detail_aud` VALUES ('917', null, null, null, null, null, null, '2016-11-17 17:10:25', null, null, null, '1483', '0');
INSERT INTO `by_member_detail_aud` VALUES ('918', null, null, null, null, null, null, '2016-11-17 19:33:51', null, null, null, '1484', '0');
INSERT INTO `by_member_detail_aud` VALUES ('918', '吴征宇', '', null, null, null, '', '2016-11-17 19:33:51', '2016-11-17 19:34:15', null, null, '1485', '1');
INSERT INTO `by_member_detail_aud` VALUES ('919', null, null, null, null, null, null, '2016-11-17 21:30:56', null, null, null, '1486', '0');
INSERT INTO `by_member_detail_aud` VALUES ('919', '陆茹玉', '', null, '1988-01-08 00:00:00', null, '', '2016-11-17 21:30:56', '2016-11-17 21:31:59', null, null, '1487', '1');
INSERT INTO `by_member_detail_aud` VALUES ('920', null, null, null, null, null, null, '2016-11-17 22:01:57', null, null, null, '1488', '0');
INSERT INTO `by_member_detail_aud` VALUES ('921', null, null, null, null, null, null, '2016-11-18 06:09:44', null, null, null, '1489', '0');
INSERT INTO `by_member_detail_aud` VALUES ('922', null, null, null, null, null, null, '2016-11-18 09:50:02', null, null, null, '1490', '0');
INSERT INTO `by_member_detail_aud` VALUES ('922', null, null, 'd1fc8c39cabb5c23186ac162a5d9a9594105a6ffa64236712598404fd74c46ae', null, null, null, '2016-11-18 09:50:02', '2016-11-18 09:51:57', null, null, '1491', '1');
INSERT INTO `by_member_detail_aud` VALUES ('922', '', '', 'd1fc8c39cabb5c23186ac162a5d9a9594105a6ffa64236712598404fd74c46ae', '1978-10-25 00:00:00', null, '310115197810251130', '2016-11-18 09:50:02', '2016-11-18 09:52:22', null, null, '1492', '1');
INSERT INTO `by_member_detail_aud` VALUES ('923', null, null, null, null, null, null, '2016-11-18 11:45:27', null, null, null, '1493', '0');
INSERT INTO `by_member_detail_aud` VALUES ('923', null, null, '8e1340a376d5715dbc2215950e1278912591ce9ef8396f09d3ae5b0ff03e9404', null, null, null, '2016-11-18 11:45:27', '2016-11-18 11:46:34', null, null, '1494', '1');
INSERT INTO `by_member_detail_aud` VALUES ('923', '', '上海市浦东新区东陆路2000弄18号501室', '8e1340a376d5715dbc2215950e1278912591ce9ef8396f09d3ae5b0ff03e9404', '1979-02-11 00:00:00', null, '342401197902110824', '2016-11-18 11:45:27', '2016-11-18 11:47:12', null, null, '1495', '1');
INSERT INTO `by_member_detail_aud` VALUES ('924', null, null, null, null, null, null, '2016-11-18 15:06:37', null, null, null, '1496', '0');
INSERT INTO `by_member_detail_aud` VALUES ('925', null, null, null, null, null, null, '2016-11-19 09:07:15', null, null, null, '1497', '0');
INSERT INTO `by_member_detail_aud` VALUES ('926', null, null, null, null, null, null, '2016-11-19 12:46:04', null, null, null, '1498', '0');
INSERT INTO `by_member_detail_aud` VALUES ('926', '楚玉勤', '', null, '1988-03-15 00:00:00', null, '', '2016-11-19 12:46:04', '2016-11-19 12:47:24', null, null, '1499', '1');
INSERT INTO `by_member_detail_aud` VALUES ('927', null, null, null, null, null, null, '2016-11-19 14:11:12', null, null, null, '1500', '0');
INSERT INTO `by_member_detail_aud` VALUES ('928', null, null, null, null, null, null, '2016-11-19 21:13:33', null, null, null, '1501', '0');
INSERT INTO `by_member_detail_aud` VALUES ('929', null, null, null, null, null, null, '2016-11-20 16:25:44', null, null, null, '1502', '0');
INSERT INTO `by_member_detail_aud` VALUES ('930', null, null, null, null, null, null, '2016-11-20 17:44:48', null, null, null, '1503', '0');
INSERT INTO `by_member_detail_aud` VALUES ('931', null, null, null, null, null, null, '2016-11-20 20:59:06', null, null, null, '1504', '0');
INSERT INTO `by_member_detail_aud` VALUES ('932', null, null, null, null, null, null, '2016-11-20 21:56:20', null, null, null, '1505', '0');
INSERT INTO `by_member_detail_aud` VALUES ('933', null, null, null, null, null, null, '2016-11-21 11:31:12', null, null, null, '1507', '0');
INSERT INTO `by_member_detail_aud` VALUES ('934', null, null, null, null, null, null, '2016-11-21 17:11:14', null, null, null, '1508', '0');
INSERT INTO `by_member_detail_aud` VALUES ('935', null, null, null, null, null, null, '2016-11-21 19:21:19', null, null, null, '1509', '0');
INSERT INTO `by_member_detail_aud` VALUES ('936', null, null, null, null, null, null, '2016-11-22 10:37:23', null, null, null, '1510', '0');
INSERT INTO `by_member_detail_aud` VALUES ('936', null, null, '6d19ca72de1fe7973e5a763cdbaf47af34674d4f45a8a2cacd881b751d680a4f', null, null, null, '2016-11-22 10:37:23', '2016-11-22 10:38:45', null, null, '1511', '1');
INSERT INTO `by_member_detail_aud` VALUES ('936', '', '佳林路898弄3号601', '6d19ca72de1fe7973e5a763cdbaf47af34674d4f45a8a2cacd881b751d680a4f', '1984-03-08 00:00:00', null, '362301198403082016', '2016-11-22 10:37:23', '2016-11-22 10:39:29', null, null, '1512', '1');
INSERT INTO `by_member_detail_aud` VALUES ('937', null, null, null, null, null, null, '2016-11-22 18:49:52', null, null, null, '1513', '0');
INSERT INTO `by_member_detail_aud` VALUES ('937', '夏惜', '', null, null, null, '', '2016-11-22 18:49:52', '2016-11-22 18:50:23', null, null, '1514', '1');
INSERT INTO `by_member_detail_aud` VALUES ('938', null, null, null, null, null, null, '2016-11-23 14:30:00', null, null, null, '1515', '0');
INSERT INTO `by_member_detail_aud` VALUES ('939', null, null, null, null, null, null, '2016-11-23 15:18:26', null, null, null, '1516', '0');
INSERT INTO `by_member_detail_aud` VALUES ('939', '', '', null, '1987-03-25 00:00:00', null, '', '2016-11-23 15:18:26', '2016-11-23 15:19:25', null, null, '1517', '1');
INSERT INTO `by_member_detail_aud` VALUES ('940', null, null, null, null, null, null, '2016-11-23 15:58:09', null, null, null, '1518', '0');
INSERT INTO `by_member_detail_aud` VALUES ('941', null, null, null, null, null, null, '2016-11-23 20:42:37', null, null, null, '1519', '0');
INSERT INTO `by_member_detail_aud` VALUES ('942', null, null, null, null, null, null, '2016-11-24 11:51:53', null, null, null, '1520', '0');
INSERT INTO `by_member_detail_aud` VALUES ('943', null, null, null, null, null, null, '2016-11-26 10:41:34', null, null, null, '1521', '0');
INSERT INTO `by_member_detail_aud` VALUES ('944', null, null, null, null, null, null, '2016-11-26 19:07:32', null, null, null, '1522', '0');
INSERT INTO `by_member_detail_aud` VALUES ('945', null, null, null, null, null, null, '2016-11-27 11:20:59', null, null, null, '1523', '0');
INSERT INTO `by_member_detail_aud` VALUES ('946', null, null, null, null, null, null, '2016-11-27 12:42:38', null, null, null, '1524', '0');
INSERT INTO `by_member_detail_aud` VALUES ('947', null, null, null, null, null, null, '2016-11-27 14:18:03', null, null, null, '1525', '0');

-- ----------------------------
-- Table structure for by_member_help
-- ----------------------------
DROP TABLE IF EXISTS `by_member_help`;
CREATE TABLE `by_member_help` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_id` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `content_id` (`content_id`) USING BTREE,
  CONSTRAINT `by_member_help_ibfk_1` FOREIGN KEY (`content_id`) REFERENCES `by_content` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_member_help
-- ----------------------------
INSERT INTO `by_member_help` VALUES ('1', '19', '注册协议', null, null, null, null);
INSERT INTO `by_member_help` VALUES ('2', '18', '会员权益', null, null, null, null);

-- ----------------------------
-- Table structure for by_member_license
-- ----------------------------
DROP TABLE IF EXISTS `by_member_license`;
CREATE TABLE `by_member_license` (
  `member_id` bigint(20) NOT NULL,
  `license_id` bigint(20) NOT NULL,
  PRIMARY KEY (`member_id`,`license_id`),
  KEY `license_id` (`license_id`) USING BTREE,
  CONSTRAINT `by_member_license_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`),
  CONSTRAINT `by_member_license_ibfk_2` FOREIGN KEY (`license_id`) REFERENCES `by_license` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_member_license
-- ----------------------------

-- ----------------------------
-- Table structure for by_menu
-- ----------------------------
DROP TABLE IF EXISTS `by_menu`;
CREATE TABLE `by_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET gb2312 DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `href` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `category_id` (`category_id`) USING BTREE,
  CONSTRAINT `by_menu_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `by_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_menu
-- ----------------------------
INSERT INTO `by_menu` VALUES ('1', '会员卡类型', '1', '/admin/cards');
INSERT INTO `by_menu` VALUES ('2', '会员管理', '1', '/admin/members');
INSERT INTO `by_menu` VALUES ('3', '会员黑名单管理', '1', '/admin/blackList');
INSERT INTO `by_menu` VALUES ('4', '会员卡积分规则', '2', '/admin/cardRules');
INSERT INTO `by_menu` VALUES ('5', '店铺积分规则', '2', '/admin/shopRules');
INSERT INTO `by_menu` VALUES ('6', '人工积分', '2', '/admin/manual/add');
INSERT INTO `by_menu` VALUES ('7', '退货', '2', '/admin/manual/minus');
INSERT INTO `by_menu` VALUES ('8', '礼品券兑换', '2', '/admin/giftCouponMember');
INSERT INTO `by_menu` VALUES ('9', '停车券', '3', '/admin/parkingCoupons');
INSERT INTO `by_menu` VALUES ('10', '礼品券', '3', '/admin/giftCoupons');
INSERT INTO `by_menu` VALUES ('11', '店铺券', '3', '/admin/shopCoupons');
INSERT INTO `by_menu` VALUES ('12', '店铺管理', '4', '/admin/shops');
INSERT INTO `by_menu` VALUES ('13', '注册协议', '5', '/admin/helps/1');
INSERT INTO `by_menu` VALUES ('14', '会员权益', '5', '/admin/helps/2');
INSERT INTO `by_menu` VALUES ('16', '权限管理', '6', '/admin/authorities');
INSERT INTO `by_menu` VALUES ('17', '用户管理', '6', '/admin/users');
INSERT INTO `by_menu` VALUES ('18', '账户设置', '6', '/admin/password');
INSERT INTO `by_menu` VALUES ('19', '会员报表', '8', '/admin/memberReport');
INSERT INTO `by_menu` VALUES ('20', '交易报表', '8', '/admin/tradingReport');
INSERT INTO `by_menu` VALUES ('21', '停车报表', '8', '/admin/parkingCouponReport');
INSERT INTO `by_menu` VALUES ('22', '店铺券报表', '8', '/admin/shopCouponReport');
INSERT INTO `by_menu` VALUES ('23', '礼品券报表', '8', '/admin/giftCouponReport');
INSERT INTO `by_menu` VALUES ('24', '业态管理', '6', '/admin/shopCategories');

-- ----------------------------
-- Table structure for by_offline_activity
-- ----------------------------
DROP TABLE IF EXISTS `by_offline_activity`;
CREATE TABLE `by_offline_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` int(11) DEFAULT '0' COMMENT '0:未生效，1:生效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of by_offline_activity
-- ----------------------------
INSERT INTO `by_offline_activity` VALUES ('1', '1');

-- ----------------------------
-- Table structure for by_offline_activity_coupon
-- ----------------------------
DROP TABLE IF EXISTS `by_offline_activity_coupon`;
CREATE TABLE `by_offline_activity_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activity_id` int(11) DEFAULT NULL,
  `shop_coupon_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shop_coupon_id` (`shop_coupon_id`),
  KEY `activity_id` (`activity_id`),
  CONSTRAINT `by_offline_activity_coupon_ibfk_2` FOREIGN KEY (`shop_coupon_id`) REFERENCES `by_coupon` (`id`),
  CONSTRAINT `by_offline_activity_coupon_ibfk_3` FOREIGN KEY (`activity_id`) REFERENCES `by_offline_activity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of by_offline_activity_coupon
-- ----------------------------
INSERT INTO `by_offline_activity_coupon` VALUES ('4', '1', '4');

-- ----------------------------
-- Table structure for by_parking_coupon_count
-- ----------------------------
DROP TABLE IF EXISTS `by_parking_coupon_count`;
CREATE TABLE `by_parking_coupon_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total` int(11) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  CONSTRAINT `by_parking_coupon_count_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_parking_coupon_count
-- ----------------------------

-- ----------------------------
-- Table structure for by_parking_coupon_exchange_history
-- ----------------------------
DROP TABLE IF EXISTS `by_parking_coupon_exchange_history`;
CREATE TABLE `by_parking_coupon_exchange_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  KEY `coupon_id` (`coupon_id`) USING BTREE,
  CONSTRAINT `by_parking_coupon_exchange_history_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`),
  CONSTRAINT `by_parking_coupon_exchange_history_ibfk_2` FOREIGN KEY (`coupon_id`) REFERENCES `by_coupon` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_parking_coupon_exchange_history
-- ----------------------------

-- ----------------------------
-- Table structure for by_parking_coupon_member
-- ----------------------------
DROP TABLE IF EXISTS `by_parking_coupon_member`;
CREATE TABLE `by_parking_coupon_member` (
  `member_id` bigint(20) NOT NULL DEFAULT '0',
  `coupon_id` int(11) NOT NULL DEFAULT '0',
  `total` int(11) DEFAULT NULL,
  PRIMARY KEY (`member_id`,`coupon_id`),
  KEY `coupon_id` (`coupon_id`) USING BTREE,
  CONSTRAINT `by_parking_coupon_member_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`),
  CONSTRAINT `by_parking_coupon_member_ibfk_2` FOREIGN KEY (`coupon_id`) REFERENCES `by_coupon` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_parking_coupon_member
-- ----------------------------

-- ----------------------------
-- Table structure for by_parking_coupon_use_history
-- ----------------------------
DROP TABLE IF EXISTS `by_parking_coupon_use_history`;
CREATE TABLE `by_parking_coupon_use_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `parking_coupon_id` int(11) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `license` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  KEY `parking_coupon_id` (`parking_coupon_id`) USING BTREE,
  CONSTRAINT `by_parking_coupon_use_history_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`),
  CONSTRAINT `by_parking_coupon_use_history_ibfk_2` FOREIGN KEY (`parking_coupon_id`) REFERENCES `by_coupon` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_parking_coupon_use_history
-- ----------------------------

-- ----------------------------
-- Table structure for by_parking_history
-- ----------------------------
DROP TABLE IF EXISTS `by_parking_history`;
CREATE TABLE `by_parking_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `license` varchar(20) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `amount` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  CONSTRAINT `by_parking_history_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_parking_history
-- ----------------------------

-- ----------------------------
-- Table structure for by_parking_withnomember_history
-- ----------------------------
DROP TABLE IF EXISTS `by_parking_withnomember_history`;
CREATE TABLE `by_parking_withnomember_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `license` varchar(20) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_parking_withnomember_history
-- ----------------------------

-- ----------------------------
-- Table structure for by_pay
-- ----------------------------
DROP TABLE IF EXISTS `by_pay`;
CREATE TABLE `by_pay` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `license` varchar(20) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `parkingPayType` smallint(6) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  CONSTRAINT `by_pay_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_pay
-- ----------------------------

-- ----------------------------
-- Table structure for by_rejected_goods
-- ----------------------------
DROP TABLE IF EXISTS `by_rejected_goods`;
CREATE TABLE `by_rejected_goods` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mobile` char(11) DEFAULT NULL,
  `shopName` varchar(50) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shopName` (`shopName`) USING BTREE,
  KEY `mobile` (`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_rejected_goods
-- ----------------------------
INSERT INTO `by_rejected_goods` VALUES ('16', '18261533057', '测试店铺', '50', '2016-11-25 16:45:14', 'terry');

-- ----------------------------
-- Table structure for by_rule
-- ----------------------------
DROP TABLE IF EXISTS `by_rule`;
CREATE TABLE `by_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rate` double DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  `card_id` int(11) DEFAULT NULL,
  `summary` varchar(50) DEFAULT NULL,
  `valid` smallint(6) DEFAULT '1',
  `beginTime` timestamp NULL DEFAULT NULL,
  `endTime` timestamp NULL DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_rule_name_unique` (`name`) USING BTREE,
  KEY `card_id` (`card_id`) USING BTREE,
  KEY `category_id` (`category_id`) USING BTREE,
  CONSTRAINT `by_rule_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `by_card` (`id`),
  CONSTRAINT `by_rule_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `by_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_rule
-- ----------------------------
INSERT INTO `by_rule` VALUES ('68', '1', '0', '1', null, '0', '2016-08-16 00:00:00', '2017-01-01 11:59:59', '9', '开业试运营', 'c', null, null, null, 'terry');
INSERT INTO `by_rule` VALUES ('70', '1', '0', null, null, '0', null, null, null, '测试店铺交易规则1', 's', null, null, null, 'terry');
INSERT INTO `by_rule` VALUES ('71', '2', '0', null, null, '0', '2016-11-25 00:00:00', '2016-12-03 11:59:59', null, '测试店铺交易规则2', 's', null, null, null, 'terry');
INSERT INTO `by_rule` VALUES ('72', '2', '20', null, null, '1', '2016-11-25 00:00:00', '2016-11-30 23:59:59', null, '测试店铺交易规则3', 's', null, null, null, 'terry');

-- ----------------------------
-- Table structure for by_rule_aud
-- ----------------------------
DROP TABLE IF EXISTS `by_rule_aud`;
CREATE TABLE `by_rule_aud` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rate` double DEFAULT NULL,
  `score` int(11) DEFAULT '0',
  `card_id` int(11) DEFAULT NULL,
  `summary` varchar(50) DEFAULT NULL,
  `valid` smallint(6) DEFAULT '1',
  `beginTime` timestamp NULL DEFAULT NULL,
  `endTime` timestamp NULL DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `REV` int(11) NOT NULL,
  `REVTYPE` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`,`REV`),
  KEY `card_id` (`card_id`) USING BTREE,
  KEY `category_id` (`category_id`) USING BTREE,
  CONSTRAINT `by_rule_aud_ibfk_1` FOREIGN KEY (`card_id`) REFERENCES `by_card` (`id`),
  CONSTRAINT `by_rule_aud_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `by_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_rule_aud
-- ----------------------------
INSERT INTO `by_rule_aud` VALUES ('68', '1', '0', '1', null, '1', '2016-08-16 00:00:00', '2016-12-31 23:59:59', '9', '开业试运营', 'c', null, null, null, 'terry', '243', '0');
INSERT INTO `by_rule_aud` VALUES ('68', '1', '0', '1', null, '0', '2016-08-16 00:00:00', '2017-01-01 11:59:59', '9', '开业试运营', 'c', null, null, null, 'terry', '1526', '1');

-- ----------------------------
-- Table structure for by_score_add_history
-- ----------------------------
DROP TABLE IF EXISTS `by_score_add_history`;
CREATE TABLE `by_score_add_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total` int(11) DEFAULT NULL,
  `reason` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  CONSTRAINT `by_score_add_history_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1304 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_score_add_history
-- ----------------------------
INSERT INTO `by_score_add_history` VALUES ('372', '37', '2016-09-06 00:12:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('373', '38', '2016-09-06 11:58:22', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('374', '39', '2016-09-06 16:43:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('375', '40', '2016-09-06 16:49:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('376', '41', '2016-09-06 16:49:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('377', '42', '2016-09-06 16:49:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('378', '43', '2016-09-07 13:49:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('379', '44', '2016-09-07 13:50:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('380', '45', '2016-09-07 13:50:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('381', '46', '2016-09-07 13:50:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('382', '47', '2016-09-07 22:15:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('383', '48', '2016-09-07 22:15:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('384', '49', '2016-09-07 22:21:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('385', '50', '2016-09-07 23:01:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('386', '51', '2016-09-07 23:18:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('387', '52', '2016-09-07 23:46:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('388', '53', '2016-09-08 00:02:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('389', '54', '2016-09-08 00:06:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('390', '55', '2016-09-08 00:07:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('391', '56', '2016-09-08 00:18:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('392', '57', '2016-09-08 01:05:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('393', '58', '2016-09-08 01:17:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('394', '59', '2016-09-08 05:46:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('395', '60', '2016-09-08 05:50:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('396', '61', '2016-09-08 06:47:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('397', '62', '2016-09-08 06:53:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('398', '63', '2016-09-08 06:58:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('399', '64', '2016-09-08 07:06:50', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('400', '65', '2016-09-08 07:13:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('401', '66', '2016-09-08 07:30:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('402', '67', '2016-09-08 07:30:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('403', '68', '2016-09-08 08:02:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('404', '69', '2016-09-08 08:18:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('405', '70', '2016-09-08 08:21:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('406', '71', '2016-09-08 08:46:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('407', '72', '2016-09-08 09:01:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('408', '73', '2016-09-08 09:04:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('409', '74', '2016-09-08 09:08:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('410', '75', '2016-09-08 09:12:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('411', '76', '2016-09-08 09:22:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('412', '77', '2016-09-08 09:30:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('413', '78', '2016-09-08 09:30:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('414', '79', '2016-09-08 09:34:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('415', '80', '2016-09-08 09:35:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('416', '81', '2016-09-08 09:56:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('417', '82', '2016-09-08 09:58:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('418', '83', '2016-09-08 09:59:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('419', '84', '2016-09-08 10:17:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('420', '85', '2016-09-08 10:20:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('421', '86', '2016-09-08 10:44:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('422', '87', '2016-09-08 10:46:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('423', '88', '2016-09-08 10:50:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('424', '89', '2016-09-08 10:52:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('425', '90', '2016-09-08 10:56:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('426', '91', '2016-09-08 10:59:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('427', '92', '2016-09-08 11:03:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('428', '93', '2016-09-08 11:03:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('429', '94', '2016-09-08 11:04:41', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('430', '95', '2016-09-08 11:11:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('431', '96', '2016-09-08 11:21:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('432', '97', '2016-09-08 11:21:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('433', '98', '2016-09-08 11:24:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('434', '99', '2016-09-08 11:39:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('435', '100', '2016-09-08 11:50:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('436', '101', '2016-09-08 11:51:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('437', '102', '2016-09-08 12:01:22', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('438', '103', '2016-09-08 12:03:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('439', '104', '2016-09-08 12:03:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('440', '105', '2016-09-08 12:08:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('441', '106', '2016-09-08 12:20:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('442', '107', '2016-09-08 12:29:41', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('443', '108', '2016-09-08 12:46:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('444', '109', '2016-09-08 12:46:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('445', '110', '2016-09-08 12:50:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('446', '111', '2016-09-08 12:55:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('447', '112', '2016-09-08 13:01:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('448', '113', '2016-09-08 13:22:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('449', '114', '2016-09-08 13:24:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('450', '115', '2016-09-08 13:25:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('451', '116', '2016-09-08 13:25:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('452', '117', '2016-09-08 13:29:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('453', '118', '2016-09-08 13:41:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('454', '119', '2016-09-08 13:49:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('455', '120', '2016-09-08 13:50:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('456', '121', '2016-09-08 13:50:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('457', '122', '2016-09-08 13:51:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('458', '123', '2016-09-08 14:06:50', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('459', '124', '2016-09-08 14:08:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('460', '125', '2016-09-08 14:10:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('461', '126', '2016-09-08 14:12:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('462', '127', '2016-09-08 14:31:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('463', '128', '2016-09-08 14:34:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('464', '129', '2016-09-08 14:38:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('465', '130', '2016-09-08 14:39:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('466', '131', '2016-09-08 14:41:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('467', '132', '2016-09-08 14:55:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('468', '133', '2016-09-08 15:01:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('469', '134', '2016-09-08 15:01:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('470', '135', '2016-09-08 15:10:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('471', '136', '2016-09-08 15:18:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('472', '137', '2016-09-08 15:20:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('473', '138', '2016-09-08 15:35:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('474', '139', '2016-09-08 15:46:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('475', '140', '2016-09-08 15:58:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('476', '141', '2016-09-08 16:05:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('477', '142', '2016-09-08 16:16:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('478', '143', '2016-09-08 16:34:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('479', '144', '2016-09-08 16:35:41', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('480', '145', '2016-09-08 17:04:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('481', '146', '2016-09-08 17:11:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('482', '147', '2016-09-08 17:13:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('483', '148', '2016-09-08 17:14:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('484', '149', '2016-09-08 17:24:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('485', '150', '2016-09-08 18:10:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('486', '151', '2016-09-08 18:15:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('487', '152', '2016-09-08 18:17:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('488', '153', '2016-09-08 18:17:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('489', '154', '2016-09-08 18:18:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('490', '155', '2016-09-08 18:24:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('491', '156', '2016-09-08 18:24:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('492', '157', '2016-09-08 18:36:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('493', '158', '2016-09-08 18:42:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('494', '159', '2016-09-08 18:57:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('495', '160', '2016-09-08 19:02:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('496', '161', '2016-09-08 19:14:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('497', '162', '2016-09-08 19:28:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('498', '163', '2016-09-08 19:31:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('499', '164', '2016-09-08 19:36:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('500', '165', '2016-09-08 19:42:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('501', '166', '2016-09-08 19:45:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('502', '167', '2016-09-08 19:45:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('503', '168', '2016-09-08 19:57:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('504', '169', '2016-09-08 20:00:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('505', '170', '2016-09-08 20:02:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('506', '171', '2016-09-08 20:07:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('507', '172', '2016-09-08 20:11:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('508', '173', '2016-09-08 20:17:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('509', '174', '2016-09-08 20:37:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('510', '175', '2016-09-08 20:45:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('511', '176', '2016-09-08 20:57:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('512', '177', '2016-09-08 20:58:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('513', '178', '2016-09-08 21:03:22', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('514', '179', '2016-09-08 21:15:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('515', '180', '2016-09-08 21:35:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('516', '181', '2016-09-08 21:37:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('517', '182', '2016-09-08 21:40:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('518', '183', '2016-09-08 21:49:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('519', '184', '2016-09-08 21:52:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('520', '185', '2016-09-08 21:54:50', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('521', '186', '2016-09-08 21:55:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('522', '187', '2016-09-08 21:59:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('523', '188', '2016-09-08 22:03:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('524', '189', '2016-09-08 22:24:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('525', '190', '2016-09-08 22:49:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('526', '191', '2016-09-08 22:52:22', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('527', '192', '2016-09-08 22:58:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('528', '193', '2016-09-08 23:03:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('529', '194', '2016-09-08 23:08:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('530', '195', '2016-09-08 23:11:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('531', '196', '2016-09-08 23:41:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('532', '197', '2016-09-09 00:26:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('533', '198', '2016-09-09 01:44:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('534', '199', '2016-09-09 02:51:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('535', '200', '2016-09-09 06:29:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('536', '201', '2016-09-09 06:49:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('537', '202', '2016-09-09 07:03:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('538', '203', '2016-09-09 07:13:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('539', '204', '2016-09-09 07:16:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('540', '205', '2016-09-09 07:20:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('541', '206', '2016-09-09 07:41:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('542', '207', '2016-09-09 07:45:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('543', '208', '2016-09-09 08:19:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('544', '209', '2016-09-09 09:07:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('545', '210', '2016-09-09 09:41:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('546', '211', '2016-09-09 09:43:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('547', '212', '2016-09-09 09:49:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('548', '213', '2016-09-09 10:02:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('549', '214', '2016-09-09 10:04:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('550', '215', '2016-09-09 10:11:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('551', '216', '2016-09-09 11:13:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('552', '217', '2016-09-09 11:18:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('553', '218', '2016-09-09 11:21:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('554', '219', '2016-09-09 11:23:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('555', '220', '2016-09-09 11:31:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('556', '221', '2016-09-09 11:42:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('557', '222', '2016-09-09 11:52:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('558', '223', '2016-09-09 12:11:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('559', '224', '2016-09-09 12:19:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('560', '225', '2016-09-09 12:27:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('561', '226', '2016-09-09 12:31:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('562', '227', '2016-09-09 14:04:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('563', '228', '2016-09-09 14:20:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('564', '229', '2016-09-09 14:34:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('565', '230', '2016-09-09 15:08:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('566', '231', '2016-09-09 15:47:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('567', '232', '2016-09-09 15:53:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('568', '233', '2016-09-09 16:53:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('569', '234', '2016-09-09 17:15:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('570', '235', '2016-09-09 17:59:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('571', '236', '2016-09-09 18:45:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('572', '237', '2016-09-09 19:01:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('573', '238', '2016-09-09 19:16:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('574', '239', '2016-09-09 19:34:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('575', '240', '2016-09-09 19:39:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('576', '241', '2016-09-09 19:49:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('577', '242', '2016-09-09 19:54:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('578', '243', '2016-09-09 19:56:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('579', '244', '2016-09-09 20:26:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('580', '245', '2016-09-09 20:43:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('581', '246', '2016-09-09 21:42:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('582', '247', '2016-09-09 22:06:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('583', '248', '2016-09-09 22:23:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('584', '249', '2016-09-10 07:38:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('585', '250', '2016-09-10 08:24:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('586', '251', '2016-09-10 08:48:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('587', '252', '2016-09-10 09:38:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('588', '253', '2016-09-10 09:59:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('589', '254', '2016-09-10 11:07:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('590', '255', '2016-09-10 11:39:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('591', '256', '2016-09-10 12:07:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('592', '257', '2016-09-10 12:19:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('593', '258', '2016-09-10 12:44:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('594', '259', '2016-09-10 13:28:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('595', '260', '2016-09-10 13:50:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('596', '261', '2016-09-10 14:21:50', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('597', '262', '2016-09-10 14:37:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('598', '263', '2016-09-10 14:38:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('599', '264', '2016-09-10 14:46:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('600', '265', '2016-09-10 14:59:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('601', '266', '2016-09-10 15:50:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('602', '267', '2016-09-10 16:14:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('603', '268', '2016-09-10 16:20:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('604', '269', '2016-09-10 16:27:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('605', '270', '2016-09-10 16:39:22', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('606', '271', '2016-09-10 16:42:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('607', '272', '2016-09-10 17:02:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('608', '273', '2016-09-10 17:03:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('609', '274', '2016-09-10 17:03:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('610', '275', '2016-09-10 17:36:50', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('611', '276', '2016-09-10 18:07:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('612', '277', '2016-09-10 18:45:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('613', '278', '2016-09-10 18:54:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('614', '279', '2016-09-10 19:16:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('615', '280', '2016-09-10 19:17:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('616', '281', '2016-09-10 19:42:22', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('617', '282', '2016-09-10 19:49:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('618', '283', '2016-09-10 20:10:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('619', '284', '2016-09-10 20:13:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('620', '285', '2016-09-10 20:25:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('621', '286', '2016-09-10 20:31:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('622', '287', '2016-09-10 20:34:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('623', '288', '2016-09-10 21:15:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('624', '289', '2016-09-10 21:41:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('625', '290', '2016-09-10 21:46:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('626', '291', '2016-09-10 22:17:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('627', '292', '2016-09-10 22:20:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('628', '293', '2016-09-10 22:31:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('629', '294', '2016-09-10 22:31:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('630', '295', '2016-09-11 00:47:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('631', '296', '2016-09-11 08:22:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('632', '297', '2016-09-11 08:59:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('633', '298', '2016-09-11 09:27:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('634', '299', '2016-09-11 09:54:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('635', '300', '2016-09-11 09:57:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('636', '301', '2016-09-11 10:56:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('637', '302', '2016-09-11 11:36:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('638', '303', '2016-09-11 11:47:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('639', '304', '2016-09-11 11:56:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('640', '305', '2016-09-11 12:04:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('641', '306', '2016-09-11 12:28:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('642', '307', '2016-09-11 12:30:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('643', '308', '2016-09-11 13:03:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('644', '309', '2016-09-11 13:10:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('645', '310', '2016-09-11 14:12:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('646', '311', '2016-09-11 14:13:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('647', '312', '2016-09-11 14:27:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('648', '313', '2016-09-11 14:28:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('649', '314', '2016-09-11 15:24:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('650', '315', '2016-09-11 15:36:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('651', '316', '2016-09-11 16:29:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('652', '317', '2016-09-11 16:58:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('653', '318', '2016-09-11 17:04:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('654', '319', '2016-09-11 17:50:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('655', '320', '2016-09-11 18:02:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('656', '321', '2016-09-11 18:30:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('657', '322', '2016-09-11 18:43:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('658', '323', '2016-09-11 20:02:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('659', '324', '2016-09-11 20:17:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('660', '325', '2016-09-11 20:36:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('661', '326', '2016-09-11 20:36:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('662', '327', '2016-09-11 20:37:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('663', '328', '2016-09-11 20:37:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('664', '329', '2016-09-11 20:38:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('665', '330', '2016-09-11 20:39:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('666', '331', '2016-09-11 20:39:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('667', '332', '2016-09-11 20:40:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('668', '333', '2016-09-11 20:42:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('669', '334', '2016-09-11 20:43:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('670', '335', '2016-09-11 20:45:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('671', '336', '2016-09-11 20:46:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('672', '337', '2016-09-11 20:46:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('673', '338', '2016-09-11 20:47:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('674', '339', '2016-09-11 20:47:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('675', '340', '2016-09-11 20:47:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('676', '341', '2016-09-11 20:47:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('677', '342', '2016-09-11 20:48:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('678', '343', '2016-09-11 20:49:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('679', '344', '2016-09-11 20:49:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('680', '345', '2016-09-11 20:49:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('681', '346', '2016-09-11 20:50:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('682', '347', '2016-09-11 20:51:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('683', '348', '2016-09-11 20:54:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('684', '349', '2016-09-11 20:54:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('685', '350', '2016-09-11 20:56:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('686', '351', '2016-09-11 20:58:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('687', '352', '2016-09-11 20:59:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('688', '353', '2016-09-11 21:02:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('689', '354', '2016-09-11 21:04:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('690', '355', '2016-09-11 21:10:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('691', '356', '2016-09-11 21:10:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('692', '357', '2016-09-11 21:14:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('693', '358', '2016-09-11 21:15:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('694', '359', '2016-09-11 21:15:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('695', '360', '2016-09-11 21:18:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('696', '361', '2016-09-11 21:18:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('697', '362', '2016-09-11 21:19:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('698', '363', '2016-09-11 21:21:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('699', '364', '2016-09-11 21:22:22', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('700', '365', '2016-09-11 21:22:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('701', '366', '2016-09-11 21:22:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('702', '367', '2016-09-11 21:24:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('703', '368', '2016-09-11 21:25:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('704', '369', '2016-09-11 21:26:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('705', '370', '2016-09-11 21:30:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('706', '371', '2016-09-11 21:32:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('707', '372', '2016-09-11 21:36:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('708', '373', '2016-09-11 21:38:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('709', '374', '2016-09-11 21:44:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('710', '375', '2016-09-11 21:53:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('711', '376', '2016-09-11 21:53:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('712', '377', '2016-09-11 21:55:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('713', '378', '2016-09-11 21:59:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('714', '379', '2016-09-11 22:03:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('715', '380', '2016-09-11 22:08:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('716', '381', '2016-09-11 22:15:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('717', '382', '2016-09-11 22:21:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('718', '383', '2016-09-11 22:24:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('719', '384', '2016-09-11 22:26:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('720', '385', '2016-09-11 22:29:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('721', '386', '2016-09-11 22:33:41', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('722', '387', '2016-09-11 22:35:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('723', '388', '2016-09-11 22:38:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('724', '389', '2016-09-11 22:47:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('725', '390', '2016-09-11 23:42:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('726', '391', '2016-09-11 23:58:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('727', '392', '2016-09-12 01:08:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('728', '393', '2016-09-12 01:21:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('729', '394', '2016-09-12 04:43:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('730', '395', '2016-09-12 05:57:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('731', '396', '2016-09-12 06:45:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('732', '397', '2016-09-12 07:05:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('733', '398', '2016-09-12 07:14:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('734', '399', '2016-09-12 07:58:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('735', '400', '2016-09-12 08:46:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('736', '401', '2016-09-12 08:52:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('737', '402', '2016-09-12 09:10:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('738', '403', '2016-09-12 09:19:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('739', '404', '2016-09-12 09:24:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('740', '405', '2016-09-12 09:47:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('741', '406', '2016-09-12 09:52:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('742', '407', '2016-09-12 09:56:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('743', '408', '2016-09-12 10:11:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('744', '409', '2016-09-12 10:21:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('745', '410', '2016-09-12 11:33:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('746', '411', '2016-09-12 12:32:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('747', '412', '2016-09-12 12:46:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('748', '413', '2016-09-12 13:06:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('749', '414', '2016-09-12 14:15:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('750', '415', '2016-09-12 15:22:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('751', '416', '2016-09-12 15:30:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('752', '417', '2016-09-12 16:40:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('753', '418', '2016-09-12 17:01:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('754', '419', '2016-09-12 17:13:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('755', '420', '2016-09-12 18:06:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('756', '421', '2016-09-12 18:51:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('757', '422', '2016-09-12 19:05:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('758', '423', '2016-09-12 19:39:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('759', '424', '2016-09-12 20:47:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('760', '425', '2016-09-12 21:01:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('761', '426', '2016-09-12 22:18:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('762', '427', '2016-09-13 07:55:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('763', '428', '2016-09-13 13:36:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('764', '429', '2016-09-13 14:21:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('765', '430', '2016-09-13 14:22:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('766', '431', '2016-09-13 15:30:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('767', '432', '2016-09-13 16:18:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('768', '433', '2016-09-13 16:38:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('769', '434', '2016-09-13 17:30:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('770', '435', '2016-09-13 18:23:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('771', '436', '2016-09-13 19:23:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('772', '437', '2016-09-13 22:24:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('773', '438', '2016-09-13 22:32:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('774', '439', '2016-09-14 08:20:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('775', '440', '2016-09-14 08:22:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('776', '441', '2016-09-14 09:23:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('777', '442', '2016-09-14 10:32:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('778', '443', '2016-09-14 11:00:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('779', '444', '2016-09-14 11:11:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('780', '445', '2016-09-14 11:13:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('781', '446', '2016-09-14 11:38:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('782', '447', '2016-09-14 12:30:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('783', '448', '2016-09-14 14:56:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('784', '449', '2016-09-14 15:00:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('785', '450', '2016-09-14 15:20:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('786', '451', '2016-09-14 15:33:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('787', '452', '2016-09-14 15:40:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('788', '453', '2016-09-14 15:43:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('789', '454', '2016-09-14 15:46:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('790', '455', '2016-09-14 15:47:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('791', '456', '2016-09-14 15:47:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('792', '457', '2016-09-14 15:48:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('793', '458', '2016-09-14 15:53:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('794', '459', '2016-09-14 15:53:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('795', '460', '2016-09-14 15:58:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('796', '461', '2016-09-14 16:00:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('797', '462', '2016-09-14 16:21:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('798', '463', '2016-09-14 16:24:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('799', '464', '2016-09-14 16:38:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('800', '465', '2016-09-14 16:40:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('801', '466', '2016-09-14 16:41:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('802', '467', '2016-09-14 16:53:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('803', '468', '2016-09-14 17:03:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('804', '469', '2016-09-14 17:10:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('805', '470', '2016-09-14 17:10:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('806', '471', '2016-09-14 18:24:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('807', '472', '2016-09-14 19:12:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('808', '473', '2016-09-14 20:04:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('809', '474', '2016-09-14 21:12:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('810', '475', '2016-09-14 21:12:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('811', '476', '2016-09-14 21:48:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('812', '477', '2016-09-14 23:39:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('813', '478', '2016-09-14 23:49:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('814', '479', '2016-09-15 07:01:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('815', '480', '2016-09-15 08:04:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('816', '481', '2016-09-15 09:09:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('817', '482', '2016-09-15 09:41:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('818', '483', '2016-09-15 11:08:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('819', '484', '2016-09-15 11:23:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('820', '485', '2016-09-15 11:37:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('821', '486', '2016-09-15 11:45:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('822', '487', '2016-09-15 13:06:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('823', '488', '2016-09-15 13:17:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('824', '489', '2016-09-15 13:18:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('825', '490', '2016-09-15 13:19:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('826', '491', '2016-09-15 13:22:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('827', '492', '2016-09-15 14:00:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('828', '493', '2016-09-15 14:33:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('829', '494', '2016-09-15 14:59:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('830', '495', '2016-09-15 15:15:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('831', '496', '2016-09-15 16:19:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('832', '497', '2016-09-15 19:42:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('833', '498', '2016-09-15 19:55:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('834', '499', '2016-09-15 20:14:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('835', '500', '2016-09-15 22:03:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('836', '501', '2016-09-15 22:32:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('837', '502', '2016-09-16 10:53:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('838', '503', '2016-09-16 11:41:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('839', '504', '2016-09-16 12:05:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('840', '505', '2016-09-16 12:54:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('841', '506', '2016-09-16 13:20:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('842', '507', '2016-09-16 14:48:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('843', '508', '2016-09-16 15:13:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('844', '509', '2016-09-16 16:02:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('845', '510', '2016-09-16 16:48:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('846', '511', '2016-09-16 17:09:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('847', '512', '2016-09-16 18:51:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('848', '513', '2016-09-16 19:42:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('849', '514', '2016-09-16 20:10:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('850', '515', '2016-09-16 22:54:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('851', '516', '2016-09-17 08:34:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('852', '517', '2016-09-17 10:21:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('853', '518', '2016-09-17 13:36:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('854', '519', '2016-09-17 13:57:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('855', '520', '2016-09-17 14:26:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('856', '521', '2016-09-17 16:33:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('857', '522', '2016-09-17 17:06:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('858', '523', '2016-09-17 17:11:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('859', '524', '2016-09-17 18:17:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('860', '525', '2016-09-17 18:27:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('861', '526', '2016-09-17 18:50:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('862', '527', '2016-09-17 19:36:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('863', '528', '2016-09-17 20:11:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('864', '529', '2016-09-17 21:18:50', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('865', '530', '2016-09-18 10:57:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('866', '531', '2016-09-18 13:40:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('867', '532', '2016-09-18 14:05:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('868', '533', '2016-09-18 14:24:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('869', '534', '2016-09-18 14:41:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('870', '535', '2016-09-18 14:47:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('871', '536', '2016-09-18 15:52:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('872', '537', '2016-09-18 17:11:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('873', '538', '2016-09-18 20:12:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('874', '539', '2016-09-18 20:39:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('875', '540', '2016-09-19 06:23:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('876', '541', '2016-09-19 08:24:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('877', '542', '2016-09-19 10:46:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('878', '543', '2016-09-19 12:29:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('879', '544', '2016-09-19 16:11:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('880', '545', '2016-09-19 20:03:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('881', '546', '2016-09-19 21:44:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('882', '547', '2016-09-20 10:10:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('883', '548', '2016-09-20 15:50:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('884', '549', '2016-09-20 18:03:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('885', '550', '2016-09-20 21:08:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('886', '551', '2016-09-20 21:53:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('887', '552', '2016-09-21 12:48:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('888', '553', '2016-09-21 21:11:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('889', '554', '2016-09-22 10:49:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('890', '555', '2016-09-22 11:04:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('891', '556', '2016-09-22 15:55:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('892', '557', '2016-09-22 16:40:41', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('893', '558', '2016-09-22 16:43:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('894', '559', '2016-09-22 17:56:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('895', '560', '2016-09-22 19:48:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('896', '561', '2016-09-22 20:12:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('897', '562', '2016-09-22 21:18:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('898', '563', '2016-09-22 22:09:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('899', '564', '2016-09-23 06:31:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('900', '565', '2016-09-23 10:49:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('901', '566', '2016-09-23 10:53:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('902', '567', '2016-09-23 12:27:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('903', '568', '2016-09-23 12:51:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('904', '569', '2016-09-23 14:34:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('905', '570', '2016-09-23 15:11:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('906', '571', '2016-09-23 17:28:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('907', '572', '2016-09-23 17:51:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('908', '573', '2016-09-23 19:48:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('909', '574', '2016-09-23 20:03:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('910', '575', '2016-09-23 20:59:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('911', '576', '2016-09-23 21:34:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('912', '577', '2016-09-24 09:03:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('913', '578', '2016-09-24 12:20:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('914', '579', '2016-09-24 12:51:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('915', '580', '2016-09-24 13:31:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('916', '581', '2016-09-24 13:41:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('917', '582', '2016-09-24 13:52:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('918', '583', '2016-09-24 14:32:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('919', '584', '2016-09-24 14:48:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('920', '585', '2016-09-24 16:40:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('921', '586', '2016-09-24 18:22:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('922', '587', '2016-09-24 18:45:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('923', '588', '2016-09-24 22:47:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('924', '589', '2016-09-24 23:05:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('925', '590', '2016-09-25 05:38:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('926', '591', '2016-09-25 11:26:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('927', '592', '2016-09-25 11:32:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('928', '593', '2016-09-25 11:38:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('929', '594', '2016-09-25 12:22:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('930', '595', '2016-09-25 14:52:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('931', '596', '2016-09-25 17:05:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('932', '597', '2016-09-25 17:45:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('933', '598', '2016-09-25 17:55:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('934', '599', '2016-09-25 17:57:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('935', '600', '2016-09-25 18:02:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('936', '601', '2016-09-25 18:08:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('937', '602', '2016-09-25 18:24:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('938', '603', '2016-09-25 18:56:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('939', '604', '2016-09-25 21:39:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('940', '605', '2016-09-26 18:51:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('941', '606', '2016-09-27 12:15:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('942', '607', '2016-09-27 15:22:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('943', '608', '2016-09-27 18:35:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('944', '609', '2016-09-27 21:12:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('945', '610', '2016-09-27 21:49:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('946', '611', '2016-09-27 21:54:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('947', '612', '2016-09-28 15:50:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('948', '613', '2016-09-28 16:55:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('949', '614', '2016-09-28 17:59:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('950', '615', '2016-09-28 22:31:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('951', '616', '2016-09-29 12:41:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('952', '617', '2016-09-29 12:42:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('953', '618', '2016-09-29 12:43:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('954', '619', '2016-09-29 12:46:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('955', '620', '2016-09-29 12:46:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('956', '621', '2016-09-29 12:49:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('957', '622', '2016-09-29 12:52:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('958', '623', '2016-09-29 12:59:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('959', '624', '2016-09-29 13:17:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('960', '625', '2016-09-29 13:43:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('961', '626', '2016-09-29 13:52:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('962', '627', '2016-09-29 14:23:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('963', '628', '2016-09-29 14:29:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('964', '629', '2016-09-29 15:26:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('965', '630', '2016-09-29 16:06:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('966', '631', '2016-09-29 16:10:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('967', '632', '2016-09-29 16:55:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('968', '633', '2016-09-29 17:00:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('969', '634', '2016-09-29 18:39:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('970', '635', '2016-09-29 18:40:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('971', '636', '2016-09-29 18:56:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('972', '637', '2016-09-30 11:01:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('973', '638', '2016-09-30 11:09:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('974', '639', '2016-09-30 17:18:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('975', '640', '2016-09-30 18:34:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('976', '641', '2016-09-30 20:21:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('977', '642', '2016-10-01 08:28:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('978', '643', '2016-10-01 10:39:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('979', '644', '2016-10-01 10:54:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('980', '645', '2016-10-01 10:57:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('981', '646', '2016-10-01 11:45:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('982', '647', '2016-10-01 11:56:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('983', '648', '2016-10-01 12:18:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('984', '649', '2016-10-01 12:21:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('985', '650', '2016-10-01 12:59:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('986', '651', '2016-10-01 14:02:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('987', '652', '2016-10-01 14:17:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('988', '653', '2016-10-01 14:26:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('989', '654', '2016-10-01 15:08:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('990', '655', '2016-10-01 15:14:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('991', '656', '2016-10-01 18:22:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('992', '657', '2016-10-01 18:35:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('993', '658', '2016-10-01 18:38:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('994', '659', '2016-10-01 20:19:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('995', '660', '2016-10-02 07:14:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('996', '661', '2016-10-02 10:32:50', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('997', '662', '2016-10-02 11:19:22', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('998', '663', '2016-10-02 12:04:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('999', '664', '2016-10-02 12:44:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1000', '665', '2016-10-02 14:40:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1001', '666', '2016-10-02 14:43:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1002', '667', '2016-10-02 17:23:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1003', '668', '2016-10-02 17:45:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1004', '669', '2016-10-02 19:32:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1005', '670', '2016-10-02 20:50:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1006', '671', '2016-10-02 20:55:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1007', '672', '2016-10-02 22:00:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1008', '673', '2016-10-03 10:22:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1009', '674', '2016-10-03 12:16:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1010', '675', '2016-10-03 12:24:41', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1011', '676', '2016-10-03 19:35:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1012', '677', '2016-10-04 11:02:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1013', '678', '2016-10-04 13:03:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1014', '679', '2016-10-04 14:41:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1015', '680', '2016-10-04 15:47:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1016', '681', '2016-10-04 17:19:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1017', '682', '2016-10-04 18:33:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1018', '683', '2016-10-04 18:37:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1019', '684', '2016-10-04 18:53:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1020', '685', '2016-10-04 20:03:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1021', '686', '2016-10-04 20:23:41', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1022', '687', '2016-10-04 21:09:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1023', '688', '2016-10-05 10:05:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1024', '689', '2016-10-05 11:08:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1025', '690', '2016-10-05 16:44:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1026', '691', '2016-10-05 17:28:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1027', '692', '2016-10-05 18:19:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1028', '693', '2016-10-05 18:29:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1029', '694', '2016-10-05 19:02:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1030', '695', '2016-10-05 19:43:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1031', '696', '2016-10-06 11:52:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1032', '697', '2016-10-06 12:08:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1033', '698', '2016-10-06 12:41:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1034', '699', '2016-10-06 14:23:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1035', '700', '2016-10-06 14:56:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1036', '701', '2016-10-06 14:59:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1037', '702', '2016-10-06 16:06:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1038', '703', '2016-10-06 16:10:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1039', '704', '2016-10-06 16:35:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1040', '705', '2016-10-06 17:17:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1041', '706', '2016-10-06 19:16:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1042', '707', '2016-10-06 19:39:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1043', '708', '2016-10-06 20:03:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1044', '709', '2016-10-06 20:37:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1045', '710', '2016-10-06 21:41:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1046', '711', '2016-10-06 22:41:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1047', '712', '2016-10-07 12:55:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1048', '713', '2016-10-07 13:18:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1049', '714', '2016-10-07 13:37:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1050', '715', '2016-10-07 13:42:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1051', '716', '2016-10-07 14:51:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1052', '717', '2016-10-07 16:25:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1053', '718', '2016-10-07 16:31:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1054', '719', '2016-10-07 17:32:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1055', '720', '2016-10-07 18:50:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1056', '721', '2016-10-07 20:25:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1057', '722', '2016-10-07 20:56:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1058', '723', '2016-10-07 21:22:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1059', '724', '2016-10-07 22:13:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1060', '725', '2016-10-08 07:25:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1061', '726', '2016-10-08 15:59:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1062', '727', '2016-10-08 20:33:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1063', '728', '2016-10-08 22:11:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1064', '729', '2016-10-09 12:04:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1065', '730', '2016-10-09 15:01:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1066', '731', '2016-10-09 21:07:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1067', '732', '2016-10-09 21:50:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1068', '733', '2016-10-10 16:47:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1069', '734', '2016-10-10 20:45:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1070', '735', '2016-10-11 10:09:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1071', '736', '2016-10-11 13:50:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1072', '737', '2016-10-12 12:31:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1073', '738', '2016-10-12 21:27:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1074', '739', '2016-10-13 07:09:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1076', '741', '2016-10-13 11:14:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1077', '742', '2016-10-13 18:49:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1078', '743', '2016-10-13 22:04:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1079', '744', '2016-10-14 18:46:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1080', '745', '2016-10-14 20:01:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1081', '746', '2016-10-14 20:06:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1082', '747', '2016-10-14 20:08:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1083', '748', '2016-10-14 20:20:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1084', '749', '2016-10-14 20:20:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1085', '750', '2016-10-14 20:23:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1086', '751', '2016-10-14 20:29:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1087', '752', '2016-10-14 20:34:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1088', '753', '2016-10-14 20:37:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1089', '754', '2016-10-14 20:39:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1090', '755', '2016-10-14 20:42:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1091', '756', '2016-10-14 21:10:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1092', '757', '2016-10-14 21:15:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1093', '758', '2016-10-14 21:24:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1094', '759', '2016-10-15 00:01:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1095', '760', '2016-10-15 10:31:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1096', '761', '2016-10-15 11:18:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1097', '762', '2016-10-15 11:27:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1098', '763', '2016-10-15 13:03:11', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1099', '764', '2016-10-15 13:34:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1100', '765', '2016-10-15 13:43:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1101', '766', '2016-10-15 15:26:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1102', '767', '2016-10-15 17:11:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1103', '768', '2016-10-15 17:28:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1104', '769', '2016-10-15 17:58:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1105', '770', '2016-10-16 12:10:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1106', '771', '2016-10-16 14:17:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1107', '772', '2016-10-16 16:39:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1108', '773', '2016-10-16 16:47:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1109', '774', '2016-10-16 17:56:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1110', '775', '2016-10-16 18:50:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1111', '776', '2016-10-16 22:29:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1112', '777', '2016-10-16 22:40:41', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1113', '778', '2016-10-17 11:53:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1114', '779', '2016-10-17 12:12:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1115', '780', '2016-10-17 13:19:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1116', '781', '2016-10-17 16:54:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1117', '782', '2016-10-18 09:33:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1118', '783', '2016-10-18 15:28:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1119', '784', '2016-10-18 17:33:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1120', '785', '2016-10-18 19:00:50', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1121', '786', '2016-10-19 10:38:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1122', '787', '2016-10-19 11:57:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1123', '788', '2016-10-20 13:28:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1124', '789', '2016-10-20 18:14:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1125', '790', '2016-10-20 18:35:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1126', '791', '2016-10-20 18:42:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1127', '792', '2016-10-20 19:07:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1128', '793', '2016-10-20 19:10:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1129', '794', '2016-10-20 19:13:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1130', '795', '2016-10-20 19:16:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1131', '796', '2016-10-20 19:21:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1132', '797', '2016-10-20 19:59:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1133', '798', '2016-10-20 21:14:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1134', '799', '2016-10-20 22:23:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1135', '800', '2016-10-20 23:18:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1136', '801', '2016-10-21 16:41:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1137', '802', '2016-10-21 22:11:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1138', '803', '2016-10-22 07:21:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1139', '804', '2016-10-22 10:52:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1140', '805', '2016-10-22 14:54:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1141', '806', '2016-10-22 15:59:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1142', '807', '2016-10-22 18:10:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1143', '808', '2016-10-22 19:22:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1144', '809', '2016-10-22 20:40:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1145', '810', '2016-10-22 23:06:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1146', '811', '2016-10-23 08:48:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1147', '812', '2016-10-23 10:34:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1148', '813', '2016-10-23 11:08:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1149', '814', '2016-10-23 12:20:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1150', '815', '2016-10-23 13:39:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1151', '816', '2016-10-23 15:44:42', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1152', '817', '2016-10-23 16:01:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1153', '818', '2016-10-23 18:26:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1154', '819', '2016-10-23 19:59:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1155', '820', '2016-10-23 20:26:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1156', '821', '2016-10-23 21:31:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1157', '822', '2016-10-24 16:36:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1158', '823', '2016-10-25 13:55:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1159', '824', '2016-10-25 14:05:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1160', '825', '2016-10-25 18:04:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1161', '826', '2016-10-25 18:06:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1162', '827', '2016-10-25 18:49:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1163', '828', '2016-10-26 10:03:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1164', '829', '2016-10-26 10:05:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1165', '830', '2016-10-26 10:08:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1166', '831', '2016-10-26 10:14:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1167', '832', '2016-10-26 10:18:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1168', '833', '2016-10-26 10:39:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1169', '834', '2016-10-26 12:15:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1170', '835', '2016-10-26 14:33:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1171', '836', '2016-10-26 19:03:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1172', '837', '2016-10-26 19:09:39', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1173', '838', '2016-10-26 19:12:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1174', '839', '2016-10-26 21:41:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1175', '840', '2016-10-27 12:48:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1176', '841', '2016-10-27 15:43:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1177', '842', '2016-10-28 10:24:47', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1178', '843', '2016-10-28 10:35:17', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1179', '844', '2016-10-28 10:40:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1180', '845', '2016-10-28 10:44:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1181', '846', '2016-10-28 10:45:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1182', '847', '2016-10-28 10:59:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1183', '848', '2016-10-28 11:02:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1184', '849', '2016-10-28 11:27:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1185', '850', '2016-10-28 11:45:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1186', '851', '2016-10-28 11:46:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1187', '852', '2016-10-28 12:43:45', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1188', '853', '2016-10-28 19:03:07', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1189', '854', '2016-10-28 22:20:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1190', '855', '2016-10-29 13:36:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1191', '856', '2016-10-29 15:00:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1192', '857', '2016-10-29 19:18:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1193', '858', '2016-10-29 20:33:31', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1194', '859', '2016-10-30 09:00:40', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1195', '860', '2016-10-30 10:37:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1196', '861', '2016-10-30 12:39:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1197', '862', '2016-10-30 12:39:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1198', '863', '2016-10-30 14:22:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1199', '864', '2016-10-30 15:23:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1200', '865', '2016-10-30 15:45:05', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1201', '866', '2016-10-30 16:20:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1202', '867', '2016-10-30 16:41:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1203', '868', '2016-10-30 17:37:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1204', '869', '2016-10-30 17:39:10', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1205', '870', '2016-10-30 17:54:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1206', '871', '2016-10-30 18:36:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1207', '872', '2016-10-30 19:06:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1208', '873', '2016-10-30 20:09:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1209', '874', '2016-10-30 20:34:13', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1210', '875', '2016-10-30 23:16:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1211', '876', '2016-11-01 07:36:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1212', '877', '2016-11-01 10:51:01', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1213', '878', '2016-11-01 14:22:43', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1214', '879', '2016-11-01 23:48:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1215', '880', '2016-11-02 12:36:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1216', '881', '2016-11-02 12:51:18', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1217', '882', '2016-11-02 18:59:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1218', '883', '2016-11-03 11:36:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1219', '884', '2016-11-03 19:04:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1220', '885', '2016-11-04 15:24:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1221', '886', '2016-11-05 08:25:35', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1222', '887', '2016-11-05 13:10:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1223', '888', '2016-11-05 17:51:58', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1224', '889', '2016-11-05 19:33:24', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1225', '890', '2016-11-05 19:53:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1226', '891', '2016-11-06 11:36:08', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1227', '892', '2016-11-06 15:17:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1228', '893', '2016-11-06 15:41:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1229', '894', '2016-11-06 16:23:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1230', '895', '2016-11-06 18:31:36', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1231', '896', '2016-11-06 23:05:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1232', '897', '2016-11-07 20:31:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1233', '898', '2016-11-09 20:44:29', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1234', '899', '2016-11-09 20:57:21', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1235', '900', '2016-11-09 20:57:46', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1236', '901', '2016-11-10 08:14:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1237', '902', '2016-11-10 09:22:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1238', '903', '2016-11-10 21:18:28', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1239', '904', '2016-11-11 15:35:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1240', '905', '2016-11-11 17:58:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1241', '906', '2016-11-11 19:39:49', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1242', '907', '2016-11-11 21:34:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1243', '908', '2016-11-12 17:17:55', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1244', '909', '2016-11-12 20:53:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1245', '910', '2016-11-13 13:24:30', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1246', '911', '2016-11-13 14:14:16', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1247', '912', '2016-11-14 12:44:54', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1248', '913', '2016-11-14 20:32:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1249', '914', '2016-11-15 22:58:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1250', '915', '2016-11-16 14:52:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1251', '916', '2016-11-17 11:21:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1252', '917', '2016-11-17 17:10:25', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1253', '918', '2016-11-17 19:33:51', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1254', '919', '2016-11-17 21:30:56', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1255', '920', '2016-11-17 22:01:57', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1256', '921', '2016-11-18 06:09:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1257', '922', '2016-11-18 09:50:02', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1258', '923', '2016-11-18 11:45:27', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1259', '924', '2016-11-18 15:06:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1260', '925', '2016-11-19 09:07:15', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1261', '926', '2016-11-19 12:46:04', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1262', '927', '2016-11-19 14:11:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1263', '928', '2016-11-19 21:13:33', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1264', '929', '2016-11-20 16:25:44', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1265', '930', '2016-11-20 17:44:48', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1266', '931', '2016-11-20 20:59:06', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1267', '932', '2016-11-20 21:56:20', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1268', '933', '2016-11-21 11:31:12', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1269', '934', '2016-11-21 17:11:14', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1270', '935', '2016-11-21 19:21:19', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1271', '936', '2016-11-22 10:37:23', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1272', '937', '2016-11-22 18:49:52', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1273', '938', '2016-11-23 14:30:00', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1274', '939', '2016-11-23 15:18:26', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1275', '940', '2016-11-23 15:58:09', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1276', '941', '2016-11-23 20:42:37', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1277', '942', '2016-11-24 11:51:53', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1278', '740', '2016-11-25 15:34:28', '880', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1279', '740', '2016-11-25 15:51:28', '1000', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1280', '740', '2016-11-25 15:52:28', '1000', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1281', '740', '2016-11-25 15:54:28', '1000', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1282', '740', '2016-11-25 16:29:28', '1000', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1283', '740', '2016-11-25 16:31:28', '50', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1284', '740', '2016-11-25 16:33:28', '1000', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1285', '740', '2016-11-25 16:35:28', '30', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1286', '740', '2016-11-25 16:38:28', '100', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1287', '740', '2016-11-25 16:39:28', '38', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1288', '740', '2016-11-25 16:42:28', '120', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1290', '37', '2016-11-25 16:56:26', '120', '补积分');
INSERT INTO `by_score_add_history` VALUES ('1291', '740', '2016-11-25 17:54:28', '2020', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1292', '943', '2016-11-26 10:41:34', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1293', '944', '2016-11-26 19:07:32', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1294', '945', '2016-11-27 11:20:59', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1295', '946', '2016-11-27 12:42:38', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1296', '947', '2016-11-27 14:18:03', '0', '注册');
INSERT INTO `by_score_add_history` VALUES ('1298', '37', '2016-11-28 17:06:15', '220', '补积分');
INSERT INTO `by_score_add_history` VALUES ('1300', '37', '2016-11-29 17:18:24', '120', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1301', '37', '2016-12-01 22:50:37', '50', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1302', '37', '2016-12-02 11:40:11', '50', '消费积分');
INSERT INTO `by_score_add_history` VALUES ('1303', '37', '2016-12-02 12:23:54', '0', '消费积分');

-- ----------------------------
-- Table structure for by_score_history
-- ----------------------------
DROP TABLE IF EXISTS `by_score_history`;
CREATE TABLE `by_score_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `deposit` int(11) DEFAULT NULL,
  `reason` varchar(20) DEFAULT NULL,
  `type` smallint(6) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  CONSTRAINT `by_score_history_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=962 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_score_history
-- ----------------------------
INSERT INTO `by_score_history` VALUES ('29', '37', '2016-09-06 00:12:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('30', '38', '2016-09-06 11:58:22', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('31', '39', '2016-09-06 16:43:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('32', '40', '2016-09-06 16:49:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('33', '41', '2016-09-06 16:49:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('34', '42', '2016-09-06 16:49:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('35', '43', '2016-09-07 13:49:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('36', '44', '2016-09-07 13:50:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('37', '45', '2016-09-07 13:50:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('38', '46', '2016-09-07 13:50:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('39', '47', '2016-09-07 22:15:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('40', '48', '2016-09-07 22:15:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('41', '49', '2016-09-07 22:21:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('42', '50', '2016-09-07 23:01:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('43', '51', '2016-09-07 23:18:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('44', '52', '2016-09-07 23:46:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('45', '53', '2016-09-08 00:02:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('46', '54', '2016-09-08 00:06:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('47', '55', '2016-09-08 00:07:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('48', '56', '2016-09-08 00:18:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('49', '57', '2016-09-08 01:05:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('50', '58', '2016-09-08 01:17:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('51', '59', '2016-09-08 05:46:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('52', '60', '2016-09-08 05:50:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('53', '61', '2016-09-08 06:47:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('54', '62', '2016-09-08 06:53:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('55', '63', '2016-09-08 06:58:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('56', '64', '2016-09-08 07:06:50', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('57', '65', '2016-09-08 07:13:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('58', '66', '2016-09-08 07:30:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('59', '67', '2016-09-08 07:30:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('60', '68', '2016-09-08 08:02:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('61', '69', '2016-09-08 08:18:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('62', '70', '2016-09-08 08:21:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('63', '71', '2016-09-08 08:46:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('64', '72', '2016-09-08 09:01:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('65', '73', '2016-09-08 09:04:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('66', '74', '2016-09-08 09:08:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('67', '75', '2016-09-08 09:12:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('68', '76', '2016-09-08 09:22:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('69', '77', '2016-09-08 09:30:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('70', '78', '2016-09-08 09:30:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('71', '79', '2016-09-08 09:34:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('72', '80', '2016-09-08 09:35:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('73', '81', '2016-09-08 09:56:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('74', '82', '2016-09-08 09:58:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('75', '83', '2016-09-08 09:59:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('76', '84', '2016-09-08 10:17:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('77', '85', '2016-09-08 10:20:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('78', '86', '2016-09-08 10:44:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('79', '87', '2016-09-08 10:46:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('80', '88', '2016-09-08 10:50:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('81', '89', '2016-09-08 10:52:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('82', '90', '2016-09-08 10:56:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('83', '91', '2016-09-08 10:59:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('84', '92', '2016-09-08 11:03:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('85', '93', '2016-09-08 11:03:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('86', '94', '2016-09-08 11:04:41', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('87', '95', '2016-09-08 11:11:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('88', '96', '2016-09-08 11:21:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('89', '97', '2016-09-08 11:21:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('90', '98', '2016-09-08 11:24:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('91', '99', '2016-09-08 11:39:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('92', '100', '2016-09-08 11:50:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('93', '101', '2016-09-08 11:51:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('94', '102', '2016-09-08 12:01:22', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('95', '103', '2016-09-08 12:03:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('96', '104', '2016-09-08 12:03:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('97', '105', '2016-09-08 12:08:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('98', '106', '2016-09-08 12:20:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('99', '107', '2016-09-08 12:29:41', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('100', '108', '2016-09-08 12:46:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('101', '109', '2016-09-08 12:46:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('102', '110', '2016-09-08 12:50:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('103', '111', '2016-09-08 12:55:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('104', '112', '2016-09-08 13:01:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('105', '113', '2016-09-08 13:22:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('106', '114', '2016-09-08 13:24:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('107', '115', '2016-09-08 13:25:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('108', '116', '2016-09-08 13:25:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('109', '117', '2016-09-08 13:29:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('110', '118', '2016-09-08 13:41:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('111', '119', '2016-09-08 13:49:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('112', '120', '2016-09-08 13:50:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('113', '121', '2016-09-08 13:50:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('114', '122', '2016-09-08 13:51:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('115', '123', '2016-09-08 14:06:50', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('116', '124', '2016-09-08 14:08:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('117', '125', '2016-09-08 14:10:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('118', '126', '2016-09-08 14:12:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('119', '127', '2016-09-08 14:31:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('120', '128', '2016-09-08 14:34:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('121', '129', '2016-09-08 14:38:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('122', '130', '2016-09-08 14:39:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('123', '131', '2016-09-08 14:41:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('124', '132', '2016-09-08 14:55:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('125', '133', '2016-09-08 15:01:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('126', '134', '2016-09-08 15:01:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('127', '135', '2016-09-08 15:10:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('128', '136', '2016-09-08 15:18:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('129', '137', '2016-09-08 15:20:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('130', '138', '2016-09-08 15:35:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('131', '139', '2016-09-08 15:46:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('132', '140', '2016-09-08 15:58:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('133', '141', '2016-09-08 16:05:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('134', '142', '2016-09-08 16:16:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('135', '143', '2016-09-08 16:34:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('136', '144', '2016-09-08 16:35:41', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('137', '145', '2016-09-08 17:04:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('138', '146', '2016-09-08 17:11:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('139', '147', '2016-09-08 17:13:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('140', '148', '2016-09-08 17:14:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('141', '149', '2016-09-08 17:24:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('142', '150', '2016-09-08 18:10:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('143', '151', '2016-09-08 18:15:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('144', '152', '2016-09-08 18:17:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('145', '153', '2016-09-08 18:17:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('146', '154', '2016-09-08 18:18:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('147', '155', '2016-09-08 18:24:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('148', '156', '2016-09-08 18:24:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('149', '157', '2016-09-08 18:36:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('150', '158', '2016-09-08 18:42:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('151', '159', '2016-09-08 18:57:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('152', '160', '2016-09-08 19:02:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('153', '161', '2016-09-08 19:14:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('154', '162', '2016-09-08 19:28:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('155', '163', '2016-09-08 19:31:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('156', '164', '2016-09-08 19:36:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('157', '165', '2016-09-08 19:42:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('158', '166', '2016-09-08 19:45:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('159', '167', '2016-09-08 19:45:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('160', '168', '2016-09-08 19:57:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('161', '169', '2016-09-08 20:00:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('162', '170', '2016-09-08 20:02:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('163', '171', '2016-09-08 20:07:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('164', '172', '2016-09-08 20:11:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('165', '173', '2016-09-08 20:17:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('166', '174', '2016-09-08 20:37:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('167', '175', '2016-09-08 20:45:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('168', '176', '2016-09-08 20:57:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('169', '177', '2016-09-08 20:58:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('170', '178', '2016-09-08 21:03:22', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('171', '179', '2016-09-08 21:15:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('172', '180', '2016-09-08 21:35:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('173', '181', '2016-09-08 21:37:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('174', '182', '2016-09-08 21:40:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('175', '183', '2016-09-08 21:49:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('176', '184', '2016-09-08 21:52:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('177', '185', '2016-09-08 21:54:50', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('178', '186', '2016-09-08 21:55:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('179', '187', '2016-09-08 21:59:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('180', '188', '2016-09-08 22:03:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('181', '189', '2016-09-08 22:24:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('182', '190', '2016-09-08 22:49:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('183', '191', '2016-09-08 22:52:22', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('184', '192', '2016-09-08 22:58:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('185', '193', '2016-09-08 23:03:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('186', '194', '2016-09-08 23:08:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('187', '195', '2016-09-08 23:11:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('188', '196', '2016-09-08 23:41:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('189', '197', '2016-09-09 00:26:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('190', '198', '2016-09-09 01:44:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('191', '199', '2016-09-09 02:51:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('192', '200', '2016-09-09 06:29:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('193', '201', '2016-09-09 06:49:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('194', '202', '2016-09-09 07:03:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('195', '203', '2016-09-09 07:13:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('196', '204', '2016-09-09 07:16:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('197', '205', '2016-09-09 07:20:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('198', '206', '2016-09-09 07:41:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('199', '207', '2016-09-09 07:45:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('200', '208', '2016-09-09 08:19:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('201', '209', '2016-09-09 09:07:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('202', '210', '2016-09-09 09:41:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('203', '211', '2016-09-09 09:43:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('204', '212', '2016-09-09 09:49:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('205', '213', '2016-09-09 10:02:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('206', '214', '2016-09-09 10:04:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('207', '215', '2016-09-09 10:11:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('208', '216', '2016-09-09 11:13:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('209', '217', '2016-09-09 11:18:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('210', '218', '2016-09-09 11:21:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('211', '219', '2016-09-09 11:23:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('212', '220', '2016-09-09 11:31:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('213', '221', '2016-09-09 11:42:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('214', '222', '2016-09-09 11:52:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('215', '223', '2016-09-09 12:11:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('216', '224', '2016-09-09 12:19:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('217', '225', '2016-09-09 12:27:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('218', '226', '2016-09-09 12:31:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('219', '227', '2016-09-09 14:04:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('220', '228', '2016-09-09 14:20:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('221', '229', '2016-09-09 14:34:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('222', '230', '2016-09-09 15:08:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('223', '231', '2016-09-09 15:47:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('224', '232', '2016-09-09 15:53:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('225', '233', '2016-09-09 16:53:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('226', '234', '2016-09-09 17:15:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('227', '235', '2016-09-09 17:59:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('228', '236', '2016-09-09 18:45:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('229', '237', '2016-09-09 19:01:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('230', '238', '2016-09-09 19:16:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('231', '239', '2016-09-09 19:34:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('232', '240', '2016-09-09 19:39:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('233', '241', '2016-09-09 19:49:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('234', '242', '2016-09-09 19:54:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('235', '243', '2016-09-09 19:56:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('236', '244', '2016-09-09 20:26:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('237', '245', '2016-09-09 20:43:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('238', '246', '2016-09-09 21:42:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('239', '247', '2016-09-09 22:06:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('240', '248', '2016-09-09 22:23:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('241', '249', '2016-09-10 07:38:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('242', '250', '2016-09-10 08:24:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('243', '251', '2016-09-10 08:48:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('244', '252', '2016-09-10 09:38:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('245', '253', '2016-09-10 09:59:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('246', '254', '2016-09-10 11:07:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('247', '255', '2016-09-10 11:39:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('248', '256', '2016-09-10 12:07:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('249', '257', '2016-09-10 12:19:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('250', '258', '2016-09-10 12:44:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('251', '259', '2016-09-10 13:28:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('252', '260', '2016-09-10 13:50:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('253', '261', '2016-09-10 14:21:50', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('254', '262', '2016-09-10 14:37:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('255', '263', '2016-09-10 14:38:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('256', '264', '2016-09-10 14:46:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('257', '265', '2016-09-10 14:59:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('258', '266', '2016-09-10 15:50:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('259', '267', '2016-09-10 16:14:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('260', '268', '2016-09-10 16:20:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('261', '269', '2016-09-10 16:27:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('262', '270', '2016-09-10 16:39:22', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('263', '271', '2016-09-10 16:42:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('264', '272', '2016-09-10 17:02:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('265', '273', '2016-09-10 17:03:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('266', '274', '2016-09-10 17:03:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('267', '275', '2016-09-10 17:36:50', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('268', '276', '2016-09-10 18:07:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('269', '277', '2016-09-10 18:45:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('270', '278', '2016-09-10 18:54:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('271', '279', '2016-09-10 19:16:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('272', '280', '2016-09-10 19:17:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('273', '281', '2016-09-10 19:42:22', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('274', '282', '2016-09-10 19:49:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('275', '283', '2016-09-10 20:10:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('276', '284', '2016-09-10 20:13:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('277', '285', '2016-09-10 20:25:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('278', '286', '2016-09-10 20:31:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('279', '287', '2016-09-10 20:34:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('280', '288', '2016-09-10 21:15:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('281', '289', '2016-09-10 21:41:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('282', '290', '2016-09-10 21:46:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('283', '291', '2016-09-10 22:17:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('284', '292', '2016-09-10 22:20:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('285', '293', '2016-09-10 22:31:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('286', '294', '2016-09-10 22:31:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('287', '295', '2016-09-11 00:47:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('288', '296', '2016-09-11 08:22:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('289', '297', '2016-09-11 08:59:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('290', '298', '2016-09-11 09:27:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('291', '299', '2016-09-11 09:54:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('292', '300', '2016-09-11 09:57:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('293', '301', '2016-09-11 10:56:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('294', '302', '2016-09-11 11:36:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('295', '303', '2016-09-11 11:47:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('296', '304', '2016-09-11 11:56:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('297', '305', '2016-09-11 12:04:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('298', '306', '2016-09-11 12:28:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('299', '307', '2016-09-11 12:30:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('300', '308', '2016-09-11 13:03:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('301', '309', '2016-09-11 13:10:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('302', '310', '2016-09-11 14:12:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('303', '311', '2016-09-11 14:13:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('304', '312', '2016-09-11 14:27:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('305', '313', '2016-09-11 14:28:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('306', '314', '2016-09-11 15:24:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('307', '315', '2016-09-11 15:36:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('308', '316', '2016-09-11 16:29:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('309', '317', '2016-09-11 16:58:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('310', '318', '2016-09-11 17:04:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('311', '319', '2016-09-11 17:50:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('312', '320', '2016-09-11 18:02:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('313', '321', '2016-09-11 18:30:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('314', '322', '2016-09-11 18:43:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('315', '323', '2016-09-11 20:02:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('316', '324', '2016-09-11 20:17:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('317', '325', '2016-09-11 20:36:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('318', '326', '2016-09-11 20:36:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('319', '327', '2016-09-11 20:37:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('320', '328', '2016-09-11 20:37:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('321', '329', '2016-09-11 20:38:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('322', '330', '2016-09-11 20:39:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('323', '331', '2016-09-11 20:39:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('324', '332', '2016-09-11 20:40:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('325', '333', '2016-09-11 20:42:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('326', '334', '2016-09-11 20:43:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('327', '335', '2016-09-11 20:45:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('328', '336', '2016-09-11 20:46:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('329', '337', '2016-09-11 20:46:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('330', '338', '2016-09-11 20:47:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('331', '339', '2016-09-11 20:47:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('332', '340', '2016-09-11 20:47:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('333', '341', '2016-09-11 20:47:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('334', '342', '2016-09-11 20:48:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('335', '343', '2016-09-11 20:49:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('336', '344', '2016-09-11 20:49:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('337', '345', '2016-09-11 20:49:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('338', '346', '2016-09-11 20:50:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('339', '347', '2016-09-11 20:51:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('340', '348', '2016-09-11 20:54:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('341', '349', '2016-09-11 20:54:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('342', '350', '2016-09-11 20:56:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('343', '351', '2016-09-11 20:58:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('344', '352', '2016-09-11 20:59:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('345', '353', '2016-09-11 21:02:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('346', '354', '2016-09-11 21:04:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('347', '355', '2016-09-11 21:10:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('348', '356', '2016-09-11 21:10:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('349', '357', '2016-09-11 21:14:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('350', '358', '2016-09-11 21:15:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('351', '359', '2016-09-11 21:15:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('352', '360', '2016-09-11 21:18:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('353', '361', '2016-09-11 21:18:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('354', '362', '2016-09-11 21:19:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('355', '363', '2016-09-11 21:21:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('356', '364', '2016-09-11 21:22:22', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('357', '365', '2016-09-11 21:22:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('358', '366', '2016-09-11 21:22:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('359', '367', '2016-09-11 21:24:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('360', '368', '2016-09-11 21:25:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('361', '369', '2016-09-11 21:26:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('362', '370', '2016-09-11 21:30:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('363', '371', '2016-09-11 21:32:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('364', '372', '2016-09-11 21:36:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('365', '373', '2016-09-11 21:38:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('366', '374', '2016-09-11 21:44:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('367', '375', '2016-09-11 21:53:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('368', '376', '2016-09-11 21:53:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('369', '377', '2016-09-11 21:55:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('370', '378', '2016-09-11 21:59:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('371', '379', '2016-09-11 22:03:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('372', '380', '2016-09-11 22:08:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('373', '381', '2016-09-11 22:15:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('374', '382', '2016-09-11 22:21:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('375', '383', '2016-09-11 22:24:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('376', '384', '2016-09-11 22:26:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('377', '385', '2016-09-11 22:29:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('378', '386', '2016-09-11 22:33:41', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('379', '387', '2016-09-11 22:35:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('380', '388', '2016-09-11 22:38:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('381', '389', '2016-09-11 22:47:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('382', '390', '2016-09-11 23:42:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('383', '391', '2016-09-11 23:58:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('384', '392', '2016-09-12 01:08:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('385', '393', '2016-09-12 01:21:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('386', '394', '2016-09-12 04:43:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('387', '395', '2016-09-12 05:57:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('388', '396', '2016-09-12 06:45:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('389', '397', '2016-09-12 07:05:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('390', '398', '2016-09-12 07:14:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('391', '399', '2016-09-12 07:58:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('392', '400', '2016-09-12 08:46:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('393', '401', '2016-09-12 08:52:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('394', '402', '2016-09-12 09:10:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('395', '403', '2016-09-12 09:19:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('396', '404', '2016-09-12 09:24:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('397', '405', '2016-09-12 09:47:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('398', '406', '2016-09-12 09:52:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('399', '407', '2016-09-12 09:56:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('400', '408', '2016-09-12 10:11:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('401', '409', '2016-09-12 10:21:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('402', '410', '2016-09-12 11:33:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('403', '411', '2016-09-12 12:32:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('404', '412', '2016-09-12 12:46:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('405', '413', '2016-09-12 13:06:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('406', '414', '2016-09-12 14:15:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('407', '415', '2016-09-12 15:22:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('408', '416', '2016-09-12 15:30:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('409', '417', '2016-09-12 16:40:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('410', '418', '2016-09-12 17:01:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('411', '419', '2016-09-12 17:13:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('412', '420', '2016-09-12 18:06:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('413', '421', '2016-09-12 18:51:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('414', '422', '2016-09-12 19:05:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('415', '423', '2016-09-12 19:39:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('416', '424', '2016-09-12 20:47:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('417', '425', '2016-09-12 21:01:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('418', '426', '2016-09-12 22:18:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('419', '427', '2016-09-13 07:55:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('420', '428', '2016-09-13 13:36:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('421', '429', '2016-09-13 14:21:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('422', '430', '2016-09-13 14:22:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('423', '431', '2016-09-13 15:30:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('424', '432', '2016-09-13 16:18:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('425', '433', '2016-09-13 16:38:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('426', '434', '2016-09-13 17:30:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('427', '435', '2016-09-13 18:23:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('428', '436', '2016-09-13 19:23:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('429', '437', '2016-09-13 22:24:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('430', '438', '2016-09-13 22:32:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('431', '439', '2016-09-14 08:20:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('432', '440', '2016-09-14 08:22:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('433', '441', '2016-09-14 09:23:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('434', '442', '2016-09-14 10:32:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('435', '443', '2016-09-14 11:00:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('436', '444', '2016-09-14 11:11:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('437', '445', '2016-09-14 11:13:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('438', '446', '2016-09-14 11:38:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('439', '447', '2016-09-14 12:30:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('440', '448', '2016-09-14 14:56:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('441', '449', '2016-09-14 15:00:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('442', '450', '2016-09-14 15:20:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('443', '451', '2016-09-14 15:33:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('444', '452', '2016-09-14 15:40:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('445', '453', '2016-09-14 15:43:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('446', '454', '2016-09-14 15:46:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('447', '455', '2016-09-14 15:47:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('448', '456', '2016-09-14 15:47:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('449', '457', '2016-09-14 15:48:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('450', '458', '2016-09-14 15:53:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('451', '459', '2016-09-14 15:53:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('452', '460', '2016-09-14 15:58:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('453', '461', '2016-09-14 16:00:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('454', '462', '2016-09-14 16:21:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('455', '463', '2016-09-14 16:24:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('456', '464', '2016-09-14 16:38:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('457', '465', '2016-09-14 16:40:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('458', '466', '2016-09-14 16:41:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('459', '467', '2016-09-14 16:53:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('460', '468', '2016-09-14 17:03:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('461', '469', '2016-09-14 17:10:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('462', '470', '2016-09-14 17:10:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('463', '471', '2016-09-14 18:24:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('464', '472', '2016-09-14 19:12:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('465', '473', '2016-09-14 20:04:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('466', '474', '2016-09-14 21:12:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('467', '475', '2016-09-14 21:12:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('468', '476', '2016-09-14 21:48:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('469', '477', '2016-09-14 23:39:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('470', '478', '2016-09-14 23:49:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('471', '479', '2016-09-15 07:01:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('472', '480', '2016-09-15 08:04:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('473', '481', '2016-09-15 09:09:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('474', '482', '2016-09-15 09:41:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('475', '483', '2016-09-15 11:08:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('476', '484', '2016-09-15 11:23:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('477', '485', '2016-09-15 11:37:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('478', '486', '2016-09-15 11:45:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('479', '487', '2016-09-15 13:06:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('480', '488', '2016-09-15 13:17:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('481', '489', '2016-09-15 13:18:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('482', '490', '2016-09-15 13:19:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('483', '491', '2016-09-15 13:22:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('484', '492', '2016-09-15 14:00:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('485', '493', '2016-09-15 14:33:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('486', '494', '2016-09-15 14:59:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('487', '495', '2016-09-15 15:15:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('488', '496', '2016-09-15 16:19:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('489', '497', '2016-09-15 19:42:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('490', '498', '2016-09-15 19:55:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('491', '499', '2016-09-15 20:14:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('492', '500', '2016-09-15 22:03:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('493', '501', '2016-09-15 22:32:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('494', '502', '2016-09-16 10:53:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('495', '503', '2016-09-16 11:41:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('496', '504', '2016-09-16 12:05:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('497', '505', '2016-09-16 12:54:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('498', '506', '2016-09-16 13:20:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('499', '507', '2016-09-16 14:48:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('500', '508', '2016-09-16 15:13:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('501', '509', '2016-09-16 16:02:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('502', '510', '2016-09-16 16:48:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('503', '511', '2016-09-16 17:09:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('504', '512', '2016-09-16 18:51:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('505', '513', '2016-09-16 19:42:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('506', '514', '2016-09-16 20:10:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('507', '515', '2016-09-16 22:54:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('508', '516', '2016-09-17 08:34:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('509', '517', '2016-09-17 10:21:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('510', '518', '2016-09-17 13:36:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('511', '519', '2016-09-17 13:57:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('512', '520', '2016-09-17 14:26:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('513', '521', '2016-09-17 16:33:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('514', '522', '2016-09-17 17:06:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('515', '523', '2016-09-17 17:11:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('516', '524', '2016-09-17 18:17:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('517', '525', '2016-09-17 18:27:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('518', '526', '2016-09-17 18:50:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('519', '527', '2016-09-17 19:36:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('520', '528', '2016-09-17 20:11:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('521', '529', '2016-09-17 21:18:50', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('522', '530', '2016-09-18 10:57:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('523', '531', '2016-09-18 13:40:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('524', '532', '2016-09-18 14:05:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('525', '533', '2016-09-18 14:24:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('526', '534', '2016-09-18 14:41:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('527', '535', '2016-09-18 14:47:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('528', '536', '2016-09-18 15:52:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('529', '537', '2016-09-18 17:11:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('530', '538', '2016-09-18 20:12:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('531', '539', '2016-09-18 20:39:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('532', '540', '2016-09-19 06:23:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('533', '541', '2016-09-19 08:24:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('534', '542', '2016-09-19 10:46:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('535', '543', '2016-09-19 12:29:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('536', '544', '2016-09-19 16:11:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('537', '545', '2016-09-19 20:03:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('538', '546', '2016-09-19 21:44:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('539', '547', '2016-09-20 10:10:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('540', '548', '2016-09-20 15:50:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('541', '549', '2016-09-20 18:03:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('542', '550', '2016-09-20 21:08:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('543', '551', '2016-09-20 21:53:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('544', '552', '2016-09-21 12:48:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('545', '553', '2016-09-21 21:11:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('546', '554', '2016-09-22 10:49:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('547', '555', '2016-09-22 11:04:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('548', '556', '2016-09-22 15:55:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('549', '557', '2016-09-22 16:40:41', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('550', '558', '2016-09-22 16:43:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('551', '559', '2016-09-22 17:56:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('552', '560', '2016-09-22 19:48:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('553', '561', '2016-09-22 20:12:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('554', '562', '2016-09-22 21:18:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('555', '563', '2016-09-22 22:09:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('556', '564', '2016-09-23 06:31:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('557', '565', '2016-09-23 10:49:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('558', '566', '2016-09-23 10:53:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('559', '567', '2016-09-23 12:27:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('560', '568', '2016-09-23 12:51:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('561', '569', '2016-09-23 14:34:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('562', '570', '2016-09-23 15:11:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('563', '571', '2016-09-23 17:28:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('564', '572', '2016-09-23 17:51:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('565', '573', '2016-09-23 19:48:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('566', '574', '2016-09-23 20:03:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('567', '575', '2016-09-23 20:59:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('568', '576', '2016-09-23 21:34:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('569', '577', '2016-09-24 09:03:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('570', '578', '2016-09-24 12:20:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('571', '579', '2016-09-24 12:51:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('572', '580', '2016-09-24 13:31:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('573', '581', '2016-09-24 13:41:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('574', '582', '2016-09-24 13:52:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('575', '583', '2016-09-24 14:32:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('576', '584', '2016-09-24 14:48:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('577', '585', '2016-09-24 16:40:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('578', '586', '2016-09-24 18:22:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('579', '587', '2016-09-24 18:45:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('580', '588', '2016-09-24 22:47:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('581', '589', '2016-09-24 23:05:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('582', '590', '2016-09-25 05:38:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('583', '591', '2016-09-25 11:26:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('584', '592', '2016-09-25 11:32:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('585', '593', '2016-09-25 11:38:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('586', '594', '2016-09-25 12:22:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('587', '595', '2016-09-25 14:52:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('588', '596', '2016-09-25 17:05:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('589', '597', '2016-09-25 17:45:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('590', '598', '2016-09-25 17:55:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('591', '599', '2016-09-25 17:57:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('592', '600', '2016-09-25 18:02:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('593', '601', '2016-09-25 18:08:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('594', '602', '2016-09-25 18:24:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('595', '603', '2016-09-25 18:56:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('596', '604', '2016-09-25 21:39:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('597', '605', '2016-09-26 18:51:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('598', '606', '2016-09-27 12:15:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('599', '607', '2016-09-27 15:22:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('600', '608', '2016-09-27 18:35:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('601', '609', '2016-09-27 21:12:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('602', '610', '2016-09-27 21:49:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('603', '611', '2016-09-27 21:54:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('604', '612', '2016-09-28 15:50:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('605', '613', '2016-09-28 16:55:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('606', '614', '2016-09-28 17:59:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('607', '615', '2016-09-28 22:31:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('608', '616', '2016-09-29 12:41:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('609', '617', '2016-09-29 12:42:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('610', '618', '2016-09-29 12:43:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('611', '619', '2016-09-29 12:46:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('612', '620', '2016-09-29 12:46:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('613', '621', '2016-09-29 12:49:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('614', '622', '2016-09-29 12:52:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('615', '623', '2016-09-29 12:59:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('616', '624', '2016-09-29 13:17:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('617', '625', '2016-09-29 13:43:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('618', '626', '2016-09-29 13:52:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('619', '627', '2016-09-29 14:23:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('620', '628', '2016-09-29 14:29:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('621', '629', '2016-09-29 15:26:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('622', '630', '2016-09-29 16:06:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('623', '631', '2016-09-29 16:10:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('624', '632', '2016-09-29 16:55:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('625', '633', '2016-09-29 17:00:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('626', '634', '2016-09-29 18:39:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('627', '635', '2016-09-29 18:40:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('628', '636', '2016-09-29 18:56:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('629', '637', '2016-09-30 11:01:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('630', '638', '2016-09-30 11:09:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('631', '639', '2016-09-30 17:18:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('632', '640', '2016-09-30 18:34:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('633', '641', '2016-09-30 20:21:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('634', '642', '2016-10-01 08:28:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('635', '643', '2016-10-01 10:39:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('636', '644', '2016-10-01 10:54:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('637', '645', '2016-10-01 10:57:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('638', '646', '2016-10-01 11:45:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('639', '647', '2016-10-01 11:56:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('640', '648', '2016-10-01 12:18:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('641', '649', '2016-10-01 12:21:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('642', '650', '2016-10-01 12:59:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('643', '651', '2016-10-01 14:02:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('644', '652', '2016-10-01 14:17:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('645', '653', '2016-10-01 14:26:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('646', '654', '2016-10-01 15:08:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('647', '655', '2016-10-01 15:14:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('648', '656', '2016-10-01 18:22:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('649', '657', '2016-10-01 18:35:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('650', '658', '2016-10-01 18:38:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('651', '659', '2016-10-01 20:19:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('652', '660', '2016-10-02 07:14:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('653', '661', '2016-10-02 10:32:50', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('654', '662', '2016-10-02 11:19:22', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('655', '663', '2016-10-02 12:04:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('656', '664', '2016-10-02 12:44:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('657', '665', '2016-10-02 14:40:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('658', '666', '2016-10-02 14:43:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('659', '667', '2016-10-02 17:23:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('660', '668', '2016-10-02 17:45:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('661', '669', '2016-10-02 19:32:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('662', '670', '2016-10-02 20:50:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('663', '671', '2016-10-02 20:55:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('664', '672', '2016-10-02 22:00:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('665', '673', '2016-10-03 10:22:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('666', '674', '2016-10-03 12:16:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('667', '675', '2016-10-03 12:24:41', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('668', '676', '2016-10-03 19:35:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('669', '677', '2016-10-04 11:02:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('670', '678', '2016-10-04 13:03:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('671', '679', '2016-10-04 14:41:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('672', '680', '2016-10-04 15:47:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('673', '681', '2016-10-04 17:19:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('674', '682', '2016-10-04 18:33:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('675', '683', '2016-10-04 18:37:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('676', '684', '2016-10-04 18:53:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('677', '685', '2016-10-04 20:03:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('678', '686', '2016-10-04 20:23:41', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('679', '687', '2016-10-04 21:09:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('680', '688', '2016-10-05 10:05:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('681', '689', '2016-10-05 11:08:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('682', '690', '2016-10-05 16:44:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('683', '691', '2016-10-05 17:28:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('684', '692', '2016-10-05 18:19:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('685', '693', '2016-10-05 18:29:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('686', '694', '2016-10-05 19:02:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('687', '695', '2016-10-05 19:43:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('688', '696', '2016-10-06 11:52:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('689', '697', '2016-10-06 12:08:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('690', '698', '2016-10-06 12:41:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('691', '699', '2016-10-06 14:23:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('692', '700', '2016-10-06 14:56:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('693', '701', '2016-10-06 14:59:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('694', '702', '2016-10-06 16:06:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('695', '703', '2016-10-06 16:10:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('696', '704', '2016-10-06 16:35:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('697', '705', '2016-10-06 17:17:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('698', '706', '2016-10-06 19:16:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('699', '707', '2016-10-06 19:39:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('700', '708', '2016-10-06 20:03:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('701', '709', '2016-10-06 20:37:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('702', '710', '2016-10-06 21:41:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('703', '711', '2016-10-06 22:41:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('704', '712', '2016-10-07 12:55:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('705', '713', '2016-10-07 13:18:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('706', '714', '2016-10-07 13:37:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('707', '715', '2016-10-07 13:42:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('708', '716', '2016-10-07 14:51:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('709', '717', '2016-10-07 16:25:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('710', '718', '2016-10-07 16:31:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('711', '719', '2016-10-07 17:32:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('712', '720', '2016-10-07 18:50:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('713', '721', '2016-10-07 20:25:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('714', '722', '2016-10-07 20:56:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('715', '723', '2016-10-07 21:22:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('716', '724', '2016-10-07 22:13:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('717', '725', '2016-10-08 07:25:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('718', '726', '2016-10-08 15:59:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('719', '727', '2016-10-08 20:33:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('720', '728', '2016-10-08 22:11:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('721', '729', '2016-10-09 12:04:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('722', '730', '2016-10-09 15:01:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('723', '731', '2016-10-09 21:07:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('724', '732', '2016-10-09 21:50:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('725', '733', '2016-10-10 16:47:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('726', '734', '2016-10-10 20:45:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('727', '735', '2016-10-11 10:09:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('728', '736', '2016-10-11 13:50:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('729', '737', '2016-10-12 12:31:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('730', '738', '2016-10-12 21:27:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('731', '739', '2016-10-13 07:09:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('732', '740', '2016-10-13 10:52:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('733', '741', '2016-10-13 11:14:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('734', '742', '2016-10-13 18:49:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('735', '743', '2016-10-13 22:04:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('736', '744', '2016-10-14 18:46:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('737', '745', '2016-10-14 20:01:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('738', '746', '2016-10-14 20:06:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('739', '747', '2016-10-14 20:08:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('740', '748', '2016-10-14 20:20:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('741', '749', '2016-10-14 20:20:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('742', '750', '2016-10-14 20:23:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('743', '751', '2016-10-14 20:29:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('744', '752', '2016-10-14 20:34:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('745', '753', '2016-10-14 20:37:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('746', '754', '2016-10-14 20:39:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('747', '755', '2016-10-14 20:42:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('748', '756', '2016-10-14 21:10:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('749', '757', '2016-10-14 21:15:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('750', '758', '2016-10-14 21:24:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('751', '759', '2016-10-15 00:01:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('752', '760', '2016-10-15 10:31:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('753', '761', '2016-10-15 11:18:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('754', '762', '2016-10-15 11:27:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('755', '763', '2016-10-15 13:03:11', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('756', '764', '2016-10-15 13:34:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('757', '765', '2016-10-15 13:43:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('758', '766', '2016-10-15 15:26:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('759', '767', '2016-10-15 17:11:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('760', '768', '2016-10-15 17:28:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('761', '769', '2016-10-15 17:58:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('762', '770', '2016-10-16 12:10:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('763', '771', '2016-10-16 14:17:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('764', '772', '2016-10-16 16:39:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('765', '773', '2016-10-16 16:47:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('766', '774', '2016-10-16 17:56:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('767', '775', '2016-10-16 18:50:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('768', '776', '2016-10-16 22:29:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('769', '777', '2016-10-16 22:40:41', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('770', '778', '2016-10-17 11:53:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('771', '779', '2016-10-17 12:12:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('772', '780', '2016-10-17 13:19:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('773', '781', '2016-10-17 16:54:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('774', '782', '2016-10-18 09:33:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('775', '783', '2016-10-18 15:28:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('776', '784', '2016-10-18 17:33:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('777', '785', '2016-10-18 19:00:50', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('778', '786', '2016-10-19 10:38:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('779', '787', '2016-10-19 11:57:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('780', '788', '2016-10-20 13:28:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('781', '789', '2016-10-20 18:14:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('782', '790', '2016-10-20 18:35:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('783', '791', '2016-10-20 18:42:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('784', '792', '2016-10-20 19:07:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('785', '793', '2016-10-20 19:10:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('786', '794', '2016-10-20 19:13:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('787', '795', '2016-10-20 19:16:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('788', '796', '2016-10-20 19:21:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('789', '797', '2016-10-20 19:59:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('790', '798', '2016-10-20 21:14:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('791', '799', '2016-10-20 22:23:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('792', '800', '2016-10-20 23:18:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('793', '801', '2016-10-21 16:41:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('794', '802', '2016-10-21 22:11:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('795', '803', '2016-10-22 07:21:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('796', '804', '2016-10-22 10:52:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('797', '805', '2016-10-22 14:54:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('798', '806', '2016-10-22 15:59:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('799', '807', '2016-10-22 18:10:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('800', '808', '2016-10-22 19:22:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('801', '809', '2016-10-22 20:40:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('802', '810', '2016-10-22 23:06:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('803', '811', '2016-10-23 08:48:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('804', '812', '2016-10-23 10:34:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('805', '813', '2016-10-23 11:08:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('806', '814', '2016-10-23 12:20:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('807', '815', '2016-10-23 13:39:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('808', '816', '2016-10-23 15:44:42', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('809', '817', '2016-10-23 16:01:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('810', '818', '2016-10-23 18:26:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('811', '819', '2016-10-23 19:59:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('812', '820', '2016-10-23 20:26:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('813', '821', '2016-10-23 21:31:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('814', '822', '2016-10-24 16:36:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('815', '823', '2016-10-25 13:55:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('816', '824', '2016-10-25 14:05:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('817', '825', '2016-10-25 18:04:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('818', '826', '2016-10-25 18:06:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('819', '827', '2016-10-25 18:49:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('820', '828', '2016-10-26 10:03:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('821', '829', '2016-10-26 10:05:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('822', '830', '2016-10-26 10:08:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('823', '831', '2016-10-26 10:14:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('824', '832', '2016-10-26 10:18:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('825', '833', '2016-10-26 10:39:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('826', '834', '2016-10-26 12:15:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('827', '835', '2016-10-26 14:33:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('828', '836', '2016-10-26 19:03:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('829', '837', '2016-10-26 19:09:39', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('830', '838', '2016-10-26 19:12:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('831', '839', '2016-10-26 21:41:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('832', '840', '2016-10-27 12:48:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('833', '841', '2016-10-27 15:43:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('834', '842', '2016-10-28 10:24:47', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('835', '843', '2016-10-28 10:35:17', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('836', '844', '2016-10-28 10:40:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('837', '845', '2016-10-28 10:44:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('838', '846', '2016-10-28 10:45:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('839', '847', '2016-10-28 10:59:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('840', '848', '2016-10-28 11:02:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('841', '849', '2016-10-28 11:27:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('842', '850', '2016-10-28 11:45:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('843', '851', '2016-10-28 11:46:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('844', '852', '2016-10-28 12:43:45', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('845', '853', '2016-10-28 19:03:07', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('846', '854', '2016-10-28 22:20:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('847', '855', '2016-10-29 13:36:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('848', '856', '2016-10-29 15:00:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('849', '857', '2016-10-29 19:18:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('850', '858', '2016-10-29 20:33:31', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('851', '859', '2016-10-30 09:00:40', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('852', '860', '2016-10-30 10:37:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('853', '861', '2016-10-30 12:39:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('854', '862', '2016-10-30 12:39:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('855', '863', '2016-10-30 14:22:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('856', '864', '2016-10-30 15:23:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('857', '865', '2016-10-30 15:45:05', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('858', '866', '2016-10-30 16:20:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('859', '867', '2016-10-30 16:41:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('860', '868', '2016-10-30 17:37:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('861', '869', '2016-10-30 17:39:10', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('862', '870', '2016-10-30 17:54:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('863', '871', '2016-10-30 18:36:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('864', '872', '2016-10-30 19:06:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('865', '873', '2016-10-30 20:09:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('866', '874', '2016-10-30 20:34:13', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('867', '875', '2016-10-30 23:16:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('868', '876', '2016-11-01 07:36:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('869', '877', '2016-11-01 10:51:01', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('870', '878', '2016-11-01 14:22:43', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('871', '879', '2016-11-01 23:48:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('872', '880', '2016-11-02 12:36:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('873', '881', '2016-11-02 12:51:18', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('874', '882', '2016-11-02 18:59:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('875', '883', '2016-11-03 11:36:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('876', '884', '2016-11-03 19:04:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('877', '885', '2016-11-04 15:24:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('878', '886', '2016-11-05 08:25:35', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('879', '887', '2016-11-05 13:10:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('880', '888', '2016-11-05 17:51:58', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('881', '889', '2016-11-05 19:33:24', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('882', '890', '2016-11-05 19:53:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('883', '891', '2016-11-06 11:36:08', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('884', '892', '2016-11-06 15:17:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('885', '893', '2016-11-06 15:41:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('886', '894', '2016-11-06 16:23:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('887', '895', '2016-11-06 18:31:36', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('888', '896', '2016-11-06 23:05:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('889', '897', '2016-11-07 20:31:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('890', '898', '2016-11-09 20:44:29', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('891', '899', '2016-11-09 20:57:21', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('892', '900', '2016-11-09 20:57:46', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('893', '901', '2016-11-10 08:14:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('894', '902', '2016-11-10 09:22:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('895', '903', '2016-11-10 21:18:28', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('896', '904', '2016-11-11 15:35:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('897', '905', '2016-11-11 17:58:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('898', '906', '2016-11-11 19:39:49', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('899', '907', '2016-11-11 21:34:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('900', '908', '2016-11-12 17:17:55', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('901', '909', '2016-11-12 20:53:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('902', '910', '2016-11-13 13:24:30', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('903', '911', '2016-11-13 14:14:16', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('904', '912', '2016-11-14 12:44:54', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('905', '913', '2016-11-14 20:32:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('906', '914', '2016-11-15 22:58:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('907', '915', '2016-11-16 14:52:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('908', '916', '2016-11-17 11:21:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('909', '917', '2016-11-17 17:10:25', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('910', '918', '2016-11-17 19:33:51', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('911', '919', '2016-11-17 21:30:56', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('912', '920', '2016-11-17 22:01:57', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('913', '921', '2016-11-18 06:09:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('914', '922', '2016-11-18 09:50:02', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('915', '923', '2016-11-18 11:45:27', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('916', '924', '2016-11-18 15:06:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('917', '925', '2016-11-19 09:07:15', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('918', '926', '2016-11-19 12:46:04', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('919', '927', '2016-11-19 14:11:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('920', '928', '2016-11-19 21:13:33', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('921', '929', '2016-11-20 16:25:44', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('922', '930', '2016-11-20 17:44:48', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('923', '931', '2016-11-20 20:59:06', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('924', '932', '2016-11-20 21:56:20', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('925', '933', '2016-11-21 11:31:12', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('926', '934', '2016-11-21 17:11:14', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('927', '935', '2016-11-21 19:21:19', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('928', '936', '2016-11-22 10:37:23', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('929', '937', '2016-11-22 18:49:52', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('930', '938', '2016-11-23 14:30:00', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('931', '939', '2016-11-23 15:18:26', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('932', '940', '2016-11-23 15:58:09', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('933', '941', '2016-11-23 20:42:37', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('934', '942', '2016-11-24 11:51:53', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('935', '740', '2016-11-25 15:34:28', '1000', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('936', '740', '2016-11-25 15:51:28', '1000', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('937', '740', '2016-11-25 15:52:28', '1000', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('938', '740', '2016-11-25 15:54:28', '1000', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('939', '740', '2016-11-25 16:29:28', '1000', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('940', '740', '2016-11-25 16:31:28', '50', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('941', '740', '2016-11-25 16:33:28', '1000', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('942', '740', '2016-11-25 16:35:28', '30', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('943', '740', '2016-11-25 16:38:28', '100', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('944', '740', '2016-11-25 16:39:28', '38', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('945', '740', '2016-11-25 16:42:28', '120', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('946', '740', '2016-11-25 16:45:14', '-120', '退货', '5', '手工退货');
INSERT INTO `by_score_history` VALUES ('948', '37', '2016-11-25 16:56:26', '120', '补积分', '4', '人工测试');
INSERT INTO `by_score_history` VALUES ('949', '740', '2016-11-25 17:54:28', '2020', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('950', '943', '2016-11-26 10:41:34', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('951', '944', '2016-11-26 19:07:32', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('952', '945', '2016-11-27 11:20:59', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('953', '946', '2016-11-27 12:42:38', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('954', '947', '2016-11-27 14:18:03', '0', '注册', '3', null);
INSERT INTO `by_score_history` VALUES ('956', '37', '2016-11-28 17:06:15', '220', '补积分', '4', '');
INSERT INTO `by_score_history` VALUES ('958', '37', '2016-11-29 17:18:24', '120', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('959', '37', '2016-12-01 22:50:37', '50', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('960', '37', '2016-12-02 11:40:11', '50', '消费积分', '4', null);
INSERT INTO `by_score_history` VALUES ('961', '37', '2016-12-02 12:23:54', '0', '消费积分', '4', null);

-- ----------------------------
-- Table structure for by_sequence
-- ----------------------------
DROP TABLE IF EXISTS `by_sequence`;
CREATE TABLE `by_sequence` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100301 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_sequence
-- ----------------------------
INSERT INTO `by_sequence` VALUES ('100000');
INSERT INTO `by_sequence` VALUES ('100001');
INSERT INTO `by_sequence` VALUES ('100002');
INSERT INTO `by_sequence` VALUES ('100003');
INSERT INTO `by_sequence` VALUES ('100004');
INSERT INTO `by_sequence` VALUES ('100005');
INSERT INTO `by_sequence` VALUES ('100006');
INSERT INTO `by_sequence` VALUES ('100007');
INSERT INTO `by_sequence` VALUES ('100008');
INSERT INTO `by_sequence` VALUES ('100009');
INSERT INTO `by_sequence` VALUES ('100010');
INSERT INTO `by_sequence` VALUES ('100011');
INSERT INTO `by_sequence` VALUES ('100012');
INSERT INTO `by_sequence` VALUES ('100013');
INSERT INTO `by_sequence` VALUES ('100014');
INSERT INTO `by_sequence` VALUES ('100015');
INSERT INTO `by_sequence` VALUES ('100016');
INSERT INTO `by_sequence` VALUES ('100017');
INSERT INTO `by_sequence` VALUES ('100018');
INSERT INTO `by_sequence` VALUES ('100019');
INSERT INTO `by_sequence` VALUES ('100020');
INSERT INTO `by_sequence` VALUES ('100021');
INSERT INTO `by_sequence` VALUES ('100022');
INSERT INTO `by_sequence` VALUES ('100023');
INSERT INTO `by_sequence` VALUES ('100024');
INSERT INTO `by_sequence` VALUES ('100025');
INSERT INTO `by_sequence` VALUES ('100026');
INSERT INTO `by_sequence` VALUES ('100027');
INSERT INTO `by_sequence` VALUES ('100028');
INSERT INTO `by_sequence` VALUES ('100029');
INSERT INTO `by_sequence` VALUES ('100030');
INSERT INTO `by_sequence` VALUES ('100031');
INSERT INTO `by_sequence` VALUES ('100032');
INSERT INTO `by_sequence` VALUES ('100033');
INSERT INTO `by_sequence` VALUES ('100034');
INSERT INTO `by_sequence` VALUES ('100035');
INSERT INTO `by_sequence` VALUES ('100036');
INSERT INTO `by_sequence` VALUES ('100037');
INSERT INTO `by_sequence` VALUES ('100038');
INSERT INTO `by_sequence` VALUES ('100039');
INSERT INTO `by_sequence` VALUES ('100040');
INSERT INTO `by_sequence` VALUES ('100041');
INSERT INTO `by_sequence` VALUES ('100042');
INSERT INTO `by_sequence` VALUES ('100043');
INSERT INTO `by_sequence` VALUES ('100044');
INSERT INTO `by_sequence` VALUES ('100045');
INSERT INTO `by_sequence` VALUES ('100046');
INSERT INTO `by_sequence` VALUES ('100047');
INSERT INTO `by_sequence` VALUES ('100048');
INSERT INTO `by_sequence` VALUES ('100049');
INSERT INTO `by_sequence` VALUES ('100050');
INSERT INTO `by_sequence` VALUES ('100051');
INSERT INTO `by_sequence` VALUES ('100052');
INSERT INTO `by_sequence` VALUES ('100053');
INSERT INTO `by_sequence` VALUES ('100054');
INSERT INTO `by_sequence` VALUES ('100055');
INSERT INTO `by_sequence` VALUES ('100056');
INSERT INTO `by_sequence` VALUES ('100057');
INSERT INTO `by_sequence` VALUES ('100058');
INSERT INTO `by_sequence` VALUES ('100059');
INSERT INTO `by_sequence` VALUES ('100060');
INSERT INTO `by_sequence` VALUES ('100061');
INSERT INTO `by_sequence` VALUES ('100062');
INSERT INTO `by_sequence` VALUES ('100063');
INSERT INTO `by_sequence` VALUES ('100064');
INSERT INTO `by_sequence` VALUES ('100065');
INSERT INTO `by_sequence` VALUES ('100066');
INSERT INTO `by_sequence` VALUES ('100067');
INSERT INTO `by_sequence` VALUES ('100068');
INSERT INTO `by_sequence` VALUES ('100069');
INSERT INTO `by_sequence` VALUES ('100070');
INSERT INTO `by_sequence` VALUES ('100071');
INSERT INTO `by_sequence` VALUES ('100072');
INSERT INTO `by_sequence` VALUES ('100073');
INSERT INTO `by_sequence` VALUES ('100074');
INSERT INTO `by_sequence` VALUES ('100075');
INSERT INTO `by_sequence` VALUES ('100076');
INSERT INTO `by_sequence` VALUES ('100077');
INSERT INTO `by_sequence` VALUES ('100078');
INSERT INTO `by_sequence` VALUES ('100079');
INSERT INTO `by_sequence` VALUES ('100080');
INSERT INTO `by_sequence` VALUES ('100081');
INSERT INTO `by_sequence` VALUES ('100082');
INSERT INTO `by_sequence` VALUES ('100083');
INSERT INTO `by_sequence` VALUES ('100084');
INSERT INTO `by_sequence` VALUES ('100085');
INSERT INTO `by_sequence` VALUES ('100086');
INSERT INTO `by_sequence` VALUES ('100087');
INSERT INTO `by_sequence` VALUES ('100088');
INSERT INTO `by_sequence` VALUES ('100089');
INSERT INTO `by_sequence` VALUES ('100090');
INSERT INTO `by_sequence` VALUES ('100091');
INSERT INTO `by_sequence` VALUES ('100092');
INSERT INTO `by_sequence` VALUES ('100093');
INSERT INTO `by_sequence` VALUES ('100094');
INSERT INTO `by_sequence` VALUES ('100095');
INSERT INTO `by_sequence` VALUES ('100096');
INSERT INTO `by_sequence` VALUES ('100097');
INSERT INTO `by_sequence` VALUES ('100098');
INSERT INTO `by_sequence` VALUES ('100099');
INSERT INTO `by_sequence` VALUES ('100100');
INSERT INTO `by_sequence` VALUES ('100101');
INSERT INTO `by_sequence` VALUES ('100102');
INSERT INTO `by_sequence` VALUES ('100103');
INSERT INTO `by_sequence` VALUES ('100104');
INSERT INTO `by_sequence` VALUES ('100105');
INSERT INTO `by_sequence` VALUES ('100106');
INSERT INTO `by_sequence` VALUES ('100107');
INSERT INTO `by_sequence` VALUES ('100108');
INSERT INTO `by_sequence` VALUES ('100109');
INSERT INTO `by_sequence` VALUES ('100110');
INSERT INTO `by_sequence` VALUES ('100111');
INSERT INTO `by_sequence` VALUES ('100112');
INSERT INTO `by_sequence` VALUES ('100113');
INSERT INTO `by_sequence` VALUES ('100114');
INSERT INTO `by_sequence` VALUES ('100115');
INSERT INTO `by_sequence` VALUES ('100116');
INSERT INTO `by_sequence` VALUES ('100117');
INSERT INTO `by_sequence` VALUES ('100118');
INSERT INTO `by_sequence` VALUES ('100119');
INSERT INTO `by_sequence` VALUES ('100120');
INSERT INTO `by_sequence` VALUES ('100121');
INSERT INTO `by_sequence` VALUES ('100122');
INSERT INTO `by_sequence` VALUES ('100123');
INSERT INTO `by_sequence` VALUES ('100124');
INSERT INTO `by_sequence` VALUES ('100125');
INSERT INTO `by_sequence` VALUES ('100126');
INSERT INTO `by_sequence` VALUES ('100127');
INSERT INTO `by_sequence` VALUES ('100128');
INSERT INTO `by_sequence` VALUES ('100129');
INSERT INTO `by_sequence` VALUES ('100130');
INSERT INTO `by_sequence` VALUES ('100131');
INSERT INTO `by_sequence` VALUES ('100132');
INSERT INTO `by_sequence` VALUES ('100133');
INSERT INTO `by_sequence` VALUES ('100134');
INSERT INTO `by_sequence` VALUES ('100135');
INSERT INTO `by_sequence` VALUES ('100136');
INSERT INTO `by_sequence` VALUES ('100137');
INSERT INTO `by_sequence` VALUES ('100138');
INSERT INTO `by_sequence` VALUES ('100139');
INSERT INTO `by_sequence` VALUES ('100140');
INSERT INTO `by_sequence` VALUES ('100141');
INSERT INTO `by_sequence` VALUES ('100142');
INSERT INTO `by_sequence` VALUES ('100143');
INSERT INTO `by_sequence` VALUES ('100144');
INSERT INTO `by_sequence` VALUES ('100145');
INSERT INTO `by_sequence` VALUES ('100146');
INSERT INTO `by_sequence` VALUES ('100147');
INSERT INTO `by_sequence` VALUES ('100148');
INSERT INTO `by_sequence` VALUES ('100149');
INSERT INTO `by_sequence` VALUES ('100150');
INSERT INTO `by_sequence` VALUES ('100151');
INSERT INTO `by_sequence` VALUES ('100152');
INSERT INTO `by_sequence` VALUES ('100153');
INSERT INTO `by_sequence` VALUES ('100154');
INSERT INTO `by_sequence` VALUES ('100155');
INSERT INTO `by_sequence` VALUES ('100156');
INSERT INTO `by_sequence` VALUES ('100157');
INSERT INTO `by_sequence` VALUES ('100158');
INSERT INTO `by_sequence` VALUES ('100159');
INSERT INTO `by_sequence` VALUES ('100160');
INSERT INTO `by_sequence` VALUES ('100161');
INSERT INTO `by_sequence` VALUES ('100162');
INSERT INTO `by_sequence` VALUES ('100163');
INSERT INTO `by_sequence` VALUES ('100164');
INSERT INTO `by_sequence` VALUES ('100165');
INSERT INTO `by_sequence` VALUES ('100166');
INSERT INTO `by_sequence` VALUES ('100167');
INSERT INTO `by_sequence` VALUES ('100168');
INSERT INTO `by_sequence` VALUES ('100169');
INSERT INTO `by_sequence` VALUES ('100170');
INSERT INTO `by_sequence` VALUES ('100171');
INSERT INTO `by_sequence` VALUES ('100172');
INSERT INTO `by_sequence` VALUES ('100173');
INSERT INTO `by_sequence` VALUES ('100174');
INSERT INTO `by_sequence` VALUES ('100175');
INSERT INTO `by_sequence` VALUES ('100176');
INSERT INTO `by_sequence` VALUES ('100177');
INSERT INTO `by_sequence` VALUES ('100178');
INSERT INTO `by_sequence` VALUES ('100179');
INSERT INTO `by_sequence` VALUES ('100180');
INSERT INTO `by_sequence` VALUES ('100181');
INSERT INTO `by_sequence` VALUES ('100182');
INSERT INTO `by_sequence` VALUES ('100183');
INSERT INTO `by_sequence` VALUES ('100184');
INSERT INTO `by_sequence` VALUES ('100185');
INSERT INTO `by_sequence` VALUES ('100186');
INSERT INTO `by_sequence` VALUES ('100187');
INSERT INTO `by_sequence` VALUES ('100188');
INSERT INTO `by_sequence` VALUES ('100189');
INSERT INTO `by_sequence` VALUES ('100190');
INSERT INTO `by_sequence` VALUES ('100191');
INSERT INTO `by_sequence` VALUES ('100192');
INSERT INTO `by_sequence` VALUES ('100193');
INSERT INTO `by_sequence` VALUES ('100194');
INSERT INTO `by_sequence` VALUES ('100195');
INSERT INTO `by_sequence` VALUES ('100196');
INSERT INTO `by_sequence` VALUES ('100197');
INSERT INTO `by_sequence` VALUES ('100198');
INSERT INTO `by_sequence` VALUES ('100199');
INSERT INTO `by_sequence` VALUES ('100200');
INSERT INTO `by_sequence` VALUES ('100201');
INSERT INTO `by_sequence` VALUES ('100202');
INSERT INTO `by_sequence` VALUES ('100203');
INSERT INTO `by_sequence` VALUES ('100204');
INSERT INTO `by_sequence` VALUES ('100205');
INSERT INTO `by_sequence` VALUES ('100206');
INSERT INTO `by_sequence` VALUES ('100207');
INSERT INTO `by_sequence` VALUES ('100208');
INSERT INTO `by_sequence` VALUES ('100209');
INSERT INTO `by_sequence` VALUES ('100210');
INSERT INTO `by_sequence` VALUES ('100211');
INSERT INTO `by_sequence` VALUES ('100212');
INSERT INTO `by_sequence` VALUES ('100213');
INSERT INTO `by_sequence` VALUES ('100214');
INSERT INTO `by_sequence` VALUES ('100215');
INSERT INTO `by_sequence` VALUES ('100216');
INSERT INTO `by_sequence` VALUES ('100217');
INSERT INTO `by_sequence` VALUES ('100218');
INSERT INTO `by_sequence` VALUES ('100219');
INSERT INTO `by_sequence` VALUES ('100220');
INSERT INTO `by_sequence` VALUES ('100221');
INSERT INTO `by_sequence` VALUES ('100222');
INSERT INTO `by_sequence` VALUES ('100223');
INSERT INTO `by_sequence` VALUES ('100224');
INSERT INTO `by_sequence` VALUES ('100225');
INSERT INTO `by_sequence` VALUES ('100226');
INSERT INTO `by_sequence` VALUES ('100227');
INSERT INTO `by_sequence` VALUES ('100228');
INSERT INTO `by_sequence` VALUES ('100229');
INSERT INTO `by_sequence` VALUES ('100230');
INSERT INTO `by_sequence` VALUES ('100231');
INSERT INTO `by_sequence` VALUES ('100232');
INSERT INTO `by_sequence` VALUES ('100233');
INSERT INTO `by_sequence` VALUES ('100234');
INSERT INTO `by_sequence` VALUES ('100235');
INSERT INTO `by_sequence` VALUES ('100236');
INSERT INTO `by_sequence` VALUES ('100237');
INSERT INTO `by_sequence` VALUES ('100238');
INSERT INTO `by_sequence` VALUES ('100239');
INSERT INTO `by_sequence` VALUES ('100240');
INSERT INTO `by_sequence` VALUES ('100241');
INSERT INTO `by_sequence` VALUES ('100242');
INSERT INTO `by_sequence` VALUES ('100243');
INSERT INTO `by_sequence` VALUES ('100244');
INSERT INTO `by_sequence` VALUES ('100245');
INSERT INTO `by_sequence` VALUES ('100246');
INSERT INTO `by_sequence` VALUES ('100247');
INSERT INTO `by_sequence` VALUES ('100248');
INSERT INTO `by_sequence` VALUES ('100249');
INSERT INTO `by_sequence` VALUES ('100250');
INSERT INTO `by_sequence` VALUES ('100251');
INSERT INTO `by_sequence` VALUES ('100252');
INSERT INTO `by_sequence` VALUES ('100253');
INSERT INTO `by_sequence` VALUES ('100254');
INSERT INTO `by_sequence` VALUES ('100255');
INSERT INTO `by_sequence` VALUES ('100256');
INSERT INTO `by_sequence` VALUES ('100257');
INSERT INTO `by_sequence` VALUES ('100258');
INSERT INTO `by_sequence` VALUES ('100259');
INSERT INTO `by_sequence` VALUES ('100260');
INSERT INTO `by_sequence` VALUES ('100261');
INSERT INTO `by_sequence` VALUES ('100262');
INSERT INTO `by_sequence` VALUES ('100263');
INSERT INTO `by_sequence` VALUES ('100264');
INSERT INTO `by_sequence` VALUES ('100265');
INSERT INTO `by_sequence` VALUES ('100266');
INSERT INTO `by_sequence` VALUES ('100267');
INSERT INTO `by_sequence` VALUES ('100268');
INSERT INTO `by_sequence` VALUES ('100269');
INSERT INTO `by_sequence` VALUES ('100270');
INSERT INTO `by_sequence` VALUES ('100271');
INSERT INTO `by_sequence` VALUES ('100272');
INSERT INTO `by_sequence` VALUES ('100273');
INSERT INTO `by_sequence` VALUES ('100274');
INSERT INTO `by_sequence` VALUES ('100275');
INSERT INTO `by_sequence` VALUES ('100276');
INSERT INTO `by_sequence` VALUES ('100277');
INSERT INTO `by_sequence` VALUES ('100278');
INSERT INTO `by_sequence` VALUES ('100279');
INSERT INTO `by_sequence` VALUES ('100280');
INSERT INTO `by_sequence` VALUES ('100281');
INSERT INTO `by_sequence` VALUES ('100282');
INSERT INTO `by_sequence` VALUES ('100283');
INSERT INTO `by_sequence` VALUES ('100284');
INSERT INTO `by_sequence` VALUES ('100285');
INSERT INTO `by_sequence` VALUES ('100286');
INSERT INTO `by_sequence` VALUES ('100287');
INSERT INTO `by_sequence` VALUES ('100288');
INSERT INTO `by_sequence` VALUES ('100289');
INSERT INTO `by_sequence` VALUES ('100290');
INSERT INTO `by_sequence` VALUES ('100291');
INSERT INTO `by_sequence` VALUES ('100292');
INSERT INTO `by_sequence` VALUES ('100293');
INSERT INTO `by_sequence` VALUES ('100294');
INSERT INTO `by_sequence` VALUES ('100295');
INSERT INTO `by_sequence` VALUES ('100296');
INSERT INTO `by_sequence` VALUES ('100297');
INSERT INTO `by_sequence` VALUES ('100298');
INSERT INTO `by_sequence` VALUES ('100299');
INSERT INTO `by_sequence` VALUES ('100300');

-- ----------------------------
-- Table structure for by_shop
-- ----------------------------
DROP TABLE IF EXISTS `by_shop`;
CREATE TABLE `by_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(225) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `shop_key` varchar(225) DEFAULT NULL,
  `img_href` varchar(77) DEFAULT NULL,
  `first_category_id` int(11) DEFAULT NULL,
  `second_category_id` int(11) DEFAULT NULL,
  `floor_id` int(11) DEFAULT NULL,
  `address` varchar(10) DEFAULT NULL,
  `business_hour` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_shop_shopKey_unique` (`shop_key`) USING BTREE,
  KEY `first_category_id` (`first_category_id`) USING BTREE,
  KEY `second_category_id` (`second_category_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `floor_id` (`floor_id`) USING BTREE,
  CONSTRAINT `by_shop_ibfk_1` FOREIGN KEY (`first_category_id`) REFERENCES `by_category` (`id`),
  CONSTRAINT `by_shop_ibfk_2` FOREIGN KEY (`second_category_id`) REFERENCES `by_category` (`id`),
  CONSTRAINT `by_shop_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `by_user` (`id`),
  CONSTRAINT `by_shop_ibfk_4` FOREIGN KEY (`floor_id`) REFERENCES `by_floor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_shop
-- ----------------------------
INSERT INTO `by_shop` VALUES ('17', '大马榴芒', null, 'terry', 'terry', '2016-11-21 10:20:10', '2016-11-21 10:20:10', '20107010007', '', '46', '48', '8', 'B05', '', '15026578868');
INSERT INTO `by_shop` VALUES ('18', '海外购', null, 'terry', 'terry', '2016-11-21 10:23:24', '2016-11-21 10:23:24', '20102010007', '', '45', '47', '2', '226', '', '15900958333');
INSERT INTO `by_shop` VALUES ('19', '猫山王', null, 'terry', 'terry', '2016-11-21 10:24:45', '2016-11-21 10:24:45', '20103010004', '', '46', '48', '3', '310', '', '13661976896');
INSERT INTO `by_shop` VALUES ('20', '玛丽莲', null, 'terry', 'terry', '2016-11-21 10:26:02', '2016-11-21 10:26:02', '20103010009', '', '46', '48', '3', '330', '', '13061722445');
INSERT INTO `by_shop` VALUES ('21', '莎莎美甲', null, 'terry', 'terry', '2016-11-21 10:32:57', '2016-11-21 10:32:57', '20102010006', '', '49', '50', '2', '225', '', '13764050420');
INSERT INTO `by_shop` VALUES ('22', '重庆熬家老火锅', null, 'terry', 'terry', '2016-11-21 10:40:14', '2016-11-21 10:40:14', '20105010001', '', '46', '48', '5', '502', '', '15001888432');
INSERT INTO `by_shop` VALUES ('23', '雪冰', null, 'terry', 'terry', '2016-11-21 10:41:25', '2016-11-21 10:41:25', '20102010005', '', '46', '48', '2', '222', '', '15821860834');
INSERT INTO `by_shop` VALUES ('24', '眼镜生活', null, 'terry', 'terry', '2016-11-21 10:42:28', '2016-11-21 10:42:35', '20102010008', '', '49', '52', '2', '230', '', '13918016889');
INSERT INTO `by_shop` VALUES ('25', '苹果数码', null, 'terry', 'terry', '2016-11-21 10:44:38', '2016-11-21 10:44:38', '20103010015', '', '45', '47', '3', '321', '', '17721237556');
INSERT INTO `by_shop` VALUES ('26', '玛食哒', null, 'terry', 'terry', '2016-11-21 10:45:34', '2016-11-21 10:45:34', '20104010009', '', '46', '48', '4', '418', '', '15821881707');
INSERT INTO `by_shop` VALUES ('27', 'Yeh', null, 'terry', 'terry', '2016-11-21 10:46:37', '2016-11-21 10:46:37', '20104010010', '', '46', '48', '4', '422', '', '18049772777');
INSERT INTO `by_shop` VALUES ('28', '签起味蕾', null, 'terry', 'terry', '2016-11-21 10:47:53', '2016-11-21 10:47:53', '20104010002', '', '46', '48', '4', '402', '', '18616170617');
INSERT INTO `by_shop` VALUES ('29', '大咀茶餐厅', null, 'terry', 'terry', '2016-11-21 10:49:06', '2016-11-21 10:49:06', '20103010010', '', '46', '48', '3', '308', '', '18930283949');
INSERT INTO `by_shop` VALUES ('30', '测试店铺', null, 'terry', 'terry', '2016-11-25 13:51:37', '2016-11-25 13:51:37', '20104010014', '', '45', '47', '2', '202', '', '');

-- ----------------------------
-- Table structure for by_shopping_mall
-- ----------------------------
DROP TABLE IF EXISTS `by_shopping_mall`;
CREATE TABLE `by_shopping_mall` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_shopping_mall
-- ----------------------------
INSERT INTO `by_shopping_mall` VALUES ('1', 'nx');
INSERT INTO `by_shopping_mall` VALUES ('2', 'jq');

-- ----------------------------
-- Table structure for by_shop_coupon_member
-- ----------------------------
DROP TABLE IF EXISTS `by_shop_coupon_member`;
CREATE TABLE `by_shop_coupon_member` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `member_id` bigint(20) DEFAULT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `exchanged_time` timestamp NULL DEFAULT NULL,
  `used_time` timestamp NULL DEFAULT NULL,
  `code` char(17) DEFAULT NULL,
  `trading_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`) USING BTREE,
  KEY `coupon_id` (`coupon_id`) USING BTREE,
  KEY `trading_id` (`trading_id`) USING BTREE,
  CONSTRAINT `by_shop_coupon_member_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`),
  CONSTRAINT `by_shop_coupon_member_ibfk_2` FOREIGN KEY (`coupon_id`) REFERENCES `by_coupon` (`id`),
  CONSTRAINT `by_shop_coupon_member_ibfk_3` FOREIGN KEY (`trading_id`) REFERENCES `by_trading` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_shop_coupon_member
-- ----------------------------
INSERT INTO `by_shop_coupon_member` VALUES ('1', '37', '1', '2016-12-06 10:53:32', null, '20161206480100220', null);
INSERT INTO `by_shop_coupon_member` VALUES ('2', '37', '1', '2016-12-06 10:53:32', null, '20161206500100221', null);
INSERT INTO `by_shop_coupon_member` VALUES ('3', '37', '1', '2016-12-06 10:53:32', null, '20161206507100222', null);
INSERT INTO `by_shop_coupon_member` VALUES ('4', '37', '1', '2016-12-06 10:53:32', null, '20161206512100223', null);
INSERT INTO `by_shop_coupon_member` VALUES ('5', '37', '1', '2016-12-06 10:53:32', null, '20161206518100224', null);
INSERT INTO `by_shop_coupon_member` VALUES ('6', '37', '1', '2016-12-06 10:56:15', null, '20161206278100225', null);
INSERT INTO `by_shop_coupon_member` VALUES ('7', '37', '1', '2016-12-06 10:56:15', null, '20161206283100226', null);
INSERT INTO `by_shop_coupon_member` VALUES ('8', '37', '1', '2016-12-06 10:56:15', null, '20161206290100227', null);
INSERT INTO `by_shop_coupon_member` VALUES ('9', '37', '1', '2016-12-06 10:56:21', null, '20161206160100228', null);
INSERT INTO `by_shop_coupon_member` VALUES ('10', '37', '1', '2016-12-06 10:56:21', null, '20161206165100229', null);
INSERT INTO `by_shop_coupon_member` VALUES ('11', '37', '1', '2016-12-06 11:02:51', null, '20161206786100230', null);
INSERT INTO `by_shop_coupon_member` VALUES ('12', '37', '1', '2016-12-06 11:02:51', null, '20161206792100231', null);
INSERT INTO `by_shop_coupon_member` VALUES ('13', '37', '1', '2016-12-06 11:02:51', null, '20161206798100232', null);
INSERT INTO `by_shop_coupon_member` VALUES ('14', '37', '1', '2016-12-06 11:02:51', null, '20161206806100233', null);
INSERT INTO `by_shop_coupon_member` VALUES ('15', '37', '1', '2016-12-06 11:03:00', null, '2016120665100234', null);
INSERT INTO `by_shop_coupon_member` VALUES ('16', '37', '1', '2016-12-07 16:34:05', null, '20161207382100235', null);
INSERT INTO `by_shop_coupon_member` VALUES ('65', '37', '1', '2016-12-14 13:32:16', null, '20161214122100284', null);
INSERT INTO `by_shop_coupon_member` VALUES ('66', '37', '1', '2016-12-14 13:32:19', null, '20161214221100285', null);
INSERT INTO `by_shop_coupon_member` VALUES ('67', '37', '1', '2016-12-14 13:32:21', null, '20161214236100286', null);
INSERT INTO `by_shop_coupon_member` VALUES ('68', '37', '1', '2016-12-14 13:32:33', null, '20161214112100287', null);
INSERT INTO `by_shop_coupon_member` VALUES ('69', '37', '1', '2016-12-14 13:32:36', null, '20161214110100288', null);
INSERT INTO `by_shop_coupon_member` VALUES ('70', '37', '1', '2016-12-14 13:32:48', null, '20161214799100289', null);
INSERT INTO `by_shop_coupon_member` VALUES ('71', '37', '1', '2016-12-14 13:32:50', null, '20161214854100290', null);
INSERT INTO `by_shop_coupon_member` VALUES ('72', '37', '1', '2016-12-14 13:32:56', null, '20161214524100291', null);
INSERT INTO `by_shop_coupon_member` VALUES ('73', '37', '1', '2016-12-14 13:33:03', null, '20161214859100292', null);
INSERT INTO `by_shop_coupon_member` VALUES ('74', '37', '1', '2016-12-14 13:34:08', null, '20161214580100293', null);
INSERT INTO `by_shop_coupon_member` VALUES ('75', '37', '1', '2016-12-14 13:34:18', null, '20161214661100294', null);
INSERT INTO `by_shop_coupon_member` VALUES ('76', '37', '1', '2016-12-14 13:34:25', null, '20161214422100295', null);
INSERT INTO `by_shop_coupon_member` VALUES ('77', '37', '1', '2016-12-14 13:34:30', null, '20161214561100296', null);
INSERT INTO `by_shop_coupon_member` VALUES ('78', '37', '1', '2016-12-14 13:34:37', null, '20161214268100297', null);
INSERT INTO `by_shop_coupon_member` VALUES ('79', '37', '1', '2016-12-14 13:38:13', '2016-12-14 16:57:31', '20161214632100298', null);
INSERT INTO `by_shop_coupon_member` VALUES ('81', '37', '4', '2016-12-14 13:55:01', '2016-12-14 16:39:33', '20161214999100300', null);

-- ----------------------------
-- Table structure for by_shop_menu
-- ----------------------------
DROP TABLE IF EXISTS `by_shop_menu`;
CREATE TABLE `by_shop_menu` (
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `menu_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shop_id`,`menu_id`),
  KEY `menu_id` (`menu_id`) USING BTREE,
  CONSTRAINT `by_shop_menu_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `by_shop` (`id`),
  CONSTRAINT `by_shop_menu_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `by_menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_shop_menu
-- ----------------------------

-- ----------------------------
-- Table structure for by_shop_rule
-- ----------------------------
DROP TABLE IF EXISTS `by_shop_rule`;
CREATE TABLE `by_shop_rule` (
  `shop_id` int(11) NOT NULL DEFAULT '0',
  `rule_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`shop_id`,`rule_id`),
  KEY `rule_id` (`rule_id`) USING BTREE,
  CONSTRAINT `by_shop_rule_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `by_shop` (`id`),
  CONSTRAINT `by_shop_rule_ibfk_2` FOREIGN KEY (`rule_id`) REFERENCES `by_rule` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_shop_rule
-- ----------------------------
INSERT INTO `by_shop_rule` VALUES ('30', '70');
INSERT INTO `by_shop_rule` VALUES ('30', '71');
INSERT INTO `by_shop_rule` VALUES ('30', '72');

-- ----------------------------
-- Table structure for by_trading
-- ----------------------------
DROP TABLE IF EXISTS `by_trading`;
CREATE TABLE `by_trading` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `shop_id` int(11) DEFAULT NULL,
  `member_id` bigint(20) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_trading_code_unique` (`code`) USING BTREE,
  KEY `shop_id` (`shop_id`) USING BTREE,
  KEY `member_id` (`member_id`) USING BTREE,
  KEY `by_trading_createdTime_index` (`created_time`) USING BTREE,
  CONSTRAINT `by_trading_ibfk_1` FOREIGN KEY (`shop_id`) REFERENCES `by_shop` (`id`),
  CONSTRAINT `by_trading_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `by_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=562 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_trading
-- ----------------------------
INSERT INTO `by_trading` VALUES ('359', '17', null, '2016-11-21 11:05:46', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('360', '17', null, '2016-11-21 11:06:46', '-0.01', null, null);
INSERT INTO `by_trading` VALUES ('361', '18', null, '2016-11-21 11:27:46', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('362', '18', null, '2016-11-21 11:28:46', '-0.01', null, null);
INSERT INTO `by_trading` VALUES ('363', '21', null, '2016-11-21 11:30:46', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('364', '21', null, '2016-11-21 11:31:46', '-0.01', null, null);
INSERT INTO `by_trading` VALUES ('365', '23', null, '2016-11-21 11:33:46', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('366', '23', null, '2016-11-21 11:34:46', '-0.01', null, null);
INSERT INTO `by_trading` VALUES ('367', '20', null, '2016-11-21 11:41:46', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('368', '28', null, '2016-11-21 12:19:46', '81', null, null);
INSERT INTO `by_trading` VALUES ('369', '25', null, '2016-11-21 12:27:46', '558', null, null);
INSERT INTO `by_trading` VALUES ('370', '28', null, '2016-11-21 13:29:46', '58', null, null);
INSERT INTO `by_trading` VALUES ('371', '28', null, '2016-11-21 13:31:45', '22', null, null);
INSERT INTO `by_trading` VALUES ('372', '28', null, '2016-11-21 13:59:45', '70', null, null);
INSERT INTO `by_trading` VALUES ('373', '24', null, '2016-11-21 14:57:45', '719', null, null);
INSERT INTO `by_trading` VALUES ('374', '18', null, '2016-11-21 15:03:45', '66', null, null);
INSERT INTO `by_trading` VALUES ('375', '20', null, '2016-11-21 16:49:45', '22', null, null);
INSERT INTO `by_trading` VALUES ('376', '25', null, '2016-11-21 18:58:45', '880', null, null);
INSERT INTO `by_trading` VALUES ('377', '24', null, '2016-11-21 19:45:44', '250', null, null);
INSERT INTO `by_trading` VALUES ('378', '18', null, '2016-11-21 19:50:44', '316', null, null);
INSERT INTO `by_trading` VALUES ('379', '20', null, '2016-11-21 20:37:44', '80', null, null);
INSERT INTO `by_trading` VALUES ('380', '20', null, '2016-11-21 20:38:44', '24', null, null);
INSERT INTO `by_trading` VALUES ('381', '20', null, '2016-11-21 20:39:44', '51', null, null);
INSERT INTO `by_trading` VALUES ('382', '28', null, '2016-11-21 21:06:44', '16', null, null);
INSERT INTO `by_trading` VALUES ('383', '18', null, '2016-11-21 21:30:44', '55', null, null);
INSERT INTO `by_trading` VALUES ('384', '21', null, '2016-11-21 21:56:44', '168', null, null);
INSERT INTO `by_trading` VALUES ('385', '18', null, '2016-11-22 11:01:42', '69', null, null);
INSERT INTO `by_trading` VALUES ('386', '18', null, '2016-11-22 11:52:42', '533', null, null);
INSERT INTO `by_trading` VALUES ('387', '24', null, '2016-11-22 12:08:42', '399', null, null);
INSERT INTO `by_trading` VALUES ('388', '28', null, '2016-11-22 12:12:42', '64', null, null);
INSERT INTO `by_trading` VALUES ('389', '18', null, '2016-11-22 12:21:41', '127', null, null);
INSERT INTO `by_trading` VALUES ('390', '28', null, '2016-11-22 12:26:41', '18', null, null);
INSERT INTO `by_trading` VALUES ('391', '19', null, '2016-11-22 14:53:41', '28', null, null);
INSERT INTO `by_trading` VALUES ('392', '20', null, '2016-11-22 15:22:41', '21', null, null);
INSERT INTO `by_trading` VALUES ('393', '18', null, '2016-11-22 16:05:41', '125', null, null);
INSERT INTO `by_trading` VALUES ('394', '18', null, '2016-11-22 16:27:41', '37', null, null);
INSERT INTO `by_trading` VALUES ('395', '20', null, '2016-11-22 18:51:40', '18', null, null);
INSERT INTO `by_trading` VALUES ('396', '20', null, '2016-11-22 20:17:40', '36', null, null);
INSERT INTO `by_trading` VALUES ('397', '24', null, '2016-11-22 20:27:40', '55', null, null);
INSERT INTO `by_trading` VALUES ('398', '24', null, '2016-11-23 12:39:37', '98', null, null);
INSERT INTO `by_trading` VALUES ('399', '18', null, '2016-11-23 14:06:37', '198', null, null);
INSERT INTO `by_trading` VALUES ('400', '25', null, '2016-11-23 14:27:37', '160', null, null);
INSERT INTO `by_trading` VALUES ('401', '28', null, '2016-11-23 15:17:37', '133', null, null);
INSERT INTO `by_trading` VALUES ('402', '20', null, '2016-11-23 15:52:37', '42', null, null);
INSERT INTO `by_trading` VALUES ('403', '20', null, '2016-11-23 15:53:37', '14', null, null);
INSERT INTO `by_trading` VALUES ('404', '19', null, '2016-11-23 16:30:37', '156', null, null);
INSERT INTO `by_trading` VALUES ('405', '18', null, '2016-11-23 16:52:37', '49', null, null);
INSERT INTO `by_trading` VALUES ('406', '18', null, '2016-11-23 17:09:37', '130', null, null);
INSERT INTO `by_trading` VALUES ('407', '18', null, '2016-11-23 17:13:36', '69', null, null);
INSERT INTO `by_trading` VALUES ('408', '18', null, '2016-11-23 17:29:36', '176', null, null);
INSERT INTO `by_trading` VALUES ('409', '24', null, '2016-11-23 17:47:36', '700', null, null);
INSERT INTO `by_trading` VALUES ('410', '18', null, '2016-11-23 18:35:36', '127', null, null);
INSERT INTO `by_trading` VALUES ('411', '18', null, '2016-11-23 19:01:36', '49', null, null);
INSERT INTO `by_trading` VALUES ('412', '18', null, '2016-11-23 19:41:36', '69', null, null);
INSERT INTO `by_trading` VALUES ('413', '18', null, '2016-11-23 19:56:36', '67', null, null);
INSERT INTO `by_trading` VALUES ('414', '20', null, '2016-11-23 20:12:36', '52', null, null);
INSERT INTO `by_trading` VALUES ('415', '18', null, '2016-11-23 21:16:36', '62', null, null);
INSERT INTO `by_trading` VALUES ('416', '18', null, '2016-11-23 21:31:36', '39', null, null);
INSERT INTO `by_trading` VALUES ('417', '25', null, '2016-11-23 21:35:36', '800', null, null);
INSERT INTO `by_trading` VALUES ('418', '24', null, '2016-11-24 14:21:33', '861', null, null);
INSERT INTO `by_trading` VALUES ('419', '18', null, '2016-11-24 15:48:33', '78', null, null);
INSERT INTO `by_trading` VALUES ('420', '19', null, '2016-11-24 16:54:32', '92', null, null);
INSERT INTO `by_trading` VALUES ('421', '20', null, '2016-11-24 17:01:32', '17', null, null);
INSERT INTO `by_trading` VALUES ('422', '18', null, '2016-11-24 17:13:32', '58', null, null);
INSERT INTO `by_trading` VALUES ('423', '20', null, '2016-11-24 17:15:32', '60', null, null);
INSERT INTO `by_trading` VALUES ('424', '24', null, '2016-11-24 18:12:32', '95', null, null);
INSERT INTO `by_trading` VALUES ('425', '17', null, '2016-11-24 19:45:32', '68', null, null);
INSERT INTO `by_trading` VALUES ('426', '18', null, '2016-11-24 19:52:32', '405', null, null);
INSERT INTO `by_trading` VALUES ('427', '28', null, '2016-11-24 20:26:32', '154', null, null);
INSERT INTO `by_trading` VALUES ('428', '20', null, '2016-11-24 20:32:32', '59', null, null);
INSERT INTO `by_trading` VALUES ('429', '20', null, '2016-11-24 21:41:32', '28', null, null);
INSERT INTO `by_trading` VALUES ('430', '24', null, '2016-11-25 09:57:29', '20', null, null);
INSERT INTO `by_trading` VALUES ('431', '27', null, '2016-11-25 10:21:29', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('432', '27', null, '2016-11-25 10:22:29', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('433', '18', null, '2016-11-25 10:31:29', '310', null, null);
INSERT INTO `by_trading` VALUES ('434', '18', null, '2016-11-25 10:41:29', '145', null, null);
INSERT INTO `by_trading` VALUES ('435', '18', null, '2016-11-25 12:25:29', '38', null, null);
INSERT INTO `by_trading` VALUES ('436', '18', null, '2016-11-25 12:29:29', '95', null, null);
INSERT INTO `by_trading` VALUES ('437', '27', null, '2016-11-25 12:32:29', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('438', '27', null, '2016-11-25 12:33:29', '0.01', null, null);
INSERT INTO `by_trading` VALUES ('439', '28', null, '2016-11-25 12:37:29', '44', null, null);
INSERT INTO `by_trading` VALUES ('440', '18', null, '2016-11-25 13:07:29', '138', null, null);
INSERT INTO `by_trading` VALUES ('441', '30', null, '2016-11-25 13:55:29', '1000', null, null);
INSERT INTO `by_trading` VALUES ('442', '30', null, '2016-11-25 14:09:29', '1000', null, null);
INSERT INTO `by_trading` VALUES ('443', '25', null, '2016-11-25 14:14:29', '55', null, null);
INSERT INTO `by_trading` VALUES ('444', '18', null, '2016-11-25 14:33:29', '57', null, null);
INSERT INTO `by_trading` VALUES ('445', '18', null, '2016-11-25 15:17:28', '118', null, null);
INSERT INTO `by_trading` VALUES ('446', '18', null, '2016-11-25 15:25:29', '78', null, null);
INSERT INTO `by_trading` VALUES ('447', '30', '740', '2016-11-25 15:34:28', '1000', null, '1000');
INSERT INTO `by_trading` VALUES ('448', '30', '740', '2016-11-25 15:51:28', '1000', null, '1000');
INSERT INTO `by_trading` VALUES ('449', '30', '740', '2016-11-25 15:52:28', '1000', null, '1000');
INSERT INTO `by_trading` VALUES ('450', '30', '740', '2016-11-25 15:54:28', '1000', null, '1000');
INSERT INTO `by_trading` VALUES ('451', '30', '740', '2016-11-25 16:29:28', '1000', null, '1000');
INSERT INTO `by_trading` VALUES ('452', '30', '740', '2016-11-25 16:31:28', '50', null, '50');
INSERT INTO `by_trading` VALUES ('453', '30', '740', '2016-11-25 16:33:28', '1000', null, '1000');
INSERT INTO `by_trading` VALUES ('454', '30', '740', '2016-11-25 16:35:28', '30.01', null, '30');
INSERT INTO `by_trading` VALUES ('455', '30', '740', '2016-11-25 16:38:28', '50', null, '100');
INSERT INTO `by_trading` VALUES ('456', '30', '740', '2016-11-25 16:39:28', '38', null, '38');
INSERT INTO `by_trading` VALUES ('457', '30', '740', '2016-11-25 16:42:28', '50', null, '120');
INSERT INTO `by_trading` VALUES ('458', '30', '37', '2016-11-25 16:56:26', '50', '123456', '120');
INSERT INTO `by_trading` VALUES ('459', '30', null, '2016-11-25 16:59:28', '30.01', null, null);
INSERT INTO `by_trading` VALUES ('460', '30', '740', '2016-11-25 17:54:28', '1000', null, '2020');
INSERT INTO `by_trading` VALUES ('461', '20', null, '2016-11-25 18:03:28', '22', null, null);
INSERT INTO `by_trading` VALUES ('462', '24', null, '2016-11-25 18:04:28', '55', null, null);
INSERT INTO `by_trading` VALUES ('463', '24', null, '2016-11-25 18:20:28', '50', null, null);
INSERT INTO `by_trading` VALUES ('464', '25', null, '2016-11-25 18:37:06', '6188', null, null);
INSERT INTO `by_trading` VALUES ('465', '18', null, '2016-11-25 18:37:28', '528', null, null);
INSERT INTO `by_trading` VALUES ('466', '20', null, '2016-11-25 18:57:28', '10', null, null);
INSERT INTO `by_trading` VALUES ('467', '18', null, '2016-11-25 19:12:28', '28', null, null);
INSERT INTO `by_trading` VALUES ('468', '18', null, '2016-11-25 19:15:28', '55', null, null);
INSERT INTO `by_trading` VALUES ('469', '24', null, '2016-11-25 19:19:28', '140', null, null);
INSERT INTO `by_trading` VALUES ('470', '28', null, '2016-11-25 19:22:28', '96', null, null);
INSERT INTO `by_trading` VALUES ('471', '25', null, '2016-11-25 19:35:28', '1200', null, null);
INSERT INTO `by_trading` VALUES ('472', '28', null, '2016-11-25 19:37:28', '54', null, null);
INSERT INTO `by_trading` VALUES ('473', '18', null, '2016-11-25 19:55:28', '110', null, null);
INSERT INTO `by_trading` VALUES ('474', '18', null, '2016-11-25 20:02:28', '29', null, null);
INSERT INTO `by_trading` VALUES ('475', '20', null, '2016-11-25 20:15:28', '25', null, null);
INSERT INTO `by_trading` VALUES ('476', '20', null, '2016-11-25 20:23:28', '22', null, null);
INSERT INTO `by_trading` VALUES ('477', '18', null, '2016-11-25 20:29:28', '326', null, null);
INSERT INTO `by_trading` VALUES ('478', '20', null, '2016-11-25 20:42:17', '45', null, null);
INSERT INTO `by_trading` VALUES ('479', '20', null, '2016-11-25 20:42:27', '17', null, null);
INSERT INTO `by_trading` VALUES ('480', '20', null, '2016-11-25 20:56:27', '17', null, null);
INSERT INTO `by_trading` VALUES ('481', '27', null, '2016-11-26 10:27:25', '30', null, null);
INSERT INTO `by_trading` VALUES ('482', '24', null, '2016-11-26 11:08:25', '1000', null, null);
INSERT INTO `by_trading` VALUES ('483', '18', null, '2016-11-26 11:09:25', '108', null, null);
INSERT INTO `by_trading` VALUES ('484', '28', null, '2016-11-26 11:29:25', '42', null, null);
INSERT INTO `by_trading` VALUES ('485', '19', null, '2016-11-26 11:57:25', '2000', null, null);
INSERT INTO `by_trading` VALUES ('486', '24', null, '2016-11-26 12:20:25', '539', null, null);
INSERT INTO `by_trading` VALUES ('487', '24', null, '2016-11-26 13:11:25', '20', null, null);
INSERT INTO `by_trading` VALUES ('488', '18', null, '2016-11-26 13:12:25', '129', null, null);
INSERT INTO `by_trading` VALUES ('489', '27', null, '2016-11-26 13:38:25', '31.1', null, null);
INSERT INTO `by_trading` VALUES ('490', '18', null, '2016-11-26 14:33:24', '259', null, null);
INSERT INTO `by_trading` VALUES ('491', '18', null, '2016-11-26 14:51:24', '96', null, null);
INSERT INTO `by_trading` VALUES ('492', '28', null, '2016-11-26 15:04:24', '336', null, null);
INSERT INTO `by_trading` VALUES ('493', '25', null, '2016-11-26 15:05:24', '149', null, null);
INSERT INTO `by_trading` VALUES ('494', '20', null, '2016-11-26 15:06:24', '76', null, null);
INSERT INTO `by_trading` VALUES ('495', '20', null, '2016-11-26 15:08:24', '10', null, null);
INSERT INTO `by_trading` VALUES ('496', '20', null, '2016-11-26 15:27:24', '38', null, null);
INSERT INTO `by_trading` VALUES ('497', '20', null, '2016-11-26 15:50:24', '51', null, null);
INSERT INTO `by_trading` VALUES ('498', '20', null, '2016-11-26 16:02:24', '88', null, null);
INSERT INTO `by_trading` VALUES ('499', '18', null, '2016-11-26 16:38:24', '66', null, null);
INSERT INTO `by_trading` VALUES ('500', '25', null, '2016-11-26 17:17:24', '4988', null, null);
INSERT INTO `by_trading` VALUES ('501', '28', null, '2016-11-26 18:22:24', '190', null, null);
INSERT INTO `by_trading` VALUES ('502', '20', null, '2016-11-26 18:41:24', '25', null, null);
INSERT INTO `by_trading` VALUES ('503', '28', null, '2016-11-26 18:52:24', '60', null, null);
INSERT INTO `by_trading` VALUES ('504', '28', null, '2016-11-26 19:15:24', '176', null, null);
INSERT INTO `by_trading` VALUES ('505', '24', null, '2016-11-26 19:18:24', '95', null, null);
INSERT INTO `by_trading` VALUES ('506', '28', null, '2016-11-26 19:23:24', '44', null, null);
INSERT INTO `by_trading` VALUES ('507', '19', null, '2016-11-26 19:46:24', '20', null, null);
INSERT INTO `by_trading` VALUES ('508', '20', null, '2016-11-26 19:55:24', '26', null, null);
INSERT INTO `by_trading` VALUES ('509', '20', null, '2016-11-26 20:20:23', '10', null, null);
INSERT INTO `by_trading` VALUES ('510', '20', null, '2016-11-26 20:25:23', '10', null, null);
INSERT INTO `by_trading` VALUES ('511', '20', null, '2016-11-26 20:26:23', '23', null, null);
INSERT INTO `by_trading` VALUES ('512', '20', null, '2016-11-26 20:31:23', '25', null, null);
INSERT INTO `by_trading` VALUES ('513', '20', null, '2016-11-26 20:57:23', '39', null, null);
INSERT INTO `by_trading` VALUES ('514', '18', null, '2016-11-26 21:00:23', '711', null, null);
INSERT INTO `by_trading` VALUES ('515', '18', null, '2016-11-26 21:09:23', '327', null, null);
INSERT INTO `by_trading` VALUES ('516', '18', null, '2016-11-26 21:11:23', '147', null, null);
INSERT INTO `by_trading` VALUES ('517', '18', null, '2016-11-26 21:19:23', '174', null, null);
INSERT INTO `by_trading` VALUES ('518', '18', null, '2016-11-27 10:13:21', '326', null, null);
INSERT INTO `by_trading` VALUES ('519', '18', null, '2016-11-27 10:27:21', '59', null, null);
INSERT INTO `by_trading` VALUES ('520', '18', null, '2016-11-27 11:16:21', '120', null, null);
INSERT INTO `by_trading` VALUES ('521', '18', null, '2016-11-27 11:42:21', '37', null, null);
INSERT INTO `by_trading` VALUES ('522', '24', null, '2016-11-27 12:02:21', '1268', null, null);
INSERT INTO `by_trading` VALUES ('523', '20', null, '2016-11-27 12:25:21', '10', null, null);
INSERT INTO `by_trading` VALUES ('524', '24', null, '2016-11-27 13:28:21', '599', null, null);
INSERT INTO `by_trading` VALUES ('525', '18', null, '2016-11-27 13:55:20', '194', null, null);
INSERT INTO `by_trading` VALUES ('526', '24', null, '2016-11-27 14:02:20', '399', null, null);
INSERT INTO `by_trading` VALUES ('527', '18', null, '2016-11-27 14:20:20', '290', null, null);
INSERT INTO `by_trading` VALUES ('528', '25', null, '2016-11-27 14:41:20', '288', null, null);
INSERT INTO `by_trading` VALUES ('529', '25', null, '2016-11-27 14:48:20', '120', null, null);
INSERT INTO `by_trading` VALUES ('530', '20', null, '2016-11-27 14:56:20', '39', null, null);
INSERT INTO `by_trading` VALUES ('531', '20', null, '2016-11-27 14:57:20', '10', null, null);
INSERT INTO `by_trading` VALUES ('532', '18', null, '2016-11-27 15:08:20', '95', null, null);
INSERT INTO `by_trading` VALUES ('533', '20', null, '2016-11-27 15:10:20', '10', null, null);
INSERT INTO `by_trading` VALUES ('534', '25', null, '2016-11-27 15:20:20', '7188', null, null);
INSERT INTO `by_trading` VALUES ('535', '18', null, '2016-11-27 16:08:20', '147', null, null);
INSERT INTO `by_trading` VALUES ('536', '25', null, '2016-11-27 16:39:20', '2000', null, null);
INSERT INTO `by_trading` VALUES ('537', '24', null, '2016-11-27 16:57:20', '170', null, null);
INSERT INTO `by_trading` VALUES ('538', '20', null, '2016-11-27 17:02:20', '21', null, null);
INSERT INTO `by_trading` VALUES ('539', '20', null, '2016-11-27 17:25:20', '47', null, null);
INSERT INTO `by_trading` VALUES ('540', '20', null, '2016-11-27 17:27:20', '32', null, null);
INSERT INTO `by_trading` VALUES ('541', '24', null, '2016-11-27 17:32:20', '550', null, null);
INSERT INTO `by_trading` VALUES ('542', '20', null, '2016-11-27 17:42:20', '10', null, null);
INSERT INTO `by_trading` VALUES ('543', '24', null, '2016-11-27 17:56:20', '95', null, null);
INSERT INTO `by_trading` VALUES ('544', '24', null, '2016-11-27 18:20:20', '299', null, null);
INSERT INTO `by_trading` VALUES ('545', '28', null, '2016-11-27 18:38:20', '18', null, null);
INSERT INTO `by_trading` VALUES ('546', '21', null, '2016-11-27 18:59:20', '50', null, null);
INSERT INTO `by_trading` VALUES ('547', '18', null, '2016-11-27 19:04:19', '116', null, null);
INSERT INTO `by_trading` VALUES ('548', '18', null, '2016-11-27 19:47:19', '224', null, null);
INSERT INTO `by_trading` VALUES ('549', '20', null, '2016-11-27 19:53:19', '30', null, null);
INSERT INTO `by_trading` VALUES ('550', '18', null, '2016-11-27 19:59:19', '258', null, null);
INSERT INTO `by_trading` VALUES ('551', '20', null, '2016-11-27 20:26:19', '10', null, null);
INSERT INTO `by_trading` VALUES ('552', '24', null, '2016-11-27 20:35:19', '599', null, null);
INSERT INTO `by_trading` VALUES ('553', '24', null, '2016-11-27 21:43:19', '390', null, null);
INSERT INTO `by_trading` VALUES ('554', '30', '37', '2016-11-28 17:06:15', '100', '1234567890123456789012', '220');
INSERT INTO `by_trading` VALUES ('555', '30', '37', '2016-11-29 17:18:25', '50', null, '120');
INSERT INTO `by_trading` VALUES ('556', '30', '37', '2016-12-01 22:50:37', '50', null, '50');
INSERT INTO `by_trading` VALUES ('557', '30', '37', '2016-12-02 11:40:11', '50', null, '50');
INSERT INTO `by_trading` VALUES ('558', '30', '37', '2016-12-02 12:23:54', '50', null, '0');
INSERT INTO `by_trading` VALUES ('559', '30', null, '2016-12-12 11:41:34', '50', null, null);
INSERT INTO `by_trading` VALUES ('560', '30', null, '2016-12-12 11:42:38', '50', null, null);
INSERT INTO `by_trading` VALUES ('561', '30', null, '2016-12-12 11:56:18', '50', null, null);

-- ----------------------------
-- Table structure for by_user
-- ----------------------------
DROP TABLE IF EXISTS `by_user`;
CREATE TABLE `by_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `password` char(64) DEFAULT NULL,
  `valid` smallint(6) DEFAULT '1',
  `user_authority` varchar(10) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `updated_by` varchar(20) DEFAULT NULL,
  `created_by` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `by_user_unique` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_user
-- ----------------------------
INSERT INTO `by_user` VALUES ('1', 'terry', 'c400db1fbff89199a05fa524787152214e724d5ec13ae2d1b72e0e8d55e73c61', '1', 'ROLE_ADMIN', null, '2016-09-05 22:59:24', null, null);
INSERT INTO `by_user` VALUES ('2', 'service', 'd4a9c133a1c5a48cf97c18c62456ef0fb2d6f59f6987a516847f987514791e34', '1', 'ROLE_ADMIN', '2016-11-24 13:35:00', '2016-11-24 13:36:51', null, 'terry');

-- ----------------------------
-- Table structure for by_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `by_user_auth`;
CREATE TABLE `by_user_auth` (
  `user_id` bigint(20) NOT NULL,
  `auth_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`auth_id`),
  KEY `auth_id` (`auth_id`) USING BTREE,
  CONSTRAINT `by_user_auth_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `by_user` (`id`),
  CONSTRAINT `by_user_auth_ibfk_2` FOREIGN KEY (`auth_id`) REFERENCES `by_authority` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_user_auth
-- ----------------------------
INSERT INTO `by_user_auth` VALUES ('1', '1');
INSERT INTO `by_user_auth` VALUES ('2', '2');

-- ----------------------------
-- Table structure for by_vehicle_entrance
-- ----------------------------
DROP TABLE IF EXISTS `by_vehicle_entrance`;
CREATE TABLE `by_vehicle_entrance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parkid` varchar(20) DEFAULT NULL,
  `entrance` varchar(20) DEFAULT NULL,
  `rectype` varchar(3) DEFAULT NULL,
  `carnum` varchar(10) DEFAULT NULL,
  `cartype` varchar(10) DEFAULT NULL,
  `enter_or_leave_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(10) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of by_vehicle_entrance
-- ----------------------------

-- ----------------------------
-- Table structure for revinfo
-- ----------------------------
DROP TABLE IF EXISTS `revinfo`;
CREATE TABLE `revinfo` (
  `REV` bigint(20) NOT NULL AUTO_INCREMENT,
  `REVTSTMP` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`REV`)
) ENGINE=InnoDB AUTO_INCREMENT=1527 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of revinfo
-- ----------------------------
INSERT INTO `revinfo` VALUES ('222', '1468377788675');
INSERT INTO `revinfo` VALUES ('223', '1468824474113');
INSERT INTO `revinfo` VALUES ('224', '1468824576003');
INSERT INTO `revinfo` VALUES ('225', '1468825361906');
INSERT INTO `revinfo` VALUES ('226', '1468835817845');
INSERT INTO `revinfo` VALUES ('227', '1468836478075');
INSERT INTO `revinfo` VALUES ('228', '1468836489107');
INSERT INTO `revinfo` VALUES ('229', '1468836494084');
INSERT INTO `revinfo` VALUES ('230', '1468836525696');
INSERT INTO `revinfo` VALUES ('231', '1468836599109');
INSERT INTO `revinfo` VALUES ('232', '1468836700865');
INSERT INTO `revinfo` VALUES ('233', '1468836801457');
INSERT INTO `revinfo` VALUES ('234', '1468836810976');
INSERT INTO `revinfo` VALUES ('235', '1468836892150');
INSERT INTO `revinfo` VALUES ('236', '1468837088167');
INSERT INTO `revinfo` VALUES ('237', '1468838401463');
INSERT INTO `revinfo` VALUES ('238', '1468907664958');
INSERT INTO `revinfo` VALUES ('239', '1468909292904');
INSERT INTO `revinfo` VALUES ('240', '1468911846075');
INSERT INTO `revinfo` VALUES ('241', '1469178956943');
INSERT INTO `revinfo` VALUES ('242', '1469503004717');
INSERT INTO `revinfo` VALUES ('243', '1471327785470');
INSERT INTO `revinfo` VALUES ('244', '1471327838017');
INSERT INTO `revinfo` VALUES ('245', '1473087942931');
INSERT INTO `revinfo` VALUES ('246', '1473088087318');
INSERT INTO `revinfo` VALUES ('247', '1473091946617');
INSERT INTO `revinfo` VALUES ('248', '1473134301974');
INSERT INTO `revinfo` VALUES ('249', '1473151387851');
INSERT INTO `revinfo` VALUES ('250', '1473151591036');
INSERT INTO `revinfo` VALUES ('251', '1473151755930');
INSERT INTO `revinfo` VALUES ('252', '1473151788576');
INSERT INTO `revinfo` VALUES ('253', '1473151792087');
INSERT INTO `revinfo` VALUES ('254', '1473154695797');
INSERT INTO `revinfo` VALUES ('255', '1473154720938');
INSERT INTO `revinfo` VALUES ('256', '1473227371196');
INSERT INTO `revinfo` VALUES ('257', '1473227409478');
INSERT INTO `revinfo` VALUES ('258', '1473227433814');
INSERT INTO `revinfo` VALUES ('259', '1473227440881');
INSERT INTO `revinfo` VALUES ('260', '1473257719909');
INSERT INTO `revinfo` VALUES ('261', '1473257730713');
INSERT INTO `revinfo` VALUES ('262', '1473257877279');
INSERT INTO `revinfo` VALUES ('263', '1473257916695');
INSERT INTO `revinfo` VALUES ('264', '1473258064266');
INSERT INTO `revinfo` VALUES ('265', '1473260508436');
INSERT INTO `revinfo` VALUES ('266', '1473260561619');
INSERT INTO `revinfo` VALUES ('267', '1473261492810');
INSERT INTO `revinfo` VALUES ('268', '1473263163487');
INSERT INTO `revinfo` VALUES ('269', '1473263196368');
INSERT INTO `revinfo` VALUES ('270', '1473264168250');
INSERT INTO `revinfo` VALUES ('271', '1473264384106');
INSERT INTO `revinfo` VALUES ('272', '1473264459720');
INSERT INTO `revinfo` VALUES ('273', '1473264561522');
INSERT INTO `revinfo` VALUES ('274', '1473264590069');
INSERT INTO `revinfo` VALUES ('275', '1473265118073');
INSERT INTO `revinfo` VALUES ('276', '1473267913996');
INSERT INTO `revinfo` VALUES ('277', '1473268671048');
INSERT INTO `revinfo` VALUES ('278', '1473284779002');
INSERT INTO `revinfo` VALUES ('279', '1473285040175');
INSERT INTO `revinfo` VALUES ('280', '1473288436795');
INSERT INTO `revinfo` VALUES ('281', '1473288797284');
INSERT INTO `revinfo` VALUES ('282', '1473289092459');
INSERT INTO `revinfo` VALUES ('283', '1473289610142');
INSERT INTO `revinfo` VALUES ('284', '1473290018589');
INSERT INTO `revinfo` VALUES ('285', '1473290533009');
INSERT INTO `revinfo` VALUES ('286', '1473291002181');
INSERT INTO `revinfo` VALUES ('287', '1473291013169');
INSERT INTO `revinfo` VALUES ('288', '1473292978288');
INSERT INTO `revinfo` VALUES ('289', '1473293885909');
INSERT INTO `revinfo` VALUES ('290', '1473294109313');
INSERT INTO `revinfo` VALUES ('291', '1473295575660');
INSERT INTO `revinfo` VALUES ('292', '1473296502632');
INSERT INTO `revinfo` VALUES ('293', '1473296674347');
INSERT INTO `revinfo` VALUES ('294', '1473296893662');
INSERT INTO `revinfo` VALUES ('295', '1473297133633');
INSERT INTO `revinfo` VALUES ('296', '1473297751126');
INSERT INTO `revinfo` VALUES ('297', '1473298228565');
INSERT INTO `revinfo` VALUES ('298', '1473298256864');
INSERT INTO `revinfo` VALUES ('299', '1473298313110');
INSERT INTO `revinfo` VALUES ('300', '1473298358712');
INSERT INTO `revinfo` VALUES ('301', '1473298472427');
INSERT INTO `revinfo` VALUES ('302', '1473298528348');
INSERT INTO `revinfo` VALUES ('303', '1473299443638');
INSERT INTO `revinfo` VALUES ('304', '1473299788903');
INSERT INTO `revinfo` VALUES ('305', '1473299904665');
INSERT INTO `revinfo` VALUES ('306', '1473299949479');
INSERT INTO `revinfo` VALUES ('307', '1473300007783');
INSERT INTO `revinfo` VALUES ('308', '1473300058576');
INSERT INTO `revinfo` VALUES ('309', '1473301028896');
INSERT INTO `revinfo` VALUES ('310', '1473301242131');
INSERT INTO `revinfo` VALUES ('311', '1473301353856');
INSERT INTO `revinfo` VALUES ('312', '1473301390224');
INSERT INTO `revinfo` VALUES ('313', '1473301410091');
INSERT INTO `revinfo` VALUES ('314', '1473302672150');
INSERT INTO `revinfo` VALUES ('315', '1473302775397');
INSERT INTO `revinfo` VALUES ('316', '1473302789910');
INSERT INTO `revinfo` VALUES ('317', '1473302821970');
INSERT INTO `revinfo` VALUES ('318', '1473303052199');
INSERT INTO `revinfo` VALUES ('319', '1473303135500');
INSERT INTO `revinfo` VALUES ('320', '1473303394819');
INSERT INTO `revinfo` VALUES ('321', '1473303489662');
INSERT INTO `revinfo` VALUES ('322', '1473303525223');
INSERT INTO `revinfo` VALUES ('323', '1473303579516');
INSERT INTO `revinfo` VALUES ('324', '1473303780606');
INSERT INTO `revinfo` VALUES ('325', '1473303794249');
INSERT INTO `revinfo` VALUES ('326', '1473303881881');
INSERT INTO `revinfo` VALUES ('327', '1473304291901');
INSERT INTO `revinfo` VALUES ('328', '1473304880335');
INSERT INTO `revinfo` VALUES ('329', '1473304907237');
INSERT INTO `revinfo` VALUES ('330', '1473305077299');
INSERT INTO `revinfo` VALUES ('331', '1473305970444');
INSERT INTO `revinfo` VALUES ('332', '1473306055751');
INSERT INTO `revinfo` VALUES ('333', '1473306153148');
INSERT INTO `revinfo` VALUES ('334', '1473306636909');
INSERT INTO `revinfo` VALUES ('335', '1473306686213');
INSERT INTO `revinfo` VALUES ('336', '1473306713303');
INSERT INTO `revinfo` VALUES ('337', '1473306731879');
INSERT INTO `revinfo` VALUES ('338', '1473306781365');
INSERT INTO `revinfo` VALUES ('339', '1473307282817');
INSERT INTO `revinfo` VALUES ('340', '1473307382031');
INSERT INTO `revinfo` VALUES ('341', '1473307437682');
INSERT INTO `revinfo` VALUES ('342', '1473307512701');
INSERT INTO `revinfo` VALUES ('343', '1473307684989');
INSERT INTO `revinfo` VALUES ('344', '1473307699280');
INSERT INTO `revinfo` VALUES ('345', '1473307755703');
INSERT INTO `revinfo` VALUES ('346', '1473308424633');
INSERT INTO `revinfo` VALUES ('347', '1473308981640');
INSERT INTO `revinfo` VALUES ('348', '1473309022629');
INSERT INTO `revinfo` VALUES ('349', '1473309162980');
INSERT INTO `revinfo` VALUES ('350', '1473309999302');
INSERT INTO `revinfo` VALUES ('351', '1473310004315');
INSERT INTO `revinfo` VALUES ('352', '1473310100262');
INSERT INTO `revinfo` VALUES ('353', '1473310173484');
INSERT INTO `revinfo` VALUES ('354', '1473310204646');
INSERT INTO `revinfo` VALUES ('355', '1473310303201');
INSERT INTO `revinfo` VALUES ('356', '1473310337573');
INSERT INTO `revinfo` VALUES ('357', '1473310510993');
INSERT INTO `revinfo` VALUES ('358', '1473310905874');
INSERT INTO `revinfo` VALUES ('359', '1473312134918');
INSERT INTO `revinfo` VALUES ('360', '1473312276934');
INSERT INTO `revinfo` VALUES ('361', '1473312315976');
INSERT INTO `revinfo` VALUES ('362', '1473312331214');
INSERT INTO `revinfo` VALUES ('363', '1473312395232');
INSERT INTO `revinfo` VALUES ('364', '1473312521975');
INSERT INTO `revinfo` VALUES ('365', '1473312550314');
INSERT INTO `revinfo` VALUES ('366', '1473313264886');
INSERT INTO `revinfo` VALUES ('367', '1473313702298');
INSERT INTO `revinfo` VALUES ('368', '1473313749928');
INSERT INTO `revinfo` VALUES ('369', '1473313813772');
INSERT INTO `revinfo` VALUES ('370', '1473313815169');
INSERT INTO `revinfo` VALUES ('371', '1473313916648');
INSERT INTO `revinfo` VALUES ('372', '1473314810893');
INSERT INTO `revinfo` VALUES ('373', '1473314843897');
INSERT INTO `revinfo` VALUES ('374', '1473314925141');
INSERT INTO `revinfo` VALUES ('375', '1473315023036');
INSERT INTO `revinfo` VALUES ('376', '1473315069812');
INSERT INTO `revinfo` VALUES ('377', '1473315087599');
INSERT INTO `revinfo` VALUES ('378', '1473315175804');
INSERT INTO `revinfo` VALUES ('379', '1473315325946');
INSERT INTO `revinfo` VALUES ('380', '1473315364022');
INSERT INTO `revinfo` VALUES ('381', '1473316265474');
INSERT INTO `revinfo` VALUES ('382', '1473316344594');
INSERT INTO `revinfo` VALUES ('383', '1473316385581');
INSERT INTO `revinfo` VALUES ('384', '1473316482145');
INSERT INTO `revinfo` VALUES ('385', '1473316699365');
INSERT INTO `revinfo` VALUES ('386', '1473316757392');
INSERT INTO `revinfo` VALUES ('387', '1473316908649');
INSERT INTO `revinfo` VALUES ('388', '1473317754719');
INSERT INTO `revinfo` VALUES ('389', '1473318078054');
INSERT INTO `revinfo` VALUES ('390', '1473318099403');
INSERT INTO `revinfo` VALUES ('391', '1473318630770');
INSERT INTO `revinfo` VALUES ('392', '1473319120137');
INSERT INTO `revinfo` VALUES ('393', '1473319206050');
INSERT INTO `revinfo` VALUES ('394', '1473320107298');
INSERT INTO `revinfo` VALUES ('395', '1473320792610');
INSERT INTO `revinfo` VALUES ('396', '1473320879292');
INSERT INTO `revinfo` VALUES ('397', '1473321528253');
INSERT INTO `revinfo` VALUES ('398', '1473321572894');
INSERT INTO `revinfo` VALUES ('399', '1473321959886');
INSERT INTO `revinfo` VALUES ('400', '1473322062544');
INSERT INTO `revinfo` VALUES ('401', '1473322090206');
INSERT INTO `revinfo` VALUES ('402', '1473322581028');
INSERT INTO `revinfo` VALUES ('403', '1473322619033');
INSERT INTO `revinfo` VALUES ('404', '1473323669580');
INSERT INTO `revinfo` VALUES ('405', '1473323703633');
INSERT INTO `revinfo` VALUES ('406', '1473323741982');
INSERT INTO `revinfo` VALUES ('407', '1473325452567');
INSERT INTO `revinfo` VALUES ('408', '1473325900684');
INSERT INTO `revinfo` VALUES ('409', '1473325982664');
INSERT INTO `revinfo` VALUES ('410', '1473326044028');
INSERT INTO `revinfo` VALUES ('411', '1473326173610');
INSERT INTO `revinfo` VALUES ('412', '1473326221093');
INSERT INTO `revinfo` VALUES ('413', '1473326663481');
INSERT INTO `revinfo` VALUES ('414', '1473329405412');
INSERT INTO `revinfo` VALUES ('415', '1473329745755');
INSERT INTO `revinfo` VALUES ('416', '1473329833234');
INSERT INTO `revinfo` VALUES ('417', '1473329860515');
INSERT INTO `revinfo` VALUES ('418', '1473329869797');
INSERT INTO `revinfo` VALUES ('419', '1473329903885');
INSERT INTO `revinfo` VALUES ('420', '1473330241593');
INSERT INTO `revinfo` VALUES ('421', '1473330280753');
INSERT INTO `revinfo` VALUES ('422', '1473330786822');
INSERT INTO `revinfo` VALUES ('423', '1473330988209');
INSERT INTO `revinfo` VALUES ('424', '1473331339237');
INSERT INTO `revinfo` VALUES ('425', '1473332212912');
INSERT INTO `revinfo` VALUES ('426', '1473332240751');
INSERT INTO `revinfo` VALUES ('427', '1473332535292');
INSERT INTO `revinfo` VALUES ('428', '1473333276008');
INSERT INTO `revinfo` VALUES ('429', '1473334090665');
INSERT INTO `revinfo` VALUES ('430', '1473334260787');
INSERT INTO `revinfo` VALUES ('431', '1473334615653');
INSERT INTO `revinfo` VALUES ('432', '1473334925733');
INSERT INTO `revinfo` VALUES ('433', '1473335149497');
INSERT INTO `revinfo` VALUES ('434', '1473335153280');
INSERT INTO `revinfo` VALUES ('435', '1473335862331');
INSERT INTO `revinfo` VALUES ('436', '1473335900407');
INSERT INTO `revinfo` VALUES ('437', '1473336058852');
INSERT INTO `revinfo` VALUES ('438', '1473336159162');
INSERT INTO `revinfo` VALUES ('439', '1473336236635');
INSERT INTO `revinfo` VALUES ('440', '1473336245439');
INSERT INTO `revinfo` VALUES ('441', '1473336337354');
INSERT INTO `revinfo` VALUES ('442', '1473336471097');
INSERT INTO `revinfo` VALUES ('443', '1473336473514');
INSERT INTO `revinfo` VALUES ('444', '1473336700164');
INSERT INTO `revinfo` VALUES ('445', '1473337038940');
INSERT INTO `revinfo` VALUES ('446', '1473338252301');
INSERT INTO `revinfo` VALUES ('447', '1473338714497');
INSERT INTO `revinfo` VALUES ('448', '1473339443789');
INSERT INTO `revinfo` VALUES ('449', '1473339482831');
INSERT INTO `revinfo` VALUES ('450', '1473339802794');
INSERT INTO `revinfo` VALUES ('451', '1473339872232');
INSERT INTO `revinfo` VALUES ('452', '1473340524134');
INSERT INTO `revinfo` VALUES ('453', '1473340577848');
INSERT INTO `revinfo` VALUES ('454', '1473341512358');
INSERT INTO `revinfo` VALUES ('455', '1473341578689');
INSERT INTO `revinfo` VALUES ('456', '1473341705407');
INSERT INTO `revinfo` VALUES ('457', '1473341864850');
INSERT INTO `revinfo` VALUES ('458', '1473342024162');
INSERT INTO `revinfo` VALUES ('459', '1473342573569');
INSERT INTO `revinfo` VALUES ('460', '1473342767384');
INSERT INTO `revinfo` VALUES ('461', '1473342843648');
INSERT INTO `revinfo` VALUES ('462', '1473342850506');
INSERT INTO `revinfo` VALUES ('463', '1473342890850');
INSERT INTO `revinfo` VALUES ('464', '1473342951274');
INSERT INTO `revinfo` VALUES ('465', '1473342992934');
INSERT INTO `revinfo` VALUES ('466', '1473343016365');
INSERT INTO `revinfo` VALUES ('467', '1473343030182');
INSERT INTO `revinfo` VALUES ('468', '1473343178376');
INSERT INTO `revinfo` VALUES ('469', '1473343424275');
INSERT INTO `revinfo` VALUES ('470', '1473343455167');
INSERT INTO `revinfo` VALUES ('471', '1473344694483');
INSERT INTO `revinfo` VALUES ('472', '1473346170473');
INSERT INTO `revinfo` VALUES ('473', '1473346342811');
INSERT INTO `revinfo` VALUES ('474', '1473346685599');
INSERT INTO `revinfo` VALUES ('475', '1473346737223');
INSERT INTO `revinfo` VALUES ('476', '1473347001854');
INSERT INTO `revinfo` VALUES ('477', '1473347308921');
INSERT INTO `revinfo` VALUES ('478', '1473347464409');
INSERT INTO `revinfo` VALUES ('479', '1473349317394');
INSERT INTO `revinfo` VALUES ('480', '1473351984678');
INSERT INTO `revinfo` VALUES ('481', '1473356661443');
INSERT INTO `revinfo` VALUES ('482', '1473356703022');
INSERT INTO `revinfo` VALUES ('483', '1473360689034');
INSERT INTO `revinfo` VALUES ('484', '1473373765392');
INSERT INTO `revinfo` VALUES ('485', '1473374954992');
INSERT INTO `revinfo` VALUES ('486', '1473374997666');
INSERT INTO `revinfo` VALUES ('487', '1473375818623');
INSERT INTO `revinfo` VALUES ('488', '1473376410630');
INSERT INTO `revinfo` VALUES ('489', '1473376567778');
INSERT INTO `revinfo` VALUES ('490', '1473376643289');
INSERT INTO `revinfo` VALUES ('491', '1473376835813');
INSERT INTO `revinfo` VALUES ('492', '1473378069064');
INSERT INTO `revinfo` VALUES ('493', '1473378334632');
INSERT INTO `revinfo` VALUES ('494', '1473380374333');
INSERT INTO `revinfo` VALUES ('495', '1473383277088');
INSERT INTO `revinfo` VALUES ('496', '1473383313329');
INSERT INTO `revinfo` VALUES ('497', '1473385306588');
INSERT INTO `revinfo` VALUES ('498', '1473385416117');
INSERT INTO `revinfo` VALUES ('499', '1473385526904');
INSERT INTO `revinfo` VALUES ('500', '1473385573244');
INSERT INTO `revinfo` VALUES ('501', '1473385752457');
INSERT INTO `revinfo` VALUES ('502', '1473386562662');
INSERT INTO `revinfo` VALUES ('503', '1473386682897');
INSERT INTO `revinfo` VALUES ('504', '1473387111027');
INSERT INTO `revinfo` VALUES ('505', '1473387183858');
INSERT INTO `revinfo` VALUES ('506', '1473387194388');
INSERT INTO `revinfo` VALUES ('507', '1473390784575');
INSERT INTO `revinfo` VALUES ('508', '1473390873843');
INSERT INTO `revinfo` VALUES ('509', '1473391126313');
INSERT INTO `revinfo` VALUES ('510', '1473391304726');
INSERT INTO `revinfo` VALUES ('511', '1473391397909');
INSERT INTO `revinfo` VALUES ('512', '1473391876315');
INSERT INTO `revinfo` VALUES ('513', '1473392550499');
INSERT INTO `revinfo` VALUES ('514', '1473393157545');
INSERT INTO `revinfo` VALUES ('515', '1473394277459');
INSERT INTO `revinfo` VALUES ('516', '1473394339338');
INSERT INTO `revinfo` VALUES ('517', '1473394765970');
INSERT INTO `revinfo` VALUES ('518', '1473395268092');
INSERT INTO `revinfo` VALUES ('519', '1473395495436');
INSERT INTO `revinfo` VALUES ('520', '1473395519238');
INSERT INTO `revinfo` VALUES ('521', '1473401098928');
INSERT INTO `revinfo` VALUES ('522', '1473401134916');
INSERT INTO `revinfo` VALUES ('523', '1473402021381');
INSERT INTO `revinfo` VALUES ('524', '1473402057737');
INSERT INTO `revinfo` VALUES ('525', '1473402895207');
INSERT INTO `revinfo` VALUES ('526', '1473404916605');
INSERT INTO `revinfo` VALUES ('527', '1473407250409');
INSERT INTO `revinfo` VALUES ('528', '1473407638177');
INSERT INTO `revinfo` VALUES ('529', '1473411238747');
INSERT INTO `revinfo` VALUES ('530', '1473411419622');
INSERT INTO `revinfo` VALUES ('531', '1473412543558');
INSERT INTO `revinfo` VALUES ('532', '1473412591330');
INSERT INTO `revinfo` VALUES ('533', '1473415140311');
INSERT INTO `revinfo` VALUES ('534', '1473417929941');
INSERT INTO `revinfo` VALUES ('535', '1473418890800');
INSERT INTO `revinfo` VALUES ('536', '1473419819500');
INSERT INTO `revinfo` VALUES ('537', '1473420869885');
INSERT INTO `revinfo` VALUES ('538', '1473421177174');
INSERT INTO `revinfo` VALUES ('539', '1473421782891');
INSERT INTO `revinfo` VALUES ('540', '1473422086754');
INSERT INTO `revinfo` VALUES ('541', '1473422161964');
INSERT INTO `revinfo` VALUES ('542', '1473424002881');
INSERT INTO `revinfo` VALUES ('543', '1473425017622');
INSERT INTO `revinfo` VALUES ('544', '1473428553340');
INSERT INTO `revinfo` VALUES ('545', '1473428607517');
INSERT INTO `revinfo` VALUES ('546', '1473429967107');
INSERT INTO `revinfo` VALUES ('547', '1473431031512');
INSERT INTO `revinfo` VALUES ('548', '1473464317815');
INSERT INTO `revinfo` VALUES ('549', '1473467099420');
INSERT INTO `revinfo` VALUES ('550', '1473467149143');
INSERT INTO `revinfo` VALUES ('551', '1473468485412');
INSERT INTO `revinfo` VALUES ('552', '1473471532615');
INSERT INTO `revinfo` VALUES ('553', '1473472759202');
INSERT INTO `revinfo` VALUES ('554', '1473472813780');
INSERT INTO `revinfo` VALUES ('555', '1473472838478');
INSERT INTO `revinfo` VALUES ('556', '1473476849940');
INSERT INTO `revinfo` VALUES ('557', '1473478744924');
INSERT INTO `revinfo` VALUES ('558', '1473480476523');
INSERT INTO `revinfo` VALUES ('559', '1473480553790');
INSERT INTO `revinfo` VALUES ('560', '1473480603200');
INSERT INTO `revinfo` VALUES ('561', '1473481175604');
INSERT INTO `revinfo` VALUES ('562', '1473481210576');
INSERT INTO `revinfo` VALUES ('563', '1473481376936');
INSERT INTO `revinfo` VALUES ('564', '1473481403332');
INSERT INTO `revinfo` VALUES ('565', '1473481425743');
INSERT INTO `revinfo` VALUES ('566', '1473482688461');
INSERT INTO `revinfo` VALUES ('567', '1473485328849');
INSERT INTO `revinfo` VALUES ('568', '1473486619028');
INSERT INTO `revinfo` VALUES ('569', '1473488510353');
INSERT INTO `revinfo` VALUES ('570', '1473488591689');
INSERT INTO `revinfo` VALUES ('571', '1473488609587');
INSERT INTO `revinfo` VALUES ('572', '1473489476246');
INSERT INTO `revinfo` VALUES ('573', '1473489538787');
INSERT INTO `revinfo` VALUES ('574', '1473489970251');
INSERT INTO `revinfo` VALUES ('575', '1473490763076');
INSERT INTO `revinfo` VALUES ('576', '1473490853243');
INSERT INTO `revinfo` VALUES ('577', '1473493805044');
INSERT INTO `revinfo` VALUES ('578', '1473493851426');
INSERT INTO `revinfo` VALUES ('579', '1473495246925');
INSERT INTO `revinfo` VALUES ('580', '1473495318419');
INSERT INTO `revinfo` VALUES ('581', '1473495331448');
INSERT INTO `revinfo` VALUES ('582', '1473495659931');
INSERT INTO `revinfo` VALUES ('583', '1473496033924');
INSERT INTO `revinfo` VALUES ('584', '1473496762864');
INSERT INTO `revinfo` VALUES ('585', '1473496948828');
INSERT INTO `revinfo` VALUES ('586', '1473496987241');
INSERT INTO `revinfo` VALUES ('587', '1473498129698');
INSERT INTO `revinfo` VALUES ('588', '1473498196876');
INSERT INTO `revinfo` VALUES ('589', '1473498217438');
INSERT INTO `revinfo` VALUES ('590', '1473498241985');
INSERT INTO `revinfo` VALUES ('591', '1473500210603');
INSERT INTO `revinfo` VALUES ('592', '1473502051988');
INSERT INTO `revinfo` VALUES ('593', '1473504357336');
INSERT INTO `revinfo` VALUES ('594', '1473504872278');
INSERT INTO `revinfo` VALUES ('595', '1473506171022');
INSERT INTO `revinfo` VALUES ('596', '1473506231238');
INSERT INTO `revinfo` VALUES ('597', '1473507742261');
INSERT INTO `revinfo` VALUES ('598', '1473508193581');
INSERT INTO `revinfo` VALUES ('599', '1473508456862');
INSERT INTO `revinfo` VALUES ('600', '1473509451025');
INSERT INTO `revinfo` VALUES ('601', '1473509598876');
INSERT INTO `revinfo` VALUES ('602', '1473510338131');
INSERT INTO `revinfo` VALUES ('603', '1473510435734');
INSERT INTO `revinfo` VALUES ('604', '1473510703944');
INSERT INTO `revinfo` VALUES ('605', '1473510883871');
INSERT INTO `revinfo` VALUES ('606', '1473513356261');
INSERT INTO `revinfo` VALUES ('607', '1473514875039');
INSERT INTO `revinfo` VALUES ('608', '1473515173201');
INSERT INTO `revinfo` VALUES ('609', '1473517067500');
INSERT INTO `revinfo` VALUES ('610', '1473517112859');
INSERT INTO `revinfo` VALUES ('611', '1473517256871');
INSERT INTO `revinfo` VALUES ('612', '1473517866764');
INSERT INTO `revinfo` VALUES ('613', '1473517895085');
INSERT INTO `revinfo` VALUES ('614', '1473526031489');
INSERT INTO `revinfo` VALUES ('615', '1473526153799');
INSERT INTO `revinfo` VALUES ('616', '1473526212939');
INSERT INTO `revinfo` VALUES ('617', '1473553321642');
INSERT INTO `revinfo` VALUES ('618', '1473553450170');
INSERT INTO `revinfo` VALUES ('619', '1473555549731');
INSERT INTO `revinfo` VALUES ('620', '1473557277314');
INSERT INTO `revinfo` VALUES ('621', '1473558864338');
INSERT INTO `revinfo` VALUES ('622', '1473558909962');
INSERT INTO `revinfo` VALUES ('623', '1473559037088');
INSERT INTO `revinfo` VALUES ('624', '1473562584052');
INSERT INTO `revinfo` VALUES ('625', '1473565015834');
INSERT INTO `revinfo` VALUES ('626', '1473565628004');
INSERT INTO `revinfo` VALUES ('627', '1473566202246');
INSERT INTO `revinfo` VALUES ('628', '1473566669470');
INSERT INTO `revinfo` VALUES ('629', '1473568117009');
INSERT INTO `revinfo` VALUES ('630', '1473568149588');
INSERT INTO `revinfo` VALUES ('631', '1473568248936');
INSERT INTO `revinfo` VALUES ('632', '1473568302878');
INSERT INTO `revinfo` VALUES ('633', '1473570207479');
INSERT INTO `revinfo` VALUES ('634', '1473570638321');
INSERT INTO `revinfo` VALUES ('635', '1473574320002');
INSERT INTO `revinfo` VALUES ('636', '1473574407215');
INSERT INTO `revinfo` VALUES ('637', '1473574432864');
INSERT INTO `revinfo` VALUES ('638', '1473574470757');
INSERT INTO `revinfo` VALUES ('639', '1473575254732');
INSERT INTO `revinfo` VALUES ('640', '1473575312176');
INSERT INTO `revinfo` VALUES ('641', '1473575319666');
INSERT INTO `revinfo` VALUES ('642', '1473575336865');
INSERT INTO `revinfo` VALUES ('643', '1473578695641');
INSERT INTO `revinfo` VALUES ('644', '1473579369176');
INSERT INTO `revinfo` VALUES ('645', '1473582561311');
INSERT INTO `revinfo` VALUES ('646', '1473584320309');
INSERT INTO `revinfo` VALUES ('647', '1473584376048');
INSERT INTO `revinfo` VALUES ('648', '1473584455308');
INSERT INTO `revinfo` VALUES ('649', '1473584684500');
INSERT INTO `revinfo` VALUES ('650', '1473584704004');
INSERT INTO `revinfo` VALUES ('651', '1473587454755');
INSERT INTO `revinfo` VALUES ('652', '1473588176775');
INSERT INTO `revinfo` VALUES ('653', '1473589809990');
INSERT INTO `revinfo` VALUES ('654', '1473589853311');
INSERT INTO `revinfo` VALUES ('655', '1473590596074');
INSERT INTO `revinfo` VALUES ('656', '1473590600965');
INSERT INTO `revinfo` VALUES ('657', '1473595375102');
INSERT INTO `revinfo` VALUES ('658', '1473596220015');
INSERT INTO `revinfo` VALUES ('659', '1473597368308');
INSERT INTO `revinfo` VALUES ('660', '1473597412737');
INSERT INTO `revinfo` VALUES ('661', '1473597413376');
INSERT INTO `revinfo` VALUES ('662', '1473597437614');
INSERT INTO `revinfo` VALUES ('663', '1473597473295');
INSERT INTO `revinfo` VALUES ('664', '1473597516328');
INSERT INTO `revinfo` VALUES ('665', '1473597526380');
INSERT INTO `revinfo` VALUES ('666', '1473597579673');
INSERT INTO `revinfo` VALUES ('667', '1473597584517');
INSERT INTO `revinfo` VALUES ('668', '1473597621308');
INSERT INTO `revinfo` VALUES ('669', '1473597627133');
INSERT INTO `revinfo` VALUES ('670', '1473597669959');
INSERT INTO `revinfo` VALUES ('671', '1473597720324');
INSERT INTO `revinfo` VALUES ('672', '1473597803199');
INSERT INTO `revinfo` VALUES ('673', '1473597813628');
INSERT INTO `revinfo` VALUES ('674', '1473597835271');
INSERT INTO `revinfo` VALUES ('675', '1473597959459');
INSERT INTO `revinfo` VALUES ('676', '1473597980510');
INSERT INTO `revinfo` VALUES ('677', '1473598014815');
INSERT INTO `revinfo` VALUES ('678', '1473598024049');
INSERT INTO `revinfo` VALUES ('679', '1473598043863');
INSERT INTO `revinfo` VALUES ('680', '1473598053284');
INSERT INTO `revinfo` VALUES ('681', '1473598063851');
INSERT INTO `revinfo` VALUES ('682', '1473598076189');
INSERT INTO `revinfo` VALUES ('683', '1473598078407');
INSERT INTO `revinfo` VALUES ('684', '1473598096766');
INSERT INTO `revinfo` VALUES ('685', '1473598097765');
INSERT INTO `revinfo` VALUES ('686', '1473598128195');
INSERT INTO `revinfo` VALUES ('687', '1473598147600');
INSERT INTO `revinfo` VALUES ('688', '1473598147965');
INSERT INTO `revinfo` VALUES ('689', '1473598156525');
INSERT INTO `revinfo` VALUES ('690', '1473598190125');
INSERT INTO `revinfo` VALUES ('691', '1473598225717');
INSERT INTO `revinfo` VALUES ('692', '1473598271556');
INSERT INTO `revinfo` VALUES ('693', '1473598449470');
INSERT INTO `revinfo` VALUES ('694', '1473598452558');
INSERT INTO `revinfo` VALUES ('695', '1473598475971');
INSERT INTO `revinfo` VALUES ('696', '1473598504815');
INSERT INTO `revinfo` VALUES ('697', '1473598587703');
INSERT INTO `revinfo` VALUES ('698', '1473598710868');
INSERT INTO `revinfo` VALUES ('699', '1473598741121');
INSERT INTO `revinfo` VALUES ('700', '1473598762839');
INSERT INTO `revinfo` VALUES ('701', '1473598943230');
INSERT INTO `revinfo` VALUES ('702', '1473599058311');
INSERT INTO `revinfo` VALUES ('703', '1473599134081');
INSERT INTO `revinfo` VALUES ('704', '1473599406374');
INSERT INTO `revinfo` VALUES ('705', '1473599415037');
INSERT INTO `revinfo` VALUES ('706', '1473599607191');
INSERT INTO `revinfo` VALUES ('707', '1473599647599');
INSERT INTO `revinfo` VALUES ('708', '1473599706896');
INSERT INTO `revinfo` VALUES ('709', '1473599737007');
INSERT INTO `revinfo` VALUES ('710', '1473599906860');
INSERT INTO `revinfo` VALUES ('711', '1473599937528');
INSERT INTO `revinfo` VALUES ('712', '1473599955230');
INSERT INTO `revinfo` VALUES ('713', '1473599965940');
INSERT INTO `revinfo` VALUES ('714', '1473599975380');
INSERT INTO `revinfo` VALUES ('715', '1473600107394');
INSERT INTO `revinfo` VALUES ('716', '1473600142522');
INSERT INTO `revinfo` VALUES ('717', '1473600159558');
INSERT INTO `revinfo` VALUES ('718', '1473600179642');
INSERT INTO `revinfo` VALUES ('719', '1473600247585');
INSERT INTO `revinfo` VALUES ('720', '1473600310279');
INSERT INTO `revinfo` VALUES ('721', '1473600352379');
INSERT INTO `revinfo` VALUES ('722', '1473600362712');
INSERT INTO `revinfo` VALUES ('723', '1473600501753');
INSERT INTO `revinfo` VALUES ('724', '1473600601247');
INSERT INTO `revinfo` VALUES ('725', '1473600675918');
INSERT INTO `revinfo` VALUES ('726', '1473600720898');
INSERT INTO `revinfo` VALUES ('727', '1473600729963');
INSERT INTO `revinfo` VALUES ('728', '1473600900052');
INSERT INTO `revinfo` VALUES ('729', '1473601015740');
INSERT INTO `revinfo` VALUES ('730', '1473601094091');
INSERT INTO `revinfo` VALUES ('731', '1473601153801');
INSERT INTO `revinfo` VALUES ('732', '1473601491299');
INSERT INTO `revinfo` VALUES ('733', '1473601998134');
INSERT INTO `revinfo` VALUES ('734', '1473602013766');
INSERT INTO `revinfo` VALUES ('735', '1473602075364');
INSERT INTO `revinfo` VALUES ('736', '1473602116158');
INSERT INTO `revinfo` VALUES ('737', '1473602122028');
INSERT INTO `revinfo` VALUES ('738', '1473602350344');
INSERT INTO `revinfo` VALUES ('739', '1473602411619');
INSERT INTO `revinfo` VALUES ('740', '1473602609959');
INSERT INTO `revinfo` VALUES ('741', '1473602908812');
INSERT INTO `revinfo` VALUES ('742', '1473603327579');
INSERT INTO `revinfo` VALUES ('743', '1473603355219');
INSERT INTO `revinfo` VALUES ('744', '1473603706608');
INSERT INTO `revinfo` VALUES ('745', '1473603889263');
INSERT INTO `revinfo` VALUES ('746', '1473604006153');
INSERT INTO `revinfo` VALUES ('747', '1473604196714');
INSERT INTO `revinfo` VALUES ('748', '1473604263337');
INSERT INTO `revinfo` VALUES ('749', '1473604283238');
INSERT INTO `revinfo` VALUES ('750', '1473604421609');
INSERT INTO `revinfo` VALUES ('751', '1473604439697');
INSERT INTO `revinfo` VALUES ('752', '1473604552374');
INSERT INTO `revinfo` VALUES ('753', '1473604565691');
INSERT INTO `revinfo` VALUES ('754', '1473604680565');
INSERT INTO `revinfo` VALUES ('755', '1473604933959');
INSERT INTO `revinfo` VALUES ('756', '1473605237012');
INSERT INTO `revinfo` VALUES ('757', '1473608536110');
INSERT INTO `revinfo` VALUES ('758', '1473608611893');
INSERT INTO `revinfo` VALUES ('759', '1473608649051');
INSERT INTO `revinfo` VALUES ('760', '1473608664745');
INSERT INTO `revinfo` VALUES ('761', '1473609533573');
INSERT INTO `revinfo` VALUES ('762', '1473609611312');
INSERT INTO `revinfo` VALUES ('763', '1473609660965');
INSERT INTO `revinfo` VALUES ('764', '1473613726639');
INSERT INTO `revinfo` VALUES ('765', '1473614462684');
INSERT INTO `revinfo` VALUES ('766', '1473626622580');
INSERT INTO `revinfo` VALUES ('767', '1473626772955');
INSERT INTO `revinfo` VALUES ('768', '1473631049119');
INSERT INTO `revinfo` VALUES ('769', '1473633905863');
INSERT INTO `revinfo` VALUES ('770', '1473635126354');
INSERT INTO `revinfo` VALUES ('771', '1473635169827');
INSERT INTO `revinfo` VALUES ('772', '1473635669763');
INSERT INTO `revinfo` VALUES ('773', '1473638283076');
INSERT INTO `revinfo` VALUES ('774', '1473641193042');
INSERT INTO `revinfo` VALUES ('775', '1473641532827');
INSERT INTO `revinfo` VALUES ('776', '1473641668846');
INSERT INTO `revinfo` VALUES ('777', '1473642648908');
INSERT INTO `revinfo` VALUES ('778', '1473643158636');
INSERT INTO `revinfo` VALUES ('779', '1473643454085');
INSERT INTO `revinfo` VALUES ('780', '1473643483202');
INSERT INTO `revinfo` VALUES ('781', '1473644872228');
INSERT INTO `revinfo` VALUES ('782', '1473645171893');
INSERT INTO `revinfo` VALUES ('783', '1473645409154');
INSERT INTO `revinfo` VALUES ('784', '1473646316579');
INSERT INTO `revinfo` VALUES ('785', '1473646346202');
INSERT INTO `revinfo` VALUES ('786', '1473646916152');
INSERT INTO `revinfo` VALUES ('787', '1473651208943');
INSERT INTO `revinfo` VALUES ('788', '1473654764159');
INSERT INTO `revinfo` VALUES ('789', '1473654831266');
INSERT INTO `revinfo` VALUES ('790', '1473654893529');
INSERT INTO `revinfo` VALUES ('791', '1473655617997');
INSERT INTO `revinfo` VALUES ('792', '1473656806278');
INSERT INTO `revinfo` VALUES ('793', '1473656848178');
INSERT INTO `revinfo` VALUES ('794', '1473660946942');
INSERT INTO `revinfo` VALUES ('795', '1473664923401');
INSERT INTO `revinfo` VALUES ('796', '1473665434216');
INSERT INTO `revinfo` VALUES ('797', '1473669615401');
INSERT INTO `revinfo` VALUES ('798', '1473670861536');
INSERT INTO `revinfo` VALUES ('799', '1473671603130');
INSERT INTO `revinfo` VALUES ('800', '1473674767243');
INSERT INTO `revinfo` VALUES ('801', '1473677479528');
INSERT INTO `revinfo` VALUES ('802', '1473678346769');
INSERT INTO `revinfo` VALUES ('803', '1473680348066');
INSERT INTO `revinfo` VALUES ('804', '1473684424179');
INSERT INTO `revinfo` VALUES ('805', '1473685287941');
INSERT INTO `revinfo` VALUES ('806', '1473689920474');
INSERT INTO `revinfo` VALUES ('807', '1473693956023');
INSERT INTO `revinfo` VALUES ('808', '1473694020265');
INSERT INTO `revinfo` VALUES ('809', '1473694036284');
INSERT INTO `revinfo` VALUES ('810', '1473724513298');
INSERT INTO `revinfo` VALUES ('811', '1473744970524');
INSERT INTO `revinfo` VALUES ('812', '1473747676034');
INSERT INTO `revinfo` VALUES ('813', '1473747768196');
INSERT INTO `revinfo` VALUES ('814', '1473751858177');
INSERT INTO `revinfo` VALUES ('815', '1473754694608');
INSERT INTO `revinfo` VALUES ('816', '1473754729704');
INSERT INTO `revinfo` VALUES ('817', '1473755892765');
INSERT INTO `revinfo` VALUES ('818', '1473759012927');
INSERT INTO `revinfo` VALUES ('819', '1473762236230');
INSERT INTO `revinfo` VALUES ('820', '1473762337827');
INSERT INTO `revinfo` VALUES ('821', '1473765819117');
INSERT INTO `revinfo` VALUES ('822', '1473776670753');
INSERT INTO `revinfo` VALUES ('823', '1473777176561');
INSERT INTO `revinfo` VALUES ('824', '1473812419575');
INSERT INTO `revinfo` VALUES ('825', '1473812536946');
INSERT INTO `revinfo` VALUES ('826', '1473812674174');
INSERT INTO `revinfo` VALUES ('827', '1473812715758');
INSERT INTO `revinfo` VALUES ('828', '1473816191082');
INSERT INTO `revinfo` VALUES ('829', '1473816262907');
INSERT INTO `revinfo` VALUES ('830', '1473820374720');
INSERT INTO `revinfo` VALUES ('831', '1473822052616');
INSERT INTO `revinfo` VALUES ('832', '1473822081964');
INSERT INTO `revinfo` VALUES ('833', '1473822705535');
INSERT INTO `revinfo` VALUES ('834', '1473822779987');
INSERT INTO `revinfo` VALUES ('835', '1473824319783');
INSERT INTO `revinfo` VALUES ('836', '1473827408662');
INSERT INTO `revinfo` VALUES ('837', '1473836175126');
INSERT INTO `revinfo` VALUES ('838', '1473836198988');
INSERT INTO `revinfo` VALUES ('839', '1473836408122');
INSERT INTO `revinfo` VALUES ('840', '1473837653630');
INSERT INTO `revinfo` VALUES ('841', '1473838397530');
INSERT INTO `revinfo` VALUES ('842', '1473838441033');
INSERT INTO `revinfo` VALUES ('843', '1473838845214');
INSERT INTO `revinfo` VALUES ('844', '1473839020577');
INSERT INTO `revinfo` VALUES ('845', '1473839027644');
INSERT INTO `revinfo` VALUES ('846', '1473839041417');
INSERT INTO `revinfo` VALUES ('847', '1473839200232');
INSERT INTO `revinfo` VALUES ('848', '1473839251581');
INSERT INTO `revinfo` VALUES ('849', '1473839276364');
INSERT INTO `revinfo` VALUES ('850', '1473839287390');
INSERT INTO `revinfo` VALUES ('851', '1473839635850');
INSERT INTO `revinfo` VALUES ('852', '1473839638840');
INSERT INTO `revinfo` VALUES ('853', '1473839893947');
INSERT INTO `revinfo` VALUES ('854', '1473840014659');
INSERT INTO `revinfo` VALUES ('855', '1473840034146');
INSERT INTO `revinfo` VALUES ('856', '1473841292438');
INSERT INTO `revinfo` VALUES ('857', '1473841491031');
INSERT INTO `revinfo` VALUES ('858', '1473841556259');
INSERT INTO `revinfo` VALUES ('859', '1473842336830');
INSERT INTO `revinfo` VALUES ('860', '1473842419724');
INSERT INTO `revinfo` VALUES ('861', '1473842468533');
INSERT INTO `revinfo` VALUES ('862', '1473842599559');
INSERT INTO `revinfo` VALUES ('863', '1473843199631');
INSERT INTO `revinfo` VALUES ('864', '1473843839953');
INSERT INTO `revinfo` VALUES ('865', '1473844213190');
INSERT INTO `revinfo` VALUES ('866', '1473844253632');
INSERT INTO `revinfo` VALUES ('867', '1473844778713');
INSERT INTO `revinfo` VALUES ('868', '1473848676673');
INSERT INTO `revinfo` VALUES ('869', '1473851562060');
INSERT INTO `revinfo` VALUES ('870', '1473854676793');
INSERT INTO `revinfo` VALUES ('871', '1473856486436');
INSERT INTO `revinfo` VALUES ('872', '1473856679873');
INSERT INTO `revinfo` VALUES ('873', '1473858729873');
INSERT INTO `revinfo` VALUES ('874', '1473858736442');
INSERT INTO `revinfo` VALUES ('875', '1473860887798');
INSERT INTO `revinfo` VALUES ('876', '1473867571211');
INSERT INTO `revinfo` VALUES ('877', '1473868168047');
INSERT INTO `revinfo` VALUES ('878', '1473894104598');
INSERT INTO `revinfo` VALUES ('879', '1473897883802');
INSERT INTO `revinfo` VALUES ('880', '1473897912809');
INSERT INTO `revinfo` VALUES ('881', '1473901769039');
INSERT INTO `revinfo` VALUES ('882', '1473903698199');
INSERT INTO `revinfo` VALUES ('883', '1473908893087');
INSERT INTO `revinfo` VALUES ('884', '1473909784474');
INSERT INTO `revinfo` VALUES ('885', '1473910656195');
INSERT INTO `revinfo` VALUES ('886', '1473910933960');
INSERT INTO `revinfo` VALUES ('887', '1473911155456');
INSERT INTO `revinfo` VALUES ('888', '1473915999501');
INSERT INTO `revinfo` VALUES ('889', '1473916659594');
INSERT INTO `revinfo` VALUES ('890', '1473916725229');
INSERT INTO `revinfo` VALUES ('891', '1473916757842');
INSERT INTO `revinfo` VALUES ('892', '1473916799877');
INSERT INTO `revinfo` VALUES ('893', '1473916958570');
INSERT INTO `revinfo` VALUES ('894', '1473919219746');
INSERT INTO `revinfo` VALUES ('895', '1473921212180');
INSERT INTO `revinfo` VALUES ('896', '1473922767471');
INSERT INTO `revinfo` VALUES ('897', '1473922843261');
INSERT INTO `revinfo` VALUES ('898', '1473922880798');
INSERT INTO `revinfo` VALUES ('899', '1473923751237');
INSERT INTO `revinfo` VALUES ('900', '1473927547558');
INSERT INTO `revinfo` VALUES ('901', '1473939762947');
INSERT INTO `revinfo` VALUES ('902', '1473939793217');
INSERT INTO `revinfo` VALUES ('903', '1473940508204');
INSERT INTO `revinfo` VALUES ('904', '1473940581962');
INSERT INTO `revinfo` VALUES ('905', '1473940596165');
INSERT INTO `revinfo` VALUES ('906', '1473941665713');
INSERT INTO `revinfo` VALUES ('907', '1473948234851');
INSERT INTO `revinfo` VALUES ('908', '1473948373113');
INSERT INTO `revinfo` VALUES ('909', '1473948378693');
INSERT INTO `revinfo` VALUES ('910', '1473949939519');
INSERT INTO `revinfo` VALUES ('911', '1473994399188');
INSERT INTO `revinfo` VALUES ('912', '1473997273743');
INSERT INTO `revinfo` VALUES ('913', '1473998754634');
INSERT INTO `revinfo` VALUES ('914', '1474001650690');
INSERT INTO `revinfo` VALUES ('915', '1474001666699');
INSERT INTO `revinfo` VALUES ('916', '1474003243006');
INSERT INTO `revinfo` VALUES ('917', '1474008487853');
INSERT INTO `revinfo` VALUES ('918', '1474010035777');
INSERT INTO `revinfo` VALUES ('919', '1474010065589');
INSERT INTO `revinfo` VALUES ('920', '1474012965795');
INSERT INTO `revinfo` VALUES ('921', '1474015714553');
INSERT INTO `revinfo` VALUES ('922', '1474015934575');
INSERT INTO `revinfo` VALUES ('923', '1474016958038');
INSERT INTO `revinfo` VALUES ('924', '1474023118035');
INSERT INTO `revinfo` VALUES ('925', '1474023142705');
INSERT INTO `revinfo` VALUES ('926', '1474026140506');
INSERT INTO `revinfo` VALUES ('927', '1474027804063');
INSERT INTO `revinfo` VALUES ('928', '1474037669405');
INSERT INTO `revinfo` VALUES ('929', '1474072488120');
INSERT INTO `revinfo` VALUES ('930', '1474072540429');
INSERT INTO `revinfo` VALUES ('931', '1474072561056');
INSERT INTO `revinfo` VALUES ('932', '1474078885450');
INSERT INTO `revinfo` VALUES ('933', '1474090562296');
INSERT INTO `revinfo` VALUES ('934', '1474091827520');
INSERT INTO `revinfo` VALUES ('935', '1474093612526');
INSERT INTO `revinfo` VALUES ('936', '1474100565187');
INSERT INTO `revinfo` VALUES ('937', '1474100569847');
INSERT INTO `revinfo` VALUES ('938', '1474101225433');
INSERT INTO `revinfo` VALUES ('939', '1474103170260');
INSERT INTO `revinfo` VALUES ('940', '1474103492768');
INSERT INTO `revinfo` VALUES ('941', '1474107436227');
INSERT INTO `revinfo` VALUES ('942', '1474108047625');
INSERT INTO `revinfo` VALUES ('943', '1474108459630');
INSERT INTO `revinfo` VALUES ('944', '1474109445905');
INSERT INTO `revinfo` VALUES ('945', '1474112180312');
INSERT INTO `revinfo` VALUES ('946', '1474114265604');
INSERT INTO `revinfo` VALUES ('947', '1474118330265');
INSERT INTO `revinfo` VALUES ('948', '1474167472460');
INSERT INTO `revinfo` VALUES ('949', '1474177243841');
INSERT INTO `revinfo` VALUES ('950', '1474178702131');
INSERT INTO `revinfo` VALUES ('951', '1474179857792');
INSERT INTO `revinfo` VALUES ('952', '1474179972322');
INSERT INTO `revinfo` VALUES ('953', '1474180001043');
INSERT INTO `revinfo` VALUES ('954', '1474180889836');
INSERT INTO `revinfo` VALUES ('955', '1474181269919');
INSERT INTO `revinfo` VALUES ('956', '1474185124112');
INSERT INTO `revinfo` VALUES ('957', '1474189905752');
INSERT INTO `revinfo` VALUES ('958', '1474200779392');
INSERT INTO `revinfo` VALUES ('959', '1474202370254');
INSERT INTO `revinfo` VALUES ('960', '1474237398442');
INSERT INTO `revinfo` VALUES ('961', '1474244659312');
INSERT INTO `revinfo` VALUES ('962', '1474244723401');
INSERT INTO `revinfo` VALUES ('963', '1474253194790');
INSERT INTO `revinfo` VALUES ('964', '1474259345576');
INSERT INTO `revinfo` VALUES ('965', '1474272708468');
INSERT INTO `revinfo` VALUES ('966', '1474272844765');
INSERT INTO `revinfo` VALUES ('967', '1474272909981');
INSERT INTO `revinfo` VALUES ('968', '1474286588684');
INSERT INTO `revinfo` VALUES ('969', '1474286665577');
INSERT INTO `revinfo` VALUES ('970', '1474286677158');
INSERT INTO `revinfo` VALUES ('971', '1474292665928');
INSERT INTO `revinfo` VALUES ('972', '1474292755877');
INSERT INTO `revinfo` VALUES ('973', '1474337451078');
INSERT INTO `revinfo` VALUES ('974', '1474345702974');
INSERT INTO `revinfo` VALUES ('975', '1474357844025');
INSERT INTO `revinfo` VALUES ('976', '1474365796704');
INSERT INTO `revinfo` VALUES ('977', '1474376905850');
INSERT INTO `revinfo` VALUES ('978', '1474379585433');
INSERT INTO `revinfo` VALUES ('979', '1474433312040');
INSERT INTO `revinfo` VALUES ('980', '1474463516616');
INSERT INTO `revinfo` VALUES ('981', '1474512540038');
INSERT INTO `revinfo` VALUES ('982', '1474512565652');
INSERT INTO `revinfo` VALUES ('983', '1474513443118');
INSERT INTO `revinfo` VALUES ('984', '1474530937320');
INSERT INTO `revinfo` VALUES ('985', '1474533641482');
INSERT INTO `revinfo` VALUES ('986', '1474533794392');
INSERT INTO `revinfo` VALUES ('987', '1474538178235');
INSERT INTO `revinfo` VALUES ('988', '1474538207032');
INSERT INTO `revinfo` VALUES ('989', '1474544936971');
INSERT INTO `revinfo` VALUES ('990', '1474544993542');
INSERT INTO `revinfo` VALUES ('991', '1474546327130');
INSERT INTO `revinfo` VALUES ('992', '1474550285424');
INSERT INTO `revinfo` VALUES ('993', '1474553393574');
INSERT INTO `revinfo` VALUES ('994', '1474553467636');
INSERT INTO `revinfo` VALUES ('995', '1474553482838');
INSERT INTO `revinfo` VALUES ('996', '1474583476716');
INSERT INTO `revinfo` VALUES ('997', '1474598986081');
INSERT INTO `revinfo` VALUES ('998', '1474599140879');
INSERT INTO `revinfo` VALUES ('999', '1474599229419');
INSERT INTO `revinfo` VALUES ('1000', '1474599312065');
INSERT INTO `revinfo` VALUES ('1001', '1474604849850');
INSERT INTO `revinfo` VALUES ('1002', '1474606305968');
INSERT INTO `revinfo` VALUES ('1003', '1474606371482');
INSERT INTO `revinfo` VALUES ('1004', '1474606401614');
INSERT INTO `revinfo` VALUES ('1005', '1474612467992');
INSERT INTO `revinfo` VALUES ('1006', '1474614707112');
INSERT INTO `revinfo` VALUES ('1007', '1474622881248');
INSERT INTO `revinfo` VALUES ('1008', '1474624315469');
INSERT INTO `revinfo` VALUES ('1009', '1474631304320');
INSERT INTO `revinfo` VALUES ('1010', '1474631341528');
INSERT INTO `revinfo` VALUES ('1011', '1474632229580');
INSERT INTO `revinfo` VALUES ('1012', '1474635556465');
INSERT INTO `revinfo` VALUES ('1013', '1474637644716');
INSERT INTO `revinfo` VALUES ('1014', '1474679006646');
INSERT INTO `revinfo` VALUES ('1015', '1474679091552');
INSERT INTO `revinfo` VALUES ('1016', '1474690846328');
INSERT INTO `revinfo` VALUES ('1017', '1474690956882');
INSERT INTO `revinfo` VALUES ('1018', '1474691008826');
INSERT INTO `revinfo` VALUES ('1019', '1474691034144');
INSERT INTO `revinfo` VALUES ('1020', '1474692671970');
INSERT INTO `revinfo` VALUES ('1021', '1474695090663');
INSERT INTO `revinfo` VALUES ('1022', '1474695679711');
INSERT INTO `revinfo` VALUES ('1023', '1474696372666');
INSERT INTO `revinfo` VALUES ('1024', '1474698722787');
INSERT INTO `revinfo` VALUES ('1025', '1474698803528');
INSERT INTO `revinfo` VALUES ('1026', '1474698843570');
INSERT INTO `revinfo` VALUES ('1027', '1474699685310');
INSERT INTO `revinfo` VALUES ('1028', '1474706427942');
INSERT INTO `revinfo` VALUES ('1029', '1474706476772');
INSERT INTO `revinfo` VALUES ('1030', '1474712531391');
INSERT INTO `revinfo` VALUES ('1031', '1474713942166');
INSERT INTO `revinfo` VALUES ('1032', '1474713974911');
INSERT INTO `revinfo` VALUES ('1033', '1474728435542');
INSERT INTO `revinfo` VALUES ('1034', '1474729512117');
INSERT INTO `revinfo` VALUES ('1035', '1474753134241');
INSERT INTO `revinfo` VALUES ('1036', '1474753413036');
INSERT INTO `revinfo` VALUES ('1037', '1474773979204');
INSERT INTO `revinfo` VALUES ('1038', '1474774320373');
INSERT INTO `revinfo` VALUES ('1039', '1474774693169');
INSERT INTO `revinfo` VALUES ('1040', '1474777324161');
INSERT INTO `revinfo` VALUES ('1041', '1474777375452');
INSERT INTO `revinfo` VALUES ('1042', '1474786339078');
INSERT INTO `revinfo` VALUES ('1043', '1474786400605');
INSERT INTO `revinfo` VALUES ('1044', '1474794306764');
INSERT INTO `revinfo` VALUES ('1045', '1474796712365');
INSERT INTO `revinfo` VALUES ('1046', '1474797329337');
INSERT INTO `revinfo` VALUES ('1047', '1474797455154');
INSERT INTO `revinfo` VALUES ('1048', '1474797751116');
INSERT INTO `revinfo` VALUES ('1049', '1474797782255');
INSERT INTO `revinfo` VALUES ('1050', '1474798096229');
INSERT INTO `revinfo` VALUES ('1051', '1474799055628');
INSERT INTO `revinfo` VALUES ('1052', '1474799165108');
INSERT INTO `revinfo` VALUES ('1053', '1474800972611');
INSERT INTO `revinfo` VALUES ('1054', '1474810779332');
INSERT INTO `revinfo` VALUES ('1055', '1474887097610');
INSERT INTO `revinfo` VALUES ('1056', '1474949752212');
INSERT INTO `revinfo` VALUES ('1057', '1474960929562');
INSERT INTO `revinfo` VALUES ('1058', '1474972544199');
INSERT INTO `revinfo` VALUES ('1059', '1474981932460');
INSERT INTO `revinfo` VALUES ('1060', '1474984167895');
INSERT INTO `revinfo` VALUES ('1061', '1474984470590');
INSERT INTO `revinfo` VALUES ('1062', '1475049014946');
INSERT INTO `revinfo` VALUES ('1063', '1475049055099');
INSERT INTO `revinfo` VALUES ('1064', '1475052945832');
INSERT INTO `revinfo` VALUES ('1065', '1475056768612');
INSERT INTO `revinfo` VALUES ('1066', '1475056821486');
INSERT INTO `revinfo` VALUES ('1067', '1475073117792');
INSERT INTO `revinfo` VALUES ('1068', '1475073181830');
INSERT INTO `revinfo` VALUES ('1069', '1475124095908');
INSERT INTO `revinfo` VALUES ('1070', '1475124175370');
INSERT INTO `revinfo` VALUES ('1071', '1475124176723');
INSERT INTO `revinfo` VALUES ('1072', '1475124204160');
INSERT INTO `revinfo` VALUES ('1073', '1475124217908');
INSERT INTO `revinfo` VALUES ('1074', '1475124364767');
INSERT INTO `revinfo` VALUES ('1075', '1475124365630');
INSERT INTO `revinfo` VALUES ('1076', '1475124415502');
INSERT INTO `revinfo` VALUES ('1077', '1475124546658');
INSERT INTO `revinfo` VALUES ('1078', '1475124749535');
INSERT INTO `revinfo` VALUES ('1079', '1475125195764');
INSERT INTO `revinfo` VALUES ('1080', '1475126251523');
INSERT INTO `revinfo` VALUES ('1081', '1475126776005');
INSERT INTO `revinfo` VALUES ('1082', '1475127823407');
INSERT INTO `revinfo` VALUES ('1083', '1475128366682');
INSERT INTO `revinfo` VALUES ('1084', '1475128395583');
INSERT INTO `revinfo` VALUES ('1085', '1475130204155');
INSERT INTO `revinfo` VALUES ('1086', '1475130471412');
INSERT INTO `revinfo` VALUES ('1087', '1475130582789');
INSERT INTO `revinfo` VALUES ('1088', '1475134011447');
INSERT INTO `revinfo` VALUES ('1089', '1475136393004');
INSERT INTO `revinfo` VALUES ('1090', '1475136620224');
INSERT INTO `revinfo` VALUES ('1091', '1475139328987');
INSERT INTO `revinfo` VALUES ('1092', '1475139602857');
INSERT INTO `revinfo` VALUES ('1093', '1475145566795');
INSERT INTO `revinfo` VALUES ('1094', '1475145614472');
INSERT INTO `revinfo` VALUES ('1095', '1475146617205');
INSERT INTO `revinfo` VALUES ('1096', '1475151957977');
INSERT INTO `revinfo` VALUES ('1097', '1475152015556');
INSERT INTO `revinfo` VALUES ('1098', '1475157927754');
INSERT INTO `revinfo` VALUES ('1099', '1475204507986');
INSERT INTO `revinfo` VALUES ('1100', '1475204957822');
INSERT INTO `revinfo` VALUES ('1101', '1475227119574');
INSERT INTO `revinfo` VALUES ('1102', '1475231649350');
INSERT INTO `revinfo` VALUES ('1103', '1475238089580');
INSERT INTO `revinfo` VALUES ('1104', '1475281706735');
INSERT INTO `revinfo` VALUES ('1105', '1475289579705');
INSERT INTO `revinfo` VALUES ('1106', '1475290491884');
INSERT INTO `revinfo` VALUES ('1107', '1475290632648');
INSERT INTO `revinfo` VALUES ('1108', '1475293542176');
INSERT INTO `revinfo` VALUES ('1109', '1475294160175');
INSERT INTO `revinfo` VALUES ('1110', '1475295534961');
INSERT INTO `revinfo` VALUES ('1111', '1475295693210');
INSERT INTO `revinfo` VALUES ('1112', '1475297205475');
INSERT INTO `revinfo` VALUES ('1113', '1475297969755');
INSERT INTO `revinfo` VALUES ('1114', '1475301775603');
INSERT INTO `revinfo` VALUES ('1115', '1475302643734');
INSERT INTO `revinfo` VALUES ('1116', '1475303197430');
INSERT INTO `revinfo` VALUES ('1117', '1475305716584');
INSERT INTO `revinfo` VALUES ('1118', '1475305775157');
INSERT INTO `revinfo` VALUES ('1119', '1475305790609');
INSERT INTO `revinfo` VALUES ('1120', '1475306056033');
INSERT INTO `revinfo` VALUES ('1121', '1475317375982');
INSERT INTO `revinfo` VALUES ('1122', '1475317514367');
INSERT INTO `revinfo` VALUES ('1123', '1475317523581');
INSERT INTO `revinfo` VALUES ('1124', '1475318123560');
INSERT INTO `revinfo` VALUES ('1125', '1475318206958');
INSERT INTO `revinfo` VALUES ('1126', '1475318295207');
INSERT INTO `revinfo` VALUES ('1127', '1475324396256');
INSERT INTO `revinfo` VALUES ('1128', '1475363684916');
INSERT INTO `revinfo` VALUES ('1129', '1475375570918');
INSERT INTO `revinfo` VALUES ('1130', '1475378362478');
INSERT INTO `revinfo` VALUES ('1131', '1475378391195');
INSERT INTO `revinfo` VALUES ('1132', '1475381044943');
INSERT INTO `revinfo` VALUES ('1133', '1475383441773');
INSERT INTO `revinfo` VALUES ('1134', '1475390407195');
INSERT INTO `revinfo` VALUES ('1135', '1475390614093');
INSERT INTO `revinfo` VALUES ('1136', '1475400194206');
INSERT INTO `revinfo` VALUES ('1137', '1475401536274');
INSERT INTO `revinfo` VALUES ('1138', '1475407935082');
INSERT INTO `revinfo` VALUES ('1139', '1475412628570');
INSERT INTO `revinfo` VALUES ('1140', '1475412923405');
INSERT INTO `revinfo` VALUES ('1141', '1475416818230');
INSERT INTO `revinfo` VALUES ('1142', '1475461333769');
INSERT INTO `revinfo` VALUES ('1143', '1475461349929');
INSERT INTO `revinfo` VALUES ('1144', '1475468161140');
INSERT INTO `revinfo` VALUES ('1145', '1475468681859');
INSERT INTO `revinfo` VALUES ('1146', '1475494545508');
INSERT INTO `revinfo` VALUES ('1147', '1475505477501');
INSERT INTO `revinfo` VALUES ('1148', '1475550124334');
INSERT INTO `revinfo` VALUES ('1149', '1475550224717');
INSERT INTO `revinfo` VALUES ('1150', '1475557390106');
INSERT INTO `revinfo` VALUES ('1151', '1475563281339');
INSERT INTO `revinfo` VALUES ('1152', '1475567241188');
INSERT INTO `revinfo` VALUES ('1153', '1475567497688');
INSERT INTO `revinfo` VALUES ('1154', '1475567550593');
INSERT INTO `revinfo` VALUES ('1155', '1475572742176');
INSERT INTO `revinfo` VALUES ('1156', '1475572770756');
INSERT INTO `revinfo` VALUES ('1157', '1475577204716');
INSERT INTO `revinfo` VALUES ('1158', '1475577454307');
INSERT INTO `revinfo` VALUES ('1159', '1475577485646');
INSERT INTO `revinfo` VALUES ('1160', '1475578406575');
INSERT INTO `revinfo` VALUES ('1161', '1475582605062');
INSERT INTO `revinfo` VALUES ('1162', '1475583821660');
INSERT INTO `revinfo` VALUES ('1163', '1475586561363');
INSERT INTO `revinfo` VALUES ('1164', '1475592081944');
INSERT INTO `revinfo` VALUES ('1165', '1475633139844');
INSERT INTO `revinfo` VALUES ('1166', '1475636917950');
INSERT INTO `revinfo` VALUES ('1167', '1475636985921');
INSERT INTO `revinfo` VALUES ('1168', '1475641780287');
INSERT INTO `revinfo` VALUES ('1169', '1475657079010');
INSERT INTO `revinfo` VALUES ('1170', '1475659737833');
INSERT INTO `revinfo` VALUES ('1171', '1475662753410');
INSERT INTO `revinfo` VALUES ('1172', '1475663388747');
INSERT INTO `revinfo` VALUES ('1173', '1475665349607');
INSERT INTO `revinfo` VALUES ('1174', '1475665503588');
INSERT INTO `revinfo` VALUES ('1175', '1475665522265');
INSERT INTO `revinfo` VALUES ('1176', '1475667797191');
INSERT INTO `revinfo` VALUES ('1177', '1475725959416');
INSERT INTO `revinfo` VALUES ('1178', '1475725989097');
INSERT INTO `revinfo` VALUES ('1179', '1475726920726');
INSERT INTO `revinfo` VALUES ('1180', '1475726977998');
INSERT INTO `revinfo` VALUES ('1181', '1475727016134');
INSERT INTO `revinfo` VALUES ('1182', '1475728919832');
INSERT INTO `revinfo` VALUES ('1183', '1475729092126');
INSERT INTO `revinfo` VALUES ('1184', '1475729125937');
INSERT INTO `revinfo` VALUES ('1185', '1475734995143');
INSERT INTO `revinfo` VALUES ('1186', '1475735204108');
INSERT INTO `revinfo` VALUES ('1187', '1475737003988');
INSERT INTO `revinfo` VALUES ('1188', '1475737164603');
INSERT INTO `revinfo` VALUES ('1189', '1475741204279');
INSERT INTO `revinfo` VALUES ('1190', '1475741430978');
INSERT INTO `revinfo` VALUES ('1191', '1475742915741');
INSERT INTO `revinfo` VALUES ('1192', '1475742950948');
INSERT INTO `revinfo` VALUES ('1193', '1475745474386');
INSERT INTO `revinfo` VALUES ('1194', '1475752606624');
INSERT INTO `revinfo` VALUES ('1195', '1475752651859');
INSERT INTO `revinfo` VALUES ('1196', '1475753956149');
INSERT INTO `revinfo` VALUES ('1197', '1475755407104');
INSERT INTO `revinfo` VALUES ('1198', '1475757428464');
INSERT INTO `revinfo` VALUES ('1199', '1475757893241');
INSERT INTO `revinfo` VALUES ('1200', '1475757943961');
INSERT INTO `revinfo` VALUES ('1201', '1475761263576');
INSERT INTO `revinfo` VALUES ('1202', '1475761308644');
INSERT INTO `revinfo` VALUES ('1203', '1475764881950');
INSERT INTO `revinfo` VALUES ('1204', '1475816151868');
INSERT INTO `revinfo` VALUES ('1205', '1475817494960');
INSERT INTO `revinfo` VALUES ('1206', '1475818638650');
INSERT INTO `revinfo` VALUES ('1207', '1475818967596');
INSERT INTO `revinfo` VALUES ('1208', '1475823096641');
INSERT INTO `revinfo` VALUES ('1209', '1475828730866');
INSERT INTO `revinfo` VALUES ('1210', '1475829093140');
INSERT INTO `revinfo` VALUES ('1211', '1475832746384');
INSERT INTO `revinfo` VALUES ('1212', '1475832893111');
INSERT INTO `revinfo` VALUES ('1213', '1475837438150');
INSERT INTO `revinfo` VALUES ('1214', '1475837513950');
INSERT INTO `revinfo` VALUES ('1215', '1475837535812');
INSERT INTO `revinfo` VALUES ('1216', '1475843154398');
INSERT INTO `revinfo` VALUES ('1217', '1475843224592');
INSERT INTO `revinfo` VALUES ('1218', '1475845005508');
INSERT INTO `revinfo` VALUES ('1219', '1475846554371');
INSERT INTO `revinfo` VALUES ('1220', '1475849604054');
INSERT INTO `revinfo` VALUES ('1221', '1475849649298');
INSERT INTO `revinfo` VALUES ('1222', '1475882712193');
INSERT INTO `revinfo` VALUES ('1223', '1475913589913');
INSERT INTO `revinfo` VALUES ('1224', '1475913698383');
INSERT INTO `revinfo` VALUES ('1225', '1475913714696');
INSERT INTO `revinfo` VALUES ('1226', '1475930032501');
INSERT INTO `revinfo` VALUES ('1227', '1475935871162');
INSERT INTO `revinfo` VALUES ('1228', '1475985863419');
INSERT INTO `revinfo` VALUES ('1229', '1475991627218');
INSERT INTO `revinfo` VALUES ('1230', '1475996466409');
INSERT INTO `revinfo` VALUES ('1231', '1476018457351');
INSERT INTO `revinfo` VALUES ('1232', '1476021003715');
INSERT INTO `revinfo` VALUES ('1233', '1476089233939');
INSERT INTO `revinfo` VALUES ('1234', '1476103549011');
INSERT INTO `revinfo` VALUES ('1235', '1476151770607');
INSERT INTO `revinfo` VALUES ('1236', '1476165028663');
INSERT INTO `revinfo` VALUES ('1237', '1476165108523');
INSERT INTO `revinfo` VALUES ('1238', '1476165132739');
INSERT INTO `revinfo` VALUES ('1239', '1476246688741');
INSERT INTO `revinfo` VALUES ('1240', '1476278859383');
INSERT INTO `revinfo` VALUES ('1241', '1476313774458');
INSERT INTO `revinfo` VALUES ('1242', '1476324566177');
INSERT INTO `revinfo` VALUES ('1243', '1476324622154');
INSERT INTO `revinfo` VALUES ('1244', '1476327167303');
INSERT INTO `revinfo` VALUES ('1245', '1476328447829');
INSERT INTO `revinfo` VALUES ('1246', '1476355763039');
INSERT INTO `revinfo` VALUES ('1247', '1476367491370');
INSERT INTO `revinfo` VALUES ('1248', '1476367517506');
INSERT INTO `revinfo` VALUES ('1249', '1476442003496');
INSERT INTO `revinfo` VALUES ('1250', '1476446485328');
INSERT INTO `revinfo` VALUES ('1251', '1476446767149');
INSERT INTO `revinfo` VALUES ('1252', '1476446918406');
INSERT INTO `revinfo` VALUES ('1253', '1476446970279');
INSERT INTO `revinfo` VALUES ('1254', '1476447623173');
INSERT INTO `revinfo` VALUES ('1255', '1476447625300');
INSERT INTO `revinfo` VALUES ('1256', '1476447781791');
INSERT INTO `revinfo` VALUES ('1257', '1476448175643');
INSERT INTO `revinfo` VALUES ('1258', '1476448498940');
INSERT INTO `revinfo` VALUES ('1259', '1476448646133');
INSERT INTO `revinfo` VALUES ('1260', '1476448664619');
INSERT INTO `revinfo` VALUES ('1261', '1476448766677');
INSERT INTO `revinfo` VALUES ('1262', '1476448946056');
INSERT INTO `revinfo` VALUES ('1263', '1476450610581');
INSERT INTO `revinfo` VALUES ('1264', '1476450907616');
INSERT INTO `revinfo` VALUES ('1265', '1476451450414');
INSERT INTO `revinfo` VALUES ('1266', '1476460917960');
INSERT INTO `revinfo` VALUES ('1267', '1476460998590');
INSERT INTO `revinfo` VALUES ('1268', '1476498690797');
INSERT INTO `revinfo` VALUES ('1269', '1476498740553');
INSERT INTO `revinfo` VALUES ('1270', '1476498788507');
INSERT INTO `revinfo` VALUES ('1271', '1476501515236');
INSERT INTO `revinfo` VALUES ('1272', '1476502025389');
INSERT INTO `revinfo` VALUES ('1273', '1476502178373');
INSERT INTO `revinfo` VALUES ('1274', '1476502202937');
INSERT INTO `revinfo` VALUES ('1275', '1476507791216');
INSERT INTO `revinfo` VALUES ('1276', '1476509672524');
INSERT INTO `revinfo` VALUES ('1277', '1476510239435');
INSERT INTO `revinfo` VALUES ('1278', '1476510284619');
INSERT INTO `revinfo` VALUES ('1279', '1476516408223');
INSERT INTO `revinfo` VALUES ('1280', '1476522678889');
INSERT INTO `revinfo` VALUES ('1281', '1476523736807');
INSERT INTO `revinfo` VALUES ('1282', '1476525487208');
INSERT INTO `revinfo` VALUES ('1283', '1476591022990');
INSERT INTO `revinfo` VALUES ('1284', '1476598665380');
INSERT INTO `revinfo` VALUES ('1285', '1476607182235');
INSERT INTO `revinfo` VALUES ('1286', '1476607219899');
INSERT INTO `revinfo` VALUES ('1287', '1476607651295');
INSERT INTO `revinfo` VALUES ('1288', '1476611799330');
INSERT INTO `revinfo` VALUES ('1289', '1476615043711');
INSERT INTO `revinfo` VALUES ('1290', '1476628164034');
INSERT INTO `revinfo` VALUES ('1291', '1476628841134');
INSERT INTO `revinfo` VALUES ('1292', '1476628869224');
INSERT INTO `revinfo` VALUES ('1293', '1476676413283');
INSERT INTO `revinfo` VALUES ('1294', '1476677530381');
INSERT INTO `revinfo` VALUES ('1295', '1476681591860');
INSERT INTO `revinfo` VALUES ('1296', '1476694491464');
INSERT INTO `revinfo` VALUES ('1297', '1476754419016');
INSERT INTO `revinfo` VALUES ('1298', '1476775729649');
INSERT INTO `revinfo` VALUES ('1299', '1476783190743');
INSERT INTO `revinfo` VALUES ('1300', '1476788449998');
INSERT INTO `revinfo` VALUES ('1301', '1476788529005');
INSERT INTO `revinfo` VALUES ('1302', '1476793646758');
INSERT INTO `revinfo` VALUES ('1303', '1476844706494');
INSERT INTO `revinfo` VALUES ('1304', '1476849475042');
INSERT INTO `revinfo` VALUES ('1305', '1476941300928');
INSERT INTO `revinfo` VALUES ('1306', '1476958488791');
INSERT INTO `revinfo` VALUES ('1307', '1476959702442');
INSERT INTO `revinfo` VALUES ('1308', '1476960162175');
INSERT INTO `revinfo` VALUES ('1309', '1476961658704');
INSERT INTO `revinfo` VALUES ('1310', '1476961687510');
INSERT INTO `revinfo` VALUES ('1311', '1476961848903');
INSERT INTO `revinfo` VALUES ('1312', '1476961916790');
INSERT INTO `revinfo` VALUES ('1313', '1476961931655');
INSERT INTO `revinfo` VALUES ('1314', '1476961980526');
INSERT INTO `revinfo` VALUES ('1315', '1476962165488');
INSERT INTO `revinfo` VALUES ('1316', '1476962475862');
INSERT INTO `revinfo` VALUES ('1317', '1476964760617');
INSERT INTO `revinfo` VALUES ('1318', '1476964906579');
INSERT INTO `revinfo` VALUES ('1319', '1476969276732');
INSERT INTO `revinfo` VALUES ('1320', '1476969332874');
INSERT INTO `revinfo` VALUES ('1321', '1476973438066');
INSERT INTO `revinfo` VALUES ('1322', '1476976697671');
INSERT INTO `revinfo` VALUES ('1323', '1477039286568');
INSERT INTO `revinfo` VALUES ('1324', '1477059072419');
INSERT INTO `revinfo` VALUES ('1325', '1477092095200');
INSERT INTO `revinfo` VALUES ('1326', '1477104775673');
INSERT INTO `revinfo` VALUES ('1327', '1477119260277');
INSERT INTO `revinfo` VALUES ('1328', '1477119304959');
INSERT INTO `revinfo` VALUES ('1329', '1477123158932');
INSERT INTO `revinfo` VALUES ('1330', '1477131032043');
INSERT INTO `revinfo` VALUES ('1331', '1477135339845');
INSERT INTO `revinfo` VALUES ('1332', '1477140034787');
INSERT INTO `revinfo` VALUES ('1333', '1477140054145');
INSERT INTO `revinfo` VALUES ('1334', '1477148809852');
INSERT INTO `revinfo` VALUES ('1335', '1477149215727');
INSERT INTO `revinfo` VALUES ('1336', '1477183733057');
INSERT INTO `revinfo` VALUES ('1337', '1477190069875');
INSERT INTO `revinfo` VALUES ('1338', '1477192118453');
INSERT INTO `revinfo` VALUES ('1339', '1477196401604');
INSERT INTO `revinfo` VALUES ('1340', '1477201154389');
INSERT INTO `revinfo` VALUES ('1341', '1477208682404');
INSERT INTO `revinfo` VALUES ('1342', '1477209688754');
INSERT INTO `revinfo` VALUES ('1343', '1477209712150');
INSERT INTO `revinfo` VALUES ('1344', '1477218396965');
INSERT INTO `revinfo` VALUES ('1345', '1477223987286');
INSERT INTO `revinfo` VALUES ('1346', '1477225612666');
INSERT INTO `revinfo` VALUES ('1347', '1477229480373');
INSERT INTO `revinfo` VALUES ('1348', '1477298187194');
INSERT INTO `revinfo` VALUES ('1349', '1477374931770');
INSERT INTO `revinfo` VALUES ('1350', '1477375500529');
INSERT INTO `revinfo` VALUES ('1351', '1477389842653');
INSERT INTO `revinfo` VALUES ('1352', '1477390018771');
INSERT INTO `revinfo` VALUES ('1353', '1477392540547');
INSERT INTO `revinfo` VALUES ('1354', '1477447299090');
INSERT INTO `revinfo` VALUES ('1355', '1477447354100');
INSERT INTO `revinfo` VALUES ('1356', '1477447436899');
INSERT INTO `revinfo` VALUES ('1357', '1477447484302');
INSERT INTO `revinfo` VALUES ('1358', '1477447552936');
INSERT INTO `revinfo` VALUES ('1359', '1477447683430');
INSERT INTO `revinfo` VALUES ('1360', '1477448069531');
INSERT INTO `revinfo` VALUES ('1361', '1477448098588');
INSERT INTO `revinfo` VALUES ('1362', '1477448318428');
INSERT INTO `revinfo` VALUES ('1363', '1477449553398');
INSERT INTO `revinfo` VALUES ('1364', '1477455308948');
INSERT INTO `revinfo` VALUES ('1365', '1477463627437');
INSERT INTO `revinfo` VALUES ('1366', '1477479827881');
INSERT INTO `revinfo` VALUES ('1367', '1477480179382');
INSERT INTO `revinfo` VALUES ('1368', '1477480250135');
INSERT INTO `revinfo` VALUES ('1369', '1477480319291');
INSERT INTO `revinfo` VALUES ('1370', '1477480358792');
INSERT INTO `revinfo` VALUES ('1371', '1477480454796');
INSERT INTO `revinfo` VALUES ('1372', '1477480530302');
INSERT INTO `revinfo` VALUES ('1373', '1477489316282');
INSERT INTO `revinfo` VALUES ('1374', '1477489438310');
INSERT INTO `revinfo` VALUES ('1375', '1477489474184');
INSERT INTO `revinfo` VALUES ('1376', '1477543684984');
INSERT INTO `revinfo` VALUES ('1377', '1477554213083');
INSERT INTO `revinfo` VALUES ('1378', '1477554249334');
INSERT INTO `revinfo` VALUES ('1379', '1477621487634');
INSERT INTO `revinfo` VALUES ('1380', '1477621600326');
INSERT INTO `revinfo` VALUES ('1381', '1477622117667');
INSERT INTO `revinfo` VALUES ('1382', '1477622433719');
INSERT INTO `revinfo` VALUES ('1383', '1477622666263');
INSERT INTO `revinfo` VALUES ('1384', '1477622716379');
INSERT INTO `revinfo` VALUES ('1385', '1477623594133');
INSERT INTO `revinfo` VALUES ('1386', '1477623746469');
INSERT INTO `revinfo` VALUES ('1387', '1477625279809');
INSERT INTO `revinfo` VALUES ('1388', '1477625636634');
INSERT INTO `revinfo` VALUES ('1389', '1477625723972');
INSERT INTO `revinfo` VALUES ('1390', '1477626301210');
INSERT INTO `revinfo` VALUES ('1391', '1477626373356');
INSERT INTO `revinfo` VALUES ('1392', '1477629825023');
INSERT INTO `revinfo` VALUES ('1393', '1477652587935');
INSERT INTO `revinfo` VALUES ('1394', '1477664419535');
INSERT INTO `revinfo` VALUES ('1395', '1477719418119');
INSERT INTO `revinfo` VALUES ('1396', '1477724435194');
INSERT INTO `revinfo` VALUES ('1397', '1477739914627');
INSERT INTO `revinfo` VALUES ('1398', '1477739949552');
INSERT INTO `revinfo` VALUES ('1399', '1477744411095');
INSERT INTO `revinfo` VALUES ('1400', '1477744530949');
INSERT INTO `revinfo` VALUES ('1401', '1477744993712');
INSERT INTO `revinfo` VALUES ('1402', '1477789240245');
INSERT INTO `revinfo` VALUES ('1403', '1477795025144');
INSERT INTO `revinfo` VALUES ('1404', '1477802349874');
INSERT INTO `revinfo` VALUES ('1405', '1477802350490');
INSERT INTO `revinfo` VALUES ('1406', '1477808538861');
INSERT INTO `revinfo` VALUES ('1407', '1477812226528');
INSERT INTO `revinfo` VALUES ('1408', '1477812347366');
INSERT INTO `revinfo` VALUES ('1409', '1477813505912');
INSERT INTO `revinfo` VALUES ('1410', '1477815623724');
INSERT INTO `revinfo` VALUES ('1411', '1477815716188');
INSERT INTO `revinfo` VALUES ('1412', '1477815744538');
INSERT INTO `revinfo` VALUES ('1413', '1477816915234');
INSERT INTO `revinfo` VALUES ('1414', '1477817073326');
INSERT INTO `revinfo` VALUES ('1415', '1477820222253');
INSERT INTO `revinfo` VALUES ('1416', '1477820350548');
INSERT INTO `revinfo` VALUES ('1417', '1477821253196');
INSERT INTO `revinfo` VALUES ('1418', '1477823790016');
INSERT INTO `revinfo` VALUES ('1419', '1477825603228');
INSERT INTO `revinfo` VALUES ('1420', '1477827324201');
INSERT INTO `revinfo` VALUES ('1421', '1477829384220');
INSERT INTO `revinfo` VALUES ('1422', '1477830853209');
INSERT INTO `revinfo` VALUES ('1423', '1477840579146');
INSERT INTO `revinfo` VALUES ('1424', '1477956997014');
INSERT INTO `revinfo` VALUES ('1425', '1477957109959');
INSERT INTO `revinfo` VALUES ('1426', '1477968661143');
INSERT INTO `revinfo` VALUES ('1427', '1477981363890');
INSERT INTO `revinfo` VALUES ('1428', '1478015333435');
INSERT INTO `revinfo` VALUES ('1429', '1478061369391');
INSERT INTO `revinfo` VALUES ('1430', '1478062278619');
INSERT INTO `revinfo` VALUES ('1431', '1478084397396');
INSERT INTO `revinfo` VALUES ('1432', '1478144192983');
INSERT INTO `revinfo` VALUES ('1433', '1478171074164');
INSERT INTO `revinfo` VALUES ('1434', '1478171099309');
INSERT INTO `revinfo` VALUES ('1435', '1478244252138');
INSERT INTO `revinfo` VALUES ('1436', '1478244302722');
INSERT INTO `revinfo` VALUES ('1437', '1478305535074');
INSERT INTO `revinfo` VALUES ('1438', '1478305631882');
INSERT INTO `revinfo` VALUES ('1439', '1478305678601');
INSERT INTO `revinfo` VALUES ('1440', '1478322623469');
INSERT INTO `revinfo` VALUES ('1441', '1478339518713');
INSERT INTO `revinfo` VALUES ('1442', '1478345604637');
INSERT INTO `revinfo` VALUES ('1443', '1478345671854');
INSERT INTO `revinfo` VALUES ('1444', '1478346794095');
INSERT INTO `revinfo` VALUES ('1445', '1478403368402');
INSERT INTO `revinfo` VALUES ('1446', '1478416639546');
INSERT INTO `revinfo` VALUES ('1447', '1478418104988');
INSERT INTO `revinfo` VALUES ('1448', '1478420604993');
INSERT INTO `revinfo` VALUES ('1449', '1478428296221');
INSERT INTO `revinfo` VALUES ('1450', '1478444732407');
INSERT INTO `revinfo` VALUES ('1451', '1478448465630');
INSERT INTO `revinfo` VALUES ('1452', '1478521897198');
INSERT INTO `revinfo` VALUES ('1453', '1478695469388');
INSERT INTO `revinfo` VALUES ('1454', '1478695503252');
INSERT INTO `revinfo` VALUES ('1455', '1478695533353');
INSERT INTO `revinfo` VALUES ('1456', '1478695564108');
INSERT INTO `revinfo` VALUES ('1457', '1478695579700');
INSERT INTO `revinfo` VALUES ('1458', '1478696241972');
INSERT INTO `revinfo` VALUES ('1459', '1478696266607');
INSERT INTO `revinfo` VALUES ('1460', '1478696453010');
INSERT INTO `revinfo` VALUES ('1461', '1478736878172');
INSERT INTO `revinfo` VALUES ('1462', '1478740940705');
INSERT INTO `revinfo` VALUES ('1463', '1478740987683');
INSERT INTO `revinfo` VALUES ('1464', '1478783908710');
INSERT INTO `revinfo` VALUES ('1465', '1478849719105');
INSERT INTO `revinfo` VALUES ('1466', '1478858310340');
INSERT INTO `revinfo` VALUES ('1467', '1478864389988');
INSERT INTO `revinfo` VALUES ('1468', '1478871263683');
INSERT INTO `revinfo` VALUES ('1469', '1478942275410');
INSERT INTO `revinfo` VALUES ('1470', '1478955195176');
INSERT INTO `revinfo` VALUES ('1471', '1479014670770');
INSERT INTO `revinfo` VALUES ('1472', '1479017656869');
INSERT INTO `revinfo` VALUES ('1473', '1479017721361');
INSERT INTO `revinfo` VALUES ('1474', '1479017729636');
INSERT INTO `revinfo` VALUES ('1475', '1479098694389');
INSERT INTO `revinfo` VALUES ('1476', '1479099152697');
INSERT INTO `revinfo` VALUES ('1477', '1479099195630');
INSERT INTO `revinfo` VALUES ('1478', '1479126773133');
INSERT INTO `revinfo` VALUES ('1479', '1479221883638');
INSERT INTO `revinfo` VALUES ('1480', '1479279176723');
INSERT INTO `revinfo` VALUES ('1481', '1479279202499');
INSERT INTO `revinfo` VALUES ('1482', '1479352874690');
INSERT INTO `revinfo` VALUES ('1483', '1479373825716');
INSERT INTO `revinfo` VALUES ('1484', '1479382431124');
INSERT INTO `revinfo` VALUES ('1485', '1479382455053');
INSERT INTO `revinfo` VALUES ('1486', '1479389456759');
INSERT INTO `revinfo` VALUES ('1487', '1479389519461');
INSERT INTO `revinfo` VALUES ('1488', '1479391317393');
INSERT INTO `revinfo` VALUES ('1489', '1479420584476');
INSERT INTO `revinfo` VALUES ('1490', '1479433802566');
INSERT INTO `revinfo` VALUES ('1491', '1479433917666');
INSERT INTO `revinfo` VALUES ('1492', '1479433942922');
INSERT INTO `revinfo` VALUES ('1493', '1479440727102');
INSERT INTO `revinfo` VALUES ('1494', '1479440794886');
INSERT INTO `revinfo` VALUES ('1495', '1479440832648');
INSERT INTO `revinfo` VALUES ('1496', '1479452797983');
INSERT INTO `revinfo` VALUES ('1497', '1479517635424');
INSERT INTO `revinfo` VALUES ('1498', '1479530764540');
INSERT INTO `revinfo` VALUES ('1499', '1479530844620');
INSERT INTO `revinfo` VALUES ('1500', '1479535872544');
INSERT INTO `revinfo` VALUES ('1501', '1479561213571');
INSERT INTO `revinfo` VALUES ('1502', '1479630344154');
INSERT INTO `revinfo` VALUES ('1503', '1479635088083');
INSERT INTO `revinfo` VALUES ('1504', '1479646746366');
INSERT INTO `revinfo` VALUES ('1505', '1479650180624');
INSERT INTO `revinfo` VALUES ('1506', '1479698152454');
INSERT INTO `revinfo` VALUES ('1507', '1479699072851');
INSERT INTO `revinfo` VALUES ('1508', '1479719474472');
INSERT INTO `revinfo` VALUES ('1509', '1479727279499');
INSERT INTO `revinfo` VALUES ('1510', '1479782243204');
INSERT INTO `revinfo` VALUES ('1511', '1479782325122');
INSERT INTO `revinfo` VALUES ('1512', '1479782369887');
INSERT INTO `revinfo` VALUES ('1513', '1479811792629');
INSERT INTO `revinfo` VALUES ('1514', '1479811823917');
INSERT INTO `revinfo` VALUES ('1515', '1479882600774');
INSERT INTO `revinfo` VALUES ('1516', '1479885506068');
INSERT INTO `revinfo` VALUES ('1517', '1479885565441');
INSERT INTO `revinfo` VALUES ('1518', '1479887889154');
INSERT INTO `revinfo` VALUES ('1519', '1479904957650');
INSERT INTO `revinfo` VALUES ('1520', '1479959513259');
INSERT INTO `revinfo` VALUES ('1521', '1480128094380');
INSERT INTO `revinfo` VALUES ('1522', '1480158452988');
INSERT INTO `revinfo` VALUES ('1523', '1480216859895');
INSERT INTO `revinfo` VALUES ('1524', '1480221758421');
INSERT INTO `revinfo` VALUES ('1525', '1480227483968');
INSERT INTO `revinfo` VALUES ('1526', '1480652609729');

-- ----------------------------
-- Event structure for 晚上1点执行前一天停车券记录
-- ----------------------------
DROP EVENT IF EXISTS `晚上1点执行前一天停车券记录`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` EVENT `晚上1点执行前一天停车券记录` ON SCHEDULE EVERY 1 DAY STARTS '2016-05-18 01:00:55' ON COMPLETION NOT PRESERVE ENABLE DO insert into by_batch_parking_coupon_info_per_day
(
   use_number,exchange_number,created_time
)
values
(
   (SELECT count(*) FROM by_parking_coupon_exchange_history WHERE date(created_time) = date_sub(curdate(), INTERVAL 1 DAY)),
   (SELECT count(*) FROM by_parking_coupon_use_history WHERE date(created_time) = date_sub(curdate(), INTERVAL 1 DAY)),
   date_sub(curdate(), INTERVAL 1 DAY)
)
;;
DELIMITER ;

-- ----------------------------
-- Event structure for 晚上1点执行前一天新增会员记录
-- ----------------------------
DROP EVENT IF EXISTS `晚上1点执行前一天新增会员记录`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` EVENT `晚上1点执行前一天新增会员记录` ON SCHEDULE EVERY 1 DAY STARTS '2016-05-18 01:00:55' ON COMPLETION NOT PRESERVE ENABLE DO insert into by_batch_member_inc
(
   number,created_time
)
values
(
   (select count(1) from by_member where date(created_time) = date_sub(curdate(), INTERVAL 1 DAY)),
   date_sub(curdate(), INTERVAL 1 DAY)
)
;;
DELIMITER ;

-- ----------------------------
-- Event structure for 晚上1点执行前一天礼品券记录
-- ----------------------------
DROP EVENT IF EXISTS `晚上1点执行前一天礼品券记录`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` EVENT `晚上1点执行前一天礼品券记录` ON SCHEDULE EVERY 1 DAY STARTS '2016-05-18 01:00:32' ON COMPLETION NOT PRESERVE ENABLE DO insert into by_batch_gift_coupon_info_per_day
(
   use_number,exchange_number,created_time
)
values
(
   (SELECT count(*) FROM by_gift_coupon_member WHERE date(exchanged_time) = date_sub(curdate(), INTERVAL 1 DAY)),
   (SELECT count(*) FROM by_gift_coupon_member WHERE date(used_time) = date_sub(curdate(), INTERVAL 1 DAY)),
   date_sub(curdate(), INTERVAL 1 DAY)
)
;;
DELIMITER ;

-- ----------------------------
-- Event structure for 晚上一点执行前一天店铺券记录
-- ----------------------------
DROP EVENT IF EXISTS `晚上一点执行前一天店铺券记录`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` EVENT `晚上一点执行前一天店铺券记录` ON SCHEDULE EVERY 1 DAY STARTS '2016-05-18 01:00:17' ON COMPLETION NOT PRESERVE ENABLE DO insert into by_batch_shop_coupon_info_per_day
(
   use_number,exchange_number,created_time
)
values
(
   (SELECT count(*) FROM by_shop_coupon_member WHERE date(exchanged_time) = date_sub(curdate(), INTERVAL 1 DAY)),
   (SELECT count(*) FROM by_shop_coupon_member WHERE date(used_time) = date_sub(curdate(), INTERVAL 1 DAY)),
   date_sub(curdate(), INTERVAL 1 DAY)
)
;;
DELIMITER ;
