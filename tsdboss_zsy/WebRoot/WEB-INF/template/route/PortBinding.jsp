<%----------------------------------------
	name: PortBinding.jsp
	author: youhy
	version: 1.0 
	description: 自动配线
	Date: 2012-6-13
	自动配线参数：
	opertype=batchadd;bindtype=oneTone;routetype=phone;ndevno=000001.000002;
	pdevno='000002.000002';
	nprefix=01-01-;nbeginid=001;nendid=006;pprefix=01-01-;pbeginid=060;
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
    
    <script type="text/javascript" src="plug-in/jquery/jquery.cookie-min.js"></script>    
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.core-3.0.js"></script>
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.excheck-3.0.min.js"></script>
    <script type="text/javascript" src="plug-in/jquery/zTree/jquery.ztree.exedit-3.0.min.js"></script>    

    <link rel="stylesheet" href="style/zTreeStyle/zTreeStyle.css" type="text/css" />    
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />    	
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
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
			padding-left: 5px;
			padding-right: 10px;
		}
		.tsdbutton_rad{
			width:90px; 
			height:22px;
			background: url(style/images/public/buttonsbg.jpg) repeat-x; 
			border: #CCCCCC 1px solid; 
			cursor: pointer;
		}		 
	</style>
	<script type="text/javascript">
		var zTreeObj;
		var setting = {
			callback: {
				onClick: nodeClick,
				onDblClick: nodeDblClick					
			}
		};
		var gridimgpath = 'plug-in/jquery/jqgrid/themes/basic/images/';
		var mylayout;
		$(document).ready(function () {
			//设置该div可进行拖拽
			$("#divBind_pre").draggable();//设置配线面板可拖拽
			$("#divtree_pre").draggable();//设置配线选择上级端口面板可拖拽
			$("#divBindError").draggable();//设置配线失败面板可拖拽
			
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
			initGrid_Detail();									
			getDict();			
			setGrid_H();
			setTimeout("initGridData();",1);	
			initGrid_BindError();					
		});
		//根据选择的“业务类型”显示设备树
		function showDevice(){
			var routetype = $("#routetype").val();
			initTree(routetype);
		}
		//初始化树形控件
		function initTree(routetype){
			var devNodes = [];
			var devNode;
			//初始化页面的时候，初始化树形控件，由于“业务类型”为空，不需要加载业务类型路由模板查询			
			if( !(routetype === undefined) ){
				var params = '&routetype='+tsd.encodeURIComponent(routetype);
				var res = fetchMultiArrayValue('dbsql_route.PB.QueryDevice_Master',6,params,'route');
				if (res != undefined && res!="" && res.length>0){
					for(var i=0;i<res.length;i++){
						devNode = {"id":res[i][0],"name":res[i][1]};
						devNodes.push(devNode);
					}
				};
			}
			
			var zTreeNodes = [			
				{"name":"号线设备", open:true, childs: devNodes}
			];			
			zTreeObj = $.fn.zTree.init($("#tree"), setting, zTreeNodes);																	
		}
		//树节点单击事件,只有端口信息会显示在右侧列表中
		function nodeClick(event, treeId, treeNode, clickFlag) {
			
			//$("#devDetail").clearGridData();
			var devid = treeNode.id;
			var urlstr = '&devid='+tsd.encodeURIComponent(devid);
			var levelcount = fetchSingleValue('dbsql_route.GetLevelCount',6,urlstr,'route');
			//验证选中是节点下一级是否为端口						
			if (treeNode.level+1==levelcount){
				queryObj(devid);
				$("#devInfoDiv").hide();
				$("#portInfoDiv").show();
			}else{				   
				$("#devInfoDiv").show();
				$("#portInfoDiv").hide();
			}		
			//treeNode.level							
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
			   	colNames:['操作','id','设备名称','状态', '绑定电话', '设备地址', '模块局','上级端口编号','上级端口名称','备注', '图标'],
			   	colModel:[
			   		{name:'viewOperation',index:'viewOperation', width:90},
			   		{name:'devno',index:'devno', hidden:true},
			   		{name:'devname',index:'devname', width:120},
			   		{name:'state',index:'state', width:90},
			   		{name:'dh',index:'dh', width:80},
			   		{name:'addr',index:'addr', width:180, hidden:true},					
			   		{name:'mokuaiju',index:'mokuaiju', width:110},
			   		{name:'pdevno',index:'pdevno', hidden:true},
			   		{name:'ppdevname',index:'ppdevname', width:120},
			   		{name:'memo',index:'memo',width:120},
			   		{name:'devicon',index:'devicon', width:120, align:"center",  hidden:true}		   				
			   	],
			   	rowNum:15,
			   	rowList:[15,30,128],
			   	imgpath: gridimgpath,
			   	pager: jQuery('#pager_devDetail'),
			   	sortname: 'devno',
			    viewrecords: true,
			    sortorder: "asc",
			    pgbuttons: true,
				useDefault:true,
				loadComplete: function() { 	
					addRowOperBtn('devDetail','配线','addBind','devno','click',1,'');
					addRowOperBtn('devDetail','拆线','delBind','devno','click',2);
				  	executeAddBtn('devDetail',2);
				}, 
				onSelectRow: function(ids) {
					//ids是返回的rowid,然后根据它再返回meetid	    
					if(ids != null) {			
					    var devno=jQuery("#devDetail").getCell(ids,'devno');
					    //获取配线路由
					    getBindRoute(devno);					    
					}					    
				}, 
				caption:"端口信息"			
			}).navGrid('#pager_devDetail',
			{refresh: true, edit: false, add: false, del: false, search: false});
		}
	
	
		/*
		* 获取配线路由
		* 参数：端口编号
		*/
		function getBindRoute(DeviceNo){			
			var param = "&DeviceNo="+DeviceNo;
			var res = fetchMultiPValue("RouteManage.AirGetDevnoTree",6,param);
        	if( res != undefined && res != 'undefined' && res != ''){
        		var len = res.length;
        		var info ='';//存放自动配线信息
        		for (var i=0 ; i<len ;i++){
        			//显示 0级设备 1级设备 2级设备 端口名称
        			info += res[i][1]+':'+res[i][2]+':'+res[i][4] + '-->';
        		}        		
				//去掉最后一个'-->'
        		info = info.substr(0,info.lastIndexOf('-->'));
        		$("#divPortBind").html(info);
        	}
		}
		
	
		//根据devid查询air_device_detail表	
		function queryObj(devid){
			$("#devid_level").val(devid);	//存放上级节点的编码方便获取该节点所在设备子树的层次数目
			 
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.PB.QueryDevice','dbsql_route.PB.QueryDevicePage', 'route');
			urlstr += '&devid='+tsd.encodeURIComponent(devid)+'.';
			jQuery("#devDetail").setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");			
		}
		
		
		/**********
		*根据设备编码可以判断当前设备属于该子树的第几层，
		*根据设备树节点的端子编码判断 当前设备所在层数+1 是否等于设备层次数目，
		*	相等：该层为设备端口层
		*	不相等：该层为设备层
		*返回值：相等：true  不相等：false
		************/
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
				
		
		//删除节点后的刷新操作 1.删除树节点 2.刷新表格(tag=1表示删除主记录； =2表示删除明细记录)
		function deleteRefresh(node){
			//获取被删除节点的前一个节点
			var prenode = node.getPreNode();
			//如果前一个节点没空，则返回父节点
			if (prenode==null){
				prenode = node.getParentNode();
			}	
			/**							
			//删除树节点
			zTreeObj.removeNode(node);			
			//节点选中被删除节点的前一个节点(调用该节点的单击事件，以刷新表格)
			zTreeObj.selectNode(prenode, false);			
			nodeClick(null,null,prenode);	
			*/		
		}
				
		//设置明细jqgrid的高度
		function setGrid_H(){			   
		   //70(主页top)+26((系统模块栏))+22(主jqgrid的caption栏，估计)+40(主表格body)+30(主页底部)+24(明细表格工具栏)+其它(约10)(注意，底部有一些空白是padding(5))  
		   var detail_grid_H=document.body.clientHeight-206;
		   jQuery("#devDetail").setGridHeight(detail_grid_H);
		}
		
		//如果根节点的第一个子节点不为空，则选中此节点
		function initGridData(){
			var roots=zTreeObj.getNodes();			
			var nodes=roots[0].childs;			
			if (nodes.length > 0){	
				//如果根节点的第一个子节点不为空，则选中此节点											
				zTreeObj.selectNode(nodes[0], false);				
			}						          	
		}
	
		//弹出查询页面
		function showQuery(){	
			$('#queryvalue').val("");			
			autoBlockFormAndSetWH('divQuery',30,'100px','close',"#ffffff",false,'', '');
			setTimeout("$('#queryvalue').focus();",100);									
		}
		
		
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
				    //号线业务				    
					$("#routetype").html(routetype);
					//$("#routetype").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');
				}		
			});								
		}
		*/
		//填充下拉框内容
		function getDict(){			
			var s="<option value='' selected='true'>--请选择--</option>"
			var res = fetchMultiArrayValue('dbsql_route.GetRouteType',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					s+="<option value="+res[i][1]+">"+res[i][0]+"</option>";
				}
			};
			$("#routetype").html(s);
		}
		//2012-9-4 yhy end
		
		//控件是否为空的检测
		function NullCheck(CtlName, value){
			if ($(CtlName).val() == ""){
				alert(value+"不能为空，请重新填写！");
				$(CtlName).focus();
				return true;
			}
			return false;
		}	
	
				
	</SCRIPT>
  </head>
  
  <body>
    <DIV class="ui-layout-north" style="overflow-x: hidden;overflow-y: hidden;">
		<div id="navBar1" style="margin-left:-10px;margin-right:-10px;margin-top:-10px;margin-bottom:-8px">
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
	<DIV class="ui-layout-west">
		<div id="input-Unit" style="text-align: left;background-color:#FFFFFF;height:30px;" >
			业务类型
			<select id="routetype" style="width: 110px;" onchange="showDevice()">
			</select>
			<ul id="tree" class="ztree"></ul>				
		</div>		
		
	</DIV>		
	<DIV class="ui-layout-center">	
		<div id="input-Unit" style="margin:-10px;text-align: left;padding-top:10px; margin-left:1px; display:inline;">
        	<div id="portInfoDiv" style="display: none;">	
	             <fieldset style="height: 100%;">
				    <legend><span style="font-size:14px;  ">端口信息</span></legend>	
					<input  class="tsdbutton" type="button" value="批量配线" onclick="batchAdd();"/>				
					<input  class="tsdbutton" type="button" value="批量拆线" onclick="batchDel();"/>				
					<input  class="tsdbutton" type="button" value="配线失败信息维护" onclick="showError();" style="width: 130px;" />
	
	           
	 				<table id="devDetail" class="scroll" cellpadding="0" cellspacing="0" ></table>
					<div id="pager_devDetail" class="scroll" style="text-align:left;"></div>        
					<div id="divPortBind"></div>	
	        	</fieldset>
	        </div>
	      
	        <div id="devInfoDiv" align="center" >
	        	<div style='width:300px;' >请选择模块对象，以显示其中的端子。</div>
	        </div>
	        																				
		</div>
	</DIV>	
	<input type="hidden" id="UserId" value="<%= sUserId%>"/>
	<!-- 自动配线管理-配线页面  -->
	<jsp:include page="PortBinding_Bind.jsp"  flush="true" />
	<!-- 自动配线管理-选择上级设备页面  -->
	<jsp:include page="PortBinding_Ptree.jsp"  flush="true" />
	<!-- 操作类型 ：配线 拆线 批量配线 批量拆线 -->	
	<input type="hidden" id="ctlFlag" />
	<!-- 配线 选择端口的上级设备编号 -->
	<input type="hidden" id="preDevno_A"/>
	<!-- 配线 选择端口的上级设备名称  -->
	<input type="hidden" id="preDevName_A"/>
	<!-- 拆线端口编号  -->
	<input type="hidden" id="bindDevno"/>
	<!-- 批量操作本级设备编号  -->
	<input type="hidden" id="batchNDevno"/>
	<!-- 批量操作上级设备编号 -->
	<input type="hidden" id="batchPDevno"/>
	
  </body>
</html>
