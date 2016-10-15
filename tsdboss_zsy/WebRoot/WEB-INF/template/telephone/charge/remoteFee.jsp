<%----------------------------------------
	name: 		Duty.jsp
	author: 	huoshuai
	version: 	1.0, 2010-11-3
	description: 营收、业务流水和统计，主要是对日常营收业务的统计，
				 其中包括：宽带缴费流水、电话缴费流水、宽带业务流水、电话业务明细、故障受理、套餐。
				 可以按照日期，选择要查询的工号，来进行统计。可以导出数据、打印报表以及 高级查询。
	modify: 
		2012-02-10	chenliang	国际化
---------------------------------------------%>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>    
	<title></title>
<!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="style/js/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 页面国际化 -->
	<script type="text/javascript" src="script/broadband/usercat/Internationalization.js"></script>
	<!-- 时间插件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
<!-- 导入js文件结束 -->
<!-- 导入css文件开始 -->
	<!-- 分项卡 -->
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		
<!-- 导入css文件结束 -->
	<!-- 双导航栏异常处理 -->
	<style type="text/css">
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		
		.neirong .midd #cArea{line-height:18px;}
	</style>
	<script language="javascript" type="text/javascript">
	var Clerks = "";
	
	$(function(){
		$("#navBar1").append(genNavv());
		gobackInNavbar("navBar1");
		
		operInitialization();
		setUserRight();		
		
		//初始化营业员信息
		Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
		
		//拖动工号选择面板
		$("#chooseArea").draggable({handle:"#thisdrag"});
		
		$("#chooseAreaClose").click(function(){
			clearText("chooseArea");
		});
		$("#useridStatus").click(function(){
			$("#addUserId").click();
		});
		$("#xAreaSel").click(function(){
			openXOperator();
		});
		$("#cArea :checkbox.toplevelarea").live("click",function(){
			var checked = $(this).attr("checked");
			$("#cArea :checkbox.tndlevelarea[smallclass='par_" + $(this).val() + "']").attr("checked", checked);
			
		});
		
		$("#statusType").change(function(){
			var xval = $(this).val();
			$(".status_way").hide();
			$("#status_by" + xval).show();
			
			operSearch();
		});
	});
	
	function operSearch()
	{
		loadStatusGrid();
	}
	
	function operInitialization()
	{
		var today = new Date();
		
		var date_n_y = today.getFullYear();
		var date_n_m = today.getMonth();
		date_n_m += 1;
		
		if(date_n_m < 10)
		{
			date_n_m = "0" + date_n_m;
		}
				
		var date_n_s = today.getDate();
		
		if(date_n_s < 10)
		{
			date_n_s = "0" + date_n_s;
		}
		
		date_n = date_n_y + "-" + date_n_m + "-" + date_n_s;		
		
		var time_n = today.getHours()+":"+today.getMinutes()+":"+today.getSeconds();
		//默认起始时间
		$("#tBegin").val(date_n + " 00:00:00");
		//默认结束时间
		$("#tEnd").val(date_n + " " + "23:59:59");
		
		///电话杂费  起始日
		//$("#tBegin").focus(function(){
		//	WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true});
		//});
		
		///电话杂费  起始日
		//$("#tEnd").focus(function(){
		//	WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true});
		//});
	}
	
	function operOperator()
	{
		getUserArea();
		autoBlockForm('chooseArea',20,'chooseAreaClose',"#FFFFFF",false);
	}
	//获取营业区域
	function getAsysArea()
	{
		var asysarea = fetchMultiValue("ghCrossStatus.fetchUserArea",6,"&tstart=" + encodeURIComponent($("#tBegin").val()) + "&tend=" + encodeURIComponent($("#tEnd").val()));
		//fetchMultiValue("ghCrossStatus.fetchArea",6,"");
		if(asysarea[0]!=undefined)
		{
			var tabHtml = "";
			var ii = 0;
			var colspan = 7;
			for(ii = 0;ii<asysarea.length;ii++)
			{
				if((ii+1)%colspan==1)
					tabHtml += "</tr><tr>";
					
				tabHtml += "<td><input type=\"checkbox\" id=\"gmh_" + asysarea[ii] + "\" value=\"" + asysarea[ii] + "\" /><label for=\"gmh_" + asysarea[ii] + "\">" + asysarea[ii] + "<label></td>";				
			}
			if(ii%colspan!=0)
			{
				var kk = ii%colspan;
				while(kk<colspan)
				{
					tabHtml += "<td></td>";
					kk++;
				}
				tabHtml += "</tr>";
			}
			
			tabHtml = tabHtml.replace("</tr>","");
			//if(asysarea.length>0)
				//tabHtml = "<tr><td style=\"text-align:center;\" colspan=\"" + colspan + "\"><button class=\"tsdbutton\" style=\"margin-bottom: 0px;line-height:22px\" onclick=\"$('#ghMultiHthDetTab :checkbox').not(':checked').click()\">全选</button><button class=\"tsdbutton\" style=\"margin-bottom: 0px;line-height:22px\" onclick=\"$('#ghMultiHthDetTab :checkbox').click()\">反选</button></td></tr>" + tabHtml;
			//alert(tabHtml);
			$("#cXArea").html(tabHtml);
		}
		else
			$("#cXArea").html("");
	}
	//打开营收统计面板
	function openXOperator()
	{
		getAsysArea();
		autoBlockForm('chooseXArea',20,'chooseXAreaClose',"#FFFFFF",false);
	}
	//区域 选择面板确定
	function certainForXArea()
	{
		var checkedArea = $.map($("#cXArea :checkbox:checked"),function(n){
			return $(n).val();
		});
		
		$("#xAreaSel").val(checkedArea.join(","));
		setTimeout($.unblockUI,500);
	}
	//获取用户区域和工号
	function getUserArea()
	{
		var userarea = fetchMultiValue("ghCrossStatus.fetchUserArea",6,"&tstart=" + encodeURIComponent($("#tBegin").val()) + "&tend=" + encodeURIComponent($("#tEnd").val()));
		var userareawithuserid = fetchMultiArrayValue("ghCrossStatus.fetchUserAreaWithUserID",6,"&tstart=" + encodeURIComponent($("#tBegin").val()) + "&tend=" + encodeURIComponent($("#tEnd").val()));
		var tabAHtml = "";
		var colspan = 7;
		if(userarea[0]!=undefined)
		{
			for(var ki=0;ki<userarea.length;ki++)
			{
				if($("#Interregional").val()==3 && userarea[ki]!=$("#area").val())  //班长权限 
					continue;
				
				tabAHtml += "<tr><td style=\"font-weight:bold\" colspan=\""+colspan+"\"><input class=\"toplevelarea\" type=\"checkbox\" id=\"gmk_"+userarea[ki]+"\" value=\""+userarea[ki]+"\" /><label for=\"gmk_"+userarea[ki]+"\">"+userarea[ki]+"</lable></td></tr>";
				
				var tabHtml = "";
				var ui = 0;
				for(var ii = 0;ii<userareawithuserid.length;ii++)
				{
					if(userareawithuserid[ii][0]==userarea[ki])
					{
						if((ii+1)%colspan==1)
							tabHtml += "</tr><tr>";
							
						tabHtml += "<td width=\"100\"><input class=\"tndlevelarea\" smallclass=\"par_"+userarea[ki]+"\" type=\"checkbox\" id=\"gmu_" + userareawithuserid[ii][1] + "\" value=\"" + userareawithuserid[ii][1] + "\" /><label for=\"gmu_" + userareawithuserid[ii][1] + "\">" + userareawithuserid[ii][1] + "<label></td>";				
						ui++;
					}
				}
				if(ui%colspan!=0)
				{
					var kk = ui%colspan;
					while(kk<colspan)
					{
						tabHtml += "<td></td>";
						kk++;
					}
					tabHtml += "</tr>";
				}
				
				tabHtml = tabHtml.replace("</tr>","");
				tabAHtml += tabHtml;
			}
			//
			$("#cArea").html(tabAHtml);
		}
	}
	
	//区域 选择面板确定
	function certainForUser()
	{
		var checkedUser = $.map($("#cArea :checkbox:checked").not(".toplevelarea"),function(n){
			return $(n).val();
		});
		
		$("#useridStatus").val(checkedUser.join(","));
		setTimeout($.unblockUI,500);
	}
	
	////////////////////////////////////////////////////////////////////////////////
	//////		加缴费和业务表统计结构
	///////////////////////////////////////////////////////////////////////////////	
	function loadStatusGrid()
	{
		var statustype = $("#statusType").val();
		var sql = "ghCrossStatus.statusByGh";
		if(statustype=="mokuaiju")
			sql = "ghCrossStatus.statusByArea";
		
		$("#tab_container").empty();
		$("#tab_container").append("<table id=\"jfGrid\" class=\"scroll\"></table>");
		$("#tab_container").append("<div id=\"jfPager\" class=\"scroll\" style=\"text-align:left\"></div>");
		
		var cols = "Skry,Area,MoKuaiJu,Amount,Fee";
		//var cna = "收款人员,区域,模块局,数量,金额";
		var cna = '<fmt:message key="remoteFee.tabinfos" />';
		if($("#languageType").val()=="en")
		{
			cna = cols;
		}
		var colNames = cna.split(",");
		var colTmp = cols.split(",");
		var colModels = [];
		
		for(var i=0;i<colTmp.length;i++)
		{
			var temp = "{name:'"+colTmp[i]+"',index:'"+colTmp[i]+"',width:138}";			
			colModels.push(new Function("return "+temp)());
		}
		if(statustype=="mokuaiju")
		{
			colNames.splice(0,1);
			colModels.splice(0,1);
		}
		
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:sql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:sql + 'Cnt'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
		var params = "&tstart=" + encodeURIComponent($("#tBegin").val()) + "&tend=" + encodeURIComponent($("#tEnd").val());
		if(statustype=="mokuaiju")
			params += "&areas=" + tsd.encodeURIComponent($("#xAreaSel").val()==""?"~":$("#xAreaSel").val());
		else
			params += "&skrs=" + tsd.encodeURIComponent($("#useridStatus").val()==""?"~":$("#useridStatus").val());
		
		$("#jfGrid").jqGrid({
				url:'mainServlet.html?'+urlstr + params,
				datatype: 'xml', 
				colNames:colNames, 
				colModel:colModels, 
				       	rowNum:15, //默认分页行数
				       	rowList:[15,20,25], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#jfPager'), 
				       	viewrecords: true, 
				       	caption:'<fmt:message key="remoteFee.revenueinfos" />',//'营收统计信息' 
				       	height:document.documentElement.clientHeight-235, //高
				       	width:document.documentElement.clientWidth-30,
				       	loadComplete:function(){
										
						}						
				}).navGrid('#staPager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
	}
	
	///////////////////////////////////////////////////////////////////
	/////                      设置权限
	//////////////////////////////////////////////////////////////////
	function setUserRight()
	{
		var allRi = fetchMultiPValue("Duty.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			changeUserProperty(0);
			return false;
		}
		if(allRi[0][0]=="all")
		{
			$("#Interregional").val('true');
			changeUserProperty(10);
			return true;
		}
		var Interregional = '0';
		
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'RightsGroup','')>Interregional)
				Interregional = getCaption(allRi[i][0],'PowerGroup','');			
		}
		$("#Interregional").val(Interregional);			
		changeUserProperty(Interregional);
	}
	
	function changeUserProperty(typeid)
	{
		if(typeid==10)
		{
			$("#status_simple").hide();
			$("#status_complex").show();
		}
		else if(typeid==3)
		{
			$("#status_simple").hide();
			$("#status_complex").show();
			$("#status_by_mokuaiju_btn").hide();
			$("#status_by_mokuaiju_btn1").hide();
			$("#xAreaSel").val($("#area").val());
		}
		else
		{
			$("#status_simple").show();
			$("#status_complex").hide();
			$("#useridStatus").val($("#skrid").val());
			$("#statusType").val("uid");
		}
		operSearch();
	}
	
	function cjkEncode(text) {   
      	    if (text == null) {   
      	        return "";   
      	    }   
      	 var newText = "";   
      	    for (var i = 0; i < text.length; i++) {   
      	        var code = text.charCodeAt (i);    
      	        if (code >= 128 || code == 91 || code == 93) {//91 is "[", 93 is "]".   
      	            newText += "[" + code.toString(16) + "]";   
      	        } else {   
      	            newText += text.charAt(i);   
      	        }   
      	    }   
      	 return newText;   
      	}  
      	
      	
    ////////////////////////////////////////////////////////////////////////////
	///////////////////////////                打印报表  
	///////////////////////////////////////////////////////////////////////////
	function printR()
	{
		var userids = $("#useridStatus").val();
		var areas = $("#xAreaSel").val();
		var urll = "&skrs="+userids+"&op="+$("#skrid").val()+"&tStart="+$("#tBegin").val()+"&tOver="+$("#tEnd").val()+"&areas="+cjkEncode(areas)+"&"+new Date().getTime();;
		
		var statustype = $("#statusType").val();
		var reportname = "";
		if(statustype=="mokuaiju")
			reportname = "cross_status_bymokuaiju";
		else
			reportname = "cross_status_byuid";
			
		//window.open(urll,'','');
		printThisReport1('<%=request.getParameter("imenuid")%>',
				reportname,urll,
				'<%=(String)session.getAttribute("userid")%>',
				'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
				'<%=(String)session.getAttribute("departname")%>',1);
	}

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
	
	</script>

  </head>
  
  <body style="text-align:left">  
	<form name="childform" id="childform">
		<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
		<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
		<input type="text" id="fuheflag" name="fuheflag" style="display: none"/>
	</form>
	
	<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />
  	<input type="hidden" id="area" name="area" value='<%=request.getSession().getAttribute("chargearea") %>' />
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />

	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	<!-- 语言 -->
	<input type="hidden" id="languageType" name="languageType" value='<%=languageType %>' />
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	<input type="hidden" id="Interregional" />
	<div id="navBar1">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />:
	</div>
	
	<div id="sIn"><!-- 时间范围 -->&nbsp;&nbsp;&nbsp;<fmt:message key="Onduty.timesFrom" />:
		<input type="text" name="tBegin" id="tBegin" onFocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
			<!-- 到 --><fmt:message key="Onduty.timesTo" />
		<input type="text" name="tEnd" id="tEnd" onFocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
		<span id="status_simple">
			<button class="tsdbutton" onclick="operSearch()"><!-- 统计 --><fmt:message key="Onduty.status" /></button>
		</span>
		<br />
		<div id="status_complex">
			&nbsp;&nbsp;&nbsp;<fmt:message key="remoteFee.status" />:
			<select name="statusType" id="statusType">
				<option value="mokuaiju"><fmt:message key="remoteFee.revByStation" /><!-- 按站统计 --></option>
				<option value="uid"><fmt:message key="remoteFee.revByUserid" /><!-- 按工号统计 --></option>
			</select>
			<br />
			<div id="status_bymokuaiju" class="status_way" style="display:block">
				&nbsp;&nbsp;&nbsp;<fmt:message key="remoteFee.AreaType" /><!-- 营业站别 -->:
				<textarea rows="3" cols="50" id="xAreaSel"></textarea>
				<button class="tsdbutton" onclick="openXOperator()" id="status_by_mokuaiju_btn"><fmt:message key="remoteFee.AddAreaType" /><!-- 添加统计站点 --></button>
				<button class="tsdbutton" onclick="operSearch()" id="status_by_mokuaiju_btn1"><!-- 统计 --><fmt:message key="Onduty.status" /></button>
			</div>
			<div id="status_byuid" class="status_way" style="display:none">
				&nbsp;&nbsp;&nbsp;<fmt:message key="remoteFee.skruserid" /><!-- 收款人员 -->:
				<textarea id="useridStatus" rows="3" cols="50" onkeydown="event.returnValue=false;" style="margin-top: 0px;"></textarea>
				<span id="useridStatusLbl" style="display:none;"></span>
				<span id="useridStatusLblWithArea" style="display:none;"></span>
				<button id="addUserId" class="tsdbutton" onclick="operOperator()"><fmt:message key="remoteFee.addTjUserid" /><!-- 添加统计工号 --></button>
				<button class="tsdbutton" onclick="operSearch()"><!-- 统计 --><fmt:message key="Onduty.status" /></button>
			</div>
		</div>
	</div>
	<hr size="1" noshade="noshade"/>	
	<div id="tab_container"></div>
	<!-- 宽带营收流水 -->	
	<div id="displayuntreated"	style="overflow-y: auto; overflow-x: hidden;">
		<div id="jfG"></div>
		<div id="buttons">
			<button type="button" id="export1" onclick="DownFile('v_radjiaofei',5)" style="display:none"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>					
			<button type="button" id="print1" onclick="printR()">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>
			<button type="button" onclick="openDiaQueryG('query','v_radjiaofei',1);" style="display:none">
				<!--查询--><fmt:message key="global.query" />
			</button>
		</div>
	</div>
		
	<!-- 工号面板 -->
	<form class="neirong" id="chooseArea" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="Duty.selectuserid" /><!-- 工号选择 -->
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#chooseAreaClose').click();"><fmt:message key="global.close" /></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:718px;max-height:360px;overflow-y:auto;overflow-x:hidden;">
			<table id="cArea" width="700"></table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" onclick="certainForUser()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="chooseAreaClose">
				<fmt:message key="global.close" />
			</button>
		</div>
	</form>
	
	<!-- 区域面板 -->
	<form class="neirong" id="chooseXArea" style="display:none;width:720px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="remoteFee.AddAreaType" /><!-- 站点选择  -->
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#chooseXAreaClose').click();"><fmt:message key="global.close" /></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:718px;max-height:360px;overflow-y:auto;overflow-x:hidden;">
			<table id="cXArea" width="700"></table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" onclick="javascript:$('#cXArea :checkbox').attr('checked',true)">
				<fmt:message key="charge_phone_dkh.selectall" />
			</button>
			<button type="button" class="tsdbutton" onclick="javascript:$('#cXArea :checkbox:checked').attr('prechecked','k');$('#cXArea :checkbox').attr('checked',true);$('#cXArea :checkbox[prechecked]').attr('checked',false);$('#cXArea :checkbox[prechecked]').removeAttr('prechecked')">
				<fmt:message key="charge_phone_dkh.unselectall" />
			</button>
			<button type="button" class="tsdbutton" onclick="javascript:$('#cXArea :checkbox:checked').attr('checked',false)">
				<fmt:message key="global.clear" />
			</button>
			<button type="button" class="tsdbutton" onclick="certainForXArea()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="chooseXAreaClose">
				<fmt:message key="global.close" />
			</button>
		</div>
	</form>
	
	<input type="hidden" id="tableName"/>
	<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:800px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv"><fmt:message key="onDuty.cexporti18n" /></div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="global.close" /></a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			   <form action="#" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<div id="thelistform" style="margin-left: 10px;max-height: 200px">
						
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
				<fmt:message key="charge_phone_dkh.selectall" />
			</button>
			<button type="submit" class="tsdbutton" id="query" onclick="DownSure()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>
		</div>
	</div>	

	</body>
</html>