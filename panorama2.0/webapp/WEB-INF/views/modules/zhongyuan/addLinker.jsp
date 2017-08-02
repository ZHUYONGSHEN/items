<!Doctype html><%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="admin"/>
    <title>添加连接器</title>
    <link href="${zhongyuanPath}/css/bootstrap.min.css" rel='stylesheet'>
    <link href="${ctxStatic}/modules/720/css/stage.css" type="text/css" rel="stylesheet" />
    <style>
        .main-cont{
            margin:0 auto;
        }
        .right-content{
            width:1200px;
            font-size:16px;
        }
        .cont-tit{
            margin-top:20px;
            width:140px;
            height:32px;
            line-height:32px;
            font-size:18px;
            text-align: center;
            background: #cccccc;
        }
        .info-form{
            border:1px solid #d6dee4;
            padding-top:20px;
            padding-bottom:30px;
            background:#ffffff;
            margin-top: 20px;
        }
        .red-item {
            color: #f80040;
            margin-right: 3px;
        }
        .info-form .control-label{
            white-space: pre;
            width:130px;;
            display:inline-block;
            color: #859dad;
    		font-weight: bold;
        }
        .info-form .controls{
            margin-left:160px;;
        }
        .info-form .controls label{
        	display:inline-block;
        }
        .form-horizontal .control-group{
        	margin-top:35px;
        }
        .hide_com{
	   	 display: none;
		}
		.add{
			background-color: #009bff;
    		color: #fff;
		    width: 135px;
		    height: 40px;
		    border-radius: 135px;
		    line-height: 40px !important;
		    cursor: pointer;
		}
		.cancel{
			background-color: #e1e7eb;
		    color: #859dad;
		    width: 135px;
		    height: 40px;
		    border-radius: 135px;
		    line-height: 40px !important;
		    cursor: pointer;
		    margin-left:20px;
		}
    </style>
</head>
<body>
    <div class="main-cont mian_com">
        <div class="right-content">
            <form class="form-horizontal info-form" id="form-object-add">
                <input type="hidden" name="id" value="${object.id}"/>
                <input type="hidden" name="createBy" value="${object.createBy}"/>
                <div class="control-group">
                    <label class="control-label" for="title"><span class="red-item">*</span>项目标题：</label>
                    <div class="controls">
                        <input type="text" name="objectName" value="${object.objectName}" style="width:150;height:30px;">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" ><span class="red-item">*</span>所在片区：</label>
                    <div class="controls">
	                    <select id="province"  onchange="doProvAndCityRelation();" style="border:1px solid #d6dee4;height:30px;">
				  　　　　　　　　<option id="choosePro"value="-1">省份</option>
				  　　　　　　</select>
					      <select id="citys" onchange="doCityAndCountyRelation();" style="border:1px solid #d6dee4;height:30px;width:136px;">
					 　　　　　　　　<option id='chooseCity' value='-1' >城市</option>
					 　　　 </select>
					      <select id="county" style="border:1px solid #d6dee4;height:30px;width:136px;">
					 　　　　　　　　<option id='chooseCounty' value='-1'>片区</option>
					 　　　 </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" ><span class="red-item">*</span>房        型：</label>
                    <div class="controls">
                        <select name="room">
                            <option value="1" <c:if test="${object.room == 1}">selected="selected"</c:if>>一室</option>
                            <option value="2" <c:if test="${object.room == 2}">selected="selected"</c:if>>两室</option>
                            <option value="3" <c:if test="${object.room == 3}">selected="selected"</c:if>>三室</option>
                            <option value="4" <c:if test="${object.room == 4}">selected="selected"</c:if>>四室</option>
                            <option value="5" <c:if test="${object.room == 5}">selected="selected"</c:if>>五室及以上</option>
                        </select>
                        <select name="hall">
                            <option value="1" <c:if test="${object.hall == 1}">selected="selected"</c:if>>一厅</option>
                            <option value="2" <c:if test="${object.hall == 2}">selected="selected"</c:if>>两厅</option>
                            <option value="3" <c:if test="${object.hall == 3}">selected="selected"</c:if>>三厅</option>
                            <option value="4" <c:if test="${object.hall == 4}">selected="selected"</c:if>>四厅</option>
                            <option value="5" <c:if test="${object.hall == 5}">selected="selected"</c:if>>五厅及以上</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" ><span class="red-item">*</span>总        价：</label>
                    <div class="controls">
                        <select name="totalMoney">
                            <option <c:if test="${object.totalMoney == 1}">selected="selected"</c:if> value="1">两百万以下</option>
                            <option <c:if test="${object.totalMoney == 2}">selected="selected"</c:if>value="2">200万-300万</option>
                            <option <c:if test="${object.totalMoney == 3}">selected="selected"</c:if>value="3">300万-500万</option>
                            <option <c:if test="${object.totalMoney == 4}">selected="selected"</c:if>value="4">500万-800万</option>
                            <option <c:if test="${object.totalMoney == 5}">selected="selected"</c:if>value="5">800万-1000万</option>
                            <option <c:if test="${object.totalMoney == 6}">selected="selected"</c:if>value="6">1000万以上</option>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="up"><span class="red-item">*</span>单        价：</label>
                    <div class="controls">
                        <input type="text" value="${object.averagePrice}" name="averagePrice" style="width:150;height:30px;">&nbsp;&nbsp;元/m²
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="size"><span class="red-item">*</span>面        积：</label>
                    <div class="controls">
                        <input type="text" value="${object.buildArea}"  name="buildArea" style="width:150;height:30px;">&nbsp;&nbsp;m²
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="orientation"><span class="red-item">*</span>朝        向：</label>
                    <div class="controls">
                        <input type="text"  value="${object.orientations}"  name="orientations" style="width:150;height:30px;">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name"><span class="red-item">*</span>小区名称：</label>
                    <div class="controls">
                        <input type="text" name="name" value="${object.name}"style="width:300px;height:30px;">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="website"><span class="red-item">*</span>链        接：</label>
                    <div class="controls">
                        <input type="text"  name="objectUrl" value="${object.objectUrl}" style="width:300px;height:30px;">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" ><span class="red-item">*</span>封  面  图：</label>
	                <div class="fl div_up_img_nonebg w_540 divImageUpload" style="margin-left:30px;">
	                  <c:if test="${empty object.imgUrl}">
	                  		 <img src="${backStatic}/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>
	                  </c:if>
	                   <c:if test="${not empty object.imgUrl}">
	                  		 <img src="${fns:getCosAccessHost()}${object.imgUrl}" class="load_img_com mr10 fl" width="100"/>
	                  </c:if>
	                    <div class="fl mt20">
	                        <label class="label_load_img">
	                           	 上传图片<input type="file" name="file" id="imgUrl" class="hide_com inputImageUpload list4_logo" style="display:none"/>
	                        </label>
							<input type="hidden"  class="imgUrl" name="imgUrl" value="${object.imgUrl}">
	                        <input type="button" class="lianjieqidelte hide_com" style="display:none"data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
	                        <p class="warn_info">*格式:JPG,PNG,建议尺寸:750*422(像素)</p>
	                    </div>
	                </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputEmail">项目简介：</label>
                    <div class="controls">
                        <textarea name="remark" rows="6"  id="remark"style="width:300px;">${object.remark}</textarea>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputEmail">房源标签：</label>
                    <div class="controls">
	                    <label class="mr20 check_box_click">
	            			<i class="radio_no"></i>
	            			<input name="projectTag" value="0" id="jiaoyu1" type="checkbox" style="display:none;">  满二/满五
	            		</label>
	            		<label class="mr20 check_box_click">
	            			<i class="radio_no"></i>
	            			<input name="projectTag" value="1" id="pingpai1" type="checkbox" style="display:none;">  红本在手
	            		</label>
	            		<label  class="mr20 check_box_click">
	            			<i class="radio_no"></i>
	            			<input name="projectTag" value="2" id="shequ1" type="checkbox" style="display:none;">   学位房
	            		</label>
	            		<label  class="mr20 check_box_click">
	            			<i class="radio_no"></i>
	            			<input name="projectTag" value="3" id="xuqiu1" type="checkbox" style="display:none;"> 地铁
	            		</label>
	            		<label class="mr20 check_box_click">
	            			<i class="radio_no"></i>
	            			<input name ="projectTag" value="4" type="checkbox" style="display:none;">  南北通透
	            		</label>
	            		<label class="mr20 check_box_click">
	            			<i class="radio_no"></i>
	            			<input name ="projectTag" value="5" type="checkbox" style="display:none;">  户型方正
	            		</label>
	            		<label class="mr20 check_box_click">
	             			<i class="radio_no"></i>
	            			<input name ="projectTag" value="6" type="checkbox" style="display:none;">  随时看房
	            		</label>
	            		<label class="mr20 check_box_click">
	            			<i class="radio_no"></i>
	            			<input name ="projectTag" value="7" type="checkbox" style="display:none;">  唯一住房
	            		</label>
	            		<label class="mr20 check_box_click">
	            			<i class="radio_no"></i>
	            			<input name ="projectTag" value="8" type="checkbox" style="display:none;">  品牌开发商
	            		</label>
	            		<label class="mr20 check_box_click inline">
	            			<i class="radio_no"></i>
	            			<input name ="projectTag" value="9" type="checkbox" style="display:none;">  刚需
	            		</label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="inputEmail">排        序：</label>
                    <div class="controls">
                        <input type="text" placeholder="不大于10000" name="orderNum" value="${object.orderNum}"style="width:150px;height:30px;" maxlength="5" >
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <button type="button" class="add">添加</button>
                        <button type="button" class="cancel">取消</button>
                     </div>

                </div>
            </form>
        </div>
    </div>
<script src="${backStatic}/js/jquery.min.2.2.2.js"></script>
<script src="${backStatic}/js/ajaxfileupload.js"></script>
<script src="${backStatic}/js/cityData.js"></script>
<script>
var pro = '${object.province}';
var cityV = '${object.city}';
var countyV = '${object.district}';
$(".add").click(function(){
	save();
})
loadTag();
//设置复选框是否选中
function loadTag(){
	var tag = '${object.projectTag}';
	if(tag){
		var array = tag.split(",");
		$.each(array, function(i, n){
			var obj = document.querySelector(".mian_com").querySelector("input[name='projectTag'][value='" +n + "']");
			$(obj).siblings("i").removeClass("radio_no").addClass("radio_yes");
			$(obj).attr("checked","checked");
		});
	}
}

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
//新房确定多选标签点击序号
$(".check_box_click").click(function(event){
	event.preventDefault();
	if($(this).find("i").hasClass("radio_no")){
		var length = $("body").find("input[name='projectTag']:checked").length;
		if(length > 4){
			alert("项目标签最多选五个");
			return;
		}
		$(this).find("i").removeClass("radio_no").addClass("radio_yes");
		$(this).find("input").attr("checked","checked");
	}else if($(this).find("i").hasClass("radio_yes")){
		$(this).find("i").removeClass("radio_yes").addClass("radio_no");
		$(this).find("input").removeAttr("checked");
	}
	
});
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
 		input.val('');
		img.attr('src',lianjieqidelte.data('val'))
		lianjieqidelte.hide()
 	})
 	
function isURL(str_url) {// 验证url
	return!!str_url.match(/(^https?:(?:\/\/)?)/g);
}
function save(){
	var objectName = $("input[name='objectName']").val();
	var averagePrice = $("input[name='averagePrice']").val();
	var buildArea = $("input[name='buildArea']").val();
	var orientations = $("input[name='orientations']").val();
	var name = $("input[name='name']").val();
	var imgUrl = $("input[name='imgUrl']").val();
	var orderNum = $("input[name='orderNum']").val();
	var remark = $("#remark").val();
	var reg5 = /^[0-9]+(.[0-9]{0,2})?$/; //验证有0-2位小数的正实数：
	var reg6 = /^[0-9].?$/; //验证有0-2位小数的正实数：
	if($.trim(objectName) == ""){
		alert("项目标题不能为空");
		return false;
	}
	if($.trim(averagePrice) == ""){
		alert("单价不能为空");
		return false;
	}
	 if(!reg5.test(averagePrice) || averagePrice > 1000000){
		 alert("请输正确的单价,不能超过1百万最多带两位小数");
		 return false;
	 }
	if($.trim(buildArea) == ""){
		alert("面积不能为空");
		return false;
	}
	 if(!reg5.test(buildArea)  ||  buildArea > 10000000){ 
		 alert("请输入正确的面积,不能超过1千万最多带两位小数");
		 return;
	 }
	if($.trim(orientations) == ""){
		alert("朝向不能为空");
		return false;
	}
	if($.trim(name) == ""){
		alert("小区名称不能为空");
		return false;
	}
	if($.trim(imgUrl) == ""){
		alert("封面图不能为空");
		return false;
	}
	if(orderNum){
		if(!reg6.test(orderNum) || parseInt(orderNum)>10000){
			$("input[name='orderNum']").value="";
			alert("排序数是不大于10000的整数");
			return false;
		}
	}
	if(remark){
		if(remark.length>200){
			alert("项目简介不能超过200字符");
			return false;
		}
	}
	var formo = $("#form-object-add");
	params=formo.serialize();
	var province = $("#province").find("option:selected").text();
	var city = $("#citys").find("option:selected").text();
	var county = $("#county").find("option:selected").text();
	if($("#province").val() == -1 ||  $("#city").val() == -1 || $("#county").val() == -1){
		alert("请选择完整的片区");
		return;
	}
	var objectUrl = $("input[name='objectUrl']").val();
	if(!isURL(objectUrl)){
			ture_link=false
			alert('请填写正确的链接')
			return false;
	}
	var d = params+"&province="+province+"&city="+city+"&district="+county;
	 $.ajax({
        type: "POST",
        url: "./addObject.sys",
        data: d,
        success: function (res) {
        	if(res.code=="0000"){
	        	window.location.href="./objectList";
        	}else{
        		alert(res.message);
        	}
			
        },
        error: function(data) {
			//$("#ajaxSubmit").removeAttr("disabled");
         }
    }); 
}
</script>
</body>
</html>