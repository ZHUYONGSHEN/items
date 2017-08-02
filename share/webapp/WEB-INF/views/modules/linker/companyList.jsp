<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>所在公司</title>
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
		.model{position: fixed;left: 0;right: 0; top: 0;bottom: 0;z-index: 888;width:100%;height:100%;background:rgba(0,0,0,.5);}
		.detailWrap{width:410px;border:1px solid #e1e7eb; border-radius:5px;background:#fff; position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);}
		.titleWrap{height:60px;line-height:60px;padding:0 20px;color:#29353D;font-size:18px;}
		.titleWrap h3{display:inline-block;}
		.btn-close{float:right; color:#c2ced6;}
		.companyBox{font-size:16px; padding:10px 20px;border-top:1px solid #e1e7eb;}
		.btnWrap{height:74px;line-height:74px;text-align:right;padding-right:20px;}
		.btnWrap .btn{text-decoration: none; border: none; color: #fff; font-size: 14px; padding: 10px 30px; border-radius: 4px; }
		.btnWrap .btn.btnSubmit{background: #0ED98C;}
		
		.companyBox .tRe{width:100%;font-size:14px;border:1px solid #D6DEE4;margin-top:15px;padding:5px 10px;}
		.companyBox .remark{color:red;font-size:14px;padding-top:5px;}
	</style> 
</head>
<body>
<div class="mian_com">
	<div class="clear">
    	<div style="float:right;">
	       <a href="javascript:void(0)" class="index_list_btn_new addOb fl"><em class="icon-add"></em>新增</a>
	    </div>
    </div>
  	<form id="searchForm" action="${siteRoot}/object/companyList" method="post" >
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
					<th>创建人</th>
					<th>创建日期</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page.list}" var="item" varStatus="i">
				<tr>		
					<td width="100"><div>${i.count }</div></td>
					<td width="240"><div title="${item.companyName}">${item.companyName}</div></td>
					<td width="120"><div title="${item.createUser}">${item.createUser}</div></td>
					<td width="120"><div title=""><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></div></td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<!--分页-->
		<div class="pagination">${page}</div>
	</div>  
</div>
<div class="model" style="display:none;">
<div class="detailWrap">
	<div class="titleWrap"><h3>新增"所在公司"</h3><a href="javascript:;" class="btn-close">X</a></div>
	<div class="companyWrap">
		<div class="companyBox">
			<label>公司名称:</label>
			<textarea rows="5" class="tRe" placeholder="请输入15个字以内的公司名" maxlength="15"></textarea>
			<p class="remark"></p>
		</div>
		<div class="btnWrap" style="text-align:center;">
			<a href="javascript:;" class="btn btnSubmit">提交</a>
		</div>
	</div>
</div>
</div>
<script type="text/javascript">
	$(".addOb").click(function(){
		$('.model').fadeIn();
	})
	$(".model").on("click",".btnSubmit",function(){
		var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？%+_]");
		var name = $(".tRe").val();
		
		if ($.trim($('.tRe').val()) == "") {
			$('.remark').html("*公司名不能为空");
			return false;
		} 
		if(pattern.test(name)){
			$(".tRe").val("")
			return false;
		}
		$.post("./addCompanyInfo",{companyName:name},function(data){
			if(data.code == 0){
				window.location.href="./companyList.sys";
			}else{
				$('.remark').html(data.msg);
			}
		})
		
	})
	/* 关闭弹框 */
	$(".model").on("click",".btn-close",function(){
		$('.model').fadeOut();
	})
	$('.tRe').on('focus', function() {
		$('.remark').html("");
	});
	
	
</script>
</body>
</html>