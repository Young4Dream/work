<br>
&gt;
<%----------------------------------------
	name: RouteAdd.jsp
	author: wangli
	version: 1.0 
	description: 号线路由管理-新增/修改路由页面
	Date: 2011-11-03
	modify:2012-6-21 yhy
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<script type="text/javascript">
		var zTreeObj;
		var setting = {					
			callback: {
				onClick: nodeClick,			
				onDblClick: nodeDblClick											
			}
		};
		var currNode = "";  //用来存放当前点击的树节点的id
		var objCount = 0;   //用来存放设备的对象级别数目
		//初始化路由设备表格(air_device_master)
		function initGrid_device(routetype){
			jQuery('#grid_device').jqGrid({								
				height: 280,	  	
				width:140,
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
				caption:"配线设备列表"			
			});
			setTimeout("fillGrid_device('"+routetype+"');", 15);
		}
		
		//初始化路由模板表格(air_routedefine)
		function initGrid_routetemp(routetype, linemode){			
			jQuery('#grid_routetemp').jqGrid({				
				height: 280, 	
				width:140,
				datatype: "xml",
			   	colNames:['', 'devno', '名称'],
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
				caption:"配线模板",
				loadComplete: function() { 					
					//isModDevice
				}
					
			});
			setTimeout("fillGrid_routetemp('"+routetype+"');", 15);
		}
			
		//初始化路由表格(air_route_xxx)
		function initGrid_newroute(){			
			jQuery('#grid_newroute').jqGrid({				
				height:280,	  	
				width:340,
				datatype: "xml",
			   	colNames:['', 'id1','设备类型', '设备名称', 'id3','端口名称'],
			   	colModel:[			        
			        {name : 'routeno', index : 'routeno', width : 25},
			        {name : 'id1', index : 'id1',hidden:true},
			        {name : 'name1', index : 'name1',width:65},
			        {name : 'name2', index : 'name2',width:140},
			        {name : 'id3', index : 'id3',hidden:true},
			        {name : 'name3', index : 'name3',width:110}			        			        		
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
				ondblClickRow: function(rowid) {
					var devid=$("#grid_newroute").getCell(rowid,'id1')+'.';
					var devname=$("#grid_newroute").getCell(rowid,'name1');
					var mkj=$('#routeAdd_mkj').val();					
					initTree(devid, devname, mkj); 					
					showtree();
				},				
				caption:"用户配线"			
			}).navGrid('#pager_newroute',{refresh: false, edit: false, add: false, del: false, search: false});
 			jQuery("#grid_newroute").navGrid('#pager_newroute',{refresh: false, edit: false, add: false, del: false, search: false})
 			.navButtonAdd('#pager_newroute',{ caption:"上移", buttonimg:"style/images/public/asc.png", onClickButton: moveup, position:"last" })
  			.navButtonAdd('#pager_newroute',{ caption:"  下移", buttonimg:"style/images/public/desc.png", onClickButton: movedown, position:"last" })
  			.navButtonAdd('#pager_newroute',{ caption:"删除", buttonimg:"style/images/public/tubiao_2.jpg", onClickButton: delRouteNode, position:"last" })
  			.navButtonAdd('#pager_newroute',{ caption:"清空", buttonimg:"style/images/public/ltubiao_04.gif", onClickButton: cleargrid, position:"last" })
  			.navButtonAdd('#pager_newroute',{ caption:"清除内容", buttonimg:"style/images/public/ltubiao_03.gif", onClickButton: clearcontent, position:"last" })
  			.navButtonAdd('#pager_newroute',{ caption:"说明", buttonimg:"style/images/public/tubiao.jpg", onClickButton: showWExplanation, position:"last" });
			
		}
		
		//刷新路由设备表格数据
		function fillGrid_device(routetype){
			//自由路由设置权限
			var notFixedRoute = $("#notFixedRoute").val();
			//只有拥有设置“自由路由”权限的工号，才能使用该面板中的设备
			if( notFixedRoute == 'false'){
				//该工号没有设置自由路由权限
				$('#grid_device,#add').attr("disabled","disabled");
			}else{
				$('#grid_device,#add').removeAttr("disabled");					
			}
			
			//参数拼接，查询符合该业务类型的所有设备
			var scond = "";
			if (routetype != ''){
				scond += " and instr('~'||routetype||'~' , '~'||'" +routetype+ "'||'~')>0 ";			  
			}
			//如果业务类型为空，这查询出全部设备	
			if (scond==''){
				scond += ' and 1=1 ';
			}		
			
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryDevice_Route','', 'route');
			urlstr += '&cond='+tsd.encodeURIComponent(scond);							
			$('#grid_device').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");	
		}
		
		//刷新路由模板表格数据
		function fillGrid_routetemp(routetype){

			//查询该业务类型的设备模板			
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryRouteDefine','', 'route');
			urlstr += '&routetype='+tsd.encodeURIComponent(routetype);
			//yhy 2012-7-6 start
			//显示的时候不做次限制
			//控制模板中可设置的设备，只有可设置的设备才会显示在“设备模板”面板上
			//urlstr += "&isModDevice=and inStr('"+ tsd.encodeURIComponent(isModDevice) +"',a.devno)>0 ";			
			//yhy 2012-7-6 end
			$('#grid_routetemp').setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");			
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
		function getrowid(tabid){
			var therow = document.getElementById(tabid).rows;
			return therow.length;
		}
		
		//添加路由设备到路由表格中
		function addRouteNode(devno, devname){
			var rowid = getrowid('grid_newroute');
			var rowdata = {'routeno':rowid, 'id1':devno,'name1': devname}; 
			$('#grid_newroute').addRowData(rowid, rowdata);
		}
		
		//将路由设备列表中的选中设备添加到路由表格中
		function addDeviceNode(){
			var rowid=$('#grid_device').getGridParam("selrow");			
			var devno=$('#grid_device').getCell(rowid,'devno');			
			if (devno=='' || devno==null) {
			  return;
			}
			var devname = $('#grid_device').getCell(rowid,'devname');
			//添加路由设备到路由表格中
			addRouteNode(devno, devname);
		}
		
		//将路由模板中的所有路由设备添加到路由表格中
		function addTempNode(){
			$('#grid_newroute').clearGridData();
			var therow = document.getElementById('grid_routetemp').rows;
			for (var i = 1; i < therow.length; i++)
            {              	
            	var devno = $('#grid_routetemp').getRowData(i).devno;
                var devname = $('#grid_routetemp').getRowData(i).devname;
                //控制模板中可设置的设备，只有可设置的设备才会移到“用户配线”面板上
            	//isModDevice 
            	var isExits = isModDevice.indexOf(devno) ;
                if( isExits != -1 ){
                	addRouteNode(devno, devname);
                }				
            }
		}
		
		//将路由模板中选中的路由设备添加到路由表格中
		function addOneTempNode(){
			var rowid=$('#grid_routetemp').getGridParam("selrow");			
			var devno=$('#grid_routetemp').getCell(rowid,'devno');	
			//控制模板中可设置的设备，只有可设置的设备才会移到“用户配线”面板上
           	//isModDevice 
           	var isExits = isModDevice.indexOf(devno) ;
            if( isExits == -1 ){
            	alert("您没有该设备的设置权限！");
            	return;
            }
                		
			if (devno=='' || devno==null) {
			  return;
			}
			var devname = $('#grid_routetemp').getCell(rowid,'devname');
			//添加路由设备到路由表格中
			addRouteNode(devno, devname);
		}
		//从路由表格中删除路由设备
		function delRouteNode(){
			var table = document.getElementById('grid_newroute');			
			var rowid=$('#grid_newroute').getGridParam("selrow");
			var delnum = $('#grid_newroute').getRowData(rowid).routeno;			
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
		//路由表格，上移
		function moveup(){
			var table = document.getElementById('grid_newroute');
			var rowid=$('#grid_newroute').getGridParam("selrow");
			var selnum = $('#grid_newroute').getRowData(rowid).routeno;
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
			var selnum = $('#grid_newroute').getRowData(rowid).routeno;
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
				selnum = $('#grid_newroute').getRowData(s[i]).routeno;				
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
		//清除路由表格选中行的内容
		function clearcontent(){
			var rowid=$('#grid_newroute').getGridParam("selrow");
			var rowdata = {'name2':'','id3':'','name3':''};
			 
			$('#grid_newroute').setRowData(rowid, rowdata);
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
		//显示树控件
		function showtree(){
			$('#maxpanels').show();
			$('#divtree').show();
		}
		//隐藏树控件
		function hidetree(){
			$('#divtree').hide();
			$('#maxpanels').hide();	
		}
		
		//保存路由 flag=1:新增;flag=2:编辑;
		function save(flag){

			if (!confirm("您确定要进行保存操作吗？")){
				return;
			}
			var param = '';//参数拼接
			var table = $('#routeAdd_table').val();//相应业务类型号线信息表名
			var dh = $('#routeAdd_dh').val();
			var routeType = $('#routeAdd_routeType').val();		
			param = "&table="+table+"&dh="+dh;
			
			var optype = "";		//操作类型
			var v_portnos = "";		//端口编号拼接
			var v_routenos = "";	//设备序号拼接
			var v_portno = "";		//端口编号
			var v_routeno = "";		//设备序号
			var v_devicetype="";	//设备类型
			//获取路由表格的总行数
			var therow = document.getElementById('grid_newroute').rows;
			
			//是否为并机配线操作 0非并机地址配线  1：并机地址配线
			var isParallel = $('#isParallel').val();
			var linenumBj = ''; //配线序号
			var useridBj =	'';	//并机电话userid
			if(isParallel == 0){
				linenumBj = $('#routeAdd_lineno').val();					
			}else{				
				linenumBj = $("#linenum_bj_add").val();
				useridBj= $("#userid_bj_add").val();	
			}			
			
			param +='&isParallel=' + isParallel +'&useridParallel=' +useridBj +'&lineno='+linenumBj;
			//新增	
			if (flag == 1){
				//配线操作类型 新增
				optype = "insert";
				param += "&optype="+optype;
				
				//获取当前grid的id号数组
				var ids = $('#grid_newroute').getDataIDs();	
				v_routeno =1;//设备端口序号	
				for (var i=0; i< ids.length; i++)
				{
					
					//配线面板中如果有为设置具体端口的设备，则忽略该设备
					v_portno = $('#grid_newroute').getRowData(ids[i]).id3;
	               // v_routeno = $('#grid_newroute').getRowData(ids[i]).routeno;
	                if( undefined != v_portno &&v_portno != ''){
	                	v_portnos += v_portno+",";
	                	v_routenos += v_routeno+",";
	                	
	                	v_routeno = v_routeno +1;
	                }
	                /**
					v_portno = $('#grid_newroute').getRowData(ids[i]).id3;
	                v_routeno = $('#grid_newroute').getRowData(ids[i]).routeno;
	                
	                //yhy modify
	                if(v_portno==''){
	                	v_devicetype = $('#grid_newroute').getRowData(ids[i]).name1;
	                	alert(v_devicetype +"的端口名称不能为空。");
	                	return false;
	                }else{
	                	v_portnos += v_portno+",";
	                	v_routenos += v_routeno+",";
	                } 
	                */           
				}		
				//去掉最后一项的逗号
				if (v_portnos != ""){
					v_portnos = v_portnos.substr(0, v_portnos.length-1);
				}
				if (v_routenos != ""){
					v_routenos = v_routenos.substr(0, v_routenos.length-1);
				}
								
				param += "&portno="+v_portnos+"&routeno="+v_routenos;
				//执行插入操作
				var res = fetchMultiPValue("air_route_manage",6,param);
				if(res[0][0]=="SUCCEED"){        	             				
					alert("新增配线成功！");				
					//主页面中显示增加的路由
					query_route(dh, table);
					$("#grid_user").trigger("reloadGrid");
					//关闭编辑页面
					//setTimeout($.unblockUI,15);	
					$("#divRouteAdd").hide();																						
	        	}
	        	else{
	        		alert("增加路由失败！\r\n\n错误消息："+res[0][1]);
	        	}								
			}
			else{	
				//配线操作类型 新增			
				optype = "update";
				param += "&optype="+optype;
				
				var ids = $('#grid_newroute').getDataIDs();
				v_routeno =1;//设备端口序号	
				for (var i=0; i< ids.length; i++)
				{					
					//2012-6-25 yhy start 配线的设备在数据库中的编号从不是1的数值开始
					//由于允许用户选择的设备可以进行设置端口，保存的时候将不把该设备保存到数据库中，这将导致号线设备编号
					//不是逐一递增，对该问题进行处理					
					
					//配线面板中如果有为设置具体端口的设备，则忽略该设备
					v_portno = $('#grid_newroute').getRowData(ids[i]).id3;
	                //v_routeno = $('#grid_newroute').getRowData(ids[i]).routeno;
	                
	                if( (  undefined != v_portno &&v_portno != '') 
	                	&& (undefined!= v_routeno && v_routeno != '' )){
	                
	                	v_portnos += v_portno+",";
	                	v_routenos += v_routeno+",";
	                	v_routeno =v_routeno + 1;
	                }
	                //2012-6-25 yhy end
	                /*
	                 //yhy modify
	                if(v_portno==''){
	                	v_devicetype = $('#grid_newroute').getRowData(ids[i]).name1;
	                	alert(v_devicetype +"的端口名称不能为空。");
	                	return false;
	                }else{
	                	v_portnos += v_portno+",";
	                	v_routenos += v_routeno+",";
	                }	
	                */               
				}		
				//去掉最后一项的逗号
				if (v_portnos != ""){
					v_portnos = v_portnos.substr(0, v_portnos.length-1);
				}
				if (v_routenos != ""){
					v_routenos = v_routenos.substr(0, v_routenos.length-1);
				}
										
				param += "&portno="+v_portnos+"&routeno="+v_routenos;
				var res = fetchMultiPValue("air_route_manage",6,param);
				if(res[0][0]=="SUCCEED"){     				
					alert("修改配线成功！");
					
					//主页面中显示增加的路由
					query_route(dh, table);
					/************************
					//2012-7-12 yhy start
					//更改号线配线不需要刷新用户号线资料
					$("#grid_user").trigger("reloadGrid");
					//2012-7-12 yhy end
					**********************/
					//关闭编辑页面
					//setTimeout($.unblockUI,15);
					$("#divRouteAdd").hide();																					
	        	}
	        	else{
	        		alert("修改配线失败！\r\n\n错误消息："+res[0][1]);
	        	}							
			}
			//清除被锁定账号线路
			unLockAirUser();				
		}		
		//下面是树控件的操作函数
		//初始化树形控件
		function initTree(devid, devname, mkj){			
			var devNodes = [];
			var devNode;
			var scond="&devid="+devid;
			
			/*********************
			//去掉设备的模块局限制,加提示：“选择的设备所在模块局和电话所在模块局不一样。”
			//yhy 2012-7-5 start
			if (mkj!=null && mkj!=""){
				scond += "&cond=and mokuaiju = '"+tsd.encodeURIComponent(mkj)+"'";
			}
			else{
				scond += "&cond=and 1=1";
			}
			//yhy 2012-7-5 end
			*********************/
			
			scond += "&cond=and 1=1";
			
			var res = fetchMultiArrayValue('dbsql_route.GetTreeDevice',6,scond,'route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					devNode = {"id":res[i][0],"name":res[i][1],"devicon":res[i][2]};
					devNodes.push(devNode);
				}
			};			
			//取出此设备的层次数目，并置于全局变量objCount中.同时取出其图标文件名并置于节点数据中			 
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			res = fetchMultiArrayValue('dbsql_route.GetLevelCount',6,urlstr,'route');
			objCount = res[0][0];
			var devicon = res[0][1];
			var id = devid.substr(0, devid.length-1);//去掉后面的.号						
			var zTreeNodes = [			
				{"id":id, "name":devname, "devicon":devicon, open:true, childs: devNodes}
			];			
			zTreeObj = $.fn.zTree.init($("#tree"), setting, zTreeNodes);
			//选中根节点	
			var nodes = zTreeObj.getNodes();			
			zTreeObj.selectNode(nodes[0]);		
			//设置根节点的显示情况
			nodeClick('', '', nodes[0], '');																
		}	
		//树节点单击事件
		function nodeClick(event, treeId, treeNode, clickFlag) {		
			var devid = treeNode.id;			
			//如果已经单击过，则不再执行下面的代码。目的是为了避免 dbclick引发的两次click事件（因为在jQuery事件绑定中，dbclick可以触发两次click事件）					
			if (currNode == devid){
				return;
			}
			//用于端口查询
			$("#queryDevid").val(devid);	
			//清空查询端口名称
			$("#devnameText").val("");
				
			//如果下级是端口级，则显示选中节点的端口信息			
			//如果节点的下一级是端口级，则不再添加							
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			var levelcount = objCount;
			if (treeNode.level+2<levelcount){
				var devicon = treeNode.devicon;
				showOtherInfo(devid, levelcount, devicon);
			}
			else if (treeNode.level+2==levelcount){
				//选择的设备所在模块局和电话所在模块局不一样。 yhy 2012-7-5
				//alert("选择的设备所在模块局和电话所在模块局不一样" + devid);
				var userMkj = $('#routeAdd_mkj').val();
				var urlstr = '&devno=' + devid ;
				var devMkj= fetchSingleValue('dbsql_route.RM.getDevMkj',6,urlstr,'route');
				if( userMkj =='' ||userMkj=='undefined'){
					alert("电话所在模块局为空，请联系管理员在【用户合同号档案】中进行设置。");				
				}else if(devMkj != userMkj){
					alert("选择的设备所在模块局是[" + devMkj+ "]和电话所模块局[" + userMkj + "]不一样。");
				}
				//初始化分页
				initPage();
				queryDevice_Port(devid,'','1');	
			}							
			currNode = devid;			
		}			
		//双击树节点，添加其子节点
		function nodeDblClick(event, treeId, treeNode){	
			//如果节点已经展开过，就不再添加其子节点
			if (treeNode.isParent){					
				return;
			}
			var devid = treeNode.id;			
			//如果节点的下一级是端口级，则不再添加							
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			var levelcount = objCount;									
			if (treeNode.level+2==levelcount){
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
		//选中的对象，其下级不是端口，则不显示端口表格。而显示其它信息		
		function showOtherInfo(devid, levelcount, devicon){			
			var idlen= parseInt(levelcount*6)+parseInt(levelcount-1);
			var urlstr = '&devid='+tsd.encodeURIComponent(devid)+'&idlen='+idlen;
			var res = fetchMultiArrayValue('dbsql_route.QueryPortCount',6,urlstr,'route');
			var portinfo = "";
			var total = 0;
			if (res != undefined && res!="" && res.length>0){								
				for(var i=0;i<res.length;i++){
					total = total + parseInt(res[i][1]); 					
					switch(res[i][0]){
						case 'free': portinfo += "<font color='green' style='font-size: 11px;'>空闲："+res[i][1]+"</font><br/>"; break;
						case 'using': portinfo += "<font color='red' style='font-size: 11px;'>占用："+res[i][1]+"</font><br/>"; break;
						case 'bad': portinfo += "<font color='blue' style='font-size: 11px;'>故障："+res[i][1]+"</font><br/>"; break;
						case '': portinfo += "<font color='black' style='font-size: 11px;'>其它："+res[i][1]+"</font><br/>"; break;				
					}
				}
			}
			portinfo = "<font color='black' style='font-size: 14px;font-weight: bold'>端口总数："+total+"，其中：</font><br/>"+portinfo;			
			var iconpath = devicon;			
			var td;
			if (iconpath=="" ||iconpath==null ||iconpath==undefined){
				td = '<font color="#C3CED2">暂无图片</font>';
			}
			else{
				td = '<img src="'+iconpath+'" style="width:180px;height:150px" />'
			}
			var table = '<table border="1" cellpadding="0" bordercolor="#9AC0CD" style="height:210; width:70%;margin-top:10px;">'
			  +'<tr>'
			    +'<td style="width:50%;text-align:center;">'+td+'</td>'			    
			    +'<td style="width:50%;">'+portinfo+'</td>'
			  +'</tr>'
			  +'</table>';						
			var s = "<div style='width:550px;line-height:230px'>"+table+"</div>";
			$('#pagered1').html(s);			
			var sHint = "请继续在设备结构树中选择其子对象！";
			$('#lblhint').text(sHint);
			//隐藏添加端口按钮
			$("#addPort").hide();
			//隐藏分页按钮
			setPageButton('hide');
			
			checkNodeName('','');//将存放端口名称和编码的变量清空
		}
		//端子选择表格的选择代码
		function checkNodeName(value,DeviceNo){
			$('#thenodename').val(value);
			$('#thenodeno').val(DeviceNo);
		}	
		
		//显示对象的端子信息。动态在table中显示		
		function queryDevice_Port(devid,devname,type){
			//从配置表中获取设备端口是否允许被复用
			var Multiplexing = fetchMultiArrayValue('dbsql_rount.QueryMultipl',6,'','route');
			var MultipleVal =0;//MultipleVal为1=可复用  0=不可复用
			if (Multiplexing != undefined && Multiplexing!="" && Multiplexing.length>0){
				MultipleVal=Multiplexing[0][0];
			}
			$('#pagered1').empty();
			var urlstr = '&devid='+tsd.encodeURIComponent(devid)+'.';
			urlstr += '&devname='+tsd.encodeURIComponent(devname);
			var statestr = ' 1=1 ';
			//在显示设备端口时，是否只显示空闲端口
			var onlyShowFree = fetchMultiArrayValue('dbsql_route.onlyShowFree',6,'','route');
			if (onlyShowFree != undefined && onlyShowFree!="" && onlyShowFree.length>0){
				onlyShowFree = onlyShowFree[0][0];
				if(onlyShowFree=='Y'){
					statestr = " state = 'free' " ;
				}
			}
			urlstr += '&state='+ statestr;
			
			//分页页码获取
			var QPRows = parseInt($("#QPRows").val());
			var QPPage = parseInt($("#QPPage").val()) ;
			var pagerStart = (QPPage-1)*QPRows;			
			urlstr += '&pagerStart='+ pagerStart;
			urlstr += '&rows='+ QPRows;
			urlstr += '&portype='+ $("#hidywtype").val();
			$("#QPtype").val(type);
			$("#QPDevid").val(devid);
			$("#QPDevName").val(devname);
			
			var sqlstr = 'dbsql_route.QueryDevicePortFuzz';
			var sqlPagestr ='dbsql_route.QueryDevicePortFuzzC';
			if(type=='1'){
			 	sqlstr = 'dbsql_route.QueryDevicePortFuzz';
			 	sqlPagestr = 'dbsql_route.QueryDevicePortFuzzC';
			}else if(type=='2'){
				sqlstr = 'dbsql_route.QueryDevicePortAccurate';
				sqlPagestr = 'dbsql_route.QueryDevicePortAccurateC';
			}
			//获取该批数据的总数，用于分页
			var count = fetchMultiArrayValue(sqlPagestr,6,urlstr,'route');
			if (count != undefined && count!="" && count.length>0){
				$("#OPcounts").val(count[0][0]);
			}
			var res = fetchMultiArrayValue(sqlstr,6,urlstr,'route');
			if (res != undefined && res!="" && res.length>0){				
				var table = '';			
				table += "<table style='width:650px;' align='center' border='1' ><caption border='2px' style='font-size: 12px;border-color: black'>选择端口</caption><tr style='line-height:18px;height:18px;'>";
				var DeviceNo;
				var NodeName;						
				var NodeState;
				var DeviceNoDH;			
				var j=1;
				for(var i=0;i<res.length;i++){					
					DeviceNo = res[i][0];
					NodeName = res[i][1];
					NodeState = res[i][2];					
					DeviceNoDH = res[i][3];
					if(j%4==0){
          				if(NodeState=="free" || NodeState==""){
       						table = table + "<td width='10%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='green' style='font-size: 11px;'>"+NodeName+"</font></td></tr><tr style='line-height:14px;'>";
       					}else if(NodeState=="using"){
       						//MultipleVal
       						if(MultipleVal==1){
       							//table = table + "<td width='12%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='red' style='font-size: 11px;'>"+NodeName+"("+DeviceNoDH+")</font></td></tr><tr style='line-height:14px;'>";
       							table = table + "<td width='10%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='red' style='font-size: 11px;'>"+NodeName+"</font></td></tr><tr style='line-height:14px;'>";
       						}else{
       							//table = table + "<td width='12%'><font color='red' style='font-size: 11px;'>"+NodeName+"("+DeviceNoDH+")</font></td></tr><tr style='line-height:14px;'>";
       							table = table + "<td width='10%'><font color='red' style='font-size: 11px;'>"+NodeName+"</font></td></tr><tr style='line-height:14px;'>";
       						}
       						
       					}else if(NodeState=="bad"){
       						table = table + "<td width='10%'><font color='blue' style='padding-left:20px;font-size: 11px;' >" + NodeName + "</font></td></tr><tr style='line-height:14px;'>";       						
       					}
          			}else{
       					if(NodeState=="free" || NodeState==""){
       						table = table + "<td width='10%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='green'  style='font-size: 11px;'>"+NodeName+"</font></td>";
       					}else if(NodeState=="using"){
       						if(MultipleVal==1){
       							//table = table + "<td width='12%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='red'  style='font-size: 11px;'>"+NodeName+"("+DeviceNoDH+")</font></td>";
       							table = table + "<td width='10%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='red'  style='font-size: 11px;'>"+NodeName + "</font></td>";
       						}else{
       							//table = table + "<td width='12%'><font color='red'  style='font-size: 11px;'>"+NodeName+"("+DeviceNoDH+")</font></td>";
       							table = table + "<td width='10%'><font color='red'  style='font-size: 11px;'>"+NodeName + "</font></td>";
       						}
       						       						
       					}else if(NodeState=="bad"){
       						table = table + "<td width='10%'><font color='blue' style='padding-left:20px;font-size: 11px;'>"+NodeName+"</font></td>";       						
       					}
          			}
          			j++;
				}	
				//补全端口表格
				if(j%4!=1){
				 	while(j%4!=1){
				 		table = table + "<td width='10%'></td>";
				 		j++;
				 	}
				}
				table = table + "</tr>";
				/* 
				分页按钮移出来
				table = table+"<tr><td colspan='4'>";
				table = table+"<button id='devnameQbtn' onclick='prePage();' class='tsdbutton' style='width:60px;line-height:25px; margin-top: 3px; padding: 0px;'>上一页</button>";
				table = table+"<button id='devnameQbtn' onclick='nextPage();' class='tsdbutton' style='width:60px;line-height:25px; margin-top: 3px; padding: 0px;'>下一页</button>";
				table = table+"</td></tr>";
				*/
				table = table + "</table>" ;								
				$('#pagered1').append(table);
				//$('#porticon').html("注：绿色代表空闲端口，红色代表占用端口，蓝色代表故障端口。");
				
				var sHint = "注：绿色为空闲端口，红色为占用端口，蓝色为故障端口。";
				if(onlyShowFree=='Y'){
					sHint = "注：绿色为空闲端口。";
				}else{
					sHint = "注：绿色为空闲端口，红色为占用端口，蓝色为故障端口。";
				}
				
				$('#lblhint').text(sHint);	
				//显示添加端口按钮
				$("#addPort").show();	
				//显示分页按钮
				setPageButton('show');					
			}
			else{
				var s = "<div style='width:550px;line-height:230px'>无端口！</div>";
				$('#pagered1').append(s);	
				var sHint = "请继续在设备结构树中选择其子对象！"			
				$('#lblhint').text(sHint);	
				//隐藏添加端口按钮
				$("#addPort").show();
				//显示分页按钮
				setPageButton('hide');
			}
			
		}
		
		//根据端口名称查询端口 
		//devid 上级设备编号
		function selPortByName(type){
			var devid =$("#queryDevid").val();
			var devname = $("#devnameText").val();//端口名称
			//初始化端口显示分页
			initPage();
			queryDevice_Port(devid,devname,type);			
		}
		
		//点击确定按钮；将相应路由表格中的记录的设备名称和端口名称设置所选节点
		function selectedport(){
			//取出选中的端子
			var NodeName = $('#thenodename').val();//端口名称
			var DeviceNo = $('#thenodeno').val();  //端口编码			
			if (DeviceNo == "" || DeviceNo == null || DeviceNo == undefined) 
			{
				alert("请选中某一端口！");
				return;
			}			
			
			//检测传入的节点编号是否存在自动配线,返回前置端口+后置端口个数
			//否：直接设置端口信息
			//是：有自动配线的话，将对应设备替换成整串配线
			var urlstr = '&devno='+DeviceNo;
			var res = fetchMultiArrayValue('dbsql_route.RM.getBindExist',6,urlstr,'route');
			if (res != undefined && res!="" && res.length>0){
				if(res[0][0] == 0){
					//取出选中节点的所属设备的名称
					var nodes=zTreeObj.getSelectedNodes();	
					//返回节点的第一层祖先节点		
					var tmpnode1 = getOwnerDev(nodes[0],1);
					var name2 = ""; 
					if (tmpnode1 != null){
						name2 = tmpnode1.name;
					}
					//返回节点的第二层祖先节点		
					var tmpnode2 = getOwnerDev(nodes[0],2);
					if (tmpnode2 != null){
						name2 = name2+"("+tmpnode2.name+")";
					}
					setRouteRec(name2,DeviceNo,NodeName);	
				}else{
					//实现：有自动配线的话，将对应设备替换成整串配线
					//A)获取端口所在的整串配线端口信息，将其显示在一个临时表格grid_BindRoute中；
		　　			//B)将“用户配线”表格中，选中设备以下的设备不包括本身移到临时表格grid_BindRoute中，放在表格的尾部；
		　　			//C)将“用户配线”表格中被选中设备以下的设备包括本身从表格中删除；
		　　			//D)将临时表格grid_BindRoute中的数据移到“用户配线”表格尾部。				
					getBindRoute(DeviceNo); //A
					setTimeout("movToBindRout();", 500);//B
					setTimeout("delRowDataForNR();", 600);//C
					setTimeout("movToNewRoute();", 700);//D	
				}  
				hidetree(); 
			}
		}
		/*
		* 获取配线路由
		* 参数：端口编号
		*/
		function getBindRoute(DeviceNo){			
			var param = "&DeviceNo="+DeviceNo;	
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'Procedure',//类名
									method:'exequery',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdExeType:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpname:'RouteManage.AirGetDevnoTree'
									});						
			$("#grid_BindRoute").setGridParam({url:'mainServlet.html?'+urlstr+param}).trigger("reloadGrid");
		}
		
		//初始化自动配线表格(air_route_xxx)
		function initGrid_BindRoute(){			
			jQuery('#grid_BindRoute').jqGrid({				
				height:300,	  	
				width:340,
				datatype: "xml",
			   	colNames:[ 'id1','设备类型', '设备名称', 'id3','端口名称'],
			   	colModel:[ 
			        {name : 'id1', index : 'id1',hidden:true},
			        {name : 'name1', index : 'name1',width:65},
			        {name : 'name2', index : 'name2',width:140},
			        {name : 'id3', index : 'id3',hidden:true},
			        {name : 'name3', index : 'name3',width:110}			        			        		
			   	],
			   	imgpath: gridimgpath,
			    viewrecords: false,
			    sortorder: "asc",
				multiselect: false,
				useDefault:true,				
				pgbuttons: false,
				pginput: false,
				loadComplete: function() {		

				},			
				caption:""			
			});			
		}
		
		/*
		* 将“用户配线”表格中，选中设备以下的设备不包括本身移到临时表格grid_BindRoute中，放在表格的尾部		* 
		*/
		function movToBindRout(){	
			//判断用户配线表格中是否选中行
			var rowid=$('#grid_newroute').getGridParam("selrow");
			if (rowid!=null){
						
				var rowidMaxNR = getrowid('grid_newroute'); //“用户配线”表格行数
				var rowidMaxBR = getrowid('grid_BindRoute');//临时自动配线表格行数
				
				var id1 = '';//设备类型编号
				var name1 = '';//设备类型
				var name2 = '';//一级设备+二级设备名
				var id3 = '';//端口变化
				var name3 = '';//端口名称
				var rowdata = '';//拼接grid字符串
				
				//将“用户配线”选中设备以下的设备不包括本身移到临时表格grid_BindRoute中，放在grid_BindRoute表格的尾部	
				var i =Number(rowid) +1;
				for(i ; i <rowidMaxNR;i++){
					id1 = $('#grid_newroute').getCell(i,'id1');
					name1 = $('#grid_newroute').getCell(i,'name1');
					name2 = $('#grid_newroute').getCell(i,'name2');
					id3 = $('#grid_newroute').getCell(i,'id3');
					name3 = $('#grid_newroute').getCell(i,'name3');
					
					rowdata = {'id1':id1,'name1': name1,'name2': name2,'id3': id3,'name3': name3}; 
					$('#grid_BindRoute').addRowData(rowidMaxBR, rowdata);
					rowidMaxBR = rowidMaxBR +1;
				}//den for：rowid						
			}//end if :rowid			
		}
		
		/*
		* 将临时表格grid_BindRoute中的数据移到“用户配线”表格尾部。* 
		*/
		function movToNewRoute(){							
			var rowidMaxNR = getrowid('grid_newroute'); //“用户配线”表格行数
			var rowidMaxBR = getrowid('grid_BindRoute');//临时自动配线表格行数
			var id1 = '';//设备类型编号
			var name1 = '';//设备类型
			var name2 = '';//一级设备+二级设备名
			var id3 = '';//端口变化
			var name3 = '';//端口名称
			var rowdata = '';//拼接grid字符串
			var rowid = 1;//行号从一开始
			
			//将“用户配线”选中设备以下的设备不包括本身移到临时表格grid_BindRoute中，放在grid_BindRoute表格的尾部				
			for(rowid ; rowid <rowidMaxBR;rowid++){
				id1 = $('#grid_BindRoute').getCell(rowid,'id1');
				name1 = $('#grid_BindRoute').getCell(rowid,'name1');
				name2 = $('#grid_BindRoute').getCell(rowid,'name2');
				id3 = $('#grid_BindRoute').getCell(rowid,'id3');
				name3 = $('#grid_BindRoute').getCell(rowid,'name3');
				
				rowdata = {'routeno':rowidMaxNR,'id1':id1,'name1': name1,'name2': name2,'id3': id3,'name3': name3}; 
				$('#grid_newroute').addRowData(rowidMaxNR, rowdata);
				rowidMaxNR = rowidMaxNR +1;
			}//den for：rowid			
		}
		/*
		* 将“用户配线”表格中被选中设备以下的设备包括本身从表格中删除	* 
		*/
		function delRowDataForNR(){	
			//判断用户配线表格中是否选中行
			var rowid=$('#grid_newroute').getGridParam("selrow");
			if (rowid!=null){						
				var rowidMaxNR = getrowid('grid_newroute'); //“用户配线”表格行数
				
				//将“用户配线”表格中被选中设备以下的设备包括本身从表格中删除
				for(rowid ; rowid <rowidMaxNR;rowid++){
					$('#grid_newroute').delRowData(rowid);
				}//den for：rowid						
			}//end if :rowid			
		}
		
		
		//返回节点的祖先节点，level参数表示第几层祖先。
		function getOwnerDev(node, level){
			if (node.level<=1){
				return node;
			}
			var parentnode = node.getParentNode();
			while (parentnode!=null){
				if (parentnode.level == level){
					return parentnode;
					break;
				}
				parentnode = parentnode.getParentNode();
			}
			return null;
		}
		//根据树中选择的节点，设置路由表格中的选中记录的相应字段
		function setRouteRec(name2,id3,name3){
			var rowid=$('#grid_newroute').getGridParam("selrow");
			if (rowid!=null){
				$('#grid_newroute').setRowData(rowid, {name2 : name2});
				$('#grid_newroute').setRowData(rowid, {id3 : id3});
				$('#grid_newroute').setRowData(rowid, {name3 : name3});				
			}
		}
		
		//页面操作说明 flag 1:关闭说明按钮，其他情况显示说明按钮		
		function showWExplanation(flag){
			
			if( flag == 1){
				$("#Explanation").hide();
			}else{
				$("#Explanation").show();
			}			
		}
		
		
		//打开新增端口面板
		function addPort(devid){
			//将父设备的端口保存在隐藏域中
			$("#pdevno").val(devid);
			$('#Detail_Title').text('新增设备端口');
			//清空
			resetPan();
			//端口名称命名提示
			$("#nodeExplain").show();
			$("#divDetail").show();
		}
		
		
		//清空面板信息，将设备端口状态置为空闲，模块局设置为上级设备模块局
		function resetPan(){						
			$("#divDetail :text").val("");
			$("#divDetail select").val("");
			//状态设置为 空闲
			$("#state").val("free");
			
			//模块局模块局和当前电话的模块局一致			
			var rowid = $("#grid_user").getGridParam("selrow");
			if (rowid == null) 
			{
				alert("请先选中用户记录，再进行此操作！");
				return;
			}
			var mokuaiju=$("#grid_user").getCell(rowid,'MoKuaiJu');	
			$("#mokuaiju").val(mokuaiju);
			
			$("#devname_d").focus();	
		}
		
		//保存air_Device_Detail表.flag=1:新增;
		function saveDetail(flag){
			if (NullCheck("#devname_d", "设备名称")) {return};
			if (!confirm("您确定要进行保存操作吗？")){
				return;
			}
			//如果是新增，则传入父设备编码这个参数parentno  
			var parentno = $("#pdevno").val();;
			var v_devno = $("#devno_d").val();
        	var v_devname = tsd.encodeURIComponent($("#devname_d").val());
        	var v_devnameold = tsd.encodeURIComponent($("#devnameOld_d").val());
        	var v_mokuaiju = tsd.encodeURIComponent($("#mokuaiju").val());
        	var v_memo = tsd.encodeURIComponent($("#memo_d").val());  
        	var v_state = tsd.encodeURIComponent($("#state").val());
        	// optype=insert  optag=2 对明细表进行新增
        	var param=	"&optype=insert"	+"&optag=2"	 
        				+"&devno=" 			+ v_devno	+ "&portNameOld=" 	+ v_devnameold 
        				+ "&devname="		+ v_devname + "&mokuaiju=" 		+v_mokuaiju 
        				+"&memo=" 			+ v_memo 	+ "&state="			+v_state 
        				+"&parentno=" 		+ parentno;   	     	
			
        	var res = fetchMultiPValue("air_device_manage",6,param);        	      
        	if(res[0][0]=="SUCCEED"){        	     
        		//保存新增的话，提示是否继续新增
				if (flag == 1)
				{
					//新增成功后，在编号输入框中显示刚刚插入的设备编号
					$("#devno_d").val(res[0][1]);
					//初始化分页
					initPage();				
					//刷新端口列表						
		        	queryDevice_Port(currNode,'','1');
					if (confirm("保存成功！\r\n\n点击“确定”按钮继续新增设备，点击“取消”按钮返回主页面。")){											
						//清空输入框，以开始新的录入
						resetPan();						
						return;
					}
					//刷新配线端子选择面板上的端口信息
		        	//关闭本页面
		        	$("#divDetail").hide(); 		
				}
        	}
        	else if(res[0][0]=="FAILED"){ 
        		alert(res[0][1]);
        	}
        	else{
        		alert("保存失败！请仔细检查填写的数据是否正确。\r\n\n错误消息："+res[0][1]);
        	} 											
		}
		
		//填充下拉框内容
		function getSelOption(){
		
			//端口状态
			s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetObjState',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][1]+">"+res[i][0]+"</option>";
				}
			};
			$("#state").html(s);
		
			//模块局	
			s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetMkj',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][0]+">"+res[i][0]+"</option>";
				}
				$("#mokuaiju").html(s);
			};
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
		/********************* 分页 函数*********************/
		//初始化
		function initPage(){
			$("#QPRows").val(128);
			$("#QPPage").val(1);
		}
		//下一页
		function nextPage(){
			
			var QPPage = $("#QPPage").val();
			var QPRows = $("#QPRows").val();
			var OPcounts = $("#OPcounts").val();
			var startrow = (parseInt(QPPage))*QPRows;
			
			if( startrow<OPcounts ){
				$("#QPPage").val(parseInt(QPPage) + 1);
			}
			else{
				alert("已是最后一页");
				return false;
			}			
			changeData();
		}
		//上一页
		function prePage(){			
			var QPPage = $("#QPPage").val();		
			
			if(QPPage!=1){
				$("#QPPage").val(parseInt(QPPage) - 1);
			}
			else{
				alert("已是第一页");
				return false;
			}			
			 changeData();
		}
		
		function changeData(){
			var type = $("#QPtype").val();
			var devid = $("#QPDevid").val();
			var devname = $("#QPDevName").val();			
			queryDevice_Port(devid, devname ,type );
		}
		//显示 隐藏分页按钮
		function setPageButton(type){
			if(type =='show'){
				$("#preBut").show();	
				$("#nextBut").show();
			}else if(type =='hide'){
				$("#preBut").hide();	
				$("#nextBut").hide();
			}
		}
		
	</script>
	<style type="text/css">
		.neirong .middd{
			width:99.8%;
			height:100%;
			float:left;
			border-right:1px solid #60b2e3;
			border-left:1px solid #60b2e3;
			border-bottom:1px solid #60b2e3;
		}
		.tsdbutton_add{
			padding:1px 1px 1px 1px;  
			height:23px; 
			margin-top:1px;
			margin-left:5px; 
			background: url(style/images/public/buttonbg.jpg) repeat-x; 
			border: #CCCCCC 1px solid; 
			cursor: pointer; 
		}
		.yhy_spanred{
			color: red;
			display: block;
			float: right;
			clear: both;
		}
		.midd_div{
			width:390px; 
			margin-top:10px;
		}
		.midd_span{
			width:60px; 
			text-align:right;
			float:left;
		}
		.helpCss{
			color:red;
		}
	</style>
</head>

	<div class="neirong" id="divRouteAddBj" style="width:480px;height:180px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Detail_Title">对象信息</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="setTimeout($.unblockUI,15);unLockAirUser();"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		
		<div class="middd" style="background-color:#FFFFFF;"> <br />
			<div style="overflow:hidden;">
				<table id="grid_bj_add" class="scroll" cellpadding="0" cellspacing="0" ></table>
				<div id="pager_bj_add" class="scroll" style="text-align:left;"></div>
			</div>						
		</div>
			
		<div class="midd_butt" style="height:38px;">
			<button onclick="javascript:setTimeout($.unblockUI,15);unLockAirUser();" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>			
		</div>
	</div>	
	<div id="maxpanels" class="maxpanel" style="display: none">
	</div>
	

<div class="neirong" id="divRouteAdd"
	style="width: 760px; display: none">
	<div class="top">
		<div class="top_01" id="thisdrag">
			<div class="top_01left">
				<div class="top_02">
					<img src="style/images/public/neibut01.gif" />
				</div>
				<div class="top_03" id="titlediv">
					<span id="Detail_Title">对象信息</span>
				</div>
				<div class="top_04">
					<img src="style/images/public/neibut03.gif" />
				</div>
			</div>
			<div class="top_01right">
				<a href="javascript:;" onclick="javascript:$('#divRouteAdd').hide();unLockAirUser();"><fmt:message
						key="global.close" />
					<!-- 关闭 -->
				</a>
			</div>
		</div>
		<div class="top02right">
			<img src="style/images/public/toptiaoright.gif" />
		</div>
	</div>
	<div style="background-color: #FFFFFF; align: center; width: 760px;">
		<table border="1" cellpadding="0" bordercolor="#9AC0CD"
			style="height: 100%; width: 100%;">
			<tr>
				<td>
					<!-- 设备列表 -->
					<table id="grid_device" class="scroll" cellpadding="0"
						cellspacing="0"></table>
					<div class="helpCss">提示：不支持双击和拖放操作，请选择名称，然后点击“移入”进行配线。</div>
					
				</td>
				<td>
					<!-- 移入按钮 -->
					<button id="add"
						style="width: 40px; height: 36px; cursor: pointer;"
						onclick="addDeviceNode();">
						移入
						<br />
						☞
					</button>
				</td>
				<td>
					<!-- 具体配线信息 -->
					<table id="grid_newroute" class="scroll" cellpadding="0"
						cellspacing="0"></table>
					<div id="pager_newroute" class="scroll" style="text-align: left;"></div>
					<div class="helpCss">提示：请双击“设备类型”进行端口配置。</div>
				</td>
				<td style="display: none;">
					<!-- 导入按钮 -->
					<button id="add"
						style="width: 40px; height: 36px; cursor: pointer;margin-bottom: 30px;"
						onclick="addOneTempNode();">
						移入
						<br />
						☜
					</button>
					<!-- 导入按钮 -->
					<button id="add"
						style="width: 40px; height: 36px; cursor: pointer;"
						onclick="addTempNode();">
						导入
						<br />
						☜☜
					</button>
				</td>
				<td style="display: none;">
					<!-- 设备模板 -->
					<table id="grid_routetemp" class="scroll" cellpadding="0"
						cellspacing="0"></table>
					<div class="helpCss">提示：不支持双击和拖放操作，请选择名称，然后点击“移入”进行配线。</div>
				</td>
				<td style="display: none;">
					<!-- 临时配线信息 -->
					<table id="grid_BindRoute" class="scroll" cellpadding="0"
						cellspacing="0"></table>
					
				</td>
			</tr>
		</table>
	</div>
	<div class="midd_butt" style="height: 38px;">
		<span id="dhvaluets" style="float: left;color:#000099;font-weight:bold;"></span>
		<button onclick="save($('#Flag').val());" class="tsdbutton"
			style="margin-left: 20px;">
			保存
		</button>
		<button onclick="javascript:$('#divRouteAdd').hide();unLockAirUser();"
			class="tsdbutton" style="margin-left: 20px;">
			取消
		</button>
	</div>
</div>
<!-- 选中具体设备端口面板 -->
<div id="maxpanels" class="maxpanel" style="display: none">
</div>
<div class="neirong" id="divtree"
	style="margin-left: 50px; margin-top: 20px; width: 850px; display: none;z-index:2001; ">
	<div class="top">
		<div class="top_01" id="thisdrag">
			<div class="top_01left">
				<div class="top_02">
					<img src="style/images/public/neibut01.gif" />
				</div>
				<div class="top_03" id="titlediv">
					<span>请选择设备端口</span>
				</div>
				<div class="top_04">
					<img src="style/images/public/neibut03.gif" />
				</div>
			</div>
			<div class="top_01right">
				<a href="javascript:;" onclick="hidetree();"> <fmt:message
						key="global.close" />
					<!-- 关闭 --> 
				</a>
			</div>
		</div>
		<div class="top02right">
			<img src="style/images/public/toptiaoright.gif" />
		</div>
	</div>

	<div class="midd"
		style="background-color: #FFFFFF; text-align: left; height: 320px;">
		<div id="input-Unit">
			<div id="tree" class="ztree" 
				style="float: left; height: 310px; overflow: auto; width: 200px;">
				<ul style="height: auto;width: auto;"></ul>
			</div>
			<div
				style="float: left; height: 320px; overflow-y: auto; overflow-x: hidden; width: 3px; background-color: gray">
			</div>
			<div style='width:550px;line-height:30px;'><span>端口名称</span>
				<input type='text' id='devnameText' style='width:150px;' />
				<button id='devnameQbtn' onclick='selPortByName(2);' class='tsdbutton' 
						style='width:60px;line-height:25px; margin-top: 3px; padding: 0px;'>精确查询</button>
				<button id='devnameQbtn' onclick='selPortByName(1);' class='tsdbutton' 
						style='width:60px;line-height:25px; margin-top: 3px; padding: 0px;'>模糊查询</button>		
				<div class="helpCss">提示：快速定位功能供对端口较为熟悉的人使用。</div>								
			</div>
			<div id="pagered1"
				style="float: left; height: 230px; overflow-y: auto; overflow-x: auto;">
				<div style='width: 550px;'>
					请选择模块对象，以显示其中的端子。
				</div>
			</div>
			<div id="porticon" style="margin-top: 0px; font-weight: bold;width: 520px;height: 35px;">
				<div
					style="width: 200px;float: left;font-weight: lighter;cursor: hand;">
					<button id='preBut' onclick='prePage();' class="tsdbutton_add">
					上一页
					</button>
					<button id='nextBut' onclick='nextPage();' class="tsdbutton_add">
					下一页
					</button>
					<button  id='addPort' onclick='addPort(currNode);' 
						class="tsdbutton_add" >
						新增端口 
					</button>									
				</div>			    
				<div id="lblhint" style="width: 320px;float: right;text-align: left;"></div>
			</div>
		</div>

	</div>
	<div class="midd_butt" style="height: 38px;">
		<button id="hthChooseFormSave" onclick="selectedport();"
			class="tsdbutton" style="margin-left: 20px;">
			确定
		</button>
		<button onclick="hidetree();" class="tsdbutton"
			style="margin-left: 20px;">
			取消
		</button>
	</div>
</div>
<!-- 页面操作说明 start -->
<div class="neirong" id="Explanation"
	style="margin-left: 150px; margin-top: 100px; width: 400px; display: none; z-index: 2001;">
	<div class="top">
		<div class="top_01" id="thisdrag">
			<div class="top_01left">
				<div class="top_02">
					<img src="style/images/public/neibut01.gif" />
				</div>
				<div class="top_03" id="titlediv">
					<span>页面操作说明</span>
				</div>
				<div class="top_04">
					<img src="style/images/public/neibut03.gif" />
				</div>
			</div>
			<div class="top_01right">
				<a href="javascript:;" onclick="showWExplanation(1);">
				 <fmt:message key="global.close" />
					<!-- 关闭 --> 
				</a>
			</div>
		</div>
		<div class="top02right">
			<img src="style/images/public/toptiaoright.gif" />
		</div>
	</div>
	<div class="midd"
		style="background-color: #FFFFFF; text-align: left; height: 150px;overflow-y:auto;overflow-x:hidden; ">
		<div id="input-Unit" style="text-align: left;width: 380px;">
			<p>【配线模板-移入】选中“配线模板”中的设备，点击“移入”将该设备移入“用户配线”面板</p>
			<p>【配线模板-导入】选中“配线模板”中的设备，点击“导入”将模板上所有设备移入“用户配线”面板</p>
			<p>【配线设备列表-移入】选中“配线设备列表”中的设备，点击“移入”将该设备移入“用户配线”面板</p>
			<p>【设置设备端口】在“用户配线”区域双击要进行设置的设备，弹出端口选择面板</p>
			<p>【上移】往上移动选择的用户配线设备一个距离</p>
			<p>【下移】往下移动选择的用户配线设备一个距离</p>
			<p>【删除】删除选择的用户配线设备</p>
			<p>【清空】清空当前用户配线表格中的所有设备</p>
			<p>【清空内容】清空选择的用户配线设备端口信息</p>			
		</div>

	</div>	
</div>
<!-- 页面操作说明 end -->

<input type="hidden" id="routeAdd_dh" />
<input type="hidden" id="routeAdd_routeType" />
<input type="hidden" id="routeAdd_lineno" />
<input type="hidden" id="routeAdd_mkj" />
<input type="hidden" id="routeAdd_table" />
<input type="hidden" id="Flag" />
<input type="hidden" id="editgridid" />
<input type="hidden" id="thenodename" />
<input type="hidden" id="thenodeno" />
<input type="hidden" id="queryDevid" />
<!-- 用于分页显示 -->
<input type="hidden" id="QPRows"  value="128"/>
<input type="hidden" id="QPPage" value="1"/>
<input type="hidden" id="OPcounts" />

<input type="hidden" id="QPtype" />
<input type="hidden" id="QPDevid" />
<input type="hidden" id="QPDevName"/>
<!-- 新增端口 -->
	<div class="neirong" id="divDetail" style="width:500px;display: none;z-index:2001;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Detail_Title">设备信息</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#divDetail').hide();"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;"> <br />
			<div id="devname_d_D" class="midd_div" >
				<span class="midd_span" >设备名称:</span>
				<input type="text" id="devname_d" style="width:300px;"/>
				<span class="yhy_spanred">*</span>
				<span id="nodeExplain" style="color: red;margin-left: 2px;width: 187px;text-align: left;">
					在同一个设备下设备端口的名称不能重名。
				</span>
				<input type="hidden" id="devnameOld_d"/>
				<input type="hidden" id="pdevno"/>
			</div>	
			<div id="state_D" class="midd_div">
				<span class="midd_span">状态:</span>
				<select id="state" style="width:302px;"></select>
			</div>
			<div id="mokuaiju_D" class="midd_div">
				<span class="midd_span">模块局:</span>
				<select id="mokuaiju"  style="width:302px;"></select>
			</div>				
			<div id="memo_d_D" class="midd_div">
				<span class="midd_span">备注:</span>
				<input type="text" id="memo_d" style="width:300px;" />
			</div>							
		</div>		
		<div class="midd_butt" style="height:38px;">  
			<button onclick="saveDetail(1);" class="tsdbutton" 
				style="margin-left: 20px;">
				保存
			</button>
			<button onclick="javascript:$('#divDetail').hide();" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>			
		</div>
	</div>