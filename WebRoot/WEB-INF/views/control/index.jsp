<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.joda.time.DateTime"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>米加PPBUY</title>

		<link href="${ctx}/scripts/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${ctx}/scripts/control/css/styles.css" rel="stylesheet">
		<link href="${ctx}/scripts/bootstrap/fontcss.css" rel="stylesheet">
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" />
		<lin href="${ctx}/scripts/bootstrap/plugins/treeview/bootstrap-treeview.min.css" rel="stylesheet" />
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/control/js/html5shiv.min.js"></script>
		<script src="${ctx}/scripts/control/js/respond.min.js"></script>
		<![endif]-->

		<style type="text/css">
		.error-tip {
			color: #dd4b39;
		}

		#sidebar-collapse {
			background-color: #30a5ff !important;
			color: #fff !important;
		}
		
		.col-lg-offset-2 {
		    margin-left: 14.66666667%;
		}
		
		.col-lg-10 {
		    width: 85.333333%;
		}
		</style>
		<script type="text/javascript">
			function iFrameHeight(id) {
			    var ifm = document.getElementById(id);
			    var subWeb = document.frames ? document.frames[id].document : ifm.contentDocument;
			    if(ifm != null && subWeb != null) {
			    	ifm.height = subWeb.body.scrollHeight;
			    }
			}
		</script>
	</head>

	<body>
		<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="javascript:;"><span>米加PPBUY</span>后台系统</a>
				<ul class="user-menu">
					<li class="dropdown pull-right">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span> ${user.name}<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li>
								<a href="javascript:;" id="view-user"><span class="glyphicon glyphicon-user"></span>&nbsp;个人资料</a>
							</li>
							<li>
								<a href="javascript:;" id="reset-password"><span class="glyphicon glyphicon-cog"></span>&nbsp;密码修改</a>
							</li>
							<li>
								<a href="${ctx}/control/logout"><span class="glyphicon glyphicon-log-out"></span>&nbsp;注销</a>
							</li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		</nav>

		<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar"
			style="width: 14%;">
			<form role="search">
				<div class="form-group">
					<img src="${ctx}/images/logo-white.png" class="img-responsive center-block" />
				</div>
			</form>
			<div id="treeview" class=""></div>
			<%-- <ul class="nav">
			<li role="presentation" class="divider"></li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-user"></span>当前用户：${user.name}</li>
		</ul>
		<div class="attribution">&copy;&nbsp;<%=new DateTime().getYear() %>&nbsp;<a href="http://www.cashlai.com" target="_blank" style="color:#fff;">钱来网</a></div>--%>
		</div>

		<div class="col-sm-9 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">
			<div class="row">
				<ol class="breadcrumb">
					<li>
						<a href="javascript:;" onclick="goHome();"><span class="glyphicon glyphicon-home"></span></a>
					</li>
					<li class="active">
						主页
					</li>
				</ol>
			</div>

<!--			<div class="row">-->
<!--				<div class="col-lg-1">-->
<!--					<h1 class="page-header"></h1>-->
<!--				</div>-->
<!--			</div>-->

			<div class="row">
				<div class="col-lg-11"
					style="width: 100%; padding-left: 0px; padding-right: 0px;">
					<div class="panel panel-default">
						<div class="panel-heading" id="panel-txt">
							主页
						</div>
						<div class="panel-body">
							<div class="canvas-wrapper">
								<iframe id="funcIframe" name="funcIframe" frameborder="0" width="100%" height="1" onload="iFrameHeight('funcIframe')" scrolling="no"></iframe>
							</div>
						</div>

						<div class="panel-footer" style="text-align: center;">
							&copy;&nbsp;<%=new DateTime().getYear() %>&nbsp;米加
						</div>

					</div>
				</div>
			</div>

		</div>

		<script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
		<script src="${ctx}/scripts/json2.js" charset="utf-8"></script>
		<script src="${ctx}/scripts/validate_reg.js" charset="utf-8"></script>
		<script src="${ctx}/scripts/bootstrap/bootstrap.min.js" charset="utf-8"></script>
		<script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
		<script src="${ctx}/scripts/bootstrap/plugins/treeview/bootstrap-treeview.min.js" charset="utf-8"></script>

		<script type="text/javascript">

		!function ($) {
		    $(document).on("click","ul.nav li.parent > a > span.icon", function(){          
		        $(this).find('em:first').toggleClass("glyphicon-minus");      
		    }); 
		    $(".sidebar span.icon").find('em:first').addClass("glyphicon-plus");
		}(window.jQuery);

		$(window).on('resize', function () {
		  if ($(window).width() > 768) $('#sidebar-collapse').collapse('show');
		});
		
		$(window).on('resize', function () {
		  if ($(window).width() <= 767) $('#sidebar-collapse').collapse('hide');
		});
		
		$(document).ready(function(){
			
			var $treeView;
			$.ajax({
				url:'${ctx}/control/resource/getResourceTree',
				type:'post',
				dataType:'json',
				success:function(data){
					if(data){
						var resources = data.rNodes;
						var datas = resources;//'${user.account}' == 'admin' ? resources :  resources[0].nodes;
						$treeView = $('#treeview').treeview({
						  levels: 1,
				          color: '#428bca',
				          searchResultColor: '#D9534F',
				          data: datas,
				          backColor: "#30a5ff",
				          color: "#fff",
				          showBorder: false,
				          selectedColor: "#fff",
				          selectedBackColor: "#30a5ff",
				          onhoverColor: "#30a5ff",
				          expandIcon: 'glyphicon glyphicon-chevron-right',
				          collapseIcon: 'glyphicon glyphicon-chevron-down',
				          onNodeSelected:function(event,node){
				          	if(node.path){
				          		var path = node.path;
				          		var rpath = path.replace('{uid}','${user.id}');
				          		$('#funcIframe').attr('src','${ctx}' + rpath);
				          		$('#panel-txt').html(node.text);
				          	}
				          },
				          onNodeUnselected:function(event,node){
				          },
				          onSearchComplete:function(event, results){
				          	
				          }
				     	});
					
					}
			     
				}
			});
			
			
			
			
			$('#search-menu').on('keyup', function(){
				var val = $(this).val();
				$treeView.treeview('search', [ val,{
				  ignoreCase: true,     // case insensitive
				  exactMatch: false,    // like:false，equals:true
				  revealResults: true,  // true:展开，false:不展开
				}]);
				
			}).on('keydown',function(){
				var val = $(this).val();
				$treeView.treeview('search', [ val,{
				  ignoreCase: true,     // case insensitive
				  exactMatch: false,    // like:false，equals:true
				  revealResults: true,  // true:展开，false:不展开
				}]);
			}).on('change',function(){
				var val = $(this).val();
				$treeView.treeview('search', [ val,{
				  ignoreCase: true,     // case insensitive
				  exactMatch: false,    // like:false，equals:true
				  revealResults: true,  // true:展开，false:不展开
				}]);
			});
			
			$('#view-user').click(function(){
				$('#funcIframe').attr('src','${ctx}/control/user/view/${user.id}');
			});
			
			// 重置密码
			$('#reset-password').click(function(){
				$('#funcIframe').attr('src','${ctx}/control/user/resetpass/${user.id}');
			});
			
			// 进入主页面展现当日数据
			$('#funcIframe').attr('src','${ctx}/control/today/${user.id}');
			
		});
		
		function toUrl(o){
			var url = $(o).attr('data-url');
			$(o).parent().on('click',function(){
				$('#funcIframe').attr('src','${ctx}/' + url);
			});
		}
		
		function goHome(){
			$('#panel-txt').html('主页');
			$('#funcIframe').attr('src','${ctx}/control/today/${user.id}');
		}
	</script>
	</body>

</html>
