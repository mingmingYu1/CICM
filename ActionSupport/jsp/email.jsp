<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="${pageContext.request.contextPath}/js/bootstrap-table.js"></script>
<div class="container-fluid div-user-header div-color-blue bgColor">
	<button class="btn btn-info btnBgColor" data-toggle="modal" data-target="#emailModel" onclick="addTask()">添加任务</button>
</div>
<table id="allot-email" data-toggle="table" data-cache="false" data-pagination="true"
       data-side-pagination="server" data-url="/ActionSupport/email-config/queryTask"
       class="table table-striped table-bordered templatemo-user-table " style="margin-top:20px;">
  <thead class="bgColor">
  <tr>
    <th data-field="id" data-visible=false>主键</th>
    <th data-field="taskName" data-title-tooltip="" data-width='35%' data-align="center">邮件主题</th>
    <th data-field="comment" data-title-tooltip="" data-width='35%' data-align="center" >数据表</th>
    <th data-field="status" data-width='15%' data-align="center" data-formatter="emailStatusFormatter"
        data-events="emailStatusEvents">状态
    </th>
    <th data-field="allot" data-width='15%' data-align="center" data-formatter="emailFormatter"
        data-events="emailEvents">操作
    </th>
  </tr>
  </thead>
</table>
<!-- 邮箱分配页面 -->
<div class="modal fade" id="emailModel" tabindex="-1" role="dialog" aria-labelledby="userEditModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="userEditModalLabel">任务管理</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" role="form" id="email_form" action="/ActionSupport/email-config/update" method="post">
          <div class="form-group">
            <label for="emailDate" class="col-sm-2 col-sm-offset-1 control-label">邮件主题</label>
          	<div class="col-sm-6" style="padding-left:0px;padding-right:0px;">
				      <input class="form-control" id="taskName" name="taskName" placeholder="请输入邮箱主题"/>
          	</div>
          </div>
          <div class="form-group">
            <label for="dataTable" class="col-sm-2 col-sm-offset-1 control-label">数据表</label>
            <div class="col-sm-6" id="dataTable" style="max-height:150px;overflow:auto;border:1px solid #ccc;padding-left:0px;padding-right:0px;padding-bottom:7px;border-radius:4px;">

            </div>
          </div>
          <div class="form-group">
            <input type="hidden" id="id" name="id">
            <input type="hidden" id="status" name="status" value="0">
            <input type="hidden" id="tableComment" name="tableComment">
            <input type="hidden" id="tableName" name="tableName">
            <label for="addemail" class="col-sm-2 col-sm-offset-1 control-label">收件人</label>
            <div class="col-sm-6" id="addEmail" style="max-height:150px;overflow:auto;border:1px solid #ccc;padding-left:0px;padding-right:0px;padding-bottom:7px;border-radius:4px;">
				
            </div>
          </div>
          <div class="form-group">
            <label for="emailDate" class="col-sm-2 col-sm-offset-1 control-label">日期</label>
            <div class="col-sm-6" style="padding-left:0px;padding-right:0px;">
              <select class="form-control" name="emailDate" id="emailDate">
                <option value="0" selected>每月</option>
                <option value="1">每周</option>
                <option value="2">每天</option>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="emailDay" class="col-sm-2 col-sm-offset-1 control-label"></label>
            <div class="col-sm-6" style="padding-left:0px;padding-right:0px;">
              <select class="form-control" name="emailDay" id="emailDay">

              </select>
            </div>
          </div>
          <div class="form-group">
            <label for="emailDate" class="col-sm-2 col-sm-offset-1 control-label"></label>
            <div class="col-sm-6" style="padding-left:0px;padding-right:0px;">
              <select class="form-control" name="emailTime" id="emailTime">

              </select>
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="save_email_btn" type="button" class="btn btn-primary">提交</button>
      </div>
    </div>
  </div>
</div>
<script>
  //   分配按钮
  function emailFormatter(value, row, index) {
    return [
      '<a href="javascript:void(0)" class="_email" title="分配"><i class=" icon-pencil"></i></a>&nbsp&nbsp',
      '<a href="javascript:void(0)"  class="email_remove " title="删除"><i class="icon-trash"></i></a>',
    ].join("");
  };

  //   分配的逻辑
  window.emailEvents = {
    'click ._email': function (e, value, row, index) {
    	$.ajax({
            url: "/ActionSupport/email-config/updatePage?_time=" + new Date().getTime(),
            dataType: "json",
            data: {id: row.id, tableName : row.tableName},
            success: function (response) {
            	if(response != null){
            		var code = response.code;
            		if(code != null && code == 0){
            			var tableConfigEntity = response.tableConfigEntity;
            			$("#id").val(tableConfigEntity.id);
            			$("#status").val(tableConfigEntity.status);
            			$("#taskName").val(tableConfigEntity.taskName);
            			$("#tableName").val(tableConfigEntity.tableName);
            			$("#tableComment").val(tableConfigEntity.tableComment);
            			addData(tableConfigEntity.tableName);
		            	toAddEmail(response.emailList);
		            	if(response.emailDate != null && "" != response.emailDate){
			            	$("#emailDate").val(response.emailDate);
			            	dateCheck();
			            	var emailDayStr = response.emailDay;
			            	if(emailDayStr != null && "" != emailDayStr){
			            	  var emailDayArr = emailDayStr.split(",");
			            	  $("#emailDay").val(emailDayArr[0]);
			            	}
			            	var emailTimeStr = response.emailTime;
			            	if(emailTimeStr != null && "" != emailTimeStr){
			            	  var emailTimeArr = emailTimeStr.split(",");
			            	  $("#emailTime").val(emailTimeArr[0]);
			            	}
		            	}
				        $("#emailModel").modal("show");
            		} else {
            			  var txt = response.message;
                    window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
            		}
            	}
            }
          });
    },
    'click .email_remove': function (e, value, row, index) {     //   删除按钮
    	var txt="您确定删除吗 ?";
		var option = {
			btn: parseInt("0011",2),
			onOk: function(){
        var id = row.id;
        var params = {'id':id};
					$.ajax({ 
						url: "/ActionSupport/email-config/delete",
						type:"post",
						dataType:"json",
						cache:"false",
						data:params, 
						success: function(responseText){
              if(responseText.code == 0) {
                $('#allot-email').bootstrapTable('refresh', {url: "/ActionSupport/email-config/queryTask"});
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
  function emailStatusFormatter(value, row, index) {
    if (row.status == 1) {
      return '<a href="javascript:void(0)" class="emailStatus_run">&nbsp; 启用 &nbsp;';
    } else {
      return '<a href="javascript:void(0)" class="emailStatus_stop">&nbsp; 停止 &nbsp;';
    }
  };

  //  修改状态的方法
  window.emailStatusEvents = {
    'click .emailStatus_run': function (e, value, row, index) {
   	 var txt = "您确定停止吗 ?";
      var option = {
        btn: parseInt("0011", 2),
        onOk: function () {
          var id = row.id;
          $.ajax({
            url: "/ActionSupport/email-config/updateStatus?_time=" + new Date().getTime(),
            dataType: "json",
            data: {id: id, status: 0},
            success: function (response) {
              if (0 == response.code) {
                row.status = 0;
                $('#allot-email').bootstrapTable('updateRow', {index: index, row: row});
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
              url: "/ActionSupport/email-config/updateStatus?_time=" + new Date().getTime(),
              dataType: "json",
              data: {id: id, status: 1},
              success: function (response) {
                if (0 == response.code) {
                  row.status = 1;
                  $('#allot-email').bootstrapTable('updateRow', {index: index, row: row});
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

  //     请求邮箱
  function toAddEmail(emailList) {
    $("#addEmail").text("");
    //邮箱名
    $.ajax({
      url: "/ActionSupport/email-config/listEmail?time="+ new Date().getTime(),
      type:"post",
      dataType:"json",
      cache:"false",
      success: function(responseText){
    	if(responseText == null || responseText.length <= 0) {
          var div = "<div style='color:red;margin-top:7px;margin-left:10px;'>没有配置邮箱，请前往邮箱管理页面配置。</div>"
          $("#addEmail").append(div);
          return;
        }
        var str="<label class='checkbox-inline' ><input type='checkbox'onclick='selectAllEmail(this)' name='allEmail'/>全选</label>";
        for(var i=0;i<responseText.length;i++) {
          var emailId = responseText[i].id;
          if(emailList != null && emailList.length > 0){
        	var count = 0;
	        for(var j = 0; j < emailList.length; j++){
	          if(emailId == emailList[j].id){
	        	  str=str+"<label class='checkbox-inline'>"
	        	  			+"<input type='checkbox' name='addEmail' checked='checked' onclick='isCheckedEmail(this)' value='"
	        	  			+emailId+"'>"+responseText[i].emailAddr+"&nbsp;&nbsp;&nbsp;"+responseText[i].username
	        	  		 +"</label>";
	        	  break;
	          }
	          count++;
	        }
	        if(j == emailList.length) {
	        	str=str + "<label class='checkbox-inline'>"
				  			+"<input type='checkbox' name='addEmail' onclick='isCheckedEmail(this)' value='"
				  			+emailId+"'>"+responseText[i].emailAddr+"&nbsp;&nbsp;&nbsp;"+responseText[i].username
				  	    + "</label>"
	        }
          } else {
	        str=str+"<label class='checkbox-inline'><input type='checkbox' onclick='isCheckedEmail(this)' name='addEmail' value='"+emailId+"'>"
                +responseText[i].emailAddr+"&nbsp;&nbsp;&nbsp;"+responseText[i].username+"</label>"
          }
        }
        $("#addEmail").append(str);
        if(responseText != null && emailList != null && responseText.length == emailList.length) {
          $("input[name= 'allEmail']").prop("checked",true)
        }
      }
    });
  }
  var Day = [
    {"id":1,"dateName":"1号"},{"id":2,"dateName":"2号"},{"id":3,"dateName":"3号"},{"id":4,"dateName":"4号"},{"id":5,"dateName":"5号"},
    {"id":6,"dateName":"6号"},{"id":7,"dateName":"7号"},{"id":8,"dateName":"8号"},{"id":9,"dateName":"9号"},{"id":10,"dateName":"10号"},
    {"id":11,"dateName":"11号"},{"id":12,"dateName":"12号"},{"id":13,"dateName":"13号"},{"id":14,"dateName":"14号"},{"id":15,"dateName":"15号"},
    {"id":16,"dateName":"16号"},{"id":17,"dateName":"17号"},{"id":18,"dateName":"18号"},{"id":19,"dateName":"19号"},{"id":20,"dateName":"20号"},
    {"id":21,"dateName":"21号"},{"id":22,"dateName":"22号"},{"id":23,"dateName":"23号"},{"id":24,"dateName":"24号"},{"id":25,"dateName":"25号"},
    {"id":26,"dateName":"26号"},{"id":27,"dateName":"27号"},{"id":28,"dateName":"28号"},{"id":29,"dateName":"29号"},
    {"id":30,"dateName":"30号"},{"id":31,"dateName":"31号"}
  ]
  var Time = [
    {"id":0,"dateName":"0时"},{"id":1,"dateName":"1时"},{"id":2,"dateName":"2时"},{"id":3,"dateName":"3时"},{"id":4,"dateName":"4时"},{"id":5,"dateName":"5时"},
    {"id":6,"dateName":"6时"},{"id":7,"dateName":"7时"},{"id":8,"dateName":"8时"},{"id":9,"dateName":"9时"},{"id":10,"dateName":"10时"},
    {"id":11,"dateName":"11时"},{"id":12,"dateName":"12时"},{"id":13,"dateName":"13时"},{"id":14,"dateName":"14时"},{"id":15,"dateName":"15时"},
    {"id":16,"dateName":"16时"},{"id":17,"dateName":"17时"},{"id":18,"dateName":"18时"},{"id":19,"dateName":"19时"},{"id":20,"dateName":"20时"},
    {"id":21,"dateName":"21时"},{"id":22,"dateName":"22时"},{"id":23,"dateName":"23时"}
  ]
  var Week =  [
    {"id":1,"dateName":"周日"},{"id":2,"dateName":"周一"},{"id":3,"dateName":"周二"},{"id":4,"dateName":"周三"},{"id":5,"dateName":"周四"},{"id":6,"dateName":"周五"},
    {"id":7,"dateName":"周六"}
  ]
  //     添加时间的方法
  function addDate(date,select) {
    var str="";
    for(var i=0;i<date.length;i++) {
      str = str+"<option value="+date[i].id+">"+date[i].dateName+"</option>";
    }
    $(select).html("");
    $(select).append(str);
  };

  //  提交
  function addEmail() {
    $("#email_form").ajaxSubmit(function (responseResult) {
      if(responseResult != null){
    	var result = $.parseJSON(responseResult);
    	if(result.code == 2 && result.message != null){
		    window.wxc.xcConfirm(result.message, window.wxc.xcConfirm.typeEnum.info);
		    return;
    	}
    	if(result.message != null){
    		$("#emailModel").modal("hide");
    		$('#allot-email').bootstrapTable('refresh', {url: "/ActionSupport/email-config/queryTask"});
		    window.wxc.xcConfirm(result.message, window.wxc.xcConfirm.typeEnum.info);
    	}
      }
    });
  }
  //    前端验证的方法
  function addEmailCheck() {
    if($("#taskName").val() == "") {
      var txt="邮件主题不可以为空!";
      window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      return false;
    }
    if (!istaskNameLength($("#taskName").val(), 160)){
      var txt = "邮箱主题名字在160个字符内（中文为两个字符）!";
      window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      return false;
    }
    var dataTableId = "";
    $('input:checkbox[name="dataTable"]:checked').each(function() {
      dataTableId += ","+$(this).val();
    });
    if(dataTableId == ""){
      var txt="必须添加数据表!";
      window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      return false;
    }
    var emailId = "";
    $('input:checkbox[name="addEmail"]:checked').each(function() {
      emailId += ","+$(this).val();
    });
    if(emailId == ""){
      var txt="必须添加用户邮箱!";
      window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      return false;
    }
  }
//    判断邮箱主题检验字符长度
  function istaskNameLength(filename, maxLength) {
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
    if (byteValLen == 0) {
      returnValue = false;
    }
    return returnValue;
  }
  //   当选择月，周，日的时候
  $("#emailDate").on("change",function() {
    dateCheck()
  })
  //    判断当前是每月还是没周
  function dateCheck() {
  	var checked = $("#emailDate option:selected").val();
    if(checked == 0) {
      $("#emailDay").removeAttr("disabled");
      addDate(Day,"#emailDay");
      addDate(Time,"#emailTime");
    }else if(checked == 1) {
      $("#emailDay").removeAttr("disabled");
      addDate(Week,"#emailDay");
      addDate(Time,"#emailTime");
    }else{
      $("#emailDay").html("")
                    .attr("disabled","disabled");
      addDate(Time,"#emailTime");
    }
  }
  //  提交按钮
  $("#save_email_btn").on("click",function() {
    if(addEmailCheck() == false){
      return false;
    }
    addEmail();
  })
  //     添加数据
function addData(checkedTables) {
	$("#dataTable").text("");
	var checked = false;
	var tables = [];
	if(checkedTables != null && "" != checkedTables){
		tables = checkedTables.split(",");
		if(tables.length > 0){
		  checked = true;
		}
	}
    $.ajax({
      url: "/ActionSupport/email-config/listTable?time="+ new Date().getTime(),
      type:"post",
      dataType:"json",
      cache:"false",
      success: function(responseText){
        var str1="<label class='checkbox-inline' ><input type='checkbox' onclick='selectAll(this)' name='all'/>全选</label>";
        if(responseText != null && responseText.length > 0 ) {
          for(var i=0;i<responseText.length;i++) {
        	  var comment = responseText[i].comment;
        	  if(comment == null || "" == comment){
        		  comment = responseText[i].tableName;
        	  }
            if(checked){
              var count = 0;
              for(var j=0; j<tables.length; j++){
                if(tables[j] == responseText[i].tableName){
                    str1 = str1+"<label class='checkbox-inline'><input type='checkbox' onclick='isChecked(this)' checked='checked' "
                      +" name='dataTable' value='"+responseText[i].tableName+"'>"+comment+"</label>";
                  break;
                }
                count++;
              }
              if(count == tables.length){
                str1 = str1+"<label class='checkbox-inline'><input type='checkbox' onclick='isChecked(this)' "
                    +" name='dataTable' value='"+responseText[i].tableName+"'>"+comment+"</label>";
              }
            } else {
              str1 = str1+"<label class='checkbox-inline'><input type='checkbox' onclick='isChecked(this)' "
                  +" name='dataTable' value='"+responseText[i].tableName+"'>"+comment+"</label>";
            }
          }
        }
        $("#dataTable").append(str1);
        if(responseText != null && checkedTables != null && responseText.length == tables.length) {
          $("input[name= 'all']").prop("checked",true)
        }
      }
    });
  }
function addTask() {
  addData();
  $("#id").val("");
  $("#taskName").val("");
  $("#dataTable").text("");
  $("#addEmail").text("");
  $.ajax({
      url: "/ActionSupport/email-config/listEmail?time="+ new Date().getTime(),
      type:"post",
      dataType:"json",
      cache:"false",
      success: function(responseText){
        if(responseText.length <= 0) {
          var div = "<div style='color:red;margin-top:7px;margin-left:10px;'>没有配置邮箱，请前往邮箱管理页面配置。</div>"
          $("#addEmail").append(div);
        }
        var str1="<label class='checkbox-inline' ><input type='checkbox'onclick='selectAllEmail(this)' name='allEmail'/>全选</label>";
        if(responseText != null && responseText.length > 0 ) {
          for(var i=0;i<responseText.length;i++) {
            str1 = str1+"<label class='checkbox-inline'><input type='checkbox' onclick='isCheckedEmail(this)' name='addEmail'  value='"
            +responseText[i].id+"'>"+responseText[i].emailAddr+"&nbsp;&nbsp;&nbsp;"+responseText[i].username+"</label>"
          }
        }
        $("#addEmail").append(str1);
      }
    });
  $("#emailDate").val(0);
  dateCheck();
}
  function selectAll(select) {
    var $inoutAll = $(select)
    if($inoutAll.is(":checked")) {
      $("input[name='dataTable']").prop("checked", true);
    } else {
      $("input[name='dataTable']").prop("checked", false);
    }
  };
  
  function selectAllEmail(select) {
    var $inoutAll = $(select)
    if($inoutAll.is(":checked")) {
      $("input[name='addEmail']").prop("checked", true);
    } else {
      $("input[name='addEmail']").prop("checked", false);
    }
  };
  
  function isChecked(select) {
    if(!$(select).is(":checked")) {
      $("input[name= 'all']").prop("checked" ,false)
    }
    var checkedArr = [];
    $("input:checkbox[name='dataTable']:checked").each(function(){
      checkedArr.push($(this).val())
    })
    var $label = $("#dataTable").find("label");
    if(checkedArr.length == ($label.length-1)){
      $("input[name= 'all']").prop("checked" ,true)
    }
  }
  function isCheckedEmail(select) {
    if(!$(select).is(":checked")) {
      $("input[name='allEmail']").prop("checked" ,false)
    }
    var checkedArr = [];
    $("input:checkbox[name='addEmail']:checked").each(function(){
      checkedArr.push($(this).val())
    })
    var $label = $("#addEmail").find("label");
    if(checkedArr.length == ($label.length-1)){
      $("input[name= 'allEmail']").prop("checked" ,true)
    }
  }
  //
  $(".modal.fade").modal({show:false,keyboard:false});

  $('#allot-email').bootstrapTable().on('post-body.bs.table',function(){
    pageHeight();
  });
</script>

