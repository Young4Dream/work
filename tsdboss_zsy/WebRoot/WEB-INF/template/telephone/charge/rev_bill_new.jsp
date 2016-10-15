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
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #f8f8f8;line-height: 40px;" >
		中石油固话费用结算单
	</div>
	<table class="ghInfo" width="90%" border="2" bordercolor="#EEEEEE"
		cellspacing="0" cellpadding="1"
		style="background-color: #EEEEEE border-collapse: collapse;border:1px #EEEEEE solid"
		bgcolor="#eeeeee">
		<tr>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:10%;background-color: #f8f8f8;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:20%;background-color: #f8f8f8;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #eeeeee;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #eeeeee;"><!--话费月份--><!-- <fmt:message key="Revenue.pTelExpenseMonth" /> -->
				话费月份
			</td>
			<td style="background-color: #f8f8f8;"><span class="billdeflet" pjid="hzyf"></span></td>
		    <td style="background-color: #eeeeee;">话费周期</td>
		    <td style="background-color: #f8f8f8;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #eee;">市话费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf2"></span></td>
						<td style="width:10%;background-color: #eee;">国内长途费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf4"></span></td>
						<td style="width:10%;background-color: #eee;">国际长途费</td><td style="width:10%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf5"></span></td>
					    <td style="width:10%;background-color: #eee;">IP电话费</td><td style="width:20%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf6"></span></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">月租费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="zfs1"></span></td>
			            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
			            <td style="width:10%;background-color: #eee;"></td><td style="width:10%;background-color: #f8f8f8;"></td>
			            <td style="width:10%;background-color: #eee;"></td><td style="width:20%;background-color: #f8f8f8;"></td>
<!-- 					<td style="width:10%;background-color: #eee;">上网费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #eee;">特免号码</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf8"></span></td>
						<td style="width:10%;background-color: #eee;">电信手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf16"></span></td>	 -->					
					</tr>
<%-- 					<tr>
						<td style="width:10%;background-color: #eee;">联通手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf10"></span></td>
						<td style="width:10%;background-color: #eee;">移动手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf11"></span></td>
						<td style="width:10%;background-color: #eee;">联通IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf5"></span></td>
						<td style="width:10%;background-color: #eee;">移动IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf12"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">电信IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf13"></span></td>
					<td style="width:10%;background-color: #eee;">减免</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf14"></span></td>
					<td style="width:10%;background-color: #eee;">信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf15"></span></td>
						<td style="width:10%;background-color: #eee;">转入信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf17"></span></td>
						<td style="width:10%;background-color: #eee;">电信11808</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf18"></span></td>
           				 <td style="width:10%;background-color: #eee;">月租费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="zfs1"></span></td>						
					</tr>
					<tr>
			            <td style="width:10%;background-color: #eee;">新业务费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs2"></span></td>
			            <td style="width:10%;background-color: #eee;">宽带费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs3"></span></td>
			            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
			            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
					</tr> --%>
					<tr>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqhf" /></td><td style="width:10%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqhf"></span></td>		
					<!--	<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.jmhf" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="jmhf"></span></td>		-->			
						<td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#EEEEEE;">
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
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #f8f8f8;line-height: 40px;" >
		电话收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#EEEEEE"
		cellspacing="0" cellpadding="1"
		style="background-color: #EEEEEE border-collapse: collapse;border:1px #EEEEEE solid"
		bgcolor="#eeeeee">
		<tr>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #f8f8f8;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #eeeeee;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #eeeeee;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #eee;">市话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf1"></span></td>
						<td style="width:10%;background-color: #eee;">国内长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf2"></span></td>
						<td style="width:10%;background-color: #eee;">国际长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf3"></span></td>
					<%--<td style="width:10%;background-color: #eee;">本地网</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf4"></span></td>--%>
					  <td style="width:10%;background-color: #eee;">内话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf7"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">数据费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf9"></span></td>
					  <td style="width:10%;background-color: #eee;">上网费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #eee;">特免号码</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf8"></span></td>
						<td style="width:10%;background-color: #eee;">电信手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf16"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">联通手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf10"></span></td>
						<td style="width:10%;background-color: #eee;">移动手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf11"></span></td>
						<td style="width:10%;background-color: #eee;">联通IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf5"></span></td>
						<td style="width:10%;background-color: #eee;">移动IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf12"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">电信IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf13"></span></td>
					<%--<td style="width:10%;background-color: #eee;">减免</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf14"></span></td>--%>
					<%--<td style="width:10%;background-color: #eee;">信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf15"></span></td>--%>
						<td style="width:10%;background-color: #eee;">转入信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf17"></span></td>
						<td style="width:10%;background-color: #eee;">电信11808</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf18"></span></td>
            <td style="width:10%;background-color: #eee;">月租费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="zfs1"></span></td>						
					</tr>
					<tr>
            <td style="width:10%;background-color: #eee;">新业务费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs2"></span></td>
            <td style="width:10%;background-color: #eee;">宽带费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs3"></span></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqhf" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#EEEEEE;">
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
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #f8f8f8;line-height: 40px;" >
		电话收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#EEEEEE"
		cellspacing="0" cellpadding="1"
		style="background-color: #EEEEEE border-collapse: collapse;border:1px #EEEEEE solid"
		bgcolor="#eeeeee">
		<tr>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #f8f8f8;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #eeeeee;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #eeeeee;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #eee;">市话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf1"></span></td>
						<td style="width:10%;background-color: #eee;">国内长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf2"></span></td>
						<td style="width:10%;background-color: #eee;">国际长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf3"></span></td>
					<%--<td style="width:10%;background-color: #eee;">本地网</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf4"></span></td>--%>
					  <td style="width:10%;background-color: #eee;">内话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf7"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">数据费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf9"></span></td>
					  <td style="width:10%;background-color: #eee;">上网费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #eee;">特免号码</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf8"></span></td>
						<td style="width:10%;background-color: #eee;">电信手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf16"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">联通手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf10"></span></td>
						<td style="width:10%;background-color: #eee;">移动手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf11"></span></td>
						<td style="width:10%;background-color: #eee;">联通IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf5"></span></td>
						<td style="width:10%;background-color: #eee;">移动IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf12"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">电信IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf13"></span></td>
					<%--<td style="width:10%;background-color: #eee;">减免</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf14"></span></td>--%>
					<%--<td style="width:10%;background-color: #eee;">信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf15"></span></td>--%>
						<td style="width:10%;background-color: #eee;">转入信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf17"></span></td>
						<td style="width:10%;background-color: #eee;">电信11808</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf18"></span></td>
            <td style="width:10%;background-color: #eee;">月租费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="zfs1"></span></td>						
					</tr>
					<tr>
            <td style="width:10%;background-color: #eee;">新业务费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs2"></span></td>
            <td style="width:10%;background-color: #eee;">宽带费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs3"></span></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqhf" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#EEEEEE;">
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
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #f8f8f8;line-height: 40px;" >
		电话收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#EEEEEE"
		cellspacing="0" cellpadding="1"
		style="background-color: #EEEEEE border-collapse: collapse;border:1px #EEEEEE solid"
		bgcolor="#eeeeee">
		<tr>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #f8f8f8;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #eeeeee;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #eeeeee;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #eee;">市话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf1"></span></td>
						<td style="width:10%;background-color: #eee;">国内长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf2"></span></td>
						<td style="width:10%;background-color: #eee;">国际长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf3"></span></td>
					<%--<td style="width:10%;background-color: #eee;">本地网</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf4"></span></td>--%>
					  <td style="width:10%;background-color: #eee;">内话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf7"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">数据费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf9"></span></td>
					  <td style="width:10%;background-color: #eee;">上网费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #eee;">特免号码</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf8"></span></td>
						<td style="width:10%;background-color: #eee;">电信手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf16"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">联通手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf10"></span></td>
						<td style="width:10%;background-color: #eee;">移动手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf11"></span></td>
						<td style="width:10%;background-color: #eee;">联通IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf5"></span></td>
						<td style="width:10%;background-color: #eee;">移动IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf12"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">电信IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf13"></span></td>
					<%--<td style="width:10%;background-color: #eee;">减免</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf14"></span></td>--%>
					<%--<td style="width:10%;background-color: #eee;">信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf15"></span></td>--%>
						<td style="width:10%;background-color: #eee;">转入信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf17"></span></td>
						<td style="width:10%;background-color: #eee;">电信11808</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf18"></span></td>
            <td style="width:10%;background-color: #eee;">月租费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="zfs1"></span></td>						
					</tr>
					<tr>
            <td style="width:10%;background-color: #eee;">新业务费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs2"></span></td>
            <td style="width:10%;background-color: #eee;">宽带费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs3"></span></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqhf" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#EEEEEE;">
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
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #f8f8f8;line-height: 40px;" >
		电话收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#EEEEEE"
		cellspacing="0" cellpadding="1"
		style="background-color: #EEEEEE border-collapse: collapse;border:1px #EEEEEE solid"
		bgcolor="#eeeeee">
		<tr>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #f8f8f8;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #eeeeee;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #eeeeee;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #eee;">市话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf1"></span></td>
						<td style="width:10%;background-color: #eee;">国内长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf2"></span></td>
						<td style="width:10%;background-color: #eee;">国际长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf3"></span></td>
					<%--<td style="width:10%;background-color: #eee;">本地网</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf4"></span></td>--%>
					  <td style="width:10%;background-color: #eee;">内话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf7"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">数据费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf9"></span></td>
					  <td style="width:10%;background-color: #eee;">上网费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #eee;">特免号码</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf8"></span></td>
						<td style="width:10%;background-color: #eee;">电信手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf16"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">联通手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf10"></span></td>
						<td style="width:10%;background-color: #eee;">移动手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf11"></span></td>
						<td style="width:10%;background-color: #eee;">联通IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf5"></span></td>
						<td style="width:10%;background-color: #eee;">移动IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf12"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">电信IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf13"></span></td>
					<%--<td style="width:10%;background-color: #eee;">减免</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf14"></span></td>--%>
					<%--<td style="width:10%;background-color: #eee;">信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf15"></span></td>--%>
						<td style="width:10%;background-color: #eee;">转入信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf17"></span></td>
						<td style="width:10%;background-color: #eee;">电信11808</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf18"></span></td>
            <td style="width:10%;background-color: #eee;">月租费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="zfs1"></span></td>						
					</tr>
					<tr>
            <td style="width:10%;background-color: #eee;">新业务费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs2"></span></td>
            <td style="width:10%;background-color: #eee;">宽带费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs3"></span></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqhf" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#EEEEEE;">
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
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #f8f8f8;line-height: 40px;" >
		电话收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#EEEEEE"
		cellspacing="0" cellpadding="1"
		style="background-color: #EEEEEE border-collapse: collapse;border:1px #EEEEEE solid"
		bgcolor="#eeeeee">
		<tr>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #f8f8f8;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #eeeeee;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #eeeeee;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #eee;">市话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf1"></span></td>
						<td style="width:10%;background-color: #eee;">国内长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf2"></span></td>
						<td style="width:10%;background-color: #eee;">国际长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf3"></span></td>
					<%--<td style="width:10%;background-color: #eee;">本地网</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf4"></span></td>--%>
					  <td style="width:10%;background-color: #eee;">内话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf7"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">数据费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf9"></span></td>
					  <td style="width:10%;background-color: #eee;">上网费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #eee;">特免号码</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf8"></span></td>
						<td style="width:10%;background-color: #eee;">电信手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf16"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">联通手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf10"></span></td>
						<td style="width:10%;background-color: #eee;">移动手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf11"></span></td>
						<td style="width:10%;background-color: #eee;">联通IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf5"></span></td>
						<td style="width:10%;background-color: #eee;">移动IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf12"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">电信IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf13"></span></td>
					<%--<td style="width:10%;background-color: #eee;">减免</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf14"></span></td>--%>
					<%--<td style="width:10%;background-color: #eee;">信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf15"></span></td>--%>
						<td style="width:10%;background-color: #eee;">转入信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf17"></span></td>
						<td style="width:10%;background-color: #eee;">电信11808</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf18"></span></td>
            <td style="width:10%;background-color: #eee;">月租费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="zfs1"></span></td>						
					</tr>
					<tr>
            <td style="width:10%;background-color: #eee;">新业务费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs2"></span></td>
            <td style="width:10%;background-color: #eee;">宽带费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs3"></span></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqhf" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#EEEEEE;">
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
	<div id="ghInfoTitle" style="width: 100%;height:40px;background-color: #f8f8f8;line-height: 40px;" >
		电话收费单
	</div>
	<table class="ghInfo" width="100%" border="2" bordercolor="#EEEEEE"
		cellspacing="0" cellpadding="1"
		style="background-color: #EEEEEE border-collapse: collapse;border:1px #EEEEEE solid"
		bgcolor="#eeeeee">
		<tr>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.reportdh"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="dh"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.payaccount"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hth"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.dhcounts"/></td>
			<td style="width:15%;background-color: #f8f8f8;">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td>
			<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.jstype"/></td>
			<td style="width:15%;background-color: #f8f8f8;"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.cash"/></span></td>
			
		</tr>
		<tr>
			<td style="background-color: #eeeeee;"><fmt:message key="charge_phone_js.reportusername"/></td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color: #eeeeee;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3" style="background-color: #f8f8f8;"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		
		<tr>
			<td colspan="8">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td style="width:10%;background-color: #eee;">市话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf1"></span></td>
						<td style="width:10%;background-color: #eee;">国内长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf2"></span></td>
						<td style="width:10%;background-color: #eee;">国际长途</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf3"></span></td>
					<%--<td style="width:10%;background-color: #eee;">本地网</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf4"></span></td>--%>
					  <td style="width:10%;background-color: #eee;">内话</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf7"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">数据费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf9"></span></td>
					  <td style="width:10%;background-color: #eee;">上网费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf6"></span></td>
						<td style="width:10%;background-color: #eee;">特免号码</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf8"></span></td>
						<td style="width:10%;background-color: #eee;">电信手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf16"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">联通手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf10"></span></td>
						<td style="width:10%;background-color: #eee;">移动手机</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf11"></span></td>
						<td style="width:10%;background-color: #eee;">联通IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf5"></span></td>
						<td style="width:10%;background-color: #eee;">移动IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf12"></span></td>						
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;">电信IP</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf13"></span></td>
					<%--<td style="width:10%;background-color: #eee;">减免</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf14"></span></td>--%>
					<%--<td style="width:10%;background-color: #eee;">信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf15"></span></td>--%>
						<td style="width:10%;background-color: #eee;">转入信息</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf17"></span></td>
						<td style="width:10%;background-color: #eee;">电信11808</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="hf18"></span></td>
            <td style="width:10%;background-color: #eee;">月租费</td><td style="width:15%;background-color: #f8f8f8;"><span class="billdeflet" pjid="zfs1"></span></td>						
					</tr>
					<tr>
            <td style="width:10%;background-color: #eee;">新业务费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs2"></span></td>
            <td style="width:10%;background-color: #eee;">宽带费</td><td style="width:15%;background-color: #f8f8f8;"></span><span class="billdeflet" pjid="zfs3"></span></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
            <td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;"></td>
					</tr>
					<tr>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.sqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqfee" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqye"></span></td>
						<td style="width:10%;background-color: #eee;"><fmt:message key="charge_phone_js.bqhf" /></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"><span class="billdeflet" pjid="bqhf"></span></td>						
						<td style="width:10%;background-color: #eee;"></td><td style="width:15%;background-color: #f8f8f8;border:1px #EEEEEE solid"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#EEEEEE;">
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
		电话收费单
	</div>
	<table class="ghInfo" width="680" border="2" bordercolor="#EEEEEE"
		cellspacing="0" cellpadding="1"
		style="background-color: #EEEEEE border-collapse: collapse;border:1px #EEEEEE solid"
		bgcolor="#eeeeee">
		<tr>
			<td style="background-color:#EEEEEE;"><fmt:message key="charge_phone_js.reportusername"/></td><td colspan="2"><span class="billdeflet" pjid="yhmc"  style="font-size:18px;color:#F00"></span></td>
			<td style="background-color:#EEEEEE;"><!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td colspan="3"><span class="billdeflet" pjid="out_bz2"></span></td>
		</tr>
		<tr>
			<td width="80" style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.reportdh"/>
			</td>
			<td width="180">
				<span class="billdeflet" pjid="dh"></span>
			</td>
			<td width="80" style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.payaccount"/>
			</td>
			<td width="140">
				<span class="billdeflet" pjid="hth"></span>
			</td>
			<td width="100">				
				<table style="float:left;display:inline-block;"><tr><td style="background-color:#EEEEEE;"><fmt:message key="charge_phone_js.dhcounts"/></td><td width="30">&nbsp;&nbsp;<span class="billdeflet" pjid="dhsl" trunc="int"></span></td></tr></table>
			</td>
			<td width="100">
				<table style="float:left;display:inline-block;"><tr><td style="background-color:#EEEEEE;"><fmt:message key="charge_phone_js.jstype"/></td><td width="30"><span id="pjffs" class="billdeflet" pjid="sflx"><fmt:message key="charge_phone_js.feecheck"/></span></td></tr></table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<!--话费月份-->
				<fmt:message key="Revenue.pTelExpenseMonth" />
			</td>
			<td>
				<span class="billdeflet" pjid="out_bz2"></span>
			</td>
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.hfcount"/>
			</td>
			<td colspan="3">
				<span class="billdeflet" pjid="out_bz3"></span>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<table width="680" border="0" cellspacing="0" cellpadding="0" bordercolor="#eeeeee" style="background-color: #eeeeee; border-collapse: collapse" bgcolor="#eeeeee">
					<tr>
						<td width="85" style="background-color:#EEEEEE;">电信市话</td><td width="85"><span class="billdeflet" pjid="jn"></span></td>
						<td width="85" style="background-color:#EEEEEE;">电信国内</td><td width="85"><span class="billdeflet" pjid="jw"></span></td>
						<td width="85" style="background-color:#EEEEEE;">电信国际</td><td width="85"><span class="billdeflet" pjid="gnctf"></span></td>
						<td width="85" style="background-color:#EEEEEE;">移动国内</td><td width="85"><span class="billdeflet" pjid="gjctf"></span></td>						
					</tr>
					<tr>
						<!--<td style="background-color:#EEEEEE;">IP话费</td><td><span class="billdeflet" pjid="iphf"></span></td>-->
						<td style="background-color:#EEEEEE;">港澳台</td><td><span class="billdeflet" pjid="got"></span></td>
            <td style="background-color:#EEEEEE;">月租费</td><td><span class="billdeflet" pjid="yzf"></span></td>
						<!--<td style="background-color:#EEEEEE;">中兴宽带</td><td><span class="billdeflet" pjid="kdf"></span></td>-->
					</tr>
					<!--<tr>	
						<td style="background-color:#EEEEEE;">代收宽带</td><td><span class="billdeflet" pjid="dskdf"></span></td>		
						<td style="background-color:#EEEEEE;">新功能费</td><td width="85"><span class="billdeflet" pjid="xgn"></span></td>
						<td></td><td></td>					
					</tr>-->
					<tr>
						<td style="background-color:#EEEEEE;"><fmt:message key="charge_phone_js.sqfee" /></td><td><span class="billdeflet" pjid="sqye"></span></td>		
						<td style="background-color:#EEEEEE;"><fmt:message key="charge_phone_js.bqfee" /></td><td><span class="billdeflet" pjid="bqye"></span></td>
						<td style="background-color:#EEEEEE;"><fmt:message key="charge_phone_js.bqhf" /></td><td><span class="billdeflet" pjid="bqhf"></span></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr style="display:none;">
			<td style="background-color:#EEEEEE;">
				<fmt:message key="charge_phone_js.feermb"/>
			</td>
			<td colspan="2">
				<span xjid="bcssd"></span>
			</td>
			<td style="background-color:#EEEEEE;">
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


