<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>连接器数据</title>
    <meta name="decorator" content="admin"/>
	<style type="text/css">
    	.Wdate{
			background: #fff url(${backStatic}/images/daterili.png) no-repeat 123px;
		}
		.highcharts-credits {
			display:none !important;
		}
    </style>
    <script type="text/javascript">
	    $(function(){
	    	$("#btnExport").click(function(){
	        	$("#searchForm").attr("action","${backPath}/data/exportAccessLogData?linkerId=${object.id}");
	    		$("#searchForm").submit();
	    		$("#searchForm").attr("action","${backPath}/data/accessLogData?linkerId=${object.id}");
	    	});
	    	defaultAddr={
	    			"sheng":"${log.province}",
	    			"shi":"${log.city}",
	    			"qu":"${log.county}"
	    	};
	    	$.initcity(defaultAddr,$("#province"),$("#city"),$("#county"));
	    	if("${log.channelId}"){
	    		$('select[name="channelId"] option[value=${log.channelId}]').attr('selected', 'selected');
	    	}
	    })
    </script>   
</head>
<body>
<div class="mian_com">
	<h2 class="datadetailtitle mb20">${object.objectName}连接器数据日报</h2>
	<div class="data_detail_mian">
		<div class="data_detail_tab clear mb20">
			<li><a href="${backPath}/data/mainData?linkerId=${object.id}">关键数据</a></li>
			<li><a href="${backPath}/data/clickData?linkerId=${object.id}">点击行为</a></li>
			<li><a href="${backPath}/data/userLocationData?linkerId=${object.id}">访问用户所在地</a></li>
			<li class="cur"><a href="${backPath}/data/accessLogData?linkerId=${object.id}">访问用户分时统计</a></li>
			<li><a href="${backPath}/data/shareRelationData?linkerId=${object.id}">分享关系链</a></li>
		</div>
		<div class="data_detail_tab_mian">
			<!-- 访问用户分时统计 -->
			<div class="data_detail_detadata">
				<form class="data_detail_keydata_head clear mb20" id="searchForm" action="${backPath}/data/accessLogData?linkerId=${object.id}" method="post">
					<li class="datainput fl">
						统计日期:<input class="Wdate" id="beginDate" name="beginDate" type="text" readonly="readonly"
						value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />-
						<input class="Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
						value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</li>
					<li class="fl dataslect ml20">选择地区:
						<select class="ml10" id="province" name="province"></select>
						<select class="ml10" id="city" name="city"></select>
						<select class="ml10" id="county" name="county"></select>
					</li>
					<li class="fl dataslect ml20">渠道:
						<select class="ml10" id="channel" name="channelId">
							<option value="">全部</option>
							<c:forEach var="item" items="${channelList}">
							<option value="${item.id}">${item.channelName }</option>
							</c:forEach>
						</select>
					</li>
					<li class="fl ml20"><input type="submit"  class="loglistsearch_sub blue_btn_com ml20 fl" value="查询"></li>
					<li class="fr color_16d38e mt10" id="btnExport"><i class="icon_excel mr5"></i>导出数据报表</li>
				</form>
				<div class="data_detail_detatable mb20">
					<li class="clear">
						<p class="wone">时间段(时)</p>
						<p class="wcommon">0</p>
						<p class="wcommon">1</p>
						<p class="wcommon">2</p>
						<p class="wcommon">3</p>
						<p class="wcommon">4</p>
						<p class="wcommon">5</p>
						<p class="wcommon">6</p>
						<p class="wcommon">7</p>
						<p class="wcommon">8</p>
						<p class="wcommon">9</p>
						<p class="wcommon">10</p>
						<p class="wcommon">11</p>
						<p class="wcommon">12</p>
						<p class="wcommon">13</p>
						<p class="wcommon">14</p>
						<p class="wcommon">15</p>
						<p class="wcommon">16</p>
						<p class="wcommon">17</p>
						<p class="wcommon">18</p>
						<p class="wcommon">19</p>
						<p class="wcommon">20</p>
						<p class="wcommon">21</p>
						<p class="wcommon">22</p>
						<p class="wcommon">23</p>
					</li>
					<li class="clear">
						<p class="wone">访问次数</p>
						<p class="wcommon">${data.h0}</p>
						<p class="wcommon">${data.h1}</p>
						<p class="wcommon">${data.h2}</p>
						<p class="wcommon">${data.h3}</p>
						<p class="wcommon">${data.h4}</p>
						<p class="wcommon">${data.h5}</p>
						<p class="wcommon">${data.h6}</p>
						<p class="wcommon">${data.h7}</p>
						<p class="wcommon">${data.h8}</p>
						<p class="wcommon">${data.h9}</p>
						<p class="wcommon">${data.h10}</p>
						<p class="wcommon">${data.h11}</p>
						<p class="wcommon">${data.h12}</p>
						<p class="wcommon">${data.h13}</p>
						<p class="wcommon">${data.h14}</p>
						<p class="wcommon">${data.h15}</p>
						<p class="wcommon">${data.h16}</p>
						<p class="wcommon">${data.h17}</p>
						<p class="wcommon">${data.h18}</p>
						<p class="wcommon">${data.h19}</p>
						<p class="wcommon">${data.h20}</p>
						<p class="wcommon">${data.h21}</p>
						<p class="wcommon">${data.h22}</p>
						<p class="wcommon">${data.h23}</p>
					</li>
				</div>
				<div class="data_chart mb20 clear">
					<p class="data_chart_date_title">${object.objectName}连接器用户访问量分时统计</p>
					<!-- 图表 -->
					<div style="height:370px" id="container"></div>
				</div>
				<p class="data_detail_tx_info mt20 mb5">提示:</p>
				<p class="data_detail_tx_info">   
				  在用户浏览量较高的时段进行刷新操作，可获得更好的推广效果
   				</p>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		/* var $wcommon = $('.wcommon'),
			$mianCom = $('.mian_com');
		(function setWcommonWidth (){
			clearTimeout(clearTime);
			var mianComWidth = $mianCom.width();
			console.log(mianComWidth);
			if(mianComWidth >= 1800){
				$wcommon.css('width','3.949%');
			} else if(mianComWidth >= 1560){
				console.log('第二个');
				$wcommon.css('width','3.915%');
			} else {
				$wcommon.css('width','3%');
			}
			var clearTime = setTimeout(setWcommonWidth,2000);
		})(); */
		var categories=[];
		for(var i=0;i<24;i++){
			categories.push(i+"时");
		}
	    var chart = new Highcharts.Chart('container', {
	        title: {
	            text: '',
	            x: -20
	        },
	        xAxis: {
	            categories: categories
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
	        },
	        tooltip: {
	            valueSuffix: ''
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'middle',
	            borderWidth: 0
	        },
	        series: [{name:'访问次数',data:[${data.h0},${data.h1},${data.h2},${data.h3},${data.h4},${data.h5},${data.h6},${data.h7},
	            ${data.h8},${data.h9},${data.h10},${data.h11},${data.h12},${data.h13},${data.h14},${data.h15},
	            ${data.h16},${data.h17},${data.h18},${data.h19},${data.h20},${data.h21},${data.h22},${data.h23}]
	        }]
	    });
	</script>  
</body>
</html>