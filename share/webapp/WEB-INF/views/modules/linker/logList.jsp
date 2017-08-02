<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>操作日志</title>
    <meta name="decorator" content="admin"/>
	<style type="text/css">
    	
    	.Wdate{
			background: #fff url(${backStatic}/images/daterili.png) no-repeat 142px;
		}
		#searchForm li i{
			color:#d6dee4;
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
	<h2 class="logactivetitle"><a href="${siteRoot}/object/objectList">H5连接器</a><span>></span>操作记录</h2>
		<form id="searchForm" action="${backPath}/linker/log" method="post" class="loglist_search_head clear mt10">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<li>项目名或ID:<input class="w110" type="text" name="keyword" value="${log.keyword}" /></li>
			<li>操作人:<input class="w110" type="text" name="createBy" value="${log.createBy}" /></li>
			<li>URI:<input class="w280" type="text" name="requestUri" value="${log.requestUri}" /></li>
			<li>操作日期:<input class="mr20 w170 Wdate" id="beginDate" name="beginDate" type="text" style="margin-right: 10px;" readonly="readonly"
			value="<fmt:formatDate value="${log.beginDate}" pattern="yyyy-MM-dd HH:mm"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});" /><i>—</i>
			<input class="w170 Wdate" id="endDate" name="endDate" type="text" readonly="readonly" 
			value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd HH:mm"/>" onclick="WdatePicker({minDate:'#F{$dp.$D(\'beginDate\')}',dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false});"/></li>
			<li><input type="submit"  class="loglistsearch_sub blue_btn_com fl" value="查询"></li>
		</form>
		<div class="mt10 loglist_mian_list">
			<div class="loglist_mian">
				<li class="clear title">
					<p class="wone">项目名称</p>
					<p class="wtwo">项目ID</p>
					<p class="wthree">URI</p>
					<p class="wfour">操作人</p>
					<p class="wfire">操作人IP</p>
					<p class="wsix">操作时间</p>
					<p class="wsevev">操作记录</p>
				</li>
				<c:forEach items="${page.list}" var="bean">
					<li class="clear">
						<p class="wone" title="${bean.object.objectName}">${bean.object.objectName}</p>
						<p class="wtwo" title="${bean.object.id}">${bean.object.id}</p>
						<p class="wthree" title="${bean.requestUri}">${bean.requestUri}</p>
						<p class="wfour" title="${bean.createBy}">${bean.createBy}</p>
						<p class="wfire" title="${bean.ip}">${bean.ip}</p>
						<p class="wsix" title="${bean.createTime}"><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm"/></p>
						<p class="wsevev" title="${bean.title}">${bean.title}</p>
					</li>
				</c:forEach>
			</div>
			
			<div class="pagination">${page}</div>
		</div>
	</div>
</body>
</html>