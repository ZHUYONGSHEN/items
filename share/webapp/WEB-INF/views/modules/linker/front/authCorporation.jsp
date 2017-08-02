<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    	<title>公司认证</title>
    	<script>
    		if(devicePixelRatio == 2){
    			document.write('<meta name="viewport" content="initial-scale=0.5, maximum-scale=0.5, minimum-scale=0.5, user-scalable=no">');
    		} else if(devicePixelRatio == 3){
    			document.write('<meta name="viewport" content="initial-scale=0.3333333333333333, maximum-scale=0.3333333333333333, minimum-scale=0.3333333333333333, user-scalable=no">');
    		} else {
    			document.write('<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">');
    		}
    	</script>
    	<meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	    <meta name="format-detection" content="telephone=no" />
	    <meta name="apple-mobile-web-app-capable" content="yes">
	    <meta content="black" name="apple-mobile-web-app-status-bar-style">
	    <meta content="telephone=yes" name="format-detection">
	    <meta name="x5-fullscreen" content="true">
	    <meta name="full-screen" content="yes">
	    <link rel="stylesheet" href="${linkerStatic}/css/common.css?v=1.0">
	    <link rel="stylesheet" href="${linkerStatic}/css/mobiscroll.scroller.android-ics.css">
	    <link rel="stylesheet" href="${linkerStatic}/css/mobiscroll.scroller.css">
	    <style type="text/css">
	    	body,.corporation,.addCorporation{
	    		background-color:#ecf4f9;
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
			.dwwl {
				margin:0;
			}
			.dwww,
			.android-ics .dwhl {
				padding:0;
			}
			.android-ics.light .dwbw .dwb {
				border-left:none;
				color:#fe3d1d;
			}
			.android-ics.light .dwwo {
				background: -webkit-gradient(linear,left bottom,left top,from(#ffffff),color-stop(0.52, rgba(255,255,255,0)),color-stop(0.48, rgba(255,255,255,0)),to(#ffffff));
			    background: -webkit-linear-gradient(#ffffff 0%,rgba(255,255,255,0) 52%, rgba(255,255,255,0) 48%, #ffffff 100%);
			    background: -moz-linear-gradient(#ffffff 0%,rgba(255,255,255,0) 52%, rgba(255,255,255,0) 48%, #ffffff 100%);
			    background: linear-gradient(#ffffff 0%,rgba(255,255,255,0) 52%, rgba(255,255,255,0) 48%, #ffffff 100%);
			}
			.android-ics .dwv {
				border-bottom:none;
			}
			.android-ics .dww {
				width:100%!important;
			}
			.android-ics .dw .dwb-a{
				background:none;
			}
			.android-ics.light .dwbw:first-child .dwb {
				text-align: left;
				padding-left:.3rem;
			}
			.android-ics.light .dwbw:last-child .dwb {
				text-align: right;
				padding-right:.3rem;
			}
			.android-ics .dw .dwwol {
				left:0;
				width:100%;
				border-top: 1px solid #ccc;
    			border-bottom: 1px solid #ccc;
			}
			.android-ics .dww .dw-li {
				font-size:.32rem;
				color:#999;
			}
			.android-ics.light .dwbc {
				top:0;
				right:0;
				left:0;
				z-index:11;
				border-bottom:1px solid #b6b5b5;
			}
			.cor-search,
			.auth li em,
			.cor-search input,
			.addCorporation p em,
			.auth li,
			.android-ics.light .dwwr {
				position: relative;
			}
			.cor-search span,
			.cor-searchNoMess,
			.auth li input,
			.auth li b,
			.android-ics.light .dwbc {
				position: absolute;
			}
			.cor-bg,
			.auth ul,
			.addCorporation ul,
			.android-ics.light .dwwr,
			.android-ics.light .dwbc {
				background-color:white;
			}
			.auth,
			.cor-search input,
			.cor-searchNoMess p{
				text-align:center;
			}
			.cor-searchNoMess,
			.corporation,
			.addCorporation,
			.android-ics.light .dw .dwwb{
				display:none;
			}
	    	.auth {
	    		padding-left:.4rem;
	    		padding-right:.4rem;
	    		margin-top:.32rem;
	    	}
	    	.auth ul {
	    		margin-left:-.4rem;
	    		margin-right:-.4rem;
	    	}
	    	.auth li,
	    	.corporation ul li,
	    	.addCorporation li {
	    		padding:.36rem .4rem;
	    		font-size:.32rem;
	    		color:#3f4a53;
	    		text-align:left;
	    		border-bottom:1px solid #d3ecf9;
	    	}
	    	.auth li:last-child,
	    	.addCorporation li:last-child {
	    		border-bottom:none;
	    	}
	    	.auth li input,
	    	.auth li b {
	    		top:0;
	    		right:0;
	    		bottom:0;
	    		left:0;
	    		z-index:11;
	    		width:100%;
	    		height: inherit;
	    		padding-right: .7rem;
	    		color: #3f4a53;
	    		background:none;
	    		text-align: right;
	    	}
	    	.auth li b {
	    		top: .35rem;
	    	}    
	    	.icon {
	    		display:inline-block;
	    		width:.23rem;
	    		height:.23rem;
	    	}
	    	.icon-del {
	    		width:.47rem;
	    		height:.47rem;
	    		background:url(${backStatic}/images/authDel_icon.png) no-repeat center center;
	    		background-size:contain;
	    	}
	    	.icon-than {
	    		background:url(${backStatic}/images/authListIcon.png) no-repeat center center;
	    		background-size:contain;
	    	}
	    	.icon-search {
	    		width:.32rem;
	    		height:.32rem;
	    		background:url(${backStatic}/images/search2.png) no-repeat center center;
	    		background-size:contain;
	    	}
	    	.icon-danger {
	    		width:.29rem;
	    		height:.29rem;
	    		background:url(${backStatic}/images/authdangerIcon.png) no-repeat center center;
	    		background-size:contain;
	    	}
	    	.auth li em {
	    		top:.1rem;
	    		float: right;
	    		width:.11rem;
	    		height:.23rem;
	    	}
	    	.btn {
	    		display: block;
			    padding: .26rem 2rem;
			    margin-bottom: 0;
			    font-size: .28rem;
			    font-weight: 400;
			    /* line-height: 1.42857143; */
			    text-align: center;
			    white-space: nowrap;
			    vertical-align: middle;
			    -ms-touch-action: manipulation;
			    touch-action: manipulation;
			    cursor: pointer;
			    -webkit-user-select: none;
			    -moz-user-select: none;
			    -ms-user-select: none;
			    user-select: none;
			    background-image: none;
			    border: 1px solid transparent;
			    border-radius: 4px;
	    	}
	    	.btn-blue {
	    		margin-top:.5rem;
	    		color:#fff;
	    		background-color:#108ee9;
	    	}
	    	.upData {
	    		display: flex;
	    		display: -webkit-flex;
				justify-content:center;
				-webkit-justify-content: center;
				align-items:center;
				-webkit-align-items: center;
	    		width:3.25rem;
	    		height:2.78rem;
	    		margin-top: .36rem;
	    		border:1px solid #eceef3;
	    		border-radius:4px;
	    		text-align:center;
	    		vertical-align:middle;
	    		background:url(${backStatic}/images/authupIcon.png) no-repeat center center;
	    		overflow:hidden;
	    		/* background-size:100%; */
	    	}
	    	.corporation,
	    	.addCorporation {
	    		position: fixed;
			    top: .32rem;
			    right: 0;
			    bottom: 0;
			    left: 0;
			    z-index:11;
			    width: 100%;
			    height: 100%;
	    	}
	    	.cor-bg {
	    		padding-top:.2rem;	
	    	}
	    	.cor-search {
	    		width:7.5rem;
	    		height:.86rem;
	    		padding-left:.09rem;
	    		padding-right:.09rem;
	    		padding-bottom:.2rem;
	    		font-size:.28rem;
	    	}
	    	.cor-search span {
	    		right:.3rem;
	    		top:.17rem;
	    		z-index:10;
	    		color:#808080;
	    		font-size:.3rem;
	    	}
	    	.cor-search input {
	    		z-index:11;
	    		width:100%;
	    		height:.66rem;
	    		padding-left:1.29rem;
	    		padding-right:.7rem;
	    		line-height:.66rem;
	    		background:url(${backStatic}/images/search2.png)#eeeff3 no-repeat 36.5% center;
	    		background-size:5%;
	    		border-radius:2px;
	    		transition:all .25s ease-out;
				-webkit-transition:all .25s ease-out;
	    	}
	    	.cor-search.active input {
	    		width:6.19rem;
	    		padding-left:.7rem;
	    		padding-right:.3rem;
	    		text-align:left;
	    		background-position: 4% center;
	    	}
	    	.corporation ul{
	    		max-height: 10rem;
    			overflow-y: auto;
	    	}
	    	/*.corporation ul li:last-child{
	    		padding-bottom:.16rem;
	    	} */
	    	.cor-searchNoMess {
	    		top:1.06rem;
	    		right:0;
	    		bottom:0;
	    		left:0;
	    		z-index:12;
	    		width:3.3rem;
	    		height:4rem;
	    		margin:auto;
	    	}
	    	.cor-searchNoMess img {
	    		max-width:100%;
	    	}
	    	.cor-searchNoMess p{
	    		color:#a6a6a6;
	    		font-size:.34rem;
	    	}
	    	.cor-searchNoMess span {
	    		padding:.26rem .8rem;
	    	}
	    	.addCorporation {
	    		padding-left: .4rem;
    			padding-right: .4rem;
	    	}
	    	.addCorporation ul {
    			margin-left: -.4rem;
    			margin-right: -.4rem;
	    	}
	    	.addCorporation p {
	    		margin-top:.24rem;
	    		font-size:.28rem;
	    		color:#888;
	    	}
	    	.addCorporation p em {
	    		top:-.3rem;
	    	}
	    	.addCorporation p span {
	    		display: inline-block;
   	 			width: 6.3rem;
	    		margin-left:.1rem;
	    	}
	    	.promptBox {
				position: fixed;
				left: 0;
				top: 0;
				right: 0;
				bottom: 0;
				z-index: 1111;
				width: 100%;
				height: 100%;
			}
			.promptBox div{
				display: -webkit-flex;
			  	display: flex;
			  	align-items:center;
				width:inherit;
				height:inherit;
			}
			.promptBox p {
				/* position: absolute;
				left: 0;
				top: 0;
				right: 0;
				bottom: 0;
				z-index: 1; */
				max-width: 5rem;
				height: .8rem;
				line-height: .8rem;
				margin: auto;
				color: #fff;
				font-size: .3rem;
				text-align: center;
				background: rgba(0,0,0,.6);
				border-radius: 3px;
				padding-right: .3rem;
				padding-left:.3rem;
			}
	    	@media screen and (max-width:320px){
	    		.auth li em{
	    			top:.09rem;
	    		}
	    	}
	    	@media screen and (min-width:350px) and (max-width:361px){
	    		.auth li em{
	    			top:.06rem;
	    		}
	    		.auth li b {
	    			top:.38rem;
	    		}
	    	}
	    	@media screen and (min-width:400px) and (max-width:500px){
	    		.auth li em{
	    			top:.05rem;
	    		}
	    		.auth li b {
	    			top:.4rem;
	    		}
	    	}
	    </style>
	    <script type="text/javascript">
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
		<div class="auth">
			<ul>
				<li><em class="icon icon-than"></em><span>所在公司</span><b>
				<c:if test="${info.companyName != null}">
					${info.companyName}
				</c:if>
				<c:if test="${info.companyName == null}">
					请选择
				</c:if>
				</b></li>
				<c:if test="${info.province != null}">
					<li><em class="icon icon-than"></em><span>所在地区</span><input id="area" value="${info.province} ${info.city} ${info.area}" type="button" areaid="${info.areaId}" /></li>
				</c:if>
				<c:if test="${info.province == null}">
					<li><em class="icon icon-than"></em><span>所在地区</span><input id="area" value="请选择" type="button" areaid="10064 10043 10375" /></li>
				</c:if>
				<li style="position: relative;">
					<span>名片</span>
					<div class="upData" id="upDataFile" data-elemShow ="upDataFile" data-upDataUrl="" data-Type="png/jpg/jpeg/gif">
					 	<img  class="showImg" style="width: auto;height: auto; border:none;">
					</div>
					<i class="icon icon-del" style="display:none;position:absolute;left:3rem;top:1.26rem;z-index:11;"></i>
				</li>
			</ul>
			<div class="btn btn-blue tijiao">提交</div>
		</div>
		<div class="corporation">
			<div class="cor-bg">
				<div class="cor-search">
					<span>取消</span>
					<input type="text" placeholder="输入门店名称">
				</div>
				<ul></ul>
			</div>
			<div class="cor-searchNoMess" style="display:none;">
				<img alt="图片" src="${backStatic}/images/search-UFO.png">
				<p></p>
				<span class="btn btn-blue">请点击编辑</span>
			</div>
		</div>
		<div class="addCorporation">
			<ul><li><input type="text" style="width:100%; height:inherit;"></li></ul>
			<p><em class="icon icon-danger"></em><span>佣金将结佣到您所在的公司，请认真输入您所在的公司全称！</span></p>
			<span class="btn btn-blue">确认</span>
		</div>
		<input style="display:none;" id="fileImages" accept="image/*" type="file" capture="camera">
		<div class="promptBox" style="display: none;"><div><p></p></div></div>
	</body>
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
	<script src="${linkerStatic}/js/mobiscroll.zepto.js" type="text/javascript"></script>
	<script src="${linkerStatic}/js/mobiscroll.core.js" type="text/javascript"></script>
	<script src="${linkerStatic}/js/mobiscroll.scroller.js" type="text/javascript"></script>
	<script src="${linkerStatic}/js/mobiscroll.area.js"></script>
	<script src="${linkerStatic}/js/mobiscroll.scroller.android-ics.js"></script>
	<script>
	var showImg = "${info.cardUrl}";
	if(showImg){
		var s = "${fns:getCosAccessHost()}" + showImg;
		$(".showImg").attr("src",s);
		loadImg(s);
		$('.icon-del').show();
	}
	function loadImg (src){
   	  	 var _html = '<img alt="图片" src="'+ src +'">'
   	  	 $(".upData").html(_html);
   	  	 $(".upData img").load(src,function(){
	   	  	var imgWidth = $(this).width(),
		 	imgHeight = $(this).height(),
		 	initSize,updataHeight = $('.upData').height(), updataWidth = $('.upData').width();
			initSize = imgWidth > imgHeight ? imgHeight : imgWidth;
			initSize = initSize < updataHeight ? initSize : updataHeight;
			if(initSize < updataHeight){
				$(this).css({'width':initSize,'height':'100%'});
			} else {
				$(this).css({'height':initSize,'width':'100%'});
			}
   	  	 });
	}
	 wx.config({
		debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
		appId : '${signature["appid"]}', // 必填，公众号的唯一标识
		timestamp : '${signature["timestamp"]}', // 必填，生成签名的时间戳
		nonceStr : '${signature["noncestr"]}', // 必填，生成签名的随机串
		signature : '${signature["signature"]}',// 必填，签名，见附录1
		jsApiList : ['chooseImage','uploadImage']
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
		function initWxApi(){
	//		调用微信接口上传图片
			if(!isWeiXin()){
				alert("请在微信打开!");
				return;
			}
		}
		(function ($) {
		    $.mobiscroll.i18n.zh = $.extend($.mobiscroll.i18n.zh, {
		        setText: '确定',
		        cancelText: '取消'
		       
		    });
		})(jQuery);
		$(function(){
			var valo = $("#area").attr("areaid"),
				timer = null;
			$('#area').scroller('destroy').scroller({ preset: 'area', theme: 'android-ics light', display: 'bottom',valueo:valo });
			function promptBoxHidden(mes){
               $('.promptBox').fadeIn();
               $('.promptBox p').text(mes);
               var clearTime = setTimeout(function(){
                 $('.promptBox').fadeOut();
                 clearTimeout(clearTime);
               },1500);
             }
			$('.cor-search input').focus(function(){
				var _that = $(this);
				_that.parent().addClass('active');
			}).blur(function(){
				var _that = $(this);
				_that.parent().removeClass('active');
			});
			$('.cor-search input').on('input propertychange',function(){
				var _that = $(this),
					thatValue = _that.val().trim();
				if(!thatValue){
					clearTimeout(timer);
					return false;
				}
				if(timer){
					clearTimeout(timer);
				}
				timer =  setTimeout(function(){
		            $.post("./selectByNameLike", {companyName: thatValue}, function(res){
		            	if(res.code==0){
		            		if(res.list.length < 1){
		            			$('.cor-searchNoMess').fadeIn();
		            			$('.corporation ul').css('padding-bottom',0).html("");
		            			$('.cor-searchNoMess p').text('找不到“'+ thatValue +'”');
		            			return false;
		            		}
		            		$('.cor-searchNoMess').fadeOut();
		            		var _html="";
		            		for(var i=0,list;list = res.list[i++];){
		            			_html+='<li>'+ list.companyName +'</li>'
		            		}
		            		$('.corporation ul').css('padding-bottom','.4rem').append(_html);
		            	} else {
		            		$('.cor-searchNoMess').fadeIn();
		            		$('.cor-searchNoMess p').text('找不到“+ thatValue +”');
		            	}
		            });
		         }, 1500);
			});
			$('.cor-searchNoMess span').click(function(){
				$(this).parents('.corporation').fadeOut();
				$('.addCorporation').fadeIn();
				$('.addCorporation li input').val($('.cor-search input').val());
				return false;
			});
			$('.cor-search span').click(function(){
				$(this).siblings().val("");
				$(this).parents('.corporation').fadeOut();
				return false;
			});
			$('.auth li').eq(0).on('click',function(){
				var _that = $(this),
					thatIndex = _that.index();
				if(thatIndex==0){
					$('.corporation').fadeIn();
					$('.corporation ul').html("");
					$('.cor-searchNoMess').hide();
					$('.cor-search input').val("");
				}
				return false;
			});
			$('.addCorporation span.btn').click(function(){
				$(this).parents('.addCorporation').fadeOut();
				$('.auth li b').text($('.addCorporation li input').val());
				return false;
			});
			$('.corporation ul').on('click','li',function(){
				var _that = $(this);
				$('.auth li b').text(_that.text());
				_that.parents('.corporation').fadeOut();
				return false;
			});
			$('.tijiao').on('click',function(){
				var _companyName = $('.auth li b').text().trim(),
					_addres = $('#area').val().trim(),
					obj={
						'openId':"${mpUser.openId}"
					},
					_arr;
				if(_companyName == '请选择' || _addres =='请选择'){
					return false;
				}
				_arr = _addres.split(" ");
				obj.companyName = _companyName;
				obj.createUser = "${nickName}";
				obj.province = _arr[0];
				obj.city = _arr[1];
				obj.area = _arr[2];    
				if(serverId){
					obj.cardUrl = serverId;
				}
				obj.img = showImg;
				obj.linkerId = "${linkerId}";
				obj.id = "${info.id}";
				obj.areaId = $('body').attr('data-areaid');
				var nickName = "${nickName}";
				$.post("./addCompanyInfo", obj, function(res){
	            	if(res.code==0){
	            		location.href="./toSetting?linkerId=${linkerId}&fopenId=${fopenId}&nickName="+window.encodeURI(window.encodeURI(nickName))+"&phone=${phone}&headImg=${headImg}&companyInfoId="+res.id+"&serverId=${serverId}&channelId=${channelId}";
	            	} else {
	            		promptBoxHidden(res.msg);
	            	}
	            });
				return false;
			});
			$('.auth li .icon-del').click(function(){
				serverId=null;
				//$(".showImg").removeAttr("src");
				$(".upData img").remove();
				$(this).hide();
				return false;
			});
			
		});
	/**var fileId = document.getElementById("fileImages")//change执行事件目标
	imgageType = "",//文件类型
	imgageSize = "",//文件大小
	imageWidth = "",//宽
	imageHeight = "",//高
	request= "";//终止ajax上传变量
	fileId.addEventListener("change",upLoadImage,false );
    function upLoadImage() {
    	var data = this.files[0];
    	var fd = new FormData();
    	createUpDateFile(data);
        function createUpDateFile(fileData) {
        	//是否有文件数据
        	if (fileData) {
        		var URL = window.URL || window.webkitURL;
                var blob = URL.createObjectURL(fileData);
                var img = new Image();
                var type = fileData.type.substring(fileData.type.indexOf('/')+1,fileData.type.length);
            	//文件类型与大小
            	if (!!imgageType) {
            		if (imgageType.indexOf(type) < 0 || !fileData.type) {
            			$("#fileImages").wrap('<form>').closest('form').get(0).reset();
	                 	alert('请上传'+ imgageType +'后缀的文件!');
	                 	return false;
	                }
            	}
                if(!!imgageSize){
                	if (fileData.type > imgageSize*1024) {
                		$("#fileImages").wrap('<form>').closest('form').get(0).reset();
	                 	alert('请上传文件大小小于/等于'+ upDataFileSize +'M!');
	                 	return false;
	                }
                }
                img.src = blob;
                img.onload = function () {
                	var imgWidth = img.width;
                	var imgHeight = img.height;
                	alert(imgWidth);
                	//文件尺寸
                	if (!!imageWidth) {
                		if (imgWidth > imageWidth) {
                			$("#fileImages").wrap('<form>').closest('form').get(0).reset();
	                		alert('请上传文件尺寸小于/等于'+ imageWidth +'(宽)!');
	                		return false;
	                	}
                	}
                	if (!!imageHeight) {
                		if ( imgHeight > imageHeight) {
                			$("#fileImages").wrap('<form>').closest('form').get(0).reset();
	                		alert('请上传文件尺寸小于/等于'+ imageHeight +'(高)!');
	                		return false;
	                	}
                	}
                	//显示目标
            		if(!!upDataElemShowId){
            			document.getElementById(upDataElemShowId).style.backgroundImage = "url("+ blob +")";
            		}
            		//显示目标名称
            		if (!!upDataElemName) {
						document.getElementById(upDataElemName).innerHTML = data.name
					}
					if (!!upDataElemStopId) {
						document.getElementById(upDataElemStopId).addEventListener('click',requestAbort, false);
						function requestAbort(argument) {
							request.abort();
						}
					}
                    var startimes = new Date();
                    if(!!upDataUrl){
                    	request = $.ajax({
	                        type: "POST",
	                        url: upDataUrl,
	                        data: fd,
	                        processData: false,
	                        contentType: false,
	                        success: function (res) {
	                            var result = res;
	                            //是否上传成功(根据返回字段微调)
                                console.log(result);
                                $("#fileImages").wrap('<form>').closest('form').get(0).reset();
	                        },
	                        xhr: function (e) {
	                        	//进度流
	                        	var xhr = $.ajaxSettings.xhr();
							    if(onprogress && xhr.upload) {
							     	xhr.upload.addEventListener("progress" , onprogress, false);
							     	return xhr;
							    }
	                        },
	                        error: function (data) {
	                        	//提交出错
	                        }
	                    });
                    }

                }
	        }
       	};
    }**/
    var localId;
    var serverId;
    $('#upDataFile').click(function (argument) {
    	var _that = $(this);
    	//微信接口
    	/* fileId.click(); */
    	wx.ready(function(){
	    	wx.chooseImage({
	   			count: 1,
	   			success: function (res) {
	   				localId = res.localIds;
	   				loadImg(localId);
	   				//$(".showImg").attr("src",localId);
	   				//_that.css({'background':'url('+localId+') no-repeat center',"background-size":"contain"});
	   				//上传图片
	   				wx.uploadImage({
	   					localId: localId.toString(),
	   					success: function (res) {
	   						serverId = res.serverId;
	   						$('.icon-del').show();
	   					}
	   				})
	   			}
	   		});
    	});
    	//点击触发change
    	/* var _that = this;
    	imgageType = _that.getAttribute('data-Type'),//文件类型
		imageWidth = _that.getAttribute('data-fileWidth'),//文件宽
		imageHeight = _that.getAttribute('data-fileheight'),//文件高
		upDataElemShowId = _that.getAttribute('data-elemShow'),//本地展示目标ID
		upDataElemStopId = _that.getAttribute('data-elemStop'),//强制取消上传ID
		upDataElemAnimationId = _that.getAttribute('data-elemAnimation'),//上传动画元素ID
		upDataFileSize = _that.getAttribute('data-fileSize'),//文件大小单位(m)
		upDataElemName = _that.getAttribute('data-elemName'),//文件名称
		upDataUrl = _that.getAttribute('data-upDataUrl');//ajax提交地址
		fileId.click();
		if (!!upDataElemAnimationId && !!upDataElemStopId) {
			document.getElementById(upDataElemAnimationId).style.width = 0;
		} */
		return false;
    });
	</script>
</html>















