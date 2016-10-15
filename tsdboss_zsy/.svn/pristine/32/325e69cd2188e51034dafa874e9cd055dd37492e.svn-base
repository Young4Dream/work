<%----------------------------------------
	name: theDeviceType.jsp
	author: chenliang
	version: 1.0, 2009-12-05
	description: 二级设备管理 对号线设备类型的管理
	modify: 		
		  2010-11-5 youhongyu 添加注释功能	
		  2010-11-24chenze    修改getTheSelected（），处理路由段处理
---------------------------------------------%>
<%@page import="com.tsd.service.util.Log"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";

	String userid = (String) session.getAttribute("userid");
	
	String NodeField = request.getParameter("NodeField");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	
	String departname = (String)session.getAttribute("departname");
	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>The-Device-Type-Manager</title>
		
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
		
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		
			
			
<script type="text/javascript">
	/**
	* 页面初始化
	* @param 
	* @return 
	*/
	jQuery(document).ready(function () {
		var NodeField = $('#NodeField').val();//设备别名
		var mkj = '<%=request.getParameter("mkj") %>';//设备所在模块局
		//获取设备类型
		getThisDeviceType(NodeField,mkj);
	});

	
	/**
	* 获取当前下拉选项的值 
	* @param NodeField：
	* @param mkj：
	* @return 
	*/
	function getThisDeviceType(NodeField,mkj){
		var urlstr=tsd.buildParams({ 	
		 		 						packgname:'service',//java包
					 					clsname:'ExecuteSql',//类名
					 					method:'exeSqlData',//方法名
					 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 					tsdcf:'mssql',//指向配置文件名称
					 					tsdoper:'query',//操作类型 
					 					datatype:'xmlattr',//返回数据格式 
					 					tsdpk:'userLineManager.getDeviceType'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					 				});
			var nodename = getNodeName(NodeField);
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&DeviceNo='+tsd.encodeURIComponent(nodename)+'&MoKuaiJu='+tsd.encodeURIComponent(mkj),
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
						var thisdevicetype = '';
						var  i = 1;
						var flag = 0;
						$(xml).find('row').each(function(){
                  				var deviceno = $(this).attr("DeviceNo".toLowerCase());
                  				var devicetype = $(this).attr("DeviceType".toLowerCase());
                  				var deviceicon = $(this).attr("DeviceIcon".toLowerCase());
                  				
                  				var freenum = $(this).attr("free");
                  				var usingnum = $(this).attr("using");
                  				var badnum = $(this).attr("bad");
                  				
                  				var basepath = $('#basePath').val();
                  				
                  				var theicon = '';
                  				if('null'==deviceicon){
                  					theicon = '<%=iconpath %>'+i+'.gif';
                  				}else{
                  					theicon = basepath+deviceicon;
                  				}
                  				if(devicetype!=''&&devicetype!=null){
                  					//var anum = getTheNum('NodeState',deviceno);
                  					//var bnum = getTheNum('NodeState!',deviceno);
                  					var bnum = usingnum*1 + badnum*1;
                  					var thedeviceno = deviceno.substring(4);
                  					//thisdevicetype += "<p><label><input type='radio' onclick=openTheDeviceMx('"+deviceno+"') readonly='readonly' name='devicetype' id='r"+deviceno+"'/><img src='"+theicon+"'/><a href='#' onclick=openTheDeviceMx('"+deviceno+"') ><font  style='font-size: 16px;margin-left:5px'>"+devicetype+"</font></a>(<input type='hidden' id='ian"+thedeviceno+"' value='"+anum+"' ><font color='green'>可用个数："+anum+"个</font>/<font color='red'>不可用个数："+bnum+"个</font>)"+"</label></p>" ;
                  					thisdevicetype += "<tr  height='45px'><td style='border: 1px; border-style: solid; border-color: #87CEFA'><input type='radio' onclick=openTheDeviceMx('"+deviceno+"') name='devicetype' id='r"+deviceno+"'/></td><td align='center' style='border: 1px; border-style: solid; border-color: #87CEFA'><a href='#' onclick=openTheDeviceMx('"+deviceno+"') ><img style='width:76px;height:55px' src='"+theicon+"'/></a></td><td class='ahref' style='border: 1px; border-style: solid; border-color: #87CEFA'><a href='#' onclick=openTheDeviceMx('"+deviceno+"') ><font  style='font-size: 16px;margin-left:5px'>"+devicetype+"</font></a></td><td style='border: 1px; border-style: solid; border-color: #87CEFA'>(<input type='hidden' id='ian"+thedeviceno+"' value='"+freenum+"' ><font color='green'>可用个数："+freenum+"个</font>/<font color='red'>不可用个数："+bnum+"个</font>)</td>"+"</tr>" ;
                  				}else{flag=1;alert('对不起，该区域下暂无此类设备可选择!');window.close();}
							i++;
						});
						if(flag!=1){
							$('#thisdevicetype').html("<br/><table width='500px' align='center' style='border: 1px; border-style: solid; border-color: #87CEFA'><caption border='2px' style='font-size: 14px;border-color: black'>可选择设备列表</caption>"+thisdevicetype+"</table>");
						}
					//	else{
					//		$('#thisdevicetype').html("<center><font style='font-size: 14px;margin-left:5px' >"+thisdevicetype+"</font></center>");
					//	}
						
				}
			});
	}
	/**
	* 获取当前用户所在部门的NodeName
	* @param NodeField：查询的参数
	* @return 
	*/
	function getNodeName(NodeField){
		var NodeName = '';
		var urlstr=tsd.buildParams({ 	
		 		 						packgname:'service',//java包
					 					clsname:'ExecuteSql',//类名
					 					method:'exeSqlData',//方法名
					 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 					tsdcf:'mssql',//指向配置文件名称
					 					tsdoper:'query',//操作类型 
					 					datatype:'xmlattr',//返回数据格式 
					 					tsdpk:'userLineManager.getNodeName'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					 				});
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&NodeField='+tsd.encodeURIComponent(NodeField),
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
						$(xml).find('row').each(function(){
                  				NodeName=$(this).attr("NodeName".toLowerCase());
						 });
				}
			});
		return NodeName;
	}
	
	
	/**
	* 显示三级设备的可用和不可用设备的数量
	* @param DeviceNo：设备
	* @return 返回字符串，显示设备可用和不可用个数
	*/
	function getDeviceMx(DeviceNo){
		var anum = getTheNum('NodeState',DeviceNo);
		var bnum = getTheNum('NodeState!',DeviceNo);		
		var NodeName = '<font color="green">可用个数：'+anum+'个/<font color="red">不可用个数：' + bnum + '个</font>';		
		return NodeName;
	}
	
	/**
	* 显示三级设备的可用和不可用设备的数量
	* @param str：标识设备是否可用 NodeState：可用设备 ；NodeState!不可用设备：
	* @param DeviceNo：设备
	* @return 返回符合条件的设备数量
	*/
	function getTheNum(str,DeviceNo){
		var num = '';
		var urlstr=tsd.buildParams({ 	
		 		 						packgname:'service',//java包
					 					clsname:'ExecuteSql',//类名
					 					method:'exeSqlData',//方法名
					 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 					tsdcf:'mssql',//指向配置文件名称
					 					tsdoper:'query',//操作类型 
					 					datatype:'xmlattr',//返回数据格式 
					 					tsdpk:'userLineManager.getTheNum'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					 		});
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&str='+str+'&DeviceNo='+DeviceNo,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){
						num += $(this).attr("num");
					});
				}
			});
		return num;
	}
	
	/**
	* 显可用设备
	* @param DeviceNo：设备
	* @return 
	*/
	function openTheDeviceMx(DeviceNo){
		document.getElementById('r'+DeviceNo).checked = true;
		//在这导入新数据时还需再测试一下
		//var theDeviceNo = DeviceNo.substring(4);
		var thedeviceno = DeviceNo.substring(4);
		var thefree = $('#ian'+thedeviceno).val();
		if(thefree!='0'&&thefree!=undefined){
			window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/theDeviceMx.jsp&DeviceNo='+DeviceNo,window,"dialogWidth:420px; dialogHeight:400px; center:yes; scroll:yes");
		}else{
			//var operationtips = $("#operationtips").val();
			//var successful = $("#successful").val();
			//jAlert('无可用设备可选择!',operationtips);
			alert('无可用设备可选择!');
		}
	}
	
	/**
	* 获取被选中设备  2010-11-24传递父节点编号 
	* @param str：
	* @return 
	*/
	function getTheSelected(str,pdvno){
		var thei = $('#NodeField').val();
		window.dialogArguments.getTheVlaue(thei,str,pdvno);
		window.close();
	}
</script>
<style type="text/css">
.ahref a {
	cursor: hand;
	text-decoration: none;
}
.ahref a:hover {
	color: #FF8C00;
}
		</style>
  </head>
  
  <body>
  	<div id="navBar" style="width: 820px">
			<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px"/>
			<fmt:message key="global.location" />
			:
			号线管理
			>>>
			选择设备
	</div>
    
    <table cellpadding="5px" cellspacing="5px">
    	<tr>
    		
    	</tr>
    </table>
    
    <div id='thisdevicetype' style="margin-top: 0px;height:365px;overflow-y: auto;overflow-x: hidden;"></div>
	<br />
	<div id="buttons" style="margin-top: 10px;margin-bottom: 0px;width:820px" >
		<button type="button" style='margin-left: 352px' onclick="window.close();">
			关闭
		</button>
	</div>			
	<input type="hidden" id="basePath" value="<%=basePath%>" />
	<input type="hidden" id="NodeField" value="<%=NodeField%>" />
	<input type="hidden" id="thefree"/>
	<input type="hidden" id="theradio"/>
	<input type="hidden" id="operationtips"
					value="<fmt:message key="global.operationtips"/>" />
  </body>
</html>
