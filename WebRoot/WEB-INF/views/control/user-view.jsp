<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>个人资料</title>
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
			    <label for="sex_male" class="col-sm-2 control-label">用户性别：</label>
			     <div class="col-sm-3">
					<c:if test="${user.sex eq '10'}">男</c:if>
					<c:if test="${user.sex eq '11'}">女</c:if>
				</div>
			</div>
			
			<div class="form-group">
			    <label for="age" class="col-sm-2 control-label">用户年龄：</label>
			    <div class="col-sm-3">
			    	${user.age}
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="email" class="col-sm-2 control-label">邮件：</label>
			    <div class="col-sm-3">
			    	${user.email}
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="office_mobile" class="col-sm-2 control-label">办公电话：</label>
			    <div class="col-sm-3">
			    	${user.office_phone}
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="mobile" class="col-sm-2 control-label">移动电话：</label>
			    <div class="col-sm-3">
			    	${user.mobil_phone}
			    </div>
			</div>
			
		  	
		</form>
	</body>
	
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	
</html>