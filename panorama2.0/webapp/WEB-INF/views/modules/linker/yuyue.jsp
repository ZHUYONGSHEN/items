<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>预约看房列表</title>
	<meta name="decorator" content="admin"/>
	<link href="${ctxStatic}/modules/720/css/stage.css" type="text/css" rel="stylesheet" />
	
	<style>
		*{margin:0;padding:0;box-sizing:border-box;}
		html,body{width:100%;height:100%;background:#f1f6f9;}
		#wraper{width:100%;height:auto;/* position:absolute;left:50%;top:50%;transform:translate(-50%,-50%); */background:#f1f6f9;}
		#header{width:100%;height:42px;margin-top:30px;}
		.header-yuyue{width:300px;height:36px;line-height:36px;font-size:16px;font-weight:600;}
		.header-download{width:121px;height:32px;float:right;background:url('${linkerStatic}/img/icon_download.png') no-repeat center;background-size:contain;cursor:pointer;}
		.tops{width:100%;height:80px;margin-bottom:9px;background:#fff;}
		.tops>div:nth-child(1){width:319px;height:100%;float:left;}
		.tops>div:nth-child(1)>div{width:70px;height:100%;line-height:80px;float:left;margin:0 10px 0 31px;}
		.tops>div:nth-child(1)>input{width:154px;height:34px;border:1px solid #ccc;float:left;margin-top:24px;padding-left:7px;}
		.tops>div:nth-child(2){width:268px;height:100%;float:left;}
		.tops>div:nth-child(2)>div{width:80px;height:100%;line-height:80px;float:left;}
		.tops>div:nth-child(2)>input{width:105px;height:34px;border:1px solid #ccc;float:left;margin:24px 0 0 22px;padding-left:7px;}
		.tops>div:nth-child(3){width:98px;height:37px;float:left;background:url('${linkerStatic}/img/icon_sumbmit.png') no-repeat center;background-size:contain;cursor:pointer;margin-top:22px;}
		.bottoms{background:#fff;}
		td{border-bottom:1px solid #f1f6f9;}
		table tbody tr:hover{background:#f2faff;}
		table tbody a{display:block;width:20px;height:22px;background:url('${linkerStatic}/img/ic-delete.png') no-repeat center;margin:0 auto;cursor:pointer;}
		table tbody a:hover{background:url('${linkerStatic}/img/ic-delete-hover.png') no-repeat center;}
		thead td,tbody td{text-align:center;width:100px;height:40px;line-height:60px;}
		table{width:100%;}
		table thead td{font-weight:600;font-size:16px;}
		.active{border-radius:5px!important;}
		#pagination{border:none!important;float:left;margin-right:30px;}
		.totalrecord{width:137px;height:33px;float:left;text-align:center;margin:22px 0 0 25px;} 
		.fenye{float:right;}
		#getpage{width:57px;height:25px;border:1px solid #ccc;margin-right:17px;}
		#btn-paging-jump{width:86px;height:30px;background:none;border:1px solid #009bff;border-radius:16px;color:#009bff;}
		.input-group{float:left;margin-top:22px;margin-right:25px;}
		.totalpage{color:#009bff;}
		#btnExport{width:160px;background-color:#009cff; border-radius:20px; height:40px; line-height:40px; color:#fff;text-align: center; }
		#btnExport:hover{color:#fff;}
		table{border:1px solid #f1f6f9;}
		table thead td {padding:10px 0; color:#526a7a}
		table tbody td {color:#859dad}
		table tbody tr:last-child td { border-bottom:none; }
	</style>
</head>
<body>
	<div id="header" style="margin-bottom:30px;">
		<div style="float: right; margin-right:30px;" id="btnExport">导出表格</div>
		<div class="header-yuyue" style="margin-left:30px; color:#526a7a;"> <span style="color:#0099ff">${objectName} </span> > 预约看房列表</div>
	</div>
	<div id="wraper">
		<form id="searchForm" action="./toAppointmentDataList" method="post" style="display:none;">
			<div class="tops">
				<div id="submitBtn"></div>
				<input type="hidden"  name="linkerId" value="${linkerId}"/>
				<input type="hidden"  name="objectName" value="${objectName}"/>
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			 </div>
		</form>
		<div class="bottoms" style="margin-right:30px; margin-left:30px;box-shadow:0 0 1px #e1e7eb;">
			<table cellpadding="0" cellspacing="0">
				<thead>
					<td>序号</td>
					<td>预约人</td>
					<td>手机号码</td>
					<td>预约看房时间</td>
					<td>其他要求</td>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="bean" varStatus="index">
					<tr>
						<td>${index.index + 1}</td>
						<td>${bean.customer}</td>
						<td>${bean.mobile}</td>
						<td>${bean.appointmentSd}</td>
						<td>${bean.otherRequirement}</td>
					 </tr>
				</c:forEach>
				</tbody>
			</table>
				<div class="pagination">${page}</div>
		</div>
	</div>

<script type="text/javascript" src="${linkerStatic}/js/jquery.min.2.2.2.js"></script>
<script>
	
	//导出信息
	$("#btnExport").click(function(){
		console.info("00000000");
    	$("#searchForm").attr("action","./exportAppointmentData");
		$("#searchForm").submit();
		$("#searchForm").attr("action","./toAppointmentDataList");
	});
	$("#submitBtn").click(function(){
		$("#searchForm").submit();
	});
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
    	return false;
    }
	
	
</script>	
</body>
</html>