<%----------------------------------------
	name: right-notices.jsp
	author: 陈良
	version: 1.0, 2010-10-13
	description: 
	modify: 
		2010-11-29 youhongyu 添加头部注释
---------------------------------------------%>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <head>
    
    <title>下载</title>
    
	<meta http-equiv="pragma" content="no-cache" />
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0" />    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
	<meta http-equiv="description" content="This is my page" />
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="script/public/printnews.js" type="text/javascript"></script>
	
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		.thisli{list-style-type:none;list-style-image:url(style/images/public/arrow.jpg);width:75%};
		.thisli li{border-bottom:1px dashed #ccc;line-height:15px};
		body,label,td{
			font-family:verdana,Arial, Helvetica, sans-serif;
			font-size:14px;
			text-align:left;
			text-overflow:ellipsis;
		}
		a{ color:#000000;text-decoration: none; } 
		a:hover { color: #F60; }
		#displaytopinfo a{color:red;text-decoration: none;}
		#displaytopinfo a:hover{color:blue;}
		hr {
			margin:1px 0 1px 0;
			border:0;
			border-top:1px dashed #CCCCCC;
			height:0;
		}
	</style>
	
	
	<style type="text/css">
<!--
/*通用*/

*{padding:0px;margin:0px;}
* li{list-style:none;}

.clearfix:after {
    content: "\0020";
    display: block;
    height: 0;
    clear: both;
}
.clearfix {
    _zoom: 1;
}
*+html .clearfix {
	overflow:auto;
}

.menu_navcc{width:920px; margin:0 auto;}
.menu_nav{width:920px;height:48px;background:url(style/images/public/nav_bg.gif) repeat-x;float:left;margin-top:18px;}
.menu_nav .nav_content{padding-left:25px;background:url(style/images/public/nav_l_bg.gif) no-repeat;float:left;}
.menu_nav .nav_content li{width:95px;height:48px;padding-left:15px;padding-right:13px;background:url(style/images/public/nav_li_right.gif) no-repeat right center;float:left;line-height:48px;text-align:center;font-size:14px;font-weight:bold;}
.menu_nav .nav_content li a{color:#fff;width:95px;height:48px;display:block;}
.menu_nav .nav_content li.current{line-height:37px;}
.menu_nav .nav_content li em{background:url(style/images/public/bid_new.gif) no-repeat;width:35px;height:21px;display:inline-block;position:absolute;top:-20px;left:40px;}

.menu_nav .nav_content li.current a,.menu_nav .nav_content li a:hover{width:95px;height:37px;background:url(style/images/public/nav_li_current.gif) no-repeat;display:block;color:#fff;}
.menu_nav .nav_content li a:hover{background:url(style/images/public/nav_li_hover.gif) no-repeat;line-height:37px;text-decoration:none;}

.menu_nav_right{padding-right:20px;background:url(style/images/public/nav_r_bg.gif) no-repeat right top;float:right;margin-left:50px;padding-top:13px;height:23px;padding-bottom:12px;}
p{
margin-bottom:15px}
-->
</style>
	
  </head>  
  <body>
	<table align="center" style="margin-top:100px;">
					<tr>
						<td>
							<center>
							<fieldset style="width: 670px;margin-left: 20px;text-align:left;height: auto">
								<label style="margin-left: 45px"><b>下载列表</b>:</label>
								<label>&nbsp;&nbsp;<span id="displaytopinfo"></span></label>
								<hr />									
								<table>
									<tr>
									  <td height=30px;>
									  	<A href="<%=basePath %>UserFiles/File/AdbeRdr1000_zh_CN.exe" _fcksavedurl="/UserFiles/File/AdbeRdr1000_zh_CN.exe"><image src="style/images/public/arrow.jpg" alt="点击下载"/> 点击下载PDF打印插件：AdbeRdr1000_zh_CN.exe</A> 
									  </td>											
									</tr>	
									<tr>
									  <td height=30px;>
									  	<A href="<%=basePath %>UserFiles/File/pdf description.doc" _fcksavedurl="/UserFiles/File/pdf description.doc"><image src="style/images/public/arrow.jpg" alt="点击下载"/> 点击下载pdf插件安装配置说明文档：pdf description.doc</A> 
									  </td>											
									</tr>
									<tr>
									  <td height=30px;>
									  	<A href="<%=basePath %>UserFiles/File/IE8-WindowsXP-x86-CHS.exe" _fcksavedurl="/UserFiles/File/IE8-WindowsXP-x86-CHS.exe"><image src="style/images/public/arrow.jpg" alt="点击下载"/> 点击下载IE8更新包：IE8-WindowsXP-x86-CHS.exe</A> 
									  </td>											
									</tr>												
									<tr>
									  <td height=30px;>
									  	<A href="<%=basePath %>UserFiles/File/IE8.doc" _fcksavedurl="/UserFiles/File/IE8.doc"><image src="style/images/public/arrow.jpg" alt="点击下载"/> 点击下载IE8安装配置说明：IE8.doc</A> 
									  </td>											
									</tr>					
								</table>
							</fieldset>
						</center>
					</td>
				</tr>
  			</table>
							
				<input type="hidden" id="distitle"/>
				<input type="hidden" id="disid"/>
				<input type="hidden" id="thistypename" value="sys"/>
				
		   		<div style="display: none">
					 <form action="notices" name="operform" method="post" id="operform">
						<input type='hidden' name="thisflag" id="thisflag"/>
						<input type='hidden' name="nid" id="nid"/>
						<input type="submit" id="willsubmit"/>
					 </form>			
				</div>
  </body>
</html>
