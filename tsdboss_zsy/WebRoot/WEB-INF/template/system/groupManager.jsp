<%----------------------------------------
	name: groupManager.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 对权限组的一个管理
	modify: 
		2009-11-26 chenliang  添加功能注释.
      	2009-12-01 chenliang  添加返回功能和字段别名的修改
      	2009-12-14 chenliang  整理权限组显示
      	2011-01-14 chenze     添加特殊权限组限制，完善权限组关联性限制
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<title>Group-Manager</title>
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
		
		<script type="text/javascript" src="script/public/datalength.js"></script>
		
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
							 					  tsdpname:'groupManager.getPower',//存储过程的映射名称
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
				var queryright = '';
				
				var exportright = '';
				
				var editfields = '';
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
				
				var str = 'true';
				if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){
							addright += getCaption(spower,'add','')+'|';
										
							deleteright += getCaption(spower,'delete','')+'|';
										
							editright += getCaption(spower,'edit','')+'|';
							
							exportright += getCaption(spower,'export','')+'|';
							
							queryright += getCaption(spower,'query','')+'|';
										
							editfields += getCaption(spower,'editfields','');
							
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
							saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
						}
				}else if(spower=='all@'){
						$("#addright").val(str);
						$("#deleteright").val(str);
						$("#editright").val(str);
						$("#exportright").val(str);
						$("#queryright").val(str);
						$("#queryright").val(str);
						$("#saveQueryMright").val(str);
						isReadonly(false);
						flag = true;
				}	
				var hasadd = addright.split('|');
				var hasdelete = deleteright.split('|');
				var hasedit = editright.split('|');
				var hasexport = editright.split('|');
				var hasquery = queryright.split('|');
				
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
				/**
				 * 将受限字段复原
				 * @param status(状态)
				 * @return 无返回值
				 */
				function isReadonly(status){
					var fields = getFields('sys_powergroup');
					var fieldarr = fields.split(",");
					for(var j = 0 ; j <fieldarr.length-1;j++){
						if(document.getElementById(fieldarr[j])!=''&&document.getElementById(fieldarr[j])!=undefined){
							document.getElementById(fieldarr[j]).disabled = status;
						}
					
					}
				}
				///////////////////进行字段判断
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
						 					tsdpk:'groupManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'groupManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 					});
			var column  = '';
			var thisdata = loadData('sys_powergroup','<%=languageType%>',1,'<fmt:message key="groupManager.modifyAndDelete" />');
			column = thisdata.FieldName.join(',');			 					
			$('#thecolumns').val(column);
			$("#qxid").html(thisdata.getFieldAliasByFieldName('groupid'));
			$("#sqxid").html(thisdata.getFieldAliasByFieldName('groupid'));
			
			$("#qxname").html(thisdata.getFieldAliasByFieldName('groupname'));
			$("#sqxname").html(thisdata.getFieldAliasByFieldName('groupname'));
			
			$("#qxmemo").html(thisdata.getFieldAliasByFieldName('memo'));
			
			//jqgrid隐藏某一列的值
			thisdata.colModels[1].hidden=true;
			thisdata.colModels[0].width=80;
			//thisdata.setWidth({Operation:13,groupid:20});		
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&cloumn='+column, 
				datatype: 'xml', 
				colNames:thisdata.colNames, 
				colModel:thisdata.colModels, 
				       	rowNum:15, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'groupid', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:'<fmt:message key="powergroup.management"/>', 
				       	height:document.documentElement.clientHeight-185,
				       	width:document.documentElement.clientWidth-25,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										///自动适应 工作空间
										// var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										// setAutoGridHeight("editgrid",reduceHeight);
										
										
										addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" alt="'+'<fmt:message key="groupManager.modify" />'+'"/>','openRowModify','groupid','click',1,"groupname");
										addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_02.gif" alt="'+'<fmt:message key="groupManager.delete" />'+'"/>','deleteRow','groupid','click',2,"groupname");
									 
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
				 * 弹出添加面板
				 * @param 无参数
				 * @return 无返回值
				 */
				function openText(){
					var addinfo = $("#addinfo").val();
					isReadonly(false);
					//tsd.setTitle($("#input-Unit .title h3"),addinfo);
					$('#titledivs').html(addinfo);
			 		$("#saveadd").show();
			 		$("#saveexit").show();
			 		autoBlockForm('add',60,'close',"#ffffff",false);//弹出查询面板
					$("#modify").hide();
					clearText('operform');
					//hideError();//隐藏错误信息 
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
					 	var groupid = $("#groupid").val();
					 	//var groupidd = $("#groupidd").val();
					 	var groupname = $("#groupname").val();
					 	var memo = $("#memo").val();
					 	
					 	//对ID还得进一步进行判断
					 	//if(groupid!=null&&groupid!=""){
					 	//	params+="&groupid="+tsd.encodeURIComponent(groupid);
					 	//}else if(groupidd!=null&&groupidd!=""){
					 	//	params+="&groupid="+tsd.encodeURIComponent(groupidd);
					 	//}else{
						//	var operationtips = $("#operationtips").val();
							//var successful = $("#successful").val();
						//	alert("<fmt:message key='powergroup.theid'/>!",operationtips);
						//	$('#groupid').focus();
						//	return false;
						//}
					 	 if(groupname!=null&&groupname!=""){
					 		params+="&groupname="+tsd.encodeURIComponent(groupname);
					 	}else{
							var operationtips = $("#operationtips").val();
							//var successful = $("#successful").val();
							alert("<fmt:message key='powergroup.thename'/>!",operationtips);
							$('#groupname').focus();
							return false;
						}
					 		
					 	params+="&memo="+tsd.encodeURIComponent(memo);
					 	
					 	var thestate = $('#thestate').val();
						var theloginfo = '';
						var thetype = '';
						
						var thefieldalias = fetchFieldAlias('sys_powergroup','<%=languageType%>');
						if(thestate==0){
							//添加权限组信息,记录日志
							thetype = 'add';
							theloginfo = "(sys_powergroup)"+tsd.encodeURIComponent("<fmt:message key='global.add'/>")+tsd.encodeURIComponent("<fmt:message key='powergroup.thetitle'/>：");
							theloginfo += tsd.encodeURIComponent(thefieldalias['groupid']) + ':' + tsd.encodeURIComponent(groupid) + ',';
							theloginfo += tsd.encodeURIComponent(thefieldalias['groupname']) + ':' + tsd.encodeURIComponent(groupname) + ',';
							if(memo!=''&&null!=memo){
								theloginfo += tsd.encodeURIComponent(thefieldalias['memo']) + ':' + tsd.encodeURIComponent(memo);
							}
						}else if(thestate==1){
							//修改权限组信息,记录日志
							thetype = 'modify';
							theloginfo = "(sys_powergroup)"+tsd.encodeURIComponent("<fmt:message key='global.edit'/>")+groupid+tsd.encodeURIComponent("<fmt:message key='powergroup.thetitle'/>")+tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：");
							
							var thearr = getGroupInfo(groupid,0);
							
							if(thearr['groupname']!=groupname){
								theloginfo += tsd.encodeURIComponent(thefieldalias['groupname']) + ':' + tsd.encodeURIComponent(thearr['groupname']) + '>>>' + tsd.encodeURIComponent(groupname) +';';
							}
							if(thearr['memo']!=groupname){
								theloginfo += tsd.encodeURIComponent(thefieldalias['memo']) + ':' + tsd.encodeURIComponent(thearr['memo']) + '>>>' + tsd.encodeURIComponent(memo) +';';
							}
						}
						writeLogInfo('',thetype,theloginfo);
						//每次拼接参数必须添加此判断
						if(tsd.Qualified()==false){return false;}
						return params;
					}
				
				/**
				 * 拼参数
				 * @param groupid(唯一标识)
				 * @param type(类型)
				 * @return 数组
				 */
				function getGroupInfo(groupid,type){
					var arr = new Array();
					var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'groupManager.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&groupid='+groupid,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
									var groupid = $(this).attr("groupid");
									var groupname = $(this).attr("groupname");
									var memo = $(this).attr("memo");
									
									//在做修改时需要进行判断的值参数
									arr['groupid'] = groupid;
									arr['groupname'] = groupname;
									arr['memo'] = memo;
									
									if(type==1){
										var theuserinfo = fetchFieldAlias('sys_powergroup','<%=languageType%>');
										var deluserinfo = '';
										deluserinfo += tsd.encodeURIComponent(theuserinfo['groupid']) + ':' + tsd.encodeURIComponent(groupid) + ';' ;
										deluserinfo += tsd.encodeURIComponent(theuserinfo['groupname']) + ':' + tsd.encodeURIComponent(groupname) + ';' ;
										deluserinfo += tsd.encodeURIComponent(theuserinfo['memo']) + ':' + tsd.encodeURIComponent(memo) + ';' ;
										$('#thedelinfo').val(deluserinfo);
									}
								});
							}
						});
					return arr;
				}
				
				/**
				 * 添加完成，进行数据交互即保存
				 * @param thesave(添加方式：1.保存添加；2.保存退出)
				 * @return 无返回值
				 */
				function saveInfo(thesave){
					/****************************************
					*   是否是可输入ID，查看数据库中是否存在此id  *
					****************************************/
					var groupid = $("#groupid").val();
					var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'groupManager.querygroupid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
								var gid = $(this).attr("groupid");
								if(gid==groupid){
									var operationtips = $("#operationtips").val();
									var worninfo = $("#worninfo").val();
									alert(worninfo,operationtips);
									$('#groupid').focus();
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
											 					tsdpk:'groupManager.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
													$('#groupname').focus();												
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
				 * @return 无返回值(操作成功)/false(数据库中没有此条记录)
				 */
				 function deleteRow(key){
				 	var deleteright = $("#deleteright").val();
					if(deleteright=="true"){
						if(arguments[1]=="administrators" || arguments[1]=="dataadministrators")
						{
							//alert("特权权限组 " + arguments[1] + " 不允许被删除");
							alert("<fmt:message key='groupManager.privilegeGroup' />" + arguments[1] + "<fmt:message key='groupManager.notAllowDelete' />");
							return;							
						}
						
					 	var deleteinformation = $("#deleteinformation").val();
					 	var operationtips = $("#operationtips").val();
					 	if(confirm('<fmt:message key="global.deleteinformation"/>')){
						 	var urlstr=tsd.buildParams({ 	
							 		 						packgname:'service',//java包
										 					clsname:'ExecuteSql',//类名
										 					method:'exeSqlData',//方法名
										 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
										 					tsdcf:'mssql',//指向配置文件名称
										 					tsdoper:'query',//操作类型 
										 					datatype:'xmlattr',//返回数据格式 
										 					tsdpk:'groupManager.queryisusedid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										 				});
							$.ajax({
								url:'mainServlet.html?'+urlstr+'&groupid='+key,
								datatype:'xml',
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(xml){
									$(xml).find('row').each(function(){
										var num = $(this).attr("num");
										if(num>0){
											var operationtips = $("#operationtips").val();
											var worntips = $("#worntips").val();
											alert(worntips,operationtips);
											return false;
										}else{
											//设置命令参数
									 		 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
														 					clsname:'ExecuteSql',//类名
														 					method:'exeSqlData',//方法名
														 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
														 					tsdcf:'mssql',//指向配置文件名称
														 					tsdoper:'exe',//操作类型 
														 					tsdpk:'groupManager.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
														 				});
												getGroupInfo(key,1);
												var thedelinfo  = $('#thedelinfo').val();
					 							writeLogInfo('','delete',tsd.encodeURIComponent("<fmt:message key='global.delete'/>")+tsd.encodeURIComponent("<fmt:message key='powergroup.thetitle'/>")+key+tsd.encodeURIComponent("<fmt:message key='usermanager.info'/>：")+thedelinfo);
												$.ajax({
													url:'mainServlet.html?'+urlstr+'&groupid='+key,
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
									});
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
				 * 预修改信息
				 * @param key(唯一标识)
				 * @return 无返回值(查询预修改记录)
				 */
				function openRowModify(key){
					var editright = $("#editright").val();
					if(editright=="true"){
						if(arguments[1]=="administrators" || arguments[1]=="dataadministrators")
						{
							//alert("特权权限组 " + arguments[1] + " 不允许被修改");
							alert("<fmt:message key='groupManager.privilegeGroup' />" + arguments[1] + "<fmt:message key='groupManager.notAllowUpdate' />");
							return;							
						}
					
						var editinfo = $("#editinfo").val();
						//tsd.setTitle($("#input-Unit .title h3"),editinfo);
						$('#titledivs').html(editinfo);
						$("#modify").show();
						$("#saveadd").hide();
						$("#saveexit").hide();
						
						//hideError();//隐藏错误信息 
						clearText('operform'); 
						$("#groupid").val(key);
							///设置命令参数
						 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'groupManager.queryByKey' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&groupid='+key,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
							
								$(xml).find('row').each(function(){
									
									var groupname = $(this).attr("groupname");
									var memo = $(this).attr("memo");
									$("#groupname").val(groupname);
									$("#memo").val(memo);
									
									var editfields = $("#editfields").val();
									/*************************************
									**   将当前表的所有字段取出来，分割字符串 ***
									*************************************/
									var fields = getFields('sys_powergroup');
									var fieldarr = fields.split(",");
									/**********************************
									**   将当前表中的spower字段取出来 *****
									**********************************/
									
									var spower = editfields.split(",");
									
									if(spower.length>0){
										for(var i=0;i<spower.length;i++){
											for(var j = 0 ; j <fieldarr.length-1;j++){
												if(fieldarr[j]==spower[i]){
													document.getElementById(fieldarr[j]).disabled = false;
													break;
												}
											}
										}
									}
								});
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
				 * 将修改后的信息保存起来
				 * @param 无参数
				 * @return 无返回值
				 */
				function modifyInfo(){
					$('#thestate').val(1);
					
					 var params = buildParams();
					 if(params==false){return false;}
						key=$("#groupid").val();
							///设置命令参数
					 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'exe',//操作类型 
								 					tsdpk:'groupManager.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
							urlstr+=params;
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&groupid='+key,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){
									alert('<fmt:message key="global.successful"/>','<fmt:message key="global.operationtips"/>');
									/*************
									** 释放资源 **
									************/
									//isReadonly(true);
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
						 					tsdpk:'groupManager.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'groupManager.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 				});
					var thecolumn = $('#thecolumns').val();
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&cloumn='+thecolumn}).trigger("reloadGrid");
				 	setTimeout($.unblockUI, 15);//关闭面板
				}
				/**********************************
				**    在初始化页面的时候将面板加载进来 **
				**********************************/
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
				fuheDisQuery('groupManager.queryByWhere','groupManager.queryByWherepage');
			}
			/**
			 * 查询通用模板
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
				var column = $('#thecolumns').val();
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&cloumn='+column}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板			
			}
			/**
			 * 弹出简单查询面板
			 * @param 无参数
			 * @return 无返回值
			 */
			function openQueryGroup(){
				clearText('querygroupforms');
				$('#whichorder').val(0);//简单查询
				autoBlockForm('querygroupform',60,'queryclose',"#ffffff",false);//弹出面板
			}
			
			/**
			 * 执行总查询
			 * @param 无参数
			 * @return 无返回值
			 */
			function queryGroup(){
				var groupid = $('#querygroupid').val();
				var groupname = $('#querygroupname').val();
				
				var params = '';
				params += '&groupid=' + groupid;
				params += '&groupname=' + tsd.encodeURIComponent(groupname);
				
				var expparams = ' 1=1 ';
				if(groupid!=''){
					expparams += " and groupid='" +  tsd.encodeURIComponent(groupid) + "'";
				}
				if(groupname!=''){
					expparams += " and groupname='" +  tsd.encodeURIComponent(groupname) + "'";
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
						 					tsdpk:'groupManager.queryjd',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdpkpagesql:'groupManager.querypagejd'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
						 				});
					var thecolumn = $('#thecolumns').val();
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
						alert("<fmt:message key='groupManager.SeniorInquiresAndSave' />");
						return;
					}
				 	var addinfo = $("#addinfo").val(); 	
				 	//tsd.setTitle($("#input-Unit .title h3"),addinfo); 	
					clearText('addquery');
					//hideError();//隐藏错误信息	
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
				 * @param sqlstr(组合排序字段)
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
							sql = 'groupManager.queryjd';
							pagesql = 'groupManager.querypagejd';
						}else if(flag==1||flag==2){
							params = fuheQbuildParams();	
							if(params=='&fusearchsql='){
								params +='1=1';
							}
							var column = $("#thecolumns").val();		
							params =params+'&orderby='+sqlstr+'&column='+column;
							params += '&orderkey=groupid';
							params += '&ordertablename=sys_powergroup';
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
										var thefieldalias = getCaption($(this).attr("field_alias"),'<%=languageType%>','');
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
.btn_2k3 {
	BORDER-RIGHT: #87CEFA 1px solid;
	min-width: 50px;
	PADDING-RIGHT: 2px;
	BORDER-TOP: #87CEFA 1px solid;
	PADDING- LEFT: 2px;
	FONT-SIZE: 12px;
	FILTER: progid :   DXImageTransform .   Microsoft . 
		
		Gradient(GradientType =   0, StartColorStr =   #FFFFFF, EndColorStr = 
		 #87CEFA);
	BORDER-LEFT: #87CEFA 1px solid;
	CURSOR: hand;
	COLOR: black;
	PADDING-TOP: 2px;
	BORDER-BOTTOM: #87CEFA 1px solid;
	margin-top: 5px;
}

.tdstyle {
	border-bottom: 1px solid #A9C8D9;
}

.spanstyle {
	display: -moz-inline-box;
	display: inline-block;
	width: 115px
}
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
									key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="buttons">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="order2"
				onclick="openDiaO('sys_powergroup');">
				<!-- 组合排序 -->
				<fmt:message key="order.title" />
			</button>
			<button type="button" id="openadd1" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openQueryGroup()">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="query1"
				onclick="openDiaQueryG('query','sys_powergroup')" disabled="disabled">
				<!-- 高级查询 -->
				<fmt:message key="groupManager.SeniorInquires" />
			</button>
			<button id='gjquery1' onclick='openQueryM(1);'>
				<fmt:message key="oper.mod" />
			</button>

			<button id='savequery1' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave" />
			</button>
			<button type="button" id="exp1"
				onclick="thisDownLoad('tsdBilling','mssql','sys_powergroup','<%=languageType%>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
		<div id="buttons">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="order2"
				onclick="openDiaO('sys_powergroup');">
				<!-- 组合排序 -->
				<fmt:message key="order.title" />
			</button>
			<button type="button" id="openadd2" onclick="openText()"
				disabled="disabled">
				<fmt:message key="global.add" />
			</button>
			<button type="button" onclick="openQueryGroup()">
				<fmt:message key="global.query" />
			</button>

			<button type="button" id="query2"
				onclick="openDiaQueryG('query','sys_powergroup')" disabled="disabled">
				<!-- 高级查询 -->
				<fmt:message key="groupManager.SeniorInquires" />
			</button>
			<button id='gjquery2' onclick='openQueryM(1);'>
				<fmt:message key="oper.mod" />
			</button>

			<button id='savequery2' onclick="opensaveQ();" disabled="disabled">
				<fmt:message key="oper.modSave" />
			</button>
			<button type="button" id="exp2"
				onclick="thisDownLoad('tsdBilling','mssql','sys_powergroup','<%=languageType%>',6)"
				disabled="disabled">
				<fmt:message key="global.exportdata" />
			</button>
		</div>



		<div class="neirong" id="add" style="display: none; width: 600px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titledivs">
							<!-- 添加 -->
							<fmt:message key="groupManager.add" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="clearText('operform');reloadData();">
						<!-- 关闭 -->
						<fmt:message key="groupManager.close" />
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="operform" id="operform"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="dflabelclass">
								<label for="groupname" style="width: 90px">
									<span id="qxname"></span>
								</label>
							</td>
							<td>
								<input type="text" name="groupname" id="groupname"
									class="textclass" style="width: 150px" disabled="disabled" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
							<td class="dflabelclass">
								<label for="memo" style="width: 90px">
									<span id="qxmemo"></span>
								</label>
							</td>
							<td>
								<input type="text" name="memo" class="textclass"
									style="width: 150px" id="memo" disabled="disabled" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" style="width: 80px"
					id="saveadd" onclick="saveInfo(1)">
					<!-- 保存添加 -->
					<fmt:message key="groupManager.saveAndAdd" />
				</button>
				<button type="submit" class="tsdbutton" style="width: 80px"
					id="saveexit" onclick="saveInfo(2)" style="margin-left: 10px">
					<!-- 保存退出 -->					
					<fmt:message key="groupManager.saveAndclose" />
				</button>
				<button type="submit" class="tsdbutton" id="modify"
					onclick="modifyInfo();">
					<fmt:message key="global.edit" />
				</button>
				<button type="button" class="tsdbutton" id="close"
					style="margin-left: 10px"
					onclick="clearText('operform');reloadData();">
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

			<input type="hidden" id="worninfo"
				value="<fmt:message key="powergroup.worn"/>" />
			<input type="hidden" id="worntips"
				value="<fmt:message key="powergroup.worntips"/>" />
			<input type="hidden" id="deletepower"
				value="<fmt:message key="global.deleteright"/>" />
			<input type="hidden" id="editpower"
				value="<fmt:message key="global.editright"/>" />

			<input type="hidden" id="addright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="exportright" />

			<input type="hidden" id="editfields" />

			<input type="hidden" id="whichoper" />
			<input type="hidden" id="alog" />
			<input type="hidden" id="groupid" />

			<input type="hidden" id="userid" value="<%=userid%>" />
			<%@page import="com.tsd.service.util.Log"%>
			<input type='hidden' id='userloginip'
				value='<%=Log.getIpAddr(request)%>' />
			<input type='hidden' id='userloginid'
				value='<%=session.getAttribute("userid")%>' />
			<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />

			<input type="hidden" id="thecolumns" />
			<input type="hidden" id="thecolumn" />
			<input type="hidden" id="thedelinfo" />
			<input type="hidden" id="thestate" />

			<!-- 添加模板面板 -->
			<div id="modT" name='modT' style="display: none" class="neirong"
				style="width:800px">
				<br />
				<div class="top">
					<div class="top_01">
						<div class="top_01left">
							<div class="top_02">
								<img src="style/images/public/neibut01.gif" />
							</div>
							<div class="top_03">
								<!-- 查询模板保存 -->					
								<fmt:message key="groupManager.InquiresTheTemplateSave" />
							</div>
							<div class="top_04">
								<img src="style/images/public/neibut03.gif" />
							</div>
						</div>
						<div class="top_01right">
							<a href="#" onclick="closeoMod()"><span
								style="margin-left: 5px;"><fmt:message key="global.close" />
							</span> </a>
						</div>
					</div>
					<div class="top02right">
						<img src="style/images/public/toptiaoright.gif" />
					</div>
				</div>
				<div class="midd">
					<form id='addquery' name="addquery" onsubmit="return false;"
						action="#">
						<input type="hidden"/>
						<table width="100%" id="tdiv" border="0" cellspacing="0"
							cellpadding="0" style="line-height: 33px; font-size: 12px;">
							<tr>
								<td align="right" class="dflabelclass">
									<label id="nameg_mod">
										<fmt:message key="oper.modName" />
									</label>
								</td>
								<td width="200px" align="left">
									<input type="text" name="name_mod" id="name_mod"
										onkeyup="this.value=replaceStrsql(this.value,80)"
										class="textclass" />
									<font style="color: #ff0000;">*</font>
								</td>

								<td align="right" class="dflabelclass">
									<label id=''></label>
								</td>
								<td width="150px" align="left"></td>

								<td align="right" class="dflabelclass"></td>
								<td width="150px" align="left"></td>
							</tr>
						</table>
					</form>
					<div class="midd_butt">
						<!-- 保存 -->
						<button class="tsdbutton" id="saveModB"
							style="width: 80px; heigth: 27px;" onclick="saveModQuery(1);">
							<fmt:message key="global.save" />
						</button>
						<!-- 关闭 -->
						<button class="tsdbutton" id="closeModB"
							style="width: 63px; heigth: 27px;" onclick="closeoMod();">
							<fmt:message key="global.close" />
						</button>
					</div>
				</div>
			</div>
			<!-- 查询树信息存放 -->
			<input type="hidden" id='treepid' />
			<input type="hidden" id='treecid' />
			<input type="hidden" id='treestr' />
			<input type="hidden" id='treepic' />

			<!-- 高级查询 模板隐藏域 -->
			<input type="hidden" id="queryright" />
			<input type="hidden" id="saveQueryMright" />

			<input type="hidden" id="jdparams" />
			<input type="hidden" id="whichorder" value="2" />


			<input type="hidden" id="useridd" value="<%=userid%>" />
		</div>



		<!-- 工号简单查询 -->
		<div class="neirong" id="querygroupform"
			style="display: none; width: 600px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="groupManager.query"/>
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#queryclose').click();"><fmt:message key="groupManager.close"/></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" id="querygroupforms" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="dflabelclass">
								<label id="sqxid"></label>
							</td>
							<td>
								<input type="text" id="querygroupid" style="width: 150px"
									class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="4" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"/>
							</td>
							<td class="dflabelclass">
								<label id="sqxname"></label>
							</td>
							<td>
								<input type="text" id="querygroupname" style="width: 150px"
									class="textclass" />
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="queryGroup()">
					<fmt:message key="global.query" />
				</button>
				<button type="button" class="tsdbutton" id="queryclose"
					style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>

		<!-- 导出数据 -->
		<div class="neirong" id="thefieldsform"
			style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<!-- 选择您要导出的数据字段 -->
							<fmt:message key="groupManager.chooseData" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="groupManager.close" /></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td>
								<div id="thelistform"
									style="margin-left: 10px; max-height: 200px">

								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="query"
					onclick="checkedAllFields()">
					<fmt:message key="groupManager.checkAll" />
				</button>
				<button type="submit" class="tsdbutton" id="query"
					onclick="getTheCheckedFields('tsdBilling','mssql','sys_powergroup')">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>

			</div>
		</div>
	</body>
</html>