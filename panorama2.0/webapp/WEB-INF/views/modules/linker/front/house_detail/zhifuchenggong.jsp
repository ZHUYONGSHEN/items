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
<title>支付成功</title>
<link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
<style>
	*{box-sizing:border-box;margin:0;padding:0;}
	html,body{width:100%;height:100%;} 
	body{font-size:0.3rem;}
	.fl{float:left;}
	#container{height:100%;}
	.icons{width:2rem;height:2rem;background:url('${backStatic}/images/icon_shenhechenggong.png') no-repeat center;background-size:cover;margin:0 auto;margin-top:1rem;margin-bottom:0.5rem;}
</style>
</head>
<body>
	<div id="container">
		<div class="icons"></div>
		<div style="text-align:center;color:#333;font-size:0.36rem;margin-bottom:0.5rem;">支付成功</div>
		<p style="width:90%;margin:0 auto;text-align:center;"><span style="color:#ccc;">可关注“</span>找房公众号<span style="color:#ccc;">“--“</span>我的保证金<span style="color:#ccc;">“</span></p>
		<p style="width:90%;margin:0 auto;text-align:center;color:#ccc;">中查询交易记录</p>
		<a href="javascript:void(0);" class="queding" style="display:block;width:90%;height:1rem;background:#1f97ff;margin:0 auto;border-radius:6px;text-align:center;line-height:1rem;color:#fff;font-size:0.36rem;margin-top:0.5rem;">确定</a>
	</div>
	
	
	
	
	
	
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
	<script>
		$(".queding").on("click",function(){
			location.href="./${linkerId}"
		})
	</script>
</body>
</html>