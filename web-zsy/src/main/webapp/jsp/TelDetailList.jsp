<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head id="Head1">
<title>WEB查询系统--电话查询--电话详单--列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="generator" content="Microsoft Visual Studio .NET 7.1" />
<meta name="code_language" content="C#" />
<meta name="vs_defaultClientScript" content="JavaScript" />
<meta name="vs_targetSchema"
	content="http://schemas.microsoft.com/intellisense/ie5" />
<link href="images/calWebStyles_V40.css" rel="stylesheet" />
<link href="images/hotmail___1000000001.css" rel="stylesheet" />
<script language="javascript" charset="gb2312" type="text/javascript"
	src="js/dialog.js"></script>
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
	href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
	rel="stylesheet" type="text/css" />
</head>
<body>
	<form name="form2" method="post"
		action="TelDetailList.jsp?Tel=573&amp;Begin=2016-10-1&amp;End=2016-11-1&amp;Kind=hdmx&amp;Bjhm=&amp;Type=all"
		id="form2">
		<div>
			<input type="hidden" name="__EVENTTARGET" id="__EVENTTARGET" value="" />
			<input type="hidden" name="__EVENTARGUMENT" id="__EVENTARGUMENT"
				value="" /> <input type="hidden" name="__VIEWSTATE"
				id="__VIEWSTATE"
				value="/wEPDwUIMjg4MjIxNjEPZBYCAgMPZBYIAgUPDxYCHgRUZXh0BUogIOeUteivnVsgNTczIF3vvJvlvIDlp4vml7bpl7RbIDIwMTYtMTAtMSBd77yb57uT5p2f5pe26Ze0WyAyMDE2LTExLTEgXSAgIGRkAgsPPCsACwEADxYIHghEYXRhS2V5cxYAHgtfIUl0ZW1Db3VudGYeCVBhZ2VDb3VudAIBHhVfIURhdGFTb3VyY2VJdGVtQ291bnRmZGQCFQ8PFgIfAAUn5YWxMOadoeiusOW9le+8jOWFsTHpobXvvIzlvZPliY3nrKwx6aG1ZGQCFw8QZBAVAQExFQEBMRQrAwFnZGQYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgEFCWJ0blJlcG9ydBvxy6DGG4KM2cCtWZJZw0pqC11O" />
		</div>

		<script type="text/javascript"> 
<!--
var theForm = document.forms['form2'];
if (!theForm) {
theForm = document.form2;
}
function __doPostBack(eventTarget, eventArgument) {
if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
theForm.__EVENTTARGET.value = eventTarget;
theForm.__EVENTARGUMENT.value = eventArgument;
theForm.submit();
}
}
// -->
</script>


		<table cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="40">
					<table cellSpacing=0 cellPadding=0 width="100%" bgcolor=#336699
						border=0>
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
													onClick="javascript:location.href='index.jsp';">&nbsp;&nbsp;&nbsp;
													<a class=E tabIndex=3 href="index.jsp">首页</a>&nbsp;&nbsp;&nbsp;
												</td>
												<td style=""><img src="images/tab.separator.on.l.gif"></td>
												<td noWrap background="images/tab.bg.on.gif"
													style="CURSOR: hand;"
													onClick="javascript:location.href='TelManage.jsp';">&nbsp;&nbsp;&nbsp;
													<a class=E tabIndex=3 href="TelManage.jsp">电话查询</a>&nbsp;&nbsp;&nbsp;
												</td>
												<td style=""><img src="images/tab.separator.on.l.gif"></td>
												<td noWrap background="images/tab.bg.off.gif"
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
											<TR align=middle bgcolor=#4791c5>
												<TD id=headerTitleInlineCell style="PADDING-LEFT: 10px"
													vAlign=center align=left width="50%" height=22><FONT
													class=G>电话号码［ 573 ］欢迎登录
														<td align="right" style="width: 100%;"><img id="img1"
															alt="退出" src="images/a_exit.gif" style="cursor: pointer;"
															onclick="javascript:parent.window.location.replace(parent.window.location.href='TelLogin.jsp');" />
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

		<table style="background-color: #4791c5" width="100%" border="0"
			cellpadding="0" cellspacing="0">
			<tr align="center">
				<td style="height: 500px;" valign="top">
					<div align="center">
						<span id="MenuControl1"><table width="160" height="100%"
								border=0 cellpadding=0 cellspacing=0 align="center"
								background-color=Color[Empty]>  <tr> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td> <td valign="top"><table>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="Q" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelDetail.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> <strong>电话详单</strong></td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelFee.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 电话话费</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelPassword.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 修改密码</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td> </table></td> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td></tr></table>
			</span>
</div>
</td>	
<td valign="top" style="height: 500px">
<div align="center">
<table cellspacing="0" cellpadding="0" border="0"  style="height:500px;width:840px; ">
<tr align="center">
<td  width="100%" bgcolor="#deebf5" align="center" >

<div align="center" >
	<table  cellspacing="0" cellpadding="0" width="800" align="center" bgcolor="lightsteelblue"	border="0">
		<tr>
			<td align=center style="height: 23px">
				<span id="lblStat">  电话[ 573 ]；开始时间[ 2016-10-1 ]；结束时间[ 2016-11-1 ]   </span>&nbsp;<span id="lblSum"></span>
			</td >
			<td style="width:120px; height: 23px;" align="right" >
				<input type="image" name="btnReport" id="btnReport" src="images/a_report.gif" style="border-width:0px;" />
				</td>
		</tr>
	</table>
	
	<table  cellspacing="0" cellpadding="0" width="800" align="center" bgcolor="AliceBlue"	border="0" height="450">
	<tr valign="top"><td height="450" valign="top">
	
	<table cellspacing="0" cellpadding="2" rules="all" border="1" id="DataGrid1" style="color:Black;background-color:White;border-color:PowderBlue;border-width:1px;border-style:Solid;width:800px;border-collapse:collapse;">
<tr style="background-color:AliceBlue;border-style:Solid;height:20px;">
<td>#</td><td><a href="javascript:__doPostBack('DataGrid1$ctl02$ctl00','')" style="color:Black;">被叫号码</a></td><td><a href="javascript:__doPostBack('DataGrid1$ctl02$ctl01','')" style="color:Black;">话始时间</a></td><td><a href="javascript:__doPostBack('DataGrid1$ctl02$ctl02','')" style="color:Black;">通话时长</a></td><td><a href="javascript:__doPostBack('DataGrid1$ctl02$ctl03','')" style="color:Black;">通话类型</a></td><td><a href="javascript:__doPostBack('DataGrid1$ctl02$ctl04','')" style="color:Black;">基本话费</a></td><td><a href="javascript:__doPostBack('DataGrid1$ctl02$ctl05','')" style="color:Black;">服务费</a></td><td><a href="javascript:__doPostBack('DataGrid1$ctl02$ctl06','')" style="color:Black;">话费合计</a></td>
</tr>
</table>
	</td></tr></table>
	
	<table  cellspacing="0" cellpadding="0" width="800" bgcolor="lightsteelblue" border="0">
		<tr >
			<td style="height: 20px" align=center>
				<a id="btnFirst" href="javascript:__doPostBack('btnFirst','')" style="display:inline-block;height:18px;">[ 首页 ]</a>
				<a id="btnPrev" href="javascript:__doPostBack('btnPrev','')" style="display:inline-block;height:18px;">[上一页]</a>
				<a id="btnNext" href="javascript:__doPostBack('btnNext','')" style="display:inline-block;height:18px;">[下一页]</a>
				<a id="btnLast" href="javascript:__doPostBack('btnLast','')" style="display:inline-block;height:18px;">[ 末页 ]</a>
				<span id="lblPage" style="display:inline-block;background-color:LightSteelBlue;height:18px;">共0条记录，共1页，当前第1页</span>
				<select name="listPage" id="listPage" style="width:48px;">
<option selected="selected" value="1">1</option>

</select>
				<input type="submit" name="btnGo" value="GO" id="btnGo" />
			 </td>
			 
		</tr>
	</table>
</div>									
</td>
<td width="240" bgcolor="#4791c5" ></td>
</tr>
</table>

</div>
</td>

</tr>
		</table>




		<div>

			<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION"
				value="/wEWDwLMrP7KCALo442vBQKAg4OnDwKBg4OnDwKCg4OnDwKDg4OnDwL8goOnDwL9goOnDwL+goOnDwKO+N3hDwLWs7u7BwK14fOOCgKx4bePCQK9r9qICQKBk/m1C0fDVIPStwXgWXjsfiFmDa9Hfd2e" />
		</div>
	</form>
</body>
</html>

