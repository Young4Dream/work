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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
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
	<!-- 分项卡 -->
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
	
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
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
	<!-- 验证框架需要导入的js文件 -->
	<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
  	<!-- 操作列样式 -->
	<script src="script/public/public.js" type="text/javascript"></script>
	<!-- 验证数据长度附 -->
	<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
	<script src="script/public/datalength.js" type="text/javascript"></script>
	<!-- 菜单样式 -->
	<link rel="stylesheet" href="style/css/telephone/usermanagement/single_thirteen.css" type="text/css" />
	<!-- 时间插件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>

	<style type="text/css">
	.tsdbutton{margin-bottom:-2px;margin-top:2px;}
	/*div,span{font-size:14px;}*/
	</style>
	<script>
	$(function(){
		
		var res = fetchMultiArrayValue("ReportParam.stations",6,"");
		if(res[0]!=undefined && res[0][0]!=undefined)
		{
			var optHtml = "<option value=\"%\">全部</option>";
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml = optHtml + "<option value=\"" + res[ii][0] + "\">" + res[ii][0] + "</option>";
			}
			$("#stations").html(optHtml);
		}
		
		res = fetchMultiArrayValue("ReportParam.paytype",6,"");
		if(res[0]!=undefined)
		{
			var optHtml = "<option value=\"%\">全部</option>";
			for(var ii=0;ii<res.length;ii++)
			{
				optHtml = optHtml + "<option value=\"" + res[ii][0] + "\">" + res[ii][1] + "</option>";
			}
			$("#paytypes").html(optHtml);
		}
		
		setUserRight();
		loadLists();
		
	});
	
	function search()
	{
		loadLists();
	}
	
	function loadLists()
	{
		$("#container").html("<table id=\"maingrid\" class=\"scroll\"></table><div style=\"text-align:left\" id=\"maingridpager\" class=\"scroll\"></div>");
		var cols = "skry,lsz,hth,yhmch,byck,jfshj,xzjfshj,pay_flag";
		var cna = "收款员,流水号,合同号,付费名称,实收金额,缴费时间,销账时间,原结算方式";
		<%if(languageType=="en"){%>
			cna = cols;
		<%}%>
		var colNames = cna.split(",");
		var colModelStr = cols.split(",");
		var colModels = [];
		
		for(var i=0;i<colModelStr.length;i++)
		{
			var temp = "{name:'"+colModelStr[i]+"',index:'"+colModelStr[i]+"',width:132}";				
			colModels.push(new Function("return "+temp)());
		}
		colModels[0].width=80;
		colModels[5].width=150;
		colModels[6].width=150;
		
		var urlstr=tsd.buildParams({packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式
									tsdpk:'fxzcx.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'fxzcx.queryc'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
								});
	
		$("#maingrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&xtype=" + encodeURIComponent($(":radio[name='byarea']:checked").val()) + "&paytype=" + encodeURIComponent($("#paytypes").val()) + "&skrid=" + encodeURIComponent($("#skrid").val()) + "&ttype=" + encodeURIComponent($("#tj_tjtype").val()) + "&timeend=" + encodeURIComponent($("#tj_timeend").val()) + "&timestart=" + encodeURIComponent($("#tj_timestart").val()) + "&area=" + encodeURIComponent($("#stations").val()),
				datatype: 'xml', 
				colNames:colNames, 
				colModel:colModels, 
				       	rowNum:30, //默认分页行数
				       	//multiselect:true,
				       	rowList:[30,50,100,1000], //可选分页行数
				       	useDefault:true,
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#maingridpager'), 
				       	//sortname: $("#yhlb").val(), //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:'反销账查询',
				       	height:290, //高
				       	//width:document.documentElement.clientWidth-57,
				       	height:document.documentElement.clientHeight-157,
				       	loadComplete:function(){
				       		if($("#maingrid tr.jqgrow[id='1']").html()!="")
				       			$("#printDetail").removeAttr("disabled");
					}
				}).navGrid('#maingridpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
				); 
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
			
			$("#stations").val(area);
			$("#stations").attr("disabled","disabled");
			return false;
		}
		if(allRi[0][0]=="all")
		{
			$("#ableForOtherArea").val('true');	
			$("#tj_way_st").css("display","inline");
			return true;
		}
		var ableForOtherArea = "false";
		
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'ableForOtherArea','')=="true")
				ableForOtherArea = 'true';	
		}
		/*if(ableForOtherArea=="true")
			$("#tj_way_st").css("display","inline");
		*/	
		if(ableForOtherArea=="true")
		{
			
		}
		else
		{
			var area = $("#area").val();
			
			$("#stations").val(area);
			$("#stations").attr("disabled","disabled");
		}
		$("#ableForOtherArea").val(ableForOtherArea);
	}
	
	function ghPrintDetail()
	{
		var params = "";
		params += "&xtype=" + cjkEncode($(":radio[name='byarea']:checked").val()) + "&paytype=" + cjkEncode($("#paytypes").val()) + "&skrid=" + cjkEncode($("#skrid").val()) + "&ttype=" + cjkEncode($("#tj_tjtype").val()) + "&timeend=" + cjkEncode($("#tj_timeend").val()) + "&timestart=" + cjkEncode($("#tj_timestart").val()) + "&area=" + cjkEncode($("#stations").val());
		printThisReport1('<%=request.getParameter("imenuid")%>',
				"fxzcx",params,
				'<%=(String)session.getAttribute("userid")%>',
				'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
				'<%=(String)session.getAttribute("departname")%>',1);
	}
	</script>
  </head>
  
  <body>
  <!-- 
	账期<input type="radio" name="byhzyf" id="byhzyf" />
	<input type="text" name="hzyf" id="tj_hzyf" onFocus="WdatePicker({startDate:'%y-%M',dateFmt:'yyyyMM'})" value="<%=hzdf.format(cld.getTime()) %>" />
	<input type="radio" name="byarea" id="byself" />本人<input type="radio" name="byarea" id="byarea" />本站
	<select id="stations" name="stations" style="width:120px;"></select>
	
	<br />
	时间<input type="radio" name="byhzyf" id="bytime" />
	<input type="text" name="hzyf" id="tj_timestart" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" value="<%=sdf.format(new Date()) %>" />
	至
	<input type="text" name="hzyf" id="tj_timeend" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" value="<%=sdf.format(new Date()) %>" />
	收费方式<select id="paytypes" name="paytypes" style="width:80px;"></select>
	<button class="tsdbutton">查询</button>
   -->
   	<!-- <fieldset style="margin-left:120px;margin-right:120px;margin-top:100px;font-size:14px;">
   	<legend style="font-size:14px">反销账清单</legend> -->
	<br />
	统计方式：<select id="tj_tjtype" style="display:inline;">
		<option value="1">按原缴款时间</option>
		<option value="2">按反销账时间</option>
	</select>
	<div id="tj_type_time" style="display:inline;">
		<input type="text" name="tj_timestart" id="tj_timestart" style="width:80px;" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" value="<%=sdf.format(new Date()) %>" />
		至
		<input type="text" name="tj_timeend" id="tj_timeend" style="width:80px;" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})" value="<%=sdf.format(new Date()) %>" />
		
	</div>
	<div id="tj_way" style="display:inline;">
		<input type="radio" name="byarea" value="1" checked />本人<input type="radio" name="byarea" value="2" />按站		
	</div>
	<div id="tj_way_st" style="display:inline;">
		<select id="stations" name="stations" style="width:120px;"></select>
	</div>
	<div id="tj_paytype" style="display:inline;">
		收费方式<select id="paytypes" name="paytypes" style="width:80px;"></select>		
	</div>
	
	<button class="tsdbutton" onclick="search()">查询</button>
	<button class="tsdbutton" id="printDetail" onclick="ghPrintDetail()" disabled>打印报表</button>
	<!-- </fieldset> -->
	
	<div id="container">
		<table id="maingrid" class="scroll"></table>
		<table id="maingridpager" class="scroll"></table>
	</div>
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
