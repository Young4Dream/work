<%----------------------------------------
	name: phoneChange.jsp
	author: youhongyu
	version: 1.0, 2009-11-26
	description: 电话换号记录 Phone Change
	modify: 
		2010-01-18 youhongyu 更改导出模块 
		2010-01-20 youhongyu grid字段可控 验证方法
		2010-03-08 youhongyu 更改grid样式 面板的弹出方式
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
    <title> Phone Change</title>
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
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		<script type="text/javascript">
			/**
			 * 查看当前用户的扩展权限，对spower字段进行解析
			 * @param 无参数
			 * @return 无返回值
			 */
			function getUserPower(){
				 var urlstr=buildParamsPro("phoneChange.getPower","query");
				
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
				//用于换号
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
						
						//editfields = getFields('qhyt_bj');
						
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
			
			/**
			 * 页面初始化
			 * @param 无参数
			 * @return 无返回值
			 */
			jQuery(document).ready(function () {
			
			//页面头部 用于显示当前所在位置
			//getNavit();
			$("#navBar").append(genNavv());
			//初始化换号日期
			var dated = getDateS();
			$("#ChangeTime").val(dated);
			/**********************
			**   取得当前用户的权限  *
			**********************/
			getUserPower();
			/*********************************
			*  用户权限判定，初始化用户可操作权限 *
			*******************************/
			
			var addright = $("#addright").val();
			var delBright = $("#delBright").val();
			var editBright = $("#editBright").val();
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
			/****************
			if(addright=="true"){
				document.getElementById("openadd1").disabled=false;
				document.getElementById("openadd2").disabled=false;
			}
			if(delBright=="true"){
				document.getElementById("opendel1").disabled=false;
				document.getElementById("opendel2").disabled=false;
			}
			******************/
			if(editBright=="true"){
				document.getElementById("changeTel").disabled=false;
				
			}
			
			if(exportright=="true"){
				document.getElementById("export1").disabled=false;
				document.getElementById("export2").disabled=false;
			}
			if(printright=="true"){
				document.getElementById("print1").disabled=false;
				document.getElementById("print2").disabled=false;
			}
			
			var column  = '';
			var thisdata = loadData('dh_change','<%=languageType %>',2);
			column = thisdata.FieldName.join(',');			
			$("#cols").val(column);
			var col=[[],[]];
			col=getRb_Field('dh_change','Dh',"详细",'70','ziduansF');//得到jqGrid要显示的字段
			var column = $("#ziduansF").val();
							
			//Dh,NewDh0,NewDh,ChangeTime
			var Dhg = thisdata.getFieldAliasByFieldName('Dh');
			var NewDh0g = thisdata.getFieldAliasByFieldName('NewDh0');
			var NewDhg = thisdata.getFieldAliasByFieldName('NewDh');
			var ChangeTimeg = thisdata.getFieldAliasByFieldName('ChangeTime');	
			
			$("#Dhg_a").html(Dhg);
			$("#NewDh0g_a").html(NewDh0g);
			$("#NewDhg_a").html(NewDhg);
			$("#ChangeTimeg_a").html(ChangeTimeg);
			
			$("#Dhg_s").html(Dhg);
			$("#NewDh0g_s").html(NewDh0g);
			$("#NewDhg_s").html(NewDhg);
			$("#ChangeTimeg_s").html(ChangeTimeg);
			// Dh,NewDh0,NewDh,ChangeTime	
			/////设置命令参数
			var urlstr= buildParamsSql('query','xml','phoneChange.query','phoneChange.querypage');
			
			//grid标题获取
			var navv = document.location.search;
			var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));		
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0],
				colModel:col[1],
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Dh', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:infoo, 
				       	height:200, //高
				       //	width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										///自动适应 工作空间
										//var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										//setAutoGridHeight("editgrid",reduceHeight);
										//setAutoGridWidth("editgrid",'0');
										/*********定义需要的行链接按钮************
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										//addRowOperBtn('editgrid',editinfo,'openRowModify','Dh','click',1);
										//addRowOperBtn('editgrid',deleteinfo,'deleteRow','Dh','click',2);
									  
									 	//addRowOperBtnimage('editgrid','openRowModify','Dh','click',1,"images/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
										//addRowOperBtnimage('editgrid','deleteRow','Dh','click',2,"images/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openRowInfo','Dh','click',1,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;");//详细
										
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
										executeAddBtn('editgrid',1);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var Dh =$("#editgrid").getCell(ids,"Dh");
													openRowInfo(Dh);
												}
										}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
			});


			/**
			 * 显示详细信息
			 * @param key
			 * @return 无返回值
			 */
function openRowInfo(key){
		//markTable(1);//显示红色*号	
		//设置编辑框的标题
		$(".top_03").html("详细信息");//标题	
	 	//将修改面板的输入框全部	置为不可用		
		isDisabledN('dh_change','','_s'); 
		clearText('operformT1');
		queryByID(key);
		openpan();
}
		

			/**
			 * 取出一条数据显示在修改面板中
			 * @param key
			 * @return 无返回值
			 */
function queryByID(key){  
 		$("#Dh_s").val(key);	
		var urlstr=tsd.buildParams({  
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdcf:'mssql',//指向配置文件名称
							  tsdoper:'query',//操作类型 
							  datatype:'xmlattr',//返回数据格式 
							  tsdpk:'phoneChange.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							});	
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&Dh='+key,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
				$(xml).find('row').each(function(){
				
					//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
					///如果sql语句中指定列名 则按指定名称给参数
					// Dh,NewDh0,NewDh,ChangeTime
					var Dh = $(this).attr("dh");							
					$("#Dh_s").val(Dh);
					
					var NewDh0 = $(this).attr("newdh0");
					$("#NewDh0_s").val(NewDh0);
				
					var NewDh = $(this).attr("newdh");
					$("#NewDh_s").val(NewDh);
					
					var ChangeTime = $(this).attr("changetime");
					$("#ChangeTime_s").val(ChangeTime);	
					
				});
			}
		});
}
						
			
			/**
			 * 组合排序
			 * @param sqlstr
			 * @return 无返回值
			 */
			function zhOrderExe(sqlstr){
					var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
					params =params+'&orderby='+sqlstr;	
					////var params ='&orderby='+sqlstr;			    
				 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1= buildParamsSql('query','xml','phoneChange.queryByOrder','phoneChange.queryByOrderpage');
				 	//拼接sql语句的查询字段
				 	//var colsStr= "'viewOperation' as 'oper',";
					//var colsStr = $("#cols").val();
					var column = $("#ziduansF").val();
				 	var link = urlstr1 + params+'&column='+column;	
					$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			}
			
			/**
			 * 复合查询参数获取
			 * @param 无参数
			 * @return 无返回值
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
			 * 复合查询操作
			 * @param 无参数
			 * @return 无返回值
			 */
			function fuheQuery()
			{
				var params = fuheQbuildParams();			
				if(params=='&fusearchsql='){
					params +='1=1';
				}	
						
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=buildParamsSql('query','xml','phoneChange.fuheQueryByWhere','phoneChange.fuheQueryByWherepage');
			 	//拼接sql语句的查询字段
				//var colsStr= "'viewOperation' as 'oper',";
				//var colsStr = $("#cols").val();
				var column = $("#ziduansF").val();
			 	var link = urlstr1 + params+'&column='+column;	
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板			
			}
			/**
			 * 执行复合查询出提交过来的相应操作
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
					fuheOpenModify();
				}
				else
				{
					fuheQuery();
				}
			}
			/**
			 * 获取换号参数
			 * @param 无参数
			 * @return 无返回值
			 */
			function buildParams(){
			 	//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;				
			 	var params='';
			 	
			 	var OldTel = delTrim($("#OldTel").val());
			 	var NewTel = delTrim($("#NewTel").val());
			 	var ChangeTime = $("#ChangeTime").val();
			 				 					
			 	if(OldTel!=""&&!checkTel(OldTel)){
				 		if(!isTelY(OldTel)){
				 			alert($("#OldTelg").html()+"<fmt:message key='global.invalid'/>");
		  					$("#OldTel").focus();
		  					return false;
				 		}		  			
		  		}
		  		else if(OldTel==""){
		  			alert("<fmt:message key='tariff.input'/>"+$("#OldTelg").html());
		  			$("#OldTel").focus();
		  			return false;
		  		}
		  		if(NewTel!=""&&!checkTel(NewTel)){
		  			if(!isTelY(NewTel)){
				 			alert($("#NewTelg").html()+"<fmt:message key='global.invalid'/>");
				  			$("#NewTel").focus();
				  			return false;
				 	}		  			
		  		}else if(NewTel==""){
		  			alert("<fmt:message key='tariff.input'/>"+$("#NewTelg").html());
		  			$("#NewTel").focus();
		  			return false;
		  		}
			  	 	/***********************/
				 	//如果有可能值是汉字 请使用encodeURI()函数转码
				 	params+="&OldTel="+OldTel;			 		
			 	 	//如果有可能值是汉字 请使用encodeURI()函数转码
			 		params+="&NewTel="+NewTel;
			 	 	//如果有可能值是汉字 请使用encodeURI()函数转码
			 		params+="&ChangeTime="+ChangeTime;
			 	 	
				//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				return params;
			 }			 
			/**
			 * 换号操作
			 * @param 无参数
			 * @return 无返回值
			 */
			function changeObj(){
				var params=buildParams();
				if(params==false){return false;}
				var changeTel = '<fmt:message key="phoneChange.changePhone" /><fmt:message key="global.operation" />';
				var operationtips = $("#operationtips").val();
				jConfirm(changeTel,operationtips,function(x){
					if(x==true){
						/***************************
						*     判断完成，进行保存操作   *
						***************************/
							var	Res ='';														
							var urlstr = tsd.buildParams({
						        packgname : 'service', 
						        clsname : 'Procedure', 
						        method : 'exequery', 
						        ds : 'tsdBilling', //数据源名称 对应的spring配置的数据源
						        tsdpname : 'phoneChange.ProChangeTelTrigger', //存储过程的映射名称
						        tsdExeType : 'query', 
						        datatype : 'xmlattr' 
    						});
							urlstr+=params;
							$.ajax({
									url:'mainServlet.html?'+urlstr,
									datatype:'xmlattr',
									cache:false,//如果值变化可能性比较大 一定要将缓存设成false
									timeout: 1000,
									async: false ,//同步方式
									success:function(xml){
									
										$(xml).find('row').each(function(){
											Res = $(this).attr("res");
											var operationtips = $("#operationtips").val();
											var successful = $("#successful").val();
											if(Res==''||Res==undefined||Res=='undefined'){
												jAlert(successful,operationtips);
												var imenuname =$("#imenuname").text();
												var str = '';
												str="(Pro_ChangeTel_Trigger)<fmt:message key='phoneChange.changePhone' />。"+$("#OldTelg").text()+":"+$("#OldTel").val()+";"+$("#NewTelg").text()+":"+$("#NewTel").val()+";"+$("#ChangeTimeg").text()+":"+$("#ChangeTime").val();
												var method ="<fmt:message key='phoneChange.changePhone' />";
												//写入日志操作
												writeLogInfo("",tsd.encodeURIComponent(method),tsd.encodeURIComponent(str));				
											}
											else{
												jAlert(Res,operationtips);
											}
											setTimeout($.unblockUI, 15);
											
										});
									}
							});
						 //clearText('operform');
						 var dated = getDateS();
						 $('#ChangeTime').val(dated);
						 fuheQuery();
					}	
				});	
			}
	




			/**
			 * 打开查询面板
			 * @param 无参数
			 * @return 无返回值
			 */
function openQuery(){		
	 	$(".top_03").html('<fmt:message key="global.query" />');//标题		
	 	openQueryT();
		$('#jdquery').show();
		clearText('queryform');
}
 			/**
			 * 通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 			   @oper 操作类型 modify|save
			 * @param 无参数
			 * @return 无返回值
			 */
 function QbuildParams(){
 	// Dh,NewDh0,NewDh,ChangeTime
 	var Dh = delTrim($("#Dh_a").val());
 	var NewDh0 = delTrim($("#NewDh0_a").val());
 	var NewDh = delTrim($("#NewDh_a").val());	
 	var ChangeTime = $("#ChangeTime_a").val();	
 			 
	var paramsStr='1=1 ';
 	if(Dh!=''){
 	 	paramsStr+="and Dh like '%"+Dh+"%' ";
 	}
 	if(NewDh0!=''){
 		paramsStr+="and NewDh0 like '%"+NewDh0+"%' " ;
 	}
 	if(NewDh!=''){
 		paramsStr+="and NewDh like '%"+NewDh+"%' " ;
 	}
 	if(ChangeTime!=''){
 		paramsStr+=" and CONVERT(VARCHAR(30),ChangeTime,120) like '%"+ChangeTime+"%' ";
 	}
 	
 	$("#fusearchsql").val(paramsStr);
 	fuheQuery();
 }	
			/**
			 * 重新加载jQuery
			 * @param key
			 * @return 无返回值
			 */
function querylist(key){

		//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
		$("#fusearchsql").val("");				
		
	 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
	 	var urlstr1=buildParamsSql('query','xml','phoneChange.query','phoneChange.querypage');
	 	//拼接sql语句的查询字段
		//var colsStr = $("#cols").val();
		var column = $("#ziduansF").val();
	 	var link = urlstr1 +'&column='+column;	
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板		
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
		autoBlockFormAndSetWH('queryT',60,5,'closeoquery',"#ffffff",true,1000,'');//弹出查询面板
		
}
			/**
			 * 页面效果
			 * @param 无参数
			 * @return 无返回值
			 */
function CGid(){
	$("#changeID").toggle().show();
	$("#changeID").toggle().hide();
	
}

</script>
	</head>
<style type="text/css"> 
 .style1 {
	background-color:#A9C3E8;
	padding: 4px;		
	}
</style>
<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		</style>
  <body>   
  <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
  </form>
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
			<button type="button" id="order1" onclick="openDiaO('dh_change');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
			<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button id='mbquery1' onclick='openQueryM(1);' >
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery1' onclick="openDiaQ('query','dh_change');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery1' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="export1" onclick="thisDownLoad('tsdBilling','mssql','dh_change','<%=languageType %>')" disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>					
			<button type="button" id="print1" onclick="printThisReport1('<%=request.getParameter("imenuid")%>','dh_change',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>')" disabled="disabled">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>
	</div>	
    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="order2" onclick="openDiaO('dh_change');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>			
			<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button id='mbquery2' onclick='openQueryM(1);' >
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery2' onclick="openDiaQ('query','dh_change');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery2' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="export2" onclick="thisDownLoad('tsdBilling','mssql','dh_change','<%=languageType %>')" disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>					
			<button type="button" id="print2" onclick="printThisReport1('<%=request.getParameter("imenuid")%>','dh_change',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>')" disabled="disabled">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>
	</div>	
	
	
	
	<!-- 简单查询面板 -->
<div id="pan" name='pan' style="display: none"  class="neirong">
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
	<div class="top02right"><img src="style/images/public/neibut01.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="Dhg_s"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Dh_s" id="Dh_s" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id="NewDh0g_s"></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="NewDh_s" id="NewDh_s" class="textclass"/></td>
									    
				    <td width="12%" align="right"  class="labelclass"><label id="NewDhg_s"></label></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="NewDh0_s" id="NewDh0_s" class="textclass"/></td>
			    	
			 	 </tr>	
			 	 <tr >
				    <td width="12%" align="right" class="labelclass"><label id="ChangeTimeg_s"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="ChangeTime_s" id="ChangeTime_s" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
									    
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			    	
			 	 </tr>		 	  
			</table>
		</form>	
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
				<div class="top_03" >功能名称</div>
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
				    	<input type="text" name="Dh_a" id="Dh_a" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id="NewDh0g_a"></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="NewDh_a" id="NewDh_a" class="textclass"/></td>
									    
				    <td width="12%" align="right"  class="labelclass"><label id="NewDhg_a"></label></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="NewDh0_a" id="NewDh0_a" class="textclass"/></td>
			    	
			 	 </tr>	
			 	 <tr >
				    <td width="12%" align="right" class="labelclass"><label id="ChangeTimeg_a"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="ChangeTime_a" id="ChangeTime_a" value="" onfocus="WdatePicker({startDate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
									    
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			    	
			 	 </tr>		 	  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询 --><button class="tsdbutton" id="jdquery" style="width:63px;heigth:27px;" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeoquery" style="width:63px;heigth:27px;" onclick="closeoQuery();" ><fmt:message key="global.close" /></button>
		</div>	
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
	<div class="top02right"><img src="style/images/public/neibut01.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr>
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
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="saveModQuery(1);" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>


	

		<form action="#" name="operform" id="operform" onsubmit="return false;">
			<div id="input-Unit">
				<div  id='dtitle' style="background-color:#EDF8FC;line-height: 30px;margin-bottom: 10px;border-bottom-width: medium; ">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneChange.changePhone" /><fmt:message key="global.operation" />
				</div>
									
				<div id="inputtext">							
							<p><label for="OldTel">
							 <span id="OldTelg"> <fmt:message key="phoneChange.oldTel" /></span><!-- 旧电话号 -->
							</label>
							<input type="text" name="OldTel" id="OldTel" onpropertychange="TextUtil.NotMax(this)" maxlength="16"></input>
							<span style="float:left;line-height:24px;color:#ff0000">*</span>
							
							<label for="NewTel">
							<span id="NewTelg"> <fmt:message key="phoneChange.newTel" /></span>  <!-- 本次改号 -->
							</label>
							<input type="text" name="NewTel" id="NewTel" onpropertychange="TextUtil.NotMax(this)" maxlength="16"></input>
							<span style="float:left;line-height:24px;color:#ff0000">*</span>
							</p>
							<p><label for="ChangeTime">
							 <span id="ChangeTimeg"> <fmt:message key="phoneChange.changeTime" /></span> <!-- 换号时间 -->
							</label> 
							<input type="text" name="ChangeTime" id="ChangeTime"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"></input>
							</p>						
				</div>
			</div>
			<div id="buttons"  align="center">
					
						<button type="submit" id="changeTel" onclick="changeObj();" disabled="disabled">
							<fmt:message key="phoneChange.changePhone" /><!-- 换号 -->
						</button>
						<button type="button" id="close"  onclick="clearText('operform'); var dated = getDateS();$('#ChangeTime').val(dated);">
							 <fmt:message key="global.clear" /><!-- 清空 -->
						</button>
					
			</div>
		</form>			



	<div style="display: none">
					<input type="hidden" id="addinfo" value="<fmt:message key="global.add"/>" />
					<input type="hidden" id="deleteinfo" value="<fmt:message key="global.delete"/>" />
					<input type="hidden" id="editinfo" value="<fmt:message key="global.edit"/>" />
					<input type="hidden" id="queryinfo" value="<fmt:message key="global.query"/>" />

					<input type="hidden" id="operation" value="<fmt:message key="global.operation"/>" />
					<input type="hidden" id="operationtips" value="<fmt:message key="global.operationtips"/>" />
					<input type="hidden" id="successful" value="<fmt:message key="global.successful"/>" />
					<input type="hidden" id="deleteinformation" value="<fmt:message key="global.deleteinformation"/>" />
										
					<input type="hidden" id="worninfo" value="<fmt:message key="zhji.zjjxonly"/>" />
					<input type="hidden" id="worntips" value="<fmt:message key="powergroup.worntips"/>" />
						
					<input type="hidden" id="deletepower" value="<fmt:message key="global.deleteright"/>" />
					<input type="hidden" id="editpower" value="<fmt:message key="global.editright"/>" />
					
					<input type="hidden" id="addright"/>					
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="editright"/>
					<input type="hidden" id="editfields"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editBright"/>
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />			
					<!-- 用于写入日志 -->
				   <input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request) %>"/> 
				   <input type="hidden" id="userloginid" value="<%=session.getAttribute("userid") %>"/> 
				   <input type="hidden" id="thislogtime" value="<%=Log.getThisTime() %>" />
				  
					<!-- 修改时保存原来数据的隐藏域 --> 	
					<input type="hidden" id="logoldstr" />	
					<input type="hidden" id="useridd" value="<%=userid %>"/>		
					<input type="hidden" id="imenuname1" value="<%=imenuname %>"/>	
					
					<!-- 添加隐藏域：用于获取项目的绝对路径 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 		
					<!-- mssql 语句中 查询列表记录 -->
					<input type="hidden" id="cols"/>
					
					<!-- mssql 语句中 查询列表记录 用于下载 -->
					<input type="text" id="121"/>
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
					<!-- grid自动 -->
					<input type="hidden" id='ziduansF' />
					<input type='hidden' id='thecolumn'/>					
	</div>	

		
		
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
					<div class="top02right"><img src="style/images/public/neibut01.gif" /></div>	
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
						全选
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="getTheCheckedFields('tsdBilling','mssql','dh_change');">
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
