<%----------------------------------------
	name: userLineManager.jsp
	author: chenze
	version: 1.0, 2010-11-23
	description: 路由段设置
	modify: 
		 	
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'routeSegment.jsp' starting page</title>
    
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<!-- dtree需要导入文件 -->
	<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
	<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>	
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<style type="text/css">
	#definePrevNodeGridContainer table td {line-height:18px;}
	#definePrevNodeGridContainer table th {line-height:16px;}
	#depthOneDevice,#depthTwoDevice{font-weight:normal;}
	</style>
	<script type="text/javascript">
	$(function(){
		$("#navBar").append(genNavv());
		gobackInNavbar("navBar");
		
		Dat = loadData("air_devicemx",$("#lanType").val(),1,"修改上级端口&nbsp;查看");
		depthThreeDat = loadData("air_devicemx",$("#lanType").val(),1,"选择");
		
		depthThreeDat.setHidden(["memo","PDeviceNo","DeviceName"]);
		depthThreeDat.setWidth({"Operation":"50"});
		loadMxGrid();
		loadDefineMxGrid();
		
		initDropdownDepthOne();
		initDropdownDepthTwo();
		
		$("#definePrevNodeTabClose").click(function(){
			initDropdownDepthOne();
			$("#depthOneDevice").trigger("change");
			//清除缓存数据
			$("#definePrevNodeTab").removeData("deviceno");
			
			loadDefineMxGrid("~");
		});
	});
	
	var Dat = "";
	var depthThreeDat = "";
	/**
 	 * 初始化页面主jqGrid
	 * @param
 	 *		
	 * @return 
	 */	
	function loadMxGrid()
	{			
		var urlstr=tsd.buildParams({ packgname:'service',//java包
						clsname:'ExecuteSql',//类名
						method:'exeSqlData',//方法名
						ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
						tsdcf:'mssql',//指向配置文件名称
						tsdoper:'query',//操作类型 
						datatype:'xml',//返回数据格式 
						tsdpk:'routeSegment.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						tsdpkpagesql:'routeSegment.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
		urlstr += "&cols=";		
		var temp = Dat.FieldName.join(",");		
		urlstr += temp;
		
		jQuery("#edit_grid").jqGrid({
			url:'mainServlet.html?' + urlstr, 
			datatype: 'xml',
			colNames:Dat.colNames,
			colModel:Dat.colModels,
			       	rowNum:10, 
			       	rowList:[10,20,30],
			       	//useDefault:true,
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#edit_pager'), 
			       	sortname:'deviceno',
			       	viewrecords: true,
			       	sortorder: 'desc', 
			       	caption:"设备端口信息", 
			       	useDefault:true,
			       	height:260,
			       	loadComplete:function(){
			        	if($("#edit_grid tr.jqgrow[id='1']").html()=="")
							return false;
			        	//addRowOperBtn('b_main_grid','<img src="images/printreport.png" title="<fmt:message key="global.print" />" />','printKD','userid','click',1,'tStart');
			        	addRowOperBtn('edit_grid','<img src="style/images/public/ltubiao_01.gif" title="修改" />','modifyPrevNode','DeviceNo','click',1);
			        	addRowOperBtn('edit_grid','<img src="style/images/public/ltubiao_03.gif" title="查看" />','detailPrevNode','DeviceNo','click',2);
			        	executeAddBtnWithoutAddCell('edit_grid',2);
			        	
			        	var ids = $("#edit_grid").getDataIDs();
						for(var i=0;i<ids.length;i++)
						{
							var uid = $("#edit_grid").getCell(ids[i],"NodeState");
							$("#edit_grid").setRowData(ids[i],{"NodeState":uid=="free"?"空闲":uid=="using"?"占用":""});
						}	
			        	
			        }
			       
			}).navGrid('#edit_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
	}
	/**
 	 * 确定设置
	 * @param 
 	 *		
	 * @return 
	 */	
	function checkBeforeModify(DevicdNo)
	{
		var res = fetchMultiPValue("routeSegment.Proc",6,"&Func=CheckExists&DeviceNo=" + DevicdNo);
		if(res[0]!=undefined && res[0][0]!=undefined && res[0][0]=="OK")
		{
			var info = "当前端口存在前置端口 " + res[0][1] + " 和后续端口 " + res[0][2] + " ，重新设置将破坏现在路由段设置，你确定要继续设置吗？";
			if(confirm(info))
			{
				//executeNoQuery("routeSegment.updatetonull",6,""&PDeviceNo=" + );
				return true;
			}
			else
				return false;
		}
		else
			return true;
	}
	/**
 	 * 打开设置面板
	 * @param 
 	 *		
	 * @return 
	 */	
	function modifyPrevNode(DeviceNo)
	{
		if(!checkBeforeModify(DeviceNo))
			return;
		initDropdownDepthOne(DeviceNo);
		$("#definePrevNodeTab").data("deviceno",DeviceNo);
		autoBlockFormAndSetWH('definePrevNodeTab',10,5,'definePrevNodeTabClose',"#ffffff",false,1000,'');
	}
	
	/**
 	 * 打开详细面板
	 * @param 
 	 *		
	 * @return 
	 */	
	function detailPrevNode(DeviceNo)
	{
		var res = fetchMultiPValue("routeSegment.Proc",6,"&Func=GetSegment&DeviceNo=" + DeviceNo);
		if(res[0]!=undefined && res[0][0]!=undefined && res[0][0]=="OK")
		{
			$("#detailPrevNodeInfoContainer .d_1").html(res[0][3]);
			$("#detailPrevNodeInfoContainer .d_2").html(res[0][1]);
			$("#detailPrevNodeInfoContainer .d_3").html(res[0][2]);
		}
		else
			$("#detailPrevNodeInfoContainer span").html("");
		autoBlockFormAndSetWH('detailPrevNodeTab',10,5,'detailPrevNodeTabClose',"#ffffff",false,1000,'');
	}
	
	/**
 	 * 初始化设置上级节点面板三级设备列表
	 * @param  	DeviceNo 设备编号 
 	 *		
	 * @return 
	 */	
	function loadDefineMxGrid(deviceno)
	{
		var urlstr=tsd.buildParams({ packgname:'service',//java包
						clsname:'ExecuteSql',//类名
						method:'exeSqlData',//方法名
						ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
						tsdcf:'mssql',//指向配置文件名称
						tsdoper:'query',//操作类型 
						datatype:'xml',//返回数据格式 
						tsdpk:'routeSegment.depthThreeDeviceQuery',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						tsdpkpagesql:'routeSegment.depthThreeDeviceQuerypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
		urlstr += "&cols=";		
		var temp = depthThreeDat.FieldName.join(",");		
		urlstr += temp;
		
		//如果有参数，则按参数刷新页面
		if(deviceno!=undefined && deviceno!="~!")
		{
			urlstr += "&DeviceNo=" + deviceno;
			jQuery("#depththreeedit_grid").setGridParam({"url":'mainServlet.html?'+urlstr}).trigger("reloadGrid");;
			return;
		}
		else
		{
			urlstr += "&DeviceNo=~";
		}
		
		jQuery("#depththreeedit_grid").jqGrid({
			url:'mainServlet.html?' + urlstr, 
			datatype: 'xml', 
			colNames:depthThreeDat.colNames,
			colModel:depthThreeDat.colModels,
			       	rowNum:10, 
			       	rowList:[10,20,30],
			       	//useDefault:true,
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#depththreeedit_pager'), 
			       	sortname:'deviceno',
			       	viewrecords: true,
			       	sortorder: 'desc', 
			       	caption:"设备端口信息", 
			       	useDefault:true,
			       	height:220,
			       	width:710,
			       	loadComplete:function(){
			        	if($("#depththreeedit_grid tr.jqgrow[id='1']").html()=="")
							return false;
			        	//addRowOperBtn('b_main_grid','<img src="images/printreport.png" title="<fmt:message key="global.print" />" />','printKD','userid','click',1,'tStart');
			        	addRowOperBtn('depththreeedit_grid','<img src="style/images/public/ltubiao_01.gif" title="修改" />','choosePrevNode','DeviceNo','click',1);
			        	executeAddBtnWithoutAddCell('depththreeedit_grid',1);
			        	
			        	var ids = $("#depththreeedit_grid").getDataIDs();
						for(var i=0;i<ids.length;i++)
						{
							var uid = $("#depththreeedit_grid").getCell(ids[i],"NodeState");
							$("#depththreeedit_grid").setRowData(ids[i],{"NodeState":uid=="free"?"空闲":uid=="using"?"占用":""});
						}	
			        	
			        },
			        ondblClickRow:function(idx){
			        	var deviceno = $("#depththreeedit_grid").getCell(idx,"DeviceNo");
			        	choosePrevNode(deviceno);
			        }
			       
			}).navGrid('#depththreeedit_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
			); 
	}
	/**
 	 * 选择要设置的上级节点	
	 * @param  	DeviceNo 设备编号 
 	 *		
	 * @return 
	 */
	function choosePrevNode(DeviceNo)
	{
		if(confirm("你确定要设置节点" +　$("#definePrevNodeTab").data("deviceno") + " 的上一级节点为 " + DeviceNo + " 吗?"))
		{
			var prram = "&PDeviceNo=" + tsd.encodeURIComponent(DeviceNo) +"&DeviceNo=" + $("#definePrevNodeTab").data("deviceno");
			var res = executeNoQuery("routeSegment.setPDev",6,prram);
			if(res=="true" || res==true)
			{
				alert("设置节点操作成功");
			}
			else
			{
				alert("设置一级节点操作失败");
			}
			//关闭面板
			$("#definePrevNodeTabClose").click();
			//刷新主Grid
			$("#edit_grid").trigger("reloadGrid");
		}
	}
	/**
 	 * 初始化设置上级节点面板一级设备
	 * @param  	DeviceNo 设备编号 
 	 *		
	 * @return 
	 */	
	function initDropdownDepthOne(DeviceNo)
	{
		var result = fetchMultiArrayValue("routeSegment.frontFirstDevice",6,"&DeviceNo="+DeviceNo);
		var optHtml = "<option value=\"~!\">请选择</option>";
		if(result[0]!=undefined && result[0][0]!=undefined)
		{
			for(var i=0;i<result.length;i++)
			{
				optHtml += "<option value=\"" + result[i][0] + "\">" + result[i][1] + "</option>";
			}
		}
		$("#depthOneDevice").html(optHtml);
	}
	/**
 	 * 初始化设置上级节点面板二级设备
	 * @param  	DeviceNo 设备编号 
 	 *		
	 * @return 
	 */	
	function initDropdownDepthTwo(DeviceNo)
	{
		var result = fetchMultiArrayValue("routeSegment.depthTwoDevice",6,"&DeviceNo="+DeviceNo);
		var optHtml = "<option value=\"~!\">请选择</option>";
		if(result[0]!=undefined && result[0][0]!=undefined)
		{
			for(var i=0;i<result.length;i++)
			{
				optHtml += "<option value=\"" + result[i][0] + "\">" + result[i][1] + "</option>";
			}
		}
		$("#depthTwoDevice").html(optHtml);
	}
	
	
	
	
	function fuheExe()
	{
			var queryName= document.getElementById("queryName").value;
			if(queryName=="delete")
			{
				fuheDel(); //批量删除
			}
			else if(queryName=="modify")
			{
				fuheOpenModify();//批量修改
			}
			else
			{
				fuheQuery();		//高级查询
			}
	}
	
	//复合查询操作
	function fuheQuery()
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
									  tsdpk:'routeSegment.querywhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'routeSegment.querypagewhere'
									});
		var link = urlstr1 + params;
		link = link + "&cols=" + Dat.FieldName.join(",");
	 	$("#edit_grid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板			
	}
		
	/**
	 * 组合排序 
	 	通过隐藏域gridinfo 判断是对呼叫类型jqgrid或是呼叫类型明细jqgrid操作；
	 	key=1：呼叫类型排序 ；key=2：呼叫类型明细排序
	 * @param sqlstr 进行组合排序的排序sql子语句
	 * @return 
	 */
	function zhOrderExe(sqlstr)
	{			
		var params = fuheQbuildParams();			
			if(params=='&fusearchsql=')
			{
				params +='1=1';
			}
		 params =params+'&orderby='+sqlstr;		    
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'routeSegment.queryorder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'routeSegment.querypageorder'
										});
			var link = urlstr1 + params;
			link = link + "&cols=" + Dat.FieldName.join(",");
		 	$("#edit_grid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
		 	
	}
	
	
	</script>

  </head>
  
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		:
	</div>
		
	<div id="buttons">
		<button type="button" onclick="openDiaO('air_devicemx')">
			<!--组合排序--><fmt:message key="order.title" />
		</button>
	   <button type="button" onclick="openDiaQueryG('query','air_devicemx','a')" >
			<!--查询--><fmt:message key="global.query" />
		</button>
		<button type="button" onclick="" disabled="disabled" style="display:none;">
			<!--打印--><fmt:message key="tariff.printer" />
		</button>
	</div>	
	<table id="edit_grid" class="scroll"></table>
	<div id="edit_pager" class="scroll" style="text-align:left;"></div>
		<div id="buttons">
		<button type="button" onclick="openDiaO('air_devicemx')">
			<!--组合排序--><fmt:message key="order.title" />
		</button>
	   <button type="button" onclick="openDiaQueryG('query','air_devicemx','a')" >
			<!--查询--><fmt:message key="global.query" />
		</button>
		<button type="button" onclick="" disabled="disabled" style="display:none;">
			<!--打印--><fmt:message key="tariff.printer" />
		</button>
	</div>
	<div class="neirong" id="definePrevNodeTab" style="display: none;width:760px;">
		<div class="top">
		<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" >设置上级节点</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="javascript:void(0);" onclick="$('#definePrevNodeTabClose').click()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
			</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
			<div class="midd" >
			<form id='definePrevNode' name="definePrevNode" onsubmit="return false;" action="#" >
			  <input type="hidden" ></input>
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">				
				  <tr>
				    <td width="12%" align="right" class="labelclass"><label>一级设备</label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<select name="depthOneDevice" id="depthOneDevice" onchange="initDropdownDepthTwo(this.value)"></select>
				    	<label class="addred" ></label>
				    </td>
				    <td width="12%" align="right"  class="labelclass" style="line-height: 20px;"><label>二级设备</label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<select name="depthTwoDevice" id="depthTwoDevice" onchange="loadDefineMxGrid(this.value)"></select>
				    	<label class="addred" ></label>
				    </td>
				  </tr>
				  <tr>
					<td colspan="4">
					  <div id="definePrevNodeGridContainer">
					  	<table id="depththreeedit_grid" class="scroll"></table>
						<div id="depththreeedit_pager" class="scroll" style="text-align:left;"></div>
					  </div>						
					</td>				    
				  </tr>			
			   </table>
			</form>	
			<div class="midd_butt" style="width:742px;">
			<!-- 修改     --><button class="tsdbutton" id="modify1" style="width:63px;heigth:27px;display:none" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
		    <!-- 关闭 	 --><button class="tsdbutton" id="definePrevNodeTabClose" style="width:63px;heigth:27px;"><fmt:message key="global.close" /></button>
			</div>
		</div>
	</div>
	
	<div class="neirong" id="detailPrevNodeTab" style="display: none;width:760px;">
		<div class="top">
		<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" >路由段详细信息</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="$('#detailPrevNodeTabClose').click()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
			</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
			<div class="midd" >			
		  	<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">				
			  <tr>
				<td colspan="4">
				  <div id="detailPrevNodeInfoContainer">
				  	<table align="center">
				  		<tr>
				  			<td width="90">当前端口</td><td><span class="d_1"></span></td>
				  		</tr>
				  		<tr>
				  			<td>前置端口</td><td><span class="d_2"></span></td>
				  		</tr>
				  		<tr>
				  			<td>后置端口</td><td><span class="d_3"></span></td>
				  		</tr>
				  	</table>
				  </div>						
				</td>				    
			  </tr>			
		   </table>
			<div class="midd_butt" style="width:742px;">
			<!-- 关闭 	 --><button class="tsdbutton" id="detailPrevNodeTabClose" style="width:63px;heigth:27px;"><fmt:message key="global.close" /></button>
			</div>
		</div>
	</div>
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType%>' />		
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
	
	
	<input type="hidden" id="useridd" value="<%=session.getAttribute("userid") %>"/>
	<input type="hidden" id='queryName'/>
	<input type="hidden" id="fusearchsql" name="fusearchsql"/>
	<!-- 查询树信息存放　用于实现保存本次查询条件 -->
	<input type="hidden" id='treepid' />	
	<input type="hidden" id='treecid' />	
	<input type="hidden" id='treestr' />	
	<input type="hidden" id='treepic' />
		
  </body>
</html>
