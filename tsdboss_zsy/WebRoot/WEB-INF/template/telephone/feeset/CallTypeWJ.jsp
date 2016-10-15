<%----------------------------------------
	name: CallTypeWJ.jsp
	author: youhongyu
	version: 1.0, 2010-10-11
	description: 定义网间结算呼叫类型
	modify: 
		2009-11-26 youhongyu 添加注释功能	
		2010-12-10 liwen  :   查询新增时 基本费转移至呼叫类型 由原来的文本输入框换成下拉框
		2010-12-15 youhongyu   修改本查询为模板功能，使其能区分本次要保存的查询内容是来自哪个表
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
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
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
    	<title><fmt:message key="tariff.wangjianjiesuan" /></title><!--定义网间结算呼叫类型-->
    	
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
			
		<script type="text/javascript">
			
			/**
			 * 查看当前用户的扩展权限，对spower字段进行解析
			 * @param 
			 * @return 
			 */
			function getUserPower(){
				 var urlstr=tsd.buildParams({ 	  packgname:'service',
							 					  clsname:'Procedure',
												  method:'exequery',
							 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 					  tsdpname:'CallTypeWJ.getPower',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
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
				var exportright = '';
				var printright ='';
				
				var deleteright = '';
				var editright = '';
				var queryright = '';				
				var queryMright = '';
				var saveQueryMright ='';
				
				var editfields = '';
				var editfields_son='';
				
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
						
						$("#queryright").val(str);						
						$("#queryMright").val(str);
						$("#saveQueryMright").val(str);
						
						$("#exportright").val(str);
						$("#printright").val(str);
						//var languageType = $("#languageType").val();
						editfields = getFields('call_type_num_wj');
						editfields_son = getFields('call_type_wj');
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
</script>
<script type="text/javascript">		
				
				/**
				 * 将定义网间结算呼叫类型弹出面板输入框设置为可用
				 * @param 
				 * @return 
				 */
				function removeDisabled(){
					var fields = getFields("call_type_num_wj");
					var fieldarr = fields.split(",");					
					for(var j = 0 ; j <fieldarr.length-1;j++){
						$('#'+fieldarr[j]).removeAttr("disabled");
					}
				}
								
				/**
				 * 将定义网间结算呼叫类型弹出面板输入框设置为不可用
				 * @param 
				 * @return 
				 */
				function isDisabled(){
					var fields = getFields("call_type_num_wj");
					var fieldarr = fields.split(",");
					for(var j = 0 ; j <fieldarr.length-1;j++){
						$('#'+fieldarr[j]).attr("disabled","disabled");
					}
				}
				/**
				 * 将定定义网间结算呼叫类型明细弹出面板输入框设置为可用
				 * @param 
				 * @return 
				 */
				function removeDisabled_son(){
					var fields = getFields("call_type_wj");
					var fieldarr = fields.split(",");					
					for(var j = 0 ; j <fieldarr.length-1;j++){
						$('#'+fieldarr[j]).removeAttr("disabled");
					}
					$('#Call_Type_son').removeAttr("disabled");
				}
				
				/**
				 * 将定定义网间结算呼叫类型明细明细弹出面板输入框设置为不可用
				 * @param 
				 * @return 
				 */
				function isDisabled_son(){
					var fields = getFields("call_type_wj");
					var fieldarr = fields.split(",");
					for(var j = 0 ; j <fieldarr.length-1;j++){
						$('#'+fieldarr[j]).attr("disabled","disabled");
					}
					$('#Call_Type_son').attr("disabled","disabled");
				}
			
			/**
			 * 判断输入的字符是否为数字或三位小数以内小数 
			 * @param val：要进行判断的字符串
			 * @return true：符合  false：不符合
			 */
			 function isDecimal(val)    
			 {    
			     var str = val;   
			     if(str.length!=0){   
			         reg=/^[-\+]?\d+(\.?\d{0,3})$/;   
					 if(!reg.test(str)){   
					    return false;
					 }   
			      }  
			      return true; 
			 }
			 
			/**
			*	查询新增时 基本费转移至呼叫类型 下拉框里的值
			*   @param 
			*   @return 
			*/	   
			function getJbfzy() {
				var urlstr=buildParamsSqlByS('tsdBilling','query','xmlattr','CallTypeNumWJ.queryJbfzy','');						
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
                   				var area="<option value='"+$(this).attr("Call_Type".toLowerCase())+"'>"+$(this).attr("Call_Type".toLowerCase())+"</option>";
								$("#Jbfzy").html($("#Jbfzy").html()+area);
							});
					}
				});
			}
			
		/**
		 * 页面初始化
		 * @param 
		 * @return 
		 */
		jQuery(document).ready(function () {			
			/**********************
			**   取得当前用户的权限  *
			**********************/
			getUserPower();
			/*********************************
			*  用户权限判定，初始化用户可操作权限 *
			*******************************/
			/*********************************
			** 获取基本费转移至呼叫类型 下拉框里的值*
			*********************************/
			getJbfzy();
			
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
				document.getElementById("gjquery3").disabled=false;
				document.getElementById("gjquery4").disabled=false;
			}		
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
				document.getElementById("savequery3").disabled=false;
				document.getElementById("savequery4").disabled=false;
			}			
			
			if(addright=="true"){
				document.getElementById("openadd1").disabled=false;
				document.getElementById("openadd2").disabled=false;
				document.getElementById("openadd3").disabled=false;
				document.getElementById("openadd4").disabled=false;
			}
			if(delBright=="true"){
				document.getElementById("opendel3").disabled=false;
				document.getElementById("opendel4").disabled=false;
			}
			if(editBright=="true"){
				document.getElementById("openmod3").disabled=false;
				document.getElementById("openmod4").disabled=false;
			}
			if(exportright=="true"){
				document.getElementById("export1").disabled=false;
				document.getElementById("export2").disabled=false;
				document.getElementById("export3").disabled=false;
				document.getElementById("export4").disabled=false;
			}
			if(printright=="true"){
				//document.getElementById("print1").disabled=false;
				//document.getElementById("print2").disabled=false;
				//document.getElementById("print3").disabled=false;
				//document.getElementById("print4").disabled=false;
			}
			
			//获取主表数据表对应字段国际化信息
			var thisdata = loadData('call_type_num_wj','<%=languageType %>',1);
			
			var col=[[],[]];
			col=getRb_Field('call_type_num_wj','Call_Type',"<fmt:message key='CallTypeWJ.modifydeletedetail' />",'97','ziduansF1');//得到jqGrid要显示的字段
			var column = $("#ziduansF1").val();
			
			var Call_Typeg = thisdata.getFieldAliasByFieldName('Call_Type');
			var Jbfzyg = thisdata.getFieldAliasByFieldName('Jbfzy');
			var Yhlg = thisdata.getFieldAliasByFieldName('Yhl');
			
			/***给页面添加面板标签赋值**/
			$("#Call_Typeg").html(Call_Typeg);
			$("#Jbfzyg").html(Jbfzyg);
			$("#Yhlg").html(Yhlg);
			/////设置主表命令参数
				var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'CallTypeNumWJ.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'CallTypeNumWJ.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
			var navv = document.location.search;
			var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));
			jQuery("#editgrid").jqGrid({
				/*执行存储过程---------------- 
				tsdpname：可以调用其他存储过程，
				注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
				ds：对应applicationContent.xml里配置的数据源 
				*/   
				height:130, //高
				url:'mainServlet.html?'+urlstr+'&column='+column,
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1], 
				       	rowNum:5, //默认分页行数
				       	rowList:[5,10,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Call_Type', //默认排序字段
				       	viewrecords: true, 
				       	multiselect: false,
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:infoo, 
				        width:document.documentElement.clientWidth-40,
				       	loadComplete:function(){
				       					//查询后，默认选中第一条
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										
										//如果主表查询无记录，则要清掉明细表记录			
										if($("#editgrid").getGridParam('records')==0)
										{
										  $("#editgrid_son").setGridParam({url:"mainServlet.html?"+urlstr_son+"&Call_Type=''"}).trigger('reloadGrid');
										}
										///自动适应 工作空间
										//var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										//sAutoGridHeight("editgrid",reduceHeight);
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
										addRowOperBtnimage('editgrid','openRowModify','Call_Type','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
										addRowOperBtnimage('editgrid','deleteRow','Call_Type','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openRowInfo','Call_Type','click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='CallTypeWJ.detail' />","&nbsp;&nbsp;&nbsp;");//详细
										
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换
										addRowOperBtn('editgrid',editinfo,'openRowModify','Call_Type','click',1);
										addRowOperBtn('editgrid',deleteinfo,'deleteRow','Call_Type','click',2);
										*/
										executeAddBtn('editgrid',3);
										readyMingxi();
										},
										//选择grid种的一列触发方法，根据这列种的Call_Type的值来查询加载editgrid_son表
										onSelectRow: function(ids) {
												//ids是返回的rowid,然后根据它再返回meetid	 
												reLoadMingxi(ids);									 
										},
										ondblClickRow: function(ids) {
											if(ids != null) {
												var Call_Type =$("#editgrid").getCell(ids,"Call_Type");
												openRowInfo(Call_Type);
											}
										}
									
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		
				reLoadMingxi(0);
			});
			
			
/**
 * 定义网间结算呼叫类型jqgrid面板查看明细按钮，查看网间结算呼叫类型详细信息
 * @param key 每条信息查看表识 字段Call_Type的值
 * @return 
 */
function openRowInfo(key){
		markTable(0);//显示红色*号		
	 	$(".top_03").html('<fmt:message key="CallTypeWJ.detailmessage" />');//设置编辑框的标题		
		isDisabledN('call_type_num_wj','',''); //将修改面板的输入框全部	置为不可用
		$("#gridinfo").val(1);
		openpan();//显示修改面板	
		clearText('operformT1');//清空修改面板								
		queryByID(key);
}


/**
 * 加载明细表信息 根据网间结算呼叫类型的信息显示该网间结算呼叫类型明细
 * @param ids 网间结算呼叫类型jqgrid行标识，
 * @return 
 */
function reLoadMingxi(ids){
		if(ids != null) {			
							var meetid='';
							meetid=$("#editgrid").getCell(ids,"Call_Type");	
							$("#meetid").val(meetid);
							
							var str =" 1=1 and Call_Type='"+meetid+"' ";
							$("#querysql_son").val(str);
									
							//readyMingxi();
							var urlstr_son=buildParamsSqlByS('tsdCDR','query','xml','CallTypeWJ.query','CallTypeWJ.querypage');
							meetid=tsd.encodeURIComponent(meetid);	
							var column = $("#ziduansF2").val();	
							$("#editgrid_son").setGridParam({url:"mainServlet.html?"+urlstr_son+"&Call_Type="+meetid+'&column='+column}).trigger('reloadGrid');			
						}
}

/**
 * 在grid中展示网间结算呼叫类型明细表信息
 * @param ids 显示网间结算呼叫类型jqgrid行标识，
 * @return 
 */
function readyMingxi(){
			//获取主表数据表对应字段国际化信息		
			var thisdata = loadData('call_type_wj','<%=languageType %>',1);
			
			var col=[[],[]];
			col=getRb_Field('call_type_wj','Bjzg',"<fmt:message key='CallTypeWJ.modifydeletedetail' />",'97','ziduansF2','NetName');//得到jqGrid要显示的字段
			
			var Bjzgg = thisdata.getFieldAliasByFieldName('Bjzg');
			var NetNameg = thisdata.getFieldAliasByFieldName('NetName');
			var Call_Typeg = thisdata.getFieldAliasByFieldName('Call_Type');			
			
			/***给页面中存储字段的隐藏标签赋值**/
			//添加面板			
			$("#Bjzgg_son").html(Bjzgg);
			$("#Call_Typeg_son").html(Call_Typeg);
			$("#NetNameg_son").html(NetNameg);
			//$("#Numg_son").html(Numg);
			var urlstr_son=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'CallTypeWJ.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'CallTypeWJ.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});	
			var navv = document.location.search;
			var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));		
			jQuery("#editgrid_son").jqGrid({
				/*执行存储过程---------------- 
				tsdpname：可以调用其他存储过程，
				注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
				ds：对应applicationContent.xml里配置的数据源 
				*/   
				//url:'mainServlet.html?'+urlstr_son+"&Call_Type="+params,//,
				height:250, //高
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1], 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered_son'), 
				       	sortname: 'Bjzg', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:infoo+'<fmt:message key="tariff.sublist"/>', 
				        width:document.documentElement.clientWidth-40,
				       	loadComplete:function(){
				       					//查询后，默认选中第一条
										$("#editgrid_son").setSelection('0', true);
										$("#editgrid_son").focus();
										
										///自动适应 工作空间
										//var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered_son").height();
										//setAutoGridHeight("#editgrid_son",reduceHeight);
										//setAutoGridWidth("editgrid",'0');
										/*********定义需要的行链接按钮************
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	
										////@7  这张表有两个关键字，这个位置的值是第二个关键字*/
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										addRowOperBtnimage('editgrid_son','openRowModify_son','Bjzg','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'NetName');//修改
										addRowOperBtnimage('editgrid_son','deleteRow_son','Bjzg','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;",'NetName');//删除
										addRowOperBtnimage('editgrid_son','openRowInfo_son','Bjzg','click',3,'style/images/public/ltubiao_03.gif',"<fmt:message key='CallTypeWJ.detail' />","&nbsp;&nbsp;&nbsp;",'NetName');//详细
										
									   /****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换
										addRowOperBtn('editgrid_son',editinfo,'openRowModify_son','Bjzg','click',1,'NetName');
										addRowOperBtn('editgrid_son',deleteinfo,'deleteRow_son','Bjzg','click',2,'NetName');
										*/
										executeAddBtn('editgrid_son',3);
										},
										ondblClickRow: function(ids) {
											if(ids != null) {
												var Bjzg =$("#editgrid_son").getCell(ids,"Bjzg");
												var NetName =$("#editgrid_son").getCell(ids,"NetName");
												openRowInfo_son(Bjzg,NetName);
											}
										}
				}); 
			}
/**
 * 查看网间结算呼叫类型明细详细信息
 * @param key 每条信息查看表示 字段Bjzg的值
 * @param key1 每条信息查看表示 字段NetName的值
 * @return 
 */
function openRowInfo_son(key,key1){
		markTable(0);//显示红色*号		
	 	$(".top_03").html('<fmt:message key="CallTypeWJ.detailmessage" />');//设置编辑框的标题		
		isDisabledN('Call_Type','','_son'); //将修改面板的输入框全部	置为不可用
		$("#gridinfo").val(2);
		openpan();//显示修改面板	
		clearText('operformT2');//清空修改面板								
		queryByID_son(key,key1);				
}
/**
 * 从网间结算呼叫类型，取出一条数据显示在addform面板
 * @param key 每条信息查看表示 字段Call_Type的值
 * @return 
 */
function queryByID(key){
 		 	$("#Call_Type").val(key);				 
			var urlstr=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xmlattr',//返回数据格式 
										  tsdpk:'CallTypeNumWJ.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										});		 					
			//key=$("#ID").val();
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&Call_Type='+tsd.encodeURIComponent(key),
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
						//将数据库中值赋值到修改页面上对应的文本框里
						var oldstr=[];
						var Call_Type = $(this).attr("Call_Type".toLowerCase());							
						$("#Call_Type").val(Call_Type);
						oldstr.push(Call_Type);
						var Jbfzy = $(this).attr("Jbfzy".toLowerCase());
						$("#Jbfzy").val(Jbfzy);
						oldstr.push(Jbfzy);
						var Yhl = $(this).attr("Yhl".toLowerCase());
						$("#Yhl").val(Yhl);	
						oldstr.push(Yhl);
						$("#logoldstr").val(oldstr);
						//$("#ID").attr("disabled","disabled");
						//存放呼叫类型，用于修改的时候判断是否更改了，一般操作子表
						$("#CallTypeM").val(Call_Type);
					});
				}
			});
}


/**
 * 从网间结算呼叫类型明细，取出一条数据显示在addform面板
 * @param key 每条信息查看表示 字段Bjzg的值
 * @param key1 每条信息查看表示 字段NetName的值
 * @return 
 */
function queryByID_son(key,key1){ 
 		 	$("#NetName_son").val(key1);
			$("#Bjzg_son").val(key);
			var urlstr=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xmlattr',//返回数据格式 
										  tsdpk:'CallTypeWJ.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										});		 					
			//key=$("#ID").val();
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&Bjzg='+tsd.encodeURIComponent(key)+'&NetName='+tsd.encodeURIComponent(key1),
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
						//将数据库中值赋值到修改页面上对应的文本框里
						var oldstr=[];
						var Call_Type = $(this).attr("Call_Type".toLowerCase());							
						$("#Call_Type_son").val(Call_Type);
						oldstr.push(Call_Type);
						$("#logoldstr").val(oldstr);
						//var Num = $(this).attr("Num");
						//$("#Num_son").val(Num);
						});
				}
			});
}

var closeflash = false;//用于判断添加操作是保存新增，或保存退出。保存新增closeflash=true ；保存退出=false

/**
 * 对网间结算呼叫类型进行保存操作
 * @param saves 判断保存类型 1：保存新增 ；2保存退出
 * @return 
 */
function saveObj(saves){
			/***************
			**判断添加信息是否满足要求
			**************/
			var params=buildParams();
			if(params==false){return false;}
			/****************************************
			*   是否是可输入关键字是否已经存在，Num  *
			****************************************/
			var Call_Type = $("#Call_Type").val();
			Call_Type=Call_Type.replace(/(^\s*)|(\s*$)/g,"");//去掉字符串左右空格
			var urlstr=tsd.buildParams({
					packgname:'service',//java包
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
					tsdcf:'mssql',//指向配置文件名称
					tsdoper:'query',//操作类型
					datatype:'xmlattr',//返回数据格式
					tsdpk:'CallTypeNumWJ.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			});
			urlstr+='&Call_Type='+tsd.encodeURIComponent(Call_Type);
			$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
					var flag = false;
					$(xml).find('row').each(function(){
						var dbCall_Type = $(this).attr("Call_Type".toLowerCase());
						if(dbCall_Type!='undefined'&&dbCall_Type!=undefined){
							dbCall_Type=dbCall_Type.toLowerCase();
							Call_Type=Call_Type.toLowerCase();
							if(dbCall_Type==Call_Type){
								
								alert("<fmt:message key='tariff.callTypeExist'/>");
								$("#Call_Type").focus();
								flag = true;
							}
						}
							
					});
					if(flag==false){
					
					/***************************
					*     判断完成，进行保存操作   *
					***************************/
						
						var urlstr1 =tsd.buildParams({  
							packgname:'service',//java包
							clsname:'ExecuteSql',//类名
							method:'exeSqlData',//方法名
							ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							tsdcf:'mssql',//指向配置文件名称
							tsdoper:'exe',//操作类型
							datatype:'xml',//返回数据格式
							tsdpk:'CallTypeNumWJ.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						});
						urlstr1 +=params;
						//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)
						$.ajax({
						url:'mainServlet.html?'+urlstr1,
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){
								var operationtips = $("#operationtips").val();
								var successful = $("#successful").val();
								jAlert(successful,operationtips);
								
								//写入日志操作
								var str ="(call_type_num_wj)<fmt:message key='global.add'/>。"+$("#Call_Typeg").html()+": "+$("#Call_Type").val()+";"+$("#Jbfzyg").html()+": "+$("#Jbfzy").val()+";"+$("#Yhlg").html()+": "+$("#Yhl").val();
								writeLogInfo("","add",tsd.encodeURIComponent(str));				
								
									if(saves==2){
										//fuheQuery();
										querylist(0);
										setTimeout($.unblockUI, 15);
									}else{
										closeflash=true;//表示关闭时需要刷新
										clearText('operformT1');
									}
								}
							}
						});
					}
				}
			});
}

var closeflash_son=false;//用于判断添加操作是保存新增，或保存退出。保存新增closeflash_son=true ；保存退出closeflash_son=false
/**
 * 对网间结算呼叫类型明细进行保存操作
 * @param saves 判断保存类型 1：保存新增 ；2保存退出
 * @return 
 */
function saveObj_son(saves){
			/****************************************
			*   是否是可输入关键字是否已经存在，Num  *
			****************************************/
			var NetName = $("#NetName_son").val();
			NetName = delTrim(NetName);//去掉左右空格
			var Bjzg =$("#Bjzg_son").val();
			Bjzg = delTrim(Bjzg);//去掉左右空格
			var params=buildParams_son();
			if(params==false){return false;}
			var urlstr=tsd.buildParams({
				packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型
				datatype:'xmlattr',//返回数据格式
				tsdpk:'CallTypeWJ.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			});
			urlstr+='&NetName='+tsd.encodeURIComponent(NetName)+'&Bjzg='+tsd.encodeURIComponent(Bjzg);
			$.ajax({
			url:'mainServlet.html?'+urlstr,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
				success:function(xml){
					var flag = false;
					$(xml).find('row').each(function(){
						var dbNetName = $(this).attr("NetName".toLowerCase());
						if(dbNetName!='undefined'&&dbNetName!=undefined){
							dbNetName=dbNetName.toLowerCase();
							NetName=NetName.toLowerCase();
							if(dbNetName==NetName){
								var operationtips = $("#operationtips").val();
								var worninfo = $("#worninfo").val();				
								//jAlert("<fmt:message key='tariff.wornBNN'/>",operationtips);
								alert("<fmt:message key='tariff.wornBNN'/>");
								$("#NetName_son").focus();
								flag = true;
							}
						}
						
					});
					if(flag==false){
					
					/***************************
					*     判断完成，进行保存操作   *
					***************************/
						
						var urlstr=tsd.buildParams({  
						packgname:'service',//java包
						clsname:'ExecuteSql',//类名
						method:'exeSqlData',//方法名
						ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
						tsdcf:'mssql',//指向配置文件名称
						tsdoper:'exe',//操作类型
						datatype:'xml',//返回数据格式
						tsdpk:'CallTypeWJ.save'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						});
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
								jAlert(successful,operationtips);
								
								//写入日志操作
								var str ="(call_type_wj)<fmt:message key='tariff.sublist'/><fmt:message key='global.add'/>。"+$("#NetNameg_son").html()+": "+NetName+";"+$("#Bjzgg_son").html()+": "+Bjzg+";"+$("#Call_Typeg_son").html()+": "+$("#Call_Type_son").val();
								writeLogInfo("","add",tsd.encodeURIComponent(str));				
								
									if(saves==2){
										querylist_son(0);
										//fuheQuery_son();
										setTimeout($.unblockUI, 15);
									}else{
										closeflash_son=true;//表示关闭时需要刷新
										clearText('operformT2');
										$("#Call_Type_son").val($("#meetid").val());
									}
								}
							}
						});
					}
				}
			});
}


/**
 * 对网间结算呼叫类型进行修改
 * @param 
 * @return 
 */
function modifyObj(){
		/*************
		**获取修改参数判断输入信息是否满足条件
		****************/
		 var params = buildParams();
		 if(params==false){return false;}
		 var urlstr=tsd.buildParams({     packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'exe',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'CallTypeNumWJ.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										});
		 	urlstr+=params;
		 	$.ajax({
				url:'mainServlet.html?'+urlstr,  
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						//操作提示国际化
						var operationtips = $("#operationtips").val();
						//操作成功
						var successful = $("#successful").val();
						jAlert(successful,operationtips);
						// 释放资源 							
						setTimeout($.unblockUI, 15);
						
						//写入日志操作隐藏域
						var logoldstr = $("#logoldstr").val();	
						var oldstr = logoldstr.split(',');
						//写入日志
						var str ="(call_type_num_wj)<fmt:message key='global.edit'/>。"+$("#Call_Typeg").html()+": "+$("#Call_Type").val()+";"+$("#Jbfzyg").html()+": "+oldstr[1]+">>>"+$("#Jbfzy").val()+";"+$("#Yhlg").html()+": "+oldstr[2]+">>>"+$("#Yhl").val();
						//str = transfer(str);
						writeLogInfo("","modify",tsd.encodeURIComponent(str));	
						querylist(0);
						//fuheQuery();	
					}	
				}
			});
}


 /**
 * 对网间结算呼叫类型明细进行修改 通过隐藏域modifyM 的值来判断调用单条修改，还是批量修改
 * @param
 * @return 
 */
function modifyObj_son(){
		var modifyM = $("#modifyM").val();
		if(modifyM=="row"){
			modifyObjRow_son();
		}
		else if(modifyM=="batch"){
			fuheModify_son();
		}
}

 /**
 * 对网间结算呼叫类型明细单条记录修改
 * @param
 * @return 
 */
function modifyObjRow_son(){
		 var params = buildParams_son();
		 if(params==false){return false;}			
		 var urlstr=tsd.buildParams({     packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'exe',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'CallTypeWJ.modify'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									});
		 	urlstr+=params;
		 	$.ajax({
				url:'mainServlet.html?'+urlstr,
				//+"&Bjzg="+tsd.encodeURIComponent($("#Bjzg_son").val())+"&NetName="+tsd.encodeURIComponent($("#NetName_son").val())
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						//操作提示国际化
						var operationtips = $("#operationtips").val();
						//操作成功
						var successful = $("#successful").val();
						jAlert(successful,operationtips);
						/*************
							** 释放资源 **
						************/							
						setTimeout($.unblockUI, 15);
						
						//写入日志操作隐藏域
						var logoldstr = $("#logoldstr").val();	
						var oldstr = logoldstr.split(',');
						//写入日志
						var str ="(call_type_wj)<fmt:message key='tariff.sublist'/><fmt:message key='global.edit'/>。"+$("#Bjzgg_son").html()+": "+$("#Bjzg_son").val()+";"+$("#NetNameg_son").html()+": "+$("#NetName_son").val()+";"+$("#Call_Typeg_son").html()+": "+oldstr[0]+">>>"+$("#Call_Type_son").val();
						//str = transfer(str);
						writeLogInfo("","modify",tsd.encodeURIComponent(str));	
						//fuheQuery_son();
						querylist_son(0);			
					}	
				}
			});
}
/**
 * 网间结算呼叫类型jqgrid删除按钮操作，删除该条呼叫类型记录之前需把其明细表的信息先删除
 * @param key  Call_Type呼叫类型值
 * @return 
 */
function deleteRow(key){
		/**************************
		 *    是否有执行删除的权限    *
		 *************************/
		var deleteright = $("#deleteright").val();
		if(deleteright=="true"){	
		
			var deleteinformation = $("#deleteinformation").val();
			var operationtips = $("#operationtips").val();
		 	jConfirm(deleteinformation,operationtips,function(x){
		 		 if(x==true){
		 		 	/*****************
		 		 	**删除子表信息
		 		 	*****************/
					 var urlstr=tsd.buildParams({ packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mssql',//指向配置文件名称
												  tsdoper:'exe',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'CallTypeNumWJ.deleteson'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												});
					urlstr='mainServlet.html?'+urlstr+'&Call_Type='+tsd.encodeURIComponent(key); 
					$.ajax({
						url:urlstr,
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(msg){
							if(msg=="true"){
								var operationtips = $("#operationtips").val();
								var successful = $("#successful").val();
								jAlert(successful,operationtips);
								setTimeout($.unblockUI, 15);
								
								//写入日志操作
								var str="(call_type_wj)<fmt:message key='tariff.sublist'/><fmt:message key='tariff.deleteb'/>。"+"<fmt:message key='global.conditions'/>:"+$("#Call_Typeg").html()+":"+key;
								str = transferApos(str);
								writeLogInfo("","Bulk Delete",tsd.encodeURIComponent(str));	
								querylist_son(0);
								//fuheQuery_son();
							}	
						}
					});
					/*****************
		 		 	**删除主表信息
		 		 	*****************/
		 		 	queryByID(key);
					var urlstr1=tsd.buildParams({ packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mssql',//指向配置文件名称
												  tsdoper:'exe',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'CallTypeNumWJ.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												});
					urlstr1='mainServlet.html?'+urlstr1+'&Call_Type='+tsd.encodeURIComponent(key); 
					$.ajax({
						url:urlstr1,
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(msg){
							if(msg=="true"){
								var operationtips = $("#operationtips").val();
								var successful = $("#successful").val();
								jAlert(successful,operationtips);
								setTimeout($.unblockUI, 15);
								
								//写入日志操作
								var str ="(call_type_num_wj)<fmt:message key='global.delete'/>。"+$("#Call_Typeg").html()+": "+$("#Call_Type").val()+";"+$("#Jbfzyg").html()+": "+$("#Jbfzy").val()+";"+$("#Yhlg").html()+": "+$("#Yhl").val();
								writeLogInfo("","delete",tsd.encodeURIComponent(str));	
								//fuheQuery();
								querylist(0);
							}	
						}
					});
				}
			});
		
		}
		else{					
			var operationtips = $("#operationtips").val();
			var deletepower = $("#deletepower").val();
			jAlert(deletepower,operationtips);
		}				
}

/**
 * 网间结算呼叫类型明细jqgrid删除按钮操作
 * @param key  被叫字冠值
 * @param key1 计费网名值
 * @return 
 */
function deleteRow_son(key,key1){
	 	 	/**************************
		 	*    是否有执行删除的权限    *
		 	*************************/
			var deleteright = $("#deleteright").val();
			if(deleteright=="true"){	
			 	var deleteinformation = $("#deleteinformation").val();
				var operationtips = $("#operationtips").val();
			 	jConfirm(deleteinformation,operationtips,function(x){
			 		 if(x==true){
			 		 	queryByID_son(key,key1);
						 var urlstr=tsd.buildParams({  packgname:'service',//java包
													  clsname:'ExecuteSql',//类名
													  method:'exeSqlData',//方法名
													  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
													  tsdcf:'mssql',//指向配置文件名称
													  tsdoper:'exe',//操作类型 
													  datatype:'xml',//返回数据格式 
													  tsdpk:'CallTypeWJ.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
													});
						var urlstr='mainServlet.html?'+urlstr+'&Bjzg='+tsd.encodeURIComponent(key)+'&NetName='+tsd.encodeURIComponent(key1); 
						$.ajax({
							url:urlstr,
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(msg){
								if(msg=="true"){
									var operationtips = $("#operationtips").val();
									var successful = $("#successful").val();
									jAlert(successful,operationtips);
									setTimeout($.unblockUI, 15);
																			
									//写入日志操作
									var str="(call_type_wj)<fmt:message key='tariff.sublist'/><fmt:message key='global.delete'/>。"+$("#Bjzgg_son").html()+": "+$("#Bjzg_son").val()+";"+$("#NetNameg_son").html()+": "+$("#NetName_son").val()+";"+$("#Call_Typeg_son").html()+": "+$("#Call_Type_son").val();
									writeLogInfo("","delete",tsd.encodeURIComponent(str));				
									//fuheQuery_son();
									querylist_son(0);
								}	
							}
						});
					}
				});
			}
			else{					
				var operationtips = $("#operationtips").val();
				var deletepower = $("#deletepower").val();
				jAlert(deletepower,operationtips);
			}
}

/**
 * 进行通用查询 批量删除 批量修改入口；
 	根据隐藏域gridinfo判断是对呼叫类型数据操作，还是对呼叫类型明细数据操作
 	根据隐藏域queryName 判断是何种操作 delete：批量删除 ；modify：批量修改；其他：高级查询
 * @param 
 * @return 
 */
function fuheExe()
{
		var key = $("#gridinfo").val();
		var queryName= $("#queryName").val();
		if(key==1){
			$("#querysql").val($("#fusearchsql").val());					
			fuheQuery();
		}
		if(key==2){
			$("#querysql_son").val($("#fusearchsql").val());					
			if(queryName=="delete")
			{
				fuheDel_son();
			}
			else if(queryName=="modify")
			{
				fuheOpenModify_son();
			}
			else
			{
				fuheQuery();
			}
		}
		//var queryName= document.getElementById("queryName").value;
}


/**
 * 重新加载网间结算呼叫类型jQgrid数据
 * @param key备用参数
 * @return 
 */
function querylist(key){
			//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
			$("#fusearchsql").val("");
			$("#gridinfo").val(1);
			
			/////设置主表命令参数
			 var urlstr=tsd.buildParams({ packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'CallTypeNumWJ.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'CallTypeNumWJ.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
										});
			var column = $("#ziduansF1").val();
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+column}).trigger("reloadGrid");	
			setTimeout($.unblockUI, 15);//关闭面板
			closeo();
}
			
/**
 * 重新加载呼叫类型明细jQgrid数据
 * @param key备用参数
 * @return 
 */
function querylist_son(key){
			//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
			$("#fusearchsql").val("");			
			$("#gridinfo").val(2);			
			var urlstr_son=tsd.buildParams({ packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'CallTypeWJ.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'CallTypeWJ.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
										});	
											
			var meetid = $("#meetid").val();	
			meetid=tsd.encodeURIComponent(meetid);	
			  
			urlstr_son+="&Call_Type="+meetid; 
			var column = $("#ziduansF2").val();
			$("#editgrid_son").setGridParam({url:'mainServlet.html?'+urlstr_son+'&column='+column}).trigger("reloadGrid");
			setTimeout($.unblockUI, 15);//关闭面板
			closeo();	
}


/**
 * 主表复合查询操作
 * @param 
 * @return 
 */
function fuheQuery(){
			var key =$("#gridinfo").val();
			if(key==1){
				var params = fuheQbuildParams();			
				if(params=='&fusearchsql='){
					params +='1=1';
				}
				
				//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'CallTypeNumWJ.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'CallTypeNumWJ.fuheQueryByWherepage'
											});
				var link = urlstr1 + params;	
				var column = $("#ziduansF1").val();
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板	
			}
			if(key==2){
				var params = fuheQbuildParams();			
				if(params=='&fusearchsql='){
					params +='1=1';
				}
				var meetid = $("#meetid").val();	
				meetid=tsd.encodeURIComponent(meetid);	  
				params+="&Call_Type="+meetid; 
				
				//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'CallTypeWJ.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'CallTypeWJ.fuheQueryByWherepage'
											});
				var link = urlstr1 + params;	
				var column = $("#ziduansF2").val();
			 	$("#editgrid_son").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板	
			}
			$("#modinfo").val('');
			closeo();
}


 /**
 * 呼叫类型明细表批量删除操作
 * @param 
 * @return 
 */
function fuheDel_son(){
			var deleteinformation = $("#deleteinformation").val();
			var operationtips = $("#operationtips").val();	
			//jConfirm("确认要删除?",'提示对话框',function(x)
			jConfirm(deleteinformation,operationtips,function(x){
		 		if(x==true)
		 		{	
		 		var params = fuheQbuildParams();	
		 		if(params==false){return false;}	
		 		var meetid =$("#meetid").val();	
		 		meetid=tsd.encodeURIComponent(meetid);	  
				params+="&Call_Type="+meetid; 
		 						    
		 		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'exe',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'CallTypeWJ.fuheDeleteBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  
											});
				var link='mainServlet.html?'+urlstr1+params; 
			 	$.ajax({
						url:link,
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(msg){
							if(msg=="true"){
								var operationtips = $("#operationtips").val();
								var successful = $("#successful").val();									
								jAlert(successful,operationtips);
								//jAlert("操作成功","操作提示");
								setTimeout($.unblockUI, 15);
								
								//写入日志操作
								var str ="(call_type_num_wj)<fmt:message key='tariff.sublist'/><fmt:message key='tariff.deleteb'/>。"+"<fmt:message key='global.conditions'/>:"+$("#fusearchsql").val();
								str = transferApos(str);
								writeLogInfo("","Bulk Delete",tsd.encodeURIComponent(str));
								//fuheQuery_son();
								querylist_son(0);
							
							}	
						}
					});
				}
			});				
}


 /**
 * 网间结算呼叫类型明细表批量修改对象
 * @param 
 * @return 
 */
function fuheModify_son()
{
			var mparams=MbuildParams_son();
			if(mparams==false){return false;}
			var params = fuheQbuildParams();
			params += mparams
			var meetid =$("#meetid").val();	
			meetid=tsd.encodeURIComponent(meetid);	  
			params+="&Call_Type="+meetid;
			var urlstr=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'exe',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'CallTypeWJ.fuheModifyBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										});
		 	urlstr+=params;
			$.ajax({
				url:'mainServlet.html?'+urlstr,
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						var operationtips = $("#operationtips").val();
						var successful = $("#successful").val();
						jAlert(successful,operationtips);
						setTimeout($.unblockUI, 15);
						clearText('operformT2');
						
						//写入日志操作
						//$("#logoldstr").val();
						var str ="(call_type_wj)<fmt:message key='tariff.sublist'/><fmt:message key='tariff.modifyb'/>。"+"<fmt:message key='global.newVal'/>:"+$("#logoldstr").val()+" <fmt:message key='global.conditions'/>:"+$("#fusearchsql").val();
						str = transferApos(str);
						writeLogInfo("","Batch Edit",tsd.encodeURIComponent(str));
						fuheQuery();
					}	
				}
			});
}

/**
 * 组合排序 
 	通过隐藏域gridinfo 判断是对网间结算呼叫类型jqgrid或是网间结算呼叫类型明细jqgrid操作；
 	key=1：网间结算呼叫类型排序 ；key=2：网间结算呼叫类型明细排序
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
			var key = $("#gridinfo").val();
			if(key==1){
				
				//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'CallTypeNumWJ.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'CallTypeNumWJ.queryByOrderpage'
											});
				var column = $("#ziduansF1").val();
				var link = urlstr1 + params+'&column='+column;	
				$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	//setTimeout($.unblockUI, 15);//关闭面板
			}
			////有问题
			if(key==2){
				var column = $("#ziduansF2").val();
				var meetid =$("#meetid").val();	
				meetid=tsd.encodeURIComponent(meetid);	  
				params+="&Call_Type="+meetid;  
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'CallTypeWJ.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'CallTypeWJ.queryByOrderpage'
											});
				var link = urlstr1 + params;	
				$("#editgrid_son").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
			 	//setTimeout($.unblockUI, 15);//关闭面板
			}
}
			

/**
 * 打开简单查询面板  	
 * @param  key 判断是对网间结算呼叫类型jqgrid或是网间结算呼叫类型明细jqgrid操作；
 		   key=1：网间结算呼叫类型 ；key=2：网间结算呼叫类型明细
 * @return 
 */
function openQuery(key){ 	
		$("#gridinfo").val(key);
		markTable(1);//隐藏红色*号
		$(".top_03").html('<fmt:message key="global.query" />');//标题		
		switch(key){
			case 1:	
				removeDisabledN('call_type_num_wj','','');					
				openpan();				
				$('#jdquery1').show();
				clearText('operformT1');			
				break;
			case 2:	
				removeDisabledN('call_type_wj','','_son');
				openpan();				
				$('#jdquery2').show();
				clearText('operformT2');
				
				//根据主表选中的字段给呼叫类型设置默认值
				$("#Call_Type_son").val($("#meetid").val());
			
				$('#Call_Type_son').attr("disabled","disabled");
				$("#Call_Type_son").removeClass();
				$("#Call_Type_son").addClass("textclass2");
				break;	
			}
 }


 /**
 * jqgrid上新增按钮操作 ，弹出新增面板	
 * @param  	key 判断是对网间结算呼叫类型jqgrid或是网间结算呼叫类型明细jqgrid操作；
 			key=1：网间结算呼叫类型 ；key=2：网间结算呼叫类型明细
 * @return 
 */
function openadd(key){
		markTable(0);//显示红色*号
		$(".top_03").html('<fmt:message key="global.add" />');//标题	
		switch(key){			
			case 1:	
					removeDisabledN('call_type_num_wj','','');
					$("#gridinfo").val(1);
					openpan();
					$("#save1").show();
					$("#readd1").show();
					clearText('operformT1');				
					break;
			case 2:					
					 /************************
					 	if($("#meetid").val()==false){
					 		jAlert("请选择定义呼叫类型主表某行！","操作");
					 		return;
					 	}
					 ********************/
					removeDisabledN('call_type_wj','','_son');
				 	$("#gridinfo").val(2);
					openpan();
					$("#save2").show();
					$("#readd2").show();
					clearText('operformT2');
					
					//根据主表选中的字段给呼叫类型设置默认值
					$("#Call_Type_son").val($("#meetid").val());
					/*
					//Call_Type_son不可修改
					$('#Call_Type_son').attr("disabled","disabled");
					$("#Call_Type_son").removeClass();
					$("#Call_Type_son").addClass("textclass2");
					*/
					break;	
			}
}


 /**
 * 网间结算呼叫类型jqgrid上修改按钮操作 ，打开修改面板并加载将要修改的数据
 * @param  key 呼叫类型值
 * @return 
 */
function openRowModify(key){
	var editright = $("#editright").val();
		if(editright=="true"){
				markTable(0);//显示红色*号
				var editinfo = $("#editinfo").val();
			 	$(".top_03").html(editinfo);//设置编辑框的标题
				isDisabledN('call_type_num_wj','',''); //将修改面板的输入框全部置为不可用
				$("#gridinfo").val(1);
				openpan();//显示修改面板
				$("#modify1").show();$("#reset1").show();
				clearText('operformT1');//清空修改面板
				queryByID(key);//取出数据库中改条记录，并放到修改面板中
				setTableFields();
				$('#Call_Type').attr("disabled","disabled");
				$("#Call_Type").removeClass();
				$("#Call_Type").addClass("textclass2");
		}
		else{
			var operationtips = $("#operationtips").val();
			var editpower = $("#editpower").val();
			jAlert(editpower,operationtips);
		}
}

 /**
 * 网间结算呼叫类型明细jqgrid上修改按钮操作 ，打开修改面板并加载将要修改的数据
 * @param  key 被叫字冠值
 * @param  key1 计费网名值 
 * @return 
 */
function openRowModify_son(key,key1){	
		var editright = $("#editright").val();
		if(editright=="true"){	
				markTable(0);//显示红色*号
				var editinfo = $("#editinfo").val();
			 	$(".top_03").html(editinfo);//设置编辑框的标题
				
				isDisabledN('call_type_wj','','_son'); //将修改面板的输入框全部	置为不可用
			 	$("#gridinfo").val(2);
				openpan();//显示修改面板							
				$("#modify2").show();$("#reset2").show();
				clearText('operformT2');//清空修改面板			
				queryByID_son(key,key1);
				setTableFields_son();//控制可修改字段	
				
				$('#Bjzg_son').attr("disabled","disabled");
				$("#Bjzg_son").removeClass();
				$("#Bjzg_son").addClass("textclass2");
				
				$('#NetName_son').attr("disabled","disabled");
				$("#NetName_son").removeClass();
				$("#NetName_son").addClass("textclass2");	
				
				$("#modifyM").val("row");						
	 	}
		else{
			var operationtips = $("#operationtips").val();
			var editpower = $("#editpower").val();
			jAlert(editpower,operationtips);
		}			
}	


/**
 * 网间结算呼叫类型明细jqgrid上修改按钮操作 ，打开批量修改面板
 * @param  
 * @return 
 */
function fuheOpenModify_son()
{	
		markTable(1);//隐藏红色*号
	 	$(".top_03").html('<fmt:message key="tariff.modifyb" />');//标题	
	 	isDisabledN('call_type_wj','','_son'); //将修改面板的输入框全部	置为不可用	
	 	$("#gridinfo").val(2);
		openpan();//显示修改面板		
		$("#modifyB2").show();
		clearText('operformT2');		
		
		setTableFields_son();//控制可修改字段			
		//关键字不允许更改		
		$('#Bjzg_son').attr("disabled","disabled");
		$("#Bjzg_son").removeClass();
		$("#Bjzg_son").addClass("textclass2");
		
		$('#NetName_son').attr("disabled","disabled");
		$("#NetName_son").removeClass();
		$("#NetName_son").addClass("textclass2");
		
		$("#modifyM").val("batch");
}

 /**
 * 根据简单查询输入条件进行简单查询
 * @param  	key 判断是对网间结算呼叫类型或网间结算呼叫类型明细操作；
 			key=1：网间结算呼叫类型 ；key=2：网间结算呼叫类型明细
 * @return 
 */	
function QbuildParams(key){
	 	if(key==1){	 						
		 	var Call_Type = $("#Call_Type").val(); Call_Type = delTrim(Call_Type);//去掉左右空格		 	
		 	var Jbfzy = $("#Jbfzy").val(); Jbfzy = delTrim(Jbfzy);//去掉左右空格
		 	var Yhl = $("#Yhl").val();	 Yhl = delTrim(Yhl);//去掉左右空格
		 					
			var paramsStr='1=1 ';			 		
		 	if(Call_Type!=''){
		 	 	paramsStr+="and Call_Type like '%"+Call_Type+"%' ";
		 	}
		 	if(Jbfzy!=''){
		 		paramsStr+="and Jbfzy like '%"+Jbfzy+"%' " ;
		 	}
		 	if(Yhl!=''){
		 		paramsStr+="and Yhl like '%"+Yhl+"%' " ;
		 	}
		 	
		 	$("#querysql").val(paramsStr);				 	
		 	fuheQuery();
	 	}
	 	if(key==2){			 					 	
		 	var Bjzg = $("#Bjzg_son").val(); Bjzg = delTrim(Bjzg);//去掉左右空格
		 	var Call_Type = $("#Call_Type_son").val(); Call_Type = delTrim(Call_Type);//去掉左右空格
		 	var NetName = $("#NetName_son").val(); NetName = delTrim(NetName);//去掉左右空格
			
			var paramsStr='1=1 ';				 	
		 	if(Bjzg!=''){
		 		paramsStr+="and Bjzg like '%"+Bjzg+"%' " ;
		 	}
		 	if(Call_Type!=''){
		 		paramsStr+="and Call_Type like '%"+Call_Type+"%' " ;
		 	}
		 	if(NetName!=''){
		 	 	paramsStr+="and NetName like '%"+NetName+"%' ";
		 	}
		 	$("#querysql_son").val(paramsStr);				 	
		 	fuheQuery();
		 }			 	
}

 /**
 * 对网间结算呼叫类型添加、修改面板，通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 	@oper 操作类型 modify|save
 * @param 
 * @return 
 */	
function buildParams(){
	 	//每次拼接参数必须初始化此参数
		tsd.QualifiedVal=true;				
	 	var params='';
	 	var Call_Type = $("#Call_Type").val(); Call_Type = delTrim(Call_Type);//去掉左右空格
	 	var Jbfzy = $("#Jbfzy").val();	Jbfzy = delTrim(Jbfzy);//去掉左右空格
	 	var Yhl = $("#Yhl").val();	Yhl = delTrim(Yhl);//去掉左右空格

	 	var operationtips = $("#operationtips").val();
	 	//如果有可能值是汉字 请使用encodeURI()函数转码
	 	if(Call_Type!=null&&Call_Type!=""){
 			params+="&Call_Type="+tsd.encodeURIComponent(Call_Type);
 		}
	 	else{	
	 		//请输入呼叫类型!
 			alert("<fmt:message key='tariff.wornCallType'/>");
 			$("#Call_Type").focus();
 			return false;
 		} 
 		if(Yhl!=null&&Yhl!=""){
 			
 			if(isDecimal(Yhl)){
	 			params+="&Yhl="+Yhl;
	 		}
	 		else{
	 			//优惠率值请输入数字，且小数位不要大于三位！
	 			alert("<fmt:message key='tariff.wornYhl'/>");
	 			$("#Yhl").focus();
	 			return false;
	 		}
	 	}
	 	else{	
 			params+="&Yhl=1";
 		} 
 		params+="&Jbfzy="+tsd.encodeURIComponent(Jbfzy);
 		//每次拼接参数必须添加此判断
		if(tsd.Qualified()==false){return false;}
		return params;
}	 
/**
 * 对网间结算呼叫类型明细添加、修改面板，通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 	@oper 操作类型 modify|save
 * @param 
 * @return 
 */
function buildParams_son(){
		 	//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;				
		 	var params='';
		 	
		 	var Bjzg = $("#Bjzg_son").val();	Bjzg = delTrim(Bjzg);//去掉左右空格
		 	var Call_Type = $("#Call_Type_son").val();	Call_Type = delTrim(Call_Type);//去掉左右空格
		 	var NetName = $("#NetName_son").val();	NetName = delTrim(NetName);//去掉左右空格
		 			 	
		 	//如果有可能值是汉字 请使用encodeURI()函数转码
		 	if(Bjzg!=null&&Bjzg!=""){params+="&Bjzg="+tsd.encodeURIComponent(Bjzg);}	
	 		else{	
	 			//请输入被叫字冠!
	 			alert("<fmt:message key='tariff.wornBjzg'/>");
	 			$("#Bjzg_son").focus();
	 			return false;
	 		} 
	 		
	 		if(Call_Type!=null&&Call_Type!=""){params+="&Call_Type="+tsd.encodeURIComponent(Call_Type);}
		 	else{	
		 		//请输入呼叫类型!
		 		
	 			alert("<fmt:message key='tariff.wornCallType'/>");
	 			$("#Call_Type_son").focus();
	 			return false;
	 		} 
	 		
		 	if(NetName!=null&&NetName!=""){params+="&NetName="+tsd.encodeURIComponent(NetName);}
		 	else{	
		 		//请输入计费网名!
	 			alert("<fmt:message key='tariff.wornNetName'/>");
	 			$("#NetName_son").focus();
	 			return false;
	 		}
	 		 
	 		//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
}			 
			
/**
 * 对网间结算呼叫类型明细批量修改面板，通过表单值构造数据操作参数
 * @param 
 * @return 
 */
function MbuildParams_son(){			
		 	//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;
			var params='';
		 	var Call_Type = $("#Call_Type_son").val();
		 	Call_Type = delTrim(Call_Type);//去掉左右空格
		 	var modifyStr="set";
		 	var modifySet='set';
		 	if(Call_Type!=""){
		 		modifySet+=' Call_Type=\''+tsd.encodeURIComponent(Call_Type)+'\'';	
		 		modifyStr+=' Call_Type=\''+Call_Type+'\'';
		 	}
		 	else{			 		
		 		jAlert('<fmt:message key="tariff.modifyinfo"/>','<fmt:message key="global.operationtips"/>');
		 		return false;
		 	}
		 	$("#logoldstr").val(modifyStr);		
		 	params+="&modifySet="+modifySet;	 
		 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
		 	    
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
}

 /**
 * 高级查询参数获取
 	隐藏域gridinfo参数用于判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；
 	gridinfo=1：网间结算呼叫类型 ；gridinfo=2：网间结算呼叫类型明细
 * @param 
 * @return 
 */
function fuheQbuildParams(){
			 			
			//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;
		 	var params='';
		 	
		 	var modinfo = $("#modinfo").val();
			if(modinfo==1){
				$("#querysql").val($("#fusearchsql").val());	
			}else if(modinfo==2){
				$("#querysql_son").val($("#fusearchsql").val());
			}
			
		 	var key = $("#gridinfo").val();
		 	var fusearchsql='';
		 	if(key==1){
		 		fusearchsql = encodeURIComponent($("#querysql").val());			 		
		 	}
		 	else if(key==2){
		 		var fusearchsql = $("#querysql_son").val();		 		
		 		var meetid= $("#meetid").val() ;
		 		fusearchsql +=" and Call_Type='"+meetid+"' ";
		 		fusearchsql = encodeURIComponent(fusearchsql);
		 		//如果有可能值是汉字 请使用encodeURI()函数转码
		 		params+='&fusearchsql='+fusearchsql;
		 	}
		 	params+='&fusearchsql='+fusearchsql;
		 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
		 	//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
}
 /**
 * 设置网间结算呼叫类型明细面板可编辑域
 	根据管理员在配置页面配置的信息解析
 * @param 
 * @return 
 */
 function setTableFields_son(){
 
 		var editfields_son = $("#editfields_son").val();
						
		// 将当前表的所有字段取出来，分割字符串		
		var fields = getFields("call_type_wj");														
		var fieldarr = fields.split(",");
		
		//将当前表中的spower字段取出来 
		var spower = editfields_son.split(",");
		
		// 考虑字段大小写问题 		
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
							$('#'+arr[i]+'_son').removeAttr("disabled");						
							$('#'+arr[i]+'_son').removeClass();
							$('#'+arr[i]+'_son').addClass("textclass");
							break;
						}
				}
			}
		}
 }
 
  /**
 * 设置网间结算呼叫类型面板可编辑域
 	根据管理员在配置页面配置的信息解析
 * @param 
 * @return 
 */
function setTableFields(){
		var editfields = $("#editfields").val();
		
		//将当前表的所有字段取出来，分割字符串		
		var fields = getFields("call_type_num_wj");														
		var fieldarr = fields.split(",");
		
		//将当前表中的spower字段取出来
		var spower = editfields.split(",");
		
		// 考虑字段大小写问题 		
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
							$('#'+arr[i]).removeClass();
							$('#'+arr[i]).addClass("textclass");
							break;
						}
				}
			}
		}
}
</script>

<script type="text/javascript">

 /**
 * 关闭表格面板
 	隐藏域gridinfo判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；
 	gridinfo=1：网间结算呼叫类型 ；gridinfo=2：网间结算呼叫类型明细
 * @param 
 * @return 
 */
function closeo(){
	var key= $("#gridinfo").val();
	if(key=='1'){
		if(closeflash){
		 		 closeflash=false;
		 		 querylist(0);	
		 }
		 clearText('operformT1');	
	}
	else if (key=='2'){
		 if(closeflash_son){
					closeflash_son=false;
					querylist_son(0);
		}	
		clearText('operformT2');			
	}	
		setTimeout($.unblockUI, 15);		
}
 /**
 * 打开表格面板
 	隐藏域gridinfo判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；
 	gridinfo=1：网间结算呼叫类型 ；gridinfo=2：网间结算呼叫类型明细
 * @param 
 * @return 
 */
function openpan(){		
		var key= $("#gridinfo").val();
		if(key=='1'){				
				autoBlockFormAndSetWH('panTab1',60,5,'closeo1',"#ffffff",true,1000,'');//弹出查询面板
				$("#jdquery1").hide();$("#readd1").hide();$("#save1").hide();$("#modify1").hide();$("#reset1").hide();$("#clearB1").hide();
		}else if(key=='2'){					
				autoBlockFormAndSetWH('panTab2',60,5,'closeo2',"#ffffff",true,1000,'');//弹出查询面板		
				$("#modifyB2").hide();$("#jdquery2").hide();$("#readd2").hide();$("#save2").hide();$("#modify2").hide();$("#reset2").hide();$("#clearB2").hide();
		}			
}

 /**
 * 网间结算呼叫类型修改面板的取消按钮操作
 * @param 
 * @return 
 */
function reset1(){		
		var key=$("#Call_Type").val();
		key = delTrim(key);//去掉左右空格
		queryByID(key);	
}
/**
 * 网间结算呼叫类型明细修改面板的取消按钮操作
 * @param 
 * @return 
 */
function reset2(){			
		var key1 =$("#NetName_son").val();	key1 = delTrim(key1);//去掉左右空格
		var key =$("#Bjzg_son").val();	key = delTrim(key);//去掉左右空格
		queryByID_son(key,key1);	
}
</script>
<script type="text/javascript">

 /**
 * 页面上高级查询、批量修改、批量删除按钮操作，打开查询窗口
 * @param key key打开窗口方法，query modify delete存放在隐藏域queryName
 * @param key1 标识操作的表，1主表，2明细表 存放在隐藏域gridinfo
 * @return 
 */	
function openwinQ(key,key1)
{
	$("#gridinfo").val(key);
	if(key==1){
		openDiaQueryG(key1,'call_type_num_wj','1');					
	}
	else if(key==2){
		openDiaQueryG(key1,'call_type_wj','2');
	}
}

/**
 * 打开将本查询保存问模板窗口
 * @param key 标识操作的表，1主表，2明细表 存放在隐藏域gridinfo
 * @return 
 */
function openSaveModT(key)
{
	
	$("#gridinfo").val(key);
	if(key==1){
		openModT('call_type_num_wj','1');					
	}
	else if(key==2){
		openModT('call_type_wj','2');
	}
	
}
/**
 * 页面上组合排序按钮操作，打开组合排序窗口
 * @param key 标识操作的表，1主表，2明细表 存放在隐藏域gridinfo
 * @return 
 */
function openwinO(key)
{	
		$('#gridinfo').val(key);
		if(key==1){
			openDiaO('call_type_num_wj');
		}	
		if(key==2)
		{	
			openDiaO('call_type_wj');
		}	
}
</script>
<script type="text/javascript">
/**
 * 查询模板保存面板中的保存按钮操作，用于保存本次查询为模板
	 隐藏域gridinfo判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；
	 gridinfo=1：网间结算呼叫类型 ；gridinfo=2：网间结算呼叫类型明细
 * @param 
 * @return 
 */
function addQuery(){
	 	var key = $("#gridinfo").val();
	 	saveModQuery(key);
 }
 /**
 * 模板查询按钮操作，弹出查询模板信息窗口，用户可根据该查看信息，选择已有查询模板进行查询
	  隐藏域gridinfo判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；
	 gridinfo=1：网间结算呼叫类型 ；gridinfo=2：网间结算呼叫类型明细
 * @param 
 * @return 
 */
 function modQuery(key){
	 	$("#gridinfo").val(key);
	 	$('#modinfo').val(key);
	 	openQueryM(key);
 }
  /**
 *导出数据面板的导出按钮操作，
	 隐藏域gridinfo判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；
	 gridinfo=1：网间结算呼叫类型 ；gridinfo=2：网间结算呼叫类型明细
 * @param 
 * @return 
 */
  function saveExoprt(){
	 	var key = $('#gridinfo').val();
	 	if(key==2||key=='2'){
	 		getTheCheckedFields('tsdCDR','mssql','call_type_wj');
	 	}
	 	else{
	 		getTheCheckedFields('tsdCDR','mssql','call_type_num_wj');
	 	}		 	
 }
  /**
 *标识当前操作的面板，点击页面导出数据按钮时操作
	  隐藏域gridinfo判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；
	 gridinfo=1：网间结算呼叫类型 ；gridinfo=2：网间结算呼叫类型明细
 * @param key 判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；1：网间结算呼叫类型 ，2：网间结算呼叫类型明细
 * @return 
 */
 function openExport(key){
 		$('#gridinfo').val(key);
 }
		 
			 
/**
 *报表打印参数获取
	  隐藏域gridinfo判断是对网间结算呼叫类型或是网间结算呼叫类型明细操作；
	 gridinfo=1：网间结算呼叫类型 ；gridinfo=2：网间结算呼叫类型明细
 * @param
 * @return 
 */			 
function getPriParams(){
	var params='';	
	var modinfo = $("#modinfo").val();
	if(modinfo==1){
		$("#querysql").val($("#fusearchsql").val());	
	}else if(modinfo==2){
		$("#querysql_son").val($("#fusearchsql").val());
	}
 	var key = $("#gridinfo").val();
 	if(key==1){
 		var fusearchsql = encodeURIComponent(cjkEncode($("#querysql").val()));
 		encodeURIComponent($("#querysql").val());
 		//如果有可能值是汉字 请使用encodeURI()函数转码 		
 	}
 	else if(key==2){
 		var fusearchsql = $("#querysql_son").val();		 		
 		var meetid= $("#meetid").val();
 		fusearchsql +=" and Call_Type='"+meetid+"' ";
 		fusearchsql = encodeURIComponent(cjkEncode(fusearchsql));
 		//如果有可能值是汉字 请使用encodeURI()函数转码 			
 	}	
	
 	//如果有可能值是汉字 请使用encodeURI()函数转码
 	params+='&fusearchsql='+fusearchsql;			 	
 	if(params=='&fusearchsql='){
		params +='1=1';
	}
	return params;
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
				$("#navBar").append(genNavv());
		});
</script>
  </head>
<style type="text/css"> 
 .style1 {
	background-color:#A9C3E8;
	padding: 4px;		
	}
</style>
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}
		</style> 
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
			<button type="button" id="order1" onclick="openwinO(1);">
				<!--组合排序--><fmt:message key="order.title" />
			</button>
			<button type="button" id="openadd1" onclick="openadd(1);" disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>		   
			<button type="button" onclick="openQuery(1);">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='modQuery(1);' id='mbquery1'><fmt:message key="oper.mod"/></button>
			<button type="button" id='gjquery1' onclick="openwinQ(1,'query');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='savequery1' onclick="openSaveModT(1);openExport(1);" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button>
			<button type="button" id="export1" onclick="thisDownLoad('tsdBilling','mssql','call_type_num_wj','<%=languageType %>');openExport(1);"
			 disabled="disabled"> <!--  disabled="disabled" -->
				<!--导出--><fmt:message key="global.exportdata" />
			</button>	
			<!--打印				
			<button type="button" id="print1" onclick="openExport(1);printThisReport1('<%=request.getParameter("imenuid")%>','call_type_num_wj',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>')"  disabled="disabled">
				<fmt:message key="tariff.printer" />
			</button>
			-->
		</div>	
    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons" style="display: none;">
			<button type="button" id="order2" onclick="openwinO(1);">
				<!--组合排序--><fmt:message key="order.title" />
			</button>
			<button type="button" id="openadd2" onclick="openadd(1);" disabled="disabled"><!--  disabled="disabled" -->
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>   
		    <button type="button" onclick="openQuery(1);">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='modQuery(1);' id='mbquery2'><fmt:message key="oper.mod"/></button>
			<button type="button" id='gjquery2' onclick="openwinQ(1,'query');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='savequery2' onclick="openSaveModT(1);openExport(1);" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button>
			<button type="button" id="export2" onclick="thisDownLoad('tsdBilling','mssql','call_type_num_wj','<%=languageType %>');openExport(1);"
			 disabled="disabled"> <!--  disabled="disabled" -->
				<!--导出--><fmt:message key="global.exportdata" />
			</button>	
			<!--打印				
			<button type="button" id="print2" onclick="openExport(1);printThisReport1('<%=request.getParameter("imenuid")%>','call_type_num_wj',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');"  disabled="disabled">
				<fmt:message key="tariff.printer" />
			</button>
			-->
		</div>	
	
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="order3" onclick="openwinO(2);">
				<!--组合排序--><fmt:message key="order.title" />
			</button>		
			<button type="button" id="openadd3" onclick="openadd(2);" disabled="disabled" >
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>   
			<button type="button" onclick="openQuery(2);">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='modQuery(2);' id='mbquery3'><fmt:message key="oper.mod"/></button>
			<button type="button" id='gjquery3' onclick="openwinQ(2,'query');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='savequery3' onclick="openSaveModT(2);openExport(2);" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button>
			 <button type="button" id="opendel3" onclick="openwinQ(2,'delete');" disabled="disabled">
				<!--批量删除--><fmt:message key="tariff.deleteb" />
			</button>
			 <button type="button" id="openmod3" onclick="openwinQ(2,'modify');" disabled="disabled">
				<!--批量修改--><fmt:message key="tariff.modifyb" />
			</button>
			<button type="button" id="export3"  onclick="thisDownLoad('tsdBilling','mssql','call_type_wj','<%=languageType %>');openExport(2);" 
			disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>	
			<!--打印				
			<button type="button" id="print3" onclick="openExport(2);printThisReport1('<%=request.getParameter("imenuid")%>','call_type_wj',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>')"  disabled="disabled">
				<fmt:message key="tariff.printer" />
			</button>
			-->
	</div>	
	<table id="editgrid_son" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered_son" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons" style="display: none;">
			<button type="button" id="order4" onclick="openwinO(2);">
				<!--组合排序--><fmt:message key="order.title" />
			</button>		
			<button type="button" id="openadd4" onclick="openadd(2);" disabled="disabled">
				<!-- 新增 --><fmt:message key="global.add" />
		    </button>		
			<button type="button" onclick="openQuery(2);">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='modQuery(2);' id='mbquery4'><fmt:message key="oper.mod"/></button>
			<button type="button" id='gjquery4' onclick="openwinQ(2,'query');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='savequery4' onclick="openSaveModT(2);openExport(2);" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button>
			 <button type="button" id="opendel4" onclick="openwinQ(2,'delete');" disabled="disabled">
				<!--批量删除--><fmt:message key="tariff.deleteb" />
			</button>
			 <button type="button" id="openmod4" onclick="openwinQ(2,'modify');" disabled="disabled">
				<!--批量修改--><fmt:message key="tariff.modifyb" />
			</button>
			<button type="button" id="export4" onclick="thisDownLoad('tsdBilling','mssql','call_type_wj','<%=languageType %>');openExport(2);"
			 disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>		
			<!--打印			
			<button type="button" id="print4" onclick="openExport(2);printThisReport1('<%=request.getParameter("imenuid")%>','call_type_wj',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>')"  disabled="disabled">
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
				<div class="top_03" ><fmt:message key="CallTypeWJ.functionname" /></div>
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
				    	<input type="text" name="name_mod" id="name_mod" maxlength="50" onpropertychange="TextUtil.NotMax(this)" class="textclass"/>
				    	<font style="color: #ff0000;">*</font></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
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
				<div class="top_03" ><fmt:message key="CallTypeWJ.functionname" /></div>
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
			  <!--  呼叫类型 -->
			    <td width="12%" align="right" class="labelclass"><label id="Call_Typeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Call_Type" id="Call_Type" class="textclass" maxlength="16" onpropertychange="TextUtil.NotMax(this)"></input>						
					<label class="addred" ></label></td>
			  <!-- 通话时长 -->
			    <td width="12%" align="right"  class="labelclass" style="line-height: 20px;" ><label  id="Jbfzyg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<!-- <input type="text" name="Jbfzy" id="Jbfzy" class="textclass" maxlength="16" onpropertychange="TextUtil.NotMax(this)"/></td> -->
			    	<select name="Jbfzy" class="textclass" id=Jbfzy><option value=" "><fmt:message key="CallTypeWJ.choose" /></option></select></td>			
			<!-- 明细话单归档表前缀 -->
			    <td width="12%" align="right"  class="labelclass"><label id="Yhlg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="Yhl" id="Yhl" class="textclass" style="ime-mode: Disabled" onkeypress="var k=event.keyCode; return k>=46&&k<=57&&k!=47" maxlength="9" onpaste="return   !clipboardData.getData('text').match(/\D/)" ondragenter="return   false"></input></td>	  
			</tr>			
		</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery1" onclick="QbuildParams(1);"><fmt:message key="global.query" /></button>		
		<!-- 保存新增 --><button class="tsdbutton" id="readd1" style="width:80px;heigth:27px;" onclick="saveObj(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save1" style="width:80px;heigth:27px;" onclick="saveObj(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify1" style="width:63px;heigth:27px;" onclick="modifyObj();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB1" style="width:63px;heigth:27px;" onclick="clearText('operformT1');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset1" style="width:63px;heigth:27px;" onclick="reset1();" ><fmt:message key="CallTypeWJ.cancel" /></button>
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
				<div class="top_03" ><fmt:message key="CallTypeWJ.functionname" /></div>
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
			  <!-- 被叫字冠 -->		   
				    <td width="12%" align="right" class="labelclass"><label id="Bjzgg_son" ></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Bjzg_son" id="Bjzg_son" class="textclass" maxlength="16" onpropertychange="TextUtil.NotMax(this)"/>						
						<label class="addred" ></label></td>
				   <!--  计费网名 -->
				    <td width="12%" align="right"  class="labelclass"><label  id="NetNameg_son"></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">			    	
						<input type="text" name="NetName_son" id="NetName_son" class="textclass" maxlength="20" onpropertychange="TextUtil.NotMax(this)"/>
						<label class="addred" ></label></td>	
				
				    <td width="12%" align="right"  class="labelclass"><label id="Call_Typeg_son"></label></td>
				    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="Call_Type_son" id="Call_Type_son" class="textclass" maxlength="16" onpropertychange="TextUtil.NotMax(this)"/>				  	
				  	</td>				  
				</tr>			
			</table>			
		</form>	
		<div class="midd_butt">
		<!-- 查询     --><button class="tsdbutton" id="jdquery2" onclick="QbuildParams(2);"><fmt:message key="global.query" /></button>
		<!-- 批量修改 --><button class="tsdbutton" id="modifyB2" style="width:80px;heigth:27px;" onclick="modifyObj_son();"><fmt:message key="tariff.modifyb" /></button>
		<!-- 保存新增 --><button class="tsdbutton" id="readd2" style="width:80px;heigth:27px;" onclick="saveObj_son(1);" ><fmt:message key="global.save" /><fmt:message key="global.add" /></button>
	 	<!-- 保存退出 --><button class="tsdbutton" id="save2" style="width:80px;heigth:27px;" onclick="saveObj_son(2);" ><fmt:message key="global.save" /><fmt:message key="main.quit" /></button>
		<!-- 修改     --><button class="tsdbutton" id="modify2" style="width:63px;heigth:27px;" onclick="modifyObj_son();"><fmt:message key="global.edit" /></button>		    
	    <!-- 清空     --><button class="tsdbutton" id="clearB2" style="width:63px;heigth:27px;" onclick="clearText('operformT2');" ><fmt:message key="global.clear" /></button>
	    <!-- 取消     --><button class="tsdbutton" id="reset2" style="width:63px;heigth:27px;" onclick="reset2();" >取消</button>
		<!-- 关闭 	 --><button class="tsdbutton" id="closeo2" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>  


	  
	  	
	<!-- typtDemoModify  表单输入区域  -->
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
					<input type="hidden" id="editfields_son"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editBright"/>
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />
									
					<input type="hidden" id="meetid" />	
					
					<!-- 用于写入日志 -->
				   <input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request) %>"/> 
				   <input type="hidden" id="userloginid" value="<%=session.getAttribute("userid") %>"/> 
				   <input type="hidden" id="thislogtime" value="<%=Log.getThisTime() %>" />
				   <!-- 修改时保存原来数据的隐藏域 --> 	
				   <input type="hidden" id="logoldstr" />		
				   <input type="hidden" id="useridd" value="<%=userid %>"/>							
				</div>	
	</div>
   <form name="childform" id="childform">
   <!-- 存放主表删除时候Call_Type -->
  <input type="text" id="CallTypeM" name="CallTypeM" style="display: none"/>
  <!-- 存放调用复合查询窗口的方法，是查询、删除、修改 -->
  <input type="text" id="queryName" name="queryName" style="display: none"/>
  <!--  标识目前正在处理是单条修改、批量修改 -->
  <input type="text" id="modifyM" name="modifyM" style="display: none"/>
   <!-- 存放主表的复合查询条件 -->
  <input type="text" id="querysql" name="querysql" style="display: none"/>
   <!-- 存放子表的复合查询条件 -->
  <input type="text" id="querysql_son" name="querysql_son" style="display: none"/>
   <!-- 查询窗口返回的值 -->
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
 <!-- 标识目前正在处理的是那个表 -->
  <input type="text" id="gridinfo" name="gridinfo" style="display: none"/>
  	<!-- 标识面板查询的表 -->
<input type="hidden" id="modinfo" name="modinfo"/>	
    
  <!-- 打印报表 -->
					<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
					
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
					<input type="hidden" id='ziduansF1'/>
					<input type="hidden" id='ziduansF2'/>
					<input type='hidden' id='thecolumn'/>	
  </form>
  
  
   <!-- 导出数据 -->
			<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv"><fmt:message key="CallTypeWJ.checkexportdata" /></div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="CallTypeWJ.close" /></a></div>
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
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
						<fmt:message key="CallTypeWJ.chooseall" />
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
