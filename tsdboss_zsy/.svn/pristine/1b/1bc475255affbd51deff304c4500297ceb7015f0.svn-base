<%----------------------------------------
	name: userProfile.jsp
	author: youhongyu
	version: 1.0, 2009-11-26
	description: 用户档案总览 UserProfile
	modify: 
		2010-01-18 youhongyu 更改导出模块 
		2010-01-20 youhongyu 更改grid样式 grid字段可控 验证方法
		2010-03-11 youhongyu 更改页面显示结构  面板的弹出方式
		2010-12-17 liwen     按钮样式修改
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	String languageType = (String) session.getAttribute("languageType");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>User Profile</title><!-- 用户档案总览 -->
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
		<!-- 菜单样式 -->
		<link rel="stylesheet" href="style/css/telephone/usermanagement/single_thirteen.css" type="text/css" />
		
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
				 					  tsdpname:'userProfile.getPower',//存储过程的映射名称
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
				
				queryright += getCaption(spowerarr[i],'query','')+'|';
				queryMright += getCaption(spowerarr[i],'queryM','')+'|';
				saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
	
			}
	}else if(spower=='all@'){		
			
			$("#queryright").val(str);						
			$("#queryMright").val(str);
			$("#saveQueryMright").val(str);
						
			//var languageType = $("#languageType").val();
			//editfields = getFields('Tbl_CardNo');
			
			flag = true;
	}
	
	if(flag==false){
		
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
	}
	
}


</script>


<script type="text/javascript">
	var tabStatus_a = 1;	
	var tabStatus_b = 1;	
	var tables_a = ["Yhdang","AttachFee_Hth"];
	var tables_b = ["AttachFee","HfIntime"];
	
	var pkeys_a = ["yhdang","attachfeehth"];
	var pkeys_b = ["attachFee","hfintime"];	
	
	//var colNamess = [["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"],["<fmt:message key='global.operation' />"]];
	//var colModels = [[],[],[],[]];
	var firstLoad_a = [true,true];
	var firstLoad_b = [true,true];
	var mNames_a = [
				"<fmt:message key='userProfile.yhdang' />",
				"<fmt:message key='userProfile.attachFeeHth' />"
				];
	var mNames_b = [
				"<fmt:message key='userProfile.attachFee' />",
				"<fmt:message key='userProfile.hfIntime' />"
				];	
				
						
			/**
			 * 页面初始化
			 * @param 无参数
			 * @return 无返回值
			 */
	$(function(){
			//标题修改	
			$("#navBar").append(genNavv());
			
			
			
			//用户权限判定，初始化用户可操作权限 
			getUserPower();	
			var queryright = $("#queryright").val();			
			var saveQueryMright = $("#saveQueryMright").val();
			
			if(queryright=="true"){
				document.getElementById("gjquery1").disabled=false;
				document.getElementById("gjquery2").disabled=false;
				document.getElementById("gjquery3").disabled=false;
				
				document.getElementById("gjquery11").disabled=false;
				document.getElementById("gjquery21").disabled=false;
				document.getElementById("gjquery31").disabled=false;
			}		
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
				document.getElementById("savequery3").disabled=false;
				
				document.getElementById("savequery11").disabled=false;
				document.getElementById("savequery21").disabled=false;
				document.getElementById("savequery31").disabled=false;
			}
			ready1();	
			//第一层分项卡的初始化
			$("#tabs_a").tabs();
			$("#tabs_b").tabs();
			tabsChg_a(1);				
			
			//tabsChg_b(1);	
	});	
			/**
			 * 写jgride标签
			 * @param id
			 * @return 无返回值
			 */
	function tabsChg_a(id)
	{
		$("#gridd_a").empty();
		$("#gridd_a").append('<table id="editgrid_a" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd_a").append('<div id="pagered_a" class="scroll" style="text-align: left;"></div>');
		$("#editgrid_a").empty();
		$("#fusearchsql").val("");			
		switch(id)
		{		
			case 1:
				tabStatus_a=1;
				//电话档案日志表
				ready2();
				$("#cen3").show();
				break;
			case 2:
				tabStatus_a=2;
				//电话包月
				ready3();
				$("#cen3").hide();
				break;			
			default:
				tabStatus_a=1;			
				//电话档案日志表
				ready2();
				$("#cen3").show();
		}
	}
			/**
			 * 写jgride标签
			 * @param id
			 * @return 无返回值
			 */
	function tabsChg_b(id)
	{
		$("#gridd_b").empty();
		$("#gridd_b").append('<table id="editgrid_b" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd_b").append('<div id="pagered_b" class="scroll" style="text-align: left;"></div>');
		$("#editgrid_b").empty();
		$("#fusearchsql").val("");			
		switch(id)
		{		
			case 1:
				tabStatus_b=1;
				//电话月杂
				ready4();
				break;
			case 2:
				tabStatus_b=2;	
				//合同号杂费
				ready5();				
				break;		
			default:
				tabStatus_b=1;		
				//电话档案日志表
				ready4();
		}		
	}

	//ready1();  电话档案日志表
			/**
			 * 电话档案日志表
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready1()
	{
		var thisdata = loadData('Hthdang','<%=languageType %>',2);
		
		var col=[[],[]];
		col=getRb_Field('Hthdang','Hth',"<fmt:message key='userProfile.detail' />",'70','ziduansF');//得到jqGrid要显示的字段
		var column = $("#ziduansF").val();
		
		var Dhg = thisdata.getFieldAliasByFieldName('Dh');
		var Yhmcg = thisdata.getFieldAliasByFieldName('Yhmc');
		var Yhdzg = thisdata.getFieldAliasByFieldName('Yhdz');		
		$("#Dhg_a").html(Dhg);
		$("#Yhmcg_a").html(Yhmcg);
		$("#Yhdzg_a").html(Yhdzg);
		
		var urlstr=buildParamsSql('query','xml','hthdang.query','hthdang.querypage');
		
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1],
				       	rowNum:5, //默认分页行数
				       	rowList:[5,10,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Hth', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userProfile.hthdang' />", 
				       	shrinkToFit: false,
				       	height:130, //高
				    	width:document.documentElement.clientWidth-120,
				       	loadComplete:function(){
										addRowOperBtnimage('editgrid','openRowInfo_1','Hth','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userProfile.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										//addRowOperBtnimage('editgrid','openMxInfo_a','Hth','click',2,'images/ltubiao_05.gif',"明细","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid',1);							    		
							    		//loadyhdangd();
										//alert($("#editgrid").getCell(1,"Hth"));	
										$("#meetid").val($("#editgrid").getCell(1,"Hth"));
										
										},
							//选择grid种的一列触发方法，根据这列种的Call_Type的值来查询加载editgrid_son表
							onSelectRow: function(ids) {
									//ids是返回的rowid,然后根据它再返回meetid
									if(ids != null) {
											var meetid='';
											meetid=$("#editgrid").getCell(ids,"Hth");	
											$("#meetid").val(meetid);
											if($("#tabs_a").is(":visible")){												
												$("#tabsChg_a").click();
												//tabsChg_a(1);
											}
									}									
							},
							ondblClickRow: function(ids) {
									if(ids != null) {
										var Hth =$("#editgrid").getCell(ids,"Hth");
										openRowInfo_1(Hth);
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
			 * 打开对应grid记录详细信息1
			 * @param key
			 * @return 无返回值
			 */
function openRowInfo_1(key){
	openRowInfo(key,1);
}
			/**
			 * 打开对应grid记录详细信息2
			 * @param key
			 * @return 无返回值
			 */
function openRowInfo_2(key){
	openRowInfo(key,2);
}
			/**
			 * 打开对应grid记录详细信息3
			 * @param key
			 * @return 无返回值
			 */
function openRowInfo_3(key){
	openRowInfo(key,3)
}
			/**
			 * 打开对应grid记录详细信息4
			 * @param key
			 * @return 无返回值
			 */
function openRowInfo_4(key){
	openRowInfo(key,4);
}
			/**
			 * 打开对应grid记录详细信息5
			 * @param key
			 * @return 无返回值
			 */
function openRowInfo_5(key){
	openRowInfo(key,5);
}	
			/**
			 * 获取对应jqgrid的数据表名
			 * @param key
			 * @return String
			 */
function getTable(key){
		var tablename='';
		switch(key){
			case 1:
				tablename='hthdang';
				break;
			case 2:
				tablename='yhdang';
				break;
			case 3:
				tablename='attachfee_hth';
				break;
			case 4:
				tablename='attachfee';
				break;
			case 5:
				tablename='hfintime';
				break;
		}
		return tablename;
}
			/**
			 * 显示详细信息
			 * @param key
			 * @param key1
			 * @return String
			 */
function openRowInfo(key,key1){
		//获取表别名，生成展示table
		
		var tablename=getTable(key1);
		var fieldA= getLoadP('<%=languageType%>',tablename);
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
				 $tr_1 += " <td width='12%' align='right' class='labelclass'><label id='"+fieldA[0][i]+"g' >"+fieldA[1][i]+"</label></td><td width='20%' align='left' style='border-bottom:1px solid #A9C8D9;'><input type='text' name='"+fieldA[0][i]+"' id='"+fieldA[0][i]+"' disabled='disabled' class='textclass2'></input></td>";
			}
		}
		$("#perinfo tbody").html($tr_1);	
			
		openpan();			
		//设置编辑框的标题		
		$(".top_03").html("<fmt:message key='userProfile.detailmessage' />");//标题	 	
		queryByID(key,fieldA[0],key1);
		
}
			/**
			 * 取出一条数据显示在修改面板中
			 * @param key
			 * @param key1
			 * @param key2
			 * @return 无返回值
			 */
function queryByID(key,key1,key2){ 
		var urlstr=tsd.buildParams({  
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdcf:'mssql',//指向配置文件名称
							  tsdoper:'query',//操作类型 
							  datatype:'xmlattr',//返回数据格式 
							  tsdpk:'userProfile'+key2+'.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							});	
			//tables[tabStatus]
			switch(key2){
				case 1:
					urlstr +="&Hth="+key;
					break;
				case 2:
					urlstr +="&Dh="+key;
					break;
				case 3:
					urlstr +="&ID="+key;
					break;
				case 4:
					urlstr +="&ID="+key;
					break;	
				case 5:
					urlstr +="&ID="+key;
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
/**********************
	function openMxInfo_a(key){
		$("#meetid").val(key);
		$("#tabsChg_a").click();
		//tabsChg_a(1);
		$("#cen2").show();		
	}
*************************/
			/**
			 * 计费类别费率减免 loadyhdangd
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready2()
	{		
			
		//此表为明细表，获取关联字段
		var meetid = $("#meetid").val();
		meetid=tsd.encodeURIComponent(meetid);	
		var urlstr_son=buildParamsSql('query','xml','yhdang.query','yhdang.querypage');
		var col=[[],[]];
		col=getRb_Field('Yhdang','Dh',"<fmt:message key='userProfile.detail' />",'70','ziduansF1');//得到jqGrid要显示的字段
		var column = $("#ziduansF1").val();		
		$("#editgrid_a").jqGrid({
				url:'mainServlet.html?'+urlstr_son+'&column='+column+"&Hth="+meetid,
				datatype: 'xml', 
				colNames:col[0],//["<fmt:message key='global.operation' />","Charge_Type","Thlx","Bjfj","Jbfl_Jme","Jbfl_Jmbl","Tffl_Jme","Tffl_Jmbl","Fuf_Jme","Fuf_Jmbl","Fjf_Jme","Fjf_Jmbl","Bz"], 
				colModel:col[1], 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered_a'), 
				       	sortname:'Dh', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userProfile.yhdang' />", 
				       	shrinkToFit: false,
				       	height:215, //高
				    	width:document.documentElement.clientWidth-90,
				       	loadComplete:function(){
										addRowOperBtnimage('editgrid_a','openRowInfo_2','Dh','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userProfile.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										//addRowOperBtnimage('editgrid_a','openMxInfo_b','Dh','click',2,'images/ltubiao_05.gif',"明细","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid_a',1);
										//alert($("#editgrid_a").getCell(1,"Dh"));
										$("#Dhmeetid").val($("#editgrid_a").getCell(1,"Dh"));
							},
							//选择grid种的一列触发方法，根据这列种的Call_Type的值来查询加载editgrid_son表
							onSelectRow: function(ids) {
									//ids是返回的rowid,然后根据它再返回meetid	    
									if(ids != null) {			
										var Dhmeetid='';
										Dhmeetid=$("#editgrid_a").getCell(ids,"Dh");	
										$("#Dhmeetid").val(Dhmeetid);
										if($("#tabs_b").is(":visible")){
											$("#tabsChg_b").click();
											//tabsChg_b(1);
										}
										
								}
							},
							ondblClickRow: function(ids) {
									if(ids != null) {
										var Dh =$("#editgrid_a").getCell(ids,"Dh");
										openRowInfo_2(Dh);
									}
							}							
				}).navGrid('#pagered_a', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	/****************
	function openMxInfo_b(key){
		$("#Dhmeetid").val(key);
		$("#cen3").show();
		$("#tabsChg_b").click();
		//tabsChg_b(1);
	}
	****************/
			/**
			 * ready3 计费类别费率减免
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready3()
	{
		//此表为明细表，获取关联字段
		var meetid = $("#meetid").val();
		meetid=tsd.encodeURIComponent(meetid);		
		var urlstr=buildParamsSql('query','xml','attachfeehth.query','attachfeehth.querypage');
		var col=[[],[]];
		col=getRb_Field('AttachFee_Hth','Hth',"<fmt:message key='userProfile.detail' />",'70','ziduansF1','ID');//得到jqGrid要显示的字段
		var column = $("#ziduansF1").val();
						
		$("#editgrid_a").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column+"&Hth="+meetid,
				datatype: 'xml', 
				colNames:col[0],//["<fmt:message key='global.operation' />","Charge_Type","Thlx","Bjfj","Jbfl_Jme","Jbfl_Jmbl","Tffl_Jme","Tffl_Jmbl","Fuf_Jme","Fuf_Jmbl","Fjf_Jme","Fjf_Jmbl","Bz"], 
				colModel:col[1], 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered_a'), 
				       	sortname:'Hth', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userProfile.attachFeeHth' />", 
				       	height:215, //高
				       	width:document.documentElement.clientWidth-90,
				       	loadComplete:function(){
										addRowOperBtnimage('editgrid_a','openRowInfo_3','ID','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userProfile.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid_a',1);
						},
						ondblClickRow: function(ids) {
								if(ids != null) {
									var ID =$("#editgrid_a").getCell(ids,"ID");
									openRowInfo_3(ID);
								}
						}
				}).navGrid('#pagered_a', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
			/**
			 * ready2计次费率 合同号档案日志表
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready4()
	{		
		//此表为明细表，获取关联字段
		var Dhmeetid =$("#Dhmeetid").val();
		Dhmeetid=tsd.encodeURIComponent(Dhmeetid);	
		
		var urlstr=buildParamsSql('query','xml','attachfee.query','attachfee.querypage');
		var col=[[],[]];
		col=getRb_Field('AttachFee','ID',"<fmt:message key='userProfile.detail' />",'70','ziduansF2','Dh');//得到jqGrid要显示的字段
		var column = $("#ziduansF2").val();
				
		$("#editgrid_b").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column+"&Dh="+Dhmeetid,
				datatype: 'xml', 
				colNames:col[0],//["<fmt:message key='global.operation' />","Call_Type","Bjzg","YhDaihao","Cs0","Cs1","Cs2","Cs3","Feilu","TfFeilu","BaseHf","Tfhf","HoliDay_Type",'Period_Time'], 
				colModel:col[1],
				       	rowNum:5, //默认分页行数
				       	rowList:[5,10,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered_b'), 
				       	sortname: 'Dh', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userProfile.attachFee' />", 
				       	height:150, //高
				       	//width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
										addRowOperBtnimage('editgrid_b','openRowInfo_4','ID','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userProfile.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid_b',1);
										/****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var ID =$("#editgrid_b").getCell(ids,"ID");
													openRowInfo_4(ID);
												}
										}
				}).navGrid('#pagered_b', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
			/**
			 * ready4 分时段费率减免
			 * @param 无参数
			 * @return 无返回值
			 */
	function ready5() 
	{	
		//此表为明细表，获取关联字段					
		var Dhmeetid =$("#Dhmeetid").val();
		Dhmeetid=tsd.encodeURIComponent(Dhmeetid);	
		
		var urlstr=buildParamsSql('query','xml','hfintime.query','hfintime.querypage');
		var col=[[],[]];
		col=getRb_Field('hfintime','ID',"<fmt:message key='userProfile.detail' />",'70','ziduansF2');//得到jqGrid要显示的字段
		var column = $("#ziduansF2").val();		
		
		$("#editgrid_b").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column+"&Dh="+Dhmeetid,
				datatype: 'xml', 
				colNames:col[0],//["<fmt:message key='global.operation' />","Jmlx","Jmshd","Jrlx","jdjbJme","jbJmbl","jdtfJme","tfJmbl","jdsxJme","sxJmbl","jdfjJme","fjJmbl","jdqtJme1","qtJmbl1","jdqtJme2","qtJmbl2","memo"], 
				colModel:col[1], 
				       	rowNum:5, //默认分页行数
				       	rowList:[5,10,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered_b'), 
				       	sortname: 'ID', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='userProfile.hfIntime' />", 
				       	height:150, //高
				       	//width:document.documentElement.clientWidth+100,
				       	loadComplete:function(){
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
										addRowOperBtnimage('editgrid_b','openRowInfo_5','ID','click',1,'style/images/public/ltubiao_03.gif',"<fmt:message key='userProfile.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid_b',1);
										 /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var ID =$("#editgrid_b").getCell(ids,"ID");
													openRowInfo_5(ID);
												}
										}
				}).navGrid('#pagered_b', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
 			/**
			 * ready4 打开查询面板
			 * @param 无参数
			 * @return 无返回值
			 */
 function openQuery(){		
		$(".top_03").html('<fmt:message key="global.query" />');//标题
		openQueryT();
		clearText('queryform');
 }

 			/**
			 * 通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
			   @oper 操作类型 modify|save
			 * @param 无参数
			 * @return 无返回值
			 */
 function QbuildParams(){
 	var Dh = delTrim($("#Dh_a").val());
 	var Yhmc = delTrim($("#Yhmc_a").val());
 	var Yhdz = delTrim($("#Yhdz_a").val());	
 				 	
 	var paramsStr='1=1 ';
 	if(Dh!=''){
 			if(isTelY(Dh)){
	 			paramsStr+="and Dh like '%"+Dh+"%' ";
	 		}
	 		else{
	 			//电话号码请输入整数！
	 			alert("<fmt:message key='Revenue.bTelephone'/><fmt:message key='global.invalid'/>");
	 			$("#Dh").focus();
	 			return false;
	 		} 		
 	}
 	if(Yhmc!=''){
 		paramsStr+="and Yhmc like '%"+Yhmc+"%' " ;
 	}
 	if(Yhdz!=''){
 		paramsStr+="and Yhdz like '%"+Yhdz+"%' " ;
 	}
 	$("#fusearchsql").val(paramsStr);
 	$("#jqgridC").val(1);
 	fuheQuery();
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
		{	}
		else if(queryName=="modify")
		{	}
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
	var column = $("#ziduansF").val();	
	var urlstr=buildParamsSql('query','xml','hthdang.queryByWhere','hthdang.queryByWherepage');	
	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+params+'&column='+column}).trigger("reloadGrid");
	setTimeout($.unblockUI, 15);//关闭面板
}

			/**
			 * 判断当前操作的是那个jqgrid
			 * @param key
			 * @return int
			 */
function getJQgirdIn(key){
	var Ts=0;
	switch(key){
		case 1:
				Ts=1;
				break;
		case 2:
			switch(tabStatus_a){
				case 1:
					Ts=2;
					break;
				case 2:
					Ts=3;
					break;
			}
			break;
		case 3:
			switch(tabStatus_b){
				case 1:
					Ts=4;
					break;
				case 2:
					Ts=5;
					break;
			}
			break;
	}////switch end	
	return Ts;
}	

			/**
			 * 复合查询
			 * @param 无参数
			 * @return 无返回值
			 */
function fuheQuery()
{
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}
	 	//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
		
		var Ts=$("#jqgridC").val();
		Ts=parseInt(Ts);
		switch(Ts){
  					case 1:   						
						var column = $("#ziduansF").val();
  						var urlstr1=buildParamsSql('query','xml','hthdang.fuheQueryByWhere','hthdang.fuheQueryByWherepage');
  						$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr1+'&column='+column+params}).trigger("reloadGrid");
  						break;
  					case 2:   						
						var column = $("#ziduansF1").val();
  						var urlstr1=buildParamsSql('query','xml','yhdang.fuheQueryByWhere','yhdang.fuheQueryByWherepage');
  						
  						//此表为明细表，获取关联字段
						var meetid = $("#meetid").val();
						meetid=tsd.encodeURIComponent(meetid);	
  						$("#editgrid_a").setGridParam({url:'mainServlet.html?'+urlstr1+'&Hth='+meetid+'&column='+column+params}).trigger("reloadGrid");
  						break;
  					case 3:   						
						var column = $("#ziduansF1").val();
  						var urlstr1=buildParamsSql('query','xml','attachfeehth.fuheQueryByWhere','attachfeehth.fuheQueryByWherepage');
  						
  						//此表为明细表，获取关联字段
						var meetid = $("#meetid").val();
						meetid=tsd.encodeURIComponent(meetid);
  						$("#editgrid_a").setGridParam({url:'mainServlet.html?'+urlstr1+'&Hth='+meetid+'&column='+column+params}).trigger("reloadGrid");
  						break;
  					case 4:   						
						var column = $("#ziduansF2").val();
  						var urlstr1=buildParamsSql('query','xml','attachfee.fuheQueryByWhere','attachfee.fuheQueryByWherepage');
  						
  						//此表为明细表，获取关联字段					
						var Dhmeetid =$("#Dhmeetid").val();
						Dhmeetid=tsd.encodeURIComponent(Dhmeetid);
  						$("#editgrid_b").setGridParam({url:'mainServlet.html?'+urlstr1+'&Dh='+Dhmeetid+'&column='+column+params}).trigger("reloadGrid");
  						break;
  					case 5:   						
						var column = $("#ziduansF2").val();
  						var urlstr1=buildParamsSql('query','xml','hfintime.fuheQueryByWhere','hfintime.fuheQueryByWherepage');
  						
  						//此表为明细表，获取关联字段					
						var Dhmeetid =$("#Dhmeetid").val();
						Dhmeetid=tsd.encodeURIComponent(Dhmeetid);
  						$("#editgrid_b").setGridParam({url:'mainServlet.html?'+urlstr1+'&Dh='+Dhmeetid+'&column='+column+params}).trigger("reloadGrid");
  						break;
  		}				
		 	setTimeout($.unblockUI, 15);//关闭面板			
			closeo();		
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
		params +=params+'&orderby='+sqlstr;	
		
	 	//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
				
		var Ts=$("#jqgridC").val();
		Ts=parseInt(Ts);
		switch(Ts){
  					case 1:   						
						var column = $("#ziduansF").val();
  						var urlstr1=buildParamsSql('query','xml','hthdang.queryByOrder','hthdang.queryByOrderpage');  						
  						$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr1+'&column='+column+params}).trigger("reloadGrid");
  						break;
  					case 2:   						
						var column = $("#ziduansF1").val();
  						var urlstr1=buildParamsSql('query','xml','yhdang.queryByOrder','yhdang.queryByOrderpage');
  						//此表为明细表，获取关联字段
						var meetid = $("#meetid").val();
						meetid=tsd.encodeURIComponent(meetid);	
						
  						$("#editgrid_a").setGridParam({url:'mainServlet.html?'+urlstr1+'&Hth='+meetid+'&column='+column+params}).trigger("reloadGrid");
  						break;
  					case 3:   						
						var column = $("#ziduansF1").val();
  						var urlstr1=buildParamsSql('query','xml','attachfeehth.queryByOrder','attachfeehth.queryByOrderpage');
  						//此表为明细表，获取关联字段
						var meetid = $("#meetid").val();
						meetid=tsd.encodeURIComponent(meetid);	
						
  						$("#editgrid_a").setGridParam({url:'mainServlet.html?'+urlstr1+'&Hth='+meetid+'&column='+column+params}).trigger("reloadGrid");
  						break;
  					case 4:   						
						var column = $("#ziduansF2").val();
  						var urlstr1=buildParamsSql('query','xml','attachfee.queryByOrder','attachfee.queryByOrderpage');
  						//此表为明细表，获取关联字段					
						var Dhmeetid =$("#Dhmeetid").val();
						Dhmeetid=tsd.encodeURIComponent(Dhmeetid);	
		
  						$("#editgrid_b").setGridParam({url:'mainServlet.html?'+urlstr1+'&Dh='+Dhmeetid+'&column='+column+params}).trigger("reloadGrid");
  						break;
  					case 5:   						
						var column = $("#ziduansF2").val();
  						var urlstr1=buildParamsSql('query','xml','hfintime.queryByOrder','hfintime.queryByOrderpage');
  						//此表为明细表，获取关联字段					
						var Dhmeetid =$("#Dhmeetid").val();
						Dhmeetid=tsd.encodeURIComponent(Dhmeetid);	
		
  						$("#editgrid_b").setGridParam({url:'mainServlet.html?'+urlstr1+'&Dh='+Dhmeetid+'&column='+column+params}).trigger("reloadGrid");
  						break;
  		}				
		 	setTimeout($.unblockUI, 15);//关闭面板			
				 	
	}
			/**
			 * 打开修改面板
			 * @param key
			 * @return 无返回值
			 */
function openModTs(key){
	var Ts=getJQgirdIn(key);
	$("#jqgridC").val(Ts);
	openModT();
}
			/**
			 * 保存本次高级查询方法
			 * @param key
			 * @return 无返回值
			 */
function addQuery(key){	
	var Ts=$("#jqgridC").val();
	Ts=parseInt(Ts);
	saveModQuery(Ts);
	$("#fusearchsql").val("");
}
			/**
			 * 模板查询
			 * @param key
			 * @return 无返回值
			 */
function modQuery(key){
	var Ts=getJQgirdIn(key);
	$("#jqgridC").val(Ts);
	openQueryM(Ts);
} 
 			/**
			 * 组合排序
			 * @param key
			 * @return 无返回值
			 */      
function openwinO(key){
	var Ts=getJQgirdIn(key);				
	var tablename=getTable(Ts);
	$("#jqgridC").val(Ts);	
	openDiaO(tablename);
}
			/**
			 * 打开复合查询面板
			 * @param key
			 * @return 无返回值
			 */
function openwinQ(key)
{
	$("#fusearchsql").val("");
	var Ts=getJQgirdIn(key);
	var tablename=getTable(Ts);	
	$("#jqgridC").val(Ts);
	openDiaQ("query",tablename);
	//alert(tablename);
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
		autoBlockFormAndSetWH('queryT',60,5,'closeoT',"#ffffff",true,1000,'');//弹出查询面板
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
	<div id='but1'>
		<div id="buttons" name="pribut" >
			<button type="button" onclick="openwinO(1);">
			<fmt:message key="order.title" />
			</button>		
			<button type="button" onclick="openQuery();">
					<!--查询-->
					<fmt:message key="global.query" />
			</button>
			<button id='mbquery1' onclick='modQuery(1);' >
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery1' onclick="openwinQ(1);" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery1' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 
		</div>
	</div>
	
	<!-- 第一层 主表-->
	<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>		
	<div id='but1' style="display: none;">
		<div id="buttons" name="pribut" >
			<button type="button" onclick="openwinO(1);">
			<fmt:message key="order.title" />
			</button>		
			<button type="button" onclick="openQuery();">
					<!--查询-->
					<fmt:message key="global.query" />
			</button>
			<button id='mbquery11' onclick='modQuery(1);' >
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery11' onclick="openwinQ(1);" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery11' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 
		</div>
	</div>
		
<div id='cen2' >
	<div id='but2'>
		<div id="buttons" name="pribut">
			<button type="button" onclick="openwinO(2);">
			<fmt:message key="order.title" />
			</button>
			<button id='mbquery2' onclick='modQuery(2);'>
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery2' onclick="openwinQ(2);" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery2' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 
		</div>
	</div>
	<!-- 第二层  明细分项卡-->
	
	<!-- Tabs -->
	<div id="tabs_a" >	
		<ul>
			<li><a href="#gridd_a" onclick="tabsChg_a(1)" id='tabsChg_a'><span><fmt:message key='userProfile.yhdang' /></span></a></li>
			<li><a href="#gridd_a" onclick="tabsChg_a(2)"><span><fmt:message key='userProfile.attachFeeHth' /></span></a></li>
		</ul>
		<div id="gridd_a">
		    <table id="editgrid_a" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered_a" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	
	<div id='but2' style="display: none;">
		<div id="buttons" name="pribut">
			<button type="button" onclick="openwinO(2);">
			<fmt:message key="order.title" />
			</button>
			<button id='mbquery21' onclick='modQuery(2);'>
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery21' onclick="openwinQ(2);" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery21' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 
		</div>
	</div>
</div>

<div id='cen3' >
	<div id='but2'>
		<div id="buttons" name="pribut">
			<button type="button" onclick="openwinO(3);">
			<fmt:message key="order.title" />
			</button>
			<button id='mbquery3' onclick='modQuery(3);'>
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery3' onclick="openwinQ(3);" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery3' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 
		</div>
	</div>
	<!-- 第三层 明细分项卡-->
	
	<!-- Tabs -->
	<div id="tabs_b">	
		<ul>			
			<li><a href="#gridd_b" onclick="tabsChg_b(1)" id='tabsChg_b'><span><fmt:message key='userProfile.attachFee' /></span></a></li>
			<li><a href="#gridd_b" onclick="tabsChg_b(2)"><span><fmt:message key='userProfile.hfIntime' /></span></a></li>
		</ul>
		<div id="gridd_b">
		    <table id="editgrid_b" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered_b" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	
	<div id='but2' style="display: none;">
		<div id="buttons" name="pribut">
			<button type="button" onclick="openwinO(3);">
			<fmt:message key="order.title" />
			</button>
			<button id='mbquery31' onclick='modQuery(3);'>
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery31' onclick="openwinQ(3);" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery31' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 
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
				<div class="top_03" ><fmt:message key="userProfile.functionname" /></div>
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
				    
				    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
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


<!-- 添加修改面板 -->
<div class="neirong" id="pan" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="userProfile.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
			<div style="max-height:315px;overflow-y: auto;overflow-x: hidden;">
				<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
					<table id='perinfo' width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
						<tbody></tbody>	  
					</table>
				</form>	
			</div>	
			<div class="midd_butt">
			<!-- 关闭 	 --><button class="tsdbutton" id="closeo" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
			</div>	
	</div>
</div>









 <!-- 简单查询面板 -->
<div id="queryT" name='queryT' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="userProfile.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoQuery();"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='queryform' name="queryform" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="Dhg_a"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Dh_a" id="Dh_a" class="textclass" /></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id="Yhmcg_a"></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Yhmc_a" id="Yhmc_a" class="textclass"/></td>
									    
				    <td width="12%" align="right"  class="labelclass"><label id="Yhdzg_a"></label></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="Yhdz_a" id="Yhdz_a" class="textclass"/></td>
			    	
			 	 </tr>		 	  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询 --><button class="tsdbutton" id="jdquery" style="width:63px;heigth:27px;" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeoT" style="width:63px;heigth:27px;" onclick="closeoQuery();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>
  	
	
	<!-- typtDemoModify  表单输入区域  -->
		<div id="inputs">
	
		
		</div>
	<form name="childform" id="childform">
	<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
</form>
<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
<!-- 语言 -->
<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />

<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
<input type="hidden" name="languageType" id="languageType" value='<%=languageType %>' />
	<input type="hidden" id="addright" />
	<input type="hidden" id="deleteright" />
	<input type="hidden" id="editright" />
	<input type="hidden" id="delBright" />
	<input type="hidden" id="editBright" />
	<input type="hidden" id="exportright" />
	<input type="hidden" id="printright" />
	
	<input type="hidden" id="operation"
						value="<fmt:message key="global.operation"/>" />
	<input type="hidden" id="operationtips"
		value="<fmt:message key="global.operationtips"/>" />
	<input type="hidden" id="successful"
		value="<fmt:message key="global.successful"/>" />
	<input type="hidden" id="deleteinformation"
						value="<fmt:message key="global.deleteinformation"/>" />
	<!-- mssql 语句中 查询列表记录 -->
	<input type="hidden" id="cols"/>
	<input type="hidden" id="cols_p"/>
	<input type="hidden" id="cols_s"/>
	<!-- 添加隐藏域：用于获取项目的绝对路径 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 	
	<!-- mssql 语句中 查询列表记录 用于下载 -->
	<input type="hidden" id="121"/>
	<input type="hidden" id="122"/>
	<!-- meetid 用于存放明细表关连字段 关连字段为hth -->
	<input type='hidden' id='meetid' value='00000'/>
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
	<input type="hidden" id='ziduansF1' />
	<input type="hidden" id='ziduansF2' />
	<input type='hidden' id='thecolumn'/>
	<input type='hidden' id='jqgridC'/>	
	
	
	<input type='hidden' id='Dhmeetid' value=''/>
</body>
</html>
