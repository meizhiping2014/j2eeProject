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
			/** #a9d9ff; **/
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
						<a href="${ctx}/control/role/add" class="btn btn-primary"><img src="${ctx}/images/add.png" />&nbsp;新增</a>
						<a href="javascript:;" id="edit" style="display: none;" class="btn btn-primary"><img src="${ctx}/images/edit.png" />&nbsp;修改</a>
						<a href="javascript:;" id="disable_all" style="display: none;" class="btn btn-primary"><img src="${ctx}/images/delete.png" />&nbsp;删除</a>
					</p>
				</div>
		
				<hr />
				<table id="roleTable" class="cell-border" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>
								id
							</th>
							<th>
								<input tabindex="1" type="checkbox" id="checkall">
								角色名称
							</th>
							<th>
								角色描述
							</th>
							<th>
								创建时间
							</th>
							<th>
								创建者
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
			
			roleTable = $('#roleTable').DataTable( {
				lengthChange:false,
				ordering: false,
				paging:true,
				processing: true,
				order: [[ 0, "desc" ]],
				serverSide: true,
				ajax:{
					url:'${ctx}/control/role/list',
					type:'post',
					dataType:'json',
					data:{
						'searchVal':function(){
							return $('#roleTable_filter').find('input').val();
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
					{ data : 'id'},
			        { data : 'name' ,
			          render:function(data,type,full,meta){
			          	if(data == '超级系统管理员'){
			          		return data;
			          	}
			          	return '<input type="checkbox" id="'+meta.row+'" />&nbsp;&nbsp;' + data;
			          }
			        },
			        { data : 'description' },
			        { data : 'created_date'},
			        { data : 'creator'}
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
					$('#roleTable tbody').find('input[type=checkbox]').check($('#checkall'),operateBtn);
					// 每一行checkbox取消选择
					$('#roleTable tbody').find('input[type=checkbox]').uncheck($('#checkall'),operateBtn);
					
	            	window.parent.iFrameHeight('funcIframe');
			    }
	        });
	        
	        // 绑定click事件
	        $('#roleTable tbody').onEventInit();
	        
	        
	        // 删除角色
	        $('#disable_all').click(function(){
	        	var selLen = roleTable.rows('.selected').data().length;
	        	if(selLen == 0){
	        		dialog({
		        		id:'art-dialog',
		        		title:'提示',
		        		content:'请选择要删除的角色',
		        		okValue: '确定',
		        		ok:function(){}
	        		}).show();
	        		return ;
	        	}
	        	
	        	top.dialog({
	        		id:'art-dialog',
	        		title:'提示',
	        		content:'<label class="error-tip">确定删除？（不可恢复）</label>',
	        		 okValue: '确定',
	        		 ok:function(){
	        		 	// 获取选中行
			        	var rows = roleTable.rows('.selected').data();
			        	console.log(rows[0].id);
			        	
			        	var ids = [];
			        	for(var i = 0;i<rows.length;i++){
			        		ids.push(rows[i].id);
			        	}
			        	
			        	$.ajax({
			        		url:'${ctx}/control/role/delete',
			        		type:'post',
			        		data:{roleids:ids.join(',')},
			        		dataType:'json',
			        		success:function(data){
			        			if(data && data.code == '0'){
			        				dialog({
						        		id:'art-dialog',
						        		title:'提示',
						        		content:'操作成功',
						        		okValue: '确定',
						        		ok:function(){
						        			window.location.href = window.location.href;
						        		}
					        		}).show();
			        			}else{
			        				dialog({
						        		id:'art-dialog',
						        		title:'提示',
						        		content:'操作失败',
						        		okValue: '确定',
						        		ok:function(){
						        			window.location.href = window.location.href;
						        		}
					        		}).show();
			        			}
			        		}
			        	})
	        		 },
	        		cancelValue: '取消',
	        		cancel: function () {}
	        	}).show();
	        });
	        
	        // 编辑
	        $('#edit').click(function(){
	        	var rows = roleTable.rows('.selected').data();
			    if(rows.length != 1){
			    	dialog({
		        		id:'art-dialog',
		        		title:'提示',
		        		content:'请选择要编辑的角色',
		        		okValue: '确定',
		        		ok:function(){}
	        		}).show();
	        		return ;
			    }
			    
			    window.location.href = '${ctx}/control/role/edit/'+rows[0].id;
			    
	        });
	        
		});
		
		function operateBtn(){
		
			var d_row = roleTable.rows('.selected').data();
		        
	        if(d_row.length > 0){
		        $('#disable_all').show();
	        }else{
	        	$('#disable_all').hide();
	        }
	        
	        
	        if(d_row.length == 1){
	        	$('#edit').show();
	        }else{
	        	$('#edit').hide();
	        }
		}
		
        
	</script>
</html>
