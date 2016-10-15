
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%----------------------------------------
	name: userLogQ.jsp
	author: youhongyu
	version: 1.0, 2009-11-26
	description: 对此文件的描述
	modify: 
		2010-01-18 youhongyu 更改导出模块 
		2010-01-20 youhongyu 更改grid样式 grid字段可控 验证方法
---------------------------------------------%>
<%@page import="com.tsd.service.util.Log" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>User Profile Log Query</title>
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
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		
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
	<style type="text/css">
	#V1,#V2,#V3,#V4{height:0px;}
	#editgrid a{font-weight:bold;}
	</style>
	
<script type="text/javascript">
			/**
			 * 查看当前用户的扩展权限，对spower字段进行解析
			 * @param 无参数
			 * @return 无返回值
			 */
function getUserPower(){
	 var urlstr=tsd.buildParams({ 	  packgname:'service',
				 					  clsname:'Procedure',
									  method:'exequery',
				 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
				 					  tsdpname:'userLogQ.getPower',//存储过程的映射名称
				 					  tsdExeType:'query',
				 					  datatype:'xmlattr'
			 					});
	/************************
	*   调用存储过程需要的参数 *
	**********************/
	var userid = $('#useridd').val();	
	var groupid = $('#zid').val();
	var imenuid = $('#imenuid').val();
	
	/****************
	*   拼接权限参数 *
	**************/
	
	var addright = '';
	var delBright = '';
	var editBright = '';
	
	var deleteright = '';
	var editright = '';
	var editfields = '';
	
	var exportright = '';
	var printright ='';
	
	var queryright = '';				
	var queryMright = '';
	var saveQueryMright ='';
		
	var flag = false;
	
	var spower = '';
	
	var str = 'true';
	
	$.ajax({
			url:'mainServlet.html?'+urlstr+'&userid='+userid+'&groupid='+groupid+'&menuid='+imenuid,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				$(xml).find('row').each(function(){
						spower += $(this).attr("spower")+'@';
				});
			}
	});
	if(spower!=''&&spower!='all@'){
			var spowerarr = spower.split('@');
									
			for(var i = 0;i<spowerarr.length-1;i++){
				addright += getCaption(spowerarr[i],'add','')+'|';
				delBright += getCaption(spowerarr[i],'delB','')+'|';
				editBright += getCaption(spowerarr[i],'editB','')+'|';	
				deleteright += getCaption(spowerarr[i],'delete','')+'|';
				editright += getCaption(spowerarr[i],'edit','')+'|';	
				editfields += getCaption(spowerarr[i],'editfields','');
				exportright += getCaption(spowerarr[i],'export','')+'|';
				printright += getCaption(spowerarr[i],'print','')+'|';
				
				
				queryright += getCaption(spowerarr[i],'query','')+'|';
				queryMright += getCaption(spowerarr[i],'queryM','')+'|';
				saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
	
			}
	}else if(spower=='all@'){
			$("#addright").val(str);
			$("#delBright").val(str);
			$("#editBright").val(str);
			
			$("#deleteright").val(str);
			$("#editright").val(str);
			
			$("#exportright").val(str);
			$("#printright").val(str);
			
			$("#queryright").val(str);						
			$("#queryMright").val(str);
			$("#saveQueryMright").val(str);
						
			//var languageType = $("#languageType").val();
			//editfields = getFields('Tbl_CardNo');
			
			flag = true;
	}
	
	if(flag==false){
		var hasadd = addright.split('|');
		var hasdelB = delBright.split('|');
		var haseditB = editBright.split('|');
		var hasdelete = deleteright.split('|');
		var hasedit = editright.split('|');
		var hasexport = exportright.split('|');
		var hasprint = printright.split('|');
		
		
			var hasquery = queryright.split('|');
			var hasqueryM = queryMright.split('|');
			var hassaveQueryM = saveQueryMright.split('|');
			
			for(var i = 0;i<hasquery.length;i++){
				if(hasquery[i]=='true'){
					$("#queryright").val(str);
					break;
				}
			}					
			for(var i = 0;i<hasqueryM.length;i++){
				if(hasqueryM[i]=='true'){
					$("#queryMright").val(str);
					break;
				}
			}					
			for(var i = 0;i<hassaveQueryM.length;i++){
				if(hassaveQueryM[i]=='true'){
					$("#saveQueryMright").val(str);
					break;
				}
			}
			
		for(var i = 0;i<hasadd.length;i++){
			if(hasadd[i]=='true'){
				$("#addright").val(str);
				break;
			}
		}
		for(var i = 0;i<hasdelB.length;i++){
			if(hasdelB[i]=='true'){
				$("#delBright").val(str);
				break;
			}
		}
		for(var i = 0;i<haseditB.length;i++){
			if(haseditB[i]=='true'){
				$("#editBright").val(str);
				break;
			}
		}
		for(var i = 0;i<hasdelete.length;i++){
			if(hasdelete[i]=='true'){
				$("#deleteright").val(str);
				break;
			}
		}
		for(var i = 0;i<hasedit.length;i++){
			if(hasedit[i]=='true'){
				$("#editright").val(str);
				break;
			}
		}					
		for(var i = 0;i<hasexport.length;i++){
			if(hasexport[i]=='true'){
				$("#exportright").val(str);
				break;
			}
		}					
		for(var i = 0;i<hasprint.length;i++){
			if(hasprint[i]=='true'){
				$("#printright").val(str);
				break;
			}
		}	
					
						
	}
	$("#editfields").val(editfields);
}
</script>
<script type="text/javascript">



	var tabStatus = 1;
	var primaryKeys = [
		["dh"],
		["hth"],
		["Hth","FeeCode"],
		["id"]
	];
	
	var prikeyIdx=[[1],[1],[1,2],[1]];
	var tables = ["yhdang_old","hthdang_old","attachfee_old","qhyt_bytc_detail_old"];
	var pkeys = ["Yhdangold","Hthdangold","AttachFeeold","bytcdetailold"];
	var fuheM = false;
	var colNamess = [["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"]];
	var colModels = [[],[],[],[]];
	var firstLoad = [true,true,true,true];
	var mNames = [
				"<fmt:message key='userLogQ.Yhdangold' />",
				"<fmt:message key='userLogQ.Hthdangold' />",
				"<fmt:message key='userLogQ.AttachFeeold' />",
				"<fmt:message key='userLogQ.bytcdetailold' />"
				];
			/**
			 * 标题修改
			 * @param 无参数
			 * @return 无返回值
			 */
	$(function(){
			//导航条信息
			$("#navBar").append(genNavv());
			//分项卡初始化
			$("#tabs").tabs();
			ready1();		
		
			//用户权限判定，初始化用户可操作权限 
			getUserPower();			
			var exportright = $("#exportright").val();
			var printright = $("#printright").val();			
			var queryright = $("#queryright").val();			
			var saveQueryMright = $("#saveQueryMright").val();
			
			if(queryright=="true"){
				document.getElementById("gjquery1").disabled=false;
				document.getElementById("gjquery2").disabled=false;
			}		
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
			}			
			if(exportright=="true"){
				document.getElementById("export1").disabled=false;
				document.getElementById("export2").disabled=false;
			}
			if(printright=="true"){
				//document.getElementById("print1").disabled=false;
				//document.getElementById("print2").disabled=false;
			}
				
	});
			/**
			 * 向页面中写jgride标签
			 * @param id
			 * @return 无返回值
			 */
	function tabsChg(id)
	{
		$("#gridd").empty();
		$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
		$("#editgrid").empty();
		$("#fusearchsql").val("");
		switch(id)
		{
			case 1:
				tabStatus=1;
				//电话档案日志表
				ready1();
				//$("#editgrid").trigger("reloadGrid");
				break;
			case 2:
				tabStatus=2;
				//合同号档案日志表
				ready2();
				//$("#editgrid").trigger("reloadGrid");
				break;
			case 3:
				tabStatus=3;
				//电话月杂费日志表
				ready3();
				//$("#editgrid").trigger("reloadGrid");
				break;
			case 4:			
				tabStatus=4;
				//开通套餐日志报表
				ready4();
				break;
			default:
				tabStatus=1;				
				//getI18n();
				//电话档案日志表
				ready1();
		}		
	}
			/**
			 * 获取jgride需要显示的字段
			 * @param tablename
			 * @return String二维数组
			 */
	function getGridNameModel(tablename){
			 
			//对jgGrid的操作符进行国际化
			var opr = $("#operation").val();
			
			//获取数据表对应字段国际化信息
			var languageType = $("#languageType").val();
			var gridA =[[],[],[]];
			var colNames=[];
			var colModels=[];
			var temp='';
			var strarr = getI18nNoLan(languageType,tablename);
			
			// 生成grid 标题  colModels 存放grid colModel信息 colNames 存放grid colName信息
			//temp = "{name:'viewOperation',index:'viewOperation',width:120}";
			//colModels.push(eval("(" + temp + ")"));
			colNames=strarr[1];
			gridA[2]=strarr[0];
			//colNames.unshift(opr);
			
			//生成操作列name,index信息
			for(i=0;i<strarr[0].length;i++){
				temp = "{name:'"+ strarr[0][i] + "',index:'" + strarr[0][i] + "',width:80}";
				colModels.push(eval("(" + temp + ")"));
			}
			gridA[0]=colNames;
			gridA[1]=colModels;
			$("#cols").val(strarr[0]);
			return gridA;
	}
			/**
			 * ready1 电话档案日志表
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready1()
	{
		var cloumn  = '';
		var thisdata = loadData('yhdang_old','<%=languageType %>',2);	
		cloumn = thisdata.FieldName.join(',');	
		//$("#thecloumn").val(cloumn);
		//$("#cols").val(cloumn);
		var col=[[],[]];
		col=getRb_Field('yhdang_old','dh',"<fmt:message key='userLogQ.detail' />",'70','ziduansF');//得到jqGrid要显示的字段
		var column = $("#ziduansF").val();
		
		var OperTimeg = thisdata.getFieldAliasByFieldName('OperTime');
		var Dhg = thisdata.getFieldAliasByFieldName('Dh');
		var Yhmcg = thisdata.getFieldAliasByFieldName('Yhmc');
		var Yhdzg = thisdata.getFieldAliasByFieldName('Yhdz');
		$("#OperTimeg_a").html(OperTimeg);
		$("#Dhg_a").html(Dhg);
		$("#Yhmcg_a").html(Yhmcg);
		$("#Yhdzg_a").html(Yhdzg);		
		
		var urlstr=buildParamsSql('query','xml','Yhdangold.query','Yhdangold.querypage');		
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+ "&column="+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1],//gridA[1]
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'dh', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userLogQ.Yhdangold' />", 
				       	height:260, //高
				       	///width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
									
										//addRowOperBtn('editgrid',"<fmt:message key='global.edit' />",'openRowModify','rowguid','click',1);
										//addRowOperBtn('editgrid',"<fmt:message key='global.delete' />",'deleteRow','rowguid','click',2);
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										addRowOperBtnimage('editgrid','openRowInfo','dh','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userLogQ.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid',1);
									
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var rowguid =$("#editgrid").getCell(ids,"rowguid");
													openRowInfo(rowguid);
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
			 * 显示详细信息
			 * @param key
			 * @return 无返回值
			 */
function openRowInfo(key){
		//获取表别名，生成展示table
		var fieldA= getLoadP('<%=languageType %>',tables[tabStatus-1]);
		var $tr_1='';
		for(i=0;i<fieldA[0].length;i++){
			if(i%3==0){
				$tr_1 += " <tr> <td width='12%' align='right' class='labelclass'><label id='"+fieldA[0][i]+"g' >"+fieldA[1][i]+"</label></td><td width='22%' align='left' style='border-bottom:1px solid #A9C8D9;'><input type='text' name='"+fieldA[0][i]+"' id='"+fieldA[0][i]+"' disabled='disabled' class='textclass2'></input></td>";
				if(i==fieldA[0].length-1){
					$tr_1 += " <td width='12%' align='right' class='labelclass'></td><td width='22%' align='left' style='border-bottom:1px solid #A9C8D9;'></td>";
				 	$tr_1 += " <td width='12%' align='right' class='labelclass'></td><td width='20%' align='left' style='border-bottom:1px solid #A9C8D9;'></td>";
				 }
			}
			else if(i%3==1){
				$tr_1 += " <td width='12%' align='right' class='labelclass'><label id='"+fieldA[0][i]+"g' >"+fieldA[1][i]+"</label></td><td width='22%' align='left' style='border-bottom:1px solid #A9C8D9;'><input type='text' name='"+fieldA[0][i]+"' id='"+fieldA[0][i]+"' disabled='disabled' class='textclass2'></input></td>";
				if(i==fieldA[0].length-1){
					$tr_1 += " <td width='12%' align='right' class='labelclass'></td><td width='20%' align='left' style='border-bottom:1px solid #A9C8D9;'></td>";
				}
			}
			else if(i%3==2){
				 $tr_1 += " <td width='12%' align='right' class='labelclass'><label id='"+fieldA[0][i]+"g' >"+fieldA[1][i]+"</label></td><td width='22%' align='left' style='border-bottom:1px solid #A9C8D9;'><input type='text' name='"+fieldA[0][i]+"' id='"+fieldA[0][i]+"' disabled='disabled' class='textclass2'></input></td>";
			}
		}
		$("#perinfo tbody").html($tr_1);	
			
		openpan();			
		//设置编辑框的标题		
		$(".top_03").html("<fmt:message key='userLogQ.detailmessage' />");//标题	 	
		queryByID(key,fieldA[0]);
		
}
		
			/**
			 * 取出一条数据显示在修改面板中
			 * @param key
			 * @param key2
			 * @return 无返回值
			 */
function queryByID(key,key1){ 
		var urlstr=tsd.buildParams({  
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdcf:'mssql',//指向配置文件名称
							  tsdoper:'query',//操作类型 
							  datatype:'xmlattr',//返回数据格式 
							  tsdpk:'userLogQ'+tabStatus+'.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							});	
			//tables[tabStatus]
			switch(tabStatus){
				case 1:
					urlstr +="&rowguid="+key;
					break;
				case 2:
					urlstr +="&rowguid="+key;
					break;
				case 3:
					urlstr +="&ID="+key;
					break;
				case 4:
					urlstr +="&id="+key;
					break;			
			}
			
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
				$(xml).find('row').each(function(){
				
					//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
					///如果sql语句中指定列名 则按指定名称给参数
					for(var i=0;i<key1.length;i++){
						var ZjjxZu = $(this).attr(key1[i].toLowerCase());							
						$("#"+key1[i]).val(ZjjxZu);
					}					
					
				});
			}
		});
}
			/**
			 * ready2  计次费率 合同号档案日志表
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready2()
	{
		var cloumn  = '';
		var thisdata = loadData('Hthdang_old','<%=languageType %>',2);	
		cloumn = thisdata.FieldName.join(',');	
		//$("#thecloumn").val(cloumn);
		//$("#cols").val(cloumn);
		
		var col=[[],[]];
		col=getRb_Field('hthdang_old','hth',"<fmt:message key='userLogQ.detail' />",'70','ziduansF');;//得到jqGrid要显示的字段
		var column = $("#ziduansF").val();
		
		var OperTimeg = thisdata.getFieldAliasByFieldName('OperTime');
		var Dhg = thisdata.getFieldAliasByFieldName('Dh');
		var Yhmcg = thisdata.getFieldAliasByFieldName('Yhmc');
		var Yhdzg = thisdata.getFieldAliasByFieldName('Yhdz');
		$("#OperTimeg_b").html(OperTimeg);
		$("#Dhg_b").html(Dhg);
		$("#Yhmcg_b").html(Yhmcg);
		$("#Yhdzg_b").html(Yhdzg);	
		/***************
		var gridA = getGridNameModel("Hthdang_old");		
		var colsStr	= $("#cols").val();	
		$("#121").val(colsStr);
		$("#122").val(gridA[0]);
		*************/		
		var urlstr=buildParamsSql('query','xml','Hthdangold.query','Hthdangold.querypage');
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1],
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'hth', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userLogQ.Hthdangold' />", 
				       	height:260, //高
				      //width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
										//addRowOperBtn('editgrid',"<fmt:message key='global.edit' />",'openRowModify','rowguid','click',1);
										//addRowOperBtn('editgrid',"<fmt:message key='global.delete' />",'deleteRow','rowguid','click',2);
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										addRowOperBtnimage('editgrid','openRowInfo','hth','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userLogQ.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid',1);
										}
										,
										ondblClickRow: function(ids) {
												if(ids != null) {
													var rowguid =$("#editgrid").getCell(ids,"rowguid");
													openRowInfo(rowguid);
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
			 * ready3 计费类别费率减免
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready3()
	{
		var cloumn  = '';
		var thisdata = loadData('attachfee_old','<%=languageType %>',2);	
		cloumn = thisdata.FieldName.join(',');	
		$("#thecloumn").val(cloumn);
		$("#cols").val(cloumn);
		
		var col=[[],[]];
		col=getRb_Field('attachfee_old','ID',"<fmt:message key='userLogQ.detail' />",'70','ziduansF');;//得到jqGrid要显示的字段
		var column = $("#ziduansF").val();
		
		var OperTimeg = thisdata.getFieldAliasByFieldName('OperTime');
		var Dhg = thisdata.getFieldAliasByFieldName('Dh');
		
		$("#OperTimeg_c").html(OperTimeg);
		$("#Dhg_c").html(Dhg);			
		
		var urlstr=buildParamsSql('query','xml','AttachFeeold.query','AttachFeeold.querypage');	
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1],
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname:'ID', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userLogQ.AttachFeeold' />", 
				       	height:260, //高
				       	//width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
										//addRowOperBtn('editgrid',"<fmt:message key='global.edit' />",'openRowModify','ID','click',1);
										//addRowOperBtn('editgrid',"<fmt:message key='global.delete' />",'deleteRow','ID','click',2);
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										addRowOperBtnimage('editgrid','openRowInfo','ID','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userLogQ.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid',1);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var ID =$("#editgrid").getCell(ids,"ID");
													openRowInfo(ID);
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
			 * ready4开通套餐日志报表
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready4() 
	{	
		var cloumn  = '';
		var thisdata = loadData('qhyt_bytc_detail_old','<%=languageType %>',2);	
		cloumn = thisdata.FieldName.join(',');	
		//$("#thecloumn").val(cloumn);
		//$("#cols").val(cloumn);
		var col=[[],[]];
		col=getRb_Field('qhyt_bytc_detail_old','id',"<fmt:message key='userLogQ.detail' />",'70','ziduansF');;//得到jqGrid要显示的字段
		var column = $("#ziduansF").val();
		
		var Opendateg = thisdata.getFieldAliasByFieldName('Opendate');
		var dhg = thisdata.getFieldAliasByFieldName('dh');
	
		$("#Opendateg_d").html(Opendateg);
		$("#dhg_d").html(dhg);			

		var urlstr=buildParamsSql('query','xml','bytcdetailold.query','bytcdetailold.querypage');
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1],
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'id', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userLogQ.bytcdetailold' />", 
				       	height:260, //高
				       	width:document.documentElement.clientWidth+100,
				       	loadComplete:function(){
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
										//addRowOperBtn('editgrid',"<fmt:message key='global.edit' />",'openRowModify','id','click',1);
										//addRowOperBtn('editgrid',"<fmt:message key='global.delete' />",'deleteRow','id','click',2);
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										addRowOperBtnimage('editgrid','openRowInfo','id','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userLogQ.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid',1);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var id =$("#editgrid").getCell(ids,"id");
													openRowInfo(id);
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
			 * 批操作
			 * @param 无参数
			 * @return 无返回值
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
			disablePrimary(1);
			openAddForm();
		}
		else
		{
			fuheQuery();
		}
	}
			/**
			 * 重新加载jQuery
			 * @param key
			 * @return 无返回值
			 */
function querylist(key){
				//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
				$("#fusearchsql").val("");		
		
				//var colsStr = $("#cols").val();
				var urlstr=buildParamsSql('query','xml',pkeys[tabStatus-1]+'.queryByWhere',pkeys[tabStatus-1]+'.queryByWherepage');
				var link='';
				var column = $("#ziduansF").val();
				
				link = urlstr+'&column='+column;
			 	setTimeout($.unblockUI, 15);//关闭面板
				$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");				
}
			/**
			 * 复合查询
			 * @param 无参数
			 * @return 无返回值
			 */
	function fuheQuery()
	{
		var colsStr = $("#cols").val();
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:pkeys[tabStatus-1]+'.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:pkeys[tabStatus-1]+'.fuheQueryByWherepage'
									});
	
		var link = urlstr1 + params;
		var column = $("#ziduansF").val();	
		
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板			
	}
			/**
			 * 条件排序
			 * @param sqlstr
			 * @return 无返回值
			 */
	function zhOrderExe(sqlstr){
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}
		params =params+'&orderby='+sqlstr;				    
	 	//var colsStr = $("#cols").val();		 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:pkeys[tabStatus-1]+'.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:pkeys[tabStatus-1]+'.queryByOrderpage'
									});
		var link = urlstr1 + params;	
		var column = $("#ziduansF").val();	
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板
		 	
	}
			/**
			 * 打开查询面板
			 * @param 无参数
			 * @return 无返回值
			 */
	function openSearch()
	{
		$("#queryName").val("query");
		showDialog(1);
	}
	
			/**
			 * 打开批量删除面板
			 * @param 无参数
			 * @return 无返回值
			 */
	function openBatchDelete()
	{
		$("#queryName").val("delete");
		showDialog(1);
	}
			/**
			 * 打开批量修改面板
			 * @param 无参数
			 * @return 无返回值
			 */
	function openBatchEdit()
	{
		$("#queryName").val("modify");
		showDialog(1);
	}
			/**
			 * 打开对话框
			 * @param oper
			 * @return 无返回值
			 */
function showDialog(oper)
{
	var t_name = "";
	if(tabStatus==1)
		t_name = "yhdang_old";
	else if(tabStatus==2)
		t_name = "hthdang_old";
	else if(tabStatus==3)
		t_name="attachfee_old";
	else
		t_name = "qhyt_bytc_detail_old";
		
	//通过oper判断是查询还是排序，控制打开窗口的方式
	if(oper==0)openDiaO(t_name);
	else openDiaQ('query',t_name);		
}
 			/**
			 * 打开查询面板
			 * @param 无参数
			 * @return 无返回值
			 */
 function openQuery1(){ 		
		tsd.setTitle($("#input-Unit .title h3"),'<fmt:message key="global.query" />');		
		clearText('operform'+tabStatus);
		hideError();//隐藏错误信息
		//autoBlockForm('operform'+tabStatus,60,'close'+tabStatus,"#ffffff",false);//弹出查询面板
		autoBlockFormAndSetWH('operform'+tabStatus,60,60,'close'+tabStatus,"#ffffff",false,'750','');//弹出查询面板
					
 }
			/**
			 * 打开查询面板
			 * @param 无参数
			 * @return 无返回值
			 */
function openQuery(){		
	 	$(".top_03").html('<fmt:message key="global.query" />');//标题		 	
	 	hideError();//隐藏错误信息	
	 	openQueryT();
		$('#jdquery'+tabStatus).show();
		clearText('queryform'+tabStatus);
}
</script>
<script type="text/javascript">
/*
添加，修改 表格样式调整涉及方法
*/
			/**
			 * 关闭表格面板
			 * @param 无参数
			 * @return 无返回值
			 */
function closeo(){		
		clearText('operformT1');
		setTimeout($.unblockUI, 15);//关闭面板
}
			/**
			 * 打开表格面板
			 * @param 无参数
			 * @return 无返回值
			 */
function openpan(){		
		autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板		
}
			/**
			 * 关闭表格面板
			 * @param 无参数
			 * @return 无返回值
			 */
function closeoQuery(){			
		setTimeout($.unblockUI, 15);//关闭面板
}
			/**
			 * 打开表格面板
			 * @param 无参数
			 * @return 无返回值
			 */
function openQueryT(){		
		autoBlockFormAndSetWH('queryT'+tabStatus,60,5,'closeoquery'+tabStatus,"#ffffff",true,1000,'');//弹出查询面板
		
}
</script>
<script type="text/javascript">
 			/**
			 * 通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 			   @oper 操作类型 modify|save
			 * @param 无参数
			 * @return 无返回值
			 */
 function QbuildParams(){
    switch(tabStatus){
   		case 1:   				
   				var OperTime = $("#OperTime_a").val();	
			 	var Dh = delTrim($("#Dh_a").val());
			 	var Yhmc = delTrim($("#Yhmc_a").val());
			 	var Yhdz = delTrim($("#Yhdz_a").val());			 	
			 				 	
				var paramsStr='1=1 ';
			 	if(OperTime!=''){
			 	 	paramsStr+="and convert(varchar(12),OperTime,121) like '%"+OperTime+"%' ";
			 	}
			 	if(Dh!=''){
			 		paramsStr+="and Dh like '%"+Dh+"%' " ;
			 	}
			 	if(Yhmc!=''){
			 		paramsStr+="and Yhmc like '%"+Yhmc+"%' " ;
			 	}		 	
			 	if(Yhdz!=''){
			 		paramsStr+="and Yhdz like '%"+Yhdz+"%' " ;
			 	}
			 	$("#fusearchsql").val(paramsStr);
			
			 	fuheQuery();			
				break;
		case 2:				
				var OperTime = $("#OperTime_b").val();	
			 	var Dh = delTrim($("#Dh_b").val());
			 	var Yhmc = delTrim($("#Yhmc_b").val());
			 	var Yhdz = delTrim($("#Yhdz_b").val());		 		
			 				 		
		 		var paramsStr='1=1 ';
			 	if(OperTime!=''){
			 	 	paramsStr+="and convert(varchar(12),OperTime,121) like '%"+OperTime+"%' ";
			 	}
			 	if(Dh!=''){
			 		paramsStr+="and Dh like '%"+Dh+"%' " ;
			 	}
			 	if(Yhmc!=''){
			 		paramsStr+="and Yhmc like '%"+Yhmc+"%' " ;
			 	}		 	
			 	if(Yhdz!=''){
			 		paramsStr+="and Yhdz like '%"+Yhdz+"%' " ;
			 	}
			 	$("#fusearchsql").val(paramsStr);
			 	
			 	fuheQuery();			
				break;
		case 3:
   				var OperTime = $("#OperTime_c").val();	
			 	var Dh = delTrim($("#Dh_c").val());	 		
			 	
			 	var paramsStr='1=1 ';
			 	if(OperTime!=''){
			 	 	paramsStr+="and convert(varchar(12),OperTime,121) like '%"+OperTime+"%' ";
			 	}
			 	if(Dh!=''){
			 		paramsStr+="and Dh like '%"+Dh+"%' " ;
			 	}
			 	
			 	$("#fusearchsql").val(paramsStr);
			 	fuheQuery();
				break;
		case 4:
				var Opendate = $("#Opendate_d").val();	
			 	var dh = delTrim($("#dh_d").val());	 		
			 	
			 	var paramsStr='1=1 ';
			 	if(Opendate!=''){
			 	 	paramsStr+="and convert(varchar(12),Opendate,121) like '%"+Opendate+"%' ";
			 	}
			 	if(dh!=''){
			 		paramsStr+="and dh like '%"+dh+"%' " ;
			 	}
			 	
			 	$("#fusearchsql").val(paramsStr);
			 	fuheQuery();
				break;
	}////switch end	
 }	
			/**
			 * 打印报表
			 * @param 无参数
			 * @return 无返回值
			 */
	function printBB(){
		switch(tabStatus){
			case 1:	
					printThisReport1('<%=request.getParameter("imenuid")%>','yhdang_old',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');				
					break;
			case 2:	
					printThisReport1('<%=request.getParameter("imenuid")%>','hthdang_old',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
					break;
			case 3:			
					printThisReport1('<%=request.getParameter("imenuid")%>','attachfee_old',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');			
					break;
			case 4:			
					printThisReport1('<%=request.getParameter("imenuid")%>','qhyt_bytc_detail_old',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
					break;		
		}
	}
			/**
			 * 保存本次高级查询方法
			 * @param 无参数
			 * @return 无返回值
			 */
function addQuery(){
	saveQuery(tabStatus);
}
			/**
			 * 模板查询你
			 * @param 无参数
			 * @return 无返回值
			 */
function modQuery(){	
	 openQueryM(tabStatus);
}
			/**
			 * 导出操作
			 * @param 无参数
			 * @return 无返回值
			 */
function saveExoprt(){
		switch(tabStatus){
			case 1:			
					getTheCheckedFields('tsdBilling','mssql','yhdang_old');				
					break;
			case 2:			
					getTheCheckedFields('tsdBilling','mssql','hthdang_old');
					break;
			case 3:
					getTheCheckedFields('tsdBilling','mssql','attachfee_old');				
					break;
			case 4:
					getTheCheckedFields('tsdBilling','mssql','qhyt_bytc_detail_old');
					break;
		}
 }
 			/**
			 * 打开导出面板
			 * @param 无参数
			 * @return 无返回值
			 */
 function openExport(){
 		switch(tabStatus){
			case 1:	
					thisDownLoad('tsdBilling','mssql','yhdang_old','<%=languageType %>');				
					break;
			case 2:	
					thisDownLoad('tsdBilling','mssql','hthdang_old','<%=languageType %>');	
					break;
			case 3:			
					thisDownLoad('tsdBilling','mssql','attachfee_old','<%=languageType %>');				
					break;
			case 4:			
					thisDownLoad('tsdBilling','mssql','qhyt_bytc_detail_old','<%=languageType %>');	
					break;		
		}
 }
	</script>
	<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		</style> 
</head>

<body> 
	<!-- 用户操作导航-->
		<div id="navBar1">
			<table width="100%" height="26px">
			<tr>
				<td width="80%" valign="middle">
			  <div id="navBar" style="float:left">
			  <img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
			  <fmt:message key="global.location" />
					:
			  </div>
			  </td>
			  <td width="20%" align="right" valign="top">
			  <div id="d2back"><a href="javascript:void(0);" onclick="parent.history.back(); return false;"><fmt:message key="gjh.houtuei" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			  </td>
			  </tr>
		  </table>
		</div>
 	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder1" onclick="showDialog(0)">
			<!--排序--><fmt:message key="order.title" />
		</button>
		<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
		</button>
		<button id='mbquery1' onclick='modQuery();' >
			<!--模板查询--><fmt:message key="oper.mod"/>
		</button>
		<button id='gjquery1' onclick="openSearch();" disabled="disabled">
			<!--高级查询-->
			<fmt:message key="oper.queryA"/>
		</button>
		<button id='savequery1' onclick="openModT();" disabled="disabled">
			<!--保存本次查询--><fmt:message key="oper.modSave"/>
		</button> 
		<button type="button" id="export1" onclick="openExport();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>	
		<!--打印				
		<button type="button" id="print1" onclick="printBB();" disabled="disabled">
			<fmt:message key="tariff.printer" />
		</button>  
		--> 
	</div>
	<!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key='userLogQ.Yhdangold' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key='userLogQ.Hthdangold' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(3)"><span><fmt:message key='userLogQ.AttachFeeold' /></span></a></li>
			<li><a href="#gridd" onclick="tabsChg(4)"><span><fmt:message key='userLogQ.bytcdetailold' /></span></a></li>
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
		<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
		</button>
		<button id='mbquery2' onclick='modQuery();' >
			<!--模板查询--><fmt:message key="oper.mod"/>
		</button>
		<button id='gjquery2' onclick="openSearch();" disabled="disabled">
			<!--高级查询-->
			<fmt:message key="oper.queryA"/>
		</button>
		<button id='savequery2' onclick="openModT();" disabled="disabled">
			<!--保存本次查询--><fmt:message key="oper.modSave"/>
		</button> 
		<button type="button" id="export2" onclick="openExport();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>	
		<!--打印				
		<button type="button" id="print2" onclick="printBB();" disabled="disabled">
			<fmt:message key="tariff.printer" />
		</button>
		-->
	</div>
	
	
	
	
	

<!-- 添加修改面板 -->
<div class="neirong" id="pan" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="userLogQ.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
			<table id='perinfo' width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
				<tbody></tbody>	  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>
	
	
	
	
	<!-- 简单查询面板 -->
<div id="queryT1" name='queryT1' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="userLogQ.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoQuery();"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='queryform1' name="queryform1" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="Dhg_a"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Dh_a" id="Dh_a" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id="OperTimeg_a"></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="OperTime_a" id="OperTime_a" onfocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" class="textclass"/></td>
									    
				    <td width="12%" align="right"  class="labelclass"><label id="Yhmcg_a"></label></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="Yhmc_a" id="Yhmc_a" class="textclass"/></td>
			    	
			 	 </tr>	
			 	 <tr >
				    <td width="12%" align="right" class="labelclass"><label id="Yhdzg_a"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Yhdz_a" id="Yhdz_a" value="" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
									    
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			    	
			 	 </tr>		 	  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询 --><button class="tsdbutton" id="jdquery1" style="width:63px;heigth:27px;" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeoquery1" style="width:63px;heigth:27px;" onclick="closeoQuery();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>		
	
	
<!-- 简单查询面板 -->
<div id="queryT2" name='queryT2' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="userLogQ.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoQuery();"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='queryform2' name="queryform2" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="Dhg_b"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Dh_b" id="Dh_b" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id="OperTimeg_b"></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="OperTime_b" id="OperTime_b" onfocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" class="textclass"/></td>
									    
				    <td width="12%" align="right"  class="labelclass"><label id="Yhmcg_b"></label></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="Yhmc_b" id="Yhmc_b" class="textclass"/></td>
			    	
			 	 </tr>	
			 	 <tr >
				    <td width="12%" align="right" class="labelclass"><label id="Yhdzg_b"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Yhdz_b" id="Yhdz_b" value="" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
									    
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			    	
			 	 </tr>		 	  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询 --><button class="tsdbutton" id="jdquery2" style="width:63px;heigth:27px;" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeoquery2" style="width:63px;heigth:27px;" onclick="closeoQuery();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>		



<!-- 简单查询面板 -->
<div id="queryT3" name='queryT3' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="userLogQ.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoQuery();"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='queryform3' name="queryform3" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="Dhg_c"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Dh_c" id="Dh_c" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id="OperTimeg_c"></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="OperTime_c" id="OperTime_c" onfocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" class="textclass"/></td>
									    
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			    	
			 	 </tr>	  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询 --><button class="tsdbutton" id="jdquery3" style="width:63px;heigth:27px;" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeoquery3" style="width:63px;heigth:27px;" onclick="closeoQuery();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>		
	
	

<!-- 简单查询面板 -->
<div id="queryT4" name='queryT4' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="userLogQ.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoQuery();"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='queryform4' name="queryform4" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="dhg_d"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="dh_d" id="dh_d" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id="Opendateg_d"></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Opendate_d" id="Opendate_d" onfocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" class="textclass"/></td>
									    
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			    	
			 	 </tr>	  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询 --><button class="tsdbutton" id="jdquery4" style="width:63px;heigth:27px;" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeoquery4" style="width:63px;heigth:27px;" onclick="closeoQuery();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>	


<!-- 添加模板面板 -->
<div id="modT" style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="userLogQ.functionname" /></div>
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
				    	<input type="text" name="name_mod" id="name_mod" onpropertychange="TextUtil.NotMax(this)" maxlength="50" class="textclass"/>
				    	<font style="color: #ff0000;">*</font></td>
				    
				    <td width="12%" align="right" class="labelclass"><label id=''></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
					
				     <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			 	 </tr>
			</table>
		</form>
		<div class="midd_butt">
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="addQuery();" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>
	</div>
</div>

	
	
<form name="childform" id="childform">
<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
</form>
<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	<input type="hidden" id="addright" />
	<input type="hidden" id="deleteright" />
	<input type="hidden" id="editright" />
	<input type="hidden" id="delBright" />
	<input type="hidden" id="editBright" />
	<input type="hidden" id="exportright" />
	<input type="hidden" id="printright" />
	<!-- 操作国际化 -->
	<input type="hidden" id="addinfo" value="<fmt:message key="global.add"/>" />
	<input type="hidden" id="deleteinfo" value="<fmt:message key="global.delete"/>" />
	<input type="hidden" id="editinfo" value="<fmt:message key="global.edit"/>" />
	<input type="hidden" id="queryinfo" value="<fmt:message key="global.query"/>" />

	<input type="hidden" id="operation" value="<fmt:message key="global.operation"/>" />
	<input type="hidden" id="operationtips" value="<fmt:message key="global.operationtips"/>" />
	<input type="hidden" id="successful" value="<fmt:message key="global.successful"/>" />
	<input type="hidden" id="deleteinformation" value="<fmt:message key="global.deleteinformation"/>" />	
	
	<!-- mssql 语句中 查询列表记录 -->
	<input type="hidden" id="cols"/>
	<!-- 添加隐藏域：用于获取项目的绝对路径 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 	
	<!-- mssql 语句中 查询列表记录 用于下载 -->
	<input type="hidden" id="121"/>
	<input type="hidden" id="122"/>
	
	<!-- 高级查询 模板隐藏域 -->
	<input type="hidden" id="queryright"/>
	<input type="hidden" id="queryMright"/>
	<input type="hidden" id="saveQueryMright"/>	
	<!-- 查询树信息存放 -->
	<input type="hidden" id='treepid'/>
	<input type="hidden" id='treecid'/>	
	<input type="hidden" id='treestr'/>	
	<input type="hidden" id='treepic'/>
	<input type="hidden" id="useridd" value="<%=userid %>"/>
	
	<!-- grid自动 -->
	<input type="hidden" id='ziduansF' />
	<input type='hidden' id='thecolumn'/>
	

		
		
		<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv"><fmt:message key="userLogQ.chooseexportdata" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="userLogQ.close" /></a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<div id="thelistform" style="margin-left: 10px;max-height: 200px;overflow-y: auto;overflow-x: hidden;">
								
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
						<fmt:message key="userLogQ.selectall" />
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="saveExoprt();">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
				</div>
		</div>	
		
		<input type="hidden" id="whickOper"/>
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<%
			if (!languageType.equals("en")) {
				languageType = "zh";
			}
		%>
		<input type="hidden" id="languageType" value="<%=languageType%>" />
	
</body>

</html>
