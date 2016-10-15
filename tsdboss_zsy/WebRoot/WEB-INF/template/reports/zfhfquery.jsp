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
			
			var time1=$("#time1").val();
			var time2=$("#time2").val();
			
			var flag=fetchMultiPValue('zfhfquery.Hftj_Hfszb',6,'&time1='+time1+"&time2="+time2+"&isflag="+$("#isflag").val());
			
			if(flag=="true"){
				$("#queryparam").hide();
				$("#infolist").height(document.documentElement.clientHeight-50);
				$("#infolist").show();
				
				
				
				var menuid=$("#imenuid").val();
				//var tablename='';
				var userid= $("#useridd").val();
				var groupid = $("#zid").val();
				groupid=groupid.replace(new RegExp("~","g"),",");
				var userdept= $("#departname").val();
				var basepath=$("#thisbasePath").val();
				var time1=$("#time1").val();
				
				var params="";
				
				params+="&hzyf="+time1.substring(0,7).replace('-','');
				params+="&time1="+$("#time1").val();
				params+="&time2="+$("#time2").val();
				params+="&year="+$("#badyear").val();
				params+="&month="+$("#badmonth").val();
				params+="&badfee="+$("#badfee").val();
				
				
				//进行打印操作
    			var reportInfo = basepath + 'ReportServer?reportlet=/com/tsdreport/commonreport/jfgl_hfszb.cpt'+cjkEncode(params)+'&userid='+userid+'&groupid='+groupid+'&userdept='+cjkEncode(userdept);
    			$("#reportIF").attr("src",reportInfo);	
			}
			
			
		}
	
		//返回操作
		function reback(){
			
			$("#reportIF").attr("src","about:blank");
			$("#infolist").hide();
			$("#queryparam").show();
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
											  tsdpk:'hfQuery.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'hfQuery.fuheQueryByWherepage'
											});
				var link = urlstr1 + params;
				$("#editgrid").setGridParam({url:'mainServlet.html?'+link+"&hzyf="+$("#hzyf").val()}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 0);//关闭面板
		}
		
		////合并打印预览		
		function ghPrintPrew()
		{
			var reportfilename = "jfgl_hthhftj";
			
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
			<td width="25%">开始时间</td>
			<td>
				<input type="text" id="time1"  onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" style="width: 150px;margin-top: 5px;margin-bottom: 5px;height: 20px;margin-left: 15px;line-height: 20px;"/>
			</td>
		</tr>
		<tr>
			<td width="25%">结束时间</td>
			<td>
				<input type="text" id="time2"  onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" style="width: 150px;margin-top: 5px;margin-bottom: 5px;height: 20px;margin-left: 15px;line-height: 20px;"/>
			</td>
		</tr>
		<tr>
			<td width="25%">坏账截止月份</td>
			<td>
				<input type="text" id="badyear"  style="width: 45px;margin-top: 5px;margin-bottom: 5px;height: 20px;margin-left: 15px;line-height: 20px;"/>
				<span style="vertical-align: middle;height: 29px;">&nbsp;年&nbsp;</span>
				<input type="text" id="badmonth" style="width: 45px;margin-top: 5px;margin-bottom: 5px;height: 20px;margin-left: 5px;line-height: 20px;"/>
				<span style="vertical-align: middle;height: 29px;">&nbsp;月&nbsp;</span>
			</td>
		</tr>
		<tr>
			<td width="25%">坏账总额</td>
			<td>
				<input type="text" id="badfee"  style="width: 150px;margin-top: 5px;margin-bottom: 5px;height: 20px;margin-left: 15px;line-height: 20px;"/>
			</td>
		</tr>
		<tr>
			<td width="25%">是否重算</td>
			<td>
				<select id="isflag" style="width: 150px;margin-top: 5px;margin-bottom: 5px;height: 20px;margin-left: 15px;">
					<option value="0" selected="selected">是</option>
					<option value="1">否</option>
				</select>
				<button id="hz" name="hz" class="tsdbutton" onclick="queryInfo()" style="margin-left: 20px;margin-top: 5px;margin-bottom: 5px;">查询</button>
			</td>
		</tr>
	</table>
	
	
	<!-- 报表div-->
	<div id="infolist" style="display: none;">
		<a onclick="reback();"
			style="float: right; cursor: pointer; text-decoration: underline; color: blue;">返回重选统计条件</a>
		<iframe name="reportIF" id="reportIF"
			style="width: 100%; height: 100%;"></iframe>

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
