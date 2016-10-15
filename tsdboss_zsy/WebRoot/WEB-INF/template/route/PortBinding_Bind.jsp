<br>&gt;<%----------------------------------------
	name: PortBinding_Bind.jsp
	author: youhy
	version: 1.0 
	description: 自动配线管理-配线页面 
	Date: 2012-6-14
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<% 
String languageType = (String) session.getAttribute("languageType");
if (!languageType.equals("en")) {
		languageType = "zh";
}
%>
<head>
	<script type="text/javascript">		
		
		/***********
		* 弹出批量配线面板
		*
		***********/
		function batchAdd(){
			var falg = getBatchDevno();
			if ( falg == false) {return false;}
			//保存操作类型
			$("#ctlFlag").val("batchadd");	
			
			//批量配线 需要填写批量配线方式 本级端口信息 上级端口信息
			$("#batchPan1").show();	
			$("#batchPan2").show();	
			$("#batchPan3").show();	
			$("#divBind_batch #batchTitle").text("批量配线");//标题	
			$("#divBind_batch #bindBtn").text("批量配线");//按钮标题
			autoBlockFormAndSetWH('divBind_batch',30,'100px','close',"#ffffff",false,'', '');			
		}
		/***********
		* 弹出批量拆线面板
		*
		***********/
		function batchDel(){
			var falg = getBatchDevno();
			if ( falg == false) {return false;}
			//保存操作类型
			$("#ctlFlag").val("batchdel");
			
			//批量拆线 只需要填写本级端口信息
			$("#batchPan1").hide();
			$("#batchPan3").hide();	
			$("#batchPan2").show();
			$("#divBind_batch #batchTitle").text("批量拆线");//标题	
			$("#divBind_batch #bindBtn").text("批量拆线");//按钮标题
			autoBlockFormAndSetWH('divBind_batch',30,'100px','close',"#ffffff",false,'', '');
		}
		
		/***********
		* 拆线操作
		*
		***********/
		function delBind(devno){
			//保存操作类型
			$("#ctlFlag").val("del");
			$("#bindDevno").val(devno);	
			updateDetail();	
		}	
		/***********
		* 弹出配线面板		
		*
		***********/
		function addBind(devno){
			var routetype = $("#routetype").val();
			//根据业务类型、选择节点编号 获取上级设备的设备名称和设备编码
			var urlstr = '&devno='+tsd.encodeURIComponent(devno) +'&routetype='+tsd.encodeURIComponent(routetype);			
			var res = fetchMultiArrayValue('dbsql_route.PB.QueryPreNo',6,urlstr,'route');
			if (res != undefined && res!="" && res.length>0){
				$("#preDevno_A").val(res[0][0]);
				$("#preDevName_A").val(res[0][1]);
			}else{
				alert("该设备无上级设备，不能定义上级端口。");
				return;
			}			
			//显示上级设备信息
			$("#ctlFlag").val("add");
			//将本级端口编号缓存起来
			$("#bindDevno").val(devno);
			$("#divBind_pre").show();
			//autoBlockFormAndSetWH('divBind_pre',30,'100px','close',"#ffffff",false,'', '');			
		}
				

		/********************
		* 配线操作
		* 更新air_Device_Detail表
		* ctlFlag : 
		********************/
		function updateDetail(){			
			var infosrt = ''; //操作类型确定提示
			var nDevno = '';//本级端口编码
			var pDevno = '';//上级端口编码
			
			var nPrefix = '';//本级端口前缀
			var nBeginid = '';//本级端口开始值
			var nEndid = '';//本级端口截止值
			var pPrefix = '';//上级端口前缀
			var pBeginid = '';//上级端口开始值
			var bindType ='';//绑定类型
			
			var operType ='';//操作类型
			var routeType ='';//号线类型	
			var autoCompletion = 0;//是否补全 0：不补全  1：补全
			var idlen = 0;//补全长度
			
			operType = $("#ctlFlag").val();				
			routeType = $("#routetype").val();
			
			//根据操作类型获取相关参数 
				//add：配线； del：拆线； batchadd：批量配线； batchdel：批量拆线
			if( operType == 'add' ){ 
				if (NullCheck("#PName", "上级端口")) {
					return false;
				}	
				nDevno = $("#bindDevno").val();
				pDevno = $("#PNode").val();
				infosrt = '配线';
				
			}else if( operType == 'del' ){				
				nDevno = $("#bindDevno").val();
				infosrt = '拆线';
				
			}else if( operType == 'batchadd' ){
				if (NullCheck("#nPrefix", "端口前缀")) {return false;}
				if (NullCheck("#nBeginid", "端口开始值")) {return false;}
				if (NullCheck("#nEndid", "端口截止值")) {return false;}
				if (NullCheck("#pPrefix", "上级端口前缀")) {return false;}
				if (NullCheck("#pBeginid", "上级端口开始值")) {return false;}
				
				
				if ($("#check1").attr("checked")==true){				
					if (NullCheck("#idlen1", "编码长度")) {return};
					autoCompletion = 1;
				}
				idlen = tsd.encodeURIComponent($("#idlen1").val());
				
				nPrefix = tsd.encodeURIComponent($("#nPrefix").val());
				nBeginid = tsd.encodeURIComponent($("#nBeginid").val());
				nEndid = tsd.encodeURIComponent($("#nEndid").val());
				pPrefix = tsd.encodeURIComponent($("#pPrefix").val());
				pBeginid = tsd.encodeURIComponent($("#pBeginid").val());
				bindType = tsd.encodeURIComponent($("#bindType").val());
				
				nDevno = $("#batchNDevno").val();
				pDevno = $("#batchPDevno").val();
				
				infosrt = '批量配线';
			}else if( operType == 'batchdel' ){
				if (NullCheck("#nPrefix", "端口前缀")) {return false;}
				if (NullCheck("#nBeginid", "端口开始值")) {return false;}
				if (NullCheck("#nEndid", "端口截止值")) {return false;}
				
				if ($("#check1").attr("checked")==true){				
					if (NullCheck("#idlen1", "编码长度")) {return};
					autoCompletion = 1;
				}
				idlen = tsd.encodeURIComponent($("#idlen1").val());
				
				nPrefix = tsd.encodeURIComponent($("#nPrefix").val());
				nBeginid = tsd.encodeURIComponent($("#nBeginid").val());
				nEndid = tsd.encodeURIComponent($("#nEndid").val());
				
				nDevno = $("#batchNDevno").val();
				infosrt = '批量拆线';
			}
			 
			//弹出提示按钮，确定进行号线配、拆线操作
			if (!confirm("您确定要进行" + infosrt + "操作吗？")){
				return false ;
			}			
	        
	        //参数拼接
        	var param= '&opertype=' + operType + '&routetype='+routeType + '&bindtype=' + bindType;
			param += '&ndevno=' + nDevno + '&pdevno=' + pDevno;
			param += '&nprefix=' + nPrefix + '&nbeginid=' + nBeginid + '&nendid=' + nEndid ;
			param += '&pprefix=' + pPrefix + '&pbeginid=' + pBeginid ;
			param += '&idlen='+idlen+'&lpad='+autoCompletion;
        	
        	//调用自动配线存储过程实现配、拆线操作
        		//返回值：SUCCEED：配、拆线成功 无配线失败端子
        		//返回值：ERROR：配、拆线成功 有部分配线失败端子
        		//返回值：其他：配拆线失败
        	var res = fetchMultiPValue("PortBinding.AirAutoAssign",6,param);        	      
        	if(res[0][0]=="SUCCEED"){ 
        		if(res[0][1]=="add" || res[0][1]=="batchadd"){
        			alert('配线成功。'); 
        		}else if(res[0][1]=="del" || res[0][1]=="batchdel"){
        			alert('拆线成功。'); 
        		}		
        	}
        	else if (res[0][0]=="FAILED"){
	        	if(res[0][1]=="add" || res[0][1]=="batchadd"){
        			alert('批量配线中有未匹配端口，请查看配线失败信息。'); 
        		}
        	}
        	else{
        		alert("配、拆线失败！请仔细检查填写的数据是否正确。\r\n\n错误消息："+res[0][1]);
        	}
        	
        	//清空操作面板数据
        	resetPan(operType);	
        	//刷新表格(端口信息)
			jQuery("#devDetail").trigger("reloadGrid");	
			
			//关闭本窗口
        	if( operType == 'add' ){
        		$("#divBind_pre").hide();
        	}else{
        		setTimeout($.unblockUI,15); 
        	}
		}
		
		
		/***********
		* 显示上级设备信息	
		*
		***********/
		function showPreInfo(grid){			
			//1.获取上级设备编号 上级设备名称
			//2.初始化上级设备树形控件	
			
			var preDevno = $("#preDevno_A").val()+'.';
			var preDevName = $("#preDevName_A").val();			
			initTree_pre(preDevno, preDevName, ''); 					
			showtree();					
		}
		
		/************
		*根据选中设备 获取本级设备编号 上级设备编号
		*用于批量配线
		************/
		function getBatchDevno(){
			var devno ='';//当前选择设备的编号
			var routeType = $("#routetype").val(); //业务类型
			var nodes=zTreeObj.getSelectedNodes();
        	if (nodes.length>0){
        		devno = nodes[0].id;       		        			        		
        	}
        
			//判断选择的设备在业务类型模板中，是否定义了上级设备
			var urlstr = '&devno='+tsd.encodeURIComponent(devno) +'&routetype='+tsd.encodeURIComponent(routeType);			
			var res = fetchMultiArrayValue('dbsql_route.PB.QueryPreNo',6,urlstr,'route');
			if (res != undefined && res!="" && res.length>0){
				$("#batchPDevno").val(res[0][0]);
				$("#batchNDevno").val(res[0][2]);
			}else{
				alert("该设备未定义上级设备。");
				return false;
			}			
		}
		/************
		* 清空面板
		* 参数operType 操作类型（add：配线； del：拆线； batchadd：批量配线； batchdel：批量拆线）
		************/
		function resetPan(operType){
			if (operType == 'add')
				{
					//清空配线面板 
					$("#divBind_pre :text").val(""); 
				}else if (operType == 'batchadd' || operType == 'batchdel'){	
					//清空批量配、拆线面板 
					$("#divBind_batch :text").val("");
					$("#divBind_batch select").val("");
					$("#divBind_batch [name='check1']").removeAttr("checked");//取消全选					
				}		   
		}
		
		/////////////////////////////////////////////////////////
		///////////////   配线失败信息展示 start   /////////////////
		/////////////////////////////////////////////////////////
		//弹出配线失败信息
		function showError(){
			var routetype = $("#routetype").val();
			fillGridError(routetype);
			$("#divBindError").show();	
			//autoBlockFormAndSetWH('divBindError',30,'100px','close',"#ffffff",false,'', '');												
		}
		/*
		* 获取配线路由
		* 参数：端口编号
		*/
		function fillGridError(routetype){	
			var urlstr = buildParamsSqlByS('tsdBilling','query','xml','dbsql_route.PB.QueryError','dbsql_route.PB.QueryErrorPage', 'route');
			urlstr += '&routetype='+tsd.encodeURIComponent(routetype);
			$("#bindError").setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
		}
		
		//初始化自动配线表格(air_route_xxx)
		function initGrid_BindError(){
			//devno,pdevno,breason,status,bdate,memo,operdate,oper,routetype
			jQuery("#bindError").jqGrid({  	
				datatype: "xml",
			   	colNames:['操作','ID','端口编号','端口名称','上级端口编号','上级端口名称','失败原因','状态', '配线日期', '备注', '操作时间','操作人员','业务类型'],
			   	colModel:[
			   		{name:'viewOperation',index:'viewOperation', width:70},
			   		{name:'ID',      index:'ID',		hidden:true},
			   		{name:'devno',   index:'devno',		hidden:true},
			   		{name:'devname', index:'devname',	width:120},				   		
			   		{name:'pdevno',  index:'pdevno',	hidden:true},
			   		{name:'pdevname',index:'pdevname',	width:120},	
			   		{name:'breason', index:'breason',	width:120},
			   		{name:'status',  index:'status',	hidden:true},
			   		{name:'bdate',   index:'bdate',		align:"center", width:125},
			   		{name:'memo',    index:'memo', 		align:"right", width:90 },					
			   		{name:'operdate',index:'operdate',	hidden:true},
			   		{name:'oper',    index:'oper', 		hidden:true},
			   		{name:'routetype',index:'routetype',hidden:true}	
			   	],
			   	rowNum:15,
			   	rowList:[15,30,128],
			   	imgpath: gridimgpath,
			   	pager: jQuery('#pager_bindError'),
			   	sortname: 'devno',
			    viewrecords: true,
			    sortorder: "asc",
			    pgbuttons: true,
				useDefault:true,
				hiegth:270,
				loadComplete: function() { 	
					addRowOperBtn('bindError','处理','handleError','ID','click',1);
					addRowOperBtn('bindError','忽略','ignoreError','ID','click',2);
				  	executeAddBtn('bindError',2);
				}, 
				caption:"配线失败信息"			
			}).navGrid('#pager_bindError',
			{refresh: true, edit: false, add: false, del: false, search: false});			
		}
		//处理操作 1:处理
		function handleError(ID){
			if (!confirm("您确定要将该配线失败状态置为“处理”吗？")){
				return;
			}
			updateErrorStatus(ID,1);
		}
		//忽略操作 2:忽略
		function ignoreError(ID){
			if (!confirm("您确定要将该配线失败状态置为“忽略”吗？")){
				return;
			}
			updateErrorStatus(ID,2);
		}
		//对失败信息进行 1:处理 2:忽略
		function updateErrorStatus(ID,status){
			var UserId =$("#UserId").val();
			var params = '&ID='+ID + '&status='+status +'&oper='+tsd.encodeURIComponent(UserId);			
			var res = executeNoQuery("dbsql_route.PB.UpdateErrStatus",6,params,"route");
			if(res=="true"||res==true)
			{
				alert("“配线失败”状态修改成功。");	
				//writeLogInfo("","modify",loginfo);
			}
			$("#bindError").trigger("reloadGrid");
		}
		/////////////////////////////////////////////////////////
		///////////////   配线失败信息展示 end     /////////////////
		/////////////////////////////////////////////////////////
		
			
		///////////////////////////////////////////////////////
		////////////////////   导出功能 start  ///////////////////
		/**********************************************************
				function name:   openDiaDownLoad()
				function:		 打开导出数据窗口
				parameters:      
				return:			 
				description:     打开导出数据窗口
				Date:				2010-9-7 
		********************************************************/
		function openDiaDownLoad(){	
			var languageType = '<%=languageType%>';//国际化标签			
			thisDownLoad('tsdBilling','mssql','vw_air_bind_error',languageType);	
		}
		
		/**********************************************************
						function name:   exeDownLoad()
						function:		 执行导出数据
						parameters:      
						return:			 
						description:     执行导出数据
						Date:				2010-9-7 
		********************************************************/
		function exeDownLoad(){	
			getTheCheckedFields('tsdBilling','mssql','vw_air_bind_error','vw_air_bind_error');
		}
		////////////////////   导出功能 end  ///////////////////
	</script>
	
	<style type="text/css">
		.midd_div{
			width:450px; 
			margin-top:10px;
			text-align:left;
		}
		.midd_span{
			width:115px; 
			text-align:right;
			float:left;
			margin-right: 3px;
		}
		
		.neirong .middd{
			width:99.8%;
			height:100%;
			float:left;
			border-right:1px solid #60b2e3;
			border-left:1px solid #60b2e3;
			border-bottom:1px solid #60b2e3;
		}
		input{
			vertical-align:middle;
			height:18px;
			
			}
	</style>
</head>
	
	<div class="neirong" id="divBind_pre" style="width:500px;display: none;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Title">配线</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#divBind_pre').hide();"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;"> <br />
			<div id="preDeviceName" class="midd_div" >
				
					<div style="float:left; margin-left:10px; padding-top:3px;">上级端口名称:</div>
					<div style="float:left;"><input type="text" id="PName" disabled="disabled" /></div>
					<div style="float:left; margin-top:-9px; margin-left:2px;"><button class="tsdbutton" onclick="showPreInfo();">选择上级设备端口</button></div>		
               	
				
					<div style="color: red; clear:both; margin-left:20px; font-size:11px;  line-height:25px;">端口名称只能通过选择获取</div>
					<input type="hidden" id="PNode" />	
				
				
			</div>						
		</div>		
		<div class="midd_butt" style="height:38px;">  
			<button onclick="updateDetail();" class="tsdbutton" 
				style="margin-left: 20px;">
				保存
			</button>
			<button onclick="javascript:$('#divBind_pre').hide();" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>			
		</div>
	</div>	
	
		
	<div class="neirong" id="divBind_batch" style="width:500px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="batchTitle"></span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;"> <br />
			<div id="batchPan1"  class="midd_div">	
				<span class="midd_span" >批量配线方式</span>	
				<select id="bindType" style="width:74px;">
					<option value="oneTone">一对一</option>
					<option  value="manyTone">多对一</option>
				</select>
						 
			</div>
			<div id="batchPan2"  class="midd_div">	
				<span class="midd_span" >端口名称：前缀</span>	
				<input type="text" id="nPrefix" style="width:74px;"/>
				起始值<input type="text" id="nBeginid" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
				至
				<input type="text" id="nEndid" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>			 
			</div>
			<div id="batchPan3" class="midd_div">		 
				<span class="midd_span" >上级端口名称：前缀</span>	
				<input type="text" id="pPrefix" style="width:74px;"/>
				起始值<input type="text" id="pBeginid" style="width:28px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>				
			</div>	
			<div  class="midd_div">
				<input type="checkbox" name="check1" id="check1"/><label for="check1">编码左补0</label> 
					编码长度
				<input type="text" id="idlen1" style="width:30px;" onkeyup="value=value.replace(/[^\d]/g,'')"/>
			</div>				
		</div>		
		<div class="midd_butt" style="height:38px;">  
			<button onclick="updateDetail();" class="tsdbutton" id="bindBtn"
				style="margin-left: 20px;">
				批量配线
			</button>
			<button onclick="javascript:setTimeout($.unblockUI,15);" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>			
		</div>
	</div>
	
	
	<div class="neirong" id="divBindError" style="width:600px;height: 300px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span id="Title">配线错误信息管理</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#divBindError').hide();"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="middd" style="background-color:#FFFFFF;"> <br />
			<div style="width: 100%;overflow-x: auto;height: 96%;padding-top: 0px;margin-top: 0px;">
				<input  class="tsdbutton" type="button" value="导出" style="float: left;" onclick="openDiaDownLoad();"/>
				<table id="bindError" class="scroll" cellpadding="0" cellspacing="0" ></table>
				<div id="pager_bindError" class="scroll" style="text-align:left;"></div>
			</div>						
		</div>		
		<div class="midd_butt" style="height:33px;"> 			
			<button onclick="javascript:$('#divBindError').hide();" class="tsdbutton"  style="margin-left: 20px;">
				关闭			
			</button>			
		</div>
	</div>
	
	
	
	

<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:700px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv"><fmt:message key="SingleTabE.selField" /></div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="global.close"/></a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			<form action="#" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<div id="thelistform" style="margin-left: 10px;max-height: 200px;overflow-y: scroll;" >				
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields();">
				<fmt:message key="SingleTabE.selectAll" />
			</button>
			<button type="submit" class="tsdbutton" id="query" onclick="exeDownLoad();">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>			
		</div>
</div>	

<input type="hidden" id="fusearchsql" name="fusearchsql" value=" 1=1 " />
<input type="hidden" id="languageType" value="<%=languageType %>" >

	