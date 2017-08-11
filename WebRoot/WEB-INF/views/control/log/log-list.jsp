<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>操作日志列表</title>
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/bootstrap/bootstrap.min.css" />
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/My97DatePicker/skin/WdatePicker.css" />
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		
		<style type="text/css">
		
		#exTab1 .tab-content {
			background-color: #f9fbfd;
			padding : 5px 15px;
		}
		
		#exTab1 .nav-tabs > li > a {
			/**border-radius: 0;
			font-size: 1.75rem;**/
		}
		 
		.error_tip{
			color:#F00;
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
<div class="toolbar">
			<p style="margin:5px 5px;">开始日期：<input type="text" style="width:auto;display: inline;" id="startDate" name="startDate" value="${nowDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'endDate\',{M:-1});}',maxDate:'#F{$dp.$D(\'endDate\');}'})" />
			结束日期：<input type="text" style="width:auto;display: inline;" id="endDate" name="endDate" value="${nowDate}" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\');}', maxDate:'#F{$dp.$D(\'startDate\',{M:1});}'})" />&nbsp;&nbsp;<button type="button" class="btn btn-primary" id="query"><img src="${ctx}/images/query.png" />&nbsp;查询</button></p>
		</div>
		<hr />
		<table id="logTable" class="cell-border" cellspacing="0" width="100%">
			<thead>
				<tr>
					<th>pid</th>
					<th>日志类型</th>
					<th nowrap="nowrap">日志操作类型</th>
					<th>日志操作内容</th>
					<th nowrap="nowrap">操作人</th>
					<th nowrap="nowrap">操作时间</th>
					<th nowrap="nowrap">IP</th>
				</tr>
			</thead>
		</table>

</body>

<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
<script src="${ctx}/scripts/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
<script src="${ctx}/scripts/datatable/jquery.dataTables.min.js" charset="utf-8"></script>
<script src="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.js" charset="utf-8"></script>

<script type="text/javascript">
	$(function(){
	
		 var logTable = $('#logTable').DataTable( {
		 	lengthChange:false,
		 	searching: false,
			paging:true,
			ordering: false,
			processing: true,
			order: [[ 0, "desc" ]],
			serverSide: true,
			ajax:{
				url:'${ctx}/control/log/query',
				type:'post',
				dataType:'json',
				data:{
					'startDate':function(){
						return $('#startDate').val();
					},
					'endDate':function(){
						return $('#endDate').val();
					},
					'searchVal':function(){
						return '';
					}
				}
			},
			columnDefs: [
				{
	                "targets": [ 0,1 ],
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
		        { data : 'log_type' },
		        { data : 'log_type_val'},
		        { data : 'pid',
		          render: function ( data, type, full, meta ) {
			          	if(full.log_content){
				          	return '<a href="javascript:;"  data-toggle="popover" onclick="popoverShow(\''+data+'\',\''+full.log_type_val+'\')"  data-placement="top">查看</a>';
			          	}
			          	return '无';
				  }
				},
		        { data : 'log_creator'},
		        { data : 'log_date'},
		        { data : 'log_ip'}
		    ],
            language: {
                "url": "${ctx}/scripts/datatable/plugins/chinese.lang"
            },
            drawCallback: function( settings ) {
            	window.parent.iFrameHeight('funcIframe')
		    }
            
        });
        
        
        $('#query').click(function(){
        
        	logTable.ajax.reload();
        });
        
	});
	
	function popoverShow(pid,type_val){
		$.get('${ctx}/control/log/query/'+pid,function(data){
			if(data){
				var log_content = data.log_content
				top.dialog({
		       		id:'art-dialog',
		       		title:'操作类型：'+type_val,
		       		content:'<textarea id="resultTxt" rows="20" cols="110" class="form-control" style="color:#000;" readonly="readonly">'+JSON.stringify(JSON.parse(log_content),null,'\t')+'</textarea>',
		       		okValue:'确定',
		       		ok:function(){}
		      	}).show();
			}
		},'json');
		
	}
</script>
</html>
