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
<title>精彩留言</title>
<link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
<style>
	*{overflow:hidden;box-sizing:border-box;margin:0;padding:0;}
	html,body{width:100%;height:100%;} 
	body{font-size:0.3rem;background:#f5f4f9;}
	.fl{float:left;}
	#container{width:100%;height:3rem;background:#fff;}
	#tijiaos{width:90%;height:0.8rem;margin:0 auto;margin-top:1rem;}
	#tijiaos>a{display:block;width:100%;height:100%;background:#1f97ff;border-radius:6px;text-align:center;line-height:0.8rem;color:#fff;}
	#container>div{width:100%;height:0.4rem;text-align:right;padding-right:12px;color:#ccc;}
	#container>textarea{width:100%;height:2.6rem;border:0;resize:none;outline:none;padding-left:8px;font-size:16px;}
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


	<div id="container">
		<textarea id="content"></textarea>
		<div><span id="count">0</span>/50</div>
	</div>
	
	<div id="tijiaos">
		<a href="javascript:void(0)">提交</a>
	</div>
	
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
	<script type="text/javascript"  src="${backStatic}/js/alert-box.js"></script>
	<script>
		var linkerId = '${linkerId}';
		var openId = '${openId}';
		$("#tijiaos").on("click",function(){
			var content = $("#content").val();
			if(!content){
				$(".mask").css("display","block");
				$(".alerts>b").html('留言不能为空');
				$(".alerts>i").addClass("fail");
				$(".mask").animate({opacity: 'hide'}, 2000,function(){
					$(".mask").css("display","none");
					$(".alerts>b").html('');
					$(".alerts>i").removeClass("fail");
					$(".mask").css("opacity","1")});
				return false;
			}
			if(content.length>50){
				$(".mask").css("display","block");
				$(".alerts>b").html('长度不能超过50');
				$(".alerts>i").addClass("fail");
				$(".mask").animate({opacity: 'hide'}, 2000,function(){
					$(".mask").css("display","none");
					$(".alerts>b").html('');
					$(".alerts>i").removeClass("fail");
					$(".mask").css("opacity","1")});
				return false;
			}
			$.ajax({
				type: "POST",
				url:'./leaveMessage',
				data:{
					linkerId:linkerId,
					openId:openId,
					content:content
				},
				success:function(data){
					if(data.code == 0){
						$(".mask").css("display","block");
						$(".alerts>b").html('留言成功');
						$(".alerts>i").addClass("success");
						$(".mask").animate({opacity: 'hide'}, 2000,function(){
							window.location.href="./details?objectId=" + linkerId;
							$(".mask").css("display","none");
							$(".alerts>b").html('');
							$(".alerts>i").removeClass("success");
							$(".mask").css("opacity","1")});
					}else{
						$(".mask").css("display","block");
						$(".alerts>b").html('留言失败');
						$(".alerts>i").addClass("fail");
						$(".mask").animate({opacity: 'hide'}, 2000,function(){
							$(".mask").css("display","none");
							$(".alerts>b").html('');
							$(".alerts>i").removeClass("fail");
							$(".mask").css("opacity","1")});
					}
		        }
			});
		})
		$("#content").on("keyup",function(){
			if($("#content").val().length>50){
				$("#content").val($("#content").val().substr(0,50));
			}else{
				$("#count").html($("#content").val().length);
			}
		})
	</script>
</body>
</html>