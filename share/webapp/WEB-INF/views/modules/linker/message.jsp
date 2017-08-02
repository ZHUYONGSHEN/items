<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>留言列表</title>
	<meta name="decorator" content="admin"/>
	<link href="${ctxStatic}/modules/720/css/stage.css" type="text/css" rel="stylesheet" />
	
	<style>
		*{margin:0;padding:0;box-sizing:border-box;}
		html,body{width:100%;height:100%;background:#f1f6f9;}
		#wraper{width:100%;height:auto;/* position:absolute;left:50%;top:50%;transform:translate(-50%,-50%); */background:#f1f6f9;}
		#header{width:100%;height:42px;margin-top:30px;}
		.header-yuyue{width:auto;height:36px;line-height:36px;font-size:16px;font-weight:600;}
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
		#btnExport{width:160px;background-color:#009cff; border-radius:20px; height:40px; line-height:40px; color:#fff;text-align: center; }
		#btnExport:hover{color:#fff;}
		table{border:1px solid #f1f6f9;}
		table thead td {padding:10px 0; color:#526a7a}
		table tbody td {color:#859dad}
		.modal{    
			position: absolute;
		    left: 0;
		    right: 0;
		    top: 0;
		    bottom: 0;
			z-index: 888;
			width:100%;
			height:100%;
			background:rgba(0,0,0,.5);
		}
		.modal-content {
			position: absolute;
		    left: 0;
		    right: 0;
		    top: 0;
		    bottom: 0;
			z-index: 888;
			width:520px;
			max-height:270px;
			margin:auto;
			background:rgba(255,255,255,1);
		}
		.radio_no,.radio_yes {
			width:21px;
			height:21px;
		}
	</style>
</head>
<body>
	<div id="header">
		<div class="header-yuyue" style="margin-left:30px;"> <span style="color:#0099ff">${objectName} </span> > 详情页留言</div>
	</div>
	<div id="wraper">
		<div style="padding-top:15px; height:90px; padding-bottom: 30px;margin-right:30px; margin-left:30px;">
			<div style="float: right;" id="btnExport">导出表格</div>
			<label class="mr20 check_box_click fl" style="margin-top:5px; color:#526a7a">
       			<i class="radio_no" style="top:5px;"></i>
       			<input id ="allCheck" value="8" type="checkbox" style="display:none;">全选
        	</label>
			<a onclick="batchDelMessage();" class="fl" style="display:block; width:120px;height:40px; line-height:40px; color:#fff;text-align: center; border-radius:20px; background-color:#0ed98c;">删除</a>
		</div>
		<form id="searchForm" action="./toLinkerMessageList" method="post" style="display:none">
			<div class="tops">
				<div id="sub mitBtn"></div>
				<input type="hidden"  name="linkerId" value="${linkerId}"/>
				<input type="hidden"  name="objectName" value="${objectName}"/>
				<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			 </div>
		</form>
		<div class="bottoms" style="margin-right:30px; margin-left:30px;box-shadow:0 0 1px #e1e7eb;"> 
			<table cellpadding="0" cellspacing="0">
				<thead>
					<td></td>
					<td>序号</td>
					<td>留言内容</td>
					<td>留言人</td>
					<td>留言日期</td>
					<td>操作</td>
				</thead>
				<tbody id="tshow">
				<c:forEach items="${page.list}" var="bean" varStatus="index">
					<tr>
						<td>	
							<label class="mr20 check_box_click">
		            			<i class="radio_no"></i>
		            			<input name ="checkBox1" value="${bean.id}" type="checkbox" style="display:none;">
		            		</label>
	            		</td>
						<td>${index.index + 1}</td>
						<td><p style="max-width:300px;height:60px;white-space: nowrap; overflow:hidden;text-overflow:ellipsis; margin:auto;">${bean.content}</p></td>
						<td>${bean.nickname}</td>
						<td><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td>
							<a class="delete dele_icon" style="margin-right:40px;" onclick="delMessage('${bean.id}');"></a>
							<a class="details edit_icon" val1="${bean.content}" val2="${bean.nickname}" val3="<fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"></a>
						</td>
					 </tr>
				</c:forEach>
				</tbody>
			</table>
				<div class="pagination">${page}</div>
		</div>
	</div>
	<div class="modal" style="display:none;">
		<div class="modal-content" style="border:1px solid #e1e7eb; border-radius:5px;">
		   <div class="modal-header" style="height:60px; line-height:60px; padding-left:20px; padding-right:20px;">
		   		<span class="close" style="float:right; font-size:24px; color:#c2ced6;">&times;</span>
				<h4 class="modal-title" style="font-size:18px;">${objectName}－留言详情</h4>
		   </div>
		   <div class="modal-body" style="padding:20px; min-height:150px; font-size:16px;color:#333; border-top:1px solid #e1e7eb; border-bottom:1px solid #e1e7eb;">
		   		<div style="padding-bottom:20px;">留言内容：</div>
		   		<p style="color:#859dad; line-height:24px;"  class="messageContent"></p>
		   </div>
		   <div class="modal-footer" style="height:60px; width:100%;">
		   	<div style=" float:left; font-size:16px;color:#333;padding-left:20px; width:50%; height:60px; line-height:60px;">
		   		<span>留言人：</span>
		   		<p style="color:#859dad; font-size:16px; padding-right:15px;width:170px; float:right;" class="nickName"></p>
		   	</div>
		   	<div style=" float:left; font-size:16px;color:#333; width:50%; height:60px; line-height:60px;">
		   		<span>留言日期：</span>
		   		<p style="color:#859dad; font-size:16px; padding-right:15px;width:175px; float:right;" class="createTime"></p>
		   	</div>
		   </div>
		</div>
	</div>
<script type="text/javascript" src="${linkerStatic}/js/jquery.min.2.2.2.js"></script>
<script>
function delMessage(id){
	if(window.confirm('你确定要删除留言吗？')){
		$.ajax({
	        type: "GET",
	        url: "./delMessage?ids="+id,
	        success: function (res) {
	         	window.location.href="./toLinkerMessageList?linkerId=${linkerId}&objectName=${objectName}";
	        },
	        error: function(data) {
	            alert("删除留言失败！");
	         }
	    });
     }else{
        return false;
    }

}
//批量删除
function batchDelMessage(){
	var length = $('#tshow').find(".radio_yes").length;
	if(length == 0){
		 alert("请选择要删除的信息");
	}else{
		if(window.confirm('你确定要删除'+length+'条留言吗？')){
			var check_val = [];
			$('#tshow').find(".radio_yes").each(function(){
				check_val.push($(this).next("input").val());
			})
			 $.ajax({
		        type: "GET",
		        url: "./delMessage?ids="+check_val,
		        success: function (res) {
		         	window.location.href="./toLinkerMessageList?linkerId=${linkerId}&objectName=${objectName}";
		        },
		        error: function(data) {
		            alert("删除留言失败！");
		         }
		    }); 
	     }else{
	        return false;
	    }
	}
}
//导出信息
$("#btnExport").click(function(){
   	$("#searchForm").attr("action","./exportMessageData");
	$("#searchForm").submit();
	$("#searchForm").attr("action","./toLinkerMessageList");
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

$(".check_box_click").click(function(event){
	event.preventDefault();
	if($(this).find("i").hasClass("radio_no")){
		$(this).find("i").removeClass("radio_no").addClass("radio_yes");
		$(this).find("input").attr("checked","checked");
		if($(this).find("input").attr("id") == "allCheck"){
			$('#tshow').find(".check_box_click").each(function(){
				$(this).find("i").removeClass("radio_no").addClass("radio_yes");
				$(this).find("input").attr("checked","checked");
			})
		}else{
			if($('#tshow').find(".radio_yes").length == $('#tshow').find("i").length){
				if($("#allCheck").prev("i").hasClass("radio_no")){
					$("#allCheck").prev("i").removeClass("radio_no").addClass("radio_yes");
					$("#allCheck").attr("checked","checked");
				}
			}
		}
	}else if($(this).find("i").hasClass("radio_yes")){
		if($(this).find("input").attr("id") == "allCheck"){
			$('#tshow').find(".check_box_click").each(function(){
				$(this).find("i").removeClass("radio_yes").addClass("radio_no");
				$(this).find("input").removeAttr("checked");
			})
		}else{
			if($("#allCheck").prev("i").hasClass("radio_yes")){
				$("#allCheck").prev("i").removeClass("radio_yes").addClass("radio_no");
				$("#allCheck").removeAttr("checked");
			}
		}
		$(this).find("i").removeClass("radio_yes").addClass("radio_no");
		$(this).find("input").removeAttr("checked");
	}
	
});
$('#wraper').on('click','.details',function(){
	var content = $(this).attr("val1");
	var nickName = $(this).attr("val2");
	var createTime = $(this).attr("val3");
	$(".messageContent").html(content);
	$(".nickName").html(nickName);
	$(".createTime").html(createTime);
	var mod = $('.modal');
	if(mod.is(':hidden')){
		$('.modal').fadeIn();
	}
	return false;
});
$('.modal').on('click',function(){
	var mod = $(this);
	mod.fadeOut();
	return false;
});

</script>
</body>	
</html>