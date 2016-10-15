<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/telCancel.jsp
    Function:   电话业务撤销
    Author:     wenxuming
    Date:       2010-11-09
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；    
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	SimpleDateFormat formatto = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String nowTime = format.format(now);
	String nowTimeto = formatto.format(now);
%>
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
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>电话业务撤销</title>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>	
		<!-- 弹出面板需要导入js文件 -->
		<script src="js/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>	
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
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->	
		<style type="text/css">
		#input-Unit .title{text-align:left;}
		.inputbox{{margin-left:20px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
		#tdiv td{line-height:26px;}
		</style>
		
		<script type="text/javascript">
		jQuery(document).ready(function()
		{	    
		    $("#navBar").append(genNavv());
		    gobackInNavbar("navBar");
		    
		    thisDetailField();
		    
		    //thisInfo(16,'');
		    $("#tdiv td:even").css("padding-right","8px");
		    
		    $("#kdSearchBox").focus();
			$("#kdSearchBox").select();
			
			$("#kdSearchBox").keydown(function(event){
				if(event.keyCode==13)
				{
					$("#kdSearchByUserName").click();
				}
			});			
			$("#kdSearchByUserName").click(function(){
				searchJob();
			});
		}); 
				
		/*********
		* 查询用户工单
		* @param;
		* @return;
		**********/
		function searchJob()
		{
			var username = $.trim($("#kdSearchBox").val());
			var userid = $("#userid").val();			
			var area = $("#area").val();			
			var power = $("#Interregional").val();			
			var params = "";
			params += "&Dh=";
			params += tsd.encodeURIComponent(username);
			params += "&Hth=";
			params += tsd.encodeURIComponent(username);
			params += "&SkrID=";
			params += tsd.encodeURIComponent(userid);
			params += "&area=";
			params += tsd.encodeURIComponent(area);
			params += "&Func=";
			params += tsd.encodeURIComponent("GetTeljob");
			params += "&power=";
			params += tsd.encodeURIComponent(power);			
			var res = fetchMultiPValue("PhoneService.Cancel",6,params);
			params="";
			if(res[0]==undefined || res[0][0]==undefined)
			{
				//没取到数据
				//to-do
				//alert("用户" + username + "没有可撤销的业务");			
				alert("<fmt:message key="phone.getinternet0308" />" + username + "<fmt:message key="phone.getinternet0309" />");
				clearPage();
				$("#kdSearchBox").focus();
				$("#kdSearchBox").select();
			}
			else if(res[0][0]==-1 || res[0][0]=="")
			{
				alert(res[0][1]);
				clearPage();
				$("#kdSearchBox").focus();
				$("#kdSearchBox").select();
			}
			else
			{	
				params += "&Func=";
				params += tsd.encodeURIComponent("GetFee");
				params += "&IDD=";
				params += tsd.encodeURIComponent(res[0][0]);					
				var resstr = fetchMultiPValue("PhoneService.Cancel",6,params);
				if(resstr[0][0]=="FAILED"){
					alert(resstr[0][1]);
					return;
				}
				if(resstr[0][1]!="0"){
					$("#tfeevalue").empty();
					var restfee = fetchMultiArrayValue("dbsql_phone.querybusinessjebid",6,"&jobid="+res[0][0]);			
					if(restfee[0]==undefined || restfee[0][0]==undefined||restfee[0][0]==""){
						restfee.length=0;
						$("#tfeevalue").empty();
						$("#sumfee").empty();
						$("#tftable").hide();
						$("#tfdiv").hide();
					}else{
						$("#tftable").show();
					    $("#tfdiv").show();
					}
					var str ="";
					for(var i=0;i<restfee.length;i++){
						str +="<tr><td valign='bottom' style='width:200px;'>";
					    str +="<span style='color:red;font-size:15px;'>"+restfee[i][0]+"</span></td>";
					    str +="<td valign='bottom' style='width:200px;'>";
					    str +="<span style='color:red;font-size:15px;'>"+restfee[i][1]+"￥</span></td></tr>";
					    str +="</tr><tr><td colspan=3><hr style='border: 1px dotted #CCCCCC;' /></td></tr><tr>";
					}
					$("#tfeevalue").html(str);
					$("#sumfee").text(resstr[0][1]);
				}else{
					$("#tfeevalue").empty();
					$("#sumfee").empty();
					$("#tftable").hide();
					$("#tfdiv").hide();
				}
				//成功，返回工单号
				thisInfo(res[0][0]);
				$("#kdcx").removeAttr("disabled");
				//缓存用户账号和工单号
				$("#kdSearchBox").data("username",$.trim($("#kdSearchBox").val()));
				$("#kdSearchBox").data("jobid",res[0][0]);
			}
		}
		
		/*********
		* 清空页面
		* @param;
		* @return;
		**********/
		function clearPage()
		{
			//清除现在工单流程信息
			$("#tdiv tr.dynamicadd").remove();			
			$(".tdstyle div").empty();			
			$("#addBzText").val("");			
			$("#kdSearchBox").removeData("username");
			$("#kdSearchBox").removeData("jobid");			
			$("#kdSearchBox").removeData("jobtype");			
			$("#addBzText").val("");			
			$("#kdcx").attr("disabled","disabled");
		}
		
		/*********
		* 重置
		* @param;
		* @return;
		**********/
		function resetPage()
		{
			clearPage();
			$("#kdSearchBox").val("");
			$("#kdSearchBox").select();
			$("#kdSearchBox").focus();
			$("#tfeevalue").empty();
			$("#sumfee").empty();
			$("#tftable").hide();
			$("#tfdiv").hide();
		}
		
		/*********
		* 点击保存拼接参数调用过程执行撤单操作
		* @param;
		* @return;
		**********/
		function cxJob()
		{
			var username = $("#kdSearchBox").data("username");
			var userid = $("#userid").val();		
			var area = $("#area").val();		
			var power = $("#Interregional").val();
			var jobid = $("#kdSearchBox").data("jobid");
			var depart = $("#department").val();					
			var jobtype=$("#kdSearchBox").data("jobtype");									
			var description = $("#addBzText").val();			
			if($.trim(description)=="")
			{
				//alert("必须填写业务撤销备注信息");
				alert("<fmt:message key="phone.getinternet0310" />");
				$("#addBzText").focus();
				$("#addBzText").select();
				return false;
			}
			else if(description.length>100)
			{
				//alert("备注长度过长，最大允许100个字符");
				alert("<fmt:message key="phone.getinternet0311" />");
				$("#addBzText").focus();
				$("#addBzText").select();
				return false;
			}			
			var params = "";
			params += "&Dh=";
			params += tsd.encodeURIComponent($("#thisUserNamevalue").text());
			params += "&Hth=";
			params += tsd.encodeURIComponent($("#thisPayModevalue").text());
			params += "&SkrID=";
			params += tsd.encodeURIComponent(userid);
			params += "&area=";
			params += tsd.encodeURIComponent(area);
			params += "&Func=";
			params += tsd.encodeURIComponent("save");
			params += "&power=";
			params += tsd.encodeURIComponent(power);
			params += "&IDD=";
			params += tsd.encodeURIComponent(jobid);
			params += "&depart=";
			params += tsd.encodeURIComponent(depart);	
			params += "&ywlx=";
			params += tsd.encodeURIComponent($("#thisJobTypevalue").text());
			tsd.QualifiedVal=true;
			params += "&zwbz=";
			params += tsd.encodeURIComponent(description);
			if(tsd.Qualified()==false){$("#addBzText").focus();$("#addBzText").select();return false;}			
			var loginfo = "<fmt:message key="phone.getinternet0428" />：";//电话业务撤销(业务类型
			loginfo += $("#thisJobTypevalue").text();
			loginfo += ")(";
			loginfo += "<fmt:message key="phone.getinternet0103" />:";
			loginfo += username;
			loginfo += ")(";
			loginfo += "<fmt:message key="phone.getinternet0429" />:";//被撤销业务工单号
			loginfo += jobid;
			loginfo += ")(<fmt:message key="phone.getinternet0381" />:";
			loginfo += area;
			loginfo += ")(<fmt:message key="phone.getinternet0396" />:";
			loginfo += userid+")";
			loginfo += ")(<fmt:message key="phone.getinternet0430" />:";//退费金额
			loginfo += $("#thisJobyjje").html()+")";
			loginfo = tsd.encodeURIComponent(loginfo);
			params+="&ywbz="+loginfo;			
			//if(confirm("你确定要撤销业务么？"))
			if(confirm("<fmt:message key="phone.getinternet0312" />"))
			{
				var res = fetchMultiPValue("PhoneService.Cancel",6,params);							
				if(res[0]==undefined || res[0][0]==undefined || res[0][0]=='-1')
				{
					//alert("撤销业务失败");
					alert("<fmt:message key="phone.getinternet0313" />");
				}
				else
				{
					if(res[0][0]=='FAILED'){
						alert(res[0][1]);
						return false;
					}
					//从tsd_ini表中查询是否打印退费票据参数Y为打印，N为不答应
					var result = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('phonebusiness')+"&tident="+tsd.encodeURIComponent('tfNotes'));
					if(result==undefined || result==""){			
						result='';
					}
					if(result=="Y"){
						printThisReport1($("#imenuid").val(),'tf',"&jobid="+jobid,$("#userid").val(),$("#zid").val(),$("#area").val(),'1');
					}
					writeLogInfo("","modify",loginfo);
					resetPage();
					$("#thismemovalue").empty();
					$("#kdSearchBox").val("");
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
				}
			}			
		}		

		/*********
		* 页面设置权限
		* @param;
		* @return;
		**********/
		function setUserRight()
		{
			var allRi = fetchMultiPValue("PackageSummary.getPower",6,"&userid="+$("#userid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
			if(typeof allRi == 'undefined' || allRi.length == 0)
			{
				//alert("取权限失败");
				$("#Interregional").val("0");		
				return false;
			}
			if(allRi[0][0]=="all")
			{
				$("#Interregional").val('10');	
				return true;
			}
			var Interregional = '0';			
			for(var i = 0;i<allRi.length;i++){
				if(getCaption(allRi[i][0],'RightsGroup','')=="10")
				{
					Interregional = '10';
					break;
				}	
				else if(getCaption(allRi[i][0],'RightsGroup','')=="3" && Interregional!='10')
				{
					Interregional = '3';
					break;
				}	
				else
				{
					Interregional = '0';
				}			
			}
			$("#Interregional").val(Interregional);			
		}
		
		function getywlx(ywlx){
			var res = fetchSingleValue("dbsql_phone.queryywsl_code",6,"&ywlx="+ywlx);
			return res;
		}
		
		/*********
		* 根据工单ID查询工单信息
		* @param：jobid工单ID;
		* @return;
		**********/
		function thisInfo(jobid,mqbm){
            	///设置命令参数
						 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'teljob.querydetail' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&jobid='+jobid+'&tsdtemp='+Math.random(),
							/*
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式*/
							cache:false,					
							success:function(xml){
								$(xml).find('row').each(function(){
									var tmp_id = $(this).attr('id');
									if(tmp_id!=undefined){
										$("#thisJobIDvalue").html(tmp_id);
										
										var tmp_yjje = $(this).attr('yjje');
										if(tmp_yjje==null||tmp_yjje==undefined){
											tmp_yjje = '';										
										}
										$("#thisJobyjje").html(tmp_yjje+"￥");
																		
										
										var tmp_Sgnr = $(this).attr('sgnr');
										if(tmp_Sgnr==null||tmp_Sgnr==undefined){
											tmp_Sgnr = '';
										}
										$("#thisJobTypevalue").html(tmp_Sgnr);
										$("#thisJobTypevaluezh").html(getywlx(tmp_Sgnr));
										//缓存业务类型
										$("#kdSearchBox").data("jobtype",tmp_Sgnr);
										
										var tmp_Mqbm = $(this).attr('mqbm');
										if(tmp_Mqbm=='null'||tmp_Mqbm==undefined){
											tmp_Mqbm = '';
										}
										$("#thismqbmvalue").html(tmp_Mqbm);
										
										var tmp_IfCancel = $(this).attr('ifcancel');
										if(tmp_IfCancel=='null'||tmp_IfCancel==undefined){
											tmp_IfCancel = '';
										}
										if(tmp_IfCancel=='0'){
											//var tmp_IfCancelzh='正常';
											var tmp_IfCancelzh="<fmt:message key="phone.getinternet0431" />";								
										}else if(tmp_IfCancel=='1'){
											//var tmp_IfCancelzh='撤销';
											var tmp_IfCancelzh="<fmt:message key="phone.getinternet0432" />";
										}
										$("#thisIfCancelvaluezh").html(tmp_IfCancelzh);										
										$("#thisIfCancelvalue").html(tmp_IfCancel);
										var tmp_Ydh = $(this).attr('ydh');
										if(tmp_Ydh=='null'||tmp_Ydh==undefined){
											tmp_Ydh = '';
										}
										$("#thisjobstatusvalue").html(tmp_Ydh);
										var tmp_Xdh = $(this).attr('xdh');
										if(tmp_Xdh=='null'||tmp_Xdh==undefined){
											tmp_Xdh = '';
										}
										$("#thisUserNamevalue").html(tmp_Xdh);
										var tmp_Nxm = $(this).attr('nxm');
										if(tmp_Nxm=='null'||tmp_Nxm==undefined){
											tmp_Nxm = '';
										}
										$("#thisoldsRealNamevalue").html(tmp_Nxm);
										var tmp_xm = $(this).attr('xm');
										if(tmp_xm=='null'||tmp_xm==undefined){
											tmp_xm = '';
										}
										$("#thissRealNamevalue").html(tmp_xm);
										
										var sgrq = $(this).attr('sgrq');
										if(sgrq=='null'||sgrq==undefined){
											sgrq = '';
										}else{
											sgrq = sgrq.substring(0,19);
										}
										$("#thisJobRecTimevalue").html(sgrq);
										var theuserid = $(this).attr('jlry');
										if(theuserid!=''&&theuserid!=undefined){
											theuserid = getTrueValue('tsdBilling','sys_user','username','userid',theuserid,'1','1');
										}else{
											theuserid = '';
										}
										$("#thisUserIDvalue").html(theuserid);
										var tmp_Area = $(this).attr('area');
										if(tmp_Area=='null'||tmp_Area==undefined){
											tmp_Area = '';
										}
										$("#thisAreavalue").html(tmp_Area);
										var tmp_Slbm = $(this).attr('slbm');
										if(tmp_Slbm=='null'||tmp_Slbm==undefined){
											tmp_Slbm = '';
										}
										$("#thisDepartvalue").html(tmp_Slbm);
										var tmp_Dhlx = $(this).attr('dhlx');
										if(tmp_Dhlx=='null'||tmp_Dhlx==undefined){
											tmp_Dhlx = '';
										}
										$("#thisValuevalue").html(tmp_Dhlx);
										var tmp_IDD = $(this).attr('idd');
										if(tmp_IDD=='null'||tmp_IDD==undefined){
											tmp_IDD = '';
										}
										$("#thisvlanidvalue").html(tmp_IDD);
										var ispay = $(this).attr('ispay');
										if(ispay=='cash'){
											//ispay = '现金';
											ispay = "<fmt:message key="phone.getinternet0433" />";
										}else if(ispay=='transfer'){
											//ispay = '转账';
											ispay = "<fmt:message key="phone.getinternet0434" />";
										}else{
											ispay = '';
										}
										$("#thisPayTypevalue").html(ispay);
										var tmp_Dhgn = $(this).attr('dhgn');
										if(tmp_Dhgn=='null'||tmp_Dhgn==undefined){
											tmp_Dhgn = '';
										}
										$("#thisiFeeTypevalue").html(tmp_Dhgn);
										var tmp_BeginYwArea = $(this).attr('beginywarea');
										if(tmp_BeginYwArea=='null'||tmp_BeginYwArea==undefined){
											tmp_BeginYwArea = '';
										}
										$("#thissDhvalue").html(tmp_BeginYwArea);
										//$("#thisValue").html($(this).attr('Dhgn'));
										var tmp_Bm1 = $(this).attr('bm1');
										if(tmp_Bm1=='null'||tmp_Bm1==undefined){
											tmp_Bm1 = '';
										}
										var tmp_Bm2 = $(this).attr('bm2');
										if(tmp_Bm2=='null'||tmp_Bm2==undefined){
											tmp_Bm2 = '';
										}
										var tmp_Bm3 = $(this).attr('bm3');
										if(tmp_Bm3=='null'||tmp_Bm3==undefined){
											tmp_Bm3 = '';
										}
										var tmp_Bm4 = $(this).attr('bm4');
										if(tmp_Bm4=='null'||tmp_Bm4==undefined){
											tmp_Bm4 = '';
										}
										$("#thissRegDatevalue").html(tmp_Bm1);
						            	$("#thisfeedendtimevalue").html(tmp_Bm2);
										$("#thisiFeeTypeTimevalue").html(tmp_Bm3);
										$("#thisoldsAddressvalue").html(tmp_Bm4);
										var tmp_Ydz = $(this).attr('ydz');
										if(tmp_Ydz=='null'||tmp_Ydz==undefined){
											tmp_Ydz = '';
										}
										$("#thissAddressvalue").html(tmp_Ydz);
										var tmp_Xdz = $(this).attr('xdz');
										if(tmp_Xdz=='null'||tmp_Xdz==undefined){
											tmp_Xdz = '';
										}
						            	$("#thisiStatusvalue").html(tmp_Xdz);
						            	var tmp_Wgbm = $(this).attr('wgbm');
										if(tmp_Wgbm=='null'||tmp_Wgbm==undefined){
											tmp_Wgbm = '';
										}
										$("#thissDh1value").html(tmp_Wgbm);
										var tmp_Yhxz = $(this).attr('yhxz');
										if(tmp_Yhxz=='null'||tmp_Yhxz==undefined){
											tmp_Yhxz = '';
										}
										$("#thissDh2value").html(tmp_Yhxz);
										var tmp_Ywarea = $(this).attr('ywarea');
										if(tmp_Ywarea=='null'||tmp_Ywarea==undefined){
											tmp_Ywarea = '';
										}
						            	$("#thisiSimultaneousvalue").html(tmp_Ywarea);
						            	var tmp_CardID = $(this).attr('cardid');
										if(tmp_CardID=='null'||tmp_CardID==undefined){
											tmp_CardID = '';
										}
										$("#thisUserName1value").html(tmp_CardID);
										var tmp_IsComplete = $(this).attr('iscomplete');
										if(tmp_IsComplete=='null'||tmp_IsComplete==undefined){
											tmp_IsComplete = '';
										}
										if(tmp_IsComplete=='N'){
											//var tmp_IsCompletezh='未完工';
											var tmp_IsCompletezh="<fmt:message key="phone.getinternet0435" />";
										}else if(tmp_IsComplete=='Y'){
											//var tmp_IsCompletezh='已完工';
											var tmp_IsCompletezh="<fmt:message key="phone.getinternet0436" />";
										}else{
											var tmp_IsCompletezh='';
										}
										$("#thisidtypevaluezh").html(tmp_IsCompletezh);
										$("#thisidtypevalue").html(tmp_IsComplete);
										
										var thejobstatus = $(this).attr('jobstatus');
										if(thejobstatus!=''&&thejobstatus!=undefined){
											thejobstatus = getTrueValue('tsdBilling','tsd_Ini','TIDent','TValues',thejobstatus,'TSection','canacceptjobtype');
										}										
										if(thejobstatus==undefined||thejobstatus=="undefined"){
											thejobstatus = '';
										}
						            	$("#thisidcardvalue").html(thejobstatus);
										var tmp_Lsh = $(this).attr('lsh');
										if(tmp_Lsh=='null'||tmp_Lsh==undefined){
											tmp_Lsh = '';
										}
										$("#thisdevnovalue").html(tmp_Lsh);
										var tmp_Lxdh = $(this).attr('lxdh');
										if(tmp_Lxdh=='null'||tmp_Lxdh==undefined){
											tmp_Lxdh = '';
										}
										$("#thisoldspeedvalue").html(tmp_Lxdh);
						            	var tmp_LinkMan = $(this).attr('linkman');
										if(tmp_LinkMan=='null'||tmp_LinkMan==undefined){
											tmp_LinkMan = '';
										}
										
						            	$("#thisspeedvalue").html(tmp_LinkMan);
						            	var tmp_value1 = $(this).attr('value1');
										if(tmp_value1=='null'||tmp_value1==undefined){
											tmp_value1 = '';
										}
										$("#thismobilevalue").html(tmp_value1);
										var tmp_value2 = $(this).attr('value2');
										if(tmp_value2== 'null'||tmp_value2==undefined){
											tmp_value2 = '';
										}
										var tmp_value3 = $(this).attr('value3');
										if(tmp_value3=='null'||tmp_value3==undefined){
											tmp_value3 = '';
										}
										var tmp_value4 = $(this).attr('value4');
										if(tmp_value4=='null'||tmp_value4==undefined){
											tmp_value4 = '';
										}
										var tmp_value5 = $(this).attr('value5');
										if(tmp_value5=='null'||tmp_value5==undefined){
											tmp_value5 = '';
										}
										var tmp_value6 = $(this).attr('value6');
										if(tmp_value6=='null'||tmp_value6==undefined){
											tmp_value6 = '';
										}
										var tmp_value7 = $(this).attr('value7');
										if(tmp_value7=='null'||tmp_value7==undefined){
											tmp_value7 = '';
										}
										var tmp_value8 = $(this).attr('value8');
										if(tmp_value8=='null'||tmp_value8==undefined){
											tmp_value8 = '';
										}
										var tmp_value9 = $(this).attr('value9');
										if(tmp_value9=='null'||tmp_value1==undefined){
											tmp_value9 = '';
										}
										
										$("#thislinkphonevalue").html(tmp_value2);
										
						            	$("#thislinkmanvalue").html(tmp_value3);
										$("#thisFeevalue").html(tmp_value4);
										
										$("#thisFeeNamevalue").html(tmp_value5);
						            	$("#thissBmvalue").html(tmp_value6);
										$("#thissBm2value").html(tmp_value7);
										$("#thissBm3value").html(tmp_value8);
						            	$("#thissBm4value").html(tmp_value9);
						            	var tmp_Bz = $(this).attr('bz');
										if(tmp_Bz=='null'||tmp_Bz==undefined){
											tmp_Bz = '';
										}
										$("#thisifurgentvalue").html(tmp_Bz);
										var tmp_Zwbz = $(this).attr('zwbz');
										if(tmp_Zwbz=='null'||tmp_Zwbz==undefined||tmp_Zwbz=="undefined"){
											tmp_Zwbz = '';
										}
										$("#thismemovalue").html(tmp_Zwbz);
										var tmp_YHth = $(this).attr('hth');
										if(tmp_YHth=='null'||tmp_YHth==undefined){
											tmp_YHth = '';
										}
										$("#thisPayModevalue").html(tmp_YHth);
										var tmp_Pgrq = $(this).attr('pgrq');
										if(tmp_Pgrq=='null'||tmp_Pgrq==undefined){
											tmp_Pgrq = '';
										}else{
											tmp_Pgrq = tmp_Pgrq.substring(0,19);
										}
										$("#thisisPayvalue").html(tmp_Pgrq);
										var tmp_Hth = $(this).attr('value15');
										if(tmp_Hth=='null'||tmp_Hth==undefined){
											tmp_Hth = '';
										}
										$("#thisHthvalue").html(tmp_Hth);
										var tmp_JobState = $(this).attr('djhwcsj');
										if(tmp_JobState=='null'||tmp_JobState==undefined){
											tmp_JobState = '';
										}else{
											tmp_JobState = tmp_JobState.substring(0,19);
										}
										$("#thisjobstatevalue").html(tmp_JobState);
									}
								});
							}
						});
						
				//autoBlockForm('detailInfo',20,'detailinfoclose',"#ffffff",false);//弹出查询面板		
            }
                        
            /*********
			* 获取选择值的真实值
			* @param;
			* @return;
			**********/
           function getTrueValue(ds,tablename,code,thelimit,limitvalue,theif,theend){
           	var realvalue = '';
           	 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:ds,//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mysql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'dbsql_phone.querytruevaluezh' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 					});
			if(limitvalue==''||limitvalue==null){
				thelimit = 1;
				limitvalue = 1;
			}			
			$.ajax({
						url:'mainServlet.html?'+urlstr+'&tablename='+tablename+'&code='+code+'&thelimit='+thelimit+'&theif='+theif+'&theend='+theend+'&limitvalue='+limitvalue+'&tsdtemp='+Math.random(),
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
								realvalue += $(this).attr("code");//是否已接收
							});
						}
					});
			return realvalue;
       		}

			/*********
			* 初始化显示详细信息的字段
			* @param;
			* @return;
			**********/
            function thisDetailField(){
            	var column  = '';
				var thisdata = loadData('TelJob','<%=languageType %>',1);
				column = thisdata.FieldName.join(',');
				//$("#thisJobID").html(thisdata.getFieldAliasByFieldName('ID'));
				//$("#thisJobID").html('工单编号');
				$("#thisJobID").html("<fmt:message key="phone.getinternet0437" />");				
				$("#thisJobType").html(thisdata.getFieldAliasByFieldName('Sgnr'));
				$("#thismqbm").html(thisdata.getFieldAliasByFieldName('Mqbm'));
				$("#thisIfCancel").html(thisdata.getFieldAliasByFieldName('IfCancel'));
				$("#thisjobstatus").html(thisdata.getFieldAliasByFieldName('Ydh'));
				$("#thisUserName").html(thisdata.getFieldAliasByFieldName('Xdh'));
				$("#thisoldsRealName").html(thisdata.getFieldAliasByFieldName('Nxm'));
				$("#thissRealName").html(thisdata.getFieldAliasByFieldName('Xm'));
				$("#thisJobRecTime").html(thisdata.getFieldAliasByFieldName('Sgrq'));				
				$("#thisUserID").html(thisdata.getFieldAliasByFieldName('Jlry'));
				$("#thisArea").html(thisdata.getFieldAliasByFieldName('Area'));
				$("#thisDepart").html(thisdata.getFieldAliasByFieldName('Slbm'));
				$("#thisValue").html(thisdata.getFieldAliasByFieldName('Dhlx'));
				$("#thisvlanid").html(thisdata.getFieldAliasByFieldName('IDD'));
				$("#thisPayType").html(thisdata.getFieldAliasByFieldName('IsPay'));
				$("#thisiFeeType").html(thisdata.getFieldAliasByFieldName('Dhgn'));
				$("#thissDh").html(thisdata.getFieldAliasByFieldName('BeginYwArea'));
				//$("#thisValue").html(thisdata.getFieldAliasByFieldName('Dhgn'));
				$("#thissRegDate").html(thisdata.getFieldAliasByFieldName('Bm1'));				
            	$("#thisfeedendtime").html(thisdata.getFieldAliasByFieldName('Bm2'));
				$("#thisiFeeTypeTime").html(thisdata.getFieldAliasByFieldName('Bm3'));
				$("#thisoldsAddress").html(thisdata.getFieldAliasByFieldName('Bm4'));
				$("#thissAddress").html(thisdata.getFieldAliasByFieldName('Ydz'));
            	$("#thisiStatus").html(thisdata.getFieldAliasByFieldName('Xdz'));
				$("#thissDh1").html(thisdata.getFieldAliasByFieldName('Wgbm'));				
				$("#thissDh2").html(thisdata.getFieldAliasByFieldName('Yhxz'));
            	$("#thisiSimultaneous").html(thisdata.getFieldAliasByFieldName('Ywarea'));
				$("#thisUserName1").html(thisdata.getFieldAliasByFieldName('CardID'));
				$("#thisidtype").html(thisdata.getFieldAliasByFieldName('IsComplete'));
            	$("#thisidcard").html(thisdata.getFieldAliasByFieldName('jobstatus'));								
				$("#thisoldspeed").html(thisdata.getFieldAliasByFieldName('Lxdh'));
            	$("#thisspeed").html(thisdata.getFieldAliasByFieldName('LinkMan'));            	
				$("#thismobile").html(thisdata.getFieldAliasByFieldName('value1'));
				$("#thislinkphone").html(thisdata.getFieldAliasByFieldName('value2'));				
            	$("#thislinkman").html(thisdata.getFieldAliasByFieldName('value3'));
				$("#thisFee").html(thisdata.getFieldAliasByFieldName('value4'));				
				$("#thisFeeName").html(thisdata.getFieldAliasByFieldName('value5'));
            	$("#thissBm").html(thisdata.getFieldAliasByFieldName('value6'));
				$("#thissBm2").html(thisdata.getFieldAliasByFieldName('value7'));
				$("#thissBm3").html(thisdata.getFieldAliasByFieldName('value8'));
            	$("#thissBm4").html(thisdata.getFieldAliasByFieldName('value9'));
				$("#thisifurgent").html(thisdata.getFieldAliasByFieldName('Bz'));				
				$("#thismemo").html(thisdata.getFieldAliasByFieldName('Zwbz'));
				$("#thisPayMode").html(thisdata.getFieldAliasByFieldName('Hth'));
				$("#thisisPay").html(thisdata.getFieldAliasByFieldName('Pgrq'));
				$("#thisHth").html(thisdata.getFieldAliasByFieldName('value15'));
            	$("#thisdevno").html(thisdata.getFieldAliasByFieldName('Lsh'));
            	$("#thisjobstate").html(thisdata.getFieldAliasByFieldName('dJhwcsj'));            	
            }		
		</script>
	</head>

	<body>
		<div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
		</div>		
		<table cellspacing="5px">
			<tr>
				<td><fmt:message key="phone.getinternet0314" /><!-- 电话号码-->:</td>
				<td><input type="text" class="inputbox" id="kdSearchBox" name="kdSearchBox" /></td>
				<td>
					<button class="tsdbutton" id="kdSearchByUserName" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;"><fmt:message key="phone.getinternet0466" /><!-- 查找 --></button><button class="tsdbutton" id="kdUserInfo" style="display:none;" disabled><fmt:message key="phone.getinternet0467" /><!-- 用户信息 --></button>	
				</td>
			</tr>
		</table>
	   <div id="input-Unit" style="margin-bottom:0px;">
			<div id="tfdiv" style="display:none;">
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/45.gif" />
					<fmt:message key="phone.getinternet0315" /><!-- 退费信息-->
				</div>
			</div>			
		<table cellspacing="5" id="tftable" style="display:none;">
			<tr>
				<td>
					<table style="background-color:#A9C8D9;border:#A9C8D9 solid 0px;width:250px;">
						<tr><td valign='bottom' style='width:200px;'><h4><fmt:message key="phone.getinternet0316" /><!-- 费用项--></h4></td><td valign='bottom' style='width:50px;'><h4><fmt:message key="phone.getinternet0093" /><!-- 费用金额 --></h4></td></tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table id="tfeevalue" cellspacing="0">
					</table>
				</td>
				<td valign="bottom" style="font-size:15px;">
					<fmt:message key="phone.getinternet0317" /><!--合计-->：<span id="sumfee" style="color:red;"></span>￥
				</td>
			</tr>
		</table>	 
		<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/45.gif" />
					<fmt:message key="phone.getinternet0318" /><!--工单信息-->
		</div>
		</div>
		<table id="tdiv" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisJobID"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisJobIDvalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisJobType"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisJobTypevaluezh"></div>
					<div id="thisJobTypevalue" style="display:none;"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thismqbm"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thismqbmvalue"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisIfCancel"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisIfCancelvaluezh"></div>
					<div id="thisIfCancelvalue" style="display:none;"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisjobstatus"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">					
					<div id="thisjobstatusvalue" style="display:none;"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisUserName"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisUserNamevalue"></div>
				</td>
			</tr>

			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisoldsRealName"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisoldsRealNamevalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thissRealName"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissRealNamevalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisJobRecTime"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisJobRecTimevalue"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisUserID"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisUserIDvalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisArea"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisAreavalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisDepart"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisDepartvalue"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisValue"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisValuevalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisvlanid"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisvlanidvalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisPayType"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisPayTypevalue"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisiFeeType"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisiFeeTypevalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thissDh"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissDhvalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thissRegDate"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissRegDatevalue"></div>
				</td>
			</tr>

			<tr>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisfeedendtime"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisfeedendtimevalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisiFeeTypeTime"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisiFeeTypeTimevalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisoldsAddress"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisoldsAddressvalue"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thissAddress"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissAddressvalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisiStatus"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisiStatusvalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thissDh1"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissDh1value"></div>
				</td>
			</tr>

			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thissDh2"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissDh2value"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisiSimultaneous"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisiSimultaneousvalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisUserName1"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisUserName1value"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisidtype"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisidtypevaluezh"></div>
					<div id="thisidtypevalue" style="display:none;"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisidcard"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisidcardvalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisjobstate"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisjobstatevalue"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisoldspeed"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisoldspeedvalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisspeed"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thismobilevalue"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisPayMode"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisPayModevalue"></div>
				</td>
			</tr>
			<tr style='display:none'>
				<td class="labelclass">
					<label for="sarea">
						<span id="thislinkphone"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thislinkphonevalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thislinkman"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thislinkmanvalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisFee"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisFeevalue"></div>
				</td>
			</tr>
			<tr style='display:none'>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisFeeName"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisFeeNamevalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thissBm"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissBmvalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thissBm2"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissBm2value"></div>
				</td>
			</tr>
			<tr style='display:none'>
				<td class="labelclass">
					<label for="sarea">
						<span id="thissBm3"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissBm3value"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thissBm4"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissBm4value"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="thismobile"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisspeedvalue"></div>
				</td>
				
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thismemo"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<textarea readonly="readonly" rows="5" cols="30" id="thismemovalue"></textarea>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisisPay"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisisPayvalue"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="thisifurgent"></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisifurgentvalue"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="thisdevno"></span>
					</label>
				</td>
				<td width="20%" class="tdstyle" colspan=7>
					<div id="thisdevnovalue"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<fmt:message key="phoneyewu.memo" />
				</td>
				<td width="20%" class="tdstyle" colspan=7>
					<textarea id="addBzText" style="width:500px;height:100px;" onKeyDown="if(this.value.length>100){alert('备注信息最大长度为100个字符');this.value=this.value.substring(0,100);event.returnValue=false;}"></textarea>
				</td>
			</tr>
		</table>	
	<%-- <h2><fmt:message key="phoneyewu.memo" /></h2>
	<textarea id="addBzText" style="width:500px;height:100px;" onKeyDown="if(this.value.length>100){alert('备注信息最大长度为100个字符');this.value=this.value.substring(0,100);event.returnValue=false;}"></textarea> --%>
	<div id="buttons" style="text-align:center">
		<button id="kdcx" style="width:120px;" onClick="cxJob()" disabled><fmt:message key="phone.getinternet0319" /><!-- 撤销 --></button><button id="kdback" style="width:120px;" onClick="resetPage()"><fmt:message key="AddUser.Reset" /></button>
	</div>
		
		
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="Interregional" />
	
	<input type="hidden" id="department" name="department" value='<%=session.getAttribute("departname") %>' />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="userid" name="userid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
	<input type="hidden" id="fufeitypepath"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->	
	<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
