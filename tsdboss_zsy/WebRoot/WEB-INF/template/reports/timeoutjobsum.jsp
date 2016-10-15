<%----------------------------------------
	name: 
	author: huoshuai
	version: 1.0
	description: 超时工单汇总
	modify: 
			
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
	<title>超时工单汇总</title>
	
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
		});
		function submitQuery(){
				var begin=$("#tBegin").val();
				var end=$("#tEnd").val();
				if(begin=="" && end==""){
					alert("请选择时间范围！");
					return;
				}
				$("#queryparam").hide();
				$("#reportdiv").height(document.documentElement.clientHeight-50);
				$("#reportdiv").show();
				openDiaPrintWorkload();
			}
			function openDiaPrintWorkload(){
				//////////////////
				/////报表参数设置
				//////////////////
				//设置全局参数
				var menuid=$("#imenuid").val();	
				var userid= $("#skrid").val();
				var groupid = $("#zid").val();
				groupid=groupid.replace(new RegExp("~","g"),",");
			
				var repName=$("#reportname").val();
				var reportName = 'commonreport/timeoutjobsum.cpt';
				var conds="";
				var rightflag=$("#hidrightflag").val();
				
				//设置局部参数
				var params= "";
				var begin=$("#tBegin").val();
				var end=$("#tEnd").val();
				var sbm=$("#sbm").val();
				var tmp="'";
				
				if(begin!=""){
					begin=begin+" 00:00:00";
				}
				if(end!=""){
					end=end+" 23:59:59";
				}
				params+="&begin="+begin;
				params+="&end="+end;
				if(sbm!="-1"){
					params+="&sbm="+sbm;
				}
				//alert(params);
				
				var reportInfo = $("#thisbasePath").val() + 'ReportServer?reportlet=/com/tsdreport/'+reportName+cjkEncode(params)+'&userid='+userid+'&groupid='+groupid;
		        $("#reportIF").attr("src",reportInfo);
				
			}
			/***************************************************
			* 函数名： reback
			* 版权所有 (C) 2013 泰思达
			* 描述：返回重新选择条件
			* 作者：shuoshuai
			* 创建日期：20130719
			* 修订记录：
			**************************************************/
			function reback(){
				$("#reportIF").attr("src","about:blank");
				$("#reportdiv").hide();
				$("#queryparam").show();
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
			#queryparam{border:#7691c7 1px solid;width:500px;margin-left:auto;margin-right:auto;margin-top:60px;}
			.qtd1{line-height:40px;border:#7691c7 1px solid;background-color: #C9D4EA;text-align: right;margin-left: 10px;padding-right: 5px;}
			.qtd2{line-height:40px;border:#7691c7 1px solid;text-align: left;padding-left: 10px;}
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
			<td class="qtd1" width="25%">时间段</td>
			<td class="qtd2">
				<div style="float: left;">
					<input type="text" readonly="readonly" name="tBegin" id="tBegin"
						style="width: 120px;cursor: pointer;" class="Wdate"
						onFocus="WdatePicker({startDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'tEnd\')}',dateFmt:'yyyy-MM-dd',isShowClear:false,alwaysUseStartDate:true})" />
					&nbsp;&nbsp;&nbsp;
				</div>
				<div style="float: left;"><b style="line-height: 30px;">To:</b></div>
				<div style="float: left;">
					&nbsp;&nbsp;&nbsp;
					<input type="text" readonly="readonly" name="tEnd" id="tEnd"
					style="width: 120px;cursor: pointer;" class="Wdate"
					onFocus="WdatePicker({startDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'tBegin\')}',dateFmt:'yyyy-MM-dd',isShowClear:false,alwaysUseStartDate:true})" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="qtd1">
				部门：
			</td>
			<td class="qtd2">
				<select id="sbm" style="width: 180px;">
					<option value="-1">请选择</option>
					<option value="4">外线班</option>
				</select>
			</td>
		</tr>
		<tr>
			<td class="qtd2" colspan="2" style="text-align: center;line-height: 28px;">
				<button id="query" style="height: 30px;margin-top: 10px;width: 70px;" onclick="submitQuery();"> 查 询 </button>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button id="reset" style="height: 30px;width: 70px;"> 重 置 </button>
			</td>
		</tr>
	</table>
	
	
	<!-- 报表div-->
	<div id="reportdiv" style="display: none;">
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
