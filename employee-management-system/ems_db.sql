SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for yk_attendance
-- ----------------------------
DROP TABLE IF EXISTS `yk_attendance`;
CREATE TABLE `yk_attendance` (
  `attendance_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `check_in_time` time DEFAULT NULL,
  `check_out_time` time DEFAULT NULL,
  `state` int(11) NOT NULL COMMENT '0-正常打卡 1-迟到 2-早退 ',
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`attendance_id`) USING BTREE,
  KEY `employee_id` (`employee_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yk_attendance
-- ----------------------------
INSERT INTO `yk_attendance` VALUES ('1', '2', '2025-01-03', '08:42:49', '20:42:58', '0', '2');
INSERT INTO `yk_attendance` VALUES ('2', '3', '2025-01-03', '08:42:01', '20:42:07', '0', '5');
INSERT INTO `yk_attendance` VALUES ('6', '1', '2025-01-03', '08:06:06', '21:06:07', '0', '1');
INSERT INTO `yk_attendance` VALUES ('8', '1', '2025-01-05', '08:13:40', '21:13:48', '0', '1');
INSERT INTO `yk_attendance` VALUES ('9', '2', '2025-01-05', '08:14:23', '21:14:28', '0', '2');
INSERT INTO `yk_attendance` VALUES ('10', '3', '2025-01-05', '08:17:42', '21:17:49', '0', '5');
INSERT INTO `yk_attendance` VALUES ('11', '4', '2025-01-06', '08:56:31', '21:56:35', '0', '1');
INSERT INTO `yk_attendance` VALUES ('12', '1', '2025-01-06', '11:47:17', '11:47:18', '2', '1');
INSERT INTO `yk_attendance` VALUES ('13', '6', '2025-01-07', '09:34:33', '21:34:49', '0', '1');
INSERT INTO `yk_attendance` VALUES ('15', '1', '2025-01-07', '11:17:34', '11:17:35', '2', '1');

-- ----------------------------
-- Table structure for yk_department
-- ----------------------------
DROP TABLE IF EXISTS `yk_department`;
CREATE TABLE `yk_department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) NOT NULL,
  `department_code` varchar(255) DEFAULT NULL COMMENT '部门编码',
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yk_department
-- ----------------------------
INSERT INTO `yk_department` VALUES ('1', '研发部', 'RD001', '2024-12-31 11:15:40');
INSERT INTO `yk_department` VALUES ('2', '测试部', 'QA001', '2025-01-02 11:49:57');
INSERT INTO `yk_department` VALUES ('5', '运维部', 'OP001', '2025-01-07 09:49:41');
INSERT INTO `yk_department` VALUES ('6', '市场部', 'MD001', '2025-01-07 11:15:41');
-- ----------------------------
-- Table structure for yk_employee
-- ----------------------------
DROP TABLE IF EXISTS `yk_employee`;
CREATE TABLE `yk_employee` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(255) NOT NULL COMMENT '员工名字',
  `phone` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `hire_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `position_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`employee_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yk_employee
-- ----------------------------
INSERT INTO `yk_employee` VALUES ('1', '张三', '13512365066', '2', '1', '2025-01-02', '0', '5', 'zhangsan@example.com');
INSERT INTO `yk_employee` VALUES ('2', '李四', '13898765432', '6', '2', '2025-01-02', '0', '1', 'lisi@example.com');
INSERT INTO `yk_employee` VALUES ('3', '王五', '13912345678', '7', '5', '2025-01-03', '0', '4', 'wangwu@example.com');
INSERT INTO `yk_employee` VALUES ('4', '赵六', '13787654321', '9', '1', '2025-01-05', '0', '1', 'zhaoliu@example.com');
INSERT INTO `yk_employee` VALUES ('5', '钱七', '13611112222', '10', '1', '2025-01-07', '1', '1', 'qianqi@example.com');
INSERT INTO `yk_employee` VALUES ('6', '孙八', '13433334444', '11', '1', '2025-01-06', '0', '1', 'sunba@example.com');

-- ----------------------------
-- Table structure for yk_leave
-- ----------------------------
DROP TABLE IF EXISTS `yk_leave`;
CREATE TABLE `yk_leave` (
  `leave_id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `leave_type` int(11) NOT NULL COMMENT '请假类型',
  `start_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `status` int(11) NOT NULL COMMENT '请假状态',
  `reason` text,
  `cheack_name` varchar(255) DEFAULT NULL COMMENT '审批人',
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`leave_id`) USING BTREE,
  KEY `employee_id` (`employee_id`) USING BTREE,
  CONSTRAINT `yk_leave_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `yk_employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yk_leave
-- ----------------------------
INSERT INTO `yk_leave` VALUES ('1', '1', '2', '2025-01-02 00:00:00', '2025-01-04 00:00:00', '1', '年假申请', '王经理', '1');
INSERT INTO `yk_leave` VALUES ('2', '2', '1', '2025-01-02 23:24:57', '2025-01-04 23:25:01', '2', '病假证明已提交', '李主管', '2');
INSERT INTO `yk_leave` VALUES ('7', '3', '0', '2025-01-04 09:39:00', '2025-01-12 09:39:00', '1', '家中有事', '张总监', '5');
INSERT INTO `yk_leave` VALUES ('8', '6', '1', '2025-01-07 10:31:17', '2025-01-10 10:31:19', '0', '感冒需休息', null, '1');
INSERT INTO `yk_leave` VALUES ('9', '1', '2', '2025-01-11 11:19:00', '2025-01-18 11:19:00', '0', '年假申请', null, '1');

-- ----------------------------
-- Table structure for yk_position
-- ----------------------------
DROP TABLE IF EXISTS `yk_position`;
CREATE TABLE `yk_position` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `position_name` varchar(255) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '1--正常  0--异常',
  `code` varchar(255) DEFAULT NULL COMMENT '岗位编码',
  PRIMARY KEY (`position_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yk_position
-- ----------------------------
INSERT INTO `yk_position` VALUES ('1', '测试工程师', '2025-01-01 21:37:32', '1', 'TE');
INSERT INTO `yk_position` VALUES ('4', '运维工程师', '2025-01-02 10:05:26', '1', 'OE');
INSERT INTO `yk_position` VALUES ('5', '开发工程师', '2025-01-02 10:24:29', '1', 'DE');
INSERT INTO `yk_position` VALUES ('6', '前端工程师', '2025-01-07 09:53:06', '1', 'FE');
INSERT INTO `yk_position` VALUES ('7', '产品经理', '2025-01-07 09:53:45', '1', 'PM');

-- ----------------------------
-- Table structure for yk_user
-- ----------------------------
DROP TABLE IF EXISTS `yk_user`;
CREATE TABLE `yk_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` int(11) NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of yk_user
-- ----------------------------
INSERT INTO `yk_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'admin@example.com', '3', null);
INSERT INTO `yk_user` VALUES ('2', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', 'zhangsan@example.com', '1', null);
INSERT INTO `yk_user` VALUES ('6', 'lisi', 'e10adc3949ba59abbe56e057f20f883e', 'lisi@example.com', '1', null);
INSERT INTO `yk_user` VALUES ('7', 'wangwu', 'e10adc3949ba59abbe56e057f20f883e', 'wangwu@example.com', '1', null);
INSERT INTO `yk_user` VALUES ('8', 'manager', 'e10adc3949ba59abbe56e057f20f883e', 'manager@example.com', '2', '1');
INSERT INTO `yk_user` VALUES ('9', 'zhaoliu', 'e10adc3949ba59abbe56e057f20f883e', 'zhaoliu@example.com', '1', null);
INSERT INTO `yk_user` VALUES ('10', 'qianqi', 'e10adc3949ba59abbe56e057f20f883e', 'qianqi@example.com', '1', null);
INSERT INTO `yk_user` VALUES ('11', 'sunba', 'e10adc3949ba59abbe56e057f20f883e', 'sunba@example.com', '1', null);
