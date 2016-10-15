<%----------------------------------------
	name: procedureManager.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 对存储过程的一个管理
	modify: 
		2009-11-26 chenliang  添加功能注释.
        2009-12-30 chenliang  统一样式和显示布局
        2010-01-08 chenliang  修改样式显示问题
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String userid = (String) session.getAttribute("userid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Procedure-Manager</title>
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
				 $("#navBar1").append(genNavv());
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'procedureManager.getPower',//存储过程的映射名称
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
				
				$.ajax({
						url:'mainServlet.html?'+urlstr+'&userid='+userid+'&groupid='+groupid+'&menuid='+imenuid,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
									var spower = $(this).attr("spower");
									if(spower=='all'){
										addright = 'true';
										deleteright = 'true';
										editright = 'true';
										exportright = 'true';
										queryright = 'true';				
										saveQueryMright ='true';
										editfields = '';
										flag = true;
									}else if(spower!=''&&spower!='all'){
										addright += getCaption(spower,'add','')+'|';
										
										deleteright += getCaption(spower,'delete','')+'|';
										
										editright += getCaption(spower,'edit','')+'|';
										
										editfields += getCaption(spower,'editfields','');
										
										exportright += getCaption(spower,'export','')+'|';
										
										queryright += getCaption(spowerarr[i],'query','')+'|';
							
										saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
									}
								});
							}
				});
				
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
					isReadonly(false);
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
		
			/**
			 * 将受限字段复原 
			 * @param status(状态)
			 * @return 无返回值
			 */
			function isReadonly(status){
				var fields = getFields('per_storedprocedure');
				var fieldarr = fields.split(",");
				for(var j = 0 ; j <fieldarr.length-1;j++){
					document.getElementById(fieldarr[j]).disabled = status;
				}
			}
			
			
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
				/**********************
				**   取得当前用户的权限  *
				**********************/
				getUserPower();
				///设置命令参数
			 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xml',//返回数据格式 
						 					tsdpk:'procedureManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'procedureManager.queryPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			var column  = '';
			//修改|删除
			var thisdata = loadData('per_storedprocedure','<%=languageType %>',1,"<fmt:message key='procedureManager.modifyAndDelete' />");
			column = thisdata.FieldName.join(',');			 					
			
			$('#thecolumn').val(column);
			
			$("#pid").html(thisdata.getFieldAliasByFieldName('id'));
			$('#sshownames').html(thisdata.getFieldAliasByFieldName('sshowname'));
			$('#pshowname').html(thisdata.getFieldAliasByFieldName('sshowname'));
			$('#snames').html(thisdata.getFieldAliasByFieldName('sname'));
			$('#spronames').html(thisdata.getFieldAliasByFieldName('sproname'));
			$('#pproname').html(thisdata.getFieldAliasByFieldName('sproname'));
			$('#spagenames').html(thisdata.getFieldAliasByFieldName('spagename'));
			$('#ppagename').html(thisdata.getFieldAliasByFieldName('spagename'));
			
		
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
			//jqgrid隐藏某一列的值
			//thisdata.colModels[1].hidden=true;
			
			thisdata.setWidth({Operation:80});		
			
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&cloumn='+column,
				datatype: 'xml', 
				colNames:thisdata.colNames, 
				colModel:thisdata.colModels, 
				       	rowNum:15, 
				       	rowList:[10,15,20], 
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'id', 
				       	viewrecords: true, 
				       	sortorder: 'asc', 
				       	caption:'<fmt:message key="pro.management"/>', 
				       	height:document.documentElement.clientHeight-182,
				        //width:document.documentElement.clientWidth-50,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										//修改删除	
										addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" alt="'+'<fmt:message key="procedureManager.modify" />'+'"/>','openRowModify','id','click',1);
										addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_02.gif" alt="'+'<fmt:message key="procedureManager.delete" />'+'"/>','deleteRow','id','click',2);
										
										/////执行行按钮添加
										//////表格ID
										///////依赖于addRowOperBtn(gridId,linkName,url,idName,outType)函数
										executeAddBtn('editgrid',2);
										///自动适应 工作空间
										// var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										// setAutoGridHeight("editgrid",reduceHeight);
										// setAutoGridWidth("editgrid",'0');
										}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} 
					); 
			});
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
			</script>

		<script type="text/javascript">
				/*********************************
				**             添加信息            **
				***********************************/
				/**
				 * 弹出添加面板
				 * @param 无参数
				 * @return 无返回值
				 */
				function openText(){
					//tsd.setTitle($("#input-Unit .title h3"),'<fmt:message key="global.add"/>');
					//document.getElementById('id').readOnly = false;
					$('#titlediv').html('<fmt:message key="global.add"/>');
					isReadonly(false);
			 		$("#saveadd").show();
			 		$("#saveexit").show();
			 		autoBlockForm('add',60,'close',"#ffffff",false);//弹出面板
					$("#modify").hide();
					clearText('operform');
					hideError();//隐藏错误信息 
				}
				/**
				 * 拼参数
				 * @param 无参数
				 * @return String(成功)/false(文本框验证失败)
				 */
				function buildParams(){
					//每次拼接参数必须初始化此参数
					tsd.QualifiedVal=true;
				
					var params="";
					var id=$("#id").val();
					var sshowname=$("#sshowname").val();
					var spagename=$("#spagename").val();
					var sname=$("#sname").val();
					var sproname=$("#sproname").val();
					
					if(id!=null&&id!=""){
						params+="&id="+tsd.encodeURIComponent(id);
					}else{
						alert('<fmt:message key="pro.isid"/>!','<fmt:message key="global.operationtips"/>');
						$('#id').focus();
						return false;
					}
					if(sshowname!=null&&sshowname!=""){
						params+="&sshowname="+tsd.encodeURIComponent(sshowname);
					}else{
						alert('<fmt:message key="pro.isdisplayname"/>!','<fmt:message key="global.operationtips"/>');
						$('#sshowname').focus();
						return false;
					}
					if(spagename!=null&&spagename!=""){
						params+="&spagename="+tsd.encodeURIComponent(spagename);
					}else{
						alert('<fmt:message key="pro.ispagename"/>!','<fmt:message key="global.operationtips"/>');
						$('#spagename').focus();
						return false;
					}
					
					params+="&sname="+tsd.encodeURIComponent(sname);
					
					if(sproname!=null&&sproname!=""){
						params+="&sproname="+tsd.encodeURIComponent(sproname);
					}else{
						alert('<fmt:message key="pro.ispro"/>!','<fmt:message key="global.operationtips"/>');
						$('#sproname').focus();
						return false;
					}
					
					var thestate = $('#thestate').val();
						var theloginfo = '';
						var thetype = '';
						
						var thefieldalias = fetchFieldAlias('per_storedprocedure','<%=languageType %>');
						if(thestate==0){
							//添加权限组信息,记录日志
							thetype = 'add';
							theloginfo = "(per_storedprocedure)"+tsd.encodeURIComponent("<fmt:message key='global.add'/>")+tsd.encodeURIComponent("<fmt:message key='pro.procedure'/>：");
							theloginfo += tsd.encodeURIComponent(thefieldalias['id']) + ':' + tsd.encodeURIComponent(id) + ',';
							theloginfo += tsd.encodeURIComponent(thefieldalias['sshowname']) + ':' + tsd.encodeURIComponent(sshowname) + ',';
							theloginfo += tsd.encodeURIComponent(thefieldalias['spagename']) + ':' + tsd.encodeURIComponent(spagename) + ',';
							theloginfo += tsd.encodeURIComponent(thefieldalias['sproname']) + ':' + tsd.encodeURIComponent(sproname) + ',';
							
							if(sname!=''&&null!=sname){
								theloginfo += tsd.encodeURIComponent(thefieldalias['sname']) + ':' + tsd.encodeURIComponent(sname);
							}
						}else if(thestate==1){
							//修改权限组信息,记录日志
							thetype = 'modify';
							theloginfo = "(per_storedprocedure)"+tsd.encodeURIComponent("<fmt:message key='global.edit'/>")+id+tsd.encodeURIComponent("<fmt:message key='pro.procedure'/>")+tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：");
							
							var thearr = getProInfo(id,0);
							
							if(thearr['sshowname']!=sshowname){
								theloginfo += tsd.encodeURIComponent(thefieldalias['sshowname']) + ':' + tsd.encodeURIComponent(thearr['sshowname']) + '>>>' + tsd.encodeURIComponent(sshowname) +';';
							}
							if(thearr['spagename']!=spagename){
								theloginfo += tsd.encodeURIComponent(thefieldalias['spagename']) + ':' + tsd.encodeURIComponent(thearr['spagename']) + '>>>' + tsd.encodeURIComponent(spagename) +';';
							}
							if(thearr['sproname']!=sproname){
								theloginfo += tsd.encodeURIComponent(thefieldalias['sproname']) + ':' + tsd.encodeURIComponent(thearr['sproname']) + '>>>' + tsd.encodeURIComponent(sproname) +';';
							}
							if(thearr['sname']!=sname){
								theloginfo += tsd.encodeURIComponent(thefieldalias['sname']) + ':' + tsd.encodeURIComponent(thearr['sname']) + '>>>' + tsd.encodeURIComponent(sname) +';';
							}
						}
						writeLogInfo('',thetype,theloginfo);
					
					
					//每次拼接参数必须添加此判断
					if(tsd.Qualified()==false){return false;}
				
					return params;
					
				}
				/**
				 * 获得结果集显示所需参数
				 * @param id(唯一标识)
				 * @param type(类型)
				 * @return 数组
				 */
				function getProInfo(id,type){
					var arr = new Array();
					var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'procedureManager.queryDataByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&id='+id,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									var id = $(this).attr("id");
									var sshowname = $(this).attr("sshowname");
									var spagename = $(this).attr("spagename");
									var sname = $(this).attr("sname");
									var sproname = $(this).attr("sproname");
									
									//在做修改时需要进行判断的值参数
									arr['id'] = id;
									arr['sshowname'] = sshowname;
									arr['spagename'] = spagename;
									arr['sname'] = sname;
									arr['sproname'] = sproname;
									
									if(type==1){
										var theuserinfo = fetchFieldAlias('per_storedprocedure','<%=languageType %>');
										var delinfo = '';
										delinfo += tsd.encodeURIComponent(theuserinfo['id']) + ':' + tsd.encodeURIComponent(id) + ';' ;
										delinfo += tsd.encodeURIComponent(theuserinfo['sshowname']) + ':' + tsd.encodeURIComponent(sshowname) + ';' ;
										delinfo += tsd.encodeURIComponent(theuserinfo['spagename']) + ':' + tsd.encodeURIComponent(spagename) + ';' ;
										delinfo += tsd.encodeURIComponent(theuserinfo['sname']) + ':' + tsd.encodeURIComponent(sname) + ';' ;
										delinfo += tsd.encodeURIComponent(theuserinfo['sproname']) + ':' + tsd.encodeURIComponent(sproname) + ';' ;
										
										$('#thedelinfo').val(delinfo);
									}
								});
							}
						});
					return arr;
				}
				
				/**
				 * 添加完成，进行数据交互即保存
				 * @param thesave(添加类型：1.保存添加；2.保存退出)
				 * @return 无返回值
				 */
				function saveInfo(thesave){
					var pid = $("#id").val();
					var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'procedureManager.querygroupid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
					$.ajax({
						url:'mainServlet.html?'+urlstr,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							var flag = false;
							$(xml).find('row').each(function(){
								var gid = $(this).attr("id");
								if(gid==pid){
									alert('<fmt:message key="powergroup.worn"/>!','<fmt:message key="global.operationtips"/>');
									flag = true;
								}
							});
							
							if(flag==false){
								/***************************
								*     判断完成，进行保存操作   * 
								***************************/
									$('#thestate').val(0);
									var params=buildParams();
								 	if(params==false){return false;}
								 		 var urlstr=tsd.buildParams({ 	
								 		 						packgname:'service',//java包
											 					clsname:'ExecuteSql',//类名
											 					method:'exeSqlData',//方法名
											 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
											 					tsdcf:'mssql',//指向配置文件名称
											 					tsdoper:'exe',//操作类型 
											 					tsdpk:'procedureManager.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											 				});
										urlstr+=params;
									$.ajax({
										url:'mainServlet.html?'+urlstr,
										cache:false,//如果值变化可能性比较大 一定要将缓存设成false
										timeout: 1000,
										async: false ,//同步方式
										success:function(msg){
											if(msg=="true"){
												alert('<fmt:message key="global.successful"/>','<fmt:message key="global.operationtips"/>');
												
												if(thesave==1){
													clearText('operform');
													$('#pid').focus();
												}else if(thesave==2){
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
				 * @return 无返回值(删除成功)/false(数据库中无此信息)
				 */
				 function deleteRow(key){
				 	var deleteright = $('#deleteright').val();
				 	if(deleteright=="true"){
					 	if(confirm('<fmt:message key="global.deleteinformation"/>')){
							 //设置命令参数
					 		 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
										 					clsname:'ExecuteSql',//类名
										 					method:'exeSqlData',//方法名
										 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
										 					tsdcf:'mssql',//指向配置文件名称
										 					tsdoper:'exe',//操作类型 
										 					tsdpk:'procedureManager.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										 				});
								getProInfo(key,1);
								var thedeleteinfo = $('#thedelinfo').val();
								writeLogInfo('','delete',thedeleteinfo);
								$.ajax({
									url:'mainServlet.html?'+urlstr+'&id='+key,
									cache:false,//如果值变化可能性比较大 一定要将缓存设成false
									timeout: 1000,
									async: false ,//同步方式
									success:function(msg){
										if(msg=="true"){
											alert('<fmt:message key="global.successful"/>','<fmt:message key="global.operationtips"/>');
											setTimeout($.unblockUI, 15);
											reloadData();
										}	
									}
								});
						}
					}else{
						alert('<fmt:message key="global.deleteright"/>!','<fmt:message key="global.operationtips"/>');
						return;
					}
			 	}
				/**
				 * 修改信息  
				 * @param key(唯一标识)
				 * @return 无返回值
				 */
				function openRowModify(key){
					var editright = $('#editright').val();
					if(editright=="true"){
						document.getElementById('id').disabled = true;
						//tsd.setTitle($("#input-Unit .title h3"),'<fmt:message key="global.edit"/>');
						$('#titlediv').html('<fmt:message key="global.edit"/>');
						$("#modify").show();
						$("#saveadd").hide();
						$("#saveexit").hide();
						
						hideError();//隐藏错误信息 
						clearText('operform'); 
						$("#id").val(key);
					
						///设置命令参数
						 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'procedureManager.queryDataByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&id='+key,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									var sshowname=$(this).attr("sshowname");
									var spagename=$(this).attr("spagename");
									var sname=$(this).attr("sname");
									var sproname=$(this).attr("sproname");
									
									$("#sshowname").val(sshowname);
									$("#spagename").val(spagename);
									$("#sname").val(sname);
									$("#sproname").val(sproname);
									
									var editfields = $("#editfields").val();
									
									/*************************************
									**   将当前表的所有字段取出来，分割字符串 ***
									*************************************/
									var fields = getFields('per_storedprocedure');
									
									if(fields!=undefined){
										var fieldarr = fields.split(",");
										/**********************************
										**   将当前表中的spower字段取出来 *****
										**********************************/
										var spower = editfields.split(",");
										
										for(var i=0;i<spower.length;i++){
											for(var j = 0 ; j <fieldarr.length-1;j++){
												if(spower[i]==fieldarr[j]){
													document.getElementById(spower[i]).disabled = false;
													break;
												}
											}
										}
									}
								});
								autoBlockForm('add',60,'close',"#ffffff",false);//弹出面板
							}
						});
					}else{
						alert('<fmt:message key="global.editright"/>!','<fmt:message key="global.operationtips"/>');
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
					 key=$("#id").val();
							///设置命令参数
					 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'exe',//操作类型 
								 					tsdpk:'procedureManager.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						urlstr+=params;
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&id='+key,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){
									alert('<fmt:message key="global.successful"/>','<fmt:message key="global.operationtips"/>');
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
			 		///设置命令参数
				 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
							 					clsname:'ExecuteSql',//类名
							 					method:'exeSqlData',//方法名
							 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 					tsdcf:'mssql',//指向配置文件名称
							 					tsdoper:'query',//操作类型 
							 					datatype:'xml',//返回数据格式 
							 					tsdpk:'procedureManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 					tsdpkpagesql:'procedureManager.queryPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							 					});
					var column = $('#thecolumn').val();
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&cloumn='+column}).trigger("reloadGrid");
				 	setTimeout($.unblockUI, 15);//关闭面板
				
				}
				
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
				fuheDisQuery('procedureManager.queryDataByWhere','procedureManager.queryDataByWherePage');
			}
			/**
			 * 简单查询的具体操作
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
			 * 弹出简单查询面板
			 * @param 无参数
			 * @return 无返回值
			 */
			function openQueryPro(){
				clearText('queryproforms');
				$('#whichorder').val(0);//简单查询
				autoBlockForm('queryproform',60,'queryclose',"#ffffff",false);//弹出面板
			}
			
			/**
			 * 执行查询
			 * @param 无参数
			 * @return 无返回值
			 */
			function queryPro(){
				var pshowname = $('#queryshowname').val();
				var ppagename = $('#querypagename').val();
				var proname = $('#queryproname').val();
				
				var params = '';
				params += '&sshowname=' +  tsd.encodeURIComponent(pshowname);
				params += '&spagename=' + tsd.encodeURIComponent(ppagename);
				params += '&sproname=' + tsd.encodeURIComponent(proname);
				
				var expparams = ' 1=1 ';
				if(pshowname!=''){
					expparams += " and sshowname='" +  tsd.encodeURIComponent(pshowname) + "'";
				}
				if(ppagename!=''){
					expparams += " and spagename='" +  tsd.encodeURIComponent(ppagename) + "'";
				}
				if(proname!=''){
					expparams += " and sproname='" +  tsd.encodeURIComponent(proname) + "'";
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
						 					tsdpk:'proManager.queryjd',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'proManager.querypagejd'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
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
						//alert('请先用高级查询，在保存。');
						alert("<fmt:message key='procedureManager.SeniorInquiresAndSave' />");
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
				 * @param sqlstr(排序语句)
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
							sql = 'proManager.queryjd';
							pagesql = 'proManager.querypagejd';
						}else if(flag==1||flag==2){
							params = fuheQbuildParams();	
							if(params=='&fusearchsql='){
								params +='1=1';
							}
							var column = $("#thecolumn").val();		
							params =params+'&orderby='+sqlstr+'&column='+column;
							params += '&orderkey=id';
							params += '&ordertablename=per_storedprocedure';
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
				
			</script>
		<style type="text/css">
			.titlemargin{margin-left:90px !important;margin-left:45px;}
			.tdstyle{border-bottom:1px solid #A9C8D9;}
			.spanstyle{display:-moz-inline-box; display:inline-block; width:115px}
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
							<fmt:message key="global.location" />:
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
		<div id="buttons">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="order1" onclick="openDiaO('per_storedprocedure');" >
				<!-- 组合排序 -->	<fmt:message key="tariff.order" />
			</button>
			<button type="button" id="openadd1" onclick="openText()" disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openQueryPro()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query1" disabled="disabled"
				onclick="openDiaQueryG('query','per_storedprocedure')">
				<!-- 高级查询 -->
				<fmt:message key="procedureManager.SeniorInquires" />
			</button>
			<button id='gjquery1' onclick='openQueryM(1);' >
				<fmt:message key="oper.mod"/>
			</button>
			
			<button id='savequery1' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="exp1" onclick="thisDownLoad('tsdBilling','mssql','per_storedprocedure','<%=languageType %>',6)"
					disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
		<div id="buttons">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="order2" onclick="openDiaO('per_storedprocedure');" >
				<!-- 组合排序 -->	<fmt:message key="order.title" />
			</button>
			<button type="button" id="openadd2" onclick="openText()" disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openQueryPro()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query2" disabled="disabled"
				onclick="openDiaQueryG('query','per_storedprocedure')">
				<!-- 高级查询 -->
				<fmt:message key="procedureManager.SeniorInquires" />
			</button>
			<button id='gjquery2' onclick='openQueryM(1);' >
				<fmt:message key="oper.mod"/>
			</button>
			
			<button id='savequery2' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button> 
			<button type="button" id="exp2" onclick="thisDownLoad('tsdBilling','mssql','per_storedprocedure','<%=languageType %>',6)"
					disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		
		
		<div class="neirong" id="add" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">
								<!-- 添加 -->
								<fmt:message key="procedureManager.add" />
								</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="clearText('operform');reloadData();">
								<!-- 关闭 -->
								<fmt:message key="procedureManager.close" />
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
									<label for="pid" id="pid"></label>
								</td>
								<td class="tdstyle">
									<input type="text" name="pid" id="id" class="textclass" style="ime-mode: Disabled;width:150px" onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="4" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" disabled="disabled" />
									<font style="color:red;">*</font>
								</td>
								<td class="labelclass">
									<label for="sshownames" id="sshownames"></label>
								</td>
								<td class="tdstyle">
									<input type="text" name="sshowname" id="sshowname" class="textclass" style="width:150px" disabled="disabled" />
									<font style="color:red;">*</font>
								</td>
								
								<td class="labelclass">
									<label for="spagenames" id="spagenames"></label>
								</td>
								<td class="tdstyle">
									<input type="text" name="spagenames" id="spagename" style="width:150px" class="textclass" disabled="disabled" />
									<font style="color:red;">*</font>
								</td>
							</tr>
							
							<tr>	
								<td class="dflabelclass">
									<label for="snames" style="width: 90px">
										<span id="snames"></span>
									</label>
								</td>
								<td>
									<input type="text" name="sname" id="sname" class="textclass" style="width:150px" disabled="disabled"/>
								</td>
								<td class="dflabelclass">
									<label for="spronames" style="width: 90px">
										<span id="spronames"></span>
									</label>
								</td>
								<td>
									<input type="text" name="sproname" id="sproname" style="width:150px" class="textclass" disabled="disabled"/>
									<font style="color:red;">*</font>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" style="width: 80px" id="saveadd" onclick="saveInfo(1)">
						<!-- 保存添加 -->
						<fmt:message key="procedureManager.saveAndAdd" />
					</button>
					<button type="submit" class="tsdbutton" style="width: 80px" id="saveexit" onclick="saveInfo(2)" style="margin-left: 10px">
						<!-- 保存退出 -->
				      	<fmt:message key="procedureManager.saveAndclose" />
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

			<input type="hidden" id="addright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="exportright" />
			
			<input type="hidden" id="editfields" />

			<input type="hidden" id="thedelinfo" />
			<input type="hidden" id="thestate" />
			<input type="hidden" id="thecolumn" />
			
			<input type="hidden" id="userid" value="<%=userid%>" />
			<%@page import="com.tsd.service.util.Log"%>
			<input type='hidden' id='userloginip'
				value='<%=Log.getIpAddr(request)%>' />
			<input type='hidden' id='userloginid'
				value='<%=session.getAttribute("userid")%>' />
			<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		</div>
		
		<!-- 简单查询面板 -->
		<div class="neirong" id="queryproform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">
								<!-- 查询 -->
				      		        	<fmt:message key="procedureManager.query" />
								</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#queryclose').click();">
							<!-- 关闭 -->
				                 	<fmt:message key="procedureManager.close" />
							</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" name="queryproforms"
							id="queryproforms" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>	
								<td class="dflabelclass">
									<label id="pshowname"></label>
								</td>
								<td>
									<input type="text" id="queryshowname" class="textclass" style="width:150px"/>
									<font style="color:red;">*</font>
								</td>
								
								<td class="dflabelclass">
									<label id="ppagename"></label>
								</td>
								<td>
									<input type="text" id="querypagename" style="width:150px" class="textclass"/>
									<font style="color:red;">*</font>
								</td>
								<td class="dflabelclass">
									<label id="pproname"></label>
								</td>
								<td>
									<input type="text" id="queryproname" style="width:150px" class="textclass" />
									<font style="color:red;">*</font>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" onclick="queryPro()">
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
				                <fmt:message key="procedureManager.InquiresTheTemplateSave" />
						</div>
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
				
			<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">
								<!-- 选择您要导出的数据字段 -->
				        			<fmt:message key="procedureManager.chooseData" />
								</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();">
							<!-- 关闭 -->
				        	        <fmt:message key="procedureManager.close" />
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
				        <fmt:message key="procedureManager.checkAll" />
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="getTheCheckedFields('tsdBilling','mssql','per_storedprocedure')">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
				</div>
		</div>	
		<input type="hidden" id="useridd" value="<%=userid %>"/>
		<input type="hidden" id="operationtips"
					value="<fmt:message key="global.operationtips"/>" />
		<input type="hidden" id="successful"
					value="<fmt:message key="global.successful"/>" />	
	</body>
</html>
