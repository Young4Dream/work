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
	cld.add(Calendar.DAY_OF_MONTH,-7);
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
		
		var res = fetchMultiArrayValue("ReportParam.stationswithflag",6,"");
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			var optHtml = "<option value=\"%\">全部</option>";
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml = optHtml + "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
			}
			$("#stations").html(optHtml);
		}
		$("#tj_tjtype").change(function(){
			var val = $(this).val();
			if(val=="byhzyf")
			{
				$("#tj_type_hzyf").css("display","inline");
				$("#tj_type_time").css("display","none");
			}
			else
			{
				$("#tj_type_time").css("display","inline");
				$("#tj_type_hzyf").css("display","none");
			}
		});
		setUserRight();
	});
	
	function searchHz()
	{
		var hzyf = $("#tj_hzyf").val();
		var timebegin = $("#tj_timestart").val();
		var timeend = $("#tj_timeend").val();
		var area = $("#stations").val();
		var userid = $("#skrid").val();
		var tjtype = $("#tj_tjtype").val();
		
		if(tjtype=="byhzyf")
		{
			if($.trim(hzyf)=="")
			{
				alert("请输入收费月份");
				$("#tj_hzyf").select().focus();
				return;
			}
		}
		else
		{
			if($.trim(timebegin)=="")
			{
				alert("请输入统计起始时间");
				$("#tj_timestart").select().focus();
				return;
			}
			if($.trim(timeend)=="")
			{
				alert("请输入统计截止时间");
				$("#tj_timeend").select().focus();
				return;
			}
		}
		
		var params = "&tstart=" + cjkEncode(timebegin) + "&tend=" + cjkEncode(timeend) + "&hzyf=" + cjkEncode(hzyf);
		params += "&userid=" + cjkEncode(userid) + "&area=" + cjkEncode(area);
		printThisReport1('<%=request.getParameter("imenuid")%>',
					'ywlhz',params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
	}
	
	///设置权限
	function setUserRight()
	{
		var allRi = fetchMultiPValue("Duty.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			$("#ableForOtherArea").val("false");
			var area = $("#area").val();
			if(area.indexOf("-")>0)
				area = area.substr(2,area.length);
			$("#stations").val(area);
			$("#stations").attr("disabled","disabled");
			return false;
		}
		if(allRi[0][0]=="all")
		{
			$("#ableForOtherArea").val('true');	
			return true;
		}
		var ableForOtherArea = "false";
		
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'ableForOtherArea','')=="true")
				ableForOtherArea = 'true';	
		}
		if(ableForOtherArea=="true")
		{
			
		}
		else
		{
			var area = $("#area").val();
			if(area.indexOf("-")>0)
				area = area.substr(2,area.length);
			$("#stations").val(area);
			$("#stations").attr("disabled","disabled");
		}
		$("#ableForOtherArea").val(ableForOtherArea);
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
	<legend style="font-size:14px">业务量汇总</legend>
		<div id="tj_way_area" style="display:inline;">
			选择营业区域：
			<select id="stations" name="stations" style="width:120px;"></select>
		</div>
		
		<div id="tj_type_hzyf" style="display:none;">
			<input type="text" name="hzyf" id="tj_hzyf" style="width:90px;" onFocus="WdatePicker({startDate:'%y-%M',dateFmt:'yyyyMM'})" value="<%=hzdf.format(new Date()) %>" />
		</div>
		<div id="tj_type_time" style="display:inline;">
			<input type="text" name="hzyf" id="tj_timestart" style="width:90px;" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" value="<%=sdf.format(cld.getTime()) %>" />
			至
			<input type="text" name="hzyf" id="tj_timeend" style="width:90px;" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" value="<%=sdf.format(new Date()) %>" />
			
		</div>
		
		<div id="tj_paytype" style="display:inline;">
			<button class="tsdbutton" onclick="searchHz()">查询</button>
		</div>
		<br />
		<p style="visibility:hidden">1</p>
		<p style="visibility:hidden">1</p>
		<p style="visibility:hidden">1</p>
		<p style="visibility:hidden">1</p>
		<p style="visibility:hidden">1</p>
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
