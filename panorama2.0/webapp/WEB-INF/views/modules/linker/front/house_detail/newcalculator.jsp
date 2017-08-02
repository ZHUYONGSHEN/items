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
<title>${linkerName}</title>
<link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
<link type="text/css" href="${backStatic}/css/styleyc.css" rel="stylesheet">
<style>
    #header{
        height:80px;
    }
    #ifmals1{
        width:100%;
        height:100%;
        position:fixed;
        left:-2px;
    }
</style>
</head>
<body>
	<iframe id="ifmals1" src="http://house.map.qq.com/mobile/calculator.html">
	</iframe>
	
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
</body>
</html>