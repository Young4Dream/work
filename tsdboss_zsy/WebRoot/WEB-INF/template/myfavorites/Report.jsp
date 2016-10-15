<%----------------------------------------
	name: Report.jsp
	author: 孙琳
	version: 1.0, 2010-11-04
	description: 没有可打印的报表文件
	modify: 
		2011-02-25  cz   修改js处理错误
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<html>
	<head>
		<title>Common Report</title>		
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/main.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script type="text/javascript">
		/**
		 * 查看当前用户的扩展权限
		 * @param 无参数
		 * @return 无返回值
		 */
		function setUserRight()
		{
			var allRi = fetchMultiPValue("Duty.getPower",6,"&userid="+$("#userid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
			if(typeof allRi == 'undefined' || allRi.length == 0)
			{
				//alert("取权限失败");
				return false;
			}
			if(allRi[0][0]=="all")
			{
				return true;
			}
			var reportname = '';
			
			for(var i = 0;i<allRi.length;i++){
				if(getCaption(allRi[i][0],'reportname','')!="")
				{
					reportname = getCaption(allRi[i][0],'reportname','');
					break;
				}			
			}
			$("#reportlet").val("/com/tsdreport/" + reportname + ".cpt");
		}
		/**
		 * 中文编码
		 * @param 无参数
		 * @return 无返回值
		 */
		function cjkEncode(text) {   
        	    if (text == null) {   
        	        return "";   
        	    }   
        	 var newText = "";   
        	    for (var i = 0; i < text.length; i++) {   
        	        var code = text.charCodeAt (i);    
        	        if (code >= 128 || code == 91 || code == 93) {//91 is "[", 93 is "]".   
        	            newText += "[" + code.toString(16) + "]";   
        	        }
        	        else if(code==37)
        	        {
        	        	newText += "%25"; 
        	        }
        	        else {   
        	            newText += text.charAt(i);   
        	        }
        	           
        	    }   
        	 return newText;   
    	}  
    	/**
		 * 下载报表
		 * @param 无参数
		 * @return 无返回值
		 */
    	function loadFromReportConfig()
    	{
    		var res = fetchSingleValue("cReport.FileName",7,"&menuid="+$("#imenuid").val());
    		if(res!=undefined && res!="")
    		{
    			$("#reportlet").val("/com/tsdreport/" + res);
    		}
    	}
	</script>
		
	</head>
	<body>
		<form name="report" id="report" method="get">
			<!-- 报表文件名 -->
			<input type="hidden" name="reportlet" id="reportlet"  />
			<!-- UserID -->
			<input type="hidden" name="userid" id="userid" value="<%=(String)session.getAttribute("userid")%>" />
			<!-- UserName -->
			<input type="hidden" name="username" id="username" value="<%=(String)session.getAttribute("username")%>" />
			<!-- 管理区域 -->
			<input type="hidden" name="managearea" id="managearea" value="<%=(String)session.getAttribute("managearea")%>" />
			<!-- 部门 -->
			<input type="hidden" name="departname" id="departname" value="<%=(String)session.getAttribute("departname")%>" />
			<!-- 权限组ID -->
			<input type="hidden" name="groupid" id="groupid" value="<%=(String)session.getAttribute("groupid")%>" />
			<!-- 营收区域 -->
			<input type="hidden" name="chargearea" id="chargearea" value="<%=(String)session.getAttribute("chargearea")%>" />
			<!-- 业务区域 -->
			<input type="hidden" name="userarea" id="userarea" value="<%=(String)session.getAttribute("userarea")%>" />
		</form>
	
		<input type="hidden" name="userid" id="userid" value="<%=(String)session.getAttribute("userid")%>" />
		<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
		<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
		<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 		
		
		<div id="error" style="width:360px;height:80px;border:#99ccff 1px solid;line-height:80px;text-align:center;vertical-align:middle;display:none;">
			<h3>没有可打印的报表文件</h3>
		</div>
		
		<script language="javascript">
		
			setUserRight();
			
			loadFromReportConfig();
			
			var obj = document.report.reportlet;
						
			if(obj.value == "" || obj.value==undefined || obj.value=="null")
			{
				error.style.marginLeft = (document.body.clientWidth - 360)/2;
				error.style.marginTop = (document.body.clientHeight - 300)/2;
				error.style.display = "block";
			}
			else
			{
				//document.report.action = $("#thisbasePath").val() + "ReportServer";
				//document.report.submit();
				var param = $("#thisbasePath").val() + "ReportServer";
				$.each($("#report :hidden"),function(i,n){
					param = param + "&";
					param = param + $(n).attr("name");
					param = param + "=";
					param = param + cjkEncode($(n).attr("value"));
				});
				param = param.replace("ReportServer&reportlet","ReportServer?reportlet");
				document.location = param;
			}
		</script>
	
	</body>
</html>