<%----------------------------------------
	name: FinalUpdate.jsp
	author: youhongyu
	version: 1.0, 2010-12-28
	description: 常量表内存数据更新
	modify: 
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><!-- 定义收费科目 --></title>    
    
    	
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
			
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
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />	
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>		

<script type="text/javascript">
/**
* 页面初始化
* @param 
* @return 
*/
jQuery(document).ready(function () {
			//页面头部 用于显示当前所在位置
			$("#navBar").append(genNavv());						
			getFinalItems();//显示常量表列表信息			
});

/**
 * 显示常量表列表信息
 * @param 无参数
 * @return 无返回值
 */
function getFinalItems(){		
		var arr=[["FINAL.Dhgn","FINAL.Dhlx","FINAL.HwjbDef","FINAL.MokuaiJu","FINAL.area_ywsl","FINAL.asys_area","FINAL.yhlb","FINAL.yhxz",
				"FINAL.hwjb","FINAL.yjdz","FINAL.ZnjBz","FINAL.CallPayType","FINAL.CallPay_Shedule_Base","FINAL.Hwjb_Shedule_Base",
				"FINAL.Free_Grade","FINAL.Charge_Type","FINAL.attachprice","FINAL.attachprice2","FINAL.qhyt_bytc_type","FINAL.Staff",
				"FINAL.Staff2","FINAL.qhyt_hth","FINAL.custtype","FINAL.creditgrade","FINAL.tradetype","FINAL.comptype","FINAL.department"],
				//["电话功能", "电话类型","话务级别定义","模块局定义","业务区域定义","话费营收点定义","用户类别","用户性质",
				//"话务级别","根据用户区域查询一级地址","滞纳金标志","付费策略","催缴测罗","调级策略",
				//"补贴类别","计费类别","费用名称","费用名称的子类型","套餐类型","得到联系人及联系人单位",
				//"得到联系人及联系人","代缴合同号","客户类型","信誉等级","行业类型","单位类型","部门定义"]];
				["<fmt:message key='FinalUpdate.phonefunction' />", "<fmt:message key='FinalUpdate.phonestyle' />","<fmt:message key='FinalUpdate.definestyle' />","<fmt:message key='FinalUpdate.definemodel' />","<fmt:message key='FinalUpdate.definebusinessarea' />","<fmt:message key='FinalUpdate.definefeecollect' />","<fmt:message key='FinalUpdate.userstyle' />","<fmt:message key='FinalUpdate.userproperty' />",
				"<fmt:message key='FinalUpdate.phonebusinessgrade' />","<fmt:message key='FinalUpdate.seekaddress' />","<fmt:message key='FinalUpdate.overdueremark' />","<fmt:message key='FinalUpdate.urgefunction' />","<fmt:message key='FinalUpdate.urgefunction' />","<fmt:message key='FinalUpdate.controlfunction' />",
				"<fmt:message key='FinalUpdate.subsidystyle' />","<fmt:message key='FinalUpdate.feestyle' />","<fmt:message key='FinalUpdate.feename' />","<fmt:message key='FinalUpdate.feenamesunstyle' />","<fmt:message key='FinalUpdate.mealstyle' />","<fmt:message key='FinalUpdate.linkmanandunit' />",
				"<fmt:message key='FinalUpdate.linkmanand' />","<fmt:message key='FinalUpdate.replacecompanynumber' />","<fmt:message key='FinalUpdate.clientstyle' />","<fmt:message key='FinalUpdate.creditgrade' />","<fmt:message key='FinalUpdate.professionstyle' />","<fmt:message key='FinalUpdate.companystyle' />","<fmt:message key='FinalUpdate.departmentdefine' />"]];
		var thevalue="";
		for(var i=0;i<arr[0].length;i++){
			var thebr = "";
			thevalue += "<span class='spanstyle'><input type='checkbox' name='updateItem' value='"+arr[0][i]+"' style='width:20px;height:20px;'>";
			thevalue +="<label style='text-align: left;margin-left:5px;'>"+arr[1][i]+"</label></span>"+thebr;
		}
		var disbutton = "<div style='text-align:center'>"
						+"<button type='button' id='checkIsAll' class='tsdbutton' onclick=isCheckedAll('updateItem','checkIsAll') "
						+"style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'><fmt:message key='FinalUpdate.selectall' /></button><button type='button' id='groupidclick'"
						+" class='tsdbutton' onclick=checkedOK('updateItem')"
						+" style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'><fmt:message key='FinalUpdate.sure' /></button></div>";
		$('#FinalTab').html(thevalue+'<hr/>'+disbutton);					 
}

/**
 * 获取选择的复选框，并执行数据更新
 * @param name 复选框name值
 * @return 无返回值
 */
function checkedOK(name){
	var $check = $("input[name=updateItem]:checked");
	var finalitems = new Array();
	$($check).each(function(){
			var groupname = $(this).val();		
			finalitems.push(groupname);
	 });	
	 updateone(finalitems);    
}
/**
 * 提交到java平台进行更新
 * @param name 复选框的选择值
 * @return 无返回值
 */
function updateone(identity){
	var urlstr=tsd.buildParams({
					packgname:'service',//java包
					clsname:'AskConstant',//类名
					method:'askConstantTable',//方法名
					identity:identity, //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指
					pattern:'update'// 访问方式 select：查询常量表信息，update：更新常量表信息 
					});
	var ywlxsbm='';
	$.ajax({
		url:'mainServlet.html?'+urlstr,					
		datatype:'xml',
		cache:false,//如果值变化可能性比较大 一定要将缓存设成false
		timeout: 65000,
		async: false ,//同步方式
		success:function(xml){
			//alert("更新成功！");
			alert("<fmt:message key='FinalUpdate.deletesuccess' />");
		}
	});	
}

/**
 * 改变复选框状态
 * @param name  复选框name值
 * @param butid 按钮id值
 * @return 无返回值
 */
function isCheckedAll(name,butid){
	var tagname=document.getElementsByName(name);  
    for(var i=0;i<tagname.length;i++){
    	if(tagname[i].checked == true){
    		for(var j = 0 ;j < tagname.length;j++){
				tagname[j].checked = false;				    			
    		}
    		//$('#'+butid).html('全选');
    		$('#'+butid).html("<fmt:message key='FinalUpdate.selectall' />");
    		break;
    	}else{
    		for(var j = 0 ;j < tagname.length;j++){
				tagname[j].checked = true;				    			
    		}
    		//$('#'+butid).html('全不选');
    		$('#'+butid).html("<fmt:message key='FinalUpdate.selectnone' />");
    		break;
    	}
    }      
}
</script>
</head>

<style type="text/css"> 
	.spanstyle{display:-moz-inline-box; display:inline-block; width:170px;line-height: 20px;margin-top:20px;margin-left:20px;}
	
 	.style1 {
		background-color:#A9C3E8;
		padding: 4px;		
	}
	#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
	cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
	.a{border:1px solid #ccc;width:500px;overflow:left;text-overflow:ellipsis;}
	
</style> 
  <body>   
  <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>

  </form>
  		<!-- 用户操作导航-->
		<div id="navBar1">
			<table width="100%" height="26px">
			<tr>
				<td width="80%" valign="middle">
			  <div id="navBar" style="float:left">
			  <img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
			  <fmt:message key="global.location" />
					:
			  </div>
			  </td>
			  <td width="20%" align="right" valign="top">
			  <div id="d2back"><a href="javascript:void(0);" onclick="parent.history.back(); return false;"><fmt:message key="gjh.houtuei" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
			  </td>
			  </tr>
		  </table>
		</div>
		
		<div id="FinalTab" style="font-size: 14px;">
			
		</div>
	
	
	
		<div id="inputs">		
					<div style="display: none">					
					<input type="hidden" id="addinfo"
						value="<fmt:message key="global.add"/>" />
					<input type="hidden" id="deleteinfo"
						value="<fmt:message key="global.delete"/>" />
					<input type="hidden" id="editinfo"
						value="<fmt:message key="global.edit"/>" />
					<input type="hidden" id="queryinfo"
						value="<fmt:message key="global.query"/>" />

					<input type="hidden" id="operation"
						value="<fmt:message key="global.operation"/>" />
					<input type="hidden" id="operationtips"
						value="<fmt:message key="global.operationtips"/>" />
					<input type="hidden" id="successful"
						value="<fmt:message key="global.successful"/>" />
					<input type="hidden" id="deleteinformation"
						value="<fmt:message key="global.deleteinformation"/>" />						
					
					<input type="hidden" id="worninfo"
						value="<fmt:message key="zhji.zjjxonly"/>" />
					<input type="hidden" id="worntips"
						value="<fmt:message key="powergroup.worntips"/>" />
						
					<input type="hidden" id="deletepower"
						value="<fmt:message key="global.deleteright"/>" />
					<input type="hidden" id="editpower"
						value="<fmt:message key="global.editright"/>" />
					
					<input type="hidden" id="zhjititle"
						value="<fmt:message key="tariff.zhji" />" />
					
					<input type="hidden" id="addright"/>
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="editright"/>
					<input type="hidden" id="editfields"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editBright"/>
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />			
					<!-- 用于写入日志 -->
				   <input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request) %>"/> 
				   <input type="hidden" id="userloginid" value="<%=session.getAttribute("userid") %>"/> 
				   <input type="hidden" id="thislogtime" value="<%=Log.getThisTime() %>" />
				   <!-- 修改时保存原来数据的隐藏域 --> 	
					<input type="hidden" id="logoldstr" />	
					<input type="hidden" id="useridd" value="<%=userid %>"/>		
					<input type="hidden" id="imenuname" value="<%=imenuname %>"/>	
					<!-- 汇总字段的存放 -->
					<input type="hidden" id="HzFieldsform" />	
					<input type="hidden" id="HzFieldsNO" />	
					
					<input type="hidden" id="spanA" />	
					<!-- 查询树信息存放 -->
					<input type="hidden" id='treepid' />	
					<input type="hidden" id='treecid' />	
					<input type="hidden" id='treestr' />	
					<input type="hidden" id='treepic' />
					<!-- 高级查询 模板隐藏域 -->
					<input type="hidden" id="queryright"/>
					<input type="hidden" id="queryMright"/>
					<input type="hidden" id="saveQueryMright"/>
					<!-- grid自动 -->
					<input type="hidden" id='ziduansF' />
					<input type='hidden' id='thecolumn'/>					
				</div>	
	</div>


		<input type="hidden" id="whickOper"/>
		<input type="hidden" id="imenuid" value="<%=imenuid%>" />
		<input type="hidden" id="zid" value="<%=zid%>" />
		<%
			if (!languageType.equals("en")) {
				languageType = "zh";
			}
		%>
		<input type="hidden" id="languageType" value="<%=languageType%>" />
  </body>
</html>
