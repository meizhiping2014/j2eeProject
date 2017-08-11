<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>重置用户密码</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		<link href="${ctx}/scripts/bootstrap/fontcss.css" rel="stylesheet">
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
			    <label for="account" class="col-sm-2 control-label">账户名称：</label>
			    <div class="col-sm-3">
			      ${user.account}
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="name" class="col-sm-2 control-label">姓名：</label>
			    <div class="col-sm-3">
			      ${user.name}
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="organization_id" class="col-sm-2 control-label">所属机构码：</label>
			    <div class="col-sm-3">
			    	${o.code}
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="organization_id" class="col-sm-2 control-label">所属机构：</label>
			    <div class="col-sm-3">
			    	${o.name}
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="sex_male" class="col-sm-2 control-label">原密码：</label>
			     <div class="col-sm-3">
					<input type="password" class="form-control password_test" name="password" id="password" placeholder="请输入原密码">
				</div>
			</div>
			
			<div class="form-group">
			    <label for="age" class="col-sm-2 control-label">新密码：</label>
			    <div class="col-sm-3">
			    	<input type="password" class="form-control password_test" name="new_password" id="new_password" placeholder="请输入新密码">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="email" class="col-sm-2 control-label">确认新密码：</label>
			    <div class="col-sm-3">
			    	<input type="password" class="form-control password_test" name="comfirm_password" id="comfirm_password" placeholder="请输入确认新密码">
			    </div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="button" class="btn btn-primary" id="resetPassBtn"><img src="${ctx}/images/save.png" />&nbsp;保存</button>
			      <span class="error-tip msg"></span>
			    </div>
			</div>
			
		  	
		</form>
	</body>
	
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(function(){
			// 校验原密码是否正确
			var flag = true;
			$('#password').blur(function(){
				if($(this).val()){
					$.ajax({
						url:'${ctx}/control/user/validatepass',
						data:{'userid':'${user.account}','password':$('#password').val()},
						type:'post',
						dataType:'json',
						success:function(data){
							flag = data ? data.flag : flag
							$('.msg').html((data && !data.flag) ? '原密码不正确' : '')
						}
					});
				}
			});
			
			$('#resetPassBtn').click(function(){
				
				var error_tip = $('.msg');
					error_tip.html('');
				
				var password = $('#password');
		    	var trim_password  = Reg.trim(password.val());
		    	if(Reg.isNull(trim_password)){
		    		error_tip.html('&nbsp;请输入原密码');
		    		password.focus();
		    		return ;
		    	}
		    	
		    	if(!flag){
		    		error_tip.html('原密码不正确')
		    		password.focus();
		    		return 
		    	}
		    	
		    	var new_password = $('#new_password')
		    	var trim_new_password  = Reg.trim(new_password.val());
		    	if(Reg.isNull(trim_new_password)){
		    		error_tip.html('&nbsp;请输入新密码');
		    		new_password.focus();
		    		return ;
		    	}
		    	
		    	if(trim_new_password.length < 6){
		    		error_tip.html('&nbsp;新密码长度至少为6位');
		    		new_password.focus();
		    		return ;
		    	}
		    	
		    	var comfirm_password = $('#comfirm_password')
		    	var trim_comfirm_password = Reg.trim(comfirm_password.val());
		    	if(Reg.isNull(trim_comfirm_password)){
		    		error_tip.html('&nbsp;请输入确认新密码');
		    		comfirm_password.focus();
		    		return ;
		    	}
		    	
		    	if(trim_new_password !== trim_comfirm_password){
		    		error_tip.html('&nbsp;新密码不一致');
		    		return;
		    	}
		    	
		    	if(!error_tip.html()){
		    		$.ajax({
		    			url:'${ctx}/control/user/resetpass',
		    			data:{'id':'${user.id}','newpassword':$('#new_password').val()},
		    			type:'post',
						dataType:'json',
						success:function(data){
							if(data && data.code == '0'){
			        				top.dialog({
						        		title:'消息',
						        		content:'操作成功',
						        		ok:function(){
						        			window.location.href = window.location.href;
						        		}
					        		}).show();
			        			}else{
			        				top.dialog({
						        		title:'消息',
						        		content:'操作失败',
						        		ok:function(){}
					        		}).show();
			        			}
						}
		    		});
		    	}
		    	
		    	
			});
		});
	</script>
</html>