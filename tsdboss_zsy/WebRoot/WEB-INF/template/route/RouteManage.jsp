<%----------------------------------------
	name: RouteManage.jsp
	author: wangli
	version: 1.0 
	description: 用户号线资料管理即用户路由管理 
	Date: 2011-11-15
	modiry：2012-6-19 yhy
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String sUserId = (String) session.getAttribute("userid");
	String sArea = (String) session.getAttribute("chargearea");
	String  manArea = (String) session.getAttribute("managearea");
	String sDepart = (String) session.getAttribute("departname");	
	String sMenuid = request.getParameter("imenuid");
	String sGroupid = request.getParameter("groupid");	
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";	
	

	String route_ywlx = request.getParameter("ywlx");	
	String route_accesstype = request.getParameter("accesstype");
	String route_username = request.getParameter("username");
	String route_jobid  = request.getParameter("jobid");
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery.layout.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js" type="text/javascript"></script>
	<script src="script/broadband/business/broadbandservice.js" type="text/javascript"></script>
	<script src="script/broadband/business/radbusiprint.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script> <!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>			
		
    <script type="text/javascript" src="script/public/tsdpower.js"></script><!-- 页面权限控制 -->
    <script type="text/javascript" src="script/public/main.js"></script>
    <script type="text/javascript" src="script/public/mainStyle.js"></script>
    <script type="text/javascript" src="script/public/transfer.js"></script>	    
    <script type="text/javascript" src="script/public/revenue.js" ></script> 
    <script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>	

    <script type="text/javascript" src="plug-in/jquery/jquery.cookie-min.js"></script>    
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.core-3.0.js"></script>
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.excheck-3.0.min.js"></script>
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.exedit-3.0.min.js"></script>
    <!-- 生产调度 -->
    <script type="text/javascript" src="script/route/RouteManage.js"></script>
    <!-- 权限设置 -->
	<script type="text/javascript" src="script/public/tsdpower.js" ></script>

	<link rel="stylesheet" href="style/zTreeStyle/zTreeStyle.css" type="text/css" /> 
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />      	
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">
		.maxpanel{
			padding:1%;
			background-color:#CCCCCC;
			padding-bottom:15px;
			position: absolute;
			filter:alpha(opacity=25);
			z-index: 2000;
		}
		
		#input-Unit{ float:left; width:100%; text-align:center; }
		#input-Unit .title_rad{ width:100%; height:22px; border-bottom:1px solid #C8D8E5;  text-align:center; color:#3C3C3C; line-height: 22px; font-weight:bold; background:#CCCCFF;}		
		.tsdbutton_rad{width:70px; height:22px;background: url(style/images/public/buttonsbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer;}
		#divroute .grid_bdiv{
			overflow:hidden;
		}		 
	</style>	
	<script type="text/javascript">	
		var gridimgpath = 'plug-in/jquery/jqgrid/themes/basic/images/';	
		var mylayout;
		//存放用户的路由线路总数目					
		var gridCount = 0; 
		//是否初始化增加路由页面中的若干grid
		var initedgrids = false;  
		$(document).ready(function () {
			//设置配线面板可拖拽
			$("#divRouteAdd").draggable();
			$("#divDetail").draggable();
			getSelOption();
		
			/***************************************
			           设置权限
			***************************************/		
			var userid = $('#useridd').val();	
			var groupid = $('#zid').val();
			var imenuid = $('#imenuid').val();	
			//权限关键字 uploadDoc:上传文件权限（0：上传word、excel；1：上传word；2：上传excel ；其它：无上传权限）		
			var htmlinfo = [
							{oper:'notFixed',	id:'notFixedRoute',	type:'2',value:'true'},
							{oper:'delDoc',     id:'deletefileright',	type:'2',value:'true'},
							{oper:'uploadDoc',  id:'uploadDocRight',	type:'4',value:'0'}							
						   ];
							
			getUserPowerNEW(htmlinfo,userid,groupid,imenuid,"subsidyPay.getPower");	
			//利用布局控件设置布局			
			mylayout = $('body').layout({ 
				applyDefaultStyles: true,				
				center__resizable:false,
				north__resizable:false,
				south__resizable:false,
				north__closable:false,
				east__closable:false,
				south__closable:false,
				center__closable:false,	
				west__minSize:760,		
				center__size:300,							
				spacing_open:1										
			});		
			$("#navBar").append(genNavv());
			getRightsOfScddbm();//获取用户权限
			initGrid_user();//初始化用户表格(air_users)
			setGrid_H();//设置表格(air_users)自适应高度
			
			//初始化并机表格
			initGrid_bj();
			//初始化选择并机配线表格
			initGrid_bj_add();
			$("#divtree").draggable();
			$('#maxpanels').css('height',document.documentElement.clientHeight);
	        $('#maxpanels').css('width', document.documentElement.clientWidth);
	        //填充页面下拉框内容
	        //getDict();//目前屏蔽该信息
	        
	        //根据request中的业务类型的值判断，
	        	//是通过点击右侧菜单打开页面，或通过工单页面按钮打开的页面
	        var routeYwlx = $("#route_ywlx").val();
	        if ( routeYwlx == 'null'){	
	        	setTimeout("query_user(2)",200);
	        }else{
	        	setTimeout("queryUserByJob()",200);	//根据工单传过来的参数查询用户信息
	        }
	        
	        //加载设置路由表格内容															
	        initGrid_newroute();   
	        //初始化自动配线表格(air_route_xxx)
			initGrid_BindRoute();	
			
			//初始化电话号线互换jqgrid
			initGrid_changeRoute('grid_Aroute','pager_Aroute');
			initGrid_changeRoute('grid_Broute','pager_Broute');																		
		});
		//2012-9-4 yhy start 修改获取数据方式不从内存直接获取
		/*
        //填充页面下拉框内容
		function getDict(){
			$.ajax({
				url:"phone_querydate?func=query",
				async:false,//异步
				cache:false,
				timeout:20000,//1000表示1秒
				type:'post',
				success:function(xml,textStatus)
				{					
				    var routetype = xml.substring(xml.indexOf("<routetype=")+11,xml.indexOf("routetype/>"));
				    var linemode = xml.substring(xml.indexOf("<linemode=")+10,xml.indexOf("linemode/>"));	
				    //下拉框第一项默认返回"请选择"，改为“全部”
				    routetype = routetype.replace('请选择','全部');			    
				    linemode = linemode.replace('请选择','全部');
				    //号线业务				    
					$("#routetype").html(routetype);
					//配线方式
					$("#linemode").html(linemode);
				}		
			});								
		}
		*/
		//填充页面下拉框内容
		function getDict(){			
			//号线业务
			var s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetRouteType',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][1]+">"+res[i][0]+"</option>";
				}
			};
			$("#routetype").html(s);
			
			//配线方式
			s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetLineMode',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][1]+">"+res[i][0]+"</option>";
				}
			};
			$("#linemode").html(s);		
		}		
		//2012-9-4 yhy end
		/***
		* lws 
		* 并机复制路由
		* 20120621
		***/
		function initGrid_bj_add(){			
			jQuery('#grid_bj_add').jqGrid({	
				datatype: "xml",
			   	colNames:['电话', '用户地址','号线序号', '系统类型', '用户ID'],
			   	colModel:[			        
			        {name : 'dh', index : 'dh',width:120},
			        {name : 'useraddr', index : 'useraddr',width:380},
			        {name : 'linenum', index : 'linenum',width:55,hidden:true},
			        {name : 'dhtype', index : 'dhtype',hidden:true},
			        {name : 'userid', index : 'userid',hidden:true}			        			        		
			   	],
			   	imgpath: gridimgpath,			   	
			   	sortname: 'dh',
			    viewrecords: false,
			    sortorder: "asc",
				multiselect: false,
				useDefault:true,
				pager: jQuery('#pager_bj_add'),
				pgbuttons: false,
				pginput: false,
				width:document.documentElement.clientWidth-27,
				loadComplete: function() { 					

				}, 
				ondblClickRow: function(rowid) {
					//双击选中并机号线
					var linenum=jQuery("#grid_bj_add").getCell(rowid,'linenum');
					$('#linenum_bj_add').val(linenum);
					editRoute(1);
					setTimeout($.unblockUI,15);
				},				
				caption:"用户并机配线选择"			
			}).navGrid('#pager_bj_add',
			{refresh: false, edit: false, add: false, del: false, search: false}
			);	
		}
		//初始化用户表格(air_users)
		function initGrid_user(){			
			jQuery("#grid_user").jqGrid({								
				datatype: "xml",
			   	colNames:['操作','dh','电话','宽带账号', '用户名称', '用户单位', '用户地址', '开户日期', '模块局','系统类型id','系统类型','系统类型号线表','业务类值','业务类型','号线序号'],
			   	colModel:[
			        {name : 'viewOperation', index : 'viewOperation', width : 135},
			        {name : 'Dh', index : 'Dh', width : 100,hidden:true},
			        {name : 'phoneacct', index : 'phoneacct', width : 100},
			        {name : 'internetacct', index : 'internetacct', width : 100},
			        {name : 'UserName', index : 'UserName', width : 150},
			        {name : 'UserBM', index : 'UserBM', width : 200},
			        {name : 'userAddr', index : 'userAddr', width : 250},
			        {name : 'Regdate', index : 'Regdate', width : 135},
			        {name : 'MoKuaiJu', index : 'MoKuaiJu',width:100},
			        {name : 'dhtype', index : 'dhtype', width:100,hidden:true},
			        {name : 'typename', index :'typename',hidden:true},
			        {name : 'table_route_name', index : 'table_route_name',hidden:true},
			        {name : 'hjlx', index : 'hjlx',hidden:true},
			        {name : 'tvalues', index : 'tvalues', width:100,hidden:true},
			        {name : 'linenum', index : 'linenum', width:80}
			   	],
			   	rowNum:15,
			   	rowList:[10,15,20],
			   	imgpath: gridimgpath,
			   	pager: jQuery('#pager_user'),
			   	sortname: 'Dh',
			    viewrecords: true,
			    sortorder: "asc",
			    pgbuttons: true,
				multiselect: false,
				useDefault:true,
				height:document.documentElement.clientHeight-27,
				loadComplete: function() {	
					//查询无数据，不执行添加操作列操作
					if($("#grid_user tr.jqgrow[id='1']").html()==""){
						return false;
					}else{												
						//修改按钮方法名 李伟松 bind>>>>bindRoute； 修改添加按钮的方法；
						addRowOperBtnExtend('grid_user','配线','bindRoute','Dh','click',1,'','MoKuaiJu','linenum');
						//addRowOperBtnExtend('grid_user','修改地址','openUserAddr','Dh','click',2,'','MoKuaiJu');
						//addRowOperBtnExtend('grid_user','互换','changeRoute','Dh','click',3,'','MoKuaiJu','linenum');
						//addRowOperBtnExtend('grid_user','文档','openDocumentM','Dh','click',3,'','MoKuaiJu','dhtype');
						executeAddBtn('grid_user',1);		
						//查询后，默认选中第一条
						jQuery("#grid_user").setSelection('3', true);
						jQuery("#grid_user").focus();	
						if($("#grid_user tr.jqgrow[id='2']").html()=="null"||$("#grid_user tr.jqgrow[id='2']").html()==null){
							var ids = $("#grid_user").getDataIDs();
							var dh = $("#grid_user").getCell(ids[0],"Dh");
							var tableRouteName = $("#grid_user").getCell(ids[0],"table_route_name");
							query_route(dh, tableRouteName);
						}
					}
				}, 
				onSelectRow: function(ids) {
				    //ids是返回的rowid,然后根据它再返回meetid	    
					if(ids != null) {			
					    var dh=jQuery("#grid_user").getCell(ids,'Dh');		
					    var type=jQuery("#grid_user").getCell(ids,'hjlx');
					    //用户路由表名
					    var tableRouteName =jQuery("#grid_user").getCell(ids,'table_route_name');
					    
					    var dhtype =jQuery("#grid_user").getCell(ids,'dhtype');
					    
					    if(dhtype=="53"){
					    	$("#hidywtype").val("broadband");
					    }else{
					    	$("#hidywtype").val("phone");
					    }
					    
					    $("#bjdh").val(dh);
					    //$("#bjdhtype").val(type);
					    					    
						query_route(dh, tableRouteName);					
						query_bj(dh);
						
						//号线序号
					    var linenum=jQuery("#grid_user").getCell(ids,'linenum');
						var isExists = isRouteExists( linenum );
						//保存“号线配线状态”
						$('#route_exists').val(isExists);
					}
				},	
				caption:"用户资料"	
			});
		}
		
		//初始化并机表格 lws 20120620
		function initGrid_bj(){
			jQuery("#grid_bj").jqGrid({								
				datatype: "xml",
			   	colNames:['操作','电话','用户ID', '用户地址', '号线序号','电话类型'],
			   	colModel:[
			        {name : 'viewOperation', index : 'viewOperation', width : 70},
			        {name : 'dh', index : 'dh', width:100 ,hidden:true},
			        {name : 'userid', index : 'userid', width : 100 ,hidden:true},
			        {name : 'userAddr', index : 'userAddr', width : 280},
			        {name : 'linenum', index : 'linenum', width:80 },
			        {name : 'dhtype', index : 'dhtype', width:200 ,hidden:true},
			   	],
			   	rowNum:15,
			   	rowList:[10,15,20],
			   	imgpath: gridimgpath,
			   	pager: jQuery('#pager_bj'),
			   	sortname: 'dh',
			    viewrecords: true,
			    sortorder: "asc",
			    pgbuttons: true,
				multiselect: false,
				useDefault:true,
				loadComplete: function() {
					//查询无数据，不执行添加操作列操作
					if($("#grid_bj tr.jqgrow[id='1']").html()==""){
						return false;
					}else{						
						//修改按钮方法名 李伟松 bind>>>>bindRoute； 修改添加按钮的方法；
						addRowOperBtnExtend('grid_bj','配线','bindRouteBj','dh','click',1,'','linenum');
						executeAddBtn('grid_bj',1);					
					}
				}, 
				onSelectRow: function(ids) {
					if(ids != null) {
					    //号线序号
					    var userid=jQuery("#grid_bj").getCell(ids,'userid');
					    $('#userid_bj_add').val(userid);
					    var linenum=jQuery("#grid_bj").getCell(ids,'linenum');
					    //根据该并机地址的linenum和电话的号线序号列表对比，查看该地址是否已有配线
					    var isExists = isRouteExists( linenum );
					    if(isExists == 0){
					    	$('#route_exists_bj').val(0);
					    }else{
					    	$('#route_exists_bj').val(1);
					    	$('#linenum_bj_add').val(linenum);
					    }				
					}
					
				},				
				caption:"并机信息"	
			});
		}
		
		//初始化路由表格(air_route_xxx)
		function initGrid_route(grid){
			jQuery(grid).jqGrid({				
				height: '100%',	  	
				width:450,
				datatype: "xml",
			   	colNames:['', 'id1','设备类型', '设备名称', 'id3','端口名称'],
			   	colModel:[			        
			        {name : 'routeno', index : 'routeno', width : 25},
			        {name : 'id1', index : 'id1',hidden:true},
			        {name : 'name1', index : 'name1',width:75},
			        {name : 'name2', index : 'name2',width:170},
			        {name : 'id3', index : 'id3',hidden:true},
			        {name : 'name3', index : 'name3',width:180}			        			        		
			   	],
			   	imgpath: gridimgpath,			   	
			   	sortname: 'routeno',
			    viewrecords: true,
			    sortorder: "asc",
				multiselect: false,
				useDefault:true,
				loadComplete: function() { 
				},				 
				caption:"配线1"			
			});
		}
			
		
		/**********************************************************
		function name:  query_user(mode)
						function:	 查询air_users表
						mode:  0:精确查询；1:模糊查询 2:初始化加载页面
						description：mode=2：初始化页面的时候，只显示最近七天进行业务受理的用户记录，显示按业务受理时间倒叙排序
		**********************************************************/
		function query_user(mode){	
			var useridd = $("#useridd").val();			//登入工号
			var userGroupId = $("#userGroupId").val();	//登入工号权限组		
			var isViewMKJRigth = '' ;
			//admin和数据管理员、管理员权限组拥有全部权限，其他权限组的工号	
			//由于一个工号可以同时属于多个权限组，权限组之前用~分割开，
			userGroupId = "~" + userGroupId + "~";
			if(useridd == "admin" || (userGroupId.indexOf("~1~") !=-1) || (userGroupId.indexOf("~2~") !=-1) ){
				isViewMKJRigth = " 1=1 ";
			}else{
				//根据scddbm表中配置的信息进行权限控制
				isViewMKJRigth = "instr('" + isViewMKJ +"',mokuaiju)>0 ";
			}
			
			//查询参数拼接
			var urlstr = '';			
			if (mode == 2){	//初始化页面的时候,显示最近七天做过业务受理的用户信息				
				urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryInit','dbsql_route.GetInitCount', 'route');
			
				//可查看数据限制：根据工号可查看模块局进行限制
				var scond = "&cond=" + encodeURIComponent(isViewMKJRigth) ;
				urlstr = urlstr + scond;
				
			}else{
				urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryUser','dbsql_route.GetUserCount', 'route');
				//查询条件参数拼接
				var scond = "";
				/*****************************
				//2012-6-18 yhy begin
				//去掉 “业务类型”“配线方式” 查询条件
				var v_routetype = $('#routetype').val();
				var v_linemode = $('#linemode').val();			
				if (v_routetype != ''){		
					scond += " and dhtype = '" +v_routetype+ "'";			  
				};
				if (v_linemode != ''){
					scond += " and hjlx = '" +v_linemode+ "'";			  
				};
				//2012-6-18 yhy end
				*/	
				//查询条件
				var fieldname = $("#queryfield").val(); 
				//查询值
				var fieldvalue = $("#queryvalue").val();						  			
				if (fieldname != '' && fieldvalue!= ''){
					if (mode==0){
						scond += " and "+fieldname+" = '" +fieldvalue+ "'";
					}
					else if(mode==1){
						scond += " and "+fieldname+" like '%" +fieldvalue+ "%'";
					} 							  
				};
					
				//可查看数据限制：根据工号可查看模块局进行限制
				scond += " and " + isViewMKJRigth;
								
				if (scond==''){
					scond += ' and 1=1 ';
				}
				urlstr += '&cond='+encodeURIComponent(scond);			
			}
			//重新加载grid_user数据
			$('#grid_user').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");				
		}
		
		//查询该电话下并机信息 lws 20120620
		function query_bj(dh){
			
			//查询条件
			var condParam="";
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryBj','dbsql_route.GetUserCount', 'route');
			if (condParam=!''){
				condParam = " and dh like '" +dh+ "'";
			} 
			urlstr+='&cond='+condParam;
			$('#grid_bj').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");	
		}
		//查询用户路由表，不同的路由线路独立显示
		function query_route(dh, tableRouteName){			
			//清空上一次查询用户配线信息
			delGrid();
		
			//根据业务类型返回对应的用户路由表名
			var tab = tableRouteName;
			var tab_his = tableRouteName+"_his";
			if (tab == ''){
				//如果没设置业务类型，则默认为电话业务
				tab = "air_route_phone";
				tab_his= "air_route_phone_his";	
			}			
			var urlstr = '&tablename='+tab+'&dh='+tsd.encodeURIComponent(dh);
			
			//返回该用户的线路序号数组
			var res = fetchMultiArrayValue('dbsql_route.GetRouteLine',6,urlstr,'route');
			//将电话的所有号线序号保留下来，用于判断对应的地址上的配线是否已存在，
			//存在修改号线 不存在新增号线
			$("#routeIds").val(res);
			if (res != undefined && res!="" && res.length>0){
				
				gridCount = res.length;
				//号线序号，循环显示电话的多条配线信息
				var lineno;	
				
				for(var i=0;i<res.length;i++){
				
					lineno = res[i][0];	
					//李伟松 2012-7-10 start
					/*******************************
					用户配线展示方式修改，用树形方式来展示	
					//显示该线路的路由
					//1.创建grid
					var grid = createGrid_query(i);					
					//2.初始化grid					
					initGrid_route(grid);
					//3.查询记录，并返回到grid中
					//setTimeout("fillGrid('"+tab+"', '"+dh+"', "+lineno+", '"+grid+"');", 200);
					//fillGrid(tab, dh, lineno, grid);
					*******************************/
					initTree_route('&tablename='+tab+'&dh='+tsd.encodeURIComponent(dh)+'&lineno='+lineno,i);
				}									
			}
			else{				
				var s = "该用户尚未配线！";
				$('#treeGroup').append(s);				
			}
			
			
			//加载历史号线信息
			var urlstr_his = '&tablename='+tab_his+'&dh='+tsd.encodeURIComponent(dh);
			
			//返回该用户的线路序号数组
			var res_his = fetchMultiArrayValue('dbsql_route.GetRouteLine',6,urlstr_his,'route');
			//将电话的所有号线序号保留下来，用于判断对应的地址上的配线是否已存在，
			//存在修改号线 不存在新增号线
			if (res_his != undefined && res_his!="" && res_his.length>0){
				
				//gridCount = res_his.length;
				//号线序号，循环显示电话的多条配线信息
				var lineno;	
				
				for(var i=0;i<res_his.length;i++){
				
					lineno = res_his[i][0];	
					//李伟松 2012-7-10 start
					/*******************************
					用户配线展示方式修改，用树形方式来展示	
					//显示该线路的路由
					//1.创建grid
					var grid = createGrid_query(i);					
					//2.初始化grid					
					initGrid_route(grid);
					//3.查询记录，并返回到grid中
					//setTimeout("fillGrid('"+tab+"', '"+dh+"', "+lineno+", '"+grid+"');", 200);
					//fillGrid(tab, dh, lineno, grid);
					*******************************/
					initTree_route_his('&tablename='+tab_his+'&dh='+tsd.encodeURIComponent(dh)+'&lineno='+lineno,i);
				}									
			}else{				
				//var s = "该用户尚未配线！";
				$('#treeGroup2').append('');				
			}
			
		}
		
		
		/**********************************************************
				function:		清空上一次查询用户配线信息
				参数:			linenum配线序号
				description:   	根据号线序号列表，判断对应的地址上的配线是否已存在，
								存在修改号线 不存在新增号线
								linenum 存在号线序号列表中 ，该配线存在返回1
								linenum 不存在号线序号列表中，该配线不存在返回0
				返回值：flag 标识该号线配线状态 0:未配线 1：已配线
		********************************************************/
		function isRouteExists( linenum ){
			var routeIds = $("#routeIds").val();//号线序号列表
			var flag = 0;//标识该号线配线状态 0:未配线 1：已配线
			
			//判断号线序号列表是否有值
			if(routeIds !== '' ){
				//将号线序号列表字符串拆分成数组
				var routeIdA = routeIds.split(",");
				//alert('routeIds = '+ routeIds +'=-----'+routeIdA.length);
				for(var i=0;i<routeIdA.length ;i++){
					//判断该号线是否已经配线，当号线表中有序号和用户号线序号相等，则该用户已配线
					if(routeIdA[i]==linenum){
						//alert('routeIdA[i]==linenum'+routeIdA[i]);
						flag =1;
					}
				}
			}
			return flag;
		}
		
		/**********************************************************
				function:		 清空上一次查询用户配线信息
				description:   
		********************************************************/
		function delGrid(){
			 $("#treeGroup").empty();
			 $("#treeGroup2").empty();
		}
		
		/**********************************************************
				function name:   fillGrid(tab, dh, lineno, grid)
				function:		用户具体号线显示 根据传递过来的jqgrid的id刷新该grid数据、设置标题、
				parameters:     tab: 号线路由表表名
								dh: 电话
								lineno: 配线线路序号
								grid:jqgrid的id
				return:			 
				description:   
		********************************************************/
		function fillGrid(tab, dh, lineno, grid){
			//刷新该grid数据
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryRoute','', 'route');
			urlstr += '&tablename='+tab+'&dh='+tsd.encodeURIComponent(dh)+'&lineno='+lineno;			
			$(grid).setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
			
			//设置jqgrid标题
			var id = grid.substr(1,grid.length-1);//去掉前面的#号
			/*
			var radios="<input type='radio' id='rdo"+id+"' name='RadioGroup1' value='"+id+"' /><label for='rdo" + 
						id+"'>配线"+lineno+"</label>";
			*/
			var radios="<label for='rdo" + id+"'>配线"+lineno+"</label>";			
			$(grid).setCaption(radios);
			
			//设置jqgrid 
			$(grid).val(lineno);									
		}
		
		//往divroute域中条件电话路由jqgrid列表
		function createGrid_query(i){
			var id = "gridroute_"+i;			
			var s = "<div id='divroute_"+i+"'>";			
			s += "<table id='"+id+"' value1='divroute_"+i+"' class='scroll'  cellpadding='0' cellspacing='0' ></table>";
			s += "</div>";			
			$('#divroute').append(s);
			return '#'+id;			
		}
				
		//根据业务类型返回对应的用户路由表
		function getRouteTable(type){			
			var res = "";
			switch(type){
				case 'phone': res = "air_route_phone"; break;
				case 'broadband': res = "air_route_broadband"; break;
				case 'device': res = "air_route_device"; break;
				case 'tv': res = "air_route_tv"; break;
				default: res = "air_route_phone";				
			}			
			return res;
		}
		
		//设置表格(air_users)自适应高度
		function setGrid_H(){			   
		   //70(主页top)+26(系统模块栏)+40(查询栏)+30(主页底部)+其它(约10)(注意，底部有一些空白是padding(5))  
		   var grid_H=document.body.clientHeight-280;
		   jQuery("#grid_user").setGridHeight(grid_H);
		}
		
		///////////////////////////////////////////////////////////////////////
		//////////////////////       具体路由设置操作      ///////////////////////////
		///////////////////////////////////////////////////////////////////////
		//新增/编辑路由.flag=1:新增;flag=2:编辑;
		function editRoute(flag){
			//并机标识 0：未并机 1：并机
			var isParallel = $('#isParallel').val();
			var gridid = '';
			if(isParallel == 0){
				gridid = 'grid_user';
			}else {
				gridid = 'grid_bj';
			}
			
			//修改选择用户号线，获取选择表格行号
			var rowid = $("#"+gridid).getGridParam("selrow");
			if (rowid == null) 
			{
				alert("请先选中用户记录，再进行此操作！");
				return;
			}
			//配线的序号，即air_route_XXXX表格中的lineNO字段			
			var linenums=$("#"+gridid).getCell(rowid,'linenum');
									
			var rowidUser = $("#grid_user").getGridParam("selrow");//选中的用户号线信息的rowid号
			var sysType=$("#grid_user").getCell(rowidUser,'dhtype'); 	//系统类型
			var routeType=$("#grid_user").getCell(rowidUser,'hjlx');	//业务类型
			var dh=$("#grid_user").getCell(rowidUser,'Dh');				//电话
			var mkj=$("#grid_user").getCell(rowidUser,'MoKuaiJu');		//模块局							
			//var linenums=$("#grid_user").getCell(rowid,'linenum');	//号线序号			
			var tableName = $("#grid_user").getCell(rowidUser,'table_route_name');//相应系统类型号线信息表名
			
			
			//第一次打开号线设置面板，初始化面板上的jqgrid信息，包括：配置设备列表和设备魔板					
			if (initedgrids==false){
				//初始化路由表格(air_route_xxx)
				initGrid_device(routeType);
				//初始化路由模板表格(air_route_xxx)
				initGrid_routetemp(routeType);
				//initGrid_newroute();	
			}else{
				//刷新路由模板
				fillGrid_routetemp(routeType);
				//刷新路由设备
				fillGrid_device(routeType);
			}
			
			//根据具体操作处理 1：新增 2：修改
			if (flag == 1){
				//清空路由表格，调用方法
				cleargrid();
				//并机路由加载
				if(isParallel == 1){
					var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryRouteForUpdate','', 'route');
					urlstr += '&tablename='+tableName+'&dh='+tsd.encodeURIComponent(dh)+'&lineno='+$('#linenum_bj_add').val();
					$('#grid_newroute').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");	
				}
			}else{
				//跟新配线路由表格
				var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryRouteForUpdate','', 'route');					
				urlstr += '&tablename='+tableName+'&dh='+tsd.encodeURIComponent(dh)+'&lineno='+linenums;
				$('#grid_newroute').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
				//保存修改的号线序号
				$("#routeAdd_lineno").val(linenums);
			/*
				var gridid=getSelectedGrid();
				if (gridid=='' || gridid==undefined){
					alert("请先选中路由，再进行此操作！");
					return;
				}
				//为routeAdd_lineno隐藏域变量赋值
				var gridid=getSelectedGrid();
				$('#routeAdd_lineno').val($('#'+gridid).val());
				//路由表格中显示被修改的路由信息
				showroute(gridid, 'grid_newroute');
				//为editgridid隐藏域变量赋值
				$('#editgridid').val(gridid);
			*/				
			} 
			$('#routeAdd_dh').val(dh);
			$('#routeAdd_routeType').val(routeType);			
			$('#routeAdd_mkj').val(mkj);
			$('#routeAdd_table').val(tableName);
			$('#Flag').val(flag);	
			$("#divRouteAdd").show();					
			//autoBlockFormAndSetWH('divRouteAdd',30,'100px','close',"#ffffff",false,'', '');	
			initedgrids = true;		
		}
		
		//复制新增路由
		function addWithCopy(){
			//获取表格选中行号
			var rowid = jQuery("#grid_user").getGridParam("selrow");			
			if (rowid == null) 
			{				
				alert("请先选中用户记录，再进行此操作！");
				return;
			}
			//$("#routeAdd_lineno").val(linenums);
			var gridid=getSelectedGrid();
			if (gridid=='' || gridid==undefined){
				alert("请先选中路由，再进行此操作！");
				return;
			}			
			
			var sysType=$("#grid_user").getCell(rowid,'dhtype'); 	//系统类型
			var routeType=$("#grid_user").getCell(rowid,'hjlx');	//业务类型
			var dh=$("#grid_user").getCell(rowid,'Dh');				//电话
			var mkj=$("#grid_user").getCell(rowid,'MoKuaiJu');		//模块局							
			//var linenums=$("#grid_user").getCell(rowid,'linenum');	//号线序号			
			var tableName = $("#grid_user").getCell(rowid,'table_route_name');//相应系统类型号线信息表名
								
			if (initedgrids==false){
				//初始化路由表格(air_route_xxx)
				initGrid_device(routeType);
				//初始化路由模板表格(air_route_xxx)
				initGrid_routetemp(routeType);
				//initGrid_newroute();	
			}else{
				//刷新路由模板
				fillGrid_routetemp(routeType);
				//刷新路由设备
				fillGrid_device(routeType);
			}
						
			var gridid=getSelectedGrid();			
			//路由表格中显示被修改的路由信息
			showroute(gridid, 'grid_newroute');	
			$('#routeAdd_dh').val(dh);
			$('#routeAdd_mkj').val(mkj);
			$('#routeAdd_table').val(tableName);
			$('#Flag').val(1);
			$("#divRouteAdd").show();						
			//autoBlockFormAndSetWH('divRouteAdd',30,'100px','close',"#ffffff",false,'', '');	
			initedgrids = true;		
		}	
		
		//返回被选中的grid的id
		function getSelectedGrid(){
			var item = $(":radio:checked");			
			var len=item.length; 			
			if(len>0){ 
				return $(":radio:checked").val(); 
			}
			else{
				return "";
			} 
		}
		
		//删除选中路由
		function delRoute(){
			var rowid = jQuery("#grid_user").getGridParam("selrow");			
			if (rowid == null) 
			{				
				alert("请先选中用户记录，再进行此操作！");
				return;
			}
			//返回被选中的路由表格名称
			var gridid=getSelectedGrid();
			if (gridid=='' || gridid==undefined){
				alert("请先选中路由，再进行此操作！");
				return;
			}
			if (!confirm("您确定要进行删除路由操作吗？")){
				return;
			}						
			
			var routeType=$("#grid_user").getCell(rowid,'hjlx');
			var dh=$("#grid_user").getCell(rowid,'Dh');
			var table = $("#grid_user").getCell(rowid,'table_route_name');//相应系统类型号线信息表名
						
			var param = "&table="+table+"&dh="+dh+"&optype=delete&lineno="+$('#'+gridid).val();						
			var res = fetchMultiPValue("air_route_manage",6,param);
        	if(res[0][0]=="SUCCEED"){        	             				
				alert("删除路由成功！");
				//若删除成功，则在页面上删掉路由表格(先返回包含路由表格的div的id，然后删除)				
				var tmpid = document.getElementById(gridid).value1;	
				$('#'+tmpid).remove();												
        	}
        	else{
        		alert("删除路由失败！\r\n\n错误消息："+res[0][1]);
        	} 			
			
		}		
		//输出指定个数的空格
		function writespace(count){
			var s = "";
			for (var i=1; i<=count; i++){
				s+="&nbsp;";
			}
			document.write(s);			
		}
		
		function test(){
			alert($('#gridroute_0').caption);
		}
		
		
		/**
		* 20120619
		* 李伟松
		* 配线
		**/
		//配线按钮时间		
		function bindRoute(dh,key2,MoKuaiJu,linenum){
			//设置并机标识，用于判断是否并机；isParallel=0：非并机 ；isParallel=1：并机
			$('#isParallel').val(0);
            $('#grid_user').setSelection(key2, true);			
			
			//是否有操作权限验证
			//admin和数据管理员、管理员权限组拥有全部权限，其他权限组的工号
				//根据scddbm表中配置的信息进行权限控制
				//由于一个工号可以同时属于多个权限组，权限组之前用~分割开，
			//登入工号权限组
			var userGroupId = $("#userGroupId").val();	
			userGroupId = "~" + userGroupId + "~";
			if(useridd != "admin" && (userGroupId.indexOf("~1~") ==-1) && (userGroupId.indexOf("~2~") ==-1) ){
				var isRight = isModMKJ.charAt(MoKuaiJu)
				if(isRight == '' ){
					alert("您没有该模块配线权限。");
					return ;
				}//end if:isRight;
			}
			
			//锁定该电话的该线路，防止多人设置同一条号线
			var flag = lockAirUser(dh , linenum);
			if( flag == false){ 
				return;
			}
					
			//判断是否已配线，1:已配线修改配线信息，0:未配线新增配线信息
			var res=$('#route_exists').val();
			if( res == 1 ){
				editRoute(2);//修改操作
			}else if( res == 0 ){
				editRoute(1);//新增操作
			}//end if: res;
			$("#dhvaluets").text("当前配线电话："+$("#routeAdd_dh").val());
		}
		/**
		* 20120619
		* 李伟松
		* 并机配线
		**/
		function bindRouteBj(key1,key2,linenum){
			//判定是否是并机1为并机；0为非并机
			$('#isParallel').val(1);
			
            $('#grid_bj').setSelection(key2, true);
            		
            
            //修改选择用户号线，获取选择表格行号
			var rowid = $("#grid_user").getGridParam("selrow");
			if (rowid == null) 
			{
				alert("请先选中用户记录，再进行此操作！");
				return;
			}
			var MoKuaiJu=$("#grid_user").getCell(rowid,'MoKuaiJu');		//模块局		
			
			//是否有操作权限验证
			var isModMKJJRigth = '' ;
			//admin和数据管理员、管理员权限组拥有全部权限，其他权限组的工号
				//根据scddbm表中配置的信息进行权限控制
				//由于一个工号可以同时属于多个权限组，权限组之前用~分割开，
			//登入工号权限组	
			var userGroupId = $("#userGroupId").val();	
			userGroupId = "~" + userGroupId + "~";
			if(useridd != "admin" && (userGroupId.indexOf("~1~") ==-1) && (userGroupId.indexOf("~2~") ==-1) ){
				var isRight = isModMKJ.charAt(MoKuaiJu);
				if(isRight == '' ){
					alert("您没有该模块配线权限。");
					return ;
				}
			}
			
			
            //锁定该电话的该线路，防止多人设置同一条号线
			var flag = lockAirUser(key1 , linenum);
			if( flag == false){ 
				return;
			}	
			
			//判断是否已配线，1：已配线修改配线信息:0：未配线新增配线信息
			var res=$('#route_exists_bj').val();	
			if(res==1){
				editRoute(2);
			}else if(res==0){
				var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryBjAdd','', 'route');
				urlstr += '&dh='+tsd.encodeURIComponent($('#bjdh').val())+'&userid='+$('#userid_bj_add').val();
				$('#grid_bj_add').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid")
				autoBlockFormAndSetWH('divRouteAddBj',30,'100px','close',"#ffffff",false,'', '');
				//editRoute(1);
			}			
		}
		
		//往jqgrid上添加操作列
		function addRowOperBtnExtend(gridId,linkName,url,idName,outType,index){
			var menuTblRow = document.getElementById(gridId).rows;
			var idName_b = arguments[6];
			var idName_c = arguments[7];
			var idName_d = arguments[8];
			var useSecondKey1 = (typeof idName_b=='undefined'?false:true);
			var useSecondKey2 = (typeof idName_c=='undefined'?false:true);
			var useSecondKey3 = (typeof idName_d=='undefined'?false:true);
			var len = menuTblRow.length;
			var temp=[];
			for(var j=1;j<len;j++){
				var params =jQuery('#'+gridId).getRowData(j)[idName];
				var paramsb;
				var paramsc = jQuery('#'+gridId).getRowData(j)[idName_c];
				var paramsd = jQuery('#'+gridId).getRowData(j)[idName_d];
				if(useSecondKey1){
					paramsb=j;
				}
				var btnHtml='';
				if(outType=='link'){
					btnHtml+='<a href=\"'+url+'&'+idName+'='+params;
					if(useSecondKey1){
						btnHtml+='&'+idName_b + '=' + paramsb;
					}
					if(useSecondKey2){
						btnHtml+='&'+idName_c + '=' + paramsc;
					}
					if(useSecondKey3){
						btnHtml+='&'+idName_d + '=' + paramsd;
					}
					btnHtml+='\">'+linkName+'</a>';
				}else if(outType=='click'){
					btnHtml+='<a title='+linkName+' href=\"javascript:'+url+"('"+params;
					if(useSecondKey1){
						btnHtml+="',"+paramsb;
					}
					if(useSecondKey2){
						btnHtml+=",'"+paramsc +"' ";
					}
					if(useSecondKey3){
						btnHtml+=",'"+paramsd +"' ";
					}
					btnHtml =btnHtml+")\">"+linkName+'</a>';
				}
				temp[j]=btnHtml;
			}
			menuOpers[index-1]=temp;
		}
		
		

//显示用户详细信息
		function showUserInfo(){
			var rowid = jQuery("#grid_user").getGridParam("selrow");			
			if (rowid == null) 
			{				
				alert("请先选中用户记录，再进行此操作！");
				return;
			}		
			var dh=$("#grid_user").getCell(rowid,'Dh');			
			var urlstr = '&dh='+tsd.encodeURIComponent(dh);
			//返回该用户的线路数目
			var res = fetchMultiArrayValue('dbsql_route.QueryUserInfo',6,urlstr,'route');
			if (res != undefined && res!="" && res.length>0){
				var UserName = res[0][0];
                if (UserName != undefined)
                {
                    var UserBM = res[0][1];
                    var userAddr = res[0][2];
                    var linkMan = res[0][3];
                    var linkDh = res[0][4];
                    var MoKuaiJu = res[0][5];
                    var Regdate = res[0][6];
                    
                    var bm1 = res[0][7];
                    var bm2 = res[0][8];
                    var bm3 = res[0][9];
                    var bm4 = res[0][10];
                    var dhgn = res[0][11];
                    var bz2 = res[0][12];
                    var ywarea = res[0][13];
                    var yhxz = res[0][14];
                    var yhlb = res[0][15];
                    var sflx = res[0][16];                    
                    var dhzt = res[0][17];
                    var lxdh = res[0][18];
                    
                    $('#dis_bm1').html(bm1);
                    $('#dis_bm2').html(bm2);
                    $('#dis_bm3').html(bm3);
                    $('#dis_bm4').html(bm4);
                    $('#dis_dhgn').html(dhgn);
                    $('#dis_bz2').html(bz2);
                    $('#dis_ywarea').html(ywarea);
                    $('#dis_yhlb').html(yhlb);
                    $('#dis_sflx').html(sflx);
                    $('#dis_yhxz').html(yhxz);                    
                    $('#dis_username').html(UserName);                    
                    $('#dis_userbm').html(UserBM);
                    $('#dis_useraddress').html(userAddr);
                    $('#dis_linkman').html(linkMan);
                    $('#dis_mkj').html(MoKuaiJu);
                    $('#dis_Regdate').html(Regdate);
                    $('#dis_linkdh').html(linkDh);
                    $('#dis_dh').html(dh);                    
                    $("#dis_mokuaiju").html(MoKuaiJu);
                    $("#dis_dhzt").html(dhzt);
                    $("#dis_lxdh").html(lxdh);
                    
                    autoBlockForm('userdhinfos', 20, 'closedhinfos', "#ffffff", false);
                    //弹出查询面板
                }
			};
			autoBlockForm('userdhinfos', 20, 'closedhinfos', "#ffffff", false);
		}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////        权限控制        ///////////////////////////////
/////////////////////////////////////////////////////////////////////////////		
		//权限控制的全局变量
		var isViewMKJ = ''	;	//登入工号可查看号线的模块局
		var isModMKJ = ''	;	//登入工号可进行配线号线的模块局
		var isModDevice = ''	;	//登入工号可进行设置的号线设备
		/**
		* 获取登入工号权限
		* 包括：查看号线的模块局、可进行配线号线的模块局、可进行设置的号线设备
		* @param 
		* @return 	isViewMKJ
		*			isModMKJ
		*			isModDevice
		*/
		function getRightsOfScddbm(){
			var useridd = $("#useridd").val();			//登入工号
			var userGroupId = $("#userGroupId").val();	//登入工号权限组
			var manArea = $("#manArea").val();			//登入工号所在营业区域；逗号隔开'，'多个区域
			var magDepart = $("#magDepart").val();		//登入工号所在部门				
			
			//admin和数据管理员、管理员权限组拥有全部权限，其他权限组的工号
			//根据scddbm表中配置的信息进行权限控制
			//由于一个工号可以同时属于多个权限组，权限组之前用~分割开，
			var userGroupId = $("#userGroupId").val();	
			userGroupId = "~" + userGroupId + "~";
			if(useridd == "admin" || (userGroupId.indexOf("~1~") !=-1) || (userGroupId.indexOf("~2~") !=-1) ){
				//获取系统中全部模块局
				var allModDeviceA = fetchMultiArrayValue('dbsql_route.RM.QueryModDevAll',6,'','route');
				if (allModDeviceA != undefined && allModDeviceA!="" && allModDeviceA.length>0){
					//将获取到的可进行设置的号线设备数组转化成字符串
					isModDevice = allModDeviceA.join(',');					
				};
				
				//获取系统中全部设备编号
				var allMKJA = fetchMultiArrayValue('dbsql_route.RM.QueryMKJAll',6,'','route');				
				if (allMKJA != undefined && allMKJA!="" && allMKJA.length>0){
					var thismkj = allMKJA.join(',');
					isViewMKJ = thismkj;
					isModMKJ = thismkj;
				};
			}else{
				//获取登入工号权限
				var urlsql = '&manArea=' + tsd.encodeURIComponent(manArea) + 
							 '&magDepart=' + tsd.encodeURIComponent(magDepart) ;
				var RigthsScddbm = fetchMultiArrayValue('dbsql_route.RM.QueryRigthsOfscddbm',6,urlsql,'route');
				if (RigthsScddbm != undefined && RigthsScddbm!="" && RigthsScddbm.length>0){
				
					var isViewMKJA =new Array();  	//登入工号可查看号线的模块局数组
					var isModMKJA = new Array(); 	//登入工号可进行配线号线的模块局数组
					var isModDeviceA = new Array();  //登入工号可进行设置的号线设备
					
					for(var i=0; i<RigthsScddbm.length; i++){
						//可查看的模块局包括：scddbm表中设置的可查看模块局 和 可修改模块
						isViewMKJA.push( RigthsScddbm[i][0] );
						isViewMKJA.push( RigthsScddbm[i][1] );
						
						isModMKJA.push( RigthsScddbm[i][1] );
						isModDeviceA.push( RigthsScddbm[i][2] );
					}
					
					//将获取到的数组转化成字符串
					isViewMKJ = isViewMKJA.join(',');
					isModMKJ = isModMKJA.join(',');
					
					isModDevice = isModDeviceA.join(',');		
				}//end if (RigthsScddbm)
			}
		}
		

		/***********************
	   	* 锁定账号线路
	   	* @param;
	   	* @return;
	   ************************/
		function lockAirUser(dh,linenum){
			var flag = false;
			var Func = 'lock';//锁定
			var oper= tsd.encodeURIComponent($("#useridd").val());
			var params = '&Func=' + Func + '&oper=' + oper +
						'&dh=' + dh + '&linenum=' + linenum;
			var result = fetchMultiPValue("RouteManage.air_IfHandle",6,params,'route');
			if(result[0]!=undefined && result[0][0]!="")
			{
				if(result[0][0] == 'Error' ){
					alert(result[0][1]);
				}else if (result[0][0] == 'SUCCEED' ){
					flag = true;
				}				
			}
			return flag;
		}
		
		/***********************
	   	* 清除被锁定账号线路
	   	* @param;
	   	* @return;
	   ************************/
	   function unLockAirUser()
	   {	   		
	   		var Func = 'unlock';//解锁
			var oper= tsd.encodeURIComponent($("#useridd").val());
			var params = '&Func=' + Func + '&oper=' + oper ;
			var result = fetchMultiPValue("RouteManage.air_IfHandle",6,params,'route');		
	   }
	   /***********************
	   	* 配线树组
	   	* @param;
	   	* @return;
	   ************************/
	   function initTree_route(param,num){
	   		//var  treeNode =zTreeObj.getNodeByParam("id", v_devno, nodes[0]);
			//zTreeObj.addNodes(treeNode, devNodes);
			//alert(num);   
			var treesHtml='<div class="divTreeDM"><ul id="tree'+num+'" class="ztree" style="padding-bottom:10px;"></ul></div>';
			$('#treeGroup').html($('#treeGroup').html()+treesHtml);
			var devNodes = [];
			var devNode;
			var res = fetchMultiArrayValue('dbsql_route.QueryRoute_tree',6,param,'route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					//配线树上的最后一个节点是用户地址，区分用户地址树上节点图标
					if( i == (res.length -1)){
						devNode = {"name":res[i][0],"open":true,"icon":"<%=iconpath%>/119.gif",childs:[{"name":res[i][1]}]};
					}
					else{
						devNode = {"name":res[i][0],"open":true,"icon":"<%=iconpath%>/125.gif",childs:[{"name":res[i][1],"open":true,"icon":"<%=iconpath%>/125.gif",childs:[{"name":res[i][2]}]}]};
					}
					devNodes.push(devNode);
				}
			};

			var zTreeNodes = [			
				{"name":"配线序号"+parseInt(num+1), open:true, childs: devNodes }
			];			
			$.fn.zTree.init($("#tree"+num), '', zTreeNodes);
																			
		}
		
		
		/***********************
	   	* 号线历史信息
	   	* @param;
	   	* @return;
	   ************************/
	   function initTree_route_his(param,num){
	   		//var  treeNode =zTreeObj.getNodeByParam("id", v_devno, nodes[0]);
			//zTreeObj.addNodes(treeNode, devNodes);
			//alert(num);   
			var treesHtml='<div class="divTreeDM"><ul id="tree'+num+'_his" class="ztree" style="padding-bottom:10px;"></ul></div>';
			$('#treeGroup2').html($('#treeGroup2').html()+treesHtml);
			var devNodes = [];
			var devNode;
			var res = fetchMultiArrayValue('dbsql_route.QueryRoute_tree',6,param,'route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					//配线树上的最后一个节点是用户地址，区分用户地址树上节点图标
					if( i == (res.length -1)){
						devNode = {"name":res[i][0],"open":true,"icon":"<%=iconpath%>/119.gif",childs:[{"name":res[i][1]}]};
					}
					else{
						devNode = {"name":res[i][0],"open":true,"icon":"<%=iconpath%>/125.gif",childs:[{"name":res[i][1],"open":true,"icon":"<%=iconpath%>/125.gif",childs:[{"name":res[i][2]}]}]};
					}
					devNodes.push(devNode);
				}
			};

			var zTreeNodes = [			
				{"name":"配线序号"+parseInt(num+1), open:true, childs: devNodes }
			];			
			$.fn.zTree.init($("#tree"+num+"_his"), '', zTreeNodes);
																			
		}
	   
	</SCRIPT> 
    <style type="text/css">
    	input{
			vertical-align:middle;
			height:16px;
			}
		select{
			vertical-align:middle;
			}	
		.divTreeDM{
			float: left;
			margin-top:1px;
		}
    </style>
</head>
<body onbeforeunload='unLockAirUser();'>
	<DIV class="ui-layout-north" style="overflow-x: hidden;overflow-y: hidden;">
		<div id="navBar1" style="margin:-10px">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />您当前所在的位置 ：		 												 													
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);" onclick="parent.history.back(); return false;">
								返回
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>					
	</DIV> 
	<DIV  >		
	<!-- class="ui-layout-south" -->
		<div style="margin-top:-5px; margin-bottom:-7px;display: none;" >			
			<button class="tsdbutton" id="btnclose" onclick="closeDialog();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
				关闭
			</button>			
		</div>					
	</DIV> 	
	<DIV class="ui-layout-west" >
		<div id="input-Unit" style="margin-top: -5px; margin-left: -5px;margin-right: -10px;margin-bottom: -10px;">
        	<!--  
        	<fieldset style="width:1400px;"><legend><span style="font-size:14px;">条件查询</span></legend>
			-->
			<div style="width:100%; height:40px; text-align:left; ">	
				<div style="display: none;">	
				系统类型
				<select id="routetype" style="width: 110px;" >
					<option value='' selected='selected'>--全部--</option>
					<option value='phone'>电话</option>
					<option value='broadband'>宽带</option>
					<option value='device'>设备</option>
					<option value='tv'>有线电视</option>
				</select>
				配线方式<select id="linemode" style="width: 100px;" >
					<option value='' selected='selected'>--全部--</option>
					<option value='MDF'>配线架</option>
				    <option value='ODF'>光纤到户</option>
				</select><br/>		
				</div>		
				查询条件<select id="queryfield" style="width: 110px;" >
					<option value="dh">用户电话</option>
					<option value="internetacct">宽带帐号</option>
					<option value="username">用户名称</option>
					<option value="useraddr">用户地址</option>
				</select>
				<input type="text" id="queryvalue" value="" style="width:145px;"/>
				<input  class="tsdbutton" type="button" value="精确查询" onclick="query_user(0);"/>
				<input  class="tsdbutton" type="button" value="模糊查询" onclick="query_user(1);"/>
			</div>
			
			<div style="width:100%;">
	 			<table id="grid_user" class="scroll" cellpadding="0" cellspacing="0" ></table>
				<div id="pager_user" class="scroll" style="text-align:left;"></div>			
			</div>	
			
			<div style="  float:left;">
	 			<table id="grid_bj" class="scroll" cellpadding="0" cellspacing="0" ></table>
				<div id="pager_bj" class="scroll" style="text-align:left;"></div>
			</div>
			<!-- 
            </fieldset>
             -->
		</div>
	</DIV>	
	<DIV class="ui-layout-center">	
		<!-- <div id="divroute" style="float:left;margin-left: -5px;">
				
		</div> -->			
		<div id='treeGroup' style="float:left;margin-left: -5px;height: 250px;">

        </div>
        <br />
        <div id="hisrouteinfo" style="margin-top: 300px;height: 200px;">
	        <fieldset style="height: 200px;">
			<legend>历史号线信息：</legend>
	        <div id='treeGroup2'>
	        
	        </div>
		</fieldset>
	    </div>
        
        						
	</DIV>
	
	<!-- 用户类型 -->
	<input type="hidden" id="route_ywlx" value="<%=route_ywlx %>"/>
	<!-- 用户账号 -->
	<input type="hidden" id="route_accesstype" value="<%=route_accesstype %>"/>
	<!-- 接入类型 -->
	<input type="hidden" id="route_username" value="<%=route_username %>"/>
	<!-- 工单id -->
	<input type="hidden" id="route_jobid" value="<%=route_jobid %>"/>
	<!-- 基本 -->
	<input type="hidden" id="useridd" value="<%=userid%>"/>	
	<input type="hidden" id="imenuid" value="<%=imenuid%>" />
	<input type="hidden" id="zid" value="<%=zid%>" />
	<!-- 用户权限组 -->
	<input type="hidden" id="userGroupId" value="<%=sGroupid%>" />	
	<!-- 业务区域 -->
	<input type="hidden" id="manArea" value="<%=manArea%>" />
	<!-- 管理部门 -->
	<input type="hidden" id="magDepart" value="<%=sDepart%>" />
	
	<!-- 判断路由是否存在 -->
	<input type="hidden" id="route_exists" value="" />
	<!-- 自由路由权限 -->
	<input type="hidden" id="notFixedRoute" value="" />
	<input type="hidden" id="route_exists_bj" value="" />
	<input type="hidden" id="route_bj" value="" />
	<input type="hidden" id="isParallel" value="" />
	<input type="hidden" id="bjdhtype" value="" />
	<input type="hidden" id="bjdh" value="" />
	<input type="hidden" id="linenum_bj_add" value="" />
	<input type="hidden" id="userid_bj_add" value="" />
	
	<input type="hidden" id="hidywtype" />
	
	<!-- 电话的号线序号列表 -->
	<input type="hidden" id="routeIds" value="" />
	<!-- 主表新增、编辑页面 -->
	<jsp:include page="RouteAdd.jsp"  flush="true" />
	<!-- 用户详细信息页面 -->
	<jsp:include page="UserInfo.jsp"  flush="true" />
	<!-- 主表新增、编辑页面 -->
	<jsp:include page="RouteAddrUpdate.jsp"  flush="true" />
	<!-- 文档管理 -->
	<jsp:include page="LineDocumentM.jsp"  flush="true" />
	<!-- 电话互换 -->
	<jsp:include page="RouteChangeLine.jsp"  flush="true" />
	
	
	
</body>
</html>