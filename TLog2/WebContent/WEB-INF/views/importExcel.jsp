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
   <link href="${APP_PATH }/static/css/dropzone.css" rel="stylesheet">
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
                               <span class="username"><c:out value="${user.name }"></c:out></span>
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
              <li class="sub-menu">
                  <a href="javascript:;" class="" style="width:100%">
                      <i class="icon-user"></i>
                      <span>管理员</span>
                      <span class="arrow"></span>
                  </a>
                  <ul class="sub" style="margin-left:-25%">
                      <li ><a style="width:250px" href="${APP_PATH}/users">查看管理员</a></li>
                      <li><a style="width:250px" href="#">创建管理员</a></li>
                      <li><a style="width:250px"href="${APP_PATH}/adLog/${user.id }">管理员日志</a></li>
                      <li><a style="width:250px" href="#">上传附件</a></li>
                  </ul>
              </li>
              <li class="sub-menu active">
                  <a href="javascript:;" class="" style="width:100%">
                      <i class="icon-cogs"></i>
                      <span>人员管理</span>
                      <span class="arrow"></span>
                  </a>
                  <ul class="sub" style="margin-left:-25%">
                      <li ><a style="width:250px" href="${APP_PATH}/index1/${user.id }">查看人员</a></li>
                      <li class="active"><a style="width:250px" href="#">导入表格</a></li>
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
               导入人员表
                   </h3>
                   <ul class="breadcrumb">
                       <li>
                           <a href="#">首页</a>
                           <span class="divider">/</span>
                       </li>
                       <li class="active">
                            导入人员表
                       </li>
                   </ul>

               </div>
            </div>

         <!--显示信息 -->
           <div class="row-fluid">
                <div class="span12">
                    
                    <div class="widget red">
                        <div class="widget-title">
                            <h4><i class="icon-asterisk"></i> 文件导入导出</h4>
                            <span class="tools">
                            <a href="javascript:;" class="icon-chevron-down"></a>
                            <a href="javascript:;" class="icon-remove"></a>
                            </span>
                        </div>
                        <div class="widget-body form">
                            <form action="${APP_PATH}/downLoadExcel/dao" method="post" id="form2" >  
   				 				<input type="submit" id="exportExcel" class="btn btn-large btn-success" name="exportExcel" value="Excel模板文件"/>  
							</form> </br></br>
                            <form id="form1" enctype="multipart/form-data">
                            	<div style="width:50%">
                            	<input type="file" id="xlsxup" name="xlsxup" class="btn  btn-primary"/>
                            	</div>
                            	<span style="display:block;margin-top:-2%;margin-left:25%;font-size:15px">文件以xlsx结尾</span></br></br></br>
                            </form>
                            <form action="${APP_PATH}/downLoadExcel/dai" method="post" id="form2">  
   				 				<input type="submit" id="exportExcel" class="btn btn-large btn-success" name="exportExcel" value="Excel导出"/>  
							</form> 
                        </div>
                    </div>
                    
                </div>
                	
            </div>
            
         </div>
         
      </div>
      </div>
      

<!-- 修改状态弹出框 s-->

<div class="modal fade" id="state" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" >
		<div class="modal-content" style="background-color:#79FF79">
			 <!--   <div class="modal-header" >
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" >
					修改个人信息
				</h4>
			</div>-->
			<div class="modal-body" style="padding:0;margin-top:3%;font-size:20px;">
				<p id = "p1" style="color:black;margin-left:20%"></p>
			</div>
			<div class="modal-footer" style="border:0px;">
				<button type="button"  class="btn btn-default" data-dismiss="modal" >关闭
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
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
	
   <div id="footer">
       2013 &copy; MetroAdmin.
   </div>
  <script type="text/javascript">
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
	  
	  //导入文件
	  $("#xlsxup").bind('change',function(){
		  var fileName = $('.xlsxup').val();
		  var extension = fileName.substring(fileName.lastIndexOf('.'), fileName.length).toLowerCase();
		  if(extension!=".xlsx"){
			  return;
		  }
		  var data = new FormData();
          data.append('file', $('#xlsxup')[0].files[0]);
		  $.ajax({
              url:"${APP_PATH}/uploadExcel",
              type:"POST",
              data: data,
              cache: false,
              contentType: false, //不可缺参数
              processData: false, //不可缺参数  
              success:function(result){
            	  if(result.code==100){
            		  window.location.href="${APP_PATH}/index1/${user.id }";
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
	  
	  //下载表格  ajax不能下载
	 /* $("#downLoad").click(function(){
		  $.ajax({
              url:"${APP_PATH}/downLoadExcel",
              type:"POST",
              data:$('#form1').serialize(),
              success:function(result){
            	  /*if(result.code==100){
            		  //window.location.href="${APP_PATH}/index1/${user.id }";
            	  }else{
            		  $('#pwd').modal('hide');
                    	$("#p1").text("导出文件失败");
                    	$('#state').modal('show');
                    	$("#state").on("hide.bs.modal",function(e){
                    			location.reload();
                      		});
            	  }
              },  
              error: function(result){
            	  
              }  
          });
	  }) */
   </script>
   <script type="text/javascript" src="${APP_PATH }/static/js/jquery-3.0.0.min.js"></script>
   <script src="${APP_PATH }/static/js/jquery.nicescroll.js" type="text/javascript"></script>
   <script type="text/javascript" src="${APP_PATH }/static/js/jquery-ui-1.9.2.custom.min.js"></script>
   <script type="text/javascript" src="${APP_PATH }/static/js/jquery.slimscroll.min.js"></script>
   <script src="${APP_PATH }/static/js/fullcalendar.min.js"></script>
   <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
   <script src="${APP_PATH }/static/js/dropzone.js"></script>
   
 <!--[if lt IE 9]>
   <script src="http://www.js-css.cn/js/excanvas.js"></script>
   <script src="http://www.js-css.cn/js/respond.js"></script>
   <![endif]-->
   <script src="${APP_PATH }/static/js/jquery.scrollto.min.js"></script>
   <script src="${APP_PATH }/static/js/common-scripts.js"></script>

<meta http-equiv="content-type" content="text/html;charset=UTF-8">
</body>
</html>