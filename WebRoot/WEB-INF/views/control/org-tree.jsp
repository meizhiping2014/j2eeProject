<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>机构列表</title>
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
		    <h3 class="panel-title">机构树形结构</h3>
		  </div>
		  <div class="panel-body">
		    <div class="row">
			  <div class="col-xs-12 col-sm-2 col-md-3">
			  	<div class="panel panel-default">
				  <div class="panel-body">
				    <ul id="org-tree" class="ztree"></ul>
				  </div>
				</div>	
			  </div>
			  <div class="col-xs-6 col-md-9">
			  	<div class="panel panel-default">
				  <div class="panel-body">
				  	<iframe id="org-frame" width="100%" height="680" frameborder="0" scrolling="auto" src=""></iframe>
				  </div>
				</div>
			  </div>
			</div>
		  </div>
		</div>
		
		<!-- <p><span class="error-tip">*&nbsp;</span>机构码：<input type="text" id="org-code" name="code"/></p> -->
		<script type="text/template" id="org-add-template">
			<form id="org-form">
			<p>&nbsp;&nbsp;父结构：<span id="p-org">{parent_name}</span></p>
			<p><span class="error-tip">*&nbsp;</span>机构名称：<input type="text" id="org-name" name="name" /></p>
			<p>&nbsp;&nbsp;机构地址：<input type="text" id="org-address" name="address" /></p>
			</form>
		</script>
		
		<script type="text/template" id="org-edit-template">
			<form id="org-edit-form">
			<p>&nbsp;&nbsp;&nbsp;父结构：<span id="p-org">{parent_name}</span><input type="hidden" id="org-id" name="id" value="{id}" /></p>
			<p>&nbsp;&nbsp;&nbsp;机构码：<input type="text" id="org-code" name="code" disabled="disabled" value="{code}"/></p>
			<p>机构名称：<input type="text" id="org-name" name="name" value="{name}"/></p>
			<p>机构地址：<input type="text" id="org-address" name="address" value="{address}"/></p>
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
					removeTitle:'删除机构',
					showRenameBtn: showRenameBtn,
					renameTitle:'修改机构'
				},
				async: {
					enable: true,
					url:'${ctx}/control/org/query',
					autoParam:["id", "name=n", "level=lv"],
					otherParam:{"otherParam":"zTreeAsyncTest"},
					dataFilter: filter
				}
			};
			
			var zNodes =[{ id:-1, pId:-1, name : "机构树",isParent: false,icon:"${ctx}/images/application.png"}];

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
				$('#org-frame').attr('src','${ctx}/control/org/query/'+ treeNode.id)
			}
			
			function beforeRemove(treeId, treeNode){
				
				var zTree = $.fn.zTree.getZTreeObj('org-tree');
				
				var d = top.dialog({
					id:'org-add-dialog',
					    title: '操作',
					    content:'<p class="error-tip">此操作会删除当前机构下的所有机构及用户（请谨慎操作），确定执行操作？</p>',
					    okValue: '确定',
					    ok: function () {
					    	$.ajax({
					        	url:'${ctx}/control/org/delete/'+treeNode.id,
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
			
				var org_add_template = $('#org-edit-template').html();
				var t_parentNode = treeNode.getParentNode();
				
				org_add_template = org_add_template.replace('{parent_name}',((t_parentNode != '-1') ? t_parentNode.name : ''))
					.replace('{id}',(treeNode.id || ''))
					.replace('{code}',(treeNode.code || ''))
					.replace('{name}',(treeNode.name || ''))
					.replace('{address}',(treeNode.address || ''));
				
				var zTree = $.fn.zTree.getZTreeObj('org-tree');
					
					var d = top.dialog({
						id:'org-add-dialog',
					    title: '修改机构',
					    content: org_add_template,
					    okValue: '确定',
					    statusbar: '<label class="error-tip msg"></label>',
					    ok: function () {
					    	
					    	var error_tip = top.$('.msg');
					    	error_tip.html('');
					    	//var org_code = top.$('#org-code');
					    	var org_name = top.$('#org-name');
					    	var org_address = top.$('#org-address');
					    	
					    	/**var trim_org_code = Reg.trim(org_code.val());
					    	if(Reg.isNull(trim_org_code)){
					    		error_tip.html('&nbsp;请输入机构编码');
					    		org_code.focus();
					    		return false;
					    	}**/
					    	
					    	var trim_org_name = Reg.trim(org_name.val());
					    	if(Reg.isNull(trim_org_name)){
					    		error_tip.html('&nbsp;请输入机构名称');
					    		org_name.focus();
					    		return false;;
					    	}
					    	
					    	/** var trim_org_address = Reg.trim(org_address.val());
					    	if(Reg.isNull(trim_org_address)){
					    		error_tip.html('&nbsp;请输入机构地址');
					    		org_address.focus();
					    		return false;;
					    	}**/
					    	
					        $.ajax({
					        	url:'${ctx}/control/org/edit/'+treeNode.id,
					        	type:'post',
					        	dataType:'json',
					        	data:top.$('#org-edit-form').serialize(),
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
				return treeNode.id != -1;
			}
	
			function showRenameBtn(treeId, treeNode) {
				return treeNode.id != -1;
			}

			// 添加机构
			function addHoverDom(treeId, treeNode) {
			
				var sObj = $("#" + treeNode.tId + "_span");
				if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length > 0) return;
				
				var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
					+ "' title='添加机构' onfocus='this.blur();'></span>";
				sObj.append(addStr);
				
				var btn = $("#addBtn_" + treeNode.tId);
				if (btn) btn.bind("click", function(){
					
					var org_add_template = $('#org-add-template').html(),
						parent_id;
					// 设置父机构
					if(treeNode.id != '-1'){
						org_add_template = org_add_template.replace('{parent_name}',treeNode.name);
						parent_id = treeNode.id;
					}else{
						org_add_template = org_add_template.replace('{parent_name}','无');
					}
					
					var zTree = $.fn.zTree.getZTreeObj('org-tree');
					
					var d = top.dialog({
						id:'org-add-dialog',
					    title: '添加机构',
					    content: org_add_template,
					    okValue: '确定',
					    statusbar: '<label class="error-tip msg"></label>',
					    ok: function () {
					    	
					    	var error_tip = top.$('.msg');
					    	error_tip.html('');
					    	//var org_code = top.$('#org-code');
					    	var org_name = top.$('#org-name');
					    	var org_address = top.$('#org-address');
					    	
					    	/**var trim_org_code = Reg.trim(org_code.val());
					    	if(Reg.isNull(trim_org_code)){
					    		error_tip.html('&nbsp;请输入机构编码');
					    		org_code.focus();
					    		return false;
					    	}**/
					    	
					    	var trim_org_name = Reg.trim(org_name.val());
					    	if(Reg.isNull(trim_org_name)){
					    		error_tip.html('&nbsp;请输入机构名称');
					    		org_name.focus();
					    		return false;;
					    	}
					    	
					    	/**var trim_org_address = Reg.trim(org_address.val());
					    	if(Reg.isNull(trim_org_address)){
					    		error_tip.html('&nbsp;请输入机构地址');
					    		org_address.focus();
					    		return false;;
					    	}**/
					    	
					    	// ajax请求参数
					    	var reqParam = top.$('#org-form').serialize();
					    	if(parent_id){
					    		reqParam += '&parent_id=' + parent_id;
					    	}
			    	
					        $.ajax({
					        	url:'${ctx}/control/org/add',
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
		$("#editBtn_"+treeNode.tId).unbind().remove();
		$("#delBtn_"+treeNode.tId).unbind().remove();
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
			if(!childNodes[i].isParent){
				childNodes[i].icon = '${ctx}/images/chart_organization.png';
			}
		}
		return childNodes;
	}
	
	$(document).ready(function(){
		// ztree 初始化
		$.fn.zTree.init($("#org-tree"), setting, zNodes);
	});
		</script>
	</body>
</html>