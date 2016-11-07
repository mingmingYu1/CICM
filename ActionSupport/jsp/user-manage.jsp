<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
<style type="text/css">
	.user_remove{}
	.user_edit{}

	
</style>
<div class="container-fluid div-user-header div-color-blue bgColor">
	<button class="btn btn-info btnBgColor" data-toggle="modal" data-target="#userModal" onclick="toaddUser()">添加用户</button>
</div>
<div class="row div-search">
 	<div class="col-xs-3">
 		<select class="form-control" id="user_query_type">
  			<option value="0">全部</option>
  			<option value="1">按部门</option>
  			<option value="2">按角色</option>
  			<option value="3">按姓名</option>
		</select>
    </div>
	<div class="col-xs-3">
  		<input type="text" class="form-control"  id="user_condition" placeholder="请输入关键字">
	</div>
	<button id="search_user_btn" class="btn btn-info btnBgColor">搜索</button>
    <button id="reset_user_btn"class="btn btn-default">重置</button>
</div>

<table id="cimc_user" data-toggle="table" data-cache="false" data-pagination="true"
	data-pagination=true data-side-pagination="server" data-url="/ActionSupport/user/query" data-query-params="productQueryParams"
	class="table table-striped table-bordered templatemo-user-table">
   	<thead>
   		<tr>
  		<th data-field="uid" data-visible=false>主键 </th>
 			<th data-field="realname" data-width='18%' data-align="center">姓名</th>
 			<th data-field="username" data-width='18%' data-align="center">账户</th>
 			<th data-field="deptname" data-width='18%' data-align="center">所属部门</th>
 			<th data-field="rolename" data-title-tooltip=""  data-width='25%' data-align="center">所属角色</th>
 			<th data-field="status"   data-visible=false>状态</th>
 			<th data-field="operate_user" data-width='21%' data-align="center" data-formatter="operateFormatterUser" data-events="operateEventsUser">操作</th>
   		</tr>
   	</thead>
</table>    
                                                
<!-- 用户添加页面 -->
<div class="modal fade" id="userModal" tabindex="-1" role="dialog" aria-labelledby="userModalLabel" aria-hidden="true">
	<div class="modal-dialog">
      	<div class="modal-content">
         	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            	<h4 class="modal-title" id="userModalLabel">添加用户</h4>
         	</div>
         	<div class="modal-body">
         	
      			<form class="form-horizontal" role="form" id="user_form" action="/ActionSupport/user/addUser" method="post">
			   		<div class="form-group">
			      		<label for="realname" class="col-sm-2 col-sm-offset-2 control-label">姓名</label>
			      		<div class="col-sm-6">
			         		<input type="text" class="form-control" id="addrealname" maxlength=20 name="realname" placeholder="请输入姓名">
			      		</div>
			   		</div>
			   		<div class="form-group">
			      		<label for="username" class="col-sm-2 col-sm-offset-2 control-label">用户名</label>
			      		<div class="col-sm-6">
			         		<input type="text" class="form-control" id="addusername" maxlength=17 name="username" placeholder="请输入用户名">
			      		</div>
			   		</div>
			   
			   		<div class="form-group">
			      		<label for="password" class="col-sm-2 col-sm-offset-2 control-label">密码</label>
			      		<div class="col-sm-6">
			         		<input type="password" class="form-control" id="addpassword" maxlength="16" name="password" placeholder="请输入密码" value="">
			      		</div>
			   		</div>
			   
			   		<div class="form-group">
			      		<label for="dept" class="col-sm-2 col-sm-offset-2 control-label">部门</label>
			      		<div class="col-sm-6">
			         		<select class="form-control" id=adddid name="did">
			         			<option value="-1">请选择</option>
			         		</select>
			      		</div>
			   		</div>
			   
			   		<div class="form-group">
			      		<label for="role" class="col-sm-2 col-sm-offset-2 control-label">角色</label>
			      		<div class="col-sm-6" id="addrolecodition">
			      		   
			      		</div>
			      		<input type="hidden" id="adduserroleIds" name="roleIds" value=""/>
			   		</div>
				</form>
			
         	</div>
         	<div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	<button id="save_user_btn" type="button" class="btn btn-primary">提交</button>
         	</div>
      	</div>
	</div>
</div>

<!-- 用户编辑页面 -->
<div class="modal fade" id="userEditModal" tabindex="-1" role="dialog" aria-labelledby="userEditModalLabel" aria-hidden="true">
	<div class="modal-dialog">
      	<div class="modal-content">
         	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            	<h4 class="modal-title" id="userEditModalLabel">编辑用户</h4>
         	</div>
         	<div class="modal-body">
         	
      			<form class="form-horizontal" role="form" id="user_edit_form" action="/ActionSupport/user/updateUser" method="post">
			   		<input type="hidden" id="uid" name="uid" value="">
			   		<div class="form-group">
			      		<label for="realname" class="col-sm-2 col-sm-offset-2 control-label">姓名</label>
			      		<div class="col-sm-6">
			         		<input type="text" class="form-control" id="realname" maxlength=20 name="realname" placeholder="请输入姓名">
			      		</div>
			   		</div>
			   		<div class="form-group">
			      		<label for="username" class="col-sm-2 col-sm-offset-2 control-label">用户名</label>
			      		<div class="col-sm-6">
			         		<input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" readonly="true">
			      		</div>
			   		</div>
			   
			   		<div class="form-group">
			      		<label for="dept" class="col-sm-2 col-sm-offset-2 control-label">部门</label>
			      		<div class="col-sm-6">
			         		<select class="form-control" id=did name="did">
			         			<option value="-1">请选择</option>
			         		</select>
			      		</div>
			   		</div>
			   
			   		<div class="form-group">
			      		<label for="role" class="col-sm-2 col-sm-offset-2 control-label">角色</label>
			      		<div class="col-sm-6" id="rolecodition">
			         		
			      		</div>
			      		<input type="hidden" id="roleIds" name="roleIds" value=""/>
			   		</div>
					<div class="form-group">
						<label class="col-sm-2 col-sm-offset-2 control-label">状态</label>
						<div class="col-sm-6">
							<label class="checkbox-inline" style="padding-left:0">
					      		<input type="radio" name="status" id="no-activate" 
					         	value="0"> 冻结
					   		</label>
				      		<label class="checkbox-inline ">
					      		<input type="radio" name="status" id="activate" checked="checked"
					         	value="1"> 激活
					   		</label>
						</div>
						
					   	
					</div>
					
				</form>
			
         	</div>
         	<div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	<button id="save_edit_user_btn" type="button" class="btn btn-primary">提交</button>
         	</div>
      	</div>
	</div>
</div>

<!-- 密码重置页面 -->
<div class="modal fade" id="userResetPwordModal" tabindex="-1" role="dialog" aria-labelledby="userResetPwordModalLabel" aria-hidden="true">
	<div class="modal-dialog">
      	<div class="modal-content">
         	<div class="modal-header">
            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            	<h4 class="modal-title" id="userEditModalLabel">密码重置</h4>
         	</div>
         	<div class="modal-body">
         	
      			<form class="form-horizontal" role="form" id="user_resetPword_form" action="/ActionSupport/user/resetPword" method="post">
			   		<input type="hidden" id="uid" name="uid" value="">
			   		<div class="form-group">
			      		<label for="realname" class="col-sm-2 col-sm-offset-2 control-label">姓名</label>
			      		<div class="col-sm-6">
			         		<input type="text" class="form-control" id="realname" maxlength=10 name="realname" placeholder="请输入姓名" readonly="true">
			      		</div>
			   		</div>
			   		<div class="form-group">
			      		<label for="username" class="col-sm-2 col-sm-offset-2 control-label">用户名</label>
			      		<div class="col-sm-6">
			         		<input type="text" class="form-control" id="username" name="username" placeholder="请输入用户名" readonly="true">
			      		</div>
			   		</div>
			   		<div class="form-group" >
			      		<label for="password" class="col-sm-2 col-sm-offset-2 control-label">新密码</label>
			      		<div class="col-sm-6">
			         		<input type="password" class="form-control" id="resetPword1" name="password1" placeholder="请输入新密码" value="">
			      		</div>
			   		</div>
			   		<div class="form-group" >
			      		<label for="password" class="col-sm-2 col-sm-offset-2 control-label">新密码</label>
			      		<div class="col-sm-6">
			         		<input type="password" class="form-control" id="resetPword2" name="password2" placeholder="请输入新密码" value="">
			      		</div>
			   		</div>
				</form>
         	</div>
         	<div class="modal-footer">
            	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            	<button id="pword_reset_user_btn" type="button" class="btn btn-primary">提交</button>
         	</div>
      	</div>
	</div>
</div>

<script type="text/javascript">
function operateFormatterUser(value, row, index) {
	return [

	    '<a href="javascript:void(0)"  class="user_edit _edit" title="编辑"><i class="icon-pencil"></i>',
	    '</a>&nbsp&nbsp',
	    '<a href="javascript:void(0)"  class="user_remove _remove" title="删除"><i class="icon-trash"></i>',
	    '</a>&nbsp&nbsp',
	    <c:forEach items="${roles}" var="r">
			<c:if test="${r==1}">
				'<a href="javascript:void(0)" class="user_resetPword _edit" title="重置密码"><i class="icon-lock"></i>',
				'</a>',	
			</c:if>
		</c:forEach>
	    
	].join('');
}
  
window.operateEventsUser = {
	//编辑用户
	'click .user_edit': function (e, value, row, index) {
	
	var editdeptname = row.deptname;
	var editrolename = row.rolename;
	var status = row.status;
	if(status==1){
		$("#activate").attr("checked",true);
		$("#no-activate").attr("checked",false);
	}else{
		$("#no-activate").attr("checked",true);
		$("#activate").attr("checked",false);
	}
	
	jQuery("#did").empty();
	jQuery("#did").append("<option value='-1'>请选择</option>");
	//部门
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
						if(editdeptname==deptname){
						
							jQuery("#did").append("<option selected = 'selected' value='"+id+"'>"+deptname+"</option>");
						}else{
							jQuery("#did").append("<option value='"+id+"'>"+deptname+"</option>");
						}
					}
				};
				
			};
			
			if(-1==result){
			}
			return false;
    	}
    });
    
  	$("#rolecodition").text("");
  	  //角色
   	 $.ajax({ 
		url: "/ActionSupport/user/roleshow", 
		type:"post",
		dataType:"json",
		cache:"false",
		success: function(responseText){
			
			var rolenames = editrolename.split(" | ");
			var result = responseText.result;
			
			if(-2==result){
				window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
				return false;
			}
			if(1==result){
				var roleList = responseText.roleList;
				var count = roleList.length;
				var links = "";
				if(count>0){
					for(var i=0;i<count;i++){
						if(row.uid !== 1 && roleList[i].id === 1){
							continue;
						}
					/* 	if(i<=3){
							if(contain(rolenames,roleList[i].rolename))
								links=links+"<label class='checkbox-inline'><input checked='checked' type='checkbox' name='roleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
							else
								links=links+"<label class='checkbox-inline'><input type='checkbox' name='roleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
						}else if(i%3==1){
							links=links+"<br/>";
							if(contain(rolenames,roleList[i].rolename))
								links=links+"<label class='checkbox-inline'><input checked='checked' type='checkbox' name='roleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
							else
								links=links+"<label class='checkbox-inline'><input type='checkbox' name='roleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
						}else{ */
							if(contain(rolenames,roleList[i].rolename))
								links=links+"<label class='checkbox-inline'><input checked='checked' type='checkbox' name='roleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
							else
								links=links+"<label class='checkbox-inline'><input type='checkbox' name='roleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
						/* } */
					}
				};
				jQuery("#rolecodition").append(links);
				 $("#userEditModal").modal("show");
			}
			
			if(-1==result){
			}
			return false;
    	},
    	error: function() {
			$("#userEditModal").modal("show");
		}
    });
	
		$("#user_edit_form").autofill(row);
		 /* setTimeout(function () { 
		 
		    $("#userEditModal").modal("show");
		 }, 500); */
	},
	
	//删除用户
	'click .user_remove': function (e, value, row, index) {
		var txt="您确定删除吗 ?";
		var option = {
			btn: parseInt("0011",2),
			onOk: function(){
					var id = row.uid;
					var params = {'uid':id};
					$.ajax({ 
						url: "/ActionSupport/user/deluser", 
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
							if(0==responseText.num){
								var txt="管理员角色不允许删除!";
								window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
								return false;
							}
					
							if(1==result){
								var txt="删除用户成功!";
								window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
								setTimeout("finduser()",500);
							}else{
								var txt="删除出现异常!";
								window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
							}
					
							return false;
							//$('#cimc_user').bootstrapTable('load', responseText);
				
		    			}
		    		});
				}
			}
		window.wxc.xcConfirm(txt, "custom", option);
	},
	//密码重置
	'click .user_resetPword': function (e, value, row, index) {
		checkSession();
		
		var userid = row.uid;
		if(userid === 1){
			var txt="不能重置管理用户的密码!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		document.getElementById("user_resetPword_form").reset();
		$("#user_resetPword_form").autofill(row);
		$("#resetPword").val("");
		$("#userResetPwordModal").modal("show");
		
/* 		var uid = row.uid;
		var params = {uid:uid};
		$.ajax({ 
			url: "/ActionSupport/user/resetPword", 
			type:"post",
			dataType:"json",
			data:params,
			cache:"false",
			success: function(responseText){
				var result = responseText.result;
				if(-2==result){
					window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
					return false;
				}			
				if(1==result){
					//alert("密码重置成功!");
					var txt="密码重置成功!";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				};
				
				if(-1==result){
					//alert("密码重置出现异常!");
					var txt="密码重置出现异常!";
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				}
				return false;
	    	}
   		 }); */
		
	}
};

//      添加用户方法

function add_user() {
	$("#user_form").ajaxSubmit(function (responseResult) {
	
		var result = $.parseJSON(responseResult);
		if(-2==result.result){
			window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
			return false;
		}
		if(0==result.num){
			var txt="密码不能为空!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(1==result.num){
			var txt="密码不能小于6位!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(2==result.num){
			var txt="用户名和密码不能相等!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(3==result.num){
			var txt="用户名已经存在!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(4==result.num){
			var txt="用户名不能为空!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(5==result.num){
			var txt="建用户必须赋予角色!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(6==result.num){
			var txt="普通用户不允许赋予管理员权限!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(7==result.num){
			var txt="密码必须为数字和字母组合,且不能大于16位!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(8==result.num){
			var txt="用户名必须为数字和字母开头,6到17位数字、字母或者下划线!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(9==result.num){
			var txt="姓名不能为空!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		
		if(1==result.result){
			
			var txt="保存新的用户成功!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			setTimeout("finduser()",500);
			
			$("#userModal").modal("hide");
			document.getElementById("user_form").reset();
			
			return false;
		}
		
		if(-1==result.result){
			var txt="保存新的用户信息异常!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
				
	});
}

//        修改用户的方法
function edit_user() {
	$("#user_edit_form").ajaxSubmit(function (responseResult) {
	
		var result = $.parseJSON(responseResult);
		if(-2==result.result){
			window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
			return false;
		}
		
		if(1==result.num){
			var txt="管理员用户不允许修改!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(0==result.num){
			var txt="用户必须赋予角色!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(4==result.num){
			var txt="用户名不能为空!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(6==result.num){
			var txt="普通用户不允许赋予管理员权限!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(8==result.num){
			var txt="用户名必须为数字和字母开头,6到17位数字、字母或者下划线!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(9==result.num){
			var txt="姓名不能为空!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(1==result.result){
			var txt="更新用户成功!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			setTimeout("finduser()",500);
			
			$("#userEditModal").modal("hide");
			//$("#user_edit_form").reset();
			document.getElementById("user_edit_form").reset();
			
			return false;
		}
		
		if(-1==result.result){
			var txt="更新用户信息异常!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
				
	});
}
//      密码重置
function pword_reset() {
	$("#user_resetPword_form").ajaxSubmit(function (responseResult) {
		
		var result = $.parseJSON(responseResult);
		
		if(-2==result.result){
			window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
			return false;
		}
		
		if(3==result.num){
			var txt="非管理员权限,不能重置密码!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(5==result.num){
			var txt="不能重置管理用户的密码!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(4==result.num){
			var txt="两次输入密码不一致!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(0==result.num){
			var txt="密码不能为空!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(1==result.num){
			var txt="密码不能小于6位!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(2==result.num){
			var txt="用户名和密码不能相等!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(7==result.num){
			var txt="密码必须为数字和字母，且不能大于16位!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		
		if(1==result.result){
			var txt="重置密码成功!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			setTimeout("finduser()",500);
			
			$("#userResetPwordModal").modal("hide");
			document.getElementById("user_resetPword_form").reset();
			
			return false;
		}
		
		if(-1==result.result){
			var txt="重置密码信息异常!";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
	});
}
//添加用户  
$("#save_user_btn").on('click',function(){
	if(addusercheck()==false){
		return false;
	}
	add_user();
});

//修改用户
$("#save_edit_user_btn").on('click',function(){
	if(editusercheck() == false) {
		return false;
	}
	edit_user()
});

//提交重置密码
$("#pword_reset_user_btn").on('click',function(){
	if(pword_reset_check() == false){
		return false;
	}
	pword_reset()
});

//查询
$("#search_user_btn").on("click",function(){
	finduser();
});
$("#user_condition").keydown(function(e){
		if($("#user_condition").val()!==""){
			if (e.keyCode === 13) {
				e.preventDefault();
				finduser();	
			}
		}
});
//   前端检验密码
function pword_reset_check(){
	if($("#resetPword1").val()=="" 
		||$("#resetPword2").val()==""){
		var txt="重置密码不能为空!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	
	if($("#resetPword1").val().length<8
		||$("#resetPword2").val().length<8){
		var txt="密码不能少于8位!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	
	if($("#resetPword1").val()!=$("#resetPword2").val()){
		var txt="两次输入密码不同!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
}
function finduser(){
	var query_type = $("#user_query_type").val();
	var condition = $("#user_condition").val();
	var params = {query_type:query_type,condition:condition};
	$.ajax({ 
		url: "/ActionSupport/user/query", 
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
			if(-1==result){
				var txt="用户查询出现异常!";
				window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
				return false;
			}
			if(1==result){
				$('#cimc_user').bootstrapTable('getOptions').pageNumber=1;
				$('#cimc_user').bootstrapTable('load', responseText);
			}
			return false;
    	}
    });
}


$("#reset_user_btn").on("click",function(){
	$("#user_query_type").val(0);
	$("#user_condition").val("");
	finduser();
});

function productQueryParams(params){
	params.query_type = $("#user_query_type").val();
	params.condition = $("#user_condition").val();
	return params;
}

function toaddUser(){

	document.getElementById("user_form").reset();
	jQuery("#adddid").empty();
	jQuery("#adddid").append("<option value='-1'>请选择</option>");
	//部门
	$.ajax({ 
		url: "/ActionSupport/user/deptshow", 
		type:"post",
		dataType:"json",
		cache:"false",
		success: function(responseText){
			var result = responseText.result;
			if(-2==result.result){
				window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
				return false;
			}
			if(1==result){
				
				var deptList = responseText.deptList;
				if(deptList.length>0){
					for(var i=0;i<deptList.length;i++){
						var id = deptList[i].id;
						var deptname = deptList[i].deptname;
						jQuery("#adddid").append("<option value='"+id+"'>"+deptname+"</option>");
					}
				};
				
			};
	
			if(-1==result){
			}
			return false;
    	}
    });
    
  	$("#addrolecodition").text("");
  	  //角色
   	 $.ajax({ 
		url: "/ActionSupport/user/roleshow", 
		type:"post",
		dataType:"json",
		cache:"false",
		success: function(responseText){
			var result = responseText.result;
			if(-2==result.result){
				window.location.href='${pageContext.request.contextPath}/jsp/login.jsp';
				return false;
			}
			if(1==result){
				var roleList = responseText.roleList;
				var count = roleList.length;
				var links = "";
				if(count>0){
					for(var i=0;i<count;i++){
						if(roleList[i].id == 1){
							continue;
						}
						/* if(i<3){
							links=links+"<label class='checkbox-inline'><input type='checkbox' name='addroleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
						}else if(i%3==0){
							links=links+"<br/>";
							links=links+"<label class='checkbox-inline'><input type='checkbox' name='addroleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
						}else{ */
							links=links+"<label class='checkbox-inline'><input type='checkbox' name='addroleId' value='"+roleList[i].id+"'>"+roleList[i].rolename+"</label> ";
						/* } */
					}
				};
				jQuery("#addrolecodition").append(links);
				
			}
			
			if(-1==result){
			}
			return false;
    	},
    });
    
}

function contain(array,obj) {
    var i = array.length;
    while (i--) {
        if (array[i] === obj) {
            return true;
        }
    }
    return false;
}

//编辑用户校验
function editusercheck(){
	if($("#realname").val()==""){
		var txt="姓名不能为空!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	if($("#username").val()==""){
		var txt="用户名不能为空!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	if($("#did").val()==-1){
		var txt="添加用户必须选择部门!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	
	var roleId = "";
	   $('input:checkbox[name="roleId"]:checked').each(function() {  
	       roleId += ","+$(this).val();  
	   });
	 if(roleId==""){
	 	var txt="添加用户必须选角色!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	 }  
	 roleId = roleId.substring(1);
	 $("#roleIds").val(roleId);
}

function addusercheck(){
	if($("#addrealname").val()==""){
		var txt="姓名不能为空!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	if($("#addusername").val()==""){
		var txt="用户名不能为空!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	if($("#addpassword").val()==""){
		var txt="密码不能为空!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	if($("#addpassword").val().length<8){
		var txt="密码不能小于8位!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	if($("#adddid").val()==-1){
		var txt="添加用户必须选择部门!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	}
	
	var roleId = "";
	   $('input:checkbox[name="addroleId"]:checked').each(function() {  
	       roleId += ","+$(this).val();  
	   });
	 if(roleId==""){
	 	var txt="添加用户必须选角色!";
		window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		return false;
	 }  
	 roleId = roleId.substring(1);
	 $("#adduserroleIds").val(roleId);
}

$('#cimc_user').bootstrapTable().on('post-body.bs.table',function(){
	pageHeight();
});
$(document).keydown(function(e){
	if(e.keyCode === 13){
		if($('.xcConfirm').length == 0){
			if ($('#userModal').css('display') === 'block') {
				e.preventDefault();
				if(addusercheck()==false){
					return false;
				}
				add_user();
			}
			if ($('#userEditModal').css('display') === 'block') {
				e.preventDefault();
				if(editusercheck() == false) {
					return false;
				}
				edit_user()
			}
			if ($('#userResetPwordModal').css('display') === 'block') {
				e.preventDefault();
				if(pword_reset_check() == false) {
					return false;
				}
				pword_reset()
			}
		}
	}
});

$(".modal.fade").modal({show:false,keyboard:false});
</script>
