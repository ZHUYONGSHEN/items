<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>接口测试</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <script src="//cdn.bootcss.com/jquery/2.2.2/jquery.min.js"></script>
</head>
<body>
<script>
	$(function(){
		var id="${albumId}";
		$.ajax({
            type: "GET",
            url: "http://test.ljq.zooming-data.com/api/pano/"+id,
            data: {},
            dataType: "jsonp",
            jsonp: "callbackparam",
            success: function (data) {
                console.log(data);
            },
            error: function () {
            }
        });
	});
</script>
</body>
</html>