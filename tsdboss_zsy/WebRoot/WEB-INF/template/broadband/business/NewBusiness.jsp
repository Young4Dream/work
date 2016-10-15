<%-- 
	File Name:  yiji.jsp
    Function:   宽带业务受理（移机）
    Author:     wenxuming
    Date:       2009-01-01
    Description: 宽带修改地址
    Modify:     2010-03-21  
    			2010-12-14：霍帅   打印方法改为通用方法"printThisReport1(...)"
 --%>

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
	String userareaid = (String) session.getAttribute("userarea");
	String depart = (String) session.getAttribute("departname");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<%
	String pmenuname = request.getParameter("pmenuname");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title><fmt:message key="gjh.yidongdizhi" /></title>
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

<!-- 导入css文件结束 -->			
                <style type="text/css">
		#input-Unit .title{ width:100%; height:32px; background:url(style/images/public/kuangbg.jpg); border-bottom:1px solid #C8D8E5;  text-align:left; color:#3C3C3C; }
		</style>
		<!-- 双导航栏异常处理 -->
		<style type="text/css">
			#navBar1 {height: 26px;background: url(style/images/public/daohangbg.jpg);line-height: 28px;}
			
			#yjbaseinfo{margin-left:10px;}
			#yjbaseinfo tr{height:32px;}
			#yjrenzheng{margin-left:10px;}
			#yjrenzheng tr{height:32px;}
			
			.tsdbtn{line-height:28px;padding:2px 12px 2px 12px;  height:28px; margin-top:4px; margin-left:5px; background: url(style/images/public/buttonbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer; }

			cas {float: left;width: 100%;height: 26px;background: url(style/images/public/daohangbg.jpg) repeat-x;line-height: 28px;}
		</style>
		<style type="text/css">
			.button {width: 50px;height: 25px;background: url(style/images/public/buttonbg.jpg) repeat-x;border: #CCCCCC 1px solid;cursor: pointer;
				float: left; *float: none;border-top: #CCCCCC 1px solid;border-bottom: #CCCCCC 1px solid;}
		body {text-align: left}
		.neirong .midd #grid table{line-height:18px;}
		.neirong .midd #queryHTHdw tr{line-height:18px;}
		</style>
     <script language="javascript">
		function printReportV(reportName,params)
			{
				$("#p_i_f").attr("src","print.jsp"+"?report="+reportName+"&params="+params);				
			}
        </script>
        <script type="text/javascript">
		/******************************************
			**  查看当前用户的扩展权限，对spower字段进行解析 *
			*****************************************/
				function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'newbusiness.xuanxian',//存储过程的映射名称
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
				var checkright='';
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
						checkright='true';
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
							
							checkright += getCaption(spowerarr[i],'check','')+'|';
							
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
				var hascheck = checkright.split('|');
				var str = 'true';
				
				if(flag==true){
					$("#addright").val(addright);
					$("#addBright").val(addBright);
					$("#deleteright").val(deleteright);
					$("#delBright").val(delBright);
					$("#editright").val(editright);
					$("#editBright").val(editright);
					$("#checkright").val(checkright);
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
					for(var i = 0;i<hascheck.length;i++){
						if(hascheck[i]=='true'){
							$("#checkright").val(str);
							break;
						}
					}
				}
				
				//隐藏域赋值 设置是否可以不选
				$("#ableForNoChoose").val(ableForNoChoose?"true":"false");
				
			}
		</script> 
		<script type="text/javascript">
	    $(function(){
	            var languageType = $("#languageType").val();
    	        brodbandinter(languageType);//页面字段国际化
    	        
	            jiesuo();
				$("#navBar").append(genNavv());	
				getUserPower();	
				var checkright = $("#checkright").val();
				if(checkright=="true"){
			     $("#zafeilist").attr("disabled","");
			    } 
				queryFeename();
				
				//隐藏取消新业务模块
				$("#addise").hide();			
				$("#addspe").hide();
				$("#quxiaotitle").hide();		 				 					
			});
		
		  function jiesuo(){
	        $(window).unload(function(){
			kdunLock();
			    });
		    }
		
		  /////////////////////////////////////////////////////////////////
	      // 查询用户数据 
	      /////////////////////////////////////////////////////////////////
		 function QueryObj(params){		

		 if(params==false){return false;}
		 var urlstr=tsd.buildParams({ packgname:'service',//java包
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
										queryFeename();				
										alert('<fmt:message key="gjh.usernot"/>');
										$("#iiFeeType").attr("disabled","disabled");
										
					                 }	
							else{
							$("#quxiaotable").show();
							//每次重新载入时情况以前的数据
							clearText("form1");
							addsvaluesto="";
							Speedfeeto="";	
							amemoto="";
							smemoto="";
							$("#closesave").attr("disabled","disabled");
							$("#addiSimultaneous").empty();
							$("#addspeediFeetype").empty();
							$("#addspeedif").empty();
							$("#addiSim").empty();
							isnotifurgent();//得到是否紧急
							$("#jobmemo").removeAttr("disabled"); 
							iSimultaneoustype()//查出数据后得到增加同时在线数下拉单
						    var id = $(this).attr("id");												
							$("#id").val(id);															
					     	var PauseStartTime = $(this).attr("pausestarttime");		//隐藏字段					     															
							$("#PauseStartTime").val(PauseStartTime);
					        var PauseStopTime = $(this).attr("pausestoptime");		//隐藏字段																
							$("#PauseStopTime").val(PauseStopTime);
					        var AcctStartMonth = $(this).attr("acctstartmonth");		//隐藏字段																
							$("#AcctStartMonth").val(AcctStartMonth);
					        var AcctEndMonth = $(this).attr("acctendmonth");		//隐藏字段																
							$("#AcctEndMonth").val(AcctEndMonth);			
					        var PauseStartMonth = $(this).attr("pausestartmonth");		//隐藏字段																
							$("#PauseStartMonth").val(PauseStartMonth);			
					        var PauseEndMonth = $(this).attr("pauseendmonth");		//隐藏字段																
							$("#PauseEndMonth").val(PauseEndMonth);			
					        var UserID = $(this).attr("userid");		//隐藏字段
					        $("#UserID").val(UserID);
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
							$("#feeendtime").val(feeendtime);				
					        var iFeeTypeTime = $(this).attr("ifeetypetime");		//隐藏字段																
							$("#iFeeTypeTime").val(iFeeTypeTime);					
					        var iFeeType1 = $(this).attr("ifeetype1");		//隐藏字段																
							$("#iFeeType1").val(iFeeType1);				
					      	var iFeeTypeS = $(this).attr("ifeetypeS");		//隐藏字段																
							$("#iFeeTypeS").val(iFeeTypeS);				
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
							var ipaddr = $(this).attr("ipaddr");
							$("#ipaddr").val(ipaddr);
							var vlanid = $(this).attr("vlanid");
							$("#vlanid").val(vlanid);
							var linkman = $(this).attr("linkman");
							$("#linkman").val(linkman);	//联系人
							var linkphone = $(this).attr("linkphone");
							$("#linkphone").val(linkphone);		//联系电话	
							var AcctStartTime = $(this).attr("acctstarttime");
							$("#AcctStartTime").val(AcctStartTime);
							var AcctStopTime = $(this).attr("acctstoptime");
							$("#AcctStopTime").val(AcctStopTime);
							var RemainFee = $(this).attr("remainfee");
							$("#RemainFee").val(RemainFee);									
							var PayType = $(this).attr("paytype");
							if(PayType>=10){
							//外部用户
							$("#PayType").val("<fmt:message key="gjh.externaluser"/>");
							}
							if(PayType==0){
							//免费用户
							$("#PayType").val("<fmt:message key="gjh.freeusers"/>");
							}
							if(PayType==1){
							//<!-- 后付用户 -->
							$("#PayType").val("<fmt:message key="gjh.hfusers"/>");
							}
							if(PayType==2){
							//<!-- 预付用户 -->
							$("#PayType").val("<fmt:message key="gjh.yufuusers"/>");
							}
							
							var iFeeType = $(this).attr("ifeetype");
							
							var sDh1 = $(this).attr("sdh1");
							if(sDh1==3){
							  //商用用户
							  $("#sDh1").val("商用用户");
							}else if(sDh1==2){
							  //公费用户
							  $("#sDh1").val("<fmt:message key="gjh.gfyh" />");
							  isnotattachfeeise(UserName);//判断是否办理了增加同时在现实新业务
							  isnotattachfeespeed(UserName);//判断是否办理了带宽提速新业务
							  closefeespeed(UserName);//判断是否取消了带宽提速新业务	
							  closefeeise(UserName);//判断是否取消了增加同时在现实新业务
							  alert("该用户办理带宽提速后将不能办理申请停机业务！");	
							}else if(sDh1==1){
							  //私费用户
							  $("#sDh1").val("<fmt:message key="gjh.PrivatelyUsers" />");							  
							  $("#addspeediFeetype").hide();
							  alert("该用户为私费用户，不能办理宽带提速，只能办理增加同时在线数");
							}else{
							   sDh1 = UserTypequery(sDh1);
							   $("#sDh1").val(sDh1);
							}
							
							/////////////////根据档案表里的iFeeType的值去查询费率表里的FeeCode字段对应的FeeName值//////////////////////													
							var isitype="";
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
					              url:'mainServlet.html?'+urlstr+'&FeeCode='+iFeeType,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					                 $(xml).find('row').each(function(){	
								     var feename=$(this).attr("feename");
								     var BaseFee = $(this).attr("basefee");
								     isitype = $(this).attr("itype");
								     
								     addspeediFeeType(BaseFee,sDh1)//得到带宽提速计费规则列表进行选择
								     $("#BaseFee").val(BaseFee);
								     $("#iFeeType").val(feename);							  								 
							         });
							      }
							});																					
							var sDh = $(this).attr("sdh");
							$("#sDh").val(sDh);											
							var sRegDate = $(this).attr("sregdate");
							$("#sRegDate").val(sRegDate);
							var sRealName = $(this).attr("srealname");
							$("#sRealName").val(sRealName);							
							var curFee =RemainFee-Fee5;	
							$("#curFee").val(curFee);							
							var sBm = $(this).attr("sbm");
							$("#sBm").val(sBm);
							var sBm2 = $(this).attr("sbm2");
							$("#sBm2").val(sBm2);
							var sBm3 = $(this).attr("sbm3");
							$("#sBm3").val(sBm3);
							var sBm4 = $(this).attr("sbm4");
							$("#sBm4").val(sBm4);
							var sAddress = $(this).attr("saddress");
							$("#sAddress").val(sAddress);
							var iStatus = $(this).attr("istatus");
							if(iStatus==0){
							//正常
							 var params=quereyshiftj(UserName);
							  if(params>0){
							    $("#iStatus").val("申请停机");
							  }else{
							    $("#iStatus").val("<fmt:message key="yiji.zc"/>");
							  }
							}
							if(iStatus==1){
							//锁定
							$("#iStatus").val("<fmt:message key="gjh.lock"/>");
							}
							if(iStatus==2){
							//停机保号
							$("#iStatus").val("欠费");
							}							
							$("#getiStatus").val(iStatus);
							var iMacAutoBand = $(this).attr("imacautoband");
							$("#iMacAutoBand").val(iMacAutoBand);
							var iSimultaneous = $(this).attr("isimultaneous");
							$("#iSimultaneous").val(iSimultaneous);
							var speed = $(this).attr("speed");
							$("#speed1").val(speed);//放到隐藏域中，掉过程时调用
							var speedzh = calBSpeed(speed);//带宽格式转换	
							$("#speed").val(speedzh);
							var autopay = $(this).attr("autopay");
							$("#autopay").val(autopay);							
							//var sDh2 = $(this).attr("sDh2");
							//$("#sDh2").val(sDh2);
							var UserName1 = $(this).attr("username1");
							$("#UserName1").val(UserName1);
							var UserName2 = $(this).attr("username2");
							$("#UserName2").val(UserName2);
							var idtype = $(this).attr("idtype");
							if(idtype==1){$("#idtype").val("教职工");}
							if(idtype==2){$("#idtype").val("本科生");}
							if(idtype==3){$("#idtype").val("研究生");}
							if(idtype==4){$("#idtype").val("离退休");}
							if(idtype==5){$("#idtype").val("护照");}
							if(idtype==6){$("#idtype").val("军官证");}
							if(idtype==7){$("#idtype").val("身份证");}
							if(idtype==8){$("#idtype").val("其它");}
							var idcard = $(this).attr("idcard");
							$("#idcard").val(idcard);
							var mobile = $(this).attr("mobile");
							$("#mobile").val(mobile);						
							$("#form1").css("display","block");	//展开表单							
							//每次查询后重新加载杂费项和杂费金额
							$("#closesave").removeAttr("disabled");
							queryFeename();
							//判断是否为计时用户，如果为计时用户不能办理新业务
							if(isitype=='3'){
							   alert("计时用户不能办理新业务！");
							   clearText("form1");
							   queryFeename();
							   $("#kdSearchBox").focus();
							   isitype="";
							   return false;
							}
							//关闭弹出查询groud面板
							setTimeout($.unblockUI,10);
							$("#payitem").removeAttr("disabled");
						   }});
					}
				});
	      }	      	     
		 
		 //查看用户是否办理新业务增加同时在线数
		 function isnotattachfeeise(UserName){
		     var feename = 'addSimultaneous';
		     var urlstr=tsd.buildParams({packgname:'service',//java包
						 				 clsname:'ExecuteSql',//类名
						 				 method:'exeSqlData',//方法名
						 				 ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				 tsdcf:'mysql',//指向配置文件名称
						 				 tsdoper:'query',//操作类型 
						 				 datatype:'xmlattr',
						 				 tsdpk:'newbusiness.isnotnewbusi'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&UserName="+UserName+"&FeeName="+feename,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					    $(xml).find('row').each(function(){
					     var uname = $(this).attr("username");					     
					       if(uname!=undefined){
					         var Memo = $(this).attr("memo");
					         var BeginDate = $(this).attr("begindate");				         
					         var getdate = getDate(BeginDate);
					         if(getdate==0){
					         	$("#addSimultaneousnot").text("★.当月你已经办理了增加同时在线数业务，不能再次办理，只能办理取消该业务！");
					         	$("#addiSimultaneous").attr("disabled","disabled")
					         }else{
					         	$("#addSimultaneousnot").empty();
					         	$("#addiSimultaneous").removeAttr("disabled")
					         }
					         $("#MemoiSe").text(Memo);
					         $("#quxiaotitle").show();
					         $("#addise").show();							
					       }else{
					       	 $("#addSimultaneousnot").empty();
					       	 $("#addiSimultaneous").removeAttr("disabled")
					         $("#MemoiSe").empty();
					         $("#addise").hide();
					       }
					    });
					}
			  });				 				
		 } 
		 //查看用户是否办理新业务带宽提速
		 function isnotattachfeespeed(UserName){
		     var feename = 'addSpeed';
		     var urlstr=tsd.buildParams({packgname:'service',//java包
						 				 clsname:'ExecuteSql',//类名
						 				 method:'exeSqlData',//方法名
						 				 ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				 tsdcf:'mysql',//指向配置文件名称
						 				 tsdoper:'query',//操作类型 
						 				 datatype:'xmlattr',
						 				 tsdpk:'newbusiness.isnotnewbusi'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&UserName="+UserName+"&FeeName="+feename,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					    $(xml).find('row').each(function(){
					     var uname = $(this).attr("username");
					       if(uname!=undefined){
					         var Memo = $(this).attr("memo");
					         $("#Memospeed").text(Memo);
					         $("#quxiaotitle").show();
					         $("#addspe").show();
					         var BeginDate = $(this).attr("begindate");
					         var EndDate = $(this).attr("enddate");				         
					         var getdate = getDate(BeginDate);
					         if(getdate==0){
					         	$("#addSpeednot").text("★.当月你已经办理了带宽提速业务，不能再次办理，只能办理取消该业务！");
					         	$("#addspeediFeetype").attr("disabled","disabled");
					         }else{
					         	$("#addspeediFeetype").removeAttr("disabled");
					         	$("#addSpeednot").empty();					         	
					         }
					         var getEnddate = getDate(EndDate);
					         if(getEnddate==0){
					         	$("#colosaddSpeednot").text("★.当月你已经取消了带宽提速业务，不能再次办理！");
					         	$("#Cancelspeed").attr("disabled","disabled");
					         }else{
					         	$("#colosaddSpeednot").empty();
					         	$("#Cancelspeed").removeAttr("disabled");
					         }
					       }else{
					         $("#addspeediFeetype").removeAttr("disabled");
					       	 $("#addSpeednot").empty();					         
					         $("#Memospeed").empty();
					         $("#addspe").hide();
					         $("#colosaddSpeednot").empty();
					         $("#Cancelspeed").removeAttr("disabled");					         
					       }
					    });
					}
			  });				 				
		 }    
		 
		 //查看用户是否取消新业务带宽提速
		 function closefeespeed(UserName){
		     var feename = 'addSpeed';
		     var urlstr=tsd.buildParams({packgname:'service',//java包
						 				 clsname:'ExecuteSql',//类名
						 				 method:'exeSqlData',//方法名
						 				 ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				 tsdcf:'mysql',//指向配置文件名称
						 				 tsdoper:'query',//操作类型 
						 				 datatype:'xmlattr',
						 				 tsdpk:'newbusiness.closenewbusi'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&UserName="+UserName+"&FeeName="+feename,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					    $(xml).find('row').each(function(){
					     var uname = $(this).attr("username");
					       if(uname!=undefined){
					         var Memo = $(this).attr("memo");
					         $("#Memospeed").text(Memo);
					         $("#quxiaotitle").show();
					         $("#addspe").show();
					         var BeginDate = $(this).attr("begindate");
					         var EndDate = $(this).attr("enddate");
					         var getEnddate = getDate(EndDate);					         
					         if(getEnddate==0){
					         	$("#colosaddSpeednot").text("★.当月你已经取消了带宽提速业务，不能再次办理！");
					         	$("#Cancelspeed").attr("disabled","disabled");
					         	$("#addspeediFeetype").attr("disabled","disabled");
					         	$("#addspe").hide();
					         }else{
					         	$("#colosaddSpeednot").empty();					         	
					         	$("#Cancelspeed").removeAttr("disabled");
					         	$("#addiSimultaneous").removeAttr("disabled");
					         	$("#addspeediFeetype").removeAttr("disabled");					         	
					         }
					       }else{
					            $("#colosaddSpeednot").empty();
					            $("#Cancelspeed").removeAttr("disabled");				         	
					       }
					    });
					}
			  });				 				
		 }
		 
		 //查看用户是否取消新业务增加同时在线数
		 function closefeeise(UserName){
		     var feename = 'addSimultaneous';
		     var urlstr=tsd.buildParams({packgname:'service',//java包
						 				 clsname:'ExecuteSql',//类名
						 				 method:'exeSqlData',//方法名
						 				 ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				 tsdcf:'mysql',//指向配置文件名称
						 				 tsdoper:'query',//操作类型 
						 				 datatype:'xmlattr',
						 				 tsdpk:'newbusiness.closenewbusi'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&UserName="+UserName+"&FeeName="+feename,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					    $(xml).find('row').each(function(){
					     var uname = $(this).attr("username");					     
					       if(uname!=undefined){
					         var Memo = $(this).attr("memo");
					         var EndDate = $(this).attr("enddate");
					         var getEnddate = getDate(EndDate);
					         if(getEnddate==0){
					         	$("#colosaddSimultaneousnot").text("★.当月你已经取消了增加同时在线数业务，不能再次办理！");
					         	$("#Cancelise").attr("disabled","disabled");
					         	$("#addiSimultaneous").attr("disabled","disabled");
					         	$("#addise").hide();
					         }else{
					         	$("#colosaddSimultaneousnot").empty();
					         	$("#Cancelise").removeAttr("disabled");
					         	$("#addiSimultaneous").removeAttr("disabled");
					         	$("#addspeediFeetype").removeAttr("disabled");					         	
					         }							
					       }else{
					       	 $("#colosaddSimultaneousnot").empty();
					         $("#Cancelise").removeAttr("disabled");
					       }
					    });
					}
			  });				 				
		 }
		  
		 	
		 /////////////////////////////////////////////////////////////////
	     // 查询下拉列表--计费规则
	     /////////////////////////////////////////////////////////////////	
		 function addspeediFeeType(BaseFee,usertype){
		  var ify="";
	      var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'newbusiness.addspeedifeetype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});			 							
			$.ajax({
					url:'mainServlet.html?'+urlstr+"&basefee="+BaseFee+"&usertype="+usertype,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					            ify="";
					            $("#addspeediFeetype").empty();
					            $("#addspeediFeetype").append("<tr><td><center>选择</center></td><td><center>编号</center></td><td><center>带宽提速计费规则</center></td></tr>");
								$(xml).find('row').each(function(){
								var feecode = $(this).attr("feecode");
								var feename = $(this).attr("feename");
								var ispeed = $(this).attr("speed");
								if(feecode!=undefined){					
								ify += "<tr>";
								ify += "<td><center><input type='radio' name='itemto' id='itemto' onclick='iFeetypeSJ("+ispeed+","+feecode+")' style=\"width:30\"/></center></td>";
								//<input type='checkbox' name='checkbox1' id='ck' onclick='javascript:iFeetypeSJ("+feecode+")' value='"+feecode+"' style='width:15px; height:15px; border:0px;float:rith; line-height:'/>
								ify += "<td width=\"40\"><center>";
								ify += $(this).attr("feecode");
								ify += "</center></td>";
								ify += "<td width=\"200\"><center>";
								ify += $(this).attr("feename");
								ify += "</center></td>";
								ify += "<tr>";
								}else{
								  ify="<tr><td>没有可提升的计费规则！！！</td></tr>"
								}													
							});							
							$("#addspeediFeetype").append(ify);
						}
					});
		   }	
		 
		 var Speedfeeto="";//带宽提速费用
		 var smemoto="";//带宽提速备注
		 function iFeetypeSJ(paramsto,paramss){	
		    var QJiFeeType="";	    
		    var ifeetype = $("#iFeeType").val();
		    var BaseFee = $("#BaseFee").val();
		    //$('#divto3 [name="itemto"][checked=true]:radio').val();
		    var addspeedBaseFee="";
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
					              url:'mainServlet.html?'+urlstr+'&FeeCode='+paramss,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					                 QJiFeeType="";
					                 $(xml).find('row').each(function(){	
								     var feename=$(this).attr("feename");
								     addspeedBaseFee = $(this).attr("basefee");
								     var speed_iag = $(this).attr("speed_iag");
								    
								     if(confirm("确定将计费规则["+ifeetype+"]提升为["+feename+"]吗？")){				
									    //$(":checkbox[name='checkbox1']").removeAttr("checked");
									    $("#addspeediFeeType").val(feename);									   		   
									    var speedold = $("#speed1").val();								    					    
										if(speedold.indexOf("pppoe")==0){																			
								          var speedzh = calBSpeed(speed_iag);				
								          $("#addspeed").val(speedzh);
									      $("#addspeed1").val(speed_iag);
									      QJiFeeType=speedzh;
									    }else{								    		
									         $("#addspeed").val(calBSpeed(paramsto));									       
									         $("#addspeed1").val(paramsto);
									         QJiFeeType=calBSpeed(paramsto);
										}									
										smemoto="带宽由"+ifeetype+"提升为"+QJiFeeType+"";	
									    Speedfeeto = parseInt(addspeedBaseFee,10) - parseInt(BaseFee,10);
									    $("#addspeedif").text("带宽由"+ifeetype+"提升为"+QJiFeeType+"需要每月收取带宽提速费用"+Speedfeeto+"元!");
									    }else{
									     $("[name='itemto']:radio").each(function(){   
									          this.checked = false;									       
									       });
									     $("#addspeed").val("");
									     $("#addspeed1").val("");
									     smemoto='';
									     Speedfeeto='';
									     $("#addspeediFeeType").val("");
									     $("#addspeedif").empty();
									    }								  								 
							         });
							      }
							});			
		 } 
		 
		 
		  /////////////////////////////////////////////////////////// 
		  //从配置表里取到同时在线数的下拉值
		  ///////////////////////////////////////////////////////////
		  var sim="";
		  function iSimultaneoustype(){
		  var systemtype='broadbandsetup';//代表的系统项
		  var propertytype='iSimultaneous';//属性值
	      var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.tblconfit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});				 							
			$.ajax({
					url:'mainServlet.html?'+urlstr+'&ssection='+systemtype+'&sltem='+propertytype,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					            sim="";
					            $("#addiSimultaneous").empty();
								///////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
								$("#addiSimultaneous").html("<option value='' selected=true>请选择</option>");
								$(xml).find('row').each(function(){
								//////////给下拉框进行赋值操作、5
								var svalue = $(this).attr("svalue");
								  for(i=1;i<=svalue;i++){				
								     var ee="<option value='"+i+"'>"+i+"</option>";
								     sim=sim+ee;  
								  }																	
							});					
						    $("#addiSimultaneous").html($("#addiSimultaneous").html()+sim);
						}
					});
				}
		
		var amemoto="";//增加的同时在线数备注		
		function addSimultaneous(){
		   var isimultaneous = $("#iSimultaneous").val();
		   var addiSimultaneous =　$("#addiSimultaneous").val();
		   if(isimultaneous==addiSimultaneous)
		   {
			   alert("同时在线数没有更改！");
			   $("#addiSimultaneous").val("");
			   $("#addiSim").empty();
			   addsvaluesto="";
			   amemoto="";
			   return false;
		   }
		   else if (isimultaneous>addiSimultaneous)
		   {
			   if(confirm("确定将同时在线数["+isimultaneous+"]变更为["+addiSimultaneous+"]吗？"))
			   {
			      amemoto="同时在线数由"+isimultaneous+"变更为"+addiSimultaneous+"";
			      chooseiSimultaneous();		      
			      $("#addiSim").text("同时在线数由["+isimultaneous+"]变更为["+addiSimultaneous+"]每月无需收取增加同时在线数费用!");
			   }
		   }else
		   {
		   	   if(confirm("确定将同时在线数["+isimultaneous+"]增加为["+addiSimultaneous+"]吗？"))
			   {
			      amemoto="同时在线数由"+isimultaneous+"增加为"+addiSimultaneous+"";
			      chooseiSimultaneous();		      
			      $("#addiSim").text("同时在线数由["+isimultaneous+"]增加为["+addiSimultaneous+"]每月收取增加同时在线数费用["+addsvaluesto+"]元!");
			   }
		   }
		}
				
		var addsvaluesto="";//取出增加后的同时在线数费用		
        function chooseiSimultaneous(){         
         var ssection = 'newfee';
         var sltem ='add a Simultaneous';
         var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.tblconfit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});	
			$.ajax({
					url:'mainServlet.html?'+urlstr+"&ssection="+ssection+"&sltem="+sltem,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					     var svalueSim="";
					     var svalues ="";
					     addsvaluesto="";
					     $(xml).find('row').each(function(){
					      svalueSim = $(this).attr("svalue");
					     });
					    var addSimultaneous = $("#addiSimultaneous").val();
					    var addSim = parseInt(addSimultaneous,10);
					    for(i=1;i<addSim;i++){
					       svalues = svalueSim*i;
					    }
					    
					    addsvaluesto=(svalues==""?"0":svalues);
					  }  
				  });			   	  		 			
         }	
        
        //取消业务办理
        function cancelise(busitype){
             var username = $("#UserName").val();
             if(confirm("你确定取消该业务吗？")){
        	 var urlstr=tsd.buildParams({packgname:'service',
									 	 clsname:'Procedure',
										 method:'exequery',
									  	 ds:'broadband',//数据源名称 对应的spring配置的数据源
									     tsdpname:'newbusiness.radnewfunction',//存储过程的映射名称
									 	 tsdExeType:'query',
									 	 datatype:'xmlattr',
									 	 tsdUserId:'true'
									 });		 
							$.ajax({
								url:'mainServlet.html?'+urlstr+"&businetype="+busitype+"&username="+username,
								datatype:'xml',
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(xml){
									$(xml).find('row').each(function(){
										var res = $(this).attr("result");
										if(res==1){
									       QueryObj("&UserName="+username);
									       alert("增加同时在线数业务已经取消！！！");
									    }else if(res==2){
									       QueryObj("&UserName="+username);
									       alert("带宽提速业务已经取消！！！");
									    }	
									});									
								}
							});
			}					
        }
      
        //数据提交后进行保存
        function save(){
            
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
						//
						return false;
					}
				}
			}
          
            var userid = $("#userid").val();
            var area = $("#area").val();
            var depart = $("#depart").val();
            var username = $("#UserName").val();
            var iSimultaneous = $("#addiSimultaneous").val();
            if(iSimultaneous==""){
               iSimultaneous = $("#iSimultaneous").val();
            }
            var feei = $("#feei").val();
            var addspeediFeeType = $("#addspeediFeeType").val();
            var speed = $("#speed1").val();
            var addspeed = $("#addspeed1").val();
            //付费方式
			var payitem = $("#payitem").val();
			if(payitem==null){payitem='';}
			payitem=payitem.replace(/(^\s*)|(\s*$)/g,"");
			var ispay;//是否付费（Y/N）
			//根据付费方式来判断是否付费的类型
			if(payitem=='cash'){
				  ispay='Y';
				  $("#transferHTH").val("");
			}else if(payitem=='transfer'){
				  ispay='N';
			}else{
			   ispay='';
			}				 	
				 	
			var zzhth = $("#transferHTH").val();
			if(payitem=='transfer'&&zzhth==""){
			   alert("<fmt:message key="broadband.zzhthnotnull"/>");
				  return false;
			}
            if(iSimultaneous==""&&addspeediFeeType==""){
               alert("您没有办理业务，请选择业务办理！");
               $("#kdSearchBox").focus();
               return false;
            }
            var ifurgent = $("#ifurgent").val();
	        var jobmemo = $("#jobmemo").val();
	        jobmemo=jobmemo.replace(/(^\s*)|(\s*$)/g,"");
	        var pat=/[@#\$%\^&\*]+/g; 
			        if(pat.test(jobmemo)) 
			        { 
			         alert("<fmt:message key="broadband.srdbzzbnyffzf"/>"); 
			         $("#jobmemo").select();
			         $("#jobmemo").focus();
			         return false; 
			        }
            paymode = tsd.encodeURIComponent(payitem);
			ispay = tsd.encodeURIComponent(ispay);
			hth = tsd.encodeURIComponent(zzhth);
			ifurgent = tsd.encodeURIComponent(ifurgent);
		    jobmemo = tsd.encodeURIComponent(jobmemo);
            if(confirm("确定办理该新业务吗？","操作提示")){
            var urlstr=tsd.buildParams({ packgname:'service',
									 	 clsname:'Procedure',
										 method:'exequery',
									  	 ds:'broadband',//数据源名称 对应的spring配置的数据源
									     tsdpname:'newbusiness.radnewfunction',//存储过程的映射名称
									 	 tsdExeType:'query',
									 	 datatype:'xmlattr',
									 	 tsdUserId:'true'
									 });		 
							$.ajax({
								url:'mainServlet.html?'+urlstr+"&zfee="+feei+"&userid="+userid+"&area="+tsd.encodeURIComponent(area)+"&depart="+tsd.encodeURIComponent(depart)+"&username="+username+"&afee="+addsvaluesto+"&sfee="+Speedfeeto+"&ameno="+tsd.encodeURIComponent(amemoto)+"&smemo="+tsd.encodeURIComponent(smemoto)+"&iSimultaneous="+iSimultaneous+"&prespeed="+speed+"&speedadd="+addspeed+"&feename="+queryFeeInfo()+"&paymode="+paymode+"&ispay="+ispay+"&hth="+hth+"&ifurgent="+ifurgent+"&descrpt="+jobmemo+"&sbusinetype="+"openbusi",
								datatype:'xml',
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(xml){
									$(xml).find('row').each(function(){
									  var result = $(this).attr("result");
									  if(result!=0){
									     var payitem = $("#payitem").val();//得到数据加载到隐藏域中
										 $("#payitemYCY").val(payitem);
									  
									     $("#jobidid").val(result);
									     $("#printfeeee").val(feei);
									     
									     $.ajax({
											    url:'jobcode.html?'+"&telJobType="+'newfunction'+"&docId="+result+"&userid="+$("#userid").val()+"&transitionName=",
											    datatype:'xml',
											    cache:false,//如果值变化可能性比较大 一定要将缓存设成false
											    timeout: 1000,
											    async: false ,//同步方式
											    success:function(xml){}
											    });
									     
									     //打印报表
					                     autoBlockForm("choosePrintJob","150","close","#FFFFFF",false);
					                     
					                      //插入日志
					                     var loginfo = "";
									     loginfo += tsd.encodeURIComponent("表:");
									     loginfo += "radjob";
										 loginfo += tsd.encodeURIComponent("操作员:");
										 loginfo += userid;
										 loginfo += ";";
										 loginfo += tsd.encodeURIComponent("受理地点:");
										 loginfo += tsd.encodeURIComponent(area);
										 loginfo += ";";
										 loginfo += tsd.encodeURIComponent("用户帐号:");
										 loginfo += username;
										 loginfo += ";";
										 loginfo += tsd.encodeURIComponent("增加同时在线数:");
										 loginfo += iSimultaneous;
										 loginfo += ";";
										 loginfo += tsd.encodeURIComponent("带宽提速计费规则:");
										 loginfo += tsd.encodeURIComponent(addspeediFeeType);
										 loginfo += ";";
										  
										 writeLogInfo("","add",loginfo);
					                      
									     addsvaluesto="";
									     Speedfeeto="";	
									     amemoto="";
									     smemoto="";								  
									     clearText("form1");
									     $("#jobmemo").attr("disabled","disabled"); 
									     $("#kdSearchBox").val("");
									     $("#kdSearchBox").focus();
									     $("#closesave").attr("disabled","disabled");
									     $("#addiSimultaneous").empty();
									     $("#addspeediFeetype").empty();
									     $("#addspeedif").empty();
			                             $("#addiSim").empty();	
			                             $("#ifurgent").empty();
			 	                         $("#jobmemo").val("");
			                             queryFeename();
			                             kdunLock();//解锁用户
			                             $("#addSimultaneousnot").empty();
			                             $("#addSpeednot").empty();
			                             $("[name='itemto']:radio").each(function(){   
									        this.checked = false;									       
									     });
									     $("#quxiaotable").hide();  
									     $("#colosaddSimultaneousnot").empty();
									     $("#colosaddSpeednot").empty();	
									  }else{
									    alert("操作失败！");
									    return false;
									  }
									})
								}
							});	
				}else{
				  $("#kdSearchBox").focus();
				}				
         }
         
         function xuxiao(){
            clearText("form1");
			$("#kdSearchBox").val("");
			$("#kdSearchBox").focus();
			$("#closesave").attr("disabled","disabled");
			$("#addiSimultaneous").empty();
			$("#addspeediFeetype").empty();
			$("#addspeedif").empty();
			$("#addiSim").empty();
			$("#MemoiSe").empty();
			$("#Memospeed").empty();
			$("#quxiaotable").hide();
			addsvaluesto="";
			Speedfeeto="";	
			amemoto="";
			smemoto="";	
			queryFeename();
			kdunLock();//解锁用户
			$("#transferHTH").val(""); 
			$("#transferHTHbox").attr("checked","");
			$("#transferHTHbox").attr("disabled","disabled");
			$("#addSimultaneousnot").empty();
			$("#addSpeednot").empty();
			$("#itemto").removeAttr("disabled");
         }
         
         
         //从配置表里取到用户类型
		  function UserTypequery(sDh1){
		  var UserType;
		  var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 				clsname:'ExecuteSql',//类名
						 				method:'exeSqlData',//方法名
						 				ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				tsdcf:'mysql',//指向配置文件名称
						 				tsdoper:'query',//操作类型 
						 				datatype:'xmlattr',
						 				tsdpk:'telJobbroadband.usertype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 			});				 							
			$.ajax({
					url:'mainServlet.html?'+urlstr+"&TypeID="+sDh1,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
								///////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
								$(xml).find('row').each(function(){								
								UserType = $(this).attr("usertype");														
							});					
						}
					});
				return UserType;	
			}	  
	</script>
    <script type="text/javascript">
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
                 kdunLock();//解锁用户
                 var param=feeendtimeUser(UserName);
                 if(param>0){
                    alert("该用户未完工，暂不能办理此业务！");
                    return false;
                 }
                 
                 var par=isnotnewbusi(UserName);      
                 if(par==1){
                    alert("该用户已经办理了套餐业务["+packagenameto+"],不能在办理新业务业务！");
                    return;
                 }
                if(kdLock(UserName)==true){
				QueryObj("&UserName="+UserName);
				$("#kdSearchBox").val(UserName);
				$("#kdSearchWay").css("visibility","visible");
				}				
             }

            //判断工单是否完工
            function feeendtimeUser(UserName){
              var result;
                var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'feeendtime.shifouwangong'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
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
            
            //根据用户帐号，得到用户类型
            function getusertype(UserName){
                var res = fetchMultiArrayValue("broadband.getusertype",0,"&username="+tsd.encodeURIComponent(UserName));
                if(res==""){
                   return "";
                }else{
                   return res[0][0];
                }
            }

            //判断该用户是否办理了套餐业务，如果办理了就无法办理申请停机
	        var packagenameto="";//套餐业务全局	
	        function isnotnewbusi(UserName){
	        var res = "";
	        var usertype = getusertype(UserName);
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
								url:'mainServlet.html?'+urlstr+"&busiclass="+'broadband'+"&nubmer="+UserName+"&busitype="+'newfunction'+"&usertype="+usertype,
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

				//alert(param);
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
					//alert(temp);
					temp = temp.replace(",","");
					
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
        		if(parseFloat($("#printfeeee").val(),10)!=0&&$("#payitemYCY").val()!='transfer')
        		{
        			setTimeout(autoBlockForm("choosePrint","150","close","#FFFFFF",false),15);
        			$("#payitemYCY").val("");
        		}
        		else
        		{
        			setTimeout($.unblockUI,1);
        			$("#payitemYCY").val("");
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
        			printWithoutPreview("broadband_sf",params);;
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
					              url:'mainServlet.html?'+urlstr+'&bname='+tsd.encodeURIComponent('newfunction'),
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
								      var checkBox="<div style='width:50%;text-align:left; height:25px; float:left;'><input type='checkbox' onClick='feecheck()' style='width:25;height=25' name='checkbox' value='"+strs+"' style='width:15px; height:15px; border:0px;float:left; line-height:'/><span style='line-height:25px; padding-left:5px; float:left;'>"+strs+"</span></div>";
				                      $("#zafeilist").html($("#zafeilist").html()+checkBox);
				                      ifnotpayitem(strs);
				                      $("#payitem").attr("disabled","disabled");
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
								  //初始化时查询费用项queryAllfeiy(ids);
								  }
								  //$("checkbox").remove();
							      });
							      }
							});							
		}	   
		
		//查询宽带费用合计
		var zfxfeename="";
		function queryAllfeiy(ids){
		if(ids==""){ids="''";}
		if(ids!=undefined){
		    zfxfeename=ids.replace(new RegExp("'","g"),"");
		    zfxfeename=zfxfeename.replace(new RegExp(",","g"),"~");
		    
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
          var ids="";
         for (i=0;i<objarray;i++)
          {
              if(str[i].checked == true)
                {
                chestr=str[i].value;
               
                chestrto += "'"+tsd.encodeURIComponent(chestr)+"',";
			    ids =chestrto.substr(0,chestrto.length-1);
		       }else{
		        $("#feei").val("0");
		       }
           }
           queryAllfeiy(ids);
        }
        
           //锁定账号 true可办理 false 不可办理
			function kdLock(UserName)
			{
			var rel = fetchSingleValue("processingdistory.queryuseridname",6,"&userid="+$("#userid").val());
			var res = fetchMultiPValue("kd.Lock",0,"&userid="+$("#userid").val()+"&account="+UserName+"&businesstype=newfunction&flag=in"+"&realname="+tsd.encodeURIComponent(rel));
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
								    isf = isf+ee;
								});
							    $("#ifurgent").html($("#ifurgent").html()+isf);
							}
					 });
             }	
	</script> 
    <script language="JavaScript" type="text/javascript">     
            var TextUtil = new Object(); 
            TextUtil.NotMax = function(oTextArea){ 
                var maxText = oTextArea.getAttribute("maxlength"); 
                if(oTextArea.value.length > maxText){ 
                        oTextArea.value = oTextArea.value.substring(0,maxText); 
                        alert("超出限制"); 
                } 
            } 
        </script>
     <script language="JavaScript" type="text/javascript">           
         function ifnotpayitem(params){          
             if(params!=""){
              getpayitem();
             }
         }
         //从数据库中获取付费类型     
         function getpayitem(){
            $("#payitem").empty();
            var res = fetchMultiArrayValue("adduser.getpayitem",6,"");
            var querypayitemsel="";
               if(res[0][0]!=undefined){
				   for(var i=0;i<res.length;i++)
				   {
				    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
				    querypayitemsel+=ee					
				   }
			       $("#payitem").html($("#payitem").html()+querypayitemsel);
			   }			   
         }
         
         //选择付费类型时触发的事件
         function onchangehth(){
             var payitem = $("#payitem").val();
             if(payitem=='transfer'){
               $("#transferHTHbox").removeAttr("disabled");
             }else{
               $("#transferHTHbox").attr("disabled","disabled");
               $("#transferHTHbox").attr("checked","");
               $("#transferHTH").val("");
             }
         }
         
         //查看是否选择单位合同号，如果选择者弹出窗口显示单位同好和单位名称进行选择
        function isnotdanwei(){
            $("#queryHTHdw").empty();//每次查询前将以前的数据清空
            var transferHTHbox = $("#transferHTHbox").attr("checked");//查看是否被选择
            if(transferHTHbox==true){
               autoBlockForm('queryHTH',5,'close',"#ffffff",false);//弹出查询框
               var res = fetchMultiArrayValue("phonelnstalled.isnotdanweiHTH",6,"");
               var ify="";
               ify += "<tr><td width=\"200\"><center><h4>单位合同号</h4></center></td><td width=\"400\"><center><h4>单位名称</h4></center></td></tr>";
               for(var i=0;i<res.length;i++){
                    ify += "<tr onClick=\"getHTHdanwei('"+res[i][0]+"')\" onDblClick=\"getinputHTH('"+res[i][0]+"')\" id=\""+res[i][0]+"\">";					
					ify += "<td style=\"width: 200px;height: 24px\"><center>";
					ify += res[i][0];
					ify += "</center></td>";
					ify += "<td width=\"400\"><center>";
					ify += res[i][1];
					ify += "</center></td>";
					ify +="</tr>";
               }
               $("#queryHTHdw").append(ify);
            }else{
               $("#transferHTHbox").attr("checked","");
               $("#transferHTH").val("");
               $("#inputDWHTH").val("");//将隐藏域中的清空	
            }            
        }
        
        //得到弹出单位合同号信息选择后的合同号
		function getHTHdanwei(params){
		      var inputDWHTH = params; 
		      $("#inputDWHTH").val(inputDWHTH);//把得到的单位合同号添加到隐藏域中点击确定的时候在从隐藏域中取
		      $("#queryHTHdw tr").css('background-color','#ffffff');
		      document.getElementById(params).style.background='#00ffff';
		}
		//点击弹出合同号狂窗口保存
		function getinputHTH(inputDWHTH){
		     var inputDWHTH = $("#inputDWHTH").val();//从隐藏域中得到单位合同号付给页面显示
		     $("#queryHTHdw tr").css('background-color','#ffffff');
		     $("#transferHTH").val(inputDWHTH);
		     $("#inputDWHTH").val("");//获取后将隐藏域中的清空		     
		     setTimeout($.unblockUI,15);
		}
		function closeGB(){
		   setTimeout($.unblockUI,15);
		   $("#queryHTHdw tr").css('background-color','#ffffff');
		   $("#transferHTHbox").attr("checked","");
		   $("#inputDWHTH").val("");//将隐藏域中的清空
		}		
		//得到月份是否大于当月
		function getDate(BeginDate){
	     	var res;
		       var urlstr=tsd.buildParams({packgname:'service',//java包
						 				   clsname:'ExecuteSql',//类名
						 				   method:'exeSqlData',//方法名
						 				   ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 				   tsdcf:'mssql',//指向配置文件名称
						 				   tsdoper:'query',//操作类型 
						 				   datatype:'xmlattr',
						 				   tsdpk:'processdistory.getmonthtime',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				   tsdUserID:'ture'
									 	});	 								
							$.ajax({
									url:'mainServlet.html?'+urlstr+"&monthtime="+BeginDate,
									datatype:'xml',
									cache:false,//如果值变化可能性比较大 一定要将缓存设成false
									timeout: 1000,
									async: false ,//同步方式
									success:function(xml){
								    $(xml).find('row').each(function(){
								        res = $(this).attr("mon");								        
								    });     
								}								
							});	
				return res;						   
		     }
		     
		    //计算带宽
			function calBSpeed(speed)
			{
				var speed1= speed.toString(); 
				var pres = speed1.toUpperCase();
				var ddd = pres.indexOf("PPPOE");
						
				if(ddd==0)
				{
					var pspeed = speed.toUpperCase().replace("PPPOE","");
					return pspeed
				}
				else
				{
					speed = parseInt(speed,10);					
					return (speed/1024000)+"M";
				}	
			} 
      </script>
      <script language="javascript">
		///////////////////////////////////////////////////////////////////////////////
		// 功能：这个类使得被附加的表格可以支持行点击高亮
		// 参数：
		//            tbl:                 要附加样式的 table.
		//            selectedRowIndex:    初始高亮的行的索引(从 0 开始). 此参数可省。
		//            hilightColor:        高亮颜色。可省（默认为绿色）
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
			  <div id="navBar" style="float:left">
			  <img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
			  <fmt:message key="global.location" />
					：
			  </div>
			  </td>
			  <td width="20%" align="right" valign="top">
			  <div id="d2back"><a href="javascript:void(0);" onclick="parent.history.back(); return false;"><fmt:message key="gjh.houtuei" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			  </td>
			  </tr>
		  </table>
		</div>	

			<div id="broadband_frame">
				
				<div id="input-Unit">
					<div id="inputtext">
						<table id="kdBar" style="margin-left:10px;">
							<tr>
								<td>
									<fmt:message key="broadband.querytype" /><!-- 查询方式 -->
									<select id="kdSearchWay" onchange="closequery()">
										<option value="0"><fmt:message key="broadband.account" /><!-- 账号 --></option>
										<option value="1"><fmt:message key="broadband.phone" /><!-- 电话 --></option>
										<option value="2"><fmt:message key="broadband.username" /><!-- 用户名 --></option>
									</select>
								</td>
								<td>
									<input type="text" class="" id="kdSearchBox" name="kdSearchBox" />
								</td>
								<td>
									<button class="tsdbutton" id="kdSearchByUserName" onclick="kdSearch()"><fmt:message key="Revenue.bSearch" /><!-- 查找 --></button>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<form action="#" onsubmit="return false;" name="form1" id="form1" method="post">
				<div id="input-Unit">
					<div id="inputtext">
						<div class="title">
							&nbsp;&nbsp;
							<img src="style/icon/45.gif" />
							办理新业务							
						</div>
						<div id="inputtext">
						&nbsp;&nbsp;&nbsp;&nbsp;<font color="red"><span id="addSimultaneousnot"></span></font>
						&nbsp;&nbsp;&nbsp;&nbsp;<span id="addSpeednot" style="color:red"></span><br>
						&nbsp;&nbsp;&nbsp;&nbsp;<span id="colosaddSpeednot" style="color:red"></span><br>
						&nbsp;&nbsp;&nbsp;&nbsp;<span id="colosaddSimultaneousnot" style="color:red"></span>						
						<table border="0px" cellpadding="0px" cellspacing="5px">
						   <tr>
						    <td>
							<table cellspacing="10px">
							   <tr>
							      <td>
							      <fmt:message key="BillingBG.BillingGZDQ" />
							      </td>
							      <td>
							        <input type="text" name="iFeeType" id="iFeeType"
									disabled="disabled" style="width: 150px"></input>
							      </td>
							      <td>
							         <fmt:message key="BillingBG.Bandwidthto" />
							     </td>
							     <td>
							       <input type="text" name="speed" id="speed" disabled="disabled" style="width: 150px" />
							     </td>
							     </tr>
							     <tr>
							     <td>
							         带宽提速计费规则
							     </td>
							     <td>
							       <input type="text" name="addspeediFeeType" id="addspeediFeeType" disabled="disabled" style="width: 150px"></input>
							     </td>							     							   
							      <td>
							      提速带宽
							     </td> 
							     <td>
								  <input type="text" name="addspeed" id="addspeed" disabled="disabled"
									style="width: 150px"/>		
							     </td>
							     </tr>
							     <tr>
							     <td>
							      同时在线数
							     </td> 
							     <td>
								  <input type="text" name="iSimultaneous" id="iSimultaneous" disabled="disabled"
									style="width: 150px"/>		
							     </td>
							      <td>
							      增加同时在线数
							     </td> 
							     <td>
								  <select name="addiSimultaneous" id="addiSimultaneous" onchange="addSimultaneous()" style="width: 150px">
								     <option value="">请选择</option>
								  </select>		
							     </td>
							   </tr>
							  </table>
						</table>											
						<table cellspacing="7px">
						<tr>
						<td>
						<table border="1" cellpadding="0" bordercolor="#3C9DFF" id="addspeediFeetype">
					    </table>
					    </td>
					    <td>	
						<table border="0px" cellpadding="0px" cellspacing="5px" id="tishixx">
						    <tr>
						      <td>
						          <span id="addspeedif" style="color:Blue"></span>
						      </td>
						    </tr>
						    <tr>
						      <td>
						          <span id="addiSim" style="color:Blue"></span>
						      </td>
						    </tr>
						</table>
						</td>
						</tr>
						</table>							
						</div>
				     <div id="input-Unit">					   
						<div class="title" id="quxiaotitle">
							&nbsp;&nbsp;
							<img src="style/icon/45.gif" />
							取消新业务							
						</div>
						<div id="inputtext">
						<table border="1" cellpadding="0px" cellspacing="5px" id="quxiaotable" bordercolor="#3C9DFF">
						   <tr id="addise">
						      <td>
						        增加同时在线数
						      </td>
						      <td>
						        <span id="MemoiSe" style="color:red"></span>
						      </td>
						      <td>
						        <button class="tsdbutton" id="Cancelise"
									onclick="cancelise('addSimultaneous')">
									取消该业务
								</button>
						      </td>
						   </tr>
						   <tr id="addspe">
						      <td>
						       带宽提速
						      </td>
						      <td>
						        <span id="Memospeed" style="color:red"></span>
						      </td>
						      <td>
						        <button class="tsdbutton" id="Cancelspeed" onclick="cancelise('addSpeed')">
									取消该业务
								</button>
						      </td>
						   </tr>
						</table>						
					   </div>
					 </div>
						<div class="title">
							&nbsp;&nbsp;
							<img src="style/icon/45.gif" />
							<fmt:message key="BillingBG.UserState" />							
						</div>
						
						<div id="inputtext">
							<p>
								<label for="RemainFee" style="width: 70px">
									<span id="spanRemainFee"></span><!-- 上月余额 -->
									<!-- 余额 -->								
								</label>
								<input type="text" name="RemainFee" id="RemainFee"
									disabled="disabled" style="width: 130px"></input>
								<label for="Fee5" style="width: 70px">
									<span id="spanFee5"></span><!-- 当月费用 -->
									<!-- 当前费用 -->
								</label>
								<input type="text" name="Fee5" id="Fee5" disabled="disabled"
									style="width: 130px" />
								<label for="iStatus" style="width: 70px">
									<span id="spaniStatus"></span>
									<!-- 用户状态 -->
								</label>
								<input type="text" name="iStatus" id="iStatus"
									disabled="disabled" style="width: 130px" />
							</p>
						</div>

						<div class="title">
							&nbsp;&nbsp;
							<img src="style/icon/45.gif" />
							<fmt:message key="BillingBG.JBInformation" />							
						</div>
						<div id="inputtext">
							<p>
								<label for="UserName" style="width: 70px">
									<span id="spanUserName"></span>
									<!-- 用户帐号 -->
								</label>
								<input type="text" name="UserName" id="UserName"
									disabled="disabled" style="width: 130px" />
								<label for="sDh" style="width: 70px">	
									<span id="spansDh"></span><!-- 绑定电话 -->
								</label>	
								<input type="text" name="sDh" id="sDh" disabled="disabled"
										style="width: 130px" />								
								<label for="iStatus" style="width: 70px">
									<span id="spansRealName"></span><!-- 用户姓名 -->
									<!-- 用户姓名 -->
								</label>
								<input type="text" name="sRealName" id="sRealName"
									disabled="disabled" style="width: 130px" />
							</p>
							<p>
							    <label for="Values" style="width: 70px">
									<span id="spanValue"></span>
									<!-- 用户密码 -->
								</label>
								<input type="text" name="Values" id="Values" disabled="disabled"
									style="width: 130px" />
								<label for="sBm" style="width: 70px">
									<span id="spansBm"></span>
									<!-- 所在部门1 -->
								</label>
								<input type="text" name="sBm" id="sBm" disabled="disabled"
									style="width: 130px" />
								<label for="sBm2" style="width: 70px">
									<span id="spansBm2"></span>
									<!-- 所在部门2 -->
								</label>
								<input type="text" name="sBm2" id="sBm2" disabled="disabled"
									style="width: 130px" />
							</p>
							<p>		
								<label for="sBm3" style="width: 70px">
									<span id="spansBm3"></span>
									<!-- 所在部门3 -->
								</label>
								<input type="text" name="sBm3" id="sBm3" disabled="disabled"
									style="width: 130px" />
							
								<label for="sBm4" style="width: 70px">
									<span id="spansBm4"></span>
									<!-- 所在部门4 -->
								</label>
								<input type="text" name="sBm4" id="sBm4" disabled="disabled"
									style="width: 130px" />
								<label for="iStatus" style="width: 70px">
									<span id="spansAddress"></span>
									<!--用户地址-->
								</label>
								<input type="text" name="sAddress" id="sAddress"
									disabled="disabled" style="width: 130px" />
							</p>
							<p>		
								<label for="sRegDate" style="width: 70px">
									<span id="spansRegDate"></span><!-- 开户日期 -->
								</label>
								<input type="text" name="sRegDate" id="sRegDate"
									class="required date"
									onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
									disabled="disabled" style="width: 130px" />							
								<label for="mobile" style="width: 70px">
									<span id="spanmobile"></span>
									<!-- 移动电话 -->
								</label>
								<input type="text" name="mobile" id="mobile" disabled="disabled"
									style="width: 130px" />
								<label for="linkman" style="width: 70px">
									<span id="spanlinkman"></span>
									<!-- 联系人 -->
								</label>
								<input type="text" name="linkman" id="linkman"
									disabled="disabled" style="width: 130px" />
							</p>
							<p>		
								<label for="idtype" style="width: 70px">
									<span id="spanidtype"></span>
									<!-- 证件类型 -->
								</label>
								<input type="text" name="idtype" id="idtype" disabled="disabled"
									style="width: 130px"></input>							
								<label for="idcard" style="width: 70px">
									<span id="spanidcard"></span>
									<!-- 证件号码 -->
								</label>
								<input type="text" name="idcard" id="idcard" disabled="disabled"
									style="width: 130px" />

								<label for="linkphone" style="width: 70px">
									<span id="spanlinkphone"></span>
									<!-- 联系电话 -->
								</label>
								<input type="text" name="linkphone" id="linkphone"
									disabled="disabled" style="width: 130px" />
							</p>
							<p>		
								<label for="sDh1" style="width: 70px">
									<span id="spansDh1"></span>
									<!-- 用户类型 -->
								</label>
								<input type="text" name="sDh1" id="sDh1" disabled="disabled"
									style="width: 130px" />
								<label for="feeendtime" style="width: 70px">
								完工日期
								</label>
								<input type="text" name="feeendtime" id="feeendtime"
									  disabled="disabled" style="width: 130px"></input>	
							</p>

						</div>

					</div>
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/45.gif" />
						<fmt:message key="BillingBG.Credentials" />						
					</div>
					
					<div id="inputtext" style="margin-top: 2px;">
						<table border="0px" cellpadding="0px" cellspacing="10px">
							<tr>								
								<td style="width: 60px;" align="right">
									<span id="spanAcctStartTime"></span>
								</td>
								<td style="width:165px">
									<input type="text" name="AcctStartTime" id="AcctStartTime"
										class="required date"
										onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
										disabled="disabled" style="width: 130px" />
								</td>
								<td style="width: 50px;" align="right">
									<span id="spanAcctStopTime"></span>
								</td>
								<td style="width:160px">
									<input type="text" name="AcctStopTime" id="AcctStopTime"
										class="required date"
										onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
										disabled="disabled" style="width: 130px" />
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
					<div id="inputtext">
						<label for="iStatus" style="width: 70px">
							<span id="spanidaddr"></span>
						</label>
						<input type="text" name="ipaddr" id="ipaddr" disabled="disabled"
							style="width: 130px" />
						<label for="iStatus" style="width: 70px">
							<span id="spanvlanid"></span><!-- 绑定vlanid -->
						</label>
						<input type="text" name="vlanid" id="vlanid" disabled="disabled"
							style="width: 130px" />
						<label for="UserName1" style="width: 70px">
							<span id="spanUserName1"></span><!-- MAC地址 -->
						</label>
						<input type="text" name="UserName1" id="UserName1" disabled="disabled"
							style="width: 130px"/>
					</div>
				 </div>
                            
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/45.gif" />
						<fmt:message key="gjh.Rates" />
						<!-- 费率 -->
					</div>
							
							<div id="inputtext">
								<table border="0px" cellpadding="0px" cellspacing="2px">
									<tr>
										<td width="100px">
											<fmt:message key="phoneyewu.yicixingfee" />
								            <!-- 一次性费用 -->
										</td>
										<td width="500px">
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
							<hr style="border: 1px dotted #CCCCCC;" />
							<div>
								<table cellpadding="5px" cellspacing="5px">
									<tr>
										<td align="right">
											<fmt:message key="gjh.TotalFees" />
											<!-- 杂费合计 -->
										</td>
										<td>
											<input type="text" name="id" id="feei" value="0" readonly />
										</td>										
									    <td><fmt:message key="broadband.paytype" /><!-- 付费类型 --></td>
									    <td>
									       <select name="payitem" id="payitem" style="width:100px" onchange="onchangehth()"></select>
									    </td>
									    <td><fmt:message key="broadband.ZZhth" /><!-- 转账合同号 --></td>
										<td>
											<input type="text" name="transferHTH" id="transferHTH" style="width:150" disabled="disabled" />
										</td>
										<td>
										  <input type='checkbox' name="transferHTHbox" id="transferHTHbox"
														style="width: 22px; padding: 0px;" onclick="isnotdanwei()" disabled="disabled"/>
										</td>
										<td><fmt:message key="broadband.selectHTH" /><!-- 选择合同号 --></td>
								   </tr>
								</table>								
							</div>
							<hr style="border: 1px dotted #CCCCCC;"/>
							<table cellspacing="2px">
							  <tr>
							    <td>
							      <fmt:message key="broadband.isurgent" /><!-- 是否紧急 -->
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
	         	                 <textarea id="jobmemo" name="jobmemo" rows="4" cols="80" onpropertychange="TextUtil.NotMax(this)" maxlength="60" disabled="disabled"></textarea>
							    </td>
							  </tr>							  
							</table>
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
								<input type="hidden" name="feeendtime" id="feeendtime"/>
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
								<button id="closesave" onclick="save()" disabled="disabled">
									<!-- 确定 -->
									<fmt:message key="Revenue.Save" />
								</button>
								<button id="close1111" onclick="xuxiao()">
									<!-- 取消 -->
									<fmt:message key="Revenue.Cancel" />
								</button>
							</div>
						</div>
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
					<input type="hidden" id="BroadbandBusinessright" />
					<input type="hidden" id="TelphoneBusinessright" />
				    <input type="hidden" id="zid" value="1~2~3" />
				    <input type="hidden" id="c_p_address_addright"/>
					<input type="hidden" id="userid" value="<%=userid%>" />
					<input type="hidden" id="area" value="<%=area%>" />
					<input type="hidden" id="depart" value="<%=depart%>" />
					<input type="hidden" id="userareaid" value="<%= userareaid%>"/>
					<!-- 打印报表 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
					<input type="hidden" name="BaseFee" id="BaseFee"/>
					<input type="hidden" name="checkright" id="checkright"/>
					<input type="hidden" id="userid" value="<%=userid %>"/>
					<input type="hidden" id="area" value="<%=area %>"/>
					<input type="hidden" id="depart" value="<%=depart %>"/>
					<input type="hidden" id="userareaid" value="<%=userareaid %>"/>
					<input type="hidden" id="imenuid" value="<%=imenuid %>"/>
					<input type="hidden" id="zid" value="<%=zid %>"/>
					<input type="hidden" id="languageType" value="<%=languageType %>"/>
					<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
					<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
					<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
					<input type="hidden" name="jobidid" id="jobidid" />
					<input type="hidden" name="reportparam" id="reportparam"/>	
					<input type="hidden" name="printfeeee" id="printfeeee" value="0"/>	
					<input type="hidden" name="addspeed1" id="addspeed1"/>
					<input type='hidden' name="speed1" id="speed1"/>
					<input type="hidden" name="UserID" id="UserID"/>
					<input type="hidden" id="inputDWHTH" name="inputDWHTH"/>
					<input type="hidden" id="payitemYCY" name="payitemYCY"/> 
					
					<!-- 是否可以不选一次性费用项 -->
					<input type="hidden" id="ableForNoChoose" name="ableForNoChoose" />
				</div>
		<!-- 宽带缴费查询面板 -->
		 <div class="neirong" id="multiSearch" style="display:none;width:700px;">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="broadband.yijiUserNamequery" /><!-- 宽带移机用户信息查询 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onclick="javascript:$('#kdMultiSearchClose').click();"><!-- 关闭 --><fmt:message key="global.close" /></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>	
			</div>		
			<div class="midd" style="background-color:#FFFFFF;text-align:left;width:698px;overflow-x:hidden;">
				<div id="grid"></div>
			</div>		
			<div class="midd_butt">
				<button type="button" class="tsdbutton" id="kdMultiSearchClose">
					<!-- 关闭 --><fmt:message key="global.close" />
				</button>
			</div>
		</div>	
		<!-- 合同号查询面板 -->
		<div class="neirong" id="queryHTH"
			style="display: none;width:528px">
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
						<a href="#" onclick="closeGB();"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;">
			<div id="inputtext">
			<div style="width: 525px; height: 250px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">			   						
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="queryHTHdw" style="width: 507px;">												
						</table>
			</div>										
				<div id="buttons">  
				<center>
					<button id="save" onclick="getinputHTH()"
						style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onclick="closeGB();" style="margin-left: 20px;">
						<fmt:message key="global.close" />
						<!-- 关闭 -->
					</button>
				</center>	
				</div>
			  </div>	 
			</div>
		</div>	
			<!-- 打印表报 -->	
		<div class="neirong" id="choosePrintJob"
			style="display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="broadband.printmethod" /><!-- 打印方式 -->
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif"/>
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:center;">
						<h4><fmt:message key="broadband.sjbcaccouncc" /><!-- 数据保存成功。请选择打印方式  --> :</h4> 
						<button id="printDirect" class="tsdbutton" onclick="jobPrint(1)"><fmt:message key="broadband.zhijiePrint" /><!-- 直接打印 --></button>	
						<button id="printInDirect" class="tsdbutton" onclick="jobPrint(2)"><fmt:message key="broadband.yulanPrint" /><!-- 预览打印 --></button>
						<button id="printInDirect" class="tsdbutton" onclick="jobPrint(0)"><fmt:message key="broadband.notprint" /><!-- 不打印 --></button>
		    </div>	
		    <div class="midd_butt"></div> 
		</div>
		
		<div class="neirong" id="choosePrint"
			style="display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="broadband.printmethod" /><!-- 打印方式 -->
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:center;">
						<h4><fmt:message key="broadband.jobpiaojuprintwanbi" /><!-- 工单票据打印完毕，请换纸，然后选择打印方式  --> :</h4> 
						<button id="printDirect" class="tsdbutton" onclick="lsPrint(1)"><fmt:message key="broadband.zhijiePrint" /><!-- 直接打印 --></button>
						<button id="printInDirect" class="tsdbutton" onclick="lsPrint(0)"><fmt:message key="broadband.yulanPrint" /><!-- 预览打印 --></button>
		    </div>	
		    <div class="midd_butt"></div> 
		</div>
		<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
	    <script>		
		var hilighter2 = new TableRowHilighter(document.getElementById('queryHTHdw'), 0, 'lightsteelblue');
	  </script>
	</body>
</html>