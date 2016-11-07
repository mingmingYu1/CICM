function resetPass(){
	document.getElementById("update_password_form").reset();
	$("#resetpass").modal("show");
	checkSession();
}
$("#resetpass").keydown(function(e){
	if(e.keyCode === 13){
		if($('.xcConfirm').length == 0){
			if ($('#resetpass').css('display') === 'block') {
				e.preventDefault();
				resetPassAjax();
			}
		}
	}
});
function resetPassAjax(){
	$("#update_password_form").ajaxSubmit(function (responseResult) {
		var result = $.parseJSON(responseResult);
		if(-2==result.result){
			window.location.href='../jsp/login.jsp';
			return false;
		}
		if(3==result.num){
			var txt="原始密码不能为空 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(4==result.num){
			var txt="原始密码有误 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(9==result.num){
			var txt="两次输入新密码不一致 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(0==result.num){
			var txt="新密码不能为空 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(1==result.num){
			var txt="新密码不能小于8位 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(2==result.num){
			var txt="用户名和密码不能相等 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		if(5==result.num){
			var txt="用密码只能为数字和字母,且不能超过16位 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		
		if(-1==result.result){
			var txt="密码修改出现异常 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
			return false;
		}
		
		if(1==result.result){
			$("#resetpass").modal("hide");
			var txt="密码修改成功 !";
			window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
		}
		return false;
	});
}
$("#reset_pass_btn").on('click',function(){
	resetPassAjax()
});

$(".modal.fade").modal({show:false,keyboard:false});
