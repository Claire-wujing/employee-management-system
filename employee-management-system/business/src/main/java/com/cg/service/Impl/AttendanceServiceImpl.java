package com.cg.service.Impl;

import com.cg.entity.Attendance;
import com.cg.mapper.AttendanceMapper;
import com.cg.service.AttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 考勤服务实现类，提供对考勤数据的业务逻辑处理。
 * 实现了添加考勤记录、查询单条记录以及查询列表的功能。
 */
@Service
public class AttendanceServiceImpl implements AttendanceService {

    /**
     * 注入考勤数据访问层，用于与数据库交互。
     */
    @Autowired
    private AttendanceMapper attendanceMapper;

    /**
     * 添加一条考勤记录。
     *
     * @param date 日期（格式：yyyy-MM-dd）
     * @param checkInTime 上班打卡时间（格式：HH:mm:ss）
     * @param checkOutTime 下班打卡时间（格式：HH:mm:ss）
     * @param status 状态（如正常、迟到、早退等）
     * @param employeeId 员工ID
     * @param departmentId 部门ID
     */
    @Override
    public void addAttendance(String date, String checkInTime, String checkOutTime, Integer status, Integer employeeId, Integer departmentId) {
        // 调用 Mapper 层将数据插入到数据库
        attendanceMapper.addAttendance(date, checkInTime, checkOutTime, status, employeeId, departmentId);
    }

    /**
     * 根据日期和员工ID查找考勤记录。
     *
     * @param date 日期（格式：yyyy-MM-dd）
     * @param employeeId 员工ID
     * @return 返回匹配的考勤记录对象，若无则返回 null
     */
    @Override
    public Attendance findAttendance(String date, Integer employeeId) {
        // 查询指定员工在指定日期的考勤记录
        return attendanceMapper.findAttendance(date, employeeId);
    }

    /**
     * 查询考勤记录列表，支持按日期和部门筛选。
     *
     * @param date 可选参数，指定查询日期
     * @param attendanceId 可选参数（当前未使用）
     * @param departmentId 部门ID，用于限制查询范围
     * @return 返回符合条件的考勤记录列表
     */
    @Override
    public List<Attendance> attendanceList(String date, Integer attendanceId, Integer departmentId) {
        // 调用 Mapper 查询符合筛选条件的考勤记录
        return attendanceMapper.attendanceList(date, attendanceId, departmentId);
    }
}
