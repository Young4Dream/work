<%----------------------------------------
	name: DeviceManage.jsp
	author: wangli
	version: 1.0 
	description: 号线设备管理 
	Date: 2011-10-31
	modify：2012-6-18 yhy
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
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";		
%>

<%@page import="java.io.File"%>
<%	
	//获取设备图标
	String devicepath = basePath + "style/icon/device/";
	String rootPath = request.getRealPath("style/images/public/");//大图标所在文件夹
	
	File thepath = new File(rootPath);
	int x = 0;
	if(thepath.listFiles().length>0){
		for(int i = 0 ; i < thepath.listFiles().length;i++){
			if(thepath.listFiles()[i].toString().endsWith(".jpg")){
				x++;
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery.layout.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script> <!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>		
    <script type="text/javascript" src="script/public/tsdpower.js"></script><!-- 页面权限控制 -->
    <script type="text/javascript" src="script/public/main.js"></script>
    <script type="text/javascript" src="script/public/mainStyle.js"></script>
    <script type="text/javascript" src="script/public/transfer.js"></script>	    
    <script type="text/javascript" src="script/public/revenue.js" ></script>
    
    <script type="text/javascript" src="script/route/DeviceManage.js"></script>
    
    <script type="text/javascript" src="plug-in/jquery/jquery.cookie-min.js"></script>    
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.core-3.0.js"></script>
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.excheck-3.0.min.js"></script>
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.exedit-3.0.min.js"></script>
    <script type="text/javascript" src="plug-in/jquery/contextmenu/jquery.contextmenu.r2.js"></script>
    <!-- 把下拉框变成可复合多选 -->
	<script src="plug-in/MultiSelect/jquery.bgiframe.min.js" type="text/javascript"></script>
	<script src="plug-in/MultiSelect/jquery.multiSelect.js" type="text/javascript"></script>			
	<link href="plug-in/MultiSelect/jquery.multiSelect.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" href="style/zTreeStyle/zTreeStyle.css" type="text/css" />    
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />    	
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
	
	<script type="text/javascript">
		//树初始化
		var zTreeObj;
		var setting = {					
			callback: {			
				onClick: nodeClick,		
				onRightClick: nodeClick,		
				onDblClick: nodeDblClick											
			}
		};	
		var gridimgpath = 'plug-in/jquery/jqgrid/themes/basic/images/';
		//定义一个页面布局变量
		var mylayout;
		//取得表内的字段值来判断用何种方式操作设备地址(Y：下拉列表;N:手动输入)
		var addrChoice=fetchSingleValue('dbsql_route.GetDeviceAddr',6,'','route');	
		//页面初始化
		$(document).ready(function () {
			//窗口放大缩小，窗口内容自适应
			$(window).bind("resize", function () 
			{
				$('#maxpanels').css('height',document.documentElement.clientHeight);
				$('#maxpanels').css('width',document.documentElement.clientWidth);
			});
			
			//利用布局控件设置布局			
			mylayout = $('body').layout({ 
				applyDefaultStyles: true,
				east__size:416,
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
			initTree();
			initMenu();	
			//初始化设备子设备表格
			initGrid_Detail();	
			//填充下拉框内容						
			getDict();	
			//设置明细jqgrid的高度		
			setGrid_H();
			//页面初始化是，默认选中设备树上第一个设备节点
			setTimeout("initGridData();",1);		
			var treeHeight = document.documentElement.clientHeight - 100;
			$('.divTreeDM').css('height',treeHeight);
				
		});


		//初始化树形控件的右键菜单
		function initMenu(){
  		  $('#tree').contextMenu('itemMenu', 
		  {
		      bindings : 
		      {
		          'add' : function (t) 
		          {
				    editParent(1);
		          },
		          'update' : function (t) 
		          {
					editParent(2, 'tree');
		          },
		          'del' : function (t) 
		          {
					delObj();
		          }
		      }
		  });		 
		}
		
		//初始化树形控件
		function initTree(){			
			var devNodes = [];
			var devNode;
			var res = fetchMultiArrayValue('dbsql_route.QueryDevice_Master',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					devNode = {"id":res[i][0],"name":res[i][1]};
					devNodes.push(devNode);
				}
			};
			var zTreeNodes = [			
				{"name":"号线设备",open:true,childs: devNodes}
			];			
			zTreeObj = $.fn.zTree.init($("#tree"), setting, zTreeNodes);																	
		}
		
		//用于表示菜单树上的节点是否已经被点击过，避免双击时触发单击事件
		var masterTag_glob ;
		//树节点单击事件
		function nodeClick(event, treeId, treeNode, clickFlag) {	
			//点击树上节点时，设置选择被单击节点
			zTreeObj.selectNode(treeNode, false);
			var devid = treeNode.id;			
			var tag = 1;
			var devno ='';//div中的id
			//var grid = "#devMaster1"; 
				
			if (treeNode.level==0) 
			{	
				return;
			}
			else if (treeNode.level==1){
				tag = 1;
				devno = $("#devno_MA").val();				
			}
			else if (treeNode.level > 1){
				tag = 2;
				devno = $("#devno_MB").val();	
			}
				
			//用于表示菜单树上的节点是否已经被点击过，避免双击时触发单击事件
			//树节点的id和主表格中的id一样，表示已经单击过
			//由于该出有两个表格，表格之前的切换，会导致树节点的id和主表格中的id一样判断混淆，
			//所以引入了masterTag_glob参数用于标识上次点击的表格
			if (masterTag_glob ==tag && devid == devno){  
					return;
			}
			masterTag_glob = tag;
			//显示选中节点的信息
			queryDevice_Master(devid, tag);
			
			/*
			else if (treeNode.level==1){
				tag = 1;
				grid = "#devMaster1";
				$("#div_devMaster1").show();
				$("#div_devMaster2").hide();
				$("#devMaster1").clearGridData();				
			}
			else if (treeNode.level > 1){
				tag = 2;
				grid = "#devMaster2";
				$("#div_devMaster1").hide();				
				$("#div_devMaster2").show();
				$("#devMaster2").clearGridData();				
			}
			
			//由于在jQuery事件绑定中，dbclick可以触发两次click事件，所以我在这里特别写了段特殊的代码，以避免下面代码的执行				
			var rowid = jQuery(grid).getGridParam("selrow");			
			if (rowid != null) 
			{
				var devno=$(grid).getCell(rowid,'devno');
				if (devid == devno){  //树节点的id和主表格中的id一样，表示已经单击过
					return;
				}
			}			
			//特殊处理end
			//显示选中节点的信息
			queryDevice_Master(devid, tag, grid);
			*/					
		}
		//双击树节点，添加其子节点
		function nodeDblClick(event, treeId, treeNode){
			//即便选中节点，但不在节点上双节，那么treeNode参数也是null.故而有次判断					
			if (treeNode==null){
				return;
			}	
			var devid = treeNode.id;			
			if (treeNode.level==0) 
			{	
				return;
			}
			else{
				//如果节点已经展开过，就不再添加其子节点
				if (treeNode.isParent){					
					return;
				}
				//如果节点的下一级是端口级，则不再添加							
				var urlstr = '&devid='+tsd.encodeURIComponent(devid);
				
				var levelcount = fetchSingleValue('dbsql_route.GetLevelCount',6,urlstr,'route');					
				if (treeNode.level+1==levelcount){
					return;
				}
				var urlstr = '&devid='+tsd.encodeURIComponent(devid)+'.';							
				var devNodes = [];
				var devNode;
				var res = fetchMultiArrayValue('dbsql_route.QueryDevice_DetailId',6,urlstr,'route');
				if (res != undefined && res!="" && res.length>0){
					for(var i=0;i<res.length;i++){
						devNode = {"id":res[i][0],"name":res[i][1]};
						devNodes.push(devNode);
					}					
					zTreeObj.addNodes(treeNode, devNodes);
				};											
			}
		}	
	
			
		//初始化设备子设备表格
		function initGrid_Detail(){
			jQuery("#devDetail").jqGrid({  	
				datatype: "xml",
			   	colNames:['id','设备名称','状态', '绑定电话', '设备地址', '模块局','所属区域','业务类型','备注', '图标','上级端口', 'IP地址','VLAN'],
			   	colModel:[
			   		{name:'devno',index:'devno', hidden:true},
			   		{name:'devname',index:'devname', width:140},
			   		{name:'state',index:'state', align:"center", width:90},
			   		{name:'dh',index:'dh', align:"center", width:90},
			   		{name:'addr',index:'addr', width:160},					
			   		{name:'mokuaiju',index:'mokuaiju', width:130},
			   		{name:'areaname',index:'areaname', width:90},
			   		{name:'portype',index:'portype', width:90},
			   		{name:'memo',index:'memo', align:"center", width:180},
			   		{name:'devicon',index:'devicon', width:120, hidden:true},
			   		{name:'pdevno',index:'pdevno', align:"center", hidden:true}	,
			   		{name:'ip',index:'ip', align:"center", width:100},
			   		{name:'vlan',index:'vlan', align:"center", width:90,hidden:true}			   		   				
			   	],
			   	rowNum:15,
			   	rowList:[15,30,128],
			   	imgpath: gridimgpath,
			   	pager: jQuery('#pager_devDetail'),
			   	sortname: 'devno',
			    viewrecords: true,
			    sortorder: "asc",
			    pgbuttons: true,
				multiselect: true,
				useDefault:true,
				loadComplete: function() { 					
					/**********
					*根据设备树节点的端子编码判断 当前设备所在层数+1 是否等于设备层次数目，
					*	相等：该层为设备端口层
					*	不相等：该层为设备层
					*返回值：相等：true  不相等：false
					*注：设备层显示字段：设备名称 设备地址 模块局 图标 备注
					*   端子层显示字段：设备名称 状态 绑定电话 模块局 图标 备注
					************/
					var devid =$("#devid_level").val();
					var levelFlag =getThelevel(devid);					
					if(levelFlag){						
						jQuery("#devDetail").showCol("state");
						jQuery("#devDetail").showCol("dh");
						jQuery("#devDetail").hideCol("addr");
						jQuery("#devDetail").hideCol("ip");
						jQuery("#devDetail").hideCol("vlan");
						jQuery("#devDetail").hideCol("areaname");
						jQuery("#devDetail").showCol("portype");
						$("#ywarea_D").hide();
						$("#portype_D").show();
						$("#ywarea_b_D").hide();
						$("#portype_b_D").show();
						//只有端口层才有批量删除功能，其不需要验证节点下面是否还挂有子设备
						$("#batchDel").attr("style","display:inline;");
					}else{
						//只有端口层才有批量删除功能，其不需要验证节点下面是否还挂有子设备
						$("#batchDel").attr("style","display:none;");
						jQuery("#devDetail").hideCol("state");
						jQuery("#devDetail").hideCol("dh");
						jQuery("#devDetail").hideCol("portype");
						$("#ywarea_D").show();
						$("#portype_D").hide();
						$("#ywarea_b_D").show();
						$("#portype_b_D").hide();
						//jQuery("#devDetail").showCol("addr");
						/***
						* 只有第二级设备有设备地址属性
						* 由于devid值是目前设备的父设备的编号，所以判断当期设备是否为二级设备
						* end = devid.split('.').length ;
						* end == 1;//jqgrid上显示的为二级设备
						*/
						var end = devid.split('.').length ;
						if(end == 1){								
							jQuery("#devDetail").showCol("addr");
							jQuery("#devDetail").showCol("ip");
							jQuery("#devDetail").showCol("vlan");
							jQuery("#devDetail").showCol("areaname");
						}else{
							jQuery("#devDetail").hideCol("addr");
							jQuery("#devDetail").hideCol("ip");
							jQuery("#devDetail").hideCol("vlan");
							jQuery("#devDetail").hideCol("areaname");
						}
					}
				}, 
				onSelectRow: function(ids) {
					//隐藏树上的邮件菜单	
					//$('#tree').contextMenu('itemMenu', hide());	
					 $('#tree').hideMenu();			
					//ids是返回的rowid,然后根据它再返回meetid     
		            if (ids != null) 
		            {
		            	var resid = $("#devDetail").getCell(ids, "devno");
		                $('#devid_devno').val(resid);
					}			    
				}, 
				caption:"子设备信息"			
			}).navGrid('#pager_devDetail',{refresh: true, edit: false, add: false, del: false, search: false});
		}
		
		//根据devid查询air_device_master或air_device_detail表(tag=1前者，tag=2后者)，
		//grid参数表示接收返回记录的表格的id
		function queryDevice_Master(devid, tag, grid){
			var devno ; //设备端口编号
			var sql;
			if (tag==1)
			{
				sql = 'dbsql_route.QueryDevice_Master1';
			}
			else{
				sql = 'dbsql_route.QueryDevice_Master2';
			}
			var params = '&devid='+tsd.encodeURIComponent(devid);	
			var res = fetchMultiArrayValue(sql,6,params,'route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					if (tag==1)
					{
						var devno_MA = res[i][0];
						var devname_MA = res[i][1];
						var levelcount_MA = res[i][2];
						var routetype_MA = res[i][3];
						var routetypeVal_MA = res[i][4];
						var linemode_MA = res[i][5];
						var memo_MA = res[i][6];
						var devicon_MA = res[i][7];
						
						devno = devno_MA;
						
						$("#devno_MA").val(devno_MA);
						$("#devname_MA").val(devname_MA);
						$("#levelcount_MA").val(levelcount_MA);
						$("#routetype_MA").val(routetype_MA);
						$("#routetypeVal_MA").val(routetypeVal_MA);
						$("#linemode_MA").val(linemode_MA);
						$("#memo_MA").val(memo_MA);
						$("#devicon_MA").val(devicon_MA);
						$("#DevMasterDiv1").show();
						$("#DevMasterDiv2").hide();
					}
					else{
						var devno_MB = res[i][0];
						var devname_MB = res[i][1];
						var state_MB = res[i][2];
						var dh_MB = res[i][3];
						var addr_MB = res[i][4];
						var mokuaiju_MB = res[i][5];
						var memo_MB = res[i][6];
						var devicon_MB = res[i][7];
						var pdevno_MB = res[i][8];
						//2012-9-11 yhy start 
						//添加两个字段
						var ip_MB =  res[i][9];
						var vlan_MB =  res[i][10];
						var ywarea_MB = res[i][11];
						//2012-9-11 yhy end
						devno = devno_MB;
						
						$("#devno_MB").val(devno_MB);
						$("#devname_MB").val(devname_MB);
						$("#state_MB").val(state_MB);
						$("#dh_MB").val(dh_MB);
						$("#addr_MB").val(addr_MB);
						$("#mokuaiju_MB").val(mokuaiju_MB);
						$("#ywarea_MB").val(ywarea_MB);
						$("#memo_MB").val(memo_MB);
						$("#devicon_MB").val(devicon_MB);
						$("#pdevno_MB").val(pdevno_MB);
						//2012-9-11 yhy start 
						//添加两个字段
						$("#ip_MB").val(ip_MB);
						$("#vlan_MB").val(vlan_MB);
						//2012-9-11 yhy end
						
						$("#DevMasterDiv1").hide();
						$("#DevMasterDiv2").show();
						
						var end = devid.split('.').length ;
						if(end == 2){
							$("#addr_MBD").show();
						}else{
							$("#addr_MBD").hide();
						}
					}					
				}
			}
			
			//显示子设备信息
			queryObj(devno);	
			/**
			var sql;
			if (tag==1)
			{
				sql = 'dbsql_route.QueryDevice_Master1';
			}
			else{
				sql = 'dbsql_route.QueryDevice_Master2';
			}
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml',sql,'', 'route');
			urlstr += '&devid='+tsd.encodeURIComponent(devid);	
			//alert(urlstr+" "+grid);		
			$(grid).setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
			*/
		}
		//根据devid查询air_device_detail表	
		function queryObj(devid){
			$("#devid_level").val(devid);	//存放上级节点的编码方便获取该节点所在设备子树的层次数目
			 
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryDevice_Detail','dbsql_route.GetDetailCount', 'route');
			urlstr += '&devid='+tsd.encodeURIComponent(devid)+'.';
			jQuery("#devDetail").setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");			
		}
		
		
		/********************************
		*根据设备编码可以判断当前设备属于该子树的第几层，
		*根据设备树节点的端子编码判断 当前设备所在层数+1 是否等于设备层次数目，
		*	相等：该层为设备端口层
		*	不相等：该层为设备层
		*返回值：相等：true  不相等：false
		********************************/
		function getThelevel(devid){
			var flag ;
			//根据设备树节点的id查询该节点所在设备子树允许的层次数目
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			var maxLevel = fetchSingleValue('dbsql_route.GetLevelCount',6,urlstr,'route');
			//根据设备树节点的端子编码判断 当前设备所在层数
			var theLevel = devid.split(".").length+1;	
			
			if(theLevel == maxLevel){
				flag = true;
			}else{
				flag = false;
			}
			return flag;
			
		}
		
		/********************************
		*根据设备编码可以判断当前设备属于该子树的第几层，
		*根据设备树节点的端子编码判断 当前设备所在层数+1 是否等于设备层次数目，
		*	相等：该层为设备端口层
		*	不相等：该层为设备层
		*返回值：相等：true  不相等：false
		********************************/
		function getThelevelDetail(devid){
			var flag ;
			//根据设备树节点的id查询该节点所在设备子树允许的层次数目
			//根据设备树节点的端子编码判断 当前设备所在层数
			var parentLevel = devid.split(".").length;	
			var nextLevel = $('#devid_devno').val().split(".").length;
			
			if(nextLevel==3){
				flag = true;
			}else{
				flag = false;
			}
			return flag;
			
		}
		
		/**********
		*根据设备编码获取当前设备的模块局
		*返回值：模块局
		************/
		function getTheMKJ(devid){
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			var deviceMKJ = fetchSingleValue('dbsql_route.GetMKJByDevid',6,urlstr,'route');			
			return deviceMKJ;
		}
		/************************************
		右键菜单 新增/编辑操作
		flag=1:新增;flag=2:编辑; 
		ctl='tree'树控件调用编辑功能;ctl='grid'表格控件调用编辑功能;
		************************************/		
		function editParent(flag, ctl){
			//取出树中选中的节点及其level
			var nodes=zTreeObj.getSelectedNodes();
			if (nodes.length<=0) 
			{
				if (flag==1){
					alert("请先选中设备，再对其进行子设备的新增！");
				}
				else{
					alert("请先选中设备，再对其进行编辑操作！");
				}
				return;
			}
			var level=nodes[0].level;
			//若选中根节点，则只能新增路由设备(air_Device_Master)
			if (flag==1){
				if (level == 0)
				{
					editMaster(1);
				}
				else if (level > 0){
					editDetail(1, ctl,'child');
				}
			}
			else{
				if (level == 0)
				{
					alert("根节点不能编辑！");
					return;
				}
				else if (level == 1){
					editMaster(2);
				}				
				else if (level > 1){
					editDetail(2, ctl,'parent');
				}				
			}
		}
		//新增/编辑air_Device_Master表.flag=1:新增;flag=2:编辑;
		function editMaster(flag){
			if (flag == 1)
			{
				$('#Master_Title').text('新增设备');
				reset_M();
			}
			else{
				$('#Master_Title').text('编辑设备');
				//显示设备的信息，供修改
				showInfo_M('#devMaster1');  //todo 考虑devMaster2
			}
			$("#masterFlag").val(flag); 
			autoBlockFormAndSetWH('divMaster',100,'100px','close',"#ffffff",false,'', '');
		}
		
		//新增/编辑air_Device_Detail表.flag=1:新增;flag=2:编辑;
		//右键菜单 type:child :右键菜单新增子节点、jqgrid上的新增、删除按钮; parent：右键菜单编辑本身;
		function editDetail(flag, ctl,type){
			if (flag == 1)
			{
				var nodes=zTreeObj.getSelectedNodes();
	        	if (nodes.length>0){
	        		if (nodes[0].level==0){
	        			alert('请选中设备节点后，再点击此按钮来新增其子设备！');
	        			return;
	        		}	        		        			        		
	        	}
				$('#Detail_Title').text('新增子设备');
				reset_D();	
			}else{
				if (ctl=='grid'){					
					var rowid = jQuery("#devDetail").getGridParam("selrow");					
					if (rowid == null){
						 alert('请选中设备记录后，再点击此按钮来进行编辑！');
						 return;
					}
					//每次只能修改一条设备，选择的设备为多条的时候弹出提示
					var ids=jQuery("#devDetail").getGridParam("selarrrow");  
					if(ids.length>1){
						alert('每次只能修改一条设备，请确定！');
						return;
					}
					
					//显示设备的信息，供修改
					showInfo_D('#devDetail');
					$("#ctlFlag").val("grid"); 
				}
				else{
					//显示设备的信息，供修改
					showInfo_D('#devMaster2');
					$("#ctlFlag").val("tree");
				}
				$('#Detail_Title').text('编辑子设备');
			}
			$("#detailFlag").val(flag); 
			
			/************
			*根据设备树节点的端子编码判断 当前设备所在层数+1 是否等于设备层次数目，
			*	相等：该层为设备端口层
			*	不相等：该层为设备层
			*返回值：相等：true  不相等：false
			*注：设备层显示字段：设备名称  设备地址 模块局 图标 备注
			*   端子层显示字段：设备名称 状态 绑定电话 模块局 图标 备注
			*
			************/
			var devid =$("#devid_level").val();	
			var levelFlag ;
			
			if(type == 'parent'){
				var end = devid.split('.').length ;
				if(end != 0){
					devid = devid.substr(0,end );		
				}				
			}
			
			levelFlag =getThelevel(devid);			
			if(levelFlag){
				$("#nodeExplain").show();//端口名称命名提示
				$("#state_D").show();
				$("#dh_D").show();
				$("#addr_D").hide();
				$("#ip_D").hide();
				$("#vlan_D").hide();	
				$("#ywarea_D").hide();
				$("#port_D").show();			
			}else{
				$("#nodeExplain").hide();//端口名称命名提示
				$("#state_D").hide();
				$("#dh_D").hide();
				//$("#addr_D").show();
				$("#ywarea_D").show();
				$("#portype_D").hide();
				/***
				* 只有第二级设备有设备地址属性
				* devid2值是当前树上选择节点
				* 1右键菜单编辑功能，devid2值是设备本身的编码
				* 	则	end = devid.split('.').length ;
				* 		end == 2;//为二级设备
				* 2右键菜单新增子设备功能，devid2值是其父设备的编码
				*	则	end = devid.split('.').length ;
				* 		end == 1;//为二级设备
				* 3右侧子设备信息中的新增、修改，devid2值是其父设备的编码
				* 	则  end = devid.split('.').length ;
				*	    end == 1;//为二级设备
				*/
				//
				//如果设备不为第二级设备，则隐藏设备地址栏
				if(type == 'parent'){
					var devid2 =$("#devid_level").val();
					var end = devid2.split('.').length ;
					if(end == 2){
						$("#addr_D").show();
						$("#ip_D").show();
						$("#vlan_D").show();
					}else{
						$("#addr_D").hide();
						$("#ip_D").hide();
						$("#vlan_D").hide();
					}
				}else{
					var devid2 =$("#devid_level").val();
					var end = devid2.split('.').length ;
					if(end == 1){
						$("#addr_D").show();
						$("#ip_D").show();
						$("#vlan_D").show();
					}else{
						$("#addr_D").hide();
						$("#ip_D").hide();
						$("#vlan_D").hide();
					}
				}				
					
			}				
			
			autoBlockFormAndSetWH('divDetail',30,'100px','close',"#ffffff",false,'', '');			
		}
			
		//设备树上 右键删除操作，删除air_Device_Master或air_Device_Detail表单条记录
		function delObj(){
			//取出树中选中的节点及其level
			var nodes=zTreeObj.getSelectedNodes();					
			if (nodes.length<=0) 
			{
				alert("请先选中节点设备，再对其进行删除操作！");
				return;
			}
			var level=nodes[0].level;	
			var optag;						
			if (level == 0)
			{
				alert("根节点不能删除！");
				return;
			}
			else if (level == 1){
				optag = 1;
			}				
			else if (level > 1){
				optag = 2;
			}	
			if (!confirm("您确定要进行删除操作吗？")){
				return;
			}			
			var v_devno = nodes[0].id;
			var urlstr = '&devid='+tsd.encodeURIComponent(v_devno)+'.';
			var cnt = fetchSingleValue('dbsql_route.DetailExist',6,urlstr,'route');
			if (cnt > 0)
			{
				alert("包含有子设备的设备不能被删除！");
				return;
			}

			var param="&optype=delete"+"&optag="+optag+"&devno="+v_devno;			
			var res = fetchMultiPValue("air_device_manage",6,param);        	      
        	if(res[0][0]=="SUCCEED"){        	             				
				//alert("删除成功！");	
				deleteRefresh(nodes[0]);			
        	}
        	else{
        		alert("删除失败！\r\n\n错误消息："+res[0][1]);
        	} 	
		}
		
		//删除air_Device_Detail表，删除grid本页选中的记录
		function delObj_d(){
			var rowid=jQuery("#devDetail").getGridParam("selarrrow");			
			if (rowid.length == 0) 
			{
				alert("请先选中记录，再对其进行删除操作！");
				return;
			}	
			if (!confirm("您确定要进行删除操作吗？\r\n\n注意：包含有子设备的设备不能被删除！")){
				return;
			}
			var nodes=zTreeObj.getSelectedNodes();
			for(var i=0;i<rowid.length;i++){										
				var v_devno = jQuery("#devDetail").getCell(rowid[i],'devno');
				var urlstr = '&devid='+tsd.encodeURIComponent(v_devno)+'.';
				var cnt = fetchSingleValue('dbsql_route.DetailExist',6,urlstr,'route');
				if (cnt > 0)
				{
					continue;
				}			
				var param="&optype=delete"+"&optag=2&devno="+v_devno;
				
				var res = fetchMultiPValue("air_device_manage",6,param);        	      
	        	if(res[0][0]=="SUCCEED"){       										
					if (nodes.length>0) 
					{
						//如果父节点是open状态，则将删除的明细记录对应的节点从树中删除
		        		if (nodes[0].open){
		        			//返回删除记录对应的树节点
		        			var node = zTreeObj.getNodeByParam("id", v_devno, nodes[0]);	        			
			        		//删除树节点
							zTreeObj.removeNode(node);		        		
		        		}	
					}								
	        	}
	        	else{
	        		alert("删除失败！\r\n\n错误消息："+res[0][1]);
	        		return;
	        	}
        	}
			//根据父设备id刷新明细表格
			if (nodes.length>0) 
			{				
				queryObj(nodes[0].id);
			}	        	 
		}		
		//删除设备树节点后的刷新操作 1.删除树节点 2.刷新表格(tag=1表示删除主记录； =2表示删除明细记录)
		function deleteRefresh(node){
			//获取被删除节点的前一个节点
			var prenode = node.getPreNode();
			//如果前一个节点没空，则返回父节点
			if (prenode==null){
				prenode = node.getParentNode();
			}								
			//删除树节点
			zTreeObj.removeNode(node);			
			//节点选中被删除节点的前一个节点(调用该节点的单击事件，以刷新表格)
			zTreeObj.selectNode(prenode, false);			
			nodeClick(null,null,prenode);			
		}
		//设置控件只读属性和底色
		function setReadonly(ctl,value){
			ctl.attr('readonly',value);
			if (value){
				ctl.attr('style','width:300px; background:silver;ime-mode: disabled');	
			}
			else{
				ctl.attr('style','width:300px;ime-mode: disabled');
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
		//设备编号是否重复的检测	 检测air_device_master或air_device_detail表(tag=1前者，tag=2后者)	
		function idRepeat(CtlName, tag){
			var sql;
			if (tag==1)
			{
				sql = 'dbsql_route.DevNoExist_M';
			}
			else{
				sql = 'dbsql_route.DevNoExist_D';
			}		
			var value = $(CtlName).val();
			var res = fetchMultiArrayValue(sql,6,"&devid="+tsd.encodeURIComponent(value),'route');						
			if (res > 0){
				alert(value+"已存在，请重新填写！");
				$(CtlName).select();
				$(CtlName).focus();
				return true;
			}
			return false;
		}
		//设置明细jqgrid的高度
		function setGrid_H(){			   
		   //70(主页top)+26((系统模块栏))+22(主jqgrid的caption栏，估计)+40(主表格body)+30(主页底部)+24(明细表格工具栏)+其它(约10)(注意，底部有一些空白是padding(5))  
		   var detail_grid_H=document.body.clientHeight-235;
		   var detail_grid_W=document.body.clientWidth-180;
		   jQuery("#devDetail").setGridHeight(detail_grid_H);
		   jQuery("#devDetail").setGridWidth(detail_grid_W);
		}
		
		//页面初始化是，默认显示第一个设备信息
		function initGridData(){		        			
			//如果根节点的第一个子节点不为空，则选中此节点
			var roots=zTreeObj.getNodes();			
			var nodes=roots[0].childs;			
			if (nodes.length > 0){	
				//如果根节点的第一个子节点不为空，则选中此节点
				zTreeObj.selectNode(nodes[0], false);
				queryDevice_Master(nodes[0].id, 1, "#devMaster1");
			}
		}
		//批量新增
		function batchAdd(flag){ 
			if (flag == 1)
			{
				var nodes=zTreeObj.getSelectedNodes();
	        	if (nodes.length>0){
	        		if (nodes[0].level==0){
	        			alert('请选中设备节点后，再点击此按钮来新增其子设备！');
	        			return;
	        		}	        		        			        		
	        	}
				$('#Batch_Title').text('批量新增');						
				$("#endid").attr('readonly',false);
				$("#endid").attr('style','width:30px;');
				$("#deviceNamePan").show();			
			}
			else{
				var ids=jQuery("#devDetail").getGridParam("selarrrow");
				if (ids.length==0){
					alert('请选中设备记录后，再点击此按钮来进行编辑！');
	        		return;
				}
				$('#Batch_Title').text('批量编辑');	
				$("#endid").attr('readonly',true);
				$("#endid").attr('style','width:30px;background:silver;');	
				$("#deviceNamePan").hide();	
			}
			reset_B();
			$("#batchFlag").val(flag); 
			
			/************
			*根据设备树节点的端子编码判断 当前设备所在层数+1 是否等于设备层次数目，
			*	相等：该层为设备端口层
			*	不相等：该层为设备层
			*返回值：相等：true  不相等：false
			*注：设备层显示字段：设备名称  设备地址 模块局 图标 备注
			*   端子层显示字段：设备名称 状态 绑定电话 模块局 图标 备注
			*
			************/
			var devid =$("#devid_level").val();	
			var levelFlag =getThelevel(devid);			
			if(levelFlag){
				$("#batchNodeExplain").show();
				$("#state_b_D").show();
				$("#dh_b_D").show();
				$("#addr_b_D").hide();				
			}else{
				$("#batchNodeExplain").hide();
				$("#state_b_D").hide();
				$("#dh_b_D").hide();
				//$("#addr_b_D").show();
								
				/***
				* 只有第二级设备有设备地址属性
				* 由于devid值是目前设备的父设备的编号，所以判断当期设备是否为二级设备
				* end = devid.split('.').length ;
				* end == 1;//jqgrid上显示的为二级设备
				*/
				var end = devid.split('.').length ;
				if(end == 1){
					$("#addr_b_D").show();
				}else{
					$("#addr_b_D").hide();
				}
			}			
			
			autoBlockFormAndSetWH('divBatchAdd',30,'100px','close',"#ffffff",false,'', '');
		}	
		function sortNumber(a,b)
		{
			return a - b;
		}	
		//弹出查询页面
		function showQuery(){	
			$('#queryvalue').val("");			
			autoBlockFormAndSetWH('divQuery',30,'100px','close',"#ffffff",false,'', '');
			setTimeout("$('#queryvalue').focus();",100);									
		}
							
	</SCRIPT>
	<style type="text/css">
		#input-Unit{ 
			float:left;
			width:97%; 
			text-align:center;
		}
		#input-Unit .title_rad{
			width:97%; 
			height:24px; 
			border-bottom:1px solid #C8D8E5;  
			text-align:left; 
			color:#3C3C3C; 
			line-height: 22px; 
			font-weight:bold; 
			background:#CCCCFF;
		}
		.tsdbutton_rad{
			width:70px; height:22px;
			background: url(style/images/public/buttonsbg.jpg) repeat-x; 
			border: #CCCCCC 1px solid; 
			cursor: pointer;
		}
		.divTreeDM{
			position:fixed;
			width:100%; 
			left:0px;
            right:0px;
            position: relative;
            margin-top: -0px; /* footer高度的负值 */
            clear: both;           
		}
		.divTreeEx{
			position:fixed;
			bottom:0px;
			right:0px; 
			height:50px; 
			background-color:#E1F2F9;
  			width:100%;
		}		 
	
	
	.float_div{
		float:left;
		margin:4px 6px 8px 6px;
		width:240px;
		height:18px;
		font-size:13px;
		line-height:18px;
		display:block;
		}
	.float_div input{
		float:right;
		height:18px;
		line-height:18px;
		vertical-align:middle;
		}	
	.neibu{
		width:auto; 
		height:18px;
		line-height:18px;
		padding-top:1px;
		display:inline;
		float:right;
		}	
	#divBtn .tsdbutton{
		float:left;
	}	
	</style>
  </head>
  
  <body>
    <DIV class="ui-layout-north" style="overflow-x: hidden;overflow-y: hidden;">
		<div id="navBar1" style="margin-left:-10px;margin-right:-10px;margin-top:-10px;margin-bottom:-8px">
			<table width="100%" height="26px" >
				<tr>
					<td width="80%" valign="middle" >
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />您当前所在的位置 ：		 												 													
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back" style="padding-right:10px;"><!--去掉</a>后面的&nbsp; songxiaofei-->
							<a href="javascript:void(0);" onclick="parent.history.back(); return false;">
								返回
							</a>
						</div>
					</td>
				</tr>
			</table>
		</div>								
	</DIV> 	
	<DIV class="ui-layout-west" >
		<div id="input-Unit" style="text-align: left;background-color:#FFFFFF;overflow: hidden;" >
			<div class="divTreeDM" style="overflow-y: auto;">
                <ul id="tree" class="ztree" >
                </ul>
            </div>
            
            <div class="divTreeEx">
				<hr style="width: 95%;"/>	            	
				<div style="font-weight: bold; color:red;">说明：</div>
					1.设备树上可使用右键菜单
            </div>
		</div>	
		
	</DIV>		
	<DIV class="ui-layout-center">
	<!-- 右键菜单div --> 		
		<div id="itemMenu" class="contextMenu" style="display:none;"> 
			<ul>
				<li id="add"><img src="style/images/public/ltubiao_03.gif"  />新增子设备<br /></li>
				<li id="update"><img src="style/images/public/tree_addnode.gif" />编辑<br /></li>
				<li id="del"><img src="style/images/public/ltubiao_02.gif" />删除<br /></li>
			</ul>
		</div>
	
		
			<div id="input-Unit" style="margin:-10px;">
			<fieldset style="margin-left:5px;padding-bottom:10px;">
		    		<legend><span style=" font-size:12px;">设备信息</span></legend>	
			<div id="DevMasterDiv1" style="display: none;">
				<div class="float_div"  id="devno_MAD" style="display: none;"><input type="text" disabled="disabled" id="devno_MA" /><div class="neibu">设备编码：</div></div>
			    <div class="float_div"  id="devname_MAD" ><input type="text" disabled="disabled" id="devname_MA" /><div class="neibu">设备名称：</div></div>
			    <div class="float_div"  id="levelcount_MAD" ><input type="text" disabled="disabled" id="levelcount_MA" /><div class="neibu">层次数目：</div></div>
				<div class="float_div"  id="routetype_MAD" ><input type="text" disabled="disabled" id="routetype_MA" /><div class="neibu">业务类型：</div></div>
				<div class="float_div"  id="routetypeVal_MAD" style="display: none;"><input type="text" disabled="disabled" id="routetypeVal_MA" /><div class="neibu">业务类型值：</div></div>				
			    <div class="float_div"  id="linemode_MAD" ><input type="text" disabled="disabled" id="linemode_MA" /><div class="neibu">配线方式：</div></div>
			    <div class="float_div"  id="memo_MAD" ><input type="text" disabled="disabled" id="memo_MA" /><div class="neibu">备注：</div></div>
			    <div class="float_div"  id="devicon_MAD" style="display: none;"><input type="text" disabled="disabled" id="devicon_MA" /><div class="neibu">图标：</div></div>
			</div>
			<div id="DevMasterDiv2" >
				<div class="float_div"  id="devno_MBD" style="display: none;"><input type="text" disabled="disabled" id="devno_MB" /><div class="neibu">设备编码：</div></div>
				<div class="float_div"  id="devname_MBD" ><input type="text" disabled="disabled" id="devname_MB" /><div class="neibu">设备名称：</div></div>
			    <div class="float_div"  id="state_MBD" style="display: none;"><input type="text" disabled="disabled" id="state_MB" /><div class="neibu">状态：</div></div>
			    <div class="float_div"  id="dh_MBD" style="display: none;"><input type="text" disabled="disabled" id="dh_MB" /><div class="neibu">绑定电话：</div></div>
			    <div class="float_div"  id="addr_MBD" ><input type="text" disabled="disabled" id="addr_MB" /><div class="neibu">设备地址：</div></div>
			    <div class="float_div"  id="mokuaiju_MBD" ><input type="text" disabled="disabled" id="mokuaiju_MB" /><div class="neibu">模块局：</div></div>
			    <div class="float_div"  id="ywarea_MBD" ><input type="text" disabled="disabled" id="ywarea_MB" /><div class="neibu">业务区域：</div></div>
			    <div class="float_div"  id="memo_MBD" ><input type="text" disabled="disabled" id="memo_MB" /><div class="neibu">备注：</div></div>
			    <div class="float_div"  id="devicon_MBD" style="display: none;"><input type="text" disabled="disabled" id="devicon_MB" /><div class="neibu">图标：</div></div>
				<div class="float_div"  id="pdevno_MBD" style="display: none;"><input type="text" disabled="disabled" id="pdevno_MB" /><div class="neibu">上级设备：</div></div>
				<div class="float_div"  id="ip_MBD"><input type="text" disabled="disabled" id="ip_MB" /><div class="neibu">IP地址：</div></div>
				<div class="float_div"  id="vlan_MBD"><input type="text" disabled="disabled" id="vlan_MB" /><div class="neibu">VLAN：</div></div>
			
			</div>
			</fieldset>	
			<!-- 设备信息 start 
			<div id="div_devMaster1">
				<table id="devMaster1" class="scroll" cellpadding="0" cellspacing="0"></table>
			</div>
			<div id="div_devMaster2" style="display:none;">		
				<table id="devMaster2" class="scroll" cellpadding="0" cellspacing="0"></table>
			</div>
			-->
			<!-- 设备信息 end -->
			</div>
			<div style="float:left;margin-top:10px;display:inline;">
				<!-- songxiaofei 修改按钮与子设备信息的兼容性（ie8与火狐） -->		
				<!-- songxiaofei 修改批量修改按钮的样式，使其不换行 -->				
					<input  class="tsdbutton" type="button" value="新增" onclick="editDetail(1,'grid','child');"/>
					<input  class="tsdbutton" type="button" value="编辑" onclick="editDetail(2,'grid','child');"/>
					<input  class="tsdbutton" type="button" value="删除" onclick="delObj_d();"/>
					<input  class="tsdbutton" type="button" value="批量新增" onclick="batchAdd(1);"/>				
					<input  class="tsdbutton" type="button" value="批量编辑" onclick="batchAdd(2);"/>	
					<input  class="tsdbutton" type="button" value="批量删除" id="batchDel" 
						onclick="openDiaQueryG('delete','air_device_detail');" style="display: none;"/>	
					<input  class="tsdbutton" type="button" value="查找" onclick="showQuery();"/>
			</div>
            <div style="float:left;" id="divBtn"> 
					<table id="devDetail" class="scroll" cellpadding="0" cellspacing="0" ></table>
           			<div id="pager_devDetail" class="scroll" style="text-align:left; width:60px;"></div>        		
           	</div>		
	</DIV>
	
	<!-- 存放上级节点的编码方便获取该节点所在设备子树的层次数目 -->
	<input type="hidden" id="devid_level"/>
	<input type="hidden" id="devid_devno"/>
	<input type="hidden" id="devid_Icon_count" value="<%=x %>"/>
	<input type="hidden" id="devid_Icon_Path" value="<%=devicepath %>"/>
	
	
	<!-- 主表新增、编辑页面 -->
	<jsp:include page="DeviceMaster.jsp"  flush="true" />		
	<!-- 明细表新增、编辑页面 -->
	<jsp:include page="DeviceDetail.jsp"  flush="true" />
	<!-- 明细表批量新增、批量编辑页面 -->
	<jsp:include page="Detail_BatchAdd.jsp"  flush="true" />
	<!-- 明细表查询页面 -->
	<jsp:include page="Detail_Query.jsp"  flush="true" />		
  </body>
</html>
