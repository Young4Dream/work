<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%-- 
    File Name:  busManagement/EditProperty.jsp
    Function:   修改属性
    Author:     wenxuming
    Date:       2009-10-12
    Description: 
    Modify: 
     2010-07-09: 添加可修改用户类型和用户接入类型 --edit by chenliang
--%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title><fmt:message key="gjh.xgsx" />
		</title>
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<!-- 导入的js文件 -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script src="style/js/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js"
			type="text/javascript"></script>
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js"
			type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<script type="text/javascript" src="css/tree/dtree.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<!-- 页面国际化 -->
		<script type="text/javascript"
			src="script/broadband/usercat/Internationalization.js"></script>		
		<script type="text/javascript"
			src="script/broadband/business/broadbandservice.js"></script>	
		<!-- 时间控件 -->
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 导入js文件结束 -->
		<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
		<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
		<!-- 调用接口js -->
		<script type="text/javascript" src="script/broadband/business/tsd_interface.js"></script>
<!-- 导入css文件结束 -->	
		<style type="text/css">
#input-Unit .title {
	width: 100%;
	height: 32px;
	background: url(style/images/public/kuangbg.jpg);
	border-bottom: 1px solid #C8D8E5;
	text-align: left;
	color: #3C3C3C;
}
</style>
		<link href="style/xin.css" rel="stylesheet" type="text/css" />
		<!-- 新的面板样式 -->
		<!-- 双导航栏异常处理 -->
		<style type="text/css">
#navBar1 {
	height: 26px;
	background: url(style/images/public/daohangbg.jpg);
	line-height: 28px;
}

#navBar1 .navBar {
	
}

#navBar1 .d2back {
	float: right
}

#page {
	text-align: left
}
}
</style>
		<style type="text/css">
a {
	text-decoration: none;
	color: #000000;
	font-size: 14px;
}

a:hover {
	text-decoration: none;
	color: #ff0000;
	font-size: 14px
}
</style>
		<style type="text/css">
.button {
	width: 50px;
	height: 25px;
	background: url(style/images/public/buttonbg.jpg) repeat-x;
	border: #CCCCCC 1px solid;
	cursor: pointer;
	float: left; *
	float: none;
	border-top: #CCCCCC 1px solid;
	border-bottom: #CCCCCC 1px solid;
}

body {
	text-align: left
}

.neirong .midd #grid table {
	line-height: 18px;
}

#memocontent table {
	line-height: 18px;
}
</style>
		<script type="text/javascript">
				/******************************************
			     **查看当前用户的扩展权限，对spower字段进行解析 *
			     *****************************************/
				function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'EditProperty.quanxie',//存储过程的映射名称
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
				var addright = '';
				var addBright='';
				var deleteright = '';
				var delBright='';
				var editright = '';
				var editBright = '';
				var exportright='';
				var printright='';
				var saveright='';
				var checkright='';
				var RemainFeeright='';//余额
				var PayTyperight='';//费用类型
				var iStatusright='';//用户状态
				var sRealNameright='';//姓名
				var sBmright='';//部门
				var sAddressright='';//地址
				var sRegDateright='';//开户日期
				var sDh1right='';//用户类型
				var sDh2right='';//端口
				var UserName1right='';//邮政编码
				var idtyperight='';//证件类型
				var idcardright='';//证件号码
				var sDhright='';//电话
				var iSimultaneousright='';//同时在线数
				var speedright='';//带宽
				var AcctStartTimeright='';//账户有效起始时间
				var AcctStopTimeright='';//账户有效截至时间
				var ipaddrright='';//绑定IP
				var vlanidright='';//绑定VLANID
				var iMacAutoBandright='';//是否绑定
				var linkmanright='';//联系人
				var linkphoneright='';//联系电话
				var UserNameright='';//用户帐号
				var Valueright='';//用户密码
				var iFeeTyperight='';//计费规则
				var mobileright='';//移动电话
				var zafeilistright='';//杂费类型
				var BroadbandBusinessright='';//选择宽带业务复选框权限
				var TelphoneBusinessright='';//选择电话业务复选框权限
				var sBm2right='';//部门2
				var sBm3right='';//部门3
				var sBm4right='';//部门4
				var MACdzright='';//MAC地址
				var BASright='';//BAS设备
				var feeendtimeright='';//完工时间
				var ifeetypetimeright='';//计费时间
				var jrlxright = '';//接入类型
				var addressinputright ='';
				var flag = false;				
				
				var spower = '';				
				//是否可以不选一次性费用项
				var ableForNoChoose = false;
				
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
						addright = 'true';
						addBright='true';
						deleteright = 'true';
						delBright = 'true';
						editright = 'true';
						editBright = 'true';
						exportright='true';
						printright='true';
						saveright='true';
						checkright='true';
						RemainFeeright='true';//余额1
				        PayTyperight='true';//费用类型2
						iStatusright='true';//用户状态3
						sRealNameright='true';//姓名4
						sBmright='true';//部门5
						sAddressright='true';//地址6
						sRegDateright='true';//开户日期7
						sDh1right='true';//用户类型8
						sDh2right='true';//端口9
					    UserName1right='true';//邮政编码10
						idtyperight='true';//证件类型12
						idcardright='true';//证件号13
						sDhright='true';//电话15
						iSimultaneousright='true';//同时在线数16
						speedright='true';//带宽17
						AcctStartTimeright='true';//账户有效起始时间18
						AcctStopTimeright='true';//账户有效截至时间19
						ipaddrright='true';//绑定IP20
						vlanidright='true';//绑定VLANID21
						iMacAutoBandright='true';//是否绑定
				        linkmanright='true';//联系人
				        linkphoneright='true';//联系电话
				        UserNameright='true';//用户帐号
				        Valueright='true';//用户密码
				        iFeeTyperight='true';//计费规则
				        mobileright='true';//移动电话
				        zafeilistright='true';//杂费类型
				        BroadbandBusinessright='true';//选择宽带业务复选框权限
						TelphoneBusinessright='true';//选择电话业务复选框权限
						sBm2right='true';//部门2
				        sBm3right='true';//部门3
				        sBm4right='true';//部门4
				        MACdzright='true'//mac地址
				        BASright='true';//BAS设备
				        feeendtimeright='true';//完工时间
				        ifeetypetimeright='true';//计费时间
				        jrlxright = 'true';//接入类型
				        addressinputright = 'true';
						flag = true;
						//是否可以不选一次性费用项
						ableForNoChoose = true;				
						
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');
						
						for(var i = 0;i<spowerarr.length-1;i++){
							addright += getCaption(spowerarr[i],'add','')+'|';							
							addBright += getCaption(spowerarr[i],'addB','')+'|';														
							deleteright += getCaption(spowerarr[i],'delete','')+'|';							
							delBright += getCaption(spowerarr[i],'delB','')+'|';							
							editright += getCaption(spowerarr[i],'edit','')+'|';								
							editBright += getCaption(spowerarr[i],'editB','')+'|';								
							exportright += getCaption(spowerarr[i],'export','')+'|';								
							printright += getCaption(spowerarr[i],'print','')+'|';								
							saveright += getCaption(spowerarr[i],'save','')+'|';							
							checkright += getCaption(spowerarr[i],'check','')+'|';///////							
							RemainFeeright += getCaption(spowerarr[i],'yue','')+'|';
							PayTyperight += getCaption(spowerarr[i],'fylx','')+'|';
							iStatusright += getCaption(spowerarr[i],'yhzt','')+'|';
							sRealNameright += getCaption(spowerarr[i],'name','')+'|';
							sBmright += getCaption(spowerarr[i],'bumen','')+'|';
							sAddressright += getCaption(spowerarr[i],'dizhi','')+'|';
							sRegDateright += getCaption(spowerarr[i],'khrq','')+'|';
							sDh1right += getCaption(spowerarr[i],'yhlx','')+'|';
							sDh2right += getCaption(spowerarr[i],'dkh','')+'|';
							UserName1right += getCaption(spowerarr[i],'yzbm','')+'|';
							idtyperight += getCaption(spowerarr[i],'zjlx','')+'|';
							idcardright += getCaption(spowerarr[i],'zjhm','')+'|';
							sDhright += getCaption(spowerarr[i],'dianhua','')+'|';
							iSimultaneousright += getCaption(spowerarr[i],'tszxs','')+'|';
							speedright += getCaption(spowerarr[i],'daikuan','')+'|';
							AcctStartTimeright += getCaption(spowerarr[i],'zhqssj','')+'|';
							AcctStopTimeright += getCaption(spowerarr[i],'zhjzsj','')+'|';
							ipaddrright += getCaption(spowerarr[i],'bdIP','')+'|';
							vlanidright += getCaption(spowerarr[i],'bdVLANID','')+'|';
							iMacAutoBandright += getCaption(spowerarr[i],'sfbd','')+'|';
							linkmanright += getCaption(spowerarr[i],'lxr','')+'|';
							linkphoneright += getCaption(spowerarr[i],'lxdh','')+'|';							
							UserNameright += getCaption(spowerarr[i],'yhzh','')+'|';
							Valueright += getCaption(spowerarr[i],'yhpwd','')+'|';
							iFeeTyperight += getCaption(spowerarr[i],'jfgz','')+'|';
							mobileright += getCaption(spowerarr[i],'yddh','')+'|';
							zafeilistright += getCaption(spowerarr[i],'zflx','')+'|';							
							BroadbandBusinessright += getCaption(spowerarr[i],'broadYW','')+'|';						
							TelphoneBusinessright += getCaption(spowerarr[i],'telphoneYW','')+'|';							
							sBm2right += getCaption(spowerarr[i],'sBm2','')+'|';
							sBm3right += getCaption(spowerarr[i],'sBm3','')+'|';
							sBm4right += getCaption(spowerarr[i],'sBm4','')+'|';
							MACdzright += getCaption(spowerarr[i],'MACdz','')+'|';
							BASright += getCaption(spowerarr[i],'BASsb','')+'|';;//BAS设备
				            feeendtimeright += getCaption(spowerarr[i],'Completiontime','')+'|';//完工时间
				            ifeetypetimeright+= getCaption(spowerarr[i],'Billingtime','')+'|';//计费时间
							jrlxright+= getCaption(spowerarr[i],'eidtjrlx','')+'|';//接入类型
							addressinputright += getCaption(spowerarr[i],'addressinput','')+'|';//地址是否可选择
							//是否可以不选
							if(getCaption(spowerarr[i],'ableForNoChoose','')=="true")
							{
								ableForNoChoose = true;
							}
						}
				}	
				
				var hasadd = addright.split('|');
				var hasaddB = addBright.split('|');
				var hasdelete = deleteright.split('|');
				var hasdelB = delBright.split('|');				
				var hasedit = editright.split('|');
				var haseditB = editBright.split('|');
				var hasexport = exportright.split('|');
				var hasprint = printright.split('|');
				var hassave = saveright.split('|');
				var hascheck = checkright.split('|');
				
				var hasRemainFee=RemainFeeright.split('|');//余额
				var hasPayType=PayTyperight.split('|');//费用类型
				var hasiStatus=iStatusright.split('|');//用户状态
				var hassRealName=sRealNameright.split('|');//姓名
				var hassBm=sBmright.split('|');//部门
				var hassAddress=sAddressright.split('|');//地址
				var hassRegDate=sRegDateright.split('|');//开户日期
				var hassDh1=sDh1right.split('|');//用户类型
				var hassDh2=sDh2right.split('|');//端口
				var hasUserName1=UserName1right.split('|');//邮政编码
				var hasidtype=idtyperight.split('|');//证件类型
				var hasidcard=idcardright.split('|');//证件号码
				var hassDh=sDhright.split('|');//电话
				var hasiSimultaneous=iSimultaneousright.split('|');//同时在线数
				var hasspeed=speedright.split('|');//带宽
				var hasAcctStartTime=AcctStartTimeright.split('|');//账户有效起始时间
				var hasAcctStopTime=AcctStopTimeright.split('|');//账户有效截至时间
				var hasipaddr=ipaddrright.split('|');//绑定IP
				var hasvlanid=vlanidright.split('|');//绑定VLANID
				var hasiMacAutoBand=iMacAutoBandright.split('|');//绑定VLANID
				var haslinkman=linkmanright.split('|');//绑定VLANID
				var haslinkphone=linkphoneright.split('|');//绑定VLANID
				
				var hasUserName=UserNameright.split('|');//用户帐号
				var hasValue=Valueright.split('|');//用户密码
				var hasiFeeType=iFeeTyperight.split('|');//计费规则
				var hasmobile=mobileright.split('|');//计费规则
				var haszafeilist=zafeilistright.split('|');//杂费类型
				var hasBroadbandBusiness = BroadbandBusinessright.split('|');
				var hasTelphoneBusiness = TelphoneBusinessright.split('|');
				var hassBm2 = sBm2right.split('|');
				var hassBm3 = sBm3right.split('|');
				var hassBm4 = sBm4right.split('|');
				var hasMACdz = MACdzright.split('|');
				var hasBAS= BASright.split('|');//BAS设备
				var hasfeeendtime=feeendtimeright.split('|');//完工时间
				var hasifeetypetime=ifeetypetimeright.split('|');//计费时间
				var hasjrlx=jrlxright.split('|');//计费时间
				var hasaddressinput = addressinputright.split('|');//地址是否可选
				var str = 'true';
				
				if(flag==true){
					$("#addright").val(addright);
					$("#addBright").val(addBright);
					$("#deleteright").val(deleteright);
					$("#delBright").val(delBright);
					$("#editright").val(editright);
					$("#editBright").val(editright);
					$("#exportright").val(exportright);
					$("#printright").val(printright);
					$("#saveright").val(saveright);
					$("#checkright").val(checkright);					
					$("#RemainFeeright").val(RemainFeeright);
					$("#PayTyperight").val(PayTyperight);
					$("#iStatusright").val(iStatusright);
					$("#sRealNameright").val(sRealNameright);
					$("#sBmright").val(sBmright);
					$("#sAddressright").val(sAddressright);
					$("#sRegDateright").val(sRegDateright);
					$("#sDh1right").val(sDh1right);
					$("#sDh2right").val(sDh2right);
					$("#UserName1right").val(UserName1right);
					$("#idtyperight").val(idtyperight);
					$("#idcardright").val(idcardright);
					$("#sDhright").val(sDhright);
					$("#iSimultaneousright").val(iSimultaneousright);
					$("#speedright").val(speedright);
					$("#AcctStartTimeright").val(AcctStartTimeright);
					$("#AcctStopTimeright").val(AcctStopTimeright);
					$("#ipaddrright").val(ipaddrright);
					$("#vlanidright").val(vlanidright);
					$("#iMacAutoBandright").val(iMacAutoBandright);
					$("#linkmanright").val(linkmanright);
					$("#linkphoneright").val(linkphoneright);
					$("#UserNameright").val(UserNameright);
					$("#Valueright").val(Valueright);
					$("#iFeeTyperight").val(iFeeTyperight);
					$("#mobileright").val(mobileright);
					$("#zafeilistright").val(zafeilistright);
					$("#BroadbandBusinessright").val(BroadbandBusinessright);
					$("#TelphoneBusinessright").val(TelphoneBusinessright);
					$("#sBm2right").val(sBm2right);
					$("#sBm3right").val(sBm3right);
					$("#sBm4right").val(sBm4right);
					$("#MACdzright").val(MACdzright);
					
					$("#BASright").val(BASright);
					$("#feeendtimeright").val(feeendtimeright);
					$("#ifeetypetimeright").val(ifeetypetimeright);
					$("#jrlxright").val(jrlxright);
					$("#addressinputright").val(addressinputright);
					
					
				}else{
					for(var i = 0;i<hasadd.length;i++){
						if(hasadd[i]=='true'){
							$("#addright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasaddB.length;i++){
						if(hasaddB[i]=='true'){
							$("#addBright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelete.length;i++){
						if(hasdelete[i]=='true'){
							$("#deleteright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelB.length;i++){
						if(hasdelB[i]=='true'){
							$("#delBright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasedit.length;i++){
						if(hasedit[i]=='true'){
							$("#editright").val(str);
							break;
						}
					}
					for(var i = 0;i<haseditB.length;i++){
						if(haseditB[i]=='true'){
							$("#editBright").val(str);
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
					for(var i = 0;i<hassave.length;i++){
						if(hassave[i]=='true'){
							$("#saveright").val(str);
							break;
						}
					}
					for(var i = 0;i<hascheck.length;i++){
						if(hascheck[i]=='true'){
							$("#checkright").val(str);
							break;
						}
					}
					//////////////////////////////////////////////////////////////////////////
					for(var i = 0;i<hasRemainFee.length;i++){
						if(hasRemainFee[i]=='true'){
							$("#RemainFeeright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasPayType.length;i++){
						if(hasPayType[i]=='true'){
					        $("#PayTyperight").val(str);
							break;
						}
					}
					for(var i = 0;i<hasiStatus.length;i++){
						if(hasiStatus[i]=='true'){
					       $("#iStatusright").val(str);
							break;
						}
					}
					for(var i = 0;i<hassRealName.length;i++){
						if(hassRealName[i]=='true'){
							$("#sRealNameright").val(str);
							break;
						}
					}
					for(var i = 0;i<hassBm.length;i++){
						if(hassBm[i]=='true'){
							$("#sBmright").val(str);
							break;
						}
					}
					for(var i = 0;i<hassAddress.length;i++){
						if(hassAddress[i]=='true'){
							$("#sAddressright").val(str);
							break;
						}
					}
					for(var i = 0;i<hassRegDate.length;i++){
						if(hassRegDate[i]=='true'){
							$("#sRegDateright").val(str);
							break;
						}
					}
					for(var i = 0;i<hassDh1.length;i++){
						if(hassDh1[i]=='true'){
							$("#sDh1right").val(str);
							break;
						}
					}
					for(var i = 0;i<hassDh2.length;i++){
						if(hassDh2[i]=='true'){
							$("#sDh2right").val(str);
							break;
						}
					}
					for(var i = 0;i<hasUserName1.length;i++){
						if(hasUserName1[i]=='true'){
							$("#UserName1right").val(str);
							break;
						}
					}
					for(var i = 0;i<hasidtype.length;i++){
						if(hasidtype[i]=='true'){
							$("#idtyperight").val(str);
							break;
						}
					}
					for(var i = 0;i<hasidcard.length;i++){
						if(hasidcard[i]=='true'){
							$("#idcardright").val(str);
							break;
						}
					}
					for(var i = 0;i<hassDh.length;i++){
						if(hassDh[i]=='true'){
							$("#sDhright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasiSimultaneous.length;i++){
						if(hasiSimultaneous[i]=='true'){
							$("#iSimultaneousright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasspeed.length;i++){
						if(hasspeed[i]=='true'){
							$("#speedright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasAcctStartTime.length;i++){
						if(hasAcctStartTime[i]=='true'){
							$("#AcctStartTimeright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasAcctStopTime.length;i++){
						if(hasAcctStopTime[i]=='true'){
							$("#AcctStopTimeright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasipaddr.length;i++){
						if(hasipaddr[i]=='true'){
							$("#ipaddrright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasvlanid.length;i++){
						if(hasvlanid[i]=='true'){
							$("#vlanidright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasiMacAutoBand.length;i++){
						if(hasiMacAutoBand[i]=='true'){
							$("#iMacAutoBandright").val(str);
							break;
						}
					}
					for(var i = 0;i<haslinkman.length;i++){
						if(haslinkman[i]=='true'){
							$("#linkmanright").val(str);
							break;
						}
					}	
					for(var i = 0;i<haslinkphone.length;i++){
						if(haslinkphone[i]=='true'){
							$("#linkphoneright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasUserName.length;i++){
						if(hasUserName[i]=='true'){
							$("#UserNameright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasValue.length;i++){
						if(hasValue[i]=='true'){
							$("#Valueright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasiFeeType.length;i++){
						if(hasiFeeType[i]=='true'){
							$("#iFeeTyperight").val(str);
							break;
						}
					}
					for(var i = 0;i<hasmobile.length;i++){
						if(hasmobile[i]=='true'){
							$("#mobileright").val(str);
							break;
						}	
					}	
					for(var i = 0;i<haszafeilist.length;i++){	
					if(haszafeilist[i]=='true'){
							$("#zafeilistright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasBroadbandBusiness.length;i++){
						if(hasBroadbandBusiness[i]=='true'){
							$("#BroadbandBusinessright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasTelphoneBusiness.length;i++){
						if(hasTelphoneBusiness[i]=='true'){
							$("#TelphoneBusinessright").val(str);
							break;
						}
					}
					for(var i = 0;i<hassBm2.length;i++){
						if(hassBm2[i]=='true'){
							$("#sBm2right").val(str);
							break;
						}
					}
					for(var i = 0;i<hassBm3.length;i++){
						if(hassBm3[i]=='true'){
							$("#sBm3right").val(str);
							break;
						}
					}
					for(var i = 0;i<hassBm4.length;i++){
						if(hassBm4[i]=='true'){
							$("#sBm4right").val(str);
							break;
						}
					}
					for(var i = 0;i<hasMACdz.length;i++){
						if(hasMACdz[i]=='true'){
							$("#MACdzright").val(str);
							break;
						}
					}
					
					for(var i = 0;i<hasBAS.length;i++){
						if(hasBAS[i]=='true'){
							$("#BASright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasfeeendtime.length;i++){
						if(hasfeeendtime[i]=='true'){
							$("#feeendtimeright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasifeetypetime.length;i++){
						if(hasifeetypetime[i]=='true'){
							$("#ifeetypetimeright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasjrlx.length;i++){
						if(hasjrlx[i]=='true'){
							$("#jrlxright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasaddressinput.length;i++){
						if(hasaddressinput[i]=='true'){
							$("#addressinputright").val(str);
							break;
						}
					}
				}	
				
				
				//隐藏域赋值 设置是否可以不选
				$("#ableForNoChoose").val(ableForNoChoose?"true":"false");	
			
			}
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		
		//ids:传主见ID值，useradmin：当前登录的用户或管理员,username用户帐号,qjfeename得到指定的计费规则信息,useridto查询用户的工号
    	var ids;
    	var QJiFeeType;
    	var username;
    	var qjfeename;
    	var useridto;
    	var zfx;//杂费项
    	var zfxfeename;//为feename传值的全局变量
    
  	/////////////////////////////////////////////////////////////////
	//     下拉-杂费类型获取值填入杂费项
	/////////////////////////////////////////////////////////////////
	   function yzproperty(){
	            var RemainFeeright=$("#RemainFeeright").val();//余额
				var PayTyperight=$("#PayTyperight").val();//用户类别
				var iStatusright=$("#iStatusright").val();//用户状态
				var sRealNameright=$("#sRealNameright").val();//姓名
				var sBmright=$("#sBmright").val();//部门
				var sAddressright=$("#sAddressright").val();//地址
				var sRegDateright=$("#sRegDateright").val();//开户日期
				
				var sDh2right=$("#sDh2right").val();//端口
				var UserName1right=$("#UserName1right").val();//邮政编码
				var idtyperight=$("#idtyperight").val();//证件类型
				var idcardright=$("#idcardright").val();//证件号码
				var sDhright=$("#sDhright").val();//电话
				var iSimultaneousright=$("#iSimultaneousright").val();//同时在线数
				var speedright=$("#speedright").val();//带宽
				var AcctStartTimeright=$("#AcctStartTimeright").val();//账户有效起始时间
				var AcctStopTimeright=$("#AcctStopTimeright").val();//账户有效截至时间
				var ipaddrright=$("#ipaddrright").val();//绑定IP
				var vlanidright=$("#vlanidright").val();//绑定VLANID
				var iMacAutoBandright=$("#iMacAutoBandright").val();//是否绑定
				var linkmanright=$("#linkmanright").val();//联系人
				var linkphoneright=$("#linkphoneright").val();//联系电话
				var mobileright=$("#mobileright").val();//移动电话
				var UserNameright=$("#UserNameright").val();//用户帐号
				var Valueright=$("#Valueright").val();//用户密码
				var iFeeTyperight=$("#iFeeTyperight").val();//计费规则
				var zafeilistright=$("#zafeilistright").val();//杂费类型
				var BroadbandBusinessright =　$("#BroadbandBusinessright").val();
	            var TelphoneBusinessright = $("#TelphoneBusinessright").val();
	            var sBm2right = $("#sBm2right").val();
	            var sBm3right = $("#sBm3right").val();
	            var sBm4right = $("#sBm4right").val();
	            var MACdzright = $("#MACdzright").val();
				var BASright = $("#BASright").val();
				var feeendtimeright = $("#feeendtimeright").val();
				var ifeetypetimeright =	$("#ifeetypetimeright").val();
				
				var jrlxright =	$("#jrlxright").val();
				var sDh1right=$("#sDh1right").val();//用户类型
				
				
				//修改用户类型 --edit by chenliang
				if(sDh1right=="true"){
				   $("#sDh1").removeAttr("disabled");
				}
				if(jrlxright=="true"){
				   $("#accessmethods").removeAttr("disabled");
				}
				
				if(idtyperight=="true"){
				   $("#idtype").attr("disabled","");
				}
				if(idcardright=="true"){
				   $("#idcard").attr("disabled","");
				}
				if(sRealNameright=="true"){
				   $("#sRealName").attr("disabled","");
				}
				if(sAddressright=="true"){
				   $("#sAddress").attr("disabled","");
				}
				if(UserName1right=="true"){
				   $("#UserName1").attr("disabled","");
				}
				if(iStatusright=="true"){
				   $("#iStatus").attr("disabled","");
				}
				if(sDhright=="true"){
				   $("#sDh").attr("disabled","");
				}
				if(mobileright=="true"){
				   $("#mobile").attr("disabled","");
				}
				if(vlanidright=="true"){
				   $("#vlanid").attr("disabled","");
				}
				if(BroadbandBusinessright=="true"){
	               $("#BroadbandBusiness").attr("disabled","");
	            }
	            if(TelphoneBusinessright=="true"){
	             $("#TelphoneBusiness").attr("disabled","");
	            }	             
	            if(sBmright=="true"){
				   $("#sBm").attr("disabled","");
				}
	            if(Valueright=="true"){
				   $("#Values").attr("disabled","");
				}
	            if(sBm2right=="true"){
	             $("#sBm2").attr("disabled","");
	            }
	            if(sBm3right=="true"){
	             $("#sBm3").attr("disabled","");
	            }
	            if(sBm4right=="true"){
	             $("#sBm4").attr("disabled","");
	            }
	            if(zafeilistright=="true"){
				   $("#zafeilist").attr("disabled","");
				}
				if(linkmanright=="true"){
				   $("#linkman").attr("disabled","");
				}
				if(linkphoneright=="true"){
				   $("#linkphone").attr("disabled","");
				}
				if(MACdzright=="true"){
				   $("#UserName1").removeAttr("disabled");
				}
				if(BASright=="true"){
				   $("#devno").removeAttr("disabled");
				}
				if(feeendtimeright=="true"){
					$("#feeendtime").removeAttr("disabled");
				}
				if(ifeetypetimeright=="true"){
					$("#iFeeTypeTime").removeAttr("disabled");
				}
				if($("#addressinputright").val()=="true"){
				    $("#sAddress").focus(function(){c_p_address_fun();});
					$("#sAddress").keyup(function(){notecheck();});
				}
	   }
	   
	   function notecheck(){
			 	var notecheck = $("#sAddress").val();
			    if(notecheck.length>0){
			    	 $("#sAddress").val(notecheck.substr(0,0));
			    }
			 }
	   
	////////////////////////页面加载开始处////////////////////////////////////////////   	  
	   jQuery(document).ready(function()
	   {
	       var languageType = $("#languageType").val();
    	   brodbandinter(languageType);//页面字段国际化
	   
	         jiesuo();
       		//页面表头当前位置显示
	       $("#navBar").append(genNavv());
	       
		   //自动加载杂费项
		   queryFeename();      		    
		    //判断权限
		    getUserPower();
		    yzproperty();
		    var saveright = $("#saveright").val(); 
		    var checkright = $("#checkright").val();
		    if(saveright=="true"){
		    $("#closequxiao").attr("disabled","");
		    $("#closesave").attr("disabled","");
		    //$("#close").attr("readonly","readonly");
		    }
		    if(checkright=="true"){
		     $("#zafeilist").attr("disabled","");
		    }
		    
		    $("#TJzt").hide();//默认情况下隐藏停机状态的复机时间和月份数
		});
    	
    	
    	function jiesuo(){
	        $(window).unload(function(){
			kdunLock();
		    });
	    }	
   	/////////////////////////////////////////////////////////////////
	//      拼接更新参数
	/////////////////////////////////////////////////////////////////	 	
	
        function buildnewParams(){
		 tsd.QualifiedVal=true;
		 var params='';
		             var userid = $("#userid").val();
		             var area = $("#area").val();
		             var depart = $("#depart").val();
		             var UserName=$("#UserName").val();//用户帐号
		             UserName=UserName.replace(/(^\s*)|(\s*$)/g,"");
		             /*
		             var um=/^\ {0,}(\w){3,10}\ {0,}$/;
		             if(!um.test(UserName)&&UserName.length!=0){
		             //用户帐号不合法，请重新填写!
		                alert("<fmt:message key="gjh.yhzhbhf"/>");
		                $("#UserName").select();
            			$("#UserName").focus();
		                return false;
		             } */
		             var Value=$("#Values").val();//用户密码
		             Value=Value.replace(/(^\s*)|(\s*$)/g,"");	
		             var pwd=/^\ {0,}([A-Za-z0-9]|[._]){3,19}\ {0,}$/; 
		             if(!pwd.test(Value)&&Value.length!=0){
		             //用户密码不合法,请确认是否是6到20位，或有非法字符存在！
		                alert("密码最少为3为！");
		                $("#Values").select();
            			$("#Values").focus();
		                return false;
		             }	     
					 var sBm=$("select[id='sBm'] :selected").html();;//部门
					 var sRegDate=$("#sRegDate").val();//开户日期
					 var sDh1=$("#sDh1").val();//用户类型
					 var mobile=$("#mobile").val();//移动电话
					 mobile=mobile.replace(/(^\s*)|(\s*$)/g,"");
					 var reh =/^\ {0,}[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+\ {0,}$/;
					 if(!reh.test(mobile)&&mobile.length!=0){
					 //移动电话不合法，请重新输入！
					    alert("<fmt:message key="gjh.yddhbhf"/>");
					    $("#mobile").select();
            			$("#mobile").focus();
					    return false;
					 }
					 var idtype=$("#idtype").val();//证件类型
					 var idcard=$("#idcard").val();//证件号码
					 idcard=idcard.replace(/(^\s*)|(\s*$)/g,"");
					 /**
					 var rer=/\d{17}[\d|X]|\d{15}/; 
					  var idcardcode = $("#idcard").attr("disabled");
					  if(idcardcode!=true){
					    if(!rer.test(idcard)&&idcard.length!=0){
					       alert("<fmt:message key="gjh.zjhmbhf"/>");
					       $("#idcard").select();
            	           $("#idcard").focus();
					       return false;
					      }
					 }**/
					 var iSimultaneous=$("#iSimultaneous").val();//同时在线数	
					 iSimultaneous=iSimultaneous.replace(/(^\s*)|(\s*$)/g,"");
					 var sz=/^\ {0,}[0-9]{1}[0-9]{0,}\ {0,}$/;
					 if(!sz.test(iSimultaneous)&&iSimultaneous.length!=0){
					 //同时在线数不合法，请重新输入！
					    alert("<fmt:message key="gjh.tszxsbhf"/>");
					    $("#iSimultaneous").select();
            			$("#iSimultaneous").focus();
					    return false;
					 }		 
					 var AcctStartTime=$("#AcctStartTime").val();//账户有效起始时间
					 var AcctStopTime=$("#AcctStopTime").val();//账户有效截至时间
					 var ipaddr=$("#ipaddr").val();//绑定IP
					 ipaddr=ipaddr.replace(/(^\s*)|(\s*$)/g,"");
					 var ree=/^\ {0,}(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$\ {0,}/;
					 if(!ree.test(ipaddr)&&ipaddr.length!=0){
					 //绑定IP不合法，请重新输入！
					    alert("<fmt:message key="gjh.bdIPbhf"/>");
					    $("#ipaddr").select();
            			$("#ipaddr").focus();
					    return false;
					 }
					 var vlanid=$("#vlanid").val();//绑定VLANID
					 vlanid=vlanid.replace(/(^\s*)|(\s*$)/g,"");
					 //var regg = /^[^*/\\?]+$/g;					 
					 //if(!regg.test(vlanid)){
					 //  alert("不能输入非法字符！");
					 //  return false;
					 //}
				     var linkman=$("#linkman").val();//联系人
				     linkman=linkman.replace(/(^\s*)|(\s*$)/g,"");
				     var linkphone=$("#linkphone").val();//联系电话
				     linkphone=linkphone.replace(/(^\s*)|(\s*$)/g,"");
				     var reb =/^\ {0,}[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+\ {0,}$/;
				     if(!reb.test(linkphone)&&linkphone.length!=0){
				     //联系电话不合法，请重新输入！
					    alert("<fmt:message key="gjh.lxdhbhf"/>");
					    $("#linkphone").select();
            			$("#linkphone").focus();
					    return false;
					 }
					 var sDh = $("#sDh").val();
					 var sDh1 = $("#sDh1").val();
					 
					 var iFeeType = $("#iFeeType").val();
					
					 var sRealName = $("#sRealName").val();
					 var sAddress = $("#sAddress").val();
					 var zafeilist = $("#zafeilist").val(); 
					 var feei = $("#feei").val();
					 $("#printfeeee").val(feei);
					 var iStatus = $("#iStatus").val();
					 var UserName1 = $("#UserName1").val();
					 //此方法得到select外面的值，不是value的值
					 var sBm2 = $("select[id='sBm2'] :selected").html();
					 var sBm3 = $("select[id='sBm3'] :selected").html();
					 var sBm4 = $("select[id='sBm4'] :selected").html();
					 var sbmt = $("#sBm").val();				 
					 var sbmt2 = $("#sBm2").val();
					 
					 var disabled1 = $("#sBm").attr("disabled");
					 var disabled2 = $("#sBm2").attr("disabled");
					 var disabled3 = $("#sBm3").attr("disabled");
					 var disabled4 = $("#sBm4").attr("disabled");					  
					if(disabled1!=true&&disabled2!=true&&disabled3!=true&&disabled4!=true){
					 if($('#sBm2 option').size()>1&&sbmt2==""){
					 	   alert("<fmt:message key="broadband.selectsbm2"/>");
					 	   $("#sBm2").select();
					 	   $("#sBm2").focus();
					 	   return false;
					 	}
					 var sbmt3 = $("#sBm3").val();
					 if($('#sBm3 option').size()>1&&sbmt3==""){
					 	   alert("<fmt:message key="broadband.selectsbm3"/>");
					 	   $("#sBm3").select();
					 	   $("#sBm3").focus();
					 	   return false;
					 	}
					 var sbmt4 = $("#sBm4").val();
					 if($('#sBm4 option').size()>1&&sbmt4==""){
					 	   alert("<fmt:message key="broadband.selectsbm4"/>");
					 	   $("#sBm4").select();
					 	   $("#sBm4").focus();
					 	   return false;
					 	}
					 if(sbmt==''){
					 	 var sBm='';
					 	}
					 	if(sbmt2==''){
					 	  var sBm2='';
					 	}
					 	if(sbmt3==''){
					 	   var sBm3='';
					 	}
					 	if(sbmt4==''){
					 	  var sBm4='';
					 	}
					 }
				  var hth = $("#hth").val();
				  
				  var sspeed = $("#sspeed").val();
				  var devno = $("#devno").val();
	              var getspeed="";
	              
	              if(devno=="1"&&sspeed.toUpperCase().indexOf("PPPOE")==0){
	              	 speed = sspeed.toUpperCase().replace("PPPOE","");	              	 
	              	 speed = speed.replace("M","");	              	 
	              	 getspeed = parseInt(speed,10)*1024000;
	              }else if(devno=="2"&&sspeed.toUpperCase().indexOf("PPPOE")!=0){
	              	 getspeed = parseInt(sspeed,10)/1024000;
	              	 var pspeed = "pppoe*M";
	              	 getspeed = pspeed.replace("*",getspeed);
	              }else{
	              	 getspeed = sspeed;
	              }
	              var feeendtime = $("#feeendtime").val();
	              var iFeeTypeTime = $("#iFeeTypeTime").val();
         			
         		  //edit by chenliang --start
         		  var accessmethods = $("#accessmethods").val();
         		  if(accessmethods=='')
         		  {
         		  	alert('请选择接入类型!');
         		  	$('#accessmethods').focus();
         		  	return false;
         		  }
         		  //edit by chenliang --end
         		  
         params+="&flag=0&tsdflag=modify";
         params+="&userid="+tsd.encodeURIComponent(userid);
         params+="&area="+tsd.encodeURIComponent(area);
         params+="&depart="+tsd.encodeURIComponent(depart);
         params+="&username="+tsd.encodeURIComponent(UserName);
         params+="&password="+tsd.encodeURIComponent(Value);
		 params+="&sDh="+tsd.encodeURIComponent(sDh);
		 
		 params+="&sRealName="+tsd.encodeURIComponent(sRealName);		 
		 params+="&sBm="+tsd.encodeURIComponent(sBm);
		 params+="&sRegDate="+tsd.encodeURIComponent(sRegDate);
		 if(sDh1==''){
		 	alert('请选择用户类型!');
		 	$('#sDh1').focus();
		 	return;
		 }
		 params+="&usertype="+tsd.encodeURIComponent(sDh1);
		 params+="&sMobilePhone="+tsd.encodeURIComponent(mobile);	
		 
		 params+="&sAddress="+tsd.encodeURIComponent(sAddress);		 
		 params+="&idtype="+tsd.encodeURIComponent(idtype);
		 params+="&idcard="+tsd.encodeURIComponent(idcard);	
		 params+="&iSimultaneous="+tsd.encodeURIComponent(iSimultaneous);	
		 		 
		 params+="&AcctStartTime="+tsd.encodeURIComponent(AcctStartTime);
		 params+="&AcctStopTime="+tsd.encodeURIComponent(AcctStopTime);
		 params+="&ipaddr="+tsd.encodeURIComponent(ipaddr);
		 params+="&vlanid="+tsd.encodeURIComponent(vlanid);
		 params+="&linkman="+tsd.encodeURIComponent(linkman);
		 params+="&linkphone="+tsd.encodeURIComponent(linkphone);
		 params+="&bmhth="+tsd.encodeURIComponent(hth);
		 queryFeeInfo();
		 
		 params+="&feename="+zfxfeenameto;
		 params+="&fee="+tsd.encodeURIComponent(feei);
		 params+="&sBm2="+tsd.encodeURIComponent(sBm2);
		 params+="&sBm3="+tsd.encodeURIComponent(sBm3);
		 params+="&sBm4="+tsd.encodeURIComponent(sBm4);
		 params+="&iFeeType="+tsd.encodeURIComponent(iFeeType);
		 params+="&iStatus="+tsd.encodeURIComponent(iStatus);
		 params+="&UserName1="+tsd.encodeURIComponent(UserName1);
		 params+="&devno="+tsd.encodeURIComponent(devno);
		 params+="&getspeed="+tsd.encodeURIComponent(getspeed);
		 params+="&feeendtime="+tsd.encodeURIComponent(feeendtime);
		 params+="&iFeeTypeTime="+tsd.encodeURIComponent(iFeeTypeTime);
		 params+="&iFeeTypeS="+tsd.encodeURIComponent(accessmethods);
		 
		 if(tsd.Qualified()==false){return false;}
		 return params;
		 }	
		 
		  /////////////////////////////////////////////////////////////////
		  //      查询下拉列表--计费规则
		  ///////////////////////////////////////////////////////////////// 	
	      var ify=""; 
		  function aQueryObj(usertype){
	      var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'tbl_IspList.toquery'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});				
			$.ajax({
					url:'mainServlet.html?'+urlstr+"&usertype="+usertype,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){	
					ify="";						
								///////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
								$(xml).find('row').each(function(){
								//////////给下拉框进行赋值操作、
								var ee="<option value='"+$(this).attr("feecode")+"'>"+$(this).attr("feename")+"</option>";
								ify = ify+ee;				
							});
							$("#iFeeType").html("<option value='100'></option>");
							$("#iFeeType").html($("#iFeeType").html()+ify);
						}
					});
				}
		 	 
		/////////////////////////////////////////////////////////////////
		//查询用户数据 
		/////////////////////////////////////////////////////////////////
		 function QueryObj(params){		
		  //var params = buildParams();	
		  if(params==false){return false;}
		  var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'radcheck.toqueryall',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdUserID:'ture'
						 				});		 				
			urlstr+=params;			
			$.ajax({
					url:'mainServlet.html?'+urlstr,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						/////////////////////////////
						//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
						$(xml).find('row').each(function(){						 
							   var id = $(this).attr("id");		
							   ids=id;
				          	if(id==undefined){
					                    clearText("form1");																			
										jAlert('<fmt:message key="gjh.usernot"/>','<fmt:message key="gjh.tsk"/>');										
					        }else{					        
							getBASsb();
		                    queryFeename();
		                    
		                    isnotifurgent();//备注是否紧急
		                    getBASsb();//设备
		                    $("#pausestoptime").val("");
		                    $("#FJMonth").val("");
		                    $("#jobmemo").removeAttr("disabled"); 
							$("#id").val(id);														
					     	var PauseStartTime = $(this).attr("pausestarttime");		//隐藏字段					     															
							$("#PauseStartTime").val(PauseStartTime);							
					        var PauseStopTime = $(this).attr("pausestoptime");		//隐藏字段																
							$("#pausestoptime").val(PauseStopTime);
							var FJMonth=getFJMonth(PauseStopTime.substring(0,19));
							$("#FJMonth").val(FJMonth+"个月");//得到还有几个月复机的月份数
					        var AcctStartMonth = $(this).attr("acctstartmonth");		//隐藏字段																
							$("#AcctStartMonth").val(AcctStartMonth);
					        var AcctEndMonth = $(this).attr("acctendmonth");		//隐藏字段																
							$("#AcctEndMonth").val(AcctEndMonth);			
					        var PauseStartMonth = $(this).attr("pausestartmonth");		//隐藏字段																
							$("#PauseStartMonth").val(PauseStartMonth);			
					        var PauseEndMonth = $(this).attr("pauseendmonth");		//隐藏字段																
							$("#PauseEndMonth").val(PauseEndMonth);			
					        var UserID = $(this).attr("userid");		            //隐藏字段
					        $("#devno").val(UserID);
					        $("#useridID").val(UserID);					       	
					        var iFeeStopType = $(this).attr("ifeestoptype");																		
							$("#iFeeStopType").val(iFeeStopType);
							$("#inputiFeeStopType").val(iFeeStopType);					
					        var iAutoSessiontimeout = $(this).attr("iautosessiontimeout");		//隐藏字段																
							$("#iAutoSessiontimeout").val(iAutoSessiontimeout);					
						    var RemainTime = $(this).attr("remaintime");		//隐藏字段																
							$("#RemainTime").val(RemainTime);					
				        	var thismonthtime = $(this).attr("thismonthtime");		//隐藏字段																
							$("#thismonthtime").val(thismonthtime);					
					    	var nextmonthtime = $(this).attr("nextmonthtime");		//隐藏字段																
							$("#nextmonthtime").val(nextmonthtime);					
					     	var totaltime = $(this).attr("totaltime");		//隐藏字段																
							$("#totaltime").val(totaltime);				
					      	var feeendtime = $(this).attr("feeendtime");		//隐藏字段	
					      	if(feeendtime == '2999-12-30 00:00:00'){
					      		feeendtime = "该用户未完工";
					      	}															
							$("#feeendtime").val(feeendtime.substring(0,19));				
					        var iFeeTypeTime = $(this).attr("ifeetypetime");		//隐藏字段																
							$("#iFeeTypeTime").val(iFeeTypeTime.substring(0,19));					
					        var iFeeType1 = $(this).attr("ifeetype1");		//隐藏字段																
							$("#iFeeType1").val(iFeeType1);				
					      	var iFeeTypeS = $(this).attr("ifeetypes");		//隐藏字段																
							$("#iFeeTypeS").val(iFeeTypeS);	//接入类型
							//edit by chenliang --start
							$('#accessmethods').val(iFeeTypeS);//选中值
							$('#oldjrlx').val(iFeeTypeS);//原始值
							//edit by chenliang --end
									
					        var Fee5 = $(this).attr("fee5");		//隐藏字段																
							$("#Fee5").val(Fee5);
					        var Fee1 = $(this).attr("fee1");																		
							$("#Fee1").val(Fee1);
					        var Fee2 = $(this).attr("fee2");																		
							$("#Fee2").val(Fee2);
					        var Fee3 = $(this).attr("fee3");																	
							$("#Fee3").val(Fee3);
					        var Fee4 = $(this).attr("fee4");																		
							$("#Fee4").val(Fee4);
							var UserName = $(this).attr("username");
							username=UserName;
							$("#UserName").val(UserName);														
							var Value = $(this).attr("value");					
							$("#Values").val(Value);
							$("#Valuess").val(Value);
							$("#userPWD").val(Value);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更	
							var ipaddr = $(this).attr("ipaddr");
							$("#ipaddr").val(ipaddr);
							var vlanid = $(this).attr("vlanid");
							$("#vlanid").val(vlanid);
							$("#userBDVLAN").val(vlanid);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							var linkman = $(this).attr("linkman");
							$("#linkman").val(linkman);	//联系人
							$("#userLXR").val(linkman);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							var linkphone = $(this).attr("linkphone");
							$("#linkphone").val(linkphone);//联系电话	
							$("#userLXDH").val(linkphone);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							var AcctStartTime = $(this).attr("acctstarttime");
							$("#AcctStartTime").val(AcctStartTime.substring(0,19));
							var AcctStopTime = $(this).attr("acctstoptime");
							$("#AcctStopTime").val(AcctStopTime.substring(0,19));
							var RemainFee = $(this).attr("remainfee");
					        $("#RemainFee1").val(RemainFee);
							$("#RemainFee").val(RemainFee);								
							var PayType = $(this).attr("paytype");
							$("#PayType").val(PayType);							
							var iFeeType = $(this).attr("ifeetype");
							var sDh1 = $(this).attr("sdh1");
							
							UserTypeSelect(sDh1);//从配置文件里得到用户类型select下拉菜单选项
							
							//显示计费规则（更改后）的下拉菜单
		                    aQueryObj(sDh1);
							$("#sDh1").val(sDh1);
							//edit by chenliang 
							$("#oldsDh1").val(sDh1);
							
							/////////////////根据档案表里的iFeeType的值去查询费率表里的FeeCode字段对应的FeeName值//////////////////////
							var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'tbl_IspList.totoquery'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});						
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&FeeCode='+iFeeType+'&usertype='+sDh1,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              $(xml).find('row').each(function(){	
								  var feename=$(this).attr("feename");
								  QJiFeeType=feename;
								  var ift = "<option value="+iFeeType+">"+feename+"</option>";
									$("#iFeeType").html($("#iFeeType").html()+ift);
									$("#iFeeType").val(feename);
							      });
							      }
							});
							//////////////////////////////////////
							var sDh = $(this).attr("sdh");
							sDhto=sDh;
							$("#sDh").val(sDh);												
							var sRegDate = $(this).attr("sregdate");
							$("#sRegDate").val(sRegDate.substring(0,19));
							var sRealName = $(this).attr("srealname");
							sRealNameto=sRealName
							$("#sRealName").val(sRealName);
							$("#userMC").val(sRealName);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更							
							var curFee =RemainFee-Fee5;	
							$("#curFee").val(curFee);							
							var sBm = $(this).attr("sbm");
							getsBm1();
							//$("#sBm").option(sBm);
							var issBm = isnotdecment(sBm);
							if(issBm=='0'){
								var sb = "<option value="+sBm+">"+sBm+"</option>";
								$("#sBm").html($("#sBm").html()+sb);
								$("#sBm").val(sBm);
							}else{
							    $("#sBm").val(sBm);
							}
							$("#usersBm1").val(sBm);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更	
							
							var sBm2 = $(this).attr("sbm2");
							addsBmer();//得到部门二的下拉菜单
							if(sBm2!=""){
							var sb2 = "<option value="+sBm2+">"+sBm2+"</option>";
							$("#sBm2").html($("#sBm2").html()+sb2);
							$("#sBm2").val(sBm2);
							$("#usersBm2").val(sBm2);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							}	
							
							var sBm3 = $(this).attr("sbm3");							
							addsBmsan();//得到部门三的下拉菜单
							if(sBm3!=""){							
							var sb3 = "<option value="+sBm3+">"+sBm3+"</option>";
							$("#sBm3").html($("#sBm3").html()+sb3);
							$("#sBm3").val(sBm3);
							$("#usersBm3").val(sBm3);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							}
							
							var sBm4 = $(this).attr("sbm4");
							addsBmsi();//得到部门四的下拉菜单
							if(sBm4!=""){
							var sb4 = "<option value="+sBm4+">"+sBm4+"</option>";
							$("#sBm4").html($("#sBm4").html()+sb4);
							$("#sBm4").val(sBm4);
							$("#usersBm4").val(sBm4);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							}
							
							var sAddress = $(this).attr("saddress");
							sAddressto=sAddress;
							$("#sAddress").val(sAddress);
							$("#userDZ").val(sAddress);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							var iStatus = $(this).attr("istatus");
							var iStatusname=""
							$("#TJzt").hide();
							$("#userZT").val(iStatus);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							if(iStatus==0){
							//正常
							 var params=quereyshiftj();
							  if(params>0){
							    iStatusname='申请停机';
							    $("#iStatus").html("<option value='"+iStatus+"' selected=true>"+iStatusname+"</option>");
							    $("#TJzt").show();	
							  }else{
							    iStatusname='正常';
							    $("#iStatus").html("<option value='"+iStatus+"' selected=true>"+iStatusname+"</option>");
							    var ist = "<option value="+'1'+">"+'锁定'+"</option>";
							    $("#iStatus").html($("#iStatus").html()+ist);
							  }
							}
							if(iStatus==1){
							//锁定
							iStatusname='锁定';
							$("#iStatus").html("<option value='"+iStatus+"' selected=true>"+iStatusname+"</option>");
							var ist = "<option value="+'0'+">"+'解锁'+"</option>";
							$("#iStatus").html($("#iStatus").html()+ist);
							}
							if(iStatus==2){
							iStatusname='欠费';
							$("#iStatus").html("<option value='"+iStatus+"' selected=true>"+iStatusname+"</option>");
							}
														
							$("#getiStatus").val(iStatus);
							var iMacAutoBand = $(this).attr("imacautoband");
							$("#iMacAutoBand").val(iMacAutoBand);
							var iSimultaneous = $(this).attr("isimultaneous");
							$("#iSimultaneous").val(iSimultaneous);
							var speed = $(this).attr("speed");
							$("#sspeed").val(speed);
							var speedzh = calBSpeed(speed);//带宽格式转换	
							$("#speed").val(speedzh);
							var autopay = $(this).attr("autopay");
							$("#autopay").val(autopay);							
							var sDh2 = $(this).attr("sDh2");
							$("#sDh2").val(sDh2);
							var UserName1 = $(this).attr("username1");
							$("#UserName1").val(UserName1);
							$("#userMACDZ").val(UserName1);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							var UserName2 = $(this).attr("username2");
							$("#UserName2").val(UserName2);
							var idtype = $(this).attr("idtype");
							$("#idtype").val(idtype);
							var idcard = $(this).attr("idcard");
							$("#idcard").val(idcard);
							$("#userZJHM").val(idcard);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							var mobile = $(this).attr("mobile");
							$("#mobile").val(mobile);		
							$("#userYDDH").val(mobile);//在隐藏中，后面与更改后的做对比，看那些数据进行了变更
							$("#form1").css("display","block");	//展开表单							
							//每次查询后重新加载杂费项和杂费金额
							queryFeename();
							getmemocontent(UserName);//得到历史备注信息
							$("#closesave").removeAttr("disabled");
						 }});
					}
				});
	          }
	          
	          //根据复机时间和当前时间得到复机的月份数
	          function getFJMonth(PauseStopTime){
	             var res = fetchMultiArrayValue("EditProperty.gettimemonth",6,"&PauseStopTime="+PauseStopTime);
	             var PauseMonth = res[0][0];
	             return PauseMonth;
	          }
	          
	          //查询判断用户部门是否在部门表里
	          function isnotdecment(DeptName){	  
	               var res;        
	               var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'department.notcheck'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});						
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&DeptName='+tsd.encodeURIComponent(DeptName),
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              $(xml).find('row').each(function(){	
					              res = $(this).attr("res");
							      });
							      }
							});
				  return res;			
	          }
	          
	           //修改属性值
	           var sRealNameto;//得到从查询中得到的用户姓名与新输入的用户姓名对比
		       var iStatusto;//得到从查询中得到的用户状态与新输入的用户状态对比
		       var sAddressto;//得到从查询中得到的用户地址与新输入的用户地址对比
	           var sDhto;//得到从查询中得到的电话与新输入的电话对比
	           var speedto;//得到从查询中得到的带宽与新输入的带宽对比
	           function userUpdate(){
	              var UserName = $("#UserName").val();
	              if(UserName.length==0){
	                 alert("<fmt:message key="broadband.qsrcxtj"/>");//请输入查询条件
	                 return false;
	              }
	              var yhdangsDh=sDhqueryyhdang();
				        var sDh = $("#sDh").val();
				        if(sDh!=sDhto){ 
				        if(yhdangsDh==0){
				        //该电话不可修改！
						alert("<fmt:message key="stopkeepnumber.gdhbkxg"/>");				
						$("#sDh").val(sDhto);
						$("#sDh").select();
						return false;
					    }
				         var radchecksDh=sDhqueryredcheck();
				         if(radchecksDh!=0){
			            //该电话已经绑定了宽带用户，不能再次被绑定 
						alert("<fmt:message key="AddUser.phonebdband"/>");
						$("#sDh").select();
						$("#sDh").val(sDhto);
						return false;
			          }
	              }
	              if(username==undefined){alert('<fmt:message key="userchanges.qsrcxnr"/>');$("#inputUserName").select();return false;}
	            

				//当checkbox的name值一样的话来区分checkbox那个是否选中状态
		 	 	    var checkedBox = "";
					$("input[type='checkbox'][name='checkbox'][checked]").each(function(i,n){
						checkedBox += $(n).val();
					});
					//是否可以不选
					if(checkedBox=="" && $("input[type='checkbox'][name='checkbox']").size()>0)
					{
						if($("#ableForNoChoose").val()=="false")
						{
							alert("<fmt:message key="broadband.qxzzsyxycxfy"/>");
							return false;
						}
						else if($("#ableForNoChoose").val()=="true")
						{
							if(confirm("<fmt:message key="broadband.sfqrbxycxfy"/>"))
							{
								//确认不选
							}
							else
							{
								return false;
							}
						}
					}
					
	            var params = buildnewParams();
	            var ifurgent = $("#ifurgent").val();
	            var jobmemo = $("#jobmemo").val();
	            jobmemo = jobmemo.replace(/(^\s*)|(\s*$)/g,'');
		         var pat=/[@#\$%\^&\*]+/g; 
			        if(pat.test(jobmemo)) 
			        { 
			         alert("<fmt:message key="broadband.srdbzzbnyffzf"/>"); 
			         $("#jobmemo").select();
			         $("#jobmemo").focus();
			         return false;
			        }
	            ifurgent = tsd.encodeURIComponent(ifurgent);
				      jobmemo = tsd.encodeURIComponent(jobmemo);
		        if(params==false){return false;}
	              if(confirm("<fmt:message key="gjh.yousure"/>"+username+"<fmt:message key="gjh.changevalue"/>")){	           
	              var devno = $("#devno").val();
	              var userid = $("#useridID").val();	              
	              if(devno!=userid){
	                 devno='Y';
	              }else{
	              	 devno='';	
	              }
	              $("#useridID").val("");	              	              
	              var sBm = $("select[id='sBm'] :selected").html();
	              var usersBm1 = $("#usersBm1").val();
	              var sbmtype='';
	              if(sBm!=usersBm1){sbmtype='Y';}	                            	              
	              var Value=$("#Values").val();//用户密码	              
		          var password = $("#Valuess").val();//跟新前密码				                  
		          Value=Value.replace(/(^\s*)|(\s*$)/g,"");
		          password=password.replace(/(^\s*)|(\s*$)/g,"");
		             if(Value!=password){
		             	if(getinterface()=='YES'){
		             	/*调用接口，如果返回为true则继续执行下列的开户超做，如果返回false则提示遇到异常开户失败*/			 			 			 
							    var jkres=TSDInterface.ZXISAM.changePassword($("#UserName").val(),Value,password);						
								 	jkres = eval("("+jkres+")");
								 	if(jkres.info!="true"&&jkres.info!=true){
								 		alert("接口出现["+jkres.resultInfo.infoStr+"]异常，无法执行密码修改操作过程！");
								 		return false;
								    }
						}		    
		             }
	              setProperty(params);//修改宽带资料
	              $("#Valuess").val("");
	              var urlstr=tsd.buildParams({packgname:'service',//java包
						 					  clsname:'Procedure',//类名
						 					  method:'exequery',//方法名
						 					  ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					  tsdpname:'editproperty.update',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					  tsdExeType:'query',
						 					  datatype:'xmlattr',
									 	      tsdUserId:'true'
						 				});	 				
				   urlstr+=params;
				   //调用存储过程返回工单	 						 				 					
			       $.ajax({
					url:'mainServlet.html?'+urlstr+"&ifurgent="+ifurgent+"&descrpt="+jobmemo+"&devno="+devno+"&sbmtype="+sbmtype,
					datatype:'xml',
				    cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				    timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					$(xml).find('row').each(function(){
						var result = $(this).attr("result");
						 if(result==0){
						    alert("<fmt:message key="gjh.eiterfailure"/>");
						 }else{	
						 		
						  var userid = $("#userid").val();
					      var loginfo = "";
					      loginfo +=tsd.encodeURIComponent("操作员："+userid+";");
					      loginfo += tsd.encodeURIComponent("表:");
					      loginfo += "radcheck";
						  loginfo += tsd.encodeURIComponent("修改帐号为:");
						  loginfo += username;
						  loginfo += tsd.encodeURIComponent("的相关信息");
						  loginfo += ";";
					      //数据更改前					      
			              var Value=$("#Values").val();//用户密码   
						  var mobile=$("#mobile").val();//移动电话
						  var idcard=$("#idcard").val();//证件号码	 
						  var vlanid=$("#vlanid").val();//绑定VLANID
					      var linkman=$("#linkman").val();//联系人
					      var linkphone=$("#linkphone").val();//联系电话
						  var sRealName = $("#sRealName").val();
						  var sAddress = $("#sAddress").val();
						  var iStatus = $("#iStatus").val();
						 
						  var oldjrlx = $("#oldjrlx").val();
						  var oldsDh1 = $("#oldsDh1").val();
						  var sDh1 = $("#sDh1").val();
						  
						  var UserName1 = $("#UserName1").val();
						  var sBm = $("select[id='sBm'] :selected").html();
						  var sBm2 = $("select[id='sBm2'] :selected").html();
					      var sBm3 = $("select[id='sBm3'] :selected").html();
					      var sBm4 = $("select[id='sBm4'] :selected").html();
						  //数据更改后
						  var userZT = $("#userZT").val();
						  var userMC = $("#userMC").val();
						  var userPWD=$("#userPWD").val();//用户密码
						  var usersBm1 = $("#usersBm1").val();
						  var usersBm2 = $("#usersBm2").val();
						  var usersBm3 = $("#usersBm3").val();
						  var usersBm4 = $("#usersBm4").val();
						  var userYDDH = $("#userYDDH").val();
						  var userZJHM = $("#userZJHM").val();
						  var userLXR = $("#userLXR").val();
						  var userLXDH = $("#userLXDH").val();
						  var userDZ = $("#userDZ").val(); 
						  var userBDVLAN = $("#userBDVLAN").val();
						  var userMACDZ = $("#userMACDZ").val();
						  
						  var jrlx = $("#accessmethods").val();
						  
						  if(userZT!=iStatus){loginfo += tsd.encodeURIComponent("用户状态:"+userZT+"～"+iStatus+";");}
					      if(userMC!=sRealName){loginfo += tsd.encodeURIComponent("用户名称:"+userMC+"～"+sRealName+";");}
					      if(userPWD!=Value){loginfo += tsd.encodeURIComponent("上网密码:"+userPWD+"～"+Value+";");}
					      if(usersBm1!=sBm){loginfo += tsd.encodeURIComponent("一级部门:"+usersBm1+"～"+sBm+";");}
					      if(usersBm2!=sBm2){loginfo += tsd.encodeURIComponent("二级部门:"+usersBm2+"～"+sBm2+";");}
					      if(usersBm3!=sBm3){loginfo += tsd.encodeURIComponent("三级部门:"+usersBm3+"～"+sBm3+";");}
					      if(usersBm4!=sBm4){loginfo += tsd.encodeURIComponent("四级部门:"+usersBm4+"～"+sBm4+";");}
					      if(userYDDH!=mobile){loginfo += tsd.encodeURIComponent("移动电话:"+userYDDH+"～"+mobile+";");}
					      if(userZJHM!=idcard){loginfo += tsd.encodeURIComponent("证件号码:"+userZJHM+"～"+idcard+";");}
					      if(userLXR!=linkman){loginfo += tsd.encodeURIComponent("联系人:"+userLXR+"～"+linkman+";");}
					      if(userLXDH!=linkphone){loginfo += tsd.encodeURIComponent("联系电话:"+userLXDH+"～"+linkphone+";");}
					      if(userDZ!=sAddress){loginfo += tsd.encodeURIComponent("用户地址:"+userDZ+"～"+sAddress+";");}
					      if(userBDVLAN!=vlanid){loginfo += tsd.encodeURIComponent("绑定vlan:"+userBDVLAN+"～"+vlanid+";");}
					      if(userMACDZ!=UserName1){loginfo += tsd.encodeURIComponent("MAC地址:"+userMACDZ+"～"+UserName1+";");}					      			      
					      //eidt by chenliang
					      if(jrlx!=oldjrlx){loginfo += tsd.encodeURIComponent("接入类型:"+oldjrlx+"～"+jrlx+";");}					      			      
					      if(sDh1!=oldsDh1){loginfo += tsd.encodeURIComponent("用户类型:"+oldsDh1+"～"+sDh1+";");}					      			      
					      					      
						  writeLogInfo("","modify",loginfo);//把日志插入到mssql日志表里
						  insertmysqllog(result,loginfo);//把日志插入到mysql modifyAttrLog日志表里						  
						 					 	  
				     		  //修改传过来的属性值(包括电话和宽带共有的字段信息所以需要修改电话档案表里和宽带档案表里的共有信息)      						    	
						      //把得到的结果集传入到serlvet里面去
						      $("#jobidid").val(result);						    
						      $("#kdSearchBox").select();
	            			  $("#kdSearchBox").focus();
	            			  $("#jobmemo").attr("disabled","disabled");
	            			  clearText('form1');
						      $("#closesave").attr("disabled","disabled");
						      $("#kdSearchBox").val("");
						      $("#iStatus").empty();
						      $("#ifurgent").empty();
				 	          $("#jobmemo").val("");
				 	          $("#sBm").empty();
				 	          $("#devno").empty();
				 	          $("#memocontent").empty();
				 	          $("#phone_frame").hide();
	            			  //打印报表
						      //autoBlockForm("choosePrintJob","150","close","#FFFFFF",false); 								 								 							
							  zfxfeenameto="";
						    }
						});
					  }
					});
				  }
	           }
	       
	       
	       //修改属性时调用此方法
	       function setProperty(params,result){
	         var devno = $("#devno").val();	        
	         var urlstr=tsd.buildParams({packgname:'service',//java包
						 				 clsname:'ExecuteSql',//类名
						 				 method:'exeSqlData',//方法名
						 				 ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				 tsdcf:'mysql',//指向配置文件名称
						 				 tsdoper:'exe',//操作类型 
						 				 datatype:'xmlattr',
						 				 tsdpk:'radcheck.update',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				 tsdUserID:'ture'
						 				});
				urlstr+=params;		 				
	             //对字段进行修改
					$.ajax({
					url:'mainServlet.html?'+urlstr+'&id='+ids,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
					   if(msg=="true"){
					      var sDh = $("#sDh").val();
					      kdunLock();//解锁帐号
					      alert("<fmt:message key="gjh.eidterseccess"/>");					      					      
					   }else{
					      alert("<fmt:message key="gjh.eiterfailure"/>");
					      $("#kdSearchBox").select();
            			  $("#kdSearchBox").focus();
					   }
					}
				});
	       }
	       
	       /*在把日志存入到mysql表里*/
	       function insertmysqllog(result,loginfo){
	       		
	       		var res = executeNoQuery("EditProperty.insertmysqllog",0,"&jobid="+result+"&loginfo="+loginfo);	       		
	       }
	       
	       //修改电话档案表里的信息（主要为了电话和宽带同步修改）
	       function yhdangupdate(sDh){
	           var params = buildnewParams();
	           var urlstr=tsd.buildParams({ packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'exe',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'yhdang.update',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdUserID:'ture'
						 				});
				urlstr+=params;		 				
	             //对字段进行修改
					$.ajax({
					url:'mainServlet.html?'+urlstr+'&sDh='+sDh,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){					
					      var loginfo = "";
					      loginfo += tsd.encodeURIComponent("表:");
					      loginfo += "yhdang";
						  loginfo += tsd.encodeURIComponent("修改电话为:");
						  loginfo += sDh;
						  loginfo += tsd.encodeURIComponent("的相关信息");
						  loginfo += ";";						  
						  writeLogInfo("","modify",loginfo);
					   }
					});		 				
	       }
	       
	     /*判断电话sDh是否被绑定（也就是是否为空），如果被绑定则判断该电话是否在yhdang表里,不存在这不能修改此字段
		   *再判断该电话在宽带档案表radcheck(mysql数据库)里是否存在再判断该电话在宽带档案表radcheck(mysql数据库)里是否存在
		   *修改时电话和宽带的共有资料在同步修改，修改时调用存储过程radywsl_xgsx (sDhqueryyhdang()方法和 sDhqueryredcheck()方法)*/ 
	     function sDhqueryredcheck(){  
		   var sDh = $("#sDh").val();
		   var sDhyh;
		   if(sDh!=null&&sDh!=""){  
		    //radcheck判断该电话是否存在		  	
			var urlstr1=tsd.buildParams({ packgname:'service',//java包
						 				  clsname:'ExecuteSql',//类名
						 			      method:'exeSqlData',//方法名
						 				  ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				  tsdcf:'mysql',//指向配置文件名称
						 				  tsdoper:'query',//操作类型 
						 				  datatype:'xmlattr',
						 				  tsdpk:'editproperty.querysDhradcheck',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				  tsdUserID:'ture'
						 				});			
			$.ajax({
					url:'mainServlet.html?'+urlstr1+'&sDh='+sDh,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						$(xml).find('row').each(function(){
						  var result = $(this).attr("result");
						 sDhyh=result;
						});
					  }
				  });	  	
		  }
		  return sDhyh;
	 }   
	 function sDhqueryyhdang(){
	    var sDh = $("#sDh").val();
	    var sDhrec;
	    sDh=sDh.replace(/(^\s*)|(\s*$)/g,"");
		  if(sDh==null||sDh==""){	
		  	sDh="''";
		  	//alert("111");
		  }		  
	    //从yhdang表里判断该电话否存在
		  var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'editproperty.querysDhyhdang',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdUserID:'ture'
						 				});				 								
			$.ajax({
					url:'mainServlet.html?'+urlstr+'&sDh='+sDh,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						$(xml).find('row').each(function(){
						 var result = $(this).attr("result");
						  sDhrec=result;
						});
			     	  }
				  });			 
		    return sDhrec;
	    }    
			
		//查询杂费项	
		function queryFeename(){
		var array="";
		var ids="";
		var idsto="";
		var urlstr=tsd.buildParams({packgname:'service',//java包
						 			clsname:'ExecuteSql',//类名
						 			method:'exeSqlData',//方法名
						 			ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 			tsdcf:'mysql',//指向配置文件名称
						 			tsdoper:'query',//操作类型 
						 			datatype:'xmlattr',
						 			tsdpk:'adduser.queryzhafei',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 			tsdUserID:'ture'
						 		  });
		                   $.ajax({
					              url:'mainServlet.html?'+urlstr+'&bname='+tsd.encodeURIComponent('modifyattr'),
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              $("#zafeilist").empty();
					              $(xml).find('row').each(function(){
								  var feename=$(this).attr("feename");
								  if(feename!=undefined){
								  array=feename.split("~");
								  for(i=0;i<array.length;i++){
								      var strs = array[i];
								      var strsto = array[i];
								      if(strs!=""){
								      var checkBox="<div style='width:50%;text-align:left; height:25px; float:left;'><input type='checkbox' onClick='feecheck()' name='checkbox' value='"+strs+"' style='width:15px; height:15px; border:0px;float:left; line-height:'/><span style='line-height:25px; padding-left:5px; float:left;'>"+strs+"</span></div>";
				                      $("#zafeilist").html($("#zafeilist").html()+checkBox);
				                      }
								      if(i==0)
								      {
								      	ids += "'"+tsd.encodeURIComponent(strs)+"'";
								      }
								      else 
								      {
								      	ids += ",'"+tsd.encodeURIComponent(strs)+"'";
								      }			      
								  }
								  //初始化费用项queryAllfeiy(ids);
								  }
							      });
							      }
							});							
		}
		
		//查询宽带费用合计
		function queryAllfeiy(ids){
		if(ids!=undefined){
		    zfxfeename=ids.replace(new RegExp("'","g"),"");
		    zfxfeename=zfxfeename.replace(new RegExp(",","g"),"~");		    
		if(ids==undefined){$("#feei").attr("value","");}
		   var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'userChanages.queryAllzfx',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdUserID:'ture'
						 				});		
						 		$.ajax({
					              url:'mainServlet.html?'+urlstr+'&sltem='+ids,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              $(xml).find('row').each(function(){
								  var ss=$(this).attr("ss");
								     if(ss!="null"){					       
								        $("#feei").val(ss);
								     }else{
								       $("#feei").val("0.0");
								      }
							      });
							     }
							});
				}else{
				$("#feei").attr("value","0.0");
			 }				
		 }
		
		//根据杂费复选框的选择情况来对费用合计进行总计
        function feecheck(){
          var str=document.getElementsByName("checkbox");
          var objarray=str.length;
          var chestr="";
          var chestrto="";
         for (i=0;i<objarray;i++)
          {
              if(str[i].checked == true)
              {
                chestr=str[i].value;               
			    chestrto += "'"+tsd.encodeURIComponent(chestr)+"',";
			    var a =chestrto.substr(0,chestrto.length-1);
		      }
           }
           var ids = a;
           queryAllfeiy(ids);
        }
        
        ///////////////验证前后不可以后空格////////////////
	    function replaceLong(str) 
	    {
	       return  str.replace(/(^\s*)|(\s*$)/g,"");
	    }

		//锁定账号 true可办理 false 不可办理
		function kdLock(UserName)
		{
			var rel = fetchSingleValue("processingdistory.queryuseridname",6,"&userid="+$("#userid").val());
			var res = fetchMultiPValue("kd.Lock",0,"&userid="+$("#userid").val()+"&account="+UserName+"&businesstype=modifyattr&flag=in"+"&realname="+tsd.encodeURIComponent(rel));
			if(res[0]==undefined||res[0][0]==undefined||res[0][0]=="")
			{
			    return true;
			}
			else
			{
				var info = "";
				info += "账号";
				info += UserName;
				info += "正被";
				info += res[0][0];
				info += "受理，请稍等...";
				alert(info);
				return false;
			}
		}
		
		//解锁账号
		function kdunLock()
		{
		  var res = fetchMultiPValue("kd.Lock",0,"&userid="+$("#userid").val()+"&flag=out");
		}
		
		//带宽转换（将数字转换成M数）
	     function speedConversion(params){
	         var speed = (parseInt(params,10)/1024000)+'M';
	         return speed;
	     }
	     
    </script>
		<!-- 从部门库里得到一级，二级，三级，四级部门 -->
		<script language="javascript">
            function getsBm1(){
            //得到部门库中的第一级部门
            var sBM="";
            var urlstr=tsd.buildParams({packgname:'service',//java包
						 				clsname:'ExecuteSql',//类名
						 				method:'exeSqlData',//方法名
						 				ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				tsdcf:'mssql',//指向配置文件名称
						 				tsdoper:'query',//操作类型 
						 				datatype:'xmlattr',
						 				tsdpk:'adduser.addsBm1'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});									
			                $.ajax({
					              url:'mainServlet.html?'+urlstr,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              sBM="";				              
					              $(xml).find('row').each(function(){					              
					              var DeptCode = $(this).attr("deptcode");
					              var DeptName = $(this).attr("deptname");
					                if(DeptName!=undefined){
								      var ee="<option value='"+DeptCode+"'>"+DeptName+"</option>";								  
									  sBM = sBM +ee;
								     }
							      });				      
							      $("#sBm").html("<option value='' selected=true></option>");
							      $("#sBm").html($("#sBm").html()+sBM);
							      }
							});		
        }
        
        							
		//得到部门库第二级部门
        function addsBmer(){
          var sBm = $("#sBm").val();
          getsbmhth(sBm);//根据部门一得到该部门的合同号          
          //为空时SQL语句替换会出错
          if (sBm=="")
          {
        	$("#sBm2").html("<option value='' selected=true></option>");
        	return false;
          }
          $("#sBm3").html("<option value='' selected=true></option>");
          $("#sBm4").html("<option value='' selected=true></option>");
          //alert(sBm);
          var sBM="";
          var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.addsBm2'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&sjbmbh='+sBm,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              sBM="";							      
					                $(xml).find('row').each(function(){
					                   var DeptCode = $(this).attr("deptcode");
					              var DeptName = $(this).attr("deptname");
					                  if(DeptName!=undefined){
							            var ee="<option value='"+DeptCode+"'>"+DeptName+"</option>";
							            sBM = sBM+ee;								        
								      }
								    });
								    $("#sBm2").html("<option value='' selected=true></option>");
								    $("#sBm2").html($("#sBm2").html()+sBM);
							      }
							   });
        }	 
        //得到部门库第三级部门
        function addsBmsan(){
          var sBm2 = $("#sBm2").val();
          //为空时SQL语句替换会出错
          if (sBm2=="")
          {
        	$("#sBm3").html("<option value='' selected=true></option>");
        	return false;
          }        
          $("#sBm4").html("<option value='' selected=true></option>");
          var sBm="";
          var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.addsBm3'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&sjbmbh='+sBm2,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              sBm="";					       
					                $(xml).find('row').each(function(){	
					                   var DeptCode = $(this).attr("deptcode");
					              var DeptName = $(this).attr("deptname");
					                  if(DeptName!=undefined){
							            var ee="<option value='"+DeptCode+"'>"+DeptName+"</option>";
							            sBm=sBm+ee;								        
								      }
							        });
							        $("#sBm3").html("<option value='' selected=true></option>");
							        $("#sBm3").html($("#sBm3").html()+sBm);
							      }
							});
        }	 
         //得到部门库第四级部门
        function addsBmsi(){
          var sBm3 = $("#sBm3").val();
         //为空时SQL语句替换会出错
          if (sBm3=="")
          {
        	$("#sBm4").html("<option value='' selected=true></option>");
        	return false;
          }
          var sBm="";
          var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.addsBm4'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&sjbmbh='+sBm3,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              sBm="";				       
					                $(xml).find('row').each(function(){	
					                   var DeptCode = $(this).attr("deptcode");
					              var DeptName = $(this).attr("deptname");
					                  if(DeptName!=undefined){
							            var ee="<option value='"+DeptCode+"'>"+DeptName+"</option>";
							            sBm=sBm+ee;								       
								      }
							        });
							        $("#sBm4").html("<option value='' selected=true></option>");
							        $("#sBm4").html($("#sBm4").html()+sBm);
							      }
							});
        }		  
        
        //后退事件
        function backwin(){
          history.back();
        }            
    </script>
		<!-- 回车事件 -->
		<script language="javascript">
                function testKey(event){
                    if(event.keyCode==13){
                        document.getElementById("outst").click();
                        return false;
                    }
                }
                function lastKey(event){
                    if(event.keyCode==13){
                        document.getElementById("last").click();
                        return false;
                    }
                }
                function nextKey(event){
                    if(event.keyCode==13){
                        document.getElementById("next").click();
                        return false;
                    }
                }

                $(function(){
                	bindToPage();
                });

                function bindToPage()
                {
                	$("#kdMultiSearchClose").click(function(){
            			setTimeout($.unblockUI,15);
            			$("#kdSearchBox").select();
            			$("#kdSearchBox").focus();
            			$("#kdSearchWay").css("visibility","visible");
            		});
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();

					$("#kdSearchBox").keydown(function(event){if(event.keyCode==13){$("#kdSearchBox").blur();$("#kdSearchByUserName").click();}});
					$(document).keydown(function(event){
						var panelStatus = $("#multiSearch").css("display");
						if(panelStatus == "block")
						{
							//alert(event.keyCode);
							var idx = $("#bu_muser").getGridParam("selrow");
							idx = parseInt(idx,10);
							//alert("A:"+idx);
							//alert(typeof idx);
							var len = $("#bu_muser").getDataIDs().length;
							//alert(typeof len);
							
							if(event.keyCode==40)
							{
								if(idx==null||isNaN(idx))
								{
									$("#bu_muser").setSelection("1");
								}
								else
								{
									$("#bu_muser").setSelection(idx+1);
								}
							}
							else if(event.keyCode==38)
							{
								if(idx==null||isNaN(idx))
								{
									$("#bu_muser").setSelection(len);
								}
								else
								{
									$("#bu_muser").setSelection(idx-1);
								}
							}
							else if(event.keyCode==37)
							{
								$("#bu_pager #prev").click();
							}
							else if(event.keyCode==39)
							{
								$("#bu_pager #next").click();
							}
							else if(event.keyCode==27)
							{
								$("#kdMultiSearchClose").click();
							}
							else if(event.keyCode==13)
							{
								if(idx==null||isNaN(idx)||idx==undefined)
								{
								}
								else
								{
									userChoose($("#bu_muser").getCell(idx,"UserName"),$("#bu_muser").getCell(idx,"sDh"),$("#bu_muser").getCell(idx,"sRealName"));
								}
							}
						}
					});
                }
 
            function userChoose(UserName)
            {
                kdunLock();//解锁帐号
                var par=isnotnewbusi(UserName);      
                 if(par==1){
                    //alert("该用户已经办理了套餐业务["+packagenameto+"],不能在办理修改属性业务！");
                    alert("<fmt:message key="broadband.gyhyjblltcyw"/>["+packagenameto+"],<fmt:message key="broadband.bnzblxgsxyw"/>");
                    return false;
                 }
                 if(kdLock(UserName)==true){
                 	//edit by chenliang --start
			        getAccessmethods();//得到接入方式	
				    //edit by chenliang --end
                    
                    QueryObj("&UserName="+UserName);
					$("#kdSearchBox").val(UserName);
					$("#kdSearchWay").css("visibility","visible");
					setTimeout($.unblockUI,10); 
                 }            				
            }
            
            //判断该用户是否办理了套餐业务，如果办理了就无法办理申请停机
	        var packagenameto="";//套餐业务全局	
	        function isnotnewbusi(UserName){
	        var res = "";
        	var urlstr=tsd.buildParams({ packgname:'service',
									 	 clsname:'Procedure',
										 method:'exequery',
									 	 ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
									 	 tsdpname:'stopkeepnumer.isnotNewBusi',//存储过程的映射名称
									 	 tsdExeType:'query',
									 	 datatype:'xmlattr',
									 	 tsdUserId:'true'
									 	});							
							$.ajax({
								url:'mainServlet.html?'+urlstr+"&busiclass="+'broadband'+"&nubmer="+UserName+"&busitype="+'modifyattr',
								datatype:'xml',
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(xml){
									/////////////////////////////
									////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
									packagenameto="";
									$(xml).find('row').each(function(){
										res = $(this).attr("res");
										var packagename = $(this).attr("packagename");
										packagenameto=packagename;										
									});
								}
							});
				return res;						
			}
            
            var zfxfeenameto="";
            function queryFeeInfo()
            {                
				var param = zfxfeename;
				var feei = $("#feei").val();
				
				//费用为0时依旧保存费用项名称
				//if(feei==0){param=""}	


				if(param==undefined){
				   param="";
				 }	
				$("#reportparam").val(param);
				
				var arr = param.split("~");
				var sqlparam = arr.join("','");
				sqlparam = "'" + sqlparam + "'";

				var res = fetchMultiArrayValue("yiji.queryFee",0,"&itemss="+sqlparam);
				if(res[0]==undefined||res[0][0]==undefined||res[0][0]==""||res[0]=="")
				{
					return "";
				}
				else
				{
					var temp = "";
					for(var j=0;j<res.length;j++)
					{
						temp += ",";
						temp += tsd.encodeURIComponent(res[j][0]);
						temp += tsd.encodeURIComponent("：");
						temp += res[j][1];
						temp += tsd.encodeURIComponent("元");						
					}
					temp = temp.replace(",","");
					zfxfeenameto=temp;
					return temp;
				}			 
            }

        	/////工单打印
        	function jobPrint(flag)
        	{
        		var jobid= $("#jobidid").val();
				var params = "&JobID="+jobid;
        		if(flag=="1")
        		{
        			printWithoutPreview("broadband_jobadduser","JobID_"+jobid);
        		}
        		else if(flag=="2")
        		{
        			printThisReport1('<%=request.getParameter("imenuid")%>',
					'jobadduser',params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);	
        		}
        		else
        		{
            		
        		}        		
        		//setTimeout($.unblockUI,1);
        		if(parseFloat($("#printfeeee").val(),10)!=0)
        		{
        			setTimeout(autoBlockForm("choosePrint","150","close","#FFFFFF",false),15);
        		}
        		else
        		{
        			setTimeout($.unblockUI,1);
        		}       		
        	}

        	function cjkEncode(text) {   
        	    if (text == null) {   
        	        return "";   
        	    }   
        	 var newText = "";   
        	    for (var i = 0; i < text.length; i++) {   
        	        var code = text.charCodeAt (i);    
        	        if (code >= 128 || code == 91 || code == 93) {//91 is "[", 93 is "]".   
        	            newText += "[" + code.toString(16) + "]";   
        	        } else {   
        	            newText += text.charAt(i);   
        	        }   
        	    }   
        	 return newText;   
        	}  
        	
        	/////收费打印
        	function lsPrint(flag)
        	{
        		var param = $("#reportparam").val();
				var arr = param.split("~");
				var sqlparam = arr.join("','");
				var feeinfoooo = "";
				sqlparam = "'" + sqlparam + "'";
				//取费用项目信息
				var res = fetchMultiArrayValue("yiji.queryFee",0,"&itemss="+sqlparam);
				
				if(res[0]==undefined||res[0][0]==undefined)
				{
					for(var k=1;k<=12;k++)
					{
						feeinfoooo += "&fee";
						feeinfoooo += k;
						feeinfoooo += "=";
						feeinfoooo += "";
						feeinfoooo += "&val";
						feeinfoooo += k;
						feeinfoooo += "=";
						feeinfoooo += "";
					}
				}
				else
				{
					var j = 1;
					for(j=1;j<res.length+1;j++)
					{
						feeinfoooo += "&fee";
						feeinfoooo += j;
						feeinfoooo += "=";
						feeinfoooo += cjkEncode(res[j-1][0]);
						feeinfoooo += "&val";
						feeinfoooo += j;
						feeinfoooo += "=";
						feeinfoooo += cjkEncode(res[j-1][1]);
					}
					while(j<=12)
					{
						feeinfoooo += "&fee";
						feeinfoooo += j;
						feeinfoooo += "=";
						feeinfoooo += "";
						feeinfoooo += "&val";
						feeinfoooo += j;
						feeinfoooo += "=";
						feeinfoooo += "";
						j++;
					}
				}
				
        		var params = "&JobID="+$("#jobidid").val() + feeinfoooo;
        		if(flag=="1")
        		{
        			printWithoutPreview("broadband_sf",params);
        		}
        		else
        		{
        			printThisReport1('<%=request.getParameter("imenuid")%>',
					'broadband_sf',params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
        		}
        		setTimeout($.unblockUI,15);
        		
        	}

        	function checkAddress(addr)
        	{        		
				var res = fetchSingleValue("Address.Check",0,"&sAddress="+tsd.encodeURIComponent(addr));
				if(res==undefined||res=='0')
				{
					return false;
				}
				else
				{	
					return true;
				}
        	}

    </script>
		<script language="javascript">
//从配置表里取到用户类型的下拉值 -- edit by chenliang 2010-07-21
function UserTypeSelect(sDh1)
{
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'broadband', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mysql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', tsdpk : 'radusertype.usertype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr, datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 1000, async : false , //同步方式
        success : function (xml)
        {
            ///////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
            var iftt = "<option value=''></option>";
            $(xml).find('row').each(function ()
            {
                //////////给下拉框进行赋值操作、5
                var TypeID = $(this).attr("typeid");
                var UserType = $(this).attr("usertype");
                if(undefined!=TypeID){
                	//修改用户类型时，公私用户之间不能进行互转
	                var flag = false;
	                if (sDh1 == 1) {
	                    if (TypeID == 2) {
	                        flag = true;
	                    }
	                }
	                else if (sDh1 == 2) {
	                    if (TypeID == 1) {
	                        flag = true;
	                    }
	                }
	                //var ee = "<option value='" + TypeID + "'>" + UserType + "</option>";
	                if (flag == false) {
	                    iftt += "<option value='" + TypeID + "'>" + UserType + "</option>";
	                }
                }
            });
            //$("#sDh1").html("<option value=''></option>");
            $("#sDh1").html(iftt);
        }
    });
}			
				
			  //查看用户是否处于停机状态
	          function quereyshiftj(){
	           var result;
	           var UserName = $("#UserName").val();           
	              var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'UserChanager.shifoubanli'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});						
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&UserName='+UserName,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              $(xml).find('row').each(function(){	
								  result=$(this).attr("result");								    
							      });
							      }
							});
					return result;		
	           }
	     	     
	     function addnewinfo(){
			var groupid = $('#zid').val();
			//window.showModalDialog('mainServlet.html?pagename=line/addressManage.jsp&imenuid=1085&pmenuname=号线管理 &imenuname=地址库管理 &groupid='+groupid,window,"dialogWidth:820px; dialogHeight:650px; center:yes; scroll:yes");
			var ret = window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/addressManage.jsp&imenuid=1085&pmenuname=号线管理&imenuname=地址库管理&yemiantype=addusertype&groupid='+groupid+"56755",null,"dialogWidth:820px;dialogHeight:650px;help:no;status:no");							
				if(ret!=undefined){
				   $("#sAddress").val(ret);
				   $("#c_p_address").hide('slow');
				   //恢复显示
				   $("#UserName1").css("display","block");
			}
	     }   
        
        //选择用户所在区域        
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
					                  var xuhao = $(this).attr("xuhao");
					                  var ywarea = $(this).attr("ywarea");
					                  if(ywarea!=undefined){
							            var ee="<option value='"+xuhao+"'>"+ywarea+"</option>";
							            uareato=uareato+ee;								       
								      }
							        });								        				       						        				       						        
							        $("#c_p_address_seluserarea").html($("#c_p_address_seluserarea").html()+uareato);					       
							      }
							});
        }
        
     /////地址选择
	 function c_p_address()
	 {
		var ctrr = $("#sAddress");
		$(ctrr).focus(function(){c_p_address_fun();});		
	 }
	
	 /////地址选择
	 function c_p_address_fun()
	 {
		if($("#c_p_address").size()<1)
		{
			$("#sAddress").after("<div id=\"c_p_address\"></div>");
		}
		var left = $("#sAddress").offset().left-90;
		var top = $("#sAddress").offset().top + 25;
		//alert($("#sAddress").parent().offset().left);
		$("#c_p_address").css({'position':'absolute','left':left,'top':top,'background-color':'#FFFFFF','border':'#99ccff 1px solid','height':'112px','width':'900px'});
		$("#c_p_address").empty();		
		var address_tab="<table id=\"address_tab\" style=\"\">";
		address_tab += "<tr><td colspan=\"6\"><h4>添加地址</h4></td></tr>";
		address_tab += "<tr><td align=\"right\">区域</td><td><select id=\"c_p_address_seluserarea\"></select></td><td>小区号</td><td><select id=\"c_p_address_xq\"><option value=\"\">--请选择--</option></select></td><td>楼栋号</td><td><select id=\"c_p_address_ld\"><option value=\"\">--请选择--</option></select></td><td>单元号</td><td><select id=\"c_p_address_dy\"><option value=\"\">--请选择--</option></select></td><td>门牌号</td><td><select id=\"c_p_address_mp\"><option value=\"\">--请选择--</option></select></td></tr>";
		address_tab += "<tr><td><button id=\"c_p_address_bnok\" class=\"tsdbutton\">确定</button></td><td colspan='2'><button id=\"c_p_address_add\" onclick=\"addnewinfo()\" class=\"tsdbutton\">添加新地址</button></td><td><button id=\"c_p_address_bncancel\" class=\"tsdbutton\">取消</button></td><td></td><td></td><td></td><td></td></tr>";
		address_tab += "</table>";
		$("#c_p_address").append(address_tab);
		getuserareato();
		$("#c_p_address_seluserarea").val($("#userareaid").val());
		var addr = $("select[id='c_p_address_seluserarea'] :selected").html();
		c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));							
		var cpad = $("#c_p_address_addright").val();
		if(cpad=="true"){
		  $("#c_p_address_add").removeAttr("disabled");		  		  	  
		}
		$("select[id^='c_p_address_']").css("width","100px");		
		//c_p_bindToAddr(1,"c_p_address_xq","");
		//var sua = $("select[id='c_p_address_seluserarea'] :selected").html();
		//c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(sua));
		//隐藏证件类型下拉框
		$("#UserName1").css("display","none");
		//获得焦点时显示
		$("#c_p_address").show('slow');
		$(document).one("click",function(event){
			//$("#c_p_address").hide('slow');
			//event.stopPropagation();
		});

		$("#c_p_address_seluserarea").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("select[id='c_p_address_seluserarea'] :selected").html();
			if(addr!="")
			{
				c_p_bindToAddr(1,"c_p_address_xq","&addrarea=" + tsd.encodeURIComponent(addr));
			}
		});
			    
		$("#c_p_address_xq").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("#c_p_address_xq").val();
			if(addr!="")
			{
				c_p_bindToAddr(2,"c_p_address_ld","&addr=" + $("#c_p_address_xq").val());
			}
		});
		
		$("#c_p_address_ld").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("#c_p_address_ld").val();
			if(addr!="")
			{
				c_p_bindToAddr(3,"c_p_address_dy","&addr=" + $("#c_p_address_ld").val());
			}
		});
		
		$("#c_p_address_dy").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("#c_p_address_dy").val();
			if(addr!="")
			{
			 c_p_bindToAddr(4,"c_p_address_mp","&addr=" + addr);
			}
		});
		
		$("#c_p_address_bnok").click(function(){
			
			var info = "";
			var errinfo = "";
			
			var elems = ['xq','ld','dy','mp'];
			var infoo = ['小区号','楼栋号','单元号','门牌号'];
			
			for(var j=0;j<4;j++)
			{
				if($("#c_p_address_"+elems[j]).val() != "")
				{
					info += $("select[id='c_p_address_"+elems[j]+"'] :selected").html();
					info += ",";
				}else if(resto!=undefined){
				    errinfo += infoo[j];
					errinfo += ",";
				}	
			}
			if(errinfo.length!=0)
			{
				alert("请继续选择下一级地址","操作提示");
			}
			else
			{
				info = info.replace(new RegExp(",","g"),"");
				if(checkAddress(info))
				{
					alert("地址 " + info + " 已经被用户"+addressusername+"占用，不能重复添加");
					return false;
				}
				$("#sAddress").val(info);
				$("#c_p_address").hide('slow');
				//恢复显示
				$("#UserName1").css("display","block");
			}
			//alert($("select[id^='c_p_address']").size());
		});
		
		$("#c_p_address_bncancel").click(function(){
			$("#c_p_address").hide('slow');
			//恢复显示
			$("#UserName1").css("display","block");
		});
	}
	
	var resto="";
	function c_p_bindToAddr(idx,selid,param)
	{		     
		var res = fetchMultiArrayValue("AddressBox.query"+idx,6,param);
		var elems = ['xq','ld','dy','mp'];
		//alert(res[0] == undefined + ":" + res[0][0] == undefined);
		resto=res[0][0];
		if(res[0] == undefined || res[0][0] == undefined || res[0] == "")
		{
			for(var j=idx;j<=4;j++)
			{
				$("#c_p_address_"+elems[j-1]).empty();
				$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--请选择--</option>");
			}
			
			return false;
		}
		$("#"+selid).empty();
		$("#"+selid).append("<option value=\"\">--请选择--</option>");
		var quanju="";
		for(var i=0;i<res.length;i++)
		{
		    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
		    quanju+=ee					
		}
		 $("#"+selid).html($("#"+selid).html()+quanju);
		//重置索引  > idx + 1 的下拉框
		for(var j=idx + 1;j<=4;j++)
		{
			$("#c_p_address_"+elems[j-1]).empty();
			$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--请选择--</option>");
		}
	  }
	  var addressusername="";
	  function checkAddress(addr)
      {        	    
        	    var addrto = $("#c_p_address_mp").val();
        	    var userareaadress = $("#userareaid").val();
        	    if(addrto!=null&&addrto!=""){
				var res = fetchSingleValue("Address.Check",0,"&sAddress="+tsd.encodeURIComponent(addr)+"&userarea="+tsd.encodeURIComponent(userareaadress));
					 if(res==undefined||res=='0')
					{
						return false;
					}
					else
					{
						addressusername=res;
						return true;
					}
				}				
       } 
        
        function quxiao(){
          $("#iStatus").empty();
          clearText('form1');
          $("#ifurgent").empty();
		  $("#jobmemo").val("");
          kdunLock();//解锁帐号
          $("#sspeed").val("");
          $("#memocontent").empty();
          $("#phone_frame").hide();
        }
        
        //查询方式改变后将清空原来的 
        function closequery(){
              $("#kdSearchBox").val("");
              $("#kdSearchBox").select();
              $("#kdSearchBox").focus();
         }
         
         //取出是否紧急状态             
         function isnotifurgent(){
                 var isf;
                 var ifurgent = 'ifurgent';
                 var urlstr=tsd.buildParams({packgname:'service',//java包
						 					 clsname:'ExecuteSql',//类名
						 					 method:'exeSqlData',//方法名
						 					 ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					 tsdcf:'mysql',//指向配置文件名称
						 					 tsdoper:'query',//操作类型 
						 					 datatype:'xmlattr',
						 					 tsdpk:'adduser.tblconfitifurgent'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});				 							
				 $.ajax({
						url:'mainServlet.html?'+urlstr+'&ssection='+ifurgent,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
						            isf="";
						            $("#ifurgent").empty();
									///////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
									$(xml).find('row').each(function(){
									//////////给下拉框进行赋值操作、5
									var sitem = $(this).attr("sitem");
									var svalue = $(this).attr("svalue");
									var ee="<option value='"+sitem+"'>"+svalue+"</option>";
								    isf = isf+ee																
								});
							    $("#ifurgent").html($("#ifurgent").html()+isf);
							}
					 });                 
             } 
          
            var TextUtil = new Object(); 
            TextUtil.NotMax = function(oTextArea){ 
                var maxText = oTextArea.getAttribute("maxlength"); 
                if(oTextArea.value.length > maxText){ 
                        oTextArea.value = oTextArea.value.substring(0,maxText); 
                        alert("<fmt:message key="broadband.ccxz"/>"); 
                } 
            }
           
        //根据部门一得到合同号       
        function getsbmhth(sbm){
           if(sbm=="")
           {
           sbm=null;
           }
           var res = fetchMultiArrayValue("adduser.getsbmhth",6,"&sbm="+tsd.encodeURIComponent(sbm));
		   if(res==""){            
             $("#hth").val("");             
             $("#sBm3").empty();
	         $("#sBm4").empty();
	       }else{
	         var hth = res[0][0];
	         $("#hth").val(hth);
	         $("#sBm3").empty();
	         $("#sBm4").empty();
	       }  
        }  
        
         //得到BAS设备数据
           function getBASsb(){
             $("#devno").empty();
             var res = fetchMultiArrayValue("adduser.queryBASsb",0,"");
             var queryBASsel="";
               if(res[0][0]!=undefined){
				   for(var i=0;i<res.length;i++)
				   {
				    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
				    queryBASsel+=ee					
				   }
				   $("#devno").append("<option value=\"\">--<fmt:message key="global.select" />--</option>");
			       $("#devno").html($("#devno").html()+queryBASsel);
			   }			   
           }
           
           $(function(){
           		$("#phone_frame").hide();
                $("#shuangjishow").click(shuangjishow);	
                $("#memoStatus").text("[打开]");		
           });
           //显示历史备注信息
           function shuangjishow(){
    				//取到当前checkbox是否选中
    				var checkboxStatus=$("input[name='getcheck']").attr("checked");
    				if(checkboxStatus==true)
    				{
    					$("#getcheck").attr("checked","");
    					$("#phone_frame").slideUp("slow");
    					$("#memoStatus").text("[打开]");       					 					    			
    				}
    				else
    				{   
    					$("#getcheck").attr("checked","checked");
    					$("#phone_frame").slideDown("hide");    					
    					$("#memoStatus").text("[关闭]"); 
    				}    				    		      					
			}						
			
			//得到历史备注信息
			function getmemocontent(UserName){
				$("#memocontent").empty();
				var res = fetchMultiArrayValue("EditProperty.getHistoryNotes",0,"&UserName="+UserName);
				var Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
				if(res==""||res=="null"||res==undefined||res==null){
					var ify='';
					ify +="<tbody>";
					ify+="<tr>";
					ify+="<td colspan=4>";
					ify+="该用户没有历史备注信息！！！";
					ify+="</td>";
					ify+="</tr>";
					ify +="</tbody>";
				}else{
				var ify='';
					for(var i=0;i<res.length;i++){
						var strtype = getywsl(res[i][2]);
						var sltime = res[i][0].substring(0,19);		
						ify +="<tbody>";
						ify+="<tr>";
						ify+="<td width=\"150\">";
						ify+=sltime;
						ify+="</td>";
						ify+="<td width=\"100\">";
						ify+=Clerks[res[i][1]];
						ify+="</td>";
						ify+="<td width=\"150\">";
						ify+=strtype;
						ify+="</td>";
						ify+="<td width=\"300\">";
						ify+=res[i][3];
						ify+="</td>";
						ify+="</tr>";
						ify +="</tbody>";
					}
				}
				$("#memocontent").append(ify);					
			}
		//根据业务类型关键字得到业务类型
		function getywsl(bname){
			var res = fetchMultiArrayValue("config.queryById",0,"&bname="+bname);
			if(res==""||res=="null"||res==undefined||res==null){
				return '未知的业务类型'
			}else{
			return res[0][0];
			}
		}	
		
		          		
      </script>
		<script language="javascript">
		///////////////////////////////////////////////////////////////////////////////
		// 功能：这个类使得被附加的表格可以支持行点击高亮
		// 参数：
		// tbl:                要附加样式的 table.
		// selectedRowIndex:    初始高亮的行的索引(从 0 开始). 此参数可省。
		// hilightColor:        高亮颜色。可省（默认为绿色）
		///////////////////////////////////////////////////////////////////////////////
		function TableRowHilighter(tbl, selectedRowIndex, hilightColor) {
		    this.currentRow = null;
		    this.hilightColor = hilightColor ? hilightColor : 'green';
		
		    if (selectedRowIndex != null 
		        && selectedRowIndex >= 0 
		        && selectedRowIndex < tbl.rows.length) 
		    {
		        this.currentRow = tbl.rows[selectedRowIndex];        
		        tbl.rows[selectedRowIndex].runtimeStyle.backgroundColor = this.hilightColor;
		    }
		
		    var _this = this;
		    tbl.attachEvent("onmouseover", table_onclick);   
		
		    function table_onclick(){
		        var e = event.srcElement;
		        if (e.tagName == 'TD')
		            e = e.parentElement;           
		        if (e.tagName != 'TR') return;
		        if (e == _this.currentRow) return;
		        if (_this.currentRow)
		            _this.currentRow.runtimeStyle.backgroundColor = '';		            
		        e.runtimeStyle.backgroundColor = _this.hilightColor;
		        _this.currentRow = e;
		    }
		}
		
		//得到宽带接入方式
		function getAccessmethods(){
		   var sSection = '接入方式';
		   $("#accessmethods").empty();
		   var res = fetchMultiArrayValue("adduser.getAccessmethods",0,"&sSection="+tsd.encodeURIComponent(sSection));
		   var getaccess="";		   
               if(res[0][0]!=undefined){              
				   for(var i=0;i<res.length;i++)
				   {
				    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
				    getaccess+=ee
				   }
				   $("#accessmethods").append("<option value=\"\">--请选择--</option>");
			       $("#accessmethods").html($("#accessmethods").html()+getaccess);			       
			   }
		}
       </script>
       <style type="text/css">
       	hr {border:1px #A9C8D9 dotted;}
       </style>
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
									key="gjh.houtuei" />
							</a>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="broadband_frame" >
			<div id="input-Unit" style="margin-bottom: 0px">
				<div id="inputtext">
					<table id="kdBar" style="margin-left: 10px;">
						<tr>
							<td>
								<fmt:message key="broadband.querytype" />
								<!-- 查询方式 -->
								<select id="kdSearchWay" onchange="closequery()">
									<option value="0">
										<fmt:message key="broadband.account" />
										<!-- 账号 -->
									</option>
									<option value="1">
										<fmt:message key="broadband.phone" />
										<!-- 电话 -->
									</option>
									<option value="2">
										<fmt:message key="broadband.username" />
										<!-- 用户名 -->
									</option>
								</select>
							</td>
							<td>
								<input type="text" class="" id="kdSearchBox" name="kdSearchBox" />
							</td>
							<td>
								<button class="tsdbutton" style="margin-bottom: 10px" id="kdSearchByUserName"
									onclick="kdSearch()">
									<fmt:message key="Revenue.bSearch" />
									<!-- 查找 -->
								</button>
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<form action="#" onsubmit="return false;" name="form1" id="form1"
				method="post">
				<div id="input-Unit" style="margin-bottom: 0px">
					<div id="inputtext">
						<div class="title">
							&nbsp;&nbsp;
							<img src="style/icon/45.gif" />
							<fmt:message key="BillingBG.UserState" />
						</div>
						<div id="inputtext">
							<table cellspacing="10px">
								<tr>
									<td>
										<span id="spanRemainFee"></span>
										<!-- 上月余额 -->
										<!-- 余额 -->
									</td>
									<td>
										<input type="text" name="RemainFee" id="RemainFee"
											disabled="disabled" style="width: 130px"></input>
									</td>
									<td>
										<span id="spanFee5"></span>
										<!-- 当月费用 -->
										<!-- 当前费用 -->
									</td>
									<td>
										<input type="text" name="Fee5" id="Fee5" disabled="disabled"
											style="width: 130px" />
									</td>
									<td>
										<span id="spaniStatus"></span>
										<!-- 用户状态 -->
									</td>
									<td>
										<select name="iStatus" id="iStatus" style="width: 130px"
											disabled="disabled">
											<option value=""></option>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan=6>
										<table cellspacing="5px" id="TJzt">
											<tr>
												<td>
													复机时间
												</td>
												<td>
													<input type="text" name="pausestoptime" id="pausestoptime"
														style="width: 130px" disabled="disabled" />
												</td>
												<td>
													复机月份
												</td>
												<td>
													<input type="text" name="FJMonth" id="FJMonth"
														style="width: 130px" disabled="disabled" />
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
						<div class="title">
							&nbsp;&nbsp;
							<img src="style/icon/45.gif" />
							<fmt:message key="BillingBG.JBInformation" />
						</div>
						<div id="inputtext">
							<table cellspacing="10px">
								<tr>
									<td>
										<span id="spanUserName"></span>
										<!-- 用户帐号 -->
									</td>
									<td>
										<input type="text" name="UserName" id="UserName"
											disabled="disabled" style="width: 130px" />
									</td>
									<td>
										<span id="spansDh"></span>
									</td>
									<td>
										<input type="text" name="sDh" id="sDh" disabled="disabled"
											style="width: 130px" />
									</td>
									<td>
										<span id="spansRealName"></span>
										<!-- 用户姓名 -->
									</td>
									<td>
										<input type="text" name="sRealName" id="sRealName"
											disabled="disabled" style="width: 130px"
											onkeyup="this.value=replaceLong(this.value)" />
									</td>
								</tr>
								<tr>
									<td>
										<span id="spanValue"></span>
										<!-- 用户密码 -->
									</td>
									<td>
										<input type="text" name="Values" id="Values"
											style="width: 130px" />
									</td>
									<td>
										<span id="spansBm"></span>
										<!-- 所在部门1 -->
									</td>
									<td>
										<select name="sBm" id="sBm" style="width: 130px"
											disabled="disabled" onchange="addsBmer()">
										</select>
									</td>
									<td>
										<span id="spansBm2"></span>
										<!-- 所在部门2 -->
									</td>
									<td>
										<select name="sBm2" id="sBm2" onchange="addsBmsan()"
											style="width: 130px" disabled="disabled">
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<span id="spansBm3"></span>
										<!-- 所在部门3 -->
									</td>
									<td>
										<select name="sBm3" id="sBm3" onchange="addsBmsi()"
											style="width: 130px" disabled="disabled">
										</select>
									</td>
									<td>
										<span id="spansBm4"></span>
										<!-- 所在部门4 -->
									</td>
									<td>
										<select name="sBm4" id="sBm4" style="width: 130px"
											disabled="disabled">
										</select>
									</td>
									<td>
										<span id="spaniFeeType"></span>
										<!-- 计费规则 -->
									</td>
									<td>
										<select name="iFeeType" id="iFeeType" onchange="setspeed()"
											style="width: 130px" disabled="disabled">
											<option value="100">
											</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<span id="spanmobile"></span>
										<!-- 移动电话 -->
									</td>
									<td>
										<input type="text" name="mobile" id="mobile"
											disabled="disabled" style="width: 130px"
											style="ime-mode: Disabled"
											onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57"
											maxlength="11"
											onpaste="return   !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false" />
									</td>
									<td>
										<span id="spanidtype"></span>
										<!-- 证件类型 -->
									</td>
									<td>
										<select name="idtype" id="idtype" disabled="disabled"
											style="width: 130px">
											<option value="100">
											</option>
											<option value="7">
												<!--身份证 -->
												<fmt:message key="AddUser.ID" />
											</option>
											<option value="1">
												<!-- 教职工 -->
												<fmt:message key="AddUser.Faculty" />
											</option>
											<option value="2">
												<!--本科生 -->
												<fmt:message key="AddUser.Undergraduate" />
											</option>
											<option value="3">
												<!--研究生 -->
												<fmt:message key="AddUser.Graduate" />
											</option>
											<option value="4">
												<!--离退休 -->
												<fmt:message key="AddUser.Retired" />
											</option>
											<option value="5">
												<!--护照 -->
												<fmt:message key="AddUser.Passport" />
											</option>
											<option value="6">
												<!--军官证 -->
												<fmt:message key="AddUser.MilitaryID" />
											</option>
											<option value="8">
												<!--其它 -->
												<fmt:message key="AddUser.other" />
											</option>
										</select>
									</td>
									<td>
										<span id="spanidcard"></span>
										<!-- 证件号码 -->
									</td>
									<td>
										<input type="text" name="idcard" id="idcard"
											disabled="disabled" style="width: 130px"
											style="ime-mode: Disabled"
											onkeypress="var k=event.keyCode; return k>=48&&k<=57"
											maxlength="20"
											onpaste="return   !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false" />
									</td>
								</tr>
								<tr>
									<td>
										<span id="spanlinkman"></span>
										<!-- 联系人 -->
									</td>
									<td>
										<input type="text" name="linkman" id="linkman"
											disabled="disabled" style="width: 130px" />
									</td>
									<td>
										<span id="spanlinkphone"></span>
										<!-- 联系电话 -->
									</td>
									<td>
										<input type="text" name="linkphone" id="linkphone"
											disabled="disabled" style="width: 130px"
											style="ime-mode: Disabled"
											onkeypress="var k=event.keyCode; return k>=48&&k<=57"
											maxlength="11"
											onpaste="return   !clipboardData.getData('text').match(/\D/)"
											ondragenter="return   false" />
									</td>
									<td>
										<span id="spansDh1"></span>
										<!-- 用户类型 -->
									</td>
									<td>
										<select name="sDh1" id="sDh1" disabled="disabled"
											style="width: 130px">
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<span id="spansRegDate"></span>
									</td>
									<td>
										<input type="text" name="sRegDate" id="sRegDate"
											class="required date"
											onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
											disabled="disabled" style="width: 130px" />
									</td>
									<td>
										完工日期
									</td>
									<td>
										<input type="text" name="feeendtime" id="feeendtime"
											disabled="disabled" style="width: 130px"
											class="required date"
											onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" />
									</td>
									<td>
										计费时间
									</td>
									<td>
										<input type="text" name="iFeeTypeTime" id="iFeeTypeTime"
											class="required date"
											onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
											disabled="disabled" style="width: 130px" />
									</td>
								</tr>
								<tr>
									<td>
										<span id="spanhth"></span>
										<!-- 合同号 -->
									</td>
									<td>
										<input type="text" name="hth" id="hth" disabled="disabled"
											style="width: 130px" />
									</td>
									<td>
										设备类型
									</td>
									<td>
										<select name="devno" id="devno" disabled="disabled"
											style="width: 130px">
									</td>
								</tr>
								<tr>
									<td>
										<span id="spansAddress"></span>
										<!--用户地址-->
									</td>
									<td colspan=3>
										<input type="text" name="sAddress" id="sAddress"
											disabled="disabled" style="width: 230px"/>
									</td>
								</tr>
							</table>
						</div>
					</div>
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/45.gif" />
						<fmt:message key="BillingBG.Credentials" />
					</div>
					<div id="inputtext" style="margin-bottom: 0px">
						<table border="0" cellpadding="0px" cellspacing="10px">
							<tr>
								<td>
									<span id="spanAcctStartTime"></span>
								</td>
								<td>
									<input type="text" name="AcctStartTime" id="AcctStartTime"
										class="required date"
										onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
										disabled="disabled" style="width: 130px" />
								</td>
								<td>
									<span id="spanspeed"></span>
								</td>
								<td>
									<input type="text" name="speed" id="speed" disabled="disabled"
										style="width: 130px;margin-left: 20px" />
								</td>
								<td>
									接入类型
								</td>
								<td>
									<select name="accessmethods" id="accessmethods"
										style="width: 130px;margin-left: 20px" disabled="disabled">
									</select>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td>
									<span id="spanAcctStopTime"></span>
								</td>
								<td>
									<input type="text" name="AcctStopTime" id="AcctStopTime"
										class="required date"
										onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
										disabled="disabled" style="width: 130px" />
								</td>
								<td>
									<span id="spaniSimultaneous"></span>
								</td>
								<td>
									<input type="text" name="iSimultaneous" id="iSimultaneous"
										onkeyup="value=value.replace(/[^\d]/g,'')" disabled="disabled"
										style="width: 130px;margin-left: 20px" />
								</td>
							</tr>
						</table>
						<!-- <input type=text name=speed value ="" onblur="if (!(/^[\d]+\.?\d*$/.test(this.value)) ){jAlert('输入带宽非法!','消息提示框');this.value=''}"/>  -->
					</div>
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/45.gif" />
						<fmt:message key="BillingBG.BindingInformation" />
					</div>
					<div id="inputtext" style="margin-left: 0px">
						<p>
							<label for="ipaddr" style="width: 60px;text-align: left">
								<span id="spanidaddr"></span>
							</label>
							<input type="text" name="ipaddr" id="ipaddr" disabled="disabled"
								style="width: 130px;margin-left: 18px" />
							<label for="vlanid" style="width: 60px;text-align: left">
								<span id="spanvlanid"></span>
								<!-- 绑定vlanid -->
							</label>
							<input type="text" name="vlanid" id="vlanid" disabled="disabled"
								style="width: 130px;margin-left: 18px" />
							<label for="UserName1" style="width: 60px;text-align: left">
								<span id="spanUserName1"></span>
								<!-- MAC地址 -->
							</label>
							<input type="text" name="UserName1" id="UserName1"
								style="width: 150px;margin-left: 18px" disabled="disabled" />
						</p>
					</div>
					<div class="title" style="display: none">
						&nbsp;&nbsp;
						<img src="style/icon/45.gif" />
						<fmt:message key="gjh.Rates" />
						<!-- 费率 -->
					</div>
					<br />
					<br />
					<div id="inputtext">
						<table border="0px" cellpadding="0px" cellspacing="2px"
							style="display: none">
							<tr>
								<td width="10%">
									<fmt:message key="phoneyewu.yicixingfee" />
									<!-- 一次性费用 -->
									：
								</td>
								<td width="80%">
									<div
										style="width: 100%; height: 150px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
										<div id="zafeilist" style="width: 100%; float: left;"
											disabled="disabled">
										</div>
									</div>
								</td>
							</tr>
						</table>
					</div>
					
					<hr/>
					
					<a href="javascript:void(0)" id="shuangjishow"><input
							name="getcheck" type="checkbox" id="getcheck"
							style="margin-top: 10px; display: none;" />查看历史备注信息<span
						id="memoStatus"></span>
					</a>
					<div id="phone_frame">
						<div id="page">
							<table border="5" cellpadding="0" bordercolor="#d0d0d0"
								style="width: 750px">
								<tr>
									<td width="150">
										受理时间
									</td>
									<td width="100">
										受理工号
									</td>
									<td width="150">
										业务类型
									</td>
									<td width="300">
										备注信息
									</td>
								</tr>
							</table>
							<div
								style="width: 750px; height: 200px; overflow-y: scroll; overflow-x: hidden; border-top: 0px solid gray; border-left: 0px solid gray;">
								<table id="memocontent" border="5" cellpadding="0"
									bordercolor="#d0d0d0" style="width: 750px"></table>
							</div>
						</div>
					</div>
					<table cellspacing="2px">
						<tr>
							<td>
								<fmt:message key="broadband.isurgent" />
								<!-- 是否紧急 -->
							</td>
							<td>
								<select name="ifurgent" id="ifurgent" style="width: 100px">
								</select>
							</td>
							<td>
								<fmt:message key="phoneyewu.memo" />
								<!-- 备注 -->
							</td>
							<td>
								<textarea id="jobmemo" name="jobmemo" rows="4" cols="80"
									onpropertychange="TextUtil.NotMax(this)" maxlength="60"
									disabled="disabled"></textarea>
							</td>
						</tr>
					</table>
					<div>
						<table cellpadding="5px" cellspacing="5px" style="display: none">
							<tr>
								<td align="right">
									<fmt:message key="gjh.TotalFees" />
									<!-- 杂费合计 -->
									：
								</td>
								<td>
									<input type="text" name="id" id="feei" value="0" readonly />
								</td>
							</tr>
						</table>
					</div>
					<!-- 缺省值,没有也必须传到后台-->
					<div style="display: none">
						<input type="hidden" name="PauseStartTime" id="PauseStartTime"
							value="1990-01-01 00:00:00" />
						;
						<input type="hidden" name="PauseStopTime" id="PauseStopTime"
							value="1990-01-01 00:00:00" />
						;
						<input type="hidden" name="AcctStartMonth" id="AcctStartMonth"
							value="0" />
						;
						<input type="hidden" name="AcctEndMonth" id="AcctEndMonth"
							value="0" />
						;
						<input type="hidden" name="PauseStartMonth" id="PauseStartMonth"
							value="0" />
						;
						<input type="hidden" name="PauseEndMonth" id="PauseEndMonth"
							value="0" />
						;
						<!-- <input type="hidden" name="UserID" id="UserID" value="0"/>; -->
						<input type="hidden" name="iFeeStopType" id="iFeeStopType"
							value="-1" />
						;
						<input type="hidden" name="iAutoSessiontimeout"
							id="iAutoSessiontimeout" value="0" />
						;
						<input type="hidden" name="RemainTime" id="RemainTime" value="0" />
						;
						<input type="hidden" name="thismonthtime" id="thismonthtime"
							value="0" />
						;
						<input type="hidden" name="nextmonthtime" id="nextmonthtime"
							value="0" />
						;
						<input type="hidden" name="totaltime" id="totaltime" value="0" />
						;
						<input type="hidden" name="feeendtime" id="feeendtime"
							value="1990-01-01 00:00:00" />
						;
						<input type="hidden" name="iFeeTypeTime" id="iFeeTypeTime"
							value="1990-01-01 00:00:00" />
						;
						<input type="hidden" name="iFeeType1" id="iFeeType1" value="-1" />
						;
						<input type="hidden" name="Fee5" id="Fee5" value="0.00" />
						;
						<input type="hidden" name="id" id="id" />
						;
						<input type="hidden" name="iFeeTypeS" id="iFeeTypeS" />
						;
						<input type="hidden" name="UserName" id="UserName" value="" />
						;
						<input type="hidden" name="iFeeStopType" id="iFeeStopType"
							value="-1" />
						;
					</div>
					<div id="buttons">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button id="closesave" onclick="userUpdate()" disabled="disabled">
							<!-- 确定 -->
							<fmt:message key="Revenue.Save" />
						</button>
						<button id="closequxiao" onclick="quxiao()">
							<!-- 取消 -->
							<fmt:message key="Revenue.Cancel" />
						</button>
					</div>
				</div>
				<input type="hidden" id="userZT" />
				<input type="hidden" id="userMC" />
				<input type="hidden" id="userPWD" />
				<input type="hidden" id="usersBm1" />
				<input type="hidden" id="usersBm2" />
				<input type="hidden" id="usersBm3" />
				<input type="hidden" id="usersBm4" />
				<input type="hidden" id="userYDDH" />
				<input type="hidden" id="userZJHM" />
				<input type="hidden" id="userLXR" />
				<input type="hidden" id="userLXDH" />
				<input type="hidden" id="userDZ" />
				<input type="hidden" id="userBDVLAN" />
				<input type="hidden" id="userMACDZ" />
			</form>
			<!-- 查询用户名的相关信息，在根据此信息来查询资费所有信息 -->
			<div>
				<form action="#" id="operform" method="post" style="display: none">
					<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
					<div id="pagered" class="scroll" style="text-align: left;"></div>
				</form>
			</div>
			<!-- 不动的部分 -->
			<div style="display: none">
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
				<input type="hidden" id="management"
					value="<fmt:message key="ip.management"/>" />
				<input type="hidden" id="worninfo"
					value="<fmt:message key="ip.worn"/>" />
				<input type="hidden" id="worntips"
					value="<fmt:message key="ip.worntips"/>" />
				<input type="hidden" id="deletepower"
					value="<fmt:message key="global.deleteright"/>" />
				<input type="hidden" id="editpower"
					value="<fmt:message key="global.editright"/>" />

				<input type="hidden" id="deletefailed"
					value="<fmt:message key="ip.deletefailed"/>" />
				<input type="hidden" id="selectarea"
					value="<fmt:message key="ip.select"/>" />
				<input type="hidden" id="inputip"
					value="<fmt:message key="ip.inputip"/>" />
				<input type="hidden" id="selectarea"
					value="<fmt:message key="ip.selectarea"/>" />
				<input type="hidden" id="addmemo"
					value="<fmt:message key="ip.addmemo"/>" />

				<input type="hidden" id="addright" />
				<input type="hidden" id="addBright" />
				<input type="hidden" id="deleteright" />
				<input type="hidden" id="delBright" />
				<input type="hidden" id="editright" />
				<input type="hidden" id="editBright" />
				<input type="hidden" id="exportright" />
				<input type="hidden" id="printright" />
				<input type="hidden" id="saveright" />
				<input type="hidden" id="checkright" />
				<input type="hidden" id="RemainFeeright" />
				<input type="hidden" id="PayTyperight" />
				<input type="hidden" id="iStatusright" />
				<input type="hidden" id="sRealNameright" />
				<input type="hidden" id="sBmright" />
				<input type="hidden" id="sAddressright" />
				<input type="hidden" id="sRegDateright" />
				<input type="hidden" id="sDh1right" />
				<input type="hidden" id="sDh2right" />
				<input type="hidden" id="UserName1right" />
				<input type="hidden" id="UserName2right" />
				<input type="hidden" id="idtyperight" />
				<input type="hidden" id="idcardright" />
				<input type="hidden" id="PayTyperight" />
				<input type="hidden" id="sDhright" />
				<input type="hidden" id="iSimultaneousright" />
				<input type="hidden" id="speedright" />
				<input type="hidden" id="AcctStartTimeright" />
				<input type="hidden" id="AcctStopTimeright" />
				<input type="hidden" id="ipaddrright" />
				<input type="hidden" id="vlanidright" />
				<input type="hidden" id="iMacAutoBandright" />
				<input type="hidden" id="linkmanright" />
				<input type="hidden" id="linkphoneright" />
				<input type="hidden" id="UserNameright" />
				<input type="hidden" id="Valueright" />
				<input type="hidden" id="iFeeTyperight" />
				<input type="hidden" id="mobileright" />
				<input type="hidden" id="zafeilistright" />
				<input type="hidden" id="BroadbandBusinessright" />
				<input type="hidden" id="TelphoneBusinessright" />
				<input type="hidden" id="sBm2right" />
				<input type="hidden" id="sBm3right" />
				<input type="hidden" id="sBm4right" />
				<input type="hidden" id="MACdzright" />

				<input type="hidden" id="jrlxright" />
				<input type="hidden" id="oldjrlx" />
				<input type="hidden" id="oldsDh1" />

				<input type="hidden" name="jobidid" id="jobidid" />
				<input type="hidden" name="reportparam" id="reportparam" />
				<input type="hidden" id="userid" value="<%=userid%>" />
				<input type="hidden" id="area" value="<%=area%>" />
				<input type="hidden" id="depart" value="<%=depart%>" />
				<input type="hidden" name="printfeeee" id="printfeeee" value="0" />
				<input type="hidden" id="userareaid" value="<%=userareaid %>" />

				<!-- 是否可以不选一次性费用项 -->
				<input type="hidden" id="ableForNoChoose" name="ableForNoChoose" />

				<!-- 打印报表 -->
				<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
			</div>
		</div>

		<!-- 宽带缴费查询面板 -->
		<div class="neirong" id="multiSearch"
			style="display: none; width: 700px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="broadband.xgsxUserNamequery" />
							<!-- 宽带修改属性用户信息查询 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;"
							onclick="javascript:$('#kdMultiSearchClose').click();">
							<!-- 关闭 -->
							<fmt:message key="global.close" />
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd"
				style="background-color: #FFFFFF; text-align: left; width: 698px; overflow-x: hidden;">
				<div id="grid"></div>
			</div>

			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="kdMultiSearchClose">
					<!-- 关闭 -->
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>

		<!-- 打印表报 -->
		<div class="neirong" id="choosePrintJob" style="display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="broadband.printmethod" />
							<!-- 打印方式 -->
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: center;">
				<h4>
					<fmt:message key="broadband.sjbcaccouncc" />
					<!-- 数据保存成功。请选择打印方式  -->
					:
				</h4>
				<button id="printDirect" class="tsdbutton" onclick="jobPrint(1)">
					<fmt:message key="broadband.zhijiePrint" />
					<!-- 直接打印 -->
				</button>
				<button id="printInDirect" class="tsdbutton" onclick="jobPrint(2)">
					<fmt:message key="broadband.yulanPrint" />
					<!-- 预览打印 -->
				</button>
				<button id="printInDirect" class="tsdbutton" onclick="jobPrint(0)">
					<fmt:message key="broadband.notprint" />
					<!-- 不打印 -->
				</button>
			</div>
			<div class="midd_butt"></div>
		</div>

		<div class="neirong" id="choosePrint" style="display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="broadband.printmethod" />
							<!-- 打印方式 -->
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd"
				style="background-color: #FFFFFF; text-align: center;">
				<h4>
					<fmt:message key="broadband.jobpiaojuprintwanbi" />
					<!-- 工单票据打印完毕，请换纸，然后选择打印方式  -->
					:
				</h4>
				<button id="printDirect" class="tsdbutton" onclick="lsPrint(1)">
					<fmt:message key="broadband.zhijiePrint" />
					<!-- 直接打印 -->
				</button>
				<button id="printInDirect" class="tsdbutton" onclick="lsPrint(0)">
					<fmt:message key="broadband.yulanPrint" />
					<!-- 预览打印 -->
				</button>
			</div>
			<div class="midd_butt"></div>
		</div>
		<iframe id="printReportDirect"
			style="width: 120px; height: 0px; visibility: visible"
			src="print.jsp"></iframe>
		<input type="hidden" id="sspeed" name="sspeed" />
		<input type="hidden" id="useridID" name="useridID" />
		<input type="hidden" id="BASright" name="BASright" />
		<input type="hidden" id="feeendtimeright" name="feeendtimeright" />
		<input type="hidden" id="ifeetypetimeright" name="ifeetypetimeright" />
		<input type="hidden" id="Valuess"/>
		<input type="hidden" id="addressinputright"/>
		<script>
		var hilighter2 = new TableRowHilighter(document.getElementById('memocontent'), 0, 'lightsteelblue');
	  </script>
	</body>
</html>