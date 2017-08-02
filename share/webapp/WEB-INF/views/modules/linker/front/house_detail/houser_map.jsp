<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
<meta name='apple-mobile-web-app-capable' content='yes' />
<meta content="black" name="apple-mobile-web-app-status-bar-style" />
<meta content="telephone=no" name="format-detection" />
<title>地图</title>
<link type="text/css" href="${backStatic}/css/common_app.css" rel="stylesheet">
<style>
#houser_map{position:absolute;width:100%;top:0px;left:0px;height:calc(100% - 68px);}
.tx-wen{position:absolute;width:100%;bottom:5px;background:#fff;color:#c2c7c8;font-size:14px;}
.tx-wen li{float:left;width:16.6%;text-align:center;position:relative;}
.houser_list{position:absolute;width:100%;height:68px;bottom:0px;background:#fff;border-top:1px solid #ccc;}
.houser_list li{float:left;width:16.6%;text-align:center;height:100%;position:relative;}
.houser_list li img{width:40%;position:absolute;top:10px;left:50%;margin-left:-20%;}
.clear{
	clear:both;
}
.color_00ccff{color:#00ccff}
.color_0{color:#00ccff}
.clear:after {visibility:hidden;display:block;font-size:0;content:" ";	clear:both;height:0}
</style>
</head>
<body>
	<div id="houser_map">
	
	</div>
	<div class="houser_list clear">
		<li data-so="0"><img src="${backStatic}/images/h5-icon/gj.png"></li>
		<li data-so="1"><img src="${backStatic}/images/h5-icon/dt.png"></li>
		<li data-so="1"><img src="${backStatic}/images/h5-icon/xx.png"></li>
		<li data-so="1"><img src="${backStatic}/images/h5-icon/sc.png"></li>
		<li data-so="1"><img src="${backStatic}/images/h5-icon/yy.png"></li>
		<li data-so="1"><img src="${backStatic}/images/h5-icon/yh.png"></li>
	</div>
	<div class="tx-wen">
			<li>公交</li>
			<li>地铁</li>
			<li>学校</li>
			<li>商超</li>
			<li>医院</li>
			<li>银行</li>
	</div>
	<input type="hidden" id="latitude">
	<input type="hidden" id="longitude">
	
	<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
	<script type="text/javascript" src="${backStatic}/js/common1.js"></script>
	<script type="text/javascript" src="${backStatic}/js/public.js"></script>
	<script type="text/javascript" src="${backStatic}/js/rem.js"></script>
	<script type="text/javascript" src="http://cdn.szzunhao.com/hongbao/js/jweixin-1.0.0.js"></script>
	<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=3GJBZ-3SURO-6DVWN-SK5WL-YOG6H-3SF3H"></script>
	<script>
		var search_arr=['公交','地铁','学校','商场','医院','银行'],searchService,map,markers = [];
		$('#latitude').val(getUrlParam('la'))
		$('#longitude').val(getUrlParam('lo'))
		console.log($('#longitude').val())
		map_init(getUrlParam('la'),getUrlParam('lo'),getUrlParam('name'),getUrlParam('add'))
		if(getUrlParam('search')>=0){
			searchKeyword(getUrlParam('search'),getUrlParam('la'),getUrlParam('lo'))
			$('.tx-wen').find('li').removeClass('color_00ccff').eq(getUrlParam('search')).addClass('color_00ccff')
			$('.houser_list li').eq(getUrlParam('search')).find('img').attr('src',$('.houser_list li').eq(getUrlParam('search')).find('img').attr('src').split('.')[0].split('_')[0]+'_cur.png')
		}
		function map_init(laa,lo,addname,add) {
			var myLatlng = new qq.maps.LatLng(laa,lo);
			var myOptions = {
				zoom: 16,
				center: myLatlng,
				disableDefaultUI: true
			};
			var map = new qq.maps.Map(document.getElementById("houser_map"), myOptions);
			var anchorsa = new qq.maps.Point(16, 42),
		        size = new qq.maps.Size(32, 42),
		        origin = new qq.maps.Point(0, 0),
		        icon = new qq.maps.MarkerImage("${backStatic}/images/h5-icon/mo.png",size, origin,anchorsa);
			var marker = new qq.maps.Marker({
				icon: icon,
				position: myLatlng,
				map: map,
				zIndex:9999999
			});
			
			var infoWin = new qq.maps.InfoWindow({
		        map: map
		    });
			 qq.maps.event.addListener(marker, "click",function() {
				infoWin.open();
				infoWin.setContent('<div style="font-size:14px"><p>名称:'+addname+'</p><p>地址:'+add+'</p></div>');
				infoWin.setPosition(myLatlng);
			})
			var latlngBounds = new qq.maps.LatLngBounds();
	
			//调用Poi检索类
			searchService = new qq.maps.SearchService({
				complete : function(results){
					var pois = results.detail.pois;
					console.log(pois)
					for(var i = 0,l = pois.length;i < l; i++){
						(function(i){
							var poi = pois[i];
							latlngBounds.extend(poi.latLng); 
							var icon ;
							switch(true){
								case poi.category.indexOf('公交')>=0:
								console.log(0)
									icon= new qq.maps.MarkerImage('${backStatic}/images/h5-icon/gj-icon.png',size, origin,anchorsa);
									break;
								case poi.category.indexOf('地铁')>=0:
								console.log(1)
									icon= new qq.maps.MarkerImage('${backStatic}/images/h5-icon/dt-icon.png',size, origin,anchorsa);
									break;
									case poi.category.indexOf('学校')>=0:
									console.log(2)
									icon= new qq.maps.MarkerImage('${backStatic}/images/h5-icon/xx-icon.png',size, origin,anchorsa);
									break;
									case poi.category.indexOf('商场')>=0:
									console.log(poi.category.indexOf('商场'))
									icon= new qq.maps.MarkerImage('${backStatic}/images/h5-icon/sc-icon.png',size, origin,anchorsa);
									break;
									case poi.category.indexOf('医院')>=0:
									console.log(4)
									icon= new qq.maps.MarkerImage('${backStatic}/images/h5-icon/yy-icon.png',size, origin,anchorsa);
									break;
									case poi.category.indexOf('银行')>=0:
									
									console.log(5)
									icon= new qq.maps.MarkerImage('${backStatic}/images/h5-icon/yh-icon.png',size, origin,anchorsa);
									break;
							}
							
							var marker = new qq.maps.Marker({
								icon: icon,
								map:map,
								position: poi.latLng
							});
							marker.setTitle(i+1);
							markers.push(marker);
							infoWin.close();
							qq.maps.event.addListener(marker, "click",function() {
								//console.log(pois[i])
								infoWin.open();
								infoWin.setContent('<div style="font-size:14px"><p>名称:'+pois[i].name+'</p><p>地址:'+pois[i].address+'</p></div>');
								infoWin.setPosition(pois[i].latLng);
								
							})
						})(i)
					}
					map.fitBounds(latlngBounds);
				}
			});
			
		}
		function clearmark() {
		    if (markers) {
		        for (i in markers) markers[i].setMap(null);
		        markers.length = 0
		    }
		}
		function searchKeyword(search,la,lo) {
		clearmark();
		    var keyword = search_arr[search];
		    region = new qq.maps.LatLng(la,lo);
		    searchService.setPageCapacity(2e3);
		    searchService.searchNearBy(keyword, region, 3000);//根据中心点坐标、半径和关键字进行周边检索。
		}
		$('.houser_list li').click(function(){
				var srcs = $(this).find('img')
				$('.houser_list li').find('img').each(function(){
					$(this).attr('src',$(this).attr('src').split('.')[0].split('_')[0]+'.png')
				})
				srcs.attr('src',srcs.attr('src').split('.')[0].split('_')[0]+'_cur.png')
				searchKeyword($(this).index(),$('#latitude').val(),$('#longitude').val())
				$('.tx-wen').find('li').removeClass('color_00ccff').eq($(this).index()).addClass('color_00ccff')
		})
	</script>
</body>
</html>