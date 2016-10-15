<%----------------------------------------
	name: XQselDeviceType.jsp
	author: youhongyu
	version: 1.0, 2011-9-27
	description: 小区号线设备类型的选择
	modify:
---------------------------------------------%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String NodeField = request.getParameter("NodeField");
	String mokuaiju = request.getParameter("mkj");
	String deviceName = request.getParameter("deviceName");
	String deviceField = request.getParameter("deviceField");
	
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");	
	String departname = (String)session.getAttribute("departname");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>The-Device-Type-Manager</title>
		
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		
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
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		
		<link rel="stylesheet" href="plug-in/jquery/zTree/demoStyle/demo.css" type="text/css"/>
		<link rel="stylesheet" href="plug-in/jquery/zTree/zTreeStyle/zTreeStyle.css" type="text/css" />
  		<script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree-2.6.js" language="javascript"></script>
		<script type="text/javascript" src="plug-in/jquery/zTree/demoTools.js"></script>
		<script src="script/telephone/linemanagement/XQselDeviceType.js" type="text/javascript"></script>	
<script type="text/javascript">

	 
	/**
	* 页面初始化
	* @param 
	* @return 
	*/
	jQuery(document).ready(function () {
		/**
			//获取生成树的节点信息
			var fieldfalg = getTreeJson();
	 		if(fieldfalg=='F'){ return false; }
			showDeviceTree();//展示树
		*/
		var NodeField= $("#NodeField").val();
		var mokuaiju= $("#mokuaiju").val();
		var deviceName= $("#deviceName").val();
		var deviceField= $("#deviceField").val();
		//alert("=====NodeField:"+NodeField+"====mokuaiju:"+mokuaiju+"=====deviceName:"+deviceName+"=====deviceField:"+deviceField);
		showJQgrid();//显示jqgridm面板
		//reloadJQgrid(1);
		//var NodeField = $('#NodeField').val();//设备别名
		//var mkj = '< %=request.getParameter("mkj") %>';//设备所在模块局
		
	});

		
	/**
	* 显示三级设备的可用和不可用设备的数量
	* @param DeviceNo：设备
	* @return 返回字符串，显示设备可用和不可用个数
	*/
	function getDeviceMx(DeviceNo){
		var anum = getTheNum('NodeState',DeviceNo);
		var bnum = getTheNum('NodeState!',DeviceNo);		
		var NodeName = '<font color="green">可用个数：'+anum+'个/<font color="red">不可用个数：' + bnum + '个</font>';		
		return NodeName;
	}
		
	
</script>
<style type="text/css">
.ahref a {
	cursor: hand;
	text-decoration: none;
}
.ahref a:hover {
	color: #FF8C00;
}
</style>

<style type="text/css">		
	#left_k{width:0px;height:0px;float:left;clear:both;overflow-x:scroll;border:1px solid #99ccff;}	
	#right_k{width:698px;height:360px;float:left;overflow-x:hidden;border:1px solid #99ccff;}		
</style>
  </head>
  
  <body>
  	<div id="navBar" style="width: 700px">
			<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px"/>
			<fmt:message key="global.location" />
			:
			号线管理
			>>>
			选择设备
	</div>
    <div id="left_k">    	
	</div>
	<div id="right_k">
		<div style="height: 35px;padding-top: 7px;">
			<!-- 
			<label>设备类型：</label><input type="text" id="" style="width: 75px;"/>
			<label>设备名称：</label><input type="text" id="" style="width: 75px;"/>
			-->
			<label>设备名称：</label><input type="text" id="deviceNameQ" nodeid="" nodename="" pnodename="" style="width: 150px;"/>
			<input type="button" value="模糊查询" onclick="reloadJQgrid(2);"/>
		</div>
		<div>			
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
		<div id="ri_grid"></div>
	</div>  

	
			
	
	<!-- 隐藏域 -->
	<input type="hidden" id="basePath" value="<%=basePath%>" />
	<input type="hidden" id="NodeField" value="<%=NodeField%>" />
	<input type="hidden" id="mokuaiju" value="<%=mokuaiju %>" />
	<input type="hidden" id="deviceName" value="<%=deviceName %>" />
	<input type="hidden" id="deviceField" value="<%=deviceField %>" />
	
	<input type="hidden" id="jsoninfo" />
	<input type="hidden" id="ziduansF" />
	
	
	
	<input type="hidden" id="DeviceType_line"/>
	<input type="hidden" id="thefree"/>
	<input type="hidden" id="theradio"/>
	<input type="hidden" id="operationtips"
					value="<fmt:message key="global.operationtips"/>" />
  </body>
</html>
