<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
<link href="${ctx}/scripts/bootstrap/fontcss.css" rel="stylesheet">
<title>没有权限</title>
</head>

<body>
	<div class="jumbotron">
		<div class="container">
		  <h1>:(</h1>
		  <p>${param.message}</p>
		  <p><a class="btn btn-primary btn-lg" href="javascript:;" onclick="goBackOrHome();" role="button">返回上一页</a>
		  <a class="btn btn-primary btn-lg" href="javascript:;" onclick="goBackOrHome(-1);" role="button">首页</a></p>
		</div>
	</div>
	
</body>
<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>

<script type="text/javascript">
	function goBackOrHome(t){
		t ? parent.window.location.href = '${ctx}/control/main' : window.location.href = '<%=request.getHeader("Referer")%>';
	}
</script>
</html>