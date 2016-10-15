<%----------------------------------------
	name: paramSet.jsp
	author: youhongyu
	version: 1.0, 2010-5-19
	description: 170查询参数设置
	modify: 	
		2009-11-13 youhongyu oracle移植
		2010-12-21 youhongyu 修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>

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
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
%>
<%
	String lanType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>170 query parameter</title>
    
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
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
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
			 var urlstr=buildParamsPro('paramSet.getPower','query');
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
			var editfields_son='';
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
						editfields_son += getCaption(spowerarr[i],'editfields2','');
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
					editfields = getFields('t170_qf_cxyysz');
					editfields_son = getFields('t170_jy_cxyysz');
					
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
			$("#editfields_son").val(editfields_son);
}

			 /**
 		   	  * 初始化收费科目
 			  * @param 无参数
 			  * @return 无返回值
 			  */
			 function getKemu(){
						var urlstr=buildParamsSqlByS('tsdBilling','query','xmlattr','paramSet.getKemu','');
						
						$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
									$(xml).find('row').each(function(){
		                   				var area="<option value='"+$(this).attr("Kemu".toLowerCase())+"'>"+$(this).attr("Kemu".toLowerCase())+"</option>";
										$("#Kemu").html($("#Kemu").html()+area);
									});
							}
						});
				}
				

			
	var tabStatus = 1;
	var primaryKeys = [
		["Xh"],
		["Xh"]
	];
	var tables = ["t170_qf_cxyysz","t170_jy_cxyysz"];
	var pkeys = ["QfCxyySz","JyCxyySz"];
	var fuheM = false;
	var firstLoad = [true,true];
	var mNames = ["170费用查询参数设置","170结余查询参数设置"];
	
	$(function(){
			//分项卡方法调用
			$("#tabs").tabs();
			tabsChg(1);
			//导航栏设置
			$("#navBar").append(genNavv());
			setLabelN('t170_jy_cxyysz','','g');//设置添加修改面板中lable字段别名
			getKemu();//初始化收费科目
			//权限设置
			getUserPower();
			var addright = $("#addright").val();
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
			
			if(addright=="true"){
				document.getElementById("openadd1").disabled=false;
				document.getElementById("openadd2").disabled=false;
			}
			if(exportright=="true"){
				document.getElementById("export1").disabled=false;
				document.getElementById("export2").disabled=false;
			}
			if(printright=="true"){
				document.getElementById("print1").disabled=false;
				document.getElementById("print2").disabled=false;
			}		
		
	});


var closeflash = false;//用于判断是添加新增、添加保存	
/**
  * 改变jgride状态
  * @param id(唯一标识)
  * @return 无返回值
  */
function tabsChg(id)
{
		$("#gridd").empty();
		$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
		$("#editgrid").empty();
		$("#fusearchsql").val("")
		switch(id)
		{
			case 1:
				tabStatus=1;				
				ready1();
				break;
			case 2:
				tabStatus=2;				
				ready2();
				break;
			default:
				tabStatus=1;				
				ready1();
		}
}

/**
  * 170费用查询参数设置jgride结果集
  * @param 无参数
  * @return 无返回值
  */
function ready1(){			
			var col=[[],[]];
			col=getRb_Field('t170_qf_cxyysz','Xh',"修改|删除|详细",'97','ziduansF1');;//得到jqGrid要显示的字段
			var column = $("#ziduansF1").val();	 			 					
			
			var urlstr=buildParamsSqlByS('tsdBilling','query','xml','paramSet.query','paramSet.querypage');			
			//alert(colNamess[tabStatus-1].length);
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column+'&talbename='+tables[0],
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1], 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Xh', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"170费用查询参数设置", 
				       	height:document.documentElement.clientHeight-230, //高
				        width:document.documentElement.clientWidth-50,
				       	loadComplete:function(){				       	
				       					var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										addRowOperBtnimage('editgrid','openRowModify','Xh','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
										addRowOperBtnimage('editgrid','deleteRow','Xh','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openRowInfo','Xh','click',3,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;");//详细
																				
										executeAddBtn('editgrid',3);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var Xh =$("#editgrid").getCell(ids,"Xh");
													openRowInfo(Xh);
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
  * 170结余查询参数设置jgride结果集
  * @param 无参数
  * @return 无返回值
  */
function ready2(){		
			
			var col=[[],[]];
			col=getRb_Field('t170_jy_cxyysz','Xh',"修改|删除|详细",'97','ziduansF2');//得到jqGrid要显示的字段
			var column = $("#ziduansF2").val();	
			var urlstr=buildParamsSqlByS('tsdBilling','query','xml','paramSet.query','paramSet.querypage');	
			
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column+'&talbename='+tables[1],
				datatype: 'xml',				
				colNames:col[0], 
				colModel:col[1], 			
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Xh', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"170结余查询参数设置", 
				       	height:document.documentElement.clientHeight-230, //高
				        width:document.documentElement.clientWidth-50,
				       	loadComplete:function(){
				       					var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										addRowOperBtnimage('editgrid','openRowModify','Xh','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
										addRowOperBtnimage('editgrid','deleteRow','Xh','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openRowInfo','Xh','click',3,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;");//详细
															
										executeAddBtn('editgrid',3);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var Xh =$("#editgrid").getCell(ids,"Xh");
													openRowInfo(Xh);
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
  * 打开修改面板并加载将要修改的数据 
  * @param key(唯一标识)
  * @return 无返回值
  */
function openRowInfo(key){
	
	markTable(1);//显示红色*号	
	//设置编辑框的标题
	$(".top_03").html("详细信息");//标题	
	isDisabledN('t170_jy_cxyysz','','');//将修改面板的输入框全部	置为不可用
	clearText('operformT1');//清空修改面板				
	openpan();//显示修改面板
	queryByID(key);
}

/**
  * 根据id查询数据
  * @param key(唯一标识)
  * @return 无返回值
  */
function queryByID(key){
		$("#Xh").val(key);		
		var urlstr=buildParamsSqlByS('tsdBilling','query','xmlattr','paramSet.queryByKey','');
						
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&Xh='+key+'&talbename='+tables[tabStatus-1],
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				/////////////////////////////
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
				$(xml).find('row').each(function(){
						//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
						///如果sql语句中指定列名 则按指定名称给参数
						//Xh  Kemu Zdm  Yywjm Sm
						var oldstr=[];
						
						
						
						var Zdm = $(this).attr("Zdm".toLowerCase());
						oldstr.push(Zdm);	
						$("#Zdm").val(Zdm);
						
						var Yywjm = $(this).attr("Yywjm".toLowerCase());
						oldstr.push(Yywjm);	
						$("#Yywjm").val(Yywjm);
						
						var Sm = $(this).attr("Sm".toLowerCase());
						oldstr.push(Sm);	
						$("#Sm").val(Sm);
						
						var Xh = $(this).attr("Xh".toLowerCase());
						oldstr.push(Xh);	
						$("#Xh").val(Xh);
						
						var Kemu = $(this).attr("Kemu".toLowerCase());	
						oldstr.push(Kemu);						
						$("#Kemu").val(Kemu);
						
						$("#logoldstr").val(oldstr);							
				});
			}
		});		
}

/**
  * 新增
  * @param saves(添加状态1：保存添加；2：保存关闭)
  * @return 无返回值
  */
function saveObj(saves){	
			var params=buildParams();
			if(params==false){return false;}
			var urlstr=buildParamsSqlByS('tsdBilling','exe','xml','paramSet.add','');	
			urlstr+=params;
					
			//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
			$.ajax({
			url:'mainServlet.html?'+urlstr+'&talbename='+tables[tabStatus-1],
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
				success:function(msg){
						if(msg=="true"){
							var operationtips = $("#operationtips").val();
							var successful = $("#successful").val();
							jAlert(successful,operationtips);
												
							//写入日志操作
							var fieldname = ['Kemu','Zdm','Yywjm','Sm'];
							var str = '';
							for(var i=0;i<fieldname.length;i++){											
						 		str += $("#"+fieldname[i]+"g").html()+": "+delTrim($("#"+fieldname[i]).val())+";";
					 		}
					 		logwrite(1,str);	
								
							if(saves==2){
								querylist(0);
								setTimeout($.unblockUI, 15);
							}else{
								closeflash=true;//表示关闭时需要刷新									
								clearText('operformT1');
							}
					
					}
				}
			});	
}

/**
  * 删除
  * @param key(唯一标识)
  * @return 无返回值
  */
function deleteRow(key){
	var deleteright = $("#deleteright").val();
	if(deleteright=="true"){		
					queryByID(key);	
				 	var deleteinformation = $("#deleteinformation").val();
					var operationtips = $("#operationtips").val();
				 	jConfirm(deleteinformation,operationtips,function(x){
				 		 if(x==true){
				 		 	var urlstr1=buildParamsSqlByS('tsdBilling','exe','xml','paramSet.deleteByKey','');
							var urlstr='mainServlet.html?'+urlstr1+'&Xh='+key+'&talbename='+tables[tabStatus-1]; 
							$.ajax({
								url:urlstr,
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
										var operationtips = $("#operationtips").val();
										var successful = $("#successful").val();
										jAlert(successful,operationtips);
										setTimeout($.unblockUI, 15);
										
										//写入日志操作
										var fieldname = ['Xh','Kemu','Zdm','Yywjm','Sm'];
										var str = '';
										for(var i=0;i<fieldname.length;i++){											
									 		str += $("#"+fieldname[i]+"g").html()+": "+delTrim($("#"+fieldname[i]).val())+";";
								 		}										
										logwrite(2,str);
										//fuheQuery();
										querylist(0);
									}	
								}
							});
						}
					});
			
	}else{
		var operationtips = $("#operationtips").val();
		var deletepower = $("#deletepower").val();	
		jAlert(deletepower,operationtips);
	}
}

/**
  * 修改 
  * @param 无参数
  * @return 无返回值
  */
function modifyObj(){
	
			 var params = buildParams();
			 if(params==false){return false;}	
			 	var urlstr=buildParamsSqlByS('tsdBilling','exe','xml','paramSet.modify','');
			 	urlstr+=params;
			 	
				$.ajax({
					url:'mainServlet.html?'+urlstr+'&talbename='+tables[tabStatus-1],
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							//操作提示国际化
							var operationtips = $("#operationtips").val();
							//操作成功
							var successful = $("#successful").val();
							jAlert(successful,operationtips);
							/*************
							** 释放资源 **
							************/							
							setTimeout($.unblockUI, 15);
							//写入日志操作
							var logoldstr = $("#logoldstr").val();	
							var oldstr = logoldstr.split(',');
							
							var fieldname = ['Zdm','Yywjm','Sm'];
							var str = '';
							//关键字信息	//'Xh',
							str += $("#Xhg").html()+": "+$("#Xh").val()+";";
							str += $("#Kemug").html()+": "+oldstr[4]+">>>"+$("#Kemu").val()+";";
							for(var i=0;i<fieldname.length;i++){						 		
					 			var valStr = delTrim($("#"+fieldname[i]).val());
					 			if(valStr!=oldstr[i]){
					 				str += $("#"+fieldname[i]+"g").html()+": "+oldstr[i]+">>>"+valStr+";";
				 				}			 			
					 		}					
							
							logwrite(3,str);
							//fuheQuery();
							querylist(0);
						}	
					}
				});	
}
  
/**
  * 执行复合查询出提交过来的相应操作
  * @param 无参数
  * @return 无返回值
  */           
function fuheExe()
{		
	fuheQuery();
}

/**
  * 导出或打印查询语句
  * @param key(唯一标识)
  * @return 无返回值
  */   
function querylist(key){
		//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
		$("#fusearchsql").val("");
		var link='';
		switch(tabStatus){
			case 1:
				var column = $("#ziduansF1").val();
				var urlstr=buildParamsSqlByS('tsdBilling','query','xml','paramSet.query','paramSet.querypage');											
				link=urlstr+'&column='+column;
				break;
			case 2:	
				var column = $("#ziduansF2").val();
				var urlstr=buildParamsSqlByS('tsdBilling','query','xml','paramSet.query','paramSet.querypage');
				link=urlstr+'&column='+column;
				break;
		}
		$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&talbename='+tables[tabStatus-1]}).trigger("reloadGrid");
		setTimeout($.unblockUI, 15);
		closeo();
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
		var column='';
		switch(tabStatus){
				case 1:
					column = $("#ziduansF1").val();
					break;
			case 2:
					column = $("#ziduansF2").val();
					break;
		}////switch end	
		var urlstr=buildParamsSqlByS('tsdBilling','query','xml','paramSet.fuheQueryByWhere','paramSet.fuheQueryByWherepage');		
		var link = urlstr + params;
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column+'&talbename='+tables[tabStatus-1]}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板
	 	closeo();			
}

/**
  * 组合排序
  * @param sqlstr(排序条件)
  * @return 无返回值
  */
function zhOrderExe(sqlstr){
			var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
			params =params+'&orderby='+sqlstr;			    
	 		
			var urlstr1=buildParamsSqlByS('tsdBilling','query','xml','paramSet.queryByOrder','paramSet.queryByOrderpage');
			var column='';
			switch(tabStatus){
	 			case 1:
						column = $("#ziduansF1").val();
						break;
				case 2:
						column = $("#ziduansF2").val();
						break;
			}////switch end			
			var link = urlstr1 + params;	
			
	 		$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column+'&talbename='+tables[tabStatus-1]}).trigger("reloadGrid");
	 		//setTimeout($.unblockUI, 15);//关闭面板
}

/**
  * 新增弹出的对话框
  * @param 无参数
  * @return 无返回值
  */
function openadd(){
		markTable(0);//显示红色*号
		$(".top_03").html('<fmt:message key="global.add" />');//标题								
		removeDisabledN('t170_qf_cxyysz','','');
		openpan();
		$("#save1").show();
		$("#readd1").show();
		clearText('operformT1');
		$('#Xh').attr("disabled","disabled");
		$("#Xh").removeClass();
		$("#Xh").addClass("textclass2");				
}

/**
  * 打开修改面板并加载将要修改的数据
  * @param key(唯一标识)
  * @return 无返回值
  */
function openRowModify(key){
		//判断是否有权限
		var editright = $("#editright").val();
		if(editright=="true"){							
			markTable(0);//显示红色*号
			var editinfo = $("#editinfo").val();
		 	$(".top_03").html(editinfo);//设置编辑框的标题
			
			isDisabledN('t170_qf_cxyysz','',''); //将修改面板的输入框全部	置为不可用
			openpan();//显示修改面板
			$("#modify1").show();$("#reset1").show();
			clearText('operformT1');//清空修改面板		
					
			queryByID(key);//取出数据库中改条记录，并放到修改面板中				
			setTableFields();	
					
			$('#Xh').attr("disabled","disabled");
			$("#Xh").removeClass();
			$("#Xh").addClass("textclass2");
		}
		else{
			var operationtips = $("#operationtips").val();
			var editpower = $("#editpower").val();
			jAlert(editpower,operationtips);
		}
		
}

/**
  * 添加修改参数获取
  * @param 无参数
  * @return String
  */
function buildParams(){
	var operationtips = $("#operationtips").val();
   
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;				
		 	var params='';
			//Xh  Kemu Zdm  Yywjm Sm
		 	var Xh = $("#Xh").val();
		 	var Kemu = $("#Kemu").val();
		 	var Zdm = $("#Zdm").val().replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	var Yywjm = $("#Yywjm").val().replace(/(^\s*)|(\s*$)/g,"");
		 	var Sm = $("#Sm").val().replace(/(^\s*)|(\s*$)/g,"");
		 	
		 	
		  	//必填 varchar
		 	if(Kemu==null||Kemu==""){		  		
		  		alert("<fmt:message key='tariff.input'/>"+$("#Kemug").html());
		  		$("#Kemu").focus();
		  		return false;
		  	}		  	
		  	params=params+"&Xh="+Xh;
		  	params=params+"&Kemu="+tsd.encodeURIComponent(Kemu);	
		  	params=params+"&Zdm="+tsd.encodeURIComponent(Zdm);	
		  	params=params+"&Yywjm="+tsd.encodeURIComponent(Yywjm);	
		  	params=params+"&Sm="+tsd.encodeURIComponent(Sm);		  		
		  	
		 	//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
			
}

/**
  * 复合查询参数获取
  * @param 无参数
  * @return String
  */
function fuheQbuildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
	 	var params='';
	 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());
	 	
	 	//如果有可能值是汉字 请使用encodeURI()函数转码
	 	params+='&fusearchsql='+fusearchsql;			 	
	 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
	 	//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}

/**
  * 字段权限控制
  * @param 无参数
  * @return 无返回值
  */
function setTableFields(){
		switch(tabStatus){
				case 1:
						var editfields = $("#editfields").val();						
						/*************************************
						**   将当前表的所有字段取出来，分割字符串 ***
						*************************************/
						var fields = getFields("t170_qf_cxyysz");
						var fieldarr = fields.split(",");
						/**********************************
						**   将当前表中的spower字段取出来 *****
						**********************************/
						var spower = editfields.split(",");
						/***************************
						**  考虑字段大小写问题   *****
						*************************/
						
						var atr = '';
						for(var i = 0 ; i <spower.length;i++){
							atr+=spower[i]+'@';	
						}
						var atrarr = atr.split('@');
						var arr = atrarr.sort();
						
						if(arr.length>0){
							for(var i=1;i<arr.length;i++){
								for(var j = 0 ; j <fieldarr.length-1;j++){
									if(arr[i]==fieldarr[j]){										
										$('#'+arr[i]).removeAttr("disabled");						
										$("#"+arr[i]).removeClass();
										$("#"+arr[i]).addClass("textclass");											
										break;
									}
								}
							}
						}	
					break;
				case 2:
					
					var editfields = $("#editfields_son").val();
					/*************************************
					**   将当前表的所有字段取出来，分割字符串 ***
					*************************************/
					var fields = getFields("t170_jy_cxyysz");
					var fieldarr = fields.split(",");
					/**********************************
					**   将当前表中的spower字段取出来 *****
					**********************************/
					var spower = editfields.split(",");
					/***************************
					**  考虑字段大小写问题   *****
					*************************/
					var atr = '';
					for(var i = 0 ; i <spower.length;i++){
						atr+=spower[i]+'@';	
					}
					var atrarr = atr.split('@');
					var arr = atrarr.sort();
					if(arr.length>0){
						for(var i=1;i<arr.length;i++){
							for(var j = 0 ; j <fieldarr.length-1;j++){
								if(arr[i]==fieldarr[j]){									
									$('#'+arr[i]).removeAttr("disabled");						
									$('#'+arr[i]).removeClass();
									$('#'+arr[i]).addClass("textclass");													
									break;
								}
							}
						}
					}	
					break;		
		}			
}

/**
  * 打印	
  * @param 无参数
  * @return 无返回值
  */
function PrintB()
{
	printThisReport1('<%=request.getParameter("imenuid")%>',pkeys[tabStatus-1],getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
}

/**
  * 写入日志方法
  * @param str：操作的方式 1 添加 、2 删除 、3 修改、4 批量删除 、5 批量修改
  * @param code：写入日志表的内容
  * @return 返回 true 操作成功 false 操作失败
  */
function logwrite(status,content){		
		tsd.QualifiedVal=true; 	
		switch(status){
			case 1:
			///增加
					writeLogInfo("","add",tsd.encodeURIComponent(tables[tabStatus-1]+"<fmt:message key='global.add' />。"+content));				
					break;
			case 2:
			///删除
					writeLogInfo("","delete",tsd.encodeURIComponent(tables[tabStatus-1]+"<fmt:message key='global.delete' />。"+content));
					break;			
			case 3:
			///修改
					writeLogInfo("","modify",tsd.encodeURIComponent(tables[tabStatus-1]+"<fmt:message key='global.edit' />。"+content));
					break;			
			}
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
}

</script>
<script type="text/javascript">
/**
  * 关闭表格面板
  * @param 无参数
  * @return 无返回值
  */
function closeo(){
		if(closeflash){
		 		 closeflash=false;
		 		 querylist(0);	
		 }
		clearText('operformT1');	
		setTimeout($.unblockUI, 15);//关闭面板				
}

/**
  * 打开表格面板
  * @param 无参数
  * @return 无返回值
  */
function openpan(){	
	autoBlockFormAndSetWH('panTab1',60,5,'closeo1',"#ffffff",true,1000,'');//弹出查询面板
	$("#jdquery1").hide();$("#modifyB1").hide();$("#readd1").hide();$("#save1").hide();$("#modify1").hide();$("#reset1").hide();$("#clearB1").hide();
}

/**
  * 修改单挑记录时的信息重置方法
  * @param 无参数
  * @return 无返回值
  */
function resett(){
		var key='';
		key=$("#Xh").val();		
		queryByID(key);
}	
</script>
<script type="text/javascript">
/**
  * 打开组合排序面板
  * @param 无参数
  * @return 无返回值
  */
function openwinO(){
		switch(tabStatus){
 			case 1:
					openDiaO('t170_qf_cxyysz');
					break;
			case 2:
					openDiaO('t170_jy_cxyysz');
					break;
		}////switch end					
}

/**
  * 打开复合面板
  * @param str
  * @return 无返回值
  */	
function openfuh(str){
		switch(tabStatus){
				case 1:
				openDiaQueryG(str,'t170_qf_cxyysz');
				break;
			case 2:
				openDiaQueryG(str,'t170_jy_cxyysz');
				break;
		}////switch end	
}

 /**
 * 打开保存本次查询面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @return 
 */	
function openSaveModPan(){
		switch(tabStatus){
				case 1:
				openModT('t170_qf_cxyysz');
				break;
			case 2:
				openModT('t170_jy_cxyysz');
				break;
		}////switch end					
}

/**
  * 打开复合查询面板	
  * @param 无参数
  * @return 无返回值
  */		
function openwinQ()
{
		openfuh("query");
}

/**
  * 打开复合删除面板		
  * @param 无参数
  * @return 无返回值
  */		
function openwinD()
{
		openfuh("delete");
}

/**
  * 打开复合修改面板			
  * @param 无参数
  * @return 无返回值
  */	
function openwinM()
{
		openfuh("modify");
}

/**
  * 保存本次高级查询方法		
  * @param 无参数
  * @return 无返回值
  */	
function addQuery(){
	//saveQuery(tabStatus);
	saveModQuery(tabStatus);
}

/**
  * 模板查询		
  * @param 无参数
  * @return 无返回值
  */
function modQuery(){	
	 openQueryM(tabStatus);
}

/**
  * 导出数据面板确定按钮事件	
  * @param 无参数
  * @return 无返回值
  */
function saveExoprt(){
		switch(tabStatus){
			case 1:			
					getTheCheckedFields('tsdBilling','mssql','t170_qf_cxyysz');		
					break;
			case 2:	
					getTheCheckedFields('tsdBilling','mssql','t170_jy_cxyysz');
					break;
		}
 }
 
 /**
  * 打开导出数据面板
  * @param 无参数
  * @return 无返回值
  */
 function openExport(){
 		switch(tabStatus){
			case 1:			
					thisDownLoad('tsdBilling','mssql','t170_qf_cxyysz','<%=languageType %>');				
					break;
			case 2:			
					thisDownLoad('tsdBilling','mssql','t170_jy_cxyysz','<%=languageType %>');	
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
		
		
	<div id="zong" >
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder1" onclick="openwinO();">
			<!--排序--><fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd1" onclick="openadd();" disabled="disabled">
			<!--添加--><fmt:message key="global.add" />
	    </button>
		<button onclick='modQuery();' id='mbquery1'>
			<fmt:message key="oper.mod"/>
		</button>
		<button type="button" id='gjquery1' onclick="openwinQ();" disabled="disabled">
			<!--高级查询--><fmt:message key="oper.queryA"/>
		</button>
		<button type="button" id='savequery1' onclick="openSaveModPan();" disabled="disabled">
			<!--保存本次查询--><fmt:message key="oper.modSave"/>
		</button>
		<button type="button" id="export1" onclick="openExport();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>					
		<button type="button" id="print1" onclick="PrintB();" disabled="disabled">
			<!--打印--><fmt:message key="tariff.printer" />
		</button>   
	</div>
	<!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span>170费用查询参数设置</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span>170结余查询参数设置</span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder2" onclick="openwinO();">
			<!--排序--><fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd2" onclick="openadd();" disabled="disabled">
			<!--添加--><fmt:message key="global.add" />
	    </button> 
		<button onclick='modQuery();' id='mbquery2'>
			<!--模板查询--><fmt:message key="oper.mod"/>
		</button>
		<button type="button" id='gjquery2' onclick="openwinQ();" disabled="disabled">
			<!--高级查询-->
			<fmt:message key="oper.queryA"/>
		</button>
		<button type="button" id='savequery2' onclick="openSaveModPan();" disabled="disabled">
			<!--保存本次查询--><fmt:message key="oper.modSave"/>
		</button>
		<button type="button" id="export2" onclick="openExport();" disabled="disabled"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>					
		<button type="button" id="print2" onclick="PrintB();" disabled="disabled">
			<!--打印--><fmt:message key="tariff.printer" />
		</button>
	</div>
</div>	
	
	
	

<!-- 添加模板面板 -->
<div id="modT" name='modT' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
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
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>	


<!-- 添加修改面板 read1 -->
<div class="neirong" id="panTab1" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
			<input type="hidden" ></input>
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  <tr>	
			    <input type="hidden" name="Xh" id="Xh" class="textclass"></input>	
			    <td width="12%" align="right"  class="labelclass"><label  id="Kemug"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<select name="Kemu" id="Kemu" class="textclass" >
						<option value="" ><fmt:message key="global.select"/></option>						
					</select>	
			    	<label class="addred" ></label>	
			    	</td>			
			
			    <td width="12%" align="right" class="labelclass"><label id="Zdmg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="Zdm" id="Zdm" onpropertychange="TextUtil.NotMax(this)" maxlength="200" class="textclass"/></td>				  	
				<td width="12%" align="right" class="labelclass"><label id="Yywjmg"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Yywjm" id="Yywjm" onpropertychange="TextUtil.NotMax(this)" maxlength="200" class="textclass"/></td>
			</tr>
		  
		  	<tr>
			    <td width="12%" align="right" class="labelclass"><label id="Smg"  ></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Sm" id="Sm" onpropertychange="TextUtil.NotMax(this)" maxlength="200" class="textclass"/></td>
								    
			    <td width="12%" align="right" class="labelclass"><label id=""  ></label></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    	</td>	
		    	
		    	<td width="12%" align="right" class="labelclass"><label id=""  ></label></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
		    	</td>	       	
		    	
		 	 </tr>	
		  
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery1" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
		<!-- 批量修改 --><button class="tsdbutton" id="modifyB1" style="width:80px;heigth:27px;" onclick="fuheModify();"><fmt:message key="tariff.modifyb" /></button>
		<!-- 保存新增 --><button class="tsdbutton" id="readd1" style="width:80px;heigth:27px;" onclick="saveObj(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save1" style="width:80px;heigth:27px;" onclick="saveObj(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify1" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB1" style="width:63px;heigth:27px;" onclick="clearText('operformT1');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset1" style="width:63px;heigth:27px;" onclick="resett();" >取消</button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo1" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>

<!-- typtDemoModify  表单输入区域  -->
	
	
<form name="childform" id="childform">
	<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
</form>

<input type="hidden" id="useridd" value="<%=userid %>"/>
<!-- 语言 -->
<input type="hidden" id="lanType" name="lanType" value='<%=lanType %>' />

<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 

					<input type="hidden" id="addinfo"
						value="<fmt:message key="global.add"/>" />
					<input type="hidden" id="deleteinfo"
						value="<fmt:message key="global.delete"/>" />
					<input type="hidden" id="editinfo"
						value="<fmt:message key="global.edit"/>" />
					<input type="hidden" id="queryinfo"
						value="<fmt:message key="global.query"/>" />

					<input type="hidden" id="operation"
						value="<fmt:message key="global.operation"/>" />
					<input type="hidden" id="operationtips"
						value="<fmt:message key="global.operationtips"/>" />
					<input type="hidden" id="successful"
						value="<fmt:message key="global.successful"/>" />
					<input type="hidden" id="deleteinformation"
						value="<fmt:message key="global.deleteinformation"/>" />
						
					
					<input type="hidden" id="worninfo"
						value="<fmt:message key="zhji.zjjxonly"/>" />
					<input type="hidden" id="worntips"
						value="<fmt:message key="powergroup.worntips"/>" />
						
					<input type="hidden" id="deletepower"
						value="<fmt:message key="global.deleteright"/>" />
					<input type="hidden" id="editpower"
						value="<fmt:message key="global.editright"/>" />
					
					<input type="hidden" id="zhjititle"
						value="<fmt:message key="tariff.zhji" />" />
					<input type="hidden" id="addright"/>					
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="editright"/>
					<input type="hidden" id="editfields"/>
					<input type="hidden" id="editfields_son"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editBright"/>
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />
					<!-- 存储sql语句查询部分 -->
					<input type="hidden" id="thecolumn" />
					
					<!--写日志 -->
					<input type="hidden" id="logoldstr" />
				
					<input type="hidden" id="mptitle" value="<%=imenuname %>"/>
					<!-- 打印报表 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
					
					<!-- 高级查询 模板隐藏域 -->
					<input type="hidden" id="queryright"/>
					<input type="hidden" id="queryMright"/>
					<input type="hidden" id="saveQueryMright"/>	
					<!-- 查询树信息存放 -->
					<input type="hidden" id='treepid' />	
					<input type="hidden" id='treecid' />	
					<input type="hidden" id='treestr' />	
					<input type="hidden" id='treepic' />	
					<!-- grid自动 -->
					<input type="hidden" id='ziduansF1' />
					<input type="hidden" id='ziduansF2' />
					<input type='hidden' id='thecolumn'/>
										

		
			<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">选择您要导出的数据字段</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a></div>
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
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields();">
						全选
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
