package com.meng.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.meng.bean.Employee;
import com.meng.bean.Msg;
import com.meng.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description
 * @Author Meng
 * @Versions
 * @Date 2021-05-12-21:10
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;


    //@RequestParam 用于接收http请求体中的数据或URL中的参数信息
    //分页插件配置在mybatis-config.xml中
    @ResponseBody //看到你就要想到导入jackson.jar
    @RequestMapping("/emps")
    public Msg getAllEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //这里是设置分页数据，意思就是从pn页到pn+5ye
        PageHelper.startPage(pn,5);
        //获取所有数据
        List<Employee> employeeList = employeeService.getAllEmps();
        for(Employee e:employeeList){
            System.out.println(e);
        }
        //将上面获取到的数据进行分页处理，也就是每次取出pn+5条数据
        PageInfo<Employee> pageInfo = new PageInfo<>(employeeList, 5);
        //将数据通过json方式返回给前端
        System.out.println("cha_xun_quan_bu_yuan_gong");
        return Msg.success().add("pageInfo",pageInfo);
    }



    //保存员工信息
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(Employee employee){
        employeeService.saveEmp(employee);
        return Msg.success();
    }


    /**
     * 对员工EmpName进行员工校验
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmpName")
    public Msg backend_verification_empName(@RequestParam("empName") String empName){
        String regex = "^[a-z0-9_-]{6,16}$";
        System.out.println(empName);
        if(!empName.matches(regex)){
            return Msg.failure().add("info","用户名3-16位的英文字母或数字(后端校验)");
        }
        List<Employee> employees = employeeService.username_verification(empName);
        if(employees.isEmpty()){
            return Msg.success();
        }else{
            return Msg.failure().add("info","用户名重复(后端验证)");
        }
    }

    /**
     * 对员工EmpEmail进行员工校验
     * @param empEmail 这个是url路径上的参数
     * @return
     */
    @ResponseBody
    @RequestMapping("/checkEmpEmail")
    public Msg backend_verification_empEmail(@RequestParam("empEmail") String empEmail){
        String regex = "^[a-z\\d]+(\\.[a-z\\d]+)*@([\\da-z](-[\\da-z])?)+(\\.{1,2}[a-z]+)+$";
        System.out.println(empEmail);
        if(!empEmail.matches(regex)){
            return Msg.failure().add("info","邮箱格式不正确(后端校验)");
        }
        Long i = employeeService.email_verification(empEmail);
        if(i == 0){
            return Msg.success();
        }else{
            return Msg.failure().add("info","此邮箱邮箱重复(后端验证)");
        }
    }

    /**
     * 根据id查询员工
     * @param id url路径上传递过来的id   这个是请求地址
     * @return
     */
    @ResponseBody
    @RequestMapping("/emp/{id}")
    public Msg getEmpById(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmpById(id);
        return Msg.success().add("employee",employee);
    }


    /**
     * 更新员工
     * @param employee
     * @return
     * @version 1.0
     * @error 出现了问题，可以看到打印出的员工信息empId和empName都为null
     *        主要是empId为null不行，因为数据库需要根据empId去更新员工信息(where empId = ?)
     */
    /*@ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.PUT)
    public Msg update_employee_information(Employee employee){
        System.out.println(employee);//Employee{empId=null, empName='null', gender='M', email='685660@qq.com', dId=1, department=null}
        employeeService.update_employee_information(employee);
        return Msg.success();
    }*/
    /**
     * 更新员工
     * @param employee
     * @return
     * @version 2.0
     * @description 对1.0 问题的解释，在url地址上加入了员工ID且占位符、变量名都要与employee中的empId属性保持一致，
     *              spring mvc 在封装的时候会将其封装进去
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg update_employee_information(@PathVariable("empId")Integer empId, Employee employee){
        System.out.println(employee);//Employee{empId=1, empName='null', gender='N', email='685660@qq.com', dId=1, department=null}
        employeeService.update_employee_information(employee);
        return Msg.success();
    }

    /**
     * 单个删除
     * @param deleteId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.DELETE)
    public Msg delete_employee_by_id(@RequestParam("delete_id") Integer deleteId){
        employeeService.delete_employee_by_id(deleteId);
        return Msg.success();
    }

    /**
     * 批量删除
     * @param del_id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{del_id}",method = RequestMethod.DELETE)
    public Msg batch_delete_employee_by_id(@PathVariable("del_id") String del_id){
        if(del_id.contains("-")){
            String[] strings = del_id.split("-");
            for (String string : strings) {
                System.out.println(string);
            }
            List<Integer> del_id_list = new ArrayList<>();
            for (String string : strings) {
                del_id_list.add(Integer.valueOf(string));
            }
            employeeService.batch_delete_employee_by_id(del_id_list);
        }else{
            Integer integer = Integer.valueOf(del_id);
            employeeService.delete_employee_by_id(integer);
        }
        return Msg.success();
    }





}
