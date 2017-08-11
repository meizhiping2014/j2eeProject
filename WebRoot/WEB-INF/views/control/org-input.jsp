<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>机构列表</title>
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
	
	<form id="org-form" class="form-horizontal" role="form" >
			
			<div class="form-group">
			    <label for="organization_id" class="col-sm-2 control-label">父机构：</label>
			    <div class="col-sm-3">
			    	<select id="parent_id" name="parent_id" data-placeholder="请选择父机构..." class="chosen-select">
			    		<option value=""></option>
			    		<c:forEach items="${organizationVOs}" var="org" varStatus="status">
				    		<optgroup label="${org.name}">
				    			<c:forEach items="${map}" var="m">
				    				<c:if test="${m.key eq org.id}">
				    					<c:forEach items="${m.value}" var="o">
				    						<option value="${o.id}">${o.name}</option>
				    					</c:forEach>
				    				</c:if>
				    			</c:forEach>
				    		</optgroup>
			    		</c:forEach>
			    	</select>
			    </div>
			</div>
			
			<!--  <div class="form-group">
			    <label for="account" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>机构码：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control" name="code" id="code" placeholder="请输入机构码" readonly="readonly" value="${org_code}" />
			    </div>
			</div>-->
			
			<div class="form-group">
			    <label for="name" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>名称：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control" name="name" id="name" placeholder="请输入名称">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="password" class="col-sm-2 control-label">地址：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control password_test" name="address" id="address" >
			    </div>
			</div>
			
			
			<div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="button" class="btn btn-primary" id="saveOrg">保存</button>
			      <span class="error-tip msg"></span>
			    </div>
		  	</div>
		  	
		  	
		</form>
				
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	<script src="${ctx}/scripts/chosen/chosen.jquery.min.js"></script>
	<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			$('#saveOrg').click(function(){
				
				var error_tip = $('.msg');
				error_tip.html('');
				
				/** var parent_id = $('#parent_id'),
					trim_parent_id = Reg.trim(parent_id.val());
				if(Reg.isNull(trim_parent_id)){
					error_tip.html('&nbsp;请选择机构')
					parent_id.focus();
					return ;
				}
				
				var org_code = $('#code'),
					trim_code =  Reg.trim(org_code.val());
				if(Reg.isNull(trim_code)){
					error_tip.html('&nbsp;请输入机构编码')
					code.focus();
					return ;
				}**/
				
				var name = $('#name'),
					trim_name = Reg.trim(name.val());
				if(Reg.isNull(trim_name)){
					error_tip.html('&nbsp;请输入机构名称')
					name.focus();
					return ;
				}
				
				$.ajax({
		        	url:'${ctx}/control/org/add',
		        	type:'post',
		        	dataType:'json',
		        	data:$('#org-form').serialize(),
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
	</body>
</html>