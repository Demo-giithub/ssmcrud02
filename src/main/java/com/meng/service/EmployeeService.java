package com.meng.service;

import com.meng.bean.Employee;
import com.meng.bean.EmployeeExample;
import com.meng.dao.EmployeeMapper;
import org.apache.ibatis.annotations.Lang;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.security.auth.login.CredentialException;
import java.util.List;


/**
 * @Description
 * @Author Meng
 * @Versions
 * @Date 2021-05-12-21:10
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    //查询数据库中的所有信息
    public List<Employee> getAllEmps(){
        List<Employee> employees = employeeMapper.selectByExampleWithDept(null);
        System.out.println("service_ceng");
        return employees;
    }

    //保存员工信息
    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    //对用户名进行校验
    public List<Employee> username_verification(String empName){
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        return employeeMapper.selectByExample(employeeExample);
    }
    //对用户名进行校验
    public Long email_verification(String empEmail){
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmailEqualTo(empEmail);
        return employeeMapper.countByExample(employeeExample);
    }

    //根据主键查询员工信息
    public Employee getEmpById(Integer id){
        return employeeMapper.selectByPrimaryKeyWithDept(id);
    }

    //更新员工
    public void update_employee_information(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    //删除员工
    public void delete_employee_by_id(Integer deleteId){
        employeeMapper.deleteByPrimaryKey(deleteId);
    }


    //批量删除员工
    public void batch_delete_employee_by_id(List list){
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(list);
        employeeMapper.deleteByExample(employeeExample);
    }

}
