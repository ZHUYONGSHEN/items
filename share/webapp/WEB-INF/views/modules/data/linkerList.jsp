<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>连接器数据</title>
    <meta name="decorator" content="admin"/>
	<style type="text/css">
    	
    	.Wdate{
			background: #fff url(${backStatic}/images/daterili.png) no-repeat right;
			
		}
    </style>
    <script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>    
</head>
<body>
	<div class="mian_com">
		<form id="searchForm" action="${backPath}/data" method="post" class="loglist_search_head clear mt10">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<li>项目名、ID或网址:<input style="width: 300px" type="text" name="keyword" value="${keyword}" /></li>
			<li><input type="submit"  class="loglistsearch_sub blue_btn_com fl" value="查询"></li>
		</form>
		<div class="mt10 commondivlist">
			<div class="commondivtable datalist">
				<li class="clear title">
					<p style="width:13%">项目名称</p>
					<p style="width:8%">类型</p>
					<p style="width:15%">网址</p>
					<p style="width:12%">公司</p>
					<p style="width:8%">所在省</p>
					<p style="width:8%">城市</p>
					<p style="width:8%">区域</p>
					<p style="width:8%">创建人</p>
					<p style="width:10%">创建时间</p>
					<p style="width:10%">操作</p>
				</li>
				<c:forEach items="${page.list}" var="bean">
					<li class="clear">
						<p  style="width:13%" title="${bean.objectName}">${bean.objectName}</p>
						<p  style="width:8%">
							<c:if test="${bean.fyType == 0}">
								新房
							</c:if>
							<c:if test="${bean.fyType == 1}">
								二手房
							</c:if>
							<c:if test="${bean.fyType == 2}">
								其他
							</c:if>
						</p>
						<p  style="width:15%" title="${fns:getHost()}/linker/${bean.id}">${fns:getHost()}/linker/${bean.id}</p>
						<p  style="width:12%" title="${bean.updateBy}">${bean.updateBy}</p>
						<p  style="width:8%" title="${bean.province}">${bean.province}</p>
						<p  style="width:8%" title="${bean.city}">${bean.city}</p>
						<p  style="width:8%"title="${bean.county}">${bean.county}</p>
						<p  style="width:8%" title="${bean.createBy}">${bean.createBy}</p>
						<p  style="width:10%" title="${bean.createTime}"><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm"/></p>
						<p  style="width:10%"><a  href="javascript:void(0)" class="see_log" vals="${bean.id}">查看日报</a></p>
					</li>
				</c:forEach>
			</div>
			
			<div class="pagination">${page}</div>
		</div>
	</div>
<script>
$(".see_log").click(function(){
	var flag = "${checkReportFlag}";
	if(flag=="true"){
		$(this).attr("href","${backPath}/data/mainData?linkerId="+$(this).attr("vals"));
		$(this).click();
	}else{
		alert("您没有权限!");
	}
});
</script>
</body>
</html>