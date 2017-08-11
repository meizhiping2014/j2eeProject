<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>资源列表</title>

		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/zTree/css/zTreeStyle/zTreeStyle.css" />
		
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
		<script src="${ctx}/scripts/control/js/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
			.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
			.error-tip{
				color:#dd4b39;
			}
			.panel-primary {
			    border-color: #30a5ff!important;
			}
			.panel-heading{
				background-color: #30a5ff!important;
				border-color: #30a5ff!important;
			}
		</style>
	</head>
	<body>
	
		
		<div class="panel panel-primary">
		  <div class="panel-heading">
		    <h3 class="panel-title">资源树形结构</h3>
		  </div>
		  <div class="panel-body">
		  	
		    <div class="row">
			  <div class="col-xs-12 col-sm-2 col-md-3">
			  	<div class="panel panel-default">
				  <div class="panel-body" >
				  	注：<img src="${ctx}/images/menu.png" />为菜单，<img src="${ctx}/images/function.png" />为功能
				    <ul id="resource-tree" class="ztree"></ul>
				  </div>
				</div>	
			  </div>
			  <div class="col-xs-6 col-md-9">
			  	<div class="panel panel-default">
				  <div class="panel-body">
				  	<iframe id="resource-frame" width="100%" height="680" frameborder="0" scrolling="auto" src=""></iframe>
				  </div>
				</div>
			  </div>
			</div>
			
		  </div>
		</div>
		
	</body>
	
	<script type="text/template" id="resource-add-template">
			<form id="resource-form">
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;父资源：<span id="p-org">{parent_name}</span></p>
			<p><span class="error-tip">*</span>&nbsp;资源名称：<input type="text" id="resource-name" name="name"/></p>
			<p>&nbsp;&nbsp;资源路径：<input type="text" id="resource-path" name="path" /></p>
			<p>&nbsp;&nbsp;资源类型：<input type="radio" name="resource_type" id="resourceTypeMENU" value="2" checked="checked"/><label for="resourceTypeMENU">菜单</label>
				<input type="radio" name="resource_type" id="resourceTypeFUNCTION" value="3"/><label for="resourceTypeFUNCTION">功能类型</label></p>
			<p>&nbsp;&nbsp;排列顺序：<input type="text" id="resource-order-num" name="order_num" /></p>
			<p>&nbsp;&nbsp;资源描述：<input type="text" id="resource-desc" name="description" /></p>
			</form>
	</script>
	
	<script type="text/template" id="resource-edit-template">
			<form id="resource-form">
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;父资源：<span id="p-org">{parent_name}</span></p>
			<p><span class="error-tip">*</span>&nbsp;资源名称：<input type="text" id="resource-name" name="name" value="{name}"/></p>
			<p>&nbsp;&nbsp;资源路径：<input type="text" id="resource-path" name="path" value="{path}" /></p>
			<p>&nbsp;&nbsp;排列顺序：<input type="text" id="resource-order-num" name="order_num" value="{order_num}" /></p>
			<p>&nbsp;&nbsp;资源描述：<input type="text" id="resource-desc" name="description" value="{description}" /></p>
			</form>
	</script>
		
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	<script src="${ctx}/scripts/zTree/js/jquery.ztree.all.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
	
	<script type="text/javascript">
		var setting = {
				view: {
					addHoverDom: addHoverDom,
					removeHoverDom: removeHoverDom,
					selectedMulti: false
				},
				callback: {
					onClick: zTreeOnClick,
					beforeRemove: beforeRemove,
					beforeEditName: beforeEditName,
					beforeDrag: beforeDrag
				},
				edit: {
					enable: true,
					showRemoveBtn: showRemoveBtn,
					removeTitle:'删除资源',
					showRenameBtn: showRenameBtn,
					renameTitle:'修改资源'
				},
				async: {
					enable: true,
					url:'${ctx}/control/resource/query',
					autoParam:["id", "name=n", "level=lv"],
					otherParam:{"otherParam":"zTreeAsyncTest"},
					dataFilter: filter
				}
			};
			
			var zNodes =[{ id:-1, pId:-1, name : "资源树",isParent: false,icon:"${ctx}/images/application.png"}];

			// 判断是否存在节点
			var count = '${count}';
			if(count > 0){
				zNodes[0].isParent = true;
			}
			
			function beforeDrag(){
				return false;
			}
			
			// 节点点击
			function zTreeOnClick(event, treeId, treeNode) {
				$('#resource-frame').attr('src','${ctx}/control/resource/query/'+ treeNode.id)
			}
			
			function beforeRemove(treeId, treeNode){
				
				var zTree = $.fn.zTree.getZTreeObj('resource-tree');
				
				var d = top.dialog({
					    title: '操作',
					    content:'<p class="error-tip">此操作会删除当前资源下的所有资源（请谨慎操作），确定执行操作？</p>',
					    okValue: '确定',
					    ok: function () {
					    	$.ajax({
					        	url:'${ctx}/control/resource/delete/'+treeNode.id,
					        	type:'post',
					        	dataType:'json',
					        	success:function(data){
					        		if(data && data.code == '-1'){
					        			top.dialog({
										    title: '消息',
										    content: '操作失败',
										    ok: function () {}
									    }).show();
					        		}else{
					        			top.dialog({
										    title: '消息',
										    content: '操作成功',
										    ok: function () {}
									    }).show();
					        		}
					        		refreshTree(zTree,treeNode.id,'delete');
					        	}
					        });
					    	
					    },
					    cancelValue: '取消',
					    cancel: function () {}
				});
				d.showModal();
				return false;
			}
			
			function beforeEditName(treeId, treeNode) {
			
				var resource_edit_template = $('#resource-edit-template').html();
				var t_parentNode = treeNode.getParentNode();
				
				resource_edit_template = resource_edit_template.replace('{parent_name}',((t_parentNode != '-1') ? t_parentNode.name : '无'))
					.replace('{name}',(treeNode.name || ''))
					.replace('{path}',(treeNode.path || ''))
					.replace('{order_num}',(treeNode.order_num || ''))
					.replace('{description}',(treeNode.description || ''));
					
				var zTree = $.fn.zTree.getZTreeObj('resource-tree');
					
					var d = top.dialog({
					    title: '修改资源',
					    content: resource_edit_template,
					    okValue: '确定',
					    statusbar: '<label class="error-tip msg"></label>',
					    ok: function () {
					    	
					    	var error_tip = top.$('.msg');
					    	error_tip.html('');
					    	var resource_name = top.$('#resource-name');
					    	var resource_path = top.$('#resource-path');
					    	var resource_order_num = top.$('#resource-order-num');
					    	
					    	var trim_resource_name = Reg.trim(resource_name.val());
					    	if(Reg.isNull(trim_resource_name)){
					    		error_tip.html('&nbsp;请输入资源名称');
					    		resource_name.focus();
					    		return false;
					    	}
					    	
					    	var trim_resource_order_num = Reg.trim(resource_order_num.val());
					    	if(!Reg.isNull(trim_resource_order_num) && !Reg.noZeroInt(trim_resource_order_num)){
					    		error_tip.html('&nbsp;排列顺序只能为数字');
					    		resource_order_num.focus();
					    		return false;
					    	}
					    	
					    	/**var trim_resource_path = Reg.trim(resource_path.val());
					    	if(Reg.isNull(trim_resource_path)){
					    		error_tip.html('&nbsp;请输入资源路径');
					    		resource_path.focus();
					    		return false;;
					    	}**/
					    	
					        $.ajax({
					        	url:'${ctx}/control/resource/edit/'+treeNode.id,
					        	type:'post',
					        	dataType:'json',
					        	data:top.$('#resource-form').serialize(),
					        	success:function(data){
					        		if(data && data.code == '-1'){
					        			top.dialog({
										    title: '消息',
										    content: '操作失败',
										    ok: function () {}
									    }).show();
					        		}else{
					        			top.dialog({
										    title: '消息',
										    content: '操作成功',
										    ok: function () {}
									    }).show();
					        		}
					        		refreshTree(zTree,treeNode.id,'edit');
					        	}
					        });
					    },
					    cancelValue: '取消',
					    cancel: function () {}
					});
					d.showModal();
					
					return false;
			}
	
			function showRemoveBtn(treeId, treeNode) {
				return treeNode.level > 1;
			}
	
			function showRenameBtn(treeId, treeNode) {
				return treeNode.id != -1;
			}

			// 添加资源
			function addHoverDom(treeId, treeNode) {
			
				if(treeNode.id == -1) return false;
				
				var sObj = $("#" + treeNode.tId + "_span");
				if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length > 0) return;
				
				var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
					+ "' title='添加资源' onfocus='this.blur();'></span>";
				sObj.append(addStr);
				
				var btn = $("#addBtn_" + treeNode.tId);
				if (btn) btn.bind("click", function(){
					
					var resource_add_template = $('#resource-add-template').html(),
						parent_id;
					// 设置父机构
					if(treeNode.id != '-1'){
						resource_add_template = resource_add_template.replace('{parent_name}',treeNode.name);
						parent_id = treeNode.id;
					}else{
						resource_add_template = resource_add_template.replace('{parent_name}','无');
					}
					
					var zTree = $.fn.zTree.getZTreeObj('resource-tree');
					
					var d = top.dialog({
						id:'resource-add-dialog',
					    title: '添加资源',
					    content: resource_add_template,
					    okValue: '确定',
					    statusbar: '<label class="error-tip msg"></label>',
					    ok: function () {
					    	
					    	var error_tip = top.$('.msg');
					    	error_tip.html('');
					    	
					    	var resource_name = top.$('#resource-name');
					    	var resource_path = top.$('#resource-path');
					    	var resource_order_num = top.$('#resource-order-num');
					    	var resource_type = top.$('input[name="resource_type"]:checked').val();
					    	
					    	var trim_resource_name = Reg.trim(resource_name.val());
					    	if(Reg.isNull(trim_resource_name)){
					    		error_tip.html('&nbsp;请输入资源名称');
					    		resource_name.focus();
					    		return false;
					    	}
					    	
					    	var trim_resource_order_num = Reg.trim(resource_order_num.val());
					    	if(!Reg.isNull(trim_resource_order_num) && !Reg.noZeroInt(trim_resource_order_num)){
					    		error_tip.html('&nbsp;排列顺序只能为数字');
					    		resource_order_num.focus();
					    		return false;
					    	}
					    	
					    	/**
					    	var trim_resource_path = Reg.trim(resource_path.val());
					    	if(Reg.isNull(trim_resource_path)){
					    		error_tip.html('&nbsp;请输入资源路径');
					    		resource_path.focus();
					    		return false;
					    	}**/
					    	
					    	// ajax请求参数
					    	var reqParam = top.$('#resource-form').serialize();
					    	if(parent_id){
					    		reqParam += '&parent_id=' + parent_id;
					    	}
					        $.ajax({
					        	url:'${ctx}/control/resource/add',
					        	type:'post',
					        	dataType:'json',
					        	data:reqParam,
					        	success:function(data){
					        		if(data && data.code == '-1'){
					        			top.dialog({
										    title: '消息',
										    content: '操作失败',
										    ok: function () {}
									    }).show();
					        		}else{
					        			treeNode.isParent = true;
					        			top.dialog({
										    title: '消息',
										    content: '操作成功',
										    ok: function () {}
									    }).show();
					        		}
					        		refreshTree(zTree,treeNode.id,'add');
					        	}
					        });
					    },
					    cancelValue: '取消',
					    cancel: function () {}
					});
					d.showModal();
				
					return false;
				});
			}
	
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	}

	function refreshTree(zTree,id,operate_type){
		var node = zTree.getNodeByParam("id", id, null);
		var t_parentNode = node.getParentNode();
		var refreshNode = (operate_type == 'add' ? node: t_parentNode);
		zTree.reAsyncChildNodes(refreshNode, "refresh",false);
	}
	
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			if(childNodes[i].resource_type == '3'){
				childNodes[i].icon = '${ctx}/images/function.png';
			}
			if(childNodes[i].resource_type == '2'){
				childNodes[i].icon = '${ctx}/images/menu.png';
			}
		}
		return childNodes;
	}
	
	$(document).ready(function(){
	
		// ztree 初始化
		$.fn.zTree.init($("#resource-tree"), setting, zNodes);
		
	});
	
	
	</script>
</html>