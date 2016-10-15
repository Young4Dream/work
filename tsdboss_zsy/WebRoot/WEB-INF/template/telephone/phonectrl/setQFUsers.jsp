<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/UserDetailsQuery.jsp
    Function:   电话用户详细资料查询
    Author:     wenxuming
    Date:       2011-04-19
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
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
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
		<title>电话用户详细信息查询</title>
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
		    $("#tabs").tabs();   	
			Dat = loadData("QFeeUsers","zh",2);
			getGrid('开机','');
			submitDate('');
			getTypeNum();
		});
		
		function getTypeNum(){
			var res = fetchMultiArrayValue("dbsql_phone.getQFeeUsersTypeNum",6,'','business');
			if(res[0][0]!=undefined&&res[0][0]!=""){
				for(var i=0;i<res.length;i++){
					if(res[i][0]=="开机"){
						$("#kj_oper").text(res[i][0]+"("+res[i][1]+")");
					}else if(res[i][0]=="欠费限呼"){
						$("#xh_oper").text(res[i][0]+"("+res[i][1]+")");
					}else if(res[i][0]=="欠费停机"){
						$("#qf_oper").text(res[i][0]+"("+res[i][1]+")");
					}else if(res[i][0]=="强制拆除"){
						$("#delete_oper").text(res[i][0]+"("+res[i][1]+")");
					}
				}
			}else{
				$("#kj_oper").text("开机用户");
				$("#xh_oper").text("欠费限呼");
				$("#qf_oper").text("欠费停机");
				$("#delete_oper").text("强制拆除");
			}
		}
		
		function getGrid(key,query){
			$("#fstypehidden").val(key);
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
			$("#editgrid").empty();
			var params="";
			params += "&cloum=" + tsd.encodeURIComponent(Dat.FieldName.join(","));
			if(query=="query"){
				params+="&fusearchsql="+tsd.encodeURIComponent($("#fusearchsql").val());
			}else{
				params+="&fusearchsql=1=1";
			}
			params+="&tjtype="+tsd.encodeURIComponent(key);
					var urlstr=tsd.buildParams({
												packgname:'service',//java包
												clsname:'ExecuteSql',//类名
												method:'exeSqlData',//方法名
												ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												tsdcf:'business',//指向配置文件名称
												tsdoper:'query',//操作类型 
												datatype:'xml',//返回数据格式 
												tsdpk:'dbsql_phone.queryFQFeeUsers',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												tsdpkpagesql:'dbsql_phone.querypageQFeeUsers'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
					jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+params,
						datatype: 'xml', 						
						colNames:Dat.colNames, 
						colModel:Dat.colModels, 
						rowNum:10, //默认分页行数
						rowList:[10,15,20], //可选分页行数
						multiselect:true,
						imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						pager: jQuery('#pagered'), 
						sortname: 'FSTIME', //默认排序字段
						multiboxonly:true,
						//hidegrid: false, 
						sortorder: 'desc',//默认排序方式 						
						height:170, //高
						//	width:document.documentElement.clientWidth-27,
						loadComplete:function(){
							var ids = $("#editgrid").getDataIDs();		
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
        
		function fuheExe(){
			if($("#queryType").val()==1){
				getGrid($("#fstypehidden").val(),'query');
			}else{
				submitDate('query');
			}
		}
		
		function submitDate(query){
			$("#gridd_d").empty();
			$("#gridd_d").append('<table id="editgrid_d" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd_d").append('<div id="pagered_d" class="scroll" style="text-align: left;"></div>');
			$("#editgrid_d").empty();
			var params="";
			params += "&cloum=" + tsd.encodeURIComponent(Dat.FieldName.join(","));
			if(query=="query"){
				params+="&fusearchsql="+tsd.encodeURIComponent($("#fusearchsql").val());
			}else{
				params+="&fusearchsql=1=1";
			}
				var urlstr=tsd.buildParams({
												packgname:'service',//java包
												clsname:'ExecuteSql',//类名
												method:'exeSqlData',//方法名
												ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												tsdcf:'business',//指向配置文件名称
												tsdoper:'query',//操作类型 
												datatype:'xml',//返回数据格式 
												tsdpk:'dbsql_phone.queryFQFeeUsers_set',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												tsdpkpagesql:'dbsql_phone.querypageQFeeUsers_set'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
					jQuery("#editgrid_d").jqGrid({
						url:'mainServlet.html?'+urlstr+params,
						datatype: 'xml', 						
						colNames:Dat.colNames, 
						colModel:Dat.colModels, 
						rowNum:10, //默认分页行数
						rowList:[10,15,20], //可选分页行数
						multiselect:true,
						imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						pager: jQuery('#pagered_d'), 
						sortname: 'FSTIME', //默认排序字段						
						//hidegrid: false, 
						multiboxonly:true,
						sortorder: 'desc',//默认排序方式 
						caption:'已接收数据',				       	
						height:170, //高
						//	width:document.documentElement.clientWidth-27,
						loadComplete:function(){
							var ids = $("#editgrid_d").getDataIDs();		
												},
						ondblClickRow: function(ids) {
												}
						}).navGrid('#pagered_d',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							);
		}
				
		function save(){
			var params="";
			var Batchall = $("#editgrid").getGridParam("selarrrow");
			if(Batchall.length==0)
			{
				alert("请选择要批量处理的数据");
				return;
			}
			var tval = [];
			for(var ii=0;ii<Batchall.length;ii++)
			{
				var tmp = $("#editgrid").getCell(Batchall[ii],"DH");
				if(null==tmp)
				{
					alert("没有可处理的合同号");
					return;
				}
				tval.push(tmp);
			}		
			params += "&hths=" + $.trim(tval.join(","));
			params += "&opertype=2";
			if(confirm("确定提交吗？")){	
				var ress = fetchMultiPValue('QueryOwningFee.submitHthQfje',6,params);
				if(ress!=undefined&&ress!=""&&ress[0][0]=="SUCCEED"){
					alert("操作成功！");
					$('#queryType').val(1);
					fuheExe();
					submitDate('');	
					getTypeNum();			
				}else{
					alert("操作失败！");
				}
			}
		}
		
		function save_ower(){
			var params="";
			var Batchall = $("#editgrid_d").getGridParam("selarrrow");
			if(Batchall.length==0)
			{
				alert("请选择要批量处理的数据");
				return;
			}
			var tval = [];
			for(var ii=0;ii<Batchall.length;ii++)
			{
				var tmp = $("#editgrid_d").getCell(Batchall[ii],"DH");
				if(null==tmp)
				{
					alert("没有可处理的电话");
					return;
				}
				tval.push(tmp);
			}
			params += "&hths=" + $.trim(tval.join(","));
			params += "&opertype=3";
			if(confirm("确定提交吗？")){							
				var ress = fetchMultiPValue('QueryOwningFee.submitHthQfje',6,params);
				if(ress!=undefined&&ress!=""&&ress[0][0]=="SUCCEED"){
					alert("操作成功！");
					submitDate('');
					getTypeNum();
				}else{
					alert("操作失败！");
				}
			}
		}
		
		function qfPrint()
		{
			var printfile ='commonreport/qf_printMD';
			var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+printfile+".cpt&fusearchsql="+$("#fusearchsql").val();		
			window.showModalDialog(urll,window,"dialogWidth:760px; dialogHeight:580px; center:yes; scroll:no");
		}

	</script>
  <body>
    <div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
		</div>
	<button id="" class="tsdbutton" onClick="openDiaQueryG('query','QFeeUsers');$('#queryType').val(1);" style="width:70px;">查询</button>	
	<button id="" class="tsdbutton" onClick="save();" style="width:70px;">提交处理</button>	
	<!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onClick="getGrid('开机','')"><span id="kj_oper">开机用户</span></a></li>
			<li><a href="#gridd" onClick="getGrid('欠费限呼','')"><span id="xh_oper">欠费限呼</span></a></li>
			<li><a href="#gridd" onClick="getGrid('欠费停机','')"><span id="qf_oper">欠费停机</span></a></li>		
			<li><a href="#gridd" onClick="getGrid('强制拆除','')"><span id="delete_oper">强制拆除</span></a></li>			
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>			
		</div>		
	</div>
	<button id="" class="tsdbutton" onClick="openDiaQueryG('query','QFeeUsers');$('#queryType').val(2);" style="width:70px;">查询</button>	
	<button id="" class="tsdbutton" onClick="save_ower();" style="width:200px;">处理完毕状态将更新到数据库</button>	
	<button id="" class="tsdbutton" onClick="qfPrint();" style="width:70px;">打印</button>	
	<div id="gridd_d">
		<table id="editgrid_d" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered_d" class="scroll" style="text-align: left;"></div>			
	</div>
	<!-- 高级查询 -->		
	<input type="hidden" id="queryName" name="queryName" value=""/>
	<input type="hidden" id="fusearchsql" name="fusearchsql" value="1=1"/>
	<!-- 查询树信息存放 保存模板查询 -->
	<input type="hidden" id='treepid'/>
	<input type="hidden" id='treecid'/>
	<input type="hidden" id='treestr'/>
	<input type="hidden" id='treepic'/>
	<input type="hidden" id="fieldname"/>
	<input type="hidden" id="countlength"/>
	<input type="hidden" id="languageType" value="<%=languageType %>"/>
	<input type="hidden" id="userid" value="<%=userid %>"/>
	<input type="hidden" id="area" value="<%=area %>"/>
	<input type="hidden" id="zid" value="<%=zid %>"/>
	<input type="hidden" id="imenuid" value="<%=imenuid %>"/>
	<!-- 打印报表 -->
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' />
	<input type="hidden" id="fstypehidden"/>
	<input type="hidden" id="queryType"/>
  </body>
</html>
