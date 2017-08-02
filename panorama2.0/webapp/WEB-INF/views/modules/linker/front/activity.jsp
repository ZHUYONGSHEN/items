<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="format-detection" content="telephone=no" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>红海湾</title>
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
<div class="container">
    <div class="yellowColor"></div>
    <div class="C-messages">
        <div class="C-list clearfix">
            <div class="C-L-left">
                <h4>活动时间</h4>
                <p>2017-07-15 08:00</p>
            </div>
            <div class="C-L-right">
                <h4>活动地点</h4>
                <p>惠州虹海湾二期</p>
            </div>
        </div>
        <div class="C-list clearfix">
            <h4>集合地点</h4>
            <p>深圳香蜜湖度假村停车场A区/深大地铁站C口，免费大巴接送</p>
        </div>
        <div class="C-list clearfix">
            <h4>活动内容</h4>
            <p>海边茶歇、亲子摄影、沙滩寻宝、DIY、海边风筝(全程免费)</p>
        </div>
    </div>
</div>
<footer>
    <a class="btn btn-red" href="./enroll">马上报名</a>
</footer>
</body>
</html>