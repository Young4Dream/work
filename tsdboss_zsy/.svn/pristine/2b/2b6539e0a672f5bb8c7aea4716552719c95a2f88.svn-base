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
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<script src="script/public/equery.js" type="text/javascript" language="javascript"></script>
<!-- 导入css文件结束 -->
	<style type="text/css">
		.textclassss{border:#FFF 1px none;}
	</style>
	<style type="text/css">
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
	</style>
	<script type="text/javascript" language="javascript">
	$(function(){
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			$("#tabs").tabs();
			Dat = loadData("v_joblist_radjob",$("#lanType").val(),2);
			Dat.setHidden(["JobID"]);
			
			var userid_username=["userid","username"];
			users = fetchMultiKVValue("Duty.fetchUserId",6,"",userid_username);
			
			Sys_Config = fetchMultiKVValue("Duty.sysConfig",6,"",["tsection","tvalues"]);
			if(Sys_Config["Phone"]=="Y" || Sys_Config["Broadband"]=="Y")
			{
				$("#tabs ul").hide();
				if(Sys_Config["Broadband"]=="Y")
					tabsChg(2);
				else
					tabsChg(1);
			}
			
			initialGrid();
			
			thisDetailField();
			initialFieldAlias();
		});
		
		var Dat = "";
		var users = "";
		var Sys_Config = "";
		
		function initialFieldAlias()
		{
			$("#lUserName").text(Dat.getFieldAliasByFieldName("UserName"));
			
			$("#lJobType").text(Dat.getFieldAliasByFieldName("JobType"));
			
			$("#lJobRecTime").text(Dat.getFieldAliasByFieldName("JobRecTime"));
			
			$("#lLsz").text(Dat.getFieldAliasByFieldName("lsz"));
			
			$("#lUserID").text(Dat.getFieldAliasByFieldName("UserNamee"));
			
			$("#lSdh").text(Dat.getFieldAliasByFieldName("sDh"));
			
			$("#lsRealName").text(Dat.getFieldAliasByFieldName("sRealName"));
			
			$("#lFee").text(Dat.getFieldAliasByFieldName("Fee"));
			
			$("#lFeeName").text(Dat.getFieldAliasByFieldName("FeeName"));
			
			$("#lPayMode").text(Dat.getFieldAliasByFieldName("PayMode"));
			
			$("#lmemo").text(Dat.getFieldAliasByFieldName("memo"));
		}
		
		var tabStatus = 1;
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
					Dat = loadData("v_joblist_radjob",$("#lanType").val(),2);
					Dat.setHidden(["JobID"]);
					initialGrid(Dat);
					$("#editgrid").trigger("reloadGrid");
					break;
				case 2:
					tabStatus=2;				
					Dat = loadData("cz_TelJob",$("#lanType").val(),2);
					initialDhGrid(Dat);
					$("#editgrid").trigger("reloadGrid");
					break;
				default:
					tabStatus=1;				
					Dat = loadData("v_joblist_radjob",$("#lanType").val(),2);
					Dat.setHidden(["JobID"]);
					initialGrid(Dat);
			}		
		}
		
		function initialGrid()
		{
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'jobList.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'jobList.queryC'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&cols=" + Dat.FieldName.join(","),
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				       	rowNum:30, //默认分页行数
				       	rowList:[30,50,100], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'JobRecTime', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'宽带工单记录',//"宽带业务流水", 
				       	height:document.documentElement.clientHeight-180, //高
				       	//width:document.documentElement.clientWidth-80,
				       	loadComplete:function(){
							var ids = $("#editgrid").getDataIDs();
							//alert(ids);
							for(var i=0;i<ids.length;i++)
							{
								//alert($("#editgrid").getRowData(ids[i]).UserID);
								//alert(users[$("#editgrid").getRowData(ids[i]).UserID]);
								$("#editgrid").setRowData(ids[i],{"UserID":users[$("#editgrid").getRowData(ids[i]).UserID]});
							}
						},
						ondblClickRow:function(rowid){
							
							var obj = $("#editgrid").getRowData(rowid);
							//alert(obj.JobID);
							thisInfo(obj.JobID);
							return false;
							
							$("#UserName").val(obj.UserName);
							$("#JobType").val(obj.JobType);
							
							$("#JobRecTime").val(obj.JobRecTime);
							$("#Lsz").val(obj.lsz);
							
							$("#UserID").val(obj.UserNamee);
							$("#Sdh").val(obj.sDh);
							
							$("#sRealName").val(obj.sRealName);
							$("#Fee").val(obj.Fee);
							
							$("#FeeName").val(obj.FeeName);
							$("#PayMode").val(obj.PayMode);
							
							$("#memo").val(obj.memo);
							
							autoBlockForm('jobListDetailPanel',20,'jobListDetailPanelClose',"#FFFFFF",false);
						}
				}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		
		/**
		 * 初始化电话Grid
		 * @param
		 * @return 
		 */
		function initialDhGrid()
		{
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'payList.dhjob',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'payList.dhjobcnt'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
									
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&cols=" + Dat.FieldName.join(","),
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
		       	rowNum:30, //默认分页行数
		       	rowList:[30,50,100], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#pagered'), 
		       	sortname: 'Sgrq', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'desc',//默认排序方式 
		       	caption:'电话工单记录',//"宽带业务流水", 
		       	height:document.documentElement.clientHeight-200, //高
		       	width:document.documentElement.clientWidth-65,
		       	loadComplete:function(){
					var ids = $("#editgrid").getDataIDs();
					//alert(ids);
					for(var i=0;i<ids.length;i++)
					{
						//alert($("#editgrid").getRowData(ids[i]).UserID);
						//alert(users[$("#editgrid").getRowData(ids[i]).UserID]);
						$("#editgrid").setRowData(ids[i],{"Jlry":users[$("#editgrid").getRowData(ids[i]).Jlry]});
					}
					
					getJiaofeiSum('payList.dhjobBySum','');
					
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
	        			var info = "<h2>本阶段业务受理信息</h2>";				        			
        				info += "业务数：<b>" + $(data).find("row:first").attr("num") + "</b>，";
        				info += "一次性费合计：<b>" + $(data).find("row:first").attr("heji") + "</b> 元";
        				
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
			var tablename = "v_joblist_radjob";
			if(tabStatus=="2") tablename='cz_TelJob';
			else tablename='v_joblist_radjob';
			
			document.getElementById("queryName").value="query";
			if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){ 
				window.showModalDialog("/tsdboss/queryServlet?tablename="+tablename+"&url=/search.jsp",window,"dialogWidth:700px; dialogHeight:500px; center:yes; scroll:no");
		    }
		    else{
				window.showModalDialog("/tsdboss/queryServlet?tablename="+tablename+"&url=/search.jsp",window,"dialogWidth:690px; dialogHeight:600px; center:yes; scroll:no");
			}
		}
		
		/**
		 * 打开组合排序窗口
		 * @param
		 * @return 
		 */
		function openwinO()
		{
			var tablename = "v_joblist_radjob";
			if(tabStatus=="2") tablename='cz_TelJob';
			else tablename='v_joblist_radjob';
			
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
					
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:tabStatus==2?'payList.dhjobQueryByWhere':'jobList.queryWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:tabStatus==2?'payList.dhjobcntQueryByWherepage':'jobList.queryCWhere'
										
										});
			var link = urlstr1 + params;
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
			 params =params+'&orderby='+sqlstr;		    
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:tabStatus==2?'payList.dhjobord':'jobList.queryOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:tabStatus==2?'payList.dhjobcntord':'jobList.queryCOrder'
											
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
		
		function thisInfo(jobid,mqbm){
            	///设置命令参数
				 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
							 					clsname:'ExecuteSql',//类名
							 					method:'exeSqlData',//方法名
							 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 					tsdcf:'mysql',//指向配置文件名称
							 					tsdoper:'query',//操作类型 
							 					datatype:'xmlattr',//返回数据格式 
							 					tsdpk:'broadbandjob.querydetail' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 					});
				$.ajax({
					url:'mainServlet.html?'+urlstr+'&jobid='+jobid+'&tsdtemp='+Math.random(),
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						$(xml).find('row').each(function(){
							$("#thisJobIDvalue").html($(this).attr('JobID'));
							var thejobtype = $(this).attr('JobType');
							
							thejobtype = getTrueValue('tsdBilling','Ywsl_Code','ShowName','Ywlx',thejobtype,'TypeID','53');
							if(thejobtype=='undefined'){
								thejobtype='';
							}
							$("#thisJobTypevalue").html(thejobtype);
							$("#thismqbmvalue").html($(this).attr("mqbm"));
							
							$("#thisValuevalue").html($(this).attr('Value'));
							
							var theifcancel = $(this).attr('IfCancel');
							
							if(theifcancel=='N'){
								theifcancel = '<fmt:message key="jobList.isno"/>';
							}else if(theifcancel=='Y'){
								theifcancel = '<fmt:message key="jobList.isyes"/>';
							}
							
							$("#thisIfCancelvalue").html(theifcancel);
							$("#thisUserNamevalue").html($(this).attr('UserName'));
							
							$("#thisoldsRealNamevalue").html($(this).attr('oldsRealName'));
							$("#thissRealNamevalue").html($(this).attr('sRealName'));
							$("#thisJobRecTimevalue").html($(this).attr('JobRecTime'));
							
							var theuserid = $(this).attr('UserID');
							theuserid = getTrueValue('tsdBilling','sys_user','username','userid',theuserid,'1','1');
							if(theuserid==undefined)
							{
								theuserid = "";
							}
							
							$("#thisUserIDvalue").html(theuserid);
							$("#thisAreavalue").html($(this).attr('Area'));
							$("#thisDepartvalue").html($(this).attr('Depart'));
							$("#thisValuevalue").html($(this).attr('Value'));
							$("#thisvlanidvalue").html($(this).attr('vlanid'));
							
							var thepaytype = $(this).attr('PayType');
							thepaytype = getTrueValue('broadband','tbl_Config','sValue','sItem',thepaytype,'sSection','paytype');
							if(thepaytype=='undefined'){
								thepaytype='';
							}
							$("#thisPayTypevalue").html(thepaytype);
							
							var thefeetype = $(this).attr('iFeeType');
							thefeetype = getTrueValue('broadband','tbl_IspList','FeeName','FeeCode',thefeetype,'1','1');
							
							$("#thisiFeeTypevalue").html(thefeetype);
							
							$("#thissDhvalue").html($(this).attr('sDh'));
							$("#thissRegDatevalue").html($(this).attr('sRegDate'));
			            	$("#thisfeedendtimevalue").html($(this).attr('feedendtime'));
							$("#thisiFeeTypeTimevalue").html($(this).attr('iFeeTypeTime'));
							$("#thisoldsAddressvalue").html($(this).attr('oldsAddress'));
							$("#thissAddressvalue").html($(this).attr('sAddress'));
							
							var thestatus = $(this).attr('iStatus');
							thestatus = getTrueValue('broadband','tbl_Config','sValue','sItem',thestatus,'sSection','iStatus');
							if(thestatus=='undefined'){
								thestatus='';
							}
			            	$("#thisiStatusvalue").html(thestatus);
			            	
							var theusertype = $(this).attr('sDh1');
							
							theusertype = getTrueValue('broadband','radusertype','UserType','TypeID',theusertype,'1','1');
							if(theusertype=='undefined'){
								theusertype='';
							}
							$("#thissDh1value").html(theusertype);
							$("#thissDh2value").html($(this).attr('sDh2'));
			            	$("#thisiSimultaneousvalue").html($(this).attr('iSimultaneous'));
							$("#thisUserName1value").html($(this).attr('UserName1'));
							
							var theidtype = $(this).attr('idtype');
							if(theidtype=="")
							{
								theidtype = "~";
							}
							theidtype = getTrueValue('broadband','tbl_Config','sValue','sItem',theidtype,'sSection','idtype');
							if(theidtype=='undefined'){
								theidtype='';
							}
							$("#thisidtypevalue").html(theidtype);
			            	$("#thisidcardvalue").html($(this).attr('idcard'));
			            	
			            	var thedevtype = $(this).attr('devno');
			            	thedevtype = getTrueValue('broadband','tbl_Config','sValue','sItem',thedevtype,'sSection','devno');
							if(thedevtype=='undefined'){
								thedevtype='';
							}
							$("#thisdevnovalue").html(thedevtype);
							var theoldspeed = $(this).attr('oldspeed');
							if(theoldspeed!=''){
								theoldspeed = calBSpeed(theoldspeed);
							}
							$("#thisoldspeedvalue").html(theoldspeed);
							var thespeed = $(this).attr('speed');
							if(thespeed!=''){
								thespeed = calBSpeed(thespeed);
							}
			            	$("#thisspeedvalue").html(thespeed);
			            	
							$("#thismobilevalue").html($(this).attr('mobile'));
							$("#thislinkphonevalue").html($(this).attr('linkphone'));
							
			            	$("#thislinkmanvalue").html($(this).attr('linkman'));
							$("#thisFeevalue").html($(this).attr('Fee'));
							
							$("#thisFeeNamevalue").html($(this).attr('FeeName'));
			            	$("#thissBmvalue").html($(this).attr('sBm'));
							$("#thissBm2value").html($(this).attr('sBm2'));
							$("#thissBm3value").html($(this).attr('sBm3'));
			            	$("#thissBm4value").html($(this).attr('sBm4'));
			            	
			            	var theurgent = $(this).attr('ifurgent');
			            	
			            	theurgent = getTrueValue('broadband','tbl_Config','sValue','sItem',theurgent,'sSection','ifurgent');
							
							$("#thisifurgentvalue").html(theurgent);
							
							$("#thismemovalue").val($(this).attr('memo'));
							
							var thejobstatus = $(this).attr('jobstatus');
							thejobstatus = getTrueValue('tsdBilling','tsd_Ini','TIDent','TValues',thejobstatus,'TSection','canacceptjobtype');
							
			            	$("#thisjobstatusvalue").html(thejobstatus);
							
							var themode = $(this).attr('PayMode');
							if(themode!="" && themode!=undefined)
							{
								themode = getTrueValue('broadband','tbl_Config','sValue','sItem',themode,'sSection','paymode');
							}
							$("#thisPayModevalue").html(themode);
							
							$("#thisHthvalue").html($(this).attr('Hth'));
							
							var thepay = $(this).attr('isPay');
							if(thepay=='N'){
								thepay = '<fmt:message key="jobList.isno"/>';
							}else if(thepay=='Y'){
								thepay = '<fmt:message key="jobList.isyes"/>';
							}
			            	$("#thisisPayvalue").html(thepay);
						});
					}
				});
				
				autoBlockForm('detailInfo',20,'detailinfoclose',"#ffffff",false);//弹出查询面板		
		}
		
		//获取选择值的真实值
           function getTrueValue(ds,tablename,code,thelimit,limitvalue,theif,theend){
           	var realvalue = '';
           	 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:ds,//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mysql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'broadbandjob.querytruevalue' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 					});
			$.ajax({
						url:'mainServlet.html?'+urlstr+'&tablename='+tablename+'&code='+code+'&thelimit='+thelimit+'&theif='+theif+'&theend='+theend+'&limitvalue='+limitvalue+'&tsdtemp='+Math.random(),
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
								realvalue += $(this).attr(code);//是否已接收
							});
						}
					});
			return realvalue;
       }
       
       function thisDetailField(){
            	var column  = '';
				var thisdata = loadData('radjob','<%=languageType %>',1);
				column = thisdata.FieldName.join(',');			 					
				
				$("#thisJobID").html(thisdata.getFieldAliasByFieldName('JobID'));
				$("#thisJobType").html(thisdata.getFieldAliasByFieldName('JobType'));
				$("#thismqbm").html(thisdata.getFieldAliasByFieldName('mqbm'));
				
				$("#thisValue").html(thisdata.getFieldAliasByFieldName('Value'));
				
				$("#thisIfCancel").html(thisdata.getFieldAliasByFieldName('IfCancel'));
				$("#thisUserName").html(thisdata.getFieldAliasByFieldName('UserName'));
				$("#thisoldsRealName").html(thisdata.getFieldAliasByFieldName('oldsRealName'));
				$("#thissRealName").html(thisdata.getFieldAliasByFieldName('sRealName'));
				$("#thisJobRecTime").html(thisdata.getFieldAliasByFieldName('JobRecTime'));
				
				$("#thisUserID").html(thisdata.getFieldAliasByFieldName('UserID'));
				$("#thisArea").html(thisdata.getFieldAliasByFieldName('Area'));
				$("#thisDepart").html(thisdata.getFieldAliasByFieldName('Depart'));
				$("#thisValue").html(thisdata.getFieldAliasByFieldName('Value'));
				$("#thisvlanid").html(thisdata.getFieldAliasByFieldName('vlanid'));
				$("#thisPayType").html(thisdata.getFieldAliasByFieldName('PayType'));
				$("#thisiFeeType").html(thisdata.getFieldAliasByFieldName('iFeeType'));
				$("#thissDh").html(thisdata.getFieldAliasByFieldName('sDh'));
				$("#thissRegDate").html(thisdata.getFieldAliasByFieldName('sRegDate'));
				
            	$("#thisfeedendtime").html(thisdata.getFieldAliasByFieldName('feeendtime'));
				$("#thisiFeeTypeTime").html(thisdata.getFieldAliasByFieldName('iFeeTypeTime'));
				$("#thisoldsAddress").html(thisdata.getFieldAliasByFieldName('oldsAddress'));
				$("#thissAddress").html(thisdata.getFieldAliasByFieldName('sAddress'));
				
            	$("#thisiStatus").html(thisdata.getFieldAliasByFieldName('iStatus'));
            	
				$("#thissDh1").html(thisdata.getFieldAliasByFieldName('sDh1'));
				
				$("#thissDh2").html(thisdata.getFieldAliasByFieldName('sDh2'));
            	$("#thisiSimultaneous").html(thisdata.getFieldAliasByFieldName('iSimultaneous'));
				$("#thisUserName1").html(thisdata.getFieldAliasByFieldName('UserName1'));
				$("#thisidtype").html(thisdata.getFieldAliasByFieldName('idtype'));
            	$("#thisidcard").html(thisdata.getFieldAliasByFieldName('idcard'));
				$("#thisdevno").html(thisdata.getFieldAliasByFieldName('devno'));
				
				$("#thisoldspeed").html(thisdata.getFieldAliasByFieldName('oldspeed'));
            	$("#thisspeed").html(thisdata.getFieldAliasByFieldName('speed'));
            	
				$("#thismobile").html(thisdata.getFieldAliasByFieldName('mobile'));
				$("#thislinkphone").html(thisdata.getFieldAliasByFieldName('linkphone'));
				
            	$("#thislinkman").html(thisdata.getFieldAliasByFieldName('linkman'));
				$("#thisFee").html(thisdata.getFieldAliasByFieldName('Fee'));
				
				$("#thisFeeName").html(thisdata.getFieldAliasByFieldName('FeeName'));
            	$("#thissBm").html(thisdata.getFieldAliasByFieldName('sBm'));
				$("#thissBm2").html(thisdata.getFieldAliasByFieldName('sBm2'));
				$("#thissBm3").html(thisdata.getFieldAliasByFieldName('sBm3'));
            	$("#thissBm4").html(thisdata.getFieldAliasByFieldName('sBm4'));
				$("#thisifurgent").html(thisdata.getFieldAliasByFieldName('ifurgent'));
				
				$("#thismemo").html(thisdata.getFieldAliasByFieldName('memo'));
            	$("#thisjobstatus").html(thisdata.getFieldAliasByFieldName('jobstatus'));
            	
				$("#thisPayMode").html(thisdata.getFieldAliasByFieldName('PayMode'));
				$("#thisHth").html(thisdata.getFieldAliasByFieldName('Hth'));
            	$("#thisisPay").html(thisdata.getFieldAliasByFieldName('isPay'));
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
		////合并打印预览		
		function ghPrintPrew()
		{
			var reportfilename = "joblist";
			
			var params = fuheQbuildParams();						
			if(params=='&fusearchsql='){
				params +='1=1';
			}	
	
			printThisReport1('<%=request.getParameter("imenuid")%>',
				reportfilename,params,
				'<%=(String)session.getAttribute("userid")%>',
				'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
				'<%=(String)session.getAttribute("departname")%>',1);
		}
	</script>

  </head>
  
  <body>
    <form name="childform" id="childform" style="display:none">
		<input type="text" id="queryName" name="queryName" value=""/>
		<input type="text" id="fusearchsql" name="fusearchsql" />
	</form>
	
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="order1" onclick="openDiaO(tabStatus==2?'cz_TelJob':'v_joblist_radjob');">
			<!--组合排序--><fmt:message key="order.title" />
		</button>
		<button type="button" onclick="clearText('squeryforms');autoBlockForm('squeryform',60,'squeryformclose','#ffffff',false);">
			简单查询
		</button>				   
		<button type="button" onclick="openDiaQueryG('query',tabStatus==2?'cz_TelJob':'v_joblist_radjob');">
			高级查询
		</button>
		<button type="button" onclick="ghPrintPrew();">
			预览打印
		</button>	
		<!-- 这里的按钮可以自由更换 但格式要对 -->
		<button type="button" id="openadd2" onclick="thisDownLoad('broadband','mysql','radjiaofei','<%=languageType %>')" style="display:none;">
			<fmt:message key="global.exportdata" />
		</button>
	</div>
    <div id="tabs">	
		<ul>
			<li class="broadbandtab"><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key="jobList.ghysgridtitle" /></span></a></li>
			<li class="phonetab"><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key="jobList.ghbusigridtitle" /></span></a></li>
		</ul>
		<div id="gridd">	
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>
	</div>
	<div id="ghxzinfo" style="font-size:14px;color:#000"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons" style="display: none">
		<button type="button" id="order1" onclick="openDiaO(tabStatus==2?'cz_TelJob':'v_joblist_radjob');">
			<!--组合排序--><fmt:message key="order.title" />
		</button>					   
		<button type="button" onclick="openDiaQueryG('query',tabStatus==2?'cz_TelJob':'v_joblist_radjob');">
			<!--查询--><fmt:message key="global.query" />
		</button>	
	</div>
	
	<div class="neirong" id="detailInfo" style="display: none;width: 800px;">
		<div class="top">
			<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="image/neibut01.gif" /></div>
					<div class="top_03" id="titlediv"><fmt:message key="jobList.jobdetail" /></div>
					<div class="top_04"><img src="image/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="javascritp:$('#detailinfoclose').click();"><fmt:message key="writeOff.close"/></a></div>
			</div>
			<div class="top02right"><img src="image/toptiaoright.gif" /></div>		
		</div>

		<div class="midd" >
		   <form action="#" name="operform" id="operform" onsubmit="return false;">
			<table width="100%" id="tdiv" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;" cellspacing="0" cellpadding="0">
					<tr>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisJobID"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="thisJobIDvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisJobType"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisJobTypevalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thismqbm"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thismqbmvalue"></div>
						</td>
					</tr>
					<tr>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisIfCancel"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisIfCancelvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisjobstatus"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisjobstatusvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisUserName"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="thisUserNamevalue"></div>
						</td>
					</tr>
					
					<tr>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisoldsRealName"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisoldsRealNamevalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thissRealName"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissRealNamevalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisJobRecTime"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="thisJobRecTimevalue"></div>
						</td>
						
					</tr>
					<tr>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisUserID"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisUserIDvalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisArea"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisAreavalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisDepart"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="thisDepartvalue"></div>
						</td>
					</tr>
					
					<tr>
						
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisValue"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisValuevalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisvlanid"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisvlanidvalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisPayType"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="thisPayTypevalue"></div>
						</td>
					</tr>
					<tr>
						
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisiFeeType"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisiFeeTypevalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thissDh"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissDhvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thissRegDate"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissRegDatevalue"></div>
						</td>
					</tr>
					
					<tr>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisfeedendtime"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisfeedendtimevalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisiFeeTypeTime"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="thisiFeeTypeTimevalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisoldsAddress"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisoldsAddressvalue"></div>
						</td>
					</tr>
					<tr>
						<td class="labelclass">
							<label for="sarea">
								<span id="thissAddress"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissAddressvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisiStatus"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisiStatusvalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thissDh1"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissDh1value"></div>
						</td>
					</tr>
					
					<tr>
						
						
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thissDh2"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissDh2value"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisiSimultaneous"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisiSimultaneousvalue"></div>
						</td>
						<td class="labelclass">
							<label for="sarea">
								<span id="thisUserName1"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisUserName1value"></div>
						</td>
						
					</tr>
					
					
					<tr>
						
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisidtype"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisidtypevalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisidcard"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisidcardvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisdevno"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisdevnovalue"></div>
						</td>
						
					</tr>
					
					
					
					<tr>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisoldspeed"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisoldspeedvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisspeed"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisspeedvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thismobile"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thismobilevalue"></div>
						</td>
					</tr>
					
					
					<tr>
						
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thislinkphone"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thislinkphonevalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thislinkman"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thislinkmanvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisFee"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisFeevalue"></div>
						</td>
						
					</tr>
					
					
					<tr>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisFeeName"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisFeeNamevalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thissBm"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissBmvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thissBm2"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissBm2value"></div>
						</td>
					</tr>
					
					
					<tr>
						
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thissBm3"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissBm3value"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thissBm4"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thissBm4value"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisifurgent"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisifurgentvalue"></div>
						</td>
					</tr>
					
					<tr>
						
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thismemo"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<textarea readonly="readonly" rows="5" cols="30" id="thismemovalue"></textarea>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisisPay"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisisPayvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisPayMode"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisPayModevalue"></div>
						</td>
					</tr>
					
					
					<tr>
						
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisHth"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisHthvalue"></div>
						</td>
						
						<td class="labelclass">
							<label for="sarea">
								<span id="thisjobstatuss"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="thisjobstatusvalues"></div>
						</td>
						
						<td class="labelclass">
							
						</td>
						
						<td width="20%" class="tdstyle">
							
						</td>
					</tr>
					
				</table>
			</form>
		</div>	
		
		<div class="midd_butt">
				<button type="button" class="btn_2k3 tsdbutton" id="detailinfoclose" style="width: 100px;margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
		</div>
	</div>
	
	<div class="neirong" id="jobListDetailPanel" style="display:none;width:660px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="image/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="jobList.historyjoblist" />
					</div>
					<div class="top_04">
						<img src="image/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#jobListDetailPanelClose').click();"><fmt:message key="writeOff.close"/></a>
				</div>
			</div>
			<div class="top02right">
				<img src="image/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:660px;font-size:14px;">
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height: 33px; font-size: 12px;">
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lUserName"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="UserName" class="textclass" maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lJobType"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="JobType" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lJobRecTime"></label>
					</td>
					<td width="22%" align="left"
						style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="JobRecTime" class="textclass" maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lLsz"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="Lsz" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lUserID"></label>
					</td>
					<td width="22%" align="left"
						style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="UserID" class="textclass"
							maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lSdh"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="Sdh" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lsRealName"></label>
					</td>
					<td width="22%" align="left"
						style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="sRealName" class="textclass" maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lFee"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="Fee" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lFeeName"></label>
					</td>
					<td width="22%" align="left"
						style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="FeeName" class="textclass" maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lPayMode"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="PayMode" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lmemo"></label>
					</td>
					<td colspan="3" width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<textarea name="memo" id="memo" class="textclass" style="margin-left:5px;width:500px;height:100px;"></textarea>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="jobListDetailPanelClose">
				<fmt:message key="writeOff.close"/>
			</button>
		</div>
		
	</div>
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	
	<!-- 简单查询 -->
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
								受理人员
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
								受理起始时间
							</td>
							<td >
								<input type="text" id="squerybegindate" style="width: 180px" class="textclass" />
							</td>
							<td class="dflabelclass" id="sdatetext">
								受理结束时间
							</td>
							<td >
								<input type="text" id="squeryenddate" style="width: 180px" class="textclass" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="eQuery('Jlry','xdh','hth','sgrq')">
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
