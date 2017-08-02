$.fn.alert = function(opt){
	if (this[0].$alert)
	return this[0].$alert;
	var obj = $('<div class="alert-main"></div>').appendTo("body"),
		box = $('<div class="alert-box"></div>').appendTo(obj).html(this);
	var alert = {
		obj: obj,
		box: box,
		show: function(){
			obj.show();
			box.animate({
				top: 0,
				opacity: 1
			}, 200).css({
				marginTop: ($(window).height() - box.height()) / 2.4
			});
		},
		hide: function(){
			box.animate({
				top: -20,
				opacity: 0
			}, 200, function(){ obj.hide(); });
		},
		html: function(i1, i2){
			box.html(i1);
			if (i2 != false){
				alert.show();
			}
		},
		init: function(){
			box.animate({
				top: -20,
				opacity: 0
			}, 0);
			obj.on("click", function(e){
				if ($.contains(e.target, box[0]))
				alert.hide();
			})
			obj.on("click", ".close", function(){
				alert.hide();
			})
		}()
	}
	return this[0].$alert = alert, alert;
};