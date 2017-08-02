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
					<p class="wone">项目名称</p>
					<p class="wtwo">项目ID</p>
					<p class="wthree">网址</p>
					<p class="wfour">创建人</p>
					<p class="wfire">操作人IP</p>
					<p class="wsix">创建时间</p>
					<p class="wsev">操作</p>
				</li>
				<c:forEach items="${page.list}" var="bean">
					<li class="clear">
						<p class="wone" title="${bean.objectName}">${bean.objectName}</p>
						<p class="wtwo" title="${bean.id}">${bean.id}</p>
						<p class="wthree" title="${fns:getHost()}/linker/${bean.id}">${fns:getHost()}/linker/${bean.id}</p>
						<p class="wfour" title="${bean.createBy}">${bean.createBy}</p>
						<p class="wfire" title=""></p>
						<p class="wsix" title="${bean.createTime}"><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm"/></p>
						<p class="wsev" ><a  href="javascript:void(0)" class="see_log" vals="${bean.id}">查看日报</a></p>
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