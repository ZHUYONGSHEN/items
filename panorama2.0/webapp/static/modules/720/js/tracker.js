$(function(){

$.url = {
	init: function(){
		location.search.slice(1).split("&").forEach(function(i){
			var key = i.split("=")[0], val = i.split("=")[1];
			if (key) $.url[key] = decodeURIComponent(val);
		})
	}
}

$.url.init();

$.url.user_id = $.url.user_id || 
				$.url.agentId || 
				$.url.token;

var load = new Date().format("yyyy-MM-dd hh:mm:ss");

var href = encodeURI(location.origin + location.pathname);

var pageId = document.body.getAttribute('pageId') || false;

var unitId = document.body.getAttribute('unitId') || false;

var hidType = document.body.getAttribute('secondHouse') || window.conn_type;

var type = {
	'string': 'string',
	'number': 'number',
	'object': 'object'
};

function param($, split){
	return Object.keys($).filter(function(i){
		return i = $[i], typeof i in type;
	})
	.map(function(i){
		return i + '=' + (
		typeof $[i] != typeof $ ? encodeURIComponent($[i]) : param($[i], '|'));
	})
	.join(split || '&');
};

window.tracker = function(opt){
	var opt = $.extend({
			productId: 1,
			pageId: pageId,
			unitId: unitId,
			fromUrlTime: load,
			fromUrl: href,
			action: 'click',
			error: function(res){
				console.log(res);
			},
			success: function(res){
				/*console.log({
					pageId: opt.pageId,
					unitId: opt.unitId,
					message: res.message
				});*/
			},
			hidType: !!hidType,
			brokerId: $.url.user_id,
			userType: $.url.user_type,
			activityId: $.url.activityId,
			toUrlTime: new Date().format("yyyy-MM-dd hh:mm:ss")
	}, opt);
	if (opt.hidType)
		opt.housingId = $.url.hid
	else
		opt.objectId = $.url.hid;
	if (opt.pageId && opt.unitId){
		$.ajax({
			url: testhurl + '/dct/datacount/InsertDataCountForPC.sys?' + param(opt),
			timeout: 500,
			dataType: 'jsonp',
			jsonp: 'callbackparam',
			error: opt.error,
			success: opt.success,
			complete: opt.complete
		})
	}
}

$(window).on("load", function(){
	tracker({ action: 'load' });
})

$("body").on("click", "[unitId]", function(e){
	var url = this.href || '',
		pid = this.getAttribute('pageId') || pageId,
		uid = this.getAttribute('unitId') || unitId,
		act = this.getAttribute('action') || 'click',
		href = url.split('?')[0];
	if (url.indexOf('http') + 1){
		e.preventDefault();
		tracker({
			pageId: pid,
			unitId: uid,
			action: act,
			toUrl: href,
			complete: function(){
				location.href = url;
			}
		})
	}
	else {
		tracker({
			pageId: pid,
			unitId: uid,
			action: act
		})
	}
})

});