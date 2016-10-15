<%----------------------------------------
	name: MonthPrice.jsp
	author: youhongyu
	version: 1.0, 2010-10-11
	description: 定义月杂费类型
	modify: 
		2009-11-26 youhongyu 添加注释功能	
		2010-12-15 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
		2011-01-11 chenze    增加交换机类型，全选，全不选
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
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
<%
	String lanType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    	<title>Definition relay Bureau to Group</title> 
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
		
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
		
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 资费菜单样式 -->
		<link href="style/css/pubMode/tariff.css" rel="stylesheet" type="text/css" />
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		
		<!-- 分项卡 -->	
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
		<link rel="stylesheet" type="text/css" href="plug-in/MultiSelect/jquery.multiSelect.css" />
		<script type="text/javascript" src="plug-in/MultiSelect/jquery.multiSelect.js"></script>
		
		<style type="text/css">
		#V1,#V2,#V3,#V4{height:0px;}
		#editgrid a{font-weight:bold;}
		.multiSelect{width:153px;margin-left:4px;height:18px;line-height:18px;}
		.multiSelectOptions{width:153px;}
		
		</style>
	
<script type="text/javascript">
/**
* 查看当前用户的扩展权限，对spower字段进行解析
* @param 
* @return 
*/
function getUserPower(){
			 var urlstr=buildParamsPro('MonthPrice.getPower','query');
			/************************
			*   调用存储过程需要的参数 *
			**********************/
			var userid = $('#useridd').val();	
			var groupid = $('#zid').val();
			var imenuid = $('#imenuid').val();
			
			/****************
			*   拼接权限参数 *
			**************/
			
			var addright = '';
			var delBright = '';
			var editBright = '';
			var deleteright = '';
			var editright = '';
			var editfields = '';
			var editfields_son='';
			var exportright = '';
			var printright ='';
			
			var queryright = '';				
			var queryMright = '';
			var saveQueryMright ='';
			
			var flag = false;
			var spower = '';
			var str = 'true';
			
			$.ajax({
					url:'mainServlet.html?'+urlstr+'&userid='+userid+'&groupid='+groupid+'&menuid='+imenuid,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						$(xml).find('row').each(function(){
								spower += $(this).attr("spower")+'@';
						});
					}
			});
			if(spower!=''&&spower!='all@'){
					var spowerarr = spower.split('@');
					for(var i = 0;i<spowerarr.length-1;i++){
						addright += getCaption(spowerarr[i],'add','')+'|';
						delBright += getCaption(spowerarr[i],'delB','')+'|';
						editBright += getCaption(spowerarr[i],'editB','')+'|';	
						deleteright += getCaption(spowerarr[i],'delete','')+'|';
						editright += getCaption(spowerarr[i],'edit','')+'|';	
						editfields += getCaption(spowerarr[i],'editfields','');
						editfields_son += getCaption(spowerarr[i],'editfields2','');
						exportright += getCaption(spowerarr[i],'export','')+'|';
						printright += getCaption(spowerarr[i],'print','')+'|';
						
						queryright += getCaption(spowerarr[i],'query','')+'|';
						queryMright += getCaption(spowerarr[i],'queryM','')+'|';
						saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
					}
			}else if(spower=='all@'){
					$("#addright").val(str);
					$("#delBright").val(str);
					$("#editBright").val(str);
					$("#deleteright").val(str);
					$("#editright").val(str);
					$("#exportright").val(str);
					$("#printright").val(str);
					$("#queryright").val(str);						
					$("#queryMright").val(str);
					$("#saveQueryMright").val(str);
					//var languageType = $("#languageType").val();
					editfields = getFields('attachprice');
					editfields_son = getFields('attachprice_hth');
					
					flag = true;
			}
			
			if(flag==false){
				var hasadd = addright.split('|');
				var hasdelB = delBright.split('|');
				var haseditB = editBright.split('|');
				var hasdelete = deleteright.split('|');
				var hasedit = editright.split('|');
				var hasexport = exportright.split('|');
				var hasprint = printright.split('|');
				
				var hasquery = queryright.split('|');
				var hasqueryM = queryMright.split('|');
				var hassaveQueryM = saveQueryMright.split('|');
				
				for(var i = 0;i<hasquery.length;i++){
					if(hasquery[i]=='true'){
						$("#queryright").val(str);
						break;
					}
				}					
				for(var i = 0;i<hasqueryM.length;i++){
					if(hasqueryM[i]=='true'){
						$("#queryMright").val(str);
						break;
					}
				}					
				for(var i = 0;i<hassaveQueryM.length;i++){
					if(hassaveQueryM[i]=='true'){
						$("#saveQueryMright").val(str);
						break;
					}
				}
				
				for(var i = 0;i<hasadd.length;i++){
					if(hasadd[i]=='true'){
						$("#addright").val(str);
						break;
					}
				}
				for(var i = 0;i<hasdelB.length;i++){
					if(hasdelB[i]=='true'){
						$("#delBright").val(str);
						break;
					}
				}
				for(var i = 0;i<haseditB.length;i++){
					if(haseditB[i]=='true'){
						$("#editBright").val(str);
						break;
					}
				}
				for(var i = 0;i<hasdelete.length;i++){
					if(hasdelete[i]=='true'){
						$("#deleteright").val(str);
						break;
					}
				}
				for(var i = 0;i<hasedit.length;i++){
					if(hasedit[i]=='true'){
						$("#editright").val(str);
						break;
					}
				}					
				for(var i = 0;i<hasexport.length;i++){
					if(hasexport[i]=='true'){
						$("#exportright").val(str);
						break;
					}
				}					
				for(var i = 0;i<hasprint.length;i++){
					if(hasprint[i]=='true'){
						$("#printright").val(str);
						break;
					}
				}					
			}
			$("#editfields").val(editfields);
			$("#editfields_son").val(editfields_son);
}

	//用于表识当前选项卡		
	var tabStatus = 1;
	//存放各选项卡的对应的表的关键字
	var primaryKeys = [
		["FeeCode","FeeType"],
		["FeeCode","FeeType"]
	];
	//存放各选项卡对应表名
	var tables = ["attachprice","attachprice_hth"];
	//存放各选项卡对sql语句的开始部分
	var pkeys = ["MPAttachPrice","MPAttachPriceHth"];
	
	var fuheM = false;	
	var firstLoad = [true,true];
	
	//存放各选项卡对应jqgrid的标题
	var mNames = ["<fmt:message key='MonthPhone.phone' />","<fmt:message key='MonthPhone.contract' />"];
	
	/**
	 * 页面初始化
	 * @param 
	 * @return 
	 */
	$(function(){
			//分项卡方法调用
			$("#tabs").tabs();
			//导航栏设置
			$("#navBar").append(genNavv());
			//权限设置
			getUserPower();
			var addright = $("#addright").val();
			var delBright = $("#delBright").val();
			var editBright = $("#editBright").val();
			var exportright = $("#exportright").val();
			var printright = $("#printright").val();
			
			var queryright = $("#queryright").val();			
			var saveQueryMright = $("#saveQueryMright").val();
			
			if(queryright=="true"){
				document.getElementById("gjquery1").disabled=false;
				document.getElementById("gjquery2").disabled=false;
			}		
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
			}
			
			if(addright=="true"){
				document.getElementById("openadd1").disabled=false;
				document.getElementById("openadd2").disabled=false;
			}
			if(delBright=="true"){
				document.getElementById("opendel1").disabled=false;
				document.getElementById("opendel2").disabled=false;
			}
			if(editBright=="true"){
				document.getElementById("openmod1").disabled=false;
				document.getElementById("openmod2").disabled=false;
			}
			if(exportright=="true"){
				document.getElementById("export1").disabled=false;
				document.getElementById("export2").disabled=false;
			}
			if(printright=="true"){
				//document.getElementById("print1").disabled=false;
				//document.getElementById("print2").disabled=false;
			}
		initJhjid();		
		tabsChg(1);	//默认显示第一个选项卡
	});


var closeflash = false;//用于判断添加操作是保存新增，或保存退出。保存新增closeflash=true ；保存退出=false
/**
 * 点击切换选项卡操作
 * @param id 当前被点击的选项卡表识，通过该表识打开相应选项卡
 * @return 
 */
function tabsChg(id)
{
		$("#gridd").empty();
		$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
		$("#editgrid").empty();
		$("#fusearchsql").val("");
		switch(id)
		{
			case 1:
				tabStatus=1;				
				ready1();
				break;
			case 2:
				tabStatus=2;				
				ready2();
				break;
			default:
				tabStatus=1;				
				ready1();
		}
}

/**
 * 初始化交换机编号
 * @param 
 * @return 
 */
function initJhjid()
{
	//var jhjs = fetchMultiArrayValue("MPAttachPrice.jhj",6,"");
	var jhjs = fetchMultiArrayValue("MPAttachPrice.ywlx",6,""); //2016-01-26 交换机型号改成业务类型
	if(jhjs[0]!=undefined && jhjs[0][0]!=undefined)
	{
		var optHtml = "";
		for(var ii=0;ii<jhjs.length;ii++)
		{
			//optHtml += '<option value="' + jhjs[ii][0] + '">'+ jhjs[ii][1] + '</option>';
			optHtml += '<option value="' + jhjs[ii][1] + '">'+ jhjs[ii][1] + '</option>';
		}
		
		$("#nBz").html(optHtml);
		$("#nBz").multiSelect({ oneOrMoreSelected: '*',selectAllText:'<fmt:message key="MonthPrice.allswitchmachine" />',noneSelected:''},'','nBz',',');
		$("#nBz").next(".multiSelectOptions").find(".selectAll:first").hide();
		$("#nBz").next(".multiSelectOptions").prepend("<label style='border-bottom:1px dashed #CCC'><input type='checkbox' name='nBz' id='nBz_chknone' value='N' /><fmt:message key='MonthPrice.canotchoose' /></label>");
		$("#nBz").next(".multiSelectOptions").prepend("<label style='border-bottom:1px dashed #CCC'><input type='checkbox' name='nBz' id='nBz_chkall' value='' /><fmt:message key='MonthPrice.allswitchmachine' /></label>");
		$("#nBz_chknone").click(function(){
			if($("#nBz_chknone:checked").size()>0)
			{
				$(":checkbox[name='nBz']:checked").not($("#nBz_chknone,#nBz_chkall")).click();
				$(":checkbox[name='nBz']").not($(this)).attr("disabled","disabled");
				$("#nBz").val("<fmt:message key='MonthPrice.canotchoose' />").attr("trueval","N");
			}
			else
			{
				$(":checkbox[name='nBz']").removeAttr("disabled");
				$("#nBz").val("").attr("trueval","");
			}
		});
		$("#nBz_chkall").click(function(){
			if($("#nBz_chkall:checked").size()>0)
			{
				$(":checkbox[name='nBz']:checked").not($("#nBz_chknone,#nBz_chkall")).click();
				$(":checkbox[name='nBz']").not($(this)).attr("disabled","disabled");
				$("#nBz").val("<fmt:message key='MonthPrice.allswitchmachine' />").attr("trueval","");
			}
			else
			{
				$(":checkbox[name='nBz']").removeAttr("disabled");
				$("#nBz").val("").attr("trueval","");
			}
		});
		$("#bzBugFixer1").multiSelect({ oneOrMoreSelected: '*'},'','bzBugFixer1',',');
		$("#bzBugFixer1").hide();
		//$("#Bz").addClass("multiSelect");
	}	
}


/**
 * 第一个选项卡对应的jqgrid的数据加载，和其对应的弹出面板中标签的国际化
 	表attachprice
 * @param 
 * @return 
 */
function ready1(){			
			var column  = '';
			var thisdata = loadData('attachprice','<%=languageType %>',1);
			column = thisdata.FieldName.join(',');	
			$('#thecolumn').val(column);
			var col=[[],[]];
			col=getRb_Field('attachprice','FeeCode',"<fmt:message key='MonthPrice.modifydeletedetail' />",'97','ziduansF1','FeeType');;//得到jqGrid要显示的字段
			var column = $("#ziduansF1").val();	 			 					
			//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
			var FeeCodeg = thisdata.getFieldAliasByFieldName('FeeCode');
			var FeeTypeg = thisdata.getFieldAliasByFieldName('FeeType');
			var FeeNameg = thisdata.getFieldAliasByFieldName('FeeName');
			var Priceg = thisdata.getFieldAliasByFieldName('Price');
			var TjPriceg = thisdata.getFieldAliasByFieldName('TjPrice');
			//var Bzg = thisdata.getFieldAliasByFieldName('Bz');
			var Dhlx = thisdata.getFieldAliasByFieldName('DHLX');
			$("#FeeCodeg").html(FeeCodeg);
			$("#FeeTypeg").html(FeeTypeg);
			$("#FeeNameg").html(FeeNameg);
			$("#Priceg").html(Priceg);
			$("#TjPriceg").html(TjPriceg);
			//$("#Bzg").html(Bzg);
			$("#Dhlx").html(Dhlx);
			column = column.replace(",Bz",",getMultiValues(Bz,'jhjid','jhjid','jhjname',',') Bz"); 
			$("#ziduansF1").val(column);
			var urlstr=tsd.buildParams({ packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'MPAttachPrice.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'MPAttachPrice.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
										});
			//alert(colNamess[tabStatus-1].length);
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1], 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'FeeCode', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='MonthPhone.phone' />", 
				       	shrinkToFit: false,
		       			width:document.documentElement.clientWidth-50,
		       			height:285, //高
				       	loadComplete:function(){				       	
				       					var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										addRowOperBtnimage('editgrid','openRowModify','FeeCode','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'FeeType');//修改
										addRowOperBtnimage('editgrid','deleteRow','FeeCode','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'FeeType');//删除
										addRowOperBtnimage('editgrid','openRowInfo','FeeCode','click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='MonthPrice.detail' />","&nbsp;&nbsp;&nbsp;",'FeeType');//详细
						
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	*/
										/****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换
										addRowOperBtn('editgrid',"<fmt:message key='global.edit' />",'openRowModify','FeeCode','click',1,'FeeType');
										addRowOperBtn('editgrid',"<fmt:message key='global.delete' />",'deleteRow','FeeCode','click',2,'FeeType');
									   
										*/
										executeAddBtn('editgrid',3);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var FeeCode =$("#editgrid").getCell(ids,"FeeCode");
													var FeeType =$("#editgrid").getCell(ids,"FeeType");
													openRowInfo(FeeCode,FeeType);
												}
										}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
}
/**
 * 第二个选项卡对应的jqgrid的数据加载，和其对应的弹出面板中标签的国际化
 	对应表attachprice_hth
 * @param 
 * @return 
 */
function ready2(){
			
			var column  = '';
			var thisdata = loadData('attachprice_hth','<%=languageType %>',1);
			column = thisdata.FieldName.join(',');		
			var col=[[],[]];
			col=getRb_Field('attachprice_hth','FeeCode',"<fmt:message key='MonthPrice.modifydeletedetail' />",'97','ziduansF2','FeeType');//得到jqGrid要显示的字段
			var column = $("#ziduansF2").val();				
			//FeeCode	FeeType		FeeName	 Price
			var FeeCodeg = thisdata.getFieldAliasByFieldName('FeeCode');
			var FeeTypeg = thisdata.getFieldAliasByFieldName('FeeType');
			var FeeNameg = thisdata.getFieldAliasByFieldName('FeeName');
			var Priceg = thisdata.getFieldAliasByFieldName('Price');
			$("#FeeCodeg_s").html(FeeCodeg);
			$("#FeeTypeg_s").html(FeeTypeg);
			$("#FeeNameg_s").html(FeeNameg);
			$("#Priceg_s").html(Priceg);
			
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'MPAttachPriceHth.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'MPAttachPriceHth.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});	
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml',				
				colNames:col[0], 
				colModel:col[1], 			
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'FeeCode', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:"<fmt:message key='MonthPhone.contract' />", 
				       	shrinkToFit: false,
		       			width:document.documentElement.clientWidth-50,
		       			height:285, //高
				       	loadComplete:function(){
				       					var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										addRowOperBtnimage('editgrid','openRowModify','FeeCode','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'FeeType');//修改
										addRowOperBtnimage('editgrid','deleteRow','FeeCode','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'FeeType');//删除
										addRowOperBtnimage('editgrid','openRowInfo','FeeCode','click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='MonthPrice.detail' />","&nbsp;&nbsp;&nbsp;",'FeeType');//详细
						
										 /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+
										addRowOperBtn('editgrid',"<fmt:message key='global.edit' />",'openRowModify','FeeCode','click',1,"FeeType");
										addRowOperBtn('editgrid',"<fmt:message key='global.delete' />",'deleteRow','FeeCode','click',2,"FeeType");
									  
										*/
										executeAddBtn('editgrid',3);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var FeeCode =$("#editgrid").getCell(ids,"FeeCode");
													var FeeType =$("#editgrid").getCell(ids,"FeeType");
													openRowInfo(FeeCode,FeeType);
												}
										}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
}

/**
 * 对jqgrid面板查看明细按钮，可查看详细信息
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key 查询该条记录的第一个参数
 * @param key1  查询该条记录的第二个参数
 * @return 
 */
function openRowInfo(key,key1){
	markTable(1);//显示红色*号	
	//设置编辑框的标题
	$(".top_03").html("详细信息");//标题
	//根据tabStatus判断对相应的面板中的输入框设置为不可用
	switch(tabStatus){
		case 1:
				isDisabledN('attachprice','',''); //将修改面板的输入框全部	置为不可用
				clearText('operformT1');//清空修改面板	 	
				$("#nBz").next(".multiSelectOptions").find(":checkbox").attr("disabled","disabled");
				break;			
		case 2:
				isDisabledN('attachprice_hth','','_s');//将修改面板的输入框全部	置为不可用
				clearText('operformT2');//清空修改面板	
				break;			
	}
	openpan();//显示修改面板
	queryByID(key,key1);//从数据库中查找出该记录的详细信息
}
/**
 * 从数据库中查找出该记录的详细信息，显示在详细面板中
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key 查询该条记录的第一个参数
 * @param key1  查询该条记录的第二个参数
 * @return 
 */
function queryByID(key,key1){
		switch(tabStatus){
				case 1:
				$("#FeeCode").val(key);
				$("#FeeType").val(key1);
				var urlstr=tsd.buildParams({  packgname:'service',//java包
													  clsname:'ExecuteSql',//类名
													  method:'exeSqlData',//方法名
													  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													  tsdcf:'mssql',//指向配置文件名称
													  tsdoper:'query',//操作类型 
													  datatype:'xmlattr',//返回数据格式 
													  tsdpk:'MPAttachPrice.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													});		 					
						
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&FeeCode='+key+'&FeeType='+tsd.encodeURIComponent(key1),
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								/////////////////////////////
								//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
								$(xml).find('row').each(function(){
										//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
										///如果sql语句中指定列名 则按指定名称给参数
										//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
										var oldstr=[];
										
										var FeeCode = $(this).attr("FeeCode".toLowerCase());	
										oldstr.push(FeeCode);						
										$("#FeeCode").val(FeeCode);
										
										var FeeType = $(this).attr("FeeType".toLowerCase());
										oldstr.push(FeeType);	
										$("#FeeType").val(FeeType);
										
										var FeeName = $(this).attr("FeeName".toLowerCase());
										oldstr.push(FeeName);	
										$("#FeeName").val(FeeName);
										
										var Price = $(this).attr("Price".toLowerCase());
										oldstr.push(Price);	
										$("#Price").val(Price);
										
										var TjPrice = $(this).attr("TjPrice".toLowerCase());
										oldstr.push(TjPrice);	
										$("#TjPrice").val(TjPrice);
										
										var Bz = $(this).attr("Bz".toLowerCase());
										if(Bz!=null && Bz!=undefined && Bz!="")
										{
											var bzlist = [];
											if(Bz.indexOf(",")>0)
												bzlist = Bz.split(",");
											else
												bzlist.push(Bz);
											
											for(var ii=0;ii<bzlist.length;ii++)
											{
												$("#nBz").next(".multiSelectOptions").find("input:checkbox[value='"+bzlist[ii]+"']").each(function(){
													$(this).attr("checked","checked").click().attr("checked","checked");
												});
											}
											oldstr.push(Bz); 
											//$("#Bz").val(Bz);
										}
										else if(Bz=="")
										{
											$("#nBz_chkall").click();
											$("#nBz").next(".multiSelectOptions").find(":checkbox").not($("#nBz_chkall")).attr("disabled","disabled");
										}
										$("#logoldstr").val(oldstr);	
										//向隐藏域中放值
									 	$("#H_FeeCode").val(FeeCode);
									 	$("#H_FeeType").val(FeeType);						
								});
							}
						});
						break;
					case 2:	
						$("#FeeCode_s").val(key);
						$("#FeeType_s").val(key1);		
						var urlstr=tsd.buildParams({  packgname:'service',//java包
													  clsname:'ExecuteSql',//类名
													  method:'exeSqlData',//方法名
													  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													  tsdcf:'mssql',//指向配置文件名称
													  tsdoper:'query',//操作类型 
													  datatype:'xmlattr',//返回数据格式 
													  tsdpk:'MPAttachPriceHth.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													});		 					
						
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&FeeCode='+key+'&FeeType='+tsd.encodeURIComponent(key1),
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								/////////////////////////////
								//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
								$(xml).find('row').each(function(){
									//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
									///如果sql语句中指定列名 则按指定名称给参数
									//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
									var oldstr=[];
									var FeeCode = $(this).attr("FeeCode".toLowerCase());	
									oldstr.push(FeeCode);						
									$("#FeeCode_s").val(FeeCode);
									var FeeType = $(this).attr("FeeType".toLowerCase());
									oldstr.push(FeeType);	
									$("#FeeType_s").val(FeeType);
									var FeeName = $(this).attr("FeeName".toLowerCase());
									oldstr.push(FeeName);	
									$("#FeeName_s").val(FeeName);
									var Price = $(this).attr("Price".toLowerCase());
									oldstr.push(Price);	
									$("#Price_s").val(Price);
									
									$("#logoldstr").val(oldstr);
									//向隐藏域中放值
									 $("#H_FeeCode").val(FeeCode);
									 $("#H_FeeType").val(FeeType);	
									
								});
							}
						});
						break;
			}
}

/**
 * 添加面板中保存新增、保存退出按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param saves 判断保存类型 1：保存新增 ；2保存退出
 * @return 
 */
function saveObj(saves){
	switch(tabStatus){
		case 1:
			var params=buildParams();
			if(params==false){return false;}
			//判断关键字是否已经存在
			var falg = '';
			var urlstr1=buildParamsSql('query','xmlattr','MPAttachPrice.existed','');
			urlstr1 += params;
			$.ajax({
				url:'mainServlet.html?'+urlstr1,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					/////////////////////////////
					//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
					$(xml).find('row').each(function(){
						//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
						///如果sql语句中指定列名 则按指定名称给参数
						var FeeCode = $(this).attr("FeeCode".toLowerCase());
						var FeeCodeh=$("#FeeCode").val();
						FeeCodeh=FeeCodeh.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
						if(FeeCode==FeeCodeh){
							var operationtips = $("#operationtips").text();
							//套餐类型和费用名称的组合已经存在，请重新输入！
							var IDDg = $("#FeeCodeg").text();
							var TypeIDg = $("#FeeTypeg").text();
							//alert(IDDg+" "+TypeIDg+"<fmt:message key='tariff.Portfolio'/><fmt:message key='tariff.isExist'/>",operationtips);
							alert(IDDg+" "+TypeIDg+"<fmt:message key='tariff.Portfolio'/><fmt:message key='tariff.isExist'/>");
							$("#FeeCode").focus();
							falg="false";
						}
					});
				}
			});
			if(falg=="false"){return false;}
			
			var urlstr=buildParamsSql('exe','xml','MPAttachPrice.add','');
			urlstr+=params;
					
					//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
					$.ajax({
					url:'mainServlet.html?'+urlstr,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
						success:function(msg){
							if(msg=="true"){
							var operationtips = $("#operationtips").val();
							var successful = $("#successful").val();
							alert(successful,operationtips);
							
							//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
							//写入日志操作
							var str =$("#FeeCodeg").html()+": "+$("#FeeCode").val()+";"+$("#FeeTypeg").html()+": "+$("#FeeType").val()+";"+$("#FeeNameg").html()+": "+$("#FeeName").val()+";"+$("#Priceg").html()+": "+$("#Price").val()+";"+$("#TjPriceg").html()+": "+$("#TjPrice").val()+";"+$("#Bzg").html()+": "+$("#nBz").attr("trueval");
							logwrite(1,str);	
									
								if(saves==2){
									//fuheQuery();
									querylist(0);
									setTimeout($.unblockUI, 15);
								}else{
									closeflash=true;//表示关闭时需要刷新									
									clearText('operformT1');
									$("#nBz").next(".multiSelectOptions").find(":checkbox").removeAttr("disabled").removeAttr("checked");
								}
							
							}
						}
					});	
			break;
		case 2:
			var params=buildParams();
			if(params==false){return false;}
			//判断关键字是否已经存在
			var falg = '';
			var urlstr1=buildParamsSql('query','xmlattr','MPAttachPriceHth.existed','');
			urlstr1 += params;
			$.ajax({
				url:'mainServlet.html?'+urlstr1,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					/////////////////////////////
					//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
					$(xml).find('row').each(function(){
						//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
						///如果sql语句中指定列名 则按指定名称给参数
						var FeeCode = $(this).attr("FeeCode".toLowerCase());
						var FeeCodeh=$("#FeeCode_s").val();
						FeeCodeh=FeeCodeh.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
						if(FeeCode==FeeCodeh){
							var operationtips = $("#operationtips").text();
							//套餐类型和费用名称的组合已经存在，请重新输入！
							var IDDg = $("#FeeCodeg_s").text();
							var TypeIDg = $("#FeeTypeg_s").text();
							//alert(IDDg+" "+TypeIDg+"<fmt:message key='tariff.Portfolio'/><fmt:message key='tariff.isExist'/>",operationtips);
							alert(IDDg+" "+TypeIDg+"<fmt:message key='tariff.Portfolio'/><fmt:message key='tariff.isExist'/>");
							$("#FeeCode_s").focus();
							falg="false";
						}
					});
				}
			});
			if(falg=="false"){return false;}
			
			var urlstr=buildParamsSql('exe','xml','MPAttachPriceHth.add','');
			urlstr+=params;
					
					//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
					$.ajax({
					url:'mainServlet.html?'+urlstr,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
						success:function(msg){
							if(msg=="true"){
							var operationtips = $("#operationtips").val();
							var successful = $("#successful").val();
							alert(successful,operationtips);
							
							//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
							//写入日志操作
							var str =$("#FeeCodeg_s").html()+":"+$("#FeeCode_s").val()+";"+$("#FeeTypeg_s").html()+":"+$("#FeeType_s").val()+";"+$("#FeeNameg_s").html()+":"+$("#FeeName_s").val()+";"+$("#Priceg_s").html()+":"+$("#Price_s").val();
							logwrite(1,str);	
									
								if(saves==2){
									//fuheQuery();
									querylist(0);
									
								}else{
									closeflash=true;//表示关闭时需要刷新
									clearText('operformT2');
								}
							
							}
						}
					});	
			break;
	}
	
}
/**
 * jqgrid面板中，删除按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key 查询该条记录的第一个参数
 * @param key1  查询该条记录的第二个参数
 * @return 
 */
function deleteRow(key,key1){
	var deleteright = $("#deleteright").val();
	if(deleteright=="true"){   
		switch(tabStatus){
			case 1:
					//queryByID1(key);	
				 	var deleteinformation = $("#deleteinformation").val();
					var operationtips = $("#operationtips").val();
				 	jConfirm(deleteinformation,operationtips,function(x){
				 		 if(x==true){
				 		 	var urlstr1=buildParamsSql('exe','xml','MPAttachPrice.deleteByKey','');
							var urlstr='mainServlet.html?'+urlstr1+'&FeeCode='+key+'&FeeType='+tsd.encodeURIComponent(key1); 
							$.ajax({
								url:urlstr,
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
										var operationtips = $("#operationtips").val();
										var successful = $("#successful").val();
										alert(successful,operationtips);
										setTimeout($.unblockUI, 15);
										
										//写入日志操作
										//var logoldstr = $("#logoldstr").val();	
										//var oldstr = logoldstr.split(',');
										var str =$("#FeeCodeg").html()+":"+key+";"+$("#FeeTypeg").html()+":"+key1;
										logwrite(2,str);
										//fuheQuery();
										querylist(0);
									}	
								}
							});
						}
					});
				break;
			case 2:	
					//queryByID1(key);	
				 	var deleteinformation = $("#deleteinformation").val();
					var operationtips = $("#operationtips").val();
				 	jConfirm(deleteinformation,operationtips,function(x){
				 		 if(x==true){
				 		 	var urlstr1=buildParamsSql('exe','xml','MPAttachPriceHth.deleteByKey','');
							var urlstr='mainServlet.html?'+urlstr1+'&FeeCode='+key+'&FeeType='+tsd.encodeURIComponent(key1); 
							$.ajax({
								url:urlstr,
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(msg){
									if(msg=="true"){
										var operationtips = $("#operationtips").val();
										var successful = $("#successful").val();
										alert(successful,operationtips);
										setTimeout($.unblockUI, 15);
										
										//写入日志操作
										//var logoldstr = $("#logoldstr").val();	
										//var oldstr = logoldstr.split(',');
										var str =$("#FeeCodeg").html()+":"+key+";"+$("#FeeTypeg").html()+":"+key1;
										logwrite(2,str);
										//fuheQuery();
										querylist(0);
									}	
								}
							});
						}
					});
				break;
		}
	}else{
		var operationtips = $("#operationtips").val();
		var deletepower = $("#deletepower").val();	
		alert(deletepower,operationtips);
	}
}

/**
 * 修改面板中，修改按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param
 * @return 
 */
function modifyObj(){
	switch(tabStatus){
		case 1:
				var params=buildParams();
				if(params==false){return false;}
				//判断关键字是否已经存在
				if($("#H_FeeCode").val() != $("#FeeCode").val() || $("#H_FeeType").val() != $("#FeeType").val()){
					 Code = ',FeeType='+tsd.encodeURIComponent($("#FeeType").val());
					 //判断关键字是否已经存在
					/*
					var falg = '';
					var urlstr1=buildParamsSql('query','xmlattr','MPAttachPrice.existed','');
					urlstr1 += params;
					$.ajax({
						url:'mainServlet.html?'+urlstr1,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							/////////////////////////////
							//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
							$(xml).find('row').each(function(){
								//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
								///如果sql语句中指定列名 则按指定名称给参数
								var FeeCode = $(this).attr("FeeCode".toLowerCase());
								var FeeCodeh=$("#FeeCode").val();
								FeeCodeh=FeeCodeh.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
								if(FeeCode==FeeCodeh){
									var operationtips = $("#operationtips").text();
									//套餐类型和费用名称的组合已经存在，请重新输入！
									var IDDg = $("#FeeCodeg").text();
									var TypeIDg = $("#FeeTypeg").text();
									//alert(IDDg+" "+TypeIDg+"<fmt:message key='tariff.Portfolio'/><fmt:message key='tariff.isExist'/>",operationtips);
									alert(IDDg+" "+TypeIDg+"<fmt:message key='tariff.Portfolio'/><fmt:message key='tariff.isExist'/>");
									$("#FeeCode").focus();
									falg="false";
								}
							});
						}
					});
					if(falg=="false"){return false;}
					*/
				}else{
					Code = '';
				}
				
				var urlstr=buildParamsSql('exe','xml','MPAttachPrice.modify','');
			 	urlstr+=params;
				$.ajax({
					url:'mainServlet.html?'+urlstr+'&FeeType1='+tsd.encodeURIComponent($("#H_FeeType").val())+'&Code='+Code,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							//操作提示国际化
							var operationtips = $("#operationtips").val();
							//操作成功
							var successful = $("#successful").val();
							alert(successful,operationtips);
							/*************
							** 释放资源 **
							************/							
							setTimeout($.unblockUI, 15);
							
							//写入日志
							var logoldstr = $("#logoldstr").val();	
							var oldstr = logoldstr.split(',');
							//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
							var str =$("#FeeCodeg").html()+": "+$("#FeeCode").val()+";"+$("#FeeTypeg").html()+": "+$("#FeeType").val()+";"+$("#FeeNameg").html()+": "+oldstr[2]+">>>"+$("#FeeName").val()+";"+$("#Priceg").html()+": "+oldstr[3]+">>>"+$("#Price").val()+";"+$("#TjPriceg").html()+": "+oldstr[4]+">>>"+$("#TjPrice").val()+";"+$("#Bzg").html()+": "+oldstr[5]+">>>"+$("#nBz").attr("trueval");
									
							logwrite(3,str);
							//fuheQuery();
							querylist(0);
						}	
					}
				});
			break;
		case 2:
			 	var params = buildParams();
				if(params==false){return false;}
			 	//判断关键字是否已经存在
				if($("#H_FeeCode").val() != $("#FeeCode_s").val() || $("#H_FeeType").val() != $("#FeeType_s").val()){
					 Code = ',FeeType='+tsd.encodeURIComponent($("#FeeType_s").val());
					//判断关键字是否已经存在
					var falg = '';
					var urlstr1=buildParamsSql('query','xmlattr','MPAttachPriceHth.existed','');
					urlstr1 += params;
					$.ajax({
						url:'mainServlet.html?'+urlstr1,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							/////////////////////////////
							//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
							$(xml).find('row').each(function(){
								//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
								///如果sql语句中指定列名 则按指定名称给参数
								var FeeCode = $(this).attr("FeeCode".toLowerCase());
								var FeeCodeh=$("#FeeCode_s").val();
								FeeCodeh=FeeCodeh.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
								if(FeeCode==FeeCodeh){
									var operationtips = $("#operationtips").text();
									//套餐类型和费用名称的组合已经存在，请重新输入！
									var IDDg = $("#FeeCodeg_s").text();
									var TypeIDg = $("#FeeTypeg_s").text();
									//alert(IDDg+" "+TypeIDg+"<fmt:message key='tariff.Portfolio'/><fmt:message key='tariff.isExist'/>",operationtips);
									alert(IDDg+" "+TypeIDg+"<fmt:message key='tariff.Portfolio'/><fmt:message key='tariff.isExist'/>");
									$("#FeeCode_s").focus();
									falg="false";
								}
							});
						}
					});
					if(falg=="false"){return false;}
				}else{
					Code = '';
				}
			 			
				var urlstr=buildParamsSql('exe','xml','MPAttachPriceHth.modify','');
			 	urlstr+=params;
			 	
				$.ajax({
					url:'mainServlet.html?'+urlstr+'&FeeType1='+tsd.encodeURIComponent($("#H_FeeType").val())+'&Code='+Code,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							//操作提示国际化
							var operationtips = $("#operationtips").val();
							//操作成功
							var successful = $("#successful").val();
							alert(successful,operationtips);
							/*************
							** 释放资源 **
							************/							
							setTimeout($.unblockUI, 15);
							
							//写入日志
							var logoldstr = $("#logoldstr").val();	
							var oldstr = logoldstr.split(',');
							//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
							var str =$("#FeeCodeg").html()+": "+$("#FeeCode").val()+";"+$("#FeeTypeg").html()+": "+$("#FeeType").val()+";"+$("#FeeNameg").html()+": "+oldstr[2]+">>>"+$("#FeeName").val()+";"+$("#Priceg").html()+": "+oldstr[3]+">>>"+$("#Price").val();
									
							logwrite(3,str);
							//fuheQuery();
							querylist(0);
						}	
					}
				});
			break;
	}
}

/**
 * 进行通用查询 批量删除 批量修改入口；
 	根据隐藏域queryName 判断是何种操作 delete：批量删除 ；modify：批量修改；其他：高级查询
 * @param 
 * @return 
 */         
function fuheExe()
{
		var queryName= document.getElementById("queryName").value;
		if(queryName=="delete")
		{
			fuheDel();
		}
		else if(queryName=="modify")
		{
			fuheOpenModify();
		}
		else
		{
			fuheQuery();
		}
}
/**
 * 重新加载jQgrid数据
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key备用参数
 * @return 
 */
function querylist(key){
		//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
		$("#fusearchsql").val("");
		var link='';
		switch(tabStatus){
			case 1:
				var column = $("#ziduansF1").val();
				var urlstr=tsd.buildParams({ packgname:'service',//java包
											clsname:'ExecuteSql',//类名
											method:'exeSqlData',//方法名
											ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											tsdcf:'mssql',//指向配置文件名称
											tsdoper:'query',//操作类型 
											datatype:'xml',//返回数据格式 
											tsdpk:'MPAttachPrice.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											tsdpkpagesql:'MPAttachPrice.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
											
				link=urlstr+'&column='+column;
				break;
			case 2:	
				var column = $("#ziduansF2").val();	
				var urlstr=tsd.buildParams({ packgname:'service',//java包
										clsname:'ExecuteSql',//类名
										method:'exeSqlData',//方法名
										ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										tsdcf:'mssql',//指向配置文件名称
										tsdoper:'query',//操作类型 
										datatype:'xml',//返回数据格式 
										tsdpk:'MPAttachPriceHth.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										tsdpkpagesql:'MPAttachPriceHth.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
										});	
				link=urlstr+'&column='+column;
				break;
		}
		$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
		setTimeout($.unblockUI, 15);
		closeo();
}

/**
 * 高级查询操作，通过高级查询面板生成查询条件，查询和刷新jqgrid面板中的信息
 通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function fuheQuery()
{
		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
		if(params=='&fusearchsql='){
			params +='1=1';
		}			
		var column='';
		switch(tabStatus){
				case 1:
					column = $("#ziduansF1").val();
					break;
			case 2:
					column = $("#ziduansF2").val();
					break;
		}////switch end	
	 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'query',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:pkeys[tabStatus-1]+'.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									  tsdpkpagesql:pkeys[tabStatus-1]+'.fuheQueryByWherepage'
									});
		//alert(pkeys[tabStatus-1]+'.fuheQueryByWhere');
		var link = urlstr1 + params;
		column = column.replace(",Bz",",getMultiValues(Bz,'jhjid','jhjid','jhjname',',') Bz"); 
		//alert(link);	
	 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
	 	setTimeout($.unblockUI, 15);//关闭面板
	 	closeo();			
}

 /**
 * 批量删除操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function fuheDel()
{
		jConfirm("<fmt:message key='global.alert.del' />","<fmt:message key='global.operationtips'/>",function(x){
			if(x==true)
	 		{	
		 		var params = '&fusearchsql='+tsd.encodeURIComponent($("#fusearchsql").val());			
				if(params=='&fusearchsql='){
					params +='1=1';
				}									    
		 		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'exe',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:pkeys[tabStatus-1]+'.fuheDeleteBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  
											});
				var link='mainServlet.html?'+urlstr1+params; 
		 		$.ajax({
					url:link,
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							
							alert("<fmt:message key='global.successful' />","<fmt:message key='global.operationtips' />");
							setTimeout($.unblockUI, 15);
							//写入日志操作
							var str ="<fmt:message key='global.conditions'/> : "+$("#fusearchsql").val();
							str = transferApos(str);
							logwrite(4,str);
							//fuheQuery();
							querylist(0);
						}	
					}
				});
			}
		});		
}

 /**
 * 批量修改操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function fuheModify(){	
		var params = fuheQbuildParams();
		if(params == false){return false;}	
		var mparams = MbuildParams();
		if(mparams == false){return false;}	
		params += mparams;
		var urlstr=tsd.buildParams({ packgname:'service',//java包
									  clsname:'ExecuteSql',//类名
									  method:'exeSqlData',//方法名
									  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									  tsdcf:'mssql',//指向配置文件名称
									  tsdoper:'exe',//操作类型 
									  datatype:'xml',//返回数据格式 
									  tsdpk:pkeys[tabStatus-1]+'.fuheModifyBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									});
	 	urlstr+=params;
		$.ajax({
			url:'mainServlet.html?'+urlstr,
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(msg){
				if(msg=="true"){
					
					//写入日志操作
					$("#logoldstr").val();
					var str ="<fmt:message key='global.newVal'/> : "+$("#logoldstr").val()+"<fmt:message key='global.conditions'/> : "+$("#fusearchsql").val();
					str = transferApos(str);
					logwrite(5,str);
					var operationtips = $("#operationtips").val();
					var successful = $("#successful").val();
					alert(successful,'operationtips');
					setTimeout($.unblockUI, 15);
					fuheQuery();
				}	
			}
		});	
}


/**
 * 组合排序 
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param sqlstr 进行组合排序的排序sql子语句
 * @return 
 */
function zhOrderExe(sqlstr){
			var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
			params =params+'&orderby='+sqlstr;	
			////var params ='&orderby='+sqlstr;			    
	 		var urlstr1=tsd.buildParams({  packgname:'service',//java包
													  clsname:'ExecuteSql',//类名
													  method:'exeSqlData',//方法名
													  ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													  tsdcf:'mssql',//指向配置文件名称
													  tsdoper:'query',//操作类型 
													  datatype:'xml',//返回数据格式 
													  tsdpk:pkeys[tabStatus-1]+'.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													  tsdpkpagesql:pkeys[tabStatus-1]+'.queryByOrderpage'
			});
			var column='';
			switch(tabStatus){
	 			case 1:
						column = $("#ziduansF1").val();
						break;
				case 2:
						column = $("#ziduansF2").val();
						break;
			}////switch end			
			var link = urlstr1 + params;	
			
	 		$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
	 		//setTimeout($.unblockUI, 15);//关闭面板
}

/**
 * 打开简单查询面板  
 	通过tabStatus，来判断是在哪个选项卡进行的操作	
 * @param 
 * @return 
 */
function openQuery(){		
		markTable(1);//隐藏红色*号
		$(".top_03").html('<fmt:message key="global.query" />');//标题		
		switch(tabStatus){
			case 1:	
				removeDisabledN('attachprice','','');			
				openpan();
				$('#jdquery1').show();
				clearText('operformT1');
				$("#nBz").next(".multiSelectOptions").find(":checkbox").removeAttr("disabled").removeAttr("checked");			
				break;
			case 2:	
				removeDisabledN('attachprice_hth','','_s');
				openpan();
				$('#jdquery2').show();
				clearText('operformT2');				
				break;	
			}
 }


/**
 * jqgrid上新增按钮操作 ，弹出新增面板	
 	通过tabStatus，来判断是在哪个选项卡进行的操作	
 * @param 
 * @return 
 */
function openadd(){
		markTable(0);//显示红色*号
		$(".top_03").html('<fmt:message key="global.add" />');//标题	
		switch(tabStatus){			
			case 1:					
				removeDisabledN('attachprice','','');
				openpan();
				$("#save1").show();
	 			$("#readd1").show();
				clearText('operformT1');	
				$("#nBz").next(".multiSelectOptions").find(":checkbox").removeAttr("disabled").removeAttr("checked");			
				break;
			case 2:					
				removeDisabledN('attachprice_hth','','_s');
				openpan();
				$("#save2").show();
	 			$("#readd2").show();
	 			clearText('operformT2');
				break;	
			}
}
 /**
 * jqgrid上修改按钮操作 ，打开修改面板并加载将要修改的数据
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param key 查询该条记录的第一个参数
 * @param key1  查询该条记录的第二个参数
 * @return 
 */
function openRowModify(key,key1){	
	switch(tabStatus){
		case 1:
			var editright = $("#editright").val();
			if(editright=="true"){	
								
				markTable(0);//显示红色*号
				var editinfo = $("#editinfo").val();
			 	$(".top_03").html(editinfo);//设置编辑框的标题
				
				isDisabledN('attachprice','',''); //将修改面板的输入框全部	置为不可用
				openpan();//显示修改面板
				$("#modify1").show();$("#reset1").show();
				clearText('operformT1');//清空修改面板	
				$("#nBz").next(".multiSelectOptions").find(":checkbox").removeAttr("disabled").removeAttr("checked");
						
				queryByID(key,key1);//取出数据库中改条记录，并放到修改面板中				
				setTableFields();	
						
				$('#FeeCode').attr("disabled","disabled");
				$("#FeeCode").removeClass();
				$("#FeeCode").addClass("textclass2");
				//$('#FeeType').attr("disabled","disabled");
				//$("#FeeType").removeClass();
				//$("#FeeType").addClass("textclass2");
			}
			else{
				var operationtips = $("#operationtips").val();
				var editpower = $("#editpower").val();
				alert(editpower,operationtips);
			}
			break;			
		case 2:
			var editright = $("#editright").val();
			if(editright=="true"){	
				markTable(0);//显示红色*号
				var editinfo = $("#editinfo").val();
			 	$(".top_03").html(editinfo);//设置编辑框的标题				
			 		
				isDisabledN('attachprice_hth','','_s');//将修改面板的输入框全部	置为不可用
				openpan();//显示修改面板
				$("#modify2").show();$("#reset2").show();
				clearText('operformT2');//清空修改面板	
				queryByID(key,key1);				
				setTableFields();			
				
				$('#FeeCode_s').attr("disabled","disabled");
				$("#FeeCode_s").removeClass();
				$("#FeeCode_s").addClass("textclass2");
				//$('#FeeType_s').attr("disabled","disabled");
				//$("#FeeType_s").removeClass();
				//$("#FeeType_s").addClass("textclass2");				
			}
			else{
				var operationtips = $("#operationtips").val();
				var editpower = $("#editpower").val();
				alert(editpower,operationtips);
			}
			break;			
	}
}
/**
 *jqgrid上修改按钮操作 ，打开批量修改面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param  
 * @return 
 */
function fuheOpenModify(){
	switch(tabStatus){
		case 1:
				markTable(1);//隐藏红色*号
				$(".top_03").html('<fmt:message key="tariff.deleteb" />');//标题	
				
				isDisabledN('attachprice','',''); //将修改面板的输入框全部	置为不可用
				setTableFields();
				openpan();
				$("#modifyB1").show();
				clearText('operformT1');
				$("#nBz").next(".multiSelectOptions").find(":checkbox").removeAttr("disabled").removeAttr("checked");
				
				//设置不可批量修改字段的样式
			 	//FeeCode,FeeType 
				$('#FeeCode').attr("disabled","disabled");
				$("#FeeCode").removeClass();
				$("#FeeCode").addClass("textclass2");
				$('#FeeType').attr("disabled","disabled");
				$("#FeeType").removeClass();
				$("#FeeType").addClass("textclass2");		
			break;			
		case 2:
				markTable(1);//隐藏红色*号
				$(".top_03").html('<fmt:message key="tariff.deleteb" />');//标题					
							 	
				isDisabledN('attachprice_hth','','_s');//将修改面板的输入框全部	置为不可用	
				setTableFields();
				openpan();
				$("#modifyB2").show();
				clearText('operformT2');
				
				//设置不可批量修改字段的样式
			 	//FeeCode,FeeType 
				$('#FeeCode_s').attr("disabled","disabled");
				$("#FeeCode_s").removeClass();
				$("#FeeCode_s").addClass("textclass2");
				$('#FeeType_s').attr("disabled","disabled");
				$("#FeeType_s").removeClass();
				$("#FeeType_s").addClass("textclass2");
				break;	
	}
}


 /**
 * 根据简单查询输入条件进行简单查询
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param  
 * @return 
 */	
 function QbuildParams(){
		//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;				
	 	var params='';	
	   	switch(tabStatus){
			case 1:			
				//FeeCode	FeeType	FeeName	 Price	TjPrice	Bz
			 	var FeeCode = $("#FeeCode").val();	FeeCode=FeeCode.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 	var FeeType = $("#FeeType").val();	FeeType=FeeType.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 	var FeeName = $("#FeeName").val();	FeeName=FeeName.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 	var Price = $("#Price").val();		
			 	var TjPrice = $("#TjPrice").val();	
			 	var Bz = $("#nBz").attr("trueval");			Bz=Bz.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			  	
			  	var paramsStr='1=1 ';
			 	if(FeeCode!=''){
			 	 	paramsStr+="and FeeCode like '%"+FeeCode+"%' ";
			 	}
			 	if(FeeType!=''){
			 		paramsStr+="and FeeType like '%"+FeeType+"%' " ;
			 	}
			 	if(FeeName!=''){
			 		paramsStr+="and FeeName like '%"+FeeName+"%' " ;
			 	}
			 	if(Price!=''){
			 		
			 		if(isMoney(Price)){
			 			paramsStr+="and Price ="+Price+" " ;
			 		}
			 		else{
			 			//请输入数字，且小数位不要大于三位！
			 			alert($("#Priceg").html()+"<fmt:message key='MonthPrice.enternumber' />");
			 			$("#Price").focus();
			 			return false;
			 		}
			 	}
			 	if(TjPrice!=''){
			 		
			 		if(isMoney(TjPrice)){
			 			paramsStr+="and TjPrice ="+TjPrice+" " ;
			 		}
			 		else{
			 			//请输入数字，且小数位不要大于三位！
			 			alert($("#TjPriceg").html()+"<fmt:message key='MonthPrice.enternumber' />");
			 			$("#TjPrice").focus();
			 			return false;
			 		}
			 	}
			 	if(Bz!=''){
			 		Bz=tsd.encodeURIComponent(Bz);
			 		//paramsStr+="and Bz like '%"+Bz+"%' " ;
			 		paramsStr+="and dhlx like '%"+Bz+"%' " ;
			 	}
			 	
			 	$("#fusearchsql").val(paramsStr);
			 	fuheQuery();			
				break;			
			case 2:			
				//FeeCode	FeeType	FeeName	 Price	
			 	var FeeCode = $("#FeeCode_s").val(); 	FeeCode=FeeCode.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 	var FeeType = $("#FeeType_s").val();	FeeType=FeeType.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 	var FeeName = $("#FeeName_s").val();	FeeName=FeeName.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 	var Price = $("#Price_s").val();	
			 	var paramsStr='1=1 ';
			 	if(FeeCode!=''){
			 	 	paramsStr+="and FeeCode like '%"+FeeCode+"%' ";
			 	}
			 	if(FeeType!=''){
			 		paramsStr+="and FeeType like '%"+FeeType+"%' " ;
			 	}
			 	if(FeeName!=''){
			 		paramsStr+="and FeeName like '%"+FeeName+"%' " ;
			 	}
			 	if(Price!=''){
			 		if(isMoney(Price)){
			 			paramsStr+="and Price ="+Price+" " ;
			 		}
			 		else{
			 			//请输入数字，且小数位不要大于三位！
			 			alert($("#Priceg_s").html()+"<fmt:message key='MonthPrice.enternumber' />");
			 			$("#Price_s").focus();
			 			return false;
			 		}			 		
			 	}
			 	
			 	$("#fusearchsql").val(paramsStr);
			 	fuheQuery();				 	
				break;
		}	
}
 /**
 * 添加、修改面板，通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 	@oper 操作类型 modify|save 	
 * @param 
 * @return 
 */
function buildParams(){
	var operationtips = $("#operationtips").val();
   	switch(tabStatus){
		case 1:
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;				
		 	var params='';
			//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
		 	var FeeCode = $("#FeeCode").val();	FeeCode=FeeCode.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	var FeeType = $("#FeeType").val();	FeeType=FeeType.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	
		 	var FeeName = $("#FeeName").val();	FeeName=FeeName.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	var Price = $("#Price").val();
		 	var TjPrice = $("#TjPrice").val();
		 	var Bz = $("#nBz").attr("trueval");			Bz=Bz.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	
		 	//必填 int
		 	if(FeeCode!=null&&FeeCode!=""){
		  		if(subInt(FeeCode)==0){
		  			//alert($("#FeeCodeg").html()+"<fmt:message key='global.invalid'/>",operationtips);
		  			alert($("#FeeCodeg").html()+"<fmt:message key='global.invalid'/>");
		  			$("#FeeCode").focus();
		  			return false;
				}
		  		else{
		  			params=params+"&FeeCode="+FeeCode;
		  		}
		  	}else{
		  		
		  		alert("<fmt:message key='tariff.input'/>"+$("#FeeCodeg").html());
		  		$("#FeeCode").focus();
		  		return false;
		  	}
		  	
		  	FeeCode = parseInt(FeeCode,10);
		  	if(isNaN(FeeCode))
		  	{
		  		alert("<fmt:message key='MonthPrice.feenumber' />");
		  		$("#FeeCode").select().focus();
		  		return false;
		  	}
		  	if(!(FeeCode>0 && FeeCode<=50))
		  	{
		  		alert("<fmt:message key='MonthPrice.feenumberlimit' />");
		  		$("#FeeCode").select().focus();
		  		return false;
		  	}
		  	//必填 varchar
		 	if(FeeType!=null&&FeeType!=""){
		  		params=params+"&FeeType="+tsd.encodeURIComponent(FeeType);
		  	}else{
		  		
		  		alert("<fmt:message key='tariff.input'/>"+$("#FeeTypeg").html());
		  		$("#FeeType").focus();
		  		return false;
		  	}
		  	if(FeeType==null || FeeType==""){
		  		alert("<fmt:message key='MonthPrice.enterfeename' />");
		  		$("#FeeName").select().focus();
		  		return false;
		  	}
		  	params=params+"&FeeName="+tsd.encodeURIComponent(FeeName);		  	
		  	//money
		  	if(Price==null||Price==""){
		  		params=params+"&Price=0";
		  	}
		  	else{
		  		if(isMoney(Price)){
		 			params=params+"&Price="+Price;
		 		}
		 		else{
		 			//请输入数字，且小数位不要大于三位！
		 			alert($("#Priceg").html()+"<fmt:message key='MonthPrice.enternumber' />");
		 			$("#Price").focus();
		 			return false;
		 		}		  		
		  	}
		  	//money
		  	if(TjPrice==null||TjPrice==""){
		  		params=params+"&TjPrice=0";
		  	}
		  	else{
		  		if(isMoney(TjPrice)){
		 			params=params+"&TjPrice="+TjPrice;
		 		}
		 		else{
		 			//请输入数字，且小数位不要大于三位！
		 			alert($("#TjPriceg").html()+"<fmt:message key='MonthPrice.enternumber' />");
		 			$("#TjPrice").focus();
		 			return false;
		 		}
		  		
		  	}
		  	//int
		  	/*
		  	if(Bz==null||Bz==""){
		  		params=params+"&Bz=0";
		  	}
		  	else{
		  		params=params+"&Bz="+Bz;
		  	}		  	
		  	*/
		  	params=params+"&Dhlx="+tsd.encodeURIComponent(Bz);
		 	//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
			break;			
		case 2:
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;				
		 	var params='';
			//FeeCode	FeeType		FeeName	 Price	
		 	var FeeCode = $("#FeeCode_s").val(); 	FeeCode=FeeCode.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	var FeeType = $("#FeeType_s").val();	FeeType=FeeType.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	var FeeName = $("#FeeName_s").val();	FeeName=FeeName.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
		 	var Price = $("#Price_s").val();
		 	
		 	//必填 int
		 	if(FeeCode!=null&&FeeCode!=""){
		  		if(subInt(FeeCode)==0){
		  			//alert($("#FeeCodeg_s").html()+"<fmt:message key='global.invalid'/>",operationtips);
		  			alert($("#FeeCodeg_s").html()+"<fmt:message key='global.invalid'/>");
		  			$("#FeeCode_s").focus();
		  			return false;
				}
		  		else{
		  			params=params+"&FeeCode="+FeeCode;
		  		}
		  	}else{
		  		//alert("<fmt:message key='tariff.input'/>"+$("#FeeCodeg_s").html(),operationtips);
		  		alert("<fmt:message key='tariff.input'/>"+$("#FeeCodeg_s").html());
		  		$("#FeeCode_s").focus();
		  		return false;
		  	}
		  	FeeCode = parseInt(FeeCode,10);
		  	if(isNaN(FeeCode))
		  	{
		  		alert("<fmt:message key='MonthPrice.feenumber' />");
		  		$("#FeeCode_s").select().focus();
		  		return false;
		  	}
		  	if(!(FeeCode>0 && FeeCode<=50))
		  	{
		  		alert("<fmt:message key='MonthPrice.feenumberlimit' />");
		  		$("#FeeCode_s").select().focus();
		  		return false;
		  	}
		  	//必填 varchar
		 	if(FeeType!=null&&FeeType!=""){
		  		params=params+"&FeeType="+tsd.encodeURIComponent(FeeType);
		  	}else{
		  		//alert("<fmt:message key='tariff.input'/>"+$("#FeeTypeg_s").html(),operationtips);
		  		alert("<fmt:message key='tariff.input'/>"+$("#FeeTypeg_s").html());
		  		$("#FeeType_s").focus();
		  		return false;
		  	}
		  	//必填 varchar
		 	if(FeeName!=null&&FeeName!=""){
		  		params=params+"&FeeName="+tsd.encodeURIComponent(FeeName);
		  	}else{
		  		//alert("<fmt:message key='tariff.input'/>"+$("#FeeNameg_s").html(),operationtips);
		  		alert("<fmt:message key='tariff.input'/>"+$("#FeeNameg_s").html());
		  		$("#FeeName_s").focus();
		  		return false;
		  	}		  	
		  	//money
		  	if(Price==null||Price==""){
		  		params=params+"&Price=0";
		  	}
		  	else{
		  		if(isMoney(Price)){
		 			params=params+"&Price="+Price;
		 		}
		 		else{
		 			//请输入数字，且小数位不要大于三位！
		 			alert($("#Priceg_s").html()+"<fmt:message key='MonthPrice.enternumber' />");
		 			$("#Price_s").focus();
		 			return false;
		 		}		  		
		  	}	
		 	//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
			break;
	}
}
/**
 * 对修改面板，通过表单值构造数据操作参数
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function MbuildParams(){
	switch(tabStatus){
		case 1:
			 	//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
				//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
			 	var params='';
			 	
			 	var FeeName = $("#FeeName").val();  FeeName=FeeName.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 	var Price = $("#Price").val();		
			 	var TjPrice = $("#TjPrice").val();
			 	var Bz = $("#nBz").attr("trueval");			Bz=Bz.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 		
			 		var modifyStr="";
			 		var modifySet='set';
			 		
			 		if(FeeName!=""&&modifySet=="set"){
			 			modifySet+=' FeeName=\''+tsd.encodeURIComponent(FeeName)+'\'';
			 			modifyStr+=$("#FeeNameg").html()+": "+FeeName+';';
			 		}			 		
			 		if(Price!=""&&modifySet=="set"){
			 			if(isMoney(Price)){
				 			modifySet+=' Price='+Price;
			 				modifyStr+=$("#Priceg").html()+": "+Price+';';
				 		}
				 		else{
				 			//请输入数字，且小数位不要大于三位！
				 			alert($("#Priceg").html()+"<fmt:message key='MonthPrice.enternumber' />");
				 			$("#Price").focus();
				 			return false;
				 		}
			 			
			 		}
			 		else if(Price!=""&&modifySet!="set"){
			 			if(isMoney(Price)){
				 			modifySet+=', Price='+Price;
			 				modifyStr+=$("#Priceg").html()+": "+Price+';';
				 		}
				 		else{
				 			//请输入数字，且小数位不要大于三位！
				 			alert($("#Priceg").html()+"<fmt:message key='MonthPrice.enternumber' />");
				 			$("#Price").focus();
				 			return false;
				 		}
			 			
			 		}
			 		if(TjPrice!=""&&modifySet=="set"){
			 			if(isMoney(TjPrice)){
				 			modifySet+=' TjPrice='+TjPrice;
			 				modifyStr+=$("#TjPriceg").html()+": "+TjPrice+';';
				 		}
				 		else{
				 			//请输入数字，且小数位不要大于三位！
				 			alert($("#TjPriceg").html()+"<fmt:message key='MonthPrice.enternumber' />");
				 			$("#TjPrice").focus();
				 			return false;
				 		}
			 			
			 		}
			 		else if(TjPrice!=""&&modifySet!="set"){
			 			if(isMoney(TjPrice)){
				 			modifySet+=', TjPrice='+TjPrice;
			 				modifyStr+=$("#TjPriceg").html()+": "+TjPrice+';';
				 		}
				 		else{
				 			//请输入数字，且小数位不要大于三位！
				 			alert($("#TjPriceg").html()+"<fmt:message key='MonthPrice.enternumber' />");
				 			$("#TjPrice").focus();
				 			return false;
				 		}
			 			
			 		}
			 		Bz=tsd.encodeURIComponent(Bz);
			 		if(Bz!=""&&modifySet=="set"){
			 			modifySet+=' Bz='+Bz;
			 			modifyStr+=$("#Bzg").html()+": "+Bz+';';
			 		}
			 		else if(Bz!=""&&modifySet!="set"){
			 			modifySet+=', Bz='+Bz;
			 			modifyStr+=$("#Bzg").html()+": "+Bz+';';
			 		}
			 		if(modifySet=="set"){			 		
			 			//var operationtips = $("#operationtips").val();
						//alert("请输入修改内容!","操作提示")	
			 			alert('<fmt:message key="tariff.modifyinfo"/>','<fmt:message key="global.operationtips"/>');
			 			return false;
			 		}		
			 		$("#logoldstr").val(modifyStr); 		
			 		params+="&modifySet="+modifySet;	 
			 	   //注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
			 	    
				//每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
				return params;
				break;
			case 2:
				//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
				//FeeCode	FeeType		FeeName	 Price	TjPrice	Bz
			 	var params='';
			 	//var FeeCode = $("#FeeCode_s").val();
			 	//var FeeType = $("#FeeType_s").val();
			 	var FeeName = $("#FeeName_s").val(); 	FeeName=FeeName.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			 	var Price = $("#Price_s").val();
			 	
		 		var modifyStr="";
		 		var modifySet='set';
		 		
		 		if(FeeName!=""&&modifySet=="set"){
		 			modifySet+=' FeeName=\''+tsd.encodeURIComponent(FeeName)+'\'';
		 			modifyStr+=$("#FeeNameg_s").html()+": "+FeeName+';';
		 		}
		 		if(Price!=""&&modifySet=="set"){
		 				if(isMoney(Price)){
				 			modifySet+=' Price='+Price;
		 					modifyStr+=$("#Priceg_s").html()+": "+Price+';';
				 		}
				 		else{
				 			//请输入数字，且小数位不要大于三位！
				 			alert($("#Priceg_s").html()+"<fmt:message key='MonthPrice.enternumber' />");
				 			$("#Price_s").focus();
				 			return false;
				 		}
		 			
		 		}
		 		else if(Price!=""&&modifySet!="set"){
		 				if(isMoney(Price)){
				 			modifySet+=', Price='+Price;
		 					modifyStr+=$("#Priceg_s").html()+": "+Price+';';
				 		}
				 		else{
				 			//请输入数字，且小数位不要大于三位！
				 			alert($("#Priceg_s").html()+"<fmt:message key='MonthPrice.enternumber' />");
				 			$("#Price_s").focus();
				 			return false;
				 		}
		 			
		 		}
		 		if(modifySet=="set"){			 		
		 			//var operationtips = $("#operationtips").val();
					//alert("请输入修改内容!","操作提示")	
		 			alert('<fmt:message key="tariff.modifyinfo"/>','<fmt:message key="global.operationtips"/>');
		 			return false;
		 		}		
		 		$("#logoldstr").val(modifyStr); 		
		 		params+="&modifySet="+modifySet;	 
		 	   //注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
		 	    
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
			break;
		}
}


 /**
 * 高级查询参数获取
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function fuheQbuildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;
	 	var params='';
	 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());
	 	
	 	//如果有可能值是汉字 请使用encodeURI()函数转码
	 	params+='&fusearchsql='+fusearchsql;			 	
	 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
	 	//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}
 /**
 * 设弹出面板可编辑域
 	根据管理员在配置页面配置的信息解析
 * @param 
 * @return 
 */
function setTableFields(){
		switch(tabStatus){
				case 1:
						var editfields = $("#editfields").val();						
						/*************************************
						**   将当前表的所有字段取出来，分割字符串 ***
						*************************************/
						var fields = getFields("attachprice");
						var fieldarr = fields.split(",");
						/**********************************
						**   将当前表中的spower字段取出来 *****
						**********************************/
						var spower = editfields.split(",");
						/***************************
						**  考虑字段大小写问题   *****
						*************************/
						
						var atr = '';
						for(var i = 0 ; i <spower.length;i++){
							atr+=spower[i]+'@';	
						}
						var atrarr = atr.split('@');
						var arr = atrarr.sort();
						
						if(arr.length>0){
							for(var i=1;i<arr.length;i++){
								for(var j = 0 ; j <fieldarr.length-1;j++){
									if(arr[i]==fieldarr[j]){										
										$('#'+arr[i]).removeAttr("disabled");						
										$("#"+arr[i]).removeClass();
										$("#"+arr[i]).addClass("textclass");											
										break;
									}
								}
							}
						}	
					break;
				case 2:
					
					var editfields = $("#editfields_son").val();
					/*************************************
					**   将当前表的所有字段取出来，分割字符串 ***
					*************************************/
					var fields = getFields("attachprice_hth");
					var fieldarr = fields.split(",");
					/**********************************
					**   将当前表中的spower字段取出来 *****
					**********************************/
					var spower = editfields.split(",");
					/***************************
					**  考虑字段大小写问题   *****
					*************************/
					var atr = '';
					for(var i = 0 ; i <spower.length;i++){
						atr+=spower[i]+'@';	
					}
					var atrarr = atr.split('@');
					var arr = atrarr.sort();
					if(arr.length>0){
						for(var i=1;i<arr.length;i++){
							for(var j = 0 ; j <fieldarr.length-1;j++){
								if(arr[i]==fieldarr[j]){									
									$('#'+arr[i]+'_s').removeAttr("disabled");						
									$('#'+arr[i]+'_s').removeClass();
									$('#'+arr[i]+'_s').addClass("textclass");													
									break;
								}
							}
						}
					}	
					break;		
		}
			
}

/**
 * 页面上打印按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function PrintB(){
		switch(tabStatus){
			case 1:			
					printThisReport1('<%=request.getParameter("imenuid")%>','attachprice',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');			
					break;
			case 2:			
					printThisReport1('<%=request.getParameter("imenuid")%>','attachprice_hth',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
					break;			
		}
}
/**********************************************************
				function name:    logwrite(status,content)
				function:		  写入日志方法
				parameters:       str：操作的方式 1 添加 、2 删除 、3 修改、4 批量删除 、5 批量修改
								  code：写入日志表的内容
				return:			  返回 true 操作成功 false 操作失败
				description:      
********************************************************/
function logwrite(status,content){
		var table="";
		switch(tabStatus){
			case 1:
				table="(attachprice)";
				break;
			case 2:
				table="(attachprice_hth)";
				break;
		}
		tsd.QualifiedVal=true; 	
		switch(status){
			case 1:
			///增加
					writeLogInfo("","add",encodeURIComponent(table+"<fmt:message key='global.add' />。"+content));				
					break;
			case 2:
			///删除
					writeLogInfo("","delete",encodeURIComponent(table+"<fmt:message key='global.delete' />。"+content));
					break;			
			case 3:
			///修改
					writeLogInfo("","modify",encodeURIComponent(table+"<fmt:message key='global.edit' />。"+content));
					break;
			case 4:
			///批量删除
					writeLogInfo("","Bulk Delete",encodeURIComponent(table+"<fmt:message key='tariff.deleteb' />。"+content));
					break;
			case 5:
			///批量修改
					writeLogInfo("","Batch Edit",encodeURIComponent(table+"<fmt:message key='tariff.modifyb' />。"+content));
					break;
			}
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
}

</script>
<script type="text/javascript">

 /**
 * 关闭表格面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function closeo(){
		if(closeflash){
		 		 closeflash=false;
		 		 querylist(0);	
		 }
		 switch(tabStatus){
			case 1:
				clearText('operformT1');
				$("#nBz").next(".multiSelectOptions").find(":checkbox").removeAttr("disabled").removeAttr("checked");
				break;
			case 2:
				clearText('operformT2');
				break;
		}
		setTimeout($.unblockUI, 15);//关闭面板
				
}
 /**
 * 打开表格面板
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function openpan(){
	switch(tabStatus){
			case 1:				
				autoBlockFormAndSetWH('panTab1',60,5,'closeo1',"#ffffff",false,960,'');//弹出查询面板
				$("#jdquery1").hide();$("#modifyB1").hide();$("#readd1").hide();$("#save1").hide();$("#modify1").hide();$("#reset1").hide();$("#clearB1").hide();
				break;
			case 2:				
				autoBlockFormAndSetWH('panTab2',60,5,'closeo2',"#ffffff",false,960,'');//弹出查询面板		
				$("#jdquery2").hide();$("#modifyB2").hide();$("#readd2").hide();$("#save2").hide();$("#modify2").hide();$("#reset2").hide();$("#clearB2").hide();
				break;
	}		
}


 /**
 * 修改面板的取消按钮操作
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function resett(){
		var key='';
		var key1='';
		switch(tabStatus){
			case 1:
				key=$("#FeeCode").val();		key=key.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
				key1=$("#FeeType").val();		key1=key1.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
				break;
			case 2:
				key=$("#FeeCode_s").val();		key=key.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
				key1=$("#FeeType_s").val();		key1=key1.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
				break;
		}
		queryByID(key,key1);
}	
</script>
<script type="text/javascript">
/**
 * 页面上组合排序按钮操作，打开组合排序窗口
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function openwinO(){
		switch(tabStatus){
 			case 1:
					openDiaO('attachprice');
					break;
			case 2:
					openDiaO('attachprice_hth');
					break;
		}////switch end					
}
 /**
 * 高级查询、批量修改、批量删除打开查询窗口
 	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param str str打开窗口方法，query modify delete存放在隐藏域queryName
 * @return 
 */	
function openfuh(str){
		switch(tabStatus){
				case 1:
				openDiaQueryG(str,'attachprice','1');
				break;
			case 2:
				openDiaQueryG(str,'attachprice_hth','2');
				break;
		}////switch end	
}

/**
 * 打开将本查询保存问模板窗口
 * @param key 标识操作的表，1主表，2明细表 存放在隐藏域gridinfo
 * @return 
 */
function openSaveModT()
{	
	switch(tabStatus){
				case 1:
				openModT('attachprice','1');
				break;
			case 2:
				openModT('attachprice_hth','2');
				break;
	}////switch end	
}

 /**
 * 页面上高级查询按钮操作，打开查询窗口
 * @param 
 * @return 
 */	
function openwinQ()
{
		openfuh("query");
}
 /**
 * 页面上批量删除按钮操作，打开查询窗口
 * @param 
 * @return 
 */	
function openwinD()
{
		openfuh("delete");
}
 /**
 * 页面上批量修改按钮操作，打开查询窗口
 * @param
 * @return 
 */	
function openwinM()
{
		openfuh("modify");
}


/**
 * 查询模板保存面板中的保存按钮操作，用于保存本次查询为模板
	 通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function addQuery(){
	saveModQuery(tabStatus);
}
 /**
 * 模板查询按钮操作，弹出查询模板信息窗口，用户可根据该查看信息，选择已有查询模板进行查询
	 通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function modQuery(){	
	 openQueryM(tabStatus);
}
  /**
 *导出数据面板的导出按钮操作，
	通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param 
 * @return 
 */
function saveExoprt(){
		switch(tabStatus){
			case 1:			
					getTheCheckedFields('tsdBilling','mssql','attachprice');		
					break;
			case 2:	
					getTheCheckedFields('tsdBilling','mssql','attachprice_hth');
					break;
		}
 }
  /**
 *页面上导出按钮操作
	  通过tabStatus，来判断是在哪个选项卡进行的操作
 * @param
 * @return 
 */
 function openExport(){
 		switch(tabStatus){
			case 1:			
					thisDownLoad('tsdBilling','mssql','attachprice','<%=languageType %>');				
					break;
			case 2:			
					thisDownLoad('tsdBilling','mssql','attachprice_hth','<%=languageType %>');	
					break;			
		}
 }
</script>
<script type="text/javascript">
			/**
			 *初始化设置资费设置jqgrid头部导航条
			 * @param
			 * @return 
			 */
			jQuery(document).ready(function(){
					//获取系统语言标识
					var languageType = $("#languageType").val();
					//获取本菜单id
					var imenuid = $('#imenuid').val();
					//获取组信息
					var groupid = $('#zid').val();
					//获取菜单并解析
					getTariffBar(languageType,imenuid,'CallType.getNavigator',groupid);
			});
</script>


<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
</style> 
</head>

<body> 

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
		
	<div id="zong" >
		<!-- 资费设置导航条-->
		<div id="tariffBar" style="font-size: 14px; text-align: left;"></div>
		
		<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="openorder1" onclick="openwinO();">
				<!--排序--><fmt:message key="order.title" />
			</button>		
			<button type="button" id="openadd1" onclick="openadd();" disabled="disabled">
				<!--添加--><fmt:message key="global.add" />
		    </button>	  
			<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='modQuery();' id='mbquery1'>
				<fmt:message key="oper.mod"/>
			</button>
			<button type="button" id='gjquery1' onclick="openwinQ();" disabled="disabled">
				<!--高级查询--><fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='savequery1' onclick="openSaveModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button>
			 <button type="button" id="opendel1" onclick="openwinD();" disabled="disabled">
				<!--批量删除--><fmt:message key="tariff.deleteb" />
			</button>
			 <button type="button" id="openmod1" onclick="openwinM();" disabled="disabled">
				<!--批量修改--><fmt:message key="tariff.modifyb" />
			</button>
			<button type="button" id="export1" onclick="openExport();" disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>
			<!--打印					
			<button type="button" id="print1" onclick="PrintB();" disabled="disabled">
				<fmt:message key="tariff.printer" />
			</button> 
			-->  
		</div>
		
		<!-- Tabs start -->
		<div id="tabs">	
			<ul>
				<li><a href="#gridd" onclick="tabsChg(1)"><span><fmt:message key='MonthPhone.phone' /></span></a></li>
				<li><a href="#gridd" onclick="tabsChg(2)"><span><fmt:message key='MonthPhone.contract' /></span></a></li>
			</ul>
			<div id="gridd">
			    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
				<div id="pagered" class="scroll" style="text-align: left;"></div>
			</div>		
		</div>
		<!-- Tabs  end-->
		
		<!-- 用户操作标题以及放一些快捷按钮-->
		<div id="buttons">
			<button type="button" id="openorder2" onclick="openwinO();">
				<!--排序--><fmt:message key="order.title" />
			</button>
			<button type="button" id="openadd2" onclick="openadd();" disabled="disabled">
				<!--添加--><fmt:message key="global.add" />
		    </button>
		   	<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='modQuery();' id='mbquery2'>
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button type="button" id='gjquery2' onclick="openwinQ();" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='savequery2' onclick="openSaveModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button>
			 <button type="button" id="opendel2" onclick="openwinD();" disabled="disabled">
				<!--批量删除--><fmt:message key="tariff.deleteb" />
			</button>
			 <button type="button" id="openmod2" onclick="openwinM();" disabled="disabled">
				<!--批量修改--><fmt:message key="tariff.modifyb" />
			</button>
			<button type="button" id="export2" onclick="openExport();" disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>
			<!--打印
			<button type="button" id="print2" onclick="PrintB();" disabled="disabled">
				<fmt:message key="tariff.printer" />
			</button>
			-->
		</div>
</div>



<!-- 添加模板面板 -->
<div id="modT" name='modT' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="MonthPrice.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoMod()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='addquery' name="addquery" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="name_mod" id="name_mod" onpropertychange="TextUtil.NotMax(this)" maxlength="50" class="textclass"/>
				    	<font style="color: #ff0000;">*</font></td>
				    
				    <td width="12%" align="right" class="labelclass"><label id=''></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
									    
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>			    	
			 	 </tr>		  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="addQuery();" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>	


<!-- 添加修改面板 read1 -->
<div class="neirong" id="panTab1" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="MonthPrice.functionname" /></div>
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
			    <td width="12%" align="right" class="labelclass"><label id="FeeCodeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="FeeCode" id="FeeCode" style="ime-mode: Disabled;" onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="4" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" class="textclass"></input>							
					<label class="addred" ></label></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="FeeTypeg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="FeeType" id="FeeType" onpropertychange="TextUtil.NotMax(this)" maxlength="40" class="textclass"></input>
			    	<label class="addred" ></label></td>
			
		  		<td width="12%" align="right" class="labelclass"><label id="FeeNameg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="FeeName" id="FeeName" onpropertychange="TextUtil.NotMax(this)" maxlength="40" class="textclass"/>
				  	<label class="addred" ></label>
				</td>
			</tr>
		  	<tr>	  	
				<td width="12%" align="right" class="labelclass"><label id="Priceg"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Price" id="Price" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" class="textclass"/></td>
			     
			    <td width="12%" align="right" class="labelclass"><label id="TjPriceg"  ></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="TjPrice" id="TjPrice" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" class="textclass"/></td>
								    
			    <td width="12%" align="right" class="labelclass"><!-- <label id="Bzg"  ></label> --><label id="Dhlx"  ></label></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
	    			<select id="bzBugFixer1" style="display:none">
						<option value="111"><fmt:message key="MonthPrice.solveconflict" /></option>
					</select>
					<select name="nBz" id="nBz" class="textclass"></select>
		    		</td>	    	
		    </tr>	
		  
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery1" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
		<!-- 批量修改 --><button class="tsdbutton" id="modifyB1" style="width:80px;heigth:27px;" onclick="fuheModify();"><fmt:message key="tariff.modifyb" /></button>
		<!-- 保存新增 --><button class="tsdbutton" id="readd1" style="width:80px;heigth:27px;" onclick="saveObj(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save1" style="width:80px;heigth:27px;" onclick="saveObj(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify1" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB1" style="width:63px;heigth:27px;" onclick="clearText('operformT1');$('#nBz').next('.multiSelectOptions').find(':checkbox').removeAttr('disabled').removeAttr('checked');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset1" style="width:63px;heigth:27px;" onclick="resett();" ><fmt:message key="MonthPrice.cancel" /></button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo1" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>

<!-- 添加修改面板  ready2-->
<div class="neirong" id="panTab2" style="display: none">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" ><fmt:message key="MonthPrice.functionname" /></div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeo()"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='operformT2' name="operformT2" onsubmit="return false;" action="#" >
		<input type="hidden" ></input>
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  <tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="FeeCodeg_s" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="FeeCode_s" id="FeeCode_s" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=48&&k<=57" maxlength="4" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" class="textclass"></input>							
					<label class="addred" ></label></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="FeeTypeg_s"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="FeeType_s" id="FeeType_s" onpropertychange="TextUtil.NotMax(this)" maxlength="16" class="textclass"></input>
			    	<label class="addred" ></label></td>			
			
			    <td width="12%" align="right"  class="labelclass"><label id="FeeNameg_s"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="FeeName_s" id="FeeName_s" onpropertychange="TextUtil.NotMax(this)" maxlength="16" class="textclass"/>
				  	<label class="addred" ></label></td>					  
			</tr>		  
		  	<tr>
			    <td width="12%" align="right" class="labelclass"><label id="Priceg_s"></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Price_s" id="Price_s" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="8" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return false" class="textclass"/></td>
			   
			    <td width="12%" align="right"  class="labelclass"></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
								    
			    <td width="12%" align="right"  class="labelclass"></td>
		    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>	    	
		    	
		 	 </tr>		  
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery2" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
		<!-- 批量修改 --><button class="tsdbutton" id="modifyB2" style="width:80px;heigth:27px;" onclick="fuheModify();"><fmt:message key="tariff.modifyb" /></button>
		<!-- 保存新增 --><button class="tsdbutton" id="readd2" style="width:80px;heigth:27px;" onclick="saveObj(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save2" style="width:80px;heigth:27px;" onclick="saveObj(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify2" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB2" style="width:63px;heigth:27px;" onclick="clearText('operformT1');$('#nBz').next('.multiSelectOptions').find(':checkbox').removeAttr('disabled').removeAttr('checked');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset2" style="width:63px;heigth:27px;" onclick="resett();" ><fmt:message key="MonthPrice.cancel" /></button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo2" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>


	<!-- typtDemoModify  表单输入区域  -->
	
	
<form name="childform" id="childform">
	<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
	<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
</form>

<input type="hidden" id="useridd" value="<%=userid %>"/>
<!-- 语言 -->
<input type="hidden" id="lanType" name="lanType" value='<%=lanType %>' />

<input type="hidden" id="skrid" name="skrid" value='<%=request.getSession().getAttribute("userid") %>' />

<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 

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
					<input type="hidden" id="editfields_son"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editBright"/>
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />
					<!-- 存储sql语句查询部分 -->
					<input type="hidden" id="thecolumn" />
					
					<!--写日志 -->
					<input type="hidden" id="logoldstr" />
				
					<input type="hidden" id="mptitle" value="<%=imenuname %>"/>
					<!-- 打印报表 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
					
					<!-- 高级查询 模板隐藏域 -->
					<input type="hidden" id="queryright"/>
					<input type="hidden" id="queryMright"/>
					<input type="hidden" id="saveQueryMright"/>	
					<!-- 查询树信息存放 -->
					<input type="hidden" id='treepid' />	
					<input type="hidden" id='treecid' />	
					<input type="hidden" id='treestr' />	
					<input type="hidden" id='treepic' />	
					<!-- grid自动 -->
					<input type="hidden" id='ziduansF1' />
					<input type="hidden" id='ziduansF2' />
					<input type='hidden' id='thecolumn'/>
					<!-- 用于主键判断 -->
					<input type='hidden' id='H_FeeCode'/>
					<input type='hidden' id='H_FeeType'/>
										

		
			<!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv"><fmt:message key="MonthPrice.chooseexportdata" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="MonthPrice.close" /></a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<div id="thelistform" style="margin-left: 10px;max-height: 200px">
								
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields();">
						<fmt:message key="MonthPrice.selectall" />
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="saveExoprt();">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
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
