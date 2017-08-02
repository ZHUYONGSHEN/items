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
<title>更多房源</title>
<link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
<style>
	*{overflow:hidden;box-sizing:border-box;margin:0;padding:0;}
	html,body{width:100%;height:100%;} 
	body{font-size:0.3rem;}
	.fl{float:left;}
	#container{height:100%;}
	#more_houses_content{height:100%;overflow:auto;-webkit-overflow-scrolling: touch;}
	#more_houses_content>li{height:1.8rem;border-bottom:1px solid #e6e6e6;}
	.more_houses_content_div1{width:1.7rem;height:1.3rem;margin-top:0.25rem;background:red;margin-right:16px;margin-left:20px;}
	.more_houses_content_div2{height:100%;line-height:1.8rem;}
	
</style>
</head>
<body>
	<div id="container">
		<ul id="more_houses_content">
		</ul>
	</div>
	
	
	
	
	<input type="hidden" id="totalPage" value="0"/>
	<input type="hidden" id="currentPage" value="0"/>
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
	<script type="text/javascript" src="${backStatic}/js/doT.min.js"></script>
	<script type="text/template" id="templete">
	 {{for(var i=0;i < it.length;i++){}}	
			<li data_vals="{{=it[i].linkerId}}">
				<div class="more_houses_content_div1 fl"><img width="100%" height="100%" src="{{=it.url}}{{=it[i].coverImgUrl}}"></div>
				<div class="more_houses_content_div2 fl" style="font-size:16px;">{{=it[i].name}}</div>
			</li>
     {{}}}
	</script>
	<script>
	var siteRoot="${siteRoot}";
	var cdn_url = '${fns:getCosAccessHost()}';
	var fyType = '${fyType}';
	var page = 0,pageSize=10;
	var oldScrollTop,requestFram,preventRepeatRequest=false;
	loadLinker();
	/*更多房源点击  */
	$("#more_houses_content").on("click","li",function(){
		window.location.href="${fns:getHost()}/linker/"+$(this).attr("data_vals");
	});
	function loadLinker(){
		if (preventRepeatRequest) {
            return;
        }
		preventRepeatRequest = true;
		page = parseInt($("#currentPage").val())+1;
		$.ajax({
			url:siteRoot+'/api/object/getMoreLinkers',
			data:{
				currPage:page,
				pageSize:pageSize,
				fyType:fyType
			},
			success:function(data){
				var template=$("#templete").html();
				$("#totalPage").val(data.page.totalPage);
				$("#currentPage").val(data.page.currentPage);
				data.page.items.url = cdn_url;
				$("#more_houses_content").append(doT.template(template)(data.page.items));
				if ($("#currentPage").val() < $("#totalPage").val()) {
	                preventRepeatRequest = false;
	            }
			}
		});
		
	}
	var moveEnd = function () {
		requestFram = requestAnimationFrame(function() {//判断惯性运动是否已经完成
			if ($("#more_houses_content")[0].scrollTop != oldScrollTop) {
				oldScrollTop = $("#more_houses_content")[0].scrollTop;
				moveEnd()
			} else {
				cancelAnimationFrame(requestFram);
				loadMore();
			}
		})
	}
	
	var loadMore = function() {
		if ($("#more_houses_content")[0].scrollTop + $("#more_houses_content")[0].offsetHeight+5 >= $("#more_houses_content")[0].scrollHeight&&$("#more_houses_content")[0].scrollTop>0) {
			loadLinker();
		}
	}
	
	$("#more_houses_content").on("touchmove",function(){
    	loadMore();
    });
    
    $("#more_houses_content").on("touchend",function(){
		oldScrollTop = $(this)[0].scrollTop;
		moveEnd();//惯性触发加载更多
	});
	</script>
</body>
</html>