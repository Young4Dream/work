<%----------------------------------------
	name: hponeDAM.jsp
	author: youhongyu
	version: 1.0, 2010-10-13
	description: 明细话单档案管理
	modify: 
		2010-11-5 youhongyu 添加注释功能
		2010-11-16 youhongyu 页面查询按钮功能未实现，注释掉原来测试代码	
		2010-12-15 liwen     样式修改
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.tsd.service.util.Log"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>If a single file management details</title>	
		
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
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
			
		

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
							 					  tsdpname:'rePrice.getPower',//存储过程的映射名称
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
				
				var addright = '';
				var delBright = '';
				var editBright = '';				
				var deleteright = '';
				var editright = '';
				var editfields = '';				
				var exportright = '';
				var printright ='';
				
				/**
				添加模板查询
				queryright queryMright saveQueryMright
				hasquery hasqueryM hassaveQueryM 
				**/
				var queryright = '';				
				var queryMright = '';
				var saveQueryMright ='';
				
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
							addright += getCaption(spowerarr[i],'add','')+'|';
							
							delBright += getCaption(spowerarr[i],'delB','')+'|';
							
							editBright += getCaption(spowerarr[i],'editB','')+'|';	
														
							deleteright += getCaption(spowerarr[i],'delete','')+'|';
							
							editright += getCaption(spowerarr[i],'edit','')+'|';	
							
							editfields += getCaption(spowerarr[i],'editfields','');
							
							exportright += getCaption(spowerarr[i],'export','')+'|';
							
							printright += getCaption(spowerarr[i],'print','')+'|';
							
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
							queryMright += getCaption(spowerarr[i],'queryM','')+'|';
							
							saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
							
						}
				}else if(spower=='all@'){
						$("#addright").val(str);
						$("#delBright").val(str);
						$("#editBright").val(str);
						
						$("#deleteright").val(str);
						$("#editright").val(str);						
						$("#exportright").val(str);
						$("#printright").val(str);
						
						$("#queryright").val(str);						
						$("#queryMright").val(str);
						$("#saveQueryMright").val(str);
						
						//var languageType = $("#languageType").val();
						//editfields = getFields('JhjID');
						flag = true;
				}				
				if(flag==false){
					var hasadd = addright.split('|');
					var hasdelB = delBright.split('|');
					var haseditB = editBright.split('|');
					var hasdelete = deleteright.split('|');
					var hasedit = editright.split('|');
					var hasexport = exportright.split('|');
					var hasprint = printright.split('|');
					
					var hasquery = queryright.split('|');
					var hasqueryM = queryMright.split('|');
					var hassaveQueryM = saveQueryMright.split('|');
					
					for(var i = 0;i<hasquery.length;i++){
						if(hasquery[i]=='true'){
							$("#queryright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasqueryM.length;i++){
						if(hasqueryM[i]=='true'){
							$("#queryMright").val(str);
							break;
						}
					}
					
					for(var i = 0;i<hassaveQueryM.length;i++){
						if(hassaveQueryM[i]=='true'){
							$("#saveQueryMright").val(str);
							break;
						}
					}			
					for(var i = 0;i<hasadd.length;i++){
						if(hasadd[i]=='true'){
							$("#addright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelB.length;i++){
						if(hasdelB[i]=='true'){
							$("#delBright").val(str);
							break;
						}
					}
					for(var i = 0;i<haseditB.length;i++){
						if(haseditB[i]=='true'){
							$("#editBright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelete.length;i++){
						if(hasdelete[i]=='true'){
							$("#deleteright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasedit.length;i++){
						if(hasedit[i]=='true'){
							$("#editright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasexport.length;i++){
						if(hasexport[i]=='true'){
							$("#exportright").val(str);
							break;
						}
					}					
					for(var i = 0;i<hasprint.length;i++){
						if(hasprint[i]=='true'){
							$("#printright").val(str);
							break;
						}
					}					
				}
				$("#editfields").val(editfields);
		}
		</script>
		<script type="text/javascript">
			/**
			 * 页面初始化
			 * @param 
			 * @return 
			 */		
			jQuery(document).ready(function(){
					//设置当前位置
					$("#navBar").append(genNavv());		
					
					// 用户权限判定，初始化用户可操作权限 			
					getUserPower();
					/*
					//获取个操作权限
					
					var exportright = $("#exportright").val();
					var queryright = $("#queryright").val();							
					var saveQueryMright = $("#saveQueryMright").val();
					
					//获取个操作按钮可用性
					
					if(exportright=="true"){
						document.getElementById("export1").disabled=false;
						document.getElementById("export2").disabled=false;
					}					
					if(queryright=="true"){
						document.getElementById("gjquery1").disabled=false;
						document.getElementById("gjquery2").disabled=false;
					}					
					if(saveQueryMright=="true"){
						document.getElementById("savequery1").disabled=false;
						document.getElementById("savequery2").disabled=false;
					}
					*/
					setGdMonth();//初始化话单月份
					limitDate();//限制起始时间和截止时间
					initSelect();//初始化通话类型
					addTextarea();//初始化自定义条件
			});	
			
		    /**
			 * 设置话单月份为当前月和上一个月
			 * @param  
			 * @return 
			 */
			function initSelect(){
				var thlx = fetchMultiArrayValue("rePrice.thlx",6,"");
				if(thlx!=""  && thlx!=undefined){
					for(var i=0;i<thlx.length;i++){
						$("#thlx").append("<option value="+thlx[i][1]+">"+thlx[i][1]+"</option>");
					}
					
				}
			}								
		</script>		
		
		<script type="text/javascript">
		    /**
			 * 设置话单月份为当前月和上一个月
			 * @param  
			 * @return 
			 */
		  function setGdMonth(){
		  		var myDate = new Date();
		  		var curYear=myDate.getFullYear();//获取完整的年份(4位,1970-????)
				var curMonth=myDate.getMonth()+1;//获取当前月份(0-11,0代表1月)
				if(curMonth<10){
					curMonth="0"+curMonth;//设置月份为01这种格式
				}
				var curYearMonth=curYear.toString()+curMonth+"";//当前年月
				/****************
				当当前月份为1时，上一个月份为上一年的最后一个月份
				*****************/
				var upYear="";//去年
				var upMonth="";//上一个月						
				var upYearMont="";//上一年的年月
				if(curMonth=="01"){
					upYear=curYear-1;
					upYearMonth=upYear+"12";
				}else{
					upMonth=curMonth-1;
					if(upMonth<10){
						upMonth="0"+upMonth;//设置月份为01这种格式
					}
					upYearMonth=curYear.toString()+upMonth+"";
				}
				$("#GdMonth").empty();//清空话单月份
				$("#GdMonth").append("<option value="+curYearMonth+">"+curYearMonth+"</option><option value="+upYearMonth+">"+upYearMonth+"</option>");
		  }
		    /**
			 * 设置话单月份为当前月和上一个月
			 * @param  
			 * @return 
			 */
		  function limitDate(){
		  		$("#time1").val("");
		  		$("#time2").val("");
		  		var GdMonth=$("#GdMonth").val();
		  		var year=GdMonth.substr(0,4);
		  		var month=GdMonth.substr(4,2);
		  		var curDate=year+"-"+month;
		  		var start=curDate+'-01 00:00:00';
		  		//var end=curDate+'-%ld 23:59:59';
		  		var end=curDate+'-31 23:59:59';
		  		//alert("start="+start);
		  		//alert("end="+end);
		  		$("#startDate").val(start);
		  		$("#endDate").val(end);
		  		$("#curDate").val(curDate);
		  }
		  
		    /**
			 * 设置日历控件的最大最小月份
			 * @param  
			 * @return 
			 
		  function setPJTime(flag){
		  		var curDate=$("#curDate").val();
		  		//alert(curDate);
		  		var start=curDate+'-01 00:00:00';
		  		var end=curDate+'-%ld 23:59:59';
		  		//alert("start="+start);
		  		//alert("end="+end);
		  		if(flag=="1"){
		  			$("#time1").focus(function(){
						WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,readOnly:true,minDate:start,maxDate:end});
					});
		  		}else if(flag=="2"){
		  			$("#time2").focus(function(){
						WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,readOnly:true,minDate:start,maxDate:end});
					});
		  		}else{
		  			alert("请重新选择时间！");
		  		}
		  		
		  		
		  }
		  */
			 /**
			 * 页面提交查询
			 * @param  
			 * @return 
			 */	
			function submitQuery(){
								//重新批价时，必须停止话单分拣程序
					if(confirm("<fmt:message key='rePrice.confirm' />！")){
						var params=SubmbuildParams();
						if(params==false){return false;}
						loadPopup();
						/////设置命令参数
						var urlstr=tsd.buildParams({  packgname:'service',
								 					  clsname:'Procedure',
													  method:'exequery',
								 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
								 					  tsdpname:'HDFJ.FJAgain',//存储过程的映射名称
								 					  tsdExeType:'query',
								 					  datatype:'xmlattr'
							 					});
						 
						var	Res ='';	
						urlstr+=params;
						$.ajax({
								url:'mainServlet.html?'+urlstr,
								datatype:'xml',
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(xml){
									$(xml).find('row').each(function(){
										var res=$(this).attr("res");
										var tag=$(this).attr("tag");
										if(res=="SUCCEED"){						
											alert(tag);
										}else{
											alert(tag);
										}
										disablePopup();
									});
								}
						});
					}else{
						return false;
					}
					
					
			}
			
			function compareTime(){
				var GdMonth=$("#GdMonth").val();//话单月份
				var time1=$("#time1").val();//开始时间
				var time2=$("#time2").val();//截止时间
				
				if(GdMonth!=""){
					GdMonth=GdMonth.substr(0,4)+"-"+GdMonth.substr(3,2);
				}
				
				if(time1!=""){
					time1=time1.substr(0,7);
					if(GdMonth!=time1){
						alert("<fmt:message key='rePrice.gdmonthAndTime1' />");//话单月份与起始时间不符，请重新选择
						return false;
					}
				}
				
				if(time2!=""){
					time2=time2.substr(0,7);
					if(GdMonth!=time2){
						alert("<fmt:message key='rePrice.gdmonthAndTime2' />");//话单月份与截止时间不符，请重新选择
						return false;
					}
				}
			}
			
			/**
			 * 查询操作，查询参数拼接
			 * @param 
			 * @return 
			 */
			 function SubmbuildParams(){
				 	//每次拼接参数必须初始化此参数
					tsd.QualifiedVal=true;				
				 	var params='';
					
					var GdMonth=$("#GdMonth").val();//话单月份				
				 	var time1 = $("#time1").val();//起始时间
				 	var time2 = $("#time2").val();//截止时间
				 	var dh1=$("#dh1").val();//起始电话
				 	var dh2=$("#dh2").val();//截止时间
				 	var hth=$("#hth").val();//合同号
				 	var zjjx=$("#zjjx").val();//中继局向
				 	var bjhm=$("#bjhm").val();//被叫号码
				 	var thlx=$("#thlx").val();//通话类型
				 	var custom=$("#hidCustom").val();//自定义
				 	
				 	if(GdMonth==''){
				 		alert("<fmt:message key='rePrice.GdMonth' />");//请输入话单月份
				 		$("#GdMonth").focus();
				 		return false;
				 	}
				 	if(time1==''){				 		
				 		alert("<fmt:message key='rePrice.time1' />");//请输入起始时间
				 		$("#time1").focus();
				 		return false;
				 	}
				 	
				 	if(time2==''){				 		
				 		alert("<fmt:message key='rePrice.time2' />");//请输入截止时间
				 		$("#time2").focus();
				 		return false;
				 	}
					//检测时间
	        		var timecheck=fetchSingleValue("phoneListQ.getstartendDay",6,"&starttime="+time1+"&endtime="+time2);
	        		timecheck = parseInt(timecheck);
	        		if(isNaN(timecheck) || timecheck<=0)
	        		{
	        			alert("<fmt:message key='rePrice.time2CompareTime1' />");//终止时间必须大于起始时间
	        			$("#time2").focus();
	        			return false;
	        		} 
	        		//alert(custom);       		
        			if(custom=='<fmt:message key="rePrice.custom" />'){//直接输入条件，不要以"and"开头
        				custom="";
        			}
				 	params +="&GdMonth="+encodeURIComponent(GdMonth);
				 	params +="&TIME1="+encodeURIComponent(time1);
				 	params +="&TIME2="+encodeURIComponent(time2);
				 	params +="&DH1="+encodeURIComponent(dh1);
				 	params +="&DH2="+encodeURIComponent(dh2);				 	
				 	params +="&Hth="+encodeURIComponent(hth);
				 	params +="&Zjjx="+encodeURIComponent(zjjx);
				 	params +="&Bjhm="+encodeURIComponent(bjhm);
				 	params +="&Thlx="+encodeURIComponent(thlx);
				 	params +="&custom="+encodeURIComponent(custom);
				 										
					//每次拼接参数必须添加此判断
					if(tsd.Qualified()==false){return false;}					
					return params;
			 }
			 
			 /*
			 **去掉自定义框默认的字
			 **
			 */
			 function clearTextarea(){
			 	var custom=$("#custom").val();
			 	$("#hidCustom").val(custom);
			 	$("#custom").val("");
			 	$("#custom").removeClass();
			 }
			 
			 /*
			 **增加自定义框默认的字并设置其样式
			 **
			 */
			 function addTextarea(){
			 	var custom=$("#custom").val();
			 	$("#hidCustom").val(custom);
			 	$("#custom").val('<fmt:message key="rePrice.custom" />');//直接输入条件，不要以"and"开头
			 	$("#custom").attr("class","fontStyle");
			 }
			 
		</script>
		<script type="text/javascript">
			/**
			 * 显示等待
			 * @param 无参数
			 * @return 无返回值
			 */
			function showWait()
			{
				$("#loading").css("display","block");//loadPopup();
			}
			/**
			 * 隐藏等待
			 * @param 无参数
			 * @return 无返回值
			 */
			function hideWait()
			{
				$("#loading").css("display","none");//disablePopup();
			}
			
			/**
			 * 弹窗
			 * @param 无参数
			 * @return 无返回值
			 */
			var popupStatus = 0;
			function loadPopup(){
				centerPopup();
				$("#rePrice").attr("disabled","disabled");
				//loads popup only if it is disabled
				if(popupStatus==0){
					$("#backgroundPopup").css({
						"opacity": "0.7"
					});
					$("#backgroundPopup").css("display","block");
					$("#loading").css("display","block");
					popupStatus = 1;
				}
			}
			/**
			 * disablePopup
			 * @param 无参数
			 * @return 无返回值
			 */
			function disablePopup(){
				//disables popup only if it is enabled
				$("#rePrice").removeAttr("disabled","disabled");
				if(popupStatus==1){
					$("#backgroundPopup").fadeOut("slow");
					$("#loading").fadeOut("slow");
					popupStatus = 0;
				}
			}
			/**
			 * centering popup
			 * @param 无参数
			 * @return 无返回值
			 */
			function centerPopup(){
				//request data for centering
				var windowWidth = document.documentElement.clientWidth;
				var windowHeight = document.documentElement.clientHeight;
				var popupHeight = $("#loading").height();
				var popupWidth = $("#loading").width();
				//centering
				$("#loading").css({
					"position": "absolute",
					"top": windowHeight/2-popupHeight/2,
					"left": windowWidth/2-popupWidth/2
				});
				//only need force for IE6
				
				$("#backgroundPopup").css({
					"height": windowHeight
				});			
			}
		</script>
  </head>


<style type="text/css">
		.style1 {
			background-color: #A9C3E8;
			padding: 4px;
		}
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		#listQtb {
			margin-top: 10px;			
		}
		#listQtb tr td input{
			width: 140px;
			height: 25px;
			margin-bottom: 3px;
		}
		.fontStyle{
			font-size:12px;
			color:#A8A8A8;
		}
		
		label{float:right;text-align:left;margin-left:0px;}
		#loading{
			display:none;
			position:fixed;
			_position:absolute; /* hack for internet explorer 6*/
			height:300px;
			width:608px;
			text-align:center;
			background:#FFFFFF;
			border:2px solid #cecece;
			z-index:2;
			padding:12px;
			font-size:13px;
		}
		#backgroundPopup{
			display:none;
			position:fixed;
			_position:absolute; /* hack for internet explorer 6*/
			height:100%;
			width:100%;
			top:0;
			left:0;
			background:#ffffff;
			border:1px solid #cecece;
			z-index:1;
		}				
</style>   
<body >
		<div id="navBar1">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
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
		
		<div class="title">				
				<img src="style/icon/65.gif" />
				<fmt:message key="BillingBG.query" />					
		</div>
		
		<div>
			<fieldset style="margin-left:20px;margin-right:20px;">
					<table id="listQtb" cellspacing="2px;" cellpadding="0" 
						style="width: 750px;border: 0px;float:left;">
						<tr>
							<td width="12%" align="right" >
								<label id="GdMonthg"><fmt:message key="rePrice.GdMonthg" /></label><!-- 话单月份 -->
							</td>
							<td width="22%" align="left" >
								<select name="GdMonth" id="GdMonth" style="width:150px;" onchange="return limitDate();"></select>							
							</td>
							
							<td width="12%" align="right" >
								<label id="time1g"><fmt:message key="rePrice.time1g" /></label><!-- 起始日期 -->
							</td>
							<td width="22%" align="left" >
								<!-- 
								<input type="text" name="time1" id="time1" onfocus="setPJTime('1')" ></input>
								 -->
								 <input type="text" name="time1" id="time1" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,isShowOthers:false,readOnly:true,minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'#F{$dp.$D(\'endDate\')}'})" ></input>								
							</td>

							<td width="12%" align="right">
								<label id="time2g"><fmt:message key="rePrice.time2g" /></label><!-- 截止日期 -->
							</td>
							<td width="20%" align="left" >
								<!-- 
								<input type="text" name=time2 id="time2" onfocus="setPJTime('2')" ></input>
								 -->	
								 <input type="text" name="time2" id="time2" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,isShowOthers:false,readOnly:true,minDate:'#F{$dp.$D(\'startDate\')}',maxDate:'#F{$dp.$D(\'endDate\')}'})" ></input>							
							</td>						
						</tr>
						<tr>
							<td width="12%" align="right" >
								<label id="dh1g"><fmt:message key="rePrice.dh1g" /></label><!-- 起始电话 -->
							</td>
							<td width="22%" align="left" >
								<input type="text" name="dh1" id="dh1"></input>								
							</td>

							<td width="12%" align="right">
								<label id="dh2g"><fmt:message key="rePrice.dh2g" /></label><!-- 截止电话 -->
							</td>
							<td width="20%" align="left" >
								<input type="text" name="dh2" id="dh2"></input>								
							</td>						
							<td width="12%" align="right" >
								<label id="hthg"><fmt:message key="rePrice.hthg" /></label><!-- 合同号 -->
							</td>
							<td width="22%" align="left" >
								<input type="text" name="hth" id="hth"></input>								
							</td>					
						</tr>
						<tr>
							<td width="12%" align="right" >
								<label id="zjjxg"><fmt:message key="rePrice.zjjxg" /></label><!-- 中继局向 -->
							</td>
							<td width="22%" align="left" >
								<input type="text" name="zjjx" id="zjjx"></input>								
							</td>

							<td width="12%" align="right">
								<label id="bjhmg"><fmt:message key="rePrice.bjhmg" /></label><!-- 被叫号码 -->
							</td>
							<td width="20%" align="left" >
								<input type="text" name="bjhm" id="bjhm"></input>								
							</td>						
							<td width="12%" align="right" >
								<label id="thlxg"><fmt:message key="rePrice.thlxg" /></label><!-- 通话类型 -->
							</td>
							<td width="22%" align="left" >
								<select name="thlx" id="thlx" style="width:150px;"></select>								
							</td>					
						</tr>	
						<tr>
							<td width="12%" align="right" >
								<label id="customg"><fmt:message key="rePrice.customg" /></label><!-- 自定义条件 -->
							</td>
							<td width="22%" align="left" colspan="5">
								<textarea rows="5" cols="105" name="custom" id="custom" onfocus="clearTextarea()" onblur="addTextarea()"></textarea>								
							</td>
						</tr>
						<tr>
							<td height="20"></td><td></td><td></td><td></td><td></td>
						</tr>
						<tr>
							<td align="center" cols="5">
								
							</td>
							<td></td>
							<td>
								<!--重新批价-->
								<button type="button" id="rePrice" name="rePrice" class="tsdbutton" onclick="submitQuery();" align="center">					
									<fmt:message key="rePrice.rePrice" /><!-- 重新批价 -->
								</button>
							</td>
							<td></td>
							<td></td>
						</tr>	
					</table>				
					</fieldset>
					
					  <div id="loading">
							<div style="height:40px"></div>
							<img src="style/images/public/loading.gif" />
							<br />
							<!-- 正在进行批价处理，请稍候 --><fmt:message key="rePrice.waitg" />……
							<br />
							<div id="ontimehzinfo" style="border-top:1px solid #ccc;max-heigth:400px;overflow-y:auto;">
							</div>
					  </div>
					  <div id="backgroundPopup"></div>	
		</div>	
<!-- 页面通用隐藏域 开始-->
		<div style="display: none">
			<form name="childform" id="childform">
				<input type="text" id="queryName" name="queryName" value=""
					style="display: none" />
				<input type="text" id="fusearchsql" name="fusearchsql"
					style="display: none" />
			</form>
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

			<input type="hidden" id="addright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="editfields" />
			<input type="hidden" id="delBright" />
			<input type="hidden" id="editBright" />
			<input type="hidden" id="exportright" />
			<input type="hidden" id="printright" />


			<!-- 用于写入日志 -->
			<input type="hidden" id="userloginip"
				value="<%=Log.getIpAddr(request)%>" />
			<input type="hidden" id="userloginid"
				value="<%=session.getAttribute("userid")%>" />
			<input type="hidden" id="thislogtime" value="<%=Log.getThisTime()%>" />
			<!-- 修改时保存原来数据的隐藏域 -->
			<input type="hidden" id="logoldstr" />
			<input type="hidden" id="useridd" value="<%=userid%>" />

			<!-- 打印报表 -->
			<input type='hidden' id='thisbasePath' value='<%=basePath%>' />

			<!-- 查询树信息存放 -->
			<input type="hidden" id='treepid' />
			<input type="hidden" id='treecid' />
			<input type="hidden" id='treestr' />
			<input type="hidden" id='treepic' />

			<input type="hidden" id="curDate"/>
			<input type="hidden" id="startDate"/>
			<input type="hidden" id="endDate"/>
			
			<input type="hidden" id="hidCustom" />
			
<!-- 页面通用隐藏域 结束-->			
	</body>
</html>
