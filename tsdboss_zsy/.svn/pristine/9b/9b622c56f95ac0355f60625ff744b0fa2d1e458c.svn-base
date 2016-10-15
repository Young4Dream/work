<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/broadband/business/ymbroadband.jsp
    Function:   宽带业务受理
    Author:     wenxuming
    Date:       2011-07
    Description: 
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
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>telReprint</title>
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
		<script src="script/telephone/business/phone_kjbq_gh.js" type="text/javascript"></script>	
		<!-- 业务受理专用的CSS代码 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
		<style type="text/css">
			input2{ BACKGROUND-COLOR:#ffffff; BORDER-BOTTOM:#000000 1px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT: #ffffff 1px solid; BORDER-TOP
: #ffffff 1px solid; COLOR: rgb(0,0,0); FONT-SIZE: 9pt
}
		</style>
		<script language="javascript" type="text/javascript">
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
				//用户属性
				var userAccountNumberright='';//用户帐号
				var usernumberright='';//用户编号
				var startdateright='';//开户日期
				var userpwdright='';//用户密码
				var confirmpwdright='';//确认密码
				var cltyperight='';//策略类型
				var ywarearight='';//所属区域
				var zfStandardright='';//自费标准
				var PayTyperight='';//付费类型
				var BindingIPright='';//绑定IP
				var BindingVlanright='';//绑定vlan
				var PCMACright='';//PC MAC
				var djLoginright='';//多机登录
				var CMBrandright='';//CM绑定
				var BindingCMright='';//绑定CM
				var CMMAKright='';//CM MAC
				var kyStatusright='';//可用MAC
				var StatusDateright='';//状态日期
				var StatusBZright='';//状态备注
				var useridright='';//操作员
				var lastczright='';//剩余储值
				var BillingDateright='';//计费日期
				var expireDateright='';//到期日期
				//用户资料
				var UserNameright='';//用户名称
				var UserAddressright='';//用户地址
				var HousingPhoneright='';//住宅电话
				var UnitNameright='';//单位名称
				var linkmanright='';//联系人
				var linkphoneright='';//联系电话
				var E_mailright='';//E-mail
				var AccountAddressright='';//账单地址
				var ZipCoderight='';//邮政编码
				var DocumentNameright='';//证件名称
				var DocumentNumberright='';//证件号码
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
						//用户属性
						userAccountNumberright='true';//用户帐号
						usernumberright='true';//用户编号
						startdateright='true';//开户日期
						userpwdright='true';//用户密码
						confirmpwdright='true';//确认密码
						cltyperight='true';//策略类型
						ywarearight='true';//所属区域
						zfStandardright='true';//自费标准
						PayTyperight='true';//付费类型
						BindingIPright='true';//绑定IP
						BindingVlanright='true';//绑定vlan
						PCMACright='true';//PC MAC
						djLoginright='true';//多机登录
						CMBrandright='true';//CM绑定
						BindingCMright='true';//绑定CM
						CMMAKright='true';//CM MAC
						kyStatusright='true';//可用MAC
						StatusDateright='true';//状态日期
						StatusBZright='true';//状态备注
						useridright='true';//操作员
						lastczright='true';//剩余储值
						BillingDateright='true';//计费日期
						expireDateright='true';//到期日期
						//用户资料
						UserNameright='true';//用户名称
						UserAddressright='true';//用户地址
						HousingPhoneright='true';//住宅电话
						UnitNameright='true';//单位名称
						linkmanright='true';//联系人
						linkphoneright='true';//联系电话
						E_mailright='true';//E-mail
						AccountAddressright='true';//账单地址
						ZipCoderight='true';//邮政编码
						DocumentNameright='true';//证件名称
						DocumentNumberright='true';//证件号码
						flag = true;
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						for(var i = 0;i<spowerarr.length-1;i++){							
							userAccountNumberright +=getCaption(spowerarr[i],'userAccountNumber','')+'|';
							usernumberright +=getCaption(spowerarr[i],'usernumber','')+'|';
							startdateright +=getCaption(spowerarr[i],'startdate','')+'|';
							userpwdright +=getCaption(spowerarr[i],'userpwd','')+'|';
							confirmpwdright +=getCaption(spowerarr[i],'confirmpwd','')+'|';
							cltyperight +=getCaption(spowerarr[i],'cltype','')+'|';
							ywarearight +=getCaption(spowerarr[i],'ywarea','')+'|';
							zfStandardright +=getCaption(spowerarr[i],'zfStandard','')+'|';
							PayTyperight +=getCaption(spowerarr[i],'PayType','')+'|';
							BindingIPright +=getCaption(spowerarr[i],'BindingIP','')+'|';
							BindingVlanright +=getCaption(spowerarr[i],'BindingVlan','')+'|';
							PCMACright +=getCaption(spowerarr[i],'PCMAC','')+'|';
							djLoginright +=getCaption(spowerarr[i],'djLogin','')+'|';
							CMBrandright +=getCaption(spowerarr[i],'CMBrand','')+'|';
							BindingCMright +=getCaption(spowerarr[i],'BindingCM','')+'|';
							CMMAKright +=getCaption(spowerarr[i],'CMMAK','')+'|';
							kyStatusright +=getCaption(spowerarr[i],'kyStatus','')+'|';
							StatusDateright +=getCaption(spowerarr[i],'StatusDate','')+'|';
							StatusBZright +=getCaption(spowerarr[i],'StatusBZ','')+'|';
							useridright +=getCaption(spowerarr[i],'userid','')+'|';
							lastczright +=getCaption(spowerarr[i],'lastcz','')+'|';	
							BillingDateright +=getCaption(spowerarr[i],'BillingDate','')+'|';	
							expireDateright +=getCaption(spowerarr[i],'expireDate','')+'|';		
							
							UserNameright +=getCaption(spowerarr[i],'UserName','')+'|';
							UserAddressright +=getCaption(spowerarr[i],'UserAddress','')+'|';
							HousingPhoneright +=getCaption(spowerarr[i],'HousingPhone','')+'|';
							UnitNameright +=getCaption(spowerarr[i],'UnitName','')+'|';
							linkmanright +=getCaption(spowerarr[i],'linkman','')+'|';
							linkphoneright +=getCaption(spowerarr[i],'linkphone','')+'|';
							E_mailright +=getCaption(spowerarr[i],'E_mail','')+'|';
							AccountAddressright +=getCaption(spowerarr[i],'AccountAddress','')+'|';
							ZipCoderight +=getCaption(spowerarr[i],'ZipCode','')+'|';
							DocumentNameright +=getCaption(spowerarr[i],'DocumentName','')+'|';
							DocumentNumberright +=getCaption(spowerarr[i],'DocumentNumber','')+'|';
						}
				}
				var hasuserAccountNumber = userAccountNumberright.split('|');
				var hasusernumber = usernumberright.split('|');
				var hasstartdate = startdateright.split('|');
				var hasuserpwd = userpwdright.split('|');
				var hasconfirmpwd = confirmpwdright.split('|');
				var hascltype = cltyperight.split('|');
				var hasywarea = ywarearight.split('|');
				var haszfStandard = zfStandardright.split('|');
				var hasPayType = PayTyperight.split('|');
				var hasBindingIP = BindingIPright.split('|');
				var hasBindingVlan = BindingVlanright.split('|');
				var hasPCMAC = PCMACright.split('|');
				var hasdjLogin = djLoginright.split('|');
				var hasCMBrand = CMBrandright.split('|');
				var hasBindingCM = BindingCMright.split('|');
				var hasCMMAK = CMMAKright.split('|');
				var haskyStatus = kyStatusright.split('|');
				var hasStatusDate = StatusDateright.split('|');
				var hasStatusBZ = StatusBZright.split('|');
				var hasuserid = useridright.split('|');
				var haslastcz = lastczright.split('|');
				var hasBillingDate = BillingDateright.split('|');
				var hasexpireDate = expireDateright.split('|');
				
				var hasUserName = UserNameright.split('|');
				var hasUserAddress = UserAddressright.split('|');
				var hasHousingPhone = HousingPhoneright.split('|');
				var hasUnitName = UnitNameright.split('|');
				var haslinkman = linkmanright.split('|');
				var haslinkphone = linkphoneright.split('|');
				var hasE_mail = E_mailright.split('|');
				var hasAccountAddress = AccountAddressright.split('|');
				var hasZipCode = ZipCoderight.split('|');
				var hasDocumentName = DocumentNameright.split('|');
				var hasDocumentNumber = DocumentNumberright.split('|');
				var str = 'true';
				if(flag==true){
					$("#userAccountNumberright").val(userAccountNumberright);
					$("#usernumberright").val(usernumberright);
					$("#startdateright").val(startdateright);
					$("#userpwdright").val(userpwdright);
					$("#confirmpwdright").val(confirmpwdright);
					$("#cltyperight").val(cltyperight);
					$("#ywarearight").val(ywarearight);
					$("#zfStandardright").val(zfStandardright);
					$("#PayTyperight").val(PayTyperight);
					$("#BindingIPright").val(BindingIPright);
					$("#BindingVlanright").val(BindingVlanright);
					$("#PCMACright").val(PCMACright);
					$("#djLoginright").val(djLoginright);
					$("#CMBrandright").val(CMBrandright);
					$("#BindingCMright").val(BindingCMright);
					$("#CMMAKright").val(CMMAKright);
					$("#kyStatusright").val(kyStatusright);
					$("#StatusDateright").val(StatusDateright);
					$("#StatusBZright").val(StatusBZright);
					$("#useridright").val(useridright);
					$("#lastczright").val(lastczright);
					$("#BillingDateright").val(BillingDateright);
					$("#expireDateright").val(expireDateright);
					
					$("#UserNameright").val(UserNameright);
					$("#UserAddressright").val(UserAddressright);
					$("#HousingPhoneright").val(HousingPhoneright);
					$("#UnitNameright").val(UnitNameright);
					$("#linkmanright").val(linkmanright);
					$("#linkphoneright").val(linkphoneright);
					$("#E_mailright").val(E_mailright);
					$("#AccountAddressright").val(AccountAddressright);
					$("#ZipCoderight").val(ZipCoderight);
					$("#DocumentNameright").val(DocumentNameright);
					$("#DocumentNumberright").val(DocumentNumberright);

				}else{				
					for(var i = 0;i<hasuserAccountNumber.length;i++){
							$("#userAccountNumberright").val(hasuserAccountNumber[i]);
							break;
						}
					for(var i = 0;i<hasusernumber.length;i++){
							$("#usernumberright").val(hasusernumber[i]);
							break;
						}
					for(var i = 0;i<hasstartdate.length;i++){
							$("#startdateright").val(hasstartdate[i]);
							break;
						}
					for(var i = 0;i<hasuserpwd.length;i++){
							$("#userpwdright").val(hasuserpwd[i]);
							break;
						}
					for(var i = 0;i<hasconfirmpwd.length;i++){
							$("#confirmpwdright").val(hasconfirmpwd[i]);
							break;
						}
					for(var i = 0;i<hascltype.length;i++){
							$("#cltyperight").val(hascltype[i]);
							break;
						}
					for(var i = 0;i<hasywarea.length;i++){
							$("#ywarearight").val(hasywarea[i]);
							break;
						}						
					for(var i = 0;i<haszfStandard.length;i++){
							$("#zfStandardright").val(haszfStandard[i]);
							break;
						}
					for(var i = 0;i<hasPayType.length;i++){
							$("#PayTyperight").val(hasPayType[i]);
							break;
						}
					for(var i = 0;i<hasBindingIP.length;i++){
							$("#BindingIPright").val(hasBindingIP[i]);
							break;
						}																	
					for(var i = 0;i<hasBindingVlan.length;i++){
							$("#BindingVlanright").val(hasBindingVlan[i]);
							break;
						}
					for(var i = 0;i<hasPCMAC.length;i++){
							$("#PCMACright").val(hasPCMAC[i]);
							break;
						}
					for(var i = 0;i<hasdjLogin.length;i++){
							$("#djLoginright").val(hasdjLogin[i]);
							break;
						}					
					for(var i = 0;i<hasCMBrand.length;i++){
							$("#CMBrandright").val(hasCMBrand[i]);
							break;
						}
					for(var i = 0;i<hasBindingCM.length;i++){
							$("#BindingCMright").val(hasBindingCM[i]);
							break;
						}
					for(var i = 0;i<hasCMMAK.length;i++){
							$("#CMMAKright").val(hasCMMAK[i]);
							break;
						}
					for(var i = 0;i<haskyStatus.length;i++){
							$("#kyStatusright").val(haskyStatus[i]);
							break;
						}
					for(var i = 0;i<hasStatusDate.length;i++){
							$("#StatusDateright").val(hasStatusDate[i]);
							break;
						}					
					for(var i = 0;i<hasStatusBZ.length;i++){
							$("#StatusBZright").val(hasStatusBZ[i]);
							break;
						}
					for(var i = 0;i<hasuserid.length;i++){
							$("#useridright").val(hasuserid[i]);
							break;
						}
					for(var i = 0;i<haslastcz.length;i++){
							$("#lastczright").val(haslastcz[i]);
							break;
						}
					for(var i = 0;i<hasBillingDate.length;i++){
							$("#BillingDateright").val(hasBillingDate[i]);
							break;
						}
					for(var i = 0;i<hasexpireDate.length;i++){
							$("#expireDateright").val(hasexpireDate[i]);
							break;
						}							
					for(var i = 0;i<hasUserName.length;i++){
							$("#UserNameright").val(hasUserName[i]);
							break;
						}
					for(var i = 0;i<hasUserAddress.length;i++){
							$("#UserAddressright").val(hasUserAddress[i]);
							break;
						}										
					for(var i = 0;i<hasHousingPhone.length;i++){
							$("#HousingPhoneright").val(hasHousingPhone[i]);
							break;
						}
					for(var i = 0;i<hasUnitName.length;i++){
							$("#UnitNameright").val(hasUnitName[i]);
							break;
						}
					for(var i = 0;i<haslinkman.length;i++){
							$("#linkmanright").val(haslinkman[i]);
							break;
						}					
					for(var i = 0;i<haslinkphone.length;i++){
							$("#linkphoneright").val(haslinkphone[i]);
							break;
						}
					for(var i = 0;i<hasE_mail.length;i++){
							$("#E_mailright").val(hasE_mail[i]);
							break;
						}
					for(var i = 0;i<hasAccountAddress.length;i++){
							$("#AccountAddressright").val(hasAccountAddress[i]);
							break;
						}
					for(var i = 0;i<hasZipCode.length;i++){
							$("#ZipCoderight").val(hasZipCode[i]);
							break;
						}
					for(var i = 0;i<hasDocumentName.length;i++){
							$("#DocumentNameright").val(hasDocumentName[i]);
							break;
						}							
					for(var i = 0;i<hasDocumentNumber.length;i++){
							$("#DocumentNumberright").val(hasDocumentNumber[i]);
							break;
						}	
				}												   
			}
			
			function getbusinessqx(){
				//用户帐号
				if($("#userAccountNumberright").val()=="false"){
					$("#userAccountNumber").attr("disabled","disabled");
					$("#userAccountNumber").css("background","#DCDCDC");
				}else{										
					$("#userAccountNumber").removeAttr("disabled");
				}				
				//用户编码
				if($("#usernumberright").val()=="false"){					
					$("#usernumber").attr("disabled","disabled");
					$("#usernumber").css("background","#DCDCDC");
				}else{					
					$("#usernumber").removeAttr("disabled");
				}
				//开户日期
				if($("#startdateright").val()=="false"){					
					$("#startdate").attr("disabled","disabled");
					$("#startdate").css("background","#DCDCDC");
				}else{					
					$("#startdate").removeAttr("disabled");
				}
				//用户密码
				if($("#userpwdright").val()=="false"){					
					$("#userpwd").attr("disabled","disabled");
					$("#userpwd").css("background","#DCDCDC");
				}else{					
					$("#userpwd").removeAttr("disabled");
				}
				//确认密码
				if($("#confirmpwdright").val()=="false"){					
					$("#confirmpwd").attr("disabled","disabled");
					$("#confirmpwd").css("background","#DCDCDC");
				}else{					
					$("#confirmpwd").removeAttr("disabled");
				}
				//策略类型
				if($("#cltyperight").val()=="false"){					
					$("#cltype").attr("disabled","disabled");
					$("#cltype").css("background","#DCDCDC");
				}else{					
					$("#cltype").removeAttr("disabled");
				}
				//业务区域
				if($("#ywarearight").val()=="false"){					
					$("#ywarea").attr("disabled","disabled");
					$("#ywarea").css("background","#DCDCDC");
				}else{					
					$("#ywarea").removeAttr("disabled");
				}
				//资费标准
				if($("#zfStandardright").val()=="false"){					
					$("#zfStandard").attr("disabled","disabled");
					$("#zfStandard").css("background","#DCDCDC");
				}else{									
					$("#zfStandard").removeAttr("disabled");	
				}
				//付费方式
				if($("#PayTyperight").val()=="false"){					
					$("#PayType").attr("disabled","disabled");
					$("#PayType").css("background","#DCDCDC");
				}else{					
					$("#PayType").removeAttr("disabled");
				}
				//绑定IP
				if($("#BindingIPright").val()=="false"){					
					$("#BindingIP").attr("disabled","disabled");
					$("#BindingIP").css("background","#DCDCDC");
				}else{					
					$("#BindingIP").removeAttr("disabled");
				}
				//绑定vlan
				if($("#BindingVlanright").val()=="false"){					
					$("#BindingVlan").attr("disabled","disabled");
					$("#BindingVlan").css("background","#DCDCDC");
				}else{					
					$("#BindingVlan").removeAttr("disabled");
				}
				//PC MAC
				if($("#PCMACright").val()=="false"){					
					$("#PCMAC").attr("disabled","disabled");
					$("#PCMAC").css("background","#DCDCDC");
				}else{					
					$("#PCMAC").removeAttr("disabled");
				}
				//多机登录
				if($("#djLoginright").val()=="false"){					
					$("#djLogin").attr("disabled","disabled");
					$("#djLogin").css("background","#DCDCDC");
				}else{					
					$("#djLogin").removeAttr("disabled");
				}
				//CM绑定
				if($("#CMBrandright").val()=="false"){					
					$("#CMBrand").attr("disabled","disabled");
					$("#CMBrand").css("background","#DCDCDC");
				}else{					
					$("#CMBrand").removeAttr("disabled");
				}
				//绑定MC
				if($("#BindingCMright").val()=="false"){					
					$("#BindingCM").attr("disabled","disabled");
					$("#BindingCM").css("background","#DCDCDC");
				}else{					
					$("#BindingCM").removeAttr("disabled");
				}
				//CM MAK
				if($("#CMMAKright").val()=="false"){					
					$("#CMMAK").attr("disabled","disabled");
					$("#CMMAK").css("background","#DCDCDC");
				}else{					
					$("#CMMAK").removeAttr("disabled");
				}
				//可用状态
				if($("#kyStatusright").val()=="false"){					
					$("#kyStatus").attr("disabled","disabled");
					$("#kyStatus").css("background","#DCDCDC");
				}else{					
					$("#kyStatus").removeAttr("disabled");
				}
				//状态时间
				if($("#StatusDateright").val()=="false"){					
					$("#StatusDate").attr("disabled","disabled");
					$("#StatusDate").css("background","#DCDCDC");
				}else{					
					$("#StatusDate").removeAttr("disabled");
				}
				//状态备注
				if($("#StatusBZright").val()=="false"){					
					$("#StatusBZ").attr("disabled","disabled");
					$("#StatusBZ").css("background","#DCDCDC");
				}else{					
					$("#StatusBZ").removeAttr("disabled");
				}
				//操作员
				if($("#useridright").val()=="false"){					
					$("#userid").attr("disabled","disabled");
					$("#userid").css("background","#DCDCDC");
				}else{					
					$("#userid").removeAttr("disabled");
				}
				//剩余储值
				if($("#lastczright").val()=="false"){					
					$("#lastcz").attr("disabled","disabled");
					$("#lastcz").css("background","#DCDCDC");
				}else{					
					$("#lastcz").removeAttr("disabled");
				}
				//计费日期
				if($("#BillingDateright").val()=="false"){					
					$("#BillingDate").attr("disabled","disabled");
					$("#BillingDate").css("background","#DCDCDC");
				}else{					
					$("#BillingDate").removeAttr("disabled");
				}
				//到期时间
				if($("#expireDateright").val()=="false"){					
					$("#expireDate").attr("disabled","disabled");
					$("#expireDate").css("background","#DCDCDC");
				}else{					
					$("#expireDate").removeAttr("disabled");
				}
				//用户名称
				if($("#UserNameright").val()=="false"){					
					$("#UserName").attr("disabled","disabled");
					$("#UserName").css("background","#DCDCDC");
				}else{					
					$("#UserName").removeAttr("disabled");
				}
				//用户地址
				if($("#UserAddressright").val()=="false"){					
					$("#UserAddress").attr("disabled","disabled");
					$("#UserAddress").css("background","#DCDCDC");
				}else{					
					$("#UserAddress").removeAttr("disabled");
				}
				//住宅电话
				if($("#HousingPhoneright").val()=="false"){					
					$("#HousingPhone").attr("disabled","disabled");
					$("#HousingPhone").css("background","#DCDCDC");
				}else{					
					$("#HousingPhone").removeAttr("disabled");
				}
				//账单名称
				if($("#UnitNameright").val()=="false"){					
					$("#UnitName").attr("disabled","disabled");
					$("#UnitName").css("background","#DCDCDC");
				}else{					
					$("#UnitName").removeAttr("disabled");
				}
				//联系人
				if($("#linkmanright").val()=="false"){					
					$("#linkman").attr("disabled","disabled");
					$("#linkman").css("background","#DCDCDC");
				}else{					
					$("#linkman").removeAttr("disabled");
				}
				//联系电话
				if($("#linkphoneright").val()=="false"){					
					$("#linkphone").attr("disabled","disabled");
					$("#linkphone").css("background","#DCDCDC");
				}else{					
					$("#linkphone").removeAttr("disabled");
				}
				//E-mail
				if($("#E_mailright").val()=="false"){				
					$("#E-mail").attr("disabled","disabled");
					$("#E-mail").css("background","#DCDCDC");
				}else{					
					$("#E-mail").removeAttr("disabled");
				}
				//账单地址
				if($("#AccountAddressright").val()=="false"){					
					$("#AccountAddress").attr("disabled","disabled");
					$("#AccountAddress").css("background","#DCDCDC");
				}else{					
					$("#AccountAddress").removeAttr("disabled");
				}
				//邮件地址
				if($("#ZipCoderight").val()=="false"){					
					$("#ZipCode").attr("disabled","disabled");
					$("#ZipCode").css("background","#DCDCDC");
				}else{					
					$("#ZipCode").removeAttr("disabled");
				}
				//证件名称
				if($("#DocumentNameright").val()=="false"){					
					$("#DocumentName").attr("disabled","disabled");
					$("#DocumentName").css("background","#DCDCDC");					
				}else{					
					$("#DocumentName").removeAttr("disabled");
				}
				//证件号码
				if($("#DocumentNumberright").val()=="false"){					
					$("#DocumentNumber").attr("disabled","disabled");
					$("#DocumentNumber").css("background","#DCDCDC");
				}else{					
					$("#DocumentNumber").removeAttr("disabled");
				}		
			}
			jQuery(document).ready(function(){	    
			    $("#navBar").append(genNavv());		
			    getbusinesstype();
			    getUserPower();
			    getbusinessqx();
			    $("#startdate").val($("#thislogtime").val());
				$("#usernumber").val('zh0000000');
	   		}); 
	   		
	   		function getbusinesstype(){
	   			var imenuid = $("#imenuid").val();
	   			if(imenuid=='4076'){
	   				$("#querytitle").hide();
	   			}
	   		}
		</script>
  </head>
  
  <body>
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
		<div id="querytitle">
		<div id="input-Unit">
			<div class="title">
				&nbsp;&nbsp;
				<img src="style/icon/65.gif" />
				查询帐号
			</div>
		<div id="inputtext">
			<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								查询方式
								<select id="ghSearchWay" style="width: 100px;" >
									<option value="0">
										电话
									</option>
									<option value="1">
										用户名
									</option>
									<option value="2">
										用户地址
									</option>
								</select>
							</td>
							<td>
								<input type="text" class="" id="ghSearchBox" name="ghSearchBox"/>
							</td>
							<td>
								<button class="tsdbutton" id="submitButton" onClick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									查找
								</button>
							</td>
							<td width="290"></td>
						</tr>
			</table>
		</div>		
	</div>
	</div>
	<div id="input-Unit">
			<div class="title">
				&nbsp;&nbsp;
				<img src="style/icon/65.gif" />
				用户属性
			</div>
		<div id="inputtext">
			<div class="midd">
			<table id="tablehthdang" style="width:780px;">
				<tr>
					<td class="wenzi">用户帐号</td>
					<td><input type="text" id="userAccountNumber" name="userAccountNumber" style="width:150px;"/></td>
					<td class="wenzi">用户编号</td>
					<td><input type="text" id="usernumber" name="usernumber" style="width:150px;"/></td>
					<td class="wenzi">开户日期</td>
					<td><input type="text" id="startdate" name="startdate" style="width:150px;"/></td>
				</tr>				
				<tr>
					<td class="wenzi">用户密码</td>
					<td><input type="text" id="userpwd" name="userpwd" style="width:150px;"/></td>
					<td class="wenzi">确认密码</td>
					<td><input type="text" id="confirmpwd" name="confirmpwd" style="width:150px;"/></td>
					<td class="wenzi">策略类型</td>
					<td><input type="text" id="cltype" name="cltype" style="width:150px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">咨费标准</td>
					<td><input type="text" id="zfStandard" name="zfStandard" style="width:150px;"/></td>
					<td class="wenzi">所属区域</td>
					<td><input type="text" id="ywarea" name="ywarea" style="width:150px;"/></td>
					<td class="wenzi">付费方式</td>
					<td><input type="text" id="PayType" name="PayType" style="width:150px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">绑定IP</td>
					<td><input type="text" id="BindingIP" name="BindingIP" style="width:150px;"/></td>
					<td class="wenzi">绑定Vlan</td>
					<td><input type="text" id="BindingVlan" name="BindingVlan" style="width:150px;"/></td>
					<td class="wenzi">PC MAC</td>
					<td><input type="text" id="PCMAC" name="PCMAC" style="width:150px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">多机登录</td>
					<td><input type="text" id="djLogin" name="djLogin" style="width:150px;"/></td>
					<td class="wenzi">CM品牌</td>
					<td><input type="text" id="CMBrand" name="CMBrand" style="width:150px;"/></td>
					<td class="wenzi">绑定CM</td>
					<td><input type="text" id="BindingCM" name="BindingCM" style="width:150px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">CM MAC</td>
					<td><input type="text" id="CMMAK" name="CMMAK" style="width:150px;"/></td>
					<td class="wenzi">可用状态</td>
					<td><input type="text" id="kyStatus" name="kyStatus" style="width:150px;"/></td>
					<td class="wenzi">状态时间</td>
					<td><input type="text" id="StatusDate" name="StatusDate" style="width:150px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">状态备注</td>
					<td><input type="text" id="StatusBZ" name="StatusBZ" style="width:150px;"/></td>
					<td class="wenzi">操作员</td>
					<td><input type="text" id="userid" name="userid" style="width:150px;"/></td>
					<td class="wenzi">剩余储值</td>
					<td><input type="text" id="lastcz" name="lastcz" style="width:150px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">计费时期</td>
					<td><input type="text" id="BillingDate" name="BillingDate" style="width:150px;"/></td>
					<td class="wenzi">到期时期</td>
					<td><input type="text" id="expireDate" name="expireDate" style="width:150px;"/></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			</div>
		</div>
	</div>
	<div id="input-Unit">
			<div class="title">
				&nbsp;&nbsp;
				<img src="style/icon/65.gif" />
				用户资料
			</div>
		<div id="inputtext">
			<div class="midd">
			<table id="tablehthdang" style="width:780px;">
				<tr>
					<td class="wenzi">用户名称</td>
					<td><input type="text" id="UserName" name="UserName" style="width:150px;"/></td>
					<td class="wenzi">用户地址</td>
					<td colspan="5"><input type="text" id="UserAddress" name="UserAddress" style="width:260px;"/></td>
				</tr>				
				<tr>
					<td class="wenzi">住宅电话</td>
					<td><input type="text" id="HousingPhone" name="HousingPhone" style="width:150px;"/></td>
					<td class="wenzi">单位名称</td>
					<td colspan="5"><input type="text" id="UnitName" name="UnitName" style="width:260px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">联系人</td>
					<td><input type="text" id="linkman" name="linkman" style="width:150px;"/></td>
					<td class="wenzi">联系电话</td>
					<td><input type="text" id="linkphone" name="linkphone" style="width:150px;"/></td>
					<td class="wenzi">E-mail</td>
					<td><input type="text" id="E-mail" name="E-mail" style="width:150px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">账单地址</td>
					<td><input type="text" id="AccountAddress" name="AccountAddress" style="width:150px;"/></td>
					<td class="wenzi">邮政编码</td>
					<td><input type="text" id="ZipCode" name="ZipCode" style="width:150px;"/></td>
					<td class="wenzi">证件名称</td>
					<td><input type="text" id="DocumentName" name="DocumentName" style="width:150px;"/></td>
				</tr>
				<tr>
					<td class="wenzi">证件号码</td>
					<td><input type="text" id="DocumentNumber" name="DocumentNumber" style="width:150px;"/></td>
					<td></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			</div>
		</div>
		<div id="buttons">
				<center>
					<button id="save" onClick="updateGH()" style="margin-left: 20px;">
						提交
					</button>
					<button id="reset" onClick="pageReset()" style="margin-left: 20px;">
						<!-- 重置 -->
						<fmt:message key="AddUser.Reset" />
					</button>
				</center>
			</div>
	</div>		
 </div>			
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
		<!-- 权限隐藏域 -->
		<input type="hidden" id="userAccountNumberright"/>
		<input type="hidden" id="usernumberright"/>
		<input type="hidden" id="startdateright"/>
		<input type="hidden" id="userpwdright"/>
		<input type="hidden" id="confirmpwdright"/>
		<input type="hidden" id="cltyperight"/>
		<input type="hidden" id="ywarearight"/>
		<input type="hidden" id="zfStandardright"/>
		<input type="hidden" id="PayTyperight"/>
		<input type="hidden" id="BindingIPright"/>
		<input type="hidden" id="BindingVlanright"/>
		<input type="hidden" id="PCMACright"/>
		<input type="hidden" id="djLoginright"/>
		<input type="hidden" id="CMBrandright"/>
		<input type="hidden" id="BindingCMright"/>
		<input type="hidden" id="CMMAKright"/>
		<input type="hidden" id="kyStatusright"/>
		<input type="hidden" id="StatusDateright"/>
		<input type="hidden" id="StatusBZright"/>
		<input type="hidden" id="useridright"/>
		<input type="hidden" id="lastczright"/>
		<input type="hidden" id="BillingDateright"/>
		<input type="hidden" id="expireDateright"/>
		<input type="hidden" id="UserNameright"/>
		<input type="hidden" id="UserAddressright"/>
		<input type="hidden" id="HousingPhoneright"/>
		<input type="hidden" id="UnitNameright"/>
		<input type="hidden" id="linkmanright"/>
		<input type="hidden" id="linkphoneright"/>
		<input type="hidden" id="E_mailright"/>
		<input type="hidden" id="AccountAddressright"/>
		<input type="hidden" id="ZipCoderight"/>
		<input type="hidden" id="DocumentNameright"/>
		<input type="hidden" id="DocumentNumberright"/>
		<input type="hidden" id="CMBrandright"/>
		<input type="hidden" id="BindingCMright"/>
  </body>
</html>
