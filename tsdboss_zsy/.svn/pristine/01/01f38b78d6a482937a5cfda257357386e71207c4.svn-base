<%----------------------------------------
	name: rev_bill.jsp
	author: chenze
	version: 1.0, 2011-01-23
	description: 
	modify: 添加国际化信息 chenliang 2012-01-12 
	
	国际化标签说明：

	charge_phone_js.reporttitle=义煤通信固话费用结算单
	charge_phone_js.reportusername=客户名称
	charge_phone_js.reportpoint=信誉积分
	charge_phone_js.reportdh=电话号码
	charge_phone_js.payaccount=付费账号
	charge_phone_js.dhcounts=电话部数
	charge_phone_js.jstype=结算方式
	charge_phone_js.cash=现金
	charge_phone_js.hfcount=话费周期
	charge_phone_js.jbfee=基本费
	charge_phone_js.ctfee=长途费
	charge_phone_js.yzfee=月租费
	charge_phone_js.newfee=新功能使用费
	charge_phone_js.tcfee=套餐费
	charge_phone_js.yhfee=优惠费
	charge_phone_js.znjfee=滞纳金
	charge_phone_js.sqfee=上期余额
	charge_phone_js.bqfee=本期余额
	charge_phone_js.bqhf=本期话费
	charge_phone_js.feermb=金额(大写)
	charge_phone_js.feecheck=支票
	charge_phone_js.expert=内行
	
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<style type="text/css">
.oddtd{background-color:#F00;}
.ghInfo td{font-size:14px;} 
.billdeflet{font-size:12px;font-weight:bold;}
</style>
<%--  现金票    -----------------------------------------begin------------------------------------------------------------------------------  --%>
<div class="config_bill" xid="cash">
	
	<table class="ghInfo" width="65%" border="2" bordercolor="#A9C8D9"
		cellspacing="0" cellpadding="1"
		style=" border-collapse: collapse;border:1px #A9C8D9 solid">
		<tr>
			<td colspan="8">
				<label style="font-size: 20px;font-weight: bold;width: 100%;text-align: center;margin-top: 10px;margin-bottom: 10px;">综合业务收费单</label>
				<br />
			</td>
		</tr>
		
		<tr>
			<td style="width:10%;background-color: #F5FAFE;">客户号</td>
			<td style="width:15%;"><span class="billdeflet" id="custno"></span></td>
			<td style="width:10%;background-color: #F5FAFE;">用户性质</td>
			<td style="width:15%;">&nbsp;&nbsp;<span class="billdeflet" id="custtype"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;" colspan="3"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
		</tr>
		<tr>
			<td style="background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3"><span class="billdeflet" id="custname"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #F5FAFE;">
				费用月份
			</td>
			<td colspan="3" ><span class="billdeflet" id="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">电话费</td><td style="width:15%;"><span class="billdeflet" id="hf1"></span></td>
						<td style="width:11%;background-color: #F5FAFE;">宽带费</td><td style="width:15%;"><span class="billdeflet" id="hf2"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">集群业务费</td><td style="width:15%;"><span class="billdeflet" id="hf3"></span></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">光缆业务费</td><td style="width:15%;"><span class="billdeflet" id="hf4"></span></td>
						<td style="width:11%;background-color: #F5FAFE;">数字链路业务</td><td style="width:15%;"><span class="billdeflet" id="hf5"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">VPN业务费</td><td style="width:15%;"><span class="billdeflet" id="hf6"></span></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">增值业务费</td><td style="width:15%;"><span class="billdeflet" id="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;"><span class="billdeflet" id="hf8"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;"><span class="billdeflet" id="hf8"></span></td>				
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><span class="billdeflet" id="sqye"></span></td>		
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;border-top:1px #A9C8D9 solid;"><span class="billdeflet" id="bqye"></span></td>
						<td style="width:10%;border-top:1px #A9C8D9 solid;"></td><td style="width:15%;border-top:1px #A9C8D9 solid;"><span class="billdeflet" pjid="bqhf"></span></td>						
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<!--实收-->
				<fmt:message key="Revenue.Paid" />
			</td>
			<td colspan="2">
				<span xjid="bcsss"></span>
				<span class="billdeflet" pjid="sflxto" style="display:none;"></span>
			</td>
		</tr>
	</table>
</div>
<%--  现金票    -----------------------------------------end  ------------------------------------------------------------------------------  --%>
<%--  <fmt:message key="charge_phone_js.feecheck"/>    -----------------------------------------begin------------------------------------------------------------------------------  --%>
<div class="config_bill" style="display:none" xid="cheque">
	
	<table class="ghInfo" width="65%" border="2" bordercolor="#A9C8D9"
		cellspacing="0" cellpadding="1"
		style="border-collapse: collapse;border:1px #A9C8D9 solid">
		<tr>
			<td colspan="8" style="background-color: #F5FAFE;">
				<label style="font-size: 20px;font-weight: bold;width: 100%;text-align: center;margin-top: 10px;margin-bottom: 10px;">综合业务收费单</label>
				<br />
			</td>
		</tr>
		<tr>
			<td style="width:10%;background-color: #F5FAFE;">客户号</td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="custno"></span></td>
			<td style="width:10%;background-color: #F5FAFE;">用户性质</td>
			<td style="width:15%;background-color: #F5FAFE;">&nbsp;&nbsp;<span class="billdeflet" id="custtype"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" id="custname"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #F5FAFE;">
				费用月份
			</td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" id="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">电话费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf1"></span></td>
						<td style="width:15%;background-color: #F5FAFE;">宽带费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf2"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">集群业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf3"></span></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">光缆业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf4"></span></td>
						<td style="width:15%;background-color: #F5FAFE;">数字链路业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf5"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">VPN业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf6"></span></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">增值业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf8"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf8"></span></td>				
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><span class="billdeflet" id="sqye"></span></td>		
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"><span class="billdeflet" id="bqye"></span></td>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"><span class="billdeflet" pjid="bqhf"></span></td>						
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<!--实收-->
				<fmt:message key="Revenue.Paid" />
			</td>
			<td colspan="2">
				<span xjid="bcsss"></span>
				<span class="billdeflet" pjid="sflxto" style="display:none;"></span>
			</td>
		</tr>
	</table>
</div>
<%--  <fmt:message key="charge_phone_js.feecheck"/>    -----------------------------------------end  ------------------------------------------------------------------------------  --%>
<%--  内联票    -----------------------------------------begin------------------------------------------------------------------------------  --%>
<div class="config_bill" style="display:none" xid="transfer">
	
	<table class="ghInfo" width="65%" border="2" bordercolor="#A9C8D9"
		cellspacing="0" cellpadding="1"
		style="border-collapse: collapse;border:1px #A9C8D9 solid">
		<tr>
			<td colspan="8" style="background-color: #F5FAFE;">
				<label style="font-size: 20px;font-weight: bold;width: 100%;text-align: center;margin-top: 10px;margin-bottom: 10px;">综合业务收费单</label>
				<br />
			</td>
		</tr>
		<tr>
			<td style="width:10%;background-color: #F5FAFE;">客户号</td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="custno"></span></td>
			<td style="width:10%;background-color: #F5FAFE;">用户性质</td>
			<td style="width:15%;background-color: #F5FAFE;">&nbsp;&nbsp;<span class="billdeflet" id="custtype"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" id="custname"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #F5FAFE;">
				费用月份
			</td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" id="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">电话费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf1"></span></td>
						<td style="width:15%;background-color: #F5FAFE;">宽带费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf2"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">集群业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf3"></span></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">光缆业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf4"></span></td>
						<td style="width:15%;background-color: #F5FAFE;">数字链路业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf5"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">VPN业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf6"></span></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">增值业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf8"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf8"></span></td>				
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><span class="billdeflet" id="sqye"></span></td>		
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"><span class="billdeflet" id="bqye"></span></td>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"><span class="billdeflet" pjid="bqhf"></span></td>						
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<!--实收-->
				<fmt:message key="Revenue.Paid" />
			</td>
			<td colspan="2">
				<span xjid="bcsss"></span>
				<span class="billdeflet" pjid="sflxto" style="display:none;"></span>
			</td>
		</tr>
	</table>
</div>


<%--  预付    -----------------------------------------begin------------------------------------------------------------------------------  --%>
<div class="config_bill" style="display:none" xid="prepayment">
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #F5FAFE;line-height: 40px;" >
		综合业务收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#F5FAFE"
		cellspacing="0" cellpadding="1"
		style="background-color: #F5FAFE border-collapse: collapse;border:1px #F5FAFE solid"
		bgcolor="#F5FAFE">
		<tr>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #F5FAFE;">用户性质</td>
			<td style="width:15%;background-color: #F5FAFE;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" id="custname"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #F5FAFE;">
				费用月份
			</td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" id="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">电话费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf1"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">宽带费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf2"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">集群业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf3"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">光缆业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf4"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">数字链路业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf5"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">VPN业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">增值业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" id="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><span class="billdeflet" id="sqye"></span></td>		
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-right: 1px #A9C8D9 solid;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"><span class="billdeflet" id="bqye"></span></td>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;"><span class="billdeflet" pjid="bqhf"></span></td>						
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<!--实收-->
				<fmt:message key="Revenue.Paid" />
			</td>
			<td colspan="2">
				<span xjid="bcsss"></span>
				<span class="billdeflet" pjid="sflxto" style="display:none;"></span>
			</td>
		</tr>
	</table>
</div>

<%--  内联票    -----------------------------------------end  ------------------------------------------------------------------------------  --%>

<%--  内联票    -----------------------------------------begin------------------------------------------------------------------------------  --%>
<div class="config_bill" style="display:none" xid="dcash">
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #F5FAFE;line-height: 40px;" >
		综合业务收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#F5FAFE"
		cellspacing="0" cellpadding="1"
		style="background-color: #F5FAFE border-collapse: collapse;border:1px #F5FAFE solid"
		bgcolor="#F5FAFE">
		<tr>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #F5FAFE;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #F5FAFE;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">电话费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf9"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">宽带费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">集群业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">光缆业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">数字链路业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf9"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">VPN业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">增值业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<!--实收-->
				<fmt:message key="Revenue.Paid" />
			</td>
			<td colspan="2">
				<span xjid="bcsss"></span>
				<span class="billdeflet" pjid="sflxto" style="display:none;"></span>
			</td>
		</tr>
	</table>
</div>
<%--  内联票    -----------------------------------------end  ------------------------------------------------------------------------------  --%>

<%--  内联票    -----------------------------------------begin------------------------------------------------------------------------------  --%>
<div class="config_bill" style="display:none" xid="dtransfer">
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #F5FAFE;line-height: 40px;" >
		综合业务收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#F5FAFE"
		cellspacing="0" cellpadding="1"
		style="background-color: #F5FAFE border-collapse: collapse;border:1px #F5FAFE solid"
		bgcolor="#F5FAFE">
		<tr>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #F5FAFE;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #F5FAFE;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">电话费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf9"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">宽带费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">集群业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">光缆业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">数字链路业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf9"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">VPN业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">增值业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<!--实收-->
				<fmt:message key="Revenue.Paid" />
			</td>
			<td colspan="2">
				<span xjid="bcsss"></span>
				<span class="billdeflet" pjid="sflxto" style="display:none;"></span>
			</td>
		</tr>
	</table>
</div>
<%--  内联票    -----------------------------------------end  ------------------------------------------------------------------------------  --%>


<%--  托收  -----------------------------------------begin------------------------------------------------------------------------------  --%>
<div class="config_bill" style="display:none" xid="inside">
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #F5FAFE;line-height: 40px;" >
		综合业务收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#F5FAFE"
		cellspacing="0" cellpadding="1"
		style="background-color: #F5FAFE border-collapse: collapse;border:1px #F5FAFE solid"
		bgcolor="#F5FAFE">
		<tr>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #F5FAFE;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #F5FAFE;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #F5FAFE;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #F5FAFE;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #F5FAFE;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #F5FAFE;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">电话费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf9"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">宽带费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">集群业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">光缆业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">数字链路业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf9"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">VPN业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">增值业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<!--实收-->
				<fmt:message key="Revenue.Paid" />
			</td>
			<td colspan="2">
				<span xjid="bcsss"></span>
				<span class="billdeflet" pjid="sflxto" style="display:none;"></span>
			</td>
		</tr>
	</table>
</div>
<%--  托收   -----------------------------------------end  ------------------------------------------------------------------------------  --%>


<%--  大客户支票   -----------------------------------------begin------------------------------------------------------------------------------  --%>
<div class="config_bill" style="display:none" xid="dcheque">
	<div id="ghInfoTitle">
		综合业务收费单
	</div>
	<table class="ghInfo" width="680" border="2" bordercolor="#F5FAFE"
		cellspacing="0" cellpadding="1"
		style="background-color: #F5FAFE border-collapse: collapse;border:1px #F5FAFE solid"
		bgcolor="#F5FAFE">
		<tr>
			<td style="background-color:#F5FAFE;"><fmt:message key="charge_phone_js.reportusername"/></td><td colspan="2"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color:#F5FAFE;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		<tr>
			<td width="80" style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.reportdh"/>
			</td>
			<td width="180">
				<span class="billdeflet" pjid="dh"></span>
			</td>
			<td width="80" style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.payaccount"/>
			</td>
			<td width="140">
				<span class="billdeflet" pjid="hth"></span>
			</td>
			<td width="100">				
				<table style="float:left;display:inline-block;"><tr><td style="background-color:#F5FAFE;"><fmt:message key="charge_phone_js.dhcounts"/></td><td width="30">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td></tr></table>
			</td>
			<td width="100">
				<table style="float:left;display:inline-block;"><tr><td style="background-color:#F5FAFE;"><fmt:message key="charge_phone_js.jstype"/></td><td width="30"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.feecheck"/></span></td></tr></table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td>
				<span class="billdeflet" pjid="out_bz2"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.hfcount"/>
			</td>
			<td colspan="3">
				<span class="billdeflet" pjid="out_bz3"></span>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">电话费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf9"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">宽带费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">集群业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">光缆业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;">数字链路业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf9"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">VPN业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #F5FAFE;">增值业务费</td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf7"></span></td>
						<td style="width:10%;background-color: #F5FAFE;"></td><td style="width:15%;background-color: #F5FAFE;"><span class="billdeflet" pjid="hf8"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #F5FAFE;border:1px #A9C8D9 solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></td><td style="width:15%;background-color: #F5FAFE;border-top:1px #A9C8D9 solid;border-bottom:1px #A9C8D9 solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#F5FAFE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#F5FAFE;">
				<!--实收-->
				<fmt:message key="Revenue.Paid" />
			</td>
			<td colspan="2">
				<span xjid="bcsss"></span>
				<span class="billdeflet" pjid="sflxto" style="display:none;"></span>
			</td>
		</tr>
	</table>
</div>
<%--  内联票    -----------------------------------------end  ------------------------------------------------------------------------------  --%>


