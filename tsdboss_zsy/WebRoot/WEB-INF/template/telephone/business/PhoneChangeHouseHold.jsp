﻿<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhoneChangeHouseHold.jsp
    Function:   电话过户
    Author:     wenxuming
    Date:       2011-01-10
    Description: 
    Modify: 
     
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<title>电话过户业务</title>
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
		<!-- 此页面砖用 -->
		<script src="script/telephone/business/phone_kjbq_gh.js" type="text/javascript" language="javascript"></script>
		<script src="script/telephone/business/phoneInstalled_new_huos.js" type="text/javascript"></script>
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>	
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>	
		<!-- 打印报表弹出窗口 -->
		<script src="script/telephone/business/businessreprint.js" type="text/javascript" language="javascript"></script>
		<script src="script/telephone/business/pkgPriceDiscount.js" type="text/javascript" language="javascript"></script>
		<script type="text/javascript">
	       jQuery(document).ready(function()
		   {	    
		    $("#navBar").append(genNavv());
		    getinternation();	//businesspublic.js中  自动加载显示框	        
		    //PageInitial();			
		    ghPayMoney('p_changeuser');//根据过户标识查询一次性费用
		    $("#ghSearchBox").select();
		    $("#ghSearchBox").focus();
		    $("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");
			$("#changehouse select").attr("disabled","disabled");
		    $("#changehouse :text").attr("disabled","disabled");
		    $.ajax({
					url:"phone_querydate?func=query",
					async:true,//异步
					cache:false,
					timeout:20000,//1000表示1秒
					type:'post',
					success:function(xml,textStatus)
					{	
						//取缴费方式 返回的是html格式
					    var syhlb = xml.substring(xml.indexOf("<yhlb=")+6,xml.indexOf("yhlb/>"));					    
					    var yhxz = xml.substring(xml.indexOf("<yhxz=")+6,xml.indexOf("yhxz/>"));					   
					    var CallSheduleNo = xml.substring(xml.indexOf("<CallSheduleNo=")+15,xml.indexOf("CallSheduleNo/>"));
					    var dhgn = xml.substring(xml.indexOf("<dhgn=")+6,xml.indexOf("dhgn/>"));
					    $("#usertype").html(syhlb);					   
						$("#CallSheduleNo_new").html(CallSheduleNo);
						$("#newDhgn").html(dhgn);
						$("#UserTypeyhdang").html(yhxz);
						$("#yhxz_hidden").html(yhxz);
					}	
				});
			internation();    			
			gethide('p_changeuser');//WebRoot/script/telephone/business/businesspublic.js文件中隐藏页面模块
			gettable();//默认加载固定费表格现实phone_kibq_gh.js函数中
			getfufeitype();//付费类型
			///电话杂费  终止日
			$("#TCEndtime").focus(function(){
				WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});			
			$("#TCStarttime").focus(function(){
				WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});
			$("#TCEndtimes").focus(function(){
				WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});
			$("#TCStarttimes").focus(function(){
				WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});		
		   });
		   
		/********
        *生成付费类型下拉框
        *@param;
       	*@return;
        ********/
        function getfufeitype()
        {
           $("#cPayType").empty();
           var querysel='';
		   var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfigkemu",6,"&kemu=pbusinessfee&tsection=payitem");
				if(res[0]==undefined || res[0][0]==undefined)
        		{
        			return false;
        		}
        	for(var i=0;i<res.length;i++){
        		querysel+="<option value="+res[i][0]+">"+res[i][1]+"</option>";
        	}
		   $("#cPayType").html(querysel);
		   $("#cPayType").val("tuoshou");
        }
		   
		   	/*******
		   	* 从真实姓名对应的多个账户中选择要查询的账户
		   	* @param: Yhmc用户名称、Dh电话、Yhdz用户地址;
		   	* @return;
		  	 ********/
			function userChoose(Yhmc,Dh,Yhdz)
			{
			    var yw=fetchMultiArrayValue("select.yw",6,"&dh="+Dh);
			    $("#yw").val(yw);
				var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_changeuser")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
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
				var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(*) as cont&tablename=insteadoffee&key=dh='"+Dh+"'");
				if(res!="0"&&res!=undefined){
					//alert("查询的电话【"+Dh+"】有代缴费用信息，过户时请注意是否处理代缴项！");
					alert("<fmt:message key="phone.getinternet0281" />"+Dh+"<fmt:message key="phone.getinternet0282" />");
				}
				var reshth = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=hth&tablename=yhdang&key=dh='"+Dh+"'");
				var resdjhth = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(*) as cont&tablename=insteadoffee&key=INSTEADHTH='"+reshth+"'");
				if(resdjhth!="0"&&res!=undefined){
					//】被其他电话所代缴，过户时请注意是否处理代缴项！
					alert("<fmt:message key="phone.getinternet0281" />"+reshth+"<fmt:message key="phone.getinternet0283" />");
				}
				$("#changehouse select").removeAttr("disabled");
				$("#changehouse :text").removeAttr("disabled");
				$("#hth").attr("disabled","disabled");
				$("#tablehthdang").empty();
				geththtable();//加载合同号信息显示框
			    $("#tablehthdang select").attr("disabled","disabled");
				$("#tablehthdang :text").attr("disabled","disabled");
				$("#tableyhdang select").attr("disabled","disabled");
				$("#tableyhdang :text").attr("disabled","disabled");
				$("#geththsbm :text").attr("disabled","disabled");
				$("#sAddress").val(Yhdz);
				ghSerBasicInfo(Dh);
				ghZF(Dh);
				gethTC(Dh);
				getdhBYTC(Dh);
				setTimeout("gethffee()",500);
				setTimeout("getphonefeename()",500);//固定费下拉选项script/telephone/business/phone_kjbq_gh.js
				addspeediFeeType(Dh);//固话杂费设置scrip·t/telephone/business/phone_kjbq_gh.js	
				getPackaggroupid();//套餐下拉选项script/telephone/business/phone_kjbq_gh.js
				Bytc_Refreshs(Dh);//包月套餐设置script/telephone/business/phone_kjbq_gh.js	
				setTimeout("getyhxzstr('p_movewithoutarea')",500);	
				$("#Bm2_yhdang").removeAttr("disabled");
				$("#Bm3_yhdang").removeAttr("disabled");
				$("#Bm4_yhdang").removeAttr("disabled");	
				ghPayMoney('p_changeuser');//根据过户标识查询一次性费用
				setTimeout($.unblockUI,1);
				
			}	
			
			function setYhdangBm(){
				$("#Bm1_yhdang").val($("#sBm1").val());
				$("#Bm2_yhdang").val($("#sBm2").val());
				$("#Bm3_yhdang").val($("#sBm3").val());
				$("#Bm4_yhdang").val($("#sBm4").val());
			}					

			//判断用户费用
			function gethffee(){
				var hffee = $("#phoneBalance").val().replace(/(^\s*)|(\s*$)/g,"");				
				hffee = parseFloat(hffee,10);
				var czyfee = $("#czyfee").val();
				if(czyfee=="NO"){
					//alert("该账号已欠费"+hffee+"元，请结清费用！");
					//alert("<fmt:message key="phone.getinternet0272" />"+hffee+"<fmt:message key="phone.getinternet0273" />");
				}else if(czyfee=="YES"){
					var yefeevalue = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1) as cont&tablename=yhdang&key=hth='"+$("#Hth").val()+"' and nvl(delbz,'tsd')<>'delete'");
					if(yefeevalue=="1"&&$("#Yhlb").val()!="<fmt:message key="phone.getinternet0384" />"){//公费
						//alert("该账号有余额"+hffee+"元，请退费处理！");
						alert("<fmt:message key="phone.getinternet0274" />"+hffee+"<fmt:message key="phone.getinternet0275" />");
					}
				}
			}
        
        
        
        //设置代缴默认值跟权限值
        function setBz2(){
        	if($("#sBm2").val()!=""){
					$("#Bz2_hthdang").val('Y');	//默认大客户代收为是
					$("#Bz2_hthdang").removeAttr("disabled");
				}else{
					$("#Bz2_hthdang").val('N');	//默认大客户代收为否
					$("#Bz2_hthdang").attr("disabled","disabled");
				}				
			//此处必须放在下面			
			var Bz2right = $("#Bz2right").val();
				if(Bz2right=='true'){
					$("#Bz2_hthdang").removeAttr("disabled");
				}
        }	
		
        /**********************
		*开户和修改属性的合同号信息跟固话信息自动加载，并可对必选项进行配置
		*@arraybtfield全局变量@arrraydaijiaohth全局变量
		***********************/
		//全局变量arraybtfield 自动加载取出必选项放到该数组中，提交的时候判断哪些为必选；		
	    var arraybtfield = [];
	    //全局变量arrraydaijiaohth 在加载的时候把所有字段放到该数组，保存提示判断时用到
	    var arrraydaijiaohth = [];	    
        //字段名国际化
        function internation(){
          var languageType = $("#languageType").val();
          //自动加载代缴合同号编辑区
        	var str = getFields("daijiao");
        	var Dat = loadData("daijiao","zh",2);
        	var tabletr="<tr>";         		
          		var rsss = fetchFieldAlias('daijiao',languageType);        		
        		var j=0;
        		for(var i=0;i<Dat.FieldName.length;i++){
        			var str = rsss[Dat.FieldName[i]];
        			if(Dat.FieldName[i]!='dh'){
        				arrraydaijiaohth.push(Dat.FieldName[i]);
        				tabletr +="<td class='labelclass' style='width:20%'>"+str+"</td>";
        				tabletr +="<td style='width:30%'><input type='text' name="+Dat.FieldName[i]+" id="+Dat.FieldName[i]+" / ></td>";
        				j++;
        			}
        			if(j%2==0){
        				tabletr +="</tr><tr>";
        			}
        		}
        	tabletr+="</tr>";
        	$("#daijiaoinput").append(tabletr);
        }	       
        
        /*******
	   	* 查询手动填写的空号是否在空号表里
	   	* @param:xdh电话;
	   	* @return;
	  	 ********/
        function getisnotnullphone(xdh){
        	var boolean='false';
        	var res = fetchSingleValue("PhoneGH.getisnotnullphone",6,"&dh="+xdh);
        	if(res!=0){
        		boolean='true';
        	}
        	return boolean;
        }
        
        /*******
	   	* 修改保存是调用该方法
	   	* @param;
	   	* @return;
	  	 ********/
        function saveUpdate(){
        	/*
        	//判断是否可以办理该业务	       	
			if(!gethffee())
			{
				return false;
			}*/
        	tsd.QualifiedVal=true;        	 
        	var params = "";
        	var sdh = $("#Dh_yhdang").val();        	
        	sdh=sdh.replace(/(^\s*)|(\s*$)/g,"");
        	if(sdh.length==0){
        		//alert("请选择要办理该项业务的电话号码");
				alert("<fmt:message key="phone.getinternet0176" />");
        		$("#ghSearchBox").select();$("#ghSearchBox").focus();return false;} 
            //新合同号
			var chth = $("#hth").val();
			if(chth=="")
			{
				//alert("合同号不能为空,请生成、输入或选择一个合同号");
				alert("<fmt:message key="phone.getinternet0286" />");
				return false;
			}
			params += "&sDh=";
		    params += tsd.encodeURIComponent($("#Dh_yhdang").val());
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
			 	params += "&"+Dat.FieldName[i]+"hth="+tsd.encodeURIComponent(strhth);
			 }	
			 		var Email = $("#Email_hthdang").val();//邮件地址  
					if(Email!=undefined){
			        	Email=Email.replace(/(^\s*)|(\s*$)/g,"");	
						var emailRegExp = new RegExp("[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
						if ((!emailRegExp.test(Email)||Email.indexOf('.')==-1)&&Email!=""&&$("#Email_hthdang").attr("disabled")!=true){
							alert("<fmt:message key="phone.getinternet0029" />");
							$("#Email_hthdang").select();
							$("#Email_hthdang").focus();
							return false;
						}
					}
					//身份证号码
		        	var IDCard = $("#IDCard_hthdang").val();        	
			        if($("#IDCard_hthdang").attr("disabled")!=true&&IDCard!=""&&!/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(IDCard)&&IDCard!=undefined)
		        	{
			        	alert("<fmt:message key="phone.getinternet0030" />");
			        	$("#IDCard_hthdang").select();
			        	$("#IDCard_hthdang").focus();
			        	return false;
		        	}
		        	//合同号一级部门
		        	var chthbm1 = $("#sBm1").val();
					/*
		        	var resgfhth = fetchSingleValue("dbsql_phone.queryhthdanghth",6,"&hth="+tsd.encodeURIComponent($("#Hth_hthdang").val()));
					if(resgfhth==undefined||resgfhth=='0')
					{
			        	if($("#usertype option:selected").text()=="<fmt:message key="phone.getinternet0384" />"&&$("#sBm1").val()=="")
			        	{
			        		alert("<fmt:message key="phone.getinternet0033" />");
			        		$("#sBm1").select();
			        		$("#sBm1").focus();
			        		return false;
			        	}
		        	}
					*/
		        	params += "&chthbm1=";
		        	params += tsd.encodeURIComponent(chthbm1);
		        	//合同号二级部门        	
		        	var chthbm2 = $("#sBm2").val();
		        	params += "&chthbm2=";
					params += tsd.encodeURIComponent(chthbm2);
					//合同号三级部门        	
		        	var chthbm3 = $("#sBm3").val();
		        	params += "&chthbm3=";
					params += tsd.encodeURIComponent(chthbm3);
					//合同号二级部门        	
		        	var chthbm4 = $("#sBm4").val();
		        	params += "&chthbm4=";
					
					params += "&bm1_yhdang=";
		        	params += tsd.encodeURIComponent($("#Bm1_yhdang").val());
		        	//yhdang二级部门        	
		        	params += "&bm2_yhdang=";
					params += tsd.encodeURIComponent($("#Bm2_yhdang").val());
					//yhdang三级部门        	
		        	params += "&bm3_yhdang=";
					params += tsd.encodeURIComponent($("#Bm3_yhdang").val());
					//yhdang二级部门        	
		        	params += "&bm4_yhdang=";
					params += tsd.encodeURIComponent($("#Bm4_yhdang").val());				
			var oldHth = $("#Hth_yhdang").val();
			oldHth=oldHth.replace(/(^\s*)|(\s*$)/g,"");			
			if($("#Hth_hthdang").val().replace(/(^\s*)|(\s*$)/g,"")==oldHth){
				//alert("新合同号与原合同号一样，请重新输入");
				alert("<fmt:message key="phone.getinternet0287" />");
				return;
			}			
			params += "&OldHth=";
			params += tsd.encodeURIComponent(oldHth);
			var xusername = $("#xusername").val();
			xusername=xusername.replace(/(^\s*)|(\s*$)/g,"");
			params += "&xusername=";
			params += tsd.encodeURIComponent(xusername);
			
			var TransferFee = $("#TransferFee").val();
			if(TransferFee==""){
				//alert("请选择是否转账金额！");
				alert("<fmt:message key="phone.getinternet0289" />");
				$("#TransferFee").select();$("#TransferFee").focus();return false;}			
			params += "&TransferFee=";
			params += tsd.encodeURIComponent(TransferFee);			
			//备注
        	var tBZZZ = $("#phonepkBz").val();
        	params += "&zwbz=";
			params += tsd.encodeURIComponent(tBZZZ);						
			//工号
			var uuserid = $("#userid").val();
			params += "&UserID=";
			params += tsd.encodeURIComponent(uuserid);
			//部门
			var udepart = $("#depart").val();
			params += "&Depart=";
			params += tsd.encodeURIComponent(udepart);
			var userareaid = $("#userareaid").val();
			params += "&userarea=";
			params += tsd.encodeURIComponent(userareaid);
			//区域营业厅
			var uarea = $("#area").val();
			params += "&Area=";
			params += tsd.encodeURIComponent(uarea);			
			//是否付费
        	var jfufeicheckbox = $("#fufeicheckbox").attr("checked");        	        	
        	//付费方式
        	var jfufeitype = $("#cPayType").val();        	
        	params += "&jfufeitype=";
			params += tsd.encodeURIComponent(jfufeitype);        	
        	//应缴费用
        	var jyjfee = $("#cYingJiao").val().replace(/(^\s*)|(\s*$)/g,"");
        	if(jyjfee==""){jyjfee=0;}
        	params += "&jyjfee=";
			params += tsd.encodeURIComponent(jyjfee);
        	//实收费用
        	/*
        	var jfflsjfy = $("#cShiShou").val().replace(/(^\s*)|(\s*$)/g,"");
        	if(jfflsjfy==""){jfflsjfy=0;}
        	params += "&sjfee=";
			params += tsd.encodeURIComponent(jfflsjfy);*/        	
        	//缴费款项
        	var jPaymoney = $("#cPayItem").val();
        	jyjfee = parseFloat(jyjfee,10);
			//jfflsjfy = parseFloat(jfflsjfy,10);	
			if(jyjfee==0){jPaymoney="";}
			//if(jyjfee!=0&&jfflsjfy==0){alert("请输入实缴费用！");$("#jfflsjfy").select();$("#jfflsjfy").focus();return false;}	
        	if(jPaymoney==""||jPaymoney==undefined){jPaymoney="";}
        	params += "&feename=";
			params += tsd.encodeURIComponent(jPaymoney);						
        	
        	//联系人
        	var linkman = $("#Bz8_yhdang").val();
        	params += "&lxr=";
			params += tsd.encodeURIComponent(linkman);
			//联系电话
        	var lxdh = $("#Bz9_yhdang").val();
        	params += "&lxdh=";
			params += tsd.encodeURIComponent(lxdh);
			
			//新呼出权限
			//var newDhgn = $("#newDhgn").val();
			//params += "&newDhgn=";
			//params += tsd.encodeURIComponent(newDhgn);
			
			//新催缴策略
			var CallSheduleNo_new = $("#CallSheduleNo_new").val();
			params += "&newCallSheduleNo=";
			params += tsd.encodeURIComponent(CallSheduleNo_new);
			var UserTypeyhdang = $("#UserTypeyhdang").val();
			if(UserTypeyhdang==""){
				//alert("请选择固话用户性质！");
				alert("<fmt:message key="phone.getinternet0290" />");
				$("#UserTypeyhdang").select();
				$("#UserTypeyhdang").focus();
				return;
			}
			params += "&UserType_yhdang=";
			params += tsd.encodeURIComponent(UserTypeyhdang);
			
			//2016-01-14 donglei 添加 是否带费用过户
			if($("#withfee").attr("checked")){
				params += "&withfee=1";
				var HthLimit = tsd.encodeURIComponent($("#Dh_yhdang").val());
				params += "&HthLimit="+HthLimit;
			}
			params += withfee;
			var loginfo = "<fmt:message key="phone.getinternet0406" />:";//电话过户
			loginfo += "(<fmt:message key="phone.getinternet0103" />:";//电话
			loginfo += sdh;
			loginfo += ")(<fmt:message key="phone.getinternet0407" />:";//原合同号
			loginfo += oldHth;
			loginfo += ")(<fmt:message key="phone.getinternet0408" />:";//新合同号
			loginfo += $("#hth").val();
			loginfo += ")(<fmt:message key="phone.getinternet0409" />:";//原账户名
			loginfo += $("#oldhthyhmc").val();
			loginfo += ")(<fmt:message key="phone.getinternet0410" />:";//新账户名
			loginfo += $("#Yhmc_hthdang").val();
			loginfo += ")(<fmt:message key="phone.getinternet0411" />:";//新用户姓名 
			loginfo += xusername;
			loginfo += ")(<fmt:message key="phone.getinternet0412" />:";//金额是否转移
			loginfo += TransferFee+")";
			loginfo = tsd.encodeURIComponent(loginfo);
			params+="&ywbz="+loginfo;
			params+="&YwArea="+tsd.encodeURIComponent($("#yw").val());
			
        	if(tsd.Qualified()==false){return false;}
        	var result = fetchMultiPValue("PhoneChangeHouseHold_saveupdate",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]==-1)
			{
				//alert("业务失败");
				alert("<fmt:message key="phone.getinternet0193" />");
			}
			else
			{
				//操作成功		
				//操作成功
				$("#jobidid").val(result[0][0]);
				$("#ppaytype").val(jfufeitype);
				$("#fee").val(jyjfee);			
				$("#ghSearchBox").select();
			    $("#ghSearchBox").focus();					
				//判断是否打印工单，从tsd_ini表中配置Y为打印
				printworkorder('p_changeuser');//script/telephone/business/businessreprint.js中
				writeLogInfo("","update",loginfo);	
				pageReset();			
			}
        }
        
        /*******
	   	* 重置
	   	* @param;
	   	* @return;
	  	 ********/
        function pageReset(){
	  		$("#withfee").attr("checked",false);
        	$(":text").val("");
			$("#tablehthdang :text").val("");
        	$("#tablehthdang select").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");
        	$("#geththsbm").removeAttr("disabled");
        	$("#cPayType").val("cash").trigger("change");
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();
			$("#phonefeetype").empty();
			$("#Packaggroupid").empty();
			$("#Packagetypes").empty();
			$("#phonefeename").empty();
			$("#dhzftab").empty();
			$("#bytctabs").empty();
			$("#cPayType").val("cash");
			$("#danweiHTHbox").removeAttr("checked");
			ghPayMoney('p_changeuser');//根据过户标识查询一次性费用				
			$("#dhBYTC").empty();
			$("#sBm1").val("");
			$("#sBm2").val("");
			$("#sBm3").val("");
			$("#sBm4").val("");
			$("#TransferFee").val("");
			$("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#changehouse select").attr("disabled","disabled");
		    $("#changehouse :text").attr("disabled","disabled");
		    refreshbusinessfee();
		    gethide('p_changeuser');//WebRoot/script/telephone/business/businesspublic.js文件中隐藏页面模块
		    gettable();//默认加载固定费表格现实phone_kibq_gh.js函数中
		    $("#CallSheduleNo_new").val("");
		    $("#UserTypeyhdang").val("");
		    $("#usertype").val("");
			unLockDh();
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
	   	   
        //选择用户类别时触发事件
        function changeyhlb(){
			geththedite();//businesspublic.js中  自动加载显示框合同号可编辑的显示框
        	getyhxzstr('p_movewithoutarea');
        	if($("#usertype option:selected").text()!="<fmt:message key="phone.getinternet0384" />"){
					$("#sBm1").val("");
					$("#sBm2").val("");
					$("#sBm3").val("");
					$("#sBm4").val("");
				}	
			$("#geththsbm").removeAttr("disabled");				
        }
      	
	   </script>
	</head>
	<body onUnload="unLockDh()">
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
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
								<select id="ghSearchWay" style="width:100px;">
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
								<button class="tsdbutton" id="submitButton"
									onclick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
								</button>
							</td>
							<td>
								<input type="checkbox" id="withfee" style="display:none;width:30px;" />
								
							</td>
							<td width="290"><!-- 不带费用过户 --></td>
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
					<fmt:message key="phone.getinternet0182" /><!-- 合同号信息显示-->&nbsp;<input type="checkbox" id="hthshowcheck" checked="checked" onClick="getshow()" style="width:15px;" />
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
						<fmt:message key="phone.getinternet0195" /><!-- 变更内容 -->
					</div>
					<div id="inputtext">
					 <div id="changehouse">
					  <table cellspacing="4" id="geththsbm">
						<tr>
						<td class="wenzi"><span id="spanBm1"></span></td>
						<td><input type="text" id="sBm1" style="width:140px;" disabled="disabled"/><font color="red"><span id="bixuantype"></span></font>
						<input type="hidden" id="sBm1code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="yijisBmhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td class="wenzi"><span id="spanBm2"></span></td>
						<td><input type="text" id="sBm2" style="width:140px;"/>
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
						<td class="wenzi"><span id="spanBm3"></span></td>
						<td><input type="text" id="sBm3" style="width:140px;"/>
						<input type="hidden" id="sBm3code" style="width:150px;" disabled="disabled"/>
						</td>
						<td>
						<button class="tsdbutton" id="setHth" 
						onclick="addsBmsanhth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
						<fmt:message key="phone.getinternet0075" /><!-- 选择 -->
						</button>
						</td>
						<td class="wenzi"><span id="spanBm4"></span></td>
						<td><input type="text" id="sBm4" style="width:140px;"/>
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
					<table>
						<tr>
							<td class="wenzi">&nbsp;
								<fmt:message key="phone.getinternet0074" /><!-- 用户类别 -->
							</td>							
							<td class="wenzix"><select id="usertype" style="width:140px;" onChange="javascript:$('#hth').val('');$('#Hth').val('');changeyhlb();$('#geththsbm select').removeAttr('disabled');"></select></td>
							<td class="wenzi">
								<fmt:message key="phone.getinternet0277" /><!-- 新 --><span id="spanhth"></span>
								<!-- 合同号 -->
							</td>
							<td class="wenzix">
								<input type="text" name="hth" id="hth" style="width: 150px"
									disabled="disabled" />
								<input type="hidden" name="gfhth" id="gfhth" />
							</td>
							<td colspan="4">
								&nbsp;&nbsp;&nbsp;&nbsp;
								<button class="tsdbutton" id="setHth" 
									onclick="GenerateHth('p_changeuser');" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0077" /><!-- 生成合同号 -->
								</button>
								<button class="tsdbutton" id="setHth" 
									onclick="InputHth();" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;display:none;">
									<fmt:message key="phone.getinternet0078" /><!-- 输入合同号 -->
								</button>
								<button class="tsdbutton" id="setselectHth" 
									onclick="selecthth('1')" 
									style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0079" /><!-- 选择合同号 -->											
								</button>
								<button class="tsdbutton" id="setHth" 
									onclick="GenerateHth()" 
									style="height: 28px; margin-top: 3px; padding: 0px;display:none;">
									生成新合同号
									<!-- 设置单位合同号 -->
								</button>
								<button class="tsdbutton" id="setDJHth" 
									onclick="setDJHTH()" 
									style="height: 28px;width:90px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phoneyewu.setdjhth" />
									<!-- 设置代缴合同号 -->
								</button>
							</td>							
						</tr>	
						<tr>
							<td class="wenzi"><fmt:message key="phone.getinternet0291" /><!-- 新用户姓名 --></td>
							<td class="wenzix">
								<input type="text" id="xusername" name="xusername" style="width:150px;"/>
							</td>
							<!--<td><fmt:message key="phone.getinternet0292" /></td --><!-- 新催缴策略 -->
							<!--<td>
								<select id="CallSheduleNo_new" style="width:150px;"></select>
							</td>-->
							<td class="wenzi" style="display:none"><fmt:message key="phone.getinternet0293" /><!-- 新呼出权限--></td>
							<td class="wenzix" style="display:none">
								<select id="newDhgn" style="width:150px;"></select>
							</td>
							<td class="wenzi"><fmt:message key="phone.getinternet0294" /><!-- 用户性质--></td>
							<td class="wenzix">
								<select id="UserTypeyhdang" style="width:150px;"></select><font style="color:red">*</font>
							</td>
							<td style="display:none;">&nbsp;<font color="red">账户金额是否转移</font></td>
							<td style="display:none;">&nbsp;&nbsp;
								<select id="TransferFee" style='width:90px;'>
									<option value='N'>待留</option>
									<option value='Y'>转移</option>
								</select>
							</td>							
						</tr>
					</table>
				  </div>	
				</div>					
				<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0183" /><!--固话信息显示-->&nbsp;<input type="checkbox" id="yhdangshowcheck"  onclick="getshow()" style="width:15px;" />
					</div>
				<div id="inputtext">
						<div class="midd">
							<table id="tableyhdang" style="width:780px;"></table>
						</div>	
				</div>																							
				<div class="title" style="display:none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0184" /><!--固定费信息显示-->&nbsp;
				</div>
				<table style="display:none;">
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
									<th width="100">
										<center>
											<h4>
												<span id="spanFeeType_table"></span>
											</h4>
										</center>
									</th>
									<th width="164">
										<center>
											<h4>
												用户类型
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
				<div class="title" style="display:none">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
				<fmt:message key="phone.getinternet0185" /><!--优惠套餐信息显示-->
				</div>
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="dhTCX"
					width="780" style="display:none">
				</table>
				<div id='setBYPkg_frame'>
				<div class="title" style="display: none;">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0186" /><!--包月套餐信息显示-->&nbsp;
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
									<select name="Packaggroupid" id="Packaggroupid" style="width: 157px;" onChange="getPackagetypes()"></select>
								</td>
							</tr>
							<tr>
								<td colspan="2">
						  			<div style="width:225px; height: 158px; overflow-y: scroll; overflow-x: hidden;background-color:#f7f7f7;border:1px 1px solid #dddddd;">
											<table id="Packagetypes" style="width:225px;" border="1" cellpadding="0"></table>											
									</div>									
						  		</td>
						  		<td>
						  			<input type="hidden" id="Packagetypeshidden"/><!-- 包月套餐费用项值提交到临时时取该值进行保存 -->
						  		</td>
							</tr>
						  </table>
					 	 </td>
				 	 	 <td class="wenzi" style="width:70px;">
				 	 		<table cellspacing="1">
				 	 			<tr>
				 	 				<td width=5% style="margin-left: 0px;"></td>
				 	 			</tr>				 	 							  				
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcadd" 
											onclick="Bytc_Saves()"
											style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0083" /><!-- 新增>> -->
										</button></center>
				  					</td>
				  				</tr>
				  				<tr>
				  					<td colspan="2"><center>
				  						<button class="tsdbutton" id="bytcdels" 
											onclick="Bytc_Dels()"
											style="width:60px; height: 26px; margin-top: 3px; padding: 0px;">
											<fmt:message key="phone.getinternet0084" /><!-- 取消 -->
										</button></center>
				  					</td>
				  				</tr>
				 	 		</table>
				 	 	</td>
				 	 	<td valign="top">				 	 		
				 	 		<table id="dzhthcontent"  style="width:463px;">
				 	 			<tr>
									<th width="20"><input type="checkbox" id="bytctab_checkalls" onClick="Bytc_CheckALL('tc')" style="width:15px;" /></th>
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
				 	 		<div style="width:475px; height: 160px; overflow-y: scroll; overflow-x: hidden;">
				 	 		<table id="bytctabs" style="width:455px;" border="1" cellpadding="0" bordercolor="#9AC0CD">

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
							<button id="dzpkg" onClick="getDZblock()"  class="tsdbutton"  style="margin-left: 20px;">打折</button>
						</td>	
						<td>
							<input type="text" id="pkg_rateStr" disabled="disabled"/>
						</td>			
				    </tr>
				</table>
				</div>
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
									<td class="wenzi" style="width:100px;">
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
					<table style="background-color:#f7f7f7">
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
					<button id="save" onClick="saveUpdate()" style="margin-left: 20px;">
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
							<fmt:message key="phone.getinternet0295" /><!--电话过户业务用户信息查询-->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:void(0);"
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
		<input type="hidden" id="startdate" value="<%=Log.getSysTime() %>"/><!-- 固定费用起始日期 -->
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
		<input type="hidden" id="bmtypekey"/><!-- 部门编号 -->		
		<input type="hidden" id="sbmcode"/><!-- 部门编号 -->
		<input type="hidden" id="sbmname"/><!-- 部门名称 -->
		<input type="hidden" id='selbz'/><!-- 电话站标识 -->
		<input type="hidden" id="mokuaiju"/><!-- 电话模块局 -->
		<input type="hidden" id="CustTyperight"/><!-- 客户类型 -->
		<input type="hidden" id="selecththvaluekey"/><!-- 单击得到选择合同号信息放到隐藏域等待获取 -->
		<!-- 获取空号模块局权限 -->
	    <input type="hidden" id="konghaoarearight" name="konghaoarearight"/>
	    <input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
	    <input type="hidden" id="fufeitypepath"/>
	    <input type="hidden" id="Area_hidden"/>
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
		<input type="hidden" id="stiffbusinestype" value="phoneGH"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<input type="hidden" id="Bz2right"/><!-- 一级部门是否代收 -->
		<input type="hidden" id="oldhthyhmc"/>
		<input type="hidden" id="czyfee"/><!-- 判断是否欠费 -->
		<input type="hidden" id="selecththarearight"/>
		<select id="yhxz_hidden" style="display:none;"></select>
		<input type="hidden" id="dhlx_yhdang"/>
		<input type="hidden" id="yw"/>
		<jsp:include page="phone_internet.jsp" flush="true"/>
		<input type="hidden" id="businesstype" value="p_changeuser"/><!-- 该页面的业务类型 -->		
</body>
</html>	
