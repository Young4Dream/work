<%----------------------------------------
	name: addWaitAdjust.jsp
	author: youhongyu
	version: 1.0, 2011-1-22
	description: 手工添加调级用户
	modify: 
			2011-2-28 初始化修改（改模块公用了单表编辑里面的部分方法，单表编辑页面的调整导致修改）
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";
	
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String departname = (String)session.getAttribute("departname");
	String languageType = (String) session.getAttribute("languageType");
	if (!languageType.equals("en")) {
			languageType = "zh";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<jsp:include page="../../pubMode/publicLable.jsp" flush="false"/>	
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>addWaitAdjust</title>
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
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 操作列样式 -->
		<script type="text/javascript" src="script/public/public.js"></script>
		
		<!-- 把下拉框变成可复合多选 -->
		<script src="plug-in/MultiSelect/jquery.bgiframe.min.js" type="text/javascript"></script>
		<script src="plug-in/MultiSelect/jquery.multiSelect.js" type="text/javascript"></script>			
		<link href="plug-in/MultiSelect/jquery.multiSelect.css" rel="stylesheet" type="text/css" />
		
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		
		<!-- 权限设置 -->
		<script src="script/public/tsdpower.js" type="text/javascript"></script>
		<!-- 单表编辑 -->
		<script src="script/pubMode/SingleTabE.js" type="text/javascript"></script>	
		<link href="style/css/pubMode/SingleTabE.css" rel="stylesheet" type="text/css" />
		<!-- 本页面特殊使用 -->
		<script src="script/telephone/phonectrl/addWaitAdjust.js" type="text/javascript"></script>		

<script type="text/javascript">
/**--------------------------初始化变量 开始--------------------------------**/
		/******************************************************
				               全局变量定义
		******************************************************/
		closeflash = false;//用于判断是添加新增、添加保存
		g_SingleTabE = 'yes';//标识改页面未全局变量
		isshowdata='';//初始化页面时，是否显示数据
		prefix ='';//前缀
		suffixN ='g';//标签后缀
		suffixW ='';//文本域后缀
		suffixQN ='Qg';//简单查询面板标签后缀
		suffixQW ='Q';//简单查询面板文本域后缀		
		suffixIN ='Ig';//详细信息面板标签后缀
		suffixIW ='I';//详细信息面板文本域后缀
		
		//关键字的三种格式
		keyQueryS='';
		keyGridRow ='';//jqgrid添加左侧按钮时，需要参数
		keyWhereS='';
		keyGridTop=new Array();
		
		iscreatPan = false; //判断是否生成添加、修改面板
		iscreatPanQuery = false; //判断是否简单查询面板		
		iscreatInfoPan = false; //判断是否显示详细面板
		//级联弹出详细面板
		isRelatedInfoXX = new Array();//被关联字段的信息 数组1：字段名  数组2：单选复选值  数组3：数据字典保存起来  数组4：多选分隔符
		relatedInfoXX = new Array();//有关联字段的字段名
		isRelateValXX = new Array();//存放修改面板上 被关联字段的值 数组1：字段名 2：字段值
		
		tablename = 'hwjb_waitadjust';//表名
		reportName='';//对应报表名称
		dataSource = 'tsdBilling';//数据源
		powerParams = "subsidyPay.getPower";//权限存储过程对应的表名
		tablealiasName='hwjb_waitadjust';//表别名
		tsdcf = 'mssql';//配置文件名
		rights='add~delete~query~orderBy~jdQuery~modQuery~saveQueryM~delB';
		tablenameleft=' where 1=1 ';//多表关联
		initialization=' 1=1 ';//初始化条件
		delspecial='';//是否要进行删除前特殊处理
		codeinfo='';//表标识，用于判断
		tariffBarHeight=0;//资费设置导航高度
		
		//级联弹出的修改、添加、详细面板
		isRelatedInfo = new Array();//被关联字段的信息 数组1：字段名  数组2：单选复选值  数组3：数据字典保存起来  数组4：多选分隔符
		relatedInfo = new Array();//有关联字段的字段名
		isRelateVal = new Array();//存放修改面板上 被关联字段的值 数组1：字段名 2：字段值
		
		//级联的简单查询面板
		isRelatedInfoQ = new Array();//被关联字段的信息 数组1：字段名  数组2：单选复选值  数组3：数据字典保存起来  数组4：多选分隔符
		
		//唯一性字段组 的字段和分组保存
		unigroupinfo = new Array();
		
		var languageType = '<%=languageType%>';//国际化标签
		fields = getFields(tablealiasName);// 从别名表中获取字段名
		fieldarr = fields.split(",");// 从别名表中获取字段名
/**-------------------------初始化变量 结束-------------------------------**/
/**
* 页面初始化
* @param 
* @return 
*/
jQuery(document).ready(function () {	
		$("#navBar").append(genNavv());//当前所在位置
		/***************************************
			           设置权限
		***************************************/		
		var userid = $('#useridd').val();	
		var groupid = $('#zid').val();
		var imenuid = $('#imenuid').val();			
		var htmlinfo = [{oper:'add',	id:'openadd1,openadd2',		type:'1',value:''},
						{oper:'query',	id:'gjquery1,gjquery2',		type:'1',value:''},
						{oper:'saveQueryM',id:'savequery1,savequery2',type:'1',value:''},
						{oper:'delB',	id:'opendel1,opendel2',		type:'1',value:''},
						{oper:'delete',	id:'deleteright',			type:'2',value:'true'},
						{oper:'editfields',id:'editfields',			type:'3',value:tablealiasName}						
						];
		getUserPowerNEW(htmlinfo,userid,groupid,imenuid,powerParams);
		/***********************************
		根据别名表名获取字段信息 组织成一个json字符串,
		如果从别名表中没有取出符合信息，则提示用户				
		***********************************/
		//////////////////////用于格式化jqgrid上显示sql语句，和显示详细信息
		var fieldfalg = getPublicFieldInfo(2);
		if(fieldfalg=='F'){ return false; }
		//////////////////////生成的json可以用于除以上两种情况的其它操作
		var fieldfalg = getPublicFieldInfo(1);
		if(fieldfalg=='F'){ return false; }
		
		formatKey();//对关键字的格式进行格式化
		getUniqueGroup();//获取要唯一性判断的字段及分组情况
		/***************************************
			           功能按钮配置
		***************************************/
		var operstr = showRightBut();	
		
		/***********************************
				初始化jqgrid数据
		***********************************/
		/////设置命令参数
		var urlstr=tsd.buildParams({ 	  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:dataSource,//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:tsdcf,//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'publicmode.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'publicmode.fuheQueryByWherepage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		});	
		urlstr = urlstr +keyQueryS+"&initialization="+initialization;
		readJQgird(operstr,urlstr);
		
		
		
		/***************************************
			            按钮处理
		***************************************/
		hideButPower();//隐藏不可用按钮
		//初始化话务控制类型
		getServiceType();	
});

 	function setdhg_a(){
 		var selecttype = $("#selecttype").val();
	 	if(selecttype=="dh"){
	 		$("#dhg_a").text("电话号");
	 	}else if(selecttype=="hth"){
	 		$("#dhg_a").text("合同号");
	 	}else{
	 		$("#dhg_a").text("");
	 	}
	 	$("#valuekey").val("")
 	}
</script>
</head>
<body >	
<!-- 当前所在位置 -->
	<div id="navBar1">
		<table width="100%" height="26px">
			<tr>
				<td width="80%" valign="middle">
					<div id="navBar" style="float: left">
						<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
						<fmt:message key="global.location" />
						:
					</div>
				</td>
				<td width="20%" align="right" valign="top">
					<div id="d2back">
						<a href="javascript:void(0);"
							onclick="parent.history.back(); return false;"><fmt:message
								key="gjh.houtuei" />
						</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 资费设置导航条-->
	<div id='tariffBar' style="font-size: 14px; text-align: left;">			
	</div>	

<!-- jqgrid面板显示 -->			
	<!-- 用户操作标题以及放一些快捷按钮-->
	<div id="buttons">		
		<button type="button" id="order1" onclick="openDiaOrder();" >
			<!-- 组合排序 -->	<fmt:message key="order.title" />
		</button>		
		<button type="button" id="openadd1" onclick="openadd();"
			disabled="disabled">
			<fmt:message key="global.add" />
		</button>
		<button type="button" id="jdquery1" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>	
		<!--<button onclick='exeModqueryOper();' id='mbquery1'>
			 模板查询 
			<fmt:message key="oper.mod"/>
		</button>-->	
		<button type="button" id='gjquery1' onclick="openDiaQuery();" disabled="disabled">
			<!--高级查询-->
			<fmt:message key="oper.queryA"/>
		</button>
		<!-- <button type="button" id='savequery1' onclick="openModT();" disabled="disabled">
			将本查询保存为模板
			<fmt:message key="oper.modSave"/>
		</button> -->
		<button type="button" id="opendel1" onclick="openDiaDelete();"
			disabled="disabled">
			<!--批量删除-->
			<fmt:message key="tariff.deleteb"/>
		</button>
		<button type="button" id="openmod1" onclick="openDiaModify();"
			disabled="disabled">
			<!--批量修改-->
			<fmt:message key="tariff.modifyb"/>
		</button>
		<button type="button" id="export1"  onclick="openDiaDownLoad();" 
			disabled="disabled">
			<!--导出-->
			<fmt:message key="global.exportdata"/>
		</button>
		<button type="button" id="print1" onclick="openDiaPrint();"  disabled="disabled">
			<!--打印-->
			<fmt:message key="tariff.printer"/>
		</button>
	</div>
	
	<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	
	<!-- 用户操作标题以及放一些快捷按钮-->
	<div id="buttons">
		<button type="button" id="order2" onclick="openDiaOrder();">
			<!--组合排序-->
			<fmt:message key="order.title"/>
		</button>
		<button type="button" id="openadd2" onclick="openadd();"
			disabled="disabled">
			<fmt:message key="global.add"/>
		</button>
		<button type="button"  id="jdquery2" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
		</button>		
		<!--<button onclick='exeModqueryOper();' id='mbquery2'>
			模板查询
			<fmt:message key="oper.mod"/>
		</button>-->
		<button type="button" id='gjquery2' onclick="openDiaQuery();" disabled="disabled">
			<!--高级查询-->
			<fmt:message key="oper.queryA"/>
		</button>
		<!-- <button type="button" id='savequery2' onclick="openModT();" disabled="disabled">
			保存高级查询为模板 
			<fmt:message key="oper.modSave"/>
		</button>		-->	
		<button type="button" id="opendel2" onclick="openDiaDelete();"
			disabled="disabled">
			<!--批量删除-->
			<fmt:message key="tariff.deleteb"/>
		</button>
		<button type="button" id="openmod2" onclick="openDiaModify();"
			disabled="disabled">
			<!--批量修改-->
			<fmt:message key="tariff.modifyb"/>
		</button>
		<button type="button" id="export2" onclick="openDiaDownLoad();" 
			disabled="disabled">
			<!--导出-->
			<fmt:message key="global.exportdata"/>
		</button>
		<button type="button" id="print2" onclick="openDiaPrint()"  disabled="disabled">
			<!--打印-->
			<fmt:message key="tariff.printer"/>
		</button>
	</div>		
	
	
<!-- 隐藏面板 -->	
<!-- 添加修改面板 -->
<div class="neirong" id="pan" style="display: none;width: 700px;">
	<br/>
	<div class="top">
		<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<div style="max-height:250px;overflow-y: auto;overflow-x: hidden;background-color: #fff" >
			<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" style="width: 680px;float: left;">
				<input type="hidden" id=''></input>
				<table width="100%" id="addtable" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">			
				 	<tboby>
				 	<!-- 
					 <tr>
						    <td width="120px" align="right" class="labelclass"><label id="dhg_a">电话号</label></td>							
						    <td width="220px" align="left" style="border-bottom:1px solid #A9C8D9;">
						    	<input type="text" name="dh_a" id="dh_a" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=48&&k<=57"  maxlength="13" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false"  
						    	class="textclass" />
						    	<label class="addred" ></label>
						    </td>
						    
						    <td width="120px" align="right"  class="labelclass"><label id='hthg_a'>合同号</label></td>
						    <td width="220px;" align="left" style="border-bottom:1px solid #A9C8D9;">
						    	<input type="text" name="hth_a" id="hth_a" 
						    	class="textclass" />
						    	<label class="addred" ></label>
						    </td>					
				 	 </tr>
				 	  -->
				 	  <tr>
				 	  	<td width="120px" align="right" class="labelclass"><label id="addtype">添加类型</label></td>							
						<td width="220px" align="left" style="border-bottom:1px solid #A9C8D9;">						    	
						    	<select name="selecttype" id="selecttype" class="textclass" onchange="setdhg_a();">
						    		<option value="">--请选择--</option>
						    		<option value="dh">电话号</option>
						    		<option value="hth">合同号</option>
						    	</select>
						    	<label class="addred"></label>
						</td>
						<td width="120px" align="right" class="labelclass"><label id="dhg_a"></label></td>							
						<td width="220px" align="left" style="border-bottom:1px solid #A9C8D9;">
							<input type="text" id="valuekey" name="valuekey"/>
						</td>	
				 	  </tr>
				 	 <tr>
						    <td width="120px" align="right" class="labelclass"><label id="servicetypeg_a">话务控制类型</label></td>							
						    <td width="220px" align="left" style="border-bottom:1px solid #A9C8D9;">						    	
						    	<select name="servicetype_a" id="servicetype_a" class="textclass">
						    		<option value="">--<fmt:message key="global.select"/>--</option>
						    	</select>						    	
						    	<label class="addred"></label>
						    </td>
						    <td width="120px" align="right"  class="labelclass"><label id=''></label></td>
						    <td width="220px;" align="left" style="border-bottom:1px solid #A9C8D9;"></td>					
				 	 </tr>
			 	   </tboby>
				</table>
			</form>	
		</div>
		<div class="midd_butt">		
		<!-- 批量修改 --><button class="tsdbutton" id="modifyB" style="width:80px;heigth:27px;" onclick="fuheModify();"><fmt:message key="tariff.modifyb"/></button>
		<!-- 保存新增 --><button class="tsdbutton" id="readd" style="width:80px;heigth:27px;" onclick="saveObj(1);"><fmt:message key="global.save"/><fmt:message key="global.add"/></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save" style="width:80px;heigth:27px;" onclick="addYH();"><fmt:message key="global.save"/></button>
		<!-- 修改     --><button class="tsdbutton" id="modify" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit"/></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB" style="width:63px;heigth:27px;" onclick="clearText('operformT1');"><fmt:message key="global.clear"/></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset" style="width:63px;heigth:27px;" onclick="resett();">取消</button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo" style="width:63px;heigth:27px;" onclick="closeo();"><fmt:message key="global.close"/></button>
		</div>	
	</div>
</div>

<!-- 添加详细信息面板 -->
<div class="neirong" id="panX" style="display: none;width: 700px;">
	<br/>
	<div class="top">
		<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoXX()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<div style="max-height:250px;overflow-y: auto;overflow-x: hidden;background-color: #fff" >
			<form id='operformTX' name="operformTX" onsubmit="return false;" action="#" style="width: 680px;float: left;">
				<input type="hidden" id=''></input>
				<table width="100%" id="Infotable" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">			
				 	<tboby><tr><td colspan="4"></td></tr></tboby>
				</table>
			</form>	
		</div>
		<div class="midd_butt">		
		<!-- 关闭 	 --><button class="tsdbutton" id="closeoX" style="width:63px;heigth:27px;" onclick="closeoXX();"><fmt:message key="global.close"/></button>
		</div>	
	</div>
</div>


<!-- 简单查询面板 -->
<div class="neirong" id="QueryPan" style="display: none;width: 700px;">
	<br/>
	<div class="top">
		<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeQuery();"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
		<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<div style="max-height:250px;overflow-y: auto;overflow-x: hidden;background-color: #fff" >
			<form id='operformTQuery' name="operformTQuery" onsubmit="return false;" action="#" style="width: 680px;float: left;">
				<input type="text" style="display: none;" />
				<table id="querytable" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">			
				 	<!-- 
				 		<tr>
							<td width="120px" align="right" class="labelclass"><label id="starttimeg_b">时间范围从</label></td>							
						    <td width="220px" align="left" style="border-bottom:1px solid #A9C8D9;">
						    	<input type="text" name="starttime_b" id="starttime_b" class="textclass" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
						    	/>
						    </td>
						    
						    <td width="120px" align="right"  class="labelclass"><label id='endtiemg_b'>至</label></td>
						    <td width="220px;" align="left" style="border-bottom:1px solid #A9C8D9;">
						    	<input type="text" name="endtiem_b" id="endtiem_b" class="textclass" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
						    	 />
						    </td>					
				 	 </tr>
				 	 <tr>
						    <td width="120px" align="right" class="labelclass"><label id="servicetypeg_b">话务控制类型</label></td>							
						    <td width="220px" align="left" style="border-bottom:1px solid #A9C8D9;">						    	
						    	<select name="servicetype_b" id="servicetype_b" class="textclass">
						    		<option value=""><fmt:message key="global.select"/></option>
						    	</select>
						    </td>
						    
						    <td width="120px" align="right"  class="labelclass"><label id=''></label></td>
						    <td width="220px;" align="left" style="border-bottom:1px solid #A9C8D9;"></td>					
				 	 </tr>
				 	  -->
				 	  <tr>
						    <td width="50%"  style="text-align:right;background: #F0F7FB;">电话号码</td>							
						    <td width="520"  style="border-bottom:1px solid #A9C8D9;">						    	
						    	<input type="text" id="selectphone" name="selectphone" class="textclass"/>
						    </td>
				 	 </tr>	 
				</table>
			</form>	
		</div>
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery" onclick="QbuildParams();"><fmt:message key="global.query"/></button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeQ" style="width:63px;heigth:27px;" onclick="closeQuery();"><fmt:message key="global.close"/></button>
		</div>
	</div>
</div>


<!-- 添加模板面板 -->
<div id="modT" name='modT' style="display: none;width: 700px;"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
		<input type="text" style="display: none;"  />
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">			
			  	<tr>
				    <td width="120px" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
				    <td width="220px" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="name_mod" id="name_mod" maxlength="50" onpropertychange="TextUtil.NotMax(this)" class="textclass" />
				    	<font style="color: #ff0000;">*</font></td>
				    
				    <td width="120px" align="right"  class="labelclass"><label id=''></label></td>
				    <td width="220px;" align="left" style="border-bottom:1px solid #A9C8D9;"></td>					
			 	 </tr>	  
			</table>
		</form>
		<div class="midd_butt">
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="saveModQueryOper();" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>			

	
<div style="display: none">
	<!-- 国际化标识 -->
	
	<input type="hidden" id="addinfo" value="<fmt:message key="global.add"/>" /><!-- 添加 -->
	<input type="hidden" id="deleteinfo" value="<fmt:message key="global.delete"/>" /><!-- 删除 -->
	<input type="hidden" id="editinfo" value="<fmt:message key="global.edit"/>" /><!-- 修改 -->
	<input type="hidden" id="deletebinfo" value="<fmt:message key="tariff.deleteb"/>" /><!-- 批量删除 -->
	<input type="hidden" id="modifybinfo" value="<fmt:message key="tariff.modifyb"/>" /><!-- 批量修改 -->
	<input type="hidden" id="conditions" value="<fmt:message key="global.conditions"/>" /><!-- 条件 -->
	<input type="hidden" id="newVal" value="<fmt:message key="global.newVal"/>" /><!-- 新值 -->
	<input type="hidden" id="mesall" value="<fmt:message key="pubMode.mesAll"/>" /><!-- 详细信息 -->
	
	
	
	<input type="hidden" id="queryinfo" value="<fmt:message key="global.query"/>" />
	<input type="hidden" id="operation" value="<fmt:message key="global.operation"/>" />
	<input type="hidden" id="operationtips" value="<fmt:message key="global.operationtips"/>" />
	<input type="hidden" id="successful" value="<fmt:message key="global.successful"/>" />
	<input type="hidden" id="deleteinformation" value="<fmt:message key="global.deleteinformation"/>" />
	<input type="hidden" id="worninfo" value="<fmt:message key="zhji.zjjxonly"/>" />
	<input type="hidden" id="worntips" value="<fmt:message key="powergroup.worntips"/>" />
	<input type="hidden" id="deletepower" value="<fmt:message key="global.deleteright"/>" />
	<input type="hidden" id="editpower" value="<fmt:message key="global.editright"/>" />
	<input type="hidden" id="zhjititle" value="<fmt:message key="tariff.zhji" />" />
	<input type="hidden" id="selectinfo" value="<fmt:message key="global.select"/>" />
	<input type="hidden" id="inputAlarmInfo" value="<fmt:message key='tariff.input'/>" />
	
	
	<!-- 基本 -->
	<input type="hidden" id="useridd" value="<%=userid%>"/>	
	<input type="hidden" id="imenuid" value="<%=imenuid%>" />
	<input type="hidden" id="zid" value="<%=zid%>" />
	<input type="hidden" id="departname" value="<%=departname%>" /><!-- 部门 -->
		
	<input type="hidden" id="languageType" value="<%=languageType%>" />
	

	<!-- 权限控制 -->
	<input type="hidden" id="addright" />
	<input type="hidden" id="deleteright" />
	<input type="hidden" id="editright" />
	<input type="hidden" id="editfields" />
	<input type="hidden" id="delBright" />
	<input type="hidden" id="editBright" />
	<input type="hidden" id="exportright" />
	<input type="hidden" id="printright" />
	<input type="hidden" id="queryright"/>
	<input type="hidden" id="queryMright"/>
	<input type="hidden" id="saveQueryMright"/>
	
	<!-- grid自动 -->
	<input type="hidden" id='ziduansF' />
	<input type='hidden' id='thecolumn'/>	
	
	<!-- 高级查询 -->		
	<input type="hidden" id="queryName" name="queryName" value=""  />
	<input type="hidden" id="fusearchsql" name="fusearchsql"  />
	<!-- 查询树信息存放 保存模板查询 -->
	<input type="hidden" id='treepid' />	
	<input type="hidden" id='treecid' />	
	<input type="hidden" id='treestr' />	
	<input type="hidden" id='treepic' />
	
			
	<!-- 用于写入日志 -->
	<input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request)%>" />
	<input type="hidden" id="userloginid" value="<%=session.getAttribute("userid")%>" />
	<input type="hidden" id="thislogtime" value="<%=Log.getThisTime()%>" />		
	<input type="hidden" id="LogContentS"  /><!-- 拼接添加、修改的字符串 -->
	<input type="hidden" id="logoldstr" /><!-- 修改时保存原来数据的隐藏域 -->
	<input  type="hidden" name="BatchEditLog" id="BatchEditLog" />	<!-- 批量修改时保存原来数据的隐藏域 -->
	<!-- 打印报表 -->
	<input type='hidden' id='thisbasePath' value='<%=basePath%>' />	
	<!-- 导出数据 -->
	<input type="hidden" id="whickOper"/>	
	<!-- 存放字段相关信息 json格式 -->
	<input type="hidden" id="fieldjsoninfo"/>	
	<!-- 显示详细信息面板 存放字段相关信息 json格式 -->
	<input type="hidden" id="fieldjsoninfoXX"/>
	<!-- 查询 -->
	<input type="hidden" id="modifyreset"/>
	<!-- 权限配置 -->
	<input type="hidden" id="deleteJQ" />
	<input type="hidden" id="editJQ" />
	<input type="hidden" id="showInfoJQ" />
	
</div>		
<jsp:include page="../../pubMode/publicLable.jsp" flush="false"/>	
</body>
</html>
