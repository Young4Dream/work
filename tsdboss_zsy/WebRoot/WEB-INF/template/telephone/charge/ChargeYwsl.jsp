<%-- *******************************************************************************
**          *******         ******  *******     **       *****                   **  
**             *            *          *       ** **     *    *                  **
**             *   ******   ******     *      **   **    *****                   ** 
**             *                 *     *     ** *** **   *  *                    **
**             *            ******     *    **       **  *    *                  **
**                                                                               **               
** name:    "WebRoot/WEB-INF/template/telephone/charge/CahrgeYwsl.jsp"           **
** author:  chenliang                                                            **
** date:    2012-08-31                                                           **
** desc:    电话业务受理费用一次性费用收取                                                   **
******************************************************************************** --%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="com.tsd.service.util.Log"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
	String userid = (String) session.getAttribute("userid");
	String languageType = (String) session.getAttribute("languageType");
	String depart = (String) session.getAttribute("departname");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>ChargeYwsl</title>
    <!-- jquery的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="script/public/main.js" type="text/javascript"></script>
	<script src="script/public/revenue.js" type="text/javascript"></script>
	<!-- 导航专用 -->
	<script src="script/public/navigationbar.js" type="text/javascript"></script>
	<!-- 字符串处理、解析专用 -->
	<script src="script/public/tsdstring.js" type="text/javascript"></script>
	<!-- 导入css文件开始 -->
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript">
$(function(){
	initialBar();
	$('#phoneno').focus();

	$("#fufeitype").empty();
	var querysel='';
	var res = fetchMultiArrayValue("dbsql_phone.queryphoneconfigkemu",6,"&kemu=pbusinessfee&tsection=payitem");
	if(res[0]==undefined || res[0][0]==undefined)
	{
		return false;
	}
	for(var i=0;i<res.length;i++){
		querysel+="<option value="+res[i][0]+" flf='"+res[i][2]+"'>"+res[i][1]+"</option>";
	}
	$("#fufeitype").html(querysel);
	$("#fufeitype").val("tuoshou");
	
	$("#zpnumbertext").hide();
	$("#zpnumber").hide();
});
//加载用户信息
function loadBusiInfo(){
	//获取输入的电话号码或合同号
	var sPhoneno = $('#phoneno').val();
	if(sPhoneno == ''){
		alert('请输入要查询的电话号码或合同号');
		$('#phoneno').focus();
		return false;
	}else{
		//判断是否有未缴清的一次性受理费
		var sBusiInfo = fetchMultiArrayValue('ChargeYwsl.querybusiinfo',6,'&dh='+sPhoneno);
		var thisfee = 0;
		var tofeehw=false;
		//工单表数据更新
		var jobidlist = new Array();
		if(sBusiInfo[0][0] != undefined){
		    var resslbm = fetchMultiArrayValue('ChargeYwsl.querymaxpgid',6,'&id='+sBusiInfo[0][0]+"&busitype="+sBusiInfo[0][0]);			
			if(resslbm[0][0]<=resslbm[0][1]&&resslbm[0][0]!=0){
				alert("工单流程没有走到配置可收费部门，请等待确认！");
				return;
			}
			var busiDiv = '';
			for(var i = 0 ; i < sBusiInfo.length;i++){
				thisfee += sBusiInfo[i][7]*1;
				jobidlist.push(sBusiInfo[i][0]);
				busiDiv += '<label>业务名称：</label><span>'+sBusiInfo[i][1]+'</span><label>受理时间：</label><span>'+sBusiInfo[i][2]+'</span><label>受理人：</label><span>'+sBusiInfo[i][3]+'</span>'+
						   '<label>受理站点：</label><span>'+sBusiInfo[i][4]+'</span><label>联系人：</label><span>'+sBusiInfo[i][5]+'</span><label>联系电话：</label><span>'+sBusiInfo[i][6]+'</span><label>未缴费用：</label><span>'+sBusiInfo[i][7]+'</span><label>未缴款项：</label><span style="width:408px;">'+sBusiInfo[i][8]+'</span>'+
						   '<label>备注信息：</label><span style="width:656px;">'+sBusiInfo[i][9]+'</span>';
			}
		}else{
			var sBusiInfo = fetchMultiArrayValue('ChargeYwsl.querybusiinfo.tf',6,'&dh='+sPhoneno);
			
			if(sBusiInfo[0][0] != undefined){
				var busiDiv = '';
				for(var i = 0 ; i < 1;i++){
					thisfee += sBusiInfo[i][7]*1;
					jobidlist.push(sBusiInfo[i][0]);
					busiDiv += '<label>业务名称：</label><span>'+sBusiInfo[i][1]+'</span><label>受理时间：</label><span>'+sBusiInfo[i][2]+'</span><label>受理人：</label><span>'+sBusiInfo[i][3]+'</span>'+
							   '<label>受理站点：</label><span>'+sBusiInfo[i][4]+'</span><label>联系人：</label><span>'+sBusiInfo[i][5]+'</span><label>联系电话：</label><span>'+sBusiInfo[i][6]+'</span><label>已缴费用：</label><span>'+sBusiInfo[i][7]+'</span><label>已缴款项：</label><span style="width:408px;">'+sBusiInfo[i][8]+'</span>'+
							   '<label>备注信息：</label><span style="width:656px;">'+sBusiInfo[i][9]+'</span>';
					$("#spanbasic0").text(sBusiInfo[i][10]);	
					$("#spanbasic3").text(sBusiInfo[i][11]);	   
				}
				tofeehw=true;
			
			//alert(sBusiInfo);
			}else{
				alert('用户【'+sPhoneno+'】暂无可收取的一次性受理费');
				dataReset();
				$('#phoneno').focus();
				return false;
			}
		}
		//alert(sBusiInfo.length);		
		$('#displayInfo').empty();
		$('#busiInfo').hide();
		$('#displayInfo').show();
		$('#displayInfo').html(busiDiv);
		$("#zpnumbertext").hide();
	    $("#zpnumber").hide();
		$("#zpnumber").val("");
		//用户基本信息
		var sBasiInfo = fetchMultiArrayValue('ChargeYwsl.querybasicinfo',6,'&dh='+sPhoneno);
		if(sBasiInfo[0][0] != undefined){
			for(var i = 0 ; i < sBasiInfo[0].length ; i++){
				$('#spanbasic'+i).text(sBasiInfo[0][i]);
			}
		}
		$('#jobidlist').val(jobidlist.join(','));
		$('#thisfee').val(thisfee);
		$('#feeget').focus();
		$('#tofee').show();
		$('#tofee_1').hide();
		$("#feesave").text("缴费");
		if(tofeehw){
			$('#tofee').hide();
			$('#tofee_1').show();
			$('#thisfee_1').text(thisfee);
			$("#feesave").text("退费");
		}
	}
}
//递交金额输入框回事事件
function KeyDown_DJBox(event){
	if(event.keyCode==13){
		//取应交金额的值
		var yj = $("#thisfee").val();
		yj=parseFloat(yj,10);
		//取递交金额的值
		var dj = $("#feeget").val();
		dj=parseFloat(dj,10);
		if(isNaN(dj)) dj=0;
		//检测是否已进行用户查询
		if($('#phoneno').val() == ''){
			alert("请先进行用户查询");
			$("#feeget").val('');
			$("#phoneno").select().focus();
			return false;
		}
		if(dj==0)
		{					
			alert("递交金额不能等于0");
			$("#feeget").select().focus();
			return false;
		}
		//判断递交金额是否小于应缴金额
		if(dj-yj<0)
		{
			alert("递交金额不能小于本次应缴");
			$("#feeget").select().focus();
			return false;
		}
		//判断是否有递交金额
		//$("#ghSs").val($("#ghDJ").val()).select().focus();
		var ifee = dj-yj;
		$('#feeset').val(parseFloat(ifee,10).toFixed(2)).select().focus();
	}
}
//业务费收取成功之后进行数据更新
function busiFeeUpdate(){
	var jobidlist = $('#jobidlist').val();
	var resarr = jobidlist.split(',');
	var flag = false;
	var jobarr = new Array();
	if($("#feesave").text()=="缴费"){
		if($("#fufeitype").val()=="")return;
		for(var i in resarr){
			var res = executeNoQuery('ChargeYwsl.updatebusiinfo',6,'&skr=<%=userid %>&id='+resarr[i]+'&ispay='+$("#fufeitype").val()+"&zpnum="+$("#zpnumber").val().replace(/(^\s*)|(\s*$)/g,""));
			if(res)flag=res;
			if(res==true||res=="true"){
				executeNoQuery('ChargeYwsl.updatebusiinfo_hthmc',6,'&idto='+resarr[i]);
				executeNoQuery('ChargeYwsl.updatebusiinfo_yhmc',6,'&idto='+resarr[i]);
			}
			jobarr.push("'"+resarr[i]+"'");
		}
	}else if($("#feesave").text()=="退费"){
		//在这里写 退费要执行的sql
		for(var i in resarr){
			var res = executeNoQuery('ChargeYwsl.updatebusiinfo.tf',6,'&skr=<%=userid %>&id='+resarr[i]+"&dh="+$("#phoneno").val());
			if(res)flag=res;//退费成功 给flag 为 true;
			jobarr.push("'"+resarr[i]+"'");
		}
	}
	if(flag){
		alert($("#feesave").text()+'成功');
		tsdRptPrint(jobarr.join(','));
		$('#feeget').focus();
		$('#tofee').show();
		$('#tofee_1').hide();
		$("#feesave").text("缴费");
	}else{
		alert($("#feesave").text()+'失败');
	}
}
//监听回车
function KeyDown_PhoneBox(event){
	if(event.keyCode==13){
		$("#phoneSearch").click();
	}
}
//实收金额显示用户数据
function KeyDown_SsjeBox(event)
{
	if(event.keyCode==13)
	{
		if (document.getElementById("feesave").disabled==false)
		{
			//执行保存
			$("#feesave").click();
		}
	}
}
//报表打印
function tsdRptPrint(joblist){
	var thisJobid = '';
	if(joblist.indexOf(',')!=-1){
		thisJobid = joblist.substring(0,joblist.lastIndexOf(','))
	}else{
		thisJobid = joblist;
	}
	var params = '&jobid='+thisJobid;
	var sVal = fetchMultiArrayValue('ChargeYwsl.queryFeeVal',6,'&jobid='+joblist);
	if(sVal[0][0] != undefined){
		params += '&yjkx='+ tsd.encodeURIComponent(sVal[0][0]);
		params += '&yjje='+sVal[0][1];
	}
	
	
	//判断是缴费打印还是退费打印
	if($("#feesave").text()=="缴费"){
			//记录日志信息
		var loginfo = '';//日志
		loginfo += '【应缴款项】：' + sVal[0][0] + '；';
		loginfo += '【应缴金额】：' + sVal[0][1] + '；';
		loginfo += '【业务工单ID】：' + joblist.replace(/'/g,'') + '；';
		writeLogInfo('','modify',tsd.encodeURIComponent(loginfo));

		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/charge/busiCharge.cpt"+params;
	}else if($("#feesave").text()=="退费"){
		//记录日志信息
		var loginfo = '';//日志
		loginfo += '【应退款项】：' + sVal[0][0] + '；';
		loginfo += '【应退金额】：' + sVal[0][1] + '；';
		loginfo += '【业务工单ID】：' + joblist.replace(/'/g,'') + '；';
		writeLogInfo('','modify',tsd.encodeURIComponent(loginfo));
		params += '&numb='+$("#phoneno").val();
		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/charge/busiCharge_tf.cpt"+params;
	}
	//调打印预览窗口
	window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
	//信息数据重置
	dataReset();
}
//直接打印
function printWithoutPreview(reportname,paramvalue){
	document.getElementById('printReportDirect').contentWindow.RepPri(reportname,paramvalue);
}
//只允许录入数据字符 0-9 和小数点
function tsdNumCheck(objTR){
   var txtval = objTR.value;
   if(/.*[\u4e00-\u9fa5]+.*$/.test(txtval)){ 
     alert("金额不能含有汉字！");
     objTR.value = ''; 
   }else{
     var key = event.keyCode;
     if((key < 48||key > 57) && key != 46 ){
       event.keyCode = 0;
     }else{
       if(key == 46){
         if(txtval.indexOf(".") != -1 || txtval.length == 0){
       	   event.keyCode = 0;
         }
       }
     }
   }
}
//数据信息重置
function dataReset(){
	for(var i = 0 ; i < 5;i++){
		$('#spanbasic'+i).text('');
	}
	$('#busiInfo').show();
	$('#displayInfo').hide();
	$('#phoneno,#thisfee,#feeget,#feeset').val('');
	$('#phoneno').focus();
	$('#tofee').show();
	$('#tofee_1').hide();
	$("#feesave").text("缴费");
	$("#zpnumber").val("");
}


function payWayChange(){
    if($("#fufeitype").val()=="cheque"){
		$("#zpnumbertext").show();
		$("#zpnumber").show();
	}else{
		$("#zpnumbertext").hide();
		$("#zpnumber").hide();
	}
	$("#zpnumber").val("");
}
</script>
	<style type="text/css">
		body{background-color:#FFFFFF;}
		.tsdbtn {height:30px;margin-top:0px;BORDER-RIGHT: #87CEFA 1px solid; PADDING-RIGHT: 5px; BORDER-TOP: #87CEFA 1px solid; PADDING-LEFT: 5px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr=#FFFFFF, EndColorStr=#87CEFA); BORDER-LEFT: #87CEFA 1px solid; CURSOR: hand;COLOR: black; PADDING-TOP: 1px; BORDER-BOTTOM: #87CEFA 1px solid}
		label {float: left;margin-left: 10px;width: 80px;height:22px;line-height:22px;font-size:14px;background-color:#E8E9E8;text-align:right;}
		hr{margin:2px 0 2px 0;border:0;border-top:1px dashed #CCCCCC;height:0;}
		.tsddivstyle{width:760px;margin-top:2px}
		#basicInfo label{margin:2px;}
		#basicInfo span{word-wrap:break-word;display:-moz-inline-box;display:inline-block;width:160px;float:left;min-height:22px;line-height:22px;font-size:14px;margin:2px;border:1px; background:#E8E9E8}
		#queryDiv label{margin: 2px;text-align:right}
		#queryDiv span{display:-moz-inline-box;display:inline-block;width:120px;float:left;height:22px;line-height:22px;font-size:14px;}
		#infodiv label{margin:2px;text-align:right;}
		#infodiv span{word-wrap:break-word;display:-moz-inline-box;display:inline-block;width:160px;float:left;min-height:22px;line-height:22px;font-size:14px;margin:2px;border:1px; background:#E8E9E8}
		#tofee label{margin:2px;}
		#tofee span{word-wrap:break-word;display:-moz-inline-box;display:inline-block;width:160px;float:left;min-height:22px;line-height:22px;font-size:14px;margin:2px;border:1px; background:#E8E9E8}		
		#basicInfo option{word-wrap:break-word;display:-moz-inline-box;display:inline-block;width:160px;float:left;min-height:22px;line-height:22px;font-size:14px;margin:2px;border:1px; background:#E8E9E8}
		#tofee_1 {word-wrap:break-word;display:-moz-inline-box;display:inline-block;width:160px;float:left;min-height:22px;line-height:22px;font-size:30px;margin:2px;border:1px;}
		#tofee_1 span,h1{font-size:16px;color:red;}
		
		#tofee_zph label{margin:2px;}
		#tofee_zph span{word-wrap:break-word;display:-moz-inline-box;display:inline-block;width:160px;float:left;min-height:22px;line-height:22px;font-size:14px;margin:2px;border:1px; background:#E8E9E8}
	</style>
  </head>
  
  <body>
  	<!-- 菜单导航 -->
	<div id="navBar">&nbsp;&nbsp;<img src="style/icon/dot11.gif"/><fmt:message key="global.location" />:</div>
	<!-- 查询信息 -->
	<hr />
	<div id="queryDiv">
		<label>电话号码：</label>
		<span><input type="text" id="phoneno" onpaste="javascript:$('#phoneno').trigger('keydown');" onkeydown="KeyDown_PhoneBox(event);"
				style="height:22px;line-height:22px;font-size:14px;margin-left:2px"/></span>
		<button type="button" id="phoneSearch" class="tsdbtn" style="width: 60px;margin-left:45px" onclick="loadBusiInfo()">
		查询
		</button>
	</div>
	<hr />
	<!-- 页面显示信息 -->
	<div id="basicInfo" class="tsddivstyle">
		<label>用户名称：</label><span id="spanbasic0"></span>
		<label>所在部门：</label><span id="spanbasic1"></span>
		<label>所属站：</label><span id="spanbasic2"></span>
		<label>合同号：</label><span id="spanbasic3"></span>
		<label>用户地址：</label><span id="spanbasic4"></span>
		<label>付费方式：</label><span id="spanbasic5"><select onchange="payWayChange()" class="you1" style="width: 150px" id="fufeitype" name="fufeitype"><option flf="commonreport/fixedphone_zjsfee" value="">--请选择--</option></select></span>
	</div>
	<div id="infodiv">
		<span id="busiid" style="display: none"></span>
		<div id="busiInfo" class="tsddivstyle">
			<label>业务名称：</label><span></span>
			<label>受理时间：</label><span></span>
			<label>受理人：</label><span></span>
			<label>受理站点：</label><span></span>
			<label>联系人：</label><span></span>
			<label>联系电话：</label><span></span>
			<label>未缴费用：</label><span></span>
			<label>未缴款项：</label><span style="width:408px;"></span>
			<label>备注信息：</label><span style="width:656px;"></span>
		</div>
		<div id="displayInfo" class="tsddivstyle" style="display: none"></div>
	</div>
	<hr/>
	<label id="zpnumbertext">支票号：</label><input type="text" id="zpnumber" style="height:22px;line-height:22px;font-size:14px;" 
					style="ime-mode: disabled; width: 200px;ime-mode:disabled"
					onpaste="return !clipboardData.getData('text').match(/\D/)"
					ondragenter="return   false" onkeypress="javascript:tsdNumCheck(this)"
					onkeydown="KeyDown_DJBox(event);"/>
	<br /><br />
	<!-- 缴费输入区域 -->
	<div id="tofee" >
		<label>本次应缴：</label>
		<span><input type="text" id="thisfee" style="height:22px;line-height:22px;font-size:14px;" readonly="readonly"/></span>
		<label>递交金额：</label>
		<span><input type="text" id="feeget" style="height:22px;line-height:22px;font-size:14px;" 
					style="ime-mode: disabled; width: 120px;ime-mode:disabled"
					onpaste="return !clipboardData.getData('text').match(/\D/)"
					ondragenter="return   false" onkeypress="javascript:tsdNumCheck(this)"
					onkeydown="KeyDown_DJBox(event);"/></span>
		<label>应找金额：</label>
		<span><input type="text" id="feeset" style="height:22px;line-height:22px;font-size:14px;" 
				readonly="readonly"
				onkeydown="KeyDown_SsjeBox(event);" /></span>		
	</div>	
	<div id="tofee_1" style="display: none;">
		<h1>本次退费金额：<span id=thisfee_1></span></h1>
	</div>
	<br /><br /><br />
	<hr />
	<button type="button" id="feesave" class="tsdbtn" style="width: 60px;margin-left:250px;" onclick="busiFeeUpdate()">
		缴费
	</button>
	<button type="button" class="tsdbtn" style="width: 60px;margin-left:15px" onclick="dataReset()">
		重置
	</button>
	<!-- 打印票据 -->
	<iframe id="printReportDirect" style="width: 120px; height: 0px; visibility: visible" src="print.jsp"></iframe>
	<input type="hidden" id="jobidlist" />
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
  </body>
</html>
