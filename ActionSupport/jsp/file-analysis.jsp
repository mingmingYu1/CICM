<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core " %> --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script src="../js/jquery.formautofill.min.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.ztree.all-3.5.min.js"></script>
<link href="${pageContext.request.contextPath}/css/zTreeStyle.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/cmxform.css" rel="stylesheet">
<style type="text/css">

</style>

<div class="div-user-header bgColor">
  <button class="btn btn-info btnBgColor" id="add_btn">添加</button>
</div>
<div class="row div-search">
  <div class="col-xs-3">
    <select class="form-control" id="query_type">
      <option value="0">全部</option>
      <option value="1">按类别</option>
      <option value="2">按文件名</option>
      <option value="3">按格式</option>
    </select>
  </div>
  <div class="col-xs-3">
    <input type="text" class="form-control" id="condition" placeholder="请输入关键字">
  </div>
  <button id="search_btn" class="btn btn-info btnBgColor">搜索</button>
  <button id="reset_btn" class="btn btn-default">重置</button>
</div>
<table id="cimc_file_analysis" data-toggle="table" data-cache="false" data-pagination=true
       data-side-pagination="server" data-url="/ActionSupport/file-analysis/query"
       data-query-params="productQueryParams"
       class="table table-striped table-bordered templatemo-user-table ">
  <thead class="bgColor">
  <tr>
    <th data-field="id" data-visible=false>主键</th>
    <th data-field="filepath" data-visible=false>文件路径</th>
    <th data-field="categoryname" data-title-tooltip="" data-width='20%' data-align="center">类别</th>
    <th data-field="filename" data-title-tooltip="" data-width='35%' data-align="center">文件名</th>
    <th data-field="suffix" data-width='10%' data-align="center">文件格式</th>
    <th data-field="status" data-width='15%' data-align="center" data-formatter="statusFormatter"
        data-events="updateStatus">运行状态
    </th>
    <th data-field="operate" data-width='20%' data-align="center" data-formatter="operateFormatter"
        data-events="operateEvents">操作
    </th>
  </tr>
  </thead>
</table>

<!-- 添加页面 -->
<div class="modal fade" id="fileAnalysisModal" tabindex="-1" role="dialog" aria-labelledby="modalLabel-file-analysis"
     aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="modalLabel-file-analysis">添加文本</h4>
      </div>
      <div class="modal-body">

        <form class="form-horizontal" role="form" id="file_analysis_form" action="/ActionSupport/file-analysis/add"
              enctype="multipart/form-data">
          <div class="form-group">
            <div class="col-sm-6">
              <input type="hidden" class="form-control" id="id" name="id">
            </div>
          </div>

          <div class="form-group" id="file_edit" readonly="true">
            <label for="filename" class="col-sm-2 col-sm-offset-2 control-label">文件</label>

            <div class="col-sm-6">
              <input type="text" class="form-control" id="file" name="file" readonly>
            </div>
          </div>
          <div class="form-group" id="file_add">
            <label for="filename" class="col-sm-2 col-sm-offset-2 control-label">文件</label>

            <div class="col-sm-6">
              <input type="file" class="form-control inputFile" id="filename" name="filename"
                     accept="application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document, text/plain">
            </div>
          </div>
          <div class="form-group">
            <label for="category-tree" class="col-sm-2 col-sm-offset-2 control-label">类别</label>

            <div class="col-sm-6">
              <div class="ztree" id="category-tree" style="height:300px;overflow:auto"></div>
            </div>
            <input type="hidden" id="flows" name="flows" value=""/>
          </div>

        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button id="save_btn" type="button" class="btn btn-primary">提交</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">

  var setting = {
    check: {
      enable: true,
      chkboxType: {"Y": "ps", "N": "ps"}
    },
    view: {
      showIcon: true,
      showLine: true,
      showTitle: true,
      selectedMuti: true,
      expandSpeed: "fast",
      dblClickExpand: true
    },
    data: {
      simpleData: {   //简单的数据源，一般开发中都是从数据库里读取，API有介绍，这里只是本地的
        enable: true,
        idKey: "id",  //id和pid，这里不用多说了吧，树的目录级别
        pIdKey: "pid",
        rootPId: 0   //根节点
      }
    },
    callback: {
      beforeClick: beforeClick,
      onCheck: onCheck,
      onClick: function (event, treeId, treeNode) {
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        treeObj.checkNode(treeNode, !treeNode.checked, true, true);
      }
    }
  };
  function beforeClick(treeId, treeNode) {
    //alert("beforeClick");
  }
  function onCheck(e, treeId, treeNode) {
    var nodes = zTree.getCheckedNodes();
  }

  function operateFormatter(value, row, index) {
    return [
      '<a href="javascript:void(0)" class="_edit" title="编辑"><i class=" icon-pencil"></i>',
      '</a>&nbsp&nbsp',
      '<a href="javascript:void(0)" class="_remove" title="删除"><i class="icon-trash"></i>',
      '</a>&nbsp&nbsp',
      '<a href="javascript:void(0)" class="_preview" title="预览"><i class="icon-eye-open"></i>',
      '</a>'
    ].join('');
  }
  var trs; //保存当前tr内的信息；
  window.operateEvents = {
    'click ._edit': function (e, value, row, index) {
      resetFileAnalysisForm();
      $("#modalLabel-file-analysis").html("");
      $("#modalLabel-file-analysis").html("编辑文本");
      $("#file_edit").css("display", "block");
      $("#file_add").css("display", "none");
      var id = row.id;
      var file = row.filename + row.suffix;
      $("#file_analysis_form").autofill({id: id, file: file});
      createCateTree(id);
      $("#fileAnalysisModal").modal("show");
    },
    'click ._remove': function (e, value, row, index) {
      var txt = "您确定删除吗 ?";
      var option = {
        btn: parseInt("0011", 2),
        onOk: function () {
          if (row.status == 1) {
            var txt = "您删除的文件正在调度,不可删除";
            window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
            return;
          }
          var id = row.id;
          $.ajax({
            url: "/ActionSupport/file-analysis/del?_time=" + new Date().getTime(),
            dataType: "json",
            data: {id: id},
            success: function (response) {
              var txt = response.message;
              window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
              if (0 == response.code) {
                //如果当前页只有最后一条记录，删除后会显示没有结果
                //$('#cimc_file_analysis').bootstrapTable('remove', {field: 'id',values: [row.id]});
                $('#cimc_file_analysis').bootstrapTable('refresh', {url: "/ActionSupport/file-analysis/query"});
              }
            }
          });
        }
      }
      window.wxc.xcConfirm(txt, "custom", option);
    },
    'click ._preview': function (e, value, row, index) {
      if (row.filepath == null || row.filename == null || row.suffix == null) {
        var txt = "您选择的文件路径不存在或者您选择的文件不存在 !";
        window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
        return false;
      }

      $("#yuLan").modal("show");
      trs = row;
      $("#yuLan-path").html(row.filename + row.suffix);
      for (var i = 0; i < $("#yulan-container h4").length; i++) {
        $("#yulan-container h4")[i].innerHTML = "";
      }
      for (var i = 0; i < $("#yulan-container ul").length; i++) {
        $("#yulan-container ul")[i].innerHTML = "";
      }
      var suffix = row.suffix;
      $("#content_preview").html('');
      $.ajax({
        url: "/ActionSupport/file-analysis/previewContent",
        data: {id: row.id},
        dataType: "json",
        success: function (data) {
          if (data != null) {
            if (data.code != null && data.code == 0) {
              if (suffix == '.txt') {
                $("#content_preview").html(data.content);
              } else if (suffix == '.doc' || suffix == '.docx') {
                url = "../" + data.content.substr(data.content.indexOf("upload"));
                $("#content_preview").load(url);
              }
            } else {
              $("#content_preview").html(data.content);
            }
          }
        }
      });

    }
  };
  //   fillCheck
  function fileCheck() {
    //新增时上传文件，编辑时使用文件id
    var filepath = $("#filename").val();
    var fileId = $("#file").val();
    if ((fileId == null || fileId == "") && (filepath == null || filepath == "")) {
      var txt = "请选择文件 !";
      window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      return false;
    }
    //获得上传文件名
    var filepathRep = filepath.replace(new RegExp(/\\/g), "/");
    var fileName = filepathRep.substr(filepathRep.lastIndexOf("/") + 1);
    //新增时才需此校验
    if (fileId == null || fileId == "") {
      if (!isFileNameInLength(fileName, 100)) {
        var txt = "上传的文件名称必须在100个字符内（中文为两个字符）!";
        window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
        return false;
      }
      //切割出后缀文件名
      var filetype = fileName.substr(fileName.lastIndexOf(".") + 1);
      if (filetype == null || (filetype != "doc" && filetype != "docx" && filetype != "txt")) {
        var txt = "上传的文件必须为docx或者doc或者txt格式 !";
        window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
        return false;
      }

      //校验文件的大小，不能超过10M
      if (!checkFileSizeFun(filepath)) {
        var txt = "上传的文件大小不能超过10M!";
        window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
        return false;
      }
    }

    var nodes = zTree.getCheckedNodes();
    var flowsVal = [];
    if (nodes == null || nodes.length == 0) {
      var txt = "请选择文件的类别 !";
      window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      return false;
    } else {
      for (var i = 0; i < nodes.length; i++) {
        flowsVal.push(nodes[i].id);
      }
      $("#flows").val(flowsVal);
    }
  }
  //    文件上传ajax
  function fileAjax() {
    $("#file_analysis_form").ajaxSubmit({
      type: 'post', success: function (responseResult) {
        var result = $.parseJSON(responseResult);

        if (0 == result.code) {
          $("#fileAnalysisModal").modal("hide");
          $('#cimc_file_analysis').bootstrapTable('refresh', {url: "/ActionSupport/file-analysis/query"});
        }
        var txt = result.message;
        window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
      }
    });
  }
  $("#save_btn").on('click', function () {
    if (fileCheck() == false) {
      return false;
    }
    fileAjax()
  });
  //  文本分析搜索方法
  function search_file() {
    var query_type = $("#query_type").val();
    var condition = $("#condition").val();
    var params = {query_type: query_type, condition: condition};
    $.ajax({
      url: "/ActionSupport/file-analysis/query",
      dataType: "json",
      cache: "false",
      type: "POST",
      data: params,
      success: function (responseText) {
        //$('#cimc_user').bootstrapTable({'data':responseText,''});
        $('#cimc_file_analysis').bootstrapTable('load', responseText);
      }
    });
  }
  $("#search_btn").on("click", function () {
    search_file()
  });
  $("#condition").keydown(function (e) {
    if ($("#condition").val() !== "") {
      if (e.keyCode === 13) {
        e.preventDefault();
        search_file();
      }
    }
  });
  $("#reset_btn").on("click", function () {
    $("#query_type").val(0);
    $("#condition").val("");
    $('#cimc_file_analysis').bootstrapTable('refresh', {url: "/ActionSupport/file-analysis/query"});
  });

  $("#add_btn").on("click", function () {
    resetFileAnalysisForm();
    $("#modalLabel-file-analysis").html("");
    $("#modalLabel-file-analysis").html("添加文本");
    $("#file_edit").css("display", "none");
    $("#file_add").css("display", "block");
    createCateTree();
    $("#fileAnalysisModal").modal("show");
  });

  function productQueryParams(params) {
    params.query_type = $("#query_type").val();
    params.condition = $("#condition").val();
    return params;
  }

  function statusFormatter(value, row, index) {

    if (row.status == 1) {
      return '<a href="javascript:void(0)" class="status_run">&nbsp; 正在调度 &nbsp;';
    } else {
      return '<a href="javascript:void(0)" class="status_stop">&nbsp; 停止调度 &nbsp;';
    }

  }

  window.updateStatus = {
    'click .status_run': function (e, value, row, index) {
      var txt = "您确定停止调度吗 ?";
      var option = {
        btn: parseInt("0011", 2),
        onOk: function () {
          var id = row.id;
          $.ajax({
            url: "/ActionSupport/file-analysis/updateStatus?_time=" + new Date().getTime(),
            dataType: "json",
            data: {id: id, status: 0},
            success: function (response) {
              if (0 == response.code) {
                row.status = 0;
                $('#cimc_file_analysis').bootstrapTable('updateRow', {index: index, row: row});
              }
              var txt = response.message;
              window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
            }
          });
        }
      }
      window.wxc.xcConfirm(txt, "custom", option);
    },
    'click .status_stop': function (e, value, row, index) {
      var txt = "您确定开始调度吗 ?";
      var option = {
        btn: parseInt("0011", 2),
        onOk: function () {
          var id = row.id;
          $.ajax({
            url: "/ActionSupport/file-analysis/updateStatus?_time=" + new Date().getTime(),
            dataType: "json",
            data: {id: id, status: 1},
            success: function (response) {
              if (0 == response.code) {
                row.status = 1;
                $('#cimc_file_analysis').bootstrapTable('updateRow', {index: index, row: row});
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

  $("#yuLan-tiqu").on("click", function () {

    var id = trs.id;
    $.ajax({
      url: "/ActionSupport/file-analysis/preview?_time=" + new Date().getTime(),
      dataType: "json",
      type: "POST",
      data: {id: id},
      success: function (data) {
        if (data.code != null && data.code != 0) {
          var txt = data.message;
          window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
        } else {
          addYuLan(data);
        }
      }
    });
  });

  function addYuLan(data) {
    $("#yulan-list1").html("");
    $("#yulan-list2").html("");
    $("#yulan-list3").html("");
    $("#yulan-text1").html("一级类目");
    $("#yulan-text2").html("二级类目");
    $("#yulan-text3").html("标签属性");

    var one_level_cate = data.one_level_category.split(',');
    for (var i = 0; i < one_level_cate.length; i++) {
      $("#yulan-list1").append("<li class='list-group-item'>" + one_level_cate[i] + "</li>");
    }
    var two_level_cate = data.two_level_category.split(',');
    for (var i = 0; i < two_level_cate.length; i++) {
      $("#yulan-list2").append("<li class='list-group-item'>" + two_level_cate[i] + "</li>");
    }
    var lable_attr = data.label_attr;
    var count = 0;
    if (lable_attr != undefined && lable_attr != null && lable_attr.length > 0) {
      for (var i = 0; i < lable_attr.length; i++) {
        $("#yulan-list3").append("<li class='list-group-item' style='margin-bottom: 5px;'>" + lable_attr[i] + "</li>");
        count++;
      }
    }
    if (count == 0) {
      $("#yulan-list3").html("您选择的文件，没有提取出任何关键词标签 ");
    }
  }

  function createCateTree(fileId) {

    $.ajax({
      url: "/ActionSupport/category/categoryTree",
      type: "post",
      dataType: "json",
      data: {fileId: fileId},
      cache: "false",
      success: function (responseText) {
        zTree = $.fn.zTree.init($("#category-tree"), setting, responseText.treenodes);
      }
    });
  }

  function resetFileAnalysisForm() {
    //id,file,filename,flows
    $("#id").val('');
    $("#file").val('');
    $("#filename").val('');
    $("#flows").val();

  }

  //返回字符串val是否在规定字节长度max内
  function isFileNameInLength(filename, maxLength) {
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

  function checkFileSizeFun(filePath) {
    var isIE = /msie/i.test(navigator.userAgent) && !window.opera;
    if (isIE) {
      var fileSystem = new ActiveXObject("Scripting.FileSystemObject");
      var file = fileSystem.GetFile(filePath);
      // fileSize不能用var申明
      fileSize = file.Size;

    } else {
      fileSize = $("#filename").get(0).files[0].size;
    }
    var size = fileSize / 1024 / 1024;
    if (size > 10) {
      return false;
    }
    return true;
  }
  $.ajax({
  	url: '/ActionSupport/file-analysis/query',
  	dataType: 'json',
  	success: function(data) {
  		console.log(data)
  	}
  })
  $('#cimc_file_analysis').bootstrapTable().on('post-body.bs.table', function () {
    pageHeight();
  });

</script>
