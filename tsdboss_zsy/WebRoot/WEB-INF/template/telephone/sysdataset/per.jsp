<%----------------------------------------
	name: per.jsp
	author: youhongyu
	version: 1.0, 2009-12-09
	description: 模块局权限设置
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title></title>
	
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
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
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
		<!-- 验证框架需要导入的js文件 -->
		<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
	  	<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
	
	<style type="text/css">
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
			
		
		.existed{background-color:#cccccc;}
		
		button{width:90px;}
		
		p.over{
			background-color: #B2D2FF;
			cursor:pointer;
		}
		
		p.selected{
			background-color:#3d84cc;
			color: White;
		}
	</style>

	<script type="text/javascript">
	//用于保存路由线路
	var jdomm = [];
	//用保存设备信息
	var cevice = [];
	//记录记录是否已更改
	var hasChanged = false;
	//字段别名键值对数组
	var filAlias = "";
	/**
	 * 初始化
	 * @param 无参数
	 * @return 无返回值
	 */
	$(function(){
		$("#navBar1").append(genNavv());
		gobackInNavbar("navBar1");
		
		//取别名
		filAlias = fetchFieldAlias("ScddBm",$("#lanType").val());
	
		$("#add").click(function(){
			if($("#allDept p.selected").size()<1)
			{
				//alert("请选择要设置的部门");
				alert("<fmt:message key='manageRoute.chooseInfo' />");
				return false;
			}
			
			if($("#allDevice p.selected").size()<1)
			{
				//alert("请选择要添加的模块局");
				alert("<fmt:message key='per.alertSAdd' />");
				return false;
			}
			$("#useAble").append($("#allDevice p.selected").clone().removeClass("selected").removeClass("over"));
			//状态标志
			hasChanged = true;
			
			genDeviceListAgn();
			operChoosed();
		});
		/**
		 * 删除按钮
		 * @param 无参数
		 * @return 无返回值
		 */
		$("#delete").click(function(){
			if($("#useAble p.selected").size()<1)
			{
				//alert("请选择要删除的模块局");
				alert("<fmt:message key='per.alertSDel' />");
				return false;
			}
			//要移除的设备的FieldName
			var domm = $("#useAble p.selected .FieldName").text();
			//alert(domm);
			$.each($("#allDevice p:gt(0)"),function(i,n){
				//alert($(n).find("span.FieldName").text() +":"+ domm);
				//alert($(n).find("span.FieldName").text() == domm);
				if($(n).find("span.FieldName").text() == domm)
				{
					$(n).removeClass("existed");
				}
			});			
			
			$("#useAble p.selected").remove();
			//状态标志
			hasChanged = true;
			//$("#allDevice").append($("#useAble p.selected").remove().removeClass("selected"));
			operAll();
		});		
		/**
		 * 返回按钮
		 * @param 无参数
		 * @return 无返回值
		 */
		$("#back").click(function(){
			//$("#useAble p:gt(0)").remove();
			
			//genDeviceList();
			//genDept();
		});
		/**
		 * 添加按钮
		 * @param 无参数
		 * @return 无返回值
		 */
		$("#save").click(function(){
			if($("#allDept .selected").size() < 1)
			{
				//alert("请选择部门");
				alert("<fmt:message key='manageRoute.chooseInfo' />");
				return false;
			}
			if(!hasChanged)
			{
				//alert("可管模块局信息无更改");
				alert("<fmt:message key='per.noChange' />");
				return false;
			}
			save();
		});
		
		genDeviceList();
		
		genDept();
	});
	/**
	 * 保存路由
	 * @param 无参数
	 * @return boolean
	 */
	function save()
	{
		var fieldNames =[];
		$.each($("#useAble p:gt(0)"),function(){
			var temp = "";
			temp = $(this).find(".FieldName").text();
			fieldNames.push(temp);
		});
		fieldNames = fieldNames.sort();
		fieldNames = fieldNames.join(",") + ",";
		tsd.QualifiedVal=true;  
		fieldNames=tsd.encodeURIComponent(fieldNames);
		if(tsd.Qualified()==false){return false;}
		//原有的Linefields
		var srcFieldNames = $("#allDept p.selected span.IDDD").next().text();
		
		var id = $("#allDept p.selected .IDDD").text();
		var result = executeNoQuery("per.modifyModiMo",6,"&ModiMoKuaiJus="+fieldNames+"&ID="+id);	
		var result2 = executeNoQuery("per.modifyViewMo",6,"&ViewMoKuaiJus="+fieldNames+"&ID="+id);
		if((result==true||result=="true")&&(result2==true||result2=="true"))
		{
			//alert("部门可管理模块局设置成功");
			alert("<fmt:message key='per.saveSuccess' />");
			//同步更新页面部门LineFields信息
			//$("#allDept p.selected span.IDDD").next().text(fieldNames);
			$("#allDept p.selected span.IDDD").next().text(decodeURIComponent(fieldNames));			
			//记日志
			//var loginfo = "&LineFields="+fieldNames+"&ID="+id;
		tsd.QualifiedVal=true;  
		srcFieldNames=tsd.encodeURIComponent(srcFieldNames);
		if(tsd.Qualified()==false){return false;}
			var loginfo = "TableName:Scddbm;";
			loginfo += tsd.encodeURIComponent(filAlias["ID"]);
			loginfo += ":";
			loginfo += id;
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["Bm"]);
			loginfo += ":";
			loginfo += srcFieldNames;
			loginfo += ">>>";
			loginfo += fieldNames;
			loginfo += ";";
			
			writeLogInfo("","modify",loginfo);
		}
		else
		{
			//alert("部门可管理模块局设置失败");
			alert("<fmt:message key='per.saveFail' />");
		}
		//状态标志，无更改
		hasChanged = false;
	}
	/**
	 * 初始化时添加设备列表
	 * @param 无参数
	 * @return 无返回值
	 */
	function genDeviceList()
	{
		var devices = fetchMultiArrayValue("per.fetchMokuai",6,"");
		if(typeof devices[0]=='undefined' && typeof devices[0][0]=='undefined')
			return false;
		
		cevice  = devices;
		var linesss = "";
		for(var i=0;i<devices.length;i++)
		{
			linesss += "<p>"+devices[i][1]+"<span style=\"display:none;\" class=\"DeviceNo\">" + devices[i][0] + "</span>"+"<span style=\"display:none;\" class=\"FieldName\">" + devices[i][2] + "</span>" +"</p>";
		}
		$("#allDevice p:gt(0)").remove();
		$("#allDevice").append(linesss);
		
		operAll();
	}
	/**
	 * 初始化时添加部门信息
	 * @param 无参数
	 * @return 无返回值
	 */
	function genDept()
	{
		var devices = fetchMultiArrayValue("per.fetchBm",6,"");
		if(typeof devices[0]=='undefined' && typeof devices[0][0]=='undefined')
			return false;
		var linesss = "";
		for(var i=0;i<devices.length;i++)
		{
			linesss += "<p>"+devices[i][1]+"<span style=\"display:none;\" class=\"IDDD\">" + devices[i][0] + "</span>"+"<span style=\"display:none;\" class=\"LineFields\">" + devices[i][2] + "</span>" +"</p>";
		}
		$("#allDept p:gt(0)").remove();
		$("#allDept").append(linesss);
		
		operDept();
	}
	/**
	 * 给模块局设备添加事件
	 * @param 无参数
	 * @return 无返回值
	 */
	function operAll()
	{
		$("#allDevice p:gt(0)").css({width:'180px',height:'26px','line-height':'26px','margin-top':'3px'});
		//alert($("#allDevice p:eq(0)").hasClass("existed"));
		$.each($("#allDevice p:gt(0)"),function(i,n){
			if(!$(n).hasClass("existed"))
			{
				$(n).click(function(){
					$("#allDevice p").removeClass("selected");
					$(this).addClass("selected");			
				}).dblclick(function(){
					$("#add").click();			
				}).mouseover(function(){
					$(this).addClass("over");
				}).mouseout(function(){
					$(this).removeClass("over");
				});
			}
		});
	}
	/**
	 * 给选中的部门添加事件
	 * @param 无参数
	 * @return 无返回值
	 */
	function operDept()
	{
		$("#allDept p:gt(0)").css({width:'180px',height:'26px','line-height':'26px','margin-top':'3px'});
		
		$("#allDept p:gt(0)").click(function(){
		
			if(hasChanged)
			{
				//if(confirm("部门可管模块局信息已更改，是否保存"))
				if(confirm("<fmt:message key='per.alertsave' />"+"?"))
				{
					$("#save").click();
				}
				else
				{					
					hasChanged = false;
				}
			}
			
			$("#allDept p").removeClass("selected");
			$(this).addClass("selected");
			
			$("#useAble p:gt(0)").remove();
			//取部门可控模块局设备的值
			var fieldddd = "";
			var fields = "";
			fieldddd = $(this).find(".LineFields").text();
			fieldddd = fieldddd.substring(0,fieldddd.length-1);
			
			fields = fieldddd.split(",");
			
			for(var i=0;i<fields.length;i++)
			{
				if(fields[i]=="")
					continue;
				$("#useAble").append("<p>" + getDeviceName(fields[i]) + "<span style=\"display:none;\" class=\"FieldName\">" + fields[i] + "</span></p>");
				//删除所有设备中已添加的设备
				
				//$("#allDevice:contains("+ fields[i] +")").remove();
			}
			//重新生成不可用设备
			genDeviceList();
			genDeviceListAgn();
			
			//alert($("#allDevice p").not($("#allDevice p[class='existed']")).size());
			
			operChoosed();//$("#useAble").text(fieldddd);
			
		}).mouseover(function(){
			$(this).addClass("over");
		}).mouseout(function(){
			$(this).removeClass("over");
		});
	}
	/**
	 * 取设备名称
	 * @param fieldName(字段名)
	 * @return String
	 */
	function getDeviceName(fieldName)
	{
		for(var i=0;i<cevice.length;i++)
		{
			//alert(fieldName + ":" + cevice[i][2]);
			if(fieldName == cevice[i][2])
				return cevice[i][1];
		}
		//return "未知模块局";
		return "<fmt:message key='per.unknown' />";
	}
	/**
	 * 给选中的模块局添加事件
	 * @param 无参数
	 * @return 无返回值
	 */
	function operChoosed()
	{
		$("#useAble p:gt(0)").css({width:'180px',height:'26px','line-height':'26px','margin-top':'3px'});
		
		$.each($("#useAble p:gt(0)"),function(i,n){
			$(n).click(function(){
				
				$("#useAble p").removeClass("selected");
				$(this).addClass("selected");
				
			}).dblclick(function(){
				$("#delete").click();			
			}).mouseover(function(){
				$(this).addClass("over");				
			}).mouseout(function(){
				$(this).removeClass("over");
			});
		});
	}
	/**
	 * 根据用户已有可能模块局生成新的模块局列表
	 * @param 无参数
	 * @return 无返回值
	 */
	function genDeviceListAgn()
	{
		var domms = [];
		$.each($("#useAble span.FieldName"),function(i,n){
			domms.push($(n).text());
		});
			
		$("#allDevice").find("p").each(function(){
			if($.inArray($(this).find(".FieldName").text(),domms)>-1)
			{
				//$(this).remove();
				$(this).unbind("mouseover");
				$(this).unbind("mouseout");
				$(this).unbind("click");
				$(this).unbind("dblclick");
				$(this).attr("class","existed");
			}
		});
		
	}
	
	</script>

  </head>
  
  <body>
    <div id="navBar1" style="font-size:14px;">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' />
	<input type='hidden' id='lanType' value='<%=session.getAttribute("languageType") %>' /> 
	<div align=center>
	<table id="containerr" align="center" border="1" bordercolor="#999999" style="margin-top:10px;border-collapse:separate">
		<tr>
			<td width="230" align="left" style="border-width:0px;font-weight:bold;"><!-- 所有部门 --><fmt:message key='manageRoute.allDep' /></td><td width="230" align="left" style="border-width:0px;font-weight:bold;"><!-- 部门可管理模块局 --><fmt:message key='per.canMokuai' /> </td><td width="150" style="border-width:0px;"></td><td width="230" align="left" style="border-width:0px;font-weight:bold;"><!-- 所有模块局--><fmt:message key='per.allMokuai' /></td>
		</tr>
		<tr>
			<td width="230" align="left" valign="top"><div id="allDept" style="height:340px;overflow-y:scroll;padding-left:10px;"><p style="width: 180px; height: 2px; line-height: 2px;"></p></div></td>
			<td width="230" align="left" valign="top"><div id="useAble" style="height:340px;overflow-y:scroll;padding-left:10px;"><p style="width: 180px; height: 2px; line-height: 2px;"></p></div></td>
			<td width="150" align="center" valign="top" style="height:340px;border-width:0px;">
				<p><button id="up" class="tsdbutton" style="visibility:hidden;"><fmt:message key="per.moveup" /></button></p><br />
				<p><button id="add" class="tsdbutton"> &lt; <!-- 添加模块局 --><fmt:message key="per.addmodule" /></button></p><br />
				<p><button id="delete" class="tsdbutton"> &gt; <!-- 删除模块局 --><fmt:message key="per.deletemodule" /></button></p><br />
				<p><button id="up" class="tsdbutton" style="visibility:hidden;"><fmt:message key="per.moveup" /></button></p><br />
				<p><button id="down" class="tsdbutton" style="visibility:hidden;"><fmt:message key="per.movedown" /></button></p>
			</td>
			<td width="230" align="left" valign="top"><div id="allDevice" style="height:340px;overflow-y:scroll;padding-left:10px;"><p style="width: 180px; height: 2px; line-height: 2px;"></p></div></td>
		</tr>
	</table>
	</div>
	<div id="buttons" style="text-align:center;margin-top:10px;">
		<button id="save"><!-- 保存 --><fmt:message key='global.save' /></button><span style="width:80px;visibility:hidden">_________</span><button style="visibility:hidden" id="back"><!-- 重置 --><fmt:message key='tariff.reset' /></button>
	</div>
  </body>
</html>
