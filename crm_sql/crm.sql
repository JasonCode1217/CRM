/*
 Navicat Premium Data Transfer

 Source Server         : jason
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : crm

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 30/08/2021 22:17:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_cus_dev_plan
-- ----------------------------
DROP TABLE IF EXISTS `t_cus_dev_plan`;
CREATE TABLE `t_cus_dev_plan`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `sale_chance_id` int(0) UNSIGNED NULL DEFAULT NULL COMMENT '营销机会id',
  `plan_item` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '计划内容',
  `plan_date` datetime(0) NULL DEFAULT NULL COMMENT '计划日期',
  `exe_affect` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行效果',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_valid` int(0) NULL DEFAULT NULL COMMENT '有效状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sale_chance_id`(`sale_chance_id`) USING BTREE,
  CONSTRAINT `t_cus_dev_plan_ibfk_1` FOREIGN KEY (`sale_chance_id`) REFERENCES `t_sale_chance` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 209 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_cus_dev_plan
-- ----------------------------
INSERT INTO `t_cus_dev_plan` VALUES (201, 4, '建万达小镇', '2021-09-10 09:46:24', '未开工', '2021-08-13 09:46:48', '2021-08-13 09:46:50', 1);
INSERT INTO `t_cus_dev_plan` VALUES (202, 4, '建万达乐园', '2021-12-22 09:47:13', '筹备中', '2021-08-13 09:47:23', '2021-08-13 09:47:26', 1);
INSERT INTO `t_cus_dev_plan` VALUES (203, 5, '举行校园招聘', '2021-08-01 09:48:08', '正在进行', '2021-08-13 09:48:27', '2021-08-13 09:48:30', 1);
INSERT INTO `t_cus_dev_plan` VALUES (204, 8, '新品设计', '2021-08-03 00:00:00', '设计交流', '2021-08-13 09:49:07', '2021-08-13 13:38:06', 1);
INSERT INTO `t_cus_dev_plan` VALUES (205, 1, '生产摩托', '2021-08-14 00:00:00', '生产力帆摩托', '2021-08-13 11:18:48', '2021-08-13 14:48:30', 1);
INSERT INTO `t_cus_dev_plan` VALUES (206, 13, '京东下乡', '2021-09-08 00:00:00', '实现农村京东站点建设', '2021-08-13 13:01:03', '2021-08-13 13:01:03', 1);
INSERT INTO `t_cus_dev_plan` VALUES (207, 8, '京东618', '2022-06-18 00:00:00', '囤货中', '2021-08-13 13:03:42', '2021-08-13 13:37:54', 0);
INSERT INTO `t_cus_dev_plan` VALUES (208, 10, '修水库', '2021-09-20 00:00:00', '建成八河水库', '2021-08-13 13:14:26', '2021-08-13 13:14:26', 1);
INSERT INTO `t_cus_dev_plan` VALUES (209, 10, '修水塔', '2021-11-20 00:00:00', '建成水塔', '2021-08-13 13:14:52', '2021-08-13 13:14:52', 1);

-- ----------------------------
-- Table structure for t_customer
-- ----------------------------
DROP TABLE IF EXISTS `t_customer`;
CREATE TABLE `t_customer`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `khno` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `area` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cus_manager` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `level` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `myd` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `xyd` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `post_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fax` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `web_site` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `yyzzzch` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fr` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zczj` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nyye` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `khyh` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `khzh` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dsdjh` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gsdjh` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(0) NULL DEFAULT NULL,
  `is_valid` int(0) NULL DEFAULT 1,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer
-- ----------------------------
INSERT INTO `t_customer` VALUES (1, 'KH21321321', '北京大牛科技', '北京', 'test', '战略合作伙伴', '☆☆☆', '☆☆☆', '北京海淀区双榆树东里15号', '100027', '010-62263393', '010-62263393', 'www.daniu.com', '420103000057404', '赵飞翔', '1000', '5000', '中国银行', '6225231243641', '4422214321321', '4104322332', 1, 1, '2017-01-16 11:28:43', '2016-08-24 18:42:19');
INSERT INTO `t_customer` VALUES (2, 'KH20150526073022', '风驰科技', '北京', 'test', '大客户', '☆☆☆☆', '☆☆☆☆', '321', '21', '321', '321', '321', '321', '码云', '', '21', '321', '321', '321', '3213', 1, 1, '2017-01-16 12:15:19', '2016-11-28 11:46:24');
INSERT INTO `t_customer` VALUES (20, 'KH201709181013450', '腾讯', '测试', 'test', '', '☆☆☆☆☆', '☆☆☆☆', '', '636400', '13327792156', '', '', NULL, '赵飞翔', '', '', '', '', '', '', 1, 1, '2017-01-16 10:13:57', '2021-08-18 17:34:08');
INSERT INTO `t_customer` VALUES (21, 'KH201709181112739', '阿里巴巴', '北京', 'test01', '战略合作伙伴', '☆☆☆☆☆', '☆☆☆☆☆', '浙江杭州', '324324', '23424324324', '2343', 'www.alibaba.com', '232432', '码云', '100', '100000', '杭州', '23432432', '4324324', '234324234', 1, 1, '2017-01-16 11:12:16', '2017-09-18 11:25:25');
INSERT INTO `t_customer` VALUES (22, 'KH20171021105508617', '中国工商银行', '上海', 'test', '战略合作伙伴', '☆☆☆☆☆', '☆☆☆☆☆', '浦东', '201600', '18920156732', '12312321', 'www.icbc.com', '12323', '吴三强', '1000000', '100000', '工商', '212321', '', '', 1, 1, '2017-01-16 10:55:09', '2020-11-14 02:28:37');
INSERT INTO `t_customer` VALUES (23, 'KH20180115104723756', '百度', '北京', 'test', '战略合作伙伴', '☆☆☆☆', '☆☆☆☆☆', '北京西二旗', '100000', '2321321', '213123', '123213', '2321321', '李彦宏', '10000', '100000', '工商', '121321313', '', '', 1, 1, '2018-01-16 10:47:23', '2018-01-15 10:50:00');
INSERT INTO `t_customer` VALUES (24, 'KH20180504112003301', '小米科技', '上海', 'test', '重点开发客户', '☆☆☆☆☆', '☆☆☆☆☆', '北京市海淀区清河中街68号华润五彩城购物中心二期13层', '1000000', '010-12345678', '123123131', 'www.xiaomi.com', '110108012660422', '雷军', '185000', '5000000', '中国银行', '99999999999', '91110108551385082Q', '91110108551385082Q', 1, 1, '2018-05-04 11:16:21', '2018-05-04 11:22:24');
INSERT INTO `t_customer` VALUES (32, 'KH1605352800204', '网易test', '上海', 'admin', '大客户', NULL, '', '', '', '13787654345', '', '', NULL, '张三test', '', '', '', '', '', '', 1, 1, '2020-11-14 19:20:00', '2020-11-14 20:20:59');
INSERT INTO `t_customer` VALUES (33, 'KH1605352897591', '网易科技', NULL, NULL, '战略合作伙伴', NULL, NULL, NULL, NULL, '1589876543', NULL, NULL, NULL, '张三', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, '2020-11-14 19:21:38', '2020-11-14 19:21:38');
INSERT INTO `t_customer` VALUES (34, 'KH1605352974388', '网易科技有限公司', NULL, NULL, '战略合作伙伴', NULL, NULL, NULL, NULL, '15898765437', NULL, NULL, NULL, '张三', NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, '2020-11-14 19:22:54', '2020-11-14 19:22:54');
INSERT INTO `t_customer` VALUES (35, 'KH1605353772927', '腾讯科技', '', '', '战略合作伙伴', NULL, '', '', '', '13787654345', '', '', NULL, '马化腾', '', '', '', '', '', '', 1, 1, '2020-11-14 19:36:13', '2020-11-14 20:21:04');
INSERT INTO `t_customer` VALUES (36, 'KH1605353908782', '测试测试', '', '', '战略合作伙伴', NULL, '', '', '', '15898765437', '', '', NULL, 'zhangsan', '', '', '', '', '', '', 1, 1, '2020-11-14 19:38:29', '2020-11-14 20:21:08');
INSERT INTO `t_customer` VALUES (37, 'KH1629277794413', '航海王', '红土大陆', '罗杰', '战略合作伙伴', NULL, NULL, '双子峽', NULL, '13678276106', NULL, NULL, NULL, '路飞', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, '2021-08-18 17:09:54', '2021-08-18 17:34:17');
INSERT INTO `t_customer` VALUES (38, 'KH1629278736286', '和之国', '九里', '凯多', '重点开发客户', NULL, '', '鬼岛', '', '18888886666', '', '', NULL, '凯多', '', '', '', '', '', '', 0, 1, '2021-08-18 17:25:36', '2021-08-18 17:25:36');

-- ----------------------------
-- Table structure for t_customer_contact
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_contact`;
CREATE TABLE `t_customer_contact`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `cus_id` int(0) NULL DEFAULT NULL,
  `contact_time` datetime(0) NULL DEFAULT NULL,
  `address` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `overview` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  `is_valid` int(0) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer_contact
-- ----------------------------
INSERT INTO `t_customer_contact` VALUES (1, 1, '2015-05-14 05:00:00', '1', '2', NULL, NULL, 1);
INSERT INTO `t_customer_contact` VALUES (2, 1, '2015-05-06 00:00:00', '12', '22', NULL, NULL, 1);
INSERT INTO `t_customer_contact` VALUES (3, 1, '2015-08-22 00:00:00', '珠江路2', '吃饭2', NULL, NULL, 1);
INSERT INTO `t_customer_contact` VALUES (4, 1, '2016-09-01 00:00:00', '112', '233', '2016-09-01 09:53:39', '2016-09-01 09:53:39', 0);
INSERT INTO `t_customer_contact` VALUES (5, 1, '2016-11-22 00:00:00', '师德师风', '阿德的', '2016-11-25 09:38:37', '2016-11-25 09:38:37', 1);

-- ----------------------------
-- Table structure for t_customer_linkman
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_linkman`;
CREATE TABLE `t_customer_linkman`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `cus_id` int(0) NULL DEFAULT NULL,
  `link_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zhiwei` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `office_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_valid` int(0) NULL DEFAULT 1,
  `ceate_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_customer_loss
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_loss`;
CREATE TABLE `t_customer_loss`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `cus_no` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cus_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cus_manager` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `last_order_time` date NULL DEFAULT NULL,
  `confirm_loss_time` date NULL DEFAULT NULL,
  `state` int(0) NULL DEFAULT NULL,
  `loss_reason` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_valid` int(0) NULL DEFAULT 1,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 412 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer_loss
-- ----------------------------
INSERT INTO `t_customer_loss` VALUES (401, 'KH21321321', '北京大牛科技', 'test', NULL, NULL, 1, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (402, 'KH20150526073022', '风驰科技', 'test', NULL, NULL, 1, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (403, 'KH201709181013450', '腾讯', 'test', '2020-09-03', NULL, 0, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (404, 'KH201709181112739', '阿里巴巴', 'test01', NULL, NULL, 0, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (405, 'KH20171021105508617', '中国工商银行', 'test', NULL, NULL, 1, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (406, 'KH20180115104723756', '百度', 'test', NULL, NULL, 0, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (407, 'KH20180504112003301', '小米科技', 'test', '2018-10-01', NULL, 0, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (408, 'KH1605352800204', '网易test', 'admin', NULL, NULL, 0, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (409, 'KH1605352897591', '网易科技', NULL, NULL, '2021-08-19', 1, '我摊牌了', 1, '2021-08-19 12:04:58', '2021-08-19 20:29:58');
INSERT INTO `t_customer_loss` VALUES (410, 'KH1605352974388', '网易科技有限公司', NULL, NULL, NULL, 0, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (411, 'KH1605353772927', '腾讯科技', '', NULL, NULL, 0, NULL, 1, '2021-08-19 12:04:58', '2021-08-19 12:04:58');
INSERT INTO `t_customer_loss` VALUES (412, 'KH1605353908782', '测试测试', '', NULL, '2021-08-19', 1, '没有原因', 1, '2021-08-19 12:04:58', '2021-08-19 16:35:23');

-- ----------------------------
-- Table structure for t_customer_order
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_order`;
CREATE TABLE `t_customer_order`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `cus_id` int(0) NULL DEFAULT NULL,
  `order_no` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `order_date` datetime(0) NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(0) NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  `is_valid` int(0) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer_order
-- ----------------------------
INSERT INTO `t_customer_order` VALUES (5, 20, '201910021001', '2020-09-03 14:56:10', '上海松江区', 1, '2016-01-29 14:56:15', '2016-11-29 14:56:17', 1);
INSERT INTO `t_customer_order` VALUES (6, 20, '202001022534', '2020-06-16 14:56:26', '杭州市滨江大道', 1, '2016-02-29 14:56:30', '2016-11-29 14:56:32', 1);
INSERT INTO `t_customer_order` VALUES (7, 24, '201911021082', '2018-10-01 17:27:31', '上海浦东', 1, '2019-09-01 17:27:13', '2017-01-01 17:27:21', 1);
INSERT INTO `t_customer_order` VALUES (8, 25, '201909021001', '2019-11-11 10:09:32', '背景海淀', 1, '2019-11-09 10:09:36', '2019-11-09 10:09:39', 1);
INSERT INTO `t_customer_order` VALUES (9, 37, '202108201001', '2021-08-20 17:12:33', '橘子镇', 1, '2021-08-20 17:12:45', '2021-08-20 17:12:48', 1);
INSERT INTO `t_customer_order` VALUES (10, 38, '202108201002', '2021-08-20 17:13:00', '糖汁村', 1, '2021-08-20 17:13:09', '2021-08-20 17:13:12', 1);

-- ----------------------------
-- Table structure for t_customer_reprieve
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_reprieve`;
CREATE TABLE `t_customer_reprieve`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `loss_id` int(0) NULL DEFAULT NULL,
  `measure` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_valid` int(0) NULL DEFAULT 1,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer_reprieve
-- ----------------------------
INSERT INTO `t_customer_reprieve` VALUES (60, 403, '和老马一起游山玩水', 1, '2021-08-19 14:15:43', '2021-08-19 14:15:45');
INSERT INTO `t_customer_reprieve` VALUES (61, 403, '和老马一起共进晚餐', 1, '2021-08-19 14:15:58', '2021-08-19 14:16:01');
INSERT INTO `t_customer_reprieve` VALUES (70, 403, '和老马打cf', 0, '2021-08-19 16:26:49', '2021-08-19 16:29:10');
INSERT INTO `t_customer_reprieve` VALUES (71, 403, '和老马打王者', 1, '2021-08-19 20:29:33', '2021-08-19 20:29:33');

-- ----------------------------
-- Table structure for t_customer_serve
-- ----------------------------
DROP TABLE IF EXISTS `t_customer_serve`;
CREATE TABLE `t_customer_serve`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `serve_type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `overview` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `customer` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `service_request` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_people` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `assigner` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `assign_time` datetime(0) NULL DEFAULT NULL,
  `service_proce` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `service_proce_people` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `service_proce_time` datetime(0) NULL DEFAULT NULL,
  `service_proce_result` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `myd` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_valid` int(0) NULL DEFAULT 1,
  `update_date` datetime(0) NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_customer_serve
-- ----------------------------
INSERT INTO `t_customer_serve` VALUES (89, '6', '', '腾讯', 'fw_005', '校园招聘', '张三', '1', '2021-08-20 00:00:00', '已处理', '张三', '2021-08-20 00:00:00', '已完成', '☆☆☆☆', 1, '2021-08-20 16:45:10', '2021-08-20 15:42:13');
INSERT INTO `t_customer_serve` VALUES (90, '7', '我不想还花呗', '阿里巴巴', 'fw_005', '花呗利息太高', '张三', '3', '2021-08-20 00:00:00', '不还就不还', '皮特', '2021-08-20 00:00:00', '已处理', '☆☆☆☆☆', 1, '2021-08-20 16:57:52', '2021-08-20 15:50:31');
INSERT INTO `t_customer_serve` VALUES (92, '6', '罗杰是否留下了大宝藏', '航海王', 'fw_003', 'One Piece真的存在吗？', '皮特', '3', '2021-08-20 00:00:00', '真的存在！', '皮特', '2021-08-20 16:57:18', NULL, NULL, 1, '2021-08-20 16:57:18', '2021-08-20 16:52:10');
INSERT INTO `t_customer_serve` VALUES (93, '7', '打倒凯多', '和之国', 'fw_002', '凯多欺压和之国居民', '皮特', '1', '2021-08-20 16:56:43', NULL, NULL, NULL, NULL, NULL, 1, '2021-08-20 16:56:43', '2021-08-20 16:52:45');

-- ----------------------------
-- Table structure for t_datadic
-- ----------------------------
DROP TABLE IF EXISTS `t_datadic`;
CREATE TABLE `t_datadic`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `data_dic_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `data_dic_value` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_valid` tinyint(0) NULL DEFAULT 1,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_t_datadic`(`data_dic_value`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_datadic
-- ----------------------------
INSERT INTO `t_datadic` VALUES (1, '客户等级', '普通客户', 1, '2020-02-20 10:04:27', '2020-02-20 10:04:48');
INSERT INTO `t_datadic` VALUES (2, '客户等级', '重点开发客户', 1, '2020-02-20 10:04:30', '2020-02-20 10:04:51');
INSERT INTO `t_datadic` VALUES (3, '客户等级', '大客户', 1, '2020-02-20 10:04:33', '2020-02-20 10:04:53');
INSERT INTO `t_datadic` VALUES (4, '客户等级', '合作伙伴', 1, '2020-02-20 10:04:35', '2020-02-20 10:04:56');
INSERT INTO `t_datadic` VALUES (5, '客户等级', '战略合作伙伴', 1, '2020-02-20 10:04:37', '2020-02-20 10:04:59');
INSERT INTO `t_datadic` VALUES (6, '服务类型', '咨询', 1, '2020-02-20 10:04:40', '2020-02-20 10:05:01');
INSERT INTO `t_datadic` VALUES (7, '服务类型', '建议', 1, '2020-02-20 10:04:43', '2020-02-20 10:05:04');
INSERT INTO `t_datadic` VALUES (8, '服务类型', '投诉', 1, '2020-02-20 10:04:45', '2016-08-24 15:48:46');

-- ----------------------------
-- Table structure for t_module
-- ----------------------------
DROP TABLE IF EXISTS `t_module`;
CREATE TABLE `t_module`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '资源id',
  `module_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源名',
  `module_style` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源样式',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '资源地址',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '上级资源id',
  `parent_opt_value` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级资源权限码',
  `grade` int(0) NULL DEFAULT NULL COMMENT '层级',
  `opt_value` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限码',
  `orders` int(0) NULL DEFAULT NULL COMMENT '排序号',
  `is_valid` int(0) NULL DEFAULT NULL COMMENT '有效状态',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 167 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_module
-- ----------------------------
INSERT INTO `t_module` VALUES (1, '营销管理', '', '#', -1, NULL, 0, '10', 1, 1, '2017-09-28 00:00:00', '2020-02-17 15:46:59');
INSERT INTO `t_module` VALUES (2, '营销机会管理', '', 'saleChance/index', 1, NULL, 1, '1010', 1, 1, '2017-09-28 00:00:00', '2020-02-17 15:47:26');
INSERT INTO `t_module` VALUES (3, '营销机会管理查询', '', '#', 2, NULL, 2, '101001', 2, 1, '2017-09-28 00:00:00', '2020-02-17 15:47:51');
INSERT INTO `t_module` VALUES (4, '营销机会管理添加', '', '#', 2, NULL, 2, '101002', 2, 1, '2017-09-28 00:00:00', '2017-09-28 00:00:00');
INSERT INTO `t_module` VALUES (5, '营销机会管理删除', '', '#', 2, NULL, 2, '101003', 3, 1, '2017-09-28 00:00:00', '2017-09-28 00:00:00');
INSERT INTO `t_module` VALUES (6, '客户开发计划', '', 'cus_dev_plan/index', 1, NULL, 1, '1020', 2, 1, '2017-09-28 00:00:00', '2017-09-28 00:00:00');
INSERT INTO `t_module` VALUES (7, '查看详情', '', '#', 6, NULL, 2, '102001', 1, 1, '2017-09-28 00:00:00', '2017-09-28 00:00:00');
INSERT INTO `t_module` VALUES (8, '客户管理', '', 'customer/index', -1, NULL, 0, '20', 3, 1, '2017-07-01 00:00:00', '2017-07-01 00:00:00');
INSERT INTO `t_module` VALUES (9, '客户信息管理', '', 'customer/index', 8, NULL, 1, '2010', 1, 1, '2017-09-06 00:00:00', '2017-09-06 00:00:00');
INSERT INTO `t_module` VALUES (10, '创建', '', '#', 9, NULL, 2, '201001', 1, 1, '2017-07-01 00:00:00', '2017-07-01 00:00:00');
INSERT INTO `t_module` VALUES (11, '修改', '', '#', 9, NULL, 2, '201002', 2, 1, '2017-07-01 00:00:00', '2017-07-01 00:00:00');
INSERT INTO `t_module` VALUES (12, '客户流失管理', '', 'customer_loss/index', 8, NULL, 1, '2020', 2, 1, '2017-08-17 00:00:00', '2017-08-17 00:00:00');
INSERT INTO `t_module` VALUES (13, '暂缓流失', '', 'openCustomerReprieve', 12, NULL, 2, '202001', 1, 1, '2017-09-23 00:00:00', '2017-09-23 00:00:00');
INSERT INTO `t_module` VALUES (14, '统计报表', '', '#', -1, NULL, 0, '40', 4, 1, '2017-08-15 00:00:00', '2017-08-15 00:00:00');
INSERT INTO `t_module` VALUES (15, '客户贡献分析', '', 'report/1', 14, NULL, 1, '4010', 1, 1, '2017-08-15 00:00:00', '2017-08-15 00:00:00');
INSERT INTO `t_module` VALUES (16, '服务管理', '', '#', -1, NULL, 0, '30', 3, 1, '2017-08-18 00:00:00', '2017-08-18 00:00:00');
INSERT INTO `t_module` VALUES (17, '基础数据管理', '', '#', -1, NULL, 0, '50', 5, 1, '2017-08-18 00:00:00', '2017-08-18 00:00:00');
INSERT INTO `t_module` VALUES (18, '系统管理', '', '#', -1, NULL, 0, '60', 6, 1, '2017-08-18 00:00:00', '2017-08-18 00:00:00');
INSERT INTO `t_module` VALUES (19, '删除', '', '#', 9, NULL, 2, '201003', 3, 1, '2017-08-18 00:00:00', '2017-08-18 00:00:00');
INSERT INTO `t_module` VALUES (26, '用户管理', '', 'user/index', 18, NULL, 1, '6010', NULL, 1, '2017-10-24 16:54:12', '2017-10-24 16:54:12');
INSERT INTO `t_module` VALUES (27, '角色管理', '', 'role/index', 18, NULL, 1, '6020', NULL, 1, '2018-01-13 11:29:17', '2018-01-13 11:29:19');
INSERT INTO `t_module` VALUES (28, '资源管理', '', 'module/index/1', 18, NULL, 1, '6030', NULL, 1, '2018-01-13 11:29:40', '2018-01-13 11:29:42');
INSERT INTO `t_module` VALUES (34, '服务创建', '', NULL, 16, NULL, 1, '3010', NULL, 1, '2018-01-16 09:21:59', '2018-01-16 09:22:02');
INSERT INTO `t_module` VALUES (35, '服务分配', '', NULL, 16, NULL, 1, '3020', NULL, 1, '2018-01-16 09:22:26', '2018-01-16 09:22:28');
INSERT INTO `t_module` VALUES (36, '服务处理', '', NULL, 16, NULL, 1, '3030', NULL, 1, '2018-01-16 09:22:47', '2018-01-16 09:22:50');
INSERT INTO `t_module` VALUES (37, '服务反馈', '', NULL, 16, NULL, 1, '3040', NULL, 1, '2018-01-16 09:23:11', '2018-01-16 09:23:13');
INSERT INTO `t_module` VALUES (38, '服务归档', '', NULL, 16, NULL, 1, '3050', NULL, 1, '2018-01-16 09:23:37', '2018-01-16 09:23:39');
INSERT INTO `t_module` VALUES (39, '客户构成分析', '', NULL, 14, NULL, NULL, '4020', NULL, 1, '2018-01-16 14:57:24', '2018-01-16 14:57:27');
INSERT INTO `t_module` VALUES (40, '客户服务分析', '', NULL, 14, NULL, NULL, '4030', NULL, 1, '2018-01-16 16:14:48', '2018-01-16 16:14:50');
INSERT INTO `t_module` VALUES (44, '营销机会管理修改', '', NULL, 2, NULL, 2, '101004', NULL, 1, '2019-09-25 15:22:12', '2020-01-15 10:43:09');
INSERT INTO `t_module` VALUES (102, '数据字典管理', '', 'sale_chance/xxx', 17, NULL, 1, '5010', NULL, 1, '2019-09-26 11:07:00', '2019-09-26 11:07:00');
INSERT INTO `t_module` VALUES (103, '产品信息查询', '', '#', 17, NULL, 2, '5020', NULL, 1, '2019-09-26 11:13:14', '2019-09-26 11:13:14');
INSERT INTO `t_module` VALUES (109, '客户类别分析', '', 'report/r01', 14, NULL, 1, '4060', NULL, 1, '2019-11-09 16:31:58', '2019-11-09 16:31:58');
INSERT INTO `t_module` VALUES (126, '流失管理添加', '', NULL, 12, NULL, 2, '123213', 12323, 1, '2020-02-17 15:25:53', '2020-02-17 15:25:53');
INSERT INTO `t_module` VALUES (130, '用户添加', '', NULL, 26, NULL, 2, '601001', NULL, 1, '2020-02-17 15:55:45', '2020-02-17 15:55:45');
INSERT INTO `t_module` VALUES (131, '用户查询', '', NULL, 26, NULL, 2, '601002', NULL, 1, '2020-02-17 15:56:04', '2020-02-17 15:56:04');
INSERT INTO `t_module` VALUES (132, '用户修改', '', NULL, 26, NULL, 2, '601003', NULL, 1, '2020-02-17 15:56:20', '2020-02-17 15:56:20');
INSERT INTO `t_module` VALUES (133, '用户删除', '', NULL, 26, NULL, 2, '601004', NULL, 1, '2020-02-17 15:56:36', '2020-02-17 15:56:36');
INSERT INTO `t_module` VALUES (134, '角色添加', '', NULL, 27, NULL, 2, '602001', NULL, 1, '2020-02-17 15:56:53', '2020-02-17 15:56:53');
INSERT INTO `t_module` VALUES (135, '角色查询', '', NULL, 27, NULL, 2, '602002', NULL, 1, '2020-02-17 15:57:08', '2020-02-17 15:57:08');
INSERT INTO `t_module` VALUES (136, '角色修改', '', NULL, 27, NULL, 2, '602003', NULL, 1, '2020-02-17 15:57:23', '2020-02-17 15:57:23');
INSERT INTO `t_module` VALUES (137, '角色删除', '', NULL, 27, NULL, 2, '602004', NULL, 1, '2020-02-17 15:57:37', '2020-02-17 15:57:37');
INSERT INTO `t_module` VALUES (138, '资源添加', '', NULL, 28, NULL, 2, '603001', NULL, 1, '2020-02-17 15:57:57', '2020-02-17 15:57:57');
INSERT INTO `t_module` VALUES (139, '资源查询', '', NULL, 28, NULL, 2, '603002', NULL, 1, '2020-02-17 15:58:18', '2020-02-17 15:58:18');
INSERT INTO `t_module` VALUES (140, '资源修改', '', NULL, 28, NULL, 2, '603003', NULL, 1, '2020-02-17 15:58:31', '2020-02-17 15:58:31');
INSERT INTO `t_module` VALUES (141, '资源删除', '', NULL, 28, NULL, 2, '603004', NULL, 1, '2020-02-17 15:58:45', '2020-02-17 15:58:45');
INSERT INTO `t_module` VALUES (142, '字典管理', '', 'data_dic/index', 18, NULL, 1, '6040', NULL, 1, '2020-02-20 21:30:11', '2020-02-20 21:30:53');
INSERT INTO `t_module` VALUES (143, '字典添加', '', NULL, 142, NULL, 2, '604001', NULL, 1, '2020-02-20 21:31:12', '2020-02-20 21:31:12');
INSERT INTO `t_module` VALUES (144, '字典查询', '', NULL, 142, NULL, 2, '604002', NULL, 1, '2020-02-20 21:31:31', '2020-02-20 21:31:31');
INSERT INTO `t_module` VALUES (145, '字典修改', '', NULL, 142, NULL, 2, '604003', NULL, 1, '2020-02-20 21:31:47', '2020-02-20 21:31:47');
INSERT INTO `t_module` VALUES (146, '字典删除', '', NULL, 142, NULL, 2, '604004', NULL, 1, '2020-02-20 21:32:03', '2020-02-20 21:32:03');
INSERT INTO `t_module` VALUES (147, '服务创建查询', '', NULL, 34, NULL, 2, '301001', NULL, 1, '2020-02-20 21:32:39', '2020-02-20 21:34:40');
INSERT INTO `t_module` VALUES (149, '服务分配查询', '', NULL, 35, NULL, 2, '302001', NULL, 1, '2020-02-20 21:34:31', '2020-02-20 21:34:31');
INSERT INTO `t_module` VALUES (150, '服务处理查询', '', NULL, 36, NULL, 2, '303001', NULL, 1, '2020-02-20 21:34:56', '2020-02-20 21:34:56');
INSERT INTO `t_module` VALUES (151, '服务处理', '', NULL, 36, NULL, 2, '303002', NULL, 1, '2020-02-20 21:35:20', '2020-02-20 21:35:20');
INSERT INTO `t_module` VALUES (152, '服务反馈查询', '', NULL, 37, NULL, 2, '304001', NULL, 1, '2020-02-20 21:35:43', '2020-02-20 21:35:43');
INSERT INTO `t_module` VALUES (153, '服务反馈', '', NULL, 37, NULL, 2, '304002', NULL, 1, '2020-02-20 21:35:57', '2020-02-20 21:35:57');
INSERT INTO `t_module` VALUES (154, '测试管理', NULL, 'test/index', 1, NULL, 1, '1030', NULL, 1, '2020-11-13 02:57:06', '2020-11-13 02:57:06');
INSERT INTO `t_module` VALUES (155, '财务管理', NULL, NULL, -1, NULL, 0, '70', NULL, 1, '2020-11-13 02:58:52', '2020-11-13 02:58:52');
INSERT INTO `t_module` VALUES (156, '财务信息管理', NULL, 'aa/index', 155, NULL, 1, '7010', NULL, 1, '2020-11-13 03:00:11', '2020-11-13 03:00:11');
INSERT INTO `t_module` VALUES (157, '财务添加操作', NULL, NULL, 156, NULL, 2, '701001', NULL, 1, '2020-11-13 03:00:51', '2020-11-13 03:00:51');
INSERT INTO `t_module` VALUES (158, '测试管理1', '', NULL, -1, NULL, 0, '100', NULL, 1, '2020-11-13 03:32:21', '2020-11-13 04:26:26');
INSERT INTO `t_module` VALUES (159, '测试管理2', '', NULL, -1, NULL, 0, '90', NULL, 0, '2020-11-13 03:33:38', '2020-11-13 04:53:37');
INSERT INTO `t_module` VALUES (160, '测试子菜单一2', '', 'test001/index', 158, NULL, 1, '10010', NULL, 1, '2020-11-13 03:34:14', '2020-11-13 04:26:49');
INSERT INTO `t_module` VALUES (161, '测试子菜单一001', '', NULL, 160, NULL, 2, '1001001', NULL, 1, '2020-11-13 03:34:34', '2020-11-13 04:27:18');
INSERT INTO `t_module` VALUES (162, '测试子菜单一03', '', NULL, 160, NULL, 2, '801003', NULL, 1, '2020-11-13 03:34:47', '2020-11-13 04:05:44');
INSERT INTO `t_module` VALUES (163, '王者荣耀', NULL, NULL, NULL, NULL, 0, '80', NULL, 1, '2021-08-17 19:22:46', '2021-08-17 19:22:46');
INSERT INTO `t_module` VALUES (164, '和平精英', NULL, NULL, -1, NULL, 0, '90', NULL, 0, '2021-08-17 19:25:05', '2021-08-18 11:17:57');
INSERT INTO `t_module` VALUES (165, '今日说法', '', NULL, -1, NULL, 0, '120', NULL, 0, '2021-08-17 21:13:52', '2021-08-18 11:16:25');
INSERT INTO `t_module` VALUES (166, '测试子菜单—3', '', '#111', 158, NULL, 1, '8888', NULL, 1, '2021-08-18 00:31:14', '2021-08-18 00:32:24');
INSERT INTO `t_module` VALUES (167, '啊哈哈', '', NULL, 166, NULL, 2, '88881', NULL, 1, '2021-08-18 00:31:44', '2021-08-18 00:31:44');

-- ----------------------------
-- Table structure for t_order_details
-- ----------------------------
DROP TABLE IF EXISTS `t_order_details`;
CREATE TABLE `t_order_details`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `order_id` int(0) NULL DEFAULT NULL,
  `goods_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `goods_num` int(0) NULL DEFAULT NULL,
  `unit` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` float NULL DEFAULT NULL,
  `sum` float NULL DEFAULT NULL,
  `is_valid` int(0) NULL DEFAULT 1,
  `create_date` datetime(0) NULL DEFAULT NULL,
  `update_date` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order_details
-- ----------------------------
INSERT INTO `t_order_details` VALUES (1, 5, '联想笔记本', 2, '台', 4900, 9800, 1, '2016-11-29 14:59:32', '2016-11-29 14:59:34');
INSERT INTO `t_order_details` VALUES (2, 5, '惠普音响', 4, '台', 200, 800, 1, '2017-03-01 11:32:34', '2017-03-01 11:32:36');
INSERT INTO `t_order_details` VALUES (3, 8, '罗技键盘', 10, '个', 90, 900, 1, '2017-03-01 11:32:39', '2017-03-01 11:32:41');
INSERT INTO `t_order_details` VALUES (4, 6, '艾利鼠标', 20, '个', 20, 400, 1, '2017-03-01 11:32:46', '2017-03-01 11:32:48');
INSERT INTO `t_order_details` VALUES (5, 7, '东芝U盘', 5, '个', 105, 525, 1, '2017-03-01 11:32:51', '2017-03-01 11:32:53');
INSERT INTO `t_order_details` VALUES (6, 7, '充电器', 1, '个', 30, 30, 1, '2017-03-01 11:32:55', '2017-03-01 11:32:57');
INSERT INTO `t_order_details` VALUES (7, 9, '电风扇', 5, '台', 200, 1000, 1, '2021-08-20 17:13:59', '2021-08-20 17:14:02');
INSERT INTO `t_order_details` VALUES (8, 10, '黄金梅丽号', 1, '艘', 50000, 50000, 1, '2021-08-20 17:14:24', '2021-08-20 17:14:26');

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_id` int(0) NOT NULL COMMENT '角色id',
  `module_id` int(0) NOT NULL COMMENT '资源id',
  `acl_value` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限码',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `module_id`(`module_id`) USING BTREE,
  CONSTRAINT `t_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_permission_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `t_module` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8195 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
INSERT INTO `t_permission` VALUES (7211, 101, 1, '10', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7212, 101, 2, '1010', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7213, 101, 3, '101001', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7214, 101, 4, '101002', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7215, 101, 5, '101003', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7216, 101, 44, '101004', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7217, 101, 6, '1020', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7218, 101, 7, '102001', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7219, 101, 154, '1030', '2021-08-17 10:53:01', '2021-08-17 10:53:01');
INSERT INTO `t_permission` VALUES (7270, 103, 16, '30', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7271, 103, 34, '3010', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7272, 103, 147, '301001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7273, 103, 35, '3020', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7274, 103, 149, '302001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7275, 103, 36, '3030', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7276, 103, 150, '303001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7277, 103, 151, '303002', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7278, 103, 37, '3040', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7279, 103, 152, '304001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7280, 103, 153, '304002', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7281, 103, 38, '3050', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7282, 103, 18, '60', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7283, 103, 26, '6010', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7284, 103, 130, '601001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7285, 103, 131, '601002', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7286, 103, 132, '601003', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7287, 103, 133, '601004', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7288, 103, 27, '6020', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7289, 103, 134, '602001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7290, 103, 135, '602002', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7291, 103, 136, '602003', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7292, 103, 137, '602004', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7293, 103, 28, '6030', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7294, 103, 138, '603001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7295, 103, 139, '603002', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7296, 103, 140, '603003', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7297, 103, 141, '603004', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7298, 103, 142, '6040', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7299, 103, 143, '604001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7300, 103, 144, '604002', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7301, 103, 145, '604003', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7302, 103, 146, '604004', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7303, 103, 158, '100', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7304, 103, 160, '10010', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7305, 103, 161, '1001001', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7306, 103, 162, '801003', '2021-08-17 10:53:20', '2021-08-17 10:53:20');
INSERT INTO `t_permission` VALUES (7319, 104, 14, '40', '2021-08-17 10:53:30', '2021-08-17 10:53:30');
INSERT INTO `t_permission` VALUES (7320, 104, 15, '4010', '2021-08-17 10:53:30', '2021-08-17 10:53:30');
INSERT INTO `t_permission` VALUES (7321, 104, 39, '4020', '2021-08-17 10:53:30', '2021-08-17 10:53:30');
INSERT INTO `t_permission` VALUES (7322, 104, 40, '4030', '2021-08-17 10:53:30', '2021-08-17 10:53:30');
INSERT INTO `t_permission` VALUES (7323, 104, 109, '4060', '2021-08-17 10:53:30', '2021-08-17 10:53:30');
INSERT INTO `t_permission` VALUES (7327, 109, 14, '40', '2021-08-17 10:53:40', '2021-08-17 10:53:40');
INSERT INTO `t_permission` VALUES (7328, 109, 15, '4010', '2021-08-17 10:53:40', '2021-08-17 10:53:40');
INSERT INTO `t_permission` VALUES (7329, 109, 39, '4020', '2021-08-17 10:53:40', '2021-08-17 10:53:40');
INSERT INTO `t_permission` VALUES (7330, 109, 40, '4030', '2021-08-17 10:53:40', '2021-08-17 10:53:40');
INSERT INTO `t_permission` VALUES (7331, 109, 109, '4060', '2021-08-17 10:53:40', '2021-08-17 10:53:40');
INSERT INTO `t_permission` VALUES (7332, 109, 155, '70', '2021-08-17 10:53:40', '2021-08-17 10:53:40');
INSERT INTO `t_permission` VALUES (7333, 109, 156, '7010', '2021-08-17 10:53:40', '2021-08-17 10:53:40');
INSERT INTO `t_permission` VALUES (7334, 109, 157, '701001', '2021-08-17 10:53:40', '2021-08-17 10:53:40');
INSERT INTO `t_permission` VALUES (8119, 105, 1, '10', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8120, 105, 2, '1010', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8121, 105, 3, '101001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8122, 105, 4, '101002', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8123, 105, 5, '101003', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8124, 105, 44, '101004', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8125, 105, 6, '1020', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8126, 105, 7, '102001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8127, 105, 8, '20', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8128, 105, 9, '2010', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8129, 105, 10, '201001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8130, 105, 11, '201002', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8131, 105, 19, '201003', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8132, 105, 12, '2020', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8133, 105, 13, '202001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8134, 105, 126, '123213', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8135, 105, 14, '40', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8136, 105, 15, '4010', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8137, 105, 39, '4020', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8138, 105, 40, '4030', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8139, 105, 109, '4060', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8140, 105, 16, '30', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8141, 105, 34, '3010', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8142, 105, 147, '301001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8143, 105, 35, '3020', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8144, 105, 149, '302001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8145, 105, 36, '3030', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8146, 105, 150, '303001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8147, 105, 151, '303002', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8148, 105, 37, '3040', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8149, 105, 152, '304001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8150, 105, 153, '304002', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8151, 105, 38, '3050', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8152, 105, 17, '50', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8153, 105, 102, '5010', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8154, 105, 103, '5020', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8155, 105, 18, '60', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8156, 105, 26, '6010', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8157, 105, 130, '601001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8158, 105, 131, '601002', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8159, 105, 132, '601003', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8160, 105, 133, '601004', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8161, 105, 27, '6020', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8162, 105, 134, '602001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8163, 105, 135, '602002', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8164, 105, 136, '602003', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8165, 105, 137, '602004', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8166, 105, 28, '6030', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8167, 105, 138, '603001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8168, 105, 139, '603002', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8169, 105, 140, '603003', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8170, 105, 141, '603004', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8171, 105, 142, '6040', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8172, 105, 143, '604001', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8173, 105, 144, '604002', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8174, 105, 145, '604003', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8175, 105, 146, '604004', '2021-08-19 20:28:42', '2021-08-19 20:28:42');
INSERT INTO `t_permission` VALUES (8176, 102, 8, '20', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8177, 102, 9, '2010', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8178, 102, 10, '201001', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8179, 102, 11, '201002', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8180, 102, 19, '201003', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8181, 102, 12, '2020', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8182, 102, 13, '202001', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8183, 102, 126, '123213', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8184, 102, 16, '30', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8185, 102, 34, '3010', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8186, 102, 147, '301001', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8187, 102, 35, '3020', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8188, 102, 149, '302001', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8189, 102, 36, '3030', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8190, 102, 150, '303001', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8191, 102, 151, '303002', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8192, 102, 37, '3040', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8193, 102, 152, '304001', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8194, 102, 153, '304002', '2021-08-20 16:47:25', '2021-08-20 16:47:25');
INSERT INTO `t_permission` VALUES (8195, 102, 38, '3050', '2021-08-20 16:47:25', '2021-08-20 16:47:25');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '角色主键id',
  `role_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名',
  `role_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_valid` int(0) NULL DEFAULT NULL COMMENT '有效状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (101, '销售', '负责产品的销售', '2021-08-11 13:13:46', '2021-08-15 14:51:58', 1);
INSERT INTO `t_role` VALUES (102, '客户经理', NULL, '2021-08-11 13:13:59', '2021-08-11 13:14:01', 1);
INSERT INTO `t_role` VALUES (103, '技术经理', NULL, '2021-08-14 13:52:47', '2021-08-14 13:52:50', 1);
INSERT INTO `t_role` VALUES (104, '人事', NULL, '2021-08-14 13:53:04', '2021-08-14 13:53:07', 1);
INSERT INTO `t_role` VALUES (105, '系统管理员', '拥有系统最高权限', '2021-08-14 13:53:17', '2021-08-15 15:03:00', 1);
INSERT INTO `t_role` VALUES (108, '产品经理', NULL, '2021-08-15 13:46:21', '2021-08-15 13:46:21', 0);
INSERT INTO `t_role` VALUES (109, '项目经理', '负责项目的计划和执行', '2021-08-15 14:48:08', '2021-08-15 14:51:19', 1);

-- ----------------------------
-- Table structure for t_sale_chance
-- ----------------------------
DROP TABLE IF EXISTS `t_sale_chance`;
CREATE TABLE `t_sale_chance`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `chance_source` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '机会来源',
  `customer_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `cgjl` int(0) NULL DEFAULT NULL COMMENT '成功几率',
  `overview` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '概要',
  `link_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `link_phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `assign_man` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分配人',
  `assign_time` datetime(0) NULL DEFAULT NULL COMMENT '分配时间',
  `state` int(0) NULL DEFAULT NULL COMMENT '分配状态',
  `dev_result` int(0) NULL DEFAULT NULL COMMENT '开发结果',
  `is_valid` int(0) NULL DEFAULT NULL COMMENT '有效状态',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_sale_chance
-- ----------------------------
INSERT INTO `t_sale_chance` VALUES (1, '广告', '兆润', 70, NULL, '陈建明', '16608380566', NULL, 'admin', '2', '2021-08-09 19:07:15', 1, 2, 1, '2021-08-09 19:07:49', '2021-08-09 19:07:55');
INSERT INTO `t_sale_chance` VALUES (2, '抖音推广', '绝味', 80, NULL, '李大妈', '15507653112', NULL, 'admin', '3', '2021-08-09 21:37:59', 1, 1, 1, '2021-08-09 21:38:08', '2021-08-09 21:38:10');
INSERT INTO `t_sale_chance` VALUES (3, '官网', '海康威视', NULL, '', '刘华强', '13678273603', '', 'jason', '2', '2021-08-11 14:53:43', 1, 1, 1, '2021-08-10 15:01:29', '2021-08-11 14:53:43');
INSERT INTO `t_sale_chance` VALUES (4, '官网', '万达集团', NULL, NULL, '王健林', '17150668666', NULL, 'peter', '2', '2021-08-10 15:06:08', 1, 1, 1, '2021-08-10 15:06:08', '2021-08-10 15:06:08');
INSERT INTO `t_sale_chance` VALUES (5, '微信公众号', '杰瑞集团', NULL, '', '程子豪', '16672732562', '', 'admin', '2', '2021-08-11 21:53:46', 1, 1, 1, '2021-08-10 18:30:54', '2021-08-11 21:53:46');
INSERT INTO `t_sale_chance` VALUES (6, '官网', '兆润', NULL, '', '王兰', '15165363241', '', 'admin', '2', '2021-08-13 14:47:41', 1, 1, 1, '2021-08-10 18:33:47', '2021-08-13 14:47:41');
INSERT INTO `t_sale_chance` VALUES (7, '广告', '大华', NULL, '', '史蒂夫', '17516253689', '', 'admin', '', NULL, 0, 0, 1, '2021-08-10 18:37:24', '2021-08-10 18:37:24');
INSERT INTO `t_sale_chance` VALUES (8, '官网', '小米', NULL, '', '雷军', '15878270632', '', 'jason', '1', '2021-08-11 10:19:20', 1, 3, 1, '2021-08-10 18:39:35', '2021-08-11 10:19:20');
INSERT INTO `t_sale_chance` VALUES (9, '阿达', '规划局', NULL, '', '阿伟', '15165363241', '', 'jason', '', NULL, 0, 0, 1, '2021-08-10 18:41:21', '2021-08-11 11:04:42');
INSERT INTO `t_sale_chance` VALUES (10, '史蒂夫', '施工方', NULL, '', '史蒂夫', '18888888888', '', 'jason', '1', '2021-08-11 14:53:59', 1, 2, 1, '2021-08-10 18:41:58', '2021-08-11 14:53:59');
INSERT INTO `t_sale_chance` VALUES (11, '史蒂夫', '水电费水电费', NULL, '', '史蒂夫', '15165363241', '', 'jason', '', NULL, 0, 0, 1, '2021-08-10 18:43:50', '2021-08-10 18:43:50');
INSERT INTO `t_sale_chance` VALUES (12, '刚发的', '改水电费', NULL, '', '电饭锅', '17516253689', '', 'jason', '', NULL, 0, 0, 1, '2021-08-10 18:44:55', '2021-08-10 18:44:55');
INSERT INTO `t_sale_chance` VALUES (13, '官网', '京东', 80, '京东下乡', '刘强东', '15562998365', '', 'jason', '1', '2021-08-13 12:42:14', 1, 2, 1, '2021-08-13 12:42:14', '2021-08-13 12:42:14');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `user_pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `true_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `is_valid` int(0) NULL DEFAULT NULL COMMENT '有效状态',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', 'ISGMyneATSuhkiwz4BURBQ==', '张三', 'fxcvd122@126.com', '15623567881', 1, '2021-08-10 13:46:14', '2021-08-20 16:34:08');
INSERT INTO `t_user` VALUES (2, 'jason', 'ISGMyneATSuhkiwz4BURBQ==', '辰纪忻', '1790150205@qq.com', '17628383212', 1, '2021-08-10 13:46:08', '2021-08-17 11:15:41');
INSERT INTO `t_user` VALUES (3, 'peter', 'ISGMyneATSuhkiwz4BURBQ==', '皮特', NULL, NULL, 1, '2021-08-10 13:46:58', '2021-08-10 13:47:02');
INSERT INTO `t_user` VALUES (4, 'aaa', 'ISGMyneATSuhkiwz4BURBQ==', 'aaa', NULL, NULL, 0, '2021-08-14 11:55:06', '2021-08-14 11:55:07');
INSERT INTO `t_user` VALUES (5, 'bbb', 'ISGMyneATSuhkiwz4BURBQ==', 'bbb', NULL, NULL, 0, NULL, NULL);
INSERT INTO `t_user` VALUES (6, 'ccc', 'ISGMyneATSuhkiwz4BURBQ==', 'ccc', NULL, NULL, 0, NULL, NULL);
INSERT INTO `t_user` VALUES (7, 'ddd', 'ISGMyneATSuhkiwz4BURBQ==', 'ddd', NULL, NULL, 0, NULL, NULL);
INSERT INTO `t_user` VALUES (8, 'marry', 'ZwsUcorZkCrsujLiL6T2vQ==', '何茂瑜', '1741702350@qq.com', '15108270226', 1, '2021-08-14 12:57:27', '2021-08-19 20:26:55');
INSERT INTO `t_user` VALUES (9, 'eee', 'ISGMyneATSuhkiwz4BURBQ==', 'eee', '1654535@163.com', '13678276506', 0, '2021-08-14 13:34:54', '2021-08-14 13:34:54');
INSERT INTO `t_user` VALUES (11, 'bob', 'ISGMyneATSuhkiwz4BURBQ==', '鲍勃', '4861684@126.com', '17265783212', 0, '2021-08-15 10:44:37', '2021-08-15 11:05:46');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(0) NOT NULL COMMENT '用户id',
  `role_id` int(0) NOT NULL COMMENT '角色id',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `t_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `t_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_user_role_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES (3, 3, 102, '2021-08-11 13:37:21', '2021-08-11 13:37:24');
INSERT INTO `t_user_role` VALUES (16, 2, 103, '2021-08-17 11:15:41', '2021-08-17 11:15:41');
INSERT INTO `t_user_role` VALUES (18, 8, 105, '2021-08-19 20:26:55', '2021-08-19 20:26:55');
INSERT INTO `t_user_role` VALUES (19, 1, 105, '2021-08-20 16:34:08', '2021-08-20 16:34:08');
INSERT INTO `t_user_role` VALUES (20, 1, 102, '2021-08-20 16:34:08', '2021-08-20 16:34:08');

SET FOREIGN_KEY_CHECKS = 1;
