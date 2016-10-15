<%----------------------------------------
	name: gfrevenue.jsp 
	author: cz
	version: 1.0, 2011-03-28
	description: 公费账户缴费
	modify: 
			
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
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title>自定义发票打印</title>
	
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
	<!-- 分项卡 -->
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
	
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
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
	<!-- 验证框架需要导入的js文件 -->
	<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
  	<!-- 操作列样式 -->
	<script src="script/public/public.js" type="text/javascript"></script>
	<!-- 验证数据长度附 -->
	<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
	<script src="script/public/datalength.js" type="text/javascript"></script>
	<!-- 菜单样式 -->
	<link rel="stylesheet" href="style/css/telephone/usermanagement/single_thirteen.css" type="text/css" />
	<script language="javascript">
	$(function(){
		$("#navBar").append(genNavv());
		gobackInNavbar("navBar");
		
		fetchPaytype();
		
		//多合同号缴费面板删除事件
		$("#Ct_FeeItems").keydown(function(event){
			if(event.keyCode==46)
			{
				var vval = $("#Ct_FeeItems").val();
				if(vval != null && vval != undefined)
				{
					for(var ii=0;ii<vval.length;ii++)
					{
						$("#Ct_FeeItems").find("option[value='"+vval[ii]+"']").remove();
					}
					refreshFee();
				}
			}
		});
		$("#Ct_Yhmc").select().focus();
	});
	
	function fetchPaytype()
	{
		var res = fetchMultiArrayValue("gfdhjiaofei.paytype",6,"");
		var optHtml = "";
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii][1] + "\">" + res[ii][0] + "</option>";
			}
			$("#Ct_PayType").html(optHtml);
			$("#Ct_PayType").val("cash");
		}			
	}
	function numValid(obj)
	{		
		if($.browser.msie)
		{
			var dotPos = obj.value.indexOf(".");
			var lenAfterDot;
			
			if(dotPos==-1)
			{
				lenAfterDot = 0;
			}
			else
			{
				lenAfterDot = obj.value.length - dotPos -1;
			}
			
			var evt = window.event;
			if (evt.keyCode < 48 || evt.keyCode > 57)
			{
				if(evt.keyCode==46)
				{
					if(dotPos==-1)
						lenAfterDot=0;
					else
						evt.returnValue = false;
				}
				else
				{
					evt.returnValue = false;
				}
			}
			else
			{
				if(dotPos!=-1)
				{
					if(lenAfterDot>=2)
					{
						evt.returnValue = false;
					}
				}
			}
		}
		else
		{
			obj.value=obj.value.replace(/[^0-9]/g,'');
		}
	}
	
	function getGlobalVar()
	{
		var iio = 1;
		return function(){
			return iio++;
		}
	}
	var getGlobalVarc = getGlobalVar();
	
	function feeitemAdd()
	{
		var feeitem = $.trim($("#Ct_FeeItem").val());
		var itemfee = $("#Ct_Fee").val();
		
		if(feeitem=="")
		{
			alert("请输入费用项目");
			$("#Ct_FeeItem").select().focus();
			return false;
		}
		if(itemfee=="")
		{
			alert("请输入正确的费用格式");
			$("#Ct_Fee").select().focus();
			return false;
		}
		if(isNaN(parseFloat(itemfee)))
		{
			alert("请输入正确的费用格式");
			$("#Ct_Fee").select().focus();
			return false;
		}
		$("#Ct_FeeItems").append("<option value=\"opt_"+getGlobalVarc()+"\" feename=\""+feeitem+"\" fee=\""+itemfee+"\">"+feeitem + "：" + itemfee +" 元</option>");
		//alert($("#Ct_FeeItems").html());
		refreshFee();
		$("#Ct_FeeItem,#Ct_Fee").val("");
	}
	//刷新费用金额
	function refreshFee()
	{
		var feeall = 0;
		$("#Ct_FeeItems").find("option").each(function(){
			var tmp = parseFloat($(this).attr("fee"));
			if(isNaN(tmp))
				tmp = 0;
			feeall = feeall + tmp;
		});
		$("#currentfee").html(feeall);
	}
	
	//删除数据
	function feeitemDrop()
	{
		var vval = $("#Ct_FeeItems").val();
		if(vval != null && vval != undefined)
		{
			for(var ii=0;ii<vval.length;ii++)
			{
				$("#Ct_FeeItems").find("option[value='"+vval[ii]+"']").remove();
			}
			refreshFee();
		}
		else
			alert("请选择要删除的费用项");
	}
	// 保存自定义发票数据
	function feeitemSave()
	{
		var yhmc = $.trim($("#Ct_Yhmc").val());
		/*if(yhmc=="")
		{
			alert("请输入用户姓名");
			$("#Ct_Yhmc").select().focus();
			return false;
		}*/
		var dh = $.trim($("#Ct_Dh").val());
		/*if(dh=="")
		{
			alert("请输入电话号码");
			$("#Ct_Dh").select().focus();
			return false;
		}*/
		
		if($.trim(yhmc)=="" && $.trim(dh)=="")
		{
			alert("请输入用户姓名或者电话号码中的至少一项");
			$("#Ct_Yhmc").select().focus();
			return;
		}
		
		var feecollect = [];
		var feecollect_tosave = [];
		var fee = 0;
		$("#Ct_FeeItems option").each(function(){
			feecollect.push($(this).text());
			feecollect_tosave.push([$(this).attr("feename"),$(this).attr("fee")]);
			fee += parseFloat($(this).attr("fee"));
		});
		//alert(feecollect.join(","));
		//alert(fee);
		if(feecollect.length<1)
		{
			alert("请添加费用项目");
			$("#Ct_FeeItem").select().focus();
			return false;
		}
		var nid = fetchSingleValue("selfconfigreport.fetchid",6,"");
		if(nid=="" || nid==undefined)
		{
			alert("保存数据失败");
			return;
		}
		var params = "&id=" + nid + "&dh=" + tsd.encodeURIComponent(dh);
		params += "&yhmc=" + tsd.encodeURIComponent(yhmc);
		params += "&skrid=" + tsd.encodeURIComponent($("#skrid").val());
		params += "&area=" + tsd.encodeURIComponent($("#area").val());
		params += "&pay_flag=" +  tsd.encodeURIComponent($("#Ct_PayType").val());
		params += "&feeitems=" + encodeURIComponent(feecollect.join(", "));
		var res = executeNoQuery("selfconfigreport.add",6,params);
		var xitemsuccess = true;
		var xitemtemp = true;
		if(res=="true" || res==true)
		{
			for(var k=0;k<feecollect_tosave.length;k++)
			{
				xitemtemp = executeNoQuery("selfconfigreport.addfeeitem",6,"&id=" + nid + "&feeitem=" + encodeURIComponent(feecollect_tosave[k][0]) + "&fee=" + feecollect_tosave[k][1]);
				if(xitemtemp=="false" || xitemtemp==false)
				{
					xitemsuccess = false;
					break;
				}
			}
			if(xitemsuccess==true)
			{
				executeNoQuery("selfconfigreport.calfee",6,"&id=" + nid);
				alert("自定义数据保存成功,等待打印发票");
				var loginfo = tsd.encodeURIComponent("自定义发票");
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("电话号码：");
				loginfo += ":";
				loginfo += tsd.encodeURIComponent(dh);
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("用户姓名：");
				loginfo += ":";
				loginfo += tsd.encodeURIComponent(yhmc);
				loginfo += ";";
				loginfo += tsd.encodeURIComponent("编号");
				loginfo += ":" + nid;
				writeLogInfo("","add",loginfo);
				/*
				printThisReport1('<%=request.getParameter("imenuid")%>',
					'selfconfigreport',"&pid=" + nid,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);*/
				printWithoutPreview("commonreport/selfconfigreport","pid_" + nid);
				clearPage();
			}
			else
			{
				executeNoQuery("selfconfigreport.drop",6,"&id=" + nid);
				alert("数据保存失败");
			}
		}
		else
		{
			alert("保存失败");
		}
	}
	
	function clearPage()
	{
		$('#currentfee').text('');
		$("#Ct_Yhmc,#Ct_Dh,#Ct_FeeItem,#Ct_Fee").val("");
		$("#Ct_PayType").val("cash");
		$("#Ct_FeeItems option").remove();
		$("#Ct_Yhmc").select().focus();
	}
	</script>
	<style type="text/css">
		.tsdbutton{margin:2px;padding:2px 18px 2px 18px;height:24px;margin-bottom:0px;}
		.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/imgs/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
		.inputbox{{margin-left:2px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		td{padding-left:3px;padding-top:3px;font-size:13px;line-height:20px;}/* songxiaofei 修改 2012-09-18*/
		input{width:80px; height:18px;line-height:18px;display:inline;}/* songxiaofei 修改 2012-09-18*/
	</style>
  </head>
  
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
	
	<table style="margin-left:5px;margin-top:5px;"border="0"><!-- songxiaofei 修改 -->
		<tr>
			<td>用户姓名：</td><td><input type="text" name="Ct_Yhmc" id="Ct_Yhmc" class="inputbox"  /></td>
			<td>电话号码：</td><td><input type="text" name="Ct_Dh" id="Ct_Dh" class="inputbox"   /></td>
		</tr>
		<!--  <tr>
			<td>电话号码：</td><td><input type="text" name="Ct_Dh" id="Ct_Dh" class="inputbox" maxlength="50" style="width:336px;" /></td>
		</tr>-->
		<tr>
			<td>付费方式：</td><td><select name="Ct_PayType" id="Ct_PayType" class="inputbox" ></select></td>
			<td>费用名称：</td><td><input type="text" name="Ct_FeeItem" id="Ct_FeeItem" class="inputbox" /></td>
		</tr>
		<tr>
			<!-- songxiaofei 修改 -->
			<td>费用金额：</td><td  colspan="3"><input type="text" name="Ct_Fee" id="Ct_Fee" class="inputbox" style="" onkeypress="numValid(this)" /></td>
		</tr>
		<tr>
			<!-- songxiaofei 修改 -->
			<td colspan="4">
				费用项目列表：(<span style="font-size:12px;color:#f00;">选中要删除的费用项，按Delete键删除</span>)
			</td>
		</tr>
		<tr>
			<!-- songxiaofei 修改 -->
			<td colspan="4">
				<select name="Ct_FeeItems" id="Ct_FeeItems"  multiple="multiple" style="width:520px;font-size: 13px;height:200px;border:1px solid #ccc;"></select>
			</td>
		</tr>
		<tr>
			<!-- songxiaofei 修改 -->
			<td colspan="4">当前已添加费用金额：<span id="currentfee" style="color:red;font-weight:bold;border-bottom:2px solid #000;">0</span><span> 元 </span></td>
		</tr>
		<tr>
		<!-- songxiaofei 修改 -->
			<td colspan="4">
				<button class="tsdbutton" onclick="feeitemAdd()">添加</button>
				<button class="tsdbutton" onclick="feeitemDrop()">删除</button>
				<button class="tsdbutton" onclick="feeitemSave()">保存票据</button>
			</td>
		</tr>
	</table>
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />

	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType%>' />
		
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
	<iframe id="printReportDirect" style="width: 120px; height: 0px; visibility: visible" src="print.jsp"></iframe>
  </body>
</html>
