<%----------------------------------------
	name: jobRightManager.jsp
	author: chenliang
	version: 1.0, 2010-01-10
	description: 对处理工单权限的一个设置
	modify: 
		2010-01-10 chenliang 完成基本功能
      	2010-01-11 chenliang 进行页面的样式统一美化
      	2010-11-29 chenze    修改方法saveInfo，去除原有mysql同步，解决job_canoperateuserid数据表主键约束报错问题
      	2010-12-06 liwen     解决高级查询时 根据业务类别无法查出结果的问题
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
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
		<script type="text/javascript" src="script/public/transfer.js"></script>
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
							 					  tsdpname:'jobRightManager.getPower',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
			
				/****************
				*   拼接权限参数 *
				**************/
				
				var addright = '';
				var deleteright = '';
				var editright = '';
				var queryright = '';				
				var saveQueryMright ='';
				var editfields = '';
				
				var flag = false;
				
				var spower = '';
				
				$.ajax({
						url:'mainServlet.html?'+urlstr+'&userid=<%=userid %>&groupid=<%=zid %>&menuid=<%=imenuid %>',
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
				
				var str = 'true';
				if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							addright += getCaption(spower,'add','')+'|';
										
							deleteright += getCaption(spower,'delete','')+'|';
										
							editright += getCaption(spower,'edit','')+'|';
										
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
							saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';									
										
							editfields += getCaption(spower,'editfields','');
						}
				}else if(spower=='all@'){
						$("#addright").val(str);
						$("#deleteright").val(str);
						$("#editright").val(str);
						$("#queryright").val(str);
						$("#saveQueryMright").val(str);
						flag = true;
				}	
				var hasadd = addright.split('|');
				var hasdelete = deleteright.split('|');
				var hasedit = editright.split('|');
				var hasquery = queryright.split('|');
				var hassaveQueryM = saveQueryMright.split('|');
				
				if(flag==false){
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
			 * 初始化
			 * @param 无参数
			 * @return 无返回值
			 */
			jQuery(document).ready(function () { 
			/**********************
			**   获取当前导航菜单  *
			**********************/
			$("#navBar1").append(genNavv());
			/**********************
			**   取得当前用户的权限  *
			**********************/
			getUserPower();
			//业务类别
			getValue('ywclass','&fusearchsql=1=1','typeid','TypeName','ywsl_type');
			//业务类型
			//getValue('ywtype','&fusearchsql=1=1','ywlx','ShowName','ywsl_code');
			
			//业务部门
			//getValue('jobRightManager.ywdept','dept','&UserOperate='+,'ywlx','ShowName');
			
			var addright = $("#addright").val();
			if(addright=="true"){
				document.getElementById("openadd1").disabled=false;
				document.getElementById("openadd2").disabled=false;
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
						 					ds:'tsdReport',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xml',//返回数据格式 
						 					tsdpk:'jobRightManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'jobRightManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 					});
			var column  = '';
			var thisdata = loadData('job_canoperateuserid','<%=languageType %>',1);
			column = thisdata.FieldName.join(',');			 					
			$('#thecolumn').val(column);
			$("#sywclass").html(thisdata.getFieldAliasByFieldName('businessclass'));
			$("#sywtype").html(thisdata.getFieldAliasByFieldName('businesstype'));
			$("#sdept").html(thisdata.getFieldAliasByFieldName('department'));
			$("#srightuserid").html(thisdata.getFieldAliasByFieldName('userid'));
			
			//jqgrid隐藏某一列的值
			//thisdata.colModels[1].hidden=true;
			$('#thecolumn').val(column);
			thisdata.setWidth({Operation:20,businessclass:50,businesstype:50,department:50});		
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&cloumn='+column, 
				datatype: 'xml', 
				colNames:thisdata.colNames, 
				colModel:thisdata.colModels, 
				       	rowNum:15, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'businessclass', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:'工单权限列表', 
				       	height:300, //高
				       	width:document.documentElement.clientWidth-45,
				       	loadComplete:function(){
				       					if($("#editgrid tr.jqgrow[id='1']").html()=="")
											return false;
				       	
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										///自动适应 工作空间
										
										//getRealValue(field,tablename,wheather,value)
										
										
										var therow = document.getElementById('editgrid').rows;
									 	for(var i =1; i<therow.length;i++){
									 		//获取jqgrid某一列的值 $('#jqgrid的id').getRowData(行号).列名(区分大小写)
									 		var ywclass = $('#editgrid').getRowData(i).businessclass;
									 		if(ywclass!=''&&ywclass!=undefined){
									 			var classname = getRealValue('TypeName','ywsl_type','typeid',ywclass);
									 			//设置jqgrid的某一列的值 $('#jqgrid的id').setRowData(行号,{列名:要设置的值);
									 			$('#editgrid').setRowData(i,{businessclass:classname});
									 		}
									 		
									 		var ywtype = $('#editgrid').getRowData(i).businesstype;
									 		if(ywtype!=''&&ywclass!=undefined){
									 			var classname = getRealValue('ShowName','ywsl_code','ywlx',ywtype);
									 			//设置jqgrid的某一列的值 $('#jqgrid的id').setRowData(行号,{列名:要设置的值);
									 			$('#editgrid').setRowData(i,{businesstype:classname});
									 		}
									 		var ywtment = $('#editgrid').getRowData(i).department;
									 		if(ywtment!=''&&ywtment!=undefined){
									 			var classname = getRealValue('bm','scddbm','id',ywtment);									 			
									 			//设置jqgrid的某一列的值 $('#jqgrid的id').setRowData(行号,{列名:要设置的值);
									 			$('#editgrid').setRowData(i,{department:classname});
									 		}
									 	}
									 	
										var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										setAutoGridHeight("editgrid",reduceHeight);
										
										addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" alt="修改"/>','openRowModify','businessclass','click',1,'businesstype','department');
										
										addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_02.gif" alt="删除"/>','deleteRow','businessclass','click',2,'businesstype','department');
										executeAddBtn('editgrid',2);
										}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
			});
			
			
				
				/**
				 * 修改信息
				 * @param key1
				 * @param key2
				 * @param key3
				 * @return 无返回值
				 */
				function openRowModify(key1,key2,key3){
					var editright = $("#editright").val();
					if(editright=="true"){
						$('#titlediv').html('<fmt:message key="global.edit" />');
						$("#saveexit").hide();
						$("#saveadd").hide();
						$("#modify").show();
						
						hideError();//隐藏错误信息 
						clearText('operform'); 
						
						var thekey1 = getRealValue('typeid','ywsl_type','TypeName',key1);
						var thekey2 = getRealValue('ywlx','ywsl_code','ShowName',key2)
						var thekey3 = getRealValue('id','Scddbm','bm',key3);
						$('#key1').val(thekey1);
						$('#key2').val(thekey2);
						$('#key3').val(thekey3);
						
						///设置命令参数
						 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdReport',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'jobRightManager.querythevalue' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&businessclass='+thekey1+'&businesstype='+thekey2+'&department='+thekey3,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									var userid = $(this).attr("userid");
									getTheDept();
									
									getValue('ywtype','&fusearchsql=1=1&typeid='+thekey1,'ywlx','ShowName','ywsl_code');
									$('#ywclass').val(thekey1);
									$('#ywtype').val(thekey2);
									$('#dept').val(thekey3);
									
									getUserId(key3);
									//默认选中以前的
									forChecked('userids',userid);
									document.getElementById('displayuserid').style.display='block'; 
								});
								//autoBlockForm('operform',5,'close',"#ffffff",true);//弹出查询面板
								//document.getElementById('add').style.display='block'; 
								//document.getElementById('displayinfo').style.display='none'; 
								
								autoBlockForm('add',60,'close',"#ffffff",false);//弹出查询面板
							}
						});
					}else{
						var operationtips = $("#operationtips").val();
						var editpower = $("#editpower").val();
						alert(editpower,operationtips);
					}
				}
			
				/**
				 * 获取已经选中的值
				 * @param name
				 * @param thisvalue
				 * @return 无返回值
				 */
				function forChecked(name,thisvalue){
					if(''!=thisvalue&&null!=thisvalue){
						var thenum = thisvalue.lastIndexOf(',');
						var m = 0;
						if(thenum==-1){
							thisvalue += ',';
							m = 1;
						}
						var thearr = thisvalue.split(',');
						var tagname=document.getElementsByName(name);
						  
						//获取name的所有的值
						for(var i = 0 ; i < tagname.length;i++){
							//获取以前的记录选中值
							for(var j = 0;j<thearr.length-m;j++){
								if(tagname[i].value==thearr[j]){
							        tagname[i].checked = true;
							        break;
							    }
							}
						}
					}
				}
				
				
				/**
				 * 将修改后的信息保存起来
				 * @param 无参数
				 * @return 无返回值
				 */
				function modifyInfo(){
					 var params = buildParams();
					 if(params==false){return false;}
						var key1=$("#key1").val();
						var key2=$("#key2").val();
						var key3=$("#key3").val();
							///设置命令参数
					 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdReport',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'exe',//操作类型 
								 					tsdpk:'jobRightManager.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
							urlstr+=params;
						$.ajax({
							url:'mainServlet.html?'+urlstr+params+'&key1='+key1+'&key2='+tsd.encodeURIComponent(key2)+'&key3='+tsd.encodeURIComponent(key3),
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){
									modifyInfoMysql(params,key1,key2,key3);
									alert('<fmt:message key="global.successful"/>','<fmt:message key="global.operationtips"/>');
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
				 * 修改mysql中的记录
				 * @param params
				 * @param key1
				 * @param key2
				 * @param key3
				 * @return 无返回值
				 */
				function modifyInfoMysql(params,key1,key2,key3){
					var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mysql',//指向配置文件名称
								 					tsdoper:'exe',//操作类型 
								 					tsdpk:'jobRightManager.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
					urlstr+=params;
					$.ajax({
							url:'mainServlet.html?'+urlstr+params+'&key1='+key1+'&key2='+tsd.encodeURIComponent(key2)+'&key3='+tsd.encodeURIComponent(key3),
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								
							}
						});
				}
			
			
				
				/**
				 * 页面初始化时加载系统区域，供用户进行选择
				 * @param id
				 * @param param
				 * @param save
				 * @param view
				 * @param tablename
				 * @return 无返回值
				 */
				function getValue(id,param,save,view,tablename){
						var sql = '';
						if(view==''){
							sql += 'jobRightManager.querybm'
						}else if(id=='ywtype'){
							sql += 'jobRightManager.querytype';
						}else{
							sql += 'main.Export';
						}
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						var cols = save + ',' + view;
						if(view==''){
							
							var num = cols.lastIndexOf(',');
							var selectvalue = cols.substring(0,num);
							cols = selectvalue;
							view = selectvalue;
						
						}
						$.ajax({
							url:'mainServlet.html?'+urlstr+param+'&table='+tablename+'&cols='+cols+param,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
									
									$("#"+id).html("<option value='0'><fmt:message key='ip.select'/></option>");
									var thisvalue = '';
									
									$(xml).find('row').each(function(){
										if($(this).attr(view.toLowerCase())!='' && $(this).attr(view.toLowerCase())!=undefined){
											thisvalue += "<option  value='"+$(this).attr(save.toLowerCase())+"'>"+$(this).attr(view.toLowerCase())+"</option>";
										}
									 });
									
									$("#"+id).html($("#"+id).html()+thisvalue);
							}
						});
				}
				
				
				
				/**
				 * 删除信息
				 * @param key1
				 * @param key2
				 * @param key3
				 * @return 无返回值
				 */
				 function deleteRow(key1,key2,key3){
				 	var deleteright = $("#deleteright").val();
				 	/**************************
				 	*    是否有执行删除的权限    *
				 	*************************/
					if(deleteright=="true"){
						 	jConfirm('<fmt:message key="global.deleteinformation"/>?', '<fmt:message key="global.operationtips"/>', function(x) { if(x==true){ 
						 	
						 		var thekey1 = getRealValue('typeid','ywsl_type','TypeName',key1);
						 		var thekey2 = getRealValue('ywlx','ywsl_code','ShowName',key2);
								var	thekey3 = getRealValue('id','Scddbm','bm',key3);

								
						 		/******************
						 		*  IP是否已被使用  *  
						 	   *****************/
							 	//if(isUsedIP(key)==false){
									var urlstr=tsd.buildParams({ 	packgname:'service',//java包
															 		clsname:'ExecuteSql',//类名
															 		method:'exeSqlData',//方法名
															 		ds:'tsdReport',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
															 		tsdcf:'mssql',//指向配置文件名称
															 		tsdoper:'exe',//操作类型 
															 		tsdpk:'jobRightManager.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
															 	});
									
									//var thedelinfo  = $('#thedelinfo').val();
					 				//writeLogInfo('','delete',tsd.encodeURIComponent("<fmt:message key='global.delete'/>")+tsd.encodeURIComponent("IP：")+key+tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：")+thedelinfo);
												
									$.ajax({
											url:'mainServlet.html?'+urlstr+'&businessclass='+thekey1+'&businesstype='+thekey2+'&department='+thekey3,
											cache:false,//如果值变化可能性比较大 一定要将缓存设成false
											timeout: 1000,
											async: false ,//同步方式
											success:function(msg){
													if(msg=="true"){
															deleteMysqlRs(thekey1,thekey2,thekey3);
															alert('<fmt:message key="global.successful"/>','<fmt:message key="global.operationtips"/>');
															setTimeout($.unblockUI, 15);
															reloadData();
													}	
											}
									});
							//	}else{
							//		var operationtips = $("#operationtips").val();
							//		var deletefailed = $("#deletefailed").val();
							//		alert(deletefailed,operationtips);
							//	}
						}});	
					}else{
						alert('<fmt:message key="global.deleteright"/>','<fmt:message key="global.operationtips"/>');
					}
			 	}
				
				/**
				 * 删除mysql表中的记录
				 * @param thekey1
				 * @param thekey2
				 * @param key3
				 * @return 无返回值
				 */
				function deleteMysqlRs(thekey1,thekey2,key3){
					var urlstr=tsd.buildParams({ 	packgname:'service',//java包
															 		clsname:'ExecuteSql',//类名
															 		method:'exeSqlData',//方法名
															 		ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
															 		tsdcf:'mysql',//指向配置文件名称
															 		tsdoper:'exe',//操作类型 
															 		tsdpk:'jobRightManager.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
															 	});
					$.ajax({
											url:'mainServlet.html?'+urlstr+'&businessclass='+thekey1+'&businesstype='+tsd.encodeURIComponent(thekey2)+'&department='+tsd.encodeURIComponent(key3),
											cache:false,//如果值变化可能性比较大 一定要将缓存设成false
											timeout: 1000,
											async: false ,//同步方式
											success:function(msg){
													
											}
									});
				}
				
				
				/**
				 * 业务部门
				 * @param 无参数
				 * @return boolean
				 */
				function getTheDept(){
					//业务部门
					var ywclass = $('#ywclass').val();
					if(ywclass!=''&&null!=ywclass){
						getValue('ywtype','&fusearchsql=1=1&typeid='+ywclass,'ywlx','ShowName','ywsl_code');
						getValue('dept','&fusearchsql=1=1&UserOperate='+tsd.encodeURIComponent($('#ywclass').find("option:selected").text()),'id','bm','Scddbm');
					}else{
						alert('请选择业务类型');
						$('#ywclass').focus();
						return false;
					}
				}
				
				/**
				 * 查询系统有权工号
				 * @param departname
				 * @return 无返回值
				 */
				function getUserId(departname){
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'jobRightManager.queryuserid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&dept='+tsd.encodeURIComponent(departname),
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
							
									 var thevalue = "<form name='theuseridform'>";
										var i = 1;
										$(xml).find('row').each(function(){
											var userid = $(this).attr("userid");
											var username = $(this).attr("username");
											if(userid!=undefined){
												if(username==''){
													username = userid;
												}
												var thebr = '';
												if(i*1%6==0){
													thebr = '<br/>';
												}
												thevalue += "<span class='spanstyle'><input type='checkbox' name='userids' value='"+userid+"' style='width:20px;height:20px;margin-top:5px;margin-left:5px;'><label style='text-align: left;width:100px;font-size:12px;margin-left:10px'>"+username+"</label></span>"+thebr;
											 	i++;
											 }else{
											 	thevalue = '对不起，该部门下暂无工号!';
											 }
										});
										$('#rightuserid').html(thevalue+'</form>');
							}
						});
				}
			
				/**
				 * 更新状态
				 * @param 无参数
				 * @return 无返回值
				 */
				function openText(){
					clearText('operform');
					//tsd.setTitle($("#input-Unit .title h3"),'');
					
					//document.getElementById('displayinfo').style.display = 'none';
					//document.getElementById('add').style.display = 'block';
					
					$('#saveadd').show();
					$('#saveexit').show();
					$('#modify').hide();
					
					
					//$('#add').show("slow");
					//$('#displayinfo').hide("slow");
					autoBlockForm('add',60,'close',"#ffffff",false);//弹出查询面板
					
					
					$('#titlediv').html('<fmt:message key="global.add" />');
					//hideError();//隐藏错误信息 
				}
			
				
				/**
				 * 在初始化页面的时候将面板加载进来
				 * @param 无参数
				 * @return 无返回值
				 */
			 $(document).ready(function(){
				//参数为你要验证的表单的id	
	  			$("#saveadd").show();
			 	$("#saveexit").show();
				$("#modify").hide();
				
	  			//blockForm('openadd1','operform',5,'close',"#ffffff",false);
	  			//blockForm('openadd2','operform',5,'close',"#ffffff",false);
	  			
			});
				/**
				 * 工号全选或工号反
				 * @param 无参数
				 * @return 无返回值
				 */
			function checkedAllUserid(){
					var tagname=document.getElementsByName('userids');  
					for(var i=0;i<tagname.length;i++){
							if(tagname[i].checked == true){
								tagname[i].checked = false;
								$('#selectall').html('工号全选');
							}else{
								tagname[i].checked = true;
								$('#selectall').html('工号反选');
							}
					}  
			}
				/**
				 * 业务类型
				 * @param 无参数
				 * @return 无返回值
				 */
			function thisDeptClick(){
				var isvalue = $('#dept').find("option:selected").text();
				
				if(isvalue==''||isvalue==null){
					alert('请选择业务类型!');
					$('#ywclass').focus();
					return false;
				}else if(isvalue!=0){
					//显示选择工号
					getUserId(isvalue);
					document.getElementById('displayuserid').style.display='block'; 
				}
			}
			
				/**
				 * 保存宽带工单权限设置 -- 将数据保存到mssql数据库中
				 * @param thesave
				 * @return boolean
				 */
			function saveInfo(thesave){
					if(getIsExist()==false){
							var params=buildParams();
									 if(params==false){return false;}
									 var urlstr=tsd.buildParams({ 	
									 		 						packgname:'service',//java包
												 					clsname:'ExecuteSql',//类名
												 					method:'exeSqlData',//方法名
												 					ds:'tsdReport',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
												 					tsdcf:'mssql',//指向配置文件名称
												 					tsdoper:'exe',//操作类型 
												 					tsdpk:'jobRightManager.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												 				});
										urlstr+=params;
										$.ajax({
											url:'mainServlet.html?'+urlstr,
											cache:false,//如果值变化可能性比较大 一定要将缓存设成false
											timeout: 1000,
											async: false ,//同步方式
											success:function(msg){
												if(msg=="true"){
													//操作成功提示
													alert('<fmt:message key="global.successful"/>','<fmt:message key="global.operationtips"/>');
													if(thesave==1){//保存添加
														//saveInfoMysql();
														clearText('operform');
														//setTimeout($.unblockUI, 5);
														//$('#userid').focus();
														//autoBlockForm('operform',2,'close',"#ffffff",true);//弹出查询面板
														$('#add').show("slow");
														$('#displayuserid').hide();
													}else if(thesave==2){//保存退出
														//saveInfoMysql();
														setTimeout($.unblockUI, 15);
														reloadData();
													}
													
												}	
											}
										});
					}else{
						alert('对不起，不可重复设置工单权限组!');
						$("#ywclass").focus();
						return false;
					}
			}
			
				/**
				 * 将数据保存到mysql中
				 * @param 无参数
				 * @return 无返回值
				 */
			function saveInfoMysql(){
				var params=buildParams();
				if(params==false){return false;}
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mysql',//指向配置文件名称
								 					tsdoper:'exe',//操作类型 
								 					tsdpk:'jobRightManager.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												 				});
						urlstr+=params;
						$.ajax({
											url:'mainServlet.html?'+urlstr,
											cache:false,//如果值变化可能性比较大 一定要将缓存设成false
											timeout: 1000,
											async: false ,//同步方式
											success:function(msg){
												
											}
			  			 });
			
			}
			
			
				/**
				 * 重新加载工单设置数据
				 * @param 无参数
				 * @return 无返回值
				 */
			function reloadData(){
					thisclose();
			 		 var urlstr=tsd.buildParams({ 	
			 		 						packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					datatype:'xml',//返回数据格式 
						 					ds:'tsdReport',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					tsdpk:'jobRightManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'jobRightManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 				});
					var column = $('#thecolumn').val();
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&cloumn='+column}).trigger("reloadGrid");
				 	document.getElementById('displayuserid').style.display='none'; 
				 	setTimeout($.unblockUI, 15);//关闭面板
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
						
					 	var ywclass = $("#ywclass").val();
					 	
					 	var ywtype = $("#ywtype").val();
					 	
					 	var dept = $("#dept").val();
					 	
					 	if(ywclass==0){
					 		alert('请选择业务类型!');
					 		$("#ywclass").focus();
					 		return false;
					 	}
					 	if(ywtype==0){
					 		alert('请选择业务类别!');
					 		$("#ywtype").focus();
					 		return false;
					 	}
					 	
					 	if(dept==0){
					 		alert('请选择部门!');
					 		$("#dept").focus();
					 		return false;
					 	}
					 	
					 	var userid = getTheCheckedUserID();
						
					 	params+="&ywclass="+tsd.encodeURIComponent(ywclass);
					 	params+="&ywtype="+tsd.encodeURIComponent(ywtype);
					 	params+="&dept="+tsd.encodeURIComponent(dept);
					 	params+="&userid="+tsd.encodeURIComponent(userid);
					 	
					 	

						//每次拼接参数必须添加此判断
						if(tsd.Qualified()==false){return false;}
						return params;
					}
					
					/**
					 * 取用户所选中的值
					 * @param 无参数
					 * @return String
					 */
					function getTheCheckedUserID(){
						var thename=document.getElementsByName('userids');  
						var thevalue = '';
						for(var i=0;i<thename.length;i++){
						    if(thename[i].checked==true){
						    	thevalue += thename[i].value + ',';
						    }
						}
						thevalue = thevalue.substring(0,thevalue.lastIndexOf(','));
						
						return thevalue;						
				}
					
					/**
					 * 在显示值时显示确定值，而不是
					 * @param field
					 * @param tablename
					 * @param wheather
					 * @param value
					 * @return String
					 */
				function getRealValue(field,tablename,wheather,value){
					var thisvalue = '';
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'jobRightManager.queryvalue'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&field='+field+'&tablename='+tablename+'&wheather='+wheather+'&value='+tsd.encodeURIComponent(value),
							datatype:'xml',
							cache:true,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
									$(xml).find('row').each(function(){
										thisvalue = $(this).attr(field.toLowerCase());
									});
							}
						});
					return thisvalue;
				}
				
				/**
				 * 该设置权限组是否存在
				 * @param 无参数
				 * @return boolean
				 */
				function getIsExist(){
					var flag = false;
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdReport',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'jobRightManager.queryisexit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						
						var key1 = $("#ywclass").val();
					 	
					 	var key2 = $("#ywtype").val();
					 	
					 	var key3 = $("#dept").val();
						
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&businessclass='+key1+'&businesstype='+tsd.encodeURIComponent(key2)+'&department='+tsd.encodeURIComponent(key3),
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
									$(xml).find('row').each(function(){
																			
										var num = $(this).attr("num");
										if(num>0){
											flag = true;
										}
									});
							}
						});
					return flag;
				}
				/**
				 * 关闭
				 * @param 无参数
				 * @return 无返回值
				 */
				function thisclose(){
					//document.getElementById('displayinfo').style.display = 'none';
					//document.getElementById('add').style.display = 'block';
					
					//$('#displayinfo').show("slow");
					$('#add').hide("slow");
				}
				
				/**
				 * 初始化
				 * @param 无参数
				 * @return 无返回值
				 */
				$(function(){
					$("#add").draggable({handle:"#thisdrag"});
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
					fuheQueryJobRight('jobRightManager.queryByWhere','jobRightManager.queryByWherepage');
				}
				/**
				 * 共用查询
				 * @param querysql
				 * @param querypagesql
				 * @return 无返回值
				 */
				function fuheQueryJobRight(querysql,querypagesql)
				{
					var params = fuheQbuildParams();
					if(params=='&fusearchsql='){
						params +='1=1';
					}
				 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
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
				 * 复合查询参数获取，@oper 操作类型 fuhe
				 * @param 无参数
				 * @return String
				 */
				function fuheQbuildParams(){
					 	//每次拼接参数必须初始化此参数
						tsd.QualifiedVal=true;
					 	var params='';
					 	
					 	//修改，解决高级查询时 查询业务类别无法查出结果的问题。
					 	var flag = false;
					 	var queryByWhere = '';
					 	var indexBusClass = $("#fusearchsql").val().indexOf('businessclass');
					 	var indexBusType = $("#fusearchsql").val().indexOf('businesstype');
					 	if (indexBusClass != -1 || indexBusType != -1) {
					 		//暂未发现好的解决办法
					 		var indexD = $("#fusearchsql").val().lastIndexOf('=');
					 		var endIndex = $("#fusearchsql").val().length - 1;
					 		var queryValues = $("#fusearchsql").val().substring(indexD+1, endIndex);
					 		var temp = '';  
					 		if (indexBusClass != -1 ) {
					 			temp = '(select typeid from ywsl_type  where typename = ';
					 		} else {
					 			temp = '(SELECT distinct ywlx FROM ywsl_code where ShowName= ';
					 		}
					 		queryByWhere = $("#fusearchsql").val().substring(0,indexD+1) + temp + queryValues + '))';
					 		flag = true;
					 	}
					 	if(flag == false) {
					 		queryByWhere = $("#fusearchsql").val();
					 	}
					 	//如果有可能值是汉字 请使用encodeURI()函数转码
					 	//var fusearchsql = encodeURIComponent($("#fusearchsql").val());
					 	var fusearchsql = encodeURIComponent(queryByWhere);			 	
					 	params+='&fusearchsql='+fusearchsql;
					 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
					 	//每次拼接参数必须添加此判断
						if(tsd.Qualified()==false){return false;}
						return params;
				}
				
				/**
				 * 组合排序
				 * @param sqlstr
				 * @return 无返回值
				 */
				function zhOrderExe(sqlstr){
						var params = '';
						params = fuheQbuildParams();	
						if(params=='&fusearchsql='){
							params +='1=1';
						}
						var column = $("#thecolumn").val();		
						params =params+'&orderby='+sqlstr+'&column='+column;
						params += '&orderkey=businessclass';
						params += '&ordertablename=job_canoperateuserid';
						sql = 'main.queryByOrder';
						pagesql = 'main.queryByOrderpage';
							
					 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
					 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
													  clsname:'ExecuteSql',//类名
													  method:'exeSqlData',//方法名
													  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
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
				 * 重写保存模板的方法
				 * @param 无参数
				 * @return 无返回值
				 */
			function opensaveQ(){		
					//获取查询树信息
					var fusearchsql = $("#fusearchsql").val();	
					
					var treepid = $("#treepid").val();
					
					if(treepid==''||fusearchsql=='&fusearchsql='){
						alert('请先用高级查询，在保存。');
						return;
					}
				 	var addinfo = $("#addinfo").val(); 	
				 	//tsd.setTitle($("#input-Unit .title h3"),addinfo); 	
					clearText('addquery');
					hideError();//隐藏错误信息	
					autoBlockForm('modT',60,'closeModB',"#ffffff",false);//弹出查询面板
					//autoBlockFormAndSetWH('addquery',60,60,'Qclose',"#ffffff",false,730,'');//弹出查询面板
			}
			</script>
			
			<style type="text/css">
				.titlemargin{margin-left:73px !important;margin-left:38px;}
				.tdstyle{border-bottom:1px solid #A9C8D9;}
				.spanstyle{display:-moz-inline-box; display:inline-block; width:100px}
			</style>
  </head>
  
  <body>
  		<form name="childform" id="childform">
			<input type="text" id="queryName" name="queryName" value=""
				style="display: none" />
			<input type="text" id="querysql" name="querysql" 
				style="display: none"/>
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
		<div id="displayinfo" style="text-align: left" class="thisunder">
			<!-- 用户操作标题以及放一些快捷按钮-->
			<div id="buttons" style="width: 100%">
				<button type="button" id="order1" onclick="openDiaO('job_canoperateuserid');" >
				<!-- 组合排序 -->	<fmt:message key="order.title" />
				</button>
				<button type="button" id="openadd1" onclick="openText()"
					disabled="disabled">
					<fmt:message key="global.add" />
				</button>
				
				<button type="button" id="query1" onclick="openDiaQueryG('query','job_canoperateuserid')" 
					disabled="disabled">
					高级查询
				</button>
				<button id='gjquery1' onclick='openQueryM(1);' >
					<fmt:message key="oper.mod"/>
				</button>
			
				<button id='savequery1' onclick="opensaveQ();" disabled="disabled">
					<fmt:message key="oper.modSave"/>
				</button> 
			</div>
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
			<div id="buttons">
				<button type="button" id="order2" onclick="openDiaO('job_canoperateuserid');" >
				<!-- 组合排序 -->	<fmt:message key="order.title" />
				</button>
				<button type="button" id="openadd2" onclick="openText()"
					disabled="disabled">
					<fmt:message key="global.add" />
				</button>
				
				<button type="button" id="query2" onclick="openDiaQueryG('query','job_canoperateuserid')" 
					disabled="disabled">
					高级查询
				</button>
				<button id='gjquery2' onclick='openQueryM(1);' >
					<fmt:message key="oper.mod"/>
				</button>
			
				<button id='savequery2' onclick="opensaveQ();" disabled="disabled">
					<fmt:message key="oper.modSave"/>
				</button> 
				
			</div>
		</div>
		<input type="hidden" id="addright" />
		<input type="hidden" id="deleteright" />
		<input type="hidden" id="editright" />
		<input type="hidden" id="editfields" />
		
		<input id="thecolumn" type="hidden"/>
		<input id="key1" type="hidden"/>
		<input id="key2" type="hidden"/>
		<input id="key3" type="hidden"/>
		
		<div class="neirong" id="add" style="display: none;width: 800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">项目名称</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="reloadData();">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
			
					<div class="midd" >
					   <form action="#" name="operform" id="operform" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="labelclass">
										<label for="sarea">
											<span id="sywclass"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="ywclass" class="textclass" onchange="getTheDept()"></select>
										
										<font style="color:red;">*</font>
									</td>
									
									<td class="labelclass">
										<label for="sarea">
											<span id="sywtype"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="ywtype" style="width: 150px" class="textclass"></select>
										
										<font style="color:red;">*</font>
										
									</td>
									<td class="labelclass">
										<label for="sarea">
											<span id="sdept"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="dept" style="width: 150px" class="textclass" onclick="thisDeptClick()"></select>
										
										<font style="color:red;">*</font>
									</td>
								</tr>
								<tr id="displayuserid" style="display: none;" >
									<td class="dflabelclass" width="12%">
										<label for="sarea" style="width: 90px">
											<span id="srightuserid"></span>
										</label>
									</td>
									<td colspan="5" width="80%" style="text-align: left;">
										<div id="rightuserid" style='max-height:200px;overflow-y: auto;overflow-x: hidden;'>
										</div>
									</td>
								</tr>
							</table>
						</form>
					</div>	
				
					<div class="midd_butt">
							<button type="submit" class="tsdbutton" id="selectall" onclick="checkedAllUserid()">
								工号全选
							</button>
							
							<button type="submit" class="tsdbutton" id="saveadd" onclick="saveInfo(1)">
								保存添加
							</button>
							<button type="submit" class="tsdbutton" id="saveexit" onclick="saveInfo(2)" style="margin-left: 10px">
								保存退出
							</button>
							<button type="submit" class="tsdbutton" id="modify" onclick="modifyInfo();">
								<fmt:message key="global.edit" />
							</button>
							<button type="button" class="tsdbutton" id="close" style="margin-left: 10px" onclick="reloadData();">
								<fmt:message key="global.close" />
							</button>
					</div>
	<%
		String theIE = request.getHeader("User-Agent");
		int theflag = 0;
		if(theIE.indexOf("MSIE 6.0")!=-1){
			theflag = 1;
		}else if(theIE.indexOf("MSIE 7.0")!=-1||theIE.indexOf("MSIE 8.0")!=-1){
			theflag = 2;
		}
	%>		
	<%
		if(theflag==1){
	%>
		<br/>
		<br/>
		<br/>
		<br/>
	<%		
		}else if(theflag==2){
	%>
		<br/>
	<%		
		}
	%>
		</div>
		
		
		
		<!-- 添加模板面板 -->
		<div id="modT" name='modT' style="display: none"  class="neirong" style="width:800px">
			<br/>
			<div class="top">
			<div class="top_01">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" >查询模板保存</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
				</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
				<div class="midd" >
				<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
					<input type="hidden" ></input>
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
				<input type="hidden" id="whichorder" value="2"/>		
				<input type="hidden" id="successful"  value="<fmt:message key="global.successful"/>" />		
				
				<input type="hidden" id="useridd" value="<%=userid%>"/>				
				<input type="hidden" id="zid" value="<%=zid%>"/>	
				<input type="hidden" id="imenuid" value="<%=imenuid%>"/>
				
	
  </body>
</html>
