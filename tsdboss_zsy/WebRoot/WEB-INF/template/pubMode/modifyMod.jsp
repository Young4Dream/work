<%----------------------------------------
	name: modifyMod.jsp
	author: youhongyu
	version: 1.0, 2009-11-26
	description: 查询模板维护
	modify: 
		2009-11-30	更改添加、修改、删除之后的grid展示方式:fuheQuery()>>>querylist() 
    	2009-12-30 修改保存新增 整理代码
    	2010-9-25  oracle 移植
		2010-11-05 youhongyu 添加注释功能
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.tsd.service.util.Log" %>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");	
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    	<title><fmt:message key="pubMode.modifyMod" /></title><!--查询模板维护-->    
    
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
		<!-- 验证数据长度 -->
		<script type="text/javascript" src="script/public/datalength.js"></script>
		
		<!-- tree -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
  
  		<!-- 操作列样式 -->
		<script type="text/javascript" src="script/public/public.js"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />		
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
		<!-- 该页面对应的js脚本 -->
		<script type="text/javascript" src="script/pubMode/modifyMod.js"></script>
		
		<script type="text/javascript">
			/**
			* 页面初始化
			* @param 
			* @return 
			*/
			jQuery(document).ready(function () {
					getUserPower();//该页面的权限主要用于设置可编辑域
					getformInfo();//修改面板用户组复选框选择面板初始化生成
					
					/////设置命令参数
					var urlstr=tsd.buildParams({      packgname:'service',//java包
													  clsname:'ExecuteSql',//类名
													  method:'exeSqlData',//方法名
													  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													  tsdcf:'mssql',//指向配置文件名称
													  tsdoper:'query',//操作类型 
													  datatype:'xml',//返回数据格式 
													  tsdpk:'modifyMod.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													  tsdpkpagesql:'modifyMod.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
												});
					
					
					
					//获取数据表对应字段国际化信息，设置添加等面板的国际化标签
					//qid,name,menid,userid,groupid,querysql		
					var languageType = $("#languageType").val();		
					var thisdata = loadData('query_global',languageType,1);
							
					var qidg = thisdata.getFieldAliasByFieldName('qid');
					var nameg = thisdata.getFieldAliasByFieldName('name');
					var menidg = thisdata.getFieldAliasByFieldName('menid');
					var useridg = thisdata.getFieldAliasByFieldName('userid');
					var groupidg = thisdata.getFieldAliasByFieldName('groupid');			
					
								
					$("#qidg").html(qidg);
					$("#nameg").html(nameg);
					$("#groupidg").html(groupidg);
							
					
					//得到jqGrid要显示的字段
					var col=[[],[]];
					col=getRb_Field('query_global','qid',"修改|删除|查询条件",'115','ziduansF','userid');
					var column = $("#ziduansF").val();
					var useridd = $("#useridd").val();
					jQuery("#editgrid").jqGrid({						
							url:'mainServlet.html?'+urlstr+'&userid='+useridd+'&column='+column,
							datatype: 'xml', 
							colNames:col[0], 
							colModel:col[1], 
							       	rowNum:5, //默认分页行数
							       	rowList:[5,10,20], //可选分页行数
							       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
							       	pager: jQuery('#pagered'), 
							       	sortname: 'qid', //默认排序字段
							       	viewrecords: true, 
							       	//hidegrid: false, 
							       	sortorder: 'asc',//默认排序方式 
							       	caption:'<fmt:message key="pubMode.modifyMod" />', 
							       	height:'267px', //高
							       // width:document.documentElement.clientWidth-27,
							       	loadComplete:function(){
													$("#editgrid").setSelection('0', true);
													$("#editgrid").focus();
													///自动适应 工作空间
													// var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
													//setAutoGridHeight("editgrid",reduceHeight);
													//setAutoGridWidth("editgrid",'0');
													/*********定义需要的行链接按钮************
													////@1  表格的id
													////@2  链接名称
													////@3  链接地址或者函数名称
													////@4  行主键列的名称 可以是隐藏列
													////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
													////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
													var editinfo = $("#editinfo").val();
													var deleteinfo = $("#deleteinfo").val();
													addRowOperBtnimage('editgrid','openRowModify','qid','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
													addRowOperBtnimage('editgrid','deleteRow','qid','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
													addRowOperBtnimage('editgrid','generateTree','qid','click',3,'style/images/public/ltubiao_03.gif',"查询条件","&nbsp;&nbsp;&nbsp;");//详细
													
												   /****执行行按钮添加********
													*@1 表格ID
													*@2 操作按钮数量 等于定义数量
													*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
													executeAddBtn('editgrid',3);
													},
													ondblClickRow:function(ids){		
														if(ids!=null){		       
										                    var qid=$("#editgrid").getCell(ids,"qid");
										                   	generateTree(qid);
									                   	}
													},onSelectRow:function(rowid){
														/**
														if(rowid!=null){		       
										                    var qid=$("#editgrid").getCell(rowid,"qid");
										                   	generateTree(qid);
									                   	}
									                   	*/									
													}			
						}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
							{height:140,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
							{height:140,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
							{reloadAfterSubmit:false}, // del options 
							{} // search options 
					); 
			});
			
		</script>
<base target="_self"/>
</head>
<style type="text/css"> 
 .style1 {
	background-color:#A9C3E8;
	padding: 4px;		
	}

	#navBar1{  height:26px;background:url(style/imgs/daohangbg.jpg); line-height:28px;}
	cas{float:left; width:100%; height:26px;background:url(../imgs/daohangbg.jpg) repeat-x; line-height:28px;}
	h3 {width:60%; height:32px; text-align:center; float:left; line-height:32px; font-size:16px; font-weight:bold;margin-left:90px !important;margin-left:46px;}
	.a{margin-left:90px;border:1px solid #ccc;width:274px;overflow:left;text-overflow:ellipsis;}
</style> 
  <body>  
  <div style="width:560px;">
  <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
  </form>
  
  		<!-- 用户操作导航-->
			<div id="navBar1" >
				<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
				  <div id="navBar" style="float:left">
				  <img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
				  <fmt:message key="global.location" />
						:模板维护
				  </div>
				  </td>
				  </tr>
			  </table>
			</div>
</div> 
<div style="width: 560px;">
	<div style="width: 400px;height: 250px;float:left;">		
	    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;width: 395px;"></div>	
		
		
		
<!-- 添加修改面板 -->
<div class="neirong" id="pan" style="display: none">
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
		<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
		<input type="hidden" ></input>
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  <tr>			   
			    <td width="30%" align="right" class="labelclass"><label id="nameg" ></label></td>							
			    <td width="70%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="name" id="name" maxlength="50" onkeyup="this.value=replaceStrsql(this.value,80)" class="textclass"></input>							
					<label class="addred" ></label></td>			    
			</tr>
			
			<tr>		    
       			<td width="30%" align="right" style="background:#F0F7FB; border-bottom:1px solid #A9C8D9; padding-right:1%;">
       			<label id="groupidg" ></label></td>
        		
       			<td width="70%" style=" border-bottom:1px solid #A9C8D9;">
         		<span id="dept">
					<textarea rows="6" cols="40" id='groupid' onfocus="getTheDept(); " style="min-height:50px;height:auto;width:278px;float:left;"></textarea>	
				</span>
				<span id="thedept" style="display: none;"></span>
	   			<label class="addred" style="float:left;"></label></td>			       			
			   			  
	    	</tr>	  	
		  	
		</table>
		<div style="display: none;"><span id="qidg"></span><input type="text" id="qid"/></div>
		</form>	
		<div class="midd_butt">
		<!-- 修改 --><button class="tsdbutton" id="modify" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空 --><button class="tsdbutton" id="clearB" style="width:63px;heigth:27px;" onclick="clearText('operformT1');"><fmt:message key="global.clear" /></button>
	    <!-- 取消 --><button class="tsdbutton" id="reset" style="width:63px;heigth:27px;" onclick="resett();">取消</button>
		<!-- 关闭 --><button class="tsdbutton" id="closeo" style="width:63px;heigth:27px;" onclick="closeo();"><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>
		
		
		
		
		
		
		<!-- typtDemoModify  表单输入区域  -->
		
			<div style="display: none">
			
					<input type="hidden" id="imenuid" value="<%=imenuid%>" />
					<input type="hidden" id="zid" value="<%=zid%>" />
					<%
						if (!languageType.equals("en")) {
							languageType = "zh";
						}
					%>

					<input type="hidden" id="languageType" value="<%=languageType%>" />

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
					<input type="hidden" id="deleteright" value="true"/>
					<input type="hidden" id="editright" value="true"/>
					<input type="hidden" id="editfields" />
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
					<!-- 打印报表 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 			
					<input name="params" id="params" type="hidden" />
					
					<!-- grid自动 -->
					<input type="hidden" id='ziduansF' />
					<input type='hidden' id='thecolumn'/>	
				</div>	
	</div>
	<div style="display: none;width:400px;height:300px;border: 1px thick #ff0000;" id='querytree'>
		<div id="input-Unit">
			<div class="title">
				<h3></h3>
				<div class="lguanbi" onclick="javascript:$('#Qclose').click();">
					<a href="#" onclick="javascript:$('#FMclose').click();"><fmt:message key="global.close" /></a>
				</div>
			</div>
			<div id="treediv" style="height:230px;overflow: scroll;text-align: left;margin-left: 10px;">																
			</div>
			<div id="buttons">					
				<button type="button" id="Qclose" >
					<!-- 关闭 --><fmt:message key="global.close" />
				</button>
			</div>
		</div>
	</div>
</div>
  </body>
</html>
