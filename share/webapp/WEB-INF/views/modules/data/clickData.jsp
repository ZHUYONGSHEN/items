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
	        	$("#searchForm").attr("action","${backPath}/data/exportClickData?linkerId=${object.id}");
	    		$("#searchForm").submit();
	    		$("#searchForm").attr("action","${backPath}/data/clickData?linkerId=${object.id}");
	    	});
	    })
	</script>    
</head>
<body>
<div class="mian_com">
	<h2 class="datadetailtitle mb20">${object.objectName}连接器数据日报</h2>
	<div class="data_detail_mian">
		<div class="data_detail_tab clear mb20">
			<li><a href="${backPath}/data/mainData?linkerId=${object.id}">关键数据</a></li>
			<li class="cur"><a href="${backPath}/data/clickData?linkerId=${object.id}">点击行为</a></li>
			<li><a href="${backPath}/data/userLocationData?linkerId=${object.id}">访问用户所在地</a></li>
			<li><a href="${backPath}/data/accessLogData?linkerId=${object.id}">访问用户分时统计</a></li>
			<li><a href="${backPath}/data/shareRelationData?linkerId=${object.id}">分享关系链</a></li>
		</div>
		<div class="data_detail_tab_mian">
			<!-- 点击行为 -->
			<div class="data_detail_clickdata">
				<form class="data_detail_keydata_head clear mb20" id="searchForm" action="${backPath}/data/clickData?linkerId=${object.id}" method="post">
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
					<li class="fr color_16d38e mt10" id="btnExport"><i class="icon_excel mr5"></i>导出数据报表</li>
				</form>
				<div class="data_chart mb20">
					<p class="clear data_chart_select">
						<select class="fr" id="dataSelect">
							<option value="sy_yqdy">一起代言</option>
							<option value="sy_bddh">拨打电话</option>
							<option value="sy_dz">点赞</option>
							<option value="sy_xc">相册</option>
							<option value="sy_tx">头像</option>
							<c:if test="${!empty menuList[0].sy_fc}"><option value="sy_fc">浮层</option></c:if>
							<c:if test="${!empty menuList[0].sy_xmxq}"><option value="sy_xq">项目详情</option></c:if>
							<c:if test="${!empty menuList[0].sy_yyjs}"><option value="sy_yyjs">右语音介绍</option></c:if>
							<c:if test="${!empty menuList[0].sy_music}"><option value="sy_music">音乐</option></c:if>
							<c:if test="${menuList[0].sy_vr>0}"><option value="sy_vr">VR</option></c:if>
							<c:if test="${menuList[0].sy_tly>0}"><option value="sy_tly">陀螺仪</option></c:if>
							<c:if test="${!empty menuList[0].sy_sp}"><option value="sy_sp">沙盘</option></c:if>
							<c:if test="${!empty menuList[0].sy_hb}"><option value="sy_hb">红包</option></c:if>
							<c:if test="${!empty menuList[0].sy_kaquan}"><option value="sy_kaquan">卡劵</option></c:if>
							<c:forEach var="item" items="${zdyButtonList}" varStatus="i">
								<option value="sy_${i.count }">${item.channel_name }</option>
							</c:forEach>
						</select>
						<span class="fr mr10">可视化数据:</span>
					</p>
					<!-- 图表  -->
					<div style="height:270px" id="container"></div>
				</div>
				<div style="overflow-x: auto;width:100%; max-width:2200px;border-right: 1px solid #d6dee4;">
					<div class="datacommontable data_detail_clicktable" style="border-bottom:0px;">
						<li class="title clear">
							<p>统计日期</p>
							<p>渠道</p>
							<p>一起代言</p>
							<p>拨打电话</p>
							<p>点赞</p>
							<p>相册</p>
							<p>头像</p>
							<c:if test="${!empty menuList[0].sy_fc}"><p>浮层</p></c:if>
							<c:if test="${!empty menuList[0].sy_xmxq}"><p>项目详情</p></c:if>
							<c:if test="${!empty menuList[0].sy_yyjs}"><p>语音介绍</p></c:if>
							<c:if test="${!empty menuList[0].sy_music}"><p>音乐</p></c:if>
							<c:if test="${menuList[0].sy_vr > 0}"><p>VR</p></c:if>
							<c:if test="${menuList[0].sy_tly > 0}"><p>陀螺仪</p></c:if>
							<c:if test="${!empty menuList[0].sy_sp}"><p>沙盘</p></c:if>
							<c:if test="${!empty menuList[0].sy_hb}"><p>红包</p></c:if>
							<c:if test="${!empty menuList[0].sy_kaquan}"><p>卡劵</p></c:if>
							<c:forEach var="item" items="${zdyButtonList}">
								<p>${item.channel_name }</p>
							</c:forEach>
						</li>
					</div>
					<div class="datacommontable data_detail_clicktable data_detail_keytable_scroll">
						<c:forEach var="item" items="${list}">
							<li class="clear">
								<p><fmt:formatDate value="${item.day}" pattern="yyyy-MM-dd"/></p>
								<p>${item.channel_name}</p>
								<p>${item.sy_yqdy}</p>
								<p>${item.sy_bddh}</p>
								<p>${item.sy_dz}</p>
								<p>${item.sy_xc}</p>
								<p>${item.sy_tx}</p>
								<c:if test="${!empty menuList[0].sy_fc}"><p>${item.sy_fc}</p></c:if>
								<c:if test="${!empty menuList[0].sy_xmxq}"><p>${item.sy_xmxq}</p></c:if>
								<c:if test="${!empty menuList[0].sy_yyjs}"><p>${item.sy_yyjs}</p></c:if>
								<c:if test="${!empty menuList[0].sy_music}"><p>${item.sy_music}</p></c:if>
								<c:if test="${menuList[0].sy_vr > 0}"><p>${item.sy_vr}</p></c:if>
								<c:if test="${menuList[0].sy_tly > 0}"><p>${item.sy_tly}</p></c:if>
								<c:if test="${!empty menuList[0].sy_sp}"><p>${item.sy_sp}</p></c:if>
								<c:if test="${!empty menuList[0].sy_hb}"><p>${item.sy_hb}</p></c:if>
								<c:if test="${!empty menuList[0].sy_kaquan}"><p>${item.sy_kaquan }</p></c:if>
								<c:choose>
									<c:when test="${zdyButtonList.size() == 1}">
										<p>${item.sy_1}</p>
									</c:when>
									<c:when test="${zdyButtonList.size() == 2}">
										<p>${item.sy_1}</p>
										<p>${item.sy_2}</p>
									</c:when>
									<c:when test="${zdyButtonList.size() == 3}">
										<p>${item.sy_1}</p>
										<p>${item.sy_2}</p>
										<p>${item.sy_3}</p>
									</c:when>
									<c:when test="${zdyButtonList.size() == 4}">
										<p>${item.sy_1}</p>
										<p>${item.sy_2}</p>
										<p>${item.sy_3}</p>
										<p>${item.sy_4}</p>
									</c:when>
									<c:when test="${zdyButtonList.size() == 5}">
										<p>${item.sy_1}</p>
										<p>${item.sy_2}</p>
										<p>${item.sy_3}</p>
										<p>${item.sy_4}</p>
										<p>${item.sy_5}</p>
									</c:when>
									<c:when test="${zdyButtonList.size() == 6}">
										<p>${item.sy_1}</p>
										<p>${item.sy_2}</p>
										<p>${item.sy_3}</p>
										<p>${item.sy_4}</p>
										<p>${item.sy_5}</p>
										<p>${item.sy_6}</p>
									</c:when>
								</c:choose>
							</li>
						</c:forEach>
					</div>
				</div>
				<p class="data_detail_tx_info mt20 mb5">说明:</p>
				<p class="data_detail_tx_info">   
				   点击行为：该连接器各功能按钮和模块的被点击次数  
   				</p>
			</div>
		</div>
	</div>
</div>

	<script type="text/javascript">
		var len = $(".data_detail_clicktable .title p").length;
		$(".data_detail_clicktable").css("width",125*len);
	
		var categories=JSON.parse('${categories}');
		var data=JSON.parse('${data}');
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
	            valueSuffix: '次'
	        },
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'middle',
	            borderWidth: 0
	        },
	        series: [{name:'',data:[]}]
	    });
	    var chartDataMap=[];
	    
	    $(function(){
	    	if("${channelId}"){
	    		$('select[name="channelId"] option[value=${channelId}]').attr('selected', 'selected');
	    	}
	    	$("#dataSelect").change(function(){
	    		var id=$(this).val();
	    		var name= $(this)[0].options[$(this)[0].selectedIndex].text;
	    		var chartData=chartDataMap[id];
	    		if(chartData==null){
	    			chartData={};
	    			chartData.name=name;
	    			var list=[];
	    			for(var i=0;i<data.length;i++){
	    				list.push(data[i][id]);
	    			}
	    			chartData.data=list;
	    			chartDataMap[id]=chartData;
	    		}
	    		updateSeries(chartData);
	    	});
	    	$("#dataSelect").change();
	    });
	    
	    function updateSeries(chartData){
	    	chart.series[0].update({
        		name: chartData.name,
        		data:chartData.data
    		});
	    }
	    
	</script> 
</body>
</html>