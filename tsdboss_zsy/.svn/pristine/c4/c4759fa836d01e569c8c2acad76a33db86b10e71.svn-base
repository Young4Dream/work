<%----------------------------------------
	name: spowerManager.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 对权限设置的管理
	modify: 
		2009-11-26 chenliang  添加功能注释.
        2010-01-08 chenliang  IE6、IE7样式兼容
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>IP-Manager</title>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>

		<!-- 验证框架需要导入的js文件 -->
		<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>

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
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
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
							 					  tsdpname:'spowerManager.getPower',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#userid').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				
				/****************
				*   拼接权限参数 *
				**************/
				
				var addright = '';
				var deleteright = '';
				var editright = '';
				var editfields = '';
				var exportright = '';
				var queryright = '';				
				var saveQueryMright ='';
				var flag = false;
				
				var spower = '';
				
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
				if(spower=='all@'){
						addright = 'true';
						deleteright = 'true';
						editright = 'true';
						exportright = 'true';
						queryright = 'true';				
						saveQueryMright ='true';
						isReadonly(false);
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						
						for(var i = 0;i<spowerarr.length-1;i++){
							addright += getCaption(spowerarr[i],'add','')+'|';
														
							deleteright += getCaption(spowerarr[i],'delete','')+'|';
							
							editright += getCaption(spowerarr[i],'edit','')+'|';	
							
							editfields += getCaption(spowerarr[i],'editfields','');
							
							exportright += getCaption(spower,'export','')+'|';
										
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
							saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
						}
				}
				
				var hasadd = addright.split('|');
				var hasdelete = deleteright.split('|');
				var hasedit = editright.split('|');
				var hasexport = editright.split('|');
				var hasquery = queryright.split('|');
				var hassaveQueryM = saveQueryMright.split('|');
				var str = 'true';
				
				if(flag==true){
					$("#addright").val(addright);
					$("#deleteright").val(deleteright);
					$("#editright").val(editright);
					$("#exportright").val(editright);
					$("#queryright").val(queryright);
					$("#saveQueryMright").val(saveQueryMright);
				}else{
					for(var i = 0;i<hasadd.length;i++){
						if(hasadd[i]=='true'){
							$("#addright").val(str);
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
						if(hasedit[i]=='true'){
							$("#exportright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasquery.length;i++){
						if(hasquery[i]=='true'){
							$("#queryright").val(str);
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
				
				$("#editfields").val(editfields);
			}
		</script>

		<script type="text/javascript">
			/**************************************
				存储过程操作示例
				-------------------------------
				具体参数请参照《泰思达WEB平台开发手册》
				-------------------------------
			**************************************/
			/**
			 * 页面初始化
			 * @param 无参数
			 * @return 无返回值
			 */
			jQuery(document).ready(function () { 
			$("#navBar1").append(genNavv());
			/**********************
			**   取得当前菜单名称    *
			**********************/
			var management = $("#management").val();
			$("#titlee").html(management);
			
			/**********************
			**   取得当前用户的权限  *
			**********************/
			getUserPower();
			var addright = $("#addright").val();
	
			if(addright=="true"){
				document.getElementById("openadd1").disabled=false;
				document.getElementById("openadd2").disabled=false;
			}
			
			var exportright = $("#exportright").val();
			
			if(exportright=="true"){
				document.getElementById("exp1").disabled=false;
				document.getElementById("exp2").disabled=false;
			}
			var queryright = $("#queryright").val();			
			var saveQueryMright = $("#saveQueryMright").val();
			
			if(queryright=="true"){
				document.getElementById("query1").disabled=false;
				document.getElementById("query2").disabled=false;
			}		
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
			}
				///设置命令参数
			 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xml',//返回数据格式 
						 					tsdpk:'spowerManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'spowerManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 					});
			
			var column  = '';
			//var thisdata = loadData('sys_powerparam','<%=languageType %>',1,'修改|删除');
			var thisdata = loadData('sys_powerparam','<%=languageType %>',1,"<fmt:message key='spowerManager.modifyAndDelete' />");
			column = thisdata.FieldName.join(',');			 					
			
			/***********************************************************
			*这个地方需要判断用的是什么数据库，EDB和ORACLE对INSTR函数处理方式不同
			************************************************************/
			$.ajax ( {
				url : 'mainServlet.html?packgname=service&clsname=DBService&method=service&operate=decideDBType&ds=tsdBilling',
				datatpe:'xml',     
				cache:false,
				timeout: 1000,
				async: false ,
				success:function(data){ 
					 if (data == 'enterprisedb')  {
						column = column.replace('paramalias',"SUBSTR(paramalias,POSITION('<%=languageType %>' IN paramalias)*3-1,POSITION('/}' IN SUBSTR(paramalias,POSITION('<%=languageType %>' IN paramalias)))-POSITION('<%=languageType %>' IN paramalias)-2) paramalias");
						column = column.replace('description',"SUBSTR(description,POSITION('<%=languageType %>' IN description)*3-1,POSITION('/}' IN SUBSTR(description,POSITION('<%=languageType %>' IN description)))-POSITION('<%=languageType %>' IN description)-2)");
					 } else {
						column = column.replace('paramalias',"SUBSTR(paramalias,INSTR(paramalias,'<%=languageType %>')*3-1,INSTR(paramalias,'/}',INSTR(paramalias,'<%=languageType %>'))-INSTR(paramalias,'<%=languageType %>')-3) paramalias");
						column = column.replace('description',"SUBSTR(description,INSTR(description,'<%=languageType %>')*3-1,INSTR(description,'/}',INSTR(description,'<%=languageType %>'))-INSTR(description,'<%=languageType %>')-3)");
					 }
					 
					$('#thecolumn').val(column);
				}
			}) ;
			
			var zhdescription = "<fmt:message key="spower.zhmemo"/>";
			var endescription = "<fmt:message key="spower.enmemo"/>";
			
			var zhalias = "<fmt:message key="spower.zhalias"/>";
			var enalias = "<fmt:message key="spower.enalias"/>";
			
			$('#simenuid').html(thisdata.getFieldAliasByFieldName('imenuid'));
			$('#qimenuid').html(thisdata.getFieldAliasByFieldName('imenuid'));
			
			$('#stype').html(thisdata.getFieldAliasByFieldName('type'));
			$('#qtype').html(thisdata.getFieldAliasByFieldName('type'));
			$('#sdict').html(thisdata.getFieldAliasByFieldName('dict'));
			$('#szhdescription').html(zhdescription);
			$('#sendescription').html(endescription);
			$('#scode').html(thisdata.getFieldAliasByFieldName('paramname'));
			$('#qcode').html(thisdata.getFieldAliasByFieldName('paramname'));
			$('#szhalias').html(zhalias);
			$('#senalias').html(enalias);
			
			thisdata.setWidth({Operation:80});		
			
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&cloumn='+column, 
				datatype: 'xml', 
				colNames:thisdata.colNames, 
				colModel:thisdata.colModels, 
				       	rowNum:15, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'paramname', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:management, 
				       	height:document.documentElement.clientHeight-182,
				       	//width:document.documentElement.clientWidth-52,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										///自动适应 工作空间
										// var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										// setAutoGridHeight("editgrid",reduceHeight);
										
										/*********定义需要的行链接按钮************
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃， 范围：1+	*/
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										//addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" alt="修改"/>','openRowModify','paramname','click',1);
										//addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_02.gif" alt="删除"/>','deleteRow','paramname','click',2);111
										addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" alt="'+'<fmt:message key="spowerManager.modify" />'+'"/>','openRowModify','paramname','click',1,'PAGENAME');
										addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_02.gif" alt="'+'<fmt:message key="spowerManager.delete" />'+'"/>','deleteRow','paramname','click',2,'PAGENAME');
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
			});
			</script>


		<script type="text/javascript">
				/*********************************
				**             添加信息            **
				***********************************/
			
				/**
				 * 弹出增加面板
				 * @param 无参数
				 * @return 无返回值
				 */
				function openText(){
					var addinfo = $("#addinfo").val();
					document.getElementById('code').disabled = false;
					isReadonly(false);
					//tsd.setTitle($("#input-Unit .title h3"),addinfo);
			 		$('#titledivs').html(addinfo);
			 		$("#saveadd").show();
			 		$("#saveexit").show();
			 		autoBlockForm('add',60,'close',"#ffffff",false);//弹出查询面板
			 		$('#dismenutr').hide();
					$("#modify").hide();
					$('#theimenuid_').val(0);
					clearText('operform');
					hideError();//隐藏错误信息 
				}
				
				/**
				 * 拼参数
				 * @param 无参数
				 * @return String
				 */
				function buildParams(){
						//每次拼接参数必须初始化此参数
						tsd.QualifiedVal=true;
						var params='';
						
						var  code = $("#code").val();
						var  imenuid = $("#spowerimenuid").val();
						
						var  zhalias = $("#zhalias").val();
						var  enalias = $("#enalias").val();
						var  dict = $("#dict").val();
						var  type = $("#type").val();
						var  zhdescription = $("#zhdescription").val();
						var  endescription = $("#endescription").val();
						
					 	if(code!=null&&code!=""){
					 			params+="&paramname="+tsd.encodeURIComponent(code);
					 	}else{
						 	var operationtips = $("#operationtips").val();
							//var worninfo = $("#worninfo").val();
							alert('<fmt:message key="spower.iscode"/>',operationtips);
							$('#code').focus();
						 	return false;
						 }
						
						//标识权限所在菜单
						/**
						if(imenuid!=null&&imenuid!=""){
					 			params+="&imenuid="+tsd.encodeURIComponent(imenuid);
					 	}else{
					 		//alert('菜单id不允许为空，不然到时分配权限的时候容易出问题!');
					 		alert("<fmt:message key='spowerManager.idNotNull' />");
					 		return false;
					 	}
						*/
												
						params+="&imenuid=0";		
						var atr = '{zh=';
						var btr = '{en=';
					 	var ctr = '/}';
					 	var codeparam = atr + tsd.encodeURIComponent(zhalias) +ctr+btr+ tsd.encodeURIComponent(enalias) + ctr;
					 		
					 	params+="&paramalias="+codeparam;	
					 	
					 	params+="&dict="+tsd.encodeURIComponent(dict);
					 	if(type==0){
					 		var operationtips = $("#operationtips").val();
							//var worninfo = $("#worninfo").val();
							alert('<fmt:message key="spower.thetype"/>',operationtips);
							$('#type').focus();
						 	return false;
					 	}
					 	params+="&type="+tsd.encodeURIComponent(type);
					 	
					 	var spagename = $("#pagename").val();
					 	if('' == spagename){
					 	  alert('<fmt:message key="spower.htmlName"/>');
					 		//alert('请输入所属页面名称');
							$("#pagename").focus();
							return false;					 		
					 	}else{
					 		params+="&pagenames="+tsd.encodeURIComponent(spagename);
					 	}
					 	params+="&defaultvalues="+tsd.encodeURIComponent($('#defaultvalues').val());
					 	var description = atr +	tsd.encodeURIComponent(zhdescription) + ctr + btr +  tsd.encodeURIComponent(endescription) + ctr;
					 
					 	params+="&description="+description;
					 	
					 	var thestate = $('#thestate').val();
						var theloginfo = '';
						var thetype = '';
						
						var thefieldalias = fetchFieldAlias('sys_powerparam','<%=languageType %>');
						if(thestate==0){
							//添加权限组信息,记录日志
							thetype = 'add';
							theloginfo = "(sys_powerparam)"+tsd.encodeURIComponent("<fmt:message key='global.add'/>")+tsd.encodeURIComponent("<fmt:message key='spower.thespower'/>：");
							theloginfo += tsd.encodeURIComponent(thefieldalias['paramname']) + ':' + tsd.encodeURIComponent(code) + ',';//权限关键字
							theloginfo += tsd.encodeURIComponent(thefieldalias['imenuid']) + ':' + tsd.encodeURIComponent(imenuid) + ',';//权限关键字
							
							if(zhalias!=''&&null!=zhalias){
								theloginfo += tsd.encodeURIComponent('<fmt:message key="spower.zhalias"/>') + ':' + tsd.encodeURIComponent(zhalias)+',';//<fmt:message key="spower.zhalias"/>
							}
							if(enalias!=''&&null!=enalias){
								theloginfo += tsd.encodeURIComponent('<fmt:message key="spower.enalias"/>') + ':' + tsd.encodeURIComponent(enalias)+',';//<fmt:message key="spower.enalias"/>
							}
							theloginfo += tsd.encodeURIComponent(thefieldalias['type']) + ':' + tsd.encodeURIComponent(type) + ',';//值类型
							if(dict!=''&&null!=dict){
								theloginfo += tsd.encodeURIComponent(thefieldalias['dict']) + ':' + tsd.encodeURIComponent(dict)+',';//可选值
							}
							if(zhdescription!=''&&null!=zhdescription){
								theloginfo += tsd.encodeURIComponent('<fmt:message key="spower.zhmemo"/>') + ':' + tsd.encodeURIComponent(zhdescription)+',';//<fmt:message key="spower.zhmemo"/>
							}
							if(endescription!=''&&null!=endescription){
								theloginfo += tsd.encodeURIComponent('<fmt:message key="spower.enmemo"/>') + ':' + tsd.encodeURIComponent(endescription)+',';//<fmt:message key="spower.enmemo"/>
							}
						}else if(thestate==1){
							//修改权限组信息,记录日志
							thetype = 'modify';
							theloginfo = "(sys_powerparam)"+tsd.encodeURIComponent("<fmt:message key='global.edit'/>")+tsd.encodeURIComponent("<fmt:message key='spower.thespower'/>")+code+tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：");
							
							var thearr = getParamInfo(code,0);
							
							if(thearr['paramname']!=code){
								theloginfo += tsd.encodeURIComponent(thefieldalias['paramname']) + ':' + tsd.encodeURIComponent(thearr['paramname']) + '>>>' + tsd.encodeURIComponent(code) +';';
							}
							if(thearr['imenuid']!=imenuid){
								theloginfo += tsd.encodeURIComponent(thefieldalias['imenuid']) + ':' + tsd.encodeURIComponent(thearr['imenuid']) + '>>>' + tsd.encodeURIComponent(imenuid) +';';
							}
							
							if(thearr['zhalias']!=zhalias){
								theloginfo += tsd.encodeURIComponent('<fmt:message key="spower.zhalias"/>') + ':' + tsd.encodeURIComponent(thearr['zhalias']) + '>>>' + tsd.encodeURIComponent(zhalias) +';';
							}
							if(thearr['enalias']!=enalias){
								theloginfo += tsd.encodeURIComponent('<fmt:message key="spower.enalias"/>') + ':' + tsd.encodeURIComponent(thearr['enalias']) + '>>>' + tsd.encodeURIComponent(enalias) +';';
							}
							if(thearr['type']!=type){
								theloginfo += tsd.encodeURIComponent(thefieldalias['type']) + ':' + tsd.encodeURIComponent(thearr['type']) + '>>>' + tsd.encodeURIComponent(type) +';';
							}
							if(thearr['dict']!=dict){
								theloginfo += tsd.encodeURIComponent(thefieldalias['dict']) + ':' + tsd.encodeURIComponent(thearr['dict']) + '>>>' + tsd.encodeURIComponent(dict) +';';
							}
							if(thearr['zhdescription']!=zhdescription){
								theloginfo += tsd.encodeURIComponent('<fmt:message key="spower.zhalias"/>') + ':' + tsd.encodeURIComponent(thearr['zhdescription']) + '>>>' + tsd.encodeURIComponent(zhdescription) +';';
							}
							if(thearr['endescription']!=endescription){
								theloginfo += tsd.encodeURIComponent('<fmt:message key="spower.enalias"/>') + ':' + tsd.encodeURIComponent(thearr['endescription']) + '>>>' + tsd.encodeURIComponent(endescription) +';';
							}
						}
						writeLogInfo('',thetype,theloginfo);
					 	
						//每次拼接参数必须添加此判断
						if(tsd.Qualified()==false){return false;}
						return params;
					}
				/**
				 * 获取页面初始化参数
				 * @param paramname
				 * @param thetype
				 * @return 数组
				 */
				function getParamInfo(paramname,thetype){
					var arr = new Array();
					var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'spowerManager.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&paramname='+paramname,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									var paramname = $(this).attr("paramname");

									var paramalias = $(this).attr("paramalias");
									var zhalias = getCaption(paramalias, 'zh', '');
									var enalias = getCaption(paramalias, 'en', '');

									var type = $(this).attr("type");
									var dict = $(this).attr("dict");
									var imenuid = $(this).attr("imenuid");
									
									var description = $(this).attr("description");
									var zhdescription = getCaption(description, 'zh', '');
									var endescription = getCaption(description, 'en', '');
									
									//在做修改时需要进行判断的值参数
									arr['paramname'] = paramname;
									arr['zhalias'] = zhalias;
									arr['enalias'] = enalias;
									
									arr['type'] = type;
									arr['dict'] = dict;
									arr['imenuid'] = imenuid;
									
									arr['zhdescription'] = zhdescription;
									arr['endescription'] = endescription;
									
									if(thetype==1){
										var theinfo = fetchFieldAlias('sys_powerparam','<%=languageType %>');
										var delinfo = '';
										delinfo += tsd.encodeURIComponent(theinfo['paramname']) + ':' + tsd.encodeURIComponent(paramname) + ';' ;
										delinfo += tsd.encodeURIComponent(theinfo['imenuid']) + ':' + tsd.encodeURIComponent(imenuid) + ';' ;
										delinfo += tsd.encodeURIComponent('<fmt:message key="spower.zhalias"/>') + ':' + tsd.encodeURIComponent(zhalias) + ';' ;
										delinfo += tsd.encodeURIComponent('<fmt:message key="spower.enalias"/>') + ':' + tsd.encodeURIComponent(enalias) + ';' ;
										delinfo += tsd.encodeURIComponent(theinfo['type']) + ':' + tsd.encodeURIComponent(type) + ';' ;
										delinfo += tsd.encodeURIComponent(theinfo['dict']) + ':' + tsd.encodeURIComponent(dict) + ';' ;
										delinfo += tsd.encodeURIComponent('<fmt:message key="spower.zhmemo"/>') + ':' + tsd.encodeURIComponent(zhdescription) + ';' ;
										delinfo += tsd.encodeURIComponent('<fmt:message key="spower.enmemo"/>') + ':' + tsd.encodeURIComponent(endescription) + ';' ;
									
										$('#thedelinfo').val(delinfo);
									}
								});
							}
						});
					return arr;
				}
				
				
				/**
				 * 数据保存
				 * @param thesave(保存状态：1.保存增加；2.保存退出)
				 * @return 无返回值
				 */
				function saveInfo(thesave){
					/****************************************
					*   是否是可输入ID，查看数据库中是否存在此id  *
					****************************************/
					var code = $("#code").val();
					var pagename = $('#pagename').val();
					var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'spowerManager.querycode'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
					$.ajax({
						url:'mainServlet.html?'+urlstr+'&pagenames='+pagename+'&paramname='+code,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							var flag = false;
							$(xml).find('row').each(function(){
								var res = $(this).attr("res");
								if(res>0){
									//alert("对不起，您要添加的权限已存在!");
									alert("<fmt:message key='spowerManager.groupExist' />");
									$('#code').focus();
									flag = true;
								}
							});
							
							if(flag==false){
								$('#thestate').val(0);
								/***************************
								*     判断完成，进行保存操作   * 
								***************************/
								 var params=buildParams();
								 if(params==false){return false;}
								 var urlstr=tsd.buildParams({ 	
								 		 						packgname:'service',//java包
											 					clsname:'ExecuteSql',//类名
											 					method:'exeSqlData',//方法名
											 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
											 					tsdcf:'mssql',//指向配置文件名称
											 					tsdoper:'exe',//操作类型 
											 					tsdpk:'spowerManager.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											 				});
									urlstr+=params;
									$.ajax({
										url:'mainServlet.html?'+urlstr,
										cache:false,//如果值变化可能性比较大 一定要将缓存设成false
										timeout: 1000,
										async: false ,//同步方式
										success:function(msg){
											if(msg=="true"){
												var operationtips = $("#operationtips").val();
												var successful = $("#successful").val();
												alert(successful,operationtips);
												if(thesave==1){
													clearText('operform');
													$('#code').focus();
												}else{
													setTimeout($.unblockUI, 15);
													reloadData();	
												}
												
											}	
										}
									});
							}
						}
					});
				}
				/**
				 * 删除信息
				 * @param key(唯一标识)
				 * @return 无返回值(删除成功)/false(数据库中不存在此条信息)
				 */
				 function deleteRow(key,key2){
				 	var deleteright = $("#deleteright").val();
				 	/**************************
				 	*    是否有执行删除的权限    *
				 	*************************/
					if(deleteright=="true"){
						 	if(confirm('<fmt:message key="global.deleteinformation"/>')){
									var urlstr=tsd.buildParams({ 	packgname:'service',//java包
															 		clsname:'ExecuteSql',//类名
															 		method:'exeSqlData',//方法名
															 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
															 		tsdcf:'mssql',//指向配置文件名称
															 		tsdoper:'exe',//操作类型 
															 		tsdpk:'spowerManager.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
															 	});
									getParamInfo(key,1);
									var thedelinfo  = $('#thedelinfo').val();
					 				writeLogInfo('','delete',tsd.encodeURIComponent("<fmt:message key='global.delete'/>")+tsd.encodeURIComponent("<fmt:message key='spower.thespower'/>")+key+tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：")+thedelinfo);
											
									$.ajax({
											url:'mainServlet.html?'+urlstr+'&paramname='+key+'&pagenames='+key2,
											cache:false,//如果值变化可能性比较大 一定要将缓存设成false
											timeout: 1000,
											async: false ,//同步方式
											success:function(msg){
													if(msg=="true"){
															var operationtips = $("#operationtips").val();
															var successful = $("#successful").val();
															alert(successful,operationtips);
															setTimeout($.unblockUI, 15);
															reloadData();
														}	
													}
											
									});
						}
					}else{
						var operationtips = $("#operationtips").val();
						var deletepower = $("#deletepower").val();
						alert(deletepower,operationtips);
					}
			 	}
				
				
				/**
				 * 修改信息 
				 * @param key(唯一标识)
				 * @return 无返回值
				 */
				function openRowModify(key,key2){
					var editright = $("#editright").val();
					if(editright=="true"){
						var editinfo = $("#editinfo").val();
						//tsd.setTitle($("#input-Unit .title h3"),editinfo);
						
						$('#titledivs').html(editinfo);
						$("#modify").show();
						$("#saveadd").hide();
						$("#saveexit").hide();
						$('#dismenutr').hide();
						hideError();//隐藏错误信息 
						clearText('operform'); 
						$("#paramname").val(key);
						///设置命令参数
						var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'spowerManager.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
							 					
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&paramname='+key+'&pagenames='+key2,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									
									var paramname = $(this).attr("paramname");
									var imenuid = $(this).attr("imenuid");
									$('#theimenuid_').val(imenuid);	
									var paramalias = $(this).attr("paramalias");
									var type = $(this).attr("type");
									var dict = $(this).attr("dict");
									var pagename = $(this).attr("pagename");
									var defaultvalues = $(this).attr("defaultvalues");
									
									var description = $(this).attr("description");
									var zhcodealias = getCaption(paramalias, 'zh', '');
									var encodealias = getCaption(paramalias, 'en', '');
									
									var zhdescription = getCaption(description, 'zh', '');
									var endescription = getCaption(description, 'en', '');
									
									$('#code').val(paramname);
									$('#spowerimenuid').val(imenuid);
									
									$('#zhalias').val(zhcodealias);
									$('#enalias').val(encodealias);
									$('#zhdescription').val(zhdescription);
									$('#endescription').val(endescription);
									$('#type').val(type);
									$('#dict').val(dict);
									$('#pagename').val(pagename);
									$('#defaultvalues').val(defaultvalues);
									
									/**
									var editfields = $("#editfields").val();
									var fields = getFields('sys_powerparam');
									var fieldarr = fields.split(",");
									var spower = editfields.split(",");
									if(spower.length>0){
										for(var i=1;i<spower.length;i++){
											for(var j = 0 ; j <fieldarr.length;j++){
												if(fieldarr[j]==spower[i]){
													if(fieldarr[j]=="description"){
														document.getElementById("zhdescription").disabled = false;
														document.getElementById("endescription").disabled = false;		
													}else if(fieldarr[j]=="paramalias"){
														document.getElementById("zhalias").disabled = false;
														document.getElementById("enalias").disabled = false;	
													}else if(fieldarr[j]=="imenuid"){
														document.getElementById("spowerimenuid").disabled = false;
													}else{
														if(document.getElementById(fieldarr[j])!=null){
															document.getElementById(fieldarr[j]).disabled = false;
														}
													}
													break;
												}
											}
										}
										document.getElementById("code").disabled = true;
									}*/
								});
								$('#code').attr('disabled','')
								autoBlockForm('add',60,'close',"#ffffff",false);//弹出查询面板
								//$('#code').attr('disabled','disabled');
								setTimeout("$('#code').attr('disabled','disabled')",1000);
							}
						});
					}else{
						var operationtips = $("#operationtips").val();
						var editpower = $("#editpower").val();
						alert(editpower,operationtips);
					}
				}
				/**
				 * 将修改后的信息保存起来
				 * @param 无参数
				 * @return 无返回值
				 */
				function modifyInfo(){
					 $('#thestate').val(1);
					 var params = buildParams();
					 if(params==false){return false;}
						key=$("#paramname").val();
							///设置命令参数
					 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'exe',//操作类型 
								 					tsdpk:'spowerManager.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
							urlstr+=params;
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&paramname='+key,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){
									var operationtips = $("#operationtips").val();
									var successful = $("#successful").val();
									alert(successful,operationtips);
									/*************
									** 释放资源 **
									************/
									setTimeout($.unblockUI, 15);
									reloadData();
								}	
							}
						});
						
						
				}
				
				/**
				 * 重载信息 
				 * @param 无参数
				 * @return 无返回值
				 */
				function reloadData(){
			 		 var urlstr=tsd.buildParams({ 	
			 		 						packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					datatype:'xml',//返回数据格式 
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					tsdpk:'spowerManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'spowerManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 				});
					//var languageType = $("#languageType").val();
					var column = $('#thecolumn').val();
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&cloumn='+column}).trigger("reloadGrid");
				 	setTimeout($.unblockUI, 15);//关闭面板
				}
				
			/**
			 * 在初始化页面的时候将面板加载进来
			 * @param 无参数
			 * @return 无返回值
			 */
			 $(document).ready(function(){
		
				//参数为你要验证的表单的id	
	  			myValidate("operform");
	  			$("#save").show();
				$("#modify").hide();
			});
			
			/**
			 * 执行复合查询出提交过来的相应操作
			 * @param 无参数
			 * @return 无返回值
			 */
			function fuheExe(){
				var queryName= $('#queryName').val();
				if(queryName=="query"){
					fuheQuery();
				}
			}
			/**
			 * 简单查询
			 * @param 无参数
			 * @return 无返回值
			 */
			function fuheQuery(){
				fuheDisQuery('spowerManager.queryByWhere','spowerManager.queryByWherepage');
			}
			/**
			 * 查询模块
			 * @param querysql(查询语句)
			 * @param querypagesql(分页语句)
			 * @return 无返回值
			 */
			function fuheDisQuery(querysql,querypagesql)
			{
				var params = fuheQbuildParams();			
				if(params=='&fusearchsql='){
					params +='1=1';
				}	
						
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:querysql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:querypagesql
											});
				var languageType = $('#languageType').val();					
				var link = urlstr1 + params+'&lang='+languageType;	
				var column = $('#thecolumn').val();
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&cloumn='+column}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板			
			}
			
			
			/**
			 * 将受限字段复原 
			 * @param status(状态)
			 * @return 无返回值
			 */
			function isReadonly(status){
				var userid = $('#userid').val();
				if(userid=='admin'){
					status = false;
				}
				var fields = getFields('sys_powerparam');
				var fieldarr = fields.split(",");
				for(var j = 0 ; j <fieldarr.length-1;j++){
					if(fieldarr[j]=="description"){
						document.getElementById("zhdescription").disabled = status;
						document.getElementById("endescription").disabled = status;		
					}else if(fieldarr[j]=="paramalias"){
						document.getElementById("zhalias").disabled = status;
						document.getElementById("enalias").disabled = status;	
					}else if(fieldarr[j]=="imenuid"){
						document.getElementById("spowerimenuid").disabled = status;
					}else{
						try{
							document.getElementById(fieldarr[j]).disabled = status;
						}catch(e){}
					}
				}
			}
			
			/**
			 * 弹出简单查询面板
			 * @param 无参数
			 * @return 无返回值
			 */
			function openQuerySpower(){
				clearText('queryspowerforms');
				$('#whichorder').val(0);//简单查询
				autoBlockForm('queryspowerform',60,'queryclose',"#ffffff",false);//弹出面板
			}
			
			/**
			 * 执行查询
			 * @param 无参数
			 * @return 无返回值
			 */
			function querySpower(){
				var paramname = $('#querycode').val();
				var imenuid = $('#querymenuid').val();
				var type = $('#querytype').val();
				
				var params = '';
				params += '&paramname=' + paramname;
				params += '&type=' + tsd.encodeURIComponent(type);
				params += '&imenuid=' + tsd.encodeURIComponent(imenuid);
				
				var expparams = ' 1=1 ';
				if(paramname!=''){
					expparams += " and paramname='" + paramname + "'";
				}
				if(imenuid!=''){
					expparams += " and imenuid like '%" + imenuid + "%'";
				}
				if(type!=''){
					expparams += " and type='" + type + "'";
				}
				$('#fusearchsql').val(expparams);
				var urlstr=tsd.buildParams({ 	
			 		 						packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					datatype:'xml',//返回数据格式 
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					tsdpk:'spowerManager.queryjd',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'spowerManager.querypagejd'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 				});
					var thecolumn = $('#thecolumn').val();
					$('#jdparams').val('&cloumn='+thecolumn+params);
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&cloumn='+thecolumn+params}).trigger("reloadGrid");
				 	setTimeout($.unblockUI, 15);//关闭面板
			}
			
			/**
			 * 重写保存模板的方法
			 * @param 无参数
			 * @return 无返回值
			 */
			function opensaveQ(){		
					//获取查询树信息
					var fusearchsql = $("#fusearchsql").val();	
					
					var treepid = $("#treepid").val();
					
					if(treepid==''||fusearchsql=='&fusearchsql='){
						//alert('请先用高级查询，再保存。');
						alert("<fmt:message key='spowerManager.SeniorInquiresAndSave' />");
						return;
					}
				 	var addinfo = $("#addinfo").val(); 	
				 	//tsd.setTitle($("#input-Unit .title h3"),addinfo); 	
					clearText('addquery');
					hideError();//隐藏错误信息	
					autoBlockForm('modT',60,'closeModB',"#ffffff",false);//弹出查询面板
					//autoBlockFormAndSetWH('addquery',60,60,'Qclose',"#ffffff",false,730,'');//弹出查询面板
			}
				/**
				 * 复合查询参数获取，@oper 操作类型 fuhe 
				 * @param 无参数
				 * @return String
				 */	
				function fuheQbuildParams(){
					 	//每次拼接参数必须初始化此参数
						tsd.QualifiedVal=true;
					 	var params='';
					 	
					 	//如果有可能值是汉字 请使用encodeURI()函数转码
					 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());			 	
					 	params+='&fusearchsql='+fusearchsql;
					 			 	
					 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
					 	//每次拼接参数必须添加此判断
						if(tsd.Qualified()==false){return false;}
						return params;
				}
				
				/**
				 * 组合排序
				 * @param sqlstr(组合排序条件)
				 * @return 无返回值
				 */	
				function zhOrderExe(sqlstr){
						var params = '';
						var flag = $('#whichorder').val();
						var sql = '';
						var pagesql = '';
						//0：简单查询 1：高级查询
						if(flag==0){
							var jdparams = $('#jdparams').val();
							params += jdparams +'&tsdOrderBy='+sqlstr;;
							sql = 'ipManager.queryjd';
							pagesql = 'ipManager.querypagejd';
						}else if(flag==1||flag==2){
							params = fuheQbuildParams();	
							if(params=='&fusearchsql='){
								params +='1=1';
							}
							var column = $("#thecolumn").val();		
							params =params+'&orderby='+sqlstr+'&column='+column;
							params += '&orderkey=paramname';
							params += '&ordertablename=sys_powerparam';
							sql = 'main.queryByOrder';
							pagesql = 'main.queryByOrderpage';
						}
							
					 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
					 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
													  clsname:'ExecuteSql',//类名
													  method:'exeSqlData',//方法名
													  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													  tsdcf:'mssql',//指向配置文件名称
													  tsdoper:'query',//操作类型 
													  datatype:'xml',//返回数据格式 
													  tsdpk:sql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													  tsdpkpagesql:pagesql
													});
						var link = urlstr1 + params;					
					 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
					 	//jAlert("操作成功","操作提示");
						setTimeout($.unblockUI, 15);
				} 
				
				/**
				 * 拼接要显示的数据列
				 * @param tablename(表名)
				 * @return 数组
				 */	
				function displayFields(tablename){
					var thearr = new Array();
						 var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'roleManager.gettheeditfields'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&tablename='+tablename,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
										var thefieldname = $(this).attr("field_name") ;
										var thefieldalias = getCaption($(this).attr("field_alias"),'<%=languageType %>','');
										if(thefieldalias!=''){
											var disvalue = thefieldname + ' as ' + tsd.encodeURIComponent(thefieldalias);
											thearr.push(disvalue);
										}
								 });
							 }
						 });
					return thearr;
				}
/**
 * 获得焦点事件
 * @param 无参数
 * @return 无返回值
 */				
function dismenus(){
	var urlstr=tsd.buildParams({ 
    								packgname:'service',//java包
						 			clsname:'ExecuteSql',//类名
						 			method:'exeSqlData',//方法名
						 			ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 			tsdcf:'mssql',//指向配置文件名称
						 			tsdoper:'query',//操作类型 
						 			datatype:'xmlattr',//返回数据格式 
						 			tsdpk:'spowerManager.getmenulist'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 	   });
	$.ajax({
				url:'mainServlet.html?lan=<%=languageType %>'+urlstr,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 3000,
				async: false ,//同步方式
				success:function(xml){
						var i = 0;
						var menulist = '';
						$(xml).find('row').each(function(){
								var menuname = $(this).attr("smenuname");
								var menuid = $(this).attr("imenuid") ;
								var thebr = '';
								if((i+1)*1%3==0){
									thebr = '<br/>';
								}
								menulist += "<span class='spanstylemenu'><input type='checkbox' name='thismenulist' value='"+menuid+"' style='width:15px;height:15px;'><label style='text-align: left;margin-left:5px'>"+menuname+"</label></span>"+thebr;
								i++;
						});
						var disbutton = "<div style='text-align:center'><button type='button' id='ischeckallmenu' class='tsdbutton' onclick=isCheckedAll('thismenulist','ischeckallmenu') style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'><fmt:message key='spowerManager.checkAll' /></button><button type='button' class='tsdbutton' onclick=checkedOK('thismenulist','dismenutr','spowerimenuid') style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'><fmt:message key='spowerManager.sure' /></button></div>";
						$('#dismenulist').html(menulist+'<hr/>'+disbutton);
						var theimenuid_ = $('#theimenuid_').val();
		
						if(theimenuid_!=0){
							forChecked('thismenulist',theimenuid_);
						}
						$('#dismenutr').show('slow');
				}
	});	
}


/**
 * 改变复选框状态
 * @param name
 * @param butid
 * @return 无返回值
 */	
function isCheckedAll(name,butid){
	var tagname=document.getElementsByName(name);  
	for(var i=0;i<tagname.length;i++){
		if(tagname[i].checked == true){
		  		for(var j = 0 ;j < tagname.length;j++){
					tagname[j].checked = false;				    			
		   		}
		   		//全选
		   		$('#'+butid).html("<fmt:message key='spowerManager.checkAll' />");
		   		break;
		}else{
		   		for(var j = 0 ;j < tagname.length;j++){
					tagname[j].checked = true;				    			
		   		}
		   		//全不选
		   		$('#'+butid).html("<fmt:message key='spowerManager.notcheckAll' />");
		  		break;
		}
	}      
}

/**
 * 将选择的结果显示
 * @param name
 * @param hidedivid
 * @param showvalueid
 * @return 无返回值
 */	
function checkedOK(name,hidedivid,showvalueid){
	var tagname=document.getElementsByName(name);  
	var checkvalue = '';
	
	for(var i=0;i<tagname.length;i++){
		if(tagname[i].checked == true){
			checkvalue += tagname[i].value + '~';	
		}	
	}    
	var dotnum = checkvalue.lastIndexOf('~');
	if(dotnum!=-1){
		checkvalue = checkvalue.substring(0,dotnum); 
	}
	$('#'+hidedivid).hide('slow');
	$('#'+showvalueid).val(checkvalue);
	$('#zhalias').focus();
}

/**
 * 获取已经选中的值
 * @param name
 * @param thisvalue
 * @return 无返回值
 */	
function forChecked(name,thisvalue){
	if(''!=thisvalue&&null!=thisvalue){
		if(thisvalue.indexOf('~')!=-1){
			var thearr = thisvalue.split('~');
			var tagname=document.getElementsByName(name);
			//获取name的所有的值
			for(var i = 0 ; i < tagname.length;i++){
				//获取以前的记录选中值
				for(var j = 0;j<thearr.length;j++){
					if(tagname[i].value==thearr[j]){
				        tagname[i].checked = true;
				        break;
				    }
				}
			}
		}else{
			var tagname=document.getElementsByName(name);
			//获取name的所有的值
			for(var i = 0 ; i < tagname.length;i++){
				if(tagname[i].value==thisvalue){
					tagname[i].checked = true;
					break;
				}
			}
		}
	}
}

</script>
		<style type="text/css">
			.titlemargin{margin-left:90px !important;margin-left:45px;}
			.spanstyle{display:-moz-inline-box; display:inline-block; width:115px}
			.spanstylemenu{display:-moz-inline-box; display:inline-block; width:185px}
			hr {margin:2px 0 2px 0;border:0;border-top:1px dashed #CCCCCC;height:0;}
		</style>
		
	</head>

	<body>
		<form name="childform" id="childform">
			<input type="text" id="queryName" name="queryName" value=""
				style="display: none" />
			<input type="text" id="fusearchsql" name="fusearchsql"
				style="display: none" />
		</form>
		<!-- 用户操作导航-->
		<div id="navBar">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message
									key="gjh.houtuei" />
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<!-- 用户操作标题以及放一些快捷按钮-->
		<div id="buttons">
			<button type="button" id="order1" onclick="openDiaO('sys_powerparam');" >
				<!-- 组合排序 -->	<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd1" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openQuerySpower()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query1" disabled="disabled"
				onclick="openDiaQueryG('query','sys_powerparam')">
				<!-- 高级查询 -->
				<fmt:message key="spowerManager.SeniorInquires" />
			</button>
			<button id='gjquery1' onclick='openQueryM(1);' >
				<fmt:message key="oper.mod"/>
			</button>
			
			<button id='savequery1' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="exp1" onclick="thisDownLoad('tsdBilling','mssql','sys_powerparam','<%=languageType %>',6)"
					disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
		<div id="buttons">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="order2" onclick="openDiaO('sys_powerparam');" >
				<!-- 组合排序 -->	<fmt:message key="order.title" />
			</button>
			<button type="button" id="openadd2" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openQuerySpower()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query2" disabled="disabled"
				onclick="openDiaQueryG('query','sys_powerparam')">
				<!-- 高级查询 -->
				<fmt:message key="spowerManager.SeniorInquires" />
			</button>
			<button id='gjquery2' onclick='openQueryM(1);' >
				<fmt:message key="oper.mod"/>
			</button>
			
			<button id='savequery2' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="exp2" onclick="thisDownLoad('tsdBilling','mssql','sys_powerparam','<%=languageType %>',6)"
					disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		
		<div class="neirong" id="add" style="display: none;width:700px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titledivs"></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#close').click();">
							<!-- 关闭 -->
							<fmt:message key="spowerManager.close" />
							</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="operform"
							id="operform" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									<label for="scode" id="scode"></label>
								</td>
								<td class="tdstyle" colspan="3">
									<input type="text" name="code" id="code" class="textclass" style="width:150px" />
									<font style="color:red;">*</font>
								</td>
								<td class="labelclass" style="display: none">
									<label for="simenuid" id="simenuid"></label>
								</td>
								<td class="tdstyle" style="display: none">
									<input type="text" id="spowerimenuid" onfocus="dismenus()" onkeyup="value=value.replace(/[^\d]/g,'')" class="textclass" style="width:150px" disabled="disabled" />
									<font style="color:red;">*</font>
								</td>
							</tr>
							<tr id="dismenutr" style="display: none">
								<td class="labelclass">
									<!-- 可配置菜单 -->
									<fmt:message key="spowerManager.ConfigurationMenu" />
								</td>
								<td class="tdstyle" colspan="3">
									<div id="dismenulist" style="max-height:200px;overflow-y: auto;overflow-x: hidden;"></div>
								</td>
							</tr>
							<tr>
								<td class="labelclass">
									<label for="szhalias" id="szhalias"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="zhalias" style="width:150px" class="textclass" disabled="disabled" />
									
								</td>
								<td class="labelclass">
									<label for="senalias" id="senalias"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="enalias" style="width:150px" class="textclass" disabled="disabled" />
								</td>
							</tr>
							<tr>
								<td class="labelclass">
									<label for="stype" id="stype"></label>
								</td>
								<td class="tdstyle">
									<select id='type' disabled="disabled" class="textclass" style="width:150px" >
										<option value='0'>
											<fmt:message key="ip.select" />
										</option>
										<option value='input'>
											input
										</option>
										<option value='select'>
											select 
										</option>
										<option value='list'>
											list 
										</option>
									</select>
									<font style="color:red;margin-left: 5px">*</font>
								</td>
								<td class="labelclass">
									<label for="sdict" id="sdict"></label>
								</td>
								<td class="tdstyle">
									<input type="text" id="dict" style="width:150px" class="textclass" disabled="disabled" />
								</td>
							</tr>
							<tr>
								<td class="labelclass">
									<fmt:message key="spower.htmlNames" />
								</td>
								<td class="tdstyle">
									<input type="text" name="pagename" id="pagename" class="textclass" style="width:150px"/>
									<font style="color:red;">*</font>
								</td>
								<td class="labelclass">
									<fmt:message key="spower.defaultValue" />
								</td>
								<td class="tdstyle">
									<input type="text" name="defaultvalues" id="defaultvalues" class="textclass" style="width:150px"/>
								</td>
							</tr>
							<tr>
								<td class="dflabelclass">
									<label for="code">
										<span id="szhdescription"></span>
									</label>
								</td>
								<td >
									<input type="text" id="zhdescription" class="textclass" style="width: 150px" disabled="disabled"/>
								</td>
								<td class="dflabelclass">
									<label for="memo" style="width: 90px">
										<span id="sendescription"></span>
									</label>
								</td>
								<td>
									<input type="text" class="textclass" style="width: 150px" id="endescription" disabled="disabled"/>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" style="width: 80px" id="saveadd" onclick="saveInfo(1)">
						<!-- 保存添加 -->
						<fmt:message key="spowerManager.saveAndAdd" />
					</button>
					<button type="submit" class="tsdbutton" style="width: 80px" id="saveexit" onclick="saveInfo(2)" style="margin-left: 10px">
						<!-- 保存退出 -->
						<fmt:message key="spowerManager.saveAndclose" />
					</button>
					<button type="submit" class="tsdbutton" id="modify" onclick="modifyInfo();">
						<fmt:message key="global.edit" />
					</button>
					<button type="button" class="tsdbutton" id="close" style="margin-left: 10px" onclick="clearText('operform');reloadData();">
						<fmt:message key="global.close" />
					</button>
				</div>
		</div>
		
			<div style="display: none">
				<input type="hidden" id="imenuid" value="<%=imenuid%>" />
				<input type="hidden" id="zid" value="<%=zid%>" />
				<%
					if (!languageType.equals("en")) {
						languageType = "zh";
					}
				%>

				<input type="hidden" id="languageType" value="<%=languageType%>" />

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
				<input type="hidden" id="management"
					value="<fmt:message key="spower.management"/>" />
				<input type="hidden" id="worninfo"
					value="<fmt:message key="ip.worn"/>" />
				<input type="hidden" id="worntips"
					value="<fmt:message key="ip.worntips"/>" />
				<input type="hidden" id="deletepower"
					value="<fmt:message key="global.deleteright"/>" />
				<input type="hidden" id="editpower"
					value="<fmt:message key="global.editright"/>" />
				<input type="hidden" id="deletefailed"
					value="<fmt:message key="ip.deletefailed"/>" />
				<input type="hidden" id="selectarea"
					value="<fmt:message key="ip.select"/>" />
				<input type="hidden" id="inputip"
					value="<fmt:message key="ip.inputip"/>" />
				<input type="hidden" id="selectarea"
					value="<fmt:message key="ip.selectarea"/>" />
				<input type="hidden" id="addmemo"
					value="<fmt:message key="ip.addmemo"/>" />
				<input type="hidden" id="ipvalid"
					value="<fmt:message key="ip.valid"/>" />


				<input type="hidden" id="addright" />
				<input type="hidden" id="deleteright" />
				<input type="hidden" id="editright" />
				<input type="hidden" id="editfields" />
				<input type="hidden" id="paramname" />


				<input type="hidden" id="userid" value="<%=userid%>" />
				
				<input type="hidden" id="thecolumn" />
				<input type="hidden" id="thedelinfo" />
				<input type="hidden" id="thestate" />
				<%@page import="com.tsd.service.util.Log"%>
				<input type='hidden' id='userloginip'
					value='<%=Log.getIpAddr(request)%>' />
				<input type='hidden' id='userloginid'
					value='<%=session.getAttribute("userid")%>' />
				<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
			</div>
			
		<!-- 简单查询面板 -->
		<div class="neirong" id="queryspowerform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">
								<!-- 查询 -->
								<fmt:message key="spowerManager.query" />
								</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#queryclose').click();">
							<!-- 关闭 -->
							<fmt:message key="spowerManager.close" />
							</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="queryspowerforms"
							id="queryspowerforms" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>	
								<td class="dflabelclass">
									<label id="qcode"></label>
								</td>
								<td>
									<input type="text" id="querycode" class="textclass" style="width:150px"/>
								</td>
								
								<td class="dflabelclass">
									<label id="qimenuid"></label>
								</td>
								<td>
									<input type="text" id="querymenuid" style="width:150px" class="textclass"/>
								</td>
								<td class="dflabelclass">
									<label id="qtype"></label>
								</td>
								<td>
									<select id='querytype' class="textclass" style="width:150px" >
										<option value=''>
											<fmt:message key="ip.select" />
										</option>
										<option value='input'>
											input
										</option>
										<option value='select'>
											select 
										</option>
										<option value='list'>
											list 
										</option>
									</select>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" onclick="querySpower()">
						<fmt:message key="global.query" />
					</button>
					<button type="button" class="tsdbutton" id="queryclose" style="margin-left: 10px">
						<fmt:message key="global.close" />
					</button>
				</div>
		</div>
		
		<!-- 添加模板面板 -->
		<div id="modT" name='modT' style="display: none"  class="neirong" style="width:800px">
			<br/>
			<div class="top">
			<div class="top_01">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" >
						<!-- 查询模板保存 -->
						<fmt:message key="spowerManager.InquiresTheTemplateSave" />
						</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
				</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
				<div class="midd" >
				<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
					<input type="hidden" />
					<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
					  	<tr>
						    <td align="right" class="dflabelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
						    <td width="200px" align="left">
						    	<input type="text" name="name_mod" id="name_mod" onkeyup="this.value=replaceStrsql(this.value,80)" class="textclass" />
						    	<font style="color: #ff0000;">*</font></td>
						    
						    <td align="right"  class="dflabelclass"><label id=''></label></td>
						    <td width="150px" align="left"></td>
							
						    <td align="right"  class="dflabelclass"></td>
					    	<td width="150px" align="left"></td>
					 	 </tr>	  
					</table>
				</form>
				<div class="midd_butt">
				<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="saveModQuery(1);" ><fmt:message key="global.save" /></button>
			 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
				</div>	
			</div>
		</div>	
			<!-- 查询树信息存放 -->
				<input type="hidden" id='treepid' />	
				<input type="hidden" id='treecid' />	
				<input type="hidden" id='treestr' />	
				<input type="hidden" id='treepic' />	
				
				<!-- 高级查询 模板隐藏域 -->
				<input type="hidden" id="queryright"/>
				<input type="hidden" id="saveQueryMright"/>		
				
				<input type="hidden" id="jdparams"/>	
				<input type="hidden" id="exportright"/>	
				<input type="hidden" id="whichorder" value="2"/>		
				
			<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">
								<!-- 选择您要导出的数据字段 -->
								<fmt:message key="spowerManager.chooseData" />
								</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();">
							<!-- 关闭 -->
							<fmt:message key="spowerManager.close" />
							</a></div>
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
						<!-- 全选 -->
						<fmt:message key="spowerManager.checkAll" />
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="getTheCheckedFields('tsdBilling','mssql','sys_powerparam')">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
				</div>
		</div>	
		<input type="hidden" id="useridd" value="<%=userid %>"/>	
		<input type="hidden" id="theimenuid_"/>	
	</body>
</html>
