<%-- 
    File Name:  tariff/Set2rate.jsp
    Function:   
    Author:     chenze
    Date:       2010-10-11
    Description: 
    Modify:     youhongyu 移植 	
                2010-11-5   chenze  添加注释
                2010-11-10   尤红玉  头部注释
                2010-11-26  chenze  增加高级查询和导出数据时Blob字段转换
                2010-12-10  liwen   修改，新增，查询面板标题修改
                2010-12-15 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
                2010-12-17 youhongyu   查询有问题，输入计费网名为公网，查询不出结果.解决方法：将附有初始值的text框的值置空
                					   打开通用查询，头部无法正确显示当前批操作类型问题更正
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>

<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Definition relay Bureau to Group</title>
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
		<script type="text/javascript" src="script/public/datalength.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
			
	<style type="text/css">
		#V1,#V2,#V3,#V4{height:0px;}
		#editgrid a{font-weight:bold;}
		body{text-align:left;}
		input,select{margin-left:0px;}
		
		.textclass{width:180px;margin-left:0px;}
		
		.spanstyle{display:-moz-inline-box; display:inline-block; width:135px}
		
		.disabledStar{display:none;}
	</style>
	<script type="text/javascript">
	/**************************************
		**通过调用存储过程获取计费菜单
		-------------------------------
	**************************************/
	jQuery(document).ready(function(){
			//获取系统语言标识
			var languageType = $("#lanType").val();
			//获取本菜单id
			var imenuid = $('#imenuid').val();
			//获取组信息
			var groupid = $('#zid').val();
			//获取菜单并解析
			getTariffBar(languageType,imenuid,'set1Rate.getNavigator',groupid);
	});
	/*
	*获取当前数据库类型
	postgresql enterprisedb  oracle mssql mysql
	*/
	function decideDBType (){
		$.get('mainServlet.html',{packgname:'service',clsname:'DBService',method:'service',operate:'decideDBType',ds:'tsdBill'},function(data){
	     	return data;
	  	});
	}
	</script>
	<script type="text/javascript">
	//获取数据库类型
	var decideDBType =decideDBType();//postgresql enterprisedb  oracle mssql mysql
	var Dat = "";
	var tabStatus = 1;
	var primaryKeys = [
		["NetName","Bjzg"],
		["Call_Type","Bjzg","NetName","Cs0","Cs2","HoliDay_Type","Period_Time"],
		["Jmlx","Jmshd","Jrlx"],
		["Charge_Type","Thlx"]
	];
	//var prikeyIdx=[[1,2],[1,2,3,4,6,12,13],[1,2,3],[1,2]];	
	var tablef = ["feilu","jcfeilu","fljm","charge_type"];
	var tables = ["Feilu2","Jcfeilu2","Fljm2","Charge_Type2"];
	var pkeys = ["Rate2Feilu","Rate2Jcfeilu","Rate2Fljm","Rate2Charge_Type"];
	var fuheM = false;
	
	var colNamess = [["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"]];
	var colModels = [[],[],[],[]];
	var firstLoad = [true,true,true,true];
	var mNames = [
				"<fmt:message key='SetRate.feilu' />",
				"<fmt:message key='SetRate.jcfeilu' />",
				"<fmt:message key='SetRate.fljm' />",
				"<fmt:message key='SetRate.chargetype' />"
				];
	//用于数据格式的验证
	var regularExp = [];
	regularExp["int"] = /^\d+$/;
	regularExp["double"] = /^\d+|\d+\.\d+$/;
	//修改数据时保存原记录
	var sourceData = new Array();
	
	$(function(){
		$("#navBar").append(genNavv());
		$("#tabs").tabs();
		//取页面权限
		setUserRight();
		//取国际化信息
		getI118n();
		loadFeilu(Dat);
		
		$("#close21").click(function(){fuheM=false;});	
		//测试
		//vValid("ST7","ST7_ld");
		
		//初始化面板面板里的下拉列表
		InitialDropdownList();
		
		$("input[dtype='int'],input[dtype='double']").keyup(function(event){
			if(!/^[0-9]+(.[0-9]{2})?$/.test($(this).val()))
				$(this).val($(this).val().replace(/[^\d\.]+/g,''));
		});
	});
	
	/**
	 * 取字串长度，中文字符长度为2
	 * @param  str  将要取长度的字符串
	 * @return 字符串的升序
	 */
	function getLength(str)
	{
		var len = 0;
		for(var i=0;i<str.length;i++)
		{
			if(str.charCodeAt(i)>255)
				len += 2;
			else
				len += 1;				
		}
		return len;
	}
	/**
	 * 选项卡切换事件，用于切换时执行相应的事件
	 * @param id 选项卡的编号
	 * @return 
	 */
	function tabsChg(id)
	{
		$("#gridd").empty();
		$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
		//$("#editgrid").empty();
		$("#queryName").val("");
		$("#fusearchsql").val("");
		switch(id)
		{
			case 1:
				tabStatus=1;				
				getI118n();
				loadFeilu(Dat);
				$("#editgrid").trigger("reloadGrid");
				break;
			case 2:
				tabStatus=2;				
				getI118n();
				loadJcFeilu(Dat);
				$("#editgrid").trigger("reloadGrid");
				break;
			case 3:
				tabStatus=3;				
				getI118n();
				loadFljm(Dat);
				$("#editgrid").trigger("reloadGrid");
				break;
			case 4:
				tabStatus=4;				
				getI118n();
				loadChargeType(Dat);
				break;
			default:
				tabStatus=1;				
				getI118n();
				loadFeilu(Dat);
		}		
	}
	/**
	 * 加载费率表格
	 * @param models 当前Grid结构对象
	 * @return 
	 */
	function loadFeilu(models)
	{
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'Rate2Feilu.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'Rate2Feilu.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + '&cols=' + models.FieldName.join(","),
				datatype: 'xml', 
				colNames:models.colNames,//["<fmt:message key='global.operation' />","NetName","Bjzg","Bjdm","Jbjcm","Jbfl","Tfjcm","Tffl","Qjms","Fuf","Fjf","Fjl","Jmlx",'rowguid'], 
				colModel:models.colModels, 
		       	rowNum:10, //默认分页行数
		       	rowList:[10,15,20], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/',
		       	pager: jQuery('#pagered'), 
		       	sortname: 'NetName', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'asc',//默认排序方式 
		       	caption:"<fmt:message key='SetRate.feilu' />", 
		       	shrinkToFit: false,
		       	width:document.documentElement.clientWidth-85,
		       	height:290, //高
		       	loadComplete:function(){
								////@1  表格的id
								////@2  链接名称
								////@3  链接地址或者函数名称
								////@4  行主键列的名称 可以是隐藏列
								////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
								////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'openRowModify','NetName','click',1,'Bjzg');
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','NetName','click',2,'Bjzg');
							    /****执行行按钮添加********
								*@1 表格ID
								*@2 操作按钮数量 等于定义数量
								*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
								executeAddBtn('editgrid',2);
								}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
  /**
   * 计次费率
	 * @param  
	 * @return 
	 */
	function loadJcFeilu(models)
	{
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'Rate2Jcfeilu.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'Rate2Jcfeilu.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
									
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + '&cols=' + models.FieldName.join(","),
				datatype: 'xml', 
				colNames:models.colNames,//["<fmt:message key='global.operation' />","Call_Type","Bjzg","YhDaihao","Cs0","Cs1","Cs2","Cs3","Feilu","TfFeilu","BaseHf","Tfhf","HoliDay_Type",'Period_Time'], 
				colModel:models.colModels, 
		       	rowNum:10, //默认分页行数
		       	rowList:[10,15,20], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#pagered'), 
		       	sortname: 'Call_Type', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'asc',//默认排序方式 
		       	caption:"<fmt:message key='SetRate.jcfeilu' />", 
		       	shrinkToFit: false,
		       	width:document.documentElement.clientWidth-90,
		       	height:290, //高
		       	loadComplete:function(){
								////@1  表格的id
								////@2  链接名称
								////@3  链接地址或者函数名称
								////@4  行主键列的名称 可以是隐藏列
								////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
								////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'openRowModify','Call_Type','click',1,"Bjzg","NetName","Cs0","Cs2","HoliDay_Type","Period_Time");
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','Call_Type','click',2,"Bjzg","NetName","Cs0","Cs2","HoliDay_Type","Period_Time");
							   /****执行行按钮添加********
								*@1 表格ID
								*@2 操作按钮数量 等于定义数量
								*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
								executeAddBtn('editgrid',2);
								}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
	/**
	 * 分时段费率减免
	 * @param oper 
	 * @return 
	 */
	function loadFljm(models)
	{
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'Rate2Fljm.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'Rate2Fljm.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
									
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + '&cols=' + models.FieldName.join(","),
				datatype: 'xml', 
				colNames:models.colNames,//["<fmt:message key='global.operation' />","Jmlx","Jmshd","Jrlx","jdjbJme","jbJmbl","jdtfJme","tfJmbl","jdsxJme","sxJmbl","jdfjJme","fjJmbl","jdqtJme1","qtJmbl1","jdqtJme2","qtJmbl2","memo"], 
				colModel:models.colModels, 
		       	rowNum:10, //默认分页行数
		       	rowList:[10,15,20], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#pagered'), 
		       	sortname: 'Jmlx', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'asc',//默认排序方式 
		       	caption:"<fmt:message key='SetRate.fljm' />", 
		       	shrinkToFit: false,
		       	width:document.documentElement.clientWidth-70,
		       	height:290, //高
		       	loadComplete:function(){
								////@1  表格的id
								////@2  链接名称
								////@3  链接地址或者函数名称
								////@4  行主键列的名称 可以是隐藏列
								////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
								////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'openRowModify','Jmlx','click',1,'Jmshd','Jrlx');
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','Jmlx','click',2,'Jmshd','Jrlx');
							   /****执行行按钮添加********
								*@1 表格ID
								*@2 操作按钮数量 等于定义数量
								*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
								executeAddBtn('editgrid',2);
								
								var ids = $("#editgrid").getDataIDs();
								var holidaymapping = fetchMultiKVValue("Rate1Feilu.HoliDay_Type",6,"",["holiday_type","bz"]);
								for(var ii=0;ii<ids.length;ii++)
								{
									var sval = $("#editgrid").getCell(ids[ii],"Jrlx");
									var xval = holidaymapping[sval];
									if(xval==undefined) xval = "";
									$("#editgrid").setRowData(ids[ii],{"Jrlx":xval});
								}
						}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
	/**
	 * 计费类别费率减免
	 * @param oper 
	 * @return 
	 */
	function loadChargeType(models)
	{
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'Rate2Charge_Type.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'Rate2Charge_Type.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		var cols = 	 models.FieldName.join(",");
		//根据数据库类型 修改sql语句
		if(decideDBType=='oracle'){
			cols = cols.replace(new RegExp(',Bz,',"g"),",to_char(Bz),");
		}
									
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + '&cols=' + cols,
				datatype: 'xml', 
				colNames:models.colNames,//["<fmt:message key='global.operation' />","Charge_Type","Thlx","Bjfj","Jbfl_Jme","Jbfl_Jmbl","Tffl_Jme","Tffl_Jmbl","Fuf_Jme","Fuf_Jmbl","Fjf_Jme","Fjf_Jmbl","Bz"], 
				colModel:models.colModels, 
		       	rowNum:10, //默认分页行数
		       	rowList:[10,15,20], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#pagered'), 
		       	sortname: 'Charge_Type', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'asc',//默认排序方式 
		       	caption:"<fmt:message key='SetRate.chargetype' />", 
		       	shrinkToFit: false,
		       	width:document.documentElement.clientWidth-80,
		       	height:290, //高
		       	loadComplete:function(){								
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'openRowModify','Charge_Type','click',1,'Thlx');
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','Charge_Type','click',2,'Thlx');
							   
								executeAddBtn('editgrid',2);
					}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
	/**
	 * 取国际化信息
	 * @param 
	 * @return 
	 */
	function getI118n()
	{
		
		//alert(tabStatus-1);
		Dat = loadData(tablef[tabStatus-1],$("#languageType").val(),1,"<fmt:message key='Set2rate.modifydelete' />");	
		Dat.colModels[0].width=76;
		//alert(Dat.FieldName);
		
		var i = 0;
		if(firstLoad[tabStatus-1])
		{
			//设置别名
			var labels = $("#addform"+(tabStatus) + " label");			
			var temp = "";
			$.each(labels,function(i,n){
				//alert("#"+n+"_label_"+tabStatus);
				temp = $(n).attr("for");
				temp = temp.substring(0,temp.lastIndexOf("_"));
								
				$("#"+temp+"_label_"+tabStatus).text(Dat.getFieldAliasByFieldName(temp));				
			});
			//添加红色星号
			HighLight();
			//alert($("#NetName_label_1").text());
			firstLoad[tabStatus-1] = false;
		}		
	}
	
	/**
	 * 在primaryKeys中定义的主键字段对应的页面输入选项加星号
	 * @param
	 * @return 
	 */
	function HighLight()
	{
		$.each(primaryKeys[tabStatus-1],function(i,n){
			
			$("#"+n+"_label_" + tabStatus).parent().parent().next().append("<span style=\"color:#FF0000;\">*</span>");
		});		
	}
	
	/**
	 * 初始化添加面板里的下拉框
	 * @param
	 * @return 
	 */
	function InitialDropdownList()
	{
		//计费网名
		var netnames = fetchMultiValue("Rate1Feilu.NetName",2,"");
		
		$("#NetName_1,#NetName_2").append("<option value=\"<fmt:message key='Set2rate.choose' />\"><fmt:message key='Set2rate.choose' /></option>");
		if(netnames!=undefined && netnames[0]!=undefined)
		{
			for(var i=0;i<netnames.length;i++)
			{
				$("#NetName_1").append("<option value=\"" + netnames[i] + "\">" + netnames[i] + "</option>");
				$("#NetName_2").append("<option value=\"" + netnames[i] + "\">" + netnames[i] + "</option>");
			}
		}
		//减免类型
		var jmlx = fetchMultiArrayValue("Rate1Feilu.Jmlx",2,"");
		
		$("#Jmlx_1").append("<option value=\"\"><fmt:message key='Set2rate.choose' /></option>");
		if(jmlx[0]!=undefined && jmlx[0][0]!=undefined)
		{
			for(var i=0;i<jmlx.length;i++)
			{
				$("#Jmlx_1").append("<option value=\"" + jmlx[i][0] + "\">" + jmlx[i][1] + "</option>");
			}
		}
		//节假日类型
		var holidaytype = fetchMultiArrayValue("Rate1Feilu.HoliDay_Type",6,"");
		
		$("#Jrlx_3,#HoliDay_Type_2").append("<option value=\"<fmt:message key='Set2rate.choose' />\"><fmt:message key='Set2rate.choose' /></option>");
		if(holidaytype!=undefined && holidaytype[0]!=undefined)
		{
			for(var i=0;i<holidaytype.length;i++)
			{
				$("#Jrlx_3,#HoliDay_Type_2").append("<option value=\"" + holidaytype[i][0] + "\">" + holidaytype[i][1] + "</option>");
			}
		}
		//呼叫类型
		var calltype = fetchMultiArrayValue("Rate1Feilu.Call_Type",2,"");
		
		$("#Call_Type_2,#Thlx_4").append("<option value=\"<fmt:message key='Set2rate.choose' />\"><fmt:message key='Set2rate.choose' /></option>");
		if(calltype!=undefined && calltype[0]!=undefined)
		{
			for(var i=0;i<calltype.length;i++)
			{
				$("#Call_Type_2,#Thlx_4").append("<option value=\"" + calltype[i] + "\">" + calltype[i] + "</option>");
			}
		}
		
	}
	
	
	/**
	 * 修改时禁用主键字段输入
	 * @param
	 * @return 
	 */	
	function disablePrimary()
	{
		for(var i=0;i<primaryKeys[tabStatus-1].length;i++)
		{
			$("#"+primaryKeys[tabStatus-1][i] + "_" + tabStatus).attr("disabled","disabled");
		}
	}

	/**
	 * 恢复所有表单可用
	 * @param
	 * @return 
	 */		
	function makeAllEnabled()
	{/*
		for(i=0;i<16;i++)
		{
			$("#ST"+(i+1)).removeAttr("disabled");
			$("#ST"+prikeyIdx[tabStatus-1][i]).css("display","inline");
		}*/
		$("#addform" + tabStatus + " :input").each(function(i,n){
			$(n).removeAttr("disabled");
		});
	}

	/**
	 * 取值 用于复合修改 第二个参数决定是否给字符串值加引号 用于增加
	 * @param
	 * @return 
	 */	
	function getValue(fieldname)
	{
		var idx = $.inArray(fieldname,Dat.FieldName);
		var dType = Dat.DataType[idx];
		var vall = $("#"+fieldname+"_"+tabStatus).val();
		var res = vall;
		if(dType=='dtString')
		{
			if(typeof arguments[1]=='undefined')
				res = "'"+vall+"'";//字符串类型需用单引号引起来
			else
				res = vall;
		}
		else if(dType=='dtInteger'&&vall=='')
		{
			res = "0";
		}
		else if(dType=='dtDouble'&&vall=='')
		{
			res = "0"
		}
		return res;
	}
	

	/**
	 * 更换按钮状态 0修改  1新增   2查询
	 * @param  sta 状态 0修改  1新增   2查询
	 * @return 
	 */
	function toggleBtn(sta)
	{
		if(sta==0)
		{
			$("#addform"+tabStatus+"save").hide();
			$("#addform"+tabStatus+"exit").hide();
			$("#addform"+tabStatus+"modify").show();
			$("#addform"+tabStatus+"search").hide();
		}
		else if(sta==1)
		{
			$("#addform"+tabStatus+"save").show();
			$("#addform"+tabStatus+"exit").show();
			$("#addform"+tabStatus+"modify").hide();
			$("#addform"+tabStatus+"search").hide();
		}
		else if(sta==2)
		{
			$("#addform"+tabStatus+"save").hide();
			$("#addform"+tabStatus+"exit").hide();
			$("#addform"+tabStatus+"modify").hide();
			$("#addform"+tabStatus+"search").show();
		}
	}
	///

	/**
	 * 打开修改面板
	 * @param 
	 * @return 
	 */
	function openRowModify()
	{	
		$(".top_03").html("<fmt:message key='Set2rate.modify' />");
		if($("#editright").val()=="false")
		{
			alert("<fmt:message key='Set2rate.nomodifyright' />");
			//return false;
		}
		else
		{
			clearText("addform" + tabStatus,2);
			toggleBtn(0);
			disablePrimary();
			//生成参数串
			var params = "";
			var j = 0;
			for(j=0;j<primaryKeys[tabStatus-1].length;j++)
			{
				params += "&";
				params += primaryKeys[tabStatus-1][j];
				params += "=";
				params += tsd.encodeURIComponent(arguments[j]);
			}
			
			$("#addform"+tabStatus+"modify").data("modifystr",params);
			
			//alert(params);
			//取如参数字段对应的数据
			//var res = fetchMultiArrayValue(pkeys[tabStatus-1]+".queryByKey",2,params);
			delete sourceData;
			sourceData = new Array();
			
			var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdCDR',
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xmlattr',//返回数据格式 
				tsdpk:pkeys[tabStatus-1]+".queryByKey"
				});
			
			$.ajax({
				url:"mainServlet.html?" + urlMm + params,
				async:false,
				cache:false,
				timeout:1000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						var lables = $("#addform" + tabStatus + " label");
						//$.each(lables,function(i,n){
						for(var k=0;k<lables.length;k++)
						{
							var tmp = $(lables[k]).attr("for");
							//tmp = tmp.replace("label_" + tabStatus,"");
							tmp = tmp.substring(0,tmp.length-2);
							
							$("#" + tmp + "_" + tabStatus).val($(this).attr(tmp.toLowerCase()));
							
							sourceData[tmp] = $(this).attr(tmp.toLowerCase());
						}	
					});
				}
			});
			
			tsd.setTitle($("#input-Unit .title h3"),"<fmt:message key='global.edit' />");
			//autoBlockForm('addform',60,'FMclose',"#ffffff",true);
			autoBlockFormAndSetWH("addform"+tabStatus,60,10,"addform"+tabStatus+"Close","#FFFFFF",true,750,'auto');
		}
	}

	/**
	 * 添加保存数据
	 * @param 
	 * @return 
	 */
	function addForFeilu()
	{	
		var j=0;
		var queryStr = "";
		
		//必填字段
		for(j=0;j<primaryKeys[tabStatus-1].length;j++)
		{
			var controlBom = $("#"+primaryKeys[tabStatus-1][j]+"_"+tabStatus);
			if($(controlBom).val()=="" || $(controlBom).val()=="<fmt:message key='Set2rate.choose' />")
			{
				var tmp = "";
				tmp = $(controlBom).parent().prev().text();
				alert($.trim(tmp) + "<fmt:message key='Set2rate.canotbeempty' />");
				$(controlBom).select();
				$(controlBom).focus();
				return false;								
			}
			
			//拼接主键参数，用于验证数据是否已存在
			queryStr += "&";
			queryStr += primaryKeys[tabStatus-1][j];
			queryStr += "=";
			
			tsd.QualifiedVal=true;
			queryStr += tsd.encodeURIComponent($(controlBom).val());
			if(tsd.Qualified()==false){$(controlBom).select();$(controlBom).focus();return false;}
			
		}
		
		var res = fetchSingleValue(pkeys[tabStatus-1]+".existed",2,queryStr);
		if(parseInt(res)>0)
		{
			alert("<fmt:message key='Set2rate.recordexist' />");
			//第一个主键输入框获得焦点
			$("#"+primaryKeys[tabStatus-1][0]+"_"+tabStatus).select();
			$("#"+primaryKeys[tabStatus-1][0]+"_"+tabStatus).focus();
			return false;
		}
		//清空queryStr;
		queryStr = "";
		
		//拼接参数串
		var lables = $("#addform" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			tmp = tmp.replace("label_","");
			
			if($("#"+tmp).attr("dtype")!=undefined && $("#"+tmp).attr("dtype")!='int' && $("#"+tmp).attr("dtype")!='double')
			{
				if(!regularExp[$("#"+tmp).attr("dtype")].test($("#" + tmp).val()))
				{
					alert($.trim($(lables[k]).text()) + "<fmt:message key='Set2rate.falseform' />" + getType($("#"+tmp).attr("dtype")) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}
			}
			//如果是计费类别费率减免的备注 默认为空格
			if(tabStatus==4 && tmp=="Bz_4" && $("#" + tmp).val()=="")
			{
				$("#" + tmp).val(" ");
			}
			
			var intstr = $("#" + tmp).val();
			if( ($("#"+tmp).attr("dtype")!='int' || $("#"+tmp).attr("dtype")!='double') && intstr=="" && tmp!="Jmlx_1"){
				intstr=0;
			}
			
			queryStr += "&";
			queryStr += tmp.replace("_"+tabStatus,"");
			queryStr += "=";
			queryStr += tsd.encodeURIComponent(intstr);
			
		}
		
		var i = 0;
		var params = "";
		//日志信息
		var loginfo = "<fmt:message key='Set2rate.settworate' />";
		
		loginfo += mNames[tabStatus-1];
		loginfo += ";TableName:";
		loginfo += tables[tabStatus-1];
		loginfo += ";";
		
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		loginfo += queryStr.replace(new RegExp("&","g"),";").replace(new RegExp("=","g"),":");
		
		loginfo = tsd.encodeURIComponent(loginfo);
		
		if(tsd.Qualified()==false){return false;}
		
		//alert(params);
		
		var res = executeNoQuery(pkeys[tabStatus-1]+".add",2,queryStr);
		
		if(res=="true"||res==true)
		{
			alert("<fmt:message key='global.successful' />");
			
			writeLogInfo("","add",loginfo);
		}
		
		$("#editgrid").trigger("reloadGrid");
		clearText("addform"+tabStatus,2);
		//第一个主键输入框获得焦点
		$("#"+primaryKeys[tabStatus-1][0]+"_"+tabStatus).select();
		$("#"+primaryKeys[tabStatus-1][0]+"_"+tabStatus).focus();
		
		return true;
	}
	/**
	 * 保存退出
	 * @param 
	 * @return 
	 */
	function addForExit()
	{
		var res = addForFeilu();
		if(res) setTimeout($.unblockUI, 15);
	}
	/**
	 * 根据数据类型取中文，用于提示信息
	 * @param 
	 * @return 
	 */
	function getType(type)
	{
		if(type=="int")
		{
			return "<fmt:message key='Set2rate.integer' />";
		}
		else if(type=="double")
		{
			return "<fmt:message key='Set2rate.number' />";
		}
		if(type=="datetime")
		{
			return "<fmt:message key='Set2rate.date' />";
		}
		else
		{
			return "<fmt:message key='Set2rate.char' />";
		}
	}
	/**
	 * 修改数据
	 * @param 
	 * @return 
	 */
	function ModifyData()
	{
		
		if(!fuheM)
		{
			//alert("O:"+ObuildParams());
			//return false;
			//修改参数
			var querystr = "";
			
			//日志信息
			var loginfo = "<fmt:message key='Set2rate.settworate' />";
			
			loginfo += mNames[tabStatus-1];
			loginfo += ";TableName:";
			loginfo += tables[tabStatus-1];
			loginfo += ";";
			
			loginfo = tsd.encodeURIComponent(loginfo);
			
			//拼接参数串
			var lables = $("#addform" + tabStatus + " label");
			//$.each(lables,function(i,n){
			for(var k=0;k<lables.length;k++)
			{
				var tmp = $(lables[k]).attr("for");
								
				if($("#"+tmp).attr("dtype")!=undefined && $("#"+tmp).attr("dtype")!='int' && $("#"+tmp).attr("dtype")!='double')
				{
					if(!regularExp[$("#"+tmp).attr("dtype")].test($("#" + tmp).val()))//格式验证
					{
						alert($.trim($(lables[k]).text()) + "<fmt:message key='Set2rate.falseform' />" + getType($("#"+tmp).attr("dtype")) + ".");
						$("#"+tmp).select();
						$("#"+tmp).focus();
						return false;
					}					
				}
				
				
				var fieldname = tmp.substring(0,tmp.length-2);
				
				//如果是计费类别费率减免的备注 默认为空格
				if(tabStatus==4 && tmp=="Bz_4" && $("#" + tmp).val()=="")
				{
					$("#" + tmp).val(" ");
				}				
				
				var intstr = $("#" + tmp).val();
				if( ($("#"+tmp).attr("dtype")!='int' || $("#"+tmp).attr("dtype")!='double') && intstr=="" && tmp!="Jmlx_1"){
					intstr=0;
				}
				
				//拼参数
				querystr += "&";
				querystr += tmp.replace("_"+tabStatus,"");
				querystr += "=";
				querystr += tsd.encodeURIComponent(intstr);
			
				//记录有修改的字段
				if($("#"+tmp).val()!=sourceData[fieldname])
				{
					loginfo += fieldname;
					loginfo += ":";
					loginfo += tsd.encodeURIComponent(sourceData[fieldname]);
					loginfo += ">>>";
					loginfo += tsd.encodeURIComponent($("#"+tmp).val());
					loginfo += ";";
				}
							
			}
			
									
			var res = executeNoQuery(pkeys[tabStatus-1]+".modify",2,querystr);
			if(res=="true"||res==true)
			{
				alert("<fmt:message key='Set2rate.modifydata' />");
				
				writeLogInfo("","modify",loginfo);
			}
			setTimeout($.unblockUI, 15);//关闭面板
			$("#editgrid").trigger("reloadGrid");//重新加载数据
		}
		else
		{
			fuheModify();
		}
	}
	/**
	 * 删除数据
	 * @param 
	 * @return 
	 */
	function deleteRow()
	{
		if($("#deleteright").val()=="false")
		{
			alert("<fmt:message key='Set2rate.nodeleteright' />");
			//return false;
		}
		else
		{//生成参数串
			var params = "";
			var i = 0;
			for(i=0;i<primaryKeys[tabStatus-1].length;i++)
			{
				params += "&";
				params += primaryKeys[tabStatus-1][i];
				params += "=";
				//params += arguments[i];
				params += tsd.encodeURIComponent(arguments[i]);
			}
			//alert(params);		
			//删除
			if(confirm("<fmt:message key='Set2rate.willdeletetherecord' />"))
			{
				executeNoQuery(pkeys[tabStatus-1]+".deleteByKey",2,params);
					//记日志
					var loginfo = "<fmt:message key='Set2rate.settworate' />";
			
					loginfo += mNames[tabStatus-1];
					loginfo += ";TableName:";
					loginfo += tables[tabStatus-1];
					loginfo += ";";
					loginfo = tsd.encodeURIComponent(loginfo);
					
					params = params.replace("&","");
					params = params.replace(new RegExp("&","g"),";");
					params = params.replace(new RegExp("=","g"),":");
					
					loginfo = loginfo + params;
					
					writeLogInfo("","delete",loginfo);
					//重新加载数据
					$("#editgrid").trigger("reloadGrid");
			}
			
		}
	}
	/**
	 * 打开添加面板
	 * @param 
	 * @return 
	 */
	function openAddForm()
	{	
		$(".top_03").html("<fmt:message key='Set2rate.add' />");
		makeAllEnabled();
		toggleBtn(1);
		clearText("addform"+tabStatus,2);
				
		autoBlockFormAndSetWH("addform"+tabStatus,60,10,"addform"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		
	}
	
	/**
	 * 打开查询面板
	 * @param 
	 * @return 
	 */
	function openSearchForm()
	{	
		$(".top_03").html("<fmt:message key='Set2rate.seek' />");
		makeAllEnabled();
		toggleBtn(2);
		clearText("addform"+tabStatus,2);
		//将附有初始值的text框的值置空
		$("#addform"+tabStatus +" :text").each(function(){
			$(this).val("");
		});
		
		//隐藏星号
		$("span:contains('*')").addClass("disabledStar");
		
		$("#addform"+tabStatus+"Close").unbind("click");
		$("#addform"+tabStatus+"Close").bind("click",function(){
			$("span:contains('*')").removeClass("disabledStar");
		});
				
		autoBlockFormAndSetWH("addform"+tabStatus,60,10,"addform"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		
	}
	
	/**
	 * 打开将本查询保存问模板窗口
	 * @param key 标识操作的表，1主表，2明细表 存放在隐藏域gridinfo
	 * @return 
	 */
	function openSaveModT()
	{
		var t_name = "";
		if(tabStatus==1)
			t_name = "feilu";
		else if(tabStatus==2)
			t_name = "jcfeilu";
		else if(tabStatus==3)
			t_name="fljm";
		else
			t_name = "charge_type";
				
		openModT(t_name,'1');		
	}
	
	/**
	 * 打开查询或排序对话框
	 * @param oper 
	 * @return 
	 */
	function showDialog(oper,type)
	{
		var t_name = "";
		if(tabStatus==1)
			t_name = "feilu";
		else if(tabStatus==2)
			t_name = "jcfeilu";
		else if(tabStatus==3)
			t_name="fljm";
		else
			t_name = "charge_type";
			
			
		if(oper==0){
			openDiaO(t_name);
		}else{
			openDiaQueryG(type,t_name,'1');
		}		
		
		/***
		var page = oper==0?"order.jsp":"search.jsp";
		
		var winHW = (oper==0?"dialogWidth:610px; dialogHeight:320px;":"dialogWidth:680px; dialogHeight:580px;");
		//alert(t_name);
		//alert(oper);
		if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
			window.showModalDialog("/tsd2009/queryServlet?tablename="+t_name+"&url=/"+page,window,winHW + " center:yes; scroll:no");
	    }
	    else{
			window.showModalDialog("/tsd2009/queryServlet?tablename="+t_name+"&url=/"+page,window,winHW + " center:yes; scroll:no");
		}
		*/
	}

	/**
	 * 条件排序
	 * @param oper 
	 * @return 
	 */
	function zhOrderExe(sqlstr){
		
		var params ='&orderby='+sqlstr;	
		
		var tparam = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(tparam=='&fusearchsql='){
			tparam ='&fusearchsql=1=1';
		}			    
	 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:pkeys[tabStatus-1]+'.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:pkeys[tabStatus-1]+'.queryByOrderpage'
									});
		var link = urlstr1 + params  + "&cols=" + Dat.FieldName.join(",") + tparam;
					
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板
		 	
	}
	/**
	 * 打开查询框
	 * @param oper 
	 * @return 
	 */
	function openSearch()
	{
		$("#queryName").val("query");
		showDialog(1,'query');
	}
	/**
	 * 打开复合删除框
	 * @param oper 
	 * @return 
	 */
	function openBatchDelete()
	{
		$("#queryName").val("delete");
		showDialog(1,'delete');
	}
	/**
	 * 打开复合修改框
	 * @param oper 
	 * @return 
	 */
	function openBatchEdit()
	{
		$("#queryName").val("modify");
		showDialog(1,'modify');
	}
	/**
	 * 批量操作
	 * @param oper 
	 * @return 
	 */
	function fuheExe()
	{
		var queryName= document.getElementById("queryName").value;
		if(queryName=="delete")
		{
			fuheDel();
		}
		else if(queryName=="modify")
		{
			//fuheOpenModify();
			fuheM = true;//复合修改标志
			toggleBtn(0);
			disablePrimary();
			clearText("addform" + tabStatus,2);
			//将附有初始值的text框的值置空
			$("#addform"+tabStatus +" :text").each(function(){
				$(this).val("");
			});
						
			autoBlockFormAndSetWH("addform"+tabStatus,60,10,"addform" + tabStatus + "Close","#FFFFFF",true,750,'auto');
		}
		else
		{
			fuheQuery();
		}
	}
	
	
	/**
	 * 复合查询
	 * @param oper 
	 * @return 
	 */
	function fuheQuery()
	{
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}				
	 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:pkeys[tabStatus-1]+'.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:pkeys[tabStatus-1]+'.fuheQueryByWherepage'
									});
		
		var link = urlstr1 + params + "&cols=";
		if(tabStatus==4){
			//获取数据库类型
			if(decideDBType=='oracle'){
				link += Dat.FieldName.join(",").replace("Bz","to_char(Bz)");
			}else{
				link += Dat.FieldName.join(",");
			}
		}
		else{
			link += Dat.FieldName.join(",");
		}
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板			
	}
	/**
	 * 复合删除
	 * @param oper 
	 * @return 
	 */
	function fuheDel()
	{
		
		if(confirm("<fmt:message key='Set2rate.willdeletealldata' />"))
		{
		
	 		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
			if(params=='&fusearchsql='){
				params +='1=1';
			}
	 		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'exe',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:pkeys[tabStatus-1]+'.fuheDeleteBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  
										});
			var link='mainServlet.html?'+urlstr1+params; 
		 	$.ajax({
					url:link,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							
							var loginfo = "<fmt:message key='Set2rate.settworate' />";
			
							loginfo += mNames[tabStatus-1];
							loginfo += ";TableName:";
							loginfo += tables[tabStatus-1];
							loginfo += ";";
							loginfo += "<fmt:message key='Set2rate.condition' />:";
							loginfo = tsd.encodeURIComponent(loginfo);
					
							loginfo += $("#fusearchsql").val().replace(new RegExp("'","g"),"\"");
							writeLogInfo("","batchdelete",loginfo);
														
							alert("批量删除成功");
							setTimeout($.unblockUI, 15);
							fuheQuery();
						}	
					}
				});
		}		
	}
	
	/**
	 * 复合修改
	 * @param oper 
	 * @return 
	 */
	function fuheModify()
	{
		var queryStr = "";
		//拼接参数串
		var lables = $("#addform" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			tmp = tmp.replace("label_","");
			
			if($("#"+tmp).val()!="" && $("#"+tmp).val()!="<fmt:message key='Set2rate.choose' />")
			{
				if($("#"+tmp).attr("dtype")!=undefined && !regularExp[$("#"+tmp).attr("dtype")].test($("#" + tmp).val()))
				{
					alert($.trim($(lables[k]).text()) + "<fmt:message key='Set2rate.falseform' />" + getType($("#"+tmp).attr("dtype")) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}
				
				queryStr += ",";
				queryStr += tmp.replace("_"+tabStatus,"");
				queryStr += "=";
				
				if($("#"+tmp).attr("dtype")==undefined)
					queryStr += "'";
				
				tsd.QualifiedVal=true;	
				queryStr += tsd.encodeURIComponent($("#" + tmp).val());
				if(tsd.Qualified()==false){$("#"+tmp).select();$("#"+tmp).focus();return false;}
				
				if($("#"+tmp).attr("dtype")==undefined)
					queryStr += "'";
				
			}
		}
		//去第一个逗号
		queryStr = queryStr.replace(",","");
		
		var params = "&modifySet=";
		params += 'set '
		params += queryStr;
		
		tsd.QualifiedVal=true;	
		params += '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());
		if(tsd.Qualified()==false){return false;}
		
		
		 //if(params==false){return false;}			
		 var urlstr=tsd.buildParams({ packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'exe',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:pkeys[tabStatus-1]+'.fuheModifyBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									});
	 	urlstr+=params;
		//key=$("#Zjjx").val();
		//var urlstr='mainServlet.html?packgname=service&clsname=Procedure&ds=mssql&method=exequery&tsdpname=procedureDome.modify&tsdExeType=exe'+params; 
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(msg){
				if(msg=="true"){//日志
					var loginfo = "<fmt:message key='Set2rate.settworate' />";			
					loginfo += mNames[tabStatus-1];
					loginfo += ";TableName:";
					loginfo += tables[tabStatus-1];
					loginfo += ";";
					
					loginfo = tsd.encodeURIComponent(loginfo);
					
					loginfo += queryStr;
					loginfo += tsd.encodeURIComponent(";<fmt:message key='Set2rate.condition' />:");
					loginfo += $("#fusearchsql").val();
					loginfo = loginfo.replace(new RegExp("'","g"),"\"");
					
					writeLogInfo("","batchmodify",loginfo);
					
					alert("<fmt:message key='Set2rate.updatesucess' />");
					setTimeout($.unblockUI, 15);
					fuheQuery();
				}	
			}
		});
		fuheM = false;//复合修改标志
	}
	/**
	 * 设置用户权限
	 * @param oper 
	 * @return 
	 */
	function setUserRight()
	{
		//alert($("#skrid").val()+":"+$("#imenuid").val()+":"+$("#zid").val());
		var allRi = fetchMultiPValue("set1Rate.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			return false;
		}
		if(allRi[0][0]=="all")
		{
			return true;
		}
		var addright = "false";
		var delBright = "false";
		var editBright = "false";
		
		var deleteright = "false";
		var editright = "false";
		
		var exportright = "false";
		var printright = "false";
		
		var queryright = "false";
		var saveQueryMright = "false";
				
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'add','')=="true")
				addright = "true";
			if(getCaption(allRi[i][0],'delB','')=="true")							
				delBright = "true"; 
			if(getCaption(allRi[i][0],'editB','')=="true")
				editBright = "true" ;
			if(getCaption(allRi[i][0],'delete','')=="true")
				deleteright = "true";
			if(getCaption(allRi[i][0],'edit','')=="true")							
				editright = "true";
			if(getCaption(allRi[i][0],'export','')=="true")
				exportright = "true" ;
			if(getCaption(allRi[i][0],'print','')=="true")
				printright = "true";
				
			if(getCaption(allRi[i][0],'query','')=="true")
				printright = "true";
				
			if(getCaption(allRi[i][0],'saveQueryM','')=="true")
				saveQueryMright = "true";
		}
		//alert(addright+":"+delBright+":"+editBright);
		$("#addright").val(addright);
		$("#delBright").val(delBright);
		$("#editBright").val(editBright);
		if(addright=="false")
		{
			$("#openadd1").attr("disabled","disabled");
			$("#openadd2").attr("disabled","disabled");
		}
		if(delBright=="false")
		{
			$("#opendel1").attr("disabled","disabled");
			$("#opendel2").attr("disabled","disabled");
		}
		if(editBright=="false")
		{
			$("#openmod1").attr("disabled","disabled");
			$("#openmod2").attr("disabled","disabled");
		}
		
		$("#editright").val(editright);
		$("#deleteright").val(deleteright);
		
		$("#exportright").val(exportright);
		$("#printright").val(printright);
		if(exportright=="false")
		{
			$("#export1").attr("disabled","disabled");
			$("#export2").attr("disabled","disabled");
		}
		if(printright=="false")
		{
			$("#print1").attr("disabled","disabled");
			$("#print2").attr("disabled","disabled");
		}
		
		if(queryright="false")
		{
			
			$("#gjcx1").attr("disabled","disabled");
			$("#gjcx2").attr("disabled","disabled");
		}
		
		
		if(saveQueryMright="false")
		{
			
			$("#savequery1").attr("disabled","disabled");
			$("#savequery2").attr("disabled","disabled");
		}
		//alert(editright+":"+deleteright+":"+exportright);
	}
	
	
	/**
	 * 导出文件
	 * @param oper 
	 * @return 
	 */
	function DownFile()
	{
	/**
		var urlstr=tsd.buildParams({ packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'datafileDown',//返回数据格式 
										  tsdpk:'main.Export'
										});
		var param = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
			if(param=='&fusearchsql='){
				param +='1=1';
			}
		param += "&cols=";
		param += Dat.FieldName.join(",");
		param += "&table=";
		param += tables[tabStatus-1];
		
		if($("#download").size()==0)
			$("body").append("<iframe id='download' name='download' width='0' height='0'></iframe>");
		$("#download").attr("src","mainServlet.html?"+urlstr+param);
		*/
		
		thisDownLoad('tsdBilling','mssql',tablef[tabStatus-1],$("#lanType").val(),5);
	}
	
	/**
	 * 导出文件相关
	 * @param 
	 * @return 
	 */
	function DownSure()
	{
		getTheCheckedFields('tsdCDR','mssql',tables[tabStatus-1],tablef[tabStatus-1]);
	}
	
	/**
	 * 数据导出
	 * @param 
	 * @return 
	 */
	function getTheCheckedFields(ds,tsdcf,table,table2,flagfield){
		var thename=document.getElementsByName('thefields');  					
		var thevalue = '';
		var theclos = '';
		var atable = table;
		if(table2!=undefined){
			atable = table2;
		}
		var arr = displayFields(atable);
		
		var limitarr = thename.length;
		//如果字段较多则只取前20个
		var limitflag = false;
		var disi = 0;
		for(var i = 0 ; i < limitarr;i++){
			if(thename[i].checked==true){
		    	disi++;
		    }
		}
		if(disi>20){
			limitarr = 20;
			limitflag = true;
		}
		
		for(var i=0;i<limitarr;i++){
			if(thename[i].checked==true){
				theclos += arr[i] + ',';
			}
		}
		theclos = theclos.substring(0,theclos.lastIndexOf(','));
		
		if(tabStatus==4){
			//根据数据库类型 修改sql语句
			if(decideDBType=='oracle'){
				theclos = theclos.replace("Bz","to_char(Bz)");
			}			
		}
		
		/**
		var keys_ = 0;
		if(limitflag==true){
			var myDate = new Date(); 
			keys_ = myDate.getTime();//时间的唯一性
			var theclos_ = '';
			for(var i=0;i<thename.length;i++){
			    if(thename[i].checked==true){
			     	theclos_ += arr[i].replace(/\'/g,'"') + ',';//将'号替换为双引号
			    }
			}
			theclos_ = theclos_.substring(0,theclos_.lastIndexOf(','));
			
			addExportField(theclos_,keys_);//加入数据到临时表
		}
		*/
		//dataDownload('tsdBilling','mssql',theclos,'sys_user');
		
		thisDataDownload(ds,tsdcf,theclos,table,flagfield,limitflag);
		
		//将面板关闭
		setTimeout($.unblockUI, 15);
	}
	
	/**
	 * 打印报表
	 * @param 
	 * @return 
	 */
	function printR()
	{
		var params = ''+$("#fusearchsql").val();			
		if(params==''){
			params ='1=1';
		}
		printThisReport1('<%=request.getParameter("imenuid")%>',tables[tabStatus-1],'&fusearchsql='+encodeURIComponent(cjkEncode($.trim(params))),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>')
	}
	
	/**
	 * 保存本次高级查询方法
	 * @param 
	 * @return 
	 */
	function addQuery(){
		saveModQuery(tabStatus);
	}
	
	/**
	 * 模板查询
	 * @param 
	 * @return 
	 */
	function modQuery(){
		 openQueryM(tabStatus);
	}
	
	/**
	 * 简单查询
	 * @param 
	 * @return 
	 */
	function SimpleSearch()
	{
		var queryStr = "";
		//拼接参数串
		var lables = $("#addform" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			tmp = tmp.replace("label_","");
			
			if($("#"+tmp).val()!="" && $("#"+tmp).val()!="<fmt:message key='Set2rate.choose' />")
			{
				if($("#"+tmp).attr("dtype")!=undefined && !regularExp[$("#"+tmp).attr("dtype")].test($("#" + tmp).val()))
				{
					alert($.trim($(lables[k]).text()) + "<fmt:message key='Set2rate.falseform' />" + getType($("#"+tmp).attr("dtype")) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}
				
				queryStr += " and ";
				queryStr += tmp.replace("_"+tabStatus,"");
				
				if($("#"+tmp).attr("dtype")==undefined)
					queryStr += " like ";
				else
					queryStr += " = ";				
				
				if($("#"+tmp).attr("dtype")==undefined)
					queryStr += "'%";
				
				tsd.QualifiedVal=true;	
				queryStr += $("#" + tmp).val();
				if(tsd.Qualified()==false){$("#"+tmp).select();$("#"+tmp).focus();return false;}
				
				if($("#"+tmp).attr("dtype")==undefined)
					queryStr += "%'";
				
			}
		}
		//去第一个逗号
		queryStr = queryStr.replace("and","");
		
		//alert(queryStr);
		
		$("#fusearchsql").val(queryStr);
		
		fuheQuery();
		
		$("span:contains('*')").removeClass("disabledStar");
	}
	</script>
</head>

<body> 
<form name="childform" id="childform">
	<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
</form>

<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 

<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
<!-- 语言 -->
<input type="hidden" id="lanType" name="lanType" value='<%=lanType %>' />

<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
<input type="hidden" name="languageType" id="languageType" value='<%=lanType %>' />
  	<div id="navBar">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		:		
	</div>
  	<br />
  	<!-- 资费设置导航条-->
	<div id='tariffBar' style="font-size: 14px; text-align: left;">
	</div>
  	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder1" onclick="showDialog(0)">
			<!--排序--><fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd1" onclick="openAddForm()">
			<!--添加--><fmt:message key="global.add" />
	    </button>
	    <button type="button" onclick="openSearchForm()">
			<!--查询-->
			<fmt:message key="global.query" />
		</button>
		<button onclick='modQuery()' id='mbquery1'>
				<fmt:message key="oper.mod"/>
		</button>
	   <button type="button" id="gjcx1" onclick="openSearch()">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id='savequery1' onclick="openSaveModT()">
				<fmt:message key="oper.modSave"/>
		</button>
		 <button type="button" id="opendel1" onclick="openBatchDelete()">
			<!--批量删除--><fmt:message key="tariff.deleteb" />
		</button>
		 <button type="button" id="openmod1" onclick="openBatchEdit()">
			<!--批量修改--><fmt:message key="tariff.modifyb" />
		</button>
		<button type="button" id="export1" onclick="DownFile()"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>	
		<!--打印				
		<button type="button" id="print1" onclick="printR()">
			<fmt:message key="tariff.printer" />
		</button> 
		-->  
	</div>
	<!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key='SetRate.feilu' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key='SetRate.jcfeilu' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(3)"><span><fmt:message key='SetRate.fljm' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(4)"><span><fmt:message key='SetRate.chargetype' /></span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	

	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder2" onclick="showDialog(0)">
			<!--排序--><fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd2" onclick="openAddForm()">
			<!--添加--><fmt:message key="global.add" />
	    </button>
	    <button type="button" onclick="openSearchForm()">
			<!--查询-->
			<fmt:message key="global.query" />
		</button> 
		<button onclick='modQuery()' id='mbquery2'>
				<fmt:message key="oper.mod"/>
		</button>
	   <button type="button" id="gjcx2" onclick="openSearch()">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id='savequery2' onclick="openSaveModT()">
				<fmt:message key="oper.modSave"/>
		</button>
		 <button type="button" id="opendel2" onclick="openBatchDelete()">
			<!--批量删除--><fmt:message key="tariff.deleteb" />
		</button>
		 <button type="button" id="openmod2" onclick="openBatchEdit()">
			<!--批量修改--><fmt:message key="tariff.modifyb" />
		</button>
		<button type="button" id="export2" onclick="DownFile()"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>	
		<!--打印				
		<button type="button" id="print2" onclick="printR()">
			<fmt:message key="tariff.printer" />
		</button>
		-->
	</div>
	
	
	<!-- Number 1 一 -->
	<form class="neirong" id="addform1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="Set2rate.settworate&ratetable" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#addform1Close').click();"><fmt:message key="Set2rate.close" /></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%" >
						<label for="NetName_1"><!-- 计费网名 -->
							<span id="NetName_label_1"></span>
						</label>
					</td>
					<td width="34%" class="tabinputclass">
						<select name="NetName_1" id="NetName_1" class="textclass" ></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Bjzg_1"><!-- 被叫字冠 -->
							<span id="Bjzg_label_1"></span>
						</label>
					</td>
					<td width="34%" class="tabinputclass">
						<input type="text" name="Bjzg_1" id="Bjzg_1" class="textclass"></input>						
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Bjdm_1"><!-- 被叫地名 -->
							<span id="Bjdm_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Bjdm_1" id="Bjdm_1" class="textclass" ></input>
					</td>
					<td class="labelclass">
						<label for="Jbjcm_1"><!-- 基本计次秒 -->
							<span id="Jbjcm_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Jbjcm_1" id="Jbjcm_1" class="textclass" dtype="int" value="60"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Jbfl_1"><!-- 基本费率 -->
							<span id="Jbfl_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Jbfl_1" id="Jbfl_1" class="textclass" dtype="double" value="0"></input>
					</td>
					<td class="labelclass">
						<label for="Tfjcm_1"><!-- 特服计次秒 -->
							<span id="Tfjcm_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Tfjcm_1" id="Tfjcm_1" class="textclass" dtype="int" value="60"></input>					
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Tffl_1"><!-- 特服费率 -->
							<span id="Tffl_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Tffl_1" id="Tffl_1" class="textclass" dtype="double" value="0"></input>
					</td>
					<td class="labelclass">	
						<label for="Qjms_1"><!-- 强计秒数 -->
							<span id="Qjms_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Qjms_1" id="Qjms_1" class="textclass" dtype="int" value="3"></input>				
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Fuf_1"><!-- 服务费 -->
							<span id="Fuf_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Fuf_1" id="Fuf_1" class="textclass" dtype="double" value="0"></input>
					</td>
					<td class="labelclass">
						<label for="Fjf_1"><!-- 附加费 -->
							<span id="Fjf_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Fjf_1" id="Fjf_1" class="textclass" dtype="double" value="0"></input>						
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Fjl_1"><!-- 附加率 -->
							<span id="Fjl_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Fjl_1" id="Fjl_1" class="textclass" dtype="double" value="0"  ></input>
					</td>
					<td class="labelclass">
						<label for="Jmlx_1"><!-- 减免类型 -->
							<span id="Jmlx_label_1"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<select name="Jmlx_1" id="Jmlx_1" class="textclass" ></select>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="addform1save" onclick="addForFeilu()">
				<fmt:message key="Set2rate.saveadd" />
			</button>
			<button type="button" class="tsdbutton" id="addform1exit" onclick="addForExit()">
				<fmt:message key="Set2rate.saveexit" />
			</button>
			<button type="button" class="tsdbutton" id="addform1modify" onclick="ModifyData()">
				<fmt:message key="Set2rate.modify" />
			</button>
			<button type="button" class="tsdbutton" id="addform1search" onclick="SimpleSearch()">
				<fmt:message key='Set2rate.seek' />
			</button>
			<button type="button" class="tsdbutton" id="addform1Close">
				<fmt:message key="Set2rate.close" />
			</button>
		</div>
	</form>
	
	<!-- Number 2 二 -->
	<form class="neirong" id="addform2" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="Set2rate.settworate&secondratetable" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#addform2Close').click();"><fmt:message key="Set2rate.close" /></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%">
						<label for="BaseHf_2">
							<!-- 基础话费 -->
							<span id="BaseHf_label_2"></span>
						</label>
					</td>
					<td width="34%" class="tabinputclass">
						<input type="text" name="BaseHf_2" id="BaseHf_2" class="textclass" dtype="double"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Bjzg_2">
							<!-- 被叫字冠 -->
							<span id="Bjzg_label_2"></span>
						</label>
					</td>
					<td width="34%" class="tabinputclass">
						<input type="text" name="Bjzg_2" id="Bjzg_2" class="textclass"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Call_Type_2">
							<!-- 呼叫类型 -->
							<span id="Call_Type_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<select name="Call_Type_2" id="Call_Type_2" class="textclass"></select>
					</td>
					<td class="labelclass">
						<label for="Cs0_2">
							<!-- 基本次数下限 -->
							<span id="Cs0_label_2"></span>
						</label>
					<td class="tabinputclass">
						<input type="text" name="Cs0_2" id="Cs0_2" class="textclass" dtype="int" value="0"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Cs1_2">
							<!-- 基本次数上限 -->
							<span id="Cs1_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Cs1_2" id="Cs1_2" class="textclass" dtype="int" value="0"></input>
					</td>
					<td class="labelclass">	
						<label for="Cs2_2">
							<!-- 特服次数下限 -->
							<span id="Cs2_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Cs2_2" id="Cs2_2" class="textclass" dtype="int" value="0"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Cs3_2">
							<!-- 特服次数上限 -->
							<span id="Cs3_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Cs3_2" id="Cs3_2" class="textclass" dtype="int" value="0"></input>
					</td>
					<td class="labelclass">
						<label for="Feilu_2">
							<!-- 基本费率 -->
							<span id="Feilu_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Feilu_2" id="Feilu_2" class="textclass" dtype="double" value="0"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="HoliDay_Type_2">
							<!-- 节假日类型 -->
							<span id="HoliDay_Type_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<select name="HoliDay_Type_2" id="HoliDay_Type_2"
							 class="textclass"></select>
					</td>
					<td class="labelclass">
						<label for="Period_Time_2">
							<!-- 时段 -->
							<span id="Period_Time_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Period_Time_2" id="Period_Time_2"
							 class="textclass"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="TfFeilu_2">
							<!-- 特服费率 -->
							<span id="TfFeilu_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="TfFeilu_2" id="TfFeilu_2"
							 class="textclass" dtype="double"></input>
					</td>
					<td class="labelclass">
						<label for="Tfhf_2">
							<!-- 特服话费 -->
							<span id="Tfhf_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Tfhf_2" id="Tfhf_2"  class="textclass" dtype="double" value="0"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="YhDaihao_2">
							<!-- 优惠代号 -->
							<span id="YhDaihao_label_2"></span><span id="ST13_lf"
								style="display: none;"></span><span id="ST13_ld"
								style="display: none;"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="YhDaihao_2" id="YhDaihao_2" class="textclass"></input>
					</td>
					<td class="labelclass">
						<label for="NetName_2">
							<!-- 计费网名 -->
							<span id="NetName_label_2"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<select name="NetName_2" id="NetName_2" class="textclass" ></select>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="addform2save" onclick="addForFeilu()">
				<fmt:message key="Set2rate.saveadd" />
			</button>
			<button type="button" class="tsdbutton" id="addform2exit" onclick="addForExit()">
				<fmt:message key="Set2rate.saveexit" />
			</button>
			<button type="button" class="tsdbutton" id="addform2modify" onclick="ModifyData()">
				<fmt:message key="Set2rate.modify" />
			</button>
			<button type="button" class="tsdbutton" id="addform2search" onclick="SimpleSearch()">
				<fmt:message key='Set2rate.seek' />
			</button>
			<button type="button" class="tsdbutton" id="addform2Close">
				<fmt:message key="Set2rate.close" />
			</button>
		</div>
	</form>
	
	
	<!-- Number 3 三 -->
	<form class="neirong" id="addform3" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="Set2rate.settworate&timeratereduce" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#addform3Close').click();"><fmt:message key="Set2rate.close" /></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="25%">
						<label for="Jmlx_3"><!-- 减免类型 -->
							<span id="Jmlx_label_3"></span>
						</label>
					</td>
					<td width="25%" class="tabinputclass">
						<input type="text" name="Jmlx_3" id="Jmlx_3"  class="textclass" ></input>
					</td>
					<td class="labelclass" width="25%">
						<label for="Jmshd_3"><!-- 减免时段 -->
							<span id="Jmshd_label_3"></span>
						</label>
					</td>
					<td width="25%" class="tabinputclass">
						<input type="text" name="Jmshd_3" id="Jmshd_3"  class="textclass"></input>
					</td>						
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Jrlx_3"><!-- 节日类型 -->
							<span id="Jrlx_label_3"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<select name="Jrlx_3" id="Jrlx_3"  class="textclass"></select>
					</td>
					<td class="labelclass">
						<label for="jdjbJme_3"> <!-- 基本费率减免额 -->
							<span id="jdjbJme_label_3"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="jdjbJme_3" id="jdjbJme_3"  class="textclass" dtype="double" value="0"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="jbJmbl_3"><!-- 基本费率减免比率 -->
							<span id="jbJmbl_label_3"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="jbJmbl_3" id="jbJmbl_3" class="textclass" dtype="double" value="0"></input>
					</td>
					<td class="labelclass">	
						<label for="jdtfJme_3"><!-- 特服费率减免额 -->
							<span id="jdtfJme_label_3"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="jdtfJme_3" id="jdtfJme_3"  class="textclass" dtype="double" value="0"></input>
					</td>					
				</tr>
				<tr>
					<td class="labelclass">
						<label for="tfJmbl_3"><!-- 特服费率减免比率 -->
							<span id="tfJmbl_label_3"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="tfJmbl_3" id="tfJmbl_3" class="textclass" dtype="double" value="0"></input>	
					</td>
					<td class="labelclass">	
						<label for="jdfjJme_3"><!-- 附加费减免额 -->
							<span id="jdfjJme_label_3"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="jdfjJme_3" id="jdfjJme_3"  class="textclass" dtype="double" value="0"></input>	
					</td>			
				</tr>
				<tr>
					<td class="labelclass">
						<label for="fjJmbl_3"><!-- 附加费率减免比率 -->
							<span id="fjJmbl_label_3"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="fjJmbl_3" id="fjJmbl_3"  class="textclass" dtype="double" value="0"></input>
					</td>
					<td class="labelclass">
						<label for="memo_3"><!-- 备注 -->
							<span id="memo_label_3"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="memo_3" id="memo_3"  class="textclass"></input>	
					</td>					
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="addform3save" onclick="addForFeilu()">
				<fmt:message key="Set2rate.saveadd" />
			</button>
			<button type="button" class="tsdbutton" id="addform3exit" onclick="addForExit()">
				<fmt:message key="Set2rate.saveexit" />
			</button>
			<button type="button" class="tsdbutton" id="addform3modify" onclick="ModifyData()">
				<fmt:message key="Set2rate.modify" />
			</button>
			<button type="button" class="tsdbutton" id="addform3search" onclick="SimpleSearch()">
				<fmt:message key='Set2rate.seek' />
			</button>
			<button type="button" class="tsdbutton" id="addform3Close">
				<fmt:message key="Set2rate.close" />
			</button>
		</div>
	</form>
	
	<!-- Number 4 四 -->
	<form class="neirong" id="addform4" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="Set2rate.settworate&feetype" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#addform4Close').click();"><fmt:message key="Set2rate.close" /></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="25%">
						<label for="Charge_Type_4"><!-- 计费类别 -->
							<span id="Charge_Type_label_4"></span>
						</label>
					</td>
					<td width="25%" class="tabinputclass">
						<input type="text" name="Charge_Type_4" id="Charge_Type_4"  class="textclass" maxlength="2" ></input>
					</td>
					<td class="labelclass" width="25%">
						<label for="Thlx_4"><!-- 呼叫类型 -->
							<span id="Thlx_label_4"></span>
						</label>
					</td>
					<td width="25%" class="tabinputclass">
						<select name="Thlx_4" id="Thlx_4"  class="textclass" ></select>	
					</td>					
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Bjfj_4"><!-- 被叫附加 -->
							<span id="Bjfj_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Bjfj_4" id="Bjfj_4"  class="textclass" ></input>
					</td>
					<td class="labelclass">
						<label for="Jbfl_Jme_4"><!-- 基本费率减免额 -->
							<span id="Jbfl_Jme_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Jbfl_Jme_4" id="Jbfl_Jme_4"  class="textclass"  dtype="double" value="0"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Jbfl_Jmbl_4"><!-- 基本费率减免比率 -->
							<span id="Jbfl_Jmbl_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Jbfl_Jmbl_4" id="Jbfl_Jmbl_4" class="textclass" dtype="double" value="0"></input>
					</td>
					<td class="labelclass">	
						<label for="Tffl_Jme_4"><!-- 特服费率减免额 -->
							<span id="Tffl_Jme_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Tffl_Jme_4" id="Tffl_Jme_4"  class="textclass"  dtype="double" value="0"></input>		
					</td>			
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Tffl_Jmbl_4"><!-- 特服费率减免比率 -->
							<span id="Tffl_Jmbl_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Tffl_Jmbl_4" id="Tffl_Jmbl_4" class="textclass" dtype="double" value="0"></input>	
					</td>
					<td class="labelclass">	
						<label for="Fuf_Jme_4"><!-- 服务费减免额 -->
							<span id="Fuf_Jme_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Fuf_Jme_4" id="Fuf_Jme_4"  class="textclass"  dtype="double" value="0"></input>	
					</td>			
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Fuf_Jmbl_4"><!-- 服务费减免比率 -->
							<span id="Fuf_Jmbl_label_4"></span><span id="ST9_lf" style="display:none;"></span><span id="ST9_ld" style="display:none;"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Fuf_Jmbl_4" id="Fuf_Jmbl_4"  class="textclass"  dtype="double" value="0"></input>
					</td>
					<td class="labelclass">
						<label for="Fjf_Jme_4"><!-- 附加费减免额 -->
							<span id="Fjf_Jme_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Fjf_Jme_4" id="Fjf_Jme_4"  class="textclass"  dtype="double" value="0"></input>
					</td>						
				</tr>
				<tr>
					<td class="labelclass">
						<label for="Fjf_Jmbl_4"><!-- 附加费减免比率 -->
							<span id="Fjf_Jmbl_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Fjf_Jmbl_4" id="Fjf_Jmbl_4" class="textclass"  dtype="double" value="0"></input>	
					</td>
					<td class="labelclass">
						<label for="Bz_4"><!-- 备注 -->
							<span id="Bz_label_4"></span>
						</label>
					</td>
					<td class="tabinputclass">
						<input type="text" name="Bz_4" id="Bz_4"  class="textclass" ></input>
					</td>		
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="addform4save" onclick="addForFeilu()">
				<fmt:message key="Set2rate.saveadd" />
			</button>
			<button type="button" class="tsdbutton" id="addform4exit" onclick="addForExit()">
				<fmt:message key="Set2rate.saveexit" />
			</button>
			<button type="button" class="tsdbutton" id="addform4modify" onclick="ModifyData()">
				<fmt:message key="Set2rate.modify" />
			</button>
			<button type="button" class="tsdbutton" id="addform4search" onclick="SimpleSearch()">
				<fmt:message key='Set2rate.seek' />
			</button>
			<button type="button" class="tsdbutton" id="addform4Close">
				<fmt:message key="Set2rate.close" />
			</button>
		</div>
	</form>
	

	
	
	<!-- 添加模板面板 -->
	<div id="modT" name='modT' style="display: none"  class="neirong">
		<br/>
		<div class="top">
		<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" ><fmt:message key="Set2rate.functionname" /></div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
			</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
			<div class="midd" >
			<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
				
				  	<tr >
					    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
					    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
					    	<input type="text" name="name_mod" id="name_mod" onkeyup="this.value=replaceStrsql(this.value,80)" class="textclass"/>
					    	<font style="color: #ff0000;">*</font></td>
					    
					    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
					    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
										    
					     <td width="12%" align="right"  class="labelclass"></td>
				    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
				    	
				 	 </tr>	
			  
				</table>
			</form>	
			<div class="midd_butt">
			<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="addQuery()" ><fmt:message key="global.save" /></button>
		 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod()" ><fmt:message key="global.close" /></button>
			</div>	
		</div>
	</div>
	
	<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:800px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv"><fmt:message key="Set2rate.chooseexportdata" /></div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="Set2rate.close" /></a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			   <form action="#" onsubmit="return false;">
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
		<div class="midd_butt">
			<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
				<fmt:message key="Set2rate.selectall" />
			</button>
			<button type="submit" class="tsdbutton" id="query" onclick="DownSure()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>
			
		</div>
	</div>	
	
	<!-- 查询树信息存放 -->
	<input type="hidden" id='treepid' />	
	<input type="hidden" id='treecid' />	
	<input type="hidden" id='treestr' />	
	<input type="hidden" id='treepic' />	
	
	<!-- 高级查询 模板隐藏域 -->
	<input type="hidden" id="queryright"/>
	<input type="hidden" id="queryMright"/>
	<input type="hidden" id="saveQueryMright"/>		
	
	<input type="hidden" id="useridd" value="<%=session.getAttribute("userid") %>"/>
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=session.getAttribute("languageType") %>' />
	
	<input type="hidden" id="addright" />
	<input type="hidden" id="deleteright" />
	<input type="hidden" id="editright" />
	<input type="hidden" id="delBright" />
	<input type="hidden" id="editBright" />
	<input type="hidden" id="exportright" />
	<input type="hidden" id="printright" />
	
	<input type="hidden" id="queryright" />
	<input type="hidden" id="saveQueryMright" />
	<input type="hidden" id="successful" value="<fmt:message key='global.successful' />"/>
</body>
</html>
