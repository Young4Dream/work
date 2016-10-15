<%----------------------------------------
	name: broadband/usercat/authorizelog.jsp
	author: 吴长龙 
	version: 1.0, 2010-11-3
	description: 用户认证日志查询 
	modify: 
		2010-11-3 吴长龙 添加注释
		2010-11-08  chenze  添加方法注释 
		
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" pageEncoding="utf-8"%>
 
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>用户认证日志查询</title>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script type="text/javascript" src="plug-in/jquery/jquery.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/jquery.jqGrid.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/js/jqModal.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/js/jqDnR.js" ></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="script/public/mainStyle.js" ></script>
		
		<style type="text/css">
			#navBar1{height:26px;background:url(style/imgs/daohangbg.jpg); line-height:28px;}
			.inputbox{{background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:80px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		</style>
		
		<script type="text/javascript">
		/**
		 * 页面加载时执行
		 * @param
		 * @return
		 */
		jQuery(document).ready(function(){
			//设置命令参数
		    var urlstr=getParams();
			urlstr+="&fusearchsql= 1=1";
			 
			jQuery("#editgrid").jqGrid({
					url:'mainServlet.html?'+urlstr,
					datatype: 'xml', 
					colNames:['账号','登录时间','登录日志'], 
					colModel:[
							{name:'username',index:'username',width:120},
							{name:'log_time',index:'log_time',width:150},
							{name:'log_text',index:'log_text',width:740}
				       	], 
				       	rowNum:20, //默认分页行数
				       	rowList:[30,50,100], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'log_time', //默认排序字段
				       	viewrecords: true,
				       	sortorder: 'DESC',//默认排序方式 
				       	caption:'用户认证日志', 
				       	width:document.documentElement.clientWidth-50,
					    height:document.documentElement.clientHeight-150,
				       	loadComplete:function(){
							//var reduceHeight=$("#navBar").height()+$("#buttons").height()+$("#pagered").height()-26;
							//setAutoGridHeight("editgrid",reduceHeight);
						}
					}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
				);
			});
		/**
		 * 获得要提交的参数
		 * @param
		 * @return
		 */
		function getParams(){
			return tsd.buildParams({
					packgname:'service',
					clsname:'ExecuteSql',
					method:'exeSqlData',
					ds:'tsdBilling',
					tsdcf:'mysql',
					tsdoper:'query',
					datatype:'xml',
					tsdpk:'dbsql_authorizelog.query',
					tsdpkpagesql:'dbsql_authorizelog.querypage'
			});
		}
		
		/**
		 * 刷新jqGrid表格
		 * @param
		 * @return
		 */
		function refresh(){
			//拼接动态条件
			var urlstr = tsd.buildParams({
							packgname:'service',
							clsname:'ExecuteSql',
							method:'exeSqlData',
							ds:'tsdBilling',
							tsdcf:'mysql',
							tsdoper:'query',
							datatype:'xml',
							tsdpk:'dbsql_authorizelog.query',
							tsdpkpagesql:'dbsql_authorizelog.querypage'
			});
			var username = tsd.encodeURIComponent($("#username").val());
			
			urlstr +="&fusearchsql="+encodeURIComponent("( 1=1 AND USERNAME LIKE \'%"+$("#username").val()+"\%') ");	
		
			//刷新表格
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
		}
		
		</script>
  </head>
  <body>
		<!-- 用户操作导航-->
		<div id="navBar">
			<div id="navBar1" style="float: left;"><img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" /> 您当前所在的位置 :用户资料查询&nbsp;&nbsp;&#62;&#62;&#62;&nbsp;&nbsp;用户认证日志查询</div>
			<div id="d2back" style="float: right;margin-right: 40px"><a href="javascript:void(0);"onclick="parent.history.back(); return false;">返 回</a></div>
		</div>
		<!-- 用户操作标题以及放一些快捷按钮-->	
		<div id="buttons">
			<label for="username">用户登录名：</label>
			<input id="username" type="text" class="inputbox" />
			<button type="button" onclick="refresh();">查询</button>
		</div>
	    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
  </body>
</html>