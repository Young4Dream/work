<%----------------------------------------
	name: jobFlow.jsp
	author: 
	version: 1.0, 2010-11-3
	description: 
	modify: 
		2010-12-14：霍帅   打印方法改为通用方法"printThisReport1(...)"
---------------------------------------------%>


<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String userareaid = (String) session.getAttribute("userarea");
	String depart = (String) session.getAttribute("departname");

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
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script src="style/js/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js"
			type="text/javascript"></script>
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js"
			type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<script type="text/javascript" src="css/tree/dtree.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<!-- 页面国际化 -->
		<script type="text/javascript"
			src="script/broadband/usercat/Internationalization.js"></script>		
		<script type="text/javascript"
			src="script/broadband/business/broadbandservice.js"></script>	
		<!-- 时间控件 -->
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 导入js文件结束 -->
		<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
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
				//初始化营业员信息
				Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
				kdDat = loadData("v_jobflow_radjob",$("#lanType").val(),1,"打印&nbsp;|&nbsp;预览");
				//kdDat.setWidth({'Operation':'180'});
				kdDat.colModels[0].width=100;
				kdDat.setHidden(['JobID']);
				
				setUserRight();				
				
				loadKdTab();
				thisDetailField();			
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
											  tsdpk:'JobFlow.fuheQueryByWhere' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'JobFlow.fuheQueryByWherepage' + keyEnd
											});
											
				//alert(pkeys[tabStatus-1]+'.fuheQueryByWhere');
				var link = urlstr1 + params;
				
				
				
				//alert(link);
				
				link += "&skrid=";
				link += $("#skrid").val();
				
				link += "&area=";
				link += tsd.encodeURIComponent($("#area").val());
				
				link += "&cols=";
				link += kdDat.FieldName.join(",");
				//alert(link);	
			 	$("#b_main_grid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板			
			}
			
			////预览工单报表
			function kdPrintPrewJob(jobid)
			{
			
				var printfile = "broadband_jobadduser_reprint";
				
				var urll = "&JobID="+jobid;
		
				printThisReport1('<%=request.getParameter("imenuid")%>',
					printfile,urll,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
			}
			/////中文转码
			function cjkEncode(text) {   
        	    if (text == null) {   
        	        return "";   
        	    }   
        		var newText = "";   
        	    for (var i = 0; i < text.length; i++) {   
        	        var code = text.charCodeAt (i);    
        	        if (code >= 128 || code == 91 || code == 93) {//91 is "[", 93 is "]".   
        	            newText += "[" + code.toString(16) + "]";   
        	        } else {   
        	            newText += text.charAt(i);   
        	        }   
        	    }   
        	 return newText;   
        	}  
			/////预览收费票据
			function kdPrintPrewSF(jobid,feename)
			{
			
				if(feename=="")
				{
					alert("费用为空，不能打印");
				}
				else
				{
					var printfile = "broadband_sf_reprint";
					var fees = analizeFeeName(feename);
					var param = "";
					
					for(var i=1;i<fees.length;i+=2)
					{					
						param += "&fee";
						param += (i+1)/2;
						param += "=";
						param += cjkEncode(fees[i-1]);
						param += "&val";
						param += (i+1)/2;
						param += "=";
						param += fees[i];					
					}
					
					for(var j=fees.length/2+1;j<=12;j++)
					{
						param += "&fee";
						param += j;
						param += "=";
						param += "";
						param += "&val";
						param += j;
						param += "=";
						param += "";
					}
					
					var urll = "&JobID="+jobid+param;				
			
					printThisReport1('<%=request.getParameter("imenuid")%>',
					printfile,urll,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
				}
			}
			//解析杂费项
			function analizeFeeName(feename)
			{
				var feenames = feename.split(",");
				var feens = [];
				var temp = [];
				
				for(var i=0;i<feenames.length;i++)
				{
					temp = feenames[i].split("：");
					feens.push(temp[0]);
					feens.push(temp[1].replace("元",""));
				}
				
				return feens;
			}
			
			////////////////////////////////////////////////////////////////////////////
			////                          条件排序
			///////////////////////////////////////////////////////////////////////////
			function zhOrderExe(sqlstr){
				
				//判断权限
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
											  tsdpk:'JobFlow.queryByOrder' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'JobFlow.queryByOrderpage' + keyEnd
											});
				var link = urlstr1 + params;	
				
				link += "&skrid=";
				link += $("#skrid").val();
				
				link += "&area=";
				link += tsd.encodeURIComponent($("#area").val());
				
				link += "&cols=";
				link += kdDat.FieldName.join(",");
				
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
				
				var cols = "viewOperation,ID,UserName,JobType,JobRecTime,lsz,UserID,sDh,sRealName,Fee,FeeName";
				var cna = "打印|预览,ID,帐号,业务类型,受理时间,流水号,工号,电话,用户名称,金额,费用名称";
				if($("#lanType").val()=="en")
				{
					cna = cols;
				}
				var colnn = cna.split(",");
				var coln = cols.split(",");
				var colm = [];
				
				for(var i=0;i<coln.length;i++)
				{
					var temp = "{name:'"+coln[i]+"',index:'"+coln[i]+"',width:120}";
					
					colm.push(new Function("return "+temp)());
				}
				colm[0].width=100;
				colm[1].hidden=true;
				colm[4].width=100;
		
		
				var urlstr=tsd.buildParams({ packgname:'service',//java包
								clsname:'ExecuteSql',//类名
								method:'exeSqlData',//方法名
								ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								tsdcf:'mysql',//指向配置文件名称
								tsdoper:'query',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpk:'JobFlow.queryKDMain' + keyEnd,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								tsdpkpagesql:'JobFlow.querypageKDMain' + keyEnd//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							});
				urlstr += "&skrid=";
				urlstr += $("#skrid").val();
				
				urlstr += "&area=";
				urlstr += tsd.encodeURIComponent($("#area").val());
				
				urlstr += "&cols=";
				urlstr += kdDat.FieldName.join(",");
				
				jQuery("#b_main_grid").jqGrid({
					url:'mainServlet.html?' + urlstr, 
					datatype: 'xml', 
					colNames:kdDat.colNames,
					colModel:kdDat.colModels,
					       	rowNum:30, 
					       	rowList:[30,50,100], 
					       	//imgpath:'css/jqgrid/themes/basic/images/', 
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/',
					       	pager: jQuery('#b_main_pager'), 
					       	sortname:'JobRecTime', 
					       	viewrecords: true, 
					       	sortorder: 'desc', 
					       	caption:"宽带工单记录", 
					       	height:360,
					       	loadComplete:function(){
					        	if($("#b_main_grid tr.jqgrow[id='1']").html()=="")
									return false;
					        	
					        	addRowOperBtn('b_main_grid','<img src="style/images/public/printreport.png" title="打印业务受理单" />','lsPrint','JobID','click',1);					        	
					        	addRowOperBtn('b_main_grid','<img src="style/images/public/print-view.png" title="预览业务受理单" />','lsPrint','JobID','click',2);					        						/*
					        	addRowOperBtn('b_main_grid','<img src="style/images/public/printreport.png" title="打印收费单" />','printKDSF','JobID','click',3,'FeeName');					        	
					        	addRowOperBtn('b_main_grid','<img src="style/images/public/print-view.png" title="预览收费单" />','kdPrintPrewSF','JobID','click',4,'FeeName');
					        	addRowOperBtn('b_main_grid','<img src="style/images/public/printreport.png" title="套打" />','printKDJobTD','JobID','click',5,'FeeName');
					        	*/
					        	executeAddBtn('b_main_grid',2);		
					        	
					        	var ids = $("#b_main_grid").getDataIDs();
								for(var i=0;i<ids.length;i++)
								{
									var uid = $("#b_main_grid").getCell(ids[i],"UserID");
									var kid = Clerks[uid];
									if(kid!=undefined)
									{
										$("#b_main_grid").setRowData(ids[i],{"UserID":kid});
									}
								}	
					        	
					        },
					        ondblClickRow:function(rowid){
							
								//var obj = $("#b_main_grid").getRowData(rowid);
								//alert(obj.JobID);
								var jobid = $("#b_main_grid").getCell(rowid,"JobID");
								thisInfo(jobid);
							}
					       
					}).navGrid('#b_main_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
						); 
			}
			
		/**********
		* 收费打印
		* @param：flag为1时直接打印，为2时预览打印;
		* @return;
	    **********/
       	function lsPrint(flag)
       	{
	       var params = "&jobid="+flag;
	       		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/broadband/BBywsl_jobworkorder.cpt"+params;
	       		if(flag=="1")
	       		{
	       			printWithoutPreview("broadband/rad_busi_adduser","jobid_"+flag);
	       		}
	       		else
	       		{
	       			window.showModalDialog(urll,window,"dialogWidth:720px; dialogHeight:550px; center:yes; scroll:no");
	       		}
       	}
			
			///////////////////////////////////////////////////////////////////
			/////                      设置权限
			//////////////////////////////////////////////////////////////////
			function setUserRight()
			{//alert("&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
				var allRi = fetchMultiPValue("JobFlow.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
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
				
				
				$("#printt").val(printt);
				$("#RightGroup").val(rightgroup);
			}
			
			
			/////打印工单票据
			function printKDJob(jobid)
			{
				if($("#printt").val()=="false")
				{
					alert("你没有打印权限");
				}
				else
				{
					var printfile = "broadband_jobadduser_reprint";
					//增加重打次数
					refreshPrinttimes(2,jobid);
					
					printWithoutPreview(printfile,"JobID_"+jobid);
				}
			}
			
			/////套打
			function printKDJobTD(jobid,feename)
			{
				if($("#printt").val()=="false")
				{
					alert("你没有打印权限");
				}
				else if(feename=="")
				{
					alert("费用为空，不能打印");
				}
				else
				{
					var fees = analizeFeeName(feename);
					var param = "";
					
					for(var i=1;i<fees.length;i+=2)
					{					
						param += "&fee";
						param += (i+1)/2;
						param += "=";
						param += cjkEncode(fees[i-1]);
						param += "&val";
						param += (i+1)/2;
						param += "=";
						param += fees[i];					
					}
					
					for(var j=fees.length/2+1;j<=12;j++)
					{
						param += "&fee";
						param += j;
						param += "=";
						param += "";
						param += "&val";
						param += j;
						param += "=";
						param += "";
					}
					
					var printfile = "broadband_sf_reprint_td";
					
					document.getElementById('printReportDirect').contentWindow.RepPriForJob(printfile,"&JobID="+jobid+param);
				}
			}
			
			//////打印收费票据
			function printKDSF(jobid,feename)
			{
				if($("#printt").val()=="false")
				{
					alert("你没有打印权限");
				}
				else if(feename=="")
				{
					alert("费用为空，不能打印");
				}
				else
				{
					var fees = analizeFeeName(feename);
					var param = "";
					
					for(var i=1;i<fees.length;i+=2)
					{					
						param += "&fee";
						param += (i+1)/2;
						param += "=";
						param += cjkEncode(fees[i-1]);
						param += "&val";
						param += (i+1)/2;
						param += "=";
						param += fees[i];					
					}
					
					for(var j=fees.length/2+1;j<=12;j++)
					{
						param += "&fee";
						param += j;
						param += "=";
						param += "";
						param += "&val";
						param += j;
						param += "=";
						param += "";
					}
					
					//alert(param);
					
					var printfile = "broadband_sf_reprint";
					
					document.getElementById('printReportDirect').contentWindow.RepPriForJob(printfile,"&JobID="+jobid+param);
					//增加重打次数
					refreshPrinttimes(1,jobid);
				}
			}
			
			function refreshPrinttimes(type,id)
			{
				if(type==1)
					executeNoQuery("JobFlow.reprintsf",0,"&JobID="+id);
				else if(type==2)
					executeNoQuery("JobFlow.reprintjob",0,"&JobID="+id);
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
							var thejobtype = $(this).attr('jobtype');
							thejobtype = getTrueValue('tsdBilling','Ywsl_Code','ShowName','Ywlx',thejobtype,'TypeID','53');
							if(thejobtype=='undefined'){
								thejobtype='';
							}
							$("#thisJobTypevalue").html(thejobtype);
							$("#thismqbmvalue").html($(this).attr("mqbm"));
							
							$("#thisValuevalue").html($(this).attr('value'));
							
							var theifcancel = $(this).attr('ifcancel');
							
							if(theifcancel=='N'){
								theifcancel = '否';
							}else if(theifcancel=='Y'){
								theifcancel = '是';
							}
							
							$("#thisIfCancelvalue").html(theifcancel);
							$("#thisUserNamevalue").html($(this).attr('username'));
							
							$("#thisoldsRealNamevalue").html($(this).attr('oldsrealname'));
							$("#thissRealNamevalue").html($(this).attr('srealname'));
							$("#thisJobRecTimevalue").html($(this).attr('jobrectime'));
							
							var theuserid = $(this).attr('userid');
							theuserid = getTrueValue('tsdBilling','sys_user','username','userid',theuserid,'1','1');
							if(theuserid==undefined)
							{
								theuserid = "";
							}
							
							$("#thisUserIDvalue").html(theuserid);
							$("#thisAreavalue").html($(this).attr('area'));
							$("#thisDepartvalue").html($(this).attr('depart'));
							$("#thisValuevalue").html($(this).attr('value'));
							$("#thisvlanidvalue").html($(this).attr('vlanid'));
							
							var thepaytype = $(this).attr('paytype');
							thepaytype = getTrueValue('broadband','tbl_Config','sValue','sItem',thepaytype,'sSection','paytype');
							if(thepaytype=='undefined'){
								thepaytype='';
							}
							$("#thisPayTypevalue").html(thepaytype);
							
							var thefeetype = $(this).attr('ifeetype');
							thefeetype = getTrueValue('broadband','tbl_IspList','FeeName','FeeCode',thefeetype,'1','1');
							
							$("#thisiFeeTypevalue").html(thefeetype);
							
							$("#thissDhvalue").html($(this).attr('sdh'));
							$("#thissRegDatevalue").html($(this).attr('sregdate'));
			            	$("#thisfeedendtimevalue").html($(this).attr('feedendtime'));
							$("#thisiFeeTypeTimevalue").html($(this).attr('ifeetypetime'));
							$("#thisoldsAddressvalue").html($(this).attr('oldsaddress'));
							$("#thissAddressvalue").html($(this).attr('saddress'));
							
							var thestatus = $(this).attr('istatus');
							thestatus = getTrueValue('broadband','tbl_Config','sValue','sItem',thestatus,'sSection','iStatus');
							if(thestatus=='undefined'){
								thestatus='';
							}
			            	$("#thisiStatusvalue").html(thestatus);
			            	
							var theusertype = $(this).attr('sdh1');
							
							theusertype = getTrueValue('broadband','radusertype','UserType','TypeID',theusertype,'1','1');
							if(theusertype=='undefined'){
								theusertype='';
							}
							$("#thissDh1value").html(theusertype);
							$("#thissDh2value").html($(this).attr('sdh2'));
			            	$("#thisiSimultaneousvalue").html($(this).attr('isimultaneous'));
							$("#thisUserName1value").html($(this).attr('username1'));
							
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
							$("#thisFeevalue").html($(this).attr('fee'));
							
							$("#thisFeeNamevalue").html($(this).attr('feename'));
			            	$("#thissBmvalue").html($(this).attr('sbm'));
							$("#thissBm2value").html($(this).attr('sbm2'));
							$("#thissBm3value").html($(this).attr('sbm3'));
			            	$("#thissBm4value").html($(this).attr('sbm4'));
			            	
			            	var theurgent = $(this).attr('ifurgent');
			            	
			            	theurgent = getTrueValue('broadband','tbl_Config','sValue','sItem',theurgent,'sSection','ifurgent');
							
							$("#thisifurgentvalue").html(theurgent);
							
							$("#thismemovalue").val($(this).attr('memo'));
							
							var thejobstatus = $(this).attr('jobstatus');
							thejobstatus = getTrueValue('tsdBilling','tsd_Ini','TIDent','TValues',thejobstatus,'TSection','canacceptjobtype');
							
			            	$("#thisjobstatusvalue").html(thejobstatus);
							
							var themode = $(this).attr('paymode');
							if(themode!="" && themode!=undefined)
							{
								themode = getTrueValue('broadband','tbl_Config','sValue','sItem',themode,'sSection','paymode');
							}
							$("#thisPayModevalue").html(themode);
							
							$("#thisHthvalue").html($(this).attr('hth'));
							
							var thepay = $(this).attr('ispay');
							if(thepay=='N'){
								thepay = '否';
							}else if(thepay=='Y'){
								thepay = '是';
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
		<button type="button" onclick="openDiaO('v_jobflow_radjob')">
			<!--组合排序--><fmt:message key="order.title" />
		</button>
				   
	   <button type="button" onclick="openDiaQueryG('query','v_jobflow_radjob')" >
			<!--查询--><fmt:message key="global.query" />
		</button>
							
		<button type="button" onclick="" disabled="disabled" style="display:none;">
			<!--打印--><fmt:message key="tariff.printer" />
		</button>
	</div>	
	<table id="b_main_grid" class="scroll"></table>
	<div id="b_main_pager" class="scroll" style="text-align:left;"></div>
	
	<div class="neirong" id="detailInfo" style="display: none;width: 800px;">
		<div class="top">
			<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="titlediv">工单详细信息</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="javascritp:$('#detailinfoclose').click();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>		
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
	
	<input type="hidden" name="printt" id="printt" />
	
	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
	
	<input type="text" id="fuheflag" name="fuheflag" style="display: none"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
	</body>		
</html>
	