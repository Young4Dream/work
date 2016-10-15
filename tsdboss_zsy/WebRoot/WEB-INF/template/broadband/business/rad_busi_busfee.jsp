<%-- *******************************************************************************
**          *******         ******  *******     **       *****                   **  
**             *            *          *       ** **     *    *                  **
**             *   ******   ******     *      **   **    *****                   ** 
**             *                 *     *     ** *** **   *  *                    **
**             *            ******     *    **       **  *    *                  **
**                                                                               **               
** name:    "WebRoot/WEB-INF/template/broadband/business/rad_busi_busfee.jsp"    **
** author:  huoshuai                                                             **
** date:    2012-12-23                                                           **
** desc:    宽带业务受理费用一次性费用收取                                                   **
******************************************************************************** --%>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="com.tsd.service.util.Log"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
	String userid = (String) session.getAttribute("userid");
	String languageType = (String) session.getAttribute("languageType");
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
	<script src="script/broadband/business/broadbandservice.js" type="text/javascript"></script>	
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
	
	$("#zpnumbertext").hide();
	$("#zpnumber").hide();
	getDict();
});
//加载用户信息
function loadBusiInfo(){
	//获取输入的电话号码或合同号
	var internetacct = $('#txtinternet').val();
	if(internetacct == ''){
		alert('请输入要查询的宽带账号');
		$('#txtinternet').focus();
		return false;
	}else{
		//判断是否有未缴清的一次性受理费
		var res = fetchMultiArrayValue('rad_busi_busifee.queryInfo',6,'&internetacct='+internetacct,'business');
		if(res != undefined && res != "" && res != null){
			var busiDiv = '';
				$("#hidjfid").val(res[0][0]);
				$("#spanbasic1").text(res[0][1]);
				$("#spanbasic0").text(res[0][2]);	
				$("#spanbasic2").text(res[0][3]);	
				$("#spanbasic3").text(res[0][4]);	
				$("#spanbasic5").text(res[0][6]);
				$("#spanbasic6").text(res[0][18]);	
				$("#hidcallpaytype").val(res[0][7]);
				$("#businame").text(res[0][17]);	
				if(res[0][17]=="退费"){
					$("#ptab").hide();
					$("#tofee_1").show();
				}else{
					$("#ptab").show();
					$("#tofee_1").hide();
				}
				$("#busifee").text(res[0][9]);	
				$("#zafee").text(res[0][11]);	
				$("#busiarea").text(res[0][12]);	
				$("#busioper").text(res[0][13]);	
				$("#busidate").text(res[0][14]);	
				$("#busiremark").text(res[0][15]);	
				
				$("#thisfee").val(res[0][16]);	
				$("#hidjobid").val(res[0][5]);
		}else{
			alert('用户【'+internetacct+'】暂无可收取的一次性受理费');
			dataReset();
			$('#txtinternet').focus();
			return false;
		}
	}
}
//递交金额输入框回事事件
function KeyDown_DJBox(event){
	if(event.keyCode==13){
		var feename=$("#businame").text();
		if(feename=="退费"){
			
		}else{
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
}
function Blur_DJBox(){
		var feename=$("#businame").text();
		if(feename=="退费"){
			
		}else{
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
		    //取缴费方式 返回的是html格式
		    var payitem = xml.substring(xml.indexOf("<radpayitem=")+12,xml.indexOf("radpayitem/>"));
		    
			$("#fufeitype").html(payitem);
			$("#fufeitype").val("cash");
		}		
	});
}
//业务费收取成功之后进行数据更新
function busiFeeUpdate(){
	var jobidlist = $('#jobidlist').val();
	var resarr = jobidlist.split(',');
	var flag = false;
	if($("#feesave").text()=="提交"){
		if($("#fufeitype").val()==""){
			return;
		}else if($("#fufeitype").val()=='cheque'){
			if($("#txtcheque").val()==""){
				alert("请填写支票号！");
				$("#txtcheque").focus();
				return;
			}
		}
		var res = executeNoQuery_rad('rad_busi_busifee.updateInfo',6,'&userid='+$("#userloginid").val()+'&id='+$("#hidjfid").val()+'&payitem='+$("#fufeitype").val()+"&zpnum="+$("#txtcheque").val());
		if(res){	flag=res	};
	}else if($("#feesave").text()=="退费"){
		
	}
	if(flag){
		alert('操作成功');
		tsdRptPrint();		
		$("#feesave").text("提交");
	}else{
		alert('操作失败');
	}
}
function executeNoQuery_rad(key,dss,param)
{
	var result = false;
	var urll = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'broadband',
				tsdcf:'oracle_business',//指向配置文件名称
				tsdoper:'exe',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:key
				});
	$.ajax({
		url:"mainServlet.html?" + urll + param,
		async:false,
		cache:false,
		timeout:1000,
		type:'post',
		success:function(xml){result = xml;}		
	});
	return result;
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
function tsdRptPrint(){
	
	var params="";
	params+= "&jobid="+$("#hidjobid").val();
	//判断是缴费打印还是退费打印
	if($("#feesave").text()=="提交"){
		//记录日志信息
		var loginfo = '';//日志
		loginfo += '【业务类型】：' + $("#businame").text() + '；';
		loginfo += '【应缴金额】：' + $("#thisfee").text() + '；';
		//loginfo += '【业务工单ID】：' + joblist.replace(/'/g,'') + '；';
		writeLogInfo('','modify',tsd.encodeURIComponent(loginfo));

		var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/charge/rad_busiCharge.cpt"+params;
	}else if($("#feesave").text()=="退费"){
		
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
	$("#hidjfid").val('');
	$("#spanbasic1").text('');
	$("#spanbasic0").text('');	
	$("#spanbasic2").text('');	
	$("#spanbasic3").text('');	
	//$("#spanbasic4").text('');	
	$("#spanbasic5").text('');	
	$("#spanbasic6").text('');	
	$("#businame").text('');	
	$("#busifee").text('');	
	$("#zafee").text('');	
	$("#busiarea").text('');	
	$("#busioper").text('');	
	$("#busidate").text('');	
	$("#busiremark").text('');	
	$("#fufeitype").val('cash');
	$("#txtcheque").val('');
	$("#txtcheque").attr('disabled','disabled');
	$("#thisfee").val('');	
	$("#feeget").val('');
	$("#feeset").val('');
	$("#ptab").show();
	$("#tofee_1").hide();
	$("#feesave").text("提交");
}


function payWayChange(){
    if($("#fufeitype").val()=="cheque"){
		$("#txtcheque").attr("disabled","");
		$("#txtcheque").val('');
		$("#txtcheque").focus();
	}else{
		$("#txtcheque").val('');
		$("#txtcheque").attr("disabled","disabled");
	}
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
	</style>
  </head>
  
  <body>
  	<!-- 菜单导航 -->
	<div id="navBar">&nbsp;&nbsp;<img src="style/icon/dot11.gif"/><fmt:message key="global.location" />:</div>
	<!-- 查询信息 -->
	<hr />
	<div id="queryDiv">
		<label style="background-color: #ffffff;">宽带账号：</label>
		<span><input type="text" id="txtinternet" onpaste="javascript:$('#phoneno').trigger('keydown');" onkeydown="KeyDown_PhoneBox(event);"
				style="height:22px;line-height:22px;font-size:14px;margin-left:2px"/></span>
		<button type="button" id="btnSearch" style="width: 60px;height:25px;margin-left:45px" onclick="loadBusiInfo()">
		查询
		</button>
	</div>
	<hr />
	<!-- 页面显示信息 -->
	<div id="basicInfo" class="tsddivstyle">
		<label>用户名称：</label><span id="spanbasic1" style="width: 407px;"></span>
		<label>宽带账号：</label><span id="spanbasic0"></span>
	</div>
	<div id="basicInfo" class="tsddivstyle">
		<label>业务区域：</label><span id="spanbasic2"></span>
		<label>用户地址：</label><span id="spanbasic3" style="width: 407px;"></span>
	</div>
	<div id="basicInfo" class="tsddivstyle">
		<!-- label>联系人：</label><span id="spanbasic4"></span>
		<label>联系电话：</label><span id="spanbasic5"></span -->
		<label>付费类型：</label><span id="spanbasic6"></span>
		<label>上网套餐：</label><span id="spanbasic5" style="width: 407px;"></span>		
	</div>
	<div id="infodiv">
		<span id="busiid" style="display: none"></span>
		<div id="busiInfo" class="tsddivstyle">
			<label>业务名称：</label><span id="businame"></span>
			<label>套餐费：</label><span id="busifee"></span>
			<label>业务费：</label><span id="zafee"></span>
			<label>受理站点：</label><span id="busiarea"></span>
			<label>受理人：</label><span id="busioper"></span>
			<label>受理时间：</label><span id="busidate"></span>
			<label>备注信息：</label><span style="width:656px;" id="busiremark"></span>
		</div>
		<div id="displayInfo" class="tsddivstyle" style="display: none"></div>
	</div>
	<hr/>
	<!-- 缴费输入区域 -->
	<table id="ptab">
		<tr>
			<td><label style="background-color: #ffffff;">付款方式：</label></td>
			<td><span><select onchange="payWayChange()" class="you1" style="width: 150px" id="fufeitype" name="fufeitype"><option flf="commonreport/fixedphone_zjsfee" value="">--请选择--</option></select></span></td>
			<td><label style="background-color: #ffffff;">支票号：</label></td>
			<td>
				<span><input type="text" id="txtcheque" disabled="disabled" style="height:22px;line-height:22px;font-size:14px;" 
					style="ime-mode: disabled; width: 120px;ime-mode:disabled"
					onpaste="return !clipboardData.getData('text').match(/\D/)"
					ondragenter="return   false"/></span>
			</td>
		</tr>
		<tr>
			<td><label style="background-color: #ffffff;">本次应缴：</label></td>
			<td><span><input type="text" id="thisfee" style="height:22px;line-height:22px;font-size:14px;" disabled="disabled"/></span></td>
			<td><label style="background-color: #ffffff;">递交金额：</label></td>
			<td>
				<span><input type="text" id="feeget" style="height:22px;line-height:22px;font-size:14px;" 
					style="ime-mode: disabled; width: 120px;ime-mode:disabled"
					onpaste="return !clipboardData.getData('text').match(/\D/)"
					ondragenter="return   false" onkeypress="javascript:tsdNumCheck(this)"
					onkeydown="KeyDown_DJBox(event);" onblur="Blur_DJBox();"/></span>
			</td>
			<td><label style="background-color: #ffffff;">应找金额：</label></td>
			<td>
				<span><input type="text" id="feeset" style="height:22px;line-height:22px;font-size:14px;" 
				disabled="disabled"	onkeydown="KeyDown_SsjeBox(event);" /></span>
			</td>
		</tr>
	</table>
	<div id="tofee_1" style="display: none;">
		<h1>本次退费金额：<span id=thisfee_1></span></h1>
	</div>
	<br /><br /><br />
	<hr />
	<button type="button" id="feesave" style="width: 100px;height:25px;margin-left:250px;" onclick="busiFeeUpdate()">
		提交
	</button>
	&nbsp;&nbsp;&nbsp;&nbsp;
	<button type="button" style="width: 100px;height:25px;margin-left:15px" onclick="dataReset()">
		重置
	</button>
	<!-- 打印票据 -->
	<iframe id="printReportDirect" style="width: 120px; height: 0px; visibility: visible" src="print.jsp"></iframe>
	<input type="hidden" id="jobidlist" />
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->
	<input type="hidden" id='hidjfid'/>
	<input type="hidden" id='hidjobid'/>
	<input type="hidden" id='hidcallpaytype'/>
  </body>
</html>
