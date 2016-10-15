<%----------------------------------------
	name: broadband/usercat/PackageHistoryInfo.jsp
	Function:  历史套餐查询 
	author: 吴长龙
	version: 1.0, 2010-11-3
	description:  
	modify: 
		2010-11-3 吴长龙 添加注释
		2010-11-08  chenze  添加方法注释
		
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
 <%@page import="com.tsd.service.util.Log" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String strarea = (String)request.getSession().getAttribute("chargearea");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>

<%
	SimpleDateFormat format = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    	<title>rates management</title>
  		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script type="text/javascript" src="plug-in/jquery/jquery.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/jquery.jqGrid.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/js/jqModal.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/js/jqDnR.js" ></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="script/public/mainStyle.js" ></script>
		<!-- 验证框架需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/validate/jquery.validate.js" ></script>
		<link rel="stylesheet" type="text/css" media="screen" href="../../js/validate/css/screen.css" />
		<!-- 弹出面板需要导入js文件 -->
		<script type="text/javascript" src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" ></script>
		
		<!-- 弹出对话框需要导入的js文件 -->			
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script type="text/javascript" src="plug-in/jquery/jquery.alerts/jquery.alerts.js" ></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
		<!-- 时间选择器需要导入的js文件 -->	
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js" ></script>
		<!-- 本项目引入 -->
		<script type="text/javascript" src="script/usercat/main.js"></script>
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/public.js"></script>
		<!-- 日志 
		<script src="js/split/main.js" type="text/javascript"></script>-->
		<!-- 导航 -->
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/imgs/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(../imgs/daohangbg.jpg) repeat-x; line-height:28px;}
		</style>
		
		<script type="text/javascript">
		
		/**
		 * 获取YYYY-MM格式的日期值
		 * @param
		 * @return
		 */
		function getNowDate(){		
			var now = new Date();			
			var year = now.getYear();
			var month = now.getMonth()+1;
			var day=now.getDate();
			now = year+"-"+(month<10?"0"+month:month)+"-"+(day<10?"0"+day:day);
			
			return now;
		}
		/**
		 * 页面加载时执行
		 * @param
		 * @return
		 */
		jQuery(document).ready(function(){		
		//页面表头当前位置显示
		$("#navBar1").append(genNavv());
		//设置默认时间段
		$("#tBegin").val(getNowDate());
		$("#tEnd").val(getNowDate());
		//加载表，默认不查询数据
		jQuery("#editgrid").jqGrid({
				/*执行存储过程---------------- 
				tsdpname：可以调用其他存储过程，
				注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
				ds：对应applicationContent.xml里配置的数据源 
				*/
				//url:'mainServlet.html?'+urlstr+params,
				datatype: 'xml', 
				colNames:['用户名','操作员','停用日期','套餐名称','区域'], 
				colModel:[
							{name:'username',index:'username'},
							{name:'suserid',index:'suserid'},
							{name:'createdate',index:'createdate'},
							{name:'feename',index:'feename'},
							{name:'area',index:'area'}
						], 
				       	rowNum:15, //默认分页行数
				       	rowList:[10,20,30,50,100], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'acctstoptime', //默认排序字段
				       	viewrecords: true,
				       	sortorder: 'asc',//默认排序方式 
				       	caption:'用户历史套餐信息', 
				       	height:240, //高
				        width:document.documentElement.clientWidth-58,
				       	loadComplete:function(){
							$("#editgrid").setSelection('0',true);
							$("#editgrid").focus();		
						}
				}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					);
		
		});
		/**
		 * 验证输入的时间的格式
		 * @param
		 * @return
		 */
		function vlidateTime()
		{
			if($("#tBegin").val()=="")
			{			
				alert("请输入起始时间，系统默认为当前时间！");
				$("#tBegin").val(getNowDate());
				return false;
			}
			else if($("#tEnd").val()=="")
			{
				alert("请输入结束时间，系统默认为当前时间！");
				$("#tEnd").val(getNowDate());
				return false;
			}
			if($("#tBegin").val()>$("#tEnd").val())
			{
				alert("开始日期不能晚于结束日期！");
				return false;
			}
		}
		/**
		 * 加载数据
		 * @param
		 * @return
		 */
		function loadDataInfo(){
			var zid=$("#zid").val();
			var tempvalue=$("#kdSearchBox").val();
			//判断时间是否输入
			if(vlidateTime()==false){
				return;
			}
			//获得参数，必须调用该方法。。
			var params="";
			var tempsql="";
			var tempsqlPage="";
			params = fuheQbuildParams();			
			/////////
			var tempSearch=$("#kdSearchWay").val();
			if(tempvalue!=""){				
				if(tempSearch=="0"){			 
					if(params=='&fusearchsql='){
						params+="r.username='"+tsd.encodeURIComponent(tempvalue)+"'";
					}
				}
				if(tempSearch=="1")	{
					if(params=='&fusearchsql='){
						params+="s.srealname='"+tsd.encodeURIComponent(tempvalue)+"'";
					}
				}	
				if(tempSearch=="2")	{
					if(params=='&fusearchsql='){
						params+="s.sdh='"+tsd.encodeURIComponent(tempvalue)+"'";
					}
				}			
			}else{
				if(params=='&fusearchsql='){
					params+="1=1";
				}			
			}
			params+="&tStart="+tsd.encodeURIComponent($("#tBegin").val());
			params+="&tOver="+tsd.encodeURIComponent($("#tEnd").val());
			//params+="&xuhao="+tsd.encodeURIComponent($("#areaCode").val());
			//if(zid==1 || zid==4){
				tempsql="dbsql_packageHistory.queryAdmin";
				tempsqlpage="dbsql_packageHistory.queryPageAdmin";
			//}else{
			//	tempsql="dbsql_packageHistory.query";
			//	tempsqlpage="dbsql_packageHistory.queryPage";
			//	params+="&xuhao="+tsd.encodeURIComponent($("#areaCode").val());
			//}
			var urlstr = tsd.buildParams({
						packgname:'service',
						clsname:'ExecuteSql',
						method:'exeSqlData',
						ds:'broadband',
						tsdcf:'mysql',
						tsdoper:'query',
						datatype:'xml',
						tsdpk:tempsql,
						tsdpkpagesql:tempsqlpage
			});
			//重新加载数据
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+params}).trigger("reloadGrid");
		}
		
			/**
			 * 获取复合查询参数
			 * @param
			 * @return
			 */
			 function fuheQbuildParams(){
			 	//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
			 	var params='';		 	
			 			 	
			 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());
			 	//如果有可能值是汉字 请使用encodeURI()函数转码
			 	params+='&fusearchsql='+fusearchsql;			 	
			 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
			 	//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				return params;
			 }	
         
		</script>
		 </head>
<style type="text/css"> 
 .style1 {
	background-color:#A9C3E8;
	padding: 4px;		
	}
</style>
  <body>   
   <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
  </form>
  			
		<!-- 用户操作导航-->
		<div id="navBar">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message
									key="gjh.houtuei" />
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
  	
		
		<!-- 用户操作标题以及放一些快捷按钮-->	
		<div>
			<span id="kdsWay" style="width: 50px">			
				查询方式
				<select id="kdSearchWay">
					<option value="0">登录账号</option>
					<option value="1">用户姓名</option>
					<option value="2">绑定电话</option>
				</select>
			</span>&nbsp;&nbsp;
			查询字段值：<input type="text" class="inputbox" id="kdSearchBox" name="kdSearchBox" /><br/>
			时间范围 :
			<input type="text" readonly="readonly" name="tBegin" id="tBegin" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
				 到
			<input type="text" readonly="readonly" name="tEnd" id="tEnd" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
	
			<button class="tsdbutton" onclick="loadDataInfo();">查询</button>
		</div>
	
    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		
			<!-- 不动的部分 -->
			<div style="display: none">
					<input type="hidden" id="imenuid" value="<%=imenuid%>" />
					<input type="hidden" id="zid" value="<%=zid%>" />
					<%
						if (!languageType.equals("en")) {
							languageType = "zh";
						}
					%>

					<input type="hidden" id="languageType" value="<%=languageType%>" />

					<input type="hidden" id="addinfo"
						value="<fmt:message key="global.add"/>" />
					<input type="hidden" id="deleteinfo"
						value="<fmt:message key="global.delete"/>" />
					<input type="hidden" id="editinfo"
						value="<fmt:message key="global.edit"/>" />
					<input type="hidden" id="queryinfo"
						value="<fmt:message key="global.query"/>" />

							<input type="hidden" id="operation"
						value="<fmt:message key="global.operation"/>" />
					<input type="hidden" id="operationtips"
						value="<fmt:message key="global.operationtips"/>" />
					<input type="hidden" id="successful"
						value="<fmt:message key="global.successful"/>" />
					<input type="hidden" id="deleteinformation"
						value="<fmt:message key="global.deleteinformation"/>" />
					<input type="hidden" id="management"
						value="<fmt:message key="ip.management"/>" />
					<input type="hidden" id="worninfo"
						value="<fmt:message key="ip.worn"/>" />
					<input type="hidden" id="worntips"
						value="<fmt:message key="ip.worntips"/>" />
					<input type="hidden" id="deletepower"
						value="<fmt:message key="global.deleteright"/>" />
					<input type="hidden" id="editpower"
						value="<fmt:message key="global.editright"/>" />
					
					<input type="hidden" id="deletefailed"
						value="<fmt:message key="ip.deletefailed"/>" />
					<input type="hidden" id="selectarea"
						value="<fmt:message key="ip.select"/>" />
					<input type="hidden" id="inputip"
						value="<fmt:message key="ip.inputip"/>" />
					<input type="hidden" id="selectarea"
						value="<fmt:message key="ip.selectarea"/>" />
					<input type="hidden" id="addmemo"
						value="<fmt:message key="ip.addmemo"/>" />
						
					
				
					<input type="hidden" id="addright"/>	
					<input type="hidden" id="addBright"/>			
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editright"/>	
					<input type="hidden" id="editBright"/>								
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />		
					<input type="hidden" id="userid" value="<%=userid %>"/>
					
					<!-- 国际化保存表字段名 -->	
					<input type="hidden" id="id" />							
					
					
						<!-- /****日志*** -->	
					<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>'/> 
				   <input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
				   <input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
				   <input type="hidden" id="areaCode" value="<%=strarea %>"	/>		  
				    <input type='hidden' id='oldh'  /> 				   	
				    <input type='hidden' id='areah'  />
				    <input type="hidden" id="addh"/>
				    <input type="hidden" id="edith"/>
				   
				 
				   		 
				   		 
				</div>	
	
  </body>
</html>