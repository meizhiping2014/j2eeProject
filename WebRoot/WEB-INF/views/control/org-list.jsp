<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>机构列表</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">

		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
		<script src="${ctx}/scripts/control/js/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
		
			table.dataTable tbody tr.selected {
				background-color: #a9d9ff;
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
	
	<table id="orgTable" class="cell-border" cellspacing="0" width="100%">
					<thead>
						<tr>
							<th>
								id
							</th>
							<th>
								机构编码
							</th>
							<th>
								机构名称
							</th>
							<th>
								机构地址
							</th>
						</tr>
					</thead>
				</table>
				
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	
	<script src="${ctx}/scripts/datatable/jquery.dataTables.min.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.js" charset="utf-8"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var orgTable = $('#orgTable').DataTable( {
				paging:true,
				processing: true,
				order: [[ 0, "desc" ]],
				serverSide: true,
				ajax:{
					url:'${ctx}/control/org/list/'+'${id}',
					type:'post',
					dataType:'json',
					data:{
						'searchVal':function(){
							return $('#orgTable_filter').find('input').val();
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
			        { data : 'code' },
			        { data : 'name'},
			        { data : 'address'}
			    ],
	            language: {
	                "url": "${ctx}/scripts/datatable/plugins/chinese.lang"
	            }
	        });
		});
	</script>
	</body>
</html>