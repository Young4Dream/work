<%----------------------------------------
	name: 		onDuty_new.jsp
	author: 	chenliang
	version: 	1.0, 2012-02-28
	description: 当班营收、业务和流水统计
	modify: 
			2012-03-06 调试页面，增加导出和打印功能
			2012-03-08 调试页面，增加查看明细的功能
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ page language="java" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String iconpath = basePath + "style/icon/";
String userid = (String)session.getAttribute("userid");
String imenuid = request.getParameter("imenuid");
String groupid = request.getParameter("groupid");
String username = (String)session.getAttribute("username");
String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title></title>
    <script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
    <link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/broadband/charge/duty.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript">
$(function(){
	$("#navBar1").append(genNavv());
	getTabInfo();
	$('#Duty').css('margin-top','35');
});
//获取统计信息
function getTabInfo()
{
	autoBlockForm('submitloading',20,'submitloadingclose',"#FFFFFF",false);
	var params = '';
	params += '&flag=1';//当班营收、业务流水和统计
	params += "&userid=<%=userid %>";
	params += '&begindate=<%=Log.getSysTime() %> 00:00:00';
	params += '&enddate=<%=Log.getSysTime() %> 23:59:59';
	$('#tsdreportparams').val(params);
	//params += '&language=';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', clsname : 'Procedure', method : 'exequery', ds : 'tsdBilling',
        tsdpname : 'duty.hfys_StatInfo',tsdExeType : 'query', datatype : 'xmlattr' 
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
			var sSkrs = '';//统计收款人员
			var sDhFee = new Array();//电话营收
			var sDhFeeCount = 0;	//收费笔数
			var sDhFees = 0;	//收费金额
			var sDhBusi = new Array();//电话业务
			var sDhBusiCount = 0;	//业务笔数
			var sDhBusiFees = 0;	//受理费金额
			var thisFlag = false;	//数据格式是否正常
			var drawArr = new Array();//统计图表值存储
            $(xml).find('row').each(function ()
            {
           		//统计类别 1：电话营收；2：电话业务；3：宽带营收；4：宽带业务；
           		var jobtype = $(this).attr("jobtype");
                if(1 == jobtype || 2 == jobtype){
                	if(1 == iCount){
                		sSkrs = $(this).attr("skrs")!='' ? $(this).attr("skrs") : '';
                		sStart = $(this).attr("tstart")!='' ? $(this).attr("tstart") : '';
                		sOver = $(this).attr("tover")!='' ? $(this).attr("tover") : '';
                	}
                	var countt = $(this).attr("countt");
	                var fee = $(this).attr("fee") == '' ? 0 : $(this).attr("fee");
	                fee = parseFloat(fee).toFixed(2);
	                var feetype = $(this).attr("showname");//显示名称
	                var reportName = $(this).attr("reportname");//报表名称
	                var whereinfo = $(this).attr("whereinfo");//报表名称
	                //val数据格式：统计类型 + 笔数 + 金额 + 报表名称 + 限制条件
	                var val = feetype+'@'+countt+'@'+fee;
                	if(1 == jobtype){//电话营收
                		reportName = reportName == '' ? 'payment' : reportName;
                		val = val + '@' + reportName + '@' + whereinfo;
                		sDhFee.push(val);
                	}else if(2 == jobtype){//电话业务
                		reportName = reportName == '' ? 'busi' : reportName;
                		val = val + '@' + reportName + '@' + whereinfo;
                		sDhBusi.push(val);
                	}
                	//统计图表以数组形式进行存值
					var tvalarr = new Array();
					tvalarr.push(feetype);
					tvalarr.push(fee*1);
					drawArr.push(tvalarr);
					iCount ++;
                }else{
                	thisFlag = true;
                	return false;
                }
            });
            if(thisFlag == false){
            	//已最大业务类型个数生成数据
	           	var iLength = sDhFee.length > sDhBusi.length ?  sDhFee.length : sDhBusi.length;
	           	for(var i = 0 ; i < iLength ; i++){
	                ghTab += '<tr>';
	           		if(0 == i){
	           			ghTab += '<td rowspan="'+iCount+'"><fmt:message key="duty_new.dh"/></td>';
	           		}
	           		//电话营收
	           		var sFee = sDhFee[i];
	           		//alert(sFee);
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
	           				ghTab += '<td></td>';
	           			}
	           		}
	           		//电话业务
	           		var sBusi = sDhBusi[i];
	           		if(sBusi !='' && sBusi != undefined){
	           			var sBusiArr = sBusi.split('@');
	           			sDhBusiCount += sBusiArr[1]*1;
	           			sDhBusiFees += parseFloat(sBusiArr[2]);
	           			for(var j = 0 ; j < sBusiArr.length - 2 ; j++){
	           				if(0 == sBusiArr[1]){
								ghTab += '<td>'+sBusiArr[j]+'</td>';	           					
	           				}else{
								ghTab += "<td><label style='display:none' id='"+sBusiArr[3]+i+"'>"+sBusiArr[4]+"</label><a href='javascript:void(0);' onclick=dutyMx('"+sBusiArr[3]+"','"+i+"','"+sBusiArr[0]+"')>"+sBusiArr[j]+"</a></td>";	           				
	           				}
	           			}
	           		}else{
	           			for(var j = 0 ; j < 3 ; j++){
	           				ghTab += '<td></td>';
	           			}
	           		}
	           		ghTab += '</tr>';
	           	}
	            var iTotalCount = (sDhFeeCount/2) + sDhBusiCount;//总笔数
	            var iTotalFee = (sDhFees/2) + sDhBusiFees;//总费用
	            if( '' != ghTab){//电话营收和业务流水统计
	            	$('#Duty').empty();
	            	var sTime 	= sStart + ' <fmt:message key="duty_new.to"/> ' + sOver;//admin(超管)
	            	var sUserid = '<%=userid %>(<%=username %>)';
	            	var sTitle 	= '<tr><td style="font-weight: bold;"><fmt:message key="duty_new.statedate"/></td><td colspan="3" id="stateDate">'+sTime+'</td><td align="center" style="font-weight: bold;"><fmt:message key="duty_new.stateuserid"/></td><td colspan="2">'+sUserid+'</td></tr>'
	            	var sNav 	= '<tr class="trcss"><td style="width: 80px"<fmt:message key="duty_new.statetype"/></td><td style="width: 120px"><fmt:message key="duty_new.feetype"/></td><td style="width: 40px"><fmt:message key="duty_new.feecount"/></td>'+
	            					'<td style="width: 100px"><fmt:message key="duty_new.fee"/></td><td style="width: 120px"><fmt:message key="duty_new.busitype"/></td><td style="width: 40px"><fmt:message key="duty_new.feecount"/></td>'+
	            					'<td style="width: 100px"><fmt:message key="duty_new.fee"/></td></tr>';
	         		var sTotal 	= '<tr class="trcss">'+
	         						'<td ><fmt:message key="duty_new.sumxiaoji"/></td><td>'+(sDhFeeCount/2)+'</td><td>'+(sDhFees.toFixed(2)/2)+'</td><td ><fmt:message key="duty_new.sumxiaoji"/></td>'+
				    				'<td>'+sDhBusiCount+'</td><td>'+sDhBusiFees.toFixed(2)+'</td></tr>'+
				    			  '<tr style="font-weight: bold;">'+
				    				'<td colspan="4" ><fmt:message key="duty_new.sumheji"/></td><td>'+iTotalCount+'</td><td>'+iTotalFee.toFixed(2)+'</td></tr>';   	
	            	$('#Duty').html('<table class="tabcss">'+sTitle+sNav+ghTab+sTotal+'</table>');//计算合计
	            }
	            //alert(drawArr);
				dutyDraw(drawArr);
            }else{
            	alert('<fmt:message key="duty_new.getchartfaild"/>');//获取统计图表数据无效，生成统计图表失败
            }
        }
    });
}
//画统计图
function dutyDraw(arr){
//声明对象 
var myChart = new JSChart('graph', 'line');
//初始化对象
myChart.setDataArray(arr, '<%=userid %>');
//设置画布大小
myChart.setSize(820, 300);
//设置Y精度
//myChart.setAxisValuesNumberY(1);
myChart.setAxisNameX('');//默认是X
myChart.setAxisNameY('');//默认是Y
myChart.setTitle('');//默认是JsChart
//myChart.setTitleColor('#454545');
myChart.setAxisValuesColor('#454545');
myChart.setAxisValuesAngle(30);//倾斜角度
myChart.setAxisValuesColor('#555');//值字体颜色
myChart.setAxisColor('#B5B5B5');//X轴显示颜色
myChart.setAxisWidth(1);
myChart.setBarValuesColor('#2F6D99');
myChart.setAxisPaddingBottom(60);
myChart.setLineColor(randomClr(), '<%=userid %>');
//设置提示信息
for(var i = 0 ; i < arr.length;i++){
	myChart.setTooltip([arr[i][0],arr[i][1]]);
}
myChart.setFlagColor('#9D16FC');
myChart.setFlagRadius(4);
myChart.setAxisPaddingRight(50);
//标签
myChart.setLegendShow(true);
myChart.setLegendPosition(490, 80);
myChart.setLegendForLine('<%=userid %>', '<%=userid %>(<%=username %>)');//参数：id，值
//画布
myChart.draw();
setTimeout($.unblockUI, 15);
}
//查看明细
function dutyMx(rptName,ids,jobtype){
	var val = rptName+ids;
	var params = '';
	//报表特殊转码：encodeURIComponent()
	params += '&whereparams='+encodeURIComponent($('#'+val).text());
	params += "&userid='<%=userid %>'";
	params += '&flag='+encodeURIComponent(jobtype);
	params += '&stateDate='+encodeURIComponent($('#stateDate').text());
	var urll = params+"&"+new Date().getTime();
	var basepath = '<%=basePath %>ReportServer?reportlet=/com/tsdreport/commonreport/'+rptName+'.cpt'+params+"&______" + new Date();
   	window.open(basepath);
}

//获取用户权限
function getUserPower(){
	var allRi = fetchMultiPValue('payFlow.getPower',6,'&userid=<%=userid %>&menuid=<%=imenuid %>&groupid=<%=groupid %>');
	if(typeof allRi == 'undefined' || allRi.length == 0){
		return false;
	}
	if(allRi[0][0] != 'all'){
		var printRight = '';
		for(var i = 0;i<allRi.length;i++){
			printRight += getCaption(allRi[i][0],'DutyPrint','');//打印全部统计报表的信息
		}
		if(printRight != ''){
			var hasprint = printRight.split('|');
			for(var i = o ; i < hasprint.length;i++){
				if (hasprint[i] == 'true') {
		        	$('#buttons').show();
					$('#Duty').css('margin-top','15');
		        	break;
		        }
			}
		}
	}else{
		$('#buttons').show();
		$('#Duty').css('margin-top','15');
	}
}
//打印报表
function printReport(basePath,rptName){
	var reportname = rptName
	var params = $('#tsdreportparams').val();//报表统计参数
	var urll = params+"&"+new Date().getTime();
	params = '&rptparams='+params.replace(/&/g,';');
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
		<!-- 用户操作按钮 -->
	<div id="buttons" style="text-align: left;margin-bottom: 0px;display: none">
		<button type="button" id="opendel1" onclick="exportData()" style="display: none">
			<fmt:message key="global.exportdata" />
		</button>
		<button type="button" id="opendel1" onclick="printReport('<%=basePath %>','onDuty')">
			<fmt:message key="global.print" />
		</button>
	</div>
   	<div id="Duty"></div>
  	<br/>
  	<label style="font-size: 14px;font-weight: bold;margin-left: 5px"><fmt:message key="duty_new.jscharts"/><!-- 统计图表 -->：</label>
  	<div id="graph" style="margin-left: 20px"></div>
  	<br/>
  	<div class="neirong" id="submitloading" style="display: none;">
		<table cellspacing="5" style="float:left;width: 60%;text-align:canter;margin-left:5px">
			<tr><td style="font-size: 14px;font-weight: bold;"><img src="style/images/public/loading_2.gif" style="margin-right:5px"/><fmt:message key="duty_new.isloading"/><!-- 正在加载，请稍候... -->...</td></tr>	
		</table>
		<a href="#" id="submitloadingclose" style="display: none"><fmt:message key="global.close"/></a>
	</div>
  	
    <script src="script/public/mainStyle.js" type="text/javascript"></script>
    <script type="text/javascript" src="script/public/main.js"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<!-- 统计图表需要引用的脚本 -->
	<script src="plug-in/jscharts/jscharts.js" type="text/javascript"></script>
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
  	<script src="script/broadband/charge/duty.js" type="text/javascript" language="javascript"></script>
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<input type="hidden" id="tsdreportparams"/>
  </body>
</html>