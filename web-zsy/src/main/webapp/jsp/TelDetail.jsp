<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>WEB查询系统--电话查询--电话详单</title>
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
<body>
	<form name="form2" method="post" action="TelDetail.jsp" id="form2">
		<div>
			<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
				value="/wEPDwUJLTgwNjczNDI0D2QWAgIDD2QWBAIJDw8WAh4EVGV4dAUJMjAxNi0xMC0xZGQCCw8PFgIfAAUJMjAxNi0xMS0xZGQYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgEFBWJ0bk9LMzn/aItu5FsThV0d9iuzWjDUUC0=" />
		</div>

		<table cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="40">
					<table cellSpacing=0 cellPadding=0 width="100%" bgcolor=#336699
						border=0>
						<tbody>
							<tr>
								<td vAlign=top>
									<table cellSpacing=0 cellPadding=0 width="100%" border=0>
										<tbody>
											<tr>
												<TD width="180" rowSpan=2 background="images/tab.bg.dln.gif">
													<IMG src="images/Logo.jpg" width=180 border=0>
												</TD>
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
									</table>
								</td>
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

		<table style="height: 500px; background-color: #4791c5" width="100%"
			border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 500px;" valign="top">
					<div align="center">
						<span id="MenuControl1"><table width="160" height="100%"
								border=0 cellpadding=0 cellspacing=0 align="center"
								background-color=Color[Empty]>  <tr> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td> <td valign="top"><table>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="Q" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelDetail.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> <strong>电话详单</strong></td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelFee.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 电话话费</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td>  <tr align="left" style="display:auto">  	 <td height="40" width="160" align="left" class="P" onmouseover="MO()" onmouseout="MU()" 	 		onclick="javascript:location.href='TelPassword.jsp'"><img src="images/list.gif" width="12" height="12" align="absMiddle"> 修改密码</td> 	</tr>  <tr align="left" style="display:auto">  	 <td style="height:2px; width:160px; background-image:url(images/bar2.gif); background-repeat:repeat"></td> </table></td> <td style="width:1px;background-image:url(images/bar.gif); background-repeat:repeat"></td></tr></table>
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

<table cellpadding="0" cellspacing="0" class="css0086" style="filter:alpha(opacity=85)">
<tr>
	<td class="css0144" style="PADDING-RIGHT:5pt; PADDING-LEFT:5pt; PADDING-BOTTOM:5pt; PADDING-TOP:5pt;background-color: #4791c5;">
		<table cellpadding="0" cellspacing="0" class="css0113">
			<tr>																
				<td  style="height: 15px; font-size:20pt;font-weight:bold;"><div align="center" style="color: white">
					&nbsp;请输入查询条件</div>
				</td>       
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td style="	PADDING-RIGHT:10pt; PADDING-LEFT:10pt; PADDING-BOTTOM:10pt; PADDING-TOP:10pt; background-color:#ffffff">
		<table cellpadding="0" cellspacing="4" class="css0113" >
																	
			<tr>
				<td class="css0059" align="right" style="width: 61px"><label for="txtPassword">话单种类：</label></td>
				<td align="left" style="width: 193px" >
				   <select name="txtKind" id="txtKind" style="width:138px;">
<option value="hdmx">固话通话记录</option>

</select></td>
			</tr>
			
																	
			<tr>
				<td class="css0059" align="right" style="width: 61px"><label for="txtPassword">通话类型：</label></td>
				<td align="left" style="width: 193px" >
				   <select name="txtCallType" id="txtCallType" style="width:138px;">
<option value="all">全部</option>
<option value="市话">市话</option>
<option value="本地网">本地网</option>
<option value="国内长途">国内长途</option>
<option value="国际长途">国际长途</option>
<option value="IP电话">IP电话</option>
<option value="信息">信息</option>
<option value="上网">上网</option>
<option value="特免">特免</option>

</select></td>
			</tr>													
			<tr>
				<td class="css0059" align="right" style="width: 61px"><label for="txtPassword">
					开始时间：</label></td>
				<td class="css0093" align="left" style="width: 193px" ><div class="css0064">
					<input id="BeginTime" name="BeginTime" class="" value="2016-10-1" size type="text" readonly="true" onclick="javascript:this.focus()" onFocus="fPopCalendar(this,this,PopCal);
					 <!-- return false; -->" style="cursor:hand" /><script language="JavaScript"> 
var gdCtrl = new Object();
var gcGray = "#808080";
var gcToggle = "highlight";
var gcBG = "threedface";
var gMonths = new Array("一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月");
var gdCurDate = new Date();
var giYear = gdCurDate.getFullYear();
var giMonth = gdCurDate.getMonth()+1;
var giDay = gdCurDate.getDate();
var sxYear = giYear;
var sxMonth = giMonth;
var sxDay = giDay;
var sxDatestr = gdCtrl.value;
if (sxDatestr != ""){
var sxDate = new Date(sxDatestr);
sxYear = sxDate.getFullYear();
}
var VicPopCal = new Object();
function mouseover(obj){
obj.style.borderTop = 'buttonshadow 1px solid';
obj.style.borderLeft = 'buttonshadow 1px solid';
obj.style.borderRight = 'buttonhighlight 1px solid';
obj.style.borderBottom = 'buttonhighlight 1px solid';
}
function mouseout(obj){
obj.style.borderTop = 'buttonhighlight 1px solid';
obj.style.borderLeft = 'buttonhighlight 1px solid';
obj.style.borderRight = 'buttonshadow 1px solid';
obj.style.borderBottom = 'buttonshadow 1px solid';
}
function mousedown(obj){
obj.style.borderTop = 'buttonshadow 1px solid';
obj.style.borderLeft = 'buttonshadow 1px solid';
obj.style.borderRight = 'buttonhighlight 1px solid';
obj.style.borderBottom = 'buttonhighlight 1px solid';
}
function mouseup(obj){
obj.style.borderTop = 'buttonhighlight 1px solid';
obj.style.borderLeft = 'buttonhighlight 1px solid';
obj.style.borderRight = 'buttonshadow 1px solid';
obj.style.borderBottom = 'buttonshadow 1px solid';
}
function fPopCalendar(popCtrl, dateCtrl, popCal){
VicPopCal = popCal;
gdCtrl = dateCtrl;
fSetYearMon(giYear, giMonth);
var point = fGetXY(popCtrl);
with (VicPopCal.style) {left = point.x;top  = point.y+popCtrl.offsetHeight+1;visibility = 'visible';}
VicPopCal.focus();
}
function fSetDate(iYear, iMonth, iDay){
if ((iYear == 0) && (iMonth == 0) && (iDay == 0)){
gdCtrl.value = "";
}
else{
if (iMonth < 10){iMonth = "0"+iMonth;}
if (iDay < 10){iDay = "0"+iDay;}
gdCtrl.value = iYear+"-"+iMonth+"-"+iDay;
}
VicPopCal.style.visibility = "hidden";
}
function fSetSelected(aCell){
var iOffset = 0;
var iYear = parseInt(document.all.tbSelYear.value);
var iMonth = parseInt(document.all.tbSelMonth.value);
aCell.bgColor = gcBG;
with (aCell.children["cellText"]){
var iDay = parseInt(innerText);
if (color==gcGray){iOffset = (Victor<10)?-1:1;}
iMonth += iOffset;
if (iMonth<1) {	iYear--; iMonth = 12;}else{if (iMonth>12){iYear++;iMonth = 1;}}
}
fSetDate(iYear, iMonth, iDay);
}
function Point(iX, iY){this.x = iX;this.y = iY;}
function fBuildCal(iYear, iMonth){
var aMonth=new Array();
for(i=1;i<7;i++){aMonth[i]=new Array(i);}
var dCalDate=new Date(iYear, iMonth-1, 1);
var iDayOfFirst=dCalDate.getDay();
var iDaysInMonth=new Date(iYear, iMonth, 0).getDate();
var iOffsetLast=new Date(iYear, iMonth-1, 0).getDate()-iDayOfFirst+1;
var iDate = 1;
var iNext = 1;
for (d = 0; d < 7; d++){aMonth[1][d] = (d<iDayOfFirst)?-(iOffsetLast+d):iDate++;}
for (w = 2; w < 7; w++){for (d = 0; d < 7; d++){aMonth[w][d] = (iDate<=iDaysInMonth)?iDate++:-(iNext++);}}
return aMonth;
}
function fDrawCal(iYear, iMonth, iDay, iCellWidth, iDateTextSize) {
var WeekDay = new Array("日","一","二","三","四","五","六");
var styleTD = " bgcolor='"+gcBG+"' width='"+iCellWidth+"' bordercolor='"+gcBG+"' valign='middle' align='center' style='font-size: 12px;background: buttonface;border-top: buttonhighlight 1px solid;border-left: buttonhighlight 1px solid;border-right: buttonshadow 1px solid;	border-bottom: buttonshadow 1px solid;";
with (document) {
write("<tr align='center'>");
for(i=0; i<7; i++){write("<td height='20' "+styleTD+"color:#990099' >" + WeekDay[i] + "</td>");}
write("</tr>");
for (w = 1; w < 7; w++) {
write("<tr align='center'>");
for (d = 0; d < 7; d++) {
write("<td width='10%' height='15' id=calCell "+styleTD+"cursor:hand;' onmouseover='mouseover(this)' onmouseout='mouseout(this)' onmousedown='mousedown(this)' onmouseup='mouseup(this)' onclick='fSetSelected(this)'>");
write("<font style='font-size: 13px;' id=cellText Victor='Liming Weng'> </font>");
write("</td>");
}
write("</tr>");
}
}
}
function fUpdateCal(iYear, iMonth) {
sxYear = iYear;
sxMonth = iMonth;
yeartd1.innerText = sxYear + "年";
monthtd1.innerText = gMonths[sxMonth-1];
myMonth = fBuildCal(iYear, iMonth);
var i = 0;
for (w = 0; w < 6; w++){
for (d = 0; d < 7; d++){
with (cellText[(7*w)+d]) {
Victor = i++;
if (myMonth[w+1][d]<0) {
color = gcGray;
innerText = -myMonth[w+1][d];
}else{
color = ((d==0)||(d==6))?"red":"black";
innerText = myMonth[w+1][d];
}
}
}
}
}
function fSetYearMon(iYear, iMon){
sxYear = iYear;
sxMonth = iMon;
yeartd1.innerText = sxYear + "年";
monthtd1.innerText = gMonths[sxMonth-1];
document.all.tbSelMonth.options[iMon-1].selected = true;
for (i = 0; i < document.all.tbSelYear.length; i++){
if (document.all.tbSelYear.options[i].value == iYear){
document.all.tbSelYear.options[i].selected = true;
}
}
fUpdateCal(iYear, iMon);
}
function fPrevMonth(){
var iMon = document.all.tbSelMonth.value;
var iYear = document.all.tbSelYear.value;
if (--iMon<1) {
iMon = 12;
iYear--;
}
fSetYearMon(iYear, iMon);
}
function fNextMonth(){
var iMon = document.all.tbSelMonth.value;
var iYear = document.all.tbSelYear.value;
if (++iMon>12) {
iMon = 1;
iYear++;
}
fSetYearMon(iYear, iMon);
}
function fGetXY(aTag){
var oTmp = aTag;
var pt = new Point(0,0);
do {
pt.x += oTmp.offsetLeft;
pt.y += oTmp.offsetTop;
oTmp = oTmp.offsetParent;
} while(oTmp.tagName!="BODY");
return pt;
}
with (document){
write("<Div id='PopCal' onclick='event.cancelBubble=true' style='POSITION:absolute; VISIBILITY: hidden; bordercolor:#000000;border:2px ridge;width:10;z-index:100;'>");
write("<table id='popTable' border='1' bgcolor='#eeede8' cellpadding='0' cellspacing='0' style='font-size:12px'>");
write("<TR>");
write("<td valign='middle' align='center' style='cursor:default'>");
write("<table width='176' border='0' cellpadding='0' cellspacing='0'>");
write("<tr align='center'>");
write("<td height='22' width='20' name='PrevMonth' style='font-family:\"webdings\";font-size:15px' onClick='fPrevMonth()' onmouseover='this.style.color=\"#ff9900\"' onmouseout='this.style.color=\"\"'>3</td>");
write("<td width='64' id='yeartd1' style='font-size:12px' onmouseover='yeartd1.style.display=\"none\";yeartd2.style.display=\"\";' onmouseout='this.style.background=\"\"'>");
write(sxYear + "年");
write("</td>");
write("<td width='64' id='yeartd2' style='display:none' onmouseout='yeartd2.style.display=\"none\";yeartd1.style.display=\"\";'>");
write("<SELECT style='width:64px;font-size: 12px;font-family: 宋体;' id='tbSelYear' onChange='fUpdateCal(document.all.tbSelYear.value, document.all.tbSelMonth.value);yeartd2.style.display=\"none\";yeartd1.style.display=\"\";' Victor='Won'>");
for(i=1930;i<2015;i++){
write("<OPTION value='"+i+"'>"+i+"年</OPTION>");
}
write("</SELECT>");
write("</td>");
write("<td width='72' id='monthtd1' style='font-size:12px' onmouseover='monthtd1.style.display=\"none\";monthtd2.style.display=\"\";' onmouseout='this.style.background=\"\"'>");
write(gMonths[sxMonth-1]);
write("</td>");
write("<td width='72' id='monthtd2' style='display:none' onmouseout='monthtd2.style.display=\"none\";monthtd1.style.display=\"\";'>");
write("<select style='width:72px;font-size: 12px;font-family: 宋体;' id='tbSelMonth' onChange='fUpdateCal(document.all.tbSelYear.value, document.all.tbSelMonth.value);monthtd2.style.display=\"none\";monthtd1.style.display=\"\";' Victor='Won'>");
for (i=0; i<12; i++){
write("<option value='"+(i+1)+"'>"+gMonths[i]+"</option>");
}
write("</SELECT>");
write("</td>");
write("<td width='20' name='PrevMonth' style='font-family:\"webdings\";font-size:15px' onclick='fNextMonth()' onmouseover='this.style.color=\"#ff9900\"' onmouseout='this.style.color=\"\"'>4</td>");
write("</tr>");
write("</table>");
write("</td></TR><TR><td align='center'>");
write("<DIV style='background-color:teal;'><table width='100%' border='0' bgcolor='threedface' cellpadding='0' cellspacing='0'>");
fDrawCal(giYear, giMonth, giDay, 19, 14);
write("</table></DIV>");
write("</td></TR><TR><TD height='20' align='center' valign='bottom'>");
write("<font style='cursor:hand;font-size:12px' onclick='fSetDate(0,0,0)' onMouseOver='this.style.color=\"#0033FF\"' onMouseOut='this.style.color=0'>清空</font>");
write("&nbsp;&nbsp;&nbsp;&nbsp;");
write("<font style='cursor:hand;font-size:12px' onclick='fSetDate(giYear,giMonth,giDay)' onMouseOver='this.style.color=\"#0033FF\"' onMouseOut='this.style.color=0'>今天: "+giYear+"-"+giMonth+"-"+giDay+"</font>");
write("</TD></TR></TD></TR></TABLE>");
write("</Div>");
}
</script>
<SCRIPT event=onclick() for=document>PopCal.style.visibility = 'hidden';</SCRIPT>

					&nbsp;</div>
				</td>
			</tr>
				
			<tr>
				<td class="css0059" align="right" style="width: 61px; height: 14px"><label for="txtPassword">
					结束时间：</label></td>
				<td class="css0093" align="left" style="height: 14px; width: 193px;" ><div class="css0064">
					<input id="EndTime" name="EndTime" class="" value="2016-11-1" size type="text" readonly="true" onclick="javascript:this.focus()" onFocus="fPopCalendar(this,this,PopCal); <!-- return false; -->" style="cursor:hand" />
					&nbsp;</div>
				</td>
			</tr>
			
			<tr>
				<td class="css0059" align="right" style="width: 61px; height: 14px"><label for="txtPassword">
					被叫号码：</label></td>
				<td class="css0093" align="left" style="height: 14px; width: 193px;" ><div class="css0064">
					<input name="TextBox1" type="text" id="TextBox1" />&nbsp;</div>
				</td>
			</tr>
												

			<tr >
				<td class="css0059" align="right" style="width: 61px">
					注意1：</td>
				<td class="css0097" align="left" style="width: 193px">
					固话通话记录:固话的通话记录查询;
				</td>
			</tr>
			
			
			<tr >
				<td class="css0059" align="right" style="width: 61px; height: 28px;">
					注意2：</td>
				<td class="css0097" align="left" style="width: 193px; height: 28px;">
					查询日期:为开始月份的某一天,<br />
					&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; 至结束月份的某一天.</td>
			</tr>
		</table>
		<div>
			&nbsp;</div>
	</td>
</tr>
<tr>
	<td class="css0144" style="height:20px;PADDING-RIGHT:5pt; PADDING-LEFT:5pt; PADDING-BOTTOM:5pt; PADDING-TOP:5pt; background-color: background;">
		<table cellpadding="0" cellspacing="4" class="css0113">																														
			<tr>
				<td class="css0059" align="right" style="width: 72px"></td>
				<td class="css0093" style="width: 105px"><div align="left"><span class="css0170"><input type="image" name="btnOK" id="btnOK" src="images/a_query.gif" style="border-width:0px;" /></span></div>																
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


		<div></div>

		<div>

			<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION"
				value="/wEWDQKu9NO0AQKgorrBAwKAs8eSCQLDp/7NBgLEk7ClDwLPvZm+DwLPvZm8AwLVlxoC4oSmlg0C+4fu4Q0Ciu++kQwC7NGy6wYC3ZKZjwHsrRUO2OkO5fjRaBUsZYgWz4/7xg==" />
		</div>
	</form>

</body>
</html>


</body>
</html>