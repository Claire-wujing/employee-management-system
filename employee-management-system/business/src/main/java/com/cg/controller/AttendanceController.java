package com.cg.controller;

import com.cg.entity.Attendance;
import com.cg.entity.Employee;
import com.cg.entity.User;
import com.cg.service.AttendanceService;
import com.cg.service.EmployeeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

//考勤控制器
@Controller
@RequestMapping("/attendance")
public class AttendanceController {

    @Autowired
    AttendanceService attendanceService;
    @Autowired
    EmployeeService employeeService;
    @RequestMapping("/Clock")
    public String Clock(HttpServletRequest request) {
        return "Clock";
    }

    @RequestMapping("/addClock")
    public String doClock(HttpServletRequest request,
                          @RequestParam("date") String date,
                          @RequestParam("checkInTime") String checkInTime,
                          @RequestParam("checkOutTime") String checkOutTime,
                          @RequestParam("state") Integer status,
                          Model model) {
        // 获取当前登录用户
        User user = (User) request.getSession().getAttribute("user");
        Integer userId = user.getId();
        Employee employee = employeeService.findEmployeeByUserId(userId);
        Integer employeeId = employee.getEmployeeId();
        Integer departmentId = employee.getDepartmentId();

        System.out.println(checkInTime + " " + checkOutTime);

        Attendance one = attendanceService.findAttendance(date, employeeId);
        if (one == null) {
            attendanceService.addAttendance(date, checkInTime, checkOutTime, status, employeeId, departmentId);
            model.addAttribute("message", "打卡成功");
        } else {
            // 已打卡提示
            model.addAttribute("message", "今天已经打卡完成了");
        }

        return "Clock";
    }

    @RequestMapping(value = "/List")
    public String attendance(HttpServletRequest request, Model model) {
        // 获取当前登录用户并提取部门ID（管理员）
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId = user.getDepartmentId();

        List<Employee> employeeList = employeeService.employeeList("", "", null, departmentId);
        List<Attendance> attendanceList = attendanceService.attendanceList(null, null, departmentId);

        // 将数据存入 session 中供前端使用
        request.getSession().setAttribute("attendanceList", attendanceList);
        request.getSession().setAttribute("employeeList", employeeList);

        return "attendance";
    }
    @RequestMapping("/searchAttendance")//查询考勤记录
    public String searchDepartment(@RequestParam(value = "date", required = false) String date,
                                   @RequestParam(value = "state", required = false) Integer state,
                                   HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId = user.getDepartmentId();
        List<Attendance> attendanceList = attendanceService.attendanceList(date, state, departmentId);// 条件查询考勤记录
        request.getSession().setAttribute("attendanceList", attendanceList);// 更新 session 中的考勤记录

        return "attendance";
    }
}
