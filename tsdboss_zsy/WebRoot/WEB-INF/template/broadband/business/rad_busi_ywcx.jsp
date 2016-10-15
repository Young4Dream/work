<%----------------------------------------
	name: rad_busi_ywcx.jsp
	author: wenxuming
	version: 1.0 
	description: 业务撤销
	Date: 2012-03-20
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
		.tdstyle{height:30px;}
	</style>	
	<script type="text/javascript">			
		$(document).ready(function () {					
			$("#navBar").append(genNavv());																		
		});	
		
		//根据字段名和字段值查询raduserinfo表. 精确查找
		function queryRadUser_equal(){
			var fieldname = $("#queryfield").val(); 
			var fieldvalue = $("#queryvalue").val();
			queryRadUser_equalReal(fieldname,fieldvalue);			
		}
		function queryRadUser_equalReal(fieldname,fieldvalue){
			var res = fetchMultiArrayValue_rad('dbsql_rad.queryradjobvalue',6,"&fieldname="+fieldname+"&fieldvalue="+tsd.encodeURIComponent(fieldvalue),'business');
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
			setnull();  
			$("#kdcx").removeAttr("disabled"); 	
        	$("#Area").text(arr[0][0]);
        	$("#BILLNO").text(arr[0][1]);
        	$("#BUSIID").text(arr[0][2]);
        	$("#BUSITYPE").text(arr[0][3]);
			if(arr[0][4]=="Y"){
	        	$("#CANCEL").text("是");			
			}else{
				$("#CANCEL").text("否");			
			}
			if(arr[0][5]=="Y"){
	        	$("#COMPLETE").text("是");			
			}else{
				$("#COMPLETE").text("否");			
			}
        	$("#COMPLETEDATE").text(arr[0][6]);
        	$("#DEPT").text(arr[0][7]);
        	$("#Fee").text(arr[0][8]);
        	$("#INTERNETACCT").text(arr[0][9]);
        	$("#JOBDATE").text(arr[0][10]); 
			if(arr[0][11]=="normal"){
				$("#STATUS").text("正常");
			}else if(arr[0][11]=="cancel"){
				$("#STATUS").text("撤销");
			}else if(arr[0][11]=="destroy"){
				$("#STATUS").text("废单");
			}else if(arr[0][11]=="pause"){
				$("#STATUS").text("挂起");
			}    	        	
        	
			if(arr[0][12]=="normal"){
			    $("#URGENT").text("普通");
			}else if(arr[0][12]=="urgent"){
				$("#URGENT").text("紧急");
			}
        	$("#UserID").text(arr[0][13]);           	
        	$("#memo").text(arr[0][14]);
			$("#JobID").val(arr[0][15]);
        	//inLock("move",arr[0][0]);	
		}
		
		function setnull(){
        	$("#Area").text("");
        	$("#BILLNO").text("");
        	$("#BUSIID").text("");
        	$("#BUSITYPE").text("");
        	$("#CANCEL").text("");
        	$("#COMPLETE").text("");
        	$("#COMPLETEDATE").text("");
        	$("#DEPT").text("");
        	$("#Fee").text("");
        	$("#INTERNETACCT").text("");
        	$("#JOBDATE").text("");        	        	
        	$("#STATUS").text("");
        	$("#URGENT").text("");
        	$("#UserID").text("");           	
        	$("#memo").text("");
			$("#JobID").val("");
			$("#addBzText").val("");
			$("#queryvalue").val("");
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
			var addBzText = $("#addBzText").val();
			if(addBzText==""||addBzText==undefined){
				alert("撤销备注不能为空！");
				$("#addBzText").select().focus();
				return;
			}
			var addBzText = $("#addBzText").val();
        	var JobID = tsd.encodeURIComponent($("#JobID").val());
         	var param="&JobID="+JobID+"&userid="+$("#userid").val()+"&bz="+tsd.encodeURIComponent(addBzText);
			var res = fetchMultiPValue("rad_busi_cx",6,param);
			if((res[0][0]!=undefined||res[0][0]!="")&&res[0][0]!="FAILED"){
				alert(res[0][0]);				
			}else{
				alert(res[0][1]);
			}
			setnull();
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
				<option value="dh">住宅电话</option>
				<option value="username">用户名称</option>
				<option value="useraddr">用户地址</option>
				<option value="internetacct">宽带账号</option>
			</select>
			<input type="text" id="queryvalue" style="width:162px;"/>
			<input  class="tsdbutton_rad" type="button" value="精确查询" onclick="queryRadUser_equal();"/>
			<input  class="tsdbutton_rad" type="button" value="模糊查询" onclick="popupQueryPanel();"/>
		</div>		
	</DIV> 	<br/><br/>
	<table id="tdiv" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">宽带账号</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="INTERNETACCT"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">业务类型</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="BUSITYPE"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">受理区域</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="Area"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">工单状态</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="STATUS"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">紧急状态</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">					
					<div id="URGENT"></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">受理人员</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="UserID"></div>
				</td>
			</tr>

			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">是否撤销</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="CANCEL"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">是否完工</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="COMPLETE"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">完工日期</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="COMPLETEDATE"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">业务手续费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="Fee"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">业务流水号</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="BILLNO"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">受理人员部门</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="DEPT"></div>
				</td>
			</tr>						
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">业务受理日期</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="JOBDATE"></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">备注</span>
					</label>
				</td>
				<td width="20%" class="tdstyle" colspan=5>
					<div id="memo"></div>
				</td>
			</tr>
		</table>
		<br/>
	<table border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">	
		<tr>
			<td width="20%" class="labelclass">
				<h2>撤销备注</h2>
			</td>
			<td width="20%" class="tdstyle" colspan=5>
	<textarea id="addBzText" style="width:500px;height:100px;" onKeyDown="if(this.value.length>100){alert('备注信息最大长度为100个字符');this.value=this.value.substring(0,100);event.returnValue=false;}"></textarea>
			</td>
		</tr>
		<tr>
				<td class="">
					<label for="sarea">
						<span id=""></span>
					</label>
				</td>

				<td width="20%" class="">
				</td>

				<td class="">
					<label for="sarea">
						<span id=""></span>
					</label>
				</td>

				<td width="20%" class="">
					<div id="JOBDATE"></div>
				</td>

				<td class="">
					<label for="sarea">
						<span id="thisPayMode"></span>
					</label>
				</td>

				<td width="20%" class="">
					<div id="thisPayModevalue"></div>
				</td>
			</tr>
	</table>
	<div id="buttons" style="text-align:center">
		<button id="kdcx" style="width:120px;" onClick="cxJob()" disabled><!-- 撤销 -->撤销</button><button id="kdback" style="width:120px;" onClick="setnull()"><!-- 返回 -->重置</button>
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
	<input type="hidden" id="returnUserAcct"/>
	<input type="hidden" id="IsLimitArea"/>
	<input type="hidden" id="repfile"/>
	<input type="hidden" id="ywarea" value="<%=ywarea %>"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id="userid" value="<%=sUserId%>"/>	
	<input type="hidden" id="JobID"/>
	<!-- 弹出报表打印框 -->	
	<div id="businessreprint"></div><!-- 加载的文件在script/telephone/business/businessreprint.js -->  
	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>	
</body>
</thml>