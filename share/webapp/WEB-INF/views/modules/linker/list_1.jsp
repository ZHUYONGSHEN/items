<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="admin"/>
    <title>基本信息</title>
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
        <a href="" class="cur">
            <span class="head_icon_big head_icon_one head_icon_yes"></span>
            <p class="head_icon_tx">基本信息</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a>
            <span class="head_icon_big head_icon_two head_icon_no"></span>
            <p class="head_icon_tx">相册</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a>
            <span class="head_icon_big head_icon_three head_icon_no"></span>
            <p class="head_icon_tx">按钮</p>
        </a>
    </li>
    <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a>
            <span class="head_icon_big head_icon_four head_icon_no"></span>
            <p class="head_icon_tx">推广信息</p>
        </a>
    </li>
    <!-- <li class="head_nav_chear_no">
        <a>
            <span class="head_icon_big head_icon_free head_icon_no"></span>
            <p class="head_icon_tx">分享</p>
        </a>
    </li> -->
</div>
<div class="mian_com">
	<div class="connter_mian">
		<form id="form-object-add">
			<input type="hidden" value="${id}" name="id" id="id">
			<input type="hidden" value="${object.albumId}" name="albumId" id="albumId">
			<input type="hidden" name="createBy" value="${createBy}" id="accountId"/>
			<li class="connter_module_title clear">基本信息 <span class="fr quesi_span"><i class="quesi_con"></i>示例 <img src="${backStatic}/images/shouye.png" style="display: block"/></span></li>
			<li class="clear mb20 list_li_com">
				<b class="redStar" style="float:left;margin-top:18px;margin-right:3px;"></b>
                <span class="fl span_com">项目名称:</span>
                <input type="text" name="objectName" value="${object.objectName}" maxlength="12" placeholder="请输入12个字之内的项目名称" class="btn_tx_com_connter fl reg_rempty" data-reg="emptys"/>
                <span class="warn_tx_com hide_com">*不能为空</span>
            </li>

			<li class="clear mb20 list_li_com">
                <span class="fl span_com" style="margin-left:14px;">项目简介:</span>
                <textarea rows="4" cols="4"  name="objectSynopsis" maxlength="50" placeholder="请输入50个字之内的项目简介"  class="btn_tx_com_connter fl" style="height: 100px;line-height:25px">${object.objectSynopsis}</textarea>
                <!-- <span class="warn_tx_com hide_com">*不能为空</span> -->
            </li>
            
			<li class="clear mb20 list_li_com">
				<b class="redStar" style="float:left;margin-top:18px;margin-right:3px;"></b>
                <span class="fl span_com">所在片区:</span>
               	 <select id="province"  onchange="doProvAndCityRelation();" style="border:1px solid #d6dee4;height:50px;">
		  　　　　　　　　<option id="choosePro"value="-1">省份</option>
		  　　　　　　</select>
			      <select id="citys" onchange="doCityAndCountyRelation();" style="border:1px solid #d6dee4;height:50px;width:136px;">
			 　　　　　　　　<option id='chooseCity' value='-1' >城市</option>
			 　　　 </select>
			      <select id="county" style="border:1px solid #d6dee4;height:50px;width:136px;">
			 　　　　　　　　<option id='chooseCounty' value='-1'>片区</option>
			 　　　 </select>
                <span class="warn_tx_com hide_com">*不能为空</span> 
            </li>
			<li class="clear mb20 list_li_com">
				<b class="redStar" style="float:left;margin-top:18px;margin-right:3px;"></b>
                <span class="fl span_com">顶部标题:</span>
                <input type="text" name="topTitle" value="${object.topTitle}" placeholder="请输入12个字之内的顶部标题"  class="btn_tx_com_connter fl dingbu_biaoti" data-reg="emptyssizeten" maxlength="12"/>
                <span class="warn_tx_com hide_com">*不能为空且小于10个字符</span>
            </li>
            
            
			
			<li class="clear mb20 list_li_com">
                <span class="fl span_com" style="margin-left:14px;">浮层选项:</span>
                <label class="radio_label_click"><i class="radio_<c:if test="${object.supernatantType == 1}">yes</c:if><c:if test="${object.supernatantType != 1}">no</c:if> mr5"></i><input type="radio" name="supernatantType" value="1" <c:if test="${object.supernatantType == 1}">checked="checked"</c:if> class="mr5 hide_com clickshow" />需要浮层</label>
                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${object.supernatantType == 0 || object.supernatantType == null}">yes</c:if><c:if test="${object.supernatantType == 1}">no</c:if> mr5"></i><input type="radio" value="0" <c:if test="${object.supernatantType == 0 || object.supernatantType == null}">checked="checked"</c:if> name="supernatantType" class="mr5 hide_com clickhide"/>不需要浮层</label>
                <div class="clickhidediv w_550 <c:if test="${object.supernatantType == 0 || object.supernatantType == null}">hide_com</c:if>">
                    <div class="clear">
                        <img src="<c:if test="${empty object.floatingLayer}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty object.floatingLayer}">${fns:getCosAccessHost()}${object.floatingLayer}</c:if>" class="load_img_com mr10 fl" width="100"/>
                        <div class="fl mt20">
                            <label class="label_load_img">
                                上传图片<input type="file" name="file" id="imgFile" onchange="saveImgtt(this)" class="hide_com"/>
                            </label>
                            <input type="button" class="lianjieqidelte <c:if test="${empty object.floatingLayer}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
							<input type="hidden" name="floatingLayer"  value="${object.floatingLayer}" id="floatingLayer">
                            <p class="warn_info">*格式:JPG,PNG,GIF,尺寸:520*720(像素)</p>
                        </div>
                    </div>
                   	<div class="mt10 color_29353d">浮层链接:<input type="text" class="btn_tx_com_connter_link ml10 link_reg_input"  value="${object.floatingUrl}" name="floatingUrl" placeholder="请填写指向的链接URL"/></div>
                   	<label class="radio_label_click"><i class="radio_${object.floatingShowTogetherNum?'yes':'no'} mr5"></i>
	                	<input type="radio" class="mr5 hide_com" name="floatingShowTogetherNum" value="true" <c:if test="${object.floatingShowTogetherNum}">checked="checked"</c:if>/>
	                	显示代言人数量
                	</label>
                	<label class="ml20 radio_label_click"><i class="radio_${!object.floatingShowTogetherNum?'yes':'no'} mr5"></i>
	                	<input type="radio" class="ml10 mr5 hide_com" name="floatingShowTogetherNum" value="false" <c:if test="${!object.floatingShowTogetherNum}">checked="checked"</c:if> />
	                	不显示代言人数量
                	</label>
                </div>
            </li>
            <c:if test="${gsFlag == true}">
	             <li class="clear mb20 list_li_com">
	                <span class="fl span_com" style="margin-left:14px;">代言人基数:</span>
	                <c:if test="${object.isOpen == 1}">
	                	   <input type="text" name="falseTogetherNum" value="${object.falseTogetherNum - 1000}" placeholder="请输入代言人基数"  class="btn_tx_com_connter fl" data-reg="emptyssizeten" maxlength="12"/>
	                </c:if>
	                <c:if test="${object.isOpen == 0 || object.isOpen == null}">
	                	   <input type="text" name="falseTogetherNum" value="${object.falseTogetherNum}" placeholder="请输入代言人基数"  class="btn_tx_com_connter fl" data-reg="emptyssizeten" maxlength="12"/>
	                </c:if>
	                <span class="warn_tx_com hide_com"></span>
	            </li>
            </c:if>
            
            <!--新增 自动切换照片  -->
            
            <%-- <li class="clear mb20 list_li_com">
                <span class="fl span_com">自动切换照片:</span>
                <label class="radio_label_click"><i class="radio_<c:if test="${object.isCarousel == 0 || object.isCarousel == null}">yes</c:if><c:if test="${object.isCarousel ==1}">no</c:if> mr5"></i><input type="radio" class="mr5 hide_com" name="isCarousel" value="0" <c:if test="${object.isCarousel == 0 || object.isCarousel == null}">checked="checked"</c:if>/>关闭</label>
                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${object.isCarousel == 1}">yes</c:if><c:if test="${object.isCarousel != 1}">no</c:if> mr5"></i><input type="radio" name="isCarousel" class="ml10 mr5 hide_com" value="1" <c:if test="${object.isCarousel == 1}">checked="checked"</c:if> name="start"/>开启</label>
            </li> --%>
            

			<li class="clear mb20 list_li_com">
                <span class="fl span_com" style="margin-left:14px;">开场动效:</span>
                <label class="radio_label_click"><i class="radio_<c:if test="${object.start == 0 || object.start == null}">yes</c:if><c:if test="${object.start ==1}">no</c:if> mr5"></i><input type="radio" class="mr5 hide_com" name="start" value="0" <c:if test="${object.start == 0 || object.start == null}">checked="checked"</c:if>/>无动效</label>
                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${object.start == 1}">yes</c:if><c:if test="${object.start != 1}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com" value="1" <c:if test="${object.start == 1}">checked="checked"</c:if> name="start"/>小行星开场</label>
            </li>
			
			<li class="clear pt28 list_li_com">
                <span class="span_com">&nbsp;</span>
                <input type="button" onclick="backhref();" value="上一步" class="btn_tx_com_connter_sub btn_tx_com_connter_ccc mr20"/>
                <input type="button" onclick="submitForm('preview');" id="ajaxSubmit1" value="预览" class="btn_tx_com_connter_sub btn_tx_com_connter_yulan mr20"/>
                <input type="button" onclick="submitForm('save');" id="ajaxSubmit"  value="保存并下一步" class="btn_tx_com_connter_sub btn_tx_com_connter_bule"/>
            </li>
            <input type="hidden" id="formSubmitType" value="save">
		</form>
	</div>
</div>
<div  class="right_del_mian hide_com">
    <div>
        <p class="alert_title">删除图片</p>
        <div class="alert_deleta_mian">
            <img src="${backStatic}/images/warnicon.png" class="warunicon">确定要删除这张图片吗?
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
<script src="${backStatic}/js/cityData.js"></script>

<script type="text/javascript">
var pro = '${object.province}';
var cityV = '${object.city}';
var countyV = '${object.county}';
var oldParams=null;
var params=null; 
$(function(){
	oldParams=$("#form-object-add").serialize();
});

function backhref(){
	window.location.href = "./objectList";
}
function preview(){
	var formo = $("#form-object-add");
	params=formo.serialize();
	var province = $("#province").find("option:selected").text();
	var city = $("#citys").find("option:selected").text();
	var county = $("#county").find("option:selected").text();
	if($("#province").val() == -1 ||  $("#city").val() == -1 || $("#county").val() == -1){
		alert("请选择完整的片区");
		return;
	}
	var d=params+"&formchanged="+(params!=oldParams);
	d += "&province="+province+"&city="+city+"&county="+county;
	$("#ajaxSubmit1").attr("disabled","disabled");
	$.ajax({
        type: "POST",
        url: "./addObject",
        data: d,
        success: function (res) {
        	$("#ajaxSubmit1").removeAttr("disabled");
        	$("#id").val(res.id);
        	$("#albumId").val(res.albumId);
			$('#forwardiframe').attr('src',"../linker/"+res.id)
        	$('#delforwardiframemian').show()
        },
        error: function(data) {
            alert("新增项目失败！");
			$("#ajaxSubmit1").removeAttr("disabled");
         }
    });
}
function submitForm(formSubmitType){
	$("#formSubmitType").val(formSubmitType);
	$("#form-object-add").submit();
}

$(function(){
	$("#form-object-add").validate({
		rules: {
			"objectName":{
				required:true ,
				maxlength:12
			},
			"falseTogetherNum":{
				required:false ,
				digits:true,
				max:99999,
				min:0
			},
			"floatingUrl":{
				url:true
			}
		},
		messages: {
			"falseTogetherNum":{
				
			}
		},
		submitHandler:function(form){
			if($("#formSubmitType").val()=="save"){
				addObject();
			}else{
				preview();
			}
			
        }    
	});
});

/**
 * ajax背景图上传
 */
 function saveImgtt(b){
	var allowExtention=".jpg,.jpeg,.gif,.png";//允许上传文件的后缀名
	var extention=$(b).val().substring($(b).val().lastIndexOf(".")+1).toLowerCase();
	var browserVersion= window.navigator.userAgent.toUpperCase();
	var loadimg = $('<img src=""/>')
	console.log(!(allowExtention.indexOf(extention)>-1))
	if(!(allowExtention.indexOf(extention)>-1)){
		alert('请上传规定的图片格式')
		return false;
	}
	if (navigator.userAgent.indexOf("MSIE")>=1) { // IE
		loadimg.attr('src',$(b).val())
	} else {
		loadimg.attr( 'src',window.URL.createObjectURL($(b)[0].files.item(0)))
	}
	var urlPic="${siteRoot}/object/uploadfile";
	loadimg.bind('load',function(){
		if(loadimg[0].naturalHeight!="720"){
			alert('请上传规定的图片尺寸')
			return false;
		}
		if(loadimg[0].naturalWidth!="520"){
			alert('请上传规定的图片尺寸')
			return false;
		}
		$.ajaxFileUpload({
 			url:urlPic,
 			secureuri:false,
 			fileElementId:"imgFile",
 			dataType:'json',
 			data:{
 				preImg:$("#floatingLayer").val()
 			},
 			beforeSend:function(){
 			},
 			complete:function(){
 			},				
 			success: function (data, status){
 				//上传成功 将图片的路径写入隐藏域
 				if(data.returnCode=="SUCCESS"){
 					$("#floatingLayer").val(data.cosFilePath);
 					$(".load_img_com").attr("src",data.cosData.access_url);
 					$(".lianjieqidelte").show()
 					
 				}else{
 					alert(data.returnMsg)
 				}
 			},
 			error: function (data, status, e){
 				alert("上传失败");
 			}
 		});	
	})
 	}
 	$('.lianjieqidelte').click(function(){
 		var _this =$(this)
 		alertbox({
			msg:$('.right_del_mian').html(),tcallfn_tx:'删除',
			tcallfn:function(){
				_this.parent().siblings('img').attr('src',_this.data('val'))
		 		$("#floatingLayer").val('');
				_this.hide()
			}
		});
 		
 	})
</script>

<script type="text/javascript">
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
 			emptyssizeten:/^(?!.{13}|s*$)/g,
 			number:/\d+/
 		}
 	}
 }
 reg_input = function(opt){
 	return new Reg_input(opt)
 }




function addObject(){
	var formo = $("#form-object-add");
	params=formo.serialize();
	var d=params+"&formchanged="+(params!=oldParams);
	
	var province = $("#province").find("option:selected").text();
	var city = $("#citys").find("option:selected").text();
	var county = $("#county").find("option:selected").text();
	if($("#province").val() == -1 ||  $("#city").val() == -1 || $("#county").val() == -1){
		alert("请选择完整的片区");
		return;
	}
	if(!$.trim($(".dingbu_biaoti").val())){
		alert("顶部标题不能为空!");
		return;
	}
	d += "&province="+province+"&city="+city+"&county="+county;
 	$("#ajaxSubmit").attr("disabled","disabled");
 	
	$.ajax({
        type: "POST",
        url: "./addObject",
        data: d,
        success: function (res) {
        	if(res.code=='-2'){
        		alert("没有权限!");
        	}else{
        		$("#ajaxSubmit").removeAttr("disabled");
            	location.href="${siteRoot}/object/toAlbum?id="+res.id;
    			//location.href="${backPath}/pano/album/main?id="+res.albumId+"&linkerId="+res.id;
        	}
        },
        error: function(data) {
            alert("新增项目失败！");
			$("#ajaxSubmit").removeAttr("disabled");
         }
    });	 
}
 $('#delforwardiframe').click(function(){
	 window.location.href = "./toaddObject?id="+$("#id").val();
 });
</script>
</body>

</html>