package com.cg.controller;

import com.cg.entity.Employee;
import com.cg.entity.Leave;
import com.cg.entity.User;
import com.cg.service.EmployeeService;
import com.cg.service.LeaveService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/leave")
public class LeaveController {
    @Autowired
    LeaveService leaveService;

    @Autowired
    EmployeeService employeeService;


     //显示请假列表页面
    @RequestMapping(value = "/List")
    public String leave(HttpServletRequest request, Model model){
        // 获取当前用户信息
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId=user.getDepartmentId();
        // 获取请假列表并存储到session
        List<Leave> leaveList= leaveService.leaveList(null,null,null,departmentId);
        request.getSession().setAttribute("leaveList", leaveList);
        // 获取员工列表并存储到session
        List<Employee> employeeList= employeeService.employeeList("","",null,departmentId);
        request.getSession().setAttribute("employeeList", employeeList);
        return "leave";
    }


    @RequestMapping(value = "/updateLeave")
    public String updateLeave(HttpServletRequest request,
                              @RequestParam("leaveId") Integer leaveId,
                              @RequestParam("status") Integer status){

        User user = (User) request.getSession().getAttribute("user");
        leaveService.editLeave(leaveId,status,user.getUsername());
        return "redirect:/leave/List";
    }
    //根据用户的部门ID查询请假信息
    @RequestMapping("/searchLeave")
    public String searchLeave(@RequestParam(value = "leaveType", required = false) Integer leaveType,
                               @RequestParam(value = "status", required = false) Integer status, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer departmentId=user.getDepartmentId();
        List<Leave> leavaeList = leaveService.leaveList(leaveType,status,null,departmentId);
        request.getSession().setAttribute("leaveList", leavaeList);
        return "leave";
    }


     //显示请假详细信息
    @RequestMapping("/detailLeave")
    public String detailLeave(HttpServletRequest request,@RequestParam("leaveId") Integer leaveId) {
        Leave leave = leaveService.findLeaveById(leaveId);
        request.getSession().setAttribute("leave", leave);
        return "detailLeave";
    }

    //显示员工请假记录页面
    @RequestMapping("/employeeLeave")
    public String employeeLeave(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer userId = user.getId();
        Employee employee =  employeeService.findEmployeeByUserId(userId);
        request.getSession().setAttribute("employee", employee);
        return "employeeLeave";
    }

//显示添加请假记录页面
    @RequestMapping("/addLeave")
    public String addLeave(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer userId = user.getId();
        Employee employee =  employeeService.findEmployeeByUserId(userId);
        request.getSession().setAttribute("employee", employee);
        return "addLeave";
    }


     //处理添加请假记录请求
    @RequestMapping("/doAddLeave")
    public String doAddLeave(HttpServletRequest request,@RequestParam("employeeId") Integer employeeId
            ,@RequestParam("leaveType") Integer leaveType
            ,@RequestParam("startDate") String startDate
            ,@RequestParam("endDate") String endDate
            ,@RequestParam("reason") String reason)
    {
        Integer status = 0;
        User user = (User) request.getSession().getAttribute("user");
        Integer userId = user.getId();
        Employee employee =  employeeService.findEmployeeByUserId(userId);
        //从员工对象中获取所属部门ID，用于后续添加请假记录时关联部门信息。
        Integer departmentId = employee.getDepartmentId();
        leaveService.addLeave(employeeId,leaveType,startDate,endDate,reason,status,departmentId);
        return "employeeLeave";
    }

     //显示请假历史记录页面

    @RequestMapping("/History")
    public String History(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        Integer userId = user.getId();
        Integer departmentId=user.getDepartmentId();
        Employee employee =  employeeService.findEmployeeByUserId(userId);
        Integer employeeId= employee.getEmployeeId();
        List<Leave> leaveList= leaveService.leaveList(null,null,employeeId,departmentId);

        request.getSession().setAttribute("leaveList", leaveList);
        return "HistoryLeave";
    }


    @RequestMapping(value = "/delete")
    public String deleteDepartment(@RequestParam("leaveId") Integer leaveId) {
        leaveService.deleteLeave(leaveId);
        return "redirect:/leave/employeeLeave";
    }
}
