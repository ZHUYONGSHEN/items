<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="decorator" content="admin"/>
    <title>分享</title>
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
    <li class="head_nav_chear">
        <p class="head_icon_txover_no"></p>
        <a href="./toAddButton?id=${id}&albumId=${albumId}">
            <span class="head_icon_big head_icon_three head_icon_cheack"></span>
            <p class="head_icon_tx">按钮</p>
        </a>
    </li>
    <%-- <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a href="./toaddZuoCeButton?id=${id}&albumId=${albumId}">
            <span class="head_icon_big head_icon_four head_icon_cheack"></span>
            <p class="head_icon_tx">左侧及下方按钮</p>
        </a>
    </li> --%>
    <li class="head_nav_chear_no">
        <a href="" class="cur">
            <span class="head_icon_big head_icon_four head_icon_yes"></span>
            <p class="head_icon_tx">推广信息</p>
        </a>
    </li>
</div>
<div class="mian_com clear">
<form id="form-fenxiang-add">
	<div class="connter_mian_list3 fl" style="width: 940px;min-width:940px;">
		<div class="br_dash_b">
		<!-- 头像设置 -->
		<li class="connter_module_title clear"><i class="redStar"></i>头像 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
        <li class="clear list_li_com pb38 divImageUpload">
				<div class="clear">
					<img src="<c:if test="${empty lsList.headImageUrl }">${backStatic}/images/img_logo1.png</c:if><c:if test="${not empty lsList.headImageUrl}">${fns:getCosAccessHost()}${lsList.headImageUrl}</c:if>" class="load_img_com mr10 fl" width="100"/>
					<div class="fl mt20">
						<label class="label_load_img">
							上传图片<input type="file" name="file" id="touxiangFile" class="hide_com inputImageUpload details_head_img"/>
						</label>
						<input type="button" class="lianjieqidelte <c:if test="${empty lsList.headImageUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
						<input type="hidden" name="headImageUrl" value="${lsList.headImageUrl}" id="headImageUrl">
						<p class="warn_info">*格式:JPG,PNG,尺寸:200*200(像素)</p>
					</div>
				</div>
				<div class="mt10 color_29353d">固定名字:<input type="text" style="height:30px;line-height:30px;width:200px;" maxlength="6" name="fixedName" value="${lsList.fixedName}" class="btn_tx_com_connter_link ml10" placeholder="请填写6个字之内的固定姓名"/></div>
        </li>
        </div>
        <input type="hidden"  value="1" name="headType"/>
        <!-- 电话设置 -->
        <div class="clear mb20 list_li_com" style="width: 940px;min-width:940px;border-bottom:1px solid #ccc;">
        	<div class="connter_module_title clear ml130"><i class="redStar"></i>电话设置 </div>
        	<div class="fl span_com ml130">电话号码:</div>
        	<div class="fl mb20"><input class="pl3" name="telephone" value="${lsList.telephone}"style="border:1px solid #ccc;width:230px;height:30px;line-height:30px;"></div>
        </div>
        <!-- 地区设置 -->
        <div class="br_dash_b">
	        <li class="connter_module_title clear"><i class="redStar"></i>地区设置 </li>
	        <li class="clear mb20 list_li_com">
	        	<span class="fl span_com">所在公司:</span>
	        	<input type="hidden" name="companyInfoId" value="${lsList.companyInfoId}"/>
	            <input type="text" style="width:265px;height:30px;line-height:30px;" name="companyName" value="${companyInfo.companyName}" class="btn_tx_com_connter" placeholder="请输入所在公司"/>
	        </li>
	        <li class="clear mb20 list_li_com">
	        	<span class="fl span_com">公司所在地区:</span>
	        	<select id="province" onchange="doProvAndCityRelation();" style="border:1px solid #d6dee4;height:50px;">
			  　　  	<option id="choosePro"value="-1">省份</option>
			  　　  </select>
				<select id="citys"   onchange="doCityAndCountyRelation();" style="border:1px solid #d6dee4;height:50px;width:136px;">
				 	<option id='chooseCity' value='-1' >城市</option>
				</select>
				<select id="county"  style="border:1px solid #d6dee4;height:50px;width:136px;">
				 	<option id='chooseCounty' value='-1'>片区</option>
				</select>
	        </li>
        </div>
        <!--logo设置  -->
        <div class="list3divlisht br_dash_b">
			<li class="connter_module_title clear" style="width: 940px;min-width:940px;">logo设置 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
			
			<li class="clear pb38 list_li_com divImageUpload">
                <span class="fl span_com">左上logo:</span>
                <div class="fl div_up_img_nonebg w_540">
                    <img src="<c:if test="${empty topLeftLogo}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty topLeftLogo}">${fns:getCosAccessHost()}${topLeftLogo}</c:if>" class="load_img_com mr10 fl" width="100" style="margin-top:28px"/>
                    <div class="fl mt20">
                        <label class="label_load_img">
                            	上传图片<input type="file" name="file" id="zuoshanglogo" class="hide_com inputImageUpload list4_logo left-logosss"/>
                        </label>
						<input type="hidden" name="topLeftLogo" id="topLeftLogo" value="${topLeftLogo}">
                        <input type="button" class="lianjieqidelte <c:if test="${empty topLeftLogo}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
                        <p class="warn_info">*格式:JPG,PNG,尺寸:200*64(像素)</p>
                    </div>
                </div>
            </li>
		</div>
			<input type="hidden" name="objectId" id="objectId" value="${id}">
			<input type="hidden" name="id" id="id" value="${lsList.id}">
		<!-- 分享设置 -->
		<li class="connter_module_title clear">分享设置 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/fengxiang.jpg" /></span></li>
			
		<li class="clear mb20 list_li_com">
                <span class="fl span_com">标题:</span>
                <label class="radio_label_click mr60 standards"><i class="type_selects_i radio_<c:if test="${lsList.titleType == 0||lsList.titleType==null}">yes</c:if><c:if test="${lsList.titleType != 0 && lsList.titleType != null }">no</c:if> mr5"></i><input type="radio" class="mr5 hide_com" <c:if test="${lsList.titleType == 0|| lsList.titleType==null}">checked="checked"</c:if> name="titleType" value="0"/>标准</label>
            	<label class="ml20 radio_label_click mr60 standards"><i class="type_selects_i radio_<c:if test="${lsList.titleType == 1}">yes</c:if><c:if test="${lsList.titleType != 1}">no</c:if> mr5"></i><input type="radio" <c:if test="${lsList.titleType == 1}">checked="checked"</c:if> class="ml10 mr5 hide_com" value="1" name="titleType"/>系统统计</label>
                <div>
                	<input type="text" style="width:265px;height:30px;line-height:30px;" name="shareEntryTitle" value="${lsList.shareEntryTitle}" class="btn_tx_com_connter ml130 inputs" data-reg="empstyflasesix" maxlength="20" placeholder="请输入20个字之内的标题"/>
               		
               	</div>
                
		    			<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
        </li>
			
			<li class="clear mb20 list_li_com">
                <span class="fl span_com">描述:</span>
                <textarea class="btn_tx_com_textarea fl" name="shareBewrite" placeholder="请输入50个字之内的描述" maxlength="50">${lsList.shareBewrite}</textarea>
            </li>
			
			<li class="clear mb20 list_li_com divImageUpload">
                <span class="fl span_com">小方图:</span>
                <div class="div_up_img_nonebg fl w_540">
                    <div class="clear">
                        <img src="<c:if test="${empty lsList.squareMap}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty lsList.squareMap}">${fns:getCosAccessHost()}${lsList.squareMap}</c:if>" class="load_img_com mr10 fl" width="100"/>
                        <div class="fl mt20">
                            <label class="label_load_img">
                                上传图片<input type="file" name="file" id="xiaofangtu" class="hide_com inputImageUpload xiao_fang_tu"/>
                            </label>
							<input type="hidden" name="squareMap" id="squareMap" value="${lsList.squareMap}">
                            <input type="button" class="lianjieqidelte <c:if test="${empty lsList.squareMap}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
                            <p class="warn_info">*格式:JPG,PNG,尺寸:100*100(像素)</p>
                        </div>
                    </div>
                </div>
            </li>
			
<!-- 			<li class="clear mb20 list_li_com"> -->
<!--                 <span class="fl span_com">链接:</span> -->
<%--                 <input type="text" value="${lsList.shareUrl}" name="shareUrl" class="btn_tx_com_connter fl"/> --%>
<!--             </li> -->
	<!--         <li class="clear mb20 list_li_com"> -->
	<!--             <span class="fl span_com">链接:</span> -->
	<!--             <input type="text" class="btn_tx_com fl"/> -->
	<!--         </li> -->
			<li class="clear pb38 pt28 list_li_com">
                <span class="span_com">&nbsp;</span>
                <input type="button" onclick="backhref();" value="上一步" class="btn_tx_com_connter_sub btn_tx_com_connter_ccc mr20"/>
                <input type="button" id="ajaxSubmit1" onclick="forwardindex();" value="预览" class="btn_tx_com_connter_sub btn_tx_com_connter_yulan mr20"/>
                <input type="button" id="ajaxSubmit" onclick="addShare();" value="保存" class="btn_tx_com_connter_sub btn_tx_com_connter_bule"/>
            </li>
		</form>
	</div>
	<div class="fl com_list_right" style="margin-left:20px;">
        <li class="mb20">
            <div id="qrCode" class="load_img_com qrCode"/></div>
            <p>请使用微信扫一扫预览</p>
        </li>
        <li>
            <input type="text" class="btn_type_tx_list5" id="objectUrl" readonly="readonly"/>
            <span class="copy_tx_input" data-clipboard-target="objectUrl" id="d_clip_button">复制</span>
        </li>
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
<script src="${backStatic}/js/ajaxfileupload.js"></script>
<script src="${backStatic}/js/jquery.qrcode.min.js"></script>
<script src="${backStatic}/js/cityData.js"></script>

<script type="text/javascript">
/* 分享标题选择 */
$(".standards").click(function(){
	var _index=$(this).index();
	if(_index==2){
		$(".inputs").attr("placeholder","我是第x个江山地颜值控");
	}else if(_index==1){
		$(".inputs").attr("placeholder","请输入20个字之内的标题");
	}
});

var pro = '${companyInfo.province}';
var cityV = '${companyInfo.city}';
var countyV = '${companyInfo.area}';
var fyType = '${fyType}';
var oldParams=null;
var params=null; 
$(function(){
	oldParams=$("#form-fenxiang-add").serialize();
});

$("#d_clip_button").click(function() {
    var text = $(this).siblings('input').val();
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val(text).select();
    document.execCommand("copy");
    $temp.remove();
    alert("已复制到剪切板")
});
function backhref(){
	window.location.href = "${siteRoot}/object/toAddButton?id=${id}";
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
 			input = div.find('[type=text]');
 		}
 		var img = div.find('img');
 		if((allowExtention.indexOf(extention)>-1)){
 			if (navigator.userAgent.indexOf("MSIE")>=1) { // IE
 				loadimg.attr('src',_self.val())
 			} else {
 				loadimg.attr( 'src',window.URL.createObjectURL(_self[0].files.item(0)))
 			}
 			loadimg.bind('load',function(){
 				if(_self.is('.details_head_img')){
 					if(loadimg[0].naturalHeight!="200"){
 	 					alert('请上传规定的图片尺寸')
 	 					return false;
 	 				}
 	 				if(loadimg[0].naturalWidth!="200"){
 	 					alert('请上传规定的图片尺寸')
 	 					return false;
 	 				}
 				}else if(_self.is('.xiao_fang_tu')){
 					if(loadimg[0].naturalHeight!="100"){
 	 					alert('请上传规定的图片尺寸')
 	 					return false;
 	 				}
 	 				if(loadimg[0].naturalWidth!="100"){
 	 					alert('请上传规定的图片尺寸')
 	 					return false;
 	 				}
 				}else if(_self.is(".left-logosss")){
 					if(loadimg[0].naturalHeight!="64"){
 	 					alert('请上传规定的图片尺寸')
 	 					return false;
 	 				}
 	 				if(loadimg[0].naturalWidth!="200"){
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
 		 					input.val(data.cosFilePath);
 		 					img.attr("src",data.cosData.access_url);
 		 					lianjieqidelte.show()
 		 				}else{
 		 					alert(data.returnMsg)
 		 				}
 		 			},
 		 			error: function (data, status, e){
 		 				alert("上传失败");
 		 			}
 		 		});		
 			})
 		}else{
 			alert('请上传规定的图片格式')
 			return false;
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
$(function() {
	var ip_addr = document.location.hostname;
	var objectUrl = 'http://'+ip_addr+'/linker/${id}';
	$("#objectUrl").val(objectUrl);
	$('#qrCode').qrcode(objectUrl); //任意字符串 
});

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
 $('body').on('blur','.reg_rempty',function(){
 	blur_reg_is_true =reg_input({el:$(this),blur_istrue:true})
 })
$('body').on('click','.lianjieqiicon',function(){
	var _this = $(this)
	$(this).parent().siblings('img').attr('src',_this.data('val'))
	$(this).siblings('[type="hidden"]').val(_this.data('val'))
})
function yanzheng(){
	 var headImageUrl = $("input[name='headImageUrl']").val();
	 var fixedName = $("input[name='fixedName']").val();
	 var telephone = $("input[name='telephone']").val();
	// var reg =/^(0|86|17951)?(13[0-9]|15[012356789]|17[013678]|18[0-9]|14[57])[0-9]{8}$/;
	// var reg1 =/^(((400)-(\d{3})-(\d{4}))|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{3,7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)$/;
	// var reg2 =/^(((0\d{3}[\-])?\d{7}|(0\d{3}[\-])?\d{8}|(0\d{2}[\-])?\d{8}))([\-]\d{2,4})?$/;
	 if(fyType != "2"){
		 if(!headImageUrl){
			 alert("头像不能为空");
			 return false;
		 }
		 if(!fixedName){
			 alert("姓名不能为空");
			 return false;
		 }
		 if(!telephone){
			 alert("手机号不能为空");
			 return false;
		 }
		/*  if(!reg.test(telephone) && !reg1.test(telephone) && !reg2.test(telephone)){
			 alert("手机号格式不正确");
			 return false;
		 } */
		 return true;
	 }else{
		 if((headImageUrl && fixedName && telephone) || (!headImageUrl && !fixedName && !telephone)){
			 /* if(telephone){
				 if(!reg.test(telephone) && !reg1.test(telephone) && !reg2.test(telephone)){
					 alert("手机号格式不正确");
					 return false;
				 }
			 } */
			 return true;
		 }else{
			 alert("头像姓名手机要么都填写,要么都不填");
			 return false;
		 }
	 }
 }
function addShare(){
	var formo = $("#form-fenxiang-add");
	reg_is_true  = reg_input({el:$('.reg_rempty'),blur_istrue:false})
	var flag = yanzheng();
	if(!flag){
		return false;
	}
	 var titleType = $("input[name='titleType']:checked").val();
	if(titleType == 1){
		var shareEntryTitle = $("input[name='shareEntryTitle']").val();
		var reg = /x/ig;
		var result = shareEntryTitle.match(reg);
		if (!result || result.length!=1) {
			alert("分享标题必须只包含一个x");
			return false;
		}
	}
		params=formo.serialize();
 		var d=params+"&formchanged="+(params!=oldParams);
 		var province = $("#province").find("option:selected").text();
 		var city = $("#citys").find("option:selected").text();
 		var area = $("#county").find("option:selected").text();
 		d += "&province="+province+"&city="+city+"&area="+area;
 		$("#ajaxSubmit").attr("disabled","disabled");
		$.ajax({
	        type: "POST",
	        url: "./addShare.sys",
	        data: d,
	        success: function (res) {
	        	window.location.href="./objectList";
	        },
	        error: function(data) {
	            alert("新增用户失败！");
				$("#ajaxSubmit").removeAttr("disabled");
	         }
	    }); 
}
 function forwardindex(){
	 	var formo = $("#form-fenxiang-add");
	 	var flag = yanzheng();
		if(!flag){
			alert("头像姓名手机要么都填写,要么都不填");
			return false;
		}
		var titleType = $("input[name='titleType']:checked").val();
		if(titleType == 1){
			var shareEntryTitle = $("input[name='shareEntryTitle']").val();
			var reg = /x/ig;
			var result = shareEntryTitle.match(reg);
			if (!result || result.length!=1) {
				alert("分享标题必须只包含一个x");
				return false;
			}
		}
//	 	reg_is_true  = reg_input({el:$('.reg_rempty'),blur_istrue:false})
		//if(reg_is_true.istrue){
			params=formo.serialize();
 			var d=params+"&formchanged="+(params!=oldParams);
			$("#ajaxSubmit1").attr("disabled","disabled");
			$.ajax({
		        type: "POST",
		        url: "./addShare.sys",
		        data: d,
		        success: function (res) {
		        	console.log(res);
					$("#ajaxSubmit1").removeAttr("disabled");
		//         	var accountId = $("#accountId").val();
		//         	var token = $("#token").val();
		        	
		        	$('#forwardiframe').attr('src',"../linker/${id}")
		        	$('#delforwardiframemian').show()
					//window.open("../linker/index?objectId="+res.id);
		        },
		        error: function(data) {
		            alert("新增用户失败！");
					$("#ajaxSubmit1").removeAttr("disabled");
		         }
		    });
		//}
	}
 $('#delforwardiframe').click(function(){
	 window.location.href = "./toaddFenXiang?id="+$("#objectId").val()+"&albumId=${albumId}";
 }) 

</script>
</body>
</html>