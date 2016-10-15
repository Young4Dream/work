<%----------------------------------------
	name: rad_busi_dPort.jsp
	author: wenxuming
	version: 1.0 
	description: 一端多口
	Date: 2012-03-22
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String sUserId = (String) session.getAttribute("userid");
	String sArea = (String) session.getAttribute("chargearea");
	String sDepart = (String) session.getAttribute("departname");	
	String sMenuid = request.getParameter("imenuid");
	String sGroupid = request.getParameter("groupid");	
	String path = request.getContextPath();
	String ywarea = (String) session.getAttribute("userarea");	
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery.layout.js" type="text/javascript"></script>
	<script src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js" type="text/javascript"></script>
	<script src="script/broadband/business/broadbandservice.js" type="text/javascript"></script>
	<script src="script/broadband/business/radbusiprint.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script> <!-- 弹出面板需要导入js文件 -->	
    <script type="text/javascript" src="script/public/tsdpower.js"></script><!-- 页面权限控制 -->
    <script type="text/javascript" src="script/public/main.js"></script>
    <script type="text/javascript" src="script/public/mainStyle.js"></script>
    <script type="text/javascript" src="script/public/transfer.js"></script>	    
    <script type="text/javascript" src="script/public/revenue.js" ></script>    
    	
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
	<link href="style/css/telephone/business/businesspublic.css" rel="stylesheet" type="text/css"/>
	<style type="text/css">
		#input-Unit{ float:left; width:100%; text-align:center;}
		#input-Unit .title_rad{ width:100%; height:22px; border-bottom:1px solid #C8D8E5;  text-align:center; color:#3C3C3C; line-height: 22px; font-weight:bold; background:#CCCCFF;}
		.tsdbutton_rad{width:70px; height:22px;background: url(style/images/public/buttonsbg.jpg) repeat-x; border: #CCCCCC 1px solid; cursor: pointer;}		 
		.tdstyle{height:25px;}
	</style>	
	<script type="text/javascript">			
		$(document).ready(function () {					
			$("#navBar").append(genNavv());	
			//setfuser();		
			getDict();															
		});	
		
		//根据字段名和字段值查询raduserinfo表. 精确查找
		function queryRadUser_equal(){
			var fieldname = $("#queryfield").val(); 
			var fieldvalue = $("#queryvalue").val();
			queryRadUser_equalReal(fieldname,fieldvalue);			
		}
		function queryRadUser_equalReal(fieldname,fieldvalue){
			if(fieldvalue==""){
				fieldvalue='-1';
			}
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_equal1',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');
			if (res != undefined && res!="" && res.length>0){
				setValue(res);	
			}
			else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				setnull();  
				$("#kdcx").attr("disabled","disabled");
				$("#queryvalue").select();
				$("#queryvalue").focus();
			}			
		}	
		
		//根据查询结果数组，给控件赋值
		function setValue(arr){  
			var rescomplete = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1)&tablename=radjob&key=internetacct='"+arr[0][0]+"' and COMPLETE='N'");	 			
			if(rescomplete>0){
				alert("该帐号未完工，不能办理次业务");
				return;
			}
			setnull();  
			$("#kdcx").removeAttr("disabled"); 	
        	$("#INTERNETACCT").text(arr[0][0]);
			executeNoQuery("dbsql_phone.deleteallrad_busi_dport",6,"&z_internetacct_to="+arr[0][0],'business');
			executeNoQuery("dbsql_phone.updatepwdisnullrad_busi_dport",6,"&z_internetacct_to="+arr[0][0],'business');			
			getfuser(arr[0][0]);
			getfuser_lxvalue(arr[0][0]);
        	$("#username").text(arr[0][1]);
        	$("#useraddr").text(arr[0][2]);
        	$("#bm1").text(arr[0][3]);
	        $("#bm2").text(arr[0][4]);						
	        $("#bm3").text(arr[0][5]);			
        	$("#bm4").text(arr[0][6]);
        	$("#area").text(arr[0][7]);
        	$("#usertype").text(arr[0][8]);
        	$("#userattr").text(arr[0][9]);
        	$("#startdate").text(arr[0][10]); 
			$("#enddate").text(arr[0][11]); 
			$("#pkgid").text(fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=pkgname&tablename=radpkg&key=pkgid="+arr[0][13]+""));
			var stat="";
			if(arr[0][14]=="K"){
				stat="正常";
			}else{
				stat="停机";
			}
        	$("#status").text(stat);           	
        	$("#cardtype").text(arr[0][15]);
			$("#cardid").val(arr[0][16]);			
			$("#mobile").val(arr[0][17]);
			$("#linkphone").val(arr[0][18]);
			$("#linkman").val(arr[0][19]);
			$("#dh").val(arr[0][20]);
        	inLock("move",arr[0][0]);	
			
		}
		
		function setnull(){
			executeNoQuery("dbsql_phone.deleteallrad_busi_dport",6,"&z_internetacct_to="+$("#INTERNETACCT").text(),'business');
			executeNoQuery("dbsql_phone.updatepwdisnullrad_busi_dport",6,"&z_internetacct_to="+$("#INTERNETACCT").text(),'business');	
        	$("#INTERNETACCT").text("");
			getfuser("");
			getfuser_lxvalue("");
        	$("#username").text("");
        	$("#useraddr").text("");			
        	$("#bm1").text("");
	        $("#bm2").text("");						
	        $("#bm3").text("");			
        	$("#bm4").text("");
        	$("#area").text("");
        	$("#usertype").text("");
        	$("#userattr").text("");
        	$("#startdate").text(""); 
			$("#enddate").text(""); 
			$("#pkgid").text("");
        	$("#status").text("");           	
        	$("#cardtype").text("");
			$("#cardid").val("");			
			$("#mobile").val("");
			$("#linkphone").val("");
			$("#linkman").val("");
			$("#dh").val("");
		}
		
		function popupQueryPanel(){
			queryRadUser_like();			
		}
		//根据字段名和字段值查询raduserinfo表. 模糊查找
		function queryRadUser_like(){
			var fieldname = $("#queryfield").val(); 
			var fieldvalue = $("#queryvalue").val();
			var s="";
			$("#tabqueryres").empty();
			s="<tr style='line-height: 22px; font-weight:bold; text-align:center;'>";
			s +="	<td width='80px'>用户账户</td>"
			s +="	<td width='100px'>用户名称</td>"
			s +="	<td>用户地址</td>"
			s +="	<td width='70px'>住宅电话</td>"
			s +="	<td width='90px'>移动电话</td>"
			s +="	</tr>";
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryRadUser_like',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');			
			if (res != undefined && res!="" && res.length>0){
				for(var i=0;i<res.length;i++){
					if (res[i][0]==undefined || res[i][1]==undefined) {continue;}				
					s += "<tr style='line-height: 22px;' id='"+res[i][0]+"' onclick=\"selectRow('"+res[i][0]+"')\"; ondblclick=\"dbclickRow('"+res[i][0]+"');\">";   					 
					s += "<td style='text-align:center'>"+res[i][0]+"</td>";
					s += "<td style='text-align:center'>"+res[i][1]+"</td>";
					s += "<td style='text-align:center'>"+res[i][2]+"</td>";
					s += "<td style='text-align:center'>"+res[i][3]+"</td>";
					s += "<td style='text-align:center'>"+res[i][4]+"</td>";
					s += "</tr>";					
				}
				if (s != ""){
					$("#tabqueryres").append(s);
				}
				autoBlockFormAndSetWH('divquery',70,'','close',"#ffffff",false,'', '');	
			}else{
				alert("没有符合条件的用户，请确认您的输入是否正确！");
				setnull();  
				$("#kdcx").attr("disabled","disabled");
				$("#queryvalue").select();
				$("#queryvalue").focus();
			}
		}	
		
		function getfuser(username){
			var str="<tr style='display:none'><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td></tr>";
			var num=0;
			var j=1;
			if(username==""){
				username="-1";
			}
			var res = fetchMultiArrayValue_rad('dbsql_rad.rad_busi_dPort',6,"&username="+username,'business');
			if (res != undefined && res!="" && res.length>0){			
				for(var i=0;i<res.length;i++){	
					var strcolor=""
					var opentype=""
					if(res[i][1]=="delete"){
						strcolor="#aaaaaa";
						opentype="还原";
					}else{
						strcolor="#000000";
						opentype="拆除";
					}				
					str += "<td class='labelclass' width='15%'>帐号"+j+":</td><td width='13%' class='tdstyle'><span style='color:"+strcolor+"'>"+res[i][0]+"</span>&nbsp;&nbsp;<a href='javascript:void(0)' style='color:red;' onclick=\"choosesetfuser('"+res[i][0]+"','"+res[i][1]+"','"+res[i][2]+"','"+res[i][3]+"')\">修改</a>&nbsp;&nbsp;<a href='javascript:void(0)' style='color:red;' onclick=\"deletefacct('"+res[i][0]+"')\">"+opentype+"</a></td>";						
					num++;
					j++;
					if(num>2){
					  str += "</tr><tr>";
					  num=0;
					}
				}	
				str += "</tr>";	
			}	
			$("#fusername_to").html(str);
		}
		
		function deletefacct(key){
			var delbzRes = executeNoQuery("dbsql_phone.deleterad_busi_dport",6,"&facct="+key,'business');
        	if(delbzRes=="true" || delbzRes==true)
        	{
				alert("操作成功，请提交！");				
			}else{
				alert("对不起，操作失败！");
			}
			getfuser($("#INTERNETACCT").text());
		}
		
		function setfuser(){
			var str="";
			var num=1;		
			var res = fetchSingleValue("dbsql_phone.querytsd_ini",6,"&tsection="+tsd.encodeURIComponent('宽带绑定帐号')+"&tident="+tsd.encodeURIComponent('绑定数目'));
			$("#bdnum").val(res);
			if (res != undefined && res!="" && res.length>0){			
				for(var i=0;i<res.length*2;i++){	
					str +="<tr style='display:none'><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td></tr>";				
					str += "<td class='labelclass'>绑定帐号("+num+"):</td><td width='13%' class='tdstyle'><input type='text' id='fusername"+num+"' style='width:150px;'/></td>";	
					str += "<td class='labelclass'>帐号密码("+num+"):</td><td width='13%' class='tdstyle'><input type='text' id='fpwd"+num+"' style='width:150px;'/></td>";										
					str += "</tr>";
					num++;
				}
			}	
			$("#addfusername").html($("#addfusername").html()+str);
		}
		
		//模糊查询面板选中一条记录，变底色		
		function selectRow(rowid){			
			$("#returnUserAcct").val(rowid);
			document.getElementById(rowid).style.background='#0080FF';
		}
		
		//模糊查询面板点确定时调用
		function setuserinfo(){
			var rows=document.getElementById('tabqueryres').getElementsByTagName('tr');		
			if (rows.length>1){
				if ($("#returnUserAcct").val()==""){
				 	alert("请先选中一条记录！");
					return;
				}				
				queryRadUser_equalReal('INTERNETACCT',$("#returnUserAcct").val());
			}
			setTimeout($.unblockUI,15);//关闭模糊查询面板
		}
		//双击查询面板中的记录行时调用
		function dbclickRow(rowid){					
			selectRow(rowid);
			setuserinfo(); 
		}
		
		function cxJob(){
			var addBzText = $("#addBzText").text();
			if(addBzText==""||addBzText==undefined){
				alert("撤销备注不能为空！");
				$("#addBzText").select().focus();
				return;
			}
        	var JobID = tsd.encodeURIComponent($("#JobID").val());
         	var param="&JobID="+JobID+"&userid="+$("#userid").val();
			var res = fetchMultiPValue("rad_busi_cx",6,param);
			if((res[0][0]!=undefined||res[0][0]!="")&&res[0][0]!="FAILED"){
				alert(res[0][0]);				
			}else{
				alert(res[0][1]);
			}
			setnull();
		}
		
		function choosesetfuser(fuser,key,pwd,jldate){
			if(key=="delete"){
				alert("该帐号已经预备拆机状态不能进行修改操作！");
				return;
			}		
			$("#oldpwd").val("");
			$("#newpwd").val("");	
			$("#fuser").val(fuser);
			$("#oldpwd").val(pwd);
			$("#jldate").val(jldate);
			autoBlockForm("choosesetfuser","150","close","#FFFFFF",false);
		}
		
		//调用宽带开户的后台存储过程
        function savedb(){  
        	//取出所有项目的值，若有可能包含中文的，都做下编码转换		
			var bdnum = $("#bdnum").val();
			var param="";
			if($("#pkgid_to").val()==""){
				alert("绑定套餐不能为空！");	
				return;
			}
			param+="&internetacct="+tsd.encodeURIComponent($("#INTERNETACCT").text());
			param+="&busitype=addport";
			param+="&userid="+tsd.encodeURIComponent($("#userid").val());
			param+="&busiarea="+tsd.encodeURIComponent($("#sArea").val());
			param+="&busifee=";
			param+="&workmemo="+tsd.encodeURIComponent("");
			param+="&busitype=addport";
			param+="&pkgid="+$("#pkgid_to").val();
			var userid = tsd.encodeURIComponent("<%=sUserId%>");
        	var department = tsd.encodeURIComponent("<%=sDepart%>");
        	var busiarea = tsd.encodeURIComponent("<%=sArea%>");
        	var busiywarea = tsd.encodeURIComponent("<%=ywarea%>");
        	param+="&department="+department+"&busiarea="+busiarea+"&busiywarea="+busiywarea;
        	var res = fetchMultiPValue_rad("rad_busi",6,param);        	      
        	if(res[0][0]=="SUCCEED"){
        		alert("办理成功");
        	}else if(res[0][0]=="FAILED"){
				alert(res[0][1]);
			}   	
			setnull();
        }
		
		function setfpwd(){
			var updateRes = executeNoQuery("dbsql_phone.updatepwdrad_busi_dport",6,"&facct="+$("#fuser").val()+"&z_acct="+$("#INTERNETACCT").text()+"&newpwd="+$("#newpwd").val(),'business');
        	if(updateRes=="true" || updateRes==true)
        	{
				alert("操作成功，请提交！");
				setTimeout($.unblockUI,15);
			}else{
				alert("对不起，操作失败！");
				setTimeout($.unblockUI,15);
			}
		}
		
		//填充下拉框内容
		function getDict(){			         
	        $.ajax({
				url:"phone_querydate?func=query",
				async:true,//异步
				cache:false,
				timeout:20000,//1000表示1秒
				type:'post',
				success:function(xml,textStatus)
				{					
				    if (InvalidSessionPro(xml)) {return false};
					var radtype = xml.substring(xml.indexOf("<radpkg=")+8,xml.indexOf("radpkg/>"));
					/*
					var count=$("#pkgid_to option").length;
					  for(var i=0;i<count;i++){
					  	 alert($("#pkgid_to").get(0).options[i].value);
						 if($("#pkgid_to").get(0).options[i].value!=11&&$("#pkgid_to").get(0).options[i].value!=''){  
							//$("#pkgid option[value='11']").remove();
							$("#pkgid_to option[value='"+$("#pkgid_to").get(0).options[i].value+"']").remove();							
						 }  				 
					  }
					 */
					 radtype="<option value=''>--请选择--</option>"
					 radtype+="<option lvalue='一端双口|11|100' value='11'>一端双口</option>"
					 $("#pkgid_to").html(radtype); 
				}		
			});
		}
		
		//根据选取的套餐，设置套餐金额输入框
		function setPkgFee(){	
			
			var res = fetchMultiArrayValue("dbsql_rad.radpkgsetenddate_new",6,"&pkgid="+$("#pkgid_to").val()+"","business");
			if(res!=undefined){
				$("#enddate").val(res[0][0]);
			}else{
				$("#enddate").val("");
			}
			$("#txtregdate").val(res[0][1]);		
			var ctlpkg = document.getElementById("pkgid_to");			
			var radfee = ctlpkg.options[ctlpkg.options.selectedIndex].lvalue;
			if (radfee!=undefined){
				var array = radfee.split("|");		
				var rescount = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=count(1)&tablename=rad_busi_dport&key=zinternetacct='"+$("#INTERNETACCT").text()+"' and nvl(delbz,'tsd')<>'destroy' and opentype='add'");		
				$("#txtmoney").text(parseFloat(array[2])*parseFloat(rescount));				
			}
			else{
				$("#txtmoney").text("0");
			} 	
		}
		
		function addfuser(){
			if($("#INTERNETACCT").text()==""){
				alert("请先查询一个主帐号！");
				return;
			}
			$("#newfusername").val("");
			$("#newfpwd").val("");
			autoBlockForm("addfusernamecloos","150","close","#FFFFFF",false);			
		}
		
		function savefuser(){
			//取出所有项目的值，若有可能包含中文的，都做下编码转换		
			var bdnum = $("#bdnum").val();
			var param="";
			var addRes="";
			/*	
			for(var i=1;i<=bdnum;i++){
				var res = fetchSingleValue_rad('dbsql_rad.radUserExist',6,"&user="+tsd.encodeURIComponent($("#fusername"+i).val().replace(/(^\s*)|(\s*$)/g,"")),'business');			
				if (res > 0){
					alert("帐号["+$("#fusername"+i).val()+"]已经存在，请重新输入！");
					$("#fusername"+i).select().focus();
					return;
				}
				if($("#fusername"+i).val()!=""&&$("#fpwd"+i).val()==""){
					alert("帐号密码不能为空！");
					$("#fpwd"+i).select().focus();
					return;
				}
				if($("#fusername0").val()==$("#fusername1").val()){
					alert("绑定帐号1跟绑定帐号2不能一样，请重新输入！");
					return;
				}
				param+="&z_acct="+$("#INTERNETACCT").text().replace(/(^\s*)|(\s*$)/g,"");
				param+="&f_acct="+$("#fusername"+i).val().replace(/(^\s*)|(\s*$)/g,"");
				param+="&f_pwd="+$("#fpwd"+i).val().replace(/(^\s*)|(\s*$)/g,"");
				if($("#fusername"+i).val()!=""){
					addRes = executeNoQuery("dbsql_phone.addfuserrad_busi_dport",6,param,'business');
				}
			}*/	
			if($("#newfusername").val().replace(/(^\s*)|(\s*$)/g,"")==""){
				alert("绑定帐号不能为空");	
				$("#newfusername").select().focus();
				return;
			}	
			var res = fetchSingleValue_rad('dbsql_rad.radUserExist',6,"&user="+tsd.encodeURIComponent($("#newfusername").val().replace(/(^\s*)|(\s*$)/g,"")),'business');			
			if (res > 0){
				alert("帐号["+$("#newfusername").val()+"]已经存在，请重新输入！");
				$("#newfusername").select().focus();
				return;
			}
			if($("#newfusername").val()!=""&&$("#newfpwd").val()==""){
					alert("帐号密码不能为空！");
					$("#newfpwd").select().focus();
					return;
			}
			param+="&z_acct="+$("#INTERNETACCT").text().replace(/(^\s*)|(\s*$)/g,"");
			param+="&f_acct="+$("#newfusername").val().replace(/(^\s*)|(\s*$)/g,"");
			param+="&f_pwd="+$("#newfpwd").val().replace(/(^\s*)|(\s*$)/g,"");
			addRes = executeNoQuery("dbsql_phone.addfuserrad_busi_dport",6,param,'business');	
        	if(addRes=="true" || addRes==true)
        	{
				alert("操作成功，请提交！");
				setTimeout($.unblockUI,15);
			}else{
				alert("对不起，操作失败！");
				setTimeout($.unblockUI,15);
			}
			setPkgFee();
			getfuser_lxvalue($("#INTERNETACCT").text());
		}
		
		function getfuser_lxvalue(username){
			var str="<tr style='display:none'><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td><td class='labelclass'></td><td width='13%' class='tdstyle'></td></tr>";
			var num=0;
			var j=1;
			if(username==""){
				username="-1";
			}
			$("#fusername_lxvalue").empty();
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryrad_busi_dPort_add',6,"&z_acct="+username,'business');
			if (res != undefined && res!="" && res.length>0){			
				for(var i=0;i<res.length;i++){	
					str += "<td class='labelclass'>绑定帐号("+j+"):</td><td width='13%' class='tdstyle'><span id=>"+res[i][0]+"</span>&nbsp;&nbsp;<a href='javascript:void(0)' style='color:red;' onclick=\"closfusers('"+res[i][0]+"')\">删除</a></td>";							
					num++;
					j++;
					if(num>3){
					  str += "</tr><tr>";
					  num=0;
					}
				}	
				str += "</tr>";					
			}			
			$("#fusername_lxvalue").html(str);
			setPkgFee();
		}
		
		function closfusers(key){
			closRes = executeNoQuery("dbsql_phone.closdeletefsuers",6,"&z_acct="+$("#INTERNETACCT").text()+"&f_acct="+key,'business');
			if(closRes=="true" || closRes==true)
        	{
				alert("操作成功，请提交！");
				setTimeout($.unblockUI,15);
			}else{
				alert("对不起，操作失败！");
				setTimeout($.unblockUI,15);
			}
			getfuser_lxvalue($("#INTERNETACCT").text());
		}
		
		function unLock(){
			executeNoQuery("dbsql_phone.deleteallrad_busi_dport",6,"&z_internetacct_to="+$("#INTERNETACCT").text(),'business');
			executeNoQuery("dbsql_phone.updatepwdisnullrad_busi_dport",6,"&z_internetacct_to="+$("#INTERNETACCT").text(),'business');
		}
	</SCRIPT> 
</head>
<body onunload="unLock()">	
	<DIV class="ui-layout-north">
		<div id="navBar1" style="margin:-10px">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />您当前所在的位置 ：		 												 													
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);" onclick="parent.history.back(); return false;">
								返回
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div style="width:100%; height:30px; text-align:left;font-weight:bold; margin-top: 25px; ">
			&nbsp;&nbsp;<img src="style/icon/65.gif" />&nbsp;&nbsp;&nbsp;&nbsp;
			查询方式:<select id="queryfield" style="width: 90px;" >
				<option value="internetacct">用户帐号</option>
				<option value="username">用户名称</option>
				<option value="useraddr">用户地址</option>
				<option value="dh">住宅电话</option>
				<option value="mobile">联系电话</option>
				<option value="area">用户区域</option>
			</select>
			<input type="text" id="queryvalue" style="width:162px;"/>
			<input  class="tsdbutton_rad" type="button" value="精确查询" onclick="queryRadUser_equal();"/>
			<input  class="tsdbutton_rad" type="button" value="模糊查询" onclick="popupQueryPanel();"/>
		</div>		
	</DIV> 	<br/>
	<table id="tdiv" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
			<tr>
			<td width="20%" class="labelclass">
				<h2>用户基本信息</h2>
			</td>
			<td width="20%" class="tdstyle" colspan=5>

			</td>
		</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">上网帐号</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="INTERNETACCT"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">用户名称</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="username"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">用户地址</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="useraddr"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">一级部门</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="bm1"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">二级部门</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">					
					<div id="bm2"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">三级部门</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="bm3"></div>
				</td>
			</tr>

			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">四级部门</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="bm4"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">营业区域</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="area"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">用户类别</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="usertype"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">用户性质</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="userattr"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">起始日期</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="startdate"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">截止日期</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="enddate"></div>
				</td>
			</tr>						
			<tr>
			   <td class="labelclass">
					<label for="sarea">
						<span id="">套餐类型</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="pkgid"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">状态</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="status"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">证件类型</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="cardtype"></div>
				</td>
			</tr>
			<tr>
			  <td class="labelclass">
					<label for="sarea">
						<span id="">证件类型</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="cardtype"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">证件号码</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="cardid"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">移动电话</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="mobile"></div>
				</td>
			</tr>
			<tr>
			  <td class="labelclass">
					<label for="sarea">
						<span id="">联系电话</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="linkphone"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">联系人</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="linkman"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">住宅电话</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="dh"></div>
				</td>
			</tr>
		</table>
		<br/>
		<table id="tdiv" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:880px;"
			cellspacing="0" cellpadding="0">
			<tr>
			<td width="20%" class="labelclass">
				<center><h2>已绑定附属帐号信息</h2></center>
			</td>
		</tr>
		 <tr>
		 <td>
		 	<table id="fusername_to" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:100%;min-width:780px;"
			cellspacing="0" cellpadding="0"></table>
		 </td>
		</tr>
	</table>
	<br/>
	<table id="" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
			<tr>
			<td width="20%" class="labelclass">
				<h2>绑定帐号</h2>
			</td>
			<td width="20%" class="tdstyle">
				&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0);" onclick="addfuser();" style="color:red">新增</a>
			</td>
			<td width="20%" class="tdstyle" colspan=4>
				
			</td>
		</tr>
	</table>	
	<table id="fusername_lxvalue" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
	</table>		
	<br/>
	<table id="" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
			<tr>
			<td width="20%" class="labelclass">
				<h2>套餐信息</h2>
			</td>
			<td width="20%" class="tdstyle" colspan=5>
			</td>
		</tr>
		<tr>
			<td class="labelclass">绑定套餐</td>
			<td width="20%" class="tdstyle">
				<select id="pkgid_to" style="width: 190px;" onchange="setPkgFee();"></select>
			</td>
			<td class="labelclass">应收金额</td>
			<td width="20%" class="tdstyle">
				<span id="txtmoney"></span>
			</td>
			<td class="labelclass"></td>
			<td width="20%" class="tdstyle"></td>
		</tr>
	</table>	
	<div id="buttons" style="text-align:center">
		<button id="kdcx" style="width:120px;" onClick="savedb()" disabled>提交</button><button id="kdback" style="width:120px;" onClick="setnull()"><!-- 返回 -->重置</button>
	</div>		
	<!-- 模糊查询结果div  -->
	<div class="neirong" id="divquery" style="width:550px;display: none">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<span>请选择您需要的记录</span>
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="setTimeout($.unblockUI,15);"><fmt:message key="global.close" /><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>
		<div class="midd" style="background-color:#FFFFFF;text-align:left;height:240px;">		
			<div id="page" style="overflow-y:scroll;height:100%;width: 100%;">					
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" id="tabqueryres" style="width: 530px;">												
				</table>
			</div>
		</div>
		<div class="midd_butt" style="width:540px;height:38px;">  
			<button id="hthChooseFormSave" onclick="setuserinfo();" class="tsdbutton" 
				style="margin-left: 20px;">
				确定
			</button>
			<button id="hthChooseFormReset" onclick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
				取消				
			</button>
			<button id="hthChooseFormsx" onclick="javascript:queryRadUser_like()" class="tsdbutton"  style="margin-left: 20px;">
				刷新				
			</button>
		</div>
	</div>
	<div class='neirong' id='choosesetfuser' style='display:none;width:780px'>
		<div class='top'>
		<div class='top_01' id='thisdrag'>
		<div class='top_01left'>
		<div class='top_02'>
		<img src='style/images/public/neibut01.gif'/>
		</div>
		<div class='top_03' id='titlediv'>
		已绑定附属帐号修改
		</div>
		</div>
		</div>
		<div class='top02right'>
		<img src='style/images/public/toptiaoright.gif' />
		</div>
		</div>
		<div class='midd' style='background-color:#FFFFFF;text-align:center;'>
		<hr style='border: 3px dotted #CCCCCC;' />
		<table cellspacing='7' style='margin-right:120px;'>
			<tr>
				<td>
					帐号密码	
				</td>
				<td>
					<input type="text" id="oldpwd" style="width:120px;" disabled="disabled"/>
				</td>
				<td>
					新帐号密码	
				</td>
				<td>
					<input type="text" id="newpwd" style="width:120px;"/>
				</td>
				<td>
					记录日期	
				</td>
				<td>
					<input type="text" id="jldate" style="width:150px;" disabled/>
				</td>
			</tr>
		</table>
		</div>
		<div class='midd_butt' style='width:765px'>
			<button id='printInDirect' class='tsdbutton' onclick='setfpwd();'>保存</button>
			<button id='printInDirect' class='tsdbutton' onclick='setTimeout($.unblockUI,1);'>关闭</button>
		</div> 
	</div>	
	
	<div class='neirong' id='addfusernamecloos' style='display:none;width:720px'>
		<div class='top'>
		<div class='top_01' id='thisdrag'>
		<div class='top_01left'>
		<div class='top_02'>
		<img src='style/images/public/neibut01.gif'/>
		</div>
		<div class='top_03' id='titlediv'>
		新增附属帐号
		</div>
		</div>
		</div>
		<div class='top02right'>
		<img src='style/images/public/toptiaoright.gif' />
		</div>
		</div>
		<div class='midd' style='background-color:#FFFFFF;text-align:center;'>
		<hr style='border: 3px dotted #CCCCCC;' />
		<table id="addfusername" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">绑定帐号</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<input type="text" id="newfusername" name="newfusername" sytle="width:150px"/>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">密码</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<input type="text" id="newfpwd" name="newfpwd" sytle="width:150px"/>
				</td>
			</tr>
	    </table>
		</div>
		<div class='midd_butt' style='width:705px'>
			<button id='printInDirect' class='tsdbutton' onclick='savefuser();'>保存</button>
			<button id='printInDirect' class='tsdbutton' onclick='setTimeout($.unblockUI,1);'>关闭</button>
		</div> 
	</div>
	<input type="hidden" id="returnUserAcct"/>
	<input type="hidden" id="IsLimitArea"/>
	<input type="hidden" id="repfile"/>
	<input type="hidden" id="ywarea" value="<%=ywarea %>"/>
	<input type="hidden" id="sArea" value="<%=sArea%>"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="userid" value="<%=sUserId%>"/>	
	<input type="hidden" id="JobID"/>
	<input type="hidden" id="bdnum"/>
	<input type="hidden" id="fuser"/>
	<!-- 弹出报表打印框 -->	
	<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>	
</body>
</thml>