var sessionTimeOutTxt = "登陆超时，请重新登陆。";
$.ajaxSetup({ 
	cache:"false",
	success: function(XMLHttpRequest, textStatus) { 
		var result = XMLHttpRequest;
        if(result!=null&&typeof(result)=="string"){
        	if(result.indexOf("<html>")!=-1&&result.indexOf("<title>登陆</title>")!=-1) { 
        		var option = {
        			closeBtn:false,
        			btn: parseInt("0001",2),
        			onOk: function(){
        				window.location.href= "/ActionSupport/jsp/login.jsp"; 
        			},
        			onClose:function(){
        				window.location.href= "/ActionSupport/jsp/login.jsp"; 
        			}
        			
	            }
        		window.wxc.xcConfirm("登陆超时，请重新登陆。", "custom", option);
                return false;  
            }
        }
    },
    error: function(jqXHR, textStatus, errorThrown){  
    	var text = jqXHR.responseText;
    	if(text!=null&&typeof(text)=="string"&&text.indexOf("<html>")!=-1&&text.indexOf("<title>登陆</title>")!=-1){
    		var option = {
    			closeBtn:false,
    			btn: parseInt("0001",2),
    			onOk: function(){
    				window.location.href= "/ActionSupport/jsp/login.jsp"; 
    			},
    			onClose:function(){
    				window.location.href= "/ActionSupport/jsp/login.jsp"; 
    			}
    			
            }
    		window.wxc.xcConfirm("登陆超时，请重新登陆。", "custom", option);
    		return;
    	}
        switch (jqXHR.status){  
        	case(502): 
        		window.wxc.xcConfirm("网络异常", window.wxc.xcConfirm.typeEnum.info);
            	break; 
            case(500):  
            	window.wxc.xcConfirm("服务器系统内部错误", window.wxc.xcConfirm.typeEnum.info);
                break;  
            case(401):  
            	window.wxc.xcConfirm("未登录", window.wxc.xcConfirm.typeEnum.info);
                break;  
            case(403):  
            	window.wxc.xcConfirm("无权限执行此操作", window.wxc.xcConfirm.typeEnum.info);
                break;  
            case(408):  
            	window.wxc.xcConfirm("请求超时", window.wxc.xcConfirm.typeEnum.info);
                break;  
            default:
            	if(0==jqXHR.status){
            		window.wxc.xcConfirm("请求未成功发送", window.wxc.xcConfirm.typeEnum.info);
            	}else{
            		window.wxc.xcConfirm("未知错误："+jqXHR.status, window.wxc.xcConfirm.typeEnum.info);
            	}
        } 
    },
});


function checkSeesionTimeOut(text){
	if(text!=null&&typeof(text)=="string"&&text.indexOf("<html>")!=-1&&text.indexOf("<title>登陆</title>")){
		var option = {
			closeBtn:false,
			btn: parseInt("0001",2),
			onOk: function(){
				window.location.href= "/ActionSupport/jsp/login.jsp"; 
			},
			onClose:function(){
				window.location.href= "/ActionSupport/jsp/login.jsp"; 
			}
			
        }
		window.wxc.xcConfirm("登陆超时，请重新登陆。", "custom", option);
		return "cimc-break";
	}
}

function checkSession(){
	$.ajax({ 
		url: "/ActionSupport/login/checkSession?_time"+new Date().getTime(), 
		type:"post",
		dataType:"json",
		cache:"false",
		success: function(responseText){
			if(responseText.code==-1){
				var option = {
					closeBtn:false,
					btn: parseInt("0001",2),
					onOk: function(){
						window.location.href= "/ActionSupport/jsp/login.jsp"; 
					},
					onClose:function(){
						window.location.href= "/ActionSupport/jsp/login.jsp"; 
					}
					
		        }
				window.wxc.xcConfirm("登陆超时，请重新登陆。", "custom", option);
				return false;
			}
		}
	});
}