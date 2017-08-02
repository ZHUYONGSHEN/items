<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>相册管理</title>
    <meta name="decorator" content="admin"/>
    <style type="text/css">
    	.alert_deleta_mian{
    		padding-bottom:57px;
    	}
    	.fenzu{
    		display:inline-block;
    		color:#000;
    	}
    </style>
    <script src="${ctxStatic}/modules/720/js/filebase64-big.js" type="text/javascript"></script>
    <script type="text/javascript">
    	var close_flag=false;
    	var linkerId='${linkerId}';
   		var albumId='${album.id}';
   		var cosAccessHost ="${fns:getCosAccessHost()}";
   		var leftKeyCurSceneGroudId = null;
   		var sceneTitleDefault = '${backStatic}/images/sceneListTitle.jpg';
   		var sceneTitleYse = '${backStatic}/images/sceneListTitleYse.png';
   		var jqXHR =null;
   		var secenefiledata;
   		var fileimgarr =[];
   		var ajaxfileimgarr =[];
   		var loadtimes,loadtoal=70;
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
   	  	  };
   	  	};
   		var successfilelist=0;
   		var fileimgaugment ={
    		    quality: 0.85,
    		    before:function(){
    		    	$("#ajaxload").show();
    		    	
    		    },
    		    success: function (result) {
    		    	var imgname = ''
    		    	$("#ajaxload").hide();
    		    	$("#alertboxbg").show();
    			    $("#alretboxmian").show();
    			    	imgname+= '<li class="clear alert_list"><i class="whole_img_icon fl"></i><p class="tx_over fl" style="width:180px;">'+fileimgarr[0].name
    			    	+'</p><i class="fl ml10" style="color:#859dad">等'+fileimgarr.length+'个文件</i></li>';
    			    $("#alretboxmian .grouplistname").html(imgname)
    		    }
    		}
   		var sceneGroupIds
    	var sortscennum
    	$(function(){
    		$('.fileupload').localResizeIMG(fileimgaugment);
    		/* $("body").on("click",'.fileupload', function() {
    			$(this).fileupload({
        			url : "${backPath}/pano/scene/fileupload",
        			dataType : 'json',
        			autoUpload: false,
        			add : function(e, data) {
        				jqXHR=data;
        				console.log(data.originalFiles[0].name)
          		      	var allowExtention=".jpg,.jpeg,.bmp,.gif,.png";//允许上传文件的后缀名
        				var extention=data.fileInput.context.value.substring(data.fileInput.context.value.lastIndexOf(".")+1).toLowerCase();
        				if(!(allowExtention.indexOf(extention)>-1)){
        					alert('上传正确的图片');
        					jqXHR= null;
        					$("#alertboxbg").remove();
              		        $("#alretboxmian").remove();
        					return false;
        				}
        				$("#alertboxbg").show();
          		        $("#alretboxmian").show();
          		        $("#alretboxmian #fileupload_img_name").text(data.originalFiles[0].name)
        				var loadimg= $('#alretboxmian .load_img_com');
        				if (navigator.userAgent.indexOf("MSIE")>=1) { // IE
							loadimg.attr('src',data.fileInput.context.value);
							$("#originalImage").attr("src",data.fileInput.context.value);
						} else {
							loadimg.attr( 'src',window.URL.createObjectURL(data.files[0]));
							$("#originalImage").attr("src",window.URL.createObjectURL(data.files[0]));
						}
        				
        				$("#originalImage").bind('load',function(){
        					$("#img_width").val($("#originalImage").width());
            				$("#img_height").val($("#originalImage").height());
        				});

        				//data.submit();
        			},
        			start: function (e) {
        			   // $("#progress").show();
        			},
        			done : function(e, data) {
        			    //$("#progress").hide();
        			    var result=data.result;
        			    if(result.returnCode=="SUCCESS"){
        			    	var sceneGroupId=$("#alretboxmian .sceneGroup").val();
        			    	var sort=$("#alretboxmian .sceneGroup option:selected").data("scenenum");
        			    	d={
        			    		"name":result.fileName,
        			    		"imgUrl":result.imgUrl,
        			    		"thumbnailUrl":result.thumbnailUrl,
        			    		"sceneGroup.id":sceneGroupId,
        			    		"albumId":albumId,
        			    		"sort":sort
        			    	};
        			    	saveScene(d);
        			    }else{
        			    	$("#ajaxload").hide();
        			    	$("#alretboxmian .uploadimg_com_waring_tx").show().html(result.returnMsg)
        			    	//alert(result.returnMsg);
        			    }
        			},
        			progressall: function (e, data) {
        				var progress = parseInt(data.loaded / data.total * 100, 10);
        			   // $('#progress .bar').css('width',progress + '%');
        			}
        		});
    		 }); */
    		
    		//上传图片弹窗
    		$("#btn_imageupload").click(function(){
				if($("#alretboxmian").length){
					$("#alertboxbg").remove();
				    $("#alretboxmian").remove();
				}
				if(!$('#tab_nav_xie').is(':hidden')){
					$(".alert_select.sceneGroup option[value='"+leftKeyCurSceneGroudId+"']").attr("selected", true); 
				}
				$(".fileupload").click();
				$(this).attr('data-local','local');
			    alertbox({
			        msg:$('.uploadimg_com').html(),
			        tcallfn_tx:'开始上传',
			        ishide:true,
			        tcallfn:function(){
			        	var txhtml='';
			        	var sceneGroupel= $("#alretboxmian .sceneGroup")[0]
			        	sceneGroupIds=$(sceneGroupel).val();
    			    	sortscennum=$("#alretboxmian .sceneGroup option:selected").data("scenenum");
		    			$('.uploadstar_mian').show();
		    			$('.uploadingstar_group span').html(sceneGroupel.options[sceneGroupel.selectedIndex].text)
		    			$('.uploadstar_mian .alert_title_upinggrup').html(successfilelist+'/'+fileimgarr.length)
		    			for(var i=0;i<fileimgarr.length;i++){
		    				 //_create(fileimgaugment,fileimgarr[i],secneupfileimg)
		    				txhtml+='<li class="color_859dad clear">'+
		    				'<span><i class="uploadstaricon"></i></span>'+
		    				'<span class="tx_over uploadstar_list_name">'+fileimgarr[i].name+'</span>'+
		    				'<span class="uploadstar_list_tx"><i>排队中..</i></span>'+
		    				'<span class="tx_over uploadstar_list_m"></span>'+
		    				'<span class="uploadstar_list_size">'+(fileimgarr[i].size/1024/1024).toFixed(2)+'M</span>'+
		    				'<span class="uploadstar_list_up"><i class="londing"></i></span>'+
		    				'<span><i class="londingclose"></i></span>'+
		    				'<p class="loadbg"></p>'+
		         			'</li>'
		    			}
		    			$('.uploadstar_list').append(txhtml);
		    			$('#sihaiload').show()
		    			$('.uploadstar_mian').show();
		    			secneupfileimg();
		    			if($('#tab_nav_xie').is(':hidden')){
		    				leftKeyCurSceneGroudId = null;
		    			}
			        },
			        fcallfn:function(){
			        	location.reload();
			        }
			    });
			});
    		 $('body').on('click','.londingclose',function(){
    			 var idx = $(this).parents('li').index()
    			 if(idx == successfilelist){
    				ajaxfileimgarr[successfilelist].abort()
    				$(".uploadstar_list li").eq(successfilelist).find('.loadbg').hide();
	            	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i style="color:#cccccc">已取消</i>');
					$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html('');
					$(".uploadstar_list li").eq(successfilelist).find('.londing').show();
					$(".uploadstar_list li").eq(successfilelist).find('.londingclose').hide();
					successfilelist++;
					secneupfileimg();
    			 }else{
    				 fileimgarr.splice(idx,1)
    				 $(this).parents('li').remove()
    			 }
    			 $('.uploadstar_mian .alert_title_upinggrup').html(successfilelist+'/'+fileimgarr.length)
    		 })
    		 $('.uploadstar_close').click(function(){
    			 if(close_flag){
    				 $(".uploadstar_mian ").hide();
    				 $("#sihaiload").css("display","none");
    				 location.reload();
    			 }else{
    				 alertbox({
    	 			        msg:$('.close_del_up_mian').html(),
    	 			        tcallfn_tx:'确定',
    	 			        tcallfn:function(){
    	 			        	location.reload();
    	 			        }
    	    			 })
    			 }
    			 
    		 })
    		 $('#uploadstar_smalls').click(function(){
    			 if($(this).is('.uploadstar_small')){
    				$(this).addClass('uploadstar_big').removeClass('uploadstar_small');
    				$('.uploadlist_mian').hide();
    			 }else{
    				$(this).addClass('uploadstar_small').removeClass('uploadstar_big');
     				$('.uploadlist_mian').show();
    			 }
    		 })
    		 $('body').on('click','.londing',function(){
    			 var idx = $(this).parents('li').index();
    			 fileimgarr.push(fileimgarr[idx]);
    			 fileimgarr.splice(idx,1);
    			 $(this).parents('li').remove();
    			 --successfilelist;
    			 var fileimgarrlength = fileimgarr.length -1
    			 var txhtml='<li class="color_859dad clear">'+
 				'<span><i class="uploadstaricon"></i></span>'+
				'<span class="tx_over uploadstar_list_name">'+fileimgarr[fileimgarrlength].name+'</span>'+
				'<span class="uploadstar_list_tx"><i>排队中..</i></span>'+
				'<span class="tx_over uploadstar_list_m"></span>'+
				'<span class="uploadstar_list_size">'+(fileimgarr[fileimgarrlength].size/1024/1024).toFixed(2)+'M</span>'+
				'<span class="uploadstar_list_up"><i class="londing"></i></span>'+
				'<span><i class="londingclose"></i></span>'+
				'<p class="loadbg"></p>'+
     			'</li>'
     			$('.uploadstar_list').append(txhtml);
    		 })
    	});
    	function secneupfileimg(result){
    		var successfilelists = result ? result : successfilelist
    		function _create(amgumentfile) {
    			var URL = window.URL || window.webkitURL|| window.mozURL;
    		    var blob = URL.createObjectURL(amgumentfile);
    		    var img = new Image();
    		    img.src = blob;
    		    img.onload = function() {
    		        var that = this;
    				var data,filewidth,fileheight;
    		        //生成比例
    		        if(that.width >= 8192){
    		        	filewidth= 8192; 
    		            fileheight = 4096; 
    		        }else{
    		        	filewidth =that.width;
    		        	fileheight =that.height;
    		        }
    		        
    		        //生成canvas
    		        var canvas = document.createElement('canvas');
    		        var ctx = canvas.getContext('2d');
    		        $(canvas).attr({
    		            width: filewidth,
    		            height: fileheight
    		        });
    		        ctx.drawImage(that, 0, 0, filewidth, fileheight);
    		        /**
    		         * 生成base64
    		         * 兼容修复移动设备需要引入mobileBUGFix.js
    		         */
    		        var base64 = canvas.toDataURL('image/jpeg', 0.8);
    		        data = window.atob(base64.split(',')[1]);
    		        var ia = new Uint8Array(data.length);
    		        for (var i = 0; i < data.length; i++) {
    		              ia[i] = data.charCodeAt(i);
    		        };
    		         //canvas.toDataURL 返回的默认格式就是 image/png
    		        var blob = new Blob([ia], {
    		         	type: "image/jpeg",
    		        });
    		        var result = {
    		            base64: base64,
    		            clearBase64: base64.substr(base64.indexOf(',') + 1),
    		            filewidth:filewidth,
    		            fileheight:fileheight,
    		            filename:amgumentfile.name
    		        };
    		        // 执行后函数 
    		        //secneupfileimg(result)
    		        var fd = new FormData();
    		        fd.append('file', blob);
    		        fd.append('filename', result.filename);
    		        fd.append('width', result.filewidth);
    		        fd.append('height', result.fileheight);
    		        var startimes  = new Date()
    		        var datalocal = $("#btn_imageupload").attr('data-local');
    		    // 生成结果
    			   ajaxfileimgarr.push($.ajax({
    			        type: "POST",
    			        url: "${backPath}/pano/scene/fileupload",
    			        data: fd,
    			        processData: false,
    			        contentType: false,
    			        success: function (res) {
    			        	var result=res;
    					    if(result.returnCode=="SUCCESS"){
    					    	var sceneGroupId=sceneGroupIds;
    					    	var sort=sortscennum;
    					    	d={
    					    		"name":result.fileName,
    					    		"imgUrl":result.imgUrl,
    					    		"thumbnailUrl":result.thumbnailUrl,
    					    		"sceneGroup.id":sceneGroupId,
    					    		"albumId":albumId,
    					    		"sort":sort,
    					    	};
    					    	if(datalocal=='local'){
    					    		d.upSource = datalocal
    					    	}
    					    	saveScene(d);
    					    }else{
    					    	$(".uploadstar_list li").eq(successfilelist).find('.loadbg').hide();
    			            	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i style="color:#ff5050">'+result.returnMsg+'</i>');
    							$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html('');
    							$(".uploadstar_list li").eq(successfilelist).find('.londingclose').hide();
    							$("#ajaxload").hide();
    					    	$("#alretboxmian .uploadimg_com_waring_tx").show().html(result.returnMsg);
    					    	clearInterval(loadtimes);
    					    	loadtoal=70;
    					    	console.log(successfilelist,ajaxfileimgarr.length);
    					    	successfilelist++;
    					    	loadtimes = false;
    					    	if(successfilelist==ajaxfileimgarr.length){
    					    		close_flag=false;
    					    		//location.reload();
    					    	}
    					    	secneupfileimg();
    					    	//alert(result.returnMsg);
    					    }
    					    
    			        },
    			        xhr:xhrOnProgress(function(e){
    			            var percent=(e.loaded / e.total)*100;//计算百分比 
    			            var endtime = new Date()  
    			            var stmes = (endtime-startimes)/1000
    			            if(percent>=70){
    			            	if(!loadtimes){
	    				            loadtimes = setInterval(function(){
	    				            	 $(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html('0.5MB/S')
	    				            	if(loadtoal <=99 ){
		    				            	loadtoal+= 0.5
		    				            	$(".uploadstar_list li").eq(successfilelist).find('.loadbg').css('width',loadtoal+'%')
		        			            	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i>'+loadtoal+'%</i>')
	    				            	}
	    				            }, 1000)
    			            	}
    			            }else{
    			            	$(".uploadstar_list li").eq(successfilelist).find('.loadbg').css('width',percent+'%')
        			            $(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i>'+percent.toFixed(2)+'%</i>')
        			            $(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html(((((e.total)/1024)/1024)/(stmes)).toFixed(2)+'MB/S')
    			            	
    			            }
    			         }),
    			        error: function(data) {
    			        }
    			    })
    			   )
    			   /* $("#btn_imageupload").attr('data-local',""); */
    		    };
    		}
    		_create(fileimgarr[successfilelists])
    	}
    	function uploadImage(){
			if(jqXHR){
				jqXHR.submit();
			}else{
				alert('选择图片');
			}
		}
    	function saveScene(d){
    		d.linkerId=linkerId;
			$.post("${backPath}/pano/scene/save",d,function(data){
				if(data.returnCode=="SUCCESS"){
					if(successfilelist < fileimgarr.length){
						loadtoal = 70
						clearInterval(loadtimes)
						loadtimes = false
						$(".uploadstar_list li").eq(successfilelist).find('.loadbg').hide()
		            	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i style="color:#16d38e">完成</i>')
						$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html('')
						$(".uploadstar_list li").eq(successfilelist).find('.londingclose').hide()
					}
				}else{
					loadtoal = 70
					clearInterval(loadtimes)
					loadtimes = false
					$(".uploadstar_list li").eq(successfilelist).find('.loadbg').hide()
	            	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i style="color:#ff5050">失败</i>')
					$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html('')
					$(".uploadstar_list li").eq(successfilelist).find('.londing').show()
					$(".uploadstar_list li").eq(successfilelist).find('.londingclose').hide()
					$("#alretboxmian .uploadimg_com_waring_tx").show().html(data.returnMsg);
					//alert(data.returnMsg);
				}
				if(successfilelist == (fileimgarr.length-1)){
					close_flag=true;
					//location.reload();
				}
				successfilelist++
				$('.uploadstar_mian .alert_title_upinggrup').html(successfilelist+'/'+fileimgarr.length)
				secneupfileimg()
				
			});
		}
    	$(function(){
	    	if(!stage.group){
	    		$('.camear_head>span').eq(0).addClass('active').siblings().removeClass('active').find('img').attr('src',backStatic+'/images/list2_nav0.png');
				$('.camear_head>span').eq(1).find('img').attr('src',backStatic+'/images/list2_nav1.png');
	    		$('.big_whole').show();
	    		$('#tab_nav_xie').hide();
	    	}else if(stage.group>0){
	    		$('.camear_head>span').eq(0).find('img').attr('src',backStatic+'/images/list2_nav00.png');
				$('.camear_head>span').eq(1).addClass('active').siblings().removeClass('active').end().find('img').attr('src',backStatic+'/images/list2_nav11.png');
	    		$('.small_whole_info').show();
				$('.small_whole_info ul').eq(stage.group-1).show();
				$('#tab_nav_xie').show();
				$('#tab_nav_xie').html('分组 <i></i>'+$('.small_whole li').eq(stage.group).find('.edit_tx').html());
	    	}else{
	    		$('.camear_head>span').eq(0).find('img').attr('src',backStatic+'/images/list2_nav00.png');
				$('.camear_head>span').eq(1).addClass('active').siblings().removeClass('active').end().find('img').attr('src',backStatic+'/images/list2_nav11.png');
	    		$('.small_whole').show();
	    		$('#tab_nav_xie').hide();
	    	}
    	})
    </script>
    <style>
    html,body{height:100%}
    </style>
</head>
<body>
<div class="mask" style="width:100% ;height:100%;position:absolute;left:0;top:0;z-index:999;background:rgba(60,60,60,0.8);display:none"></div>
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
        <a href="${siteRoot}/object/toaddObject?id=${linkerId}">
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
            <p class="head_icon_tx">按钮</p>
        </a>
    </li>
    <!-- <li class="head_nav_chear_no">
        <p class="head_icon_txover_no"></p>
        <a>
            <span class="head_icon_big head_icon_four head_icon_no"></span>
            <p class="head_icon_tx">右侧及下方按钮</p>
        </a>
    </li> -->
    <li class="head_nav_chear_no">
        <a>
            <span class="head_icon_big head_icon_four head_icon_no"></span>
            <p class="head_icon_tx">推广信息</p>
        </a>
    </li>
</div>
<div class="mian_com" style="position: relative;">
	<b class="redStar" style="float:left;position: absolute; left:15px; top:35px;"></b>
    <div class="camear_head mb20 clear">
        <span class="active fl"><img src="${backStatic}/images/list2_nav0.png" class="camer_list0_img">全部</span>
        <span class="fl"><img src="${backStatic}/images/list2_nav1.png" class="camer_list0_img">分组</span>
        <p id="tab_nav_xie" class="tab_nav_xie fl"></p>
        <i class="btn_com blue_btn_com fr btn_imageupload_hover"><em class="icon-add"></em>上传照片
        	<div class="uploadimgtab">
        		<div class="" id="btn_imageupload">
        		</div>
        		<div id="btn_select_library">
        		</div>
        	</div>
        </i>
    </div>
    <div class="tabmian">
        <!--全部-->
        <ul class="big_whole clear whole hide_com">
        	<c:forEach var="group" items="${album.sceneGroupList}">
	        	<c:forEach var="item" items="${group.sceneList}">
		        	<li data-id="${item.id}" data-type="scene" data-imgurl="${fns:getCosAccessHost()}${item.imgUrl}">
		        		<input type="hidden" name="name" value="${item.name}">
		        		<input type="hidden" name="des" value="${item.des}">
		        		<input type="hidden" name="thumbnailUrl" value="${item.thumbnailUrl}">
		        		<input type="hidden" name="imgUrl" value="${item.imgUrl}">
		        		<input type="hidden" name="createTime" value="<fmt:formatDate value="${item.createTime}"  pattern="yyyy-MM-dd HH:mm" />">
		        		<input type="hidden" name="bottomLogo" value="${item.bottomLogo}">
		                <img src="${fns:getCosAccessHost()}${item.thumbnailUrl}" class="fl"/>
		                <p class="fl tx_over" title="${item.name}">
		                    <i class="whole_img_icon"></i><i class="edit_tx">${item.name}</i>
		                </p>
		                <i class="list2_icon_cur"></i>
		                <i class="list2_icon_hover"></i>
		            </li>
		        </c:forEach>    
        	</c:forEach>
        </ul>
        <!--分组-->
        <ul class="small_whole clear hide_com whole">
            <!--固定-->
            <li>
            	<div class="small_btn_div">
	                <i class="small_btn"></i>
	                <em>添加分组</em>
                </div>
            </li>
            <c:forEach var="group" items="${album.sceneGroupList}">
	            <li data-id="${group.id}" data-type="sceneGroup" data-sort="${group.sort}">
	                <img src="<c:if test="${not empty group.coverImgUrl}">${fns:getCosAccessHost()}${group.coverImgUrl}</c:if><c:if test="${empty group.coverImgUrl}">${backStatic}/images/b.png</c:if>" class="fl"/>
	                <p class="fl tx_over" title="${group.name}(${group.sceneList.size()})">
	                    <i class="whole_img_file"></i><i class="edit_tx" data-id="${group.id}"><em class="fenzu">${group.name}</em></i>(${group.sceneList.size()})
	                </p>
	                <i class="list2_icon_cur"></i>
	            </li>
            </c:forEach>
        </ul>
        <!--分组详细-->
        <div class="small_whole_info clear hide_com whole">
        	<c:forEach var="group" items="${album.sceneGroupList}">
	            <ul class="hide_com" data-groupid="${group.id}">
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
    <div style="text-align: right;">
    	<li class="clear pb38 list_li_com pt50">
			<span class="span_com">&nbsp;</span>
			<input type="button" onclick="backhref();" value="上一步" class="btn_tx_com_connter_sub btn_tx_com_connter_ccc mr20"/>
			<input type="button" onclick="forwarddetails();" value="预览" class="btn_tx_com_connter_sub btn_tx_com_connter_yulan mr20"/>
			<input type="button" onclick="addrightButton();" id="ajaxSubmit" value="保存并下一步" class="btn_tx_com_connter_sub btn_tx_com_connter_bule"/>
		</li>
    </div>
</div>

<!--右键菜单-->
<div class="hide_com right_click_nav right_moudown_nav">
    <!--<li>设为首页背景图</li>-->
    <li class="alert_bianji">编辑场景</li>
    <li class="alert_basic">基本信息</li>
    <li class="point_setting">高级设置</li>
    <li class="alert_bottomLogo">底部logo</li>
    <li class="scene_preview">预览</li>
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
<!--删除分组-->
<div  class="right_del_mian_del hide_com">
    <div>
        <p class="alert_title">删除分组</p>
        <div class="alert_deleta_mian">
            <img src="${backStatic}/images/warnicon.png" class="warunicon">确定要删除分组吗?
        </div>
    </div>
</div>
<!--取消上传-->
<div  class="close_del_up_mian hide_com">
    <div>
        <p class="alert_title">取消上传</p>
        <div class="alert_deleta_mian">
            <img src="${backStatic}/images/warnicon.png" class="warunicon">确定要取消上传吗?
        </div>
    </div>
</div>
<!-- 删除平面图 -->
<div  class="sandScene_del_mian hide_com">
    <div>
        <p class="alert_title">删除图片</p>
        <div class="alert_deleta_mian">
            <img src="${backStatic}/images/warnicon.png" class="warunicon">确定要删除这张平面图吗?
        </div>
    </div>
</div>
<!--上传照片-->
<img id="originalImage" src="" style="display: none;">
<input type="file" class="hide_com fileupload" multiple="multiple" id="sencenfileupload"/>


<div class="uploadimg_com hide_com">
    <form>
        <p class="alert_title">上传照片</p>
        <ul class="grouplistname " style="margin-top:50px;">
	        <li class="clear mb10 mt10 alert_list">
	            <p style="line-height: 5px;"></p> 
	        </li>
        </ul>
        <ul class=" mt10" style="margin-bottom:50px;">
	        <li class="clear mb10 alert_list">
				<p class="alert_tx">上传到:
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
				</p>
	        </li>
	         <li class="clear mb10 alert_list uploadimg_com_waring_tx hide_com" style="color:#f00">
	         xxx
	         </li>
         </ul>
    </form>
</div>
<!--编辑场景-->
<input type="file" name="file" accept="image/*" class="hide_com input_load_coms edit_fileupload"/>
<div class="edit_com hide_com">
    <form>
        <p class="alert_title">编辑场景</p>
        <li class="clear mb10 alert_list">
            <p class="alert_tx">场景名称:</p>
            <input type="text" maxlength="10" placeholder="请输入10个字之内的场景名称" class="btn_tx_com edit_scene_name" />
            <span class="warn_tx_com hide_com">*不能为空</span>
        </li>
        <li class="clear mb10 alert_list">
            <p class="alert_tx">场景描述:</p>
            <input type="text" class="btn_tx_com edit_scene_des"/>
        </li>
        <li class="clear mb10 alert_list">
            <p class="alert_tx">全景上传:</p>
            <label class="color_009bff">
                <img src="${backStatic}/images/img_logo.png" class="load_img_com mr10 edit_scene_thumbnailUrl" width="80"/>
            	
            </label>
        </li>
    </form>
</div>
<!--基本信息-->
<div class="basic_com hide_com">
    <form>
        <p class="alert_title">基本信息</p>
        <li class="clear mb10 alert_list">
            <p class="alert_tx">场景名称:</p>
            <input type="text" class="btn_tx_com fl info_scene_name" disabled="disabled" style="border:0px;background-color:none;color:#859dad"/>
        </li>
        <li class="clear mb10 alert_list">
            <p class="alert_tx">场景描述:</p>
            <input type="text" class="btn_tx_com fl info_scene_des" disabled="disabled" style="border:0px;background-color:none;color:#859dad"/>
        </li>
        <li class="clear mb10 alert_list">
            <p class="alert_tx">场景ID:<span class="ml5 info_scene_id" ></span></p>
        </li>
        <li class="clear mb10 alert_list">
            <p class="alert_tx">创建时间:<span class="ml5 info_scene_createtime"></span></p>
        </li>
    </form>
</div>
<!--查看大图-->
<div class="dbclick_com hide_com">
	<div class="dblcik_bg">
	</div>
	<!-- <img src="${backStatic}/images/b.jpg"  width="500" height="400"/> -->
	<div class="dvclick_mian">
	    <div class="dbclick_show">
	        <li><img src="${backStatic}/images/b.jpg" id="dbclick_img_conent" data-idx='0' /></li>
	    </div>
	    <div class="dbclick_arrow">
	        <span class="dbclick_arrow_l" id="dbclick_arrow_l"></span>
	        <span class="dbclick_arrow_r" id="dbclick_arrow_r"></span>
	    </div>
    </div>
    <img src="${backStatic}/images/img_del.png" id="dbclick_hide_main" style="position: absolute;top:0px;right:0px;z-index:1000;cursor: pointer;border:5px solid #000"/>
    <div class="dbclick_bottom_mian">
    	<i class="dbclick_bottom_icon dbclick_bianji_icon" title="基本信息"></i>
    	<i class="dbclick_bottom_icon dbclick_edit_icon" title="编辑场景"></i>
    	<i class="dbclick_bottom_icon dbclick_gaoji_icon" title="高级设置"></i>
    	<i class="dbclick_bottom_icon dbclick_logo_icon" title="底部logo"></i>
    	<i class="dbclick_bottom_icon dbclick_del_icon" title="删除"></i>
    </div>
</div>
<!--底部logo-->
<input type="file" name="file" accept="image/*" class="hide_com input_load_coms bottomLogoFileupload"/>
<div class="uplogoimg_com hide_com">
    <form>
        <p class="alert_title">底部logo</p>
        <li class="clear mb10 alert_list clear">
            <p class="alert_tx">底部logo上传:</p>
            <label class="color_009bff fl">
                <img src="${backStatic}/images/img_bottom_logo.png" class="load_img_com mr10 bottomLogoFileupload_img" width="80"/>
            </label>
            <input type="button" class="lianjieqidelte fl" style="margin-top:47px;" value="删除图片">
        </li>
    </form>
</div>
<!--分组右键菜单-->
<div class="hide_com small_right_click_nav right_moudown_nav">
    <li class="small_right_nav_contentd">重命名</li>
    <li class="add_plan">设置平面图</li>
    <li class="right_nav_del">删除</li>
    <li class="small_right_nav_xiu">更改封面</li>
    <li class="forwardShiftSceneGroup">向前移一位</li>
    <li class="backwardShiftSceneGroup">向后移一位</li>
</div>
<!--分组更改封面-->
<div class="small_banner_img hide_com">
    <form class="small_banner_form">
        <p class="alert_title">更改封面</p>
        <div class="mr20 mt20 mb10 ml20 clear">
            <label class="fl mr10">
                <img src="${backStatic}/images/b.jpg"  class="fl" width="80" height="80"/>
                <input type="radio" name="small_banner_img" class="hide_com">
            </label>
            <label class="fl mr10">
                <img src="${backStatic}/images/b.jpg" class="fl"  width="80" height="80"/>
                <input type="radio" name="small_banner_img" class="hide_com">
            </label>
        </div>
    </form>
</div>
<!--分组详细右键菜单-->
<div class="hide_com small_right_info_click_nav right_moudown_nav">
    <li class="alert_small_right_banner">设为封面</li>
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
<div id="delforwardiframemian" class="hide_com">
	<span id="delforwardiframe" class="delforwardiframe"></span>
	<div class="delforwardiframebg">
	</div>
	<iframe id="forwardiframe" class="fowrdiframe">
	</iframe>
</div>
<iframe src="" id="point_setting" class="hide_com" style="position:absolute;top:50%;left:50%;width:95%;height:95%;z-index:1000;transform:translate(-50%,-50%)"></iframe>
<iframe src="" id="scene_preview" class="hide_com" style="position:absolute;top:50%;left:50%;width:95%;height:95%;z-index:1000;transform:translate(-50%,-50%)"></iframe>
<div id="ajaxload" class="ajaxload">
    <div class="ajaxbg"></div>
    <div class="cssload-loader"></div>
    <!-- <img src="${backStatic}/images/ajax-loader.gif"  class="ajaxloadimg"/> -->
</div>
<!-- 增加平面设置  -->
<div class="add_planSet_layer">
	<div class="add_planSet_layer-content">
		<div class="add_planSet_layer-title">
			<i title="关闭"></i>
			<h4>设置平面图<small><img src="${backStatic}/images/add_planSet_layer_title.jpg" title="设置一张平面图，让全景以“点位”的形式放置其中，全局效果一目了然" alt="设置一张平面图，让全景以“点位”的形式放置其中，全局效果一目了然" /></small></h4>
		</div>
		<div class="add_planSet_layer-main">
			<div class="add_planSet_layer_main-left">
				<div class="add_planSet_layer_main_left-showImg">
					<div id="sandPoint">
						<div class="sandPoint-list" id="sandPoint-list">
						</div>
					</div>
					<div class="remImgUrl" alt="删除" title="删除"></div>
					<div class="add_planSet_layer_main_left-upData">
						<form style="width: 100%;height: 100%;">
							<input type="hidden" name="linkerId" value="${linkerId}">
							<input type="file" name="file" id="sandTableImageFile" class="upDataImg" value="上传平面图">
						</form>
						
					</div>
				</div>
			</div>
			<div class="add_planSet_layer_main-right">
				<div id="sceneList">
					<dt><img src="${backStatic}/images/sceneListTitle.jpg" style="margin-bottom:-2px;" title="添加场景" alt="添加场景" /></dt>
					<dl>
						
					</dl>
				</div>
				<div class="add_planSet_layer_main_right-cont" id="add_planSet_layer_main_right-cont">
					<div id="add_planSet_layer_main_right_cont-main">
						<ul>		
						</ul>
					</div>
				</div>
				<div class="add_planSet_layer-footer">
					<button><img src="${backStatic}/images/.add_planSet_layer_footer_button.png" title="完成" alt="完成" /></button>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="uploadstar_mian hide_com">
     <p class="alert_title clear">上传照片(<i class="alert_title_upinggrup">1/6</i>)<i class="fr uploadstar_close"></i></i><i id="uploadstar_smalls" class="uploadstar_small fr"><em class="uploadstar_smallss"></em></i></p>
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

<div class="uplibrarymian hide_com">
     <p class="alert_title clear">从素材库选择</p>
     <p><select class="uplibrary_select uplibrary_selectcur"></select></p>
     <div class="uplibrary_scroll">
     	
     </div>
     <p class="ablumselectmian">添加至:
     	<select class="uplibrary_select ablumgroup_select" style="height:25px;margin:15px 20px;">
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
     </p>
</div>
<div id="sihaiload" style="background: rgb(0, 0, 0); opacity: 0.5; top: 0px; left: 0px; position: fixed; z-index: 996; height: 100%; width: 100%; display: none;"></div>
<div class="AJAXUpData">
	<i class="loader--spinningDisc"></i>
</div>
<!--切换连接-->
<div  class="tab_album_bottom_alert hide_com">
    <div>
        <p class="alert_title">切换为腾讯街景连接</p>
        <div class="alert_deleta_mian">
            <img src="${backStatic}/images/warnicon.png" class="warunicon">确定要切换为腾讯街景连接?
        </div>
    </div>
</div>
<div class="tab_album_bottom">
	<div class="tab_album_bottom_br"><span>or</span></div>
	<div class="tab_album_bottom_tx">
		暂无图片，<a id="tabalbumlink">切换腾讯街景连接</a>
	</div>
</div>
<script src="${ctxStatic}/modules/720/js/list2_1.js?v=1.3" type="text/javascript"></script>
<script type="text/javascript">
//切换连接
$(function(){
	$('#tabalbumlink').click(function(){
		alertbox({
			msg:$('.tab_album_bottom_alert').html(),
			tcallfn_tx:'确定',
			tcallfn:function(){
				location.href="${backPath}/pano/album/togglePano?albumId=${album.id}&linkerId=${linkerId}&panoType=tencentPano"
			}
		})
	})
})
//素材库选择
function librarySaveScene(d){
	$.post("${backPath}/pano/scene/save",d,function(data){console.log(data)})
}
$(function(){
	var uplibrary_selectidx =0;
	var ablumgroup_selectidx =0;
	$('body').on('click','.uplibrary_list li',function(){
		if($(this).is('.cur')){
			$(this).removeClass('cur')
		}else{
			$(this).addClass('cur')
		}
	})
	$('body').on('change','.uplibrary_selectcur',function(){
		var _this =$(this)
		uplibrary_selectidx = _this[0].selectedIndex
		$('#alretboxmian .uplibrary_scroll > div').hide().eq(uplibrary_selectidx).show()
	})
	$('body').on('change','.ablumgroup_select',function(){
		var _this =$(this)
		ablumgroup_selectidx = _this[0].selectedIndex
	});
	var hasLoadFileData=false;
	
	$('#btn_select_library').click(function(){
		$('#alretboxmian .uplibrary_scroll > div').hide().eq(uplibrary_selectidx).show()
		if(!hasLoadFileData){
			$.get("${backPath}/file/image/list",{},function(data){
				hasLoadFileData=true;
				var res = data
				var opthtml =''
				var listhtml = ''

				for(var i=0;i<res.length;i++){
					var fileInfoList =res[i].fileInfoList
					opthtml +='<option>'+res[i].name+'</option>'
					if(i==0){
						listhtml +='<div class="uplibrary_list clear">'
					}else{
						listhtml +='<div class="uplibrary_list clear hide_com">'
					}
					
					for(var j=0;j<fileInfoList.length;j++){
						listhtml+='<li data-thumbnailPath="'+fileInfoList[j].thumbnailPath+'" data-name="'+fileInfoList[j].name+'" data-resourcePath="'+fileInfoList[j].resourcePath+'">'+
								'<img src="'+cosAccessHost+fileInfoList[j].thumbnailPath+'" class="fl">'+
								'<p class="tx_over fl">'+fileInfoList[j].name+'</p>'+
								'<i class="uplibrary_list_cur"></i><i class="uplibrary_list_hover"></i></li>'
					}
					listhtml+='</div>'
				}
				console.log(data);
				$('.uplibrary_selectcur').html(opthtml)
				$('.uplibrary_scroll').html(listhtml)
			});
		}
		alertbox({
			msg:$('.uplibrarymian').html(),
			tcallfn_tx:'上传',
			tcallfn:function(){
				var datalist
				$('#alretboxmian .uplibrary_scroll > div').eq(uplibrary_selectidx).find('li').each(function(){
					var _this = $(this)
					if(_this.is('.cur')){
						console.log(1)
						//选择列表
						var d={
				    		"name":_this.data('name'),
				    		"imgUrl":_this.data('resourcepath'),
				    		"thumbnailUrl":_this.data('thumbnailpath'),
				    		"sceneGroup.id":$('#alretboxmian .ablumgroup_select').val(),
				    		"albumId":albumId,
				    		"linkerId":linkerId
				    	};
						$('#ajaxload').show();
						librarySaveScene(d);
					}
				})
				location.reload();
			}
		})
	})
	
})
var _eventState= true;
var sandTableImgPath=null;
//添加平面设置
$('.add_planSet_layer-footer button').click(function(){
	 var backgroundImage = $('.add_planSet_layer_main-left').css('background-image');
	 var backgroundImageName=backgroundImage.substring(backgroundImage.lastIndexOf("/")+1,backgroundImage.lastIndexOf("."));
	 var defaultBackgroundImageName = 'sandUpDataImg';
	 var listSandPoint = $('.sandPoint_list-main'), 
	 	 pointGroup = [], 
	 	 backgroundImgUrl ="";
	if(backgroundImageName !== defaultBackgroundImageName){
		for(var i=0; i< listSandPoint.length; i++){
			pointGroup.push({
				'x' : listSandPoint.eq(i).css('left').replace("px",""),
				'y' : listSandPoint.eq(i).css('top').replace("px",""),
				'angle' : listSandPoint.eq(i).find('.moveDiv').attr('data-rotate'),
				'sceneId' : listSandPoint.eq(i).attr('data-sceneId')
			});
		}
		function removeCharacter (character,removeChar){
			if((typeof character !=='string' && character.constructor !==String) || (typeof removeChar !=='string' && removeChar.constructor !==String) ){
				return;
			}
			var returncharacter = "";
			if(character.indexOf(removeChar) != -1){
				returncharacter = character.replace(removeChar,"");
				removeCharacter(returncharacter,removeChar);
			}
			return returncharacter;
		}
		var imgPath = $('.add_planSet_layer_main-left').css('background-image').replace("url(\"","").replace("\")","");
		backgroundImgUrl = removeCharacter(imgPath,cosAccessHost);
	}
		var upData = {
			"linkerId":linkerId,
			"albumId":albumId,
			"sceneGroupId": small_right_this.attr('data-id'),
			"imgPath":backgroundImgUrl,
			"points": pointGroup
		};
		 $.ajax({
	         type:"POST",
	         url:"${backPath}/pano/sandTable/save",
	         dataType:"json",
	         data: JSON.stringify(upData),
	         contentType : 'application/json;charset=utf-8',
	         beforeSend: function(){
	              //加载动画开始
	        	 $('.AJAXUpData').fadeIn();
	         },
	         success: function(){
	        	 $('.add_planSet_layer').fadeOut();
	              //请求成功做处理
	         },
	         complete: function(){
	              //加载动画结束
	        	 $('.AJAXUpData').fadeOut();
	         },
	         error: function(){
	              //请求失败时调用此函数
	        	 alert('提交失败！');
	         }
	    });
		 $('.add_planSet_layer').fadeOut();
});
$('.add_plan').click(function(){
	$('#sceneList dt img').attr('src',sceneTitleDefault);
	$('#sandTableImageFile').val("");
	$('.add_planSet_layer').fadeIn();
	var groupId = small_right_this.attr('data-id'),
		groupList = $('.small_whole_info ul'),
		html = "",
		addHml = $('#sceneList dl');
	addHml.html("");
	$('#add_planSet_layer_main_right_cont-main ul').html("");
	$('#sandPoint-list').html("");
	$('.remImgUrl').hide();
	$('.add_planSet_layer_main_left-upData').show();
	var bg = '${backStatic}/images/sandUpDataImg.jpg';
	$('.add_planSet_layer_main-left').css({'background':'url('+ bg +') #f1f6f9 no-repeat center center'});
	$.get("${backPath}/pano/sandTable/get?sceneGroupId="+ groupId, function(result){
		if(result.returnCode == 'SUCCESS'&& result.sandTable!=""){
			var pointList = result.sandTable.points,
				points = document.getElementById('sandPoint-list'),
				sceneListMain = document.getElementById('add_planSet_layer_main_right_cont-main').getElementsByTagName('ul')[0],
				pointHtml ='',
				sceneListHtml ='';
			$('#sceneList dt img').attr('src',sceneTitleYse);
			if(result.sandTable.imgPath!=""&& result.sandTable.imgPath != undefined){
				$('.add_planSet_layer_main_left-upData').hide();
				$('.add_planSet_layer_main-left').css({'background':'url('+ result.sandTable.imgUrl +') #f1f6f9 no-repeat center center','background-size': 'contain'});
				$('.remImgUrl').show();
			}
			if(pointList.length>0){
				var  sceneList = $(".small_whole_info  ul[data-groupid='"+groupId+"']").children('li');
				if(sceneList.length > 0){
					for(var j=0; j< sceneList.length; j++){
						for(var i=0; i< pointList.length; i++){
							if(pointList[i].sceneId == sceneList[j].getAttribute('data-id')){
								sceneListHtml += '<li class="add_planSet_layer_main_right_cont-copy" data-sceneId="'+ sceneList.eq(j).attr('data-id') +'"><img src="'+ sceneList.eq(j).find('img').attr('src') +'" /><span>'+ sceneList.eq(j).find('p').attr('title') +'</span><i alt="删除"></i></li>';
							}
						}
					}
					
				}
				sceneListMain.innerHTML = sceneListHtml;
				var scenList=$('#add_planSet_layer_main_right_cont-main ul li');
				for(var i=0, pointLen = pointList.length; i< pointLen; i++){
					for(var j=0, len = scenList.length; j < len; j++ ){
						if(pointList[i].sceneId == scenList.eq(j).attr('data-sceneid')){
							pointHtml+='<div class="sandPoint_list-main" style="left:'+ pointList[i].x +'px; top:'+ pointList[i].y +'px;" data-sceneId="'+ pointList[i].sceneId +'"><div class="sandPoint_list_main-AC" style="display:block;"> <i></i> <div class="sandPoint_list_main-prompt">已将当前全景加入沙盘图<br/> 您可以： <br/>拖动黄点设置位置 <br/>拖动尖头设置视角偏移</div></div><div class="moveDiv" style="transform: rotate('+ pointList[i].angle +'deg);" data-rotate="'+ pointList[i].angle +'"><div class="splm_active-point" style="display:none;"><div class="splm_active_po-mask"></div><div class="splm_active_po-anActive" data-pointState="false"></div></div></div></div>';	
						}
					}	
				}
				points.innerHTML= pointHtml;
				initSandPoint();
			}	
		}
	  });
	
	return false;
});
$('.add_planSet_layer-title i').click(function(){
	$('.add_planSet_layer').fadeOut();
	$('#sandTableImageFile').val("");
	return false;
});
$('#add_planSet_layer_main_right_cont-main').on('click','dt',function(){
	var _that = $(this), 
		_state = _that.siblings('dd').is(':hidden');
	if(_state){
		_that.parent().parent().addClass('active').siblings().removeClass('active');
	} else{
		_that.parent().parent().removeClass('active');
	}
	var _mainPoint = $('#sandPoint div'),
	 	_sPoInd = 0;
	for(var i=0; i< _mainPoint.length;i++){
		if(_mainPoint.eq(i).attr('data-sceneId') == parseInt(_that.parent().parent().attr('data-sceneId'))){
			_sPoInd = i;
			break;
		}
	}
	_mainPoint.eq(_sPoInd).addClass('active').siblings().removeClass('active');
	return false;
});
$('.remImgUrl').on('click',function(){
	var bg = '${backStatic}/images/sandUpDataImg.jpg';
	alertbox({
		msg:$('.sandScene_del_mian').html(),
		tcallfn_tx:'确认',
		tcallfn:function(){
			if($('.add_planSet_layer_main-left').css('background-image')!=''){
				$('.add_planSet_layer_main-left').css('background','url('+ bg +') #f1f6f9 no-repeat center center');
				$('#sceneList dl').html('');
				$('#add_planSet_layer_main_right_cont-main ul').html('');
				$('.add_planSet_layer_main_left-upData').show();
				$('.sandPoint-list').html('');
				$('.remImgUrl').hide();
				$('#sandTableImageFile').val("");
				
			}
		}
	});
	return false;
});
/*
	沙盘点位设置
*/
$('.sandPoint-list').on('click','div.sandPoint_list_main-AC',function(){
	var _that = $(this);
	$('.splm_active-point').hide();
	$('.sandPoint_list_main-AC').show();
	_that.hide();
	_that.siblings('.moveDiv').find('.splm_active-point').show();
	var _copy = $('#add_planSet_layer_main_right_cont-main li'), thisSceneId = _that.parent('.sandPoint_list-main').attr('data-sceneid');
	for(var i=0; i< _copy.length;i++){
		if(thisSceneId == _copy.eq(i).attr('data-sceneId')){
			_copy.eq(i).addClass('active').siblings().removeClass('active');
			break;
		}
	}
	return false;
});
var addPo;
function initSandPoint (){
    var isUserMaskInteracting = false,
    	isUserAnActiveInteracting = false,
    	$anActive = $('.splm_active_po-mask'),
    	$mask = $('.splm_active_po-anActive'),
    	maskX = 0,
    	maskY = 0,
    	anActiveX = 0,
    	anActiveY = 0,
    	moveAnActiveY = 0,
    	moveAnActiveX = 0;
	function onMaskMouseDown (){
		event.preventDefault();
		isUserMaskInteracting = true;
		isUserAnActiveInteracting = false;
		maskX = event.clientX;
		maskY = event.clientY;
		if(this.className == "splm_active_po-anActive"){
			addPo = this.getAttribute('data-pointstate');
		}
	}
	function onMaskMouseMove( event ) {
        if ( isUserMaskInteracting === true ) {
        	var x  = event.clientX;
        	isUserAnActiveInteracting = false;
            if(event.clientX < $('#sandPoint').offset().left+ 329 || event.clientY < $('#sandPoint').offset().top+ 369 ){
            	if(addPo == 'true'){
            		$(this).parents('.sandPoint_list-main').css({'left':x -  $('#sandPoint').offset().left,'top': event.clientY - $('#sandPoint').offset().top});
            	} else {
            		$(this).parents('.sandPoint_list-main').css({'left':x - 8 -  $('#sandPoint').offset().left,'top': event.clientY-8 - $('#sandPoint').offset().top});
            	}
        	   
           }
        }
        
    }
	function onMaskMouseUp( event ) {
		isUserMaskInteracting = false;
		isUserAnActiveInteracting = false;
    }
	function onAnActiveMouseDown (){
		event.preventDefault();
		isUserAnActiveInteracting = true;
		isUserMaskInteracting = false;
		anActiveX = event.clientX;
		anActiveY = event.clientY;
	}
	function onAnActiveMouseMove( event ) {
        if ( isUserAnActiveInteracting === true ) {
        	isUserMaskInteracting = false;
        	moveAnActiveX = event.clientX;
        	moveAnActiveY = event.clientY;
        	var ele = $(this).parents('.moveDiv');
    		var tageEleX = ele.offset().left + ele.width()/2;
    		var tageEleY = ele.offset().top + ele.height()/2;
    		var quadrantX = moveAnActiveX - tageEleX;
    		var quadrantY = moveAnActiveY - tageEleY;
    		var to = Math.abs( quadrantX/quadrantY);
    		var  OutArray = Math.atan( to )/( 2 * Math.PI ) * 360;
    		if( quadrantX < 0 && quadrantY < 0)//相对在左上角，第四象限，js中坐标系是从左上角开始的，这里的象限是正常坐标系
    		{
    			OutArray = -OutArray;
			}else if( quadrantX < 0 && quadrantY > 0)//左下角,3象限
			{
				OutArray = -( 180 - OutArray )
			}else if( quadrantX > 0 && quadrantY < 0)//右上角，1象限
			{
				OutArray = OutArray;
			}else if( quadrantX > 0 && quadrantY > 0)//右下角，2象限
			{
				OutArray = 180 - OutArray;
			}
    		ele.css({'transform':'rotate('+ OutArray + 'deg)'});
    		ele.attr('data-rotate', OutArray);
        }
    }
	function onAnActiveMouseUp( event ) {
		isUserAnActiveInteracting = false;
		isUserMaskInteracting = false;
    }
	if($mask!=undefined){
		for(var i=0; i<$mask.length; i++){
			$mask[i].addEventListener( 'mousedown', onMaskMouseDown, false );
			$mask[i].addEventListener( 'mousemove', onMaskMouseMove, false );
			$mask[i].addEventListener( 'mouseup', onMaskMouseUp, false );
			$anActive[i].addEventListener( 'mousedown', onAnActiveMouseDown, false );
			$anActive[i].addEventListener( 'mousemove', onAnActiveMouseMove, false );
		}
		
		
		document.addEventListener( 'mouseup', onAnActiveMouseUp, false );
	}
}

 
/*
	沙盘场景列表
*/
 
 $('#sceneList dt').click(function(){
	 var backgroundImage = $('.add_planSet_layer_main-left').css('background-image');
	 var backgroundImageName=backgroundImage.substring(backgroundImage.lastIndexOf("/")+1,backgroundImage.lastIndexOf("."));
	 var defaultBackgroundImageName = 'sandUpDataImg',
	 	groupId = small_right_this.attr('data-id'),
		groupList = $('.small_whole_info ul'),
		html = "",
		addHml = $('#sceneList dl');
	 if(backgroundImageName!=defaultBackgroundImageName){
		 var _that = $(this);
		 if(_that.siblings('dl').is(':hidden')){
			 _that.addClass('active');
		 } else {
			 _that.removeClass('active'); 
		 }
		_that.siblings('dl').stop(true,true).slideToggle();
	 }
	 if(addHml.find('dd').length==0){
		 for(var i=0; i< groupList.length; i++){
			if(groupList.eq(i).attr('data-groupid') == groupId && groupList.eq(i).children('li').length>0 ){
				var currGroup = $(groupList[i]).find('li');
				for(var j=0; j < currGroup.length; j++){
					var sceneId = currGroup.eq(j).attr('data-id'),
						sceneThumbnail =  currGroup.eq(j).children('img').attr('src'),
						sceneName =  currGroup.eq(j).children('p').attr('title');
					html +='<dd data-sceneid="'+ sceneId +'"><img src="'+ sceneThumbnail +'"><span>'+ sceneName +'</span></dd>';
				}
			}
		}
		addHml.html(html);
	 }
	 
	 return false;
 });
 
 $('#sceneList').on('click','dd',function(){
	 var backgroundImage = $('.add_planSet_layer_main-left').css('background-image');
	 var backgroundImageName=backgroundImage.substring(backgroundImage.lastIndexOf("/")+1,backgroundImage.lastIndexOf("."));
	 var defaultBackgroundImageName = 'sandUpDataImg';
	if(backgroundImageName!=defaultBackgroundImageName){
		var _that = $(this),
			thisIndex = _that.attr('data-sceneId'),
			thisImageSrc = _that.find('img').attr('src'),
			thisSceneName = _that.find('span').html(),
			_copy = $('.add_planSet_layer_main_right_cont-copy');
			_that.parent().slideToggle();
			if(_that.parent().is(':hidden')){
				_that.parent().siblings('dt').addClass('active');
			 } else {
				 _that.parent().siblings('dt').removeClass('active'); 
			 }
			if(_copy !='undefined'){
				for(var i=0; i< _copy.length;i++){
					if(_copy.eq(i).attr('data-sceneId') == thisIndex){
						return;
					}
				}
				_copy.removeClass('active');
			var sceneListHtml = '<li class="add_planSet_layer_main_right_cont-copy active" data-sceneId="'+ thisIndex +'"><img src="'+ thisImageSrc +'" /><span>'+ thisSceneName +'</span><i alt="删除"></i></li>';
			var _mainId = document.getElementById('add_planSet_layer_main_right_cont-main').getElementsByTagName('ul')[0];
			_mainId.innerHTML += sceneListHtml;
			$('.splm_active-point').hide().parent('.moveDiv').siblings('.sandPoint_list_main-AC').show();
			var scenePointList = '<div class="sandPoint_list-main" style="left:50%; top:50%;transform: translate(-50%,-50%);" data-sceneId="'+ thisIndex +'"><div class="sandPoint_list_main-AC" style="display:none;"> <i></i> <div class="sandPoint_list_main-prompt">已将当前全景加入沙盘图 您可以： 拖动黄点设置位置 拖动尖头设置视角偏移</div></div><div class="moveDiv" data-rotate="0"><div class="splm_active-point" style="display:block;"><div class="splm_active_po-mask"></div><div class="splm_active_po-anActive" data-pointState ="true"></div></div></div></div>';
			var point = document.getElementById('sandPoint-list');
			point.innerHTML+= scenePointList;
			initSandPoint();
		}
	}
	
	return false;
});
 $('#add_planSet_layer_main_right_cont-main').on('click','li',function(){
	var _that = $(this),_index = 0,_copy = $('.sandPoint_list-main');
		_that.addClass('active').siblings().removeClass('active'); 
		for(var i=0; i< _copy.length;i++){
			if(_that.attr('data-sceneId') == _copy.eq(i).attr('data-sceneId')){
				$('.splm_active-point').hide();
				$('.sandPoint_list_main-AC').show();
				$('.sandPoint_list-main').eq(i).find('.sandPoint_list_main-AC').hide().siblings('.moveDiv').find('.splm_active-point').show();
				break;
			}
		}
		return false;
});
 $('#add_planSet_layer_main_right_cont-main').on('click','i',function(){
	var _that = $(this);
	alertbox({
		msg:$('.right_del_mian').html(),
		tcallfn_tx:'确认',
		tcallfn:function(){
			var _copy = $('.sandPoint_list-main');
			for(var i=0; i< _copy.length;i++){
				if(_that.parents('li').attr('data-sceneId') == _copy.eq(i).attr('data-sceneId')){
					_copy.eq(i).remove();
					_that.parent().remove();
					break;
				}
			}
		}
	});
	return false;
});
 
/*
	上传平面图
*/

$('#sandTableImageFile').change(function(data){
	var sandImageFile = document.getElementById('sandTableImageFile');
	var formData = new FormData(),
		fileWidth = 600,
		fileHeight = 600,
		fileSize = 200,
		allowExtention="/jpg,/jpeg,/png";//允许上传文件的后缀名
	formData.append('file',sandImageFile.files[0]);
	formData.append('linkerId',$('input[name="linkerId"]').val());
	var reader = new FileReader();
	if(sandImageFile.files[0].type !="" && sandImageFile.files[0].type.indexOf('/jpg') > 0 || sandImageFile.files[0].type.indexOf('/jpeg')>0 || sandImageFile.files[0].type.indexOf('/png')> 0 ){
		reader.onload = function (e) {
	       var data = e.target.result;
	       //加载图片获取图片真实宽度和高度
	       var image = new Image();
	       image.onload=function(){
	      	 var width = image.width;
	         var height = image.height;
	         if(width!=fileWidth||height!=fileHeight){
	        	 alert('上传图片尺寸错误');
	     		 return false;
	         }else if(e.total/1024 > fileSize){
	        	alert('上传小于200K的图片');
	      		return false;
	         }else if(width== fileWidth|| height== fileHeight || (allowExtention.indexOf(extention)>-1) || e.total/1024 < fileSize){
	        	 $.ajax({
	      	       type: "POST",
	      	       url: "${backPath}/pano/sandTable/uploadfile",
	      	       data:formData,
	      	       processData: false,
	      	       contentType: false,
	      	       success: function (res) {
	      	    	   if(res.returnCode=="SUCCESS"){
	      	   				var result=res;
	      	   	    		$(".add_planSet_layer_main-left").css({"background-image":"url('"+result.cosData.access_url+"')","background-size":"contain"});
	      	   	    		$(".add_planSet_layer_main_left-upData").hide();
	      	   	    		$(".remImgUrl").show();
	      	   			}
	      	       },
	      	       error: function(data) {
	      	       }
	      	   });
	         }
	       };
	       image.src= data;
	   };
	} else {
		alert('上传jpg,jpeg,png格式的图片');
 		return false;
	}
    
   reader.readAsDataURL(sandImageFile.files[0]);
   
	/* $(this).fileupload({
		url : "${backPath}/pano/sandTable/uploadfile",
		dataType : 'json',
		autoUpload: false,
		add : function(e, data) {
			console.log(00);
			var allowExtention=".jpg,.png";//允许上传文件的后缀名
			var extention=data.fileInput.context.value.substring(data.fileInput.context.value.lastIndexOf(".")+1).toLowerCase();
			if(!(allowExtention.indexOf(extention)>-1)){
				alert('上传jpg,png格式的图片');
				return false;
			}
			data.submit();
		},
		start: function (e) {
		   // $("#progress").show();
		},
		done : function(e, data) {
		    //$("#progress").hide();
		    var result=data.result;
		    if(result.returnCode=="SUCCESS"){
		    	sandTableImgPath=result.cosData.resource_path;
		    	$(".add_planSet_layer_main-left").css("background-image","url('"+result.cosData.access_url+"')");
		    	$(".add_planSet_layer_main_left-upData").hide();
		    	$(".remImgUrl").show();
		    }else{
		    }
		},
		progressall: function (e, data) {
			//var progress = parseInt(data.loaded / data.total * 100, 10);
		    // $('#progress .bar').css('width',progress + '%');
		}
	}); */
});

 
//上一步
function backhref(){
	window.location.href = "${siteRoot}/object/toaddObject?id=${linkerId}";
}
//预览
function forwarddetails(){
	if($('.big_whole li').length ==0){
		alert('请上传一张全景图');
		return false;
	}
	$('#forwardiframe').attr('src',"${siteRoot}/linker/${linkerId}");
    $('#delforwardiframemian').show();
} 
//保存并下一步
function addrightButton(){
	if($('.big_whole li').length ==0){
		alert('请上传一张全景图');
		return false;
	}
	window.location.href = "${siteRoot}/object/toAddButton?id=${linkerId}";
}
$('.right_moudown_nav .point_setting').click(function(){
	pointSetting(small_right_this);
});
function pointSetting(ele){
	$(".mask").css("display","block");
	$("body").css("overflow","hidden");
	var sceneId=$(ele).data("id");
	$('#point_setting').show(function(){
		var iframeWnd = document.getElementById("point_setting").contentWindow;
		iframeWnd.postMessage({
	        linkerId:linkerId
	    }, "*");
	}).attr('src','${backPath}/pano/point/setting?albumId='+albumId+"&sceneId="+sceneId);
	
}

$('.right_moudown_nav .scene_preview').click(function(){
	$(".mask").css("display","block");
	$("body").css("overflow","hidden");
	var sceneId=$(small_right_this).data("id");
	$('#scene_preview').show().attr('src','${siteRoot}/pano/preview/'+albumId+"#id="+sceneId);
});
$('body').on('focus','.edit_tx',function(e){
	$('.small_whole li').unbind('mousedown');
	oldSceneGroupName = $(this).html().trim();
});
//失去焦点更改场景组名称
$('body').on('blur','.edit_tx',function(e){
	$('.small_whole li').bind('mousedown',bindmosedown);
	$(this).prop('contenteditable',false);
	var name=$(this).text().trim();
	if(name.length>10){
		name = name.substr(0,10).trim();
		$(this).text(name);
		alert('组名小于等于10个字符');
		return;
	}
	if(oldSceneGroupName==$(this).html().trim()){
		return;
	}else if(oldSceneGroupName!="" && $(this).html().trim()==""){
		$(this).html(oldSceneGroupName);
		return;
	} else if(oldSceneGroupName =='' && $(this).html().trim() ==''){
		$(this).parents('li').remove();
		return;
	}
	
	if(name.replace(/&nbsp;/g,"").trim()==""){
		$(this).parents('li').remove();
		return;
	}
	
	var groupId=$(this).data("id");
	if(groupId==undefined){
		groupId="";
	}
	console.log(name);
	saveSceneGroup(groupId,name,$(this));
	
});
//回车默认修改名字
$('body').on('keypress','.edit_tx',function(e){
	if(e.which == 13) {  
		$(this).blur();
	}
});
var _saveSceneGroup=false;
//保存场景组
function saveSceneGroup(id,name,ele){
	if(_saveSceneGroup){
		return;
	}
	_saveSceneGroup=true;
	d={
		"id":id,
		"name":name,
		"album.id":albumId
	};
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scenegroup/save",d,function(data){
		if(data.returnCode=="SUCCESS"){
			//location.reload();
			//location.href='?id='+stage.id+'&group='+ele.index()
			//console.log(location.hostname+location.pathname+'?id='+stage.id)
		}else{
			alert(data.returnMsg);
			$(ele).html(oldSceneGroupName);
			if(oldSceneGroupName==""){
				$(ele).parents('li').remove();
			}
		}
		_saveSceneGroup=false;
	});
}

$(function(){
	//删除场景分组或场景
	$('.right_nav_del').click(function(){
		$('.right_click_nav').hide();
		alertbox({
			msg:$('.right_del_mian').html(),tcallfn_tx:'删除',
			tcallfn:function(){
				var _this=small_right_this,
					groupId = $(_this).data("id");
				console.log(groupId);
				var type=$(_this).data("type");
				console.log("type:"+type);
				if(type=="sceneGroup"){
					var id=$(_this).data("id");
					deleteSceneGroup(id);
				}else if(type=="scene"){
					var sceneGroupId = $(_this).parents('ul').attr('data-groupid');
					if(sceneGroupId!=undefined){
						deleteScene(chooseSceneIdList,sceneGroupId);
					} else {
						deleteScene(chooseSceneIdList)
					}
				}else{
					return;
				}
			}
		});
	});
	$('.small_right_click_nav .right_nav_del').click(function(){
		$('.right_click_nav').hide();
		alertbox({
			msg:$('.right_del_mian_del').html(),tcallfn_tx:'删除',
			tcallfn:function(){
				var _this=small_right_this;
				var type=$(_this).data("type");
				if(type=="sceneGroup"){
					var id =$(_this).data("id");
					deleteSceneGroup(id);
				}else if(type=="scene"){
					deleteScene(chooseSceneIdList);
				}else{
					return;
				}
			}
		});
	});
	
});
//删除场景分组
function deleteSceneGroup(id){
	var d={"id":id};
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scenegroup/delete",d,function(data){
		if(data.returnCode=="SUCCESS"){
			location.reload();
		}else{
			alert(data.returnMsg);
		}
	}); 
}
//删除场景
function deleteScene(ids,sceneGroupId){
	var d;
	if(sceneGroupId !=undefined){
		d={"ids":ids.join(","),"sceneGroupId":sceneGroupId};
	} else {
		d={"ids":ids.join(",")};
	}
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scene/delete",d,function(data){
		if(data.returnCode=="SUCCESS"){
			location.reload();
		}else{
			alert(data.returnMsg);
		}
	});
}

$(function(){
	//向前移动场景事件
	$('.forwardShiftScene').click(function(){
		$('.right_moudown_nav').hide();
		var ele=small_right_this;
		sceneSwapSort($(ele).prev(),ele);
		$(ele).removeClass('cur');
	});
	
	//向后移动场景事件
	$('.backwardShiftScene').click(function(){
		$('.right_moudown_nav').hide();
		var ele=small_right_this;
		sceneSwapSort(ele,$(ele).next());
		$(ele).removeClass('cur');
	});
});

//场景互换排序
function sceneSwapSort(one,two){
	if(one.length==0||two.length==0){
		return
	}
	var oneSort=$(one).data("sort");
	var twoSort=$(two).data("sort");
	if(oneSort==undefined||twoSort==undefined){
		return;
	}
	var d={
		"one.id":$(one).data("id"),
		"one.sort":oneSort,
		"two.id":$(two).data("id"),
		"two.sort":twoSort
	};
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scene/swapSort",d,function(data){
		if(data.returnCode=="SUCCESS"){
			$(one).data("sort",twoSort);
			$(two).data("sort",oneSort);
			$(two).insertBefore($(one));  
		}else{
			alert(data.returnMsg);
		}
	});	
}

$(function(){
	//向前移动场景组事件
	$('.forwardShiftSceneGroup').click(function(){
		$('.right_moudown_nav').hide();
		var ele=small_right_this;
		sceneGroupSwapSort($(ele).prev(),ele);
		$(ele).removeClass('cur');
	});
	
	//向后移动场景组事件
	$('.backwardShiftSceneGroup').click(function(){
		$('.right_moudown_nav').hide();
		var ele=small_right_this;
		sceneGroupSwapSort(ele,$(ele).next());
		$(ele).removeClass('cur');
	});
});

//场景组互换排序
function sceneGroupSwapSort(one,two){
	if(one.length==0||two.length==0){
		return;
	}
	var oneSort=$(one).data("sort");
	var twoSort=$(two).data("sort");
	if(oneSort==undefined||twoSort==undefined){
		return;
	}
	var d={
		"one.id":$(one).data("id"),
		"one.sort":oneSort,
		"two.id":$(two).data("id"),
		"two.sort":twoSort
	};
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scenegroup/swapSort",d,function(data){
		if(data.returnCode=="SUCCESS"){
			$(one).data("sort",twoSort);
			$(two).data("sort",oneSort);
			$(two).insertBefore($(one));  
		}else{
			alert(data.returnMsg);
		}
	});	
}

$(function(){
	//设为封面事件
	$('.alert_small_right_banner').click(function(){
		$('.right_moudown_nav').hide();
		var ele=small_right_this;
		toCoverImg(ele);
		$(ele).removeClass('cur');
	});
	
});


// 设为分组封面
function toCoverImg(ele){
	var d={"id":$(ele).data("id")};
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scene/toCoverImg",d,function(data){
		if(data.returnCode=="SUCCESS"){
			$(ele).data("sort",data.curSort);
			$(ele).parent().prepend($(ele));
			var coverImgUrl=$(ele).find("img").attr("src");
			$(".small_whole li").eq($(ele).parent().index()+1).find("img").attr("src",coverImgUrl);
		}else{
			alert(data.returnMsg);
		}
	});	
}
var labelListId;
//分组更改封面
$('.small_right_nav_xiu').click(function(){
	var curGroupId = small_right_this.attr('data-id');
	var len = $(".small_whole_info ul[data-groupid='"+curGroupId+"']").children().length;
	if(len>0){
		var small_banner_html = '<form class="small_banner_form">'+
	    '<p class="alert_title">更改封面</p>'+
	    '<div class="mr20 mt20 mb10 ml20 clear">';
		$('.small_whole_info').find('ul').eq(small_right_this.index()-1).find('li').each(function(){
			 small_banner_html +='<label class="fl mr10" data-index='+small_right_this.index()+'>'+
	         '<img src="'+$(this).find('img').attr('src')+'"  class="fl" width="80" height="80"/>'+
	         '<input type="radio" name="small_banner_img" class="hide_com">'+
	         '</label>';
		});
		small_banner_html +='</div></form>';
		alertbox({msg:small_banner_html,
			tcallfn:function(){
				toCoverImg(labelListId);
			}
		});
	}
	
});
$('body').on('click','#alretboxmian .small_banner_form label',function(e){
	e.stopPropagation();
	var Listindex = $(this).data("index");
	console.log(Listindex);
	labelListId = $('.small_whole_info ul').eq(Listindex-1).find('li').eq($(this).index());
	console.log(labelListId);
	$(this).addClass('cur').siblings().removeClass('cur');
});

$(function(){
	//更改分组事件
	$('.alert_small_right_info_edit').click(function(){
		alertbox({msg:$('.small_right_info_com').html(),
			tcallfn:function(){
				var sceneGroupId=$("#alretboxmian .sceneGroup").val();
				if(sceneGroupId==curSceneGroupId){
					return;
				}
				var d={
					"ids":chooseSceneIdList.join(","),
					"sceneGroupId":sceneGroupId	
				};
				changeGroup(d);
			}
		});
		$("#alretboxmian .sceneGroup option[value='"+curSceneGroupId+"']").remove();
	});
});
//更改分组
function changeGroup(d){
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scene/changeGroup",d,function(data){
		if(data.returnCode=="SUCCESS"){
			setFirstSceneToCoverImg(curSceneGroupId);
		}else{
			alert(data.returnMsg);
		}
	});	
}
function setFirstSceneToCoverImg(id){
	var d={id:id};
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scenegroup/setFirstSceneToCoverImg",d,function(data){
		if(data.returnCode=="SUCCESS"){
			location.reload();
		}else{
			alert(data.returnMsg);
		}
	});	
}
var scene_image_change=false;
var update_scene_id;
var new_name;
var new_des;
//编辑场景事件
$('.alert_bianji').click(function(){
	var ele=small_right_this;
	editScene(ele);
});

function editScene(ele){
	update_scene_id=$(ele).data("id");
	var name=$("input[name='name']",$(ele)).val();
	var des=$("input[name='des']",$(ele)).val();
	var imgUrl=$("input[name='imgUrl']",$(ele)).val();
	var thumbnailUrl=$("input[name='thumbnailUrl']",$(ele)).val();
	alertbox({msg:$('.edit_com').html(),
		tcallfn:function(){
			new_name=$("#alretboxmian .edit_scene_name").val();
			if(new_name.length==0){
				alert("场景名称不能为空");
				return;
			}
			new_des=$("#alretboxmian .edit_scene_des").val();
			$("#alretboxmian .uploadimg_com_waring_tx").hide();
			$("#ajaxload").show();
			if(scene_image_change){
				uploadImage();
			}else{
				var d={
					id:update_scene_id,
					name:new_name,
					des:new_des,
					imgUrl:imgUrl,
					thumbnailUrl:thumbnailUrl
				};
				updateScene(d);
			}
		}
	});
	
	$("#alretboxmian .edit_scene_name").val(name);
	$("#alretboxmian .edit_scene_des").val(des);
	$("#alretboxmian .edit_scene_thumbnailUrl").attr("src",cosAccessHost+thumbnailUrl);
}

function updateScene(d){
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scene/update",d,function(data){
		if(data.returnCode=="SUCCESS"){
			location.reload();
		}else{
			alert(data.returnMsg);
		}
		$("#ajaxload").hide();
	});
}
$(function(){
	$("body").on("click",'.edit_scene_thumbnailUrl', function() {
		$('.edit_fileupload').click();
	})
	$("body").on("click",'.edit_fileupload', function() {
		$(this).fileupload({
			url : "${backPath}/pano/scene/fileupload",
			dataType : 'json',
			autoUpload: false,
			add : function(e, data) {
				jqXHR=data;
				console.log(data)
  		      	var allowExtention=".jpg,.jpeg,.bmp,.gif,.png";//允许上传文件的后缀名
				var extention=data.fileInput.context.value.substring(data.fileInput.context.value.lastIndexOf(".")+1).toLowerCase();
				if(!(allowExtention.indexOf(extention)>-1)){
					alert('上传正确的图片');
					jqXHR= null;
					$("#alertboxbg").remove();
      		        $("#alretboxmian").remove();
					return false;
				}
				$("#alertboxbg").show();
  		        $("#alretboxmian").show();
				var loadimg= $('#alretboxmian .load_img_com');
				if (navigator.userAgent.indexOf("MSIE")>=1) { // IE
					loadimg.attr('src',data.fileInput.context.value);
				} else {
					loadimg.attr( 'src',window.URL.createObjectURL(data.files[0]));
				}
				scene_image_change=true;
				//data.submit();
			},
			start: function (e) {
			   // $("#progress").show();
			},
			done : function(e, data) {
			    //$("#progress").hide();
			    var result=data.result;
			    if(result.returnCode=="SUCCESS"){
			    	d={
			    		id:update_scene_id,
			    		name:new_name,
			    		des:new_des,
			    		"imgUrl":result.imgUrl,
			    		"thumbnailUrl":result.thumbnailUrl,
			    	};
			    	updateScene(d);
			    }else{
			    	$("#ajaxload").hide();
			    	$("#alretboxmian .uploadimg_com_waring_tx").show().html(result.returnMsg);
			    }
			},
			progressall: function (e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
			   // $('#progress .bar').css('width',progress + '%');
			}
		});
	 });
});

//基本信息事件
$('.alert_basic').click(function(){
	var ele=small_right_this;
	showInfo(ele);
});
function showInfo(ele){
	var id=$(ele).data("id");
	var name=$("input[name='name']",$(ele)).val();
	var des=$("input[name='des']",$(ele)).val();
	var createtime=$("input[name='createTime']",$(ele)).val();
	alertbox({msg:$('.basic_com').html(),alerttap:0,
		tcallfn:function(){
		}
	});
	$("#alretboxmian .info_scene_name").val(name);
	$("#alretboxmian .info_scene_des").val(des);
	$("#alretboxmian .info_scene_id").html(id);
	$("#alretboxmian .info_scene_createtime").html(createtime);
}
//底部logo事件
$('.alert_bottomLogo').click(function(){
	var ele=small_right_this;
	editBottomLogo(ele);
});

function editBottomLogo(ele){
	var bottomLogo=$("input[name='bottomLogo']",$(ele)).val();
	$("body").on("click",'#alretboxmian .lianjieqidelte', function() {
		$("input[name='bottomLogo']",$(ele)).val('');
		$('#alretboxmian img').attr('src','${backStatic}/images/img_logo.png')
		return false;
	})
	alertbox({msg:$('.uplogoimg_com').html(),
		tcallfn:function(){
			console.log(bottomLogo)
			console.log($("input[name='bottomLogo']",$(ele)).val())
			if(bottomLogo!="" && $("input[name='bottomLogo']",$(ele)).val()==""){
				var d={
			    	"id":$(ele).data("id"),	
			    	"bottomLogo":""
			    };
				updateBottomLogo(d);
			}else{
				if(!($('#alretboxmian img').attr('src').indexOf(bottomLogo) > 0)){
					uploadImage();
				}
			}
		},fcallfn:function(){
        	location.reload();
        }
	});
	if(bottomLogo!=""){
		$("#alretboxmian .load_img_com").attr("src",cosAccessHost+bottomLogo);
	}
}

function updateBottomLogo(d){
	d.linkerId=linkerId;
	$.post("${backPath}/pano/scene/updateBottomLogo",d,function(data){
		if(data.returnCode="SUCCESS"){
			location.reload();
		}else{
			alert(data.returnMsg);
		}
	});
}

$(function(){
	$("body").on("click",'.bottomLogoFileupload_img', function() {
		$('.bottomLogoFileupload').click();
	})
	$("body").on("click",'.bottomLogoFileupload', function() {
		$(this).fileupload({
			url : "${backPath}/pano/scene/bottomLogoFileupload",
			dataType : 'json',
			autoUpload: false,
			add : function(e, data) {
				jqXHR=data;
  		      	var allowExtention=".jpg,.jpeg,.bmp,.gif,.png";//允许上传文件的后缀名
				var extention=data.fileInput.context.value.substring(data.fileInput.context.value.lastIndexOf(".")+1).toLowerCase();
				if(!(allowExtention.indexOf(extention)>-1)){
					alert('上传jpg,jpeg,bmp,gif,png格式的图片');
					jqXHR= null;
					$("#alertboxbg").remove();
      		        $("#alretboxmian").remove();
					return false;
				}
				$("#alertboxbg").show();
  		        $("#alretboxmian").show();
				var loadimg= $('#alretboxmian .load_img_com');
				if (navigator.userAgent.indexOf("MSIE")>=1) { // IE
					loadimg.attr('src',data.fileInput.context.value);
				} else {
					loadimg.attr( 'src',window.URL.createObjectURL(data.files[0]));
				}
				//data.submit();
			},
			start: function (e) {
			   // $("#progress").show();
			},
			done : function(e, data) {
			    //$("#progress").hide();
			    var result=data.result;
			    if(result.returnCode=="SUCCESS"){
			    	var ele=small_right_this;
			    	var d={
			    		"id":$(ele).data("id"),	
			    		"bottomLogo":result.imgUrl
			    	};
			    	updateBottomLogo(d);
			    	
			    }else{
			    	$("#ajaxload").hide();
			    	$("#alretboxmian .uploadimg_com_waring_tx").show().html(result.returnMsg);
			    }
			},
			progressall: function (e, data) {
				var progress = parseInt(data.loaded / data.total * 100, 10);
			   // $('#progress .bar').css('width',progress + '%');
			}
		});
	 });
});
</script>
</body>
</html>