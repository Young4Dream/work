<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'josnTest.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
     function requestJson(){   
            $.ajax({  
         type:'post',      
         url:'${pageContext.request.contextPath }/requestJson.action',  
         data:'name=手机&price=999',  
         cache:false,  
         dataType:'json',  
         success:function(data){  
           alert(data.name);
         }  
     });  
     
     }
   </script>
</head>

<body>
	<input type="button" onclick="requestJson();" value="输入" />
</body>
</html>
