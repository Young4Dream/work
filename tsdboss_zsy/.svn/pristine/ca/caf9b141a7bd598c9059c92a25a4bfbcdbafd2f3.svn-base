<%----------------------------------------
	name: revenue.jsp
	author: chenze
	version: 1.0, 2010-11-3
	description: 
	modify: 
			2011-01-20  chenze  	增加电话宽带页面分享
			2012-02-09	cheliang 	国际化
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String userid = (String) session.getAttribute("userid");
	String languageType = (String) session.getAttribute("languageType");	
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
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
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
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
	<!-- 分项卡 -->
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
<!-- 导入css文件结束 -->

	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<script src="script/public/equery.js" type="text/javascript" language="javascript"></script>
	
	<!-- 权限设置 -->
	<script src="script/public/tsdpower.js" type="text/javascript"></script>

	<style type="text/css">
		body{text-align:left;}
	</style>

	<script type="text/javascript">
		//2012-9-21 yhy start 
		//权限控制
		function getUserRight(){
			//用户名
			var userid = $('#useridd').val();	
			//权限组
			var groupid = $('#zid').val();
			//菜单id
			var imenuid = $('#imenuid').val();
			//获取权限组的存储过程别名
			var powerParams = "subsidyPay.getPower";
			//权限组区分，10管理员，3班长，0营业员
			var htmlinfo = [
							{oper:'RightsGroup',	id:'RightGroup',	type:'4',value:'0'}
						   ];
			getUserPowerNEW(htmlinfo,userid,groupid,imenuid,powerParams);
		}
		
		function getRightParam(){
			var keyEnd = "";
			if($("#RightGroup").val()=="3")
			{
				keyEnd = "Monitor";
			}
			else if($("#RightGroup").val()=="10")
			{
				keyEnd = "Operator";
			}
			var params = '';
			
			if($("#RightGroup").val()=="3")
			{
				params += "&RightGroup= Area=";
				params +=" '";
				params += tsd.encodeURIComponent($("#area").val());
				params +="' ";
			}
			else{
				params += "&RightGroup= 1=1";
			}	
			
			return params;
		}
		//2012-9-21 yhy end
		
		
		var Dat = "";
		var Clerks = "";
		var Sys_Config = "";
		
		var tabStatus = 1;
		
		$(function(){
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			//权限控制
			getUserRight();
						
			$("#tabs").tabs();
			
			Dat = loadData("v_radjiaofei",$("#lanType").val(),2);
			//初始化营业员信息
			Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
			
			Sys_Config = fetchMultiKVValue("Duty.sysConfig",6,"",["tsection","tvalues"]);
			if(Sys_Config["Phone"]=="Y" || Sys_Config["Broadband"]=="Y")
			{
				$("#tabs ul").hide();
				if(Sys_Config["Broadband"]=="Y"){
					tabsChg(2);
				}
				else{
					tabsChg(1);
				}
			}
			initialGrid();
			
			
		});
		
		
		
		
		
		/**
		 * 选项卡切换事件
		 * @param  id  选项卡编号
		 * @return 
		 */
		function tabsChg(id)
		{
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
			//$("#editgrid").empty();
			$("#queryName").val("");
			$("#fusearchsql").val("");
			switch(id)
			{
				case 1:
					tabStatus=1;				
					Dat = loadData("v_radjiaofei",$("#lanType").val(),2);
					initialGrid(Dat);
					$("#editgrid").trigger("reloadGrid");
					break;
				case 2:
					tabStatus=2;				
					Dat = loadData("cz_JiaoFei",$("#lanType").val(),2);
					initialDhGrid(Dat);
					$("#editgrid").trigger("reloadGrid");
					break;
				default:
					tabStatus=1;				
					Dat = loadData("v_radjiaofei",$("#lanType").val(),2);
					initialGrid(Dat);
			}		
		}
		/**
		 * 初始化页面宽带Grid
		 * @param  
		 * @return 
		 */
		
		function initialGrid()
		{
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mysql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'payList.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'payList.queryC'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			var RightParam = getRightParam();			
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&cols=" + Dat.FieldName.join(",") +RightParam,
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				       	rowNum:30, //默认分页行数
				       	rowList:[30,50,100], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'AcctPayTime', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'<fmt:message key="payList.kdjfgridtitle"/>',//"宽带缴费流水", 
				       	height:document.documentElement.clientHeight-180, //高
				       	//width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
							var ids = $("#editgrid").getDataIDs();
							for(var i=0;i<ids.length;i++)
							{
								var uid = $("#editgrid").getRowData(ids[i]).Operator;
								var kid = Clerks[uid];
								if(kid!=undefined)
								{
									$("#editgrid").setRowData(ids[i],{"Operator":kid});
								}
							}
						},
						ondblClickRow:function(idx){
							
						}
				}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		
		/**
		 * 初始化电话营收流水表格
		 * @param
		 * @return 
		 */
		function initialDhGrid()
		{
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'payList.dhjiaofei',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'payList.dhjiaofeicnt'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			var RightParam = getRightParam();							
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&cols=" + Dat.FieldName.join(",") + RightParam,
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				       	rowNum:30, //默认分页行数
				       	rowList:[30,50,100], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/',
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Jfshj', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'<fmt:message key="payList.ghjfgridtitle"/>',//"宽带业务流水", 
				       	height:document.documentElement.clientHeight-200, //高
				       	width:document.documentElement.clientWidth-65,
				       	loadComplete:function(){
							var ids = $("#editgrid").getDataIDs();
							for(var i=0;i<ids.length;i++)
							{
								var uid = $("#editgrid").getRowData(ids[i]).Operator;
								var kid = Clerks[uid];
								if(kid!=undefined)
								{
									$("#editgrid").setRowData(ids[i],{"Operator":kid});
								}
							}
							
							getJiaofeiSum("payList.dhjiaofeiBySum",RightParam);
							
							
						},
						ondblClickRow:function(idx){
							
						}
				}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		function getJiaofeiSum(sql,param){
		
			var fuheparams = fuheQbuildParams();						
			if(fuheparams=='&fusearchsql='){
				fuheparams +='1=1';
			}
		
			var urlstr=tsd.buildParams({
					packgname:'service',//java包
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:'tsdCharge',//数据源名称
					tsdcf:'mssql',//指向配置文件名称
					tsdoper:'query',//操作类型 
					datatype:'xmlattr',//返回数据格式 
					tsdpk:sql
				});
	        	$.ajax({
	        		url:'mainServlet.html?'+urlstr + param + fuheparams,
	        		cache:false,
	        		async:true,
	        		timeout:10000,
	        		success:function(data){
	        			var info = "<h2>本阶段缴费信息</h2>";				        			
        				info += "缴费笔数：<b>" + $(data).find("row:first").attr("num") + "</b>，";
        				info += "缴费合计：<b>" + $(data).find("row:first").attr("heji") + "</b> 元";
        				
	        			$("#ghxzinfo").html(info);
	        		}
	        	});
		}
		/**
		 * 打开查询窗口
		 * @param 
		 * @return 
		 */
		function openwinQ()
		{
			var tablename = "radjiaofei";
			if(tabStatus=="2") tablename='cz_JiaoFei';
			else tablename='radjiaofei';
			
			document.getElementById("queryName").value="query";
			if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){ 
				window.showModalDialog("/tsd2009/queryServlet?tablename="+tablename+"&url=/search.jsp",window,"dialogWidth:700px; dialogHeight:500px; center:yes; scroll:no");
		    }
		    else{
				window.showModalDialog("/tsd2009/queryServlet?tablename="+tablename+"&url=/search.jsp",window,"dialogWidth:690px; dialogHeight:600px; center:yes; scroll:no");
			}
		}
		
		/**
		 * 打开排序窗口
		 * @param
		 * @return 
		 */
		function openwinO()
		{
			var tablename = "radjiaofei";
			if(tabStatus=="2") tablename='cz_JiaoFei';
			else tablename='radjiaofei';
			
			if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
				window.showModalDialog("/tsdboss/queryServlet?tablename="+tablename+"&url=/order.jsp",window,"dialogWidth:610px; dialogHeight:320px; center:yes; scroll:no");
		    }
		    else{
				window.showModalDialog("/tsdboss/queryServlet?tablename="+tablename+"&url=/order.jsp",window,"dialogWidth:620px; dialogHeight:350px; center:yes; scroll:no");
			}				
		}
		
				
		//复合查询操作
		function fuheQuery()
		{	
			var params = fuheQbuildParams();						
			if(params=='&fusearchsql='){
				params +='1=1';
			}	
			var RightParam = getRightParam();
					
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mysql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										   tsdpk:tabStatus==2?'payList.dhjiaofeiQueryByWhere':'payList.queryWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:tabStatus==2?'payList.dhjiaofeicntQueryByWherepage':'payList.queryCWhere'
										
										});
			var link = urlstr1 + params + RightParam;
			link = link + "&cols=" + Dat.FieldName.join(",");
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
		 	setTimeout($.unblockUI, 15);//关闭面板			
		}
		
		
		
		//组合排序
		function zhOrderExe(sqlstr)
		{			
			var params = fuheQbuildParams();			
			if(params=='&fusearchsql=')
			{
				params +='1=1';
			}
			//权限控制 
			var RightParam = getRightParam();
			params =params+'&orderby='+sqlstr + RightParam ;		    
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:tabStatus==2?'payList.dhjiaofeiord':'payList.queryOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:tabStatus==2?'payList.dhjiaofeicntord':'payList.queryCOrder'
											
											});
				var link = urlstr1 + params;
				link = link + "&cols=" + Dat.FieldName.join(",");
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	
		}
		
		function fuheExe()
		{
			var queryName= document.getElementById("queryName").value;
			if(queryName=="delete")
			{
				fuheDel();
			}
			else if(queryName=="modify")
			{
				fuheOpenModify();
			}
			else
			{
				fuheQuery();
			}
		}
		
		
		//拼接要显示的数据列
		function displayFields(tablename)
		{
			var thearr = new Array();
			 var urlstr=tsd.buildParams({ 
								packgname:'service',//java包
			 					clsname:'ExecuteSql',//类名
			 					method:'exeSqlData',//方法名
			 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			 					tsdcf:'mssql',//指向配置文件名称
			 					tsdoper:'query',//操作类型 
			 					datatype:'xmlattr',//返回数据格式 
			 					tsdpk:'roleManager.gettheeditfields'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 					});
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&tablename='+tablename,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){
							var thefieldname = $(this).attr("Field_Name") ;
							var thefieldalias = getCaption($(this).attr("Field_Alias"),'<%=languageType %>','');
							if(thefieldalias!=''){
								var disvalue = thefieldname + ' as ' + tsd.encodeURIComponent(thefieldalias);
								thearr.push(disvalue);
							}
					 });
				 }
			 });
			return thearr;
		}
		
		/**
		 * 导出文件按钮执行方法
		 * @param 
		 * @return 
		 */
		function DownFile()
		{
			thisDownLoad('tsdBilling','mssql',tabStatus==2?"cz_JiaoFei":"radjiaofei",$("#lanType").val(),5);
		}
		/**
		 * 确认导出
		 * @param
		 * @return 
		 */
		function DownSure()
		{
			getTheCheckedFields(tabStatus==2?"tsdCharge":"broadband",tabStatus==2?"mssql":"mysql",tabStatus==2?"cz_JiaoFei":"radjiaofei");
		}
		
		
		////合并打印预览		
		function ghPrintPrew()
		{
			var reportfilename = "jiaofei";
			
			var params = fuheQbuildParams();						
			if(params=='&fusearchsql='){
				params +='1=1';
			}	
			var RightParam = getRightParam();
	
			printThisReport1('<%=request.getParameter("imenuid")%>',
				reportfilename,params+RightParam,
				'<%=(String)session.getAttribute("userid")%>',
				'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
				'<%=(String)session.getAttribute("departname")%>',1);
		}
		
	</script>

  </head>
  
  <body>
	<form name="childform" id="childform" style="display: none">
		<input type="text" id="queryName" name="queryName" value="" />
		<input type="text" id="fusearchsql" name="fusearchsql" />
	</form>
	
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="order1" onclick="openDiaO(tabStatus==2?'cz_JiaoFei':'v_radjiaofei');">
			<!--组合排序--><fmt:message key="order.title" />
		</button>
		<button type="button" onclick="clearText('squeryforms');autoBlockForm('squeryform',60,'squeryformclose','#ffffff',false);">
			简单查询
		</button>				   
		<button type="button" onclick="openDiaQueryG('query',tabStatus==2?'cz_JiaoFei':'v_radjiaofei');">
			高级查询
		</button>
		<!-- 这里的按钮可以自由更换 但格式要对 -->
		<button type="button" id="openadd2"
			onclick="thisDownLoad('broadband','mysql','radjiaofei','<%=languageType %>')"
			style="display:none;">
			<fmt:message key="global.exportdata" />
		</button>
		<button type="button" onclick="ghPrintPrew();">
			预览打印
		</button>
	</div>	
    <div id="tabs">	
		<ul>
			<li class="broadbandtab"><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key="payList.kdysgridtitle" /></span></a></li>
			<li class="phonetab"><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key="payList.ghysgridtitle" /></span></a></li>
		</ul>
		<div id="gridd">
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>
	</div>
	<div id="ghxzinfo" style="font-size:14px;color:#000"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons" style="display: none">
		<button type="button" id="order1" onclick="openDiaO(tabStatus==2?'cz_JiaoFei':'v_radjiaofei');">
			<!--组合排序--><fmt:message key="order.title" />
		</button>					   
		<button type="button" onclick="openDiaQueryG('query',tabStatus==2?'cz_JiaoFei':'v_radjiaofei');">
			<!--查询--><fmt:message key="global.query" />
		</button>					   
	</div>
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<input type="hidden" id="useridd" value="<%=userid%>"/>	
	<!-- 可查看权限设置  -->
	<input type="hidden" id="RightGroup" name="RightGroup" />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' />
	
	
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
								收款人员
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
								缴费起始时间
							</td>
							<td >
								<input type="text" id="squerybegindate" style="width: 180px" class="textclass" />
							</td>
							<td class="dflabelclass" id="sdatetext">
								缴费结束时间
							</td>
							<td >
								<input type="text" id="squeryenddate" style="width: 180px" class="textclass" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="eQuery('Skry','dh','j.hth','jfshj')">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="squeryformclose" style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
  </body>
</html>
