<%----------------------------------------
	name: revenue.jsp
	author: chenze
	version: 1.0, 2010-11-3
	description: 
	modify: 
			2010-12-14：霍帅   打印方法改为通用方法"printThisReport1(...)"
			2011-01-13  chenze  增加多合同号缴费
			2011-01-20  chenze  增加电话宽带页面分享，多合同号设计调整
			2011-02-11  chenze  修正页面快捷方式（Ctrl+Alt），用户信息表格显示等功能模块FireFox兼容性问题，分离电话功能禁用选项和电话缴费功能禁用选项
			2011-02-25  cz      增加rev_bill.jsp票据配置方式，修正多合同号缴费时大客户号处理
			2011-02-28  cz      添加缴费金额限制，是否可以多收，少收
			2011-03-02  cz      修正查询之后页面票据显示对多合同号记录处理问题,增加多合同号缴费明细显示
			2011-03-27  cz      增加参数配置 大客户账号共用一个流水号
---------------------------------------------%>


<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String theTime=Log.getThisTime(); 
	String area = (String) session.getAttribute("chargearea");
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
		<title>
			<!-- 收费结帐 -->
			<fmt:message key="Revenue.chargeCheckout" />
		</title>

		<!-- 导入的js文件 -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script src="style/js/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<script type="text/javascript" src="css/tree/dtree.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 导入js文件结束 -->
		<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

		<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
		<!-- 导入css文件结束 -->

		<style type="text/css">
#chooseBox {
	padding-bottom: 30px;
}

#chooseForJF,#chooseForFJ {
	width: 80px;
}

.tsdbutton {
	margin: 2px;
	padding: 2px 18px 2px 18px;
	height: 24px;
}

.tsdbtn {
	line-height: 28px;
	padding: 2px 12px 2px 12px;
	height: 28px;
	margin-top: 4px;
	margin-left: 5px;
	background: url(style/images/public/buttonbg.jpg) repeat-x;
	border: #CCCCCC 1px solid;
	cursor: pointer;
}

label {
	float: left;
	text-align: left;
	margin-left: 10px;
	width: 80px;
	line-height: 28px;
}

.inputbox { {
	margin-left: 20px;
	background: url(style/images/public/inputText_bg.jpg) repeat-x;
	width: 180px;
	border: #999999 solid 1px;
	text-align: left;
	color: #000000;
	font-size: 12px;
	font-weight: bold;
	height: 22px;
	line-height: 23px;
}

}
#kdBar p {
	clear: both;
	padding-left: 10px;
}

/*宽带票据*/
#kdFP,#ghFP {
	padding-top: 30px;
	padding-bottom: 10px;
	padding-left: 10px;
}

#ghFP {
	padding-top: 18px;
}
#multiHthDetail,#commonHthYfDetail{
	display:none;
}

#multiHthDetail h6,#commonHthYfDetail h6{
	cursor:pointer;
}

#multiHthDetail td,#commonHthYfDetail td{
	background-color: #ffffff;
	line-height: 22px;
}

#kdInfo,.ghInfo {
	text-align: left;
	border: #eeeeee 1px solid;
}

#kdInfo td,.ghInfo td{
	background-color: #ffffff;
	line-height: 22px;
}

#kduserInfoPanelTabRight table,#kduserInfoPanelTabRight,#kduserInfoPanelTab {
	text-align: left;
	border: #eeeeee 1px solid;
}

#kduserInfoPanelTabRight table td,#kduserInfoPanelTabRight td,#kduserInfoPanelTab td {
	background-color: #ffffff;
	line-height: 22px;
}

.bolder {
	font-weight: bold;
}

#kduiJf,#kduiJob,#kduiGNB,#kduiTZ,#kduiKF,#kduiXX {
	cursor: pointer;
}

#ghuserInfoPanelTabRight table,#ghuserInfoPanelTabRight,#ghuserInfoPanelTab {
	text-align: left;
	border: #eeeeee 1px solid;
}

#ghuserInfoPanelTabRight table td,#ghuserInfoPanelTabRight td,#ghuserInfoPanelTab td {
	background-color: #ffffff;
	line-height: 22px;
}

#ghuiJf,#ghuiJob,#ghuiGNB,#ghuiCTC,#ghuiKF,#ghuiLTC,#ghuiGDF {
	cursor: pointer;
}

#kdStatus {
	padding-left: 10px;
}

#ghInfoTitle {
	text-align: center;
	width: 620px;
	height: 28px;
	font-weight: bold;
	font-size: 16px;
	line-height: 18px;
}

#ghYHYE,#ghYHYE span {
	color: #F00;
	font-size:14px;
}

.neirong .midd #grid table {
	line-height: 18px;
}

#bu_muser a {
	font-weight: bold;
}

#ghbu_muser a {
	font-weight: bold;
}

.btns,#kdButtons,#ghButtons {
	width: 100%;
	float: left; *
	float: none;
	height: 36px;
	background: url(style/images/public/buttonsbg.jpg) repeat-x;
	border-top: #CCCCCC 1px solid;
	border-bottom: #CCCCCC 1px solid;
}
.ghHthDrpt{
	width:90px;
}
#ghMultiHthDetTab_Container{
	max-height:156px;
	width:750px;
	overflow-y:auto;
}
#ghMultiHthDetTab td{
	width:110px;
	height:20px;
}
#ghMultiHthDetTab td input{
	display:inline-block;float:left;
}
#ghMultiHthDetTab td span{
	line-height:12px;height:12px;display:inline-block;width:100px;cursor:pointer;
	*height:22px;*line-height:20px;  /*FF Hack*/
}
#ghuserInfoPanelTab .spanC{
	text-align: right;
	padding-right:4px;
	background-color: #eeeDDe;
}
#ghuserInfoPanelTab .inputC{
	text-align: left;
	padding-left:2px;
}

.hidePayType{
	display:none;
}

.ghInfo td{line-height:27px;}
.center{text-align:center;}
.right{
	text-align:right;
}
</style>
	<script type="text/javascript" language="javascript">
	
	//弹窗状态
	var popupStatus = 0;
	
	var Clerks = "";
	//Phone Broadband限制
	var Sys_Config = "";
	var PrintConfig = "";
	//var BillAllocMapping = {"固话缴费":"ghInfoJF","固话预存":"ghInfoYC","灵通缴费":"ghInfoLTJF","灵通预存":"ghInfoLTYC","退费":"ghInfoTFF"};
	
	//页面加载
	$(function(){
		
		pageLoad();
		
		getidtype();//设置证件类型
	});
	//页面加载
	function pageLoad()
	{
		initialBar();
		pConfig();
		tsd.tsdtip();
		setUserRight();
		
		//初始化营业员信息
		Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
		PrintConfig = fetchMultiKVValue("Revenue.NConfig",6,"",["tident","tvalues"]);
				
		bindEventGlobal();
		bindEventToKd();
		
		bindEventToGh();
		
		//解锁账号
		kdunLock();
		bindToUnload();
		//固话输入框聚集
		if($("#forbid").val()!="Y")
		{
			$("#ghSearchBox").select().focus();
		}
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		$("#kduserInfoPanel td[title]").live("click",function(){
			if($(this).parent("tr").next().attr("clickreturntr")=="clickreturntr"){
				$(this).parent("tr").next().remove();
			}
			else
			{
				var tdsize = $(this).parent("tr").find("td").size();
				$(this).parent("tr").after("<tr clickreturntr=\"clickreturntr\"><td colspan=\""+tdsize+"\" style=\"color:#F00;\">"+$(this).attr("title")+"</td></tr>");
			}
		});
		$("#kdInfoStatus").click(function(){
			if($(this).attr("title")==undefined) return;
			if($(this).parent().parent("tr").next().attr("clickreturntr")=="clickreturntr"){
				$(this).parent().parent("tr").next().remove();
			}
			else
			{
				var tdsize = $(this).parent().parent("tr").find("td").size();
				$(this).parent().parent("tr").after("<tr clickreturntr=\"clickreturntr\"><td colspan=\""+tdsize+"\" style=\"color:#F00;\">"+$(this).attr("title")+"</td></tr>");
			}
		});
		//多合同号详细
		$("#multiHthDetail h6").toggle(function(){
			$("#multiHthDetailTab").show();
		},function(){
			$("#multiHthDetailTab").hide();
		});
		
		$("#commonHthYfDetail h6").toggle(function(){
			$("#commonHthYfDetailTab").show();
		},function(){
			$("#commonHthYfDetailTab").hide();
		});
		//临时修改为默认电话缴费
		$("#chooseForJF,#chooseForFJ").val("电话费").trigger("change");
		//$("#chooseForJF,#chooseForFJ").val("电话费").trigger("change").attr("disabled","disabled");
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	}
	//初始化导航栏
	function initialBar()
	{
		$("#navBar").append(genNavv());
		
		gobackInNavbar("navBar");
		
		if($.browser.mozilla)
		{
		}
	}
	///设置权限
	function setUserRight()
	{
		var allRi = fetchMultiPValue("Duty.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			$("#ableTuiFeiEJ").val("false");
			$("#dhyhlbpub").val('false');	//判断是否拥有受理办公用户缴费权限 true：为有权限 false为无权限 
			$("#ghUnpaymentPrint").hide();
			return false;
		}
		if(allRi[0][0]=="all")
		{
			$("#ableTuiFeiEJ").val('true');	
			$("#dhyhlbpub").val('true');
			$("#ghUnpaymentPrint").show();
			return true;
		}
		var Interregional = 'false';
		var dhyhlbpubrigth = 'false';
		var ableForBigHth = "false";
		var UnpaymentRigth = "false";
		
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'ableTuiFeiEJ','')=="true"){
				Interregional = 'true';	
			}
			if(getCaption(allRi[i][0],'dhyhlbpub','')=="true"){
				dhyhlbpubrigth = 'true';
			}
			if(getCaption(allRi[i][0],'ableForBigHth','')=="true"){
				ableForBigHth = 'true';
			}
			if(getCaption(allRi[i][0],'unpaymentRigth','')=="true"){
				UnpaymentRigth = 'true';
			}
			//默认为直接打印票据，如果有高级权限设置，则覆盖tsd_ini配置
			var chooseprint = getCaption(allRi[i][0],'choosePrint','N');
			if(chooseprint=="Y" || chooseprint=="O"){
				PrintConfig["ChoosePrint"] = chooseprint;
			}
		}
		if(ableForBigHth=="false"){
			$("#ghMultiHth").hide();
		}
		if(UnpaymentRigth=="false"){
			$("#ghUnpaymentPrint").hide();
		}
		
		$("#ableTuiFeiEJ").val(Interregional);
		$("#dhyhlbpub").val(dhyhlbpubrigth);
		$("#ableForBigHth").val(Interregional);
	}
	
	function bindToUnload()
	{
		$(window).unload(function(){
			kdunLock();
		});
	}
	////事件绑定
	function bindEventGlobal()
	{
		$("#chooseForJF,#chooseForFJ").change(function(){
			refreshState($(this));
		});
		
		$(document).keydown(function(event){
			//查询面板状态
			var panelStatus = $("#multiSearch").css("display");
			//用户名查找面板
			var userpanelStatus = $("#ghSearch").css("display");
			//宽带用户信息面板
			var kduserInfoPanelStatus = $("#kduserInfoPanel").css("display");
			//宽带缴费票据打印面板
			var choosePrintStatus = $("#choosePrint").css("display");
			//宽带退费票据打印面板
			var choosePrintForTuiFeiStatus = $("#choosePrintForTuiFei").css("display");
			//电话缴费余额分配面板
			var ghHfDistributionFormStatus = $("#ghHfDistributionForm").css("display");
			//电话用户信息面板
			var ghuserInfoPanelStatus = $("#ghuserInfoPanel").css("display");
			
			if(panelStatus == "block")
			{
				var idx = $("#bu_muser").getGridParam("selrow");
				idx = parseInt(idx,10);
				var len = $("#bu_muser").getDataIDs().length;
				
				//电话
				var ghidx = $("#ghbu_muser").getGridParam("selrow");
				ghidx = parseInt(idx,10);
				var ghlen = $("#ghbu_muser").getDataIDs().length;
				
				if(event.keyCode==40)
				{
					if(idx==null||isNaN(idx))
					{
						$("#bu_muser").setSelection("1");
					}
					else
					{
						$("#bu_muser").setSelection(idx+1);
					}
					
					if(ghidx==null||isNaN(ghidx))
					{
						$("#ghbu_muser").setSelection("1");
					}
					else
					{
						$("#ghbu_muser").setSelection(idx+1);
					}
				}
				else if(event.keyCode==38)
				{
					if(idx==null||isNaN(idx))
					{
						$("#bu_muser").setSelection(len);
					}
					else
					{
						$("#bu_muser").setSelection(idx-1);
					}
					
					if(ghidx==null||isNaN(ghidx))
					{
						$("#ghbu_muser").setSelection(len);
					}
					else
					{
						$("#ghbu_muser").setSelection(idx-1);
					}
				}
				else if(event.keyCode==37)
				{
					$("#bu_pager #prev").click();
					$("#ghbu_pager #prev").click();
				}
				else if(event.keyCode==39)
				{
					$("#bu_pager #next").click();
					$("#ghbu_pager #next").click();
				}
				else if(event.keyCode==27)
				{
					$("#kdMultiSearchClose").click();
					$("#ghMultiSearchClose").click();
				}
				else if(event.keyCode==13)
				{
					if(idx==null||isNaN(idx)||idx==undefined)
					{
					}
					else
					{
						userChoose($("#bu_muser").getCell(idx,"UserName"),$("#bu_muser").getCell(idx,"sDh"),$("#bu_muser").getCell(idx,"sRealName"));
					}
					
					if(ghidx==null||isNaN(ghidx)||ghidx==undefined)
					{
					}
					else
					{
						userChoose($("#ghbu_muser").getCell(idx,"UserName"),$("#ghbu_muser").getCell(idx,"sDh"),$("#ghbu_muser").getCell(idx,"sRealName"));
					}
				}
			}
			else if(userpanelStatus == "block")
			{
				var idx = $("#bu_muser").getGridParam("selrow");
				idx = parseInt(idx,10);
				var len = $("#bu_muser").getDataIDs().length;
				
				//电话
				var idx = $("#bu_muser").getGridParam("selrow");
				idx = parseInt(idx,10);
				var len = $("#bu_muser").getDataIDs().length;
				
				if(event.keyCode==40)
				{
					if(idx==null||isNaN(idx))
					{
						$("#bu_muser").setSelection("1");
					}
					else
					{
						$("#bu_muser").setSelection(idx+1);
					}
					
					if(ghidx==null||isNaN(ghidx))
					{
						$("#ghbu_muser").setSelection("1");
					}
					else
					{
						$("#ghbu_muser").setSelection(ghidx+1);
					}
				}
				else if(event.keyCode==38)
				{
					if(idx==null||isNaN(idx))
					{
						$("#bu_muser").setSelection(len);
					}
					else
					{
						$("#bu_muser").setSelection(idx-1);
					}
					
					if(ghidx==null||isNaN(ghidx))
					{
						$("#ghbu_muser").setSelection(ghlen);
					}
					else
					{
						$("#ghbu_muser").setSelection(ghidx-1);
					}
				}
				else if(event.keyCode==37)
				{
					$("#bu_pager #prev").click();
					$("#ghbu_pager #prev").click();
				}
				else if(event.keyCode==39)
				{
					$("#bu_pager #next").click();
					$("#ghbu_pager #next").click();
				}
				else if(event.keyCode==27)
				{
					$("#kdMultiSearchClose").click();
					$("#ghMultiSearchClose").click();
				}
				else if(event.keyCode==13)
				{
					if(idx==null||isNaN(idx)||idx==undefined)
					{
					}
					else
					{
						userChoose($("#bu_muser").getCell(idx,"UserName"),$("#bu_muser").getCell(idx,"sDh"),$("#bu_muser").getCell(idx,"sRealName"));
					}
					
					if(ghidx==null||isNaN(ghidx)||ghidx==undefined)
					{
					}
					else
					{
						userChoose($("#ghbu_muser").getCell(idx,"UserName"),$("#ghbu_muser").getCell(idx,"sDh"),$("#ghbu_muser").getCell(idx,"sRealName"));
					}
				}
			}
			else if(kduserInfoPanelStatus == "block")
			{
				//TO-DO Something when kduserInfoPanel is shown
			}
			else if(choosePrintStatus == "block")
			{
				//TO-DO Something when choosePrint is shown
			}
			else if(choosePrintForTuiFeiStatus == "block")
			{
				//TO-DO Something when choosePrintForTuiFei is shown
			}
			else if(ghHfDistributionFormStatus == "block")
			{
				//TO-DO Something when ghHfDistributionForm is shown
			}
			else if(ghuserInfoPanelStatus == "block")
			{
				//TO-DO Something when kduserInfoPanel is shown
			}
			else
			{
				//没有弹出面板的情况下
				//if($.browser.msie)
				//{
					if(event.altKey && event.ctrlKey)
					{
						//如果当前是电话缴费页面，则切换至宽带缴费
						if($("#gh").css("display")=="block" && Sys_Config["Broadband"]!="Y")
						{
							$("#gh").css("display","none");
							$("#kd").css("display","block");
							
							$("#kdSearchBox").select().focus();
							$("#chooseForJF,#chooseForFJ").val("宽带费");
						}//如果当前是宽带缴费页面，则切换至电话缴费
						else if($("#gh").css("display")=="none" && Sys_Config["Phone"]!="Y")
						{
							$("#kd").css("display","none");
							$("#gh").css("display","block");
							
							$("#ghSearchBox").select().focus();
							$("#chooseForJF,#chooseForFJ").val("电话费");
						}
					}
				//}
			}
			
		});
	}
	//宽带事件绑定
	function bindEventToKd()
	{
		$("#kdSearchWay").change(function(){$("#kdSearchBox").select();});
		
		$("#kdSearchByUserName").click(function(){kdSearch();});
		
		$("#kdJQ").click(function(){$("#kdSearchBox").select();$("#kdSearchBox").focus();});
		
		$("#kdUserInfo").click(function(){openUserInfoPanel();});
		
		$("#kduserInfoPanelclose").click(function(){
			$.unblockUI;
			$("#ChooseForJF").css("visibility","visible");
			$("#kdSearchWay").css("visibility","visible");
			$("#kdDJ").select();
		});
		//用户信息面板拖动
		$("#kduserInfoPanel").draggable({handle:"#thisdrag"});
		//用户缴费面板拖动
		$("#choosePrint").draggable({handle:"#thisdrag"});
		//用户退费面板拖动
		$("#choosePrintForTuiFei").draggable({handle:"#thisdrag"});
		//宽带缴费查询面板拖动
		$("#multiSearch").draggable({handle:"#thisdrag"});
		//电话缴费查询面板拖动
		//$("#ghSearch").draggable({handle:"#thisdrag"});
		//退费
		$("#kdTuiFei").click(function(){kdTuiFeiFun();});
		
		$("#kdMultiSearchClose").click(function(){
			setTimeout($.unblockUI,1);
			$("#kdSearchBox").select();
			$("#kdSearchBox").focus();
			$("#ChooseForJF").css("visibility","visible");
			$("#kdSearchWay").css("visibility","visible");
		});
		
		$("#kdSearchBox").keydown(function(event){if(event.keyCode==13){$("#kdSearchBox").blur();$("#kdSearchByUserName").click();}});
		
		
		//业务、缴费切换
		$("#kduiJf").click(function(){
			$("#kduserInfoPanelTabJOB").hide();
			$("#kduserInfoPanelTabTC").hide();
			$("#kduserInfoPanelTabJF").show();
			$("#kduserInfoPanelTabTZ").hide();
			$("#kduserInfoPanelTabKF").hide();
			$("#kduserInfoPanelTabXX").hide();
			$("#kduserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#kduiJf").addClass("bolder");
		});
		$("#kduiJob").click(function(){			
			$("#kduserInfoPanelTabJF").hide();
			$("#kduserInfoPanelTabTC").hide();
			$("#kduserInfoPanelTabJOB").show();
			$("#kduserInfoPanelTabTZ").hide();
			$("#kduserInfoPanelTabKF").hide();
			$("#kduserInfoPanelTabXX").hide();
			$("#kduserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#kduiJob").addClass("bolder");
		});
		$("#kduiGNB").click(function(){			
			$("#kduserInfoPanelTabJF").hide();
			$("#kduserInfoPanelTabTC").show();
			$("#kduserInfoPanelTabJOB").hide();
			$("#kduserInfoPanelTabTZ").hide();
			$("#kduserInfoPanelTabKF").hide();
			$("#kduserInfoPanelTabXX").hide();
			$("#kduserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#kduiGNB").addClass("bolder");
		});
		$("#kduiTZ").click(function(){			
			$("#kduserInfoPanelTabJF").hide();
			$("#kduserInfoPanelTabTZ").show();
			$("#kduserInfoPanelTabJOB").hide();
			$("#kduserInfoPanelTabTC").hide();
			$("#kduserInfoPanelTabKF").hide();
			$("#kduserInfoPanelTabXX").hide();
			$("#kduserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#kduiTZ").addClass("bolder");
		});
		$("#kduiKF").click(function(){			
			$("#kduserInfoPanelTabJF").hide();
			$("#kduserInfoPanelTabTZ").hide();
			$("#kduserInfoPanelTabKF").show();
			$("#kduserInfoPanelTabJOB").hide();
			$("#kduserInfoPanelTabTC").hide();
			$("#kduserInfoPanelTabXX").hide();
			$("#kduserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#kduiKF").addClass("bolder");
		});
		$("#kduiXX").click(function(){			
			$("#kduserInfoPanelTabJF").hide();
			$("#kduserInfoPanelTabTZ").hide();
			$("#kduserInfoPanelTabKF").hide();
			$("#kduserInfoPanelTabJOB").hide();
			$("#kduserInfoPanelTabTC").hide();
			$("#kduserInfoPanelTabXX").show();
			$("#kduserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#kduiXX").addClass("bolder");
		});
		
		$("#kdDJ").keydown(function(event){
			if(event.keyCode==13)
			{
				if($("#kdInfo").data("username")==undefined)
				{
					alert("请先查询用户");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
					return false;
				}
				if($.trim($("#kdDJ").val())=="")
				{
					alert("请输入递交金额");
					$("#kdDJ").select();
					$("#kdDJ").focus();
					return false;
				}
				if($.browser.mozilla)
				{
					if(!/^[0-9]+(.[0-9]{0,2})?$/.test($("#kdDJ").val()))
					{
						alert("请输入正确的递交金额,至多两位小数");
						$("#kdDJ").select();
						$("#kdDJ").focus();
						return false;
					}
				}
				var paytypee = parseInt($("#kdInfo").data("paytype"),10);
				var basefee = parseFloat($("#kdInfo").data("basefee"),10);
				var usertypee = parseInt($("#kdInfo").data("usertype"),10);
				var ye = parseFloat($("#kdYE").val(),10);
				var dj = parseFloat($("#kdDJ").val(),10);
				var newbusinessfee = parseFloat($("#kdInfo").data("newbusinessfee"),10);
				if(dj<=0)
				{
					alert("缴费金额不能为0");
					$("#kdDJ").select();
					$("#kdDJ").focus();
					return false;
				}
				if(usertypee!=2 && usertypee!=4)
				{			
					if(paytypee>=10)
					{
						if((dj * 1.0) % (basefee+newbusinessfee) != 0)
						{
							var altinfo = "用户";
							altinfo += $("#kdInfo").data("username");
							altinfo += "为外部用户,"						
							altinfo += "缴费金额必须为基本费用加新业务费的整数倍,基本费用为";
							altinfo += $("#kdInfo").data("basefee");
							altinfo += "新业务费为";
							altinfo += $("#kdInfo").data("newbusinessfee");
							alert(altinfo);
							$("#kdDJ").select();
							$("#kdDJ").focus();
							return false;
						}
					}
					else
					{				
						if(dj<basefee+newbusinessfee-ye)
						{
							var alertinfo = "用户";
							alertinfo += $("#kdInfo").data("username");
							alertinfo += "基本费为:";
							alertinfo += $("#kdInfo").data("basefee");
							alertinfo += ",新业务费为:";
							alertinfo += $("#kdInfo").data("newbusinessfee");
							alertinfo += ",现有余额:";
							alertinfo += $("#kdInfo").data("kdye");
							alertinfo += ",至少应该续费：";
							alertinfo += (basefee+newbusinessfee-ye);
							
							alert(alertinfo);
							$("#kdDJ").select();
							$("#kdDJ").focus();
							return false;
						}
					}
				}
				else
				{//公费用户
					if(paytypee>=10)
					{
						if((dj * 1.0) % (newbusinessfee) != 0)
						{
							var altinfo = "用户";
							altinfo += $("#kdInfo").data("username");
							altinfo += "为外部公费用户,"						
							altinfo += "新业务费为";
							altinfo += $("#kdInfo").data("newbusinessfee");
							altinfo += "至少应缴";
							altinfo += (newbusinessfee);
							alert(altinfo);
							$("#kdDJ").select();
							$("#kdDJ").focus();
							return false;
						}
					}
					else
					{				
						if(dj<newbusinessfee)
						{
							var alertinfo = "用户";
							alertinfo += $("#kdInfo").data("username");
							alertinfo += "为公费用户,新业务费为:";
							alertinfo += $("#kdInfo").data("newbusinessfee");
							alertinfo += ",至少应该续费：";
							alertinfo += (newbusinessfee);
							
							alert(alertinfo);
							$("#kdDJ").select();
							$("#kdDJ").focus();
							return false;
						}
					}
				}
				//设置实收金额默认值
				//$("#kdSs").val($("#kdDJ").val());
				$("#kdSs").val($("#leijiFee").val());
				
				$("#kdSs").select();
				$("#kdSs").focus();
			}
		});
		
		$("#kdSs").keydown(function(event){
			if(event.keyCode==13)
			{
				if($("#kdInfo").data("username")==undefined)
				{
					alert("请先查询用户");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
					return false;
				}
				
				
				if($.browser.mozilla)
				{
					if(!/^[0-9]+(.[0-9]{0,2})?$/.test($("#kdSs").val()))
					{
						alert("请输入正确的实收金额,至多两位小数");
						$("#kdSs").select();
						$("#kdSs").focus();
						return false;
					}
				}
				var paytypee = parseInt($("#kdInfo").data("paytype"),10);
				var usertypee = parseInt($("#kdInfo").data("usertype"),10);
				var basefee = parseFloat($("#kdInfo").data("basefee"),10);
				var ye = parseFloat($("#kdYE").val(),10);
				var dj = parseFloat($("#kdDJ").val(),10);
				var ss = parseFloat($("#kdSs").val(),10);
				var newbusinessfee = parseFloat($("#kdInfo").data("newbusinessfee"),10);
				if($.trim($("#kdDJ").val())=="")
				{
					alert("请输入递交金额");
					$("#kdDJ").focus();
					$("#kdDJ").select();
					return false;
				}
				
				if($.trim($("#kdSs").val())=="" || isNaN(parseFloat($.trim($("#kdSs").val()),10)))
				{
					alert("请输入实收金额");
					$("#kdSs").focus();
					$("#kdSs").select();
					return false;
				}
				
				if(ss<=0)
				{
					alert("实收金额不能为0");
					$("#kdSs").select();
					$("#kdSs").focus();
					return false;
				}
				
				if(ss>dj)
				{
					alert("实收金额不能大于递交金额");
					$("#kdSs").select();
					$("#kdSs").focus();
					return false;
				}
				if(usertypee!=2 && usertypee!=4)
				{//非公费用户
					if(paytypee>=10)
					{
						if((ss * 1.0) % (basefee+newbusinessfee) != 0)
						{
							var altinfo = "用户";
							altinfo += $("#kdInfo").data("username");
							altinfo += "为外部用户,"						
							altinfo += "缴费金额必须为基本费用加新业务费的整数倍,基本费用为";
							altinfo += $("#kdInfo").data("basefee");
							altinfo += "新业务费为";
							altinfo += $("#kdInfo").data("newbusinessfee");
							alert(altinfo);
							$("#kdSs").select();
							$("#kdSs").focus();
							return false;
						}
					}
					else
					{				
						if(ss<basefee+newbusinessfee-ye)
						{
							var alertinfo = "用户";
							alertinfo += $("#kdInfo").data("username");
							alertinfo += "基本费为:";
							alertinfo += $("#kdInfo").data("basefee");
							alertinfo += ",新业务费为:";
							alertinfo += $("#kdInfo").data("newbusinessfee");
							alertinfo += ",现有余额:";
							alertinfo += $("#kdInfo").data("kdye");
							alertinfo += ",至少应该续费：";
							alertinfo += (basefee+newbusinessfee-ye);
							alert(alertinfo);
							$("#kdSs").select();
							$("#kdSs").focus();
							return false;
						}
					}
				}
				else
				{//公费用户
					if(paytypee>=10)
					{
						if((ss * 1.0) % (newbusinessfee) != 0)
						{
							var altinfo = "用户";
							altinfo += $("#kdInfo").data("username");
							altinfo += "为外部公费用户,"						
							altinfo += "缴费金额必须为新业务费的整数倍,";
							altinfo += "新业务费为：";
							altinfo += $("#kdInfo").data("newbusinessfee");
							alert(altinfo);
							$("#kdSs").select();
							$("#kdSs").focus();
							return false;
						}
					}
					else
					{				
						if(ss<newbusinessfee)
						{
							var alertinfo = "用户";
							alertinfo += $("#kdInfo").data("username");
							alertinfo += "为公费用户,新业务费为:";
							alertinfo += $("#kdInfo").data("newbusinessfee");
							alertinfo += ",至少应该续费：";
							alertinfo += (newbusinessfee);
							alert(alertinfo);
							$("#kdSs").select();
							$("#kdSs").focus();
							return false;
						}
					}
				}
				$("#kdYz").val(dj-ss);
				$("#kdsave").click();
			}
		}).keyup(function(){
			if($.trim($("#kdSs").val())=="")
			{
				$("#kdYz").val("");
			}
			else
			{
				var dj = parseFloat($("#kdDJ").val(),10).toFixed(2);
				var ss = parseFloat($("#kdSs").val(),10).toFixed(2);
				dj = parseFloat(dj,10);
				ss = parseFloat(ss,10);
				
				if(isNaN(dj)) dj = 0;
				if(isNaN(ss)) ss = 0;
				
				if(ss>dj)
				{
					alert("实收金额不能大于递交金额");
					var ssv = $("#kdSs").val();
					$("#kdSs").val(ssv.substring(0,ssv.length-1));
					$("#kdSs").select();
					$("#kdSs").focus();
					return false;
				}
				$("#kdYz").val((dj-ss).toFixed(2));
			}
		});
		
		$("#kdsave").click(function(){
			if($("#kdInfo").data("username")=="")
			{
				alert("请输入并查询要缴费的用户账号");
				$("#kdSearchBox").select();
				$("#kdSearchBox").focus();
				return false;
			}
			
			//代办人信息
			var bz4 = $("#bz4").val();
	       	//var bz5 = $("#bz5").val();
	       	var cDocumentsNumber = $("#bz5").val();
	       	if(cDocumentsNumber!=undefined){
	        	cDocumentsNumber=cDocumentsNumber.replace(/(^\s*)|(\s*$)/g,"");
	        	if($("#bz4").val()=="身份证" && cDocumentsNumber!="" && !/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(cDocumentsNumber))
	        	{
	        		alert("代办证件号码中请输入正确的身份证号码");
	        		$("#bz5").select();
	        		$("#bz5").focus();
	        		return false;
	        	}
		    }
			    
			if($.browser.mozilla)
			{
				if(!/^[0-9]+(.[0-9]{0,2})?$/.test($("#kdDJ").val()))
				{
					alert("请输入正确的递交金额,至多两位小数");
					$("#kdDJ").select();
					$("#kdDJ").focus();
				}
				if(!/^[0-9]+(.[0-9]{0,2})?$/.test($("#kdSs").val()))
				{
					alert("请输入正确的实收金额,至多两位小数");
					$("#kdSs").select();
					$("#kdSs").focus();
				}
			}
			var paytypee = parseInt($("#kdInfo").data("paytype"),10);
			var basefee = parseFloat($("#kdInfo").data("basefee"),10);
			var usertypee = parseInt($("#kdInfo").data("usertype"),10);
			var ye = parseFloat($("#kdYE").val(),10);
			var dj = parseFloat($("#kdDJ").val(),10);
			var ss = parseFloat($("#kdSs").val(),10);
			var newbusinessfee = parseFloat($("#kdInfo").data("newbusinessfee"),10);
			
			if($.trim($("#kdDJ").val())=="")
			{
				alert("请输入递交金额");				
				$("#kdDJ").select();
				$("#kdDJ").focus();
				return false;
			}
			
			if($.trim($("#kdSs").val())=="" || isNaN(parseFloat($.trim($("#kdSs").val()),10)))
			{
				alert("请输入实收金额");
				$("#kdSs").select();
				$("#kdSs").focus();				
				return false;
			}
			
			if(dj<=0)
			{
				alert("递交金额不能为0");
				$("#kdDJ").select();
				$("#kdDJ").focus();
				return false;
			}
			
			if(ss<=0)
			{
				alert("实收金额不能为0");
				$("#kdSs").select();
				$("#kdSs").focus();
				return false;
			}
			
			if(ss>dj)
			{
				alert("实收金额不能大于递交金额");
				$("#kdSs").select();
				$("#kdSs").focus();
				return false;
			}
			
			if(usertypee!=2 && usertypee!=4)
			{//非公费用户
				if(paytypee>=10)
				{
					if((ss * 1.0) % (basefee+newbusinessfee) != 0)
					{
						var altinfo = "用户";
						altinfo += $("#kdInfo").data("username");
						altinfo += "为外部用户,"						
						altinfo += "缴费金额必须为基本费用加新业务费的整数倍,基本费用为";
						altinfo += $("#kdInfo").data("basefee");
						altinfo += "新业务费为";
						altinfo += $("#kdInfo").data("newbusinessfee");
						alert(altinfo);
						$("#kdSs").select();
						$("#kdSs").focus();
						return false;
					}
				}
				else
				{				
					if(ss<basefee+newbusinessfee-ye)
					{
						var alertinfo = "用户";
						alertinfo += $("#kdInfo").data("username");
						alertinfo += "基本费为:";
						alertinfo += $("#kdInfo").data("basefee");
						alertinfo += ",新业务费为:";
						alertinfo += $("#kdInfo").data("newbusinessfee");
						alertinfo += ",现有余额:";
						alertinfo += $("#kdInfo").data("kdye");
						alertinfo += ",至少应该续费：";
						alertinfo += (basefee+newbusinessfee-ye);
						
						alert(alertinfo);
						$("#kdSs").select();
						$("#kdSs").focus();
						return false;
					}
				}
			}
			else
			{//公费用户
				if(paytypee>=10)
				{
					if((ss * 1.0) % (newbusinessfee) != 0)
					{
						var altinfo = "用户";
						altinfo += $("#kdInfo").data("username");
						altinfo += "为外部公费用户,"						
						altinfo += "缴费金额必须为新业务费的整数倍,";
						altinfo += "新业务费为";
						altinfo += $("#kdInfo").data("newbusinessfee");
						alert(altinfo);
						$("#kdSs").select();
						$("#kdSs").focus();
						return false;
					}
				}
				else
				{				
					if(ss<newbusinessfee)
					{
						var alertinfo = "用户";
						alertinfo += $("#kdInfo").data("username");
						alertinfo += "为公费用户,新业务费为:";
						alertinfo += $("#kdInfo").data("newbusinessfee");
						alertinfo += ",至少应该续费：";
						alertinfo += (newbusinessfee);
						
						alert(alertinfo);
						$("#kdSs").select();
						$("#kdSs").focus();
						return false;
					}
				}
			}
			
			$("#kdYz").val((dj-ss).toFixed(2));
			
			var info = "确认缴费\n\n";
			info += "账号:\t\t";
			info += $("#kdInfoUserName").text();
			info += "\n用户姓名:\t";
			info += $("#kdInfosRealName").text();
			info += "\n上次余额:\t";
			info += $("#kdYE").val();
			info += "\n本次递交金额:\t";
			info += $("#kdDJ").val();
			info += "\n本次缴费金额:\t";
			info += $("#kdSs").val();
			info += "\n应找金额:\t";
			info += $("#kdYz").val();
			if(confirm(info))
			{
				//缴费
				kdPay();
				$("#kdsave").attr("disabled","disabled");
			}
			else
			{
				//清空用户信息
			}
			
		});
	}
	
	function search(idx)
	{
		if(idx==2)
		{
			kdMultiUser(2,$("#kdsRealName").val());
		}
		else if(idx==1)
		{
			kdMultiUser(1,$("#kdsDh").val());
		}
		else
		{
			kdMultiUser(0,$("#kdUserName").val());
		}
	}
	
	function printWithoutPreview(reportname,paramvalue)
	{
		document.getElementById('printReportDirect').contentWindow.RepPri(reportname,paramvalue);
	}
	
	function testCAlert()
	{
		alert($("#multiSearch").css("display"));
	}
	
	function clearKdInfo()
	{
		//清空宽带查询框
		$("#kdSearchBox").val("");
		
		$("#kdInfo span").empty();
		
		$("#kdsave").attr("disabled","disabled");
		//清空宽带信息
		$("#kdInfo").removeData("paytype");
		
		$("#kdInfo").removeData("usertype");
		
		$("#kdInfo").removeData("feetype");
		
		$("#kdInfo").removeData("basefee");
		
		$("#kdInfo").removeData("kdlsz");
		
		$("#kdInfo").removeData("kdye");
		
		$("#kdInfo").removeData("username");
		
		$("#kdInfo").removeData("remainfee");
		
		$("#kdInfo").removeData("fee5");
		
		$("#kdInfo").removeData("newbusinessfee");
		
		$("#kdInfo").removeData("tf");
		
		//情况代办人员信息
		$("#bz1").val("");
		$("#bz2").val("");
		$("#bz3").val("");
		$("#bz4").val("身份证");
		$("#bz5").val("");
		$("#bz10").val("");
		$("#AcctPayTime").val("<%=theTime%>");
		//清空宽带缴费输入框
		$("#kdStatus input[type='text']").val("");
		
		$("#kduserInfoPanel span").empty();
		
		$("#kdUserInfo").attr("disabled","disabled");	
		
		//$("#kdTuiFei").attr("disabled","disabled");	
		
		$("tr[clickreturntr='clickreturntr']").remove();
		kdTuiFeiResetFun();	
		
		kdunLock();
		
		$("#kdSearchBox").select();
		$("#kdSearchBox").focus();
	}
	
	function clearKdInfoWithoutSearchBox()
	{
		
		$("#kdInfo span").empty();
		
		//情况代办人员信息
		$("#bz1").val("");
		$("#bz2").val("");
		$("#bz3").val("");
		$("#bz4").val("身份证");
		$("#bz5").val("");
		$("#bz10").val("");
		$("#AcctPayTime").val("<%=theTime%>");
		
		$("#kdsave").attr("disabled","disabled");
		//清空宽带信息
		$("#kdInfo").removeData("paytype");
		
		$("#kdInfo").removeData("usertype");
		
		$("#kdInfo").removeData("feetype");
		
		$("#kdInfo").removeData("basefee");
		
		$("#kdInfo").removeData("kdlsz");
		
		$("#kdInfo").removeData("kdye");
		
		$("#kdInfo").removeData("username");
		
		$("#kdInfo").removeData("remainfee");
		
		$("#kdInfo").removeData("fee5");
		
		$("#kdInfo").removeData("newbusinessfee");
		
		$("#kdInfo").removeData("tf");
		
		
		//清空宽带缴费输入框
		$("#kdStatus input[type='text']").val("");
		
		$("#kduserInfoPanel span").empty();
		
		$("#kdUserInfo").attr("disabled","disabled");
		
		//$("#kdTuiFei").attr("disabled","disabled");	
		
		$("tr[clickreturntr='clickreturntr']").remove();
		kdTuiFeiResetFun();	
		
		kdunLock();
		
		$("#kdSearchBox").select();
		$("#kdSearchBox").focus();
	}
	
	/////宽带打印
	function kdPrint(flag)
	{
		var lsz= $("#kdInfo").data("kdlsz");
		//alert(lsz);
		if(typeof lsz == "undefined")
		{
			alert("打印失败");
			return false;
		}
		if(flag==0){
			printRep("broadband_revenue","&lsz="+lsz,flag);	
		}else if(flag==1){
			printRep("broadband_revenue","&lsz="+lsz,flag);
			noprint('broadband');
		}
		
		//printRep("broadband_leave_1","&lsz="+lsz,flag);			
		//setTimeout($.unblockUI,1);		
		//clearKdInfo();
	}
	
	/////电话打印
	function ghPrint(flag)
	{
		reportfile ='chargelist(heji)';
		var lsz='<%=(String)session.getAttribute("userid")%>';
		if(flag==0)
		{			
			printRep(reportfile,"&skrid="+lsz,flag);
		}
		if(flag==1)
		{
			printRep(reportfile,"&skrid="+lsz,flag);
			noprint('phone');
		}
		if(flag==2)
		{
			setTimeout($.unblockUI,1);
			ghClearInfo();
			return false;
		}
		
		var lsz= $("#skrid").val();
		if(typeof lsz == "undefined")
		{
			alert("打印失败");
			return false;
		}
		
		//取缴费方式
		var paytype = $.trim($("#ghFFFs").val());
		var reportfile = "fixedphone_leave";
		/*
		if(paytype=="固话缴费")
		{
			reportfile = "fixedphone_leave";
		}
		else if(paytype=="固话预存")
		{
			reportfile = "fixedphone_leave_yc";
		}
		else if(paytype=="灵通缴费")
		{
			reportfile = "fixedphone_leave_ltjs";
		}
		else if(paytype=="灵通预存")
		{
			reportfile = "fixedphone_leave_ltyc";
		}
		else if(paytype=="退费")
		{
			reportfile = "fixedphone_leave_tuifei";
		}
		*/
		reportfile = $("#ghFFFs option:selected").attr("rptfile");
		if($("#ghPayReport:checked").size()>0 &&$("#ghInfo").data("hthlistpay")!="Y")
		{
			reportfile = reportfile + "_combined";
		}


	}
	
function noprint(type)
{
	setTimeout($.unblockUI,1);
	if(type =='broadband'){
		$("#printtype").data("printtype",'broadband');
	}else if(type =='phone'){
		$("#printtype").data("printtype",'phone');
	}	
	setTimeout('autoBlockForm("choosePrintForReceipt","150","ghNoPrintRe","#FFFFFF",false)',25);
	return false;
}

	
	
	///根据用户账号取付费类型
	function kdUserType(UserName)
	{
		var res = fetchSingleValue("Revenue.fetchUserType",0,"&UserName="+UserName);

		$("#kduiUserType").text(analizeUserType(res));
		
		$("#kdInfo").data("usertype",res);
	}
	
	function kdPayType(UserName)
	{
		var res = fetchSingleValue("Revenue.fetchPayType",0,"&UserName="+UserName);

		$("#kdInfo").data("paytype",res);
	}
	
	function analizeUserType(usertype)
	{
		usertype = fetchSingleValue("Revenue.fUTP",0,"&TypeID="+usertype);
		if(usertype==undefined)
		{
			usertype = "";
		}
		return usertype;
	}
	
	function analizePayType(paytype)
	{
		paytype = parseInt(paytype,10);
		if(paytype>=10)
		{
			return "外部用户";
		}
		else
		{
			return "小区网用户";
		}
	}
	//缴费前先 查询该用户上次缴费金额和缴费时间
	function kdPayQuery(UserName,sRealName){
		var info ='';
		var Arrears = fetchMultiArrayValue("Revenue.getArrears",0,"&username="+UserName);
		if(Arrears[0]!=undefined&&Arrears[0][0]!=undefined){
			info = "用户宽带使用起始日期为："+Arrears[0][0];
			info += "至"+Arrears[0][1]+"，因未续费已停机";
			alert(info);
		}
		var res = fetchMultiArrayValue("Revenue.getPayMessage",0,"&username="+UserName);
	 	if(res[0]!=undefined&&res[0][0]!=undefined){
	 		info = "上次缴费信息\n\n";
			info += "账号:\t";
			info += UserName;
			info += "\n用户姓名:";
			info += sRealName;
			info += "\n上次缴费时间:";
			info += res[0][1];
			info += "\n计费方式:";
			info += res[0][2]; 
			alert(info);
	 	}
		
	}
	//取指定用户的费用名称和基本费用
	function kdFeeName(UserName)
	{
		var res = fetchMultiArrayValue("Revenue.fetchFeeName",0,"&UserName="+UserName);

		if(typeof res[0][0] == 'undefined')
		{
			return false;
		}
		$("#kduiFeeName").text(res[0][0]);
		$("#kdInfoFeeName").text(res[0][0]);
		$("#kdInfo").data("basefee",res[0][1]);
		$("#kdInfo").data("feetype",res[0][0]);
	}
	//取指定用户的费用名称和基本费用
	function kdStatus(UserName)
	{
		var res = fetchSingleValue("revenue.fetchIStatus",0,"&UserName="+UserName);

		if(typeof res == 'undefined')
		{
			return false;
		}
	}
	
	function analizeKdStatus(status,UserName)
	{
		status = parseInt(status,10);
		switch(status)
		{
			case 0:
				return "正常";
				break;
			case 1:
				return "锁定";
				break;
			case 2:
				kdStopTime("sysstop",UserName);
				return "欠费";
				break;
			default:
				return "";
		}
	}
	//取用户欠费停机时间或停机保号时间
	function kdStopTime(ywlx,UserName)
	{
		var res=fetchSingleValue("Revenue.fetchStopTime",0,"&ywlx="+ywlx+"&UserName="+UserName);
		if(res==undefined||res=="")
		{
			return false;
		}
		else
		{
			$("#kdInfoStopTime").text(res);
		}
	}
	
	//取用户停机保号复机时间
	function kdPauseStopTime(UserName)
	{
		var res=fetchMultiArrayValue("Revenue.pauseStopTime",0,"&UserName="+UserName);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			return false;
		}
		else
		{
			$("#kdInfoPauseStopTimeLbl").text("复机时间");
			$("#kdInfoPauseStopTime").text(res[0][1]);
		}
	}
	
	//判断是否在停机保号状态
	function kdPause(UserName)
	{
		var res = fetchSingleValue("Revenue.pause",0,"&UserName="+UserName);

		if(typeof res == 'undefined' || res == "0")
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	//取用户余额
	function kdQueryYE(UserName)
	{
		var res = fetchSingleValue("Revenue.fetchYE1",0,"&UserName="+UserName);

		if(typeof res == 'undefined')
		{
			res = 0;
		}
		$("#kdYE").val(res);
		
		$("#kdInfo").data("kdye",res);
	}
	//取remainfee
	function kdQueryRemainFee(UserName)
	{
		var res = fetchSingleValue("Revenue.fetchRemainFee",0,"&UserName="+UserName);

		if(typeof res == 'undefined')
		{
			res = 0;
		}
		
		$("#kdInfo").data("remainfee",res);
		
		$("#kdInfoRemainFee").text(res);
	}
	//取fee5
	function kdQueryFee5(UserName)
	{
		var res = fetchSingleValue("Revenue.fetchFee5",0,"&UserName="+UserName);

		if(typeof res == 'undefined')
		{
			res = 0;
		}
		$("#kdInfo").data("fee5",res);
		
		$("#kdInfoFee5").text(res);
	}	
	//取用户基本信息
	function kdBasicInfoo(UserName)
	{
		var res = fetchMultiArrayValue("Revenue.fetchBasicInfo",0,"&UserName="+UserName);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			return false;
		}
		else
		{
			//
			var paytype = res[0][0];
			
			$("#kduiPayType").text(analizePayType(paytype));
			var sdh = res[0][1];
			$("#kduisDh").text(sdh);
			$("#kdInfosDh").text(sdh);
			
			var sregdate = res[0][2];
			var acctstarttime = res[0][14];
			var acctstoptime = res[0][15];
			$("#kduisRegDate").text(sregdate);
			$("#kdInfoRegDate").text(sregdate);//缴费主面板显示开户日期
			$("#kdInfoacctstarttime").text(acctstarttime);//缴费主面板显示计费起始日期
			$("#kdInfoacctstoptime").text(acctstoptime);//缴费主面板显示计费截止日期
			var feeendtime = res[0][3];
			$("#kduifeeendtime").text(feeendtime);
			var srealname = res[0][4];
			$("#kduisRealName").text(srealname);
			$("#kduisRealNameTitle").text(srealname);
			$("#kdInfosRealName").text(srealname);
			
			var saddress = res[0][5];
			$("#kduisAddress").text(saddress);
			$("#kdInfosAddress").text(saddress);
			
			var sdh1 = res[0][6];
			$("#kduiUserType").text(analizeUserType(sdh1));
			$("#kdInfosDh1").text(analizeUserType(sdh1));
			
			var sdh2 = res[0][7];
			$("#kduisDh2").text(sdh2);
			
			var istatus = res[0][8];
			$("#kduiiStatus").text(analizeKdStatus(istatus,UserName));
			$("#kdInfoStatus").text(analizeKdStatus(istatus,UserName));
			
			//如果锁定，则显示锁定原因
			var faultFee = analizeLock(UserName);
			if(faultFee!="" && istatus=="1")
			{
				faultFee = "当前未完工故障工单费用项：" + faultFee;
				$("#kduiiStatus").attr("title",faultFee);
				$("#kdInfoStatus").attr("title",faultFee);
			}
			else
			{
				$("#kduiiStatus").removeAttr("title");
				$("#kdInfoStatus").removeAttr("title");
			}
			
			if(kdPause(UserName))
			{
				$("#kduiiStatus").text("申请停机");
				$("#kdInfoStatus").text("申请停机");
				kdStopTime("yhstop",UserName);
				kdPauseStopTime(UserName);
			}
			else
			{
				$("#kdInfoPauseStopTimeLbl").text("");
				$("#kdInfoPauseStopTime").text("");
			}
			
			var sbm1 = res[0][9];
			$("#kduisBm1").text(sbm1);
			var sbm2 = res[0][10];
			$("#kduisBm2").text(sbm2);
			var sbm3 = res[0][11];
			$("#kduisBm3").text(sbm3);
			var sbm4 = res[0][12];
			$("#kduisBm4").text(sbm4);
			
			var speed = res[0][13];
						
			$("#kdInfo").data("paytype",paytype);
			$("#kdInfo").data("usertype",sdh1);
		}
	}
	//业务历史查询
	function kdJobLS(UserName)
	{
		var res = fetchMultiArrayValue("Revenue.jobLS",0,"&UserName="+UserName);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#kduserInfoPanelTabJOB").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\">业务类型</td><td width=\"220\">工单记录时间</td><td width=\"130\">营业员</td>";
			temp += "</tr>";
			
			$("#kduserInfoPanelTabJOB").append(temp);
			return false;
		}
		else
		{
			var temp = "";
			$("#kduserInfoPanelTabJOB").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\">业务类型</td><td width=\"220\">工单记录时间</td><td width=\"130\">营业员</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td ";
				if(res[j][0]=="修改计费规则" || res[j][0]=="公费转私费" || res[j][0]=="私费转公费")
				{
					temp += " title=\"";
					temp += analizeFeeNamee(res[j][3],res[j][4]);
					temp += "\" ";
				}
				else if(res[j][0]=="修改属性")
				{
					temp += " title=\"";
					temp += analizeXgxx(res[j][5]);
					temp += "\" ";					
				}
				else if(res[j][0]=="移机")
				{
					temp += " title=\"";
					temp += "用户地址从 " + res[j][8] + "  至  " + res[j][7];
					temp += "\" ";
				}
				else if(res[j][0]=="过户")
				{
					temp += " title=\"";
					temp += "用户姓名从 " + res[j][10] + " 更改为 " + res[j][9];
					temp += "\" ";
				}
				temp += ">";
				temp += res[j][0];
				temp += "</td>";
				temp += "<td>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td>";
				temp += Clerks[res[j][2]]==undefined?"":Clerks[res[j][2]];
				
				temp += "</td>";
				temp += "</tr>";
			}
			$("#kduserInfoPanelTabJOB").append(temp);
		}
	}

	//解析计费规则
	function analizeFeeNamee(ifeetype,ifeetype1)
	{
		if(ifeetype==ifeetype1)
		{
			return "";
		}
		var res1 = fetchSingleValue("Revenue.loadType",0,"&FeeCode="+ifeetype);
		if(res1==undefined)
		{
			res1 = "";
		}
		var res2 = fetchSingleValue("Revenue.loadType",0,"&FeeCode="+ifeetype1);
		if(res2==undefined)
		{
			res2 = "";
		}
		return res1 + "  至   " + res2;
	}
	//修改属性备注
	function analizeXgxx(jobid)
	{
		var result = fetchSingleValue("Revenue.loadXGXX",0,"&jobid=" + jobid);
		if(result==undefined)
		{
			result = "";
		}
		return result;
	}
	
	//取故障原因
	function analizeLock(UserName)
	{
		var result = fetchSingleValue("revenue.LockInfo",0,"&UserName=" + UserName);
		if(result==undefined)
		{
			result = "";
		}
		return result;
	}
	
	//用户缴费历史查询
	function kdJFLS(UserName)
	{
		var res = fetchMultiArrayValue("Revenue.jfLS",0,"&UserName="+UserName);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#kduserInfoPanelTabJF").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\">缴费金额</td><td width=\"220\">缴费时间</td><td width=\"130\">营业员</td>";
			temp += "</tr>";
			
			$("#kduserInfoPanelTabJF").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#kduserInfoPanelTabJF").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\">缴费金额</td><td width=\"220\">缴费时间</td><td width=\"130\">营业员</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td>";
				temp += res[j][0];
				temp += "</td>";
				temp += "<td>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td>";
				
				//替换工号为用户姓名
				//temp += res[j][2];
				temp += Clerks[res[j][2]]==undefined?"":Clerks[res[j][2]];
				
				temp += "</td>";
				temp += "</tr>";
			}
			$("#kduserInfoPanelTabJF").append(temp);
		}
	}

	//调账信息
	function kdTZ(UserName)
	{
		var res = fetchMultiArrayValue("Revenue.tz",0,"&UserName="+UserName);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#kduserInfoPanelTabTZ").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\">调账时间</td><td width=\"60\">调账金额</td><td width=\"60\">营业员</td><td width=\"230\">备注</td>";
			temp += "</tr>";
			
			$("#kduserInfoPanelTabTZ").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#kduserInfoPanelTabTZ").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\">调账时间</td><td width=\"60\">调账金额</td><td width=\"60\">营业员</td><td width=\"230\">备注</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td>";
				temp += res[j][0];
				temp += "</td>";
				temp += "<td>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td>";
				
				//替换工号为营业员姓名
				temp += Clerks[res[j][2]]==undefined?"":Clerks[res[j][2]];
				
				temp += "</td>";
				temp += "<td title=\"";
				temp += res[j][3];
				temp += "\">";
				temp += res[j][3].substring(0,18);
				temp += (res[j][3].length>18)?"<span style=\"font-weight:bold;\">...</span>":"";
				temp += "</td>";
				temp += "</tr>";
			}
			$("#kduserInfoPanelTabTZ").append(temp);
		}
	}
	
	//扣费信息
	function kdKF(UserName)
	{
		var res = fetchMultiArrayValue("Revenue.kf",0,"&UserName="+UserName);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#kduserInfoPanelTabKF").empty();
			
			temp += "<tr>";
			temp += "<td width=\"50\">月份</td><td width=\"90\">计费规则</td><td width=\"45\">合计</td><td width=\"45\">本月余额</td><td width=\"45\">上网费</td><td width=\"40\">新业务费</td><td width=\"45\">调账费</td><td width=\"35\">申停天数</td><td width=\"35\">欠停天数</td><td width=\"35\">扣费天数</td>";
			temp += "</tr>";
			
			$("#kduserInfoPanelTabKF").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#kduserInfoPanelTabKF").empty();
			
			temp += "<tr>";
			temp += "<td width=\"50\">月份</td><td width=\"90\">计费规则</td><td width=\"45\">合计</td><td width=\"45\">本月余额</td><td width=\"45\">上网费</td><td width=\"40\">新业务费</td><td width=\"45\">调账费</td><td width=\"35\">申停天数</td><td width=\"35\">欠停天数</td><td width=\"35\">扣费天数</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				//月份
				temp += "<td>";
				temp += res[j][0];
				temp += "</td>";
				
				//计费规则
				temp += "<td title=\"当前计费规则当月日扣费:" + res[j][10] +"元\">";
				temp += res[j][9];
				temp += "</td>";
				
				//合计
				temp += "<td>";
				temp += res[j][1];
				temp += "</td>";
				//本月余额
				temp += "<td>";
				temp += res[j][8];
				temp += "</td>";
				
				//上网费
				temp += "<td>";
				temp += res[j][2];
				temp += "</td>";
				//新业务费
				temp += "<td>";
				temp += res[j][3];
				temp += "</td>";
				//调账费
				temp += "<td>";
				temp += res[j][4];
				temp += "</td>";
				
				//申停天数
				temp += "<td>";
				temp += res[j][5];
				temp += "</td>";
				//欠停天数
				temp += "<td>";
				temp += res[j][6];
				temp += "</td>";
				//扣费天数
				temp += "<td>";
				temp += res[j][7];
				temp += "</td>";
				
				temp += "</tr>";
			}
			$("#kduserInfoPanelTabKF").append(temp);
		}
	}
	
	//当月扣费详细信息
	function kdXX(UserName)
	{
		var res = fetchMultiArrayValue("Revenue.fetchDetailOfHz",0,"&UserName="+UserName);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#kduserInfoPanelTabXX").empty();
			
			temp += "<tr>";
			temp += "<td width=\"120\">计费规则</td><td width=\"90\">用户类型</td><td width=\"35\">申停天数</td><td width=\"35\">欠停天数</td><td width=\"35\">扣费天数</td><td width=\"65\">合计</td><td width=\"45\">上网费</td><td width=\"45\">新业务费</td><td width=\"45\">调账费</td>";
			temp += "</tr>";
			
			$("#kduserInfoPanelTabXX").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#kduserInfoPanelTabXX").empty();
			
			temp += "<tr>";
			temp += "<td width=\"120\">计费规则</td><td width=\"90\">用户类型</td><td width=\"35\">申停天数</td><td width=\"35\">欠停天数</td><td width=\"35\">扣费天数</td><td width=\"65\">合计</td><td width=\"45\">上网费</td><td width=\"45\">新业务费</td><td width=\"45\">调账费</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				//规则
				temp += "<td title=\"当前计费规则本月日扣费:" + res[j][11] +"元\">";
				temp += res[j][1];
				temp += "</td>";
				//用户类型
				temp += "<td>";
				temp += res[j][2];
				temp += "</td>";
				//申停天数
				temp += "<td>";
				temp += res[j][4];
				temp += "</td>";
				//欠停天数
				temp += "<td>";
				temp += res[j][5];
				temp += "</td>";
				//扣费天数
				temp += "<td>";
				temp += res[j][6];
				temp += "</td>";
				//合计
				temp += "<td>";
				temp += res[j][7];
				temp += "</td>";
				//上网费
				temp += "<td>";
				temp += res[j][8];
				temp += "</td>";
				//新业务费
				temp += "<td>";
				temp += res[j][9];
				temp += "</td>";
				//调账费
				temp += "<td>";
				temp += res[j][10];
				temp += "</td>";
				
				temp += "</tr>";
			}
			$("#kduserInfoPanelTabXX").append(temp);
		}
	}
	
	function kdSearch()
	{alert('3');
		//清空上次状态
		clearKdInfoWithoutSearchBox();
		//解锁账号
		kdunLock();
		//模糊查询总数
		var keys=["Revenue.queryCountByIDM","Revenue.queryCountBysDhNameM","Revenue.queryCountBysRealNameM"];
		//精确查询
		var keyy=["Revenue.queryByIDExtract","Revenue.queryBySDHExtract","Revenue.queryBySRealNameExtract"];
		var infos = ["账号","电话","姓名"];
		var idx = parseInt($("#kdSearchWay").val(),10);
		//alert(idx);
		if($.trim($("#kdSearchBox").val())=="")
		{
			alert("请输入要查询的用户"+infos[idx]);
			$("#kdSearchBox").select();
			$("#kdSearchBox").focus();
			return false;
		}		
		else
		{
			//每次拼接参数必须初始化此参数
			var param = "";
			tsd.QualifiedVal=true;
	
			param = tsd.encodeURIComponent($.trim($("#kdSearchBox").val()));
			
			if(tsd.Qualified()==false){$("#kdSearchBox").select();$("#kdSearchBox").focus();return false;}
			
			var kdjingquechaxun = $("#kdJQ").attr("checked");
			if(kdjingquechaxun)
			{
				var resa = fetchSingleValue(keyy[idx],0,"&UN="+param);
				if(resa==undefined||resa=="")
				{
					alert("精确查询没有找到"+infos[idx]+"为"+$("#kdSearchBox").val()+"的用户");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
				}
				else
				{
					var resa_sdh = "";
					var resa_srealname = "";
					if(idx==1)
					{
						resa_sdh = $("#kdSearchBox").val();
					}
					else if(idx==2)
					{
						resa_srealname = $("#kdSearchBox").val();
					}
					userChoose(resa,resa_sdh,resa_srealname);
				}
			}
			else
			{	alert('2');
				var temp = fetchSingleValue(keys[idx],0,"&UN="+param);
				if(temp=="0")
				{
					alert("没有符合条件的用户，请检查输入");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
				}
				else
				{
					kdMultiUser(idx,param);
				}
			}
		}
	}
	
	//打开用户信息面板
	function openUserInfoPanel()
	{		
		$("#kduserInfoPanelclose").focus();
		$("#ChooseForJF").css("visibility","hidden");
		$("#kdSearchWay").css("visibility","hidden");
		
		var UserName = $("#kdInfo").data("username");
		//业务
		kdJobLS(UserName);
		//缴费
		kdJFLS(UserName);
		//套餐信息
		kdGetTaoCan(UserName);
		//调账信息
		kdTZ(UserName);
		//扣费金额
		kdKF(UserName);
		//当月扣费详细信息
		kdXX(UserName);
		
		autoBlockForm('kduserInfoPanel',20,'kduserInfoPanelclose',"#FFFFFF",false);
	}
	//打开电话用户信息面板
	function openDhUserInfoPanel()
	{		
		$("#kduserInfoPanelclose").focus();
				
		var Hth = $("#ghInfo").data("hth");
		
		var Dh = $("#ghInfo").data("dh");
		//业务
		ghJobLS(Dh);
		//缴费
		ghJFLS(Hth);
		//套餐信息
		ghGetTaoCan(Dh);
		//调账信息
		//ghTZ(Dh);
		//扣费金额
		ghKFLS(Hth);
		//当月扣费详细信息
		//ghXX(Dh);
		ghCTCLS(Dh);
		ghGDFLS(Dh);
		ghLTCLS(Dh);
		
		autoBlockForm('ghuserInfoPanel',20,'ghuserInfoPanelclose',"#FFFFFF",false);
	}
	
	  //电话缴费历史查询
	function ghJFLS(Hth)
	{
		var res = fetchMultiArrayValue("revenue.jflist",1,"&Hth="+Hth);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#ghuserInfoPanelTabJF").empty();
			
			temp += "<tr>";
			temp += "<td width=\"150\" class='center'>缴费时间</td><td width=\"90\" class='center'>缴费金额</td><td width=\"90\" class='center'>应缴金额</td><td width=\"90\" class='center'>滞纳金</td><td width=\"90\" class='center'>预收款</td><td width=\"85\" class='center'>缴费方式</td><td width=\"130\" class='center'>营业员</td>";
			temp += "</tr>";
			
			$("#ghuserInfoPanelTabJF").append(temp);
			return false;
		}
		else
		{
			var temp = "";
			$("#ghuserInfoPanelTabJF").empty();
			
			temp += "<tr>";
			temp += "<td width=\"150\" class='center'>缴费时间</td><td width=\"90\" class='center'>缴费金额</td><td width=\"90\" class='center'>应缴金额</td><td width=\"90\" class='center'>滞纳金</td><td width=\"90\" class='center'>预收款</td><td width=\"85\" class='center'>缴费方式</td><td width=\"130\" class='center'>营业员</td>";			
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td class='center'>";
				temp += res[j][0];
				temp += "</td>";
				
				temp += "<td class='right'>";
				temp += res[j][2];
				temp += "</td>";
				
				temp += "<td class='right'>";
				temp += res[j][5];
				temp += "</td>";
				
				temp += "<td class='right'>";
				temp += res[j][6];
				temp += "</td>";
				
				temp += "<td class='right'>";
				temp += res[j][7];
				temp += "</td>";
				
				temp += "<td class='center'>";
				temp += res[j][4];
				temp += "</td>";
				
				temp += "<td class='center'>";
				
				//替换工号为用户姓名
				//temp += res[j][2];
				temp += Clerks[res[j][3]]==undefined?"":Clerks[res[j][3]] + "(" + res[j][3] + ")";
				
				temp += "</td>";
				temp += "</tr>";
			}
			$("#ghuserInfoPanelTabJF").append(temp);
		}
	}
	
	
	//电话用户业务变更历史查询
	function ghJobLS(Hth)
	{
		var res = fetchMultiArrayValue("revenue.joblist",7,"&Dh="+Hth);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#ghuserInfoPanelTabJOB").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\" class='center'>业务类型</td><td width=\"220\" class='center'>工单记录时间</td><td width=\"130\" class='center'>营业员</td>";
			temp += "</tr>";
			
			$("#ghuserInfoPanelTabJOB").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#ghuserInfoPanelTabJOB").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\" class='center'>业务类型</td><td width=\"220\" class='center'>工单记录时间</td><td width=\"130\" class='center'>营业员</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td>";
				temp += res[j][0];
				temp += "</td>";
				temp += "<td>";				
				//替换工号为用户姓名
				//temp += res[j][2];
				temp += Clerks[res[j][2]]==undefined?"":Clerks[res[j][2]] + "(" + res[j][2] + ")";
				
				temp += "</td>";
				temp += "</tr>";
			}
			$("#ghuserInfoPanelTabJOB").append(temp);
		}
	}
	
	//电话用户这包月套餐查询
	function ghCTCLS(Dh)
	{
		var res = fetchMultiArrayValue("revenue.hfintime",6,"&dhh="+Dh);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#ghuserInfoPanelTabCTC").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\" class='center'>包月类型</td><td width=\"220\" class='center'>起始有效月</td><td width=\"130\" class='center'>截止有效月</td>";
			temp += "</tr>";
			
			$("#ghuserInfoPanelTabCTC").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#ghuserInfoPanelTabCTC").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\" class='center'>包月类型</td><td width=\"220\" class='center'>起始有效月</td><td width=\"130\" class='center'>截止有效月</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td class='center'>";	
				temp += res[j][0];
				temp += "</td>";
				temp += "<td class='center'>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td class='center'>";				
				temp += res[j][2];				
				temp += "</td>";
				temp += "</tr>";
			}
			$("#ghuserInfoPanelTabCTC").append(temp);
		}
	}
	
	//电话用户优惠套餐查询
	function ghLTCLS(Dh)
	{
		var res = fetchMultiArrayValue("revenue.bytc",6,"&dhh="+Dh);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#ghuserInfoPanelTabLTC").empty();
			
			temp += "<tr>";
			temp += "<td width=\"240\" class='center'>套餐类型</td><td width=\"170\" class='center'>开通日期</td><td width=\"80\" class='center'>开始计费月</td>";
			temp += "</tr>";
			
			$("#ghuserInfoPanelTabLTC").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#ghuserInfoPanelTabLTC").empty();
			
			temp += "<tr>";
			temp += "<td width=\"240\" class='center'>套餐类型</td><td width=\"170\" class='center'>开通日期</td><td width=\"80\" class='center'>开始计费月</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td class='center'";				
				temp += ">";
				temp += res[j][0];
				temp += "</td>";
				temp += "<td class='center'>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td class='center'>";				
				temp += res[j][2];				
				temp += "</td>";
				temp += "</tr>";
			}
			$("#ghuserInfoPanelTabLTC").append(temp);
		}
	}
	
	//电话用户固定费查询
	function ghGDFLS(Dh)
	{
		var res = fetchMultiArrayValue("revenue.attachfee",6,"&dhh="+Dh);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#ghuserInfoPanelTabGDF").empty();
			
			temp += "<tr>";
			temp += "<td class='center'>费用类型</td><td class='center'>子类型</td><td class='center'>价格</td><td class='center'>停机价格</td><td class='center'>起始有效月</td><td class='center'>截止有效月</td>";
			temp += "</tr>";
			
			$("#ghuserInfoPanelTabGDF").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#ghuserInfoPanelTabGDF").empty();
			
			temp += "<tr>";
			temp += "<td class='center'>费用类型</td><td class='center'>子类型</td><td class='center'>价格</td><td class='center'>停机价格</td><td class='center'>起始有效月</td><td class='center'>截止有效月</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td class='center'";				
				temp += ">";
				temp += res[j][0];
				temp += "</td>";
				temp += "<td class='center'>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td class='right'>";				
				temp += res[j][2];				
				temp += "</td>";
				temp += "<td class='right'>";
				temp += res[j][3];
				temp += "</td>";
				temp += "<td class='center'>";
				temp += res[j][4];
				temp += "</td>";
				temp += "<td class='center'>";
				temp += res[j][5];
				temp += "</td>";
				temp += "</tr>";
			}
			$("#ghuserInfoPanelTabGDF").append(temp);
		}
	}
	
	//电话用户扣费查询
	function ghKFLS(Hth)
	{
		//2012-11-5 yhy start
		//修改显示字段
		var temp = "";
		$("#ghuserInfoPanelTabKF").empty();		
		temp += "<tr>";
		temp += "<td class='center'>话费月份</td><td class='center'>补贴后合计</td><td class='center'>话费</td><td class='center'>固定费</td><td class='center'>补贴</td><td class='center'>代缴</td><td class='center'>套餐费</td><td class='center'>上月余额</td><td class='center'>应缴费</td><td class='center'>调整费</td><td class='center'>滞纳金</td><td class='center'>本月实收</td><td class='center'>本月余额</td><td class='center'>结清</td>";
		temp += "</tr>";
		$("#ghuserInfoPanelTabKF").append(temp);
		
		var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:"tsdCharge",
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xmlattr',//返回数据格式 
				tsdpk:"revenue.koufei"
				});
		
		$.ajax({
			url:"mainServlet.html?" + urlMm + "&hthh="+Hth,
			async:true,
			cache:false,
			timeout:200000,
			type:'post',
			success:function(xml){
				temp = "";
				$("#ghuserInfoPanelTabKF").empty();
				temp += "<tr>";
				temp += "<td class='center'>话费月份</td><td class='center'>补贴后合计</td><td class='center'>话费</td><td class='center'>固定费</td><td class='center'>补贴</td><td class='center'>代缴</td><td class='center'>套餐费</td><td class='center'>上月余额</td><td class='center'>应缴费</td><td class='center'>调整费</td><td class='center'>滞纳金</td><td class='center'>本月实收</td><td class='center'>本月余额</td><td class='center'>结清</td>";
				temp += "</tr>";
				$(xml).find("row").each(function(){
					temp += "<tr>"
					temp += "<td class='center'>";						
					temp += $(this).attr("hzyf");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("btheji");
					temp += "</td>";
					temp += "<td class='right'>";				
					temp += $(this).attr("hf");				
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("gdf");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("butie");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("dj");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("tcf");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("syye_ysk");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("yjf");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("jmhf");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("znj");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("byss");
					temp += "</td>";
					temp += "<td class='right'>";
					temp += $(this).attr("byye_ysk");
					temp += "</td>";
					temp += "<td class='center'>";
					temp += $(this).attr("pay_flag");
					temp += "</td>";
					temp += "</tr>";
				});
				
				$("#ghuserInfoPanelTabKF").append(temp);
			}
		});
		//2012-11-5 yhy end
	}
	
	function ghGetTaoCan(Dh)
	{
		var res = fetchMultiPValue("Revenue.getPackageName",6,"&UserID="+$("#skrid").val()+"&busiclass=phone&nubmer="+Dh);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#ghuserInfoPanelTabTC").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\" class='center'>套餐名称</td><td width=\"150\" class='center'>套餐生效时间</td><td width=\"100\" class='center'>电话费</td><td width=\"100\" class='center'>营业员</td>";
			temp += "</tr>";
			
			$("#ghuserInfoPanelTabTC").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#ghuserInfoPanelTabTC").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\" class='center'>套餐名称</td><td width=\"150\" class='center'>套餐生效时间</td><td width=\"100\" class='center'>电话费</td><td width=\"100\" class='center'>营业员</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td class='center'>";
				temp += res[j][0];
				temp += "</td>";
				temp += "<td class='center'>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td class='center'>";
				temp += res[j][3];
				temp += "</td>";
				temp += "<td class='center'>";
				temp += res[j][2];
				temp += "</td>";
				temp += "</tr>";
			}
			$("#ghuserInfoPanelTabTC").append(temp);
		}
	}
	
	//电话大客户缴费明细
	function ghBigHth()
	{
		//var res  = fetchMultiArrayValue("revenue.bighthdetail",6,"&skrid=" + encodeURIComponent($("#skrid").val()));
		var temp = "";
		$("#multiHthDetailTab").empty();		
		temp += "<tr>";
		temp += "<td>合同号</td><td>用户名称</td><td>电话数量</td><td>应缴费</td><td>话费</td><td>滞纳金</td><td>减免费</td>";
		temp += "</tr>";
		$("#multiHthDetailTab").append(temp);
		
		var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:"tsdCharge",
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xmlattr',//返回数据格式 
				tsdpk:"revenue.bighthdetail"
				});
		
		$.ajax({
			url:"mainServlet.html?" + urlMm + "&skrid="+encodeURIComponent($("#skrid").val()),
			async:true,
			cache:false,
			timeout:200000,
			type:'post',
			success:function(xml){
				temp = "";
				$("#multiHthDetailTab").empty();
				
				temp += "<tr>";
				temp += "<td>合同号</td><td>用户名称</td><td>电话数量</td><td>应缴费</td><td>话费</td><td>滞纳金</td><td>减免费</td>";;
				temp += "</tr>";
				$(xml).find("row").each(function(){
					temp += "<tr>"
					temp += "<td";				
					temp += ">";
					temp += $(this).attr("hth");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("yhmc");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("dhsl");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("yjf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("hf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("znj");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("jmhf");
					temp += "</td>";
					temp += "</tr>";
				});
				
				$("#multiHthDetailTab").html(temp);
			}
		});
	}
	
	//电话大客户缴费明细
	function ghCommonYfHth()
	{
		//var res  = fetchMultiArrayValue("revenue.bighthdetail",6,"&skrid=" + encodeURIComponent($("#skrid").val()));
		var temp = "";
		$("#commonHthYfDetailTab").empty();		
		temp += "<tr>";
		temp += "<td>汇总月份</td><td>本次应缴</td><td>话费</td><td>滞纳金</td><td>市话费</td><td>国内长途</td><td>专网长途</td><td>国际长途</td><td>月租</td><td>专线费</td><td>新功能使用费</td><td>套餐费</td><td>优惠费</td><td>上期余额</td>";
		temp += "</tr>";
		$("#commonHthYfDetailTab").append(temp);
		//滞纳金，市话费，国内长途，专网长途，国际长途，月租，专线费，新功能使用费，套餐费，优惠费，上期余额
		var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:"tsdCharge",
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xmlattr',//返回数据格式 
				tsdpk:"revenue.commonyflist"
				});
		
		$.ajax({
			url:"mainServlet.html?" + urlMm + "&skrid="+encodeURIComponent($("#skrid").val()),
			async:true,
			cache:false,
			timeout:200000,
			type:'post',
			success:function(xml){
				temp = "";
				$("#commonHthYfDetailTab").empty();
				
				temp += "<tr>";
				temp += "<td>汇总月份</td><td>本次应缴</td><td>话费</td><td>滞纳金</td><td>市话费</td><td>国内长途</td><td>专网长途</td><td>国际长途</td><td>月租</td><td>专线费</td><td>新功能使用费</td><td>套餐费</td><td>优惠费</td><td>上期余额</td>";
				temp += "</tr>";
				$(xml).find("row").each(function(){
					temp += "<tr>"
					temp += "<td>";
					temp += $(this).attr("hzyf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("bcyj");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("heji");
					temp += "</td>";					
					temp += "<td>";
					temp += $(this).attr("znj");
					temp += "</td>";					
					temp += "<td>";
					temp += $(this).attr("hf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("gnct");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zwct");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("gjct");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs1");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs3");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs2");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs4");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("zfs5");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("syye_ysk");
					temp += "</td>";
					temp += "</tr>";
				});
				
				$("#commonHthYfDetailTab").html(temp);
				//如果有多个月欠费，则显示明细
				if($("#commonHthYfDetailTab tr").size()>2)
					$("#commonHthYfDetail").show();
			}
		});
	}
	
	
	//取电话用户基本信息
	function ghBasicInfoo(Dh)
	{
		var res = fetchMultiArrayValue("revenue.ghbasicinfo",6,"&Dh="+Dh);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			return false;
		}
		else
		{
			$("#ghuiDh").text(Dh);
			//合同号
			var hth = res[0][0];			
			$("#ghuiHth").text(hth);
			
			var yhmc = res[0][1];
			$("#ghuiYhmc,#ghuisRealNameTitle").text(yhmc);
			
			var yhdz = res[0][6];
			$("#ghuiYhdz").text(yhdz);
			
			var hwjb = res[0][7];
			$("#ghuiHwjb").text(getGhHwjb(hwjb));
			
			var mima = res[0][8];
			$("#ghuiMima").text(mima);			
			
			var regdate = res[0][9];
			// $("#ghuiRegDate").text(regdate);  装机日期，已取消
			
			var startdate = res[0][10];
			$("#ghuiStartDate").text(startdate);
			
			var dhgn = res[0][12];
			$("#ghuiDhgn").text(dhgn);
			//中原油田，取模块局
			var ywarea = res[0][14];
			$("#ghuiYwArea").text(ywarea);
			
						
			var bm1 = res[0][2];
			$("#ghuiBm1").text(bm1);
			var bm2 = res[0][3];
			$("#ghuiBm2").text(bm2);
			var bm3 = res[0][4];
			$("#ghuiBm3").text(bm3);
			var bm4 = res[0][5];
			$("#ghuiBm4").text(bm4);			
						
			//$("#ghInfo").data("hth",hth);
			
			var reshth = fetchMultiArrayValue("revenue.ghbasichthinfo",6,"&Dh="+Dh);
			if(reshth[0]==undefined||reshth[0][0]==undefined)
			{
				return false;
			}
			else
			{
				var yhlb = reshth[0][0];
				$("#ghuiYhlb").text(yhlb);
			}
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
	
	
	
	/////////////////////////查询宽带相关信息////////////////////
	function kdMultiUser(flag,UN)
	{
		if(flag!="1"&&flag!="2")
		{
			flag = 0;
		}
		var keys = [["Revenue.queryByIDM","Revenue.queryCountByIDM"],["Revenue.queryBysDhM","Revenue.queryCountBysDhNameM"],["Revenue.queryBysRealNameM","Revenue.queryCountBysRealNameM"]];
		$("#grid").empty();
		$("#grid").append("<table id=\"bu_muser\" class=\"scroll\"></table><div id=\"bu_pager\" class=\"scroll\"></div>");
		var urlstr = tsd.buildParams({
			packgname:'service',//java包
			clsname:'ExecuteSql',//类名
			method:'exeSqlData',//方法名
			ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			tsdcf:'mysql',//指向配置文件名称
			tsdoper:'query',//操作类型 
			datatype:'xml',
			tsdpk:keys[flag][0],//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			tsdpkpagesql:keys[flag][1],
			tsdUserID:'ture'
		});
		$("#bu_muser").jqGrid({
				url:'mainServlet.html?' +urlstr+ "&UN="+UN, 
				datatype: 'xml', 
				colNames:['操作','姓名','帐号','电话','地址','用户类型'],
				colModel:[{name:'viewOperation',index:'viewOperation',width:50},{name:'sRealName',index:'sRealName',width:80},{name:'UserName',index:'UserName',width:120},{name:'sDh',index:'sDh',width:100},{name:'sAddress',index:'sAddress',width:280},{name:'usertype',index:'usertype',width:80}],
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#bu_pager'),
		       	sortname:'UserName', 
		       	viewrecords: true,
		       	rowNum:10, //默认分页行数
		       	//rowList:[10,20,30], //可选分页行数
		       	sortorder: 'asc', 
		       	//caption:'用户信息', 
		       	height:240,
		       	useDefault:true,
		       	//width:726,
		       	loadComplete:function(){
		        	$("#bu_muser").setSelection(1);
		        	addRowOperBtn('bu_muser','选择','userChoose','UserName','click',1,'sDh','sRealName');
		        	executeAddBtn('bu_muser',1);
		        },
		        ondblClickRow:function(idx){
		        	userChoose($("#bu_muser").getCell(idx,"UserName"),$("#bu_muser").getCell(idx,"sDh"),$("#bu_muser").getCell(idx,"sRealName"));
		        }
			       
			}).navGrid('#bu_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				);
			$("#ChooseForJF").css("visibility","hidden");
			$("#kdSearchWay").css("visibility","hidden");
			autoBlockForm("multiSearch","50","kdMultiSearchClose","#FFFFFF",false);
		}
		
	/**
	 *查询电话相关信息
	 */
	function ghMultiUser(UN)
	{
		var tsdpkstr ='';
		var tsdpkpagesqlstr ='';
		//$("#ghuserInfoPanel").attr('display','none');
		//判断是否拥有受理办公用户缴费权限 true：为有权限 false为无权限  dhyhlbpub
		var dhyhlbpub = $("#dhyhlbpub").val();
		if(dhyhlbpub=="true")
		{
			tsdpkstr='Revenue.queryByUserNamePub';
			tsdpkpagesqlstr='Revenue.queryCountByUserNamePub';
		}else{
			tsdpkstr='Revenue.queryByUserName';
			tsdpkpagesqlstr='Revenue.queryCountByUserName';
		}
		
		$("#ghgrid").empty();
		$("#ghgrid").append("<table id=\"ghbu_muser\" class=\"scroll\"></table><div id=\"ghbu_pager\" class=\"scroll\"></div>");
		var urlstr = tsd.buildParams({
				packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'mysql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',
				tsdpk:tsdpkstr,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				tsdpkpagesql:tsdpkpagesqlstr,
				tsdUserID:'ture'
		});
		$("#ghbu_muser").jqGrid({
				url:'mainServlet.html?' +urlstr+ "&UN="+tsd.encodeURIComponent(UN), 
				datatype: 'xml', 
				colNames:['操作','电话','用户名','合同号','部门','地址'],
				colModel:[{name:'viewOperation',index:'viewOperation',width:50},{name:'sDh',index:'sDh',width:80},{name:'UserName',index:'UserName',width:120},{name:'hth',index:'hth',width:100},{name:'bm1',index:'bm1',width:180},{name:'yhdz',index:'yhdz',width:280}],
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#ghbu_pager'),
		       	sortname:'dh', 
		       	viewrecords: true,
		       	rowNum:10, //默认分页行数
		       	sortorder: 'asc', 
		       	height:240,
		       	useDefault:true,
		       	loadComplete:function(){
		        	$("#ghbu_muser").setSelection(1);
		        	addRowOperBtn('ghbu_muser','选择','nameChoose','UserName','click',1,'sDh','hth');
		        	executeAddBtn('ghbu_muser',1);
		        },
		        ondblClickRow:function(idx){
		        	nameChoose($("#ghbu_muser").getCell(idx,"UserName"),$("#ghbu_muser").getCell(idx,"sDh"),$("#ghbu_muser").getCell(idx,"hth"));
		        }
			       
			}).navGrid('#ghbu_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				);

			autoBlockForm("ghSearch","50","ghMultiSearchClose","#FFFFFF",false);
		}	
	
	function nameChoose(UserName,sDh,sRealName)
	{
		if(kdLock(UserName))
		{
			$('#ghSearchBox').val(sDh);
			$('#ghSearchWay').val(1);
			ghSearch();
			//$('#ghSearchWay').val(3);
			setTimeout($.unblockUI,1);
		}
	}
	
	///////////////////////////////从真实姓名对应的多个账户中选择要缴费的账户///////////////////////
	function userChoose(UserName,sDh,sRealName)
	{    alert('1');
		kdPayQuery(UserName,sRealName);
		if(kdLock(UserName))
		{
		/*****************************************
			Modified by:fenghongyi
			Modified time:2012-12-19
			Modified error:对公用户不能实现续费
		******************************************/

			if(!isSF(UserName) && !isGF(UserName))
			{
				//alert("该公费用户无新业务，无需缴费");
				//$("#kdDJ").attr("disabled","disabled");
				//$("#kdSs").attr("disabled","disabled");
				//$("#kdsave").attr("disabled","disabled");
				$("#kdsave").removeAttr("disabled");
			}
			else
			{
				$("#kdDJ").removeAttr("disabled");
				$("#kdSs").removeAttr("disabled");
				$("#kdsave").removeAttr("disabled");
			}
			
			$("#kdInfoUserName").text(UserName);
			$("#kdInfosDh").text(sDh);
			$("#kdInfosRealName").text(sRealName);
			
			var idx = parseInt($("#kdSearchWay").val(),10);
			if(idx==0)
			{
				$("#kdSearchBox").val(UserName);
			}
			else if(idx==1)
			{
				$("#kdSearchBox").val(sDh);
			}
			else
			{
				$("#kdSearchBox").val(sRealName);
			}
			
			kdFeeName(UserName);
			kdQueryYE(UserName);
			kdQueryRemainFee(UserName);
			kdQueryFee5(UserName);
			
			kdBasicInfoo(UserName);				
			
			kdNewBusinessFee(UserName);
			fetchNewBusinessInfo(UserName);
			
			$("#kdInfo").data("username",UserName);
			
			$("#kduiUserName").text(UserName);
			
			$("#kdUserInfo").removeAttr("disabled");
			
			//if((parseFloat($("#kdInfo").data("remainfee"),10)-parseFloat($("#kdInfo").data("fee5"),10)>0) && checkTC(UserName))
			//{
				//$("#kdTuiFei").removeAttr("disabled");
			//}
			
			$("#ChooseForJF").css("visibility","visible");
			$("#kdSearchWay").css("visibility","visible");
			
			setTimeout($.unblockUI,1);
			
			$("#kdDJ").focus();	
			
		}	
	}
	
	//////////////////////////////////////////////////////////////////////
	/////                     宽带缴费
	////           宽带缴费金额为 
	//////////////////////////////////////////////////////////////////////
	function kdPay()
	{
		var value = 0;
		var b_bc = $.trim($("#kdSs").val());
		if(b_bc!="")
			value += parseFloat(b_bc);		
			
		var UserName = $("#kdInfo").data("username");
		var skrid = $("#skrid").val();
		var params = '';
		
		//代办人信息
       	var bz1 = $("#bz1").val();
       	var bz2 = $("#bz2").val();
       	var bz3 = $("#bz3").val();
       	var bz4 = $("#bz4").val();
       	var bz5 = $("#bz5").val();
       	var bz10 = $("#bz10").val();
       	var acctpaytime= $("#AcctPayTime").val();
       	
       	params += "&bz1="+tsd.encodeURIComponent(bz1);
       	params += "&bz2="+tsd.encodeURIComponent(bz2);
       	params += "&bz3="+tsd.encodeURIComponent(bz3);
       	params += "&bz4="+tsd.encodeURIComponent(bz4);			     
       	params += "&bz5="+tsd.encodeURIComponent(bz5);
		params += "&bz10="+tsd.encodeURIComponent(bz10);
		params += "&acctpaytime=" + tsd.encodeURIComponent(acctpaytime);
		
		if(UserName == null||UserName == undefined||UserName == '')
		{
			alert('请输入要缴费的用户信息');
			$("#kdSearchBox").select();
			$("#kdSearchBox").focus();
			return false;
		}
		else
		{
			params += "&UserName="+UserName;
		}
		if(value == null||value == undefined||value == '') {
			alert('请输入缴费金额！');
			$("#kdDJ").select();
			$("#kdDJ").focus();
			return false;
		} 
		else
		{
			params += "&fillvalue="+value;
		}
		var fee5 = fetchSingleValue("Revenue.fetchFee5",0,"&UserName="+UserName);
		if(fee5 == null||fee5 == undefined||fee5 == '') {
			fee5 = 0;
		}		
				
		params += "&fee5="+fee5;
		
		params += "&back=0";
		params += "&flag=0";
		params += "&area=";
		params += tsd.encodeURIComponent($("#area").val());
		
		
		var loginfo = tsd.encodeURIComponent("宽带 缴费");
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("账号");
		loginfo += ":";
		loginfo += UserName;
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("缴费金额");
		loginfo += ":";
		loginfo += value;
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("流水号");
		loginfo += ":";
		
		
		 var urlstr=tsd.buildParams({ packgname:'service',
			 			clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'broadband',
						tsdExeType:'query',//操作类型 
						datatype:'xmlattr',//返回数据格式 
						tsdpname:'revenue.kdPay',
						tsdUserId:'true'
			 });
				urlstr+=params;
				
				$.ajax({
						url:'mainServlet.html?'+urlstr,
						cache:false,
						datatype:'xml',
						timeout: 1000,
						async: false ,
						success:function(xml){
							$(xml).find("row").each(function(){
								var result=$(this).attr("results");
								
								if(result==0||result==undefined){
									alert('宽带充值失败，请重新操作！');
								}
								else
								{									
									$("#kdInfo").data("kdlsz",result);
									loginfo += result;
									writeLogInfo("","modify",loginfo);
									autoBlockForm("choosePrint","150","close","#FFFFFF",false);	
									$("#printDirect").focus();
								}
							});
						}
				});			
		//解锁
		kdunLock();
	}
	
	
	//////////////////////////////////////////////////////////////////////
	/////                     宽带退费
	////           宽带缴费金额为   调结算的过程
	//////////////////////////////////////////////////////////////////////
	function kdTF()
	{
		var value = 0;
		var b_bc = $.trim($("#kdSs").val());
		if(b_bc!=""){
			value += parseFloat(b_bc);	
		}
		value = value*(-1);	
			
		var UserName = $("#kdInfo").data("username");
		var skrid = $("#skrid").val();
		var params = '';
		if(UserName == null||UserName == undefined||UserName == '')
		{
			alert('请输入要缴费的用户信息');
			$("#kdSearchBox").select();
			$("#kdSearchBox").focus();
			return false;
		}
		else
		{
			params += "&UserName="+UserName;
		}
		
		params += "&fillvalue="+value;
		params += "&flag=0";
		
		var fee5 = fetchSingleValue("Revenue.fetchFee5",0,"&UserName="+UserName);
		if(fee5 == null||fee5 == undefined||fee5 == '') {
			fee5 = 0;
		} 
		params += "&fee5="+fee5;
		
		params += "&back=1";
		
		params += "&area=";
		params += tsd.encodeURIComponent($("#area").val());
		
		//退费备注信息
		var tfbz = $("#addBzText").val();
		tsd.QualifiedVal=true;
		params += "&bz=";
		params += tsd.encodeURIComponent(tfbz);
		if(tsd.Qualified()==false){return false;}
		//关闭备注面板并清空备注框
		setTimeout("$.unblockUI",1000);
		$("#addBzText").val("");
		
		var loginfo = tsd.encodeURIComponent("宽带 退费");
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("账号");
		loginfo += ":";
		loginfo += UserName;
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("退费金额");
		loginfo += ":";
		loginfo += value;
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("流水号");
		loginfo += ":";
		 var urlstr=tsd.buildParams({ packgname:'service',
			 			clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'broadband',
						tsdExeType:'query',//操作类型 
						datatype:'xmlattr',//返回数据格式 
						tsdpname:'revenue.kdPay',
						tsdUserId:'true'
			 });
				urlstr+=params;
				
				$.ajax({
						url:'mainServlet.html?'+urlstr,
						cache:false,
						datatype:'xml',
						timeout: 1000,
						async: false ,
						success:function(xml){
							$(xml).find("row").each(function(){
								var result=$(this).attr("results");
								
								if(result==0||result==undefined){
									alert('宽带退费失败，请重新操作！');
								}
								else
								{									
									$("#kdInfo").data("kdlsz",result);
									loginfo += result;
									loginfo += ";";
									//退费备注信息
									loginfo += tsd.encodeURIComponent("退费备注：");
									loginfo += ":";
									loginfo += tsd.encodeURIComponent(tfbz);
									
									
									writeLogInfo("","modify",loginfo);
									
									autoBlockForm("choosePrintForTuiFei","150","close","#FFFFFF",false);	
									$("#printTDirect").focus();
								}
							});
						}
				});			
		//解锁
		kdunLock();
	}

	
	//设置发票
	function printRep(reportname,params,flag)
	{
		var urll = params+"&"+new Date().getTime();
		if(flag==1)
		{
			params = params.replace(new RegExp("&","g"),"");
			params = params.replace(new RegExp("=","g"),"_");
			printWithoutPreview( reportname,params);
			//printWithoutPreview("commonreport/" + reportname,params);
			
		}else
		{
				var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+reportname+".cpt"+urll;
			 	window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
        		
			 	//var theurl = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/" + reportname + ".cpt&";
			 	//window.open(theurl);
        		 /**
			     printThisReport1('< %=request.getParameter("imenuid")%>',
				 reportname,urll,
				 '< %=(String)session.getAttribute("userid")%>',
				 '< %=request.getParameter("groupid").replaceAll("~", ",")%>',
				 '< %=(String)session.getAttribute("departname")%>',2);
				 */
		}	
	}
	//缴费项目配置
	function pConfig()
	{
		var res=fetchSingleValue("Revenue.config",6,"");
		if(res==undefined)
		{
			return false;
		}
		var pArr = res.split(",");
		for(var i=0;i<pArr.length;i++)
		{
			//宽带缴费项目配置
			$("#chooseForJF").append("<option value=\""+pArr[i]+"\">"+pArr[i]+"</option>");
			//固话缴费项目配置
			$("#chooseForFJ").append("<option value=\""+pArr[i]+"\">"+pArr[i]+"</option>");
		}	
		//alert($("#chooseForJF").html()+"----"+$("#chooseForFJ").html());
		ghCheckCan();
	}
	
	//根据下拉框状态更新面板
	function refreshState(cron)
	{
		if(cron==null || cron==undefined)
			cron = $("#chooseForJF");
		
		if($(cron).val()=="电话费")
		{
			//固话缴费提示信息
			$("#gh").css("display","block");
			$("#kd").css("display","none");
			$("#chooseForJF,#chooseForFJ").val("电话费");//.attr("selected","selected");
			$("#ghSearchBox").select();
		}
		else
		{
			$("#kd").css("display","block");
			$("#gh").css("display","none");
			$("#chooseForJF,#chooseForFJ").val("宽带费");
			$("#kdSearchBox").select();
		}
	}

	//新业务
	function fetchNewBusinessInfo(UserName)
	{
		$("#kduserInfoPanelTabNewBuss").empty();
		
		var newb = fetchMultiArrayValue("Revenue.fetchAttachFee",0,"&UserName="+UserName);
		if(newb[0]==undefined||newb[0][0]==undefined){
			return false;
		}
		var temp = "";
		for(var j=0;j<newb.length;j++)
		{
			temp = "";
			temp += "<tr>";
			temp += "<td width=\"36\"></td>";
			temp += "<td width=\"280\">";
			temp += newb[j][2];
			temp += "</td>";
			temp += "<td>";
			temp += newb[j][1];
			temp += "元";
			temp += "</td>";
			temp += "<tr>";
			
			$("#kduserInfoPanelTabNewBuss").append(temp);
		}
	}
	//宽带新业务费
	function kdNewBusinessFee(UserName)
	{
		var feee = fetchSingleValue("Revenue.fetchSumFee",0,"&UserName="+UserName);
		if(feee==undefined||feee=="")
		{
			feee = "0";
		}
		feee = parseFloat(feee,10);
		
		$("#kdInfo").data("newbusinessfee",feee);
		$("#kduiNewFee").text(feee);
	}
	//宽带 是否公费且有无新业务 
	function isGF(UserName)
	{
		var res = fetchSingleValue("Revenue.checkGF",0,"&UserName="+UserName);
		
		res = parseInt(res,10);
		
		if(res>0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	//宽带 是否私费
	function isSF(UserName)
	{
		var res = fetchSingleValue("Revenue.checkSF",0,"&UserName="+UserName);
		
		res = parseInt(res,10);
		
		if(res>0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	//判断是否可退套餐业务费用 没办则返回 true，办有则返回 false,当拥有退E家费用权限时，也返回false
	function checkTC(UserName)
	{
		var ableTuiFeiEJVar = $("#ableTuiFeiEJ").val();
		if(ableTuiFeiEJVar=="true")
		{
			return true;
		}
			
		var res = fetchSingleValue("Revenue.checkPK",6,"&UserName="+UserName);
		if(res=="0" || res == "" || res == undefined)
		{			
			return true;
		}
		else
		{
			return false;
		}
	}
	//退费按钮事件
	function kdTuiFeiFun()
	{	
		/**
		// 中石油 当前宽带不进行如下汇总过程 2011-11-3
		//汇总
		executeNoQueryProc("revenue.hz",0,"&UserName="+$("#kdInfo").data("username"));	
		*/
		//返回宽带账号使用状态，计算出当前使用费用，返回res[0][0] 1:未完工用户  ;2:最新账期为开始计费 ;3:在当前账期内，需要退费  ;4:已欠停用户 ;		
		var res = fetchMultiPValue("revenue.hz",0,"&UserName="+$("#kdInfo").data("username"));
		var usefee;
		var mons;
		var ye;
		var acctstarttime ;
		var acctstopttime ;	
		if(res != undefined|| res[0][0]!= undefined)
		{
			usefee =res[0][1];
			mons = res[0][2];
			ye =res[0][3];
			acctstarttime =res[0][4];
			acctstopttime =res[0][5];
			var str ='';
			if(res[0][0]==2 )//最新账期为开始计费
			{
				str +='最新账期为开始计费';
				str +='\n账期开始时间为：'+acctstarttime;
				str +='\n账期截止时间为：'+acctstopttime;
				str +='\n账期已使用时间为：'+mons;
				str +='\n账期已用金额为：'+usefee;				
				str +='\n账期余额为：'+ye;
			}
			else if(res[0][0]==31 )//最新账期为开始计费
			{
				str +='最新账期为开始计费';
				str +='\n账期开始时间为：'+acctstarttime;
				str +='\n账期截止时间为：'+acctstopttime;
				str +='\n账期已使用时间为：'+mons;
				str +='\n账期已用金额为：'+usefee;				
				str +='\n账期余额为：'+ye;
			}
			else if(res[0][0]==32 )//需退费
			{
				//str +='最新账期为开始计费';
				str +='\n账期开始时间为：'+acctstarttime;
				str +='\n账期截止时间为：'+acctstopttime;
				str +='\n账期已使用时间为：'+mons;
				str +='\n账期已用金额为：'+usefee;				
				str +='\n账期余额为：'+ye;
			}
			else if(res[0][0]==33 )//包年费用已被冲减完
			{
				str +='包年费用已被月份重冲减完';
				str +='\n账期开始时间为：'+acctstarttime;
				str +='\n账期截止时间为：'+acctstopttime;
				str +='\n账期已使用时间为：'+mons;
				str +='\n账期已用金额为：'+usefee;				
				str +='\n账期余额为：'+ye;
			}
			else if(res[0][0]==4 )//已欠停用户
			{
				str +='该用户已欠停';
			}
			
			alert(str);//输出提示退费信息
			if(res[0][0]==33||res[0][0]==4){//停机用户无须退费
				return ;
			}
		}
		var ontimeYE=ye;
		//alert(res[0][0]+"---"+res[0][1]+"----"+res[0][2]+"---"+res[0][3]);
		/**
		//取实时余额
		var ontimeYE = fetchSingleValue("Revenue.ontimeYE",0,"&UserName="+$("#kdInfo").data("username"));
		ontimeYE = parseFloat(ontimeYE,10);
		//alert(ontimeYE);
		if(ontimeYE<=0)
		{
			alert("实时余额小于0，不能退费");
			return false;
		}
		*/
		$("#kdDJ").val("");
		$("#kdSs").val("");
		$("#kdDJ").attr("disabled","disabled");
		$("#kdSs").attr("disabled","disabled");
		//更新实时余额和退费金额
		$("#kdYE").val(ontimeYE);
		$("#kdSs").val(ontimeYE);
		//更新kdye
		$("#kdInfo").data("kdye",ontimeYE);
		$("#kdInfo").data("kdusefee",usefee);
		//更新新月未出账费用
		kdQueryFee5($("#kdInfo").data("username"));
		$("#kdSsLbl").text("退费金额");
		$("#kdInfo .tuifeijinger").css("display","block");
		$("#kdInfoTuiFei").text(ontimeYE);
		
		if(confirm("你确定要对用户"+$("#kdInfo").data("username")+"进行退费操作？退费金额为："+ontimeYE+" 元"))
		{
			autoBlockForm('addBzForm',5,'addBzClose',"#ffffff",false);
			$("#addBzAddUnt").click(function(){
				if($.trim($("#addBzText").val())=="")
				{
					alert("必须填写退费备注信息");
					$("#addBzText").focus();
					$("#addBzText").select();
				}
				else if($("#addBzText").val().length>100)
				{
					alert("备注长度过长，最大允许100个字符");
					$("#addBzText").focus();
					$("#addBzText").select();
				}
				else
				{
					//保存备注信息 and 退费
					kdTF();
				}
			});
			$("#addBzClose").click(function(){
				//备注面板 关闭
				kdTuiFeiResetFun();
				$("#kdYE").val($("#kdInfo").data("kdye"));
			});
		}
		else
		{
			kdTuiFeiResetFun();
			$("#kdYE").val($("#kdInfo").data("kdye"));
		}
	}
	
	
	//退费后执行的还原事件
	function kdTuiFeiResetFun()
	{
		$("#kdDJ").removeAttr("disabled","disabled");
		$("#kdSs").removeAttr("disabled","disabled");
		$("#kdInfo .tuifeijinger").css("display","none");
		$("#kdStatus :text").val("");
		$("#kdSsLbl").text("实收金额");
	}
	
	/////退费打印
	function kdTPrint(flag)
	{
		var lsz= $("#kdInfo").data("kdlsz");
		if(typeof lsz == "undefined")
		{
			alert("打印失败");
			return false;
		}
		printRep("receipt_broadbandR2","&lsz="+lsz,flag);	
		
		setTimeout($.unblockUI,1);
		
		kdTuiFeiResetFun();
		clearKdInfo();
	}
	

	function kdGetTaoCan(UserName)
	{
		var res = fetchMultiPValue("Revenue.getPackageName",6,"&UserID="+$("#skrid").val()+"&busiclass=broadband&nubmer="+UserName);
		if(res[0]==undefined||res[0][0]==undefined)
		{
			var temp = "";
			$("#kduserInfoPanelTabTC").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\">套餐名称</td><td width=\"150\">套餐生效时间</td><td width=\"100\">宽带费</td><td width=\"100\">营业员</td>";
			temp += "</tr>";
			
			$("#kduserInfoPanelTabTC").append(temp);
			
			return false;
		}
		else
		{
			var temp = "";
			$("#kduserInfoPanelTabTC").empty();
			
			temp += "<tr>";
			temp += "<td width=\"140\">套餐名称</td><td width=\"150\">套餐生效时间</td><td width=\"100\">宽带费</td><td width=\"100\">营业员</td>";
			temp += "</tr>";
			
			for(var j=0;j<res.length;j++)
			{
				temp += "<tr>"
				temp += "<td>";
				temp += res[j][0];
				temp += "</td>";
				temp += "<td>";
				temp += res[j][1];
				temp += "</td>";
				temp += "<td>";
				temp += res[j][3];
				temp += "</td>";
				temp += "<td>";
				temp += res[j][2];
				temp += "</td>";
				temp += "</tr>";
			}
			$("#kduserInfoPanelTabTC").append(temp);
		}
	}
	
	//锁定账号 true可办理 false 不可办理
	function kdLock(UserName)
	{
		var res = fetchMultiPValue("kd.Lock",0,"&userid="+$("#skrid").val()+"&account="+UserName+"&businesstype=fee&flag=in&realname="+tsd.encodeURIComponent("<%=session.getAttribute("username")%>"));
		if(res[0]==undefined||res[0][0]==undefined||res[0][0]=="")
		{
			return true;
		}
		else
		{
			var info = "";
			info += "账号";
			info += UserName;
			info += "正被";
			info += res[0][0];
			info += "受理，请稍等...";
			alert(info);
			return false;
		}
	}
	//解锁账号
	function kdunLock()
	{
		var res = fetchMultiPValue("kd.Lock",0,"&userid="+$("#skrid").val()+"&flag=out");
	}
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////				电话缴费
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	function bindEventToGh()
	{
		//查询输入框回车事件
		$("#ghSearchBox").keydown(function(event){
			if(event.keyCode==13)
			{
				$("#ghSearchByUserName").click();
			}
			else
			{
				//多合同号缴费查询条件使用一次后失效
				$("#ghInfo").removeData("hthlist");
				$("#ghInfo").removeData("hthlistpay");
				if($("#ghFFFs option[cval^='d']").size()>0)
				{
					var tmpPayType = $("#ghInfo").data("paytype");
					$("#ghInfo").data("paytype",$("#ghFFFs option[cval^='d']").remove());
					$("#ghFFFs").append(tmpPayType);
				}
			}
		});
		
		//多合同号缴费面板删除事件
		$("#ghMultiHths").keydown(function(event){
			if(event.keyCode==46)
			{
				var vval = $("#ghMultiHths").val();
				if(vval != null && vval != undefined)
				{
					for(var ii=0;ii<vval.length;ii++)
					{
						$("#ghMultiHths").find("option[value='"+vval[ii]+"']").remove();
					}
					$("#ghMultiHthDetTab :checkbox:checked").attr("checked",false);
					$("#ghMultiHths option").each(function(){
						//hths.push($(this).attr("value"));
						$("#ghMultiHthDetTab :checkbox[value='"+$(this).attr("value")+"']").attr("checked",true);
					});
				}
				else
					alert("请选择要删除的合同号");
			}
		});
		//电话用户信息查询面板
		$("#ghUserInfo").click(function(){openDhUserInfoPanel();});
		
		//生成电话票据
		$(".config_bill").each(function(){
			getBillAlloc($(this).attr("xid"));
		});
		//加载多合同号缴费面板
		ghLoadDept();
		//业务、缴费切换
		$("#ghuiJf").click(function(){
			$("#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC").hide();
			$("#ghuserInfoPanelTabJF").show();
			$("#ghuserInfoPanelTabKF,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiJf").addClass("bolder");
		});
		$("#ghuiJob").click(function(){			
			$("#ghuserInfoPanelTabJF").hide();
			$("#ghuserInfoPanelTabTC").hide();
			$("#ghuserInfoPanelTabJOB").show();
			$("#ghuserInfoPanelTabKF,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiJob").addClass("bolder");
		});
		$("#ghuiGNB").click(function(){			
			$("#ghuserInfoPanelTabJF").hide();
			$("#ghuserInfoPanelTabTC").show();
			$("#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabKF,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiGNB").addClass("bolder");
		});
		$("#ghuiKF").click(function(){			
			$("#ghuserInfoPanelTabJF").hide();
			$("#ghuserInfoPanelTabKF").show();
			$("#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiKF").addClass("bolder");
		});
		$("#ghuiGDF").click(function(){			
			$("#ghuserInfoPanelTabJF,#ghuserInfoPanelTabKF,#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabLTC").hide();
			$("#ghuserInfoPanelTabGDF").show();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiGDF").addClass("bolder");
		});
		$("#ghuiLTC").click(function(){			
			$("#ghuserInfoPanelTabJF,#ghuserInfoPanelTabKF,#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC,#ghuserInfoPanelTabCTC,#ghuserInfoPanelTabGDF").hide();
			$("#ghuserInfoPanelTabLTC").show();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiLTC").addClass("bolder");
		});
		$("#ghuiCTC").click(function(){			
			$("#ghuserInfoPanelTabJF,#ghuserInfoPanelTabKF,#ghuserInfoPanelTabJOB").hide();
			$("#ghuserInfoPanelTabTC,#ghuserInfoPanelTabGDF,#ghuserInfoPanelTabLTC").hide();
			$("#ghuserInfoPanelTabCTC").show();
			$("#ghuserInfoPanelTabRight .bolder").removeClass("bolder");
			$("#ghuiCTC").addClass("bolder");
		});
		//电话缴费用户信息面板配置项
		if(PrintConfig["PayUserInfoJF"]=="N")
			$("#ghuiJf").remove();
		if(PrintConfig["PayUserInfoJob"]=="N")
			$("#ghuiJob").remove();
		if(PrintConfig["PayUserInfoKF"]=="N")
			$("#ghuiKF").remove();
		if(PrintConfig["PayUserInfoGDF"]=="N")
			$("#ghuiGDF").remove();
		if(PrintConfig["PayUserInfoLTC"]=="N")
			$("#ghuiLTC").remove();
		if(PrintConfig["PayUserInfoCTC"]=="N")
			$("#ghuiCTC").remove();
		$(".ghuserInfoTitle:first:visible").click();
		
		//月份选择发生变化时执行
		$("#ghPayMonth").change(function(){
			ghCalYjf();
		});
		//查询按钮事件
		$("#ghSearchByUserName").click(function(){
			ghSearch();
		});
		//拆机按钮事件
		$("#ghTuiFei").click(function(){
			ghChaiJiSearch();
		});
		//付费方式更改
		$("#ghFFFs").change(function(){
			var xcval = $("#ghFFFs option:selected").attr("cval");
			if(xcval==undefined || xcval==null) xcval = "";
			if($("#ghInfo").data("dh")!=undefined && xcval.substr(xcval.length-1,1)=="_")
			{
				var yjje = $("#ghInfo").data("byyecal");
				yjje = parseFloat(yjje);
				
				if(!isNaN(yjje) && yjje<0)
				{
					if(checkExistChaiJi())
					{
						$("#ghDJ").val(yjje);
						$("#ghSs").val(yjje).trigger("keyup");
						
						$("#ghDJ,#ghSs").attr("disabled","disabled");
					}
					else
					{
						var lastval = $("#ghFFFs").attr("lastselected");
						if(lastval==undefined) lastval=$("#ghFFFs option:first").val();
						$("#ghFFFs").val(lastval);
						alert("必须是近期拆机的用户才能办理退费,当前用户无法办理退费");
					}
				}
				else
				{
					alert("当前用户无可退费用");
					var lastval = $("#ghFFFs").attr("lastselected");
					if(lastval==undefined) 
						lastval=$("#ghFFFs option:first").val();
					$("#ghFFFs").val(lastval);
				}
			}
			else
			{
				//$("#ghDJ,#ghSs,#ghYz").val("");
				$("#ghDJ,#ghSs").removeAttr("disabled");
				$("#ghDJ").select().focus();
				$("#ghFFFs").attr("lastselected",$(this).val());
				
				var yjff = $("#ghInfo").data("byyecal");
				yjff = parseFloat(yjff);
				if(isNaN(yjff))
				{
				
				}
				if(yjff>0)
				{
					if($("#ghFFFs").val()=="cash")
					{
						$("#ghDJ,#ghSs").val(Math.ceil(yjff));
						$("#ghYz").val("0.00");
					}
					else
					{
						$("#ghDJ,#ghSs").val(yjff);
						$("#ghYz").val("0.00");
					}
				}
				
			}
			
			//切换显示
			//$(".config_bill").hide();
			$(".config_bill[xid='" + $("#ghFFFs option:selected").attr("cval") + "']").show();
			
			//如果已经查询用户，则变更缴费方式时同步更新票据
			if($("#ghInfo").data("dh")!=undefined){
				phoneInfo();
			}
			$(".billdeflet[pjid='sflx']").html($("#ghFFFs option:selected").text());
		});
		//固定费复选框费复选框
		$("#ghOnlyGH").click(function(){$("#ghDJ").select();$("#ghDJ").focus();});
		
		//长市话费复选框
		$("#ghOnlyCSH").click(function(){$("#ghDJ").select();$("#ghDJ").focus();});
		
		//递交金额输入框回事事件
		$("#ghDJ").keydown(function(event){
			if(event.keyCode==13)
			{
				//取应交金额的值
				var yj = $("#ghYJ").val();
				yj=parseFloat(yj,10);
				
				//取递交金额的值
				var dj = $("#ghDJ").val();
				dj=parseFloat(dj,10);
				if(isNaN(dj)) dj=0;
				
				//固定费选中状态
				var ghOnlyGHChk = $("#ghOnlyGH").attr("checked");
				//长市话费选中状态
				var ghOnlyCSHChk = $("#ghOnlyCSH").attr("checked");
				//检测是否已进行用户查询
				if($("#ghInfo").data("dh")==undefined)
				{
					alert("请先进行用户查询");
					$("#ghSearchBox").select().focus();
					return false;
				}
				if($.trim($("#ghDJ").val())=="")
				{
					alert("请输入递交金额");
					$("#ghDJ").select().focus();
					return false;
				}
				if($("#ghInfo").data("hthlistpay")=="Y")
				{
					if(yj==0){
						alert("多合同号缴费时应缴金额为0，无须缴费");
						return false;
					}
				}
				/*
				if(dj==0)
				{					
					alert("递交金额不能等于0");
					$("#ghDJ").select().focus();
					return false;
				}*/
				if($("#ghInfo").data("tuifei")!="T")  //如果不是退费
				{
					//判断是否允许少收
					if(PrintConfig["PayLevel"]=="1" && dj<yj)
					{
						alert("当前应缴" + yj + "元，递交金额不能小于应缴金额");
						$("#ghDJ").select().focus();
						return false;
					}
					
					//判断是否有应缴金额，如果有，则默认
					/*
					if(yj>0)
						$("#ghSs").val(Math.ceil(yj)).select().focus();
					else
						$("#ghSs").val($("#ghDJ").val()).select().focus();
					*/
					$("#ghSs").val($("#ghYJ").val()).select().focus();
				}
			}
		});
		//实收金额输入框键盘事件
		$("#ghSs").keydown(function(event){
			if(event.keyCode==13)
			{
				//取应交金额的值
				var yj = $("#ghYJ").val();
				yj=parseFloat(yj,10);
				
				//取递交金额的值
				var dj = $("#ghDJ").val();
				dj=parseFloat(dj,10);
				if(isNaN(dj)) dj = 0;
				//取实收金额的值
				var ss = $("#ghSs").val();
				ss=parseFloat(ss,10);
				if(isNaN(ss)) ss=0;
				
				//检测是否已进行用户查询
				if($("#ghInfo").data("dh")==undefined)
				{
					alert("请先进行用户查询");
					$("#ghSearchBox").select().focus();
					return false;
				}
				//多合同号缴费
				if($("#ghInfo").data("hthlistpay")=="Y")
				{
					var yj = $("#ghYJ").val();
					yj=parseFloat(yj,10);
					if(yj==0){
						alert("多合同号缴费时应缴金额为0，无须缴费");
						return false;
					}
				}
				//实收金额必须大于0
				/*
				if(ss==0)
				{
					alert("实收金额不能为0");
					$("#ghSs").select();
					$("#ghSs").focus();
					return false;
				}*/
				if($.trim($("#ghDJ").val())=="")
				{
					alert("请输入递交金额");
					$("#ghDJ").select().focus();
					return false;
				}
				if($.trim($("#ghSs").val())=="")
				{
					alert("请输入实收金额");
					$("#ghSs").select().focus();
					return false;
				}
				//多合同号缴费
				if($("#ghInfo").data("hthlistpay")=="Y")
				{
					var yj = $("#ghYJ").val();
					yj=parseFloat(yj,10);
					if(yj!=ss){
						alert("多合同号缴费时实收金额必须等于应缴金额");
						$("#ghSs").select().focus();
						return false;
					}
				}
				//判断是否有递交金额
				if(ss > dj)
				{
					alert("实收金额不能大于递交金额");
					$("#ghSs").select().focus();
					return false;
				}
				if($("#ghInfo").data("tuifei")!="T")
				{
					//判断是否允许少收
					if(PrintConfig["PayLevel"]=="1" && ss<yj)
					{
						alert("当前应缴" + yj + "元，实收金额不能小于应缴金额");
						$("#ghSs").select().focus();
						return false;
					}
					//判断是否允许多收
					if(PrintConfig["PayLevel"]=="2" && ss<yj)
					{
						alert("当前应缴" + yj + "元，实收金额不能大于应缴金额");
						$("#ghSs").select().focus();
						return false;
					}
					//判断是否必须与实收金额相同
					if(PrintConfig["PayLevel"]=="3" && ss!=yj)
					{
						alert("当前应缴" + yj + "元，实收金额必须与应缴金额相同");
						$("#ghSs").select().focus();
						return false;
					}
				}
				//执行保存
				$("#ghsave").click();
			}
		}).keyup(function(){
			if($.trim($("#ghSs").val())=="")
			{
				$("#kdYz").val("");
			}
			else
			{
				var dj = parseFloat($("#ghDJ").val(),10).toFixed(2);
				var ss = parseFloat($("#ghSs").val(),10).toFixed(2);
				dj = parseFloat(dj,10);
				ss = parseFloat(ss,10);
				if(isNaN(dj)) dj = 0;
				if(isNaN(ss)) ss = 0;
				
				if(ss>dj)
				{
					alert("实收金额不能大于递交金额");
					var ssv = $("#ghSs").val();
					$("#ghSs").val(ssv.substring(0,ssv.length-1));
					$("#ghSs").select();
					$("#ghSs").focus();
					return false;
				}
				$("#ghYz").val((dj-ss).toFixed(2));
			}
		});
		
		//电话缴费  保存
		$("#ghsave").click(function(){
			//取应交金额的值
			var yj = $("#ghYJ").val();
			yj=parseFloat(yj,10);
			if(isNaN(yj)) yj = 0;
			//取递交金额的值
			var dj = $("#ghDJ").val();
			dj=parseFloat(dj,10);
			if(isNaN(dj)) dj = 0;
			//取实收金额的值
			var ss = $("#ghSs").val();
			ss=parseFloat(ss,10);
			if(isNaN(ss)) ss = 0;
			//检测是否已进行用户查询
			if($("#ghInfo").data("dh")==undefined)
			{
				alert("请先进行用户查询");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
				return false;
			}
			//多合同号缴费
			if($("#ghInfo").data("hthlistpay")=="Y")
			{
				if(yj==0){
					alert("多合同号缴费应缴金额为0，无须缴费");
					return false;
				}
			}
			//判断递交金额是否是有效数字
			if(isNaN(dj))
			{
				alert("请输入递交金额");
				$("#ghDJ").select();
				$("#ghDJ").focus();
				return false;
			}
			if($("#ghInfo").data("tuifei")!="T")
			{
				//判断是否允许少收
				if(PrintConfig["PayLevel"]=="1" && dj<yj)
				{
					alert("当前应缴" + yj + "元，递交金额不能小于应缴金额");
					$("#ghDJ").select().focus();
					return false;
				}
			}
			//只有一个缴费单元时判断递交金额是否大于应缴金额
			/*
			if(dj<yj && ($("#ghDJ").attr("disabled")==undefined || $("#ghDJ").attr("disabled")==false))
			{
				alert("递交金额不能小于应缴金额");
				$("#ghDJ").select();
				$("#ghDJ").focus();
				return false;
			}
			*/
			
			/////是否有实收金额
			if(isNaN(ss))
			{
				alert("请输入实收金额");
				$("#ghSs").select();
				$("#ghSs").focus();
				return false;
			}
			if($.trim($("#ghDJ").val())=="")
				{
					alert("请输入递交金额");
					$("#ghDJ").select().focus();
					return false;
				}
				if($.trim($("#ghSs").val())=="")
				{
					alert("请输入实收金额");
					$("#ghSs").select().focus();
					return false;
				}
			//实收金额小于或等于0
			/*if(ss == 0)
			{
				alert("实收金额必须等于0");
				$("#ghSs").select();
				$("#ghSs").focus();
				return false;
			}*/
			//多合同号缴费
			if($("#ghInfo").data("hthlistpay")=="Y")
			{
				if(yj!=ss){
					alert("多合同号缴费时实收金额必须等于应缴金额");
					$("#ghSs").select().focus();
					return false;
				}
			}
			//实收金额必须大于递交金额
			if(ss > dj)
			{
				alert("实收金额不能大于递交金额");
				$("#ghSs").select();
				$("#ghSs").focus();
				return false;
			}
			if($("#ghInfo").data("tuifei")!="T")
			{
				//判断是否允许少收
				if(PrintConfig["PayLevel"]=="1" && ss<yj)
				{
					alert("当前应缴" + yj + "元，实收金额不能小于应缴金额");
					$("#ghSs").select().focus();
					return false;
				}
				//判断是否允许多收
				if(PrintConfig["PayLevel"]=="2" && ss<yj)
				{
					alert("当前应缴" + yj + "元，实收金额不能大于应缴金额");
					$("#ghSs").select().focus();
					return false;
				}
				//判断是否必须与实收金额相同
				if(PrintConfig["PayLevel"]=="3" && ss!=yj)
				{
					alert("当前应缴" + yj + "元，实收金额必须与应缴金额相同");
					$("#ghSs").select().focus();
					return false;
				}
			}
			//电话缴费 确认面板
			var info = "确认缴费\n\n";
			info += "合同号:\t\t";
			info += $("#ghInfo").data("hth");
			info += "\t\t\t";
			info += "\n电话号码:\t";
			info += $("#ghInfo").data("dh");
			info += "\t\t\t";
			
			info += "\n用户名:\t\t";
			info += $("#ghInfo").data("yhmc");
			
			info += "\n本月余额:\t";
			info += $("#ghInfo").data("byye");
			info += "\n递交金额:\t";
			info += $("#ghDJ").val();
			info += "\n实收金额:\t";
			info += $("#ghSs").val();
			info += "\n应找金额:\t";
			info += $("#ghYz").val();
			//add by whm 
			info += "\n发票抬头:\t";
			info+= $("#regText1").val();
			info += "\n发票金额:\t";
			info+= $("#regText2").val();
			info += "\n联系方式:\t";
			info+= $("#regText3").val();
			info += "\n备    注:\t";
			info+= $("#regText4").val();
			
			//AmountInWords 页面显示票据金额
			$("span[xjid='bcssd']").html(AmountInWords($("#ghSs").val(),2));
			$("span[xjid='bcsss']").html($("#ghSs").val());
			
			if($("#ghInfo").data("tuifei")!="T")
			{
				if(confirm(info))
				{
					if(ghJiaoFei() && ghJiaoFeiSuccess())
					{
						if(PrintConfig["ChoosePrint"]=="Y")
							setTimeout("autoBlockForm('choosePrintForDhJF','150','close','#FFFFFF',false)",25);
						else if(PrintConfig["ChoosePrint"]=="O")
						{
							//不打印票据
							ghClearInfo();
						}
						else{
							ghPrint(1);
						}
						$("#ghSearchBox").select().focus();
					}
				}
			}
			else
			{
				if(ghJiaoFei() && ghJiaoFeiSuccess())
				{					
					if(PrintConfig["ChoosePrint"]=="Y")
						setTimeout("autoBlockForm('choosePrintForDhJF','150','close','#FFFFFF',false)",25);
					else if(PrintConfig["ChoosePrint"]=="O")
					{
						//不打印票据
						ghClearInfo();
					}
					else
						ghPrint(1);
				}
			}
		});
		
		//电话缴费余额分配面板 固定费输入框 回车事件
		$("#ghDitForGH").keydown(function(event){
			if(event.keyCode==13)
			{
				$("#ghHfDistributionSave").click();
			}
		});
		//设置全局变量
		ghSetGlobalParam();
		//电话缴费方式
		ghSetPayName();
		//默认移除大客户缴费方式
		$("#ghInfo").data("paytype",$("#ghFFFs option[cval^='d']").remove());
		
		ghexecuteDelete();
		$("#ghHfDistributionForm").draggable({handle:"#thisdrag"});
		$(window).unload(function(){
			ghexecuteDelete();
		});
	}
	/////检测是否可以进行电话缴费
	function ghCheckCan()
	{
		Sys_Config = fetchMultiKVValue("Duty.sysConfig",6,"",["tsection","tvalues"]);
		var dhPayForbid = fetchSingleValue("Duty.sysDhPayConfig",6,"");
		//如果设置有禁止电话缴费，则同时禁用电话功能
		if(dhPayForbid=="Y")
			Sys_Config["Phone"] = "Y";
			
		if(Sys_Config["Broadband"]=="Y" && $("#chooseForJF option").size()>1)
		{
			$("#chooseForJF,#chooseForFJ").find("option[value='宽带费']").remove();
		}
		if(Sys_Config["Phone"]=="Y" && $("#chooseForJF option").size()>1)
		{
			$("#chooseForJF,#chooseForFJ").find("option[value='电话费']").remove();
		}
		
		refreshState();
		if($("#chooseForJF option").size()==1)
			$("#chooseForJF,#chooseForFJ").attr("disabled","disabled");
	}
	/////电话设置全局变量
	function ghSetGlobalParam()
	{
		$("#global_param1").val(fetchSingleValue('revenue.globalParam1',6,""));
		$("#global_param2").val(fetchSingleValue('revenue.globalParam2',6,""));
		$("#global_param3").val(fetchSingleValue('revenue.globalParam3',6,""));
		$("#global_param4").val(fetchSingleValue('revenue.globalParam4',6,""));
		$("#global_param5").val(fetchSingleValue('revenue.globalParam5',6,""));//TSectio='收费结账' and TIdent='当前收费月份'
		
		if(typeof($("#global_param5").val()) == 'undefined')
		{
			alert("不能收费");
		}
	}
	
	/////删除当前登录用户的**信息
	function ghexecuteDelete()
	{
		executeNoQuery('revenue.del1',1,"&skrid=" + $("#skrid").val());
		executeNoQuery('revenue.del2',1,"&skrid=" + $("#skrid").val());
		executeNoQuery('revenue.del3',1,"&skrid=" + $("#skrid").val());
	}
	/////电话取新功能
	function ghNewGongNeng()
	{
		var res=fetchSingleValue("revenue.fetchXinGoneNeng",6,"&dh="+$("#ghInfo").data("dh"));
	}
	
	//当日营收统计
	function ghAndKdStatus()
	{
		//宽带费
		var broadband_total=parseFloat(fetchSingleValue('revenue.radJFStatus',0,""));
		//电话费
		var phone_total=parseFloat(fetchSingleValue('revenue.JFStatus',1,""));
		
		if(isNaN(broadband_total))
			broadband_total=0;
		if(isNaN(phone_total))
			phone_total=0;
		$("#统计标签").html("当日营收合计："+(broadband_total+phone_total).toFixed(2)+"元；其中电话费："+phone_total.toFixed(2)+"元；宽带费："+broadband_total.toFixed(2)+"元");
		
	}
	//用户付费类型
	function ghUserType()
	{
		//获取用户类型
		var p_callPayType=fetchSingleValue("revenue.fetchCallPayType",1,"&dh=" + $("#ghInfo").data("dh") + "&hth=" + $("#ghInfo").data("dh"));
		$("#用户类型标签").val(p_callPayType=="0"?"免费用户":(p_callPayType=="1"?"后付费用户":(p_callPayType=="2"?"预付费用户":"限额用户")));
	}
	
	//电话缴费余额分配
	function ghDistribution(obj)
	{
		var ye = $.trim($("#ghDitTotal").text());
		ye = parseFloat(ye,10);
		if(isNaN(ye)) ye = 0;
		
		var ghGH = obj.value;
		ghGH = parseFloat(ghGH,10);
		if(isNaN(ghGH)) ghGH = 0;
		
		if(ghGH <= ye)
		{
			$("#ghDitForCSH").val((ye - ghGH).toFixed(2));
		}
		else
		{
			alert("固定费用不能大于可能分配余额");
			obj.value = obj.value.substring(0,obj.value.length-1);
			obj.select();
			obj.focus();
			return false;
		}
	}


	/////电话缴费查询
	function ghSearch()
	{
		
		if($('#ghSearchWay').val()==3)
		{
			var username=$('#ghSearchBox').val();
			if(username=="")
			{
				alert("请输入要查询的电话号码");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
				return false;
			}
			ghMultiUser(username);//显示查询用户面板
			//ghClearInfoWithoutSearchBox();//清空面板
		}else{
			
			ghClearInfoWithoutSearchBox();//清空面板
			var dhNum = $.trim($("#ghSearchBox").val());
			//判断是否为多合同号缴费
			if($("#ghInfo").data("hthlistpay")=="Y")
			{
				dhNum = $("#ghInfo").data("hthlist");
			}
			if(dhNum=="")
			{
				alert("请输入要查询的电话号码");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
			}
			else
			{
				tsd.QualifiedVal=true;
				dhNum = tsd.encodeURIComponent(dhNum);
				if(tsd.Qualified()==false){
					$("#ghSearchBox").select();
					$("#ghSearchBox").focus();
					return false;
				}
				//alert(dhNum);
				//判断是否拥有受理办公用户缴费权限 true：为有权限 false为无权限  dhyhlbpub
				var dhyhlbpub = $("#dhyhlbpub").val();
				if(dhyhlbpub=="false")
				{
					var res = fetchMultiValue("Revenue.ifbangong",6,"&UN="+dhNum);
					if(res[0]!=undefined && res[0]>=1)
					{
						alert('该电话为办公用户，不能受理收费。');
						$("#ghSearchBox").select();
						$("#ghSearchBox").focus();
						return ;
					}				
				}				

				if(ghCheckHth()&&ghCalYjf())
				{
					ghMonthFee();	//取欠费月份
					//var ye=fetchSingleValue("Revenue.fetchFee5",0,"&UserName="+UserName);
					//恢复保存按钮为可用状态
					$("#ghsave").removeAttr("disabled");
					//可打印未收费票据
					$("#ghUnpaymentPrint").removeAttr("disabled");
					
					//恢复用户信息查询面板可用
					if($("#ghInfo").data("hthlistpay")!="Y")
					{
						$("#ghUserInfo,#ghTuiFeiBtn").removeAttr("disabled");
						//ghZyjb(dhNum); //2012-03-12注释的
						//电话用户基本信息
						ghBasicInfoo($.trim($("#ghInfo").data("dh")));
						ghRefreshStatus($.trim($("#ghInfo").data("dh")));
					}
					else
					{
						$("#ghUserInfo").attr("disabled","disabled");
					}
					//2012-11-5 yhy start
					//去用户当月的话费和本月余额
					var hth = $("#ghInfo").data("hth");
					var redata = fetchMultiArrayValue("Revenue.getghbyxx",6,"&hth=" + hth);
					//当多合同号查询的时候，不显示该区域
					if(redata.length=1){						
						$("#ghbyxx").show();
					}else{
						$("#ghbyxx").hide();
					}
					
					if(redata[0] !=undefined && redata[0][0]!=undefined){
						//当用户为免费或后付费用户，当前话费余额从hfmax字段中获取
						//当用户为预付费用户，当前话费余额从maxhf字段中获取
						var CallPayType = redata[0][3];
						if( CallPayType=='0' || CallPayType=='1' ){
							$("#ghbyxxByye").text(redata[0][2]);
						}else if( CallPayType=='2' ){
							$("#ghbyxxByye").text(redata[0][1]);
						}
						$("#ghbyxxByhf").text(redata[0][0]);
						
					}
					//2012-11-5 yhy end
				}
			}
		
		}
		
		//多合同号缴费查询条件使用一次后失效
		//$("#ghInfo").removeData("hthlist");
		//$("#ghInfo").removeData("hthlistpay");
	}
	//拆机按钮 事件
	function ghChaiJiSearch()
	{
		//是否选了多个合同号
		if($("#ghInfo").data("hthlistpay")=="Y")
		{
			alert("当前为多合同号缴费模式，无法进行拆机结算");
			$("#ghSearchBox").select().focus();
			return false;
		}
		ghClearInfoWithoutSearchBox();//电话  清空页面信息  不清除查询框
		var dhNum = $.trim($("#ghSearchBox").val());
		if(dhNum=="")
		{
			alert("请输入要查询的电话号码");
			$("#ghSearchBox").select();
			$("#ghSearchBox").focus();
		}
		else
		{
			//2012-11-5 yhy start
			//添加确定是否要进行结账算费提示
			if(confirm("您确定要进行结账算费吗？")){
				//验证参数是否正确
				tsd.QualifiedVal=true;
				dhNum = tsd.encodeURIComponent(dhNum);//拆机电话号码
				if(tsd.Qualified()==false){
					$("#ghSearchBox").select();
					$("#ghSearchBox").focus();
					return false;
				}
				//电话缴费 当前输入账号是否允许缴费，并记录缴费电话和合同号
				//获取拆机费用节约
				if(ghCheckHth()&&ghChaiJiCalYjf())
				{
					phoneInfo();
					//恢复用户信息查询面板可用
					$("#ghUserInfo,#ghTuiFeiBtn").removeAttr("disabled");
					//电话用户基本信息
					ghBasicInfoo($.trim($("#ghSearchBox").val()));
					//恢复保存按钮为可用状态
					$("#ghsave").removeAttr("disabled");
					//可打印未收费票据
					$("#ghUnpaymentPrint").removeAttr("disabled");
				}
			}
			//2012-11-5 yhy end
		}
	}
	
	//检测指定电话号码是否有预退费记录
	function checkExistYTF()
	{
		var res = fetchSingleValue("Revenue.existsYTF",1,"&DhOrHth=" + encodeURIComponent($("#ghInfo").data("dh")));
		if(res=="0")
		{
			return true;
		}
		else
		{
			alert("该电话号码已存在预退费记录，请先到电话退费模块进行退费");
			return false;
		}
	}
	//检测是否有有效的私转公记录
	function checkExistPrivateToPublic()
	{
		var res = fetchSingleValue("Revenue.existsPrivateToPublic",7,"&DhHth=" + encodeURIComponent($("#ghInfo").data("hth")));
		if(res=="0" || res=="" || res==undefined)
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	//检测是否有有效的拆机记录
	function checkExistChaiJi()
	{
		var res = fetchSingleValue("Revenue.existsChaiJi",7,"&DhOrHth=" + encodeURIComponent($("#ghInfo").data("hth")));
		if(res=="0" || res=="" || res==undefined)
		{
			return false;
		}
		else
		{
			return true;
		}
	}
	////////////////////////////////////////////////////////////////////////////
	////                     电话缴费方式
	////////////////////////////////////////////////////////////////////////////
	function ghSetPayName()
	{
		var paynames = fetchMultiArrayValue("revenue.nfetchPayName",6,"");
		$.each(paynames,function(i,n){
			$("#ghFFFs").append("<option rptfile=\"" + n[1] + "\" cval=\""+ n[2] +"\" value=\"" + n[2] +"\"" + (n[0]==""?" selected=\"selected\"":"") + ">" + n[0] + "</option>");
		});
	}
	
	/////弹出缴费分配框
	function ghShowDit()
	{
		//固定费应缴金额
		var ghyj = $("#ghGHYJ").val();
		ghyj = parseFloat(ghyj,10);
		if(isNaN(ghyj) || ghyj<0) ghyj = 0;
		
		//长市话费应缴金额
		var cshyj = $("#ghCSHYJ").val();
		cshyj = parseFloat(cshyj,10);
		if(isNaN(cshyj) || cshyj<0) cshyj = 0;
		
		//实收金额
		var ss = $("#ghSs").val();
		ss = parseFloat(ss,10);
		if(isNaN(ss)) ss = 0;
		
		//显示合计
		$("#ghDitTotal").text((ss - ghyj - cshyj).toFixed(2));
		
		//弹出缴费框
		autoBlockForm('ghHfDistributionForm',100,'ghHfDistributionClose',"#FFFFFF",false);
		$("#ghDitForGH").val("");
		$("#ghDitForCSH").val("");
	}
	
	//取欠费月份
	function ghMonthFee()
	{
		var months = fetchMultiArrayValue("revenue.fetchMonthFee",1,"&skrID="+$("#skrid").val());
		if(months[0].length<1)
			return false;
		$("#ghPayMonth").empty();
		$.each(months,function(i,n){
			$("#ghPayMonth").append("<option value=\"" + n[0] + "\">" + n[0] + "</option>");
		});
		
		$("#ghPayMonth").val(months[months.length-1]);
	}
	
	//电话  清空页面信息
	function ghClearInfo()
	{
		//欠费月份清空
		$("#ghPayMonth").empty();
		$("#ghUserInfo,#ghTuiFeiBtn").attr("disabled","disabled");
		//电话缴费信息栏 输入框清空
		$("#ghStatus :text").val("");
		//将递交金额输入框，实收金额输入框置为可用
		$("#ghDJ,#ghSs").removeAttr("disabled");
		
		//清空票据
		$(".config_bill span").empty();
		$("#ghInfo").removeData("dh");
		$("#ghInfo").removeData("hth");
		
		$("#ghInfo").removeData("ssye");
		$("#ghInfo").removeData("byyecal");
		
		$("#ghInfo").removeData("hthlist");
		$("#ghInfo").removeData("hthlistpay");
		$("#ghmhdept1,#ghmhyhlb,#ghSingleAddInput").val("");
		$("#ghMultiHths").find("option").remove();
		$("#ghMultiHthDetTab").html("");
		//将保存按钮置为不可用
		$("#ghsave").attr("disabled","disabled");
		//可打印未收费票据
		$("#ghUnpaymentPrint").attr("disabled","disabled");
		$("#ghYHYE").attr("tip2","当前月费用： 元");
		$("#ghYHYE").attr("tip1","实时余额： 元");
		$("#ghYHYE .tip").html("实时余额：元, 当前月费用：元");
		$("#ghYHYE .jfed").html("");
				
		$("#ghFFFs").val($("#ghFFFs option:first").val());
		$("#ghFFFs").trigger("change");
		
		$("#multiHthDetail,#commonHthYfDetail").hide();
		$("#multiHthDetailTab,#commonHthYfDetailTab").html("");		
		$("#ghmhdept1").val("").trigger("change");
		$("#ghMultiHths option").remove();
		
		//ghexecuteDelete();  清空之后发票无法获取数据
		$("#ghSearchBox").val("");
		$("#ghSearchBox").select();
		$("#ghSearchBox").focus();
		$('#regText1').val("");
		$('#regText2').val("");
		$('#regText3').val("");
		$('#regText4').val("");
		document.getElementById('showtext1').style.display="none";
		document.getElementById('showtext2').style.display="none";	
		$('#isInvoicing').attr("checked",false);
		$("#ghPayReport").attr("checked",false);
	}
	
	//电话  清空页面信息  不清除查询框
	function ghClearInfoWithoutSearchBox()
	{
		//欠费月份清空
		$("#ghPayMonth").empty();
		$("#ghUserInfo,#ghTuiFeiBtn").attr("disabled","disabled");
		//电话缴费信息栏 输入框清空
		$("#ghStatus :text").val("");
		//将递交金额输入框，实收金额输入框置为可用
		$("#ghDJ,#ghSs").removeAttr("disabled");
		//清空票据
		$(".config_bill span").empty();
		
		$("#ghInfo").removeData("dh");
		$("#ghInfo").removeData("hth");
		
		$("#ghInfo").removeData("ssye");
		$("#ghInfo").removeData("byyecal");
				
		//将保存按钮置为不可用
		$("#ghsave").attr("disabled","disabled");
		//可打印未收费票据
		$("#ghUnpaymentPrint").attr("disabled","disabled");
		//清空用户余额
		$("#ghYHYE").attr("tip2","当前月费用： 元");
		$("#ghYHYE").attr("tip1","实时余额： 元");
		$("#ghYHYE .tip").html("实时余额：元, 当前月费用：元");
		$("#ghYHYE .jfed").html("");
		
		$("#ghFFFs").val($("#ghFFFs option:first").val());
		$("#ghFFFs").trigger("change");
		
		$("#multiHthDetail,#commonHthYfDetail").hide();
		$("#multiHthDetailTab,#commonHthYfDetailTab").html("");
		$("#ghmhdept1").val("").trigger("change");
		$("#ghMultiHths option").remove();
		
		//ghexecuteDelete();	清空之后发票无法获取数据
	    $('#regText1').val("");
		$('#regText2').val("");
		$('#regText3').val("");
		$('#regText4').val("");
		document.getElementById('showtext1').style.display="none";
		document.getElementById('showtext2').style.display="none";	
			$('#isInvoicing').attr("checked",false);
		$("#ghPayReport").attr("checked",false);
	}


	/////电话缴费 当前输入账号是否允许缴费，并记录缴费电话和合同号
	function ghCheckHth()
	{
		var area = $("#area").val();
		var skrid = $("#skrid").val();
		var dhNum = $("#ghSearchBox").val();
		//多合同号缴费
		if($("#ghInfo").data("hthlistpay")=="Y")
		{
			dhNum = $("#ghInfo").data("hthlist");
		}
		tsd.QualifiedVal=true;
		var param = "&Area=";
		param += tsd.encodeURIComponent(area);
		param += "&SkrID=";
		param += tsd.encodeURIComponent(skrid);
		param += "&Hth=";
		param += tsd.encodeURIComponent(dhNum);
		param += "&Version=200404";
		if(tsd.Qualified()==false){$("#ghSearchBox").select();$("#ghSearchBox").focus();return false;}
		
		res = fetchMultiPValue("revenue.HFYS_Check_Hth",1,param);
		if(res[0]!=undefined && res[0][0]!=undefined && res[0][0] == "")
		{
		
			if($("#ghInfo").data("hthlistpay")!="Y")  // 如果不是多合同号缴费，记录电话号，合同号信息
			{
				//记录电话号码
				$("#ghInfo").data("dh",$.trim($("#ghSearchBox").val()));
				//获取电话和合同号
				var redata = fetchMultiArrayValue("Revenue.fetchHth",6,"&hthdh=" + tsd.encodeURIComponent($.trim($("#ghSearchBox").val())));
				if(redata[0]!=undefined && redata[0][0]!=undefined)
				{
					$("#ghInfo").data("dh",redata[0][1]);
					$("#ghInfo").data("hth",redata[0][0]);
				}
				else
				{
					$("#ghInfo").data("dh",$.trim($("#ghSearchBox").val()));
				}
			}
			else  // 如果是多合同号缴费，记录电话号，合同号信息
			{
				//记录电话号码
				$("#ghInfo").data("dh",$.trim($("#ghInfo").data("hthlist")));
				var redata = fetchMultiArrayValue("Revenue.fetchHth",6,"&hthdh=" + tsd.encodeURIComponent($.trim($("#ghInfo").data("hthlist"))));
				if(redata[0]!=undefined && redata[0][0]!=undefined)
				{
					$("#ghInfo").data("dh",redata[0][1]);
					$("#ghInfo").data("hth",redata[0][0]);
				}
				else
				{
					$("#ghInfo").data("dh",$.trim($("#ghInfo").data("hthlist")));
				}
			}
			return true;
		}
		else
		{
			var searchWay=$('#ghSearchWay').val();
			if(searchWay==3)
			{
				$("#ghSearchBox").select().focus();
				return false;
			}
			alert(res[0][0]==undefined?"当前输入账号无法缴费，请联系管理人员":res[0][0]);
			$("#ghSearchBox").select().focus();
			return false;
		}
	}
	
	/////电话缴费  查询应缴费
	function ghCalYjf()
	{
		var area = $("#area").val();
		var skrid = $("#skrid").val();
		var multiparam = "";
		if($("#ghInfo").data("hthlistpay")=="Y" && $("#ghMultiHthFlag:checked").size()>0)
		{
			multiparam = "&tickettype=combined";
		}
		//缴费月份
		var sjm ;
		if($("#ghPayMonth").val()=="" || $("#ghPayMonth").val()==null)
		{
			sjm = $("#global_param5").val();
		}
		else
		{
			sjm =$("#ghPayMonth").val();
		}
		//
		var resss = fetchMultiPValue("revenue.HFYS_Cacul_Yjf",1,"&SkrID="+skrid+"&Sj_SfMonth="+sjm+"&sSkfs="+tsd.encodeURIComponent($("#ghFFFs").val())+"&Area="+tsd.encodeURIComponent(area)+"&Kemu=" + tsd.encodeURIComponent("电话费")+"&Version=200501" + multiparam);
		if(resss[0]!=undefined||resss[0][3]!=undefined)
		{
			if(resss[0][3]=='')
			{
				var yjff = parseFloat(resss[0][0],10);
				if(isNaN(yjff)) yjff = 0;
				$("#ghYJ").val(yjff<0?'0':yjff.toFixed(2));//合计应缴
				if(yjff<=0)
				{
					alert('该用户已缴费！')
				}
				//如果有缴费，默认递交金额和实收金额
				if(yjff>0)
					//$("#ghDJ,#ghSs").val(Math.ceil(yjff));
				//如果是大客户缴费，递交实收默认为应缴金额
				if($("#ghInfo").data("hthlistpay")=="Y" && yjff>0)
				{
					$("#ghDJ,#ghSs").val(yjff);
					$("#ghYz").val("0");
				}
				
				if(yjff<0)
					$("#ghYHYE span.jfed").html("，当前账期已缴费");
				else
					$("#ghYHYE span.jfed").html("");
					
				//余额提示
				var ssye = parseFloat(resss[0][1],10);
				if(isNaN(ssye)) {
					ssye = "0.00";
				}
				else {
					ssye = ssye.toFixed(2);
				}
				ghShowYE(ssye);
				//实时余额
				$("#ghInfo").data("ssye",ssye);
				$("#ghInfo").data("byyecal",yjff);
				
				if(resss[0][2]=="0")
				{
					PrintConfig["PayLevel"] = "3";
				}
				else if(resss[0][2]=="1")
				{
					PrintConfig["PayLevel"] = "1";
				}
				else if(resss[0][2]=="2")
				{
					PrintConfig["PayLevel"] = "4";
				}
				else
				{
					PrintConfig["PayLevel"] = "3";
				}
				
				if(PrintConfig["YcTip"]=="Y")
				{
					//标识缴费类型 是普通电话还是小灵通  检测标准：以3开头的标识为小灵通用户，否则为普通电话
					var jfltype = 0;				
					if($("#ghInfo").data("dh")!=undefined && $("#ghInfo").data("dh").charAt(0)=="3")
					{
						jfltype = 1;
					}
					if(yjff>0)
					{
						$("#ghFFFs").val($("#ghFFFs option[cval$='-']:first").val());
						$("#ghFFFs").trigger("change");
						alert("当前用户已欠费 "+(yjff)+" 元，缴费票据将使用结算单");
					}
					else
					{
						$("#ghFFFs").val($("#ghFFFs option[cval$='+']:first").val());
						$("#ghFFFs").trigger("change");
						alert("当前用户尚有余额 "+(yjff*(-1))+" 元，缴费票据将使用预存单");
					}
				}
				//递交金额输入框获得焦点
				$("#ghDJ").select();
				$("#ghDJ").focus();
				
				phoneInfo();
				return true;//成功
			}
			else
			{
				alert(resss[0][3]==undefined?resss[0][0]:resss[0][3]);
				$("#ghSearchBox").select().focus();
				return false;
			}
		}
		else
		{
			alert("未知错误！");
			$("#ghSearchBox").select().focus();
			return false;
		}
	}
	
	//电话缴费
	function ghJiaoFei()
	{
		//电话缴费实收金额
		var ghss = $("#ghSs").val();
		ghss = parseFloat(ghss,10);
		
		//缴费
		//var res=fetchSingleValue("revenue.JiaoFei",1,"&Bcss=" + ghss + "&Bcss_gdf=0&skrID="+$("#skrid").val() + "&skfs=" + tsd.encodeURIComponent($("#ghFFFs").val()));
		var res = fetchMultiPValue("revenue.JiaoFei",1,"&Version=200404&Kemu="+tsd.encodeURIComponent("电话费")+"&Bcss=" + ghss + "&Bcss_gdf=0&SkrID="+$("#skrid").val() + "&Skfs=" + tsd.encodeURIComponent($.trim($("#ghFFFs").val())));
		if(res=="")
		{
			//alert("jiaofei suc");
			return true;
		}
		else
		{
			alert("缴费失败:"+res);
			return false;
		}
	}
	//缴费确认
	function ghJiaoFeiSuccess()
	{
		//电话缴费实收金额
		var ghss = $("#ghSs").val();
		ghss = parseFloat(ghss,10);
		
		var loginfo = tsd.encodeURIComponent("电话 缴费");
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("电话号码");
		loginfo += ":";
		loginfo += $("#ghInfo").data("dh");
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("合同号");
		loginfo += ":";
		loginfo += $("#ghInfo").data("hth");
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("收款方式");
		loginfo += ":";
		loginfo += tsd.encodeURIComponent($.trim($("#ghFFFs").val()));
		loginfo += ";";
		loginfo += tsd.encodeURIComponent("金额");
		loginfo += ":";
		loginfo += ghss;
		
		var fpinfo;
		fpinfo="";
		if ($.trim($("#regText1").val()).length>1) {fpinfo+="发票抬头："+$("#regText1").val()+". ";}
		if ($.trim($("#regText2").val()).length>1) {fpinfo+="发票金额："+$("#regText2").val()+". ";}
		if ($.trim($("#regText3").val()).length>1) {fpinfo+="联系方式："+$("#regText3").val()+". ";}
		if ($.trim($("#regText4").val()).length>1) {fpinfo+="备    注："+$("#regText4").val()+". ";}
		if (fpinfo!="")
		{
			//alert('1'+fpinfo);
			var res = fetchMultiPValue("revenue.JiaoFeiChengGong",1,"&Version=200404&Kemu="+tsd.encodeURIComponent("电话费")+"&Bcss=" + ghss + "&SkrID="+$("#skrid").val() + "&Skfs=" + tsd.encodeURIComponent($.trim($("#ghFFFs").val()))+"&fpinfo=" + tsd.encodeURIComponent(fpinfo));
		}
		else
		{
			//alert('2'+fpinfo);
			var res = fetchMultiPValue("revenue.JiaoFeiChengGong",1,"&Version=200404&Kemu="+tsd.encodeURIComponent("电话费")+"&Bcss=" + ghss + "&SkrID="+$("#skrid").val() + "&Skfs=" + tsd.encodeURIComponent($.trim($("#ghFFFs").val())));
		}
//		var res=fetchMultiArrayValue("revenue.JiaoFeiChengGong",1,"&Bcss=" + ghss + "&skrID="+$("#skrid").val() + "&skfs=" + tsd.encodeURIComponent($("#ghFFFs").val()));
		//var res = fetchMultiPValue("revenue.JiaoFeiChengGong",1,"&Version=200404&Kemu="+tsd.encodeURIComponent("电话费")+"&Bcss=" + ghss + "&SkrID="+$("#skrid").val() + "&Skfs=" + tsd.encodeURIComponent($.trim($("#ghFFFs").val()));
		if(res[0][0]==""||res[0][0]=="SUCCEED")
		{
			writeLogInfo("","modify",loginfo);
			return true;
		}
		else
		{
			if(res[0][1]!=undefined)
			{
				alert(getretdescript("Hfys_Bill_Ok",res[0][1],"","",$("#lanType").val()));
			}
			return false;
		}
	}
	
	/////获取拆机费用节约 电话缴费  拆机
	function ghChaiJiCalYjf()
	{
		var area = $("#area").val();
		var skrid = $("#skrid").val();
		//
		var resss = fetchMultiPValue("revenue.HFYS_Cacul_Yjf",1,"&SkrID="+skrid+"&Sj_SfMonth="+tsd.encodeURIComponent("实时结清")+"&sSkfs="+tsd.encodeURIComponent($("#ghFFFs").val())+"&Area="+tsd.encodeURIComponent(area)+"&Kemu=" + tsd.encodeURIComponent("电话费")+"&Version=200501");
		//resss[0][0] 已缴费用 resss[0][1]余额 resss[0][2]缴费方式
		if(resss[0]!=undefined && resss[0][3]!=undefined)
		{
			if(resss[0][3]=='')
			{
			    ghMonthFee();	//取欠费月份  
			    
				var yjff = parseFloat(resss[0][0],10);
				
				if(isNaN(yjff)) yjff = 0;
				//alert("测试！"+yjff);
				$("#ghYJ").val(yjff<0?'0':yjff.toFixed(2));//合计应缴
				var sssye = parseFloat(resss[0][1],10);
				if(isNaN(sssye)) {  sssye = 0;     }
				ghShowYE(sssye.toFixed(2));
				//实时余额
				$("#ghInfo").data("ssye",sssye.toFixed(2));
				$("#ghInfo").data("byyecal",yjff);
				
				if(resss[0][2]=="0")
				{
					PrintConfig["PayLevel"] = "3";
				}
				else if(resss[0][2]=="1")
				{
					PrintConfig["PayLevel"] = "1";
				}
				else if(resss[0][2]=="2")
				{
					PrintConfig["PayLevel"] = "4";
				}
				else
				{
					PrintConfig["PayLevel"] = "3";
				}
				
				if(PrintConfig["YcTip"]=="Y")
				{
					if(parseFloat(resss[0][1],10)>=0){
						alert("电话号码 " + $("#ghInfo").data("dh") + " 实时余额为 " + sssye.toFixed(2) + " 元.");
					}
					else{
						alert("电话号码 " + $("#ghInfo").data("dh") + " 已欠费 " +sssye*(-1).toFixed(2) + " 元.");
					}
					//标识缴费类型 是普通电话还是小灵通  检测标准：以3开头的标识为小灵通用户，否则为普通电话
					var jfltype = 0;				
					if($("#ghInfo").data("dh")!=undefined && $("#ghInfo").data("dh").charAt(0)=="3")
					{
						jfltype = 1;
					}
					if(yjff>0)
					{
						$("#ghFFFs").val($("#ghFFFs option[cval$='-']:first").val());
						$("#ghFFFs").trigger("change");
					}
					else
					{
						$("#ghFFFs").val($("#ghFFFs option[cval$='+']:first").val());
						$("#ghFFFs").trigger("change");
					}
				}
				//递交金额输入框获得焦点
				$("#ghDJ").select().focus();
					if(yjff<0)
				{
					alert('该用户当前余额:'+yjff+'元');
					
					ghTuiFeiCfm();
					/**
					return true;//成功
					*/
					
				}
				return true;//成功
			}
			else
			{
				alert(resss[0][3]);
				return false;
			}
		}
		else
		{
			alert(resss[0]==undefined?"unknow fault":resss[0]);
			$("#ghDJ").select().focus();
			return false;
		}
	}
	//存储实时余额信息 和 未出账费用信息
	function ghShowYE(ye)
	{
		var hths = $("#ghInfo").data("hth");
		if($("#ghInfo").data("hthlistpay")=="Y"){
			hths = $("#ghInfo").data("hthlist");
		}
		var htadd = fetchSingleValue("revenue.hthontimeye",6,"&Hth=" + tsd.encodeURIComponent(hths));
		
		$("#ghYHYE").attr("tip2","当前月费用：" + (isNaN(parseFloat(htadd))?"0.00":parseFloat(htadd).toFixed(2)) + " 元");
		if(ye>=0){
			$("#ghYHYE").attr("tip1","实时余额：" + (ye) + " 元");
		}
		else{
			$("#ghYHYE").attr("tip1","实时欠费：" + (ye*(-1)) + " 元");
		}
		$("#ghYHYE .tip").html($("#ghYHYE").attr("tip2") +", "+ $("#ghYHYE").attr("tip1"));
	}
	//解析话务级别
	function getGhHwjb(hwjb)
	{
		if(hwjb=="") hwjb="~";
		var res = fetchSingleValue("revenue.hwjb",6,"&hwjbb=" + tsd.encodeURIComponent(hwjb));
		if(res==undefined) res = "";
		return res;
	}
	
	//取电话重要级别
	function ghZyjb(Dh)
	{
		return;
	}
	
	function phoneInfo()
	{
		$("#chooseTel").html('电话号码');
		var sshe = 0;
		var choose=$('#ghSearchWay').val();
		var urlMm = tsd.buildParams({ packgname:'service',
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:'tsdCharge',
					tsdcf:'mssql',//指向配置文件名称
					tsdoper:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpk:"revenue.fetchPhoneInfo"
					});
		$.ajax({
			url:"mainServlet.html?" + urlMm + "&SkrID="+ $("#skrid").val(),//012",// ,
			async:false,
			cache:false,
			timeout:1000,
			success:function(xml){
				$(xml).find("row:first").each(function(){
					billAllocFill($.trim($("#ghFFFs option:selected").attr("cval")),$(xml));
					
					$("#ghInfo").data("yhmc",$(this).attr("yhmc"));
					$("#ghInfo").data("byye",parseFloat($(this).attr("byye_ysk"))==0?"":parseFloat($(this).attr("byye_ysk")).toFixed(2));
					
					//用于未收费票据打印的参数 hth 、流水号
					var hfys_hth = $(this).attr("hth");
					var hfys_out_bz4 = $(this).attr("out_bz4");
					
					$("#unpaymentHth").val(hfys_hth);
					$("#unpaymentLsh").val(hfys_out_bz4);
					/*
					//用户名称
					$("#pyhmc").html($(this).attr("yhmc"));
					//电话
					$("#pdhhm").html($(this).attr("dh"));
					//合同号
					$("#phth").html($(this).attr("hth"));
					
					//收费月份
					$("#pjfyf").html($(this).attr("out_bz2"));
					
					//序号
					$("#pid").html($(this).attr("out_bz4"));
					//备注
					$("#pbz").html($(this).attr("out_bz11"));
					//收款人
					$("#pskr").html($(this).attr("skr"));
					//缴费月份
					*/
					try{
						var datarow = $(this);
						var dataval = undefined;
						$(".config_bill[xid='"+$.trim($("#ghFFFs option:selected").attr("cval"))+"'] span.billdeflet").not($(".ghInfo table span.billdeflet")).each(function(){
							var dataid = $(this).attr("pjid");
							if(dataid!=undefined && $.trim(dataid)!="")
							{
								if(dataid.indexOf("+")<0)   // 解析报表定义中的单一字段项
								{
									dataval = $(datarow).attr(dataid);
									if(dataval==null || dataval==undefined){
										dataval = "<font color=\"red\">E</font>";
									}
									$(this).html(dataval);
								}
								else
								{
									var dataidarr = [dataid];
									if(dataid.indexOf("+")>-1) {
										dataidarr = dataid.split("+");  // 解析报表定义中的多字段项
									}
									var tmpo = 0;alert(dataidarr);
									for(var jl=0;jl<dataidarr.length;jl++)
									{
										var tpov = $(datarow).attr(dataidarr[jl]);
										tpov = parseFloat(tpov,10);
										if(isNaN(tpov)) tpov = 0;
										tmpo += tpov;
									}
									$(this).html(PrintConfig["ShowZero"]=="Y"?tmpo.toFixed(2):(tmpo==0?"":tmpo.toFixed(2)));
								}
							}
						});
						datarow = null;
						//费用项 多行值 
						$(".config_bill[xid='"+$.trim($("#ghFFFs option:selected").attr("cval"))+"'] .ghInfo table span.billdeflet").each(function(){
							var dataid = $(this).attr("pjid");
							var spancellthis = $(this);
							if(dataid!=undefined && $.trim(dataid)!="")
							{
								var dataidarr = [dataid];
								if(dataid.indexOf("+")>-1) dataidarr = dataid.split("+"); // 解析报表定义中的多字段项
								var tmpo = 0;
								$(xml).find("row").each(function(){
									
									for(var jl=0;jl<dataidarr.length;jl++)
									{
										var tpov = $(this).attr(dataidarr[jl]);
										tpov = parseFloat(tpov,10);
										if(isNaN(tpov)) tpov = 0;
										tmpo += tpov;
									}
								});
								var trunctype = $(spancellthis).attr("trunc");
								if(trunctype == "int")
									tmpo = Math.round(tmpo);
								else
									tmpo = tmpo.toFixed(2);
									
								$(spancellthis).html(PrintConfig["ShowZero"]=="Y"?tmpo:(tmpo==0?"":tmpo));
								spancellthis = null;
							}
						});
						if(choose==2)
						{
							$("#chooseTel").html('合同号');
							$("span[pjid='dh']").html($("#ghInfo").data("hth"));	
						}
					}catch(e)
					{
						alert(e.message);
					}
					//付款方式
					$(".billdeflet[pjid='sflx']").html($("#ghFFFs option:selected").text());
					
					if(PrintConfig["ShowJFDetail"]=="Y")
					{
						if($("#ghInfo").data("hthlistpay")=="Y")
						{
							var res = fetchMultiArrayValue("revenue.bighth",6,"&skrid=" + encodeURIComponent($("#skrid").val()));
							if(res[0]!=undefined && res[0][0]!=undefined)
							{
								$(".config_bill[xid^='d'] span.billdeflet[pjid='yhmc']").html(res[0][0]);
								$(".config_bill[xid^='d'] span.billdeflet[pjid='hth']").html(res[0][1]);//dtransfer						
							}
							
							$("#multiHthDetail").show();
							$("#commonHthYfDetail").hide();
							$("#commonHthYfDetailTab").html("");
							ghBigHth();
						}
						else
						{
							$("#multiHthDetailTab").html("");
							$("#multiHthDetail").hide();
							ghCommonYfHth();
						}
					}
				});			
			}
		});
	}
	//解析指定票据数据
	function billAllocFill(billname,data)
	{
		//取指定票据表格中的span
		var spanarr = $(".config_bill[xid='"+billname+"'] .ghInfo .billdefsmalllet span");
		
		var spid,fid;
		$.each(spanarr,function(i,n){
			spid = $(n).attr("id");
			fid = spid.substring(spid.lastIndexOf("_@")+2);
			fid = fid.split("+");
			
			$(n).html(billAnalize(billname,data,fid));
		});
	}
	//解析指定字段的值
	function billAnalize(billname,data,fieldarr)
	{
		var heji = 0;
		var tmp = 0;
		for(var i=0;i<fieldarr.length;i++)
		{
			$(data).find("row").each(function(){
				tmp = parseFloat($(this).attr(fieldarr[i].toLowerCase()));
				
				if(isNaN(tmp)) tmp = 0;
				
				heji += tmp;
			});			
		}
		return PrintConfig["ShowZero"]=="Y"?heji.toFixed(2):(heji==0?"":heji.toFixed(2));
	}
	//自动生成票据
	function getBillAlloc(billname)
	{
		if($(".config_bill[xid='" + billname + "'] .ghInfo .billdefsmalllet").size()<1)
			return;
		var billarr = fetchMultiArrayValue("Revenue.fetchBillAlloc",6,"&BillN=" + tsd.encodeURIComponent(billname));
		//alert(billarr);
		var tabHtml = "";
		var idx = 1,i = 0;
		for(idx=1;idx<=billarr.length;idx++)
		{
			if(idx%4==1) tabHtml += "<tr>";
			tabHtml += "<td width=\"88\">";
			tabHtml += billarr[idx-1][0];
			tabHtml += "</td>";
			tabHtml += "<td width=\"67\"><span id=\"billalloc_@";
			tabHtml += billname;
			tabHtml += "_@";
			tabHtml += billarr[idx-1][1];
			tabHtml += "\"></span></td>";
			if(idx%4==0) tabHtml += "</tr>";
		}
		if(billarr.length%4!=0)
		{
			idx = 4-billarr.length%4;
			for(i=0;i<idx;i++)
				tabHtml += "<td width=\"88\"></td><td width=\"67\"></td>";
			tabHtml += "</tr>";
		}
		$(".config_bill[xid='" + billname + "'] .ghInfo .billdefsmalllet").html(tabHtml);
	}
	//多合同号缴费面板
	function ghLoadDept()
	{
		var res = fetchMultiArrayValue("revenue.bm1list",6,"");
		var optHtml = "<option value=\"\">请选择</option>";
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
			}
		}
		$("#ghmhdept1").html(optHtml);
		//二级地址
		$("#ghmhdept1").bind("change",function(){
			var tval = $("#ghmhdept1").val();
			if(tval=="") tval="~";
			res = fetchMultiArrayValue("revenue.bm2list",6,"&bm1=" + tsd.encodeURIComponent(tval));
			optHtml = "<option value=\"\">请选择</option>";
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml += "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
				}
			}
			$("#ghmhdept2").html(optHtml).trigger("change");
			//ghLoadHthList();
			$("#ghMultiHths option").remove();
		});
		//三级地址
		$("#ghmhdept2").bind("change",function(){
			var tval = $("#ghmhdept2").val();
			var bm1 = $("#ghmhdept1").val();
			if(tval=="") tval="~";
			if(bm1=="") bm1="~";
			res = fetchMultiArrayValue("revenue.bm3list",6,"&bm1=" + tsd.encodeURIComponent(bm1) + "&bm2=" + tsd.encodeURIComponent(tval));
			optHtml = "<option value=\"\">请选择</option>";
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml += "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
				}
			}
			$("#ghmhdept3").html(optHtml).trigger("change");
			//ghLoadHthList();
		});
		//四级地址
		$("#ghmhdept3").bind("change",function(){
			var tval = $("#ghmhdept3").val();
			var bm1 = $("#ghmhdept1").val();
			var bm2 = $("#ghmhdept2").val();
			if(tval=="") tval="~";
			if(bm1=="") bm1="~";
			if(bm2=="") bm2="~";
			res = fetchMultiArrayValue("revenue.bm4list",6,"&bm1=" + tsd.encodeURIComponent(bm1) + "&bm2=" + tsd.encodeURIComponent(bm2) + "&bm3=" + tsd.encodeURIComponent(tval));
			optHtml = "<option value=\"\">请选择</option>";
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml += "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
				}
			}
			$("#ghmhdept4").html(optHtml).trigger("change");			
		});
		
		$("#ghmhdept4").bind("change",function(){
			ghLoadHthList();
		});
		
		res=fetchMultiArrayValue("revenue.yhlblist",6,"");
		optHtml = "<option value=\"\">请选择</option>";
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii][1] + "\">" + res[ii][1] + "</option>";
			}
		}
		
		$("#ghmhyhlb").html(optHtml).change(function(){
			ghLoadHthList();
		});
		
		//合同号列表选择触发
		$("#ghMultiHthDetTab td :checkbox").live("click",function(){
			/*  更换显示方式 
			var hths = "";
			var hthsdis = "";
			$("#ghMultiHthDetTab td :checkbox:checked").each(function(){
				hths += "," + $(this).val();
				hthsdis += "," + $(this).parent().text();
			});
			$("#ghMultiHths").val(hthsdis.replace(",","").replace(/,/g,"\n"));
			*/
			var hths = $(this).val();
			var hthsdis = $(this).parent().text();
			/*
			if($("#ghInfo").data("hthlist")!=undefined)
			{
				var obj = $("#ghInfo").data("hthlist");
				alert($("#" + $(this).attr("id") + ":checked").size());
				if($("#" + $(this).attr("id") + ":checked").size()==0)
					delete obj[hths];
				else
					obj[hths]=hthsdis;
				
				$("#ghInfo").data("hthlist",obj);
			}
			else
			{
				var obj = new Object();
				obj[hths]=hthsdis;
				$("#ghInfo").data("hthlist",new Object());
				
			}
			//触发textarea显示事件	
			ghDisMultiHthToArea();
			*/
			if($("#" + $(this).attr("id") + ":checked").size()>0)
			{
				//if($.inArray(hths,$("#ghMultiHths").val().split("\n"))==-1)
					//$("#ghMultiHths").val($.trim($("#ghMultiHths").val()+"\n"+hths));
				if($("#ghMultiHths").find("option[value='" + hths + "']").size()==0)
					$("#ghMultiHths").append("<option value='"+hths+"'>"+hths+"</option>");
			}
			else
			{
				/*var cval = $("#ghMultiHths").val();
				$("#ghMultiHths").val("");
				if(cval!="")
				{
					var hthsss = cval.split("\n");
					for(var ik=0;ik<hthsss.length;ik++)
						if(hthsss[ik]!=hths)
							$("#ghMultiHths").val($.trim($("#ghMultiHths").val()+"\n"+hthsss[ik]));
				}*/
				$("#ghMultiHths").find("option[value='" + hths + "']").remove();
			}
		});
		$("#ghMultiHthDetTab td span").live("click",function(){
			$(this).parent().find(":checkbox:first").click();
		});
	}
	
	function ghLoadHthList()
	{
		var bm1 = $("#ghmhdept1").val();
		var bm2 = $("#ghmhdept2").val();
		var bm3 = $("#ghmhdept3").val();
		var bm4 = $("#ghmhdept4").val();
		var yhlb = $("#ghmhyhlb").val();
		
		if($("#ghmhdept1").val()=="") bm1="'~'"; else bm1="'" + bm1 + "'";
		if($("#ghmhdept2").val()=="") bm2="bm2 or bm2 is null"; else bm2="'" + bm2 + "'";
		if($("#ghmhdept3").val()=="") bm3="bm3 or bm3 is null"; else bm3="'" + bm3 + "'";
		if($("#ghmhdept4").val()=="") bm4="bm4 or bm4 is null"; else bm4="'" + bm4 + "'";
		if($("#ghmhyhlb").val()=="") yhlb="yhlb or yhlb is null"; else yhlb="'" + yhlb + "'";
		
		var res = fetchMultiArrayValue("revenue.hthlist",6,"&bm1=" + tsd.encodeURIComponent(bm1) + "&bm2=" + tsd.encodeURIComponent(bm2) + "&bm3=" + tsd.encodeURIComponent(bm3) + "&bm4=" + tsd.encodeURIComponent(bm4) + "&yhlb=" + tsd.encodeURIComponent(yhlb));
		ghDrawHths(res);
	}
	
	function ghDrawHths(hths)
	{
		if(hths[0]!=undefined && hths[0][0]!=undefined)
		{
			var tabHtml = "";
			var ii = 0;
			var colspan = 6;
			for(ii = 0;ii<hths.length;ii++)
			{
				if((ii+1)%colspan==1)
					tabHtml += "</tr><tr>";
					
				tabHtml += "<td><input type=\"checkbox\" id=\"gmh_" + hths[ii][0] + "\" value=\"" + hths[ii][0] + "\" usertype=\""+hths[ii][2]+"\" /><span title=\"合同号：" +hths[ii][0]+ ";用户姓名："+hths[ii][1]+"\" for=\"gmh_" + hths[ii][0] + "\">" + hths[ii][0] + "<span></td>";				
			}
			if(ii%colspan!=0)
			{
				var kk = ii%colspan;
				while(kk<colspan)
				{
					tabHtml += "<td></td>";
					kk++;
				}
				tabHtml += "</tr>";
			}
			
			tabHtml = tabHtml.replace("</tr>","");
			if(hths.length>0)
				tabHtml = "<tr><td style=\"text-align:center;\" colspan=\"" + colspan + "\"><button class=\"tsdbutton\" style=\"margin-bottom: 0px;line-height:22px\" onclick=\"$('#ghMultiHthDetTab :checkbox').not(':checked').click()\">全选</button><button class=\"tsdbutton\" style=\"margin-bottom: 0px;line-height:22px\" onclick=\"$('#ghMultiHthDetTab :checkbox').click()\">反选</button></td></tr>" + tabHtml;
			//alert(tabHtml);
			$("#ghMultiHthDetTab").html(tabHtml);
		}
		else
			$("#ghMultiHthDetTab").html("");
			
		$("#ghMultiHths option").each(function(){
			//hths.push($(this).attr("value"));
			$("#ghMultiHthDetTab :checkbox[value='"+$(this).attr("value")+"']").attr("checked",true);
		});
	}
	/**
		添加单个合同号
	*/
	function ghSingleAddToHths()
	{
		var hthinput = $.trim($("#ghSingleAddInput").val());
		if(hthinput==""){
			alert("请输入要添加的合同号");
			$("#ghSingleAddInput").select().focus();
			return false;
		}
		var res = fetchMultiArrayValue("revenue.hthck",6,"&hthh="+tsd.encodeURIComponent(hthinput));
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			var yhmc = res[0][1];
			var hth = res[0][0];
			//alert(typeof $("#ghInfo").data("hthlist"));
			/*
			if($("#ghInfo").data("hthlist")!=undefined)
				$("#ghInfo").data("hthlist")[hth]=hth;
			else
			{
				var obj = new Object();
				obj[hth]=hth+"("+yhmc+")";
				$("#ghInfo").data("hthlist",obj);
			}
			
			ghDisMultiHthToArea();
			*/
			/*
			if($("#ghMultiHths").find("option[value='" + hth + "']").size()==0)
				$("#ghMultiHths").append("<option value='"+hth+"'>"+hth+"</option>");
			else
			{
				alert("你所添加的号码已经存在");
				$("#ghMultiHths").val(hth);
				$("#ghSingleAddInput").select().focus();
			}
			
			*/
			//如果输入的是大客户号，则查询二级合同号
			if(res[0][2]=="1")
				res = fetchMultiArrayValue("revenue.getthreehth",6,"&hthh="+tsd.encodeURIComponent(hthinput));
			ghDrawHths(res);
		}
		else
		{
			alert("你所输入的合同号不存在");
			$("#ghSingleAddInput").select().focus();
		}
	}
	/**
		显示对象数据
	*/
	function ghDisMultiHthToArea()
	{
		var obj = $("#ghInfo").data("hthlist");
		var objstr = "";
		if(obj!=undefined && typeof obj=='object')
		{
			for(var key in obj)
				objstr += obj[key] + "\n";
		}alert(typeof objstr + " - " + objstr);
		$("#ghMultiHths").val(objstr);
	}
	/**
		弹出多合同号输入面板
	*/
	function ghOpenMultiHthForm()
	{
		autoBlockForm('ghMultiHthJf',20,'ghMultiHthJfclose',"#FFFFFF",false);
		//如果 是第一次打开面板，获取用户性质
		/*
		if($("#ghInfo").data("multiPayYhxzInit")!="true")
			ghMultiPayYhxz();
		*/
	}
	
	/**
		多合同号缴费确认面板
	*/
	function ghMultiHthJfPay()
	{
		var hths = [];
		$("#ghMultiHths option").each(function(){
			hths.push($(this).attr("value"));
		});
		hths = hths.join(",");
		if(hths=="" || hths==undefined)
		{
			alert("请设置要缴费的合同号");
			return false;
		}
		var hthd = hths;//.replace(new RegExp("\n+","g"),",").replace(new RegExp("\\s+","g"),"");
		//检测输入的合同号的正确性
		var ress = fetchMultiPValue("revenue.multihthcheck",6,"&pnums=" + tsd.encodeURIComponent(hthd));
		if(ress[0]!=undefined && ress[0][0]!=undefined)
		{
			if(ress[0][0]=="ERROR")
			{
				if(ress[0][1]=="No nums input")
					alert("请输入合同号");
				else
					alert(ress[0][1] + " 为无效合同号,请确认输入正确的合同号");
				return false;
			}
		}
		$("#ghInfo").data("hthlist",hthd);
		$("#ghInfo").data("hthlistpay","Y");
		$("#ghSearchBox").val("...");
		
		var tmpPayType = $("#ghInfo").data("paytype");
		$("#ghInfo").data("paytype",$("#ghFFFs option").not("##ghFFFs option[cval^='d']").remove());//dtransfer
		$("#ghFFFs").append(tmpPayType);
		
		setTimeout($.unblockUI,100);
		
		setTimeout("ghSearch()",100);
	}
	/**
		多合同号缴费用户性质
	*/
	function ghMultiPayYhxz()
	{
		var res = fetchMultiArrayValue("revenue.yhxzlist",6,"");
		var tabHtml = "";
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			for(var ii=0;ii<res.length;ii++)
			{
				tabHtml += "<td><label style=\"width:70px;margin-left:0px;\"><input type=\"checkbox\" class=\"multiPayCheckbox\" id=\"multiPayYhxzCheckbox"+res[ii][1]+"\" yhxz=\""+res[ii][1]+"\" />"+res[ii][0]+"</label></td>";
			}
			if(tabHtml!="")
				tabHtml = "<table width=\"580\"><tr><td>按性质选择：</td>" + tabHtml + "</tr></table>";
		}
		$("#multiPayYhxz_Container").html(tabHtml);
		$("#multiPayYhxz_Container .multiPayCheckbox:checkbox").click(function(){
			//$('#ghMultiHthDetTab :checkbox')
			var yhxz = $(this).attr("yhxz");
			//alert(typeof $(this).attr("checked"));
			if($(this).attr("checked"))
				$("#ghMultiHthDetTab :checkbox[usertype='"+yhxz+"']").not(":checked").click();
			else
				$("#ghMultiHthDetTab :checkbox:checked[usertype='"+yhxz+"']").click();
		});
		$("#ghInfo").data("multiPayYhxzInit","true");
	}
	
	//电话退费
	function ghTuiFeiCfm()
	{
		if($("#ghInfo").data("hth")==undefined)
		{
			alert("请先对需退费用户执行查询操作");
			$("#ghSearchBox").select().focus();
			return;
		}
		var yj = $("#ghInfo").data("byyecal");
		yj = parseFloat(yj,10);
		if(isNaN(yj)){
			yj = 0;
		}
		if(yj<0)
		{
		/*
			var exists_var = fetchSingleValue("revenue.tuifeit",6,"&hth=" + $("#ghInfo").data("hth"));
			exists_var = parseFloat(exists_var,10);
			if(isNaN(exists_var))
				exists_var = -1;
			if(exists_var<1)
			{
				alert("账号 " + $("#ghInfo").data("hth") + " 未被销户或销户时间不足，不可退返费用");
				return;
			}
			*/
			if(confirm("确定要对 " + $("#ghInfo").data("hth") + " 执行退费操作吗？当前可退费金额 " + yj*(-1) + " 元，点击确定将完成退费"))
			{
				$("#ghInfo").data("tuifei","T");
				$("#ghFFFs").val("cash").trigger("change");
				$("#ghDJ").attr("disabled",true).val(yj);
				$("#ghSs").attr("disabled",true).val(yj);
				$("#ghYz").val("0");
				
				//$("#ghsave").click();
			}
		}
		else
		{
			alert("当前用户无可退费用");
		}
		//alert(yj);
	}
	
	function ghRefreshStatus(Dh)
	{
		//取拆机日期
		var sinfo = fetchSingleValue("revenue.fetchstatusinfo",6,"&dh=" + encodeURIComponent(Dh));
		if(sinfo==undefined)
			sinfo = "";
		if(sinfo!="")
		{
			$("#ghuiDelDate").html(sinfo);
			$("#ghuiDelDate").closest("tr").css("display","block");
			//$(".jfghuiDelDate").html("，拆机日期：" + sinfo);
		}
		else
			$("#ghuiDelDate").closest("tr").css("display","none");
		//取状态
		var dinfo = fetchSingleValue("revenue.fetchzt",6,"&dh=" + encodeURIComponent(Dh));
		if(dinfo==undefined)
			dinfo = "";
		$("#ghuiStatus").html(dinfo);
	}
/**
 * 打印预览
 * @param 无参数
 * @return 无返回值
 */
function theviewprint(flag)
{
	var printfile ='';
	var params = '';
	var type =$("#printtype").data("printtype");
	if(type=='broadband'){
		printfile = "receipt_broadbandR2";
		params = "&lsz=" + $("#kdInfo").data("kdlsz");
	}else if(type=='phone'){
		printfile = 'receipt2';
		params = "&skrid=<%=(String)session.getAttribute("userid")%>";
	}
	
 	if(flag==0)
 	{
    	var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+printfile+".cpt"+params;
		window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
		if(type =='broadband'){
			clearKdInfo();
		}else if(type =='phone'){
			ghClearInfo();
		}
        /**	
         //var theurl = "/tsdboss/ReportServer?reportlet=/com/tsdreport/" + printfile + ".cpt";
    	//window.open(theurl);
    		
    	printThisReport1('< %=request.getParameter("imenuid")%>',
		"teljob","&JobID=" + key,
		'< %=(String)session.getAttribute("userid")%>',
		'< %=request.getParameter("groupid").replaceAll("~", ",")%>',
		'< %=(String)session.getAttribute("departname")% >',1);
        //isSelect(2, type);
        */
 	} else if(flag==1) 	{
 		printfile=printfile;
 		printRep(printfile,params,flag);
		if(type =='broadband'){
			clearKdInfo();
		}else if(type =='phone'){
			ghClearInfo();
		}
 		setTimeout($.unblockUI,1);
 	} else if(flag==2){
 		if(type =='broadband'){
			clearKdInfo();
		}else if(type =='phone'){
			ghClearInfo();
		}
		setTimeout($.unblockUI,1);
		return false;
 	}
    //$('#printclose').click();
}

/**
 * 未收费打印
 * @param flag：打印方式
 * @return 无返回值
 */
function unPaymentPrintDo(flag)
{
	var printfile ='';
	var params = '&tsdtemp=' + Math.random();
	//合同号
	var hth= $("#unpaymentHth").val();
	//
	var lsh= $("#unpaymentLsh").val();
	printfile = 'unPaymentReceipt';
	params += "&skrid=<%=(String)session.getAttribute("userid")%>";	
	params += "&area=" + encodeURIComponent(cjkEncode("<%=area%>"));	
	params += "&hth=" + encodeURIComponent(cjkEncode(hth));
	params += "&lsh=" + encodeURIComponent(cjkEncode(lsh));
 	if(flag==0)
 	{
    	var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+printfile+".cpt"+params;
		window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
	} else if(flag==1) 	{
		printWithoutPreview("unPaymentReceipt","lsh_"+lsh);
 		//printRep(printfile,params,flag);
 		//setTimeout($.unblockUI,1);
 	} else if(flag==2){
		//setTimeout($.unblockUI,1);		
 	}
 	ghClearInfo();
 	setTimeout($.unblockUI,1);
}
/**
 *点击未收费打印票据， 打开打印票据面板
 */
function ghOpenUnpaymentDiv(){
	setTimeout('autoBlockForm("unpaymentPrintDiv","150","ghUnpaymentNoPrintRe","#FFFFFF",false)',25);
}	

/**
 *收取发票，记录发票内容
 */
function regRise(key)
{
	if(key.checked==true)
	{
		document.getElementById('showtext1').style.display="";
		document.getElementById('showtext2').style.display="";
		document.getElementById('showtext3').style.display="";
		document.getElementById('showtext4').style.display="";
	}else
	{
		document.getElementById('showtext1').style.display="none";
		document.getElementById('showtext2').style.display="none";
		document.getElementById('showtext3').style.display="none";
		document.getElementById('showtext4').style.display="none";
	}
}


			/***********************
			* 设置代办证件类型
			* @param;
			* @return;
		    *************************/
			function getidtype(){
				$("#bz4").empty();
				var strbz6="<option value=\"\">--请选择--</option>"; 
				var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfig",6,"&configtype=idtype");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        		for(var i=0;i<res.length;i++){
        			strbz6+="<option value="+res[i][1]+">"+res[i][1]+"</option>";
        		}
				$("#bz4").append(strbz6);
				$("#bz4").val('身份证');
			}
			
	</script>

	</head>

	<body style="text-align: left">
		<div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />
			:
		</div>

		<div id="gh">
			<div id="ghBar" style="margin-left: 10px;">
				缴费项目:
				<select id="chooseForFJ" style="width: 100px;">

				</select>
				&nbsp;&nbsp;<select id="ghSearchWay" style="width: 100px;" onchange="ghClearInfo()">
					<option value="1">电话号码</option>
					<option value="2">合同号</option>
					<option value="3">用户名或地址</option>
				</select>:
				<input type="text" class="inputbox" id="ghSearchBox" style="margin-left:2px;" 
					name="ghSearchBox" onpaste="javascript:$('#ghSearchBox').trigger('keydown');" />
				<button class="tsdbutton" id="ghSearchByUserName" style="margin-bottom: 0px;">
					查找
				</button>
				<button class="tsdbutton" id="ghMultiHth" onclick="ghOpenMultiHthForm()" style="margin-bottom: 0px;padding:2px;">
					多合同号
				</button>
				<button class="tsdbutton" id="ghTuiFei" style="margin-bottom: 0px;padding-left:2px;padding-right:2px;">
					结账算费
				</button>
				<button class="tsdbutton" id="ghTuiFeiBtn" onclick="ghTuiFeiCfm()" style="margin-bottom: 0px;padding-left:11px;padding-right:11px;" >
					退费
				</button>
				<button class="tsdbutton" id="ghUserInfo" style="margin-bottom: 0px;padding-left:2px;padding-right:2px;" disabled>
					用户信息
				</button>
				
				<br />
				缴费月份:
				<select style="width: 100px;" id="ghPayMonth"></select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
			</div>

			<div id="ghFP">
				<table id="ghInfo" style="display:none"></table>
				<jsp:include page="rev_bill.jsp"></jsp:include>
				<div id="ghYHYE" tip1="实时余额：  元" tip2="当前月费用：  元" style="display : none">
					<span class="tip">当前月份费用： 元</span>
					<span class="jfed"></span>
					<span class="jfghuiDelDate"></span>
				</div>
			</div>
			<div id='ghbyxx' style='display:none;'>
				<table style="color: #f00; font-size: 18px;font-weight:bold;margin-left:10px;">
					<tr>
					
						<td width="70" style="display:none">当前月话费</td>
						<td width="100" style="display:none"><span id='ghbyxxByhf'></span></td>
					 
						<td width="70">当前余额</td>
						<td width="100"><span id='ghbyxxByye' ></span></td>
					</tr>
				</table>
			</div>
			<div id="multiHthDetail">
				<h6>多合同号缴费明细</h6>
				<table id="multiHthDetailTab" width="720" border="1" bordercolor="#eeeeee"
					cellspacing="0" cellpadding="1"
					style="background-color: #eeeeee; border-collapse: collapse;display:none"
					bgcolor="#eeeeee"></table>
			</div>
				
			<div id="commonHthYfDetail">
				<h6>缴费明细</h6>
				<table id="commonHthYfDetailTab" width="720" border="1" bordercolor="#eeeeee"
					cellspacing="0" cellpadding="1"
					style="background-color: #eeeeee; border-collapse: collapse;display:none"
					bgcolor="#eeeeee"></table>
			</div>
			<style type="text/css">
				#ghStatus table span,#ghStatus table input,#ghStatus table select{font-size:14px;height:22px;line-height:22px;}
				#ghStatus table input{height:20px}
				#ghStatus{background:#eee;}
			</style>
			<div id="ghStatus">
				<table width="660" >
					<tr>
						<td>
							<span id="ghYJLbl">本次应缴</span>:
						</td>
						<td>
							<input type="text" id="ghYJ" name="ghYJ" readonly="readonly"
								style="width: 110px;font-weight:bold;color:#000" />
						</td>
						<td>
							<span id="ghDJLbl">递交金额</span>:
						</td>
						<td>
							<input type="text" style="ime-mode: disabled; width: 110px;"
								id="ghDJ" name="ghDJ" onkeypress="numValid(this)"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return   false" />
						</td>
						<td>
							<span id="ghSsLbl">实收金额</span>:
						</td>
						<td>
							<input type="text" id="ghSs" name="ghSs"
								style="ime-mode: disabled; width: 110px;"
								onkeypress="numValid(this)"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return   false" />
						</td>
						<td></td>
					</tr>
					<tr>
						<td>
							<span id="ghYzLbl">应找额</span>:
						</td>
						<td>
							<input type="text" id="ghYz" name="ghYz" disabled="disabled"
								style="width: 110px" />
						</td>
						<td>
							<span>付费方式</span>：
						</td>
						<td>
							<select id="ghFFFs" style="width: 114px;"></select>
						</td>
						<!-- 
						<td>
							<span>备注</span>：
						</td>
						<td>
							<input type="text" id="ghBz" name="ghBz" style="width: 110px" />
						</td>
						 -->
						 
					</tr>
					<tr >
					<td colspan="3" style="display:none">
						 	<label style="width:160px;margin-left:-4px;" for="ghPayReport">
						 		<input type="checkbox" id="ghPayReport" name="ghPayReport" />合并缴费发票
							</label>
						 </td>
						<td colspan="3">
						 	<label style="width:160px;margin-left:-4px;">
						 		<input type="checkbox" id="isInvoicing" name="isInvoicing" onclick="regRise(this)"/>开发票
							</label>
						 </td>
					</tr>
					<tr style="display:none" id="showtext1">
						<td>
							发票抬头
						</td>
						<td>
							<input type="text"  style="width: 180px" id="regText1"></input>
						</td>
						<td>
							联系方式
						</td>
						<td>
							<input type="text"  style="width: 120px"  maxlength="11" id="regText3"></input>
		
						</td>
						
						<td>
							开票金额
						</td>
						<td>
						   <input type="text"  style="width: 67px" id="regText2"></input>
						</td>
						
						
					</tr>
					<tr style="display:none" id="showtext2">	
						<td>
							备注
						</td>
						<td colspan='5'>
						   <input type="text"  style="width: 540px" id="regText4"></input>
						</td>
					</tr>
				</table>
			</div>
			<div id="ghButtons" style="text-align: center;">
				<button style="display: none;" onclick="testCAlert()">
					Test
				</button>
				<button class="tsdbtn" id="ghUnpaymentPrint" onclick="ghOpenUnpaymentDiv();" 
				disabled="disabled" style="width: 120px;">
					未收费打印
				</button>
				<span style="visibility: hidden;">____</span>
				<button class="tsdbtn" id="ghsave" style="width: 120px;" disabled>
					保存
				</button>
				<span style="visibility: hidden;">____</span>
				<button class="tsdbtn" style="width: 120px;" onclick="ghClearInfo()">
					重置
				</button>
			</div>
		</div>
		<div id="kd" style="display: none;">

			<div id="kdBar" style="margin-left: 10px;">
				缴费项目:&nbsp;
				<select id="chooseForJF" style="width: 100px;">

				</select>
				&nbsp;&nbsp;
				<span id="kdsWay"> 查询方式:&nbsp; <select id="kdSearchWay"
					style="width: 100px;">
					<option value="0">
						账号
					</option>
					<option value="1">
						电话
					</option>
					<option value="2">
						用户名
					</option>
				</select> 精确查询 <input type="checkbox" id="kdJQ" name="kdJQ" /> </span>
				<input type="text" class="inputbox" id="kdSearchBox"
					name="kdSearchBox" />
				<button class="tsdbutton" id="kdSearchByUserName"
					style="width: 90px; margin-bottom: 0px;">
					查找
				</button>
				&nbsp;&nbsp;
				<button class="tsdbutton" id="kdTuiFei" style="margin-bottom: 0px;padding-left:2px;padding-right:2px;">
					结算退费
				</button>
				&nbsp;&nbsp;
				<button class="tsdbutton" id="kdUserInfo" disabled style="display: none;">
					用户信息
				</button>
				<br />
				

			</div>
			<div id="kdFP">
				<table id="kdInfo" width="720" border="1" bordercolor="#eeeeee"
					cellspacing="0" cellpadding="1"
					style="background-color: #eeeeee; border-collapse: collapse"
					bgcolor="#eeeeee">

					<tr>
						<td width="90">
							用户账号
						</td>
						<td width="168">
							<span id="kdInfoUserName"></span>
						</td>
						<td width="90">
							用户名
						</td>
						<td width="190">
							<span id="kdInfosRealName"></span>
						</td>
						<td width="100">
							用户类型
						</td>
						<td width="190">
							<span id="kdInfosDh1"></span>
						</td>
					</tr>
					<tr>
						<td>
							联系电话
						</td>
						<td>
							<span id="kdInfosDh"></span>
						</td>
						<td>
							用户地址
						</td>
						<td colspan="3">
							<span id="kdInfosAddress"></span>
						</td>
					</tr>
					<tr>
						<td>
							计费方式
						</td>
						<td>
							<span id="kdInfoFeeName"></span>
						</td>
						<td width="168">
							新月未出账费用
						</td>
						<td colspan='3'>
							<span id="kdInfoFee5"></span>
						</td>
					</tr>
					<tr>
					
						<td>
							状态
						</td>
						<td>
							<span id="kdInfoStatus"></span>
						</td>
						
						<td>
							开户日期
						</td>
						<td>
							<span id="kdInfoRegDate"></span>
						</td>
						
						<td>
							计费起始日期
						</td>
						<td>
							<span id="kdInfoacctstarttime"></span>
						</td>
					</tr>
					<tr>
						<td>
							计费截止日期
						</td>
						<td>
							<span id="kdInfoacctstoptime"></span>
						</td>	
						
						<td>
							停机时间
						</td>
						<td>
							<span id="kdInfoStopTime"></span>
						</td>					
						<td>
							<span id="kdInfoPauseStopTimeLbl"></span>
						</td>
						<td>
							<span id="kdInfoPauseStopTime"></span>
						</td>
						<td></td>
						<td></td>
					</tr>
					<tr class="tuifeijinger" style="display: none;">
						<td>
							退费金额
						</td>
						<td>
							<span id="kdInfoTuiFei"></span>
						</td>
						<td>

						</td>
						<td>

						</td>
						<td>

						</td>
						<td></td>
					</tr>
				</table>
			</div>
			
			<div id="inputtext" style="margin-top: 10px;margin-bottom: 10px;">
				<table border="0px" cellpadding="0px" cellspacing="2px">
					<tbody>
						<tr>															
							<td align="right">
								<!-- 代办人名称： -->
								<span id="bz1g">代办人名称</span>
							</td>
							<td>
								<input name="bz1" id="bz1" maxlength="50" 	onpropertychange="TextUtil.NotMax(this)"  type="text"/>
							</td>				
							<td align="right">

								<!-- 代办单位名称： -->
								<span id="bz10g">代办单位名称</span>
							</td>
							<td>
								<input name="bz10" id="bz10" maxlength="50" onpropertychange="TextUtil.NotMax(this)"  type="text"/>
							</td>
							<td align="right">

								<!-- 与户主关系： -->
								<span id="bz2g">与户主关系：</span>
							</td>
							<td align="left">
								<input name="bz2" id="bz2" maxlength="100" onpropertychange="TextUtil.NotMax(this)"type="text"/>								
							</td>
						</tr>	
						<tr>
							<td align="right">
								<!-- 代办联系电话： -->
								<span id="bz3g">代办联系电话</span>
							</td>
							<td>
								<input name="bz3" id="bz3" style="ime-mode: disabled;" onkeypress="var   k=event.keyCode;   return   k>=48&amp;&amp;k<=57" 
								maxlength="25" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return   false"  type="text"/>
							</td>				
							<td align="right">

								<!-- 代办证件类型： -->
								<span id="bz4g">代办证件类型</span>
							</td>
							<td>
								<select name="bz4" id="bz4" style="width: 180px;margin-left: 20px;">						
								</select>
							</td>
							<td align="right">

								<!-- 代办证件号码： -->
								<span id="bz5g">代办证件号码：</span>
							</td>
							<td align="left">
								<input name="bz5" id="bz5" style="ime-mode: disabled;" onkeypress="var   k=event.keyCode;   return   k>=48&amp;&amp;k<=57" 
								maxlength="25" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return   false"  type="text"/>
							</td>
						</tr>
						<tr>
							<td align="right">
								<!-- 缴费时间： -->
								<span id="AcctPayTimeg">缴费时间：</span>
							</td>
							<td align="left">
								<input name="AcctPayTime" id="AcctPayTime"  type="text"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								/>
							</td>
						</tr>						
					</tbody>
				</table>
			</div>
			
			<div id="kdStatus">
				<p>
					<span id="kdYELbl">实时余额</span>:
					<input type="text" id="kdYE" name="kdYE" disabled="disabled" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="kdDJLbl">递交金额</span>:
					<input type="text" style="ime-mode: disabled;" id="kdDJ"
						name="kdDJ" onkeypress="numValid(this)"
						onpaste="return !clipboardData.getData('text').match(/\D/)"
						ondragenter="return   false" />
				</p>
				<br />
				<p>
					<span id="kdSsLbl">实收金额</span>:
					<input type="text" id="kdSs" name="kdSs"
						style="ime-mode: disabled;" onkeypress="numValid(this)"
						onpaste="return !clipboardData.getData('text').match(/\D/)"
						ondragenter="return   false" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="kdYzLbl">应找额</span>&nbsp;&nbsp;&nbsp;:
					<input type="text" id="kdYz" name="kdYz" disabled="disabled" />
				</p>
			</div>
			<div id="kdButtons" style="text-align: center;">
				<button style="display: none;" onclick="testCAlert()">
					Test
				</button>
				<button class="tsdbtn" id="kdsave" style="width: 120px;" disabled>
					保存
				</button>
				<span style="visibility: hidden;">____</span>
				<button class="tsdbtn" style="width: 120px;" onclick="clearKdInfo()">
					重置
				</button>
			</div>

		</div>

		<!-- 宽带缴费查询面板 -->
		<div class="neirong" id="multiSearch"
			style="display: none; width: 720px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							宽带缴费用户信息查询
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#kdMultiSearchClose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; width: 718px; overflow-x: hidden;">
				<div id="grid"></div>
			</div>

			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="kdMultiSearchClose">
					关闭
				</button>
			</div>
		</div>
		
		
	<!-- 电话查询面板 -->	
	<div class="neirong" id="ghSearch" style="display: none;overflow-x:hidden">
		<div class="top">
			<div class="top_01" id="ghthisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						电话缴费用户信息查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#ghMultiSearchClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>

		</div>

		<div class="midd" style="background-color:#FFFFFF;text-align:left;">
			<div id="ghgrid"></div>
		</div>

		<div class="midd_butt" style="width:100%;">
			<button type="button" class="tsdbutton" id="ghMultiSearchClose">
				关闭
			</button>
		</div>
	</div>
		
		<!-- 缴费票据打印 -->
		<div class="neirong" id="choosePrint"
			style="display: none; width: 620px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							缴费打印方式
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: center; width: 618px;">
				<div style="padding-top: 20px; padding-bottom: 20px;">
					<h3>
						缴费成功，请选择打印方式 :
					</h3>
					<br />
					<button id="printDirect" class="tsdbutton" onclick="kdPrint(1)">
						直接打印
					</button>
					<button id="printInDirect" class="tsdbutton" onclick="kdPrint(0)">
						预览打印
					</button>
					<button id="ghNoPrint_kd" class="tsdbutton" onclick="noprint('broadband')">
						不打印
					</button>
				</div>
			</div>
			<div class="midd_butt">

			</div>
		</div>

		<!-- 退费票据打印 -->
		<div class="neirong" id="choosePrintForTuiFei"
			style="display: none; width: 620px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							退费打印方式
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: center; width: 618px;">
				<div style="padding-top: 20px; padding-bottom: 20px;">
					<h3>
						退费成功，请选择打印方式 :
					</h3>
					<br />
					<button id="printTDirect" class="tsdbutton" onclick="kdTPrint(1)">
						直接打印
					</button>
					<button id="printTInDirect" class="tsdbutton" onclick="kdTPrint(0)">
						预览打印
					</button>
				</div>
			</div>
			<div class="midd_butt">

			</div>
		</div>

		<!-- 电话缴费票据打印 -->
		<div class="neirong" id="choosePrintForDhJF"
			style="display: none; width: 620px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							缴费打印方式
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: center; width: 618px;">
				<div style="padding-top: 20px; padding-bottom: 20px;">
					<h3>
						缴费成功，请选择打印方式 :
					</h3>
					<br />
					<button id="ghprintDirectDh" class="tsdbutton" onclick="ghPrint(1)">
						直接打印
					</button>
					<button id="ghprintInDirectDh" class="tsdbutton"
						onclick="ghPrint(0)">
						预览打印
					</button>
					<button id="ghNoPrint" class="tsdbutton" onclick="noprint('phone')">
						不打印
					</button>
				</div>
			</div>
			<div class="midd_butt">

			</div>
		</div>
		
		<!-- 电话收据打印 -->
		<div class="neirong" id="choosePrintForReceipt"
			style="display: none; width: 620px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							缴费打印方式
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: center; width: 618px;">
				<div style="padding-top: 20px; padding-bottom: 20px;">
					<h3>
						请选择收据打印方式 :
					</h3>
					<br />
					<button id="ghprintDirectRe" class="tsdbutton" onclick="theviewprint(1)">
						直接打印
					</button>
					<button id="ghprintInDirectRe" class="tsdbutton"
						onclick="theviewprint(0)">
						预览打印
					</button>
					<button id="ghNoPrintRe" class="tsdbutton" onclick="theviewprint(2)">
						不打印
					</button>
				</div>
			</div>
			<div class="midd_butt">

			</div>
		</div>
		
		<!-- 电话未收费打印 -->
		<div class="neirong" id="unpaymentPrintDiv"
			style="display: none; width: 620px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							缴费打印方式
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: center; width: 618px;">
				<div style="padding-top: 20px; padding-bottom: 20px;">
					<h3>
						请选择收据打印方式 :
					</h3>
					<br />
					<button id="ghUnpaymentPrintDirectRe" class="tsdbutton" onclick="unPaymentPrintDo(1)">
						直接打印
					</button>
					<button id="ghUnpaymentPrintInDirectRe" class="tsdbutton"
						onclick="unPaymentPrintDo(0)">
						预览打印
					</button>
					<button id="ghUnpaymentNoPrintRe" class="tsdbutton" onclick="unPaymentPrintDo(2)">
						不打印
					</button>
				</div>
			</div>
			<div class="midd_butt">

			</div>
		</div>

		<!-- 电话缴费分配面板 -->
		<div class="neirong" id="ghHfDistributionForm"
			style="display: none; width: 560px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							固话缴费分配
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#ghHfDistributionClose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; width: 558px;">
				<table id="addBzTab" width="60%" border="0" bordercolor="#eeeeee"
					cellspacing="0" cellpadding="1" align="center">
					<tr>
						<td colspan="4">
							本次电话缴费余额合计
							<span id="ghDitTotal"></span>元,分配方案如下
						</td>
					</tr>
					<tr>
						<td>
							固话费
						</td>
						<td>
							<input type="text" id="ghDitForGH" onkeyup="ghDistribution(this)"
								style="ime-mode: disabled; width: 80px;"
								onkeypress="numValid(this)"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return   false" />
						</td>
						<td>
							长市话费
						</td>
						<td>
							<input type="text" id="ghDitForCSH" style="width: 80px;" disabled />
						</td>
					</tr>
				</table>
			</div>

			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="ghHfDistributionSave">
					保存
				</button>
				<button type="button" class="tsdbutton" id="ghHfDistributionClose">
					关闭
				</button>
			</div>
		</div>

		<!-- 用户宽带基本信息 -->
		<div class="neirong" id="kduserInfoPanel"
			style="display: none; width: 740px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							用户
							<span style="font-size: 16px;" id="kduisRealNameTitle"></span>的基本信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#kduserInfoPanelclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>

			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; overflow: hidden; width: 738px;">
				<table>
					<tr>
						<td>
							<table id="kduserInfoPanelTab" width="240" border="1"
								bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
								style="background-color: #eeeeee; border-collapse: collapse; float: left;"
								bgcolor="#eeeeee">

								<tr>
									<td width="70">
										账号
									</td>
									<td width="170">
										<span id="kduiUserName"></span>
									</td>
								</tr>
								<tr>
									<td>
										用户名
									</td>
									<td>
										<span id="kduisRealName"></span>
									</td>
								</tr>
								<tr>
									<td>
										联系电话
									</td>
									<td>
										<span id="kduisDh"></span>
									</td>
								</tr>
								<tr>
									<td>
										状态
									</td>
									<td>
										<span id="kduiiStatus"></span>
									</td>
								</tr>
								<tr>
									<td>
										开户日期
									</td>
									<td>
										<span id="kduisRegDate"></span>
									</td>
								</tr>
								<tr>
									<td>
										完工日期
									</td>
									<td>
										<span id="kduifeeendtime"></span>
									</td>
								</tr>
								<tr>
									<td>
										地址
									</td>
									<td>
										<span id="kduisAddress"></span>
									</td>
								</tr>
								<tr>
									<td>
										区域
									</td>
									<td>
										<span id="kduisDh2"></span>
									</td>
								</tr>
								<tr>
									<td>
										用户类型
									</td>
									<td>
										<span id="kduiUserType"></span>
									</td>
								</tr>
								<tr>
									<td>
										用户类别
									</td>
									<td>
										<span id="kduiPayType"></span>
									</td>
								</tr>
								<tr>
									<td>
										计费方式
									</td>
									<td>
										<span id="kduiFeeName"></span>
									</td>
								</tr>
								<tr>
									<td>
										一级部门
									</td>
									<td>
										<span id="kduisBm1"></span>
									</td>
								</tr>
								<tr>
									<td>
										二级部门
									</td>
									<td>
										<span id="kduisBm2"></span>
									</td>
								</tr>
								<tr>
									<td>
										三级部门
									</td>
									<td>
										<span id="kduisBm3"></span>
									</td>
								</tr>
								<tr>
								<tr>
									<td>
										四级部门
									</td>
									<td>
										<span id="kduisBm4"></span>
									</td>
								</tr>
							</table>
						</td>
						<td valign="top">
							<table id="kduserInfoPanelTabRight" width="498" border="1"
								bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
								style="border-collapse: collapse; float: right;">
								<tr>
									<td width="100" style="font-weight: bold;">
										新业务费
									</td>
									<td width="390" colspan="2">
										<span id="kduiNewFee"></span>元
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<table id="kduserInfoPanelTabNewBuss" width="490" border="0"
											bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
											style="background-color: #eeeeee; border-collapse: collapse"
											bgcolor="#eeeeee"></table>
									</td>
								</tr>
								<tr>
									<td width="498" colspan="3">
										<a id="kduiJf" class="bolder">缴费历史</a>
										<a id="kduiJob">业务变更情况</a>
										<a id="kduiTZ">调账信息</a>
										<a id="kduiKF">扣费信息</a>
										<a id="kduiXX">当月扣费详细信息</a>
										<a id="kduiGNB" style="visibility:hidden">套餐包</a>
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<div style="height: 250px;">
											<table id="kduserInfoPanelTabJOB" width="498" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="kduserInfoPanelTabJF" width="498" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="kduserInfoPanelTabTC" width="498" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="kduserInfoPanelTabTZ" width="498" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="kduserInfoPanelTabKF" width="498" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>
											<table id="kduserInfoPanelTabXX" width="498" border="1"
												bordercolor="#eeeeee" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #eeeeee; border-collapse: collapse"
												bgcolor="#eeeeee"></table>

										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>

			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="kduserInfoPanelclose">
					关闭
				</button>
			</div>
		</div>
		<!-- 用户电话基本信息 -->
		<div class="neirong" id="ghuserInfoPanel"
			style="display: none; width: 750px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							用户
							<span style="font-size: 16px;" id="ghuisRealNameTitle"></span> 的基本信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#ghuserInfoPanelclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>

			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; overflow: hidden; width: 748px;">
				<!--2012-11-5 yhy start 样式调整-->
				<table>
					<tr>						
						<td valign="top">
							<table id="ghuserInfoPanelTabRight" width="740px" border="1"
								bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
								style="border-collapse: collapse; float: left;">
								<tr>
									<td width="740px" colspan="3">
										<a id="ghuiJf" class="ghuserInfoTitle bolder">缴费历史</a>
										<a id="ghuiJob" class="ghuserInfoTitle">业务变更情况</a>										
										<a id="ghuiCTC" class="ghuserInfoTitle">包月套餐</a>
										<a id="ghuiLTC" class="ghuserInfoTitle">优惠套餐</a>
										<a id="ghuiGDF" class="ghuserInfoTitle">固定费用</a>
										<a id="ghuiKF" class="ghuserInfoTitle">扣费信息</a>
										<a id="ghuiGNB" class="ghuserInfoTitle" style="visibility:hidden">套餐包</a>
									</td>
								</tr>
								<tr>
									<td >
										<div style="height: 260px;">
											<table id="ghuserInfoPanelTabJOB" width="740px" border="1"
												bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #A9C8D9; border-collapse: collapse"
												bgcolor="#A9C8D9"></table>
											<table id="ghuserInfoPanelTabJF" width="740px" border="1"
												bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #A9C8D9; border-collapse: collapse"
												bgcolor="#A9C8D9"></table>
											<table id="ghuserInfoPanelTabTC" width="740px" border="1"
												bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #A9C8D9; border-collapse: collapse"
												bgcolor="#A9C8D9"></table>
											<table id="ghuserInfoPanelTabKF" width="740px" border="1"
												bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #A9C8D9; border-collapse: collapse"
												bgcolor="#A9C8D9"></table>
											<table id="ghuserInfoPanelTabGDF" width="740px" border="1"
												bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #A9C8D9; border-collapse: collapse"
												bgcolor="#A9C8D9"></table>
											<table id="ghuserInfoPanelTabCTC" width="740px" border="1"
												bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #A9C8D9; border-collapse: collapse"
												bgcolor="#A9C8D9"></table>
											<table id="ghuserInfoPanelTabLTC" width="740px" border="1"
												bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
												style="display: none; background-color: #A9C8D9; border-collapse: collapse"
												bgcolor="#A9C8D9"></table>

										</div>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr><td width='100%' height='1px' style='border-bottom:1px solid #A9C8D9;'></td></tr>
					<tr>
						<td>
							<table id="ghuserInfoPanelTab" width="740px" border="1"
								bordercolor="#A9C8D9" cellspacing="0" cellpadding="1"
								style="background-color: #A9C8D9; border-collapse: collapse; float: left;"
								bgcolor="#eeeeee">
							<tbody>
								<tr>
									<td width="70" class='spanC'>
										电话号码
									</td>
									<td width="76" class='inputC'>
										<span id="ghuiDh"></span>
									</td>
									<td width="70" class='spanC'>
										合同号
									</td>
									<td width="76" class='inputC'>
										<span id="ghuiHth"></span>
									</td>
									<td width="70" class='spanC'>
										用户名
									</td>
									<td width="76" class='inputC'> 
										<span id="ghuiYhmc"></span>
									</td>
									<td width="70" class='spanC'>
										电话功能
									</td>
									<td width="76" class='inputC'>
										<span id="ghuiDhgn"></span>
									</td>
									<td width="70" class='spanC'>
										用户类别
									</td>
									<td width="76" class='inputC'>
										<span id="ghuiYhlb"></span>
									</td>
								</tr>
								<tr>									
									<td class='spanC'>
										状态
									</td>
									<td class='inputC'>
										<span id="ghuiStatus"></span>
									</td>
									<td class='spanC'>
										区域
									</td>
									<td class='inputC'>
										<span id="ghuiYwArea"></span>
									</td>
									<td class='spanC'>
										地址
									</td>
									<td colspan="5" class='inputC'>
										<span id="ghuiYhdz"></span>
									</td>
								</tr>
								<tr>
									<td class='spanC'>
										一级部门
									</td>
									<td colspan="9" class='inputC'>
										<span id="ghuiBm1"></span>
									</td>
								</tr>
								<tr>
									<td class='spanC'>
										二级部门
									</td>
									<td colspan="9" class='inputC'>
										<span id="ghuiBm2"></span>
									</td>									
								</tr>
							</tbody>
							</table>
						</td>
					</tr>
				</table>
				<!--2012-11-5 yhy end -->
			</div>

			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="ghuserInfoPanelclose">
					关闭
				</button>
			</div>
		</div>

		<div class="neirong" id="addBzForm"
			style="display: none; width: 680px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							添加备注
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#addBzClose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>

			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; width: 678px;">
				<h2>
					添加退费备注信息
				</h2>
				<textarea id="addBzText" style="width: 676px; height: 100px;"
					onkeydown="if(this.value.length>100){alert('备注信息最大长度为100个字符');this.value=this.value.substring(0,100);event.returnValue=false;}"></textarea>
				<br />
			</div>

			<div class="midd_butt" style="width: 664px;">
				<button type="button" class="tsdbutton" id="addBzAddUnt">
					保存备注并退费
				</button>
				<button type="button" class="tsdbutton" id="addBzClose">
					关闭
				</button>
			</div>

		</div>

		<!-- 电话多合同号缴费面板 -->
		<div class="neirong" id="ghMultiHthJf" style="display:none; width: 920px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							电话多合同缴费
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onclick="javascript:$('#kdMultiSearchClose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd" style="background-color: #FFFFFF; text-align: left; width: 918px; overflow-x: hidden;">
				<table>
					<tr>
						<td>
							<div style="line-height:22px;margin:0px;padding:0px;"><b>合同号列表</b><span title="选中列表中要删除的合同号，按Delete键删除">(Delete键删除)</span></div>
							<select id="ghMultiHths" style="width:160px;height:320px;overflow-y:auto;" multiple="multiple">
								
							</select>
						</td>
						<td style="vertical-align:top;">
							<div style="line-height:22px;margin:0px;padding:0px;font-weight:bold;">条件过滤</div>
							<table>
								<tr>
									<td>一级部门</td><td colspan="3"><select id="ghmhdept1" class="ghHthDrpt" style="width:226px;"><option value="">请选择</option></select></td>
									<td>二级部门</td><td><select id="ghmhdept2" class="ghHthDrpt"><option value="">请选择</option></select></td>
									<td>三级部门</td><td><select id="ghmhdept3" class="ghHthDrpt"><option value="">请选择</option></select></td>
									<td>四级部门</td><td><select id="ghmhdept4" class="ghHthDrpt"><option value="">请选择</option></select></td>
								</tr>
								<tr>
									<td>用户类别</td><td><select id="ghmhyhlb" class="ghHthDrpt"><option value="">请选择</option></select></td>
									<td colspan="6"><label for="ghMultiHthFlag" style="width:200px;display:none"><input type="checkbox" checked="checked" id="ghMultiHthFlag" name="ghMultiHthFlag" />只产生一条账单</label></td>
								</tr>
							</table>
							<div style="line-height:22px;margin:0px;padding:0px;font-weight:bold;">手动输入</div>
							合同号:<input id="ghSingleAddInput" type="text" /><button class="tsdbutton" style="margin-bottom: 0px;line-height:22px" onclick="ghSingleAddToHths()">查询</button>
							<table>
								<tr>
									<td colspan="8"><div id="ghMultiHthDetTab_Container"><table id="ghMultiHthDetTab"></table></div></td>
								</tr>
							</table>
							<div id="multiPayYhxz_Container"></div>
						</td>
					</tr>
				</table>
			</div>

			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="ghMultiHthJfSure" onclick="ghMultiHthJfPay()">
					确定
				</button>
				<button type="button" class="tsdbutton" id="ghMultiHthJfclose">
					关闭
				</button>
			</div>
		</div>


		<!-- 菜单ID -->
		<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
		<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
		<!-- 语言 -->
		<input type="hidden" id="lanType" name="lanType"
			value='<%=languageType%>' />
		<input type="hidden" id="global_param1" name="global_param1" />
		<input type="hidden" id="global_param2" name="global_param2" />
		<input type="hidden" id="global_param3" name="global_param3" />
		<input type="hidden" id="global_param4" name="global_param4" />
		<input type="hidden" id="global_param5" name="global_param5" />

		<input type="hidden" id="forbid" name="forbid" />

		<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
		<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
		<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />

		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		
		<input type="hidden" id="ableForBigHth" name="ableForBigHth" />
		<input type="hidden" id="ableJfDetail" name="ableJfDetail" />
		<input type="hidden" id="saveRise" name="saveRise" />
		<input type="hidden" id="hidedh" name="hidedh"/>
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
		<!-- e家用户是否可以退费 -->
		<input type="hidden" id="ableTuiFeiEJ" value="false" />
		<input type="hidden" id="dhyhlbpub" value="false" />		
		<input type="hidden" id="printtype" value="false" />
		<!-- 未收费打印 -->
		<input type="hidden" id="unpaymentHth" />
		<input type="hidden" id="unpaymentLsh" />
		<iframe id="printReportDirect" style="width: 120px; height: 0px; visibility: visible" src="print.jsp"></iframe>

		<script language="javascript">
		//检测是否可以进行电话缴费
		//ghCheckCan();
	</script>
	</body>
</html>
