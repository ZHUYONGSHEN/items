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
	body{font-size:0.3rem;}
	.fl{float:left;}
	#container{width:100%;height:100%;overflow:auto;-webkit-overflow-scrolling: touch;}
	.wraper{width:90%;height:2.7rem;margin:0 auto;border-bottom:1px solid #f3f3f3;}
	.tops{height:1rem;margin-top:0.4rem;}
	.bottoms{height:1.3rem;}
	.tops-profile{width:0.7rem;height:0.7rem;border-radius:0.35rem;background:black;margin-right:16px;}
	.times{color:#ccc;}
	
	::-webkit-scrollbar  
	{  
	    width: 2px;  
	    height: 0px;  
	    background-color: #F5F5F5;  
	}  
	::-webkit-scrollbar-track  
	{  
	    -webkit-box-shadow: inset 0 0 1px rgba(0,0,0,0);  
	    border-radius: 10px;  
	    background-color: #F5F5F5;  
	}  
	  
	
	::-webkit-scrollbar-thumb  
	{  
	    border-radius: 10px;  
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);  
	    background-color: #555;  
	}
</style>
</head>
<body>
	<div id="container">
	</div>
	<input type="hidden" id="totalPage" value="0"/>
	<input type="hidden" id="currentPage" value="0"/>
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
	<script type="text/javascript"  src="${backStatic}/js/alert-box.js"></script>
	<script type="text/javascript" src="${backStatic}/js/doT.min.js"></script>
	<script type="text/template" id="templete">
	 {{for(var i=0;i < it.length;i++){}}	
		<div class="wraper">
			<div class="tops">
				<div class="tops-profile fl" style="background:url({{=it[i].headImgUrl}}) no-repeat center;background-size:cover;"></div>
				<div class="tops-content fl">
					<div>{{=it[i].nickname}}</div>
					<div class="times">{{=it[i].createTime}}</div>
				</div>
			</div>
			<div class="bottoms">
				{{=it[i].content}}
			</div>
		</div>
     {{}}}
	</script>
	<script>
	var linkerId='${linkerId}';
	var page = 0,pageSize=10;
	var oldScrollTop,requestFram,preventRepeatRequest=false;
	loadimg();
	/* document.body.addEventListener('touchmove','#container' ,function (event) {
	    event.preventDefault();
	}, false); */
	
	function loadimg(){
		if (preventRepeatRequest) {
            return;
        }
		preventRepeatRequest = true;
		page = parseInt($("#currentPage").val())+1;
		$.ajax({
			url:'./getLinkerMessageList?linkerId='+linkerId,
			data:{
				currPage:page,
				pageSize:pageSize
			},
			success:function(data){
				var template=$("#templete").html();
				$("#totalPage").val(data.page.totalPage);
				$("#currentPage").val(data.page.currentPage);
				$("#container").append(doT.template(template)(data.page.items));
				if ($("#currentPage").val() < $("#totalPage").val()) {
	                preventRepeatRequest = false;
	            }
			}
		});
		
	}
	

	
	var moveEnd = function () {
		requestFram = requestAnimationFrame(function() {//判断惯性运动是否已经完成
			if ($("#container")[0].scrollTop != oldScrollTop) {
				oldScrollTop = $("#container")[0].scrollTop;
				moveEnd()
			} else {
				cancelAnimationFrame(requestFram);
				loadMore();
			}
		})
	}
	
	var loadMore = function() {
		if ($("#container")[0].scrollTop + $("#container")[0].offsetHeight+5 >= $("#container")[0].scrollHeight&&$("#container")[0].scrollTop>0) {
			loadimg();
		}
	}
	
	$("#container").on("touchmove",function(){
    	loadMore();
    });
    
    $("#container").on("touchend",function(){
		oldScrollTop = $(this)[0].scrollTop;
		moveEnd();//惯性触发加载更多
	});
	
	
	
	
	
	
	
	
	
	
	</script>
</body>
</html>