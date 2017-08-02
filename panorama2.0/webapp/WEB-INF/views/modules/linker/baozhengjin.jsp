<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>保证金列表</title>
	<meta name="decorator" content="admin"/>
	<link href="${ctxStatic}/modules/720/css/stage.css" type="text/css" rel="stylesheet" />
	
	<style>
		*{margin:0;padding:0;box-sizing:border-box;}
		html,body{width:100%;height:100%;background:#f1f6f9;}
		#wraper{width:95%;height:90%;position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);background:#f1f6f9;}
		#header{width:95%;height:42px;margin:0 auto;margin-top:13px;}
		.header-yuyue{width:160px;height:36px;line-height:36px;font-size:16px;font-weight:600;}
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
		.btn-a1{display:inline-block;width:60px;height:20px;text-align:center;line-height:20px;background:#009bff;border-radius:4px;color:#fff;cursor:pointer;}
		.btn-a2{display:inline-block;width:36px;height:20px;text-align:center;line-height:20px;background:#009bff;border-radius:4px;color:#fff;cursor:pointer;}
		.alert_deleta_mian>ul>li{text-align:left;margin-left:200px;}
		
		/* .logList{width:600px;height:500px;background:#fff;position:absolute;left:50%;top:50%;-webkit-transform:translate(-50%,-50%);transform:translate(-50%,-50%);-moz-transform:translate(-50%,-50%) ;} */
		
		
	</style>
</head>
<body>
	<div id="header">
		<div class="header-download" id="btnExport"></div>
		<div class="header-yuyue">保证金列表</div>
	</div>

	<div id="wraper">
		<form id="searchForm" action="./toBzj" method="post">
			<div class="tops" style="display:none;">
				<div id="submitBtn"></div>
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			 </div>
		</form>
		<div class="bottoms">
			<table cellpadding="0" cellspacing="0">
				<thead>
					<td>项目名称</td>
					<td>付款人名字</td>
					<td>付款卡号</td>
					<td>付款金额</td>
					<td>身份证</td>
					<td>手机号</td>
					<td>冻结日期</td>
					<td>退款状态</td>
					<td>操作</td>
				</thead>
				<tbody>
				<c:forEach items="${page.list}" var="bean" varStatus="index">
					<tr>
						<td>${bean.objectName}</td>
						<td>${bean.khxm}</td>
						<td>${bean.bdkkh}</td>
						<td>${bean.jyje}</td>
						<td>${bean.zjhm}</td>
						<td>${bean.sjhm}</td>
						<td><fmt:formatDate value="${bean.djTime}" pattern="yyyy-MM-dd"/></td>
						<td>
						<c:if test="${bean.ddzt == null}">
							未退款
						</c:if>
						<c:if test="${bean.ddzt == 0}">
							处理中
						</c:if>
						<c:if test="${bean.ddzt == 1}">
							已退款
						</c:if>
						<c:if test="${bean.ddzt == 2}">
							退款失败
						</c:if>
						</td>
						<td><span><a class="btn-a1" onclick="getLog('${bean.dblsh}');">查看纪录</a></span> &nbsp;&nbsp;
						<c:if test="${bean.ddzt == null || bean.ddzt == 2}">
							<span><a class="btn-a2" onclick="tuikuan('${bean.dblsh}',this);">退款</a></span></td>
						</c:if>
					 </tr>
				</c:forEach>
				</tbody>
		 	<%-- 	<tfoot>
					<tr>
						<td colspan="11">
							<input type="hidden" id="totalPages" value="${page.totalPage}">
							<div class="totalrecord">共 <span class="totalpage">${page.totalCount}</span> 条记录</div>
							<div class="fenye">
								<form method="get" >
							        <ul class='pagination' id='pagination'></ul>
							        <div class='input-group'>
							        	<input type='text' name="currentPage1" value='${page.currentPage}' id='getpage'  title='输入跳转页码' />
							            <input type="button" id='btn-paging-jump' value="跳 转">
							        </div>
							     </form>
							</div>
						</td>
					</tr>
				</tfoot> --%>
			</table>
				<div class="pagination">${page}</div>
		</div>
	</div>
	<!-- 操作纪录 -->
	<div class="logList hide_com">
		<div class="qqq">
	        <p class="alert_title">查看纪录</p>
	        <div class="alert_deleta_mian">
            	<ul>
            	
            	</ul>
	        </div>
	    </div>
	</div>
	<script>
	function tuikuan(dblsh,obj){
		if(window.confirm('确定退款吗？')){
			$.ajax({
		        type: "POST",
		        url: "./refund?dblsh="+dblsh,
		        success: function (res) {
		        	if(res.code == 0){
		        		window.location.href="./toBzj";
		        	}else{
		        		alert(res.message);
		        		window.location.href="./toBzj";
		        	}
		        },
		        error: function(data) {
		            alert("退款失败！");
		         }
		    });
	     }else{
	        //alert("取消");
	        return false;
	    }
	}
	
	function getLog(dblsh){
		//$('.logList').find("ul").empty();
		$.ajax({
	        type: "POST",
	        url: "./selectLog?dblsh="+dblsh,
	        success: function (res) {
	        	var str = "";
	        	for(var i = 0;i<res.data.length;i++){
	        		str += "<li>"+res.data[i].createTime+"  " + res.data[i].content+"</li>";
	        	}
	        	$('.logList').find("ul").html(str);
	        	alertbox({
    				msg:$('.logList').html(),
    				tcallfn_tx:'确定',
    				fcallfn_tx:'取消',
    				tcallfn:function(){
    					$("#alertboxbg").css("display","none");
						$("#alretboxmian").css("display","none");
    				},
    				tcallfn_no:function(){
    					return false;
    				}
	    		});
	        },
	        error: function(data) {
	            alert("退款失败！");
	         }
	    });
		
	
	}
	</script>
</body>
<script type="text/javascript" src="${linkerStatic}/js/jquery.min.2.2.2.js"></script>

<script>
	
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
</html>