<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>授权用户</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/multiSelect/css/multi-select.dist.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/selectize/css/selectize.default.css" />
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
		<script src="${ctx}/scripts/control/js/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
			.error-tip{
				color:#dd4b39;
			}
			
			#exTab1 .tab-content {
				background-color: #f9fbfd;
				padding : 5px 15px;
			}
			
			 html,body {
				padding: 0;
				margin: 10px;
			}
		</style>
	</head>

	<body>
	
		<form id="user-form" class="form-horizontal" role="form" action="${ctx}/control/user/auth" method="post" >
		
			<div class="form-group">
			    <label for="name" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>被授权的用户：</label>
			    <div class="col-sm-3">
			    	<input type="hidden" id="userid" name="userid" value="${userid}" />
			    	<input type="text" class="form-control" name="name" id="name" value="${name}" disabled />
			    </div>
			</div>
			
			<div class="form-group">
			    <label class="col-sm-2 control-label">&nbsp;</label>
			    <div class="col-sm-3">
			    	<div id="exTab1" class="container">
						<ul class="nav nav-pills">
							<li class="active">
								<a href="#1a" data-tid="1a" data-toggle="tab" onclick="clearMsg();">角色授权</a>
							</li>
							
							<li>
								<a href="#2a" data-tid="2a" data-toggle="tab" onclick="clearMsg();">资源授权</a>
							</li>
						</ul>
						
						<div class="tab-content clearfix">
							<div class="tab-pane active" id="1a">
									<%-- <table class="table table-bordered">
										<tr>
											<c:forEach items="${roles}" var="role" varStatus="statu">
												<td>
													<label class="checkbox-inline" >
														<input type="checkbox" name="roleIds" value="${role.id}" <c:forEach items="${userRoles}" var="uRole"><c:if test="${uRole.id eq role.id}">checked</c:if></c:forEach> >${role.name}
													</label>
												</td>
												<c:if test="${statu.count%4 == 0}">
													</tr>
													<tr>
												</c:if>
											</c:forEach>
										</tr>
									</table>
									--%>
									<select id="role-select" name="roleIds" multiple placeholder="请选择角色...">
										<c:forEach items="${roles}" var="role" varStatus="statu">
											<option value="${role.id}" <c:forEach items="${userRoles}" var="uRole"><c:if test="${uRole.id eq role.id}">selected</c:if></c:forEach>>${role.name}</option>
										</c:forEach>
									</select>
							</div>
							
							<div class="tab-pane" id="2a">
									<select id="resource_id" name="resource_id" multiple="multiple" class="optgroup">
								    		<c:forEach items="${resources}" var="resource" varStatus="status">
								    			<optgroup label="${resource.name}" data-id="${resource.id}">
									    			<c:forEach var="m" items="${map}">
									    				<c:if test="${m.key eq resource.id}">
									    					<c:forEach var="r" items="${m.value}">
									    						<option value="${r.id}" <c:forEach items="${userResources}" var="ur"> <c:if test="${ur.resource_id eq r.id}">selected</c:if></c:forEach> >${r.name}</option>
									    					</c:forEach>
									    				</c:if>
									    			</c:forEach>
									    		</optgroup>
								    		</c:forEach>
								    </select>
							</div>
							
						</div>

					</div>
					
			    </div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="button" class="btn btn-primary" id="authUser"><img src="${ctx}/images/save.png" />&nbsp;保存</button>
			      <button type="button" class="btn btn-primary" id="backList" onclick="javascript:window.location.href='${ctx}/control/user/list'"><img src="${ctx}/images/back.png" />&nbsp;返回</button>
			      <span class="error-tip msg"></span>
			    </div>
		  	</div>
		  	
		  	
		</form>
	</body>
	
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/multiSelect/js/jquery.multi-select.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/quicksearch/jquery.quicksearch.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/selectize/js/standalone/selectize.min.js" charset="utf-8"></script>
	<script type="text/javascript">
		
		$(document).ready(function(){
			
			$('#authUser').click(function(){
				var $li = $('li.active').find('a'),
				 data_tid = $li.attr('data-tid'),
				 error_tip = $('.msg'),
				 roleids = [];
				 
				 error_tip.html('');
				 
				if(data_tid == '1a'){
					
					/** var $inputs = $('input[name*=roleIds]:checked');
					if($inputs.length == 0){
						error_tip.html('&nbsp;请选择角色');
						return;
					}
					
					for(var i = 0;i<$inputs.length;i++){
						roleids.push($inputs.get(i).value);
					}**/
					
					var $role_select = $('#role-select');
					if(!$role_select.val()){
						error_tip.html('&nbsp;请选择角色');
						return;
					}
					roleids = $role_select.val();
					
					$.ajax({
						url:'${ctx}/control/user/auth',
						type:'post',
						dataType:'json',
						data:{'roleIds':roleids.join(','),'userid':$('#userid').val() },
						success:function(data){
							if(data && data.code == '0'){
								dialog({
									title:'提示',
									content:'保存成功',
									ok:function(){}
								}).show();
							}else{
								dialog({
									title:'提示',
									content:'保存失败',
									ok:function(){}
								}).show();
							}
							
						}
					});
				}
				
				if(data_tid == '2a'){
					var resource_id = $('#resource_id');
					if(!resource_id.val()){
						error_tip.html('&nbsp;请选择资源')
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
						url:'${ctx}/control/user/auth',
						type:'post',
						dataType:'json',
						data:{'resource_id':rids.join(','),'userid':$('#userid').val() },
						success:function(data){
							if(data && data.code == '0'){
								dialog({
									title:'提示',
									content:'保存成功',
									ok:function(){}
								}).show();
							}else{
								dialog({
									title:'提示',
									content:'保存失败',
									ok:function(){}
								}).show();
							}
						}
					});
					
				}
				
				
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
			
			var $select = $('#role-select').selectize({
				plugins: ['remove_button'],
				persist: false,
				create: false,
				maxItems: null,
				render: {
					item: function(data, escape) {
						return '<div>' + escape(data.text) + '</div>';
					}
				},
				onDropdownOpen:function(){
						window.parent.iFrameHeight('funcIframe');
						var ifrm = window.parent.document.getElementById('funcIframe');
						if(ifrm){
							$(ifrm).height($(ifrm).height() + 200);
						}
				},
				onDelete: function(values) {
					return true;
				}
			});
			
			setTimeout(function(){
				$select[0].selectize.open();
			},500);
			
		});
		
		function clearMsg(height){
			var error_tip = $('.msg');
			error_tip.html('');
		}
		
		
	</script>
</html>