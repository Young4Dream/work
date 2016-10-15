﻿<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/phonectrl/OperOwningFee.jsp
    Function:   查询欠费用户，并提交欠费用户
    Author:     wenxuming
    Date:       2012-06-22
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
		<title>查询欠费用户</title>
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
			#qftrid{background-color:#A9C8D9;border:#A9C8D9 solid 0px;}
			#qftrid{border-collapse:collapse;border:#A9C8D9 solid 1px;}
			#qfuser tr td{line-height:26px;border:#A9C8D9 solid 1px;TEXT-OVERFLOW: ellipsis;}
		</style>
		<style type="text/css">  
		.mytable{   
		   width:100%;
		   table-layout:fixed;
		   border:0px;   
		   margin:0px; 
		   }      
		.mytable tr td{   
		   text-overflow:ellipsis; /* for IE */    
		   -moz-text-overflow: ellipsis; /* for Firefox,mozilla */    
		    overflow:hidden;   
		    white-space: nowrap;   
		    border:0px;   
		    text-align:left;      
		   }
		   .mytable tr th{   
		    white-space: nowrap;   
		   border:0px;   
		    text-align:left   
		   }   
		</style> 
		<script type="text/javascript">		
		jQuery(document).ready(function()
		{			
			$("#navBar").append(genNavv());
		    gobackInNavbar("navBar");
		    Dat = loadData("yhdang_cv","zh",2);
			Dat_tmp = loadData("queryqfee_tmp","zh",2);			
		    getJqgridDate();
			submitDate('');
		    /*
			res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=distinct bm&tablename=scddbm&key=1=1");
			if(res[0]!=undefined)
			{
				var optHtml = "<option value=\"\">--请选择--</option>";
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml = optHtml + "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
				}
				$("#fsbm").html(optHtml);
			}
			*/
		});	
		
		function fuheExe(){
			getJqgridDate("query");
		}
		
		function dcfield(){
			thisDownLoad('tsdBilling','mssql','yhdang_cv',$("#languageType").val(),5);
		}
		
		/**
		 * 导出面板确定按钮事件，导出数据
		 * @param 
		 * @return 
		 */
		function DownSure()
		{
			getTheCheckedFields('tsdBilling','mssql','yhdang_cv');
		}

		/****************
	    *备注限制函数getJqgridDate
	    *oTextArea:内容
	    *******************/
	    var TextUtil = new Object(); 
	      TextUtil.NotMax = function(oTextArea){ 
	          var maxText = oTextArea.getAttribute("maxlength"); 
	          if(oTextArea.value.length > maxText){ 
	                 oTextArea.value = oTextArea.value.substring(0,maxText); 
	                  alert("输入超出限制！"); 
	          } 
	      } 	
	</script>
	<script type="text/javascript">
		function getJqgridDate(query){
			var userid = $("#userid").val();
			var qfjemax = $("#qfjemax").val();
			var TJtype = $("#TJtype").val();
			var strparams="";
			strparams="&userid="+userid+"&opentype="+TJtype+"&minfee="+qfjemax;
     	                if(query=="query"){
				strparams="&userid="+userid+"&opentype=querykey&minfee="+qfjemax;
			}
			var result = fetchMultiPValue("queryOwningFee.queryQFee",6,strparams);
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
			$("#editgrid").empty();
			$("#radiophone").val("");
			$("#radioHwjb").val("");
			$("#radioServiceType").val("");
			$("#radioAdjust_Man").val("");
			$("#qfuser").empty();
			var querystr = "";
			var params="";
			var fieldname = $("#fieldname").val();
			fieldname = fieldname.substring(0,fieldname.length-1);
			$("#tablevaluestr").empty();
			var queryphone = $("#queryphone").val();
			if(query=="query"){
				params="&fusearchsql="+tsd.encodeURIComponent($("#fusearchsql").val())+" and operid='"+userid+"'";
			}else{
				params="&fusearchsql=1=1 and operid='"+userid+"'";
			}
			params+="&qfjemin="+$("#qfjemin").val();
			params+="&qfjemax="+$("#qfjemax").val();
			
			//$("#fusearchsql").val(" 1=1 and qfjemax>="+$("#qfjemax").val());

			var temp = Dat.FieldName.join(",");
			var urlstr=tsd.buildParams({
				packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'business',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:'dbsql_phone.queryqfee',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				tsdpkpagesql:'dbsql_phone.queryqfeepage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			var str = $("#TJtype option:selected").text();
			if(str=="--请选择--"){
				str='强制拆除';	
			}
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&cloumn="+temp+params+"&zttype="+tsd.encodeURIComponent(str),
				datatype: 'xml', 						
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				rowNum:70, //默认分页行数
				multiselect:true,
				useDefault:true,
				rowList:[30,50,100], //可选分页行数
				//multiselect:true,
				imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				pager: jQuery('#pagered'), 
				sortname: 'qfys', //默认排序字段
				viewrecords: true,
				//hidegrid: false, 
				multiboxonly:true,
				sortorder: 'asc',//默认排序方式 
				caption:'电话欠费用户查询',
				//caption:infoo,				       	
				height:300, //高
				//width:document.documentElement.clientWidth-27,
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
		
		/*
		*批量炒作进行
		*
		*/
		function BatchOpensave(){			
			var Batchall = $("#editgrid").getGridParam("selarrrow");
			if(Batchall.length==0)
			{
				alert("请选择要批量处理的数据");
				return;
			}
			var TJtype = $("#TJtype").val();
			if(TJtype==""){
				alert("请选操作类型！");
				$("#fsbm").select().focus();
				return;
			}

			var params="";									
			var tval = [];
			for(var ii=0;ii<Batchall.length;ii++)
			{
				var tmp = $("#editgrid").getCell(Batchall[ii],"DH");
				if(null==tmp)
				{
					alert("没有可打印报表的合同号");
					return;
				}
				tval.push(tmp);
			}
			params += "&hths=" + $.trim(tval.join(","));
			params += "&minfee="+$("#qfjemax").val();
			params += "&opentype="+TJtype;
			params += "&userid="+$("#userid").val();
			params += "&opertype=1";
			if(confirm("确定提交吗？")){	
				var ress = fetchMultiPValue('QueryOwningFee.submitHthQfje',6,params);
				if(ress!=undefined&&ress!=""&&ress[0][0]=="SUCCEED"){
					alert("操作成功！");
					getJqgridDate('');	
					submitDate('');
					return;
				}else{
					alert("操作失败:"+ress[0][1]);
				}	
			}
		}
		
		function submitDate(query){
			$("#gridd_d").empty();
			$("#gridd_d").append('<table id="editgrid_d" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd_d").append('<div id="pagered_d" class="scroll" style="text-align: left;"></div>');
			$("#editgrid_d").empty();
			var params="";
			params += "&cloumn=" + tsd.encodeURIComponent(Dat_tmp.FieldName.join(","));
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
												tsdpk:'dbsql_phone.queryqfee_tmp',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												tsdpkpagesql:'dbsql_phone.queryqfee_tmppage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
					jQuery("#editgrid_d").jqGrid({
						url:'mainServlet.html?'+urlstr+params,
						datatype: 'xml', 						
						colNames:Dat_tmp.colNames, 
						colModel:Dat_tmp.colModels, 
						rowNum:10, //默认分页行数
						rowList:[10,15,20], //可选分页行数
						//multiselect:true,
						imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						pager: jQuery('#pagered_d'), 
						sortname: 'operdate', //默认排序字段						
						//hidegrid: false, 
						multiboxonly:true,
						sortorder: 'desc',//默认排序方式 
						caption:'已提交处理数据',				       	
						height:200, //高
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
		
		function qfPrint()
		{
			var params="";
			var tval = [];
			var Batchall = $("#editgrid").getGridParam("selarrrow");
			if(Batchall.length==0)
			{
				alert("请选择要打印的电话数据！");
				return;
			}
			for(var ii=0;ii<Batchall.length;ii++)
			{
				var tmp = $("#editgrid").getCell(Batchall[ii],"DH");
				if(null==tmp)
				{
					alert("没有要打印的电话数据！");
					return;
				}
				tval.push(tmp);
			}
			params += "&dhto=" + $.trim(tval.join(","));
			params += "&userid=" + $("#userid").val();
			params += "&tjtype=" + tsd.encodeURIComponent($("#TJtype option:selected").text());
			var ress = fetchMultiPValue('QueryOwningFee.setqueryqfee',6,params);
			if(ress!=undefined&&ress!=""&&ress[0][0]=="SUCCEED"){
				var printfile ='commonreport/qf_printMD';
				var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/"+printfile+".cpt&fusearchsql="+$("#fusearchsql").val()+"&userid="+$("#userid").val()+"&tjtype="+tsd.encodeURIComponent($("#TJtype option:selected").text());
				window.showModalDialog(urll,window,"dialogWidth:760px; dialogHeight:580px; center:yes; scroll:no");
			}else{
				alert("数据量过大");
			}	
		}
	</script>
  </head>
  <body>
    <div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
	</div>
	<div id="input-Unit">
		<table cellspacing='5'>
			<tr>
				<td>
					<button id="" class="tsdbutton" onClick="openDiaQueryG('query','yhdang_cv');" style="width:70px;">高级查询</button>
				</td>				
				<td>
					<button id="" class="tsdbutton" onClick="dcfield();" style="width:70px;">导出数据</button>
				</td>
				<td>
					操作类型
				</td>
				<td>
					<select id="TJtype" style="width:150px;" onChange="getJqgridDate();">
						<option value="">--请选择--</option>
						<option value="K">开机</option>
						<option value="H">欠费限呼</option>
						<option value="T">欠费停机</option>
						<option value="DELETE">强制拆除</option>						
					</select>
				</td>
				<td>欠费金额</td>
				<td>>=</td>
				<td><input type="text" id="qfjemax" style="width:50px;" value="1"/></td>
				<td>
					<button id="" class="tsdbutton" onClick="getJqgridDate();" style="width:70px;">查询</button>
				</td>
				<td>
					<button id="" class="tsdbutton" onClick="BatchOpensave();" style="width:70px;">批量提交</button>
				</td>
				<td>
					<button id="" class="tsdbutton" onClick="qfPrint();" style="width:70px;">打印</button>
				</td>
			</tr>
		</table>
		<div id='tabletitle' style="display:none;">
			
		</div>
		<div id='tablevaluestr'>
		
		</div>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>
		<div id="gridd_d">
			<table id="editgrid_d" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered_d" class="scroll" style="text-align: left;"></div>			
		</div>
	</div>
	<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:763px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">选择您要导出的数据字段</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onClick="javascript:$('#closethisinfo').click();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			   <form action="#" onSubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<div id="thelistform" style="margin-left: 10px;max-height: 200px">
						
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt" style="width:745px">
			<button type="submit" class="tsdbutton" id="query" onClick="checkedAllFields()">
				全选
			</button>
			<button type="submit" class="tsdbutton" id="query" onClick="DownSure()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>			
		</div>
	</div>		
	<!-- 高级查询 -->		
	<input type="hidden" id="queryName" name="queryName" value=""/>
	<input type="hidden" id="fusearchsql" name="fusearchsql"/>
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
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' />
  </body>
</html>
