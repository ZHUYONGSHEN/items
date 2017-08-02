<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>腾讯街景链接</title>
	<meta name="decorator" content="admin"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#tencentPanoUrl").focus();
			$("#inputForm").validate({
				rules: {
					"tencentPanoUrl":{
						required:true,
						url:true
					}
				},
				messages: {
					"tencentPanoUrl":{
						required:"请填写腾讯街景链接",
						url:"请填写合法的腾讯街景链接"
					}
				}
			});
		});
	</script>
</head>
<body>
<div class="head_nav clear">
    <!--
        已经操作过的
            给li标签加上head_nav_chear样式
            给span标签加上head_icon_cheack样式
            给p标签加上head_icon_txover
        未操作过的
            给li标签加上head_nav_chear_no样式
            给span标签加上head_icon_no样式
            给p标签加上head_icon_txover_no
        正在操作的
            给span标签加上head_icon_yes样式
            给p标签加上head_icon_txover
    -->
    <li class="head_nav_chear">
        <p class=" head_icon_txover"></p>
        <a href="${siteRoot}/object/toaddObject?id=${object.id}">
            <span class="head_icon_big head_icon_one head_icon_cheack"></span>
            <p class="head_icon_tx">基本信息</p>
        </a>
    </li>
    <li class="head_nav_chear">
        <p class=" head_icon_txover"></p>
        <a href="" class="cur">
            <span class="head_icon_big head_icon_two head_icon_yes"></span>
            <p class="head_icon_tx">相册</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <!--  <a href="${siteRoot}/object/toaddYouCeButton?id=${linkerId}&albumId=${album.id}">-->
        <a>
            <span class="head_icon_big head_icon_three head_icon_no"></span>
            <p class="head_icon_tx">右侧按钮</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a>
            <span class="head_icon_big head_icon_four head_icon_no"></span>
            <p class="head_icon_tx">右侧及下方按钮</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <a>
            <span class="head_icon_big head_icon_free head_icon_no"></span>
            <p class="head_icon_tx">分享</p>
        </a>
    </li>
</div>
<div class="album_qq_link_mian">
	<form id="inputForm" action="${siteRoot}/object/updateTencentPanoUrl" method="post">
		<p class="mb10">请输入腾讯街景连接</p>
		<input type="hidden" name="id" value="${object.id}">
		<input type="text" id="tencentPanoUrl" maxlength="80" name="tencentPanoUrl" value="${object.tencentPanoUrl}">
		<div class="clear">
			<input type="button" class="fl" value="上一步" onclick="window.location.href = '${siteRoot}/object/toaddObject?id=${object.id}'">
			<input type="submit" class="fr" value="保存并下一步">
		</div>
	</form>
</div>
<!--切换连接-->
<div  class="tab_album_bottom_alert hide_com">
    <div>
        <p class="alert_title">切换为720相册</p>
        <div class="alert_deleta_mian">
            <img src="${backStatic}/images/warnicon.png" class="warunicon">确定要切换为720相册?
        </div>
    </div>
</div>
<div class="tab_album_bottom">
	<div class="tab_album_bottom_br"><span>or</span></div>
	<div class="tab_album_bottom_tx">
		暂无街景连接，<a id="tabalbumlink">切换到上传全景图片</a>
	</div>
</div>
<script>
//切换连接
$(function(){
	$('#tabalbumlink').click(function(){
		alertbox({
			msg:$('.tab_album_bottom_alert').html(),
			tcallfn_tx:'确定',
			tcallfn:function(){
				location.href="${backPath}/pano/album/togglePano?albumId=${albumId}&linkerId=${object.id}&panoType=zoomingPano"
			}
		})
	})
})
</script>
</body>
</html>