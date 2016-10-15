<%----------------------------------------
	name: gfdetail.jsp 
	author: cz
	version: 1.0, 2011-02-26
	description: 话费汇总
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
					$(this).next().html("大客户号");
				else
					$(this).next().html("电话号码");
				$('#ghHth').select().focus();
			});
			$("#ghHth").keydown(function(event){
				if(event.keyCode==13)
				{
					ghSearch();
				}
			}).select().focus();
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
				alert("请输入待查询的大客户合同号");
				$("#ghHth").select().focus();
				return;
			}
			$("#containerDetail").html("");
			loadHths(hzyf,hthi);			
		}
		/**
			
		*/
		function loadHths(hZyf,lHth)
		{
			$("#container").html("<table id=\"maingrid\" class=\"scroll\"></table><div style=\"text-align:left\" id=\"maingridpager\" class=\"scroll\"></div>");
			var cols = "Yhmc,Hth,Hzyf,MokuaiJu";
			var cna = "帐号名称,帐户号,帐期,站别";
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
										tsdpk:'ghdhdetail.data' + $("#ghStype").val(),//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'ghdhdetail.datapage' + $("#ghStype").val()//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		
			$("#maingrid").jqGrid({
					url:'mainServlet.html?'+urlstr + "&hth=" + encodeURIComponent(lHth) + "&hzyf=" + encodeURIComponent(hZyf),
					datatype: 'xml', 
					colNames:colNames, 
					colModel:colModels, 
					       	rowNum:1000, //默认分页行数
					       	multiselect:true,
					       	rowList:[30,50,100,1000], //可选分页行数
					       	useDefault:true,
					       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
					       	pager: jQuery('#maingridpager'), 
					       	sortname: 'Yhmc', //默认排序字段
					       	viewrecords: true, 
					       	sortorder: 'desc',//默认排序方式 
					       	caption:'合同号列表',//"宽带业务流水", 
					       	height:220, //高
					       	width:document.documentElement.clientWidth-57,
					       	loadComplete:function(){
					       		$("#showDetail,#showDhDetail").removeAttr("disabled");
					       		curr_status_c = 1;
						}
					}).navGrid('#maingridpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
						{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
						{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
						{reloadAfterSubmit:false}, // del options 
						{} // search options 
						); 
		}
		
		function loadHthDetail(hZyf,hthS)
		{
			hthS = $.trim(hthS);
			if(hthS==undefined || hthS=="")
			{
				return false;
			}
			
			if(curr_status!=2 && curr_status!=0)
				curr_status = 1;
			
			$("#containerDetail").html("<table id=\"dmaingrid\" class=\"scroll\"></table><div style=\"text-align:left\" id=\"dmaingridpager\" class=\"scroll\"></div>");
			var cols = "YhdangYhmc,Dh,MoKuaiJu,Hth,HthdangYhmc,Yhxz,Hzyf,HeJi,YueZu";
			var cna = "用户名称,电话号码,模块局,合同号,合同号名称,用户性质,汇总月份,合计,月租";
			<%if(languageType=="en"){%>
				cna = cols;
			<%}%>
			var colNames = cna.split(",");
			var colModelStr = cols.split(",");
			var colModels = [];
			
			for(var i=0;i<colModelStr.length;i++)
			{
				var temp = "{name:'"+colModelStr[i]+"',index:'"+colModelStr[i]+"',width:50}";				
				colModels.push(new Function("return "+temp)());
			}
			
			var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'ghdhdetail.detail',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'ghdhdetail.detailpager'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			if(curr_status_c==0)  //如果不是第一次加载明细
			{
				$("#dmaingrid").setGridParam({caption:(curr_status==1?'账户明细':'电话明细'),url:'mainServlet.html?'+urlstr + "&hths=" + $.trim(encodeURIComponent(hthS)) + "&hzyf=" + encodeURIComponent(hZyf)+"&tablename=" + (curr_status==1?"hthhf":"huizong")}).trigger("reloadGrid");
			}
			else
			{
				$("#dmaingrid").jqGrid({
						url:'mainServlet.html?'+urlstr + "&hths=" + encodeURIComponent(hthS) + "&hzyf=" + encodeURIComponent(hZyf)+"&tablename=" + (curr_status==1?"hthhf":"huizong"),
						datatype: 'xml', 
						colNames:colNames, 
						colModel:colModels, 
						       	rowNum:1000, //默认分页行数
						       	//multiselect:true,
						       	rowList:[30,50,100,1000], //可选分页行数
						       	useDefault:true,
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#dmaingridpager'), 
						       	sortname: 'Hth', //默认排序字段
						       	viewrecords: true, 
						       	sortorder: 'desc',//默认排序方式 
						       	caption:(curr_status==1?'账户明细':'电话明细'),//"宽带业务流水", 
						       	height:220, //高
						       	width:document.documentElement.clientWidth-70,
						       	loadComplete:function(){
						       	
						       		$("#printDetail").removeAttr("disabled");
							}
						}).navGrid('#dmaingridpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							); 
			}
		}
		
		function ghDetail()
		{
			curr_status = 1;
			var hthsel = $("#maingrid").getGridParam("selarrrow");
			if(hthsel.length==0)
			{
				alert("请选择要查询明细的合同号");
				return;
			}
			var tval = [];
			for(var ii=0;ii<hthsel.length;ii++)
			{
				var tmp = $("#maingrid").getCell(hthsel[ii],"Hth");
				if(null==tmp)
				{
					alert("没有可查询的合同号");
					return;
				}
				tval.push($.trim(tmp));
			}
			loadHthDetail($("#ghZq").val(),tval.join(","));
			$("#printDetail").val("打印账户明细报表");
		}
		//电话明细 信息
		function ghDhDetail()
		{
			curr_status = 2;
			var hthsel = $("#maingrid").getGridParam("selarrrow");
			if(hthsel.length==0)
			{
				alert("请选择要查询明细的合同号");
				return;
			}
			var tval = [];
			for(var ii=0;ii<hthsel.length;ii++)
			{
				var tmp = $("#maingrid").getCell(hthsel[ii],"Hth");
				if(null==tmp)
				{
					alert("没有可查询的合同号");
					return;
				}
				tval.push($.trim(tmp));
			}
			loadHthDetail($("#ghZq").val(),tval.join(","));
			$("#printDetail").val("打印电话明细报表");
		}
		
		function ghPrintDetail()
		{
			var hthsel = $("#maingrid").getGridParam("selarrrow");
			if(hthsel.length==0)
			{
				alert("请选择要查询明细的合同号");
				return;
			}
			var tval = [];
			for(var ii=0;ii<hthsel.length;ii++)
			{
				var tmp = $("#maingrid").getCell(hthsel[ii],"Hth");
				if(null==tmp)
				{
					alert("没有可打印报表的合同号");
					return;
				}
				tval.push(tmp);
			}
			var params = "";
			params += "&hzyf=" + $("#ghZq").val() + "&hths=" + $.trim(tval.join(","));
			printThisReport1('<%=request.getParameter("imenuid")%>',
					(curr_status==2?"ghdhmx":"gfzhmx"),params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
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
		查询方式:<select id="ghStype">
			<option value="">按大客户号查询</option>
			<option value="dh">按电话号码查询</option>
		</select>
		<span>大客户号</span>：<input type="text" id="ghHth" class="inputbox" />
		<button class="tsdbutton" id="searchByHth" onclick="ghSearch()">查找</button>
		<button class="tsdbutton" id="showDetail" onclick="ghDetail()" disabled>查询账户明细</button>
		<button class="tsdbutton" id="showDhDetail" onclick="ghDhDetail()" disabled>查询电话明细</button>
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
  </body>
</html>