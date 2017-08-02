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
	<%-- <h2 class="logactivetitle"><a href="${siteRoot}/object/objectList">H5连接器</a><span>></span>操作记录</h2> --%>
		<form id="searchForm" action="${backPath}/linker/log" method="post" class="loglist_search_head clear mt10">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<li>项目名或ID:<input class="w110" type="text" name="keyword" value="${log.keyword}" /></li>
			<li>网址:<input class="w280" type="text" name="requestUri" value="${log.requestUri}" /></li>
			<li><input type="submit"  class="loglistsearch_sub blue_btn_com fl" value="查询"></li>
		</form>
		<div class="mt10 commondivlist">
			<div class="commondivtable datalist">
				<li class="clear title">
					<p class="wone">项目名称</p>
					<p class="wtwo">项目ID</p>
					<p class="wthree">网址</p>
					<p class="wfour">创建人</p>
					<p class="wfire">操作人IP</p>
					<p class="wsix">创建时间</p>
				</li>
				<c:forEach items="${page.list}" var="bean">
					<li class="clear">
						<p class="wone" title="${bean.object.objectName}">${bean.object.objectName}</p>
						<p class="wtwo" title="${bean.object.id}">${bean.object.id}</p>
						<p class="wthree" title="${bean.requestUri}">${bean.requestUri}</p>
						<p class="wfour" title="${bean.createBy}">${bean.createBy}</p>
						<p class="wfire" title="${bean.ip}">${bean.ip}</p>
						<p class="wsix" title="${bean.createTime}"><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm"/></p>
					</li>
				</c:forEach>
			</div>
			
			<div class="pagination">${page}</div>
		</div>
	</div>
</body>
</html>