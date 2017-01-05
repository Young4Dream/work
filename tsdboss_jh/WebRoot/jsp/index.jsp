<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>WEB查询系统</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<!-- <link rel="stylesheet" href="css/style.css" type="text/css" /> -->
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
	function requestJson(){ 
		var username=$("#username").val();
		var password=$("#password").val();
		var pames ='username='+username+'&password='+password;	
        $.ajax({  
     type:'post',      
     url:'${pageContext.request.contextPath }/login.action',  
     data:pames,  
     cache:false,  
     dataType:'json',  
     success:function(data){  
       var user=data.username;
        if(user!=null || user!=''){
        	$(document).ready(function(e) {
        		//这个就是跳转了，后面那个是网址
        		location.href="${pageContext.request.contextPath }/adminMain.action";
        		});
        }
     }  
 });  
   
 }
	</script>
</head>

<body style="background-color: #336699">
	<div align="center">
		<table width="900px" height="600px" border="0" cellpadding="0"
			cellspacing="0"
			style="background-image: url(images/ibg.jpg); background-repeat: no-repeat; background-position-y: center;">
			<tr style="height: 35%;">
				<td align=center style="height: 35%"><a href="jsp/welcome.jsp"><font
						style="font-size: 28px; font-family: 宋体; font-weight: bold"
						color="#0000FF"> 欢迎进入话单查询系统</font></a></td>
			</tr>
			<tr style="height: 65%;">
				<td>&nbsp;</td>
			</tr>
		</table>
	</div>


</body>
</html>
