<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>字典维护</title>
<link rel="stylesheet" type="text/css" href="${ctx}/scripts/zTree/css/demo.css" />
<link href="${ctx}/scripts/artDialog/v4/skins/blue.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/scripts/zTree/js/jquery-1.4.4.min.js" charset="utf-8"></script>
<script src="${ctx}/scripts/artDialog/v4/artDialog.js" charset="utf-8"></script>
<style type="text/css">
	
.table-d table { 
	border-collapse: collapse; 
	border: none;
	background:#30a5ff;
} 
.table-d table td { 
	border: solid #30a5ff 1px; 
	background:#FFF;
} 

.table-d table th { 
	border: solid #2288cc 1px;
	color:#fff;
	text-align: left;
} 

a {
	color:#1c4cdc;
	text-decoration: none;
}

a:hover{
	color:#f00;
}

.op-hide{
	display: none;
}
</style>
</head>
<body>
<div class="table-d">
	<p><a href="javascript:;" id="addDictData">新增</a>
	<a href="javascript:;" id="dict_data_edit" class="op-hide">编辑</a>
	<a href="javascript:;" id="dict_data_del"  class="op-hide">删除</a>
	</p>
	<table style="width:100%;" border="0">
		<thead>
			<th>
			<c:if test="${fn:length(dictionaryDatas) > 0 }"><input type="checkbox" id="cball" class="checkall" /></c:if>字典名称</th>
			<th>字典值</th>
		</thead>
		<c:forEach var="dict_data" items="${dictionaryDatas}" varStatus="status">
			<tr>
				<td><input type="checkbox" class="cb" dict-data-id="${dict_data.pid}" dict-data-name="${dict_data.dictdata_name}" dict-data-value="${dict_data.dictdata_value}"/> ${dict_data.dictdata_name}</td>
				<td>${dict_data.dictdata_value}</td>
				</td>
			</tr>
		</c:forEach>
	</table>
</div>

<div id="dict_data_div" style="display:none;">
<form id="dictdata_form">
	<input type="hidden" name="pid" id="dictdata_id" value="-1" />
	<input type="hidden" name="fk_t_dictionary_type_pid" id="fk_t_dictionary_type_pid"  value="${dict_type_id}" />
	<p><label for="d_dictdata_name">字典名称：</label><input type="text" name="dictdata_name" id="dictdata_name"  /></p> 
	<p><label for="d_dictdata_value">字典值：</label><input type="text"  name="dictdata_value" id="dictdata_value" /></p>
	<p class="errormsg" style="color:#f00;"></p>
</form>
</div>

<script type="text/javascript">
	$(function(){
		
		
		// 全选
		$('#cball').click(function(){
			var cball = $(this);
			$('.cb').attr('checked',(cball.attr('checked') ? true : false));
			showOrHide();
		});
		
		// 每行cb click
		$('.cb').click(function(){
			
			var flag = true;
			$('.cb').each(function(){
				if(!$(this).attr('checked')){
					flag = false;
					return false;
				}
			});
			$('#cball').attr('checked',flag);
			showOrHide();
		});
		
		// 新增
		$('#addDictData').click(function(){
			$('.errormsg').html('');
			var dictdata_name = $('#dictdata_name'),
			dictdata_value = $('#dictdata_value');
			
			dictdata_name.val('');
			dictdata_value.val('');
			
			art.dialog({
				id:'dict_data_dialog',
				title:'添加字典值',
				width:200,
			    content: document.getElementById('dict_data_div'),
			    okValue:'添加',
			    ok: function () {
			    	
	            	if(!$.trim(dictdata_name.val())){
	            		$('.errormsg').html('请输入字典值名称');
	            		dictdata_name.focus();
	            		return false;
	            	}
	            	
	            	if(!$.trim(dictdata_value.val())){
	            		$('.errormsg').html('请输入字典值');
	            		dictdata_value.focus();
	            		return false;
	            	}
	            	
	            	$('#dictdata_name').val(dictdata_name.val());
	            	$('#dictdata_value').val(dictdata_value.val());
	            	
			    	$.ajax({
			    		url:'${ctx}/control/dict/addDictData',
			    		type:'post',
			    		data:$('#dictdata_form').serialize(),
			    		dataType:'json',
			    		success:function(data){
			    			if(data && data == '1'){
			    				art.dialog({
	                				icon: 'face-smile',
	                			    content: '添加成功！',
	                			    ok: function () {
					    				window.location.href = window.location.href;
	                			    }
	                			});
			    			}else{
			    				art.dialog({
	                				icon: 'face-sad',
	                			    content: '添加失败！',
	                			    ok: function () {
					    				window.location.href = window.location.href;
	                			    }
	                			});
			    			}
			    		}
			    	});
			    }
			});
		});
		
		// 编辑
		$('#dict_data_edit').click(function(){
			
			var $curobj = $('.cb:checked');
			var dict_data_id = $curobj.attr('dict-data-id');
			var dict_data_name = $curobj.attr('dict-data-name');
			var dict_data_value = $curobj.attr('dict-data-value');
	    	
	    	// form中的元素
			var dictdata_id = $('#dictdata_id');
			var dictdata_name = $('#dictdata_name');
	    	var dictdata_value = $('#dictdata_value');
	    	
	    	dictdata_id.val(dict_data_id);
	    	dictdata_name.val(dict_data_name);
	    	dictdata_value.val(dict_data_value);
	    	
			art.dialog({
				id:'dict_data_dialog',
				title:'修改字典值',
				width:200,
			    content: document.getElementById('dict_data_div'),
			    okValue:'添加',
			    ok: function () {
			    	if(!$.trim(dictdata_name.val())){
		        		$('.errormsg').html('请输入字典值名称');
		        		dictdata_name.focus();
		        		return false;
		        	}
		        	
		        	if(!$.trim(dictdata_value.val())){
		        		$('.errormsg').html('请输入字典值');
		        		dictdata_value.focus();
		        		return false;
		        	}
		        	
		        	$.ajax({
			    		url:'${ctx}/control/dict/editDictData',
			    		type:'post',
			    		data:$('#dictdata_form').serialize(),
			    		dataType:'json',
			    		success:function(data){
			    			if(data && data == '1'){
			    				art.dialog({
	                				icon: 'face-smile',
	                			    content: '编辑成功！',
	                			    ok: function () {
					    				window.location.href = window.location.href;
	                			    }
	                			});
			    			}else{
			    				art.dialog({
	                				icon: 'face-sad',
	                			    content: '编辑失败！',
	                			    ok: function () {
					    				window.location.href = window.location.href;
	                			    }
	                			});
			    			}
			    		}
			    	});
		        	
			    }
			});
		});
		
		// remove 
		$('#dict_data_del').click(function(){
		
			var dict_data_id = '';
			$('.cb:checked').each(function(index,domEle){
				dict_data_id += $(domEle).attr('dict-data-id') + ',';
			});
			dict_data_id = dict_data_id.substring(0,dict_data_id.length-1);
			
			art.dialog({
				    id: 'dict_type_dialog',
				    title:'删除字典值',
				    width:200,
				    content: '<span style="color:#F00;">确认删除选中字典值？</span>',
				    button: [
				        {
				            name: '确定',
				            callback: function () {
				            	$.ajax({
						    		url:'${ctx}/control/dict/delDictData',
						    		type:'post',
						    		data:'dict_data_id=' + dict_data_id,
						    		dataType:'json',
						    		success:function(data){
						    			if(data && data == '1'){
						    				art.dialog({
					               				icon: 'face-smile',
					               			    content: '删除成功！',
					               			    ok: function () {
								    				window.location.href = window.location.href;
					               			    }
					               			});
						    			}else{
						    				art.dialog({
					               				icon: 'face-sad',
					               			    content: '删除失败！',
					               			    ok: function () {
								    				window.location.href = window.location.href;
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
		
	});
	
	function showOrHide(){
		var dict_data_edit = $('#dict_data_edit'),
		dict_data_del = $('#dict_data_del'),
		cb_checked = $('.cb:checked');
		
		cb_checked.length == 1 ? dict_data_edit.show() : dict_data_edit.hide();
		cb_checked.length > 0 ? dict_data_del.show() : dict_data_del.hide();
	}
</script>
</body>
</html>