<%----------------------------------------
	name: searchMod.jsp
	author: youhongyu
	version: 1.0, 2009-11-26
	description: 高级查询模板
	modify: 
    	2010-9-25  oracle 移植
		2010-11-05 youhongyu 添加注释功能	
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
	String tabpage = request.getParameter("tabpage");
	if ("undefined".equalsIgnoreCase(tabpage)) {
		tabpage = "1";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Template Search 查询模板</title>
		<!-- jqgrid css -->
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<!-- jquery -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<!-- jqgrid -->
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<!-- company -->
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>


		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>

		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />


		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/revenue.js"></script>
		<script type="text/javascript" src="script/public/infotest.js"></script>

		<!-- tree -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />

		<!-- 分项卡 -->
		<link rel="stylesheet"
			href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css"
			media="print, projection, screen" />
		<link rel="stylesheet"
			href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css"
			media="projection, screen" />
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js"
			type="text/javascript"></script>
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		
		<!-- 本月对应的js脚本文件 -->
		<script type="text/javascript" src="script/pubMode/searchMod.js"></script>
		<link rel="stylesheet" type="text/css" href="style/css/pubMode/searchMod.css" />
		
		<script type="text/javascript">
			/**
			* 页面初始化
			* @param 
			* @return 
			*/
			jQuery(document).ready(function () {	
					//选项卡插件导入
					$("#tabs").tabs();
					tabStatus=1;//默认选中第一个分项面板						
					ready1();//	第一个分项面板jqgrid 显示
			});	
		</script>
	</head>

	<body>
		<div style="width: 560px;">			
			<!-- 用户操作导航-->
			<div id="navBar1">
				<table width="100%" height="26px">
					<tr>
						<td width="80%" valign="middle">
							<div id="navBar" style="float: left">
								<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
								模板查询
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="width: 560px;">
			<div style="width: 560px; height: 300px; float: left;">
				<!-- 用户操作标题以及放一些快捷按钮-->
				<div id="buttons">
					<button type="button" id="order1" onclick="openModifyD();">
						<!--组合排序-->
						维护模板
					</button>
				</div>
				
				
				<!-- Tabs -->
				<div id="tabs">
					<ul>
						<li>
							<a href="#gridd" onclick="tabsChg(1)"><span>个人模板</span>
							</a>
						</li>
						<li>
							<a href="#gridd" onclick="tabsChg(2)"><span>其它模板</span>
							</a>
						</li>
					</ul>
					<div id="gridd">
						<table id="editgrid" class="scroll" cellpadding="0"
							cellspacing="0"></table>
						<div id="pagered" class="scroll"
							style="text-align: left; width: 395px;"></div>
					</div>
				</div>
				<!-- 用户操作标题以及放一些快捷按钮-->
				<div id="buttons">
					<button type="button" id="order2" onclick="openModifyD();">
						<!--组合排序-->
						维护模板
					</button>
				</div>
				
				<!-- 显示查询树 开始 -->
				<div
				style="display: none; width: 400px; height: 300px; border: 1px thick #ff0000;"
				id='querytree'>
				<div id="input-Unit">
					<div class="title">
						<h3></h3>
						<div class="lguanbi" onclick="javascript:$('#Qclose').click();">
							<a href="#" onclick="javascript:$('#FMclose').click();"><fmt:message
									key="global.close" />
							</a>
						</div>
					</div>
					<div id="treediv"
						style="height: 230px; overflow: scroll; text-align: left; margin-left: 10px;">
					</div>
					<div id="buttons">
						<button type="submit" id="query" onclick="modquery();">
							<!--  查询 -->
							<fmt:message key="global.query" />
						</button>
						<button type="button" id="Qclose">
							<!-- 关闭 -->
							<fmt:message key="global.close" />
						</button>
					</div>
				</div>
			</div>
			<!-- 显示查询树 结束 -->
			
			<div style="display: none">
					<!-- 高级查询隐藏域 -->					
					<input type="hidden" id="queryName" name="queryName" value="" />
					<input type="hidden" id="fusearchsql" name="fusearchsql" value=""/>					
			
					<input type="hidden" id="imenuid" value="<%=imenuid%>" />
					<input type="hidden" id="zid" value="<%=zid%>" />
					<%
						if (!languageType.equals("en")) {
							languageType = "zh";
						}
					%>
					<input type="hidden" id="languageType" value="<%=languageType%>" />

					<input type="hidden" id="addinfo"
						value="<fmt:message key="global.add"/>" />
					<input type="hidden" id="deleteinfo"
						value="<fmt:message key="global.delete"/>" />
					<input type="hidden" id="editinfo"
						value="<fmt:message key="global.edit"/>" />
					<input type="hidden" id="queryinfo"
						value="<fmt:message key="global.query"/>" />

					<input type="hidden" id="operation"
						value="<fmt:message key="global.operation"/>" />
					<input type="hidden" id="operationtips"
						value="<fmt:message key="global.operationtips"/>" />
					<input type="hidden" id="successful"
						value="<fmt:message key="global.successful"/>" />
					<input type="hidden" id="deleteinformation"
						value="<fmt:message key="global.deleteinformation"/>" />
					<input type="hidden" id="worninfo"
						value="<fmt:message key="zhji.zjjxonly"/>" />
					<input type="hidden" id="worntips"
						value="<fmt:message key="powergroup.worntips"/>" />
					<input type="hidden" id="deletepower"
						value="<fmt:message key="global.deleteright"/>" />
					<input type="hidden" id="editpower"
						value="<fmt:message key="global.editright"/>" />

					<!-- 权限隐藏域 -->				
					<input type="hidden" id="addright" />
					<input type="hidden" id="deleteright" />
					<input type="hidden" id="editright" />
					<input type="hidden" id="editfields" />
					<input type="hidden" id="delBright" />
					<input type="hidden" id="editBright" />
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />
					
					<!-- 用于写入日志 -->
					<input type="hidden" id="userloginip"
						value="<%=Log.getIpAddr(request)%>" />
					<input type="hidden" id="userloginid"
						value="<%=session.getAttribute("userid")%>" />
					<input type="hidden" id="thislogtime"
						value="<%=Log.getThisTime()%>" />
					<!-- 修改时保存原来数据的隐藏域 -->
					<input type="hidden" id="logoldstr" />
					<input type="hidden" id="useridd" value="<%=userid%>" />
					<input type="hidden" id="tabpage" value="<%=tabpage%>" />

					<!-- 打印报表 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
					<input name="params" id="params" type="hidden" />

					<!-- 提交查询隐藏域 -->
					<input type='hidden' id='qidd' />
			</div>
		</div>			
	</body>
</html>
