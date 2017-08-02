<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <meta name='apple-mobile-web-app-capable' content='yes' />
	    <script>
		    !(function(win, doc) {
		        function setFontSize() {
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
		        }
		        setFontSize();
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
		var obj = {
			HouseCity:'<li>不限</li>',
			newHousePrice:'<li>不限</li><li>1万以下</li><li>1万-2万</li><li>2万-3万</li><li>3万-6万</li><li>6万-10万</li><li>10万以上</li>',
			oldHousPrice:'<li>不限</li><li>200万以下</li><li>200-300万</li><li>300-400万</li><li>400-500万</li><li>500-800万</li><li>800-1000万</li><li>1000万以上</li>',
			oldHousType:'<li>不限</li><li>一室</li><li>二室</li><li>三室</li><li>四室</li><li>五室</li><li>五室以上</li>',
			dataSort:'<li>默认</li><li>最新发布</li><li>总价从低到高</li><li>总价从高到低</li><li>单价从低到高</li><li>单价从高到低</li><li>面积从低到高</li><li>面积从高到低</li>',
			oldHousTypeTitle:'<h4 data-text="户"><em>户型</em><i></i></h4>',
			houseIndex:0,
			requirementTitleIndex:null,
			oldHousTypeIndex:null,
			oldHouseTag:['满两年','满五年','红本在手','学位房','学区房','地铁物业','南北通透']
		}
		/* $(".GHZ-search-Show-header-left-tag").siblings('input').on('keypress',function(e) {
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
		        		});
	            } 
			}
             
     	}); */
	});
</script>
</body>
</html>