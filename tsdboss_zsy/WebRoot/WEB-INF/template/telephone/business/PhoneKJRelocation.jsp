<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhoneKJRelocation.jsp
    Function:   电话跨级搬迁
    Author:     wenxuming
    Date:       2011-01-10
    Description: 
    Modify: 
     
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
		<title>电话跨级搬迁</title>
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
		<!-- 此页面砖用 -->		
		<script src="script/telephone/business/phone_kjbq_gh.js" type="text/javascript"></script>
		<script src="script/telephone/business/phoneInstalled.js" type="text/javascript"></script>		
		<script src="script/telephone/business/pkgPriceDiscount.js" type="text/javascript" language="javascript"></script>	
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript">
			/*********
				* 权限设置			
				* @param;
				* @return;
		    	**********/
				function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'prodistorys.xuanxian',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#userid').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				
				/****************
				*   拼接权限参数 *
				**************/
				var useridright='';
				var konghaoarearight='';
				var selecththright='';
				var flag = false;
				
				var spower = '';				
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
				if(spower=='all@'){
						useridright='true';
						konghaoarearight='true';
						selecththright='true';
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){							
							useridright += getCaption(spowerarr[i],'RightsGroup','')+'|';	
							konghaoarearight += getCaption(spowerarr[i],'getnullarea','')+'|';	
							selecththright +=getCaption(spowerarr[i],'selecthth','')+'|';					
						}
				}
				var hasuserid = useridright.split('|');
				var haskonghaoarea = konghaoarearight.split('|');
				var hasselecthth = selecththright.split('|');
				var str = 'true';				
				if(flag==true){					
					$("#useridright").val(useridright);
					$("#konghaoarearight").val(konghaoarearight);
					$("#selecththright").val(selecththright);
				}else{					
					for(var i = 0;i<hasuserid.length;i++){
							$("#useridright").val(hasuserid[i]);
							break;
						}
					for(var i = 0;i<haskonghaoarea.length;i++){
							$("#konghaoarearight").val(haskonghaoarea[i]);
							break;
						}	
				     }
				    for(var i = 0;i<hasselecthth.length;i++){
							$("#selecththright").val(hasselecthth[i]);
							break;
						}				    
			}	
	       jQuery(document).ready(function()
		   {	 
		    $("#navBar").append(genNavv());
		    getUserPower();		    
		    getinternation();	//businesspublic.js中  自动加载显示框 		    	    	
		    ghPayMoney('p_movewithoutarea'); //通过跨局搬迁标识查询一次性费用
		    gethide("p_movewithoutarea");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
		    $("#ghSearchBox").select();
		    $("#ghSearchBox").focus();
		    $("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#tableyhdang select").attr("disabled","disabled");
			$("#tableyhdang :text").attr("disabled","disabled");
			getfufeitype();//付费类型
			gettable();//默认加载固定费表格现实phone_kibq_gh.js函数中
			if(getaddressEditer()=="NO"){
				$("#sAddressold").focus(function(){c_p_address_fun_to();});
				$("#sAddressold").keyup(function(){notecheck();});
			}
			//getphoneusertype_kjbq_gh();//用户类别phone_kjbq_gh.js文件中；
			$("#CallPayType").val("");		
			getinternetedit('p_movewithoutarea');//加载页面下拉框	
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
		   	* 新电话号需要从空号表获取，取空号
		   	* @param;
		   	* @return;
		  	********/
			function c_p_konghaoDialog()
			{
				if($("#Dh_yhdang").val()=="")
				{
					//alert("请选择要办理该项业务的电话号码");
					alert("<fmt:message key="phone.getinternet0176" />");
					$("#ghSearchBox").select();
					$("#ghSearchBox").focus();
					return false;
				}
				tsd.QualifiedVal=true;
				var param = "";
				param += "Dhlx=";
				param += tsd.encodeURIComponent($("#Dhlx").val());
				param += "&DhHead=";
				param += tsd.encodeURIComponent($("#chooseKH").val());
				param += "&imenuid=";
				param += tsd.encodeURIComponent($("#imenuid").val());
				if(tsd.Qualified()==false){return false;}
				window.showModalDialog("mainServlet.html?pagename=telephone/business/Two.jsp?"+param+"&getnullarea="+$('#konghaoarearight').val(),window,"dialogWidth:500px; dialogHeight:440px; center:yes; scroll:no");
			}
			
			/*******
		   	* 选取空号后回调函数
		   	* @param:phoneNum从空号表里获取的新电话号码,mokuaiju模块局,ywarea业务区域;
		   	* @return;
		  	********/
			function c_p_feedBack(phoneNum,mokuaiju,jhj_id,ywarea,selbz)
			{
				//$("#Area").val(selbz+"-"+mokuaiju);
				//顶部电话输入
				$("#chooseKH").val(phoneNum);
				$("#chooseKHcopy").val(phoneNum);
				$("#Mokuaijuval").val(mokuaiju);
			}	
			
			/*******
		   	* 根据查询另一个模块局下的电话信息
		   	* @param: Dh电话;
		   	* @return;
		  	 ********/
			function queryCJphone()
			{
				var Dh = $("#CJphone").val();
				Dh=Dh.replace(/(^\s*)|(\s*$)/g,"");
				if(Dh==""){
					//alert("请输入查询电话号码！");
					alert("<fmt:message key="phone.getinternet0296" />");
					$("#CJphone").select();$("#CJphone").focus();return;}
				var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_movewithoutarea")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
				if(result[0]!=undefined && result[0][0]!="")
				{
					alert(result[0][1]);
					return false;
				}
				/*
				var res = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(*) as cont&tablename=insteadoffee&key=dh='"+Dh+"'");
				if(res!="0"&&res!=undefined){
					alert("查询的电话【"+Dh+"】有代缴费用信息，跨局搬迁时请注意处理！");
				}
				*/		
				ghSerBasicInfo(Dh);
				getphonefeename();//固定费下拉选项script/telephone/business/phone_kjbq_gh.js
				getPackaggroupid();//套餐下拉选项script/telephone/business/phone_kjbq_gh.js
				addspeediFeeType(Dh);//固话杂费设置script/telephone/business/phone_kjbq_gh.js		
				Bytc_Refreshs(Dh);//包月套餐设置script/telephone/business/phone_kjbq_gh.js	
				getyhxzstr('p_movewithoutarea');						
			}
			
			function tablehthdangnull(){
				$("#tablehthdang select").val("");
				$("#tablehthdang :text").val("");
			}
			
			//设置页面
			function setpage(){
				$("#geththsbm :text").val("");
				$("#geththsbm select").val("");
				$("#change_No1 :text").val("");
				$("#change_No1 select").val("");
				$("#change_No2 :text").val("");
				$("#change_No2 select").val("");
				$("#change_No3 :text").val("");
				$("#change_No3 select").val("");
				$("#tablehthdang").empty();
				$("#newDhgn").empty();
				geththtable();//加载合同号信息显示框 
			    $("#tablehthdang select").attr("disabled","disabled");
				$("#tablehthdang :text").attr("disabled","disabled");
				$("#tableyhdang select").attr("disabled","disabled");
				$("#tableyhdang :text").attr("disabled","disabled");
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

        //设置代缴默认值跟权限值
        function setBz2(){
        	if($("#sBm2").val()!=""){
					$("#Bz2_hthdang").val('Y');	//默认大客户代收为是
					$("#Bz2_hthdang").removeAttr("disabled");
				}else{
					$("#Bz2_hthdang").val('N');	//默认大客户代收为否
					$("#Bz2_hthdang").attr("disabled","disabled");
				}
				var Bz2right = $("#Bz2right").val();
					if(Bz2right=='true'){
						$("#Bz2_hthdang").removeAttr("disabled");
					}
        } 	        
        
		/********
        *设置代缴合同号，加载合同号信息，可对对应的代缴合同号进行设置；
        *@param;
       	*@return;
        ********/
        function setDJHTH()
        {
        	var phone = $("#Dh_yhdang").val();
        		if(phone==""){
	        		//alert("请选择要办理该项业务的电话号码");
				    alert("<fmt:message key="phone.getinternet0176" />");
        			$("#ghSearchBox").select();
        			$("#ghSearchBox").focus();
	        		return false;
        		}
        	var hth = $("#hth").val();
        	if(hth==""){
        		//alert("请生成或选择一个合同号！");
        		alert("<fmt:message key="phone.getinternet0285" />");
        		return false;
        	}	
        	//用户类别
        	var cusertype = $("#usertype option:selected").text();
        	if(cusertype=="--<fmt:message key="phone.getinternet0280" />--" || cusertype==undefined)
        	{
        		//alert("请选择用户类别");
        		alert("<fmt:message key="phone.getselectyhlb" />");
        		$("#usertype").select();
        		$("#usertype").focus();
        		return false;
        	}
        	getPayment();//生成代缴费用信息
        	//私费
        	setXDJ('');
        }

        /********
        *设置单位合同号
        *@param;
       	*@return;
        ********/
        function setDJ()
        {
        	$("#setdaijiao").val("Y");
        	DisplayHthForm();
        }              
       
       	/********
        *确认代缴合同号信息提示框；
        *@param;
       	*@return;
        ********/
        function getdaijiaotishi(){
        	var languageType = $("#languageType").val();        		
				var resname = fetchFieldAlias('daijiao',languageType); 
            	var phone = $("#Dh_yhdang").val();            	
            	var strdj = "";
            	//strdj +="确认代缴：";
            	strdj +="<fmt:message key="phone.getinternet0043" />\n\n";            	
            	strdj +="<fmt:message key="phone.getinternet0044" />"+phone+"<fmt:message key="phone.getinternet0045" />\n\n";  
            	for(var i=0;i<arrraydaijiaohth.length;i++){
            		if($("#"+arrraydaijiaohth[i]+"").val()!=""){            			         		
            			strdj +=resname[arrraydaijiaohth[i]]+"["+$("#"+arrraydaijiaohth[i]+"").val()+"<fmt:message key="phone.getinternet0046" />\n";
            		}
            	}
            	alert(strdj);
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
	   	* 判断该电话是否在用户档案中
	   	* @param:xdh电话;
	   	* @return;
	  	 ********/
        function getyhdangdh(xdh){        	
        	var boolean=false;
        	var res = fetchSingleValue("dbsql_phone.queryyhdangdh",6,"&dh="+xdh);
        	if(res!=0){
        		boolean=true;
        	}
        	return boolean;
        }
        
        /*******
	   	* 修改保存是调用该方法
	   	* @param;
	   	* @return;
	  	 ********/
        function saveUpdate(){
        	tsd.QualifiedVal=true;
        	var params = "";
        	var sdh = $("#Dh_yhdang").val();
        	if(sdh.length==0){
        		//alert("请选择要办理该项业务的电话号码");
				alert("<fmt:message key="phone.getinternet0176" />");
        		$("#ghSearchBox").select();$("#ghSearchBox").focus();return false;}          	 
        	//搬迁新电话
        	var xsdh = $("#chooseKH").val();
        	xsdh=xsdh.replace(/(^\s*)|(\s*$)/g,"");
        	if(xsdh.length==0){
        		//alert("请选择一个正确的新电话！");
        		alert("<fmt:message key="phone.getinternet0297" />");
        		$("#chooseKH").select();
        		$("#chooseKH").focus();
        		return false;
        	}
        	if(getisnotnullphone(xsdh)=="false"){
        		//alert("该搬迁新电话为无效电话，请重新输入或选择！");
        		alert("<fmt:message key="phone.getinternet0298" />");
        		$("#chooseKH").select();$("#chooseKH").focus();return false;}
        	if(getyhdangdh(xsdh)==true){
				//alert("该号码已被使用，请重新选择！");
				alert("<fmt:message key="phone.getinternet0299" />");
				$("#chooseKH").select();
				$("#chooseKH").focus();
				return false;
			}
        	params += "&xsdh=";
			params += tsd.encodeURIComponent(xsdh);
			//搬迁前旧电话
			var oldsdh = $("#Dh_yhdang").val();
			oldsdh=oldsdh.replace(/(^\s*)|(\s*$)/g,"");
			params += "&oldsdh=";
			params += tsd.encodeURIComponent(oldsdh);			
			//搬迁久地址
			params += "&oldadress=";
			params += tsd.encodeURIComponent($("#Yhdz_yhdang").val());
			//搬迁新合同号
			var chth = $("#hth").val();
			chth=chth.replace(/(^\s*)|(\s*$)/g,"");
			if(chth=="")
			{
					//alert("合同号不能为空,请生成、输入或选择一个合同号");
				   alert("<fmt:message key="phone.getinternet0286" />");
					return;
			}
			var oadress = $("#sAddressold").val();
			oadress=oadress.replace(/(^\s*)|(\s*$)/g,"");
			if(oadress.length==0){
				//alert("搬迁新地址不能为空！");
				alert("<fmt:message key="phone.getinternet0300" />");
				$("#sAddressold").select();$("#sAddressold").focus();return false;}
			params += "&newadress=";
			params += tsd.encodeURIComponent(oadress);
			var BQusername = $("#BQusername").val();
			BQusername=BQusername.replace(/(^\s*)|(\s*$)/g,"");
			params += "&newyhmc=";
			params += tsd.encodeURIComponent(BQusername);
			//旧姓名
			params += "&oldyhmc=";
			params += tsd.encodeURIComponent($("#Yhmc_yhdang").val());
			
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
			        if($("#IDCard_hthdang").attr("disabled")!=true&&IDCard!=""&&!/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(IDCard))
		        	{
			        	alert("<fmt:message key="phone.getinternet0030" />");
			        	$("#IDCard_hthdang").select();
			        	$("#IDCard_hthdang").focus();
			        	return false;
		        	}		        	
		        	//合同号一级部门
		        	var chthbm1 = $("#sBm1").val();
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
					params += tsd.encodeURIComponent(chthbm4);
			//搬迁前旧合同号信息
			var oldHthvalue = $("#Hth_yhdang").val();
			oldHthvalue=oldHthvalue.replace(/(^\s*)|(\s*$)/g,"");
			
			if($("#Hth_hthdang").val().replace(/(^\s*)|(\s*$)/g,"")==oldHthvalue){
				//alert("新合同号与原合同号一样，请重新输入");
				alert("<fmt:message key="phone.getinternet0301" />");
				return;
			}
			
			params += "&OldHth_to=";
			params += tsd.encodeURIComponent(oldHthvalue);
			var TransferFee = $("#TransferFee").val();
			if(TransferFee==""){
				//alert("请选择是否转账金额！");
				alert("<fmt:message key="phone.getinternet0289" />");
				$("#TransferFee").select();
				$("#TransferFee").focus();
				return false;
			}			
			params += "&TransferFee=";
			params += tsd.encodeURIComponent(TransferFee);								
			//备注
        	var tBZZZ = $("#phonepkBz").val();
        	params += "&zwbz=";
			params += tsd.encodeURIComponent(tBZZZ);						
			//工号
			var uuserid = $("#userid").val();
			params += "&uuserid=";
			params += tsd.encodeURIComponent(uuserid);
			//新模块局
			var Mokuaijuval = $("#Mokuaijuval").val();
			params += "&newmokuaiju=";
			params += tsd.encodeURIComponent(Mokuaijuval);
			//部门
			var udepart = $("#depart").val();
			params += "&udepart=";
			params += tsd.encodeURIComponent(udepart);
			var userareaid = $("#userareaid").val();
			params += "&userarea=";
			params += tsd.encodeURIComponent(userareaid);
			//区域营业厅
			var uarea = $("#area").val();
			params += "&uarea=";
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
        	var jfflsjfy = $("#fflsjfy").val().replace(/(^\s*)|(\s*$)/g,"");
        	if(jfflsjfy==""){jfflsjfy=0;}
        	params += "&sjfee=";
			params += tsd.encodeURIComponent(jfflsjfy);*/        	
        	//缴费款项
        	var jPaymoney = $("#cPayItem").val();
        	jyjfee = parseFloat(jyjfee,10);
			//jfflsjfy = parseFloat(jfflsjfy,10);	
			if(jyjfee==0){jPaymoney="";}
			//if(jyjfee!=0&&jfflsjfy==0){alert("请输入实缴费用！");$("#jfflsjfy").select();$("#jfflsjfy").focus();return false;}
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
			//呼出新权限
			var newDhgn = $("#newDhgn").val();
			params +="&newdhgn=";
			params += tsd.encodeURIComponent(newDhgn);	
			//新催缴策略
			var CallSheduleNo_new = $("#CallSheduleNo_new").val();
			params += "&newCallSheduleNo=";
			params += tsd.encodeURIComponent(CallSheduleNo_new);
			//固话用户性质
			var UserTypeyhdang = $("#UserTypeyhdang").val();
			if(UserTypeyhdang==""){
				//alert("请选择固话用户性质！");
				alert("<fmt:message key="phone.getinternet0290" />");
				return;
			}
			params += "&UserType_yhdang=";
			params += tsd.encodeURIComponent(UserTypeyhdang);	
			params += "&hfmax_ye=";
			params += tsd.encodeURIComponent($("#phoneBalance").val());		
			//预存款
		    var prechecked= $("#precheck").attr("checked");
			if(prechecked){
			       	var Prefee = $("#Prefee").val();
			       	Prefee=Prefee.replace(/(^\s*)|(\s*$)/g,"");
			       	var confee = $("#confee").val();
			       	confee=confee.replace(/(^\s*)|(\s*$)/g,"");
			        if(Prefee.length==0){alert("<fmt:message key="phone.getinternet0035" />");$("#Prefee").select();$("#Prefee").focus();return;}	        	
			        if(confee.length==0){alert("<fmt:message key="phone.getinternet0036" />");$("#confee").select();$("#confee").focus();return;}
			        Prefee=parseFloat(Prefee,10);
			        confee=parseFloat(confee,10);
			        if(Prefee!=confee){alert("<fmt:message key="phone.getinternet0037" />");$("#confee").select();$("#confee").focus();return;}			        
			        var patrn=/^-?\d+\.{0,}\d{0,}$/; 
					 if (!patrn.exec(Prefee)){
					 	alert("<fmt:message key="phone.getinternet0038" />");
					 	$("#Prefee").select();
					 	$("#Prefee").focus();
					 	return false;
					 }
					params += "&ycfee=";
					params += tsd.encodeURIComponent(Prefee);
					params += "&sfyc=";
					params += tsd.encodeURIComponent('Y');  
		    }	
		    
		    if(isXinYeWuExists(oldsdh)=="0")
			{
				alert("<fmt:message key="phone.getinternet0034" />");
				$("#phonefeetype").select();
				$("#phonefeetype").focus();
			   	return false;
			}

			var loginfo = "<fmt:message key="phone.getinternet0417" />:";//电话跨局搬迁
			loginfo += "(<fmt:message key="phone.getinternet0196" />:";//原电话号码
			loginfo += sdh;
			loginfo += ")(<fmt:message key="phone.getinternet0197" />:";//新电话号码
			loginfo += xsdh;
			loginfo += ")(<fmt:message key="phone.getinternet0407" />:";//原合同号
			loginfo += $("#Hth_yhdang").val();
			loginfo += ")(<fmt:message key="phone.getinternet0408" />:";//新合同号			
			loginfo += $("#Hth_hthdang").val();
			loginfo += ")(<fmt:message key="phone.getinternet0411" />:";//新用户姓名
			loginfo += $("#BQusername").val();
			loginfo += ")(<fmt:message key="phone.getinternet0418" />:";//新用户地址
			loginfo += $("#sAddressold").val();
			loginfo += ")(<fmt:message key="phone.getinternet0419" />:";//原呼出权限
			loginfo += $("#Dhgn_yhdang").val();
			loginfo += ")(<fmt:message key="phone.getinternet0420" />:";//新呼出权限
			loginfo += $("#newDhgn").val();
			loginfo += ")(<fmt:message key="phone.getinternet0097" />:";//预存金额
			loginfo += Prefee+")";
			loginfo = tsd.encodeURIComponent(loginfo);
			params+="&ywbz="+loginfo;
        	if(tsd.Qualified()==false){return false;}
        	var result = fetchMultiPValue("PhoneKJRelocation_saveudpate",6,params);
			if(result[0]==undefined || result[0][0]==undefined || result[0][0]==-1)
			{
				//alert("业务失败");
				alert("<fmt:message key="phone.getinternet0193" />");
			}
			else
			{
				if(result[0][0]=='FAILED'){
					alert(result[0][1]);
					return;
				}
				if(result[0][1]!=""&&result[0][1]!="SUCCSESS"){
					alert(result[0][1]);
					loginfo += tsd.encodeURIComponent(result[0][1]);
				}
				//操作成功
				$("#jobidid").val(result[0][0]);
				$("#ppaytype").val(jfufeitype);
				$("#Prefeeval").val(Prefee);
				$("#fee").val($("#cYingJiao").val());
				$("#ghSearchBox").select();
			    $("#ghSearchBox").focus();
				//判断是否打印工单，从tsd_ini表中配置Y为打印
				printworkorder('p_movewithoutarea');//script/telephone/business/businessreprint.js中
				writeLogInfo("","update",loginfo);
				pageReset();
			}
        }
        
         /********
           	*查看是否存在新业务
           	*@param：（dh：电话）;
       	  	*@return返回值false存在新业务，true不存在新业务
          	********/
		    function isXinYeWuExists(dh)
		    {
		    	var result = fetchSingleValue("phonelnstalled.xinyewualreadyexists",6,"&Dh=" + dh+"&feename="+tsd.encodeURIComponent("<fmt:message key="phone.getinternet0393" />"));//月租
		    	if(result=="0")
		    	{
		    		return "0";
		    	}
		    	else if(result=="1")
		    	{
		    		return "1";
		    	}
		    	else
		    	{
		    		return "2";
		    	}
		    }

        /*******
	   	* 重置
	   	* @param;
	   	* @return;
	  	 ********/
        function pageReset(){
        	addspeediFeeType('');//固话杂费设置script/telephone/business/phone_kjbq_gh.js		
			Bytc_Refreshs('');//包月套餐设置script/telephone/business/phone_kjbq_gh.js	
        	$(":text").val("");
			$("#tablehthdang :text").val("");
        	$("#tablehthdang select").val("");
        	$("#tableyhdang :text").val("");
        	$("#tableyhdang select").val("");
        	$("#precheck").attr("disabled","disabled");
        	$("#precheck").removeAttr("checked");
        	$("#Prefee").attr("disabled","disabled");
			$("#confee").attr("disabled","disabled");
        	$("#staff_bm").val("").trigger("change");
        	$("#cPayType").val("cash").trigger("change");
			//业务备注框
			$("#phonepkBz").val("");
			//杂费项
			$("#dhZFX").empty();
			//套餐项
			$("#dhTCX").empty();
			$("#cPayType").val("cash");
			$("#danweiHTHbox").removeAttr("checked");		
			ghPayMoney('p_movewithoutarea'); //通过跨局搬迁标识查询一次性费用
			gettable();//默认加载固定费表格现实phone_kibq_gh.js函数中
			$("#dhBYTC").empty();
			$("#sBm1").val("");
			$("#sBm2").val("");
			$("#sBm3").val("");
			$("#sBm4").val("");
			$("#tablehthdang select").attr("disabled","disabled");
			$("#tablehthdang :text").attr("disabled","disabled");
			$("#TransferFee").val("");
			$("#phonefeetype").empty();
			$("#Packaggroupid").empty();
			$("#phonefeename").empty();
			$("#Packagetypes").empty();
			refreshbusinessfee();
			gethide("p_movewithoutarea");//根据业务类型来设置哪些模块默认状态下是否可显示businesspublic.js下函数
			$("#hthshowcheck").removeAttr("checked");
			$("#newDhgn").val("");
			$("#usertype").val("");
			unLockDh();
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
	   	* 查询判断用户类别是否在用户类别表中，否这自动添加到select中显示
	   	* @param:yhlb用户类别，yhxz用户性质;
	   	* @return;
	  	********/
		function getyhlbisnull(yhlb,yhxz){
			var yhlb_id = getusertypekey(yhlb);
			var res = fetchMultiArrayValue("query.yhlbisnull",6,"&yhlb="+tsd.encodeURIComponent(yhlb_id)+"&yhxz="+tsd.encodeURIComponent(yhxz));
			if(res[0]==undefined ||res[0][0]==undefined)
			{
				return false;
			}else if(res[0][0]=='0'){
				var querysel ="<option value='"+yhxz+"'>"+yhxz+"</option>";
				$("#Yhxz").append(querysel);
			}
		}
		
        
        //选择用户类别时触发事件
        function changeyhlb(){
        	if($("#usertype option:selected").text()!="<fmt:message key="phone.getinternet0384" />"){
					$("#sBm1").val("");
					$("#sBm2").val("");
					$("#sBm3").val("");
					$("#sBm4").val("");
				}
			$("#hth").val("");	
			$("#Hth_hthdang").val("");
			$("#geththsbm").removeAttr("disabled");	
			getyhxzstr('p_movewithoutarea');
        } 	
		</script>
		</head>
		<body>
		<body onunload="unLockDh()">
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
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0178" /><!-- 输入查询条件 -->
					</div>
					<div id="inputtext">
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								<fmt:message key="phone.getinternet0302" /><!-- 查询电话号码 -->
							</td>
							<td>
								<input type="text" class="" id="CJphone" name="CJphone" />
							</td>
							<td>
								<button class="tsdbutton" id="submitButton"
									onclick="queryCJphone()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
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
					<table cellspacing="1" id='change_NO1'>
						<tr>
							<td>&nbsp;&nbsp;<fmt:message key="phone.getinternet0073" /><!-- 电话类型 --></td>
						   	<td>&nbsp;&nbsp;&nbsp;<select id="Dhlx" style="width:110px;" disabled="disabled"></select></td>
						   	<td>&nbsp;
								<fmt:message key="phone.getinternet0074" /><!-- 用户类别 -->
							</td>
							<td>&nbsp;<select id="usertype" style="width:110px;" onChange="javascript:changeyhlb();$('#hth').val('');$('#Hth').val('');$('#geththsbm select').removeAttr('disabled');"></select></td>
							<td>
								&nbsp;<fmt:message key="phone.getinternet0303" /><!-- 搬迁新电话 -->
							</td>
							<td>
								<input type="text" id="chooseKH" name="chooseKH"
									style="width: 117"  class="you1" style="ime-mode: Disabled"
												onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57"
												maxlength="11"
												onpaste="return   !clipboardData.getData('text').match(/\D/)"
												ondragenter="return   false"/>
							</td>
							<td align="left">
								<button name="chooseKHBtn" id="chooseKHBtn"
									onclick="c_p_konghaoDialog()" class="tsdbutton" style="height: 28px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0199" /><!-- 选择空号-->
								</button>
							</td>
							<td></td><td></td><td></td><td></td>
						</tr>
					</table>
					<hr style="border: 1px dotted #CCCCCC;" />
					<table cellspacing="1" id="geththsbm">
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
					<table cellspacing="1" id='change_NO2'>
						<tr>							
							<td>
								&nbsp;&nbsp;<fmt:message key="phone.getinternet0277" /><!-- 新--><span id="spanhth"></span>
								<!-- 合同号 -->
							</td>
							<td>
								<input type="text" name="hth" id="hth" style="width: 180"
									disabled="disabled" />
								<input type="hidden" name="gfhth" id="gfhth" />
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;<button class="tsdbutton" id="setHth" onClick="GenerateHth();" 
									style="height: 28px;width:70px; margin-top: 2px; padding: 0px;">
									<fmt:message key="phone.getinternet0077" /><!-- 生成合同号 -->
								</button>
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;<button class="tsdbutton" id="setHth" onClick="InputHth();" style="height: 28px;width:70px; margin-top: 3px; padding: 0px;">
									<fmt:message key="phone.getinternet0078" /><!-- 输入合同号 -->
								</button>
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;<button class="tsdbutton" id="setselectHth" 
									onclick="selecthth()" 
									style="height: 28px;width:70px; margin-top: 2px; padding: 0px;">
									<fmt:message key="phone.getinternet0079" /><!-- 选择合同号 -->										
								</button>
							</td>
							<td>
								<button class="tsdbutton" id="setHth" 
									onclick="setDJHTH()" 
									style="height: 28px; width:90px;margin-top: 3px; padding: 0px;">
									<fmt:message key="phoneyewu.setdjhth" />
									<!-- 设置代缴合同号 -->
								</button>
							</td>							
						</tr>
					</table>	
					<hr style="border: 1px dotted #CCCCCC;" />
					<table cellspacing="1" id='change_NO3'>
						<tr>
							<td>&nbsp;&nbsp;<fmt:message key="phone.getinternet0291" /><!-- 新用户姓名 --></td>
							<td>
								<input type="text" id="BQusername" name="BQusername" style="width:168px;" maxlength="25"  onpropertychange='TextUtil.NotMax(this)'/>
							</td>
							<td>&nbsp;&nbsp;<fmt:message key="phone.getinternet0207" /><!--联系电话 --></td>
							<td>
								<input type="text" id="newlxdh" name="newlxdh" style="width:130px;" maxlength="11"  onpropertychange='TextUtil.NotMax(this)'/><font color='red'>*</font>
							</td>
							<td><fmt:message key="phone.getinternet0300" /><!--搬迁新地址 --></td>
							<td>
								<input type="text" id="sAddressold" name="sAddressold" style="width:230px;" maxlength="60"  onpropertychange='TextUtil.NotMax(this)'/><font color='red'>*</font>
							</td>
							<td style="width:30px;display:none;"></td>							
							<td style="display:none;"><font color='red'>账户金额是否转移</font></td>
							<td style="display:none;">&nbsp;&nbsp;
								<select id="TransferFee" style='width:80px;'>
									<option value='N'>待留</option>
									<option value='Y'>转移</option>
								</select>
							</td>
						</tr>
					</table>
					<hr style="border: 1px dotted #CCCCCC;" />
					<table cellspacing="5">
						<tr>
							<td>&nbsp;<fmt:message key="phone.getinternet0292" /><!-- 新催缴策略 --></td>
							<td>
								<select id="CallSheduleNo_new" style="width:150px;"></select>
							</td>
							<td><fmt:message key="phone.getinternet0293" /><!-- 新呼出权限--></td>
							<td>
								<select id="newDhgn" style="width:130px;"></select>
							</td>
							<td><fmt:message key="phone.getinternet0294" /><!-- 固话用户性质--></td>
							<td>
								<select id="UserTypeyhdang" style="width:130px;"></select><font style="color:red">*</font>
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
					<fmt:message key="phone.getinternet0305" /><!-- 合同号变更信息显示-->&nbsp;<input type="checkbox" id="hthshowcheck" onClick="getshow()" style="width:15px;" />
					</div><br>
					<div id="inputtext">
						<div class="midd">
							<table id="tablehthdang" style="width:780px;"></table>
						</div>
					</div>	
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						<fmt:message key="phone.getinternet0306" /><!-- 原号码固话信息显示-->&nbsp;<input type="checkbox" id="yhdangshowcheck" checked="checked" onClick="getshow()" style="width:15px;" />
					</div><br>
					<div id="inputtext">
						<div class="midd">
							<table id="tableyhdang" style="width:780px;"></table>
						</div>
					</div>							
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phone.getinternet0183" /><!--固话信息显示-->&nbsp;
				</div>
				<table>
					<tr>
						<td valign="top">
						  <table>
						  	<tr>
						  		<td class="wenzi" style="width:50px;line-height:30px;">
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
									<th width="140">
										<center>
											<h4>
												<span><fmt:message key="phone.getinternet0085" /><!-- 参数值 --></span>
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
						<input type="hidden" id="phonefeenamecode" name="phonefeenamecode"/><!-- 子费用 -->
						<input type="hidden" id="feelv" name="feelv" style="width:150px" disabled="disabled" /><!-- 费率 -->
						<input type="hidden" id="TJfeelv" name="TJfeelv" style="width: 150px;" disabled="disabled" /><!-- 停机费率 -->
						<input type="hidden" id="ZFStartday" name="ZFStartday" style="width: 150px;" disabled="disabled" value="<%=Log.getSysTime() %>"/><!-- 起始时间 -->
						<input type="hidden" id="ZFEndday" name="ZFEndday" style="width: 150px;" disabled="disabled" value="2999-12-31"  /><!-- 终止时间 -->						
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
				<div class="title">
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
				 	 		<table id="dzhthcontent"  style="width:453px;">
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
				 	 		<div style="width:460px; height: 160px; overflow-y: scroll; overflow-x: hidden;">
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
							<button id="dzpkg" onclick="getDZblock()"  class="tsdbutton"  style="margin-left: 20px;">打折</button>
						</td>	
						<td>
							<input type="text" id="pkg_rateStr" disabled="disabled"/>
						</td>			
				    </tr>
				</table>
				<div class="title">
					&nbsp;&nbsp;
					<img src="style/icon/65.gif" />
					<fmt:message key="phoneyewu.yewuggnmqr" />
					<!-- 业务更改内容确认 --><span id="businesschangecontent" style="color:red;"></span>
				</div>
				<div id="inputtext2">
					<table cellspacing="0" style="width:760px;" id="businesschange">
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
										onpaste="return !clipboardData.getData('text').match(/D/)" ondragenter="return   false" value='0'/>
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
				           <table cellspacing="8">
				              <tr>
				                <td>
								<table cellspacing="5">
									<tr>
										<td>&nbsp;&nbsp;<font color='red'><fmt:message key="phone.getinternet0096" /><!-- 是否预存款 --></font></td>
										<td colspan=2><input type="checkbox" id="precheck" name="precheck" onClick="getprecheck();"/></td>
									</tr>	
									<tr>	
										<td>&nbsp;&nbsp;<fmt:message key="phone.getinternet0097" /><!-- 预存金额 -->&nbsp;&nbsp;</td>
										<td><input type="text" name="Prefee" id="Prefee" style="width:130px" disabled="disabled" onKeyDown="return preKey(event)" onKeyPress="numValid(this)"
											onpaste="return !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false"/>￥</td>
										<td>&nbsp;&nbsp;&nbsp;&nbsp;<fmt:message key="phone.getinternet0098" /><!-- 确认金额 -->&nbsp;&nbsp;</td>
										<td><input type="text" name="confee" id="confee" style="width:130px" disabled="disabled" onKeyPress="numValid(this)"
											onpaste="return !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false"/>￥</td>
									</tr>
								</table>
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
											<td><textarea name="phonepkBz" id="phonepkBz" rows="4" cols="60" style="width:300px;" maxlength="60"  onpropertychange="TextUtil.NotMax(this)"></textarea></td>	
										</tr>
									</table>
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
							<fmt:message key="phone.dwHTHquery" /><!-- 单位合同号查询 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#operformClose').click();"><fmt:message key="global.close" /><!-- 关闭 --></a>
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
					<fmt:message key="global.close" /><!-- 关闭 -->
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
							<fmt:message key="phone.getinternet0307" /><!-- 电话移机业务用户信息查询 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:void(0);"
							onclick="javascript:$('#kdMultiSearchClose').click();"><fmt:message key="global.close" /><!-- 关闭 --></a>
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
					<fmt:message key="global.close" /><!-- 关闭 -->
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
		<input type="hidden" id="selecththvaluekey"/><!-- 单击得到选择合同号信息放到隐藏域等待获取 -->
		<!-- 获取空号模块局权限 -->
	    <input type="hidden" id="konghaoarearight" name="konghaoarearight"/>
	    <input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
	    <input type="hidden" id="fufeitypepath"/>
	    <input type="hidden" id='selbz'/><!-- 电话站标识 -->
		<input type="hidden" id="mokuaiju"/><!-- 电话模块局 -->
		<input type="hidden" id="Area_hidden"/>
		<input type="hidden" id="yjfeehidden"/><!-- 页面获取应缴费存入隐藏于中 -->
		<input type="hidden" id="bmtypekey"/><!-- 部门编号 -->		
		<input type="hidden" id="sbmcode"/><!-- 部门编号 -->
		<input type="hidden" id="sbmname"/><!-- 部门名称 -->
		<input type="hidden" id='selbz'/><!-- 电话站标识 -->
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
		<input type="hidden" id="stiffbusinestype" value="phoneKJBQ"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<input type="hidden" id="Mokuaijuval"/><!-- 新模块局 -->
		<input type="hidden" id="Bz2right"/><!-- 一级部门是否代收 -->
		<input type="hidden" id="chooseKHcopy"/>
		<input type="hidden" id="CustTyperight"/><!-- 客户类别 -->
		<input type="hidden" id="selecththarearight"/>
		<input type="hidden" id="selectinserttype" value="1"/>
		<input type="hidden" id="businesstype" value="p_movewithoutarea"/><!-- 该页面的业务类型 -->		
		<select id="yhxz_hidden" style="display:none"></select>
		<jsp:include page="phone_internet.jsp" flush="true"/>
</body>
</html>	