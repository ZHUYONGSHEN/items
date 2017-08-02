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
	<title></title>
	<link rel="stylesheet" href="http://release.720.hiweixiao.com/SpecialConnector/css/common.css">
	<link rel="stylesheet" href="${linkerStatic}/css/photoswipe.css">
	<link rel="stylesheet" href="${linkerStatic}/css/default-skin/default-skin.css">
	<script>
	//宽度基准
	!(function(win, doc) {
		function setFontSize() {
			var docEl = doc.documentElement;
			var winWidth = docEl.clientWidth;
			doc.documentElement.style.fontSize = (winWidth / 750) * 100 + 'px';
			/*if (winWidth <= 750) {
				doc.documentElement.style.fontSize = (winWidth / 750) * 100 + 'px';
			} else {
				docEl.style.fontSize = 100 + 'px';
			}*/
		}
		var evt = 'onorientationchange' in win ? 'orientationchange' : 'resize';
		var timer = null;
		win.addEventListener(evt, function() {
			clearTimeout(timer);
			timer = setTimeout(setFontSize, 300);
		}, false);
		win.addEventListener('pageshow', function(e) {
			if (e.persisted) {
				clearTimeout(timer);
				timer = setTimeout(setFontSize, 300);
			}
		}, false)
		setFontSize();
	}(window, document))
	</script>
	<style>
	body{
	background:#f6fafb
	}
	.videoMaskLayer {
		position: absolute;
		top:.1rem;
		right:.2rem;
		bottom:.1rem;
		left:.2rem;
		z-index:100;
		background:rgba(58,146,212,.5);
		/* background: url('${panoStatic}/img/ic_play.png') no-repeat center center;
		background-size:10%; */
	}
	.white-space {
		white-space:pre-wrap;
	}
</style>
</head>

<body >

<header class="new_house_head">
	<a href='javascript:window.history.go(-1)' style="position:absolute;top:15px;left:15px;"><img style="width:0.64rem" src="${linkerStatic}/img/go-back1.png"></a>
		<a style="position:absolute;top:15px;right:15px;display:none" href="javascript:void(0);" unitid="xqy_yyjs" id="music_a">
			<img style="width:0.64rem" src="">
			<audio src="" id="details_audio"></audio>
		</a>
	<a class="new_house_bg" style="height:4.2rem;"></a>
<!-- 	<footer>
		<p class="footer_bg clear"><span class="new_house_name"></span>
	</footer> -->
</header>




<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="pswp__bg"></div>
	<div class="pswp__scroll-wrap">
		<div class="pswp__container">
			<div class="pswp__item"></div>
			<div class="pswp__item"></div>
			<div class="pswp__item"></div>
		</div>
		<div class="pswp__ui pswp__ui--hidden">
			<div class="pswp__top-bar">
				<div class="pswp__counter"></div>
				<button class="pswp__button pswp__button--close" id="clcllca"></button>
				<div class="pswp__preloader">
					<div class="pswp__preloader__icn">
						<div class="pswp__preloader__cut">
							<div class="pswp__preloader__donut"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
				<div class="pswp__share-tooltip"></div> 
			</div>
			<div class="pswp__caption">
				<div class="pswp__caption__center"></div>
			</div>
		</div>
	</div>
</div>

<script src="//cdn.bootcss.com/jquery/2.2.2/jquery.min.js"></script>
<script src="${backStatic}/js/common.js"></script>
<script src="${linkerStatic}/js/photoswipe.min.js"></script>
<script src="${linkerStatic}/js/photoswipe-ui-default.min.js"></script>
<script src="http://cdn.szzunhao.com/hongbao/js/jweixin-1.0.0.js" type="text/javascript"></script>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=3GJBZ-3SURO-6DVWN-SK5WL-YOG6H-3SF3H"></script>
<script>
var stage ={};
var siteRoot="${siteRoot}";
window.location.search.slice(1).split("&").forEach(function(i){
    var key = i.split("=")[0], val = i.split("=")[1];
    if (key) {
        stage[key] = decodeURIComponent(val);
    }
})
var cdn_url ="${fns:getCosAccessHost()}";
var text_star = '<article class="new_house_model" unitid="xqy_bt_zw">'
var text_star_img = '<article class="new_house_model">'
var text_star_link = '<article class="new_house_model">'
var text_star_video = '<article class="new_house_model" unitid="xqy_bt_sp">'
var text_star_map = '<article class="new_house_model" unitid="xqy_bt_dt">'
var text_title_star = '<header class="p_tb10 p_lr20 new_house_comm_title">'
var text_title_end = '</header>'
var text_mian_start = '<section class="new_house_hidden p_tb10 p_lr20 white-space" style="white-space: pre-wrap;">'
var text_mian_start_hide = '<section class="p_tb10 p_lr20 line_height40 white-space" style="position: relative;">'
var text_mian_start_hux = '<section class="new_house_hidden new_house_hx_img new_house_hx p_tb10 white-space">'
var text_mian_start_link = '<section class="new_house_hidden new_house_hx p_tb10">'
var text_mian_end = '</section>'
var text_mian_more = '<p data-showif="1" class="text_center p_b20 p_t10 color_777a7a click_more"><i class="icon_big icon_db_bottom_arr m_r10"></i>更多</p>'
var text_end = '</article>'
var audioplayimg,audiostopimg;
var arr_hux=[];
var hxw=650;
var hxh=900;
var openPhotoSwipe = function(idx, items){
	var element = document.querySelector('.pswp');
	var options = {
		index: idx,
		history: false,
		focus: false,
		closeOnScroll: false,
		closeOnVerticalDrag: false,
		showAnimationDuration: 0,
		hideAnimationDuration: 0
	};
	var gallery = new PhotoSwipe(element, PhotoSwipeUI_Default, items, options);
	gallery.init();
};
$('#music_a').click(function(){
	var audio=$('#details_audio')[0];
	if(audio.paused){
		$(this).find('img').attr('src',audioplayimg);
		audio.play() ;
	}else{
		$(this).find('img').attr('src',audiostopimg);
		audio.pause();
	}
});
$.ajax({
	type:'get',
	url:'${siteRoot}/api/object/selectAllLinkerData',
	data:{
		objectId:stage.objectId
	},
	success:function(res){
		
		initShare(res);
		var bodyhtml ='';
		//右侧按钮
		var linkerRightButton = res.linkerRightButton;
		//正文模块
		var linkerTitleList = res.linkerTitleList
		var latitude,longitude,maptitle;
		//标题
		document.title = linkerRightButton.xqEntryTitle;
		// hack在微信等webview中无法修改document.title的情况
		var $iframe = $('<iframe src="/favicon.ico"></iframe>').on('load', function(){
			setTimeout(function(){$iframe.off('load').remove()}, 0);
		}).appendTo($('body'));
		$('.new_house_bg').css('background-image','url('+cdn_url+linkerRightButton.headerMapDetails+')');
		//语音
		if(linkerRightButton.yySyPage!=0&& linkerRightButton.yySyPage!=3 && linkerRightButton.yyEntryTitle!=''){
			audioplayimg=cdn_url+linkerRightButton.yyEntryIcon
			audiostopimg=cdn_url+linkerRightButton.yyStopIcon
			$('#music_a').show().find('img').attr('src',audiostopimg);
			$('#details_audio').attr('src',cdn_url+linkerRightButton.musicUrl);
		}
		//正文模块
		 for(var i=0;i<linkerTitleList.length;i++){
			var reslist = linkerTitleList[i], hu_img={};
			arr_hux[i]=[];
			switch(reslist.titleType){
				case '1':
					for(var j=0;j<reslist.titletextList.length;j++){
						if(reslist.title !=''){
							bodyhtml+=text_star+text_title_star+reslist.title+text_title_end+text_mian_start+reslist.titletextList[j].text+text_mian_end+text_mian_more+text_end
						}
					}
					break;
				case '2':
					var c = "";
					for(var o=0;o<reslist.titletextList.length;o++){
						if(reslist.title !=''&& reslist.titletextList[o].text !=""&&reslist.titletextList[o].textImageUrl !=""){
							 c += '<li class="clear" unitid="xqy_bt_zwtp" data-index="'+o+'">'+reslist.titletextList[o].text+'<i class="icon_big icon_ccc_left_arr fr"></i></li>';
							 s=text_star_img+text_title_star+reslist.title+text_title_end+text_mian_start_hux+c+text_mian_end+text_mian_more+text_end
							 hu_img={
									"src":cdn_url+reslist.titletextList[o].textImageUrl,
									"w":hxw,
									"h":hxh
							};
							 //arr_hux[i][o]={};
							 arr_hux[i][o]=hu_img;
						}
					}
					if(s){
						bodyhtml+=s
					}
					
					break;
				case '3':
					var _htmla ="", _href = ""; 
					for(var k=0;k<reslist.titletextList.length;k++){
						_href = reslist.titletextList[k].textUrl?reslist.titletextList[k].textUrl:"javascript:void(0);"
						_htmla += '<a href="'+_href+'" unitid="xqy_bt_lj"><li class="clear">'+reslist.titletextList[k].text+'<i class="icon_big icon_ccc_left_arr fr"></i></li></a>'
						if(reslist.title !=''){
							var s=text_star_link+text_title_star+reslist.title+text_title_end+text_mian_start_link+ _htmla  +text_mian_end+text_mian_more+text_end
						}
					}
					if(s){
						bodyhtml+=s
					}
					break;
				case '4':
					if(reslist.title !=''){
						bodyhtml+=text_star_video+text_title_star+reslist.title+text_title_end+text_mian_start_hide+'<video id="video" style="width:100%" poster="${linkerStatic}/img/videoImg.png" src="'+cdn_url+reslist.videoUrl+'" controls="controls"  webkit-playsinline="true" preload="none"></video>'+text_mian_end+text_end
					}
					break;
				case '5':
					if(reslist.title !=''){
						latitude = reslist.longitude;
						longitude=reslist.latitude;
						
						bodyhtml+=text_star_map+text_title_star+reslist.title+text_title_end+text_mian_start_hide+'<div id="maps" style="width:100%;height:4rem"></div>'+text_mian_end+text_end
					}
					break;
				default:
					break;
			}
		} 
		//地图
		for(var l=arr_hux.length-1;l>=0;l--){
			if(arr_hux[l].length ==0){
				arr_hux.splice(l, 1)
			}
		}
		if(latitude){
			var init = function() {
				var center = new qq.maps.LatLng(latitude,longitude);
				var map = new qq.maps.Map(document.getElementById('maps'),{
					center: center,
					zoom: 16,
					disableDefaultUI: true
				});
	
				var anchorsa = new qq.maps.Point(16, 42),
						size = new qq.maps.Size(32, 42),
						origin = new qq.maps.Point(0, 0),
						icon = new qq.maps.MarkerImage("${linkerStatic}/img/mo.png",size, origin,anchorsa);
				var marker = new qq.maps.Marker({
					icon: icon,
					map: map,
					position:map.getCenter()});
				var infoWin = new qq.maps.InfoWindow({
					map: map
				});
	
				/* qq.maps.event.addListener(marker,"click",function(e){
					infoWin.open();
					infoWin.setContent('<div style="font-size:14px"><p>名称:'+resdata.companyName+'</p><p>地址:'+resdata.address+'</p></div>');
					infoWin.setPosition(center);
				}) */
			}
			
		}
		if(linkerRightButton.postfixText !=''){
			var phonefooter =linkerRightButton.postfixText.match(/\d+/g)
			bodyhtml += '<div class="jun-height-44" style="height:80px;"></div>'+
			'<footer class="jun-newconnector-footer clear" style="border-top:1px solid #eee">'+
			'<p class="p_40 clear fz24"><img class="fl" style="width:3rem; height:1rem;" src="'+cdn_url+linkerRightButton.postfix+'">'+
			'<span class="fr" style="margin-top:22px;">商务热线:<a unitid="xqy_lxdh" href="tel:'+phonefooter+'"><span style="color:#00ccff">'+linkerRightButton.postfixText+'</span></a></span></p>'+
			'</footer>';
		}
		$('body').append(bodyhtml);
		$('.new_house_hx_img').each(function(i){
			var arr_huxe = arr_hux[i];
			$(this).find('li').click(function(){
				openPhotoSwipe($(this).index(), arr_huxe);
			});
		});
		if(latitude){
		init();
		}
		 $('.click_more').click(function(){
			if($(this).data('showif') ==1){
				$(this).siblings('.new_house_hidden ').addClass('hight_more');
				//$(this).find('i').removeClass('icon_db_bottom_arr').addClass('icon_db_up_arr')
				$(this).html('<i class="icon_big icon_db_up_arr m_r10"></i>收起');
				$(this).data('showif','0')
			}else{
				$(this).siblings('.new_house_hidden ').removeClass('hight_more');
				//$(this).find('i').removeClass('icon_db_up_arr').addClass('icon_db_bottom_arr')
				$(this).html('<i class="icon_big icon_db_bottom_arr m_r10"></i>更多');
				$(this).data('showif','1')
			}
		 });
		 if($('#video').length > 0){
			 $('#video')[0].play(); 
		 }
		 $("body").on("click", "[unitid]", function(e){
			var _this =$(this),
				videoPaused = _this.siblings('#video');
			var data={
	   				'page': 'xqy',
	       			'id':_this.attr('unitid'),
	       			'linkerId':linkerId
	    		};
   			pointajaxdate({
   				'data':data,
   				'complete':function(){
   					if(_this.context.nodeName=='A'){
   						var url = _this.attr('href');
							if(url.indexOf('http') > -1 || url.indexOf('https') > -1||url.indexOf('tel:') > -1){
	   	    				url = url;
	   	    			}else if(url =='javascript:void(0);'){
	   	    				return;
	   	    			}else {
	   	    				url = window.location.origin+ url;
	   	    			}
   						window.location.href = url;
   					} else if(videoPaused.length > 0){
   						alert(videoPaused[0]);
   						if(videoPaused[0].paused){
   							videoPaused[0].play();
   						} else {
   							videoPaused[0].pause();
   							/* $('.videoMaskLayer').css({
   		    					'background-image':"url('${panoStatic}/img/ic_play.png')",
   			    				'background-size':'10%'
   			    			}); */
   						}
   					}
				}
		 	})
		 });
	}
})
</script>
<script>

var itemssa_img =[]
/*$.ajax({
	type:'get',
	url:baseparam.baseurl+'/Connector/Activity/getActivityDetail',
	data:{
		type:getUrlParam('type')
	},
	success:function(res){
		var $body = $('body');
		var resdata = res.data
		var lihtml='';
		var videohtml =''
		document.title = resdata.activityTitle
		// hack在微信等webview中无法修改document.title的情况
		var $iframe = $('<iframe src="/favicon.ico"></iframe>').on('load', function(){
			setTimeout(function(){
				$iframe.off('load').remove()
			}, 0)
		}).appendTo($body)
		$('.new_house_bg').css('background-image','url('+resdata.headImg+')')
		$('.new_house_name').text(resdata.activityName)
		if(!resdata.introTitle){
			$('#infomian').hide()
		}
		$('#infotitle').text(resdata.introTitle)
		$('#infotext').text(resdata.intro)
		if(resdata.videoArea.list){
		for(var v=0;v<resdata.videoArea.list.length;v++){
			videohtml+='<article class="new_house_model"><header class="p_tb10 p_lr20 new_house_comm_title">'+resdata.videoArea.list[v].videoTitle+'</header><section class=" p_tb10 p_lr20 line_height40"><video style="width:100%" src="'+resdata.videoArea.list[v].videoSrc+'" webkit-playsinline="true" controls="controls" preload="none"></video></section></article>'
		}
		}
		$(videohtml).appendTo('#videodiv')
		if(!resdata.imageAreaTitle){
			$('#imglistmian').hide()
		}
		if(!resdata.latitude){
			$('#mapmian').hide()
		}
		$('#imglisttitle').text(resdata.imageAreaTitle)
		if(resdata.imageArea.list){
			for(var i=0;i<resdata.imageArea.list.length;i++){
				itemssa_img[i] = {}
				itemssa_img[i].src = resdata.imageArea.list[i].imageSrc
				itemssa_img[i].w = hxw
				itemssa_img[i].h = hxh
				lihtml += '<li class="clear">'+resdata.imageArea.list[i].imageTitle+'<i class="icon_big icon_ccc_left_arr fr"></i></li>'
			}
		}
		$(lihtml).appendTo('#new_house_hx')
		$('#new_house_hx').on('click','li',function(){
			var cao =$(this).index()
			var openPhotoSwipe = function() {
				var pswpElement = document.querySelectorAll('.pswp')[0];
				var options = {
					history: false,
					focus: false,
					closeOnScroll:false,
					closeOnVerticalDrag:false,
					showAnimationDuration: 0,
					hideAnimationDuration: 0
				};
				options.index = cao
				var gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, itemssa_img, options);
				gallery.init();
			};
			openPhotoSwipe()
			gallery.close();
		})


		var init = function() {
			var center = new qq.maps.LatLng(resdata.latitude,resdata.longitude);
			var map = new qq.maps.Map(document.getElementById('maps'),{
				center: center,
				zoom: 16,
				disableDefaultUI: true
			});

			var anchorsa = new qq.maps.Point(16, 42),
					size = new qq.maps.Size(32, 42),
					origin = new qq.maps.Point(0, 0),
					icon = new qq.maps.MarkerImage("../images/mo.png",size, origin,anchorsa);
			var marker = new qq.maps.Marker({
				icon: icon,
				map: map,
				position:map.getCenter()});
			var infoWin = new qq.maps.InfoWindow({
				map: map
			});

			qq.maps.event.addListener(marker,"click",function(e){
				infoWin.open();
				infoWin.setContent('<div style="font-size:14px"><p>名称:'+resdata.companyName+'</p><p>地址:'+resdata.address+'</p></div>');
				infoWin.setPosition(center);
			})
		}
		init();

		$('#iphone').html('<a href="tel:'+resdata.contactPhone+'"></a>'+resdata.contactPhone+'('+resdata.contactMan+')')
	}
})*/




//113.93632,22.52344
</script>

<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var linkerId="${objectId}";
wx.config({
	debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	appId : '${signature["appid"]}', // 必填，公众号的唯一标识
	timestamp : '${signature["timestamp"]}', // 必填，生成签名的时间戳
	nonceStr : '${signature["noncestr"]}', // 必填，生成签名的随机串
	signature : '${signature["signature"]}',// 必填，签名，见附录1
	jsApiList : ['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareTimeline','onMenuShareQQ','onMenuShareWeibo' ,'onMenuShareQZone']
// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
});

function initShare(linkerData){
	var title=linkerData.linkerShare.shareEntryTitle;
	var desc=linkerData.linkerShare.shareBewrite;
	var link=location.host+"/linker/" + linkerId;
	var imgUrl='${fns:getCosAccessHost()}'+linkerData.linkerShare.squareMap;
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
}
function saveShareLog(d){
	$.post("${siteRoot}/api/data/shareLog",d,function(data){
		
	});
}

</script>
</body>
</html>