<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core " %> --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!-- <div class="container-fluid div-user-header div-color-blue bgColor" style="height:44px"></div> -->
<div class="row" style="margin-top:20px;">
  <div class="col-xs-12">
  		<form class="form-horizontal">
  			<div class="form-group" style="margin-bottom:20px;">
			  	<label for="one_level_category" class="col-xs-1  control-label" style="padding-top:7px;text-align:right;">类别</label>
			  	<div class="col-xs-3">
			    	<select class="form-control" id="one_level_category" name="one_level_category" placeholder="请选择类别"></select>
			  	</div>
			  	<div class="col-xs-3">
			    	<select type="text" class="form-control" id="two_level_category" name="parentid" placeholder="请选择类别"></select>
			  	</div>
			  	<div class="col-xs-3">
			    	<select type="text" class="form-control" id="flow" name="flow" placeholder="请选择流程"></select>
			  	</div>
			</div>
		</form>
	</div>
  <div class="col-xs-4" style="margin-bottom: 20px;padding-left: 20px;padding-right: 20px;">
  	<div style="">
  		<div style="border:1px solid #cdcdcd;border-bottom:none;border-radius:4px 4px 0 0;background:#eff4f6;color:#3e4855;font-size:15px;padding-left: 10px;height:35px;line-height:35px;">文本输出</div>
  		<div style="padding:15px 15px 10px;border:1px solid #cdcdcd;background:#fcfcfc;">
  			<textarea name="content1" id="content1" style="width:100%;height:350px;overflow:auto;padding-left:10px;padding-top:5px;border:1px solid #cdcdcd;" placeholder="请输入文本..." ></textarea>
  			<button id="btn" class="btn btn-info btnBgColor" style="width:100%;margin-top:10px;">提交</button>
  		</div>
  	</div>
  </div>
  <div class="col-xs-8" style="padding-left:0px;padding-right:20px;">
  	<div style="border:1px solid #cdcdcd;height:456px;overflow:auto;border-radius:4px 4px 0 0;">
  		<div style="border-bottom:1px solid #cdcdcd;background:#eff4f6;color:#3e4855;font-size:15px;padding-left: 10px;height:35px;line-height:35px;">分析结果</div>
  		<div>
	  		<div class="fenxi">
				<h3 id="fenxi-text1"></h3>
				<ul id="fenxi-list1" class="list-unstyle list-inline"></ul>
			</div>
			<div class="fenxi">
				<h3 id="fenxi-text2"></h3>
				<ul id="fenxi-list2" class="list-unstyle list-inline"></ul>
			</div>
			<div class="fenxi">
				<h3 id="fenxi-text3"></h3>
				<ul id="fenxi-list3" class="list-unstyle list-inline"></ul>
			</div>
  		</div>
  	</div>
  </div>
</div>

                                                

<script type="text/javascript">
	// 下拉列表项
$.ajax({ 
		url: "/ActionSupport/category/query", 
		dataType:"json",
		data:{pid:0},
		success: function(categoryArray){
			jQuery("#one_level_category").empty();
			if(categoryArray!=null&&categoryArray.length>0){
				for(var i=0;i<categoryArray.length;i++){
					var category = categoryArray[i];
					jQuery("#one_level_category").append("<option value='"+category.id+"'>"+category.category+"</option>"); 
					if(i==0){
						setTwoLevelOption('two_level_category',category.id);
					}
				}
			}
      	}
	});
	$("#one_level_category").on("change",function(){
		var pid = $("#one_level_category").val();
		setTwoLevelOption('two_level_category',pid);
	});
	
	$("#two_level_category").on("change",function(){
		var pid = $("#two_level_category").val();
		setOption('flow',pid);
	});
	
	function setTwoLevelOption(selectid, pid){
		$.ajax({ 
			url: "/ActionSupport/category/query", 
			dataType:"json",
			data:{pid:pid},
			success: function(categoryArray){
				jQuery("#"+selectid).empty();
				if(categoryArray!=null&&categoryArray.length>0){
					
					for(var i=0;i<categoryArray.length;i++){
						var category = categoryArray[i];
						jQuery("#"+selectid).append("<option value='"+category.id+"'>"+category.category+"</option>");
						if(i==0){
							setOption('flow',category.id);
						}
					}
				}
	      	}
		});
	}
	
	function setOption(selectid,pid){
		$.ajax({ 
			url: "/ActionSupport/category/query", 
			dataType:"json",
			data:{pid:pid},
			success: function(categoryArray){
				jQuery("#"+selectid).empty();
				if(categoryArray!=null&&categoryArray.length>0){
					$("#"+selectid).removeAttr("disabled");
					for(var i=0;i<categoryArray.length;i++){
						var category = categoryArray[i];
						jQuery("#"+selectid).append("<option value='"+category.id+"'>"+category.category+"</option>"); 
					}
				}else{
					$("#"+selectid).attr("disabled","disabled");
				}
	      	}
		});
	}
	//    填写分析提交按钮方法
	function btnText(){
		$("#fenxi-text1").html("");
		$("#fenxi-text2").html("");
		$("#fenxi-text3").html("");
		$("#fenxi-list1").html('');
		$("#fenxi-list2").html('');
		$("#fenxi-list3").html('');
		
		var pid=$("#one_level_category").val();
		var categoryId=$("#two_level_category").val();
		var content=$("#content1").val();
		if(content.trim()===""){
			var txt="请填写分析内容 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return;
		}
		
		var one_level_name = $("#one_level_category option:selected").text();
		var two_level_name = $("#two_level_category option:selected").text();
		var three_level_name = $("#flow option:selected").text();

		$.ajax({
			url:"/ActionSupport/content-analysis/contentAnalysis",
			type:"POST",
			dataType:"json",
			data:{
				one_level_category:one_level_name,
				two_level_category:two_level_name,
				three_level_category:three_level_name,
				content:content
			},   
			//one_level_category:"+pid+"&two_level_category:"+categoryId+"&content"+content,
			success:function(data){
				if(data.code != null && data.code == 1){
					var txt=data.message;
					if(txt==null||""==txt.trim()){
						txt = "分析出错，请稍后再试";
					}
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				} else if(data.code != null && data.code == 0){
					textAdd(data);
				}else{
					window.wxc.xcConfirm("未知的返回类型，该结果可能被被恶意篡改", window.wxc.xcConfirm.typeEnum.info);
				}
			} 
		});
	}
	// 提交按钮项 
	$("#btn").on("click",function(){
		btnText();
	});
	function textAdd(data){
		$("#fenxi-text1").html("一级类目");
		$("#fenxi-text2").html("二级类目");
		$("#fenxi-text3").html("标签属性");
		$("#fenxi-list1").html("<li class='list-group-item'>"+$("#one_level_category option:selected").text()+"</li>")
		$("#fenxi-list2").html("<li class='list-group-item'>"+$("#two_level_category option:selected").text()+"</li>")
		var lable_attr=data.label_attr;
		var count = 0;
		if(lable_attr!=undefined && lable_attr!=null && lable_attr.length > 0){
			for(var i=0;i<lable_attr.length;i++ ){
				$("#fenxi-list3").append("<li class='list-group-item' style='margin-bottom: 5px;'>"+lable_attr[i]+"</li>");
				count++;
			}
		}
		if(count == 0) {
			$("#fenxi-list3").html("您输入的内容，没有提取出任何关键词标签 ");
		}
	}
	
	pageHeight();
</script>
