﻿<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhoneModify.jsp
    Function:   电话功能修改
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；
     2010-11-03 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<title>电话功能修改</title>
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
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
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->		
		<script src="script/telephone/business/businesspublic.js" type="text/javascript" language="javascript"></script>
		<script src="script/telephone/business/phoneInstalled.js" type="text/javascript"></script>
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>	
		<script src="script/telephone/business/phone_kjbq_gh.js" type="text/javascript"></script>	
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
		<script src="plug-in/MultiSelect/jquery.bgiframe.min.js" type="text/javascript"></script>
		<script src="plug-in/MultiSelect/jquery.multiSelect.js" type="text/javascript"></script>			
		<link href="plug-in/MultiSelect/jquery.multiSelect.css" rel="stylesheet" type="text/css" />				
		<style type="text/css">
		#hthzftab tr td{line-height:26px;}
		#checkroutetype{
			width:400px;
			height:20px; 
		}
		</style>
   	  <script type="text/javascript">
       jQuery(document).ready(function()
	   {	    
		    $("#navBar").append(genNavv());
		    getinternation();	//businesspublic.js中  自动加载显示框 	
		    getdisabledtype();//加载设置不可编辑项
		    PageInitial();		    
		    ghPayMoney("p_editfunction");//通过修改功能标识查询一次性费用
		    gethide("p_editfunction");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
		    gettable();//默认加载固定费表格现实phone_kibq_gh.js函数中
		    getfufeitype();//付费类型	    
		    getinternetedit('p_editfunction');//加载页面下拉框		    
		    $("#ghSearchBox").select();
		    $("#ghSearchBox").focus();		    
		    ///电话杂费  终止日
			$("#ZFStartday").focus(function(){
				WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});
			$("#ZFEndday").focus(function(){
				WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});			
			//$("#Tfgn_yhdang").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');
			/*
			$("#newDhgn_tf").focus(function(){
							autoBlockForm('querysTfDhgn',5,'close',"#ffffff",false);//弹出面板							
			});
			*/	
			getTFGN();
			//做配置是否显示合同号月租编辑框
			var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tident='hthYz' and tsection='phonebusiness'");					 										
			if(res==""||res==undefined||res=='N'){
				$("#hthYZcontext").hide();
			}else{
				$("#hthYZcontext").show();
			}
			
			getPackages();//20160316 获取套餐，yyl add
			
			$("#bytcadd").attr("disabled","disabled");
			$("#bytcdels").attr("disabled","disabled");
	   });
	   
	   //设置不可编辑项
	   function getdisabledtype(){	   		
	   		$("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");
	   		$("#phonefeename").attr("disabled","disabled");
	   		$("#phonefeetype").attr("disabled","disabled");
	   		$("#newDhgn_tf").attr("disabled","disabled");	   			   		
	   }
	   	   
	   /*******
	   	* 清除被锁定账号
	   	* @param;
	   	* @return;
	  	********/
	   function unLockDh()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneDH.ifCanSouLi",6,"&OperID=" + userid + "&Func=1");
	   		ClearTmpData();	   			   			   	
	   }
	   
	   function ClearTmpData()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneService.POPEN",6,"&userid=" + userid);
	   }
	   	   
	   /*******
	   	* 转存临时数据
	   	* @param:Dh电话;
	   	* @return;
	  	********/
	   function TransTmpData(Dh)
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneService.TranTmp",6,"&userid=" + userid + "&dh=" + tsd.encodeURIComponent(Dh));
	   }
	   
	   function ClearTmpData()
	   {
	   		var userid = tsd.encodeURIComponent($("#userid").val());	   		
	   		executeNoQueryProc("PhoneService.POPEN",6,"&userid=" + userid);
	   }
	   
        	   
	   /*******
	   	* 从真实姓名对应的多个账户中选择要查询的账户
	   	* @param:Yhmc用户名称，Dh电话，Yhdz用户地址;
	   	* @return;
	  	********/
		function userChoose(Yhmc,Dh,Yhdz,hth)
		{loadSelectedPackages(Dh);	
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_editfunction")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][1]);
				return;
			}
			
			if($("#ghSearchWay").val()=="1")
			{
				$("#ghSearchBox").val(Yhmc);
			}
			else if($("#ghSearchWay").val()=="2")
			{
				$("#ghSearchBox").val(Yhdz);
			}
			else
			{
				$("#ghSearchBox").val(Dh);
			}
			$("#sAddress").val(Yhdz);		
			ghSerBasicInfo(Dh);		
			//ghZF(Dh);	
			gethTC(Dh);
			getdhBYTC(Dh);
			addspeediFeeType(Dh);			
			setTimeout("getphonefeename()",1);		
			//addspeediFeeType_hth(hth);//加载合同号月租	
				
			//loadSelectedPackages(Dh);	
	   		$("#phonefeename").removeAttr("disabled");
	   		$("#phonefeetype").removeAttr("disabled");
	   		$("#newDhgn_tf").removeAttr("disabled");	   		
			setTimeout($.unblockUI,1);
			Bytc_Modify_show(Dh);
		}
		
		/********
		*20160331 -mingl add 
		*加载完用户信息加载用户订购套餐信息
		*********/
		function loadSelectedPackages(Dh){
			var res = fetchMultiArrayValue("dbsql_phone.query_selected_rlns",6,"&Dh=" +Dh);
			var selectedPackageInfo ="";
			var index = 0;
			$("#bytctabs").empty();//已选中套餐id存放
			var packageIds = ",";
			if(undefined != res && "" != res){
				for(var i in res){//res[i][8]--套餐id
					index = i;
		      		packageIds +=(res[i][8]+",");
		      		//$("#hasSelectedPackageId").val(tctype);
		      		selectedPackageInfo += "<tr>";
					selectedPackageInfo += "<td width=\"10\"><center>";
					if(i != 0){//当前启用套餐不能被删除
						selectedPackageInfo += "<input type=\"checkbox\" id=\"v_bytctab_checks\"" + i + " />";
					}
					selectedPackageInfo += "</center></td>";
					selectedPackageInfo += "<td width=\"170\"><center>";
					selectedPackageInfo += res[i][0];//名称
					selectedPackageInfo += "</center></td>";
					selectedPackageInfo += "<td width=\"105\"><center>";
					/**1、包年
					2、包月
					3、按天
					4、包时长
					5、包流量
					6、默认标准资费套餐
					*/
					if(1 == res[i][1]){
						res[i][1]="包年";
					}else if(2 == res[i][1]){
						res[i][1]="包月";
					}else if(3 == res[i][1]){
						res[i][1]="按天";
					}else if(4 == res[i][1]){
						res[i][1]="包时长";
					}else if(5 == res[i][1]){
						res[i][1]="包流量";
					}else if(6 == res[i][1]){
						res[i][1]="标准资费";
					}else if(7 == res[i][1]){
						res[i][1]="兜底";
					}
					selectedPackageInfo += res[i][1];//类型
					selectedPackageInfo += "</center></td>";
					selectedPackageInfo += "<td width=\"100\"><center>";
					selectedPackageInfo += res[i][2];//固定费
					selectedPackageInfo += "</center></td>";
					selectedPackageInfo += "<td width=\"150\"><center>";
					selectedPackageInfo += res[i][3];//免费期数
					selectedPackageInfo += "</center></td>";
					selectedPackageInfo += "<td width=\"140\"><center>";
					selectedPackageInfo += res[i][4];//开始时间
					selectedPackageInfo += "</center></td>";
					selectedPackageInfo += "<td width=\"140\"><center>";
					selectedPackageInfo += res[i][5];//结束时间
					selectedPackageInfo += "</center></td>";
					selectedPackageInfo += "<tr>";
				}
				index ++;
			}
			$("#hasSelectedPackageId").val(packageIds);//已有的套餐id以,,隔开
			for(var n=0;n< 4-index;n++){
				selectedPackageInfo += "<tr>";
				selectedPackageInfo += "<td width=\"10\"><center>";
				selectedPackageInfo += ".";
				selectedPackageInfo += "</center></td>";
				selectedPackageInfo += "<td width=\"170\"><center>";
				selectedPackageInfo += "……";
				selectedPackageInfo += "</center></td>";
				selectedPackageInfo += "<td width=\"105\"><center>";
				selectedPackageInfo += "……";
				selectedPackageInfo += "</center></td>";
				selectedPackageInfo += "<td width=\"100\"><center>";
				selectedPackageInfo += "……";
				selectedPackageInfo += "</center></td>";
				selectedPackageInfo += "<td width=\"150\"><center>";
				selectedPackageInfo += "……";
				selectedPackageInfo += "</center></td>";
				selectedPackageInfo += "<td width=\"140\"><center>";
				selectedPackageInfo += "……";
				selectedPackageInfo += "</center></td>";
				selectedPackageInfo += "<td width=\"140\"><center>";
				selectedPackageInfo += "……";
				selectedPackageInfo += "</center></td>";
				selectedPackageInfo += "<tr>";
			}
			$("#bytctabs").append(selectedPackageInfo);
		}

		/*******
		 * 生成电话杂费feetype
		 * @param;
		 * @return;
	     ********/ 
        function getphonefeename()
        {        
           $("#phonefeetype").html("<option value=\"\">--"+$("#getinternet0365").val()+"--</option>");           
           var res = fetchMultiArrayValue("dbsql_phone.attachprice",6,"&jhjid="+$("#SwitchNumber").val()+"&dhlx="+tsd.encodeURIComponent($("#dhlx_yhdang").val()));
           if(res[0]==undefined || res[0][0]==undefined)
           {
							return false;
           }
           
           var querysel="";
				   for(var i=0;i<res.length;i++)
				   {
				       var ee="<option value='"+res[i][1]+"'>"+res[i][0]+"</option>";	
				       querysel+=ee;					
				   }
		
				   $("#phonefeetype").append(querysel);
        }
		
		/*******
		 * 根据费用类型取子项目
		 * @param;
		 * @return;
	     ********/
        function getfeename()
        {
        	var feename = $("#phonefeetype").val();
        	//删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
	        $("#phonefeenamecode").val("");
	        getGHcsnum("");
        	$("#phonefeename tr").css('background-color','#f7f7f7');
        	if(feename==""){feename='000000';}
        	var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'dbsql_phone.attachpricefeetype_tjxh'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});	
				var ghzfzfx='';
				$("#phonefeename").empty();	
				$.ajax({
					//url:'mainServlet.html?'+urlstr+"&feename="+tsd.encodeURIComponent(feename)+"&tj="+tsd.encodeURIComponent('停机保号')+"&xh="+tsd.encodeURIComponent('限呼保号'),					
					url:'mainServlet.html?'+urlstr+"&feename="+tsd.encodeURIComponent(feename)+"&tj="+tsd.encodeURIComponent("<fmt:message key="phone.getinternet0247" />")+"&xh="+tsd.encodeURIComponent("<fmt:message key="phone.getinternet0248" />"),
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
								if($(this).attr("feetype")!=undefined){
		                 			ghzfzfx +="<tr onClick=\"getGHfeetr('"+$(this).attr("feetype")+"');getGHcsnum('"+$(this).attr("csnum")+"');\" id=\""+$(this).attr("feetype")+"\"><td>";
		                 			ghzfzfx +="☞"+$(this).attr("feetype");
		                 			ghzfzfx +="</td></tr>";
		                 		}
							});
							$("#phonefeename").append(ghzfzfx);
					}
				});
				$("#feelv").val("");
				$("#TJfeelv").val("");	
        }
                
		
		/*******
	   	* 点击保存拼接参数执行过程修改电话功能操作
	   	* @param;
	   	* @return;
	  	********/
		function updateGH()
		{
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;
		 	var params='';
		 	/*
				area	depart userid phone qjtkj  
				ableTo cIsPay cPayType cYingJiao cShiShou  
				cPayItem  cLianXiRen  cLianXiDianHua danweiHTHbox   danweiHTH  
				phonepkBz
			*/
			//获取参数
			//区域
			var area = $("#area").val();
			var userareaid = $("#userareaid").val();
			//部门
			var depart = $("#depart").val();
			//工号
			var userid = $("#userid").val();
			
			//电话
			var phone = $("#Dh_yhdang").val();
			//如果phone为空，必查询一下
			if(phone=="")
			{
				//alert("请选择要办理该项业务的电话号码");
				alert("<fmt:message key="phone.getinternet0176" />");
				$("#ghSearchBox").select();
				$("#ghSearchBox").focus();
				return false;
			}
			
			var sgn = $("#Dhgn").val();
			var xgn = $("#newDhgn").val();			
			/*
			if(xgn=="")
			{
				alert("请选择要更改的电话功能");
				$("#newDhgn_tf").select();
				$("#newDhgn_tf").focus();
				return false;
			}*/
			if(sgn==xgn)
			{
				//alert("新电话功能没有更改，无需保存");				
				alert("<fmt:message key="phone.getinternet0226" />");
				$("#newDhgn_tf").select();
				$("#newDhgn_tf").focus();
				return false;
			}						
			var resYZ = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tsection='phonebusiness' and tident='selectMonthlyRent'"); 
			if(resYZ==""||resYZ==undefined||resYZ=="Y"){
				if(isXinYeWuExists(phone)==0)
				{
					//alert("至少应该添加一项月租费");
					alert("<fmt:message key="phone.getinternet0034" />");
					$("#phonefeetype").select();
					$("#phonefeetype").focus();
					return false;
				}
			}
			if(isXinYeWuExists(phone)==2)
		    {
		      	//alert("已经存在一项月租费，不能多次添加");
		      	alert("<fmt:message key="phone.getinternet0227" />");
		      	return false;
		    }
					
			//付费方式
			var cPayType = $("#cPayType").val();				
			//应缴费
			var cYingJiao = $("#cYingJiao").val().replace(/(^\s*)|(\s*$)/g,"");
			if(cYingJiao==""){cYingJiao=0;}
			//实缴费
			/*
			var cShiShou = $("#cShiShou").val().replace(/(^\s*)|(\s*$)/g,"");
			if(cShiShou==""){cShiShou=0;}
			*/
			//费用项目
			var cPayItem = $("#cPayItem").val();
			cYingJiao = parseFloat(cYingJiao,10);
			//cShiShou = parseFloat(cShiShou,10);	
			if(cYingJiao==0){cPayItem="";}
			//if(cYingJiao!=0&&cShiShou==0){alert("请输入实缴费用！");$("#cShiShou").select();$("#cShiShou").focus();return false;}
			//联系人
			var cLianXiRen = $("#Bz8_yhdang").val();
			//联系电话
			var cLianXiDianHua = $("#Bz9_yhdang").val();
			
			//备注
			var phonepkBz = $("#phonepkBz").val().replace(/(^\s*)|(\s*$)/g,"");
			params+="&Area="+tsd.encodeURIComponent(area);
			params+="&userarea="+tsd.encodeURIComponent(userareaid);			
			params+="&Depart="+tsd.encodeURIComponent(depart);
			params+="&UserID="+tsd.encodeURIComponent(userid);
			params+="&Dhh="+tsd.encodeURIComponent(phone);
			params+="&ispay="+tsd.encodeURIComponent(cPayType);
			params+="&yjfee="+tsd.encodeURIComponent(cYingJiao);			
			//params+="&sjfee="+tsd.encodeURIComponent(cShiShou);
			params+="&feename="+tsd.encodeURIComponent(cPayItem);
			params+="&lxr="+tsd.encodeURIComponent(cLianXiRen);
			params+="&lxdh="+tsd.encodeURIComponent(cLianXiDianHua);		
			params+="&sdhgn="+tsd.encodeURIComponent(sgn);
			params+="&xdhgn="+tsd.encodeURIComponent(xgn);
			params+="&chth="+tsd.encodeURIComponent($("#Hth").val());			
			params+="&zwbz="+tsd.encodeURIComponent(phonepkBz);
			
			//20160331 -mingl -add 获取新旧套餐的id
			var pIds = $("#hasSelectedPackageId").val();
			if(pIds.length >1){//选中有套餐
				pIds = pIds.substring(1, pIds.length-1);
				if(pIds.indexOf(",")>-1){//如果有分号是两个套餐
					var pIdsArry = pIds.split(",");
					params+="&oldPackageId="+pIdsArry[0];
					params+="&newPackageId="+pIdsArry[1];
				}else{
					params+="&oldPackageId="+pIds;
				}
			}
			///修改存储过程YWSL_XGGN
			
		 	var loginfo = "<fmt:message key="phone.getinternet0421" />:";//电话修改功能
			loginfo += "(<fmt:message key="phone.getinternet0103" />:";
			loginfo += phone;
			loginfo += ")(<fmt:message key="phone.getinternet0422" />:";//呼出权限
			loginfo += sgn;
			loginfo += ")(<fmt:message key="phone.getinternet0420" />:";
			loginfo += xgn;
			loginfo += ")(<fmt:message key="phone.getinternet0381" />:";
			loginfo += area;
			loginfo += ")(<fmt:message key="phone.getinternet0396" />:";
			loginfo += userid+")";
			loginfo = tsd.encodeURIComponent(loginfo);
			params+="&ywbz="+loginfo;
			params+="&YwArea="+$("#YwArea_yhdang").val();
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			var result = fetchMultiPValue("PhoneService.XGGN",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
			{
				//alert("办理修改功能业务失败");
				alert("<fmt:message key="phone.getinternet0228" />");
			}
			else
			{
				$("#jobidid").val(result[0][0]);
				$("#ppaytype").val(cPayType);
				$("#fee").val(cYingJiao);
				writeLogInfo("","modify",loginfo);
				$("#ghSearchBox").select();
			    $("#ghSearchBox").focus();
				//判断是否打印工单，从tsd_ini表中配置Y为打印
				printworkorder('p_editfunction');//script/telephone/business/businessreprint.js中
				//页面还原
				pageReset();
			}
		}
		
		    /********
           	*查看是否存在新业务
           	*@param：（dh：电话）;
       	  	*@return返回值false存在新业务，true不存在新业务
			*@feename=1 月租
          	********/
		    function isXinYeWuExists(dh)
		    {
		    	var result = fetchSingleValue("phonelnstalled.xinyewualreadyexists",6,"&Dh=" + dh+"&feename=1");
		    	if(result=="0")
		    	{
		    		return 0;
		    	}
		    	else if(result=="1")
		    	{
		    		return 1;
		    	}
		    	else
		    	{
		    		return 2;
		    	}
		    }

		/*******
	   	* 页面重置
	   	* @param;
	   	* @return;
	  	********/
		function pageReset()
		{
			$(":text").val("");
			$("#tablehthdang :text").val("");
        	$("#tablehthdang select").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();
			$("#dhBYTC").empty();
			$("#cPayType").val("cash");
			$("#danweiHTHbox").removeAttr("checked");		
			ghPayMoney("p_editfunction");//通过修改功能标识查询一次性费用
			gethide("p_editfunction");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数		
			$("#dhzftab").empty();				
			unLockDh();//清除锁定
			refreshbusinessfee();
			gettable();//默认加载固定费表格现实phone_kibq_gh.js函数中
			addspeediFeeType('');
			$("#phonefeetype").val("");
			getfeename();
			getdisabledtype();//加载设置不可编辑项
		}						
       	       	
       	/*******
	   	* 判但起始时间是否大于截至时间
	   	* @param:parm为起始时间，params为截至时间;
	   	* @return;
	  	********/
	    function gettimeday(parm,params)
	    {
	       var result;
	       var res = fetchMultiArrayValue("phonelnstalled.getstartendtime",6,"&starttime="+parm+"&endtime="+params);
	       result = res[0][0];
	       return result;
	    }
		
		function getDhgcparam(){
			if($("#newDhgn").val()==""){
				alert("请选择呼出权限！");
				$("#newDhgn").select().focus();
				return;
			}
			var multistr='';
			//var mulselectoper = obj.rows[i].mulselectoper;
			$("[name='Tfgn_yhdang'][checked]").each(function(){
				multistr +=$(this).val()+",";			
			}) ; 
			//var len = multistr.lastIndexOf(mulselectoper);
			//if(len>0){multistr = multistr.substr(0,len);}
			$("#newDhgn_tf").val(multistr+$("#newDhgn").val());
			closeGB();
		}
		
		function getTFGN(){
	   		var languageType = $("#languageType").val();
	        $.ajax({
					url:"phone_querydate?func=query",
					async:true,//异步
					cache:false,
					timeout:20000,//1000表示1秒
					type:'post',
					success:function(xml,textStatus)
					{
					    var dhgn = xml.substring(xml.indexOf("<dhgn=")+6,xml.indexOf("dhgn/>"));
						$("#newDhgn").html(dhgn);
					}		
				});
		}	
    </script>   
	</head>
       
	<body onUnload="unLockDh()">
		<input type='hidden' id='userloginip'
			value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid'
			value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		<div id="navBar1">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							：
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message
									key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="broadband_frame">
			<div id="input-Unit">
				<div class="title" style="display: none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0178" /><!-- 输入查询条件 -->
				</div>
				<div id="inputtext">
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								<fmt:message key="phone.getinternet0179" /><!-- 查询方式 -->
								<select id="ghSearchWay" style="width: 100px;" >
									<option value="0">
										<fmt:message key="phone.getinternet0103" /><!-- 电话 -->
									</option>
									<option value="1">
										<fmt:message key="phone.getinternet0180" /><!-- 用户名 -->
									</option>
									<option value="2">
										<fmt:message key="phone.getinternet0113" /><!-- 用户地址-->
									</option>
								</select>
							</td>
							<td>
								<input type="text" class="" id="ghSearchBox" name="ghSearchBox" />
							</td>
							<td>
								<button class="tsdbutton" id="submitButton" onClick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
								</button>
							</td>
							<td width="290"></td>
						</tr>
					</table>
				</div>
				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0229" /><!--电话功能 -->
				</div>
				<div id="inputtext1">
					<table width="760" cellspacing="10px" id="changedhgn">
						<tr>
							<td width="15%" align="right">
								原电话功能
							</td>
							<td>
								<input type="text" id="TrafficLevel" name="TrafficLevel" disabled="disabled" style="width:200px" class="you1" />
							</td>
							<td width="15%" align="right">
								新电话功能
							</td>
							<td>
								<select id="newDhgn" style="width:200px" class="you1"></select>
							</td>
						</tr>
					</table>
				</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0082" /><!-- 固定费 -->
				</div>
				<table>
					<tr>
						<td valign="top">
						  <table>
						  	<tr>
						  		<td class="wenzi" style="width:60px;line-height:30px;">
										<span id="spanFeeName"></span>
										<!-- 费用代号 -->
								</td>
								<td>
										<select name="phonefeetype" id="phonefeetype" style="width: 157px;"
											onchange="getfeename()"></select>										
								</td>
							</tr>
							<tr>
								<td colspan="2">
						  			<div style="width:220px; height: 160px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
											<table id="phonefeename" style="width:230px;" border="1" cellpadding="0"></table>
									</div>
						  		</td>
							</tr>
						  </table>
					 	 </td>
				 	 	 <td class="wenzi" style="width:45px;">
				 	 		<table cellspacing="1">
				 	 			<tr>
				 	 				<td width=1% style="margin-left: 0px;"></td>
				 	 			</tr>				  				
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="dhzfsave"
										onclick="insertphonefeename()"
										style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
										<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="dhzfdel"
										onclick="deletephonefeename()"
										style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
										<fmt:message key="phone.getinternet0084" /><!-- 取消 -->
										</button></center>
				  					</td>
				  				</tr>
				 	 		</table>
				 	 	</td>
				 	 	<td valign="top">				 	 	    
				 	 		<table id="dzhthcontent"  style="width:490px;">
				 	 			<tr>
									<th width="10"><input type="checkbox" id="dhzftab_checkall" onClick="Dhzf_CheckAll()" style="width:15px;" /></th>
									<th width="200">
										<center>
											<h4>
												<span id="spanFeeType_table"></span>
											</h4>
										</center>
									</th>
									<th width="60">
										<center>
											<h4>
												<span id="spanPrice_table"></span>
												<!-- 费率 -->
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												<span><fmt:message key="phoneyewu.starttime" /></span>
												<!-- 起始时间 -->
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												<span><fmt:message key="phoneyewu.termination" /></span>
												<!-- 终止时间 -->
											</h4>
										</center>
									</th>
									<%-- <th width="75">
										<center>
											<h4>
												数量
											</h4>
										</center>
									</th>
									<th width="75">
										<center>
											<h4>
												长度
											</h4>
										</center>
									</th> --%>
								</tr>
				 	 		</table>
				 	 		<div style="width:500px; height: 165px; overflow-y: scroll; overflow-x: hidden;">
				 	 		<table id="dhzftab" style="width:490px;">
								
							</table>							
							</div>
				 	 	</td>
					 </tr>
					 <tr>
					 	<td>
					 	<div style="display:none;width: 420px; height: 20px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="addspeediFeetype">
							
						</table>
					    </div>
					  </td>
					 </tr>
				</table>
				<table cellspacing="8" id="ghfeeinput">
				</table>
				<!-- 固话费用隐藏值放此处点击新增按钮将其添加到临时表显示出来 --> 	
				<table style="display:none">
					<tr>
						<td>
						<input type="hidden" id="feecode" name="feecode" style="width: 150px;" disabled="disabled" /><!-- 费用代号 -->
						<input type="hidden" id="phonefeenamecode" name="phonefeenamecode"/><!-- 子费用 -->
						<input type="hidden" id="feelv" name="feelv" style="width:150px" disabled="disabled" /><!-- 费率 -->
						<input type="hidden" id="TJfeelv" name="TJfeelv" style="width: 150px;" disabled="disabled" /><!-- 停机费率 -->
						<input type="hidden" id="ZFStartday" name="ZFStartday" style="width: 150px;" disabled="disabled" value="<%=Log.getSysTime() %>"/><!-- 起始时间 -->
						<input type="hidden" id="ZFEndday" name="ZFEndday" style="width: 150px;" disabled="disabled" value="2999-12-31"  /><!-- 终止时间 -->						
						<input type="hidden" id="CUNIT" name="CUNIT"/><!--最小计费单位-->
						</td>	
					</tr>	
				</table>
				
				<!--合同号月租-->
				<table id="hthYZcontext" style="display: none;">
					<tr>
						<td valign="top">
						  <table>
						  	<tr>
						  		<td class="wenzi" style="width:60px;line-height:30px;">
										合同号月租
								</td>
								<td>
									<select name="phonefeetype_hth" id="phonefeetype_hth" style="width: 150px;" onChange="getfeename_hth()"></select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
						  			<div style="width:210px; height: 160px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
											<table id="phonefeename_hth" style="width:230px;" border="1" cellpadding="0"></table>
									</div>
						  		</td>
							</tr>
						  </table>
					 	 </td>
				 	 	 <td class="wenzi" style="width:45px;">
				 	 		<table cellspacing="1">
				 	 			<tr>
				 	 				<td width=1% style="margin-left: 0px;"></td>
				 	 			</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="dhzfsave"
										onclick="insertphonefeename_hth()"
										style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
										新增>><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="dhzfdel"
										onclick="deletephonefeename_hth()"
										style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
										取消<!-- 取消 -->
										</button></center>
				  					</td>
				  				</tr>
				 	 		</table>
				 	 	</td>
				 	 	<td valign="top">				 	 	    
				 	 		<table id="dzhthcontent"  style="width:490px;">
				 	 			<tr>
									<th width="10"><input type="checkbox" id="hthzftab_checkall" onClick="hthZf_CheckAll()" style="width:15px;" /></th>
									<th width="200">
										<center>
											<h4>
												子类型
											</h4>
										</center>
									</th>
									<th width="60">
										<center>
											<h4>
												价格
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												<span>起始时间</span>
												<!-- 起始时间 -->
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												<span>终止时间</span>
												<!-- 终止时间 -->
											</h4>
										</center>
									</th>
									<th width="140">
										<center>
											<h4>
												合同号
											</h4>
										</center>
									</th>
								</tr>
				 	 		</table>
				 	 		<div style="width:500px; height: 165px; overflow-y: scroll; overflow-x: hidden;">
				 	 		<table id="hthzftab" style="width:490px;">
 
							</table>							
							</div>
				 	 	</td>
					 </tr>
					 <tr>
					 	<td>
					 	<div style="display:none;width: 420px; height: 20px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="addspeediFeetype_hth">
							
						</table>
					    </div>
					  </td>
					 </tr>
				</table>
				<table cellspacing="8" id="hthfeeinput">
				</table>
				<!-- 固话费用隐藏值放此处点击新增按钮将其添加到临时表显示出来 --> 	
				<table style="display:none">
					<tr>
						<td>
						<input type="hidden" id="feecode_hth" name="feecode" style="width: 150px;" disabled="disabled" /><!-- 费用代号 -->
						<input type="hidden" id="phonefeenamecode_hth" name="phonefeename"/><!-- 子费用 -->
						<input type="hidden" id="feelv_hth" name="feelv_hth" style="width:150px" disabled="disabled" /><!-- 费率 -->
						<input type="hidden" id="Subtype_hth" name="Subtype_hth" />
						<input type="hidden" id="ZFStartday_hth" name="ZFStartday" style="width: 150px;" disabled="disabled" value="2012-07-28"/><!-- 起始时间 -->
						<input type="hidden" id="ZFEndday_hth" name="ZFEndday" style="width: 150px;" disabled="disabled" value="2999-12-31"  /><!-- 终止时间 -->						
						</td>	
					</tr>	
				</table>
				
				<!-- 修改套餐div开始 -->
				<div id='setBYPkg_frame2'>
			    <div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneyewu.bytcsz" />
					<!-- 包月套餐设置 -->
				</div>
				<table>
					<tr>
						<td>
						  <table>
							  <!--  	<tr>
							  		<td class="wenzi" align="right" style="width:65px;line-height:30px;">
										套餐
									</td>
									<td>
										<select name="Packaggroupid" id="Packaggroupid" style="width: 153px;" onchange="getPackagetypes()">
										</select>
									</td>
								</tr>
							-->	
							<tr>
								<td colspan="2">
						  			<div style="width:210px; height: 108px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7; border:1px 1px solid #dddddd;">
										<table id="Packagetypes" style="width:225px;" border="1" cellpadding="0">
										</table>
									</div>
						  		</td>
						  		<td>
						  			<input type="hidden" id="Packagetypeshidden"/><!-- 包月套餐费用项值提交到临时时取该值进行保存 -->
						  			<input type="hidden" id="hasSelectedPackageId"/><!-- 已选中套餐id拼接 -->
						  		</td>
							</tr>
						  </table>
					 	 </td>
				 	 	 <td class="wenzi" style="width:45px;">				 	 	 
				 	 		<table cellspacing="1">
				 	 			<tr>
				 	 				<td width=1% style="margin-left: 0px;"></td>
				 	 			</tr>				 	 							  				
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcadd" 
											onclick="Bytc_Modify()"
											style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcdels" 
											onclick="Bytc_Modify_Dels()"
											style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0084" /><!-- 取消 -->
										</button></center>
				  					</td>
				  				</tr>
				 	 		</table>
				 	 	</td>
				 	 	<td valign="top">				 	 		
				 	 		<table id="dzhthcontent"  style="width:640px;">
				 	 			<tr>
									<th width="10"><input type="checkbox" id="bytctab_checkalls" onclick="Bytc_CheckALL('tc')" style="width:15px;" /></th>
									<th width="170">
										<center>
											<h4>
												<span id="spanTCLX_tables">套餐名称</span>
											</h4>
										</center>
									</th>
									<th width="105">
										<center>
											<h4>
												<span id="spanTCLX_tables"><fmt:message key="phone.getinternet0087" /><!-- 套餐类型 --></span>
												<!-- 套餐类型 -->
											</h4>
										</center>
									</th>
									<th width="100">
										<center>
											<h4>
												<span id="spanTCLX_tables">固定费</span>
											</h4>
										</center>
									</th>
									<th width="150">
										<center>
											<h4>
												<span id="spanTCLX_tables">包月费免费期数</span>
											</h4>
										</center>
									</th>
									<th width="140">
										<center>
											<h4>
												<span id="spanTCQSY_tables"><fmt:message key="phone.getinternet0088" /><!-- 起始时间 --></span>
												<!-- 起始月 -->
											</h4>
										</center>
									</th>
									<th width="140">
										<center>
											<h4>
												<span id="spanTCZZY_tables"><fmt:message key="phone.getinternet0089" /><!-- 终止时间 --></span>
												<!-- 终止月 -->
											</h4>
										</center>
									</th>
								</tr>
				 	 		</table>
				 	 		<div style="width:640px; height: 120px; overflow-y: scroll; overflow-x: hidden;">
					 	 		<table id="bytctabs" style="width:640px;" >
									
								</table>
							</div>
				 	 	</td>
					 </tr>
					 <tr>
					 	<td>
					 	<div style="display:none;width: 420px; height: 20px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="addspeediFeetypes">
						</table>
					    </div>
					  </td>
					 </tr>
				</table>
				<!--  --><table cellspacing="8" >
					<tr>
				  		<td><fmt:message key="phone.getinternet0088" /><!-- 起始时间 --></td>
				  		<td><input type="text" name="TCStarttimes" id="TCStarttimes" 
							style="width: 100px;"  value="<%=Log.getSysTime() %>" disabled="disabled"/></td>
				  		<td><fmt:message key="phone.getinternet0089" /><!-- 终止时间 --></td>
				  		<td><input type="text" name="TCEndtimes" id="TCEndtimes" 
									style="width: 100px;" value="2999-12-31" disabled="disabled"/></td>
						<td>
							<!--<button id="dzpkg" onclick="getDZblock()"  class="tsdbutton"  style="margin-left: 20px;">打折</button>-->
						</td>	
						<td>
							<!--<input type="text" id="pkg_rateStr" disabled="disabled"/>-->
						</td>		
				    </tr>					
				</table>
			 </div>
			<!-- 修改套餐div结束 -->
				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<span id="feetdhypetext"></span>
					</div>
					<div id="inputtext">
						<div class="midd">
							<table>
								<tr>
									<td class="wenzi">
										<span id="spanyucunYE"></span>
										<!--出帐月余额/出帐月欠费 -->
									</td>
									<td class="wenzix">
										<input type="text" id="phoneBalance" name="phoneBalance"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="spanxinyueHF"></span>
										<!-- 实施余额/实施欠费 -->
									</td>
									<td class="wenzix">
										<input type="text" id="mothshuafei" name="mothshuafei"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="yhdang_tjbz"></span>
									</td>
									<td class="wenzix">
										<input type="text" id="Tjbz_yhdang" name="Tjbz_yhdang" style="width: 150"
											disabled="disabled" />
									</td>
								</tr>							
								<tr style="display:none">
									<td class="wenzi">
										<span id="spanDhgn"></span>
										<!-- 电话功能 -->
									</td>
									<td>
										&nbsp;<select name="Dhgn" id="Dhgn"
											style="width: 150"></select>
									</td>
									<td>
										<span id="spanJhj_IDx"></span>
										<!-- 交换机编号 -->
									</td>
									<td>
										<input type="text" name="SwitchNumber" id="SwitchNumber"
											style="width: 150;display:;" disabled="disabled" />
									</td>
									<td>
										<fmt:message key="phone.getinternet0181" /><!-- 停机标志 -->
									</td>
									<td>		
										<select id="Tjbz_yhdang" name="Tjbz_yhdang"></select>							
									</td>
								</tr>
								<tr></tr>
							</table>
						</div>
					</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0182" /><!-- 合同号信息显示-->&nbsp;<input type="checkbox" id="hthshowcheck" onClick="getshow()" style="width:15px;" />
					</div>
					<div id="inputtext">
						<div class="midd">
							<table id="tablehthdang" style="width:780px;">
							</table>
						</div>
					</div>	
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0183" /><!--固话信息显示-->&nbsp;<input type="checkbox" id="yhdangshowcheck" checked="checked" onClick="getshow()" style="width:15px;" />
					</div>
					<div id="inputtext">
						<div class="midd">
							<table id="tableyhdang" style="width:780px;"></table>
						</div>
					</div>
				<div class="title" style="display:none">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0185" /><!--优惠套餐信息显示-->
				</div>
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhTCX"
					width="780" style="display:none">

				</table>
				<div class="title" style="display: none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0186" /><!--包月套餐信息显示-->&nbsp;<input type="checkbox" id="byfeeshowcheck" onClick="getshow()" style="width:15px;" /><span id="byfeeTips" style="color:red"></span>
					</div>
				 <table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhBYTC" width="780">
				 </table>
				<div class="title" id="busifeetemplate">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneyewu.yewuggnmqr" /><!--业务更改内容确认--><span id="businesschangecontent" style="color:red;"></span>
				</div>
				<div id="inputtext1">
					<table cellspacing="0" width="760" id="businesschange">
				 		<tr>
				 			<td style="width:460px;">
				 				<table id="ffltab" style="width:460px;">
								<tr>
									<td class="wenzi" style="width:70px;">
										<fmt:message key="phone.getinternet0090" /><!-- 付费方式 -->
									</td>
									<td class="wenzix">
										<select name="cPayType" id="cPayType" style="width: 150px" class="you1" onChange="payWayChange(this)"></select>
									</td>
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="cYingJiao" id="cYingJiao" style="width: 130px;" disabled="disabled"  class="you1" onKeyPress="numValid(this)"
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false"/>
								   </td>
								   <td>
								     <table id="dzhthcontent" style="width:330px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
									   <tr>
											<th width="200">
										    	<center>
											    <h4>
											     <fmt:message key="phone.getinternet0092" /><!-- 业务受理费 -->
											    </h4>
											    </center>
											</th>
											<th width="100">
											    <center>
												<h4>
												<fmt:message key="phone.getinternet0093" /><!-- 费用金额 -->
												</h4>
												</center>
											</th>
										</tr>
									 </table>
									</td>	
								</tr>
								<tr>
									<td colspan="4">
									<fmt:message key="phone.getinternet0094" /><!-- 一次性费用 -->：
									<div
									style="width:440px; height: 105px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
									<div id="feeItem_s" style="width: 100%; float: left;">
									</div>
									</div>
									</td>
									<td valign="top">
									<table id="businessfee" style="width:330px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
									
									</table>
									</td>
								</tr>	
								<tr>
									<td class="wenzi" style="display:none;">
										<fmt:message key="phone.getinternet0095" /><!-- 缴费款项 -->
									</td>
									<td colspan="3" class="wenzix" style="display:none;">
										<input type="text" name="cPayItem" id="cPayItem"
											style="width:260px" disabled="disabled" class="you1" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
					</table>
					<hr style="border: 1px dotted #CCCCCC;" />
					<table cellspacing="3" style="background-color:#f7f7f7">
				       <tr>
				         <td>
						    <table cellspacing="0" style="display:none;">
								<tr>
									<td>
										<input type='checkbox' name="danweiHTHbox" id="danweiHTHbox"
											style="width: 22px; padding: 0px;" disabled="disabled" onClick="isnotdanwei()" />
									</td>
									<td>
										&nbsp;&nbsp;&nbsp;&nbsp;
										<font color="red"><fmt:message key="phoneyewu.isnotdwff" /><!-- 是否单位付费 --></font>
									</td>
									<td>
										<fmt:message key="phoneyewu.dwHTH" /><!-- 单位合同号 -->
									</td>
									<td>
										<input type="text" name="danweiHTH" id="danweiHTH"
											style="width: 150" disabled="disabled" />
									</td>
								</tr>
							</table>
				         </td>				        
				         <td>
				           <table cellspacing="8">
				              <tr>
				                <!-- <td valign="top"> -->
				                <td>
				                  &nbsp;&nbsp;<fmt:message key="phone.getinternet0187" /><!--业务备注-->
				                </td>
				                <td>
				                  <textarea name="phonepkBz" id="phonepkBz" rows="4" cols="110" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea>
				                </td>
				              </tr>
				           </table>
				         </td>
				      </tr>				      
				    </table>
				</div>
			</div>
			<div id="buttons">
				<center>
					<button id="save" onClick="updateGH()" style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onClick="pageReset()" style="margin-left: 20px;">
						<!-- 重置 -->
						<fmt:message key="AddUser.Reset" />
					</button>
				</center>
			</div>
		</div>

		<div class="neirong" id="operform"
			style="display: none; overflow-x: hidden; width: 600px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.getinternet0188" /><!--单位合同号查询-->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#operformClose').click();"><fmt:message key="phone.getinternet0189" /><!--关闭--></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; height: 260px; overflow-y: scroll;">
				<table border="1" cellpadding="0" bordercolor="#9AC0CD"
					id="queryHTHdw">

				</table>
			</div>
			<div class="midd_butt" style="width: 100%;">
				<button id="save" class="tsdbutton" onClick="getinputHTH()"
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button type="button" class="tsdbutton" onClick="closeGB();"
					id="operformClose">
					<fmt:message key="phone.getinternet0189" /><!--关闭-->
				</button>
			</div>
		</div>
		<div class="neirong" id="multiSearch"
			style="display: none; overflow-x: hidden;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.getinternet0232" /><!--电话修改功能业务用户信息查询-->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#kdMultiSearchClose').click();"><fmt:message key="phone.getinternet0189" /><!--关闭--></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: left;">
				<div id="grid" style="margin-top: 0px;"></div>
			</div>
			<div class="midd_butt" style="width: 100%;">
				<button type="button" class="tsdbutton" id="kdMultiSearchClose">
					<fmt:message key="phone.getinternet0189" /><!--关闭-->
				</button>
			</div>
		</div>
		
		<!-- 弹出报表打印框 -->	
		<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
		<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
		<input type="hidden" id="userid" value="<%=userid%>" />
		<input type="hidden" id="area" value="<%=area%>" />
		<input type="hidden" id="depart" value="<%=depart%>" />
		<input type="hidden" id="userareaid" value="<%=userareaid%>" />
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<input type="hidden" id="languageType" value="<%=languageType%>" />
		<input type='hidden' id='userloginip'
			value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid'
			value='<%=session.getAttribute("userid")%>' />
		<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
		<input type="hidden" id="startdate" value="<%=Log.getSysTime() %>"/><!-- 固定费用起始日期 -->
		<input type="hidden" id="useridright" name="useridright" />
		<input type="hidden" id="feenameid" name="feenameid" />
		<input type="hidden" id="inputDWHTH" name="inputDWHTH" />
		<input type="hidden" id="Subtype" name="Subtype" />
		<input type="hidden" id="reportparam" />
		<input type="hidden" id="jobidid" />
		<input type="hidden" id="ppaytype" />
		<input type="hidden" id="fee" />
		<input type="hidden" id="TrafficLevel_to"/>
		<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
		<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->
		<input type="hidden" id="fufeitypepath"/>
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->	
		<input type="hidden" id="stiffbusinestype" value="phoneXGGN"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<input type="hidden" id="dhlx_yhdang"/>
		<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
