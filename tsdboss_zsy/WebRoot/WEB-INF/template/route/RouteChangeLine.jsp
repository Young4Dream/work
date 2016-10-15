<br>
&gt;
<%----------------------------------------
	name: RouteChangeLine.jsp
	author: yhy
	version: 1.0 
	description: 号线路由管理-电话号线互换
	Date: 2012-12-27
	modify:
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
	<script type="text/javascript">
		/**
		* 打开电话互换面板
		**/
		function changeRoute(dh,key2,MoKuaiJu,linenum){
			
			clearChangePan();
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
					alert("您没有该模块电话互换权限。");
					return ;
				}//end if:isRight;
			}
			
			//锁定该电话的该线路，防止多人设置同一条号线
			var flag = lockAirUser(dh , linenum);
			if( flag == false){ 
				return;
			}	
			
			$("#changeDhFrom").text(dh);	
			showRouteForC(dh,linenum,'grid_Aroute');
			$("#changeLinenumFrom").val(linenum);
			$("#divRouteChange").show();	
		}
		/******************************************
		*电话号线互换面板情况
		* 描述：清空显示具体配线jqgrid 清空电话 清空电话linenum
		******************************************/
		function clearChangePan(){
			$('#grid_Aroute').clearGridData();
			$('#grid_Broute').clearGridData();
			
			$("#changeDhFrom").text("");
			$("#changeDhTo").val("");
			
			$("#changeLinenumFrom").val("");
			$("#changeLinenumTo").val("");			
		}
		/******************************************
		*显示互换电话号线信息
		* params :	dh : 电话
		  			linenum： 号线序号
		******************************************/
		function showRouteForC(dh,linenum,jqgridid){				
			
			//相应号线类型号线信息表名					
			var rowidUser = $("#grid_user").getGridParam("selrow");//选中的用户号线信息的rowid号			
			var tableName = $("#grid_user").getCell(rowidUser,'table_route_name');			
			$('#routeAdd_table').val(tableName);
			
			$('#'+jqgridid).clearGridData();			
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.QueryRouteForUpdate','', 'route');
			urlstr += '&tablename='+tableName+'&dh='+tsd.encodeURIComponent(dh)+'&lineno='+linenum;
			$('#'+jqgridid).setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");				
		}
		
		//初始化路由表格(air_route_xxx)
		function initGrid_changeRoute(gridid,pagerid){			
			jQuery('#'+gridid).jqGrid({				
				height:255,	  	
				width:300,
				datatype: "xml",
			   	colNames:['', 'id1','设备类型', '设备名称', 'id3','端口名称'],
			   	colModel:[			        
			        {name : 'routeno', index : 'routeno', width : 25,hidden:true},
			        {name : 'id1', index : 'id1',hidden:true},
			        {name : 'name1', index : 'name1',width:100},
			        {name : 'name2', index : 'name2',width:120},
			        {name : 'id3', index : 'id3',hidden:true},
			        {name : 'name3', index : 'name3',width:110}			        			        		
			   	],
			   	imgpath: gridimgpath,			   	
			   	sortname: 'routeno',
			    viewrecords: false,
			    sortorder: "asc",
				multiselect:false,
				useDefault:true,
				pager: jQuery('#'+pagerid),
				pgbuttons: false,
				pginput: false,
				loadComplete: function() { 					

				},				
				caption:"配线"			
			});
			
		}
		/*
		*查询被互换电话信息
		*/
		function queryDhTo(){
			//被互换电话为空验证
			var flag = DomIsNull('changeDhTo','请您输入查询号码。');
			if( flag == false){
				return false;
			}
			
			var dh = strtrimB($("#changeDhTo").val());			
			var linenum ='';
			//查询电话linenum
			var urlstr = '&dh='+tsd.encodeURIComponent(dh);
			var res = fetchMultiArrayValue('dbsql_route.QueryLinenoCha',6,urlstr,'route');
			//获取改电话配线信息
			if (res != undefined && res!="" && res.length>0){
				linenum = res[0][0];
				showRouteForC(dh,linenum,'grid_Broute');
				$("#changeLinenumTo").val(linenum);
			}else{
				alert("该电话目前没有号线信息。");
			}		
		}
		/*******************************
		*单行互换
		* 描述：只有相同设备才能进行设备互换，不同设备之间不能进行互换；
		********************************/
		function changeOne(){
			//获取选择设备的id
			var rowidFrom = $('#grid_Aroute').getGridParam("selrow");
			var rowidTo = $('#grid_Broute').getGridParam("selrow");	
			//择需要进行互换的设备信息		
			if(rowidFrom==null || rowidTo==null){
				alert("请选择需要进行互换的设备信息。");
			}
			
			//获取选中设备的设备数据
			var dataFrom = $('#grid_Aroute').getRowData(rowidFrom);
			var dataTo = $('#grid_Broute').getRowData(rowidTo);
			
			//只有相同设备才能进行设备互换，不同设备之间不能进行互换。
			var deviceTypeFrom = dataFrom.name1;
			var deviceTypeTo = dataTo.name1;
			if(deviceTypeFrom == deviceTypeTo){
				//进行两个电话选中单个设备数据将换
				$('#grid_Aroute').setRowData(rowidFrom , dataTo);
				$('#grid_Broute').setRowData(rowidTo ,dataFrom);
			}else{
				alert("只有相同设备才能进行设备互换，不同设备之间不能进行互换。");
			}		
		}
		/*全部互换*/
		function changeAll(){
			var dataFrom = getJQgridAllData("grid_Aroute");
			var dataTo = getJQgridAllData("grid_Broute");			
			
			//当其中一个电话的配线为空，则不能进行号线互换			
			var lenFrom = dataFrom.length;
			var lenTo = dataTo.length;
			if(lenFrom==0 || lenTo ==0 ){
				alert("互换配线为空，不能进行互换。");				
			}else{
				$("#grid_Aroute").clearGridData();			
				$("#grid_Broute").clearGridData();
				//将两个电话的配线设备进行互换
				//由于jqgrid的数据信息的rowid是从1开始的，所以此处的i的开始值设置为1
				var i=0;
				for(i=1 ;i<=lenFrom;i++){
					$("#grid_Broute").addRowData(i,dataFrom[i-1]);
				}
				
				for(i=1 ;i<=lenTo;i++){
					$("#grid_Aroute").addRowData(i,dataTo[i-1]);
				}
			}				
		}
		
		/*返回指定jqgrid的所有数据*/
		function getJQgridAllData(jqgrid){
			var rowids = getrowid(jqgrid);
			var onedata ;
			var dataArray = new Array();
			for(var i=1 ; i <rowids;i++){
				onedata = $("#" +jqgrid).getRowData(i);
				dataArray[i-1]=onedata;
			}
			return dataArray;
		}
		/*****************************
		* 保存电话互换信息
		*****************************/
		function saveChangeRoute(){
			//被互换电话为空验证
			var flag = DomIsNull('changeDhTo','请您输入查询号码。');
			if( flag== false){
				return false;
			}
			
			//互换配线为空，不能进行互换
			var rowsFrom = getrowid("grid_Aroute")-1;
			var rowsTo = getrowid("grid_Broute")-1;	
			if(rowsFrom==0 || rowsTo ==0 ){
				alert("互换配线为空，不能进行互换。");	
				return false;
			}
			
			//您确定要进行保存操作
			if (!confirm("您确定要进行电话号线互换吗？")){
				return false;
			}
			
			var param = '';//参数拼接
			var table = $('#routeAdd_table').val();//相应业务类型号线信息表名
			var dhFrom = $('#changeDhFrom').text();
			var dhTo = strtrimB($('#changeDhTo').val());
			var lineFrom = $('#changeLinenumFrom').val();
			var lineTo = $('#changeLinenumTo').val();	
			param += "&table=" + table;
			param += "&dhFrom=" + dhFrom;
			param += "&dhTo=" + dhTo;
			param += "&lineFrom=" + lineFrom;
			param += "&lineTo=" + lineTo;
			param += "&optype=change";
			
			//获取电话号线设备端口编码信息
			var portnoFrom = getPortNos("grid_Aroute");
			var portnoTo = getPortNos("grid_Broute");			
							
			param += "&portnoFrom=" + portnoFrom ;
			param += "&portnoTo=" + portnoTo ;
			//执行插入操作
			var res = fetchMultiPValue("air_route_change",6,param);
			if(res[0][0]=="SUCCEED"){        	             				
				alert("电话号线互换成功！");				
				//主页面中显示增加的路由
				var table = $("#routeAdd_table").val();
				query_route(dhFrom, table);
				$("#grid_user").trigger("reloadGrid");
				//关闭编辑页面
				$("#divRouteChange").hide();																		
        	}
        	else{
        		alert("电话号线互换失败！\r\n\n错误消息："+res[0][1]);
        	}
        	//清除被锁定账号线路
			unLockAirUser();
		}
		
		/***************************
		*获取jqgrid中的所有记录的portno 值，用逗号隔开个值，并拼接为 0001,0002字符串；
		***************************/
		function getPortNos(jgrid){
			var portnos = '';
			var portno = "";		//端口编号
			//获取路由表格的总行数
			var therow = document.getElementById(jgrid).rows;			
			
			//获取当前grid的id号数组
			var ids = $('#'+jgrid).getDataIDs();	
			for (var i=0; i< ids.length; i++)
			{				
				//配线面板中如果有为设置具体端口的设备，则忽略该设备
				portno = $('#'+jgrid).getRowData(ids[i]).id3;
                if( undefined != portno && portno != ''){
                	portnos += portno + ",";
                }                     
			}
			
			//去掉最后一项的逗号
			if (portnos != ""){
				portnos = portnos.substr(0, portnos.length-1);
			}
			return portnos;
		}
		
		
		
		/***************************
		* 标签元素为空验证
		***************************/
		function DomIsNull(id,info){
			var dh = strtrimB($("#"+id).val());
			if(dh=='' || undefined==dh){
				alert(info);
				$("#"+id).focus();
				return false;
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
		.divTreeEx{
			bottom:0px;
			right:0px; 
  			width:100%;
  			color:red;
  			margin-top:3px;
		}
	</style>
</head>
<!-- 电话号线互换 -->
<div class="neirong" id="divRouteChange"
	style="width: 760px; display: none">
	<div class="top">
		<div class="top_01" id="thisdrag">
			<div class="top_01left">
				<div class="top_02">
					<img src="style/images/public/neibut01.gif" />
				</div>
				<div class="top_03" id="titlediv">
					<span id="Detail_Title">电话号线互换</span>
				</div>
				<div class="top_04">
					<img src="style/images/public/neibut03.gif" />
				</div>
			</div>
			<div class="top_01right">
				<a href="javascript:;" onclick="javascript:$('#divRouteChange').hide();unLockAirUser();"><fmt:message
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
					<div style="margin-left: 20px;height: 40px;line-height: 40px;">
						互换电话:
						<span id="changeDhFrom"  style="width:145px;"></span>
						<input type="hidden" id="changeLinenumFrom"/>
					</div>
					<!-- 具体配线信息 -->
					<table id="grid_Aroute" class="scroll" cellpadding="0"
						cellspacing="0"></table>
					<div id="pager_Aroute" class="scroll" style="text-align: left;"></div>
				</td>
				<td align="center" style="vertical-align:middle;width: 60px;">
					<!-- 单条换号按钮 -->
					<button id="add"
						style="width: 40px; height: 36px; cursor: pointer;margin-bottom:30px;display: block;"
						onclick="changeOne();">
						单条
						<br />
						☜ ☞
					</button>
					
					<!-- 全部互换按钮 -->
					<button id="add"
						style="width: 45px; height: 36px; cursor: pointer;display: block;"
						onclick="changeAll();">
						全部
						<br />
						☜☜ ☞☞
					</button>
				</td>
				<td >
					<div  style="margin-left: 20px;height: 40px;line-height: 40px;">
						被互换电话:
						<input type="text" id="changeDhTo"  style="width:145px;"/>
						<input type="hidden" id="changeLinenumTo"/>
						<input class="tsdbutton" type="button" value="查询" onclick="queryDhTo();" />
					</div>
					<!-- 具体配线信息 -->
					<table id="grid_Broute" class="scroll" cellpadding="0"
						cellspacing="0"></table>
					<div id="pager_Broute" class="scroll" style="text-align: left;"></div>
				</td>				
			</tr>
			<tr>
				<td colspan='3' >
					<div class="divTreeEx">            	
						<span style="font-weight: bold; ">说明：</span>
						<span>只有相同设备才能进行设备互换，不同设备之间不能进行互换。</span>
		            </div>			
				</td>
			</tr>
		</table>
	</div>
	<div class="midd_butt" style="height: 38px;">
		<button onclick="saveChangeRoute();" class="tsdbutton"
			style="margin-left: 20px;">
			保存
		</button>
		<button onclick="javascript:$('#divRouteChange').hide();unLockAirUser();"
			class="tsdbutton" style="margin-left: 20px;">
			取消
		</button>
	</div>
</div>