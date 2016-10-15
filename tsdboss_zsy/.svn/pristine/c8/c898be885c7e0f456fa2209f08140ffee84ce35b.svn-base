<%----------------------------------------
	name: SummaryReleased.jsp 
	author: yhy
	version: 1.0, 2012-11-6
	description: 话费汇总 发布 参数配置
	modify: 
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String theTime=Log.getThisTime(); 
	String userid = (String) session.getAttribute("userid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title><!-- 收费结帐 --><fmt:message key="Revenue.chargeCheckout" /></title>
	
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>				
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 分项卡 -->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css"
			type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"
			type="text/css" media="projection, screen" />
		<!-- 菜单样式 -->
		<link rel="stylesheet" href="style/css/telephone/usermanagement/single_thirteen.css" type="text/css" />
		<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>				
		
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	
		<style type="text/css">
			label{float:right;text-align:left;margin-left:0px;}
			#container td{padding:8px 10px 2px 10px;}
			.datDrop{width:56px;}
			.txtInfo{width:360px;height:290px;overflow-y:auto;}
			.infoDiv{margin-top:32px;width:360px;padding-right:0px;}
			.divCont{width:296px;height:120px;overflow-y:auto;}
			.divCont ul{padding-left:0px;}
			.divCont ul li label{float:left;margin-left:10px;width:250px;}}
			fieldset{width:300px;padding-right:0px;}
			.btns,#kdButtons,#ghButtons{width:100%; float:left; *float:none; height:36px; background:url(style/imgs/buttonsbg.jpg) repeat-x; border-top:#CCCCCC 1px solid;border-bottom:#CCCCCC 1px solid;}
			.txtInput{width:150px;}
			#paramSetDiv fieldset{width:660px;padding-right:0px;style="text-align:left;margin-top:20px"}
		</style>
  </head>
  
  <script language="javascript">
	/**
	 * 页面加载时执行
	 * @param
	 * @return 
	 */
	//页面通用初始化
	$(function(){
		//加载导航栏
		$("#navBar").append(genNavv());
		//生成返回按钮
		gobackInNavbar("navBar");
		getwebmonths();
	});
	 	
	//汇总发布参数配置
	$(function(){	
		
		
		var s_fbyf=getIni("汇总选项","WEB发布月");
		$("#fbyf").val(s_fbyf);
		if (s_fbyf == undefined)
		{
		    $("#div_thr").attr("style","display:none;");      
		}	
		
		//修改查询月数 
		var cxys=getIni("WEBQUERY","QUERYMONTH");
		$("#cxys").val(cxys);
		if (cxys == undefined)
		{
		    $("#div_six").attr("style","display:none;");      
		}	
		
		var optHtml = "";
		for(var i=1;i<=12;i++)
		{
			optHtml += "<option value=\""+i+"\">"+i+"</option>";
		}
		//初始化收费区段月数 欠费催缴月 ,滞纳金月,欠费降级月 
		//$("#sfqdys,#qfcjrq_m,#znjrq_m,#qfjjrq_m").html(optHtml);
		
		optHtml = "";
		for(var i=1;i<=31;i++)
		{
			optHtml += "<option value=\""+i+"\">"+i+"</option>";
		}
	}); 
	
/* 	//汇总 发布初始化
	$(function(){
		//设置用户类别下拉框值
		initYhlb();
		//初始化当前时间
		initSfmonth();
		
		//用于切换合同号 用户性质汇总|发布
		$("#yhlbDiv").attr("disabled","disabled");
		$("#hthDiv").attr("disabled","disabled");
		$(":radio[name=chargeType]").click(function(){
			var chargeType = $(":radio[name=chargeType]:checked").val();			
			//按用户性质汇总发布
			if(chargeType == '1'){
				$("#yhlbDiv").removeAttr("disabled");
				$("#hthDiv").attr("disabled","disabled");
			}
			//按合同号汇总发布
			else if(chargeType == '2'){				
				$("#yhlbDiv").attr("disabled","disabled");
				$("#hthDiv").removeAttr("disabled");
			}
		});
	}); */
	
	/**
	 * 根据节和项取参数值
	 * @param tsection 配置节
	 * @param tident   配置项
	 * @return 配置值
	 */
	function getIni(tsection,tident)
	{
		var res = fetchSingleValue("Revenue.getIni",6,"&TS=" + tsd.encodeURIComponent(tsection) + "&TI=" + tsd.encodeURIComponent(tident));
		return res;
	}
	/**
	 * func  设置月份输入框的修改状态
	 * @param id:月份输入框的id属性值
	 * @return 
	 * @desc  修改 保存 取消按钮的id属性值命令规则为：所在月份输入框的id加上"_"，再加上功能标识
	 */
    function setModifyStatus(id)
	{
        var sval = $("#"+id).val();
		$("#back_"+id).val(sval);
		//$("#"+id).removeAttr("disabled");
		$("#"+id).attr("sel","0");
		$("#"+id+"_edit").attr("disabled","disabled");
		$("#"+id+"_save").removeAttr("disabled");
		$("#"+id+"_del").removeAttr("disabled");
		$("#"+id+"_cancel").removeAttr("disabled");
	}
	/**
	 * func  取消修改状态，并将值还原
	 * @param id:月份输入框的id属性值
	 * @return 
	 * @desc  修改 保存 取消按钮的id属性值命令规则为：所在月份输入框的id加上"_"，再加上功能标识
	 */
	function cancel(id)
	{
	    var sval = $("#back_"+id).val();
		$("#"+id).val(sval);
		$("#back_"+id).val("");
		$("#"+id+"_edit").removeAttr("disabled");
		$("#"+id+"_save").attr("disabled","disabled");
		$("#"+id+"_del").attr("disabled","disabled");
		$("#"+id+"_cancel").attr("disabled","disabled");
		$("#"+id).attr("sel","1");
		//清空合同号
		$("#fbhth").val("");
	}
	/**
	 * func  保存修改结果
	 * @param id:月份输入框的id属性值	 
	 * @param type:操作类型
	 * @return 
	 * @desc  修改 保存 取消按钮的id属性值命令规则为：所在月份输入框的id加上"_"，再加上功能标识
	 */
	function save(id,type )
	{
		var sval = $("#"+id).val();
		var bval = false;
		
		if (sval==undefined || sval=="")
		{
			if( id == "rznjbl"){
				alert("请输入日滞纳金比率。");
			}else if(id == "fbhth"){
				alert("请输入web发布合同号。");
			}else{
				alert("请选择一个正确的月份。");				
			}
			return;			
		}
		if (id=="czyf"){
		    bval=setIni("汇总选项","当前出帐月",sval);
	    }
	    else if (id=="sfyf"){
		    bval=setSfMonth("收费结账","当前收费月份",sval);
		}
		else if (id=="fbyf"){
			if(type == 'fb'){
				bval=setIni("汇总选项","WEB发布月",sval);
				bval = bval && setWebFBHth('fb');
			}else if(type == 'qx'){
				bval=setWebFBHth('qx');
			}		    
		}
		else if (id=="rznjbl"){
		    bval=setIni("收费结账","日滞纳金比率",sval); 
		}
		else if (id=="znjrq"){
			var sfyf = $("#sfyf").val();
		    bval=setZnjrq(sfyf,sval); 
		}else if(id=="cxys"){
			var reg = /^\d+(\.\d+)?$/;
			 if (!sval.match(reg) || sval>12){
				 alert("请输入输入正确的月份数");
				 return; 
			 }
			 bval=setIni("WEBQUERY","QUERYMONTH",sval); 
		}
		
		if (bval)
		{	
		    $("#back_"+id).val("");
		    $("#"+id+"_edit").removeAttr("disabled");
		    //$("#"+id).attr("disabled","disabled");
		    $("#"+id+"_save").attr("disabled","disabled");
			$("#"+id+"_del").attr("disabled","disabled");
		    $("#"+id+"_cancel").attr("disabled","disabled");
		    $("#"+id).attr("sel","1");
			alert("数据保存成功！");
		}
		else
		{
		    alert("对不起，数据保存失败！");
		}
	}
	/**
	 * 根据节和项设置参数值(同步方式)
	 * @param tsection 配置节
	 * @param tident   配置项
	 * @param tval     要被设置的值
	 * @return  成功则为true失败为false
	 */
	function setIni(tsection,tident,tval,type)
	{
		if(tsection==undefined || tident==undefined || tval==undefined)
		{
			alert("请提供正确的参数");
			return false;
		}
		var res = executeNoQuery("Revenue.setIni",6,"&TS=" + tsd.encodeURIComponent(tsection) + "&TI=" + tsd.encodeURIComponent(tident) + "&TV=" + tsd.encodeURIComponent(tval));
		if(res=="true" || res==true)
		{			
			return true;
		}else {
			return false;
		}
	}
	/**
	 * func  在月份输入框获取焦点时是否可以选择月份
	 * @param id:月份输入框的id属性值
	 * @return 
	 * @desc  月份输入框的自定义属性"sel"的值为1时表示不能选择，为0时表示可以选择
	 */
	function getYearAndMonth(id)
	{
        var sval = $("#"+id).attr("sel");
		//alert(sval);
		if (sval=="1")
		    return;
		else
		    WdatePicker({startDate:'%y-%M',dateFmt:'yyyyMM',alwaysUseStartDate:true});
	}
	/**
	 *设置web发布的合同号
	 * @param fbyf:发布月
	 * @param sval:发布或取消发布合同号
	 * @param type: “fb” 发布制定合同号 “qx”取消指定合同号的发布
	 * @return  成功则为true失败为false
	 */
	function setWebFBHth(type)
	{		
		var params = "";
		var fbyf = $("#fbyf").val();
		var fbhth = $("#fbhth").val();
		//获取发布合同号		
		var HthLimit = "(";
		var hthl = fbhth;
		var userid = '<%=userid%>';
		if($.trim(hthl)!="")
		{
			hthl = hthl.replace(/\n+/g,",").replace(/\s/g,'');
			hthl = "'" + hthl.replace(/,/g,"','") + "'";
			HthLimit += encodeURIComponent(hthl) + ")";
			params = "&fbwhereinfo= hzyf ='" + encodeURIComponent(fbyf) + "' and hth in " + HthLimit ;	
		}else{
			params = "&fbwhereinfo= hzyf ='" + encodeURIComponent(fbyf) + "' ";	
		}		
		//var params = "&hzyf=" + tsd.encodeURIComponent(fbyf) + "&hth=" + HthLimit ;	
		var res ="";
		if(type == "fb"){
			params += "&sflx=1";
			res = executeNoQuery("SummaryReleased.setWebFBHth",6,params);
			if($.trim(hthl)==""){
				var param = "&fbyf="+encodeURIComponent(fbyf)+"&status=&operid="+userid;
				executeNoQuery("SummaryReleased.addmonths",6,param);
			}
		}else if(type == "qx"){
			res = executeNoQuery("SummaryReleased.cancelWebFBHth",6,params);
			var param = "&fbyf="+encodeURIComponent(fbyf);
			if($.trim(hthl)==""){
			executeNoQuery("SummaryReleased.submonths",6,param);
			getwebmonths();
			}
		}
		if(res=="true" || res==true)
		{
			//alert("保存成功");			
				getwebmonths();
			return true;
		}else {
			//alert("保存失败");
			return false;
		}
	}
	
	function getwebmonths(){
		$("#yfbyf").val("");
		var x;
		var res = fetchMultiValue("SummaryReleased.getmonts",6,'');
		for (x in res){
			$("#yfbyf").append(res[x]+"<br/>");
		}
	}
  </script>
  
  <body>
  	<!-- 页面路径 -->  
  	<div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	<!-- 汇总 发布区域 -->  
	<div>

		
		<!-- 汇总参数 -->
		<input type="hidden" id="sureToHz" value="<fmt:message key='Hfhz.sureToHz'/>"/>
		<input type="hidden" name="skrid" id="skrid" value="<%=session.getAttribute("userid") %>"/>
		<!-- 进度条 -->
	   	<div id="loading" style="display:none;">
			<div style="height:80px"></div>
			<img src="style/images/public/loading.gif" />
			<br />
			<!-- 正在汇总，请稍候 --><fmt:message key='Hfhz.wait' />…...
	  	</div>
	  	<div id="backgroundPopup"></div>
	</div>
	
	<!-- 汇总发布参数设置 -->
	<div id="paramSetDiv">
		<div style="text-align:left; padding-top:20px; padding-left:10px" id="div_thr">
	        <fieldset >
			    <legend style="font-size:14px">设置WEB发布月</legend>
			    <br />
				<table id="thrtab" width="100%"  >
				    <tr>
				        <td width="10%" ><span style="padding-left: 12px;">WEB发布月：</span></td>
				        <td width="20%">
							<input type="text" name="fbyf" id="fbyf" onFocus="getYearAndMonth('fbyf');" class="txtInput"  readonly="true"  sel="1"/>
						</td>
						<td width="10%" rowspan="4"><span style="padding-left: 12px;">已发布月份：</span></td>
						<td width="20%" rowspan="4"><textarea  id="yfbyf" cols="20" rows="8" sel="1" class="txtInput"  readonly="true" ></textarea><br/>
						<!-- <span><font color="red"></font></span> -->
						</td>
					</tr>
					<tr>
						<td colspan="4"><br /></td>
					</tr>
					<tr>
						<td width="10%"><span style="padding-left: 12px;">合同号：</span></td>
						<td colspan="4" width="40%">						
							<textarea  id="fbhth" cols="20" rows="8" sel="1" class="txtInput" ></textarea><br/>
							<span><font color="red">可指定多合同号时,每个合同号一行</font></span>
						</td>
					</tr>
					<tr>
						<td colspan="4"><br /></td>
					</tr>					
					<tr>
					  <td colspan="4">
				        &nbsp;&nbsp;<button class="tsdbutton" id="fbyf_edit" onClick="setModifyStatus('fbyf');">修&nbsp;&nbsp;改</button>
					    &nbsp;&nbsp;<button class="tsdbutton" id="fbyf_save" onClick="save('fbyf','fb');" disabled="disabled">发&nbsp;&nbsp;布</button>
						&nbsp;&nbsp;<button class="tsdbutton" id="fbyf_del" onClick="save('fbyf','qx');" disabled="disabled">取消发布</button>
				        &nbsp;&nbsp;<button class="tsdbutton" id="fbyf_cancel" onClick="cancel('fbyf')" disabled="disabled">取&nbsp;&nbsp;消</button>					
				      </td>
						
					</tr>
				</table>
			</fieldset>	   	
		</div>	
		<div style="text-align:left; padding-top:20px; padding-left:10px" id="div_six">
	        <fieldset >
			    <legend style="font-size:14px">修改查询月数</legend>
			    <br />
				<table id="sixtab" width="100%">
				    <tr>
				        <td width="10%"><span style="padding-left: 12px;">查询月数：</span></td>
				        <td width="40%"><input type="text" name="cxys" id="cxys" class="txtInput" sel="1"/></td>
					</tr>
					<tr>
						<td><br /></td>
					</tr>						
					<tr>
				        <td colspan="4">
				        &nbsp;&nbsp;<button class="tsdbutton" id="cxys_edit" onClick="setModifyStatus('cxys')">修&nbsp;&nbsp;改</button>
					    &nbsp;&nbsp;<button class="tsdbutton" id="cxys_save" onClick="save('cxys')" disabled="disabled">保&nbsp;&nbsp;存</button>
				        &nbsp;&nbsp;<button class="tsdbutton" id="cxys_cancel" onClick="cancel('cxys')" disabled="disabled">取&nbsp;&nbsp;消</button>
				        </td>
					</tr>
				</table>
			</fieldset>	   	
		</div>	
		
		<input type="hidden" id="back_czyf" value=""/>
		<input type="hidden" id="back_sfyf" value=""/>
		<input type="hidden" id="back_fbyf" value=""/>	
		<input type="hidden" id="back_rznjbl" value=""/>	
		<input type="hidden" id="back_znjrq" value=""/>	
		<input type="hidden" id="back_cxys" value=""/>	
		<input type="hidden" id="sysTime" value="<%=theTime%>"/>		
	</div>	
  </body>
  
  
</html>
