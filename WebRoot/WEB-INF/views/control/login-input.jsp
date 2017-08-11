<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.joda.time.DateTime"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>米加</title>

<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
<link href="${ctx}/scripts/bootstrap/fontcss.css" rel="stylesheet">

<!--[if lt IE 9]>
<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
<script src="${ctx}/scripts/control/js/respond.min.js"></script>
<![endif]-->

<style type="text/css">
	.error_tip{
		color:#f00;
	}
	body{
		background: #eee url(${ctx}/images/furley_bg.png);;
	}
	.form-control{
		border: 1px solid #ccc;
	}
	
	.control-label a:link{
		text-decoration: none;
		color:#30a5ff;
	}
	
	.control-label a:hover{
		color: #428bca;
		text-decoration: underline;
	}
	
</style>
</head>

<body>




<div class="container-fluid">

	<div class="row">
		<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-3 col-md-offset-4">
			<!--  <img src="${ctx}/images/logo-small.png" class="img-responsive center-block"/>-->
		</div>
	</div>
	<div class="row">
		<p>&nbsp;</p>
		<p>&nbsp;</p>
	</div>
	<div class="row">
		<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-3 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<center>登录</center>
				</div>
				<div class="panel-body">
					
					<form class="form-horizontal" id="login-form" role="form" action="${ctx}/control/login/auth" method="post">
					  <div class="form-group">
					    <label for="username" class="col-sm-4 control-label">用户名</label>
					    <div class="col-sm-5">
					      <input class="form-control" name="username" id="username" type="text" autofocus="autofocus" placeholder="请输入用户名" value="${username}" />
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="password" class="col-sm-4 control-label">密码</label>
					    <div class="col-sm-5">
					      <input type="password" class="form-control" name="password" id="password" value="" placeholder="请输入密码" />
					    </div>
					  </div>
					  <div class="form-group">
					  	<label for="code" class="col-sm-4 control-label">验证码</label>
					    <div class="col-sm-3">
					    	<input type="text" class="form-control" name="code" id="code" value="" maxlength="4" placeholder="请输入验证码" />
					    </div>
					    <label for="code" class="control-label">
					    	<img src="${ctx}/security/verifycode.jpg" id="verifycode-img"  width="60" height="23" />
					    	<a href="javascript:;" id="verifycode">换一张</a>
					    </label>
					  </div>
					  <div class="form-group">
					    <div class="col-sm-offset-3 col-sm-6">
					      <a href="javascript:;" class="btn btn-primary btn-lg btn-block" id="login_btn">登录</a>
					    </div>
					    
					  </div>
					   <div class="form-group">
					    <div class="col-sm-offset-3 col-sm-5">
					     	<p class="error_tip msg">${msg}</p>
					    </div>
					  </div>
					</form>

<%-- 
					<form id="login-form" role="form" action="${ctx}/control/login/auth" method="post" class="form-signin">
						<fieldset>
							<div class="form-group">
								<div class="input-group">
							      <div class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
							      <input class="form-control" placeholder="用户名" name="username" id="username" type="text" autofocus="autofocus" value="${username}" />
							    </div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
									<input class="form-control" placeholder="密码" name="password" id="password" type="password" value="" width="200"/>
								</div>
							</div>
							<div class="form-group">
								<div class="input-group">
									<div class="input-group-addon"></div>
									<input class="form-control" placeholder="验证码" name="password" id="password" type="text" value="" width="200"/>
								</div>
							</div>
							<a href="javascript:;" class="btn btn-primary" id="login_btn">登录</a>
							<span class="error_tip msg">${msg}</span>
						</fieldset>
					</form>--%>
				</div>
			</div>
		</div>
	</div>
	
	<div class="row navbar-fixed-bottom">
		<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-3 col-md-offset-5">
				 &copy;&nbsp;<%=new DateTime().getYear() %>&nbsp;米加
		</div>
	</div>
	
</div>
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/plugins/bootstrap-add-clear/bootstrap-add-clear.min.js" charset="utf-8"></script>
	<script type="text/javascript">
		!function ($) {
			$(document).on("click","ul.nav li.parent > a > span.icon", function(){		  
				$(this).find('em:first').toggleClass("glyphicon-minus");	  
			}); 
			$(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function () {
		  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show')
		});
		
		$(window).on('resize', function () {
		  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide')
		});
		
		$(document).ready(function(){
		
			$('#verifycode').click(function(){
				$('#verifycode-img').attr("src",'${ctx}/security/verifycode.jpg?' + new Date().getTime());
			});
		
			$('#login_btn').click(function(){
				var username = $('#username'),
				password = $('#password'),
				code = $('#code'),
				msgHtml = $('.msg');
				
				var trim_username  = Reg.trim(username.val());
		    	if(Reg.isNull(trim_username)){
		    		msgHtml.html('&nbsp;请您填写用户名');
		    		username.focus();
		    		return ;
		    	}
		    	
		    	var trim_password = Reg.trim(password.val());
		    	if(Reg.isNull(trim_password)){
		    		msgHtml.html('&nbsp;请您填写密码');
		    		password.focus();
		    		return ;
		    	}
		    	
		    	var trim_code = Reg.trim(code.val());
		    	if(Reg.isNull(trim_code)){
		    		msgHtml.html('&nbsp;请您填写验证码');
		    		code.focus();
		    		return ;
		    	}
		    	
		    	$('#login-form').submit();
			});
			
			if(window.parent.length>0){ 
              window.parent.location = "${ctx}/login.jsp"; 
			}
			
		   $('input[name="code"]').keydown(function(event){
		     if(event.keyCode==13){
		          $('#login_btn').click();
		     }
		   });
		   
		   $('#username').addClear({
		   	symbolClass: "glyphicon glyphicon-remove-circle"
		   });
		   
		   $('#password').addClear({
		   	symbolClass: "glyphicon glyphicon-remove-circle"
		   });
		   
		});
	</script>	
</body>

</html>