<%----------------------------------------
	name: manageRoute.jsp
	author: 陈泽
	version: 1.0, 2010-10-11
	description: 部门可管理路由设置返回
	modify: 
		2010-11-5 youhongyu 添加注释功能		
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
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>		
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>		
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>		
		
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
	* 页面初始化
	* @param 
	* @return 
	*/
	$(function(){
		$("#navBar1").append(genNavv());
		gobackInNavbar("navBar1");
		
		//取别名
		filAlias = fetchFieldAlias("scddbm",$("#lanType").val());
		
		$("#add").click(function(){
			if($("#allDept p.selected").size()<1)
			{
				//alert("请选择要设置的部门");
				alert("<fmt:message key='manageRoute.chooseInfo' />");
				return false;
			}
			
			if($("#allDevice p.selected").size()<1)
			{
				//alert("请选择要添加的设备");
				alert("<fmt:message key='lineFullRoute.addInfo' />");
				return false;
			}
			//jdomm.push($("#allDevice p.selected").remove().removeClass("selected").removeClass("over"));
			//genNewRoute();
			$("#useAble").append($("#allDevice p.selected").clone().removeClass("selected").removeClass("over"));
			//状态标志
			hasChanged = true;
			
			genDeviceListAgn();
			operChoosed();
		});
		
		$("#delete").click(function(){
			if($("#useAble p.selected").size()<1)
			{
				//alert("请选择要删除的设备");
				alert("<fmt:message key='lineFullRoute.deleteInfo' />");
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
		
		$("#back").click(function(){
			//$("#useAble p:gt(0)").remove();
			
			//genDeviceList();
			//genDept();
		});
		
		$("#save").click(function(){
			if($("#allDept .selected").size() < 1)
			{
				//alert("请选择部门");
				alert("<fmt:message key='manageRoute.chooseInfo' />");
				return false;
			}
			if(!hasChanged)
			{
				//alert("可管路由设备信息无更改");
				alert("<fmt:message key='manageRoute.kglysbxxnull' />");
				return false;
			}
			save();
		});
		
		genDeviceList();
		
		genDept();
	});
	
	/**
	* 页面保存按钮事件,保存路由
	* @param 
	* @return 
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
		//原有的Linefields
		var srcFieldNames = $("#allDept p.selected span.IDDD").next().text();
		
		var id = $("#allDept p.selected .IDDD").text();
		
		var result = executeNoQuery("Linee.modifyRoute",6,"&LineFields="+fieldNames+"&ID="+id);	
		
		if(result==true||result=="true")
		{
			//alert("部门可管理路由设置成功");
			alert("<fmt:message key='manageRoute.success' />");
			//同步更新页面部门LineFields信息
			$("#allDept p.selected span.IDDD").next().text(fieldNames);
			
			//记日志
			//var loginfo = "&LineFields="+fieldNames+"&ID="+id;
			
			var loginfo = "TableName:scddbm;";
			loginfo += tsd.encodeURIComponent(filAlias["ID"]);
			loginfo += ":";
			loginfo += id;
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["Bm"]);
			loginfo += ":";
			loginfo += srcFieldNames;
			loginfo += "=>";
			loginfo += fieldNames;
			loginfo += ";";
			
			writeLogInfo("","modify",loginfo);
		}
		else
		{
			//alert("部门可管理路由设置失败");
			alert("<fmt:message key='manageRoute.fail' />");
		}
		//状态标志，无更改
		hasChanged = false;
	}
	
	/**
	* 初始化时添加设备列表
	* @param 
	* @return 
	*/
	function genDeviceList()
	{
		var devices = fetchMultiArrayValue("Linee.fetchDevice",6,"&nodesect=1");
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
	* @param 
	* @return 
	*/
	function genDept()
	{
		var devices = fetchMultiArrayValue("Linee.fetchBm",6,"");
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
	* 给路由设备添加事件
	* @param 
	* @return 
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
	*  给左侧选框中部门添加事件
	* @param 
	* @return 
	*/	
	function operDept()
	{
		$("#allDept p:gt(0)").css({width:'180px',height:'26px','line-height':'26px','margin-top':'3px'});
		
		$("#allDept p:gt(0)").click(function(){
		
			if(hasChanged)
			{
				//if(confirm("部门可管路由设备信息已更改，是否保存"))
				if(confirm("<fmt:message key='manageRoute.sBmkglyxxchanager' />"))
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
			//取部门可控路由设备的值
			var fieldddd = "";
			var fields = "";
			fieldddd = $(this).find(".LineFields").text();
			
			fieldddd = fieldddd.substring(0,fieldddd.length-1);
			
			fields = fieldddd.split(",");
			
			for(var i=0;i<fields.length;i++)
			{
				if(fields[i]=="")
					continue;
				//alert(getDeviceName(fields[i]));
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
	*  取设备名称
	* @param fieldName 设备val值
	* @return 返回设备名称,如果设备在保存设备信息中查找不到，返回提示信息“未知设备”
	*/	
	function getDeviceName(fieldName)
	{
		for(var i=0;i<cevice.length;i++)
		{
			//alert(fieldName + ":" + cevice[i][2]);
			if(fieldName == cevice[i][2])
				return cevice[i][1];
		}
		//return "未知设备";
		return "<fmt:message key='manageRoute.unknow' />";
	}
	
	
	
	/**
	*  给部门可管理设备面板的设备添加事件
	* @param 
	* @return 
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
	*  根据用户已有可能设备生成新的设备列表
	* @param 
	* @return 
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
    <div id="navBar1">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' />
	<input type='hidden' id='lanType' value='<%=session.getAttribute("languageType") %>' /> 
	<div align=center>
	<table id="containerr" align="center" border="1" bordercolor="#999999" style="margin-top:10px;border-collapse:separate">
		<tr>
			<td width="230" align="left" style="border-width:0px;font-weight:bold;"><!-- 所有部门 --><fmt:message key='manageRoute.allDep' /></td><td width="230" align="left" style="border-width:0px;font-weight:bold;"><!-- 部门可管理设备 --><fmt:message key='manageRoute.sBmkglysb' /></td><td width="150" style="border-width:0px;"></td><td width="230" align="left" style="border-width:0px;font-weight:bold;"><!-- 所有设备 --><fmt:message key='lineFullRoute.allDevice' /></td>
		</tr>
		<tr>
			<td width="230" align="left" valign="top"><div id="allDept" style="height:340px;overflow-y:scroll;padding-left:10px;"><p style="width: 180px; height: 2px; line-height: 2px;"></p></div></td>
			<td width="230" align="left" valign="top"><div id="useAble" style="height:340px;overflow-y:scroll;padding-left:10px;"><p style="width: 180px; height: 2px; line-height: 2px;"></p></div></td>
			<td width="150" align="center" valign="top" style="height:340px;border-width:0px;">
				<p><button id="up" class="tsdbutton" style="visibility:hidden;">上移</button></p><br />
				<p><button id="add" class="tsdbutton"> &lt; <!-- 添加设备 --><fmt:message key='lineFullRoute.add' /></button></p><br />
				<p><button id="delete" class="tsdbutton"> &gt; <!-- 删除设备 --><fmt:message key='lineFullRoute.remove' /></button></p><br />
				<p><button id="up" class="tsdbutton" style="visibility:hidden;">上移</button></p><br />
				<p><button id="down" class="tsdbutton" style="visibility:hidden;">下移</button></p>
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
