<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/phonectrl/ArrearsProcess.jsp
    Function:   电话欠费综合处理
    Author:     wenxuming
    Date:       2011-04-21
    Description: 
    Modify:     
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
		<title>欠费综合处理</title>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
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
		<!-- 时间选择器 -->
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>	
		<style type="text/css">
			#qftrid{background-color:#A9C8D9;border:#A9C8D9 solid 0px;}
			#qftrid{border-collapse:collapse;border:#A9C8D9 solid 1px;}
			#qfuser tr td{line-height:26px;border:#A9C8D9 solid 1px;TEXT-OVERFLOW: ellipsis;}
		</style>
		<style type="text/css">  
		.mytable{   
		   width:100%;
		   table-layout:fixed;
		   border:0px;   
		   margin:0px; 
		   }      
		.mytable tr td{   
		   text-overflow:ellipsis; /* for IE */    
		   -moz-text-overflow: ellipsis; /* for Firefox,mozilla */    
		    overflow:hidden;   
		    white-space: nowrap;   
		    border:0px;   
		    text-align:left;      
		   }
		   .mytable tr th{   
		    white-space: nowrap;   
		   border:0px;   
		    text-align:left   
		   }   
		</style>  		
		<script type="text/javascript">
		/*********
			*  设置权限
			* @param;
			* @return;
		    **********/
			function setUserRight()
			{//alert("&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
				//获取权限信息
				var allRi = fetchMultiPValue("telReprint.getPower",6,"&userid="+$("#userid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
				//解析从数据库得到的权限信息
				if(typeof allRi == 'undefined' || allRi.length == 0)
				{
					//alert("取权限失败");
					return false;
				}
				//admin登入权限设置
				if(allRi[0][0]=="all")
				{
					//打印隐藏域
					$("#printt").val("true");
					$("#RightGroup").val("10");
					return true;
				}				
				var printt = false;
				var rightgroup = 0;
				for(var i = 0;i<allRi.length;i++){
					var rg = getCaption(allRi[i][0],'RightsGroup','');
					if(parseInt(rg,10)>rightgroup)
					{
						rightgroup = parseInt(rg,10);
					}
					if(getCaption(allRi[i][0],'print','')=="true")
						printt = true;
				}
				//打印隐藏域	
				$("#printt").val(printt);
				//权限组信息设置
				$("#RightGroup").val(rightgroup);
			}
		//table-layout:fixed; 
		jQuery(document).ready(function()
		{
			$("#navBar").append(genNavv());
		    gobackInNavbar("navBar");
		    setUserRight();
		    gettabletitle();
		    Dat = loadData("hwjb_owefee","zh",2);
		    if($("#RightGroup").val()=="10"){
		    	getasys_areaall();
		    }else if($("#RightGroup").val()=="3"){
		    	getasys_area();
		    }else if($("#RightGroup").val()=="0"){
		    	getasys_area();	
		    }		    	
		    calltype();    		    			
		    $("#minfee").val(1);
			$("#minmonth").val(2);
			$("#txzarea").val($("#area").val());
		});	
		
		function gettabletitle(){
			var querystr=""
			querystr += "<tr id='qftrid'>";
			querystr += "<th style='width:2%;'><center>";
			querystr += "";
			querystr += "</center></th>";
			querystr += "<th style='width:8%;'>";
			querystr += "合同号";
			querystr += "</th>";			
			querystr += "<th style='width:6%;'>";
			querystr += "电话";
			querystr += "</th>";
			querystr += "<th style='width:5%;'>";
			querystr += "实时话费";
			querystr += "</th>";
			querystr += "<th style='width:5%;'>";
			querystr += "欠费金额";
			querystr += "</th>";
			querystr += "<th style='width:4%;'>";
			querystr += "滞纳金";
			querystr += "</th>";
			querystr += "<th style='width:5%;'>";
			querystr += "欠费月数";
			querystr += "</th>";
			querystr += "<th style='width:6%;'>";
			querystr += "最早欠费月";
			querystr += "</th>";
			querystr += "<th style='width:6%;'>";
			querystr += "用户状态";
			querystr += "</th>";				
			querystr += "<th style='width:5%;'>";
			querystr += "催缴次数";
			querystr += "</th>";			
			querystr += "<th style='width:5%;'>";
			querystr += "用户类别";
			querystr += "</th>";
			querystr += "<th style='width:6%;'>";
			querystr += "用户名称";
			querystr += "</th>";
			querystr += "<th style='width:6%;'>";
			querystr += "帐户名称";
			querystr += "</th>";					
			querystr += "<th style='width:4%;'>";
			querystr += "信誉度";
			querystr += "</th>";
			querystr += "<th style='width:7%;'>";
			querystr += "营收区域";
			querystr += "</th>";
			querystr += "<th style='width:12%;'>";
			querystr += "用户地址";
			querystr += "</th>";
			querystr += "</tr>";
			$("#qfusertitle").html(querystr);
		}
		
		var checkstrno="";
		function gettabledate(){
			$("#qfuser").empty();	
			$("#checkvalue").val("");
			checkstrno="";	
			checkstr="";
			var querystr = "";			
			var num=0;
			var res = fetchMultiArrayValue("dbsql_phone.queryhwjb_owefeeto",6,"&userid="+$("#userid").val());
			if(res==""||res==undefined||res=="undefined"){alert("没有可查询的数据！");$("#cjbutton,#xhbutton,#tjbutton").attr("disabled","disabled");return;}
			$("#cjbutton,#xhbutton,#tjbutton").removeAttr("disabled","disabled");						
			for(var i=0;i<res.length;i++){
				num++;
				querystr += "<tr onClick=\"getselect('"+res[i][0]+"');\" id=\""+res[i][0]+"\">";				
				querystr += "<td  style='width:2%;'><center>";				
				if(res[i][13]!=$("#txzarea").val()){
					querystr += "<input type=\"checkbox\" id='v_bytctab_check"+res[i][0]+"'  onClick=\"getcheckboxfalse('"+res[i][0]+"');\" style='width:20px;' disabled=true/>";
					checkstrno +=res[i][0]+",";
					num--;
				}else{
					querystr += "<input type=\"checkbox\" id='v_bytctab_check"+res[i][0]+"'  onClick=\"getcheckboxfalse('"+res[i][0]+"');\" style='width:20px;' checked/>";
				}				
				querystr += "</center></td>";
				querystr+="<td title='"+res[i][0]+"' style='width:8%;'>"+res[i][0]+"</td>";
				querystr+="<td title='"+res[i][1]+"' style='width:6%;'>"+res[i][1]+"</td>";
				querystr+="<td title='"+res[i][2]+"' style='width:5%;'>"+res[i][2]+"</td>";
				querystr+="<td title='"+res[i][3]+"' style='width:5%;'>"+res[i][3]+"</td>";
				querystr+="<td title='"+res[i][7]+"' style='width:4%;'>"+res[i][7]+"</td>";
				querystr+="<td title='"+res[i][4]+"' style='width:5%;'>"+res[i][4]+"</td>";
				querystr+="<td title='"+res[i][5]+"' style='width:6%;'>"+res[i][5]+"</td>";
				querystr+="<td title='"+res[i][6]+"' style='width:6%;'>"+res[i][6]+"</td>";
				querystr+="<td title='"+res[i][8]+"' style='width:5%;'>"+res[i][8]+"</td>";
				querystr+="<td title='"+res[i][9]+"' style='width:5%;'>"+res[i][9]+"</td>";
				querystr+="<td title='"+res[i][10]+"' style='width:6%;'>"+res[i][10]+"</td>";
				querystr+="<td title='"+res[i][11]+"' style='width:6%;'>"+res[i][11]+"</td>";
				querystr+="<td title='"+res[i][12]+"' style='width:4%;'>"+res[i][12]+"</td>";
				querystr+="<td title='"+res[i][13]+"' style='width:7%;'>"+res[i][13]+"</td>";
				querystr+="<td title='"+res[i][14]+"' style='width:12%;'>"+res[i][14]+"</td>";
				querystr += "</tr>";				
			}			
			$("#qfuser").html(querystr);
			var resarea = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(*) as cont&tablename=hwjb_owefee&key=userid='"+$("#userid").val()+"' and area!='"+tsd.encodeURIComponent($("#txzarea").val())+"'");
			if(resarea!="0"){
				alert("以下没有打勾的电话的区域与查询区域不一致，不能办理限呼、催缴、停机业务！");
			}
			$("#num").val("");
			$("#num").val(num);
			$("#count").text("当前可操作数据为："+num+"条!");
			//$("input[id^='v_bytctab_check']").attr("checked","checked");			
			//jQuery.page("page",10);
		}
		
		function getselect(key){
			$("#qfuserhidden").val(key);
        	$("#qfuser tr ").css('background-color','#ffffff');
        	$("#qftrid").css('background-color','#A9C8D9');
		    document.getElementById(key).style.background='#00FFFF';
		}
			
		var checkstr="";	
		function getcheckboxfalse(key){			
			if($("#v_bytctab_check"+key+"").attr("checked")==false){
				//checkstr+="'"+key+"',";
				checkstr+=""+key+",";
				var m = parseInt($("#num").val(),10)-1;
				$("#num").val(m);
				$("#count").text("当前可操作数据为："+m+"条!");
			}else{
				//checkstr=checkstr.replace("'"+key+"',",'');
				checkstr=checkstr.replace(key+",",'');
				var m = parseInt($("#num").val(),10)+1;
				$("#num").val(m);
				$("#count").text("当前可操作数据为："+m+"条!");
			}
			$("#checkvalue").val(checkstr);
		}

		function saveupdate(key){
			var tsstr="";
			if(key=="0"){tsstr='催缴';}
			if(key=="1"){tsstr='限呼';}
			if(key=="2"){tsstr='停机';}
			if(confirm("是否对选中的用户进行"+tsstr+"操作！")){
				$("#checkvalue").val($("#checkvalue").val()+checkstrno);
				var checkvalue = $("#checkvalue").val();
				checkvalue = checkvalue.substring(0,checkvalue.length-1);
				var userid = $("#userid").val();
				var StrategyCalls = $("#StrategyCalls").val();
				var params="";
				params +="&ctltype="+key;
				params +="&hth="+checkvalue;
				params +="&userid="+userid;
				params +="&callshedule="+tsd.encodeURIComponent(StrategyCalls);
				var result = fetchMultiPValue("ArrearsProcess.p_hwjb_owefeeoperate",6,params);
				if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
				{
					alert("操作失败！");
					return;
				}else{
					if(key=='0'){
						alert("手动催缴成功！");
					}else if(key=='1'){
						alert("手动限呼成功！");
					}else{
						alert("手动停机成功！");
					}
					$("#checkvalue").val("");
					$("#num").val("");
					$("#qfuser").empty();
					$("#count").empty();
					//$("#qfcjres option:selected").val("");
					$("#qfcjres :text").val("");
					if($("#RightGroup").val()=="10"){
				    	getasys_areaall();
				    }else if($("#RightGroup").val()=="3"){
				    	getasys_area();
				    }else if($("#RightGroup").val()=="0"){
				    	getasys_area();	
				    }
				    calltype();
					$("#minfee").val(1);
					$("#minmonth").val(2);		
					$("#txzarea").val($("#area").val());			
					$("#cjbutton,#xhbutton,#tjbutton").attr("disabled","disabled");
				}
			}
		}
		
		function queryCallsData(){
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
			$("#editgrid").empty();
			var area = $("#txzarea").val();
			var userid = $("#userid").val();
			var minfee = $("#minfee").val().replace(/(^\s*)|(\s*$)/g,"");
			if(minfee==""){alert("请输入最小欠费金额！");$("#minfee").select();$("#minfee").focus();return;}
			var maxfee = $("#maxfee").val().replace(/(^\s*)|(\s*$)/g,"");
			var minmonth = $("#minmonth").val().replace(/(^\s*)|(\s*$)/g,"");
			if(minmonth==""){alert("请输入最小欠费金额！");$("#minmonth").select();$("#minmonth").focus();return;}
			var maxmonth = $("#maxmonth").val();
			var params="";
			params+="&area="+tsd.encodeURIComponent(area);
			params+="&userid="+userid;
			params+="&minfee="+minfee;
			params+="&maxfee="+maxfee;
			params+="&minmonth="+minmonth;
			params+="&maxmonth="+maxmonth;
			var result = fetchMultiPValue("ArrearsProcess.hwjb_owefee",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
			{
				$("#qfuser").empty();
				$("#count").empty();
				alert("没有可查询的数据！");
				$("#cjbutton,#xhbutton,#tjbutton").attr("disabled","disabled");
				return;
			}
			checkstrno="";
			gettabledate();
			return;
			var urlstr=tsd.buildParams({packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdCharge',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'dbsql_phone.queryhwjb_owefee',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'dbsql_phone.queryhwjb_owefeepage'	
									});								
			$("#editgrid").jqGrid({
					url:'mainServlet.html?'+urlstr+params,
					datatype: 'xml', 
						colNames:Dat.colNames, 
					    colModel:Dat.colModels,
						multiselect:true,
					    rowNum:500, //默认分页行数
					    useDefault:true,
						rowList:[10,15,20], //可选分页行数
						imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						pager: jQuery('#pagered'), 
						sortname: 'dh', //默认排序字段
						//hidegrid: false, 
						sortorder: 'desc',//默认排序方式 
						//caption:infoo,				       	
						height:300, //高
						//	width:document.documentElement.clientWidth-27,
						loadComplete:function(){		
												},
						ondblClickRow: function(ids) {
												}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
							);								
		}
		
		function getgridvalue(){			
			var gridvalue = $("#editgrid").getGridParam("selarrrow");
			if(gridvalue.length==0){
				alert("请选择欠费电话");
				return;
			}
			var array=[];
			for(var i=0;i<gridvalue.length;i++){
				var str = $("#editgrid").getCell(gridvalue[i],Dat.FieldName[1]);
				if(null==str)
				{
					alert("没有可选择的合同号");
					return;
				}
				array.push($.trim(str));
			}
			alert(array.join(","));
		}				
		
		function getasys_area(){
			var urlstr=tsd.buildParams({
								packgname:'service',		//java包
								clsname:'AskConstant',		//类名
								method:'askConstantTable',	//方法名
								identity:'FINAL.asys_area',	//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								pattern:'select',			//访问方式 select：查询常量表信息，update：更新常量表信息
								argument:'area:'+tsd.encodeURIComponent($("#area").val())			//对常量表的过滤条件
				 				});
					var ysqy='';
					$("#txzarea").empty();
					ysqy+="";
					$.ajax({
						url:'mainServlet.html?'+urlstr,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
								$(xml).find('row').each(function(){
			                 			ysqy +="<option value='"+$(this).attr("area")+"'>"+$(this).attr("area")+"</option>";
								});
								$("#txzarea").append(ysqy);
						}
					});
					
		}
		
		function getasys_areaall(){
			var urlstr=tsd.buildParams({
								packgname:'service',		//java包
								clsname:'AskConstant',		//类名
								method:'askConstantTable',	//方法名
								identity:'FINAL.asys_area',	//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								pattern:'select',			//访问方式 select：查询常量表信息，update：更新常量表信息
								argument:''
				 				});
					var ysqy='';
					$("#txzarea").empty();
					ysqy+="<option value='' selected=true>全部站</option>";
					$.ajax({
						url:'mainServlet.html?'+urlstr,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
								$(xml).find('row').each(function(){
			                 			ysqy +="<option value='"+$(this).attr("area")+"'>"+$(this).attr("area")+"</option>";
								});
								$("#txzarea").append(ysqy);
						}
					});
					
		}
		
		function calltype(){   
		   $("#StrategyCalls").empty();    
           var res = fetchMultiArrayValue("dbsql_phone.querycallpay_shedule_base",6,'&key='+tsd.encodeURIComponent("'宽带催缴','免催'"));           
           if(res[0]==undefined || res[0][0]==undefined)
           {
           		return false;
           }           
           var querysel="";
		   for(var i=0;i<res.length;i++)
		   {
		       var ee="<option value='"+res[i][1]+"'>"+res[i][1]+"</option>";	
		       querysel+=ee;					
		   }
		   $("#StrategyCalls").append(querysel);
		   $("#StrategyCalls").val("手工催缴");
		}
		
		function xiazai(){
			/*
			if(flagsql==''||flagsql==undefined){
					sql = 'main.Export';
			}else{
					sql = 'main.ExportField';
			}*/
			sql = 'main.Export';
			var fieldvalue="";
			for(var j=0;j<Dat.colModels.length;j++){
				fieldvalue+=Dat.FieldName[j]+" "+"as"+" "+Dat.FieldAlias[j]+",";		
			}			
			var params="";
			params += "&cols="+tsd.encodeURIComponent(fieldvalue.substring(0,fieldvalue.length-1));
			params += "&table=hwjb_owefee";
			params += "&tablealias=hwjb_owefee";
			params += "&exportflag=0";
			params += "&whichsql=0";
			params += "&fusearchsql=userid='"+$("#userid").val()+"'";
			var urlstr=tsd.buildParams({packgname:'service',//java包
													clsname:'ExecuteSql',//类名
													method:'exeSqlData',//方法名
													ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													tsdcf:'mssql',//指向配置文件名称
													tsdoper:'query',//操作类型
													datatype:'xls',//返回数据格式 
													tsdpk:sql//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													});
						if($("#download").size()==0)
							$("body").append("<iframe id='download' name='download' width='0' height='0'></iframe>");							
					    $("#download").attr("src","mainServlet.html?"+urlstr + params);	
		}
		
		function numValid(obj)
	{		
		if($.browser.msie)
		{
			var dotPos = obj.value.indexOf(".");
			var lenAfterDot;
			
			if(dotPos==-1)
			{
				lenAfterDot = 0;
			}
			else
			{
				lenAfterDot = obj.value.length - dotPos -1;
			}
			
			var evt = window.event;
			if (evt.keyCode < 48 || evt.keyCode > 57)
			{
				if(evt.keyCode==46)
				{
					if(dotPos==-1)
						lenAfterDot=0;
					else
						evt.returnValue = false;
				}
				else
				{
					evt.returnValue = false;
				}
			}
			else
			{
				if(dotPos!=-1)
				{
					if(lenAfterDot>=2)
					{
						evt.returnValue = false;
					}
				}
			}
		}
		else
		{
			obj.value=obj.value.replace(/[^0-9]/g,'');
		}
	}
	
  </script>
  </head>
  <body>
     <div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
		</div>
	<div id="input-Unit">
	  <table cellspacing='5' style='width:100%;background-color: #F8F8FF; border-collapse: collapse; float: left;' id="qfcjres">
	  	<tr>
	  		<td>
	  			<table cellspacing='10'>
					<tr>
						<td>通信站</td>
						<td colspan=3><select id="txzarea" style="width:120px;"></select></td>
						<td>欠费</td>
						<td>>=</td>
						<td><input type="text" id="minfee" style="width:70px;ime-mode: disabled;"
								 onkeypress="numValid(this)"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return   false"/>元</td>
						<td><=</td>
						<td><input type="text" id="maxfee" style="width:70px;ime-mode: disabled;"
								 onkeypress="numValid(this)"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return   false"/>元</td>
					</tr>
					<tr>	
						<td>欠费月数</td>
						<td>>=</td>
						<td></td>
						<td><input type="text" id="minmonth" style="width:70px;" style='width: 150px;' style='ime-mode: Disabled' onkeypress='var k=event.keyCode;return k>=48&&k<=57' maxlength="2" ondragenter='return false' onpaste='return false'/></td>
						<td><=</td>
						<td colspan=3><input type="text" id="maxmonth" style="width:70px;" style='width: 150px;' style='ime-mode: Disabled' onkeypress='var k=event.keyCode;return k>=48&&k<=57' maxlength="2" ondragenter='return false' onpaste='return false'/></td>
						<td>
							<button id="" class="tsdbutton" onclick="queryCallsData();" style="width:70px;">查询</button>
						</td>
					</tr>
				</table>
	  		</td>
	  		<td>
	  			<span id="count" style='color:red'></span>
	  		</td>
	  		<td>
	  			<table style='background-color: #AFEEEE; border-collapse: collapse; float: left;'>
	  				<tr>
	  					<td>催缴策略</td>
	  					<td>
	  						<select id="StrategyCalls" style="width:120px;"/>
	  					</td>	  					
	  				</tr>
	  				<tr>
	  					<td colspan=3 id="czbutton">
	  						<button class="tsdbutton" id="cjbutton" onclick="saveupdate('0');" title="催缴" style='width:70px;' disabled="disabled">催缴</button>&nbsp;&nbsp;
				  			<button class="tsdbutton" id="xhbutton" onclick="saveupdate('1');" title="限呼" style='width:70px;' disabled="disabled">限呼</button>&nbsp;&nbsp;
				  			<button class="tsdbutton" id="tjbutton" onclick="saveupdate('2');" title="停机" style='width:70px;' disabled="disabled">停机</button>
				  		</td>
				  	</tr>
	  			</table>
	  		</td>
	  	</tr>
	  </table>
	<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
	</div>
	<table id="qfusertitle" style="width:1300px;height:25px;" class='mytable'></table>
	<div id="page" style="width:1300px; height: 530px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
		<table id="qfuser" width="" class='mytable'></table>
	</div>
	<button id="" class="tsdbutton" onclick="xiazai();">下载</button>	
	</div>
	<input type="hidden" id="userid" value="<%=userid %>"/>
	<input type="hidden" id="imenuid" value="<%=imenuid %>"/>
	<input type="hidden" id="zid" value="<%=zid %>"/>
	<input type="hidden" id="qfuserhidden"/>
	<input type="hidden" id="checkvalue" style="width:300px;"/>
	<input type="hidden" id="num"/>
	<input type="hidden" id="area" value="<%=area %>"/>
	<!-- 权限组 -->
	<input type="hidden" id="RightGroup" name="RightGroup" />
  </body>
</html>
