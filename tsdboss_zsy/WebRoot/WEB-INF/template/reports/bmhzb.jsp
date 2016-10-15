<%@ page language="java" import="java.util.*,java.text.*" pageEncoding="UTF-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat hzdf = new SimpleDateFormat("yyyyMM");
	Calendar cld = Calendar.getInstance(); 
	cld.setTime(new Date());
	cld.add(Calendar.MONTH,-1);
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="style/js/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- tab滑动门 需要导入的样式表 *注意路径-->
	<script type="text/javascript" src="css/tree/dtree.js"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>		
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 页面国际化 -->
	<script type="text/javascript" src="script/broadband/usercat/Internationalization.js"></script>
	<!-- 时间插件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
<!-- 导入js文件结束 -->
<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<!-- 分项卡 -->
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
	
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
	<style type="text/css">
	.tsdbutton{margin-bottom:-2px;margin-top:2px;}
	div,span{font-size:14px;}
	</style>
	<script>
	$(function(){
		$("#navBar").append(genNavv());
		gobackInNavbar("navBar");
	});
	
	function search()
	{
		var hzyf = $("#hfhzb").val();
		var mokuaiju = $("#stations").val();
		var userid = $("#skrid").val();
		var starthth = $("#starthth").val();
		var stophth = $("#stophth").val();
		if($.trim(hzyf)=="")
		{
			alert("请输入账期");
			$("#hfhzb").select().focus();
			return;
		}
		if($.trim(starthth)==""){
			alert("请输入起始合同号");
			$("#starthth").select().focus();
			return;
		}
		if($.trim(stophth)==""){
			alert("请输入截止合同号");
			$("#stophth").select().focus();
			return;
		}
		if(parseInt($.trim(starthth),10)>parseInt($.trim(stophth),10)){
			alert("起始合同号不能大于截止合同号");
			$("#starthth").select().focus();
			return;
		}

		var params = "&hzyf=" + cjkEncode(hzyf);
		params += "&userid=" + cjkEncode(userid);
		params += "&starthth=" + cjkEncode(starthth);
		params += "&stophth=" + cjkEncode(stophth);
		printThisReport1('<%=request.getParameter("imenuid")%>',
					'bmhzb',params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
	}
	</script>
  </head>
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:
	</div>
	<br />
	<fieldset style="margin-left:120px;margin-right:120px;margin-top:100px;font-size:14px;">
		<legend style="font-size:14px">大客户汇总表</legend>
		<div style="font-size:14px;">
		<center>
			账期：<input type="text" id="hfhzb" style="width:80px" value="<%=hzdf.format(cld.getTime()) %>"  onFocus="WdatePicker({startDate:'%y-%M',dateFmt:'yyyyMM'})" />
			起始合同号：<input type="text" id="starthth" style="width:100px;"/>
			截止合同号：<input type="text" id="stophth" style="width:100px;"/>
			<div id="tj_paytype" style="display:inline;">
				<button class="tsdbutton" onClick="search()">查询</button> 
			</div>
			<br />
		</center>	
		</div>
	</fieldset>
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType%>' />
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />	
	<input type="hidden" id="ableForOtherArea" name="ableForOtherArea" value="false" />
	<input type="hidden" id="ableJfDetail" name="ableJfDetail" />
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
  </body>
</html>
