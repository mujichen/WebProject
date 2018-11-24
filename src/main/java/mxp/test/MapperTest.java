package mxp.test;

import mxp.bean.Employee;
import mxp.dao.DepartmentMapper;
import mxp.dao.EmployeeMapper;
import mxp.service.EmployeeService;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMaper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	@Autowired
	EmployeeService e;
	@Test
	public void testCRUD() {
//		System.out.println(departmentMaper123);
//		departmentMaper.insertSelective(new Department(null, "开发部"));
//		departmentMaper.insertSelective(new Department(null, "测试部"));
//		employeeMapper.insertSelective(new Employee(null, "jerry", "M", "Jerry@163.com", 1));
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0; i<1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@163.com", 1));
		}
	}
}
