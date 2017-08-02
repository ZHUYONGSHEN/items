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
<style>
	*{box-sizing:border-box;margin:0;padding:0;}
	html,body{width:100%;height:100%;} 
	body{font-size:0.32rem;background:#1f1f21;}
	.fl{float:left;}
	#container{height:100%;overflow:auto;-webkit-overflow-scrolling: touch;}
	.ad{
			height:92%;
			/* background:url('${backStatic}/images/xiaoqu_ad.png') no-repeat center;
			background-size:cover; */
			}
	.ad>img{width:100%;}
	.btn{height:8%;overflow:hidden;background:#fff;position:fixed;bottom:0;width:100%;}
	.btn>a{width:100%;height:100%;display:block;background:#2c81ff;text-align:center;line-height:1.06rem;color:#fff;font-size:.36rem;}
</style>
</head>
<body>
	<div id="container">
		<div class="ad"><img src="${backStatic}/images/xiaoqu_ad.png"></div>
		<div class="btn"><a href="javascript:void(0);">预定支付</a></div>
	</div>
	
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
	<script>
		var objectId="${linkerId}";
		$(".btn>a").click(function(){
			window.location.href="./toBaozhengjin ?linkerId="+ objectId;
		});
	</script>
</body>
</html>