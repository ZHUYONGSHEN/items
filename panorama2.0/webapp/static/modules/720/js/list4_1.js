$(function(){
var new_btn_list_tx_cont=0

	//添加自定义按钮
	$('#click_new_btn_list').click(function(){
		new_btn_list_tx_cont++
			var new_btn_list_tx = '<li class="clear mb20 list_li_com"><ul class="ziyidinganan">'+
		'<li class="clear mb20 list_li_com">'+
		'<span class="fl span_com">入口标题:</span>'+
		'<input type="text" name="xfanEntryTitle" class="btn_tx_com_connter fl reg_rempty" data-reg="empstyflasesix" placeholder="请输入6个字之内的入口标题" maxlength="6"/><span class="warn_tx_com hide_com">*请输入6个字符内的标题</span>'+
		'</li>'+
		'<li class="clear mb20 list_li_com divImageUpload">'+
		'<span class="fl span_com">入口图标:</span>'+
		'<div class="fl div_up_img_nonebg w_540">'+
		'<img src="'+backStatic+'/images/img_logo1.png" class="load_img_com mr10 fl" width="100"/>'+
		'<div class="fl mt20">'+
		'<label class="label_load_img">'+
		'上传图片<input type="file" name="file" class="hide_com inputImageUpload rukou_icon" id="xiafangrukoutu'+new_btn_list_tx_cont+'" />'+
		'</label>'+
		'<input type="hidden" name="xfanEntryIcon"  data-reg="emptys"><span class="warn_tx_com hide_com">*不能为空</span>'+
		'<input type="button" class="lianjieqidelte hide_com" data-val="'+backstaticurl+'/images/img_logo1.png" value="删除图片"/>'+
		'<p class="warn_info">*格式:PNG,尺寸:72*72(像素)</p>'+
		'</div>'+
		'</div>'+
		'</li>'+
		'<li class="clear mb20 list_li_com">'+
		'<span class="fl span_com">链接:</span>'+
		'<input type="text" name="xfanUrl" class="btn_tx_com_connter fl link_reg_input" data-reg="emptys"/><span class="warn_tx_com hide_com">*不能为空</span>'+
		'</li></ul><i class="icon_module_del click_module_del click_module_del_btn_list"></i></li>'

		$(this).parent().before(new_btn_list_tx)
	})
	$('.mian_com').on('click','.connter_mian_list3 .click_module_del_btn_list',function(){
		$(this).parent().remove()
	})
})