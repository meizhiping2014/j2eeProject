<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>字典维护</title>
<link rel="stylesheet" type="text/css" href="${ctx}/scripts/zTree/css/demo.css" />
<link href="${ctx}/scripts/artDialog/v4/skins/blue.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="${ctx}/scripts/zTree/css/zTreeStyle/zTreeStyle.css" />
<script src="${ctx}/scripts/zTree/js/jquery-1.4.4.min.js" charset="utf-8"></script>
<script src="${ctx}/scripts/zTree/js/jquery.ztree.all.min.js" charset="utf-8"></script>
<script src="${ctx}/scripts/zTree/js/jquery.ztree.exhide.min.js" charset="utf-8"></script>
<script src="${ctx}/scripts/artDialog/v4/artDialog.js" charset="utf-8"></script>
<style type="text/css">
body{
	margin: 5px 5px!important;
}
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
</style>

</head>
<body>

	<table style="width:860px;">
		<tr>
			<td valign="top">
				<p>查找：<input type="text" onchange="searchNode(this.value);" onkeydown="searchNode(this.value);" onkeyup="searchNode(this.value);"/></p>
				<ul id="dictTree" class="ztree"></ul>
			</td>
			<td valign="top">
				<iframe id="dictDataFrame" width="100%" height="500" style="border: 0px;" src=""></iframe>
			</td>
		</tr>
	</table>
	
<div id="dict_type_div" style="display:none;">
<form id="dicttype_form">
<p><label>字典业务类型名称：</label><input type="text" name="dict_name" id="dict_name" /></p> 
<p><label>字典业务类型值：</label><input type="text" name="dict_value" id="dict_value"/></p>
<p class="errormsg" style="color:#f00;"></p>
</form>
</div>
<script type="text/javascript">
	
	// ztree setting 初始化
	var setting = {
		view: {
			addHoverDom: addHoverDom,
			removeHoverDom: removeHoverDom,
			selectedMulti: false,
			fontCss: getFontCss
		},
		edit: {
			enable: true,
			showRenameBtn: showRenameBtn,
			showRemoveBtn: showRemoveBtn
		},
		callback: {
			onClick: zTreeOnClick
		},
		async: {
			enable: true,
			url:'${ctx}/control/dict/query',
			autoParam:["id", "name=n", "level=lv"],
			otherParam:{"otherParam":"zTreeAsyncTest"},
			dataFilter: filter
		}
	};

	var zNodes =[{ id:-1, pId:-1, name : "字典业务类型树",isParent: false}];
	
	// 判断是否存在节点
	var count = '${count}';
	if(count > 0){
		zNodes[0].isParent = true;
	}
	
	function getFontCss(treeId, treeNode) {
		return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
	}

	// 节点点击
	function zTreeOnClick(event, treeId, treeNode) {
		if(treeNode.id == -1){
			return false;
		}
		$('#dictDataFrame').attr('src','${ctx}/control/dict/query/'+ treeNode.pid)
	}
	
	function showRemoveBtn(treeId, treeNode) {
		
		if(!treeNode.isParent && treeNode.id != -1){
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#delBtn_"+treeNode.tId).length > 0) return;
			
			var delStr = "<span class='button remove' id='delBtn_" + treeNode.tId
				+ "' title='删除字典业务类型' onfocus='this.blur();'></span>";
			sObj.append(delStr);
			
			var btn = $("#delBtn_" + treeNode.tId);
			if (btn) btn.bind("click", function(){
				var zTree = $.fn.zTree.getZTreeObj("dictTree");
			
				art.dialog({
				    id: 'dict_type_dialog',
				    title:'删除业务字典类型',
				    width:200,
				    lock:true,
				    content: '<span style="color:#F00;">确认删除该字典？</span>',
				    button: [
				        {
				            name: '确定',
				            callback: function () {
				            	
				                $.ajax({
				                	url:'${ctx}/control/dict/del',
				                	type:'post',
				                	data:'dict_type_id='+treeNode.pid,
				                	dataType:'json',
				                	success:function(data){
				                		if(data && data == '1'){
				                			art.dialog({
				                				icon: 'face-smile',
				                			    content: '删除成功！',
				                			    ok: function () {
				                			    	refreshTree(zTree);
				                			    	$('#dictDataFrame').attr('src','');
				                			    }
				                			});
				                		}else{
				                			art.dialog({
				                				icon: 'face-sad',
				                			    content: '删除失败，请稍候再试！',
				                			    ok: function () {
				                			    	refreshTree(zTree);
				                			    }
				                			});
				                		}
				                	}
				                });
				            }
				        },
				        {
				            name: '取消',
				            callback: function () {
				                
				            }
				        }
				    ]
				});
			});
		}
		return false;
	}
	
	// 修改字典类型
	function showRenameBtn(treeId, treeNode) {
		if(!treeNode.isParent && treeNode.id != -1){
			var dict_name = $('#dict_name');
			var dict_value = $('#dict_value');
			
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#editBtn_"+treeNode.tId).length > 0) return;
			
			var editStr = "<span class='button edit' id='editBtn_" + treeNode.tId
				+ "' title='修改字典业务类型' onfocus='this.blur();'></span>";
			sObj.append(editStr);
			
			
			var btn = $("#editBtn_" + treeNode.tId);
			if (btn) btn.bind("click", function(){
				var zTree = $.fn.zTree.getZTreeObj("dictTree");
				
				dict_name.val(treeNode.dict_name);
				dict_value.val(treeNode.dict_value);
				
				art.dialog({
				    id: 'dict_type_dialog',
				    title:'修改业务字典类型',
				    width:200,
				    lock:true,
				    content: document.getElementById('dict_type_div'),
				    button: [
				        {
				            name: '修改',
				            callback: function () {
				            	$('.errormsg').html('');
				            	if(!$.trim(dict_name.val())){
				            		$('.errormsg').html('请输入字典业务类型名称');
				            		dict_name.focus();
				            		return false;
				            	}
				            	
				            	if(!$.trim(dict_value.val())){
				            		$('.errormsg').html('请输入字典业务类型值');
				            		dict_value.focus();
				            		return false;
				            	}
				                $.ajax({
				                	url:'${ctx}/control/dict/edit',
				                	type:'post',
				                	data:$('#dicttype_form').serialize()+'&db_dictName='+treeNode.dict_name+'&db_dictValue='+treeNode.dict_value,
				                	dataType:'json',
				                	success:function(data){
				                		if(data && data == '1'){
				                			art.dialog({
				                				icon: 'face-smile',
				                			    content: '修改成功！',
				                			    ok: function () {
				                			    	refreshTree(zTree);
				                			    }
				                			});
				                		}else{
				                			art.dialog({
				                				icon: 'face-sad',
				                			    content: '修改失败，请稍候再试！',
				                			    ok: function () {
				                			    	refreshTree(zTree);
				                			    }
				                			});
				                		}
				                	}
				                });
				            }
				        },
				        {
				            name: '取消',
				            callback: function () {
				                
				            }
				        }
				    ]
				});
				
			});
		}
		
		return false;
	}

	// 添加字典类型
	function addHoverDom(treeId, treeNode) {
		
		if(!treeNode.isParent && treeNode.id != -1) return false;
		
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length > 0) return;
		
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='添加字典类型' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		
		var btn = $("#addBtn_" + treeNode.tId);
		if (btn) btn.bind("click", function(){
			
			$('#dict_name').val('');
			$('#dict_value').val('');
			
			var zTree = $.fn.zTree.getZTreeObj("dictTree");
			art.dialog({
			    id: 'dict_type_dialog',
			    title:'添加字典类型',
			    width:200,
			    lock:true,
			    content: document.getElementById('dict_type_div'),
			    button: [
			        {
			            name: '添加',
			            callback: function () {
			            	$('.errormsg').html('');
			            	var dict_name = $('#dict_name');
			            	var dict_value = $('#dict_value');
			            	if(!$.trim(dict_name.val())){
			            		$('.errormsg').html('请输入字典类型名称');
			            		dict_name.focus();
			            		return false;
			            	}
			            	
			            	if(!$.trim(dict_value.val())){
			            		$('.errormsg').html('请输入字典类型值');
			            		dict_value.focus();
			            		return false;
			            	}
			            	
			                $.ajax({
			                	url:'${ctx}/control/dict/add',
			                	type:'post',
			                	data:$('#dicttype_form').serialize(),
			                	dataType:'json',
			                	success:function(data){
			                		if(data && data == '1'){
			                			art.dialog({
			                				icon: 'face-smile',
			                			    content: '添加成功！',
			                			    ok: function () {
			                			    	var node = zTree.getNodeByParam("id", -1, null);
			                			    	node.isParent = true;
			                			    	refreshTree(zTree);
			                			    }
			                			});
			                		}else{
			                			art.dialog({
			                				icon: 'face-sad',
			                			    content: '添加失败，请稍候再试！',
			                			    ok: function () {
			                			    	refreshTree(zTree);
			                			    }
			                			});
			                		}
			                	}
			                });
			            }
			        },
			        {
			            name: '取消',
			            callback: function () {
			                
			            }
			        }
			    ]
			});
			return false;
		});
	};
	
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
		$("#editBtn_"+treeNode.tId).unbind().remove();
		$("#delBtn_"+treeNode.tId).unbind().remove();
	};

	function refreshTree(zTree){
		var node = zTree.getNodeByParam("id", -1, null);
		zTree.reAsyncChildNodes(node, "refresh",false);
	}
	
	// 
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].dict_name.replace(/\.n/g, '.') + '(' + childNodes[i].dict_value + ')';
			childNodes[i].searchName = childNodes[i].dict_name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	
	function searchNode(val){
		var zTree = $.fn.zTree.getZTreeObj("dictTree");
		
		var nodeList = val ? zTree.getNodesByParamFuzzy('searchName', val) : zTree.getNodes()[0].children;
		var highligh_flag = val ? true : false;
		
		if(val){
			var nodes = zTree.getNodes();
			zTree.hideNodes(nodes[0].children);
		}else{
			zTree.showNodes(nodeList);
		}
		
		updateNodes(highligh_flag,nodeList);
	}
	
	function updateNodes(highlight,nodeList) {
		var zTree = $.fn.zTree.getZTreeObj("dictTree");
		if(nodeList)
			for( var i=0, l=nodeList.length; i<l; i++) {
				zTree.showNode(nodeList[i]);
				nodeList[i].highlight = highlight;
				zTree.updateNode(nodeList[i]);
			}
	}
	
	
	$(document).ready(function(){
		// ztree 初始化
		$.fn.zTree.init($("#dictTree"), setting, zNodes);
	});
</script>
</body>
</html>