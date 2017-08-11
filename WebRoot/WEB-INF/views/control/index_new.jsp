<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.joda.time.DateTime"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>跨境电商</title>

		<link href="${ctx}/scripts/olive/css/bootstrap.min.css" rel="stylesheet"><!-- BOOTSTRAP CSS -->
		<link href="${ctx}/scripts/olive/css/bootstrap-reset.css" rel="stylesheet"><!-- BOOTSTRAP CSS -->
		<link href="${ctx}/scripts/artDialog/v6/css/ui-dialog.css" rel="stylesheet" />
		<link href="${ctx}/scripts/olive/assets/font-awesome/css/font-awesome.css" rel="stylesheet"><!-- FONT AWESOME ICON CSS -->
		<link href="${ctx}/scripts/olive/css/style.css" rel="stylesheet"><!-- THEME BASIC CSS -->
		<link href="${ctx}/scripts/olive/css/style-responsive.css" rel="stylesheet"><!-- THEME RESPONSIVE CSS -->
		<link href="${ctx}/scripts/jquery.mCustomScrollbar/jquery.mCustomScrollbar.min.css" rel="stylesheet">
		
		<!--[if lt IE 9]>
		<script src="${ctx}/scripts/olive/js/html5shiv.js">
		</script>
		<script src="${ctx}/scripts/olive/js/respond.min.js">
		</script>
		<![endif]-->

		
		<style type="text/css">
		.error-tip {
			color: #dd4b39;
		}

		</style>
		<script type="text/javascript">
		
			function getDocHeight(doc) { 
			
			    doc = doc || document; 
			    var body = doc.body, html = doc.documentElement; 
			    var height = Math.max( body.scrollHeight, body.offsetHeight,  
			        html.clientHeight, html.scrollHeight, html.offsetHeight ); 
			    return height; 
			} 

			function iFrameHeight(id) {
			
			    var ifrm = document.getElementById(id);
			    var doc = ifrm.contentDocument? ifrm.contentDocument:ifrm.contentWindow.document; 
    			ifrm.style.visibility = 'hidden'; 
    			ifrm.style.height = "10px"; 
    			ifrm.style.height = getDocHeight( doc ) + 4 + "px"; 
    			ifrm.style.visibility = 'visible'; 
    			
			}
		</script>
	</head>

	<body>
		<!-- BEGIN SECTION -->
    <section id="container">
      <!-- BEGIN HEADER -->
      <header class="header white-bg">
        <!-- SIDEBAR TOGGLE BUTTON -->
			<div class="sidebar-toggle-box">
			  <div  data-placement="right" class="fa fa-bars tooltips">
			  </div>
			</div>
        <!-- SIDEBAR TOGGLE BUTTON  END-->
        <a href="${ctx}/control/main" class="logo">
          跨境电商
          <span>
            ERP系统
          </span>
        </a>
           <!-- START HEADER  NAV -->
        
        <nav class="nav notify-row" id="top_menu">
          
          <ul class="nav top-menu">
            <!-- START NOTIFY TASK BAR -->
            
            <li class="dropdown">
              <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                <i class="fa fa-tasks">
                </i>
                <span class="badge bg-success">
                  2
                </span>
              </a>
              
              <ul class="dropdown-menu extended tasks-bar">
                <li class="notify-arrow notify-arrow-blue">
                </li>
                <li>
                  <p class="blue">
                    你有6笔待办事项
                  </p>
                </li>
                <li>
                  <a href="#">
                    <div class="task-info">
                      <div class="desc">
                        Database Update
                      </div>
                      <div class="percent">
                        60%
                      </div>
                    </div>
                    <div class="progress progress-striped">
                      <div class="progress-bar progress-bar-warning set-60" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" >
                        <span class="sr-only">
                          60% Complete (warning)
                        </span>
                      </div>
                    </div>
                  </a>
                </li>
                <li>
                  <a href="#">
                    <div class="task-info">
                      <div class="desc">
                        Dashboard v1.3
                      </div>
                      <div class="percent">
                        45%
                      </div>
                    </div>
                    <div class="progress progress-striped active">
                      <div class="progress-bar set-45" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" >
                        <span class="sr-only">
                          45% Complete
                        </span>
                      </div>
                      
                    </div>
                  </a>
                </li>
                <li class="external">
                  <a href="#">
                    	查看所有待办事项
                  </a>
                </li>
              </ul>
              
            </li>
            <!-- END NOTIFY TASK BAR -->
            
            <!-- START NOTIFY INBOX BAR -->
            
            <li id="header_inbox_bar" class="dropdown">
              <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                <i class="fa fa-envelope-o">
                </i>
                <span class="badge bg-important">
                  1
                </span>
              </a>
              <ul class="dropdown-menu extended inbox">
                <li class="notify-arrow notify-arrow-blue">
                </li>
                <li>
                  <p class="blue">
                    你有1条新消息
                  </p>
                </li>
                <li>
                  <a href="#">
                    <span class="photo">
                      <img alt="avatar" src="${ctx}/scripts/olive/img/avatar-mini.jpg">
                    </span>
                    <span class="subject">
                      <span class="from">
                        张三
                      </span>
                      <span class="time">
                        刚刚
                      </span>
                    </span>
                    <span class="message">
                     测试消息
                    </span>
                  </a>
                </li>
                <li>
                  <a href="#">
                    查看所有消息
                  </a>
                </li>
              </ul>
            </li>
            <!-- END NOTIFY INBOX BAR -->
            
            <!-- START NOTIFY NOTIFICATION BAR -->
            
            <li id="header_notification_bar" class="dropdown">
              <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                <i class="fa fa-bell-o">
                </i>
                <span class="badge bg-warning">
                  1
                </span>
              </a>
              <ul class="dropdown-menu extended notification">
                <li class="notify-arrow notify-arrow-blue">
                </li>
                <li>
                  <p class="blue">
                    你有1条新提醒
                  </p>
                </li>
                <li>
                  <a href="#">
                    <span class="label label-success">
                      <i class="fa fa-plus">
                      </i>
                    </span>
                    新客户注册
                    <span class="small italic">
                      刚刚
                    </span>
                  </a>
                </li>
                <li>
                  <a href="#">
                    查看所有提醒
                  </a>
                </li>
              </ul>
            </li>
            <!-- END NOTIFY NOTIFICATION BAR -->
            
          </ul>
          
          
        </nav>
		<!-- END HEADER NAV -->
        
		 <!-- START USER LOGIN DROPDOWN  -->
		
        <div class="top-nav ">
          <ul class="nav pull-right top-menu">
<!--            <li>-->
<!--              <input type="text" class="form-control search" placeholder="搜索">-->
<!--            </li>-->
            <li class="dropdown">
              <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                <img alt="" src="${ctx}/scripts/olive/img/avatar1_small.png">
                <span class="username">
                  ${user.name}
                </span>
                <b class="caret">
                </b>
              </a>
              <ul class="dropdown-menu extended logout">
                <li class="log-arrow-up">
                </li>
                <li>
                  <a href="javascript:;" id="view-user">
                    <i class=" fa fa-suitcase">
                    </i>
                    个人资料
                  </a>
                </li>
                <li>
                  <a href="javascript:;" id="reset-password">
                    <i class="fa fa-cog">
                    </i>
                    密码修改
                  </a>
                </li>
                <li>
                  <a href="javascript:;" id="notification">
                    <i class="fa fa-bell-o">
                    </i>
                    提醒
                  </a>
                </li>
                <li>
                  <a href="${ctx}/control/logout">
                    <i class="fa fa-key">
                    </i>
                    注销
                  </a>
                </li>
              </ul>
            </li>
          </ul>
        </div>
		<!-- END USER LOGIN DROPDOWN  -->
      </header>
      
      <!-- END HEADER -->
      <!-- BEGIN SIDEBAR -->
      <aside>
        <div id="sidebar" class="nav-collapse">
          <ul class="sidebar-menu" id="nav-accordion">
<!--            <li >-->
<!--              <a href="${ctx}/control/main" class="active">-->
<!--                <i class="fa fa-dashboard">-->
<!--                </i>-->
<!--                <span>-->
<!--                  主页-->
<!--                </span>-->
<!--              </a>-->
<!--            </li>-->
            
            
            
          </ul>
        </div>
      </aside>
      <!-- END SIDEBAR -->
      <!-- BEGIN MAIN CONTENT -->
      
      
      <section id="main-content">
	  <!-- BEGIN WRAPPER  -->
        <section class="wrapper">
		  <!-- BEGIN ROW  
          <div class="row state-overview">
            <div class="col-lg-12">
              <section class="panel">
                <div class="symbol">
                  <i class="fa fa-tags blue">
                  </i>
                </div>
                <div class="value">
                  <h1 class="count">
                    0
                  </h1>
                  <p>
                    Total Sale
                  </p>
                </div>
              </section>
            </div>
          </div>-->
          
		   <!-- END ROW  -->
		   
		    <!-- BEGIN ROW  -->
          <!--<div class="row state-overview">
            <div class="col-lg-3 col-sm-6">
              <section class="panel">
                <div class="symbol">
                  <i class="fa fa-tags blue">
                  </i>
                </div>
                <div class="value">
                  <h1 class="count">
                    0
                  </h1>
                  <p>
                    总交易额
                  </p>
                </div>
              </section>
            </div>
            <div class="col-lg-3 col-sm-6">
              <section class="panel">
                <div class="symbol">
                  <i class="fa fa-money red">
                  </i>
                </div>
                <div class="value">
                  <h1 class=" count2">
                    0
                  </h1>
                  <p>
                    交易额（今日数据）
                  </p>
                </div>
              </section>
            </div>
            <div class="col-lg-3 col-sm-6">
              <section class="panel">
                <div class="symbol">
                  <i class="fa fa-user yellow">
                  </i>
                </div>
                <div class="value">
                  <h1 class=" count3">
                    0
                  </h1>
                  <p>
                    注册客户（今日数据）
                  </p>
                </div>
              </section>
            </div>
            <div class="col-lg-3 col-sm-6">
              <section class="panel">
                <div class="symbol">
                  <i class="fa fa-shopping-cart purple">
                  </i>
                </div>
                <div class="value">
                  <h1 class=" count4">
                    0
                  </h1>
                  <p>
                    交易订单数
                  </p>
                </div>
              </section>
            </div>
          </div>
		    END ROW  -->
		   
		   
		   <!-- BEGIN ROW  -->
          <div class="row">
            <div class="col-lg-12">
              <section class="panel">
                <div class="panel-body">
                  <a href="#" class="task-thumb">
<!--                    <img src="img/avatar1.jpg" alt="">-->
                  </a>
                  <div class="task-thumb-details">
                    <h1>
                      <a href="javascript:;">
<!--                        Work Progress-->
                      </a>
                    </h1>
                    <p id="nav-title">
                      	主页
                    </p>
                  </div>
	                 <hr style="margin-top:10px;margin-bottom: 10px;"/>
	                <iframe id="funcIframe" name="funcIframe" frameborder="0" width="100%" scrolling="no" marginheight="0" marginwidth="0" onload="iFrameHeight(this.id)"></iframe>			
                </div>
                
              </section>
            </div>
          </div>
		   <!-- END ROW  -->
		   
        </section>
		<!-- END WRAPPER  -->
      </section>
      <!-- END MAIN CONTENT -->
      
      <!-- BEGIN FOOTER -->
      <footer class="site-footer">
        <div class="text-center">
          <%=new DateTime().getYear() %> &copy; 米加
<!--          <a href="javascript:;" target="_blank">-->
<!--            米加 Enterprise-->
<!--          </a>-->
          <a href="javascript:;" class="go-top">
            <i class="fa fa-angle-up">
            </i>
          </a>
        </div>
      </footer>
      <!-- END  FOOTER -->
    </section>
    
    <script src="${ctx}/scripts/jquery/jquery.js" charset="utf-8"></script>
    <script src="${ctx}/scripts/olive/js/bootstrap.min.js" ></script><!-- BOOTSTRAP JS -->
    <script src="${ctx}/scripts/olive/js/jquery.dcjqaccordion.2.7.js"></script><!-- ACCORDIN JS -->
    <script src="${ctx}/scripts/olive/js/respond.min.js" ></script><!-- RESPOND JS -->
    <script src="${ctx}/scripts/olive/js/count.js"></script><!-- COUNT JS -->
    <script src="${ctx}/scripts/artDialog/v6/dist/dialog-plus-min.js" charset="utf-8"></script>
    <script src="${ctx}/scripts/jquery.mCustomScrollbar/jquery.mCustomScrollbar.concat.min.js"></script>

    
		<script type="text/javascript">


		$(document).ready(function(){
			
			/** $('#nav-accordion').append($('#menu').html());**/
			colors = ['label-danger','label-success','label-primary','label-warning','label-info','label-inverse'];
			
			$.ajax({
				url:'${ctx}/control/resource/getResourceTree',
				async:false,
				type:'post',
				dataType:'json',
				success:function(data){
					if(data){
						var resources = data.rNodes;
						var datas = resources;
						
						
						var $temp_ul = $('<ul></ul>');
						initDomTree(datas,$temp_ul);
						
						$('#nav-accordion').append($temp_ul.children());
					}
				}
			});
			
			
					 
			$('.dom_node').click(function(e){
				var path = $(this).attr('data-path');
				var node_txt = $(this).attr('data-text');
				if(path){
					var rpath = path.replace('{uid}','${user.id}');
					$('#funcIframe').attr('src','${ctx}' + rpath);
					$('#nav-title').html(node_txt);
				}
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
		
		function initDomTree(nodes,p_node){
			
			$.each(nodes,function(k,dom_node){
				
				if(dom_node.nodes){
					// <span class="label '+colors[rd(0,5)]+' span-sidebar">'+dom_node.nodes.length+'</span>
					var $li = $('<li class="sub-menu"></li>');
					$li.append('<a href="javascript:;" data-path="'+dom_node.path+'" data-text="'+dom_node.text+'" class="dom_node"><i class="fa fa-th"></i><span>'+dom_node.text+'</span></a>')
					.append('<ul class="sub"></ul>')
					.appendTo(p_node);
					
					initDomTree(dom_node.nodes, $li.children().eq(1));
					
				}else{
					$('<li class="sub-menu"></li>').append('<a href="javascript:;" data-path="'+dom_node.path+'" data-text="'+dom_node.text+'" class="dom_node"><i class="fa fa-th"></i><span>'+dom_node.text+'</span></a>').appendTo(p_node);
				}
				
			});
		}
		
		function toUrl(o){
			var url = $(o).attr('data-url');
			$(o).parent().on('click',function(){
				$('#funcIframe').attr('src','${ctx}/' + url);
			});
		}
		
		function goHome(){
			$('#nav-title').html('主页');
			$('#funcIframe').attr('src','${ctx}/control/today/${user.id}');
		}
	</script>
	
	<script src="${ctx}/scripts/olive/js/common-scripts.js"></script><!-- BASIC COMMON JS -->
	</body>

</html>
