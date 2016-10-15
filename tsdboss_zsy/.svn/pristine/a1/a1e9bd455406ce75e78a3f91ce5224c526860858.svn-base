<%----------------------------------------
	name: gfdetail.jsp 
	author: cz
	version: 1.0, 2011-04-26
	description: 话费月收入汇总
	modify: 
		2011-03-28  cz  添加报表
			
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
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title>公费电话明细打印</title>
	
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
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
		
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
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 菜单样式 -->
		<link rel="stylesheet" href="style/css/telephone/usermanagement/single_thirteen.css" type="text/css" />
		<script language="javascript">
		/**
		 * 初始化
		 * @param 无参数
		 * @return 无返回值
		 */
		$(function(){
			$("#navBar").append(genNavv());
			gobackInNavbar("navBar");
			fetchHzyf();			
			loadHths("0000","110101");
			
			$("#ghZq").change(function(){
				$("#ghHth").select().focus();
			});
			$("#ghStype").change(function(){
				if($(this).val()=="")
					$(this).next().next().html("大客户号");
				else
					$(this).next().next().html("电话号码");
				$('#ghHth').select().focus();
			});
			$("#ghHth").keydown(function(event){
				if(event.keyCode==13)
				{
					ghSearch();
				}
			}).select().focus();
			
			var res = fetchMultiArrayValue("ReportParam.stationswithflag",6,"");
			if(res[0]!=undefined && res[0][0]!=undefined)
			{
				var optHtml = "<option value=\"%\">全部</option>";
				for(var ii=0;ii<res.length;ii++)
				{
					optHtml = optHtml + "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
				}
				$("#station").html(optHtml);
			}
			setUserRight();
		});
		
		var curr_status = 0;  //区域账号明细秋电话明细
		var curr_status_c = 0; //区分是否第一次加载明细表
		
		function fetchHzyf()
		{
			var res = fetchMultiValue("ghdhdetail.hzyf",6,"");
			var optHtml = "";
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml += "<option value=\"" + res[ii] + "\">" + res[ii] + "</option>";
			}
			$("#ghZq").html(optHtml);
			var curhzyf = fetchSingleValue("ghdhdetail.nowmonth",6,"");
			if(curhzyf!="")
			{
				$("#ghZq").val(curhzyf);
			}
		}
		
		function ghSearch()
		{
			$("#printDetail").attr("disabled","disabled");
			var hzyf = $("#ghZq").val();
			var hthi = $("#ghHth").val();
			if(hthi=="")
			{
				/*alert("请输入待查询的大客户合同号");
				$("#ghHth").select().focus();
				return;*/
				hthi = "%";
			}
			$("#containerDetail").html("");
			loadHths(hzyf,hthi);			
		}
		/**
		 * 调用过程生成临时数据
		 */
		function procedureGfMxData(hZyf,lHth,Tablename)
		{
			var res = fetchMultiPValue("ghdhdetail.se",6,"&hzyf=" + encodeURIComponent(hZyf) + "&hths=" + encodeURIComponent(lHth) + "&userid=" + encodeURIComponent($("#skrid").val()) + "&tablename=" + Tablename);
			
		}
		/**
			
		*/
		function loadHths(hZyf,lHth)
		{
			$("#container").html("<table id=\"maingrid\" class=\"scroll\"></table><div style=\"text-align:left\" id=\"maingridpager\" class=\"scroll\"></div>");
			var cols = "area,yhxz,dhsl,heji,yz,xyw,zxf,tcf,yhf,hf1,hf2,hf3,hf4,hf5,hf6,hf7,hf8,hf9,hf10,hf11,gnct,gjct,ipct,zxct,f168,kdf,zdf,qtf";
			var cna = "通信站,用户性质,电话数量,总费用,月租费,套餐费,优惠费,新业务费,油田区内,油田区间,电信区内,电信区间,移动费,联通费,网通区内,网通区间,铁通区内,铁通区间,ip市话费,国内长途,国际长途,ip长途,专网长途,专线费,168信息,其它信息,宽带费,窄带费";
			<%if(languageType=="en"){%>
				cna = cols;
			<%}%>
			var colNames = cna.split(",");
			var colModelStr = cols.split(",");
			var colModels = [];
			
			for(var i=0;i<colModelStr.length;i++)
			{
				var temp = "{name:'"+colModelStr[i]+"',index:'"+colModelStr[i]+"',width:62}";				
				colModels.push(new Function("return "+temp)());
			}
			
			var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式
										tsdpk:'jfysr.data',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'jfysr.datacount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		
			$("#maingrid").jqGrid({
					url:'mainServlet.html?'+urlstr + "&hth=" + encodeURIComponent(lHth) + "&hzyf=" + encodeURIComponent(hZyf) + "&area=" + encodeURIComponent($("#station").val()),
					datatype: 'xml', 
					colNames:colNames, 
					colModel:colModels, 
					       	rowNum:100, //默认分页行数
					       	//multiselect:true,
					       	rowList:[30,50,100,1000], //可选分页行数
					       	useDefault:true,
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
					       	pager: jQuery('#maingridpager'), 
					       	sortname: $("#yhlb").val(), //默认排序字段
					       	viewrecords: true, 
					       	sortorder: 'asc',//默认排序方式 
					       	caption:'计费月收入汇总',//"宽带业务流水", 
					       	height:290, //高
					       	//width:document.documentElement.clientWidth-57,
					       	loadComplete:function(){
					       		if($("#maingrid tr.jqgrow[id='1']").html()!="")
					       			$("#printDetail").removeAttr("disabled");
						}
					}).navGrid('#maingridpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
						); 
		}
		
		
		function ghPrintDetail()
		{
			
			var params = "";
			params += "&hzyf=" + $("#ghZq").val()+"&userid=" + encodeURIComponent($("#skrid").val()) + "&area=" + cjkEncode($("#station").val());
			printThisReport1('<%=request.getParameter("imenuid")%>',
					("jfyhz" + $("#yhlb").val()),params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
		}
		
		///设置权限
		function setUserRight()
		{
			var allRi = fetchMultiPValue("Duty.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
			if(typeof allRi == 'undefined' || allRi.length == 0)
			{
				//alert("取权限失败");
				$("#ableForOtherArea").val("false");
				var area = $("#area").val();
				
				$("#station").val(area);
				$("#station").attr("disabled","disabled");
				return false;
			}
			if(allRi[0][0]=="all")
			{
				$("#ableForOtherArea").val('true');	
				return true;
			}
			var ableForOtherArea = "false";
			
			for(var i = 0;i<allRi.length;i++){
				if(getCaption(allRi[i][0],'ableForOtherArea','')=="true")
					ableForOtherArea = 'true';	
			}
			/*if(ableForOtherArea=="true")
				$("#tj_way_st").css("display","inline");
			*/	
			if(ableForOtherArea=="true")
			{
				
			}
			else
			{
				var area = $("#area").val();
				
				$("#station").val(area);
				$("#station").attr("disabled","disabled");
			}
			$("#ableForOtherArea").val(ableForOtherArea);
		}
		</script>
		<style type="text/css">
		.tsdbutton{margin:2px;padding:2px 10px 2px 10px;height:24px;}
		.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/imgs/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
		.inputbox{{margin-left:10px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
			
		</style>
  </head>
  
  <body>
	
	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
		账期：<select id="ghZq"><option>账期</option></select>
		
		<select id="station" name="station">
		</select>
		<select id="yhlb" name="yhlb">
			<option value="area">按站别显示</option>
			<option value="yhxz">按用户性质显示</option>
		</select>
		
		<button class="tsdbutton" id="searchByHth" onclick="ghSearch()">查找</button>
		<button class="tsdbutton" id="printDetail" onclick="ghPrintDetail()" disabled>打印报表</button>
	<br />
	<div id="container">
		<table id="maingrid" class="scroll"></table>
		<table id="maingridpager" class="scroll"></table>
	</div>
	
	<div id="containerDetail">
		<table id="bmaingrid" class="scroll"></table>
		<table id="bmaingridpager" class="scroll"></table>
	</div>
	
	<input type="hidden" name="skrid" id="skrid" value="<%=session.getAttribute("userid") %>"/>
  	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
  	
  	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType%>' />
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
	
	<input type="hidden" id="ableForOtherArea" name="ableForOtherArea" value="false" />
  </body>
</html>