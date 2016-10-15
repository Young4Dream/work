<%----------------------------------------
	name: SelfConfigReport.jsp
	author: chenze
	version: 1.0, 2010-12-28
	description: 
	modify: 
	
		2011-01-11  chenze  增加特殊账号限制
		
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Definition relay Bureau to Group</title>
    <!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="style/js/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script type="text/javascript" src="script/public/infotest.js"></script>
	<!-- tab滑动门 需要导入的样式表 *注意路径-->
	<script type="text/javascript" src="css/tree/dtree.js"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 时间控件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<!-- 导入js文件结束 -->
	<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />

	<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
	<link rel="stylesheet" type="text/css" href="plug-in/MultiSelect/jquery.multiSelect.css" />
	<script type="text/javascript" src="plug-in/MultiSelect/jquery.multiSelect.js"></script>
	<!-- 导入css文件结束 -->
	<style type="text/css">
		#editgrid a{font-weight:bold;}
		body{text-align:left;}
		input,select{margin-left:0px;}		
		.textclass{width:180px;margin-left:0px;}		
		.spanstyle{display:-moz-inline-box; display:inline-block; width:135px}		
		.disabledStar{display:none;}
		.tdstyle{border-bottom:1px solid #A9C8D9;line-height:32px;}
		
		.multiSelect{width:172px;margin-left:0px;height:18px;line-height:18px;}
		.multiSelectOptions{width:180px;}
		#Ctrl1_canloginip_tab_container{max-height:100px;overflow-y:auto;}
		#Ctrl1_canloginip_tab{width:96%;margin-left:auto;margin-right:auto;}
		#Ctrl1_canloginip_tab td{line-height:26px;border:1px solid #CDD;width:20%;}
		#Ctrl1_vi_canloginip_tab_container{max-height:100px;overflow-y:auto;}
		#Ctrl1_vi_canloginip_tab{width:96%;margin-left:auto;margin-right:auto;}
		#Ctrl1_vi_canloginip_tab td{line-height:26px;border:1px solid #EED;width:20%}
	</style>
	
	<script type="text/javascript">
	
	var Dat = "";
	var tabStatus = 1;	
	var tables = ['selfconfigreport'];
	var fuheM = false;	
	var firstLoad = [true];
	var mNames = ['自定义发票管理'];
		
	//用于数据格式的验证
	var regularExp = [];
	regularExp["integer"] = /^\d+$/;
	regularExp["double"] = /^\d+|\d+\.\d+$/;
	//修改数据时保存原记录
	var sourceData = new Array();
	
	$(function(){
		$("#navBar").append(genNavv());
		setUserRight();
				
		getI118n();
		loadFeilu(Dat);
		
		$("#close21").click(function(){fuheM=false;});	
		//测试
		//vValid("ST7","ST7_ld");		
		//初始化面板面板里的下拉列表
		InitialDropdownList();	
	});
	
	/////取字符串长度
	function getLength(str)
	{
		var len = 0;
		for(var i=0;i<str.length;i++)
		{
			if(str.charCodeAt(i)>255)
				len += 2;
			else
				len += 1;				
		}
		return len;
	}
	
	function loadFeilu(models)
	{
		var sqlext = "sales";
		if($("#RightsGroup").val()=="10")
		{
			sqlext = "";
		}
		//models.setHidden(["ID"]);
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'SelfConfigReport.query' + sqlext,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'SelfConfigReport.querypage' + sqlext//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		var fileds = "," + models.FieldName.join(",") + ",";
		fileds = fileds.replace(",PAY_FLAG,",",(select tvalues from tsd_ini i where i.tsection='payitem' and i.tident=pay_flag) PAY_FLAG,");
		fileds = fileds.replace(",ISDESTROY",",case ISDESTROY when 0 then '正常' when 1 then '已撤销' else to_char(ISDESTROY) end ISDESTROY");
		fileds = fileds.substring(1,fileds.length-1);
		fileds = tsd.encodeURIComponent(fileds);
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&area=" + tsd.encodeURIComponent($("#area").val()) + '&cols=' + fileds  + "&cols1=" + Dat.FieldName.join(",") + "&tablename=" + tables[tabStatus-1],
				datatype: 'xml', 
				colNames:models.colNames,//["<fmt:message key='global.operation' />","NetName","Bjzg","Bjdm","Jbjcm","Jbfl","Tfjcm","Tffl","Qjms","Fuf","Fjf","Fjl","Jmlx",'rowguid'], 
				colModel:models.colModels, 
		       	rowNum:10, //默认分页行数
		       	rowList:[10,15,20], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/',
		       	pager: jQuery('#pagered'), 
		       	sortname: 'accttime', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'desc',//默认排序方式 
		       	caption:mNames[tabStatus-1], 
		       	height:360, //高
		       	//width:document.documentElement.clientWidth-27,
		       	loadComplete:function(){
		       			if($("#editgrid tr.jqgrow[id='1']").html()=="")
							return false;
						////@1  表格的id
						////@2  链接名称
						////@3  链接地址或者函数名称
						////@4  行主键列的名称 可以是隐藏列
						////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
						////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
						addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_01.gif\" title=\"撤销\" />",'openRowModify','ID','click',1,'ISDESTROY','SKRID');
						/****执行行按钮添加********
						*@1 表格ID
						*@2 操作按钮数量 等于定义数量
						*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
						executeAddBtn('editgrid',1);
						
						var ids = $("#editgrid").getDataIDs();
						
						for(var i=0;i<ids.length;i++)
						{
							
						}
					}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	////////////////////////////////////////////////////////////////////////////////
	//////					取国际化信息
	///////////////////////////////////////////////////////////////////////////////	
	function getI118n()
	{
		
		//alert(tabStatus-1);
		Dat = loadData(tables[tabStatus-1],$("#languageType").val(),1,"撤销");
		Dat.colModels[0].width=50;
		Dat.colModels[1].hidden = true;
		if($("#AbleForCancel").val()=="false")
			Dat.colModels[0].hidden = true;
		//alert(Dat.FieldName);
		var i = 0;
		if(firstLoad[tabStatus-1])
		{
			firstLoad[tabStatus-1] = false;
		}		
	}
	
	////////////////////////////////////////////////////////////////////////////////
	//////					加星显示关键字
	///////////////////////////////////////////////////////////////////////////////	
	function HighLight()
	{
		
	}
	
	//初始化添加面板里的下拉框
	function InitialDropdownList()
	{
		
	}
	
	/**
		重置营业区域下拉
	*/
	function resetChargeArea()
	{
		
	}
	
	//////////////////////////////////////////////////////////////////////
	/////                     打开修改面板
	/////////////////////////////////////////////////////////////////////
	function openRowModify()
	{
		if($("#editright").val()=="false")
		{
			alert("你没有修改权限");
			//return false;
		}
		else if(arguments[0]==undefined || arguments[1]!="正常")
		{
			alert("当前记录无法撤销");
		}
		else if($("#CrossAreaCancel").val()!="true" && arguments[2]!=$("#skrid").val())
		{
			alert("不可撤销他人的自定义发票");
		}
		else
		{
			if(confirm("你确定要撤销当前自定义发票记录吗？"))
			{
				var res = executeNoQuery("SelfConfigReport.cancel",6,"&skrid=" + tsd.encodeURIComponent($("#skrid").val()) + "&id=" + arguments[0]);
				if(res==true || res=="true")
				{
					alert("撤销成功");
					var loginfo = tsd.encodeURIComponent("自定义发票");
					loginfo += tsd.encodeURIComponent("编号");
					loginfo += ":" + arguments[0];
					writeLogInfo("","modify",loginfo);
					$("#editgrid").trigger("reloadGrid");
				}
				else
				{
					alert("撤销失败");
				}
			}
		}
	}
	
	
	
	////////////////////////////////////////////////////////////////////////////
	////                          条件排序
	///////////////////////////////////////////////////////////////////////////
	function zhOrderExe(sqlstr){
		
		var params ='&orderby='+sqlstr + "&tablename=" + tables[tabStatus-1];	
		
		var tparam = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(tparam=='&fusearchsql='){
			tparam ='&fusearchsql=1=1';
		}			    
	 	var sqlext = "sales";
		if($("#RightsGroup").val()=="10")
		{
			sqlext = "";
		}
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:"SelfConfigReport.queryByOrder" + sqlext,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'SelfConfigReport.queryByOrderpage' + sqlext
									});
		var fileds = "," + Dat.FieldName.join(",") + ",";
		fileds = fileds.replace(",groupid,",",getMultiValues(groupid,'sys_powergroup','groupid','groupname') groupid,");
		fileds = fileds.replace(",limitlogin,",",case limitlogin when 'true' then '是' when 'false' then '否' else limitlogin end limitlogin,");		
		fileds = fileds.replace(",ISDESTROY",",case ISDESTROY when 0 then '正常' when 1 then '已撤销' else to_char(ISDESTROY) end ISDESTROY");
		fileds = fileds.substring(1,fileds.length-1);
		fileds = tsd.encodeURIComponent(fileds);
		var link = urlstr1 + params  + "&area=" + tsd.encodeURIComponent($("#area").val()) + "&cols=" + fileds  + "&cols1=" + Dat.FieldName.join(",") + tparam;
					
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板		 	
	}
	
	function openSearch()
	{
		$("#queryName").val("查询");
		showDialog(1);
	}
	
	function openBatchDelete()
	{
		$("#queryName").val("删除");
		showDialog(1);
	}
	
	function openBatchEdit()
	{
		$("#queryName").val("修改");
		showDialog(1);
	}
	///////批操作
	function fuheExe()
	{
		var queryName= document.getElementById("queryName").value;
		if(queryName=="query")
		{
			fuheQuery();
		}
		else if(queryName=="queryset")
		{
			$("#Ctrl1_wheresql").val($("#fusearchsql").val().replace(/'/g,"\""));
			$("#Ctrl1_wheredesc").val($("#fusearchdesciption").val());
		}
	}
	
	
	/////复合查询
	function fuheQuery()
	{
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}				
	 	var sqlext = "sales";
		if($("#RightsGroup").val()=="10")
		{
			sqlext = "";
		}
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:'SelfConfigReport.fuheQueryByWhere' + sqlext,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'SelfConfigReport.fuheQueryByWherepage' + sqlext
									});
		var fileds = "," + Dat.FieldName.join(",") + ",";
		fileds = fileds.replace(",groupid,",",getMultiValues(groupid,'sys_powergroup','groupid','groupname') groupid,");
		fileds = fileds.replace(",limitlogin,",",case limitlogin when 'true' then '是' when 'false' then '否' else limitlogin end limitlogin,");		
		fileds = fileds.replace(",ISDESTROY",",case ISDESTROY when 0 then '正常' when 1 then '已撤销' else to_char(ISDESTROY) end ISDESTROY");
		fileds = fileds.substring(1,fileds.length-1);
		fileds = tsd.encodeURIComponent(fileds);
		var link = urlstr1 + params + "&area=" + tsd.encodeURIComponent($("#area").val()) + "&cols=" + fileds + "&cols1=" + Dat.FieldName.join(",") + "&tablename=" + tables[tabStatus-1];
		
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板			
	}
	
	//////////////////
	function setUserRight()
	{
		//alert($("#skrid").val()+":"+$("#imenuid").val()+":"+$("#zid").val());
		var allRi = fetchMultiPValue("set1Rate.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			$("#RightsGroup").val("0");
			$("#CrossAreaCancel").val("false");
			$("#AbleForCancel").val("false");
			return false;
		}
		if(allRi[0][0]=="all")
		{
			$("#RightsGroup").val("10");
			$("#CrossAreaCancel").val("true");
			$("#AbleForCancel").val("true");
			return true;
		}
		var rightgroup = 0;
		var crossareacancel = "false"; // 是否可以撤销其它人的自定义发票
		var ableforcancel = "false";
		for(var i = 0;i<allRi.length;i++){
			var rg = getCaption(allRi[i][0],'RightsGroup','');
					
			if(parseInt(rg,10)>rightgroup)
			{
				rightgroup = parseInt(rg,10);
			}
			if(getCaption(allRi[i][0],'CrossUserCancel','')=="true")
			{
				crossareacancel = "true";
			}
			if(getCaption(allRi[i][0],'AbleForCancel','')=="true")
			{
				crossareacancel = "true";
			}
		}
		//alert(addright+":"+delBright+":"+editBright);
		$("#RightsGroup").val(rightgroup);
		$("#CrossAreaCancel").val(crossareacancel);
		$("#AbleForCancel").val(ableforcancel);
	}
		
	function print()
	{
		var skrid = $("#skrid").val();
		var area = $("#area").val();
		var sqlparam = $("#fusearchsql").val();
		if($.trim(sqlparam)=="")
			sqlparam = " 1=1";
		if($("#RightsGroup").val()=="10")
		{
		
		}
		else if($("#RightsGroup").val()=="3")
		{
			sqlparam = sqlparam + " area='" + area + "' ";
		}
		else
		{
			sqlparam = sqlparam + " skrid='" + skrid + "' ";
		}
		var params = "&sql=" + cjkEncode(sqlparam);
		printThisReport1('<%=request.getParameter("imenuid")%>',
					'selfconfighz',params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
	}
	</script>
</head>

<body> 
<form name="childform" id="childform">
	<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	<input type="text" id="fusearchdesciption" name="fusearchdesciption" style="display: none"/>
</form>

<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 

<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
<!-- 语言 -->
<input type="hidden" id="lanType" name="lanType" value='<%=lanType %>' />

<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
<input type="hidden" name="languageType" id="languageType" value='<%=lanType %>' />
  	<div id="navBar">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		:		
	</div>
  	<!-- 资费设置导航条-->
	<div id='tariffBar' style="font-size: 14px; text-align: left;">
	</div>
  	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder1" onclick="openDiaO('selfconfigreport');">
			<!--排序--><fmt:message key="order.title" />
		</button>	   
	   <button type="button" id="gjcx1" onclick="openDiaQueryG('query','selfconfigreport');">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id="prt1" onclick="print()">
			<!--高级查询--><fmt:message key="global.print" />
		</button>
	</div>
	
	<div id="gridd">
	    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>

	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder2" onclick="openDiaO('selfconfigreport');">
			<!--排序--><fmt:message key="order.title" />
		</button>
	   <button type="button" id="gjcx2" onclick="openDiaQueryG('query','selfconfigreport');">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id="prt2" onclick="print()">
			<fmt:message key="global.print" />
		</button>
	</div>
	
		
	<!-- Number 1 一 Search -->
	<form class="neirong" id="se_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						工号管理 简单查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from1Close').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_userid"><!-- 工号 -->
							<span id="Ctrl1_Sel_Lbl_userid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_userid" id="Ctrl1_Sel_userid" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_username"><!-- 姓名 -->
							<span id="Ctrl1_Sel_Lbl_username"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_username" id="Ctrl1_Sel_username" class="textclass" />
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from1search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="se_from1Close">
				关闭
			</button>
		</div>
	</form>
	
	<form class="neirong" id="lk_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						工号解锁与锁定
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#lk_from1Close').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_lk_userid"><!-- 工号 -->
							<span id="Ctrl1_lk_Lbl_userid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_lk_userid" id="Ctrl1_lk_userid" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<span id="Ctrl1_lk_Lbl_state">状态</span>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_lk_state" id="Ctrl1_lk_state" class="textclass">
							<option value="false">解除锁定</option>
							<option value="true">锁定工号</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="lk_from1search" onclick="userUnlock()">
				确定
			</button>
			<button type="button" class="tsdbutton" id="lk_from1Close">
				关闭
			</button>
		</div>
	</form>
	
	<!-- Number 1 一 -->
	<form class="neirong" id="vi_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						工号管理 详细信息
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#vi_from1Close').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;overflow-x:hidden;">
			<table style="width:100%">
				<tr>
					<td class="labelclass" width="16%;">
						<label for="Ctrl1_vi_userid"><!-- 工号 -->
							<span id="Ctrl1_vi_Lbl_userid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">					
						<span id="Ctrl1_vi_userid"></span>						
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_username"><!-- 姓名 -->
							<span id="Ctrl1_vi_Lbl_username"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_username"></span>   
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_password"><!-- 密码 -->
							<span id="Ctrl1_vi_Lbl_password"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_password"></span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_last_login"><!-- 上次登陆 -->
							<span id="Ctrl1_vi_Lbl_Last_login">上次登陆</span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_Last_login"></span>			
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_groupid"><!-- 权限组  -->
							<span id="Ctrl1_vi_Lbl_groupid"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_groupid" ></span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_departname"><!-- 部门  -->
							<span id="Ctrl1_vi_Lbl_departname"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_departname"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_userarea"><!-- 管理区域  -->
							<span id="Ctrl1_vi_Lbl_userarea"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_userarea"></span>
					</td>
					<td class="labelclass" width="16%">
						<span id="Ctrl1_vi_Lbl_chargename">营业区域</span>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_chargename"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_canloginip"><!-- 可登陆IP  -->
							<span id="Ctrl1_vi_Lbl_canloginip"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle" colspan="3">
						<span id="Ctrl1_vi_canloginip"></span>
						<div id="Ctrl1_vi_canloginip_tab_container"><table id="Ctrl1_vi_canloginip_tab"></table></div>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_linktel"><!-- 联系电话  -->
							<span id="Ctrl1_vi_Lbl_linktel"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_linktel"></span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_email"><!-- EMail  -->
							<span id="Ctrl1_vi_Lbl_email"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_email"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_limitlogin"><!-- 限制登陆  -->
							<span id="Ctrl1_vi_Lbl_limitlogin"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_limitlogin"></span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_logined"><!-- 登陆状态  -->
							<span id="Ctrl1_vi_Lbl_logined"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<span id="Ctrl1_vi_logined"></span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_vi_bz"><!-- 备注  -->
							<span id="Ctrl1_vi_Lbl_bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle" colspan="3">
						<span id="Ctrl1_vi_bz"></span><span style="display:inline-block;visibility:hidden">1</span>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="vi_from1search" style="display:none;">
				查询
			</button>
			<button type="button" class="tsdbutton" id="vi_from1Close">
				关闭
			</button>
		</div>
	</form>	
	
	<!-- 添加模板面板 -->
	<div id="modT" name='modT' style="display: none"  class="neirong">
		<br/>
		<div class="top">
		<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" >功能名称</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
			</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
			<div class="midd" >
			<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
				
				  	<tr >
					    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
					    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
					    	<input type="text" name="name_mod" id="name_mod" onpropertychange="TextUtil.NotMax(this)" maxlength="50" class="textclass"/>
					    	
					    	<font style="color: #ff0000;">*</font></td>
					    
					    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
					    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
										    
					     <td width="12%" align="right"  class="labelclass"></td>
				    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
				    	
				 	 </tr>	
			  
				</table>
			</form>	
			<div class="midd_butt">
			<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="addQuery()" ><fmt:message key="global.save" /></button>
		 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod()" ><fmt:message key="global.close" /></button>
			</div>	
		</div>
	</div>
	
	<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:800px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv">选择您要导出的数据字段</div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			   <form action="#" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>li
							<div id="thelistform" style="margin-left: 10px;max-height: 200px">
						
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
				全选
			</button>
			<button type="submit" class="tsdbutton" id="query" onclick="DownSure()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>			
		</div>
	</div>	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />
	
	<!-- 查询树信息存放 -->
	<input type="hidden" id='treepid' />	
	<input type="hidden" id='treecid' />	
	<input type="hidden" id='treestr' />	
	<input type="hidden" id='treepic' />
	
	<!-- 高级查询 模板隐藏域 -->
	<input type="hidden" id="queryright"/>
	<input type="hidden" id="queryMright"/>
	<input type="hidden" id="saveQueryMright"/>		
	
	<input type="hidden" id="useridd" value="<%=session.getAttribute("userid") %>"/>
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=session.getAttribute("languageType") %>' />
	
	<input type="hidden" id="addright" />
	<input type="hidden" id="deleteright" />
	<input type="hidden" id="editright" />
	<input type="hidden" id="delBright" />
	<input type="hidden" id="editBright" />
	<input type="hidden" id="exportright" />
	<input type="hidden" id="printright" />
	<input type="hidden" id="RightsGroup" />
	<input type="hidden" id="CrossAreaCancel" />
	<input type="hidden" id="AbleForCancel" />
	<input type="hidden" id="queryright" />
	<input type="hidden" id="saveQueryMright" />
	<input type="hidden" id="operationtips"	value="<fmt:message key="global.operationtips"/>" />
	<input type="hidden" id="successful" value="<fmt:message key="global.successful"/>" />
</body>
</html>