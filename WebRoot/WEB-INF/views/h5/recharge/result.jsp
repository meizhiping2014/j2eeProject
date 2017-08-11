<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="description" content="appstore" />
<meta name="keywords" content="appstore" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0">
<title>米加-充值结果</title>
<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
</head>
<body>

	<c:if test="${not empty result and result eq '1'}">
		<center><img src="${ctx}/images/pay_success.png" /></center>
		<p></p>
		<center>${msgTip}，金额：${money}</center>
		<p></p>
	</c:if>
	
	<c:if test="${not empty result and result eq '0'}">
		<center><img src="${ctx}/images/pay error.png" /></center>
		<p></p>
		<center>${msgTip}</center>
		<p></p>
	</c:if>
	<center><a href="${ctx}/h5/store" id="backStore" class="btn btn-primary">返回继续充值</a></center>
</body>
</html>