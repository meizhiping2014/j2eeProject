<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="description" content="appstore" />
		<meta name="keywords" content="appstore" />
		<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0">
		<title>米加-预存</title>
		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">

		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/foundation.min.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/datatable/plugins/foundation/dataTables.foundation.min.css" />
		
		<link rel="stylesheet" type="text/css" href="${ctx}/scripts/chosen/chosen.min.css" />
		
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
		<script src="${ctx}/scripts/control/js/respond.min.js"></script>
		<![endif]-->
		
		<style type="text/css">
			.error-tip{
				color:#dd4b39;
			}
			.form-horizontal .form-group{
				    margin-right: 0;
				    margin-left: 0;
			}
		</style>
	</head>
	<body>
		<div class="row">
		  <div class="col-xs-6">&nbsp;</div>
		  <div class="col-xs-6">&nbsp;</div>
		</div>
		<form id="store-form" class="form-horizontal" role="form" action="${ctx}/h5/store" method="post" >
			
			<div class="form-group">
			    <label for="userName" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>用户姓名：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control" name="userName" id="userName" placeholder="请输入用户姓名">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="identifyCard" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>身份证号：</label>
			    <div class="col-sm-3">
			    	<input type="text" class="form-control" name="identifyCard" id="identifyCard" placeholder="请输入身份证号" />
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="userPhone" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>手机号：</label>
			    <div class="col-sm-3">
			      <input type="text" class="form-control" name="userPhone" id="userPhone" placeholder="请输入手机号" maxlength="11"/>
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="bankNo" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>银行卡号：</label>
			    <div class="col-sm-3">
			    	<input type="email" class="form-control" name="bankNo" id="bankNo" placeholder="请输入银行卡号">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="chargeNo" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>充值卡号：</label>
			    <div class="col-sm-3">
			    	<input type="email" class="form-control" name="chargeNo" id="chargeNo" placeholder="请输入充值卡号">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="productNo" class="col-sm-2 control-label"><span class="error-tip">*&nbsp;</span>产品名称：</label>
			    <div class="col-sm-3">
			    	<input type="email" class="form-control" name="productNo" id="productNo" placeholder="请输入产品名称">
			    </div>
			</div>
			
			<div class="form-group">
			    <div class="col-sm-offset-2 col-sm-10">
			      <button type="button" class="btn btn-primary" id="storeBtn">下一步</button>
			      <span class="error-tip msg"></span>
			    </div>
		  	</div>
		</form>
	</body>
	<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/dynamicRow/jquery.dynamicRow.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
	<script src="${ctx}/scripts/bootstrap/bootstrap.min.js"></script>
	<script src="${ctx}/scripts/chosen/chosen.jquery.min.js"></script>
	<script type="text/template" id="testTemplate">
			<tr id="cp{index}" index='{index}'>
				<td>
					<a href="javascript:;" onclick="delTr('cp{index}')">删除</a>
				</td>
				<td>
					编号{index}
				</td>
				<td>
					类型
				</td>
				<td>
					期数／期限
				</td>
				<td>
					折扣／年化
				</td>
				<td>
					状态
				</td>
			</tr>
	</script>
	<script type="text/javascript">
	
		function delTr(id){
			$('#tbody').removeDynamicRow(id)
		}
		
		$(document).ready(function(){
		
			$('#add').click(function(){
				$('#tbody').addDynamicRow()
			});
			
			// 预存
			$('#storeBtn').click(function(){
			
				var error_tip = $('.msg');
				error_tip.html('');
			
				var userName = $('#userName');
		    	var trim_userName  = Reg.trim(userName.val());
		    	if(Reg.isNull(trim_userName)){
		    		error_tip.html('&nbsp;请输入用户姓名');
		    		userName.focus();
		    		return ;
		    	}
		    	
		    	userName.val(trim_userName);
		    	
		    	var identifyCard = $('#identifyCard');
		    	var trim_identifyCard  = Reg.trim(identifyCard.val());
		    	if(Reg.isNull(trim_identifyCard)){
		    		error_tip.html('&nbsp;请输入身份证号');
		    		identifyCard.focus();
		    		return ;
		    	}
		    	
		    	// 验证通过!
		    	var result_msg = idNoCheck(trim_identifyCard);
		    	if(result_msg != '验证通过!'){
		    		error_tip.html('&nbsp;'+result_msg);
		    		identifyCard.focus();
		    		return;
		    	}
		    	
		    	identifyCard.val(trim_identifyCard);
		    	
		    	var userPhone = $('#userPhone');
		    	var trim_userPhone  = Reg.trim(userPhone.val());
		    	if(Reg.isNull(trim_userPhone)){
		    		error_tip.html('&nbsp;请输入手机号');
		    		userPhone.focus();
		    		return ;
		    	}
		    	
		    	if(!Reg.Mobile(trim_userPhone)){
		    		error_tip.html('&nbsp;手机号格式有误');
		    		userPhone.focus();
		    		return ;
		    	}
		    	
		    	var bankNo = $('#bankNo');
		    	var trim_bankNo  = Reg.trim(bankNo.val());
		    	if(Reg.isNull(trim_bankNo)){
		    		error_tip.html('&nbsp;请输入银行卡号');
		    		bankNo.focus();
		    		return ;
		    	}
		    	
		    	if(!Reg.onlyInt(trim_bankNo)){
		    		error_tip.html('&nbsp;银行卡号格式不正确');
		    		bankNo.focus();
		    		return ;
		    	}
		    	
		    	var chargeNo = $('#chargeNo');
		    	var trim_chargeNo  = Reg.trim(chargeNo.val());
		    	if(Reg.isNull(trim_chargeNo)){
		    		error_tip.html('&nbsp;请输入充值卡号');
		    		chargeNo.focus();
		    		return ;
		    	}
		    	
		    	if(!Reg.onlyInt(trim_chargeNo)){
		    		error_tip.html('&nbsp;充值卡号格式不正确');
		    		chargeNo.focus();
		    		return ;
		    	}
		    	
		    	
		    	var productNo = $('#productNo');
		    	var trim_productNo  = Reg.trim(productNo.val());
		    	if(Reg.isNull(trim_productNo)){
		    		error_tip.html('&nbsp;请输入产品名称');
		    		productNo.focus();
		    		return ;
		    	}
		    	
		    	$('#store-form').submit()
		    	
			});
		})
	</script>
</html>