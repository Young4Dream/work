<%----------------------------------------
	name: NetGroupDef.jsp
	author: chenze
	version: 1.0, 2010-12-28
	description: 
	modify: 
		
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
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script src="style/js/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js"
			type="text/javascript"></script>
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js"
			type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/infotest.js"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<script type="text/javascript" src="css/tree/dtree.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<!-- 时间控件 -->
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 导入js文件结束 -->
		<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />

		<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
		<!-- 导入css文件结束 -->
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
	
	var tables = ['netname_group'];
	var fuheM = false;
	
	var firstLoad = [true];
	var mNames = [
				'<fmt:message key="netgroupdef.feegroupdefine" />'
				];
				
	var Clerks = "";
	
	//用于数据格式的验证
	var regularExp = [];
	regularExp["integer"] = /^\d+$/;
	regularExp["double"] = /^\d+|\d+\.\d+$/;
	//修改数据时保存原记录
	var sourceData = new Array();
	
	$(function(){
		$("#navBar").append(genNavv());
		setUserRight();
		
		//初始化营业员信息
		Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
		
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
		//models.setHidden(["ID"]);
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'NetGroupDef.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'NetGroupDef.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
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
		       	sortname: 'groupcode', //默认排序字段
		       	viewrecords: true, 
		       	sortorder: 'desc',//默认排序方式 
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
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_01.gif\" title=\"<fmt:message key='global.edit' />\" />",'openRowModify','groupcode','click',1);
								addRowOperBtn('editgrid',"<img src=\"style/images/public/ltubiao_02.gif\" title=\"<fmt:message key='global.delete' />\" />",'deleteRow','groupcode','click',2);
							    /****执行行按钮添加********
								*@1 表格ID
								*@2 操作按钮数量 等于定义数量
								*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
								executeAddBtn('editgrid',2);
								
								var ids = $("#editgrid").getDataIDs();
								
								for(var i=0;i<ids.length;i++)
								{
									var uid = $("#editgrid").getCell(ids[i],"userid");
									var kid = Clerks[uid];
									
									if(kid!=undefined)
									{
										$("#editgrid").setRowData(ids[i],{"userid":kid});
									}
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
		Dat = loadData(tables[tabStatus-1],$("#languageType").val(),1,"<fmt:message key='netgroupdef.modifydelete' />");	
		//alert(Dat.FieldName);
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
			HighLight();
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
	
	////////////////////////////////////////////////////////////////////////////////
	//////					加星显示关键字
	///////////////////////////////////////////////////////////////////////////////	
	function HighLight()
	{
		$("#Ctrl" + tabStatus + "_groupcode").parent().append("<span style=\"color:#FF0000;\">*</span>");
		$("#Ctrl" + tabStatus + "_groupname").parent().append("<span style=\"color:#FF0000;\">*</span>");	
		$("#Ctrl" + tabStatus + "_wheresql").parent().append("<span style=\"color:#FF0000;\">*</span>");
		$("#Ctrl" + tabStatus + "_tablename").parent().append("<span style=\"color:#FF0000;\">*</span>");			
	}
	
	//初始化添加面板里的下拉框
	function InitialDropdownList()
	{
		//科目
		var dtatdicts = fetchMultiKVValue("NetGroupDef.DictList",6,"&table_name=" + tables[tabStatus-1],["field_name","datadict"]);
		var datadictcode = dtatdicts["groupcode"];
		if(datadictcode!=undefined)
		{
			datadictcode = fetchMultiValue("NetGroupDef.Dict",6,"&Sql=" + encodeURIComponent(datadictcode));
			var optHtml = "";
			for(var ii in datadictcode)
			{
				optHtml += "<option value='" + datadictcode[ii] + "'>" + datadictcode[ii] + "</option>";
			}
			$("#Ctrl1_groupcode").html(optHtml);
		}
		var tablenames = dtatdicts["tablename"];
		if(tablenames!=undefined)
		{
			tablenames = fetchMultiValue("NetGroupDef.Dict",6,"&Sql=" + encodeURIComponent(tablenames));
			var optHtml = "";
			for(var ii in tablenames)
			{
				optHtml += "<option value='" + tablenames[ii] + "'>" + tablenames[ii] + "</option>";
			}
			$("#Ctrl1_Sel_tablename,#Ctrl1_tablename").html(optHtml);
		}
		
	}
	
	function bmChange(obj)
	{
		var result = "";
		if(obj.value!="")
			result = fetchSingleValue("NetGroupDef.Hth",6,"&DeptName=" + tsd.encodeURIComponent(obj.value));
		if(result==undefined)
		{
			result = "";
		}
		$("#Ctrl1_Hth").val(result);
	}
		
	////////////////////////////////////////////////////////////////////////////////
	//////					禁用主键的表单
	///////////////////////////////////////////////////////////////////////////////	
	function disablePrimary()
	{
		$("#Ctrl"+tabStatus+"_groupcode").attr("disabled","disabled");
		$("#Ctrl"+tabStatus+"_tablename").attr("disabled","disabled");
		//$("#Ctrl"+tabStatus+"_Xuhao_XH").attr("disabled","disabled");
	}
	////////////////////////////////////////////////////////////////////////////////
	//////					恢复所有表单可用
	///////////////////////////////////////////////////////////////////////////////	
	function makeAllEnabled()
	{
		$("#Ctrl"+tabStatus+"_groupcode").removeAttr("disabled");
		$("#Ctrl"+tabStatus+"_tablename").removeAttr("disabled");
		//$("#Ctrl"+tabStatus+"_Xuhao_XH").removeAttr("disabled");
	}
	
	
	//////////////////////////////////////////////////////////////////////
	/////       更换按钮状态 0修改  1新增   2查询
	/////////////////////////////////////////////////////////////////////
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
	///
	//////////////////////////////////////////////////////////////////////
	/////                     打开修改面板
	/////////////////////////////////////////////////////////////////////
	function openRowModify()
	{
		if($("#editright").val()=="false")
		{
			alert("<fmt:message key='netgroupdef.nomodifyright' />");
			//return false;
		}
		else
		{
			clearText("cl_from" + tabStatus);
			toggleBtn(0);
			disablePrimary();
			//生成参数串
			var params = "&groupcode=" + tsd.encodeURIComponent(arguments[0]);
						
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
				tsdpk:"NetGroupDef.queryByKey"
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
							if(tmp.toLowerCase()=="feetype")
							{
								$("#Ctrl"+tabStatus+"_"+tmp+" option[value='"+$.trim($(this).attr(tmp.toLowerCase()))+"']").attr("selected","selected");
							}else
							{
								$("#Ctrl"+tabStatus+"_"+tmp).val($(this).attr(tmp.toLowerCase()));
							}
							sourceData[tmp] = $(this).attr(tmp.toLowerCase());
						}	
					});
				}
			});
			
			autoBlockFormAndSetWH("cl_from"+tabStatus,60,10,"cl_from"+tabStatus+"Close","#FFFFFF",true,750,'auto');
		}
	}
	//////////////////////////////////////////////////////////////////////
	/////                      添加记录
	/////////////////////////////////////////////////////////////////////
	function addForFeilu()
	{	
		var j=0;
		var queryStr = "";
		
		var cbm = $("#Ctrl1_groupcode").val();
		if(cbm=="<fmt:message key='netgroupdef.choose' />" || cbm=="")
		{
			alert("<fmt:message key='netgroupdef.checkgroupnumber' />");
			$("#Ctrl1_groupcode").select().focus();
			return false;
		}
		var exists = fetchSingleValue("NetGroupDef.existed",6,"&groupcode=" + encodeURIComponent(cbm));
		if(parseInt(exists,10)>0)
		{
			alert("<fmt:message key='netgroupdef.numberexistchooseagain' />");
			$("#Ctrl1_groupcode").select().focus();
			return false;
		}
		var cft = $("#Ctrl1_groupname").val();
		if(cft=="")
		{
			alert("<fmt:message key='netgroupdef.entergroupname' />");
			$("#Ctrl1_groupname").select().focus();
			return false;
		}
		exists = fetchSingleValue("NetGroupDef.existedname",6,"&groupname='" + encodeURIComponent(cft) + "'");
		if(parseInt(exists,10)>0)
		{
			alert("<fmt:message key='netgroupdef.nameexistchooseagain' />");
			$("#Ctrl1_groupname").select().focus();
			return false;
		}
		var cyf = $("#Ctrl1_wheresql").val();
		if(cyf=="")
		{
			alert("<fmt:message key='netgroupdef.setgroupdefine' />");
			$("#Ctrl1_wheresql").select().focus();
			return false;
		}
		var cqtf = $("#Ctrl1_tablename").val();
		if(cqtf=="")
		{
			alert("<fmt:message key='netgroupdef.choosetablename' />");
			$("#Ctrl1_tablename").select();
			$("#Ctrl1_tablename").focus();
			return false;
		}
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
			
			if(dtype!=undefined)
			{
				if((dtype=="integer" || dtype=="double") && tvalue=="")
				{
					tvalue = "0";
				}
				if(!regularExp[dtype].test(tvalue))
				{
					alert($.trim($(lables[k]).text()) + "<fmt:message key='netgroupdef.falseform' />" + getType(dtype) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}
			}
			
			//如果是计费类别费率减免的备注 默认为空格
			
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
		
		var res = executeNoQuery("NetGroupDef.add",6,queryStr);
		
		if(res=="true"||res==true)
		{
			alert("<fmt:message key='global.successful' />");
			
			writeLogInfo("","add",loginfo);
		}
		
		$("#editgrid").trigger("reloadGrid");
		clearText("cl_from"+tabStatus);
		//第一个主键输入框获得焦点
		$("#Ctrl"+tabStatus+"_groupcode").select();
		$("#Ctrl"+tabStatus+"_groupcode").focus();
		
		
		return true;
	}
	//保存退出函数
	function addForExit()
	{
		var res = addForFeilu();
		if(res) setTimeout($.unblockUI, 15);
	}
	
	function getType(type)
	{
		if(type=="integer")
		{
			return "<fmt:message key='netgroupdef.integer' />";
		}
		else if(type=="double")
		{
			return "<fmt:message key='netgroupdef.number' />";
		}
		if(type=="datetime")
		{
			return "<fmt:message key='netgroupdef.date' />";
		}
		else
		{
			return "<fmt:message key='netgroupdef.char' />";
		}
	}
	/////修改数据
	function ModifyData()
	{
		var cbm = $("#Ctrl1_groupcode").val();
		if(cbm=="<fmt:message key='netgroupdef.choose' />" || cbm=="")
		{
			alert("<fmt:message key='netgroupdef.checkgroupnumber' />");
			$("#Ctrl1_groupcode").select().focus();
			return false;
		}
		
		var cft = $("#Ctrl1_groupname").val();
		if(cft=="")
		{
			alert("<fmt:message key='netgroupdef.entergroupname' />");
			$("#Ctrl1_groupname").select().focus();
			return false;
		}
		var exists = fetchSingleValue("NetGroupDef.existedname",6,"&groupname='" + encodeURIComponent(cft) + "'");
		if(parseInt(exists,10)>0)
		{
			alert("<fmt:message key='netgroupdef.nameexistchooseagain' />");
			$("#Ctrl1_groupname").select().focus();
			return false;
		}
		var cyf = $("#Ctrl1_wheresql").val();
		if(cyf=="")
		{
			alert("<fmt:message key='netgroupdef.setgroupdefine' />");
			$("#Ctrl1_wheresql").select().focus();
			return false;
		}
		var cqtf = $("#Ctrl1_tablename").val();
		if(cqtf=="")
		{
			alert("<fmt:message key='netgroupdef.choosetablename' />");
			$("#Ctrl1_tablename").select();
			$("#Ctrl1_tablename").focus();
			return false;
		}
		//alert("O:"+ObuildParams());
		//return false;
		
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
		
		//修改参数
		var querystr = "";
		
		//日志信息
		var loginfo = "";
		
		loginfo += tsd.encodeURIComponent(mNames[tabStatus-1]);
		loginfo += ";TableName:";
		loginfo += tables[tabStatus-1];
		loginfo += ";";
		
		var modifystr = $("#cl_from"+tabStatus+"modify").data("modifystr");
		
		
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
					alert($.trim($(lables[k]).text()) + "<fmt:message key='netgroupdef.falseform' />" + getType(dtype) + ".");
					$("#"+tmp).select();
					$("#"+tmp).focus();
					return false;
				}					
			}
			
			var fieldname = tmp.replace("Ctrl"+tabStatus+"_","");
			
			//如果是计费类别费率减免的备注 默认为空格
			
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
		
		if(tsd.Qualified()==false){return false;}		
								
		var res = executeNoQuery("NetGroupDef.modify",6,querystr+modifystr);
		if(res=="true"||res==true)
		{
			alert("<fmt:message key='netgroupdef.modifysucess' />");				
			writeLogInfo("","modify",loginfo);
		}
		setTimeout($.unblockUI, 15);//关闭面板
		$("#editgrid").trigger("reloadGrid");//重新加载数据
	
	}
	/////删除记录
	function deleteRow()
	{
		if($("#deleteright").val()=="false")
		{
			alert("<fmt:message key='netgroupdef.nodeleteright' />");
			//return false;
		}
		else
		{//生成参数串
			var params = "&groupcode="+tsd.encodeURIComponent(arguments[0]);
			
			//删除
			if(confirm("<fmt:message key='netgroupdef.willdeletethisrecord' />"))
			{
				var res = executeNoQuery("NetGroupDef.deleteByKey",6,params);
				if(res==true || res=="true")
				{
					//记日志
					var loginfo = "";			
					loginfo += mNames[tabStatus-1];
					loginfo += ";TableName:";
					loginfo += tables[tabStatus-1];
					loginfo += ";";
					loginfo = tsd.encodeURIComponent(loginfo);
					
					params = tsd.encodeURIComponent("<fmt:message key='netgroupdef.num' />:");
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
	////////////////////////////////////////////////////////////////////////////////
	//////					打开添加面板
	///////////////////////////////////////////////////////////////////////////////	
	function openAddForm()
	{
		makeAllEnabled();
		toggleBtn(1);
		clearText("cl_from"+tabStatus);
				
		autoBlockFormAndSetWH("cl_from"+tabStatus,60,10,"cl_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		//$("#Ctrl"+tabStatus+"_Xuhao").focus();
	}
	
	////////////////////////////////////////////////////////////////////////////////
	//////					打开查询面板
	///////////////////////////////////////////////////////////////////////////////	
	function openSearchForm()
	{
		clearText("se_from"+tabStatus);
						
		autoBlockFormAndSetWH("se_from"+tabStatus,60,10,"se_from"+tabStatus+"Close","#FFFFFF",false,750,'auto');
		
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
	 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:"NetGroupDef.queryByOrder",//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'NetGroupDef.queryByOrderpage'
									});
		var link = urlstr1 + params  + "&cols=" + Dat.FieldName.join(",") + tparam;
					
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
	 	//setTimeout($.unblockUI, 15);//关闭面板		 	
	}
	
	function openSearch()
	{
		$("#queryName").val("<fmt:message key='netgroupdef.seek' />");
		showDialog(1);
	}
	
	function openBatchDelete()
	{
		$("#queryName").val("<fmt:message key='netgroupdef.delete' />");
		showDialog(1);
	}
	
	function openBatchEdit()
	{
		$("#queryName").val("<fmt:message key='netgroupdef.modify' />");
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
			//$("#Ctrl1_wheresql").val($("#fusearchsql").val());
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
	 	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:'NetGroupDef.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:'NetGroupDef.fuheQueryByWherepage'
									});
		
		var link = urlstr1 + params + "&cols=" + Dat.FieldName.join(",") + "&tablename=" + tables[tabStatus-1];
		
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
			return false;
		}
		if(allRi[0][0]=="all")
		{
			return true;
		}
		var addright = "false";
		
		var deleteright = "false";
		var editright = "false";
		
		var exportright = "false";
		var printright = "false";
		
		var queryright = "false";
		var saveQueryMright = "false";
				
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'add','')=="true")
				addright = "true";
			if(getCaption(allRi[i][0],'delete','')=="true")
				deleteright = "true";
			if(getCaption(allRi[i][0],'edit','')=="true")							
				editright = "true";
			if(getCaption(allRi[i][0],'export','')=="true")
				exportright = "true" ;
			if(getCaption(allRi[i][0],'print','')=="true")
				printright = "true";
				
			if(getCaption(allRi[i][0],'query','')=="true")
				queryright = "true";
				
			if(getCaption(allRi[i][0],'saveQueryM','')=="true")
				saveQueryMright = "true";
		}
		//alert(addright+":"+delBright+":"+editBright);
		$("#addright").val(addright);
		
		if(addright=="false")
		{
			$("#openadd1").attr("disabled","disabled");
			$("#openadd2").attr("disabled","disabled");
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
	
	
	////////////////////////////////////////////////////////////////////////////
	///////////////////////////                下载文件
	///////////////////////////////////////////////////////////////////////////
	function DownFile()
	{
	
		thisDownLoad('tsdBilling','mssql',tables[tabStatus-1],$("#lanType").val(),5);
	}
	
	
	function DownSure()
	{
	
		getTheCheckedFields('tsdBilling','mssql',tables[tabStatus-1]);
	}
	
	function getDefineSql()
	{
		var tablename = $("#Ctrl1_tablename").val();
		if(tablename=="")
		{
			alert("<fmt:message key='netgroupdef.choosesettable' />");
			$("#Ctrl1_tablename").select().focus();
			return false;
		}
		openDiaQueryG('queryset',tablename);
	}
	
	////////////////////////////////////////////////////////////////////////////
	///////////////////////////                打印报表
	///////////////////////////////////////////////////////////////////////////
	function printR()
	{
		var params = ''+$("#fusearchsql").val();			
		if(params==''){
			params ='1=1';
		}
		printThisReport("set1rate" + tables[tabStatus-1],"&fusearchsql="+encodeURIComponent(cjkEncode($.trim(params))));
	}
	
	//保存本次高级查询方法
	function addQuery(){
		saveModQuery(tabStatus);
	}
	
	//模板查询你
	function modQuery(){
		 openQueryM(tabStatus);
	}
	
	function FeeTypeChange(obj)
	{
		if(obj.value=="<fmt:message key='netgroupdef.broadband' />")
		{
			$("#Ctrl1_Lbl_Dh").text("<fmt:message key='netgroupdef.netnumber' />");
		}
		else
		{
			$("#Ctrl1_Lbl_Dh").text("<fmt:message key='netgroupdef.telephonenumber' />");
		}
	}
	
	//简单查询
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
			
			
			if(tvalue!="" && tvalue!=null && tvalue!='<fmt:message key="netgroupdef.choose" />')
			{
				if(dtype!=undefined && !regularExp[dtype].test(tvalue))
				{
					alert($.trim($(lables[k]).text()) + "<fmt:message key='netgroupdef.falseform' />" + getType(dtype) + ".");
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
			alert("<fmt:message key='netgroupdef.commitcondition' />");
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
  	<br />
  	<!-- 资费设置导航条-->
	<div id='tariffBar' style="font-size: 14px; text-align: left;">
	</div>
  	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder1" onclick="openDiaO('netname_group');">
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
	   <button type="button" id="gjcx1" onclick="openDiaQueryG('query','netname_group');">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id='savequery1' onclick="openModT()">
				<fmt:message key="oper.modSave"/>
		</button>
		<button type="button" id="export1" onclick="DownFile()"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>
	</div>
	
	<div id="gridd">
	    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>

	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="openorder2" onclick="openDiaO('netname_group');">
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
	   <button type="button" id="gjcx2" onclick="openDiaQueryG('query','netname_group');">
			<!--高级查询--><fmt:message key="oper.queryA" />
		</button>
		<button type="button" id='savequery2' onclick="openModT()">
				<fmt:message key="oper.modSave"/>
		</button>
		<button type="button" id="export2" onclick="DownFile()"> 
			<!--导出--><fmt:message key="global.exportdata" />
		</button>
	</div>
	
	
	<!-- Number 1 一 -->
	<form class="neirong" id="cl_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="netgroupdef.feegroupdefine" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#cl_from1Close').click();"><fmt:message key="netgroupdef.close" /></a>
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
						<label for="Ctrl1_groupcode"><!-- 群编号 -->
							<span id="Ctrl1_Lbl_groupcode"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">					
						<select id="Ctrl1_groupcode" class="textclass">   
						</select>						
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_groupname"><!-- 群名称 -->
							<span id="Ctrl1_Lbl_groupname"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input name="Ctrl1_groupname" id="Ctrl1_groupname" class="textclass"  />   
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_tablename"><!-- 表 -->
							<span id="Ctrl1_Lbl_tablename"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_tablename" id="Ctrl1_tablename" class="textclass"></select>
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_wheresql"><!-- 群定义 -->
							<span id="Ctrl1_Lbl_wheresql"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_wheresql" id="Ctrl1_wheresql" class="textclass" disabled />	<button class="tsdbutton" style="line-height:22px" onclick="getDefineSql()">设置</button>			
					</td>
				</tr>
				<tr>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_wheredesc"><!-- 群定义描述  -->
							<span id="Ctrl1_Lbl_wheredesc"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_wheredesc" id="Ctrl1_wheredesc" class="textclass" disabled />
					</td>
					<td class="labelclass" width="16%">
						
					</td>
					<td width="34%" class="tdstyle">
						
					</td>
					
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="cl_from1save" onclick="addForFeilu()">
				<fmt:message key="netgroupdef.saveadd" />
			</button>
			<button type="button" class="tsdbutton" id="cl_from1exit" onclick="addForExit()">
				<fmt:message key="netgroupdef.saveexit" />
			</button>
			<button type="button" class="tsdbutton" id="cl_from1modify" onclick="ModifyData()">
				<fmt:message key='netgroupdef.modify' />
			</button>
			<button type="button" class="tsdbutton" id="cl_from1search" onclick="SimpleSearch()">
				<fmt:message key='netgroupdef.seek' />
			</button>
			<button type="button" class="tsdbutton" id="cl_from1Close">
				<fmt:message key="netgroupdef.close" />
			</button>
		</div>
	</form>
		
	<!-- Number 1 一 Search -->
	<form class="neirong" id="se_from1" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="netgroupdef.groupdefine&simpleseek" />
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#se_from1Close').click();"><fmt:message key="netgroupdef.close" /></a>
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
						<label for="Ctrl1_Sel_groupname"><!-- 计费群名称 -->
							<span id="Ctrl1_Sel_Lbl_groupname"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<input type="text" name="Ctrl1_Sel_groupname" id="Ctrl1_Sel_groupname" class="textclass" />
					</td>
					<td class="labelclass" width="16%">
						<label for="Ctrl1_Sel_tablename"><!-- 表 -->
							<span id="Ctrl1_Sel_Lbl_tablename"></span>
						</label>
					</td>
					<td width="34%" class="tdstyle">
						<select name="Ctrl1_Sel_tablename" id="Ctrl1_Sel_tablename" class="textclass"></select>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="se_from1search" onclick="SimpleSearch()">
				<fmt:message key='netgroupdef.seek' />
			</button>
			<button type="button" class="tsdbutton" id="se_from1Close">
				<fmt:message key="netgroupdef.close" />
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
					<div class="top_03" ><fmt:message key="netgroupdef.functionname" /></div>
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
						<div class="top_03" id="titlediv"><fmt:message key="netgroupdef.chooseexportdata" /></div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="netgroupdef.close" /></a></div>
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
				<fmt:message key="netgroupdef.selectall" />
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