package mxp.controller;

import mxp.bean.Department;
import mxp.bean.Message;
import mxp.service.DepartmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class DepartmentController {
	@Resource
	private DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Message getDepts() {
		List<Department> list = departmentService.getDepts();
		return Message.success().add("depts", list);
	}
}
