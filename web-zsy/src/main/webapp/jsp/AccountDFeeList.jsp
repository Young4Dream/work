<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>WEB查询系统--合同号查询--合同号话费明细--列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="images/calWebStyles_V40.css" rel="stylesheet" />
<link href="images/hotmail___1000000001.css" rel="stylesheet" />
<script language="javascript" charset="gb2312" type="text/javascript" src="js/dialog.js"></script>
<style type="text/css">
	.css0002 {
		FONT-SIZE: 10.5pt;
		COLOR: #fff
	}
	
	.css0025 {
		COLOR: #fff
	}
	
	.css0029 {
		COLOR: #fff
	}
	
	.css0059 {
		COLOR: #336699
	}
	
	.css0070 {
		COLOR: #336699
	}
	
	.css0086 {
		BORDER-RIGHT: #336699 1px solid;
		BORDER-TOP: #336699 1px solid;
		BORDER-LEFT: #336699 1px solid;
		BORDER-BOTTOM: #336699 1px solid
	}
	
	.css0086 {
		BORDER-TOP-WIDTH: 2px;
		BORDER-LEFT-WIDTH: 2px;
		BORDER-BOTTOM-WIDTH: 2px;
		BORDER-RIGHT-WIDTH: 2px
	}
	
	.css0144 {
		BACKGROUND-COLOR: #336699
	}
	
	.css0145 {
		BORDER-RIGHT: #deebf5 1px solid;
		BORDER-TOP: #deebf5 1px solid;
		BORDER-LEFT: #deebf5 1px solid;
		BORDER-BOTTOM: #deebf5 1px solid;
		backgrount-COLOR: #fff
	}
	
	.css0145 {
		BACKGROUND-COLOR: #deebf5
	}
	
	.css0146 {
		BACKGROUND-COLOR: #deebf5
	}
	
	.css0147 {
		BACKGROUND-COLOR: #336699
	}
	
	.css0148 {
		COLOR: #336699
	}
	
	.css0150 {
		COLOR: #336699
	}
	
	.css0175 {
		COLOR: #fff
	}
	
	.css0875 {
		COLOR: #fff
	}
</style>
<link
	href="css/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<form name="form2" method="post"
		action="AccountDFeeList.jsp?Account=573&amp;Begin=201611&amp;End=201611"
		id="form2">
		<div>
			<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
			<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT" value="" /> 
			<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
				value="/wEPDwUKMTQ2ODc3NjM3Nw9kFgICAw9kFggCBQ8PFgIeBFRleHQFRyAg5ZCI5ZCM5Y+3WyA1NzMgXe+8m+W8gOWni+aciOS7vVsgMjAxNjExIF3vvJvnu5PmnZ/mnIjku71bIDIwMTYxMSBdICAgZGQCCw88KwALAQAPFggeCERhdGFLZXlzFgAeC18hSXRlbUNvdW50Zh4JUGFnZUNvdW50AgEeFV8hRGF0YVNvdXJjZUl0ZW1Db3VudGZkZAIVDw8WAh8ABSflhbEw5p2h6K6w5b2V77yM5YWxMemhte+8jOW9k+WJjeesrDHpobVkZAIXDxBkEBUBATEVAQExFCsDAWdkZBgBBR5fX0NvbnRyb2xzUmVxdWlyZVBvc3RCYWNrS2V5X18WAQUJYnRuUmVwb3J0tmktClLU+fWqYXWvSGI1kMNc8Io=" />
		</div>
<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr>
	<td height="40">
		<table cellSpacing=0 cellPadding=0 width="100%" bgcolor=#336699 border=0>
<tbody>
<tr>
	<td vAlign=top><table cellSpacing=0 cellPadding=0
			width="100%" border=0>
			<tbody>
				<tr>
					<TD width="180" rowSpan=2 background="images/tab.bg.dln.gif"><IMG
						src="images/Logo.jpg" width=180 border=0></TD>
					<TD rowSpan=2><IMG src="images/tab.slide.hm.li.gif"></TD>
					<TD colSpan=12 height=13></TD>
				</tr>
				<tr>
					<TD><IMG src="images/tab.separator.off.gif"></TD>
					<td noWrap background="images/tab.bg.off.gif"
						style="CURSOR: hand;"
onClick="javascript:location.href='Index.jsp';">&nbsp;&nbsp;&nbsp;
	<a class=E tabIndex=3 href="Index.jsp">首页</a>&nbsp;&nbsp;&nbsp;
</td>
<td style=""><img src="images/tab.separator.on.l.gif"></td>
<td noWrap background="images/tab.bg.off.gif"
	style="CURSOR: hand;"
onClick="javascript:location.href='TelManage.jsp';">&nbsp;&nbsp;&nbsp;
	<a class=E tabIndex=3 href="TelManage.jsp">电话查询</a>&nbsp;&nbsp;&nbsp;
</td>
<td style=""><img src="images/tab.separator.on.l.gif"></td>
<td noWrap background="images/tab.bg.on.gif"
	style="CURSOR: hand;"
onClick="javascript:location.href='AccountManage.jsp';">&nbsp;&nbsp;&nbsp;
	<a class=E tabIndex=3 href="AccountManage.jsp">合同号查询</a>&nbsp;&nbsp;&nbsp;
</td>
<td style=""><img src="images/tab.separator.on.l.gif"></td>
<td noWrap background="images/tab.bg.off.gif"
	style="CURSOR: hand;"
onClick="javascript:location.href='FeeShow.jsp';">&nbsp;&nbsp;&nbsp;
	<a class=E tabIndex=3 href="FeeShow.jsp">资费标准</a>&nbsp;&nbsp;&nbsp;
</td>
<td style=""><img src="images/tab.separator.end.gif"></td>
					<TD width="100%" background="images/tab.bg.sln.gif"></TD>
				</tr>
			</tbody>
		</table></td>
</tr>
<tr>
	<td vAlign=top><table id=header1 cellSpacing=0
			cellPadding=0 width="100%" border=0>
			<TBODY>
				<TR align="center" bgcolor="#4791c5">
					<TD id=headerTitleInlineCell style="PADDING-LEFT: 10px"
align="center" align=left width="50%" height=22>
<FONT class=G>合同号［ <%= session.getAttribute("hth") %> ］欢迎登录
<td align="right" style="width: 100%;">
<img id="img1" alt="退出" src="images/a_exit.gif" style="cursor: pointer;"
onclick="javascript:parent.window.location.replace(parent.window.location.href='AccountLogin.jsp');" />
	</td>
</FONT></TD>
<TD id=headerTitleInlineCell style="WIDTH: 10px" noWrap
											height=22>&nbsp;</TD>
</TR>
</TBODY>
</table></td>
</tr>
</tbody>
</table>
</td>
	</tr>
</table>
<table style="background-color: #4791c5;" width="100%" border="0"
cellpadding="0" cellspacing="0">
<tr>
	<td style="height: 500px;" valign="top">
<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><div>
<span id="MenuControl1">
				<table width="160" height="100%" border=0 cellpadding=0 cellspacing=0 align="center" background-color=Color[Brown]>  
						<tr> 
						<td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td> 
<td valign="top">
<table>  
<tr align="left" style="display:none">  	 
<td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat">
</td>  <tr align="left" style="display:none">  	 
<td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()"  onclick="javascript:location.href='AccountDetail.jsp'">
<img src="images/list.gif" width="12" height="12" align="absMiddle"> 合同号详单</td> 	
</tr>  <tr align="left" style="display:auto">  	 
<td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  
<tr align="left" style="display:auto">  	 
<td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" onclick="javascript:location.href='AccountFee.jsp'">
<img src="images/list.gif" width="12" height="12" align="absMiddle"> 合同号话费</td> 	
</tr>  
<tr align="left" style="display:auto">  	 
<td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat">
</td>  
<tr align="left" style="display:auto">  	 
<td height="40" width="160" align="left" class="Q" onmouseover="MO()" onmouseout="MU()" onclick="javascript:location.href='AccountDFee.jsp'">
<img src="images/list.gif" width="12" height="12" align="absMiddle"> 
<strong>合同号话费明细</strong></td> 	</tr>  <tr align="left" style="display:auto">  	 
<td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  
<tr align="left" style="display:auto">  	 
<td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" onclick="javascript:location.href='AccountPassword.jsp'">
<img src="images/list.gif" width="12" height="12" align="absMiddle"> 合同号修改密码</td> 	
</tr>  <tr align="left" style="display:auto">  	 
<td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat">
</td> </table></td> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat">
											</td>
											</tr>
											</table>
						</span></div>
</td>
</tr>
					</table>
				</td>

				<td valign="top" style="height: 500px">
<div align="center">
	<table cellspacing="0" cellpadding="0" border="0"
		style="height: 500px; width: 840px;">
<tr align="center">
	<td style="PADDING-TOP: 5pt;" valign="top" width="100%"
bgcolor="#deebf5" align="center">

<div align="center">
	<table cellspacing="0" cellpadding="0" width="800"
		align="center" bgcolor="lightsteelblue" border="0">
		<tr>
			<td height="20"><span id="lblStat"
				style="font-weight: bold;"> 合同号[ 573 ]；开始月份[ 201611
		]；结束月份[ 201611 ] </span>&nbsp;</td>
<td height="20" align="right"><span id="lblSum"
	style="font-weight: bold;"></span></td>
<td style="width: 120px;" align="right"><input
type="image" name="btnReport" id="btnReport"
src="images/a_report.gif" style="border-width: 0px;" /></td>
	</tr>
</table>

<table cellspacing="0" cellpadding="0" width="800"
	align="center" bgcolor="AliceBlue" border="0" height="450">
	<tr valign="top">
		<td height="450" valign="top">

			<table cellspacing="0" cellpadding="2" rules="all"
				border="1" id="DataGrid1"
				style="color: Black; background-color: White; border-color: PowderBlue; border-width: 1px; border-style: Solid; width: 800px; border-collapse: collapse;">
<tr
	style="background-color: AliceBlue; border-style: Solid; height: 20px;">
<td>#</td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl00','')"
	style="color: Black;">电话</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl01','')"
	style="color: Black;">汇总月份</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl02','')"
	style="color: Black;">月租</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl03','')"
	style="color: Black;">市话</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl04','')"
	style="color: Black;">国内长途</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl05','')"
	style="color: Black;">国际长途</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl06','')"
	style="color: Black;">IP电话</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl07','')"
	style="color: Black;">直线费</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl08','')"
	style="color: Black;">专线费</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl09','')"
	style="color: Black;">装机</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl10','')"
	style="color: Black;">移机</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl11','')"
	style="color: Black;">购机</a></td>
<td><a
	href="javascript:__doPostBack('DataGrid1$ctl02$ctl12','')"
	style="color: Black;">合计</a></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table cellspacing="0" cellpadding="0" width="800"
	bgcolor="lightsteelblue" border="0">
	<tr>
		<td style="height: 20px" align=center><a id="btnFirst"
href="javascript:__doPostBack('btnFirst','')"
style="display: inline-block; height: 18px;">[ 首页 ]</a> <a
id="btnPrev" href="javascript:__doPostBack('btnPrev','')"
style="display: inline-block; height: 18px;">[上一页]</a> <a
id="btnNext" href="javascript:__doPostBack('btnNext','')"
style="display: inline-block; height: 18px;">[下一页]</a> <a
id="btnLast" href="javascript:__doPostBack('btnLast','')"
style="display: inline-block; height: 18px;">[ 末页 ]</a> <span
id="lblPage"
style="display: inline-block; background-color: LightSteelBlue; height: 18px;">共0条记录，共1页，当前第1页</span>
<select name="listPage" id="listPage" style="width: 48px;">
					<option selected="selected" value="1">1</option>

			</select> <input type="submit" name="btnGo" value="GO" id="btnGo" />
			</td>

		</tr>
	</table>
</div> <span style="color: #000080"> </span>
							</td>
							<td width="40" bgcolor="#d6e7ef"></td>
						</tr>
					</table>

				</div>
			</td>

		</tr>
	</table>




<div>
		<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION"
			value="/wEWFQLtsqPeAwLo442vBQKAg4OnDwKBg4OnDwKCg4OnDwKDg4OnDwL8goOnDwL9goOnDwL+goOnDwL/goOnDwL4goOnDwL5goOnDwKAg5eCCAKBg5eCCAKCg5eCCAKO+N3hDwLWs7u7BwK14fOOCgKx4bePCQK9r9qICQKBk/m1C9m9GIaIdV3cvBByul8moC3MYNMb" />
	</div>
</form>
</body>
</html>

