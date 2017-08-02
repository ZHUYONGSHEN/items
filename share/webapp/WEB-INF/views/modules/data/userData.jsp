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
</head>
<body>
<div class="mian_com">
	<h2 class="datadetailtitle mb20">${object.objectName}连接器数据日报</h2>
	<div class="data_detail_mian">
		<div class="data_detail_tab clear mb20">
			<li><a href="${backPath}/data/mainData?linkerId=${object.id}">关键数据</a></li>
			<li><a href="${backPath}/data/clickData?linkerId=${object.id}">点击行为</a></li>
			<li><a href="${backPath}/data/userLocationData?linkerId=${object.id}">访问用户所在地</a></li>
			<li><a href="${backPath}/data/accessLogData?linkerId=${object.id}">访问用户分时统计</a></li>
			<li class="cur"><a href="${backPath}/data/shareRelationData?linkerId=${object.id}">分享关系链</a></li>
		</div>
		<div class="data_detail_tab_mian">
		<!-- 关键数据 -->
			<div class="data_detail_keydata">
				<form class="data_detail_keydata_head clear mb20" id="searchForm" action="${backPath}/data/userData?linkerId=${linkerId}&openId=${openId}" method="post">
					<li class="datainput fl">
						统计日期:<input class="Wdate" id="beginDate" name="beginDate" type="text" readonly="readonly"
						value="<fmt:formatDate value="${beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />-
						<input class="Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
						value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
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
				</form>
				<div class="data_chart mb20">
					<p class="clear data_chart_select">
						<select class="fr" id="dataSelect">
							<option value="0">访问用户数</option>
							<option value="1">访问次数</option>
							<option value="2">拨打电话数</option>
							<option value="3">VR看房平均时长</option>
							<option value="4">分享次数</option>
						</select>
						<span class="fr mr10">可视化数据:</span>
					</p>
					<!-- 图表  -->
					<div id="container" style="height:270px"></div>
					
				</div>
				<div class="datacommontable data_detail_keytable" style="border-bottom:0px;">
					<li class="title clear">
						<p class="wone">统计日期</p>
						<p class="wseven">渠道</p>
						<p class="wtwo">访问用户数</p>
						<p class="wthree">访问次数</p>
						<p class="wfour">拨打电话数</p>
						<p class="wfree">VR看房平均时长(秒)</p>
						<p class="wsix" style="padding:10px 0px 10px 55px">分享次数</p>
					</li>
				</div>
				<div class="datacommontable data_detail_keytable data_detail_keytable_scroll">
					<c:forEach var="item" items="${list}">
						<li class="clear">
							<p class="wone"><fmt:formatDate value="${item.day}" pattern="yyyy-MM-dd"/></p>
							<p class="wseven">${item.channel_name }</p>
							<p class="wtwo">${item.wx_access_user_num}</p>
							<p class="wthree">${item.access_num}</p>
							<p class="wfour">0</p>
							<p class="wfree">0</p>
							<p class="wsix">${item.share_num}</p>
						</li>
					</c:forEach>
				</div>
				<p class="data_detail_tx_info mt20 mb5">说明:</p>
				<p class="data_detail_tx_info">   
				访问用户数：指的是连接器H5被打开的人数        访问次数：指连接器H5被打开的次数        拨打电话数：H5首页的“联系经纪人”号码点击确定拨打次数        VR看房平均时长：统计时间内，所有VR看房的时长／VR看房的点击用户数
   分享次数：指连接器H5页面被转发的次数，包括N级转发
   				</p>
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
		var chartJson=JSON.parse('${chart}');
	    var chart = new Highcharts.Chart('container', {
	        title: {
	            text: '',
	            x: -20
	        },
	        xAxis: {
	            categories: chartJson.categories
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
	        series: [chartJson.series[0]]
	    });
	    
	    $(function(){
	    	if("${channelId}"){
	    		$('select[name="channelId"] option[value=${channelId}]').attr('selected', 'selected');
	    	}
	    	
	    	$("#dataSelect").change(function(){
	    		var i=$(this).val();
	    		chart.series[0].update({
            		name: chartJson.series[i].name,
            		data:chartJson.series[i].data
        		});
	    	});
	    });
	</script>  
</body>
</html>