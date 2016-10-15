<%----------------------------------------
	name: right-notices.jsp
	author: 
	version: 1.0, 2010-12-13
	description: 
	modify: 
		2010-12-13 liwen 添加头部注释
---------------------------------------------%>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String thisflag = request.getParameter("thisflag");
String nid = request.getParameter("nid");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  
    <title>页面跳转</title>
    <script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
    	$(document).ready(function(){$('#willsubmit').click();});
	</script>
  </head>
  
  <body>
   		<div style="display: none">
			 <form action="notices" name="operform" method="post" id="operform">
				<input type='hidden' name="thisflag" id="thisflag" value="<%=thisflag %>"/>
				<input type='hidden' name="nid" id="nid" value="<%=nid %>"/>
				<input type="submit" id="willsubmit"/>
			 </form>			
		</div>
  </body>
</html>
