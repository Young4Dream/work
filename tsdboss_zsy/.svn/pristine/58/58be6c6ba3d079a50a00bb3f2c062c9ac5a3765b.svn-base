<%----------------------------------------
	name: NuserManager.jsp
	author: chenze
	version: 1.0, 2010-12-28
	description: 
	modify: 
		
---------------------------------------------%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>工号管理 - IP编辑</title>
    <!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="style/js/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script type="text/javascript" src="script/public/infotest.js"></script>
	<!-- tab滑动门 需要导入的样式表 *注意路径-->
	<script type="text/javascript" src="css/tree/dtree.js"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 时间控件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<!-- 导入js文件结束 -->
	<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />

	<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
	<link rel="stylesheet" type="text/css" href="plug-in/MultiSelect/jquery.multiSelect.css" />
	<script type="text/javascript" src="plug-in/MultiSelect/jquery.multiSelect.js"></script>
	<style type="text/css">
	h7{font-size:12px;line-height:14px;}
	#iptables{width:98%;margin-left:auto;margin-right:auto;}
	#iptables td{line-height:26px;border:1px solid #CDD;}
	</style>
	<script type="text/javascript">
	/**
	 *  页面加载时调用
	 *  param  
	 *  Return null
	 */
	$(function(){
		var ywarea = "<%=request.getParameter("ywarea") %>";
		var charea = "<%=request.getParameter("charea") %>";
		var ipsss = window.dialogArguments.transferCurrentIP();//"<%=request.getParameter("ips") %>";
		ywarea = "'" + ywarea.replace(/,/g,"','") + "'";
		charea = "'" + charea.replace(/,/g,"','") + "'";
		var allip = fetchMultiValue("NuserManager.getIP",6,"&ywarea=" + encodeURIComponent(ywarea) + "&charea=" + encodeURIComponent(charea));
		if(allip[0]!=undefined)
		{
			var tabHtml = "";
			var ii = 0;
			for(ii = 0;ii<allip.length;ii++)
			{
				if((ii+1)%5==1)
					tabHtml += "</tr><tr>";
					
				tabHtml += "<td><input type=\"checkbox\" id=\"chk_" + allip[ii].replace(/\./g,"_") + "\" value=\"" + allip[ii] + "\" /><label for=\"chk_" + allip[ii].replace(/\./g,"_") + "\">" + allip[ii] + "<label></td>";				
			}
			if(ii%5!=0)
			{
				var kk = ii%5;
				while(kk<5)
				{
					tabHtml += "<td></td>";
					kk++;
				}
				tabHtml += "</tr>";
			}
			tabHtml = tabHtml.replace("</tr>","");
						
			$("#iptables").html(tabHtml);
			
			if(ipsss!="")
			{
				var ipsa = [];
				if(ipsss.indexOf("~")>0)
					ipsa = ipsss.split("~");
				else
					ipsa = ipsa.push(ipsss);
				
				for(var ki=0;ki<ipsa.length;ki++)
				{
					$("#chk_" + ipsa[ki].replace(/\./g,"_")).attr("checked","checked");
				}
			}
		}
	});
	/**
	 *  获取选中的IP地址并返回给主页面
	 *  param  
	 *  Return null
	 */
	function getCheckedIP()
	{
		var ips = "";
		$(":checkbox:checked").each(function(){
			ips += "," + $(this).val();
		});
		ips = ips.replace(",","");
		window.dialogArguments.setIPDefine(ips);
		window.close();
	}
	/**
	 *  反选
	 *  param  
	 *  Return null
	 */
	function reverseCheck()
	{
		$(":checked").attr("chkflag","chkflag");
		$(":checkbox").attr("checked","checked");
		$(":checkbox[chkflag]").removeAttr("checked").removeAttr("chkflag");
	}
	</script>
  </head>
  
  <body>
    <h4>业务区域：</h4><h7><%=request.getParameter("ywarea") %></h7>
    <h4>营业区域：</h4><h7><%=request.getParameter("charea") %></h7> <br />
    <table id="iptables">
    </table>
    <table width="98%">
    	<tr>
    		<td align="center">
    			<button class="tsdbutton" onclick="javascript:$(':checkbox').attr('checked','checked')">全选</button>
    			<button class="tsdbutton" onclick="reverseCheck()">反选</button>
    			<button class="tsdbutton" onclick="getCheckedIP()">确定</button>
    			<button class="tsdbutton" onclick="javascript:window.close()">关闭</button>
    		</td>
   		</tr>
    </table>
  </body>
</html>
