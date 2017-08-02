<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    	<title>个人资料</title>
    	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	    <meta name="format-detection" content="telephone=no" />
	    <meta name="apple-mobile-web-app-capable" content="yes">
	    <meta content="black" name="apple-mobile-web-app-status-bar-style">
	    <meta content="telephone=yes" name="format-detection">
	    <meta name="x5-fullscreen" content="true">
	    <meta name="full-screen" content="yes">
	    <link rel="stylesheet" href="${linkerStatic}/css/common.css?v=1.0">
	    <link rel="stylesheet" href="${linkerStatic}/css/setting.css?v=1.1">
	    <style type="text/css">
	    	body{font-size:0.8rem;background:#f5f4f9;}
	    	#wraper{margin-top:1rem;}
	    	.bacunss{width:90%;height:2rem;margin:0 auto;margin-top:2rem;position:absolute;z-index:2;left:50%;-webkit-transform: translateX(-50%);}
	    	.bacunss>input{width:100%;height:100%;background:#108ee9;border-radius:6px;color:#fff;}
	    	
	    	.mask{width:100%;height:100%;position:absolute;left:0;top:0;right:100%;bottom:100%;display:none;}
			.alerts{text-align:center;width:90%;line-height:2rem;height:2rem;background:rgba(0,0,0,0.5);position:absolute;left:50%;top:50%;-webkit-transform:translate(-50%,-50%);border-radius:6px;}
			.fail{background:url('${backStatic}/images/icon_errors.png') no-repeat center;background-size:contain;}
			.success{background:url('${backStatic}/images/icon_successes.png') no-repeat center;background-size:contain;}
			.alerts>i{display:block;width:0.8rem;height:0.8rem;margin:0 auto;margin-top:0.3rem;}
			.alerts>b{display:block;width:100%;height:0.8rem;margin-top:4px;text-align:center;color:#fff;}
	    	
	    	.hide_com{display:none;}
	    	.zhezhao{width:100%;height:100%;position:absolute;left:0;top:0;z-index:1;}
	    	
	    	.name>input{width:100%;text-align:right;padding-right:1rem;}
	    	.pho input{width:100%;text-align:right;padding-right:1rem;}
	    	
	    	.gonghaos{width:85%;height:7rem;margin:0 auto;background:#fff;position:absolute;left:50%;-webkit-transform:translateX(-50%);z-index:3;}
	    	.haoma,.gonghaos-tip{height:1.2rem;margin-bottom:6px;}
	    	.shurukuang{height:1.2rem;margin-bottom:6px;}
	    	.shurukuang>input{height:100%;border:1px solid #ccc;padding-left:6px;}
	    	.annius{width:5.6rem;height:1.5rem;margin:0 auto;}
	    	.annius>a{display:block;height:1.5rem;background:#108ee9;border-radius:4px;color:#fff;text-align:center;line-height:1.5rem;}
	    	.haoma,.gonghaos-tip{padding-left:3rem;}
	    	.gonghaos-tip{color:red;}
	    	.shurukuang>input{margin-left:3rem;}
	    	
	    </style>
	</head>
	<body>
		<div class="mask">
			<div class="alerts">
				<!-- <i></i> -->
				<b></b>
			</div>
		</div>
		
		
		
		<div class='zhezhao'></div>
		
		 <div id="wraper">
			<!-- <div id="header">
				<div class="header-left">
					<div class="back"></div>
				</div>
				<div class="header-center">
					<div class="set-title">设置</div>
				</div>
			</div> -->
			<div id="bodies">
				<div class="avatares update_photo">
					<div>头像</div>
					<div class="touxiang-parent">
						<img class="avatares-img touxiang" src="">
					</div>
					<div></div>
				</div>
				<div class="names">
					<div>名字</div>
					<div class="name"><input type="text" name="name" value="${info.nickName}" placeholder="请输入姓名"></div>
				</div>
				<div class="pho">
					<div>电话</div>
					<div><input class="phone-num" type="text"  value='${info.phone}'  maxlength="11" placeholder="请输入电话号码"></div>
				</div>
				
			</div>
			<div class="bacunss">
				<input type="button"  class="editBtn edit" value="编辑"/>
				<input type="button"  class="editBtn save"  value="保存" style="display:none"/>
			</div>
		</div>
		
		<div class="gonghaos hide_com" style="font-size:0.8rem;border:1px solid #333;">
			<div class="haoma">请输入中原工号</div>

			<div class="shurukuang"><input type="text" id="staffNo"></div>
			<div class="gonghaos-tip"></div>
			<div class="annius"><a href="javascript:void(0);">确定</a></div>
		</div>
		<input type="hidden" id="tempImg"  value="${info.headImg}"/>
	</body>
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	
	<script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
	<script type="text/javascript" src="${linkerStatic}/js/rem.js"></script>
	<script type="text/javascript"  src="${backStatic}/js/alert-box.js"></script>
	
	<script>
	    var img = "${info.headImg}";
	    var showImg = "${fns:getCosAccessHost()}" + img;
	    if(img.indexOf("http:") != -1){
	    	showImg = img;
	    }
	    $(".touxiang").attr("src",showImg);
		var fyType = "${fyType}";//房源类型
		var openId = "${mpUser.openId}";
		var linkerId="${linkerId}";
		 wx.config({
			debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
			appId : '${signature["appid"]}', // 必填，公众号的唯一标识
			timestamp : '${signature["timestamp"]}', // 必填，生成签名的时间戳
			nonceStr : '${signature["noncestr"]}', // 必填，生成签名的随机串
			signature : '${signature["signature"]}',// 必填，签名，见附录1
			jsApiList : ['chooseImage','uploadImage']
		// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
		}); 
		document.body.addEventListener('touchmove', function (event) {
		    event.preventDefault();
		}, false);
		
		function isWeiXin(){
		    var ua = window.navigator.userAgent.toLowerCase();
		    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
		        return true;
		    }else{
		        return false;
		    }
		}
		function initWxApi(){
	//		调用微信接口上传图片
			if(!isWeiXin()){
				alert("请在微信打开!");
				return;
			}
		}
		
		function trim(str){
			var result;
	        result = str.replace(/(^\s+)|(\s+$)/g,"");
	        result = result.replace(/\s/g,"");
	        return result;
		}
		function showdata(data){
			$(".mask").css("display","block");
			$(".tip").html(data.msg).show().animate({opacity: 'hide'}, 3000,function(){$(".mask").css("display","none")});
    		setTimeout(function(){
    			window.location.href = '${siteRoot}/linker/'+ linkerId + "?openId=" + openId;
    		},1500);
			
		}
		
		var gFlag=true;
        function formPost(){
        	var phoneno=$(".phone-num").val();
        	var name= $("input[name='name']").val();
        	if(gFlag==false) return false;
        	/* var qrCodeVal=$(".yanzheng-code input").val(); */
        	//手机号为空
        	if(phoneno=="" || phoneno==null){
        		$(".mask").css("display","block");
				$(".alerts>b").html('手机号码不能为空哦！');
				$(".alerts>i").addClass("fail");
				$(".mask").animate({opacity: 'hide'}, 2000,function(){
					$(".mask").css("display","none");
					$(".alerts>b").html('');
					$(".alerts>i").removeClass("fail");
					$(".mask").css("opacity","1")});
        		gFlag=true;
        		return false;
        	}
        	if(!name){
        		$(".mask").css("display","block");
				$(".alerts>b").html('姓名不能为空！');
				$(".alerts>i").addClass("fail");
				$(".mask").animate({opacity: 'hide'}, 2000,function(){
					$(".mask").css("display","none");
					$(".alerts>b").html('');
					$(".alerts>i").removeClass("fail");
					$(".mask").css("opacity","1")});
        		gFlag=true;
        		return false;
        	}
        	if(flag && fyType == 1){
        		
        	}else{
        		 //输入正确手机号
            	if(!/^1[3|4|5|7|8]\d{9}$/.test(phoneno)){
            		$(".mask").css("display","block");
            		$(".alerts>b").html('请输入正确手机号!');
    				$(".alerts>i").addClass("fail");
    				$(".mask").animate({opacity: 'hide'}, 2000,function(){
    					$(".mask").css("display","none");
    					$(".alerts>b").html('');
    					$(".alerts>i").removeClass("fail");
    					$(".mask").css("opacity","1")});
            		gFlag=true;
            		return false;
            	}
        	}
        	/*  if(!serverId){
        		$(".mask").css("display","block");
        		$(".alerts>b").html('请上传头像!');
				$(".alerts>i").addClass("fail");
				$(".mask").animate({opacity: 'hide'}, 2000,function(){
					$(".mask").css("display","none");
					$(".alerts>b").html('');
					$(".alerts>i").removeClass("fail");
					$(".mask").css("opacity","1")});
        		gFlag=true;
        		return false;
        	} */
        	var img = $("#tempImg").val();
  			$.ajax({
 				type: "POST",
		        url: "${siteRoot}/linker/updateCustomInfo",
		        data: {
		        	"mobile":phoneno,
		        	"openId":openId,
		        	"zdyNickname":name,
		        	"mediaId":serverId,
		        	"img":img
		        },
		        success: function (data) {
		        	if(data.code == 3){
						$(".mask").css("display","block");
		    			$(".alerts>b").html('请在微信中打开此页面');
						$(".alerts>i").addClass("fail");
						$(".mask").animate({opacity: 'hide'}, 2000,function(){
							location.href="";
							$(".mask").css("display","none");
							$(".alerts>b").html('');
							$(".alerts>i").removeClass("fail");
							$(".mask").css("opacity","1")}); 
		        	} else if(data.code == 0){
		        		$(".mask").css("display","block");
		    			$(".alerts>b").html('修改成功');
						$(".alerts>i").addClass("success");
						$(".mask").animate({opacity: 'hide'}, 2000,function(){
							location.href="./"+linkerId+"?openId=" + openId;
							$(".mask").css("display","none");
							$(".alerts>b").html('');
							$(".alerts>i").removeClass("fail");
							$(".mask").css("opacity","1")}); 
		        	}
		        }
  			});
       		return false;
        }
        var localId;
		var serverId;
    	$(".update_photo").click(function(){
    		wx.chooseImage({
    			count: 1,
    			success: function (res) {
    				localId = res.localIds;
    				$(".touxiang").attr("src",localId);
    				//上传图片
    				wx.uploadImage({
    					localId: localId.toString(),
    					success: function (res) {
    						serverId = res.serverId;
    					}
    				})
    			}
    		});
    	})
        var flag = false;
    	function getZyInfo(staffNo){
    		$.ajax({
 				type: "POST",
		        url: "${siteRoot}/linker/getZyUser",
		        data: {
		        	"staffNo":staffNo
		        },
		        success: function (data) {
		        	if(data.code == 0){
		        		$("#tempImg").val(data.staffImg);
		        		$(".touxiang").attr("src",data.staffImg);
		        		$("input[name='name']").val(data.staffName);
		        		var reTag = /<(?:.|\s)*?>/g;
		        		var str = data.staff400.replace(reTag,"");
		        		$(".phone-num").val(str);
		        		$('.edit').hide();
		    			$(".save").show();
		        		$(".gonghaos").addClass("hide_com");
		        		$(".zhezhao").addClass("hide_com");
		        		flag = true;
		        	} else{
		        		$(".gonghaos-tip").html(data.message);
		        	}
		        }
  			});
    	}
    	//编辑按钮
    	$(".edit").on("click",function(){
    		if(fyType == 1){//二手房
    			$(".gonghaos").removeClass("hide_com");
    		}else{
    			$(this).hide();
    			$(".save").show();
    			$(".zhezhao").addClass("hide_com");
    		}
    	})
    	$(".save").on("click",function(){
    		formPost();
    	})
    	$("body").on("click",".annius a",function(){
    		var staffNo = $("#staffNo").val();
    		if(staffNo){
    			getZyInfo(staffNo);
    		}
    	});
	</script>
</html>















