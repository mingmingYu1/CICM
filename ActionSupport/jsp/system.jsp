<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib prefix="mrp" uri="http://www.baifendian.com/mrp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>系统管理</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<link href="${pageContext.request.contextPath}/favicon.ico" rel="Shortcut icon"/>
	<link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/bootstrap-table.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/xcConfirm.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
	<!--[if lt IE 9]>
      <script src="../js/html5shiv.min.js"></script>
      <script src="../js/respond.min.js"></script>
  	<![endif]-->
	<script src="${pageContext.request.contextPath}/js/jquery-1.11.3.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/overwrite-jquery.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery.formautofill.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
	<script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
	<script src="../js/xcConfirm.js"></script>
	<script src="../js/reset-pass.js"></script>
	<style type="text/css">
		html, body {
			-ms-overflow-style: scrollbar;
			}
	</style>
</head>
<body>
<div id="header" class="container-fluid" style="min-width:1000px;" ></div>
<div class="container-fluid content-div-height" style="min-width:1000px;min-height:400px;">
   	<div class="row" style="">
		<div class="col-xs-2  bgColor" style="padding-top:10px;" id="leftNav">
			<div class="row" style="padding-bottom:10px;">
				<div class="col-xs-12">
					<div class="input-group" >
						<input id="file_location" class="form-control" type="text"/>
						<span class="input-group-btn">
							<button id="file_location_btn" class="btn  btn-info btnBgColor">定位</button>
						</span>
					</div>
				</div>
			</div>
			<ul class="nav nav-pills nav-stacked wenben-nav">
			<mrp:p rId="42">
				<li class="active">
					<a href="${pageContext.request.contextPath}/jsp/dept-manage.jsp" title="部门管理"><i class=" icon-sitemap" style="padding-right:8px;"></i>部门管理</a>
				</li>
			</mrp:p>
			<mrp:p rId="43">	
		      	<li>
		      		<a href="${pageContext.request.contextPath}/jsp/role-manage.jsp" title="角色管理"><i class=" icon-briefcase" style="padding-right:8px;"></i>角色管理</a>
		      	</li>
		  </mrp:p>
		  <mrp:p rId="41">
		        <li>
		        	<a href="${pageContext.request.contextPath}/jsp/user-manage.jsp" title="用户管理"><i class=" icon-group" style="padding-right:8px;"></i>用户管理</a>
		        </li>
		  </mrp:p>
		  <mrp:p rId="44">
						<li>
							<a href="${pageContext.request.contextPath}/jsp/email.jsp" title="邮件任务配置"><i class="icon-time" style="padding-right:8px;"></i>邮件任务配置</a>
						</li>
		 </mrp:p>
		  <mrp:p rId="45">
						<li>
							<a href="${pageContext.request.contextPath}/jsp/email-manage.jsp" title="邮箱管理"><i class=" icon-envelope" style="padding-right:8px;"></i>邮箱管理</a>
						</li>
		 </mrp:p>
			</ul>
		</div>
		<div id="" class="col-xs-10" style="margin-top:10px;padding:0px 20px 20px">
			<ul class="nav nav-tabs  tab-list" >
				<!--<li class="tab-active">-->
					<!--&#45;&#45;<a  href="javascript:void(0)">部门管理<span class="glyphicon glyphicon-remove"></span></a>-->
				<!--</li>-->
			</ul>
			<div id="content" class="content " style="padding-bottom:15px;"></div>
		</div>
	</div>
</div>
<div class="footer">
	Copyright ® 2015 All rights reserved. 百分点版权所有
</div>
<script type="text/javascript">
$('#header').load("${pageContext.request.contextPath}/jsp/header.jsp?time="+new Date().getTime(),function(){
	$(".header-nav").eq(2).addClass("bg");
});
	var div=$("<div/>").load("${pageContext.request.contextPath}/jsp/dept-manage.jsp")
	$('#content').append(div)
//	$('#content').load("${pageContext.request.contextPath}/jsp/dept-manage.jsp");

$("li").on("click",function(event){
	$('.wenben-nav .active').removeClass("active");
	$(event.target.parentElement).addClass("active");
});
/**
 * 根据权限空中，动态获取第一个菜单加载。
 */
var a_array = $("#system-menu").find("li").find("a");
if(a_array!=null&&a_array.length>0){
	var first_a = a_array[0];
	$('#content').load(first_a.href);
	($(first_a.parentElement).addClass("active"));
}
    
function pageHeight(){
		$("#leftNav").height(0);
		var docHeight=$(document).height()-55-30;
		$("#leftNav").css("height",docHeight);
	}
$(window).on("resize",function(){
		pageHeight();
})

$(document).keydown(function(e){
	if(e.keyCode === 13){
		if($('.xcConfirm').length == 0){
			if ($('#deptModal').css('display') === 'block') {
				e.preventDefault();
				if($("#add_deptname").val() == ""){
					var txt="部门名称不允许为空 !";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				add_deptname()
			}
			if ($('#deptEditModal').css('display') === 'block') {
				e.preventDefault();
				if($("#editdeptname").val()==""){
					var txt="部门名称不允许为空 !";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				edit_dept()
			}
			if ($('#addroleModal').css('display') === 'block') {
				e.preventDefault();
				$("#addrole_form").valid();
				if($("#addrolename").val()==""){
					var txt="请输入角色名称!";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				//权限
				var right = "";
				var nodes = zTree.getCheckedNodes();
				for(var i=0;i<nodes.length;i++){
					var node = nodes[i];
					if(i==0){
						right=node.id;
					}else{
						right = right+","+node.id;
					}
				}
				if(right==""){
					window.wxc.xcConfirm("创建的角色赋予的权限不能为空!", window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				$("#addRoleRight").val(right);
				add_role()
			}
			if ($('#roleModal').css('display') === 'block') {
				$("#role_form").valid();
				//权限
				var right = "";
				var nodes = zTree.getCheckedNodes();
				for(var i=0;i<nodes.length;i++){
					var node = nodes[i];
					if(i==0){
						right=node.id;
					}else{
						right = right+","+node.id;
					}
				}
				if(right==""){
					var txt="修改角色赋予的权限不能为空!";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
					return false;
				}
				$("#editRoleRight").val(right);
				edit_role();
			}
			if($('#emailModel').css('display') === 'block'){    //    分配邮箱模态对话框
				e.preventDefault();
				if(addEmailCheck() == false){
					return false;
				}
				addEmail();
			}
			if($('#emailManageModel').css('display') === 'block'){    //    填写邮箱名模态对话框
				e.preventDefault();
				if(emailCheck() == false){
					return false;
				}
				addemailAddr();
			}
		}
	}
	if(e.keyCode === 32){
		e.preventDefault();
	}
});
</script>
</body>
</html>