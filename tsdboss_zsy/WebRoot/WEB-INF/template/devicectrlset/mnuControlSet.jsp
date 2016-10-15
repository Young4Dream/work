<%----------------------------------------
	name: mnuControlSet.jsp
	author: youhongyu
	version: 1.0, 2010-12-28
	description: 通信设备控制接口设置
	modify: 
			2011-1-5 youhongyu 添加日志写入、添加必填字段、修改弹出面板中下拉选择框默认值
		    2011-1-14 youhongyu  a.样式修改 b.分项卡数据更新 c.第二个分项卡的修改日志写入
			2011-7-14 youhongyu 控制接口设置 页面显示
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.tsd.service.util.Log"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
%>
<%
	SimpleDateFormat format = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>The definition of subsidy payment of the type</title>

		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>

		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>

		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />

		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/tsdpower.js"></script>
		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />

		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>

		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
		
		<!-- 本页面js -->
		<script src="script/devicectrlset/mnuControlSet.js" type="text/javascript"></script>

<script type="text/javascript">

//用于表识当前选项卡
var tabStatus=1;
//存放各选项卡对应表名
var tables = ["txkz_ctlset","free_grade"];
//存放各选项卡对sql语句的开始部分
var pkeys = ["mnuControlSet","FreeGrade"];
//存放各选项卡关键字段
var keys = [["jhjid","ywid","ctlport"],["id"]];
var firstLoad = [true,true];
//存放各选项卡对应jqgrid的标题
var mNames = ["<fmt:message key='subsidyPay.ButieItem' />","<fmt:message key='subsidyPay.FreeGrade' />"];
var result = new Array();//
var fieldnametow = new Array();//用于存放第一个分项卡的输入域id
/**
* 页面初始化
* @param 
* @return 
*/
jQuery(document).ready(function () {
			/**********************
			**   取得当前用户的权限  *
			**********************/
			getUserPower();	
			var addright = $("#addright").val();			
			var queryright = $("#queryright").val();			
			var saveQueryMright = $("#saveQueryMright").val();
			var exportright = $("#exportright").val();
			var saveParamsright = $("#saveParamsright").val();
						
			//高级查询权限设置
			if(queryright=="true"){
				document.getElementById("gjquery1").disabled=false;
				document.getElementById("gjquery2").disabled=false;
			}
			//本查询为模板权限设置		
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
			}
			
			if(addright=="true"){
				document.getElementById("openadd1").disabled=false;
				document.getElementById("openadd2").disabled=false;
			}
			if(exportright=="true"){
				document.getElementById("export1").disabled=false;
				document.getElementById("export2").disabled=false;
			}
			if(saveParamsright=="true"){
				document.getElementById("saveParams").disabled=false;
			}
			
			//导航栏	
			$("#navBar").append(genNavv());
			
			//第一个分项卡的初始化
			loadJQgrid();//加载第一个分项卡的jqgrid
			langLable();//第一个选项卡上lable标签国际化
			getJhjId();//初始化设备编号
			getProType();//初始化协议类型
			
			//第二个分项卡的初始化
			getParamsTwo();
			
			$("#tabs").tabs();
			tabsChg(1);	//默认显示第一个选项卡
});


</script>
<style type="text/css">
<!--
#multiple INPUT {
	text-align: left;
}

#multiple label {
	text-align: left;
}

#multiple {
	width: 100%;
	float: left;
	text-align: left;
	line-height: 18px;
}
-->
</style>
		<style type="text/css">
.style1 {
	background-color: #A9C3E8;
	padding: 4px;
}

.a {
	margin-right: 10%;
	margin-left: 100px;
	border: 1px solid #ccc;
	width: 500px;
	overflow: left;
	text-overflow: ellipsis;
}
</style>
		<style type="text/css">
#navBar1 {
	height: 26px;
	background: url(style/images/public/daohangbg.jpg);
	line-height: 28px;
}

cas {
	float: left;
	width: 100%;
	height: 26px;
	background: url(style/images/public/daohangbg.jpg) repeat-x;
	line-height: 28px;
}
</style>
	</head>

	<body>
		<form name="childform" id="childform">
			<input type="text" id="queryName" name="queryName" value=""
				style="display: none" />
			<input type="text" id="fusearchsql" name="fusearchsql"
				style="display: none" />
		</form>
		<!-- 用户操作导航-->
		<div id="navBar1">
			<table width="100%" style="height: 26px;">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message
									key="gjh.houtuei" />
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>

		
			
			<!-- Tabs -->
			<div id="tabs" style="margin-top: 5px;">
				<ul>
					<li>
						<a href="#tabsone" onclick="tabsChg(1)"><span>
							控制接口设置
						</span>
						</a>
					</li>
					<li>
						<a href="#tabstwo" onclick="tabsChg(2)"><span>
							其他参数设置
						</span>
						</a>
					</li>
				</ul>
			
			<div id="tabsone" style="display: none;">
				<!-- 用户操作标题以及放一些快捷按钮-->
				<div id="buttons"  class="gridbut1">
					<button type="button" id="order" onclick="openwinO();"
						style="float: left;">
						<!--组合排序-->
						<fmt:message key="order.title" />
					</button>
					<button type="button" id="openadd1" onclick="openadd();"
						style="float: left;" disabled="disabled">
						<!-- 新增 -->
						<fmt:message key="global.add" />
					</button>					
					<button id='mbquery1' onclick='modQuery();'>
						<fmt:message key="oper.mod" />
					</button>
					<button id='gjquery1' onclick="openwinQ();" disabled="disabled">
						<!--高级查询-->
						<fmt:message key="oper.queryA" />
					</button>
					<button id='savequery1' onclick="openSaveModPan();"
						disabled="disabled">
						<!--保存本次查询-->
						<fmt:message key="oper.modSave" />
					</button>
					<button type="button" id="export1" onclick="openExport();"
						disabled="disabled">
						<!--导出-->
						<fmt:message key="global.exportdata" />
					</button>
				</div>
			
				<div id="gridd">
					<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered" class="scroll" style="text-align: left;"></div>
				</div>
			
				<!-- 用户操作标题以及放一些快捷按钮-->
				<div id="buttons" class="gridbut2">
					<button type="button" id="order" onclick="openwinO();"
						style="float: left;">
						<!--组合排序-->
						<fmt:message key="order.title" />
					</button>
					<button type="button" id="openadd2" onclick="openadd();"
						style="float: left;" disabled="disabled">
						<!-- 新增 -->
						<fmt:message key="global.add" />
					</button>
					<button onclick='modQuery();' id='mbquery2'>
						<fmt:message key="oper.mod" />
					</button>
					<button type="button" id='gjquery2' onclick="openwinQ();"
						disabled="disabled">
						<!--高级查询-->
						<fmt:message key="oper.queryA" />
					</button>
					<button type="button" id='savequery2' onclick="openSaveModPan();"
						disabled="disabled">
						<!--保存本次查询-->
						<fmt:message key="oper.modSave" />
					</button>
					<button type="button" id="export2" onclick="openExport();"
						disabled="disabled">
						<!--导出-->
						<fmt:message key="global.exportdata" />
					</button>
				</div>
		</div>
		<div id="tabstwo" style="display: none;">
			
			<table width="95%" border="1" cellpadding="0" style="margin-top: 10px;margin-left: 5px;border:1px solid #E8E9E8;">				
				<tr >
					<td align="center" width="12%" style="height: 25px;">
						<label id="pnameg_s"></label>
					</td>
					<td align="center" width="15%" >
						<label id="pdislabelg_s"></label>
					</td>		
					<td align="center" width="35%" >
						<label id="pvalueg_s"></label>
					</td>
					<td align="center" width="38%" >
						<label id="bzg_s"></label>
					</td>							
				</tr>
				<tbody id="paramTabTwo">
				</tbody>
			</table>			
			<center style="width: 95%;">
				<button type="button" id='saveParams' onclick="saveParams();" class="tsdbutton"
							disabled="disabled">
							<!--保存-->
							<fmt:message key="global.save" />
				</button>
				
				<button class="tsdbutton" id="resetParms"
					style="width: 63px; heigth: 27px;" onclick="setParamsVal();">
					<!-- 取消     -->
					取消
				</button>
			</center>
		</div>
		</div>
		

		<!-- 添加修改面板 read1 -->
		<div class="neirong" id="panTab1" style="display: none;">
			<input type="text" id="abcd" style="margin-left: -900px;"/><!-- 处理鼠标不能聚焦的错误 -->
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							功能名称
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="closeo()"><span style="margin-left: 5px;"><fmt:message
									key="global.close" />
						</span>
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
					
				</div>
			</div>
			<div class="midd">
				<div style="max-height:250px;overflow-y: auto;overflow-x: hidden;background-color: #fff" >
				<form id='operformT1' name="operformT1" onsubmit="return false;"
					action="#" style="width: 98%;float: left;"> 					
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0" style="line-height: 33px; font-size: 12px;">
						<!-- 1 -->
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="jhjidg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								
								<select id="jhjid"  class="textclass" onchange="getValbyJhjid(this.value);"></select>
								<label class="addred"></label>
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="jhjxg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="jhjx" id="jhjx" class="textclass2" readonly="readonly"/>
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="jhjareag"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="jhjarea" id="jhjarea" 
								class="textclass2" readonly="readonly"/>
							</td>
						</tr>
					
						<!-- 2 -->
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="ywlxg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<select id="ywlx"  class="textclass" style="width: 187px;" onchange="getDllname(this.value);">
									
								</select>
								<label class="addred"></label>
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="dllnameg"></label>
							</td>							
							<td width="52%" colspan="4" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="dllname" id="dllname" class="textclass2" readonly="readonly"/>
							</td>
						</tr>
							
						<!-- 3 -->
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="ctlportg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="ctlport" id="ctlport" class="textclass"
								 style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8"
								  onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" 
								></input>
								<label class="addred"></label>
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="ywidg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="ywid" id="ywid" class="textclass"
								 style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="8"
								  onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" 
								/>
								<label class="addred"></label>
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="ctlsysnameg"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="ctlsysname" id="ctlsysname" class="textclass"/>
								<label class="addred"></label>
							</td>
						</tr>
						
						<!-- 4 -->
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="protocolg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<select id="protocol"  class="textclass" onchange="getParamsByPro(this.value);"></select>
								<label class="addred"></label>
							</td>

							<td width="12%" align="right" class="labelclass">								
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">								
							</td>

							<td width="12%" align="right" class="labelclass">								
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">								
							</td>
						</tr>						
						<tr>
							<td colspan="6">
								<table width="100%" border="1" cellpadding="0" id="paramTable" style="border:1px solid #a9c8d9;">
									<tr >
										<td colspan="4">
										<label id="paramsg" style="width: 120px;margin-left: 55px;"></label>
										<label class="addred"></label>
										</td>
									</tr>									
									<tr >
										<td align="center" width="12%" >
											<label id="pnameg"></label>
										</td>
										<td align="center" width="12%" >
											<label id="pdislabelg"></label>
										</td>		
										<td align="center" width="38%" >
											<label id="pvalueg"></label>
										</td>
										<td align="center" width="38%" >
											<label id="bzg"></label>
										</td>							
									</tr>
									<tbody id="paramTab">									
									</tbody>
								</table>						
							</td>
						</tr>
					</table>
					
				</form>
				</div>
				<div class="midd_butt">
					<!-- 查询     -->
					<button class="tsdbutton" id="jdquery1" onclick="QbuildParams();">
						<fmt:message key="global.query" />
					</button>
					<!-- 保存新增 -->
					<button class="tsdbutton" id="readd1"
						style="width: 80px; heigth: 27px;" onclick="saveObj(1);">
						<fmt:message key="global.save" /><fmt:message key="global.add" />
					</button>
					<!-- 保存退出 -->
					<button class="tsdbutton" id="save1"
						style="width: 80px; heigth: 27px;" onclick="saveObj(2);">
						<fmt:message key="global.save" /><fmt:message key="main.quit" />
					</button>
					<!-- 修改     -->
					<button class="tsdbutton" id="modify1"
						style="width: 63px; heigth: 27px;" onclick="modifyObj();">
						<fmt:message key="global.edit" />
					</button>
					<!-- 清空     -->
					<button class="tsdbutton" id="clearB1"
						style="width: 63px; heigth: 27px;"
						onclick="clearText('operformT1');">
						<fmt:message key="global.clear" />
					</button>
					<!-- 取消     -->
					<button class="tsdbutton" id="reset1"
						style="width: 63px; heigth: 27px;" onclick="resett();">
						取消
					</button>
					<!-- 关闭 	 -->
					<button class="tsdbutton" id='closeo1'
						style="width: 63px; heigth: 27px;" onclick="closeo();">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>

		<!-- 不动的部分 -->
		<div style="display: none">
			<input type="hidden" id="addinfo"
				value="<fmt:message key="global.add"/>" />
			<input type="hidden" id="deleteinfo"
				value="<fmt:message key="global.delete"/>" />
			<input type="hidden" id="editinfo"
				value="<fmt:message key="global.edit"/>" />
			<input type="hidden" id="queryinfo"
				value="<fmt:message key="global.query"/>" />
				
			<input type="hidden" id="deletebinfo" value="<fmt:message key="tariff.deleteb"/>" /><!-- 批量删除 -->
			<input type="hidden" id="modifybinfo" value="<fmt:message key="tariff.modifyb"/>" /><!-- 批量修改 -->

			<input type="hidden" id="operation"
				value="<fmt:message key="global.operation"/>" />
			<input type="hidden" id="operationtips"
				value="<fmt:message key="global.operationtips"/>" />
			<input type="hidden" id="successful"
				value="<fmt:message key="global.successful"/>" />
			<input type="hidden" id="deleteinformation"
				value="<fmt:message key="global.deleteinformation"/>" />
			<input type="hidden" id="management"
				value="<fmt:message key="ip.management"/>" />
			<input type="hidden" id="worninfo"
				value="<fmt:message key="ip.worn"/>" />
			<input type="hidden" id="worntips"
				value="<fmt:message key="ip.worntips"/>" />
			<input type="hidden" id="deletepower"
				value="<fmt:message key="global.deleteright"/>" />
			<input type="hidden" id="editpower"
				value="<fmt:message key="global.editright"/>" />

			<input type="hidden" id="deletefailed"
				value="<fmt:message key="ip.deletefailed"/>" />
			<input type="hidden" id="selectarea"
				value="<fmt:message key="ip.select"/>" />
			<input type="hidden" id="inputip"
				value="<fmt:message key="ip.inputip"/>" />
			<input type="hidden" id="selectarea"
				value="<fmt:message key="ip.selectarea"/>" />
			<input type="hidden" id="addmemo"
				value="<fmt:message key="ip.addmemo"/>" />

			<input type="hidden" id="userid" value="<%=userid%>" />
			<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
			<!-- 权限 -->

			<input type="hidden" id="addright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="editfields" />
			<input type="hidden" id="editfields_son" />
			<input type="hidden" id="delBright" />
			<input type="hidden" id="editBright" />
			<input type="hidden" id="exportright" />
			<input type="hidden" id="printright" />
			<input type="hidden" id="saveParamsright" />

			<!-- 用于写入日志 -->
			<input type="hidden" id="userloginip"
				value="<%=Log.getIpAddr(request)%>" />
			<input type="hidden" id="userloginid"
				value="<%=session.getAttribute("userid")%>" />
			<input type="hidden" id="thislogtime" value="<%=Log.getThisTime()%>" />
			<!-- 修改时保存原来数据的隐藏域 -->
			<input type="hidden" id="logoldstr" />
			<input type="hidden" id="useridd" value="<%=userid%>" />
			
			<!-- ****日志*** -->
			<input type='hidden' id='userloginip'
				value='<%=Log.getIpAddr(request)%>' />
			<input type='hidden' id='userloginid'
				value='<%=session.getAttribute("userid")%>' />
			<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
			<input type='hidden' id='logcontent' />
			<input type='hidden' id='logcondition' />
			<input type="hidden" id="conditions" value="<fmt:message key="global.conditions"/>" /><!-- 条件 -->
		
			<!-- 导航栏 -->
			<input type='hidden' id='theusergroupid' />
			<!-- 查询树信息存放 -->
			<input type="hidden" id='treepid' />
			<input type="hidden" id='treecid' />
			<input type="hidden" id='treestr' />
			<input type="hidden" id='treepic' />

			<!-- 高级查询 模板隐藏域 -->
			<input type="hidden" id="queryright" />
			<input type="hidden" id="queryMright" />
			<input type="hidden" id="saveQueryMright" />
			<!-- grid自动 -->
			<input type="hidden" id='ziduansF1' />
			<input type="hidden" id='ziduansF2' />
			<input type='hidden' id='thecolumn' />
			<input type='hidden' id='inputinfo' value='<fmt:message key="tariff.input"/>'/>
			<!-- 关键字隐藏域 -->
			<input type="hidden" id="modifyreset"/>
			<input type="hidden" id="mesall" value="<fmt:message key="pubMode.mesAll"/>" /><!-- 详细信息 -->
			
			<input type="hidden" id="oldparamsTwo"/><!-- 第二个分项卡的初始值 -->		

		</div>


		<!-- 添加模板面板 -->
		<div id="modT" style="display: none" class="neirong">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							功能名称
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="closeoMod()"><span
							style="margin-left: 5px;"><fmt:message key="global.close" />
						</span>
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form id='addquery' name="addquery" onsubmit="return false;"
					action="#">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0" style="line-height: 33px; font-size: 12px;">

						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="nameg_mod">
									<fmt:message key="oper.modName" />
								</label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="name_mod" id="name_mod"
									onpropertychange="TextUtil.NotMax(this)" maxlength="50"
									class="textclass" />
								<font style="color: #ff0000;">*</font>
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id=''></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;"></td>

							<td width="12%" align="right" class="labelclass"></td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;"></td>
						</tr>
					</table>
				</form>
				<div class="midd_butt">
					<!-- 保存 -->
					<button class="tsdbutton" id="saveModB"
						style="width: 80px; heigth: 27px;" onclick="addQuery();">
						<fmt:message key="global.save" />
					</button>
					<!-- 关闭 -->
					<button class="tsdbutton" id="closeModB"
						style="width: 63px; heigth: 27px;" onclick="closeoMod();">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>
		

		<!-- 导出数据 -->
		<div class="neirong" id="thefieldsform"
			style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							选择您要导出的数据字段
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td>
								<div id="thelistform"
									style="margin-left: 10px; max-height: 200px">

								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="query"
					onclick="checkedAllFields()">
					全选
				</button>
				<button type="submit" class="tsdbutton" id="query"
					onclick="saveExoprt();">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>

			</div>
		</div>


		<input type="hidden" id="whickOper" />
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<%
			if (!languageType.equals("en")) {
				languageType = "zh";
			}
		%>
		<input type="hidden" id="languageType" value="<%=languageType%>" />
	</body>
</html>