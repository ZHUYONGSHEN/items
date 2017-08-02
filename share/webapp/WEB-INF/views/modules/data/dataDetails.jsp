<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>连接器数据</title>
    <meta name="decorator" content="admin"/>
	<style type="text/css">
    	
    	.Wdate{
			background: #fff url(${backStatic}/images/daterili.png) no-repeat 142px;
			
		}
		.highcharts-credits {
			display:none !important;
		}
    </style>
    <script type="text/javascript">
	</script>    
</head>
<body>
<div class="mian_com">
	<h2 class="datadetailtitle mb20">海花岛连接器数据日报</h2>
	<div class="data_detail_mian">
		<div class="data_detail_tab clear mb20">
			<li class="cur">关键数据</li>
			<li>点击行为</li>
			<li>访问用户所在地</li>
			<li>访问用户分时统计</li>
		</div>
		<div class="data_detail_tab_mian">
		<!-- 关键数据 -->
			<div class="data_detail_keydata">
				<form class="data_detail_keydata_head clear mb20">
					<li class="datainput fl">
						统计日期:<input class="Wdate" id="beginDate" name="beginDate" type="text" readonly="readonly"
						value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />-
						<input class="Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
						value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</li>
					<li class="fl ml20"><input type="submit"  class="loglistsearch_sub blue_btn_com ml20 fl" value="查询"></li>
					<li class="fr color_16d38e mt10"><i class="icon_excel mr5"></i>导出数据报表</li>
				</form>
				<div class="data_chart mb20">
					<p class="clear data_chart_select">
						<select class="fr">
							<option>访问用户数</option>
							<option>访问次数</option>
							<option>拨打电话数</option>
							<option>VR看房平均时长(秒)</option>
						</select>
						<span class="fr mr10">可视化数据:</span>
					</p>
					<!-- 图表  -->
					<div style="height:270px">
					
					</div>
				</div>
				<div class="datacommontable data_detail_keytable" style="border-bottom:0px;">
					<li class="title clear">
						<p class="wone">统计日期</p>
						<p class="wtwo">访问用户数</p>
						<p class="wthree">访问次数</p>
						<p class="wfour">拨打电话数</p>
						<p class="wfree">VR看房平均时长(秒)</p>
						<p class="wsix" style="padding:10px 0px 10px 55px">分享次数</p>
					</li>
				</div>
				<div class="datacommontable data_detail_keytable data_detail_keytable_scroll">
					<li class="clear">
						<p class="wone">2017-01-12</p>
						<p class="wtwo">325621</p>
						<p class="wthree">580</p>
						<p class="wfour">580</p>
						<p class="wfree">580</p>
						<p class="wsix">580</p>
					</li>
					<li class="clear">
						<p class="wone">2017-01-12</p>
						<p class="wtwo">325621</p>
						<p class="wthree">580</p>
						<p class="wfour">580</p>
						<p class="wfree">580</p>
						<p class="wsix">580</p>
					</li>
				</div>
				<p class="data_detail_tx_info mt20 mb5">说明:</p>
				<p class="data_detail_tx_info">   
				访问用户数：指的是连接器H5被打开的人数        访问次数：指连接器H5被打开的次数        拨打电话数：H5首页的“联系经纪人”号码点击确定拨打次数        VR看房平均时长：统计时间内，所有VR看房的时长／VR看房的点击用户数
   分享次数：指连接器H5页面被转发的次数，包括N级转发
   				</p>
			</div>
			<!-- 点击行为 -->
			<div class="data_detail_clickdata hide_com">
				<form class="data_detail_keydata_head clear mb20">
					<li class="datainput fl">
						统计日期:<input class="Wdate" id="beginDate" name="beginDate" type="text" readonly="readonly"
						value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />-
						<input class="Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
						value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</li>
					<li class="fl ml20"><input type="submit"  class="loglistsearch_sub blue_btn_com ml20 fl" value="查询"></li>
					<li class="fr color_16d38e mt10"><i class="icon_excel mr5"></i>导出数据报表</li>
				</form>
				<div class="data_chart mb20">
					<p class="clear data_chart_select">
						<select class="fr">
							<option>浮层</option>
							<option>项目详情</option>
							<option>右侧语音介绍</option>
							<option>一起代言</option>
							<option>联系电话</option>
							<option>更多</option>
							<option>点赞</option>
							<option>爱心点赞</option>
							<option>左侧音乐</option>
							<option>自动旋转</option>
							<option>陀螺仪</option>
							<option>VR</option>
							<option>场景及相册</option>
							<option>语音介绍</option>
							<option>标题+正文</option>
							<option>标题+视频</option>
							<option>标题+地图</option>
							<option>底部电话</option>
							<option>分享次数</option>
						</select>
						<span class="fr mr10">可视化数据:</span>
					</p>
					<!-- 图表  -->
					<div style="height:270px">
					
					</div>
				</div>
				<div style="overflow-x: scroll;width:100%">
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
							<p class="wftsix">标题+连接</p>
							<p class="wftsix">标题+视频</p>
							<p class="wftseven">标题+地图</p>
							<p class="wfteig">底部电话</p>
							<p class="wftnine" style="padding:10px 0px 10px 5px">分享次数</p>
						</li>
					</div>
					<div class="datacommontable data_detail_clicktable data_detail_keytable_scroll">
						<li class="clear">
							<p class="wone">2016-12-02</p>
							<p class="wtwo">333</p>
							<p class="wthree">2222</p>
							<p class="wfour">5552</p>
							<p class="wfree">5552</p>
							<p class="wfree">5552</p>
							<p class="wfsix">5552</p>
							<p class="wfsev">5552</p>
							<p class="wfeig">5552</p>
							<p class="wfnine">5552</p>
							<p class="wften">5552</p>
							<p class="wfele">5552</p>
							<p class="wftwo">5552</p>
							<p class="wftfire">5552</p>
							<p class="wftfire">5552</p>
							<p class="wfour">5552</p>
							<p class="wfour">5552</p>
							<p class="wfthree">5552</p>
							<p class="wftfour">5552</p>
							<p class="wftfire">5552</p>
							<p class="wfour">5522</p>
							<p class="wftsix">5552</p>
							<p class="wftsix">5552</p>
							<p class="wftseven">5552</p>
							<p class="wfteig">5552</p>
							<p class="wftnine">5552</p>
						</li>
					</div>
				</div>
				<p class="data_detail_tx_info mt20 mb5">说明:</p>
				<p class="data_detail_tx_info">   
				   点击行为：该连接器各功能按钮和模块的被点击次数  
   				</p>
			</div>
			<!-- 访问用户所在地 -->
			<div class="data_detail_vivsitdata hide_com">
				<form class="data_detail_keydata_head clear mb20">
					<li class="datainput fl">
						统计日期:<input class="Wdate" id="beginDate" name="beginDate" type="text" readonly="readonly"
						value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />-
						<input class="Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
						value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</li>
					<li class="fl dataslect ml20">选择城市:<select class="ml10"><option>深圳</option></select></li>
					<li class="fl ml20"><input type="submit"  class="loglistsearch_sub blue_btn_com ml20 fl" value="查询"></li>
					<li class="fr color_16d38e mt10"><i class="icon_excel mr5"></i>导出数据报表</li>
				</form>
				<div class="data_chart mb20 clear" style="height:570px">
					<!-- 图表  -->
					<div class="fl" style="max-width:1000px;width:66.6%;height:570px">
					</div>
					<div class="fr data_visit_city">
						<p class="data_visit_city_title">城市访问量</p>
						<div class="data_visit_city_table_sroll">
							<div class="data_visit_city_table clear">
								<li class="fl">
									<p class="city_title"><i></i>广州市</p>
									<p class="city_num">33333</p>
								</li>
								<li class="fl">
									<p class="city_title"><i></i>广州市</p>
									<p class="city_num">33333</p>
								</li>
							</div>
							<div class="data_visit_city_table clear">
								<li class="fl">
									<p class="city_title"><i></i>广州市</p>
									<p class="city_num">33333</p>
								</li>
								<li class="fl">
									<p class="city_title"><i></i>广州市</p>
									<p class="city_num">33333</p>
								</li>
							</div>
						</div>
					</div>
				</div>
				<p class="data_detail_tx_info mt20 mb5">说明:</p>
				<p class="data_detail_tx_info">   
				  访问用户所在地：该连接器在各城市或区域打开的数据统计
   				</p>
			</div>
			<!-- 访问用户分时统计 -->
			<div class="data_detail_detadata hide_com">
				<form class="data_detail_keydata_head clear mb20">
					<li class="datainput fl">
						统计日期:<input class="Wdate" id="beginDate" name="beginDate" type="text" readonly="readonly"
						value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />-
						<input class="Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
						value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</li>
					<li class="fl dataslect ml20">选择城市:<select class="ml10"><option>深圳</option></select></li>
					<li class="fl dataslect ml20">选择区:<select class="ml10"><option>罗湖区</option></select></li>
					<li class="fl ml20"><input type="submit"  class="loglistsearch_sub blue_btn_com ml20 fl" value="查询"></li>
					<li class="fr color_16d38e mt10"><i class="icon_excel mr5"></i>导出数据报表</li>
				</form>
				<div class="data_detail_detatable mb20">
					<li class="clear">
						<p class="wone">时间段(时)</p>
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
						<p class="wcommon">24</p>
					</li>
					<li class="clear">
						<p class="wone">访问次数</p>
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
						<p class="wcommon">24</p>
					</li>
				</div>
				<div class="data_chart mb20 clear" style="height:410px">
					<p class="data_chart_date_title">海花岛连接器用户访问量分时统计</p>
					<!-- 图表 -->
					<div style="height:370px">
					</div>
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
	$('.data_detail_tab li').click(function(){
		$(this).addClass('cur').siblings().removeClass('cur')
		$('.data_detail_tab_mian > div').hide().eq($(this).index()).show()
	})
</script>
</body>
</html>