<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>加载显示...</title>
<link href="style/style.css" rel="stylesheet" type="text/css" />

<!--[if IE]>
<style type="text/css">
.toplogo {
    background:none;
    filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='image/logobg.png' ,sizingMethod='crop');
}
.toplogo01{
    background:none;
    filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src='image/logo02.png' ,sizingMethod='crop');
}
</style>
<![endif]-->
</head>

<body>

<div class="rig">
  <div class="midContent">
  <div class="midContent_1">
  <div class="midInquiry">
  <div class="midInquiry_Frame ">
	<div class="rigtop"></div>
	<div class="rigneirong">
	  <div class="welco">
	    <div class="welcoleft"><img src="style/images/public/welco01.jpg" /></div>
		<div class="welcobg">
		  <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <%
              	String languageType = (String)session.getAttribute("languageType");
               	if(!languageType.equals("en")){
               %>
              	<td align="center"><img src="style/images/public/mihuanying.jpg" /></td> 
               <%
               	}else{
               %>
               	<td align="center"><img src="style/images/public/engmihuanying.jpg" /></td>
              <%} %>
            </tr>
          </table>
		</div>
		<div class="welcoright"><img src="style/images/public/welco02.jpg" width="121" height="218" /></div>
	  </div>
	</div>
 </div>
</div>
</div>
</div>
</div>	

</body>
</html>
