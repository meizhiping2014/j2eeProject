<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>供应商列表</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		<link href="${ctx}/scripts/icheck/skins/all.css" rel="stylesheet" />
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		
		<style type="text/css">
			.error-tip{color:#dd4b39;}
			table.dataTable tbody tr.selected {background-color: #f6faff;}
			table.dataTable.cell-border tbody th,table.dataTable.cell-border tbody td {border-top: 1px solid #ddd;border-right: 1px solid #ddd;}
			table.dataTable.cell-border tbody tr th:first-child,table.dataTable.cell-border tbody tr td:first-child {border-left: 1px solid #ddd;}
			table.dataTable.cell-border tbody tr:first-child th,table.dataTable.cell-border tbody tr:first-child td {border-top: none;}
	</style>
</head>

<body>
	<div class="fdceng">
	<div class="toolbar">
		<p style="margin:5px 5px;">
			<a href="${ctx}/profitRule/edit" class="btn btn-primary"><img src="${ctx}/images/add.png" />&nbsp;新增</a>
			<a href="javascript:;" id="modify" style="display: none;" class="btn btn-primary"><img src="${ctx}/images/edit.png" />&nbsp;修改</a>
			<a href="javascript:;" id="appr" style="display: none;" class="btn btn-primary"><img src="${ctx}/images/edit.png" />&nbsp;审核</a>
		</p>
	</div>
	<hr />
	<div class="tab-pane active" id="1a">
		<div class="toolbar">
			<p style="margin:5px 5px;">产品名称：<input type="text" style="width:auto;display: inline;" id="productName" name="productName" value="">&nbsp;&nbsp;供应商：
			<select id="fkTCompanyInfoId" name="fkTCompanyInfoId" style="width:190px;">
				<option value="">不限</option>
				<c:forEach items="${companyList}" var="company" varStatus="statu">
					<option value="${company.pid}" <c:if test="${company.pid == cpi.fkTCompanyInfoId}">selected</c:if>>${company.companyFullName}</option>
				</c:forEach>
			</select>
			&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="query"><img src="${ctx}/images/query.png" />&nbsp;查询</button></p>
		</div>
		<hr />
		<table id="companyTable" class="cell-border" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th>主键</th>
					<th><input tabindex="1" type="checkbox" id="checkall">供应商</th>
					<th>产品名称</th>
					<th>价格类型</th>
					<th>消费权益类型</th>
					<th>收益展示</th>
					<th>客户收益给予</th>
					<th>首充日</th>
					<th>到账类型</th>
					<th>审核状态</th>
					<th>有效性</th>
				</tr>
			</thead>
		</table>
	</div>
	</div>
</body>
	
<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
<script src="${ctx}/scripts/icheck/icheck.js" charset="utf-8"></script>
<script src="${ctx}//scripts/icheck/icheck.checkbox.js" charset="utf-8"></script>
<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
<script src="${ctx}/scripts/datatable/jquery.dataTables.min.js" charset="utf-8"></script>
<script src="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.js" charset="utf-8"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			companyTable = $('#companyTable').DataTable({
				lengthChange:false,
			 	searching: false,
				paging:true,
				processing: true,
				order: [[ 0, "desc" ]],
				ordering: false,
				serverSide: true,
				ajax:{
					url:'${ctx}/profitRule/list',
					type:'post',
					dataType:'json',
					data:{
						'productName':function(){
							return $('#productName').val();
						},
						'fkTCompanyInfoId':function(){
							return $('#fkTCompanyInfoId').val();
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
					{ data : 'pid' },
					{ data : 'companyFullName',
						render: function ( data, type, full, meta ) {
							return '<input type="checkbox" id="'+meta.row+'" />&nbsp;&nbsp;' + data;
						}
					},			        			       
			        { data : 'productName' },
			        { data : 'priceType',
			        	render: function (data, type, full, meta ) {
				        	if(data == '22001'){
				        		return "随意充";
				        	}else if(data == '22002'){
				        		return "固定面额";
				        	}else{
				        		return data;
				        	}
				        	
					  	}
					 },
					 { data : 'consumptionType',
			        	render: function (data, type, full, meta ) {
				        	if(data == '23001'){
				        		return "实物分配";
				        	}else{
				        		return data;
				        	}
					  	}
			        },
			        { data : 'profitType',
			        	render: function (data, type, full, meta ) {
				        	if(data == '24001'){
				        		return "折扣形式";
				        	}else{
				        		return data;
				        	}
					  	}
			        },
			        { data : 'profitReturnType',
			        	render: function (data, type, full, meta ) {
				        	if(data == '25001'){
				        		return "前置";
				        	}else if(data == '25002'){
				        		return "后置";
				        	}else{
				        		return data;
				        	}
					  	}
			        },			        
			        { data : 'firstRechargeDay' },
			        { data : 'arrivalType',
			        	render: function (data, type, full, meta ) {
				        	if(data == '30001'){
				        		return "分期";
				        	}else{
				        		return data;
				        	}
					  	}
			        },
			        { data : 'apprStatus',
			        	render: function (data, type, full, meta ) {
				        	if(data == '32001'){
				        		return "待审核";
				        	}else if(data == '32002'){
				        		return "审核通过";
				        	}else if(data == '32003'){
				        		return "审核不通过";
				        	}else{
				        		return data;
				        	}	        	
					  	}
			        },
			        { data : 'recordStatus',
			        	render: function (data, type, full, meta ) {
				        	if(data == '1'){
				        		return "正常";
				        	}else if(data == '0'){
				        		return "禁用";
				        	}else{
				        		return data;
				        	}	        	
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
					    radioClass: 'iradio_square-blue'
					});
					
					// 全选
					$('#checkall').checkAll();
					// 反选
					$('#checkall').uncheckAll();
					// 每一行checkbox选择
					$('#companyTable tbody').find('input[type=checkbox]').check($('#checkall'),operateBtn);
					// 每一行checkbox取消选择
					$('#companyTable tbody').find('input[type=checkbox]').uncheck($('#checkall'),operateBtn);
					
	            	window.parent.iFrameHeight('funcIframe')
			    }
	        });
	        
	        $('#companyTable tbody').onEventInit();
	        
	        $('#query').click(function(){
	        	companyTable.ajax.reload();
	        });
	        
	        // 修改
	        $('#modify').click(function(){
	        	var rows_data = companyTable.rows('.selected').data();
	        	if(rows_data.length == 0){
	        		dialog({
		        		id:'art-dialog',
		        		title:'提示',
		        		content:'请选择需要编辑的产品',
		        		okValue: '确定',
		        		ok:function(){}
	        		}).show();
	        		return ;
	           }
	           window.location.href = '${ctx}/profitRule/edit/'+rows_data[0].pid;
	        });
	        
	        //审核
			$('#appr').click(function(){
				var rows_data = companyTable.rows('.selected').data();
	        	if(rows_data.length == 0){
	        		dialog({
		        		id:'art-dialog',
		        		title:'提示',
		        		content:'请选择需要审核的产品',
		        		okValue: '确定',
		        		ok:function(){}
	        		}).show();
	        		return ;
	           }
	           window.location.href = '${ctx}/profitRule/toAppr/'+rows_data[0].pid;
			});
		});
		
		
		
		function operateBtn(){
	        var d = companyTable.rows('.selected').data(),
	        len = d.length;
						
        	var modify = $('#modify'),
        	appr = $('#appr');
	        	
	        if(len == 1){
	        	var apprStatus = d[0].apprStatus;
	        	if(apprStatus=='32001'){//待审核
	        		appr.show();
	        	}else{//审核通过或者审核不通过
	        		modify.show();	 
	        	}
	        }else{
	        	modify.hide();
	        	appr.hide();
	        }
		}
	</script>
</html>
