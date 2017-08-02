<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="decorator" content="admin"/>
	<meta name="viewport" content="width=device-width">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
	<meta name='apple-mobile-web-app-capable' content='yes' />
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />
	<meta content="telephone=yes" name="format-detection" />
	<meta name="x5-fullscreen" content="true">
	<meta name="full-screen" content="yes">
	<title>预约看房</title>
	<link rel="stylesheet" href="http://release.720.hiweixiao.com/SpecialConnector/css/common.css">
	<%-- <link rel="stylesheet" href="${linkerStatic}/css/mobiscroll.android-ics-2.5.2.css">
	<link rel="stylesheet" href="${linkerStatic}/css/mobiscroll.core-2.5.2.css"> --%>
	<link rel="stylesheet" href="${linkerStatic}/css/mobiscroll-2.13.2.full.min.css">
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
	body{font-size:0.3rem;background:#f5f4f9;}
	.mask{width:100%;height:100%;position:absolute;left:0;top:0;right:100%;bottom:100%;display:none;}
	.alerts{width:2.4rem;height:2rem;background:rgba(0,0,0,0.5);position:absolute;left:50%;top:50%;-webkit-transform:translate(-50%,-50%);border-radius:6px;}
	.fail{background:url('${backStatic}/images/icon_errors.png') no-repeat center;background-size:contain;}
	.success{background:url('${backStatic}/images/icon_successes.png') no-repeat center;background-size:contain;}
	.alerts>i{display:block;width:0.8rem;height:0.8rem;margin:0 auto;margin-top:0.3rem;}
	.alerts>b{display:block;width:100%;height:0.8rem;margin-top:4px;text-align:center;color:#fff;}
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
	.yuYueMian {
		font-size:.3rem;
	}
	.yuYueMian-title {
		width:100%;
		height:.54rem;
		color:#9f9f9f;
		line-height:.54rem;
		background:#f2f2f7;
	} 
	.yuYueMian-form {
		background:#fff;
	}
	.yuYueMian-form .yuYueMianForm-input {
		display:table;
		width:100%;
		height:1.01rem;
		padding-right:.28rem;
		padding-left:.28rem;
		line-height:1.01rem;
		overflow:hidden;
		border-bottom:1px solid #e7e7e7;
		-webkit-transition: all 0.1s ease-in; 
		transition: all 0.1s ease-in;
	}
	.yuYueMian-form .yuYueMianForm-input:last-child {
		border-bottom:none;
	}
	.yuYueMian-form .yuYueMian-title {
		width:100%;
		padding-left:.28rem;
	}
	.yuYueMian-form .yuYueMianForm-input input {
		float: right;
		width: 3rem;
		height: inherit;
		color:#c4c4c4;
		text-align:right;
		background:none;
		-webkit-transition: all 0.1s ease-in; 
		transition: all 0.1s ease-in;
	}
	.yuYueMian-form div input::-webkit-input-placeholder {
	    color:#c4c4c4;  
	} 
	.yuYueMian-form .yuYueMianForm-input input {
		color:#333;
	}
	.mt_confirm a{
		font-size:16px;
	}
	.yuYueMianForm-submit {
		padding: .8rem .28rem 0;
		background:#f2f2f7;
		width:100%;
	}
	.yuYueMianForm-submit button {
		display:block;
		width:100%;
		padding: .36rem;
		height:auto;
		background:#28a0ee;
		color:#fff;
		outline:0;
		text-align: center;
		border-radius: 3px;
	}
	.promptBox {
		position: fixed;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    top: 0;
	    z-index: 888;
	    width:100%;
	    height:100%;
	    color:#fff;
	}
	.promptBox p{
		position:absolute;
		left:50%;
		top:50%;
		width:4.5rem;
		height:1rem;
		font-size:.35rem;
		margin-left: -2.25rem;
		margin-top:-.5rem;
		text-align: center;
		line-height:1rem;
		background:rgba(0,0,0, .5);
		border-radius: 3px;
	}
	.android-ics .dwc {
		padding-left: 0;
		margin-left: -30px;
	}
	.android-ics .dwwr {
		position: relative;
		background: #fff;
	}
	.dwl {
		top: 45px;
		right: -30px;
		color: #333;
	}
	.dwbc {
		position: absolute;
		left: 0;
		right: 0;
		width: 100%;
		top: 0;
		background: #fff;
	}
	.android-ics.light .dwb {
		border-right: none;
	}
	.android-ics.light .dwb-s {
		float: right;
		text-align: right;
	}
	.android-ics.light .dwb-c {
		text-align: left;
	}
	.android-ics.light .dwb-s .dwb {
		padding-right: 20px;
		color: #28a0ee;
	}
	.android-ics.light .dwb-c .dwb {
		padding-left: 20px;
	}
	.android-ics .dwv {
		border-bottom-color: #e7e7e7; 
	}
	.android-ics .dw .dwwl0 {
		padding-left: 45px;
	}
	.android-ics .dw .dwwl0 .dwl {
		right: -55px;
	}
	.android-ics .dwwo {
		background: none !important;
	}
	.economicName {
		float: right;
		width:3rem;
		text-align:right;
		color:#c4c4c4;
	}
	.dw-bf{
		font-size:0.25rem;
	}
	
	.mbsc-android-holo .dwv { text-align:left;text-indent:.8em; } 
	.dwbc{position:absolute;top:0;left:0;z-index:100;background:#f7f7f7;color:#55965c;}
	.dwb-c{position:absolute;top:0;color:#55965c;}
	#treelist_dummy{position:absolute;right:0;top:2.1rem;height:.9rem;line-height:.9rem;text-align:right;width:4.3rem;margin-right:0.3rem}
</style>
</head>
<body>
<div class="mask">
		<div class="alerts">
			<i></i>
			<b></b>
		</div>
</div>
<div class="yuYueMian">
	<div class="yuYueMian-form">
		<div class="yuYueMianForm-input"><em>真实名字</em><input type="text" name="customer" maxlength="4" value="" placeholder="必填" value="${data.customer}" required="required" /></div>
		<div class="yuYueMianForm-input"><em>手机号码</em><input type="tel" name="mobile" maxlength="11" placeholder="必填" value="${data.mobile}" required="required" /></div>
		<div class="yuYueMianForm-input" style="border-bottom:none;"><em>期望看房时间</em><input type="text" name="appointmentTime"  value="${data.appointmentSd}" placeholder="必填" required="required" style="display:none;" /></div>
		<div class="yuYueMianForm-input"><em>其他约看房要求</em><input type="text" name="otherRequirement"  maxlength="12"  placeholder="选填" />${data.otherRequirement}</div>
		<div class="yuYueMianForm-submit"><button type="submit" value="Submit">确定预约</button></div>
	</div>
	<div class="mt_mask"></div>
</div>
<ul id="treelist" data-type="treeList" style="display: none;">  
    <li>  
        <span vals="0">随时可看</span>  
        <ul>  
            <li>全天可看</li>  
            <li>上午</li>  
            <li>下午</li>  
            <li>晚上</li>
        </ul>  
    </li>  
</ul>  
<div class="promptBox" style="display:none;"><p></p></div>
<input type="hidden" name="appointmentSd" />
<script src="//cdn.bootcss.com/jquery/2.2.2/jquery.min.js"></script>
<script src="${linkerStatic}/js/mobiscroll-2.13.2.full.min.js"></script>
<script type="text/javascript"  src="${backStatic}/js/alert-box.js"></script>
<script>

var stage ={};
var dataId = "${data.id}";
var siteRoot="${siteRoot}";
var linkerId="${linkerId}";
var linkerName = "${linkerName}";
var targetMobile = "${targetMobile}";
window.location.search.slice(1).split("&").forEach(function(i){
    var key = i.split("=")[0], val = i.split("=")[1];
    if (key) {
        stage[key] = decodeURIComponent(val);
    }
})
var cdn_url ="${fns:getCosAccessHost()}";
//正则表达式
var telephone =/0?(13|14|15|17|18)[0-9]{9}/,
	dateTime =/\d{4}(\-|\/|.)\d{1,2}\1\d{1,2}/;
//增加上午/下午
var now = new Date();
var currYear = now.getFullYear();
var currMonth = now.getMonth();
var currDay = now.getDate();
$(function(){
	function promptBoxHidden(val){
		$('.promptBox').fadeIn();
		$('.promptBox p').text(val);
		var clearTime = setTimeout(function(){
			$('.promptBox').fadeOut();
			clearTimeout(clearTime);
		},1000);
	}
	$('.yuYueMianForm-input input').blur(function(){
		var _this = $(this),
			name = _this.attr('name'),
			valName = _this.val().trim();
		if(name =="mobile"){
			if(valName==""){
				$(".mask").css("display","block");
				$(".alerts>b").html('请输入手机号码');
				$(".alerts>i").addClass("fail");
				$(".mask").animate({opacity: 'hide'}, 2000,function(){
					$(".mask").css("display","none");
					$(".alerts>b").html('');
					$(".alerts>i").removeClass("fail");
					$(".mask").css("opacity","1")});
				return false;
			}
			_this.parent().css("border-bottom-color","#e7e7e7");
		}else if(name=="customer"){
			if(valName==""){
				$(".mask").css("display","block");
				$(".alerts>b").html('请输入真实名字');
				$(".alerts>i").addClass("fail");
				$(".mask").animate({opacity: 'hide'}, 2000,function(){
					$(".mask").css("display","none");
					$(".alerts>b").html('');
					$(".alerts>i").removeClass("fail");
					$(".mask").css("opacity","1")});
				return false;
			}
			_this.parent().css("border-bottom-color","#e7e7e7");
		}
		/* else if(name =="dateTime"){
				var dateTm = null;
				if(valName.indexOf("上午") > 0){
					dateTm = valName.replace('上午','')
				} else if (valName.indexOf("下午") > 0){
					dateTm = valName.replace('下午','')
				}
				if(!dateTime.test(dateTm)){
					$('.promptBox').fadeIn();
					$('.promptBox p').text("请选择期望看房时间");
					promptBoxHidden();
					_this.focus();
				}
			} */
		
	});

	
	$('.yuYueMianForm-submit button').click(function(){
		//提交预约看房
		var customer = $('[name="customer"]'),
			mobile = $('[name="mobile"]'),
			appointmentTime = $('[name="appointmentTime"]'),
			otherRequirement= $('[name="otherRequirement"]');
		 var reg =/^(0|86|17951)?(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$/;
		if(customer.val().trim()==""){
			$(".mask").css("display","block");
			$(".alerts>b").html('请输入真实名字');
			$(".alerts>i").addClass("fail");
			$(".mask").animate({opacity: 'hide'}, 2000,function(){
				$(".mask").css("display","none");
				$(".alerts>b").html('');
				$(".alerts>i").removeClass("fail");
				$(".mask").css("opacity","1")});
			return false;
		} else if (mobile.val().trim()==""){
			$(".mask").css("display","block");
			$(".alerts>b").html('请输入手机号码');
			$(".alerts>i").addClass("fail");
			$(".mask").animate({opacity: 'hide'}, 2000,function(){
				$(".mask").css("display","none");
				$(".alerts>b").html('');
				$(".alerts>i").removeClass("fail");
				$(".mask").css("opacity","1")});
			return false;
		}else if(!reg.test(mobile.val())){
			$(".mask").css("display","block");
			$(".alerts>b").html('手机号码格式不正确');
			$(".alerts>i").addClass("fail");
			$(".mask").animate({opacity: 'hide'}, 2000,function(){
				$(".mask").css("display","none");
				$(".alerts>b").html('');
				$(".alerts>i").removeClass("fail");
				$(".mask").css("opacity","1")});
			return false;
		}/*  else if (appointmentTime.val().trim()==""){
			$(".mask").css("display","block");
			$(".alerts>b").html('请选择看房日期');
			$(".alerts>i").addClass("fail");
			$(".mask").animate({opacity: 'hide'}, 2000,function(){
				$(".mask").css("display","none");
				$(".alerts>b").html('');
				$(".alerts>i").removeClass("fail");
				$(".mask").css("opacity","1")});
			return false;
		} */else {
			//日期
			var dataTime = appointmentTime.val().trim();
			//上下午
			var appointmentSd = $("input[name='appointmentSd']").val();
			if(!appointmentSd){
				appointmentSd = "全天";
			}
			var data = {
				"id":dataId,
				"linkerId": linkerId,
				"customer":customer.val().trim(),
				"appointmentSd":appointmentSd,
				"mobile": mobile.val().trim(),
				"appointmentTime":dataTime.trim(),
				"otherRequirement":otherRequirement.val().trim(),
				"targetMobile":targetMobile,
				"linkerName":linkerName
			};
		 	$.post("${siteRoot}/linker/addAppointmentData",data,function(result){
			    if(result.returnCode == "SUCCESS"){
			    	$(".mask").css("display","block");
					$(".alerts>b").html('预约成功');
					$(".alerts>i").addClass("success");
					$(".mask").animate({opacity: 'hide'}, 2000,function(){
						window.history.back();
						$(".mask").css("display","none");
						$(".alerts>b").html('');
						$(".alerts>i").removeClass("success");
						$(".mask").css("opacity","1")});
			    } else {
			    	$(".mask").css("display","block");
					$(".alerts>b").html('预约失败');
					$(".alerts>i").addClass("fail");
					$(".mask").animate({opacity: 'hide'}, 2000,function(){
						$(".mask").css("display","none");
						$(".alerts>b").html('');
						$(".alerts>i").removeClass("fail");
						$(".mask").css("opacity","1")});
			    }
			 });
			return false; 
		}
	});
});
$(function () {  
	$.get("./getDateData",{},function(data){
		var str="";
		for(var i=0;i<data.list.length;i++){
			str += "<li><span vals="+ data.list[i].value  +">" + data.list[i].name + "</span>";
			str += "<ul>";
			if(data.list[i].falg == 0 || !data.list[i].falg){
				str += "<li>全天可看</li><li>上午</li><li>下午</li><li>晚上</li>";
			}else if(data.list[i].falg == 1){
				str += "<li>全天可看</li><li>下午</li><li>晚上</li>";
			}else if(data.list[i].falg == 2){
				str += "<li>全天可看</li><li>晚上</li>";
			}
			str += "</ul></li>";
		}
		$('#treelist').append(str);
		 var i = Math.floor($('#treelist>li').length / 2),  
	        j = Math.floor($('#treelist>li').eq(i).find('ul li').length / 2);  
	    $("#treelist").mobiscroll().treelist({  
	        theme: "ios light",  
	        lang: "zh",
	        display:'bottom',
	        defaultValue: [1,0],  
	        setText: '确定', //确认按钮名称
	        cancelText: "取消",  
	    /*     formatResult: function (array) { //返回自定义格式结果  
	        	$("#treelist_dummy").attr("placeholder","必填");
	          
	        
	        }  ,*/
	        onSelect:function(valueText,i){
	        	var i = valueText.split(" ")[0];
	        	var h = valueText.split(" ")[1];
	        	$("#treelist_dummy").val($('#treelist>li').eq(i).children('span').text() +' '+ $('#treelist>li').eq(i).find('ul li').eq(h).text().trim(' '));
	        	$("input[name='appointmentTime']").val($('#treelist>li').eq(i).children('span').attr("vals"));
		    	$("input[name='appointmentSd']").val($('#treelist>li').eq(i).find('ul li').eq(h).text().trim(' '));
            }
	    });  
	    $("#treelist_dummy").attr("placeholder","选填");
	})
})   
</script>
</body>
</html>