<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="mrp" uri="http://www.baifendian.com/mrp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>接口说明</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link href="../favicon.ico" rel="Shortcut icon"/>
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<link href="../css/bootstrap-table.css" rel="stylesheet">
	<link href="../css/cmxform.css" rel="stylesheet">
	<link href="../css/font-awesome.min.css" rel="stylesheet">
	<link href="../css/xcConfirm.css" rel="stylesheet">
	<link href="../css/main.css" rel="stylesheet">
	<!--[if lt IE 9]>
      <script src="../js/html5shiv.min.js"></script>
      <script src="../js/respond.min.js"></script>
  	<![endif]-->
	<script src="../js/jquery-1.11.3.min.js"></script>
	<script src="../js/overwrite-jquery.js"></script>
	<script src="../js/jquery.form.js"></script>
	<script src="../js/bootstrap-table.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/xcConfirm.js"></script>
	
	<style type="text/css">
		html, body {
		    -ms-overflow-style: scrollbar;
		}
	    pre {outline: 1px solid #ccc; padding: 5px; margin: 5px; height:300px; }
	    .string { color: green; }
	    .number { color: darkorange; }
	    .boolean { color: blue; }
	    .null { color: magenta; }
	    .key { color: red; }
	</style>
</head>
<body>

<div id="header" class="container-fluid" style="min-width:1000px;"></div>
<div class="content-div-height" style="padding: 0 15px;margin-top:1px;min-width:1000px;min-height:400px;">
   	<div class="row">
			<%--<div class="col-xs-2 col-no-padding">--%>
				<%--<ul class="nav nav-pills nav-stacked wenben-nav" id="text-analyisi-menu">--%>
					<%--<mrp:p rId="21">--%>
					<%--<li>--%>
						<%--<!-- <a href="javascript:changePage('./file-analysis.jsp')">文本分析</a> -->--%>
						<%--<a href="./interface.jsp">接口说明</a>--%>	
					<%--</li>--%>
					<%--</mrp:p>--%>
				<%--</ul>--%>
			<%--</div>--%>
		<div class="content-div-height container-fluid" style="margin-top:1px">
			<div class="row">
				<div class="col-xs-2 bgColor" id="leftNav">
					<ul class="nav nav-pills nav-stacked wenben-nav " id="interface-menu" style="margin-top:5px;">
					</ul>
				</div>
				<div id="content" class="col-xs-10" style="padding:0 20px 10px;">
					<div class="page-header"  style="margin-top:10px;">
						<p style="border-radius:4px 4px 0 0;font-size:13px;background:#c6e8ff;padding-left:;color:#2a497a;padding:10px 10px;">
							<i class="icon-info-sign"></i>
							接口简介 :
							<span id="interface-describe-content"></span>
						</p>
					</div>
					<div class="page-header">
						<p style="font-size:15px;color:#666;font-weight:bold;">输入参数</p>
						<table id="request-params-table" data-toggle="table" data-cache="false"
							data-side-pagination="server" data-url="" data-query-params="productQueryParams"
							class="table table-striped table-bordered templatemo-user-table">
							<thead>
								<tr>
									<th data-field="name" data-width='15%' data-align="center">参数名称</th>
									<th data-field="type" data-width='15%' data-align="center">参数类型</th>
									<th data-field="desc" data-width='15%' data-align="center">描述</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="page-header" style="margin-top:10px">
						<p style="font-size:15px;color:#666;font-weight:bold;">输出参数</p>
						<table id="response-params-table" data-toggle="table" data-cache="false"
							data-side-pagination="server" data-url="" data-query-params="productQueryParams"
							class="table table-striped table-bordered templatemo-user-table">
							<thead>
								<tr>
									<th data-field="name" data-width='15%' data-align="center">参数名称</th>
									<th data-field="type" data-width='15%' data-align="center">参数类型</th>
									<th data-field="desc" data-width='15%' data-align="center">描述</th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="page-header col-xs-6" style="margin-top: 10px;padding-left:0px;">
						<p style="color:#666;font-size:15px;font-weight:bold;height:40px;line-height: 40px;padding-left:10px;background:#f2f8fd;border:1px solid #ccc;border-top:2px solid #ccc;margin-bottom:0px;border-bottom:none;border-radius:4px 4px 0 0;">请求参数示例</p>
						<pre id="resquest_item_id" style="border-radius:0;margin:0px;outline:none;background:#fff;">这是请求的示例</pre>
					</div>
					<div class="page-header col-xs-6" style="margin-top: 10px;padding-left:0px;padding-right:0px;">
						<p style="color:#666;font-size:15px;font-weight:bold;height:40px;line-height: 40px;padding-left:10px;background:#f2f8fd;border:1px solid #ccc;border-top:2px solid #ccc;margin-bottom:0px;border-bottom:none;border-radius:4px 4px 0 0;">返回结果示例</p>
						<pre id="response_item_id" style="border-radius:0;margin:0px;outline:none;background:#fff;">这是返回结果示例</pre>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="footer">
	Copyright ® 2015 All rights reserved. 百分点版权所有
</div>
<script type="text/javascript">
$('#header').load("./header.jsp?_time="+new Date().getTime(),function(){
	$(".header-nav").eq(1).addClass("bg");
	
});


	/**
	* 动态构造接口菜单
	*/
	$.ajax({
		url: "/ActionSupport/interfaceDescription/queryAll?_time="+new Date().getTime(),
		type:"post",
		dataType:"json",
		cache:"false",
		success: function(menuArray){
			if(menuArray!=null&&menuArray.length>0){
				var firstMenu = 0;
				for(var i=0;i<menuArray.length;i++){
					var menu = menuArray[i];
					if( i == 0 ){
						firstMenu = menu.id;
					}	
					$("#interface-menu").append("<li><a href='#' title="+menu.name+" onclick='javascript:changeContent(this, "+menu.id+")'><i class='icon-table' style='padding-right:8px;'></i>"+menu.name+"</a></li>");
				}
				changeContent($(".wenben-nav li a").get(0), firstMenu);
			}
		}
	});


	function changeContent(o, id){
		$.ajax({
			url: "/ActionSupport/interfaceDescription/queryById?_time="+new Date().getTime(),
			type:"post",
			dataType:"json",
			data:{id:id},
			cache:"false",
			success: function(menu){
				var requestParams = menu.requestParams;
				var responseParams = menu.responseParams;
				var requestExample = menu.requestExample;
				var responseExample = menu.responseExample;
				var desc = menu.desc;
				$('#request-params-table').bootstrapTable('load', {rows:requestParams});
				$('#response-params-table').bootstrapTable('load', {rows:responseParams});
// 				$('#resquest-items-content').html(JSON.stringify(requestExample));
//				$('#resquest-items-content').html('');
				$('#resquest_item_id').html(syntaxHighlight(requestExample));
//				$('#response-items-content').html('');
				$('#response_item_id').html(syntaxHighlight(responseExample));
				$('#interface-describe-content').html(desc);
				$(".active").removeClass("active");
				$(o).parent().addClass("active");
			}
		});
	}
	
	function syntaxHighlight(json) {
	    if (typeof json != 'string') {
	        json = JSON.stringify(json, undefined, 2);
	    }
	    json = json.replace(/&/g, '&').replace(/</g, '<').replace(/>/g, '>');
	    json = json.replace(/ /ig, "&nbsp;")
	    json = json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function(match) {
	        var cls = 'number';
	        if (/^"/.test(match)) {
	            if (/:$/.test(match)) {
	                cls = 'key';
	            } else {
	                cls = 'string';
	            }
	        } else if (/true|false/.test(match)) {
	            cls = 'boolean';
	        } else if (/null/.test(match)) {
	            cls = 'null';
	        }
	        return '<span class="' + cls + '">' + match + '</span>';
	    });
	    json = json.replace(/\n/ig, "<br>")
	    
	    return json;
	}
	
	$('#request-params-table').bootstrapTable().on('post-body.bs.table',function(){
		pageHeight();
	});
	
	$('#response-params-table').bootstrapTable().on('post-body.bs.table',function(){
		pageHeight();
	});
	$(window).on("resize",function(){
		pageHeight();
	})
	</script>
</body>
</html>