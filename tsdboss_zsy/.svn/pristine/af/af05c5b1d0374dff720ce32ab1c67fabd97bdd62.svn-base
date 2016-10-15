<%----------------------------------------
	name: charge_phone_dkh.jsp
	author: chenze
	version: 1.0, 2010-11-3
	description: 
	modify: 
			2011-07-27：  chenze   
---------------------------------------------%>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
    <title><!-- 大客户缴费 -->
		<fmt:message key="charge_phone_dkh.BigCustomersPayCost" />
	</title>
	<!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- tab滑动门 需要导入的样式表 *注意路径-->
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 导航专用 -->
	<script src="script/public/navigationbar.js" type="text/javascript"></script>
	<!-- 字符串处理、解析专用 -->
	<script src="script/public/tsdstring.js" type="text/javascript"></script>
	<!-- 收费结账专用js -->
	<script src="script/telephone/charge/charge_phone.jsp" type="text/javascript"></script>
	<!-- 导入js文件结束 -->
	<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<link href="style/css/telephone/charge/charge_phone.css" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	$(function(){
		initialBar();		
		$("#ghSearchBox").select().focus();
		initData("groupcustomer");		
		//合同号列表选择触发
		$("#ghMultiHthDetTab td :checkbox").live("click",function(){
			var hths = $(this).val();
			var hthsdis = $(this).parent().text();
		});
		$("#ghMultiHthDetTab td span").live("click",function(){
			$(this).parent().find(":checkbox:first").click();
		});
		
		//多合同号详细
		$("#multiHthDetail a").toggle(function(){
			$("#multiHthDetailTab").show();
		},function(){
			$("#multiHthDetailTab").hide();
		});
	});
	
	function ghDrawHths(hths)
	{
		if(hths[0]!=undefined && hths[0][0]!=undefined)
		{
			var tabHtml = "";
			var ii = 0;
			var colspan = 4;
			for(ii = 0;ii<hths.length;ii++)
			{
				if((ii+1)%colspan==1)
					tabHtml += "</tr><tr>";
					
				tabHtml += "<td><input type=\"checkbox\" id=\"gmh_" + hths[ii][0] + "\" value=\"" + hths[ii][0] + "\" usertype=\""+hths[ii][2]+"\" checked /><span title=\"<fmt:message key='charge_phone.hth'/>：" +hths[ii][0]+ ";<fmt:message key='charge_phone.username'/>："+hths[ii][1]+"\" for=\"gmh_" + hths[ii][0] + "\">" + hths[ii][0] + "(" + hths[ii][1] + ")" + "<span></td>";				
			}
			if(ii%colspan!=0)
			{
				var kk = ii%colspan;
				while(kk<colspan)
				{
					tabHtml += "<td></td>";
					kk++;
				}
				tabHtml += "</tr>";
			}
			
			tabHtml = tabHtml.replace("</tr>","");
			if(hths.length>0)
				tabHtml = "<tr><td style=\"text-align:center;\" colspan=\"" + colspan + "\"><button class=\"tsdbutton\" style=\"margin-bottom: 0px;line-height:22px\" onclick=\"$('#ghMultiHthDetTab :checkbox').not(':checked').click()\"><fmt:message key='charge_phone.selectall'/></button><button class=\"tsdbutton\" style=\"margin-bottom: 0px;line-height:22px\" onclick=\"$('#ghMultiHthDetTab :checkbox').click()\"><fmt:message key='charge_phone.unselectall'/></button></td></tr>" + tabHtml;
			//alert(tabHtml);
			$("#ghMultiHthDetTab").html(tabHtml);
		}
		else
			$("#ghMultiHthDetTab").html("");
			
		/*$("#ghMultiHths option").each(function(){
			//hths.push($(this).attr("value"));
			$("#ghMultiHthDetTab :checkbox[value='"+$(this).attr("value")+"']").attr("checked",true);
		});*/
	}
	/**
		添加单个合同号
	*/
	function ghSearch()
	{
		var hthinput = $.trim($("#ghSearchBox").val());
		if(hthinput==""){
			alert("<fmt:message key="charge_phone_dkh.inputBigCustomersID" />");//请输入要缴费的大客户号
			$("#ghSearchBox").select().focus();
			return false;
		}
		var resr = fetchMultiPValue("chargephone.dkhsearch",6,"&Area="+encodeURIComponent($("#area").val())+"&SkrID="+encodeURIComponent($("#skrid").val())+"&Sflx="+encodeURIComponent($("#ghFFFs").val())+"&Version=200404&groupcustid=" + encodeURIComponent(hthinput));
		if(resr[0]!=undefined && resr[0][0]!=undefined){
			if(resr[0][0]==""){
				//判断是否要选择大客户下的合同号进行缴费 Y：选择  N：不选择，直接缴费大客户下所有合同号
				var tsdinicfg = $("#ghInfo").data("tsdinicfg");
				if(tsdinicfg["Phone_BigHthChoose"]=="N"){
					ghMultiHthJfPay([]);
				}
				else
				{
				    resr = fetchMultiArrayValue("revenue.dkhhth",6,"&skrid="+tsd.encodeURIComponent($("#skrid").val()));				
					ghDrawHths(resr);
					autoBlockForm('ghMultiHthJf',20,'ghMultiHthJfclose',"#FFFFFF",false);
					//延迟设置焦点
					setTimeout('$("#ghMultiHthJfSure").focus()',200);
				}
			}
			else{
				alert(resr[0][0]);
			}
		}else{
			alert("<fmt:message key="charge_phone_dkh.ProcedureAbnormality" />");//程序异常
		}
	}
	/**
		多合同号缴费确认面板
	*/
	function ghMultiHthJfPay(hthstrans)
	{		
		if(hthstrans == undefined && $("#ghMultiHthDetTab td :checkbox").size()==0)
		{
			alert("<fmt:message key="charge_phone_dkh.setJiaofeiHTH" />");//请设置要缴费的合同号
			return false;
		}
		
		var hths = [];
		
		if(hthstrans==undefined){
			$("#ghMultiHthDetTab td :checkbox:not(':checked')").each(function(){
				hths.push($(this).val());
			});
		}else{
			hths = hthstrans;
		}
		hths = hths.join(",");
		var hthd = hths;//.replace(new RegExp("\n+","g"),",").replace(new RegExp("\\s+","g"),"");
		//检测输入的合同号的正确性
		/*var ress = fetchMultiPValue("revenue.multihthcheck",6,"&pnums=" + tsd.encodeURIComponent(hthd));
		if(ress[0]!=undefined && ress[0][0]!=undefined)
		{
			if(ress[0][0]=="ERROR")
			{
				if(ress[0][1]=="No nums input")
					alert("请输入合同号");
				else
					alert(ress[0][1] + " 为无效合同号,请确认输入正确的合同号");
				return false;
			}
		}*/
		$("#ghInfo").data("hthlist",hthd);
		$("#ghInfo").data("hthlistpay","Y");
		
		//var tmpPayType = $("#ghInfo").data("paytype");
		//$("#ghInfo").data("paytype",$("#ghFFFs option").not("#ghFFFs option[cval^='d']").remove());//dtransfer
		//$("#ghFFFs").append(tmpPayType);
		
		$("#ghInfo").data("ghmultiparam",$("#ghSearchBox").val());
		
		setTimeout($.unblockUI,100);
		
		setTimeout("btnFindClick('groupcustomer','','group')",100);
	}
	
	//设置发票
	function printRep(reportname,params,flag)
	{
		var urll = params+"&"+new Date().getTime();
		if(flag==1)
		{
			params = params.replace(new RegExp("&","g"),"");
			params = params.replace(new RegExp("=","g"),"_");
			printWithoutPreview("commonreport/" + reportname,params);
		}else
		{
			printThisReport1('<%=request.getParameter("imenuid")%>',
					reportname,urll,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',2);
		}	
	}
	
	//电话大客户缴费明细
	function ghBigHth()
	{
		//var res  = fetchMultiArrayValue("revenue.bighthdetail",6,"&skrid=" + encodeURIComponent($("#skrid").val()));
		var temp = "";
		//$("#multiHthDetailTab").empty();
		if($("#multiHthDetailTab tr").size()>2)	
		{
			return false;
		}		
		temp += "<tr>";//1,序号 2,合同号 3,用户名称 4,电话数量 5,合计应缴 6,本期应缴 7,前期欠费 8,滞纳金
		temp += "<td><fmt:message key="charge_phone_dkh.id" /></td><td><fmt:message key="charge_phone_dkh.hth"/></td><td><fmt:message key="charge_phone_dkh.username"/></td><td><fmt:message key="charge_phone_dkh.telPhoneNumber"/></td><td><fmt:message key="charge_phone_dkh.AggregateShouldPay"/></td><td><fmt:message key="charge_phone_dkh.ThisShouldPay"/></td><td><fmt:message key="charge_phone_dkh.qianqiqianfei"/></td><td><fmt:message key="charge_phone_dkh.znj"/></td>";
		temp += "</tr>";
		$("#multiHthDetailTab").append(temp);
		
		var urlMm = tsd.buildParams({ packgname:'service',
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:"tsdCharge",
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xmlattr',//返回数据格式 
				tsdpk:"revenue.bighthdetail"
				});
		
		$.ajax({
			url:"mainServlet.html?" + urlMm + "&skrid="+encodeURIComponent($("#skrid").val()),
			async:true,
			cache:false,
			timeout:200000,
			type:'post',
			success:function(xml){
				temp = "";
				$("#multiHthDetailTab").empty();
				var ii = 1;
				
				temp += "<tr>";//1,序号 2,合同号 3,用户名称 4,电话数量 5,合计应缴 6,本期应缴 7,前期欠费 8,滞纳金
				temp += "<td><fmt:message key="charge_phone_dkh.id" /></td><td><fmt:message key="charge_phone_dkh.hth"/></td><td><fmt:message key="charge_phone_dkh.username"/></td><td><fmt:message key="charge_phone_dkh.telPhoneNumber"/></td><td><fmt:message key="charge_phone_dkh.AggregateShouldPay"/></td><td><fmt:message key="charge_phone_dkh.ThisShouldPay"/></td><td><fmt:message key="charge_phone_dkh.qianqiqianfei"/></td><td><fmt:message key="charge_phone_dkh.znj"/></td>";
				temp += "</tr>";
				$(xml).find("row").each(function(){
					temp += "<tr>";
					temp += "<td>";
					temp += ii++;
					temp += "</td>";
					temp += "<td";				
					temp += ">";
					temp += $(this).attr("hth");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("yhmc");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("dhsl");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("yjf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("bqhf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("qqhf");
					temp += "</td>";
					temp += "<td>";
					temp += $(this).attr("znj");
					temp += "</td>";
					temp += "</tr>";
				});
				
				$("#multiHthDetailTab").html(temp);
			}
		});
		$("#multiHthDetail").show();
	}
	
	function chargeClear(){
		fetchMultiPValue('chargephone.chargeclear',6,'&userid=<%=session.getAttribute("userid") %>');
	}
	</script>
  </head>
  
  <body onunload="chargeClear()">
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />
		:
	</div>
	
	<div id="ghBar" style="margin-left: 10px;">
		&nbsp;&nbsp;<span style="font-size: 14px;font-weight: bold;"><fmt:message key="charge_phone_dkh.BigCustomersID" /><!-- 大客户号 -->:</span>
		<input type="text" class="inputbox" id="ghSearchBox" style="margin-left:2px;" 
			name="ghSearchBox"  onkeydown="KeyDown_PhoneBox(event);" />
		<button class="tsdbutton" id="ghSearchByUserName" style="margin-bottom: 0px;" onclick="ghSearch()">
			<fmt:message key="charge_phone_dkh.query" /><!-- 查找 -->
		</button>				
	</div>

	<div id="ghFP">
		<table id="ghInfo" style="display:none"></table>
		<jsp:include page="rev_bill.jsp"></jsp:include>
		<div id="ghYHYE" tip1="<fmt:message key="charge_phone_dkh.RealTimeBalance"/><!-- 实时余额：  元 -->" tip2="<fmt:message key="charge_phone_dkh.InTheCurrent"/><!-- 当前月费用：  元 -->">
			<span class="tip"><fmt:message key="charge_phone_dkh.InTheCurrentCost"/><!-- 当前月份费用： 元 --></span>
			<span class="jfed"></span>
			<br />
			<span class="jfsuccessflag" style="color:#000;font-weight:bold;"></span>
		</div>
	</div>
	
	<div id="multiHthDetail">
		 
		<h6 style="width: 120px"><a onclick="ghBigHth();" href="#"><fmt:message key="charge_phone_dkh.BigCustomersJiaofeiMX"/><!-- 大客户缴费明细 --></a></h6>
		<table id="multiHthDetailTab" width="720" border="1" bordercolor="#eeeeee"
			cellspacing="0" cellpadding="1"
			style="background-color: #eeeeee; border-collapse: collapse;display:none"
			bgcolor="#eeeeee"></table>
	</div>
	<style type="text/css">
		#ghStatus table span,#ghStatus table input,#ghStatus table select{font-size:14px;height:22px;line-height:22px;}
		#ghStatus table input{height:20px}
		#ghStatus{background:#eee;}
	</style>
	<div id="ghStatus">
		<table width="720">
			<tr>
				<td>
					<span id="ghYJLbl"><fmt:message key="charge_phone_dkh.bcShouldPay"/><!-- 本次应缴 --></span>:
				</td>
				<td>
					<input type="text" id="ghYJ" name="ghYJ" readonly="readonly"
						style="width: 90px;font-weight:bold;color:#000" />
				</td>
				<td>
					<span id="ghSsLbl"><fmt:message key="charge_phone_dkh.PaidinAmount"/><!-- 实收金额 --></span>:
				</td>
				<td>
					<!-- onkeypress="numValid(this)"  2012-02-08-->
					<input type="text" id="ghSs" name="ghSs"
						style="ime-mode: disabled; width: 90px;line-height: 16px"
						onpaste="return !clipboardData.getData('text').match(/\D/)"
						ondragenter="return   false" 
						onkeydown="KeyDown_SsjeBox(event);"/>
				</td>
				<td>
					<span><fmt:message key="charge_phone_dkh.PayMoneyWay"/><!-- 付费方式 --></span>：
				</td>
				<td>
					<select id="ghFFFs" style="width: 94px;" onchange="payitem_change('groupcustomer');"></select>
				</td>
				<td>
					<label style="width:110px;margin-left:-4px;" for="ghPayNotPrint">
						<input type="checkbox" id="ghPayNotPrint" name="ghPayNotPrint" onclick="$('#ghSs').select().focus()" checked="checked" /><fmt:message key="charge_phone_dkh.printInvoice"/><!-- 打印发票 -->
					</label>
				</td>
			</tr>
		</table>
	</div>
	<div id="ghButtons" style="text-align: center;">
		<button class="tsdbtn" id="ghsave" style="width: 120px;" disabled onclick="onSave('groupcustomer');">
			<fmt:message key="charge_phone_dkh.save"/><!-- 保存 -->
		</button>
		<span style="visibility: hidden;">____</span>
		<button class="tsdbtn" style="width: 120px;" onclick="ghClearInfo();pageUnLoad();">
			<fmt:message key="charge_phone_dkh.reset"/><!-- 重置 -->
		</button>
	</div>
	
	<!-- 电话多合同号缴费面板 -->
	<div class="neirong" id="ghMultiHthJf" style="display:none; width: 920px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						<fmt:message key="charge_phone_dkh.telphoneHthsJiaofei"/><!-- 电话多合同缴费 -->
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('ghMultiHthJfclose').click();"><fmt:message key="charge_phone_dkh.close"/><!-- 关闭 --></a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>
		</div>

		<div class="midd" style="background-color: #FFFFFF; text-align: left; width: 918px; min-height:200px; overflow-x: hidden;">
			<table>
				<tr>
					<!-- <td>
						<div style="line-height:22px;margin:0px;padding:0px;"><b>合同号列表</b><span title="选中列表中要删除的合同号，按Delete键删除">(Delete键删除)</span></div>
						<select id="ghMultiHths" style="width:160px;height:320px;overflow-y:auto;" multiple="multiple">
							
						</select>
					</td> -->
					<td style="vertical-align:top;">
						<div style="line-height:22px;margin:0px;padding:0px;font-weight:bold;"><fmt:message key="charge_phone_dkh.hthChoose"/><!-- 选择合同号 --></div>
						<table>
							<tr>
								<td colspan="8"><div id="ghMultiHthDetTab_Container"><table id="ghMultiHthDetTab"></table></div></td>
							</tr>
						</table>
						<div id="multiPayYhxz_Container"></div>
					</td>
				</tr>
			</table>
		</div>

		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="ghMultiHthJfSure" onclick="ghMultiHthJfPay()">
				<fmt:message key="charge_phone_dkh.sure"/><!-- 确定 -->
			</button>
			<button type="button" class="tsdbutton" id="ghMultiHthJfclose">
				<fmt:message key="charge_phone_dkh.close"/><!-- 关闭 -->
			</button>
		</div>
	</div>				
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
	<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType%>' />
	<input type="hidden" id="global_param1" name="global_param1" />
	<input type="hidden" id="global_param2" name="global_param2" />
	<input type="hidden" id="global_param3" name="global_param3" />
	<input type="hidden" id="global_param4" name="global_param4" />
	<input type="hidden" id="global_param5" name="global_param5" />

	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea")%>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea")%>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid")%>' />

	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />		

	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
	
	<iframe id="printReportDirect" style="width: 120px; height: 0px; visibility: visible" src="print.jsp"></iframe>
			
  </body>
</html>
