<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="description" content="appstore" />
		<meta name="keywords" content="appstore" />
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0">
		<title>选择产品</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		
		<style type="text/css">
			.fwmc_xxk { overflow: hidden; width: 350px; margin-left: 0px; }
			.fwmc_xxk li { float: left; width: 145px; height: 60px; border: 1px solid #ddd; font-size: 18px; color: #666; margin-right: 30px; text-align: center; margin-bottom: 15px; overflow: hidden; cursor: pointer; }
			.fwmc_xxk li p { line-height: 18px; font-size: 12px; color: #999; margin-top: 0px; }
			.fwmc_xxk li.on {color: #169ed8; border: 1px solid #169ed8; }
			.fwmc_xxk li.on p { color: #169ed8; }
			.zwfb_zje { margin-left: 20px; font-size: 20px; color: #169ed8; }
			.zwfb_zje i { font-size: 14px; padding-left: 5px; font-style: normal; }
			p{margin-bottom: 0px;}
			ul{margin-left:1rem;}
		</style>
	</head>
	<body>
		<div class="row">
		  <div class="col-xs-6">&nbsp;</div>
		  <div class="col-xs-6">&nbsp;</div>
		</div>
		<div class="container">
			<ul class="fwmc_xxk">
				<c:forEach var="cpi" items="${list}" varStatus="statu">
		            <li <c:if test="${statu.count == 1}">class="on"</c:if> onclick="getProductInfo(${statu.count})">
		            <i>${cpi.price}</i>元
		            <p>${cpi.portalDiscount}</p>
		            </li>		
		            <input type="hidden" id="pid${statu.count}" name="pid${statu.count}" value="${cpi.pid}"/>
	            	<input type="hidden" id="price${statu.count}" name="price${statu.count}" value="${cpi.price}"/>
	            	<input type="hidden" id="portalDiscount${statu.count}" name="portalDiscount${statu.count}" value="${cpi.portalDiscount}"/>
	            </c:forEach>
	            	<div style="float:left; width:400px; height:60px;">
	            		价格：<span id="priceText"></span><br/>
						折扣：<span id="portalDiscountText"></span><br/>
	            	</div>
	            <form id="product-form" class="form-horizontal" role="form" action="${ctx}/h5/topay" method="post" >
	            	<input type="hidden" id="data" name="data" value="${data}">
		            <input type="hidden" id="pid" name="pid" value=""/>
		            <input type="hidden" id="price" name="price" value=""/>
		            <input type="hidden" id="portalDiscount" name="portalDiscount" value=""/>
	          		<button type="button" id="submitProduct" class="btn btn-primary btn-lg btn-block">下一步</button>
				</form>
		</div>
	</body>
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>	
	<script type="text/javascript">
		$(document).ready(function(){
			initProduct();
			
			$(".fwmc_xxk li").click(function(){
				$(this).addClass("on").siblings().removeClass("on");
			});
			
			$("#submitProduct").click(function(){
			
				var pid  = Reg.trim($("#pid").val());
		    	if(Reg.isNull(pid)){
		    		alert("请选择产品！");
		    		return;
		    	}
			
				$("#product-form").submit();
			});
		});
		
		function initProduct(){
			$("#pid").val($("#pid1").val());
			$("#price").val($("#price1").val());
			$("#portalDiscount").val($("#portalDiscount1").val());
			$("#priceText").text($("#price1").val());
			$("#portalDiscountText").text($("#portalDiscount1").val());
		}
		
		function getProductInfo(index){
			$("#pid").val($("#pid"+index).val());
			$("#price").val($("#price"+index).val());			
			$("#portalDiscount").val($("#portalDiscount"+index).val());				
			$("#priceText").text($("#price"+index).val());			
			$("#portalDiscountText").text($("#portalDiscount"+index).val());
		}
	</script>
</html>