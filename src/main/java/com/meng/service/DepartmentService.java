package com.meng.service;

import com.meng.bean.Department;
import com.meng.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Description
 * @Author Meng
 * @Versions
 * @Date 2021-05-18-19:24
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;

    public List<Department> getAllDeptName(){
        return departmentMapper.selectByExample(null);
    }

}
