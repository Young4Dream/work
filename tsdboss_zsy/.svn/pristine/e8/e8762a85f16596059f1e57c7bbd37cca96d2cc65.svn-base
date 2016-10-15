<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String depart = (String) session.getAttribute("departname");
	String userareaid = (String) session.getAttribute("userarea");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html>
  <head> 
  	<base href="<%=basePath %>" />
  	<link rel="stylesheet" type="text/css" href="ReportServer?op=resource&resource=/com/fr/web/core/css/page.css" /> 
 	<link rel="stylesheet" type="text/css" href="ReportServer?op=resource&resource=/com/fr/web/load.css" /> 
 	<script type="text/javascript" src="ReportServer?op=resource&resource=/com/fr/web/jquery.js"></script> 
 	<script type="text/javascript" src="ReportServer?op=emb&resource=finereport.js"></script>
	<script language="javascript" type="text/javascript">
	
	function RepPri(reportname,paramvalue)
	{
		var parr = paramvalue.split("_");
		
		var param = "";
		for(var i=0;i<parr.length;i++)
		{
			if(i%2==0)
			{
				param += "&";
				param += parr[i];
				param += "=";
			}
			else
			{
				param += parr[i];
			}
		}
		
		if(reportname!="")
		{
			var urll = "ReportServer?reportlet=/com/tsdreport/"+reportname+".cpt"+param;
			
			FR.doURLPDFPrint(urll,false); //参数true表明不弹对话  
			//FR.doURLFlashPrint(urll); //参数true表明不弹对话

			//FR.doPrintURL(urll,1);
		}
	}
	
	
	function RepPriForJob(reportname,paramvalue)
	{
		var urll = "ReportServer?reportlet=/com/tsdreport/"+reportname+".cpt"+paramvalue;
		
		//FR.doPrintURL(urll,1);
		//FR.doURLFlashPrint(urll,true); //参数true表明不弹对话	
		FR.doURLPDFPrint(urll,false);
	}
	</script>
  </head>
  
	<body>
	</body>
</html>
