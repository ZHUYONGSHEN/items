<%@ taglib prefix="shiro" uri="/WEB-INF/tlds/shiros.tld" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fns" uri="/WEB-INF/tlds/fns.tld" %>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<c:set var="ctx" value="${pageContext.request.contextPath}${fns:getAdminPath()}"/>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
<c:set var="backPath" value="${pageContext.request.contextPath}${fns:getBackPath()}"/>
<c:set var="backStatic" value="${pageContext.request.contextPath}/static/modules/720"/>
<c:set var="linkerStatic" value="${pageContext.request.contextPath}/static/modules/linker"/>
<c:set var="panoStatic" value="${pageContext.request.contextPath}/static/modules/pano"/>
<c:set var="siteRoot" value="${pageContext.request.contextPath}"/>
<c:set var="zhongyuanPath" value="${pageContext.request.contextPath}/static/modules/zhongyuan"/>