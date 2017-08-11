<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>修改用户</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">

		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/chosen/chosen.min.css" />
		
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
		<script src="${ctx}/scripts/control/js/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
			.error-tip{
				color:#dd4b39;
			}
		</style>
	</head>

	<body>
	
		<form id="user-form" class="form-horizontal" role="form" action="${ctx}/control/user/edit" method="post" >
		
			<div class="form-group">
			    <label for="account" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>账户名称：</label>
			    <div class="col-sm-3">
			    	<input type="hidden" name="id" value="${user.id}"/>
			      <input type="text" class="form-control" name="account" id="account" readonly="readonly" placeholder="请输入账户名称" value="${user.account}" maxlength="16" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="name" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>姓名：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control" name="name" id="name" placeholder="请输入姓名" value="${user.name}" maxlength="16" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="password" class="col-sm-2 control-label">密码：</label>
			    <div class="col-sm-3">
			      <input type="password" class="form-control password_test" name="password" id="password" placeholder="请输入密码" />
			      <p class="help-block">至少6位，区分大小写</p>
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="repassword" class="col-sm-2 control-label">确认密码：</label>
			    <div class="col-sm-3">
			    	<input type="password" class="form-control password_test" id="repassword" placeholder="请输入确认密码" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="organization_id" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>所属部门：</label>
			    <div class="col-sm-3">
			    	<select id="organization_id" name="organization_id" data-placeholder="请选择部门..." class="chosen-select">
			    		<option value=""></option>
			    		
			    		<c:forEach items="${organizationVOs}" var="org" varStatus="status">
				    		<optgroup label="${org.name}">
				    			<c:forEach items="${map}" var="m">
				    				<c:if test="${m.key eq org.id}">
				    					<c:forEach items="${m.value}" var="o">
				    						<option value="${o.id}" <c:if test="${user.organization_id eq o.id}">selected</c:if> >${o.name}</option>
				    					</c:forEach>
				    				</c:if>
				    			</c:forEach>
				    		</optgroup>
			    		</c:forEach>
			    		
			    	</select>
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="sex_male" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>用户性别：</label>
			     <div class="col-sm-3">
				    <label class="radio-inline">
					  <input type="radio" name="sex" id="sex_male" checked="checked" value="10" <c:if test="${user.sex eq '10'}">checked</c:if> />男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="sex" id="sex_female" value="11" <c:if test="${user.sex eq '11'}">checked</c:if> />女
					</label>
				</div>
			</div>
			
			<div class="form-group">
			    <label for="age" class="col-sm-2 control-label">用户年龄：</label>
			    <div class="col-sm-3">
			    	<input type="text" class="form-control" name="age" id="age" value="${user.age}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="email" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>邮件：</label>
			    <div class="col-sm-3">
			    	<input type="email" class="form-control" name="email" id="email" placeholder="请输入邮件" value="${user.email}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="office_phone" class="col-sm-2 control-label">办公电话：</label>
			    <div class="col-sm-3">
			    	<input type="text" class="form-control" name="office_phone" id="office_phone" value="${user.office_phone}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="mobile" class="col-sm-2 control-label">移动电话：</label>
			    <div class="col-sm-3">
			    	<input type="text" class="form-control" name="mobil_phone" id="mobile" value="${user.mobil_phone}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="button" class="btn btn-primary" id="saveUser"><img src="${ctx}/images/save.png" />&nbsp;保存</button>
			      <button type="button" class="btn btn-primary" id="back" onclick="javascript:window.location.href='${ctx}/control/user/list'"><img src="${ctx}/images/back.png" />&nbsp;返回</button>
			      <span class="error-tip msg"></span>
			    </div>
		  	</div>
		  	
		  	
		</form>
	</body>
	
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	<script src="${ctx}/scripts/chosen/chosen.jquery.min.js"></script>
	
	
	<script type="text/javascript">
		
		$(document).ready(function(){
			
			$('#saveUser').click(function(){
			
				var error_tip = $('.msg');
				error_tip.html('');
				
				var account = $('#account');
				var trim_account  = Reg.trim(account.val());
		    	if(Reg.isNull(trim_account)){
		    		error_tip.html('&nbsp;请输入账户名');
		    		account.focus();
		    		return ;
		    	}
		    	
		    	var name = $('#name');
		    	var trim_name  = Reg.trim(name.val());
		    	if(Reg.isNull(trim_name)){
		    		error_tip.html('&nbsp;请输入姓名');
		    		name.focus();
		    		return ;
		    	}
		    	
		    	 
		    	var password = $('#password');
		    	var trim_password  = Reg.trim(password.val());
		    	/** if(Reg.isNull(trim_password)){
		    		error_tip.html('&nbsp;请输入密码');
		    		password.focus();
		    		return ;
		    	}**/
		    	
		    	if(trim_password && trim_password.length < 6){
		    		error_tip.html('&nbsp;密码长度至少为6位');
		    		password.focus();
		    		return ;
		    	}
		    	
		    	var repassword = $('#repassword');
		    	var trim_repassword  = Reg.trim(repassword.val());
		    	if(trim_password && Reg.isNull(trim_repassword)){
		    		error_tip.html('&nbsp;请输入确认密码');
		    		repassword.focus();
		    		return ;
		    	}
		    	
		    	if(trim_password !== trim_repassword){
		    		error_tip.html('&nbsp;密码不一致');
		    		return;
		    	}
		    	
		    	var org = $('#organization_id');
		    	var trim_org  = Reg.trim(org.val());
		    	if(Reg.isNull(trim_org)){
		    		error_tip.html('&nbsp;请选择所属部门');
		    		org.focus();
		    		return ;
		    	}
		    	
		    	var age = $('#age');
		    	var trim_age  = Reg.trim(age.val());
		    	if(trim_age && !Reg.noZeroInt(trim_age)){
		    		error_tip.html('&nbsp;年龄只能为正整数');
		    		age.focus();
		    		return ;
		    	}
		    	
		    	var email = $('#email');
		    	var trim_email = Reg.trim(email.val());
		    	if(Reg.isNull(trim_email)){
		    		error_tip.html('&nbsp;请输入邮件地址');
		    		email.focus();
		    		return ;
		    	}
		    	
		    	if(!Reg.email(trim_email)){
		    		error_tip.html('&nbsp;邮件格式不正确');
		    		email.focus();
		    		return ;
		    	}
		    	
		    	$('#user-form').submit();
		    	
			});
			
			// 初始化部门选择框
			$(".chosen-select").chosen({});
		});
	</script>
</html>