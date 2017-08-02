<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
		<meta name="decorator" content="admin"/>
    	<title>按钮</title>
    	<style>
    		#container{width:400px;height:400px;}
    	</style>
	</head>
	
	
	<body>
	<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=d84d6d83e0e51e481e50454ccbe8986b"></script>
		<script>
		
		var init = function() {
	    var center = new qq.maps.LatLng(39.916527,116.397128);
	    var map = new qq.maps.Map(document.getElementById('container'),{
	        center: center,
	        zoom: 13
	    });
	    //创建marker
	    var marker = new qq.maps.Marker({
	        position: center,
	        map: map
	    });
	    
	}
	</script>
		<button onclick="init()">按钮</button>
		
		<div id="container">
			
		</div>
		
		
		
	</body>
	
	<script>
	alert("OK");
	</script>
</html>