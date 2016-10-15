<%----------------------------------------
	name: hdjk.jsp
	author: 陈泽
	version: 1.0, 2010-11-04
	description: 实时话单监控
	modify: 
		2010-11-04 youhongyu 注释
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
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title>实时话单监控</title>	
	
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
		
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	
	<style type="text/css">
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
	</style>

	<script type="text/javascript" language="javascript">
	/**
	 *页面初始化
	 * @param
	 * @return 
	 */
	$(function(){
			//显示头部菜单
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			
			$("#tabs").tabs();
			Dat = loadData("autofilefjpass",$("#lanType").val(),2);
			//Dat.setHidden(["ID"]);
						
			initialGrid();//初始化实时详单监控jqgrid
			getField();//获取显示详单面板中的输入框的id
		});
		
		var Dat = ""; 
		var users = "";
		var fields = [];
		
		
		/**
		 * 重新分拣 
		 * @param 
		 * @return 
		 */
		function anewSort(){
		
			var param = $("#hiddenparames").val();
			
			if(param == "" || param == null){
				alert("请根据查询条件对话单进行重新分拣！");
				return;
			}
			if(confirm("确定要对当前记录进行重新分拣吗？")){
				var urlstr=tsd.buildParams({ 
  								packgname:'service',//java包
						 		clsname:'ExecuteSql',//类名
						 		method:'exeSqlData',//方法名
						 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 		tsdcf:'mssql',//指向配置文件名称
						 		tsdoper:'exe',//操作类型 
						 		tsdpk:'resort.importToTemp'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				 });
				 $.ajax({
				 	url:'mainServlet.html?'+urlstr+"&params="+param,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							alert("命令执行成功！");
						}	
					}
							
				});
			}
		}
		
		/**
		 * 获取显示详单面板中的输入框的id
		 * @param name 
		 * @return 
		 */
		function getField()
		{
			var lbldom = $("#tdiv td label");
			$(lbldom).each(function(){
				var tmp = $(this).attr("for");
				tmp = tmp.replace("lb_","");
				fields.push(tmp);
			});
			return fields;
		}
		
		
		function loadResortHis(){
			var column  = '';
			var languageType = $("#languageType").val();
			var thisdata = loadData('resorttemp_his',$("#lanType").val(),1,'删除');
			thisdata.colModels[0].width = 40;
			column = thisdata.FieldName.join(',');
			$("#columnHidden").val(column);
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'reSort.loadResortHis',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'reSort.loadResortHisCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			var cols = Dat.FieldName.join(",");
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr +"&cols="+column,
				datatype: 'xml',
				colNames:thisdata.colNames,
				colModel:thisdata.colModels,
		       	rowNum:30, //默认分页行数
		       	rowList:[30,50,100], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#pagered'), 
		       	sortname: 'ID', //默认排序字段
		       	viewrecords: true,
		       	sortorder: 'asc',//默认排序方式 
		       	caption:'历史重新分拣话单信息', 
		       	height:310, //高
		        width:820,
		        loadComplete:function(){
				       		//总行数
				       		//var total = jQuery("#editgrid").jqGrid('getGridParam', 'records'); //获取查询得到的总记录数量
				       		var total = jQuery("#editgrid").getGridParam('records');
				       		if($("#editgrid tr.jqgrow[id='1']").html()==""){
				       			return false;
				       		}
							$("#editgrid").setSelection('0', true);
							$("#editgrid").focus();
							addRowOperBtnimage('editgrid','deleteResortHis','ID','click',1,"style/images/public/ltubiao_02.gif",'删除',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
							executeAddBtn('editgrid',1);
						},
				ondblClickRow: function(rowid){
				}
			}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
			); 
		}
		
		
		function reloadResortHis(){
			var column  = '';
			var languageType = $("#languageType").val();
			var thisdata = loadData('resorttemp_his',$("#lanType").val(),1,'删除');
			thisdata.colModels[0].width = 40;
			column = thisdata.FieldName.join(',');
		    var urlstr=tsd.buildParams({ 
		    	packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:'reSort.loadResortHis',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				tsdpkpagesql:'reSort.loadResortHisCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			var cols = Dat.FieldName.join(",");
		    $("#editgrid").setGridParam({
		        url:'mainServlet.html?'+urlstr +"&cols="+column
		    }).trigger("reloadGrid");
		}
		
		function deleteResortHis(billId){
			var urlstr=tsd.buildParams({ 
 								packgname:'service',//java包
					 		clsname:'ExecuteSql',//类名
					 		method:'exeSqlData',//方法名
					 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 		tsdcf:'mssql',//指向配置文件名称
					 		tsdoper:'exe',//操作类型 
					 		tsdpk:'resort.deleteResortHis'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 });
			 $.ajax({
			 	url:'mainServlet.html?'+urlstr+"&Id="+billId,
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						alert("命令执行成功！");
						reloadResortHis();
					}	
				}
						
			});
		}
		
		
		/**
		 * 初始化实时详单监控jqgrid
		 * @param
		 * @return 
		 */
		function initialGrid(){
			var thisdata = loadData('autofilefjpass',$("#lanType").val(),1,'重新分拣');
			thisdata.colModels[0].width = 65;
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'reSort.page',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'reSort.pageCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			
			var cols = Dat.FieldName.join(",");
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr +"&cols="+cols,
				datatype: 'xml', 
				colNames:thisdata.colNames, 
				colModel:thisdata.colModels, 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'passdate', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'已分拣话单文件',// 
				       	height:310, //高
				       	//width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
				       		//总行数
				       		//var total = jQuery("#editgrid").jqGrid('getGridParam', 'records'); //获取查询得到的总记录数量
				       		var total = jQuery("#editgrid").getGridParam('records');
				       		if($("#editgrid tr.jqgrow[id='1']").html()==""){
				       			return false;
				       		}
							$("#editgrid").setSelection('0', true);
							$("#editgrid").focus();
							addRowOperBtnimage('editgrid','anewSortById','XUHAO','click',1,"style/images/public/ltubiao_01.gif",'重新分拣',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
							executeAddBtn('editgrid',1);
						},
						ondblClickRow:function(idx){
						}
				}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		
	   
	   function anewSortById(id){
			if(confirm("确定要对该话单进行重新分拣吗？")){
				var urlstr=tsd.buildParams({ 
  								packgname:'service',//java包
						 		clsname:'ExecuteSql',//类名
						 		method:'exeSqlData',//方法名
						 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 		tsdcf:'mssql',//指向配置文件名称
						 		tsdoper:'exe',//操作类型 
						 		tsdpk:'resort.importToTempById'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				 });
				 $.ajax({
				 	url:'mainServlet.html?'+urlstr+"&Id="+id,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							alert("命令执行成功！");
						}	
					}
							
				});
			}
		}
	   
	   /**
		 * 弹出简单查询面板
		 * @param 无参数
		 * @return 无返回值
		 */
		function openQueryPanel(){
		    clearText('querylogforms');
		    //弹出面板
		    autoBlockForm('querylogform', 60, 'queryclose', "#ffffff", true);
		}
		
		function openQueryHisPanel(){
		    clearText('queryHisform');
		    //弹出面板
		    autoBlockForm('queryHisform', 60, 'queryhisclose', "#ffffff", true);
		}
		
		
		/**
		 * 执行查询
		 * @param 无参数
		 * @return 无返回值(执行成功)/false(IP不合法)
		 */
		function queryBill(){
		    var startId = $("#startId").val();
		    var stopId = $("#stopId").val();
		    var startdate = $("#startdate").val();
		    var stopdate = $("#stopdate").val();
		    var billName = $("#billName").val();
		    
		    var params = '';
		    params += '&startId=' + startId;
		    params += '&stopId=' + tsd.encodeURIComponent(stopId);
		    params += '&startdate=' + tsd.encodeURIComponent(startdate);
		    params += '&stopdate=' + tsd.encodeURIComponent(stopdate);
		    params += '&billName=' + tsd.encodeURIComponent(billName);
		    
		    var expparams = ' 1=1 ';
		    if (startId != '') {
		        expparams += " and xuhao>= "+startId;
		    }
		    if (stopId != '') {
		        expparams += " and xuhao<= "+stopId;
		    }
		    if (startdate != '') {
		        expparams += " and to_date(to_char(passdate,'yyyy-mm-dd'),'yyyy-mm-dd') > to_date('" + startdate + "','yyyy-mm-dd')";
		    }
		    if (stopdate != '') {
		        expparams += " and to_date(to_char(passdate,'yyyy-mm-dd'),'yyyy-mm-dd') < to_date('" + stopdate + "','yyyy-mm-dd')";
		    }
		    if (billName != '') {
		    	if(billName.indexOf("\\") >0){
		    		billName = billName.replace(/\\/g,"\\\\");
		    	}
		        expparams += " and filename like '%25" +billName+ "%25'";
		    }
		    $("#hiddenparames").val(expparams);
		    
		    var urlstr = tsd.buildParams({
		        packgname : 'service', //java包
		        clsname : 'ExecuteSql', //类名
		        method : 'exeSqlData', //方法名
		        datatype : 'xml', //返回数据格式 
		        ds : 'tsdLog', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		        tsdcf : 'mssql', //指向配置文件名称
		        tsdoper : 'query', //操作类型 
		        tsdpk : 'reSort.query', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		        tsdpkpagesql : 'reSort.queryCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		    });
		    
		    $("#editgrid").setGridParam({
		        url : 'mainServlet.html?' + urlstr + '&expparams=' + expparams
		    }).trigger("reloadGrid");
		    setTimeout($.unblockUI, 15);
		}
		
		
	/**
	 * 选项卡切换事件，用于切换时执行相应的事件
	 * @param id 选项卡的编号
	 * @return 
	 */
	var tabStatus = 0;
	function tabsChg(id){
		$("#gridd").empty();
		$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
		
		switch(id){
			case 1:			
				$("#query1").show();
				$("#batchResort").show();
				$("#query2").hide();
				initialGrid();
				$("#editgrid").trigger("reloadGrid");
				break;
			case 2:
				$("#query1").hide();
				$("#batchResort").hide();
				$("#query2").show();
				loadResortHis();
				$("#editgrid").trigger("reloadGrid");
				break;
			default:
				initialGrid();
		}
	}
	
	
	function queryHisBill(){
		var filename = $("#filename").val();
	    var addTime = $("#addTime").val();
	    
	    var params = '';
	    params += '&filename=' + tsd.encodeURIComponent(filename);
	    params += '&addTime=' + tsd.encodeURIComponent(addTime);
	    
	    var expparams = ' 1=1 ';
	    if (filename != '') {
	        expparams += " and filename like '%25" +tsd.encodeURIComponent(filename)+ "%25'";
	    }
	    if (addTime != '') {
	        expparams += " and to_date(to_char(webadddate,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('" + addTime + "','yyyy-mm-dd')";
	    }
	    var column = $("#columnHidden").val();
	    var urlstr = tsd.buildParams({
	        packgname : 'service', //java包
	        clsname : 'ExecuteSql', //类名
	        method : 'exeSqlData', //方法名
	        datatype : 'xml', //返回数据格式 
	        ds : 'tsdLog', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	        tsdcf : 'mssql', //指向配置文件名称
	        tsdoper : 'query', //操作类型 
	        tsdpk : 'reSort.queryHisBill', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	        tsdpkpagesql : 'reSort.queryHisBillCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	    });
	    
	    $("#editgrid").setGridParam({
	        url : 'mainServlet.html?'+urlstr+'&expparams='+expparams+'&cols='+column
	    }).trigger("reloadGrid");
	    setTimeout($.unblockUI, 15);
	}
	</script>

  </head>
  
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<!-- 用户操作标题以及放一些快捷按钮-->
	<div id="buttons" style="margin-bottom: 0px;hight: 50px;">
		&nbsp;&nbsp;&nbsp;
		<button type="button" id="query1" style="margin-top: 5px;" onclick="openQueryPanel()">
			查询
		</button>
		<button type="button" id="query2" style="display: none;margin-top: 5px;" onclick="openQueryHisPanel()">
			查询
		</button>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button id="batchResort"  type="button" onclick="anewSort()">
			批量重新分拣
		</button>
	</div>
	
	<!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span>已分拣话单</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span>重新分拣历史话单</span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
		
	<!-- 简单查询面板 -->
	<div class="neirong" id="querylogform" style="display: none;width:670px">
			<div class="top">
				<div class="top_01" id="thisdrag">
						<div class="top_01left">
							<div class="top_02">
								<img src="style/images/public/neibut01.gif" />
							</div>
							<div class="top_03" id="titlediv">
								<!-- 查询 -->
								<fmt:message key="logManager.query" />
							</div>
							<div class="top_04">
								<img src="style/images/public/neibut03.gif" />
							</div>
						</div>
						<div class="top_01right"><a href="#" onclick="javascript:$('#queryclose').click();">
						<!-- 关闭 -->
						<fmt:message key="logManager.close" />
						</a></div>
				</div>
				<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
			<div class="midd" >
				   <form action="#" name="querylogforms" id="querylogforms" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
						<tr>	
							<td class="labelclass">
								<label id="startIdLabel">起始序号</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="startId" style="width:180px" class="textclass"/>
							</td>
							<td class="labelclass">
								<label id="stopIdLabel">截止序号</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="stopId" class="textclass"; style="width:180px"/>
							</td>
						</tr>
						<tr>	
							<td class="labelclass">
								<label id="startTimeLabel">起始分拣时间</label>
							</td>
							<td class="tdstyle">
								<input type="text" class="textclass" style="width: 180px;" readonly="readonly" 
								name="startdate" id="startdate" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
							</td>
							<td class="labelclass">
								<label id="stopTimeLabel">截止分拣时间</label>
							</td>
							<td class="tdstyle">
								<input type="text" class="textclass" style="width: 180px;" readonly="readonly" 
								name="stopdate" id="stopdate" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
							</td>
						</tr>
						<tr>	
							<td class="labelclass">
								<label id="billNameLabel">文件名称</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="billName" style="width:180px" class="textclass"/>
							</td>
							<td class="labelclass">
								
							</td>
							<td class="tdstyle">
								
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="queryBill()">
					<fmt:message key="global.query" />
				</button>
				<button type="button" class="tsdbutton" id="queryclose" style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
			</div>
	</div>
	
	
	<!-- 简单查询面板 历史重新分拣 -->
	<div class="neirong" id="queryHisform" style="display: none;width:670px">
			<div class="top">
				<div class="top_01" id="thisdrag">
						<div class="top_01left">
							<div class="top_02">
								<img src="style/images/public/neibut01.gif" />
							</div>
							<div class="top_03" id="titlediv">
								<!-- 查询 -->
								<fmt:message key="logManager.query" />
							</div>
							<div class="top_04">
								<img src="style/images/public/neibut03.gif" />
							</div>
						</div>
						<div class="top_01right"><a href="#" onclick="javascript:$('#queryhisclose').click();">
						<!-- 关闭 -->
						<fmt:message key="logManager.close" />
						</a></div>
				</div>
				<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
			<div class="midd" >
				   <form action="#" name="querylogforms" id="querylogforms" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
						<tr>	
							<td class="labelclass">
								<label id="filenameLabel">页面名称</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="filename" class="textclass"; style="width:180px"/>
							</td>
							<td class="labelclass">
								<label id="addTimeLabel">添加时间</label>
							</td>
							<td class="tdstyle">
								<input type="text" class="textclass" style="width: 180px;" readonly="readonly" 
								name="stopdate" id="addTime" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="queryHisBill()">
					<fmt:message key="global.query" />
				</button>
				<button type="button" class="tsdbutton" id="queryhisclose" style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
			</div>
	</div>
	
	<!-- 菜单ID -->
	
	<input type="hidden" id="hiddenparames" name="hiddenparames" />
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' />
	<input type="hidden" id="columnHidden" />
  </body>
</html>
