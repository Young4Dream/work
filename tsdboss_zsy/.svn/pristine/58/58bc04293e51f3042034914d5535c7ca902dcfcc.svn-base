<%----------------------------------------
	name: broadband/usercat/onlinecount.jsp
	Function:  宽带在线用户统计 每小时统计一次宽带在线用户
	author: 吴长龙
	version: 1.0, 2010-11-3
	description:  
	modify: 
		2010-11-3 吴长龙 添加注释
		2010-11-08  chenze  添加方法注释
		2010-12-13  尤红玉    打印功能修改		 
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 <%@page import="com.tsd.service.util.Log" %>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>"/>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    	<title>宽带在线用户统计</title>
  		<meta http-equiv="cache-control" content="no-cache"/>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 时间选择器需要导入的js文件 -->	
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js" ></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/imgs/daohangbg.jpg); line-height:28px;}
			.inputbox{{background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:80px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		</style>
		<script type="text/javascript">
		/**
		 * 获取要提交的参数
		 * @param
		 * @return
		 */
		function getParams(){
			return tsd.buildParams({packgname:'service',clsname:'ExecuteSql',method:'exeSqlData',ds:'broadband',tsdcf:'mysql',tsdoper:'query',datatype:'xml',tsdpk:'dbsql_onlinecount.query',tsdpkpagesql:'dbsql_onlinecount.querypage'});
		}
		/**
		 * 获取查询参数
		 * @param
		 * @return
		 */
		function getQueryParams(){
			var urlstr = new Array();//urlstr.push(i);urlstr.join("");
			urlstr.push("&fusearchsql= 1=1 ");
			var tBegin = tsd.encodeURIComponent($("#tBegin").val());
			var tEnd = tsd.encodeURIComponent($("#tEnd").val());
			if(tBegin != ""){
				urlstr.push(" AND COUNT_DATE>= ");
				urlstr.push("TO_DATE('");
				urlstr.push(tBegin);
				urlstr.push("', 'yyyy-mm-dd')");
			}
			if(tEnd != ""){
				urlstr.push(" AND COUNT_DATE<= ");
				urlstr.push("TO_DATE('");
				urlstr.push(tEnd);
				urlstr.push(" 23:59:59', 'yyyy-mm-dd hh24:mi:ss')");
			}
			return urlstr.join("");
		}
		/**
		 * 刷新jqGrid
		 * @param
		 * @return
		 */
		function refresh(){
			//拼接动态条件
			var urlstr = new Array(getParams());//urlstr.push(i);urlstr.join("");
			urlstr.push(getQueryParams());
			//刷新表格
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr.join("")}).trigger("reloadGrid");
		}
		/**
		 * 导出Excel
		 * @param
		 * @return
		 */
		function exportData(){
			/*
			var url = 'ReportServer?reportlet=/com/tsdreport/broadband_onlinecount.cpt&format=excel'+getQueryParams()+'&t='+new Date().getTime();
			window.location.href = url;
			*/
			
			//找不到改报表
			printThisReport1('<%=request.getParameter("imenuid")%>','call_type_num',
				'format=excel'+getQueryParams()+'&t='+new Date().getTime(),'<%=(String)session.getAttribute("userid")%>',
				'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
				'<%=(String)session.getAttribute("departname")%>');
		}
		/**
		 * 打印预览
		 * @param
		 * @return
		 */
		function print(){
			var url = 'ReportServer?reportlet=/com/tsdreport/broadband_onlinecount.cpt&'+getQueryParams()+'&t='+new Date().getTime();
			window.showModalDialog(url,window,'dialogWidth:750px; dialogHeight:430px; center:yes; scroll:no');
		}
		/**
		 * 页面加载时执行
		 * @param
		 * @return
		 */
		$(function(){
		/////设置命令参数
	    var urlstr=getParams();
		urlstr+="&fusearchsql= 1=1 "
		var opr = $("#operation").val();

		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr,
				datatype: 'xml', 
				colNames:['日期\\小时','00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23'], 
				colModel:[
						{name:'COUNT_DATE',index:'COUNT_DATE',width:80},
						{name:'HOUR0',index:'HOUR0',width:40},
						{name:'HOUR1',index:'HOUR1',width:40},
						{name:'HOUR2',index:'HOUR2',width:40},
						{name:'HOUR3',index:'HOUR3',width:40},
						{name:'HOUR4',index:'HOUR4',width:40},
						{name:'HOUR5',index:'HOUR5',width:40},
						{name:'HOUR6',index:'HOUR6',width:40},
						{name:'HOUR7',index:'HOUR7',width:40},
						{name:'HOUR8',index:'HOUR8',width:40},
						{name:'HOUR9',index:'HOUR9',width:40},
						{name:'HOUR10',index:'HOUR10',width:40},
						{name:'HOUR11',index:'HOUR11',width:40},
						{name:'HOUR12',index:'HOUR12',width:40},
						{name:'HOUR13',index:'HOUR13',width:40},
						{name:'HOUR14',index:'HOUR14',width:40},
						{name:'HOUR15',index:'HOUR15',width:40},
						{name:'HOUR16',index:'HOUR16',width:40},
						{name:'HOUR17',index:'HOUR17',width:40},
						{name:'HOUR18',index:'HOUR18',width:40},
						{name:'HOUR19',index:'HOUR19',width:40},
						{name:'HOUR20',index:'HOUR20',width:40},
						{name:'HOUR21',index:'HOUR21',width:40},
						{name:'HOUR22',index:'HOUR22',width:40},
						{name:'HOUR23',index:'HOUR23',width:40}
			       	], 
			       	rowNum:10, //默认分页行数
			       	rowList:[10,20,30,50,100], //可选分页行数
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pagered'), 
			       	sortname: 'COUNT_DATE', //默认排序字段
			       	viewrecords: true,
			       	sortorder: 'DESC',//默认排序方式 
			       	caption:'每小时宽带在线用户统计表', 
			       	height:300, //高
			        //width:document.documentElement.clientWidth-58,
			       	loadComplete:function(){
					var reduceHeight=$("#navBar").height()+$("#buttons").height()+$("#pagered").height()-26;
					setAutoGridHeight("editgrid",reduceHeight);
				}
				}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					);
			});
		</script>
		 </head>
  <body>   
  		<!-- 用户操作导航-->
		<div id="navBar">
			<div id="navBar1" style="float: left;"><img src="style/icon/dot11.gif" style="margin-left: 10px" /> 您当前所在的位置 :用户资料查询&nbsp;&nbsp;&#62;&#62;&#62;&nbsp;&nbsp;宽带在线用户统计</div>
			<div id="d2back" style="float: right;margin-right: 40px"><a href="javascript:void(0);"onclick="parent.history.back(); return false;">返 回</a></div>
		</div>
		<!-- 用户操作标题以及放一些快捷按钮-->	
		<div id="buttons">
			时间范围
			<input type="text" readonly="readonly" name="tBegin" id="tBegin" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" style="cursor: pointer;"/>
			到
			<input type="text" readonly="readonly" name="tEnd" id="tEnd" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" style="cursor: pointer;"/>
			<button class="tsdbutton" onclick="refresh()">查询</button>
			<!--button class="tsdbutton" onclick="print()">打印预览</button-->
			<button class="tsdbutton" onclick="exportData()">打印</button>
		</div>
	    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
  </body>
</html>