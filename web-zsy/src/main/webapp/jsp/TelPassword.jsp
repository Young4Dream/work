<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head id="Head1">
<title>WEB查询系统--话费查询--修改密码</title>
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
	<form name="form2" method="post" action="TelPassword.jsp" id="form2">
		<div>
			<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
				value="/wEPDwUIMjA4MDY1NTZkGAEFHl9fQ29udHJvbHNSZXF1aXJlUG9zdEJhY2tLZXlfXxYBBQVidG5PSzDygngkSCrtH1ZO0/8DovllRLqD" />
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
													class=G> </FONT></TD>
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

		<table style="height: 500px; background-color: #4791c5" width="100%"
			border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 500px;" valign="top">
					<div align="center">
						<span id="MenuControl1"><table width="160" height="100%"
								border=0 cellpadding=0 cellspacing=0 align="center"
								background-color=Color[Empty]>  <tr> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td> <td valign="top"><table>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelDetail.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 电话详单</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelFee.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 电话话费</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="Q" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelPassword.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> <strong>修改密码</strong></td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td> </table></td> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td></tr></table>
			</span>
</div>
</td>	
<td  style="height:500px" ><div align="center">
<table  width="840" border="0" cellpadding="0" cellspacing="0" style="background-color:#deebf5;background-image:url(images/ibg.jpg); background-repeat:no-repeat">
	<tr>
		<td  style="height:460px;PADDING-TOP:30pt; width: 840px;" valign="top">
			&nbsp;&nbsp;
			
			<div align="center">
				&nbsp;
				<table cellpadding="0" cellspacing="0"  >
					<tr style="height:50px;">
						<td >
					
						</td>
					</tr>
				</table>	
				<table cellpadding="0" cellspacing="0" class="css0086" style="filter:alpha(opacity=85)">
					<tr>
						<td class="css0144" style="PADDING-RIGHT:5pt; PADDING-LEFT:5pt; PADDING-BOTTOM:5pt; PADDING-TOP:5pt;background-color: #4791c5;">
							<table cellpadding="0" cellspacing="0" class="css0113">
								<tr>																
									<td  style="height: 15px; font-size:20pt;font-weight:bold;"><div align="center" style="color: white">
										&nbsp;请输入电话号码、原密码和新密码</div>
								</tr>
							</table>
						</td>
					</tr>
					
					<tr>
						<td style="PADDING-RIGHT:10pt; PADDING-LEFT:10pt; PADDING-BOTTOM:10pt; PADDING-TOP:10pt;
							background-color:#ffffff">
							<table cellpadding="0" cellspacing="4" class="css0113">
								<tr>
									<td class="css0059" align="right"><label for="txtUserId">电话号码：</label></td>
									<td valign="top" class="css0093" align="left"><input name="txtTel" type="text" id="txtTel" class="css0034" /></td>
								</tr>
								<tr  id="i0512" height="10">
									<td class="css0096" style="FONT-SIZE:1px; height: 14px;">&nbsp;</td>
									<td class="css0097" style="height: 14px">&nbsp; </td>
								</tr>
								<tr>
									<td class="css0059" align="right"><label for="txtPassword">原&nbsp;密&nbsp;码：</label></td>
									<td class="css0093" align="left"><div class="css0064"><input name="txtOld" type="password" id="txtOld" class="css0034" /></div>
									</td>
								</tr>
								<tr  id="i0513" height="10">
									<td class="css0096" style="FONT-SIZE:1px">&nbsp; </td>
									<td class="css0097">&nbsp;</td>
								</tr>															
								<tr>
									<td class="css0059" align="right"><label for="txtPassword">新&nbsp;密&nbsp;码：</label></td>
									<td class="css0093" align="left"><div class="css0064"><input name="txtNew" type="password" id="txtNew" class="css0034" /></div>
									</td>
								</tr>
								<tr  id="Tr2" height="10">
									<td class="css0096" style="FONT-SIZE:1px">&nbsp; </td>
									<td class="css0097">&nbsp;</td>
								</tr>															
								<tr>
									<td class="css0059" align="right"><label for="txtPassword">确认新密码：</label></td>
									<td class="css0093" align="left"><div class="css0064"><input name="txtNew2" type="password" id="txtNew2" class="css0034" /></div>
									</td>
								</tr>
								<tr  id="Tr1" height="10">
									<td class="css0096" style="FONT-SIZE:1px">&nbsp; </td>
									<td class="css0097">
										&nbsp;&nbsp;</td>
								</tr>														
								
							</table>
							<div/>
						</td>
					</tr>
					<tr >
						<td class="css0144" style="height:20px;PADDING-RIGHT:5pt; PADDING-LEFT:5pt; PADDING-BOTTOM:5pt; PADDING-TOP:5pt; background-color: background;">
							<table cellpadding="0" cellspacing="4" class="css0113">																														
								<tr>
									<td class="css0059" align="right" style="width: 71px"></td>
									<td class="css0093" style="width: 105px"><div align="left"><span class="css0170"><input type="image" name="btnOK" id="btnOK" src="images/a_ok.gif" style="border-width:0px;" /></span></div>																
											</td>
								</tr>
								
							</table>		
						</td>
					</tr>
				</table>
			</div>
			
			</td>
	</tr>
</table>
</div>
</td>
</tr>
		</table>


		<div>

			<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION"
				value="/wEWBgKKovmeBQKL+4qxCwKE+47GCwKL+96gBALzp9GUDQLdkpmPAcSmsrInMOvzyWERWGXZ9BvVJQzS" />
		</div>
	</form>
</body>
</html>

