package com.cg.controller;

import com.cg.entity.Department;
import com.cg.service.DepartmentService;
import com.cg.service.EmployeeService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
//部门管理
@Controller
@RequestMapping("/department")
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;


     //注入员工服务类，用于判断部门是否可以被删除（是否存在关联员工）。
    @Autowired
    private EmployeeService employeeService;
    @RequestMapping(value = "/List")
    public String department(HttpServletRequest request, Model model) {
        List<Department> departmentList = departmentService.departmentList("", "");
        request.getSession().setAttribute("departmentList", departmentList);
        return "department";
    }

    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model) {
        return "addDepartment";
    }
    @RequestMapping(value = "/addDepartment")
    public String addPosition(@RequestParam("departmentName") String departmentName,
                              @RequestParam("departmentCode") String departmentCode,
                              Model model) {
        // 根据部门名称检查是否已存在
        Department one = departmentService.findDepartmentByName(departmentName);
        if (one == null) {
            departmentService.addDepartment(departmentName, departmentCode);
            return "redirect:/department/List";
        } else {
            model.addAttribute("departmentError", "部门已存在");
            return "department";
        }
    }

    @RequestMapping(value = "/updateDepartment")
    public String editDepartment(@RequestParam("departmentId") Integer departmentId,
                                 HttpServletRequest request) {
        // 根据部门ID查询部门信息
        Department department = departmentService.findDepartmentById(departmentId);
        // 将部门信息存入 session，供编辑页面使用
        request.getSession().setAttribute("department", department);
        return "editDepartment";
    }
    //跳转至编辑界面
    @RequestMapping(value = "/doUpdateDepartment")
    public String editdepartment(HttpServletRequest request,
                                 @RequestParam("departmentName") String departmentName,
                                 @RequestParam("departmentCode") String departmentCode,
                                 @RequestParam("departmentId") Integer departmentId,
                                 Model model) {
        // 检查该名称是否已被其他部门占用
        int one = departmentService.findByName(departmentName, departmentId);
        System.out.println("一共找到：" + one);

        if (one == 0) {
            departmentService.editDepartment(departmentName, departmentCode, departmentId);
            return "redirect:/department/List";
        } else {
            model.addAttribute("departmentError", "该部门已存在");
            return "department";
        }
    }

    @RequestMapping(value = "/deleteDepartment")
    public String deleteDepartment(@RequestParam("departmentId") Integer departmentId,
                                   Model model) {
        // 检查该部门下是否有员工
        int one = employeeService.findEmployeeByDepartment(departmentId);
        if (one == 0) {
            departmentService.deleteDepartment(departmentId);
            return "redirect:/department/List";
        } else {
            model.addAttribute("departmentError", "该部门下有员工！！！");
            return "department";
        }
    }

    @RequestMapping("/searchDepartment")
    public String searchDepartment(@RequestParam(value = "departmentName", required = false) String departmentName,
                                   @RequestParam(value = "departmentCode", required = false) String departmentCode,
                                   HttpServletRequest request) {
        // 根据条件查询部门列表
        List<Department> departmentList = departmentService.departmentList(departmentName, departmentCode);
        request.getSession().setAttribute("departmentList", departmentList);
        return "department";
    }
}
