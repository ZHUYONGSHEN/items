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
	    <title>街景找房</title>
	    <meta name="keywords" content="" />
	    <link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
 	    <link type="text/css" href="${backStatic}/css/styleyc.css" rel="stylesheet">
	    <style type="text/css">
	    	html,body {
	    		height:100%;
	    	}
	    	input::-webkit-input-placeholder, textarea::-webkit-input-placeholder { 
				color: #999; 
			} 
			input:-moz-placeholder, textarea:-moz-placeholder { 
				color: #999; 
			} 
			input::-moz-placeholder, textarea::-moz-placeholder { 
				color: #999; 
			} 
			input:-ms-input-placeholder, textarea:-ms-input-placeholder { 
				color: #999; 
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
			.bg{
				background-color:#fff;
			}
			.sort {
				position:fixed;
			}
			.p-search,
			.sortList,
			.p-searchHistory p i,
			.p-search input {
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
			.sort .sortBtn,
			.p-searchHistory {
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
			    z-index:113;
			    margin: 0 auto;
			}
			.icon_sort {
				width:.28rem;
				height:.28rem;
				background:url(${linkerStatic}/img/zhongYuan/iconSortDefault.png) no-repeat center center;
				background-size:contain;
				margin:0 auto;
			}
			.icon_del {
				width:.22rem;
				height:.24rem;
				background:url(${linkerStatic}/img/zhongYuan/icon_del.png) no-repeat center center;
				background-size:contain;
			}
			.p-search.active {
				background-color:#f6f6f8;
			}
			.p-search span {
				top:0;
				bottom:0;
				right:.23rem;
				z-index:1;
				width:.6rem;
				height:.42rem;
				margin:auto 0;
				color:#999;
				font-size:.3rem;
			}
			.p-search.active span{
				color:#666;
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
	    		background:url(${linkerStatic}/img/zhongYuan/search.png) #f4f4f4 no-repeat 28% center;
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
	    		color:#2a2a2a;
	    		text-align:left;
	    		background-color: #e9e9e9;
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
	    		background:rgba(0,0,0,.65);
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
	    	.sortList ul li,
	    	.p-searchHistory ul li {
	    		width:7.5rem;
	    		color:#2a2a2a;
	    		font-size:.3rem;
	    	}
	    	.p-searchHistory {
	    		top:1rem;
	    		right:0;
	    		left:0;
	    		z-index:114;
	    		display:none;
	    		width:100%;
	    		height:auto;
	    		background-color:#fff;
	    	}
	    	.p-searchHistory ul {
	    		max-height:3rem;
	    		padding-left:.22rem;
	    		overflow-y: auto;
    			overflow-x: hidden;
	    	}
	    	.p-searchHistory p{
	    		padding-top:.3rem;
	    		padding-bottom:.3rem;
	    		font-size:.26rem;
	    		color:#666;
	    		text-align:center;
	    	}
	    	.p-searchHistory p i {
	    		display:inline-block;
	    		top: .02rem;
	    		margin-right: .12rem;
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
		<div class="p-searchHistory">
			<ul>
			</ul>
			<p><i class="icon icon_del"></i><span>清空历史记录</span></p>
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
				<!-- <li>最新发布</li> -->
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
			$initShowMain: $('.GZH-main ul'),
			$initWidth: $(document).width(),
			$initHeight: $(document).height(),
			$requirementList: $('.GZH-requirement-list'),
			$requirementTitle: $('.GZH-requirement-title'),
			$endSearch: $('.p-search span'),
			$startSearch: $('.p-search input'),
			defaultPic: '${linkerStatic}/img/zhongYuan/defaluePic.jpg',
			$mask: $('.GHZ-mask'),
			$sortBtn: $('.sortBtn'),
			$sort: $('.sort'),
			$sortList: $('.sortList'),
			$searchHistory: $('.p-searchHistory'),
			data:{
				'currPage':1,
				'pageSize':5,
				'orderBy':0
			},
			houseCity:'',
			houseIndex:0,
			requirementTitleIndex:null,
			requirementListIndex:null,
			sortListIndex:null,
			searchHistoryData:{
				'currPage':1,
				'pageSize':5,
				'keyWord':null,
				'orderBy':0
			},
			searchPage:0,
			clearTime:null,
			dataPage:0,
			housType:['不限','一室','二室','三室','四室','五室','五室以上'],
			houseTag:['满两/满五','红本在手','学位房','地铁','南北通透','户型方正','随时看房','唯一住房','品牌开发商','刚需'],
			priceTag:['不限','200万以下','200-300万','300-500万','500-800万','800-1000万','1000万以上'],
			defaultEven:function(event){
			    event.preventDefault();
			},
			scrollEven:function(event){
				if($(document).scrollTop() >= $(document).height()-$(window).height()){
					if(initConfig.$requirementTitle.is('hidden')){
						initConfig.searchHistoryData.currPage++;
						if(initConfig.searchHistoryData.currPage <= initConfig.searchPage){
							$.post('./queryObect',initConfig.searchHistoryData,function(data){
								if(data.code != 0){
									return false;
								}
								initConfig.searcchRending(data,false,'append');
							});
						}
						
					} else {
						initConfig.data.currPage++;
						if(initConfig.data.currPage <=initConfig.dataPage){
							$.post('./queryObect',initConfig.data,function(data){
								if(data.code != 0){
									return false;
								}
								initConfig.searcchRending(data,true,'append');
							});
						}
						
					}
				}
			},
			searcchRending:function(data){
				var _html = '';
				for(var i=0,len= data.list.length;i<len; i++){
					var defPic = data.list[i].imgUrl ? initConfig.cdn_url + data.list[i].imgUrl : initConfig.defaultPic,
							listTagHtml = '';
					if(data.list[i].projectTag){
						var tagLength = '', orientationsHtml ='';
							tagLength = data.list[i].projectTag.length;
							for(var j=0; j < tagLength;j++){
								if(/^\d$/.test(data.list[i].projectTag[j])){
									listTagHtml+='<b>'+ initConfig.houseTag[data.list[i].projectTag[j]] +'</b>'
								}
							}
					}
					if(data.list[i].orientations){
						orientationsHtml = '<i>|</i>'+ data.list[i].orientations;
					}
					_html += '<li><a href="'+ data.list[i].objectUrl +'">'+
							'<div class="GHZ-main-list-img">'+
								'<img style="width:'+ initConfig.initWidth +'px" alt="'+ data.list[i].name +'" src="'+ defPic +'">'+
								'<p>'+ data.list[i].objectName +'</p>'+
							'</div>'+
							'<div class="GHZ-main-list-title clear">'+
							'<h4>'+ data.list[i].room +'房'+ data.list[i].hall +'厅<i>|</i><em>'+ data.list[i].buildArea +'m²</em>'+ orientationsHtml +'</h4>'+
								'<span>'+initConfig.priceTag[parseInt(data.list[i].totalMoney)] +'</span>'+
								'<span class="GHZ-main-list-titleSpan">'+data.list[i].averagePrice +'元/m²</span>'+
								'<div class="GHZ-main-list-title-tag" style="width:70%;height: .5rem;overflow: hidden;">'+ listTagHtml +'</div>'+
							'</div>'+
						'</a>'+
					'</li>';
				}
				if(!!arguments[1]){
					initConfig.searchPage = data.totalPage;
				} else {
					initConfig.dataPage = data.totalPage;
				}
				if(arguments[2] && arguments[2] == 'append' ){
					initConfig.$initShowMain.append(_html);
				} else {
					initConfig.$initShowMain.html(_html);
				}
				
			},
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
		$.post('./queryObect',initConfig.data,function(data){
			if(data.code != 0){
				return false;
			}
			initConfig.searcchRending(data,false);
		});
		initConfig.$endSearch.on('click',function(){
			$(this).parent().removeClass('active');
			$('body').removeClass('bg');
			initConfig.$requirementTitle.parent('.GZH-requirement').fadeIn();
			initConfig.$sort.fadeIn();
			initConfig.$startSearch.val('');
			$('.GZH-main').css('padding-top','2rem');
			initConfig.data.currPage = 1;
			initConfig.searchHistoryData.currPage = 1;
			initConfig.$initShowMain.css({'margin-top': '0','margin-left': '0'});
			$.post('./queryObect',initConfig.data,function(data){
				if(data.code != 0){
					return false;
				}
				initConfig.searcchRending(data,true);
			});
		});
		initConfig.$searchHistory.find('p').on('click',function(){
			var $that = $(this);
			$that.siblings().html('');
			$that.hide();
			initConfig.searchHistoryData.keyWord = null;
			localStorage.removeItem('searchHistory');
			return false;
		});
		//localStorage.removeItem('searchHistory');
		//搜索历史
		!(function initLocalStorage (window){
			if('searchHistory' in localStorage){
				var _history = localStorage.getItem('searchHistory');
				if(_history){
					var arr = _history.split(','),html ='';
					for(var i=0, list; list = arr[i++];){
						html+= '<li>'+ list +'</li>';
					}
					initConfig.$searchHistory.find('ul').html(html);
				}
			} else {
				localStorage.setItem('searchHistory','');
			}
		})(window);
		initConfig.addEvent(initConfig.$sortBtn[0],'touchstart',function(){
			$(this).parent().addClass('active');
			return false;
		});
		initConfig.addEvent(initConfig.$sortBtn[0],'touchend',function(){
			var _that = $(this);
			_that.siblings().slideToggle().parent().removeClass('active');
			_that.parent().css('z-index','113');
			initConfig.$mask.css('z-index','112');
			initConfig.$mask.fadeToggle();
			return false;
		});
		initConfig.addEvent(initConfig.$sortList.find('li'),'click',function(){
			var _that = $(this);
			_that.parents('.sortList').slideToggle().removeClass('active');
			initConfig.$mask.fadeToggle();
			if(initConfig.sortListIndex == _that.index()){
				return false;
			}
			_that.addClass('active').siblings().removeClass('active');
			initConfig.searchHistoryData.orderBy = _that.index();
			initConfig.data.orderBy = _that.index();
			initConfig.sortListIndex = _that.index();
			initConfig.data.currPage = 1;
			initConfig.searchHistoryData.currPage = 1;
			if(initConfig.$requirementTitle.is('hidden')){
				$.post('./queryObect',initConfig.searchHistoryData,function(data){
					if(data.code != 0){
						return false;
					}
					initConfig.searcchRending(data,false);
				});
			} else {
				$.post('./queryObect',initConfig.data,function(data){
					if(data.code != 0){
						return false;
					}
					initConfig.searcchRending(data,true);
				});
			}
			return false;
		});
		initConfig.$requirementList.on('click','li',function(){
			var _type = initConfig.$requirementTitle.find('h4.active'),
				_$that = $(this),
				_thatIndex = _$that.index();
			initConfig.$requirementTitle.find('h4').removeClass('active');
			if(initConfig.requirementListIndex == _thatIndex){
				_$that.parent().fadeToggle();
				initConfig.$mask.fadeToggle();
				return false;
			}
			if(_type.attr('data-text')=='城'){
				if(_$that.text()!='不限'){
					initConfig.data.city = _$that.text();
				} else {
					delete initConfig.data.city
				}
				delete initConfig.data.totalMoney;
				delete initConfig.data.room;
			}  else if (_type.attr('data-text')=='总'){
				initConfig.data.totalMoney = _$that.index();
				delete initConfig.data.room;
				delete initConfig.data.city;
			}  else if (_type.attr('data-text')=='户'){
				initConfig.data.room = _$that.index();
				delete initConfig.data.city;
				delete initConfig.data.totalMoney;    
			}
			for(var i=0, list; list = initConfig.$requirementTitle.find('h4')[i++];){
				if($(list).find('em').text() != '城市' && $(list).attr('data-text') == '城'){
					$(list).find('em').text('城市');
				} else if($(list).find('em').text() != '总价' && $(list).attr('data-text') == '总'){
					$(list).find('em').text('总价');
				} else if($(list).find('em').text() != '户型' && $(list).attr('data-text') == '户'){
					$(list).find('em').text('户型');
				}
			}
			initConfig.data.orderBy = initConfig.$sortList.find('li.active').index();
			_$that.addClass('active').siblings().removeClass('active');
			_type.find('em').text(_$that.text());
			if(!_type.find('em').hasClass('cur')){
				_type.find('em').addClass('cur');
			}
			_type.siblings().find('em').removeClass('cur');
			initConfig.requirementListIndex = _thatIndex;
			_$that.parent().fadeToggle();
			initConfig.$mask.fadeToggle();
			initConfig.data.currPage = 1;
			initConfig.searchHistoryData.currPage = 1;
			$.post('./queryObect',initConfig.data,function(data){
				if(data.code != 0){
					return false;
				}
				initConfig.searcchRending(data,true);
			});
		});
		initConfig.$searchHistory.find('ul').on('click','li',function(){
			var $that = $(this),
				$thatText = $that.text();
			/* if(initConfig.searchHistoryData.keyWord == $thatText){
				return false;
			} */
			initConfig.searchHistoryData.keyWord = $thatText;
			initConfig.$startSearch.val($thatText);
			initConfig.data.currPage = 1;
			initConfig.searchHistoryData.currPage = 1;
			$that.parents('.p-searchHistory').fadeOut();
			$.post('./queryObect',initConfig.searchHistoryData,function(data){
				if(data.code != 0){
					return false;
				}
				$('.GZH-main').css('padding-top','1rem');
				initConfig.searcchRending(data,false);
			});
			
		});
		initConfig.addEvent(initConfig.$requirementTitle.find('h4'),'click',function(e){
			var _that = $(this),
				_thatIndex = _that.index(),
				_thatDataText = _that.attr('data-text'),
				_thatSiblings = _that.siblings();
			initConfig.requirementListIndex = null;
			if(initConfig.requirementTitleIndex == _thatIndex && !initConfig.$requirementList.is(':hidden')){
				initConfig.$requirementList.fadeOut();
				initConfig.$mask.fadeOut();
				initConfig.requirementTitleIndex = null;
				_that.removeClass('active');
				return false;
			}
			_that.addClass('active').siblings().removeClass('active');
			/* _thatSiblings.find('em').removeClass('cur'); */
			if(_thatDataText == '城'){
				if(initConfig.houseCity){
					initConfig.$requirementList.html(initConfig.houseCity);
				} else {
					$.post('./selectCity',function(data){
						if(data.code==0){
							initConfig.houseCity='<li>不限</li>';
							for(var i=0, len=data.list.length;i<len; i++){
								initConfig.houseCity +='<li>'+data.list[i]+'</li>';
							}
							initConfig.$requirementList.html(initConfig.houseCity);
						}
					});
				}
			} else if(_thatDataText == '总'){
				var _html ='';
				for(var i=0,list; list = initConfig.priceTag[i++];){
					_html+='<li>'+ list +'</li>';
				}
				initConfig.$requirementList.html(_html);
			} else if(_thatDataText == '户'){
				var _html ='';
				for(var i=0,list; list = initConfig.housType[i++];){
					_html+='<li>'+ list +'</li>';
				}
				initConfig.$requirementList.html(_html);
			}
			initConfig.$sort.css('z-index','100');
			initConfig.$mask.css('z-index','110');
			initConfig.requirementTitleIndex = _thatIndex;
			initConfig.$requirementList.fadeIn();
			initConfig.$mask.fadeIn();
			return false;
		});
		//搜索
		initConfig.$startSearch.focus(function(){
			var _that = $(this);
			_that.val("");
			_that.parent().addClass('active');
			$('body').addClass('bg');
			initConfig.$searchHistory.fadeIn();
			if(initConfig.$searchHistory.find('li').length > 0){
				initConfig.$searchHistory.fadeIn();
			} else {
				initConfig.$searchHistory.find('p').fadeOut();
			}
			initConfig.data.currPage = 1;
			initConfig.searchHistoryData.currPage = 1;
			initConfig.$sort.fadeOut();
			initConfig.$requirementTitle.parent().fadeOut();
			document.body.removeEventListener('scroll',initConfig.scrollEven,false);
			/* document.body.addEventListener('touchmove',initConfig.defaultEven,false); */
			initConfig.clearTime = setInterval(function(){
				initConfig.$initShowMain.html("");
			},10);
		}).blur(function(){
			var _that = $(this);
			/*_that.val("");
			_that.parent().removeClass('active'); */
			initConfig.$searchHistory.fadeOut();
			initConfig.$sort.fadeOut();
			/* $('body').css('overflow','auto'); */
			clearInterval(initConfig.clearTime);
			/* document.body.removeEventListener('touchmove',initConfig.defaultEven,false); */
			document.body.addEventListener('scroll',initConfig.scrollEven,false);
		});
		/* */
		initConfig.$startSearch.on('keypress',function(e) {
			var keycode = e.keyCode,
            	searchName = $(this).val().trim(); 
            if(keycode=='13') {
                e.preventDefault();
                if(!searchName){
            		return false;
            	}
                /* if(!searchName || initConfig.searchHistoryData.keyWord == searchName){
                	return false;
                } */
                initConfig.searchHistoryData.keyWord = searchName;
                $.post('./queryObect',initConfig.searchHistoryData,function(data){
    				if(data.code != 0){
    					return false;
    				}
    				$('.GZH-main').css('padding-top','1rem');
    				if(data.list.length > 0){
    					initConfig.$initShowMain.css({'margin-top':'0','margin-left':'0','background':'none'});
    					var _history = localStorage.getItem('searchHistory');
    					if(_history){
    						var arr = _history.split(','),
    							arrRepeatIndex = arr.indexOf(searchName),
    							_html="  ";
    						arr.unshift(searchName);
    						if( arrRepeatIndex != -1){
								arr.splice(arrRepeatIndex+1,1);
							}
    						if(arr.length > 6){
    							arr = arr.slice(0,6);
    						}
    						
    						for(var i=0, len = arr.length; i < len;i++){
    							_html+= '<li>'+ arr[i] +'</li>';
    						}
    						initConfig.$searchHistory.find('ul').html(_html);
    						localStorage.setItem('searchHistory',arr);
    					} else {
    						localStorage.setItem('searchHistory',searchName);
    						initConfig.$searchHistory.find('ul').html('<li>'+ searchName +'</li>');
    					}
    					initConfig.$searchHistory.find('p').show();
    					initConfig.searcchRending(data,true);
    				} else {
    					var _html ='<img style="width:1.54rem;height:2.48rem; max-width:100%;" src="${linkerStatic}/img/zhongYuan/searchEnd.png"/>';
    					initConfig.$initShowMain.html(_html);
    					initConfig.$initShowMain.css({'margin-top':'50%','margin-left':'40%','background':'none'});
    				}
    				initConfig.$startSearch.blur();
    				
    			});
            } 
     	});
		$(window).scroll(initConfig.scrollEven);
	});
</script>
</body>
</html>