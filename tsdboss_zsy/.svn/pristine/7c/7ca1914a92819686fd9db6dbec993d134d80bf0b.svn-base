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
		<title></title>
		<meta http-equiv="description" content="this is my page" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />		
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
		<script src="script/public/mainStyle.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript" language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript" language="javascript"></script>		
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript">
		 jQuery(document).ready(function(){
		   $("#navBar").append(genNavv());
		 })	
		 
		 function getradio(){
		 	var radio1Value=$(":radio[name='radio1']:checked").val();
			if(radio1Value=='1'){
				$("#query_zdy").show();
			    $("#query_wh").hide();
				$("#query_wh1").val("");
				$("#query_wh2").val("");
				$("#query_wh3").val("");
				$("#query_wh4").val("");
				$("#query_zdy").select().focus();				
			}else if(radio1Value=="2"){			
				$("#query_wh").show();
				$("#query_zdy").hide();
				$("#query_zdy").val("");
				$("#query_wh1").select().focus();
			}	
		 }	 
		 
		 function query_xqphone(){
		 	var radio1Value=$(":radio[name='radio1']:checked").val();
			if(radio1Value=="1"){
				var res = fetchMultiArrayValue("query_xqnulldh.getphone_on1",6,"&key="+$("#query_zdy").val());
			}else if(radio1Value=="2"){
				var str1 = $("#query_wh1").val();
				var str2 = $("#query_wh2").val();
				var str3 = $("#query_wh3").val();
				var str4 = $("#query_wh4").val();
				var res = fetchMultiArrayValue("query_xqnulldh.getphone_on2",6,"&key="+str1.toString()+str2.toString()+str3.toString()+str4.toString());
			}		
			var parstr="<tr>"
			var num=0;
			if(res==""||res==undefined){
				parstr+="<td><span style='font-size: 24pt;'>没有该条件的查询结果！！！</span></td>";
			}else{
				for(var i=0;i<res.length;i++){
					parstr+="<td>";
					parstr+="<a href='javascript:void(0)' onclick='getselectfrom("+res[i][0]+")' title='"+res[i][0]+"' style='font-size: 24pt;'>"+res[i][0]+"</a>";
					parstr+="</td>";
					num++;
					if(num==5){
						parstr+="</tr><tr>";
						num=0;
					}
				}				
			}
			parstr+="</tr>";
			$("#phonevalue").html(parstr);
		 }
		 
		 function getselectfrom(key){
		 	$("#selectphone").text(key);
			$("#cardid").val("");
			$("#yhmc").val("");
			$("#linkphone").val("");
		 	autoBlockForm('selectphonefrom',5,'close',"#ffffff",false);//弹出查询框 
		 }
		 
		 function saveiskeepphone(){
				var selectphone = $("#selectphone").text();
				var cardid = $("#cardid").val();
				var yhmc = $("#yhmc").val();
				var linkphone = $("#linkphone").val();
				cardid=cardid.replace(/(^\s*)|(\s*$)/g,"");
				yhmc=yhmc.replace(/(^\s*)|(\s*$)/g,"");
				linkphone=linkphone.replace(/(^\s*)|(\s*$)/g,"");
				if(cardid==""){alert("证件号码不能为空！");$("#cardid").select().focus();return;}
				if(cardid!=""&&!/((11|12|13|14|15|21|22|23|31|32|33|34|35|36|37|41|42|43|44|45|46|50|51|52|53|54|61|62|63|64|65)[0-9]{4})(([1|2][0-9]{3}[0|1][0-9][0-3][0-9][0-9]{3}[X0-9])|([0-9]{2}[0|1][0-9][0-3][0-9][0-9]{3}))$/.test(cardid))
				{
					alert("中请输入正确的身份证号码！");
					$("#cardid").select();
					$("#cardid").focus();
					return;
				}
				if(yhmc==""){alert("联系人不能为空！");$("#yhmc").select().focus();return;}
				if(linkphone==""){alert("联系电话不能为空！");$("#linkphone").select().focus();return;}
				var result = fetchMultiPValue("query_xqnulldh.commitsave",6,"&dh=" + selectphone+"&cardid=" + tsd.encodeURIComponent(cardid)+"&yhmc=" + tsd.encodeURIComponent(yhmc)+"&bz9=" + tsd.encodeURIComponent(linkphone)+"&ywarea="+tsd.encodeURIComponent($("#ywarea").val()));
				if(result[0]!=undefined && result[0][0]!="")
				{
					alert(result[0][0]);
					query_xqphone();
					removecheckbusi();
					return;
				}								
		 }
		</script>		
</head>       
	<body onUnload="unLockDh()">      
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
		<div id="input-Unit">
					<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						输入查询条件
					</div>
					<table id="kdBar" style="margin-left: 10px;" cellspacing="10px">
						<tr>
							<td>
								<h4>号段搜索：</h4>
							</td>
							<td>
								自定义号段
							</td>
							<td>
								<input type="radio" name="radio1" value="1" style="width:20px;" onClick="getradio()">
							</td>
							<td>
								结尾号段
							</td>
							<td>
								<input type="radio" name="radio1" value="2" style="width:20px;" onClick="getradio()">
							</td>
							<td style="width:10px;"></td>
							<td>
								<input type="text" class="" id="query_zdy" name="query_zdy" style="display:none"/>
							</td>							
							<td>																
							   <div id="query_wh" style='display:none'>
								<input type="text" class="" id="query_wh1" name="query_wh1" style="width:15px;"/>
								<input type="text" class="" id="query_wh2" name="query_wh2" style="width:15px;"/>
								<input type="text" class="" id="query_wh3" name="query_wh3" style="width:15px;"/>
								<input type="text" class="" id="query_wh4" name="query_wh4" style="width:15px;"/>
							   </div>
							</td>
							<td>
								<button class="tsdbutton" id="submitButton"
									onclick="query_xqphone()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									搜索
								</button>
							</td>
							<td width="290"></td>
						</tr>
					</table>
				<div class="title">
						&nbsp;&nbsp;
						<img src="style/icon/65.gif" />
						查询结果
					</div>
			<div id="inputtext">
				<table id="phonevalue" cellspacing="12" border="5" cellspacing="1" style="background-color:#f7f7f7"></table>			
			</div>
		</div>	
		
			
		<div class="neirong" id="selectphonefrom"	style="width:585px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							号码选择
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="removecheckbusi()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;height:70px;">
				<font style='font-size: 16pt;'>您选择的号码是[<span id="selectphone" style='font-size: 16pt;color:#0000FF'></span>]</font>
				<br>
				<hr>
				<table>				  
				  <tr>	
					<td>
						<h4>身份证号：</h4>
					</td>
					<td>
						<input type="text" id="cardid" name="cardid" style="width:200px;"/><span style="color:#FF0000">*</span>
					</td>
				  </tr>
				  <tr>
				  	<td>	
						<h4>联 系 人：</h4>				
					</td>
					<td>
						<input type="text" id="yhmc" name="yhmc" style="width:200px;"/><span style="color:#FF0000">*</span>
					</td>
				  </tr>	
				  <tr>
				  	<td>	
						<h4>联系电话：</h4>				
					</td>
					<td>
						<input type="text" id="linkphone" name="linkphone" style="width:200px;"/><span style="color:#FF0000">*</span>
					</td>
				  </tr>
				</table>
			</div>
			<div class="midd_butt" style="width:571px;height:30px;">  
				<button id="hthChooseFormSave" onClick="saveiskeepphone()" class="tsdbutton" 
					style="margin-left: 20px;">
					提交
				</button>
				<button id="hthChooseFormReset" onClick="removecheckbusi()" class="tsdbutton"  style="margin-left: 20px;">
					关闭
				</button>
			</div>
		</div>
		<input type="hidden" id="ywarea"/>
	</body>
</html>