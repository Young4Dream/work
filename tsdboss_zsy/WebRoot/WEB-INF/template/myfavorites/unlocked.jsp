<%----------------------------------------
	name: unlocked.jsp
	author: 孙琳
	version: 1.0, 2010-11-04
	description: 工号锁定与解除
	modify: 
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>解除工号锁定</title>
    
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache" />
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
	<script type="text/javascript">
	
		/**
		 * 初始化
		 * @param 无参数
		 * @return 无返回值
		 */
		jQuery(document).ready(function () { 
			//获取导航菜单
			$("#navBar1").append(genNavv());
			$('#changeuserid').focus();
		});
		/**
		 * 解除锁定
		 * @param 无参数
		 * @return 无返回值
		 */
		function changestatus(){
			var userid = $("#changeuserid").val();
			if(userid==''||null==userid){
				alert('请输入您要解除锁定的工号');
				$("#changeuserid").focus();
				return;
			}
			
			var urlstr=tsd.buildParams({ 	
				 		 						packgname:'service',//java包
							 					clsname:'ExecuteSql',//类名
							 					method:'exeSqlData',//方法名
							 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 					tsdcf:'mssql',//指向配置文件名称
							 					tsdoper:'query',//操作类型 
							 					datatype:'xmlattr',//返回数据格式 
							 					tsdpk:'userManager.queryuserid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 				});
				
				$.ajax({
					url:'mainServlet.html?'+urlstr+'&userid='+userid,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						$(xml).find('row').each(function(){
							var num = $(this).attr("num");
							if(num==0){
								//工号不存在，请重新输入
								alert("对不起，您输入的工号不存在，请确认后重新输入");
								$("#changeuserid").focus();
							}else{
								//执行更新语句
								 var urlstatus=tsd.buildParams({ 	
								 			packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'exe',//操作类型 
						 					tsdpk:'userManager.changerstatus'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});
								$.ajax({
									url:'mainServlet.html?'+urlstatus+'&userid='+userid+'&userstatus=false',
									cache:false,//如果值变化可能性比较大 一定要将缓存设成false
									timeout: 1000,
									async: false ,//同步方式
									success:function(msg){
										if(msg=="true"){
											alert('操作成功，该工号已解除锁定');
											disclearval();
										}	
									}
								});
							}
						});
					}
				});
		}
		
		/**
		 * 将信息清空
		 * @param 无参数
		 * @return 无返回值
		 */
		function disclearval(){
			$("#changeuserid").val('');
			$("#changeuserid").focus();
		}
	</script>
	<style type="text/css">
		hr {margin:2px 0 2px 0;border:0;border-top:1px dashed #CCCCCC;height:0;}
	</style>
  </head>
  
  <body>
  	<!-- 用户操作导航-->
	<div id="navBar">
		<table width="100%" height="26px">
			<tr>
				<td width="80%" valign="middle">
					<div id="navBar1" style="float: left">
						<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
						<fmt:message key="global.location" />
						:
					</div>
				</td>
				<td width="20%" align="right" valign="top">
					<div id="d2back">
						<a href="javascript:void(0);"
							onclick="parent.history.back(); return false;"><fmt:message
								key="gjh.houtuei" />
						</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<hr />
		<table style="margin-left: 20px">
			<tr>
				<td>
					请输入您要解除锁定的工号:<input type="text" name="changeuserid" id="changeuserid" style="width:200px" class="textclass"/>
				</td>
				<td>
					<div class="midd_butt" style="margin-bottom: 5px">
						<button type="submit" class="tsdbutton" style="width: 80px" id="disbut" onclick="changestatus();">
								<fmt:message key="global.ok" />
						</button>
						<button type="button" class="tsdbutton" style="width: 80px" onclick="disclearval()" style="margin-left: 10px">
								重置
						</button>
					</div>
				</td>
			</tr>
		</table>
	<hr />
  </body>
</html>
