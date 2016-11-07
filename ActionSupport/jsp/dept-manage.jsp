<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>	
<style type="text/css">
	._remove{}
	._edit{}
</style>

<div class="container-fluid div-user-header div-color-blue bgColor">
	<button class="btn btn-info btnBgColor" data-toggle="modal" data-target="#deptModal" onclick="javascript:toaddDept();">添加部门</button>
</div>
<div class="row div-search">
	<div class="col-xs-3" style="display: none;">
		<select class="form-control" id="dept_query_type">
		   	<!-- <option value="0">全部</option> -->
		   	<option value="1">按部门名称</option>
		</select>
	</div>
	<div class="col-xs-3">
		<input type="text" class="form-control"  id="dept_condition" placeholder="请输入关键字">
	</div>		
	<button id="search_dept_btn" class="btn btn-info btnBgColor">搜索</button>
    <button id="reset_dept_btn"class="btn btn-default">重置</button>
</div>
<table id="cimc_dept" data-toggle="table" data-cache="false" data-pagination="true"
	data-side-pagination="server" data-url="/ActionSupport/dept/query"
	class="table table-striped table-bordered">
    <thead>
       	<tr>
      		<th data-field="id" data-visible=false>主键 </th>
        	<th data-field="rolename" data-width='35%' data-align="center">部门名称</th>
        	<th data-field="deptPName" data-width='35%' data-align="center">上级部门</th>
        	<th data-field="operate_dept" data-width='30%' data-align="center" data-formatter="operateFormatterDept" data-events="operateEventsDept">操作</th>
       	</tr>
    </thead>
</table>                                                  

<!-- 部门添加页面 -->
<div class="modal fade" id="deptModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
	<div class="modal-dialog">
      	<div class="modal-content">
         	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            	<h4 class="modal-title" id="modalLabel">添加部门</h4>
         	</div>
         	<div class="modal-body">
         	
      			<form class="form-horizontal" role="form" id="dept_form" action="/ActionSupport/dept/adddept" method="post">
			   		<div class="form-group">
			      		<div class="col-sm-6">
			         		<!-- <input type="hidden" class="form-control" id="add_dept_id" name="id"> -->
			      		</div>
			   		</div>
			   		<div class="form-group">
			      		<label for="deptname" class="col-sm-2 col-sm-offset-2 control-label">部门名称</label>
			      		<div class="col-sm-6">
			         		<input type="text" class="form-control" id="add_deptname" maxlength=20 name="deptname" placeholder="部门名称" value="">
			      			<input type="text" class="form-control" style="display: none;"/>
			      		</div>
			   		</div>
			   		
			   		<div class="form-group">
			      		<label for="deptname" class="col-sm-2 col-sm-offset-2 control-label">上级部门</label>
			      		<div class="col-sm-6">
			         		<!-- <input type="text" class="form-control" id="pid" name="pid" placeholder="部门名称"> -->
			         		<select class="form-control" id=add_dept_pid name="pid" >
			         			<option value="-1">请选择</option>
			         		</select>
			      		</div>
			   		</div>
				</form>
			
         	</div>
         	<div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	<button id="save_dept_btn" type="button" class="btn btn-primary">提交</button>
         	</div>
      	</div>
	</div>
</div>

<!-- 部门编辑页面 -->
<div class="modal fade" id="deptEditModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
	<div class="modal-dialog">
      	<div class="modal-content">
         	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            	<h4 class="modal-title" id="modalLabel">编辑部门</h4>
         	</div>
         	<div class="modal-body">
         	
      			<form class="form-horizontal" role="form" id="edit_dept_form" action="/ActionSupport/dept/updateDept" method="post">
			   		<div class="form-group">
			      		<div class="col-sm-6">
			         		<input type="hidden" class="form-control" id="editid" name="id">
			      		</div>
			   		</div>
			   		<div class="form-group">
			      		<label for="deptname" class="col-sm-2 col-sm-offset-2 control-label">部门名称</label>
			      		<div class="col-sm-6">
			         		<input type="text" class="form-control" id="editdeptname" maxlength=20 name="deptname" placeholder="部门名称">
			      			<input type="text" class="form-control" style="display: none;"/>
			      		</div>
			   		</div>
			   		
			   		<div class="form-group">
			      		<label for="deptname" class="col-sm-2 col-sm-offset-2 control-label">上级部门</label>
			      		<div class="col-sm-6">
			         		<!-- <input type="text" class="form-control" id="pid" name="pid" placeholder="部门名称"> -->
			         		<select class="form-control" id=editpid name="pid" >
			         			<option value="-1">请选择</option>
			         		</select>
			      		</div>
			   		</div>
				</form>
			
         	</div>
         	<div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	<button id="edit_dept_btn" type="button" class="btn btn-primary">提交</button>
         	</div>
      	</div>
	</div>
</div>
<script type="text/javascript">
function operateFormatterDept(value, row, index) {
	return [
	    '<a href="javascript:void(0)"  class="_edit" title="编辑"><i class="icon-pencil"></i>',
	    '</a>&nbsp&nbsp',
	    '<a href="javascript:void(0)" class="_remove" title="删除"><i class="icon-trash"></i>',
	    '</a>'
	].join('');
}
  
window.operateEventsDept = {
	//编辑部门
	'click ._edit': function (e, value, row, index) {
		jQuery("#editpid").empty();
		jQuery("#editdeptname").val(row.rolename);
		
		var id = row.id;
		var deptPName = row.deptPName;
		var params = {"id":id};
		
		jQuery("#editid").val(id);
		
		$.ajax({ 
		url: "/ActionSupport/user/deptshow", 
		type:"post",
		dataType:"json",
		cache:"false",
		data:params, 
		success: function(responseText){
		
			var result = responseText.result;
			
			if(-2==result){
				window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
				return false;
			}
			
			if(1==result){
				jQuery("#editpid").append("<option value='-1'>请选择</option>");
				var deptList = responseText.deptList;
				
				if(deptList.length>0){
					for(var i=0;i<deptList.length;i++){
						if(deptPName==deptList[i].deptname){
							jQuery("#editpid").append("<option  selected = 'selected' value='"+deptList[i].id+"'>"+deptList[i].deptname+"</option>");
						}else{
							jQuery("#editpid").append("<option value='"+deptList[i].id+"'>"+deptList[i].deptname+"</option>");
						}
					}
				};
				
			};
			
			if(-1==result){
				jQuery("#editpid").append("<option value='-1'>请选择</option>");
			}
			return false;
    	}
    });
    	
	    $("#deptEditModal").modal("show");
	    
	    
	},
	
	//删除部门
	'click ._remove': function (e, value, row, index) {
		var txt="您确定删除部门 '"+row.rolename+"' 吗?";
		var option = {
			btn: parseInt("0011",2),
			onOk: function(){
					var id = row.id;
					var params = {'id':id};
					$.ajax({ 
						url: "/ActionSupport/dept/deldept", 
						type:"post",
						dataType:"json",
						cache:"false",
						data:params, 
						success: function(responseText){				
							var num = responseText.num;
							var result = responseText.result;
					
							if(-2==result){
								window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
								return false;
							}
					
							if(3==num){
								var txt="该部门为公司根部门,不能删除 !";
								window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
								return false;
							}
							if(0==num){
								var txt="该部门下有员工,不能删除 !";
								window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
								return false;
							}
							if(1==num){
								var txt="该部门下有子部门,请先解除绑定关系 !";
								window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
								return false;
							}
							if(1==result){
								var txt="删除部门成功 !";
								window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
								setTimeout("finddept()",500);
							}else{
								var txt="删除出现异常 !";
								window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
							}
					
							return false;
					//$('#cimc_user').bootstrapTable('load', responseText);
				
		    			}
		   			 });
				}
			}
		window.wxc.xcConfirm(txt, "custom", option);
	}
};
//   编辑部门方法
function edit_dept() {
	$("#edit_dept_form").ajaxSubmit(function (responseResult) {
		var result = $.parseJSON(responseResult);
		
		if(-2==result.result){
			window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
			return false;
		}
		
		if(2==result.num){
			var txt="部门名称不允许为空 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(7==result.num){
			var txt="部门名称不允许超过20位 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(4==result.num){
			var txt="上级部门称不允许为空 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(1==result.num){
			var txt="该部门不允许修改 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(0==result.num){
			var txt="部门名称已经存在 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(3==result.num){
			var txt="不能拿本部门当上级部门 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(-1==result.result){
			var txt="编辑部门出现异常 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(1==result.result){
			
			$("#deptEditModal").modal("hide");
			var txt="编辑部门成功 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			setTimeout("finddept()",500);
		}
		return false;
	});
}
//   添加部门的方法
function add_deptname(){
	$("#dept_form").ajaxSubmit(function (responseResult) {
		var result = $.parseJSON(responseResult);
		
		if(-2==result.result){
			window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
			return false;
		}
		
		if(1==result.num){
			var txt="部门名称不允许为空 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(3==result.num){
			var txt="部门名称不允许超过20位 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(2==result.num){
			var txt="上级部门不允许为空 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(0==result.num){
			var txt="部门名称已经存在 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(-1==result.result){
			var txt="添加部门出现异常 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(1==result.result){
			$("#deptModal").modal("hide");
			var txt="添加部门成功 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			setTimeout("finddept()",500);
		}
		return false;
	});
}
//编辑部门  
$("#edit_dept_btn").on('click',function(){
	if($("#editdeptname").val()==""){
		var txt="部门名称不允许为空 !";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	edit_dept()
});

//添加部门  
$("#save_dept_btn").on('click',function(){
	if($("#add_deptname").val() == ""){
		var txt="部门名称不允许为空 !";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	add_deptname()
});
//展示
$("#search_dept_btn").on("click",function(){
	finddept();
});
$("#dept_condition").keydown(function(e){
		if($("#dept_condition").val()!==""){
			if (e.keyCode === 13) {
				e.preventDefault();
				finddept();	
			}
		}
});
function finddept(){
	
	var query_type = $("#dept_query_type").val();
	var condition = $("#dept_condition").val();
	var params = {query_type:query_type,condition:condition};
	$.ajax({ 
		url: "/ActionSupport/dept/query", 
		type:"post",
		dataType:"json",
		cache:"false",
		data:params, 
		success: function(responseText){
		
			var result = responseText.result;
			if(-2==result){
				window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
				return false;
			}			
			if(1==result){
				$('#cimc_dept').bootstrapTable('getOptions').pageNumber=1;
				$('#cimc_dept').bootstrapTable('load', responseText);
			};
			
			if(-1==result){
				var txt="查询部门出现异常 !";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return false;	
			}
			
			return false;
    	}
    });
}


$("#reset_dept_btn").on("click",function(){
	$("#dept_condition").val("");
	finddept();
});

function toaddDept(){
	
	$("#add_deptname").val("");
	$("#add_deptname").attr("placeholder","部门名称");
	jQuery("#add_dept_pid").empty();
	jQuery("#add_dept_pid").append("<option value='-1'>请选择</option>");
	$.ajax({ 
		url: "/ActionSupport/user/deptshow", 
		type:"post",
		dataType:"json",
		cache:"false",
		success: function(responseText){
		
			var result = responseText.result;
			if(-2==result){
				window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
				return false;
			}			
			
			if(1==result){
				
				var deptList = responseText.deptList;
				
				if(deptList.length>0){
					for(var i=0;i<deptList.length;i++){
						var id = deptList[i].id;
						var deptname = deptList[i].deptname;
						jQuery("#add_dept_pid").append("<option value='"+id+"'>"+deptname+"</option>");
					}
				};
				
			};
			
			if(-1==result){
				jQuery("#add_dept_pid").empty();
				jQuery("#add_dept_pid").append("<option value='-1'>请选择</option>");
			}
			return false;
    	}
    });
}

$('#cimc_dept').bootstrapTable().on('post-body.bs.table',function(){
	pageHeight();
});

$(".modal.fade").modal({show:false,keyboard:false});

</script>