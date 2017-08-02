<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <meta name='apple-mobile-web-app-capable' content='yes' />
	    <script>
		    !(function(win, doc) {
	            var viewPort = doc.querySelector('meta[name="viewport"]');
	            if(viewPort){
	            	doc.head.removeChild(viewPort);
	            }
	            var devicePixelRatio = win.devicePixelRatio,
					isIPhone = win.navigator.appVersion.match(/iphone/gi),
					initScale=1.0;
				if(isIPhone){
					if (devicePixelRatio >= 3) {                
		                dpr = 3;
		            } else if (devicePixelRatio >= 2){
		                dpr = 2;
		            } else {
		                dpr = 1;
		            }
					initScale = 1 / dpr;
					doc.write('<meta content="initial-scale='+ initScale +', maximum-scale='+ initScale +', user-scalable=0" name="viewport" />');
				} else { 
					doc.write('<meta content="width=device-width, initial-scale='+ initScale +', maximum-scale='+ initScale +', user-scalable=0" name="viewport" />');
				}
		    }(window, document));
		</script>
	    <meta content="black" name="apple-mobile-web-app-status-bar-style" />
	    <meta content="telephone=no" name="format-detection" />
	    <meta name="x5-fullscreen" content="true">
		<meta name="full-screen" content="yes">
	    <title>全景房源</title>
	    <meta name="keywords" content="" />
	    <link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
 	    <link type="text/css" href="${backStatic}/css/styleyc.css" rel="stylesheet">
	    <style type="text/css">
	    	html,body {
	    		height:100%;
	    	}
	    	input::-webkit-input-placeholder, textarea::-webkit-input-placeholder { 
				color: #a6a6a6; 
			} 
			input:-moz-placeholder, textarea:-moz-placeholder { 
				color: #a6a6a6; 
			} 
			input::-moz-placeholder, textarea::-moz-placeholder { 
				color: #a6a6a6; 
			} 
			input:-ms-input-placeholder, textarea:-ms-input-placeholder { 
				color: #a6a6a6; 
			}
	    	::-webkit-input-placeholder {
				/* WebKit browsers */
				color: #999;
			}
			
			:-moz-placeholder {
				/* Mozilla Firefox 4 to 18 */
				color: #999;
			}
			
			::-moz-placeholder {
				/* Mozilla Firefox 19+ */
				color: #999;
			}
			
			:-ms-input-placeholder {
				/* Internet Explorer 10+ */
				color: #999;
			}
			.sort {
				position:fixed;
			}
			.p-search,
			.sortList {
				position:relative;
			}
			.p-search {
				padding-top: .2rem;
    			padding-bottom: .2rem;
			}
			.p-search {
				border-bottom:1px solid #e7e7e7;
			}
			.p-search span,
			.sort .sortBtn {
				position:absolute;
			}
			.p-search span,
			.icon,
			.sort .sortBtn span {
				display:block;
			}
			.sort {
				width:100%;
				bottom: 0;
			    left: 0;
			    right: 0;
			    z-index:16;
			    margin: 0 auto;
			}
			.icon_sort {
				width:.28rem;
				height:.28rem;
				background:url(${linkerStatic}/img/zhongYuan/iconSortDefault.png) no-repeat center center;
				background-size:contain;
				margin:0 auto;
			}
			.p-search span {
				top:0;
				bottom:0;
				right:.23rem;
				z-index:-1;
				width:.6rem;
				height:.42rem;
				margin:auto 0;
				color:#999;
				font-size:.3rem;
			}
			.p-search input {
				z-index:11;
	    		width: 7.06rem;
	    		height:.66rem;
	    		padding-left:1.2rem;
	    		padding-right:.7rem;
	    		margin-left:.22rem;
	    		margin-right:.22rem;
	    		font-size:.26rem;
	    		line-height:.66rem;
	    		text-align:center;
	    		background:url(${linkerStatic}/img/zhongYuan/search.png) #eeeff3 no-repeat 28% center;
	    		background-size:5%;
	    		border-radius:2px;
	    		border:none;
	    		transition:all .25s ease-out;
				-webkit-transition:all .25s ease-out;
			}
			.p-search.active input {
	    		width:6.19rem;
	    		padding-left:.7rem;
	    		padding-right:.3rem;
	    		text-align:left;
	    		background-position: 4% center;
	    	}
	    	.sort.active .sortBtn {
	    		background:rgba(0,0,0,1);
	    		color:rgba(255,255,255,.5);
	    	}
	    	.sort.active .sortBtn .icon_sort {
	    		background:url(${linkerStatic}/img/zhongYuan/iconSortTouchstart.png) no-repeat center center;
				background-size:contain;
	    	}
	    	.sort .sortBtn {
	    		right: .32rem;
	    		bottom:.34rem;
	    		z-index:22;
	    		width:1.02rem;
	    		height:1.02rem;
	    		padding: .25rem;
	    		color:#fff;
	    		font-size:.18rem;
	    		text-align:center;
	    		background:rgba(0,0,0,.5);
	    		border-radius:50%;
	    		box-shadow: 0 0 3px #000;
	    	}
	    	.sort .sortBtn span{
	    		margin-top:.05rem;
	    	}
	    	.sortList {
	    		z-index:111;
	    		display:none;
	    		background-color:#fff;
	    		text-align:center;
	    	}
	    	.sortList ul li {
	    		width:7.5rem;
	    		color:#2a2a2a;
	    		font-size:.3rem;
	    	}
	    </style>
	    <script>
		    !(function(win, doc) {
		        function setFontSize() {
		            var docEl = doc.documentElement;
		            var winWidth = docEl.clientWidth;
		            doc.documentElement.style.fontSize = (winWidth / 750) * 100 + 'px';
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
		    }(window, document));
		</script>
	</head>
<body>
	<header class="GZH">
		<div class="p-search">
			<span>取消</span>
			<input type="text" placeholder="请输入小区/房源关键字" />
		</div>
		<div class="GZH-requirement">
			<div class="GZH-requirement-title">
				<h4 data-text="城"><em class="active">城市</em><i></i></h4>
				<h4 data-text="总"><em>总价</em><i></i></h4>
				<h4 data-text="户"><em>户型</em><i></i></h4>
			</div>
			<ul style="display:none;" class="GZH-requirement-list">
			</ul>
		</div>
	</header>
	<div style="display:none;" class="GHZ-mask"></div>
	<div class="GZH-main">
		<ul></ul>
	</div>
	<div class="sort">
		<div class="sortBtn">
			<i class="icon icon_sort"></i>
			<span>排序</span>
		</div>
		<div class="sortList">
			<ul>
				<li class="active">默认</li>
				<li>最新发布</li>
				<li>总价从低到高</li>
				<li>总价从高到低</li>
				<li>单价从低到高</li>
				<li>单价从高到低</li>
				<li>面积从低到高</li>
				<li>面积从高到低</li>
			</ul>
		</div>
	</div>
	
<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
<script>
	$(function(){
		'use strict';
		window.initConfig = {
			cdn_url:'${fns:getCosAccessHost()}',
			initShowMain: $('.GZH-main ul'),
			initWidth: $(document).width(),
			initHeight: $(document).height(),
			requirementList: $('.GZH-requirement-list'),
			requirementTitle: $('.GZH-requirement-title'),
			endSearch: $('.p-search span'),
			startSearch: $('.p-search input'),
			defaultPic: '${backStatic}/images/defaluePic.jpg',
			mask: $('.GHZ-mask'),
			sortBtn: $('.sortBtn'),
			sort: $('.sort'),
			sortList: $('.sortList'),
			data:null,
			houseCity:'',
			price:'<li>200万以下</li><li>200-300万</li><li>300-500万</li><li>500-800万</li><li>800-1000万</li><li>1000万以上</li>',
			housType:'<li>一室</li><li>二室</li><li>三室</li><li>四室</li><li>五室</li><li>五室以上</li>',
			houseIndex:0,
			requirementTitleIndex:null,
			houseTag:['满两年','满五年','红本在手','学位房','学区房','地铁物业','南北通透'],
			addEvent:(function(win,doc){
				if(document.addEventListener){
					return function(el,type,fn){
						if(el.length){
							for(var i=0,list; list = el[i++];){
								win.initConfig.addEvent(list,type,fn);
							}
						}else{
								el.addEventListener(type,fn,false);
						}
					};
				}else{
					return function(el,type,fn){
						if(el.length){
							for(var i=0, list; list = el[i++];){
								win.initConfig.addEvent(list,type,fn);
							}
						}else{
							el.attachEvent('on'+type,function(){
								return fn.call(el,win.event);
							});
						}
				   };
			  }
		  })(window,document)
		}
		initConfig.addEvent(initConfig.sortBtn[0],'touchstart',function(){
			$(this).parent().addClass('active');
			return false;
		});
		initConfig.addEvent(initConfig.sortBtn[0],'touchend',function(){
			$(this).siblings().slideToggle().parent().removeClass('active');
			initConfig.mask.fadeToggle();
			return false;
		});
		initConfig.addEvent(initConfig.sortList.find('li'),'click',function(){
			var _that = $(this);
			_that.addClass('active').siblings().removeClass('active');
			_that.parents('.sortList').slideToggle().removeClass('active');
			initConfig.mask.fadeToggle();
			return false;
		});
		initConfig.requirementList.on('click','li',function(){
			
		});
		initConfig.addEvent(initConfig.requirementTitle.find('h4'),'click',function(){
			var _that = $(this),
				_thatIndex = _that.index(),
				_thatDataText = _that.attr('data-text'),
				_thatSiblings = _that.siblings();
			if(initConfig.requirementTitleIndex == _thatIndex){
				initConfig.requirementList.fadeOut();
				initConfig.mask.fadeOut();
				initConfig.requirementTitleIndex = null;
				_that.removeClass('active');
				return false;
			}
			_that.addClass('active').siblings().removeClass('active');
			_thatSiblings.find('em').removeClass('cur');
			if(_thatDataText == '城'){
				$.post('./selectCity',function(data){
					if(data.code==0){
						for(var i=0, len=data.list.length;i<len; i++){
							initConfig.houseCity+='<li>不限</li><li>'+data.list[i]+'</li>';
						}
						initConfig.requirementList.html(initConfig.houseCity);
					}
				});
			} else if(_thatDataText == '总'){
				initConfig.requirementList.html(initConfig.price);
			} else if(_thatDataText == '户'){
				initConfig.requirementList.html(initConfig.housType);
			}
			for(var i=0, list; list = _thatSiblings[i++];){
				if($(list).find('em').text() != '城市' && $(list).attr('data-text') == '城'){
					$(list).find('em').text('城市');
				} else if($(list).find('em').text() != '总价' && $(list).attr('data-text') == '总'){
					$(list).find('em').text('总价');
				} else if($(list).find('em').text() != '户型' && $(list).attr('data-text') == '户'){
					$(list).find('em').text('户型');
				}
			}
			initConfig.sort.css('z-index',5);
			initConfig.requirementTitleIndex = _thatIndex;
			initConfig.requirementList.fadeIn();
			initConfig.mask.fadeIn();
			return false;
		});
		//搜索
		initConfig.startSearch.focus(function(){
			var _that = $(this);
			_that.val("");
			_that.parent().addClass('active');
		}).blur(function(){
			var _that = $(this);
			_that.val("");
			_that.parent().removeClass('active');
		});
		initConfig.startSearch.on('keypress',function(e) {
			/* var parsentsEle = parseInt($(this).parents('.GHZ-search-Show').css('top').replace('px',"")); */
			var keycode = e.keyCode,
            	searchName = $(this).val().trim(); 
	            if(keycode=='13') {
		                e.preventDefault();
		                if(!searchName){
		                	return false;
		                }
		                initShowMain.html("");
		                var data = {
		        			"currPage":1,
		        			"pageSize":5,
		        			"objectName":searchName
		                }
		                initConfig.data = data;
		                /* $.post('./queryObect',data,function(data){
		        			if(data.code == 0){
		        				var html="";
		        				if(data.list.length < 1){
		        					html ='<img style="width:1.54rem;height:2.48rem; max-width:100%;" src="${backStatic}/images/GZH-searchEnd.png"/>'
		        					initShowMain.append(html);
		        					initShowMain.css({'margin-top':'50%','margin-left':'40%'});
		        					return false;
		        				}
		        				if(dataIndex==0){
		        					var buildAreaHtml="";
		        					for(var i=0,len=data.list.length;i<len; i++){
		        						if(data.list[i].coverImgUrl){
		       								defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
		       							}
		        						if(data.list[i].buildArea){
		        							buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
		       							}
			        					html += '<li><a href="${fns:getHost()}/linker/'+ data.list[i].objectId +'">'+
			        							'<div class="GHZ-main-list-img">'+
			        								'<img style="width:'+ initWidth +'px" alt="'+ data.list[i].name +'" src="'+ defaultPic +'">'+
			        								'<p>'+ data.list[i].name +'</p>'+
			        							'</div>'+
			        							'<div class="GHZ-main-list-title clear">'+
			        								'<h4>'+ data.list[i].county + buildAreaHtml +'</h4>'+
			        								'<span>'+data.list[i].averagePrice +'元/m²</span>'+
			        								'<p>'+ data.list[i].address +'</p>'+
			        							'</div>'+
			        						'</a>'+
			        					'</li>'
			        				}
		        				} else {
		        					for(var i=0,len=data.list.length;i<len; i++){
		        						if(data.list[i].coverImgUrl){
		       								defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
		       							}
			       						var tagLength = data.list[i].projectTag.length,
			   							tagHtml="",addressHtml = "",orientationsHtml="";
			      						if(data.list[i].projectTag){
			      							var listTagHtml = "";
			      							for(var j=0; j < tagLength;j++){
			    	   							if(/^\d$/.test(data.list[i].projectTag[j])){
			    	   								listTagHtml+='<b>'+ obj.oldHouseTag[data.list[i].projectTag[j]] +'</b>'
			    	   							}
			    	   						}
			      							if(data.list[i].address){
			      								tagHtml = '<div class="GHZ-main-list-title-tag">'+ listTagHtml +'</div>';
			      							} else {
			      								tagHtml = '<div class="GHZ-main-list-title-tag" style="width:70%;">'+ listTagHtml +'</div>';
			      							}
			      						}
			      						if(data.list[i].address){
			      							addressHtml = '<p style="width:80%;height: .45rem;overflow: hidden;">'+ data.list[i].address +'</p>';
			      						}
			      						if(data.list[i].orientations){
			      							orientationsHtml = '<i>|</i>'+ data.list[i].orientations;
			      						}
			      						html += '<li><a href="${fns:getHost()}/linker/'+ data.list[i].objectId +'">'+
			      								'<div class="GHZ-main-list-img">'+
			      									'<img style="width:'+ initWidth +'px" alt="'+ data.list[i].name +'" src="'+ defaultPic +'">'+
			      									'<p>'+ data.list[i].name +'</p>'+
			      								'</div>'+
			      								'<div class="GHZ-main-list-title clear">'+
			      								'<h4>'+ data.list[i].room +'房'+ data.list[i].hall +'厅<i>|</i><em>'+ data.list[i].buildArea +'m²</em>'+ orientationsHtml +'</h4>'+
			      									'<span>'+data.list[i].totalMoney +'万</span>'+addressHtml+
			      									'<span class="GHZ-main-list-titleSpan">'+data.list[i].averagePrice +'元/m²</span>'+tagHtml+
			      								'</div>'+
			      							'</a>'+
			      						'</li>'
			       					}
		        				}
		        				allPage = data.totalPage;
		        				initShowMain.append(html);
		        				initShowMain.css({'margin-top':'0','margin-left':'0'});
		        				
		        			}
		        		}); */
	            }
             
     	}); 
	});
</script>
</body>
</html>