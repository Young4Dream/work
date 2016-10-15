<%----------------------------------------
	name: T112_Query.jsp
	author: wxm
	version: 1.0, 2013-01-25
	description: 112故障工单查询
	modify: 
			
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>telReprint</title>
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
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/public.js" type=text/javascript language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->	
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" type="text/javascript">
		/**
	 * 初始化
	 * @param 无参数
	 * @return 无返回值
	 */
	$(function(){
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			loadJqgrid();
		});
		
	/*********
			* 加载jqgrid
			* @param;
			* @return;
		    **********/
			function loadJqgrid(){								
					/////设置命令参数 用于初始化jqgrid
					var urlstr=tsd.buildParams({ 	  
												packgname:'service',//java包
												clsname:'ExecuteSql',//类名
												method:'exeSqlData',//方法名
												ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												tsdcf:'mssql',//指向配置文件名称
												tsdoper:'query',//操作类型 
												datatype:'xml',//返回数据格式 
												tsdpk:'telReprint.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												tsdpkpagesql:'telReprint.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
					//操作人id
					urlstr += "&skrid=";
					urlstr += $("#skrid").val();
					//操作人所在区域
					urlstr += "&area=";
					urlstr += tsd.encodeURIComponent($("#area").val());
					var column = "ID,ID,Dh,Gzxx,Lxdh,UserInfo,IsComplete,Wgrq,Wgry";
					//获取文档 URL中“?”后面的信息 **设置jqgrid标题
					var navv = document.location.search;
					//获取url中变量为imenuname的属性值
					var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));	
					jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+'&column='+column,
						datatype: 'xml', 
						//colNames:col[0],
						colNames:['id','电话','故障信息','联系电话','用户地址','是否完工','完工日期','完工人员'],
						colModel:[{name:'ID',index:'ID',hidden:true,width:0},
									{name:'viewOperation',index:'viewOperation',width:170},
			    		   			{name:'Dh',index:'Dh',width:100}, 
				           			{name:'Gzxx',index:'Gzxx',width:150},
				           			{name:'Xdh',index:'Xdh',width:100},
				           			{name:'Lxdh',index:'Lxdh',width:150},
				           			{name:'UserInfo',index:'UserInfo',width:100},
				           			{name:'IsComplete',index:'IsComplete',width:150},
				           			{name:'Wgrq',index:'Wgrq',width:150},
				           			{name:'Jlry',index:'Jlry',width:100},
				           			{name:'Wgry',index:'Wgry',width:150}
				           		],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'Sgrq', //默认排序字段
						       	viewrecords: true,
						       	//hidegrid: false,
						       	sortorder: 'desc',//默认排序方式 
						       	caption:infoo,
						       	height:300, //高
						        //width:document.documentElement.clientWidth-27,
						       	loadComplete:function(){
											addRowOperBtn('editgrid','<img src="style/images/public/printreport.png" title="<fmt:message key="phone.getinternet0332" />" />','printKDJob','ID','click',1,'Sgnr');
										    executeAddBtn('editgrid',1);
								},
											ondblClickRow: function(ids){
														if(ids != null){
															var ID =$("#editgrid").getCell(ids,"ID");
															openRowInfo(ID);
														}
												}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false},
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true},
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true},
							{reloadAfterSubmit:false},
							{}
							); 
					
			}
		</script>	
  	</head>
	<body >
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		<div id="navBar1">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							：
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message
									key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
			<!-- 用户操作标题以及放一些快捷按钮 头部-->
			<div id="buttons">
				<!-- 组合排序 -->
				<button type="button" id="order1" onclick="openDiaO('vw_TelJob');">					
					<fmt:message key="order.title" />
				</button>				
				<!--高级查询-->
				<button type="button" id='gjquery1'
					onclick="openDiaQueryG('query','vw_TelJob');" >					
					<fmt:message key="oper.queryA" />
				</button>
			</div>
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
					
		<!-- 添加修改面板 开始-->
		<div class="neirong" id="pan" style="display: none">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							<fmt:message key="phone.getinternet0340" /><!-- 功能名称 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="closeo()"><span style="margin-left: 5px;"><fmt:message
									key="global.close" />
						</span>
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<div style="max-height:315px;overflow-y: auto;overflow-x: hidden;">
				<form id='operformT1' name="operformT1" onsubmit="return false;"
					action="#">
					<input type="hidden"></input>
					<table width="99%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0" style="line-height: 33px; font-size: 12px;">

						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Areag"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Area" id="Area" class="textclass"></input>
								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="BeginYwAreag"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="BeginYwArea" id="BeginYwArea" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Bm1g"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bm1" id="Bm1" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Bm2g"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bm2" id="Bm2" class="textclass"></input>
								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Bm3g"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bm3" id="Bm3" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Bm4g"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bm4" id="Bm4" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Bzg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Bz" id="Bz" class="textclass"></input>								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="CardIDg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="CardID" id="CardID" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Dhgng"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Dhgn" id="Dhgn" class="textclass" />
							</td>
						</tr>	

						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Dhlxg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Dhlx" id="Dhlx" class="textclass"></input>								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="dJhwcsjg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="dJhwcsj" id="dJhwcsj" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Hthg"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Hth" id="Hth" class="textclass" />
							</td>
						</tr>	
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="IDDg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="IDD" id="IDD" class="textclass"></input>								
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="IfCancelg"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="IfCancel" id="IfCancel" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="IsCompleteg"></label>
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="IsComplete" id="IsComplete" class="textclass" />
							</td>
						</tr>							
					
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="isJudgeg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="isJudge" id="isJudge" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="IsPayg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="IsPay" id="IsPay" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Jlryg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Jlry" id="Jlry" class="textclass" />
							</td>
						</tr>		
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="JobStateg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="JobState" id="JobState" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Jsbmg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Jsbm" id="Jsbm" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="LinkMang"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="LinkMan" id="LinkMan" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Lshg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Lsh" id="Lsh" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Lxdhg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Lxdh" id="Lxdh" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Mqbmg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Mqbm" id="Mqbm" class="textclass" />
							</td>
						</tr>	
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Nxmg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Nxm" id="Nxm" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Pgrqg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Pgrq" id="Pgrq" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Pgrzg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Pgrz" id="Pgrz" class="textclass" />
							</td>
						</tr>		
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Sgnrg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Sgnr" id="Sgnr" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Sgrqg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Sgrq" id="Sgrq" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Sjjeg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Sjje" id="Sjje" class="textclass" />
							</td>
						</tr>
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Slbmg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Slbm" id="Slbm" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="TypeIDg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="TypeID" id="TypeID" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Wgbmg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Wgbm" id="Wgbm" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Wgrqg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Wgrq" id="Wgrq" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Xdhg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Xdh" id="Xdh" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Xdzg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Xdz" id="Xdz" class="textclass" />
							</td>
						</tr>
						
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Xmg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Xm" id="Xm" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Ydhg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Ydh" id="Ydh" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Ydzg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Ydz" id="Ydz" class="textclass" />
							</td>
						</tr>
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="YHthg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="YHth" id="YHth" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Yhxzg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Yhxz" id="Yhxz" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id="Yjjeg"></label>
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Yjje" id="Yjje" class="textclass" />
							</td>
						</tr>
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="Yjkxg"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Yjkx" id="Yjkx" class="textclass"></input>								
							</td>
							
							<td width="12%" align="right" class="labelclass">
								<label id="Ywareag"></label>
							</td>
							<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="Ywarea" id="Ywarea" class="textclass"></input>					
							</td>

							<td width="12%" align="right" class="labelclass">							
							</td>
							<td width="20%" align="left" style="border-bottom: 1px solid #A9C8D9;">
								
								<input type="hidden" id="ID"/>
							</td>
						</tr>				
					</table>
				</form>
				</div>
				<div class="midd_butt">					
					<!-- 关闭 	 -->
					<button class="tsdbutton" id="closeo"
						style="width: 63px; heigth: 27px;" onclick="closeo();">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>
<!-- 页面通用隐藏域 开始-->
<div style="display: none">			
	<input type="hidden" id="imenuid" value="<%=imenuid%>" />
	<input type="hidden" id="zid" value="<%=zid%>" />
	<%
		if (!languageType.equals("en")) {
			languageType = "zh";
		}
	%>
	<input type="hidden" id="languageType" value="<%=languageType%>" />
	<form name="childform" id="childform">
	  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	</form>  
	<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />
  	<input type="hidden" id="area" name="area" value='<%=request.getSession().getAttribute("chargearea") %>' />
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />	
	<!-- 权限组 -->
	<input type="hidden" id="RightGroup" name="RightGroup" />	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	<!-- 页面通用隐藏域 结束-->			
	<input type="hidden" name="printt" id="printt" />
	</body>
</html>
