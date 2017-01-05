<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head id="Head1">
<title>WEB查询系统--资费标准</title>
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
	<form name="form1" method="post" action="FeeShow.jsp" id="form1">
		<div>
			<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE"
				value="/wEPDwULLTExNDQ3NzgzMzhkZEt2QvIVhgirKu0C1VQ5+PPrR8AC" />
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
													<a class=E tabIndex=3 href="Index.jsp">首页</a>&nbsp;&nbsp;&nbsp;
												</td>
												<td style=""><img src="images/tab.separator.on.l.gif"></td>
												<td noWrap background="images/tab.bg.off.gif"
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
												<td noWrap background="images/tab.bg.on.gif"
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
		<table style="height: 100%; background-color: #deebf5" width="100%"
			border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td style="height: 460px"><div align="center">
						<table width="840" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td style="height: 460px; width: 840px;" valign="top">
									<div align="center">
										<table cellpadding="0" cellspacing="0">
											<!--本页面可以修改的开始位置-->
											<tr height=350 width="80%">
												<td width="10%" />
												<td style="height: 350px;" width="80%" align="left"
													valign="middle">

													<html xmlns:o="urn:schemas-microsoft-com:office:office"
														xmlns:x="urn:schemas-microsoft-com:office:excel"
														xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=Content-Type content="text/html; charset=GB2312">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 9">
<link rel=File-List href="./FeeShow.files/filelist.xml">
<link rel=Edit-Time-Data href="./FeeShow.files/editdata.mso">
<link rel=OLE-Object-Data href="./FeeShow.files/oledata.mso">
<!--[if gte mso 9]><xml>
<o:DocumentProperties>
<o:Author>孙阳</o:Author>
<o:LastAuthor>cnpc'x fwq01</o:LastAuthor>
<o:LastPrinted>2013-07-16T06:48:50Z</o:LastPrinted>
<o:Created>2013-01-28T05:35:51Z</o:Created>
<o:LastSaved>2013-07-16T06:48:55Z</o:LastSaved>
<o:Company>微软中国</o:Company>
<o:Version>9.2812</o:Version>
</o:DocumentProperties>
<o:OfficeDocumentSettings>
<o:DownloadComponents/>
<o:LocationOfComponents HRef="file:///D:/backup/工具软件/office%25202000/msowc.cab"/>
</o:OfficeDocumentSettings>
</xml><![endif]-->
<style>
<!--
table {
	mso-displayed-decimal-separator: "\.";
	mso-displayed-thousand-separator: "\,";
}

@page {
	margin: .75in .7in .75in .7in;
	mso-header-margin: .3in;
	mso-footer-margin: .3in;
}

.font8 {
	color: black;
	font-size: 10.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

tr {
	mso-height-source: auto;
	mso-ruby-visibility: none;
}

col {
	mso-width-source: auto;
	mso-ruby-visibility: none;
}

br {
	mso-data-placement: same-cell;
}

.style0 {
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	white-space: nowrap;
	mso-rotate: 0;
	mso-background-source: auto;
	mso-pattern: auto;
	color: black;
	font-size: 11.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	border: none;
	mso-protection: locked visible;
	mso-style-name: 常规;
	mso-style-id: 0;
}

td {
	mso-style-parent: style0;
	padding-top: 1px;
	padding-right: 1px;
	padding-left: 1px;
	mso-ignore: padding;
	color: black;
	font-size: 11.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-number-format: General;
	text-align: general;
	vertical-align: middle;
	border: none;
	mso-background-source: auto;
	mso-pattern: auto;
	mso-protection: locked visible;
	white-space: nowrap;
	mso-rotate: 0;
}

.xl24 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.xl25 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
}

.xl26 {
	mso-style-parent: style0;
	font-size: 16.0pt;
	font-family: 方正小标宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.xl27 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正黑体简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
}

.xl28 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正黑体简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	white-space: normal;
}

.xl29 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正黑体简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	white-space: normal;
}

.xl30 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	white-space: normal;
}

.xl31 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	white-space: normal;
}

.xl32 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	white-space: normal;
}

.xl33 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	white-space: normal;
}

.xl34 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	white-space: normal;
}

.xl35 {
	mso-style-parent: style0;
	font-size: 16.0pt;
	font-family: 方正小标宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: none;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	white-space: normal;
}

.xl36 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正黑体简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	white-space: normal;
}

.xl37 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正黑体简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid black;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	white-space: normal;
}

.xl38 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: .5pt solid windowtext;
	border-right: none;
	border-bottom: .5pt solid windowtext;
	border-left: .5pt solid windowtext;
	white-space: normal;
}

.xl39 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid black;
	border-bottom: .5pt solid windowtext;
	border-left: none;
	white-space: normal;
}

.xl40 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	white-space: normal;
}

.xl41 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: .5pt solid windowtext;
	border-right: .5pt solid windowtext;
	border-bottom: none;
	border-left: .5pt solid windowtext;
	white-space: normal;
}

.xl42 {
	mso-style-parent: style0;
	font-size: 12.0pt;
	font-family: 方正仿宋简体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	text-align: center;
	border-top: none;
	border-right: .5pt solid windowtext;
	border-bottom: .5pt solid black;
	border-left: .5pt solid windowtext;
	white-space: normal;
}

ruby {
	ruby-align: left;
}

rt {
	color: windowtext;
	font-size: 9.0pt;
	font-weight: 400;
	font-style: normal;
	text-decoration: none;
	font-family: 宋体;
	mso-generic-font-family: auto;
	mso-font-charset: 134;
	mso-char-type: none;
	display: none;
}
-->
</style>
<!--[if gte mso 9]><xml>
<x:ExcelWorkbook>
<x:ExcelWorksheets>
<x:ExcelWorksheet>
<x:Name>办公电话</x:Name>
<x:WorksheetOptions>
<x:DefaultRowHeight>315</x:DefaultRowHeight>
<x:StandardWidth>2272</x:StandardWidth>
<x:Print>
<x:ValidPrinterInfo/>
<x:PaperSizeIndex>9</x:PaperSizeIndex>
<x:HorizontalResolution>600</x:HorizontalResolution>
<x:VerticalResolution>600</x:VerticalResolution>
</x:Print>
<x:Selected/>
<x:TopRowVisible>9</x:TopRowVisible>
<x:Panes>
<x:Pane>
<x:Number>3</x:Number>
<x:ActiveRow>2</x:ActiveRow>
</x:Pane>
</x:Panes>
<x:ProtectContents>False</x:ProtectContents>
<x:ProtectObjects>False</x:ProtectObjects>
<x:ProtectScenarios>False</x:ProtectScenarios>
</x:WorksheetOptions>
</x:ExcelWorksheet>
</x:ExcelWorksheets>
<x:WindowHeight>11010</x:WindowHeight>
<x:WindowWidth>15480</x:WindowWidth>
<x:WindowTopX>480</x:WindowTopX>
<x:WindowTopY>45</x:WindowTopY>
<x:ProtectStructure>False</x:ProtectStructure>
<x:ProtectWindows>False</x:ProtectWindows>
</x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

	<table x:str border=0 cellpadding=0 cellspacing=0 width=785
		style='border-collapse: collapse; table-layout: fixed; width: 590pt'>
		<col class=xl25 width=90
			style='mso-width-source: userset; mso-width-alt: 2880; width: 68pt'>
		<col class=xl24 width=162
			style='mso-width-source: userset; mso-width-alt: 5184; width: 122pt'>
		<col class=xl24 width=390
			style='mso-width-source: userset; mso-width-alt: 12480; width: 293pt'>
		<col class=xl25 width=143
			style='mso-width-source: userset; mso-width-alt: 4576; width: 107pt'>
		<col class=xl24 width=148
			style='mso-width-source: userset; mso-width-alt: 4736; width: 111pt'>
		<tr class=xl26 height=53
			style='mso-height-source: userset; height: 40.15pt'>
			<td colspan=4 height=53 class=xl35 width=785
				style='height: 40.15pt; width: 590pt'>办 公 电 话 资 费 标 准<br>
				<font class=font8>2013年1月1日开始实施</font></td>
		</tr>
		<tr class=xl27 height=40
			style='mso-height-source: userset; height: 30.0pt'>
			<td height=40 class=xl28 width=90 style='height: 30.0pt; width: 68pt'>分类</td>
			<td colspan=2 class=xl36 width=552
				style='border-right: .5pt solid black; border-left: none; width: 415pt'>项目</td>
			<td class=xl29 width=143 style='width: 107pt'>资费标准</td>
		</tr>
		<tr height=80 style='mso-height-source: userset; height: 60.0pt'>
			<td height=80 class=xl30 width=90 style='height: 60.0pt; width: 68pt'>本地电话话费标准</td>
			<td colspan=2 class=xl38 width=552
				style='border-right: .5pt solid black; border-left: none; width: 415pt'>本地通话费</td>
			<td class=xl32 width=143 style='width: 107pt'>前3分钟0.22元<br>
				之后0.11元/分钟
			</td>
		</tr>
		<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
			<td rowspan=9 height=682 class=xl41 width=90
				style='border-bottom: .5pt solid black; height: 511.5pt; border-top: none; width: 68pt'>长途电话话费标准</td>
			<td colspan=2 class=xl38 width=552
				style='border-right: .5pt solid black; border-left: none; width: 415pt'>国内长途通话费</td>
			<td class=xl32 width=143 style='width: 107pt'>0.30元/分钟</td>
		</tr>
		<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
			<td colspan=2 height=40 class=xl38 width=552
				style='border-right: .5pt solid black; height: 30.0pt; border-left: none; width: 415pt'>港澳台地区长途通话费</td>
			<td class=xl32 width=143 style='width: 107pt'>1.50元/分钟</td>
		</tr>
		<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
			<td rowspan=7 height=602 class=xl41 width=162
				style='border-bottom: .5pt solid black; height: 451.5pt; border-top: none; width: 122pt'>国际长途通话费</td>
			<td class=xl33 width=390 style='width: 293pt'>美国（含阿拉斯加和夏威夷，不含其它代码为“1”的国家和地区）、加拿大</td>
			<td class=xl32 width=143 style='width: 107pt'>2.40元/分钟</td>
		</tr>
		<tr height=141 style='mso-height-source: userset; height: 105.75pt'>
			<td height=141 class=xl33 width=390
				style='height: 105.75pt; width: 293pt'>澳大利亚、巴哈马、巴林、巴拿马、百慕大群岛、波多黎各、玻利维亚、不丹、德国、法国、菲律宾、芬兰、哥斯达黎加、韩国、柬埔寨、科威特、老挝、马拉维、马来西亚、美国关岛、美属萨摩亚、美属维尔京群岛、日本、塞班、塞浦路斯、泰国、文莱、乌克兰、乌兹别克斯坦、新加坡、匈牙利、意大利、印度、印度尼西亚、英国</td>
			<td class=xl32 width=143 style='width: 107pt'>3.60元/分钟</td>
		</tr>
		<tr height=105 style='mso-height-source: userset; height: 78.75pt'>
			<td height=105 class=xl33 width=390
				style='height: 78.75pt; width: 293pt'>阿富汗、埃塞俄比亚、奥地利、巴勒斯坦、以色列、白俄罗斯、比利时、斐济、佛得角、洪都拉斯、加蓬、卡塔尔、肯尼亚、莱索托、利比亚、马达加斯加、马耳他、马里、摩洛哥、墨西哥、南非、尼日利亚、塞拉利昂、斯里兰卡、突尼斯、新西兰</td>
			<td class=xl32 width=143 style='width: 107pt'>6.00元/分钟</td>
		</tr>
		<tr height=130 style='mso-height-source: userset; height: 97.5pt'>
			<td height=130 class=xl33 width=390
				style='height: 97.5pt; width: 293pt'>爱沙尼亚、保加利亚、波里尼西亚、波斯尼亚和黑塞哥维那、多哥、厄立特里亚、法属圭亚那、冈比亚、刚果.金、瓜得罗普岛、圭亚那、海地、吉布提、津巴布韦、科摩罗岛、利比里亚、留尼汪岛、马绍尔群岛、马提尼克、马约特岛、缅甸、尼泊尔、帕劳、瑞士、叙利亚、牙买加、中非</td>
			<td class=xl32 width=143 style='width: 107pt'>8.00元/分钟</td>
		</tr>
		<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
			<td height=40 class=xl33 width=390
				style='height: 30.0pt; width: 293pt'>北朝鲜、赤道几内亚、格陵兰岛、几内亚、索马里、西萨摩亚</td>
			<td class=xl32 width=143 style='width: 107pt'>12.00元/分钟</td>
		</tr>
		<tr height=106 style='mso-height-source: userset; height: 79.5pt'>
			<td height=106 class=xl33 width=390
				style='height: 79.5pt; width: 293pt'>阿森松、巴布亚新几内亚、迪戈加西亚岛、东帝汶、福克兰群岛、古巴、基里巴斯、几内亚比绍、库克群岛、列支敦士登、瑙鲁、纽埃岛、诺福克岛、圣多莫和普林西比、圣赫勒拿、所罗门群岛、汤加、图瓦卢、托克劳群岛、瓦里斯和富士那、瓦努阿图</td>
			<td class=xl32 width=143 style='width: 107pt'>15.00元/分钟</td>
		</tr>
		<tr height=40 style='mso-height-source: userset; height: 30.0pt'>
			<td height=40 class=xl33 width=390
				style='height: 30.0pt; width: 293pt'>其他国家和地区</td>
			<td class=xl32 width=143 style='width: 107pt'>4.60元/分钟</td>
		</tr>
		<tr height=21 style='height: 15.75pt'>
			<td height=21 class=xl31 style='height: 15.75pt'></td>
			<td colspan=2 class=xl34 style='mso-ignore: colspan'></td>
			<td class=xl31></td>
		</tr>
		<![if supportMisalignedColumns]>
		<tr height=0 style='display: none'>
			<td width=90 style='width: 68pt'></td>
			<td width=162 style='width: 122pt'></td>
			<td width=390 style='width: 293pt'></td>
			<td width=143 style='width: 107pt'></td>
		</tr>
		<![endif]>
	</table>

</body>

													</html>


												</td>
												<td width="10%" />
											</tr>
											<!--本页面可以修改的结束位置-->
											</div>

											</td>
											</tr>
										</table>
									</div>
								</td>
							</tr>
						</table>

						</form>
</body>
</html>

