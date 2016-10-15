<%----------------------------------------
	name: RatesSet.jsp
	author: youhongyu
	version: 1.0, 2010-10-11
	description: 两套费率表启用设置
	modify: 
		2009-11-26 youhongyu 添加注释功能	
		2010-12-14 youhongyu 样式修改
		2011-01-07 chenze    修改验证
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><!-- liang --><fmt:message key="tariff.feilvqiyong" /></title>
    	
			
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
			
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		
	<script type="text/javascript">
			/**
			 * 查看当前用户的扩展权限，对spower字段进行解析
			 * @param 
			 * @return 
			 */
			function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'RatesSet.getPower',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#useridd').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				
				/****************
				*   拼接权限参数 *
				**************/
				//页面的三种前 保存启用时间 一号到二号的转化 二号到一号的转化 
				var save = '';
				var convRate1 = '';
				var convRate2 = '';
				
				
				var flag = false;
				var spower = '';
				var str = 'true';
				
				$.ajax({
						url:'mainServlet.html?'+urlstr+'&userid='+userid+'&groupid='+groupid+'&menuid='+imenuid,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
									spower += $(this).attr("spower")+'@';
							});
						}
				});
				if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
												
						for(var i = 0;i<spowerarr.length-1;i++){
							
							save += getCaption(spowerarr[i],'save','')+'|';
							
							convRate1 += getCaption(spowerarr[i],'convRate1','')+'|';
							
							convRate2 += getCaption(spowerarr[i],'convRate2','')+'|';	
						}
				}else if(spower=='all@'){
						$("#saveright").val(str);
						$("#convRate1right").val(str);
						$("#convRate2right").val(str);
						flag = true;
				}
				
				if(flag==false){
					var saves = save.split('|');
					var convRate1s = convRate1.split('|');
					var convRate2s = convRate2.split('|');
					
					for(var i = 0;i<saves.length;i++){
						if(saves[i]=='true'){
							$("#saveright").val(str);
							break;
						}
					}
					for(var i = 0;i<convRate1s.length;i++){
						if(convRate1s[i]=='true'){
							$("#convRate1right").val(str);
							break;
						}
					}
					for(var i = 0;i<convRate2s.length;i++){
						if(convRate2s[i]=='true'){
							$("#convRate2right").val(str);
							break;
						}
					}
				}
			
			}
			
	</script>

	<script type="text/javascript">		
			
			/**
			 * 页面初始化
			 * @param 
			 * @return 
			 */
			jQuery(document).ready(function () {
			
					//页面头部 用于显示当前所在位置
					$("#navBar").append(genNavv());
					/**************************************
						**通过调用存储过程获取计费菜单
						-------------------------------
					**************************************/
					//获取系统语言标识
					var languageType = $("#languageType").val();
					//获取本菜单id
					var imenuid = $('#imenuid').val();
					//获取组信息
					var groupid = $('#zid').val();
					//获取菜单并解析
					getTariffBar(languageType,imenuid,'CallType.getNavigator',groupid);
						
					//alert(/([^']'[^'])|'('')+/.test("sadff'''gh"));
					/**********************
					**   取得当前用户的权限  *
					**********************/
					getUserPower();
					/*********************************
					*  用户权限判定，初始化用户可操作权限 *
					*******************************/
					//	save convRate1 convRate2	
					
					var saveright = $("#saveright").val();
					var convRate1right = $("#convRate1right").val();
					var convRate2right = $("#convRate2right").val();
			
			
					if(saveright=="true"){
						document.getElementById("savebn").disabled=false;
					}
					if(convRate1right=="true"){
						document.getElementById("changeRate1bn").disabled=false;
					}
					if(convRate2right=="true"){
						document.getElementById("changeRate2bn").disabled=false;
					}
					
					//获取数据库中两套费率时间，通过存储过程
					 var urlstr = buildParams("RatesSet.getTsdIni","query");
					$.ajax({
							url:'mainServlet.html?'+urlstr+"&func=set1stratestarttime",
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
										var rTime = $(this).attr("Tvalues".toLowerCase());
										$("#ratetime1").val(rTime);
								});
							}
					});
					$.ajax({
							url:'mainServlet.html?'+urlstr+"&func=set2ndratestarttime",
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
										var rTime = $(this).attr("Tvalues".toLowerCase());
										$("#ratetime2").val(rTime);
								});
							}
					});	
					getdqfeelv();					
			});
			
			function getdqfeelv(){
				var ratetime1 = $("#ratetime1").val();
				var ratetime2 = $("#ratetime2").val();
				//var resstr = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=case when to_date('"+ratetime1+"','YYYY-MM-DD HH24:MI:SS')>to_date('"+ratetime2+"','YYYY-MM-DD HH24:MI:SS') then 'true' else 'false' end&tablename=dual&key=1=1");
				var resstr = fetchSingleValue("RatesSet.querytabledate",6,"&cloum=case when to_date('"+ratetime1+"','YYYY-MM-DD HH24:MI:SS')>to_date('"+ratetime2+"','YYYY-MM-DD HH24:MI:SS') then 'true' else 'false' end&tablename=dual&key=1=1");
				if(resstr==undefined||resstr==""){$("#currentRate").val("数据获取失败");}
				var v_maxdate="";		
				var v_mindate="";		
				if(resstr=="true"){
					v_maxdate=ratetime1;
					v_mindate=ratetime2;
				}else{
					v_maxdate=ratetime2;
					v_mindate=ratetime1;
				}
				var resdate = fetchSingleValue("dbsql_phone.ratesSet",6,"&v_maxdate="+v_maxdate+"&v_mindate="+v_mindate);
				if(resdate!=undefined&&resdate!=""){
					if(ratetime1==resdate){
						$("#currentRate").val($("#fl1").val());
					}else{
						$("#currentRate").val($("#fl2").val());
					}
				}else{
					$("#currentRate").val("数据获取失败");
				}
			}
		</script>
		<script type="text/javascript">			
			/**
			 * 页面上保存启用时间按钮操作，设置两套费率的启用时间
			 * @param 
			 * @return 
			 */
			function saveRates(){
						var rTime1 = $("#ratetime1").val();
						var rTime2 = $("#ratetime2").val();
						
						if($.trim(rTime1)=="")
						{
							alert("<fmt:message key='RatesSet.onetablestarttime' />");
							$("#ratetime1").select().focus();
							return false;
						}
						if($.trim(rTime2)=="")
						{
							alert("<fmt:message key='RatesSet.onetablestarttime' />");
							$("#ratetime2").select().focus();
							return false;
						}
						var bolSuccess1 = false;
						var bolSuccess2 = false;
						//调用setTsdIni存储过程设置两套费率启用时间
						var urlstr = buildParams("RatesSet.setTsdIni","exe");
						$.ajax({
							url:'mainServlet.html?'+urlstr+"&func=set1stratestarttime&value="+rTime1,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
										var operationtips = $("#operationtips").val();
										var successful = $("#successful").val();
										//alert(successful,operationtips);
										bolSuccess1 = true;
										//setTimeout($.unblockUI, 15);
									}
								}
							});
							
							$.ajax({
							url:'mainServlet.html?'+urlstr+"&func=set2ndratestarttime&value="+rTime2,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
										var operationtips = $("#operationtips").val();
										var successful = $("#successful").val();
										//alert(successful,operationtips);
										bolSuccess2 = true;
										//setTimeout($.unblockUI, 15);
									}
								}
							});
							
							if(bolSuccess1 && bolSuccess2)
							{
								alert("<fmt:message key='RatesSet.savesucess' />");
								getdqfeelv();
							}
							
							//写入日志操作
							var str ="<fmt:message key='ratesset.saveT'/>。"+"<fmt:message key='ratesset.1stT'/>"+"func=set1stratestarttime;value="+rTime1+"<fmt:message key='ratesset.2ndT'/>"+";func=set2ndratestarttime;value="+rTime2;
							
							writeLogInfo("","start time",tsd.encodeURIComponent(str));	
													
			}
			
				/**
				 * 页面上保存一号表 -> 二号表、二号表 -> 一号表按钮操作
				 	用于进行两套费率转化。
				 * @param key费率转化表识，1：一号表 -> 二号表，2：二号表 -> 一号表
				 * @return 方法返回描述
				 */
				function changeRate(key){
					//数据库访问参数拼接
					var info = ["<fmt:message key='RatesSet.tableonetotabletwo' />","<fmt:message key='RatesSet.tabletwototableone' />"];
					if(confirm("<fmt:message key='RatesSet.willyou' />" + info[key-1] + "?"))
					{
						//var urlstr = buildParams("RatesSet.setTsdIni","exe");
						var urlstr=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mssql',//指向配置文件名称
												  tsdoper:'exe',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'RatesSet.conv'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												});
						if(key==1){
							$.ajax({
									url:'mainServlet.html?'+urlstr+"&func=1",
									cache:false,//如果值变化可能性比较大 一定要将缓存设成false
									timeout: 1000,
									async: false ,//同步方式
										success:function(msg){
											if(msg=="true"){
												var operationtips = $("#operationtips").val();
												var successful = $("#successful").val();
												alert(successful,operationtips);
												setTimeout($.unblockUI, 15);
												
												//写入日志操作
												var str ="<fmt:message key='ratesset.conv1st'/>。<fmt:message key='global.conditions'/>:Copy_Feilu 1";
												//var strconv1st = "";
												writeLogInfo("","change",tsd.encodeURIComponent(str));	
											}
										}
							});
						}
						else if(key==2){
							$.ajax({
									url:'mainServlet.html?'+urlstr+"&func=2",
									cache:false,//如果值变化可能性比较大 一定要将缓存设成false
									timeout: 1000,
									async: false ,//同步方式
										success:function(msg){
												if(msg=="true"){
												var operationtips = $("#operationtips").val();
												var successful = $("#successful").val();
												alert(successful,operationtips);
												setTimeout($.unblockUI, 15);
												
												//写入日志操作
												var str ="<fmt:message key='ratesset.conv2nd'/>。<fmt:message key='oper.condition'/>:Copy_Feilu 2";
												
												writeLogInfo("","change",tsd.encodeURIComponent(str));
											}
										}
							});
						}
					}
				}
				/**
				 * 存储过程数据访问参数拼接
				 	@oper 操作类型 modify|save
				 * @param key ： 存储过程的映射名称
				 * @param key1 ： 执行方式
				 * @return 
				 */
				function buildParams(key,key1){
					var urlstr=tsd.buildParams({  
										packgname:'service',
							 			 clsname:'Procedure',
										method:'exequery',
							 			ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 			tsdpname:key,//存储过程的映射名称
							 			tsdExeType:key1,
							 			datatype:'xmlattr'
						 				});
					return urlstr;
				}
		</script>
  </head>
<style type="text/css"> 
 .style1 {
	background-color:#A9C3E8;
	padding: 4px;		
	}
</style>
<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
</style> 
  <body>   
  <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
  </form>
  		<!-- 用户操作导航-->
		<div id="navBar1">
			<table width="100%" height="26px">
			<tr>
				<td width="80%" valign="middle">
			  <div id="navBar" style="float:left">
			  <img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
			  <fmt:message key="global.location" />
					:
			  </div>
			  </td>
			  <td width="20%" align="right" valign="top">
			  <div id="d2back"><a href="javascript:void(0);" onclick="parent.history.back(); return false;"><fmt:message key="gjh.houtuei" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			  </td>
			  </tr>
		  </table>
		</div>
		
		
		<!-- 资费设置导航条-->
		<div id="tariffBar" style="font-size: 14px; text-align: left;"></div>	
		
		<!-- 用户操作标题以及放一些快捷按钮-->
		<div id="buttons">			
			<button type="button" id="savebn" onclick="saveRates();" disabled="disabled">
				<fmt:message key='ratesset.saveT'/>	<!-- 保存启用时间 -->
			</button>									 
			<button type="button" id="changeRate1bn" onclick="changeRate(1)" disabled="disabled">
				<fmt:message key='ratesset.conv1st'/><!-- 一号表 -> 二号表 -->
			</button>
			 <button type="button" id="changeRate2bn" onclick="changeRate(2)" disabled="disabled">
				<fmt:message key='ratesset.conv2nd'/><!-- 二号表 -> 一号表  -->
			</button>
		</div>
		
  		<div>  			
			<div id="ALLMenu" style="margin-center: 50px;width: 100%;height: 380px;float: left;margin-top: 10px">
	    			<div id="input-Unit" align="left" >
	    					<div style="float: left;width: 330px;"><label for="zhmenuname" style="width: 160px;font-size: 14;"><fmt:message key='ratesset.1stT'/></label><!--  一号费率表启用时间：-->
								<input type="text" name="ratetime1"  id="ratetime1" style="width: 150px;height: 25px;line-height:25px;" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
								<input type="hidden" id="fl1" value="一号费率"/>
							</div>
							<div style="float: left;width: 330px;">
								<label for="enmenuname" style="width: 160px;font-size: 14;"><fmt:message key='ratesset.2ndT'/></label><!--  二号费率表启用时间： -->
								<input type="text" name="ratetime2"  id="ratetime2"  style="width: 150px;height: 25px;line-height:25px;"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
								<input type="hidden" id="fl2" value="二号费率"/>
							</div>
							<br/><br/><br/><br/>
							<div style="float: left;width: 330px;"><label for="tomenuname" style="width: 160px;font-size: 14;"><fmt:message key='ratesset.currentRate'/>：</label><!--  当前使用费率：-->
								<input type="text" name="currentRate"  id="currentRate" style="width: 150px;height: 25px;line-height:25px;" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" disabled=true/>
							</div>				 
					</div>
		    </div>
   		 </div>
	
	<!-- typtDemoModify  表单输入区域  -->
	<div id="inputs">
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
						
					
					<input type="hidden" id="worninfo"
						value="<fmt:message key="zhji.zjjxonly"/>" />
					<input type="hidden" id="worntips"
						value="<fmt:message key="powergroup.worntips"/>" />
						
					<input type="hidden" id="deletepower"
						value="<fmt:message key="global.deleteright"/>" />
					<input type="hidden" id="editpower"
						value="<fmt:message key="global.editright"/>" />
					
					<input type="hidden" id="zhjititle"
						value="<fmt:message key="tariff.zhji" />" />
					
					<input type="hidden" id="saveright"/>					
					<input type="hidden" id="convRate1right"/>
					<input type="hidden" id="convRate2right"/>
							
					<!-- 用于写入日志 -->
				   <input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request) %>"/> 
				   <input type="hidden" id="userloginid" value="<%=session.getAttribute("userid") %>"/> 
				   <input type="hidden" id="thislogtime" value="<%=Log.getThisTime() %>" />
				   <!-- 修改时保存原来数据的隐藏域 --> 	
					<input type="hidden" id="logoldstr" />	
					<input type="hidden" id="useridd" value="<%=userid %>"/>		

	</div>
  </body>
</html>
