<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>WEB查询系统--电话查询</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="generator" content="Microsoft Visual Studio .NET 7.1" />
<meta name="code_language" content="C#" />
<meta name="vs_defaultClientScript" content="JavaScript" />
<meta name="vs_targetSchema"
	content="http://schemas.microsoft.com/intellisense/ie5" />
<link rel="shortcut icon" />
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
</head>
<body>
	<form name="form1" method="post" action="TelManage.jsp" id="form1">
		<div>
			<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
				value="/wEPDwUJMzc0OTAxODg5ZGSNEbgd+dqxuL+aMJtzuoL13b40jw==" />
		</div>

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
		<table style="height: 100%; background-color: #4791c5" width="100%"
			border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 560px;" valign="top">
					<div>
						<span id="MenuControl1"><table width="160" height="100%"
								border=0 cellpadding=0 cellspacing=0 align="center"
								background-color=Color[Empty]>  <tr> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td> <td valign="top"><table>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelDetail.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 电话详单</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelFee.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 电话话费</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelPassword.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 修改密码</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td> </table></td> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td></tr></table>
			</span></div>
				</td>	
				
				<td style="height:560px;" valign="top">
				   <div align="center">
						<table width="840" border="0" cellpadding="0" cellspacing="0" style="background-color:#deebf5;background-image:url(images/ibg.jpg); background-repeat:no-repeat">
							<tr>
								<td style="width: 160px"></td>
								<td style="height:460px;PADDING-TOP:30pt; width: 840px; text-align: left;" valign="top">
			<div align="left">
				<table style="width:100%; background:83acd6; filter:alpha(opacity=80)" bgcolor="#83acd6"  cellpadding="1" cellspacing="1" >
					<tr align="left" valign="middle"  style="border:1pt; border-color:#6699cc; height:30px; width:90%; ">
						<td style="width:5%;" align="center" bgcolor="#ccccff" >
							序号</td>
						<td style="width:15%;" align="center" bgcolor="#ccccff" >
							功能</td>
						<td style="width:80%;" align="center" bgcolor="#ccccff" >
							操作说明
						</td>
					</tr>
			   
					<tr align="left" valign="middle"  style="border:1pt; border-color:#6699cc; height:40px; width:90%; ">
						<td style="width:5%;" align="center" bgcolor="#deebf5" >
							一</td>
						<td style="width:15%;" align="center" bgcolor="#deebf5" >
							电话详单</td>
						<td style="width:80%;" align="left" bgcolor="#deebf5" >
							选择开始日期和结束日期，可以查询该时间段内电话全部明细话单。
						</td>
					</tr>
					
					<tr align="left" valign="middle"  style="border:1pt; border-color:#6699cc; height:40px; width:90%; ">
						<td style="width:5%;" align="center" bgcolor="#deebf5" >
							二</td>
						<td style="width:15%;" align="center" bgcolor="#deebf5" >
							电话话费</td>
						<td style="width:80%;" align="left" bgcolor="#deebf5" >
							选择开始月份和结束月份，可以查询该时间段内电话每个月的汇总话费。
						</td>
					</tr>                                         

					<tr align="left" valign="middle"  style="border:1pt; border-color:#6699cc; height:40px; width:90%; ">
						<td style="width:5%;" align="center" bgcolor="#deebf5" >
							三</td>
						<td style="width:15%;" align="center" bgcolor="#deebf5" >
							修改密码</td>
						<td style="width:80%;" align="left" bgcolor="#deebf5" >
							为您提供密码变更服务，个人用户输入电话号码、合同号用户输入帐单电话号码，按照提示自行更改密码。
						</td>
					</tr>
				</table>
			
			</div>
		  </td>
								<td style="width: 160px"></td>    
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>

	</form>
	<iframe id="iframe_data" name="iframe_data" width="0" height="0"
		style="DISPLAY: none" />
</body>
</html>