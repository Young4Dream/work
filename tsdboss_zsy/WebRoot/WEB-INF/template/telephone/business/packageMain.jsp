<%-- 
    File Name:  tariff/Set1rate.jsp
    Function:   
    Author:     chenze
    Date:       2010-10-11
    Description: 
    Modify:     youhongyu 移植 	
                2010-11-5   chenze  添加注释
                2010-11-10   尤红玉  头部注释
                2010-11-26  chenze  增加高级查询和导出数据时Blob字段转换
                2010-12-10  liwen   修改，新增，查询弹出面板的标题修改
                2010-12-15 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
                2010-12-17 youhongyu   查询有问题，输入计费网名为公网，查询不出结果.解决方法：将附有初始值的text框的值置空
                					    打开通用查询，头部无法正确显示当前批操作类型问题更正
                
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>

<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
	String pageSize = (String)request.getParameter("pageSize");
	String currentPage = (String)request.getParameter("currentPage");
	String totalPage = (String)request.getParameter("totalPage");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Definition relay Bureau to Group</title>
   
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="AeroWindow/js/jquery-1.4.2.min.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
			
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/datalength.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
					
		<style type="text/css">
			.header { 
				font-size: 100%; font-weight: bold; text-align: left;
				padding: 2px;
				background-image: url(plug-in/jquery/jqgrid/themes/basic/images/headerbg.gif) ;
				color: #FFFFFF;
				width: 100%;
				white-space:nowrap; 
			}
			
			.subScroll {
				width:100%; 
				position:fixed;bottom:10px;
				vertical-align: top;
				height: 23px;
				white-space: nowrap;
				text-align: center;
				background-image: url(plug-in/jquery/jqgrid/themes/basic/images/grid-blue-ft.gif);
			}
			#tabs{
				/**margin-right:150px;*/
				width:88%;
			}
		</style>
	<script type="text/javascript">
	$(function(){
		var pageSize = <%=pageSize%>;
		var currentPage = <%=currentPage%>;
	    var totalPage = <%=totalPage%>;
	    
		if(pageSize != null && currentPage != null && totalPage != null){
			initData(pageSize,currentPage,totalPage);//初始化数据
		}else{
			initData(30,1,1);//初始化数据
		}
		
		$("#pageSizeSpan").change(function(){
			
			//重新加载数据
			var pageSize = $(this).val();
			var currentPage = $("#currentPage").val();
		    var totalPage = $("#totalPage").val();
		    initData(pageSize, currentPage, totalPage);
		});
	});
	
	//跳转到首页
	function firstPage(){
		var pageSize = $("#pageSize").val();
		var currentPage = 1;
	    var totalPage = $("#totalPage").val();
	    //initData(pageSize, currentPage, totalPage);
	    jumpPage('telephone/business/packageMain.jsp?pageSize='+pageSize+"&currentPage="+currentPage+"&totalPage="+totalPage);
	}
	
	//跳转到上一页
	function prevPage(){
		var pageSize = $("#pageSize").val();
		var currentPage = parseInt($("#currentPage").val()) - 1;
	    var totalPage = $("#totalPage").val();
	    var searchFlag =$("#searchFlag").val();
	    var packageName = $("#packageName").val();
	    var packageType =$("#packageType").val();
	    var packageStatus =$("#packageStatus").val();
	    jumpPage('telephone/business/packageMain.jsp?pageSize='+pageSize+"&currentPage="+currentPage+"&totalPage="+totalPage);
	    //initData(pageSize, currentPage, totalPage);
	}
	
	//跳转到下一页
	function nextPage(){
		var pageSize = $("#pageSize").val();
		var currentPage = parseInt($("#currentPage").val()) + 1;
	    var totalPage = $("#totalPage").val();
	    var searchFlag =$("#searchFlag").val();
	    var packageName = $("#packageName").val();
	    var packageType =$("#packageType").val();
	    var packageStatus =$("#packageStatus").val();
	    jumpPage('telephone/business/packageMain.jsp?pageSize='+pageSize+"&currentPage="+currentPage+"&totalPage="+totalPage);
	    //initData(pageSize, currentPage, totalPage);
	}
	
	//跳转到尾页
	function lastPage(){
		var pageSize = $("#pageSize").val();
		var currentPage = $("#totalPage").val();
	    var totalPage = $("#totalPage").val();
	    var searchFlag =$("#searchFlag").val();
	    var packageName = $("#packageName").val();
	    var packageType =$("#packageType").val();
	    var packageStatus =$("#packageStatus").val();
	    jumpPage('telephone/business/packageMain.jsp?pageSize='+pageSize+"&currentPage="+currentPage+"&totalPage="+totalPage);
	    //initData(pageSize, currentPage, totalPage);
	}
	
	//初始化页面数据
	function initData(pageSize,currentPage,totalPage){
		//初始页面
		var url = 'packageMainServlet.html?pageSize='+pageSize+"&currentPage="+currentPage+"&totalPage="+totalPage;
		$.ajax({
			url:url,
			data:'cmd='+0,
			datatype:'html',
			type:'post',
			cache:false,
			timeout: 1000,
			async: false,//同步方式
			success:function(res){
				$("#tbody").html("");
				var items = res.split("&&&")[0];
				var pageObject = res.split("&&&")[1];
				pageObject = $.parseJSON(pageObject);
				
				items = $.parseJSON(items);
				$.each(items, function(i, item) {
					var statusName = '';
					if(item.packageStatus == 1){
						statusName = '创建';
					}else if(item.packageStatus == 2){
						statusName = '已发布';
					}else{
						statusName = '下线';
					}
					var operator='';
					if(item.operator == 1){
						operator='电信';
					}else if(item.operator == 2){
						operator='联通';
					}else if(item.operator == 3){
						operator='内部';
					}
					
		            $("#tbody").append("<tr><td><img onclick='modify("+item.id+")' style='cursor:pointer;' src='style/images/public/ltubiao_01.gif'/>&nbsp;&nbsp;<img  onclick='deleteMethod("+item.id+")' style='cursor:pointer;' src='style/images/public/ltubiao_02.gif'/>&nbsp;<img  onclick='detail("+item.id+")' style='cursor:pointer;' src='style/images/public/ltubiao_03.gif'/></td>"+
				      "<td>"+item.packageName+"</td>"+
				      "<td>"+item.packageTypeName+"</td>"+
				      "<td>"+item.packageFee+"</td>"+
				      "<td>"+statusName+"</td>"+
				      "<td>"+item.pagFreeNum+"</td>"+
				      //"<td>"+operator+"</td>"+
				      "<td>" + (item.serviceType == undefined ? '' : item.serviceType) + "</td>" +
				      "<td>" + (item.subServiceType == undefined ? '' : item.subServiceType) + "</td>" +
				      "<td>"+getSmpFormatDate(new Date(item.createTime),true)+"</td><tr>");
		        });
		        
		        $("#currentPageInt").val(pageObject.currentPage);
		        $("#totalPageSpan").text(pageObject.totalPage);
		        $("#sumCloumSpan").text(pageObject.sumCloum);
		        $("#pageSizeSpan").val(pageObject.pageSize);
		        
		        $("#currentPage").val(pageObject.currentPage);
		        $("#totalPage").val(pageObject.totalPage);
		        $("#sumCloum").val(pageObject.sumCloum);
		        $("#pageSize").val(pageObject.pageSize);
		        
		        $(".showImgLeft").hide();
		        if(pageObject.currentPage < pageObject.totalPage){
		        	$(".hidImgRight").hide();
		        	$(".showImgRight").show();
		        }else{
		        	$(".hidImgRight").show();
		        	$(".showImgRight").hide();
		        }
		        
		        if(pageObject.currentPage > 1){
		        	$(".hidImgLeft").hide();
		        	$(".showImgLeft").show();
		        }else{
		        	$(".hidImgLeft").show();
		        	$(".showImgLeft").hide();
		        }
			}
		});
	}
	
	//扩展Date的format方法
	Date.prototype.format = function (format) {
		var o = {
			"M+": this.getMonth() + 1,
			"d+": this.getDate(),
			"h+": this.getHours(),
			"m+": this.getMinutes(),
			"s+": this.getSeconds(),
			"q+": Math.floor((this.getMonth() + 3) / 3),
			"S": this.getMilliseconds()
		}
		if (/(y+)/.test(format)) {
			format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		}
		for (var k in o) {
			if (new RegExp("(" + k + ")").test(format)) {
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
			}
		}
		return format;
	}
	/**
	*转换日期对象为日期字符串
	* @param date 日期对象
	* @param isFull 是否为完整的日期数据,
	* 为true时, 格式如"2000-03-05 01:05:04"
	* 为false时, 格式如 "2000-03-05"
	* @return 符合要求的日期字符串
	*/
	function getSmpFormatDate(date, isFull) {
		var pattern = "";
		if (isFull == true || isFull == undefined) {
			pattern = "yyyy-MM-dd hh:mm:ss";
		} else {
			pattern = "yyyy-MM-dd";
		}
		return getFormatDate(date, pattern);
	}
	/**
	*转换当前日期对象为日期字符串
	* @param date 日期对象
	* @param isFull 是否为完整的日期数据,
	* 为true时, 格式如"2000-03-05 01:05:04"
	* 为false时, 格式如 "2000-03-05"
	* @return 符合要求的日期字符串
	*/
	function getSmpFormatNowDate(isFull) {
		return getSmpFormatDate(new Date(), isFull);
	}
	/**
	*转换long值为日期字符串
	* @param l long值
	* @param isFull 是否为完整的日期数据,
	* 为true时, 格式如"2000-03-05 01:05:04"
	* 为false时, 格式如 "2000-03-05"
	* @return 符合要求的日期字符串
	*/
	function getSmpFormatDateByLong(l, isFull) {
		return getSmpFormatDate(new Date(l), isFull);
	}
	/**
	*转换long值为日期字符串
	* @param l long值
	* @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss
	* @return 符合要求的日期字符串
	*/
	function getFormatDateByLong(l, pattern) {
		return getFormatDate(new Date(l), pattern);
	}
	/**
	*转换日期对象为日期字符串
	* @param l long值
	* @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss
	* @return 符合要求的日期字符串
	*/
	function getFormatDate(date, pattern) {
		if (date == undefined) {
			date = new Date();
		}
		if (pattern == undefined) {
			pattern = "yyyy-MM-dd hh:mm:ss";
		}
		return date.format(pattern);
	} 
        
	function modify(id){
		jumpPage('telephone/business/packageMainMod.jsp&cmd=2&id='+id);
	}
	
	function deleteMethod(id){
		if(confirm("确认删除？")){
			var count = checkPackageRelate(id);
			if(count > 0){
				alert("套餐已被引用，不可删除");
				return;
			}
			var url = 'packageMainServlet.html';
			$.ajax({
				url:url,
				data:'cmd='+3+"&id="+id,
				datatype:'html',
				type:'post',
				cache:false,
				timeout: 1000,
				async: false,//同步方式
				success:function(res){
					if(res == 0){
						alert("操作成功");
						window.location.reload();
					}else{
						alert("操作失败");
					}
				}
			});
			
		}
	}
	
	function checkPackageRelate(id){
		var count = 0;
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'ExecuteSql',//类名
			  method:'exeSqlData',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'xml',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		$.ajax({
			url:"mainServlet.html?"+urlstr+"&sumfields=count(*)&tablename=yhdang t &initialization=1=1&fusearchsql=t.package_id='"+id+"'",
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$("#packageDetail2").html("");
				var packageMainDetail='';
				$(xml).find('row').each(function(){
							
					var index = 0;			
					var pag_free_num='';
					$(this).find('cell').each(function(){
						if(index ==0){
							count = $(this).text();
						}
						index++;
					});		
				});	
			}
		});
		return count;
	}
	
	function detail(id){
		jumpPage('telephone/business/packageMainMod.jsp&cmd=4&id='+id);
	}
	//页面跳转
function jumpPage(pagename){
	if (!pagename || pagename == "#") {
		return;
	}
	$('#main-frame', parent.document).attr('src', 'mainServlet.html?pagename=' + pagename + '&tsdtemp=' + Math.random());
}
	</script>
</head>

<body> 
<form name="childform" id="childform">
	<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
</form>

<input type='hidden' id='pageSize'/> 
<input type='hidden' id='currentPage'/> 
<input type='hidden' id='totalPage'/> 
<input type='hidden' id='sumCloum'/> 

<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 

<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
<!-- 语言 -->
<input type="hidden" id="lanType" name="lanType" value='<%=lanType %>' />

<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
<input type="hidden" name="languageType" id="languageType" value='<%=lanType %>' />
  	<div id="navBar">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		: 套餐管理 >>> 套餐管理	
		<div style="position:fixed; right:35px;line-height:20px;">
			<a onclick="parent.history.back(); return false;" href="javascript:void(0);">返 回</a>
		</div>
	</div>
  	<br />
  	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openadd1" onclick="jumpPage('telephone/business/packageMainAdd.jsp');">
			<!--添加--><fmt:message key="global.add" />
	    </button>
	    <!--查询-->
	    <!--<button type="button" onclick="openSearchForm()">			
			<fmt:message key="global.query" />
		</button>
	--></div>
	<!-- Tabs -->
	<div id="tabs">	
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0">
		    	<thead>
		    		<tr class="header"><img style="float:left;" src="plug-in/jquery/jqgrid/themes/basic/images/headleft.png"></img>&nbsp;套餐管理</tr>
		    		<tr>
				      <th>修改|删除|显示详细</th>
				      <th>套餐名称</th>
				      <th>套餐类型</th>
				      <th>套餐计划固定费</th>
				      <th>套餐状态</th>
				      <th>包月费免费期数</th>
				      <th>服务类型</th>
				      <th>服务子类型</th>
				      <th>创建时间</th>
				    </tr>
		    	</thead>
		    	<tbody id="tbody">
		    		
		    	</tbody>
		    	<tfoot>
				    <tr>
				    </tr>
				  </tfoot>
		    </table>
			<div id="pagered" class="subScroll" style="text-align: left;">
				<img src="plug-in/jquery/jqgrid/themes/basic/images//refresh.gif" style="cursor:pointer;" onclick="javascript:window.location.reload();"></img>
				<img src="plug-in/jquery/jqgrid/themes/basic/images//off-first.gif" class="hidImgLeft"></img>
				<img src="plug-in/jquery/jqgrid/themes/basic/images//off-prev.gif" class="hidImgLeft"></img>
				<img src="plug-in/jquery/jqgrid/themes/basic/images//first.gif" class="showImgLeft"  onclick="firstPage();"></img>
				<img src="plug-in/jquery/jqgrid/themes/basic/images//prev.gif" class="showImgLeft"  onclick="prevPage();"></img>
				<input size="3" maxlength="5" value="1" id="currentPageInt"/>
				<span>/</span><span id="totalPageSpan"></span>
				<img src="plug-in/jquery/jqgrid/themes/basic/images//off-next.gif" class="hidImgRight"></img>
				<img src="plug-in/jquery/jqgrid/themes/basic/images//off-last.gif" class="hidImgRight"></img>
				<img src="plug-in/jquery/jqgrid/themes/basic/images//next.gif" class="showImgRight" onclick="nextPage();"></img>
				<img src="plug-in/jquery/jqgrid/themes/basic/images//last.gif" class="showImgRight" onclick="lastPage();"></img>
				<select style="width:50px;" id="pageSizeSpan">
					<option value="30">30</option>
					<option value="50">50</option>
					<option value="100">100</option>
				</select>
				<span  id="sumCloumSpan"> 0</span> 行
			</div>
		</div>		
	</div>
</body>
</html>
