<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
	    <!-- <meta content="width=device-width" name="viewport" /> -->
	    <meta name='apple-mobile-web-app-capable' content='yes' />
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
	    </style>
	    <script>
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
		    }(window, document));
		</script>
	</head>
<body>
	<div class="scaleEle">
		<header class="GZH">
			<div class="GZH-tag">
				<div class="clear">
					<h4 data-index="0" class="active">新房</h4>
					<h4 data-index="1">二手房</h4>
				</div>
				<span class="GHZ-search"></span>
			</div>
			<div class="GZH-requirement">
				<div class="GZH-requirement-title">
					<h4 data-text="城"><em>城市</em><i></i></h4>
					<h4 data-text="均"><em>均价</em><i></i></h4>
				</div>
				<ul style="display:none;" class="GZH-requirement-list">
				</ul>
			</div>
		</header>
		<div class="GHZ-search-Show">
			<div class="GHZ-search-Show-header clear">
				<div class="GHZ-search-Show-header-left">
					<div class="GHZ-search-Show-header-left-tag">
						<h4 data-index="0"><em>新房</em><i></i></h4>
						<ul style="display:none;">
							<li>新房</li>
							<li>二手房</li>
							<i></i>
							<em></em>
						</ul>
					</div>
					<input type="search" placeholder="请输入楼盘"/>
				</div>
				<div class="GHZ-search-Show-header-right">取消</div>
			</div>
		</div>
		<div style="display:none;" class="GHZ-mask"></div>
	</div>
	<div class="GZH-main">
		<ul></ul>
	</div>
<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
<script>
	$(function(){
		var cdn_url = '${fns:getCosAccessHost()}',
			initShowMain = $('.GZH-main ul'),
			initWidth = $(document).width(),
			initHeight = $(document).height(),
			requirementList = $('.GZH-requirement-list'),
			mask = $('.GHZ-mask'),
			defaultPic = '${backStatic}/images/defaluePic.jpg';
		$('.GHZ-search-Show-header-right').on('click',function(){
			$('.GZH').animate({'top':0},500);
			$(this).parents('.GHZ-search-Show').animate({'top':'50px'},390);
			$('.GZH-main').animate({'padding-top':$('.GZH').height()},500);
			$('.GHZ-search-Show-header-left-tag ul').hide();
			if(requirementList.is(':hidden')){
				$('.GZH-requirement-list li,.GZH-requirement-title h4,.GZH-requirement-title.conTri h4').removeClass('active');
				obj.requirementTitleIndex = null;
				requirementListThisIndex=null;
			};
			$('.GHZ-search-Show-header-left-tag h4').removeClass('active');
			document.body.removeEventListener('touchmove',bodyScroll,false);
			var html="";
       		if(dt){
       			/* dt.currPage = pageNumber; */
       			$.post('./queryObect',dt,function(data){
       				if(data.code == 0){
       					if($('.GZH-tag h4.active').index()==0){
       						var buildAreaHtml="";
       						for(var i=0,len=data.list.length;i<len; i++){
       							if(data.list[i].coverImgUrl){
       								defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
       							}
       							/* if(data.list[i].buildArea){
       								buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
       							} */
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
	       						var tagLength = 0,
		   							tagHtml="",addressHtml = "",orientationsHtml="";
	      						if(data.list[i].projectTag){
	      							tagLength = data.list[i].projectTag.length;
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
	       				/* ++pageNumber; */
	       				allPage = data.totalPage;
	       				initShowMain.html("");
       					initShowMain.append(html);
       					initShowMain.css({'margin-top':'0','margin-left':'0'});
       				} 
       			});
       		} else {
       			$.post('./queryObect',{
       				"fyType":$('.GZH-tag h4.active').index(),
       				"currPage":1,
       				"pageSize":5
       			},function(data){
       				if(data.code == 0){
       					if($('.GZH-tag h4.active').index()==0){
       						var buildAreaHtml= "";
       						for(var i=0,len=data.list.length;i<len; i++){
       							if(data.list[i].coverImgUrl){
       								defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
       							}
       							/* if(data.list[i].buildArea){
       								buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
       							} */
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
	       						var tagLength = 0,
		   							tagHtml="",addressHtml = "",orientationsHtml="";
	      						if(data.list[i].projectTag){
	      							tagLength = data.list[i].projectTag.length;
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
	       				/* ++pageNumber; */
	       				allPage = data.totalPage;
	       				initShowMain.html("");
       					initShowMain.append(html);
       					initShowMain.css({'margin-top':'0','margin-left':'0'});
       				} 
       			});
       		}
		});
		$('.GHZ-search').on('click',function(){
			if(requirementList.is(':hidden')){
				mask.fadeOut();
			} else {
				requirementList.hide();
				mask.fadeOut();
			}
			$('body,html').css({'height':'auto','overflow':'hidden'});
			$('.GHZ-search-Show').animate({'top':0},500);
			$(this).parents('.GZH').animate({'top':-$(this).parents('.GZH').height()+'px'},450);
			$('.GZH-main').animate({'padding-top':$('.GHZ-search-Show').height()},500);
			$('input').val("");
			initShowMain.html("");
			if($('.GZH-requirement-title h4 em').hasClass('cur')){
				$('.GZH-requirement-title h4 em').removeClass('cur');
			}
			document.body.addEventListener('touchmove',bodyScroll,false);
			/*document.body.addEventListener('touchend',bodyScroll,false); */
		});
		mask.on('click',function(){
			$('.GZH-requirement-list').hide();
			$(this).fadeOut();
			$('.GZH-requirement-list li,.GZH-requirement-title h4').removeClass('active');
			obj.requirementTitleIndex = null;
			requirementListThisIndex=null;
			$('body,html').css({'height':'auto','overflow':'auto'});
			$('.GZH-main').css({'top':'0'});
		});
		var obj = {
			HouseCity:"<li>不限</li>",
			newHousePrice:"<li>不限</li><li>1万以下</li><li>1万-2万</li><li>2万-3万</li><li>3万-6万</li><li>6万-10万</li><li>10万以上</li>",
			oldHousPrice:"<li>不限</li><li>200万以下</li><li>200-300万</li><li>300-400万</li><li>400-500万</li><li>500-800万</li><li>800-1000万</li><li>1000万以上</li>",
			oldHousType:"<li>不限</li><li>一室</li><li>二室</li><li>三室</li><li>四室</li><li>五室</li><li>五室以上</li>",
			oldHousTypeTitle:"<h4 data-text='户'><em>户型</em><i></i></h4>",
			houseIndex:0,
			requirementTitleIndex:null,
			oldHousTypeIndex:null,
			oldHouseTag:['满两年','满五年','红本在手','学位房','学区房','地铁物业','南北通透']
		}
		var dt,requirementListThisIndex=null,pageNumber=2,allPage=0;
		$('.GZH-tag').on('click','h4',function(){
			var _this = $(this),
				index = _this.index(),
				val = _this.text();
			if(index == obj.houseIndex){
				return false;
			}
			obj.HouseCity = "<li>不限</li>";
			$('body,html').css({'height':'auto','overflow':'auto'});
			$.post('./queryObect',{
				"fyType":index,
				"currPage":1,
				"pageSize":5
			},function(data){
				if(data.code == 0){
					var html="";
					if(index==0){
						var buildAreaHtml="";
						for(var i=0,len=data.list.length;i<len; i++){
							if(data.list[i].coverImgUrl){
   								defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
   							}
							/* if(data.list[i].buildArea){
								buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
   							} */
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
      						var tagLength = 0,
	   							tagHtml="",addressHtml = "",orientationsHtml="";
      						if(data.list[i].projectTag){
      							var listTagHtml = "";
      							tagLength = data.list[i].projectTag.length;
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
      				initShowMain.html("");
  					initShowMain.html(html);
  					initShowMain.css({'margin-top':'0','margin-left':'0'});
				}
			});
			if(!requirementList.is(':hidden')){
				requirementList.hide();
			}
			mask.fadeOut();
			obj.houseIndex = index;
			obj.requirementTitleIndex = null;
			requirementListThisIndex=null;
			if($('.GZH-requirement-title h4 em').hasClass('cur')){
				$('.GZH-requirement-title h4 em').removeClass('cur');
			}
			$('.GZH-requirement-title h4').removeClass('active');
			_this.addClass('active').siblings().removeClass('active');
			if(val=='新房'){
				$('.GZH-requirement-title h4').eq(0).find('em').text('城市');
				$('.GZH-requirement-title h4').eq(1).find('em').text('均价');
				$('.GZH-requirement-title h4').eq(1).attr('data-text','均');
				$('.GZH-requirement-title h4').eq(2).remove();
			} else{
				$('.GZH-requirement-title h4').eq(0).find('em').text('城市');
				$('.GZH-requirement-title h4').eq(1).find('em').text('总价');
				$('.GZH-requirement-title h4').eq(1).attr('data-text','总');
				if($('.GZH-requirement-title h4').length <= 2){
					$('.GZH-requirement-title').append(obj.oldHousTypeTitle);
				}
			}
		});
		$('.GHZ-search-Show-header-left-tag h4').on('click',function(){
			var siblingEle = $(this).siblings('ul');
			if(siblingEle.is(':hidden')){
				$(this).addClass('active');
				siblingEle.show();
				return false;
			}
			$(this).removeClass('active');
			siblingEle.hide();
		});
		$('.GHZ-search-Show-header-left-tag ul li').on('click',function(){
			var parentsEle = $(this).parents('ul'),
				siblingEle = parentsEle.siblings('h4')
				thisIndex = $(this).index();
			$(this).addClass('active').siblings().removeClass('active');
			siblingEle.attr('data-index',thisIndex).find('em').text($(this).text());
			siblingEle.removeClass('active');
			parentsEle.hide();
		});
		$('input').focus(function(){
			$('.GHZ-search-Show-header-left-tag h4').removeClass('active');
			$('.GHZ-search-Show-header-left-tag ul').hide();
		});
		$(".GHZ-search-Show-header-left-tag").siblings('input').on('keypress',function(e) {
			var parsentsEle = parseInt($(this).parents('.GHZ-search-Show').css('top').replace('px',""));
			var keycode = e.keyCode,
            	searchName = $(this).val().trim(),
            	dataIndex = $('.GHZ-search-Show-header-left-tag h4').attr('data-index'); 
	            if(keycode=='13') {
	            	
	            	if(parsentsEle==0){
		                e.preventDefault();
		                if(!searchName){
		                	return false;
		                }
		                initShowMain.html("");
		                var data = {
	                		"fyType":dataIndex,
		        			"currPage":1,
		        			"pageSize":5,
		        			"objectName":searchName
		                }
		                da = data;
		                $.post('./queryObect',data,function(data){
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
		        						/* if(data.list[i].buildArea){
		        							buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
		       							} */
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
			       						var tagLength = 0,
			   							tagHtml="",addressHtml = "",orientationsHtml="";
			      						if(data.list[i].projectTag){
			      							var listTagHtml = "";
			      							tagLength = data.list[i].projectTag.length;
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
		        		});
	            } 
			}
             
     	});
		$('.GZH-requirement-title').on('click','h4',function(){
			var _this = $(this),
				index = _this.index(),
				val = _this.attr('data-text'),
				houseTypeIndex = $('.GZH-tag h4.active').index(),
				gth = parseInt(_this.parents('.GZH').css('top').replace('px',''));
			$('body,html').css({'height':initHeight,'overflow':'hidden'});
			if(index != obj.requirementTitleIndex){
				if(requirementList.is(':hidden')){
					_this.addClass('active');
					requirementList.show();
					mask.fadeIn();
				}
			} else {
				if(requirementList.is(':hidden')){
					_this.addClass('active');
					requirementList.show();
					mask.fadeIn();
				} else {
					requirementList.hide();
					mask.fadeOut();
					_this.removeClass('active');
					$('body,html').css({'height':'auto','overflow':'auto'});
				}
			}
			if(gth < 0){
				$('.GZH-main').css({'top':'-55px'});
			} else {
				$('.GZH-main').css({'top':'0'});
			}
			if(index == obj.requirementTitleIndex && obj.houseIndex == houseTypeIndex){
				return false;
			}
			_this.addClass('active').siblings().removeClass('active');
			_this.siblings().find('em').removeClass('cur');
			if($('[data-text="城"]').length > 0){
				$('[data-text="城"]').find('em').text('城市');
			}
			if ($('[data-text="均"]').length > 0){
				$('[data-text="均"]').find('em').text('均价');
			}
			if ($('[data-text="总"]').length > 0){
				$('[data-text="总"]').find('em').text('总价');
			}
			if ($('[data-text="户"]').length > 0){
				$('[data-text="户"]').find('em').text('户型');
			}
			obj.requirementTitleIndex = index;
			requirementListThisIndex=null;
			if(val=='城'){
				$.post('./selectCity',{'fyType':houseTypeIndex},function(data){
					if(data.list){
						for(var i=0, len=data.list.length;i<len; i++){
							obj.HouseCity+='<li>'+data.list[i]+'</li>'
						}
						requirementList.html(obj.HouseCity);
					}
				});
			} else if(val=='均'){
				requirementList.html(obj.newHousePrice);
			} else if(val=='总'){
				requirementList.html(obj.oldHousPrice);
			} else if(val=='户'){
				requirementList.html(obj.oldHousType);
			}
		});
		requirementList.on('click','li',function(){
			var type = $('.GZH-requirement-title h4.active'),
				houseType =$('.GZH-tag h4.active'),
				tagIndex = houseType.index(),
				data = {
				"fyType":tagIndex,
				"currPage":1,
				"pageSize":5
			},
			_this = $(this),
			gth = parseInt($('.GZH').css('top').replace('px',''));
			$('body,html').css({'height':'auto','overflow':'auto'});
			if(gth < 0){
				$('.GZH-main').css({'top':'-55px'});
			} else {
				$('.GZH-main').css({'top':'0'});
			}
			if(type.attr('data-text')=='城'){
				if(_this.text()!='不限'){
					data.city = _this.text();
				}
			} else if (type.attr('data-text')=='均'){
				data.averagePrice = _this.index();
			}  else if (type.attr('data-text')=='总'){
				data.totalMoney = _this.index();
			}  else if (type.attr('data-text')=='户'){
				data.room = _this.index();
			}
			_this.addClass('active').siblings().removeClass('active');
			type.find('em').text(_this.text());
			if(!type.find('em').hasClass('cur')){
				type.find('em').addClass('cur');
			}
			requirementList.fadeOut();
			mask.fadeOut();
			$('.GZH-requirement-title').find('h4').removeClass('active');
			/* 时间戳解决fadeIn与fadeOut渐隐渐出时间判断问题 */
			setTimeout(function(){
				if(requirementList.is(':hidden')){
					obj.requirementTitleIndex = null;
					requirementListThisIndex = null;
				}
			},550);
			if(requirementListThisIndex == _this.index()){
				return false;
			}
			dt = data;
			$.post('./queryObect',data,function(data){
				initShowMain.html("");
				if(data.code == 0){
					var html="";
       					if($('.GZH-tag h4.active').index()==0){
       						var buildAreaHtml="";
       						for(var i=0,len=data.list.length;i<len; i++){
       							if(data.list[i].coverImgUrl){
       								defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
       							}
       							/* if(data.list[i].buildArea){
       								buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
       							} */
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
	       						var tagLength = 0,
		   							tagHtml="",addressHtml = "",orientationsHtml="";
	      						if(data.list[i].projectTag){
	      							var listTagHtml = "";
	      							tagLength = data.list[i].projectTag.length;
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
			});
		})
		$.post('./queryObect',{
			"fyType":$('.GZH-tag h4.active').index(),
			"currPage":1,
			"pageSize":5
		},function(data){
			if(data.code == 0){
				var html="",buildAreaHtml="";
				for(var i=0,len=data.list.length;i<len; i++){
					if(data.list[i].coverImgUrl){
						defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
					}
					/* if(data.list[i].buildArea){
						buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
					} */
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
				allPage = data.totalPage;
				initShowMain.append(html);
				initShowMain.css({'margin-top':'0','margin-left':'0'});
				//eventBind();
			}
		});
		function bodyScroll(event){
		    event.preventDefault();
		}
		/* function cutImgz(obj,par){
		    var image=new Image();
		    image.src=obj.src;
		    $this=obj;
		    var iwidth=par.width();//获取在CSS里固定的图片显示宽度
		    var iheight=par.height();//获取在CSS里固定的图片显示高度
		    if(1*image.width*iheight!=1*iwidth*image.height){
		        //原始图片的尺寸与CSS里固定的图片尺寸比例不一致，则进行处理
		        if(image.width/image.height>=iwidth/iheight){
		            $this.height(iheight+'px');
		            $this.width((image.width*iheight)/image.height+'px');
		        } else{
		            $this.width(iwidth+'px');
		            $this.height((image.height*iwidth)/image.width+'px');
		        }
		    }
		 }*/
		 var beforeScrollTop = $(document).scrollTop();
		 var finished = true;
		$(window).scroll(function(event){
			var event = event || window.event;
	        var afterScrollTop = $(document).scrollTop();
	        var delta = afterScrollTop - beforeScrollTop;
	        beforeScrollTop = afterScrollTop;
	        var initNub = parseInt($('.GZH').css('top').replace('px',""));
	        if( Math.abs(initNub) > 60 ){
	        	return;
	        }
            if(finished && requirementList.is(':hidden')) {
            	setTimeout(function(){
            		finished = true;
            		if($(document).scrollTop() < 50){
                       	$('.GZH').css({'top':0});
                       	$('.GZH-main').css({'top':'0'});
                       	return;
                    }
            		if(delta > 0){
                    	$('.GZH').css({'top':'-55px'});
                    	$('.GHZ-search-Show').css({'top':'0'});
                    	$('.GZH-main').css({'top':'50px'});
                    } else {
                    	$('.GZH').css({'top':'0'});
                    	$('.GZH-main').css({'padding-top':'90px'});
                    }
            	},250);
	            finished = false;
	        }
		       if($(document).scrollTop()>=$(document).height()-$(window).height()){
			       	if(pageNumber <= allPage){
			       		var html="";
			       		if(dt){
			       			dt.currPage = pageNumber;
			       			$.post('./queryObect',dt,function(data){
			       				if(data.code == 0){
			       					if($('.GZH-tag h4.active').index()==0){
			       						var buildAreaHtml="";
			       						for(var i=0,len=data.list.length;i<len; i++){
			       							if(data.list[i].coverImgUrl){
			       								defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
			       							}
			       							/* if(data.list[i].buildArea){
			       								buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
			       							} */
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
				       						var tagLength = 0,
					   							tagHtml="",addressHtml = "",orientationsHtml="";
				      						if(data.list[i].projectTag){
				      							tagLength = data.list[i].projectTag.length;
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
				       				++pageNumber;
				       				allPage = data.totalPage;
			       					initShowMain.append(html);
			       					initShowMain.css({'margin-top':'0','margin-left':'0'});
			       				} 
			       			});
			       		} else {
			       			$.post('./queryObect',{
			       				"fyType":$('.GZH-tag h4.active').index(),
			       				"currPage":pageNumber,
			       				"pageSize":5
			       			},function(data){
			       				if(data.code == 0){
			       					if($('.GZH-tag h4.active').index()==0){
			       						var buildAreaHtml="";
			       						for(var i=0,len=data.list.length;i<len; i++){
			       							if(data.list[i].coverImgUrl){
			       								defaultPic = cdn_url + data.list[i].coverImgUrl.replace(/\.\d+\.\d+\d./g,'.1024.512.');
			       							}
			       						/* 	if(data.list[i].buildArea){
			       								buildAreaHtml = '<i>|</i><em>'+ data.list[i].buildArea +'m²</em>';
			       							} */
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
				       						var tagLength = 0,
					   							tagHtml="",addressHtml = "",orientationsHtml="";
				      						if(data.list[i].projectTag){
				      							tagLength = data.list[i].projectTag.length;
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
				       				++pageNumber;
				       				allPage = data.totalPage;
			       					initShowMain.append(html);
			       					initShowMain.css({'margin-top':'0','margin-left':'0'});
			       				} 
			       			});
			       		}
			       	}
		       }
		    });
		
	});
</script>
</body>
</html>