<%----------------------------------------
	name: RouteTemp.jsp
	author: wangli
	version: 1.0 
	description: 路由模板管理 
	Date: 2011-12-08
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
			initGrid_route1();
			initGrid_route2();
			initGrid_device();	
			initGrid_newroute();				
			setInitState();
			getDict();
			setTimeout("fillGrid_route1();", 15);
			$("#grid_newroute,#cancel,#grid_device,#add,#btnsave").attr("disabled","disabled");
			$("#pager_newroute").hide();									
		});
		//2012-9-4 yhy start 修改获取数据方式不从内存直接获取
		/*
		//填充下拉框内容
		function getDict(){
			$.ajax({
				url:"phone_querydate?func=query",
				async:true,//异步
				cache:false,
				timeout:20000,//1000表示1秒
				type:'post',
				success:function(xml,textStatus)
				{					
				    var routetype = xml.substring(xml.indexOf("<routetype=")+11,xml.indexOf("routetype/>"));
				    var linemode = xml.substring(xml.indexOf("<linemode=")+10,xml.indexOf("linemode/>"));	
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
		
			
		//显示路由设备
		function fillGrid_device(){						
			$(document).ready(function(){
				$("#routetype").change(function(){
			 		getgridvalue();
			 	});
			});

			
		<%--	var scond ="and routetype='"+ywtype+"'";
			
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryDevice_Route','', 'route');
			urlstr += '&cond='+tsd.encodeURIComponent(scond);							
			$('#grid_device').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");		--%>	
		}	
		
		function getgridvalue(){			
			var obj=document.getElementById('routetype');
			ywtype = obj.value;
			//update 2012-8-3 yhy start
			//一个号线设备可以同时归属于多个业务类型，所以设备的业务类型需要用包含关联获取，不能用等于查询获取
			//var scond ="and routetype='"+ywtype+"'";
			var scond = "and instr(routetype , '" + ywtype + "' )>0 " ;
			//update 2012-8-3 yhy end
						 
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryDevice_Route','', 'route');
			urlstr += '&cond='+encodeURIComponent(scond);							
			$('#grid_device').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
			$('#grid_newroute').clearGridData();
			if(ywtype==""){ywtype='/';}
			var res = fetchMultiArrayValue('dbsql_route.RouteRemp_queryair_routedefine',6,'&routetype='+ywtype,'route');			
			if(res[0] == undefined || res[0][0] == undefined || res[0] == ""){
				$('#opflag').val(1);
				return false;
			}else{	
				$('#opflag').val(2);			
				for(var i=0;i<res.length;i++){
					var rowdata = {'routesort':res[i][0], 'devno':res[i][1],'devname': res[i][2]}; 
					$('#grid_newroute').addRowData(res[i][0], rowdata);
				}
			}			
		}	
		//初始化路由设备表格(air_device_master)
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
					addDeviceNode();
				},				
				caption:"路由设备列表"			
			});		
			setTimeout("fillGrid_device();", 260);	
		}
		//初始化路由表格(air_route_xxx)
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
				loadComplete: function() { 					

				}, 
				//2012-8-7 yhy 去掉双击事件，该双击时间无用							
				caption:"路由模板定义"			
			}).navGrid('#pager_newroute',{refresh: false, edit: false, add: false, del: false, search: false});
  jQuery("#grid_newroute").navGrid('#pager_newroute',{refresh: false, edit: false, add: false, del: false, search: false}).navButtonAdd('#pager_newroute',{ 
  caption:"上移", buttonimg:"style/images/public/asc.png", onClickButton: moveup, position:"last" }).navButtonAdd(
  '#pager_newroute',{ caption:"下移", buttonimg:"style/images/public/desc.png", onClickButton: movedown, position:"last" }).navButtonAdd(
  '#pager_newroute',{ caption:"删除", buttonimg:"style/images/public/tubiao_2.jpg", onClickButton: delRouteNode, position:"last" }).navButtonAdd(  
  '#pager_newroute',{ caption:"清空", buttonimg:"style/images/public/ltubiao_04.gif", onClickButton: cleargrid, position:"last" });		
		}	
		//初始化路由模板表格(air_routedefine)
		function initGrid_route1(){			
			jQuery('#grid_route1').jqGrid({				
				height: 202, 	
				width:300,
				datatype: "xml",
			   	colNames:['','','业务类型', '配线方式'],
			   	colModel:[		
			   		{name : 'routetype', index : 'routetype', hidden:true},			        
			        {name : 'linemode', index : 'linemode', hidden:true},			   	
			   		{name : 'routetype1', index : 'routetype1'},			        
			        {name : 'linemode1', index : 'linemode1'}			        			        		
			   	],
			   	imgpath: gridimgpath,			   	
			   	sortname: 'routetype',
			    viewrecords: true,
			    sortorder: "asc",
				multiselect: false,
				useDefault:true,
				loadComplete: function() { 								
					//根据字典值，显示字典说明
					showDict();
					//查询后，默认选中第一条						
					jQuery("#grid_route1").setSelection('1', true);
					jQuery("#grid_route1").focus();			
						
				}, 				
				onSelectRow: function(ids) {
				    //ids是返回的rowid,然后根据它再返回devid	    
					if(ids != null) {					    
					    var routetype=jQuery("#grid_route1").getCell(ids,'routetype');						    
					    var linemode=jQuery("#grid_route1").getCell(ids,'linemode');
						fillGrid_route2(routetype,linemode);			
					}
				},									
				caption:"路由模板列表"			
			});
			//setTimeout("fillGrid_routetemp('"+routetype+"','"+linemode+"');", 15);
		}			
		//初始化路由模板表格(air_routedefine)
		function initGrid_route2(routetype, linemode){			
			jQuery('#grid_route2').jqGrid({				
				height: 202, 	
				width:300,
				datatype: "xml",
			   	colNames:['', 'devno', '设备名称'],
			   	colModel:[		
			   		{name : 'routesort', index : 'routesort', width:30},        
			        {name : 'devno', index : 'devno', hidden:true},
			        {name : 'devname', index : 'devname',width:200}			        			        		
			   	],
			   	imgpath: gridimgpath,			   	
			   	sortname: 'routesort',
			    viewrecords: true,
			    sortorder: "asc",
				multiselect: false,
				useDefault:true,					
				caption:"路由模板"			
			});
			//setTimeout("fillGrid_routetemp('"+routetype+"','"+linemode+"');", 15);
		}		
		//路由表格，上移
		function moveup(){
			var table = document.getElementById('grid_newroute');
			var rowid=$('#grid_newroute').getGridParam("selrow");
			var selnum = $('#grid_newroute').getRowData(rowid).routesort;
			var opid;
			for (var i = 1; i < table.rows.length; i++)
            {                	                
                var num = table.rows(i).cells(0).innerText;	                
                if (parseInt(num) == parseInt(selnum)-1){
                    //两行互换，除序号
                	changerow(table.rows(i+1), table.rows(i));
                	//将原操作行继续选中，否则选中的是移上来的行                	
                	opid = getid(num);					
                	$('#grid_newroute').setSelection(opid, true);
                	break;                	 	                	
                }	
            }
		}
		//路由表格，下移
		function movedown(){
			var table = document.getElementById('grid_newroute');
			var rowid=$('#grid_newroute').getGridParam("selrow");
			var selnum = $('#grid_newroute').getRowData(rowid).routesort;
			var opid;
			for (var i = 1; i < table.rows.length; i++)
            {                	                
                var num = table.rows(i).cells(0).innerText;	                
                if (parseInt(num) == parseInt(selnum)+1){
                    //两行互换，除序号
                	changerow(table.rows(i-1), table.rows(i));
                	//将原操作行继续选中，否则选中的是移上来的行                	
                	opid = getid(num);					
                	$('#grid_newroute').setSelection(opid, true);
                	break;                	 	                	
                }	
            }
		}
		//jqgrid的两行，内容互换(除序号)
		function changerow(row1, row2){
			var s;
			for (var i=1; i<row1.cells.length; i++)
			{
				s = row1.cells(i).innerText;
				row1.cells(i).innerText = row2.cells(i).innerText;
				row2.cells(i).innerText = s;
			}
		}
		//根据序号返回该行的rowid 
		function getid(num){
			var s = $('#grid_newroute').getDataIDs();
			var selnum; 
			for (var i=0; i< s.length; i++)
			{
				selnum = $('#grid_newroute').getRowData(s[i]).routesort;				
				if (selnum == num){
					return s[i];
					break;
				}
			}
		}
		//清空路由表格
		function cleargrid(){
			$('#grid_newroute').clearGridData();
		}		
		//从路由表格中删除路由设备
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
		//将路由设备列表中的选中设备添加到路由表格中
		function addDeviceNode(){
			var rowid=$('#grid_device').getGridParam("selrow");			
			var devno=$('#grid_device').getCell(rowid,'devno');			
			if (devno=='' || devno==null) 
			  return;					
			var devname = $('#grid_device').getCell(rowid,'devname');			
			addRouteNode(devno, devname);
		}	
		//添加路由设备到路由表格中
		function addRouteNode(devno, devname){
			//如果设备已添加，则不再添加
			if (devIsExists(devno)){
				//提示已添加
				alert("该设备已添加");
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
			var ids = $('#grid_route1').getDataIDs();
			var v_routetype = "";
			var v_linemode = "";
			for (var i=0; i<ids.length; i++)
			{
				v_routetype = $('#grid_route1').getRowData(ids[i]).routetype;				
				v_linemode = $('#grid_route1').getRowData(ids[i]).linemode;
				if (v_routetype==routetype && v_linemode==linemode){
					return true;
					break;
				}
			}			
            return false;
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
			if (flag == 1){					
				if (NullCheck("#routetype", "业务类型")) {return};
				if (NullCheck("#linemode", "配线方式")) {return};
				var v_routetype = $('#routetype').val();
				var v_linemode = $('#linemode').val();
				//如果该业务类型和配线方式已存在，则提示退出
				if (TempIsExists(v_routetype, v_linemode)){
					alert('已存在“'+v_routetype+'”和“'+v_linemode+'”的路由模板，不能再新增！');
					return;
				}
				var param = '&routetype='+tsd.encodeURIComponent(v_routetype)+'&linemode='+tsd.encodeURIComponent(v_linemode);											
				optype = "inserttemp";
				param += "&optype="+optype;
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
				param1 = param+"&portno="+v_portnos+"&routeno="+v_routenos;
				var res = fetchMultiPValue("air_route_manage",6,param1);
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
			else{		
				var param = '&routetype='+tsd.encodeURIComponent($("#routetype").val())+'&linemode='+tsd.encodeURIComponent('');											
				optype = "updatetemp";
				param = param+"&optype="+optype;
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
				param1 = param+"&portno="+v_portnos+"&routeno="+v_routenos;			
				var res = fetchMultiPValue("air_route_manage",6,param1);
				if(res[0][0]=="SUCCEED"){        	             				
					alert("修改路由模板成功！");
					//同步主页面中被修改的表格
					showroute('grid_newroute', 'grid_route2');	
					//3.设置按钮为初始状态
					setInitState();	
					getUedit(3);																									
	        	}
	        	else{
	        		alert("修改路由模板失败！\r\n\n错误消息："+res[0][1]);
	        	}							
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
		//新增路由模板
		function addTemp(){
			$("#input-Unit select").val("");
			cleargrid();
			afterAdd();
			$('#opflag').val(1);
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
		//返回路由模板列表数据
		function fillGrid_route1(){			
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryTemp','', 'route');										
			$('#grid_route1').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");						
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
		//删除路由模板
		function delTemp(){
			var rowid=$('#grid_route1').getGridParam("selrow");
			if (rowid==null || rowid==""){
				alert('请先选择“路由模板”!');
				$('#grid_route1').focus();
				return;				
			}		
			if (!confirm("您确定要进行删除路由模板操作吗？")){
				return;
			}						
			
			var rowid=$('#grid_route1').getGridParam("selrow");
			var v_routetype = $('#grid_route1').getCell(rowid,'routetype');
			var v_linemode = $('#grid_route1').getCell(rowid,'linemode');				
			var param = '&routetype='+tsd.encodeURIComponent(v_routetype)+'&linemode='+tsd.encodeURIComponent(v_linemode);											
			optype = "deletetemp";
			param = param+"&optype="+optype;
						
			var res = fetchMultiPValue("air_route_manage",6,param);
        	if(res[0][0]=="SUCCEED"){        	             				
				alert("删除路由模板成功！");
				//若删除成功，则刷新页面相应表格				
				delRefresh(rowid);
				//fillGrid_route1();							
        	}
        	else{
        		alert("删除路由模板失败！\r\n\n错误消息："+res[0][1]);
        	}
		}
		//删除路由模板后的刷新
		function delRefresh(selid){
			var ids = $('#grid_route1').getDataIDs();
			//如果仅有一条记录，则清空表格(路由类型表格和路由模板记录表格)
			if (ids.length==1){
				$('#grid_route1').clearGridData();
				$('#grid_route2').clearGridData();
			}
			else if(ids.length>1) {
				fillGrid_route1();
			}
		}
		//初始化时，设置按钮的enabled状态
		function setInitState(){
			$('#btnadd').attr("disabled",false);
			$('#btnupdate').attr("disabled",false); 
			//$('#btnsave').attr("disabled",true);
			$('#spanadd').css('color','black');
			$('#spanedit').css('color','black');			
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
		

		function getUedit(key){
			if($("#routetype").val()==""){
				alert("请先选择业务类型！");
				$("#routetype").select().focus();
				return;
			}
			if(key=="1"){
				$("#grid_newroute,#cancel,#grid_device,#add,#btnsave").removeAttr("disabled","disabled");
				$("#uedit,#routetype").attr("disabled","disabled");
				$("#pager_newroute").show();	
			}else if(key=="3"){
				$("#grid_newroute,#cancel,#grid_device,#add,#btnsave").attr("disabled","disabled");
				$("#uedit,#routetype").removeAttr("disabled");
				$("#pager_newroute").hide();
				//getDict();	
				setTimeout('getgridvalue()','200');
			}else if(key=="2"){
				save();
			}
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
		<!--<DIV class="ui-layout-south">		
	<div style="margin-top:-5px; margin-bottom:-7px">
			<button class="tsdbutton" id="btnadd" onclick="addTemp();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" > 
				新增模板 
			</button>	
			<button class="tsdbutton" id="btnupdate" onclick="editTemp();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" >
				修改模板
			</button>
			<button class="tsdbutton" id="btnsave" onclick="save();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" > 
				保存模板
			</button>						
			<button class="tsdbutton" id="btndel" onclick="delTemp();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;" > 
				删除模板 
			</button>				
		</div>
							
	</DIV> 	-->
		<DIV class="ui-layout-center">
			<div id="input-Unit" style="margin-top: -10px;">
            	
                	<fieldset style="width:730px; float:left; padding-top:4px;">
				<!--<div class="title_rad">-->
					<legend><span style="font-size:14px;  ">路由模板设置</span></legend>
				<!--</div>-->
                	
				<div style="width: 100%; height: 38px; text-align: left;">
					<div style="height: 40px; float: left; line-height: 38px;">
						业务类型:
					</div>
					<div style="height: 35px; float: left; line-height: 38px; ">
						<select id="routetype" style="width: 110px;">
							<option value='' selected='true'>
								--请选择--
							</option>
							<option value='phone'>
								电话
							</option>
							<option value='broadband'>
								宽带
							</option>
							<option value='device'>
								设备
							</option>
							<option value='tv'>
								有线电视
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
					<%-- 		配线方式<select id="linemode" style="width: 100px;" >
					<option value='' selected='true'>--请选择--</option>
					<option value='MDF'>配线架</option>
				    <option value='ODF'>光纤到户</option>
				</select>
				--%>
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
		<%-- <DIV class="ui-layout-center">
		<div id="input-Unit" style="margin-top:-10px">
			<div class="title_rad">				
				路由模板浏览
			</div>
			<table border="1" cellpadding="0" bordercolor="#9AC0CD" style="height:100%; width:100%;">
				<tr>
					<td><table id="grid_route1" class="scroll" cellpadding="0" cellspacing="0" ></table></td>
				</tr>
				<tr>			
					<td><table id="grid_route2" class="scroll" cellpadding="0" cellspacing="0" ></table></td>
				</tr>	
			</table>
		</div>	
	</DIV>
	--%>
		<input type="hidden" id="opflag" />
	</body>
	</thml>