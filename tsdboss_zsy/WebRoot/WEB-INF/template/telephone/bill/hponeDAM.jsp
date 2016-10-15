<%----------------------------------------
	name: hponeDAM.jsp
	author: youhongyu
	version: 1.0, 2010-10-13
	description: 明细话单档案管理
	modify: 
		2010-11-5 youhongyu 添加注释功能
		2010-11-16 youhongyu 页面查询按钮功能未实现，注释掉原来测试代码	
		2010-12-15 liwen     样式修改
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
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>If a single file management details</title>	
		
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
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
			
		

		<script type="text/javascript">
		
		/**
		* 查看当前用户的扩展权限，对spower字段进行解析
		* @param 
		* @return 
		*/
		function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'hponeDAM.getPower',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#useridd').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				
				/****************
				*   拼接权限参数 *
				**************/
				
				var addright = '';
				var delBright = '';
				var editBright = '';				
				var deleteright = '';
				var editright = '';
				var editfields = '';				
				var exportright = '';
				var printright ='';
				
				/**
				添加模板查询
				queryright queryMright saveQueryMright
				hasquery hasqueryM hassaveQueryM 
				**/
				var queryright = '';				
				var queryMright = '';
				var saveQueryMright ='';
				
				var flag = false;				
				var spower = '';				
				var str = 'true';
				
				$.ajax({
						url:'mainServlet.html?'+urlstr+'&userid='+userid+'&groupid='+groupid+'&menuid='+imenuid,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
									spower += $(this).attr("spower")+'@';
							});
						}
				});
				if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						
						for(var i = 0;i<spowerarr.length-1;i++){
							addright += getCaption(spowerarr[i],'add','')+'|';
							
							delBright += getCaption(spowerarr[i],'delB','')+'|';
							
							editBright += getCaption(spowerarr[i],'editB','')+'|';	
														
							deleteright += getCaption(spowerarr[i],'delete','')+'|';
							
							editright += getCaption(spowerarr[i],'edit','')+'|';	
							
							editfields += getCaption(spowerarr[i],'editfields','');
							
							exportright += getCaption(spowerarr[i],'export','')+'|';
							
							printright += getCaption(spowerarr[i],'print','')+'|';
							
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
							queryMright += getCaption(spowerarr[i],'queryM','')+'|';
							
							saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
							
						}
				}else if(spower=='all@'){
						$("#addright").val(str);
						$("#delBright").val(str);
						$("#editBright").val(str);
						
						$("#deleteright").val(str);
						$("#editright").val(str);						
						$("#exportright").val(str);
						$("#printright").val(str);
						
						$("#queryright").val(str);						
						$("#queryMright").val(str);
						$("#saveQueryMright").val(str);
						
						//var languageType = $("#languageType").val();
						//editfields = getFields('JhjID');
						flag = true;
				}				
				if(flag==false){
					var hasadd = addright.split('|');
					var hasdelB = delBright.split('|');
					var haseditB = editBright.split('|');
					var hasdelete = deleteright.split('|');
					var hasedit = editright.split('|');
					var hasexport = exportright.split('|');
					var hasprint = printright.split('|');
					
					var hasquery = queryright.split('|');
					var hasqueryM = queryMright.split('|');
					var hassaveQueryM = saveQueryMright.split('|');
					
					for(var i = 0;i<hasquery.length;i++){
						if(hasquery[i]=='true'){
							$("#queryright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasqueryM.length;i++){
						if(hasqueryM[i]=='true'){
							$("#queryMright").val(str);
							break;
						}
					}
					
					for(var i = 0;i<hassaveQueryM.length;i++){
						if(hassaveQueryM[i]=='true'){
							$("#saveQueryMright").val(str);
							break;
						}
					}			
					for(var i = 0;i<hasadd.length;i++){
						if(hasadd[i]=='true'){
							$("#addright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelB.length;i++){
						if(hasdelB[i]=='true'){
							$("#delBright").val(str);
							break;
						}
					}
					for(var i = 0;i<haseditB.length;i++){
						if(haseditB[i]=='true'){
							$("#editBright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelete.length;i++){
						if(hasdelete[i]=='true'){
							$("#deleteright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasedit.length;i++){
						if(hasedit[i]=='true'){
							$("#editright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasexport.length;i++){
						if(hasexport[i]=='true'){
							$("#exportright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasprint.length;i++){
						if(hasprint[i]=='true'){
							$("#printright").val(str);
							break;
						}
					}					
				}
				$("#editfields").val(editfields);
		}
		</script>
		<script type="text/javascript">
		
			
			/**
			* 初始化话单月份缺省起始日
			* @param 
			* @return 
			*/
		 	function getTValues(){
		 			var area='';
		 			for(var i=1;i<29;i++){
		 				area +="<option value='"+i+"'>"+i+"</option>";
		 			}
					$("#TValues ").html($("#TValues ").html()+area);					
			}
			
			/**
			* 从数据库中读取信息 ，来设置月份初始日期初始值
			* @param 
			* @return 
			*/
		 	function setTValues(){
					var urlstr=buildParamsSqlByS('tsdCDR','query','xmlattr','hponeDAM.setTValues','');	
					var params = "&TSection="+tsd.encodeURIComponent($("#TSection").val())+"&TIdent="+tsd.encodeURIComponent($("#TIdent").val());				
					$.ajax({
						url:'mainServlet.html?'+urlstr+params,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
								$(xml).find('row').each(function(){
	                   				var TValues=$(this).attr("TValues".toLowerCase());
									$("#TValues").val(TValues);
								});
						}
					});
			}
			
			/**
			* 面板确定按钮操作 ，重新设置月份初始日期初始值
			* @param 
			* @return 
			*/
			function updateTVal(){
					var urlstr=buildParamsSqlByS('tsdCDR','exe','xml','hponeDAM.updateTValues','');	
					var TValues =$("#TValues").val();
					var params ="&TValues="+TValues+ "&TSection="+tsd.encodeURIComponent($("#TSection").val())+"&TIdent="+tsd.encodeURIComponent($("#TIdent").val());				
					
					$.ajax({
							url:'mainServlet.html?'+urlstr+params,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){
									var operationtips = $("#operationtips").val();
									var successful = $("#successful").val();
									jAlert(successful,operationtips);
									
									//写入日志操作
									var str="(tsd_ini)<fmt:message key='global.edit'/><fmt:message key='hponeDAM.recordmonthstartdate'/>"+TValues;
									str = transferApos(str);
									writeLogInfo("","edit",tsd.encodeURIComponent(str));				
									setTValues();
									
								}	
							}
						});
			}
		</script>
		<script type="text/javascript">
			/**
			 * 页面初始化
			 * @param 
			 * @return 
			 */		
			jQuery(document).ready(function(){
		
					//设置当前位置
					$("#navBar").append(genNavv());		
					
					// 用户权限判定，初始化用户可操作权限 			
					getUserPower();
					//获取个操作权限
					
					var exportright = $("#exportright").val();
					var queryright = $("#queryright").val();							
					var saveQueryMright = $("#saveQueryMright").val();
					
					//获取个操作按钮可用性
					
					if(exportright=="true"){
						document.getElementById("export1").disabled=false;
						document.getElementById("export2").disabled=false;
					}					
					if(queryright=="true"){
						document.getElementById("gjquery1").disabled=false;
						document.getElementById("gjquery2").disabled=false;
					}					
					if(saveQueryMright=="true"){
						document.getElementById("savequery1").disabled=false;
						document.getElementById("savequery2").disabled=false;
					}
					
					loadGrid();//初始化加载jqgrid表
					getTValues();//初始化月份初始日期
					setTValues();//从数据库中读取信息 ，来设置月份初始日期初始值
					
			});	
			
			/**
			 * 初始化加载jqgrid表
			 * @param 
			 * @return 
			 */	
			function loadGrid(){
					//获取文档 URL中“?”后面的信息 **设置jqgrid标题
					var navv = document.location.search;
					//获取url中变量为imenuname的属性值
					var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));					
					var urlstr=buildParamsSqlByS('tsdCDR','query','xml','hponeDAM.query','hponeDAM.querypage');
					//设置jqgrid的头部参数
					var col=[[],[]];
					col=getRb_Field('mxmonth','Month',"",'97','ziduansF');//得到jqGrid要显示的字段					
					var column = $("#ziduansF").val();	
					
					jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+'&column='+column,
						datatype: 'xml', 
						colNames:col[0], 
						colModel:col[1],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'Month', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'asc',//默认排序方式 
						       	caption:infoo,				       	
						       	height:300, //高
						       //	width:document.documentElement.clientWidth-27,
						       	loadComplete:function(){
								}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
			}				
			
			/**
			 * 通用查询面板确定按钮操作 ，执行高级查询出提交过来的相应操作；
			 * @param 
			 * @return 
			 */ 
			function fuheExe()
			{
					fuheQuery();	//只有复合查询操作				
			
			}
			/**
			 * 高级查询操作，通过高级查询面板生成查询条件，查询和刷新jqgrid面板中的信息
			 * @param 
			 * @return 
			 */
			function fuheQuery()
			{
					//获取查询sql where字符串
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}					
				 	
				 	var column = $("#ziduansF").val();				 	
				 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)				
					var urlstr=buildParamsSqlByS('tsdCDR','query','xml','hponeDAM.fuheQueryByWhere','hponeDAM.fuheQueryByWherepage');
					var link = urlstr + params;										
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
				 				 	
			}
			/**
			 * 组合排序 
			 * @param sqlstr 进行组合排序的排序sql子语句
			 * @return 
			 */
			function zhOrderExe(sqlstr){
					//获取查询sql where字符串
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
					//获取查询 order by 字符串
					params =params+'&orderby='+sqlstr;	
					//获取查询 字段 字符串
					var column = $("#ziduansF").val();					
					/////设置命令参数 用于初始化jqgrid					
					var urlstr = buildParamsSqlByS('tsdCDR','query','xml','hponeDAM.queryByOrder','hponeDAM.queryByOrderpage');					
					var link = urlstr + params;						
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
			}  
			/**
			 * 高级查询操作，通过高级查询面板生成查询条件，查询和刷新jqgrid面板中的信息
			 * @param 
			 * @return 
			 */
			function fuheQbuildParams(){
				 	//每次拼接参数必须初始化此参数
					tsd.QualifiedVal=true;
				 	var params='';
				 	
				 	//如果有可能值是汉字 请使用encodeURI()函数转码
				 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());	
				 	params+='&fusearchsql='+fusearchsql;
				 	
				 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
				 	//每次拼接参数必须添加此判断
					if(tsd.Qualified()==false){return false;}
					return params;
			}								
		</script>		
		
		<script type="text/javascript">
			/**
			 * 重新加载jQgrid数据
			 * @param  
			 * @return 
			 */
			function querylist(){
					//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
					$("#fusearchsql").val("");				
					var urlstr=buildParamsSqlByS('tsdCDR','query','xml','hponeDAM.query','hponeDAM.querypage');
					var column = $("#ziduansF").val();
					$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+column}).trigger("reloadGrid");
			}
			 /**
			 * 页面提交查询
			 * @param  
			 * @return 
			 */	
			function submitQuery(){
				//该功能还未做
				/**
					var params=SubmbuildParams();
					if(params==false){return false;}
					/////设置命令参数
					var urlstr = buildParamsSqlByS('tsdCDR','exe','xml','phoneAbnormalQ.submitQuery','');	
					 
					var	Res ='';														
					urlstr+="&params="+encodeURIComponent(params);
					$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								var user = $("#useridd").val();	
								$("#mxTable").val("Hdmx_"+user);
								//alert("Hdmx_"+user);
								querylist();
								
							}
					});
					
				*/
			}
			
			
			/**
			 * 查询操作，查询参数拼接
			 * @param 
			 * @return 
			 */
			 function SubmbuildParams(){
				 	//每次拼接参数必须初始化此参数
					tsd.QualifiedVal=true;				
				 	var params='';
					/*
					Query_LongMxhd 'Func=3;User=005;GDHead=HDMX;time1=2009-10-01 00:00:00;time2=2009-11-01 23:59:59;'		
						qtypeF	time1 time2 GDHead
					*/
					var qtypeF = $("#qtypeF").val();
					params =qtypeF;
					
					//通过关键字key判断进行的查询 是查询 查询汇总
					params +=" 'Func=3";					
					var user = $("#useridd").val();					
				 	var time1 = $("#time1").val();
				 	var time2 = $("#time2").val();
				 	if(time1==''){				 		
				 		alert("<fmt:message key='hponeDAM.enterseekstarttime' />");
				 		$("#time1").focus();
				 		return false;
				 	}
				 	
				 	if(time2==''){				 		
				 		alert("<fmt:message key='hponeDAM.enterseekendtime' />");
				 		$("#time2").focus();
				 		return false;
				 	}
					//检测时间
	        		var timecheck=fetchSingleValue("phoneListQ.getstartendDay",6,"&starttime="+time1+"&endtime="+time2);
	        		timecheck = parseInt(timecheck);
	        		if(isNaN(timecheck) || timecheck<=0)
	        		{
	        			alert("<fmt:message key='hponeDAM.endmonthmorestart' />");
	        			$("#time2").focus();
	        			return false;
	        		}        		
        		
				 	var GDHead = $("#GDHead").val();				 
				 	params +=";User="+user;				 	
				 	params +=";GDHead="+GDHead;
				 	params +=";time1="+time1;
				 	params +=";time2="+time2;
				 	params +="' ";
				 										
					//每次拼接参数必须添加此判断
					if(tsd.Qualified()==false){return false;}
					return params;
			 }
			 
			/**
			 *导出数据面板的导出按钮操作，
			 * @param 
			 * @return 
			 */
			function exportDate(){				
					var mxTable = $("#mxTable").val();
					getTheCheckedFieldstwo('tsdCDR','mssql','Hdmx',mxTable);								
			}
		</script>
  </head>


<style type="text/css">
		.style1 {
			background-color: #A9C3E8;
			padding: 4px;
		}
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		#listQtb {
			margin-top: 10px;			
		}
		#listQtb tr td input{
			width: 140px;
			height: 25px;
			margin-bottom: 3px;
		}				
</style>   
<body >
		<div id="navBar1">
			<table width="100%" height="26px">
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
		
		<div class="title">				
				<img src="style/icon/65.gif" />
				<fmt:message key="BillingBG.query" />					
		</div>
		
		<div>
			<fieldset style="margin-left:20px;margin-right:20px;">
			<table id="listQtb" cellspacing="2px;" cellpadding="0" 
			style="width: 650px;border: 0px;">
						<tr>
							<td width="20%" align="right">
								<label id="TValuesg"><fmt:message key="hponeDAM.recordmonthlackstart" /></label>
							</td>
							<td width="30%" align="left" >
								<select name="TValues" id="TValues" style="width:143px;" >																
								</select>
							</td>
							<td  align="left">
								<!--确定-->
								<button type="button" class="tsdbutton" onclick="updateTVal();">					
									<fmt:message key='hponeDAM.sure' />
								</button>	
							</td>				
														
						</tr>
					</table>
					<table id="listQtb" cellspacing="2px;" cellpadding="0" 
						style="width: 650px;border: 0px;float:left;">
						<tr>
							<td width="12%" align="right" >
								<label id="timeMMg"><fmt:message key='hponeDAM.recordmonth' /></label>
							</td>
							<td width="22%" align="left" >
								<input type="text" name="timeMM" id="timeMM" 
								onfocus="WdatePicker({startDate:'%y-%M',dateFmt:'yyyy-MM',alwaysUseStartDate:true})" ></input>								
							</td>
							
							<td width="12%" align="right" >
								<label id="time1g"><fmt:message key='hponeDAM.startdate' /></label>
							</td>
							<td width="22%" align="left" >
								<input type="text" name="time1" id="time1" 
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" ></input>								
							</td>

							<td width="12%" align="right">
								<label id="time2g"><fmt:message key='hponeDAM.enddate' /></label>
							</td>
							<td width="20%" align="left" >
								<input type="text" name=time2 id="time2" 
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" ></input>								
							</td>						
												
						</tr>		
					</table>
					<!--查询-->
					<button type="button" class="tsdbutton" onclick="submitQuery();" style="float:left;pamargin-bottom: 0px;margin-top: 11px;">					
						<fmt:message key="global.query" />
					</button>					
					</fieldset>
		</div>
		
		
		

			<!-- 用户操作标题以及放一些快捷按钮 头部-->
			<div id="buttons">
				<!-- 组合排序 -->
				<button type="button" id="order1" onclick="openDiaO('mxmonth');">					
					<fmt:message key="order.title" />
				</button>				
				<!-- 模板查询 -->
				<button onclick='openQueryM(1);' id='mbquery1'>					
					<fmt:message key="oper.mod" />
				</button>
				<!--高级查询-->
				<button type="button" id='gjquery1'
					onclick="openDiaQueryG('query','mxmonth','1');" disabled="disabled">					
					<fmt:message key="oper.queryA" />
				</button>
				<!-- 将本查询保存为模板  -->
				<button type="button" id='savequery1' onclick="openModT();"
					disabled="disabled">					
					<fmt:message key="oper.modSave" />
				</button>				
				<!--导出-->
				<button type="button" id="export1"
					onclick="thisDownLoad('tsdCDR','mssql','mxmonth','<%=languageType%>')"
					disabled="disabled">					
					<fmt:message key="global.exportdata" />
				</button>
			</div>

			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
			
			<!-- 用户操作标题以及放一些快捷按钮  底部-->
			<div id="buttons">
				<!--组合排序-->
				<button type="button" id="order1" onclick="openDiaO('mxmonth');">					
					<fmt:message key="order.title" />
				</button>				
				<!-- 模板查询 -->
				<button onclick='openQueryM(1);' id='mbquery2'>
					<fmt:message key="oper.mod" />
				</button>
				<!--高级查询-->
				<button type="button" id='gjquery2'
					onclick="openDiaQueryG('query','mxmonth','1');" disabled="disabled">					
					<fmt:message key="oper.queryA" />
				</button>
				<!-- 将本查询保存为模板  -->
				<button type="button" id='savequery2' onclick="openModT();"
					disabled="disabled">
					<fmt:message key="oper.modSave" />
				</button>				
				<!--导出-->
				<button type="button" id="export2"
					onclick="thisDownLoad('tsdCDR','mssql','mxmonth','<%=languageType%>')"
					disabled="disabled">					
					<fmt:message key="global.exportdata" />
				</button>				
			</div>		


<!-- 添加模板面板 开始-->
		<div id="modT" name='modT' style="display: none" class="neirong">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							<fmt:message key="hponeDAM.functionname"/>
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
					<input type="hidden"></input>
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
								<input type="text" name="name_mod" id="name_mod" maxlength="50"
									onpropertychange="TextUtil.NotMax(this)" class="textclass" />
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
						style="width: 80px; heigth: 27px;" onclick="saveModQuery(1);">
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
<!-- 添加模板面板 开始-->

<!-- 导出数据 开始-->
			<div class="neirong" id="thefieldsform"
				style="display: none; width: 800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
						<div class="top_01left">
							<div class="top_02">
								<img src="style/images/public/neibut01.gif" />
							</div>
							<div class="top_03" id="titlediv">
								<fmt:message key='hponeDAM.chooseexportdata'/>
							</div>
							<div class="top_04">
								<img src="style/images/public/neibut03.gif" />
							</div>
						</div>
						<div class="top_01right">
							<a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="hponeDAM.close" /></a>
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
						<fmt:message key="hponeDAM.selectall"/>
					</button>
					<button type="submit" class="tsdbutton" id="query"
						onclick="getTheCheckedFields('tsdCDR','mssql','mxmonth');">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo">
						<fmt:message key="global.close" />
					</button>

				</div>
			</div>

			<input type="hidden" id="whickOper" />
<!-- 导出数据 结束-->


<!-- 页面通用隐藏域 开始-->
		<div style="display: none">
			<form name="childform" id="childform">
				<input type="text" id="queryName" name="queryName" value=""
					style="display: none" />
				<input type="text" id="fusearchsql" name="fusearchsql"
					style="display: none" />
			</form>
			<input type="hidden" id="imenuid" value="<%=imenuid%>" />
			<input type="hidden" id="zid" value="<%=zid%>" />
			<%
				if (!languageType.equals("en")) {
					languageType = "zh";
				}
			%>
			<input type="hidden" id="languageType" value="<%=languageType%>" />

			<input type="hidden" id="addinfo"
				value="<fmt:message key="global.add"/>" />
			<input type="hidden" id="deleteinfo"
				value="<fmt:message key="global.delete"/>" />
			<input type="hidden" id="editinfo"
				value="<fmt:message key="global.edit"/>" />
			<input type="hidden" id="queryinfo"
				value="<fmt:message key="global.query"/>" />

			<input type="hidden" id="operation"
				value="<fmt:message key="global.operation"/>" />
			<input type="hidden" id="operationtips"
				value="<fmt:message key="global.operationtips"/>" />
			<input type="hidden" id="successful"
				value="<fmt:message key="global.successful"/>" />
			<input type="hidden" id="deleteinformation"
				value="<fmt:message key="global.deleteinformation"/>" />

			<input type="hidden" id="worninfo"
				value="<fmt:message key="zhji.zjjxonly"/>" />
			<input type="hidden" id="worntips"
				value="<fmt:message key="powergroup.worntips"/>" />

			<input type="hidden" id="deletepower"
				value="<fmt:message key="global.deleteright"/>" />
			<input type="hidden" id="editpower"
				value="<fmt:message key="global.editright"/>" />

			<input type="hidden" id="zhjititle"
				value="<fmt:message key="tariff.zhji" />" />

			<input type="hidden" id="addright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="editfields" />
			<input type="hidden" id="delBright" />
			<input type="hidden" id="editBright" />
			<input type="hidden" id="exportright" />
			<input type="hidden" id="printright" />


			<!-- 用于写入日志 -->
			<input type="hidden" id="userloginip"
				value="<%=Log.getIpAddr(request)%>" />
			<input type="hidden" id="userloginid"
				value="<%=session.getAttribute("userid")%>" />
			<input type="hidden" id="thislogtime" value="<%=Log.getThisTime()%>" />
			<!-- 修改时保存原来数据的隐藏域 -->
			<input type="hidden" id="logoldstr" />
			<input type="hidden" id="useridd" value="<%=userid%>" />

			<!-- 打印报表 -->
			<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
			<!-- 高级查询 模板隐藏域 -->
			<input type="hidden" id="queryright" />
			<input type="hidden" id="queryMright" />
			<input type="hidden" id="saveQueryMright" />
			<!-- 查询树信息存放 -->
			<input type="hidden" id='treepid' />
			<input type="hidden" id='treecid' />
			<input type="hidden" id='treestr' />
			<input type="hidden" id='treepic' />

			<!-- grid自动 -->
			<input type="hidden" id='ziduansF' />
			<input type='hidden' id='thecolumn' />
			<input type="hidden" id="mxTable"/>
			
			<!-- 话单月份缺省起始日 -->
			<input type="hidden" id='TSection' value="<fmt:message key="hponeDAM.summaryoptions" />" />
			<input type='hidden' id='TIdent' value="<fmt:message key="hponeDAM.monthrecordstartdate" />" />
			
<!-- 页面通用隐藏域 结束-->			
	</body>
</html>
