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
					<li class="fl ml20"><input type="submit"  class="loglistsearch_sub blue_btn_com ml20 fl" value="查询"></li>
					<li class="fr color_16d38e mt10" id="btnExport"><i class="icon_excel mr5"></i>导出数据报表</li>
				</form>
				<div class="data_chart mb20">
					<p class="clear data_chart_select">
						<select class="fr" id="dataSelect">
							<option value="sy_fc">浮层</option>
							<option value="sy_xq">项目详情</option>
							<option value="sy_yyjs">右侧语音介绍</option>
							<option value="sy_yqdy">一起代言</option>
							<option value="sy_lxdh">联系电话</option>
							<option value="sy_gd">更多</option>
							<option value="sy_dz">点赞</option>
							<option value="sy_axdz">爱心点赞</option>
							<option value="sy_yy">左侧音乐</option>
							<option value="sy_zdxz">自动旋转</option>
							<option value="sy_tly">陀螺仪</option>
							<option value="sy_vr">VR</option>
							<option value="sy_xfan1">下方按钮1</option>
							<option value="sy_xfan2">下方按钮2</option>
							<option value="sy_zdyan1">自定义按钮1</option>
							<option value="sy_zdyan2">自定义按钮2</option>
							<option value="sy_cjxc">场景及相册</option>
							<option value="xqy_yyjs">语音介绍</option>
							<option value="xqy_bt_zw">标题+正文</option>
							<option value="xqy_bt_zwtp">标题+正文图片</option>
							<option value="xqy_bt_lj">标题+链接</option>
							<option value="xqy_bt_sp">标题+视频</option>
							<option value="xqy_bt_dt">标题+地图</option>
							<option value="xqy_lxdh">底部电话</option>
						</select>
						<span class="fr mr10">可视化数据:</span>
					</p>
					<!-- 图表  -->
					<div style="height:270px" id="container"></div>
				</div>
				<div style="overflow-x: auto;width:100%; max-width:2200px;border-right: 1px solid #d6dee4;">
					<div class="datacommontable data_detail_clicktable" style="border-bottom:0px;">
						<li class="title clear">
							<p class="wone">统计日期</p>
							<p class="wtwo">浮层</p>
							<p class="wthree">项目详情</p>
							<p class="wfour">右侧语音介绍</p>
							<p class="wfree">一起代言</p>
							<p class="wfree">联系电话</p>
							<p class="wfsix">更多</p>
							<p class="wfsev">点赞</p>
							<p class="wfeig">爱心点赞</p>
							<p class="wfnine">左侧音乐</p>
							<p class="wften">自动旋转</p>
							<p class="wfele">陀螺仪</p>
							<p class="wftwo">VR</p>
							<p class="wftfire">下方按钮1</p>
							<p class="wftfire">下方按钮2</p>
							<p class="wfour">自定义按钮1</p>
							<p class="wfour">自定义按钮2</p>
							<p class="wfthree">场景及相册</p>
							<p class="wftfour">语音介绍</p>
							<p class="wftfire">标题+正文</p>
							<p class="wfour">标题+正文图片</p>
							<p class="wftsix">标题+链接</p>
							<p class="wftsix">标题+视频</p>
							<p class="wftseven">标题+地图</p>
							<p class="wfteig">底部电话</p>
						</li>
					</div>
					<div class="datacommontable data_detail_clicktable data_detail_keytable_scroll">
						<c:forEach var="item" items="${list}">
							<li class="clear">
								<p class="wone"><fmt:formatDate value="${item.day}" pattern="yyyy-MM-dd"/></p>
								<p class="wtwo">${item.sy_fc}</p>
								<p class="wthree">${item.sy_xq}</p>
								<p class="wfour">${item.sy_yyjs}</p>
								<p class="wfree">${item.sy_yqdy}</p>
								<p class="wfree">${item.sy_lxdh}</p>
								<p class="wfsix">${item.sy_gd}</p>
								<p class="wfsev">${item.sy_dz}</p>
								<p class="wfeig">${item.sy_axdz}</p>
								<p class="wfnine">${item.sy_yy}</p>
								<p class="wften">${item.sy_zdxz}</p>
								<p class="wfele">${item.sy_tly}</p>
								<p class="wftwo">${item.sy_vr}</p>
								<p class="wftfire">${item.sy_xfan1}</p>
								<p class="wftfire">${item.sy_xfan2}</p>
								<p class="wfour">${item.sy_zdyan1}</p>
								<p class="wfour">${item.sy_zdyan2}</p>
								<p class="wfthree">${item.sy_cjxc}</p>
								<p class="wftfour">${item.xqy_yyjs}</p>
								<p class="wftfire">${item.xqy_bt_zw}</p>
								<p class="wfour">${item.xqy_bt_zwtp}</p>
								<p class="wftsix">${item.xqy_bt_lj}</p>
								<p class="wftsix">${item.xqy_bt_sp}</p>
								<p class="wftseven">${item.xqy_bt_dt}</p>
								<p class="wfteig">${item.xqy_lxdh}</p>
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