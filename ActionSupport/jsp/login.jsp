<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>登陆</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<%-- <link href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css" rel="stylesheet"> --%>
	<link href="${pageContext.request.contextPath}/favicon.ico" rel="Shortcut icon"/>	
	<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/xcConfirm.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">

	<!--[if lt IE 9]>
    <script src="${pageContext.request.contextPath}/js/html5shiv.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/respond.min.js"></script>
  	<![endif]-->

	<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

	<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
	<script src="${pageContext.request.contextPath}/js/xcConfirm.js"></script>

	<style type="text/css">
		.loginBox{
			width:25%;
			height:240px;
			padding:20px;
			border:1px solid #fff;
			border-radius:8px;
			box-shadow:0 0 15px #222; 
			font:14px/1.5em 'Microsoft YaHei' ;
			position: absolute;right:37%;top:30%;
			background:white;
		}		
		
		.loginBox div div input {
			width:100%
		}
		
		.loginBox div div button {
			width:100%;
			<%--background:#00CEFB;--%>
		}		
  </style>
</head>
<body>
<div class="container-fluid" style="width:100%;height:53px;background: #09529f;opacity: .9;filter:alpha(opacity=90);min-width:1000px;">
	<div class="row">
		<div class="col-xs-3" style="line-height:53px;padding-right:0px;">
			<div class="row" style="padding-right:0px;">
				<div class="col-xs-12" style="line-height:53px;padding-right:0px;height:53px;">
					<img  style="display:inline-block;width:120px;height:28px;margin-top:-3px" src="${pageContext.request.contextPath}/images/logo1.png" alt="中集">
					<p style="line-height:53px;height:53px;display:inline-block;font-size:18px;color:#fff;font-weight:bold;margin-bottom:0px;margin-left:10px;margin-top:-4px;">文本分析平台</p>
				</div>
			</div>
		</div>
	</div>
</div>
	<div class="" id="bgImg" style="position:relative;background:url('${pageContext.request.contextPath}/images/loginbg.jpg') no-repeat center;
		min-width:1000px;min-height:400px;">
	<%--<img class="img-responsive" src= alt="登录" style="width:100%;height:100%;">--%>
	<form class="form-horizontal loginBox" role="form" id="login" method="post" action="/ActionSupport/login/login">
		<div class="form-group text-center">
	 		<div class="col-xs-12">
	 			<label class="" style="color:#09529f;font-size:16px;">用户登录</label>
			</div>
		</div>
   		<div class="form-group has-feedback">
      		<div class="col-xs-12">
      			<i class="icon-user form-control-feedback formIcon"></i>
         		<input type="text" class="form-control" id="username" name= "username" maxlength="16"
            	placeholder="用户名">
      	</div>
   		</div>
   <div class="form-group has-feedback">
      <div class="col-xs-12">
      	 <span class="icon-lock	 form-control-feedback formIcon"></span>
         <input type="password" class="form-control" id="password" name = "password" maxlength="17"
            placeholder="密码">
      </div>
   </div>
   <div class="form-group">
      <div class="col-xs-12	">
         <button id="login_btn" class="btn btn-info btnBgColor" onclick="commit();return false;">登录</button>
      </div>
   </div>
	</form>
</div>
<div style="margin-top:-1px;width:100%;height:30px;text-align: center;line-height: 30px;background: #000;opacity: .6;filter:alpha(opacity=60);color: #fff;min-width:1000px;">
	Copyright ® 2015 All rights reserved. 百分点版权所有
</div>


<script type="text/javascript">
	function checkSeesionTimeOut(text){
		return "";
	}
	function commit(){
		if(valid()==false) {return false;}
		$("#login").ajaxSubmit(function (responseResult) {
				
				var result = $.parseJSON(responseResult);
				if(0==result.num){
					var txt="用户名不能为空 !";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				if(1==result.num){
					var txt="密码不能为空 !";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				if(6==result.num){
					var txt="用户名和密码不能相同 !";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				if(2==result.num){
					var txt="用户名或密码错误 !";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				if(4==result.num){
					var txt="该用户错误次数太多,已经被冻结,请联系管理员 !";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				if(3==result.num){
					var txt="该账户已经被冻结,请联系管理员 !";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				if(5==result.num){
					var txt="此用户没有任何权限,请切换用户登录!";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				if(1==result.result){//登录成功
					var menu = result.menu;
					for( var i=0; i<menu.length;i++){
						if(menu[i].id==1){
							window.location.href='${pageContext.request.contextPath}/jsp/index.jsp';
							return false;
						}
						if(menu[i].id==2){
							window.location.href='${pageContext.request.contextPath}/jsp/text-analysis.jsp';
							return false;
						}
						if(menu[i].id==3){
							window.location.href='${pageContext.request.contextPath}/jsp/interface-information.jsp';
							return false;
						} 
						if(menu[i].id==4){
							window.location.href='${pageContext.request.contextPath}/jsp/system.jsp';
							return false;
						}
					}
	//				window.location.href='${pageContext.request.contextPath}/jsp/index.jsp';
				}
			});
		//alert("commit");
		
	}
	
	function valid(){
		if($("#username").val()==""){
			var txt="用户名不能为空 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if($("#password").val()==""){
			var txt="密码不能为空 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if($("#password").val()==$("#username").val()){	
			var txt="用户名和密码不能相同 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			//$("#username").focus();
			return false;
		}
	}
	function checkpwd(obj){ 
		if(obj.value == "")return false; 
		if(obj.value.match(/[^A-Za-z0-9]/ig)){
			 var txt="用户名和密码只能为数字和字母 !";
			 window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			 return false; 
		} return true; 
	}
	//设置当前背景的高度	
var pageReset=function(){
	var height=$(window).height();
	$("#bgImg").css("height",height-52-30);
}
pageReset();
$(window).on("resize",function(){
		pageReset();
})
        	
</script>

</body>
</html>