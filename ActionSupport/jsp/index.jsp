<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="mrp" uri="http://www.baifendian.com/mrp" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>首页</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
	<link href="${pageContext.request.contextPath}/favicon.ico" rel="Shortcut icon"/>
	<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-table.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/xcConfirm.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
		
	<!--[if lt IE 9]>
      <script src="../js/html5shiv.min.js"></script>
      <script src="../js/respond.min.js"></script>
  	<![endif]-->
	<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/overwrite-jquery.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/xcConfirm.js"></script>
	
</head>
<body>
	<div class="container-fluid"
		style="background: #09529f;opacity: .9;filter:alpha(opacity=90);height:53px;min-width:1000px;">
		<div class="row">
			<div class="col-xs-3" style="padding-right:0px;">
				<div class="row" style="padding-right:0px;">
					 <div class="col-xs-12" style="line-height:53px;padding-right:0px;height:53px;">
							<img  style="display:inline-block;width:120px;height:28px;margin-top:-3px" src="${pageContext.request.contextPath}/images/logo1.png" alt="中集">
							<p style="line-height:53px;height:53px;display:inline-block;font-size:18px;color:#fff;font-weight:bold;margin-bottom:0px;margin-left:10px;margin-top:-4px;">文本分析平台</p>
					 </div>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="row">
					<mrp:p rId="1">
						<div class="col-xs-2 text-center col-xs-offset-2">
							<div class="media bg mediaContainer">
								<a class="pull-top icon-img" href="./index.jsp"> <i
									class="icon-home"></i>
									<p class="mediaP">
										<strong>首&nbsp;页</strong>
									</p> </a>
							</div>
						</div>
					</mrp:p>
					<mrp:p rId="2">
						<div class="col-xs-2 text-center">
							<div class="media header-nav mediaContainer">
								<a class=" icon-img" href="./text-analysis.jsp"> <i
									class="icon-list-alt"></i>
									<p class="mediaP">文本分析</p> </a>
							</div>
						</div>
					</mrp:p>
					<mrp:p rId="3">
						<div class="col-xs-2 text-center">
							<div class="media header-nav mediaContainer">
								<a class="pull-top icon-img" href="./interface-information.jsp">
									<i class="icon-tasks"></i>
									<p class="mediaP">接口说明</p> </a>
							</div>
						</div>
					</mrp:p>
					<mrp:p rId="4">
						<div class="col-xs-2 text-center">
							<div class="media header-nav mediaContainer">
								<a class="pull-top icon-img" href="./system.jsp"> <i
									class="icon-cog"></i>
									<p class="mediaP">系统管理</p> </a>
							</div>
						</div>
					</mrp:p>
				</div>
			</div>
			<div class="col-xs-3"
				style="margin-left:-20px;padding:5px 0px;text-align:right;color:white;font-size: 13px;margin-left:-2%;">
				<p>
					<span> <i class="icon-user"></i>
						您好,&nbsp;${sessionUser.realname }&nbsp;&nbsp;<i class="icon-lock"></i>
						<a href="#" onclick="javascript:resetPass()"
						style="color:#fff;font-size:13px;">修改密码</a>&nbsp;&nbsp; <i
						class="icon-signin"></i> <a href="javascript:void(0);"
						onclick="logout();" style="background:#005C9C;color:#fff;">退出</a>
					</span>
				</p>
				<p style="margin-top:-2%;" id="date">
					<span>2015年10月9日 星期五</span>
				</p>
			</div>
		</div>
	</div>
	<!-- 背景图 -->
<div class="container-fluid" id="bgImg"  style="background:url('${pageContext.request.contextPath}/images/welcomebg.jpg' ) no-repeat center;min-width:1000px;min-height:400px;">
	
</div>

<div class="footerIndex">
	Copyright ® 2015 All rights reserved
</div>

<!-- 修改密码 -->
<div class="modal fade" id="resetpass" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
	<div class="modal-dialog">
      	<div class="modal-content">
         	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            	<h4 class="modal-title" id="modalLabel">修改密码</h4>
         	</div>
         	<div class="modal-body">
         	
      			<form class="form-horizontal" role="form" id="update_password_form" action="/ActionSupport/user/updatePword" method="post">
			   		
			   		<div class="form-group" >
			      		<label for="filename" class="col-sm-2 col-sm-offset-2 control-label">原密码</label>
			      		<div class="col-sm-6">
			         		<input type="password" class="form-control" maxlength=16 id="old_pass" name="oldPassWord" >
			      		</div>
			   		</div>
			   		<div class="form-group">
			      		<label for="pass1" class="col-sm-2 col-sm-offset-2 control-label">新密码</label>
			      		<div class="col-sm-6">
			      			<input type="password" class="form-control" maxlength=16 id="pass1" name="newPassWord1" >
			      		</div>
			   		</div>
			   		<div class="form-group">
			   			<label for="pass2" class="col-sm-2 col-sm-offset-2 control-label">重复密码</label>
			   			<div class="col-sm-6">
			      			<input type="password" class="form-control" maxlength=16 id="pass2" name="newPassWord2" >
			      		</div>	
			   		</div>
				</form>
         	</div>
         	<div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	<button id="reset_pass_btn" type="button" class="btn btn-primary btnBgColor">提交</button>
         	</div>
      	</div>
	</div>
</div>
	
<script type="text/javascript">
	//获取当前时间
    var dayNames = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");  
	var Stamp = new Date();
	$("#date").empty();  
	$("#date").append("<span>" + Stamp.getFullYear() + "年"+(Stamp.getMonth() + 1) +"月"+Stamp.getDate()+ "日"+ " " + dayNames[Stamp.getDay()] +"</span>"); 
</script>
<script src="${pageContext.request.contextPath}/js/reset-pass.js"></script>
<script type="text/javascript">
function logout(){
	var txt="确定退出吗 ?";
		var option = {
			btn: parseInt("0011",2),
			onOk: function(){
					$.ajax({ 
						url: "/ActionSupport/login/logout", 
						type:"post",
						dataType:"json",
						cache:"false",
						success: function(responseText){
							window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
						},
						error: function() {
							window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
    	   				}
    	   			});
				}
			}
	window.wxc.xcConfirm(txt, "custom", option);
}
$(".header-nav").on("click",function(){
	$(".header-nav").removeClass("bg");
	$(this).addClass("bg");
});
//设置当前背景的高度	
var pageReset=function(){
	var height=$(window).height();
	$("#bgImg").css("height",height-53-30);
}
pageReset();

$(window).on("resize",function(){
		pageReset();
})
/*var timer;
function startTimer() {
	clearTimeout(timer);
	timer=setTimeout(function() {
			location.href='${pageContext.request.contextPath}/jsp/login.jsp';
		},30*60*1000)}
document.onmousemove=document.onmousedown=startTimer*/
</script>
</body>
</html>