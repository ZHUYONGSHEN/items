<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>相册管理</title>
	<meta name="decorator" content="default"/>
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
	<ul class="nav nav-tabs">
		<li class="active"><a href="${backPath}/pano/album/">相册列表</a></li>
		<li><a href="${backPath}/pano/album/form">相册添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="album" action="${backPath}/pano/album/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>名称 ：</label><form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;&nbsp;<label>描述 ：</label><form:input path="des" htmlEscape="false" maxlength="50" class="input-medium"/>
		&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>名称</th><th>描述</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="bean">
			<tr>
				<td>${bean.name}</td>
				<td>${bean.des}</td>
				<td>
    				<a href="${backPath}/pano/album/form?id=${bean.id}">修改</a>
					<a href="${backPath}/pano/album/delete?id=${bean.id}" onclick="return confirmx('确认要删除该相册吗？', this.href)">删除</a>
					<a href="${backPath}/pano/album/main?id=${bean.id}">相册管理</a>
					<a href="${siteRoot}/pano/${bean.id}" target="_blank">json数据</a>
					<a href="${siteRoot}/pano/preview/${bean.id}#id=${bean.id}" target="_blank">全景预览</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>