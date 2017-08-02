<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>公司认证审核</title>
    <meta name="decorator" content="admin"/>
    <script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
	<style type="text/css">
		.model,.showImg{position: fixed;left: 0;right: 0; top: 0;bottom: 0;z-index: 888;width:100%;height:100%;background:rgba(0,0,0,.5);}
		.detailWrap{width:520px;border:1px solid #e1e7eb; border-radius:5px;background:#fff; position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);}
		.titleWrap{height:60px;line-height:60px;padding:0 20px;color:#29353D;font-size:18px;}
		.titleWrap h3{display:inline-block;}
		.btn-close{float:right; color:#c2ced6;}
		.detailBox .dContent,.authBox{font-size:16px; padding:10px 20px;border-top:1px solid #e1e7eb; border-bottom:1px solid #e1e7eb;}
		.detailBox .dContent li{line-height:34px;}
		.detailBox .dContent p{display:inline-block;color:#859DAD;margin-left:5px;}
		.detailBox .mImg{max-height:184px;max-width:368px;margin-left:20px;border:1px solid #E6E6E6;}
		.btnWrap{height:74px;line-height:74px;text-align:right;padding-right:20px;}
		.btnWrap .btn{text-decoration: none; border: none; color: #fff; font-size: 14px; padding: 10px 30px; border-radius: 4px; }
		.btnWrap .btn.btnBack,.btnWrap .btn.btnSubmit{background: #0ED98C;}
		.btnWrap .btn.btnYes{background: #009BFF;margin-left:10px;}
		
		.authBox .tRe{width:100%;font-size:14px;border:1px solid #D6DEE4;margin-top:15px;padding:5px 10px;}
		.authBox .remark{color:red;font-size:14px;padding-top:5px;}
		
		.imgBox{max-width:500px;max-height:500px;position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);}
		.imgBox img{width:100%;height:100%;max-width:500px;max-height:500px;}
	</style> 
</head>
<body>
<div class="mian_com">
	<form id="searchForm" action="${siteRoot}/object/companyAuditList" method="post" >
       <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <input type="submit"  value=""/>
   </form>
	<div class="list_index_mian mt20">
        <table class="table_com">
			<thead>
				<tr>
					<th>序号</th>
					<th>所在公司</th>
					<th>所在省份</th>
					<th>城市</th>
					<th>区域</th>
					<th>名片</th>
					<th>提交人</th>
					<th>提交日期</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="item" varStatus="i">
				<tr>		
					<td width="100"><div>${i.count }</div></td>
					<td width="180"><div title="${item.companyName}">${item.companyName}</div></td>
					<td width="120"><div title="${item.province}">${item.province}</div></td>
					<td width="120"><div title="${item.city}">${item.city}</div></td>
					<td width="120"><div title="${item.area}">${item.area}</div></td>
					<td width="200">
						 <c:if test="${!empty item.cardUrl}"> 
							<a href="javascript:;" imgUrl="${fns:getCosAccessHost()}${item.cardUrl}" class="imgbig">
							<img width="20" height="23" src="${fns:getCosAccessHost()}${item.cardUrl}"></a>
						 </c:if> 
					</td>
					<td width="120"><div title="${item.createUser}">${item.createUser}</div></td>
					<td width="200"><div title="${item.createTime}"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div></td>
					<td width="200">
					<c:if test="${item.auditStatus == 0}">
						<div title="待审核">待审核</div>
					</c:if>
					<c:if test="${item.auditStatus == 1}">
						<div title="审核通过">审核通过</div>
					</c:if>
					<c:if test="${item.auditStatus == 2}">
						<div title="已驳回,${item.rebutRemark}">已驳回,${item.rebutRemark}</div>
					</c:if>
					</td>
					<td width="280">
						<div class="table_link_div200">
						<!-- 查看详情 -->
						<a class="a_com btnDtail" href="javascript:;" vals="${item.id}" cName="${item.companyName}" pro="${item.province}" city="${item.city}" area="${item.area}" date="<fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" cUser="${item.createUser}" imgUrl="${item.cardUrl}">查看详情</a>
						<c:if test="${item.auditStatus == 0}">
							<!-- 审核 -->
							<a class="a_com btnAuth" vals="${item.id}" cName="${item.companyName}" pro="${item.province}" city="${item.city}" area="${item.area}" date="<fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" cUser="${item.createUser}" imgUrl="${item.cardUrl}" href="javascript:void(0)">审核</a>
						</c:if>
						</div>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<!--分页-->
		<div class="pagination">${page}</div>
	</div>  
</div>
<!-- 查看详情 -->
<div class="model" style="display:none;">
<div class="detailWrap">
	<input type="hidden" class="hiddenId">
	<div class="titleWrap"><h3>公司认证审核</h3><a href="javascript:;" class="btn-close">X</a></div>
	<div class="detailBox">
		<div class="dContent">
			<ul>
				<li><label>所在公司:</label><p class="cName"></p></li>
				<li>
					<label>所在省份:</label><p class="province"></p>
					<label class="ml28">城市:</label><p class="city"></p>
					<label class="ml28">区域:</label><p class="country"></p>
				</li>
				<li><label>提交日期:</label><p class="date"></p><label class="ml28">提交人:</label><p class="cUser"></p></li>
				<li><label style="vertical-align:top;">名片:</label><img class="mImg"></li>
			</ul> 
		</div>
		<div class="btnWrap" style="display:none;">
			<a href="javascript:;" class="btn btnBack">驳回</a>
			<a href="javascript:;" class="btn btnYes">认证通过</a>
		</div>
	</div>
	<div class="authWrap" style="display:none;">
		<div class="authBox" style="border-bottom:none;">
			<label>驳回理由:</label>
			<textarea rows="5" class="tRe" placeholder="请输入15个字以内的驳回理由"></textarea>
			<p class="remark"></p>
		</div>
		<div class="btnWrap" style="text-align:center;">
			<a href="javascript:;" class="btn btnSubmit">驳回</a>
		</div>
	</div>
</div>
</div>
<!-- 显示图片 -->
<div class="showImg" style="display:none;">
	<div class="imgBox"></div>
</div>
<script>
var hostLink = "${fns:getCosAccessHost()}"
/**
 * 审核
 */
function audit(id,auditStatus,rebutRemark){
	$.post("./auditCompany",{id:id,auditStatus:auditStatus,rebutRemark:rebutRemark},function(data){
		 if(data.code == 0){
			window.location.href="./companyAuditList.sys";
		}else{
			console.info(data.msg)
		} 
	})
}
/* 获取信息 */
function getDetail(_this){
	var id= _this.attr("vals")
		cName = _this.attr("cName"),
		pro = _this.attr("pro"),
		city = _this.attr("city"),
		area = _this.attr("area"),
		date = _this.attr("date"),
		cUser = _this.attr("cUser"),
		imgUrl = _this.attr("imgUrl");
	$(".hiddenId").val(id)
	$(".cName").html(cName);
	$(".province").html(pro);
	$(".city").html(city);
	$(".country").html(area);
	$(".date").html(date);
	$(".cUser").html(cUser);
	if(imgUrl){
		$(".mImg").attr("src",hostLink+imgUrl);
	}
	$('.model').fadeIn();
}

/** 
 * 详情弹框 
 */
$(".table_com").on("click",".btnDtail",function(){
	getDetail($(this));
})
/* 图片放大 */
$(".table_com").on("click",".imgbig",function(){
	var imgUrl = $(this).attr("imgUrl")
	$(".showImg").fadeIn();
	$(".imgBox").html('<img src="'+imgUrl+'">')
})

/* 审核弹框 */
$(".table_com").on("click",".btnAuth",function(){
	getDetail($(this));
	$(".btnWrap").show();
})
/* 显示驳回界面 */
$(".model").on('click',".btnBack",function(){
	$(".detailBox").hide();
	$(".authWrap").show();
	$(".detailWrap").css("width","410px")
})
/* 审核通过 */
$(".model").on('click',".btnYes",function(){
	var id= $(".hiddenId").val()
	audit(id,1,"");
})
/* 驳回 */
$(".model").on("click",".btnSubmit",function(){
	if ($.trim($('.tRe').val()) == "") {
		$('.remark').html("*驳回理由不能为空");
		return false;
	} else {
		var id= $(".hiddenId").val(),
			autStatus = 2,
			autMark = $(".tRe").val();
		audit(id,autStatus,autMark);
	}
})
/* 关闭弹框 */
$(".model").on("click",".btn-close",function(){
	$('.model').fadeOut();
})
$(".showImg").on("click",function(){
	$(this).fadeOut();
})
$('.tRe').on('focus', function() {
	$('.remark').html("");
});
</script>
</body>
</html>