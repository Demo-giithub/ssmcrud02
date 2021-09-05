package com.meng.controller;

import com.meng.bean.Department;
import com.meng.bean.Msg;
import com.meng.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


/**
 * @Description
 * @Author Meng
 * @Versions
 * @Date 2021-05-18-19:24
 */
@Controller
public class DepartmentController {


    @Autowired
    DepartmentService departmentService;


    @ResponseBody
    @RequestMapping("/dept")
    public Msg getAllDeptName(){
        List<Department> allDeptName = departmentService.getAllDeptName();
        for (Department department : allDeptName) {
            System.out.println(department);
        }
        return Msg.success().add("department",allDeptName);
    }
}
