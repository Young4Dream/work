<%----------------------------------------
	name: gfdetail.jsp 
	author: cz
	version: 1.0, 2011-04-26
	description: 话费月收入汇总
	modify: 
		2011-03-28  cz  添加报表
			
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
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title> </title>
	
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
		/**
		 * 初始化
		 * @param 无参数
		 * @return 无返回值
		 */
		$(function(){
			$("#navBar").append(genNavv());
			gobackInNavbar("navBar");
			
			fetchHzyf();
			//setUserRight();
			$("#queryparam td:even").css({"background-color":"#c9d4ea","text-align":"right","padding-right":"1em"});			
			$("#dhorhth").select().focus();
			//费用项名称
			hfcols = fetchMultiArrayValue("hfmxquery.feefl",6,"");
		});
		var hfcols = null;
		function ghSearch()
		{
			//清空数据
			$("#feedetailcontainer").html("");
			
			if($.trim($("#dhorhth").val())=="")
			{
				alert("请输入要查询的电话号码或合同号");
				$("#dhorhth").select().focus();
				return;
			}
			
			if($("#rd_commonuser").attr("checked"))
			{
				var dhorhth = fetchMultiArrayValue("hfmxquery.fetchHth",6,"&hthdh=" + $("#dhorhth").val() + "&hzyf=" + $("#hzyf").val());
				//alert(dhorhth);
				if(dhorhth[0]==undefined || dhorhth[0][0]==undefined)
				{
					alert("当前输入条件没有费用信息");
					return;
				}
				var ssel = $("#ptype_rd_commonuser").val();
				var qtable = (ssel=="1"?"huizong":"hthhf");
				//var hfdata = fetchMultiArrayValue("hfmxquery.feedetail",6,"&tablename=" + qtable + "&dhorhthfl=" + (ssel=="1"?"dh":"hth") 
				//         + "&dhorhth=" + (ssel=="1"?(dhorhth[0][1]==""?"000":dhorhth[0][1]):dhorhth[0][0]) + "&hzyf=" + $("#hzyf").val());
				//alert(hfdata);
				var urlMm = tsd.buildParams({ packgname:'service',
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:"tsdBilling",
					tsdcf:'mssql',//指向配置文件名称
					tsdoper:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpk:"hfmxquery.feedetail"
				});
			
				$.ajax({
					url:"mainServlet.html?" + urlMm + "&tablename=" + qtable + "&dhorhthfl=" + (ssel=="1"?"dh":"hth") 
				         + "&dhorhth=" + (ssel=="1"?(dhorhth[0][1]==""?"000":dhorhth[0][1]):dhorhth[0][0]) + "&hzyf=" + $("#hzyf").val(),
					async:true,
					cache:false,
					timeout:200000,
					type:'post',
					success:function(xml){
						//alert($(xml).find("row:first").attr("hth"));
						procedureHfTable($(xml).find("row:first"),ssel);
						
						$(".feedetail tr:gt(0) td:even").css({"text-align":"center"});
					}
				});
			}
			else
			{
				var ssel = $("#ptype_rd_biguser").val();
				//var qtable = (ssel=="1"?"huizong":"hthhf");
				//var hfdata = fetchMultiArrayValue("hfmxquery.feedetail",6,"&tablename=" + qtable + "&dhorhthfl=" + (ssel=="1"?"dh":"hth") 
				//         + "&dhorhth=" + (ssel=="1"?(dhorhth[0][1]==""?"000":dhorhth[0][1]):dhorhth[0][0]) + "&hzyf=" + $("#hzyf").val());
				//alert(hfdata);
				var urlMm = tsd.buildParams({ packgname:'service',
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:"tsdBilling",
					tsdcf:'mssql',//指向配置文件名称
					tsdoper:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpk:(ssel=="3"?"hfmxquery.feebighth":(ssel=="4"?"hfmxquery.feebighthhthdetail":"hfmxquery.feebighthdhdetail"))
				});
			
				$.ajax({
					url:"mainServlet.html?" + urlMm + "&hth=" + $("#dhorhth").val() + "&hzyf=" + $("#hzyf").val(),
					async:true,
					cache:false,
					timeout:200000,
					type:'post',
					success:function(xml){
						
						//alert($(xml).find("row:first").attr("hth"));
						$(xml).find("row").each(function(){
							procedureHfTable($(this),ssel);
						});
						//删除没有费用的记录
						$(".feedetail").each(function(){
							if($(this).find("tr").size()==1)
							{
								$(this).remove();
							}
						});
						if($(".feedetail").size()>0 && (ssel==4 || ssel==5))
							$("#feedetailcontainer").prepend("<table style=\"margin-left:auto;margin-right:auto;margin-top:20px;\"><tr><td colspan=\"2\">共 "+$(".feedetail").size()+" 用户</td></tr></table>");
						$(".feedetail").each(function(){
							$(this).find("tr:gt(0) td:even").css({"text-align":"center"});
						});
					}
				});
			}
			//$(".feedetail tr:gt(1) td:even").css({"text-align":"center"});
			
		}
		//生成费用表格
		function procedureHfTable(data,xtype)
		{
			if($(data).attr("btheji")==undefined || $(data).attr("btheji")=="")
			{
				alert("当前输入条件没有费用信息");
				$("#dhorhth").select().focus();
				return;
			}
			var tabHtml = "<table class=\"feedetail\">";
			var hfdata = $(data);
			
			if(xtype==1)
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">电话号码：" + $(hfdata).attr("dh") + " 合同号：" + $(hfdata).attr("hth") + " " + $(hfdata).attr("yhmc") + " 汇总月份：" + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			else if(xtype==2)
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">合同号：" + $(hfdata).attr("hth") + " " + $(hfdata).attr("yhmc") + " 汇总月份：" + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			else if(xtype=="3")
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">大客户 " + $("#dhorhth").val() + " 汇总月份 " + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			else if(xtype=="4")
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">合同号：" + $(hfdata).attr("hth") + " " + $(hfdata).attr("yhmc") + " 汇总月份：" + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			else if(xtype=="5")
			{
				tabHtml += "<tr>";
				tabHtml += "<td colspan=\"2\" style=\"text-align:center\">用户：" + $(hfdata).attr("dh") + " " + $(hfdata).attr("yhmc") + " 汇总月份：" + $("#hzyf").val() +" 的费用清单</td>";
				tabHtml += "</tr>";
			}
			
			for(var ii=0;ii<hfcols.length;ii++)
			{
				alert(hfcols[ii][0]);
				alert(hfcols[ii][1]);
				if($(hfdata).attr(hfcols[ii][0].toLowerCase())!="0")
				{
					if(getCaption(hfcols[ii][1],$("#lanType").val(),hfcols[ii][1])=='月固定费'){	
					}else{
						tabHtml += "<tr>";
						tabHtml += "<td width=\"30%\">" + getCaption(hfcols[ii][1],$("#lanType").val(),hfcols[ii][1]) + "</td>";
						tabHtml += "<td>" + $(hfdata).attr(hfcols[ii][0].toLowerCase()) + "</td>";
						tabHtml += "</tr>";
					}
					
				}
			}
			//查询代缴和daijiaofor
			if($("#rd_commonuser").attr("checked")==true && $("#ptype_rd_commonuser").val()=="2")
			{
				if($(hfdata).attr("Daijiao".toLowerCase())!="0")
				{
					tabHtml += "<tr>";
					tabHtml += "<td width=\"30%\">它方代缴</td>";
					tabHtml += "<td>" + $(hfdata).attr("Daijiao".toLowerCase()) + "</td>";
					tabHtml += "</tr>";
				}
				if($(hfdata).attr("DaijiaoFor".toLowerCase())!="0")
				{
					tabHtml += "<tr>";
					tabHtml += "<td width=\"30%\">代缴</td>";
					tabHtml += "<td>" + $(hfdata).attr("DaijiaoFor".toLowerCase()) + "</td>";
					tabHtml += "</tr>";
				}
			}
			if($(hfdata).attr("btheji")!="0")
			{
				tabHtml += "<tr>";
				tabHtml += "<td width=\"30%\">共计</td>";
				tabHtml += "<td>" + $(hfdata).attr("btheji") + "</td>";
				tabHtml += "</tr>";
			}
			tabHtml += "</table>";
			
			$("#feedetailcontainer").append(tabHtml);
		}
		
		//普通用户集团用户切换事件
		function chgType(obj)
		{
			$("select[id^='ptype']").hide();
			$("#ptype_" + obj.id).show();
		}
		//取扣费月份
		function fetchHzyf()
		{
			var res = fetchMultiValue("ghdhdetail.hzyf",6,"");
			var optHtml = "";
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii] + "\">" + res[ii] + "</option>";
			}
			$("#hzyf").html(optHtml);
			var curhzyf = fetchSingleValue("ghdhdetail.nowmonth",6,"");
			if(curhzyf!="")
			{
				$("#hzyf").val(curhzyf);
			}
		}
		var hkey_root,hkey_path,hkey_key;
    	hkey_root="HKEY_CURRENT_USER";
    	hkey_path="\\Software\\Microsoft\\Internet Explorer\\PageSetup\\";
		
		//配置网页打印的页眉页脚为空
		function pagesetup_null(){   
			try{
				var RegWsh = new ActiveXObject("WScript.Shell");           
				hkey_key="header";           
				RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
				hkey_key="footer";
				RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"");
				//&b 第&p页/共&P页 &b
			}catch(e){}
		}
		//配置网页打印的页眉页脚为默认值
		function pagesetup_default(){
			try{
				var RegWsh = new ActiveXObject("WScript.Shell");
				hkey_key="header";
				RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"&w&b页码，&p/&P")
				hkey_key="footer";
				RegWsh.RegWrite(hkey_root+hkey_path+hkey_key,"&u&b&d");
			}catch(e){}
		}
		</script>
		<style type="text/css" media="screen">
		.tsdbutton{margin:2px;padding:0px 10px 5px 10px;height:24px;line-height:24px;margin-bottom:-2px;}
		.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/imgs/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
		.inputbox{{margin-left:10px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		#queryparam{border:#7691c7 1px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:60px;}
		#queryparam td{line-height:28px;border:#7691c7 1px solid;}
		
		.feedetail{border:#7691c7 1px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:20px;}
		.feedetail td{line-height:28px;border:#7691c7 1px solid;}
		
		#hzyf,#ptype_rd_commonuser,#ptype_rd_biguser{margin-left:10px;}
		#feedetailcontainer{width:600px;margin:auto;}
		</style>
		<style type="text/css" media="print">
		#queryparam,#navBar{display:none;}
		#feedetailcontainer{margin-left:20px;}
		.feedetail{border:#7691c7 0px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:20px;}
		.feedetail td{line-height:28px;border:#7691c7 0px solid;}
		</style>
  </head>
  
  <body>
	
	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
		
	<table id="queryparam">
		<tr>
			<td width="25%">电话或合同号</td>
			<td>
				<input type="text" id="dhorhth" name="dhorhth" class="inputbox" />
				<label><input type="radio" id="rd_commonuser" name="rd_user" checked onclick="chgType(this)" />普通用户</label>
				<label><input type="radio" id="rd_biguser" name="rd_user" onclick="chgType(this)" />集团用户</label>
			</td>
		</tr>
		<tr>
			<td width="25%">汇总月份</td><td><select name="hzyf" id="hzyf" /></td>
		</tr>
		<tr>
			<td width="25%">操作</td>
			<td>
				<select id="ptype_rd_commonuser">
					<option value="1">按用户</option>
					<option value="2">按账号</option>
				</select>
				<select id="ptype_rd_biguser" style="display:none">
					<option value="3">按集团账户</option>
					<option value="4">按集团子账户</option>
					<option value="5">按用户</option>
				</select>
				<button class="tsdbutton" onclick="ghSearch()">查询</button>
				<button class="tsdbutton" onclick="pagesetup_null();window.print()">打印</button>
			</td>
		</tr>
	</table>
	<div id="feedetailcontainer">
		
	</div>
	<!-- <table class="feedetail"></table> -->
	
	<input type="hidden" name="skrid" id="skrid" value="<%=session.getAttribute("userid") %>"/>
  	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
  	
  	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType%>' />
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
	
	<input type="hidden" id="ableForOtherArea" name="ableForOtherArea" value="false" />
  </body>
</html>