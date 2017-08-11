<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>用户列表</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		<link href="${ctx}/scripts/icheck/skins/all.css" rel="stylesheet" />
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
		<script src="${ctx}/scripts/control/js/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
		
			.error-tip{
				color:#dd4b39;
			}
			
			table.dataTable tbody tr.selected {
				background-color: #f6faff;
			}
			
			table.dataTable.cell-border tbody th,table.dataTable.cell-border tbody td {
			    border-top: 1px solid #ddd;
			    border-right: 1px solid #ddd
			}
			
			table.dataTable.cell-border tbody tr th:first-child,table.dataTable.cell-border tbody tr td:first-child {
			    border-left: 1px solid #ddd
			}
			
			table.dataTable.cell-border tbody tr:first-child th,table.dataTable.cell-border tbody tr:first-child td {
			    border-top: none
			}
		</style>
	</head>

	<body>
			<div class="fdceng">
				
				<div class="toolbar">
					<p style="margin:5px 5px;">
						<a href="${ctx}/control/user/add" class="btn btn-primary"><img src="${ctx}/images/add.png" />&nbsp;新增</a>
						<a href="javascript:;" id="modify" style="display: none;" class="btn btn-primary"><img src="${ctx}/images/edit.png" />&nbsp;修改</a>
						<a href="javascript:;" id="authorization" style="display: none;" class="btn btn-primary"><img src="${ctx}/images/auth.png" />&nbsp;授权</a>
						<a href="javascript:;" id="enable_all" style="display: none;" class="btn btn-primary"><img src="${ctx}/images/enable.png" />&nbsp;启用</a>
						<a href="javascript:;" id="disable_all" style="display: none;" class="btn btn-primary"><img src="${ctx}/images/disable.png" />&nbsp;停用</a>
					</p>
				</div>
		
				<hr />
				<table id="userTable" class="cell-border" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>
								id
							</th>
							<th>
								<input tabindex="1" type="checkbox" id="checkall">
								账户名称
							</th>
							<th>
								所属机构
							</th>
							<th>
								姓名
							</th>
							<th>
								用户性别
							</th>
							<th>
								用户年龄
							</th>
							<th>
								邮件
							</th>
							<th>
								办公电话
							</th>
							<th>
								移动电话
							</th>
							<th>
								状态
							</th>
						</tr>
					</thead>
				</table>
				
			</div>
	</body>
	
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/icheck/icheck.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/icheck/icheck.checkbox.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/datatable/jquery.dataTables.min.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.js" charset="utf-8"></script>
	
	<script type="text/javascript">
	
		$(document).ready(function(){
		
			userTable = $('#userTable').DataTable( {
				lengthChange:false,
				paging:true,
				ordering: false,
				processing: true,
				order: [[ 0, "desc" ]],
				serverSide: true,
				ajax:{
					url:'${ctx}/control/user/list',
					type:'post',
					dataType:'json',
					data:{
						'searchVal':function(){
							return $('#userTable_filter').find('input').val();
						}
					}
				},
				columnDefs: [
					{
		                "targets": [ 0 ],
		                "visible": false,
		                "searchable": false
		            },
                   {                               
                     "defaultContent": "",  
                     "targets": "_all"  
                   }  
                ], 
				columns: [
					{ data:'id'},
			        { data : 'account',
			          render: function ( data, type, full, meta ) {
			          	 return (data == 'admin' ? data : '<input type="checkbox" id="'+meta.row+'" />&nbsp;&nbsp;' + data);
					  }
			        },
			        { data : 'orgname' },
			        { data : 'name'},
			        { data : 'sex',
			          render: function ( data, type, full, meta ) {
			          	 if('10' == data){
			          	 	return '男';
			          	 }
			          	 return '女';
			          	 
					  }
					},
			        { data : 'age'},
			        { data : 'email'},
			        { data : 'office_phone'},
			        { data : 'mobil_phone'},
			        { data : 'visible',
			          render: function ( data, type, full, meta ) {
			          	 if(data){
			          	 	return '启用';
			          	 }
			          	 return '停用';
			          	 
					  }
			        }
			    ],
	            language: {
	                "url": "${ctx}/scripts/datatable/plugins/chinese.lang"
	            },
	            drawCallback: function( settings ) {
	            	// 初始化checkbox，添加样式
	            	$('input[type=checkbox]').iCheck({
						checkboxClass: 'icheckbox_flat-greenlight',
					    radioClass: 'iradio_flat-greenlight'
					});
					
					// 全选
					$('#checkall').checkAll();
					// 反选
					$('#checkall').uncheckAll();
					// 每一行checkbox选择
					$('#userTable tbody').find('input[type=checkbox]').check($('#checkall'),operateBtn);
					// 每一行checkbox取消选择
					$('#userTable tbody').find('input[type=checkbox]').uncheck($('#checkall'),operateBtn);
					
	            	window.parent.iFrameHeight('funcIframe')
			    }
	        });
	        
	        // 绑定click事件
	        $('#userTable tbody').onEventInit();
	        
	        // 停用用户
	        $('#disable_all').click(function(){
	        	var rows = userTable.rows('.selected').data();
	        	if(rows.lenth == 0){
	        		dialog({
		        		id:'art-dialog',
		        		title:'提示',
		        		content:'请选择要停用的用户',
		        		okValue: '确定',
		        		ok:function(){}
	        		}).show();
	        		return ;
	        	}
	        	
	        	top.dialog({
	        		id:'art-dialog',
	        		title:'提示',
	        		content:'<label class="error-tip">确定停用选择的用户？</label>',
	        		 okValue: '确定',
	        		 ok:function(){
	        		 	
	        		 	var ids = [];
	        		 	// 获取选中行
			        	for(var i = 0;i<rows.length;i++){
			        		ids.push(rows[i].id);
			        	}
			        	
			        	$.ajax({
			        		url:'${ctx}/control/user/disable',
			        		type:'post',
			        		data:{ids:ids.join(',')},
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
	        		 },
	        		cancelValue: '取消',
	        		cancel: function () {}
	        	}).show();
	        	
	        });
	        
	        $('#enable_all').click(function(){
	        	var rows = userTable.rows('.selected').data();
	        	if(rows.lenth == 0){
	        		dialog({
		        		id:'art-dialog',
		        		title:'提示',
		        		content:'请选择要启用的用户',
		        		okValue: '确定',
		        		ok:function(){}
	        		}).show();
	        		return ;
	        	}
	        	
	        	
	        	top.dialog({
	        		id:'art-dialog',
	        		title:'提示',
	        		content:'<label class="error-tip">确定启用选择的用户？</label>',
	        		 okValue: '确定',
	        		 ok:function(){
	        		 	
	        		 	var ids = [];
	        		 	// 获取选中行
			        	for(var i = 0;i<rows.length;i++){
			        		ids.push(rows[i].id);
			        	}
			        	
			        	$.ajax({
			        		url:'${ctx}/control/user/enable',
			        		type:'post',
			        		data:{ids:ids.join(',')},
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
	        		 },
	        		cancelValue: '取消',
	        		cancel: function () {}
	        	}).show();
	        	
	        });
	        
	        // 修改
	        $('#modify').click(function(){
	        	var rows_data = userTable.rows('.selected').data();
	        	if(rows_data.length == 0){
	        		dialog({
		        		id:'art-dialog',
		        		title:'提示',
		        		content:'请选择要编辑的用户',
		        		okValue: '确定',
		        		ok:function(){}
	        		}).show();
	        		return ;
	           }
	           window.location.href = '${ctx}/control/user/edit/'+rows_data[0].id;
	        });
	        
	        // 授权
	        $('#authorization').click(function(){
		        var rows_data = userTable.rows('.selected').data();
		        if(rows_data.length == 0){
		        		dialog({
			        		id:'art-dialog',
			        		title:'提示',
			        		content:'请选择要授权的用户',
			        		okValue: '确定',
			        		ok:function(){}
		        		}).show();
		        		return ;
		        }
	        	window.location.href = '${ctx}/control/user/auth?userid='+rows_data[0].id +'&name=' + rows_data[0].name;
	        });
	        
		});
		
		
		function operateBtn(){
		
	        var d = userTable.rows('.selected').data(),
	        len = d.length;
						
        	var modify = $('#modify'),
        	disable_all = $('#disable_all'),
        	authorization = $('#authorization'),
        	enable_all = $('#enable_all');
	        	
	        if(len == 1){
	        	modify.show();
	        	authorization.show();
	        }else{
	        	modify.hide();
	        	authorization.hide();
	        }
	        
	        if(len > 0){
		        disable_all.show();
		        enable_all.show();
	        }else{
	        	disable_all.hide();
	        	enable_all.hide();
	        }
	        
		}
        
	</script>
</html>
