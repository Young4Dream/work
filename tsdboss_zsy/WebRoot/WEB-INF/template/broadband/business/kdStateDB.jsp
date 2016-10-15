<%----------------------------------------
	name: 		kdState.jsp
	author: 	chenliang
	version: 	1.0, 2012-02-28
	description: 当班营收、业务和流水统计
	modify: 
			
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String iconpath = basePath + "style/icon/";
String userid = (String)session.getAttribute("userid");
String username = (String)session.getAttribute("username");
String chargearea = (String)session.getAttribute("chargearea");
//String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title></title>
    <script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
    <link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body{background-color: #FFFFFF}
.tabcss {text-align:center;margin-left:5px;margin-top:0px;cursor: hand;text-decoration: none;}
.tabcss td{border: 1px solid #C1DAD7;background: #fff; font-size:14px; padding: 6px 6px 6px 12px; color: #4f6b72;}
.trcss td{background-color: #CAE8EA;font-weight: bold;}
.tabcss td a{background: #fff; font-size:14px;color: #4f6b72;text-decoration: none;}
.tabcss td a:hover{color: #FF8C00;}
.btn{margin-left: 5px;margin-top: 5px;width: 60px;height:30px;border-right: #87cefa 1px solid; padding-right: 5px; border-top: #87cefa 1px solid; padding-left: 5px; font-size: 12px; filter: progid:dximagetransform.microsoft.gradient(gradienttype=0,startcolorstr=#ffffff, endcolorstr=#87cefa); border-left: #87cefa 1px solid; cursor: hand;color: black; padding-top: 2px; border-bottom: #87cefa 1px solid}
</style>
<script type="text/javascript">
$(function(){
	$("#navBar1").append(genNavv());
	operInitialization();
	getTabInfo();
});
//获取统计信息
function getTabInfo()
{
    //2016-09-10 00:00:00
     var myDate = new Date().format("yyyy-MM-dd");;
     /*    
    var dateday= myDate.toLocaleDateString();
    dateday=dateday.replace("/","-");
    dateday=dateday.replace("/","-");
    var datedays=dateday+" "+"00:00:00";
    var datelastday=dateday+" "+"23:59:59";
    */
    var datedays=myDate+" "+"00:00:00";
    var datelastday=myDate+" "+"23:59:59";    
    
	var tBegin =datedays; //$('#tBegin').val();
	if('' == tBegin){
		alert('<fmt:message key="duty_new.selectstart"/>');//请选择统计起始时间
		$('#tBegin').focus();
		return false;
	}
	var tEnd = datelastday;//$('#tEnd').val();
	if('' == tEnd){
		alert('<fmt:message key="duty_new.selectend"/>');//请选择统计结束时间
		$('#tEnd').focus();
		return false;
	}
	/* var useridStatus = $('#useridStatus').val();
	if('' == useridStatus){
		alert('<fmt:message key="duty_new.selectuserid"/>');//请选择统计工号
		//addOperator();
		return false;
	} */
	autoBlockForm('submitloading',20,'submitloadingclose',"#FFFFFF",false);
	var params = '';
	params += '&flag=4';//阶段营收、业务流水和统计
	params += "&userid=<%=userid %>";
	params += '&begindate='+tBegin;
	params += '&enddate='+tEnd;
	
	//var skrs = $('#useridStatus').val();
	//if('' == skrs){
		var skrs = '<%=userid %>(<%=chargearea %>)';
	//}
	params += '&skr='+tsd.encodeURIComponent(skrs);
	//设置统计工号
	var statusUserid = $('#useridStatus').val();
	var uArr = statusUserid.split(',');
	var newArr = new Array();
	for(var i = 0; i < uArr.length;i++){
		var valArr = uArr[i].split('(');
		newArr.push("'"+valArr[0]+"'");
	}
	$('#cUserStatus').text(newArr.join(','));
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling',
        tsdpname : 'kdState.hfys_KdStatInfo',tsdExeType : 'query', datatype : 'xmlattr' 
    });
    $.ajax(
    {
        url : 'mainServlet.html?' + urlstr + params, datatype : 'xml', cache : false, 
        timeout : 10000, async : true , //同步方式
        success : function (xml)
        {
        	var iCount = 1;
			var ghTab = '';//电话营收和业务流水统计
			var sStart = '';//统计开始时间
			var sOver = '';//统计结束时间
			//var sSkrs = '';//统计收款人员
			var sDhFee = new Array();//电话营收
			var sDhFeeCount = 0;	//收费笔数
			var sDhFees = 0;	//收费金额
			var sDhBusi = new Array();//电话业务
			var sDhBusiCount = 0;	//业务笔数
			var sDhBusiFees = 0;	//受理费金额
			var thisFlag = false;	//数据格式是否正常
            $(xml).find('row').each(function ()
            {
           		//统计类别 1：电话营收；2：电话业务；3：宽带营收；4：宽带业务；
           		var jobtype = $(this).attr("jobtype");
           		
                if(3 == jobtype || 4 == jobtype){
                	if(1 == iCount){
                		sStart = $(this).attr("tstart")!='' ? $(this).attr("tstart") : '';
                		sOver = $(this).attr("tover")!='' ? $(this).attr("tover") : '';
                	}
                	var countt = $(this).attr("countt");
	                var fee = $(this).attr("fee") == '' ? 0 : $(this).attr("fee");
	                fee = parseFloat(fee).toFixed(2);
	                var feetype = $(this).attr("feetype");//显示名称
	                var reportName = $(this).attr("reportname");//报表名称
	                var whereinfo = $(this).attr("whereinfo");//报表名称
	                //val数据格式：统计类型 + 笔数 + 金额 + 报表名称 + 限制条件
	                var val = feetype+'@'+countt+'@'+fee;
                	if(3 == jobtype){//电话营收
                		reportName = reportName == '' ? 'kdpayment' : reportName;
                		val = val + '@' + reportName + '@' + whereinfo;
                		sDhFee.push(val);
                	}else if(4 == jobtype){//电话业务
                		reportName = reportName == '' ? 'kdbusi' : reportName;
                		val = val + '@' + reportName + '@' + whereinfo;
                		sDhBusi.push(val);
                	}
					iCount ++;
                }else{
                	thisFlag = true;
                	return false;
                }
            });
            //alert(sDhFee);
            //alert(thisFlag);
            if(thisFlag == false){
            	//已最大业务类型个数生成数据
            	var r="</td></tr>";
	           	var iLength = sDhFee.length > sDhBusi.length ?  sDhFee.length : sDhBusi.length;
	           	if(iLength==0){
	           	iLength=1;
	           	r="</td><td>0</td></tr>";
	           	}
	           	for(var i = 0 ; i < iLength ; i++){
	                ghTab += '<tr>';
	           		if(0 == i){
	           			ghTab += '<td rowspan="'+iCount+'">宽带</td>';//电话
	           		}
	           		//电话营收
	           		var sFee = sDhFee[i];
	           		if(sFee!='' && sFee != undefined){
	           			var sFeeArr = sFee.split('@');
	           			sDhFeeCount += sFeeArr[1]*1;
	           			sDhFees += parseFloat(sFeeArr[2]);
	           			for(var j = 0 ; j < sFeeArr.length - 2 ; j++){
	           				if(0 == sFeeArr[1]){
								ghTab += "<td>"+sFeeArr[j]+"</td>";			
	           				}else{
								ghTab += "<td><label style='display:none' id='"+sFeeArr[3]+i+"'>"+sFeeArr[4]+"</label><a href='javascript:void(0);' onclick=dutyMx('"+sFeeArr[3]+"','"+i+"','"+sFeeArr[0]+"')>"+sFeeArr[j]+"</a></td>";	           				
	           				}
	           			}
	           		}else{
	           			for(var j = 0 ; j < 3 ; j++){
	           				ghTab += '<td>'+0+'</td>';
	           			}
	           		}
	           		//电话业务
	           		var sBusi = sDhBusi[i];
	           		if(sBusi !='' && sBusi != undefined){
	           			var sBusiArr = sBusi.split('@');
	           			sDhBusiCount += sBusiArr[1]*1;
	           			sDhBusiFees += parseFloat(sBusiArr[2]);
	           			for(var j = 0 ; j < sBusiArr.length -2 ; j++){
	           				if(0 == sBusiArr[1]){
								ghTab += '<td>'+sBusiArr[j]+'</td>';	           					
	           				}else{
								ghTab += "<td><label style='display:none' id='"+sBusiArr[3]+i+"'>"+sBusiArr[4]+"</label><a href='javascript:void(0);' onclick=dutyMx('"+sBusiArr[3]+"','"+i+"','"+sBusiArr[0]+"')>"+sBusiArr[j]+"</a></td>";	           				
	           				}
	           			}
	           		}else{
	           			for(var j = 0 ; j < 3 ; j++){
	           				ghTab += '<td>'+0+'</td>';
	           			}
	           		}
	           		ghTab += '</tr>';
	           	}
	            var iTotalCount = sDhFeeCount + sDhBusiCount;//总笔数
	            var iTotalFee = sDhFees + sDhBusiFees;//总费用
	            if( '' != ghTab){//电话营收和业务流水统计
	            	$('#Duty').empty();
	            	var sTime 	= sStart + ' <fmt:message key="duty_new.to"/> ' + sOver;//admin(超管)
	            	var sUserid = '<%=userid %>(<%=username %>)';//统计区间
	            	var sTitle 	= '<tr><td style="font-weight: bold;"><fmt:message key="duty_new.statedate"/></td><td colspan="3" id="stateDate">'+sTime+'</td><td align="center" style="font-weight: bold;"><fmt:message key="duty_new.stateuserid"/></td><td colspan="2">'+sUserid+'</td></tr>'//统计人员
	            	var sNav 	= '<tr class="trcss"><td style="width: 80px"><fmt:message key="duty_new.statetype"/></td><td style="width: 120px"><fmt:message key="duty_new.feetype"/></td><td style="width: 40px"><fmt:message key="duty_new.feecount"/></td>'+
	            					'<td style="width: 100px"><fmt:message key="duty_new.fee"/></td><td style="width: 120px"><fmt:message key="duty_new.busitype"/></td><td style="width: 40px"><fmt:message key="duty_new.feecount"/></td>'+
	            					'<td style="width: 100px"><fmt:message key="duty_new.fee"/></td></tr>';//收款金额
	            				
	         		var sTotal 	= '<tr class="trcss">'+
	         						'<td ><fmt:message key="duty_new.sumxiaoji"/></td><td>'+sDhFeeCount+'</td><td>'+sDhFees.toFixed(2)+'</td><td ><fmt:message key="duty_new.sumxiaoji"/></td>'+//小计
				    				'<td>'+sDhBusiCount+'</td><td>'+sDhBusiFees.toFixed(2)+r+
				    			  '<tr style="font-weight: bold;">'+
				    				'<td colspan="4" ><fmt:message key="duty_new.sumheji"/></td><td>'+iTotalCount+'</td><td>'+iTotalFee.toFixed(2)+r;//总计 	
	            	$('#Duty').html('<table class="tabcss">'+sTitle+sNav+ghTab+sTotal+'</table>');//计算合计
	            	$('#dutyInfo').show();
	            }
	            //diffViewUser();
            }
            setTimeout($.unblockUI, 15);
        }
    });
}
//根据不同工号生成曲线图
function diffViewUser(){
	var userarr = $('#cUserStatus').text();
	var valArr = new Array();
	var params = '';
	params += '&userid=<%=userid %>';
	params += '&userparams='+userarr;
	var sval = userarr.replace(/\'/g, ''); 
	var revVal = fetchMultiArrayValue('Duty.queryRevStatus',6,params);
	if(revVal[0]==undefined||revVal[0][0]==undefined)
	{
		alert('<fmt:message key="duty_new.getchartfaild"/>');//获取统计图表数据无效，生成统计图表失败
	}else{
		for(var i = 0 ; i < revVal.length;i++){
			var fee = revVal[i][1] == '' ? 0 : revVal[i][1];
	    	fee = parseFloat(fee).toFixed(2);
	    	valArr.push(revVal[i][0]+'@'+fee+'@'+revVal[i][2]);
		}
		dutyDraw(valArr,sval.split(','));	
	}
}
//画统计图
function dutyDraw(valarr,skrarr){
var Clerks = fetchMultiKVValue("Duty.fetchUserId",6,"",["userid","username"]);
//声明对象 
var myChart = new JSChart('graph', 'line');
var arr = new Array();
for(var i = 0 ; i < skrarr.length ; i++){
	var drawArr = new Array();
	for(var j = 0 ; j < valarr.length;j++){
		//alert(valarr[j]);
		var iarr = valarr[j].split('@');
		if(iarr[2]==skrarr[i]){
			var tvalarr = new Array();
			tvalarr.push(iarr[0]);
			tvalarr.push(iarr[1]*1);
			drawArr.push(tvalarr);
		}
	}
	arr.push(drawArr);
	myChart.setDataArray(drawArr,'drawreport'+i);
	myChart.setLineColor(randomClr(), 'drawreport'+i);
	myChart.setLegendForLine('drawreport'+i, skrarr[i]+'('+Clerks[skrarr[i]]+')');//参数：id，值
}
//设置提示信息特殊处理
for(var i = 0 ; i < arr.length;i++){
	for(var j = 0 ; j < arr[i].length;j++){
		//setTooltip([索引,替换值,ID],function(){回调函数})
		myChart.setTooltip([arr[i][j][0],arr[i][j][1],'drawreport'+i],function(){callBackFtn();});
	}
}
//初始化对象
//myChart.setDataArray(arr, '');
//设置画布大小
myChart.setSize(820, 400);
//设置Y值个数
//myChart.setAxisValuesNumberY(10);
//设置Y轴最大值
//myChart.setIntervalEndY(10000);
myChart.setAxisNameX('');
myChart.setAxisNameY('');
myChart.setTitle('');//默认是JsChart
//myChart.setTitleColor('#454545');
myChart.setAxisValuesColor('#454545');
myChart.setAxisValuesAngle(30);//倾斜角度
myChart.setAxisValuesColor('#777');//值字体颜色
myChart.setAxisColor('#B5B5B5');//X轴显示颜色
myChart.setAxisWidth(1);
myChart.setBarValuesColor('#2F6D99');
myChart.setAxisPaddingBottom(60);
myChart.setFlagColor('#9D16FC');
myChart.setFlagRadius(4);
myChart.setAxisPaddingLeft(60);
//标签
myChart.setLegendShow(true);
myChart.setLegendPosition(490, 80);
//画布
myChart.draw();
}
//回调函数
function callBackFtn(){
	//预留接口
}
//初始化统计时间
function operInitialization(){
	//默认起始时间
	$("#tBegin").val("<%=Log.getSysTime() %> 00:00:00");
	//默认结束时间
	$("#tEnd").val("<%=Log.getSysTime() %> 23:59:59");
}
//查看明细
function dutyMx(rptName,ids,jobtype){
	var val = rptName+ids;
	var params = '';
	//alert($('#'+val).text());
	params += '&whereparams='+encodeURIComponent($('#'+val).text());
	params += "&userid="+encodeURIComponent('<%= userid %>');//阶段营收统计工号处理 
	params += '&flag='+encodeURIComponent(jobtype);
	params += '&stateDate='+encodeURIComponent($('#stateDate').text());
	var urll = params+"&"+new Date().getTime();
	var basepath = '<%=basePath %>ReportServer?reportlet=/com/tsdreport/commonreport/'+rptName+'.cpt'+params+"&______" + new Date();
   	window.open(basepath);
}
function fetchMultiArrayValue(key,dss,param)
{
	var result = new Array();
	var i = 0;
	var j = 0;
	var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdBilling',
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:key
				});
	//alert(urlMm +"_"+param);
	$.ajax({
		url:"mainServlet.html?" + urlMm + param,
		async:false,
		cache:false,
		timeout:1000,
		type:'post',
		success:function(xml){
			$(xml).find("row").each(function(){
				result[i++] = new Array();
				$(this).find("cell").each(function(){
					result[i-1].push($(this).text());
				});
			});
		}
	});
	return result;
}
//添加统计工号
function addOperator(){
	var tBegin = $('#tBegin').val();
	if('' == tBegin){
		alert('<fmt:message key="duty_new.selectstart"/>');//请选择统计起始时间
		$('#tBegin').focus();
		return false;
	}
	var tEnd = $('#tEnd').val();
	if('' == tEnd){
		alert('<fmt:message key="duty_new.selectend"/>');//请选择统计结束时间
		$('#tEnd').focus();
		return false;
	}
	var params = '';
	params += '&tstart='+tBegin;
	params += '&tend='+tEnd;
	//autoBlockForm('submitloading',20,'submitloadingclose',"#FFFFFF",false);
	var operators = fetchMultiArrayValue('kdState.queryOperators',6,params);
	//alert(operators);
	if(operators[0]==undefined||operators[0][0]==undefined)
	{
		alert('<fmt:message key="duty_new.nouserid"/>');//在统计时间范围内暂无可显示的统计工号
	}else{
		$('#useridtab').empty();
		var valarr = new Array();
		var areaarr = new Array();
		for(var i = 0 ; i < operators.length;i++){
			areaarr.push(operators[i][1]);
			valarr.push(operators[i][0]+'~'+operators[i][2]+'~'+operators[i][3]);
		}
		var sarr = uniqueData_(areaarr);
		var tabinfo = '';
		for(var i = 0 ; i < sarr.length;i++){
			tabinfo += '<tr style="font-weight: bold;"><td>'+sarr[i]+'</td></tr><tr><td>';
			//alert(sarr[i]);
			for(var j = 0 ; j < valarr.length;j++){
				var snewarr = valarr[j].split('~');
				if(snewarr[0].indexOf(sarr[i])!=-1){
					tabinfo += "<span class='spanstyle'><input type='checkbox' value='"+snewarr[1]+"("+sarr[i]+")' name='useridchk'/>"+snewarr[2]+"</span>";
					//break;
				}
			}
			tabinfo += '</td></tr><tr><td><hr size="1" noshade="noshade" style="border:1px #A9C8D9 dotted;"/></td></tr>';
		}
		$('#useridtab').append(tabinfo);
		autoBlockForm('useridchkform',40,'closeuseridchk',"#FFFFFF",false);
	}
}
//获取选择的工号
function getTheCheckeds(name)
{
    var thename = document.getElementsByName(name);
    var thevalue = '';
   	for (var i = 0; i < thename.length; i++) {
        if (thename[i].checked == true) {
            thevalue += thename[i].value + ',';
        }
    }
    var num = thevalue.lastIndexOf(',');
    thevalue = thevalue.substring(0, num);
    if (thevalue.indexOf(',') == 0) {
        thevalue = thevalue.substring(1, thevalue.length);
    }
    return thevalue;
}
//确定选值
function chkSelected(){
	var res = getTheCheckeds('useridchk');
	if('' == res){
		alert('<fmt:message key="duty_new.selectstatususerid"/>');//请选择要统计的工号
		$('#useridStatus').val('');
		return false;
	}else{
		$('#useridStatus').val(res);
		setTimeout($.unblockUI, 15);
	}
}
//打印报表
function printReport(basePath,rptName){
	var reportname = rptName
	var params = "&userid="+'<%=userid %>';
	var urll = params+"&"+new Date().getTime();
	var basepath = basePath+'ReportServer?reportlet=/com/tsdreport/commonreport/'+reportname+'.cpt'+params+"&______" + new Date();
   	window.open(basepath);
}
</script>
  </head>
  <body >
  	<div id="navBar" style="margin-bottom: 0px">
		<table width="100%" height="26px" >
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath %>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />:
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
	<div id="input-Unit" style="margin-bottom: 0px;margin-top: 0px">
				<div class="title">
					<table cellspacing="4px" class="maintitle" align="left">
							<tr>
						    	<td><img src="<%=iconpath %>query.gif"/></td>
						    	<td></td><!-- 请选择统计范围  -->
						    </tr>
					</table>
				</div>
	</div>	
	<button class="btn" onclick="printReport('<%=basePath %>','kdState')">
			<fmt:message key="global.print" /><!-- 打印 -->
		</button>
	<div id="sIn" style="display:none;margin-top: 0;font-size: 14px">
		&nbsp;&nbsp;<!-- 时间范围 -->
		<fmt:message key="Onduty.timesFrom" />：
		<input type="text" class="textclass" name="tBegin" id="tBegin" style="width: 160px;height: 22px;line-height: 22px;margin-left: 12px" onFocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
		<fmt:message key="duty_new.to"/><!-- 至 --> 
		<input type="text" class="textclass" name="tEnd" id="tEnd" style="width: 160px;height: 22px;line-height: 22px" onFocus="WdatePicker({startDate:'%y-%M-%d 23:59:59',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
		<br />
		<fmt:message key="duty_new.skr"/><!-- 收款人工号 -->：
		<textarea id="useridStatus" class="textclass" style="margin-left: 12px;width: 360px;height: 80px" onkeydown="event.returnValue=false;" readonly="readonly"></textarea>
		<button class="btn" onclick="addOperator()" style="width: 100px">
			<fmt:message key="Duty.addskruserid" /><!-- 添加统计工号 -->
		</button>
		<button class="btn" onclick="getTabInfo()">
			<fmt:message key="Onduty.status" /><!-- 统计 -->
		</button>
		<button class="btn" onclick="printReport('<%=basePath %>','kdState')">
			<fmt:message key="global.print" /><!-- 打印 -->
		</button>
	</div>
	<hr size="1" noshade="noshade" style="border:1px #A9C8D9 dotted;"/>	
	<div id="dutyInfo" style="display: none">
	   	<div id="Duty" style="margin-top:5px"></div>
	  	<br/>
	  	<label style="font-size: 14px;font-weight: bold;margin-left: 5px;display: none"><fmt:message key="duty_new.jscharts"/><!-- 统计图表 -->：</label>
	  	<div id="graph"></div>
	  	<br/>
  	</div>
  	<label id="cUserStatus" style="display: none"></label>
	<div class="neirong" id="useridchkform" style="display: none;width:640px">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="titlediv"><fmt:message key="Duty.selectuserid" /></div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="javascript:$('#closeuseridchk').click();"><fmt:message key="global.close" /></a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" style="max-height:320px;overflow-y: auto; overflow-x: hidden;">
			<form action="#" onsubmit="return false;">
				<table id="useridtab" width="100%" id="tdiv" border="0" style="line-height: 25px;" cellspacing="0" cellpadding="0">
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="okchk" onclick="chkSelected()">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closeuseridchk" >
				<fmt:message key="global.close" />
			</button>
		</div>
	</div>
	<div class="neirong" id="submitloading" style="display: none;">
		<table cellspacing="5" style="float:left;width: 60%;text-align:canter;margin-left:5px">
			<tr><td style="font-size: 14px;font-weight: bold;"><img src="style/images/public/loading_2.gif" style="margin-right:5px"/><fmt:message key="duty_new.isloading"/><!-- 正在加载，请稍候 -->... </td></tr>	
		</table>
		<a href="#" id="submitloadingclose" style="display: none"><fmt:message key="global.close"/></a>
	</div>
    <script src="script/public/mainStyle.js" type="text/javascript"></script>
    <script type="text/javascript" src="script/public/main.js"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>

  </body>
</html>