<%----------------------------------------
	name: ghReprint.jsp
	author: chenze
	version: 1.0, 2010-11-3
	description: 
	modify: 
		2009-11-3 	霍帅 		移植到Oracle。
		2010-12-14：	霍帅   		打印方法改为通用方法"printThisReport1(...)"
		2011-9-22:	lvkui  		去掉明细
		2012-02-09	cheliang 	国际化
		
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
		<script type="text/javascript" src="script/public/transfer.js"></script>
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
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
<!-- 导入css文件结束 -->
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<script src="script/public/equery.js" type="text/javascript" language="javascript"></script>
		<style type="text/css">
		#main_grid a,#sub_grid a,#b_main_grid a{font-weight:bold;}
		</style>
		<!-- 双导航栏异常处理 -->
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		</style>
		<script language="javascript" type="text/javascript">
		var ghMDat = "";
		//var ghSDat = "";
		
		var btnStatus = 0;
			$(function(){
				$("#navBar1").append(genNavv());
				gobackInNavbar("navBar1");				
				
				setUserRight();
				
				ghMDat = loadData("jiaofei",$("#lanType").val(),1,"合并预览 | 分月预览");//合并打印 | 分月打印
				//ghMDat = loadData("jiaofei",$("#lanType").val(),1," 打印 | 预览 ");
				ghMDat.setWidth({'Operation':150,Kemu:66,Jfshj:160});
				
				//ghSDat = loadData("jiaofei_detail",$("#lanType").val(),1,"打印");
				//ghSDat.setWidth({'Operation':80,Kemu:66,Jfshj:120});
				ghMDat.colModels[9].hidden=true;
				ghMDat.colModels[11].hidden=true;
				
				loadMainTab("");
				//loadSubTab("");
				
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
											  ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'PayFlow.fuheQuerydhByWhere' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'PayFlow.fuheQuerydhByWherepage' + keyEnd
											});
											
				//alert(pkeys[tabStatus-1]+'.fuheQueryByWhere');
				var link = urlstr1 + params;
				
				link += "&skrid=";
				link += $("#skrid").val();
				
				link += "&cols=";
				link += ghMDat.FieldName.join(",");
				
				//alert(link);	
			 	$("#main_grid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	
			 	//loadSubTab("");
			 	setTimeout($.unblockUI, 15);//关闭面板			
			}
					
			////合并打印预览		
			function ghPrintPrew(lsz,payflag)
			{
				//var reportfilename = "charge";
				var reportfilename = "fixedphone_leave_combined";
				
				//reportfilename = getReportFileName(lsz);
				//alert(reportfilename.replace('prepay','combined'));
				//2012-07-24 chenliang 在删除的时候是分月的按合并的输出
				reportfilename = reportfilename.replace('prepay','combined');
				
				var urll = "&lsz="+lsz;
		
				printThisReport1('<%=request.getParameter("imenuid")%>',
					reportfilename,urll,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
			}
			
			////分月打印预览			 连打
			function ghPrintPrewL(lsz,payflag)
			{
				//var reportfilename = "charge";
				var reportfilename = "fixedphone_leave_reprint";
				
				//reportfilename = getReportFileName(lsz);
				//2012-07-24 chenliang 在删除的时候是合并的按分月的输出
				reportfilename = reportfilename.replace('combined','prepay');
				
				var urll = "&lsz="+lsz;
				
				if(payflag=="dtransfer" || payflag=='dcheque')
				{
					alert("<fmt:message key='ghReprint.ghreport' />");//大客户发票只能打印合计票
					return;
				}
		
				printThisReport1('<%=request.getParameter("imenuid")%>',
					reportfilename,urll,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
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
				
				var params ='&orderby='+sqlstr;			    
			 			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'PayFlow.queryByOrderdh' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'PayFlow.queryByOrderdhpage' + keyEnd
											});
				var link = urlstr1 + params;	
				
				link += "&skrid=";
				link += $("#skrid").val();
				
				link += "&cols=";
				link += ghMDat.FieldName.join(",");
				
			 	$("#main_grid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	//loadSubTab("");
			}
			
			////////////////////////////////////////////////////////////////////////////////////
			//////////                         加载主表
			///////////////////////////////////////////////////////////////////////////////////
			function loadMainTab(param)
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
								ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								tsdcf:'mssql',//指向配置文件名称
								tsdoper:'query',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpk:'PayFlow.queryMain' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								tsdpkpagesql:'PayFlow.querypageMain' + keyEnd//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							});
							
				urlstr += "&skrid=";
				urlstr += $("#skrid").val();
				
				urlstr += "&cols=";
				urlstr += ghMDat.FieldName.join(",");
				
				//alert(param);
				jQuery("#main_grid").jqGrid({
					url:'mainServlet.html?' + urlstr, 
					datatype: 'xml', 
					colNames:ghMDat.colNames, 
					colModel:ghMDat.colModels,
					       	rowNum:10, 
					       	rowList:[10,20,30], 
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
					       	pager: jQuery('#main_pager'), 
					       	sortname:'Jfshj', 
					       	viewrecords: true, 
					       	sortorder: 'desc', 
					       	caption:"<fmt:message key='Payflow.fixedMainInfo' />",//'固话缴费票据',
					       	width: document.documentElement.clientWidth-53, 
					       	height: document.documentElement.clientHeight-165, //高
					        loadComplete:function(){
					        	if ($("#main_grid tr.jqgrow[id='1']").html() == "") {
					                return false;
					            }
					            
					            //addRowOperBtn('main_grid','<img src="style/images/public/printreport.png" title="<fmt:message key="global.print" />" />','printGH','Lsz','click',1,'Pay_Flag');
					        	addRowOperBtn('main_grid','<img src="style/images/public/print-view.png" title="合并预览" />','ghPrintPrew','Lsz','click',1,'Pay_Flag');
					        	
					        	//addRowOperBtn('main_grid','<img src="style/images/public/printreport.png" title="<fmt:message key="global.print" />" />','printGHL','Lsz','click',3,'Pay_Flag');
					        	addRowOperBtn('main_grid','<img src="style/images/public/print-view.png" title="分月预览" />','ghPrintPrewL','Lsz','click',2,'Pay_Flag');
					        	
					        	executeAddBtn('main_grid',2);
					            
					            
					        	/*addRowOperBtn('main_grid','<img src="style/images/public/printreport.png" title="<fmt:message key="global.print" />" />','printGH','Lsz','click',1,'Pay_Flag');
					        	addRowOperBtn('main_grid','<img src="style/images/public/print-view.png" title="<fmt:message key='ghReprint.reportview' />" />','ghPrintPrew','Lsz','click',2,'Pay_Flag');
					        	//addRowOperBtn('main_grid','<img src="style/images/public/print-view.png" title="预览发票" />','printFP','Lsz','click',3,'Pay_Flag');
					        	addRowOperBtn('main_grid','<img src="style/images/public/printreport.png" title="<fmt:message key="global.print" />" />','printGHL','Lsz','click',1,'Pay_Flag');
					        	addRowOperBtn('main_grid','<img src="style/images/public/print-view.png" title="<fmt:message key='ghReprint.reportview' />" />','ghPrintPrewL','Lsz','click',2,'Pay_Flag');*/
					        	//executeAddBtnWithoutAddCell('main_grid',3);
					        	//executeAddBtn('main_grid',2);
					        },					      
					        onSelectRow:function(idx){
								/*	lsz=$("#main_grid").getCell(idx,"Lsz");	
									
									lsz=tsd.encodeURIComponent(lsz);
									
					        	var urls=tsd.buildParams({ packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'PayFlow.querySub'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
								$("#sub_grid").setGridParam({url:"mainServlet.html?"+urls+"&jflsz="+lsz+"&cols="+ghSDat.FieldName.join(",")}).trigger("reloadGrid");
					        */
					        }
					       
					}).navGrid('#main_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
						); 
			}
			////////////////////////////////////////////////////////////////////////////////////
			//////////                         加载明细表
			///////////////////////////////////////////////////////////////////////////////////
			function loadSubTab(param)
			{	
				jQuery("#sub_grid").jqGrid({
					url:'mainServlet.html?' + param + "&cols=" + ghSDat.FieldName.join(","), 
					datatype: 'xml', 
					colNames:ghSDat.colNames,
					colModel:ghSDat.colModels,
					       	rowNum:15, 
					       	rowList:[10,20,30], 
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
					       	pager: jQuery('#sub_pager'), 
					       	sortname:'Jfyf', 
					       	viewrecords: true, 
					       	sortorder: 'desc', 
					       	caption:"<fmt:message key='Payflow.fixedSubInfo' />",//'固话缴费明细', 
					       	height:220,
					       	loadComplete:function(){
					       		if ($("#sub_grid tr.jqgrow[id='1']").html() == "") {
					                return false;
					            }
					        	addRowOperBtn('sub_grid','<img src="style/images/public/printreport.png" title="<fmt:message key="global.print" />" />','printGH','JfLsz','click',1);
					        	//executeAddBtnWithoutAddCell('sub_grid',1);
					        	executeAddBtn('sub_grid',1);
					        }
					       
					}).navGrid('#sub_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
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
			{
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
			
			//合并打印直接打印
			function printGH(lsz,payflag)
			{
				//var reportfilename = "charge";
				var reportfilename = "commonreport/fixedphone_leave_combined";
				
				//var resRpt = getReportFileName(payflag);
				//2012-07-24 chenliang 在删除的时候是分月的按合并的输出
				//resRpt = resRpt.replace('prepay','combined');

				//reportfilename = "charge/" + resRpt;
				//reportfilename = resRpt;
				
				if($("#printt").val()=="false")
				{
					//jAlert("你没有打印权限","<fmt:message key='global.operationtips' />");
					alert("<fmt:message key='ghReprint.nopower' />");//你没有打印权限
					//return false;
				}
				else
				{
					printWithoutPreview(reportfilename,"lsz_"+$.trim(lsz));
				}
			}
			// 分月打印直接打印
			function printGHL(lsz,payflag)
			{
				//var reportfilename = "charge";
				//var reportfilename = "fixedphone_leave_reprint";
				var reportfilename = "commonreport/fixedphone_leave_prepay";
				
				//var resRpt = getReportFileName(payflag,'fy');
				//2012-07-24 chenliang 在删除的时候是分月的按合并的输出
				reportfilename = reportfilename.replace('combined','prepay');

				//reportfilename = "charge/" + resRpt;
				//reportfilename = resRpt;
				
				if($("#printt").val()=="false")
				{
					//jAlert("你没有打印权限","<fmt:message key='global.operationtips' />");
					alert("<fmt:message key='ghReprint.nopower' />");//你没有打印权限
					//return false;
				}
				else if(payflag=="dtransfer" || payflag=='dcheque')
				{
					alert("<fmt:message key='ghReprint.ghreport' />");//大客户发票只能打印合计票
					return;
				}
				else
				{
					printWithoutPreview(reportfilename,"lsz_"+$.trim(lsz));
				}
			}
			
			////预览发票
			function printFP(lsz,payflag)
			{
				var urll = "&lsz="+lsz;		
				
				printThisReport1('<%=request.getParameter("imenuid")%>',
					getReportFileName(lsz),params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
			}
			
			//获取缴费票据文件
			function getReportFileName(paytype,l)
			{
				
				var fname = fetchSingleValue("PayFlow.paytype",6,"&paytype=" + paytype);
				if(fname=="" || fname==undefined)
					fname = "fixedphone_leave"; 
				return fname + (l=="fy"?"_fy":"") + "_payflow";
				/**
				var fname = fetchSingleValue("ghReprint.queryprintrpt",6,"&lsz='" + lsz+"'");
				if(fname=="" || fname==undefined){
					//fname = "charge";
					fname = "fixedphone_leave";
				}
				fname = fname + '_reprint';//重打后后缀
				
				return fname;*/
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
	
	
		<div id="V1">
			<div id="buttons">
				<button type="button" onclick="openDiaO('jiaofei');">
					<!--组合排序--><fmt:message key="order.title" />
				</button>
				<button type="button" onclick="clearText('squeryforms');autoBlockForm('squeryform',60,'squeryformclose','#ffffff',false);">
					简单查询
				</button>
			   <button type="button" onclick="openDiaQueryG('query','jiaofei');" >
					高级查询
				</button>
				<button type="button" onclick="printFP()" style="display:none">
					<!-- 换发票 --><fmt:message key='global.ghReprint.changereport' />
				</button>
			</div>	
			<table id="main_grid" class="scroll"></table>
			<div id="main_pager" class="scroll" style="text-align:left;"></div>
			<div id="buttons" style="display:none">
				<button type="button" onclick="openDiaO('jiaofei_detail');" disabled>
					<!--组合排序--><fmt:message key="order.title" />
				</button>
			   <button type="button" onclick="openDiaQueryG('query','jiaofei_detail');" disabled >
					<!--查询--><fmt:message key="global.query" />
				</button>
			</div>	
			<table id="sub_grid" class="scroll"></table>
			<div id="sub_pager" class="scroll" style="text-align:left;"></div>
		</div>
		
	<input type="hidden" name="phonecharge" id="phonecharge" />
	<input type="hidden" name="broadbandcharge" id="broadbandcharge" />
	<input type="hidden" name="printt" id="printt" />

	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
	
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	
	<div class="neirong" id="squeryform" style="display: none; width: 680px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv"><fmt:message key="groupManager.query"/></div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#squeryformclose').click();"><fmt:message key="groupManager.close"/></a>
					</div>
				</div>
				<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>
			</div>
			<div class="midd">
				<form action="#" id="squeryforms" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td class="labelclass">
								收款人
							</td>
							<td class="tdstyle" colspan="3">
								<input type="text" id="squeryuserid" style="width: 180px" class="textclass" />
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								电话号码
							</td>
							<td class="tdstyle">
								<input type="text" id="squerydh" style="width: 180px"
									class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=48&&k<=57" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/>
							</td>
							<td class="labelclass">
								合同号
							</td>
							<td class="tdstyle">
								<input type="text" id="squeryhth" style="width: 180px" class="textclass" />
							</td>
						</tr>
						<tr>
							<td class="dflabelclass" id="sdatetext">
								收费起始时间
							</td>
							<td >
								<input type="text" id="squerybegindate" style="width: 180px" class="textclass" />
							</td>
							<td class="dflabelclass" id="sdatetext">
								收费结束时间
							</td>
							<td >
								<input type="text" id="squeryenddate" style="width: 180px" class="textclass" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="eQuery('Skry','dh','hth','jfshj')">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="squeryformclose" style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
	
	
	</body>
</html>
	
