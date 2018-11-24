package mxp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import mxp.bean.Department;
import mxp.dao.DepartmentMapper;

@Service
public class DepartmentService {
	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> getDepts() {
		ClassPathXmlApplicationContext a = null;
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}
}
