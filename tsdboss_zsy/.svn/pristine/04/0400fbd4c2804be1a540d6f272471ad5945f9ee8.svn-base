<%----------------------------------------
	name: RouteTemp.jsp
	author: wangli
	version: 1.0 
	description: 路由模板管理 
	Date: 2011-12-08
	2012-8-9 ：yhy 删除页面中无用代码
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String sUserId = (String) session.getAttribute("userid");
	String sArea = (String) session.getAttribute("chargearea");
	String sDepart = (String) session.getAttribute("departname");
	String sMenuid = request.getParameter("imenuid");
	String sGroupid = request.getParameter("groupid");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/ui/jquery.layout.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js"
			type="text/javascript"></script>
		<script src="script/broadband/business/broadbandservice.js"
			type="text/javascript"></script>
		<script src="script/broadband/business/radbusiprint.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>

		<script type="text/javascript" src="script/public/tsdpower.js"></script>
		<!-- 页面权限控制 -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/mainStyle.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/revenue.js"></script>

		<script type="text/javascript"
			src="plug-in/jquery/jquery.cookie-min.js"></script>
		<script type="text/javascript"
			src="plug-in/jquery/zTree/jquery.ztree.core-3.0.js"></script>
		<script type="text/javascript"
			src="plug-in/jquery/zTree/jquery.ztree.excheck-3.0.min.js"></script>
		<script type="text/javascript"
			src="plug-in/jquery/zTree/jquery.ztree.exedit-3.0.min.js"></script>

		<link rel="stylesheet" href="style/zTreeStyle/zTreeStyle.css"
			type="text/css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 新的面板样式 -->
		<link href="style/css/telephone/business/businesspublic.css"
			rel="stylesheet" type="text/css" />
		<style type="text/css">
.maxpanel {
	padding: 1%;
	background-color: #CCCCCC;
	padding-bottom: 15px;
	position: absolute;
	filter: alpha(opacity =   25);
	z-index: 2000;
}

#input-Unit {
	float: left;
	width: 100%;
	text-align: center;
}

#input-Unit .title_rad {
	width: 101%;
	text-align: left;
	height: 22px;
	border-bottom: 1px solid #C8D8E5;
	padding-left: 15px;
	margin-left: -16px;
	color: #3C3C3C;
	line-height: 22px;
	font-weight: bold;
	background: #CCCCFF;
}

.tsdbutton_rad {
	width: 70px;
	height: 22px;
	background: url(style/images/public/buttonsbg.jpg) repeat-x;
	border: #CCCCCC 1px solid;
	cursor: pointer;
}
</style>
		<script type="text/javascript">	
		var gridimgpath = 'plug-in/jquery/jqgrid/themes/basic/images/';	
		var mylayout;
		<%--取被选业务类型值--%>
		var ywtype='phone' ;				
		$(document).ready(function () {				
			//利用布局控件设置布局			
			mylayout = $('body').layout({ 
				applyDefaultStyles: true,
				west__size:540,
				center__resizable:false,
				north__resizable:false,
				south__resizable:false,
				north__closable:false,
				east__closable:false,
				south__closable:false,
				center__closable:false,									
				spacing_open:3										
			});		
			$("#navBar").append(genNavv());	
			//初始化可选路由|模块局列表
			initGrid_device();	
			//初始化路由|模块局定义
			initGrid_newroute();
			//初始化时，设置按钮的enabled状态
			setInitState();
			//初始化业务区域下拉框值
			getArea();
			//设置页面部分控件的不可用性
			$("#grid_newroute,#cancel,#grid_device,#add,#btnsave").attr("disabled","disabled");
			//隐藏”初始化路由|模块局定义“表格中的下方操作按钮
			$("#pager_newroute").hide();									
		});
		
		//初始化可选路由|模块局列表
		function initGrid_device(){								
			jQuery('#grid_device').jqGrid({								
				height: 304,	  	
				width:300,
				datatype: "xml",
			   	colNames:['devno', '名称'],
			   	colModel:[			        
			        {name : 'devno', index : 'devno', hidden:true},
			        {name : 'devname', index : 'devname',width:200}			        			        		
			   	],
			   	imgpath: gridimgpath,			   	
			   	sortname: 'devno',
			    viewrecords: true,
			    sortorder: "asc",
				multiselect: false,
				useDefault:true,
				ondblClickRow: function(rowid) {
					//双击触发“移入”操作
					addDeviceNode();
				},				
				caption:"可选路由|模块局列表"			
			});		
			setTimeout("fillGrid_device();", 260);
		}
		
		//初始化路由|模块局定义
		function initGrid_newroute(){			
			jQuery('#grid_newroute').jqGrid({				
				height:280,	  	
				width:300,
				datatype: "xml",
			   	colNames:['', 'devno', '设备名称'],
			   	colModel:[		
			   		{name : 'routesort', index : 'routesort', width:30},        
			        {name : 'devno', index : 'devno', hidden:true},
			        {name : 'devname', index : 'devname',width:200}			        			        		
			   	],
			   	imgpath: gridimgpath,			   	
			   	sortname: 'routeno',
			    viewrecords: false,
			    sortorder: "asc",
				multiselect: false,
				useDefault:true,
				pager: jQuery('#pager_newroute'),
				pgbuttons: false,
				pginput: false,
				loadComplete: function(){
				}, 
				//2012-8-7 yhy 去掉双击事件，该双击时间无用			
				caption:"路由|模块局定义"	
			}).navGrid('#pager_newroute',{refresh: false, edit: false, add: false, del: false, search: false});
		  jQuery("#grid_newroute").navGrid('#pager_newroute',{refresh: false, edit: false, add: false, del: false, search: false}).navButtonAdd(
		  '#pager_newroute',{ caption:"删除", buttonimg:"style/images/public/tubiao_2.jpg", onClickButton: delRouteNode, position:"last" }).navButtonAdd(  
		  '#pager_newroute',{ caption:"清空", buttonimg:"style/images/public/ltubiao_04.gif", onClickButton: cleargrid, position:"last" });		
		}
		
		//添加“权限类型”下拉框changge事件
		function fillGrid_device(){						
			$(document).ready(function(){
				$("#routetype").change(function(){
			 		getgridvalue();
			 	});
			});
		}
		
		//初始化时，设置按钮的enabled状态
		function setInitState(){
			$('#btnadd').attr("disabled",false);
			$('#btnupdate').attr("disabled",false); 
			//$('#btnsave').attr("disabled",true);
			$('#spanadd').css('color','black');
			$('#spanedit').css('color','black');			
		}
		
		//2012-9-4 yhy start 修改获取数据方式不从内存直接获取
		/*
		//初始化业务区域下拉框值
		function getArea(){
			var languageType = $("#languageType").val();           
	        $.ajax({
					url:"phone_querydate?func=query",
					async:true,//异步
					cache:false,
					timeout:20000,//1000表示1秒
					type:'post',
					success:function(xml,textStatus){					   					   
					    var ywarea = xml.substring(xml.indexOf("<ywarea=")+8,xml.indexOf("ywarea/>"));
					    $("#bmYwArea").html(ywarea);
					}						
				});
		}
		*/
		//初始化业务区域下拉框值
		function getArea(){
			$("#bmYwArea").empty();
			var res = fetchMultiArrayValue('FINAL_route.area_ywsl',6,'','route');
		 	if(res!=undefined&&res!=""){
		 		var str="<option value=''>--请选择--</option>";
			 	for(var j=0;j<res.length;j++){
			 		str+="<option value='"+res[j][0]+"'>"+res[j][0]+"</option>" ;
			 	}
			 	$("#bmYwArea").html(str);
		 	}
		}
		//2012-9-4 yhy end
		
		
		//当“业务区域”选中值变化时触发该函数，获取“可选部门”数据
		function getScBm(){
		//2012-9-4 zcc start 
			$("#bmYwArea").change(function(){
					
				$("#routetype").attr("disabled","disabled");
			})
		//2012-9-4 zcc end	
			$("#selectBm").empty();
			var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=id,bm&tablename=scddbm&key=area='"+tsd.encodeURIComponent($("#bmYwArea").val())+"'");
		 	if(res!=undefined&&res!=""){
		 		var str="<option value=''>--请选择--</option>";
			 	for(var j=0;j<res.length;j++){
			 
			 	
			 		str+="<option value='"+res[j][0]+"'>"+res[j][1]+"</option>" ;
			 	}
			 	$("#selectBm").html(str);
		 	}
		}
		
		//当“可选部门”值变化时触发该函数，获取“权限类型”下拉框中的值
		function getywtype(){
			var routetype=$("#routetype").val();
			$("#routetype").val("");
			
			//用于清空“可选路由|模块局列表”、“路由|模块局定义”列表数据
			
				getgridvalue();		
		}
		
		//当“权限类型”值变化时触发该函数
		//根据“业务区域” + “可选部门” + “权限类型” 值获取“可选路由|模块局列表”、“路由|模块局定义”列表数据
		function getgridvalue(){
			//2012-10-9 zcc start 
			if(routetype != "" && routetype != null)
				{
					$("#routetype").removeAttr("disabled");	
				}
			else{
					$("#routetype").attr("disabled","disabled");				
				}	
			//2012-10-9 zcc end 
			var array="";
			var obj=document.getElementById('routetype');
			ywtype = obj.value;
			//根据“权限类型”值来判断“可选路由|模块局列表”列表执行数据的来源
			//2012-8-30 yhy start
			//可修改模块局 、可查看模块局取值mokuaiju表
			//sql语句dbsql_route.BMDeviceManager_queryair_QueryArea 改为dbsql_route.BMDeviceManager_queryair_QueryMKJ
			if(ywtype=="LINEFIELDS"){
				var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.BMDeviceManager_queryair_QueryDevice','', 'route');		
			}else if(ywtype=="VIEWMOKUAIJUS"){
				var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.BMDeviceManager_queryair_QueryMKJ','', 'route');			
			}else if(ywtype=="MODIMOKUAIJUS"){
				var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.BMDeviceManager_queryair_QueryMKJ','', 'route');						
			}else{
				ywtype="1";
				var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.BMDeviceManager_querydual','', 'route');
			}
			//2012-8-30 yhy end									
			$('#grid_device').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
			
			//重新获取“路由|模块局定义”列表数据
			$('#grid_newroute').clearGridData();
			var bmYwArea=$("#bmYwArea").val();
			var selectBm=$("#selectBm").val()
			if(ywtype=="1"){
				bmYwArea='/';
				selectBm='-1';
			}
			var res = fetchSingleValue('dbsql_route.BMDeviceManager_queryair_QueryScddbm',6,'&tablefield='+ywtype+'&ywarea='+tsd.encodeURIComponent(bmYwArea)+'&bmid='+selectBm,'route');		
			if(res == undefined ||res == ""){
				return false;
			}else{		
				array=res.split(",");							
				for(var i=0;i<array.length;i++){
					if(ywtype=="LINEFIELDS"){
						var resdevno = fetchSingleValue('dbsql_phone.querytabledate',6,"&cloum=devname&tablename=air_device_master&key=devno='"+array[i]+"'");
						var rowdata = {'routesort':i+1,'devno':array[i],'devname': resdevno};
					}else{
						var rowdata = {'routesort':i+1,'devno':array[i],'devname': array[i]};
					} 
					$('#grid_newroute').addRowData(i+1,rowdata);
				}
			}
		}
			
		
		//清空“路由|模块局定义”表格
		function cleargrid(){
			$('#grid_newroute').clearGridData();
		}
		
			
		//“路由|模块局定义”表格中的“删除”按钮操作事件
		//从“路由|模块局定义”表格中删除“路由设备”、“模块局”
		function delRouteNode(){
			var table = document.getElementById('grid_newroute');			
			var rowid=$('#grid_newroute').getGridParam("selrow");
			var delnum = $('#grid_newroute').getRowData(rowid).routesort;			
			$('#grid_newroute').delRowData(rowid);
			//如果删除的行不是最后一行，那么删除后，后续行的序号要减1
			//注意，删除后，jqgrid的rowid保持不变，并不会自动减1，所以不能用jqgrid的方法完成下面的功能										
			for (var i = 1; i < table.rows.length; i++)
            {                	                
                var num = table.rows(i).cells(0).innerText;	                
                if (parseInt(num) > parseInt(delnum)){	                	
                	table.rows(i).cells(0).innerText = parseInt(num)-1; 	                	
                }	
            }				
		}
		
		//页面上“移入”按钮事件
		//将“可选路由|模块局列表”列表中的选中设备添加到“路由|模块局定义”表格中
		function addDeviceNode(){
			var rowid=$('#grid_device').getGridParam("selrow");			
			var devno=$('#grid_device').getCell(rowid,'devno');
			if (devno=='' || devno==null) 
			  return;					
			var devname = $('#grid_device').getCell(rowid,'devname');			
			addRouteNode(devno, devname);
		}
		
		//添加设备到“路由|模块局定义”表格中
		function addRouteNode(devno, devname){
			//如果设备已添加，则不再添加
			if (devIsExists(devno)){
				//提示已添加
				alert("该设备已经添加");
				return;
			}			
			var rowid = getrowid();
			var rowdata = {'routesort':rowid, 'devno':devno,'devname': devname}; 
			$('#grid_newroute').addRowData(rowid, rowdata);
		}
			
		//路由表格中的设备节点是否存在，存在返回true
		function devIsExists(devno){
			var table = document.getElementById('grid_newroute');
			var curdev;			
			for (var i = 1; i < table.rows.length; i++)
            {                	                
                curdev = table.rows(i).cells(1).innerText;                	                
                if (curdev == devno){	                	
                	return true;
                	break; 	                	
                }	
            }
            return false;	
		}
		
			
		//返回grid_newroute表格的新的rowid即原行数+1
		function getrowid(){
			var therow = document.getElementById('grid_newroute').rows;
			return therow.length;
		}
		
		//返回业务类型和配线方式的路由模板是否存在
		function TempIsExists(routetype, linemode){
			var ids = $('#grid_route').getDataIDs();
			var v_routetype = "";
			var v_linemode = "";
			for (var i=0; i<ids.length; i++)
			{
				v_routetype = $('#grid_route').getRowData(ids[i]).routetype;				
				v_linemode = $('#grid_route').getRowData(ids[i]).linemode;
				if (v_routetype==routetype && v_linemode==linemode){
					return true;
					break;
				}
			}			
            return false;
		}
		
		//按钮事件 key=1 编辑 key=2 保存 key=3 取消
		function getUedit(key){
			if($("#routetype").val()==""){
				alert("请先选择权限类型！");
				$("#routetype").select().focus();
				return;
			}
			if($("#bmYwArea").val()==""){
				alert("请先选择业务区域！");
				$("#bmYwArea").select().focus();
				return;
			}
			//2012-10-10 zcc start
			if($("#selectBm").val()=="" || $("#selectBm").val()==null){
				alert("请先选择可选部门！");
				$("#selectBm").select().focus();
				return;
			}
			//2012-10-10 zcc end 
			if(key=="1"){
				$("#grid_newroute,#cancel,#grid_device,#add,#btnsave").removeAttr("disabled","disabled");
				$("#uedit,#routetype,#bmYwArea,#selectBm").attr("disabled","disabled");
				$("#pager_newroute").show();	
			}else if(key=="3"){
				$("#grid_newroute,#cancel,#grid_device,#add,#btnsave").attr("disabled","disabled");
				$("#uedit,#routetype,#bmYwArea,#selectBm").removeAttr("disabled");
				$("#pager_newroute").hide();
				//getDict();	
				setTimeout('getgridvalue()','200');
			}else if(key=="2"){
				save();
			}
		}	
							
		//保存路由 flag=1:新增;flag=2:编辑;
		function save(){
			if (!confirm("您确定要进行保存操作吗？")){
				return;
			}			
			var optype = "";			
			var therow = document.getElementById('grid_newroute').rows;
			var param1 = "";
			var flag = $('#opflag').val();									
			if (NullCheck("#routetype", "权限类型")) {return};
			if (NullCheck("#linemode", "配线方式")) {return};
			var v_routetype = $('#routetype').val();
			var v_linemode = $('#linemode').val();
			//如果该业务类型已存在，则提示退出
			if (TempIsExists(v_routetype, v_linemode)){
				alert('已存在“'+v_routetype+'”和“'+v_linemode+'”的路由模板，不能再新增！');
				return;
			}
			var param = '&fieldtype='+tsd.encodeURIComponent(v_routetype);											
			var ids = $('#grid_newroute').getDataIDs();
			var v_portnos = "";
			var v_routenos = "";				
			var v_portno = "";
			var v_routeno = "";				 
			for (var i=0; i< ids.length; i++)
			{
				v_portno = $('#grid_newroute').getRowData(ids[i]).devno;
                v_routeno = $('#grid_newroute').getRowData(ids[i]).routesort;
                v_portnos += v_portno+",";
                v_routenos += v_routeno+",";
			}
			//去掉最后一项的逗号
			if (v_portnos != ""){
				v_portnos = v_portnos.substr(0, v_portnos.length-1);
			}
			if (v_routenos != ""){
				v_routenos = v_routenos.substr(0, v_routenos.length-1);
			}							
			param1 = param+"&fieldvalue="+tsd.encodeURIComponent(v_portnos)+"&ywarea="+tsd.encodeURIComponent($("#bmYwArea").val())+"&scBmId="+$("#selectBm").val();
			var res = fetchMultiPValue("BMDeviceManager.updateScddbm",6,param1);
			if(res[0][0]=="SUCCEED"){   				
				alert("新增路由模板成功！");
				//路由模板浏览表格中显示刚增加的路由模板
				//1.路由模板类型表格中显示新增记录
				addTempType(v_routetype, v_linemode)
				//2.路由模板浏览表格中显示新增记录
				showroute('grid_newroute', 'grid_route2');	
				//3.设置按钮为初始状态
				setInitState();
				getUedit(3);
        	}
        	else{
        		alert("增加路由模板失败！\r\n\n错误消息："+res[0][1]);
        	}								
									
		}
		//根据选择的编辑路由，在编辑页面中显示此路由信息。grid参数表示被选中编辑的grid
		function showroute(gridid1, gridid2){
			if (gridid1.substr(0,1)!='#'){
				gridid1 = '#'+gridid1;
			}
			if (gridid2.substr(0,1)!='#'){
				gridid2 = '#'+gridid2;
			}			
			//1.清除表格
			$(gridid2).clearGridData();
			//2.复制
			var ids = $(gridid1).getDataIDs();
			var rowdata;			
			for (var i=0; i< ids.length; i++)
			{
				rowdata = $(gridid1).getRowData(ids[i]);
				$(gridid2).addRowData(ids[i], rowdata);				
			}
		}	
		//控件是否为空的检测
		function NullCheck(CtlName, value){
			if ($(CtlName).val() == ""){
				alert(value+"不能为空，请重新填写！");
				$(CtlName).focus();
				return true;
			}
			return false;
		}
		
		//新增路由模板类型
		function addTempType(routetype, linemode){
			//var therow = document.getElementById('grid_route1').rows;			
			//var rowid = therow.length;
			var routetype1=$("#routetype").find("option:selected").text();
			var linemode1=$("#linemode").find("option:selected").text();
			//var rowdata = {'routetype':routetype, 'linemode':linemode, 'routetype1':routetype1, 'linemode1':linemode1}; 
			//$('#grid_route1').addRowData(rowid, rowdata);
		}
		
		
		//显示模板类型的名称
		function showDict(){
			var ids = $('#grid_route1').getDataIDs();			
			var routetype = "";
			var linemode = "";
			var routetype1 = "";
			var linemode1 = "";
			for (var i=0; i< ids.length; i++)
			{				
				routetype = $('#grid_route1').getRowData(ids[i]).routetype;				
				linemode = $('#grid_route1').getRowData(ids[i]).linemode;		
				if (routetype==undefined || linemode==undefined){
					continue;
				}					
				$("#routetype option").each(function(){
					if($(this).val() == routetype){					
						routetype1=$(this).text();						
					}					
   			    });
   			    
				$("#linemode option").each(function(){					
					if($(this).val() == linemode){					
						linemode1=$(this).text();						
					}					
   			    });				   			    			
				$('#grid_route1').setRowData(ids[i], {routetype1 : routetype1});
				$('#grid_route1').setRowData(ids[i], {linemode1 : linemode1});				
			}
		}
		//返回路由模板定义数据
		function fillGrid_route2(routetype,linemode){
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryTempRoute','', 'route');
			urlstr += '&routetype='+tsd.encodeURIComponent(routetype)+'&linemode='+tsd.encodeURIComponent(linemode);
			jQuery("#grid_route2").setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");	
		}
		//修改模板按钮代码
		function editTemp(){
			var rowid=$('#grid_route1').getGridParam("selrow");			
			if (rowid==null || rowid==""){
				alert('请先选择“路由模板”!');
				$('#grid_route1').focus();
				return;				
			}
			//将路由模板浏览表格中的路由模板记录显示在修改记录表格中
			showroute('grid_route2', 'grid_newroute');
			afterEdit();
			//设置操作标志位修改
			$('#opflag').val(2);
			var v_routetype = $('#grid_route1').getCell(rowid,'routetype');
			var v_linemode = $('#grid_route1').getCell(rowid,'linemode');					
			$('#routetype').val(v_routetype);
			$('#linemode').val(v_linemode);			
		}
			
		
		//新增后，设置按钮的enabled状态
		function afterAdd(){
			$('#btnsave').attr("disabled",false);
			$('#spanadd').css('color','red');
			$('#spanedit').css('color','black');
		}
		//修改后，设置按钮的enabled状态
		function afterEdit(){
			$('#btnsave').attr("disabled",false);
			$('#spanadd').css('color','black');
			$('#spanedit').css('color','red');
		}		
		
	</SCRIPT>
	</head>
	<body>
		<DIV class="ui-layout-north" style="overflow-x: hidden;overflow-y: hidden;">
			<div id="navBar1" style="margin: -10px -10px -8px -10px;">
				<table width="100%" style="height: 22px;">
					<tr>
						<td width="80%" valign="middle">
							<div id="navBar" style="float: left">
								<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
								您当前所在的位置 ：
							</div>
						</td>
						<td width="20%" align="right" valign="top">
							<div id="d2back" style="padding-right: 30px;">
								<a href="javascript:void(0);"
									onclick="parent.history.back(); return false;"> 返回 </a>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</DIV>
		<DIV class="ui-layout-center">
			<div id="input-Unit" style="margin-top: -8px;">
           
            	<fieldset style="width:820px; float:left;">
				<!--<div class="title_rad">-->
					<legend><span style="font-size:14px;">可管理号线设备/模块局设置</span></legend>
				<!--</div>-->
                
				<div style="width: 100%; height: 40px; text-align: left;">
					<div style="height: 40px; float: left; line-height: 40px;">
						业务区域:
					</div>
					<div style="height: 40px; float: left; line-height: 40px;">
						<select id="bmYwArea" style="width: 130px;" onchange="getScBm();">
						</select>
					</div>
					<div style="height: 40px; float: left; line-height: 40px;">
						可选部门:
					</div>
					<div style="height: 40px; float: left; line-height: 40px;">
						<select id="selectBm" style="width: 110px;" onchange="getywtype();">
						</select>
					</div>
					<div style="height: 40px; float: left; line-height: 40px;">
						权限类型:
					</div>
					<div style="height: 40px; float: left; line-height: 40px;">
						<select id="routetype" disabled="disabled" style="width: 130px;">
							<option value='' selected='true'>
								--请选择--
							</option>
							<option value='LINEFIELDS'>
								可管理设备设置
							</option>
							<option value='VIEWMOKUAIJUS'>
								可查看模块局设置
							</option>
							<option value='MODIMOKUAIJUS'>
								可操作模块局设置
							</option>
						</select>
					</div>
					<button class="tsdbutton" onclick="getUedit(1)" id="uedit">
						编辑
					</button>
					<button class="tsdbutton" id="btnsave" onclick="getUedit(2)"
						style="width: 70px; line-height: 25px; margin-top: 1px; padding: 0px;">
						保存
					</button>
					<button class="tsdbutton" id="cancel" onclick="getUedit(3)">
						取消
					</button>
				</div>
				<table border="1" cellpadding="0" bordercolor="#9AC0CD"
					style="height: 100%; width: auto; float: left;">
					<tr>
						<td>
							<table id="grid_device" class="scroll" cellpadding="0"
								cellspacing="0"></table>
						</td>
						<td style="width: 100px;">
							<button id="add"
								style="width: 90px; height: 36px; cursor: pointer;"
								onclick="addDeviceNode();">
								移入☞
							</button>
						</td>
						<td>
							<table id="grid_newroute" class="scroll" cellpadding="0"
								cellspacing="0"></table>
							<div id="pager_newroute" class="scroll" style="text-align: left;"></div>
						</td>
					</tr>
				</table>
                </fieldset>
			</div>
		</DIV>
		<input type="hidden" id="opflag" />
	</body>
	</thml>