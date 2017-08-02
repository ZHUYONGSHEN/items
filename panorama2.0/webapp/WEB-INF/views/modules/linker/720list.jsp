<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="admin"/>
    <title>列表页</title>
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
    	<a href="http://app.hiweixiao.com/Proxy/Public/login" target="_blank" class="changess fl"><img width="20px" height="20px" class="fl" style="margin:10px 15px 0 20px;" src="${backStatic}/images/icon_change.png"><span style="display:inline-block;" class="fl">切换老版本</span></a>
    	<div style="width:575px;float:right;">
			<div class="fl" style="width: 250px;display: inline-block;margin-right:40px;">
	            <div class="search_com clear">
	            	<form id="searchForm" action="${siteRoot}/object/objectList" method="post" >
	            		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<div style="position: absolute;left: 220px;top: 25px;">是否推荐：
							  <span>
								<select name="isCommend" style="width: 100px;border: 1px solid #ccc;background: none;padding: 5px;">
								   <option value="-1" <c:if test="${object.isCommend == null || object.isCommend == -1}">selected</c:if>>全部</option>
			                  	   <option <c:if test="${object.isCommend == 0}">selected</c:if>  value="0">不推荐</option>
			                  	   <option <c:if test="${object.isCommend == 1}">selected</c:if>  value="1">推荐</option>
		                  	  </select>
		                  	  </span>
		                  	  </div>
		                <input type="text" id="objectName" name="objectName"  value="${object.objectName}" class="search_com_input_tx fl"/>
		                  
		                <input type="submit" class="search_com_input_sub fl" value=""/>
	                </form>
	            </div>
	        </div>
	       <a href="javascript:void(0)" class="index_list_btn_new addOb fl" style="display:inline-block;margin-right:19px;"><em class="icon-add"></em>新增</a>
	        <a href="javascript:void(0)" class="list720log mr20 see_log fl" style="display:inline-block;">查看操作记录</a>
	    </div>
    </div>
	<div class="list_index_mian mt20">
        <table class="table_com">
			<thead>
				<tr>
					<th><div class="table_link_div">项目名称</div></th>
					<th><div class="table_link_div">房源类型</div></th>
					<th><div class="table_link_div">网址</div></th>
					<th><div class="table_link_div">描述</div></th>
					<th>创建人</th>
					<th>创建时间</th>
					<th>操作</th>
					 <th>是否推荐</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="bean" varStatus="status">
				<tr>		
					<td width="280"><div class="table_link_div200" title="${bean.objectName}">${bean.objectName}</div></td>
					<td width="50" class="pro_id">
						<div data-titles="${bean.id}" title="${bean.id}">
							<c:if test="${bean.fyType == 0}">
								新房
							</c:if>
							<c:if test="${bean.fyType == 1}">
								二手房
							</c:if>
							<c:if test="${bean.fyType == 2}">
								其他
							</c:if>
						</div>
					</td>
					<td width="340" class="clear">
						<div class="fl" style="position: relative;top:8px;" title="${fns:getHost()}/linker/${bean.id}">
							<a>${fns:getHost()}/linker/${bean.id}</a>
						</div>
						<div class="copylisthref_div fl" style="position: relative;top:10px;">
							<input type="button" value="复制" class="copylisthref" data-clipboard-text="${fns:getHost()}/linker/${bean.id}">
						</div>
					</td>
					<td width="120"><div title="${bean.objectSynopsis}">${bean.objectSynopsis}</div></td>
					<td width="100"><div title="${bean.createBy}">${bean.createBy}</div></td>
					<td width="180"><div class="table_link_div"><fmt:formatDate value="${bean.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div></td>
					<td width="280">
					<div class="table_link_div200" style="position: relative;top:5px;">
					<!-- 删除按钮 -->
						<a class="a_com edit_list_a" onclick="delobject('${bean.id}');"><i class="dele_icon"></i><i class="dele_hover"></i></a>
						<a class="a_com record_list_a" vals="${bean.id}" href="javascript:void(0)"> <i class="data_icon"></i><i class="data_hover"></i> </a> 
					<!-- 编辑按钮 -->
						<a class="a_com delete_list_a" vals="${bean.id}" href="javascript:void(0)"><i class="edit_icon"></i><i class="edit_hover" ></i></a>
						<c:if test="${bean.mid != null && bean.mid != ''}">
							<!-- 留言按钮 -->
							<a class="a_com message_list_a" vals="${bean.id}" vals1="${bean.objectName}" href="javascript:void(0)"><i class="message_icon"></i><i class="message_hover" ></i></a>
						</c:if>
						<c:if test="${bean.aid != null && bean.aid != ''}">
							<!-- 预约看房按钮 -->
							<a class="a_com yuyue_list_a" vals="${bean.id}" vals1="${bean.objectName}" href="javascript:void(0)"><i class="yuyue_icon"></i><i class="yuyue_hover" ></i></a>
						</c:if>
					<!-- 二维码按钮 -->
						<a class="a_com qrcode_a"><i class="qrcode_icon"></i></a>
						</div>
					</td>
					 <td width="100">
						<c:if test="${bean.isCommend == 0}"><div title="不推荐"><a onclick="updateIsCommend('${bean.id}',1,this);" class="a_com switch-off"></a></div></c:if><c:if test="${bean.isCommend == 1}"><div title="推荐"><a onclick="updateIsCommend('${bean.id}',0,this);" class="a_com switch-on"></a></div></c:if>
					</td> 
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<!--分页-->
		<div class="pagination">${page}</div>
	</div>  
</div>

<!-- 二维码浮层 -->
<div class="qrcodes_mask hide_com"></div>
<div id="qrcodes">
	<div class="qrcodes_content"></div>
	<p>请使用微信扫一扫阅览</p>
</div>


<!--操作记录-->
<div id="record_list" class="hide_com">
    <table class="table_com" >
        <thead>
        <tr>
            <th>操作人</th>
            <th>操作</th>
            <th>操作时间</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>尊豪网络科技有限公司</td>
            <td>编辑 分享</td>
            <td>2016年12月9日</td>
        </tr>
        </tbody>
    </table>
</div>
<script src="http://cdn.szzunhao.com/hongbao/hongbaobehind/js/bootstrap-datetimepicker.min.js"></script>
<script src="http://cdn.szzunhao.com/hongbao/hongbaobehind/js/jquery.cookie.js"></script>
<script type="text/javascript" src="http://cdn.szzunhao.com/hongbao/hongbaobehind/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://cdn.szzunhao.com/hongbao/hongbaobehind/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="http://cdn.szzunhao.com/hongbao/hongbaobehind/js/responsive-tables.js"></script>
<script type="text/javascript" src="http://cdn.szzunhao.com/hongbao/hongbaobehind/js/charisma.js"></script>
<script type="text/javascript" src="http://cdn.szzunhao.com/hongbao/hongbaobehind/js/jquery.twbsPagination.js"></script>
<script src="${backStatic}/js/ZeroClipboard.min.js"></script>
<script src="${backStatic}/js/jquery.qrcode.min.js"></script>
<script>

/* 二维码浮层 */
$(".qrcode_a").click(function(){
	$(".qrcodes_mask").css("display","block");
	$("#qrcodes").css("display","block");
	var ip_addr = document.location.hostname;
	var objectUrl = 'http://'+ip_addr+'/linker/'+$(this).parents("td").siblings(".pro_id").find("div").data("titles");
	$('.qrcodes_content').qrcode(objectUrl); //任意字符串 
	
});



$(".qrcodes_mask").click(function(){
	$(this).hide();
	$("#qrcodes").hide();
	$("#qrcodes canvas").remove();
});


$(".copylisthref").click(function() {
    var text = $(this).parents('td').find('a').html();
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val(text).select();
    document.execCommand("copy");
    $temp.remove();
    alert("已复制到剪切板")
});
var trthis;
$('.table_com tr').hover(function(){
	trthis=$(this)
	$(this).find('.copylisthref').show()
},function(){
	trthis=$(this)
	$(this).find('.copylisthref').hide()
})
$('#global-zeroclipboard-html-bridge').hover(function(){
	trthis.find('.copylisthref').show()
},function(){
	trthis.find('.copylisthref').hide()
})
</script>
<script type="text/javascript">
$('body').on('keypress','#objectName',function(e){
	if(e.which == 13) {
		$("#pageNo").val(1);
		$("#searchForm").submit();
	}
});
function delobject(id){
	var flag = "${deleteFlag}";
	if(flag=="true"){
		if(window.confirm('你确定要删除项目吗？')){
			$.ajax({
		        type: "POST",
		        url: "./delObject.sys?id="+id,
		        success: function (res) {
					alert(res.message);
//		          	var accountId = $("#accountId").val();
//		          	var token = $("#token").val();
		         	window.location.href="./objectList.sys";
		        },
		        error: function(data) {
		            alert("删除项目失败！");
		         }
		    });
	     }else{
	        //alert("取消");
	        return false;
	    }
	}else{
		alert("没有权限!");
	}

}



$(".record_list_a").click(function(){
	var flag = "${operateLogFlag}";
	if(flag=="true"){
		$(this).attr("href","${backPath}/linker/log?keyword=" + $(this).attr("vals"));
		$(this).click();
	}else{
		alert("没有权限!");
	}
});

/* 编辑 */
$(".delete_list_a").click(function(){
	var flag = "${updateFlag}";
	if(flag=="true"){
		$(this).attr("href","./toaddObject.sys?id=" + $(this).attr("vals"));
		$(this).click();
	}else{
		alert("没有权限!");
	}
});
$(".message_list_a").click(function(){
	$(this).attr("href","./toLinkerMessageList.sys?linkerId=" + $(this).attr("vals") +"&objectName=" + encodeURI(encodeURI($(this).attr("vals1"))));
	$(this).click();
});
$(".yuyue_list_a").click(function(){
	$(this).attr("href","./toAppointmentDataList.sys?linkerId=" + $(this).attr("vals") +"&objectName=" + encodeURI(encodeURI($(this).attr("vals1"))));
	$(this).click();
});
$(".see_log").click(function(){
	var flag = "${operateLogFlag}";
	if(flag=="true"){
		$(this).attr("href","${backPath}/linker/log");
		$(this).click();
	}else{
		alert("您没有权限!");
	}
});

$(".addOb").click(function(){
	var flag = "${addFlag}";
	if(flag=="true"){
		var createBy = '${createBy}';
		$(this).attr("href","./toaddObject?createBy="+createBy);
		$(this).click();
	}else{
		alert("您没有权限!");
	}
});
$('.search_com_input_tx').focus(function(){
	$('.search_com').css('border','#36aaf6 solid 1px')
})
$('.search_com_input_tx').blur(function(){
	$('.search_com').css('border','#d6dee4 solid 1px')
})
function updateIsCommend(id,isCommend,obj){
	var flag = "${commendFlag}";
	if(flag=="true"){
		$.ajax({
	        type: "POST",
	        url: "./updateIsCommend.sys",
	        data:{"id":id,"isCommend":isCommend},
	        success: function (res) {
	        	if(res.code ==0){
	        		if($(obj).hasClass("switch-off")){
	        			$(obj).removeClass("switch-off").addClass("switch-on");
	        			$(obj).parent("div").attr("title","推荐");
	        		}else{
	        			$(obj).removeClass("switch-on").addClass("switch-off");
	        			$(obj).parent("div").attr("title","不推荐");
	        		}
	        	}else{
	        		 alert("推荐失败！");
	        	}
	        },
	        error: function(data) {
	            alert("推荐失败！");
	         }
	    }); 
	}else{
		alert("您没有权限!");
	}
  	
}

</script>
</body>

</html>