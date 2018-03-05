<%@ page language="java" import="java.util.*" pageEncoding="GB18030"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <!-- ��ȡ��ǰ��Ŀ·������/��ʼ������/��β -->
<%
  pageContext.setAttribute("APP_PATH",request.getContextPath());
 %>
 <title>Ա���б�</title> 
 <!-- 
 ����/��ʼ�����·��������Դ�Ե�ǰ��Դ��·��Ϊ��׼�����׳�����
 ��/��ʼ�����·��������Դ�Է�������·��Ϊ��׼(http://localhost:8080),��Ҫ������Ŀ����
  -->  
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.0.0.min.js"></script>
<link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </head>
  
<body>

	<%--Ա���޸�ģ̬��--%>
	<div class="modal fade" id="empUpdataModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Ա���޸�</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">

						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">UserName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>

						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_updata_input" placeholder="Email"> <span
									class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_updata_input" value="M"> ��
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_updata_input" value="F"> Ů
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select id="dept_updata_select" class="form-control" name="dId">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
					<button type="button" class="btn btn-primary" id="emp_updata_btn">����</button>
				</div>
			</div>
		</div>
	</div>

	<!-- Ա����ӵ�ģ̬�� -->
	<div class="modal fade" id="empAndModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Ա�����</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">

						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">UserName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="UserName"> <span
									class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control"
									id="email_add_input" placeholder="Email"> <span
									class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">Gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="M" checked="checked"> ��
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="F"> Ů
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select id="dept_add_select" class="form-control" name="dId">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">����</button>
				</div>
			</div>
		</div>
	</div>



	<%--���ʾҳ�棬--%>
	<div class="container">
		<%--����--%>
		<div class="row">
			<div class="col-md-12">
				<h1>SSM_CURD</h1>
			</div>
		</div>
		<%--��ť--%>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">����</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">ɾ��</button>
			</div>
		</div>
		<%--���--%>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"></th>
							<th>No</th>
							<th>Name</th>
							<th>Gender</th>
							<th>Email</th>
							<th>DeptName</th>
							<th>����</th>
						</tr>
					<thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<%--��ҳ��Ϣ--%>
		<div class="row">
			<%--��ҳ������Ϣ--%>
			<div class="col-md-6" id="page_info_area"></div>
			<%--��ҳ��--%>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord, currentPage;
		//ҳ�������ɺ�ֱ��ȥ����һ��Ajax����Ҫ����ҳ����
		$(function() {
			to_page(1)
		});
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1.��������ʾԱ������
					build_emps_table(result);
					//2.��������ʾ��ҳ��Ϣ
					build_page_info(result);
					//3.������ʾ��ҳ������
					build_page_nav(result);
				}
			});
		}
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$
					.each(
							emps,
							function(index, item) {
								var checkboxTd = $("<td><input type ='checkbox' class='check_item'/></td>");
								//alert(item.empName);
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var genderTd = $("<td></td>").append(
										item.gender == 'M' ? "��" : "Ů");
								var emailTd = $("<td></td>").append(item.email);
								var deptNameTd = $("<td></td>").append(
										item.department.deptName);
								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-primary btn-sm edit_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil"))
										.append("�༭");
								//Ϊ�༭��ť����Զ������ԣ���ʾ��ǰid
								editBtn.attr("edit-id", item.empId);
								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-trash"))
										.append("ɾ��");
								//Ϊɾ����ť����Զ������ԣ���ʾ��ǰid
								delBtn.attr("del-id", item.empId);
								var btnTd = $("<td></td>").append(editBtn)
										.append(" ").append(delBtn);
								$("<tr></tr>").append(checkboxTd).append(
										empIdTd).append(empNameTd).append(
										genderTd).append(emailTd).append(
										deptNameTd).append(btnTd).appendTo(
										"#emps_table tbody");
							});
		}
		//������ʾ��ҳ��Ϣ
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"��ǰ" + result.extend.pageInfo.pageNum + "ҳ,��"
							+ result.extend.pageInfo.pages + "ҳ,�ܹ�"
							+ result.extend.pageInfo.total + "����¼");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//������ʾ��ҳ��
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("��ҳ").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled")
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("ĩҳ").attr("href", "#"));
			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}
			//�����ҳ��ǰһҳ
			ul.append(firstPageLi).append(prePageLi);
			//���1��2��3����ul�����ҳ��
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active")
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			//���ĩҳ����һҳ
			ul.append(nextPageLi).append(lastPageLi);
			var navEl = $("<nav></nav>").append(ul);
			$("#page_nav_area").append(navEl);
			//navEl.appendTo("#page_nav_area");
		}
		//��ձ���ʽ������
		function reset_form(ele) {
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		//����ģ̬��
		$("#emp_add_modal_btn").click(function() {
			//���ñ�����
			//$("#empAndModal form")[0].reset();
			reset_form("#empAndModal form");
			//�������󣬲�ѯ������Ϣ ��ʾ�������б�
			getDepts("#empAndModal select");
			$("#empAndModal").modal({
				backdrop : "static"
			});
		});
		//
		function getDepts(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "GET",
				success : function(result) {
					//console.log(result);
					//$("#dept_add_select").append("")
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		function valodate_add_form() {
			//1.�õ�ҪУ�������
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|([\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)) {
				//alert("�û���ӦΪ6-16λӢ�ĺ����ֵ���ϻ���2-5λ����");
				$("#empName_add_input").parent().removeClass("has-success");
				$("#empName_add_input").parent().addClass("has-error");
				$("#empName_add_input").next("span").text(
						"�û���ӦΪ6-16λӢ�ĺ����ֵ���ϻ���2-5λ����");
				return false;
			} else {
				$("#empName_add_input").parent().removeClass("has-error");
				$("#empName_add_input").parent().addClass("has-success");
				$("#empName_add_input").next("span").text("");
			}
			//2.У������
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("�����ʽ����ȷ");
				$("#email_add_input").parent().removeClass("has-error");
				$("#email_add_input").parent().addClass("has-error");
				$("#email_add_input").next("span").text("�����ʽ����ȷ");
				return false;
			} else {
				$("#email_add_input").parent().removeClass("has-error");
				$("#email_add_input").parent().addClass("has-success");
				$("#email_add_input").next("span").text("");
			}
			return true;
		}
		//У���û����Ƿ����(ͬ��������)
		$("#empName_add_input").change(
				function() {
					var empName = this.value;
					$.ajax({
						url : "${APP_PATH}/checkuser",
						data : "empName=" + empName,
						type : "POST",
						success : function(result) {
							if (result.code == 100) {
								$("#empName_add_input").parent().removeClass(
										"has-error");
								$("#empName_add_input").parent().addClass(
										"has-success");
								$("#empName_add_input").next("span").text(
										"�û�������");
								$("#emp_save_btn").attr("ajax_va", "success");
							} else {
								$("#empName_add_input").parent().removeClass(
										"has-success");
								$("#empName_add_input").parent().addClass(
										"has-error");
								$("#empName_add_input").next("span").text(
										result.extend.va_msg);
								$("#emp_save_btn").attr("ajax_va", "error");
							}
						}
					});
				});
		//�����¼�
		$("#emp_save_btn")
				.click(
						function() {
							//1.ģ̬������д�ı������ύ�����������б���
							//2.У������
							if (!valodate_add_form()) {
								return false;
							}
							if ($(this).attr("ajax_va") == "error") {
								return false;
							}
							//3.����Ajax����
							$
									.ajax({
										url : "${APP_PATH}/emp",
										type : "POST",
										data : $("#empAndModal form")
												.serialize(),
										success : function(result) {
											//alert(result.msg);
											if (result.code == 100) {
												//Ա������ɹ����ر�ģ̬����ʾ�ղű��������
												$("#empAndModal").modal("hide");
												to_page(totalRecord);
											} else {
												console.log(result);
												//��ʾʧ����Ϣ
												//���Ǹ��ֶεĴ�����Ϣ����ʾ�Ǹ�
												if (undefined !== result.extend.errorFields.email) {
													//��ʾ������Ϣ
													$("#email_add_input")
															.parent()
															.removeClass(
																	"has-error");
													$("#email_add_input")
															.parent()
															.addClass(
																	"has-error");
													$("#email_add_input")
															.next("span")
															.text(
																	result.extend.errorFields.email);
												}
												if (undefined !== result.extend.errorFields.empName) {
													//��ʾ������Ϣ
													$("#empName_add_input")
															.parent()
															.removeClass(
																	"has-success");
													$("#empName_add_input")
															.parent()
															.addClass(
																	"has-error");
													$("#empName_add_input")
															.next("span")
															.text(
																	result.extend.errorFields.empName);
												}
											}
										}
									});
						});
		$(document).on("click", ".edit_btn", function() {
			//alert("edit");
			//0.���Ա����Ϣ
			//1.���������Ϣ����ʾ�����б�
			getDepts("#empUpdataModal select");
			getEmp($(this).attr("edit-id"));
			//��Ա����id���ݸ����°�ť
			$("#emp_updata_btn").attr("edit-id", $(this).attr("edit-id"));
			//����ģ̬��
			$("#empUpdataModal").modal({
				backdrop : "static"
			});
		});
		function getEmp(id) {
			$.ajax({
				url : "${APP_PATH}/emp/" + id,
				type : "GET",
				success : function(result) {
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_updata_input").val(empData.email);
					$("#empUpdataModal input[name=gender]").val(
							[ empData.gender ]);
					$("#empUpdataModal select").val([ empData.dId ]);
				}
			});
		}
		//������� ����Ա��
		$("#emp_updata_btn").click(function() {
			//1.У������
			var email = $("#email_updata_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				//alert("�����ʽ����ȷ");
				$("#email_updata_input").parent().removeClass("has-error");
				$("#email_updata_input").parent().addClass("has-error");
				$("#email_updata_input").next("span").text("�����ʽ����ȷ");
				return false;
			} else {
				$("#email_updata_input").parent().removeClass("has-error");
				$("#email_updata_input").parent().addClass("has-success");
				$("#email_updata_input").next("span").text("");
			}
			//����Ajax����
			$.ajax({
				url : "${APP_PATH}/emp/" + $(this).attr("edit-id"),
				//PUT��ʽ�ύ����������HttpPutFormContentFilter
				type : "PUT",
				data : $("#empUpdataModal form").serialize(),
				//��δ����HttpPutFormContentFilterʹ�����·�����
				//type : "POST",
				//data:$("#empUpdataModal form").serialize() + "&_method=PUT",
				success : function(result) {
					//alert(result.msg);
					//1.�ر�ģ̬��
					$("#empUpdataModal").modal("hide");
					//�����޸�ҳ��
					to_page(currentPage);
					//alert(currentPage);
				}
			});
		});
		//ɾ��Ա��
		$(document).on("click", ".delete_btn", function() {
			//1.����ȷ�϶Ի���
			//�õ�����
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			//�õ�ID
			var empId = $(this).attr("del-id");
			//ȷ�Ϸ�������
			if (confirm("ȷ��ɾ����" + empName + "����")) {
				$.ajax({
					url : "${APP_PATH}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						
						to_page(currentPage);
					}
				});
			}
		});
		//ȫѡ��ȫ��ѡ
		$("#check_all").click(function() {
			//��Щdomԭ����������prop()��ȡ�����޸�
			//�Զ����������attr()��ȡ
			//����attr()��ȡԭ����������Ϊ��ע�����õ�����undefined
			//$(this).prop("checked");
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		//check_itemȫѡ�� check_allѡ��
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							//�жϵ�ǰѡ�е�Ԫ���Ƿ�Ϊ5��
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});
		//����ɾ���¼�
		$("#emp_delete_all_btn").click(
				function() {
					//$(".check_item")
					var empNames = "";
					var del_list = "";
					$.each($(".check_item:checked"), function() {
						empNames += $(this).parents("tr").find("td:eq(2)")
								.text()
								+ ",";
						//��װid�ַ���
						del_list += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});
					//ȥ������Ķ���
					empNames = empNames.substring(0, empNames.length - 1);
					del_list = del_list.substring(0, del_list.length - 1);
					if (confirm("ȷ��ɾ����" + empNames + "����")) {
						//alert(empNames);
						$.ajax({
							url : "${APP_PATH}/emp/" + del_list,
							type : "DELETE",
							success : function(result) {
								alert(result.msg);
								to_page(currentPage);
							}
						});
					}
				});
	</script>
</body>
</html>