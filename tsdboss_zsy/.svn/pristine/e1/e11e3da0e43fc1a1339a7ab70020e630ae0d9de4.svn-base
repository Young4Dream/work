<%----------------------------------------
	name: CallPay.jsp
	author: 陈泽
	version: 1.0, 2010-5-19
	description: 催缴策略管理
	modify: 	
		2009-11-13 youhongyu oracle移植	
		2010-12-21 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
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
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>  
    
    
	<style type="text/css">
		#V1,#V2,#V3,#V4{height:0px;}
		#editgrid a{font-weight:bold;}
		body{text-align:left;}
		input,select{margin-left:0px;}
		
		.textclass{width:180px;margin-left:0px;}
		
		.spanstyle{display:-moz-inline-box; display:inline-block; width:135px}
		
		.disabledStar{display:none;}
		.tdstyle{border-bottom:1px solid #A9C8D9;line-height:32px;}
	</style>
	
	<script type="text/javascript">
	var Dat = "";
	var tabStatus = 1;
	
	var tables = ['callpay_shedule_base','callpay_shedule_owemonth','callpay_shedule_interval','callpay_shedule_ringinterval','callpay_shedule_callcount','callpay_shedule_telnoday','callpay_shedule_enabletime'];
	var pkeys = ["Rate1Feilu","Rate1Jcfeilu","Rate1Fljm","Rate1Charge_Type"];
	var fuheM = false;
	
	var firstLoad = [true,true,true,true,true,true,true];
	var mNames = [
				'催缴基本策略','催缴策略_欠费月数','催缴策略_催缴间隔','催缴策略_外拨间隔','催缴策略_催缴次数','催缴策略_分段催缴','催缴策略_催缴时间'
				];
	//用于数据格式的验证
	var regularExp = [];
	regularExp["integer"] = /^\d+$/;
	regularExp["double"] = /^\d+|\d+\.\d+$/;
	//修改数据时保存原记录
	var sourceData = new Array();
	/**
	 * 页面初始化
	 * @param 无参数
	 * @return 无返回值
	 */
	$(function(){
		$("#navBar").append(genNavv());
		$("#tabs").tabs();
		
		setUserRight();
		
		getI118n();
		loadFeilu(Dat);
		
		$("#close21").click(function(){fuheM=false;});	
		//测试
		//vValid("ST7","ST7_ld");
		
		//初始化面板面板里的下拉列表
		InitialDropdownList();		
		initialSheduleNo();
	});
	
	/**
	 * 取字符串长度
	 * @param str
	 * @return int
	 */
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
	/**
	 * 改变jgride表格
	 * @param 无参数
	 * @return 无返回值
	 */
	function tabsChg(id)
	{
		$("#gridd").empty();
		$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
		//$("#editgrid").empty();
		$("#queryName").val("");
		$("#fusearchsql").val("");
		switch(id)
		{
			case 1:
				tabStatus=1;
				break;
			case 2:
				tabStatus=2;
				break;
			case 3:
				tabStatus=3;
				break;
			case 4:
				tabStatus=4;
				break;
			case 5:
				tabStatus=5;
				break;
			case 6:
				tabStatus=6;
				break;
			case 7:
				tabStatus=7;
				break;
			default:
				tabStatus=1;
		}
		
		getI118n();
		loadFeilu(Dat);
		$("#editgrid").trigger("reloadGrid");
	}
	
	/**
	 * 加载jgride
	 * @param models(遍历结果集的列名)
	 * @return 无返回值
	 */
	function loadFeilu(models)
	{
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'CallPay.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'CallPay.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		
		$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + '&cols=' + models.FieldName.join(",") + "&tablename=" + tables[tabStatus-1],
				datatype: 'xml', 
				colNames:models.colNames,//["<fmt:message key='global.operation' />","NetName","Bjzg","Bjdm","Jbjcm","Jbfl","Tfjcm","Tffl","Qjms","Fuf","Fjf","Fjl","Jmlx",'rowguid'], 
				colModel:models.colModels, 
		       	rowNum:10, //默认分页行数
		       	rowList:[10,15,20], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/',
		       	pager: jQuery('#pagered'), 
		       	sortname: 'Xuhao', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'asc',//默认排序方式 
		       	caption:mNames[tabStatus-1], 
		       	height:260, //高
		       	//width:document.documentElement.clientWidth-27,
		       	loadComplete:function(){
								////@1  表格的id
								////@2  链接名称
								////@3  链接地址或者函数名称
								////@4  行主键列的名称 可以是隐藏列
								////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
								////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'openRowModify','Xuhao','click',1);
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','Xuhao','click',2);
							    /****执行行按钮添加********
								*@1 表格ID
								*@2 操作按钮数量 等于定义数量
								*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
								executeAddBtn('editgrid',2);
								
								
							}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}

	/**
	 * 取国际化信息
	 * @param 无参数
	 * @return 无返回值
	 */
	function getI118n()
	{
		
		//alert(tabStatus-1);
		Dat = loadData(tables[tabStatus-1],$("#languageType").val(),1,"修改|删除");	
				
		var i = 0;
		if(firstLoad[tabStatus-1])
		{
			//设置新增面板别名
			var labels = $("#cl_from"+(tabStatus) + " label");			
			var temp = "";
			$.each(labels,function(i,n){
				
				temp = $(n).attr("for");
				temp = temp.replace("Ctrl"+tabStatus+"_","");
				
				$("#" + "Ctrl" + tabStatus + "_" + "Lbl_" + temp).text(Dat.getFieldAliasByFieldName(temp));				
			});
			//添加红色星号
			//HighLight();
			//alert($("#NetName_label_1").text());
			
			//设置查询面板
			var labels = $("#se_from"+(tabStatus) + " label");			
			var temp = "";
			$.each(labels,function(i,n){
				
				temp = $(n).attr("for");
				temp = temp.replace("Ctrl"+tabStatus+"_Sel_","");
				
				$("#" + "Ctrl" + tabStatus + "_Sel_" + "Lbl_" + temp).text(Dat.getFieldAliasByFieldName(temp));				
			});
			
			firstLoad[tabStatus-1] = false;
		}		
	}
	
	/**
	 * 加星显示关键字
	 * @param 无参数
	 * @return 无返回值
	 */
	function HighLight()
	{
		$("#Ctrl" + tabStatus + "_Xuhao").parent().append("<span style=\"color:#FF0000;\">*</span>");			
	}
	
	/**
	 * 初始化添加面板里的下拉框
	 * @param 无参数
	 * @return 无返回值
	 */
	function InitialDropdownList()
	{
		//科目
		var kemu = fetchMultiValue("CallPay.Kemu",6,"");
		var kemuhtml = "";
		
		if(kemu!=undefined && kemu[0]!=undefined)
		{
			for(var i=0;i<kemu.length;i++)
			{
				kemuhtml = kemuhtml + "<option value=\"" + kemu[i] + "\">" + kemu[i] + "</option>"
			}
		}
		$("#Ctrl1_Kemu").html(kemuhtml);
		$("#Ctrl1_Sel_Kemu").html("<option value=\"\">请选择</option>" + kemuhtml);
		
		//节假日类型
		var jb = fetchMultiArrayValue("CallPay.Holiday",2,"");
		var jbhtml = "";
		if(jb[0]!=undefined && jb[0][0]!=undefined)
		{
			for(var i=0;i<jb.length;i++)
			{
				jbhtml = jbhtml + "<option value=\"" + jb[i][0] + "\">" + jb[i][0] + "</option>";
				
			}
		}
		$("#Ctrl7_HoliDay_Type").html(jbhtml);
		$("#Ctrl7_Sel_HoliDay_Type").html("<option value=\"\">请选择</option>" + jbhtml);
		
		var xuhaohtml = "";
		for(var i=1;i<=50;i++)
		{
			xuhaohtml = xuhaohtml + "<option value=\"" + i + "\">" + i + "</option>";
		}
		
		$("#Ctrl1_Xuhao").html(xuhaohtml);
		$("#Ctrl2_Xuhao").html(xuhaohtml);
		$("#Ctrl3_Xuhao").html(xuhaohtml);
		$("#Ctrl4_Xuhao").html(xuhaohtml);
		$("#Ctrl5_Xuhao").html(xuhaohtml);
		$("#Ctrl6_Xuhao").html(xuhaohtml);
		$("#Ctrl7_Xuhao").html(xuhaohtml);
			
	}

	/**
	 * 初始化策略名称
	 * @param 无参数
	 * @return 无返回值
	 */
	function initialSheduleNo()
	{
		//策略名称
		var shdelue = fetchMultiValue("CallPay.SheduleNo",6,"");
		
		if(shdelue!=undefined && shdelue[0]!=undefined)
		{
			var htmll = "";
			for(var i=0;i<shdelue.length;i++)
			{
				htmll = htmll + "<option value=\"" + shdelue[i] + "\">" + shdelue[i] + "</option>";
			}
			
			//$("#Ctrl1_SheduleNo_XH").html(htmll);
			$("#Ctrl2_SheduleNo").html(htmll);
			$("#Ctrl3_SheduleNo").html(htmll);
			$("#Ctrl4_SheduleNo").html(htmll);
			$("#Ctrl5_SheduleNo").html(htmll);
			$("#Ctrl6_SheduleNo").html(htmll);
			$("#Ctrl7_SheduleNo").html(htmll);
			$("#Ctrl1_Sel_SheduleNo").html("<option value=\"\">请选择</option>" + htmll);
			$("#Ctrl2_Sel_SheduleNo").html("<option value=\"\">请选择</option>" + htmll);
			$("#Ctrl3_Sel_SheduleNo").html("<option value=\"\">请选择</option>" + htmll);
			$("#Ctrl4_Sel_SheduleNo").html("<option value=\"\">请选择</option>" + htmll);
			$("#Ctrl5_Sel_SheduleNo").html("<option value=\"\">请选择</option>" + htmll);
			$("#Ctrl6_Sel_SheduleNo").html("<option value=\"\">请选择</option>" + htmll);
			$("#Ctrl7_Sel_SheduleNo").html("<option value=\"\">请选择</option>" + htmll);
		}
	}
		
	/**
	 * 禁用主键的表单
	 * @param 无参数
	 * @return 无返回值
	 */
	function disablePrimary()
	{
		$("#Ctrl"+tabStatus+"_Xuhao").attr("disabled","disabled");
		//$("#Ctrl"+tabStatus+"_Xuhao_XH").attr("disabled","disabled");
	}
	
	/**
	 * 恢复所有表单可用
	 * @param 无参数
	 * @return 无返回值
	 */
	function makeAllEnabled()
	{
		$("#Ctrl"+tabStatus+"_Xuhao").removeAttr("disabled");
		//$("#Ctrl"+tabStatus+"_Xuhao_XH").removeAttr("disabled");
	}
	
	/**
	 * 取值 用于复合修改 第二个参数决定是否给字符串值加引号 用于增加
	 * @param fieldname(字段名字)
	 * @return String
	 */
	function getValue(fieldname)
	{
		var idx = $.inArray(fieldname,Dat.FieldName);
		var dType = Dat.DataType[idx];
		var vall = $("#"+fieldname+"_"+tabStatus).val();
		var res = vall;
		if(dType=='dtString')
		{
			if(typeof arguments[1]=='undefined')
				res = "'"+vall+"'";//字符串类型需用单引号引起来
			else
				res = vall;
		}
		else if(dType=='dtInteger'&&vall=='')
		{
			res = "0";
		}
		else if(dType=='dtDouble'&&vall=='')
		{
			res = "0"
		}
		return res;
	}
	
	/**
	 * 更换按钮状态 0修改  1新增   2查询
	 * @param sta(状态)
	 * @return 无返回值
	 */
	function toggleBtn(sta)
	{
		if(sta==0)
		{
			$("#cl_from"+tabStatus+"save").hide();
			$("#cl_from"+tabStatus+"exit").hide();
			$("#cl_from"+tabStatus+"modify").show();
			$("#cl_from"+tabStatus+"search").hide();
		}
		else if(sta==1)
		{
			$("#cl_from"+tabStatus+"save").show();
			$("#cl_from"+tabStatus+"exit").show();
			$("#cl_from"+tabStatus+"modify").hide();
			$("#cl_from"+tabStatus+"search").hide();
		}
		else if(sta==2)
		{
			$("#cl_from"+tabStatus+"save").hide();
			$("#cl_from"+tabStatus+"exit").hide();
			$("#cl_from"+tabStatus+"modify").hide();
			$("#cl_from"+tabStatus+"search").show();
		}
	}
	
	/**
	 * 打开修改面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openRowModify()
	{
		if($("#editright").val()=="false")
		{
			alert("你没有修改权限");
			//return false;
		}
		else
		{
			clearText("cl_from" + tabStatus);
			toggleBtn(0);
			disablePrimary();
			//生成参数串
			var params = "&Xuhao=" + tsd.encodeURIComponent(arguments[0]);
						
			$("#cl_from"+tabStatus+"modify").data("modifystr",params);
			
			//alert(params);
			//取如参数字段对应的数据
			//var res = fetchMultiArrayValue(pkeys[tabStatus-1]+".queryByKey",2,params);
			delete sourceData;
			sourceData = new Array();
			
			var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xmlattr',//返回数据格式 
				tsdpk:"CallPay.queryByKey"
				});
			
			$.ajax({
				url:"mainServlet.html?" + urlMm + params + "&tablename=" + tables[tabStatus-1],
				async:false,
				cache:false,
				timeout:1000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						var lables = $("#cl_from" + tabStatus + " label");
						//$.each(lables,function(i,n){
						for(var k=0;k<lables.length;k++)
						{
							var tmp = $(lables[k]).attr("for");
							
							tmp = tmp.replace("Ctrl"+tabStatus+"_","");
							
							$("#Ctrl"+tabStatus+"_"+tmp).val($(this).attr(tmp.toLowerCase()));
							
							sourceData[tmp] = $(this).attr(tmp.toLowerCase());
						}	
					});
				}
			});
			
			autoBlockFormAndSetWH("cl_from"+tabStatus,60,10,"cl_from"+tabStatus+"Close","#FFFFFF",true,750,'auto');
		}
	}
	
	/**
	 * 添加记录
	 * @param 无参数
	 * @return boolean
	 */
	function addForFeilu()
	{	
		var j=0;
		var queryStr = "";
		
		var cxuhao = $("#Ctrl" + tabStatus + "_Xuhao").val();
		
		if(cxuhao=="")
		{
			alert("序号不能为空");
			$("#Ctrl" + tabStatus + "_Xuhao").select();
			$("#Ctrl" + tabStatus + "_Xuhao").focus();
			return false;								
		}
		
		if(isNaN(parseInt(cxuhao)))
		{
			alert("序号必须为有效的数字");
			$("#Ctrl" + tabStatus + "_Xuhao").select();
			$("#Ctrl" + tabStatus + "_Xuhao").focus();
			return false;
		}
		
		//拼接主键参数，用于验证数据是否已存在
		queryStr += "&Xuhao=";
		
		tsd.QualifiedVal=true;
		queryStr += tsd.encodeURIComponent(cxuhao);
		if(tsd.Qualified()==false){$("#Ctrl" + tabStatus + "_Xuhao").select();$("#Ctrl" + tabStatus + "_Xuhao").focus();return false;}
		
		queryStr += "&tablename=";
		queryStr += tables[tabStatus-1];
		
		var res = fetchSingleValue("CallPay.existed",6,queryStr);
		if(parseInt(res)>0)
		{
			alert("你所输入的序号"+cxuhao+" 已存在,请重新输入.");
			//第一个主键输入框获得焦点
			$("#Ctrl" + tabStatus + "_Xuhao").select();
			$("#Ctrl" + tabStatus + "_Xuhao").focus();
			return false;
		}
		//清空queryStr;
		queryStr = "";		
		
		//日志信息
		var loginfo = "";
		
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		loginfo += tsd.encodeURIComponent(mNames[tabStatus-1]);
		loginfo += ";TableName:";
		loginfo += tables[tabStatus-1];
		loginfo += ";";

		//拼接参数串
		var lables = $("#cl_from" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			
			var dtype = $("#"+tmp).attr("dtype");
			var tvalue = $("#" + tmp).val();
			
			if(tmp=='Ctrl7_StartTime' && tvalue==''){
					alert("请输入"+$("#Ctrl7_Lbl_StartTime").text());
					$("#"+tmp).focus();
					return false;
			}
			if(tmp=='Ctrl7_EndTime' && tvalue==''){
					alert("请输入"+$("#Ctrl7_Lbl_EndTime").text());
					$("#"+tmp).focus();
					return false;
			}
			
			if(dtype!=undefined)
			{
				if((dtype=="integer" || dtype=="double") && tvalue=="")
				{
					tvalue = "0";
				}
				if(!regularExp[dtype].test(tvalue))
				{
					alert($.trim($(lables[k]).text()) + "数据格式不正确,必须为有效的" + getType(dtype) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}
			}
			//如果是计费类别费率减免的备注 默认为空格
			if(tabStatus==4 && tmp=="Bz_4" && $("#" + tmp).val()=="")
			{
				$("#" + tmp).val(" ");
			}
			
			queryStr += "&";
			queryStr += tmp.replace("Ctrl"+tabStatus+"_","");
			queryStr += "=";
			queryStr += tsd.encodeURIComponent(tvalue);
			
			
			loginfo += tsd.encodeURIComponent(Dat.getFieldAliasByFieldName(tmp.replace("Ctrl"+tabStatus+"_","")));
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(tvalue)
			loginfo += ";";
			
		}
		
		if(tsd.Qualified()==false){return false;}
		
		var res = executeNoQuery("CallPay.add" + tabStatus,6,queryStr);
		
		if(res=="true"||res==true)
		{
			alert("<fmt:message key='global.successful' />");
			
			writeLogInfo("","add",loginfo);
		}
		
		$("#editgrid").trigger("reloadGrid");
		clearText("cl_from"+tabStatus);
		//第一个主键输入框获得焦点
		$("#Ctrl"+tabStatus+"_Xuhao").select();
		$("#Ctrl"+tabStatus+"_Xuhao").focus();
		
		initialSheduleNo();
		InitialDropdownList();
		
		return true;
	}

	/**
	 * 保存退出函数
	 * @param 无参数
	 * @return 无返回值
	 */
	function addForExit()
	{
		var res = addForFeilu();
		if(res) setTimeout($.unblockUI, 15);
	}
	
	function getType(type)
	{
		if(type=="integer")
		{
			return "整数";
		}
		else if(type=="double")
		{
			return "数字";
		}
		if(type=="datetime")
		{
			return "日期";
		}
		else
		{
			return "字符串";
		}
	}

	/**
	 * 修改数据
	 * @param 无参数
	 * @return 无返回值
	 */
	function ModifyData()
	{
		//alert("O:"+ObuildParams());
		//return false;
		//修改参数
		var querystr = "";
		
		//日志信息
		var loginfo = "";
		
		loginfo += tsd.encodeURIComponent(mNames[tabStatus-1]);
		loginfo += ";TableName:";
		loginfo += tables[tabStatus-1];
		loginfo += ";";
		
		
		//拼接参数串
		var lables = $("#cl_from" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			
			var dtype = $("#"+tmp).attr("dtype");
			var tvalue = $("#" + tmp).val();
							
			if(dtype!=undefined)
			{
				if((dtype=="integer" || dtype=="double") && tvalue=="")
				{
					tvalue = "0";
				}
				if(!regularExp[dtype].test(tvalue))//格式验证
				{
					alert($.trim($(lables[k]).text()) + "数据格式不正确,必须为有效的" + getType(dtype) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}					
			}
			
			
			var fieldname = tmp.replace("Ctrl"+tabStatus+"_","");
			
			//如果是计费类别费率减免的备注 默认为空格
			if(tmp=="Ctrl"+tabStatus+"_Bz" && tvalue=="")
			{
				tvalue = " ";
			}
			
			//拼参数
			querystr += "&";
			querystr += fieldname;
			querystr += "=";
			querystr += tsd.encodeURIComponent(tvalue);
		
			//记录有修改的字段
			if(tvalue!=sourceData[fieldname])
			{
				loginfo += tsd.encodeURIComponent(Dat.getFieldAliasByFieldName(fieldname));
				loginfo += ":";
				loginfo += tsd.encodeURIComponent(sourceData[fieldname]);
				loginfo += ">>>";
				loginfo += tsd.encodeURIComponent(tvalue);
				loginfo += ";";
			}
						
		}
		
								
		var res = executeNoQuery("CallPay.modify"+tabStatus,6,querystr);
		if(res=="true"||res==true)
		{
			alert("修改数据成功");				
			writeLogInfo("","modify",loginfo);
		}
		setTimeout($.unblockUI, 15);//关闭面板
		$("#editgrid").trigger("reloadGrid");//重新加载数据
	
	}
	
	/**
	 * 删除记录
	 * @param 无参数
	 * @return 无返回值
	 */
	function deleteRow()
	{
		if($("#deleteright").val()=="false")
		{
			alert("你没有删除权限");
			//return false;
		}
		else
		{//生成参数串
			var params = "&Xuhao="+tsd.encodeURIComponent(arguments[0]);
			params += "&tablename=";
			params += tables[tabStatus-1];
			//删除
			if(confirm("你确定要删除本条记录吗?"))
			{
				var res = executeNoQuery("CallPay.deleteByKey",6,params);
				if(res==true || res=="true")
				{
					//记日志
					var loginfo = "";			
					loginfo += mNames[tabStatus-1];
					loginfo += ";TableName:";
					loginfo += tables[tabStatus-1];
					loginfo += ";";
					loginfo = tsd.encodeURIComponent(loginfo);
					
					params = tsd.encodeURIComponent("序号:");
					params += tsd.encodeURIComponent(arguments[0]);
					
					loginfo = loginfo + params;
					
					writeLogInfo("","delete",loginfo);
					//重新加载数据
					$("#editgrid").trigger("reloadGrid");
				}
				else
				{
					//alert("删除失败");
				}
			}
			
		}
	}
	
	/**
	 * 打开添加面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openAddForm()
	{
		makeAllEnabled();
		toggleBtn(1);
		clearText("cl_from"+tabStatus);
				
		autoBlockFormAndSetWH("cl_from"+tabStatus,60,10,"cl_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		//$("#Ctrl"+tabStatus+"_Xuhao").focus();
	}
	
	/**
	 * 打开查询面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openSearchForm()
	{
		clearText("se_from"+tabStatus);
						
		autoBlockFormAndSetWH("se_from"+tabStatus,60,10,"se_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		
	}
	
	/**
	 * 打开对话框
	 * @param oper
	 * @param type
	 * @return 无返回值
	 */
	function showDialog(oper,type)
	{
		var t_name = tables[tabStatus-1];
			
		if(oper==0){
			openDiaO(t_name);
		}else {
			openDiaQueryG(type,t_name);
		}
		
		/**
		var page = oper==0?"order.jsp":"search.jsp";
		
		
		var winHW = (oper==0?"dialogWidth:610px; dialogHeight:320px;":"dialogWidth:680px; dialogHeight:580px;");
		//alert(t_name);
		//alert(oper);
		if(isFirefox=navigator.userAgent.indexOf("Firefox")>0){  
			window.showModalDialog("/tsd2009/queryServlet?tablename="+t_name+"&url=/"+page,window,winHW + " center:yes; scroll:no");
	    }
	    else{
			window.showModalDialog("/tsd2009/queryServlet?tablename="+t_name+"&url=/"+page,window,winHW + " center:yes; scroll:no");
		}
		*/
	}
	
	 /**
	 * 打开保存本次查询面板
	 	通过tabStatus，来判断是在哪个选项卡进行的操作
	 * @return 
	 */	
	function openSaveModPan(){
			var t_name = tables[tabStatus-1];
			openModT(t_name);					
	}
	/**
	 * 条件排序
	 * @param sqlstr(排序条件)
	 * @return 无返回值
	 */
	function zhOrderExe(sqlstr){
		
		var params ='&orderby='+sqlstr + "&tablename=" + tables[tabStatus-1];	
		
		var tparam = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(tparam=='&fusearchsql='){
			tparam ='&fusearchsql=1=1';
		}			    
	 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:"CallPay.queryByOrder",//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'CallPay.queryByOrderpage'
									});
		var link = urlstr1 + params  + "&cols=" + Dat.FieldName.join(",") + tparam;
					
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板		 	
	}
	
	/**
	 * 打开查询面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openSearch()
	{
		//$("#queryName").val("query");
		showDialog(1,'query');
	}
	
	/**
	 * 打开批量删除面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openBatchDelete()
	{
		//$("#queryName").val("delete");
		showDialog(1,'delete');
	}
	
	/**
	 * 打开批量修改面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openBatchEdit()
	{
		//$("#queryName").val("modify");
		showDialog(1,'modify');
	}
	
	/**
	 * 批操作
	 * @param 无参数
	 * @return 无返回值
	 */
	function fuheExe()
	{
		var queryName= document.getElementById("queryName").value;
		if(queryName=="query")
		{
			fuheQuery();
		}
	}
	
	/**
	 * 复合查询
	 * @param 无参数
	 * @return 无返回值
	 */
	function fuheQuery()
	{
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}				
	 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:'CallPay.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'CallPay.fuheQueryByWherepage'
									});
		
		var link = urlstr1 + params + "&cols=" + Dat.FieldName.join(",") + "&tablename=" + tables[tabStatus-1];
		
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板			
	}
	
	/**
	 * 设置权限
	 * @param 无参数
	 * @return 无返回值
	 */
	function setUserRight()
	{
		//alert($("#skrid").val()+":"+$("#imenuid").val()+":"+$("#zid").val());
		var allRi = fetchMultiPValue("set1Rate.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			return false;
		}
		if(allRi[0][0]=="all")
		{
			return true;
		}
		var addright = "false";
		var delBright = "false";
		var editBright = "false";
		
		var deleteright = "false";
		var editright = "false";
		
		var exportright = "false";
		var printright = "false";
		
		var queryright = "false";
		var saveQueryMright = "false";
				
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'add','')=="true")
				addright = "true";
			if(getCaption(allRi[i][0],'delB','')=="true")							
				delBright = "true"; 
			if(getCaption(allRi[i][0],'editB','')=="true")
				editBright = "true" ;
			if(getCaption(allRi[i][0],'delete','')=="true")
				deleteright = "true";
			if(getCaption(allRi[i][0],'edit','')=="true")							
				editright = "true";
			if(getCaption(allRi[i][0],'export','')=="true")
				exportright = "true" ;
			if(getCaption(allRi[i][0],'print','')=="true")
				printright = "true";
				
			if(getCaption(allRi[i][0],'query','')=="true")
				printright = "true";
				
			if(getCaption(allRi[i][0],'saveQueryM','')=="true")
				saveQueryMright = "true";
		}
		//alert(addright+":"+delBright+":"+editBright);
		$("#addright").val(addright);
		$("#delBright").val(delBright);
		$("#editBright").val(editBright);
		if(addright=="false")
		{
			$("#openadd1").attr("disabled","disabled");
			$("#openadd2").attr("disabled","disabled");
		}
		if(delBright=="false")
		{
			$("#opendel1").attr("disabled","disabled");
			$("#opendel2").attr("disabled","disabled");
		}
		if(editBright=="false")
		{
			$("#openmod1").attr("disabled","disabled");
			$("#openmod2").attr("disabled","disabled");
		}
		
		$("#editright").val(editright);
		$("#deleteright").val(deleteright);
		
		$("#exportright").val(exportright);
		$("#printright").val(printright);
		if(exportright=="false")
		{
			$("#export1").attr("disabled","disabled");
			$("#export2").attr("disabled","disabled");
		}
		if(printright=="false")
		{
			$("#print1").attr("disabled","disabled");
			$("#print2").attr("disabled","disabled");
		}
		
		if(queryright="false")
		{
			
			$("#gjcx1").attr("disabled","disabled");
			$("#gjcx2").attr("disabled","disabled");
		}
		
		
		if(saveQueryMright="false")
		{
			
			$("#savequery1").attr("disabled","disabled");
			$("#savequery2").attr("disabled","disabled");
		}
		//alert(editright+":"+deleteright+":"+exportright);
	}
	
	/**
	 * 下载文件
	 * @param 无参数
	 * @return 无返回值
	 */
	function DownFile()
	{
	/**
		var urlstr=tsd.buildParams({ packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'datafileDown',//返回数据格式 
										  tsdpk:'main.Export'
										});
		var param = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
			if(param=='&fusearchsql='){
				param +='1=1';
			}
		param += "&cols=";
		param += Dat.FieldName.join(",");
		param += "&table=";
		param += tables[tabStatus-1];
		
		if($("#download").size()==0)
			$("body").append("<iframe id='download' name='download' width='0' height='0'></iframe>");
		$("#download").attr("src","mainServlet.html?"+urlstr+param);
		*/
		
		thisDownLoad('tsdBilling','mssql',tables[tabStatus-1],$("#lanType").val(),5);
	}
	
	/**
	 * 下载文件
	 * @param 无参数
	 * @return 无返回值
	 */
	function DownSure()
	{
		getTheCheckedFields('tsdBilling','mssql',tables[tabStatus-1]);
	}
	
	/**
	 * 打印报表
	 * @param 无参数
	 * @return 无返回值
	 */
	function printR()
	{
		var params = ''+$("#fusearchsql").val();			
		if(params==''){
			params ='1=1';
		}
		printThisReport("set1rate" + tables[tabStatus-1],"&fusearchsql="+encodeURIComponent(cjkEncode($.trim(params))));
	}
	
	/**
	 * 保存本次高级查询方法
	 * @param 无参数
	 * @return 无返回值
	 */
	function addQuery(){
		saveModQuery(tabStatus);
	}
	
	/**
	 * 模板查询
	 * @param 无参数
	 * @return 无返回值
	 */
	function modQuery(){
		 openQueryM(tabStatus);
	}
	
	/**
	 * 简单查询
	 * @param 无参数
	 * @return 无返回值
	 */
	function SimpleSearch()
	{
		var queryStr = "";
		//拼接参数串
		var lables = $("#se_from" + tabStatus + " label");
		//$.each(lables,function(i,n){
		for(var k=0;k<lables.length;k++)
		{
			var tmp = $(lables[k]).attr("for");
			
			var dtype = $("#"+tmp).attr("dtype");
			var tvalue = $("#"+tmp).val();
			
			if(tvalue!="" && tvalue!=null)
			{
				if(dtype!=undefined && !regularExp[dtype].test(tvalue))
				{
					alert($.trim($(lables[k]).text()) + "数据格式不正确,必须为有效的" + getType(dtype) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}
				
				queryStr += " and ";
				queryStr += tmp.replace("Ctrl"+tabStatus+"_Sel_","");
				
				queryStr += " = ";				
				
				if(dtype==undefined)
					queryStr += "'";
				
				tsd.QualifiedVal=true;	
				queryStr += tvalue;
				if(tsd.Qualified()==false){$("#"+tmp).select();$("#"+tmp).focus();return false;}
				
				if(dtype==undefined)
					queryStr += "'";
				
			}
		}
		if(queryStr=="")
		{
			alert("请至少提供一个查询条件");
			return false;
		}
		//去第一个逗号
		queryStr = queryStr.replace("and","");
		
		$("#fusearchsql").val(queryStr);		
		fuheQuery();
	}
	</script>
</head>

<body> 
<form name="childform" id="childform">
	<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
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
    	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder1" onclick="showDialog(0)">
			<!--排序--><fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd1" onclick="openAddForm()">
			<!--添加--><fmt:message key="global.add" />
	    </button>
	    <button type="button" onclick="openSearchForm()">
			<!--查询-->
			<fmt:message key="global.query" />
		</button>
		<button onclick='modQuery()' id='mbquery1'>
				<fmt:message key="oper.mod"/>
		</button>
	   <button type="button" id="gjcx1" onclick="openSearch()">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id='savequery1' onclick="openSaveModPan()">
				<fmt:message key="oper.modSave"/>
		</button>
		<button type="button" id="export1" onclick="DownFile()"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>
	</div>
	<!-- Tabs -->
	<div id="tabs">	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span>催缴基本策略</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span>催缴策略_欠费月数</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(3)"><span>催缴策略_催缴间隔</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(4)"><span>催缴策略_外拨间隔</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(5)"><span>催缴策略_催缴次数</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(6)"><span>催缴策略_分段催缴</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(7)"><span>催缴策略_催缴时间</span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>		
	</div>
	

	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder2" onclick="showDialog(0)">
			<!--排序--><fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd2" onclick="openAddForm()">
			<!--添加--><fmt:message key="global.add" />
	    </button>
	    <button type="button" onclick="openSearchForm()">
			<!--查询-->
			<fmt:message key="global.query" />
		</button> 
		<button onclick='modQuery()' id='mbquery2'>
				<fmt:message key="oper.mod"/>
		</button>
	   <button type="button" id="gjcx2" onclick="openSearch()">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id='savequery2' onclick="openSaveModPan()">
				<fmt:message key="oper.modSave"/>
		</button>
		<button type="button" id="export2" onclick="DownFile()"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>
	</div>
	
	
	<!-- Number 1 一 -->
	<form class="neirong" id="cl_from1" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴基本策略
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from1Close').click();">关闭</a>
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
						<label for="Ctrl1_Xuhao"><!-- 序号 -->
							<span id="Ctrl1_Lbl_Xuhao"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">					
						<select id="Ctrl1_Xuhao" class="textclass">   
						</select>						
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl1_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input name="Ctrl1_SheduleNo" id="Ctrl1_SheduleNo" class="textclass" />   
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Kemu"><!-- 科目 -->
							<span id="Ctrl1_Lbl_Kemu"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_Kemu" id="Ctrl1_Kemu" class="textclass" ></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_MinFee"><!-- 余额下限 -->
							<span id="Ctrl1_Lbl_MinFee"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_MinFee" id="Ctrl1_MinFee" dtype="double" class="textclass"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_MaxFee"><!-- 余额上限 -->
							<span id="Ctrl1_Lbl_MaxFee"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_MaxFee" id="Ctrl1_MaxFee" dtype="double" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_MinDay"><!-- 剩余天数下限 -->
							<span id="Ctrl1_Lbl_MinDay"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_MinDay" id="Ctrl1_MinDay" dtype="integer" class="textclass" />						
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_MaxDay"><!-- 剩余天数上限 -->
							<span id="Ctrl1_Lbl_MaxDay"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_MaxDay" id="Ctrl1_MaxDay" dtype="integer" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Bz"><!-- 备注 -->
							<span id="Ctrl1_Lbl_Bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Bz" id="Ctrl1_Bz" class="textclass"></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from1save" onclick="addForFeilu()">
				保存添加
			</button>
			<button type="button" class="tsdbutton" id="cl_from1exit" onclick="addForExit()">
				保存退出
			</button>
			<button type="button" class="tsdbutton" id="cl_from1modify" onclick="ModifyData()">
				修改
			</button>
			<button type="button" class="tsdbutton" id="cl_from1search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="cl_from1Close">
				关闭
			</button>
		</div>
	</form>
	
	
	<!-- Number 2 二 -->
	<form class="neirong" id="cl_from2" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_欠费月数
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from2Close').click();">关闭</a>
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
						<label for="Ctrl2_Xuhao"><!-- 序号 -->
							<span id="Ctrl2_Lbl_Xuhao"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select id="Ctrl2_Xuhao" class="textclass">   
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl2_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl2_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl2_SheduleNo" id="Ctrl2_SheduleNo" class="textclass" ></select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl2_OweMonths"><!-- 允许欠费天数 -->
							<span id="Ctrl2_Lbl_OweMonths"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl2_OweMonths" id="Ctrl2_OweMonths" dtype="integer" class="textclass"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl2_Bz"><!-- 备注 -->
							<span id="Ctrl2_Lbl_Bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl2_Bz" id="Ctrl2_Bz" class="textclass" maxlength="200" ></input>						
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from2save" onclick="addForFeilu()">
				保存添加
			</button>
			<button type="button" class="tsdbutton" id="cl_from2exit" onclick="addForExit()">
				保存退出
			</button>
			<button type="button" class="tsdbutton" id="cl_from2modify" onclick="ModifyData()">
				修改
			</button>
			<button type="button" class="tsdbutton" id="cl_from2search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="cl_from2Close">
				关闭
			</button>
		</div>
	</form>
	
	<!-- Number 3 三 -->
	<form class="neirong" id="cl_from3" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_催缴间隔
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from3Close').click();">关闭</a>
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
						<label for="Ctrl3_Xuhao"><!-- 序号 -->
							<span id="Ctrl3_Lbl_Xuhao"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select id="Ctrl3_Xuhao"  class="textclass">   
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl3_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl3_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl3_SheduleNo" id="Ctrl3_SheduleNo" class="textclass" ></select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl3_IvMinutes"><!-- 催缴成功间隔分钟 -->
							<span id="Ctrl3_Lbl_IvMinutes"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl3_IvMinutes" id="Ctrl3_IvMinutes" dtype="integer"  class="textclass"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl3_Bz"><!-- 备注 -->
							<span id="Ctrl3_Lbl_Bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl3_Bz" id="Ctrl3_Bz" class="textclass" maxlength="200" ></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from3save" onclick="addForFeilu()">
				保存添加
			</button>
			<button type="button" class="tsdbutton" id="cl_from3exit" onclick="addForExit()">
				保存退出
			</button>
			<button type="button" class="tsdbutton" id="cl_from3modify" onclick="ModifyData()">
				修改
			</button>
			<button type="button" class="tsdbutton" id="cl_from3search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="cl_from3Close">
				关闭
			</button>
		</div>
	</form>
	
	
	<!-- Number 4 四 -->
	<form class="neirong" id="cl_from4" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_外拨间隔
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from4Close').click();">关闭</a>
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
						<label for="Ctrl4_Xuhao"><!-- 序号 -->
							<span id="Ctrl4_Lbl_Xuhao"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select id="Ctrl4_Xuhao"  class="textclass">   
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl4_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl4_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl4_SheduleNo" id="Ctrl4_SheduleNo" class="textclass" ></select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl4_IvMinutes"><!-- 外拨间隔分钟 -->
							<span id="Ctrl4_Lbl_IvMinutes"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl4_IvMinutes" id="Ctrl4_IvMinutes" dtype="integer"  class="textclass"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl4_Bz"><!-- 备注 -->
							<span id="Ctrl4_Lbl_Bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl4_Bz" id="Ctrl4_Bz" class="textclass" maxlength="200" ></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from4save" onclick="addForFeilu()">
				保存添加
			</button>
			<button type="button" class="tsdbutton" id="cl_from4exit" onclick="addForExit()">
				保存退出
			</button>
			<button type="button" class="tsdbutton" id="cl_from4modify" onclick="ModifyData()">
				修改
			</button>
			<button type="button" class="tsdbutton" id="cl_from4search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="cl_from4Close">
				关闭
			</button>
		</div>
	</form>
	
	<!-- Number 5 五 -->
	<form class="neirong" id="cl_from5" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_催缴次数
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from5Close').click();">关闭</a>
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
						<label for="Ctrl5_Xuhao"><!-- 序号 -->
							<span id="Ctrl5_Lbl_Xuhao"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select id="Ctrl5_Xuhao" class="textclass">   
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl5_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl5_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl5_SheduleNo" id="Ctrl5_SheduleNo" class="textclass" ></select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl5_CallCount"><!-- 降级前催缴次数 -->
							<span id="Ctrl5_Lbl_CallCount"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl5_CallCount" id="Ctrl5_CallCount" dtype="integer"  class="textclass"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl5_Bz"><!-- 备注 -->
							<span id="Ctrl5_Lbl_Bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl5_Bz" id="Ctrl5_Bz" class="textclass" maxlength="200" ></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from5save" onclick="addForFeilu()">
				保存添加
			</button>
			<button type="button" class="tsdbutton" id="cl_from5exit" onclick="addForExit()">
				保存退出
			</button>
			<button type="button" class="tsdbutton" id="cl_from5modify" onclick="ModifyData()">
				修改
			</button>
			<button type="button" class="tsdbutton" id="cl_from5search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="cl_from5Close">
				关闭
			</button>
		</div>
	</form>
	
	
	<!-- Number 6 六 -->
	<form class="neirong" id="cl_from6" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_分段催缴
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from6Close').click();">关闭</a>
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
						<label for="Ctrl6_Xuhao"><!-- 序号 -->
							<span id="Ctrl6_Lbl_Xuhao"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select id="Ctrl6_Xuhao"  class="textclass" >   
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl6_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl6_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl6_SheduleNo" id="Ctrl6_SheduleNo" class="textclass" ></select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl6_BeginTelNo"><!-- 起始电话 -->
							<span id="Ctrl6_Lbl_BeginTelNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl6_BeginTelNo" id="Ctrl6_BeginTelNo" class="textclass" maxlength="16"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl6_EndTelNo"><!-- 终止电话 -->
							<span id="Ctrl6_Lbl_EndTelNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl6_EndTelNo" id="Ctrl6_EndTelNo" class="textclass" maxlength="16" ></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl6_BeginDay"><!-- 起始日 -->
							<span id="Ctrl6_Lbl_BeginDay"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl6_BeginDay" id="Ctrl6_BeginDay" dtype="integer"  class="textclass"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl6_EndDay"><!-- 终止日 -->
							<span id="Ctrl6_Lbl_EndDay"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl6_EndDay" id="Ctrl6_EndDay" dtype="integer"  class="textclass" maxlength="200" ></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from6save" onclick="addForFeilu()">
				保存添加
			</button>
			<button type="button" class="tsdbutton" id="cl_from6exit" onclick="addForExit()">
				保存退出
			</button>
			<button type="button" class="tsdbutton" id="cl_from6modify" onclick="ModifyData()">
				修改
			</button>
			<button type="button" class="tsdbutton" id="cl_from6search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="cl_from6Close">
				关闭
			</button>
		</div>
	</form>
	
	
	<!-- Number 7  七 -->
	<form class="neirong" id="cl_from7" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						调级策略——禁停时间
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from7Close').click();">关闭</a>
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
						<label for="Ctrl7_Xuhao"><!-- 序号 -->
							<span id="Ctrl7_Lbl_Xuhao"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select id="Ctrl7_Xuhao"  class="textclass">   
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl7_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl7_SheduleNo" id="Ctrl7_SheduleNo" class="textclass" ></select>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_HoliDay_Type"><!-- 节假日类型 -->
							<span id="Ctrl7_Lbl_HoliDay_Type"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select type="text" name="Ctrl7_HoliDay_Type" id="Ctrl7_HoliDay_Type" class="textclass">
						
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_VoiceFile"><!-- 语音文件位置 -->
							<span id="Ctrl7_Lbl_VoiceFile"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl7_VoiceFile" id="Ctrl7_VoiceFile" class="textclass"></input>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_StartTime"><!-- 每月起始日 -->
							<span id="Ctrl7_Lbl_StartTime"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl7_StartTime" id="Ctrl7_StartTime" class="textclass" onfocus="WdatePicker({startDate:'00:00',dateFmt:'HH:mm',alwaysUseStartDate:true})" ></input>
						<span class="addred" style="color:#ff0000">*</span>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_EndTime"><!-- 每月终止日 -->
							<span id="Ctrl7_Lbl_EndTime"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl7_EndTime" id="Ctrl7_EndTime" class="textclass" onfocus="WdatePicker({startDate:'00:00',dateFmt:'HH:mm',alwaysUseStartDate:true})"></input>
						<span class="addred" style="color:#ff0000">*</span>
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_SMS_Contents"><!-- 短信内容 -->
							<span id="Ctrl7_Lbl_SMS_Contents"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl7_SMS_Contents" id="Ctrl7_SMS_Contents" class="textclass"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_Bz"><!-- 备注 -->
							<span id="Ctrl7_Lbl_Bz"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl7_Bz" id="Ctrl7_Bz" class="textclass"></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from7save" onclick="addForFeilu()">
				保存添加
			</button>
			<button type="button" class="tsdbutton" id="cl_from7exit" onclick="addForExit()">
				保存退出
			</button>
			<button type="button" class="tsdbutton" id="cl_from7modify" onclick="ModifyData()">
				修改
			</button>
			<button type="button" class="tsdbutton" id="cl_from7search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="cl_from7Close">
				关闭
			</button>
		</div>
	</form>
	
	
	<!-- Number 1 一 Search -->
	<form class="neirong" id="se_from1" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴基本策略 简单查询
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
						<label for="Ctrl1_Sel_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl1_Sel_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select id="Ctrl1_Sel_SheduleNo" class="textclass" >   
						</select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_Kemu"><!-- 科目 -->
							<span id="Ctrl1_Sel_Lbl_Kemu"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_Sel_Kemu" id="Ctrl1_Sel_Kemu" class="textclass" ></select>
					</td>
				</tr>
				<tr>					
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_MinFee"><!-- 余额下限 -->
							<span id="Ctrl1_Sel_Lbl_MinFee"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_MinFee" id="Ctrl1_Sel_MinFee" dtype="integer" class="textclass" />						
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_MaxFee"><!-- 余额上限 -->
							<span id="Ctrl1_Sel_Lbl_MaxFee"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_MaxFee" id="Ctrl1_Sel_MaxFee" dtype="integer" class="textclass" />
					</td>
				</tr>
				<tr>					
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_MinDay"><!-- 剩余天数下限 -->
							<span id="Ctrl1_Sel_Lbl_MinDay"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_MinDay" id="Ctrl1_Sel_MinDay" dtype="integer" class="textclass" />						
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_MaxDay"><!-- 剩余天数上限 -->
							<span id="Ctrl1_Sel_Lbl_MaxDay"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_MaxDay" id="Ctrl1_Sel_MaxDay" dtype="integer" class="textclass" />
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
	
	
	<!-- Number 2 二 -->
	<form class="neirong" id="se_from2" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_欠费月数 简单查询 
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from2Close').click();">关闭</a>
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
						<label for="Ctrl2_Sel_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl2_Sel_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl2_Sel_SheduleNo" id="Ctrl2_Sel_SheduleNo" class="textclass" ></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl2_Sel_OweMonths"><!-- 两次降级间隔 -->
							<span id="Ctrl2_Sel_Lbl_OweMonths"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl2_Sel_OweMonths" dtype="integer"  id="Ctrl2_Sel_OweMonths" class="textclass"></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from2search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="se_from2Close">
				关闭
			</button>
		</div>
	</form>
	
	<!-- Number 3 三 -->
	<form class="neirong" id="se_from3" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_催缴间隔  简单查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from3Close').click();">关闭</a>
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
						<label for="Ctrl3_Sel_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl3_Sel_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl3_Sel_SheduleNo" id="Ctrl3_Sel_SheduleNo" class="textclass" ></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl3_Sel_IvMinutes"><!-- 降级前催缴次数 -->
							<span id="Ctrl3_Sel_Lbl_IvMinutes"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl3_Sel_IvMinutes" dtype="integer"  id="Ctrl3_Sel_IvMinutes" class="textclass"></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from3search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="se_from3Close">
				关闭
			</button>
		</div>
	</form>
	
	
	<!-- Number 4     四 -->
	<form class="neirong" id="se_from4" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_外拨间隔  简单查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from4Close').click();">关闭</a>
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
						<label for="Ctrl4_Sel_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl4_Sel_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl4_Sel_SheduleNo" id="Ctrl4_Sel_SheduleNo" class="textclass" ></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl4_Sel_IvMinutes"><!-- 降级前催缴次数 -->
							<span id="Ctrl4_Sel_Lbl_IvMinutes"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl4_Sel_IvMinutes" dtype="integer"  id="Ctrl4_Sel_IvMinutes" class="textclass"></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from4search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="se_from4Close">
				关闭
			</button>
		</div>
	</form>
	
	<!-- Number 5   五 -->
	<form class="neirong" id="se_from5" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						催缴策略_催缴次数  简单查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from5Close').click();">关闭</a>
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
						<label for="Ctrl5_Sel_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl5_Sel_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl5_Sel_SheduleNo" id="Ctrl5_Sel_SheduleNo" class="textclass" ></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl5_Sel_CallCount"><!-- 降级前催缴次数 -->
							<span id="Ctrl5_Sel_Lbl_CallCount"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl5_Sel_OweMonths" dtype="integer"  id="Ctrl5_Sel_OweMonths" class="textclass"></input>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from5search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="se_from5Close">
				关闭
			</button>
		</div>
	</form>
	
	
	<!-- Number 6   六 -->
	<form class="neirong" id="se_from6" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						调级策略——分段调级   简单查询
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from6Close').click();">关闭</a>
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
						<label for="Ctrl6_Sel_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl6_Sel_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl6_Sel_SheduleNo" id="Ctrl6_Sel_SheduleNo" class="textclass" ></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl6_Sel_BeginTelNo"><!-- 起始电话 -->
							<span id="Ctrl6_Sel_Lbl_BeginTelNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl6_Sel_BeginTelNo" id="Ctrl6_Sel_BeginTelNo" class="textclass" maxlength="16"></input>
					</td>
				</tr>
				<tr>					
					<td class="labelclass" width="16%">
						<label for="Ctrl6_Sel_EndTelNo"><!-- 终止电话 -->
							<span id="Ctrl6_Sel_Lbl_EndTelNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl6_Sel_EndTelNo" id="Ctrl6_Sel_EndTelNo" class="textclass" maxlength="16" ></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl6_Sel_BeginDay"><!-- 起始日 -->
							<span id="Ctrl6_Sel_Lbl_BeginDay"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl6_Sel_BeginDay" id="Ctrl6_Sel_BeginDay" dtype="integer"  class="textclass"></input>
					</td>
				</tr>
				<tr>					
					<td class="labelclass" width="16%">
						<label for="Ctrl6_Sel_EndDay"><!-- 终止日 -->
							<span id="Ctrl6_Sel_Lbl_EndDay"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl6_Sel_EndDay" id="Ctrl6_Sel_EndDay" dtype="integer"  class="textclass" maxlength="200" ></input>
					</td>
					<td class="labelclass"></td><td class="tdstyle"></td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from6search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="se_from6Close">
				关闭
			</button>
		</div>
	</form>
	
	<!-- Number 7    七  Search -->
	<form class="neirong" id="se_from7" style="display:none;width:720px;">
		<input type="hidden" />
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						调级策略——禁停时间
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from7Close').click();">关闭</a>
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
						<label for="Ctrl7_Sel_SheduleNo"><!-- 策略名称 -->
							<span id="Ctrl7_Sel_Lbl_SheduleNo"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl7_Sel_SheduleNo" id="Ctrl7_Sel_SheduleNo" class="textclass" ></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_Sel_HoliDay_Type"><!-- 策略名称 -->
							<span id="Ctrl7_Sel_Lbl_HoliDay_Type"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl7_Sel_HoliDay_Type" id="Ctrl7_Sel_HoliDay_Type" class="textclass" ></select>
					</td>
										
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_Sel_StartTime"><!-- 每月起始日 -->
							<span id="Ctrl7_Sel_Lbl_StartTime"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl7_Sel_StartTime" id="Ctrl7_Sel_StartTime" dtype="integer"  class="textclass" maxlength="16"></input>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl7_Sel_EndTime"><!-- 每月终止日 -->
							<span id="Ctrl7_Sel_Lbl_EndTime"></span>
						</label>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from7search" onclick="SimpleSearch()">
				查询
			</button>
			<button type="button" class="tsdbutton" id="se_from7Close">
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
				<input type="hidden" />
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
				
				  	<tr >
					    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
					    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
					    	<input type="text" name="name_mod" id="name_mod" onkeyup="this.value=replaceStrsql(this.value,80)" class="textclass"/>
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
						<td>
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
	
	<input type="hidden" id="queryright" />
	<input type="hidden" id="saveQueryMright" />
	<input type="hidden" id="operationtips"	value="<fmt:message key="global.operationtips"/>" />
	<input type="hidden" id="successful" value="<fmt:message key="global.successful"/>" />
</body>
</html>