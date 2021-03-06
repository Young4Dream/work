﻿<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/phonebatchinstalle.jsp
    Function:   电话批量装机
    Author:     chenze
    Date:       2010-12
    Description: 
    Modify: 
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String depart = (String) session.getAttribute("departname");
	String userareaid = (String) session.getAttribute("userarea");
	String username = (String) session.getAttribute("username");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
	SimpleDateFormat formatto = new SimpleDateFormat("yyyy-MM-dd");
	Date now = new Date();
	String nowTime = format.format(now);
	String nowTimeto = formatto.format(now);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<!--  <base href="<%=basePath%>"> -->
		<title>My JSP 'phoneInstalled.jsp' starting page</title>
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<!-- <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />-->
		<!-- <link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />-->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<!--<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>-->
		<!--<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>-->
		<!--<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>-->
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css"/>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<!--<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>-->
		<!--<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />-->
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css"/>	
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>		
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
		<!-- 页面权限控制 -->
        <script type="text/javascript" src="script/public/tsdpower.js"></script>
		<script src="script/telephone/business/pkgPriceDiscount.js" type="text/javascript" language="javascript"></script>	
        <!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>
		<script src="script/telephone/business/phoneInstalled.js" type="text/javascript"></script>	
		<script src="plug-in/MultiSelect/jquery.bgiframe.min.js" type="text/javascript"></script>
		<script src="plug-in/MultiSelect/jquery.multiSelect.js" type="text/javascript"></script>			
		<link href="plug-in/MultiSelect/jquery.multiSelect.css" rel="stylesheet" type="text/css" />	
		<style type="text/css">
		#checkroutetype{
			width:400px;
			height:20px; 
		}
		</style>
		<style type="text/css">
		#dqueryHTHdw tr td{line-height:22px;}
		#dqueryHTHdw tr th{line-height:25px;}
		#Paymenttable tr td{line-height:22px;}
		#selecththkey tr td{line-height:27px;};
		#querybmcontext tr td{line-height:25px;}
		#businessfee tr td{line-height:27px;}		
		.wenzixtcz {width:125px;} 
		</style>
		<script type="text/javascript">	
			/*********
			* 初始加载
			* @param;
			* @return;
		    **********/
			 jQuery(document).ready(function(){
		 		$("#navBar").append(genNavv());		    	
		    	lodingpage();//异步获取加载页面提示，其中包括加载数据等在此方法中完成phoneInstalled.jsp中
		    	getUserPower();//权限
		    	gettable();//默认加载固定费跟包月费显示框						 										
				var phonestr="请选择一个电话空号！";
				getTFGN();
				$("#Tfgn_yhdang").multiSelect({ oneOrMoreSelected: '*'},'','checkroutetype','~');	
				$("#Dhlx").removeAttr("disabled");	
				var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&tablename=tsd_ini&cloum=tvalues&key=tident='setShows' and tsection='phonebusiness'"); 										
				var arrayRes="";
				var arrayShow="";
				if(res!=""&&res!=undefined){
					arrayRes=res.split('|');
					for(var i=0;i<arrayRes.length;i++){
						arrayShow=arrayRes[i].split(':');
						if(arrayShow[1]=="false"){
							$("#"+arrayShow[0]+"").hide();
						}else{
							$("#"+arrayShow[0]+"").show();
						}
						
					}				
				}
				
				//根据电话类型获取固定费
				$("#Dhlx").change(function(){
						getphonefeename($("#SwitchNumber").val());
						getfeename();
				});
				$("#usertype").change(function(){
					//根据用户类别如果为个人自动生成合同号
							if($("#usertype").val()=="2"){
								GenerateHth();
							}
				});
			$("#inputYhdang,#setYGDF_frame,#setBusinesContext_frame,#buttons").hide();
		});	
			
		function getTFGN(){
	   		//clearMultiSelect();//清空多选下拉框
	   		var res = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&cloum=tfname&tablename=TFGN&key=1=1");
		 	if(res!=undefined&&res!=""){
		 		var str="<option value=''>--<fmt:message key="phone.getinternet0280" />--</option>";
			 	for(var j=0;j<res.length;j++){
			 		str+="<option value='"+res[j][0]+"'>"+res[j][0]+"</option>"
			 	}
			 	$("#Tfgn_yhdang").html(str);
		 	}else{
		 		$("#Tfgn_yhdang").html("<option value=''>--is null--</option>");
		 	}						
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
			$("#Dhgn_yhdang").val(multistr+$("#newDhgn").val());
			closeGB();
		}
			
		/*******
		*弹出空号查询框
		*@param;
		*@return;
		********/
		function c_p_konghaoDialog_all()
		{		
			if($("#Hth_hthdang").val()==""){
				alert("请选择或生成一个合同号");
				return;
			}		
			tsd.QualifiedVal=true;
			var param = "";
			param += "Dhlx=";
			param += tsd.encodeURIComponent($("#Dhlx").val());
			param += "&startDH=";
			param += tsd.encodeURIComponent($("#startDH_phone").val());
			param += "&endDh=";
			param += tsd.encodeURIComponent($("#endDh").val());
			param +="&hth="
			param +=tsd.encodeURIComponent($("#Hth_hthdang").val());
			param += "&imenuid=";			
			param += tsd.encodeURIComponent($("#imenuid").val());
			if(tsd.Qualified()==false){return false;}
			window.showModalDialog("mainServlet.html?pagename=telephone/business/Two_all.jsp?"+param+"&getnullarea="+$('#konghaoarearight').val(),window,"dialogWidth:500px; dialogHeight:450px; center:yes; scroll:no");
		}	
			
			/*******
        	*选取空号后回调函数
        	*@param;
       	 	*@return;
        	********/
			function c_p_feedBack(phoneNum,mokuaiju,jhj_id,ywarea,selbz)
			{
				if($("#Hth_hthdang").val()==""){alert("<fmt:message key="phone.getinternet0447" />");return;}
				$("input[id^='number_d']").removeAttr("checked");
				$("#startnum").attr("disabled","disabled");
				$("#endnum").attr("disabled","disabled");
				$("#startnum").val("");
				$("#endnum").val("");							
				getphonefeename(jhj_id);//根据选取空号表中的交换机ID来查询电话杂费
				//顶部电话输入
				$("#getphone").val(phoneNum);
				//取空号时电话,原先默认为选中号码中最大的号码默认为账单电话，现修改为操作员实际选择的号码中最大的号码默认为账单电话
				//$("#Dh_yhdang").val(phoneNum);
				//$("#Dh_hthdang").val(phoneNum);			
				$("#SwitchNumber").val(jhj_id);			
				var querypassword = phoneNum.substring(1,7);
				$("#Mima_yhdang").val(querypassword);
				$("#toMima_yhdang").val(querypassword);					
				//newadd selbz
				$("#selbz").val(selbz);//将电话通信站标识存入隐藏于
				$("#mokuaiju").val(mokuaiju);//将电话模块局存入隐藏于
				$("#MokuaiJu_yhdang").val(mokuaiju);
				$("#Mima_yhdang").val(querypassword);	
				$("#YwArea_yhdang").val($("#userareaid").val());
				$("#Bz3_yhdang").val($("#area").val());
				$("#StartDate_yhdang").val('2999-12-31');
				$("#EndDate_yhdang").val('2999-12-31');
				var userid = $('#userid').val();
				$("#tableyhdang select").removeAttr("disabled");
				$("#tableyhdang :text").removeAttr("disabled");
				$("#Dh_yhdang").attr("disabled","disabled");
				$("#ZFEndday").removeAttr("disabled");
				$("#ZFStartday").removeAttr("disabled");
				$("#TCEndtime").removeAttr("disabled");
				$("#TCStarttime").removeAttr("disabled");
				$("#TCEndtimes").removeAttr("disabled");
				$("#TCStarttimes").removeAttr("disabled");
				$("#StartDate_yhdang").attr("disabled","disabled");
				$("#EndDate_yhdang").attr("disabled","disabled");
				$("#Reg_Date").attr("disabled","disabled");
				$("#Hth_hthdang").attr("disabled","disabled");
				//$("#Dh_yhdang").attr("disabled","disabled");
				$("#Hth_yhdang").attr("disabled","disabled");
				$("#Dh_hthdang").attr("disabled","disabled");				
				$("#Yhlb_hthdang").attr("disabled","disabled");
				$("#Tjbz_yhdang").val('K');
				gettable();
				$("#Tjbz_yhdang").attr("disabled","disabled");
				//$("#UserType_yhdang").attr("disabled","disabled");				
				//根据配置权限时刻可以对计费起始，计费终止，装机日期进行可编辑
				if($("#statrtimeright").val()=="false"){
					$("#StartDate_yhdang").attr("disabled","disabled");
				}else{
					$("#StartDate_yhdang").removeAttr("disabled");
				}
				if($("#stoptimeright").val()=="false"){
					$("#EndDate_yhdang").attr("disabled","disabled");
				}else{
					$("#EndDate_yhdang").removeAttr("disabled");
				}
				if($("#zjtimeright").val()=="false"){
					$("#Reg_Date_yhdang").attr("disabled","disabled");
				}else{
					$("#Reg_Date_yhdang").removeAttr("disabled");
				}
				getPowertrue();//获取权限值进行判断
				getZJtime();
				getfeename();					
				
				if($("#Dh_hidden").val()!=""){
					getcheckphonecontent($("#Dh_hidden").val());
					executeNoQuery("dbsql_phone.insertattachfee_tmpnew",6,"&dh="+$("#Dh_yhdang").val()+"&userid="+$("#userid").val()+"&dhtow="+$("#Dh_hidden").val());
					addspeediFeeType($("#Dh_hidden").val());//获取固定费					
					executeNoQuery("dbsql_phone.insertallbusinessfee",6,"&dh=0"+"&userid="+$("#userid").val()+"&dhtow="+$("#Dh_hidden").val());
					queryFeename_batc($("#Dh_hidden").val());
				}else{
					getbusinessDefault();//设置默认值	
				}
				$("#Dh_yhdang").val(phoneNum);
				getdhcountvalue();//刷新归档电话
			}		

		function Dhzj_Save()
        {        	
        	///////////////////////////////////////////////////////////////////        				
			$("#Messagevalues").text("<fmt:message key="phone.getinternet0023" />");	
           ///////////////////////////////////////////////////////////////////           
           tsd.QualifiedVal=true;
           var procparams = "";
			//自身合同号
			var chth = $("#hth").val();
				if(chth=="")
				{
					$("#usertype").select();
					$("#usertype").focus();
					alert("<fmt:message key="phone.getinternet0025" />");
					return false;
				}   
			var resyhdang_tmp = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1) as cont&tablename=yhdang_tmp&key=userid='"+$("#userid").val()+"' and opertype='true'");
            if(resyhdang_tmp<=0){
            	alert("请选择归档装机的用户！");
            	return;
            }    
            var languageType = $("#languageType").val(); 
		    var Dat = loadData_phoneinstalled("Hthdang",languageType,2);
		    var reszh = fetchFieldAlias('Hthdang',languageType);			 
			 for(var i=0;i<Dat.FieldName.length;i++){
			 	var strhth = $("#"+Dat.FieldName[i]+"_hthdang").val();
			 	if(strhth!=undefined){
			 		strhth = strhth.replace(/(^\s*)|(\s*$)/g,"");
			        	if(strhth==""&&Judgefield_hthdang(Dat.FieldName[i]+"_hthdang")==true&&$("#"+Dat.FieldName[i]+"_hthdang").attr("disabled")!=true)
			        	{
			        		alert("<fmt:message key="phone.getinternet0026" />"+reszh[Dat.FieldName[i]]+"<fmt:message key="phone.getinternet0027" />");
			        		$("#"+Dat.FieldName[i]+"_hthdang").select();
			        		$("#"+Dat.FieldName[i]+"_hthdang").focus();
			        		return false;
			        		break;
			        	}
		        	}
		        if(strhth==null){strhth="";}	
			 	procparams += "&"+Dat.FieldName[i]+"hth="+tsd.encodeURIComponent(strhth);
			 }
			 
			var languageType = $("#languageType").val();
			var Dat = loadData_phoneinstalled("Yhdang",languageType,2);
			 var reszh = fetchFieldAlias('Yhdang',languageType);								
			 for(var i=0;i<Dat.FieldName.length;i++){
				var stryhdang = $("#"+Dat.FieldName[i]+"_yhdang").val();
				if(stryhdang!=undefined){
					stryhdang = stryhdang.replace(/(^\s*)|(\s*$)/g,"");
						if(stryhdang==""&&Judgefield_yhdang(Dat.FieldName[i]+"_yhdang")==true&&$("#"+Dat.FieldName[i]+"_yhdang").attr("disabled")!=true)
						{
							alert("<fmt:message key="phone.getinternet0031" />"+reszh[Dat.FieldName[i]]+"<fmt:message key="phone.getinternet0027" />");
							$("#"+Dat.FieldName[i]+"_yhdang").select();
							$("#"+Dat.FieldName[i]+"_yhdang").focus();
							return false;
							break;
						}
					}
				if(stryhdang==null){stryhdang="";}		
				procparams += "&"+Dat.FieldName[i]+"yhdang="+tsd.encodeURIComponent(stryhdang);
			 }
			 var cDocumentsNumber = $("#Bz7_yhdang").val();
			 if(cDocumentsNumber!=undefined){
					cDocumentsNumber=cDocumentsNumber.replace(/(^\s*)|(\s*$)/g,"");
					if($("#Bz6_yhdang").val()=="<fmt:message key="phone.getinternet0345" />" && cDocumentsNumber!="" && !/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(cDocumentsNumber))
					{
						alert("<fmt:message key="phone.getinternet0032" />");
						$("#Bz7_yhdang").select();
						$("#Bz7_yhdang").focus();
						return false;
					}
			 }
				//合同号一级部门
				var chthbm1 = $("#sBm1").val();
				/*
				if($("#usertype option:selected").text()=="<fmt:message key="phone.getinternet0384" />"&&$("#sBm1").val()=="")
				{
					alert("<fmt:message key="phone.getinternet0028" />");
					//return false;
				}
				*/
				procparams += "&chthbm1=";
				procparams += tsd.encodeURIComponent(chthbm1);
				//合同号二级部门
				var chthbm2 = $("#sBm2").val();
				procparams += "&chthbm2=";
				procparams += tsd.encodeURIComponent(chthbm2);
				//合同号三级部门        	
				var chthbm3 = $("#sBm3").val();
				procparams += "&chthbm3=";
				procparams += tsd.encodeURIComponent(chthbm3);
				//合同号二级部门        	
				var chthbm4 = $("#sBm4").val();
				procparams += "&chthbm4=";
				procparams += tsd.encodeURIComponent(chthbm4);
				var Email = $("#Email_hthdang").val();//邮件地址  
				if(Email!=undefined){
					Email=Email.replace(/(^\s*)|(\s*$)/g,"");	
					var emailRegExp = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
					if ((!emailRegExp.test(Email)||Email.indexOf('.')==-1)&&Email!=""){
						alert("<fmt:message key="phone.getinternet0029" />");
						$("#Email_hthdang").select();
						$("#Email_hthdang").focus();
						return false;
					}
				}	
				var IDCard = $("#IDCard_hthdang").val();		        	
				if(IDCard!=undefined){
					IDCard=IDCard.replace(/(^\s*)|(\s*$)/g,"");
					if(IDCard!=""&&!/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(IDCard))
					{
						alert("<fmt:message key="phone.getinternet0030" />");
						$("#IDCard_hthdang").select();
						$("#IDCard_hthdang").focus();
						return false;
					}
				}
		        //付费方式
		       	var jfufeitype = $("#fufeitype").val();
		       	procparams += "&jfufeitype=";
				procparams += tsd.encodeURIComponent(jfufeitype);	
		       	//应缴费用
		       	var jyjfee = $("#yjfee").val();
		       	jyjfee=jyjfee.replace(/(^\s*)|(\s*$)/g,"");
		       	if(jyjfee==""){jyjfee=0;}
		       	procparams += "&jyjfee=";
				procparams += tsd.encodeURIComponent(jyjfee);			
		       	//实收费用
		       	/*
		       	var jfflsjfy = $("#fflsjfy").val();
		       	jfflsjfy=jfflsjfy.replace(/(^\s*)|(\s*$)/g,"");
		       	if(jfflsjfy==""){jfflsjfy=0;}
		       	procparams += "&jfflsjfy=";
				procparams += tsd.encodeURIComponent(jfflsjfy);*/				       
		       	//缴费款项
		       	var jPaymoney = $("#Paymoney").val();
		       	procparams += "&jPaymoney=";
				procparams += tsd.encodeURIComponent(jPaymoney);
				jyjfee = parseFloat(jyjfee,10);
				//jfflsjfy = parseFloat(jfflsjfy,10);	
				if(jyjfee==0){jPaymoney="";}
				//if(jyjfee!=0&&jfflsjfy==0){alert("请输入实缴费用！");$("#fflsjfy").select();$("#fflsjfy").focus();return false;}	 			
		       	//联系人
		       	var jffllxh = $("#staff_ry").val();
		       	procparams += "&jffllxr=";
				procparams += tsd.encodeURIComponent(jffllxh);			
				//检测一次费用 (必填一项类)
				//if(!checkYCXFY()) return false;
		       	//联系电话
		       	var jffllxdh = $("#ffllxdh").val();
		       	procparams += "&jffllxdh="+jffllxdh;
		        procparams += "&fsbm=";
				procparams += tsd.encodeURIComponent($("#fsbm").val());
		        //预存款
		       	var prechecked= $("#precheck").attr("checked");
			    if(prechecked){
			       	var Prefee = $("#Prefee").val();
			       	Prefee=Prefee.replace(/(^\s*)|(\s*$)/g,"");	        	
			       	var confee = $("#confee").val();
			       	confee=confee.replace(/(^\s*)|(\s*$)/g,"");	        	
			        if(Prefee.length==0){alert("<fmt:message key="phone.getinternet0035" />");$("#Prefee").select();$("#Prefee").focus();return false;}	        	
			        if(confee.length==0){alert("<fmt:message key="phone.getinternet0036" />");$("#confee").select();$("#confee").focus();return false;}
			        if(Prefee!=confee){alert("<fmt:message key="phone.getinternet0037" />");$("#confee").select();$("#confee").focus();return false;}
			        Prefee=parseFloat(Prefee,10);
			        confee=parseFloat(confee,10);
			        var patrn=/^-?\d+\.{0,}\d{0,}$/; 
					 if (!patrn.exec(Prefee)){
					 	alert("<fmt:message key="phone.getinternet0038" />");
					 	$("#Prefee").select();
					 	$("#Prefee").focus();
					 	return false;
					 }
					procparams += "&ycfee=";
					procparams += tsd.encodeURIComponent(Prefee);
					procparams += "&sfyc=";
					procparams += tsd.encodeURIComponent('Y');  
        	}   	
		       	
		    //备注
		    var tBZZZ = $("#tBz").val();
		    procparams += "&zwbz=";
			procparams += tsd.encodeURIComponent(tBZZZ);
			//工号
			var uuserid = $("#userid").val();
			procparams += "&uuserid=";
			procparams += tsd.encodeURIComponent(uuserid);
			//用户名
			procparams += "&username=";
			procparams += tsd.encodeURIComponent('<%=username%>');
			//部门
			var udepart = $("#depart").val();
			procparams += "&udepart=";
			procparams += tsd.encodeURIComponent(udepart);
			//营业区域
			var userareaid = $("#userareaid").val(); 			
			procparams += "&userarea=";
			procparams += tsd.encodeURIComponent(userareaid);
			//区域营业厅
			var uarea = $("#area").val();
			procparams += "&uarea=";
			procparams += tsd.encodeURIComponent(uarea);											
			var loginfo = "<fmt:message key="phone.getinternet0448" />:";//电话批量装机
				loginfo += "(<fmt:message key="phone.getinternet0103" />:";
				loginfo += $("#phonenumshidden").val();
				loginfo += ")(<fmt:message key="phone.getinternet0100" />:";
				loginfo += $("#Hth_hthdang").val();
				loginfo += ")(<fmt:message key="phone.getinternet0074" />:";
				loginfo += $("#Yhlb_hthdang").val();
				loginfo += ")(<fmt:message key="phone.getinternet0112" />:";
				loginfo += $("#Yhmc_yhdang").val();
				loginfo += ")(<fmt:message key="phone.getinternet0341" />:";
				loginfo += $("#Yhdz_yhdang").val()+")";
				loginfo = tsd.encodeURIComponent(loginfo);
			procparams+="&ywbz="+loginfo;	
			if(tsd.Qualified()==false){return false;}	
			$("#usertype").select();
			$("#usertype").focus();
			$("#Messagevalues").text("<fmt:message key="phone.getinternet0023" />");
			loadPopup();
			var status_succ = false;
			var result = new Array();
			var i = 0;
			var j = 0;
			var urll = tsd.buildParams({ packgname:'service',
						clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'tsdBilling',
						tsdExeType:'query',//操作类型 
						datatype:'xml',//返回数据格式 
						tsdpname:'phonebatchinstall.install'						
				});			
			//执行发布请求，成功之后调用initResultInfo()方法显示结果
			$.ajax({
				url:"mainServlet.html?" + urll + procparams,
				async:true,
				cache:false,
				timeout:600000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						result[i++] = new Array();
						$(this).find("cell").each(function(){
							result[i-1].push($(this).text());
						});
					});
					status_succ = true;
					if(result[0]==undefined || result[0][0]==undefined || result[0][0]=="")
					{					
						alert("<fmt:message key="phone.getinternet0039" />");
						disablePopup();
					}
					else
					{
						disablePopup();
						//从procreturn表中查询失败原因
						var resto = fetchSingleValue("dbsql_phone.procreturn",6,"&pname=ywsl_setup&key="+tsd.encodeURIComponent(result[0][1]));
						var languageType = $("#languageType").val();
						var strreutrn = getCaption(resto,languageType,"");
						strreutrn = strreutrn.replace("?hth?",$("#Hth_hthdang").val());
						 	if(result[0][0]=='FAILED'){
						 		if(strreutrn==""){
						 			alert(result[0][1]);						 			
						 			return false;
						 		}else{
						 			alert(strreutrn);
						 			return false;
						 		}
						 	}
							$("#jobidid").val(result[0][0]);
							$("#ppaytype").val($("#fufeitype").val());//将付费方式付给隐藏于，打印报表会使用很关键
							$("#fee").val($("#yjfee").val());
							$("#Dh_hidden").val("");
							writeLogInfo("","add",loginfo);													
							//判断是否打印工单，从tsd_ini表中配置Y为打印
							printworkorder('p_setup');//script/telephone/business/businessreprint.js中
					}
					unLockDh();
					$("#currentHthSaved").val("N");
					$("#currentHthFirstOpen").val("Y");
					$("#currentCheckedHthBox").val("shhth");
					$("#StartDate_yhdang").attr("disabled","disabled");
					$("#EndDate_yhdang").attr("disabled","disabled");
					$("#Reg_Date").attr("disabled","disabled");					
					$("#getphone").removeAttr("check");
					$("#getphone,#getKonghao").removeAttr("disabled","disabled");
					$("#getphone").val("");
					$("#geththsbm select").removeAttr("disabled");
					$("input[id^='number_d']").removeAttr("checked");
					$("#startnum").attr("disabled","disabled");
					$("#endnum").attr("disabled","disabled");
					$("#startnum").val("");
					$("#endnum").val("");
					Dhzj_Reset();
					$("#inputYhdang,#setYGDF_frame,#setBusinesContext_frame,#buttons").hide();
					$("#nextTS").show();
					$("#startDH_phone,#endDh").val("");
					getdhcountvalue();
				},
				complete:function()
				{
					if(!status_succ)
					alert("<fmt:message key="phone.getinternet0040" />");
					unLockDh();
					$("#currentHthSaved").val("N");
					$("#currentHthFirstOpen").val("Y");
					$("#currentCheckedHthBox").val("shhth");
					$("#StartDate_yhdang").attr("disabled","disabled");
					$("#EndDate_yhdang").attr("disabled","disabled");
					$("#Reg_Date").attr("disabled","disabled");	
					Dhzj_Reset();
					getdhcountvalue();
					disablePopup();
				}
			});	
        }
        
 		/**************************************打印工单票据*********************************************/
		 
		/**********
		* 工单打印
		* @param：flag为1时直接打印，为2时预览打印;
		* @return;
	    **********/
       	function jobPrint(flag)
       	{
       		var jobid= $("#jobidid").val();
			var params = "&JobID="+jobid;
       		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/commonreport/dh_jobworkorder_all_zcy.cpt"+params;
       		if(flag=="1")
       		{
       			printWithoutPreview("commonreport/dh_jobworkorder_all_zcy","JobID_"+jobid);
       		}
       		else if(flag=="2")
       		{
       			window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
       		}
       		else
       		{

       		}      		
       	}
		
		/**********
		* 收费打印
		* @param：flag为1时直接打印，为2时预览打印;
		* @return;
	    **********/
       	function lsPrint(flag)
       	{
       		/*****
       		*获取付费类型pay_item表中的prtmodename字段的报表路径名，空为不答应票据
       		*****/
       		var res = fetchSingleValue("dbsql_phone.queryprtmodename",6,"&kemu=pbusinessfee&pay_name="+tsd.encodeURIComponent($("#ppaytype").val()));
       		if(res==""||res==undefined||res=="undefined")
       		{
       			//setTimeout($.unblockUI,1);
       			alert("<fmt:message key="phone.getinternet0126" />");
       			return;
       		}else{       			
       				var params = "&JobID="+$("#jobidid").val();
		       		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/dh_sf_reprint_all.cpt"+params;
		       		if(flag=="1")
		       		{
		       			printWithoutPreview("dh_sf_reprint_all",'JobID_'+$("#jobidid").val());
		       		}
		       		else
		       		{
		       			window.showModalDialog(urll,window,"dialogWidth:720px; dialogHeight:350px; center:yes; scroll:no");
		       		}
	       }
       	}
        
        /********
       	*查询一次性费用项信息
        *@param;
       	*@return;
        *********/
		function queryFeename_batc(key)
		{
			var array="";
			var ids="";
			var idsto="";
			var ywsltype="";
			var dhlxywtype = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=typecode&tablename=dhlx&key=lxmc='"+tsd.encodeURIComponent($("#Dhlx").val())+"'"); 
			if(dhlxywtype=="zx_phone"){
				ywsltype="p_setuptrunk";//装专线
			}else if(dhlxywtype=="gq_phone"){
				ywsltype="p_setupfibre";//装光纤
			}else if(dhlxywtype=="2m_phone"){
				ywsltype="p_setup2m";//装2M
			}else{
				ywsltype="p_setup";//装普通电话
			}
			var urlstr=tsd.buildParams({packgname:'service',//java包
				 					clsname:'ExecuteSql',//类名
				 					method:'exeSqlData',//方法名
				 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
				 					tsdcf:'mssql',//指向配置文件名称
				 					tsdoper:'query',//操作类型 
				 					datatype:'xmlattr',
				 					tsdpk:'phonelnstalled.queryyicixinfeename',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				 					tsdUserID:'ture'
				 				});
                 $.ajax({
	              url:'mainServlet.html?'+urlstr+'&ywlx='+tsd.encodeURIComponent(ywsltype)+"&typeid="+'50',
	              datatype:'xml',
	              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
	              timeout: 1000,
	              async: false ,//同步方式
	              success:function(xml)
	              {     
		              $("#zafeilist").empty();
		              //alert($("#zafeilist").html());					              
		              $(xml).find('row').each(function(){
						  var FeeType=$(this).attr("feetype");
						  if(FeeType!=undefined&&FeeType!="")
						  {
							  array=FeeType.split("~");							  
							  var kldsmcstatus = 0;//状态
							  for(i=0;i<array.length;i++)
							  {
							    var strs = array[i];							      
							    var areaa_a = $("#userareaid").val();
								  if(areaa_a==null || areaa_a=="") areaa_a="a";
								  areaa_a = tsd.encodeURIComponent(areaa_a);								  					
								  var result = fetchMultiArrayValue("phonelnstalled.queryjiaonafeenameFilter",6,"&feetype='"+tsd.encodeURIComponent(strs)+"'&area="+ areaa_a + "&usertype=" + tsd.encodeURIComponent($("#usertype option:selected").text()) + "&userproperty=" + tsd.encodeURIComponent($("#Yhxz option:selected").text()));								  
							      if(result[0]==undefined || result[0][0]==undefined)
							      {
							      	  continue;
							      }
							      kldsmcstatus++;
							      strs = result[0][0];
							      //费用类型
							      var tytypee = result[0][2];
							      if(strs!="")
							      {
							      		$("#yjfee").val("");
							      		var checkBox="<div style='width:50%;text-align:left; height:25px; float:left;'>";	
							      		checkBox+="<input fftype='"+tytypee+"' type='checkbox' onClick=\"feecheck();getcheckfee('"+strs+"');\" id='"+strs+"' name='checkbox' value='"+strs+"' style='width:15px; height:15px; border:0px;float:left; line-height:'/><span style='line-height:25px; padding-left:5px; float:left;'>"+strs+"</span></div>";									      			
					              $("#zafeilist").html($("#zafeilist").html()+checkBox);
					            	refreshbusinessfee();
					            	querybusinessfee();
					            	var resnewbusifee = fetchMultiArrayValue("dbsql_phone.querybusinessfee_all",6,"&userid="+tsd.encodeURIComponent($("#userid").val())+"&dh="+$("#Dh_yhdang").val());
										      if(resnewbusifee[0]!=undefined || resnewbusifee[0][0]!=undefined)
										      {
										      	for(var n=0;n<resnewbusifee.length;n++){
										      		if(resnewbusifee[n][0]==strs){
												      	 $("#"+resnewbusifee[n][0]+"").attr("checked",true);
								            	}
								            }
										      }
			              }
                    if(tytypee=="2")
                    {
                    	continue;
                    }
							      if(kldsmcstatus==1)
							      {
							      	ids += "'"+tsd.encodeURIComponent(strs)+"'";
							      }
							      else
							      {
							      	ids += ",'"+tsd.encodeURIComponent(strs)+"'";
							      }
							  }
						  }
						});
			    }
			});
							
		 }
		</script>	
		<script language="javascript">
		function lodingpage(){
			$("#Messagevalues").text("<fmt:message key="phone.getinternet0023" />");
			var procparams;
			loadPopup();
			var status_succ = false;
			var result = new Array();
			var i = 0;
			var j = 0;
			$.ajax({
				url:"mainServlet.html?",
				async:true,
				cache:false,
				timeout:600000,
				type:'post',
				success:function(xml){
					$(xml).find("row").each(function(){
						result[i++] = new Array();
						$(this).find("cell").each(function(){
							result[i-1].push($(this).text());
						});
					});
					status_succ = true;					
					internation();//字段名称国际化	
		    		disablePopup();
				},
				complete:function()
				{

				}
			});			
		}
		
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
			$("#backgroundPopup").css({
				"height": windowHeight
			});		
			
		}
		
		/**
		 * 根据点击是否生成新合同号按钮来显示对应的列表框
		 * @param 无参数
		 * @return 无返回值
		 */
		function getnewhthcheck(){			
			if($("#newhthcheck").attr("checked")){
				$("#setselectHth").attr("disabled","disabled");
				$("#newhthhiddenid").show();	
				unLockDh();
			}else{
				$("#setselectHth").attr("disabled","");
				$("#newhthhiddenid").hide();
			}
			$("#usertype").removeAttr("disabled")	
			$("#geththsbm :text").val("");
			$("#hth").val("");
			$("#Hth_yhdang").val("");
			$("#newhthcheck :text").val("");
			$("#newhthcheck selected").val("");
			$("#tablehthdang :text").val("");
			$("#tablehthdang selected").val("");
		}
		//生成空号选择面板
		function getdhcountvalue(){		
			$("#dhcountvalue").empty();	
			var res = fetchMultiArrayValue("dbsql_phone.getdhcountvlaue",6,"&userid="+$("#userid").val());
			if(res[0]==undefined || res[0][0]==undefined)
			{				
				$("#selectbuttonid").hide();
				return;
			}
			if(res[0][0]==""||res[0][0]==undefined){$("#selectbuttonid").hide();return;}
			$("#selectbuttonid").show();
			var dhify="<tr>";	
			var count=0;		
			for(var i=0;i<res.length;i++){
				dhify += "<td id='"+res[i][0]+"' style='width:110px;height:30px;'><input type=\"checkbox\" name=\"item\" value=\""+res[i][0]+"\" onClick=\"getcheckphone('"+res[i][0]+"');\" style=\"width:22;padding:0px;border:0px;\" id=\"";				
				dhify += res[i][0];
				dhify += "_del\" />";
				//dhify +="<a href=\"javascript:void(0)\" onClick=\"getcheckphonecontent('"+res[i][0]+"');\" title='"+res[i][1]+"'><h4>";						
				dhify +="<a href=\"javascript:void(0)\" title='"+res[i][1]+"'><h4>";						
				dhify += res[i][0];
				dhify += "</h4></a>";
				dhify += "</td>";
				count++;
				if(count==7){
					dhify += "</tr><tr>";
					count=0;	
				}
			}
			dhify +="</tr>";
			$("#dhcountvalue").append(dhify);			
		}
		
		/**
		 * 校验空号，并将空号追加到空号选择面板	2016-01-11 add by donglei
		 * 
		 */
		function checkBatchNumber(){
			var batchnumber = $.trim($("#batchnumber").val());
			if(batchnumber == null || batchnumber == "" || batchnumber == undefined){
				alert("请导入号码资源！");
				return ;
			}
			var batchArry = batchnumber.split(",");
			if(batchArry.length > 20){
				alert("最多导入20个号码");
				return;
			}
			loadPopup();
			var param = "(";
			for(var i=0;i<batchArry.length;i++){
				param += "'"+batchArry[i]+"'";
				if(i != (batchArry.length -1)){
					param += ",";
				}
			}
			param += ")";
			var dhlx = tsd.encodeURIComponent($("#Dhlx option:selected").text());
			var userid = $("#userid").val();
			var res = fetchMultiPValue("GetNullDh_all",6,"&Batch_Number="+param+"&Uidd="+userid+"&Dhlx="+dhlx);
			if(res[0]==undefined || res[0][0]==undefined)
			{	
				alert("没有符合规定的空号资源！");
				disablePopup();
				return;
			}
			
			for(var i=0;i<res.length;i++){
				
				executeNoQuery("Two_all.deleteYhdang_tmp",6,"&Dh="+res[i][0]+"&userid="+userid);
				executeNoQuery("Two_all.insertYhdang_tmp",6,"&Dh="+res[i][0]+"&Jhj_ID="+res[i][5]+"&Dhlx="+dhlx+"&MokuaiJu="+tsd.encodeURIComponent(res[i][3])+"&userid="+userid+"&hth="+tsd.encodeURIComponent($("#Hth_hthdang").val())); 
				c_p_feedBack(res[i][0],res[i][3],res[i][5],res[i][6],res[i][7]);
			}
			disablePopup();
		}
		
		
		/**
		 * 点击check出发该事件拼接删除条件
		 * @key 电话号码
		 * @return 无返回值
		 */
		var str = "";
		function getcheckphone(key){	
			if($("#"+key+"_del").attr("checked")){
				str +="'"+key+"'," ;
				var restrue = executeNoQuery("dbsql_phone.updateYhdang_tmp_true",6,"&dhto="+key+"&useridto="+$("#userid").val(),'business');
				if(restrue!="true"){
					$("#"+key+"_del").removeAttr("checked");
				}
			}else{
				str=str.replace("'"+key+"',","");
				var resfalse = executeNoQuery("dbsql_phone.updateYhdang_tmp_false",6,"&dhto="+key+"&useridto="+$("#userid").val(),'business');
				if(resfalse!="true"){
					$("#"+key+"_del").attr("checked","checked");
				}
			}
			var strvalue =str.substr(0,str.length-1);
			
			$("#stryhdang_tmpvalue").val(strvalue);
		}
		
		
				
		/**
		 * 执行删除存档电话操作
		 * @key 电话号码
		 * @return 无返回值
		 */
		function deleteyhdang_tmp(){
			if($("#stryhdang_tmpvalue").val()==""){
				//alert("请选择要删除的装机号码！");
				alert("<fmt:message key="phone.getinternet0449" />");				
				return;
			}			
			var insertRes = executeNoQuery("dbsql_phone.deleteyhdang_tmp",6,"&dhstr="+$("#stryhdang_tmpvalue").val());
        	if(insertRes=="true" || insertRes==true)
        	{
        		executeNoQuery("dbsql_phone.deleteywslusing",6,"&dhstr="+$("#stryhdang_tmpvalue").val());
        	}else{
        		alert("<fmt:message key="phone.getinternet0051" />");
        	}
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");
        	$("#Hth_yhdang").val($("#Hth_hthdang").val());
        	Bytc_Refreshs('00000000');//获取包月套餐
			addspeediFeeType('00000000');//获取固定费
        	getdhcountvalue();
		}


		function selectyhdagn_tmp(key){
			$("#stryhdang_tmpvalue").val("");
			if(key=="all"){
				$("#dhcountvalue :checkbox").attr("checked","checked");				
				var divtrue = $("#dhcountvalue input[name='item']").attr("checked");  
		   		$('input[type="checkbox"][name="item"]').attr("checked", true);
		   		var checkallto;	   
			    $($('#dhcountvalue [name="item"][checked=true]:checkbox')).each(function(){
			      checkallto += "'"+this.value + "',";
			    });
			    var a =checkallto.substr(0,checkallto.length-1);
			    a = a.replace(undefined,"");
			    $("#stryhdang_tmpvalue").val(a);
				var rescheck = executeNoQuery("dbsql_phone.updateYhdang_tmp_true_all",6,"&useridto="+tsd.encodeURIComponent($("#userid").val())+"&hthto="+$("#Hth_hthdang").val(),'business');
				if(rescheck!="true"){
					$('input[type="checkbox"][name="item"]').attr("checked", false);
				}
			}else{
				$("#dhcountvalue input[name='item']").removeAttr("checked");
				$("#stryhdang_tmpvalue").val("");
				var rescheck = executeNoQuery("dbsql_phone.updateYhdang_tmp_false_all",6,"&useridto="+tsd.encodeURIComponent($("#userid").val())+"&hthto="+$("#Hth_hthdang").val(),'business');
				if(rescheck!="true"){
					$('input[type="checkbox"][name="item"]').attr("checked", true);
				}
			}	
		}
		
		
		/**
		 * 执行固话存档操作
		 * @key 电话号码
		 * @return 无返回值
		 */
		function cddh_Save(){			
			tsd.QualifiedVal=true;
            var procparams = "";
            if($("#Hth_hthdang").val()==""){
            	alert("<fmt:message key="phone.getinternet0025" />");
            	return ;
            }
            if($("#Dh_yhdang").val()==""){
            	//alert("请选择一个装机号码并进行账号检测！");
            	alert("<fmt:message key="phone.getinternet0450" />");            	
            	return;
            }
            var languageType = $("#languageType").val();
			var Dat = loadData_phoneinstalled("Yhdang",languageType,2);
				 var reszh = fetchFieldAlias('Yhdang',languageType);								
				 for(var i=0;i<Dat.FieldName.length;i++){
				 	var stryhdang = $("#"+Dat.FieldName[i]+"_yhdang").val();
				 	if(stryhdang!=undefined){
				 		stryhdang = stryhdang.replace(/(^\s*)|(\s*$)/g,"");
				        	if(stryhdang==""&&Judgefield_yhdang(Dat.FieldName[i]+"_yhdang")==true&&$("#"+Dat.FieldName[i]+"_yhdang").attr("disabled")!=true)
				        	{
				        		alert("<fmt:message key="phone.getinternet0031" />"+reszh[Dat.FieldName[i]]+"<fmt:message key="phone.getinternet0027" />");
				        		$("#"+Dat.FieldName[i]+"_yhdang").select();
				        		$("#"+Dat.FieldName[i]+"_yhdang").focus();
				        		return false;
				        		break;
				        	}
			        	}
			        if(stryhdang==null){stryhdang="";}		
				 	procparams += "&"+Dat.FieldName[i]+"yhdang="+tsd.encodeURIComponent(stryhdang);
				 }
				 var cDocumentsNumber = $("#Bz7_yhdang").val();
	        	 if(cDocumentsNumber!=undefined){
			        	cDocumentsNumber=cDocumentsNumber.replace(/(^\s*)|(\s*$)/g,"");
			        	if($("#Bz6_yhdang").val()=="<fmt:message key="phone.getinternet0345" />" && cDocumentsNumber!="" && !/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(cDocumentsNumber))
			        	{
			        		alert("<fmt:message key="phone.getinternet0032" />");
			        		$("#Bz7_yhdang").select();
			        		$("#Bz7_yhdang").focus();
			        		return false;
			        	}
			     }
	        	
	        	//电话功能
	        	var Dhgnyhdang = $("#Dhgn_yhdang").val();
	        	procparams += "&Dhgnyhdang=";
		        procparams += tsd.encodeURIComponent(Dhgnyhdang);
				//一级部门
	        	var csbm1 = $("#Bm1_yhdang").val();
	        	/*	
	        	if($("#usertype selected").text()=="<fmt:message key="phone.getinternet0384" />"&&$("#Bm1_yhdang").val()=="")
	        	{
	        		alert("<fmt:message key="phone.getinternet0033" />");
	        		$("#Bm1_yhdang").select();
	        		$("#Bm1_yhdang").focus();
	        		//return false;
	        	}
	        	*/
	        	procparams += "&csbm1=";
	        	procparams += tsd.encodeURIComponent(csbm1);
	        	//二级部门        	
	        	var csbm2 = $("#Bm2_yhdang").val();
	        	procparams += "&csbm2=";
				procparams += tsd.encodeURIComponent(csbm2);						
	        	//三级部门        	
	        	var csbm3 = $("#Bm3_yhdang").val();
	        	procparams += "&csbm3=";
				procparams += tsd.encodeURIComponent(csbm3);	
	        	//四级部门        	
	        	var csbm4 = $("#Bm4_yhdang").val();
	        	procparams += "&csbm4=";
				procparams += tsd.encodeURIComponent(csbm4);				
		        //停机标志
		        var cTJLogo = $("#Tjbz_yhdang").val();
		        procparams += "&Tjbzyhdang=";
				procparams += tsd.encodeURIComponent('K');		        
		        //交换机编号
		        var cSwitchNumber = $("#SwitchNumber").val();
		        if(cSwitchNumber==""||cSwitchNumber==null||cSwitchNumber=="null"){cSwitchNumber='';}
		        procparams += "&Jhj_IDyhdang=";
				procparams += tsd.encodeURIComponent(cSwitchNumber);
		       	//是否付费
		       	var jfufeicheckbox = $("#fufeicheckbox").attr("checked");        	        	
		       	//付费方式
		       	var jfufeitype = $("#fufeitype").val();
		       	procparams += "&jfufeitype=";
				procparams += tsd.encodeURIComponent(jfufeitype);	
		       	//应缴费用
		       	var jyjfee = $("#yjfee").val();
		       	jyjfee=jyjfee.replace(/(^\s*)|(\s*$)/g,"");
		       	if(jyjfee==""){jyjfee=0;}
		       	procparams += "&jyjfee=";
				procparams += tsd.encodeURIComponent(jyjfee);						       
		       	//缴费款项
		       	var jPaymoney = $("#Paymoney").val();
		       	procparams += "&jPaymoney=";
				procparams += tsd.encodeURIComponent(jPaymoney);
				jyjfee = parseFloat(jyjfee,10);		
				if(jyjfee==0){jPaymoney="";}
		       	var jffllxh = $("#staff_ry").val();
		       	procparams += "&jffllxr=";
				procparams += tsd.encodeURIComponent(jffllxh);			
		       	var jffllxdh = $("#ffllxdh").val();
		       	procparams += "&jffllxdh=";  
		       	//备注
		        var tBZZZ = $("#tBz").val();
		        procparams += "&tBZZZ=";
				procparams += tsd.encodeURIComponent(tBZZZ);
				//工号
				var uuserid = $("#userid").val();
				procparams += "&uuserid=";
				procparams += tsd.encodeURIComponent(uuserid);
				//部门
				var udepart = $("#depart").val();
				procparams += "&udepart=";
				procparams += tsd.encodeURIComponent(udepart);
				//营业区域
				var userareaid = $("#userareaid").val(); 			
				procparams += "&userarea=";
				procparams += tsd.encodeURIComponent(userareaid);
				//区域营业厅
				var uarea = $("#area").val();
				procparams += "&uarea=";
				procparams += tsd.encodeURIComponent(uarea);
				procparams += "&fsbm=";
				procparams += tsd.encodeURIComponent($("#fsbm").val());				
				//dhlx
				procparams += "&dhlx=";
				procparams += tsd.encodeURIComponent($("#Dhlx option:selected").text());
				if(tsd.Qualified()==false){return false;}
				$("#usertype").select();
				$("#usertype").focus();
				$("#Messagevalues").text("<fmt:message key="phone.getinternet0023" />");
				loadPopup();
				var status_succ = false;
				var result = new Array();
				var i = 0;
				var j = 0;
				var urll = tsd.buildParams({ packgname:'service',
							clsname:'Procedure',//类名
							method:'exequery',//方法名
							ds:'tsdBilling',
							tsdExeType:'query',//操作类型 
							datatype:'xml',//返回数据格式 
							tsdpname:'phonebatchinstall.installyhdang_tmp'						
					});			
				//执行发布请求，成功之后调用initResultInfo()方法显示结果
				$.ajax({
					url:"mainServlet.html?" + urll + procparams,
					async:true,
					cache:false,
					timeout:600000,
					type:'post',
					success:function(xml){
						$(xml).find("row").each(function(){
							result[i++] = new Array();
							$(this).find("cell").each(function(){
								result[i-1].push($(this).text());
							});
						});
						status_succ = true;
						if(result[0]==undefined || result[0][0]==undefined || result[0][0]=="")
						{
							//alert("存档失败");
							alert("<fmt:message key="phone.getinternet0452" />");							
							getdhcountvalue();
							disablePopup();
						}else if(result[0][0]==0){
							alert("没有该数据的号码信息");
						}else{						
							if(result[0][0]=='FAILED'){
								if(strreutrn==""){
									alert(result[0][0]);						 			
							     	return false;
							 	}else{
							 		alert(strreutrn);
							 		return false;
							 	}
							}
						}
						$("#Dh_hidden").val($("#Dh_yhdang").val());//将第一步电话存入隐藏域中
						//alert(result[0][0]);
						$("#getphone").select();
						$("#getphone").focus();
						$("#currentHthSaved").val("N");
						$("#currentHthFirstOpen").val("Y");
						$("#currentCheckedHthBox").val("shhth");
						$("#StartDate_yhdang").attr("disabled","disabled");
						$("#EndDate_yhdang").attr("disabled","disabled");
						$("#Reg_Date").attr("disabled","disabled");					
						$("#getphone").removeAttr("check");
						$("#getphone,#getKonghao").removeAttr("disabled","disabled");
						$("#getphone").val("");
						$("#geththsbm select").removeAttr("disabled");
						$("#phonefeetype").val("");
						$("#phonefeename").empty();
						$("#Packaggroupid").val("");
						$("#Packagetypes").empty();						
						$("#tablehthdang :text").attr("disabled","disabled");
						$("#tablehthdang selected").attr("disabled","disabled");
						$("#Dh_yhdang").val("");
						if($("#startnum").val()==""){
							Bytc_Refreshs('0000000');//获取包月套餐
							addspeediFeeType('0000000');//获取固定费
							refreshbusinessfee();
						}						
						$("#businessfee").removeAttr("checked");
						$("#batchnumber").val("");
						getdhcountvalue();
						disablePopup();
						//queryFeename_batc();						
					},
					complete:function()
					{
						if(!status_succ)
						alert("<fmt:message key="phone.getinternet0040" />");
						$("#getphone").select();
						$("#getphone").focus();
						getdhcountvalue();
						disablePopup();				
					}
				});		
		}
		
		function getcheckfee(key){
        	if($("#"+key+"").attr("checked")){
	        	var areaa_a = $("#userareaid").val();
						if(areaa_a==null || areaa_a=="") areaa_a="a";
						areaa_a = tsd.encodeURIComponent(areaa_a);
						var res = fetchMultiArrayValue("phonelnstalled.queryjiaonafeenameFilter",6,"&feetype="+tsd.encodeURIComponent("'"+key+"'")+"&area="+ areaa_a + "&usertype=" + tsd.encodeURIComponent($("#usertype option:selected").text()) + "&userproperty=" + tsd.encodeURIComponent($("#Yhxz_hthdang option:selected").text()));	
						if(res[0]==undefined||res[0][0]==undefined)
						{
						 return "";
						}
						else
						{
							//是否可以更改应缴费项的金额，通过权限来实现	
							if($("#yjfeeright").val()=="true"){
								  $("#sjfeevalue").val("");
								  $("#feenamevalue").val(res[0][0]);
								  $("#feenumbervalue").val(res[0][1]);
								  autoBlockForm('editbusinessfee',5,'close',"#ffffff",false);//弹出查询框
							}else{
									if(res[0][1]==""||res[0][1]=="0"){alert("<fmt:message key="phone.getinternet0052" />");$("#"+res[0][0]+"").removeAttr("checked");return false;}
									var params='';
									params += "&fee="+res[0][1];
									params += "&feetype="+tsd.encodeURIComponent(res[0][0]);
									params += "&userid="+tsd.encodeURIComponent($("#userloginid").val());
									params +="&jobid=0";
									var insertRes = executeNoQuery("dbsql_phone.addbusinessfee_all",6,params);
									if(insertRes=="true" || insertRes==true)
									{
										//alert("添加数据成功");
										$("#businessfee").empty();
										$("#businessfeevalue :text").val("");
										refreshbusinessfee();
										writeLogInfo("","addfeetype",tsd.encodeURIComponent("<fmt:message key="phone.getinternet0388" />："+res[0][0]+")(<fmt:message key="phone.getinternet0389" />："+$("#userloginid").val()+")(<fmt:message key="phone.getinternet0390" />)"));
										closeGB();
									}else{
										     	alert("<fmt:message key="phone.getinternet0017" />");
										     	refreshbusinessfee();
										     	removecheckbusi();
									}
									querybusinessfee();
							}										
						}
					}else{
						deletebusinessfee(key);
					}
       }
       
       //保存业务受理非到临时表businessfee_tmpnew
        function deletebusinessfee(feetype){
        	var params='';
			params += "&feetype="+tsd.encodeURIComponent(feetype); 
        	params += "&userid="+tsd.encodeURIComponent($("#userloginid").val());
			if($("#startnum").val()==""){
				params +="&dh="+$("#Dh_yhdang").val();
			}else{
				params +="&dh=0";
			}
        	var insertRes = executeNoQuery("dbsql_phone.deletebusinessfee_bact",6,params);
        	if(insertRes=="true" || insertRes==true)
        		{
        			//alert("删除数据成功");
        			//alert($("#getinternet0050").val());
        			$("#businessfeevalue :text").val("");
        			$("#businessfee").empty();
        			refreshbusinessfee();
        			//writeLogInfo("","deletefeetype",tsd.encodeURIComponent("一次性费用删除日志:(费用类型："+feetype+")(删除人员："+$("#userloginid").val()+")(业务类型：电话装机)"));
        			writeLogInfo("","deletefeetype",tsd.encodeURIComponent($("#getinternet0391").val()+feetype+")("+$("#getinternet0392").val()+"："+$("#userloginid").val()+")("+$("#getinternet0390").val()+")"));
        		}
        		else
        		{
        			//alert("删除数据失败");
        			//alert($("#getinternet0051").val());
        			$("#"+feetype+"").attr("checked","checked");
        		}
        		$("#businessfeevalue :text").val(""); 
        		querybusinessfee();	       	
        }
		
				//保存业务受理非到临时表businessfee_tmpnew
        function savebusinessfee(){
        	var params='';
        	var sjfeevaluekey = $("#feenumbervalue").val();//交费时交当前费用，屏蔽实缴费用;
        	sjfeevaluekey=sjfeevaluekey.replace(/(^\s*)|(\s*$)/g,"");
        	if(sjfeevaluekey==""){sjfeevaluekey=0;}
        	sjfeevaluekey=parseFloat(sjfeevaluekey,10); 
        	var feenumbervalue = $("#feenumbervalue").val();
        	if(sjfeevaluekey==""){alert("<fmt:message key="phone.getinternet0049" />");$("#sjfeevalue").select();$("#sjfeevalue").focus();return false;}          	    	
        	var feenamevaluekey = $("#feenamevalue").val();        	       
        	var bz = $("#businessbz").val();
        	bz=bz.replace(/(^\s*)|(\s*$)/g,"");
        	params += "&fee="+sjfeevaluekey;
			params += "&feetype="+tsd.encodeURIComponent(feenamevaluekey);         	
        	params += "&bz="+tsd.encodeURIComponent(bz);
        	params += "&userid="+tsd.encodeURIComponent($("#userloginid").val());		
			params +="&jobid=0";
        	var insertRes = executeNoQuery("dbsql_phone.addbusinessfee_all",6,params);
        	if(insertRes=="true" || insertRes==true)
        		{
        			//alert("添加数据成功");
        			$("#businessfee").empty();
        			querybusinessfee();
        			$("#yjfeehidden").val(sjfeevaluekey);
        			$("#businessfeevalue :text").val("");
        			refreshbusinessfee();
        			writeLogInfo("","addfeetype",tsd.encodeURIComponent("<fmt:message key="phone.getinternet0388" />："+feenamevaluekey+")(<fmt:message key="phone.getinternet0389" />："+$("#userloginid").val()+")(<fmt:message key="phone.getinternet0390" />)"));
        			closeGB();
        		}
        		else
        		{
        			alert("<fmt:message key="phone.getinternet0017" />");
        			refreshbusinessfee();   
        			removecheckbusi();     			
        			closeGB();
        		}        		
        		$("#businessfeevalue :text").val("");
        }
		
		//电话基本信息
		function getcheckphonecontent(key){				
			$("#dhcountvalue td").css('background-color','#ffffff');			
		    document.getElementById(key).style.background='#bbbbbb';	
			var urlstr=tsd.buildParams({ packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xmlattr',//返回数据格式 
										tsdpk:'dbsql_phone.queryyhdang_tmp'
										});
			var params = "&Dh=" + key;		
			$.ajax({
				url:"mainServlet.html?"+urlstr+params,
				cache:false,
				success:function(xml){
					$(xml).find("row").each(function(){
						//Bytc_Refreshs(key);//获取包月套餐				
						$("#Yhdz_yhdang").val($(this).attr("yhdz")==undefined?"":$(this).attr("yhdz"));
						//用户姓名
						$("#Yhmc_yhdang").val($(this).attr("yhmc")==undefined?"":$(this).attr("yhmc"));
						//合同号
						$("#Hth_yhdang").val($(this).attr("hth")==undefined?"":$(this).attr("hth"));
						//密码
						$("#Mima_yhdang").val($(this).attr("mima")==undefined?"":$(this).attr("mima"));					
						//模块局
						$("#MokuaiJu_yhdang").val($(this).attr("mokuaiju")==undefined?"":$(this).attr("mokuaiju"));						
						//业务区域
						$("#YwArea_yhdang").val($(this).attr("ywarea")==undefined?"":$(this).attr("ywarea"));
						//联系电话
						$("#Bz9_yhdang").val($(this).attr("bz9")==undefined?"":$(this).attr("bz9"));					
						//联系人	
						$("#Bz8_yhdang").val($(this).attr("bz8")==undefined?"":$(this).attr("bz8"));												
						//装机日期
						$("#Reg_Date_yhdang").val($(this).attr("reg_date")==undefined?"":$(this).attr("reg_date"));				
						//强制停开	
						$("#StopBz_yhdang").val($(this).attr("stopbz")==undefined?"":$(this).attr("stopbz"));						
						//调级策略	
						$("#AdjustSheduleNo_yhdang").val($(this).attr("adjustsheduleno")==undefined?"":$(this).attr("adjustsheduleno"));				
						//催缴策略
						$("#CallSheduleNo_yhdang").val($(this).attr("callsheduleno")==undefined?"":$(this).attr("callsheduleno"));					
						//计费类别
						$("#Jflb_yhdang").val($(this).attr("jflb")==undefined?"":$(this).attr("jflb"));			
						//补贴类别
						$("#Mfjb_yhdang").val($(this).attr("mfjb")==undefined?"":$(this).attr("mfjb"));					
						//话机类型
						$("#TypeNum_yhdang").val($(this).attr("typenum")==undefined?"":$(this).attr("typenum"));						
						$("#Dhgn_yhdang").val($(this).attr("dhgn")==undefined?"":$(this).attr("dhgn"));							
						//移动电话
						$("#Mobile_yhdang").val($(this).attr("mobile")==undefined?"":$(this).attr("mobile"));				
						//证件类型
						$("#Bz6_yhdang").val(getzjtype($(this).attr("bz6"))==undefined?"":getzjtype($(this).attr("bz6")));				
						//证件号码
						$("#Bz7_yhdang").val($(this).attr("bz7")==undefined?"":$(this).attr("bz7"));
						$("#Bz1_yhdang").val($(this).attr("bz1")==undefined?"":$(this).attr("bz1"));
						$("#Bz4_yhdang").val($(this).attr("bz4")==undefined?"":$(this).attr("bz4"));
						$("#Bz5_yhdang").val($(this).attr("bz5")==undefined?"":$(this).attr("bz5"));
						//交换机ID
						$("#SwitchNumber").val($(this).attr("jhj_id")==undefined?"":$(this).attr("jhj_id"));
						//正常话务级别
						$("#UserType_yhdang").val($(this).attr("usertype")==undefined?"":$(this).attr("usertype"));//用户类型							
					});
				}
			});
		}
		
		//刷新查询费用项
        function refreshbusinessfee(){	
           $("#businessfee").empty();
           var temp='';
           if($("#Dh_yhdang").val()==""){
           		var phone = "0000000"
           }else{
           		var phone = $("#Dh_yhdang").val();
           }
           if($("#startnum").val()==""){
           		 var res = fetchMultiArrayValue("dbsql_phone.querybusinessfee_all",6,"&userid="+tsd.encodeURIComponent($("#userloginid").val())+"&dh="+phone);           
           }else{
           		 var res = fetchMultiArrayValue("dbsql_phone.querybusinessfee_all",6,"&userid="+tsd.encodeURIComponent($("#userloginid").val())+"&dh=0");           
           }
          
           if(res[0]==undefined || res[0][0]==undefined)
           {
           		$("#cPayItem").val("");
           		return false;
           }           
           var querysel="";
           var n=0;
		   for(var i=0;i<res.length;i++)
		   {
		   	   temp += ",";
			   temp += res[i][0];
			   temp += "：";
			   temp += res[i][1];
			   temp += "<fmt:message key="phone.getinternet0161" />";
		       querysel+="<tr><th style='width:200px;line-height:28px;'><center>";
		       querysel+=res[i][0];
		       querysel+="</center></th><th style='width:115px;line-height:28px;'><center>"
		       querysel+=res[i][1];
		       querysel+="</center></th></tr>";
		       n++;				
		   }
		   for(var j=0;j<5-n;j++){
		   	   querysel+="<tr><th style='width:200px;line-height:28px;'><center>";
		       querysel+="……";
		       querysel+="</center></th><th style='width:115px;line-height:28px;'><center>"
		       querysel+="……";
		       querysel+="</center></th></tr>";	
		   }
		   temp = temp.replace(",","");
		   $("#cPayItem").val(temp);
		   $("#businessfee").append(querysel);
        }
        
        /********************
			* 判断是否预存金额，来判断是否金额只读
			* @param;
			* @return;
			*********************/
			function getdhnumcheck(){
				if($("#Dhlx").val()==""){
					alert("请选择电话类型！");
					$("#Dhlx").select().focus();
					$("input[id^='number_d']").removeAttr("checked");
					return;
				}
		  		var number_dchecked= $("#number_d").attr("checked");
		  		var hthvalue = $("#hth").val();
		  		hthvalue=hthvalue.replace(/(^\s*)|(\s*$)/g,"");	
		  		if(hthvalue==""){alert("<fmt:message key="phone.getinternet0025" />");$("input[id^='number_d']").removeAttr("checked");return false;}
		  		if(number_dchecked){
		  				$("#startnum").removeAttr("disabled");
		  				$("#endnum").removeAttr("disabled");
						$("#getphone,#getKonghao").attr("disabled","disabled");
		  				$("#startnum").select();
		  				$("#startnum").focus();
		  				getyhdangvalue();
						getphonefeename("1,2,3");
		  		}else{
		  				$("#startnum").attr("disabled","disabled");
		  				$("#endnum").attr("disabled","disabled");
		  				$("#startnum").val("");
		  				$("#endnum").val("");
						$("#getphone,#getKonghao").removeAttr("disabled");
		  		}
		  		$("#getphone").val("");
		  		$("#Dh_yhdang").val("");
		  		$("#Dh_hthdang").val("");
				executeNoQuery('phonebatchinstall.deleteYhdang_tmp',6,'&slr='+$("#userid").val());
				getdhcountvalue();
		  }
		  
		  function getyhdangvalue(){
		    	getbusinessDefault();//设置默认值
				$("#Mima_yhdang").val("123456");
				$("#toMima_yhdang").val("123456");					
				if($("#userareaid").val()!="null"&&$("#userareaid").val()!=undefined){
					//通过查询区域下拉框值时付给隐藏域中的区域类型来默认给区域赋值当前工号所在区域
					if($("#areatype").val()=="ywarea"){
						$("#userareaid").val($("#userareaid").val());
					}else if($("#areatype").val()=="ysarea"){
						$("#userareaid").val($("#area").val());
					}
				}
				$("#Bz3_yhdang").val($("#area").val());
				$("#StartDate_yhdang").val('2999-12-31');
				$("#EndDate_yhdang").val('2999-12-31');
				var userid = $('#userid').val();
				$("#tableyhdang select").removeAttr("disabled");
				$("#tableyhdang :text").removeAttr("disabled");
				$("#Dh_yhdang").attr("disabled","disabled");
				$("#ZFEndday").removeAttr("disabled");
				$("#ZFStartday").removeAttr("disabled");
				$("#TCEndtime").removeAttr("disabled");
				$("#TCStarttime").removeAttr("disabled");
				$("#TCEndtimes").removeAttr("disabled");
				$("#TCStarttimes").removeAttr("disabled");
				$("#StartDate_yhdang").attr("disabled","disabled");
				$("#EndDate_yhdang").attr("disabled","disabled");
				$("#Reg_Date").attr("disabled","disabled");
				$("#Hth_hthdang").attr("disabled","disabled");
				//$("#Dh_yhdang").attr("disabled","disabled");
				$("#Hth_yhdang").attr("disabled","disabled");
				$("#Dh_hthdang").attr("disabled","disabled");				
				//$("#MokuaiJu_yhdang").attr("disabled","disabled");
				$("#Yhlb_hthdang").attr("disabled","disabled");
				$("#Tjbz_yhdang").val('K');
				gettable();
				$("#Tjbz_yhdang").attr("disabled","disabled");
				//$("#UserType_yhdang").attr("disabled","disabled");				
				//根据配置权限时刻可以对计费起始，计费终止，装机日期进行可编辑
				if($("#statrtimeright").val()=="false"){
					$("#StartDate_yhdang").attr("disabled","disabled");
				}else{
					$("#StartDate_yhdang").removeAttr("disabled");
				}
				if($("#stoptimeright").val()=="false"){
					$("#EndDate_yhdang").attr("disabled","disabled");
				}else{
					$("#EndDate_yhdang").removeAttr("disabled");
				}
				if($("#zjtimeright").val()=="false"){
					$("#Reg_Date_yhdang").attr("disabled","disabled");
				}else{
					$("#Reg_Date_yhdang").removeAttr("disabled");
				}
				getPowertrue();//获取权限值进行判断
				getZJtime();			   
		  }
		  
		  /********
           *添加电话费用杂费信息
           *@param;
       	   *@return;
           ********/		   
		   function insertphonefeename()
		   {
		      var phone = $("#Dh_yhdang").val();
		      if(phone=="")
		      {
		      	alert("请选择一个电话空号！");
		      	return false;
		      }
		      var phonefeename = $("#phonefeenamecode").val();		      
		      if($("#phonefeetype").val()=="")
		      {
		      	alert("<fmt:message key="phone.getinternet0006" />");
		      	$("#phonefeetype").focus();
		      	return false;
		      }
		      
		      if(phonefeename=="" || phonefeename==null)
		      {
		      	alert("<fmt:message key="phone.getinternet0007" />");
		      	$("#phonefeename").focus();
		      	return false;
		      }
		      if($("#startnum").val()!=""){
		      	phone='all';
		      }
		      
		      phonefeename = tsd.encodeURIComponent(phonefeename);
		      var ress = JudgeISNOTStorage(phonefeename,phone);
		      if(ress!=0)
		      {
		      	alert("<fmt:message key="phone.getinternet0008" />");
		      	return false;
		      }
		     
		      var feecode = $("#feecode").val();
		      var feelv = $("#feelv").val();
		      var TJfeelv = $("#TJfeelv").val();
		      var ZFStartday = $("#ZFStartday").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFStartday))
		      {
		      	$("#ZFStartday").focus();
		      	return false;
		      }
		      
		      var ZFEndday = $("#ZFEndday").val();
		      
		      if(!/^\d{4}-\d{2}-\d{2}$/.test(ZFEndday))
		      {
		      	$("#ZFEndday").focus();
		      	return false;
		      }
		      
		      var ZFStartmonth = ZFStartday.substring(0,7);//起始月
		      ZFStartmonth = ZFStartmonth.replace('-',"");
		      
		      var ZFEndmonth = ZFEndday.substring(0,7);//终止月
		      ZFEndmonth = ZFEndmonth.replace('-',"");
		      
		      var feename = $("#Subtype").val();
		      /*
		      if(feename=="月租" && isXinYeWuExists(phone)!="0")
		      {
		      	alert("已经存在一项月租费，不能多次添加");
		      	return false;
		      }*/
		      feename = tsd.encodeURIComponent(feename);
		      
		      //检测终止时间是否大于起始时间
		      /*
		      var resg = gettimeday(ZFStartday,ZFEndday);
		      resg = parseInt(resg,10);
		      if(resg<=0)
		      {
					alert("终止时间必须大于起始时间！");
					$("#ZFEndday").select();
		      		$("#ZFEndday").focus();
		      		return false;
		      }
		      */
		      var cs1 = $("#cs1").val();
		      if(cs1==undefined||cs1=="undefined"){cs1=""}
		      cs1=cs1.replace(/(^\s*)|(\s*$)/g,"");
		      var cs2 = $("#cs2").val();
		      if(cs2==undefined||cs2=="undefined"){cs2=""}
		      cs2=cs2.replace(/(^\s*)|(\s*$)/g,"");
		      var cs3 = $("#cs3").val();
		      if(cs2==undefined||cs3=="undefined"){cs3=""}
		      cs2=cs2.replace(/(^\s*)|(\s*$)/g,"");
		      var csstr;
		      if(cs1!=""&&cs2==""){
		      	 csstr = cs1;		      	 
		      }else if(cs1!=""&&cs2!=""&&cs3==""){
		      	 csstr = cs1+"~"+cs2;
		      }else if(cs3!=""&&cs2!=""&&cs1!=""){
		      	 csstr = cs1+"~"+cs2+"~"+cs3;
		      }		      
		      if(cs1==""&&cs2==""&&cs3==""){
		      	csstr="";
		      }
		      if(csstr==undefined){csstr="";}
		      csstr=csstr.replace('~undefined',"");
		      csstr=csstr.replace('undefined',"");
		     var DEVNUMstr = $("#DEVNUM").val().replace(/(^\s*)|(\s*$)/g,"");
		      var DEVLENGTHstr = $("#DEVLENGTH").val().replace(/(^\s*)|(\s*$)/g,"");
		      var CUNIT = $("#CUNIT").val();	 
		      if ($("#Bz4_yhdang").val()=="PBX连选"&&DEVNUMstr<=1){
		      		alert("选择连选号码时，设备数量必须大于1");
		      		return;
		      }
		     if($("#startnum").val()==""){
				  var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&dh="+$("#Dh_yhdang").val()+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr)+"&ywlx=p_setup"+"&cztype=add"+"&DEVNUM="+DEVNUMstr+"&DEVLENGTH="+DEVLENGTHstr+"&CUNIT="+CUNIT);	
			  }else{
				  var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&dh="+$("#Hth_yhdang").val()+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr)+"&ywlx=p_setup"+"&cztype=add"+"&DEVNUM="+DEVNUMstr+"&DEVLENGTH="+DEVLENGTHstr+"&CUNIT="+CUNIT);	
			  } 
		   
			 if(result[0][0]!=undefined && result[0][0]!="")
			 {
			 	addspeediFeeType('');//重新加载数据
		        $("#feecode").val("");
		        $("#feelv").val("");
		        $("#TJfeelv").val("");
		        //$("#ZFStartday").val("");
		        //$("#ZFEndday").val("");
		        $("#Subtype").val("");
		        $("#feenameid").val("");
		        $("#Subtype").val("");
		        $("#phonefeename").val("");
		        $("#ZFEndday").val("2999-12-31");
			 }else{
			 	alert("<fmt:message key="phone.getinternet0009" />");
			 }
			 
		     /*
		      var res = executeNoQuery("phonelnstalled.insertphonefeename",6,"&dh="+phone+"&feetype="+phonefeename+"&feecode="+feecode+"&feelv="+feelv+"&TJfeelv="+TJfeelv+"&StartMonth="+ZFStartmonth+"&EndMonth="+ZFEndmonth+"&StartDate="+ZFStartday+"&EndDate="+ZFEndday+"&feename="+feename+"&OperID="+tsd.encodeURIComponent($("#userid").val())+"&csstr="+tsd.encodeURIComponent(csstr));
		      if(res=="true")
		      {
		        addspeediFeeType();//重新加载数据
		        $("#feecode").val("");
		        $("#feelv").val("");
		        $("#TJfeelv").val("");
		        //$("#ZFStartday").val("");
		        //$("#ZFEndday").val("");
		        $("#Subtype").val("");
		        $("#feenameid").val("");
		        $("#Subtype").val("");
		        $("#phonefeename").val("");
		        $("#ZFEndday").val("2999-12-31");
		      }
		      else
		      {
		        alert("保存失败！");		        
		      }*/
		      //删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
		      $("#phonefeenamecode").val("");
        	  $("#phonefeename tr").css('background-color','#f7f7f7');
		    }
		    
		    /********
          *查询生成该电话固话费用项信息，以表格的形式显示
          *@param;
       	  *@return;
          ********/
		  function addspeediFeeType(key)
		  {
		  	   var phone = $("#Dh_yhdang").val();
		  	   if(key!=""){
		  	   	  phone=key;
		  	   }
			   if($("#startnum").val()!=""){
			   		phone=$("#Hth_yhdang").val();;
			   }
			   var ify="";
			   var count=0;
		       var urlstr=tsd.buildParams({ 	packgname:'service',//java包
							 					clsname:'ExecuteSql',//类名
							 					method:'exeSqlData',//方法名
							 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
							 					tsdcf:'mssql',//指向配置文件名称
							 					tsdoper:'query',//操作类型 
							 					datatype:'xmlattr',
							 					tsdpk:'phonelnstalled.queryphoneFYX'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							 				});			 							
				$.ajax({
						url:'mainServlet.html?'+urlstr+"&dh="+phone,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
						            ify="";
						            $("#dhzftab tr:has('td')").remove();					           
									$(xml).find('row').each(function(){
									var id = $(this).attr("id");
									var feetype = $(this).attr("feetype");
									var feecode = $(this).attr("feecode");								
									var Price = $(this).attr("price");		
									var TjPrice = $(this).attr("tjprice");	
									var StartDate = $(this).attr("startdate");
									var EndDate = $(this).attr("enddate");
									var csvalue = $(this).attr("csvalue");
									var feename = $(this).attr("feename");
									var devlength = $(this).attr("devlength");//长度
									var devnum = $(this).attr("devnum");//设备数量
									if(id!=undefined){	
									ify += "<tr>";
									ify += "<td><center>";
									ify += "<input type=\"checkbox\" id=\"v_dhzftab_check\"" + id +  "\"  />";
									ify += "</center></td>";
									ify += "<td width=\"200\"><center>";
									ify += feename+"("+$(this).attr("feetype")+")";
									ify += "</center></td>";
									ify += "<td style='display:none;'><center>";
									ify += $(this).attr("feecode");
									ify += "</center></td>";
									ify += "<td width=\"60\"><center>";
									ify += $(this).attr("price");
									ify += "</center></td>";
									ify += "<td width=\"100\"><center>";
									ify += $(this).attr("startdate");
									ify += "</center></td>";
									ify += "<td width=\"100\"><center>";
									ify += $(this).attr("enddate");
									ify += "</center></td>";
									ify += "<td width=\"73\"><center>";
									ify += devnum;
									ify += "</center></td>";
									ify += "<td width=\"73\"><center>";
									ify += devlength;
									ify += "</center></td>";
									ify += "<tr>";
									count += 1;
									}
								});
								for(var i=0;i<=5-count;i++){
									ify += "<tr>";
									ify += "<td width=\"20\"><center>";
									ify += ".";
									ify += "</center></td>";
									ify += "<td width=\"200\"><center>";
									ify += "……";
									ify += "</center></td>";								
									ify += "<td width=\"60\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"110\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"110\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"73\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<td width=\"73\"><center>";
									ify += "……";
									ify += "</center></td>";
									ify += "<tr>";
								}
								count=0;
								$("#dhzftab").append(ify);
								$("#dhzftab tr:empty").remove();
							}
						});					
				$("#dhzftab_checkall").removeAttr("checked");
		   }
		   
		   /********
       	*包月套餐保存临时表
        *@param;
       	*@return;
        *********/ 
        function Bytc_Saves()
        {
        	var Packaggroupid = $("#Packaggroupid").val();
        	if(Packaggroupid==""){alert("<fmt:message key="phone.getinternet0053" />");$("#Packaggroupid").select();$("#Packaggroupid").focus();return false;}
        	var tctype = $("#Packagetypeshidden").val();
        	if(tctype=="" || tctype==undefined)
        	{
        		alert("<fmt:message key="phone.getinternet0054" />");
        		return false;
        	}
        	else
        	{
        		//alert(/^\d{4}-\d{2}-\d{2}$/.test($("#TCStarttime").val()));
        		var dh = $("#Dh_yhdang").val();
        		if(dh=="")
        		{
        			alert("<fmt:message key="phone.getinternet0199" />"); //add by chenlang
        			$("#Packagetypes").val('');
        			$("#Dh_yhdang").focus();
        			return false;
        		}
        		if($("#startnum").val()!=""){
        			dh='all';
        		}
        		//验证所添加套餐类型是否已存在
        		
        		var existedcheck=fetchSingleValue("phonelnstalled.checkbytcexisteds",6,"&FeeType="+tsd.encodeURIComponent(tctype)+"&dh="+dh);
        		existedcheck = parseInt(existedcheck);
        		if(existedcheck!=0)
        		{
        			alert("<fmt:message key="phone.getinternet0055" />" + tctype + "<fmt:message key="phone.getinternet0014" />");
        			return false;
        		}
        		var startdate = $("#TCStarttimes").val();
        		var enddate = $("#TCEndtimes").val();
        		
        		//检测时间
        		//var timecheck=fetchSingleValue("phonelnstalled.getstartendtime",6,"&starttime="+startdate+"&endtime="+enddate);
        		//timecheck = parseInt(timecheck);
        		//if(isNaN(timecheck) || timecheck<=0)
        		//{
        		//	alert("终止月份必须大于起始月份");
        		//	return false;
        		//}
        		
        		//取费用名称和月数
        		var res = fetchMultiArrayValue("phonelnstalled.queryPackagetypeByWheres",6,"&FeeType="+tsd.encodeURIComponent(tctype));
        		
        		if(res[0]==undefined || res[0][0]==undefined)
        		{
        			alert("<fmt:message key="phone.getinternet0056" />");
        			return false;
        		}

        		var Fee_Types = res[0][0];
        		var resmonth = res[0][1];        	
        		var startmonth=startdate.substr(0,7).replace("-","");
        		var endmonth=enddate.substr(0,7).replace("-","");        		        		
        		var userid = $("#userid").val();        		
        		var params = "";
        		if($("#startnum").val()==""){
        			params += "&Dh="+dh;
        		}else{
        			params += "&Dh=all";
        		}        		
        		params += "&FeeType=" + tsd.encodeURIComponent(Fee_Types);
        		params += "&mon="+resmonth;
        		params += "&StartDate="+$("#TCStarttimes").val();
        		params += "&EndDate="+$("#TCEndtimes").val();        		
        		params += "&userid="+$("#userloginid").val();        		
        		var insertRes = executeNoQuery("phonelnstalled.addbytcs",6,params);     
        		if(insertRes=="false" || insertRes==false){
        			alert("<fmt:message key="phone.getinternet0017" />");
        		}
        		$("#TCEndtime").val("");
        		$("#Packagetypeshidden").val("");
        	    $("#Packagetypes tr").css('background-color','#f7f7f7');
        		Bytc_Refreshs('');
        		$("#Packagetypes").val("2999-12-31");
        	}
        } 
        
         /********
       	*刷新包月套餐数据
        *@param;
       	*@return;
        *********/ 
        function Bytc_Refreshs(key)
        {
			$("#bytctabs tr:has('td')").remove();
			$("#bytctabs tr:empty").remove();			
			var phone = '';
			if(key!=''){
				phone = key;
			}else{
				phone = $("#Dh_yhdang").val();
			}
			if($("#startnum").val()!=""){
				phone='all';
			}
			if(phone=="")
			{
				alert("<fmt:message key="phone.getinternet0056" />");
				return false;
			}
			var res = fetchMultiArrayValue("phonelnstalled.queryPackagetypeXXs",6,"&dh="+phone);	
			if(res[0]==undefined || res[0][0]==undefined)
			{
				res.length=0;
			}			
			var count = res.length;
			var sum=0;
			var ify = "";			
			for(var i=0;i<count;i++)
			{
				ify += "<tr>";
				ify += "<td width=\"20\"><center>";
				ify += "<input type=\"checkbox\" id=\"v_bytctab_checks\"" + i + " />";
				ify += "</center></td>";
				ify += "<td width=\"250\"><center>";
				ify += res[i][1];
				ify += "</center></td>";
				ify += "<td width=\"130\"><center>";
				ify += res[i][2];
				ify += "</center></td>";
				ify += "<td width=\"130\"><center>";
				ify += res[i][3];
				ify += "</center></td>";
				ify += "<tr>";
				sum++;	
			}
			for(var n=0;n<=4-sum;n++){
				ify += "<tr>";
				ify += "<td width=\"20\"><center>";
				ify += ".";
				ify += "</center></td>";
				ify += "<td width=\"250\"><center>";
				ify += "……";
				ify += "</center></td>";
				ify += "<td width=\"130\"><center>";
				ify += "……";
				ify += "</center></td>";
				ify += "<td width=\"130\"><center>";
				ify += "……";
				ify += "</center></td>";
				ify += "<tr>";
			}
			sum=0;
			$("#bytctabs").append(ify);
			$("#bytctab_checkalls").removeAttr("checked");
        }       
        
        /********
       	*生成电话包月套餐下拉框
        *@param;
       	*@return;
        *********/  
        function getPackagetypes()
        {
           $("#Packagetypeshidden").val("");
           var Packaggroupid = $("#Packaggroupid").val();
           if(Packaggroupid==""){$("#Packagetypes").empty();return;}
           $("#Packagetypes tr").css('background-color','#f7f7f7');
           if($("#Dh_yhdang").val()==""){
           		//alert("请选择一个电话空号！");
           		alert("<fmt:message key="phone.getinternet0453" />");
           		$("#Packaggroupid").val("");return;}
           var restimtype = fetchMultiArrayValue("dbsql_phone.querytabledate",6,"&tablename=monthfee_group&cloum=GTYPE,CYCLE&key=gid="+Packaggroupid);
           if(restimtype[0][0]==undefined||restimtype[0][0]==""){return false;}
			var resno = getsysdate(restimtype[0][0]);//通过获取时间类型来得到对应的时间
			$("#TCStarttimes").val(resno);
			if(restimtype[0][0]=="1"||restimtype[0][0]=="0"||restimtype[0][0]==1||restimtype[0][0]==0){
				$("#TCStarttimes").attr("disabled","disabled");
			}else{
				$("#TCStarttimes").removeAttr("disabled");
			}
			$("#cycle").val(restimtype[0][1]);
           if(Packaggroupid==""){Packaggroupid=-1000;}
           var res = fetchMultiArrayValue("phonelnstalled.queryPackagetype_monthfee",6,"&gid="+Packaggroupid);
           $("#Packagetypes").empty();           
           if(res[0]==undefined || res[0][0]==undefined)
           {
           		return false;
           }           
           var querysel="";
		   for(var i=0;i<res.length;i++)
		   {
		       querysel +="<tr onClick=\"getBYfeetr('"+res[i][0]+"','"+res[i][1]+"','"+restimtype[0][1]+"','"+res[i][2]+"');\" id=\""+res[i][0]+"\"><td>";
         	   querysel +="☞"+res[i][0];
    		   querysel +="</td></tr>";
		   }
		   $("#Packagetypes").append(querysel);
        }    
		
		function getTwoDh(Dh){
			var Res = executeNoQuery("dbsql_phone.twodhconction",6,"&phone="+Dh);
		}
		
		/********
           	*删除列表中的电话费用杂费信息
           	*@param;
       	  	*@return;
          	********/
		    function deletephonefeename()
		    {	
				var checkedDhzf = $("input[id^='v_dhzftab_check'][checked]");
	        	var count = $(checkedDhzf).size();	        	
	        	if(count<1)
	        	{
	        		//alert("请选择要删除的杂费项信息");
	        		alert($("#getinternet0010").val());
	        		return false;
	        	}	        		        	
				if($("#startnum").val()!=""){
					var dh = $("#Hth_yhdang").val();
				}else{
					var dh = $("#Dh_yhdang").val();
				}
	        	var feetype = "";
	        	var feecode = "";       	
	        	var result = true;
	        	var resultTmp = false;	        	
	        	for(var i=0;i<count;i++)
	        	{
	        		feetype = $(checkedDhzf[i]).parent().parent().next().text();
	        		feecode = $(checkedDhzf[i]).parent().parent().next().next().text();//费用code是隐藏在表格中的
	        		/*
	        		resultTmp = executeNoQuery("phonelnstalled.deletephonefeename",6,"&FeeType="+tsd.encodeURIComponent(feetype)+"&Dh="+dh);	        		
	        		if(resultTmp=="false" || resultTmp==false)
	        		{
	        			result = false;
	        			alert("删除杂费失败");
	        		}*/
	        		var result = fetchMultiPValue("phonelnstalled.insertphonefeename",6,"&feetype="+tsd.encodeURIComponent(feetype)+"&feecode="+feecode+"&dh="+dh+"&ywlx=p_setup"+"&cztype=delete");	   	
					 if(result[0]!=undefined && result[0][0]!="")
					 {					 	
	        			
					 }else{
					 	//alert("删除杂费失败");
					 	alert($("#getinternet0011").val());
					 }
	        	}
	        	/*	        	
	        	if(result)
	        	{
	        		alert("删除杂费成功");
	        	}
	        	else
	        	{
	        		alert("删除杂费失败");
	        	}*/
	        	//删除时把左边的点击显示颜色清空掉，然后把隐藏值也清空掉
	        	$("#phonefeenamecode").val("");
        	    $("#phonefeename tr").css('background-color','#f7f7f7');
	        	//重新加载数据
	        	addspeediFeeType('');	        	
		    }
			
			function ghcontextShow(){
				if($("#Hth_hthdang").val()==""){
					alert("请先选择或生成一个合同号");
					return;
				}
				var resyhdang_tmp = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1) as cont&tablename=yhdang_tmp&key=userid='"+$("#userid").val()+"' and opertype='true'");
				if(resyhdang_tmp<=0){
					alert("请选择要装机的电话！");
					$("#inputYhdang,#setYGDF_frame,#setBusinesContext_frame,#buttons").hide();
					return;
				}else{
					var phones=$("#stryhdang_tmpvalue").val();
					
					var arry=phones.replace(/\'/g,'').split(',');
					arry=arry.sort(compare);
					
					
					$("#Dh_yhdang").val(arry[arry.length-1]);
		  			$("#Dh_hthdang").val(arry[arry.length-1]);
					
					$("#inputYhdang,#setYGDF_frame,#setBusinesContext_frame,#buttons").show();
					$("#Yhmc_yhdang").select().focus();
					$("#nextTS").hide();
				}
				
			}
			//用于数组排序
			function compare(a,b){return a-b;}
		</script>		
		<style type="text/css">
			label{float:right;text-align:left;margin-left:0px;}
			#loading{
				display:none;
				position:fixed;
				_position:absolute; /* hack for internet explorer 6*/
				height:200px;
				width:408px;
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
	</head>
	<body onunload="unLockDh()">
		<div id="loading">
				<div style="height:80px"></div>
				<img src="style/images/public/loading.gif" />
				<br />
				<span id="Messagevalues"></span><!-- 加载提示信息 -->
		  		</div>
	  		<div id="backgroundPopup"></div>
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
								onclick="parent.history.back(); return false;"><fmt:message key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
					<fmt:message key="phone.getinternet0454" /><!-- 合同号选择 -->
				</div>
				<div id="inputtext">
					<table cellspacing="3">
						<tr>					
							<td>
								<fmt:message key="phone.getinternet0455" /><!-- 是否生成新合同号 -->
							</td>		
							<td>
								<input type="checkbox" id="newhthcheck" name="newhthcheck" onclick="getnewhthcheck();" style="width:30px;"/>
							</td>
							<td>
								<button class="tsdbutton" id="setselectHth" 
									onclick="selecthth('1')" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;" disabled="disabled">
									<fmt:message key="phone.getinternet0079" /><!-- 选择合同号 -->										
								</button>
							</td>
							<td>&nbsp;&nbsp;
								<button class="tsdbutton" id="setHth" 
									onclick="GenerateHth()" 
									style="height: 28px; margin-top: 3px; padding: 0px;display:none;">
									生成新合同号
									<!-- 设置单位合同号 -->
								</button>
								<button class="tsdbutton" id="setDJHth" 
									onclick="setDJHTH()" 
									style="height: 28px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phoneyewu.setdjhth" />
									<!-- 设置代缴合同号 -->
								</button>
							</td>													
						</tr>
					</table>	
					<div id="newhthhiddenid" style="display:none;">
					<table cellspacing="4" id="geththsbm">
						<tr>
						<td>&nbsp;&nbsp;<span id="spanBm1"></span></td>
						<td><input type="text" id="sBm1" style="width:180px;" disabled="disabled"/><font color="red"><span id="bixuantype"></span></font>
						<input type="hidden" id="sBm1code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="yijisBmhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td><span id="spanBm2"></span></td>
						<td><input type="text" id="sBm2" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm2code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="addsBmerhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						</tr>
						<tr>
						<td>&nbsp;&nbsp;<span id="spanBm3"></span></td>
						<td><input type="text" id="sBm3" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm3code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="addsBmsanhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td><span id="spanBm4"></span></td>
						<td><input type="text" id="sBm4" style="width:180px;" disabled="disabled"/>
						<input type="hidden" id="sBm4code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="addsBmsihth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						</tr>
						</table>
					<hr style="border: 1px dotted #CCCCCC;" />
					<table cellspacing="2">
						<tr>	
							<td>
								&nbsp;&nbsp;<fmt:message key="phone.getinternet0074" />
							</td>
							<td>
								<select name="usertype" id="usertype" style="width: 120px;" onchange="javascript:$('#hth').val('');$('#Hth').val('');$('#UserType_yhdang').val('');$('#Yhxz').val('');$('#Hth_yhdang').val('');removenullhthcontent();"></select><font color="red">*</font>									
							</td>							
							<td>
								 &nbsp;&nbsp;<fmt:message key="phone.getinternet0076" /><!-- 合&nbsp;同&nbsp;号 -->&nbsp;
							</td>
							<td>
								<input type="text" name="hth" id="hth" style="width: 180px;"
									disabled="disabled" />
								<input type="hidden" name="gfhth" id="gfhth" />
							</td>
							<td>
								<button class="tsdbutton" id="setHth" 
									onclick="GenerateHth();" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0077" /><!-- 生成合同号 -->
								</button>
							</td>
							<td>
								<button class="tsdbutton" id="setHth" 
									onclick="InputHth();" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;display:none;">
									<fmt:message key="phone.getinternet0078" /><!-- 输入合同号 -->
								</button>
							</td>
						</tr>
					</table>
					</div>
				</div>				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0080" /><!-- 合同号信息 -->
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="tablehthdang" style="width:780px;">
						</table>
						<button class='tsdbutton' id='setHthvalue'	onclick='getPublicfield();' style='height: 28px; margin-top: 3px; padding: 0px;'>同步到固话信息</button>
					</div>
				</div>	
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0456" /><!-- 装机号码 -->
				</div>
				<div id="inputtext">								
				<table cellspacing="5">	
													
					<tr>																   
						<td>
						&nbsp;<fmt:message key="phone.getinternet0073" /><!-- 电话类型 -->
						</td>
						<td>
							<select id="Dhlx" style="width:120px;" disabled="disabled"></select><span style="color:red;">*</span>
						</td>
						<td>
							<span id="spangetdh" style="display:none"></span>
							<!-- 电话号码 -->
						</td>
						<td>号码起始</td>
						<td><input type="text" name="startDH_phone" id="startDH_phone" style="width: 120px" /></td>
						<td>到</td>
						<td>
							<input type="text" name="endDh" id="endDh" style="width: 120px" />
						</td>
						<td>						
							<button class="tsdbutton" id="getKonghao" onclick="c_p_konghaoDialog_all()" style="height: 28px;width:60px; margin-top: 3px; padding: 0px;">
								<fmt:message key="phoneyewu.getkonghao" />
								<!-- 获取空号 -->
							</button>
						</td>	
					</tr>
					<tr>
						<td>
						&nbsp;导入号码
						</td>
						<td colspan="6">
							<textarea name="batchnumber" id="batchnumber" style="width: 550px;height:100px" ></textarea>
						</td>
						<td>						
							<button class="tsdbutton" id="getKonghao" onclick="checkBatchNumber()" style="height: 28px;width:60px; margin-top: 3px; padding: 0px;">
								校验空号
								<!-- 校验空号-->
							</button><br/>
							<span style="color:red">(最多导入20个号码)</span><br/>
							<span style="color:red">(导入号码之间用英文','分割	例如：111,222)</span>
						</td>
					</tr>
				</table>
				<hr style="border: 1px dotted #CCCCCC;" />
				<!-- 
				<div style="width:740px; height: 150px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
					<div id="dhcountvalue" style="width: 100%; float: left;"></div>
				</div> -->
				<table id="dhcountvalue"  cellspacing="12" border="0" cellspacing="1" style="background-color:#f7f7f7"></table>				
				<table id="selectbuttonid" style="display:none;">
					<tr>
						<td>
							<button class="tsdbutton" id="deleteyhdang_tmpall" onclick="selectyhdagn_tmp('all');" style="width:50px;height: 28px; margin-top: 3px; padding: 0px;">
								<fmt:message key="phone.getinternet0461" /><!-- 全选 -->				
							</button>
						</td>
						<td>
							<button class="tsdbutton" id="deleteyhdang_tmpnull" onclick="selectyhdagn_tmp('noall');" style="width:50px;height: 28px; margin-top: 3px; padding: 0px;">
								<fmt:message key="phone.getinternet0462" /><!-- 反选	 -->					
							</button>
						</td>
						<td>
							<button class="tsdbutton" id="deleteyhdang_tmp" onclick="deleteyhdang_tmp()" style="height: 28px; margin-top: 3px; padding: 0px;display:none;">
								<fmt:message key="phone.getinternet0463" /><!-- 取消待装机号-->				
							</button>	
						</td>
					</tr>
				</table>	
				<div id="inputYhdang">			
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0081" /><!-- 固话信息 -->
				</div>
				<div id="inputtext">
					<div class="midd">
						<table id="tableyhdang" style="width:780px;">
							<tr style="display:none">
								<td class="wenzi">
									<span id="spanyucunYE"></span>
									<!-- 话费余额 -->
								</td>
								<td>
									<input type="text" id="phoneBalance" name="phoneBalance"
										value="0" style="width: 150" disabled="disabled" />
								</td>
								<td class="wenzi">
									<span id="spanxinyueHF"></span>
									<!-- 当前月话费 -->
								</td>
								<td>
									<input type="text" id="mothshuafei" name="mothshuafei"
										value="0" style="width: 150" disabled="disabled" />
								</td>
								<td class="wenzi">
									<span id="spanTjbz"></span>
									<!-- 停机标志 -->
								</td>
								<td>
									<input type="text" id="TJLogo" name="TJLogo" style="width: 150"
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
						</table>
					</div>
				</div>
				</div>
				</div>
				<div id='setYGDF_frame'>
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
										<select name="phonefeetype" id="phonefeetype" style="width: 160px;"
											onchange="getfeename()"></select>										
								</td>
							</tr>
							<tr>
								<td colspan="2">
						  			<div style="width:210px; height: 160px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
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
									<th width="10"><input type="checkbox" id="dhzftab_checkall" onclick="Dhzf_CheckAll()" style="width:15px;" /></th>
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
									<th width="75">
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
									</th>
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
						<input type="hidden" id="phonefeenamecode" name="phonefeename"/><!-- 子费用 -->
						<input type="hidden" id="feelv" name="feelv" style="width:150px" disabled="disabled" /><!-- 费率 -->
						<input type="hidden" id="TJfeelv" name="TJfeelv" style="width: 150px;" disabled="disabled" /><!-- 停机费率 -->
						<input type="hidden" id="ZFStartday" name="ZFStartday" style="width: 150px;" disabled="disabled" value="<%=Log.getSysTime() %>"/><!-- 起始时间 -->
						<input type="hidden" id="ZFEndday" name="ZFEndday" style="width: 150px;" disabled="disabled" value="2999-12-31"  /><!-- 终止时间 -->						
						<input type="hidden" id="CUNIT" name="CUNIT"/><!--最小计费单位-->
						</td>	
					</tr>	
				</table>
				</div>
				<!-- 				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					优惠套餐				
				</div> -->
				<div id="inputtext1" style="display:none">
					<table id="bytctab" style="width:760px;">
						<tr>
							<th width="10"><input type="checkbox" id="bytctab_checkall" onclick="Bytc_CheckALL()" style="width:15px;" /></th>
							<th width="170">
								<center>
									<h4>
										<span id="spanTCFN_table">费用名称</span>
										<!-- 费用名称 -->
									</h4>
								</center>
							</th>
							<th width="240">
								<center>
									<h4>
										<span id="spanTCLX_table">套餐类型</span>
										<!-- 套餐类型 -->
									</h4>
								</center>
							</th>
							<th width="140">
								<center>
									<h4>
										<span id="spanTCQSY_table">起始时间</span>
										<!-- 起始月 -->
									</h4>
								</center>
							</th>
							<th width="140">
								<center>
									<h4>
										<span id="spanTCZZY_table">终止时间</span>
										<!-- 终止月 -->
									</h4>
								</center>
							</th>
							<th width="140">
								<center>
									<h4>
										<span id="spanTCYS_table">月数</span>
										<!-- 月数 -->
									</h4>
								</center>
							</th>
						</tr>
					</table>
					<div
						style="display:none;width: 610px; height: 130px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="addspeediFeetype">
						</table>
					</div>
					
					<table id="bytcform" cellspacing="0" style="width:760px;">
						<tr>
							<td class="wenzi" style="line-height:30px;">
								优惠套餐
							</td>
							<td class="wenzix">
								<select name="Packagetype" id="Packagetype" style="width: 150px;"></select>
							</td>
							<td class="wenzi">
								起始时间
							</td>
							<td class="wenzix">
								<input type="text" name="TCStarttime" id="TCStarttime" disabled="disabled" 
									style="width: 150px;"  value="2999-12-31" />
							</td>
							<td class="wenzi">
								终止时间
							</td>
							<td class="wenzix">
								<input type="text" name="TCEndtime" id="TCEndtime" disabled="disabled" 
									style="width: 150px;" value="2999-12-31" />
							</td>
						</tr>						
					</table>
					<table>
						<tr>							
							<td colspan="6">
								<button class="tsdbutton" id="bytcadd" 
									onclick="Bytc_Save()"
									style="width:80px; height: 26px; margin-top: 3px; padding: 0px;">
									新增>>
								</button>
							
								<button class="tsdbutton" id="bytcdel" 
									onclick="Bytc_Del()"
									style="width:80px; height: 26px; margin-top: 3px; padding: 0px;">
									取消
								</button>
							</td>
						</tr>
					</table>
					<br />
				</div>
				<div id='setBYPkg_frame'>
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
						  	<tr>
						  		<td class="wenzi" align="right" style="width:65px;line-height:30px;">
										<fmt:message key="phone.getinternet0086" /><!-- 套餐组 -->
								</td>
								<td>
									<select name="Packaggroupid" id="Packaggroupid" style="width: 153px;" onchange="getPackagetypes()"></select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
						  			<div style="width:220px; height: 158px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7; border:1px 1px solid #dddddd;">
											<table id="Packagetypes" style="width:225px;" border="1" cellpadding="0">
											</table>											
									</div>
						  		</td>
						  		<td>
						  			<input type="hidden" id="Packagetypeshidden"/><!-- 包月套餐费用项值提交到临时时取该值进行保存 -->
						  		</td>
							</tr>
						  </table>
					 	 </td>
				 	 	 <td class="wenzi">
				 	 		<table cellspacing="1">
				 	 			<tr>
				 	 				<td width=5% style="margin-left: 0px;"></td>
				 	 			</tr>				 	 							  				
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcadd" 
											onclick="Bytc_Saves()"
											style="width:80px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcdels" 
											onclick="Bytc_Dels()"
											style="width:80px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0084" /><!-- 取消 -->
										</button></center>
				  					</td>
				  				</tr>
				 	 		</table>
				 	 	</td>
				 	 	<td valign="top">				 	 		
				 	 		<table id="dzhthcontent"  style="width:453px;">
				 	 			<tr>
									<th width="20"><input type="checkbox" id="bytctab_checkalls" onclick="Bytc_CheckALL('tc')" style="width:15px;" /></th>
									<th width="280">
										<center>
											<h4>
												<span id="spanTCLX_tables"><fmt:message key="phone.getinternet0087" /><!-- 套餐类型 --></span>
												<!-- 套餐类型 -->
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
				 	 		<div style="width:460px; height: 170px; overflow-y: scroll; overflow-x: hidden;">
				 	 		<table id="bytctabs" style="width:455px;" >
								
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
				<table cellspacing="8" >
					<tr>
				  		<td><fmt:message key="phone.getinternet0088" /><!-- 起始时间 --></td>
				  		<td><input type="text" name="TCStarttimes" id="TCStarttimes" disabled="disabled" 
							style="width: 100px;"  value="<%=Log.getSysTime() %>"/></td>
				  		<td><fmt:message key="phone.getinternet0089" /><!-- 终止时间 --></td>
				  		<td><input type="text" name="TCEndtimes" id="TCEndtimes" disabled="disabled" 
									style="width: 100px;" value="2999-12-31" /></td>
						<td>
							<button id="dzpkg" onclick="getDZblock()"  class="tsdbutton"  style="margin-left: 20px;">打折</button>
						</td>
						<td>
							<input type="text" id="pkg_rateStr" disabled="disabled"/>
						</td>			
				    </tr>
				</table>	
				</div>
				<div id="setBusinesContext_frame">				
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneyewu.yewuggnmqr" />
					<!-- 业务更改内容确认 -->
				</div>
				<div id="inputtext2">
					<table cellspacing="0" style="width:760px;">
					<tr>
						<td style="width:460px;">
							<table id="ffltab" style="width:460px;">
								<tr>
									<td class="wenzi" style="width:80px;">
										<fmt:message key="phone.getinternet0090" /><!-- 付费方式 -->
									</td>
									<td class="wenzix">
										<select name="fufeitype" id="fufeitype" style="width: 140px" class="you1" onchange="payWayChange(this)"></select>
									</td>
									<td class="wenzi">
										<fmt:message key="phone.getinternet0091" /><!-- 应交合计 -->
									</td>
									<td class="wenzix">
										<input type="text" name="yjfee" id="yjfee" style="width: 130px;" disabled="disabled"  class="you1" onkeypress="numValid(this)"
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false"/>
								   </td>
								   <td>
								     <table id="bytctabs" style="width:330px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
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
									style="width:440px; height: 110px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
									<div id="zafeilist" style="width: 100%; float: left;">
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
										<input type="text" name="Paymoney" id="Paymoney"
											style="width:260px" disabled="disabled" class="you1" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
			 </table>
			</div>
			<div id="setYCFee_frame"> 
			<hr style="border: 1px dotted #CCCCCC;" />
			<table cellspacing="5" id="ycfeetable" style="background-color:#f7f7f7">
						<tr>
							<td>
								<table cellspacing="0" style="display:none">
									<tr>
										<td>
											<input type='checkbox' name="danweiHTHbox" id="danweiHTHbox"
												style="width: 22px; padding: 0px;" disabled="disabled" onclick="isnotdanwei()" />
										</td>
										<td>
											<font color="red"><fmt:message key="phoneyewu.isnotdwff" /><!-- 是否单位付费 --></font>
										</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;
											<fmt:message key="phoneyewu.dwHTH" /><!-- 单位合同号 -->
										</td>
										<td>
											<input type="text" name="danweiHTH" id="danweiHTH"
												style="width: 150px;" disabled="disabled" />
										</td>
									</tr>
								</table>
								<table cellspacing="5">
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
								</table>
								</td>
								<td>
									<table>
										<tr>
										    <td valign="top">
												<fmt:message key="phoneyewu.memo" />：
												<!-- 备注 -->												
											</td>
										</tr>
										<tr>
											<td><textarea name="tBz" id="tBz" rows="4" cols="60" style="width:300px;" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea></td>	
										</tr>
									</table>
								</td>
							</tr>
					</table>	
			</div>		
			 <div class="title" style="display:none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					设置工单发送部门
				</div>
				<table cellspacing="5" style="display:none;">
					<tr>
						<td>
							发送部门
						</td>
						<td>
							<select id="fsbm" style="width:150px;"></select>
						</td>
				    </tr>
				</table> 			  								
			</div>													
			<div id="buttons">
				<center>					
					<button id="save" onclick="cddh_Save()"
						style="margin-left: 20px;display:none;">
						<fmt:message key="phone.getinternet0464" /><!-- 存档 -->
					</button>
					<button id="save" onclick="Dhzj_Save()"
						style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onclick="Dhzj_Reset()" style="margin-left: 20px;">
						<!-- 重置 -->
						<fmt:message key="AddUser.Reset" />
					</button>
				</center>
			</div>
		<div id="buttons">
		<table style="width:780px;">
		  <tr id="nextTS">
			<!-- <td><center><a href="javascript:void(0)" onclick="ghcontextShow()" style="color:red;font-size:16px;">下一步操作</a></center></td> -->
		  	<td><button href="javascript:void(0)" onclick="ghcontextShow()" style="color:red;font-size:20px;margin-left: 400px;">下一步操作</button></td>
		  </tr>
		</table>
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
		<input type="hidden" id="setdaijiao" />
		<input type="hidden" id="reportparam" />
		<input type="hidden" id="jobidid" />
		<input type="hidden" id="ppaytype" />
		<input type="hidden" id="fee" />
		<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
		<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
		<input type="hidden" id="bmtypekey"/><!-- 部门编号 -->		
		<input type="hidden" id="sbmcode"/><!-- 部门编号 -->
		<input type="hidden" id="sbmname"/><!-- 部门名称 -->
		<input type="hidden" id='selbz'/><!-- 电话站标识 -->
		<input type="hidden" id="mokuaiju"/><!-- 电话模块局 -->
		<input type="hidden" id="selecththvaluekey"/><!-- 选择合同号 单击时把值放到隐藏域 -->
		<input type="hidden" id="konghaoarearight"/><!-- 去空号的区域权限值 -->	
		<input type="hidden" id="selecththright"/><!-- 选择合同号权限 -->			
		<input type="hidden" id="keyhidden"/><!-- 固话费参数个数 -->
		<input type="hidden" id="startdate" value="<%=Log.getSysTime() %>"/><!-- 固定费用起始日期 -->
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
		<input type="hidden" id="stiffbusinestype" value="phoneZJ"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="bytctimedisabeld"/><!-- 包月套餐时间变更标志 -->
		<input type="hidden" id="stryhdang_tmpvalue"/><!-- 将删除的电话号凭借成参数 -->
		<input type="hidden" id="areatype"/><!-- 区域类型 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<input type="hidden" id="Bz2right"/><!-- 一级部门是否代收 -->
		<input type="hidden" id="selecththarearight"/>
		<input type="hidden" id="cycle"/><!-- 获取是一次性套餐或是连续套餐 -->
		<input type="hidden" id="Dh_hidden"/>
		<select id="yhxz_hidden" style="display:none;"></select>
		<jsp:include page="phone_internet.jsp" flush="true"/>
		<input type="hidden" id="businesstype" value="p_setup"/><!-- 该页面的业务类型 -->	
	</body>
	<script>
	var hilighter2 = new TableRowHilighter(document.getElementById('addspeediFeetype'), 0, 'lightsteelblue');
	var hilighter3 = new TableRowHilighter(document.getElementById('queryHTHdw'), 0, 'lightsteelblue');
  </script>
</html>