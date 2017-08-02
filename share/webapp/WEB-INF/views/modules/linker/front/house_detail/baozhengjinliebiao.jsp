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
<title>我的保证金</title>
<link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
<style>
	*{box-sizing:border-box;margin:0;padding:0;}
	html,body{width:100%;height:100%;overflow:hidden;}
	body{font-size:0.3rem;background:#f5f4f9;}
	.fl{float:left;}
	#container{height:100%;overflow:auto;-webkit-overflow-scrolling: touch;}
	.titles{height:1rem;width:90%;margin:0 auto;display: -webkit-flex;border-bottom:1px solid #ccc;}
	.zhanghao{-webkit-flex:1 ;height:100%;line-height:1rem;color:#888;}
	.dianhuas{-webkit-flex:3 ;height:100%;line-height:1rem;}
	.tuichus{-webkit-flex:0.5 ;height:100%;line-height:1rem;color:#888;}
	.contents{width:90%;height:1.5rem;border-bottom:1px solid #ccc;margin:0 auto;display: -webkit-flex;}
	.contents-left{-webkit-flex:5 ;height:100%;}
	.contents-right{-webkit-flex:1 ;height:100%;line-height:1.5rem;color:#333;font-weight:600;margin-bottom:3px;}
	.p1{color:#333;font-weight:600;margin-top:0.3rem;}
	.p2{color:#ccc;}
	.zhuangtaiss{height:100%;-webkit-flex:3;line-height:1.5rem;text-align:center;}
</style>
</head>
<body>
	<div id="container">
		<div class="titles">
			<div class="fl zhanghao">当前帐号:</div>
			<div class="fl dianhuas">${phone}</div>
			<div class="fl tuichus">退出</div>
		</div>

		<c:if test="${list != null}">
		 	<c:forEach items="${list}" var="bean" varStatus="index">
		 		<div class="contents">
					<div class="contents-left">
						<p class="p1">${bean.objectName}</p>
						<p class="p2">${bean.createTime}</p>
					</div>
					<c:if test="${bean.type == 1}">
					  <div class="contents-right">-${bean.djje}</div>
					</c:if>
					<c:if test="${bean.type == 3}">
					  <div class="contents-right">+${bean.djje}</div>
					</c:if>
				</div>
		 	</c:forEach>
		</c:if>
		
	</div>
	
	
	
	
	
	
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script>
		$(".tuichus").click(function(){
			wx.closeWindow();
		})
	</script>
</body>
</html>