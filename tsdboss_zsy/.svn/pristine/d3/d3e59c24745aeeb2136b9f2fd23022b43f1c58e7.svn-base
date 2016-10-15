<%----------------------------------------
	name: modifyMod.jsp
	author: youhongyu
	version: 1.0, 2009-10-26
	description: 组合排序
	modify: 
    	2010-9-25  oracle 移植
		2010-11-05 youhongyu 添加注释功能	
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.tsd.query.model.TableQuery" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><fmt:message key="order.title"/></title>

		<!-- jqgrid css -->
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<!-- jquery -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<!-- jqgrid -->
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<!-- company -->
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		

		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>

		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script type="text/javascript" src="script/public/revenue.js" ></script>
		<script type="text/javascript" src="script/public/infotest.js" ></script>
		
		<!-- 日期插件 -->	
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 单表编辑 -->
		<script type="text/javascript" src="script/pubMode/order.js"></script>	
		<script type="text/javascript">
			/**
			* 页面初始化
			* @param 
			* @return 
			*/
			$(document).ready(function(){  
					//$("#orderfield").sortable(); //直接让myList下的元素可以拖动排序
	        		//根据选择的语言解析字段
	        		getI18n();
	        		$("input[name='orderBy'][value='asc']").attr("checked","checked");	        		
        	});	
		</script>
		<style type="text/css">
		<!--
			.biankuang {
				border: thin solid #BCD1EE;
			}		
       		p{
       			height:20px;
       			margin:0px;
       			padding:0px;
       			font-family:verdana,Arial, Helvetica, sans-serif;
       			list-style-type:none;
       			font-size:10px;
       			color:inherit;
       			z-index:inherit;
       		}
     		.buttons{ 
     			padding:4px 8px 4px 8px;  
	     		height:28px; 
	     		margin-top:10px; 
	     		margin-left:5px; 
	     		background: url(style/images/public/buttonbg.jpg) repeat-x; 
	     		border: #CCCCCC 1px solid; cursor: pointer; 
     		}
      	-->
      
      </style>
      
</head>	

<body>
<div id="input-Unit" >
<table width="580" height="300"  border="0">
  <tr >
    <td width="230"  valign="top" height="260">
	<table width="100%"  border="0">
      <tr bgcolor="#EDF8FC" height="30px">
        <td align="center"><!-- 可选字段 --><fmt:message key="order.beingOrder"/></td>
      </tr>
      <tr>
        <td class="biankuang"><div id="queryfield" style="width:215px;height:220px; overflow:scroll; margin-left:10px;" valign='center'>
						<%
							int i =0;
							TableQuery tableQuery =new TableQuery();								
								Collection queryC = (Collection)session.getAttribute("queryC");
								Iterator iii = queryC.iterator();		 
								if(!iii.hasNext()){}
							    else{
								    tableQuery =null;	
								    while(iii.hasNext()){
								    	tableQuery = (TableQuery)iii.next();
								  		
										if(("").equals(tableQuery.getField_Alias())){}
										else{
						%>   
										<div id="Field_Order<%=i %>" style="float: left;">
											<label id = "Field_Alias<%=i %>"  onclick="selAlias(<%=i %>)" style="text-align: left;line-height:18px;height:20px;"><%=tableQuery.getField_Alias()%></label>
											<label id = "Field_Name<%=i %>" style="display:none;"><%=tableQuery.getField_Name()%></label>  
											<img id ="Oimage<%=i %>" src=""  style="display: none;"/>
											<input type="hidden" id="Oby<%=i %>" value=""/>											
									  	</div>
				<%						i++;
									}
						
						  		}
						  	}
				%>
			</div></td>
      </tr>
    </table>
	
	</td>
    <td width="80" valign="top">
	<table width="100%" height="100%" border="0">
      <tr>
        <td  align="center">
        <P style="font-size: 13px;"><input type="radio" id="orderBy" name="orderBy" value="asc" ><fmt:message key="tariff.orderAsc"/></P>
		<P style="font-size: 13px; "><input type="radio" id="orderBy" name="orderBy" value="desc" ><fmt:message key="tariff.orderDesc"/></P>
        </td>
      </tr>
      <tr>
        <td align="center"><button type="button" onclick="movRightAll();" class='buttons'>>><!-- <fmt:message key="order.movRA"/>全部右移 --></button></td>
      </tr>
      <tr>
        <td align="center"><button type="button" onclick="movRight();" class='buttons'>&nbsp;>&nbsp;<!-- <fmt:message key="order.movR"/>单条右移 --></button></td>
      </tr>
      <tr>
        <td align="center"><button type="button" onclick="movLeftAll();" class='buttons'><<<!-- <fmt:message key="order.movLA"/>全部左移 --></button></td>
      </tr>
      <tr>
        <td align="center"><button type="button" onclick="movLeft();" class='buttons'>&nbsp;<&nbsp;<!-- <fmt:message key="order.movL"/>单条左移 --></button></td>
      </tr>
    </table></td>
    <td width="250" valign="top">
	<table width="100%"  border="0" >
      <tr bgcolor="#EDF8FC" height="30px">
        <td align="center"><fmt:message key="order.onOrder"/><!-- 排序字段 --></td>
      </tr>
      <tr>
        <td class="biankuang"><div id="orderfield" style="width:99%;height:220px; overflow:scroll; "></div></td>
      </tr>
    </table>
	
	</td>
  </tr>
  <tr>
    <td colspan="3" align="right">
		<p><button type="button" onclick="queryOrder();" class='buttons'><!-- 确定 -->&nbsp;&nbsp;&nbsp;<fmt:message key="global.ok" />&nbsp;&nbsp;&nbsp;</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<button type="button" onclick="window.close();" class='buttons'><!-- 取消 -->&nbsp;&nbsp;&nbsp;<fmt:message key="global.close"/>&nbsp;&nbsp;&nbsp;</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</p>
	</td>
  </tr>
</table>
</div>
<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>'/>
<input type="hidden" id="FieldNum" name="FieldNum" />
<input type="hidden" id='OrderByInfo' value="<fmt:message key='order.by'/>">
</body>
</html>
