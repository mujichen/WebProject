package mxp.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import mxp.bean.Employee;
import mxp.bean.Message;
import mxp.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employService;
	
	@ResponseBody
	@RequestMapping(value="/emp/{ids}", method=RequestMethod.DELETE)
	public Message delteEmp(@PathVariable("ids")String ids) {
		if (ids.contains("-")) {
			String[] strIds = ids.split("-");
			List<Integer> idList = new ArrayList<Integer>();
			for (String id : strIds) {
				idList.add(Integer.parseInt(id));
			}
			employService.deleteBatch(idList);
		} else {
			Integer id = Integer.parseInt(ids);
			employService.deleteEmp(id);
		}
		return Message.success();
	}

	@RequestMapping(value="/emp/{empId}", method=RequestMethod.PUT)
	@ResponseBody
	public Message saveEmp(Employee employee) {
		System.out.println(employee.getDepartment());
		employService.updateEmp(employee);
		return Message.success();
	}
	
	@RequestMapping(value="/emp/{id}", method=RequestMethod.GET)
	@ResponseBody
	public Message getEmp(@PathVariable("id")Integer id) {
		Employee empolyee = employService.getEmp(id);
		return Message.success().add("emp", empolyee);
	}
	
	@RequestMapping("/checkUser")
	@ResponseBody
	public Message checkUser(@RequestParam("empName") String empName) {
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if (!empName.matches(regx)) {
			return Message.fail().add("va_msg", "用户名非法");
		}
		boolean b = employService.checkUser(empName);
		if (b) {
			return Message.success();
		} else {
			return Message.fail().add("va_msg", "用户名不可用");
		}
	}
	
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Message saveEmp(@Valid Employee employee, BindingResult result) {
		if(result.hasErrors()) {
			List<FieldError> errors = result.getFieldErrors();
			Map<String, Object> map = new HashMap<String, Object>();
			for (FieldError error : errors) {
				//System.out.println(error.getField()+"  "+error.getDefaultMessage());;
				map.put(error.getField(), error.getDefaultMessage());
			}
			
			return Message.fail().add("errorField", map);
		}
		employService.saveEmp(employee);
		return Message.success();
	}

	@RequestMapping("/emps")
	@ResponseBody
	public Message getEmployeeWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employService.getAll();
		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);
		return Message.success().add("pageInfo", page);
	}
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn, Model model) {
		PageHelper.startPage(pn, 5); 
		List<Employee> emps = employService.getAll();
		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
