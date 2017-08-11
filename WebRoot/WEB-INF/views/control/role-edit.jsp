<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>编辑角色</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/multiSelect/css/multi-select.dist.css" />
		
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
		<script src="${ctx}/scripts/control/js/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
			.error-tip{
				color:#dd4b39;
			}
			
			.custom-header {
			    text-align: center;
			    padding: 3px;
			    background:#30a5ff;
			    color: #fff;
			}
			input.search-input {
			    box-sizing: border-box;
			    -moz-box-sizing: border-box;
			    width: 100%;
			    margin-bottom: 5px;
			    height: auto;
			}
		</style>
	</head>
	<body>
	
	<form id="role-form" class="form-horizontal" role="form" >
			
			<div class="form-group">
			    <label for="name" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>角色名称：</label>
			    <div class="col-sm-3">
			    	<input type="hidden" name="id" id="id" value="${role.id}" />
			      <input type="text" class="form-control" name="name" id="name" placeholder="请输入角色名称" value="${role.name}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="resource_id" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>角色值：</label>
			    <div class="col-sm-3">
			      <select id="r_id" name="r_id" multiple="multiple" class="optgroup">
			    		<c:forEach items="${resources}" var="resource" varStatus="status">
			    			<optgroup label="${resource.name}" data-id="${resource.id}">
				    			<c:forEach var="m" items="${map}">
				    				<c:if test="${m.key eq resource.id}">
				    					<c:forEach var="r" items="${m.value}">
				    						<option value="${r.id}" <c:forEach var="rr" items="${roleResources}"><c:if test="${rr.resource_id eq r.id}">selected</c:if> </c:forEach> >${r.name}</option>
				    					</c:forEach>
				    				</c:if>
				    			</c:forEach>
				    		</optgroup>
			    		</c:forEach>
			    </select>
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="name" class="col-sm-2 control-label">角色描述：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control" name="description" id="description" placeholder="" value="${role.description}" />
			    </div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="button" class="btn btn-primary" id="saveRole"><img src="${ctx}/images/save.png" />&nbsp;保存</button>.
			      <button type="button" class="btn btn-primary" id="back" onclick="javascript:window.location.href='${ctx}/control/role/list'"><img src="${ctx}/images/back.png" />&nbsp;返回</button>
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
	<script src="${ctx}/scripts/multiSelect/js/jquery.multi-select.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/quicksearch/jquery.quicksearch.js" charset="utf-8"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			
			$('#saveRole').click(function(){
				
				var error_tip = $('.msg');
				error_tip.html('');
				
				var name = $('#name'),
					trim_name = Reg.trim(name.val());
				if(Reg.isNull(trim_name)){
					error_tip.html('&nbsp;请输入角色名')
					name.focus();
					return ;
				}
				
				var resource_id = $('#r_id');
				if(!resource_id.val()){
					error_tip.html('&nbsp;请选择角色')
					resource_id.focus();
					return ;
				}
				
				
				var rids = resource_id.val();
				
				$.each(rids,function(k,o){
					var opt = resource_id.find('option[value='+o+']').get(0);
					var d_id = opt.parentNode.getAttribute('data-id');
					if($.inArray(d_id,rids) == -1){
						rids.push(d_id);
					}
				});
				
				$.ajax({
		        	url:'${ctx}/control/role/edit',
		        	type:'post',
		        	dataType:'json',
		        	data:$('#role-form').serialize()+'&resource_id='+rids.join(','),
		        	success:function(data){
		        		if(data && data.code == '-1'){
		        			dialog({
		        				id:'role-add-dialog',
		        				title:'消息',
		        				content:'&nbsp;修改失败',
		        				 okValue: '确定',
		        				 ok: function () {
		        				 	window.location.href = window.location.href;
		        				 }
		        			}).show();
		        		}else{
		        			dialog({
		        				id:'role-add-dialog',
		        				title:'消息',
		        				content:'&nbsp;修改成功',
		        				 okValue: '确定',
		        				 ok: function () {
		        				 	window.location.href = '${ctx}/control/role/list';
		        				 }
		        			}).show();
		        		}
		        	}
		        });
				
			});
			
			// 初始化机构选择框
			$('.optgroup').multiSelect({
				selectableOptgroup: true,
				  selectableHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='输入值检索'>",
				  selectionHeader: "<input type='text' class='search-input' autocomplete='off' placeholder='已选值'>",
				  afterInit: function(ms){
				    var that = this,
				        $selectableSearch = that.$selectableUl.prev(),
				        $selectionSearch = that.$selectionUl.prev(),
				        selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
				        selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';
				
				    that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
				    .on('keydown', function(e){
				      if (e.which === 40){
				        that.$selectableUl.focus();
				        return false;
				      }
				    });
				
				    that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
				    .on('keydown', function(e){
				      if (e.which == 40){
				        that.$selectionUl.focus();
				        return false;
				      }
				    });
				  },
				  afterSelect: function(values){
				    this.qs1.cache();
				    this.qs2.cache();
				  },
				  afterDeselect: function(values){
				    this.qs1.cache();
				    this.qs2.cache();
				  }
			});
		});
	</script>
	</body>
</html>