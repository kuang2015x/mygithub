<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
  pageContext.setAttribute("APP_PATH",request.getContextPath());
 %>
   <meta charset="utf-8" />
   <title>台管理系统</title>
   <meta content="width=device-width, initial-scale=1.0" name="viewport" />
   <meta content="" name="description" />
   <meta content="Mosaddek" name="author" />
   <script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.0.0.min.js"></script>
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" />
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap-responsive.min.css" rel="stylesheet" />
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap-fileupload.css" rel="stylesheet" />
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/font-awesome.css" rel="stylesheet" />
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/style.css" rel="stylesheet" />
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/style-responsive.css" rel="stylesheet" />
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/style-default.css" rel="stylesheet" id="style_color" />
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap-fullcalendar.css" rel="stylesheet" />
   <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen">
</head>
<body class="fixed-top">
   
   <div id="header" class="navbar navbar-inverse navbar-fixed-top">
       
       <div class="navbar-inner" >
           <div class="container-fluid">
               
               <div class="sidebar-toggle-box hidden-phone">
                   <div class="icon-reorder tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
               </div>
               
               
               <div class="brand" style = "float:left;padding-top:0.9%;">
                   <img src="${APP_PATH }/pic/logo.png" alt="Metro Lab" sytle="margin:1%"/>
               </div>
               
               <div class="top-nav ">
                   <ul class="nav pull-right top-menu" style="margin-top:0%">                     
                       
                       <li class="dropdown">
                           <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                               <img src="${APP_PATH }/pic/avatar1_small.jpg" alt="">
                               <span class="username" id = "uname"><c:out value="${user.name }"></c:out></span>
                               <b class="caret"></b>
                           </a>
                           <ul class="dropdown-menu extended logout">
                               <li><a href="#" id="pw"><i class="icon-cog"></i>修改密码</a></li>
                               <li><a href="${APP_PATH}/login"><i class="icon-key"></i>退出</a></li>
                           </ul>
                       </li>
                       
                   </ul>
                   
               </div>
           </div>
       </div>
       
   </div>
   <div id="container" class="row-fluid">
 	<div class="sidebar-scroll">
        <div id="sidebar" >         
          <ul class="sidebar-menu">
              <li class="sub-menu">
                  <a class="" href="${APP_PATH}/info/${user.id }" style="width:100%" id="hr1">
                      <i class="icon-adn"></i>
                      <span>管理员信息</span>
                  </a>
              </li>
              <li class="sub-menu active">
                  <a href="javascript:;" class="" style="width:100%">
                      <i class="icon-user"></i>
                      <span>管理员</span>
                      <span class="arrow"></span>
                  </a>
                  <ul class="sub" style="margin-left:-25%">
                      <li ><a style="width:250px" href="">查看管理员</a></li>
                      <li><a style="width:250px" href="#">创建管理员</a></li>
                      <li><a style="width:250px"href="${APP_PATH}/adLog/${user.id }">管理员日志</a></li>
                      <li class="active"><a style="width:250px" href="#">上传附件</a></li>
                  </ul>
              </li>
              <li class="sub-menu">
                  <a href="javascript:;" class="" style="width:100%">
                      <i class="icon-cogs"></i>
                      <span>人员管理</span>
                      <span class="arrow"></span>
                  </a>
                  <ul class="sub" style="margin-left:-25%">
                      <li><a style="width:250px" href="${APP_PATH}/index1/${user.id }">查看人员</a></li>
                      <li><a style="width:250px" href="${APP_PATH}/importExcel/${user.id }">导入表格</a></li>
                  </ul>
              </li>
          </ul>
         
      </div>
      </div>
      
        
      <div id="main-content">
         
         <div class="container-fluid">

            <div class="row-fluid">
               <div class="span12">

                   <h3 class="page-title">
               附件列表
                   </h3>
                   <ul class="breadcrumb">
                       <li>
                           <a href="#">首页</a>
                           <span class="divider">/</span>
                       </li>
                       <li class="active">
                            附件列表
                       </li>
                       
                               <div class="input-append search-input-area" style="margin-right:29%">
                                   <input class="" id="appendedInputButton" style="padding-left:10px" placeholder="输入名称">
                                   <button class="btn" type="button" id="search"><i class="icon-search"></i> </button>
                               </div>
                     
                   </ul>

               </div>
            </div>

         </div>
         <!--显示信息 -->

<div class="container">
		<%--标题--%>
		<div class="row">
			<div class="col-md-12">
				<!-- <h1>SSM_CURD</h1>-->
			</div>
		</div>
		<%--按钮--%>
		<%--表格--%>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"></th>
							<th>UserName</th>
							<th>AttachedName</th>
							<th>Date</th>
							<th>操作</th>
						</tr>
					<thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<button class="btn btn-danger" id="emp_delete_all_btn">批量删除</button>
			</div>
		</div>
		<%--分页信息--%>
		<div class="row">
			<%--分页文字信息--%>
			<div class="col-md-6" id="page_info_area"></div>
			<%--分页条--%>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
		<form id="form1" enctype="multipart/form-data">
              <div style="width:50%">
                   <input type="file" id="wordup" name="wordup" class="btn  btn-primary"/>
              </div>
              <span style="display:block;margin-top:-2%;margin-left:25%;font-size:15px">文件以docx结尾</span></br></br></br>
        </form>
	</div>
<!-- 显示信息 -->

<!-- 修改状态弹出框 s-->

<!-- 修改状态弹出框e -->

<!-- 修改密码S -->
<div class="modal fade" id="pwd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" >
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" >
					修改密码
				</h4>
			</div>
			<div class="modal-body">
			<form class="form-horizontal">
				<div class="control-group">
                <label class="control-label">原始密码</label>
                	<div class="controls" style="margin-left:15%;margin-top:-3%">
                		<input type="password" id="input3" class="input-xlarge" style="width:215px;padding-left:5px"/>
                		<span class="help-inline" id="hd1"></span>
                	</div>
                </div>
                <div class="control-group">
	                <label class="control-label">新密码</label>
                	<div class="controls" style="margin-left:15%;margin-top:-3%">
                		<input type="password" id="input4" class="input-xlarge" style="width:215px;padding-left:5px"/>
                		<span class="help-inline" id="hd2"></span>
                	</div>
	            </div>
	            <div class="control-group">
	                <label class="control-label">确认新密码</label>
                	<div class="controls" style="margin-left:15%;margin-top:-3%">
                		<input type="password" id="input5" class="input-xlarge" style="width:215px;padding-left:5px"/>
                		<span class="help-inline" id="hd3"></span>
                	</div>
	            </div>
	         </form>
            </div>                           
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-primary" id="updatePassword">
					提交更改
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
<!-- 修改密码E -->
   <%--管理员修改模态框S--%>
	<%--管理员修改模态框E--%>
	
   <div id="footer">
       2013 &copy; MetroAdmin.
   </div>
  <script type="text/javascript">
   
   $(function () {  //这样也可以实现
	   to_page(1)
	  });
   function to_page(pn) {
	   var str = pn.toString();
	   if(str.indexOf('-')>-1){ 
		   var extension = pn.substring(str.lastIndexOf('-')+1, pn.length);
		   var pc = str.substring(0,str.lastIndexOf('-'));
		   var pn = parseInt(pc);
		   //alert(pn+"-"+extension);
		   $.ajax({
				url : "${APP_PATH}/allusers/"+extension,
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析显示分页条数据
					build_page_nav(result,extension);
				}
			});
	   }else{
		   var str="";
		$.ajax({
			url : "${APP_PATH}/allattache",
			data : "pn=" + pn,
			type : "GET",
			success : function(result) {
				//console.log(result);
				//1.解析并显示员工数据
				build_emps_table(result);
				//2.解析并显示分页信息
				build_page_info(result);
				//3.解析显示分页条数据
				build_page_nav(result,str);
			}
		});
	   }
	}
	function build_emps_table(result) {
		$("#emps_table tbody").empty();
		var emps = result.extend.pageInfo.list;
		$
				.each(
						emps,
						function(index, item) {
							var t = item.attachedurl.substring(item.attachedurl.lastIndexOf('/')+1, item.attachedurl.length);
							var t2 = t.substring(0,t.lastIndexOf('.'));
							var checkboxTd = $("<td><input type ='checkbox' class='check_item'/></td>");
							//alert(item.empName);
							var empIdTd = $("<td></td>").append(item.name);
							var empNameTd = $("<td></td>").append(
									t2);
							var emailTd = $("<td></td>").append(item.uploadtime);
							var editBtn = $("<button></button>")
							.addClass(
									"btn btn-primary btn-sm edit_btn")
							.append(
									$("<span></span>")
											.addClass(
													"glyphicon glyphicon-pencil"))
							.append("查看");
					//为编辑按钮添加自定义属性，表示当前id
					editBtn.attr("edit-id", item.id);
					var delBtn = $("<button></button>")
							.addClass(
									"btn btn-danger btn-sm delete_btn")
							.append(
									$("<span></span>")
											.addClass(
													"glyphicon glyphicon-trash"))
							.append("删除");
					//为删除按钮添加自定义属性，表示当前id
					delBtn.attr("del-id", item.id);
					var btnTd = $("<td></td>").append(editBtn)
							.append(" ").append(delBtn);
							$("<tr></tr>").append(checkboxTd).append(
									empIdTd).append(empNameTd).append(emailTd).append(btnTd).appendTo(
									"#emps_table tbody");
						});
	}
	//解析显示分页信息
	function build_page_info(result) {
		$("#page_info_area").empty();
		$("#page_info_area").append(
				"当前" + result.extend.pageInfo.pageNum + "页,总"
						+ result.extend.pageInfo.pages + "页,总共"
						+ result.extend.pageInfo.total + "条记录");
		totalRecord = result.extend.pageInfo.total;
		currentPage = result.extend.pageInfo.pageNum;
	}
	//解析显示分页条
	function build_page_nav(result,strName) {
		$("#page_nav_area").empty();
		var ul = $("<ul></ul>").addClass("pagination");
		var firstPageLi = $("<li></li>").append(
				$("<a></a>").append("首页").attr("href", "#"));
		var prePageLi = $("<li></li>").append(
				$("<a></a>").append("&laquo;"));
		if (result.extend.pageInfo.hasPreviousPage == false) {
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled")
		} else {
			firstPageLi.click(function() {
				if(strName==""){
					to_page(1);
				}else{
					
				to_page(1+'-'+strName);
				}
			});
			prePageLi.click(function() {
				if(strName==""){
				to_page(result.extend.pageInfo.pageNum - 1);
				}else{
					to_page(result.extend.pageInfo.pageNum - 1+'-'+strName);
				}
			});
		}
		var nextPageLi = $("<li></li>").append(
				$("<a></a>").append("&raquo;"));
		var lastPageLi = $("<li></li>").append(
				$("<a></a>").append("末页").attr("href", "#"));
		if (result.extend.pageInfo.hasNextPage == false) {
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		} else {
			nextPageLi.click(function() {
				if(strName==""){
					
				to_page(result.extend.pageInfo.pageNum + 1);
				}else{
					to_page(result.extend.pageInfo.pageNum + 1+'-'+strName);
				}
			});
			lastPageLi.click(function() {
				if(strName==""){
					
				to_page(result.extend.pageInfo.pages);
				}else{
					to_page(result.extend.pageInfo.pages);
				}
			});
		}
		//添加首页和前一页
		ul.append(firstPageLi).append(prePageLi);
		//添加1、2、3遍历ul中添加页码
		$.each(result.extend.pageInfo.navigatepageNums, function(index,
				item) {
			var numLi = $("<li></li>").append($("<a></a>").append(item));
			if (result.extend.pageInfo.pageNum == item) {
				numLi.addClass("active")
			}
			numLi.click(function() {
				if(strName==""){
					
				to_page(item);
				}else{
					to_page(item+'-'+strName);
				}
			});
			ul.append(numLi);
		});
		//添加末页和下一页
		ul.append(nextPageLi).append(lastPageLi);
		var navEl = $("<nav></nav>").append(ul);
		$("#page_nav_area").append(navEl);
		//navEl.appendTo("#page_nav_area");
	}

	//查看附件
	$(document).on("click", ".edit_btn", function() {
		var id = ($(this).attr("edit-id"));
		/*$.ajax({ajax不能弹出保存框，所以不能进行下载
			url : "${APP_PATH}/checkAttached/" + id,
			type : "GET",
			success : function(result) {
				
				//to_page(currentPage);
			}
		});*/
        var url = "${APP_PATH}/checkAttached/"+id;
        var fileName = "testAjaxDownload.txt";
        var form = $("<form></form>").attr("action", url).attr("method", "post");
        //form.append($("<input></input>").attr("type", "hidden").attr("name", "fileName").attr("value", fileName));
        form.appendTo('body').submit().remove();
	});
	
		$(document).on("click", ".delete_btn", function() {
			//1.弹出确认对话框
			//得到姓名
			var userName = $(this).parents("tr").find("td:eq(2)").text();
			//得到ID
			var userId = $(this).attr("del-id");
			//确认发送请求
			if (confirm("确认删除【" + userName + "】吗？")) {
				$.ajax({
					url : "${APP_PATH}/user/" + userId,
					type : "DELETE",
					success : function(result) {
						
						to_page(currentPage);
					}
				});
			}
		});
		//全选、全不选
		$("#check_all").click(function() {
			//这些dom原生的属性用prop()获取或者修改
			//自定义的属性用attr()获取
			//若用attr()获取原生，但属性为标注出，得到的是undefined
			//$(this).prop("checked");
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		//check_item全选后 check_all选择
		$(document)
				.on(
						"click",
						".check_item",
						function() {
							//判断当前选中的元素是否为5个
							var flag = $(".check_item:checked").length == $(".check_item").length;
							$("#check_all").prop("checked", flag);
						});
		//批量删除事件
		$("#emp_delete_all_btn").click(
				function() {
					//$(".check_item")
					var empNames = "";
					var del_list = "";
					$.each($(".check_item:checked"), function() {
						empNames += $(this).parents("tr").find("td:eq(2)")
								.text()
								+ ",";
						//组装id字符串
						del_list += $(this).parents("tr").find("td:eq(1)")
								.text()
								+ "-";
					});
					//去除多余的逗号
					empNames = empNames.substring(0, empNames.length - 1);
					del_list = del_list.substring(0, del_list.length - 1);
					if (confirm("确认删除【" + empNames + "】吗？")) {
						//alert(empNames);
						$.ajax({
							url : "${APP_PATH}/user/" + del_list,
							type : "DELETE",
							success : function(result) {
								alert(result.msg);
								to_page(currentPage);
							}
						});
					}
				});
	//编辑管理员信息E
   		
   		
   		//修改密码
   		$('#pw').click(function(){
		  $('#pwd').modal('show');
		  
	  })
	  //提交密码
	  $("#updatePassword").click(function(){
		  
		  var opwd = $("#input3").val();
		  var npwd = $("#input4").val();
		  var cpwd = $("#input5").val();
		  if(opwd==""){
			  $('#hd1').html("旧密码不能为空").css({color:"red"});
			  return;
		  }
		  if(opwd==""){
			  $('#hd2').html("新密码不能为空").css({color:"red"});
			  return;
		  }
		  if(npwd!=cpwd){
			  $('#hd3').html("两次输入的新密码不一致").css({color:"red"});
			  return;
		  }
		  var name;
		  var id;
 			$("table").each(function(){
  			   name=$(this).find('td').eq(1).text();
  			   id=$(this).find('td').eq(4).text();
  		   })
		  $.ajax({  
              type : "post",  
              url : "${APP_PATH}/uppwd/"+id,
              dataType: 'json',
              data : {oldPassword:opwd,newPassword:npwd,conPassword:cpwd,name:name},  
              success : function(result) {
                  if(result.code==100){
                  	$('#pwd').modal('hide');
                  	$('#p1').text("修改成功");
                  	$('#state').modal('show');
                  	$("#state").on("hide.bs.modal",function(e){
                  		//hide方法后调用
                  		});                  	
                  } else{
                  	$('#pwd').modal('hide');
                  	$("#p1").text(result.extend.msg);
                  	$('#state').modal('show');
                  } 
              }  
          });
	  })
	  
	  //搜索框
	 /* $("#search").click(function(){
		  var value = $("#appendedInputButton").val();
		  var name = $.trim(value);
		 if(name==""){
			 //return;
			 to_page(1);
		 }else{
			 to_page(1+'-'+name);
		 }
	  })*/
	  
	  $("#wordup").bind('change',function(){
		  var fileName = $('#wordup').val();
		 // alert(fileName);
		  var extension = fileName.substring(fileName.lastIndexOf('.'), fileName.length).toLowerCase();
		  if(extension!=".docx"){
			  return;
		  }
		  var name = $("#uname").text();
		  var data = new FormData();
          data.append('file', $('#wordup')[0].files[0]);
		  $.ajax({
              url:"${APP_PATH}/uploadAttached/"+name,
              type:"POST",
              data: data,
              cache: false,
              contentType: false, //不可缺参数
              processData: false, //不可缺参数  
              success:function(result){
            	  if(result.code==100){
            		  //window.location.href="${APP_PATH}/index1/${user.id }";
            		  to_page(1);
            	  }else{
            		  $('#pwd').modal('hide');
                    	$("#p1").text("导入文件失败");
                    	$('#state').modal('show');
                    	$("#state").on("hide.bs.modal",function(e){
                    			location.reload();
                      		});
            	  }
              },  
              error: function(result){
            	  
              }  
          });
	  })
   </script>
   <script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.0.0.min.js"></script>
   <script src="${APP_PATH }/static/js/jquery.nicescroll.js" type="text/javascript"></script>
   <script type="text/javascript" src="${APP_PATH }/static/js/jquery-ui-1.9.2.custom.min.js"></script>
   <script type="text/javascript" src="${APP_PATH }/static/js/jquery.slimscroll.min.js"></script>
   <script src="${APP_PATH }/static/js/fullcalendar.min.js"></script>
   <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

   
 <!--[if lt IE 9]>
   <script src="http://www.js-css.cn/js/excanvas.js"></script>
   <script src="http://www.js-css.cn/js/respond.js"></script>
   <![endif]-->
   <script src="${APP_PATH }/static/js/jquery.scrollto.min.js"></script>
   <script src="${APP_PATH }/static/js/common-scripts.js"></script>

<meta http-equiv="content-type" content="text/html;charset=UTF-8">
</body>
</html>