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
<title>保证金</title>
<link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
<link href="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.css" type="text/css" rel="stylesheet" />
 <!--jbox-->
<link id="skin" rel="stylesheet" href="${ctxStatic}/jquery-jbox/2.3/Skins/Blue/jbox.css" />
<style>
	*{overflow:hidden;box-sizing:border-box;margin:0;padding:0;}
	body{font-size:0.32rem;background:#f5f4f9;}
	input{font-size:.32rem;}
	.fl{float:left;}
	#jin_e,#yinhang_kahao,#xingming,#shenfenzheng,#shouji,#yanzhenma{width:90%;margin:0 auto;margin-top:6px;}
	.jin_e_name,.yinhang_kahao_name,.xingming_name,.shenfenzheng_name,.shouji_name{height:0.84rem;border-bottom:1px solid #d3ecf9;margin-bottom:3px;}
	.mr02{margin-right:0.2rem;}
	.jin_e_name>span,.yinhang_kahao_name>span,.xingming_name>span,.shenfenzheng_name>span,.shouji_name>span,.yanzhenma_name>span{margin-top:0.2rem;margin-left:0.2rem;}
	.ml02{margin-left:0.2rem;}
	.jin_e_name>input{width:4.4rem;height:0.4rem;padding-left:3.4rem;border:0;}
	.pt015{padding-top:0.15rem;}
	.mt015{margin-top:0.15rem;}
	.mt020{margin-top:0.2rem;}
	.mt024{margin-top:0.24rem;}
	.txcenter{text-align:center;}
	.colorred{color:red;}
	.mr05{margin-right:0.5rem;}
	.yinhang_kahao_name>input,.xingming_name>input,.shenfenzheng_name>input,.shouji_name>input{width:3.9rem;height:0.4rem;border:0;}
	.yinhang_kahao_name>i,.xingming_name>i,.shenfenzheng_name>i,.shouji_name>i,.yanzhenma_name>i{display:inline-block;width:0.3rem;height:0.3rem;}
	
	#ff{background:#fff;}
	
	.yanzhenma_name{width:4.2rem;height:0.84rem;margin-right:0.2rem;margin-bottom:3px;}
	.yanzhenma_name>input{width:1.8rem;border:0;margin-top:0.25rem;}
	.get-yanzhengma{display:block;height:100%;background:#1f97ff;border-radius:4px;text-align:center;line-height:0.8rem;color:#fff;}
	#getqrcode{width:2.28rem;height:0.8rem;margin-top:2px;margin-bottom:3px;}
	#zhifu{width:6.8rem;height:0.8rem;margin:0 auto;margin-top:1.2rem;}
	#zhifu>a{display:block;height:100%;background:#1f97ff;border-radius:4px;line-height:0.8rem;text-align:center;color:#fff;}
	.gray{display:block;width:100%;border-radius:6px;height:100%;text-align:center;line-height:0.8rem;background:#ccc;}
	.error{background:url('http://cdn.szzunhao.com/hongbaobase/img/picture/i_icon_error.png') no-repeat center;background-size:cover;}

	/* .icon-ban{background:url('${backStatic}/images/icon_bank.png') no-repeat center;background-size:cover;} */

	.xingming_name input{margin-left:0.6rem;}
	.yanzhenma_name input{margin-left:0.3rem;}
	.mask{width:100%;height:100%;position:absolute;left:0;top:0;right:100%;bottom:100%;display:none;}
	.alerts{width:2.4rem;height:2rem;background:rgba(0,0,0,0.5);position:absolute;left:50%;top:50%;-webkit-transform:translate(-50%,-50%);border-radius:6px;}
	.fail{background:url('${backStatic}/images/icon_errors.png') no-repeat center;background-size:contain;}
	.success{background:url('${backStatic}/images/icon_successes.png') no-repeat center;background-size:contain;}
	.alerts>i{display:block;width:0.8rem;height:0.8rem;margin:0 auto;margin-top:0.3rem;}
	.alerts>b{display:block;width:100%;height:0.8rem;margin-top:4px;text-align:center;color:#fff;}
</style>
</head>

<body>
	<form id="ff">
		<div id="jin_e" class="input_parent">
			<div class="jin_e_name pt015 input_border">
				<span>支付金额</span>
				<input type="number" name="jin_e"><b style="color:#9a9a9a;">元</b>
			</div>
			<div class="jin_e_tip colorred"></div>
		</div>
		<div id="yinhang_kahao" class="input_parent">
			<div class="yinhang_kahao_name input_border">
				<span class="mr05 mt016 fl">银行卡号</span>
				<input type="number" class="mr02 mt020 fl" name="yinhang_kahao" placeholder="请输入支出银行卡号码">
				<i class="mt024 fl icon-ban"></i>
			</div>
			<div class="yinhang_kahao_tip colorred"></div>
		</div>
		<div id="xingming" class="input_parent">
			<div class="xingming_name input_border">
				<span class="mr05 mt016 fl">姓名</span>
				<input type="text" class="mr02 mt020 fl" name="xingming" placeholder="请输入本人姓名">
				<i class="mt024 fl"></i>
			</div>
			<div class="xingming_tip colorred"></div>
		</div>
		<div id="shenfenzheng" class="input_parent">
			<div class="shenfenzheng_name input_border">
				<span class="mr05 mt016 fl">身份证号</span>
				<input type="text" class="mr02 mt020 fl" name="shenfenzheng" placeholder="请输入身份证号码">
				<i class="mt024 fl"></i>
			</div>
			<div class="shenfenzheng_tip colorred"></div>
		</div>
		<div id="shouji" class="input_parent">
			<div class="shouji_name input_border">
				<span class="mr05 mt016 fl">手机号码</span>
				<input type="number" class="mr02 mt020 fl" name="shouji" placeholder="请输入手机号码">
				<i class="mt024 fl"></i>
			</div>
			<div class="shouji_tip colorred"></div>
		</div>
		<div id="yanzhenma" class="input_parent">
			<div class="yanzhenma_name fl input_border">
				<span class="mr05 mt016 fl">验证码</span>
				<input type="number" class="mr02 mt020 fl" name="yanzhenma" readonly="readonly" placeholder="输入验证码">
				<i class="mt024 fl"></i>
			</div>
			<div id="getqrcode">
				<a class="get-yanzhengma" href="javascript:void(0);" onclick="getCode();">获取验证码</a>
			</div>
			<div class="yanzhenma_tip colorred"></div>
		</div>
	</form>
	
	<!-- <div id="zhifu">
		<a href="javascript:void(0);">确认支付</a>
	</div> -->

<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
<script type="text/javascript"  src="${backStatic}/js/jquery-migrate-1.1.0.min.js"></script> 
<script type="text/javascript" src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/jquery-jbox/2.3/i18n/jquery.jBox-zh-CN.js"></script>
<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.method.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
<script type="text/javascript"  src="${backStatic}/js/alert-box.js"></script>
<script>
	var objectId='${linkerId}';
	document.body.addEventListener('touchmove', function (event) {
	    event.preventDefault();
	}, false);
	
	function getCode(){
		//获取验证码前的验证
		$(".yanzhenma_name>input").removeAttr("readonly");
		$(".get-yanzhengma").attr("onclick","");
		var phoneno=$.trim($(".shouji_name>input").val()); 
    	if(phoneno=="" || phoneno==null){
    		$(".shouji_tip").html('请输入手机号!').show().animate({opacity: 'hide'}, 3000);
    		$(".shouji_name").css("border","1px solid red"); 
			 $(".shouji_name").find("i").addClass("error"); 
    		$(".get-yanzhengma").attr("onclick","getCode()");
    		return false;
    	}
    	 //输入正确手机号
    	if(!/^1[3|4|5|7|8]\d{9}$/.test(phoneno)){
    		$(".shouji_tip").html('请输入正确的手机号码!').show().animate({opacity: 'hide'}, 3000);
    		$(".shouji_name").css("border","1px solid red"); 
			$(".shouji_name").find("i").addClass("error"); 
    		$(".get-yanzhengma").attr("onclick","getCode()");
    		return false;
    	}
       sendCode();
	}
	
	
	$("#zhifu>a").click(function(){
		var jin_e=$.trim($(".jin_e_name>input").val());
		var yinhang_kahao=$.trim($(".yinhang_kahao_name>input").val());
		var xingming=$.trim($(".xingming_name>input").val());
		var shenfenzheng=$.trim($(".shenfenzheng_name>input").val());
		var shouji=$.trim($(".shouji_name>input").val());
		var yanzhengma=$.trim($(".yanzhenma_name>input").val());
		
		if(!jin_e||!yinhang_kahao||!xingming||!shenfenzheng||!shouji||!yanzhengma){
			if(!jin_e){
				 $(".jin_e_tip").html('请输入支付金额!').show().animate({opacity: 'hide'}, 3000);
				$(".jin_e_name").css("border","1px solid red"); 
				return false;
			}else if(!yinhang_kahao){
				 $(".yinhang_kahao_tip").html('请输入银行卡号!').show().animate({opacity: 'hide'}, 3000);
				$(".yinhang_kahao_name").css("border","1px solid red");
				$(".yinhang_kahao_name").find("i").addClass("error");
				return false;
			}else if(!xingming){
				 $(".xingming_tip").html('请输入您的姓名!').show().animate({opacity: 'hide'}, 3000);
				$(".xingming_name").css("border","1px solid red");
				$(".xingming_name").find("i").addClass("error");
				return false;
			}else if(!shenfenzheng){
				 $(".shenfenzheng_tip").html('请输入您的身份证号!').show().animate({opacity: 'hide'}, 3000);
				$(".shenfenzheng_name").css("border","1px solid red");
				$(".shenfenzheng_name").find("i").addClass("error");
				return false;
			}else if(!shouji){
				$(".shouji_tip").html('请输入手机号!').show().animate({opacity: 'hide'}, 3000);
				$(".shouji_name").css("border","1px solid red"); 
				$(".shouji_name").find("i").addClass("error");
				return false;
			}else if(!yanzhengma){
				$(".yanzhenma_tip").html('请输入验证码!').show().animate({opacity: 'hide'}, 3000);
				$(".yanzhenma_name").css("border","1px solid red");
				$(".yanzhenma_name").find("i").addClass("error"); 
				return false;
			}
		}else{
			var reg =  /^[0-9]*[1-9][0-9]*$/;
			if(!reg.test(jin_e)){
				$(".jin_e_tip").html('请输入大于0的整数').show().animate({opacity: 'hide'}, 3000);
	    		$(".jin_e_name").css("border","1px solid red"); 
				$(".jin_e_name").find("i").addClass("error");
	    		return false;
			}else if(!/^1[3|4|5|7|8]\d{9}$/.test(shouji)){
	    		$(".shouji_tip").html('请输入正确的手机号码!').show().animate({opacity: 'hide'}, 3000);
	    		$(".shouji_name").css("border","1px solid red"); 
				$(".shouji_name").find("i").addClass("error");
	    		return false;
	    	}else if(!/^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/.test(shenfenzheng)){
	    		$(".shenfenzheng_tip").html('请输入正确的身份证号!').show().animate({opacity: 'hide'}, 3000);
	    		$(".shenfenzheng_name").css("border","1px solid red");
				$(".shenfenzheng_name").find("i").addClass("error");
	    		return false;
			}else if(!/^[a-zA-Z\s]{1,6}$|^[\u4e00-\u9fa5]{1,6}$/.test(xingming)){
				$(".xingming_tip").html('请输入正确的名字!').show().animate({opacity: 'hide'}, 3000);
				$(".xingming_name").css("border","1px solid red");
				$(".xingming_name").find("i").addClass("error");
				return false;
			}else if(!/^\d{10,20}$/.test(yinhang_kahao)){
				$(".yinhang_kahao_tip").html('请输入正确的银行卡号!').show().animate({opacity: 'hide'}, 3000);
				$(".yinhang_kahao_name").css("border","1px solid red");
				$(".yinhang_kahao_name").find("i").addClass("error");
				return false;
			}else if(!/^\d{3,8}$/.test(yanzhengma)){
				$(".yanzhenma_tip").html('请输入正确的验证码!').show().animate({opacity: 'hide'}, 3000);
				$(".yanzhenma_name").css("border","1px solid red");
				$(".yanzhenma_name").find("i").addClass("error");
				return false;
			}else{
				$.jBox.tip("处理中.....", 'loading');
				$.ajax({
					url:"./recharge",
					type: "POST",
					data:{
						openId:"${openId}",
						linkerId:objectId,
						yzm:yanzhengma,
						khxm:xingming,
						zjhm:shenfenzheng,
						sjhm:shouji,
						bdkkh:yinhang_kahao,
						jyje:jin_e
					},
					success:function(data){
						if(data.code == "0" || data.code == "1"){//正在处理
							location.href = "./toPayResultPage?linkerId="+objectId + "&type=1";
						}if(data.code == "5"){//正在处理
							location.href = "./toPayResultPage?linkerId="+objectId + "&type=0";
						}if(data.code == "2"){//正在处理
							$.jBox.tip(data.message,'error');
						}
					}
				});
			}
		}
	});
	
	var oTime=null;
    function countdown(iTime) {
        if(iTime<=1){
            $(".get-yanzhengma").attr("onclick","getCode()");
            $("#getqrcode").html('<i class="get-yanzhengma" onclick="getCode();">获取验证码</i>').removeClass('gray');
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
    	var phoneno=$.trim($(".shouji_name>input").val());
    	$.ajax({
			data:{"mobile":phoneno},
			url:"./sendXybkMessage",
			success:function(json){
				if(json.code==0){
					 $.jBox.tip('手机验证码发送成功','success');
					 countdown(60);
				}else{
					$.jBox.tip(json.message,'error');
					$(".get-yanzhengma").attr("onclick","getCode()");
				}
			}
		});
    } 
  
  $("input").focus(function(){
	  var _index=$(this).parents(".input_parent").index();
	  $(".input_border").eq(_index).css("border","0");
	  $(".input_border").eq(_index).css("border-bottom","1px solid #d3ecf9");
	  $(".input_border").eq(_index).find("i").removeClass("error");
  });
  
  
</script>
</body>
</html>