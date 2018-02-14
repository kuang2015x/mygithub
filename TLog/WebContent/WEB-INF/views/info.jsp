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
              <li class="sub-menu active">
                  <a class="" href="index.html" style="width:100%">
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
                      <li><a style="width:250px" href="${APP_PATH}/users">查看管理员</a></li>
                      <li><a style="width:250px" href="#">创建管理员</a></li>
                      <li><a style="width:250px"href="#">管理员日志</a></li>
                      <li><a style="width:250px" href="#">上传附件</a></li>
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
               个人信息
                   </h3>
                   <ul class="breadcrumb">
                       <li>
                           <a href="#">首页</a>
                           <span class="divider">/</span>
                       </li>
                       <li class="active">
                            个人信息
                       </li>
                   </ul>

               </div>
            </div>

         </div>
         <!--显示个人信息 -->
         <div class="row-fluid" style="margin-left:10%">
                    <div class="span8">
                        
                        <div class="widget purple">
                            <div class="widget-title">
                                <h4><i class="icon-reorder"></i> basic table</h4>
                                <button class="btn btn-mini btn-primary" style="margin-left:70%;margin-top:0.3%" id="popup" >
                                <i class="icon-pencil icon-white"> 修改</i>
                                </button>
                            <span class="tools">
                                <a href="javascript:;" class="icon-chevron-down"></a>
                                <a href="javascript:;" class="icon-remove"></a>
                            </span>
                            </div>
                            <div class="widget-body">
                                <table class="table">
                                    <tbody>
                                    <tr>
                                        <td>姓名：</td>
                                        <td id="v1"><c:out value="${user.name }"></c:out></td>
                                    </tr>
                                    <tr>
                                        <td>邮箱</td>
                                        <td id="v2"><c:out value="${user.email }"></c:out></td>
                                        <td id="v3" hidden="hidden"><c:out value="${user.id }"></c:out></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                    </div>
                </div> 
      </div>
        
   </div>
   
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header" >
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" >
					修改个人信息
				</h4>
			</div>
			<div class="modal-body">
			<form class="form-horizontal">
				<div class="control-group">
                <label class="control-label">姓名</label>
                	<div class="controls" style="margin-left:10%;margin-top:-3%">
                		<input type="text" id="input1" class="input-xlarge" style="width:215px;padding-left:5px"/>
                	</div>
                </div>
                <div class="control-group">
	                <label class="control-label">Email</label>
	                <div class="controls" style="margin-left:10%;margin-top:-3%">
		                <div class="input-icon left" >
			                <i class="icon-envelope"></i>
			                <input id="input2" type="text"/>
		                </div>
	                </div>
                </div>
                </form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-primary" id="update">
					确认
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
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
   
   /**$(function () {  //这样也可以实现
	   var va1=null;
	   var va2=null;
	   //alert(va2);
	   $("table").each(function(){
		   va1=$(this).find('td').eq(1).text();
		   va2=$(this).find('td').eq(3).text();
	   })
	    $('#popup').on('click', function(){
	      $('#myModal').modal('show');
	    });
	    $('#myModal').on('show.bs.modal', function (event) {
	      var modal = $(this);  //get modal itself
	      //modal.find('.modal-body #input1').text(va1);
	      //modal.find('.modal-body #input2').text(va2);
	      $("#input1").val(va1);
	      $("#input2").val(va2);
	    });
	  });**/
   		$("#popup").click(function(){
   			//alert(user.id);
   			var va1=null;
   		   var va2=null;
   		   var va3=null;
   		   //alert(va2);
   		   $("table").each(function(){
   			   va1=$(this).find('td').eq(1).text();
   			   va2=$(this).find('td').eq(3).text();
   			   va3=$(this).find('td').eq(4).text();
   		   })
   		$("#input1").val(va1);
 	      $("#input2").val(va2);
 	     $('#myModal').modal('show');
   		})
   		//修改个人信息
   		$("#update").click(function(){
   			var name=$("#input1").val();
   			var email=$("#input2").val();
   			var id;
   			$("table").each(function(){
    			   id=$(this).find('td').eq(4).text();
    		   })
            $.ajax({  
                type : "post",  
                url : "${APP_PATH}/update/"+id,
                dataType: 'json',
                data : {name:name,email:email},  
                success : function(result) {  
                    if(result.code==100){
                    	$('#myModal').modal('hide');
                    	$('#p1').text("修改成功");
                    	$('#state').modal('show');
                    	$("#state").on("hide.bs.modal",function(e){
                    		//hide方法后调用
                    			 $("table").each(function(){
					   			   $(this).find('td').eq(1).text(name);
					   			   $(this).find('td').eq(3).text(email);
					   			   
					   		   })
                    		});
                    	
                    } else{
                    	$('#myModal').modal('hide');
                    	$("#p1").text("修改失败");
                    	$('#state').modal('show');
                    } 
                }  
            });
   		})
   		
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