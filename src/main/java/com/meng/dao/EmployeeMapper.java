package com.meng.dao;

import com.meng.bean.Employee;
import com.meng.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);

    Employee selectByPrimaryKey(Integer empId);

    //查询的时候进行连表查询部门信息
    List<Employee> selectByExampleWithDept(EmployeeExample example);
    List<Employee> selectByExampleWithDept01();

    //和上面一样，只不过是根据id查询单个员工信息
    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
}