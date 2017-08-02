$(function(){
	var title_con_index = 0,imgicont=0,imgicont_s=0;new_btn_list_tx_cont=0;new_btn_shipin_tx_cont=0;new_btn_zwtp_tx_cont=0;video_icont=0
	var title_contx ='<li class="clear list_li_com">'+
		'<p class="alert_tx">标题:</p>'+
		'<input type="text" name="title" class="btn_tx_com_connter fl" maxlength="12" placeholder="请输入12个字之内的标题" data-reg="emptys"/>'+
		'</li>'+
		'<li class="clear mb20 list_li_com">'+
		'<p class="alert_tx">正文:</p>'+
		'<textarea class="btn_tx_com_textarea fl title_link_tx_type trim_inspect" data-reg="emptys" name="textList[]"></textarea><span class="warn_tx_com hide_com">*不能为空</span>'+
		'</li>'
	var title_conlink='<li class="clear mb20 list_li_com">'+
		'<p class="alert_tx">标题:</p>'+
		'<input type="text" name="title" maxlength="12" placeholder="请输入12个字之内的标题" class="btn_tx_com_connter fl" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span>'+
		'</li>'
	var title_conlink_s='<li class="clear list_li_com">'+
		'<p class="alert_tx">标题:</p>'+
		'<input type="text" name="title" maxlength="12" class="btn_tx_com_connter fl" data-reg="emptys" placeholder="请输入12个字之内的标题"/><span class="warn_tx_com hide_com">*不能为空</span>'+
		'</li>'
	var title_conlink_l='<li class="clear list_li_com">'+
		'<p class="alert_tx">链接:</p>'+
		'<input type="text" name="textUrlList[0]" class="btn_tx_com_connter title_link_tx_type fl link_reg_input" data-reg="emptys"/><span class="warn_tx_com hide_com">*输入正确链接</span>'+
		'</li>'
	var title_conlink_l_tx='<li class="clear list_li_com">'+
		'<p class="alert_tx">正文:</p>'+
		'<input type="text" name="textUrlListText[0]" maxlength="300" placeholder="请输入300个字之内的正文" class="btn_tx_com_connter title_link_tx_type_tx fl" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span>'+
		'</li>'
	var click_new_tx ='<li class="clear mt20 list_li_com">'+
		'<i class="new_module1 click_new"><i class="icon_cunt mr10"></i>新增一行</i>'+
		'</li>'
	var click_new_tx_s ='<li class="clear mt20 list_li_com">'+
		'<i class="new_module1 click_news"><i class="icon_cunt mr10"></i>新增一行</i>'+
		'</li>'
	var title_video ='<li class="clear list_li_com">'+
		'<p class="alert_tx">标题:</p>'+
		'<input type="text" name="title" maxlength="12" placeholder="请输入12个字之内的标题" class="btn_tx_com_connter fl" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span>'+
		'</li>'+
		'<li class="clear list_li_com divImageUpload">'+
		'<p class="alert_tx">视频:</p>'+
		'<video src="" webkit-playsinline="true" controls="controls" preload="none" style="width:300px;height:150px;"></video>'+
		'<label class="label_load_img fl" style="margin-top:115px">上传视频<input type="file" name="file" id="btshipin'+video_icont+'" class="hide_com inputImageUpload"/></label>'+
		'<input type="text" name="videoUrl" class="btn_tx_com fl hide_com" data-reg="emptys" readonly="readonly"/><span type="button" class="lianjieqidelte hide_com fl" style="margin-top:115px" data-val="'+backstaticurl+'/images/img_logo1.png" >删除视频</span><span class="warn_info fl" style="margin-top:120px">*格式:MP4,编码为H264</span><span class="warn_tx_com hide_com fl" style="margin-top:120px">*不能为空</span>'+
		'</li>'
	var title_map ='<li class="clear mb20 list_li_com">'+
		'<p class="alert_tx">标题:</p>'+
		'<input type="text" name="title" maxlength="12" placeholder="请输入12个字之内的标题" class="btn_tx_com_connter fl" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span>'+
		'</li>'+
		'<li class="clear mb20 list_li_com">'+
		'<tr>'+
		'<th>坐标</th>'+
		'<td>'+
		'经度(Y)&nbsp;&nbsp;<input type="text" name="longitude" value="'+$("#la").val()+'" id="longitude" onblur="init(2)" class="h30 mr20"/>'+
		'纬度(X)&nbsp;&nbsp;<input type="text" name="latitude" value="'+$("#lo").val()+'" id="latitude" onblur="init(2)" class="h30"/>'+
		'</td>'+
		'</tr>'+
		'<tr>'+
		'<th>&nbsp;</th>'+
		'<td>'+
		'<div style="width:603px;height:400px;margin-top:20px" id="container"></div>'+
		'</td>'+
		'</tr>'+
		
		'</li>'
	var new_btn_list_tx = '<li class="clear mb20 list_li_com"><ul>'+
			'<li class="clear mb20 list_li_com">'+
			'<span class="fl span_com">入口标题:</span>'+
			'<input type="text" name="zdyanEntryTitle" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" maxlength="300" placeholder="请输入300个字之内的入口标题"/><span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>'+
			'</li>'+
			'<li class="clear mb20 list_li_com">'+
			'<span class="fl span_com">入口图标:</span>'+
			'<div class="fl div_up_img_nonebg w_540">'+
			'<img src="'+backStatic+'/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>'+
			'<div class="fl mt20">'+
			'<label class="label_load_img">'+
			'上传图片<input type="file" class="hide_com inputImageUpload rukou_icon" id="zdyrukoutu'+new_btn_list_tx_cont+'"/>'+
			'</label>'+
			'<input type="hidden" name="zdyanEntryIcon" data-reg="emptys"><span class="warn_tx_com hide_com">*不能为空</span>'+
			'<input type="button" class="lianjieqidelte hide_com" data-val="'+backstaticurl+'/images/img_logo1.png" value="删除图片"/>'+
			'<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>'+
			'</div>'+
			'</div>'+
			'</li>'+
			'<li class="clear mb20 list_li_com">'+
			'<span class="fl span_com">链接:</span>'+
			'<input type="text" name="zdyanUrl" class="btn_tx_com_connter fl link_reg_input" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span>'+
			'</li></ul></li>'
	var title_arr=[title_contx,title_conlink,title_conlink_s,title_video,title_map]
	//radio切换类型
	$('.mian_com').on('click','.title_max_mian > label',function(){
		var count = $(this).index()-1;
		var title_conimg = '<li class="clear mb20 list_li_com divImageUpload">'+
			'<div class="div_up_img w_540">'+
			'<div class="clear">'+
			'<img src="'+backStatic+'/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>'+
			'<div class="fl mt20">'+
			'<label class="label_load_img">'+
			'上传图片<input type="file" class="hide_com inputImageUpload" id="zhengwentupian'+new_btn_zwtp_tx_cont+'" name="file"/>'+
			'</label>'+
			'<input type="hidden" class="title_link_hidden_type" data-reg="emptys" /><span class="warn_tx_com hide_com">*不能为空</span>'+
			'<input type="button" class="lianjieqidelte hide_com" data-val="'+backstaticurl+'/images/img_logo1.png" value="删除图片"/>'+
			'<p class="warn_info">*格式:JPG,PNG,尺寸:650*900(像素)</p>'+
			'</div>'+
			'</div>'+
			'<div class="mt10 color_29353d">正文:<input type="text" maxlength="300" class="btn_tx_com_connter_link ml10 title_link_tx_type" data-reg="emptys" placeholder="请输入300个字之内的正文"/><span class="warn_tx_com hide_com">*不能为空</span></div>'+
			'</div>'+
			'</li>'
		var title_video ='<li class="clear list_li_com">'+
		'<p class="alert_tx">标题:</p>'+
		'<input type="text" name="title" maxlength="12" placeholder="请输入12个字之内的标题" class="btn_tx_com_connter fl" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span>'+
		'</li>'+
		'<li class="clear list_li_com divImageUpload">'+
		'<p class="alert_tx">视频:</p>'+
		'<video src="" webkit-playsinline="true" controls="controls" preload="none" class="fl" style="width:300px;height:150px;"></video>'+
		'<label class="label_load_img fl ml10" style="margin-top:115px">上传视频<input type="file" name="file" id="btshipin'+video_icont+'" class="hide_com inputImageUpload"/></label>'+
		'<input type="text" name="videoUrl" class="btn_tx_com fl hide_com" data-reg="emptys" readonly="readonly"/><span type="button" class="lianjieqidelte hide_com fl" style="margin-top:115px" data-val="'+backstaticurl+'/images/img_logo1.png" >删除视频</span><span class="warn_info ml10 fl" style="margin-top:120px">*格式:MP4,编码为H264</span><span class="warn_tx_com hide_com fl" style="margin-top:120px">*不能为空</span>'+
		'</li>'
			$(this).siblings('.list3_radio_type').val(count)
			$(this).parent().attr('class','clear list_li_com mb20 title_max_mian list3_list_mian_type'+count)
			
		if(count == 2){
			count = count-1
			$(this).siblings('ul').html(title_arr[count]+title_conimg+click_new_tx)
		}else if(count == 3){
			count = count-1
			$(this).siblings('ul').html(title_arr[count]+title_conlink_l_tx+title_conlink_l+click_new_tx_s)
		}else{
			count = count-1;
			title_arr[3] = title_video
			$(this).siblings('ul').html(title_arr[count])
		}
		console.log(count)
		if(count ==4){
			init(1)
		}
	})
	//添加正文+图片
	$('.mian_com').on('click','.title_max_mian .click_new',function(){
		console.log(backStatic);
		new_btn_zwtp_tx_cont++;
		var title_conimg = '<li class="clear mb20 list_li_com divImageUpload">'+
			'<div class="div_up_img w_540">'+
			'<div class="clear">'+
			'<img src="'+backStatic+'/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>'+
			'<div class="fl mt20">'+
			'<label class="label_load_img">'+
			'上传图片<input type="file" name="file" id="zhengwentupian'+new_btn_zwtp_tx_cont+'" class="hide_com inputImageUpload"/>'+
			'</label>'+
			'<input type="hidden" class="title_link_hidden_type" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span>'+
			'<input type="button" class="lianjieqidelte hide_com" data-val="'+backstaticurl+'/images/img_logo1.png" value="删除图片"/>'+
			'<p class="warn_info">*格式:JPG,PNG,尺寸:650*900(像素)</p>'+
			'</div>'+
			'</div>'+
			'<div class="mt10 color_29353d">正文:<input type="text" maxlength="300" class="btn_tx_com_connter_link ml10 title_link_tx_type" data-reg="emptys" placeholder="请输入300个字之内的正文"/><span class="warn_tx_com hide_com">*不能为空</span></div>'+
			'</div>'+
			'<i class="icon_module_del click_module_del click_module_del_imgicont zhengwen_shanchu"></i>'+
			'</li>'
		$(this).parent().before(title_conimg)
	})
	//添加正文+链接
	$('.mian_com').on('click','.title_max_mian .click_news',function(){
		var title_conlink_l_tx='<li class="clear list_li_com">'+
		'<p class="alert_tx">正文:</p>'+
		'<input type="text" maxlength="300" placeholder="请输入300个字之内的正文" name="textUrlListText[0]" class="btn_tx_com_connter title_link_tx_type_tx fl" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span><i class="icon_module_del ml10 icon_module_conlink"></i>'+
		'</li>'
		var title_conlink_l='<li class="clear list_li_com">'+
			'<p class="alert_tx">链接:</p>'+
			'<input type="text" name="textUrlList[0]" class="btn_tx_com_connter title_link_tx_type fl link_reg_input" data-reg="emptys"/><span class="warn_tx_com hide_com">*输入正确链接</span>'+
			'</li>'
		$(this).parent().before(title_conlink_l_tx+title_conlink_l)
	})
	var s =1;
	//添加正文模块
	$('#click_new_list').click(function(){
		new_btn_zwtp_tx_cont++;
		video_icont++;
		var txt = '<li class="clear mb20 list_li_com title_max_mian list3_list_mian_type1">'+
			'<input type="hidden" name="titleType" value="1" class="list3_radio_type"/>'+
			'<span class="fl span_com">正文类型:</span>'+
			'<label class="radio_label_click"><i class="radio_yes mr5"></i><input type="radio" name="" value="1" class="mr5 hide_com clickshow" checked="checked"/>标题+正文</label>'+
			'<label class="ml20 radio_label_click"><i class="radio_no mr5"></i><input type="radio" class="ml10 mr5 hide_com clickhide" value="2" name=""/>标题+正文图片</label>'+
			'<label class="ml20 radio_label_click"><i class="radio_no mr5"></i><input type="radio" class="ml10 mr5 hide_com clickhide" value="3" name=""/>标题+链接</label>'+
			'<label class="ml20 radio_label_click"><i class="radio_no mr5"></i><input type="radio" class="ml10 mr5 hide_com clickhide" value="4" name=""/>标题+视频</label>'+
			'<label class="ml20 radio_label_click"><i class="radio_no mr5"></i><input type="radio" class="ml10 mr5 hide_com clickhide" value="5" name=""/>标题+地图</label>'+
			'<ul style="min-height:386px">'+title_contx+
			'</ul>' +
			'<i class="icon_module_del click_module_del click_module_del_newlist zhengwen_shanchu"></i>'+
			'</li>'
			s++;
		$(this).parent().siblings(".zengwen_xinzeng").append(txt);
	})
	//删除正文模块
	$('.mian_com').on('click','.title_max_mian .click_module_del_newlist',function(){
		$(this).parent().remove()
	})
	//删除正文+图片
	$('.mian_com').on('click','.title_max_mian .click_module_del_imgicont',function(){
		$(this).parent().remove()
	})
	//删除正文+链接
	$('.mian_com').on('click','.title_max_mian .icon_module_conlink',function(){
		$(this).parent().next().remove()
		$(this).parent().remove()
	})
	$('.mian_com').on('click','.connter_mian_list3 .click_module_del_btn_list',function(){
		$(this).parent().remove()
	})
	
	//添加自定义按钮
	$('#click_new_btn_list').click(function(){
		new_btn_list_tx_cont++
		var new_btn_list_tx = '<li class="clear mb20 list_li_com zdyDiv"><ul class="ziyidinganan">'+
			'<li class="clear mb20 list_li_com">'+
			'<span class="fl span_com">入口标题:</span>'+
			'<input type="text"  class="btn_tx_com_connter fl reg_rempty zdyanEntryTitle" data-reg="empstyflasesix" maxlength="6" placeholder="请输入6个字之内的入口标题" /><span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>'+
			'</li>'+
			'<li class="clear mb20 list_li_com divImageUpload">'+
			'<span class="fl span_com">入口图标:</span>'+
			'<div class="fl div_up_img_nonebg w_540">'+
			'<img src="'+backStatic+'/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>'+
			'<div class="fl mt20">'+
			'<label class="label_load_img">'+
			'上传图片<input type="file" name="file" class="hide_com inputImageUpload rukou_icon" id="zdyrukoutu'+new_btn_list_tx_cont+'"/>'+
			'</label>'+
			'<input type="hidden"  class="zdyanEntryIcon" data-reg="emptys"><span class="warn_tx_com hide_com">*不能为空</span>'+
			'<input type="button" class="lianjieqidelte hide_com" data-val="'+backstaticurl+'/images/img_logo1.png" value="删除图片"/>'+
			'<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>'+
			'</div>'+
			'</div>'+
			'</li>'+
			'<li class="clear mb20 list_li_com">'+
			'<span class="fl span_com">入口链接:</span>'+
			'<label class="radio_label_click mr60 type_selects"><i class="type_selects_i radio_no mr5"></i><input type="radio" class="mr5 hide_com"  value="0"/>跳链接</label>'+
			'<label class="ml20 radio_label_click mr60 type_selects"><i class="type_selects_i radio_no mr5"></i><input type="radio"  class="ml10 mr5 hide_com" value="1" />弹出二维码浮窗</label>'+
			'</li>'+
			'<li class="clear mb20 list_li_com">'+
			'<span class="fl span_com">链接地址:</span>'+
			'<input type="text"  class="btn_tx_com_connter fl link_reg_input zdyanUrl" data-reg="emptys"/><span class="warn_tx_com hide_com">*输入正确的链接</span>'+
			'</li></ul><i class="icon_module_del click_module_del click_module_del_btn_list" style="margin-top:15px;"></i></li>';
		   $(this).parent().before(new_btn_list_tx)
	})
	
	
//	添加户型
	var new_huxing_list_tx_count=$(".zhuli").size();
	$("#add_huxing").click(function(){
		if(new_huxing_list_tx_count<19){
			var new_huxing_list_tx='<li class="clear pb38 list_li_com divImageUpload zhuli">'+
			'<span class="fl span_com">&nbsp</span>'+
			'<div class="fl div_up_img_nonebg w_540">'+
			'<img src="'+backStatic+'/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>'+
			'<div class="fl mt20">'+
			'<label class="label_load_img mr10">'+
			'上传图片<input type="file" name="file" id="imgUrl'+new_huxing_list_tx_count+'" class="hide_com inputImageUpload list4_logo zhuli_img"/>'+
			'</label>'+
			'<input type="hidden"  class="imgUrl" id="imgUrl" >'+
			'<p class="warn_info">*格式:JPG,PNG,尺寸:649*900(像素)</p>'+
			'</div>'+
			'</div>'+
			'<div class="clear div_relative huxingmiaoshuss">'+
			'<div class="fl span_com">户型描述:</div>'+
			'<div class="fl"><input type="text" placeholder="请输入" class="householdDesc" class="mr20" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>'+
			'<div class="fl mr10" style="color:#859dad;">面积:</div>'+
			'<div class="fl mr20" style="color:#859dad;"><input class="mr20 area" type="number" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">平米</div>'+
			'<div class="delete_huxing fl">删除</div>'+
			'</div>'+
			'</li>'
			
			$(this).parent().before(new_huxing_list_tx);
			new_huxing_list_tx_count++;
		}
	});
	
//	删除新房户型
	$(".mian_com").on("click",".delete_huxing",function(){
		$(this).parents(".list_li_com").remove();
		new_huxing_list_tx_count--;
	});
	
//添加走势
	var new_zoushi_list_tx_count=0;
	$("#add_shijian").click(function(){
		if(new_zoushi_list_tx_count<10){
			var new_zoushi_list_tx='<div class="clear pb38 list_li_com chengjiaozoushi">'+
			'<div class="clear div_relative_left150 newtrend">'+
			'<div class="fl mr10">时间:</div>'+
			'<div class="fl mr106"><input  class="timePikers ttime" type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>'+
			'<div class="fl mr10">成交均价:</div>'+
			'<div class="fl mr20"><input type="number" class="taveragePrice" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">元/㎡</div>'+
			'<div class="delete_shijian fl">删除</div>'+
			'</div>'+
			'</div>'
			$(this).parent().before(new_zoushi_list_tx);
			new_zoushi_list_tx_count++;
		}
	});
	
	var new_zoushi_list_tx_count1=0;
	$("#add_shijian1").click(function(){
		if(new_zoushi_list_tx_count1<10){
			var new_zoushi_list_tx1='<div class="clear pb38 list_li_com chengjiaozoushi">'+
			'<div class="clear div_relative_left150 oldtrend">'+
			'<div class="fl mr10">时间:</div>'+
			'<div class="fl mr106"><input  class="timePikers ttime"  type="text" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;"></div>'+
			'<div class="fl mr10">成交均价:</div>'+
			'<div class="fl mr20"><input type="number" class="mr10 taveragePrice" style="width:150px;height:30px;padding-left:6px;border:1px solid #ccc;">元/平米</div>'+
			'<div class="delete_shijian1 fl">删除</div>'+
			'</div>'+
			'</div>'
			$(this).parent().before(new_zoushi_list_tx1);
			new_zoushi_list_tx_count1++;
		}
	});
	
//	新增语音按钮
	var new_yuyin_list_tx_count1=$(".yuyinDiv").size();
	$("#xinzeng_yuyin").click(function(){
		if(new_yuyin_list_tx_count1<20){
			var group =$("#yySyGroupId").html();
			var scene =$("#yySyScene").html();
			var new_yuyin_list_tx1='<div class="yuyin_shiyong yuyinDiv">'+
			'<li class="clear mb20 list_li_com divImageUpload">'+
			'<span class="fl span_com">上传语音:</span>'+
			'<audio src="" controls="controls" class="audio_up_load fl mr10"></audio>'+
			'<label class="label_load_img fl mr10">'+
			'上传语音<input type="file" name="file"  id="yuurlRukou'+new_yuyin_list_tx_count1+'" class="hide_com inputImageUpload"/>'+
			'</label>'+
			'<span class="lianjieqidelte fl hide_com" >删除语音</span>'+
			'<p class="warn_info fl">*格式:mp3</p>'+
			'<input type="text" class="btn_tx_com_connter hide_com fl textUpload yyUrl" readonly="readonly"/>'+
			'<div class="delete_yuyin fl ml10">删除</div>'+
			'</li>'+
			'<li class="clear list_li_com pb38">'+
			' <span class="fl span_com">语音适用页面:</span>'+
			'<select  class="alert_select mr5 yySyGroupId" style="width:140px;">'+
			//'<option>全部</option>'+
			group+
			'</select>'+
			'<select class="alert_select yySyScene" style="width:140px;">'+
			//'<option>全部</option>'+
			scene+
			'</select>'+
			'</li>'+
			'</div>'
			$(this).parent().before(new_yuyin_list_tx1);
			new_yuyin_list_tx_count1++;
		}
	});
	
//	删除语音
	$(".mian_com").on("click",".delete_yuyin",function(){
		$(this).parents(".yuyin_shiyong").remove();
		new_yuyin_list_tx_count1--;
	});
	
	
//	删除走势
	$(".mian_com").on("click",".delete_shijian",function(){
		$(this).parents(".list_li_com").remove();
		new_zoushi_list_tx_count--;
	});
	
	$(".mian_com").on("click",".delete_shijian1",function(){
		$(this).parents(".list_li_com").remove();
		new_zoushi_list_tx_count1--;
	});
	
	$(".mian_com").on("focus",".timePikers",function(){
		WdatePicker({ dateFmt: "yyyy-MM", isShowToday: false, isShowClear: false,onpicking:function(dp){return updateTime(dp);} });
	});
	$(".mian_com").on("focus",".timePikers1",function(){
		WdatePicker({ dateFmt: "yyyy-MM-dd", isShowToday: false, isShowClear: false });
	});
	$(".mian_com").on("focus",".timePikers2",function(){
		WdatePicker({ dateFmt: "yyyy", isShowToday: false, isShowClear: false });
	});
	function updateTime(dp){
		var flag = false;
		$(".mian_com").find(".timePikers").each(function(){
			if($(this).val() == dp.cal.getNewDateStr()){
				alert("你已选择该日期,请重新选择!");
				
				flag = true;
				return true;
			}
		})
		return flag;
		/*if(!confirm('日期框原来的值为: '+dp.cal.getDateStr()+', 要用新选择的值:' + dp.cal.getNewDateStr() + '覆盖吗?')){
			return true;
		}*/
	}
	$(".type_selects").click(function(){
		var _index=$(this).index();
		if(_index==1){
			$(".xinfangs").css("display","block");
			$(".ershoufangs").css("display","none");
			$(".qita").css("display","none");
			$(".xiangqin_shili").attr("src",backstaticurl+"/images/shili_xinfang.png");
			$(".xiangqin_shili").hide();
		}else if(_index==2){
			$(".xinfangs").css("display","none");
			$(".ershoufangs").css("display","block");
			$(".qita").css("display","none");
			$(".xiangqin_shili").attr("src",backstaticurl+"/images/shili_ershoufang.png");
			$(".xiangqin_shili").hide();
		}else if(_index==3){
			$(".xinfangs").css("display","none");
			$(".ershoufangs").css("display","none");
			$(".qita").css("display","block");
			$(".xiangqin_shili").attr("src",backstaticurl+"/images/xiangqing.png");
			$(".xiangqin_shili").hide();
		}
	});
	
//	编辑状态下触发按钮选中
	(function(){
		$(".type_selects_i").each(function(i){
			if($(this).hasClass("radio_yes")){
				$(this).parent().click();
			}
		});
	})();
	
	
	$(".showOrhide").click(function(){
		if($(this).find("i").hasClass("down_arrow")){
			$(this).find("i").removeClass("down_arrow").addClass("up_arrow");
			$(".wraper1").css("display","block");
		}else if($(this).find("i").hasClass("up_arrow")){
			$(this).find("i").removeClass("up_arrow").addClass("down_arrow");
			$(".wraper1").css("display","none");
		}
	});
	
	$(".showOrhide1").click(function(){
		if($(this).find("i").hasClass("down_arrow")){
			$(this).find("i").removeClass("down_arrow").addClass("up_arrow");
			$(".wraper2").css("display","block");
		}else if($(this).find("i").hasClass("up_arrow")){
			$(this).find("i").removeClass("up_arrow").addClass("down_arrow");
			$(".wraper2").css("display","none");
		}
	});
	
	$(".showOrhide2").click(function(){
		if($(this).find("i").hasClass("down_arrow")){
			$(this).find("i").removeClass("down_arrow").addClass("up_arrow");
			$(".wraper3").css("display","block");
		}else if($(this).find("i").hasClass("up_arrow")){
			$(this).find("i").removeClass("up_arrow").addClass("down_arrow");
			$(".wraper3").css("display","none");
		}
	});
	
	$(".showOrhide3").click(function(){
		if($(this).find("i").hasClass("down_arrow")){
			$(this).find("i").removeClass("down_arrow").addClass("up_arrow");
			$(".wraper4").css("display","block");
		}else if($(this).find("i").hasClass("up_arrow")){
			$(this).find("i").removeClass("up_arrow").addClass("down_arrow");
			$(".wraper4").css("display","none");
		}
	});
	
	$(".showOrhide4").click(function(){
		if($(this).find("i").hasClass("down_arrow")){
			$(this).find("i").removeClass("down_arrow").addClass("up_arrow");
			$(".wraper5").css("display","block");
		}else if($(this).find("i").hasClass("up_arrow")){
			$(this).find("i").removeClass("up_arrow").addClass("down_arrow");
			$(".wraper5").css("display","none");
		}
	});

	$(".showOrhide5").click(function(){
		if($(this).find("i").hasClass("down_arrow")){
			$(this).find("i").removeClass("down_arrow").addClass("up_arrow");
			$(".wraper6").css("display","block");
		}else if($(this).find("i").hasClass("up_arrow")){
			$(this).find("i").removeClass("up_arrow").addClass("down_arrow");
			$(".wraper6").css("display","none");
		}
	});
	
	$(".showOrhide6").click(function(){
		if($(this).find("i").hasClass("down_arrow")){
			$(this).find("i").removeClass("down_arrow").addClass("up_arrow");
			$(".wraper7").css("display","block");
		}else if($(this).find("i").hasClass("up_arrow")){
			$(this).find("i").removeClass("up_arrow").addClass("down_arrow");
			$(".wraper7").css("display","none");
		}
	});
	
	$(".showOrhide7").click(function(){
		if($(this).find("i").hasClass("down_arrow")){
			$(this).find("i").removeClass("down_arrow").addClass("up_arrow");
			$(".wraper8").css("display","block");
		}else if($(this).find("i").hasClass("up_arrow")){
			$(this).find("i").removeClass("up_arrow").addClass("down_arrow");
			$(".wraper8").css("display","none");
		}
	});
	
	
//	楼盘字典数据  新房
	var loupanzidian_data=null,searchState=null;
	
	$(".new_house_input").focus(function(){
		alertbox({
			msg:$('.loupanzidian').html(),
			tcallfn_tx:'确定',
			fcallfn_tx:'取消',
			tcallfn:function(){
				if(searchState==null){
					$("#alertboxbg").css("display","none");
					$("#alretboxmian").css("display","none");
					$("#form-rightButton-newhouse").find(".new_house_input").val(ser_name);
				}else if(searchState==true){
					if(loupanzidian_data){
						$("#alertboxbg").css("display","none");
						$("#alretboxmian").css("display","none");
						$(".searches_result").children().remove();
					}else{
						alert("请选择楼盘!");
					}
				}else{
					$("#form-rightButton-newhouse").find(".new_house_input").val(ser_name);
					$("#alertboxbg").css("display","none");
					$("#alretboxmian").css("display","none");
					
				}
			},
			tcallfn_no:function(){
				return false;
			}
		});
	});
	
//	楼盘字典数据  二手房
	
	$(".sub_house_input").focus(function(){
		alertbox({
			msg:$('.loupanzidian').html(),
			tcallfn_tx:'确定',
			fcallfn_tx:'取消',
			tcallfn:function(){
				if(searchState==null){
					$("#alertboxbg").css("display","none");
					$("#alretboxmian").css("display","none");
					$("#form-rightButton-oldhouse").find(".sub_house_input").val(ser_name);
				}else if(searchState==true){
					if(loupanzidian_data){
						$("#alertboxbg").css("display","none");
						$("#alretboxmian").css("display","none");
						$(".searches_result").children().remove();
					}else{
						alert("请选择楼盘!");
					}
				}else{
					$("#alertboxbg").css("display","none");
					$("#alretboxmian").css("display","none");
					$("#form-rightButton-oldhouse").find(".sub_house_input").val(ser_name);
				}
			},
			tcallfn_no:function(){
				return false;
			}
		});
	});
	
	
	
//	点击取消清空数据
	$('body').on('click','#alertboxtrue',function(e){
		console.log(54353);
	});
	
	var ser_name = "";
	
	$('body').on('click','#alretboxmian .searches_button',function(e){
		var _inputVal=$(this).siblings().find("input").val();
		ser_name = _inputVal;
		$.ajax({
			url:'http://release.app.hiweixiao.com/Panorama/Html/searchHouseName',
			data:{
				keyword:$.trim(_inputVal)
			},
			success:function(res){
				searchState=res.status;
				$(".searches_result").children().remove();
				if(!res.status){
					alert("暂无数据!");
				}else if(res.status){
					var data=res.data;
					data.forEach(function(value,index){
						var lis='<div class="lies" data-hid='+value.hid+'><p class="fl wone">'+(index+1)+'</p>'+
						'<p class="fl wtwo ellipsis">'+value.house_name+'</p>'+
						'<p class="fl wthree ellipsis">'+value.city+'</p>'+
						'<p class="fl wfour ellipsis">'+value.detail_address+'</p></div>'
						$(".searches_result").append(lis);
						
					});
				}
			}
		});
	});
	
	$('body').on('click','#alretboxmian .lies',function(e){
		var _hid=$(this).data("hid");
		$(this).css("background","#f2faff");
		$(this).siblings().css("background","none");
		$.ajax({
			url:'http://release.app.hiweixiao.com/Panorama/Html/getDetail?hid='+_hid,
			success:function(res){
				console.log(res)
				if(res.status){
					var fyType = $("input[name='fyType']:checked").val();
					if(fyType == 0){
						$("#form-rightButton-newhouse").find(".new_house_input").val(res.data.name);
					}else{
						$("#form-rightButton-oldhouse").find(".sub_house_input").val(res.data.name);
					}
					loupanzidian_data=res.data;
				}else{
					alert(res.info);
				}
			}
		});
	});
	
	
//	新房 关联楼盘字典
	$(".zidian_data_newHouse").click(function(){
		if(loupanzidian_data){
			console.log(loupanzidian_data);
			$(".new_house_input").val(loupanzidian_data.name);
			$(".new_house_price").val(loupanzidian_data.average_price);
			$(".build_area").val(loupanzidian_data.build_area);
			$(".green_rate").val(loupanzidian_data.green_rate);
			$(".plot_rate").val(loupanzidian_data.plot_rate);
			$(".developer").val(loupanzidian_data.developer);
			$(".wuyeleixing").eq(loupanzidian_data.house_use-1).click();
			$(".management").val(loupanzidian_data.management);
			$(".management_price").val(loupanzidian_data.management_price);
			$(".detail_address").val(loupanzidian_data.city+loupanzidian_data.detail_address);
			loupanzidian_data=null;
		}else{
			alert("请选择要关联的楼盘");
		}
	});
	
//	二手房 关联楼盘字典
	$(".zidian_data_sub_house").click(function(){
		if(loupanzidian_data){
			$(".sub_house_input").val(loupanzidian_data.name);
			$(".sub_house_price").val(loupanzidian_data.average_price);
			$(".build_area1").val(loupanzidian_data.build_area);
			$(".build_year").val(loupanzidian_data.build_year);
			$(".detail_address1").val(loupanzidian_data.city+loupanzidian_data.detail_address);
			loupanzidian_data=null;
		}else{
			alert("请选择要关联的楼盘");
		}
	});
	
//	监控表单元素值是否有改变
	$(".wraper1 input").change(function(){
		$(".wraper1_b").css("display","inline-block");
	});
	
	$(".wraper1 textarea").change(function(){
		$(".wraper1_b").css("display","inline-block");
	});
	
	$(".wraper1 select").change(function(){
		$(".wraper1_b").css("display","inline-block");
	});
	
	$(".wraper2 input").change(function(){
		$(".wraper2_b").css("display","inline-block");
	});
	
	$(".wraper2 textarea").change(function(){
		$(".wraper2_b").css("display","inline-block");
	});
	
	$(".wraper2 select").change(function(){
		$(".wraper2_b").css("display","inline-block");
	});
	
	$(".wraper3 input").change(function(){
		$(".wraper3_b").css("display","inline-block");
	});
	
	$(".wraper3 textarea").change(function(){
		$(".wraper3_b").css("display","inline-block");
	});
	
	$(".wraper3 select").change(function(){
		$(".wraper3_b").css("display","inline-block");
	});
	
	$(".wraper4 input").change(function(){
		$(".wraper4_b").css("display","inline-block");
	});
	
	$(".wraper4 textarea").change(function(){
		$(".wraper4_b").css("display","inline-block");
	});
	
	$(".wraper4 select").change(function(){
		$(".wraper4_b").css("display","inline-block");
	});
	
	$(".wraper5 input").change(function(){
		$(".wraper5_b").css("display","inline-block");
	});
	
	$(".wraper5 textarea").change(function(){
		$(".wraper5_b").css("display","inline-block");
	});
	
	$(".wraper5 select").change(function(){
		$(".wraper5_b").css("display","inline-block");
	});
	
	$(".wraper6 input").change(function(){
		$(".wraper6_b").css("display","inline-block");
	});
	
	$(".wraper6 textarea").change(function(){
		$(".wraper6_b").css("display","inline-block");
	});
	
	$(".wraper6 select").change(function(){
		$(".wraper6_b").css("display","inline-block");
	});
	
	$(".wraper7 input").change(function(){
		$(".wraper7_b").css("display","inline-block");
	});
	
	$(".wraper7 textarea").change(function(){
		$(".wraper7_b").css("display","inline-block");
	});
	
	$(".wraper7 select").change(function(){
		$(".wraper7_b").css("display","inline-block");
	});
	
	$(".wraper8 input").change(function(){
		$(".wraper8_b").css("display","inline-block");
	});
	
	$(".wraper8 textarea").change(function(){
		$(".wraper8_b").css("display","inline-block");
	});
	
	$(".wraper8 select").change(function(){
		$(".wraper8_b").css("display","inline-block");
	});
	
	
//	入口图标类型选择
	$(".rukoutubiao_type").click(function(){
		var _index=$(this).index();
		if(_index==1){
			$(".rukou_show_hide").css("display","block");
		}else if(_index==2){
			$(".rukou_show_hide").css("display","none");
		}
	});
	
//	新房编辑状态 走势的删除按钮
	$("body").on("click",".delete-xinfang-bianji",function(){
		$(this).parents(".newtrend").remove();
	});
	
//	二手房编辑状态 走势的删除按钮
	$("body").on("click",".delete-ershoufang-bianji",function(){
		$(this).parents(".oldtrend").remove();
	});
	
//	限制房源特色字数为500个字
	$(".fangyuan-tese").keyup(function(){
		var value=$.trim($(this).val());
		if(value.length>500){
			$(this).val(value.substring(0,500));
			
		}
	});
	
	
	
	
	
	
	
	
})