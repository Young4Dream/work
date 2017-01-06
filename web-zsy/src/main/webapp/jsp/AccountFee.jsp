<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head id="Head1">
<title>WEB查询系统--合同号查询--合同号话费</title>
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
	<form name="form2" method="post" action="AccountFee.jsp" id="form2">
		<div>
			<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
				value="/wEPDwUKLTczNDI4NTIzNg9kFgICAw9kFgQCBQ8QZBAVAgQyMDE1BDIwMTYVAgQyMDE1BDIwMTYUKwMCZ2dkZAIJDxBkEBUCBDIwMTUEMjAxNhUCBDIwMTUEMjAxNhQrAwJnZ2RkGAEFHl9fQ29udHJvbHNSZXF1aXJlUG9zdEJhY2tLZXlfXxYBBQVidG5PS8CHMum13WZ5YIQqDxAzBVDkxVp2" />
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
											<TR align=middle bgcolor=#4791c5>
												<TD id=headerTitleInlineCell style="PADDING-LEFT: 10px"
													vAlign=center align=left width="50%" height=22><FONT
													class=G>合同号［ 573 ］欢迎登录
														<td align="right" style="width: 100%;"><img id="img1"
															alt="退出" src="images/a_exit.gif" style="cursor: pointer;"
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

		<table style="height: 500px; background-color: #4791c5" width="100%"
			border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 482px;" valign="top">
					<table border="0" cellpadding="0" cellspacing="0">

						<tr>
							<td><div>
									<span id="MenuControl1"><table width="160" height="100%"
											border=0 cellpadding=0 cellspacing=0 align="center"
											background-color=Color[Brown]>  <tr> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td> <td valign="top"><table>  <tr align="left" style="display:none">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:none">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='AccountDetail.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 合同号详单</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="Q" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='AccountFee.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> <strong>合同号话费</strong></td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='AccountDFee.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 合同号话费明细</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='AccountPassword.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 合同号修改密码</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td> </table></td> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td></tr></table>
						</span></div>
</td>
</tr>
					</table>
				</td>
				<td style="height: 460px"><div align="center">
						<table width="840" border="0" cellpadding="0" cellspacing="0"
							style="background-color: #deebf5; background-image: url(images/ibg.jpg); background-repeat: no-repeat">
							<tr>
								<td style="height: 460px; PADDING-TOP: 30pt; width: 840px;"
									valign="top">&nbsp;&nbsp;

									<div align="center">
										&nbsp;
										<table cellpadding="0" cellspacing="0" class="css0086"
											style="filter: alpha(opacity = 85)">
											<tr>
												<td class="css0144"
													style="PADDING-RIGHT: 5pt; PADDING-LEFT: 5pt; PADDING-BOTTOM: 5pt; PADDING-TOP: 5pt; background-color: #4791c5; width: 255px;">
													<table cellpadding="0" cellspacing="0" class="css0113">
														<tr>
															<td
																style="height: 15px; font-size: 20pt; font-weight: bold;"><div
																	align="center" style="color: white">
																	&nbsp;请选择起止月份</div>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td
													style="PADDING-RIGHT: 10pt; PADDING-LEFT: 10pt; PADDING-BOTTOM: 10pt; PADDING-TOP: 10pt; background-color: #ffffff; width: 255px;">
													<table cellpadding="0" cellspacing="4" class="css0113">

														<tr id="Tr1" height="10">
															<td class="css0096" style="FONT-SIZE: 1px">&nbsp;</td>
															<td class="css0097">&nbsp;</td>
														</tr>

														<tr>
															<td class="css0059" align="right" style="height: 20px"><label
																for="txtPassword2"> 开始月份：</label></td>
															<td class="css0093" align="left"
																style="width: 155px; height: 20px;"><div
																	class="css0064">
																	<select name="txtBeginYY" id="txtBeginYY">
																		<option value="2015">2015</option>
																		<option selected="selected" value="2016">2016</option>

																	</select>年 <select name="txtBeginMM" id="txtBeginMM">
																		<option value="01">1</option>
																		<option value="02">2</option>
																		<option value="03">3</option>
																		<option value="04">4</option>
																		<option value="05">5</option>
																		<option value="06">6</option>
																		<option value="07">7</option>
																		<option value="08">8</option>
																		<option value="09">9</option>
																		<option value="10">10</option>
																		<option selected="selected" value="11">11</option>
																		<option value="12">12</option>

																	</select>月
																</div></td>
														</tr>
														<tr id="Tr3" height="10">
															<td class="css0096" style="FONT-SIZE: 1px">&nbsp;</td>
															<td class="css0097" style="width: 155px">&nbsp;</td>
														</tr>
														<tr>
															<td class="css0059" align="right"><label
																for="txtPassword">结束月份：</label></td>
															<td class="css0093" align="left" style="width: 155px"><div
																	class="css0064">
																	<select name="txtEndYY" id="txtEndYY">
																		<option value="2015">2015</option>
																		<option selected="selected" value="2016">2016</option>

																	</select>年 <select name="txtEndMM" id="txtEndMM">
																		<option value="01">1</option>
																		<option value="02">2</option>
																		<option value="03">3</option>
																		<option value="04">4</option>
																		<option value="05">5</option>
																		<option value="06">6</option>
																		<option value="07">7</option>
																		<option value="08">8</option>
																		<option value="09">9</option>
																		<option value="10">10</option>
																		<option selected="selected" value="11">11</option>
																		<option value="12">12</option>

																	</select>月
																</div></td>
														</tr>
														<tr id="Tr2" height="10">
															<td class="css0096" style="FONT-SIZE: 1px">&nbsp;</td>
															<td class="css0097">&nbsp;</td>
														</tr>


													</table>
													<div />
												</td>
											</tr>
											<tr>
												<td class="css0144"
													style="height: 20px; PADDING-RIGHT: 5pt; PADDING-LEFT: 5pt; PADDING-BOTTOM: 5pt; PADDING-TOP: 5pt; background-color: background; width: 255px;">
													<table cellpadding="0" cellspacing="4" class="css0113">
														<tr>
															<td class="css0059" align="right" style="width: 15px"></td>
															<td class="css0093" style="width: 105px"><div
																	align="left">
																	<span class="css0170">&nbsp; &nbsp; <input
																		type="image" name="btnOK" id="btnOK"
																		src="images/a_query.gif" style="border-width: 0px;" /></span>
																</div></td>
														</tr>

													</table>
												</td>
											</tr>
										</table>
										<table cellpadding="0" cellspacing="0">
											<tr style="height: 50px;">
												<td></td>
											</tr>
										</table>
									</div>

								</td>
							</tr>
						</table>
					</div></td>
			</tr>
		</table>


		<div>

			<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION"
				value="/wEWHgLeqri7BQKAkvmFCQKAko2pAgLH6si8CwLH6sy8CwLH6vC8CwLH6vS8CwLH6vi8CwLH6vy8CwLH6uC8CwLH6qS/CwLH6qi/CwLY6sS8CwLY6si8CwLY6sy8CwK0r6n/CgK0r93TAQKryMIlAqvIxiUCq8j6JQKryP4lAqvI8iUCq8j2JQKryOolAqvIriYCq8iiJgK0yM4lArTIwiUCtMjGJQLdkpmPAZoF3hMyi2HM/R3ChDCsFrEUIEH7" />
		</div>
	</form>
</body>
</html>

