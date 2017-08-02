<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=no" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>报名</title>
<link rel="stylesheet" href="${backStatic}/css/common.css">
<link rel="stylesheet" href="${backStatic}/css/animate.min.css">
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
<header>
    <img class="logo animated pulse" src="${backStatic}/images/logo.png" alt="沙滩亲子派对">
    <img class="themeMessages animated rubberBand" src="${backStatic}/images/theme-Messages.png" alt="沙滩亲子派对">
    <img src="${backStatic}/images/theme-BG.jpg" alt="沙滩亲子派对">
</header>
<div class="container" style="margin-bottom: .3rem;">
    <div class="yellowColor"></div>
    <div class="C-messages " style="border-radius: 0">
        <div class="C-list clearfix">
            <div class="form-group">
                <input type="text" name="uname" data-code="false" maxlength="20" class="form-control" placeholder="请输入真实姓名">
            </div>
            <div class="form-group">
                <input type="text" name="num" data-code="false" class="form-control" placeholder="请输入一起看房的人数">
            </div>
            <div class="form-group">
                <input type="text" name="phone" data-code="false" maxlength="11" minlength="11" class="form-control" placeholder="请输入常用的手机号码">
            </div>
            <div class="form-group">
                <span class="btn btn-red codeElem" style=" float: right; width: 2.2rem; height: .88rem; line-height: .88rem; border-radius: 3px; font-size: .26rem;">获取验证码</span>
                <input type="text" name="code" minlength="6" maxlength="6" data-code="false" style=" float: left; width: 3.21rem;" class="form-control" placeholder="请输入验证码">
            </div>
            <div class="form-group">
                <span class="btn btn-red submitData" style="border-radius: 3px; font-size: .34rem; opacity: .6" data-state="false">我要报名</span>
            </div>
        </div>
    </div>
    <div style="height: .28rem;"><img src="${backStatic}/images/mes-img.png" style="max-width: 100%;" alt="沙滩亲子派对"></div>
    <div class="messShow clearfix">
        <div class="M-left">
            <p style="font-size: .26rem;">已有<span style="color: #f4526a;" id="count">3547</span>人报名</p>
        </div>
        <div class="M-right">
            <span class="M-R-more"></span>
            <ul>
                <li style="z-index: 3"><img src="${backStatic}/images/1.jpg" alt="沙滩亲子派对"></li>
                <li style="z-index: 4"><img src="${backStatic}/images/2.jpg" alt="沙滩亲子派对"></li>
                <li style="z-index: 5"><img src="${backStatic}/images/3.jpg" alt="沙滩亲子派对"></li>
                <li style="z-index: 6"><img src="${backStatic}/images/4.jpg" alt="沙滩亲子派对"></li>
                <li style="z-index: 7"><img src="${backStatic}/images/5.jpg" alt="沙滩亲子派对"></li>
            </ul>
        </div>
    </div>
    
</div>
<div class="success" style="display:none;">
    <div class="S-header">
        <img src="${backStatic}/images/mes-img3.png" alt="沙滩亲子派对">
    </div>
    <div style="height: .24rem;"><img src="${backStatic}/images/mes-img2.png" style="max-width: 100%;" alt="沙滩亲子派对"></div>
    <div class="codeMess">
        <h4>关注找房公众号</h4>
        <h4>优惠活动早知道</h4>
        <img src="${backStatic}/images/code.jpg" alt="沙滩亲子派对">
        <p>识别二维码关注找房公众号</p>
    </div>
    <div class="appKnow clearfix">
        <img src="${backStatic}/images/mes-img4.png" alt="沙滩亲子派对">
        <a href="https://mp.weixin.qq.com/mp/profile_ext?action=home&__biz=MzA5NDQ2Njg4Mg==&scene=124#wechat_redirect">了解更多</a>
    </div>
</div>
<div class="promptBox" style="display: none;"><div><p></p></div></div>
<!-- <footer>
    <a class="btn btn-red" href="">马上报名</a>
</footer> -->
<script src="https://cdn.bootcss.com/jquery/3.0.0-beta1/jquery.min.js"></script>
<script>
    $(function(){
    	init();
        var submitData = $('.submitData'),
            codeElem = $('.codeElem'),
            _input = $('input[type="text"]'),
            codeNum = 60,
            timer = null,
            codeState=true,
            telephone =/0?(13|14|15|17|18)[0-9]{9}/,
            reg= /^[0-9]+$/;
            (function messagesInspect(){
            	timer = setTimeout(function(){
            		if($('input[data-code="true"]').length == _input.length){
            			submitData.attr('data-state','true')
            			submitData.css('opacity','1');
            		} else {
            			submitData.attr('data-state','false')
            			submitData.css('opacity','.6');
            		}
            		messagesInspect();
            	},500);
            })();
        submitData.click(function(){
            if(!submitData.attr('data-state')){
                return false;
            }
            var uname = $('input[name="uname"]').val();
            var phone = $('input[name="phone"]').val();
            var num = $('input[name="num"]').val();
            var code = $('input[name="code"]').val();
            if(!uname){
            	 promptBoxHidden("请输入真实姓名");
            	 $('input[name="uname"]').focus();
                 return false;
            }
            if(num==""){
                promptBoxHidden("请输入一起看房的人数");
                $('input[name="num"]').focus();
                return false;
            }else if(!reg.test(num) || num>100 || num == 0){
            	 promptBoxHidden("请输入小于100正整数");
            	 $('input[name="num"]').focus();
                 return false;
            }
            if(!telephone.test(phone)){
                promptBoxHidden("请输入常用的手机号码");
                $('input[name="phone"]').focus();
                return false;
            }
            if(!code){
            	 if(codeState){
            		 promptBoxHidden("请先获取验证码");
            	 }else{
            		 promptBoxHidden("请输入验证码");
            		 $('input[name="code"]').focus();
            	 }
                 return false;
            }
        	var data = {
    				"uname":uname,
    				"phone": phone,
    				"num":num,
    				"code":code,
    				"activityId":"100001"
    			};
        	$.post("./addEnrolInfo",data,function(result){
			    if(result.code == 0){
			    	$(".success").fadeIn();
			    } else if(result.code == 1){
			    	promptBoxHidden("你已报名,请勿重复提交");
			    }else if(result.code == 2){
			    	promptBoxHidden("验证码错误或超时");
			    }
			 });
        });
        function promptBoxHidden(mes){
                $('.promptBox').fadeIn();
                $('.promptBox p').text(mes);
                var clearTime = setTimeout(function(){
                  $('.promptBox').fadeOut();
                  clearTimeout(clearTime);
                },3000);
              }
        function getCode(codeElem){
            var ti = setTimeout(function(){
                codeElem.text('重新发送（'+codeNum+'）');
                codeNum--;
                codeState = false;
                if (codeNum==0) {
                    codeNum = 60;
                    codeState=true;
                    codeElem.text('获取验证码');
                    /* $("input[name='code']").removeAttr("disabled"); */
                    codeElem.css('background-color','#ff5050');
                    clearTimeout(ti);
                    return;
                }
                getCode(codeElem);
            },1000);
        }
         _input.blur(function(){
            var _this = $(this),
                name = _this.attr('name'),
                valName = _this.val().trim();
            if(name =="phone"){
                if(!$.isNumeric(valName) || !telephone.test(valName)){
                    promptBoxHidden("请输入常用的手机号码");
                    _this.attr('data-code','false');
                   // _this.focus();
                    return false;
                }
                _this.attr('data-code','true');
            } else if(name=="uname"){
                if(valName==""){
                    promptBoxHidden("请输入真实姓名");
                    _this.attr('data-code','false');
                    //_this.focus();
                    return false;
                }
                _this.attr('data-code','true');
            } else if(name=="num"){
            	console.log(!reg.test(valName));
            	console.log(valName<100);
            	console.log(valName == 0);
                if(valName==""){
                    promptBoxHidden("请输入一起看房的人数");
                    _this.attr('data-code','false');
                   // _this.focus();
                    return false;
                }else if(!reg.test(valName)|| valName>100 || valName == 0){
                	 promptBoxHidden("请输入小于100正整数");
                    // _this.focus();
                     return false;
                }
                _this.attr('data-code','true');
            } else if(name=="code"){
                if(valName=="" || !$.isNumeric(valName)){
                    promptBoxHidden("请输入验证码");
                    _this.attr('data-code','false');
                    //_this.focus();
                    return false;
                }
                _this.attr('data-code','true');
            }
        }); 
        codeElem.click(function(){
        	var obj = this;
            if(codeState){
            	var phone = $('input[name="phone"]').val();
            	if(!$.isNumeric(phone) || !telephone.test(phone)){
                    promptBoxHidden("请输入常用的手机号码");
                    submitData.attr('data-code','false');
                    $('input[name="phone"]').focus();
                    return false;
                }
            	$.post("./sendMessageCode",{phone:phone},function(result){
    			    if(result.code == "0"){
    			    	  codeElem.text('重新发送（60）');
    			    	  $("input[name='code']").removeAttr("disabled");
    		              getCode($(obj));
    		              $(obj).css('background-color','#bbb');
    			    }
    			 });
              
            }
            return false;
        });
        _input.on("input",function(evt){
        	var _this = $(this),
	            name = _this.attr('name'),
	            valName = _this.val().trim();
	        if(name =="phone"){
	            if(!$.isNumeric(valName) || !telephone.test(valName)){
	                _this.attr('data-code','false');
	                return false;
	            }
	            _this.attr('data-code','true');
	        } else if(name=="uname"){
	            if(valName==""){
	                _this.attr('data-code','false');
	                return false;
	            }
	            _this.attr('data-code','true');
	        } else if(name=="num"){
	            if(valName==""){
	                _this.attr('data-code','false');
	                return false;
	            }else if(!reg.test(valName) || valName>100){
	            	_this.attr('data-code','false');
	                 return false;
	            }
	            _this.attr('data-code','true');
	        } else if(name=="code"){
	        	if(reg.test(valName) && valName.length == 6){
	        		_this.attr('data-code','true');
	        	}else{
	        		 _this.attr('data-code','false');
	        	}
	            
	        }
       	});
    });
    function init(){
     	$.post("./selectCount",{activityId:"100001"},function(result){
     		var c = parseInt($("#count").html()) + result.count;
		    $("#count").html(c);
		 });
    }
</script>
</body>
</html>