/*
 Navicat Premium Data Transfer

 Source Server         : ccc
 Source Server Type    : MySQL
 Source Server Version : 80200
 Source Host           : localhost:3306
 Source Schema         : collegetextbook

 Target Server Type    : MySQL
 Target Server Version : 80200
 File Encoding         : 65001

 Date: 24/12/2025 16:12:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-12-22 08:17:50', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-12-22 08:17:50', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-12-22 08:17:50', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-12-22 08:17:50', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-12-22 08:17:50', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-12-22 08:17:50', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-12-22 08:17:50', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框');
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-12-22 08:17:50', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(0) DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '部门名称',
  `order_num` int(0) DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '山东理工大学', 0, '', '', '', '0', '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-23 08:33:31');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '计算机科学与技术学院', 1, '', '', '', '0', '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-23 08:33:53');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '计科2201', 1, '', '', '', '0', '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-23 08:34:12');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '计科2202', 2, '', '', '', '0', '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-23 08:34:21');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '计科2203', 3, '', '', '', '0', '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-23 08:34:32');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '计科2204', 4, '', '', '', '0', '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-23 08:34:43');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(0) DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '待审核', '0', 'textbook_status', NULL, 'primary', 'N', '0', 'admin', '2025-12-22 11:10:29', 'admin', '2025-12-22 11:10:35', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 0, '审核通过', '1', 'textbook_status', NULL, 'success', 'N', '0', 'admin', '2025-12-22 11:10:48', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 0, '审核拒绝', '2', 'textbook_status', NULL, 'danger', 'N', '0', 'admin', '2025-12-22 11:11:01', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 0, '已订购', '3', 'textbook_status', NULL, 'warning', 'N', '0', 'admin', '2025-12-22 11:11:15', 'admin', '2025-12-22 11:11:22', NULL);
INSERT INTO `sys_dict_data` VALUES (104, 0, '入库', '1', 'textbook_operation', NULL, 'success', 'N', '0', 'admin', '2025-12-22 11:17:17', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 0, '出库', '2', 'textbook_operation', NULL, 'primary', 'N', '0', 'admin', '2025-12-22 11:17:28', 'admin', '2025-12-22 11:17:34', NULL);
INSERT INTO `sys_dict_data` VALUES (106, 0, '退回', '3', 'textbook_operation', NULL, 'warning', 'N', '0', 'admin', '2025-12-22 11:17:49', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '审核状态', 'textbook_status', '0', 'admin', '2025-12-22 11:09:54', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (101, '操作类型', 'textbook_operation', '0', 'admin', '2025-12-22 11:17:00', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-12-22 08:17:50', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-12-22 08:17:50', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-12-22 08:17:50', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '提示消息',
  `login_time` datetime(0) DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-22 09:02:26');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-22 10:30:58');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-22 12:19:13');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-22 14:18:53');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 08:08:03');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:14:30');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:14:36');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:18:57');
INSERT INTO `sys_logininfor` VALUES (108, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:19:03');
INSERT INTO `sys_logininfor` VALUES (109, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:27:48');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:27:52');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:34:42');
INSERT INTO `sys_logininfor` VALUES (112, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:34:48');
INSERT INTO `sys_logininfor` VALUES (113, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:34:59');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:35:02');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:35:23');
INSERT INTO `sys_logininfor` VALUES (116, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:35:38');
INSERT INTO `sys_logininfor` VALUES (117, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:36:00');
INSERT INTO `sys_logininfor` VALUES (118, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:36:06');
INSERT INTO `sys_logininfor` VALUES (119, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:36:09');
INSERT INTO `sys_logininfor` VALUES (120, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:36:15');
INSERT INTO `sys_logininfor` VALUES (121, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:36:36');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:36:39');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:39:37');
INSERT INTO `sys_logininfor` VALUES (124, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:39:45');
INSERT INTO `sys_logininfor` VALUES (125, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:40:56');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:41:02');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:41:40');
INSERT INTO `sys_logininfor` VALUES (128, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:41:45');
INSERT INTO `sys_logininfor` VALUES (129, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:42:00');
INSERT INTO `sys_logininfor` VALUES (130, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:42:06');
INSERT INTO `sys_logininfor` VALUES (131, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-23 09:42:46');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 09:42:49');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-23 15:56:14');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:14:06');
INSERT INTO `sys_logininfor` VALUES (135, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:14:12');
INSERT INTO `sys_logininfor` VALUES (136, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:14:28');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:14:38');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:18:19');
INSERT INTO `sys_logininfor` VALUES (139, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:18:26');
INSERT INTO `sys_logininfor` VALUES (140, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:22:30');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:22:39');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:24:41');
INSERT INTO `sys_logininfor` VALUES (143, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:24:58');
INSERT INTO `sys_logininfor` VALUES (144, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:28:03');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:29:03');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:29:31');
INSERT INTO `sys_logininfor` VALUES (147, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:29:36');
INSERT INTO `sys_logininfor` VALUES (148, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:29:55');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:30:03');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:32:44');
INSERT INTO `sys_logininfor` VALUES (151, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-12-24 10:32:50');
INSERT INTO `sys_logininfor` VALUES (152, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:32:54');
INSERT INTO `sys_logininfor` VALUES (153, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:33:21');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:33:28');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:35:23');
INSERT INTO `sys_logininfor` VALUES (156, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:36:35');
INSERT INTO `sys_logininfor` VALUES (157, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:44:33');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:44:42');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:45:28');
INSERT INTO `sys_logininfor` VALUES (160, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:45:34');
INSERT INTO `sys_logininfor` VALUES (161, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:46:23');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:46:29');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:46:58');
INSERT INTO `sys_logininfor` VALUES (164, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:47:31');
INSERT INTO `sys_logininfor` VALUES (165, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:54:29');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:54:36');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:59:23');
INSERT INTO `sys_logininfor` VALUES (168, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 10:59:29');
INSERT INTO `sys_logininfor` VALUES (169, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 10:59:58');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 11:00:05');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 11:00:22');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 11:00:29');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 11:00:43');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-24 16:03:45');
INSERT INTO `sys_logininfor` VALUES (175, '13', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-24 16:03:49');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(0) DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(0) DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '路由名称',
  `is_frame` int(0) DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(0) DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2040 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-12-22 08:17:49', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-12-22 08:17:49', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-12-22 08:17:49', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-12-22 08:17:49', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-12-22 08:17:49', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-12-22 08:17:49', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-12-22 08:17:49', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-12-22 08:17:49', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-12-22 08:17:49', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-12-22 08:17:49', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-12-22 08:17:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '教材信息', 0, 3, 'textbook', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'education', 'admin', '2025-12-22 10:48:55', 'admin', '2025-12-22 10:52:28', '');
INSERT INTO `sys_menu` VALUES (2001, '库存管理', 0, 4, 'inventory', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'druid', 'admin', '2025-12-22 10:50:36', 'admin', '2025-12-22 10:53:01', '');
INSERT INTO `sys_menu` VALUES (2002, '教材信息', 2000, 1, 'books', 'textbook/books/index', NULL, '', 1, 0, 'C', '0', '0', 'textbook:books:list', '#', 'admin', '2025-12-22 11:00:01', '', NULL, '教材信息菜单');
INSERT INTO `sys_menu` VALUES (2003, '教材信息查询', 2002, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'textbook:books:query', '#', 'admin', '2025-12-22 11:00:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '教材信息新增', 2002, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'textbook:books:add', '#', 'admin', '2025-12-22 11:00:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '教材信息修改', 2002, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'textbook:books:edit', '#', 'admin', '2025-12-22 11:00:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '教材信息删除', 2002, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'textbook:books:remove', '#', 'admin', '2025-12-22 11:00:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '教材信息导出', 2002, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'textbook:books:export', '#', 'admin', '2025-12-22 11:00:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '教材类型', 2000, 1, 'categories', 'system/categories/index', NULL, '', 1, 0, 'C', '0', '0', 'system:categories:list', '#', 'admin', '2025-12-22 11:07:21', '', NULL, '教材类型菜单');
INSERT INTO `sys_menu` VALUES (2009, '教材类型查询', 2008, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:categories:query', '#', 'admin', '2025-12-22 11:07:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '教材类型新增', 2008, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:categories:add', '#', 'admin', '2025-12-22 11:07:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '教材类型修改', 2008, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:categories:edit', '#', 'admin', '2025-12-22 11:07:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '教材类型删除', 2008, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:categories:remove', '#', 'admin', '2025-12-22 11:07:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '教材类型导出', 2008, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:categories:export', '#', 'admin', '2025-12-22 11:07:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '出版社信息', 2000, 1, 'publishers', 'system/publishers/index', NULL, '', 1, 0, 'C', '0', '0', 'system:publishers:list', '#', 'admin', '2025-12-22 11:07:29', '', NULL, '出版社信息菜单');
INSERT INTO `sys_menu` VALUES (2015, '出版社信息查询', 2014, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:publishers:query', '#', 'admin', '2025-12-22 11:07:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '出版社信息新增', 2014, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:publishers:add', '#', 'admin', '2025-12-22 11:07:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '出版社信息修改', 2014, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:publishers:edit', '#', 'admin', '2025-12-22 11:07:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '出版社信息删除', 2014, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:publishers:remove', '#', 'admin', '2025-12-22 11:07:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '出版社信息导出', 2014, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:publishers:export', '#', 'admin', '2025-12-22 11:07:29', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '教材库存', 2001, 1, 'inventory', 'system/inventory/index', NULL, '', 1, 0, 'C', '0', '0', 'system:inventory:list', '#', 'admin', '2025-12-22 11:22:28', '', NULL, '教材库存菜单');
INSERT INTO `sys_menu` VALUES (2021, '教材库存查询', 2020, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:inventory:query', '#', 'admin', '2025-12-22 11:22:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '教材库存新增', 2020, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:inventory:add', '#', 'admin', '2025-12-22 11:22:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '教材库存修改', 2020, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:inventory:edit', '#', 'admin', '2025-12-22 11:22:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '教材库存删除', 2020, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:inventory:remove', '#', 'admin', '2025-12-22 11:22:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '教材库存导出', 2020, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:inventory:export', '#', 'admin', '2025-12-22 11:22:28', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '征订申请', 2001, 1, 'requests', 'system/requests/index', NULL, '', 1, 0, 'C', '0', '0', 'system:requests:list', '#', 'admin', '2025-12-22 11:22:38', '', NULL, '征订申请菜单');
INSERT INTO `sys_menu` VALUES (2027, '征订申请查询', 2026, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:requests:query', '#', 'admin', '2025-12-22 11:22:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '征订申请新增', 2026, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:requests:add', '#', 'admin', '2025-12-22 11:22:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '征订申请修改', 2026, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:requests:edit', '#', 'admin', '2025-12-22 11:22:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '征订申请删除', 2026, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:requests:remove', '#', 'admin', '2025-12-22 11:22:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '征订申请导出', 2026, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:requests:export', '#', 'admin', '2025-12-22 11:22:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '出入库日志', 2001, 1, 'logs', 'system/logs/index', NULL, '', 1, 0, 'C', '0', '0', 'system:logs:list', '#', 'admin', '2025-12-22 11:22:45', '', NULL, '出入库日志菜单');
INSERT INTO `sys_menu` VALUES (2033, '出入库日志查询', 2032, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:logs:query', '#', 'admin', '2025-12-22 11:22:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '出入库日志新增', 2032, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:logs:add', '#', 'admin', '2025-12-22 11:22:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '出入库日志修改', 2032, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:logs:edit', '#', 'admin', '2025-12-22 11:22:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '出入库日志删除', 2032, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:logs:remove', '#', 'admin', '2025-12-22 11:22:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '出入库日志导出', 2032, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'system:logs:export', '#', 'admin', '2025-12-22 11:22:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '征订申请审核', 2026, 6, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:requests:review', '#', 'admin', '2025-12-22 16:00:13', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '教师管理', 1, 1, 'teacher', 'system/teacher/index', NULL, '', 1, 0, 'C', '0', '0', 'system:teacher:list', 'user', 'admin', '2025-12-24 09:25:01', 'admin', '2025-12-24 10:55:47', '');
INSERT INTO `sys_menu` VALUES (2040, '教师查询', 2039, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:teacher:query', '#', 'admin', '2025-12-24 10:56:19', 'admin', '2025-12-24 10:56:31', '');
INSERT INTO `sys_menu` VALUES (2041, '教师新增', 2039, 1, 'system:teacher:add', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:teacher:add', '#', 'admin', '2025-12-24 10:57:06', 'admin', '2025-12-24 10:57:20', '');
INSERT INTO `sys_menu` VALUES (2042, '教师修改', 2039, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:teacher:edit', '#', 'admin', '2025-12-24 10:57:41', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '教师删除', 2039, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:teacher:delete', '#', 'admin', '2025-12-24 10:58:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2044, '教师导出', 2039, 1, '', NULL, NULL, '', 1, 0, 'F', '0', '0', 'system:teacher:export', '#', 'admin', '2025-12-24 10:58:25', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '模块标题',
  `business_type` int(0) DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '请求方式',
  `operator_type` int(0) DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '返回参数',
  `status` int(0) DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime(0) DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(0) DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 205 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"textbook_stock_logs,textbook_inventory,textbook_order_requests,textbook_categories,textbook_books,textbook_publishers\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 10:31:54', 190);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"books\",\"className\":\"TextbookBooks\",\"columns\":[{\"capJavaField\":\"TextbookId\",\"columnComment\":\"教材ID\",\"columnId\":1,\"columnName\":\"textbook_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"textbookId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Picture\",\"columnComment\":\"图片\",\"columnId\":2,\"columnName\":\"picture\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"picture\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Isbn\",\"columnComment\":\"ISBN\",\"columnId\":3,\"columnName\":\"isbn\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"isbn\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"教材名称\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"ja', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 10:41:16', 58);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"教材信息\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"system\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 10:48:56', 16);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"库存管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"system\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 10:50:36', 7);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2025-12-22 10:50:39', 5);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-22 10:48:55\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"教材信息\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"textbook\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 10:52:28', 10);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-22 10:50:36\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"库存管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"inventory\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 10:53:01', 7);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"books\",\"className\":\"TextbookBooks\",\"columns\":[{\"capJavaField\":\"TextbookId\",\"columnComment\":\"教材ID\",\"columnId\":1,\"columnName\":\"textbook_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"textbookId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-12-22 10:41:16\",\"usableColumn\":false},{\"capJavaField\":\"Picture\",\"columnComment\":\"图片\",\"columnId\":2,\"columnName\":\"picture\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"imageUpload\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"picture\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-12-22 10:41:16\",\"usableColumn\":false},{\"capJavaField\":\"Isbn\",\"columnComment\":\"ISBN\",\"columnId\":3,\"columnName\":\"isbn\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"isbn\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-12-22 10:41:16\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"教材名称\",\"columnId\":4,\"columnName\":\"title\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 10:56:27', 23);
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"textbook_books\"}', NULL, 0, NULL, '2025-12-22 10:56:30', 175);
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"categories\",\"className\":\"TextbookCategories\",\"columns\":[{\"capJavaField\":\"CategoryId\",\"columnComment\":\"类型ID\",\"columnId\":12,\"columnName\":\"category_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"categoryId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryName\",\"columnComment\":\"类型名称\",\"columnId\":13,\"columnName\":\"category_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ccc\",\"functionName\":\"教材类型\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{\\\"parentMenuId\\\":2000}\",\"packageName\":\"com.ruoyi.system\",\"params\":{\"parentMenuId\":2000},\"parentMenuId\":2000,\"sub\":false,\"tableComment\":\"教材类型\",\"tableId\":2,\"tableName\":\"textbook_categories\",\"tplCategory\":\"crud\",\"tplWebType\":\"element-plus\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:02:52', 41);
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"publishers\",\"className\":\"TextbookPublishers\",\"columns\":[{\"capJavaField\":\"PublisherId\",\"columnComment\":\"出版社ID\",\"columnId\":30,\"columnName\":\"publisher_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"publisherId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"PublisherName\",\"columnComment\":\"出版社名称\",\"columnId\":31,\"columnName\":\"publisher_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"publisherName\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ContactInfo\",\"columnComment\":\"联系方式\",\"columnId\":32,\"columnName\":\"contact_info\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"contactInfo\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"cccc\",\"functionName\":\"出版社信息\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{\\\"parentMenuId\\\":2000}\",\"packageName\":\"com.ruoyi.system\",\"params\":{\"parentMenuId\":2000},\"parentMenuId\":2000,\"sub\":false,\"tableComment\":\"出版社\",\"tableId\":5,\"tableName\":', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:03:44', 15);
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"textbook_categories\"}', NULL, 0, NULL, '2025-12-22 11:03:55', 149);
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"textbook_publishers\"}', NULL, 0, NULL, '2025-12-22 11:03:56', 29);
INSERT INTO `sys_oper_log` VALUES (113, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"审核状态\",\"dictType\":\"textbook_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:09:54', 112);
INSERT INTO `sys_oper_log` VALUES (114, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"待审核\",\"dictSort\":0,\"dictType\":\"textbook_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:10:29', 11);
INSERT INTO `sys_oper_log` VALUES (115, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-22 11:10:29\",\"default\":false,\"dictCode\":100,\"dictLabel\":\"待审核\",\"dictSort\":0,\"dictType\":\"textbook_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"primary\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:10:35', 10);
INSERT INTO `sys_oper_log` VALUES (116, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"审核通过\",\"dictSort\":0,\"dictType\":\"textbook_status\",\"dictValue\":\"1\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:10:48', 9);
INSERT INTO `sys_oper_log` VALUES (117, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"审核拒绝\",\"dictSort\":0,\"dictType\":\"textbook_status\",\"dictValue\":\"2\",\"listClass\":\"danger\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:11:01', 7);
INSERT INTO `sys_oper_log` VALUES (118, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已订购\",\"dictSort\":0,\"dictType\":\"textbook_status\",\"dictValue\":\"3\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:11:15', 9);
INSERT INTO `sys_oper_log` VALUES (119, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-22 11:11:15\",\"default\":false,\"dictCode\":103,\"dictLabel\":\"已订购\",\"dictSort\":0,\"dictType\":\"textbook_status\",\"dictValue\":\"3\",\"isDefault\":\"N\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:11:22', 8);
INSERT INTO `sys_oper_log` VALUES (120, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"inventory\",\"className\":\"TextbookInventory\",\"columns\":[{\"capJavaField\":\"InventoryId\",\"columnComment\":\"库存记录ID\",\"columnId\":14,\"columnName\":\"inventory_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"inventoryId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TextbookId\",\"columnComment\":\"教材\",\"columnId\":15,\"columnName\":\"textbook_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"textbookId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TotalQuantity\",\"columnComment\":\"总数量\",\"columnId\":16,\"columnName\":\"total_quantity\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",\"javaField\":\"totalQuantity\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AvailableQuantity\",\"columnComment\":\"可领用数量\",\"columnId\":17,\"columnName\":\"available_quantity\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:13:45', 44);
INSERT INTO `sys_oper_log` VALUES (121, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"requests\",\"className\":\"TextbookOrderRequests\",\"columns\":[{\"capJavaField\":\"RequestId\",\"columnComment\":\"申请ID\",\"columnId\":18,\"columnName\":\"request_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"requestId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TeacherId\",\"columnComment\":\"申请人\",\"columnId\":19,\"columnName\":\"teacher_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"teacherId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TextbookId\",\"columnComment\":\"申请教材\",\"columnId\":20,\"columnName\":\"textbook_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"textbookId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CourseName\",\"columnComment\":\"课程名称\",\"columnId\":21,\"columnName\":\"course_name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:15:25', 35);
INSERT INTO `sys_oper_log` VALUES (122, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"操作类型\",\"dictType\":\"textbook_operation\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:17:00', 7);
INSERT INTO `sys_oper_log` VALUES (123, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"入库\",\"dictSort\":0,\"dictType\":\"textbook_operation\",\"dictValue\":\"1\",\"listClass\":\"success\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:17:17', 8);
INSERT INTO `sys_oper_log` VALUES (124, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"出库\",\"dictSort\":0,\"dictType\":\"textbook_operation\",\"dictValue\":\"2\",\"listClass\":\"info\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:17:28', 7);
INSERT INTO `sys_oper_log` VALUES (125, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-22 11:17:28\",\"default\":false,\"dictCode\":105,\"dictLabel\":\"出库\",\"dictSort\":0,\"dictType\":\"textbook_operation\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"primary\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:17:34', 8);
INSERT INTO `sys_oper_log` VALUES (126, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"退回\",\"dictSort\":0,\"dictType\":\"textbook_operation\",\"dictValue\":\"3\",\"listClass\":\"warning\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:17:49', 7);
INSERT INTO `sys_oper_log` VALUES (127, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"logs\",\"className\":\"TextbookStockLogs\",\"columns\":[{\"capJavaField\":\"LogId\",\"columnComment\":\"日志ID\",\"columnId\":33,\"columnName\":\"log_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"logId\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TextbookId\",\"columnComment\":\"教材名称\",\"columnId\":34,\"columnName\":\"textbook_id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"textbookId\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Operation\",\"columnComment\":\"操作类型\",\"columnId\":35,\"columnName\":\"operation\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"textbook_operation\",\"edit\":true,\"htmlType\":\"select\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"operation\",\"javaType\":\"Long\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Quantity\",\"columnComment\":\"数量\",\"columnId\":36,\"columnName\":\"quantity\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2025-12-22 10:31:54\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"0\",', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 11:19:12', 19);
INSERT INTO `sys_oper_log` VALUES (128, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"textbook_inventory\"}', NULL, 0, NULL, '2025-12-22 11:19:19', 143);
INSERT INTO `sys_oper_log` VALUES (129, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"textbook_order_requests\"}', NULL, 0, NULL, '2025-12-22 11:19:20', 53);
INSERT INTO `sys_oper_log` VALUES (130, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"textbook_stock_logs\"}', NULL, 0, NULL, '2025-12-22 11:19:21', 30);
INSERT INTO `sys_oper_log` VALUES (131, '教材信息', 1, 'com.ruoyi.system.controller.TextbookBooksController.add()', 'POST', 1, 'admin', '研发部门', '/textbook/books', '127.0.0.1', '内网IP', '{\"categoryId\":222,\"createdAt\":\"2025-12-30\",\"edition\":\"121\",\"isbn\":\"erw\",\"params\":{},\"price\":121,\"publisherId\":123,\"textbookId\":1,\"title\":\"12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 14:46:54', 48);
INSERT INTO `sys_oper_log` VALUES (132, '教材信息', 2, 'com.ruoyi.system.controller.TextbookBooksController.edit()', 'PUT', 1, 'admin', '研发部门', '/textbook/books', '127.0.0.1', '内网IP', '{\"categoryId\":222,\"createdAt\":\"2025-12-30\",\"edition\":\"121\",\"isbn\":\"erw12\",\"params\":{},\"price\":121,\"publisherId\":123,\"textbookId\":1,\"title\":\"12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 14:47:22', 6);
INSERT INTO `sys_oper_log` VALUES (133, '教材信息', 3, 'com.ruoyi.system.controller.TextbookBooksController.remove()', 'DELETE', 1, 'admin', '研发部门', '/textbook/books/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 14:47:37', 14);
INSERT INTO `sys_oper_log` VALUES (134, '出版社信息', 1, 'com.ruoyi.system.controller.TextbookPublishersController.add()', 'POST', 1, 'admin', '研发部门', '/system/publishers', '127.0.0.1', '内网IP', '{\"params\":{},\"publisherId\":1,\"publisherName\":\"001\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 15:10:44', 17);
INSERT INTO `sys_oper_log` VALUES (135, '出版社信息', 1, 'com.ruoyi.system.controller.TextbookPublishersController.add()', 'POST', 1, 'admin', '研发部门', '/system/publishers', '127.0.0.1', '内网IP', '{\"params\":{},\"publisherId\":2,\"publisherName\":\"002\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 15:10:49', 6);
INSERT INTO `sys_oper_log` VALUES (136, '出版社信息', 1, 'com.ruoyi.system.controller.TextbookPublishersController.add()', 'POST', 1, 'admin', '研发部门', '/system/publishers', '127.0.0.1', '内网IP', '{\"params\":{},\"publisherId\":3,\"publisherName\":\"003\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 15:10:53', 5);
INSERT INTO `sys_oper_log` VALUES (137, '教材类型', 1, 'com.ruoyi.system.controller.TextbookCategoriesController.add()', 'POST', 1, 'admin', '研发部门', '/system/categories', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"categoryName\":\"100\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 15:12:36', 10);
INSERT INTO `sys_oper_log` VALUES (138, '教材类型', 1, 'com.ruoyi.system.controller.TextbookCategoriesController.add()', 'POST', 1, 'admin', '研发部门', '/system/categories', '127.0.0.1', '内网IP', '{\"categoryId\":2,\"categoryName\":\"200\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 15:12:40', 12);
INSERT INTO `sys_oper_log` VALUES (139, '教材类型', 1, 'com.ruoyi.system.controller.TextbookCategoriesController.add()', 'POST', 1, 'admin', '研发部门', '/system/categories', '127.0.0.1', '内网IP', '{\"categoryId\":3,\"categoryName\":\"300\",\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 15:12:44', 4);
INSERT INTO `sys_oper_log` VALUES (140, '教材信息', 1, 'com.ruoyi.system.controller.TextbookBooksController.add()', 'POST', 1, 'admin', '研发部门', '/textbook/books', '127.0.0.1', '内网IP', '{\"author\":\"1\",\"categoryId\":1,\"createdAt\":\"2025-12-22\",\"edition\":\"1\",\"isbn\":\"ISBN1234567890\",\"params\":{},\"price\":1,\"publisherId\":1,\"textbookId\":2,\"title\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 15:45:47', 12);
INSERT INTO `sys_oper_log` VALUES (141, '教材信息', 2, 'com.ruoyi.system.controller.TextbookBooksController.edit()', 'PUT', 1, 'admin', '研发部门', '/textbook/books', '127.0.0.1', '内网IP', '{\"author\":\"1\",\"categoryId\":1,\"createdAt\":\"2025-12-22\",\"createdBy\":1,\"edition\":\"1\",\"isbn\":\"ISBN1234567890\",\"params\":{},\"price\":1,\"publisherId\":1,\"textbookId\":2,\"title\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 15:51:22', 7);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"征订申请审核\",\"menuType\":\"F\",\"orderNum\":6,\"params\":{},\"parentId\":2026,\"perms\":\"system:requests:review\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 16:00:13', 37);
INSERT INTO `sys_oper_log` VALUES (143, '征订申请', 1, 'com.ruoyi.system.controller.TextbookOrderRequestsController.add()', 'POST', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"collegeId\":101,\"courseName\":\"2\",\"params\":{},\"quantity\":\"2\",\"requestId\":1,\"status\":2,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 16:54:04', 37);
INSERT INTO `sys_oper_log` VALUES (144, '征订申请', 2, 'com.ruoyi.system.controller.TextbookOrderRequestsController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"collegeId\":101,\"courseName\":\"2\",\"params\":{},\"quantity\":\"1\",\"requestId\":1,\"status\":0,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 16:54:17', 6);
INSERT INTO `sys_oper_log` VALUES (145, '征订申请', 1, 'com.ruoyi.system.controller.TextbookOrderRequestsController.add()', 'POST', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"classId\":103,\"collegeId\":101,\"courseName\":\"12\",\"params\":{},\"quantity\":\"2\",\"requestId\":2,\"status\":3,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 16:55:09', 12);
INSERT INTO `sys_oper_log` VALUES (146, '征订申请', 1, 'com.ruoyi.system.controller.TextbookOrderRequestsController.add()', 'POST', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"classId\":103,\"collegeId\":101,\"courseName\":\"123\",\"params\":{},\"quantity\":\"2\",\"requestId\":3,\"status\":0,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 16:56:26', 5);
INSERT INTO `sys_oper_log` VALUES (147, '征订申请', 2, 'com.ruoyi.system.controller.TextbookOrderRequestsController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"classId\":103,\"collegeId\":101,\"courseName\":\"12\",\"params\":{},\"quantity\":\"2\",\"requestId\":2,\"reviewedAt\":\"2025-12-22\",\"reviewedBy\":1,\"status\":3,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-22 17:12:33', 7);
INSERT INTO `sys_oper_log` VALUES (148, '征订申请', 2, 'com.ruoyi.system.controller.TextbookOrderRequestsController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"collegeId\":101,\"courseName\":\"2\",\"params\":{},\"quantity\":\"1\",\"requestId\":1,\"reviewedAt\":\"2025-12-23\",\"reviewedBy\":1,\"status\":1,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:08:23', 15);
INSERT INTO `sys_oper_log` VALUES (149, '出入库日志', 1, 'com.ruoyi.system.controller.TextbookStockLogsController.add()', 'POST', 1, 'admin', '研发部门', '/system/logs', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-12-23\",\"logId\":1,\"notes\":\"征订申请审核通过，申请ID: 1\",\"operation\":0,\"operatorId\":1,\"params\":{},\"quantity\":1,\"relatedRequestId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:08:23', 22);
INSERT INTO `sys_oper_log` VALUES (150, '教材库存', 1, 'com.ruoyi.system.controller.TextbookInventoryController.add()', 'POST', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":1,\"params\":{},\"textbookId\":2,\"totalQuantity\":1}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'inventory_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\project\\java\\CollegeTextbookManagementSystem\\ruoyi-system\\target\\classes\\mapper\\system\\TextbookInventoryMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TextbookInventoryMapper.insertTextbookInventory-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into textbook_inventory          ( textbook_id,             total_quantity,             available_quantity )           values ( ?,             ?,             ? )\r\n### Cause: java.sql.SQLException: Field \'inventory_id\' doesn\'t have a default value\n; Field \'inventory_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'inventory_id\' doesn\'t have a default value', '2025-12-23 08:08:23', 60);
INSERT INTO `sys_oper_log` VALUES (151, '征订申请', 2, 'com.ruoyi.system.controller.TextbookOrderRequestsController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"classId\":103,\"collegeId\":101,\"courseName\":\"123\",\"params\":{},\"quantity\":\"2\",\"requestId\":3,\"reviewedAt\":\"2025-12-23\",\"reviewedBy\":1,\"status\":1,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:10:08', 6);
INSERT INTO `sys_oper_log` VALUES (152, '教材库存', 1, 'com.ruoyi.system.controller.TextbookInventoryController.add()', 'POST', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":2,\"params\":{},\"textbookId\":2,\"totalQuantity\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:10:08', 5);
INSERT INTO `sys_oper_log` VALUES (153, '出入库日志', 1, 'com.ruoyi.system.controller.TextbookStockLogsController.add()', 'POST', 1, 'admin', '研发部门', '/system/logs', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-12-23\",\"logId\":2,\"notes\":\"征订申请审核通过，申请ID: 3\",\"operation\":0,\"operatorId\":1,\"params\":{},\"quantity\":2,\"relatedRequestId\":3,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:10:08', 5);
INSERT INTO `sys_oper_log` VALUES (154, '征订申请', 2, 'com.ruoyi.system.controller.TextbookOrderRequestsController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"classId\":103,\"collegeId\":101,\"courseName\":\"12\",\"params\":{},\"quantity\":\"2\",\"requestId\":2,\"reviewedAt\":\"2025-12-23\",\"reviewedBy\":1,\"status\":0,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:11:00', 7);
INSERT INTO `sys_oper_log` VALUES (155, '征订申请', 2, 'com.ruoyi.system.controller.TextbookOrderRequestsController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"classId\":103,\"collegeId\":101,\"courseName\":\"12\",\"params\":{},\"quantity\":\"2\",\"requestId\":2,\"reviewedAt\":\"2025-12-23\",\"reviewedBy\":1,\"status\":1,\"submittedAt\":\"2025-12-22\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:11:07', 6);
INSERT INTO `sys_oper_log` VALUES (156, '教材库存', 1, 'com.ruoyi.system.controller.TextbookInventoryController.add()', 'POST', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":2,\"params\":{},\"textbookId\":2,\"totalQuantity\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:11:07', 6);
INSERT INTO `sys_oper_log` VALUES (157, '出入库日志', 1, 'com.ruoyi.system.controller.TextbookStockLogsController.add()', 'POST', 1, 'admin', '研发部门', '/system/logs', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-12-23\",\"logId\":3,\"notes\":\"征订申请审核通过，申请ID: 2\",\"operation\":0,\"operatorId\":1,\"params\":{},\"quantity\":2,\"relatedRequestId\":2,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:11:07', 6);
INSERT INTO `sys_oper_log` VALUES (158, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"山东理工大学\",\"email\":\"\",\"leader\":\"\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:33:31', 16);
INSERT INTO `sys_oper_log` VALUES (159, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"计算机科学与技术学院\",\"email\":\"\",\"leader\":\"\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"山东理工大学\",\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:33:53', 20);
INSERT INTO `sys_oper_log` VALUES (160, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"计科2201\",\"email\":\"\",\"leader\":\"\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"计算机科学与技术学院\",\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:34:12', 14);
INSERT INTO `sys_oper_log` VALUES (161, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"计科2202\",\"email\":\"\",\"leader\":\"\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"parentName\":\"计算机科学与技术学院\",\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:34:21', 11);
INSERT INTO `sys_oper_log` VALUES (162, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"计科2203\",\"email\":\"\",\"leader\":\"\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"计算机科学与技术学院\",\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:34:32', 16);
INSERT INTO `sys_oper_log` VALUES (163, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":106,\"deptName\":\"计科2204\",\"email\":\"\",\"leader\":\"\",\"orderNum\":4,\"params\":{},\"parentId\":101,\"parentName\":\"计算机科学与技术学院\",\"phone\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:34:43', 13);
INSERT INTO `sys_oper_log` VALUES (164, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/107', '127.0.0.1', '内网IP', '107', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:34:45', 15);
INSERT INTO `sys_oper_log` VALUES (165, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102', '{\"msg\":\"存在下级部门,不允许删除\",\"code\":601}', 0, NULL, '2025-12-23 08:34:47', 4);
INSERT INTO `sys_oper_log` VALUES (166, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/108', '127.0.0.1', '内网IP', '108', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:34:49', 7);
INSERT INTO `sys_oper_log` VALUES (167, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/109', '127.0.0.1', '内网IP', '109', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:34:51', 7);
INSERT INTO `sys_oper_log` VALUES (168, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/dept/102', '127.0.0.1', '内网IP', '102', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:34:52', 6);
INSERT INTO `sys_oper_log` VALUES (169, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-22 08:17:49\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"普通角色\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:37:34', 22);
INSERT INTO `sys_oper_log` VALUES (170, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-22 08:17:49\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin1\",\"roleName\":\"教材管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:37:53', 17);
INSERT INTO `sys_oper_log` VALUES (171, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2001,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037],\"params\":{},\"roleId\":100,\"roleKey\":\"admin2\",\"roleName\":\"学院管理员\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:38:12', 16);
INSERT INTO `sys_oper_log` VALUES (172, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2001,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:38:42', 14);
INSERT INTO `sys_oper_log` VALUES (173, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/notice/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:40:09', 4);
INSERT INTO `sys_oper_log` VALUES (174, '通知公告', 3, 'com.ruoyi.web.controller.system.SysNoticeController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/notice/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 08:40:10', 4);
INSERT INTO `sys_oper_log` VALUES (175, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-22 08:17:49\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,103,100,1000,1001,1002,1003,1004,1005,1006,1016,107,1035,1036,1037,1038,2000,2002,2003,2004,2005,2006,2007,2014,2015,2016,2017,2018,2019,2008,2009,2010,2011,2012,2013],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin1\",\"roleName\":\"教材管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:07:02', 121);
INSERT INTO `sys_oper_log` VALUES (176, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:12\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,103,2000,2002,2014,2008,1000,1004,1016,2003,2007,2015,2019,2009,2013,2001,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037,2020,2021,2022,2023,2024,2025],\"params\":{},\"roleId\":100,\"roleKey\":\"admin2\",\"roleName\":\"学院管理员\",\"roleSort\":0,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:08:17', 15);
INSERT INTO `sys_oper_log` VALUES (177, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:12\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":100,\"roleKey\":\"admin2\",\"roleName\":\"学院管理员\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:08:28', 7);
INSERT INTO `sys_oper_log` VALUES (178, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:12\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,103,2000,2002,2014,2008,1000,1004,1016,2003,2007,2015,2019,2009,2013,2001,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037,2020,2021,2022,2023,2024,2025],\"params\":{},\"roleId\":100,\"roleKey\":\"admin2\",\"roleName\":\"学院管理员\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:08:58', 12);
INSERT INTO `sys_oper_log` VALUES (179, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2000,2002,2003,2004,2005,2006,2007,2014,2015,2016,2017,2018,2019,2008,2009,2010,2011,2012,2013,2001,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037,2020,2021,2022,2023,2024,2025],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:09:04', 20);
INSERT INTO `sys_oper_log` VALUES (180, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,107,2000,2002,2014,2008,2001,2026,2020,1035,2003,2007,2015,2019,2009,2013,2027,2028,2031,2021,2025],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:09:59', 13);
INSERT INTO `sys_oper_log` VALUES (181, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:10:04', 8);
INSERT INTO `sys_oper_log` VALUES (182, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '研发部门', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"ccc\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:11:04', 16);
INSERT INTO `sys_oper_log` VALUES (183, '岗位管理', 3, 'com.ruoyi.web.controller.system.SysPostController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/post/1', '127.0.0.1', '内网IP', '[1]', NULL, 1, '董事长已分配,不能删除', '2025-12-23 09:11:25', 8);
INSERT INTO `sys_oper_log` VALUES (184, '岗位管理', 3, 'com.ruoyi.web.controller.system.SysPostController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/post/2', '127.0.0.1', '内网IP', '[2]', NULL, 1, '项目经理已分配,不能删除', '2025-12-23 09:11:29', 6);
INSERT INTO `sys_oper_log` VALUES (185, '岗位管理', 3, 'com.ruoyi.web.controller.system.SysPostController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/post/3', '127.0.0.1', '内网IP', '[3]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:11:31', 9);
INSERT INTO `sys_oper_log` VALUES (186, '岗位管理', 3, 'com.ruoyi.web.controller.system.SysPostController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/post/4', '127.0.0.1', '内网IP', '[4]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:11:33', 14);
INSERT INTO `sys_oper_log` VALUES (187, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-22 08:17:49\",\"flag\":false,\"params\":{},\"postCode\":\"zr\",\"postId\":2,\"postName\":\"主任\",\"postSort\":2,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:11:55', 7);
INSERT INTO `sys_oper_log` VALUES (188, '岗位管理', 2, 'com.ruoyi.web.controller.system.SysPostController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/post', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2025-12-22 08:17:49\",\"flag\":false,\"params\":{},\"postCode\":\"fdy\",\"postId\":1,\"postName\":\"辅导员\",\"postSort\":1,\"remark\":\"\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:12:08', 10);
INSERT INTO `sys_oper_log` VALUES (189, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"ry@163.com\",\"nickName\":\"ccc\",\"params\":{},\"phonenumber\":\"15888888888\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:14:46', 11);
INSERT INTO `sys_oper_log` VALUES (190, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '计算机科学与技术学院', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":100,\"nickName\":\"11\",\"params\":{},\"postIds\":[],\"roleIds\":[2],\"status\":\"0\",\"userId\":100,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:18:10', 69);
INSERT INTO `sys_oper_log` VALUES (191, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '计算机科学与技术学院', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":101,\"nickName\":\"12\",\"params\":{},\"postIds\":[],\"roleIds\":[100],\"status\":\"0\",\"userId\":101,\"userName\":\"12\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:18:21', 79);
INSERT INTO `sys_oper_log` VALUES (192, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '计算机科学与技术学院', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":103,\"nickName\":\"13\",\"params\":{},\"postIds\":[],\"roleIds\":[101],\"status\":\"0\",\"userId\":102,\"userName\":\"13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:18:53', 67);
INSERT INTO `sys_oper_log` VALUES (193, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-22 08:17:49\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,103,100,1000,1001,1002,1003,1004,1005,1006,1016,107,1035,1036,1037,1038,2000,2002,2003,2004,2005,2006,2007,2014,2015,2016,2017,2018,2019,2008,2009,2010,2011,2012,2013,2033],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin1\",\"roleName\":\"教材管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:32:50', 10);
INSERT INTO `sys_oper_log` VALUES (194, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:12\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,103,2000,2002,2014,2008,1000,1004,1016,2003,2007,2015,2019,2009,2013,2001,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037,2020,2021,2022,2023,2024,2025],\"params\":{},\"roleId\":100,\"roleKey\":\"admin2\",\"roleName\":\"学院管理员\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:32:55', 11);
INSERT INTO `sys_oper_log` VALUES (195, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,107,2000,2002,2014,2008,2001,2026,2032,2020,1035,2003,2007,2015,2019,2009,2013,2027,2028,2031,2033,2034,2037,2021,2025],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:33:14', 14);
INSERT INTO `sys_oper_log` VALUES (196, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,107,2000,2002,2014,2008,2001,2026,2032,2020,1035,2003,2007,2015,2019,2009,2013,2027,2028,2031,2033,2034,2037,2021,2025],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:34:37', 9);
INSERT INTO `sys_oper_log` VALUES (197, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-22 08:17:49\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,103,1016,107,1035,1036,1037,1038,2000,2002,2003,2004,2005,2006,2007,2014,2015,2016,2017,2018,2019,2008,2009,2010,2011,2012,2013,2032],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin1\",\"roleName\":\"教材管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:35:21', 13);
INSERT INTO `sys_oper_log` VALUES (198, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-22 08:17:49\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,103,1016,107,1035,1036,1037,1038,2000,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2027],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin1\",\"roleName\":\"教材管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:39:34', 17);
INSERT INTO `sys_oper_log` VALUES (199, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-22 08:17:49\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,103,1016,107,1035,1036,1037,1038,2000,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2026],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin1\",\"roleName\":\"教材管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:41:37', 16);
INSERT INTO `sys_oper_log` VALUES (200, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,107,2000,2002,2008,2014,2001,2020,2026,2032,1035,2003,2007,2009,2013,2015,2019,2021,2025,2027,2028,2031,2033,2034,2037],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:43:05', 10);
INSERT INTO `sys_oper_log` VALUES (201, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:12\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,103,2000,2002,2008,2014,1000,1004,1016,2003,2007,2009,2013,2015,2019,2001,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037],\"params\":{},\"roleId\":100,\"roleKey\":\"admin2\",\"roleName\":\"学院管理员\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-23 09:43:13', 11);
INSERT INTO `sys_oper_log` VALUES (202, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"教师管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"/system/teacher\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 09:25:01', 111);
INSERT INTO `sys_oper_log` VALUES (203, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-24 09:25:01\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2039,\"menuName\":\"教师管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"teacher\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 09:26:33', 10);
INSERT INTO `sys_oper_log` VALUES (204, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/teacher/index\",\"createTime\":\"2025-12-24 09:25:01\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2039,\"menuName\":\"教师管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"teacher\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 09:53:34', 21);
INSERT INTO `sys_oper_log` VALUES (205, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-22 08:17:49\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,103,1016,107,1035,1036,1037,1038,2000,2002,2003,2004,2005,2006,2007,2014,2015,2016,2017,2018,2019,2008,2009,2010,2011,2012,2013,2026,2020],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"admin1\",\"roleName\":\"教材管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:29:29', 36);
INSERT INTO `sys_oper_log` VALUES (206, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:12\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,103,2000,2002,2014,2008,1000,1004,1016,2003,2007,2015,2019,2009,2013,2001,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037,2020,2021,2022,2023,2024,2025],\"params\":{},\"roleId\":100,\"roleKey\":\"admin2\",\"roleName\":\"学院管理员\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:33:43', 11);
INSERT INTO `sys_oper_log` VALUES (207, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,107,2000,2002,2014,2008,2001,2026,2032,2020,1035,2003,2007,2015,2019,2009,2013,2027,2028,2031,2033,2034,2037,2021,2025],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:45:26', 11);
INSERT INTO `sys_oper_log` VALUES (208, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,107,2000,2002,2014,2008,2001,2026,2032,2020,100,101,103,1035,2003,2007,2015,2019,2009,2013,2027,2028,2031,2033,2034,2037,2021,2025],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:46:56', 10);
INSERT INTO `sys_oper_log` VALUES (209, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,100,101,103,107,1035,2000,2002,2003,2007,2014,2015,2019,2008,2009,2013,2001,2026,2027,2028,2031,2032,2033,2034,2037,2020,2021,2025],\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:55:12', 13);
INSERT INTO `sys_oper_log` VALUES (210, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/teacher/index\",\"createTime\":\"2025-12-24 09:25:01\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2039,\"menuName\":\"教师管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"teacher\",\"perms\":\"system:teacher:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:55:47', 32);
INSERT INTO `sys_oper_log` VALUES (211, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '计算机科学与技术学院', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"教师查询\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2039,\"perms\":\"system:teacher:seacher\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:56:19', 6);
INSERT INTO `sys_oper_log` VALUES (212, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-24 10:56:19\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2040,\"menuName\":\"教师查询\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2039,\"path\":\"\",\"perms\":\"system:teacher:query\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:56:31', 5);
INSERT INTO `sys_oper_log` VALUES (213, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '计算机科学与技术学院', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"教师新增\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":2039,\"path\":\"system:teacher:add\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:57:06', 6);
INSERT INTO `sys_oper_log` VALUES (214, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-24 10:57:06\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2041,\"menuName\":\"教师新增\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2039,\"path\":\"system:teacher:add\",\"perms\":\"system:teacher:add\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:57:20', 5);
INSERT INTO `sys_oper_log` VALUES (215, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '计算机科学与技术学院', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"教师修改\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2039,\"perms\":\"system:teacher:edit\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:57:41', 5);
INSERT INTO `sys_oper_log` VALUES (216, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '计算机科学与技术学院', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"教师删除\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2039,\"perms\":\"system:teacher:delete\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:58:02', 5);
INSERT INTO `sys_oper_log` VALUES (217, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '计算机科学与技术学院', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"教师导出\",\"menuType\":\"F\",\"orderNum\":1,\"params\":{},\"parentId\":2039,\"perms\":\"system:teacher:export\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:58:25', 5);
INSERT INTO `sys_oper_log` VALUES (218, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:12\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,103,2000,2008,2014,2002,1000,1004,2039,2040,2041,2042,2043,2044,1016,2009,2013,2015,2019,2003,2007,2001,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2038,2032,2033,2034,2035,2036,2037],\"params\":{},\"roleId\":100,\"roleKey\":\"admin2\",\"roleName\":\"学院管理员\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 10:58:44', 11);
INSERT INTO `sys_oper_log` VALUES (219, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '计算机科学与技术学院', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"4\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 11:00:19', 5);
INSERT INTO `sys_oper_log` VALUES (220, '教材库存', 2, 'com.ruoyi.system.controller.TextbookInventoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":2,\"inventoryId\":1,\"params\":{},\"textbookId\":2,\"totalQuantity\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:06:39', 16);
INSERT INTO `sys_oper_log` VALUES (221, '征订申请', 1, 'com.ruoyi.system.controller.TextbookOrderRequestsController.add()', 'POST', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"classId\":103,\"collegeId\":101,\"courseName\":\"2\",\"params\":{},\"quantity\":\"1\",\"requestId\":4,\"status\":0,\"submittedAt\":\"2025-12-24\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:27:54', 25);
INSERT INTO `sys_oper_log` VALUES (222, '征订申请', 2, 'com.ruoyi.system.controller.TextbookOrderRequestsController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/requests', '127.0.0.1', '内网IP', '{\"classId\":103,\"collegeId\":101,\"courseName\":\"2\",\"params\":{},\"quantity\":\"1\",\"requestId\":4,\"reviewedAt\":\"2025-12-24\",\"reviewedBy\":1,\"status\":1,\"submittedAt\":\"2025-12-24\",\"teacherId\":1,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:37:12', 13);
INSERT INTO `sys_oper_log` VALUES (223, '教材库存', 2, 'com.ruoyi.system.controller.TextbookInventoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":3,\"inventoryId\":2,\"params\":{},\"textbookId\":2,\"totalQuantity\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:37:12', 4);
INSERT INTO `sys_oper_log` VALUES (224, '出入库日志', 1, 'com.ruoyi.system.controller.TextbookStockLogsController.add()', 'POST', 1, 'admin', '研发部门', '/system/logs', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-12-24\",\"logId\":4,\"notes\":\"征订申请审核通过，申请ID: 4\",\"operation\":0,\"operatorId\":1,\"params\":{},\"quantity\":1,\"relatedRequestId\":4,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:37:12', 10);
INSERT INTO `sys_oper_log` VALUES (225, '教材库存', 3, 'com.ruoyi.system.controller.TextbookInventoryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/inventory/2', '127.0.0.1', '内网IP', '[2]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:37:18', 8);
INSERT INTO `sys_oper_log` VALUES (226, '教材库存', 2, 'com.ruoyi.system.controller.TextbookInventoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":2,\"inventoryId\":1,\"params\":{},\"textbookId\":2,\"totalQuantity\":6}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:39:37', 5);
INSERT INTO `sys_oper_log` VALUES (227, '教材库存', 2, 'com.ruoyi.system.controller.TextbookInventoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":2,\"inventoryId\":1,\"params\":{},\"textbookId\":2,\"totalQuantity\":9}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:39:49', 11);
INSERT INTO `sys_oper_log` VALUES (228, '教材库存', 2, 'com.ruoyi.system.controller.TextbookInventoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":2,\"inventoryId\":1,\"params\":{},\"textbookId\":2,\"totalQuantity\":5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:42:40', 11);
INSERT INTO `sys_oper_log` VALUES (229, '教材库存', 1, 'com.ruoyi.system.controller.TextbookInventoryController.add()', 'POST', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":3,\"params\":{},\"textbookId\":2,\"totalQuantity\":5}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:43:11', 5);
INSERT INTO `sys_oper_log` VALUES (230, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-12-23 08:38:42\",\"dataScope\":\"5\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":101,\"roleKey\":\"teacher\",\"roleName\":\"任课老师\",\"roleSort\":4,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:46:10', 20);
INSERT INTO `sys_oper_log` VALUES (231, '教材库存', 2, 'com.ruoyi.system.controller.TextbookInventoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":2,\"inventoryId\":1,\"params\":{},\"textbookId\":2,\"totalQuantity\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:48:50', 4);
INSERT INTO `sys_oper_log` VALUES (232, '教材库存', 1, 'com.ruoyi.system.controller.TextbookInventoryController.add()', 'POST', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":1,\"params\":{},\"textbookId\":2,\"totalQuantity\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:49:17', 3);
INSERT INTO `sys_oper_log` VALUES (233, '教材库存', 2, 'com.ruoyi.system.controller.TextbookInventoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":2,\"inventoryId\":1,\"params\":{},\"textbookId\":2,\"totalQuantity\":0}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 15:51:12', 10);
INSERT INTO `sys_oper_log` VALUES (234, '教材信息', 5, 'com.ruoyi.system.controller.TextbookBooksController.export()', 'POST', 1, 'admin', '研发部门', '/textbook/books/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-12-24 16:00:56', 916);
INSERT INTO `sys_oper_log` VALUES (235, '教材库存', 3, 'com.ruoyi.system.controller.TextbookInventoryController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/inventory/1', '127.0.0.1', '内网IP', '[1]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 16:02:01', 13);
INSERT INTO `sys_oper_log` VALUES (236, '教材库存', 2, 'com.ruoyi.system.controller.TextbookInventoryController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/inventory', '127.0.0.1', '内网IP', '{\"availableQuantity\":3,\"inventoryId\":3,\"params\":{},\"textbookId\":2,\"totalQuantity\":7}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 16:02:07', 10);
INSERT INTO `sys_oper_log` VALUES (237, '征订申请', 1, 'com.ruoyi.system.controller.TextbookOrderRequestsController.add()', 'POST', 1, '13', '计科2201', '/system/requests', '127.0.0.1', '内网IP', '{\"courseName\":\"123\",\"params\":{},\"quantity\":\"1\",\"status\":0,\"submittedAt\":\"2025-12-24\",\"teacherId\":102,\"textbookId\":2}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'college_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\project\\java\\CollegeTextbookManagementSystem\\ruoyi-system\\target\\classes\\mapper\\system\\TextbookOrderRequestsMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TextbookOrderRequestsMapper.insertTextbookOrderRequests-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into textbook_order_requests          ( teacher_id,             textbook_id,             course_name,                          quantity,             status,                          submitted_at )           values ( ?,             ?,             ?,                          ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'college_id\' doesn\'t have a default value\n; Field \'college_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'college_id\' doesn\'t have a default value', '2025-12-24 16:05:26', 112);
INSERT INTO `sys_oper_log` VALUES (238, '征订申请', 1, 'com.ruoyi.system.controller.TextbookOrderRequestsController.add()', 'POST', 1, '13', '计科2201', '/system/requests', '127.0.0.1', '内网IP', '{\"courseName\":\"123\",\"params\":{},\"quantity\":\"1\",\"status\":0,\"submittedAt\":\"2025-12-24\",\"teacherId\":102,\"textbookId\":2}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLException: Field \'college_id\' doesn\'t have a default value\r\n### The error may exist in file [D:\\project\\java\\CollegeTextbookManagementSystem\\ruoyi-system\\target\\classes\\mapper\\system\\TextbookOrderRequestsMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.TextbookOrderRequestsMapper.insertTextbookOrderRequests-Inline\r\n### The error occurred while setting parameters\r\n### SQL: insert into textbook_order_requests          ( teacher_id,             textbook_id,             course_name,                          quantity,             status,                          submitted_at )           values ( ?,             ?,             ?,                          ?,             ?,                          ? )\r\n### Cause: java.sql.SQLException: Field \'college_id\' doesn\'t have a default value\n; Field \'college_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'college_id\' doesn\'t have a default value', '2025-12-24 16:05:29', 5);
INSERT INTO `sys_oper_log` VALUES (239, '征订申请', 1, 'com.ruoyi.system.controller.TextbookOrderRequestsController.add()', 'POST', 1, '13', '计科2201', '/system/requests', '127.0.0.1', '内网IP', '{\"courseName\":\"123\",\"params\":{},\"quantity\":\"1\",\"requestId\":5,\"status\":0,\"submittedAt\":\"2025-12-24\",\"teacherId\":102,\"textbookId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-24 16:05:56', 6);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(0) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'fdy', '辅导员', 1, '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-23 09:12:08', '');
INSERT INTO `sys_post` VALUES (2, 'zr', '主任', 2, '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-23 09:11:55', '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(0) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '系统管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-12-22 08:17:49', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '教材管理员', 'admin1', 2, '1', 0, 1, '0', '0', 'admin', '2025-12-22 08:17:49', 'admin', '2025-12-24 10:29:29', '普通角色');
INSERT INTO `sys_role` VALUES (100, '学院管理员', 'admin2', 3, '4', 1, 1, '0', '0', 'admin', '2025-12-23 08:38:12', 'admin', '2025-12-24 10:58:44', NULL);
INSERT INTO `sys_role` VALUES (101, '任课老师', 'teacher', 4, '5', 0, 1, '0', '0', 'admin', '2025-12-23 08:38:42', 'admin', '2025-12-24 15:46:10', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(0) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(0) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 2000);
INSERT INTO `sys_role_menu` VALUES (2, 2002);
INSERT INTO `sys_role_menu` VALUES (2, 2003);
INSERT INTO `sys_role_menu` VALUES (2, 2004);
INSERT INTO `sys_role_menu` VALUES (2, 2005);
INSERT INTO `sys_role_menu` VALUES (2, 2006);
INSERT INTO `sys_role_menu` VALUES (2, 2007);
INSERT INTO `sys_role_menu` VALUES (2, 2008);
INSERT INTO `sys_role_menu` VALUES (2, 2009);
INSERT INTO `sys_role_menu` VALUES (2, 2010);
INSERT INTO `sys_role_menu` VALUES (2, 2011);
INSERT INTO `sys_role_menu` VALUES (2, 2012);
INSERT INTO `sys_role_menu` VALUES (2, 2013);
INSERT INTO `sys_role_menu` VALUES (2, 2014);
INSERT INTO `sys_role_menu` VALUES (2, 2015);
INSERT INTO `sys_role_menu` VALUES (2, 2016);
INSERT INTO `sys_role_menu` VALUES (2, 2017);
INSERT INTO `sys_role_menu` VALUES (2, 2018);
INSERT INTO `sys_role_menu` VALUES (2, 2019);
INSERT INTO `sys_role_menu` VALUES (2, 2020);
INSERT INTO `sys_role_menu` VALUES (2, 2026);
INSERT INTO `sys_role_menu` VALUES (100, 1);
INSERT INTO `sys_role_menu` VALUES (100, 100);
INSERT INTO `sys_role_menu` VALUES (100, 103);
INSERT INTO `sys_role_menu` VALUES (100, 1000);
INSERT INTO `sys_role_menu` VALUES (100, 1004);
INSERT INTO `sys_role_menu` VALUES (100, 1016);
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2001);
INSERT INTO `sys_role_menu` VALUES (100, 2002);
INSERT INTO `sys_role_menu` VALUES (100, 2003);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (100, 2009);
INSERT INTO `sys_role_menu` VALUES (100, 2013);
INSERT INTO `sys_role_menu` VALUES (100, 2014);
INSERT INTO `sys_role_menu` VALUES (100, 2015);
INSERT INTO `sys_role_menu` VALUES (100, 2019);
INSERT INTO `sys_role_menu` VALUES (100, 2020);
INSERT INTO `sys_role_menu` VALUES (100, 2021);
INSERT INTO `sys_role_menu` VALUES (100, 2022);
INSERT INTO `sys_role_menu` VALUES (100, 2023);
INSERT INTO `sys_role_menu` VALUES (100, 2024);
INSERT INTO `sys_role_menu` VALUES (100, 2025);
INSERT INTO `sys_role_menu` VALUES (100, 2026);
INSERT INTO `sys_role_menu` VALUES (100, 2027);
INSERT INTO `sys_role_menu` VALUES (100, 2028);
INSERT INTO `sys_role_menu` VALUES (100, 2029);
INSERT INTO `sys_role_menu` VALUES (100, 2030);
INSERT INTO `sys_role_menu` VALUES (100, 2031);
INSERT INTO `sys_role_menu` VALUES (100, 2032);
INSERT INTO `sys_role_menu` VALUES (100, 2033);
INSERT INTO `sys_role_menu` VALUES (100, 2034);
INSERT INTO `sys_role_menu` VALUES (100, 2035);
INSERT INTO `sys_role_menu` VALUES (100, 2036);
INSERT INTO `sys_role_menu` VALUES (100, 2037);
INSERT INTO `sys_role_menu` VALUES (100, 2038);
INSERT INTO `sys_role_menu` VALUES (100, 2039);
INSERT INTO `sys_role_menu` VALUES (100, 2040);
INSERT INTO `sys_role_menu` VALUES (100, 2041);
INSERT INTO `sys_role_menu` VALUES (100, 2042);
INSERT INTO `sys_role_menu` VALUES (100, 2043);
INSERT INTO `sys_role_menu` VALUES (100, 2044);
INSERT INTO `sys_role_menu` VALUES (101, 1);
INSERT INTO `sys_role_menu` VALUES (101, 100);
INSERT INTO `sys_role_menu` VALUES (101, 101);
INSERT INTO `sys_role_menu` VALUES (101, 103);
INSERT INTO `sys_role_menu` VALUES (101, 107);
INSERT INTO `sys_role_menu` VALUES (101, 1035);
INSERT INTO `sys_role_menu` VALUES (101, 2000);
INSERT INTO `sys_role_menu` VALUES (101, 2001);
INSERT INTO `sys_role_menu` VALUES (101, 2002);
INSERT INTO `sys_role_menu` VALUES (101, 2003);
INSERT INTO `sys_role_menu` VALUES (101, 2007);
INSERT INTO `sys_role_menu` VALUES (101, 2008);
INSERT INTO `sys_role_menu` VALUES (101, 2009);
INSERT INTO `sys_role_menu` VALUES (101, 2013);
INSERT INTO `sys_role_menu` VALUES (101, 2014);
INSERT INTO `sys_role_menu` VALUES (101, 2015);
INSERT INTO `sys_role_menu` VALUES (101, 2019);
INSERT INTO `sys_role_menu` VALUES (101, 2020);
INSERT INTO `sys_role_menu` VALUES (101, 2021);
INSERT INTO `sys_role_menu` VALUES (101, 2025);
INSERT INTO `sys_role_menu` VALUES (101, 2026);
INSERT INTO `sys_role_menu` VALUES (101, 2027);
INSERT INTO `sys_role_menu` VALUES (101, 2028);
INSERT INTO `sys_role_menu` VALUES (101, 2031);
INSERT INTO `sys_role_menu` VALUES (101, 2032);
INSERT INTO `sys_role_menu` VALUES (101, 2033);
INSERT INTO `sys_role_menu` VALUES (101, 2034);
INSERT INTO `sys_role_menu` VALUES (101, 2037);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(0) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime(0) DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '创建者',
  `create_time` datetime(0) DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '更新者',
  `update_time` datetime(0) DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 101, 'admin', 'ccc', '00', 'ry@163.com', '15888888888', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-12-24 11:00:30', '2025-12-22 08:17:49', 'admin', '2025-12-22 08:17:49', '', '2025-12-24 11:00:29', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', 'ccc', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-12-22 08:17:49', '2025-12-22 08:17:49', 'admin', '2025-12-22 08:17:49', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (100, 100, '11', '11', '00', '', '', '0', '', '$2a$10$E4Ll4pSKVot0E1CwuCSDj.dYbTzCbTgzHS5UgxuVwyS7bHhmEahSe', '0', '0', '127.0.0.1', '2025-12-24 10:29:37', NULL, 'admin', '2025-12-23 09:18:10', '', '2025-12-24 10:29:36', NULL);
INSERT INTO `sys_user` VALUES (101, 101, '12', '12', '00', '', '', '0', '', '$2a$10$Lk98Xyv2BhsozQXp6.lDA.SkHfBRKeduJl5ZbmYbCJuVT2Rab.20e', '0', '0', '127.0.0.1', '2025-12-24 10:36:35', NULL, 'admin', '2025-12-23 09:18:21', '', '2025-12-24 10:36:35', NULL);
INSERT INTO `sys_user` VALUES (102, 103, '13', '13', '00', '', '', '0', '', '$2a$10$/AB6VvoBva8DeaJW/r/vFOzgxhNPQH/SD7W.Fri6V0x21I.F0/zQm', '0', '0', '127.0.0.1', '2025-12-24 16:03:49', NULL, 'admin', '2025-12-23 09:18:53', '', '2025-12-24 16:03:49', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `post_id` bigint(0) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(0) NOT NULL COMMENT '用户ID',
  `role_id` bigint(0) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 2);
INSERT INTO `sys_user_role` VALUES (101, 100);
INSERT INTO `sys_user_role` VALUES (102, 101);

-- ----------------------------
-- Table structure for textbook_books
-- ----------------------------
DROP TABLE IF EXISTS `textbook_books`;
CREATE TABLE `textbook_books`  (
  `textbook_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '教材ID',
  `picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '图片',
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'ISBN',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教材名称',
  `author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '作者',
  `publisher_id` int(0) NOT NULL COMMENT '出版社',
  `category_id` int(0) NOT NULL COMMENT '教材类型',
  `edition` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '版次（如 第3版）',
  `price` decimal(10, 2) NOT NULL COMMENT '定价',
  `created_by` int(0) DEFAULT NULL COMMENT '添加人',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`textbook_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of textbook_books
-- ----------------------------
INSERT INTO `textbook_books` VALUES (2, NULL, 'ISBN1234567890', '1', '1', 1, 1, '1', 1.00, 1, '2025-12-22 00:00:00');

-- ----------------------------
-- Table structure for textbook_categories
-- ----------------------------
DROP TABLE IF EXISTS `textbook_categories`;
CREATE TABLE `textbook_categories`  (
  `category_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of textbook_categories
-- ----------------------------
INSERT INTO `textbook_categories` VALUES (1, '100');
INSERT INTO `textbook_categories` VALUES (2, '200');
INSERT INTO `textbook_categories` VALUES (3, '300');

-- ----------------------------
-- Table structure for textbook_inventory
-- ----------------------------
DROP TABLE IF EXISTS `textbook_inventory`;
CREATE TABLE `textbook_inventory`  (
  `inventory_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '库存记录ID',
  `textbook_id` int(0) DEFAULT NULL COMMENT '教材',
  `total_quantity` int(0) DEFAULT NULL COMMENT '总数量',
  `available_quantity` int(0) DEFAULT NULL COMMENT '可领用数量',
  PRIMARY KEY (`inventory_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of textbook_inventory
-- ----------------------------
INSERT INTO `textbook_inventory` VALUES (3, 2, 7, 3);
INSERT INTO `textbook_inventory` VALUES (4, 2, 3, 1);

-- ----------------------------
-- Table structure for textbook_order_requests
-- ----------------------------
DROP TABLE IF EXISTS `textbook_order_requests`;
CREATE TABLE `textbook_order_requests`  (
  `request_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '申请ID',
  `teacher_id` int(0) NOT NULL COMMENT '申请人',
  `textbook_id` int(0) NOT NULL COMMENT '申请教材',
  `course_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名称',
  `class_id` int(0) DEFAULT NULL COMMENT '授课班级',
  `quantity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '申请数量',
  `status` int(0) DEFAULT NULL COMMENT '状态',
  `college_id` int(0) DEFAULT NULL COMMENT '所属学院',
  `submitted_at` datetime(0) DEFAULT NULL COMMENT '提交时间',
  `reviewed_by` int(0) DEFAULT NULL COMMENT '审核人',
  `reviewed_at` datetime(0) DEFAULT NULL COMMENT '审核时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '审核意见',
  PRIMARY KEY (`request_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of textbook_order_requests
-- ----------------------------
INSERT INTO `textbook_order_requests` VALUES (1, 1, 2, '2', NULL, '1', 1, 101, '2025-12-22 00:00:00', 1, '2025-12-23 00:00:00', NULL);
INSERT INTO `textbook_order_requests` VALUES (2, 1, 2, '12', 103, '2', 1, 101, '2025-12-22 00:00:00', 1, '2025-12-23 00:00:00', NULL);
INSERT INTO `textbook_order_requests` VALUES (3, 1, 2, '123', 103, '2', 1, 101, '2025-12-22 00:00:00', 1, '2025-12-23 00:00:00', NULL);
INSERT INTO `textbook_order_requests` VALUES (4, 1, 2, '2', 103, '1', 1, 101, '2025-12-24 00:00:00', 1, '2025-12-24 00:00:00', NULL);
INSERT INTO `textbook_order_requests` VALUES (5, 102, 2, '123', NULL, '1', 0, NULL, '2025-12-24 00:00:00', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for textbook_publishers
-- ----------------------------
DROP TABLE IF EXISTS `textbook_publishers`;
CREATE TABLE `textbook_publishers`  (
  `publisher_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '出版社ID',
  `publisher_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '出版社名称',
  `contact_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '联系方式',
  PRIMARY KEY (`publisher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of textbook_publishers
-- ----------------------------
INSERT INTO `textbook_publishers` VALUES (1, '001', NULL);
INSERT INTO `textbook_publishers` VALUES (2, '002', NULL);
INSERT INTO `textbook_publishers` VALUES (3, '003', NULL);

-- ----------------------------
-- Table structure for textbook_stock_logs
-- ----------------------------
DROP TABLE IF EXISTS `textbook_stock_logs`;
CREATE TABLE `textbook_stock_logs`  (
  `log_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `textbook_id` int(0) NOT NULL COMMENT '教材',
  `operation` int(0) NOT NULL COMMENT '操作类型',
  `quantity` int(0) DEFAULT NULL COMMENT '数量',
  `operator_id` int(0) DEFAULT NULL COMMENT '操作人',
  `related_request_id` int(0) DEFAULT NULL COMMENT '征订申请',
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `created_at` datetime(0) DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of textbook_stock_logs
-- ----------------------------
INSERT INTO `textbook_stock_logs` VALUES (1, 2, 0, 1, 1, 1, '征订申请审核通过，申请ID: 1', '2025-12-23 00:00:00');
INSERT INTO `textbook_stock_logs` VALUES (2, 2, 0, 2, 1, 3, '征订申请审核通过，申请ID: 3', '2025-12-23 00:00:00');
INSERT INTO `textbook_stock_logs` VALUES (3, 2, 0, 2, 1, 2, '征订申请审核通过，申请ID: 2', '2025-12-23 00:00:00');
INSERT INTO `textbook_stock_logs` VALUES (4, 2, 0, 1, 1, 4, '征订申请审核通过，申请ID: 4', '2025-12-24 00:00:00');

SET FOREIGN_KEY_CHECKS = 1;
