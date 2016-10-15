<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");//request.getParameter("groupid");
	String lanType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
   <title>分拣日志管理</title>
  
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="AeroWindow/js/jquery-1.4.2.min.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script type="text/javascript" src="script/public/datalength.js"></script>
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 新的面板样式 -->
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<!-- 分项卡 -->	
	<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
	
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
				
	<style type="text/css">
		.header { 
			font-size: 100%; font-weight: bold; text-align: left;
			padding: 2px;
			background-image: url(plug-in/jquery/jqgrid/themes/basic/images/headerbg.gif) ;
			color: #FFFFFF;
			width: 100%;
			white-space:nowrap; 
		}
		
		.subScroll {
			width:100%; 
			position:fixed;bottom:10px;
			vertical-align: top;
			height: 23px;
			white-space: nowrap;
			text-align: center;
			background-image: url(plug-in/jquery/jqgrid/themes/basic/images/grid-blue-ft.gif);
		}
		button{ padding:4px 8px 4px 8px;  height:25px; margin-top:6px;margin-bottom:4px; margin-left:5px; background: url(./style/images/public/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
	</style>
	<script type="text/javascript">
	$(function(){
		initData();//初始化数据
	});

	
	//初始化页面数据
	function initData(){
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'SortingLogService',//类名
			  method:'query',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'text',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		urlstr +="&logType="+$("#logType").val();
		$.ajax({
			url:"mainServlet.html?"+urlstr,
			datatype:'text',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(text){
			//alert(text);
			$("#tbody").html("");
			var items = text.split(";");
			for(var i in items){
				var item = items[i];
				if(item != "" && null != item && undefined != item){
					var ite = item.split(":");
					if(ite[0].indexOf("billcollect")>-1){//判断正常异常日志的
						$("#tbody").append("<tr>"+
					      "<td>"+(parseInt(i)+1)+"</td>"+
					      "<td>"+ite[0]+"</td>"+
					      "<td>正常日志</td>"+
					      "<td>"+ite[1]+"</td>"+
					      "<td>&nbsp;&nbsp;&nbsp;<img  onclick=\"detail('"+ite[0]+"')\" style='cursor:pointer;' src='style/images/public/ltubiao_03.gif'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img onclick=\"downloadFile('"+ite[0].split("-")[1]+"')\" style='cursor:pointer;' src='style/icon/32.gif'/>&nbsp;</td>"+
					      "<tr>");
					}else{
						$("#tbody").append("<tr style=\"color:red;\">"+
					      "<td>"+(parseInt(i)+1)+"</td>"+
					      "<td>"+ite[0]+"</td>"+
					      "<td>异常日志</td>"+
					      "<td>"+ite[1]+"</td>"+
					      "<td>&nbsp;&nbsp;&nbsp;<img  onclick=\"detail('"+ite[0]+"')\" style='cursor:pointer;' src='style/images/public/ltubiao_03.gif'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img onclick=\"downloadFile('"+ite[0].split("-")[1]+"')\" style='cursor:pointer;' src='style/icon/32.gif'/>&nbsp;</td>"+
					      "<tr>");
					}
				}
			}
		}
	});}
	//下载文件
	function downloadFile(fileName){
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'SortingLogService',//类名
			  method:'download',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'text',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		urlstr +="&fileName="+fileName;
		window.location.href="mainServlet.html?"+urlstr;
	}
	
	//查看日志文件详情
	function detail(fileName){
		if(fileName.indexOf("(最新)")>0){
			fileName = fileName.substring(0,fileName.indexOf("(最新)"));
		}
		$("#fileName").val(fileName);
		$("#currentNo").val("0");
		$("#lastLineContent").val("");
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'SortingLogService',//类名
			  method:'detail',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'text',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		urlstr +="&fileName="+fileName;
		urlstr += "&currentNo=0";
		$.ajax({
			url:"mainServlet.html?"+urlstr,
			datatype:'text',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(text){
				//alert(text);
				$("#lastLineContent").val(text.substring(0,text.indexOf("INFO")));
				$("#fileDetailDiv").html("<br/>"+text);
				autoBlockFormAndSetWH('panX',10,1,'closeoX',"#ffffff",false,1180,'');//弹出查询面板		
				//alert(text);
			}
		});
	}
	/**********************************************************
		function name:   closeoXX()
		function:		 关闭详细信息表格面板
		parameters:      
		return:			 
		description:     关闭详细信息表格面板
		Date:				2016-01-15
	********************************************************/
	function closeoXX(){
		setTimeout($.unblockUI, 0);//关闭面板		
	}
	
	//加载更多日志信息
	function moreLogs(){
		var fileName =$("#fileName").val();
		var urlstr='';
		var dsstr = 'tsdBilling';
		var tsdcfstr = 'oracle';
		urlstr=tsd.buildParams({ 	  
			  packgname:'service',//java包
			  clsname:'SortingLogService',//类名
			  method:'detail',//方法名
			  ds:dsstr,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
			  tsdcf:tsdcfstr,//指向配置文件名称
			  tsdoper:'query',//操作类型 
			  datatype:'text',//返回数据格式 
			  tsdpk:'publicmode.sumKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});	
		urlstr += "&fileName="+fileName;
		urlstr += "&scroll=yes";
		urlstr += "&currentNo="+$("#currentNo").val();
		urlstr += "&lastLineContent="+$("#lastLineContent").val();
		
		$.ajax({
			url:"mainServlet.html?"+urlstr,
			datatype:'text',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(text){
				//<div class='showInfo'>
				$(".showInfo").css("display","none");
				$("#fileDetailDiv").html($("#fileDetailDiv").html()+text);
				$("#lastLineContent").val(text.substring(0,text.indexOf("INFO")));
				$("#currentNo").val(Number($("#currentNo").val())+100);
				//autoBlockFormAndSetWH('panX',60,1,'closeoX',"#ffffff",false,1180,'');//弹出查询面板		
				//alert(text);
			}
		});
	
	}
</script>
</head>

<body> 
<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 

<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
<!-- 语言 -->
<input type="hidden" id="lanType" name="lanType" value='<%=lanType %>' />

<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
<input type="hidden" name="languageType" id="languageType" value='<%=lanType %>' />
  	<div id="navBar">
		<img src="style/icon/dot11.gif" style="margin-left: 10px" />
		<fmt:message key="global.location" />
		: 套餐管理 >>> 分拣日志
		<div style="position:fixed; right:35px;line-height:20px;">
			<a onclick="parent.history.back(); return false;" href="javascript:void(0);">返 回</a>
		</div>
	</div>
  	<br />
	<!-- 用户操作标题以及放一些快捷按钮-->		
	&nbsp;
   <!--   <table>
    	<tr>
    		<td>&nbsp;&nbsp;&nbsp;<span style="font-size:18px;vertical-align:middle;">日志类型：</span></td>
    		<td><select id="logType" name="logType" style="height:20px;width:150px">
					<option value="fjrz">分拣日志</option>	
					<option value="cwrz">错误日志</option>	
				</select>
			</td>
    		<td>&nbsp;&nbsp;
    			<button type="button" id="openadd1" onclick="javascript:initData();">
		  		<fmt:message key="global.query" />
    			</button>
    		</td>
    	</tr>
    </table>-->
	<!-- Tabs -->
	<div id="tabs"  style="width:90%">	
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0" style="width:99%">
		    	<thead>
		    		<tr style="height:0px">
				      <th style="width:8%;height:0px"></th>
				      <th style="width:35%;height:0px"></th>
				      <th style="width:20%;height:0px"></th>
				      <th style="width:25%;height:0px"></th>
				      <th style="width:12%;align:center;height:0px"></th>
				    </tr>
		    		<tr class="header"><img style="float:left;" src="plug-in/jquery/jqgrid/themes/basic/images/headleft.png"></img>&nbsp;分拣日志</tr>
		    		<tr>
				      <th style="width:8%"><b>序号</b></th>
				      <th style="width:35%"><b>日志名称</b></th>
				      <th style="width:20%"><b>日志类型</b></th>
				      <th style="width:25%"><b>文件大小（KB）</b></th>
				      <th style="width:12%;align:center"><b>查看</b>&nbsp;|&nbsp;<b>下载</b></th>
				    </tr>
		    	</thead>
		    	<tbody id="tbody">
		    	</tbody>
		    	<tfoot>
				    <tr>
				    </tr>
				  </tfoot>
		    </table>
		</div>		
	</div>
	<!-- 添加详细信息面板 -->
<div class="neirong" id="panX" style="display: none;width: 1090px;height:360px">
	<br/>
	<div class="top">
		<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >分拣日志详细信息</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoXX()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div>
			<input type="hidden" name="fileName" id="fileName"/> 
			<input type="hidden" name="currentNo" id="currentNo"/> 
			<input type="hidden" name="lastLineContent" id="lastLineContent"/> 
		</div>
		<div style="text-align:left;max-height:350px;overflow-y: auto;overflow-x: hidden;background-color: #fff" id="fileDetailDiv">
			
		</div>
		<div class="midd_butt">		
			<button class="tsdbutton" id="closeoX" style="width:63px;heigth:27px;" onclick="closeoXX();"><fmt:message key="global.close"/></button>
		</div>	
</div>
</body>
</html>
