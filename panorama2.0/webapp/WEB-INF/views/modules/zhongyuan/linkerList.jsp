<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="admin"/>
    <title>连接器列表页</title>
    <link href="${zhongyuanPath}/css/linkerList.css" rel='stylesheet'>
    <link href="${ctxStatic}/modules/720/css/stage.css" type="text/css" rel="stylesheet" />
    <link href="${ctxStatic}/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	</script>	
	<style>
		.switch-off{display:block;float:right;width:26px;height:22px;background:url('${backStatic}/images/switch_off.png') no-repeat center;background-size:contain;margin-top:5px;}
		.switch-off:hover{cursor:pointer;}
		
		.switch-on{display:block;float:right;width:26px;height:22px;background:url('${backStatic}/images/switch_on.png') no-repeat center;background-size:contain;margin-top:5px;}
		.switch-on:hover{cursor:pointer;}
		.changess{margin-right:70px;color:blue;display:inline-block;width:160px;height:40px;line-height:40px;background:#009cff;border-radius:20px;color:#fff;font-size:15px;}
		
	</style>
</head>
<body>
<div class="mian_com">
    <div class="clear">
    	<form id="searchForm" action="${siteRoot}/zyObjectlinker/objectList" method="post" >
    		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    	<div class="search-area">
                    <div class="search-item"><span>状态: </span><select class="status-option" name="off"><option value="-1" <c:if test="${object.off==null}">selected="selected"</c:if>>全部</option><option <c:if test="${object.off==1}">selected="selected"</c:if>value="1">上架</option><option value="0" <c:if test="${object.off==0}">selected="selected"</c:if>>下架</option></select></div>
                    <div class="search-item"><span>项目名称: </span><input type="text" value="${object.objectName}" class="pro-name" name="objectName"></div>
                    <div class="search-item"><span>添加时间: </span><input type="text" name="startTime" id="startTime"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'endTime\')}'})" value="${object.startTime}"class="time-input"> —— <input type="text" value="${object.endTime}" id="endTime"onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'startTime\')}'})" name="endTime" class="time-input"></div>
                    <input type="submit" value="搜索" class="search-btn" style="line-height:40px;background-color:#16d38e"/> <input type="button" value="+ 新增" class="add-btn add" style="line-height:40px"/>
        </div>
        </form>
    </div>
	<div class="list_index_mian mt20">
        <table class="table_com">
			<thead>
				<tr>
					<th><div style="width:35px;">排序</div></th>
					<th><div class="table_link_div">项目名称</div></th>
					<th><div class="table_link_div">所在片区</div></th>
					<th><div class="table_link_div">项目简介</div></th>
					<th><div class="table_link_div">链接</div></th>
					<th>状态</th>
					<th>创建时间</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.list}" var="bean" varStatus="status">
				<tr>	
					<td width="50">${bean.orderNum}</td>
					<td width="200"><div class="table_link_div200" title="${bean.objectName}">${bean.objectName}</div></td>
					<td width="100" class="pro_id">
						<div data-titles="" title="${bean.province}/${bean.city}/${bean.district}">
						   ${bean.province}/${bean.city}/${bean.district}
						</div>
					</td>
					<td width="340" class="clear">
						 <div style="max-height:44px;overflow:hidden;text-overflow:ellipsis;" title="${bean.remark}">
						 	<c:if test="${bean.remark.length()>50}">
						 		${bean.remark.substring(0,50)}...
						 	</c:if>
						 	<c:if test="${bean.remark.length()<50}">
						 		${bean.remark}
						 	</c:if>
						 </div>
					</td>
					<td width="120" title="${bean.objectUrl}" > <div class="table_link_div200">${bean.objectUrl}</div></td>
					<td width="100">
					<c:if test="${bean.off == 1}">
						<div title="">上架</div>
					</c:if>
					<c:if test="${bean.off == 0}">
						<div title="">下架</div>
					</c:if>
					</td>
					<td width="180"><div class="table_link_div"><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div></td>
					<td width="280">
					<div class="table_link_div200" style="position: relative;top:5px;">
					<!-- 上架或下架 -->
						<c:if test="${bean.off == 1}">
							<a class="a_com shelves_list_a toOffShelves" onclick="toOffShelves('${bean.id}')">
								<i class="offShelves_ico"></i>
								<i class="offShelves_hover"></i>
							</a>
						</c:if>
						<c:if test="${bean.off == 0}">
							<a class="a_com shelves_list_a toShelves" onclick="toShelves('${bean.id}')">
								<i class="shelves_ico"></i>
								<i class="shelves_hover"></i>
							</a>
						</c:if>
					<!-- 编辑按钮 -->
						<a class="a_com delete_list_a" vals="" onclick="edit('${bean.id}')"><i class="edit_icon"></i><i class="edit_hover" ></i></a>
						<!-- 删除按钮 -->
						<a class="a_com edit_list_a" onclick="delObject('${bean.id}')"><i class="dele_icon"></i><i class="dele_hover"></i></a> 
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
<!--上架弹窗-->
<div class="reminder-dialog onShelf">
	 <div class="dialog-tit">
	     <span>系统提示</span>
	     <span class="close-ico">×</span>
	 </div>
	 <p class="dialog-content">确定上架该连接器吗?</p>
	 <div class="command-btns">
	     <input class="command-btn" type="button" value="取消 "><input  class="command-btn" type="button" value="确认">
	 </div>
</div>

<!--下架弹窗-->
<div class="reminder-dialog remove">
	 <div class="dialog-tit">
	     <span>系统提示</span>
	     <span class="close-ico">×</span>
	 </div>
	 <p class="dialog-content">确定下架该连接器吗?</p>
	 <div class="command-btns">
	     <input class="command-btn cancel" type="button" value="取消 "><input  class="command-btn confirm" type="button" value="确认">
	 </div>
</div>
<script src="${backStatic}/js/jquery.min.2.2.2.js"></script>
<script>

/* 下架该连接器 */
function toOffShelves(id){
	if(window.confirm('确定下架该连接器吗？')){
		$.ajax({
	        type: "POST",
	        url: "./updateOffStatus.sys",
	        data:{"id":id,"off":0},
	        success: function (res) {
				alert(res.message);
	         	window.location.href="./objectList.sys";
	        },
	        error: function(data) {
	            alert("下架该连接器失败！");
	         }
	    });
     }else{
        return false;
    }
}
/* 上架该连接器  */
function toShelves(id){
	if(window.confirm('确定上架该连接器吗？')){
		$.ajax({
	        type: "POST",
	        url: "./updateOffStatus.sys",
	        data:{"id":id,"off":1},
	        success: function (res) {
				alert(res.message);
	         	window.location.href="./objectList.sys";
	        },
	        error: function(data) {
	            alert("上架该连接器失败！");
	         }
	    });
     }else{
        return false;
    }
}
/* 删除连接器  */
function delObject(id){
	if(window.confirm('确定删除该连接器吗？')){
		$.ajax({
	        type: "POST",
	        url: "./delObject.sys",
	        data:{"id":id},
	        success: function (res) {
				alert(res.message);
	         	window.location.href="./objectList.sys";
	        },
	        error: function(data) {
	            alert("删除该连接器失败！");
	         }
	    });
     }else{
        return false;
    }
}
//跳到添加连接器页面
$(".add").click(function(){
	location.href="./toaddObject";
})

function edit(id){
	location.href="./toaddObject?id="+id;
}
</script>

<script src="${ctxStatic}/My97DatePicker/lang/zh-cn.js" charset="UTF-8"></script>
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js"></script>
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js"></script>
</body>
</html>