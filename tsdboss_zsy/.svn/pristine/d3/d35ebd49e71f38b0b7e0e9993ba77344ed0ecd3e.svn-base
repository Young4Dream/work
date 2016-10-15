<%----------------------------------------
	name: PortQuery.jsp
	author: youhongyu
	version: 1.0 
	description: 号线端口查询 
	Date:2012-8-29
	modiry：
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
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	//国际化
	String languageType = (String) session.getAttribute("languageType");
	if (!languageType.equals("en")) {
			languageType = "zh";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery.layout.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script> 
	
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>			
	<!-- 页面权限控制 -->
    <script type="text/javascript" src="script/public/tsdpower.js"></script>
    <script type="text/javascript" src="script/public/main.js"></script>
    <script type="text/javascript" src="script/public/mainStyle.js"></script>
    <script type="text/javascript" src="script/public/transfer.js"></script>	    
    <script type="text/javascript" src="script/public/revenue.js" ></script> 
    <script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>	

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
		
		$(document).ready(function () {
			$("#navBar").append(genNavv());
			//设置配线面板可拖拽
			$("#divRoute").draggable();
		
			/***************************************
			           设置权限
				
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
			***************************************/	
			//初始化端口信息jqgrid
			refreshPortGrid();
			//利用布局控件设置布局			
			mylayout = $('body').layout({ 
				applyDefaultStyles: true,
				west__size:550,
				center__resizable:false,
				north__resizable:false,
				south__resizable:false,
				north__closable:false,
				east__closable:false,
				south__closable:false,
				center__closable:false,									
				spacing_open:1										
			});		
			
			
			//初始化设备列表
			initDevList();
			
			//绑定查询方式变更事件
			$("#queryPortField").change(function(){
				if($(this).val()=="4")
				{
					$("#query_by_nodename").css("display","inline");
					$("#query_by_nodenamefw,#query_by_dh").css("display","none");
				}
				else if($(this).val()=="5")
				{
					$("#query_by_nodenamefw").css("display","inline");
					$("#query_by_nodename,#query_by_dh").css("display","none");
				}
				else if($(this).val()=="6" || $(this).val()=="7" || $(this).val()=="8" )
				{
					$("#query_by_dh").css("display","inline");
					$("#query_by_nodename,#query_by_nodenamefw").css("display","none");
				}
				else
				{
					$("#query_by_nodename,#query_by_nodenamefw,#query_by_dh").css("display","none");
				}
			});
			
			setTimeout('$("#queryPortField").val(0)',300);												
		});
		
       
		//初始化设备类型
		function initDevList(){
			var optionStr = "";
			 
			var res = fetchMultiArrayValue('dbsql_route.PQ.QueryDevice_Master',6,'','route');
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					optionStr += "<OPTION value='" + res[i][0] + "'>" + res[i][1] + "</OPTION>";
				}
			};
			$("#devList").html(optionStr);
		}
		
		//清空查询条件
		function clearContext(){
			$("#queryPortField").val("");
			$("#hx_nodename").val("");
			$("#hx_nodename_from").val("");
			$("#hx_nodename_to").val("");
			$("#hx_dh").val("");
		}
		
		/**
		  查询参数拼接
		  参数： type 1=精确查询 2=模糊查询
		*/		
		function buildParams(type){
			tsd.QualifiedVal=true; 	//每次拼接参数必须初始化此参数
			
			var params ='' ;
			var queryWhere ='' ;		
			
			//1.根据号线设备类型编号，获取该号线类型号线端口的编码长度
			var devno = $("#devList").val();
			queryWhere = " devno like '" + devno + "%' ";
			
			//2.根据查询条件进行查询
			var queryPortField = $("#queryPortField").val();
			var hx_nodename = $("#hx_nodename").val();
			var hx_nodename_from = $("#hx_nodename_from").val();
			var hx_nodename_to = $("#hx_nodename_to").val();
			var hx_dh = $("#hx_dh").val();
				
			//params += "&devno=" + encodeURIComponent(devno);
			if( queryPortField==0 ){
				queryWhere += " and 1=1 ";
			}
			else if( queryPortField==1 ){
				queryWhere += " and STATE='using' ";
			}
			else if( queryPortField==2 ){
				queryWhere += " and STATE='free' ";
			}
			else if( queryPortField==3 ){
				queryWhere += " and STATE='bad' ";
			}
			else if( queryPortField==4 ){
				//非空验证
				if (NullCheck("#hx_nodename", "端口名称")) {return false};
				if( type==1 ){
					queryWhere += " and lower(DEVNAME)=lower('" + hx_nodename + "') ";	
				}else{
					queryWhere += " and lower(DEVNAME) like lower('%" + hx_nodename + "%') ";	
				}
			}
			else if( queryPortField==5 ){
				//非空验证
				if (NullCheck("#hx_nodename_from", "端口范围开始值")) {return false};
				if (NullCheck("#hx_nodename_to", "端口范围截止值")) {return false};
				queryWhere += " and DEVNAME >='" + hx_nodename_from + "' and DEVNAME <= '" + hx_nodename_to + "' " ;
			}else if( queryPortField==6 ){ //绑定电话查询
				//非空验证
				if (NullCheck("#hx_dh", "绑定电话查")) {return false};
				if( type=='1' ){
					queryWhere += " and DH='" + hx_dh + "'";
				}else{
					queryWhere += " and DH like '%" + hx_dh + "%' ";	
				}
			}else if( queryPortField==7 ){//号线电话账号查询
				//非空验证
				if (NullCheck("#hx_dh", "号线电话账号")) {return false};
				if( type=='1' ){
					queryWhere += " and phone='" + hx_dh + "'";
				}else{
					queryWhere += " and phone like '%" + hx_dh + "%' ";	
				}
			}else if( queryPortField==8 ){//号线宽带账号查询
				//非空验证
				if (NullCheck("#hx_dh", "号线宽带账号")) {return false};
				if( type=='1' ){
					queryWhere += " and broadband='" + hx_dh + "'";
				}else{
					queryWhere += " and broadband like '%" + hx_dh + "%' ";	
				}
			}
		
			//获取当前设备端口编码的长度
			var urlstr = '&devid='+tsd.encodeURIComponent(devno);
			var portLen = fetchSingleValue('dbsql_route.PQ.PortLen',6,urlstr,'route');
						
			//执行查询操作
			queryWhere = queryWhere + " and length(devno)='" + portLen + "'";
			params = "&queryWhere=" + encodeURIComponent(queryWhere);
			params = params + "&cols=" + encodeURIComponent(gridDat.FieldName.join(",")) ;
			
			if(tsd.Qualified()==false){return false;}
			
			return params;
		}
		/*
		端口查询
		参数： type 1=精确查询 2=模糊查询
		*/
		function queryPort(type)
		{		
			var params =buildParams(type) ;	
			if(params==false){return false;}
			/*
			+ "&userid=" + encodeURIComponent($("#userid").val()) 			
			+ "&cols1=" + encodeURIComponent(gridDat.FieldName.join(",").replace('nodestate',"case when 'using' then '占用' when 'free' then '空闲' when 'bad' then '损坏' else nodestate end nodestate"))
			*/			
			var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'route',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'dbsql_route.PQ.QueryPort',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'dbsql_route.PQ.QueryPortC'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			$("#maingrid").setGridParam({"url":'mainServlet.html?'+urlstr + params}).trigger("reloadGrid");
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
		//jqgrid全局变量
		var gridDat	;
		//初始化端口信息列表
		function refreshPortGrid(){
				gridDat = loadData("vw_air_device_detail","<%=languageType%>",1,"查看配线信息");
				gridDat.colModels[0].width=85;
				gridDat.setHidden(["DEVNO"]);
				$("#maingrid").jqGrid({
					url:'',
					datatype: 'xml', 
					colNames:gridDat.colNames, 
					colModel:gridDat.colModels, 
			       	rowNum:100, //默认分页行数
			       	rowList:[30,50,100,1000], //可选分页行数
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#maingridpager'), 
			       	//sortname: 'Hth', //默认排序字段
			       	viewrecords: true, 
			       	sortorder: 'asc',//默认排序方式 
			       	caption:'端口列表',
			       	height:document.documentElement.clientHeight-207, //高
			       	width:document.documentElement.clientWidth-60,
			       	loadComplete:function(){
			       		if($("#maingrid tr.jqgrow[id='1']").html()==""){
							return false;
						}else{
							//addRowOperBtnExtend('maingrid','查看端口配线','openDocumentM','DEVNAME','click',1);
							//executeAddBtn('maingrid',1);
							addRowOperBtn('maingrid', '<img src="style/images/public/ltubiao_01.gif" alt="查看端口配线"/>', 'query_route','DEVNO','click', 1);
           					executeAddBtn('maingrid', 1);
						}					
					},
					onSelectRow:function(idx){
						
					}
				}).navGrid('#maingridpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
				); 
		}
		
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
			
		
		
		/**********************************************************
				配线信息
		********************************************************/
		
		/**********************************************************
				function:		 清空上一次查询用户配线信息
				description:   
		********************************************************/
		function delGrid(){
			 $("#treeGroup").empty();
		}
		
		//查询用户路由表，不同的路由线路独立显示
		function query_route(DEVNO){				
			//清空上一次查询用户配线信息
			delGrid();
			$("#divRoute").show();
			
			//获取该端口的线路序号、账号（电话、宽带）、配线表名数组	
			var urlstr = '&devno='+tsd.encodeURIComponent(DEVNO);			
			var res = fetchMultiArrayValue('dbsql_route.PQ.queryRouteLine',6,urlstr,'route');
			
			if (res != undefined && res!="" && res.length>0){	
				//号线序号，循环显示电话的多条配线信息			
				for(var i=0;i<res.length;i++){	
					if(res[i][2]=='air_route_phone'){
						initTree_route( '电话(账号)' ,res[i][2] , res[i][1] , res[i][0] ,i);
					}else if(res[i][2]=='air_route_broadband'){
						initTree_route( '宽带账号' ,res[i][2] , res[i][1] , res[i][0] ,i);
					}										
				}									
			}
			else{				
				var s = "该用户尚未配线！";
				$('#treeGroup').append(s);				
			}			
		}
		
		/***********************
	   	* 配线树组
	   	* @param 	dhtype: 电话 或 宽带;
	   				tablename：配线表：
	   				dh：账号
	   				lineno：配线表中配线序号
	   				num：端口当前配线序号
	   	* @return;
	   ************************/
	   function initTree_route( dhtype, tablename,dh,lineno,num){
	   		//var  treeNode =zTreeObj.getNodeByParam("id", v_devno, nodes[0]);
			//zTreeObj.addNodes(treeNode, devNodes);
			var param = '&tablename='+ tablename +'&dh='+tsd.encodeURIComponent(dh)+'&lineno='+lineno;  
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
						devNode = {"name":res[i][0],"open":true,"icon":"<%=iconpath%>/125.gif",childs:[{"name":res[i][1]}]};
					}
					devNodes.push(devNode);
				}
			};

			var zTreeNodes = [			
				{"name":"配线(" + dhtype + ":" + dh + ")" , open:true, childs: devNodes }
			];			
			$.fn.zTree.init($("#tree"+num), '', zTreeNodes);
																			
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
	<DIV class="ui-layout-center" >
		<div id="input-Unit" style="margin-top: -5px; margin-left: -5px;margin-right: -10px;margin-bottom: -10px;">
 
        	<fieldset style="width:98%">
        		<legend><span style="font-size:14px;">条件查询</span></legend>
		
				<div style="width:100%; height:40px; text-align:left; ">
					号线设备：	
					<select id="devList" style="width: 110px;" >
						 
					</select>
					查询方式:
					<select id="queryPortField" style="width: 110px;" onchange="clearContext();">
						 <OPTION value='0' >所有端口</OPTION> 
						 <OPTION value='1'>查询占用的端口</OPTION> 
						 <OPTION value='2'>查询空闲的端口</OPTION> 
						 <OPTION value='3'>查询损坏的端口</OPTION> 
						 <OPTION value='4'>按端口名称查询</OPTION> 
						 <OPTION value='5'>按端口名称范围查询</OPTION> 
						 <OPTION selected value='6'>按绑定电话查询</OPTION>
						 <OPTION selected value='7'>按号线电话账号查询</OPTION>
						 <OPTION selected value='8'>按号线宽带账号查询</OPTION>
					</select>
					<div id="query_by_nodename" style="display: none;">
						<input type="text" id="hx_nodename" />
					</div>
					<div id="query_by_nodenamefw" style="display: none;">
						<input type="text" id="hx_nodename_from" />
						至
						<input type="text" id="hx_nodename_to" />
					</div>
					<div id="query_by_dh" style="display: none;">
						<input type="text" id="hx_dh" />
					</div>
					<input  class="tsdbutton" type="button" value="精确查询" onclick="queryPort(1);"/>
					<input  class="tsdbutton" type="button" value="模糊查询" onclick="queryPort(2);"/>
				</div>
			</fieldset>
			<div style="clear:both;float:left;">
	 			<table id="maingrid" class="scroll" cellpadding="0" cellspacing="0" ></table>
				<div id="maingridpager" class="scroll" style="text-align:left;"></div>			
			</div>           
		</div>
	</DIV>	
		
	<!-- 端口配线信息 start -->
	<div class="neirong" id="divRoute" style="width:500px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Detail_Title">端口配线信息</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="$('#divRoute').hide();"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;"> <br />
			<div id='treeGroup' style="float:left;margin-left: -5px;width: 550px;height: 300px;overflow: auto;">
			
    		</div>				
		</div>		
		<div class="midd_butt" style="height:38px;">  
			<button onclick="javascript:$('#divRoute').hide();" class="tsdbutton"  style="margin-left: 20px;">
				关闭				
			</button>			
		</div>
	</div>		
	<!-- 端口配线信息 end -->
	
	<!-- 用户类型 -->
	<input type="hidden" id="route_ywlx" value="<%=route_ywlx %>"/>
	<!-- 用户账号 -->
	<input type="hidden" id="route_accesstype" value="<%=route_accesstype %>"/>
	<!-- 接入类型 -->
	<input type="hidden" id="route_username" value="<%=route_username %>"/>
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
	
</body>
</thml>