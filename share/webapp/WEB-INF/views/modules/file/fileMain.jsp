<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>素材管理</title>
    <meta name="decorator" content="admin"/>
	<style type="text/css">
    	html,body{height:100%}
    </style>    
    <script type="text/javascript">
    var small_right_info_cunt=0,small_right_this;
    var chooseSceneIdList=[];
    var curSceneGroupId;
    var oldSceneGroupName;
    var _saveSceneGroup=false;
    var albumId='${album.id}';
    var cosAccessHost ="${fns:getCosAccessHost()}";
    var jqXHR =null;
    var secenefiledata
    var fileimgarr =[]
		var ajaxfileimgarr =[]
	    var xhrOnProgress=function(fun) {
	  	  xhrOnProgress.onprogress = fun; //绑定监听
	  	  //使用闭包实现监听绑
	  	  return function() {
	  	    //通过$.ajaxSettings.xhr();获得XMLHttpRequest对象
	  	    var xhr = $.ajaxSettings.xhr();
	  	    //判断监听函数是否为函数
	  	    if (typeof xhrOnProgress.onprogress !== 'function')
	  	      return xhr;
	  	    //如果有监听函数并且xhr对象支持绑定时就把监听函数绑定上去
	  	    if (xhrOnProgress.onprogress && xhr.upload) {
	  	      xhr.upload.onprogress = xhrOnProgress.onprogress;
	  	    }
	  	    return xhr;
	  	  }
	  	}
		var successfilelist=0;
		var fileimgaugment ={
		    quality: 0.85,
		    before:function(){
		    	console.log(fileimgarr)
		    	$("#ajaxload").show();
		    	
		    },
		    success: function (result) {
		    	var imgname = ''
		    	$("#ajaxload").hide();
		    	$("#alertboxbg").show();
			    $("#alretboxmian").show();
			    	imgname+= '<li class="clear alert_list"><i class="whole_img_icon fl"></i><p class="tx_over fl" style="width:180px;">'+fileimgarr[0].name
			    	+'</p><i class="fl ml10" style="color:#859dad">等'+fileimgarr.length+'个文件</i></li>'
			    $("#alretboxmian .grouplistname").html(imgname)
		    }
		}
		var sceneGroupIds
		var sortscennum
		var loadtimes,loadtoal=70;
    </script>
    <script src="${ctxStatic}/modules/720/js/filebase64-big.js" type="text/javascript"></script>
    <script src="${ctxStatic}/modules/720/js/file_library.js" type="text/javascript"></script>
</head>
<body>
<div class="mian_com">
    <div class="camear_head mb20 clear">
		<span class="active fl"><img src="${backStatic}/images/list2_nav11.png" class="camer_list0_img">分组</span>
        <p id="tab_nav_xie" class="tab_nav_xie fl"></p>
        <i class="btn_com blue_btn_com fr btn_imageupload_hover" id="btn_imageuploads">+上传照片</i>
    </div>
    <div class="tabmian">
        <!--分组-->
        <ul class="small_whole clear hide_com whole">
            <!--固定-->
            <li>
                <i class="small_btn">+</i>
            </li>
            <c:forEach var="group" items="${album.sceneGroupList}">
	            <li data-id="${group.id}" data-type="sceneGroup" data-sort="${group.sort}">
	                <img src="<c:if test="${not empty group.coverImgUrl}">${fns:getCosAccessHost()}${group.coverImgUrl}</c:if><c:if test="${empty group.coverImgUrl}">${backStatic}/images/b.png</c:if>" class="fl"/>
	                <p class="fl tx_over" title="${group.name}(${group.sceneList.size()})">
	                    <i class="whole_img_file"></i><i class="edit_tx" data-id="${group.id}">${group.name}</i>(${group.sceneList.size()})
	                </p>
	                <i class="list2_icon_cur"></i>
	            </li>
            </c:forEach>
        </ul>
        <!--分组详细-->
        <div class="small_whole_info clear  whole">
        	<c:forEach var="group" items="${album.sceneGroupList}">
	            <ul class="hide_com">
	            	<c:forEach var="item" items="${group.sceneList}">
		                <li data-id="${item.id}" data-type="scene" data-sort="${item.sort}">
		                    <img src="${fns:getCosAccessHost()}${item.thumbnailUrl}" data-imgurl="${fns:getCosAccessHost()}${item.imgUrl}" class="fl"/>
		                    <p class="fl tx_over" title="${item.name}">
		                        <i class="whole_img_icon"></i><i class="edit_tx">${item.name}</i>
		                    </p>
		                    <i class="list2_icon_cur"></i>
		                    <i class="list2_icon_hover"></i>
		                </li>
	                </c:forEach>
	            </ul>
            </c:forEach>
        </div>

    </div>
</div>
<!--分组右键菜单-->
<div class="hide_com small_right_click_nav right_moudown_nav">
    <li class="small_right_nav_contentd">重命名</li>
    <li class="right_nav_del">删除</li>
</div>
<!--删除图片-->
<div  class="right_del_mian hide_com">
    <div>
        <p class="alert_title">删除图片</p>
        <div class="alert_deleta_mian">
            <img src="${backStatic}/images/warnicon.png" class="warunicon">确定要删除这张图片吗?
        </div>
    </div>
</div>
<!--分组详细右键菜单-->
<div class="hide_com small_right_info_click_nav right_moudown_nav">
    <li class="small_right_nav_contentd">重命名</li>
    <li class="alert_small_right_info_edit">更改分组</li>
    <li class="forwardShiftScene">向前移一位</li>
    <li class="backwardShiftScene">向后移一位</li>
    <li class="right_nav_del">删除</li>
</div>
<!--分组详细 更改分组-->
<div class="small_right_info_com hide_com">
    <form>
        <p class="alert_title">更改分组</p>
        <li class="clear mb10 alert_list">
			<p class="alert_tx">选择分组:</p>
			<select class="alert_select sceneGroup">
				<c:choose>
					<c:when test="${not empty album.sceneGroupList}">
						<c:forEach var="group" items="${album.sceneGroupList}" >
							<option value="${group.id}" data-scenenum="${group.sceneList.size()}" >${group.name}</option>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<option value="">未分组</option>
					</c:otherwise>
				</c:choose>
			</select>
        </li>
    </form>
</div>
<!--上传照片-->
<img id="originalImage" src="" style="display: none;">
<input type="file" class="hide_com fileupload" multiple="multiple" id="sencenfileupload"/>

<div class="uploadimg_com hide_com" style="position: absolute;top:0px">
    <form>
        <p class="alert_title">上传照片</p>
        <ul class="grouplistname">
	        <li class="clear mb10 mt10 alert_list">
	            <p style="line-height: 5px;"></p> 
	        </li>
        </ul>
        <ul>
	        <li class="clear mb10 alert_list">
				<p class="alert_tx">选择分组:</p>
				<select class="alert_select sceneGroup"  name="sceneGroup.id">
					<c:choose>
						<c:when test="${not empty album.sceneGroupList}">
							<c:forEach var="group" items="${album.sceneGroupList}" >
								<option value="${group.id}" data-scenenum="${group.sceneList.size()}" >${group.name}</option>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<option value="">未分组</option>
						</c:otherwise>
					</c:choose>
				</select>
	        </li>
	         <li class="clear mb10 alert_list uploadimg_com_waring_tx hide_com" style="color:#f00">
	         xxx
	         </li>
         </ul>
    </form>
</div>

<div class="uploadstar_mian hide_com">
     <p class="alert_title clear">上传照片(<i class="alert_title_upinggrup">1/6</i>)<i class="fr uploadstar_close">x</i></i><i id="uploadstar_smalls" class="uploadstar_small fr"></i></p>
     <div class="uploadlist_mian">
     	<p class="color_859dad uploadingstar_group">上传到:<span class="ml20">m2</span></p>
     	<div class="uploadstar_list">
     		<!-- <li class="color_859dad clear">
				<span><i class="uploadstaricon"></i></span>
				<span class="tx_over uploadstar_list_name">sadsd</span>
				<span class="uploadstar_list_tx"><i>排队中</i></span>
				<span class="tx_over uploadstar_list_m"> </span>
				<span class="uploadstar_list_size">75M</span>
				<span class="uploadstar_list_up"><i class="londing"></i></span>
				<span><i class="londingclose"></i></span>
				<p class="loadbg"></p>
     		</li>   -->
     	</div>
     </div>
</div>
<div id="sihaiload" style="background: rgb(0, 0, 0); opacity: 0.5; top: 0px; left: 0px; position: fixed; z-index: 996; height: 100%; width: 100%; display: none;"></div>
<div id="ajaxload" class="ajaxload">
    <div class="ajaxbg"></div>
    <img src="${backStatic}/images/ajax-loader.gif"  class="ajaxloadimg"/>
</div>
</body>
</html>