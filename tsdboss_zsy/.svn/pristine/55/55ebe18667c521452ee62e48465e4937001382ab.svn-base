<%------------------------------------------ 
    File Name:  trunk/boss-bs/src/tsdboss/WebRoot/WEB-INF/template/reports/zdyReprint.jsp
    Function:   自定义发票
    Author:     wenxuming
    Date:       2012-10-10
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
		<title>自定义发票</title>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>	
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="js/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>	
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />	
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->	
		<style type="text/css">
		#input-Unit .title{text-align:left;}
		.inputbox{{margin-left:20px; background:url(style/imgs/inputText_bg.jpg) repeat-x ; width:180px; border:#999999 solid 1px;  text-align:left; color:#000000; font-size:12px; font-weight:bold; height:22px; line-height: 23px; }}
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
		#tdiv td{line-height:26px;}
		</style>
		
		<script type="text/javascript"><!--
		jQuery(document).ready(function()
		{	    
		    $("#navBar").append(genNavv());
		    gobackInNavbar("navBar");
			var getdate = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=to_char(sysdate,'YYYY-MM-DD')&tablename=dual&key=1=1");
			//$("#setdate").html(getdate);
			$("#dhnumber").select().focus();

			$("input[value='0.00']").blur(function(){
				if($(this).val()==""){
					$(this).val('0.00');
				}
			});
					
			$("input[value='0.00']").focus(function(){
				if($(this).val()==0){
					$(this).val('')
				}
			});
			$("input[value='0.00']").keydown(function(){			
				var k=event.keyCode;
				return k>=48&&k<=57||k==190&&this.value!=""&&this.value.indexOf(".")==-1||k==8||k==37||k==39;
			});
			
			$("input[value='0.00']").bind("copy paste",function(){
				return false;
			});
			
			$("input[value^='自定义费用']").focus(function(){
				if($(this).val()==$(this).attr('value_1')){
					$(this).val('')
				}
			});			
			$("input[value^='自定义费用']").blur(function(){
				if($(this).val()==""){
					$(this).val($(this).attr('value_1'));
				}
			});
			$("#jfdate").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});
			});
			$("#sfendmonth").focus(function(){
					WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyyMM',alwaysUseStartDate:true});
				});
			var sfmonth = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=tvalues&tablename=tsd_ini&key=tsection='charge' and tident='current paymonth'");
			$("#sfendmonth").val(sfmonth);
			$("#jfdate").val(getdate);
			$("#thisuserid").html($("#userid").val());
		}); 		
			/*********
			* 查询用户信息
			* @param;
			* @return;
			**********/
            function queryUserValue(){
				var phone = $("#dhnumber").val();
				if(phone==""){
					return;
				}
            	var res = fetchMultiArrayValue("dbsql_phone.uservalue",6,"&phone="+phone,'business');				
				if(res[0]!=undefined && res[0].length==3){
					$("#thishth").val(res[0][0]);
					$("#thisyhmc").val(res[0][1]);
					$("#thisyhlb").html(res[0][2]);   
					$("#jsbt,#dybt").removeAttr("disabled");     	
            	}else{
            		$("#thishth").val(phone);
					$("#thisyhmc").val("");
					$("#thisyhlb").html("");   
					$("#jsbt,#dybt").removeAttr("disabled");
				}
            }
			
			function setPrintdate(){
			
				var lsz = $("#thislsz").html();
				var zpnumber = $("#zpnumber").val();
				var thishth = $("#thishth").val();
				if(thishth==""){
					alert("合同号不能为空!");
					return;
				}
				var thisyhmc = $("#thisyhmc").val();
				var paytype = $("#paytype").val();
				var sfendmonth = $("#sfendmonth").val();
				var thisyhlb = $("#thisyhlb").html();
				var hjyjf	= $("#hjyjf").val();
				var jfdate = $("#jfdate").val();
				var ssje	= $("#ssje").val();
				var thisuserid = $("#thisuserid").html();
				var syye = $("#syye").val();
				var byye = $("#byye").val();
				var params="";
				for(var i=1;i<=21;i++){
						if(i>=17&&i<=20){
							if($("#fee"+i).val()!="0.00"){
								params += "&feename"+i+"="+tsd.encodeURIComponent($("#feename"+i).val());
								params += "&fee"+i+"="+$("#fee"+i).val();
							}
						}else{
							params += "&feename"+i+"="+tsd.encodeURIComponent($("#feename"+i).text());
							params += "&fee"+i+"="+$("#fee"+i).val();
						}
				}
				params += "&lsz="+lsz;
				params += "&zpnum="+zpnumber;
				params += "&hth="+thishth;
				params += "&yhmc="+tsd.encodeURIComponent(thisyhmc);
				params += "&paytype="+paytype;
				params += "&sfendmonth="+sfendmonth;
				params += "&yhlb="+tsd.encodeURIComponent(thisyhlb);
				params += "&hjyjf="+hjyjf;
				params += "&jftime="+jfdate;
				params += "&ssje="+ssje;
				params += "&userid="+tsd.encodeURIComponent(thisuserid);
				params += "&syye="+syye;
				params += "&byye="+byye;
				var result = fetchMultiPValue("zdyReprint.open",6,params);
				if(result[0]==undefined || result[0][0]==undefined || result[0][0]=='-1')
				{
					//alert("业务失败");
					alert("<fmt:message key="phone.getinternet0193" />");
				}
				else
				{
					alert("数据保存成功，等待打印……");
					var params = "&lsz="+result[0][0];
					var urll = $("#thisbasePath").val()+"/ReportServer?reportlet=/com/tsdreport/commonreport/zdyReptint.cpt"+params;
					//printWithoutPreview("commonreport/zdyReptint",params);
					window.showModalDialog(urll,window,"dialogWidth:800px; dialogHeight:530px; center:yes; scroll:no");
				}
			}		
			
			function jsfee(){

				var feevalue =0;
				for(var i=1;i<=21;i++){
						var fee = $("#fee"+i).val();
						if(!isNaN(fee)){
							feevalue += parseFloat(fee,10);
						}else{
							$("#fee"+i).focus();
							if(!confirm(($("#feename"+i).text()=="" ? $("#feename"+i).val():$("#feename"+i).text())+"含特殊字符!\n是否继续?")){
								return;
							}
							}
				} 
				
				$("#hjyjf").val((feevalue-parseFloat($("#syye").val(),10)).toFixed(2));
				
				
				if(parseFloat($("#ssje").val(),10)<feevalue-parseFloat($("#syye").val(),10)){
					$("#ssje").val($("#hjyjf").val());
				}
				$("#byye").val((parseFloat($("#ssje").val(),10)-parseFloat($("#hjyjf").val(),10)).toFixed(2));

				$("#thisValuevalue").text(AmountInWords($("#ssje").val(),2));
				
			}
			
			function printWithoutPreview(reportname,paramvalue)
			{
				document.getElementById('printReportDirect').contentWindow.RepPri(reportname,paramvalue);
			}
			
			function resetPage(){
				$('#zdyForm')[0].reset();
				var getdate = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=to_char(sysdate,'YYYY-MM-DD')&tablename=dual&key=1=1");
				var sfmonth = fetchSingleValue("dbsql_phone.querytabledate",6,"&cloum=tvalues&tablename=tsd_ini&key=tsection='charge' and tident='current paymonth'");
				$("#sfendmonth").val(sfmonth);
				$("#jfdate").val(getdate);
				$("#thisValuevalue").text("零元整");
				queryUserValue();
			}
		--></script>
		<style type="text/css">
		.zdyfy_input{
					background-color:#F0F7FB;
					text-align: right;
					}
		</style>
	</head>

	<body>
		<div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />:
		</div>		
		<table cellspacing="5px">
			<tr>
				<td><span style="font-size: 14px;font-weight: bold;">电话号码:</span></td>
				<td><input type="text" class="inputbox" id="dhnumber" name="dhnumber" /></td>
				<td>
					<button class="tsdbutton" id="kdSearchByUserName" onClick="queryUserValue();" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;"><fmt:message key="phone.getinternet0466" /><!-- 查找 --></button>
				</td>
			</tr>
		</table>
		<hr style="border: 1px dotted #CCCCCC;" />
		<table style="width:90%">
			<tr>
				<td><h3>首都机场6459局电信收费单</h3></td>
			</tr>
			<tr>
				<td><h4><div id="setdate"></div></h4></td>
			</tr>
		</table>
		<form id=zdyForm>			
		<table id="tdiv" border="0"
			style="border: 1px; border-style: solid; border-color: #87CEFA;width:90%;min-width:780px;"
			cellspacing="0" cellpadding="0">
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">票据号码</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thislsz"></div>
				</td>
				
				<td class="labelclass">
					<label for="sarea">
						<span id="">支票号码</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisJobTypevaluezh"><input type="text" id="zpnumber"/></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">用户代码（合同号）</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thishth_div"><input type="text" id="thishth"/></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">用户名称</span>
					</label>
				</td>

				<td width="20%" class="tdstyle" colspan=3>
					<div id="thisyhmc_div"><input type="text" id="thisyhmc"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">付费方式</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisUserNamevalue"><select id="paytype" style="width:80px;"><option rptfile="charge_dk" cval="dcash" value="dcash">现金</option><option rptfile="charge_cq" cval="cheque" value="cheque">支票</option><option rptfile="charge_tr" cval="transfer" value="transfer">电汇</option><option rptfile="charge_dk" cval="dtransfer" value="dtransfer">托收</option><option rptfile="charge_yf" cval="prepayment" value="prepayment">预付</option></select></div>
				</td>
			</tr>

			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">收费截止月</span>
					</label>
				</td>

				<td width="20%" class="tdstyle" colspan=3>
					<div id="thissfendmonth"><input type="text" id="sfendmonth" style="width:300px;"/></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">缴费类别</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisyhlb"></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">合计应收</span>
					</label>
				</td>

				<td width="20%" class="tdstyle" colspan=3>
					<div id="thisUserIDvalue"><input type="text" id="hjyjf" style="width:300px;" value="0.00"/></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">缴费日期</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisDepartvalue"><input type="text" id="jfdate"/></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">实际金额（大写）</span>
					</label>
				</td>
				<td width="20%" class="tdstyle" colspan=3>
					<div id="thisValuevalue">零元整</div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="">实际金额（小写）</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisPayTypevalue"><input type="text" id="ssje" value="0.00" /></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename1">局内几次费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisiFeeTypevalue"><input type="text" id="fee1" value="0.00" /></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename2">局外几次费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissDhvalue"><input type="text" id="fee2" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="feename3">上网通话费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissRegDatevalue"><input type="text" id="fee3" value="0.00"/></div>
				</td>
			</tr>

			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename4">国内长途费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisfeedendtimevalue"><input type="text" id="fee4" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="feename5">信息费</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisiFeeTypeTimevalue"><input type="text" id="fee5" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="feename6">国际长途费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisoldsAddressvalue"><input type="text" id="fee6" value="0.00"/></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename7">IP话费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissAddressvalue"><input type="text" id="fee7" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="feename8">专线月租</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisiStatusvalue"><input type="text" id="fee8" value="0.00"/></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename9">功能费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissDh1value"><input type="text" id="fee9" value="0.00"/></div>
				</td>
			</tr>

			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename10">宽带费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissDh2value"><input type="text" id="fee10" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="feename11">代收宽带费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisiSimultaneousvalue"><input type="text" id="fee11" value="0.00"/></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename21">预付费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisUserName1value"><input type="text" id="fee21" value="0.00"/></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename12">供料费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisidtypevaluezh"><input type="text" id="fee12" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="feename13">设备费</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisidcardvalue"><input type="text" id="fee13" value="0.00"/></div>
				</td>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename14">业务手续费</span>
					</label>
				</td>
				<td width="20%" class="tdstyle">
					<div id="thisjobstatevalue"><input type="text" id="fee14" value="0.00"/></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="feename15">光线租费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisoldspeedvalue"><input type="text" id="fee15" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="feename16">其他线路租费</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisspeedvalue"><input type="text" id="fee16" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id=""><input type="text" id="feename17" class="zdyfy_input" value="自定义费用一" value_1="自定义费用一"/></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thismobilevalue"><input type="text" id="fee17" value="0.00"/></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id=""><input type="text" id="feename18" class="zdyfy_input" value="自定义费用二" value_1="自定义费用二"/></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thislinkphonevalue"><input type="text" id="fee18" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id=""><input type="text" id="feename19" class="zdyfy_input" value="自定义费用三" value_1="自定义费用三" /></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thislinkmanvalue"><input type="text" id="fee19" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id=""><input type="text" id="feename20" class="zdyfy_input" value="自定义费用四" value_1="自定义费用四" /></span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisFeevalue"><input type="text" id="fee20" value="0.00"/></div>
				</td>
			</tr>
			<tr>
				<td class="labelclass">
					<label for="sarea">
						<span id="">上月余额</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisFeeNamevalue"><input type="text" id="syye" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">本月余额</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thissBmvalue"><input type="text" id="byye" value="0.00"/></div>
				</td>

				<td class="labelclass">
					<label for="sarea">
						<span id="">营业员</span>
					</label>
				</td>

				<td width="20%" class="tdstyle">
					<div id="thisuserid"></div>
				</td>
			</tr>
		</table>
		</form>	
	<div id="buttons" style="text-align:center">
		<button id="jsbt" style="width:120px;" onClick="jsfee()" disabled>计算</button><button id="dybt" style="width:120px;" onClick="setPrintdate()" disabled>打印</button><button id="kdback" style="width:120px;" onClick="resetPage()"><fmt:message key="AddUser.Reset" /></button>
	</div>	
	
	<iframe id="printReportDirect"  style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="Interregional" />
	
	<input type="hidden" id="department" name="department" value='<%=session.getAttribute("departname") %>' />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="userid" name="userid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	<input type="hidden" id="yjfeeright"/><!--应缴费是否可以编辑-->	
	<input type="hidden" id="fufeitypepath"/>
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' /><!-- 获得打印项目路径 -->	
	<jsp:include page="phone_internet.jsp" flush="true"/>	
	</body>
</html>
