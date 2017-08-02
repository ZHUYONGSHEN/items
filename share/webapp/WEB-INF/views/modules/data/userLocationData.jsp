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
	        	$("#searchForm").attr("action","${backPath}/data/exportUserLocationData?linkerId=${object.id}");
	    		$("#searchForm").submit();
	    		$("#searchForm").attr("action","${backPath}/data/userLocationData?linkerId=${object.id}");
	    	});
	    	
	    	defaultAddr={
	    			"sheng":"${log.province}",
	    			"shi":"${log.city}",
	    			"qu":""
	    	};
	    	$.initcity(defaultAddr,$("#province"),$("#city"));
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
			<li class="cur"><a href="${backPath}/data/userLocationData?linkerId=${object.id}">访问用户所在地</a></li>
			<li><a href="${backPath}/data/accessLogData?linkerId=${object.id}">访问用户分时统计</a></li>
			<li><a href="${backPath}/data/shareRelationData?linkerId=${object.id}">分享关系链</a></li>
		</div>
		<div class="data_detail_tab_mian">
			<!-- 访问用户所在地 -->
			<div class="data_detail_vivsitdata">
				<form class="data_detail_keydata_head clear mb20" id="searchForm" action="${backPath}/data/userLocationData?linkerId=${object.id}" method="post">
					<li class="datainput fl">
						统计日期:<input class="Wdate" id="beginDate" name="beginDate" type="text" readonly="readonly"
						value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />-
						<input class="Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
						value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</li>
					<li class="fl dataslect ml20">选择城市:
						<select class="ml10" name="province" id="province">
						</select>
						<select class="ml10" name="city" id="city">
							<option value="">全国</option>
							<option value="深圳市">深圳市</option>
						</select>
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
				<div class="data_chart mb20 clear" >
					<!-- 图表  -->
					<div id="container" class="fl" style="max-width:1000px;width:66.6%;height:570px; margin-top:37px;"></div>
					<div class="fr data_visit_city">
						<p class="data_visit_city_title">城市访问量</p>
						<div class="data_visit_city_table_sroll">
							<c:forEach var="item" items="${list}" varStatus="st">
								<c:if test="${st.index%2==0}">
									<div class="data_visit_city_table clear">
								</c:if>
								<li class="fl">
									<p class="city_title"><i></i>${empty item.city?'其他':item.city}</p>
									<p class="city_num">${item.num}</p>
								</li>
								<c:if test="${st.index%2==1||st.last}">
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<p class="data_detail_tx_info mt20 mb5">说明:</p>
				<p class="data_detail_tx_info">   
				  访问用户所在地：该连接器在各城市或区域打开的数据统计
   				</p>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function () {
	var categories=JSON.parse('${categories}');
	var data=JSON.parse('${data}');
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: categories,
            crosshair: true
        },
        yAxis: {
            min: 0,
            title: {
                text: '访问量'
            }
        },
        tooltip: {
            
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        },
        series: [{
            name: '访问量',
            data: data
        }]
    });
});
</script>
</body>
</html>