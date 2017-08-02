
function bindmosedown(e){
	e.preventDefault()
	e.stopPropagation()
	if(e.which == 3){
		var href="";
		if(window.location.href.indexOf("?")>0){
			href=window.location.href.replace(/(\&group=\d)/,'')+'&group=0';
		}else{
			href=window.location.href.replace(/(\?group=\d)/,'')+'?group=0';
		}
		window.history.pushState('', '', href);
		if($(this).index()>0) {
			$('.small_right_click_nav').css({'left': e.pageX, 'top': e.pageY}).show();
			$('.small_right_click_nav li').show()
			small_right_this = $(this)
		}

	}
	if(e.which == 1){
		var href="";
		if(window.location.href.indexOf("?")>0){
			href=window.location.href.replace(/(\&group=\d)/,'')+'&group='+$(this).index();
		}else{
			href=window.location.href.replace(/(\?group=\d)/,'')+'?group='+$(this).index();
		}
		window.history.pushState('', '', href);
		if($(this).index()>0){
			var edit_tx= '分组<i></i>'+$(this).find('.edit_tx').html();
			curSceneGroupId = $(this).data('id');
			$('#tab_nav_xie').html(edit_tx).show()
			leftKeyCurSceneGroudId = curSceneGroupId;
			$('.tabmian > ul').hide()
			$('.small_whole_info').show().find('ul').hide().eq($(this).index()-1).show()
		}else{
			var small_whole_li = '<li>'+
				'<img src="'+backStatic+'/images/b.png" class="fl"/>'+
				'<p class="fl tx_over">'+
				'<i class="whole_img_file"></i><i class="edit_tx"></i>'+
				'</p>'+
				'<i class="list2_icon_cur"></i>'+
				'</li>'
			$('.small_whole').append($(small_whole_li))
			$('.small_whole li').unbind('mousedown')
			$('.small_whole li').bind('mousedown',bindmosedown)
			small_right_this=$('.small_whole li:last-child')
			$('.small_whole li:last-child').find('.edit_tx').prop('contenteditable',true).focus()

		}
	}
}
function smallrightbindmosedown(e){
	e.preventDefault()
	e.stopPropagation()
	var id=$(this).data("id");
	var ulidx = $(this).parent('ul').index()
	var liidx = $(this).index()
	if(e.which == 3){
		small_right_this = $(this)
		if($(this).is('.cur')){
			$('.small_right_info_click_nav').css({'left':e.pageX,'top':e.pageY}).show();
			if($(this).is('.cur')){
				if(small_right_info_cunt >=1){
					$('.small_right_info_click_nav li').hide().eq(1).show()
					$('.small_right_info_click_nav li:last-child').show()
				}else{
					$('.small_right_info_click_nav li').show();
					if(small_right_this.index() ==0){
						$('.small_right_info_click_nav li').hide().eq(1).show().end().eq(4).show()
					}else if(small_right_this.index() ==1 && small_right_this.index() == small_right_this.siblings('li').length){
						$('.small_right_info_click_nav li').eq(2).hide().end().eq(3).hide()
					}else if(small_right_this.index() ==1){
						$('.small_right_info_click_nav li').eq(2).hide()
					}else if(small_right_this.index() == small_right_this.siblings('li').length){
						$('.small_right_info_click_nav li').eq(3).hide()
					}
				}
			}
		}else{
			chooseSceneIdList=[];
			chooseSceneIdList.push(id);
			$(this).siblings('li').removeClass('cur')
			$(this).addClass('cur')
			small_right_info_cunt=0
			$('.small_right_info_click_nav').css({'left':e.pageX,'top':e.pageY}).show();
			$('.small_right_info_click_nav li').show()
			if(small_right_this.index() ==0){
				$('.small_right_info_click_nav li').hide().eq(1).show().end().eq(0).show().end().eq(4).show().end().eq(3).show()
			}else if(small_right_this.index() ==1 && small_right_this.index() == small_right_this.siblings('li').length){
				console.log(112)
				$('.small_right_info_click_nav li').eq(3).hide()
			}else if(small_right_this.index() ==1){
				console.log(11)
				$('.small_right_info_click_nav li').eq(3).hide()
			}else if(small_right_this.index() == small_right_this.siblings('li').length){
				$('.small_right_info_click_nav li').eq(3).hide()
			}
		}
	}else if(e.which == 1){
		$('.small_right_info_click_nav').hide();
		if($(this).is('.cur')){
			for(var i=0;i<chooseSceneIdList.length;i++){
				if(chooseSceneIdList[i]==id){
					chooseSceneIdList.splice(i,1);
					break;
				}
			}
			$(this).removeClass('cur');
			--small_right_info_cunt;
		}else{
			chooseSceneIdList.push(id);
			$(this).addClass('cur');
			++small_right_info_cunt;
		}
	}
}
//更改分组
function changeGroup(d){
	$.post(backPath+"/file/image/changeGroup",d,function(data){
		if(data.returnCode=="SUCCESS"){
			window.location.reload();
		}else{
			alert(data.returnMsg);
		}
	});	
}
//保存场景组
function fileRename(id,name,ele){
	if(_saveSceneGroup){
		return;
	}
	_saveSceneGroup=true;
	d={
		"id":id,
		"name":name
	};
	$.post(backPath+"/file/image/rename",d,function(data){
		if(data.returnCode=="SUCCESS"){
			//location.reload();
		}else{
			alert(data.returnMsg);
		}
		_saveSceneGroup=false;
	});
}


//保存场景组
function saveFileGroup(id,name,ele){
	if(_saveSceneGroup){
		return;
	}
	_saveSceneGroup=true;
	d={
		"id":id,
		"name":name
	};
	console.log(ele.index());
	$.post(backPath+"/file/fileGroup/save",d,function(data){
		if(data.returnCode=="SUCCESS"){
			window.location.reload();
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
//互换排序
function fileSwapSort(one,two){
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
	$.post(backPath+"/file/image/swapSort",d,function(data){
		if(data.returnCode=="SUCCESS"){
			$(one).data("sort",twoSort);
			$(two).data("sort",oneSort);
			$(two).insertBefore($(one));  
		}else{
			alert(data.returnMsg);
		}
	});	
}
//删除场景分组
function deleteFileGroup(id){
	 $.post(backPath+"/file/fileGroup/delete",{"id":id},function(data){
		if(data.returnCode=="SUCCESS"){
			location.reload();
		}else{
			alert(data.returnMsg);
		}
	}); 
}
//删除场景
function deleteFile(ids){
	$.post(backPath+"/file/image/delete",{"ids":ids.join(",")},function(data){
		if(data.returnCode=="SUCCESS"){
			location.reload();
		}else{
			alert(data.returnMsg);
		}
	});
}
//上传
function secneupfileimg(result){
	var successfilelists = result ? result : successfilelist
    function _create(amgumentfile) {
    	var URL = window.URL || window.webkitURL;
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
	        ajaxfileimgarr.push($.ajax({
	            type: "POST",
	            url: backPath+"/pano/scene/fileupload",
	            data: fd,
	            processData: false,
	            contentType: false,
	            success: function (res) {
	            	var result=res;
	    		    if(result.returnCode=="SUCCESS"){
	    		    	var sceneGroupId=sceneGroupIds;
	    		    	d={
	    		    		"name":result.fileName,
	    		    		"resourcePath":result.imgUrl,
	    		    		"thumbnailPath":result.thumbnailUrl,
	    		    		"group.id":sceneGroupId,
	    		    	};
	    		    	saveImage(d);
	    		    }else{
	    		    	$("#ajaxload").hide();
	    		    	$("#alretboxmian .uploadimg_com_waring_tx").show().html(result.returnMsg);
	    		    	$(".uploadstar_list li").eq(successfilelist).find('.loadbg').hide()
		            	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i style="color:#ff5050">'+result.returnMsg+'</i>')
						$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html('')
						$(".uploadstar_list li").eq(successfilelist).find('.londingclose').hide()
				    	$("#ajaxload").hide();
				    	$("#alretboxmian .uploadimg_com_waring_tx").show().html(result.returnMsg);
				    	clearInterval(loadtimes)
				    	loadtoal=70
				    	successfilelist++
				    	loadtimes = false
				    	if(successfilelist==ajaxfileimgarr.length){
				    		location.reload()
				    	}
				    	secneupfileimg()
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
				            	 $(".uploadstar_list li").eq(successfilelists).find('.uploadstar_list_m').html('0.5MB/S')
				            	if(loadtoal <=99 ){
    				            	loadtoal+= 0.5
    				            	$(".uploadstar_list li").eq(successfilelists).find('.loadbg').css('width',loadtoal+'%')
        			            	$(".uploadstar_list li").eq(successfilelists).find('.uploadstar_list_tx').html('<i>'+loadtoal+'%</i>')
				            	} else if (!isNaN(loadtoal)){
				            		clearInterval(loadtimes);
				            		alert('请检查网络是否正常链接！');
				            	}
				            }, 1000)
		            	}
			        }else{
	                	$(".uploadstar_list li").eq(successfilelists).find('.loadbg').css('width',percent+'%')
		                $(".uploadstar_list li").eq(successfilelists).find('.uploadstar_list_tx').html('<i>'+percent.toFixed(2)+'%</i>')
		                $(".uploadstar_list li").eq(successfilelists).find('.uploadstar_list_m').html(((((e.total)/1024)/1024)/(stmes)).toFixed(2)+'MB/S')
	                }
	             }),
	            error: function(data) {
	            }
	        })
	       )
	    }
    }
    // 生成结果
   _create(fileimgarr[successfilelists]) 
}
//保存上传图片
function saveImage(d){
	$.post(backPath+"/file/image/save",d,function(data){
		if(data.returnCode=="SUCCESS"){
			if(successfilelist < fileimgarr.length){
				loadtoal = 70
				clearInterval(loadtimes)
				loadtimes =false
				$(".uploadstar_list li").eq(successfilelist).find('.loadbg').hide()
            	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i style="color:#16d38e">完成</i>')
				$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html('')
				$(".uploadstar_list li").eq(successfilelist).find('.londingclose').hide()
			}
		}else{
			loadtoal = 70
			clearInterval(loadtimes)
			loadtimes =false
			$(".uploadstar_list li").eq(successfilelist).find('.loadbg').hide()
        	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i style="color:#ff5050">失败</i>')
			$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_m').html('')
			$(".uploadstar_list li").eq(successfilelist).find('.londing').show()
			$(".uploadstar_list li").eq(successfilelist).find('.londingclose').hide()
			$("#alretboxmian .uploadimg_com_waring_tx").show().html(data.returnMsg);
			//alert(data.returnMsg);
		}
		if(successfilelist == (fileimgarr.length-1)){
			location.reload();
		}
		successfilelist++
		$('.uploadstar_mian .alert_title_upinggrup').html(successfilelist+'/'+fileimgarr.length)
		secneupfileimg()
		
	});
}
$(function(){
	
	if(stage.group>0){
		$('.small_whole_info').show()
		$('.small_whole_info ul').eq(stage.group-1).show()
		$('#tab_nav_xie').show()
	}else{
		$('.small_whole').show()
		$('#tab_nav_xie').hide()
	}
	
	$('body').on('click',function(){
		$('.small_right_click_nav').hide()
		$('.small_right_info_click_nav').hide()
	})
	
	//    分组邮件
	$('.small_whole li').bind("contextmenu",function(e){
		return false;
	});
	$('.small_whole li').bind('mousedown',bindmosedown)
	//分组详细右键
	$('.small_right_click_nav').bind("contextmenu",function(e){
		return false;
	});
	$('.small_whole_info li').bind("contextmenu",function(e){
		return false;
	});
	 
	$('.small_right_info_click_nav').bind("contextmenu",function(e){
		return false;
	});
	$('.small_whole_info li').bind('mousedown',smallrightbindmosedown)
	$('body').on('focus','.edit_tx',function(e){
		$('.small_whole li').unbind('mousedown');
		$('.small_whole_info li').unbind('mousedown');
		oldSceneGroupName=$(this).html().trim();
	});
	//失去焦点更改场景组名称
	$('body').on('blur','.edit_tx',function(e){
		var name = $(this).html().trim().replace(/<[^>]+>/g,"");
		$('.small_whole li').bind('mousedown',bindmosedown);
		$('.small_whole_info li').bind('mousedown',smallrightbindmosedown);
		$(this).prop('contenteditable',false);
		if(oldSceneGroupName =='' && name ==''){
			$(this).parents('li').remove();
			return;
		}
		if(name.replace(/&nbsp;/g,"").trim()==""){
			$(this).parents('li').remove();
			return;
		}
		if(name.length>10){
			name = name.substr(0,10).trim(); 
		}
		
		if(name==oldSceneGroupName){
			return;
		}
		
		var groupId=$(this).data("id");
		if(groupId==undefined){
			groupId="";
		}
		if($(this).parents('.small_whole_info ').length !=0){
			fileRename(groupId,name,$(this));
		}else{
			saveFileGroup(groupId,name,$(this));
		}
	});
	//回车默认修改名字
	$('body').on('keypress','.edit_tx',function(e){
		if(e.which == 13) {  
			$(this).blur();
		}
	});
	
	$('.forwardShiftScene').click(function(){
		$('.right_moudown_nav').hide();
		var ele=small_right_this;
		fileSwapSort($(ele).prev(),ele);
		$(ele).removeClass('cur');
	});
	
	//向后移动场景事件
	$('.backwardShiftScene').click(function(){
		$('.right_moudown_nav').hide();
		var ele=small_right_this;
		fileSwapSort(ele,$(ele).next());
		$(ele).removeClass('cur');
	});
	
	//删除场景分组或场景
	$('.right_nav_del').click(function(){
		$('.right_click_nav').hide();
		alertbox({
			msg:$('.right_del_mian').html(),tcallfn_tx:'删除',
			tcallfn:function(){
				var _this=small_right_this;
				console.log(_this)
				var type=$(_this).data("type");
				console.log("type:"+type);
				if(type=="sceneGroup"){
					var id=$(_this).data("id");
					deleteFileGroup(id);
				}else if(type=="scene"){
					deleteFile(chooseSceneIdList);
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
				console.log(_this)
				var type=$(_this).data("type");
				console.log("type:"+type);
				if(type=="sceneGroup"){
					var id=$(_this).data("id");
					deleteFileGroup(id);
				}else if(type=="scene"){
					deleteFile(chooseSceneIdList);
				}else{
					return;
				}
			}
		});
	});
	$('.small_right_click_nav .del_group').click(function(){
		$('.right_click_nav').hide();
		alertbox({
			msg:$('.right_del_mian_del').html(),tcallfn_tx:'删除',
			tcallfn:function(){
				var _this=small_right_this;
				console.log(_this)
				var type=$(_this).data("type");
				console.log("type:"+type);
				if(type=="sceneGroup"){
					var id=$(_this).data("id");
					deleteFileGroup(id);
				}else if(type=="scene"){
					deleteFile(chooseSceneIdList);
				}else{
					return;
				}
			}
		});
	});
	$('.camear_head span').click(function(){
		$('.small_whole_info').hide();
		$('.small_whole').show();
		$('#tab_nav_xie').hide();
		var href="";
		if(window.location.href.indexOf("?")>0){
			href=window.location.href.replace(/(\&group=\d)/,'')+'&group=0';
		}else{
			href=window.location.href.replace(/(\?group=\d)/,'')+'?group=0';
		}
		window.history.pushState('', '', href);
	})
	//分组重命名
	$('.small_right_nav_contentd').click(function(){
		small_right_this.find('.edit_tx').prop('contenteditable',true).focus()
	})
	//上传图片
	$('.fileupload').localResizeIMG(fileimgaugment);
	//上传图片弹窗
	$("#btn_imageuploads").click(function(){
		var tabNavXieText = $("#tab_nav_xie").html();
		if($("#alretboxmian").length){
			$("#alertboxbg").remove();
		        $("#alretboxmian").remove();
		}
		if(!$('#tab_nav_xie').is(':hidden')){
			$(".alert_select.sceneGroup option[value='"+leftKeyCurSceneGroudId+"']").attr("selected", true); 
		}
		$(".fileupload").click();
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
    			$('.uploadstar_mian').show()
    			secneupfileimg();
    			if($('#tab_nav_xie').is(':hidden')){
    				leftKeyCurSceneGroudId = null;
    			}
	        },
	        fcallfn:function(){
	        	//location.reload();
	        }
	    });
	    $("#tab_nav_xie").html(tabNavXieText);
	});
	 $('body').on('click','.londingclose',function(){
		 var idx = $(this).parents('li').index()
		 if(idx == successfilelist){
			ajaxfileimgarr[successfilelist].abort()
			$(".uploadstar_list li").eq(successfilelist).find('.loadbg').hide();
        	$(".uploadstar_list li").eq(successfilelist).find('.uploadstar_list_tx').html('<i style="color:#ff5050">取消</i>');
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
		 alertbox({
		        msg:$('.close_del_up_mian').html(),
		        tcallfn_tx:'确定',
		        tcallfn:function(){
		        	location.reload();
		        }
			 }) 
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
		 --successfilelist
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
	 //更改分组
	 $('.alert_small_right_info_edit').click(function(){
			alertbox({msg:$('.small_right_info_com').html(),
				tcallfn:function(){
					var sceneGroupId=$("#alretboxmian .sceneGroup").val();
					if(sceneGroupId==curSceneGroupId){
						return;
					}
					var d={
						"ids":chooseSceneIdList.join(","),
						"groupId":sceneGroupId	
					};
					changeGroup(d);
				}
			});
			$("#alretboxmian .sceneGroup option[value='"+curSceneGroupId+"']").remove();
		});
})