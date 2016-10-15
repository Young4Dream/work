<%----------------------------------------
	name: syswarn.jsp
	author: 孙琳
	version: 1.0, 2010-11-04
	description: 系统告警
	modify: 
	   2010-11-18  chenze  修改扣费校验值undefined
	   2010-11-26  chenze  针对新的扣费过程修改调用方式
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");	
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
    <base href="<%=basePath%>" />
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
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />

		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/images/public/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
	h2{font-size:18px;} 
	#container{padding-left:15px;margin-top:20px;}
	.winfo{font-size:14px;line-height:14px;}
	.winfo a{font-size:14px;line-height:14px;}
	hr{border:0;height:0px;border-top:1px dashed #cfcfcf;}
	</style>
	<script type="text/javascript">
	/**
	 * 初始化数据
	 * @param 无参数
	 * @return 无返回值
	 */
	$(function(){
		$("#navBar").append(genNavv());
		gobackInNavbar("navBar");
		
		checkKDKF();
		checkCKRK();
		checkCCTC();
	});
	/**
	 * FCK操作
	 * @param 无参数
	 * @return 无返回值
	 */
	function checkKDKF()
	{
		var result = fetchMultiArrayValue("syswarn.info",0,"");
		if(result[0]=='undefined' || result[0][0]=='undefined')
		{
		
		}
		else if(result[0][0]=="OK")
		{
			$("#kdkfinfo").html("<img src=\"style/images/public/syswarn-ok.gif\" align=\"middle\" />&nbsp;&nbsp;宽带扣费系统当前运行正常，上次运行时间：" + result[0][1]);
		}
		else
		{
			$("#kdkfinfo").html("<img src=\"style/images/public/syswarn-warn.gif\" align=\"middle\" />&nbsp;&nbsp;扣费异常，上次运行时间：" + result[0][1] + ";<button class=\"tsdbtn\" onclick=\"kf()\">立即重算</button>");
		}
	}
	/**
	 * 调用扣费过程
	 * @param 无参数
	 * @return 无返回值
	 */
	function kf()
	{
		executeNoQueryProc("Kdmhz.Hz",0,"Flag=3");
		alert("成功调用扣费过程");
		checkKDKF();
	}
	/**
	 * 检测宽带用户数据完整性
	 * @param 无参数
	 * @return 无返回值
	 */
	function checkCKRK()
	{
		var result = fetchSingleValue("syswarn.infocheck",0,"");
		if(result==undefined || result=="")
		{
		
		}
		else if(result=="OK")
		{
			$("#kdradcheckinfo").html("<img src=\"style/images/public/syswarn-ok.gif\" align=\"absmiddle\" />&nbsp;&nbsp;宽带用户账号数据完整");
		}
		else
		{
			$("#kdradcheckinfo").html("<img src=\"style/images/public/syswarn-warn.gif\" align=\"absmiddle\" />&nbsp;&nbsp;<a href=\"javascript:printThisReport('commonreport/validate_radcheck','')\">" + result + "</a>");
		}
	}
	
	/**
	 * 检测宽带用户数据完整性
	 * @param 无参数
	 * @return 无返回值
	 */
	function checkCCTC()
	{
		var result = fetchSingleValue("syswarn.infotc",7,"");
		if(result==undefined || result=="")
		{
		
		}
		else if(result=="OK")
		{
			$("#kdtcinfo").html("<img src=\"style/images/public/syswarn-ok.gif\" align=\"absmiddle\" />&nbsp;&nbsp;宽带套餐用户提速正常");
		}
		else
		{
			$("#kdtcinfo").html("<img src=\"style/images/public/syswarn-warn.gif\" align=\"absmiddle\" />&nbsp;&nbsp;<a href=\"javascript:printThisReport('commonreport/validate_tcyhspeed_gyx','')\">" + result + "</a>");
		}
	}
	</script>

  </head>
  
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
	<div id="container">
		<h2>宽带扣费</h2><hr />
		<div id="kdkfinfo" class="winfo"></div><hr />
		<br />
		<h2>宽带账号数据完整性</h2><hr />
		<div id="kdradcheckinfo" class="winfo"></div><hr />
		<br />
		<h2>宽带带宽提速</h2><hr />
		<div id="kdtcinfo" class="winfo"></div><hr />
	</div>
	
	<input type="hidden" id="thisbasePath" name="thisbasePath" value="<%=basePath %>"  />
  </body>
</html>
