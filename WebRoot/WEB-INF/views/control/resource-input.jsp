<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.megaaa.commons.utils.constants.ControlConstant"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>添加资源</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" type="text/css" />
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
		<form id="resource-form" class="form-horizontal" role="form" >
			
			<div class="form-group">
			    <label for="parent_id" class="col-sm-2 control-label">父资源：</label>
			    <div class="col-sm-3">
			    	<select id="parent_id" name="parent_id" data-placeholder="请选择父资源..." class="chosen-select">
			    		<option value="<%=ControlConstant.RESOURCE_ROOT %>"></option>
			    		<c:forEach items="${resources}" var="resource" varStatus="status">
			    			<optgroup label="${resource.name}">
				    			<c:forEach var="m" items="${map}">
				    				<c:if test="${m.key eq resource.id}">
				    					<c:forEach var="r" items="${m.value}">
				    						<option value="${r.id}">${r.name}</option>
				    					</c:forEach>
				    				</c:if>
				    			</c:forEach>
				    		</optgroup>
			    		</c:forEach>
			    	</select>
			    	
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="name" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>资源名称：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control" name="name" id="name" placeholder="请输入资源名称">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="path" class="col-sm-2 control-label">资源路径：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control" name="path" id="path" placeholder="请输入资源路径">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="path" class="col-sm-2 control-label">资源类型：</label>
			    <div class="col-sm-3">
				<input type="radio" name="resource_type" id="resourceTypeMENU" value="2" checked="checked"/><label for="resourceTypeMENU">菜单</label>
				<input type="radio" name="resource_type" id="resourceTypeFUNCTION" value="3"/><label for="resourceTypeFUNCTION">功能类型</label>
			    </div>
			</div>
			
			
			<div class="form-group">
			    <label for="order_num" class="col-sm-2 control-label">排列顺序：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control password_test" name="order_num" id="order_num" >
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="description" class="col-sm-2 control-label">资源描述：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control password_test" name="description" id="description" >
			    </div>
			</div>
			
			
			<div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="button" class="btn btn-primary" id="saveResource">保存</button>
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
	<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$('#saveResource').click(function(){
				var error_tip = $('.msg');
				error_tip.html('');
				
				var parent_id = $('#parent_id'),
					trim_parent_id = Reg.trim(parent_id.val());
				if(Reg.isNull(trim_parent_id)){
					error_tip.html('&nbsp;请选择父资源')
					parent_id.focus();
					return ;
				}
				
				var name = $('#name'),
					trim_name =  Reg.trim(name.val());
				if(Reg.isNull(trim_name)){
					error_tip.html('&nbsp;请输入资源名称')
					name.focus();
					return ;
				}
				
				/**
				var trim_path = Reg.trim(path.val());
				if(Reg.isNull(trim_path)){
					error_tip.html('&nbsp;请输入资源路径')
					path.focus();
					return ;
				}*/
				
				$.ajax({
		        	url:'${ctx}/control/resource/add',
		        	type:'post',
		        	dataType:'json',
		        	data:$('#resource-form').serialize(),
		        	success:function(data){
		        		if(data && data.code == '-1'){
		        			dialog({
		        				id:'org-add-dialog',
		        				title:'消息',
		        				content:'&nbsp;添加失败',
		        				 okValue: '确定',
		        				 ok: function () {
		        				 	window.location.href = window.location.href;
		        				 }
		        			}).show();
		        		}else{
		        			dialog({
		        				id:'org-add-dialog',
		        				title:'消息',
		        				content:'&nbsp;添加成功',
		        				 okValue: '确定',
		        				 ok: function () {
		        				 	window.location.href = window.location.href;
		        				 }
		        			}).show();
		        		}
		        	}
		        });
		        
			});
			
			// 初始化机构选择框
			$(".chosen-select").chosen({});
		});
	</script>
</html>
