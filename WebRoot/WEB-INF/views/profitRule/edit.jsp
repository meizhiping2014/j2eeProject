<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>新增供应商</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/bootstrap/fontcss.css" rel="stylesheet">
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" type="text/css" />
		<link href="${ctx}/scripts/bootstrap/plugins/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/My97DatePicker/skin/WdatePicker.css" />
		<style type="text/css">
			.error-tip{color:#dd4b39;}
			#tbody td{border-top: 0px;}
			.panel-primary>.panel-heading{background-color:#30a5ff;}
			.panel-primary{border-color: #30a5ff;}
			.btn-primary{background-color: #30a5ff;border-color: #30a5ff;}
			.company-product{margin: 0px;background-color: #30a5ff;line-height: 30px;}
		</style>
	</head>

	<body>
		<div class="panel panel-primary">
			<div class="panel-heading">新增收益到账规则</div>
		  	<div class="panel-body">
		  	<form id="company-form" class="form-horizontal" role="form" action="${ctx}/profitRule/save" method="post">
			  	<div class="form-group">
			  		<label for="companyFullName" class="col-sm-1 control-label">供应商</label>
			    	<div class="col-sm-4">
			    		<input type="hidden" id="pid" name="pid" value="${ppi.pid}"/>
			    		<select id="fkTCompanyInfoId" name="fkTCompanyInfoId" class="form-control" onchange="ciChange();" <c:if test="${isEdit}">disabled</c:if>>
							<c:forEach items="${companyList}" var="company" varStatus="statu">
								<option value="${company.pid}" <c:if test="${ppi.cPid == company.pid}">selected</c:if>>${company.companyFullName}</option>
							</c:forEach>
						</select>
			    	</div>
			    	<label for="conmparnyAbbreviation" class="col-sm-1 control-label">供应商产品</label>
			    	<div class="col-sm-4">
			      		<select id="productName" name="productName" class="form-control" onchange="productChange();" <c:if test="${isEdit}">disabled</c:if>>	
						</select>
			    	</div>
			   </div>
			    <div class="form-group">
			    	<label for="consumptionType" class="col-sm-1 control-label">消费权益类型</label>
			    	<div class="col-sm-4">
			      		<select id="consumptionType" name="consumptionType" class="form-control" disabled>
							<c:forEach items="${consumptionTypes}" var="consumptionType" varStatus="statu">
								<option value="${consumptionType.dictdata_value}" <c:if test="${ppi.consumptionType == consumptionType.dictdata_value}">selected</c:if>>${consumptionType.dictdata_name}</option>
							</c:forEach>
						</select>
			    	</div>
			    	<label for="profitType" class="col-sm-1 control-label">收益展示</label>
			    	<div class="col-sm-4">
			      		<select id="profitType" name="profitType" class="form-control" disabled>
							<c:forEach items="${profitTypes}" var="profitType" varStatus="statu">
								<option value="${profitType.dictdata_value}" <c:if test="${ppi.profitType == consumptionType.dictdata_value}">selected</c:if>>${profitType.dictdata_name}</option>
							</c:forEach>
						</select>
			    	</div>
			  	</div>
			  	<div class="form-group">
			    	<label for="profitReturnType" class="col-sm-1 control-label">客户收益给予</label>
			    	<div class="col-sm-4">
			      		<select id="profitReturnType" name="profitReturnType" class="form-control" disabled>
							<c:forEach items="${profitReturnTypes}" var="profitReturnType" varStatus="statu">
								<option value="${profitReturnType.dictdata_value}" <c:if test="${ppi.profitReturnType == consumptionType.dictdata_value}">selected</c:if>>${profitReturnType.dictdata_name}</option>
							</c:forEach>
						</select>
			    	</div>
			    	<label for="priceType" class="col-sm-1 control-label">价格类型</label>
			    	<div class="col-sm-4">
			      		<select id="priceType" name="priceType" class="form-control" disabled>
							<c:forEach items="${priceTypes}" var="priceType" varStatus="statu">
								<option value="${priceType.dictdata_value}">${priceType.dictdata_name}</option>
							</c:forEach>
						</select>
			    	</div>
			  	</div>   
			  	<div class="form-group">
			  		<label for="conmparnyAbbreviation" class="col-sm-1 control-label">首充日</label>
			    	<div class="col-sm-4">			    		
			      		<input type="text" class="form-control" id="firstRechargeDay" name="firstRechargeDay" value="${ppi.firstRechargeDay}">
			    	</div>
			    	<label for="conmparnyAbbreviation" class="col-sm-1 control-label">到账类型</label>
			    	<div class="col-sm-4">		
			    		<select id="arrivalType" name="arrivalType" class="form-control">
							<c:forEach items="${arrivalTypes}" var="arrivalType" varStatus="statu">
								<option value="${arrivalType.dictdata_value}" <c:if test="${ppi.arrivalType == consumptionType.dictdata_value}">selected</c:if>>${arrivalType.dictdata_name}</option>
							</c:forEach>
						</select>   		
			    	</div>
			  	</div>
			  	<div class="form-group suiyi">
			  		<label for="proMinPrice" class="col-sm-1 control-label">最低价格</label>
			    	<div class="col-sm-4">			    		
			      		<input type="text" class="form-control" id="proMinPrice" name="proMinPrice" value="" disabled="disabled">
			    	</div>
			    	<label for="proMaxPrice" class="col-sm-1 control-label">最高价格</label>
			    	<div class="col-sm-4">			    		
			      		<input type="text" class="form-control" id="proMaxPrice" name="proMaxPrice" value="" disabled>
			    	</div>
			  	</div>
			  	<div class="form-group suiyi">
			  		<label for="proIncreasePrice" class="col-sm-1 control-label">最低叠加价格</label>
			    	<div class="col-sm-4">			    		
			      		<input type="text" class="form-control" id="proIncreasePrice" name="proIncreasePrice" value="" disabled>
			    	</div>
			    	<label for="proDiscount" class="col-sm-1 control-label">折扣</label>
			    	<div class="col-sm-4">			    		
			      		<input type="text" class="form-control" id="proDiscount" name="proDiscount" value="" disabled>
			    	</div>
			  	</div>
			  	<p class="bg-primary company-product gdme">&nbsp;&nbsp;供应商产品价格详情</p>
			  	<input type="hidden" id="cppSize" name="cppSize" value=""/>
 				<table id="comProPrice" class="table table-bordered gdme">
			  		<tr>
					  <th style="width: 300px;">价格</th>
					  <th style="width: 300px;">折扣</th>
					</tr>
				</table>
				<p class="bg-primary company-product">&nbsp;&nbsp;前台产品收益规则配置</p>
			  	<table id="priceTab" class="table">
					<thead>
						<th style="width: 4.96%!important;">
							<button type="button" class="btn btn-primary" id="add"><img src="${ctx}/images/add.png" />&nbsp;增加</button>
						</th>						
						<th style="width: 16%!important;">价格</th>
						<th style="width: 16%!important;">期数</th>
						<th style="width: 16%!important;">期限（天）</th>
						<th style="width: 16%!important;">折扣</th>
					</thead>
						<c:choose>
		                   <c:when test="${empty pfList}">
				  				<tbody id="tbody" templateId="testTemplate" currentRowIndex="${fn:length(pfList) + 2}" minRow="1" maxRow="100">
				  			</c:when>
		                    <c:otherwise>
		                    	<tbody id="tbody" templateId="testTemplate" currentRowIndex="${fn:length(pfList) + 1}" minRow="1" maxRow="100">
		                    </c:otherwise>
		                </c:choose>
				  		<c:choose>
		                    <c:when test="${empty pfList}">
		                    	<tr id="cp1" index='1'>
									<td  style="width: 4.96%!important; line-height: 34px;">
										<a href="javascript:;" onclick="delTr('cp1')">删除</a>
									</td>
									<td  style="width: 16%!important;">
										<input type="hidden" id="cppId1" name="cppId" value="">
										<input type="text" class="form-control" id="price1" name="price" value="">
									</td>
									<td  style="width: 16%!important;">
										<input type="text" class="form-control" id="periods1" name="periods" value="">
									</td>
									<td  style="width: 16%!important;">
										<input type="text" class="form-control" id="term1" name="term" value="">
									</td>
									<td  style="width: 16%!important;">
										<input type="text" class="form-control" id="portalDiscount1" name="portalDiscount" value="">
									</td>
								</tr>
		                    </c:when>
		                    <c:otherwise>
		                        <c:forEach items="${pfList}" var="pr" varStatus="status">
		                        	<tr id="cp${status.count}" index='${status.count}'>
										<td  style="width: 4.96%!important; line-height: 34px;">
											<a href="javascript:;" onclick="delProfitRule('cp${status.count}','${pr.pid}')">删除</a>
										</td>
										<td  style="width: 16%!important;">
											<input type="hidden" id="cPId${status.count}" name="cPid" value="${pr.pid}">
											<input type="text" class="form-control" id="price${status.count}" name="price" value="<fmt:formatNumber type="number" groupingUsed="false" value="${pr.price}" />">
										</td>
										<td  style="width: 16%!important;">
											<input type="text" class="form-control" id="periods${status.count}" name="periods" value="${pr.periods}">
										</td>
										<td  style="width: 16%!important;">
											<input type="text" class="form-control" id="term${status.count}" name="term" value="${pr.term}">
										</td>
										<td  style="width: 16%!important;">
											<input type="text" class="form-control" id="portalDiscount${status.count}" name="portalDiscount" value="<fmt:formatNumber type="number" groupingUsed="false" value="${pr.portalDiscount}" />">
										</td>
									</tr>
		                        </c:forEach>
		                    </c:otherwise>
		                </c:choose>
					</tbody>
				</table>
			  	<div class="form-group">
				    <div class="col-sm-offset-2 col-sm-10">
				      <button type="button" class="btn btn-primary" id="submitCompany"><img src="${ctx}/images/save.png" />&nbsp;提交</button>
				      <span class="error-tip msg"></span>
				    </div>
			  	</div>
			</form>		  	
		  	</div>		  
		  	<div class="panel-footer"><a href="javascript:;" onclick="goBack();">返回</a></div>
			</div>
	</body>
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/dynamicRow/jquery.dynamicRow.js" charset="utf-8"></script>
	<script type="text/template" id="testTemplate">
			<tr id="cp{index}" index='{index}'>
				<td  style="width: 4.96%!important; line-height: 34px;">
					<a href="javascript:;" onclick="delTr('cp{index}')">删除</a>
				</td>
				<td  style="width: 16%!important;">
					<input type="hidden" id="cppId{index}" name="cppId" value="">
					<input type="text" class="form-control" id="price{index}" name="price" value="">
				</td>
				<td  style="width: 16%!important;">
					<input type="text" class="form-control" id="periods{index}" name="periods" value="">
				</td>
				<td  style="width: 16%!important;">
					<input type="text" class="form-control" id="term{index}" name="term" value="">
				</td>
				<td  style="width: 16%!important;">
					<input type="text" class="form-control" id="portalDiscount{index}" name="portalDiscount" value="">
				</td>				
			</tr>
	</script>
	<script type="text/javascript">
		function delTr(id){
			$('#tbody').removeDynamicRow(id);
			window.parent.iFrameHeight('funcIframe');
		}
		
		//删除前台产品收益规则
		function delProfitRule(index,pid){
			var tab = $("#tbody").find("tr").length;
			if(tab <= 1){
				dialog({
	        		id:'art-dialog',
	        		title:'提示',
	        		content:'至少保留一条数据',
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
        		 	$.ajax({
			            type: 'POST',
			            dataType: 'json',//返回json格式的数据
			            url: '${ctx}/profitRule/del',//要访问的后台地址
			            data: "pid=" + pid,//要发送的数据		            
			            success: function(data){//msg为返回的数据，在这里做数据绑定
			               if(data.flag == 1){
			               	 delTr(index);
			               }else{
			               	 dialog({
				        		id:'art-dialog',
				        		title:'提示',
				        		content:'删除系统数据出错,请联系开发人员！！！',
				        		okValue: '确定',
				        		ok:function(){}
			        		}).show();
			               }
						}
					});
        		 },
        		cancelValue: '取消',
        		cancel: function () {}
        	}).show();
		}
		
		//根据供应商加载供应商产品
		function ciChange(){
			var company =  $("#fkTCompanyInfoId").val();
			$("#productName option").remove();
			$.ajax({
	            type: 'POST',
	            dataType: 'json',//返回json格式的数据
	            url: '${ctx}/company/product/lists',//要访问的后台地址
	            data: "pid=" + company,//要发送的数据		            
	            success: function(data){//msg为返回的数据，在这里做数据绑定
	                $.each(data, function(i, n){
	                	var pid = data[i].pid;
	                	var productName =  data[i].productName;
	                	if(pid == '${ppi.cpiPid}'){
	                		$("#productName").append("<option value='"+pid+"' selected>"+productName+"</option>");
	                		return;
	                	}
	                	$("#productName").append("<option value='"+pid+"'>"+productName+"</option>");
	                });
	               productChange();
				}
			});
		}

		//查询供应商产品价格信息
		function queryCompanyProductPrice(productId,priceType) {
			
			var len = $("#comProPrice").find("tr").length;
			for(var i = 0; i < len; i++){
				$("#option"+i).remove();
			}
			$.ajax({
				type : 'POST',
				dataType : 'json',//返回json格式的数据
				url : '${ctx}/company/product/price',//要访问的后台地址
				data : "comProId=" + productId+"&priceType="+priceType,//要发送的数据		            
				success : function(data) {//msg为返回的数据，在这里做数据绑定
					if(priceType == '22001'){//随意充
						var cpp = data.cpp;
						$("#proMinPrice").val(cpp.minPrice);
						$("#proMaxPrice").val(cpp.maxPrice);
						$("#proIncreasePrice").val(cpp.increasePrice);
						$("#proDiscount").val(cpp.discount);
						$(".gdme").css("display","none");
						$(".suiyi").css("display","block");
					}else{
						for(var i = 0;i < data.cppList.length;i++){
							var minPrice = data.cppList[i].minPrice;
							var discount = data.cppList[i].discount;
							var html = '<tr id="option'+i+'"><td><input id="minPrice'+i+'" type="hidden" value="'+minPrice+'"/>'+minPrice+'</td><td>'+discount+'</td></tr>';
							$("#comProPrice").append(html); 
						}
						$("#cppSize").val(data.cppList.length);
						$(".gdme").css("display","block");
						$(".suiyi").css("display","none");
					}
				window.parent.iFrameHeight('funcIframe');
				}
			});
		}

		//根据产品，动态加载产品相关信息
		function productChange() {
			var productPid = $("#productName").val();
			$.ajax({
				type : 'POST',
				dataType : 'json',//返回json格式的数据
				url : '${ctx}/company/product/info',//要访问的后台地址
				data : "pid=" + productPid,//要发送的数据		            
				success : function(data) {//msg为返回的数据，在这里做数据绑定      
					$("#consumptionType").val(data.consumptionType);
					$("#profitType").val(data.profitType)
					$("#profitReturnType").val(data.profitReturnType);
					$("#priceType").val(data.priceType);
					queryCompanyProductPrice(productPid,data.priceType);		
				}
			});
		}

		$(document).ready(function() {
			$('#add').click(function() {
				$('#tbody').addDynamicRow();
				window.parent.iFrameHeight('funcIframe');
			});

			ciChange();
		});
		
		function goBack() {
			window.location.href = '${ctx}/profitRule/list';
		}

		$("#submitCompany").click(function() {

			var error_tip = $('.msg');
			error_tip.html('');

			var productName = $('#productName');
			var productVal = productName.val();
			if (Reg.isNull(productVal)) {
				error_tip.html('&nbsp;请选择供应商产品');
				productName.focus();
				return;
			}

			var firstRechargeDay = $('#firstRechargeDay');
			var trim_firstRechargeDay = Reg.trim(firstRechargeDay.val());
			if (Reg.isNull(trim_firstRechargeDay)) {
				error_tip.html('&nbsp首充日不能为空');
				firstRechargeDay.focus();
				return;
			}

			var flag = true;
			$('#tbody tr').each(function () {
				var i = $(this).attr('index');
				var price = $("#price" + i);
				var trim_price;
				if (Reg.isNull(price.val())) {
					error_tip.html('&nbsp;价格不能为空');
					price.focus();
					flag = false;
					return false;//跳出循环
				} else {
					trim_price = Reg.trim(price.val());
					if (Reg.isNull(trim_price)) {
						error_tip.html('&nbsp;价格不能为空');
						price.focus();
						flag = false;
						return false;//跳出循环
					}
				}

				if (!Reg.intOrFloat(trim_price)) {
					error_tip.html('&nbsp;价格输入错误');
					price.focus();
					flag = false;
					return false;//跳出循环
				}

				var periods = $("#periods" + i);
				var trim_periods;
				if (Reg.isNull(periods.val())) {
					error_tip.html('&nbsp;期数不能为空');
					periods.focus();
					flag = false;
					return false;//跳出循环
				} else {
					trim_periods = Reg.trim(periods.val());
					if (Reg.isNull(trim_periods)) {
						error_tip.html('&nbsp;期数不能为空');
						periods.focus();
						flag = false;
						return false;//跳出循环
					}
				}

				if (!Reg.noZeroInt(trim_periods)) {
					error_tip.html('&nbsp;期数输入错误');
					periods.focus();
					flag = false;
					return false;//跳出循环
				}

				var term = $("#term" + i);
				var trim_term;
				if (Reg.isNull(term.val())) {
					error_tip.html('&nbsp;期限不能为空');
					term.focus();
					flag = false;
					return false;//跳出循环
				} else {

					trim_term = Reg.trim(term.val());
					if (Reg.isNull(trim_term)) {
						error_tip.html('&nbsp;期限不能为空');
						term.focus();
						flag = false;
						return false;//跳出循环
					}
				}

				if (!Reg.noZeroInt(trim_term)) {
					error_tip.html('&nbsp;期限请填写正整数');
					term.focus();
					flag = false;
					return false;//跳出循环
				}

				var portalDiscount = $("#portalDiscount" + i);
				var trim_portalDiscount;
				if (Reg.isNull(portalDiscount.val())) {
					error_tip.html('&nbsp;折扣不能为空');
					portalDiscount.focus();
					flag = false;
					return false;//跳出循环
				} else {
					trim_portalDiscount = Reg.trim(portalDiscount.val());
					if (Reg.isNull(trim_portalDiscount)) {
						error_tip.html('&nbsp;折扣不能为空');
						portalDiscount.focus();
						flag = false;
						return false;//跳出循环
					}
				}

				if (!Reg.intOrFloat(trim_portalDiscount)) {
					error_tip.html('&nbsp;折扣输入错误');
					portalDiscount.focus();
					flag = false;
					return false;//跳出循环
				}
				
				var result = trim_term % trim_periods;
				if (result != 0) {
					error_tip.html('&nbsp;期限除以期数应为正整数');
					periods.focus();
					flag = false;
					return false;//跳出循环
				}
				
				var bool = false;
				var priceType = $("#priceType").val();
				if(priceType == '22001'){//随意充
					var proMinPrice = $("#proMinPrice").val();
					var proMaxPrice = $("#proMaxPrice").val();
					var proIncreasePrice = $("#proIncreasePrice").val();
					//价格/期数/最低价格 = 1
					var result1 = trim_price / trim_periods / proMinPrice;
					//价格/期数/最高价格 = 1
					var result2 = trim_price / trim_periods / proMaxPrice;
					//（价格/期数-最低价格）% 叠加价格=0
					var result3 = (trim_price / trim_periods - proMinPrice) % proIncreasePrice;
					
					if(result1 == 1 || result2 == 1 || result3 == 0){//满足任意条件即可
						bool = true;
					}
				}else if(priceType == '22002'){//固定面额
					var cppSize = $("#cppSize").val();
					for (var i = 0; i < cppSize; i++) {
						var minPrice = $("#minPrice"+i).val();
						var res = trim_price / trim_periods / minPrice;//前台产品价格/期数/供应商产品价格
						if(res == 1){
							bool = true;
						}
					}
				}
				if(!bool){
					error_tip.html('&nbsp;收益规则与供应商产品价格不匹配');
					price.focus();
					flag = false;
					return false;//跳出循环
				}
			});
			
			if(!flag){//如果验证失败，则不提交
				return;
			}
			
			$("#company-form").submit();
		});
	</script>
</html>
