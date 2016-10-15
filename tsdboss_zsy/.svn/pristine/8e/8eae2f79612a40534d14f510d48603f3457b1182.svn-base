<%------------------------------------------ 
    File Name:  
    Function:   通用模块公共国际化标签
    Author:     youhongyu
    Date:       2011-11-08
    Description: 
    Modify: 
-----------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String languageType = (String) session.getAttribute("languageType");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>

		
<!-- 修改 -->
<input type="hidden" id="PLedit" value="<fmt:message key="publicLable.edit"/>" />
<!-- 删除 -->
<input type="hidden" id="PLdelete" value="<fmt:message key="publicLable.delete"/>" />
<!-- 查询条件 -->
<input type="hidden" id="PLqueryCondition" value="<fmt:message key="publicLable.queryCondition"/>" />
<!-- 显示详细 -->
<input type="hidden" id="PLmesAll" value="<fmt:message key="publicLable.mesAll"/>" />
<!-- 打印 -->
<input type="hidden" id="PLprint" value="<fmt:message key="publicLable.print"/>" />
<!-- 费率设置导航 -->
<input type="hidden" id="PLfeeNavigator" value="<fmt:message key="publicLable.feeNavigator"/>" />
<!-- 查询模板保存 -->
<input type="hidden" id="PLSaveMod" value="<fmt:message key="publicLable.SaveMod"/>" />
<!-- 请先用高级查询，在保存。 -->
<input type="hidden" id="PLBeforeSaveMod" value="<fmt:message key="publicLable.BeforeSaveMod"/>" />
<!-- 请输入模板标题！ -->
<input type="hidden" id="PLInputTitleMod" value="<fmt:message key="publicLable.InputTitleMod"/>" />
<!-- 该页面为配置，请您到菜单管理页面进行配置。 -->
<input type="hidden" id="PLSTEisrow" value="<fmt:message key="publicLableSTE.isrow"/>" />



