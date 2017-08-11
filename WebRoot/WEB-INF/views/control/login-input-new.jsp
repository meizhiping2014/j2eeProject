<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.joda.time.DateTime"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>跨境电商</title>

<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/scripts/olive/css/bootstrap-reset.css" rel="stylesheet"><!-- BOOTSTRAP CSS -->
<link href="${ctx}/scripts/olive/assets/font-awesome/css/font-awesome.css" rel="stylesheet"><!-- FONT AWESOME ICON CSS -->
<link href="${ctx}/scripts/olive/css/style.css" rel="stylesheet"><!-- THEME BASIC CSS -->
<link href="${ctx}/scripts/olive/css/style-responsive.css" rel="stylesheet"><!-- THEME RESPONSIVE CSS -->
<!--[if lt IE 9]>
<script src="${ctx}/scripts/olive/js/html5shiv.js">
</script>
<script src="${ctx}/scripts/olive/js/respond.min.js">
</script>
<![endif]-->


<style type="text/css">
	.error_tip{
		color:#f00!important;
	}
</style>
</head>

<body class="login-screen">
 <!-- BEGIN SECTION -->
    <div class="container">
      <form class="form-signin" id="login-form" action="${ctx}/control/login/auth" method="post">
        <h2 class="form-signin-heading">
          登&nbsp;&nbsp;录
        </h2>
		<!-- LOGIN WRAPPER  -->
        <div class="login-wrap">
          <input type="text" class="form-control" name="username" id="username" type="text" autofocus="autofocus" placeholder="请输入用户名" value="${username}" />
          <input type="password" class="form-control" name="password" id="password" value="" placeholder="请输入密码" />
          <label class="checkbox">
            <input type="text" class="form-control" id="code" name="code" placeholder="请输入验证码" style="width:40%;float: left;"/>
            <img src="${ctx}/security/verifycode.jpg" id="verifycode-img"  width="58" height="23" style="margin-top: 5px;margin-left: 10px;" />
            <a href="javascript:;" id="verifycode" style="margin-top: 5px;">看不清?</a>
          </label>
          <button class="btn btn-lg btn-login btn-block" type="button" id="login_btn">登录</button>
          <p class="error_tip msg">${msg}</p>
          <!--  <p>
            or you can sign in via social network
          </p>
          <div class="login-social-link">
            <a href="index.html" class="facebook">
              <i class="fa fa-facebook">
              </i>
              Facebook
            </a>
            <a href="index.html" class="twitter">
              <i class="fa fa-twitter">
              </i>
              Twitter
            </a>
          </div>
          <div class="registration">
            Don't have an account yet?
            <a class="" href="registration.html">
              Create an account
            </a>
          </div>-->
        </div>
		<!-- END LOGIN WRAPPER -->
		<!-- MODAL -->
        <div  id="myModal" class="modal fade">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                  &times;
                </button>
                <h4 class="modal-title">
                  Forgot Password ?
                </h4>
              </div>
              <div class="modal-body">
                <p>
                  Enter your e-mail address below to reset your password.
                </p>
                <input type="text" name="email" placeholder="Email" autocomplete="off" class="form-control placeholder-no-fix">
              </div>
              <div class="modal-footer">
                <button data-dismiss="modal" class="btn btn-default" type="button">
                  Cancel
                </button>
                <button class="btn btn-success" type="button">
                  Submit
                </button>
              </div>
            </div>
          </div>
        </div>
		<!-- END MODAL -->
      </form>
    </div>
    <!-- END SECTION -->





<%-- 
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

				</div>
			</div>
		</div>
	</div>
	
	<div class="row navbar-fixed-bottom">
		<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-3 col-md-offset-5">
				 &copy;&nbsp;<%=new DateTime().getYear() %>&nbsp;米加
		</div>
	</div>
	
</div>--%>
</body>
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/plugins/bootstrap-add-clear/bootstrap-add-clear.min.js" charset="utf-8"></script>
	<script type="text/javascript">
		
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
			   	console.log(1231)
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
</html>