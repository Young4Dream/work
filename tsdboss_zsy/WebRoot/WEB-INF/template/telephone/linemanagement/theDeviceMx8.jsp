<%----------------------------------------
	name: theDeviceMx.jsp
	author: chenliang
	version: 1.0, 2009-11-26
	description: 
	modify: 		
		  2010-11-5 youhongyu 添加注释功能	
		  2010-11-24chenze    添加回调函数，用于传值父级节点的编号
		  2011-6-9  youhongyu 配合路由实现方式调整
		  2011-6-16 youhongyu 显示改模块下的所有端子，补全端子显示表格
		  2011-6-28 youhongyu 将已被占用的号线端子的号码显示出来
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";

	String userid = (String) session.getAttribute("userid");

	String DeviceNo = request.getParameter("DeviceNo");
	
	String devicetype = request.getParameter("devicetype");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");

	String departname = (String) session.getAttribute("departname");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>The-Device-Mx-Manager</title>
		
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
			var urlstr=tsd.buildParams({ 	
		 		 						packgname:'service',//java包
					 					clsname:'ExecuteSql',//类名
					 					method:'exeSqlData',//方法名
					 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 					tsdcf:'mssql',//指向配置文件名称
					 					tsdoper:'query',//操作类型 
					 					datatype:'xmlattr',//返回数据格式 
					 					tsdpk:'userLineManager.querythemx'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					 				});
			var DeviceNo = $('#DeviceNo').val();
			var devicetype = $('#devicetype').val();
			var NodeState = 'free';
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&DeviceNo='+tsd.encodeURIComponent(DeviceNo)+'&devicetype='+tsd.encodeURIComponent(devicetype)+'&NodeState='+NodeState,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
						var i=1;
						var talbe = "<table width='800px' align='center' border='1' ><caption border='2px' style='font-size: 14px;border-color: black'>选择端口</caption><tr>";
						$(xml).find('row').each(function(){
                  				NodeName=$(this).attr("NodeName".toLowerCase());
                  				NodeState=$(this).attr("NodeState".toLowerCase());
                  				//alert(NodeState);
                  				var DeviceNo=$(this).attr("DeviceNo".toLowerCase());
                  				var DeviceNoDH=$(this).attr("dh".toLowerCase());
                  				//alert('0x0='+DeviceNoDH);
                  				if(i%8==0){
                  					if(NodeState=="free"){
                  						talbe = talbe + "<td width='12%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='green' style='font-size: 11px;'>"+NodeName+"</font></td></tr><tr>";
                  					}else if(NodeState=="using"){
                  						talbe = talbe + "<td width='12%'><font color='red' style='padding-left:20px;font-size: 11px;' >"+NodeName+"("+DeviceNoDH+")</font></td></tr><tr>";
                  						//<input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/>
                  					}else if(NodeState=="bad"){
                  						talbe = talbe + "<td width='12%'><font color='blue' style='padding-left:20px;font-size: 11px;' >" + NodeName + "</font></td></tr><tr>";
                  						//<input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/>
                  					}
                  				}else{
                  					if(NodeState=="free"){
                  						talbe = talbe + "<td width='12%'><input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/><font color='green'  style='font-size: 11px;'>"+NodeName+"</font></td>";
                  					}else if(NodeState=="using"){
                  						talbe = talbe + "<td width='12%'><font color='red' style='padding-left:20px;font-size: 11px;' >"+NodeName+"("+DeviceNoDH+")</font></td>";
                  						//<input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/>
                  					}else if(NodeState=="bad"){
                  						talbe = talbe + "<td width='12%'><font color='blue' style='padding-left:20px;font-size: 11px;'>"+NodeName+"</font></td>";
                  						//<input type='radio' name='NodeName' value='"+NodeName+"' onClick='checkNodeName(this.value,\""+DeviceNo+"\")'/>
                  					}
                  				}
                  				i++;
						 });
						 //补全端口表格
						 if(i%8!=1){
						 	while(i%8!=1){
						 		talbe = talbe + "<td width='12%'></td>";
						 		i++;
						 	}
						 }
						 talbe = talbe+"</tr></table>";
						 $('#pagered1').html(talbe);
				}
			});
		});
		function checkNodeName(value,DeviceNo){
			$('#thenodename').val(value);
			$('#thenodeno').val(DeviceNo);
		}
		/**
		*  选择设备
		* @param
		* @return 
		*/
		function selectAndClose(){
			var NodeName = $('#thenodename').val();
			var DeviceNo = $('#thenodeno').val();
			if(NodeName!=''&&null!=NodeName){
				window.dialogArguments.getTheSelected(NodeName,DeviceNo,$('#DeviceNo').val());  //增加参数存储父级设备编号
				window.close();
			}else{
				alert('请选择设备!');
			}
		}
		//关闭本模块窗口
		function closeDialog(){
			//window.dialogArguments.closeDialog();
			window.close();
		}
		</script>
  </head>

	<body style="width: 99.5%">
		<div id="navBar">
			<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
			<fmt:message key="global.location" />
			: 号线管理 >>> 选择端口
		</div>
		<div id="pagered1"></div>
		<div style="margin-top: 5px"><strong style="margin-left: 50px">注：绿色代表可用端口，红色代表不可用端口，蓝色代表坏端口。</strong></div>
		<div id="buttons">
			<button type="button" style="margin-left: 350px"
				onclick="selectAndClose()">
				选择
			</button>
			<button type="button" style="margin-left: 10px"
				onclick="closeDialog();">
				关闭
			</button>
		</div>
		<input type="hidden" id="basePath" value="<%=basePath%>" />
		<input type="hidden" id="DeviceNo" value="<%=DeviceNo%>" />
		<input type="hidden" id="devicetype" value="<%=devicetype%>" />
		
		<input type="hidden" id="thefree" />
		<input type="hidden" id="operationtips"
			value="<fmt:message key="global.operationtips"/>" />
		<input type="hidden" id="thenodename" />
		<input type="hidden" id="thenodeno" />
	</body>
</html>
