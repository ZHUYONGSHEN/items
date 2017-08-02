<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="admin"/>
    <title>左侧按钮</title>
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
        <a href="${siteRoot}/object/toaddObject?id=${id}">
            <span class="head_icon_big head_icon_one head_icon_cheack"></span>
            <p class="head_icon_tx">基本信息</p>
        </a>
    </li>
    <li class="head_nav_chear">
        <p class=" head_icon_txover"></p>
        <a href="${siteRoot}/object/toAlbum?id=${id}">
            <span class="head_icon_big head_icon_two head_icon_cheack"></span>
            <p class="head_icon_tx">相册</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a href="./toaddYouCeButton?id=${id}&albumId=${albumId}">
            <span class="head_icon_big head_icon_three head_icon_cheack"></span>
            <p class="head_icon_tx">右侧按钮</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a href="" class="cur">
            <span class="head_icon_big head_icon_four head_icon_yes"></span>
            <p class="head_icon_tx">左侧及下方按钮</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <a>
            <span class="head_icon_big head_icon_free head_icon_no"></span>
            <p class="head_icon_tx">分享</p>
        </a>
    </li>
</div>
<div class="mian_com">
	<div class="connter_mian_list3 br_dash">
		<form id="form-leftButton-add">
			<input type="hidden" name="objectId" value="${id}">
			<input type="hidden" name="id" value="${leftButton.id}" id="id">
			<div class="list3divlisht br_dash_b">
			<li class="connter_module_title clear">logo设置 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
			
			<li class="clear pb38 list_li_com divImageUpload">
                <span class="fl span_com">左上logo:</span>
                <div class="fl div_up_img_nonebg w_540">
                    <img src="<c:if test="${empty leftButton.topLeftLogo}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty leftButton.topLeftLogo}">${fns:getCosAccessHost()}${leftButton.topLeftLogo}</c:if>" class="load_img_com mr10 fl" width="100"/>
                    <div class="fl mt20">
                        <label class="label_load_img">
                            上传图片<input type="file" name="file" id="zuoshanglogo" class="hide_com inputImageUpload list4_logo"/>
                        </label>
						<input type="hidden" name="topLeftLogo" id="topLeftLogo" value="${leftButton.topLeftLogo}">
                        <input type="button" class="lianjieqidelte <c:if test="${empty leftButton.topLeftLogo}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
                        <p class="warn_info">*格式:JPG,PNG,尺寸:200*200(像素)</p>
                    </div>
                </div>
            </li>
			</div>
			<div class="list3divlisht br_dash_b">
			<li class="connter_module_title clear">语音 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
			
			<li class="clear mb20 list_li_com">
                <span class="fl span_com">入口标题:</span>
                <input type="text" name="yyEntryTitle" value="${leftButton.yyEntryTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
            	<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
            </li>
			
			<li class="clear mb20 list_li_com divImageUpload">
                <span class="fl span_com">入口图标:</span>
                <div class="fl div_up_img_nonebg">
                    <img src="<c:if test="${empty leftButton.yyEntryIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/new_music.png </c:if><c:if test="${not empty leftButton.yyEntryIcon}">${fns:getCosAccessHost()}${leftButton.yyEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
                    <div class="fl mt20 w_396">
                        <label class="label_load_img">
                            上传图片<input type="file" name="file" id="yyrukoutu" class="hide_com inputImageUpload rukou_icon"/>
                        </label>
                        <input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/new_music.png" data-vals="/material/sys/linker/default/new_music.png" value="还原默认图标"/>
						<input type="hidden" name="yyEntryIcon" id="yyEntryIcon" value="<c:if test="${empty leftButton.yyEntryIcon}">/material/sys/linker/default/new_music.png </c:if><c:if test="${not empty leftButton.yyEntryIcon}">${leftButton.yyEntryIcon}</c:if>">
                        <p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
                    </div>
                </div>
            </li>
			
			<li class="clear mb20 list_li_com divImageUpload">
                <span class="fl span_com">暂停图标:</span>
                <div class="fl div_up_img_nonebg w_540">
                    <img src="<c:if test="${empty leftButton.yyStopIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/close_music.png </c:if><c:if test="${not empty leftButton.yyStopIcon}">${fns:getCosAccessHost()}${leftButton.yyStopIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
                    <div class="fl mt20">
                        <label class="label_load_img">
                            上传图片<input type="file" name="file" id="yyzantingtu" class="hide_com inputImageUpload rukou_icon"/>
                        </label>
                        <input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/close_music.png" data-vals="/material/sys/linker/default/close_music.png" value="还原默认图标"/>
						<input type="hidden" name="yyStopIcon" id="yyStopIcon" value="<c:if test="${empty leftButton.yyStopIcon}">/material/sys/linker/default/close_music.png </c:if><c:if test="${not empty leftButton.yyStopIcon}">${leftButton.yyStopIcon}</c:if>">
                        <p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
                    </div>
                </div>
            </li>

			<li class="clear mb20 list_li_com divImageUpload">
                <span class="fl span_com">上传语音:</span>
                <audio src="<c:if test="${not empty leftButton.yyUrl}">${fns:getCosAccessHost()}${leftButton.yyUrl}</c:if>" controls="controls" class="audio_up_load fl mr10"></audio>
                <label class="label_load_img fl mr10">
                    上传语音<input type="file" name="file" id="yyFile" class="hide_com inputImageUpload"/>
                </label>
                <span class="lianjieqidelte fl <c:if test="${empty leftButton.yyUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png"/>删除语音</span>
                <p class="warn_info fl">*格式:mp3</p>
				<input type="text" class="btn_tx_com fl hide_com" name="yyUrl" id="yyUrl" value="${leftButton.yyUrl}" readonly="readonly"/>
            </li>
			
			<li class="clear list_li_com pb38">
                <span class="fl span_com">语音适用页面:</span>
                <select class="alert_select" name="yySyPage">
	            	<option value="0" <c:if test="${rightObject.yySyPage == 0}">selected="selected"</c:if>>首页</option>
	            	<%--<option value="1" <c:if test="${rightObject.yySyPage == 1}">selected="selected"</c:if>>详情页</option>
	            	<option value="2" <c:if test="${rightObject.yySyPage == 2}">selected="selected"</c:if>>首页+详情页</option>
	            	<option value="3" <c:if test="${rightObject.yySyPage == 3}">selected="selected"</c:if>>每个720场景</option> --%>
				</select>
            </li>
			</div>
			<c:if test="${object.panoType=='zoomingPano'}">
				<div class="list3divlisht br_dash_b">
				<li class="connter_module_title clear">自动旋转 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
				
				<li class="clear list_li_com pb38">
	                <span class="fl span_com">自动旋转:</span>
	                <label class="radio_label_click w_200"><i class="radio_<c:if test="${leftButton.autorotationType == 0}">yes</c:if><c:if test="${leftButton.autorotationType != 0 }">no</c:if> mr5"></i><input type="radio" class="mr5 hide_com" <c:if test="${leftButton.autorotationType == 0}">checked="checked"</c:if> name="autorotationType" value="0"/>不需要自动旋转</label>
	                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${leftButton.autorotationType == 1  || leftButton.autorotationType == null}">yes</c:if><c:if test="${leftButton.autorotationType == 0}">no</c:if> mr5"></i><input  type="radio" <c:if test="${leftButton.autorotationType == 1  || leftButton.autorotationType == null}">checked="checked"</c:if> class="ml10 mr5 hide_com" value="1" name="autorotationType"/>需要自动旋转</label>
	            </li>
				</div>
				<div class="list3divlisht br_dash_b">
				<li class="connter_module_title clear">手机陀螺仪 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
				
				<li class="clear list_li_com pb38">
	                <span class="fl span_com">手机陀螺仪:</span>
	                <label class="radio_label_click w_200"><i class="radio_<c:if test="${leftButton.sjtlyType == 0 || leftButton.sjtlyType == null}">yes</c:if><c:if test="${leftButton.sjtlyType == 1}">no</c:if> mr5"></i><input type="radio" name="sjtlyType" <c:if test="${leftButton.sjtlyType == 0 || leftButton.sjtlyType == null}">checked="checked"</c:if> value="0" class="mr5 hide_com"/>不需要手机陀螺仪</label>
	                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${leftButton.sjtlyType == 1}">yes</c:if><c:if test="${leftButton.sjtlyType != 1}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com" <c:if test="${leftButton.sjtlyType == 1}">checked="checked"</c:if> value="1" name="sjtlyType"/>需要手机陀螺仪</label>
	            </li>
				</div>
				<div class="list3divlisht br_dash_b">
				<li class="connter_module_title clear">VR看房 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
				
				<li class="clear list_li_com pb38">
	                <span class="fl span_com">VR看房:</span>
	                <label class="radio_label_click w_200"><i class="radio_<c:if test="${leftButton.vrShowingsType == 0 || leftButton.vrShowingsType == null}">yes</c:if><c:if test="${leftButton.vrShowingsType == 1}">no</c:if> mr5"></i><input type="radio" name="vrShowingsType" <c:if test="${leftButton.vrShowingsType == 0 || leftButton.vrShowingsType == null}">checked="checked"</c:if> value="0" class="mr5 hide_com"/>不需要VR看房</label>
	                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${leftButton.vrShowingsType == 1}">yes</c:if><c:if test="${leftButton.vrShowingsType != 1}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com" <c:if test="${leftButton.vrShowingsType == 1}">checked="checked"</c:if> value="1" name="vrShowingsType"/>需要VR看房</label>
	            </li>
				</div>
			</c:if>
			<div class="list3divlisht br_dash_b">
			<li class="connter_module_title clear">下方按钮 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
			
<!-- 			新增 -->
			<c:if test="${leftButton.id == null}">
			<li class="clear mb20 list_li_com">
                <ul class="ziyidinganan">
                    <li class="clear mb20 list_li_com">
                        <span class="fl span_com">入口标题:</span>
                        <input type="text" name="xfanEntryTitle" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
		    			<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
                    </li>
                    <li class="clear mb20 list_li_com divImageUpload">
                        <span class="fl span_com">入口图标:</span>
                        <div class="fl div_up_img_nonebg w_540">
                            <img src="${backStatic}/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>
                            <div class="fl mt20">
                                <label class="label_load_img">
                                    上传图片<input type="file" name="file" id="xiafangrukoutu" class="hide_com inputImageUpload rukou_icon"/>
                                </label>
								<input type="hidden" name="xfanEntryIcon" id="xfanEntryIcon">
                                <input type="button" class="lianjieqidelte hide_com" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
                                <p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
                            </div>
                        </div>
                    </li>
                    <li class="clear mb20 list_li_com">
                        <span class="fl span_com">链接:</span>
                        <input type="text" name="xfanUrl" maxlength="80" class="btn_tx_com_connter fl link_reg_input"/>
                    </li>
                </ul>
            </li>
            </c:if>
<!--             修改 -->
			<c:if test="${leftButton.id != null}">
			<c:forEach items="${customList}" var="customList" varStatus="index">
			<li class="clear mb20 list_li_com">
                <ul class="ziyidinganan">
                    <li class="clear mb20 list_li_com">
                        <span class="fl span_com">入口标题:</span>
                        <input type="text" name="xfanEntryTitle" value="${customList.xfanEntryTitle}" class="btn_tx_com_connter fl" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
		    			<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
                    </li>
                    <li class="clear mb20 list_li_com divImageUpload">
                        <span class="fl span_com">入口图标:</span>
                        <div class="fl div_up_img_nonebg w_540">
                            <img src="<c:if test="${empty customList.xfanEntryIcon}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty customList.xfanEntryIcon}">${fns:getCosAccessHost()}${customList.xfanEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
                            <div class="fl mt20">
                                <label class="label_load_img">
                                    上传图片<input type="file" name="file" id="xiafang_rukoutu${index.index}" class="hide_com inputImageUpload rukou_icon"/>
                                </label>
								<input type="hidden" name="xfanEntryIcon" id="xfanEntryIcon" value="${customList.xfanEntryIcon}">
                                <input type="button" class="lianjieqidelte <c:if test="${empty customList.xfanEntryIcon}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
                                <p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
                            </div>
                        </div>
                    </li>
                    <li class="clear mb20 list_li_com">
                        <span class="fl span_com">链接:</span>
                        <input type="text" name="xfanUrl" maxlength="80" value="${customList.xfanUrl}" class="btn_tx_com_connter fl link_reg_input"/>
                    </li>
                </ul>
                <c:if test="${index.index >= 1}">
                	<i class="icon_module_del click_module_del click_module_del_btn_list"></i>
            	</c:if>
            </li>
			</c:forEach>
			</c:if>
			
			<li class="clear mb40 list_li_com">
                <i class="new_module" id="click_new_btn_list"><i class="icon_cunt mr10"></i>新增下方按钮</i>
            </li>
			</div>
			<c:if test="${object.panoType=='zoomingPano'}">
				<li class="clear m30 list_li_com pt38">
	                <span class="fl span_com">爱心点赞:</span>
					<label class="radio_label_click"><i class="radio_<c:if test="${leftButton.loveLike == 0 || leftButton.loveLike == null}">yes</c:if><c:if test="${leftButton.loveLike == 1}">no</c:if> mr5"></i><input type="radio" name="loveLike" <c:if test="${leftButton.loveLike == 0 || leftButton.loveLike == null}">checked="checked"</c:if> value="0" class="mr5 hide_com"/>不需要爱心点赞</label>
					<label class="ml20 radio_label_click"><i class="radio_<c:if test="${leftButton.loveLike == 1}">yes</c:if><c:if test="${leftButton.loveLike != 1}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com" <c:if test="${leftButton.loveLike == 1}">checked="checked"</c:if> value="1" name="loveLike"/>需要爱心点赞</label>
	            </li>
            </c:if>
	
			
			<li class="clear pb38 pt50 list_li_com">
				<span class="span_com">&nbsp;</span>
                <input type="button" onclick="backhref();" value="上一步" class="btn_tx_com_connter_sub btn_tx_com_connter_ccc mr20"/>
                <input type="button" id="ajaxSubmit1" onclick="forwardindex();" value="预览" class="btn_tx_com_connter_sub btn_tx_com_connter_yulan mr20"/>
                <input type="button" id="ajaxSubmit" onclick="addZuoCeButton();" value="保存并下一步" class="btn_tx_com_connter_sub btn_tx_com_connter_bule"/>
			</li>
		</form>
	</div>
</div>
<div  class="right_del_mian hide_com">
    <div>
        <p class="alert_title">删除</p>
        <div class="alert_deleta_mian">
            <img src="${backStatic}/images/warnicon.png" class="warunicon">确定要删除吗?
        </div>
    </div>
</div>
<div id="delforwardiframemian" class="hide_com">
	<span id="delforwardiframe" class="delforwardiframe"></span>
	<div class="delforwardiframebg">
	</div>
	<iframe id="forwardiframe" class="fowrdiframe">
	</iframe>
</div>
<script>
var backstaticurl="${backStatic}"
</script>
<script src="${backStatic}/js/list4_1.js"></script>
<script src="${backStatic}/js/ajaxfileupload.js"></script>

<script type="text/javascript">

function backhref(){
	window.location.href = "${siteRoot}/object/toaddYouCeButton?id=${id}&albumId=${albumId}";
}

/**
 * ajax背景图上传
 */
 	$('.mian_com').on('change', '.inputImageUpload', function(){
 		var div = $(this).parents('.divImageUpload');
 		var input = div.find('[type=hidden]');
 		var lianjieqidelte = div.find(".lianjieqidelte")
 		var allowExtention=".jpg,.jpeg,.png";//允许上传文件的后缀名
 		var mp3reg=".mp3";//允许上传文件的后缀名
 		var mp4reg=".mp4";//允许上传文件的后缀名
 		var extention=$(this).val().substring($(this).val().lastIndexOf(".")+1).toLowerCase();
 		var browserVersion= window.navigator.userAgent.toUpperCase();
 		var _self =$(this)
 		var loadimg = $('<img src=""/>')
 		
 		if(typeof(input[0])  == "undefined"){
 			input = div.find('audio');
 			if(input.length!=0){
	 			if(!(mp3reg.indexOf(extention)>-1)){
	 				alert('请上传规定的音频格式')
	 				return false;
	 			}
	 			if($(this)[0].files[0].size <='5120'){
	 				alert('请上传规定大小的音频')
	 				return false;
	 			}
 			}
 		}
 		var img = div.find('img');
 		if(img.length !=0){
 			if((allowExtention.indexOf(extention)>-1)){
	 			if (navigator.userAgent.indexOf("MSIE")>=1) { // IE
	 				loadimg.attr('src',_self.val())
	 			} else {
	 				loadimg.attr( 'src',window.URL.createObjectURL(_self[0].files.item(0)))
	 			}
	 			loadimg.bind('load',function(){
	 				if(_self.is('.list4_logo')){
	 					if(loadimg[0].naturalHeight!="200"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="200"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 				}else if(_self.is('.rukou_icon')){
	 					if(!(".png".indexOf(extention)>-1)){
	 						alert('请上传规定的图片格式')
	 	 					return false;
	 					}
	 					if(loadimg[0].naturalHeight!="72"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="72"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 				}
	 				$.ajaxFileUpload({
	 		 			url:"${siteRoot}/object/uploadfile",
	 		 			secureuri:false,
	 		 			fileElementId:_self[0].id,
	 		 			dataType:'json',
	 		 			data:{
	 		 				preImg:input.val()
	 		 			},
	 		 			beforeSend:function(){
	 		 			},
	 		 			complete:function(){
	 		 			},				
	 		 			success: function (data, status){
	 		 				//上传成功 将图片的路径写入隐藏域
	 		 				if(data.returnCode=="SUCCESS"){
	 		 					if(input[0].nodeName != 'INPUT'){
	 		 						input.siblings('input').val(data.cosData.resource_path);
	 		 						console.log(input.siblings('input'));
	 		 						input.attr("src",data.cosData.access_url);
	 		 						lianjieqidelte.show()
	 		 					}else{
	 		 						input.val(data.cosData.resource_path);
	 			 					img.attr("src",data.cosData.access_url);
	 			 					lianjieqidelte.show()
	 		 					}
	 		 				}else{
	 		 					alert(data.returnMsg)
	 		 				}
	 		 			},
	 		 			error: function (data, status, e){
	 		 				alert("上传失败"+e);
	 		 			}
	 		 		});	
	 			})
 			}else{
 				alert('请上传规定的图片格式')
				return false;
 			}
 		}else{
	 		$.ajaxFileUpload({
	 			url:"${siteRoot}/object/uploadfile",
	 			secureuri:false,
	 			fileElementId:_self[0].id,
	 			dataType:'json',
	 			data:{
	 				preImg:input.val()
	 			},
	 			beforeSend:function(){
	 			},
	 			complete:function(){
	 			},				
	 			success: function (data, status){
	 				
	 				//上传成功 将图片的路径写入隐藏域
	 				if(data.returnCode=="SUCCESS"){
	 					if(input[0].nodeName != 'INPUT'){
	 						input.siblings('input').val(data.cosData.resource_path);
	 						console.log(input.siblings('input'));
	 						input.attr("src",data.cosData.access_url);
	 						lianjieqidelte.show()
	 					}else{
	 						input.val(data.cosData.resource_path);
		 					img.attr("src",data.cosData.access_url);
		 					lianjieqidelte.show()
	 					}
	 				}else{
	 					alert(data.returnMsg)
	 				}
	 			},
	 			error: function (data, status, e){
	 				alert("上传失败"+e);
	 			}
	 		});	
 		}
 	})
 	$('body').on('click','.lianjieqidelte',function(){
 		var div = $(this).parents('.divImageUpload');
 		var input = div.find('[type=hidden]');
 		var lianjieqidelte = div.find(".lianjieqidelte")
 		var _this =$(this)
 		if(typeof(input[0])  == "undefined"){
 			input = div.find('audio');
 			if(input.length == 0){
 				input = div.find('video');
 			}
 		}
 		var img = div.find('img');
 		alertbox({
			msg:$('.right_del_mian').html(),tcallfn_tx:'删除',
			tcallfn:function(){
				if(input[0].nodeName != 'INPUT'){
						input.siblings('input').val('');
						input.attr("src",'');
						lianjieqidelte.hide()
					}else{
						input.val('');
	 					img.attr('src',lianjieqidelte.data('val'))
	 					lianjieqidelte.hide()
					}
				
			}
		});
 		
 	})
</script>

<script type="text/javascript">
var oldParams=null;
var params=null; 
$(function(){
	oldParams=$("#form-leftButton-add").serialize();
});

//js 表单验证
function Reg_input(opt){
 	this.istrue=false
 	this.inits(opt)
 }
 Reg_input.prototype = {
 	inits:function(opt){
 		var _this = this
 		_this.istrue;
 		var reg = this.reg()
		
 		if(!opt.blur_istrue){
 			opt.el.each(function(e){
 				_this.istrue=true
 				if(!reg[opt.el.eq(e).data('reg')].test($(this).val())){
 					_this.istrue=false
 					$(this).siblings('.warn_tx_com').show()
 					$("html,body").animate({scrollTop:$(this).siblings('.warn_tx_com').offset().top},300)
 					return false;
 				}else{
 				$(this).siblings('.warn_tx_com').hide()
 				}
 			})
 		}else{
 			_this.istrue=true
 			if(!reg[opt.el.data('reg')].test(opt.el.val())){
 				opt.el.siblings('.warn_tx_com').show()
 				_this.istrue=false
 			}else{
 			opt.el.siblings('.warn_tx_com').hide()
 			}
 		}
 	},
 	reg:function(){
 		return {
 			emptys:/\S/,
 			emptyssizeten:/^(?!.{11}|s*$)/g,
 			empstyflasesix:/^\S{0,6}$/g,
 			empstyflaseten:/^\S{0,10}$/g,
 			number:/\d+/
 		}
 	}
 }
 reg_input = function(opt){
 	return new Reg_input(opt)
 }
 var reg_is_true 
 var blur_reg_is_true
 var file_reg_is_true
$('body').on('click','.lianjieqiicon',function(){
	var _this = $(this)
	$(this).parent().siblings('img').attr('src',_this.data('val'))
	$(this).siblings('[type="hidden"]').val(_this.data('vals'))
})
function addZuoCeButton(){
	var formo = $("#form-leftButton-add");
	var ture_link= false;
	$('.link_reg_input').each(function(){
		if($(this).val()!=""){
	 		if(!isURL($(this).val())){
	 			ture_link=false
	 			alert('请填写正确的链接')
	 			$("html,body").animate({scrollTop:$(this).offset().top},300)
	 			return false
	 		}else{
	 			ture_link=true
	 		}
		}else{
			ture_link=true
		}
	});
	if($('.link_reg_input').length==0){
		ture_link=true;
	}
	if(!ture_link){
		return;
	}
	formo.find('.ziyidinganan').each(function(i){
		var zdyanEntryTitle =$(this).find('input[name="xfanEntryTitle"]')
		var zdyanEntryIcon =$(this).find('input[name="xfanEntryIcon"]')
		var zdyanUrl =$(this).find('input[name="xfanUrl"]')
		if(zdyanEntryTitle.val().trim()=='' && zdyanEntryIcon.val().trim()=='' && zdyanUrl.val().trim()==''){
			$(this).parent().remove()
		}
	})
 		params=formo.serialize();
 		var d=params+"&formchanged="+(params!=oldParams);
		$("#ajaxSubmit").attr("disabled","disabled");
		$.ajax({
	        type: "POST",
	        url: "./addZuoCeButton.sys",
	        data: d,
	        success: function (res) {
	        	window.location.href="./toaddFenXiang.sys?id="+res.id+"&albumId=${albumId}";
	        },
	        error: function(data) {
	            alert("新增用户失败！");
				$("#ajaxSubmit").removeAttr("disabled");
	         }
	    });
}
 
function forwardindex(){
 	var formo = $("#form-leftButton-add");
 	var ture_link= false;
	$('.link_reg_input').each(function(){
		if($(this).val()!=""){
	 		if(!isURL($(this).val())){
	 			ture_link=false
	 			alert('请填写正确的链接')
	 			$("html,body").animate({scrollTop:$(this).offset().top},300)
	 			return false
	 		}else{
	 			ture_link=true
	 		}
		}else{
			ture_link=true
		}
	});
	if($('.link_reg_input').length==0){
		ture_link=true;
	}
	if(!ture_link){
		return;
	}
	formo.find('.ziyidinganan').each(function(i){
		var zdyanEntryTitle =$(this).find('input[name="xfanEntryTitle"]')
		var zdyanEntryIcon =$(this).find('input[name="xfanEntryIcon"]')
		var zdyanUrl =$(this).find('input[name="xfanUrl"]')
		if(zdyanEntryTitle.val().trim()=='' && zdyanEntryIcon.val().trim()=='' && zdyanUrl.val().trim()==''){
			$(this).parent().remove()
		}
	})
		params=formo.serialize();
 		var d=params+"&formchanged="+(params!=oldParams);
		$("#ajaxSubmit1").attr("disabled","disabled");
		$.ajax({
	        type: "POST",
	        url: "./addZuoCeButton.sys",
	        data: d,
	        success: function (res) {
				$("#ajaxSubmit1").removeAttr("disabled");
	        	$("#id").val(res.zuoceId);
	        	
	        	$('#forwardiframe').attr('src',"./preview?id="+res.id)
	        	$('#delforwardiframemian').show()
	        },
	        error: function(data) {
	            alert("新增用户失败！");
				$("#ajaxSubmit1").removeAttr("disabled");
	         }
	    });
}

</script>
</body>
</html>