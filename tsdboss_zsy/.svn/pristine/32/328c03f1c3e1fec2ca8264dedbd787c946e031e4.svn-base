<!--*******************************************************************************
**          *******         ******  *******     **       *****                   **  
**             *            *          *       ** **     *    *                  **
**             *   ******   ******     *      **   **    *****                   ** 
**             *                 *     *     ** *** **   *  *                    **
**             *            ******     *    **       **  *    *                  **
**                                                                               **               
** name:    "WebRoot/WEB-INF/template/telephone/charge/charge_phone.jsp"         **
** version: v10.1                                                                ** 
** author:  lvkui                                                                **
** date:    2011-7-22                                                            **
** desc:    电话收费结帐                                                                    **
** modify:                                                                       ** 
********************************************************************************-->
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = (String)session.getAttribute("groupid");;
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title><!-- 营收销账 --></title>
	<!-- 导入的js文件 -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script src="style/js/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- 页面国际化 -->
		<script type="text/javascript" src="script/broadband/usercat/Internationalization.js"></script>
<!-- 导入js文件结束 -->
<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />
		
<!-- 导入css文件结束 -->
		<!-- 双导航栏异常处理 -->
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		</style>

		<style type="text/css">
			#chooseBox{padding-bottom:30px;}
			#chooseForJF,#chooseForFJ{width:80px;}
			.tsdbutton{margin:2px;padding:2px 18px 2px 18px;height:24px;}
			
			.tsdbtn{line-height:30px;padding:4px 8px 4px 8px;  height:28px; margin-top:10px; margin-left:5px; background: url(style/images/public/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }
			label { float:left;text-align:left; margin-left:10px; width: 80px; line-height: 28px; }
	
			.inputbox{{margin-left:20px; background:url(style/images/public/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
			
			
			#kdBar p{clear:both;padding-left:10px;}
			/*宽带票据*/
			#kdFP{padding-top:30px;padding-bottom:30px;padding-left:10px;}
			#kdInfo{text-align:left;border:#eeeeee 1px solid;}
			#kdInfo td{	background-color:#ffffff;line-height:22px;}
			
			#kduserInfoPanelTab{text-align:left;border:#eeeeee 1px solid;}
			#kduserInfoPanelTab td{background-color:#ffffff;line-height:22px;}
			
			#kdStatus{padding-left:10px;}
			
			#bu_muser a{font-weight:bold;}
			
			#kdButtons{width:100%; float:left; *float:none; height:43px; background:url(style/images/public/buttonsbg.jpg) repeat-x; border-top:#CCCCCC 1px solid;border-bottom:#CCCCCC 1px solid;}
		</style>
		<script language="javascript" type="text/javascript">		
		
		var firstLo = true;
		//宽带别名信息
		var Dat = "";
		//电话缴费表别名信息
		var Datdh1 = "";
		//电话缴费明细表别名信息
		var Datdh2 = "";
		//Phone Broadband限制
		var Sys_Config = "";
		
		$(function(){			
			
			$("#navBar").append(genNavv());
			gobackInNavbar("navBar");
			 
			pConfig();
			
			Datdh1 = loadData("zhjiaofei",$("#lanType").val(),"2");
			
			bindEventToGh();
			
			loadMainTab();
			
			
			
		});
		
		//缴费项目配置
		function pConfig()
		{
			var res=fetchSingleValue("Revenue.config",6,"");
			if(res==undefined)
			{
				return false;
			}
			var pArr = res.split(",");
			for(var i=0;i<pArr.length;i++)
			{
				//宽带缴费项目配置
				$("#chooseForJF").append("<option value=\""+pArr[i]+"\">"+pArr[i]+"</option>");
				//固话缴费项目配置
				$("#chooseForFJ").append("<option value=\""+pArr[i]+"\">"+pArr[i]+"</option>");
			}
			ghCheckCan();
		}
		
		function bindEventGlobal()
		{
			$("#chooseForJF,#chooseForFJ").change(function(){
				refreshState($(this));
			});
			
			$(document).keydown(function(event){
				//没有弹出面板的情况下
				//if($.browser.msie)
				//{
					if(event.altKey && event.ctrlKey)
					{
						//如果当前是电话缴费页面，则切换至宽带缴费
						if($("#gh").css("display")=="block" && Sys_Config["Broadband"]!="Y")
						{
							$("#gh").css("display","none");
							$("#kd").css("display","block");
							
							$("#kdSearchBox").select().focus();
							$("#chooseForJF,#chooseForFJ").val("<fmt:message key="writeOff.kdFee"/>");//宽带费
						}//如果当前是宽带缴费页面，则切换至电话缴费
						else if($("#gh").css("display")=="none" && Sys_Config["Phone"]!="Y")
						{
							$("#kd").css("display","none");
							$("#gh").css("display","block");
							
							$("#ghSearchBox").select().focus();
							$("#chooseForJF,#chooseForFJ").val("<fmt:message key="writeOff.telFee"/>");//电话费
						}
					}
				//}
			});
		}
		
		//检测班长是否有指定流水号的销账权限
		function checkIfBzCan()
		{
			if(isDhOrKd()==1)
				return getGHBZQX();
			else return getKDBZQX();
		}
		//根据下拉框状态更新面板
		function refreshState(cron)
		{
			if(cron==null || cron==undefined)
				cron = $("#chooseForJF");
			
			if($(cron).val()=="<fmt:message key="writeOff.telFee"/>")
			{
				//固话缴费提示信息
				$("#gh").css("display","block");
				$("#kd").css("display","none");
				$("#chooseForJF,#chooseForFJ").val("<fmt:message key="writeOff.telFee"/>");//电话费//.attr("selected","selected");
				$("#ghSearchBox").select();
			}
			else
			{
				$("#kd").css("display","block");
				$("#gh").css("display","none");
				$("#chooseForJF,#chooseForFJ").val("<fmt:message key="writeOff.kdFee"/>");//宽带费
				$("#kdSearchBox").select();
			}
		}
	
		////////////////////////////////////////////////////////////////////////////////////
		//////////                 第一次加载页面时取列名和别名
		///////////////////////////////////////////////////////////////////////////////////
		function bindEventToKd()
		{		
			
			$("#kdSearchWay").change(function(){$("#kdSearchBox").select();$("#kdSearchBox").focus();});
			
			$("#kdSearchByUserName").click(function(){searchForKd();});
			
			$("#kdSearchBox").keydown(function(event){if(event.keyCode==13){$("#kdSearchByUserName").click();}});
			
			$("#kdxz").click(function(){xzbzAdd();});
			
			$("#kdback").click(function(){
				$("#kdSearchBox").val("");
				$("#kkdd").removeData("kdauthcode");
				$("#kkdd").removeData("kdauthjid");
				loadKdTab();
				$("#kdxz").attr("disabled","disabled");
				$("#kdSearchBox").select();	
				$("#kdSearchBox").focus();
				
				setTimeout("$.unblockUI",100);
			});
		}
		
		/////检测是否可以进行电话缴费
		function ghCheckCan()
		{
			/*var res = fetchSingleValue("Revenue.ForbidPhone",6,"");
			if(res=="Y")
			{
				//保存是否禁止电话缴费状态
				$("#forbid").val("Y");
				
				$("#chooseForJF,#chooseForFJ").val("宽带费");
				$("#gh").css("display","none");
				$("#kd").css("display","block");
				$("#chooseForJF,#chooseForFJ").attr("disabled","disabled");
				
				$("#kdSearchBox").select();
				$("#kdSearchBox").focus();
			}*/
			Sys_Config = fetchMultiKVValue("Duty.sysConfig",6,"",["tsection","tvalues"]);
			var dhPayForbid = fetchSingleValue("Duty.sysDhPayConfig",6,"");
			//如果设置有禁止电话缴费，则同时禁用电话功能
			if(dhPayForbid=="Y")
				Sys_Config["Phone"] = "Y";
			
			if(Sys_Config["Broadband"]=="Y" && $("#chooseForJF option").size()>1)
			{
				$("#chooseForJF,#chooseForFJ").find("option[value='<fmt:message key="writeOff.kdFee"/>']").remove();
			}
			if(Sys_Config["Phone"]=="Y" && $("#chooseForJF option").size()>1)
			{
				$("#chooseForJF,#chooseForFJ").find("option[value='<fmt:message key="writeOff.telFee"/>']").remove();
			}
			
			refreshState();
			if($("#chooseForJF option").size()==1)
				$("#chooseForJF,#chooseForFJ").attr("disabled","disabled");
		}
		
		////////////////////////////////////////////////////////////////////////////////////
		//////////                         获取权限
		///////////////////////////////////////////////////////////////////////////////////
		function getPower()
		{
			var param = "&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val();			
			
			var res = fetchMultiPValue("writeoff.getPower",6,param);
			
			var powerr = 0;
			
			if(res[0][0]=='all')
			{
				//alert('all');
				powerr = 10;
			}
			else
			{
				for(var i = 0;i<res.length;i++){
					var temp = getCaption(res[i][0],'writeoffdays','');
					temp = parseInt(temp,10);
					if(isNaN(temp) || temp <= powerr)
					{
						continue;
					}
					else
					{
						powerr=temp;
					}
				}
			}
			return powerr;
		}
		
		/**
			检测是否可销帐
		*/
		function checkKDCan()
		{
			//是否使用的是授权码
			
			if($("#kkdd").data("kdauthcode")=="truetrue")
			{
				if($("#kdgrid").getRowData(1).lsz!=undefined)
				{
					$("#kdxz").removeAttr("disabled");
				}
				return false;
			}
			
			//使用宽带账号销账
			if($("#kdgrid").getRowData(1).lsz==undefined)
			{
				$("#kdxz").attr("disabled","disabled");
				return false;
			}
			
			//检测当前ID是否已存在申请
			if(!checkAlreadyExist(getKDJID()))
			{
				return false;
			}
			
			var kdUserName = $.trim($("#kdSearchBox").val());
			//取缴费信息
			var times = getPower();
			
			var urlMn = "&userid="+$("#skrid").val()+"&account="+tsd.encodeURIComponent(kdUserName)+"&times="+times;
				
			urlMn += "&area=";
			urlMn += tsd.encodeURIComponent($("#area").val());
			urlMn += "&ctype=checkfx";
			urlMn += "&clsz=";
			urlMn += tsd.encodeURIComponent($("#kdgrid").getRowData(1).lsz);
		
			var resjf=fetchMultiPValue("writeoff.kdxiaozhang",0,urlMn);
		
			if(resjf[0]==undefined || resjf[0][0]==undefined)
			{
				$("#kdxz").attr("disabled","disabled");
				if(confirm("<fmt:message key="writeOff.noPower"/>"))//你没有销账权限，是否要申请销账授权
				{
					autoBlockForm('addKDApForm',5,'addKDApClose',"#ffffff",false);
					if(checkIfBzCan())
					{
						$("#apply_obj_gl").css("display","none");
						$("label[for='apply_obj_gl']").css("display","none");
						$("#apply_obj_bz").css("display","block");
						$("label[for='apply_obj_bz']").css("display","block");
					}
					else
					{
						$("#apply_obj_gl").css("display","block");
						$("label[for='apply_obj_gl']").css("display","block");
						$("#apply_obj_bz").css("display","none");
						$("label[for='apply_obj_bz']").css("display","none");
					}
				}
				return false;
			}
			else if(parseInt(resjf[0][0],10)>0)
			{
				$("#kdxz").removeAttr("disabled");
				return true;
			}
			else
			{
				$("#kdxz").attr("disabled","disabled");
				if(confirm("<fmt:message key="writeOff.noPower"/>"))//你没有销账权限，是否要申请销账授权
				{
					autoBlockForm('addKDApForm',5,'addKDApClose',"#ffffff",false);
					if(checkIfBzCan())
					{
						$("#apply_obj_gl").css("display","none");
						$("label[for='apply_obj_gl']").css("display","none");
						$("#apply_obj_bz").css("display","block");
						$("label[for='apply_obj_bz']").css("display","block");
					}
					else
					{
						$("#apply_obj_gl").css("display","block");
						$("label[for='apply_obj_gl']").css("display","block");
						$("#apply_obj_bz").css("display","none");
						$("label[for='apply_obj_bz']").css("display","none");
					}
				}
				return false;
			}
		}
		
		function getKDJID()
		{
			if($("#kdgrid").getRowData(1).lsz==undefined)
			{
				$("#kdxz").attr("disabled","disabled");
				return false;
			}
			var kdUserName = $.trim($("#kdSearchBox").val());
			var times = getPower();
			var urlMn = "&userid="+$("#skrid").val()+"&account="+tsd.encodeURIComponent(kdUserName)+"&times="+times;
				
			urlMn += "&area=";
			urlMn += tsd.encodeURIComponent($("#area").val());
			urlMn += "&ctype=getid";
			urlMn += "&clsz=";
			urlMn += tsd.encodeURIComponent($("#kdgrid").getRowData(1).lsz);
			var resjf=fetchMultiPValue("writeoff.kdxiaozhang",0,urlMn);
			
			if(resjf[0]==undefined || resjf[0][0]==undefined)
			{
				$("#kdxz").attr("disabled","disabled");
				return false;
			}
			else
			{
				return resjf[0][0];
			}
		}
		
		//检测班长对指定的流水号是否有销账权限
		function getKDBZQX()
		{
			if($("#kdgrid").getRowData(1).lsz==undefined)
			{
				$("#kdxz").attr("disabled","disabled");
				return false;
			}
			var kdUserName = $.trim($("#kdSearchBox").val());
			var urlMn = "&userid="+$("#skrid").val()+"&account="+tsd.encodeURIComponent(kdUserName)+"&times=3";
				
			urlMn += "&area=";
			urlMn += tsd.encodeURIComponent($("#area").val());
			urlMn += "&ctype=checkmonitor";
			urlMn += "&clsz=";
			urlMn += tsd.encodeURIComponent($("#kdgrid").getRowData(1).lsz);
			var resjf=fetchMultiPValue("writeoff.kdxiaozhang",0,urlMn);
			
			if(resjf[0]==undefined || resjf[0][0]==undefined)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		function kdUpdateFXStatus(ctype)
		{
			var params = "";
			params += "&userid=";
			params += tsd.encodeURIComponent($("#skrid").val());
			params += "&type=" + tsd.encodeURIComponent(ctype);
			params += "&jiaofeiid=";
			params += tsd.encodeURIComponent(ctype==1?$("#gghh").data("ghauthjid"):$("#kkdd").data("kdauthjid"));
			
			executeNoQuery("WriteOff.updateFX",1,params);			
		}
		
		//根据授权码取缴费ID
		function searchForKd()
		{
			$("#kkdd").removeData("kdauthcode");
			$("#kkdd").removeData("kdauthjid");
			searchForKd_d(undefined);
		}
		
		
		////////////////////////////////////////////////////////////////////////////////////
		//////////                        查找帐号(宽带)
		///////////////////////////////////////////////////////////////////////////////////
		function searchForKd_d(jid)
		{		
			
			$("#kdxz").attr("disabled","disabled");
			var kdUserName = $.trim($("#kdSearchBox").val());
			var param = "";
			if(kdUserName!="")
			{
				//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
		
				param += "&param=UserName";
				param += "&paramval=";
				param += tsd.encodeURIComponent(kdUserName);
				
				if(tsd.Qualified()==false){
					$("#kdSearchBox").select();
					$("#kdSearchBox").focus();
					return false;
				}
				
			}
			else
			{
				//alert("请输入帐号");
				alert("<fmt:message key='Writeoff.enterAccount' />");
				$("#kdSearchBox").focus();
				return false;
			}
			///获取用户信息
			var res = fetchMultiArrayValue("WriteOff.getKDDetail",0,param);
			//取缴费信息
			var times = getPower();
				
			var urlMn = "&userid="+$("#skrid").val()+"&account="+tsd.encodeURIComponent(kdUserName)+"&times="+times;
				
			urlMn += "&area=";
			urlMn += tsd.encodeURIComponent($("#area").val());
			
			if(jid!=undefined)
			{
				urlMn += "&cjid=" + jid;
				urlMn += "&ctype=getbyjid";
			}
			//获取账号的缴费信息	
			var resjf=fetchMultiPValue("writeoff.kdxiaozhang",0,urlMn);
			
			if(jid==undefined && typeof res[0][0] == 'undefined')
			{
				//alert("你输入的信息没有记录");
				loadKdTab();
				alert("<fmt:message key="writeOff.theNumNonentity"/>");//你输入的账号不存在
				 
				$("#kdSearchBox").select();
				$("#kdSearchBox").focus();	
				$("#kdxz").attr("disabled","disabled");
				return false;
			}
			else if(jid==undefined && (resjf[0]==undefined||resjf[0][0]==undefined||resjf[0][0]==""||resjf[0][0]=="0"))
			{
				loadKdTab();
				alert("<fmt:message key="writeOff.noJiaofeiMessage"/>");//没有该用户的缴费信息，或者是在可销账的期限内没有该用户的缴费信息
				$("#kdSearchBox").select();
				$("#kdSearchBox").focus();
			}
			else
			{
				var urlMm = tsd.buildParams({ packgname:'service',
								clsname:'Procedure',//类名
								method:'exequery',//方法名
								ds:'broadband',
								tsdExeType:'query',//操作类型 
								datatype:'xml',//返回数据格式 
								tsdpname:'writeoff.kdxiaozhang'
								});
				
				$("#kdgrid").setGridParam({url:'mainServlet.html?'+urlMm+urlMn});
				$("#kdgrid").trigger("reloadGrid");
			}
		}
		
		//添加销账备注
		function xzbzAdd()
		{
			if(confirm("<fmt:message key='Writeoff.writeoffConfirm' />?"))
			{
			
				var urlstr=tsd.buildParams({ 	
 					packgname:'service',//java包
 					clsname:'ExecuteSql',//类名
 					method:'exeSqlData',//方法名
 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
 					tsdcf:'mssql',//指向配置文件名称
 					tsdoper:'exe',//操作类型 
 					tsdpk:'zhjiaofei.add'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
 				});
				urlstr+="&id="+$("#hidids").val();
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							alert("返销账成功!");
							ghClearInfo();
						}	
					}
				});
			}
			else
			{
				
			}
		}
		
		////////////////////////////////////////////////////////////////////////////////////
		//////////                        宽带 销账
		///////////////////////////////////////////////////////////////////////////////////
		function KDXiaoZhang()
		{
			if($("#kdgrid").getRowData(1).lsz==undefined)
			{
				$("#kdxz").attr("disabled","disabled");
				return false;
			}
			//$("#kdxz").attr("disabled","disabled");
			var params = "&userid=",
			params = params + $("#skrid").val();
			params = params + '&account=';
			params += $.trim($("#kdgrid").getRowData(1).UserName);
			params += "&lxz=";
			params += $("#kdgrid").getRowData(1).lsz;
			params += "&bz=";
			//销账备注
			var xzbz  = $.trim($("#addKDBzText").val());
			tsd.QualifiedVal=true;
			params += tsd.encodeURIComponent(xzbz);
			if(tsd.Qualified()==false){return false;}
			//关闭备注面板并清空备注框
			setTimeout("$.unblockUI",1000);
			$("#addKDBzClose").click();
			
			
			var loginfo = tsd.encodeURIComponent("<fmt:message key="writeOff.kdxz"/>");//宽带 销账
			loginfo += ";";
			loginfo += tsd.encodeURIComponent("<fmt:message key="writeOff.telNumber"/>");//帐号
			loginfo += ":";
			loginfo += $("#kdgrid").getRowData(1).UserName;
			loginfo += ";";
			loginfo += tsd.encodeURIComponent("<fmt:message key="writeOff.Lsh"/>");//流水号
			loginfo += ":";
			loginfo += $("#kdgrid").getRowData(1).lsz;
			loginfo += ";";
			loginfo += tsd.encodeURIComponent("<fmt:message key="writeOff.xzReason"/>");//销账原因
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(xzbz);
			
			var res = fetchMultiPValue("writeoff.kdXZ",0,params);
			if(res.length>0)
			{
				//alert(res[0][0]==0?"销账成功":"销账失败");
				alert(res[0][0]==0?"<fmt:message key='Writeoff.writeoffSuccess' />":"<fmt:message key='Writeoff.writeoffFail' />");
				$("#kdxz").attr("disabled","disabled");
				//如果是授权销账，更新状态
				
				if($("#kkdd").data("kdauthcode")=="truetrue") kdUpdateFXStatus("2");
				writeLogInfo("","modify",loginfo);
				$("#kkdd").removeData("kdauthcode");
				$("#kkdd").removeData("kdauthjid");
				//$("#kdgrid").trigger("reloadGrid");
				$("#kdSearchBox").select();	
				$("#kdSearchBox").focus();	
				loadKdTab("");
			}
			
		}
		
		///////////////////////////////////////////////////////////////////
		/////                      设置权限
		//////////////////////////////////////////////////////////////////
		function setUserRight()
		{
			var allRi = fetchMultiPValue("WriteOff.getPower1",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
			if(typeof allRi == 'undefined' || allRi.length == 0)
			{
				//alert("取权限失败");
				return false;
			}
			if(allRi[0][0]=="all")
			{
				return true;
			}
			var fixedcharge = false;
			var broadbandcharge = false;
			
			for(var i = 0;i<allRi.length;i++){
				if(getCaption(allRi[i][0],'fixedcharge','')=="true")
					fixedcharge = true;
				if(getCaption(allRi[i][0],'broadbandcharge','')=="true")							
					broadbandcharge = true; 
				
			}
			//alert(fixedcharge+":"+broadbandcharge+":"+payformore);
			
			if(fixedcharge==false)
			{
				$("#fixedcharge").css("display","none");
				
			}
			if(broadbandcharge==false)
			{
				$("#broadbandcharge").css("display","none");		
			}
			
		}
			
		
		////////////////////////////////////////////////////////////////////////////////////
		//////////                         加载宽带表
		///////////////////////////////////////////////////////////////////////////////////
		function loadKdTab(param)
		{			
			$("#kkdd").empty();
			$("#kkdd").append("<table id=\"kdgrid\" class=\"scroll\"></table><div id=\"kdpager\" class=\"scroll\"></div>");
			 
			var coln = "<fmt:message key="writeOff.kdTab"/>";//账号,缴费时间,本次缴费剩余金额,上次剩余金额,缴费金额,操作员,流水号,计费规则,用户类型
			var cols = "UserName,AcctPayTime,thisPayMoney,lastPayMoney,PayMoney,Operator,lsz,FeeName,UserType";
			coln = coln.split(",");
			var colm = [];
			cols = cols.split(",");
			for(var i=0;i<cols.length;i++)
			{
				colm.push(eval("("+"{name:'"+cols[i]+"',index:'"+cols[i]+"',width:120}"+")"));
			}
			colm[1].width=140;
			colm[4].width=80;
			colm[5].width=80;
			colm[7].width=100;
			colm[8].width=100;
			
			//alert(cols.length + "\n" + colm.length);
			jQuery("#kdgrid").jqGrid({
				url:'mainServlet.html?' + param, 
				datatype: 'xml', 
				colNames:coln,
				colModel:colm,
				       	rowNum:15, 
				       	rowList:[10,20,30], 
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#b_main_pager'), 
				       	sortname:'id', 
				       	viewrecords: true, 
				       	sortorder: 'asc', 
				       	caption:'<fmt:message key="Writeoff.broadbandRec" />',//'宽带缴费话单', 
				       	height:110,
				       	loadComplete:function(){				        	
				        
				        	checkKDCan();
				        }
				       
				}).navGrid('#kdpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////电话缴费销账
		/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		function bindEventToGh()
		{
			$("#ghSearchByUserName").click(function(){
				searchForDh();
			});
			//查询输入框回车事件
			$("#ghSearchBox").keydown(function(event){
				if(event.keyCode==13)
				{
					$("#ghSearchByUserName").click();
				}
			});
			//电话 销账
			$("#ghxz").click(function(){
				ghXiaoZhang();
			});
			//电话缴费销账  重置
			$("#ghback").click(function(){
				ghClearInfo();
			});
		}
		
		//清空页面信息
		function ghClearInfo()
		{
			$("#ghSearchBox").val("");
			
			
			loadMainTab();
			$("#ghSearchBox").focus();
		}
		
		//根据授权码取缴费ID
		function searchForDh()
		{
			$("#gghh").removeData("ghauthcode");
			$("#gghh").removeData("ghauthjid");
			searchForDh_d(undefined);			
		}
		
		
		function searchForDh_d(jid)
		{
		
			if($.trim($("#ghSearchBox").val())=="")
			{
			
				alert("请输入待销账的客户号");
				$("#ghSearchBox").select().focus();
				return false;
			}
			
			
			var urlstr=tsd.buildParams({ 	
			 		 						packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'zhjiaofei.querycount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});
			$.ajax({
				url:'mainServlet.html?'+urlstr+"&hth="+$("#ghSearchBox").val(),
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					var flag = false;
					$(xml).find('row').each(function(){
						var num = $(this).attr("num");
						if(num <= 0){
							alert("该客户在可销帐的时限内没有缴费记录!");
							$("#hidids").val('');
							$("#ghSearchBox").select();
							flag = true;
						}
					});
					
					
					if(flag==false){
					
						var urlstr=tsd.buildParams({ 	
			 		 						packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'zhjiaofei.queryid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 				});
						$.ajax({
							url:'mainServlet.html?'+urlstr+"&hth="+$("#ghSearchBox").val(),
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								var flag = false;
								$(xml).find('row').each(function(){
									var num = $(this).attr("ids");
									if(num != undefined){
										$("#hidids").val(num);
									}
								});
							}
						});
					
						/***************************
						*     判断完成，进行保存操作   * 
						***************************/
						 var urlstr=tsd.buildParams({ 	
						 		 						packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					tsdpk:'zhjiaofei.query'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 				});
							urlstr+="&hth="+$("#ghSearchBox").val();
							
							$("#ghgrid").setGridParam({url:"mainServlet.html?"+urlstr}).trigger("reloadGrid");
					}
				}
			});
			
			$("#ghxz").attr("disabled","");
			
		}
		//取电话缴费流水号
		function getGHJID()
		{
			if($("#gghh").data("lsz")==undefined)
			{
				//$("#ghxz").attr("disabled","disabled");
				return false;
			}
			var ghDH = $.trim($("#ghSearchBox").val());
			var times = getPower();
			var urlMn = "&SkrID="+$("#skrid").val()+"&CancelType=1&Hth="+tsd.encodeURIComponent(ghDH)+"&times="+times+"&Area="+tsd.encodeURIComponent($("#area").val());
				
			urlMn += "&ctype=getid";
			urlMn += "&clsz=";
			urlMn += tsd.encodeURIComponent($("#gghh").data("lsz"));
			var resjf=fetchMultiPValue("writeoff.checkXiaoZhangHth",1,urlMn);
			
			if(resjf[0]==undefined || resjf[0][0]==undefined)
			{
				//$("#ghxz").attr("disabled","disabled");
				return false;
			}
			else
			{
				return resjf[0][0];
			}
		}
		//检测班长对指定的电话流水号是否有销账权限
		function getGHBZQX()
		{
			if($("#gghh").data("lsz")==undefined)
			{
				//$("#ghxz").attr("disabled","disabled");
				return false;
			}
			var ghDH = $.trim($("#ghSearchBox").val());
			
			var urlMn = "&SkrID="+$("#skrid").val()+"&CancelType=1&Hth="+tsd.encodeURIComponent(ghDH)+"&times=3&Area="+tsd.encodeURIComponent($("#area").val());
				
			urlMn += "&ctype=checkmonitor";
			urlMn += "&clsz=";
			urlMn += tsd.encodeURIComponent($("#gghh").data("lsz"));
			var resjf=fetchMultiPValue("writeoff.checkXiaoZhangHth",1,urlMn);
			
			if(resjf[0]==undefined || resjf[0][0]==undefined || resjf[0][0]=="0")
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		
		/**
			固话   检测是否可销帐
		*/
		function checkGHCan()
		{
			//是否使用的是授权码			
			if($("#gghh").data("ghauthcode")=="truetrue")
			{
				if($("#gghh").data("lsz")!=undefined)
				{
					//$("#ghxz").removeAttr("disabled");
				}
				return false;
			}
			
			//使用电话账号销账
			if($("#gghh").data("lsz")==undefined)
			{
				//$("#ghxz").attr("disabled","disabled");
				return false;
			}
			//检测当前ID是否已存在申请
			if(!checkAlreadyExist(getGHJID()))
			{
				return false;
			}
			
			var ghDH = $.trim($("#ghSearchBox").val());
			//取缴费信息
			var times = getPower();
				
			var urlMn = "&SkrID="+$("#skrid").val()+"&CancelType=1&Hth="+tsd.encodeURIComponent(ghDH)+"&times="+times+"&Area="+tsd.encodeURIComponent($("#area").val());
				
			urlMn += "&ctype=checkfx";
			urlMn += "&clsz=";
			urlMn += tsd.encodeURIComponent($("#gghh").data("lsz"));
				
			var resjf=fetchMultiPValue("writeoff.checkXiaoZhangHth",1,urlMn);
		
			if(resjf[0]==undefined || resjf[0][0]==undefined)
			{
				//$("#ghxz").attr("disabled","disabled");
				if(confirm("<fmt:message key="writeOff.noPower"/>"))//你没有销账权限，是否要申请销账授权
				{
					autoBlockForm('addKDApForm',5,'addKDApClose',"#ffffff",false);
					if(checkIfBzCan())
					{
						$("#apply_obj_gl").css("display","none");
						$("label[for='apply_obj_gl']").css("display","none");
						$("#apply_obj_bz").css("display","block");
						$("label[for='apply_obj_bz']").css("display","block");
					}
					else
					{
						$("#apply_obj_gl").css("display","block");
						$("label[for='apply_obj_gl']").css("display","block");
						$("#apply_obj_bz").css("display","none");
						$("label[for='apply_obj_bz']").css("display","none");
					}
				}
				return false;
			}
			else if(parseInt(resjf[0][0],10)>0)
			{
				//$("#ghxz").removeAttr("disabled");
				return true;
			}
			else
			{
				//$("#ghxz").attr("disabled","disabled");
				if(confirm("<fmt:message key="writeOff.noPower"/>"))//你没有销账权限，是否要申请销账授权
				{
					autoBlockForm('addKDApForm',5,'addKDApClose',"#ffffff",false);
					if(checkIfBzCan())
					{
						$("#apply_obj_gl").css("display","none");
						$("label[for='apply_obj_gl']").css("display","none");
						$("#apply_obj_bz").css("display","block");
						$("label[for='apply_obj_bz']").css("display","block");
					}
					else
					{
						$("#apply_obj_gl").css("display","block");
						$("label[for='apply_obj_gl']").css("display","block");
						$("#apply_obj_bz").css("display","none");
						$("label[for='apply_obj_bz']").css("display","none");
					}
				}
				return false;
			}
		}
		
		//缴费表
		function loadMainTab(param)
		{
			$("#gghh").empty();
			$("#gghh").append("<table id=\"ghgrid\" class=\"scroll\"></table><div id=\"ghpager\" class=\"scroll\"></div>");
			//alert("load==="+document.documentElement.scrollWidth);
			jQuery("#ghgrid").jqGrid({
				url:'mainServlet.html?' + param, 
				datatype: 'xml', 
				colNames:Datdh1.colNames, 
				colModel:Datdh1.colModels, 
				       	rowNum:15, 
				       	rowList:[10,20,30], 
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	//pager: jQuery('#ghpager'), 
				       	sortname:'id', 
				       	viewrecords: true, 
				       	sortorder: 'asc', 
				       	caption:'<fmt:message key="Writeoff.dhJiaofeiRec" />', //电话缴费信息
				      	width:document.documentElement.scrollWidth-45,
				       	height:110, 
				        
				        loadComplete:function(){
				        
				        	checkGHCan();
				        	
				        	var urlstr=tsd.buildParams({packgname:'service',//java包
								clsname:'ExecuteSql',//类名
								method:'exeSqlData',//方法名
								ds:'tsdCharge',//数据源名称
								tsdcf:'mssql',//指向配置文件名称
								tsdoper:'query',//操作类型 
								datatype:'xmlattr',//返回数据格式 
								tsdpk:'WriteOff.queryheji'
							});
				        }
				       
				}).navGrid('#ghpager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
				); 
		}
		//明细表
		function loadSubTab(param)
		{	
			$("#ggdd").empty();
			$("#ggdd").append("<table id=\"ghdgrid\" class=\"scroll\"></table><div id=\"ghdpager\" class=\"scroll\"></div>");
			
			jQuery("#ghdgrid").jqGrid({
				url:'mainServlet.html?' + param, 
				datatype: 'xml', 
				colNames:Datdh2.colNames,
				colModel:Datdh2.colModels,
				       	rowNum:10, 
				       	rowList:[10,20,30], 
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#sub_pager'), 
				       	sortname:'id', 
				       	viewrecords: true, 
				       	sortorder: 'asc', 
				       	caption:'<fmt:message key="Writeoff.telFeeRec" />',//电话缴费话单明细
				       	width:document.documentElement.scrollWidth-45,
				       	height:110
				       
				}).navGrid('#sub_pager', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		
		//////////                         电话缴费销账
		function ghXiaoZhang()
		{
			var params = "&Func=Xiaozhang",
			params = params + '&Lsz_Ph=';
			params += $.trim($("#gghh").data("lsz"));
			params += "&SkrID=";
			params += $("#skrid").val();
			
			var loginfo = "Oper:"+$("#skrid").val();
			loginfo += ' <fmt:message key="Writeoff.telNumber" />'+"="; //账号=
			loginfo += $.trim($("#gghh").data("dh"));
			loginfo += ' <fmt:message key="Writeoff.telNumber" />'+"="; //流水号
			loginfo += $.trim($("#gghh").data("lsz"));
			
			//alert(params);
			if(confirm("<fmt:message key="Writeoff.youSure" />"))//你确定要销除本条帐单么?
			{				
				var urlstr=tsd.buildParams({ 	
 					packgname:'service',//java包
 					clsname:'ExecuteSql',//类名
 					method:'exeSqlData',//方法名
 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
 					tsdcf:'mssql',//指向配置文件名称
 					tsdoper:'exe',//操作类型 
 					tsdpk:'zhjiaofei.add'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
 				});
				urlstr+="&id="+$("#hidids").val();
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							var urlstr=tsd.buildParams({ 	
			 					packgname:'service',//java包
			 					clsname:'ExecuteSql',//类名
			 					method:'exeSqlData',//方法名
			 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			 					tsdcf:'mssql',//指向配置文件名称
			 					tsdoper:'exe',//操作类型 
			 					tsdpk:'zhjiaofei.update'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 				});
							urlstr+="&id="+$("#hidids").val();
							$.ajax({
								url:'mainServlet.html?'+urlstr,
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
										alert("返销账成功!");
									}	
								}
							});
							
							ghClearInfo();
						}	
					}
				});
			}	
		}
		//检测指定的缴费ID是否已经存在   电话宽带共用
		function checkAlreadyExist(cjid)
		{
			var urlMn = "&SkrID="+$("#skrid").val()+"&Area="+tsd.encodeURIComponent($("#area").val())+"&xtype=" + isDhOrKd();
			
			urlMn += "&ctype=checkbyid";
			urlMn += "&cjid=";
			urlMn += cjid;
				
			var resjf=fetchMultiPValue("writeoff.checkXiaoZhangHth",1,urlMn);
			
			if(resjf[0]!=undefined && resjf[0][0]=="0")
				return true
			else
			{
				if(confirm("<fmt:message key="Writeoff.xzTj" />"))//当前可销账账单已存在销账授权申请，请使用授权码进行销账。
				{
					autoBlockForm('authcodeForm',25,'authcodeFormClose',"#ffffff",false);
				}
				else
					return false;
			}
		}
		
		function applyAP()
		{
			var applyf = "";
			if($("#apply_obj_bz").attr("checked"))
			{
				applyf = "<fmt:message key="Writeoff.banzhang" />";//班长
			}
			else if($("#apply_obj_gl").attr("checked"))
			{
				applyf = "<fmt:message key="Writeoff.telAdmin" />";//管理员
			}
			if(applyf=="")
			{
				alert("<fmt:message key="Writeoff.telObject" />");//请选择要申请的对象
				return false;
			}
			
			var applyra = $.trim($("#addKDApText").val());
			if(applyra=="")
			{
				alert("<fmt:message key="Writeoff.inputReason" />");//请填写申请原因
				$("#addKDApText").select().focus();
				return false;
			}
			var jid = "";
			if(isDhOrKd()==1)
				jid = getGHJID();
			else
				jid = getKDJID();
			
			if(jid==false)
			{
				alert("<fmt:message key="Writeoff.applyBad" />");//申请失败
				return false;
			}
			
			var params = "";
			params += "&userid=";
			params += tsd.encodeURIComponent($("#skrid").val());
			params += "&uname=";
			params += tsd.encodeURIComponent($("#uuname").val());
			params += "&type=";
			params += tsd.encodeURIComponent(isDhOrKd());
			params += "&area=";
			params += tsd.encodeURIComponent($("#area").val());
			params += "&object=";
			params += tsd.encodeURIComponent(applyf);
			params += "&jiaofeiid=";
			params += tsd.encodeURIComponent(jid);
			params += "&description=";
			params += tsd.encodeURIComponent(applyra);
			
			var loginfo = tsd.encodeURIComponent((isDhOrKd()==1?"<fmt:message key="Writeoff.telphone" />":"<fmt:message key="Writeoff.broadband" />")+"<fmt:message key="Writeoff.fanxzSQ" />");//1,电话  2,宽带 3,反销账申请
			loginfo += ";";
			loginfo += tsd.encodeURIComponent("<fmt:message key="Writeoff.jiaofeiID" />");//缴费ID
			loginfo += ":";
			loginfo += jid;
			loginfo += ";";
			loginfo += tsd.encodeURIComponent("<fmt:message key="Writeoff.applicant" />");//申请人
			loginfo += ":";
			loginfo += tsd.encodeURIComponent($("#skrid").val() + "(" + $("#uuname").val() + ")");
			loginfo += ";";
			loginfo += tsd.encodeURIComponent("<fmt:message key="Writeoff.area" />");//区域
			loginfo += ":";
			loginfo += tsd.encodeURIComponent($("#area").val());
			loginfo += ";";
			loginfo += tsd.encodeURIComponent("<fmt:message key="Writeoff.applyRreasons" />");//申请原因
			loginfo += ":";
			loginfo += tsd.encodeURIComponent(applyra);
			
			var res = executeNoQuery("WriteOff.addFX",1,params);
			if(res=="true" || res==true)
			{
				alert("<fmt:message key="Writeoff.applyOk" />");//申请成功
				writeLogInfo("","modify",loginfo);
			}
			else
			{
				alert("<fmt:message key="Writeoff.applyBad" />");//申请失败
			}
			setTimeout("$.unblockUI",1000);
			$("#addKDApClose").click();
		}
		//检测当前是电话销账或是宽带销账 1:电话  2:宽带
		function isDhOrKd()
		{
			if($("#chooseForFJ").val()=="<fmt:message key="writeOff.telFee"/>")//电话费
			{
				return 1;
			}
			else if($("#chooseForFJ").val()=="<fmt:message key="writeOff.kdFee"/>")//宽带费
			{
				return 2;
			}
			else
			{
				alert("<fmt:message key="writeOff.payTypeError"/>");//错误的缴费方式
				return 0;
			}
		}
		//检测授权码 and 销账
		function confirmAuth()
		{
			var authcode = $.trim($("#authcodeTxt").val());
			if(authcode=="")
			{
				alert("<fmt:message key="writeOff.addCode"/>");//请输入授权码
				$("#authcodeTxt").select().focus();
				return false;
			}
			//获取授权码对应的缴费ID
			var jid = fetchSingleValue("WriteOff.queryFX",1,"&authcode=" + tsd.encodeURIComponent(authcode) + "&userid=" + tsd.encodeURIComponent($("#skrid").val()));
			if(jid=="" || jid==undefined)
			{
				jid == "-9999999";
			}
			//获取申请申请几间对应的缴费ID
			var jtid = "";
		
			if(isDhOrKd()==1)
			{
				jtid = getGHJID();
			}
			else
			{
				jtid = getKDJID();
			}
			if(jid!=jtid)
			{
				alert("<fmt:message key="writeOff.codeInvalid"/>");//你所输入的授权码无效
				
				return false;
			}
			else
			{
				if(isDhOrKd()==1)
				{
					$("#gghh").data("ghauthcode","truetrue");
					$("#gghh").data("ghauthjid",jid);
					//$("#ghxz").removeAttr("disabled").click();
				}
				else
				{
					$("#kkdd").data("kdauthcode","truetrue");
					$("#kkdd").data("kdauthjid",jid);
					$("#kdxz").removeAttr("disabled").click();
				}
				
				//setTimeout("$.unblockUI",100);
				$('#authcodeFormClose').click();//关闭面板
				
			}
		}
		
		function gobackInNavbar(navBar)
		{
			$("#" + navBar).append("<span id=\"goback\">返回</span>");		
			$("#goback").css({position:"absolute",top:"0px",right:"20px","font-size":"12px"}).click(function(){
				history.go(-1);
			}).hover(function(){
				$(this).css({"text-decoration":"underline","cursor":"pointer"});
			},function(){
				$(this).css({"text-decoration":"none","cursor":"none"});
			});
		}  
		</script>
  </head>
  
  <body>				   
  	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<div id="gh">
		<div id="ghBar" style="font-size: 15px;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			客户号：<input type="text" class="inputbox" id="ghSearchBox" name="ghSearchBox" /><button class="tsdbutton" id="ghSearchByUserName"><fmt:message key="writeOff.query"/><!-- 查找 --></button>
			<div id="gghh"></div>
			<div id="ggdd"></div>
            <div id="ghxzinfo" style="font-size:14px;color:#000"></div>
			<div id="buttons" style="text-align:center">
				<button id="ghxz" style="width:120px;" disabled><!-- 销帐 --><fmt:message key="Writeoff.write" /></button><button id="ghback" style="width:120px;"><!-- 返回 --><fmt:message key="writeOff.reset"/><!-- 重置 --></button>
			</div>
		</div>
	</div>

	<div id="kd" style="display:none">		
		<div id="kdBar">
			<fmt:message key="writeOff.xzItem"/><!-- 销账项目 -->:
			<select id="chooseForJF">
				
			</select>
			<fmt:message key="writeOff.userNum"/><!-- 用户账号 -->:
			<input type="text" class="inputbox" id="kdSearchBox" name="kdSearchBox" /><button class="tsdbutton" id="kdSearchByUserName"><fmt:message key="writeOff.query"/><!-- 查找 --></button>
			<div id="kkdd"></div>
			
			<div id="buttons" style="text-align:center">
				<button id="kdxz" style="width:120px;" disabled><!-- 销帐 --><fmt:message key="Writeoff.write" /></button><button id="kdback" style="width:120px;"><!-- 返回 --><fmt:message key="writeOff.reset"/><!-- 重置 --></button>
			</div>
		</div>
	</div>
	
	<div class="neirong" id="addKDBzForm" style="display:none;width:680px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="writeOff.addBZ"/><!-- 添加备注 -->
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#addKDBzClose').click();"><fmt:message key="writeOff.close"/><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>

		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:678px;">
			<h2><fmt:message key="writeOff.addWriteBz"/><!-- 添加销账备注信息 --></h2>                <!-- 备注信息最大长度为100个字符 -->
			<textarea id="addKDBzText" style="width:676px; height:100px;" onkeydown="if(this.value.length>100){alert('<fmt:message key="writeOff.BzLengthMax"/>');this.value=this.value.substring(0,100);event.returnValue=false;}"></textarea>
			<br />
		</div>

		<div class="midd_butt" style="width:664px;">
			<button type="button" class="tsdbutton" id="addKDBzAddUnt">
				<fmt:message key="writeOff.saveWriteAndXzf"/><!-- 保存备注并销账费 -->
			</button>
			<button type="button" class="tsdbutton" id="addKDBzClose">
				<fmt:message key="writeOff.close"/><!-- 关闭 -->
			</button>
		</div>
	</div>
	
	<div class="neirong" id="addKDApForm" style="display:none;width:680px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="writeOff.applyAuthorization"/><!-- 申请授权 -->
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#addKDApClose').click();"><fmt:message key="writeOff.close"/><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>

		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:678px;">
			<h2><fmt:message key="writeOff.addWriteBz"/><!-- 添加销账备注信息 --></h2>
			<table align="center" width="60%">
				<tr>
					<td><fmt:message key="writeOff.applyObject"/><!-- 申请对象 -->：</td><td><input type="radio" name="apply_obj" id="apply_obj_bz" /></td><td><label for="apply_obj_bz"><fmt:message key="writeOff.businessCaptain"/><!-- 营业班长 --></label></td><td><input type="radio" name="apply_obj" id="apply_obj_gl" /></td><td><label for="apply_obj_gl"><fmt:message key="Writeoff.telAdmin" /><!-- 管理员 --></label><font color="red">*</font></td>
				</tr>
				<tr>
					<td><fmt:message key="Writeoff.applyRreasons" /><!-- 申请原因 -->：</td><td colspan="4">
						<textarea id="addKDApText" style="width:276px; height:60px;" onkeydown="if(this.value.length>100){alert('申请原因最大长度为100个字符');this.value=this.value.substring(0,100);event.returnValue=false;}"></textarea><font color="red">*</font>
					</td>
				</tr>
			</table>
			<br />
		</div>

		<div class="midd_butt" style="width:664px;">
			<button type="button" class="tsdbutton" id="addKDApAddUnt" onclick="applyAP()">
				<fmt:message key="writeOff.sendAccredit"/><!-- 发送授权申请 -->
			</button>
			<button type="button" class="tsdbutton" id="addKDApClose">
				<fmt:message key="writeOff.close"/><!-- 关闭 -->
			</button>
		</div>
	</div>
	
	
	
	<div class="neirong" id="authcodeForm" style="display:none;width:680px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="writeOff.inputAccredit"/><!-- 填写授权码 -->
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#authcodeFormClose').click();"><fmt:message key="writeOff.close"/><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>

		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:678px;">
			<table align="center" width="40%">
				<tr>
					<td><fmt:message key="writeOff.Accredit"/><!-- 授权码 -->：</td><td><input type="text" name="authcodeTxt" id="authcodeTxt" /></td>
				</tr>
			</table>
			<br />
		</div>

		<div class="midd_butt" style="width:664px;">
			<button type="button" class="tsdbutton" id="authcodeFormUnt" onclick="confirmAuth()">
				<fmt:message key="writeOff.OK"/><!-- 确定 -->
			</button>
			<button type="button" class="tsdbutton" id="authcodeFormClose">
				<fmt:message key="writeOff.close"/><!-- 关闭 -->
			</button>
		</div>
	</div>

	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />
	<input type="hidden" id="uuname" name="uuname" value='<%=session.getAttribute("username") %>' />
  	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="forbid" name="forbid" />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	
	<input type="hidden" id="hidids" />
		
  </body>
</html>
