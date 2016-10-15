<%----------------------------------------
	name: lineFullRoute.jsp
	author: 陈泽
	version: 1.0, 2010-10-11
	description: 号线完整路由设置
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
	<title><!-- 号线完整路由设置 --><fmt:message key="Revenue.chargeCheckout" /></title>
	
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
		
			
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
		
				
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
	//选项卡状态
	var tabStatus = 1;
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
		
		$("#tabs").tabs();//初始化分享卡
		//取别名
		filAlias = fetchFieldAlias("air_routesect",$("#lanType").val());		
				
		//添加设备按钮，点击事件
		$("#add").click(function(){
			if($("#allDevice p.selected").size()<1)
			{
				//alert("请选择要添加的设备");
				alert("<fmt:message key='lineFullRoute.addInfo' />");
				return false;
			}
			jdomm.push($("#allDevice p.selected").clone().removeClass("selected").removeClass("over"));
			//取消已添加设备的绑定事件
			$("#allDevice p.selected").unbind("mouseover");
			$("#allDevice p.selected").unbind("mouseout");
			$("#allDevice p.selected").unbind("click");
			$("#allDevice p.selected").unbind("dblclick");
			$("#allDevice p.selected").attr("class","existed");

			genNewRoute();//刷新右侧选框选项
		});
		
		//删除设备按钮，点击事件
		$("#delete").click(function(){
			if($("#choosedDevice p.selected").size()<1)
			{
				//alert("请选择要删除的设备");
				alert("<fmt:message key='lineFullRoute.deleteInfo' />");
				return false;
			}
			//要删除的设备的编码
			var domm = $("#choosedDevice p.selected .DeviceNo").text();
			//所有已添加的设备
			var domms = [];
			$.each($("#choosedDevice span.DeviceNo"),function(i,n){
				domms.push($(n).text());
			});
			
			var index = $.inArray(domm,domms);
			jdomm.splice(index,1);
			
			//恢复删除的设备在所有设备中的状态
			$.each($("#allDevice p"),function(i,n){
				if($(n).find("span.DeviceNo").text()==domm)
				{
					$(n).removeClass("existed");
				}
			});
			
			genNewRoute();//刷新右侧选框选项
			//$("#allDevice").append($("#choosedDevice p.selected").remove().removeClass("selected").removeClass("over"));
			operAll();//给左侧选框中路由设备添加事件，
		});
		//向上移动 
		$("#up").click(function(){
			var domm = $("#choosedDevice p.selected .DeviceNo").text();
			var domms = [];
			$.each($("#choosedDevice span.DeviceNo"),function(i,n){
				domms.push($(n).text());
			});
			
			//alert(domms.join(',')); 
			//alert($.inArray(domm,domms));
			
			var index = $.inArray(domm,domms);
			
			if(index==-1)
			{
				//alert("请选择要移动的设备");
				alert("<fmt:message key='lineFullRoute.moveInfo' />");
				return false;
			}
			if(index == 0)
			{
				//alert("已经是第一个设备");
				alert("<fmt:message key='lineFullRoute.alreadyFir' />");
				return false;
			}
			var temp = jdomm[index-1];
			jdomm[index-1]= jdomm[index];
			jdomm[index] = temp;
			
			genNewRoute();//刷新右侧选框选项
			
		});
		
		//向下移动设备
		$("#down").click(function(){
			var domm = $("#choosedDevice p.selected .DeviceNo").text();
			var domms = [];
			$.each($("#choosedDevice span.DeviceNo"),function(i,n){
				domms.push($(n).text());
			});
			
			var index = $.inArray(domm,domms);
			
			if(index==-1)
			{
				//alert("请选择权移动的设备");
				alert("<fmt:message key='lineFullRoute.moveInfo' />");
				return false;
			}
			if(index == domms.length-1)
			{
				//alert("已经是最后一个设备");
				alert("<fmt:message key='lineFullRoute.alreadyLas' />");
				return false;
			}
			var temp = jdomm[index+1];
			jdomm[index+1]= jdomm[index];
			jdomm[index] = temp;
			
			genNewRoute();//刷新右侧选框选项
		});
		
		$("#back").click(function(){
			$("#choosedDevice p:gt(0)").remove();
			jdomm = [];
			genDeviceList();//初始化时左侧面板可添加设备列表
			
		});
		
		$("#save").click(function(){
			save();
		});
		
		genDeviceList();//初始化时左侧面板可添加设备列表	
		genChoosedFromDB();//在右侧选框中，显示被选中的路由设备		
	});
	
	
	
	/**
	* 保存路由
	* @param 
	* @return 
	*/
	function save()
	{
		var ERROR = [];
		if($("#allDevice p[class!='existed']").size()>1)
		{
			//alert("路由不完整");
			alert("<fmt:message key='lineFullRoute.notComp' />");
			return false;
		}
		var params = "";
		
		var res = executeNoQuery("Linee.delete",6,"&nodesect="+tabStatus);
		if(res=="false"||res==false)
		{
			//保存失败
			return false;
		}
		for(var i=0;i<jdomm.length;i++)
		{
			//temp = fetchSingleValue("Linee.fetchMaxNodeSort",6,"");
			//if(temp=="")
				//temp = 1;
			params = "";
			params += "&NodeName=";
			params += $(jdomm[i]).find(".DeviceNo:first").text();
			params += "&NodeSect=";
			params += tabStatus;
			params += "&NodeField=";
			
			params += $(jdomm[i]).find(".FieldName:first").text();
			params += "&NodeSort=";
			params += (i+1);
			//alert(params);
			var result = executeNoQuery("Linee.addRouteSect",6,params);
			if(result==false||result=='false')
			{
				ERROR.push($(jdomm[i]).find(".DeviceNo:first").text());
				continue;
			}
			
			//成功时       记日志
			var loginfo = "TableName:air_routesect;";
			loginfo += filAlias["NodeName"];
			loginfo += ":";
			loginfo += $(jdomm[i]).find(".DeviceNo:first").text();
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["NodeSect"]);
			loginfo += ":";
			loginfo += tabStatus;
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["NodeField"]);
			loginfo += ":";
			loginfo += $(jdomm[i]).find(".FieldName:first").text();
			
			loginfo += ";";
			loginfo += tsd.encodeURIComponent(filAlias["NodeSort"]);
			loginfo += ":";
			loginfo += (i+1);
			loginfo += ";";
			
			writeLogInfo("","add",loginfo);
		}
		if(ERROR.length==0)
		{
			//alert("组装路由成功");
			alert("<fmt:message key='lineFullRoute.assSucc' />");
		}
		else
		{
			//alert("组装失败在:"+ERROR);
			alert("<fmt:message key='lineFullRoute.assFail' />: " + ERROR);
		}
	}
	
	
	
	/**
	* 初始化时左侧面板可添加设备列表
	* @param 
	* @return 
	*/
	function genDeviceList()
	{
		$("#allDevice p:gt(0)").remove();
		var devices = fetchMultiArrayValue("Linee.fetchDevice",6,"&nodesect=" + tabStatus);
		//alert(devices);
		if(typeof devices[0]=='undefined' || typeof devices[0][0]=='undefined')
			return false;
		var linesss = "";
		for(var i=0;i<devices.length;i++)
		{
			linesss += "<p>"+devices[i][1]+"<span style=\"display:none;\" class=\"DeviceNo\">" + devices[i][0] + "</span>"+"<span style=\"display:none;\" class=\"FieldName\">" + devices[i][2] + "</span>" +"</p>";
		}
		
		$("#allDevice").append(linesss);
		
		operAll();//给左侧选框中路由设备添加事件，
	}
	
	
	
	/**
	* 给左侧选框中路由设备添加事件，
		单击、双击、鼠标移上、鼠标移走
	* @param 
	* @return 
	*/
	function operAll()
	{
		$("#allDevice p:gt(0)").css({width:'180px',height:'26px','line-height':'26px','margin-top':'3px'});
		$("#allDevice p:eq(0)").css({visibility:"hidden"});
		/*
		$("#allDevice p:gt(0)").click(function(){
			$("#allDevice p").removeClass("selected");
			$(this).addClass("selected");			
		}).dblclick(function(){
			$("#add").click();			
		}).mouseover(function(){
			$(this).addClass("over");
		}).mouseout(function(){
			$(this).removeClass("over");
		});
		*/
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
	* 给右侧选框中路由设备添加事件给右侧选框中，
		单击、双击、鼠标移上、鼠标移走
	* @param 
	* @return 
	*/
	function operChoosed()
	{
		$("#choosedDevice p:gt(0)").click(function(){
			$("#choosedDevice p").removeClass("selected");
			$(this).addClass("selected");
		}).dblclick(function(){
			$("#delete").click();			
		}).mouseover(function(){
			$(this).addClass("over");
		}).mouseout(function(){
			$(this).removeClass("over");
		});
		
	}
	

	/**
	* 成功选中的路由设备，刷新右侧选框选项
	* @param 
	* @return 
	*/
	function genNewRoute()
	{
		$("#choosedDevice p:gt(0)").remove();
		for(var i=0;i<jdomm.length;i++)
		{
			$("#choosedDevice").append(jdomm[i]);
		}
		operChoosed();//给右侧选框中，选中的设备添加事件
	}
	
	
	/**
	* 在右侧选框中，显示被选中的路由设备
	* @param 
	* @return 
	*/
	function genChoosedFromDB()
	{
		var devices = fetchMultiArrayValue("Linee.fetchRouteInfo",6,"&nodesect="+tabStatus);
		if(typeof devices[0]=='undefined' && typeof devices[0][0]=='undefined')
			return false;
		var linesss = "";
		for(var i=0;i<devices.length;i++)
		{
			//if($("#allDevice span.DeviceNo:
			linesss += "<p>"+devices[i][1]+"<span style=\"display:none;\" class=\"DeviceNo\">" + devices[i][0] + "</span>"+"<span style=\"display:none;\" class=\"FieldName\">" + devices[i][2] + "</span>" +"</p>";
		}
		
		$("#choosedDevice p:gt(0)").remove();
		$("#choosedDevice").append(linesss);
		
		$("#choosedDevice p:gt(0)").css({width:'180px',height:'26px','line-height':'26px','margin-top':'3px'});
		
		var adoms = [];
		$("#allDevice p:gt(0)").each(function(){
			//alert($(this).text());
			var DNO = $(this).find(".DeviceNo").text();
			//alert(DNO);
			adoms.push(DNO);
		});
		//alert(adoms);
		$("#choosedDevice p:gt(0)").each(function(){
			
			var DNO = $(this).find(".DeviceNo").text();
			var FN = $(this).find(".FieldName").text();
			//alert(adoms+"\n"+DNO);
			var idx = $.inArray(DNO,adoms);
			
			$("#allDevice p:eq("+(idx+1)+")").unbind("mouseover");
				$("#allDevice p:eq("+(idx+1)+")").unbind("mouseout");
				$("#allDevice p:eq("+(idx+1)+")").unbind("click");
				$("#allDevice p:eq("+(idx+1)+")").unbind("dblclick");
				$("#allDevice p:eq("+(idx+1)+")").attr("class","existed");
			
			jdomm.push($(this));
		});	
		
		operChoosed();//给右侧选框中，选中的设备添加事件
	}
	
	
	/**
	 * 点击切换选项卡操作 固话号线完整路由设置、宽带号线完整路由设置之间切换
	 * @param idx 当前被点击的选项卡标识，通过该标识打开相应选项卡
	 * @return 
	 */
	function tabChg(idx)
	{
		tabStatus = idx;		
		//genDeviceList();
		//刷新设备状态
		$("#back").click();		
		genChoosedFromDB();//在右侧选框中，显示被选中的路由设备
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

	<div id="tabs">
		<ul>
			<li><a id="LV1" href="#V1" onclick="tabChg(1)"><span>固话号线完整路由设置 </span></a></li>
			<li><a id="LV2" href="#V1" onclick="tabChg(2)"><span>宽带号线完整路由设置 </span></a></li>
		</ul>
		<div id="V1">
			<div align=center>
				<table id="containerr" align="center" border="1" bordercolor="#999999" style="margin-top:5px;border-collapse:separate">
					<tr>
						<td width="230" align="left" valign="top" style="border-width:0px;font-weight:bold;"><!-- 所有路由设备 --><fmt:message key='lineFullRoute.allDevice' /></td><td width="150" style="border-width:0px;"></td><td width="230" align="left" style="border-width:0px;font-weight:bold;"><!-- 已选路由设备 --><fmt:message key='lineFullRoute.choosed' /></td>
					</tr>
					<tr>
						<td width="230" align="left" valign="top"><div id="allDevice" style="height:320px;overflow-y:scroll;padding-left:20px;"><p style="width: 180px; height: 2px; line-height: 2px;"></p></div></td>
						<td width="150" align="center" style="height:320px;border-width:0px;">
							<p><button id="add" class="tsdbutton"><!-- 添加设备 --><fmt:message key='lineFullRoute.add' /> &gt; </button></p><br />
							<p><button id="delete" class="tsdbutton"><!-- 删除设备 --><fmt:message key='lineFullRoute.remove' />  &lt; </button></p><br />
							<p><button id="up" class="tsdbutton"><!-- 上移 --><fmt:message key='lineFullRoute.up' /></button></p><br />
							<p><button id="down" class="tsdbutton"><!-- 下移 --><fmt:message key='lineFullRoute.down' /></button></p>
						</td>
						<td width="230" align="left" valign="top"><div id="choosedDevice" style="height:320px;overflow-y:scroll;padding-left:20px;"><p style="width: 180px; height: 2px; line-height: 2px;"></p></div></td>
					</tr>
				</table>
			</div>
			<div id="buttons" style="text-align:center;margin-top:12px;">
				<button id="save"><!-- 保存 --><fmt:message key='global.save' /></button><span style="width:80px;visibility:hidden">_________</span><button id="back"><!-- 重置 --><fmt:message key='tariff.reset' /></button>
			</div>
		</div>
	</div>
  </body>
</html>
