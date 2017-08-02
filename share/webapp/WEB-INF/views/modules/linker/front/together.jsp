<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="admin"/>
	<meta name="viewport" content="width=device-width">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
	<meta name='apple-mobile-web-app-capable' content='yes' />
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />
	<meta content="telephone=yes" name="format-detection" />
	<meta name="x5-fullscreen" content="true">
	<meta name="full-screen" content="yes">
	<title>${rightButton.yqdyTopText}</title>
	<style>
		#loading {
			position: fixed;
			left:0;
			right:0;
			top:0;
			bottom:0;
			z-index: 99999;
			display: none;
			width: 100vw;
			height: 100vh;
			background: rgba(0,0,0, .6);
		}
		#loading i {
			position: absolute;
			left: 0;
			right: 0;
			top: 50%;
			margin-top: -0.5rem;
			z-index: 9999;
			font-size: .4rem;
			text-indent: -9999em;
			overflow: hidden;
			width: 1em;
			height: 1em;
			border-radius: 50%;
			margin: 0.8em auto;
			-webkit-animation: load6 1.7s infinite ease;
			animation: load6 1.7s infinite ease;
		}
		.loader--spinningDisc {
			content: '';
			top: 0;
		}
		@-webkit-keyframes load6 {
			0% {
				-webkit-transform: rotate(0deg);
				transform: rotate(0deg);
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.11em -0.83em 0 -0.42em #ffffff, -0.11em -0.83em 0 -0.44em #ffffff, -0.11em -0.83em 0 -0.46em #ffffff, -0.11em -0.83em 0 -0.477em #ffffff;
			}
			5%,
			95% {
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.11em -0.83em 0 -0.42em #ffffff, -0.11em -0.83em 0 -0.44em #ffffff, -0.11em -0.83em 0 -0.46em #ffffff, -0.11em -0.83em 0 -0.477em #ffffff;
			}
			30% {
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.51em -0.66em 0 -0.42em #ffffff, -0.75em -0.36em 0 -0.44em #ffffff, -0.83em -0.03em 0 -0.46em #ffffff, -0.81em 0.21em 0 -0.477em #ffffff;
			}
			55% {
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.29em -0.78em 0 -0.42em #ffffff, -0.43em -0.72em 0 -0.44em #ffffff, -0.52em -0.65em 0 -0.46em #ffffff, -0.57em -0.61em 0 -0.477em #ffffff;
			}
			100% {
				-webkit-transform: rotate(360deg);
				transform: rotate(360deg);
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.11em -0.83em 0 -0.42em #ffffff, -0.11em -0.83em 0 -0.44em #ffffff, -0.11em -0.83em 0 -0.46em #ffffff, -0.11em -0.83em 0 -0.477em #ffffff;
			}
		}
		@keyframes load6 {
			0% {
				-webkit-transform: rotate(0deg);
				transform: rotate(0deg);
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.11em -0.83em 0 -0.42em #ffffff, -0.11em -0.83em 0 -0.44em #ffffff, -0.11em -0.83em 0 -0.46em #ffffff, -0.11em -0.83em 0 -0.477em #ffffff;
			}
			5%,
			95% {
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.11em -0.83em 0 -0.42em #ffffff, -0.11em -0.83em 0 -0.44em #ffffff, -0.11em -0.83em 0 -0.46em #ffffff, -0.11em -0.83em 0 -0.477em #ffffff;
			}
			30% {
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.51em -0.66em 0 -0.42em #ffffff, -0.75em -0.36em 0 -0.44em #ffffff, -0.83em -0.03em 0 -0.46em #ffffff, -0.81em 0.21em 0 -0.477em #ffffff;
			}
			55% {
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.29em -0.78em 0 -0.42em #ffffff, -0.43em -0.72em 0 -0.44em #ffffff, -0.52em -0.65em 0 -0.46em #ffffff, -0.57em -0.61em 0 -0.477em #ffffff;
			}
			100% {
				-webkit-transform: rotate(360deg);
				transform: rotate(360deg);
				box-shadow: -0.11em -0.83em 0 -0.4em #ffffff, -0.11em -0.83em 0 -0.42em #ffffff, -0.11em -0.83em 0 -0.44em #ffffff, -0.11em -0.83em 0 -0.46em #ffffff, -0.11em -0.83em 0 -0.477em #ffffff;
			}
		}
		.fl{float:left;}

	</style>
	<link rel="stylesheet" href="http://release.720.hiweixiao.com/SpecialConnector/css/common.css">
	<script>
        (function (doc, win) {
            var docEl = doc.documentElement,
                //判断窗口有没有orientationchange这个方法，有就赋值给一个变量，没有就返回resize方法。
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    //把document的fontSize大小设置成跟窗口成一定比例的大小，从而实现响应式效果。
                    docEl.style.fontSize = 42.6667 * (clientWidth / 320) + 'px';
                };
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false)
        })(document, window);
	</script>
</head>
<body style="background:#f6fafb">
	<div class="p_30">
	<p class="text_center color_222323 p_b20 fz32">&nbsp;</p>
	<c:set var="num" value="<span class='color_fa5c5c num'  style='font-size:26px;'>${totalTogetherNum}</span>"></c:set>
	<p class="text_center color_222323 p_b20 fz32">${fn:replace(fn:replace(rightButton.yqdyTitle, "x", num),"X",num)}</p>
	<p class="text_center color_222323 p_b20 fz32" id="avtertx"></p>
	<p class="text_center color_222323 p_b20 fz32" style="margin-bottom: 12px;font-size:18px!important;">${rightButton.yqdyBewrite}</p>
	<div class="clear" id="imgtx" style="width:6.9rem;height:9.8rem;overflow:auto;-webkit-overflow-scrolling: touch;">
		
	</div>
	<!-- <p id="clickmore" class="fz32" style=" padding: 0.1rem 0; text-align:center;background:#00ccff;line-height:0.4rem;color:#fff;border-radius:5px">查看更多</p> -->
	</div>
	<div id="loading">
		<i class="loader--spinningDisc"></i>
	</div>
	<input type="hidden" id="falseTogetherNum" value="${falseTogetherNum}"/>
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
<script>

	var page = 1,pageSize=20,complete=false;
	var count1=parseInt($("#falseTogetherNum").val());
	$(function(){
		loadimg();
	});
	var _loadData=false;
	function loadimg(){
		if(_loadData||complete){
			return;
		}
		if (preventRepeatRequest) {
            return;
        }
		preventRepeatRequest = true;
		_loadData=true;
		$.ajax({
			type:'get',
			url:'${siteRoot}/linker/togetherData',
			data:{
				linkerId:'${id}',
				pageNo:page,
				pageSize:pageSize,
				count:count1
			},
			success:function(data){
				if (data.list.length >= 20) {
                    preventRepeatRequest = false;
                }
				if(data.list.length>0){
				    //$('#num').text(data.count);
					page++;
					var html='';
					$(".num").html(count1 + data.count);
					console.info(count1);
					for(var i=0;i<data.list.length;i++){
						var user=data.list[i];
						html+='<div style="width:1.2rem;height:1.9rem;margin-left:0.4rem;overflow:hidden;margin-bottom:.1rem;box-sizing:border-box;" class="fl"><a href="#" class="avatar_img" style="background-image: url('+user.headImgUrl+');margin-left:0!important;"></a><p style="font-size:0.32rem;width:100%;text-align:center;height:0.32rem;line-height:0.32rem;overflow:hidden;">'+user.nickName+'</p></div>';
					}
					$('#imgtx').append(html);
				}else{
					$('#clickmore').hide();
					complete=true;
				}
				if(count1<pageSize && data.length<pageSize){
					$('#clickmore').hide();
					complete=true;
				}
				_loadData=false;
			}
		});
	}
	
	var oldScrollTop,requestFram,preventRepeatRequest=false;
	var moveEnd = function () {
		requestFram = requestAnimationFrame(function() {//判断惯性运动是否已经完成
			if ($("#imgtx")[0].scrollTop != oldScrollTop) {
				oldScrollTop = $("#imgtx")[0].scrollTop;
				moveEnd()
			} else {
				cancelAnimationFrame(requestFram);
				loadMore();
			}
		})
	}
	
	var loadMore = function() {
		if ($("#imgtx")[0].scrollTop + $("#imgtx")[0].offsetHeight+5 >= $("#imgtx")[0].scrollHeight&&$("#imgtx")[0].scrollTop>0) {
			loadimg();
		}
	}
	
   /*  $('#clickmore').click(function () {
    	loadimg();
    }); */
    
    $("#imgtx").on("touchmove",function(){
    	loadMore();
    });
    
    $("#imgtx").on("touchend",function(){
		oldScrollTop = $(this)[0].scrollTop;
		moveEnd();//惯性触发加载更多
	});
    
    
    
    
    
    
    
    
    
</script>

<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var linkerId="${id}";
wx.config({
	debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	appId : '${signature["appid"]}', // 必填，公众号的唯一标识
	timestamp : '${signature["timestamp"]}', // 必填，生成签名的时间戳
	nonceStr : '${signature["noncestr"]}', // 必填，生成签名的随机串
	signature : '${signature["signature"]}',// 必填，签名，见附录1
	jsApiList : ['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareTimeline','onMenuShareQQ','onMenuShareWeibo' ,'onMenuShareQZone']
// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
});
$(function(){
	var title='${linkerShare.shareEntryTitle}';
	var desc="${linkerShare.shareBewrite}";
	var arrEntities={'lt':'<','gt':'>','nbsp':' ','amp':'&','quot':'"','ldquo':'“','rdquo':'”'};
	desc=desc.replace(/&(lt|gt|nbsp|amp|quot|ldquo|rdquo);/ig,function(all,t){return arrEntities[t];});
	title=title.replace(/&(lt|gt|nbsp|amp|quot|ldquo|rdquo);/ig,function(all,t){return arrEntities[t];});
	var link= location.host+"/linker/${linkerShare.objectId}";
	var imgUrl='${fns:getCosAccessHost()}'+'${linkerShare.squareMap}';
	var type='link';
	var dataUrl='';
	wx.ready(function(){
	    wx.onMenuShareAppMessage({
	        title:title, // 分享标题
	        desc:desc, // 分享描述
	        link:link, // 分享链接
	        imgUrl: imgUrl, // 分享图标
	        type: type, // 分享类型,music、video或link，不填默认为link
	        dataUrl: dataUrl, // 如果type是music或video，则要提供数据链接，默认为空
	        success: function () {
	            // 用户确认分享后执行的回调函数
	        	saveShareLog({linkerId:linkerId,link:link});
	        },
	        cancel: function () {
	            // 用户取消分享后执行的回调函数
	        }
	    });
	    wx.onMenuShareTimeline({
	        title:title, // 分享标题
	        link: link, // 分享链接
	        imgUrl:imgUrl, // 分享图标
	        success: function () {
	            // 用户确认分享后执行的回调函数
	        	saveShareLog({linkerId:linkerId,link:link});
	        },
	        cancel: function () {
	            // 用户取消分享后执行的回调函数
	        }
	    });


	  wx.onMenuShareQQ({
	    title: title, // 分享标题
	    desc:desc, // 分享描述
	    link: link, // 分享链接
	    imgUrl: imgUrl, // 分享图标
	    success: function () {
	       // 用户确认分享后执行的回调函数
	    },
	    cancel: function () {
	       // 用户取消分享后执行的回调函数
	    }
	  });

	  wx.onMenuShareWeibo({
	    title:title, // 分享标题
	    desc:desc, // 分享描述
	    link:link, // 分享链接
	    imgUrl: imgUrl, // 分享图标
	    success: function () {
	       // 用户确认分享后执行的回调函数
	    },
	    cancel: function () {
	      // 用户取消分享后执行的回调函数
	    }
	  });

	  wx.onMenuShareQZone({
	      title:title, // 分享标题
	      desc:desc, // 分享描述
	      link:link, // 分享链接
	      imgUrl:imgUrl, // 分享图标
	      success: function () {
	         // 用户确认分享后执行的回调函数
	      },
	      cancel: function () {
	        // 用户取消分享后执行的回调函数
	      }
	    });
	});
});

function saveShareLog(d){
	$.post("${siteRoot}/api/data/shareLog",d,function(data){
		
	});
}
</script>
</body>
</html>