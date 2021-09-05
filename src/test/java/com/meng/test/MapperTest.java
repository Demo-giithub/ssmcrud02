package com.meng.test;

import com.meng.bean.Employee;
import com.meng.dao.DepartmentMapper;
import com.meng.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @Description
 * @Author Meng
 * @Versions
 * @Date 2021-05-12-20:02
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;



    @Test
    public void testCRUD(){
//        departmentMapper.insertSelective(new department(null,"销售部"));
//        employeeMapper.insertSelective(new employee(null,"lisi","N","lisi@qq.com",2));

        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uuid = UUID.randomUUID().toString().substring(0,5)+i;
            String gender = "M";
            if(i%2==0){
                gender = "N";
            }
            int dept = i%4;
            dept++;
            mapper.insertSelective(new Employee(null,uuid,gender,uuid+"@qq.com",dept));
        }
        System.out.println("批量插入完成");
    }



}
