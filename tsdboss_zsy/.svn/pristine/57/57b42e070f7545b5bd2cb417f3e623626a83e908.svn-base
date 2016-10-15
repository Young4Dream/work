<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/telephone/business/PhoneCancelBJ.jsp
    Function:   取消电话并机
    Author:     wenxuming
    Date:       2011-12-20
    Description: 
    Modify: 
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
<html>
	<head>
		<title>取消电话并机业务</title>
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
		<!--设置全局字体大小-->
		<link href="style/css/telephone/business/fontsize_all.css" rel="stylesheet" type="text/css"/>
		<style type="text/css">
			#qftrid{background-color:#A9C8D9;border:#A9C8D9 solid 0px;}
			#qftrid{border-collapse:collapse;border:#A9C8D9 solid 1px;}
			#qfuser tr td{line-height:26px;border:#A9C8D9 solid 1px;TEXT-OVERFLOW: ellipsis;}
		</style>
		<style type="text/css">  
		.mytable{   
		   width:100%;
		   table-layout:fixed;
		   border:0px;   
		   margin:0px; 
		   }
		.mytable tr td{   
		   text-overflow:ellipsis; /* for IE */    
		   -moz-text-overflow: ellipsis; /* for Firefox,mozilla */    
		    overflow:hidden;   
		    white-space: nowrap;   
		    border:0px;   
		    text-align:left;      
		   }
		   .mytable tr th{   
		    white-space: nowrap;   
		   border:0px;   
		    text-align:left   
		   }   
		</style>					
    	<script type="text/javascript">
    	 var userid="";
    	 jQuery(document).ready(function()
		 {	    
			    $("#navBar").append(genNavv());
			    $("#ghSearchBox").select();
				$("#ghSearchBox").focus();				
				Dat = loadData("air_users","zh",1,'操作');    
			    jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?',
						datatype: 'xml', 	
						colNames:Dat.colNames, 
					    colModel:Dat.colModels,		
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'userid', //默认排序字段
						       	viewrecords: true, 
						       	//hidegrid: false, 
						       	sortorder: 'desc',//默认排序方式 
						       	caption:"并机用户信息",//'固话缴费票据', 				       	
						       	height:200, //高
						        //width:document.documentElement.clientWidth-27,
						       	loadComplete:function(){
						       		var ids = $("#editgrid").getDataIDs();
									for(var i=0;i<ids.length;i++)
									{
										LineNum = $("#editgrid").getCell(ids[i],"LineNum");
									}
						        	addRowOperBtn('editgrid',"<span style='color:red'>取消该并机</span>",'getradio','Dh','click',1,'LineNum','userAddr');
									executeAddBtnWithoutAddCell('editgrid',1);
								}
						}); 
		   });

		   function getari_user(Dh){	 	
			 	var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'PhoneCancelBJ.queryair_users',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'PhoneCancelBJ.queryair_userspage'
											});											
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&phone='+Dh+"&clos="+Dat.FieldName.join(",")}).trigger("reloadGrid");
		   }	
		   
		/**********
		* 从真实姓名对应的多个账户中选择要查询的账户
		* @param;
		* @return;
	    **********/
		function userChoose(Yhmc,Dh,Yhdz)
		{
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_splitphone")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+Dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][1]);
				return;
			}
			$("#yhdz").text(Yhdz);
			getari_user(Dh);
			setTimeout($.unblockUI,1);
		}

		function getradio(dh,LineNum,useraddr){
			/*
			var res = fetchSingleValue("PhoneCancelBJ.queryteljobiswg",6,"&Dh="+dh+"&value16="+tsd.encodeURIComponent(userid));
			if(res!=undefined&&res!=""&&res=="N"){
				alert("该取消并机信息未完工，请等待完工！");
				return;
			}
			*/
			var result = fetchMultiPValue("PhoneDH.ifCanSouLi",6,"&OperID=" + tsd.encodeURIComponent($("#userid").val()) + "&Ywlx="+tsd.encodeURIComponent("p_splitphonecalcel")+"&NowYwArea="+tsd.encodeURIComponent($("#area").val())+"&Dh="+dh);
			if(result[0]!=undefined && result[0][0]!="")
			{
				alert(result[0][1]);
				return;
			}
			/* if(useraddr==""){
				alert("当前并机地址为空，不能取消该并机！");
				return;
			} */
			if(confirm("你确定将电话【"+dh+"】的并机地址【"+useraddr+"】取消吗？")){
				//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
			 	var params='';
				//区域
				var area = $("#area").val();
				var userareaid = $("#userareaid").val();
				//部门
				var depart = $("#depart").val();
				//工号
				var useridto = $("#userid").val();			
				params+="&Area="+tsd.encodeURIComponent(area);
				params+="&userarea="+tsd.encodeURIComponent(userareaid);
				params+="&Depart="+tsd.encodeURIComponent(depart);
				params+="&UserID="+tsd.encodeURIComponent(useridto);
				params+="&Dh="+tsd.encodeURIComponent(dh);		
				params+="&linenum="+tsd.encodeURIComponent(LineNum);
				params+="&useraddr="+tsd.encodeURIComponent(useraddr);		
			 	var loginfo = "电话取消并机:";
				loginfo += "(电话号码:";
				loginfo += dh;	
				loginfo +=")(取消并机地址：";
				loginfo +=useraddr;	
				loginfo += ")(业务区域:";			
				loginfo += area;
				loginfo += ")(受理人:";			
				loginfo += useridto+")";
				loginfo = tsd.encodeURIComponent(loginfo);
		 		//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				var result = fetchMultiPValue("PhoneService.CancelBJ",6,params);
				if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
				{
					alert("电话取消并机失败");
				}
				else
				{
					alert("取消并机业务成功，请等待完工！");
					$("#jobidid").val(result[0][0]);
					writeLogInfo("","modify",loginfo);	
					$("#ghSearchBox").select();
				    $("#ghSearchBox").focus();					
				}
				getari_user(dh);
			}
		}
		
		function setPhoneBJ(){
			autoBlockForm('addBJAdressFrom', 150, 'printclose', "#ffffff", false);
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
						<button class="tsdbutton" id="submitButton" onClick="ghSearch()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
							<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
						</button>
					</td>
					<td width="290"></td>
				</tr>
			</table>
		</div>		
		<table>
			<tr>
				<!-- <td><span style="font-size: 14px;font-weight: bold;">用户当前地址：</span><span id="yhdz" style="color:red;"></span></br></td> -->
				<!--
				<td><span style="font-size: 14px;font-weight: bold;">并机地址：</span></td>
				<td><input type="text" id="BJAdress" style="width:200px;"/></td>
				<td><span id="yhdz" style="color:red;"></span></td>
				<td><button class="tsdbutton" id="submitButton" onClick="setPhoneBJ()" style="width:70px;line-height:15px; margin-top: 5px; padding: 0px;">
						新增并机
					</button>
				</td>	
				-->
			</tr>
		</table>
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>					
		<div id="inputtext1" style="display:none;">
			<table cellspacing="0" width="760" id="businesschange">
				<tr>
					<td style="width:460px;">
						<table id="ffltab" style="width:480px;">
						<tr>
							<td class="wenzi" style="width:75px;">
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
							<td colspan="4" id="ywslfeename">
							<fmt:message key="phone.getinternet0094" /><!-- 一次性费用 -->：
							<div
							style="width:400px; height: 80px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
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
							电话并机用户信息查询
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
		<!-- 获取空号模块局权限 -->
		<input type="hidden" id="Jhj_ID"/><!-- 获取空号后获取交换机id -->
	    <input type="hidden" id="konghaoarearight" name="konghaoarearight"/>
	    <input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
	    <input type="hidden" id="fufeitypepath"/>
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
		<input type="hidden" id="stiffbusinestype" value="phonechange"/><!-- 电话工单打印类型 -->
		<input type="hidden" id="Prefeeval"/><!-- 预测金额打印票据时判断 -->
		<jsp:include page="phone_internet.jsp" flush="true"/>
	</body>
</html>
