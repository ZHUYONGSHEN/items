<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="admin"/>
    <title>列表页</title>
<!--     <link id="bs-css" href="http://cdn.szzunhao.com/hongbao/hongbaobehind/css/bootstrap-cerulean.min.css" rel="stylesheet">
	<link href="http://cdn.szzunhao.com/hongbao/hongbaobehind/css/charisma-app.css" rel="stylesheet">
	<link href='http://cdn.szzunhao.com/hongbao/hongbaobehind/bower_components/chosen/chosen.min.css' rel='stylesheet'>
	<link href="http://cdn.szzunhao.com/hongbao/hongbaobehind/css/responsive-tables.css" rel='stylesheet'>
	<link href="http://cdn.szzunhao.com/hongbao/hongbaobehind/css/animate.min.css" rel='stylesheet'> -->
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
					<td width="280"><div class="table_link_div200" ></div></td>
					<td width="50" class="pro_id">
						<div data-titles="" title="">
						   
						   
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


</body>

</html>