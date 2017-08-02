<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta name='apple-mobile-web-app-capable' content='yes' />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<title>登录</title>
<link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
<style type="text/css">
	*{overflow:hidden;box-sizing:border-box;margin:0;padding:0;}
	html,body{width:100%;height:100%;}
	body{font-size:0.3rem;background:#f5f4f9;}
	.fl{float:left;}
	#phone{width:100%;height:1rem;border-bottom:1px solid #e8f5fc;background:#fff;}
	.phone-icon,.yanzgengma-icon{width:1.32rem;height:100%;}
	.phone-icon>i,.yanzgengma-icon>i{margin:0 auto;display:block;width:0.6rem;height:0.6rem;background:url('${backStatic}/images/icon_login_phone.png') no-repeat center;background-size:cover;margin-top:0.2rem;}
	.phone-content{width:6rem;height:100%;}
	.phone-content>input,.yanzgengma-content>input{width:100%;height:0.6rem;margin-top:0.2rem;border:0;padding-left:6px;font-size:0.4rem;}
	
	#yanzgengma{width:100%;height:1rem;background:#fff;}
	.yanzgengma-icon>i{background:url('${backStatic}/images/icon_login_yanzheng.png') no-repeat center;background-size:cover;margin-top:0.2rem;}
	.yanzgengma-content{width:4rem;height:100%;}
	#getqrcode{width:2rem;height:1rem;}
	#getqrcode>a{display:block;width:100%;height:70%;background:#1f97ff;text-align:center;line-height:0.7rem;margin-top:0.15rem;border-radius:4px;color:#fff;}
	#quedingyuyue{width:90%;height:1rem;margin:0.8rem auto;}
	#quedingyuyue>a{display:block;width:100%;height:100%;background:#1f97ff;text-align:center;line-height:1rem;color:#fff;border-radius:6px;}
	.gray{display:block;background:#ccc;color:#fff;width:100%;height:70%;border-radius:6px;text-align:center;line-height:0.7rem;margin-top:0.15rem;}
	.mask{width:100%;height:100%;position:absolute;left:0;top:0;right:100%;bottom:100%;display:none;}
	.alerts{width:2.4rem;height:2rem;background:rgba(0,0,0,0.5);position:absolute;left:50%;top:50%;-webkit-transform:translate(-50%,-50%);border-radius:6px;}
	.fail{background:url('${backStatic}/images/icon_errors.png') no-repeat center;background-size:contain;}
	.success{background:url('${backStatic}/images/icon_successes.png') no-repeat center;background-size:contain;}
	.alerts>i{display:block;width:0.8rem;height:0.8rem;margin:0 auto;margin-top:0.3rem;}
	.alerts>b{display:block;width:100%;height:0.8rem;margin-top:4px;text-align:center;color:#fff;}
	
</style>
</head>
<body>
	<div class="mask">
		<div class="alerts">
			<i></i>
			<b></b>
		</div>
	</div>
	
	<div id="phone">
		<div class="phone-icon fl">
			<i></i>
		</div>
		<div class="phone-content fl">
			<input type="number" placeholder="手机号码">
		</div>
	</div>
	
	<div id="yanzgengma">
		<div class="yanzgengma-icon fl">
			<i></i>
		</div>
		<div class="yanzgengma-content fl">
			<input type="number" readonly="readonly" placeholder="收到的验证码">
		</div>
		<div id="getqrcode" class="fl">
			<a class="get-yanzhengma" href="javascript:void(0);" onclick="getCode();">获取验证码</a>
		</div>
	</div>
	
	<div id="quedingyuyue">
		<a href="javascript:void(0);">确定预约</a>
	</div>
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
	<script type="text/javascript"  src="${backStatic}/js/alert-box.js"></script>
	<script>
		/* var objectId=getUrlParam('objectId'); */
		document.body.addEventListener('touchmove', function (event) {
		    event.preventDefault();
		}, false);
		
		function countdown(iTime) {
            if(iTime<=1){
                $(".get-yanzhengma").attr("onclick","getCode()");
                $("#getqrcode").html('<a class="get-yanzhengma" onclick="getCode();">获取验证码</a>').removeClass('gray');
                clearTimeout(oTime);
            }else{
                iTime--;
                $("#getqrcode").html('<i class="gray">'+lessTime(iTime)+'秒获取</i>');
                oTime=setTimeout(function () {
                    countdown(iTime);
                }, 1000);
            }
           
        }
      //时分秒小于10处理函数
        function lessTime(timeObj) {
            if (timeObj < 10) {
                timeObj = '0' + timeObj;
            }
            return timeObj;
        }
		
      //发送短信验证码
	    function sendCode(){
	    	var phoneno=$.trim($(".phone-content>input").val());
	    	$.ajax({
				type:"post",
				dataType:"json",
				data:{"phone":phoneno},
				url:"./getMessageCode",
				success:function(json){
					if(json.code==0){
						$(".mask").css("display","block");
						$(".alerts>b").html('验证码发送成功');
			    		$(".alerts>i").addClass("success");
			    		$(".mask").animate({opacity: 'hide'}, 2000,function(){$(".mask").css("display","none");$(".alerts>b").html('');$(".alerts>i").removeClass("success");$(".mask").css("opacity","1")});
						 countdown(60);
					}else{
						$(".mask").css("display","block");
						$(".alerts>b").html(json.message);
			    		$(".alerts>i").addClass("fail");
			    		$(".mask").animate({opacity: 'hide'}, 2000,function(){$(".mask").css("display","none");$(".alerts>b").html('');$(".alerts>i").removeClass("fail");$(".mask").css("opacity","1")});
						$(".get-yanzhengma").attr("onclick","getCode()");
					}
				}
			});
	    } 
		
	    function getCode(){
	    	$(".yanzgengma-content>input").removeAttr("readonly");
			//获取验证码前的验证
			var phoneno=$.trim($(".phone-content>input").val());
			$(".get-yanzhengma").attr("onclick","");
	    	if(phoneno=="" || phoneno==null){
	    		$(".mask").css("display","block");
	    		$(".alerts>b").html('手机号码不能为空');
	    		$(".alerts>i").addClass("fail");
	    		$(".mask").animate({opacity: 'hide'}, 2000,function(){$(".mask").css("display","none");$(".alerts>b").html('');$(".alerts>i").removeClass("fail");$(".mask").css("opacity","1")});
	    		$(".get-yanzhengma").attr("onclick","getCode()");
	    		return false;
	    	}
	    	 //输入正确手机号
	    	if(!/^1[3|4|5|7|8]\d{9}$/.test(phoneno)){
	    		$(".mask").css("display","block");
	    		$(".alerts>b").html('请输入正确手机号');
	    		$(".alerts>i").addClass("fail");
	    		$(".mask").animate({opacity: 'hide'}, 2000,function(){$(".mask").css("display","none");$(".alerts>b").html('');$(".alerts>i").removeClass("fail");$(".mask").css("opacity","1")});
	    		$(".get-yanzhengma").attr("onclick","getCode()");
	    		return false;
	    	}
	       sendCode();
		}
	    
	    function showdata(phoneno){
	    	location.href="./toBzjList?phone="+phoneno;
			
		}
		
	    var gFlag=true;
        function formPost(){
        	var phoneno=$.trim($(".phone-content>input").val());
        	var qrCodeVal=$.trim($(".yanzgengma-content>input").val());
        	if(gFlag==false) return false;
            gFlag=false;
        	//手机号为空
        	if(phoneno=="" || phoneno==null){
        		$(".mask").css("display","block");
	    		$(".alerts>b").html('手机号码不能为空');
	    		$(".alerts>i").addClass("fail");
	    		$(".mask").animate({opacity: 'hide'}, 2000,function(){$(".mask").css("display","none");$(".alerts>b").html('');$(".alerts>i").removeClass("fail");$(".mask").css("opacity","1")});
        		gFlag=true;
        		return false;
        	}
        	 //输入正确手机号
        	if(!/^1[3|4|5|7|8]\d{9}$/.test(phoneno)){
        		$(".mask").css("display","block");
	    		$(".alerts>b").html('请输入正确手机号');
	    		$(".alerts>i").addClass("fail");
	    		$(".mask").animate({opacity: 'hide'}, 2000,function(){$(".mask").css("display","none");$(".alerts>b").html('');$(".alerts>i").removeClass("fail");$(".mask").css("opacity","1")});
        		gFlag=true;
        		return false;
        	}
        	
          //短信验证码不能为空
        	if(qrCodeVal=="" || qrCodeVal==null){
        		$(".mask").css("display","block");
	    		$(".alerts>b").html('验证码不能为空');
	    		$(".alerts>i").addClass("fail");
	    		$(".mask").animate({opacity: 'hide'}, 2000,function(){$(".mask").css("display","none");$(".alerts>b").html('');$(".alerts>i").removeClass("fail");$(".mask").css("opacity","1")});
        		gFlag=true;
        		return false;
        	} 
  				 $.ajax({
			        url: "${siteRoot}/CashDeposit/login",
			        data: {
			        	"phone":phoneno,
			        	"code":$.trim($(".yanzgengma-content>input").val())
			        },
			        success: function (data) {
			        	if(data.code == 0){
			        		showdata(phoneno);
			        	}else{
			        		$(".mask").css("display","block");
				    		$(".alerts>b").html(data.message);
				    		$(".alerts>i").addClass("fail");
				    		$(".mask").animate({opacity: 'hide'}, 2000,function(){$(".mask").css("display","none");$(".alerts>b").html('');$(".alerts>i").removeClass("fail");$(".mask").css("opacity","1")});
			        	}
			        }
  				 });
       		return false;
        }
        
        /* 登录 */
        $("#quedingyuyue>a").click(function(){
        	formPost();
        });
        
		
	</script>
</body>
</html>