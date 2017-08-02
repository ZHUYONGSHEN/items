<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
 <meta name='apple-mobile-web-app-capable' content='yes' />
 <meta content="black" name="apple-mobile-web-app-status-bar-style" />
 <meta content="telephone=no" name="format-detection" />
 <title>导航</title>
<style type="text/css">
#container{
	min-width:370px;
	min-height:300px;
}
</style>
</head>
<body>
<script charset="utf-8" src="http://map.qq.com/api/js?v=2.exp&key=3GJBZ-3SURO-6DVWN-SK5WL-YOG6H-3SF3H"></script>
<script type="text/javascript" src="${backStatic}/js/jquery.min.2.2.2.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<div style='margin: 5px 0px'>
		<!-- <b>起点: </b> <select id="start" onchange="calcRoute();">
			<option value="22.816730,108.366900">22.816730,108.366900</option>
		</select><br>
		 <b>终点: </b> <select id="end" onchange="calcRoute();">
			<option value="22.5807100000,113.9038300000">22.5807100000,113.9038300000</option> 
		</select> --><b>计算策略：</b> <select id="policy" onchange="calcRoute();">
			<option value="LEAST_TIME">最少时间</option>
			<option value="LEAST_DISTANCE">最短距离</option>
			<option value="AVOID_HIGHWAYS">避开高速</option>
			<option value="REAL_TRAFFIC">实时路况</option>
			<option value="PREDICT_TRAFFIC">预测路况</option>
		</select> <label> <input id="sp" type="checkbox" value='1'
			onclick='showP()' /> 显示路段地标
		</label>
	</div>
	<input type="hidden" id="flatitude"  value="${latitude}"/>
	<input type="hidden" id="flongitude" value="${longitude}"/>
	<input type="hidden" id="zlatitude" value=""/>
	<input type="hidden" id="zlongitude" value=""/>
	<input type="hidden" id="city" value="${city}"/>
	<div id="container"></div>
	<div style="width: 370px; padding-top: 5px" id="routes"></div>
<script>
wx.config({
	debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
	appId : '${signature["appid"]}', // 必填，公众号的唯一标识
	timestamp : '${signature["timestamp"]}', // 必填，生成签名的时间戳
	nonceStr : '${signature["noncestr"]}', // 必填，生成签名的随机串
	signature : '${signature["signature"]}',// 必填，签名，见附录1
	jsApiList : ['getLocation']
// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
});
wx.ready(function(){
	wx.getLocation({
	    type: 'wgs84', // 默认为wgs84的gps坐标，如果要返回直接给openLocation用的火星坐标，可传入'gcj02'
	    success: function (res) {
	        var latitude = res.latitude; // 纬度，浮点数，范围为90 ~ -90
	        var longitude = res.longitude; // 经度，浮点数，范围为180 ~ -180。
	        $("#zlatitude").val(latitude);
	        $("#zlongitude").val(longitude);
	        init();
	    },
	    cancel:function(res){
	    	init();
		}
	})
});
var backStatic='${backStatic}';
    var map, 
        directionsService = new qq.maps.DrivingService({
            complete : function(response){
                var start = response.detail.start,
                    end = response.detail.end;
                console.info(start);
                console.info(end);
                var anchor = new qq.maps.Point(6, 6),
                    size = new qq.maps.Size(24, 36),
                    start_icon = new qq.maps.MarkerImage(
                    		backStatic+'/images/busmarker.png', 
                        size, 
                        new qq.maps.Point(0, 0),
                        anchor
                    ),
                    end_icon = new qq.maps.MarkerImage(
                    		backStatic+'/images/busmarker.png', 
                        size, 
                        new qq.maps.Point(24, 0),
                        anchor
                        
                    );
                start_marker && start_marker.setMap(null); 
                end_marker && end_marker.setMap(null);
                clearOverlay(route_lines);
                
                start_marker = new qq.maps.Marker({
                      icon: start_icon,
                      position: start.latLng,
                      map: map,
                      zIndex:1
                });
                end_marker = new qq.maps.Marker({
                      icon: end_icon,
                      position: end.latLng,
                      map: map,
                      zIndex:1
                });
               directions_routes = response.detail.routes;
               var routes_desc=[];
               //所有可选路线方案
               for(var i = 0;i < directions_routes.length; i++){
                    var route = directions_routes[i],
                        legs = route; 
                    //调整地图窗口显示所有路线    
                    map.fitBounds(response.detail.bounds); 
                    //所有路程信息            
                    //for(var j = 0 ; j < legs.length; j++){
                        var steps = legs.steps;
                        route_steps = steps;
                        polyline = new qq.maps.Polyline(
                            {
                                path: route.path,
                                strokeColor: '#3893F9',
                                strokeWeight: 6,
                                map: map
                            }
                        )  
                        route_lines.push(polyline);
                         //所有路段信息
                        for(var k = 0; k < steps.length; k++){
                            var step = steps[k];
                            //路段途经地标
                            directions_placemarks.push(step.placemarks);
                            //转向
                            var turning  = step.turning,
                                img_position;; 
                            switch(turning.text){
                                case '左转':
                                    img_position = '0px 0px'  
                                break;
                                case '右转':
                                    img_position = '-19px 0px'  
                                break;
                                case '直行':
                                    img_position = '-38px 0px'  
                                break;  
                                case '偏左转':
                                case '靠左':
                                    img_position = '-57px 0px'  
                                break;      
                                case '偏右转':
                                case '靠右':
                                    img_position = '-76px 0px'  
                                break;
                                case '左转调头':
                                    img_position = '-95px 0px'  
                                break;
                                default:
                                    mg_position = ''  
                                break;
                            }
                            var turning_img = '&nbsp;&nbsp;<span'+
                                ' style="margin-bottom: -4px;'+
                                'display:inline-block;background:'+
                                'url('+backStatic+'/images/turning.png) no-repeat '+
                                img_position+';width:19px;height:'+
                                '19px"></span>&nbsp;' ;
                            var p_attributes = [
                                'onclick="renderStep('+k+')"',
                                'onmouseover=this.style.background="#eee"',
                                'onmouseout=this.style.background="#fff"',
                                'style="margin:5px 0px;cursor:pointer"'
                            ].join(' ');
                            routes_desc.push('<p '+p_attributes+' ><b>'+(k+1)+
                            '.</b>'+turning_img+step.instructions);
                        }
                    //}
               }
               //方案文本描述
               var routes=document.getElementById('routes');
               routes.innerHTML = routes_desc.join('<br>');
            }
        }),
        directions_routes,
        directions_placemarks = [],
        directions_labels = [],
        start_marker,
        end_marker,
        route_lines = [],
        step_line,
        route_steps = [];

    function init() {
        map = new qq.maps.Map(document.getElementById("container"), {
            // 地图的中心地理坐标。
            center: new qq.maps.LatLng("${latitude}","${longitude}")
        });
        calcRoute();
    }
    function calcRoute() {
        var start_lat = $("#flatitude").val();
        var start_long = $("#flongitude").val();
        var end_lat = $("#zlatitude").val();
        var end_long = $("#zlongitude").val();
        route_steps = [];
            
        directionsService.setLocation("${city}");
        directionsService.setPolicy(qq.maps.DrivingPolicy[policy]);
        directionsService.search(new qq.maps.LatLng(start_lat, start_long), 
        new qq.maps.LatLng(end_lat, end_long)); 
    }
    //清除地图上的marker
    function clearOverlay(overlays){
        var overlay;
        while(overlay = overlays.pop()){
            overlay.setMap(null);
        }
    }
    function renderStep(index){   
        var step = route_steps[index];
        //clear overlays;
        step_line && step_line.setMap(null);
        //draw setp line      
        step_line = new qq.maps.Polyline(
            {
                path: step.path,
                strokeColor: '#ff0000',
                strokeWeight: 6,
                map: map
            }
        )
    }
    //显示路段路标
    function showP(){
        var showPlacemark  = document.getElementById('sp');
        if(showPlacemark.checked){
            for(var i=0;i<directions_placemarks.length;i++){
                var placemarks = directions_placemarks[i];
                for(var j=0;j<placemarks.length;j++){
                    var placemark = placemarks[j];
                    var label = new qq.maps.Label({
                        map: map,
                        position: placemark.latLng,
                        content:placemark.name
                    });
                    directions_labels.push(label);
                }
            }
        }else{
            clearOverlay(directions_labels);
        }
    } 
</script>
</body>
</html>