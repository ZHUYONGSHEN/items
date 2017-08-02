<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${object.topTitle}</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" id ="description" content="1111"/>
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=yes" name="format-detection">
    <meta name="x5-fullscreen" content="true">
    <meta name="full-screen" content="yes">
    <link rel="stylesheet" href="${linkerStatic}/css/common.css?v=1.0">
    <link rel="stylesheet" href="${panoStatic}/css/main.css?v=1.0" type="text/css" />
    <link rel="stylesheet" href="${panoStatic}/js/lib/bootstrap-3.3.6/dist/css/bootstrap.min.css">
    <style>
        *{
            padding: 0;
            margin: 0;
        }
        body {
            width: 100vw;
            height: 100vh;
        }
        .banner_left {
            position: fixed;
            left: 2%;
            bottom: 160px;
            z-index: 788;
        }
        a:link,a:visited,a:active,a:focus, a:hover{
	         text-decoration:none;
	         color:#fff;
        }
        .linkerButtonBelows{
       	    padding-left: .2rem;
   			padding-bottom: .2rem;
        }
        .linkerButtonBelows a {
        	padding-right: .1rem;
        }
        .gopng_like {
        	    background: url('${fns:getCosAccessHost()}/material/sys/linker/default/13.png') no-repeat center center;
        	    background-size:cover;
        }
    </style>
    <script>
	    var siteRoot="${siteRoot}";
		var linkerStatic="${linkerStatic}";
		var cdn_url = '${fns:getCosAccessHost()}';
		var audio_project = new Audio();//项目介绍音乐
		var audio_point=new Audio();//点位音乐
		var linkerData;
        (function (doc, win) {
            var docEl = doc.documentElement,
                //判断窗口有没有orientationchange这个方法，有就赋值给一个变量，没有就返回resize方法。
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    //把document的fontSize大小设置成跟窗口成一定比例的大小，从而实现响应式效果。
                    docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                };
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false)
        })(document, window);
    </script>
</head>
<body>
<div id="container">
	<iframe id="tencentMapPano" style="display:none;"></iframe>
	<div class="sceneName"></div>
     <audio id="point-muisc-player" preload='none'></audio>
     <article class="banner_right">
    <div id="headimg" class="headimg"></div>
    <p class="headtx" id="headtx"></p>
    <a class="icon-div" id="icon_details" href="">
        <i class="gopng gopng_detail"></i>
        <p>项目介绍</p>
    </a>
    <a class="icon-div">
    	<audio id="audio" class="audio-common">
    		<source>
    		您的浏览器不支持 audio 标签。
    	</audio>
        <i class="gopng gopng_sound"></i>
        <p>语音介绍</p>
    </a>
    <a class="icon-div" href="javascript:void(0);">
        <i class="gopng gopng_represent"></i>
        <p>一起代言</p>
    </a>
    <a class="icon-div">
        <i class="gopng gopng_iphone"></i>
        <p>联系电话</p>
    </a>
    <a class="icon-div" href="#">
        <i class="gopng gopng_more"></i>
        <p>更多</p>
    </a>
    <a class="icon-div zan" style="display:none;">
        <i class="gopng gopng_like"></i>
        <p></p>
    </a>
</article>
 </div>
 <div id="display-point-info-mdl" class="modal" role="dialog" aria-labelledby="pointInfo"></div>

<article class="banner_left"></article>
<article class="desin-left"  style='display:none;'>
   <i class="gopng gopng_heart" id="click_like"></i>
   <p id="like_num" style="text-shadow: 2px 0px 5px #000"></p>
</article>
<div id="bg">
	<div id="banner" class="common-banner">
        <img class="colse design-colse" src="${linkerStatic}/img/design_clock.png">
        <div class="banersimg">
        	<a>
        		<img/>
        		<p></p>
        	</a>
        </div>
	</div>
</div>
<div class="sandBigImg">
	<div class="sandBigImg-main">
		<div class="sandBigImgMain-points">
			<img class="sandViewClo" src='${linkerStatic}/img/design_clock.png'/>
		</div>
		
	</div>
</div>	
<audio class="audio-common"  style="display:none;" id="background_music" loop="loop">您的浏览器不支持 audio 标签。</audio>
<script src="//cdn.bootcss.com/jquery/2.2.2/jquery.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/detect.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/touch.baidu/touch-0.2.14.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/spin.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/bootstrap-3.3.6/dist/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/three.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/vr-base-effect.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/device-orientation-controls.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/circle-progress.js"></script>
<script type="text/javascript" src="${panoStatic}/js/utility.js"></script>
<script type="text/javascript" src="${panoStatic}/js/load.js?v=1.1"></script>
<script type="text/javascript" src="${panoStatic}/js/hot-point.js?v=1.1"></script> 
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script>
	var linkerData;
	var autorotationTypes;
	var linkerId="${object.id}";
	var albumId="${object.albumId}";
	var _createAudioglobal = $('#background_music').get(0);
	var panoType="${object.panoType}";//'zoomingPano' or 'tencentPano'
	var tencentPanoUrl="${object.tencentPanoUrl}";
    $(function () {
    	var sceneLikeNum;
    	var _state = true, pano, _img = "${linkerStatic}/img/like_num_img.png", cdn_url = '${fns:getCosAccessHost()}';
    	//window.location.hash = "#id=676881454b4440688cad3db9335ad50d";
    	$('body').width(window.innerWidth);
        $('body').height(window.innerHeight);
        $(window).resize(function (e) {
            $('body').width(window.innerWidth);
            $('body').height(window.innerHeight);
        });
        function sceneChange(id){
            window.location.hash = "#id=" + id;
        }
        function getSceneIndex(pano){
            var hash = window.location.hash;
            var index = 0;
            if (hash.indexOf("#id=") === 0) {
            	var sceneId = hash.substring(("#id=").length);
            	index =pano.project.scenesIndexMap[sceneId];
            }
            if (isNaN(index) || index === null || index === undefined){
            	index = 0;
            }
            return index;
        }
        $.get("${siteRoot}/api/linker/"+linkerId,function(data){
    		linkerData = data;
    		autorotationTypes=linkerData.linkerLeftButton.autorotationType;
    		console.log(linkerData);
    		if(panoType ==="zoomingPano"){
    			initPanorama({"project":linkerData.project,"cosAccessHost":linkerData.cosAccessHost});
    		} else {
    			$('#tencentMapPano').css({
    				"width":window.innerWidth,
    				"height":window.innerHeight,
    				"display":"block"
    			});
    			$('#tencentMapPano').attr('src',tencentPanoUrl);
    			addData(linkerData);
    		}
    		
    	});

        function initPanorama(data){
        	pano = new Panorama("container");
            pano.AddLoadFilishEvent(loadAllPoint(pano));
            pano.registScenechange(sceneChange);
		 	pano.reset(data);
		 	//小行星
		 	var index = getSceneIndex(pano);
    		if(linkerData.linkerObject.start != 0){
    			pano.project.enable_overlook = true;
    		}
    		pano.run(index);
    		var _setTime=null;
    		function setTimeDate(){
    			if(globalVar){
    				addData(linkerData,pano);
	    			clearTimeout(_setTime);
	    		}else{
	    			_setTime= setTimeout(setTimeDate,500);
	    		}
    			
    		}
    		setTimeDate();
        }
        function addData(dt,pano){
    		var _iconData = $('.icon-div'), _cornerDeck = $('.corner-deck');
    		//头像与名称
    		if(dt.linkerRightButton.headType == 0){
    			$('#headimg').css({
					'background-image':"url("+ cdn_url + dt.linkerRightButton.headImageUrl+")",
    				'background-size':'cover',
    				'background-repeat':'no-repeat'
    			});
    			$('#headtx').html(dt.linkerRightButton.fixedName);
    		}else{
    			$('#headimg').css({
					'background-image':"url('${mpUser.headImgUrl}')",
    				'background-size':'contain',
    				'background-repeat':'no-repeat'
    			});
    			$('#headtx').html("${mpUser.nickname}");
    		}
    		//项目介绍
    		if(dt.linkerRightButton.xqEntryTitle){
    			_iconData.eq(0).show();
    			_iconData.eq(0).attr('href',"${siteRoot}/linker/details?objectId="+linkerId);
    			_iconData.eq(0).children('i').css({
	    					'background-image':"url("+ cdn_url + dt.linkerRightButton.xqEntryIcon+")",
		    				'background-size':'contain'
		    			});
    			_iconData.eq(0).children('p').html(dt.linkerRightButton.xqEntryTitle);
    		}
    		//语音介绍
    		if(dt.linkerRightButton.yyEntryTitle){
    			_iconData.eq(1).show();
    			_iconData.eq(1).children('i').css({
  					'background-image':"url("+ cdn_url + dt.linkerRightButton.yyStopIcon+")",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(1).children('p').html(dt.linkerRightButton.yyEntryTitle);
    			//$("#audio").attr("src",cdn_url + dt.linkerRightButton.yyUrl);
    			audio_project.src=cdn_url + dt.linkerRightButton.yyUrl;
    			_iconData.eq(1).find('i').click(function(){
    				var _autio = $("#audio")[0], _music = $('#background_music')[0];
    				audio_point.pause();
    				if(!_music.paused){
    					_music.pause();
    					$('.music').css({
               				'background-image':"url(" + cdn_url + dt.linkerLeftButton.yyStopIcon+")"
             	   		});
    				}
            		if(audio_project.paused){
            			audio_project.play();
            			$(this).css({
          					'background-image':"url("+ cdn_url + dt.linkerRightButton.yyEntryIcon+")"
        	   			});
            		}else{
            			audio_project.pause();
                 		$(this).css({
               				'background-image':"url("+ cdn_url + dt.linkerRightButton.yyStopIcon+")"
             	   		});
            		}
           			 
            	});
    			//_iconData.eq(1).find('i').trigger('click');
    		};
    		//一起代言
    		if(dt.linkerRightButton.yqdyEntryTitle){
    			_iconData.eq(2).show();
    			_iconData.eq(2).attr('href', "${siteRoot}/linker/together/"+linkerId);
    			_iconData.eq(2).children('i').css({
  					'background-image':"url("+ cdn_url + dt.linkerRightButton.yqdyEntryIcon+")",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(2).children('p').html(dt.linkerRightButton.yqdyEntryTitle);
    		};
    		//联系电话
    		if(dt.linkerRightButton.dhEntryTitle){
    			_iconData.eq(3).show();
    			_iconData.eq(3).attr('href', "tel:"+ dt.linkerRightButton.telephone);
    			_iconData.eq(3).children('i').css({
  					'background-image':"url("+ cdn_url + dt.linkerRightButton.dhEntryIcon+")",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(3).children('p').html(dt.linkerRightButton.dhEntryTitle);
    		};
    		//更多精彩
    		if(dt.linkerRightButton.gdjcEntryTitle){
    			var _href = dt.linkerRightButton.gdjcUrl? dt.linkerRightButton.gdjcUrl:"javascript:void(0);";
    			_iconData.eq(4).show();
    			_iconData.eq(4).attr('href',_href);
    			_iconData.eq(4).children('i').css({
  					'background-image':"url("+ cdn_url + dt.linkerRightButton.gdjcEntryIcon+")",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(4).children('p').html(dt.linkerRightButton.gdjcEntryTitle);
    		};
    		//点赞
    		if(dt.linkerRightButton.likeType == 1 ){
    			$('.zan').attr({"href": "javascript:void(0);"});
    			$('.zan').show();
    			$('.zan').find('i').css({
  					'background-image':"url(" + cdn_url + "/material/sys/linker/13.png')",
	   				'background-size':'contain'
	   			});
    			$('.zan').find('p').html('${object.totalLikeNum}');
    			var _state = true;
    			$('.zan').find('i').click(function(){
    				if(_state){
    					$.post("${siteRoot}/api/object/LinkerlikeNum?id=" + linkerId,function(result){
        				    if(result.code == 0000){
        				    	$('.zan').find('i').css({
        		  					'background-image':"url("+ cdn_url +"/material/sys/linker/default/9.png)"
        			   			});
        				    	$('.zan').find('p').html(parseInt('${object.totalLikeNum}')+1);
        				    } else{
        				    	alert("失败");
        				    }
        				 });
    					_state = false;
    				}
    				return false;
    				
    			});
    		};
    		//下方按钮
    		if(dt.linkerButtonBelows){
    			var _html="",_len = dt.linkerButtonBelows.length<=2? dt.linkerButtonBelows.length: 2;
    			for(var i=0;i < _len;i++){
    				var _href = dt.linkerButtonBelows[i].xfanUrl? dt.linkerButtonBelows[i].xfanUrl: "javascript:void(0);";
    				_html += "<a class=\"icon-div\" style=\"display: inline-block; \" pointsid=\"sy_xfan"+ i +"\" href=\""+ _href + "\"><i class=\"gopng\" style=\" background-image: url("  + cdn_url + dt.linkerButtonBelows[i].xfanEntryIcon+"); background-size: contain;\""+"></i> <span>"+ dt.linkerButtonBelows[i].xfanEntryTitle+"</span></a>";
    			}
    			var _div = $('<div class="linkerButtonBelows" style="z-index: 10;position: absolute;"></div>');
    			_div.append(_html);
    			_div.css('bottom',$('.custom-bottom-bar').height()+'px');
    			$('#container').append(_div);
    		};
    		//自定义按钮
    		 if(dt.linkerCustomButtons){
    			var _html="", l=0, _rightIcon = $('.banner_right .icon-div');
    			for(var i=0; i<_rightIcon.length-1; i++){
    				var _hi = _rightIcon.eq(i).is(':hidden');
    				if(_hi){
    					++l;
    				}
    			}
    			if(l>0){
    				var _len = l<dt.linkerCustomButtons.length? l: dt.linkerCustomButtons.length;
    				if(_len>dt.linkerCustomButtons.length){
    					_len = dt.linkerCustomButtons.length;
    				}
        			for(var i=0; i< _len; i++){
        				var _href = dt.linkerCustomButtons[i].zdyanUrl!=""? dt.linkerCustomButtons[i].zdyanUrl: "javascript:void(0);";
        				_html += "<a class=\"icon-div\" style=\"display:block\" pointsid=\"sy_zdyan"+ i +"\" href=\""+ _href + "\"><i class=\"gopng\" style=\" background-image: url("  + cdn_url + dt.linkerCustomButtons[i].zdyanEntryIcon+"); background-size: contain;\""+"></i> <span>"+ dt.linkerCustomButtons[i].zdyanEntryTitle+"</span></a>";
        			}
        			_rightIcon.eq(_rightIcon.length-1).before(_html);
    			}
    		}; 
    		//720图标
    		if(dt.linkerLeftButton.topLeftLogo){
    			$('.sand-table-view').show();
    			$('#sand-table-pic').attr('src', cdn_url + dt.linkerLeftButton.topLeftLogo);
    		};
    		
    		//语音
   			if(dt.linkerLeftButton.yyUrl){
       			var _createAudio = $('#background_music');
       			_cornerDeck.find('li').eq(0).show();
       			//_cornerDeck.find('li').eq(0).html(_createAudio);
       			_cornerDeck.find('li').eq(0).css({
     					'background-image':"url("+cdn_url + dt.linkerLeftButton.yyEntryIcon+")"
   	   			});
       			_createAudio.attr('src', cdn_url + dt.linkerLeftButton.yyUrl);
       			_cornerDeck.find('li').eq(0).click(function(){
       				audio_point.pause();
       				if(!audio_project.paused){
       					audio_project.pause();
       					$('.gopng_sound').css({
                  				'background-image':"url("+ cdn_url + dt.linkerRightButton.yyStopIcon+")"
                	   		});
       				}
               		if(_createAudio[0].paused){
               			_createAudio[0].play();
               			$(this).css({
             					'background-image':"url("+ cdn_url + dt.linkerLeftButton.yyEntryIcon+")"
           	   			});
               			return;
               		}
                  		_createAudio[0].pause();
                  		$(this).css({
               			'background-image':"url(" + cdn_url + dt.linkerLeftButton.yyStopIcon+")"
              	   		}); 
               		
               	});
       		};
        	if(panoType ==="zoomingPano"){
        		//陀螺仪
        		if(dt.linkerLeftButton.sjtlyType == 1){
        			_cornerDeck.find('li').eq(2).show();
        		}else {
        			_cornerDeck.find('li').eq(2).hide();
        		}
        		//自动旋转
        		if(dt.linkerLeftButton.autorotationType == 1){
        			_cornerDeck.find('li').eq(3).show();
        		} else {
        			_cornerDeck.find('li').eq(3).hide();
        		}
        		//VR
        		if(dt.linkerLeftButton.vrShowingsType == 1){
        			_cornerDeck.find('li').eq(4).show();
        		} else {
        			_cornerDeck.find('li').eq(4).hide();
        		}
    		}
    		
    		//浮层
        	if(dt.linkerObject.supernatantType == 1 && dt.linkerObject.floatingLayer !=""){
    			console.log(dt.linkerObject);
    			var _href = dt.linkerObject.floatingUrl? dt.linkerObject.floatingUrl: "javascript:void(0);";
     			$('.banersimg').find('a').attr('href', _href);
     			$('.banersimg').find('img').attr('src', cdn_url + dt.linkerObject.floatingLayer);
    			/* if (sessionStorage.getItem("imgkey") != '1') {
        			sessionStorage.setItem("imgkey", 1);
        			$('#bg').show();
        			
        		} else {
        			$('#bg').hide();
        		} */
        		$('#bg').show();
    			if(dt.linkerObject.floatingShowTogetherNum){
    				$('.banersimg').find('p').html("${object.totalTogetherNum}");
    			}
    		}
    		//标题、描述
    		/* if(dt.linkerObject.objectName){
    			document.title = dt.linkerObject.topTitle;
    			var $iframe = $('<iframe src="/favicon.ico"></iframe>').on('load', function(){
    				setTimeout(function(){$iframe.off('load').remove()}, 0);
    			}).appendTo($('body'));
    			$('#description').attr('content', dt.linkerObject.objectSynopsis);
    		} */
    		//爱心点赞
    		if(panoType ==="zoomingPano"){
    			if(dt.linkerLeftButton.loveLike == 1){
    				$('.desin-left').show();
    				pano.likeImgOff=linkerStatic+"/img/like_num_on.png";
    				pano.likeImgOn = linkerStatic+"/img/like_num_img.png";
    				pano.registerLikeClickEvent('click_like','like_num');
    				pano.refreshLikeNum();
            	}
    		}
    	};
    	
    	$('.design-colse').on('click',function(){
    		$('#bg,.design-colse').fadeOut();
    		return false;
    	});
    });
    function fakeClick(fn) {
        var $a = $('<a href="#" id="fakeClick"></a>');
            $a.bind("click", function(e) {
                e.preventDefault();
                fn();
            });

        $("body").append($a);

        var evt, 
            el = $("#fakeClick").get(0);

        if (document.createEvent) {
            evt = document.createEvent("MouseEvents");
            if (evt.initMouseEvent) {
                evt.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
                el.dispatchEvent(evt);
            }
        }

        $(el).remove();
    }


</script>
</body>
</html>