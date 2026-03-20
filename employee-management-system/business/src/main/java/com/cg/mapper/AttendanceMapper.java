package com.cg.mapper;

import com.cg.entity.Attendance;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import java.util.List;

/**
 * AttendanceMapper接口用于处理考勤数据的相关操作
 * 它定义了如何与数据库中的考勤表进行交互，包括添加考勤记录、查找特定员工的考勤记录等
 */
@Mapper
public interface AttendanceMapper {
    @Insert("insert into yk_attendance(date, check_in_time, check_out_time, state,employee_id,department_id)values (#{date},#{checkInTime},#{checkOutTime},#{status},#{employeeId},#{departmentId})")
    void addAttendance(@Param("date")String date,@Param("checkInTime") String checkInTime, @Param("checkOutTime")String checkOutTime,@Param("status") Integer status,@Param("employeeId") Integer employeeId,@Param("departmentId") Integer departmentId);

    @Select("select * from yk_attendance where employee_id=#{employeeId} and date =#{date} ")
    Attendance findAttendance(@Param("date")String date,@Param("employeeId") Integer employeeId);

    List<Attendance> attendanceList(@Param("date")String date , @Param("state")Integer state,@Param("departmentId")Integer departmentId);
}
