<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="admin"/>
    <title>右侧按钮</title>
</head>
<body>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=d84d6d83e0e51e481e50454ccbe8986b"></script>
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
        <a href="" class="cur">
            <span class="head_icon_big head_icon_three head_icon_yes"></span>
            <p class="head_icon_tx">按钮</p>
        </a>
    </li>
    <!-- <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a>
            <span class="head_icon_big head_icon_four head_icon_no"></span>
            <p class="head_icon_tx">左侧及下方按钮</p>
        </a>
    </li> -->
    <li class="head_nav_chear_no">
        <a>
            <span class="head_icon_big head_icon_four head_icon_no"></span>
            <p class="head_icon_tx">推广信息</p>
        </a>
    </li>
</div>
<div class="mian_com">
<div class="connter_mian_list3 br_dash">
	<!-- 楼盘字典 -->
	<div class="loupanzidian hide_com">
	    <div class="qqq">
	        <p class="alert_title">关联楼盘字典数据</p>
	        <div class="alert_deleta_mian">
            	<div class="searches">
            		<div class="fl mr20 ml54"><input class="fl searches_value pl3" id="sddd" style="border:1px solid #ccc;width:400px;height:30px;" type="text"></div>
            		<div class="fl searches_button" style="width:60px;height:100%;line-height:30px;border:1px solid #ccc;border-radius:6px;cursor:pointer;">搜索</div>
            	</div>
            	<div class="searches_content mt10 ml14">
            		<div class="searches_title">
            			<p class="fl wone">序号</p>
            			<p class="fl wtwo">楼盘名称</p>
            			<p class="fl wthree">城市</p>
            			<p class="fl wfour">详细地址</p>
            		</div>
            		<div class="searches_result">
            			
            		</div>
            	</div>
	        </div>
	    </div>
	</div>
	
 
<%--     <input type="hidden" name="id" value="${rightObject.id}"> --%>
	<%-- <div class="list3divlisht br_dash_b">
		<li class="connter_module_title clear">头像 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span></li>
         <li class="clear list_li_com pb38 ">
            <span class="fl span_com">头像设置:</span>
			 <label class="radio_label_click"><i class="radio_<c:if test="${rightObject.headType == 1 || rightObject.headType == null}">yes</c:if><c:if test="${rightObject.headType != 1 && rightObject.headType != null}">no</c:if> mr5"></i><input name="headType" type="radio" value="1"  <c:if test="${rightObject.headType == 1 || rightObject.headType == null}">checked="checked"</c:if> class="mr5 hide_com clickhide"/>拉取微信头像</label>
             <label class="ml20 radio_label_click"><i class="radio_<c:if test="${rightObject.headType == 0}">yes</c:if><c:if test="${rightObject.headType ==1 || rightObject.headType == null}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com clickshow"  <c:if test="${rightObject.headType == 0}">checked="checked"</c:if> value="0" name="headType"/>固定头像</label>
			
			<div class="clickhidediv w_550 <c:if test="${rightObject.headType == 0}"></c:if><c:if test="${rightObject.headType ==1 || rightObject.headType == null}">hide_com</c:if> divImageUpload">
			
				<div class="clear">
					<img src="<c:if test="${empty rightObject.headImageUrl }">${backStatic}/images/img_logo1.png</c:if><c:if test="${not empty rightObject.headImageUrl}">${fns:getCosAccessHost()}${rightObject.headImageUrl}</c:if>" class="load_img_com mr10 fl" width="100"/>
					<div class="fl mt20">
						<label class="label_load_img">
							上传图片<input type="file" name="file" id="touxiangFile" class="hide_com inputImageUpload details_head_img"/>
						</label>
						<input type="button" class="lianjieqidelte <c:if test="${empty rightObject.headImageUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
						<input type="hidden" name="headImageUrl" value="${rightObject.headImageUrl}" id="headImageUrl">
						<p class="warn_info">*格式:JPG,PNG,尺寸:200*200(像素)</p>
					</div>
				</div>
				<div class="mt10 color_29353d">固定名字:<input type="text" maxlength="6" name="fixedName" value="${rightObject.fixedName}" class="btn_tx_com_connter_link ml10" placeholder="请填写6个字之内的固定姓名"/></div>
			</div>
			
        </li>
        </div> --%>
        
       <form id="form-rightButton-base">
        <div class="list3divlisht">
        <li class="connter_module_title connter_module_title1 clear pl0"><div class="showOrhide"><span class="ml130">详情</span><p style="width:74px;height:100%;float:right;overflow:hidden;"><b class="wraper1_b"></b><i class="down_arrow"></i></p></div></li>
		
		<div class="wraper1" style="display:none;">
			<li class="clear mb20 list_li_com">
			<span class="fl span_com">入口标题:</span>
			<span class="fr quesi_span"><i class="quesi_con"></i>示例<img class="xiangqin_shili" src="${backStatic}/images/xiangqing.png" /></span>
			<input type="text" name="xqEntryTitle" value="${rightObject.xqEntryTitle}" class="btn_tx_com_connter fl" data-reg="emptys" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
			<span class="warn_tx_com hide_com">*不能为空</span>
		</li>
		<li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">入口图标:</span>
			<div class="fl div_up_img_nonebg w_540">
				<img src="<c:if test="${empty rightObject.xqEntryIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/icon_xiangqins.png</c:if><c:if test="${not empty rightObject.xqEntryIcon}">${fns:getCosAccessHost()}${rightObject.xqEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="rukouFile" class="hide_com inputImageUpload rukou_icon"/>
					</label>
					<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_xiangqins.png" data-vals="/material/sys/linker/default/icon_xiangqins.png" value="还原默认图标"/>
					<input type="hidden" name="xqEntryIcon" data-reg="emptys" id="xqEntryIcon" value="<c:if test="${empty rightObject.xqEntryIcon}">/material/sys/linker/default/icon_xiangqins.png </c:if><c:if test="${not empty rightObject.xqEntryIcon}">${rightObject.xqEntryIcon}</c:if>">
					<span class="warn_tx_com hide_com">*不能为空</span>
					<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
				</div>
			</div>
		</li>
		
		 <%-- <li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">详情页头像:</span>
			<div class="fl div_up_img_nonebg w_540">
				<img src="<c:if test="${empty rightObject.headerMapDetails}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty rightObject.headerMapDetails}">${fns:getCosAccessHost()}${rightObject.headerMapDetails}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="xqytoutuFile" class="hide_com inputImageUpload details_top_img"/>
					</label>
					<input type="hidden" name="headerMapDetails" id="headerMapDetails" data-reg="emptys" value="${rightObject.headerMapDetails}">
					<input type="button" class="lianjieqidelte <c:if test="${empty rightObject.headerMapDetails}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
					<span class="warn_tx_com hide_com">*不能为空</span>
					<p class="warn_info">*格式:JPG,PNG,尺寸:750*420(像素)</p>
				</div>
			</div>
		</li>  --%>
		
		
		
		
		

		
		<!-- 此处为新增的 房源详情，分为新房二手房-->
		<li class="clear mb20 list_li_com" id="house_details">
			<span class="span_com mr60">详情类型:</span>
			<label class="radio_label_click mr60 type_selects"><i class="type_selects_i radio_<c:if test="${rightObject.fyType == 0}">yes</c:if><c:if test="${rightObject.fyType != 0}">no</c:if> mr5"></i><input type="radio" class="mr5 hide_com" <c:if test="${rightObject.fyType == 0}">checked="checked"</c:if> name="fyType" value="0"/>新房</label>
            <label class="ml20 radio_label_click mr60 type_selects"><i class="type_selects_i radio_<c:if test="${rightObject.fyType == 1}">yes</c:if><c:if test="${rightObject.fyType != 1}">no</c:if> mr5"></i><input type="radio" <c:if test="${rightObject.fyType == 1}">checked="checked"</c:if> class="ml10 mr5 hide_com" value="1" name="fyType"/>二手房</label>
            <label class="ml20 radio_label_click type_selects"><i class="type_selects_i radio_<c:if test="${rightObject.fyType == 2}">yes</c:if><c:if test="${rightObject.fyType != 2}">no</c:if> mr5"></i><input type="radio" <c:if test="${rightObject.fyType == 2}">checked="checked"</c:if> class="ml10 mr5 hide_com" value="2" name="fyType"/>其它</label>
         </form>
         
         <form id="form-rightButton-otherhouse">
         
			<li class="clear mb20 list_li_com divImageUpload qita">
				<span class="fl span_com">详情页头图:</span>
				<div class="fl div_up_img_nonebg w_540">
					<img src="<c:if test="${empty rightObject.headerMapDetails}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty rightObject.headerMapDetails}">${fns:getCosAccessHost()}${rightObject.headerMapDetails}</c:if>" class="load_img_com mr10 fl" width="100"/>
					<div class="fl mt20">
						<label class="label_load_img">
							上传图片<input type="file" name="file" id="xqytoutuFile" class="hide_com inputImageUpload details_top_img"/>
						</label>
						<input type="hidden" name="headerMapDetails" id="headerMapDetails" data-reg="emptys" value="${rightObject.headerMapDetails}">
						<input type="button" class="lianjieqidelte <c:if test="${empty rightObject.headerMapDetails}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
						<span class="warn_tx_com hide_com">*不能为空</span>
						<p class="warn_info">*格式:JPG,PNG,尺寸:750*420(像素)</p>
					</div>
				</div>
			</li>
				<!-- 		新增 -->
	 		<c:if test="${rightObject.id == null}">
			<li class="qita clear list_li_com mb20 title_max_mian list3_list_mian_type1">
				<input type="hidden" name="titleType" value="1" class="list3_radio_type"/>
				<span class="qita fl span_com">正文类型:</span>
				<label class="qita radio_label_click fl"><i class="radio_yes mr5"></i><input type="radio" name="" value="1" class="mr5 hide_com clickshow" checked="checked"/>标题+正文</label>
				<label class="qita ml20 radio_label_click fl"><i class="radio_no mr5"></i><input type="radio" value="2" class="ml10 mr5 hide_com clickhide"/>标题+正文图片</label>
				<label class="qita ml20 radio_label_click fl"><i class="radio_no mr5"></i><input type="radio" value="3" class="ml10 mr5 hide_com clickhide"/>标题+链接</label>
				<label class="qita ml20 radio_label_click fl"><i class="radio_no mr5"></i><input type="radio" value="4" class="ml10 mr5 hide_com clickhide"/>标题+视频</label>
				<label class="qita ml20 radio_label_click fl"><i class="radio_no mr5"></i><input type="radio" value="5" class="ml10 mr5 hide_com clickhide"/>标题+地图</label>
				<ul class="qita" style="min-height:386px">
					<li class="clear list_li_com">
						<p class="alert_tx">标题:</p>
						<input type="text" name="title" class="btn_tx_com_connter fl" data-reg="emptys" maxlength="12" placeholder="请输入12个字之内的标题"/>
						<span class="warn_tx_com hide_com">*不能为空</span>
					</li>
					<li class="clear list_li_com">
						<p class="alert_tx">正文:</p>
						<textarea class="btn_tx_com_textarea title_link_tx_type fl" data-reg="emptys" name="textList[0]"></textarea>
						<span class="warn_tx_com hide_com">*不能为空</span>
					</li>
				</ul>
			</li>
			</c:if> 
	<!-- 		修改 -->
	 		<c:if test="${rightObject.id != null}">
			<c:forEach items="${LktList}" var="LktList" varStatus="index">
			 <li class="qita clear list_li_com mb20 title_max_mian list3_list_mian_type${LktList.titleType}">
				<input type="hidden" name="titleType" value="${LktList.titleType}" class="list3_radio_type" />
				<span class="fl span_com">正文类型:</span>
				<label class="radio_label_click"><i class="radio_<c:if test="${LktList.titleType == 1 || LktList.titleType == null}">yes</c:if><c:if test="${LktList.titleType != 1}">no</c:if> mr5"></i><input type="radio" name="" value="1" class="mr5 hide_com clickshow" <c:if test="${LktList.titleType == 1 || LktList.titleType == null}">checked="checked"</c:if>/>标题+正文</label>
				<label class="ml20 radio_label_click"><i class="radio_<c:if test="${LktList.titleType == 2}">yes</c:if><c:if test="${LktList.titleType != 2}">no</c:if> mr5"></i><input type="radio" value="2" class="ml10 mr5 hide_com clickhide" <c:if test="${LktList.titleType == 2}">checked="checked"</c:if>/>标题+正文图片</label>
				<label class="ml20 radio_label_click"><i class="radio_<c:if test="${LktList.titleType == 3}">yes</c:if><c:if test="${LktList.titleType != 3}">no</c:if> mr5"></i><input type="radio" value="3" class="ml10 mr5 hide_com clickhide" <c:if test="${LktList.titleType == 3}">checked="checked"</c:if>/>标题+链接</label>
				<label class="ml20 radio_label_click"><i class="radio_<c:if test="${LktList.titleType == 4}">yes</c:if><c:if test="${LktList.titleType != 4}">no</c:if> mr5"></i><input type="radio" value="4" class="ml10 mr5 hide_com clickhide" <c:if test="${LktList.titleType == 4}">checked="checked"</c:if>/>标题+视频</label>
				<label class="ml20 radio_label_click"><i class="radio_<c:if test="${LktList.titleType == 5}">yes</c:if><c:if test="${LktList.titleType != 5}">no</c:if> mr5"></i><input type="radio" value="5" class="ml10 mr5 hide_com clickhide" <c:if test="${LktList.titleType == 5}">checked="checked"</c:if>/>标题+地图</label>
				<!-- 1 -->
				<c:if test="${LktList.titleType == 1}">
				<ul style="min-height:386px">
					<li class="clear list_li_com">
						<p class="alert_tx">标题:</p>
						<input type="text" name="title" maxlength="12" value="${LktList.title}" class="btn_tx_com_connter fl" data-reg="emptys" placeholder="请输入12个字之内的标题"/>
						<span class="warn_tx_com hide_com">*不能为空</span>
					</li>
					<li class="clear list_li_com">
						<p class="alert_tx">正文:</p>
						<textarea class="btn_tx_com_textarea title_link_tx_type trim_inspect fl" data-reg="emptys" name="textList[0]" >${LktList.titletextList[0].text}</textarea>
						<span class="warn_tx_com hide_com">*不能为空</span>
					</li>
				</ul>
				</c:if>
				
	 			<c:if test="${LktList.titleType == 2}">
				<!-- 2 -->
				<ul style="min-height:386px">
					<li class="clear mb20 list_li_com">
					  <p class="alert_tx">标题:</p>
					  <input type="text" name="title" maxlength="12" value="${LktList.title}" class="btn_tx_com_connter fl" data-reg="emptys" placeholder="请输入12个字之内的标题"/><span class="warn_tx_com hide_com">*不能为空</span></li>
					 
					<c:forEach items="${LktList.titletextList}" var="textList"  varStatus="index">  
					<li class="clear mb20 list_li_com divImageUpload">
					  <div class="div_up_img div_up_img w_540">
					    <div class="clear">
					      <img src="<c:if test="${empty textList.textImageUrl}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty textList.textImageUrl}">${fns:getCosAccessHost()}${textList.textImageUrl}</c:if>" class="load_img_com mr10 fl" width="100" />
					      <div class="fl mt20">
					        <label class="label_load_img">上传图片
					          <input type="file" class="hide_com inputImageUpload" id="xg_zhengwentupian${index.index}" name="file" />
					          </label>
					          <input type="hidden" class="title_link_hidden_type" data-reg="emptys" value="${textList.textImageUrl}"/>
					          <input type="button" class="lianjieqidelte <c:if test="${empty textList.textImageUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
					          <span class="warn_tx_com hide_com">*不能为空</span>
					        <p class="warn_info">*格式:JPG,PNG,尺寸:650*900(像素)</p></div>
					    </div>
					    <div class="mt10 color_29353d">正文:
					      <input type="text" maxlength="300" value="${textList.text}" class="btn_tx_com_connter_link ml10 title_link_tx_type" data-reg="emptys" placeholder="请输入300个字之内的正文" />
					     <span class="warn_tx_com hide_com">*不能为空</span>
					    </div>
					  </div>
						<i class="icon_module_del click_module_del click_module_del_imgicont zhengwen_shanchu"></i>
					</li>
					</c:forEach>
					<li class="clear mt20 list_li_com">
					  <i class="new_module1 click_new">
					    <i class="icon_cunt mr10"></i>新增一行</i>
					</li>
				</ul>
				</c:if>
				
				<c:if test="${LktList.titleType == 3}">
				<!-- 3 -->
				<ul style="min-height:386px">
					<li class="clear list_li_com">
					  <p class="alert_tx">标题:</p>
					  <input type="text" name="title" maxlength="12" value="${LktList.title}" class="btn_tx_com_connter fl" data-reg="emptys" placeholder="请输入12个字之内的标题"> <span class="warn_tx_com hide_com">*不能为空</span></li>
					<c:forEach items="${LktList.titletextList}" var="textList">
						<li class="clear list_li_com">
						  <p class="alert_tx">正文:</p>
						  <input type="text" value="${textList.text}" maxlength="15" placeholder="请输入15个字之内的正文" name="textUrlListText[0]" class="btn_tx_com_connter title_link_tx_type_tx fl " data-reg="emptys">
						  <span class="warn_tx_com hide_com">*不能为空</span>
						  <i class="icon_module_del ml10 icon_module_conlink"></i>
						</li>
						<li class="clear list_li_com">
						  <p class="alert_tx">链接:</p>
						  <input type="text" value="${textList.textUrl}" name="textUrlList[0]" class="btn_tx_com_connter title_link_tx_type fl link_reg_input" data-reg="emptys">
						  <span class="warn_tx_com hide_com">*输入正确的链接</span>
						</li>
					</c:forEach>
					<li class="clear mt20 list_li_com">
					  <i class="new_module1 click_news">
					    <i class="icon_cunt mr10"></i>新增一行</i>
					</li>
				</ul>
				</c:if>
				
				<c:if test="${LktList.titleType == 4}">
				<!-- 4 -->
				<ul style="min-height:386px">
					<li class="clear list_li_com">
					  <p class="alert_tx">标题:</p>
					  <input type="text" name="title" maxlength="12" value="${LktList.title}" class="btn_tx_com_connter fl" data-reg="emptys" placeholder="请输入12个字之内的标题">
					  <span class="warn_tx_com hide_com">*不能为空</span>
					</li>
					<li class="clear list_li_com divImageUpload">
					  <p class="alert_tx">视频:</p>
					  <video src="${fns:getCosAccessHost()}${LktList.videoUrl}" poster="${linkerStatic}/img/videoImg.png" webkit-playsinline="true" controls="controls" preload="none" style="width:300px;height:150px;"></video>
					  <label class="label_load_img fl" style="margin-top:115px">上传视频
					    <input type="file" name="file" id="btshipin0" class="hide_com inputImageUpload"></label>
					  <input type="text" name="videoUrl" value="${LktList.videoUrl}" class="btn_tx_com fl hide_com" data-reg="emptys" readonly="readonly">
					  <span class="lianjieqidelte fl <c:if test="${empty LktList.videoUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" style="margin-top:115px"/>删除视频</span>
					  <span class="warn_info fl" style="margin-top:120px">*格式:MP4,编码为H264</span>
					  <span class="warn_tx_com hide_com fl" style="margin-top:120px">*不能为空</span>
					</li>
				</ul>
				</c:if>
				<c:if test="${LktList.titleType == 5}">
				<input type="hidden" id="titleTypeForDitu" value="${LktList.titleType}">
				<!-- 5 -->	
				<ul style="min-height:386px">
					<li class="clear mb20 list_li_com">
						<p class="alert_tx">标题:</p>
						<input type="text" maxlength="12" name="title" value="${LktList.title}" class="btn_tx_com_connter fl " data-reg="emptys" placeholder="请输入12个字之内的标题"/>
						<span class="warn_tx_com hide_com">*不能为空</span>
					</li>
					<li class="clear mb20 list_li_com">
						<tr>
							<th>坐标</th>
						<td>
							经度(Y)&nbsp;&nbsp;<input type="text" name="longitude" value="${LktList.longitude}" id="longitude_qita" onblur="init_qita(2)" class="h30 mr20"/>
							纬度(X)&nbsp;&nbsp;<input type="text" name="latitude" value="${LktList.latitude}" id="latitude_qita" onblur="init_qita(2)" class="h30"/>
							</td>
						</tr>
						<tr>
							<th>&nbsp;</th>
						<td>
							<div style="width:603px;height:400px;margin-top:20px" id="container_qita"></div>
						</td>
						</tr>
					</li>
				</ul>
				</c:if>
				<c:if test="${index.index >= 1}">
					<i class="icon_module_del click_module_del click_module_del_newlist zhengwen_shanchu"></i>
				</c:if>
			</li>
			</c:forEach>
			</c:if> 
			
			 <div class="qita zengwen_xinzeng"></div>
			
	        <li class="qita clear mb20 list_li_com">
				<i class="new_module" id="click_new_list"><i class="icon_cunt mr10"></i>新增正文模块</i>
			</li> 
	        
			
			 <%-- <li class="qita clear list_li_com pb38  divImageUpload">
				<span class="fl span_com">后缀:</span>
				<div class="div_up_img_nonebg w_540 fl">
					<div class="clear">
						<img src="<c:if test="${empty rightObject.postfix}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty rightObject.postfix}">${fns:getCosAccessHost()}${rightObject.postfix}</c:if>" class="load_img_com mr10 fl" width="100"/>
						<div class="fl mt20">
							<label class="label_load_img">
								上传图片<input type="file" name="file" id="houzhuiFile" class="hide_com inputImageUpload details_bottom_img"/>
							</label>
							<input type="hidden" name="postfix" id="postfix" value="${rightObject.postfix}">
							<input type="button" class="lianjieqidelte <c:if test="${empty rightObject.postfix}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
							<p class="warn_info">*格式:JPG,PNG,尺寸:192*64(像素)</p>
						</div>
					</div>
					<div class="mt10 color_29353d">后缀文字:<input type="text" maxlength="20" class="btn_tx_com_connter_link ml10" name="postfixText" value="${rightObject.postfixText}" placeholder="如:孙先生 13000000000"/><span class="warn_tx_com hide_com">*不能为空</span></div>
				</div>
			</li>  --%>
			</form>
			
      
         
         
         
         <form id="form-rightButton-newhouse">
            <!-- 新房部分 -->
            <div class="new_house xinfangs clear ml130 list_li_com">
            	<div class="new_house_div1">
            		<span class="redStar" style="float:left;margin:18px 5px 0 12px;"></span>
            		<div class="mr10 fl ft_col">楼盘:</div>
            		<div class="fl mr20"><input name="name" class="pl3 new_house_input" value="${newInfo.name}" style="width:300px;height:30px;" type="text"></div>
            		<div class="fl"><a class="zidian_data_newHouse" style="color:#009bff;text-decoration:underline;" href="javascript:void(0);">关联楼盘字典数据</a></div>
            	</div>
            	<div class="new_house_div2">
            		<span class="redStar" style="float:left;margin:18px 5px 0 12px;"></span>
            		<div class="mr10 fl ft_col">均价:</div>
            		<div class="fl mr220"><input class="pl3 mr10" name="averagePrice" value="${newInfo.averagePrice}" style="width:150px;height:30px;" type="number">元/㎡</div>
            		<div class="fl mr20 ft_col"><span class="redStar" style="margin-right:2px;"></span>销售状态 :</div>
            		<div class="fl">
	            		<select name="saleStatus" style="display:inline-block;width:150px;height:30px;">
	            			<option value="0" <c:if test="${newInfo.saleStatus == 0}">selected="selected"</c:if>>在售</option>
	            			<option value="1" <c:if test="${newInfo.saleStatus == 1}">selected="selected"</c:if>>待售</option>
	            			<option value="2" <c:if test="${newInfo.saleStatus == 2}">selected="selected"</c:if>>在租</option>
	            			<option value="3" <c:if test="${newInfo.saleStatus == 3}">selected="selected"</c:if>>售罄</option>
	            			<option value="4" <c:if test="${newInfo.saleStatus == 4}">selected="selected"</c:if>>待定</option>
	            			<option value="5" <c:if test="${newInfo.saleStatus == 5}">selected="selected"</c:if>>招商</option>
	            		</select>
	            		
            		</div>
            	</div>
            	<div class="new_house_div3">
            		<div class="fl mr10 ft_col">开盘时间:</div>
            		<div class="fl mr270"><input name="openTime" value="${newInfo.openTime}" style="height:30px;width:150px;"  type="text"></div>
            		<div class="fl mr20 ft_col">预计交房:</div>
            		<div class="fl"><input style="height:30px;width:150px;" type="text" class="timePikers1" name="expectedOthers" value="<fmt:formatDate value="${newInfo.expectedOthers}" pattern="yyyy-MM-dd"/>"></div>
            	</div>
            	<div class="new_house_div4">
            		<div class="fl mr10 ft_col">装修状况:</div>
            		<div class="fl mr270">
            			<select name="decorateStatus" style="display:inline-block;width:150px;height:30px;">
            				<option value="0" <c:if test="${newInfo.decorateStatus == 0}">selected="selected"</c:if>>精装修</option>
            				<option value="1" <c:if test="${newInfo.decorateStatus == 1}">selected="selected"</c:if>>毛坯</option>
            				<option value="2" <c:if test="${newInfo.decorateStatus == 2}">selected="selected"</c:if>>简单装修</option>
            				<option value="3" <c:if test="${newInfo.decorateStatus == 3}">selected="selected"</c:if>>毛装修</option>
            				<option value="4" <c:if test="${newInfo.decorateStatus == 4}">selected="selected"</c:if>>公共部分精装修</option>
            				<option value="5" <c:if test="${newInfo.decorateStatus == 5}">selected="selected"</c:if>>毛坯+公共部分精装修</option>
            			</select>
            		</div>
            		<div class="fl mr20 ft_col">建筑面积:</div>
            		<div class="fl"><input name="buildArea" value="${newInfo.buildArea}" class="mr10" type="number" style="height:30px;width:150px;padding-left:6px;">㎡</div>
            	</div>
            	<div class="new_house_div5">
            		<div class="fl mr10 ft_col">占地面积:</div>
            		<div class="fl mr271"><input name="coverArea" value="${newInfo.coverArea}"  type="number" class="mr20" style="width:150px;height:30px;padding-left:6px;"></div>
            		<div class="fl mr20 ft_col">住户数:</div>
            		<div class="fl"><input type="number" step = "1" min= "0" name="householdNum"  value="${newInfo.householdNum}"  style="width:150px;height:30px;padding-left:6px;"></div>
            	</div>
            	<div class="new_house_div6">
            		<div class="fl ml13 mr10 ft_col">绿化率:</div>
            		<div class="fl mr269"><input name="greenRate" value="${newInfo.greenRate}" type="number" class="mr10" style="width:150px;height:30px;padding-left:6px;">%</div>
            		<div class="fl mr20 ft_col">容积率:</div>
            		<div class="fl"><input  name="plotRate" value="${newInfo.plotRate}" type="number" class="mr10" style="width:150px;height:30px;padding-left:6px;">%</div>
            	</div>
            	<div class="new_house_div7">
            		<div class="fl mr10 ft_col">产权年限:</div>
            		<div class="fl mr266"><input name="propertyYears" value="${newInfo.propertyYears}" class="mr10" type="number" max="70" min="0" style="width:150px;height:30px;padding-left:6px;">年</div>
            		<div class="fl mr20 ft_col">停车位:</div>
            		<div class="fl"><input  name="carNum" value="${newInfo.carNum}" class="mr10" type="number" style="width:150px;height:30px;padding-left:6px;">个</div>
            	</div>
            	<div class="new_house_div8">
            		<div class="fl ml13 mr10 ft_col">开发商:</div>
            		<div class="fl"><input name="developer" value="${newInfo.developer}" class="mr10" type="text" style="width:370px;height:30px;padding-left:6px;"></div>
            	</div>
            	<div class="new_house_div9" style="height:90px;">
            		<div class="fl mr10 ft_col">物业类型:</div>
            		<div class="fl" style="width:750px; height:90px;">
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="0" type="checkbox" style="display:none;">  普通住宅
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="1" type="checkbox" style="display:none;">  商住两用
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="2" type="checkbox" style="display:none;">  商品房
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="3" type="checkbox" style="display:none;">  建筑综合体
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="4" type="checkbox" style="display:none;">  商铺
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="5" type="checkbox" style="display:none;">  写字楼
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="6" type="checkbox" style="display:none;">  别墅
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="7" type="checkbox" style="display:none;">  公寓
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="8" type="checkbox" style="display:none;">  洋房
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="houseUse" value="9" type="checkbox" style="display:none;">  酒店 
            		</label>
            		</div>
            		
            	</div>
            	<div class="new_house_div10">
            		<div class="fl mr10 ft_col">物业公司:</div>
            		<div class="fl"><input  name="management" value="${newInfo.management}" class="mr10" type="text" style="width:370px;height:30px;padding-left:6px;"></div>
            	</div>
            	<div class="new_house_div11">
            		<div class="fl ml13 mr10 ft_col">物业费:</div>
            		<div class="fl"><input class="mr10 management_price" name="managementPrice" value="${newInfo.managementPrice}" class="mr10" type="number" style="width:150px;height:30px;padding-left:6px;">元/㎡/月</div>
            	</div>
            	<div class="new_house_div12">
            		<div class="fl ml26 mr10 ft_col">地址:</div>
            		<div class="fl"><input class="mr10 detail_address" name="detailAddress" value="${newInfo.detailAddress}" id="client_add"  type="text" style="width:370px;height:30px;padding-left:6px;"></div>
            		<div class="fl"><div class="init_map"><a style="color:#009bff;text-decoration:underline;" href="javascript:void(0)">点击获取坐标</a></div></div>
            		<input type="hidden" value="${newInfo.province}" name="province">
            		<input type="hidden" value="${newInfo.city}" name="city">
            		<input type="hidden" value="${newInfo.district}" name="district">
            	</div>
            	<div class="new_house_div13 mb10">
            		<div class="fl mr10 ft_col">当前坐标:</div>
            		<div class="fl mr30"><input name="longitude" readonly="true" value="${newInfo.longitude}" class="mr10" type="text" id="longitude" style="width:150px;height:30px;padding-left:6px;"></div>
            		<div class="fl"><input name="latitude"  readonly="true" value="${newInfo.latitude}" class="mr10" type="text" id="latitude" style="width:150px;height:30px;padding-left:6px;"></div>
            	</div>
            </div>
            <div id="container" class="xinfangs ml130 mb20"></div>
            
            <div id="search_result" class="xinfangs ml130">
            	<div class="search_result_div1">
            		<div class="ml20 mt10" style="font-size:16px;">周边交通</div>
            		<textarea class="jiaotong ml20" name="traffic">${newInfo.traffic}</textarea>
            	</div>
            	<div class="search_result_div3">
            		<div class="ml20" style="font-size:16px;">周边商业</div>
            		<textarea class="shangye ml20"name="business">${newInfo.business}</textarea>
            	</div>
            	<div class="search_result_div2">
            		<div class="ml20" style="font-size:16px;">周边医院</div>
            		<textarea class="yiyuan ml20"name="hospital">${newInfo.hospital}</textarea>
            	</div>
            </div>
          </li>
            
            <li class="clear pb38 list_li_com divImageUpload xinfangs">
                <span class="fl span_com">头图:</span>
                <div class="fl div_up_img_nonebg w_540">
                    <img src="<c:if test="${empty newInfo.headImgUrl}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty newInfo.headImgUrl}">${fns:getCosAccessHost()}${newInfo.headImgUrl}</c:if>" class="load_img_com mr10 fl" width="100"/>
                    <div class="fl mt20">
                        <label class="label_load_img">
                            	上传图片<input type="file" name="file" id="headImgUrl" class="hide_com inputImageUpload list4_logo head_img_url"/>
                        </label>
						<input type="hidden" name="headImgUrl" id="headImgUrl" value="${newInfo.headImgUrl}">
                        <input type="button" class="lianjieqidelte <c:if test="${empty newInfo.headImgUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
                        <p class="warn_info">*格式:JPG,PNG,尺寸:750*510(像素)</p>
                    </div>
                </div>
            </li>
            
            <div class="clear pb38 list_li_com pl130 xinfangs">
            	<div class="fl span_com">项目标签:</div>
            	<div class="fl" style="width: 700px;">
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="0" type="checkbox" style="display:none;white-space:nowrap;">  教育地产
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input  name ="projectTag" value="1" type="checkbox" style="display:none;white-space:nowrap;">  品牌开发商
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="2" type="checkbox" style="display:none;white-space:nowrap;">  豪华社区
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="3" type="checkbox" style="display:none;white-space:nowrap;">  低总价
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="4" type="checkbox" style="display:none;white-space:nowrap;">  刚需
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="5" type="checkbox" style="display:none;white-space:nowrap;">  投资地产
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="6" type="checkbox" style="display:none;white-space:nowrap;">  小户型
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="7" type="checkbox" style="display:none;white-space:nowrap;">  不限购
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="8" type="checkbox" style="display:none;white-space:nowrap;">  生态宜居
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="9" type="checkbox" style="display:none;white-space:nowrap;">  海景/水景地产
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="10" type="checkbox" style="display:none;white-space:nowrap;">  现房
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="11" type="checkbox" style="display:none;white-space:nowrap;">  旅游地产
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="12" type="checkbox" style="display:none;white-space:nowrap;">  花园洋房
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="13" type="checkbox" style="display:none;white-space:nowrap;">  地铁沿线
            		</label>
            	</div>
            </div>
            
            <div class="clear pb38 list_li_com pl130 xinfangs">
            	<%-- <div class="fl span_com">视频欣赏:</div>
            	<div class="fl"><input type="text"  name="fyVideo" value="${newInfo.fyVideo}" class="mr10" style="width:250px;height:30px;padding-left:6px;border:1px solid #ccc;" placeholder="填写视频链接地址，格式：http://"></div> --%>
	             <span class="fl span_com">视频欣赏:</span>	
	            	<div class="fl div_up_img_nonebg w_540 divImageUpload" style="width:590px;">
						<video src="<c:if test="${not empty newInfo.fyVideo}">${fns:getCosAccessHost()}${newInfo.fyVideo}</c:if>" controls="controls" class="audio_up_load fl mr10" style="border:1px solid #ccc;"></video>
						<label class="label_load_img fl mr10" style="margin-top:110px;">
							上传视频<input type="file" name="file" id="vedioRukou" class="hide_com inputImageUpload"/>
						</label>
						<input type="text" name="fyVideo" value="${newInfo.fyVideo}" class="btn_tx_com_connter hide_com fl textUpload" readonly="readonly"/>
						<span style="margin-top:110px;" class="lianjieqidelte fl <c:if test="${empty newInfo.fyVideo}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png"/>删除视频</span>
						<p class="warn_info fl" style="margin-top:110px;">*格式:mp4</p>
					</div>
            </div>
             <c:if test="${rightObject.id == null  || fyAttachInfos == null || fyAttachInfos == '[]'}">
                <li class="clear pb38 list_li_com divImageUpload xinfangs zhuli">
	                <span class="fl span_com">主力户型:</span>
	                <div class="fl div_up_img_nonebg w_540">
	                    <img src="${backStatic}/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>
	                    <div class="fl mt20">
	                        <label class="label_load_img">
	                           	 上传图片<input type="file" name="file" id="imgUrl" class="hide_com inputImageUpload list4_logo  zhuli_img"/>
	                        </label>
							<input type="hidden"  class="imgUrl" id="imgUrl">
	                        <input type="button" class="lianjieqidelte hide_com" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
	                        <p class="warn_info">*格式:JPG,PNG,尺寸:649*900(像素)</p>
	                    </div>
	                </div>
	                <div class="clear div_relative huxingmiaoshuss">
	                	<div class="fl span_com">户型描述:</div>
	                	<div class="fl"><input class="householdDesc"   value="${fyAttachInfo.householdDesc}" type="text" placeholder="请输入" class="mr20" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>
	                	<div class="fl mr10" style="color:#859dad;">面积:</div>
	                	<div class="fl mr20" style="color:#859dad;"><input class="area"   value="${fyAttachInfo.area}" class="mr20" type="number" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">㎡</div>
	                	<!-- <div class="delete_huxing fl">删除</div> -->
	                </div>
	            </li>
             </c:if>
             <c:if test="${rightObject.id != null && fyAttachInfos != null && fyAttachInfos != '[]'}">
	             <c:forEach items="${fyAttachInfos}" var="fyAttachInfo" varStatus="index">
	             	<li class="clear pb38 list_li_com divImageUpload xinfangs zhuli">
	                <span class="fl span_com">主力户型:</span>
	             		<div class="fl div_up_img_nonebg w_540 ">
		                    <img src="<c:if test="${empty fyAttachInfo.imgUrl}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty fyAttachInfo.imgUrl}">${fns:getCosAccessHost()}${fyAttachInfo.imgUrl}</c:if>" class="load_img_com mr10 fl" width="100"/>
		                    <div class="fl mt20">
		                        <label class="label_load_img">
		                            	上传图片<input type="file" name="file" id="imgUrl${index.index}" class="hide_com inputImageUpload list4_logo zhuli_img"/>
		                        </label>
								<input type="hidden" class="imgUrl" id="imgUrl" value="${fyAttachInfo.imgUrl}">
		                        <input type="button" class="lianjieqidelte <c:if test="${empty fyAttachInfo.imgUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
		                        <p class="warn_info">*格式:JPG,PNG,尺寸:649*900(像素)</p>
		                    </div>
		                </div>
		                <div class="clear div_relative huxingmiaoshuss">
		                	<div class="fl span_com">户型描述:</div>
		                	<div class="fl"><input class="householdDesc" value="${fyAttachInfo.householdDesc}" type="text" placeholder="请输入" class="mr20 householdDesc" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>
		                	<div class="fl mr10" style="color:#859dad;">面积:</div>
		                	<div class="fl mr20" style="color:#859dad;"><input class="area"  value="${fyAttachInfo.area}" class="mr20" type="number" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">㎡</div>
		                	<!-- <div class="delete_huxing fl">删除</div> -->
		                </div>
		                </li>
	             	</c:forEach>
             	
             </c:if>
          
            
            <li class="clear mb40 list_li_com xinfangs">
				<i class="new_module" id="add_huxing"><i class="icon_cunt mr10"></i>新增户型</i>
			</li>
            
            <li class="clear pb38 list_li_com divImageUpload xinfangs">
                <span class="fl span_com">在售楼栋:</span>
                <div class="fl div_up_img_nonebg w_540">
                    <img src="<c:if test="${empty newInfo.saleBuildingImage}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty newInfo.saleBuildingImage}">${fns:getCosAccessHost()}${newInfo.saleBuildingImage}</c:if>" class="load_img_com mr10 fl" width="100"/>
                    <div class="fl mt20">
                        <label class="label_load_img">
                            上传图片<input type="file" name="file" id="saleBuildingImage" class="hide_com inputImageUpload list4_logo sale_img"/>
                        </label>
						<input type="hidden" name="saleBuildingImage" id="saleBuildingImage" value="${newInfo.saleBuildingImage}">
                        <input type="button" class="lianjieqidelte <c:if test="${empty newInfo.saleBuildingImage}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
                        <p class="warn_info">*格式:JPG,PNG,尺寸:900*649(像素)</p>
                    </div>
                </div>
            </li>
            
            <c:if test="${rightObject.id == null || turnoverTrends =='[]'}">
                <div class="clear pb38 list_li_com xinfangs chengjiaozoushi">
            	<span class="fl span_com div_relative_left130" style="width:164px;">成交走势(单位：元/㎡)</span>
            	<div class="clear div_relative_left150 newtrend">
            		<div class="fl mr10">时间:</div>
            		<div class="fl mr106"><input  class="timePikers ttime" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>
            		<!-- <div class="fl mr106"><input readonly="readonly" id="monthly" value="年/月" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div> -->
            		<div class="fl mr10">成交均价:</div>
            		<div class="fl mr20"><input type="number" class="taveragePrice" class="mr10" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">元/㎡</div>
            		<!-- <div class="delete_shijian1 fl">删除</div>  -->
            	</div>
               </div>
            </c:if>
            <c:if test="${rightObject.id != null && turnoverTrends !=null && turnoverTrends !='[]'}">
              <div class="clear pb38 list_li_com xinfangs chengjiaozoushi">
		         <span class="fl span_com div_relative_left130" style="width:164px;">成交走势(单位：元/㎡)</span>
            	<c:forEach items="${turnoverTrends}" var="turnoverTrend" varStatus="index">
		            	<div class="clear div_relative_left150 newtrend">
		            		<div class="fl mr10">时间:</div>
		            		<div class="fl mr106"><input  value="<fmt:formatDate value="${turnoverTrend.ttime}" pattern="yyyy-MM"/>" class="timePikers ttime" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>
		            		<!-- <div class="fl mr106"><input readonly="readonly" id="monthly" value="年/月" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div> -->
		            		<div class="fl mr10">成交均价:</div>
		            		<div class="fl mr20"><input type="number"  class="taveragePrice"  value="${turnoverTrend.taveragePrice}" class="mr10" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">元/㎡</div>
		            		<div class="fl delete-xinfang-bianji">删除</div>
		            	</div>
            	</c:forEach>
            	</div>
            </c:if>
            <li class="clear mb40 list_li_com xinfangs">
				<i class="new_module" id="add_shijian"><i class="icon_cunt mr10"></i>新增走势</i>
			</li>
		</form>
        <form id="form-rightButton-oldhouse">
            <!-- 二手房部分 -->
			<div class="sub_house ershoufangs clear ml130 list_li_com">
				<div class="new_house_div1">
					<span class="redStar" style="float:left;margin:18px 5px 0 12px;"></span>
					<div class="mr10 fl ft_col">楼盘:</div>
            		<div class="fl mr20"><input name="name" value="${oldInfo.name}" class="pl3 sub_house_input" style="width:300px;height:30px;" type="text"></div>
            		<div class="fl"><a class="zidian_data_sub_house" style="color:#009bff;text-decoration:underline;" href="javascript:void(0);">关联楼盘字典数据</a></div>
				</div>
				<div class="new_house_div2">
					<div class="fl mr10 ft_col"><span class="redStar" style="margin:0 5px 0 12px;"></span>总价:</div>
					<div class="fl mr220"><input type="number" name="totalMoney" value="${oldInfo.totalMoney}" style="width:150px;height:30px;" class="mr10">万</div>
					<div class="fl mr10 ft_col" style="margin-left:11px;">均价:</div>
					<div class="fl"><input type="number" name="averagePrice" value="${oldInfo.averagePrice}" style="width:150px;height:30px;" class="mr10 sub_house_price">元/㎡</div>
				</div>
				<div class="new_house_div3">
					<div class="fl mr10 ft_col"><span class="redStar" style="margin:0 5px 0 12px;"></span>面积:</div>
					<div class="fl mr220"><input type="number" name="buildArea" value="${oldInfo.buildArea}"  style="width:150px;height:30px;" class="mr10 build_area1">㎡</div>
					<div class="fl mr10 ft_col" style="margin-left:11px;">年代:</div>
					<div class="fl"><input type="text" class="timePikers2" name="years" value="${oldInfo.years}"  style="width:150px;height:30px;margin-right:10px!important;" class="mr10 build_year">年</div>
				</div>
				<div class="new_house_div4">
					<div class="fl mr10 ft_col"><span class="redStar" style="margin:0 5px 0 12px;"></span>房型:</div>
					<div class="fl mr236"><input type="number"  name="room" value="${oldInfo.room}"style="width:50px;height:30px;" class="mr10">房<input type="number" style="width:50px;height:30px;" name="hall" value="${oldInfo.hall}" class="ml10 mr10">厅</div>
					<div class="fl mr10 ft_col" style="margin-left:11px;">朝向:</div>
					<div class="fl"><input name="orientations" value="${oldInfo.orientations}" type="text" style="width:150px;height:30px;" class="mr10"></div>
				</div>
				<div class="new_house_div5">
					<div class="fl mr10 ml28 ft_col">楼层:</div>
					<div class="fl mr246">
					<select name="currFloor">
					  	<option value="0" <c:if test="${oldInfo.currFloor == 0}">selected="selected"</c:if>>低楼层</option>
					  	<option value="1" <c:if test="${oldInfo.currFloor == 1}">selected="selected"</c:if>>中低楼层</option>
					  	<option value="2" <c:if test="${oldInfo.currFloor == 2}">selected="selected"</c:if>>中间楼层</option>
					  	<option value="3" <c:if test="${oldInfo.currFloor == 3}">selected="selected"</c:if>>中高楼层</option>
					  	<option value="4" <c:if test="${oldInfo.currFloor == 4}">selected="selected"</c:if>>高楼层</option>
					</select>
					/<input name="totalFloor" value="${oldInfo.totalFloor}"  type="number" style="width:50px;height:30px;" class="ml10 mr10">层</div>
				</div>
				<div class="new_house_div6">
					<div class="fl mr10 ft_col">装修状况:</div>
            		<div class="fl mr270">
            			<select name="decorateStatus"style="display:inline-block;width:150px;height:30px;">
            				<option value="0" <c:if test="${oldInfo.decorateStatus == 0}">selected="selected"</c:if>>精装</option>
            				<option value="1" <c:if test="${oldInfo.decorateStatus == 1}">selected="selected"</c:if>>毛坯</option>
            				<option value="2" <c:if test="${oldInfo.decorateStatus == 2}">selected="selected"</c:if>>简装</option>
            				<option value="3" <c:if test="${oldInfo.decorateStatus == 3}">selected="selected"</c:if>>豪装</option>
            			</select>
            		</div>
				</div>
				<div class="new_house_div7">
					<div class="fl ml26 mr10 ft_col">地址:</div>
            		<div class="fl"><input name="detailAddress" value="${oldInfo.detailAddress}"id="client_add1" class="mr10 detail_address1" type="text" style="width:370px;height:30px;padding-left:6px;"></div>
            		<div class="fl"><div class="init_map3"><a style="color:#009bff;text-decoration:underline;" href="javascript:void(0)">点击获取坐标</a></div></div>
            		<input type="hidden" value="${oldInfo.province}" name="province">
            		<input type="hidden" value="${oldInfo.city}" name="city">
            		<input type="hidden" value="${oldInfo.district}" name="district">
				</div>
				<div class="new_house_div8 mb10">
					<div class="fl mr10 ft_col">当前坐标:</div>
            		<div class="fl mr30"><input name="longitude"  readonly="true" value="${oldInfo.longitude}"class="mr10" type="text" id="longitude1" style="width:150px;height:30px;padding-left:6px;"></div>
            		<div class="fl"><input class="mr10" type="text" readonly="true" name="latitude" value="${oldInfo.latitude}" id="latitude1" style="width:150px;height:30px;padding-left:6px;"></div>
				</div>
			</div>
			
			<div id="container1" class="ershoufangs ml130 mb20"></div>
			<div id="search_result1" class="ershoufangs ml130">
            	<div class="search_result_div11">
            		<div class="ml20 mt10" style="font-size:16px;">周边交通</div>
            		<textarea class="jiaotong1 ml20" name="traffic">${oldInfo.traffic}</textarea>
            	</div>
            	<div class="search_result_div31">
            		<div class="ml20" style="font-size:16px;">周边商业</div>
            		<textarea class="shangye1 ml20" name="business">${oldInfo.business}</textarea>
            	</div>
            	<div class="search_result_div21">
            		<div class="ml20" style="font-size:16px;">周边医院</div>
            		<textarea class="yiyuan1 ml20"  name="hospital">${oldInfo.hospital}</textarea>
            	</div>
            </div>
            
            <li class="clear pb38 list_li_com divImageUpload ershoufangs">
                <span class="fl span_com">头图:</span>
                <div class="fl div_up_img_nonebg w_540">
                    <img src="<c:if test="${empty oldInfo.headImgUrl}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty oldInfo.headImgUrl}">${fns:getCosAccessHost()}${oldInfo.headImgUrl}</c:if>" class="load_img_com mr10 fl" width="100"/>
                    <div class="fl mt20">
                        <label class="label_load_img">
                            	上传图片<input type="file" name="file" id="erheadImgUrl" class="hide_com inputImageUpload list4_logo head_img_url"/>
                        </label>
						<input type="hidden" name="headImgUrl" id="headImgUrl" value="${oldInfo.headImgUrl}">
                        <input type="button" class="lianjieqidelte <c:if test="${empty oldInfo.headImgUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
                        <p class="warn_info">*格式:JPG,PNG,尺寸:750*510(像素)</p>
                    </div>
                </div>
            </li>
            <div class="clear pb38 list_li_com pl130 ershoufangs">
            	<div class="fl span_com">项目标签:</div>
            	<div class="fl">
            		<label for="jiaoyu1" class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name="projectTag" value="0" id="jiaoyu1" type="checkbox" style="display:none;">  满两年
            		</label>
            		<label for="pingpai1" class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name="projectTag" value="1" id="pingpai1" type="checkbox" style="display:none;">  满五年
            		</label>
            		<label for="shequ1" class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name="projectTag" value="2" id="shequ1" type="checkbox" style="display:none;">  红本在手
            		</label>
            		<label for="zongjia1" class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name="projectTag" value="3" id="zongjia1" type="checkbox" style="display:none;">  学位房
            		</label>
            		<label for="xuqiu1" class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name="projectTag" value="4" id="xuqiu1" type="checkbox" style="display:none;"> 学区房
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="5" type="checkbox" style="display:none;">  地铁物业
            		</label>
            		<label class="mr20 check_box_click">
            			<i class="radio_no"></i>
            			<input name ="projectTag" value="6" type="checkbox" style="display:none;">  南北通透
            		</label>
            	</div>
            </div>
           <%--   <c:if test="${rightObject.id == null  || fyAttachInfos == null || fyAttachInfos == '[]'}">
                <li class="clear pb38 list_li_com divImageUpload ershoufangs zhuli1">
	                <span class="fl span_com">主力户型:</span>
	                <div class="fl div_up_img_nonebg w_540">
	                    <img src="${backStatic}/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>
	                    <div class="fl mt20">
	                        <label class="label_load_img">
	                           	 上传图片<input type="file" name="file" id="oldimgUrl" class="hide_com inputImageUpload list4_logo  zhuli_img"/>
	                        </label>
							<input type="hidden"  class="imgUrl" id="imgUrl">
	                        <input type="button" class="lianjieqidelte hide_com" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
	                        <p class="warn_info">*格式:JPG,PNG,尺寸:649*900(像素)</p>
	                    </div>
	                </div>
	                <div class="clear div_relative huxingmiaoshuss">
	                	<div class="fl span_com">户型描述:</div>
	                	<div class="fl"><input class="householdDesc"   value="${fyAttachInfo.householdDesc}" type="text" placeholder="请输入" class="mr20" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>
	                	<div class="fl mr10" style="color:#859dad;">面积:</div>
	                	<div class="fl mr20" style="color:#859dad;"><input class="area"   value="${fyAttachInfo.area}" class="mr20" type="number" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">㎡</div>
	                	<!-- <div class="delete_huxing fl">删除</div> -->
	                </div>
	            </li>
             </c:if>
             <c:if test="${rightObject.id != null && fyAttachInfos != null && fyAttachInfos != '[]'}">
	             <c:forEach items="${fyAttachInfos}" var="fyAttachInfo" varStatus="index">
	             	<li class="clear pb38 list_li_com divImageUpload ershoufangs zhuli1">
	                <span class="fl span_com">主力户型:</span>
	             		<div class="fl div_up_img_nonebg w_540 ">
		                    <img src="<c:if test="${empty fyAttachInfo.imgUrl}">${backStatic}/images/img_logo1.png </c:if><c:if test="${not empty fyAttachInfo.imgUrl}">${fns:getCosAccessHost()}${fyAttachInfo.imgUrl}</c:if>" class="load_img_com mr10 fl" width="100"/>
		                    <div class="fl mt20">
		                        <label class="label_load_img">
		                            	上传图片<input type="file" name="file" id="imgUrl${index.index}" class="hide_com inputImageUpload list4_logo zhuli_img"/>
		                        </label>
								<input type="hidden" class="imgUrl" id="imgUrl" value="${fyAttachInfo.imgUrl}">
		                        <input type="button" class="lianjieqidelte <c:if test="${empty fyAttachInfo.imgUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
		                        <p class="warn_info">*格式:JPG,PNG,尺寸:649*900(像素)</p>
		                    </div>
		                </div>
		                <div class="clear div_relative huxingmiaoshuss">
		                	<div class="fl span_com">户型描述:</div>
		                	<div class="fl"><input class="householdDesc" value="${fyAttachInfo.householdDesc}" type="text" placeholder="请输入" class="mr20 householdDesc" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>
		                	<div class="fl mr10" style="color:#859dad;">面积:</div>
		                	<div class="fl mr20" style="color:#859dad;"><input class="area"  value="${fyAttachInfo.area}" class="mr20" type="number" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">㎡</div>
		                	<!-- <div class="delete_huxing fl">删除</div> -->
		                </div>
		                </li>
	             	</c:forEach>
             	
             </c:if>
          
            
            <li class="clear mb40 list_li_com ershoufangs">
				<i class="new_module" id="add_huxing1"><i class="icon_cunt mr10"></i>新增户型</i>
			</li> --%>
            <div class="clear pb38 list_li_com pl130 ershoufangs">
            	<div class="fl mr10 span_com" style="line-height:initial;">房源特色:</div>
            	<div class="fl">
            		<textarea class="fangyuan-tese" rows="9" cols="90" style="border:1px solid #ccc;font:initial!important;" name="fyItem">${oldInfo.fyItem}</textarea>
            	</div>
            </div>
            <c:if test="${rightObject.id == null}">
                <div class="clear pb38 list_li_com ershoufangs chengjiaozoushi">
            	<span class="fl span_com div_relative_left130" style="width:164px;">成交走势(单位：元/㎡)</span>
            	<div class="clear div_relative_left150  oldtrend">
            		<div class="fl mr10">时间:</div>
            		<div class="fl mr106"><input  class="timePikers ttime" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>
            		<!-- <div class="fl mr106"><input readonly="readonly" id="monthly" value="年/月" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div> -->
            		<div class="fl mr10">成交均价:</div>
            		<div class="fl mr20"><input type="number"   class="mr10 taveragePrice" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">元/㎡</div>
            		<!-- <div class="delete_shijian1 fl">删除</div>  -->
            	</div>
               </div>
            </c:if>
            <c:if test="${rightObject.id != null}">
            	<c:forEach items="${turnoverTrends}" var="turnoverTrend" varStatus="index">
            		  <div class="clear pb38 list_li_com ershoufangs chengjiaozoushi">
		            	<span class="fl span_com div_relative_left130" style="width:164px;">成交走势(单位：元/㎡)</span>
		            	<div class="clear div_relative_left150 oldtrend">
		            		<div class="fl mr10">时间:</div>
		            		<div class="fl mr106"><input  value="<fmt:formatDate value="${turnoverTrend.ttime}" pattern="yyyy-MM"/>" class="timePikers ttime" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>
		            		<!-- <div class="fl mr106"><input readonly="readonly" id="monthly" value="年/月" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div> -->
		            		<div class="fl mr10">成交均价:</div>
		            		<div class="fl mr20"><input type="number"  value="${turnoverTrend.taveragePrice}" class="mr10 taveragePrice" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">元/㎡</div>
		            		<div class="delete-ershoufang-bianji fl">删除</div> 
		            	</div>
		            </div>
            	</c:forEach>
            </c:if>
            <li class="clear mb40 list_li_com ershoufangs">
				<i class="new_module" id="add_shijian1"><i class="icon_cunt mr10"></i>新增走势</i>
			</li>
			
		</form>
		</div>
		</div>
		<div style="background:#f1f6f9;height:20px;"></div>
      <form id="form-rightButton-add">
      <input type="hidden" name="objectId" value="${id}" id="objectId">
      <input type="hidden" name="rightId" value="${rightObject.id}" id="rightId">
      <input type="hidden" name="leftId" value="${leftButton.id}" id="leftId">
      <input type="hidden" name="fyId" value="${fyId}" id="fyId">
      <!-- 一起代言 -->
      <div class="list3divlisht br_dash_b">
		<li class="connter_module_title connter_module_title1 clear pl0"><div class="showOrhide4"><i class="redStar" style="margin-left:114px; margin-right:5px;"></i><span>一起代言</span><p style="width:74px;height:100%;float:right;overflow:hidden;"><b class="wraper5_b"></b><i class="down_arrow"></i></p></div> </li>
		
		<div class="wraper5" style="display:none;">
			<li class="clear mb20 list_li_com">
				<span class="fl span_com">入口标题:</span>
				<span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/daiyan.png" style="width:362px;height:640px;"/></span>
				<input type="text" name="yqdyEntryTitle" value="${rightObject.yqdyEntryTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
				<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
			</li>

		<li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">入口图标:</span>
			 <label class="radio_label_click rukoutubiao_type"><i class="radio_<c:if test="${rightObject.yqdyEntryIconType == 0 || rightObject.yqdyEntryIconType == null}">yes</c:if><c:if test="${rightObject.yqdyEntryIconType != 0 && rightObject.yqdyEntryIconType != null}">no</c:if> mr5"></i><input name="yqdyEntryIconType" type="radio" value="0"  <c:if test="${lsList.yqdyEntryIconType == 0 || lsList.headType == null}">checked="checked"</c:if> class="mr5 hide_com clickhide"/>标准图标</label>
             <label class="ml20 radio_label_click rukoutubiao_type"><i class="radio_<c:if test="${rightObject.yqdyEntryIconType == 1}">yes</c:if><c:if test="${rightObject.yqdyEntryIconType !=1}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com clickshow"  <c:if test="${rightObject.yqdyEntryIconType == 1}">checked="checked"</c:if> value="1" name="yqdyEntryIconType"/>最后一位访客头像</label>
			 <div class="fl div_up_img_nonebg w_540 ml130 rukou_show_hide" style="display:<c:if test="${rightObject.yqdyEntryIconType == 0 || rightObject.yqdyEntryIconType == null}">block</c:if><c:if test="${rightObject.yqdyEntryIconType != 0 && rightObject.yqdyEntryIconType != null}">none</c:if>">
				<img src="<c:if test="${empty rightObject.yqdyEntryIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/icon_daiyans.png </c:if><c:if test="${not empty rightObject.yqdyEntryIcon}">${fns:getCosAccessHost()}${rightObject.yqdyEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="yqdyrukoutu" class="hide_com inputImageUpload rukou_icon"/>
					</label>
					<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_daiyans.png" data-vals="/material/sys/linker/default/icon_daiyans.png" value="还原默认图标"/>
					<input type="hidden" name="yqdyEntryIcon" class="" data-reg="emptys" id="yqdyEntryIcon" value="<c:if test="${empty rightObject.yqdyEntryIcon}">/material/sys/linker/default/icon_daiyans.png </c:if><c:if test="${not empty rightObject.yqdyEntryIcon}">${rightObject.yqdyEntryIcon}</c:if>">
					<span class="warn_tx_com hide_com">*不能为空</span>
					<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
				</div>
			</div>
		</li>


		<li class="clear mb20 list_li_com">
			<span class="fl span_com">顶部标题:</span>
			<input type="text" name="yqdyTopText" value="${rightObject.yqdyTopText}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflaseten" maxlength="10" placeholder="请输入10个字之内的顶部标题"/>
			<span class="warn_tx_com hide_com">*请输入10个字符内的标题</span>
		</li>
		
		<li class="clear mb20 list_li_com">
			<span class="fl span_com">代言标题:</span>
			<input type="text" name="yqdyTitle" value="${rightObject.yqdyTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflaseten" maxlength="10" placeholder="请输入10个字之内的代言标题"/>
			<span class="warn_tx_com hide_com">*请输入10个字符内的标题</span>
			<div class="clear"></div>
			<div style="margin-left:130px;font-size: 12px;color:#ccc;line-height: 30px;">示例：已有x位代言人（x表示代言人数量，若填写了x，将替换成实际数字）</div>
		</li>
		
		<li class="clear list_li_com pb38">
			<span class="fl span_com">一句话描述:</span>
			<input type="text" name="yqdyBewrite" value="${rightObject.yqdyBewrite}" class="btn_tx_com_connter fl " data-reg="emptys" maxlength="30" placeholder="请输入30个字之内的描述"/>
			<span class="warn_tx_com hide_com">*不能为空</span>
		</li>
		</div>
		
		</div>
		<div style="background:#f1f6f9;height:20px;"></div>
        <!-- 语音 -->
        <div class="list3divlisht br_dash_b">
		<li class="connter_module_title connter_module_title1 clear pl0"><div class="showOrhide1"><span class="ml130">语音</span><p style="width:74px;height:100%;float:right;overflow:hidden;"><b class="wraper2_b"></b><i class="down_arrow"></i></p></div></li>
		
		<div class="wraper2" style="display:none;">
			<li class="clear mb20 list_li_com">
			<span class="fl span_com">入口标题:</span>
			<span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span>
			<input type="text" name="yyEntryTitle" value="${rightObject.yyEntryTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
		    <span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
		</li>
        
		<li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">入口图标:</span>
			<div class="fl div_up_img_nonebg w_540">
				<img src="<c:if test="${empty rightObject.yyEntryIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/icon_yuyin.png </c:if><c:if test="${not empty rightObject.yyEntryIcon}">${fns:getCosAccessHost()}${rightObject.yyEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="yyrukoutu" class="hide_com inputImageUpload rukou_icon"/>
					</label>
					<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_yuyin.png" data-vals="/material/sys/linker/default/icon_yuyin.png" value="还原默认图标"/>
					<input type="hidden" name="yyEntryIcon" id="yyEntryIcon" value="<c:if test="${empty rightObject.yyEntryIcon}">/material/sys/linker/default/icon_yuyin.png </c:if><c:if test="${not empty rightObject.yyEntryIcon}">${rightObject.yyEntryIcon}</c:if>">
					<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
				</div>
			</div>
		</li>
		
		<li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">暂停图标:</span>
			<div class="fl div_up_img_nonebg w_540">
				<img src="<c:if test="${empty rightObject.yyStopIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/icon_zanting.png </c:if><c:if test="${not empty rightObject.yyStopIcon}">${fns:getCosAccessHost()}${rightObject.yyStopIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="yyzantingtu" class="hide_com inputImageUpload rukou_icon"/>
					</label>
					<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_zanting.png" data-vals="/material/sys/linker/default/icon_zanting.png"  value="还原默认图标"/>
					<input type="hidden" name="yyStopIcon" id="yyStopIcon" value="<c:if test="${empty rightObject.yyStopIcon}">/material/sys/linker/default/icon_zanting.png </c:if><c:if test="${not empty rightObject.yyStopIcon}">${rightObject.yyStopIcon}</c:if>">
					<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
				</div>
			</div>
		</li>
		<c:if test="${rightObject.id == null || linkerYyInfos == null || linkerYyInfos == '[]'}">
			<div class="yuyinDiv">
				<li class="clear mb20 list_li_com divImageUpload">
					<span class="fl span_com">上传语音:</span>
					<audio src="" controls="controls" class="audio_up_load fl mr10"></audio>
					<label class="label_load_img fl mr10">
						上传语音<input type="file" name="file" id="yuurlRukou" class="hide_com inputImageUpload"/>
					</label>
					<input type="text"  value="" class="btn_tx_com_connter hide_com fl textUpload yyUrl" readonly="readonly"/>
					<span class="lianjieqidelte fl hide_com" data-val="${backStatic}/images/img_logo1.png"/>删除语音</span>
					<p class="warn_info fl">*格式:mp3</p>
					<!-- <div class="delete_yuyin fl ml10">删除</div> -->
				</li>
				<li class="clear list_li_com pb38">
		                <span class="fl span_com">语音适用页面:</span>
						<select id="yySyGroupId" data-val="${linkerYyInfo.yySyGroupId}" class="alert_select yySyGroupId" style="width:140px;">
			            	<%-- <option value="0" <c:if test="${rightObject.yySyPage == 0}">selected="selected"</c:if>>首页</option>
			            	<option value="2" <c:if test="${rightObject.yySyPage == 2}">selected="selected"</c:if>>首页+详情页</option> --%>
			            	<option value="0">全部</option>
			            </select>
			            
			            <select id="yySyScene" data-val="${linkerYyInfo.yySyScene}"  class="alert_select yySyScene" style="width:140px;">
			            	<option value="0">全部</option>
			            </select>
		        </li>
	        </div>
		</c:if>
		<c:if test="${rightObject.id != null && linkerYyInfos != null && linkerYyInfos != '[]'}">
			<c:forEach items="${linkerYyInfos}" var="linkerYyInfo" varStatus="index">
				<div class="yuyinDiv">
					<li class="clear mb20 list_li_com divImageUpload">
						<span class="fl span_com">上传语音:</span>
						<audio src="<c:if test="${not empty linkerYyInfo.yyUrl}">${fns:getCosAccessHost()}${linkerYyInfo.yyUrl}</c:if>" controls="controls" class="audio_up_load fl mr10"></audio>
						<label class="label_load_img fl mr10">
							上传语音<input type="file" name="file" id="yuurlRukou${index.index}" class="hide_com inputImageUpload"/>
						</label>
						<input type="text"  value="${linkerYyInfo.yyUrl}" class="btn_tx_com_connter hide_com fl textUpload yyUrl" readonly="readonly"/>
						<span class="lianjieqidelte fl hide_com" data-val="${backStatic}/images/img_logo1.png"/>删除语音</span>
						<p class="warn_info fl">*格式:mp3</p>
						<!-- <div class="delete_yuyin fl ml10">删除</div> -->
					</li>
					<li class="clear list_li_com pb38">
			                <span class="fl span_com">语音适用页面:</span>
							<select  id="yySyGroupId" data-val="${linkerYyInfo.yySyGroupId}"class="alert_select yySyGroupId" style="width:140px;">
				            	<%-- <option value="0" <c:if test="${rightObject.yySyPage == 0}">selected="selected"</c:if>>首页</option>
				            	<option value="2" <c:if test="${rightObject.yySyPage == 2}">selected="selected"</c:if>>首页+详情页</option> --%>
				            	<option value="0">全部</option>
				            </select>
				            
				            <select id="yySyScene"data-val="${linkerYyInfo.yySyScene}" class="alert_select yySyScene" style="width:140px;">
				            	<option value="0">全部</option>
				            </select>
			        </li>
		        </div>
			</c:forEach>
		</c:if>
        <li class="clear mb40 list_li_com">
			<i class="new_module" id="xinzeng_yuyin"><i class="icon_cunt mr10"></i>新增语音</i>
		</li>
        
		</div>
		
		</div>
		<div style="background:#f1f6f9;height:20px;"></div>
        
        <!-- 音乐 -->
        <div class="list3divlisht br_dash_b">
		<li class="connter_module_title connter_module_title1 clear pl0"><div class="showOrhide2"><span class="ml130">音乐</span><p style="width:74px;height:100%;float:right;overflow:hidden;"><b class="wraper3_b"></b><i class="down_arrow"></i></p></div></li>
		
		<div class="wraper3" style="display:none;">
			<li class="clear mb20 list_li_com">
			<span class="fl span_com">入口标题:</span>
			<span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span>
			<input type="text" name="musicEntryTitle" value="${rightObject.musicEntryTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
		    <span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
		</li>
        
		<li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">入口图标:</span>
			<div class="fl div_up_img_nonebg w_540">
				<img src="<c:if test="${empty rightObject.musicEntryIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/icon_yinyue.png</c:if><c:if test="${not empty rightObject.musicEntryIcon}">${fns:getCosAccessHost()}${rightObject.musicEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="musicrukoutu" class="hide_com inputImageUpload rukou_icon"/>
					</label>
					<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_yinyue.png" data-vals="/material/sys/linker/default/icon_yinyue.png" value="还原默认图标"/>
					<input type="hidden" name="musicEntryIcon" id="musicEntryIcon" value="<c:if test="${empty rightObject.musicEntryIcon}">/material/sys/linker/default/icon_yinyue.png </c:if><c:if test="${not empty rightObject.musicEntryIcon}">${rightObject.musicEntryIcon}</c:if>">
					<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
				</div>
			</div>
		</li>
		
		<li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">暂停图标:</span>
			<div class="fl div_up_img_nonebg w_540">
				<img src="<c:if test="${empty rightObject.musicStopIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/icon_zanting.png </c:if><c:if test="${not empty rightObject.musicStopIcon}">${fns:getCosAccessHost()}${rightObject.musicStopIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="musiczantingtu" class="hide_com inputImageUpload rukou_icon"/>
					</label>
					<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_zanting.png" data-vals="/material/sys/linker/default/icon_zanting.png"  value="还原默认图标"/>
					<input type="hidden" name="musicStopIcon" id="musicStopIcon" value="<c:if test="${empty rightObject.musicStopIcon}">/material/sys/linker/default/icon_zanting.png </c:if><c:if test="${not empty rightObject.musicStopIcon}">${rightObject.musicStopIcon}</c:if>">
					<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
				</div>
			</div>
		</li>
		
		<li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">上传音乐:</span>
			<audio src="<c:if test="${not empty rightObject.musicUrl}">${fns:getCosAccessHost()}${rightObject.musicUrl}</c:if>" controls="controls" class="audio_up_load fl mr10"></audio>
			<label class="label_load_img fl mr10">
				上传音乐<input type="file" name="file" id="musicRukou" class="hide_com inputImageUpload"/>
			</label>
			<input type="hidden" name="musicUrl" value="${rightObject.musicUrl}" class="btn_tx_com_connter hide_com fl textUpload" readonly="readonly"/>
			<span class="lianjieqidelte fl <c:if test="${empty rightObject.musicUrl}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png"/>删除音乐</span>
			<p class="warn_info fl">*格式:mp3</p>
		</li>

        
		<li class="clear list_li_com pb38 ">
                <span class="fl span_com">音乐适用页面:</span>
				<select name="yySyPage" class="alert_select">
            	<option value="0" <c:if test="${rightObject.musicSyPage == 0}">selected="selected"</c:if>>首页</option>
            	<%-- <option value="1" <c:if test="${rightObject.yySyPage == 1}">selected="selected"</c:if>>详情页</option> --%>
            	<option value="2" <c:if test="${rightObject.musicSyPage == 2}">selected="selected"</c:if>>首页+详情页</option>
            	<%-- <option value="3" <c:if test="${rightObject.yySyPage == 3}">selected="selected"</c:if>>每个720场景</option> --%>
            </select>
        </li>
		</div>
		
		</div>
		<div style="background:#f1f6f9;height:20px;"></div>
		<!-- 红包 -->
		<div class="list3divlisht br_dash_b">
			<li class="connter_module_title connter_module_title1 clear pl0"><div class="showOrhide6"><span class="ml130">红包</span><p style="width:74px;height:100%;float:right;overflow:hidden;"><b class="wraper7_b"></b><i class="down_arrow"></i></p></div> </li>
			<div class="wraper7" style="display:none;">
				<li class="clear mb20 list_li_com">
					<span class="fl span_com">入口标题:</span>
					<span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span>
					<input type="text" name="hbEntryTitle" value="${rightObject.hbEntryTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
					<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
				</li>
				
				<li class="clear mb20 list_li_com divImageUpload">
					<span class="fl span_com">入口图标:</span>
					<div class="fl div_up_img_nonebg w_540">
						<img src="<c:if test="${empty rightObject.hbEntryIcon}">${backStatic}/images/icon_hb.png </c:if><c:if test="${not empty rightObject.hbEntryIcon}">${fns:getCosAccessHost()}${rightObject.hbEntryIcon}</c:if>" class="load_img_com mr10 fl hongbao_tubiao" width="100"/>
						<div class="fl mt20">
							<label class="label_load_img">
								上传图片<input type="file" name="file" id="hbrukoutu" class="hide_com inputImageUpload rukou_icon"/>
							</label>
							<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_hb.png" data-vals="/material/sys/linker/default/icon_hb.png" value="还原默认图标"/>
							<input type="hidden" name="hbEntryIcon" class="" data-reg="emptys" id="hbEntryIcon" value="<c:if test="${empty rightObject.hbEntryIcon}">/material/sys/linker/default/icon_hb.png </c:if><c:if test="${not empty rightObject.hbEntryIcon}">${rightObject.hbEntryIcon}</c:if>">
							<span class="warn_tx_com hide_com">*不能为空</span>
							<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
						</div>
					</div>
				</li>
				
				<li class="clear mb20 list_li_com">
					<span class="fl span_com">链接:</span>
					<input type="text" name="hbUrl" value="${rightObject.hbUrl}" class="btn_tx_com_connter fl reg_rempty link_reg_input" data-reg="empstyflasesix" placeholder="请输入链接,以http://开头"/>
					<span class="warn_tx_com hide_com">*请输入正确的链接</span>
				</li>
			</div>
		</div>
		<div style="background:#f1f6f9;height:20px;"></div>
		<!-- 卡券 -->
		<div class="list3divlisht br_dash_b">
			<li class="connter_module_title connter_module_title1 clear pl0"><div class="showOrhide3"><span class="ml130">卡券</span><p style="width:74px;height:100%;float:right;overflow:hidden;"><b class="wraper4_b"></b><i class="down_arrow"></i></p></div> </li>
			<div class="wraper4" style="display:none;">
				<li class="clear mb20 list_li_com">
					<span class="fl span_com">入口标题:</span>
					<span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span>
					<input type="text" name="kqEntryTitle" value="${rightObject.kqEntryTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
					<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
				</li>
				<li class="clear mb20 list_li_com divImageUpload">
					<span class="fl span_com">入口图标:</span>
					<div class="fl div_up_img_nonebg w_540">
						<img src="<c:if test="${empty rightObject.kqEntryIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/icon_kaquan_default.png</c:if><c:if test="${not empty rightObject.kqEntryIcon}">${fns:getCosAccessHost()}${rightObject.kqEntryIcon}</c:if>" class="load_img_com mr10 fl kaquan-tubiao" width="100"/>
						<div class="fl mt20">
							<label class="label_load_img">
								上传图片<input type="file" name="file" id="kqrukoutu" class="hide_com inputImageUpload rukou_icon_kq"/>
							</label>
							<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_kaquan_default.png" data-vals="/material/sys/linker/default/icon_kaquan_default.png" value="还原默认图标"/>
							<input type="hidden" name="kqEntryIcon" class="" data-reg="emptys" id="kqEntryIcon" value="<c:if test="${empty rightObject.kqEntryIcon}">/material/sys/linker/default/icon_kaquan_default.png </c:if><c:if test="${not empty rightObject.kqEntryIcon}">${rightObject.kqEntryIcon}</c:if>">
							<span class="warn_tx_com hide_com">*不能为空</span>
							<p class="warn_info">*格式:PNG,尺寸:144*72(像素)</p>
						</div>
					</div>
				</li>
				
				<li class="clear mb20 list_li_com">
					<span class="fl span_com">链接:</span>
					<input type="text" name="kqUrl" value="${rightObject.kqUrl}" class="btn_tx_com_connter fl reg_rempty link_reg_input" data-reg="empstyflasesix" placeholder="请输入链接,以http://开头"/>
					<span class="warn_tx_com hide_com">*请输入正确的链接</span>
				</li>
			</div>
		</div>
		<div style="background:#f1f6f9;height:20px;"></div>
		
		<div class="list3divlisht">
		<span class="quesi_span zidingyi_shiliss"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span>
		<li class="connter_module_title connter_module_title1 clear pl0"><div class="showOrhide7"><span class="ml130">自定义按钮 </span><p style="width:74px;height:100%;float:right;overflow:hidden;"><b class="wraper8_b"></b><i class="down_arrow"></i></p></div></li>
		
			<%-- <c:if test="${index.index >= 1}">
				<i class="icon_module_del click_module_del click_module_del_btn_list"></i>
			</c:if>  --%>
		<div class="wraper8" style="display:none;">
	        <c:if test="${lCusButton !=null}">
		        <c:forEach items="${lCusButton}" var="lCusButton" varStatus="index">
				<li class="clear mb20 list_li_com zdyDiv">
					<ul class="ziyidinganan">
						<li class="clear mb20 list_li_com">
							<span class="fl span_com">入口标题:</span>
							<input type="text" value="${lCusButton.zdyanEntryTitle}" class="btn_tx_com_connter reg_rempty zdyanEntryTitle" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>	
							<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
						</li>
						<li class="clear mb20 list_li_com divImageUpload">
							<span class="fl span_com">入口图标:</span>
							<div class="fl div_up_img_nonebg w_540">
								<img src="<c:if test="${empty lCusButton.zdyanEntryIcon}">${backStatic}/images/img_logo1.png</c:if><c:if test="${not empty lCusButton.zdyanEntryIcon}">${fns:getCosAccessHost()}${lCusButton.zdyanEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
								<div class="fl mt20">
									<label class="label_load_img">
										上传图片<input type="file" name="file" id="zdy_rukoutupian${index.index}" class="hide_com inputImageUpload rukou_icon"/>
									</label>
									<input type="hidden"  id="zdyanEntryIcon" class="zdyanEntryIcon" value="${lCusButton.zdyanEntryIcon}">
									<input type="button" class="lianjieqidelte <c:if test="${empty lCusButton.zdyanEntryIcon}">hide_com</c:if>" data-val="${backStatic}/images/img_logo1.png" value="删除图片"/>
									<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
								</div>
							</div>
						</li>
						<li class="clear mb20 list_li_com">
							<span class="fl span_com">入口链接:</span>
							<label class="radio_label_click mr60 type_selects"><i class="radio_<c:if test="${lCusButton.zdyanType == 0}">yes</c:if><c:if test="${lCusButton.zdyanType != 0}">no</c:if> mr5"></i><input type="radio" class="mr5 hide_com" <c:if test="${lCusButton.zdyanType == 0}">checked="checked"</c:if>  value="0"/>跳链接</label>
	            			<label class="ml20 radio_label_click mr60 type_selects"><i class="radio_<c:if test="${lCusButton.zdyanType == 1}">yes</c:if><c:if test="${lCusButton.zdyanType != 1}">no</c:if> mr5"></i><input type="radio" <c:if test="${lCusButton.zdyanType == 1}">checked="checked"</c:if> class="ml10 mr5 hide_com" value="1" />弹出二维码浮窗</label>
						</li>
						<li class="clear mb20 list_li_com">
							<span class="fl span_com">链接地址:</span>
							<input type="text"  value="${lCusButton.zdyanUrl}"  class="btn_tx_com_connter fl link_reg_input zdyanUrl"/>
							<span class="warn_tx_com hide_com">*输入正确的链接</span>
						</li>
					</ul>
					
					<i class="icon_module_del click_module_del click_module_del_btn_list" style="margin-top:15px;"></i>
				<%-- <c:if test="${index.index >= 1}">
					<i class="icon_module_del click_module_del click_module_del_btn_list"></i>
				</c:if>  --%>
				
				</li>
		        </c:forEach>
	        </c:if>
	        
			<li class="clear list_li_com" style="width:100%;">
				<i class="new_module new_module_gai" style="width:100%;" id="click_new_btn_list"><i class="icon_cunt mr10 icon_cunt_genggai"></i>新增自定义按钮</i>
			</li>
			</div>
		</div>
		<div style="background:#f1f6f9;height:20px;"></div>
		<!-- 开关按钮 -->
		<div class="list3divlisht">
			<li class="connter_module_title connter_module_title1 clear pl0"><div class="showOrhide5"><span class="ml130">开关按钮</span><p style="width:74px;height:100%;float:right;overflow:hidden;"><b class="wraper6_b"></b><i class="down_arrow"></i></p></div> </li>
			<div class="wraper6" style="display:none;">
				<!-- 陀螺仪 -->
				<c:if test="${object.panoType=='zoomingPano'}">
				<%-- <div>
				<li class="clear list_li_com pb38">
	                <span class="fl span_com">自动旋转:</span>
	                <label class="radio_label_click w_200"><i class="radio_<c:if test="${leftButton.autorotationType == 0}">yes</c:if><c:if test="${leftButton.autorotationType != 0 }">no</c:if> mr5"></i><input type="radio" class="mr5 hide_com" <c:if test="${leftButton.autorotationType == 0}">checked="checked"</c:if> name="autorotationType" value="0"/>不需要自动旋转</label>
	                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${leftButton.autorotationType == 1  || leftButton.autorotationType == null}">yes</c:if><c:if test="${leftButton.autorotationType == 0}">no</c:if> mr5"></i><input  type="radio" <c:if test="${leftButton.autorotationType == 1  || leftButton.autorotationType == null}">checked="checked"</c:if> class="ml10 mr5 hide_com" value="1" name="autorotationType"/>需要自动旋转</label>
	            </li>
				</div> --%>
				<input type="hidden" value="1" name="autorotationType"/>
				<div>
				<li class="clear list_li_com pb38">
	                <span class="fl span_com">手机陀螺仪:</span>
	                <label class="radio_label_click w_200"><i class="radio_<c:if test="${leftButton.sjtlyType == 0 || leftButton.sjtlyType == null}">yes</c:if><c:if test="${leftButton.sjtlyType == 1}">no</c:if> mr5"></i><input type="radio" name="sjtlyType" <c:if test="${leftButton.sjtlyType == 0 || leftButton.sjtlyType == null}">checked="checked"</c:if> value="0" class="mr5 hide_com"/>不需要手机陀螺仪</label>
	                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${leftButton.sjtlyType == 1}">yes</c:if><c:if test="${leftButton.sjtlyType != 1}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com" <c:if test="${leftButton.sjtlyType == 1}">checked="checked"</c:if> value="1" name="sjtlyType"/>需要手机陀螺仪</label>
	            </li>
				</div>
				<div>
				<li class="clear list_li_com pb38">
	                <span class="fl span_com">VR看房:</span>
	                <label class="radio_label_click w_200"><i class="radio_<c:if test="${leftButton.vrShowingsType == 0 || leftButton.vrShowingsType == null}">yes</c:if><c:if test="${leftButton.vrShowingsType == 1}">no</c:if> mr5"></i><input type="radio" name="vrShowingsType" <c:if test="${leftButton.vrShowingsType == 0 || leftButton.vrShowingsType == null}">checked="checked"</c:if> value="0" class="mr5 hide_com"/>不需要VR看房</label>
	                <label class="ml20 radio_label_click"><i class="radio_<c:if test="${leftButton.vrShowingsType == 1}">yes</c:if><c:if test="${leftButton.vrShowingsType != 1}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com" <c:if test="${leftButton.vrShowingsType == 1}">checked="checked"</c:if> value="1" name="vrShowingsType"/>需要VR看房</label>
	            </li>
				</div>
			</c:if>
				
		<%-- 		<!-- 点赞部分 -->
				<%-- <li class="clear m30 list_li_com">
					<span class="fl span_com">点赞:</span>
					<label class="radio_label_click clickhide w_200"><i class="radio_<c:if test="${rightObject.likeType == 0 || rightObject.likeType == null}">yes</c:if><c:if test="${rightObject.likeType == 1}">no</c:if> mr5"></i><input type="radio" name="likeType" <c:if test="${rightObject.likeType == 0 || rightObject.likeType == null}">checked="checked"</c:if> value="0" class="mr5 hide_com"/>不需要点赞</label>
					<label class="ml20 radio_label_click clickshow"><i class="radio_<c:if test="${rightObject.likeType == 1}">yes</c:if><c:if test="${rightObject.likeType != 1}">no</c:if> mr5"></i><input type="radio" class="ml10 mr5 hide_com" <c:if test="${rightObject.likeType == 1}">checked="checked"</c:if> value="1" name="likeType"/>需要点赞</label>
				</li> --%>
				
			 <!-- <li class="clear mb20 list_li_com clickhidediv" style="margin:0;background: none;border:none"> -->
				<li class="clear mb20 list_li_com clickhidediv" style="margin:0;background: none;border:none">
		            <span class="fl span_com">点赞基数:</span>
		                <input type="text" name="falseLikeNum" value="${object.falseLikeNum}" placeholder="请输入点赞基数"  class="btn_tx_com_connter fl" data-reg="emptyssizeten" maxlength="12"/>
		                <span class="warn_tx_com hide_com"></span>
		        </li> 
			</div>
		</div>
		
		
		
		<%-- <div class="list3divlisht br_dash_b">
		<li class="connter_module_title clear">电话</li>
		
		<li class="clear mb20 list_li_com">
			<span class="fl span_com">入口标题:</span>
			 <span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span>
			<input type="text" name="dhEntryTitle" value="${rightObject.dhEntryTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>	
			<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
		</li>
			
		<li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">入口图标:</span>
			<div class="fl div_up_img_nonebg w_540">
				<img src="<c:if test="${empty rightObject.dhEntryIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/14.png </c:if><c:if test="${not empty rightObject.dhEntryIcon}">${fns:getCosAccessHost()}${rightObject.dhEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="dhrukoutu" class="hide_com inputImageUpload rukou_icon"/>
					</label>
					<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/14.png" data-vals="/material/sys/linker/default/14.png" value="还原默认图标"/>
					<input type="hidden" name="dhEntryIcon" id="dhEntryIcon" value="<c:if test="${empty rightObject.dhEntryIcon}">/material/sys/linker/default/14.png </c:if><c:if test="${not empty rightObject.dhEntryIcon}">${rightObject.dhEntryIcon}</c:if>">
					<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
				</div>
			</div>
		</li>

		 <li class="clear list_li_com pb38 ">
			<span class="fl span_com">电话:</span>
			<input type="text" name="telephone" value="${rightObject.telephone}" class="btn_tx_com_connter fl" />
		</li>
			</div> --%>
			<%-- <div class="list3divlisht br_dash_b">
		<li class="connter_module_title clear">更多精彩 </li>

		<li class="clear mb20 list_li_com">
			<span class="fl span_com">入口标题:</span>
			<span class="fr quesi_span"><i class="quesi_con"></i>示例<img src="${backStatic}/images/shouye.png" /></span>
			<input type="text" name="gdjcEntryTitle" value="${rightObject.gdjcEntryTitle}" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题"/>
			<span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>
		</li>
		
		 <li class="clear mb20 list_li_com divImageUpload">
			<span class="fl span_com">入口图标:</span>
			<div class="fl div_up_img_nonebg w_540">
				<img src="<c:if test="${empty rightObject.gdjcEntryIcon}">${fns:getCosAccessHost()}/material/sys/linker/default/icon_more.png </c:if><c:if test="${not empty rightObject.gdjcEntryIcon}">${fns:getCosAccessHost()}${rightObject.gdjcEntryIcon}</c:if>" class="load_img_com mr10 fl" width="100"/>
				<div class="fl mt20">
					<label class="label_load_img">
						上传图片<input type="file" name="file" id="gdjcrukoutu" class="hide_com inputImageUpload rukou_icon"/>
					</label>
					<input type="button" class="lianjieqiicon" data-val="${fns:getCosAccessHost()}/material/sys/linker/default/icon_more.png" data-vals="/material/sys/linker/default/icon_more.png" value="还原默认图标"/>
					<input type="hidden" name="gdjcEntryIcon" id="gdjcEntryIcon" value="<c:if test="${empty rightObject.gdjcEntryIcon}">/material/sys/linker/default/icon_more.png </c:if><c:if test="${not empty rightObject.gdjcEntryIcon}">${rightObject.gdjcEntryIcon}</c:if>">
					<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>
				</div>
			</div>
		</li>
		
         <li class="clear list_li_com pb38">
			<span class="fl span_com">链接:</span>
			<input type="text" name="gdjcUrl" value="${rightObject.gdjcUrl}" class="btn_tx_com_connter fl link_reg_input"/>
		</li>
		</div> --%>
		
		

		<li class="clear pb38 pt28 list_li_com">
			<span class="span_com">&nbsp;</span>
			<input type="button" onclick="backhref();" value="上一步" class="btn_tx_com_connter_sub btn_tx_com_connter_ccc mr20"/>
			<input type="button" onclick="submitForm('preview');" id="ajaxSubmit1" value="预览" class="btn_tx_com_connter_sub btn_tx_com_connter_yulan mr20"/>
			<input type="button" onclick="submitForm('save');" id="ajaxSubmit" value="保存并下一步" class="btn_tx_com_connter_sub btn_tx_com_connter_bule"/>
		</li>
		<input type="hidden" id="formSubmitType" value="save">
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
<input type="hidden" id="la" value="22.52346"/>
<input type="hidden" id="lo" value="113.9393"/>
<c:if test="${rightObject.fyType == 0}">
<input type="hidden" id="traffic" value="${newInfo.traffic}"/>
<input type="hidden" id="business" value="${newInfo.business}"/>
<input type="hidden" id="hospital" value="${newInfo.hospital}"/>
</c:if>
<c:if test="${rightObject.fyType == 1}">
<input type="hidden" id="traffic" value="${oldInfo.traffic}"/>
<input type="hidden" id="business" value="${oldInfo.business}"/>
<input type="hidden" id="hospital" value="${oldInfo.hospital}"/>
</c:if>
<!-- <video id="video" controls="controls" autoplay="autoplay" muted="true">
</video> -->
<script>
var backstaticurl="${backStatic}"
$(function(){
	init(1);
	init1(1);
	init_qita(2);
});

/* 编辑状态显示搜索结果 */
	(function(){
		
		var type = '${rightObject.fyType}';
		if(type == 1){
			var traffic = $("#traffic").val();
			var business = $("#business").val();
			var hospital = $("#hospital").val();
			if(traffic){  
				$(".search_result_div11").css("display","block");
			}
			if(business){
				$(".search_result_div31").css("display","block");
			}
			if(hospital){
				$(".search_result_div21").css("display","block");
			}
		}else if(type == 0){
			var traffic = $("#traffic").val();
			var business = $("#business").val();
			var hospital = $("#hospital").val();
			if(traffic){
				$(".search_result_div1").css("display","block");
			}
			if(business){
				$(".search_result_div3").css("display","block");
			}
			if(hospital){
				$(".search_result_div2").css("display","block");
			}
		}
	})();
	
	
</script>

<script src="${backStatic}/js/list3_1.js"></script>
<script src="${backStatic}/js/ajaxfileupload.js"></script>

<script>
var map;
var circle;
var center;
var searchService;
var search_arr=['公交','商场','医院'];
var latlngBounds = new qq.maps.LatLngBounds();
var geocoder;
searchService = new qq.maps.SearchService({
	complete : function(results){
		var str1="公交车:";
		if(results){
			var pois = results.detail.pois;
			var poi = pois[0];
			latlngBounds.extend(poi.latLng); 
			switch(true){
				case poi.category.indexOf('公交')>=0:
					var maxLength=pois[0].postcode;
					for(var i = 1,l = pois.length;i < l; i++){
						if(maxLength.length<pois[i].postcode.length){
							maxLength=pois[i].postcode;
						}
					}
					$(".search_result_div1").css("display","block");
					$(".jiaotong").val(str1+=maxLength);
					break;
				case poi.category.indexOf('医院')>=0:
					$(".search_result_div2").css("display","block");
					var str2="";
					for(var i=0;i<pois.length;i++){
						str2+=pois[i].name+"、";
					}
					$(".yiyuan").val(str2);
					break;
				case poi.category.indexOf('商场')>=0:
					$(".search_result_div3").css("display","block");
					var str3="";
					for(var i=0;i<pois.length;i++){
						str3+=pois[i].name+"、";
					}
					$(".shangye").val(str3);
					break;
			}
		}
	}
});
var _stae = false;
function searchKeyword(search,la,lo) {
	    var keyword = search_arr[search];
	    var region = new qq.maps.LatLng(la,lo);
	    searchService.searchNearBy(keyword, region, 3000);//根据中心点坐标、半径和关键字进行周边检索。
	}
    function init(id) {
    	if(id == 1){
    		center = new qq.maps.LatLng(39.916527, 116.397128);
    		sss();
    	}else{
    		center = new qq.maps.LatLng($("#longitude").val(), $("#latitude").val());
    		map = new qq.maps.Map(document.getElementById("container"), {
                center: center,
                zoom: 17
            });
    		mak = new qq.maps.Marker({
           	    position: center,
           	    map: map
           	});
        	circle = new qq.maps.Circle({
                map: map,
                center: center,
                radius: 3,
                strokeWeight: 3
            });
    	}
        show(); 
    } 
function sss(){
	map = new qq.maps.Map(document.getElementById("container"), {
        center: center,
        zoom: 17
    });
	mak = new qq.maps.Marker({
   	    position: center,
   	    map: map
   	});
	circle = new qq.maps.Circle({
        map: map,
        center: center,
        radius: 3,
        strokeWeight: 3
    });
	show
}
function show(){
	qq.maps.event.addListener(map, "mousedown", function(event) {
         _stae = true;
	});
 	qq.maps.event.addListener(map, "mousemove", function(event) {
 		if(_stae==true){
 			mak.setPosition(new qq.maps.LatLng(event.latLng.getLng(), event.latLng.getLat()));
 		}
     });
 	qq.maps.event.addListener(document, "mouseup", function(event) {
 		 _stae = false;
 		/*init(2);
 		circle.setVisible(true); */
 		/* $("#latitude").val(event.latLng.getLng());
		$("#longitude").val(event.latLng.getLat()); */
    });
}


geocoder = new qq.maps.Geocoder({
	complete : function(result) {
        map.setCenter(result.detail.location);
        var marker = new qq.maps.Marker({
            map : map,
            position : result.detail.location
        });
        addressComponents = result.detail.addressComponents;
        $("#form-rightButton-newhouse").find("input[name='province']").val(addressComponents.province);
        $("#form-rightButton-newhouse").find("input[name='city']").val(addressComponents.city);
        $("#form-rightButton-newhouse").find("input[name='district']").val(addressComponents.district);
        $("#latitude").val(result.detail.location.lat);
        $("#longitude").val(result.detail.location.lng);
        searchKeyword(0,$('#latitude').val(),$('#longitude').val());
        setTimeout(function(){
        	searchKeyword(1,$('#latitude').val(),$('#longitude').val());
        },1000);
        setTimeout(function(){
        	 searchKeyword(2,$('#latitude').val(),$('#longitude').val());
        },1600);
       
    }
});



$(".init_map").click(function(){
	$(".search_result_div1").css("display","none");
	var storeAdd = $("#client_add").val();
    geocoder.getLocation(storeAdd);
    
})




</script>

<script>
/* 二手房部分 */
var map1;
var circle1;
var center1;
var searchService1;
var search_arr1=['公交','商场','医院'];
var latlngBounds1 = new qq.maps.LatLngBounds();
var geocoder4;
searchService1 = new qq.maps.SearchService({
	complete : function(results){
		var str1="公交车:";
		if(results){
			var pois = results.detail.pois;
			var poi = pois[0];
			latlngBounds1.extend(poi.latLng); 
			switch(true){
				case poi.category.indexOf('公交')>=0:
					var maxLength=pois[0].postcode;
					for(var i = 1,l = pois.length;i < l; i++){
						if(maxLength.length<pois[i].postcode.length){
							maxLength=pois[i].postcode;
						}
					}
					$(".search_result_div11").css("display","block");
					$(".jiaotong1").val(str1+=maxLength);
					break;
				case poi.category.indexOf('医院')>=0:
					$(".search_result_div21").css("display","block");
					var str2="";
					for(var i=0;i<pois.length;i++){
						str2+=pois[i].name+"、";
					}
					$(".yiyuan1").val(str2);
					break;
				case poi.category.indexOf('商场')>=0:
					$(".search_result_div31").css("display","block");
					var str3="";
					for(var i=0;i<pois.length;i++){
						str3+=pois[i].name+"、";
					}
					$(".shangye1").val(str3);
					break;
					
					
			}
		}
	}
});

function searchKeyword1(search,la,lo) {
	    var keyword = search_arr[search];
	    var region = new qq.maps.LatLng(la,lo);
	    searchService1.searchNearBy(keyword, region, 3000);//根据中心点坐标、半径和关键字进行周边检索。
	}


    function init1(id) {
    	if(id == 1){
    		center1 = new qq.maps.LatLng(39.916527, 116.397128);
    		sss1();
    	}else{
    		center1 = new qq.maps.LatLng($("#longitude").val(), $("#latitude").val());
    		map1 = new qq.maps.Map(document.getElementById("container1"), {
                center: center1,
                zoom: 17
            });
        	circle1 = new qq.maps.Circle({
                map: map1,
                center: center1,
                radius: 3,
                strokeWeight: 3
            });
    	}
        /*  show(); */
    } 
function sss1(){
	map1 = new qq.maps.Map(document.getElementById("container1"), {
        center: center1,
        zoom: 17
    });
	circle1 = new qq.maps.Circle({
        map: map1,
        center: center1,
        radius: 3,
        strokeWeight: 3
    });
}


geocoder4 = new qq.maps.Geocoder({
	complete : function(result) {
        map1.setCenter(result.detail.location);
        var marker = new qq.maps.Marker({
            map : map1,
            position : result.detail.location
        });
        addressComponents = result.detail.addressComponents;
        $("#form-rightButton-oldhouse").find("input[name='province']").val(addressComponents.province);
        $("#form-rightButton-oldhouse").find("input[name='city']").val(addressComponents.city);
        $("#form-rightButton-oldhouse").find("input[name='district']").val(addressComponents.district);
        $("#latitude1").val(result.detail.location.lat);
        $("#longitude1").val(result.detail.location.lng);
        searchKeyword1(0,$('#latitude1').val(),$('#longitude1').val());
        setTimeout(function(){
        	 searchKeyword1(1,$('#latitude1').val(),$('#longitude1').val());
        },800);
        
        setTimeout(function(){
        	searchKeyword1(2,$('#latitude1').val(),$('#longitude1').val());
       },800);
    }
});
$(".init_map3").click(function(){
	$(".search_result_div11").css("display","none");
	var storeAdd = $("#client_add1").val();
    geocoder4.getLocation(storeAdd);
    
});

$(".init_map3").click();
$(".init_map").click();

</script>





<script type="text/javascript">

/**
 * ajax背景图上传
 */
 	$('.mian_com').on('change', '.inputImageUpload', function(){
 		var div = $(this).parents('.divImageUpload');
 		var input = div.find('[type=hidden]');
 		var lianjieqidelte = div.find(".lianjieqidelte");
 		var allowExtention=".jpg,.jpeg,.png";//允许上传文件的后缀名
 		var mp3reg=".mp3";//允许上传文件的后缀名
 		var mp4reg=".mp4";//允许上传文件的后缀名
 		var extention=$(this).val().substring($(this).val().lastIndexOf(".")+1).toLowerCase();
 		var browserVersion= window.navigator.userAgent.toUpperCase();
 		var _self =$(this)
 		var loadimg = $('<img src=""/>')
 		if(typeof(input[0])  == "undefined"){
 			input = div.find('audio');
 			if(input.length >0){
	 			if(!(mp3reg.indexOf(extention)>-1)){
	 				alert('请上传规定的音频格式')
	 				return false;
	 			}
	 			if($(this)[0].files[0].size <='5120'){
	 				alert('请上传规定大小的音频')
	 				return false;
	 			}
 			}else if(input.length == 0){
 				input = div.find('video');
 				if(!(mp4reg.indexOf(extention)>-1)){
	 				alert('请上传规定的视频格式')
	 				return false;
	 			}
 				if($(this)[0].files[0].size <='30720'){
	 				alert('请上传规定大小的视频')
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
	 				if(_self.is('.details_head_img')){
	 					if(loadimg[0].naturalHeight!="200"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="200"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 				}else if(_self.is('.details_top_img')){
	 					if(loadimg[0].naturalHeight!="420"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="750"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 				}else if(_self.is('.details_bottom_img')){
	 					if(loadimg[0].naturalHeight!="64"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="192"){
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
	 				}else if(_self.is('.rukou_icon_kq')){
	 					if(!(".png".indexOf(extention)>-1)){
	 						alert('请上传规定的图片格式')
	 	 					return false;
	 					}
	 					if(loadimg[0].naturalHeight!="72"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="144"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 				}else if(_self.is('.head_img_url')){
	 					if(loadimg[0].naturalHeight!="510"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="750"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 				}else if(_self.is('.sale_img')){
	 					if(loadimg[0].naturalHeight!="649"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="900"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 				}else if(_self.is('.zhuli_img')){
	 					if(loadimg[0].naturalHeight!="900"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="649"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 				}else{
	 					if(loadimg[0].naturalHeight!="900"){
	 	 					alert('请上传规定的图片尺寸')
	 	 					return false;
	 	 				}
	 	 				if(loadimg[0].naturalWidth!="650"){
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
	 		 						input.siblings('input').val(data.cosFilePath);
	 		 						input.attr("src",data.cosData.access_url);
	 		 						
	 		 						lianjieqidelte.show()
	 		 					}else{
	 		 						input.val(data.cosFilePath);
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
	 		 		})	
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
	 						input.siblings('input').val(data.cosFilePath);
	 						input.attr("src",data.cosData.access_url);
	 						lianjieqidelte.show()
	 					}else{
	 						input.val(data.cosFilePath);
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
	 		console.log(0);
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
	 						input.siblings('input').val(data.cosFilePath);
	 						input.attr("src",data.cosData.access_url);
	 						/* $('#video').attr('src',data.cosData.access_url);
	 						videoImage(); */
	 						lianjieqidelte.show()
	 					}else{
	 						input.val(data.cosFilePath);
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
function videoImage (){
	var video,data;
	var scale = 0.8;
	var initialize = function() {
	    video = document.getElementById("video");
	    video.play();
	    video.muted = true;
	    video.addEventListener('loadeddata', captureImage,false);
	}
	initialize();
	var captureImage = function() {
	    var canvas = document.createElement("canvas");
	    canvas.width = video.videoWidth * scale;
	    canvas.height = video.videoHeight * scale;
	    setTimeout(function () {
	        canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
	        data = canvas.toDataURL("image/png");
	        /* if(video.paused){
	            video.pause();
	        } */
	        console.log(0);
	    },100);
	};
}
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
	oldParams=$("#form-rightButton-add").serialize();
});
function backhref(){
	window.location.href = "${siteRoot}/object/toAlbum?id="+'${id}';
}

function submitForm(formSubmitType){
	$("#formSubmitType").val(formSubmitType);
	$("#form-rightButton-add").submit();
}

$(function(){
	$.validator.addMethod("yqdyTitleRule",function(value,element){
		if(value==null||value==""){
			return true;
		}
		var reg = /x/ig;
		var result = value.match(reg);
		if (result&&result.length==1) {
			return true;
		}
		return false;
	},"代言标题必须只包含一个x");
	
	$("#form-rightButton-add").validate({
		rules: {
			"falseLikeNum":{
				required:true ,
				digits:true,
				max:99999,
				min:0
			},
			"yqdyEntryTitle":{
				required:true
			},
			"yqdyTitle":{
				yqdyTitleRule:true
			}
		},
		messages: {
		},
		submitHandler:function(form){
			if($("#formSubmitType").val()=="save"){
				save();
			}else{
				preview();
			}
			
        }    
	});
	loadGroup();
	loadScene();
	loadProjectTag();
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
 				if(!reg[$(this).data('reg')].test($(this).val())){
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

$('body').on('click','.lianjieqiicon',function(){
	var _this = $(this)
	$(this).parent().siblings('img').attr('src',_this.data('val'))
	$(this).siblings('[type="hidden"]').val(_this.data('vals'))
});
 
//处理掉空表单
function dealForm(){
	var other = $("#form-rightButton-otherhouse");
	var formo = $("#form-rightButton-add");
	var list3_list_mian_type1idex = 0;
	var list3_list_mian_type2idex =0;
	var list3_list_mian_type3idex = 0;
	other.find('.list3_list_mian_type1').each(function(i){
		var title_link_tx_type = $(this).find('.title_link_tx_type')
		var txetinput =$(this).find('input[type="text"]')
		if(txetinput.val().trim()=='' && title_link_tx_type.val().trim()==''){
			$(this).remove()
			list3_list_mian_type1idex++
		}
		if(title_link_tx_type.hasClass('trim_inspect')){
			var text = title_link_tx_type.val();
			title_link_tx_type.val(encodeURI(text));
		} 
		title_link_tx_type.prop('name','textList['+(i-list3_list_mian_type1idex)+']')
		title_link_tx_type.val(title_link_tx_type.val().split('\n').join('<br>'))
		
	})
	other.find('.list3_list_mian_type2').each(function(i){
		var title_link_hidden_type = $(this).find('.title_link_hidden_type')
		var title_link_tx_type = $(this).find('.title_link_tx_type')
		var txetinput =$(this).find('input[type="text"]')
		var divImageUpload = $(this).find('.divImageUpload')
		if(txetinput.val().trim()==''){
			$(this).remove()
			list3_list_mian_type2idex++
		}
		title_link_hidden_type.prop('name','textImageUrlList['+(i-list3_list_mian_type2idex)+']')
		title_link_tx_type.prop('name','imageTextList['+(i-list3_list_mian_type2idex)+']')
		divImageUpload.each(function(){
			var title_link_hidden_types = $(this).find('.title_link_hidden_type')
			var title_link_tx_types = $(this).find('.title_link_tx_type')
			if(title_link_hidden_types.val().trim()=='' && title_link_tx_types.val().trim()==''){
				$(this).remove()
			}
		})
	})
	other.find('.list3_list_mian_type3').each(function(i){
		var title_link_tx_type_tx = $(this).find('.title_link_tx_type_tx')
		var title_link_tx_type = $(this).find('.title_link_tx_type')
		var txetinput =$(this).find('input[type="text"]')
		if(txetinput.val().trim()==''){
			$(this).remove()
			list3_list_mian_type3idex++
		}
		title_link_tx_type.prop('name','textUrlList['+(i-list3_list_mian_type3idex)+']')
		title_link_tx_type_tx.prop('name','textUrlListText['+(i-list3_list_mian_type3idex)+']')
	})
	other.find('.list3_list_mian_type4').each(function(i){
		var videoUrl =$(this).find('input[name="videoUrl"]')
		var txetinput =$(this).find('input[type="text"]')
		if(txetinput.val().trim()=='' && videoUrl.val().trim()==''){
			$(this).remove()
		}
	})
/* 	formo.find('.ziyidinganan').each(function(i){
		var zdyanEntryTitle =$(this).find('input[name="zdyanEntryTitle"]')
		var zdyanEntryIcon =$(this).find('input[name="zdyanEntryIcon"]')
		var zdyanUrl =$(this).find('input[name="zdyanUrl"]')
		if(zdyanEntryTitle.val().trim()=='' && zdyanEntryIcon.val().trim()=='' && zdyanUrl.val().trim()==''){
			$(this).parent().remove()
		}
	}) */
} 
 
 function validData(){
	 var fyType = $("input[name='fyType']:checked").val();
	 var reg1 = /^\d{0,5}\.{0,1}(\d{1,2})?$/; //验证有0-2位小数的正实数：
	 var reg2 = /^\d{0,6}$/;//验证住户数
	 var reg3 = /^\d+$/;//验证产权年限
	 var reg4 = /^\d{0,2}\.{0,1}(\d{1,2})?$/; //验证有0-2位小数的正实数
	 var reg5 = /^[0-9]+(.[0-9]{0,2})?$/; //验证有0-2位小数的正实数：
	 if(fyType == 0){//新房
		 var averagePrice = $("#form-rightButton-newhouse").find("input[name='averagePrice']").val();
		 var buildArea= $("#form-rightButton-newhouse").find("input[name='buildArea']").val();
		 var coverArea= $("input[name='coverArea']").val();
		 var greenRate = $("input[name='greenRate']").val();
		 var plotRate  = $("input[name='plotRate']").val();
		 var propertyYears  = $("input[name='propertyYears']").val();
		 var carNum  = $("input[name='carNum']").val();
		 var managementPrice  =  $("input[name='managementPrice']").val();
		 var householdNum = $("input[name='householdNum']").val();
		 if(!$.trim($("#form-rightButton-newhouse").find("input[name='name']").val())){
				alert("楼盘名字不能为空!");
				$("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				return false;
		 }
		 if(!averagePrice){
			 alert("均价不能为空!");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(!reg5.test(averagePrice) || averagePrice > 1000000){
			 alert("请输正确的均价,不能超过1百万最多带两位小数");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(buildArea){
			 if(!reg5.test(buildArea)  ||  buildArea > 10000000){
				 alert("请输入正确的建筑面积,不能超过1千万最多带两位小数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(coverArea){
			 if(!reg5.test(coverArea)  ||  coverArea > 1000000){
				 alert("请输入于正确的占地面积,不能超过1百万最多带两位小数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(greenRate){
			 if(!reg5.test(greenRate)  ||  greenRate > 100){
				 alert("请输入正确的绿化率,不能超过100最多带两位小数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(plotRate){
			 if(!reg5.test(plotRate)  ||  plotRate > 100){
				 alert("请输入正确的容积率,不能超过100最多带两位小数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(propertyYears){
			 if(!reg3.test(propertyYears) || propertyYears>80){
				 alert("请输入正确的产权年限,不能超过80正整数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(householdNum){
			 if(!reg3.test(householdNum) || householdNum>100000){
				 alert("请输入正确的住户数,不能超过10W正整数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(carNum){
			 if(!reg3.test(carNum) || carNum>20000){
				 alert("请输入正确的停车位,不能超过20000正整数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(managementPrice && !reg1.test(managementPrice)){
			 if(!reg5.test(managementPrice)  ||  managementPrice > 1000000){
				 alert("请输入正确的物业费,不能超过1百万的正整数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 return true;
	 }else if(fyType == 1){
		 var averagePrice = $("#form-rightButton-oldhouse").find("input[name='averagePrice']").val();
		 var buildArea=  $("#form-rightButton-oldhouse").find("input[name='buildArea']").val();
		 var totalMoney= $("input[name='totalMoney']").val();
		 var room = $("input[name='room']").val();
		 var hall  = $("input[name='hall']").val();
		 var totalFloor  = $("input[name='totalFloor']").val();
		 if(!$.trim($("#form-rightButton-oldhouse").find("input[name='name']").val())){
			alert("楼盘名字不能为空!");
			$("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			return false;
		 }
		 if(averagePrice){
			 if(!reg5.test(averagePrice) || averagePrice > 1000000){
				 alert("请输正确的均价,不能超过1百万最多带两位小数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(!buildArea){
			 alert("面积不能为空");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(buildArea){
			 if(!reg5.test(buildArea)  ||  buildArea > 10000000){ 
				 alert("请输入正确的面积,不能超过1千万最多带两位小数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(!totalMoney){
			 alert("总价不能为空!");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(totalMoney){
			 if(!reg5.test(totalMoney)  ||  totalMoney > 100000){
				 alert("请输入正确的总价,不能超过1百万最多带两位小数");
				 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
				 return false;
			 }
		 }
		 if(!room){
			 alert("房型不能为空");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(!reg3.test(room) && room<100){
			 alert("请输入正确的厅,不能超过100正整数");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(room>100){
			 alert("请输入正确的厅,不能超过100正整数");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(!hall){
			 alert("房型不能为空");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(!reg3.test(hall) && hall<100){
			 alert("请输入正确的厅,不能超过100正整数");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(hall>100){
			 alert("请输入正确的厅,不能超过100正整数");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(totalFloor  && !reg3.test(totalFloor )){
			 alert("请输入正确的当前楼层数,不能超过1000正整数");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		 if(totalFloor && totalFloor>1000){
			 alert("请输入正确的当前楼层数,不能超过1000正整数");
			 $("html,body").animate({scrollTop:$("#house_details").offset().top},1000);
			 return false;
		 }
		    return true;
		 }else{
			 return true;
		 }
 }

 $("body").on("focus",".link_reg_input",function(){
	 $(this).css("border","1px solid #d6dee4");
	 $(this).siblings(".warn_tx_com").addClass("hide_com");
 });
 
function save(){
	//textList正文  textImageUrlList正文图片  textUrlList链接
	var formo = $("#form-rightButton-add");
	var baseformo = $("#form-rightButton-base");
	dealForm();
	
	if($('.list3divlisht .wraper5').is(':hidden')&&$('input[name="yqdyEntryTitle"').val()==""){
		$('.wraper5').show();
		alert('请填写必填项!');
		return;
	}
	var ture_link= true;
	$('.link_reg_input').each(function(){
		if($(this).val()!=""){
	 		if(!isURL($(this).val())){
	 			ture_link=false
	 			alert('请填写正确的链接')
	 			$("html,body").animate({scrollTop:$(this).offset().top},300)
	 			$(this).css("border","1px solid red");
	 			$(this).siblings(".warn_tx_com").removeClass("hide_com");
	 			return false
	 		}else{
	 			ture_link=true
	 		}
		}else{
			ture_link=true
		}
	})
 	if(validData() && ture_link){
 		params=formo.serialize();
 		var yyInfoStr = getYyData();
 		var buttons = getButtonData();
 		var d=params+"&"+ baseformo.serialize() +"&formchanged="+(params!=oldParams)+"&yyInfoStr="+yyInfoStr+"&buttons="+buttons;
 		var fyType = $("input[name='fyType']:checked").val();
 		if(fyType ==0){
 			var newhouseformo = $("#form-rightButton-newhouse");
 			var fyAttachInfoStr = getAttachData(0);
 			var turnoverTrendsStr = getTrendData(0);
 			d += "&" + newhouseformo.serialize()+"&fyAttachInfoStr=" + fyAttachInfoStr + "&turnoverTrendsStr=" + turnoverTrendsStr;
 		}else if(fyType == 1){
 			var oldhouseformo = $("#form-rightButton-oldhouse");
 			var turnoverTrendsStr = getTrendData(1);
 			//var fyAttachInfoStr = getAttachData(1);
 			d += "&" + oldhouseformo.serialize()+"&turnoverTrendsStr=" + turnoverTrendsStr;
 		}else if(fyType == 2){
 			var otherhouse = $("#form-rightButton-otherhouse");
 			d += "&" + otherhouse.serialize();
 		}
	 	$("#ajaxSubmit").attr("disabled","disabled");
		 $.ajax({
	        type: "POST",
	        url: "./addButton.sys",
	        data: d,
	        success: function (res) {
	        	if(res.code=="0000"){
	        		$("#ajaxSubmit").removeAttr("disabled");
		         	var accountId = $("#accountId").val();
		         	var token = $("#token").val();
		        	window.location.href="./toaddFenXiang.sys?id="+res.id+"&albumId=" + '${albumId}';
	        	}else{
	        		alert(res.message);
	        	}
				
	        },
	        error: function(data) {
				$("#ajaxSubmit").removeAttr("disabled");
	         }
	    }); 
 	}
}
 
function preview(){
	//textList正文  textImageUrlList正文图片  textUrlList链接
	var formo = $("#form-rightButton-add");
	var baseformo = $("#form-rightButton-base");
	dealForm();
	var ture_link= true;
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
	})
 	if(ture_link){
 		params=formo.serialize();
 		var yyInfoStr = getYyData();
 		var buttons = getButtonData();
 		var d=params+"&"+ baseformo.serialize() +"&formchanged="+(params!=oldParams)+"&yyInfoStr="+yyInfoStr+"&buttons="+buttons;
 		var fyType = $("input[name='fyType']:checked").val();
 		if(fyType ==0){
 			var newhouseformo = $("#form-rightButton-newhouse");
 			var fyAttachInfoStr = getAttachData(0);
 			var turnoverTrendsStr = getTrendData(0);
 			d += "&" + newhouseformo.serialize()+"&fyAttachInfoStr=" + fyAttachInfoStr + "&turnoverTrendsStr=" + turnoverTrendsStr;
 		}else if(fyType == 1){
 			var oldhouseformo = $("#form-rightButton-oldhouse");
 			//var fyAttachInfoStr = getAttachData(1);
 			var turnoverTrendsStr = getTrendData(1);
 			d += "&" + oldhouseformo.serialize()+"&turnoverTrendsStr=" + turnoverTrendsStr;
 		}else if(fyType == 2){
 			var otherhouse = $("#form-rightButton-otherhouse");
 			d += "&" + otherhouse.serialize();
 		}
 		$("#ajaxSubmit1").attr("disabled","disabled");
		$.ajax({
	        type: "POST",
	        url: "./addButton.sys",
	        data: d,
	        success: function (res) {
	        	$('.list3_list_mian_type1').each(function(i){
	        		$(this).find('.title_link_tx_type').val($(this).find('.title_link_tx_type').val().split('<br>').join('\n'))
	        	})
				$("#ajaxSubmit1").removeAttr("disabled");
	        	$("#id").val(res.youceId);
				$('#forwardiframe').attr('src',"../linker/"+res.id)
	        	$('#delforwardiframemian').show();
	        },
	        error: function(data) {
				$("#ajaxSubmit1").removeAttr("disabled");
	         }
	    });
 	}
} 
/**
 * 创建语音对象
 */
function dataYyInfo(yyUrl,yySyGroupId,yySyScene){
	this.yyUrl = yyUrl;
	this.yySyGroupId = yySyGroupId;
	this.yySyScene = yySyScene;
}
/**
 * 创建FyAttachInfo对象
 */
function dataAttachInfo(imgUrl,householdDesc,area){
	this.imgUrl = imgUrl;
	this.householdDesc = householdDesc;
	this.area = area;
}
/**
 * 创建TurnoverTrend对象
 */
function dataTrend(ttime,taveragePrice){
	this.taveragePrice = taveragePrice;
	this.ttime = ttime;
}
/**
 * 创建customButton对象
 */
function dataButton(zdyanentryTitle,zdyanentryIcon,zdyanurl,zdyantype){
	this.zdyanentryTitle = zdyanentryTitle;
	this.zdyanentryIcon = zdyanentryIcon;
	this.zdyanurl = zdyanurl;
	this.zdyantype = zdyantype;
}
//获取customButton的数据
function getButtonData(){
	var jsonstr = new Array();
	$("body").find(".zdyDiv").each(function(){
		var zdyanentryTitle = $(this).find(".zdyanEntryTitle").val();
		var zdyanentryIcon = $(this).find(".zdyanEntryIcon").val();
		var zdyanurl = $(this).find(".zdyanUrl").val();
		var zdyantype = $(this).find("input[type='radio']:checked").val();
		var object1 = new dataButton(zdyanentryTitle,zdyanentryIcon,escape(zdyanurl),zdyantype);
		var json = JSON.stringify(object1);	
		jsonstr.push(json);
	});
	jsonstr ="["  + jsonstr.join(",") +"]";
	return jsonstr;
}
//获取主力户型的数据
function getAttachData(type){
	var str = "zhuli";
	if(type == 1){
		str = "zhuli1";
	}
	var jsonstr = new Array();
	$("."+str).each(function(){
		var imgUrl = $(this).find(".imgUrl").val();
		var householdDesc = $(this).find(".householdDesc").val();
		var area = $(this).find(".area").val();
		var object1 = new dataAttachInfo(imgUrl,householdDesc,area);
		var json = JSON.stringify(object1);	
		jsonstr.push(json);
	});
	jsonstr ="["  + jsonstr.join(",") +"]";
	return jsonstr;
}



//获取成交走势数据
function getTrendData(type){
	var jsonstr = new Array();
	var str = "newtrend";
	if(type == 1){
		str = "oldtrend";
	}
	$("."+str).each(function(){
		var ttime = $(this).find(".ttime").val();
		var taveragePrice = $(this).find(".taveragePrice").val();
		var object1 = new dataTrend(ttime,taveragePrice);
		var json = JSON.stringify(object1);
		jsonstr.push(json);
	});
	jsonstr ="["  + jsonstr.join(",") +"]";
	return jsonstr;
}
//获取语音数据
function getYyData(){
	var jsonstr = new Array();
	$(".yuyinDiv").each(function(){
		var yyUrl = $(this).find(".yyUrl").val();
		var yySyGroupId = $(this).find(".yySyGroupId").val();
		var yySyScene = $(this).find(".yySyScene").val();
		var object1 = new dataYyInfo(yyUrl,yySyGroupId,yySyScene);
		var json = JSON.stringify(object1);
		jsonstr.push(json);
	});
	jsonstr ="["  + jsonstr.join(",") +"]";
	return jsonstr;
}
//设置复选框是否选中
function loadProjectTag(){
	var tag,str,houseUse;
	if("${rightObject.fyType}" == "0"){
		tag = '${newInfo.projectTag}';
		houseUse = '${newInfo.houseUse}';
		str = "form-rightButton-newhouse";
	}else if("${rightObject.fyType}" == "1"){
		tag = '${oldInfo.projectTag}';
		str = "form-rightButton-oldhouse";
	}
	if(tag){
		var array = tag.split(",");
		$.each(array, function(i, n){
			var obj = document.querySelector("#"+str).querySelector("input[name='projectTag'][value='" +n + "']");
			$(obj).siblings("i").removeClass("radio_no").addClass("radio_yes");
			$(obj).attr("checked","checked");
		});
	}
	if(houseUse){
		var array = houseUse.split(",");
		$.each(array, function(i, n){
			var obj = document.querySelector("#"+str).querySelector("input[name='houseUse'][value='" +n + "']");
			$(obj).siblings("i").removeClass("radio_no").addClass("radio_yes");
			$(obj).attr("checked","checked");
		});
	}
}

//新房确定多选标签点击序号
$(".check_box_click").click(function(event){
	event.preventDefault();
	var type = $('input[name="fyType"]:checked').val();
	var str;
	if(type == 0){
		str = "form-rightButton-newhouse";
	}else if(type == 1){
		str = "form-rightButton-oldhouse";
	}
	console.info("OK");
	if($(this).find("i").hasClass("radio_no")){
		if($(this).find("input").attr("name") == "houseUse"){
			var length = $("input[name='houseUse']:checked").length;
			if(length >= 3){
				alert("物业类型最多选三个");
				return;
			}
		}
		if($(this).find("input").attr("name") == "projectTag"){
			if(type == 1){
				if($(this).find("input").val() == 0 ){
					var obj = document.querySelector("#"+str).querySelector("input[name='projectTag'][value='1']");
					if($(obj).siblings("i").hasClass("radio_yes")){
						$(obj).siblings("i").removeClass("radio_yes").addClass("radio_no");
						$(obj).removeAttr("checked");
					}
				}
				if($(this).find("input").val() == 1 ){
					var obj = document.querySelector("#"+str).querySelector("input[name='projectTag'][value='0']");
					if($(obj).siblings("i").hasClass("radio_yes")){
						$(obj).siblings("i").removeClass("radio_yes").addClass("radio_no");
						$(obj).removeAttr("checked");
					}
				}
			}
			var length = $("#"+str).find("input[name='projectTag']:checked").length;
			if(length > 4){
				alert("项目标签最多选五个");
				return;
			}
		}
		$(this).find("i").removeClass("radio_no").addClass("radio_yes");
		$(this).find("input").attr("checked","checked");
	}else if($(this).find("i").hasClass("radio_yes")){
		$(this).find("i").removeClass("radio_yes").addClass("radio_no");
		$(this).find("input").removeAttr("checked");
	}
	
});
//二手房
$(".ershoufang_click").click(function(event){
	event.preventDefault();
	if($(this).find("i").hasClass("radio_no")){
		$(this).find("i").removeClass("radio_no").addClass("radio_yes");
		$(this).find("input").attr("checked","checked");
	}else if($(this).find("i").hasClass("radio_yes")){
		$(this).find("i").removeClass("radio_yes").addClass("radio_no");
		$(this).find("input").removeAttr("checked");
	}
}); 

function loadGroup(){
	    var obj2 = $(".yySyGroupId");
		var myDate = new Date();
		var id= '${albumId}';
		$.post("../admin/pano/album/querySceneGroupByAid?sessionid="+myDate.getTime(),{id:id},function(data){
			  var subData=data.data;
			  for(var i=0;i<subData.length;i++){
				  var cellVaues = subData[i];
				  obj2.append('<option value="'+cellVaues["id"]+'">'+cellVaues["name"]+'</option>');
				}
			  $(".yySyGroupId").each(function(){
				  var value =  $(this).attr("data-val");
				  if(value){
					  $(this).val(value); 
					  loadScene(this,value);
				  }
			  })
		});
}
$('body').on('change','.yySyGroupId',function(){
	var id = $(this).val();
	loadScene(this,id);
});
function loadScene(obj,id){
	  var obj2 = $(obj).next(".yySyScene");
	 if(!id){
		 id = $("#yySyGroupId").val();
	 }
	 obj2.html("");
	 if(id == 0){
		 obj2.append('<option value="0">全部</option>');
	 }

	  var myDate = new Date();
	  $.post("../admin/pano/album/querySceneBySid?sessionid="+myDate.getTime(),{id:id},function(data){
		  var subData=data.data;
		  for(var i=0;i<subData.length;i++){
			  var cellVaues = subData[i];
			  if($(obj2).attr("data-val")){
				  if($(obj2).attr("data-val") == cellVaues["id"]){
					  obj2.append('<option value="'+cellVaues["id"]+'" selected>'+cellVaues["name"]+'</option>');
				  }else{
					  obj2.append('<option value="'+cellVaues["id"]+'">'+cellVaues["name"]+'</option>');
				  }
			  }else{
				  obj2.append('<option value="'+cellVaues["id"]+'">'+cellVaues["name"]+'</option>');
			  }
			}
	 });
}
</script>
<!-- 以下是其他按钮的腾讯地图 -->
<script>
var map_qita;
var circle_qita;
var center_qita;
    function init_qita(id) {
    	if(id == 1){
    		center_qita = new qq.maps.LatLng(22.52346, 113.9393);
    		sss_qita();
    	}else{
    		center_qita = new qq.maps.LatLng($("#longitude_qita").val(), $("#latitude_qita").val());
    		map_qita = new qq.maps.Map(document.getElementById("container_qita"), {
                center: center_qita,
                zoom: 17
            });
    		circle_qita = new qq.maps.Circle({
                map: map_qita,
                center: center_qita,
                radius: 3,
                strokeWeight: 3
            });
    	}
         show_qita();
    } 
</script>
<script type="text/javascript">
function sss_qita(){
	map_qita = new qq.maps.Map(document.getElementById("container_qita"), {
        center: center_qita,
        zoom: 17
    });
	circle_qita = new qq.maps.Circle({
        map: map_qita,
        center: center_qita,
        radius: 3,
        strokeWeight: 3
    });
}
</script>
 <script>
function show_qita(){
 qq.maps.event.addListener(map_qita, "click", function(event) {
	 console.info("JJJJ");
	 $("#latitude_qita").val(event.latLng.getLng());
	 $("#longitude_qita").val(event.latLng.getLat());
	 circle_qita.setVisible(true);
	 init_qita(2);
     });
}
</script>


<script>
var titleTypeForDitu = $("#titleTypeForDitu").val();
if(titleTypeForDitu == 5){
	init_qita(1);
} 
</script>
</body>
</html>