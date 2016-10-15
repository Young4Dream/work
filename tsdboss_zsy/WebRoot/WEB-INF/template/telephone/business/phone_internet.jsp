<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>电话业务受理js文件国际化标签隐藏域</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript" >
	function clearMultiSelect_AABC(){
			$(".multiSelectOptions :checkbox:checked").attr("checked",false).parent().removeClass("checked");
			$(".multiSelectOptions :disabled").removeAttr("disabled");
			$(".multiSelect").attr("trueval","");
			$("#checkroutetype").attr("trueval","");
		}
</script>
  </head>
  
  <body>
    <!-- js中国际化隐藏域 -->
  <input type="hidden" id="getnullphone" value="<fmt:message key="phone.getnullphone"/>"/><!-- 请先选择一个电话空号 -->
  <input type="hidden" id="getselectyhlb" value='<fmt:message key="phone.getselectyhlb" />'/><!-- 请选择用户类别 -->
  <input type="hidden" id="getinternet0001" value='<fmt:message key="phone.getinternet0001" />'/><!-- 公费用户请选择一级部门！ -->
  <input type="hidden" id="getinternet0002" value='<fmt:message key="phone.getinternet0002" />'/><!-- 请输入合同号！ -->
  <input type="hidden" id="getinternet0003" value='<fmt:message key="phone.getinternet0003" />'/><!-- 合同号只能输入字母和数字! -->
  <input type="hidden" id="getinternet0004" value='<fmt:message key="phone.getinternet0004" />'/><!-- 对不起，合同号 -->
  <input type="hidden" id="getinternet0005" value='<fmt:message key="phone.getinternet0005" />'/><!-- 已在合同号档案中存在，请重新输入！-->
  <input type="hidden" id="getinternet0006" value='<fmt:message key="phone.getinternet0006" />'/><!-- 请选择要添加的费用名称-->
  <input type="hidden" id="getinternet0007" value='<fmt:message key="phone.getinternet0007" />'/><!-- 请选择要添加的费用子类型-->
  <input type="hidden" id="getinternet0008" value='<fmt:message key="phone.getinternet0008" />'/><!-- 该费用子类型已经存在不能重复添加！-->
  <input type="hidden" id="getinternet0009" value='<fmt:message key="phone.getinternet0009" />'/><!-- 新增失败！-->
  <input type="hidden" id="getinternet0010" value='<fmt:message key="phone.getinternet0010" />'/><!-- 请选择要删除的杂费项信息-->
  <input type="hidden" id="getinternet0011" value='<fmt:message key="phone.getinternet0011" />'/><!-- 删除杂费失败-->
  <input type="hidden" id="getinternet0012" value='<fmt:message key="phone.getinternet0012" />'/><!-- 请选择优惠套餐类型-->
  <input type="hidden" id="getinternet0013" value='<fmt:message key="phone.getinternet0013" />'/><!-- 优惠套餐-->
  <input type="hidden" id="getinternet0014" value='<fmt:message key="phone.getinternet0014" />'/><!-- 已经存在，不能重复添加-->
  <input type="hidden" id="getinternet0015" value='<fmt:message key="phone.getinternet0015" />'/><!-- 终止月份必须大于起始月份-->
  <input type="hidden" id="getinternet0016" value='<fmt:message key="phone.getinternet0016" />'/><!-- 添加数据成功-->
  <input type="hidden" id="getinternet0017" value='<fmt:message key="phone.getinternet0017" />'/><!-- 添加数据失败-->
  <input type="hidden" id="getinternet0018" value='<fmt:message key="phone.getinternet0018" />'/><!-- 请选择要删除和套餐项-->
  <input type="hidden" id="getinternet0019" value='<fmt:message key="phone.getinternet0019" />'/><!-- 删除套餐成功-->
  <input type="hidden" id="getinternet0020" value='<fmt:message key="phone.getinternet0020" />'/><!-- 删除套餐失败-->
  <input type="hidden" id="getinternet0021" value='<fmt:message key="phone.getinternet0021" />'/><!-- 请选择一级部门-->
  <input type="hidden" id="getinternet0022" value='<fmt:message key="phone.getinternet0022" />'/><!-- 生成合同号失败-->
  <input type="hidden" id="getinternet0023" value='<fmt:message key="phone.getinternet0023" />'/><!-- 数据处理中，请稍等…………-->
  <input type="hidden" id="getinternet0024" value='<fmt:message key="phone.getinternet0024" />'/><!-- 请选择电话类型-->
  <input type="hidden" id="getinternet0025" value='<fmt:message key="phone.getinternet0025" />'/><!-- 合同号不能为空,请生成或输入一个合同号-->
  <input type="hidden" id="getinternet0026" value='<fmt:message key="phone.getinternet0026" />'/><!-- 合同号信息中[-->
  <input type="hidden" id="getinternet0027" value='<fmt:message key="phone.getinternet0027" />'/><!-- ]不能为空!-->
  <input type="hidden" id="getinternet0028" value='<fmt:message key="phone.getinternet0028" />'/><!-- 当前用户类别为公费，必须选择一级部门-->
  <input type="hidden" id="getinternet0029" value='<fmt:message key="phone.getinternet0029" />'/><!-- 合同号信息中邮件格式不正确！！！-->
  <input type="hidden" id="getinternet0030" value='<fmt:message key="phone.getinternet0030" />'/><!-- 合同号信息中请输入正确的身份证号码-->
  <input type="hidden" id="getinternet0031" value='<fmt:message key="phone.getinternet0031" />'/><!-- 用户档信息中[-->
  <input type="hidden" id="getinternet0032" value='<fmt:message key="phone.getinternet0032" />'/><!-- 固话信息中请输入正确的身份证号码-->
  <input type="hidden" id="getinternet0033" value='<fmt:message key="phone.getinternet0033" />'/><!-- 当前用户类别为公费，请选择固话信息中的一级部门-->
  <input type="hidden" id="getinternet0034" value='<fmt:message key="phone.getinternet0034" />'/><!-- 至少应该添加一项月租费-->
  <input type="hidden" id="getinternet0035" value='<fmt:message key="phone.getinternet0035" />'/><!-- 请输入预存金额-->
  <input type="hidden" id="getinternet0036" value='<fmt:message key="phone.getinternet0036" />'/><!-- 请输入确认金额-->
  <input type="hidden" id="getinternet0037" value='<fmt:message key="phone.getinternet0037" />'/><!-- 预存金额与确认金额不一致！-->
  <input type="hidden" id="getinternet0038" value='<fmt:message key="phone.getinternet0038" />'/><!-- 请输入正确的金额！-->
  <input type="hidden" id="getinternet0039" value='<fmt:message key="phone.getinternet0039" />'/><!-- 开户失败-->
  <input type="hidden" id="getinternet0040" value='<fmt:message key="phone.getinternet0040" />'/><!-- 操作失败-->
  <input type="hidden" id="getinternet0041" value='<fmt:message key="phone.getinternet0041" />'/><!-- 请输入查询条件！-->
  <input type="hidden" id="getinternet0042" value='<fmt:message key="phone.getinternet0042" />'/><!-- 请选择查询类别！-->
  <input type="hidden" id="getinternet0043" value='<fmt:message key="phone.getinternet0043" />'/><!-- 确认代缴：\n\n-->
  <input type="hidden" id="getinternet0044" value='<fmt:message key="phone.getinternet0044" />'/><!-- 电话[-->
  <input type="hidden" id="getinternet0045" value='<fmt:message key="phone.getinternet0045" />'/><!-- 的用户由:\n\n-->
  <input type="hidden" id="getinternet0046" value='<fmt:message key="phone.getinternet0046" />'/><!-- 缴纳！\n-->
  <input type="hidden" id="getinternet0047" value='<fmt:message key="phone.getinternet0047" />'/><!-- 请选择合同号！-->
  <input type="hidden" id="getinternet0048" value='<fmt:message key="phone.getinternet0048" />'/><!-- 该合同号为当前受理的账户合同号，不能选择！-->
  <input type="hidden" id="getinternet0049" value='<fmt:message key="phone.getinternet0049" />'/><!-- 请输入实际金额！-->
  <input type="hidden" id="getinternet0050" value='<fmt:message key="phone.getinternet0050" />'/><!-- 删除数据成功-->
  <input type="hidden" id="getinternet0051" value='<fmt:message key="phone.getinternet0051" />'/><!-- 删除数据失败-->
  <input type="hidden" id="getinternet0052" value='<fmt:message key="phone.getinternet0052" />'/><!-- 该费用没有金额！-->
  <input type="hidden" id="getinternet0053" value='<fmt:message key="phone.getinternet0053" />'/><!-- 请选择套餐组！-->
  <input type="hidden" id="getinternet0054" value='<fmt:message key="phone.getinternet0054" />'/><!-- 请选择包月套餐类型-->
  <input type="hidden" id="getinternet0055" value='<fmt:message key="phone.getinternet0055" />'/><!-- 包月套餐\-->
  <input type="hidden" id="getinternet0056" value='<fmt:message key="phone.getinternet0056" />'/><!-- 出现意外情况，请马上联系系统管理员!-->
  <input type="hidden" id="getinternet0057" value='<fmt:message key="phone.getinternet0057" />'/><!-- 请选择代缴费用项！-->
  <input type="hidden" id="getinternet0058" value='<fmt:message key="phone.getinternet0058" />'/><!-- 请选择代缴名称！-->
  <input type="hidden" id="getinternet0059" value='<fmt:message key="phone.getinternet0059" />'/><!-- 代缴合同号不能为空！-->
  <input type="hidden" id="getinternet0060" value='<fmt:message key="phone.getinternet0060" />'/><!-- 代缴金额不能为空！-->
  <input type="hidden" id="getinternet0061" value='<fmt:message key="phone.getinternet0061" />'/><!-- 代缴比例不能为空！-->
  <input type="hidden" id="getinternet0062" value='<fmt:message key="phone.getinternet0062" />'/><!-- 代缴比例不能大于该金额的费用全部！-->
  <input type="hidden" id="getinternet0063" value='<fmt:message key="phone.getinternet0063" />'/><!-- 代缴费用\-->
  <input type="hidden" id="getinternet0064" value='<fmt:message key="phone.getinternet0064" />'/><!-- 代缴合同号不存在，请重新选择或填写！-->
  <input type="hidden" id="getinternet0065" value='<fmt:message key="phone.getinternet0065" />'/><!-- 只有公费用户可以选择一级部门！-->
  <input type="hidden" id="getinternet0066" value='<fmt:message key="phone.getinternet0066" />'/><!-- 输入超出限制！-->
  <input type="hidden" id="getinternet0067" value='<fmt:message key="phone.getinternet0067" />'/><!-- 只有新生成或输入的合同号才能进行话费预存，选择合同号不能预存话费！-->
  <input type="hidden" id="getinternet0068" value='<fmt:message key="phone.getinternet0068" />'/><!-- 公费用户不能预存话费！-->
  <input type="hidden" id="getinternet0069" value='<fmt:message key="phone.getinternet0069" />'/><!-- 页面加载中，请稍等…………-->  
  <input type="hidden" id="getinternet0120" value='<fmt:message key="phone.getinternet0120" />'/><!-- 确认密码-->
  <input type="hidden" id="getinternet0121" value='<fmt:message key="phone.getinternet0121" />'/><!-- 请配置默认打印项！-->
  <input type="hidden" id="getinternet0122" value='<fmt:message key="phone.getinternet0122" />'/><!-- 工单票据打印选择-->
  <input type="hidden" id="getinternet0123" value='<fmt:message key="phone.getinternet0123" />'/><!-- 选择打印票据类型：-->
  <input type="hidden" id="getinternet0124" value='<fmt:message key="phone.getinternet0124" />'/><!-- 打印派工单-->
  <input type="hidden" id="getinternet0125" value='<fmt:message key="phone.getinternet0125" />'/><!-- 打印收费票据-->
  <input type="hidden" id="getinternet0126" value='<fmt:message key="phone.getinternet0126" />'/><!-- 对不起，该付费方式没有对应的票据，请先配置票据！-->
  <input type="hidden" id="getinternet0127" value='<fmt:message key="phone.getinternet0127" />'/><!-- 业务办理成功！-->
  <input type="hidden" id="getinternetclose" value='<fmt:message key="global.close" />'/><!-- 关闭-->
  <input type="hidden" id="getinternet0128" value='<fmt:message key="phone.getinternet0128" />'/><!-- 派工单-->
  <input type="hidden" id="getinternet0129" value='<fmt:message key="phone.getinternet0129" />'/><!-- 收费票据-->
  <input type="hidden" id="getinternet0130" value='<fmt:message key="phone.getinternet0130" />'/><!-- 直接打印-->
  <input type="hidden" id="getinternet0131" value='<fmt:message key="phone.getinternet0131" />'/><!-- 预览打印-->
  <input type="hidden" id="getinternet0132" value='<fmt:message key="phone.getinternet0132" />'/><!-- 请选择一级部门-->
  <input type="hidden" id="getinternet0133" value='<fmt:message key="phone.getinternet0133" />'/><!-- 选择二级部门-->
  <input type="hidden" id="getinternet0134" value='<fmt:message key="phone.getinternet0134" />'/><!-- 请选择二级部门-->
  <input type="hidden" id="getinternet0135" value='<fmt:message key="phone.getinternet0135" />'/><!-- 选择三级部门-->
  <input type="hidden" id="getinternet0136" value='<fmt:message key="phone.getinternet0136" />'/><!-- 请选择三级部门-->
  <input type="hidden" id="getinternet0137" value='<fmt:message key="phone.getinternet0137" />'/><!-- 选择四级部门-->
  <input type="hidden" id="getinternet0138" value='<fmt:message key="phone.getinternet0138" />'/><!-- 请选择要删除的杂费项信息-->
  <input type="hidden" id="getinternet0139" value='<fmt:message key="phone.getinternet0139" />'/><!-- 删除杂费失败-->
  <input type="hidden" id="getinternetstarttime" value='<fmt:message key="phoneyewu.starttime" />'/><!-- 起始时间-->
  <input type="hidden" id="getinternetermination" value='<fmt:message key="phoneyewu.termination" />'/><!-- 终止时间-->
  <input type="hidden" id="getinternet0140" value='<fmt:message key="phone.getinternet0140" />'/><!-- 请查询一个电话号码！-->  
  <input type="hidden" id="getinternet0141" value='<fmt:message key="phone.getinternet0141" />'/><!-- 请输入要查询的用户-->
  <input type="hidden" id="getinternet0142" value='<fmt:message key="phone.getinternet0142" />'/><!-- 没有符合条件的用户，请检查输入-->    
  <input type="hidden" id="getinternet0143" value='<fmt:message key="phone.getinternet0143" />'/><!-- 出帐月欠费--> 
  <input type="hidden" id="getinternet0144" value='<fmt:message key="phone.getinternet0144" />'/><!-- 精确查询没有找到-->     
  <input type="hidden" id="getinternet0145" value='<fmt:message key="phone.getinternet0145" />'/><!-- 为-->     
  <input type="hidden" id="getinternet0146" value='<fmt:message key="phone.getinternet0146" />'/><!-- 的用户-->    
  <input type="hidden" id="getinternet0147" value='<fmt:message key="phone.getinternet0147" />'/><!-- 出帐月欠费--> 
  <input type="hidden" id="getinternet0148" value='<fmt:message key="phone.getinternet0148" />'/><!-- 出帐月余额--> 
  <input type="hidden" id="getinternet0149" value='<fmt:message key="phone.getinternet0149" />'/><!-- 出帐月余额--> 
  <input type="hidden" id="getinternet0150" value='<fmt:message key="phone.getinternet0150" />'/><!-- 实时欠费--> 
  <input type="hidden" id="getinternet0151" value='<fmt:message key="phone.getinternet0151" />'/><!-- 实时余额--> 
  <input type="hidden" id="getinternet0152" value='<fmt:message key="phone.getinternet0152" />'/><!-- (该用户固定费无信息！)-->
  <input type="hidden" id="getinternet0153" value='<fmt:message key="phone.getinternet0153" />'/><!-- 费用名称-->
  <input type="hidden" id="getinternet0154" value='<fmt:message key="phone.getinternet0154" />'/><!-- 费用-->
  <input type="hidden" id="getinternet0155" value='<fmt:message key="phone.getinternet0155" />'/><!-- 停机费用-->
  <input type="hidden" id="getinternet0156" value='<fmt:message key="phone.getinternet0156" />'/><!-- 费用起始时间-->
  <input type="hidden" id="getinternet0157" value='<fmt:message key="phone.getinternet0157" />'/><!-- 费用终止时间-->
  <input type="hidden" id="getinternet0158" value='<fmt:message key="phone.getinternet0158" />'/><!-- (该用户包月套餐无信息！)-->
  <input type="hidden" id="getinternet0159" value='<fmt:message key="phone.getinternet0087" />'/><!-- 套餐类型-->
  <input type="hidden" id="getinternet0160" value='<fmt:message key="phone.getinternet0159" />'/><!-- (该业务无业务费！)-->
  <input type="hidden" id="getinternet0161" value='<fmt:message key="phone.getinternet0160" />'/><!-- 请输入备注信息-->
  <input type="hidden" id="getinternet0162" value='<fmt:message key="phone.getinternet0161" />'/><!-- 元-->
  <input type="hidden" id="getinternet0222" value='<fmt:message key="phone.getinternet0222" />'/><!-- 月数-->
  <input type="hidden" id="getinternet0362" value='<fmt:message key="phone.getinternet0362" />'/><!-- 话费及状态-->
  <input type="hidden" id="getinternet0363" value='<fmt:message key="phone.getinternet0363" />'/><!-- 固定电话-->  
  
  <input type="hidden" id="getinternet0103" value='<fmt:message key="phone.getinternet0103" />'/><!-- 电话-->
  <input type="hidden" id="getinternet0104" value='<fmt:message key="phone.getinternet0104" />'/><!-- 姓名-->
  <input type="hidden" id="getinternet0341" value='<fmt:message key="phone.getinternet0341" />'/><!-- 地址-->
  <input type="hidden" id="getinternet0342" value='<fmt:message key="phone.getinternet0342" />'/><!-- 操作-->
  <input type="hidden" id="getinternet0112" value='<fmt:message key="phone.getinternet0112" />'/><!-- 用户姓名-->
  <input type="hidden" id="getinternet0100" value='<fmt:message key="phone.getinternet0100" />'/><!-- 合同号-->
  <input type="hidden" id="getinternet0341" value='<fmt:message key="phone.getinternet0341" />'/><!-- 地址-->
  <input type="hidden" id="getinternet0343" value='<fmt:message key="phone.getinternet0343" />'/><!-- 选择-->
  <input type="hidden" id="getinternet0344" value='<fmt:message key="phone.getinternet0344" />'/><!-- 套餐固定费获取失败！-->
  
  <input type="hidden" id="getinternet0345" value='<fmt:message key="phone.getinternet0345" />'/><!-- 身份证-->
  <input type="hidden" id="getinternet0346" value='<fmt:message key="phone.getinternet0346" />'/><!-- 教职工-->
  <input type="hidden" id="getinternet0347" value='<fmt:message key="phone.getinternet0347" />'/><!-- 本科生-->
  <input type="hidden" id="getinternet0348" value='<fmt:message key="phone.getinternet0348" />'/><!-- 研究生-->
  <input type="hidden" id="getinternet0349" value='<fmt:message key="phone.getinternet0349" />'/><!-- 离退休-->
  <input type="hidden" id="getinternet0350" value='<fmt:message key="phone.getinternet0350" />'/><!-- 护照-->
  <input type="hidden" id="getinternet0351" value='<fmt:message key="phone.getinternet0351" />'/><!-- 军官证-->
  <input type="hidden" id="getinternet0352" value='<fmt:message key="phone.getinternet0352" />'/><!-- 其它-->
  <input type="hidden" id="getinternet0353" value='<fmt:message key="phone.getinternet0353" />'/><!-- 电话费-->
  <input type="hidden" id="getinternet0354" value='<fmt:message key="phone.getinternet0354" />'/><!-- 是-->
  <input type="hidden" id="getinternet0355" value='<fmt:message key="phone.getinternet0355" />'/><!-- 否-->
  <input type="hidden" id="getinternet0356" value='<fmt:message key="phone.getinternet0356" />'/><!-- 单位合同号-->
  <input type="hidden" id="getinternet0357" value='<fmt:message key="phone.getinternet0357" />'/><!-- 单位名称-->
  
  <input type="hidden" id="getinternet0358" value='<fmt:message key="phone.getinternet0358" />'/><!-- 工号-->
  <input type="hidden" id="getinternet0359" value='<fmt:message key="phone.getinternet0359" />'/><!-- 时间-->
  <input type="hidden" id="memo" value='<fmt:message key="phoneyewu.memo" />'/><!-- 备注-->
  <input type="hidden" id="getinternet0361" value='<fmt:message key="phone.getinternet0361" />'/><!-- 无列名-->
  <input type="hidden" id="getinternet0360" value='<fmt:message key="phone.getinternet0360" />'/><!-- 该费用没有金额！-->
  <input type="hidden" id="getinternet0365" value='<fmt:message key="phone.getinternet0365" />'/><!-- 请选择-->
  <input type="hidden" id="getinternet0366" value='<fmt:message key="phone.getinternet0366" />'/><!-- 没有信息！！！-->
  
  <input type="hidden" id="getinternet0367" value='<fmt:message key="phone.getinternet0367" />'/><!--请选择部门！-->
  <input type="hidden" id="getinternet0368" value='<fmt:message key="phone.getinternet0368" />'/><!--请选择一级部门-->
  <input type="hidden" id="getinternet0369" value='<fmt:message key="phone.getinternet0369" />'/><!--选择二级部门-->
  <input type="hidden" id="getinternet0370" value='<fmt:message key="phone.getinternet0370" />'/><!--请选择二级部门-->
  <input type="hidden" id="getinternet0371" value='<fmt:message key="phone.getinternet0371" />'/><!--选择三级部门-->
  <input type="hidden" id="getinternet0372" value='<fmt:message key="phone.getinternet0372" />'/><!--请选择三级部门-->   
  <input type="hidden" id="getinternet0373" value='<fmt:message key="phone.getinternet0373" />'/><!--选择四级部门-->
  
  <input type="hidden" id="getinternet0374" value='<fmt:message key="phone.getinternet0374" />'/><!--添加地址-->
  <input type="hidden" id="getinternet0375" value='<fmt:message key="phone.getinternet0375" />'/><!--小区号-->
  <input type="hidden" id="getinternet0376" value='<fmt:message key="phone.getinternet0376" />'/><!--楼栋号-->
  <input type="hidden" id="getinternet0377" value='<fmt:message key="phone.getinternet0377" />'/><!--单元号-->
  <input type="hidden" id="getinternet0378" value='<fmt:message key="phone.getinternet0378" />'/><!--门牌号-->
  <input type="hidden" id="getinternetSave" value='<fmt:message key="Revenue.Save" />'/><!--确定-->
  <input type="hidden" id="getinternet0084" value='<fmt:message key="phone.getinternet0084" />'/><!-- 取消 -->
  <input type="hidden" id="getinternet0379" value='<fmt:message key="phone.getinternet0379" />'/><!-- 添加新地址 -->
  <input type="hidden" id="getinternet0380" value='<fmt:message key="phone.getinternet0380" />'/><!-- 请继续选择下一级地址,操作提示 -->
  <input type="hidden" id="getinternet0381" value='<fmt:message key="phone.getinternet0381" />'/><!--区域 -->
  <input type="hidden" id="getinternet0382" value='<fmt:message key="phone.getinternet0382" />'/><!--参数 -->
  <input type="hidden" id="getinternet0383" value='<fmt:message key="phone.getinternet0383" />'/><!--自费 -->
  <input type="hidden" id="getinternet0384" value='<fmt:message key="phone.getinternet0384" />'/><!--公费 -->
  
  <input type="hidden" id="getinternet0385" value='<fmt:message key="phone.getinternet0385" />'/><!--电话装机 -->
  <input type="hidden" id="getinternet0074" value='<fmt:message key="phone.getinternet0074" />'/><!--用户类别 -->
  <input type="hidden" id="getinternet0387" value='<fmt:message key="phone.getinternet0387" />'/><!--必选一项 -->
  <input type="hidden" id="getinternet0388" value='<fmt:message key="phone.getinternet0388" />'/><!--一次性费用添加日志:(费用类型： -->
  <input type="hidden" id="getinternet0389" value='<fmt:message key="phone.getinternet0389" />'/><!--添加人员 -->
  <input type="hidden" id="getinternet0390" value='<fmt:message key="phone.getinternet0390" />'/><!--业务类型：电话装机 --> 
  <input type="hidden" id="getinternet0391" value='<fmt:message key="phone.getinternet0391" />'/><!--一次性费用删除日志:(费用类型： -->
  <input type="hidden" id="getinternet0392" value='<fmt:message key="phone.getinternet0392" />'/><!--删除人员 -->
  <input type="hidden" id="getinternet0393" value='<fmt:message key="phone.getinternet0393" />'/><!--月租 -->
  <input type="hidden" id="getinternet0394" value='<fmt:message key="phone.getinternet0394" />'/><!--请选择地址 -->
  <input type="hidden" id="getinternet0445" value='<fmt:message key="phone.getinternet0445" />'/><!--请选择费用名称！ -->
  <input type="hidden" id="getinternet0446" value='<fmt:message key="phone.getinternet0446" />'/><!--请选择要删除套餐！ -->
  <input type="hidden" id="getinternet0447" value='<fmt:message key="phone.getinternet0447" />'/><!--请生成,输入或选择一个合同号 -->
  <input type="hidden" id="getinternet0447" value='<fmt:message key="phone.getinternet0471" />'/><!--账单电话-->
  
  <!-- 面板弹出框 -->
  <div class="neirong" id="hthChooseForm"	style="width:620px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.dwHTHquery" /><!-- 单位合同号查询 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="closeGB()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;height:260px;overflow-y:scroll;">
				<div id="page">
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"
						id="queryHTHdw" style="width: 590px;">												
					</table>					
				</div>
			</div>
			<div class="midd_butt" style="width:608px;height:50px;">  
				<button id="hthChooseFormSave" onClick="getinputHTH()" class="tsdbutton" 
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button id="hthChooseFormReset" onClick="closeGB()" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>				
		</div>
		
		<div class="neirong" id="inputhth_mb"	style="width:345px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.getinternet0099" /><!-- 手动输入合同号 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="closeGB()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;height:50px;">
					<div id="inputtext">
					<table border="0" cellpadding="0" bordercolor="" id="inpuththtable" style="width: 337px;"  cellspacing="3">
						<tr>
							<td style="width:50px;"><fmt:message key="phone.getinternet0100" /><!-- 合同号 --></td>
							<td><input type="text" id="ztag" style="width:30px;"/></td>
							<td><input type="text" id="bmhthvalue" style="width:80px" disabled="disabled"/></td>
							<td><input type="text" id="inpuththvalue" style="width:130px" maxlength="15"  onpropertychange="TextUtil.NotMax(this)"/></td>
						</tr>
					</table>
					</div>
			</div>
			<div class="midd_butt" style="width:337px;height:40px;">  
				<button id="hthChooseFormSave" onClick="saveinputHTH()" class="tsdbutton" 
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button id="hthChooseFormReset" onClick="closeGB()" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>
		</div>

		<div class="neirong" id="selecthth"	style="width:600px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.getinternet0101" /><!-- 选择合同号 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="closeGB()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;height:260px;;">
			<div id="broadband_frame">
			   <div id="inputtext">
				<table id="xzhthselect" cellspacing="4">
					<tr>
						<td><fmt:message key="phone.getinternet0102" /><!-- 查询类型 --></td>
						<td>
							<select id="selecththvalue">								
								<option value="2" selected=true><fmt:message key="phone.getinternet0100" /><!-- 合同号 --></option>
								<%-- <option value="1"><fmt:message key="phone.getinternet0103" /><!-- 电话 --></option>
								<option value="3"><fmt:message key="phone.getinternet0112" /><!-- 名称 --></option> --%>
							</select>
						</td>
						<td>
							<input type="text" id="selecththcontent" name="selecththcontent" style="width:150px;"/>
						</td>
						<td>
							<button class="tsdbutton" id="submitButton" style="line-height:20px;"
									onclick="queryhthkey()">
									<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
								</button>
						</td>
						<td>
							<button id="hthselect" class="tsdbutton" onClick="selecththkh('1');" 
								style="margin-left: 20px;line-height:20px;">
								<fmt:message key="phone.getinternet0465" /><!-- 刷新 -->
							</button>							
						</td>
						</tr>
				</table>
				</div>
				</div>				
				<div id="input-Unit">
					<!-- <hr style="border: 1px dotted #CCCCCC;" /> -->
					<div class="title">
					</div>
				<!-- 	
				<table border="1" cellpadding="0" bordercolor="#9AC0CD" style="width: 590px;">
					<thead>
						<tr>
							<td width="230px;"><h4>合同号</h4></td>
							<td width="380px;"><h4>电话</h4></td>
							<td width="380px;"><h4>名称</h4></td>
						</tr>
					</thead>														
				</table> -->
				<table id="ht" style="background-color:#A9C8D9;border:#A9C8D9 solid 0px;">
					<tr><th width="180"><center><h4><fmt:message key="phone.getinternet0100" /><!-- 合同号 --></h4></center></th><th width="120"><center><h4><fmt:message key="phone.getinternet0471" /><!-- 账单电话 --></h4></center></th><th width="300"><center><h4>电话类型<!-- 名称 --></h4></center></th></tr>
				</table>
				<table id="zj" style="background-color:#A9C8D9;border:#A9C8D9 solid 0px;">
					<tr><th width="130"><center><h4><fmt:message key="phone.getinternet0100" /><!-- 合同号 --></h4></center></th>
					    <th width="130"><center><h4><fmt:message key="phone.getinternet0471" /><!-- 账单电话 --></h4></center></th>
					    <th width="160"><center><h4>用户名称<!-- 名称 --></h4></center></th>
					    <th width="150"><center><h4>部门<!-- 名称 --></h4></center></th>
					    </tr>
				</table>					
				<div id="page" style="overflow-y:scroll;height:150px;">					
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"
						id="selecththkey" style="width: 570px;">												
					</table>					
				</div>
				</div>
			</div>				
			<div class="midd_butt" style="width:587px;height:38px;">  
				<%-- <button id="hthChooseFormSave" onClick="getsavexzhth('djsave');" class="tsdbutton" 
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button> --%>
				<button id="hthChooseFormReset" onClick="javascript:setTimeout($.unblockUI,15);$('#selecththvalue').val('');" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>
		</div>
		
		<div class="neirong" id="querysBm"	style="width:450px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<span id="querysBmtitle"></span>
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="closeGB()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;height:260px;;">
			<div id="broadband_frame">
			   <div id="inputtext">
				<table id="xzhthselect" cellspacing="4">
					<tr>
						<td><fmt:message key="phone.getinternet0102" /><!-- 查询类型 --></td>
						<td>
							<select id="querykeybm">
								<option value="1"><fmt:message key="phone.getinternet0178" /><!-- 条件查询 --></option>
								<option value="2"><fmt:message key="phone.getinternet0104" /><!-- 部门名称 --></option>								
							</select>
						</td>
						<td>
							<input type="text" id="selectsbmkey" name="selecththcontent" style="width:150px;"/>
						</td>
						<td>
							<button class="tsdbutton" id="submitButton" style="line-height:20px;"
									onclick="querykeysBm()">
									<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
								</button>
						</td>
						</tr>
				</table>
				</div>
				</div>
					<table id="bytctabss" style="width: 433px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
						<tr><td><center><fmt:message key="phone.getinternet0104" /><!-- 部门名称 --></center></td></tr>
					</table>
				<div id="page" style="overflow-y:scroll;height:200px;">
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"
						id="querybmcontext" style="width: 423px;">
					</table>
				</div>
			</div>
			<div class="midd_butt" style="width:440px;height:38px;">
				<button id="hthChooseFormSave" onClick="savesBm();setYhdangBm();" class="tsdbutton" 
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button id="hthChooseFormReset" onClick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>
		</div>				
		
		<div class="neirong" id="querysTfDhgn"	style="width:550px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<span id="querysBmtitle"></span>
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="closeGB()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;height:80px;;">
			<div id="broadband_frame">
				<table id="" cellspacing="4">
					<tr>
						<td>呼出权限</td>
						<td>
							<select id="newDhgn" style="width:150px;"></select><font color='red'>*</font>
						</td>
					</tr>					
					<tr style="display:none;">						
						<td>特服功能</td>
						<td colspan="3">
							<div id="tfgn_div"><select id="Tfgn_yhdang" name="Tfgn_yhdang" style="width:200px;"></select></div>
						</td>
					</tr>
				</table>
			</div>
			<div class="midd_butt" style="width:540px;height:33px;">
				<button id="hthChooseFormSave" onClick="getDhgcparam();closeGB();" class="tsdbutton" 
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button id="hthChooseFormReset" onClick="javascript:setTimeout($.unblockUI,15);$('selectsbmkey').val('');" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>
		</div>

		<div class="neirong" id="editbusinessfee"	style="width:685px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.getinternet0105" /><!-- 业务受理费 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="removecheckbusi()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;height:100px;">
				<div id="inputtext">
					<table border="0" cellpadding="0" bordercolor="" id="inpuththtable" style="width: 670px;"  cellspacing="3">
						<tr>
							<td style="width:50px;"><fmt:message key="phone.getinternet0106" /><!-- 业务费用 --></td>
							<td><input type="text" id="feenamevalue" style="width:180px" disabled="disabled"/></td>
							<td><fmt:message key="phone.getinternet0107" /><!-- 当前费用 --></td>
							<td><input type="text" id="feenumbervalue" style="width:100px" disabled="disabled"/></td>
							<%-- <td><fmt:message key="phone.getinternet0108" /><!-- 实缴费用 --></td>
							<td><input type="text" id="sjfeevalue" style="width:100px" onKeyPress="numValid(this)"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return false"/></td> --%>
						</tr>
						<tr>
							<td>
								<fmt:message key="phone.getinternet0109" /><!-- 备注 -->
							</td>
							<td colspan="3">
								<input type="text" id="businessbz" style="width:320px;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="midd_butt" style="width:671px;height:40px;">  
				<button id="hthChooseFormSave" onClick="savebusinessfee()" class="tsdbutton" 
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save" />
				</button>
				<button id="hthChooseFormReset" onClick="removecheckbusi()" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>
		</div>		
		
		<div class="neirong" id="dhthChooseForm" style="width:625px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="phone.getinternet0110" /><!-- 设置代缴合同号 -->
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="$('#dhthChooseFormReset').click()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>			 
			<div class="midd" style="background-color:#FFFFFF;text-align:left;">
				<table id="Paymenththselect" cellspacing="4" style="width:618px;">
					<tr>
						<td><fmt:message key="phone.getinternet0102" /><!-- 查询类型 --></td>
						<td>
							<select id="selectPaymenththvalue">
								<option value="1"><fmt:message key="phone.getinternet0103" /><!-- 电话 --></option>
								<option value="2"><fmt:message key="phone.getinternet0100" /><!-- 合同号 --></option>
								<option value="3"><fmt:message key="phone.getinternet0112" /><!-- 名称 --></option>
							</select>
						</td>
						<td>
							<input type="text" id="selectPaymenththcontent" name="selectPaymenththcontent" style="width:150px;"/>
						</td>
						<td>
							<button class="tsdbutton" id="submitButtonPayment" 
									onclick="queryPaymenththkey()" style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
									<fmt:message key="phone.getinternet0466" /><!-- 查找 -->
								</button>
						</td>
						<td>
							<button id="hthselect" class="tsdbutton" onClick="setXDJ('0');" 
								style="width:70px;line-height:25px; margin-top: 1px; padding: 0px;">
								<fmt:message key="phone.getinternet0465" /><!-- 刷新 -->
							</button>							
						</td>
						</tr>
				</table>								
					<table id="queryDJhthtable" style="width:618px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
						<tr>
							<th style="width:100px;">
								<center>
									<h4>
										<fmt:message key="phone.getinternet0100" /><!-- 合同号 -->
									</h4>
								</center>
							</th>
							<th style="width:100px;">
								<center>
									<h4>
										<fmt:message key="phone.getinternet0111" /><!-- 用户电话 -->
									</h4>
								</center>
							</th>
							<th style="width:170px;">
								<center>
									<h4>
										<fmt:message key="phone.getinternet0112" /><!-- 用户姓名 -->
									</h4>
								</center>
							</th>
							<th style="width:210px;">
								<center>
									<h4>
										<fmt:message key="phone.getinternet0113" /><!-- 用户地址-->
									</h4>
								</center>
							</th>
						</tr>
					</table>
				<div style="height:90px;overflow-y:scroll;">
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"id="dqueryHTHdw" style="width:605px;">
						
					</table>
				</div>				
				<table id="dzhthcontent" style="width:618px;height:15px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
				<tr>					
					<th style="width:170px;" height="15">
						<center>
							<h4>
								<fmt:message key="phone.getinternet0114" /><!-- 代缴电话-->
							</h4>
						</center>
					</th>
					<th style="width:200px;">
						<center>
							<h4>
								<fmt:message key="phone.getinternet0112" /><!-- 用户姓名 -->
							</h4>
						</center>
					</th>
					<th style="width:250px;">
						<center>
							<h4>
								<fmt:message key="phone.getinternet0113" /><!-- 用户地址-->
							</h4>
						</center>
					</th>			
				</tr>
			</table>	
			<div style="height:70px;overflow-y:scroll;">
					<table border="1" cellpadding="0" bordercolor="#9AC0CD"id="querydjhthdh" style="width:608px;">
						
					</table>
				</div>	
			<table id="dzhthcontent" style="width:618px;height:15px;" border="1" cellpadding="0" bordercolor="#9AC0CD">
				<tr>
					<th style="width:20px;"><input type="checkbox" id="Paymenttable_checkalls" onClick="Bytc_CheckALL('dj')" style="width:15px;" /></th>
					<th style="width:140px;" height="15">
						<center>
							<h4>
								<fmt:message key="phone.getinternet0115" /><!-- 代缴项目-->
							</h4>
						</center>
					</th>
					<th style="width:120px;">
						<center>
							<h4>
								<fmt:message key="phone.getinternet0116" /><!-- 代缴金额-->
							</h4>
						</center>
					</th>
					<th style="width:120px;">
						<center>
							<h4>
								<fmt:message key="phone.getinternet0117" /><!-- 代缴比例-->
							</h4>
						</center>
					</th>
					<th style="width:135px;">
						<center>
							<h4>
								<fmt:message key="phone.getinternet0118" /><!-- 代缴合同号-->
							</h4>
						</center>
					</th>
					<th style="width:125px;">
						<center>
							<h4>
								<fmt:message key="phone.getinternet0114" /><!-- 代缴电话-->
							</h4>
						</center>
					</th>				
				</tr>
			</table>
			<div style="width:618px; height: 75px; overflow-y: scroll; overflow-x: hidden; border-top: 1px solid gray; border-left: 1px solid gray;">
					<table id=Paymenttable style="width:620px;" border="1" cellpadding="0" bordercolor="#9AC0CD">			
				</table>					
			</div>			
			<table id="Paymentfeetable" cellspacing="0" cellpadding="0" width="618px;">
					<tr>
							<td class="wenzi">
								<fmt:message key="phone.getinternet0119" /><!-- 代缴名称-->
							</td>
							<td style="width:120px;">							
								<select name="phonePaymentfeename" id="phonePaymentfeename" style="width: 120px;"
									onchange="getPaymentall()"></select>								
							</td>
							<td class="wenzi">
								<fmt:message key="phone.getinternet0116" /><!-- 代缴金额-->
							</td>
							<td>
								<input type="text" id="Paymentfee" name="Paymentfee"
									style="width: 120px;" onKeyPress="numValid(this)"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return   false"/>	
							</td>
							<td class="wenzi">
								<fmt:message key="phone.getinternet0117" /><!-- 代缴比例-->
							</td>							
							<td>
								<input type="text" id="Paymentrate" name="Paymentrate"
									style="width: 110px;" style="width: 120px;" onkeypress="numValid(this)"
								onpaste="return !clipboardData.getData('text').match(/\D/)"
								ondragenter="return false"/>%
							</td>							
						</tr>
						<tr>					
							<td class="wenzi">
								<fmt:message key="phone.getinternet0118" /><!-- 代缴合同号-->
							</td>
							<td>
								<input type="text" id="Paymenthth" name="Paymenthth" style="width:120px"/>
							</td>
							<td class="wenzi">
								<fmt:message key="phone.getinternet0114" /><!-- 代缴电话-->
							</td>
							<td>
								<input type="text" id="Paymentdh" name="Paymentdh" style="width:120px"/>
							</td>
							<td colspan="6">&nbsp;&nbsp;&nbsp;
								<button class="tsdbutton" id="bytcadd" 
									onclick="addPaymentnew()"
									style="width:80px;line-height:20px; margin-top: 3px; padding: 0px;">
									<fmt:message key="global.save" />
									<!-- 保存 -->
								</button>&nbsp;&nbsp;
								<button class="tsdbutton" id="bytcdels" 
									onclick="Payment_Dels()"
									style="width:80px;line-height:20px; margin-top: 3px; padding: 0px;">
									<fmt:message key="global.delete" />
									<!-- 删除 -->
								</button>
							</td>
						</tr>						
				</table>
				<input type="hidden" id="currentCheckedHthBox" value="shhth" /><!-- 记录当前选中的输入框 -->
				<input type="hidden" id="currentHthSaved" value="N" /><!-- 记录是否保存当前面板 -->
				<input type="hidden" id="currentHthFirstOpen" value="Y" /><!-- 第一次打开此面板 -->
				<!-- 
				<table id="daijiaoinput">					
				</table> -->					
			</div>				
			<div class="midd_butt" style="width:623px;height:40px;">  
				<!-- <button id="dhthChooseFormSave" class="tsdbutton" 
					style="margin-left: 20px;" onclick="getdaijiaotishi()">
					<fmt:message key="Revenue.Save" />
				</button> -->
				<button id="dhthChooseFormReset"  class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>				
		</div>
		
		<div class="neirong" id="pkgPriceDiscount_blockfrom"	style="width:450px;display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<span id="querysBmtitle"></span>
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="javascript:;" onClick="closeGB()"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;height:200px;;">
			<div id="broadband_frame">
				套餐类型：<span id="pkgtypevalue" style="color:red;"></span>
				<table id="PriceDiscountValue" cellspacing="0"  border="1"  bordercolor="#9AC0CD"></table>
			  </div>				
			</div>
			<div class="midd_butt" style="width:440px;height:38px;">
				<button id="hthChooseFormReset" onClick="javascript:setTimeout($.unblockUI,15);" class="tsdbutton"  style="margin-left: 20px;">
					<fmt:message key="global.close" />
					<!-- 关闭 -->
				</button>
			</div>
		</div>
  </body>
</html>
