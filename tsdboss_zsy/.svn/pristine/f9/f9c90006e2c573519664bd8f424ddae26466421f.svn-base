<%----------------------------------------
	name: hfhz.jsp 
	author: 孙琳
	version: 1.0, 2010-11-04
	description: 话费汇总
	modify: 
			2010-12-13  liwen   去掉汇总时调试打印语句
			2010-12-14  chenze  修改扣费调用方式，增加等待状态
			2011-02-27  cz      修改扣费调用方式，去除callpaytype等无用参数
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	String departname = (String)session.getAttribute("departname");
	String languageType = (String) session.getAttribute("languageType");
	String managearea = (String)session.getAttribute("managearea");
	if (!languageType.equals("en")) {
			languageType = "zh";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>

  <head>    
	<title>话费查询</title>
	
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
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
		<!-- 时间选择器 -->
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		
		<script language="javascript">
		/**
		 * 初始化
		 * @param 无参数
		 * @return 无返回值
		 */
		$(function(){
			$("#navBar").append(genNavv());
			gobackInNavbar("navBar");
			$("#queryparam td:even").css({"background-color":"#c9d4ea","text-align":"right","padding-right":"1em"});
			var column  = '';
			var thisdata = loadData('jfgl_hthhftj','<%=languageType%>',1,'');
			column = thisdata.FieldName.join(',');			 					
			$('#thecolumns').val(column);
		});
		
		function queryInfo(){
			$("#hz").attr("disabled","disabled");
			var hzyf=$("#hzyf").val();
			
			if(hzyf=="" || hzyf==undefined){
				alert("请输入汇总月份！");
				$("#hzyf").focus();
				$("#hz").attr("disabled","");
				return false;
			}
			
			$("#queryparam").hide();
			$("#infolist").show();
			
			
			var res = fetchSingleValue('innertransfer.listpage',6,'&hzyf='+hzyf);//是否已经汇总
			if(res==0){
				var flag=fetchMultiPValue('hfquery.Hftj_Dngyzb',6,'&hzyf='+hzyf);
				if(flag=="true"){
					initGrid_Detail(hzyf);
				}
			}else{
				initGrid_Detail(hzyf);
			}
		}
		
		//初始化设备子设备表格
		function initGrid_Detail(yf){
		
			///设置命令参数
			 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:'innertransfer.list',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				tsdpkpagesql:'innertransfer.listpage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			jQuery("#editgrid").jqGrid({  	
				url:'mainServlet.html?'+urlstr+"&hzyf="+yf, 
				datatype: "xml",
			   	//colNames:['操作','汇总月份','合同号','用户名称','月租合计','话费合计','话费补贴','出差话费','代金券','转账'],
			   	colNames:['操作','汇总月份','合同号','用户名称','月租合计','话费合计','话费补贴','代金券','转账'],
			   	colModel:[
			   		{name:'viewOperation',index:'viewOperation', width:60},
			   		{name:'hzyf',index:'hzyf', width:60},
			   		{name:'hth',index:'hth', width:60},
			   		{name:'bmmc',index:'bmmc', width:120},
			   		{name:'yuezu',index:'yuezu', width:90},
			   		{name:'hf',index:'hf', width:80},
			   		{name:'hfbutei',index:'hfbutei', width:80},					
			   		//{name:'cchf',index:'cchf', width:90},
			   		{name:'daijinquan',index:'daijinquan', width:90},
			   		{name:'zhuanzhang',index:'zhuanzhang', width:90}
			   	],
			   	rowNum:15,
			   	rowList:[15,30,128],
			   	imgpath: 'plug-in/jquery/jqgrid/themes/basic/images/',
			   	pager: jQuery('#pagered'),
			   	sortname: 'hth',
			    viewrecords: true,
			    sortorder: "asc",
			    pgbuttons: true,
				caption:"  ",
				height:document.documentElement.clientHeight-150,
				width:document.documentElement.clientWidth-50,
				loadComplete: function() { 					
					addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" title="修改"/>','openRowModify','hth','click',1,'hzyf','hfbutei','cchf','daijinquan','zhuanzhang');
				 	
					executeAddBtn('editgrid',1);	
										
				}							
			}).navGrid('#pagered',{refresh: true, edit: false, add: false, del: false, search: false});
		}
		/**
		 * 预修改信息
		 * @param key(唯一标识)
		 * @return 无返回值(查询预修改记录)
		 */
		function openRowModify(key){
			$("#modify").show();
			clearText('operform'); 
			$("#huizyf").val(arguments[1]);
			$("#hthinfo").val(key);
			$("#hfbutie").val(arguments[2]);
			$("#cchf").val(arguments[3]);
			$("#daijinquan").val(arguments[4]);
			$("#zhuanzhang").val(arguments[5]);
			
			
			$("#titledivs").html("修改资料");
			autoBlockForm('add',60,'close',"#ffffff",false);//弹出查询面板
		}
		/**
		 * 将修改后的信息保存起来
		 * @param 无参数
		 * @return 无返回值
		 */
		function modifyInfo(){
			$('#thestate').val(1);
			
			var hzyf=$("#huizyf").val();
			var hth=$("#hthinfo").val();
			var hfbutie=$("#hfbutie").val();
			var cchf=$("#cchf").val();
			var daijinquan=$("#daijinquan").val();
			var zhuanzhang=$("#zhuanzhang").val();

			 var params = "";
			 if(hzyf==""||hzyf=="undefined"){
			 	params+="&hzyf=null";
			 }else{
			 	params+="&hzyf="+tsd.encodeURIComponent(hzyf);
			 }
			 if(hth==""||hth=="undefined"){
			 	params+="&hth=null";
			 }else{
			 	params+="&hth="+tsd.encodeURIComponent(hth);
			 }
			 
			 if(hfbutie==""||hfbutie=="undefined"){
			 	params+="&hfbutie=null";
			 }else{
			 	params+="&hfbutie="+tsd.encodeURIComponent(hfbutie);
			 }
			 
			 if(cchf==""||cchf=="undefined"){
			 	params+="&cchf=null";
			 }else{
			 	params+="&cchf="+tsd.encodeURIComponent(cchf);
			 }
			 
			 if(daijinquan==""||daijinquan=="undefined"){
			 	params+="&daijinquan=null";
			 }else{
			 	params+="&daijinquan="+tsd.encodeURIComponent(daijinquan);
			 }
			 
			 if(zhuanzhang==""||zhuanzhang=="undefined"){
			 	params+="&zhuanzhang=null";
			 }else{
			 	params+="&zhuanzhang="+tsd.encodeURIComponent(zhuanzhang);
			 }
			 if(params==false){return false;}
			 var key=$("#hidid").val();
					///设置命令参数
			 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'exe',//操作类型 
						 					tsdpk:'innertransfer.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});
					urlstr+=params;
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							alert('修改成功!');
							/*************
							** 释放资源 **
							************/
							//isReadonly(true);
							setTimeout($.unblockUI, 15);
							$("#editgrid").trigger("reloadGrid");
						}else{
							alert("修改失败!");
							return false;
						}	
					}
				});
		}
		//返回操作
		function reback(){
			
			$("#queryparam").show();
			$("#infolist").hide();
			$("#hz").attr("disabled","");
			
		}
		/**
		 * 批操作
		 * @param 无参数
		 * @return 无返回值
		 */
		function fuheExe()
		{
				fuheQuery();
		}
		/**********************************************************
				function name:    fuheQuery()
				function:		  高级查询方法，获取通用查询模块生成的sql语句进行查询，更新jqgrid
				parameters:       
				return:			  
				description:      
				Date:				2010-9-7 
		********************************************************/
		function fuheQuery()
		{
				var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
				if(params=='&fusearchsql='){
					params +='1=1';
				}	
						
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'innertransfer.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'innertransfer.fuheQueryByWherepage'
											});
				var link = urlstr1 + params;
				$("#editgrid").setGridParam({url:'mainServlet.html?'+link+"&hzyf="+$("#hzyf").val()}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 0);//关闭面板
		}
		
		////合并打印预览		
		function ghPrintPrew(flag)
		{
			var reportfilename = "";
			if(flag=="1"){
				reportfilename = "jfgl_dngyzb";
			}else{
				reportfilename = "jfgl_Dngyzb_two"
			}
			
			var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
			if(params=='&fusearchsql='){
				params +='1=1';
			}
			params +=" and hzyf='"+$("#hzyf").val()+"'";
	
			printThisReport1('<%=request.getParameter("imenuid")%>',
				reportfilename,params,
				'<%=(String)session.getAttribute("userid")%>',
				'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
				'<%=(String)session.getAttribute("departname")%>',1);
		}
		</script>
		<style type="text/css">
			#loading{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:300px;
				width:608px;
				text-align:center;
				background:#FFFFFF;
				border:2px solid #cecece;
				z-index:2;
				padding:12px;
				font-size:13px;
			}
			#backgroundPopup{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:100%;
				width:100%;
				top:0;
				left:0;
				background:#ffffff;
				border:1px solid #cecece;
				z-index:1;
			}
			.tsdbutton{margin:2px;padding:0px 10px 5px 10px;height:24px;line-height:24px;margin-bottom:-2px;}
			.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/imgs/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
			.inputbox{{margin-left:2px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
			#queryparam{border:#7691c7 1px solid;width:400px;margin-left:auto;margin-right:auto;margin-top:60px;}
			#queryparam td{line-height:28px;border:#7691c7 1px solid;}
			#hzyf,#ptype_rd_commonuser,#ptype_rd_biguser{margin-left:2px;}
			#feedetailcontainer{width:600px;margin:auto;}
			#feedetailcontainer{margin-left:20px;}
			.feedetail{border:#7691c7 0px solid;width:560px;margin-left:auto;margin-right:auto;margin-top:20px;}
			.feedetail td{line-height:28px;border:#7691c7 0px solid;}
		</style>
  </head>
  
  <body>
	<input type="hidden" name="skrid" id="skrid" value="<%=session.getAttribute("userid") %>"/>
  
	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
	
	<table id="queryparam">
		<tr>
			<td width="25%">查询月份</td>
			<td>
				<input type="text" id="hzyf"  onfocus="WdatePicker({startDate:'%y-%M',dateFmt:'yyyyMM',alwaysUseStartDate:true})" style="width: 150px;margin-top: 5px;margin-bottom: 5px;height: 20px;margin-left: 15px;"/>
				<button id="hz" name="hz" class="tsdbutton" onclick="queryInfo()" style="margin-left: 20px;margin-top: 5px;margin-bottom: 5px;">查询</button>
			</td>
		</tr>
	</table>
	
	<!-- 用户操作标题以及放一些快捷按钮-->
	<div id="infolist" style="display: none;">
	
		<div id="buttons">
	
			<button type="button" id="openadd" style="display: none;" onclick="openText();">
				<fmt:message key="global.add" />
			</button>
			<button type="button" id='gjquery1' onclick="openDiaQueryG('query','jfgl_dngyzb');">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='gjquery1' onclick="ghPrintPrew('1');">
				内部转账预览打印
			</button>
			<button type="button" id='gjquery1' onclick="ghPrintPrew('2');">
				动能供应预览打印
			</button>
			<button type="button" onclick="reback();" style="margin-left: 100px;">
				返回
			</button>
		</div>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>
	
	<div class="neirong" id="add" style="display: none; width: 600px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titledivs">
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="clearText('operform');reloadData();"> <!-- 关闭 -->
							<fmt:message key="groupManager.close" /> </a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="operform" id="operform"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass" width="16%;">
								汇总月份
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="huizyf" id="huizyf" class="textclass"
									style="width: 150px" disabled="disabled" />
							</td>
							<td class="labelclass" width="16%">
								合同号
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="hthinfo" class="textclass"
									style="width: 150px" id="hthinfo" disabled="disabled" />
							</td>
						</tr>

						<tr>
							<td class="labelclass" width="16%">
								话费补贴
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="hfbutie" id="hfbutie"
									class="textclass" style="width: 150px" />
							</td>
							<td class="labelclass" width="16%">
								出差话费
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="cchf" class="textclass" 
									style="width: 150px" id="cchf" />
							</td>
						</tr>
						<tr>
							<td class="labelclass" width="16%">
								代金券
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="daijinquan" id="daijinquan" 
									class="textclass" style="width: 150px"/>
							</td>
							<td class="labelclass" width="16%">
								转账
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="zhuanzhang" class="textclass" 
									style="width: 150px" id="zhuanzhang" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button id="modify" name="modify" class="tsdbutton" onclick="modifyInfo();" style="margin-left: 20px;margin-top: 5px;margin-bottom: 5px;"><fmt:message key="global.edit" /></button>
				<button id="close" name="close" class="tsdbutton" onclick="clearText('operform');" style="margin-left: 20px;margin-top: 5px;margin-bottom: 5px;"><fmt:message key="global.close" /></button>
			</div>
		</div>
	
	
	<!-- 基本 -->
	<input type="hidden" id="useridd" value="<%=userid%>"/>	
	<input type="hidden" id="imenuid" value="<%=imenuid%>" />
	<input type="hidden" id="zid" value="<%=zid%>" />
	<input type="hidden" id="departname" value="<%=departname%>" /><!-- 部门 -->
		
	<input type="hidden" id="languageType" value="<%=languageType%>" />
	<input type="hidden" id="managearea" value="managearea"/>
	

	<!-- 高级查询 -->		
	<input type="hidden" id="queryName" name="queryName" value=""  />
	<input type="hidden" id="fusearchsql" name="fusearchsql"  />
			
	<!-- 用于写入日志 -->
	<input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request)%>" />
	<input type="hidden" id="userloginid" value="<%=session.getAttribute("userid")%>" />
	<input type="hidden" id="thislogtime" value="<%=Log.getThisTime()%>" />		
	<input type="hidden" id="LogContentS"  /><!-- 拼接添加、修改的字符串 -->
	<input type="hidden" id="logoldstr" /><!-- 修改时保存原来数据的隐藏域 -->
	<input  type="hidden" name="BatchEditLog" id="BatchEditLog" />	<!-- 批量修改时保存原来数据的隐藏域 -->
	
	
	<!-- 打印报表 -->
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /> 
	<input type="hidden" id="thecolumns"/>		
	
  </body>
</html>
