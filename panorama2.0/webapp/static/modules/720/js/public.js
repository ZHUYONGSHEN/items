//table切换
$(function() {
	$('#hongbao_left').on('click', function() {
		$('.nei_left_a').css('display', 'block');
		$('.nei_right_b').css('display', 'none');
		$('#hongbao_left').addClass('clickk');
		$('#hongbao_right').removeClass('clickk');
	}), $('#hongbao_right').on('click', function() {
		testActivitys();
		$('.nei_right_b').css('display', 'block');
		$('.nei_left_a').css('display', 'none');
		$('#hongbao_right').addClass('clickk');
		$('#hongbao_left').removeClass('clickk');
	})
});



//table切换
$(function(){
	$('#Fang_left').on('click',function(){
		$('.second_house').css('display','block');
		$('.new_house').css('display','none');
		$('#Fang_left').addClass('clickk');
		$('#Fang_right').removeClass('clickk');
		$('.seach').removeClass('seach_left');
		$(".add_F").show();
	}),$('#Fang_right').on('click',function(){
		$('.new_house').css('display','block');
		$('.second_house').css('display','none');
		$('#Fang_right').addClass('clickk');
		$('#Fang_left').removeClass('clickk');
		$('.seach').addClass('seach_left');
		$(".add_F").hide();
	})
});

//底部切换
$(document).on('click','.bottom_main_menu li',function(){
	if($(this).hasClass('active')) return;

	switch ($(this).index()){
		case 0 :
			window.location.href = "index.html"
			break;
		case 1 :
			window.location.href = "fangyuan.html"
			break;
		case 2 :

			window.location.href = "lianxiren.html"

			break;
		case 3 :
			window.location.href = "login-center.html"
			break;
		default:
			break;
	}
})

//轮播图
$(function(){
	initFontSize();
function initFontSize() {
	document.documentElement.style.fontSize = document.documentElement.clientWidth / 7.5 + 'px';
};
//$('.carousel-image2').CarouselImage({
//	num :$('.carousel-image2 .carousel-num'),
//	repeat:true
//});
//$('.carousel-image1').CarouselImage({
//	num :$('.carousel-image1 .carousel-num'),
//	width:320,
//	height:240
//});
//$('.carousel-image3').CarouselImage({
//	num :$('.carousel-image3 .carousel-num'),
//	auto:false
//});
//var car = new CarouselImage();
//$('.hot-list').find('a').eq(1).addClass('focus')
//car.init({
//	target:$('.hot-list'),
//	auto:false,
//	resizeImg:false,
//	step:$('.hot-list .item:not(.focus)').width(),
//	changeCallback:function(){
//		$(this.container).find('a').eq(this.index).addClass('focus').siblings().removeClass('focus');
//		var left=($(this.container).width()-$(this.container).find('a.focus').width())/2;
//		var posLeft=left-$(this.container).find('a.focus').position().left ;
//		$(this.content).stop().css('left',posLeft);
//	},callback:function(){
//		this.index=1;
//		console.log(this.content)
//		var w = 0;
//		this.content.children().each(function(){
//			w+=$(this).outerWidth();
//		});
//		this.content.width(w);
//		this.go();
//	}
//});
})

//shouyelunbo
$(function(){
	var $index = 0;
	var $before = 0;
	var $l = $('#divbox > img').size();
	var iTime = null;
	$('.scroll > span').mouseover(function(){
		$(this).addClass('active').siblings().removeClass('active');
		$index = $(this).index();
		scrollPlay();
		$before = $index;
	});
	function scrollPlay()
	{
		$('.scroll > span').eq($index).addClass('active').siblings().removeClass('active');
		if($index == $l-1 && $before == 0)
		{
			prev();
		}
		else if($index == 0 && $before == $l-1)
		{
			next();
		}
		else if($index > $before)
		{
			next();
		}
		else if($index < $before)
		{
			prev();
		};
	};
	function next()
	{
		$('#divbox > img').eq($before).animate({'left':'-100%'});
		$('#divbox > img').eq($index).css('left','100%').stop().animate({'left':'0'});
	};
	function prev()
	{
		$('#divbox > img').eq($before).animate({'left':'100%'});
		$('#divbox > img').eq($index).css('left','-100%').stop().animate({'left':'0'});
	};

	autoPlay();
	function autoPlay()
	{
		iTime = setInterval(function(){
			$index++;
			if($index > $l-1)
			{
				$index = 0;
				$before = $l-1;
			};
			scrollPlay();
			$before = $index;
		},3000)
	};
	$('.scroll > span').hover(function(){
		clearInterval(iTime);
	},function(){
		autoPlay();
	});

});


