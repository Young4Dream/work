<%----------------------------------------
	name: payFlow.jsp
	author: chenze
	version: 1.0, 2010-11-3
	description: 
	modify: 
		2010-12-14：霍帅   打印方法改为通用方法"printThisReport1(...)"
---------------------------------------------%>


<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title><!-- 收费结帐 --><fmt:message key="Revenue.chargeCheckout" /></title>
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
		<!-- 页面国际化 -->
		<script type="text/javascript" src="script/broadband/usercat/Internationalization.js"></script>
<!-- 导入js文件结束 -->
<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
		
<!-- 导入css文件结束 -->
		<style type="text/css">
		#main_grid a,#sub_grid a,#b_main_grid a{font-weight:bold;}
		</style>
		<!-- 双导航栏异常处理 -->
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		</style>
		<script language="javascript" type="text/javascript">
		var kdDat = "";
			var Clerks;
			$(function(){
				$("#navBar1").append(genNavv());
				gobackInNavbar("navBar1");	
				setUserRight();
				//初始化营业员信息
				Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
				//kdDat = loadData("vw_radjiaofei",$("#lanType").val(),1,"打印&nbsp;|&nbsp;预览&nbsp;");
				kdDat = loadData("vw_radjiaofei",$("#lanType").val(),1,"预览&nbsp;");
				kdDat.colModels[0].width=112;
				loadKdTab();				
			});
			
			
			///////批操作
			function fuheExe()
			{
				fuheQuery();
						
			}
			//////////////////////////
			/////复合查询
			function fuheQuery()
			{
				var keyEnd = "";
				if($("#RightGroup").val()=="3")
				{
					keyEnd = "Monitor";
				}
				else if($("#RightGroup").val()=="10")
				{
					keyEnd = "Operator";
				}
				
				var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());		
				if(params=='&fusearchsql='){
					params +='1=1';
				}
						
			 	//alert(params);
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'PayFlow.fuheQueryByWhere' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'PayFlow.fuheQueryByWherepage' + keyEnd
											});
											
				//alert(pkeys[tabStatus-1]+'.fuheQueryByWhere');
				var link = urlstr1 + params;
				
				link += "&cols=";				
				//isxz
				var temp = kdDat.FieldName.join(",");
				link += temp;
				
				//alert(link);
				
				link += "&skrid=";
				link += $("#skrid").val();
				
				link += "&area=";
				link += tsd.encodeURIComponent($("#area").val());
				//alert(link);	
			 	$("#b_main_grid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板			
			}
			
			////////////////////////////////////////////////////////////////////////////
			////                          条件排序
			///////////////////////////////////////////////////////////////////////////
			function zhOrderExe(sqlstr){
						
				var keyEnd = "";
				if($("#RightGroup").val()=="3")
				{
					keyEnd = "Monitor";
				}
				else if($("#RightGroup").val()=="10")
				{
					keyEnd = "Operator";
				}
				
				var tparam = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
				if(tparam == '&fusearchsql='){
					tparam +='1=1';
				}
				
				var params ='&orderby='+sqlstr;			    
			 			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'PayFlow.queryByOrder' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'PayFlow.queryByOrderpage' + keyEnd
											});
				var link = urlstr1 + params;	
				
				link += "&skrid=";
				link += $("#skrid").val();
				
				link += "&cols=";				
				//isxz
				var temp = kdDat.FieldName.join(",");
				temp = temp.replace(",isxz,",",'NO',");
				link += temp;
				
				link += "&area=";
				link += tsd.encodeURIComponent($("#area").val());
				
				link += tparam;
					
			 	$("#b_main_grid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	//setTimeout($.unblockUI, 15);//关闭面板
				 	
			}
			
			
			////////////////////////////////////////////////////////////////////////////////////
			//////////                         加载宽带表
			///////////////////////////////////////////////////////////////////////////////////
			function loadKdTab()
			{			
				var keyEnd = "";
				if($("#RightGroup").val()=="3")
				{
					keyEnd = "Monitor";
				}
				else if($("#RightGroup").val()=="10")
				{
					keyEnd = "Operator";
				}
				
				
				var urlstr=tsd.buildParams({ packgname:'service',//java包
								clsname:'ExecuteSql',//类名
								method:'exeSqlData',//方法名
								ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								tsdcf:'mysql',//指向配置文件名称
								tsdoper:'query',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpk:'PayFlow.queryKDMain' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								tsdpkpagesql:'PayFlow.querypageKDMain' + keyEnd//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							});
				urlstr += "&skrid=";
				urlstr += $("#skrid").val();
				urlstr += "&cols=";							
				//isxz
				var temp = kdDat.FieldName.join(",");					
				
				temp = temp.replace(",isxz,",",'NO',");
				urlstr += temp;
				
				urlstr += "&area=";
				urlstr += tsd.encodeURIComponent($("#area").val());
				
				jQuery("#b_main_grid").jqGrid({
					url:'mainServlet.html?' + urlstr, 
					datatype: 'xml', 
					colNames:kdDat.colNames,
					colModel:kdDat.colModels,
					       	rowNum:30, 
					       	rowList:[30,50,100], 
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
					       	pager: jQuery('#b_main_pager'), 
					       	sortname:'paydate', 
					       	viewrecords: true, 
					       	sortorder: 'desc', 
					       	caption:"<fmt:message key='Payflow.broadband' />",//'宽带缴费话单', 
					       	width:document.documentElement.clientWidth-50,
					       	height:document.documentElement.clientHeight-150,
					       	loadComplete:function(){
					        	if($("#b_main_grid tr.jqgrow[id='1']").html()=="")
									return false;
								//Removed by zhumengfeng 2016/06/08
					        	//addRowOperBtn('b_main_grid','<img src="style/images/public/printreport.png" title="<fmt:message key="global.print" />" />','printKD','jobid','click',1);
					        	addRowOperBtn('b_main_grid','<img src="style/images/public/print-view.png" title="预览" />','kdPrintPrew','jobid','click',1);
					        	
					        	executeAddBtn('b_main_grid',1);		
					        	/**
					        	var ids = $("#b_main_grid").getDataIDs();
								for(var i=0;i<ids.length;i++)
								{
									var uid = $("#b_main_grid").getCell(ids[i],"Operator");
									var kid = Clerks[uid];
									if(kid!=undefined)
									{
										$("#b_main_grid").setRowData(ids[i],{"Operator":kid});
									}
								}
								*/
					        }
					}).navGrid('#b_main_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
						); 
			}
			
			///////////////////////////////////////////////////////////////////
			/////                      设置权限
			//////////////////////////////////////////////////////////////////
			function setUserRight()
			{//alert("&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
				var allRi = fetchMultiPValue("payFlow.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
				if(typeof allRi == 'undefined' || allRi.length == 0)
				{
					//alert("取权限失败");
					return false;
				}
				if(allRi[0][0]=="all")
				{
					$("#printt").val("true");
					$("#RightGroup").val("10");
					return true;
				}
				var printt = false;
				
				var rightgroup = 0;
				
				for(var i = 0;i<allRi.length;i++){
					
					var rg = getCaption(allRi[i][0],'RightsGroup','');
					
					if(parseInt(rg,10)>rightgroup)
					{
						rightgroup = parseInt(rg,10);
					}
					
					if(getCaption(allRi[i][0],'print','')=="true")
						printt = true;	
					
				}
				//alert(fixedcharge+":"+broadbandcharge+":"+printt);
				
						
				$("#printt").val(printt);
				$("#RightGroup").val(rightgroup);
			}
			//预览报表
			function kdPrintPrew(jobid)
			{
				var params="";
				params+= "&jobid="+jobid;
				//判断是缴费打印还是退费打印
				//var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/charge/rad_busiCharge.cpt"+params;
				var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/broadband_revenue.cpt"+params;
				//调打印预览窗口
				window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
				//信息数据重置
			}
			//累加重打次数
			function refreshRePrintTimes(lsz)
			{
				executeNoQuery("PayFlow.reprint",0,"&lsz="+lsz);
			}
			function printKD(jobid)
			{
				if($("#printt").val()=="false")
				{
					alert("你没有打印权限");
				}
				else
				{
					var printfile = "";
					
					printfile = "charge/rad_busiCharge";
					
					printWithoutPreview(printfile,"jobid_"+jobid);
				}
			}
			
		</script>
	</head>
	
	<body>
	<form name="childform" id="childform">
	  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	</form>
  
	<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />
  	<input type="hidden" id="area" name="area" value='<%=request.getSession().getAttribute("chargearea") %>' />
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	<!-- 权限组 -->
	<input type="hidden" id="RightGroup" name="RightGroup" />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	
	<div id="navBar1">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		:
	</div>
		
	<div id="buttons">
		<button type="button" onclick="openDiaO('vw_radjiaofei')">
			<!--组合排序--><fmt:message key="order.title" />
		</button>
				   
	   <button type="button" onclick="openDiaQueryG('query','vw_radjiaofei');" >
			<!--查询--><fmt:message key="global.query" />
		</button>
							
		<button type="button" onclick="" disabled="disabled" style="display:none;">
			<!--打印--><fmt:message key="tariff.printer" />
		</button>
	</div>	
	<table id="b_main_grid" class="scroll"></table>
	<div id="b_main_pager" class="scroll" style="text-align:left;"></div>			
	
	<input type="hidden" name="phonecharge" id="phonecharge" />
	<input type="hidden" name="broadbandcharge" id="broadbandcharge" />
	<input type="hidden" name="printt" id="printt" />

	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	</body>
</html>
	
