<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/pubMode/SingleWordsNum.jsp
    Function:   话单数查询
    Author:     wenxuming
    Date:       2011-05-02
    Description: 
    Modify:     
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
	SimpleDateFormat formatto = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String nowTime = format.format(now);
	String nowTimeto = formatto.format(now);
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String depart = (String) session.getAttribute("departname");
	String userareaid = (String) session.getAttribute("userarea");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>电话话单数查询</title>
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
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>			
		<style type="text/css">
		#input-Unit .title{text-align:left;}
		.inputbox{{margin-left:20px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
		#tdiv td{line-height:26px;}
		</style>
		
		<script type="text/javascript">
		jQuery(document).ready(function()
		{
			$("#navBar").append(genNavv());
		    gobackInNavbar("navBar");
			$("#starttime").focus(function(){
				WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyyMM',alwaysUseStartDate:true});
			});
			getjhjidtype();		
			getGrid('1');
		});

		function getjhjidtype(){
		   $("#jhjidtype").empty();
           var querysel='';
           querysel+="<option value=''>--请选择--</option>";
		   var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=jhjid&cloum=jhjid,jhjname&key=1=1");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        	for(var i=0;i<res.length;i++){
        		querysel+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
        	}
		   $("#jhjidtype").html(querysel);
		}
		
		function getGrid(key){
				$("#gridd").empty();
				$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
				$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
				$("#editgrid").empty();
				var userid = $("#userid").val();
				var starttime = $("#starttime").val();
				if(starttime==""){alert("请选择时间月份！");return;}
				var jhjidtype = $("#jhjidtype").val();
				if(jhjidtype==""&&key!="1"){alert("请交换机类型！");return;}
				var querytype = $("#querytype").val();
				var timetype="";
				if(querytype=="2"){
					timetype="日期"
				}else{
					timetype="文件名"
				}
				var params="";
				params+="&userid="+userid;
				params+="&billmonth="+starttime;
				params+="&jhj_id="+jhjidtype;
				params+="&mode="+querytype;
				/*
				var result = fetchMultiPValue("SingleWordsNum.p_rpt_querybillcount",6,params);				
				if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
				{
					return;
				}*/
				var urlstr=tsd.buildParams({ packgname:'service',//java包
										clsname:'Procedure',//类名
										method:'exequery',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdExeType:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpname:'SingleWordsNum.p_rpt_querybillcount'
										});	
				/*
					var urlstr=tsd.buildParams({
												packgname:'service',//java包
												clsname:'ExecuteSql',//类名
												method:'exeSqlData',//方法名
												ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												tsdcf:'mssql',//指向配置文件名称
												tsdoper:'query',//操作类型 
												datatype:'xml',//返回数据格式 
												tsdpk:'dbsql_phone.queryFYtabledate',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												tsdpkpagesql:'dbsql_phone.querypageFYtabledate'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
												
					});*/
					jQuery("#editgrid").jqGrid({
						//url:'mainServlet.html?'+urlstr+"&cloum=TITLE,SVALUE&tablename=TT_RPT_querybillcount&key=userid='"+$("#userid").val()+"'",
						url:'mainServlet.html?'+urlstr+params,
						datatype: 'xml', 						
						colNames:[timetype,'话单数'],
						colModel:[{name:'TITLE',index:'TITLE',width:200},{name:'SVALUE',index:'SVALUE',width:200}],
						rowNum:10, //默认分页行数
						rowList:[10,15,20], //可选分页行数
						//multiselect:true,
						imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						pager: jQuery('#pagered'), 
						sortname:'TITLE', //默认排序字段
						//hidegrid: false, 
						sortorder: 'asc',//默认排序方式 
						//caption:infoo,				       	
						height:500, //高
						//width:document.documentElement.clientWidth-27,
						loadComplete:function(){			
												},
						ondblClickRow: function(ids) {
												}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 					 
							
		}
		</script>
  </head>
  <body>
    <div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
		</div>
		<table style='background-color: #F8F8FF; border-collapse: collapse;'>
			<tr>
				<td>
					<input type="text" id="starttime" value="<%=nowTime %>" style="width:150px;"/>				
				</td>
				<td>					
					<select id="jhjidtype" style="width:180px;"></select>
				</td>
				<td>
					<select id="querytype" style="width:150px;">
						<option value="2">按  天</option>
						<option value="1">文件名</option>
					</select>
				</td>
				<td>
					<button type="button" class="tsdbutton" onclick="getGrid();">查询</button>
				</td>
			</tr>
		</table>
	<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>	
	<input type="hidden" id="userid" value="<%=userid %>"/>	
	<input type="hidden" id="nowTime" value="<%=nowTime %>"/>
  </body>
</html>
