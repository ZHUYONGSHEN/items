//鼠标右键
var right_nav_cunt=0,small_right_info_cunt=0,small_right_this,oldSceneGroupName;
var chooseSceneIdList=[];
var curSceneGroupId;

function bindmosedown(e){
	e.preventDefault()
	e.stopPropagation()
	
	if(e.which == 3){
		window.history.pushState('', '', window.location.href.replace(/(&group=\d)/,'')+'&group=0');
		if($(this).index()>0) {
			$('.small_right_click_nav').css({'left': e.pageX, 'top': e.pageY}).show();
			$('.small_right_click_nav li').show();
			small_right_this = $(this)
		}

	}
	if(e.which == 1){
		window.history.pushState('', '', window.location.href.replace(/(&group=\d)/,'')+'&group='+$(this).index());
		if($(this).index()>0){
			var edit_tx= '分组<i></i>'+$(this).find('.edit_tx').html();
			curSceneGroupId = $(this).data('id');
			$('#tab_nav_xie').html(edit_tx).show();
			leftKeyCurSceneGroudId = curSceneGroupId;
			$('.tabmian > ul').hide();
			$('.small_whole_info').show().find('ul').hide().eq($(this).index()-1).show();
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
			$('.small_whole li:last-child').find('.edit_tx').prop('contenteditable',true).focus();
			$('.small_whole li:last-child').find('.edit_tx').prop('contenteditable',true).blur(function(){
				var curText = $(this).html();
				if(curText!= undefined && curText!=""){
					console.log(curText);
					$(this).html(curText+'(0)');
					setTimeout(function(){
						location.reload();
					},500);
				} else {
					$('.small_whole li:last-child').remove();
				}
			});
			
		}
	}
}
$(function(){
	$('.big_whole li').bind("contextmenu",function(e){
		return false;
	});
	$('.right_click_nav').bind("contextmenu",function(e){
		return false;
	});
	$('.big_whole li').bind('mousedown',function(e){
		var id = $(this).data("id")
		window.history.pushState('', '', window.location.href.replace(/(&group=\d)/,''));
		if(e.which == 3){
			small_right_this = $(this);
			if($(this).is('.cur')){
				$('.right_click_nav').css({'left':e.pageX,'top':e.pageY}).show();
				console.log(right_nav_cunt);
				if(right_nav_cunt >=1){
					$('.right_click_nav li').hide()
					$('.right_click_nav li:last-child').show()
				}else{
					$('.right_click_nav li').show()
				}
				
			}else{
				right_nav_cunt=0
				chooseSceneIdList=[];
				chooseSceneIdList.push(id);
				$(this).siblings().removeClass('cur')
				$(this).addClass('cur')
				$('.right_click_nav').css({'left':e.pageX,'top':e.pageY}).show();
				$('.right_click_nav li').show()
			}
		}else if(e.which == 1){
			$('.right_click_nav').hide()
			if($(this).is('.cur')){
				for(var i=0;i<chooseSceneIdList.length;i++){
					if(chooseSceneIdList[i]==id){
						chooseSceneIdList.splice(i,1);
						break;
					}
				}
				$(this).removeClass('cur');
				--right_nav_cunt;
			}else{
				chooseSceneIdList.push(id);
				$(this).addClass('cur');
				++right_nav_cunt;
			}
		}
	})
	$('.big_whole li').bind('dblclick',function(e){
		small_right_this = $(this).prop("outerHTML");
		dbindex = $(this).index()
		$('.dbclick_show li').eq(dbindex).show()
		$('.dbclick_com').show()
		$('#dbclick_img_conent').attr('data-idx',$(this).index())
		$('#dbclick_img_conent').attr('src',$(this).data('imgurl'))
	})
	//双击
	$('body').on('click','#dbclick_arrow_l',function(){
		var dindex = parseInt($('#dbclick_img_conent').attr('data-idx'));
		var dbindex =$('.big_whole li').eq(dindex).data('imgurl');
		if(dindex>0){
			$('#dbclick_img_conent').hide();
			$('#dbclick_img_conent').attr('src',$('.big_whole li').eq(dindex-1).data('imgurl'));
			$('#dbclick_img_conent').attr('data-idx',dindex-1)
			$('#dbclick_img_conent').fadeIn();
			//$('#alretboxmian .dbclick_show li').eq(dbindex).hide()
			//$('#alretboxmian .dbclick_show li').eq(--dbindex).show('slow')
		}
	})
	$('.dbclick_bottom_icon').click(function(){
		var dindex = parseInt($('#dbclick_img_conent').attr('data-idx'));
		var dbindex =$('.big_whole li').eq(dindex).data('id');
		var ids=[dbindex];
		var ele=$('.big_whole li').eq(dindex);
		switch ($(this).index()){
			case 0:
				showInfo(ele);
				break;
			case 1:
				editScene(ele);
				break;
			case 2:
				pointSetting(ele);
				break;
			case 3:
				editBottomLogo(ele);
				break;
			case 4:
				alertbox({
					msg:$('.right_del_mian').html(),tcallfn_tx:'删除',
					tcallfn:function(){
						deleteScene(ids);
					}
				});
				
				break;
		}
	});
	
	$('#dbclick_hide_main').click(function(){
		$('.dbclick_com').hide();
	});
	$('body').on('click','#dbclick_arrow_r',function(){
		var dindex = parseInt($('#dbclick_img_conent').attr('data-idx'));
		var dbindex =$('.big_whole li').eq(dindex).data('imgurl')
		if(dindex<($('.big_whole li').length -1)) {
			$('#dbclick_img_conent').hide();
			$('#dbclick_img_conent').attr('src',$('.big_whole li').eq(dindex+1).data('imgurl'));
			$('#dbclick_img_conent').attr('data-idx',dindex+1);
			$('#dbclick_img_conent').fadeIn();
			//$('#alretboxmian .dbclick_show li').eq(dbindex).hide()
			//$('#alretboxmian .dbclick_show li').eq(++dbindex).show('slow')
		}
	})
	$('body').on('click',function(){
		$('.small_right_click_nav').hide()
		$('.right_click_nav').hide()
		$('.small_right_info_click_nav').hide()
	})
	function tab_com(a,b){
		a.click(function(){
			chooseSceneIdList =[]
			$(this).addClass('active').siblings().removeClass('active')
			b.eq($(this).index()).show().siblings().hide()
			$('.small_whole_info li').removeClass('cur')
			$('.big_whole li').removeClass('cur')
			$('#tab_nav_xie').hide()
			if($(this).index() == 0){
				a.eq(0).find('img').attr('src',backStatic+'/images/list2_nav0.png')
				a.eq(1).find('img').attr('src',backStatic+'/images/list2_nav1.png')
				window.history.pushState('', '', window.location.href.replace(/(&group=\d)/,''));
			}else{
				a.eq(0).find('img').attr('src',backStatic+'/images/list2_nav00.png')
				a.eq(1).find('img').attr('src',backStatic+'/images/list2_nav11.png')
				window.history.pushState('', '', window.location.href.replace(/(&group=\d)/,'')+'&group=0');
			}
		})
	}
	tab_com($('.camear_head>span'),$('.tabmian ul'))

	//    分组邮件
	$('.small_whole li').bind("contextmenu",function(e){
		return false;
	});
	$('.small_right_click_nav').bind("contextmenu",function(e){
		return false;
	});
	$('.small_whole li').bind('mousedown',bindmosedown)
	
	/*$('.small_whole li').bind('dblclick',function(e){
	 if($(this).index()>0){
	 $('.tabmian ul').hide().eq(2).show()
	 }else{
	 alertbox({msg:$('.uploadimg_info_com').html(),
	 tcallfn:function(){
	 $('#alretboxmian .uploadimg_info_com').find('form').submit()
	 }
	 })
	 }
	 })*/
	//分组重命名
	$('.small_right_nav_contentd').click(function(){
		small_right_this.find('.edit_tx').prop('contenteditable',true).focus()
	})

	
	//分组详细右键
	$('.small_whole_info li').bind("contextmenu",function(e){
		return false;
	});
	$('.small_right_info_click_nav').bind("contextmenu",function(e){
		return false;
	});
	$('.small_whole_info li').bind('mousedown',function(e){
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
							$('.small_right_info_click_nav li').hide().eq(1).show().end().eq(3).show().end().eq(4).show().end();
							console.log(0);
						}else if(small_right_this.index() ==1 && small_right_this.index() == small_right_this.siblings('li').length){
							$('.small_right_info_click_nav li').eq(2).hide().end().eq(3).hide();
							console.log(1);
						}else if(small_right_this.index() ==1){
							$('.small_right_info_click_nav li').eq(2).hide()
							console.log(2);
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
					$('.small_right_info_click_nav li').hide().eq(1).show().end().eq(4).show()
				}else if(small_right_this.index() ==1 && small_right_this.index() == small_right_this.siblings('li').length){
					$('.small_right_info_click_nav li').eq(2).hide().end().eq(3).hide()
				}else if(small_right_this.index() ==1){
					//相册组内第二个场景图
					/*$('.small_right_info_click_nav li').eq(2).hide()*/
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
	})

	$('.small_right_click_nav li').click(function(){
		$('.small_right_click_nav').hide()
	})
	$('.right_click_nav li').click(function(){
		$('.right_click_nav').hide()
	})
	$('.small_right_info_click_nav li').click(function(){
		$('.small_right_info_click_nav').hide()
	})
	
})