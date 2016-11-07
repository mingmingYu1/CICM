<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="mrp" uri="http://www.baifendian.com/mrp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>文本分析</title>
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
	<script src="../js/jquery.validate.min.js"></script>
	<script src="../js/xcConfirm.js"></script>
	<script src="../js/reset-pass.js"></script>
	<style type="text/css">
		html, body {
		    -ms-overflow-style: scrollbar;
		}
	</style>
</head>
<body>

<div class="container-fluid" id="header" style="min-width:1000px;"></div>
<div class="container-fluid" id="section" style="min-width:1000px;min-height:400px;">
   	<div class="row" style="height:100%">
			<div class="col-xs-2  bgColor" style="height:100%;padding-top:10px;" id="leftNav">
				<div class="row" style="padding-bottom:10px;">
                    <div class="col-xs-12">
                        <div class="input-group" >
                            <input class="form-control" id="file_location" type="text"/>
                            <span class="input-group-btn">
                                <button id="file_location_btn" class="btn  btn-info btnBgColor">定位</button>
                            </span>
                        </div>
                    </div>
				</div>
                <ul class="nav nav-pills nav-stacked wenben-nav">
					<mrp:p rId="21">
					<li class="active">
						<a href="./file-analysis.jsp" title="文件分析"><i class=" icon-th-list" style="padding-right:8px;"></i>文件分析</a>
					</li>
					</mrp:p>
					<mrp:p rId="22">
			    	<li>
			    		<a href='./content-analysis.jsp' title="填写分析"><i class=" icon-edit " style="padding-right:8px;"></i>填写分析</a>
			    	</li>
			    	</mrp:p>
				</ul>
			</div>
			<div id="right" class="col-xs-10" style="padding-bottom:18px;padding-top:10px;padding-left:20px;padding-right:20px;" id="rightContent">
                <ul class="nav nav-tabs   tab-list " >
                     <%--<li class="tab-active">--%>
                          <%--<a href="javascript:void(0)"><span class="glyphicon glyphicon-remove"></span></a>--%>
                     <%--</li>--%>
                </ul>
                <div id="content" class="content "></div>
            </div>
	</div>
</div>
<!-- 预览 Modal-->
<div class="modal fade" id="yuLan" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:1200px;">
    <div class="modal-content">
      <div class="modal-body">
        <h4>标签提取</h4>
        <div class="clearfix">
        	<div id="yuLan-path" class="pull-left" style="width:700px;height:35px;border:1px solid #ddd;margin-right:10px;padding-left:20px;line-height:35px;"></div>
        	<button id="yuLan-tiqu" class="btn btn-primary pull-left" type="button">提取</button>
        </div>
        <div id="content_preview" style="width:100%;height:500px;border:1px solid #ddd;margin-top:15px;overflow:auto;" >
        </div>
        <h4>分析结果</h4>
        <div style="width:100%;height:300px;border:1px solid #ddd;margin-top:15px;overflow: auto">
        	<div id="yulan-container" style="width:100%;">
	  				<div class="yulan">
							<h4 id="yulan-text1"><!-- 一级类目 --></h4>
							<ul id="yulan-list1" class="list-unstyle list-inline">
							</ul>
						</div>
						<div class="yulan">
							<h4 id="yulan-text2"><!-- 二级类目 --></h4>
							<ul id="yulan-list2" class="list-unstyle list-inline">
							</ul>
						</div>
						<div class="yulan">
							<h4 id="yulan-text3"><!-- 标签管理 --></h4>
							<ul id="yulan-list3" class="list-unstyle list-inline">
							</ul>
						</div>
  			</div>
        </div>
      </div>
      <div class="modal-footer">
        <button id="yuLanBtn" type="button" class="btn btn-info btnBgColor" data-dismiss="modal">确定</button>
      </div>
    </div>
  </div>
</div>
<div class="footer">
	Copyright ® 2015 All rights reserved. 百分点版权所有
</div>

<script type="text/javascript">
$('#header').load("./header.jsp?time="+new Date().getTime(),function(){
	$(".header-nav").eq(0).addClass("bg");
});
	var div=$("<div/>").load("./file-analysis.jsp")
	$('#content').append(div);
<%--$('#content').load("./file-analysis.jsp");--%>
// $('#content').load("./content-analysis.jsp");

/**
 * 根据权限空中，动态获取第一个菜单加载。
 */
var a_array = $("#text-analyisi-menu").find("li").find("a");
if(a_array!=null && a_array.length>0){
	var first_a = a_array[0];
	$('#content').load(first_a.href);
	($(first_a.parentElement).addClass("active"));
}

$("li").on("click",function(event){
	$('.wenben-nav .active').removeClass("active");
	$(event.target.parentElement).addClass("active");
});

$(window).on("resize",function(){
		pageHeight();
})
$(document).keydown(function(e){
	if(e.keyCode === 13){
		if($('.xcConfirm').length == 0){
			if ($('#fileAnalysisModal').css('display') === 'block') {
				e.preventDefault();
				if (fileCheck() == false) {
					return false;
				}
				fileAjax()
			}
		}
	}
});
</script>
</body>
</html>