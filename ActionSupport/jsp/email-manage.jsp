<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
<div class="container-fluid div-user-header div-color-blue bgColor">
	<button class="btn btn-info btnBgColor" data-toggle="modal" data-target="#emailManageModel" onclick="manageAddEmail()">添加邮箱</button>
</div>
<table id="email-manage" data-toggle="table" data-cache="false" data-pagination="true"
       data-side-pagination="server" data-url="/ActionSupport/email/query"
       class="table table-striped table-bordered templatemo-user-table " style="margin-top:20px;">
  <thead class="bgColor">
  <tr>
    <th data-field="id" data-visible=false>主键</th>
    <th data-field="username"data-width='20%' data-align="center">用户名</th>
    <th data-field="emailAddr" data-width='35%' data-align="center">邮箱名</th>
    <th data-field="status" data-width='15%' data-align="center" data-formatter="emailManageStatusFormatter"
        data-events="emailManageStatusEvents">状态
    </th>
    <th data-field="allot" data-width='15%' data-align="center" data-formatter="emailManageFormatter"
        data-events="emailManageEvents">操作
    </th>
  </tr>
  </thead>
</table>
<!-- 邮箱分配页面 -->
<div class="modal fade" id="emailManageModel" tabindex="-1" role="dialog" aria-labelledby="userEditModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="addEmailTitle">添加邮箱</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" role="form" id="emailManage_form" action="/ActionSupport/email/update" method="post">
          <div class="form-group">
            <label class="col-sm-2 col-sm-offset-2 control-label" for="username_manage">用户名</label>
            <div class="col-sm-6">
              <input class="form-control"  type="text" id="username_manage" name="username"  placeholder="请输入用户名"/>
            </div>
          </div>
          <div class="form-group">
          	<input type="hidden" id="id_manage" name="id" />
          	<input type="hidden" id="status_manage" name="status" value="0" />
            <label for="emailAddr_manage" class="col-sm-2 col-sm-offset-2 control-label">邮件名</label>
          	<div class="col-sm-6">
				      <input class="form-control" id="emailAddr_manage" name="emailAddr" placeholder="请输入邮箱"/>
          	</div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="submit_email_name" type="button" class="btn btn-primary">提交</button>
      </div>
    </div>
  </div>
</div>
<script>
  //   修改 、删除   按钮
  function emailManageFormatter(value, row, index) {
    return [
      '<a href="javascript:void(0)" class="email_modify" title="修改"><i class=" icon-pencil"></i></a>&nbsp&nbsp',
      '<a href="javascript:void(0)"  class="emailRemove " title="删除"><i class="icon-trash"></i></a>',
    ].join("");
  };

  //  修改 、删除  逻辑
  window.emailManageEvents = {
    'click .email_modify': function (e, value, row, index) {
        $("#addEmailTitle").html("修改邮箱");
        $("#id_manage").val(row.id);
        $("#username_manage").val(row.username);
        $("#status_manage").val(row.status);
        $("#emailAddr_manage").val(row.emailAddr);
        $("#emailManageModel").modal("show");
    },
    'click .emailRemove': function (e, value, row, index) {     //   删除按钮
    	var txt="您确定删除吗 ?";
		  var option = {
			btn: parseInt("0011",2),
			onOk: function(){
	        	var id = row.id;
	        	var params = {'id':id};
				$.ajax({ 
					url: "/ActionSupport/email/delete",
					type:"post",
					dataType:"json",
					cache:"false",
					data:params, 
					success: function(responseText){
						if(responseText.code == 0) {
			                $('#email-manage').bootstrapTable('refresh', {url: "/ActionSupport/email/query"});
			                window.wxc.xcConfirm(responseText.message, window.wxc.xcConfirm.typeEnum.info);
			            } else {
			            	window.wxc.xcConfirm(responseText.message, window.wxc.xcConfirm.typeEnum.info);
			            }
	            	}
	            });
			}
		  }
		  window.wxc.xcConfirm(txt, "custom", option);
    }
  };
  
  //    状态
  function emailManageStatusFormatter(value, row, index) {
    if (row.status == 1) {
      return '<a href="javascript:void(0)" class="emailStatus_run">&nbsp; 启用 &nbsp;';
    } else {
      return '<a href="javascript:void(0)" class="emailStatus_stop">&nbsp; 停止 &nbsp;';
    }
  };

  //  修改状态的方法
  window.emailManageStatusEvents = {
    'click .emailStatus_run': function (e, value, row, index) {
   	 var txt = "您确定停止吗 ?";
      var option = {
        btn: parseInt("0011", 2),
        onOk: function () {
          var id = row.id;
          $.ajax({
            url: "/ActionSupport/email/updateStatus?_time=" + new Date().getTime(),
            dataType: "json",
            data: {id: id, status: 0},
            success: function (response) {
              if (0 == response.code) {
                row.status = 0;
                $('#email-manage').bootstrapTable('updateRow', {index: index, row: row});
              }
              var txt = response.message;
              window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
            }
          });
        }
      }
      window.wxc.xcConfirm(txt, "custom", option);
    },
    'click .emailStatus_stop': function (e, value, row, index) {
      var txt = "您确定启用吗 ?";
      var option = {
        btn: parseInt("0011", 2),
        onOk: function () {
        	var id = row.id;
            $.ajax({
              url: "/ActionSupport/email/updateStatus?_time=" + new Date().getTime(),
              dataType: "json",
              data: {id: id, status: 1},
              success: function (response) {
                if (0 == response.code) {
                  row.status = 1;
                  $('#email-manage').bootstrapTable('updateRow', {index: index, row: row});
                }
                var txt = response.message;
                window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
              }
            });
        }
      }
      window.wxc.xcConfirm(txt, "custom", option);
    }
  }

  //  提交
  function addemailAddr() {
    $("#emailManage_form").ajaxSubmit(function (responseResult) {
      if(responseResult != null){
    	var result = $.parseJSON(responseResult);
    	if(result.message != null){
    		if(result.code == 2){
    			window.wxc.xcConfirm(result.message, window.wxc.xcConfirm.typeEnum.info);
    		} else {
			    $("#emailManageModel").modal("hide");
	    		$('#email-manage').bootstrapTable('refresh', {url: "/ActionSupport/email/query"});
			    window.wxc.xcConfirm(result.message, window.wxc.xcConfirm.typeEnum.info);
    		}
    	}
      }
    });
  }

  //    前端验证的方法
  function emailCheck() {
    var usernameValue = $("#username_manage").val();
    if(!istaskNameLength(usernameValue, 20)) {
      var txt = "用户名在20个字符内（中文为两个字符）!";
      window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      return false;
    }
    var emailAddr = $("#emailAddr_manage").val();
    if(emailAddr == "") {
      window.wxc.xcConfirm("邮箱名不可为空!", window.wxc.xcConfirm.typeEnum.info);
      return false;
    };
   var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/;
    if (!re.test(emailAddr)){
      var txt = "邮箱名格式不正确!";
      window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      return false;
    };
    if(emailAddr.length > 50) {
      window.wxc.xcConfirm("邮箱名不可超过50个字符！", window.wxc.xcConfirm.typeEnum.info);
      return false;
    }
  }
  //   添加邮箱按钮
  function manageAddEmail() {
    $("#addEmailTitle").html("添加邮箱");
    $("#id_manage").val('');
    $("#username_manage").val('');
    $("#status_manage").val('0');
    $("#emailAddr_manage").val('');
  }

  //  提交按钮
  $("#submit_email_name").on("click",function() {
    if(emailCheck() == false){
      return false;
    }
    addemailAddr();
  })
  function istaskNameLength(filename, maxLength) {
	if(filename == null || "" == filename){
	  return true;
	}
    var returnValue = true;
    var byteValLen = 0;
    for (var i = 0; i < filename.length; i++) {
      if (filename[i].match(/[^\x00-\xff]/ig) != null) {
        byteValLen += 2;
      } else {
        byteValLen += 1;
      }
      if (byteValLen > maxLength) {
        returnValue = false;
      }
    }
    return returnValue;
  }
  //
  $(".modal.fade").modal({show:false,keyboard:false});

  $('#email-manage').bootstrapTable().on('post-body.bs.table',function(){
    pageHeight();
  });
</script>

