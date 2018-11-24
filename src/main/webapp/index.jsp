<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
	<!-- Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工修改</h4>
	      </div>
	      <div class="modal-body">
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			    	<p class="form-control-static" id="empName_update_static"></p>
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="email_update_input" ></input>
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      <label class="radio-inline">
					 <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
				</div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      	<select class="form-control" name="dId">
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
	      </div>
	      <div class="modal-body">
			<form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="email" name="email" class="form-control" id="email_add_input" placeholder="Email">
			      <span class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      <label class="radio-inline">
					 <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
				</div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      	<select class="form-control" name="dId">
					</select>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container">
		<div class="row"></div>
			<div class="col-md-12">
				<h1>SSM</h1>
			</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all">
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord, currentPage; 
		$(function(){
			to_page(1);
		});
		
		function to_page(pn) {
					$.ajax({
						url:"${pageContext.request.contextPath}/emps",
						data: "pn="+pn,
						type:"get",
						success:function(result) {
							build_emps_table(result);
							build_page_info(result);
							build_page_nav(result);
				}
			});
		}
	
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var $chcekBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var $empIdTd = $("<td></td>").append(item.empId);
				var $empNameTd = $("<td></td>").append(item.empName);
				var $genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
				var $emailTd = $("<td></td>").append(item.email)
				var $deptNameTd = $("<td></td>").append(item.department.deptName);
				var $editButton = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
									.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
									.append("编辑");
				$editButton.attr("edit-id",item.empId);
				var $deleteButton = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
									.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
									.append("删除");
				$deleteButton.attr("del-id",item.empId);
				var $btnTd = $("<td></td>").append($editButton).append(" ").append($deleteButton);
				$("<tr></tr>").append($chcekBoxTd)
					.append($empIdTd)
					.append($empNameTd)
					.append($genderTd)
					.append($emailTd)
					.append($deptNameTd)
					.append($btnTd)
					.appendTo("#emps_table tbody")
			});
		}
	
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var $ul = $("<ul></ul>").addClass("pagination");
			var $firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var $prePage = $("<li></li>").append($("<a></a>").attr("href","#").append("&laquo;"));
			var $lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			var $nextPage = $("<li></li>").append($("<a></a>").attr("href","#").append("&raquo;"));
			if (result.extend.pageInfo.hasPreviousPage){
				$firstPage.click(function(){
					to_page(1);
				});
				$prePage.click(function() {
					to_page(result.extend.pageInfo.pageNum-1);
				});
			} else {
				$firstPage.addClass("disabled");
				$prePage.addClass("disabled");
			}
			if (result.extend.pageInfo.hasNextPage){
				$lastPage.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
				$nextPage.click(function() {
					to_page(result.extend.pageInfo.pageNum+1);
				});
			} else {
				$lastPage.addClass("disabled");
				$nextPage.addClass("disabled");
			}
			$ul.append($firstPage).append($prePage);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,item) {
				var $numLi = $("<li></li>").append($("<a></a>").attr("href","#").append(item));
				$numLi.click(function() {
					to_page(item);
				});
				if (result.extend.pageInfo.pageNum == item){
						$numLi.addClass("active");
				}
				$ul.append($numLi);
			});
			$ul.append($nextPage).append($lastPage);
			var navEle = $("<nav></nav>").append($ul);
			$("#page_nav_area").append($ul);
		}		
		
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，总共"
					+result.extend.pageInfo.pages+"页，"+result.extend.pageInfo.total+"记录");
			totalRecord = result.extend.pageInfo.pages+5;
			currentPage = result.extend.pageInfo.pageNum;
		}
		
		$("#emp_add_modal_btn").click(function() {
			
			reset_form("#empAddModal form");
			getDepts("#empAddModal select");
			$("#empAddModal").modal({
				backdrop: "static"
			});
		});
		
		function reset_form(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url:"${pageContext.request.contextPath}/depts",
				type:"get",
				success:function(result) {
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		function validate_add_form() {
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				show_validate_msg("#empName_add_input", "error" ,"用户名非法");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success" ,"");
			}
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_add_input", "error" ,"邮箱格式错误");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success" ,"");
			}
			return true;
		}
		
		function show_validate_msg(ele, status ,msg) {
			$(ele).parent().removeClass("has-error has-success");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#empName_add_input").blur(function(){
			var empName = this.value;
			$.ajax({
				url:"${pageContext.request.contextPath}/checkUser",
				type:"get",
				data:"empName="+empName,
				success:function(result) {
					if (result.code==100) {
						show_validate_msg("#empName_add_input", "success" ,"用户名可用");
						$("#emp_save_btn").attr("ajax-value", "success");
					} else {
						show_validate_msg("#empName_add_input", "error" ,result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-value", "fail");
					}
				}
			});
		});
		
		$("#emp_save_btn").click(function() {
			
			if (!validate_add_form()) {
				return false;
			} 
			if($(this).attr("ajax-value")=="fail") {
				return false;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/emp",
				type:"post",
				data:$("#empAddModal form").serialize(),
				success:function(result) {
					if(result.code==100){
						$("#empAddModal").modal("hide");
						to_page(totalRecord);
					} else {
						if ("undefined" != typeof(result.extend.errorField.empName)){
							show_validate_msg("#empName_add_input", "error" ,result.extend.errorField.empName);
						}
						if ("undefined" != typeof(result.extend.errorField.email)) {
							show_validate_msg("#email_add_input", "error", result.extend.errorField.email);
						}
					} 
				}
			});
		});
		
		$(document).on("click", ".edit_btn", function(){
			getDepts("#empUpdateModal select");
			getEmp($(this).attr("edit-id"));
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop: "static"
			});
		});
		
		$(document).on("click", ".delete_btn", function() {
			//alert($(this).parents("tr").find("td:eq(1)").text());
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			if (confirm("确认删除【"+empName+"】吗？")) {
				$.ajax({
					url:"${pageContext.request.contextPath}/emp/"+empId,
					type:"delete",
					data:$("#empAddModal form").serialize(),
					success:function(result) {
						to_page(currentPage);
					}
				});
			}
			
		});
		
		function getEmp(id) {
			$("#empUpdateModal form")[0].reset();
			$("#empName_update_static").text("");
			$("#email_update_input").text("");
			$.ajax({
				url:"${pageContext.request.contextPath}/emp/"+id,
				type:"get",
				success:function(result) {
					var empData = result.extend.emp;
					$("#empName_update_static").append(empData.empName);
					$("#email_update_input").attr("value",empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		$("#emp_update_btn").click(function() {
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error" ,"邮箱格式错误");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success" ,"");
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/emp/"+$(this).attr("edit-id"),
				type:"put",
				data:$("#empUpdateModal form").serialize(),
				success:function(result) {
					$("#empUpdateModal").modal("hide");
					to_page(currentPage);
				}
			});
		});
		
		$("#check_all").click(function() {
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		
		$(document).on("click", ".check_item", function() {
			var flag = ($(".check_item:checked").length == $(".check_item").length);
			$("#check_all").prop("checked", flag);
		});
		$("#emp_delete_all_btn").click(function() {
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"), function() {
				empNames += $(this).parents("tr").find("td:eq(2)").text()+"-";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			})
			empNames = empNames.substring(0,empNames.length-1);
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			if (confirm("确认删除【"+empNames+"】吗？")) {
				$.ajax({
					url:"${pageContext.request.contextPath}/emp/"+del_idstr,
					type:"delete",
					success:function(result) {
						$("#check_all").prop("checked", false);
						to_page(currentPage);
					}
				});
			}
		});
	</script>
</body>
</html>