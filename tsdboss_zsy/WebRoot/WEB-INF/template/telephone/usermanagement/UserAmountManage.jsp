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
       
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />    	
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
	
	<script type="text/javascript">
		
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
			initGrid_Detail();		
		});


		//初始化设备子设备表格
		function initGrid_Detail(){
		
			///设置命令参数
			 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:'useramountmanager.list',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				tsdpkpagesql:'useramountmanager.listpage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			jQuery("#editgrid").jqGrid({  	
				url:'mainServlet.html?'+urlstr, 
				datatype: "xml",
			   	colNames:['修改|删除','合同号','用户名称', '一级部门', '二级部门', '话费指标','标志', '序号1','序号2'],
			   	colModel:[
			   		{name:'viewOperation',index:'viewOperation', width:60},
			   		{name:'hth',index:'hth', width:90},
			   		{name:'bm',index:'bm', width:140},
			   		{name:'bm1',index:'bm1', width:120},
			   		{name:'bm2',index:'bm2', width:120},					
			   		{name:'hfzb',index:'hfzb', width:90},
			   		{name:'zcfs',index:'zcfs', width:60},
			   		{name:'xh',index:'xh', width:120, hidden:true},
			   		{name:'xh2',index:'xh2', align:"center", hidden:true}
			   	],
			   	rowNum:15,
			   	rowList:[15,30,128],
			   	imgpath: 'plug-in/jquery/jqgrid/themes/basic/images/',
			   	pager: jQuery('#pagered'),
			   	sortname: 'hth',
			    viewrecords: true,
			    sortorder: "asc",
			    pgbuttons: true,
				caption:"  ",
				height:document.documentElement.clientHeight-150,
				width:document.documentElement.clientWidth-3,
				loadComplete: function() { 					
					
					addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" title="修改"/>','openRowModify','hth','click',1);
					addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_02.gif" title="删除"/>','deleteRow','hth','click',2,'feename');
				 	
					executeAddBtn('editgrid',2);
										
				}							
			}).navGrid('#pagered',{refresh: true, edit: false, add: false, del: false, search: false});
		}
		
		/*********************************
		**             添加信息            **
		***********************************/
		/**
		 * 弹出添加面板
		 * @param 无参数
		 * @return 无返回值
		 */
		function openText(){
			$("#titledivs").html("增加");
	 		$("#saveadd").show();
	 		$("#saveexit").show();
	 		autoBlockForm('add',60,'close',"#ffffff",false);//弹出查询面板
			$("#modify").hide();
			$("#simpquery").hide();
			clearText('operform');
		}
		
		
		
	</SCRIPT>
  </head>
  
  <body>
	<div id="navBar1">
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
	<!-- 用户操作标题以及放一些快捷按钮-->
	<div id="buttons">
	
		<button type="button" id="openadd" onclick="openText();">
			<fmt:message key="global.add" />
		</button>
		<button type="button" id="jdquery1" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>	
		<button type="button" id='gjquery1' onclick="openDiaQuery();">
			<!--高级查询-->
			<fmt:message key="oper.queryA"/>
		</button>
	</div>
	
	<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>					
	
	
	<div class="neirong" id="add" style="display: none; width: 600px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titledivs">
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="clearText('operform');reloadData();"> <!-- 关闭 -->
							<fmt:message key="groupManager.close" /> </a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" name="operform" id="operform"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td class="labelclass" width="16%;">
								<label for="feename">
									合同号
								</label>
							</td>
							<td width="34%" class="tdstyle">
								<input type="hidden" id="hidid" />
								<input type="text" name="feename" id="feename" class="textclass"
									style="width: 150px" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
							<td class="labelclass" width="16%">
									用户名称
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="calledprefix" class="textclass"
									style="width: 150px" id="calledprefix" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
						</tr>

						<tr>
							<td class="labelclass" width="16%">
								一级部门
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="unit" id="unit"
									class="textclass" style="width: 150px" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
							<td class="labelclass" width="16%">
								二级部门
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="price" class="textclass" 
									style="width: 150px" id="price" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
						</tr>
						<tr>
							<td class="labelclass" width="16%">
								话费指标
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="basecs" id="basecs" 
									class="textclass" style="width: 150px"/>
							</td>
							<td class="labelclass" width="16%">
								是否显示
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="basefee" class="textclass" 
									style="width: 150px" id="basefee" />
							</td>
						</tr>
						<tr>
							<td class="labelclass" width="16%">
								一级序号
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="price" class="textclass" 
									style="width: 150px" id="price" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
							<td class="labelclass" width="16%">
								二级序号
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="price" class="textclass" 
									style="width: 150px" id="price" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
						</tr>
						<tr>
							<td class="labelclass" width="16%">
								新部门
							</td>
							<td width="34%" class="tdstyle">
								<input type="text" name="unit" id="unit"
									class="textclass" style="width: 150px" />
								<font style="color: red; margin-left: 10px">*</font>
							</td>
							<td class="labelclass" width="16%">
								&nbsp;
							</td>
							<td width="34%" class="tdstyle">
								&nbsp;
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				
				<button type="button" class="tsdbutton" id="saveadd" onclick="saveInfo(1)">
					<!-- 保存添加 --><fmt:message key="groupManager.saveAndAdd" />
				</button>
				<button type="button" class="tsdbutton"  id="saveexit" onclick="saveInfo(2)">
					<fmt:message key="groupManager.saveAndclose" />
				</button>
				<button type="button" class="tsdbutton"  id="modify" onclick="modifyInfo();">
					<fmt:message key="global.edit" />
				</button>
				<button type="button" class="tsdbutton"  id="simpquery" onclick="queryGroup()">
					<fmt:message key="global.query" />
				</button>
				<button type="button" class="tsdbutton"  id="close" onclick="clearText('operform');reloadData();">
					<fmt:message key="global.close" />
				</button>
			
			</div>
		</div>
	
  </body>
</html>
