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
				<form class="data_detail_keydata_head clear mb20" id="searchForm" action="${backPath}/data/shareRelationData?linkerId=${object.id}" method="post">
					<li class="datainput fl">
						统计日期:<input class="Wdate" id="beginDate" name="beginDate" type="text" readonly="readonly"
						value="<fmt:formatDate value="${beginDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />-
						<input class="Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
						value="<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
					</li>
					<li class="fl ml20"><input type="submit"  class="loglistsearch_sub blue_btn_com ml20 fl" value="查询"></li>
				</form>
				
				<div class="datacommontable data_relation" style="border-bottom:0px;">
					<li class="title clear">
						<p class="wone">统计日期</p>
						<p class="wtwo">创建人</p>
						<p class="wfour">1级分享者</p>
						<p class="wthree">2级分享者</p>
						<p class="wthree">3级分享者</p>
						<p class="wthree">4级分享者</p>
						<p class="wthree">5级分享者</p>
					</li>
				</div>
				<div class="datacommontable data_relation">
					<c:forEach var="item" items="${shareList}" varStatus="i">
					<li class="clear" aId="level${item.level}_${i.count}" <c:if test="${i.count > 1}">style="border-top:1px solid #d6dee4"</c:if>>
						<p class="wone"><fmt:formatDate value="${item.day}" pattern="yyyy-MM-dd"/></p>
						<p class="wtwo">${item.creater }</p>
						<p class="wfour" openId="${item.open_id}" level="${item.level}" rootOpenId="${item.open_id}"><span class="<c:if test="${item.hasNext > 0}">wmore</c:if>">${item.firstSharer }</span> <i class="arrowDown"></i></p>
					</li>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
var linkerId = "${log.linkerId}";
$(".data_relation").on("click",".arrowDown",function(e){
	var openId = $(this).parent().attr("openId"),
	    beginDate = $("#beginDate").val(),
	    endDate =$("#endDate").val();
	console.log(openId)
	window.location.href="./userData.sys?linkerId="+linkerId+"&openId="+openId+"&beginDate="+beginDate+"&endDate="+endDate;
	
})
$(".data_relation").on("click",".wmore",function(){
	var levelId = $(this).parent().parent().attr("aId"),
		level = Number($(this).parent().attr("level")),//级数
		openId = $(this).parent().attr("openId"),
		rootOpenId = $(this).parent().attr("rootOpenId"),
		_this = $(this);//openId
	if($(this).hasClass("noLine")){ //关闭
		$(this).removeClass("noLine")
		$("."+levelId).remove();
	}else{ //打开更多
		$.post('./getShareRelationDataByLevel.sys',{"linkerId":linkerId,"level":level,"openId":openId,"rootOpenId":rootOpenId},function(data){
			if(data){
				var _html = '<div class='+levelId+'>';
				for(var i=0;i<data.length;i++){
					_html +='<li class="clear" aId="level'+(level+1)+'_'+(i+1)+'">'
					  	  + '<p class="wone"></p>'
					  	  + '<p class="wtwo"></p><p class="wfour"></p>';
					for(var j=1;j<data[i].level;j++){
						var wmore="";
						if(j === data[i].level-1){
							if(data[i].hasNext > 0 && data[i].level != 5){
								wmore="wmore";
							}
							_html += '<p class="wthree" openId="'+data[i].open_id+'" level="'+data[i].level+'" rootOpenId="'+data[i].root_open_id+'"><span class="'+wmore+'">'+data[i].firstSharer+'</span><i class="arrowDown"></i></p>';
						}else{
							_html += '<p class="wthree"></p>'
						}
					}
					_html +='</li>'
				}
				_html += '</div>';
				_this.parent().parent().after(_html);
			}
		})
		$(this).addClass("noLine")
		return false;
	}
})


</script>
</body>
</html>