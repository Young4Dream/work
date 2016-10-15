<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhoneHFZJ.jsp
    Function:   电话恢复装机
    Author:     wenxuming
    Date:       2010-10
    Description: 
    Modify: 
     2010-10月份 对该页面进行移植，并对版式进行修改；
     2010-11-03 把公用的CSS提取出来放到style/css/telephone/business/businesspublic.css；
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<title>电话恢复拆机业务</title>
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
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>		
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript">
       jQuery(document).ready(function()
	   {	    
	    $("#navBar").append(genNavv());
	    getinternation();	//businesspublic.js中  自动加载显示框	    
	    PageInitial();
	    ghPayMoney('p_replyphone');	 //通过恢复装机标识查询一次性费用 
	    gethide("p_replyphone");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
	    getfufeitype();//付费类型	  
	    $("#ghSearchBox").select();
	    $("#ghSearchBox").focus();
	    $("#tablehthdang select").attr("disabled","disabled");
		$("#tablehthdang :text").attr("disabled","disabled");
		$("#tableyhdang select").attr("disabled","disabled");
		$("#tableyhdang :text").attr("disabled","disabled");
		//$("#precheck").attr("disabled","disabled");
	   }); 
	   	   
	   /*********
		* 清除被锁定账号
		* @param;
		* @return;
	    **********/
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
	   	   
	   /*********
		* 从真实姓名对应的多个账户中选择要查询的账户
		* @param：Yhmc用户名称，Dh电话，Yhdz用户地址;
		* @return;
	    **********/
		function userChoose(Yhmc,Dh,Yhdz)
		{
			if(!fetchHCJ(Dh))
			{
				return;
			}
			
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_replyphone")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][1]);
				return;
			}
			
			//判断是否完工
			var res = fetchSingleValue("dbsql_phone.getteljobwgrq",6,"&dh="+Dh);
			if(res>0){
				//alert("对不起，该电话未完工！！！");
				alert("<fmt:message key="phone.getinternet0163" />");
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
			$("#phone").val(Dh);
			$("#sAddress").val(Yhdz);		
			//$("#precheck").removeAttr("disabled");
			ghSerBasicInfo(Dh);			
			ghZF(Dh);
			gethTC(Dh);
			getdhBYTC(Dh);
			setTimeout($.unblockUI,1);
		}
				
		/*********
		* 取拆机必须保留的余额
		* @param;
		* @return;
	    **********/
		function fetchHCJ(Dh)
		{
			var result = fetchMultiArrayValue("PhoneHFZJ.checkCj",6,"&Dh=" + Dh);
			if(result[0]==undefined || result[0][0]==undefined)
			{
				//alert("该用户没有拆机记录或已过可恢复时限");			
				alert("<fmt:message key="phone.getinternet0218" />");
				return false;
			}			
			if(result[0][0]=="delete")
			{
				//$("#currentStatus").val("拆机");
				$("#currentStatus").val("<fmt:message key="phone.getinternet0219" />");
				//$("#destStatus").html("<option value=\"\">恢复拆机</option>");
				$("#destStatus").html("<option value=\"\"><fmt:message key="phone.getinternet0220" /></option>");
				return true;
			}
			
			//alert("该用户没有拆机记录或已过可恢复时限");			
			alert("<fmt:message key="phone.getinternet0218" />");
			return false;
		}
				
		/*********
		* 点击保存拼接参数调用过程执行回复装机操作
		* @param;
		* @return;
	    **********/
		function updateGH()
		{
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
			//判断是否可以办理该业务
			if(!fetchHCJ(phone))
			{
				return false;
			}
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
						
			//付费方式
			var cPayType = $("#cPayType").val();			
			
			//var cIsPay = $("#cIsPay").val();			
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
			if(isNaN(cYingJiao)) cYingJiao = 0;
			//if(isNaN(cShiShou)) cShiShou = 0;
			//if(cYingJiao!=0&&cShiShou==0){alert("请输入实缴费用！");$("#cShiShou").select();$("#cShiShou").focus();return false;}
			var szt = $("#currentStatus").val();
			var xzt = $("#destStatus").val();
			//联系人
			var cLianXiRen = $("#Bz8_yhdang").val().replace(/(^\s*)|(\s*$)/g,"");			
			//联系电话
			var cLianXiDianHua = $("#Bz9_yhdang").val().replace(/(^\s*)|(\s*$)/g,"");		
			//备注
			var phonepkBz = $("#phonepkBz").val().replace(/(^\s*)|(\s*$)/g,"");
			if(phonepkBz==null||phonepkBz==""){
				//alert("请输入备注！");
				alert("<fmt:message key="phone.getinternet0160" />");
				$("#phonepkBz").focus();
				return false;
			}
			//预存款 去掉预存款项，想要预存到应收界面操作
		   /*  var prechecked= $("#precheck").attr("checked");
			if(prechecked){
			       	var Prefee = $("#Prefee").val();
			       	Prefee=Prefee.replace(/(^\s*)|(\s*$)/g,"");	        	
			       	var confee = $("#confee").val();
			       	confee=confee.replace(/(^\s*)|(\s*$)/g,"");	        	
			        if(Prefee.length==0){
			        	//alert("请输入预存金额");
			        	alert("<fmt:message key="phone.getinternet0035" />");
			        	$("#Prefee").select();
			        	$("#Prefee").focus();
			        	return;
			        }	        	
			        if(confee.length==0){
			        	//alert("请输入确认金额");
			        	alert("<fmt:message key="phone.getinternet0036" />");
			        	$("#confee").select();
			        	$("#confee").focus();
			        	return;
			        }
			        Prefee=parseFloat(Prefee,10);
			        confee=parseFloat(confee,10);
			        if(Prefee!=confee){
			        	//alert("预存金额与确认金额不一致！");
			        	alert("<fmt:message key="phone.getinternet0037" />");
			        	$("#confee").select();
			        	$("#confee").focus();
			        	return;
			        }			        
			        var patrn=/^-?\d+\.{0,}\d{0,}$/; 
					 if (!patrn.exec(Prefee)){
					 	//alert("请输入正确的金额！");
					 	alert("<fmt:message key="phone.getinternet0038" />");
					 	$("#Prefee").select();
					 	$("#Prefee").focus();
					 	return false;
					 }
					params += "&ycfee=";
					params += tsd.encodeURIComponent(Prefee);
					params += "&sfyc=";
					params += tsd.encodeURIComponent('Y');  
		    } */			
			params+="&Area="+tsd.encodeURIComponent(area);
			params+="&userarea="+tsd.encodeURIComponent(userareaid);					
			params+="&Depart="+tsd.encodeURIComponent(depart);
			params+="&UserID="+tsd.encodeURIComponent(userid);
			params+="&Dhh="+tsd.encodeURIComponent(phone);			
			params+="&szt="+tsd.encodeURIComponent(szt);
			params+="&xzt="+tsd.encodeURIComponent(xzt);		
			params+="&ispay="+tsd.encodeURIComponent(cPayType);
			//params+="&yjfee="+tsd.encodeURIComponent(cYingJiao);			
			//params+="&sjfee="+tsd.encodeURIComponent(cShiShou);
			params+="&feename="+tsd.encodeURIComponent(cPayItem);
			params+="&lxr="+tsd.encodeURIComponent(cLianXiRen);
			params+="&lxdh="+tsd.encodeURIComponent(cLianXiDianHua);		
			params+="&zwbz="+tsd.encodeURIComponent(phonepkBz);
			params+="&Hthhth="+tsd.encodeURIComponent($("#Hth").val());
			params+="&IDCard="+tsd.encodeURIComponent($("#IDCard").val());	
			params+="&Yhxz="+tsd.encodeURIComponent($("#Yhxz").val());	
			params+="&Yhlb="+tsd.encodeURIComponent($("#Yhlb").val());
			
		 	var loginfo = "<fmt:message key="phone.getinternet0416" />:";//电话恢复装机
			loginfo += "(<fmt:message key="phone.getinternet0103" />:";
			loginfo += phone;	
			loginfo += ")(<fmt:message key="phone.getinternet0381" />:";			
			loginfo += area;
			loginfo += ")(<fmt:message key="phone.getinternet0396" />:";			
			loginfo += userid+"))";
			//loginfo += ")(<fmt:message key="phone.getinternet0097" />:";//预存金额			
			//loginfo += Prefee+")";
			loginfo = tsd.encodeURIComponent(loginfo);
			params+="&ywbz="+loginfo;
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}						
			var result = fetchMultiPValue("PhoneService.HF",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1'||result[0][0]=="")
			{				
				//alert("恢复拆机业务失败");
			    alert("<fmt:message key="phone.getinternet0221" />");
			}
			else
			{
				$("#jobidid").val(result[0][0]);
				if(result[0][1]!=""&&result[0][1]!="SUCCSESS"){
					alert(result[0][1]);
					loginfo+=tsd.encodeURIComponent(result[0][1]);
				}
				$("#ppaytype").val(cPayType);
				$("#fee").val(cYingJiao);
				//判断是否打印工单，从tsd_ini表中配置Y为打印
				$("#Prefeeval").val($("#Prefee").val());
				printworkorder('p_replyphone');//script/telephone/business/businessreprint.js中
				writeLogInfo("","modify",loginfo);
				$("#ghSearchBox").select();
			    $("#ghSearchBox").focus();
				//页面还原
				pageReset();
			}
		}
		
		/*********
		* 重置页面
		* @param;
		* @return;
	    **********/
		function pageReset()
		{
			$(":text").val("");
			$("#tablehthdang :text").val("");
        	$("#tablehthdang select").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");
        	//$("#precheck").attr("disabled","disabled");
        	//$("#precheck").removeAttr("checked");
        	//$("#Prefee").attr("disabled","disabled");
			//$("#confee").attr("disabled","disabled");
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();
			$("#dhBYTC").empty();
			$("#destStatus").empty();
			$("#cPayType").val("cash");
			$("#Prefee").val("");
			$("#confee").val("");
			$("#danweiHTHbox").removeAttr("checked");			
			ghPayMoney('p_replyphone');	 //通过恢复装机标识查询一次性费用							
			unLockDh();//清除锁定
			refreshbusinessfee();
			gethide("p_replyphone");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
		}
		
		/********************
			* 回车事件
			* @param;
			* @return;
			*********************/
		  function preKey(event){
                    if(event.keyCode==13){
                        $("#confee").val($("#Prefee").val());
                        $("#confee").select();
                        $("#confee").focus();
                        return false;
                    }
                }
    </script>
    <script language="javascript">       
        /*********
		* 选择用户所在区域
		* @param;
		* @return;
	    **********/     
        function getuserareato(){
          var uareato="";
            var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.getuserarea'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              uareato="";
					              $("#seluserarea").empty();			       
					                $(xml).find('row').each(function(){	
					                  var xuhao = $(this).attr("Xuhao");
					                  var ywarea = $(this).attr("YwArea");
					                  if(ywarea!=undefined){
							            var ee="<option value='"+xuhao+"'>"+ywarea+"</option>";
							            uareato=uareato+ee;								       
								      }
							        });								        				       						        				       						        
							        $("#c_p_address_seluserarea").html($("#c_p_address_seluserarea").html()+uareato);					       
							      }
							});
        }
           	
		/*********
		* 取当前查询电话的包月套餐信息
		* @param:Dh电话;
		* @return;
		**********/
		function gethTC(Dh)
		{
			var res = fetchMultiArrayValue("PhonemoveAddress.dhTC",6,"&dh="+Dh);	
			//判断包月套餐信息是否有数据，没有的话直接退出不做处理
			if(res[0]==undefined ||res[0][0]==undefined)
			{
				return false;
			}
			var zfInfo = "";
			zfInfo += "<tr>";
			zfInfo += "<td>";
			//zfInfo += "费用名称";
			zfInfo += "<fmt:message key="phone.getinternet0153" />";
			zfInfo += "</td>";
			zfInfo += "<td>";
			//zfInfo += "套餐类型";
			zfInfo += "<fmt:message key="phone.getinternet0087" />";
			zfInfo += "</td>";
			zfInfo += "<td>";
			//zfInfo += "起始时间";
			zfInfo += "<fmt:message key="phoneyewu.starttime" />";
			zfInfo += "</td>";
			zfInfo += "<td>";
			//zfInfo += "终止时间";
			zfInfo += "<fmt:message key="phoneyewu.termination" />";
			zfInfo += "</td>";
			zfInfo += "<td>";
			//zfInfo += "月数";
			zfInfo += "<fmt:message key="phone.getinternet0222" />";
			zfInfo += "</td>";
				zfInfo += "</tr>";
			
			for(var i=0;i<res.length;i++)
			{
				zfInfo += "<tr>";
					zfInfo += "<td>";
					zfInfo += res[i][0];
					zfInfo += "</td>";
					zfInfo += "<td>";
					zfInfo += res[i][1];
					zfInfo += "</td>";
					zfInfo += "<td>";
					zfInfo += res[i][2];
					zfInfo += "</td>";
					zfInfo += "<td>";
					zfInfo += res[i][3];
					zfInfo += "</td>";
					zfInfo += "<td>";
					zfInfo += res[i][4];
					zfInfo += "</td>";
				zfInfo += "</tr>";
			}
			$("#dhTCX").html(zfInfo);			
			$("#dhTCX tr:eq(0)").css("font-weight","700");
		}
		
		/********************
			* 判断是否预存金额，来判断是否金额只读
			* @param;
			* @return;
			*********************/
			function getprecheck(){
		  		var prechecked= $("#precheck").attr("checked");
		  		var hthvalue = $("#Dh_yhdang").val();
		  		hthvalue=hthvalue.replace(/(^\s*)|(\s*$)/g,"");	
		  		if(hthvalue==""){
		  			//alert("请选择要办理该项业务的电话号码");
					alert("<fmt:message key="phone.getinternet0176" />");
		  			$("input[id^='precheck']").removeAttr("checked");
		  			return false;
		  		}
		  		if($("#Yhlb").val().replace(/(^\s*)|(\s*$)/g,"")=="<fmt:message key="phone.getinternet0384" />"){
		  			$("input[id^='precheck']").removeAttr("checked");
		  			//alert("公费用户不能预存话费！");
		  			alert("<fmt:message key="phone.getinternet0068" />");
		  			return false;
		  		}
		  		if(prechecked){
		  				$("#Prefee").removeAttr("disabled");
		  				$("#confee").removeAttr("disabled");
		  				$("#Prefee").select();
		  				$("#Prefee").focus();
		  		}else{
		  				$("#Prefee").attr("disabled","disabled");
		  				$("#confee").attr("disabled","disabled");
		  				$("#Prefee").val("");
		  				$("#confee").val("");
		  		}
		  }
    </script>
	</head>
       
	<body onunload="unLockDh()">
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
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0178" /><!-- 输入查询条件 -->
				</div>
				<div id="inputtext">
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								<fmt:message key="phone.getinternet0179" /><!-- 查询方式 -->
								<select id="ghSearchWay" style="width: 100px;">
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
								<button class="tsdbutton" id="submitButton" onclick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
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
					<fmt:message key="phone.getinternet0195" /><!-- 变更内容 -->
				</div>
				<div id="inputtext">
					<table width="560" cellspacing="10px">
						<tr>
							<td>
								<fmt:message key="phone.getinternet0223" /><!-- 当前状态-->
							</td>
							<td>
								<input type="text" name="currentStatus" id="currentStatus" disabled />
							</td>
							<td>
								<fmt:message key="phone.getinternet0224" /><!-- 可办理业务-->
							</td>
							<td>
								<select name="destStatus" id="destStatus" style="width:180px;" disabled></select>
							</td>
						</tr>
					</table>
				</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<span id="feetdhypetext"></span>
					</div>
				<div id="inputtext">
						<div class="midd">
							<br>
							<table>
								<tr>
									<td class="wenzi">
										<span id="spanyucunYE"></span>
										<!--出帐月余额/出帐月欠费 -->
									</td>
									<td>
										<input type="text" id="phoneBalance" name="phoneBalance"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="spanxinyueHF"></span>
										<!-- 实施余额/实施欠费 -->
									</td>
									<td>
										<input type="text" id="mothshuafei" name="mothshuafei"
											value="0" style="width: 150" disabled="disabled" />
									</td>
									<td class="wenzi">
										<span id="yhdang_tjbz"></span>
									</td>
									<td>
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
											style="width: 150;display:none;" disabled="disabled" />
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
					<fmt:message key="phone.getinternet0182" /><!-- 合同号信息显示-->&nbsp;<input type="checkbox" id="hthshowcheck" onclick="getshow()" style="width:15px;" />
					</div><br>
					<div id="inputtext">
						<div class="midd">
							<table id="tablehthdang" style="width:780px;">
							</table>
						</div>
					</div>	
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0183" /><!--固话信息显示-->&nbsp;<input type="checkbox" id="yhdangshowcheck" checked="checked" onclick="getshow()" style="width:15px;" />
					</div><br>
					<div id="inputtext">
						<div class="midd">
							<table id="tableyhdang" style="width:780px;"></table>
						</div>
					</div>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0184" /><!--固定费信息显示-->&nbsp;<input type="checkbox" id="gdfeeshowcheck" onclick="getshow()" style="width:15px;" /><span id="gdfeeTips" style="color:red"></span>
				</div>
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhZFX"
					width="780">

				</table>
				<div class="title"  style="display:none">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0185" /><!--优惠套餐信息显示-->
				</div>
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhTCX"
					width="780" style="display:none">
				</table>
				<%-- <div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0186" /><!--包月套餐信息显示-->&nbsp;<input type="checkbox" id="byfeeshowcheck" onclick="getshow()" style="width:15px;" /><span id="byfeeTips" style="color:red"></span>
					</div>
				 <table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhBYTC" width="780">
				 </table> --%>
				<div class="title">
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
										<select name="cPayType" id="cPayType" style="width: 150px" class="you1" onchange="payWayChange(this)"></select>
									</td>
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="cYingJiao" id="cYingJiao" style="width: 130px;" disabled="disabled"  class="you1" onkeypress="numValid(this)"
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
								<table cellspacing="10" style="display:none;">
									<tr>
										<td>
											<input type='checkbox' name="danweiHTHbox" id="danweiHTHbox"
												style="width: 22px; padding: 0px;" disabled="disabled" onclick="isnotdanwei()" />
										</td>
										<td>
											<font color=red>请选择单位合同号</font>
										</td>
									</tr>
									<tr>
										<td>
											单位合同号：
										</td>
										<td>
											<input type="text" name="danweiHTH" id="danweiHTH"
												style="width: 150" disabled="disabled" />
										</td>
									</tr>
								</table>
							</td>
							<td>
								<%-- <table cellspacing="5">
									<tr>
										<td>&nbsp;&nbsp;<font color='red'><fmt:message key="phone.getinternet0096" /><!-- 是否预存款 --></font></td>
										<td colspan=2><input type="checkbox" id="precheck" name="precheck" onclick="getprecheck();"/></td>
									</tr>	
									<tr>	
										<td>&nbsp;&nbsp;<fmt:message key="phone.getinternet0097" /><!-- 预存金额 -->&nbsp;&nbsp;</td>
										<td><input type="text" name="Prefee" id="Prefee" style="width:130px" disabled="disabled" onkeydown="return preKey(event)" onkeypress="numValid(this)"
											onpaste="return !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false"/>￥</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="phone.getinternet0098" /><!-- 确认金额 -->&nbsp;&nbsp;</td>
										<td><input type="text" name="confee" id="confee" style="width:130px" disabled="disabled" onkeypress="numValid(this)"
											onpaste="return !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false"/>￥</td>
									</tr>
								</table> --%>
								</td>
								<td>
									<table cellspacing="8">
										<tr>
										    <td valign="top">
												<fmt:message key="phoneyewu.memo" />：
												<!-- 备注 -->												
											</td>
										</tr>
										<tr>
											<td><textarea name="phonepkBz" id="phonepkBz" rows="4" cols="60" style="width:600px;" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea></td>	
										</tr>
									</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="buttons">
				<center>
					<button id="save" onclick="updateGH()" style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onclick="pageReset()" style="margin-left: 20px;">
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
				<button id="save" class="tsdbutton" onclick="getinputHTH()"
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button type="button" class="tsdbutton" onclick="closeGB();"
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
							<fmt:message key="phone.getinternet0225" /><!--电话恢复折机业务用户信息查询-->
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
		<input type="hidden" id="useridright" name="useridright" />
		<input type="hidden" id="feenameid" name="feenameid" />
		<input type="hidden" id="inputDWHTH" name="inputDWHTH" />
		<input type="hidden" id="Subtype" name="Subtype" />
		<input type="hidden" id="reportparam" />
		<input type="hidden" id="jobidid" />
		<input type="hidden" id="ppaytype" />
		<input type="hidden" id="fee" />
		<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
		<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
		<input type="hidden" id="fufeitypepath"/>
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
		<input type="hidden" id="stiffbusinestype" value="phoneGNBG"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
