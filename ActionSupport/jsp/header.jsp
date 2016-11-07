<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
isELIgnored="false"%>
<%@taglib prefix="mrp" uri="http://www.baifendian.com/mrp"%>
<%
String path = request.getContextPath(); String basePath =
request.getScheme() + "://" + request.getServerName() + ":" +
request.getServerPort() + path + "/";
%>
<div class="row" style="background:#09529f;opacity: .9;height:53px;filter:alpha(opacity=90)">
  <div class="col-xs-3" style="padding-right: 0px;">
    <div class="row" style="padding-right:0px;">
      <div class="col-xs-12" style="line-height:53px;padding-right:0px;height:53px;">
        <img style="display:inline-block;width:120px;height:28px;margin-top:-3px"
             src="${pageContext.request.contextPath}/images/logo1.png" alt="中集">

        <p style="line-height:53px;height:53px;display:inline-block;font-size:18px;color:#fff;font-weight:bold;margin-bottom:0px;margin-left:10px;margin-top:-4px;">
          文本分析平台</p>
      </div>
    </div>
  </div>
  <div class="col-xs-6" style="font-size: 12px;color:white;">
    <div class="row">
      <mrp:p rId="1">
        <div class="col-xs-2 text-center col-xs-offset-2">
          <div class="media mediaContainer">
            <a class="pull-top icon-img" href="./index.jsp"> <i
                class="icon-home"></i>

              <p class="mediaP">
                <strong>首&nbsp;页</strong>
              </p>
            </a>
          </div>
        </div>
      </mrp:p>
      <mrp:p rId="2">
        <div class="col-xs-2 text-center">
          <div class="media header-nav mediaContainer">
            <a class="pull-top icon-img" href="./text-analysis.jsp">
              <i class="icon-list-alt"></i>

              <p class="mediaP">文本分析</p></a>
          </div>
        </div>
      </mrp:p>
      <mrp:p rId="3">
        <div class="col-xs-2 text-center">
          <div class="media header-nav mediaContainer">
            <a class="pull-top icon-img"
               href="./interface-information.jsp"> <i
                class="icon-tasks"></i>

              <p class="mediaP">接口说明</p></a>
          </div>
        </div>
      </mrp:p>
      <mrp:p rId="4">
        <div class="col-xs-2 text-center">
          <div class="media header-nav mediaContainer">
            <a class="pull-top icon-img" href="./system.jsp"> <i
                class="icon-cog"></i>

              <p class="mediaP">系统管理</p></a>
          </div>
        </div>
      </mrp:p>
    </div>
  </div>
  <div class="col-xs-3"
       style="padding:5px 7px;text-align:right;color:white;font-size: 13px;margin-left:-20px;">
    <p>
						<span> <i class="icon-user"></i>
								您好,&nbsp;${sessionUser.realname }&nbsp;&nbsp;<i
                  class="icon-lock"></i> <a href="#"
                                            onclick="javascript:resetPass()"
                                            style="color:#fff;font-size:13px;">修改密码</a>&nbsp;&nbsp; <i
                  class="icon-signin"></i> <a href="javascript:void(0);"
                                              onclick="logout();" style="background:#005C9C;color:#fff;">退出</a>
						</span>
    </p>

    <p style="margin-top:-2%;margin-bottom:0" id="date">
      <span>2015年10月9日 星期五</span>
    </p>
  </div>
</div>
<!-- 修改密码 -->
<div class="modal fade" id="resetpass" tabindex="-1" role="dialog"
     aria-labelledby="modalLabel" aria-hidden="true">
  <div class="modal-dialog" style="width:550px;">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="modalLabel">修改密码</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" role="form"
              id="update_password_form"
              action="/ActionSupport/user/updatePword" method="post">
          <div class="form-group">
            <label for="filename"
                   class="col-sm-2 col-sm-offset-2 control-label">原密码</label>

            <div class="col-sm-6">
              <input type="password" class="form-control" maxlength=16
                     id="old_pass" name="oldPassWord">
            </div>
          </div>
          <div class="form-group">
            <label for="pass1"
                   class="col-sm-2 col-sm-offset-2 control-label">新密码</label>

            <div class="col-sm-6">
              <input type="password" class="form-control" maxlength=16
                     id="pass1" name="newPassWord1">
            </div>
          </div>
          <div class="form-group">
            <label for="pass2"
                   class="col-sm-2 col-sm-offset-2 control-label">重复密码</label>

            <div class="col-sm-6">
              <input type="password" class="form-control" maxlength=16
                     id="pass2" name="newPassWord2">
            </div>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default"
                data-dismiss="modal">关闭
        </button>
        <button id="reset_pass_btn" type="button"
                class="btn btn-primary btnBgColor">提交
        </button>
      </div>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/js/reset-pass.js"></script>

<script type="text/javascript">
  //获取当前时间
  var dayNames = new Array("星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六");
  var Stamp = new Date();
  $("#date").empty();
  $("#date").append(
      "<span>" + Stamp.getFullYear() + "年" + (Stamp.getMonth() + 1) + "月"
      + Stamp.getDate() + "日" + " " + dayNames[Stamp.getDay()]
      + "</span>");
</script>
<script type="text/javascript">
  function logout() {
    var txt = "确定退出吗 ?";
    var option = {
      btn: parseInt("0011", 2),
      onOk: function () {
        $.ajax({
          url: "/ActionSupport/login/logout",
          type: "post",
          dataType: "json",
          cache: "false",
          success: function (responseText) {
            window.location.href = '${pageContext.request.contextPath}/jsp/login.jsp';
          },
          error: function () {
            window.location.href = '${pageContext.request.contextPath}/jsp/login.jsp';
          }
        });
      }
    }
    window.wxc.xcConfirm(txt, "custom", option);
  }
  //阻止事件的默认行为
  function stopEvent(event) {
    if (event.preventDefault) {
      event.preventDefault();
    } else {
      event.returnValue = false;
    }
  }
  //页面一加载完成根据左侧的导航第一个子孩子生成tab页第一个li
  (function addTab() {
    var text = $(".wenben-nav a").eq(0).text();
    var href = $(".wenben-nav a").eq(0).attr("href");
    $(".wenben-nav a").eq(0).parent().addClass("tab-active2");
    var li = $("<li class='tab-active '/>")
        .html("<a href='javascript:void(0)'>" + text + "<span class='glyphicon glyphicon-remove'></span></a>");
    $(".tab-list").html(li);
    $(".tab-list span").hide();
  })();
  // --左侧导航点击时的
  $(".wenben-nav>li>a")
      .each(function (i) {
        this.index = i;
      })
      .on(
      "click",
      function (event) {
        stopEvent(event)
        var href = $(this).attr("href");
        var text = $(this).text();
        var textA = $('.tab-list>li>a:contains(' + text + ')');
        $(".tab-list span").hide();
        $(".tab-active").removeClass("tab-active");
        //$(".tab-list li").eq(this.index).addClass("tab-active");
        $(textA).parent().addClass("tab-active");
        $(textA).find("span").show();
        if ($(".tab-list span").length == 1) {
          $(".tab-list span").hide();
        }
        if ($(this).parent().hasClass("tab-active2")) {
          $("#content>div").hide();
          $("#content>div").eq($(textA).parent().index()).show();
          pageHeight();
          //$("#content>div").eq($(textA).parent().index()).show();
          //.load(href + "?time="+ new Date().getTime());
          return;
        }
        //当li的数量大于或等于10时不可再增加
        if ($(".tab-list li").length >= 9) {
          return;
        }
        $("#content>div").hide();
        var div = $("<div/>").load(href + "?time=" + new Date().getTime());
        $("#content").append(div);
        var li = $("<li class='tab-active'/>")
            .html("<a href='javascript:void(0)'>" + $(this).text() + "<span class='glyphicon glyphicon-remove'></span></a>")
        $(".tab-list").append(li);
        $(this).parent().addClass("tab-active2");
      });

  //tab中a点击时，显现对应页面
  $(".tab-list").on("click", "a", function () {
    $(".tab-list a").each(function (i) {
      this.index = i
    })
    var text = $(this).text();       //当前选中的字体
    var textA = $('.wenben-nav>li>a:contains(' + text + ')') //  匹配左侧的a
    $(".tab-list li ").removeClass("tab-active ");
    $(".tab-list span").hide();
    $(this).parent().addClass("tab-active ");
    $(this).find("span").show();
    $("#content>div").hide();
    $("#content>div").eq(this.index).show();
    $(".wenben-nav>li").removeClass("active");
    textA.parent().addClass("active");
    if ($(".tab-list span").length == 1) {
      $(".tab-list span").hide();
    }
  })

  $(".tab-list").on(
      "click",
      "span",
      function (event) {
        event.stopPropagation()   //停止事件的冒泡
        var text = $(this).parent().text();  //当前选中的字体
        var textA = $('.wenben-nav>li>a:contains(' + text + ')')  //  匹配左侧的a
        $(".tab-list span").each(function (i) {
          this.index = i
        })
        if ($(".tab-list span").length == 1) {
          return;
        }
        if (this.index - 1 >= 0) {
          $(".tab-active").remove();
          $(".tab-list li").eq(this.index - 1).addClass("tab-active")
              .find("span").show();
          $("#content>div").eq(this.index).remove();
          $("#content>div").eq(this.index - 1).show();
          $(".active").removeClass("active tab-active2");
          var text = $(".tab-list li a").eq(this.index - 1).text();
          var textA = $('.wenben-nav>li>a:contains(' + text + ')');
          textA.parent().addClass("active");
        } else {
          $(".tab-active").remove();
          $(".tab-list li").eq(this.index).addClass("tab-active")
              .find("span").show();
          $("#content>div").eq(this.index).remove();
          $("#content>div").eq(this.index).show();
          $(".active").removeClass("active tab-active2");
          var text = $(".tab-list li a").eq(this.index).text();
          var textA = $('.wenben-nav>li>a:contains(' + text + ')');
          textA.parent().addClass("active");
        }
        if ($(".tab-list span").length == 1) {
          $(".tab-list span").hide();
        }
      });
  $("#file_location_btn").click(function () {
    if ($("#file_location").val() !== "") {
      dingwei();
    }
  });

  $("#file_location").keydown(function (e) {
    if ($("#file_location").val() !== "") {
      if (e.keyCode === 13) {
        e.preventDefault();
        dingwei();
      }
    }
  });
  //      定位的方法
  var dingwei = function () {
    var location_text = $("#file_location").val();
    var textA = $('.wenben-nav>li>a:contains(' + location_text + ')');
    if (textA == null || textA.length == 0) {
      return;
    }
    var liA = $('.tab-list>li>a:contains(' + $(textA[0]).text() + ')');
    $(".tab-list span").hide();
    $(".tab-list li").removeClass("tab-active");
    $(".active").removeClass("active");
    textA = textA[0];
    $(textA).parent().addClass("active tab-active2");
    if (liA != null && liA.length > 0) {
      $("#content>div").hide();
      $("#content>div").eq(liA.parent().index()).show();
      $(".tab-list li").eq(liA.parent().index())
          .addClass("tab-active").find("span").show();
      if ($(".tab-list span").length == 1) {
        $(".tab-list span").hide();
      }
      return;
    }
    $("#content>div").hide();
    var div = $("<div/>").load($(textA).get(0).href + "?time=" + new Date().getTime());
    $("#content").append(div);
    var li = $("<li class='tab-active'/>")
        .html("<a href='javascript:void(0)'>"
        + $(textA).text()//$(textA).get(0).text
        + "<span class='glyphicon glyphicon-remove'></span></a>")
    $(".tab-list").append(li);
  }
  //控制页面的高度
  function pageHeight() {
    //debugger;
    $("#leftNav").height(0);
    var docHeight = $(document).height() - 53 - 30;
    $("#leftNav").css("height", docHeight);
  }
  /*var timer;
   function startTimer() {
   clearTimeout(timer);
   timer=setTimeout(function() {
   location.href='${pageContext.request.contextPath}/jsp/login.jsp'
   },30*60*1000)}

   document.onmousemove=document.onmousedown=startTimer*/
</script>
