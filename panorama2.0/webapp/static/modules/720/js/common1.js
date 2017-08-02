user_type = getUrlParam('user_type');
token = getUrlParam('token');
secret_key = getUrlParam('secret_key');
var baseurl;
baseurl = 'http://app.hiweixiao.com';
var hi720url = 'http://fang.zooming-data.com/Formal';
var testhurl = 'http://hongbao.szzunhao.com'
var hongbaourl = 'http://hongbao.szzunhao.com'
var share_port = 'wxDataId=81'
var share_id = 'wxc6cc8db1517b3f28'

function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
    var r = window.location.search.substr(1).match(reg); //匹配目标参数
    if (r != null)
        return decodeURI(r[2]);
    return null; //返回参数值
}
Date.prototype.format = function(format) {
        var o = {
            "M+": this.getMonth() + 1, //month
            "d+": this.getDate(), //day
            "h+": this.getHours(), //hour
            "m+": this.getMinutes(), //minute
            "s+": this.getSeconds(), //second
            "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
            "S": this.getMilliseconds() //millisecond
        }
        if (/(y+)/.test(format))
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(format))
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        return format;
    }
    //生成随机数
function randomNum(under, over) {
    switch (arguments.length) {
        case 1:
            return parseInt(Math.random() * under + 1);
        case 2:
            return parseInt(Math.random() * (over - under + 1) + under);
        default:
            return 0;
    }
}
$(function() {
    //安卓手机头部样式-10px
    var ua = navigator.userAgent.toLowerCase();
    if (/android/.test(ua)) {
        $('.header').css('margin-top', '-10px')
        $('.blank110').css('margin-top', '-10px')
    }

    if (user_type == 2) //中原用户
    {
        $('#hideA').show();
    } else {
        $('#hideA').hide();
    }

    $('.quan_main_box').on('click', '.one_li', function() {
        var name = $(this).find('.one_li_left span').text()
        $('.person-info').show();
        $('.Fill07').hide()
        $('#username').val(name);
    });

    $("#warp input[type=file]").change(function() {
        if ($(this).prev().attr('src') != '') {
            $(this).next().hide();
        } else {
            $(this).next().show();
        }

    });

    $('#upfangyuans').click(function() {
        var a = true;
        if ($('#warp input[type=file]').val() == '') {
            a = false;
        }
        if (a == false) {
            alert('必须提供A+房源截图')
            return;
        } else {
            $('#ajiapic').css('display', 'block');
            var formData = new FormData($('#ajia')[0]);
            formData.append('secret_key', secret_key);
            formData.append('token', token);
            formData.append('user_type', user_type);
            var url = baseurl + '/Connector/MyHouse/uploadCapturePic';
            $.ajax({
                type: "POST",
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                dataType: "json",
                url: url,
                success: function(bkdata) {
                    if (bkdata.status) {
                        var strl = '已上传';
                        $('#hre05').val(strl);
                        $('#a_image').val(bkdata.data);
                        setTimeout(function() {
                            $('#ajiapic').css('display', 'none');
                            $('.shangchaun_2').hide();
                            $('.person-info').show();
                            $('#shen_tijiao').show();
                        }, 3000);
                    } else {
                        //alert(bkdata.info);
                        $('#ajiapic').css('display', 'none');
                        $('#ajiapic_error').show();
                        setTimeout(function() {
                            $('#ajiapic_error').css('display', 'none');
                        }, 3000)
                    }
                },
                error: function(e) {
                    console.log(e);
                },

            });
        }
    });

    $("#hongbao_left").click(function() {
        contact($('.scroll-wrap_right .one_geren'));
    });
    $("#hongbao_right").click(function() {
        contact($('.scroll-wrap_right .one_geren'), 2);
    });

    $('#check_ul').on('click', 'li', function() {
        $('input#href007').val($(this).find('a').text().trim());
        $('input#href007').attr('data-hid', $(this).attr('data-hid'));
        $('.adcodeaaa').val($(this).find('input').val());
        $('.person-info').show();
        $('#shen_tijiao').show();
        $('.Fill007').hide();
    });
    $('#shen_tijiao').on('click', function() {
        var url = baseurl + '/Connector/MyHouse/apply_Shooting';
        var hid = $('#href007').attr('data-hid');
        var village_name = $('#href007').val();
        var linkman = $('#username').val();
        var is_key = $("#hre01").val();
        //var is_key = $('#hre01').attr('data-num');
        var reservation_owner = $("#hre03").val();
        //var reservation_owner = $('#hre03').attr('data-num');
        var take_date = $('#hre06').val();
        var appointment_time = $('#hre08').val();
        var id = getUrlParam('id');
        if (hid == '') {
            alert('未知房源');
            return;
        }
        if (village_name == '') {
            alert('未知房源');
            return;
        }
        if (linkman == '') {
            alert('请选择联系人');
            return;
        }
        if (is_key == '') {
            alert('请选择是否有钥匙');
            return;
        }
        if (reservation_owner == '') {
            alert('请选择是否为预约业主');
            return;
        }

        if (take_date == '') {
            alert('请选择预约日期');
            return;
        }
        if (appointment_time == '') {
            alert('请选择预约时间');
            return;
        }
        var data = {
            'secret_key': secret_key,
            'token': token,
            'hid': hid,
            'village_name': village_name,
            'is_key': is_key,
            'linkman': linkman,
            'reservation_owner': reservation_owner,
            'take_date': take_date,
            'appointment_time': appointment_time,
            'user_type': user_type,
        }

        if (id != null) {
            data.id = id;
        }
        var ident = $('.identity').val();
        if (user_type == 2 || ident == 3) {
            //var capture_pic = $('#hre05').val();
            var capture_pic = $('#a_image').val();
            if (capture_pic == '') {
                alert('请选择A+系统房源截图');
                return;
            }
            data.pic = capture_pic;
        }

        $.ajax({
            type: 'POST',
            data: data,
            dataType: 'json',
            url: url,
            success: function(bkdata) {
                //console.log(bkdata)       	            	
                if (bkdata.status) {
                    alert('申请拍摄成功');
                    setTimeout(function() {
                        location.href = 'paishejilu.html?token=' + token + '&secret_key=' + secret_key + '&user_type=' + user_type;
                    }, 800)
                } else {
                    alert(bkdata.info)
                }
            },
            error: function(bkdata) {
                if (!bkdata.status) {
                    alert('提交失败');
                }
            }
        });
    });
})

function xuanzhefangyuan() {
    var url = baseurl + '/Connector/index/getApplylist';
    var data = {
        'secret_key': secret_key,
        'token': token,
        'user_type': user_type
    };
    $.ajax({
        type: "GET",
        data: data,
        dataType: 'json',
        url: url,
        success: function(bkdata) {
            var data = null;
            var name = '';
            var hid = 0;
            // console.log(bkdata.data);
            /*if (user_type == 1) {
                data = bkdata['data'].mine;
            } else if (user_type == 2) {
                data = bkdata['data']['data']['data_list'];
            }*/
            var data = bkdata.data;
            var tpl = '';
            $('#lurufangyuanaa').attr('href', '' + hi720url + '/APP/lurufangyuan.html?token=' + token + '&secret_key=' + secret_key + '&user_type=' + user_type);
            $(data).each(function(i) {
                /*                if (user_type == 1) {
                                    name = data[i].village_name;
                                    hid = data[i].hid;
                                } else if (user_type == 2) {
                                    name = data[i].estate_name;
                                    hid = data[i].house_id;
                                }*/
                name = data[i].village_name;
                hid = data[i].hid;
                adcode = data[i].adcode;
                house_no = data[i].house_no;
                room_count = data[i].room_count;
                hall_count = data[i].hall_count;
                really_area = data[i].really_area;
                if (data[i].type == 1) {
                    $('#lurufangyuanaa').css('display', 'none');
                }
                tpl += '<li data-hid="' + hid + '"><a href="javascript:void(0);">' + name + '</a><input value="' + adcode + '" type="hidden"/><span style="padding-left:0px">' + house_no +
                    '</span><span>' + room_count + '房' + hall_count + '厅</span><span>' + really_area + '㎡</span></li>'
            })
            $('#check_ul').html(tpl);
        },
    });
}

//联系人 //分组id区分客户1  还是经纪人2
function contact(wrap, groupId) {
    groupId = groupId || 1;
    var url = baseurl + '/connector/Contact/getAddressBook';
    var data = {
        'secret_key': secret_key,
        'token': token,
        'group_id': groupId,
        'user_type': user_type
    }
    var tpl = ''
    $.post(url, data, function(bk) {
        var data = bk.data;
        if (!data) {
            // alert('没有联系人');
            $('#alert_div').show();
        }
        $(data).each(function(i) {
            tpl += '<div class="one_li" data-id="' + data[i].id + '">'
            tpl += '<div class="one_li_left">'
            tpl += '<span>' + data[i].name + '</span>'
            tpl += '</div>'
            tpl += '<div class="one_li_right">'
            tpl += '<span>' + data[i].mobile + '</span>'
            tpl += '</div></div>'
        })
        wrap.html(tpl);
    }, 'json');
}

function meimie() {
    xuanzhefangyuan();
    $('.person-info').hide();
    $('#shen_tijiao').hide();
    $('.Fill007').show();
}

function pic2() {
    $('.person-info').hide();
    $('#shen_tijiao').hide();
    $('.shangchaun_2').show();
}


/**提示框插件**
 **autor : cj**
 **warning : 要在jquery文件之后加载该js**
 **config: msg(显示提示消息 String),
 **bgcolor(提示框背景颜色 String),
 **fade(是否自动隐藏boolean),
 **second(自动隐藏时间int),
 **place(距离底部的距离int,百分比,也可以写"top","middle","bottom"),
 **togglespeed(提示框显示隐藏过渡时间)
 **时间单位 : 秒
 **可用接口 : destroy**/
;(function($) {
    var Mesgbox = function(ele, opt) {
        this.$element = ele,
            this.defaults = {
                msg: "msg",
                bgcolor: "#AAD7FF",
                fade: true,
                second: 3,
                togglespeed: 0.2,
                place: 5
            },
            this.setting = $.extend({}, this.defaults, opt),
            this.creatMsgbox = function() {
                var boxClass = "infos_box";
                var boxDesc = "infos_desc";
                var defaultBoxCss = {
                    "position": "fixed",
                    "display": "none",
                    "bottom": "5%",
                    "width": "80%",
                    "z-index": "50",
                    "left": "50%",
                    "margin-left": "-40%",
                    "padding": "0px",
                    "box-sizing": "border-box",
                    "background": "#AAD7FF",
                    "border-radius": "10px",
                    "-webkit-border-radius": "10px"
                };
                var defaultDescCss = {
                    "width": "100%",
                    "position": "relative",
                    "text-align": "center",
                    "vertical-align": "middle",
                    "font-size": "0.4rem",
                    "font-weight": "600",
                    "color": "#000000",
                    "display": "block",
                    "padding-top": "1vh",
                    "padding-bottom": "1vh"

                };
                var msgs = " ";
                var box = {};
                msgs = "<div class='" + boxClass + "'><p class='" + boxDesc + "'></p></div>";
                box.boxClass = boxClass;
                box.boxDesc = boxDesc;
                box.msgs = msgs;
                box.defaultBoxCss = defaultBoxCss;
                box.defaultDescCss = defaultDescCss;
                return box;
            }
    }
    Mesgbox.prototype = {
        init: function() {
            var t;
            var msgbox;
            var $this = this;
            var place;
            msgbox = this.creatMsgbox();
            if (!this.$element.has("." + msgbox.boxClass).length) {
                this.$element.append(msgbox.msgs);
            }
            if (typeof($this.setting.place) == "number") {
                place = ($this.setting.place).toString() + "%";
            } else if (typeof($this.setting.place) == "string") {
                switch ($this.setting.place) {
                    case "top":
                        place = "85%";
                        break;
                    case "middle":
                        place = "50%";
                        break;
                    case "bottom":
                        place = "5%";
                        break;
                    default:
                        place = "5%";
                        break;
                }
            }
            $("." + msgbox.boxDesc).css(msgbox.defaultDescCss).text(this.setting.msg);
            return $("." + msgbox.boxClass).css(msgbox.defaultBoxCss).css({
                "background": $this.setting.bgcolor,
                "bottom": place
            }).fadeIn("" + $this.setting.togglespeed * 1000 + "", function() {
                if ($this.setting.fade) {
                    clearTimeout(t);
                    t = setTimeout(function() {
                        $(".infos_box").fadeOut("" + $this.setting.togglespeed * 1000 + "");
                    }, $this.setting.second * 1000);
                }
            });
        },
        destroy: function(opt) {
            if ($(opt).length) {
                $(opt).remove();
            } else {
                $.error("Dom " + opt + " is not exist");
            }
        }
    }
    $.fn.msgbox = function(options) {
        var box = new Mesgbox(this, options); //实例化
        if (box[options]) {
            return box[options].apply(this, Array.prototype.slice.call(this, arguments));
        } else if (typeof options === 'object' || !options) {
            return box.init();
        } else {
            $.error("Method " + options + " is not exist on jQuery.msgbox");
        }
    }
})(jQuery);

$.fn.alert = function(opt) {
    if (this[0].$alert)
        return this[0].$alert;
    var obj = $('<div class="alert"></div>').appendTo("body"),
        box = $('<div class="alert-box"></div>').appendTo(obj).html(this);
    var alert = {
        obj: obj,
        box: box,
        show: function() {
            obj.show();
            box.animate({
                top: 0,
                opacity: 1
            }, 200).css({
                marginTop: ($(window).height() - box.height()) / 2.4
            });
        },
        hide: function() {
            box.animate({
                top: -20,
                opacity: 0
            }, 200, function() {
                obj.hide();
            });
        },
        html: function(i1, i2) {
            box.html(i1);
            if (i2 != false) {
                alert.show();
            }
        },
        init: function() {
            box.animate({
                top: -20,
                opacity: 0
            }, 0);
            obj.on("click", function(e) {
                if ($.contains(e.target, box[0]))
                    alert.hide();
            })
            obj.on("click", ".close", function() {
                alert.hide();
            })
        }()
    }
    return this[0].$alert = alert, alert;
};

;(function(){
	function alertBox(opts){
		this.opt={
			bgclass:'background:#000;opacity:0.5;top:0px;left:0px;position:fixed;z-index:996;height:100%;width:100%;',
			divclass:'top:50%;left:50%;position:fixed;z-index:997;width:70%',
			msgclass:'background:#fff;top:50%;right:50%;position:relative;z-index:997;text-align:center;font-size:0.28rem;border-radius:5px',
			fcallfn:false,
			tcallfn:false
		}
		this.settings(opts)
		this.inits(this.opt)
	}
	alertBox.prototype={
		inits:function(opt){
			var _this = this
			$('body').append('<div id="alertboxbg" style="'+opt.bgclass+'"></div><div id="alretboxmian" style="'+opt.divclass+'"><div style="'+opt.msgclass+'"><p style="padding: 0.4rem;">'+opt.msg+'</p><p class="alertbox_button"><span id="alertboxfalse">否</span><span id="alertboxtrue">是</span></p></div></div>')
			$('#alertboxtrue').unbind().bind('click',function(){
				_this.hidealerbox()
				if(_this.opt.tcallfn){
					_this.opt.tcallfn()
				}
			})
			$('#alertboxfalse').unbind().bind('click',function(){
				_this.hidealerbox()
				if(_this.opt.fcallfn){
					_this.opt.fcallfn()
				}
			})
		},
		hidealerbox:function(){
			$('#alertboxbg').remove()
			$('#alretboxmian').remove()
		},
		settings:function(opts){
			for(var i in opts){
				//this.opt
				this.opt[i] = opts[i]
			}
			return this.opt
		}
	}                                 
	window.alertbox = function(options){
		return new alertBox(options)
	}
})(window,document)
