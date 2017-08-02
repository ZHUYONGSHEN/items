<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>全景预览</title>
    <link rel="stylesheet" href="http://release.720.hiweixiao.com/SpecialConnector/css/common.css">
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=yes" name="format-detection">
    <meta name="x5-fullscreen" content="true">
    <meta name="full-screen" content="yes">
    <link rel="stylesheet" href="${panoStatic}/css/main.css" type="text/css" />
    <link rel="stylesheet" href="${panoStatic}/js/lib/bootstrap-3.3.6/dist/css/bootstrap.min.css">
    <style>
    	.main-btn-type {
		    color: white;
		    width: 70px;
		    height: 32px;
		    float: right;
		    line-height: 32px;
		    text-align: center;
		    position: absolute;
		    border-radius: 4px;
		    background-color: rgba(60, 60, 60, 0.8);
		    cursor: pointer;
		}
		#main-close-btn {
		    right: 20px;
		    top: 10px;
	    }
	    .corner-deck li{
    		height: 2.4rem;
    		width: 2.4rem;
    		margin-top: .4rem;
    	}
    </style>
    
</head>
<body>
	<div id="container">
        <audio id="point-muisc-player" preload='none'></audio>
        <div class="main-btn-type" id="main-close-btn">关闭</div>
    </div>
    <div id="display-point-info-mdl" class="modal" role="dialog" aria-labelledby="pointInfo"></div>
<script src="//cdn.bootcss.com/jquery/2.2.2/jquery.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/detect.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/utility.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/three.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/vr-base-effect.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/device-orientation-controls.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/spin.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/load.js"></script>
<script type="text/javascript" src="${panoStatic}/js/hot-point.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/touch.baidu/touch-0.2.14.min.js"></script>
<script type="text/javascript" src="${panoStatic}/js/lib/bootstrap-3.3.6/dist/js/bootstrap.min.js"></script>
<script>
    $(function () {
    	var linkerId="${id}";
    	var albumId="${albumId}";
    	var _state = true, pano, _img = "${linkerStatic}/img/like_num_img.png", cdn_url = 'http://720test-10037467.file.myqcloud.com';
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
                //nIdx = pano.getSceneIndex(id);
            }
            if (isNaN(index) || index === null || index === undefined){
            	index = 0;
            }
            return index;
        }
		/* $.get("${siteRoot}/pano/${albumId}",function(data){
			pano = new Panorama("container");
            pano.AddLoadFilishEvent(loadAllPoint(pano));
            pano.registScenechange(sceneChange);
            pano.reset(data);
            var index = getSceneIndex(pano);
            pano.run(index);
            countUserAction(pano.project.id, 'load');
		});	 */
		$('#main-close-btn').click(function (event) {
			var obj=window.parent.document.getElementById("scene_preview");
		    if(obj !== ""){
		    	obj.style.display="none";
		    	obj.src="";
		        window.parent.document.getElementsByClassName("mask")[0].style.display="none";
		        window.parent.document.body.style.overflow="initial";
		    }
		});
		$.get("${siteRoot}/object/selectAllLinkerData?objectId="+ linkerId,function(data){
    		var linkerData = data;
    		//if(linkerData.linkerRightButton){
                pano = new Panorama("container");
                pano.AddLoadFilishEvent(loadAllPoint(pano));
                pano.registScenechange(sceneChange);
        		 $.get("${siteRoot}/pano/"+albumId,function(data){
         				pano.reset(data);
             	        var index = getSceneIndex(pano);
             	       		//小行星
           	    		if(linkerData.linkerObject.start != 0){
           	    			pano.project.enable_overlook = true;
           	    		}
              	        pano.run(index);
           	         	addData(linkerData);
        			 
        	       //countUserAction(pano.project.id, 'load');
        	    });
    		//}
    		
    	});
    	
    	
    	function addData(dt){
    		var _iconData = $('.icon-div'), _cornerDeck =  $('.corner-deck'), _href = window.location.href;
    		//小行星
    		if(dt.linkerObject.start != 0){
    			pano.project.enable_overlook = true;
    		}
    		//头像与名称
    		if(dt.linkerRightButton.headType == 0){
    			$('#headimg').css({
					'background-image':"url("+ cdn_url + dt.linkerRightButton.headImageUrl+")",
    				'background-size':'contain'
    			});
    			$('#headtx').html(dt.linkerRightButton.fixedName);
    		}else{
    			$('#headimg').css({
					'background-image':"url('${mpUser.headImgUrl}')",
    				'background-size':'contain'
    			});
    			$('#headtx').html("${mpUser.nickname}");
    		}
    		//项目介绍
    		if(dt.linkerRightButton.xqEntryTitle){
    			_iconData.eq(0).show();
    			_iconData.eq(0).attr('href',"details?objectId="+linkerId);
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
  					'background-image':"url("+ cdn_url + dt.linkerRightButton.yyEntryIcon+")",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(1).children('p').html(dt.linkerRightButton.yyEntryTitle);
    			_iconData.eq(1).children('audio').attr({"src": cdn_url + dt.linkerRightButton.yyUrl, "autoplay": "autoplay"});
    			_iconData.eq(1).find('i').on('click',function(){
    				var _autio = $("#audio")[0];
            		if(_autio.paused){
            			_autio.play();
            			$(this).css({
          					'background-image':"url("+ cdn_url + dt.linkerRightButton.yyEntryIcon+")"
        	   			});
            			return;	
            		}
           			_autio.pause();
             		$(this).css({
           				'background-image':"url("+ cdn_url + dt.linkerRightButton.yyStopIcon+")"
         	   		}); 
            	});
    		};
    		//一起代言
    		if(dt.linkerRightButton.yqdyEntryTitle){
    			_iconData.eq(2).show();
    			_iconData.eq(2).attr('href', "together/"+linkerId);
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
    			_iconData.eq(4).show();
    			_iconData.eq(4).attr('href',dt.linkerRightButton.gdjcUrl);
    			_iconData.eq(4).children('i').css({
  					'background-image':"url("+ cdn_url + dt.linkerRightButton.gdjcEntryIcon+")",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(4).children('p').html(dt.linkerRightButton.gdjcEntryTitle);
    		};
    		//点赞
    		if(dt.linkerRightButton.likeType == 1 ){
    			var _state = true;
    			_iconData.eq(5).attr({"href": "javascript:void(0);"});
    			_iconData.eq(5).show();
    			_iconData.eq(5).find('i').css({
  					'background-image':"url(http://720test-10037467.file.myqcloud.com/material/sys/linker/default/13.png)",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(5).find('p').html(dt.linkerObject.likeNum);
    			_iconData.eq(5).find('i').on('click',function(){
    				if(_state){
    					$.post("${siteRoot}/object/LinkerlikeNum?objectId=" + linkerId,{id:dt.linkerObject.id},function(result){
        				    if(result.message == "点赞成功"){
        				    	_iconData.eq(5).find('i').css({
        		  					'background-image':"url("+ "http://720test-10037467.file.myqcloud.com/material/sys/linker/default/9.png"+")"
        			   			});
        				    	_iconData.eq(5).find('p').html(dt.linkerObject.likeNum+1);
        				    }
        				 });
    					_state = false;
    				}
    				
    			});
    		};
    		//自定义按钮
    		if(dt.linkerButtonBelows){
    			var _html="";
    			for(var i=0;i < dt.linkerButtonBelows.length;i++){
    				_html += "<a class=\"icon-div\" style=\"display: inline-block; \" href=\""+ dt.linkerButtonBelows[i].xfanUrl + "\"><i class=\"gopng\" style=\" background-image: url(" + cdn_url + dt.linkerButtonBelows[i].xfanEntryIcon+"; background-size: contain;\""+"></i> <span>"+ dt.linkerButtonBelows[i].xfanEntryTitle+"</span></a>";
    			}
    			$('.banner_left').html(_html);
    		};
    		//720图标
    		if(dt.linkerLeftButton.topLeftLogo){
    			_cornerDeck.children('.sand-table-view').show();
    			_cornerDeck.children('.sand-table-view').children('img').attr('src', cdn_url + dt.linkerLeftButton.topLeftLogo);
    		};
    		//语音
    		if(dt.linkerLeftButton.yyUrl){
    			var _createAudio = $('<audio style="display:none;">您的浏览器不支持 audio 标签。</audio>');
    			_cornerDeck.find('li').eq(0).show();
    			_cornerDeck.find('li').eq(0).html(_createAudio);
    			_cornerDeck.find('li').eq(0).css({
  					'background-image':"url("+ cdn_url + dt.linkerLeftButton.yyEntryIcon+")"
	   			});
    			_createAudio.attr('src', cdn_url + dt.linkerLeftButton.yyUrl);
    			_cornerDeck.find('li').eq(0).on('click',function(){
            		if(_createAudio[0].paused){
            			_createAudio[0].play();
            			$(this).css({
          					'background-image':"url("+ cdn_url + dt.linkerLeftButton.yyEntryIcon+")"
        	   			});
            			return;	
            		}
            		_createAudio[0].pause();
             		$(this).css({
           				'background-image':"url("+ cdn_url + dt.linkerLeftButton.yyStopIcon+")"
         	   		}); 
            	});
    		};
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
    		//浮层
    		if(dt.linkerObject.supernatantType == 1){
    			$('#bg').show();
    			$('.banersimg').find('a').attr('href', cdn_url + dt.linkerObject.floatingUrl);
    			$('.banersimg').find('img').attr('src', cdn_url + dt.linkerObject.floatingLayer);
    		}
    		//标题、描述
    		if(dt.linkerObject.objectName){
    			$(document).attr('title', dt.linkerObject.topTitle);
    			$('#description').attr('content', dt.linkerObject.objectSynopsis);
    		}
    	};
    	$('.design-colse').on('click',function(){
    		$('#bg,.design-colse').fadeOut();
    		return false;
    	});
	});
</script>
</body>
</html>