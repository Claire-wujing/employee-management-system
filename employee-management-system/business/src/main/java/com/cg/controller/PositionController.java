package com.cg.controller;

import com.cg.entity.Position;
import com.cg.service.EmployeeService;
import com.cg.service.PositionService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

//岗位控制器
@Controller
@RequestMapping("/position")
public class PositionController {

    @Autowired
    private PositionService positionService ;

    @Autowired
    EmployeeService employeeService;


    @RequestMapping(value = "/List")
    public String position(HttpServletRequest request, Model model){
        // 获取所有岗位列表
        List<Position> positionList= positionService.positionList("","",null);
        request.getSession().setAttribute("positionList", positionList);
        return "position";
    }


    @RequestMapping(value = "/add")
    public String add(HttpServletRequest request, Model model){
        return "addPosition";
    }
    @RequestMapping(value = "/addPosition")
    public String addPosition(@RequestParam("positionName") String positionName,@RequestParam("code") String code, Model model){
        // 检查岗位名称是否已存在
        Position one=positionService.findPositionByName(positionName);
        if(one==null){
            positionService.addposition(positionName,code);
            return "redirect:/position/List";
        }else {
            model.addAttribute("positionError", "岗位已存在");
            return "position";
        }
    }

    @RequestMapping(value = "/updatePosition")
    public String editPosition(@RequestParam("positionId") Integer positionId,HttpServletRequest request) {
        // 根据ID获取岗位信息
        Position position =  positionService.findPositionById(positionId);
        request.getSession().setAttribute("position", position);
        return "editPosition";
    }

    @RequestMapping(value = "/doUpdatePosition")
    public String editposition(HttpServletRequest request,@RequestParam("positionName") String positionName,
                               @RequestParam("status") Integer status,
                               @RequestParam("code") String code,
                               @RequestParam("positionId") Integer positionId,Model model){
        // 检查岗位名称是否存在
        int one = positionService.findByName(positionName,positionId);
        System.out.println("一共找到："+one);
        if (one==0){
            // 更新岗位信息
            positionService.editPosition(positionName,status,code,positionId);
            return "redirect:/position/List";
        }else{
            model.addAttribute("positionError", "该岗位已存在");
            return "position";
        }
    }

    @RequestMapping(value = "/deletePosition")
    public String deletePosition(@RequestParam("positionId") Integer positionId, Model model) {
        // 检查岗位下是否有员工
        int one = employeeService.findEmployeeByPosition(positionId);
        if(one == 0){
            positionService.deleteposition(positionId);
            return "redirect:/position/List";
        }else{
            model.addAttribute("positionError", "该岗位下有员工！！！");
            return "position";
        }
    }

    @RequestMapping("/searchPosition")
    public String searchEvents(@RequestParam(value = "positionName", required = false) String positionName,
                               @RequestParam(value = "code", required = false) String code,
                               @RequestParam(value = "status", required = false) Integer status, HttpServletRequest request) {
        // 根据条件搜索岗位列表
        List<Position> positionList = positionService.positionList(code,positionName,status);
        request.getSession().setAttribute("positionList", positionList);
        return "position";
    }
}
