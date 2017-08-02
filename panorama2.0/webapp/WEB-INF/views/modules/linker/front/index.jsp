<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>${object.topTitle}</title>
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=yes" name="format-detection">
    <meta name="x5-fullscreen" content="true">
    <meta name="full-screen" content="yes">
    <link rel="stylesheet" href="${linkerStatic}/css/common.css?v=1.0">
    <link rel="stylesheet" href="${panoStatic}/css/main.css?v=1.1" type="text/css" />
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
        .sceneName{
        	position: absolute;
		    left: 0;
		    right: 0;
		    display:none;
		    max-width:120px;
		    max-height:16px;
		    margin: 10px auto;
		    overflow:hidden;
		    color: #fff; 
		    text-align: center;
    		text-shadow: 2px 0px 5px #000;
        }
        .sandViewClo {
        	float:right;
        	margin-top:-55px;
        }
        .sandBigImgMain-points {
        	position: relative;
        }
        .shapan_del{
			width:0.7rem;
			height:1.16rem;
			background:url('${linkerStatic}/img/design_clock.png') no-repeat center;
			background-size:contain;
			z-index:1000;
			position:absolute;
			left:5.95rem;
			/* top:2.98rem; */
			top:2.7rem;
		}
    </style>
    <script>
    	var siteRoot="${siteRoot}";
    	var linkerStatic="${linkerStatic}";
    	var cdn_url = '${fns:getCosAccessHost()}';
    	var audio_project = new Audio();//项目介绍音乐
    	var audio_point=new Audio();//点位音乐
    	var audio_scene=new Audio();//单个场景语音
    	var linkerData;
    	var haveweifenzu=false;//判断是否有未分组
        (function (doc, win) {
            var docEl = doc.documentElement,
                //判断窗口有没有orientationchange这个方法，有就赋值给一个变量，没有就返回resize方法。
                resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
                recalc = function () {
                    var clientWidth = docEl.clientWidth;
                    if (!clientWidth) return;
                    //把document的fontSize大小设置成跟窗口成一定比例的大小，从而实现响应式效果。
                    if(clientWidth<700){
                    	docEl.style.fontSize = 100 * (clientWidth / 750) + 'px';
                    }else{
                    	docEl.style.fontSize ="100px";
                    }
                    
                };
            if (!doc.addEventListener) return;
            win.addEventListener(resizeEvt, recalc, false);
            doc.addEventListener('DOMContentLoaded', recalc, false)
        })(document, window);
    </script>
</head>
<body>
<div class="maskes"></div>
<div class="wraperss" style="display:none;">
	<p></p>
	<div></div>
</div>
<div id="container" class="conta">
	<div style="line-height:.32rem;width:2rem;height:.32rem;position:absolute;left:0.45rem;top:0.65rem;color:#fff;font-size:.22rem;text-shadow: 2px 0px 5px #000;">人气: ${accessTimes}</div>
	<!-- 左上logo重写 -->
	<div class="left-logos"></div>
	<iframe id="tencentMapPano" style="display:none;"></iframe>
	<div class="sceneName"></div>
     <audio id="point-muisc-player" preload='none'></audio>
     
     <div id="headimg_wraper" style="display:none;">
    	<div id="headimg" class="headimg"></div>
    	<p class="headtx ellipsis" id="headtx"></p>
    	<a class="tels" href="javascript:void(0);">联系</a>
    </div>
    
     <article class="banner_right">
    
    <a class="icon-div" id="icon_details" pointsid = "sy_xq" href="javascript:void(0);">
        <i class="gopng gopng_detail"></i>
        <p>项目介绍</p>
    </a>
    <a class="icon-div" href="javascript:void(0);" pointsid = "sy_yyjs">
    	<audio id="audio" class="audio-common">
    		<source>
    		您的浏览器不支持 audio 标签。
    	</audio>
        <i class="gopng gopng_sound" style="border-radius:.32rem;"></i>
        <p>语音介绍</p>
    </a>
    
    <a class="icon-div" href="javascript:void(0);" pointsid = "sy_yqdy" >
        <i class="gopng gopng_represent"></i>
        <p>一起代言</p>
    </a>
    <a class="icon-div" href="javascript:void(0);"  pointsid = "sy_lxdh">
        <i class="gopng gopng_iphone"></i>
        <p>联系电话</p>
    </a>
    <a class="icon-div" href="javascript:void(0);" pointsid = "sy_gd">
        <i class="gopng gopng_more"></i>
        <p>更多</p>
    </a>
    <!-- <a class="icon-div zan" href="javascript:void(0);" style="display:none;" pointsid = "sy_dz">
        <i class="gopng gopng_like"></i>
        <p></p>
    </a> -->
    <!--右侧 卡券按钮 -->
	<a class="kaquans" href="javascript:void(0);" style='display:none;width:1.2rem;height:0.9rem;margin-top:.15rem;margin-top: .1rem;'>
		<i class="kaquans_icon"></i>
	        <p style="text-align:center;padding-left:.25rem;"></p>
	</a>
</article>

	<div class="banner_bottom" style="display:none;">
		<a class="changjing fl" href="javascript:void(0);" style="height:100%;-webkit-flex:1; ">
	        <i class="changjing_icon mb2"></i>
	        <p>场景</p>
	    </a>
	    <a class="detailes fl" href="javascript:void(0);" style="height:100%;-webkit-flex:2;display:none; padding-left:.24rem;">
	        <i class="detailes_icon"></i>
	        <p style="overflow:hidden;">房源详情</p>
	    </a>
	    <a class="shapan fl" href="javascript:void(0);" style="height:100%;-webkit-flex:2;display:none;">
	        <i class="shapan_icon"></i>
	        <p style="overflow:hidden;">沙盘</p>
	    </a>
	    <a class="hongbaos fl" href="javascript:void(0);" style="height:100%;-webkit-flex:2;display:none;">
	        <i class="hongbaos_icon" style="border-radius:.35rem;"></i>
	        <p style="overflow:hidden;"></p>
	    </a>
	    <a class="songs fl" href="javascript:void(0);" style="height:100%;-webkit-flex:2;">
	        <i class="songs_icon"></i>
	        <p style="overflow:hidden;">语音</p>
	    </a>
	    <a class="daiyans fl" href="javascript:void(0);" style="height:100%;-webkit-flex:2;padding-right:.24rem;">
	        <i class="daiyans_icon"></i>
	        <p style="overflow:hidden;">一起代言(<span></span>)</p>
	    </a>
	    <a class="dianzans fl" href="javascript:void(0);" style="height:100%;-webkit-flex:1;">
	        <i class="dianzans_icon"></i>
	        <p><span></span></p>
	    </a>
	</div>
	
	
 </div>
 <div id="display-point-info-mdl" class="modal" role="dialog" aria-labelledby="pointInfo"></div>

<article class="banner_left"></article>
<article class="desin-left"  style='display:none;'>
   <i class="gopng gopng_heart" id="click_like" pointsid = "sy_axdz"></i>
   <p id="like_num" style="text-shadow: 2px 0px 5px #000"></p>
</article>
<div id="bg">
	<div id="banner" class="common-banner">
        <img class="colse design-colse" src="${linkerStatic}/img/design_clock.png">
        <div class="banersimg">
        	<a pointsId = "sy_fc">
        		<img/>
        		<p></p>
        	</a>
        </div>
	</div>
</div>
<div class="sandBigImg" style="display:none;">
	<div class="sandBigImg-main">
		<div class="sandBigImgMain-points">
			<img class="sandViewClo" src='${linkerStatic}/img/design_clock.png' width="30px"/>
		</div>
		
	</div>
</div>

<!--沙盘右上角隐藏按钮 -->
<div class="shapan_del" style="display:none;">
	
</div>
	
<audio class="audio-common"  style="display:none;" id="background_music" loop="loop">您的浏览器不支持 audio 标签。</audio>
<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
<%-- <script type="text/javascript" src="${panoStatic}/js/pano_api1.js"></script>  --%>

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
<script type="text/javascript" src="${backStatic}/js/common.js?v=1.1"></script>
<script type="text/javascript" src="${backStatic}/js/jquery.qrcode.min.js?v=1.1"></script>
<script>
	var isCarousel="${object.isCarousel}";//是否自动切换照片,0:不切换,1:切换
	var autorotationTypes;
	var oTime=null;
	var group;
	var _group=null;
	var xinGroup;
	var idxx;
	var idxx1;
	var linkerData;
	var linkerId="${object.id}";
	var albumId="${object.albumId}";
	var _createAudioglobal = $('#background_music').get(0);
	var panoType="${object.panoType}";//'zoomingPano' or 'tencentPano'
	var tencentPanoUrl="${object.tencentPanoUrl}";
    $(function () {
    	var pano;
    	var _img = "${linkerStatic}/img/like_num_img.png";
    	$('body').width(window.innerWidth);
        $('body').height(window.innerHeight);
        $(window).resize(function (e) {
            $('body').width(window.innerWidth);
            $('body').height(window.innerHeight);
        });
        $('.sandViewClo').click(function(){
        	$('.sandBigImg').fadeOut();
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
        	/* autorotationTypes=data.linkerLeftButton.autorotationType; */
        	autorotationTypes='1';
    		linkerData = data;
    		
    		$(".songs_icon").css({"background-images":'url('+cdn_url+data.linkerRightButton.yyEntryIcon+')',"background-size":"contain"});
    		$(".songs>p").html(data.linkerRightButton.yyEntryTitle);
    		$(".hongbaos_icon").css({"background-images":'url('+cdn_url+data.linkerRightButton.hbEntryIcon+')',"background-size":"contain"});
    		console.log(linkerData);
    		 if(linkerData.project.scene_groups){
    			if(linkerData.project.scene_groups.length>1&&linkerData.project.scene_groups[0].title=="未分组"){
    				haveweifenzu=true;
    			}
    		}
    		if(panoType =="zoomingPano"){
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
		 	idxx=index;
		 	idxx1=index;
		 	for(var i=0;i<data.project.scene_groups.length;i++){
		 		for(var j=0;j<data.project.scene_groups[i].scenes.length;j++){
		 			if(data.project.scene_groups[i].scenes[j].id==data.project.scenes[index].id){
			 			xinGroup=i;
			 		}
		 		}
		 	}
    		if(linkerData.linkerObject.start != 0){
    			pano.project.enable_overlook = true;
    		}
    		//自动幻灯片
    		if(linkerData.linkerObject.isCarousel == 1){
    			pano.autoPlayState = true;
    		}
    		pano.run(index);
    		var _setTime=null;
    		function setTimeDate(){
    			if(globalVar){
    				addData(linkerData,pano);
    				//自动幻灯片
    				if(linkerData.linkerObject.isCarousel == 1){
    					pano.autoPlay(pano);
    	    		}
	    			clearTimeout(_setTime);
	    		}else{
	    			_setTime= setTimeout(setTimeDate,500);
	    		}
    			
    		}
    		setTimeDate();
        }
    	function addData(dt,pano){
    		$('.sceneName').show();
    		//左侧按钮
    		if(panoType != 'zoomingPano'){
    			var cornerDeck = '<div class="corner-deck" style="margin-top:10px;"><div class="sand-table-view"><img crossorigin ="Anonymous" id="sand-table-pic" class="left"/></div><ul><li class="music" pointsid="sy_yy"></li></ul><audio autoplay class="bg_music_player"></audio></div>';
    			$(cornerDeck).appendTo($('.conta')); 
    			
    			$('.banner_right').css('top','43px');
    		}
    		//数据埋点
    		$('body').on('click','[pointsid]',function(e){
    			e.preventDefault();
    			var _this = $(this);
    			var data={
    				'page': 'sy',
        			'id':_this.attr('pointsid'),
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
	   					}
    				}
    			});
    		});
    		
    		if(panoType ==="zoomingPano"){
    			//相册单独埋点
        		$('.ul-imgs').on('click','img',function(e){
        			var data={
            			'page': 'sy',
                		'id':'sy_cjxc',
                		'linkerId':linkerId
            		};
        			pointajaxdate({
        				'data':data
        			});
        		});
    			//VR进入时长统计与VR点击次数
        		var inVrTime = null,
        			vrStae = false,
        			initNumber=0;
        		$('.vr-switch').click(function(){
        			vrStae=true;
        			/* inVrTime = new Date().getTime();
        			console.log(inVrTime); */
        			inVrTime = setInterval(function(){
        				++initNumber;
        			},1000);
        			var data={
                			'page': 'sy',
                    		'id':'sy_vr',
                    		'linkerId':linkerId
                		};
            			pointajaxdate({
            				'data':data
            			});
        			return false;
        		});
        		$('body').on('click','.vr-exit',function(e){
        			vrStae = false;
        			/* var outVrTime = new Date().getTime();
        			var second = Math.round((outVrTime - inVrTime)/1000); */
        			clearInterval(inVrTime);
        			var data = {
       					'linkerId': linkerId,
       					'sceneId': pano.getCurrScene().id,
       					'time': initNumber
        			};
        			if(initNumber >= 1){
        				$.post('${siteRoot}/api/data/vrUseLog',data);
        			}
        			inVrTime=null;
        			initNumber=0;
        			return false;
        		});
        		
        		$('.group-bar').on('click','.scene_group_desc',function(){
        			var _that = $(this);
        			if(_that.hasClass('select')){
        				return;
        			} else {
        				var sandStae = $('#sandTableViewBig').is(':hidden');
        				if(!sandStae){
        					$('#sandTableViewBig').hide();
        					$('.sand-table').addClass('off');
        				}
        			}
        		});
    		}
    		//页面可见
    		document.addEventListener('visibilitychange', function(){
    			if(vrStae){
    				$('.vr-exit').trigger('click');
    			}
    		}, false);
    		//即将离开当前页面
    		window.addEventListener('beforeunload', function(e) {  
				if(vrStae){
					$('.vr-exit').trigger('click');
    			}
    		},false);
    		
    		/* 下方按钮场景点击 */
    		$(".changjing").click(function(){
    			$('.custom-bottom-bar .cutover').trigger('click');
    			var bottomBarNumber = parseInt($('.custom-bottom-bar').css('height').replace('px',''));
    			if(bottomBarNumber!==0){
    				$('.banner_right').animate({'bottom':'1.54rem'},350);
    			}else {
    				$('.banner_right').animate({'bottom':'3.14rem'},350);
    			}
    		});
    		
    		/* 替换下方按钮图标与文字 */
    		if(dt.linkerRightButton.xqEntryTitle){
    			$(".detailes_icon").css({"background-images":'url('+cdn_url+dt.linkerRightButton.xqEntryIcon+')',"background-size":"contain"})
        		$(".detailes>p").html(dt.linkerRightButton.xqEntryTitle);
    			/* 下方按钮房源详情 */
                $(".detailes").click(function(){
                	window.location.href="${siteRoot}/linker/details?objectId="+linkerId+"&linkerName=${object.objectName}&fopenId=${ownerMpUser.openId}";
                });
    		}
    		 $(".daiyans_icon").css({"background-images":'url('+cdn_url+dt.linkerRightButton.yqdyEntryIcon+')',"background-size":"contain"})
    		 $(".daiyans>p").html(dt.linkerRightButton.yqdyEntryTitle+'('+'${togetherCount}'+')');
    		 /* 一起代言 */
    		$(".daiyans").click(function(){
    			window.location.href="${siteRoot}/linker/together/"+linkerId;
    		});
    		 
           $(".shapan").click(function(){
        	   if(pano.project.sandTableMap!=undefined){
               	var loadGetSceneGrounpId = pano.project.scenes[idxx1].sceneGroup.id;
                var loadStb = pano.project.sandTableMap[loadGetSceneGrounpId];
                   if(loadStb){
                	   $(".sand-table").click();
                	   $(".shapan_del").show();
                	   /* $('.sandTableViewBig').click(); */
                   	/* $(".sand-table").show(); */
                   }else {
                   /* 	$(".sand-table").hide(); */
                   }
               }
           });
           
           /*点击关闭沙盘  */
           $(".shapan_del").click(function(){
        	   $(this).hide();
        	   $(".sandTableView").hide();
           });
           
           /* canvas转成img */
           function convertCanvasToImage(canvas){
        	     var image = new Image();
        	     image.src = canvas.toDataURL("image/png");
        	     return image;
        	}
           
           /* 右侧自定义按钮点击弹出二维码 */
           $("body").on("click",".zidingyi_annius",function(){
        	   var _index=$(this).index();
        	   console.log(_index);
        	   if(dt.linkerCustomButtons){
        		   if(dt.linkerCustomButtons[_index-5].zdyanType=='1'){
        			   $(this).removeAttr("href");
        			   $(".maskes").show();
       				   $(".wraperss").show();
       			   	   $('.wraperss>div').qrcode(dt.linkerCustomButtons[_index-5].zdyanUrl);
       			   	   var canvas=document.getElementsByClassName("wraperss")[0].getElementsByTagName("div")[0].getElementsByTagName("canvas")[0];
       			   	   var img=convertCanvasToImage(canvas);
       			   	 $('.wraperss>div>canvas').remove();
       			   	  $(".wraperss>div").append(img);
        		   }
        	   }
           });
           
           
           $("body").on("touchstart",".wraperss>p",function(e){
        	   e.stopPropagation();
        	   $(".wraperss>div>img").remove();
        	   $(".wraperss").css("display","none");
        	   $(".maskes").css("display","none");
           });
           
           /* 下方语音按钮 */
           $(".songs").click(function(){
        	   if(audio_scene.paused){
        		   audio_point.pause();
           		   audio_scene.play();
           		   $(".songs_icon").css({"background":'url('+cdn_url+dt.linkerRightButton.yyStopIcon+') no-repeat center',"background-size":"cover"});
           		   
           		if(!audio_project.paused){
           			audio_project.pause();
             		$(".gopng_sound").css({
           				'background':"url("+ cdn_url + dt.linkerRightButton.musicEntryIcon+") no-repeat center","background-size":"cover"
         	   		});
        		}
           		
           	   }else{
           		   audio_scene.pause();
           		 $(".songs_icon").css({"background":'url('+cdn_url+dt.linkerRightButton.yyEntryIcon+') no-repeat center',"background-size":"cover"});
           	   }
           });
           
           /* 下方按钮点赞 */
           $(".dianzans").one("click",function(){
        	   $.post("${siteRoot}/api/object/LinkerlikeNum?id=" + linkerId,function(result){
				    if(result.code == 0000){
				    	 $(".dianzans_icon").css({
				    		 "background":"url('${backStatic}/images/icon_dianzans_yes.png') no-repeat center","background-size":"cover"
			   			});
				    	 $(".dianzans>p>span").html(parseInt('${totalLikeNum}')+1);
				    } else{
				    	alert("失败");
				    }
				 });
           });
           
           /* 右侧卡券按钮 */
           $(".kaquans").click(function(){
        	   window.location.href=dt.linkerRightButton.kqUrl;
           });
           
           /* 下方按钮红包 */
           $(".hongbaos").click(function(){
        	   window.location.href=dt.linkerRightButton.hbUrl;
           });
           
           /* 头像点击  跳转到设置 */
           $("#headimg").click(function(){
        	   if('${ownerMpUser.openId}'){
        		   window.location.href="./toSetting?linkerId=" + linkerId + "&fopenId=${ownerMpUser.openId}";
        	   }else{
        		   window.location.href="./toSetting?linkerId=" + linkerId;
        	   }
           });
    		
    		var _iconData = $('.icon-div'), _cornerDeck = $('.corner-deck');
    		//头像与名称
    		if('${ownerMpUser.openId}'){
    			var img = "${ownerMpUser.zdyHeadImgUrl}";
    			var showImg = cdn_url + img;
    			if(img.indexOf("http:") != -1){
    				showImg = img;
    			}
    			$('#headimg').css({
    				/* 固定头像 */
					'background-image':"url("+showImg+")",
    				'background-size':'cover',
    				'background-repeat':'no-repeat'
    			});
    			$('#headtx').html("${ownerMpUser.zdyNickname}");
    			var tempPhone = "${ownerMpUser.mobile}";
    			if(tempPhone.indexOf("转")!= -1){
    				tempPhone = tempPhone.replace("转",",");
    			}
    			$(".tels").attr("href","tel:"+tempPhone);
    		}else{
    			$('#headimg').css({
    				/* 固定头像 */
					'background-image':"url("+ cdn_url + dt.linkerShare.headImageUrl+")",
    				'background-size':'cover',
    				'background-repeat':'no-repeat'
    			});
    			$('#headtx').html(dt.linkerShare.fixedName);
    			$(".tels").attr("href","tel:"+dt.linkerShare.telephone);
    		}
    		//项目介绍
    		
    		if(dt.linkerRightButton.xqEntryTitle){
    			/* _iconData.eq(0).show(); */
    			_iconData.eq(0).attr('href',"");
    			_iconData.eq(0).children('i').css({
	    					'background-image':"url("+ cdn_url + dt.linkerRightButton.xqEntryIcon+")",
		    				'background-size':'contain'
		    			});
    			_iconData.eq(0).children('p').html(dt.linkerRightButton.xqEntryTitle);
    		}
    		//音乐介绍
    		if(dt.linkerRightButton.musicUrl){
    			_iconData.eq(1).show();
    			_iconData.eq(1).children('i').css({
  					'background-image':"url("+ cdn_url + dt.linkerRightButton.musicEntryIcon+")",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(1).children('p').html(dt.linkerRightButton.musicEntryTitle);
    			//$("#audio").attr("src",cdn_url + dt.linkerRightButton.yyUrl);
    			audio_project.src=cdn_url + dt.linkerRightButton.musicUrl;//音乐的url
    			_iconData.eq(1).find('i').click(function(){
    				var _autio = $("#audio")[0], _music = $('#background_music')[0];
    				audio_point.pause();
    				if(!_music.paused){
    					_music.pause();
    					$('.music').css({
               				'background-image':"url(" + cdn_url + dt.linkerRightButton.musicEntryTitle+")"
             	   		});
    				}
    				
    				if(!audio_scene.paused){
    					audio_scene.pause();
    					$(".songs_icon").css({"background":'url('+cdn_url+dt.linkerRightButton.yyEntryIcon+') no-repeat center',"background-size":"cover"});
    				}
    				
            		if(audio_project.paused){
            			audio_project.play();
            			$(this).css({
          					'background-image':"url("+ cdn_url + dt.linkerRightButton.musicStopIcon+")"
        	   			});
            		}else{
            			audio_project.pause();
                 		$(this).css({
               				'background-image':"url("+ cdn_url + dt.linkerRightButton.musicEntryIcon+")"
             	   		});
            		}
           			 
            	});
    			//_iconData.eq(1).find('i').trigger('click');
    		};
    		
    		/* 卡券显示或隐藏 */
    		if(dt.linkerRightButton.kqUrl){
    			$(".kaquans").css("display","block");
    			$(".kaquans_icon").css({"background-image":"url("+ cdn_url + dt.linkerRightButton.kqEntryIcon+")","background-size":"contain"});
    			$(".kaquans>p").html(dt.linkerRightButton.kqEntryTitle);
    		}
    		
    		//一起代言
    		if('${togetherImage}'){
        		$(".daiyans_icon").css({'background-image':'url('+"${togetherImage}"+')','background-size':'contain'});
    		}else{
        		$(".daiyans_icon").css({'background-image':'url('+cdn_url+dt.linkerRightButton.yqdyEntryIcon+')','background-size':'contain'});
    		}
    		$(".daiyans>p>span").html(dt.linkerObject.totalTogetherNum);
    		
    		/* 底部房源详情显示或隐藏 */
    		if(dt.linkerRightButton.fyType!=null){
    			$(".detailes").show();
    		} else {
    			$(".detailes").remove();
    		}
    		
    		/* 底部红包按钮显示或隐藏 */
    		if(dt.linkerRightButton.hbUrl){
    			$(".hongbaos").show();
    		} else {
    			$(".hongbaos").remove();
    		}
    		
    		
    		
    		/* 点赞 */
    		$(".dianzans>p>span").html("${totalLikeNum}");
    		
    		
    		if(dt.linkerRightButton.yqdyEntryTitle){
    			/* _iconData.eq(2).show();  */
    			_iconData.eq(2).attr('href', "${siteRoot}/linker/together/"+linkerId);
    			_iconData.eq(2).children('i').css({
  					'background-image':"url("+ cdn_url + dt.linkerRightButton.yqdyEntryIcon+")",
	   				'background-size':'contain'
	   			});
    			_iconData.eq(2).children('p').html(dt.linkerRightButton.yqdyEntryTitle);
    		};
    		//联系电话
    		
    		
    		if(dt.linkerRightButton.dhEntryTitle){
    			/* _iconData.eq(3).show(); */
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
    		/* if(dt.linkerRightButton.likeType == 1 ){
    			$('.zan').attr({"href": "javascript:void(0);"});
    			$('.zan').show();
    			$('.zan').find('i').css({
  					'background-image':"url(" + cdn_url + "/material/sys/linker/13.png')",
	   				'background-size':'contain'
	   			});
    			$('.zan').find('p').html('${object.totalLikeNum}');
    			var _state = true;
    			$('.zan').find('i').click(function(){
    				var data={
                			'page': 'sy',
                    		'id':'sy_dz',
                    		'linkerId':linkerId
                		};
            			pointajaxdate({
            				'data':data
            			});
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
    		};  */
    		//下方按钮
    		if(dt.linkerButtonBelows){
    			var _html="",_len = dt.linkerButtonBelows.length<=2? dt.linkerButtonBelows.length: 2;
    			for(var i=0;i < _len;i++){
    				var _href = dt.linkerButtonBelows[i].xfanUrl? dt.linkerButtonBelows[i].xfanUrl: "javascript:void(0);",
    					num = i+1;;
    				_html += "<a class=\"icon-div\" style=\"display: inline-block; \" pointsid=\"sy_xfan"+ parseInt(num) +"\" href=\""+ _href + "\"><i class=\"gopng\" style=\" background-image: url("  + cdn_url + dt.linkerButtonBelows[i].xfanEntryIcon+"); background-size: contain;\""+"></i> <span>"+ dt.linkerButtonBelows[i].xfanEntryTitle+"</span></a>";
    			}
    			var _div = $('<div class="linkerButtonBelows" style="z-index: 10;position: absolute;"></div>');
    			_div.append(_html);
    			_div.css('bottom',$('.custom-bottom-bar').height()+'px');
    			$('#container').append(_div);
    		};
    		//自定义按钮
    		 if(dt.linkerCustomButtons){
    			var _html="", l=0, _rightIcon = $('.banner_right .icon-div');
    			for(var i=0; i<_rightIcon.length; i++){
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
        					var num = i+1;
        				_html += "<a class=\"icon-div zidingyi_annius\" style=\"display:block\" pointsid=\"sy_zdyan"+ parseInt(num) +"\" href=\""+ _href + "\"><i class=\"gopng\" style=\" background-image: url("  + cdn_url + dt.linkerCustomButtons[i].zdyanEntryIcon+"); background-size: contain;\""+"></i> <span>"+ dt.linkerCustomButtons[i].zdyanEntryTitle+"</span></a>";
        			}
        			_rightIcon.eq(_rightIcon.length-1).before(_html);
    			}
    		}; 
    		//720图标
    		if(dt.linkerLeftButton.topLeftLogo){
    			/* $('.sand-table-view').css({"position":"absolute","top":"-0.52rem","left":"-5.6rem"});
    			$('.sand-table-view').show();
    			$('#sand-table-pic').attr('src', cdn_url + dt.linkerLeftButton.topLeftLogo); */ 
    			
    			/* 重写左上logo */
    			$(".left-logos").show();
    			$(".left-logos").css({'background':'url('+cdn_url+dt.linkerLeftButton.topLeftLogo+') no-repeat center',"background-size":"contain"})
    		};
    		
    		//语音
   			/* if(dt.linkerLeftButton.yyUrl){
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
       		}; */
       		
       		
       		
       		
        	if(panoType ==="zoomingPano"){
        		//陀螺仪
        		if(dt.linkerLeftButton.sjtlyType == 1){
        			 _cornerDeck.find('li').eq(2).show();
        			 $(".tuoluoyi-title").show();
        		}else {
        			_cornerDeck.find('li').eq(2).hide();
        		}
        		//自动旋转
        		if(autorotationTypes == 1){
        			_cornerDeck.find('li').eq(4).click();
        		} else {
        			_cornerDeck.find('li').eq(3).hide();
        		}
        		//VR
        		if(dt.linkerLeftButton.vrShowingsType == 1){
        			_cornerDeck.find('li').eq(5).show();
        			 $(".vr-title").show();
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
    			if (sessionStorage.getItem("imgkey") != '1') {
        			sessionStorage.setItem("imgkey", 1);
        			$('#bg').show();
        			
        		} else {
        			$('#bg').hide();
        		}
    			if(dt.linkerObject.floatingShowTogetherNum){
    				$('.banersimg').find('p').html("${togetherCount}");
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
    				/* $('.desin-left').show(); */
    				pano.likeImgOff=linkerStatic+"/img/like_num_on.png";
    				pano.likeImgOn = linkerStatic+"/img/like_num_img.png";
    				pano.registerLikeClickEvent('click_like','like_num');
    				pano.refreshLikeNum();
            	}
    		}
    		initWxApi(linkerData);
			complete();
    	}
    	
    	$('.design-colse').on('click',function(){
    		$('#bg,.design-colse').fadeOut();
    		return false;
    	});
    	$('.banner_bottom a').eq(1).css('padding-left','.24rem');
    });
  
    function complete(){
    	$('html').one("touchstart", function () {
    		$('#background_music').get(0).play();
    	});
    	$("body").one("touchstart", function () {
    		$('#background_music').get(0).play();
    	});
    	$('#background_music').get(0).play();
    }
    
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

<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
wx.config({
	debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	appId : '${signature["appid"]}', // 必填，公众号的唯一标识
	timestamp : '${signature["timestamp"]}', // 必填，生成签名的时间戳
	nonceStr : '${signature["noncestr"]}', // 必填，生成签名的随机串
	signature : '${signature["signature"]}',// 必填，签名，见附录1
	jsApiList : ['getLocation','onMenuShareTimeline','onMenuShareAppMessage','onMenuShareTimeline','onMenuShareQQ','onMenuShareWeibo' ,'onMenuShareQZone']
// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
});
function isWeiXin(){
    var ua = window.navigator.userAgent.toLowerCase();
    if(ua.match(/MicroMessenger/i) == 'micromessenger'){
        return true;
    }else{
        return false;
    }
}
function saveAccessLog(d){
	$.post("${siteRoot}/api/data/accessLog",d,function(data){
		
	});
}
function saveShareLog(d){
	$.post("${siteRoot}/api/data/shareLog",d,function(data){
		
	});
	
}
function initWxApi(linkerData){
	if(!isWeiXin()){
		var d={
			linkerId:linkerId	
		};
		saveAccessLog(d);
		return;
	}
	var title=linkerData.linkerShare.shareEntryTitle;
	var desc=linkerData.linkerShare.shareBewrite;
	var titleType =linkerData.linkerShare.titleType;
	//var link=location.host+"/linker/" + linkerId;
	var link = location.href;
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
	        },
	        trigger:function(res){
	        	if(titleType == 1){
	        		var obj = this;
		        	 $.ajax({
		     	        type: "GET",
		     	        url: "${siteRoot}/api/data/getShareNumBylinkerId",
		     	        data: {linkerId:linkerId},
		     	        async:false,
		     	        success: function (data) {
		     	        	var str = obj.title;
			        		str = str.replace(/x/i, data);
			        		obj.title = str;
		     	        }
		     	    }); 
	        	}
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
	        },
	        trigger:function(res){
	        	if(titleType == 1){
	        		var obj = this;
		        	 $.ajax({
		     	        type: "GET",
		     	        url: "${siteRoot}/api/data/getShareNumBylinkerId",
		     	        data: {linkerId:linkerId},
		     	        async:false,
		     	        success: function (data) {
		     	        	var str = obj.title;
			        		str = str.replace(/x/i, data);
			        		obj.title = str;
		     	        }
		     	    }); 
	        	}
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
		   },
	        trigger:function(res){
	        	if(titleType == 1){
	        		var obj = this;
		        	 $.ajax({
		     	        type: "GET",
		     	        url: "${siteRoot}/api/data/getShareNumBylinkerId",
		     	        data: {linkerId:linkerId},
		     	        async:false,
		     	        success: function (data) {
		     	        	var str = obj.title;
			        		str = str.replace(/x/i, data);
			        		obj.title = str;
		     	        }
		     	    }); 
	        	}
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
	    	},
	        trigger:function(res){
	        	if(titleType == 1){
	        		var obj = this;
		        	 $.ajax({
		     	        type: "GET",
		     	        url: "${siteRoot}/api/data/getShareNumBylinkerId",
		     	        data: {linkerId:linkerId},
		     	        async:false,
		     	        success: function (data) {
		     	        	var str = obj.title;
			        		str = str.replace(/x/i, data);
			        		obj.title = str;
		     	        }
		     	    }); 
	        	}
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
	      	},
	        trigger:function(res){
	        	if(titleType == 1){
	        		var obj = this;
		        	 $.ajax({
		     	        type: "GET",
		     	        url: "${siteRoot}/api/data/getShareNumBylinkerId",
		     	        data: {linkerId:linkerId},
		     	        async:false,
		     	        success: function (data) {
		     	        	var str = obj.title;
			        		str = str.replace(/x/i, data);
			        		obj.title = str;
		     	        }
		     	    }); 
	        	}
	        }
	    });
	  
	  	wx.getLocation({
		    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
		    success: function (res) {
		        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
		        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
		        tencentMapAddress({
		        	latitude:latitude,
		        	longitude:longitude,
		        	complete:function(result){
		        		var addressComponents=result.detail.addressComponents;
		        		var country=addressComponents.country;
		        		var province=addressComponents.province;
		        		var city=addressComponents.city;
		        		var district=addressComponents.district;
		        		var street=addressComponents.street;
		        		var d={
		        			linkerId:linkerId,
		        			country:country,
		        			province:province,
		        			city:city,
		        			county:district,
		        			street:street,
		        			latitude:latitude,
				        	longitude:longitude,
				        	openId:'${mpUser.openId}'
		        		};
		        		saveAccessLog(d);
		        	}
		        });
		    },
		    cancel: function () {
				//这个地方是用户拒绝获取地理位置
		    	var d={
		    		linkerId:linkerId,
		        	openId:'${mpUser.openId}'
		    	};
		    	saveAccessLog(d);
			}
		}); 
	});
}
</script>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp"></script>
<script>
(function(){
	var latLng=null;
	var geocoder=null;
	function tencentMapAddress(opts){
        this.init(opts);
        this.run();
	}
	tencentMapAddress.prototype={
		init:function(opts){
			latLng = new qq.maps.LatLng(opts.latitude,opts.longitude);
			geocoder = new qq.maps.Geocoder({
		        complete : opts.complete
		    });
		},
		run:function(){
			geocoder.getAddress(latLng);
		}
	};
	window.tencentMapAddress = function(opts){
        return new tencentMapAddress(opts);
    };
})(window,document);

</script>
</body>
</html>