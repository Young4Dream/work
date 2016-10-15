<%----------------------------------------
	name: dhRecover.jsp
	author: cl
	version: 1.0, 2011-12-28
	description: 手动回收号源
	modify: 
			增加手机回收号源日志记录 cl 2011-12-29
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	//String imenuid = request.getParameter("imenuid");
	//String groupid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Manual recovery of signal source</title>
		<meta http-equiv="pragma" content="no-cache" />
		<meta http-equiv="cache-control" content="no-cache" />
		<meta http-equiv="expires" content="0" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/main.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
jQuery(document).ready(function () { 
	
	$("#navBar1").append(genNavv());//获取导航
	initTab('yhdang','tdiv',"<fmt:message key='dhRecover.userbasicinformation' />");//初始化表格信息
	$('#dhquery').focus();
	$("#dhquery").keydown(function(event){if(event.keyCode==13){$("#openquery").click();}});//回车响应
});
/**
功能：初始化表格显示信息
参数说明：
	tab，别名表配置表名；
	ids，显示table的id；
	divtitle，显示标题内容；
*/
function initTab(tab,ids,divtitle){
	var res = fetchMultiArrayValue("dhRecover.querytab",6,"&tab="+tab);
	if(res!='')
	{
		var tabhtml = '<tr>';
		var sfix = '';
		var linenum = 4;//显示用户信息个数
		var addnum = res.length%linenum; 
		if(addnum!=0){
			var stradd = '';
			var sint = linenum - addnum;//填白个数
			for(var i = 0 ; i < sint;i++){
				stradd += '<td class="labelclass" style="width:10%;"></td><td class="textclass" ></td>';
			}
		}
		var columnarr = new Array();
		for(var i = 0 ; i < res.length;i++){
			if((i+1)%linenum==0){
				sfix = '</tr>';
			}else{
				if(i+1==res.length){
					sfix = stradd;
				}else{
					sfix = '';				
				}
			}
			tabhtml+= '<td class="labelclass" style="width:10%;">'+getCaption(res[i][1], '<%=languageType %>', '')+'</td><td class="textclass" id="'+tab+'div_'+res[i][0]+'"></td>'+sfix;
			columnarr.push(res[i][0]);
		}	
		$('#'+ids).html('<tr><td colspan="8" class="labelclass" style="text-align:left;font-size:14px;font-weight: bold;">&nbsp;'+divtitle+'</td></tr>'+tabhtml);
		$('#column_'+tab).text(columnarr.join(','));
	}else{
		alert("<fmt:message key='dhRecover.failedcheckaliastableconfiguration' />");
	}
}

//查询用户详细信息
function dhInfo(){
	var dhquery = $('#dhquery').val();
	if(dhquery==''){
		alert("<fmt:message key='dhrecover.inputTelNum' />");
		$('#dhquery').focus();
		return false;
	}
	var params = '';
	params += '&dh='+dhquery;
	params += '&func=query';
	var res = fetchMultiPValue('dhRecover.hmzy_manualcallback',6,params);
	if(res[0][0]=='FAILED'){
		$('#openrecover').attr('disabled','disabled');
		var ress = fetchSingleValue('main.querytaginfo',6,'&procname=hmzy_manualcallback&tags='+res[0][1]);
		if(ress!=undefined){
			alert(getCaption(ress, '<%=languageType %>', ''));
		}else{
			alert(res[0][1]);
		}
		textInfoClear();
		return false;
	}
	var columnval = $('#column_yhdang').text();
	if(res[0][1]=='delete'){//拆机
		var arr = columnval.split(',');
		var result = fetchMultiArrayValue("dhRecover.querytabinfo",6,"&dh=" + dhquery+'&column='+columnval);
		if(result==''){
			alert("<fmt:message key='dhrecover.queryuserbasicinformationfailed' />");
			textInfoClear();
			return false;
		}
		for(var i=0 ; i < arr.length;i++){
			$('#yhdangdiv_'+arr[i]).text(result[0][i]);
		}
		$('#tdhchangediv').hide();
		$('#openrecover').removeAttr('disabled');
	}else if(res[0][1]=='change'){//改号
		initTab('dh_change','tdhchangediv',"<fmt:message key='dhrecover.userchangeInfo' />");//初始化表格信息
		var ncolumnval = $('#column_dh_change').text();//获取数据列
		//查询改号信息
		var srev = fetchMultiArrayValue("dhRecover.querychangeinfo",6,"&dh=" + dhquery+'&column='+ncolumnval);
		if(srev!=''){
			var sarr = ncolumnval.split(',');
			for(var i=0 ; i < sarr.length;i++){
				$('#dh_changediv_'+sarr[i]).text(srev[0][i]);
			}
			//显示用户基本信息，srev[0][2]为用户改号之后的号码
			var ress = fetchMultiArrayValue("dhRecover.querytabinfo",6,"&dh=" + srev[0][2]+'&column='+columnval);
			if(ress!=''){
				var sarr = columnval.split(',');
				for(var i=0 ; i < sarr.length;i++){
					$('#yhdangdiv_'+sarr[i]).text(ress[0][i]);
				}
				$('#tdhchangediv').show();
			}else{
				alert("<fmt:message key='dhrecover.Newdatathatdoesnotexist' />");
				textInfoClear();
				return false;
			}
		}else{
			alert("<fmt:message key='dhrecover.userchangeInfofailed' />");
			textInfoClear();
			return false;
		}
		$('#openrecover').removeAttr('disabled');
	}else{
		
		alert("<fmt:message key='dhrecover.callinterfacefailure' />");
		textInfoClear();
		$('#openrecover').attr('disabled','disabled');
		return false;
	}
	$('#recovertype').text(res[0][1]);
}
//信息重置
function textInfoClear(){
	$('#tdhchangediv').hide();
	if($('#yhdangdiv_Dh').text()!=''){
		var columnval = $('#column_yhdang').text();
		var sarr = columnval.split(',');
		for(var i=0 ; i < sarr.length;i++){
			$('#yhdangdiv_'+sarr[i]).text('');
		}				
	}
	$('#dhquery').focus();
}
//号码回收处理
function dhRecover(){
	var dhquery = $('#dhquery').val();
	if(dhquery==''){
		alert("<fmt:message key='dhrecover.inputtherecoftelnum' />");
		$('#dhquery').focus();
		return false;
	}
	if(confirm("<fmt:message key='dhrecover.determinedtotel' />"+dhquery+"<fmt:message key='dhrecover.reclaimwhat' />")){
		var params = '';
		params += '&dh='+dhquery;
		params += '&func=save';
		var res = fetchMultiPValue('dhRecover.hmzy_manualcallback',6,params);
		if(res[0]!=undefined&&res[0][0]!=undefined)
		{
			if(res[0][0]=='SUCCEED'){
				var recovertype = $('#recovertype').text()=='delete'?"<fmt:message key='dhrecover.destroy' />":"<fmt:message key='dhrecover.changeNum' />";
				writeLogInfo('','modify',tsd.encodeURIComponent("<fmt:message key='dhrecover.dh' />"+dhquery+"<fmt:message key='dhrecover.byuserid' /><%=userid %><fmt:message key='dhrecover.sdhsstate' />"+recovertype));
				$('#dhquery').val('');
				alert("<fmt:message key='dhrecover.thesuccessofoperation' />");
			}else{
				var ress = fetchSingleValue('main.querytaginfo',6,'&procname=hmzy_manualcallback&tags='+res[0][1]);
				if(ress!=undefined){
					alert(getCaption(ress, '<%=languageType %>', ''));
				}else{
					alert(res[0][1]);
				}
			}
		}else{
			alert("<fmt:message key='dhrecover.callinterfacefailure' />");
		}
		textInfoClear();
	}
}
</script>
<style type="text/css">
.labelclass{line-height: 30px;}
.textclass{width:200px;border-bottom:1px solid #A9C8D9;}
</style>
</head>
<body>
		<form name="childform" id="childform">
			<input type="text" id="queryName" name="queryName" value=""
				style="display: none" />
			<input type="text" id="fusearchsql" name="fusearchsql"
				style="display: none" />
		</form>
		<div id="navBar" style="margin-bottom: 0px">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />:
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);" onclick="parent.history.back(); return false;">
								<fmt:message key="gjh.houtuei" />
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="buttons" style="text-align: left;margin-top: 1px;margin-bottom: 1px">
			<table>
				<tr>
					<td><font style="font-size: 13px;margin-left: 35px"><fmt:message key="dhrecover.telNum"/></font></td>
					<td><input type="text" style="width:135px;height: 20px;line-height: 20px" id="dhquery""/></td>
					<td>
						<button type="button" id="openquery" onclick="dhInfo()"><fmt:message key="dhrecover.query"/></button>
						<button type="button" id="openrecover" onclick="dhRecover()" disabled="disabled"><fmt:message key="dhrecover.Recycling"/></button>
					</td>
				</tr>
			</table>
		</div>
		<table id="tdhchangediv" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;display: none" cellspacing="0" cellpadding="0">
		</table>
		<table id="tdiv" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;margin-top: 1px" cellspacing="0" cellpadding="0">
		</table>
		
		<label id='column_yhdang' style="display: none"></label>
		<label id='column_dh_change' style="display: none"></label>
		<label id='recovertype' style="display: none"></label>
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid' value='<%=userid%>' />
		
		

		
	</body>
</html>
