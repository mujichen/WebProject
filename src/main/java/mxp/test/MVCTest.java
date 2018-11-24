package mxp.test;

import com.github.pagehelper.PageInfo;
import mxp.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/springDispatcherServlet-servlet.xml"})
public class MVCTest {
	MockMvc mockMvc;
	@Autowired
	WebApplicationContext context;
	
	@Before
	public void initMockMvc() {
		//ClassPathXmlApplicationContext
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	@Test
	public void testPage() throws Exception {
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1"))
			.andReturn();
		MockHttpServletRequest request = result.getRequest();
		PageInfo<Employee> pageInfo = (PageInfo<Employee>) request.getAttribute("pageInfo");
		System.out.println("当前页码"+pageInfo.getPageNum());
		System.out.println("总页码"+pageInfo.getPages());
		System.out.println("总记录数"+pageInfo.getTotal());
		System.out.println("当前显示的页码");
		int[] nums = pageInfo.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(" "+i);
		}
		List<Employee> list = pageInfo.getList();
		for (Employee e : list) {
			System.out.println("ID:"+e.getEmpId()+"  name:"+e.getEmpName());
		}
	}
}
