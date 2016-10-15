<%----------------------------------------
	name: danganM.jsp
	author: fulingqiao
	version: 1.0, 2009-11-26
	description: 对宽带档案管理进行操作
	modify: 
		2009-12-30 fulingqiao 大修改。其中 减少的字段是iFeeStopType,iMacAutoBand,RemainTime,thismonthtime,nextmonthtime,totaltime,iFeeType1 
							  增加的字段是:Fee5,sBm2,sBm3,sBm4  
		2010-01-05 fulingqiao 主动选择显示字段
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.tsd.service.util.Log"%>
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
	String languageType = (String) session.getAttribute("languageType");
%>

<%
	SimpleDateFormat format = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
	String userarea = (String) session.getAttribute("userarea");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>rates management</title>
		<!--定义中继局向组-->
		<meta http-equiv="cache-control" content="no-cache" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js"
			type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet"
			type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>

		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
			type="text/javascript"></script>
		<!-- 分项卡 -->
		<link rel="stylesheet"
			href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css"
			media="print, projection, screen" />
		<link rel="stylesheet"
			href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css"
			media="projection, screen" />

		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js"
			type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js"
			type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" media="screen"
			href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<!-- dtree需要导入文件 -->
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />

		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>

		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 验证框架需要导入的js文件 -->
		<script src="plug-in/jquery/validate/jquery.validate.js"
			type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script type="text/javascript"
			src="script/telephone/sysdataset/infotest.js"></script>
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<style type="text/css">
		#navBar1{  height:26px;background:url(style/images/public/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(style/images/public/daohangbg.jpg) repeat-x; line-height:28px;}

</style>
		<style type="text/css">
.style1 {
	background-color: #A9C3E8;
	padding: 4px;
}
</style>
		<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
-->
</style>


		<script type="text/javascript">
			/**
			 * 查看当前用户的扩展权限，对spower字段进行解析
			 * @param 无参数
			 * @return 无返回值
			 */
			function getUserPower(){
				 var urlstr=buildParamsPro("dangan.getPower","query");
				
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = $('#userid').val();	
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
				
				var exportright = '';
				var printright ='';
					var queryright = '';	
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
							
							exportright += getCaption(spowerarr[i],'export','')+'|';
							
							printright += getCaption(spowerarr[i],'print','')+'|';
							queryright += getCaption(spowerarr[i],'query','')+'|';
							
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
						$("#saveQueryMright").val(str);
						
						editfields = getFields('radcheck');
						
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
					var hassaveQueryM = saveQueryMright.split('|');
					for(var i = 0;i<hasquery.length;i++){
						if(hasquery[i]=='true'){
							$("#queryright").val(str);
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
			}
		</script>
		<script type="text/javascript">
			/**
			 * 写日志
			 * @param status(状态)
			 * @param content(内容)
			 * @return boolean
			 */
			function logwrite(status,content){
			tsd.QualifiedVal=true; 	
			switch(status){
			case 1:
			///增加
					writeLogInfo("","add",tsd.encodeURIComponent("(radcheck)"+"<fmt:message key="global.add" />"+":"+content));				
					break;
			case 2:
			///删除
					writeLogInfo("","delete",tsd.encodeURIComponent("(radcheck)"+"<fmt:message key="global.delete" />"+":"+content));
					break;			
			case 3:
			///修改
					writeLogInfo("","edit","(radcheck)"+tsd.encodeURIComponent("<fmt:message key="global.edit" />")+":"+content);
					break;
				
			case 4:
			///批量删除
			writeLogInfo("","deleteBatch",tsd.encodeURIComponent("(radcheck)"+"<fmt:message key="tariff.deleteb" />"+":"+content));
		
					break;
			
			case 5:
			writeLogInfo("","editBatch",tsd.encodeURIComponent("(radcheck)"+"<fmt:message key="tariff.modifyb" />"+":"+content));
			
					break;
					}
			
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			}
			
			
				/**************************************
				**通过调用配置文件中的sql查看对象
				-------------------------------
			**************************************/
	/**
	* 初始化
	* @param 无参数
	* @return 无返回值
	*/
	jQuery(document).ready(function () {	
	getalllist();//所有列表的数据
	//页面表头当前位置显示
	$("#navBar1").append(genNavv());		
			/**********************
			**   取得当前用户的权限  *
			**********************/
			getUserPower();	
			var addright = $("#addright").val();
					
			 var exportright = $("#exportright").val();
			if(exportright=="true"){
				$("#export").removeAttr("disabled");	$("#exportf").removeAttr("disabled");
			}
		 	var printf11 = $("#printright").val();
			if(printf11=="true"){
				$("#print").removeAttr("disabled");	$("#printf").removeAttr("disabled");
			}			
			var delBright = $("#delBright").val();
			if(delBright=="true"){
				$("#opendel").removeAttr("disabled");	$("#opendelf").removeAttr("disabled");
			}
			var editBright = $("#editBright").val();
			if(editBright=="true"){	
				$("#openmod").removeAttr("disabled");	$("#openmodf").removeAttr("disabled");
			}
			var queryright = $("#queryright").val();
			var saveQueryMright = $("#saveQueryMright").val();
			if(queryright=="true"){
					$("#gjquery1").removeAttr("disabled");	$("#gjquery2").removeAttr("disabled");
			}
			if(saveQueryMright=="true"){
				document.getElementById("savequery1").disabled=false;
				document.getElementById("savequery2").disabled=false;
			}
					
			
			
		//设置命令参数
		 var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
												tsdpk:'danganM.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'danganM.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
											
												
			//对jgGrid的操作符进行国际化
			var opr = $("#operation").val();
			var thisdata = loadData('radcheck','<%=languageType%>',1);	
			
			var AcctStartTime= thisdata.getFieldAliasByFieldName('AcctStartTime');			
			var AcctStopTime= thisdata.getFieldAliasByFieldName('AcctStopTime');
			var feeendtime= thisdata.getFieldAliasByFieldName('feeendtime');
			var idcard= thisdata.getFieldAliasByFieldName('idcard');
			var idtype= thisdata.getFieldAliasByFieldName('idtype');
			var iFeeStopType= thisdata.getFieldAliasByFieldName('iFeeStopType');
			var iFeeType= thisdata.getFieldAliasByFieldName('iFeeType');
			var iFeeType1= thisdata.getFieldAliasByFieldName('iFeeType1');
			var iFeeTypeTime= thisdata.getFieldAliasByFieldName('iFeeTypeTime');
			var iMacAutoBand= thisdata.getFieldAliasByFieldName('iMacAutoBand');
			var ipaddr= thisdata.getFieldAliasByFieldName('ipaddr');
			var iSimultaneous= thisdata.getFieldAliasByFieldName('iSimultaneous');
			var iStatus= thisdata.getFieldAliasByFieldName('iStatus');
			var linkman=thisdata.getFieldAliasByFieldName('linkman');
			var linkphone=thisdata.getFieldAliasByFieldName('linkphone');
			var mobile=thisdata.getFieldAliasByFieldName('mobile');		
			var nextmonthtime= thisdata.getFieldAliasByFieldName('nextmonthtime');
			var PauseStartTime= thisdata.getFieldAliasByFieldName('PauseStartTime');
			var PauseStopTime= thisdata.getFieldAliasByFieldName('PauseStopTime');
			var PayType= thisdata.getFieldAliasByFieldName('PayType');
			var RemainFee= thisdata.getFieldAliasByFieldName('RemainFee');
			var RemainTime=thisdata.getFieldAliasByFieldName('RemainTime');
			var sAddress= thisdata.getFieldAliasByFieldName('sAddress');
			var sBm= thisdata.getFieldAliasByFieldName('sBm');
			var sDh= thisdata.getFieldAliasByFieldName('sDh');
			var sDh1= thisdata.getFieldAliasByFieldName('sDh1');
			var sDh2= thisdata.getFieldAliasByFieldName('sDh2');
			var speed= thisdata.getFieldAliasByFieldName('speed');
			var sRealName= thisdata.getFieldAliasByFieldName('sRealName');
			var sRegDate= thisdata.getFieldAliasByFieldName('sRegDate');
			var thismonthtime= thisdata.getFieldAliasByFieldName('thismonthtime');
			var totaltime= thisdata.getFieldAliasByFieldName('totaltime');
			var UserName= thisdata.getFieldAliasByFieldName('UserName');
			var UserName1= thisdata.getFieldAliasByFieldName('UserName1');
			var Value= thisdata.getFieldAliasByFieldName('Value');
			var vlanid= thisdata.getFieldAliasByFieldName('vlanid');

			var Fee5= thisdata.getFieldAliasByFieldName('Fee5');
			var sBm2= thisdata.getFieldAliasByFieldName('sBm2');
			var sBm3= thisdata.getFieldAliasByFieldName('sBm3');	
			var sBm4= thisdata.getFieldAliasByFieldName('sBm4');
			var hth= thisdata.getFieldAliasByFieldName('hth');
				//隐藏域,给页面中存储字段的标签赋值	
			$("#iFeeType").html(iFeeType);		
			$("#Value").html(Value);
			$("#ipaddr").html(ipaddr);
			$("#vlanid").html(vlanid);
			$("#AcctStartTime").html(AcctStartTime);
			$("#AcctStopTime").html(AcctStopTime);		
			$("#PauseStartTime").html(PauseStartTime);
			$("#PauseStopTime").html(PauseStopTime);				
			$("#RemainFee").html(RemainFee);
			$("#PayType").html(PayType);			
			$("#iFeeType").html(iFeeType);		
			$("#sDh").html(sDh);
			$("#sRegDate").html(sRegDate);
			$("#sRealName").html(sRealName);
			$("#sBm").html(sBm);
			$("#sAddress").html(sAddress);
			$("#iStatus").html(iStatus);
			$("#iSimultaneous").html(iSimultaneous);
			$("#feeendtime").html(feeendtime);
			$("#iFeeTypeTime").html(iFeeTypeTime);
			$("#sDh1").html(sDh1);
			$("#sDh2").html(sDh2);
			$("#UserName1").html(UserName1);			
			$("#idtype").html(idtype);
			$("#idcard").html(idcard);
			$("#speed").html(speed);		
			$("#linkman").html(linkman);		
			$("#linkphone").html(linkphone);
			$("#mobile").html(mobile);
			$("#Fee5").html(Fee5);
			$("#sBm2").html(sBm2);
			$("#sBm3").html(sBm3);
			$("#sBm4").html(sBm4);
			$("#UserName").val(UserName);							
			$("#lUserName").html(UserName);
			$("#hth").html(hth);
			
			
			$("#UserNameq").html(UserName);
			$("#sRealNameq").html(sRealName);
			$("#sDhq").html(sDh);
			$("#sAddressq").html(sAddress);
			var col=[[],[]];
			col=getRb_Field('radcheck','id',"修改|删除|详细",'97','ziduans');;//得到jqGrid要显示的字段
		
		
		jQuery("#editgrid").jqGrid({	
				url:'mainServlet.html?'+urlstr+"&ziduans="+$("#ziduans").val(),
				datatype: 'xml', 
				colNames:col[0], 
				colModel:col[1], 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'sRegDate', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'<fmt:message key="dangan.title"/>', 
				       	height:300, //高
				       // width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();	
										addRowOperBtnimage('editgrid','openModify','id','click',1,"style/images/public/ltubiao_01.gif","修改","&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
										addRowOperBtnimage('editgrid','openDel','id','click',2,"style/images/public/ltubiao_02.gif",'删除',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openInfo','id','click',3,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;");//详细
										executeAddBtn('editgrid',3);
										 var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										 setAutoGridHeight("editgrid",reduceHeight);
										},
									ondblClickRow:function(rowid){
									var id=$("#editgrid").getCell(rowid,"id");
									openInfo(id);//详细
									}
				}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
					
			});
	
		/**
		* 显示详细信息操作
		* @param id
		* @return 无返回值
		*/
		function openInfo(id){		
		$("#id").val(id);
		
		$("#titlediv").html('详细');//标题
		markTable(1);//去掉帐号的红色*号		
		queryByAccount();//显示当前数据
		
		$("#tdiv input[type='text']").attr("disabled","disabled");
		$("#tdiv input[type='text']").removeClass();	
		$("#tdiv input[type='text']").addClass("textclass2");//所有input[type:text]类型的都去掉边框
		$("#iUserName").removeAttr("disabled");
		$("#iUserName").attr("readonly","readonly");
		infopan();
			
		}
	
           	///重新加载jQuery
			 function querylist(){
			 $("#fusearchsql").val("");
			  var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'danganM.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'danganM.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
			 	 setTimeout($.unblockUI, 15);//关闭面板
				$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+"&ziduans="+$("#ziduans").val()}).trigger("reloadGrid");
			
			 }
		 /**
		 * 判断时间大小
		 * @param one(第一个参数)
		 * @param two(第二个参数)
		 * @return 1:第一个参数大于第二个参数;-1:第一个参数小于于第二个参数;0:相等
		 */
		 function bijiao(one,two){
			 //去掉比秒还小的部分
			 one=one.substr(0,19); two=two.substr(0,19);
			 //去掉时间中所有非数字的项，
			 one = one.replace(new RegExp('-',"g"),'');
			 one = one.replace(new RegExp(' ',"g"),'');
			 one = one.replace(new RegExp(':',"g"),'');
			 two = two.replace(new RegExp('-',"g"),'');
			 two = two.replace(new RegExp(' ',"g"),'');
			 two = two.replace(new RegExp(':',"g"),'');
			 one=parseInt(one,10);two=parseInt(two,10);//时间转变十进制的可以比较的数字。
			 if(one>two) return 1;
			 if(one<two) return -1;
			 if(one==two) return 0;
		}
           	 /**
			 * 打开修改面板
			 * @param id
			 * @return 无返回值
			 */	
			 function openModify(id){
			  
				var editright = $("#editright").val();
				if(editright=="true"){
				$("#id").val(id);
				$("#titlediv").html('<fmt:message key="global.edit" />');//标题
				 modifylist();
				modifypan();
				$("#reset").show();$("#modify").show();$("#reset").show();
				//$("#tdiv input[type='text']").attr("readonly","");
				//$("#tdiv input[type='text']").removeClass();	$("#tdiv input[type='text']").addClass("textclass");			
				 queryByAccount();//显示当前数据
				 
				 //置所有字段为不可修改的。
				 $("#tdiv input[type='text']").attr("disabled","disabled");
				 $("#tdiv select").attr("disabled","disabled");
				 $("#tdiv input[type='text']").removeClass();	$("#tdiv input[type='text']").addClass("textclass2");
				  $("#tdiv select").removeClass();	$("#tdiv select").addClass("textclass2");
				var editfields = $("#editfields").val(); 
									/*************************************
									**   将当前表的所有字段取出来，分割字符串 ***
									*************************************/
							
									var fields = getFields("radcheck");	
																			
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
												 	$('#i'+arr[i]).removeAttr("disabled");	
												 	$('#i'+arr[i]).removeClass();	$('#i'+arr[i]).addClass("textclass");											
													break;
												}
											}
										}
									}
								
					//部门
				if($("#isBm2").val()==null){$("#isBm2").attr("disabled","disabled");$("#isBm3").attr("disabled","disabled");$("#isBm4").attr("disabled","disabled");}
				else if($("#isBm3").val()==null){$("#isBm3").attr("disabled","disabled");$("#isBm4").attr("disabled","disabled");}
				else if($("#isBm4").val()==null){$("#isBm4").attr("disabled","disabled");}
				
					var userid=$("#userid").val();//当前用户
					if(userid!="admin"){//如果当前用户不是admin，帐号一项是不可修改的。
						$("#iUserName").removeAttr("disabled");
						$("#iUserName").attr("readonly","readonly");
						markTable(1);//红色*号		
						$("#iUserName").removeClass();$("#iUserName").addClass("textclass2");				
					}else{//如果当前用户是admin，帐号一项是可修改的。
						$("#iUserName").removeAttr("disabled");	
						markTable(0);//红色*号
						$("#iUserName").removeClass();$("#iUserName").addClass("textclass");	
					}
					//宽带
					$("#ispeed").attr("disabled","disabled");
					$("#ispeed").removeClass();$("#ispeed").addClass("textclass2");
					//合同号
					$("#ihth").attr("disabled","disabled");
					$("#ihth").removeClass();$("#ihth").addClass("textclass2");		
					
			 	}else{
			 			
						var operationtips = $("#operationtips").val();
						var editpower = $("#editpower").val();
						jAlert(editpower,operationtips);
					}
			 }
  		  /**
		   * 删除某条记录
		   * @param id
		   * @return 无返回值
		   */	
  		  function openDel(id){  	
  			var deleteright = $("#deleteright").val();
  			/**************************
				 	*    是否有执行删除的权限    *
				 	*************************/
		if(deleteright=="true"){		
		$("#id").val(id);			
  		  
  		 if(confirm("<fmt:message key="global.alert.del"/>?")){  		
  		 var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'broadband',
						 					tsdcf:'mysql',
						 					tsdoper:'exe',				 	
											tsdpk:'danganM.delByAccount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
		
			urlstr=urlstr+"&id="+id;
		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
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
					var info=$("#addh").val();		
					logwrite(2,"id:"+id);
					querylist();										
					}
					
					}});
		}
		
			
					}else{
						var operationtips = $("#operationtips").val();
						var deletepower = $("#deletepower").val();	
									
						jAlert(deletepower,operationtips);
					}
		
		
			
  		 }
  	
  		       /***********************************集成操作**********************
               **********************************************************************************/               
          
               	/**
		   		 * 执行复合查询出提交过来的相应操作
		   		 * @param 无参数
		  		 * @return 无返回值
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
		   	 * 组合排序
		   	 * @param sqlstr(拼接出的排序条件)
		  	 * @return 无返回值
		   	 */	
			function zhOrderExe(sqlstr){
				
					var params = fuheQbuildParams();			
						if(params=='&fusearchsql='){
							params +='1=1';
						}
				 params =params+'&tsdOrderby='+sqlstr;			    
				 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mysql',//指向配置文件名称
												  tsdoper:'query',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'danganM.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												  tsdpkpagesql:'danganM.queryByOrderpage'
												});
					var link = urlstr1 + params;					
				 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+"&ziduans="+$("#ziduans").val()}).trigger("reloadGrid");
				 	//setTimeout($.unblockUI, 15);//关闭面板
				 	
			}
			/**
		   	 * 复合查询操作
		   	 * @param 无参数
		  	 * @return 无返回值
		   	 */	
			function fuheQuery()
			{	
				var params = fuheQbuildParams();
					 		
				if(params=='&fusearchsql='){
					params +='1=1';
				}	
				 
				 
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'danganM.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'danganM.fuheQueryByWherepage'
											});
				var link = urlstr1 + params;	
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+"&ziduans="+$("#ziduans").val()}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板			
			}
			
			/**
		   	 * 复合查询的批量删除操作
		   	 * @param 无参数
		  	 * @return 无返回值
		   	 */
			function fuheDel(){
				
				var deleteinformation = $("#deleteinformation").val();
				var operationtips = $("#operationtips").val();	
				//jConfirm("确认要删除?",'提示对话框',function(x)
				jConfirm(deleteinformation,operationtips,function(x){
			 		if(x==true)
			 		{	
			 		var params = fuheQbuildParams();	    
			 		//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
				 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mysql',//指向配置文件名称
												  tsdoper:'exe',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'danganM.fuheDeleteBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												  
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
									logwrite(4,"<fmt:message key="oper.condition"/>:"+$("#areah").val());	
									querylist();	
								}	
							}
						});
					}
				});	
			
			}
			
			/**
		   	 * 打开复合批量修改面板
		   	 * @param 无参数
		  	 * @return 无返回值
		   	 */
			function fuheOpenModify()
			{
				$("#iStatushidden").val("");//存放用户状态的值的隐藏域置空。可以使打开批量修改面板中用户状态的下拉列表值为0,1
				clear();//清空表单数据	
				$("#titlediv").html('<fmt:message key="tariff.modifyb" />');//标题
				modifypan();
				markTable(1);
				$("#modifyB").show();
				//所有字段为不可修改
				 $("#tdiv input[type='text']").attr("disabled","disabled");
				 $("#tdiv select").attr("disabled","disabled");
				 $("#tdiv input[type='text']").removeClass();	$("#tdiv input[type='text']").addClass("textclass2");
									var editfields = $("#editfields").val(); 
										/*************************************
										**   将当前表的所有字段取出来，分割字符串 ***
										*************************************/
										
										var fields = getFields("radcheck");	
																				
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
														$('#i'+arr[i]).removeAttr("disabled");	
														 $('#i'+arr[i]).removeClass();	$('#i'+arr[i]).addClass("textclass");											
														break;
													}
												}
											}
										}
						//部门
				if($("#isBm2").val()==null){$("#isBm2").attr("disabled","disabled");$("#isBm3").attr("disabled","disabled");$("#isBm4").attr("disabled","disabled");}
				else if($("#isBm3").val()==null){$("#isBm3").attr("disabled","disabled");$("#isBm4").attr("disabled","disabled");}
				else if($("#isBm4").val()==null){$("#isBm4").attr("disabled","disabled");}
					$("#iUserName").removeAttr("disabled");//帐号
					$("#iUserName").attr("readonly","readonly");
					$("#iUserName").removeClass();$("#iUserName").addClass("textclass2");
					
					$("#isDh").attr("disabled","disabled");//帐号
					$("#isDh").removeClass();$("#isDh").addClass("textclass2");
					//宽带
					$("#ispeed").attr("disabled","disabled");
					$("#ispeed").removeClass();$("#ispeed").addClass("textclass2");	
					//合同号
					$("#ihth").attr("disabled","disabled");
					$("#ihth").removeClass();$("#ihth").addClass("textclass2");	
				
  			}
			/**
		   	 * 批量修改操作
		   	 * @param 无参数
		  	 * @return 无返回值
		   	 */
			function fuheModify(){
		
				tsd.QualifiedVal=true;				
  				///var fp=self.opener.document.getElementById("fusearchsql").value;
  				var fp=$("#fusearchsql").val();
  				fp=encodeURIComponent(fp);  			
				if(tsd.Qualified()==false){return false;} 									
				var p = fuheBuildParam();
				if(p==false) return false;
				var param="";
				param=param+p+"&fusearchsql="+fp;			
				var urlstr=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'exe',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'danganM.fuheModifyBy'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											});
			 	urlstr+=param;	
			 
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&id="+$("#fuheid").val(),
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
						if(msg=="true"){
							var operationtips = $("#operationtips").val();
							var successful = $("#successful").val();
							alert(successful,operationtips);					
							closeo();
							var str ="(radcheck)(<fmt:message key='tariff.modifyb'/>)。"+"<fmt:message key='global.newVal'/>: "+$("#logoldstr").val()+"<fmt:message key='global.conditions'/> ："+$("#fusearchsql").val();
							str = transferApos(str);
							writeLogInfo("","Batch Edit",tsd.encodeURIComponent(str));
							
						fuheQuery();
						}	
					}
				});
			}
			/*****************************************************************************************************
               *****************导出
               **************************************************************************************************/
             /**
		   	  * 复合查询参数获取
		   	  * @param 无参数
		  	  * @return String
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
	 * 打印操作
	 * @param 无参数
	 * @return 无返回值
	 */
	function print(){
			//printThisReport("userManagement/tsddanganM",getPriParams());
			printThisReport1('<%=request.getParameter("imenuid")%>',
				'vw_radcheck',getPriParams(),
				'<%=(String)session.getAttribute("userid")%>',
				'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
				'<%=(String)session.getAttribute("departname")%>');			
			
	}
	
	/*************************pan1
	*************************/

           	/**
			 * 	onblur事件
			 * @param 无参数
			 * @return 无返回值
			 */
           	function acblur(){           	
           	var str=$("#iUserName").val();          
           	if(!isExistByA(str)){
           	 alert($("#UserName").val()+"<fmt:message key="accountM.alert.userExist"/>");
           	 $("#iUserName").focus();
           	 }
           	}
        /**
		 * 拼接参数
		 * @param 无参数
		 * @return 无返回值
		 */   	
        function buildParam(){
          		
           	tsd.QualifiedVal=true;  	
			var str="";	
		  	var UserName=$("#iUserName").val();
		  	if(UserName!=""&&UserName!=null){UserName=tsd.encodeURIComponent(UserName);}
		    str=str+"&UserName="+UserName;
			var FeeType=$("#iFeeType").val();
			if(FeeType==null||FeeType=="") FeeType='-1';
			str=str+"&FeeType="+FeeType;		
			var Value=$("#iValue").val();
			if(Value!=""&&Value!=null){Value=tsd.encodeURIComponent(Value);}
			str=str+"&Value="+Value;	
			var ipaddr=$("#iipaddr").val();
			str=str+"&ipaddr="+ipaddr;	
			var vlanid=$("#ivlanid").val();
			if(vlanid!=""&&vlanid!=null){vlanid=tsd.encodeURIComponent(vlanid);}
			str=str+"&vlanid="+vlanid;	
			var AcctStartTime=$("#iAcctStartTime").val();
			if(AcctStartTime==null||AcctStartTime=="") AcctStartTime='1990-01-01 00:00:00.0';
			str=str+"&AcctStartTime="+AcctStartTime;	
			var AcctStopTime=$("#iAcctStopTime").val();	
			if(AcctStopTime==null||AcctStopTime=="") AcctStopTime='1990-01-01 00:00:00.0';
			str=str+"&AcctStopTime="+AcctStopTime;	
			var PauseStartTime=$("#iPauseStartTime").val();
			
			if(PauseStartTime==null||PauseStartTime=="") PauseStartTime='1990-01-01 00:00:00';
			str=str+"&PauseStartTime="+PauseStartTime;	
			var PauseStopTime=$("#iPauseStopTime").val();
			if(PauseStopTime==null||PauseStopTime=="") PauseStopTime='1990-01-01 00:00:00.0';
			str=str+"&PauseStopTime="+PauseStopTime;				
			var RemainFee=$("#iRemainFee").val();
			if(RemainFee==null||RemainFee=="") RemainFee=0;
			str=str+"&RemainFee="+RemainFee;
			var PayType=$("#iPayType").val();	
			if(PayType!=""&&PayType!=null){PayType=tsd.encodeURIComponent(PayType);}
			str=str+"&PayType="+PayType;	
			var iFeeType=$("#iiFeeType").val();	
			if(iFeeType==null||iFeeType=="") iFeeType='-1';
			str=str+"&iFeeType="+iFeeType;
			var sDh=$("#isDh").val();
			if(sDh!=""&&sDh!=null){sDh=tsd.encodeURIComponent(sDh);}
			str=str+"&sDh="+sDh;
			var sRegDate=$("#isRegDate").val();
			if(sRegDate==null||sRegDate=="") sRegDate='1990-01-01 00:00:00';
			str=str+"&sRegDate="+sRegDate;
			var sRealName=$("#isRealName").val();
			if(sRealName!=""&&sRealName!=null){sRealName=tsd.encodeURIComponent(sRealName);}
			str=str+"&sRealName="+sRealName;
			var sBm=$("#isBm option[selected]").text();
			if(sBm!=""&&sBm!=null){sBm=tsd.encodeURIComponent(sBm);}		
			str=str+"&sBm="+sBm;
			var hth=$("#ihth").val();
			if(hth!=""&&hth!=null){hth=tsd.encodeURIComponent(hth);}		
			str=str+"&hth="+hth;
			var sAddress=$("#isAddress").val();
			if(sAddress!=""&&sAddress!=null){sAddress=tsd.encodeURIComponent(sAddress);}
			str=str+"&sAddress="+sAddress;
			var iStatus=$("#iiStatus").val();
			if(iStatus!=""&&iStatus!=null){iStatus=tsd.encodeURIComponent(iStatus);}
			str=str+"&iStatus="+iStatus;
			var iSimultaneous=$("#iiSimultaneous").val();	
			if(iSimultaneous==null||iSimultaneous=="") iSimultaneous=0;
			str=str+"&iSimultaneous="+iSimultaneous;
			var feeendtime=$("#ifeeendtime").val();
			if(feeendtime==null||feeendtime=="") feeendtime='1990-01-01 00:00:00.0';
			str=str+"&feeendtime="+feeendtime;
			var iFeeTypeTime=$("#iiFeeTypeTime").val();
			if(iFeeTypeTime==""||iFeeTypeTime==null) iFeeTypeTime='1990-01-01 00:00:00.0';
			str=str+"&iFeeTypeTime="+iFeeTypeTime;
			var sDh1=$("#isDh1").val();
			if(sDh1!=""&&sDh1!=null){sDh1=tsd.encodeURIComponent(sDh1);}
		 	str=str+"&sDh1="+sDh1;		
			var sDh2=$("#isDh2").val();
			if(sDh2!=""&&sDh2!=null){sDh2=tsd.encodeURIComponent(sDh2);}
			str=str+"&sDh2="+sDh2;
			var UserName1=$("#iUserName1").val();	
			if(UserName1!=""&&UserName1!=null){UserName1=tsd.encodeURIComponent(UserName1);}
			str=str+"&UserName1="+UserName1;	
			var idtype=$("#iidtype").val();
			if(idtype!=""&&idtype!=null){idtype=tsd.encodeURIComponent(idtype);}
			str=str+"&idtype="+idtype;
			var idcard=$("#iidcard").val();
			if(idcard!=""&&idcard!=null){idcard=tsd.encodeURIComponent(idcard);}
			str=str+"&idcard="+idcard;
			var speed=$("#ispeed").val();
			if(speed.indexOf('M')!=-1){	
					speed=MCoversion(speed);//显示(将M数转化成数字)	
					
			}		
			if(speed==""||speed==null){	
				speed="0";
			}
				str=str+"&speed="+speed;
			
			var linkman=$("#ilinkman").val();	
			if(linkman!=""&&linkman!=null){linkman=tsd.encodeURIComponent(linkman);}	
			str=str+"&linkman="+linkman;
			var linkphone=$("#ilinkphone").val();
			if(linkphone!=""&&linkphone!=null){linkphone=tsd.encodeURIComponent(linkphone);}	
			str=str+"&linkphone="+linkphone;
			var mobile=$("#imobile").val();
			if(mobile!=""&&mobile!=null){mobile=tsd.encodeURIComponent(mobile);}	
			str=str+"&mobile="+mobile;
			var Fee5=$("#iFee5").val();
			if(Fee5==""||Fee5==null) Fee5='0';
			if(Fee5!=""&&Fee5!=null){Fee5=tsd.encodeURIComponent(Fee5);}	
			str=str+"&Fee5="+Fee5;
			//var sBm2=$("#isBm2").val();
			var sBm2=$("#isBm2 option[selected]").text();
			if(sBm2!=""&&sBm2!=null){sBm2=tsd.encodeURIComponent(sBm2);}	
			else{sBm2="";}	
			str=str+"&sBm2="+sBm2;
			//var sBm3=$("#isBm3").val();
			var sBm3=$("#isBm3 option[selected]").text();
			if(sBm3!=""&&sBm3!=null){sBm3=tsd.encodeURIComponent(sBm3);}	
			else{sBm3="";}	
			str=str+"&sBm3="+sBm3;
			//var sBm4=$("#isBm4").val();
			var sBm4=$("#isBm4 option[selected]").text();
			if(sBm4!=""&&sBm4!=null){sBm4=tsd.encodeURIComponent(sBm4);}
			else{sBm4="";}	
			str=str+"&sBm4="+sBm4;
		  		 //每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
					/////验证
		  	if(UserName==""){  	
		  			alert($("#UserName").val()+"<fmt:message key="global.notNull"/>");
		  			return false;
		  	} 
			/**
		  	if(ipaddr!=""&&!isIP(ipaddr)){
		  		alert($("#ipaddr").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
		  	}
		  	 if(vlanid!=""&&!isIP(vlanid)){
		  		alert($("#vlanid").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
		  	}**/
		  	
		  
		  	if(sDh!=""&&!checksDh()) return false;//验证绑定电话
		  	
		  	if(!subFF("RemainFee",12,2)){return false;}
			if(!subFF("Fee5",12,2)){return false;}
		  
		  		  /**	if(mobile!=""&&!checkTel(mobile)){
		  		alert($("#mobile").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
		  	}
			if(linkphone!=""&&!checkTel(linkphone)){
		  		alert($("#linkphone").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
		  	}**/
		  	tsd.QualifiedVal=true; 
		  	
				///修改时记录的日志
				var info1=tsd.encodeURIComponent($("#UserName").val()+":"+$("#UserNameoh").val()+" >>> "+UserName+" ");						
				$("#edith").val(info1);		
			//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;} 
					
		  		return str;
		  		
		  	
           		}
         
		/**
		 * 判断一个账号是否有重复
		 * @param ac(账号)
		 * @return boolean(没有重复的返回true,否则返回false)
		 */ 	 
  		 function isExistByA(ac){
  		 tsd.QualifiedVal=true;  
  		 var flag=true;
  		 var id=$("#id").val();
  		 if(ac!=""&&ac!=null) ac=tsd.encodeURIComponent(ac);
  		 if(tsd.Qualified()==false){return false;} 
  		 var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'broadband',
						 					tsdcf:'mysql',
						 					tsdoper:'query',
						 					datatype:'xmlattr',				 	
											tsdpk:'danganM.queryAll'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});		
		urlstr=urlstr+"&id="+id;		
				$.ajax({
					url:'mainServlet.html?'+urlstr+"&UserName="+ac,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){							
							var UserName=$(this).attr("value");							
							if(UserName!=undefined) {
								flag=false;	
								return false;
							}																			
						});		
				
					}});				
					return flag;
					
  		 }
  		 /**
		 * 显示某条数据的日志,弹出修改面板显示的数据
		 * @param 无参数
		 * @return String
		 */ 
  		 function queryByAccount(){  
  		 	
  		 var info="";	
  		 var id=$("#id").val();  	
  		 var urlstr=tsd.buildParams({packgname:'service',
						 				clsname:'ExecuteSql',
						 				method:'exeSqlData',
						 				ds:'broadband',
						 				tsdcf:'mysql',
						 				tsdoper:'query',
						 				datatype:'xmlattr',				 	
										tsdpk:'danganM.queryById'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
						
		
		
			urlstr=urlstr+"&id="+id;
		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){												
								var UserName=$(this).attr("username");
								var iFeeStopType=$(this).attr("ifeestoptype");	
								var iFeeType=$(this).attr("ifeetype");
								var Value=$(this).attr("value");	
								var ipaddr=$(this).attr("ipaddr");	
								var vlanid=$(this).attr("vlanid");	
								var AcctStartTime=$(this).attr("acctstarttime");	
								var AcctStopTime=$(this).attr("acctstoptime");	
								var PauseStartTime=$(this).attr("pausestarttime");	
								var PauseStopTime=$(this).attr("pausestoptime");	
								var RemainFee=$(this).attr("remainfee");	
								var PayType=$(this).attr("paytype");	
								var iFeeType=$(this).attr("ifeetype");	
								var sDh=$(this).attr("sdh");	
								var sRegDate=$(this).attr("sregdate");	
								var sRealName=$(this).attr("srealname");	
								var sBm=$(this).attr("sbm");
								var sAddress=$(this).attr("saddress");	
								var iStatus=$(this).attr("istatus");	
								var iMacAutoBand=$(this).attr("imacautoband");	
								var iSimultaneous=$(this).attr("isimultaneous");							
								var RemainTime=$(this).attr("remaintime");	
								var thismonthtime=$(this).attr("thismonthtime");	
								var nextmonthtime=$(this).attr("nextmonthtime");	
								var totaltime=$(this).attr("totaltime");	
								var feeendtime=$(this).attr("feeendtime");	
								var iFeeTypeTime=$(this).attr("ifeetypetime");	
								var iFeeType1=$(this).attr("ifeetype1");							
								var sDh1=$(this).attr("sdh1");	
								var sDh2=$(this).attr("sdh2");	
								var UserName1=$(this).attr("username1");									
								var idtype=$(this).attr("idtype");	
								var idcard=$(this).attr("idcard");	
								var speed=$(this).attr("speed");	
								var mobile=$(this).attr("mobile");
								var linkphone=$(this).attr("linkphone");
								var linkman=$(this).attr("linkman");
								var Fee5=$(this).attr("fee5");							
								var sBm2=$(this).attr("sbm2");var sBm3=$(this).attr("sbm3");var sBm4=$(this).attr("sbm4");
								var hth=$(this).attr("hth");
								$("#iUserName").val(UserName);						
								$("#iiFeeType").val(iFeeType);							
								$("#iValue").val(Value);
								$("#iipaddr").val(ipaddr);
								$("#ivlanid").val(vlanid);
								if(AcctStartTime=='1990-01-01 00:00:00.0'){
									$("#iAcctStartTime").val("");
								}else{
									$("#iAcctStartTime").val(AcctStartTime);
								}
								if(AcctStopTime=='1990-01-01 00:00:00.0'){
									$("#iAcctStopTime").val("");
								}else{
									$("#iAcctStopTime").val(AcctStopTime);	
								}	
								if(PauseStartTime=='1990-01-01 00:00:00.0'){
									$("#iPauseStartTime").val("");
								}else{
									$("#iPauseStartTime").val(PauseStartTime);
								}
								if(PauseStopTime=='1990-01-01 00:00:00.0'){
									$("#iPauseStopTime").val("");
								}else{
									$("#iPauseStopTime").val(PauseStopTime);	
								}						
								$("#iRemainFee").val(RemainFee);
								$("#iPayType").val(PayType);								
								//catOption(id,iFeeType,iFeeStopType);						
								$("#isDh").val(sDh);
								if(sRegDate=='1990-01-01 00:00:00.0'){
									$("#isRegDate").val("");
								}else{
									$("#isRegDate").val(sRegDate);
								}
								$("#isRealName").val(sRealName);
								
								$("#isAddress").val(sAddress);
								$("#iiSimultaneous").val(iSimultaneous);
								if(feeendtime=='1990-01-01 00:00:00.0'){
									$("#ifeeendtime").val("");
								}else{
									$("#ifeeendtime").val(feeendtime);
								}
								if(iFeeTypeTime=='1990-01-01 00:00:00.0'){
									$("#iiFeeTypeTime").val("");
								}else{
									$("#iiFeeTypeTime").val(iFeeTypeTime);
								}					
								$("#isDh1").val(sDh1);
								$("#isDh2").val(sDh2);
								$("#iUserName1").val(UserName1);								
								$("#iidtype").val(idtype);
								$("#iidcard").val(idcard);
								var con=speedConversion(speed);//带宽转换（将数字转换成M数）
								if(isNaN(con.replace('M',''))){con="";}//如果不是数字	
															
								$("#ispeed").val(con);
								
								$("#imobile").val(mobile);
								$("#ilinkphone").val(linkphone);
								$("#ilinkman").val(linkman);		
								$("#iFee5").val(Fee5);
								//部门
								$("#ihth").val(hth);
								querybyaccountBumen(sBm,sBm2,sBm3,sBm4);//三个部门的关联显示
								//$("#iStatus").val(iStatus);
								$("#iPayType").val(PayType);
								$("#isDh1").val(sDh1);
								$("#iiFeeType").val(iFeeType);
								////修改操作记录日志时，保存旧数据
								$("#idoh").val(id);
								$("#UserNameoh").val(UserName);								
								$("#ipaddroh").val(ipaddr);
								$("#vlanidoh").val(vlanid);
								$("#sRealNameoh").val(sRealName);
							    var info=$("#UserName").val()+":"+UserName;						
								//下拉列表中数据
								$("#iStatushidden").val(iStatus);//存在hidden里
								
								$("#addh").val(info);
						});						
				
					}});
					
					return info;
  		 }
  	/**
	 * 用户状态修改
	 * @param 无参数
	 * @return 无返回值
	 */ 
  	function modify1(){
  	
  		var id=$("#id").val();	
  		var UserName=$("#iUserName").val();
  		if(!isExistByA(UserName)){ 
  			 alert($("#UserName").val()+"<fmt:message key='accountM.alert.userExist'/>");
           	 $("#iUserName").focus();
           	 return false;
           	 }  		
  			var str=buildParam();
  		if(str==false) return false;
  		if(notchange==true){//用户状态能修改
					var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'broadband',
						 					tsdcf:'mysql',
						 					tsdoper:'exe',				 	
											tsdpk:'danganM.updateByAccount'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
			}else{
			var urlstr=tsd.buildParams({packgname:'service',
						 					clsname:'ExecuteSql',
						 					method:'exeSqlData',
						 					ds:'broadband',
						 					tsdcf:'mysql',
						 					tsdoper:'exe',				 	
											tsdpk:'danganM.updateByAccount.noiStatus'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
					
			}
			
			urlstr=urlstr+str+"&id="+id;
		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
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
							closeo();	
						var log=$("#edith").val();
						logwrite(3,log);	
						querylist();	
												
					
					}
					
					}});
  		}
  		 
  		
			/**
			 * 拼接参数
			 * @param 无参数
			 * @return String
			 */ 
           	function fuheBuildParam(){
           	var params="";	
           	tsd.QualifiedVal=true;  
           	var modifyStr="set";
			var modifySet='set';
			var FeeType=$("#iFeeType").val();
			if(FeeType!=""&&modifySet=="set"){
			modifySet=modifySet+" FeeType="+FeeType;	
			modifyStr=modifyStr+" FeeType="+FeeType;	
			}else if(FeeType!=""&&modifySet!="set"){
			modifySet=modifySet+", FeeType="+FeeType;	
			modifyStr=modifyStr+" FeeType="+FeeType;	
			}	
			var Value=$("#iValue").val();
			if(Value!=""&&modifySet=="set"){
			modifySet=modifySet+' Value=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' Value=\''+Value+'\'';
			}else if(Value!=""&&modifySet!="set"){
			modifySet=modifySet+', Value=\''+tsd.encodeURIComponent(Value)+'\'';
			modifyStr=modifyStr+' Value=\''+Value+'\'';
			}				
			var ipaddr=$("#iipaddr").val();
			if(ipaddr!=""&&modifySet=="set"){
			modifySet=modifySet+' ipaddr=\''+tsd.encodeURIComponent(ipaddr)+'\'';
			modifyStr=modifyStr+' ipaddr=\''+ipaddr+'\'';
			}else if(ipaddr!=""&&modifySet!="set"){
			modifySet=modifySet+', ipaddr=\''+tsd.encodeURIComponent(ipaddr)+'\'';
			modifyStr=modifyStr+' ipaddr=\''+ipaddr+'\'';
			}	
			var vlanid=$("#ivlanid").val();
			if(vlanid!=""&&modifySet=="set"){
			modifySet=modifySet+' vlanid=\''+tsd.encodeURIComponent(vlanid)+'\'';
			modifyStr=modifyStr+' vlanid=\''+vlanid+'\'';
			}else if(vlanid!=""&&modifySet!="set"){
			modifySet=modifySet+', vlanid=\''+tsd.encodeURIComponent(vlanid)+'\'';
			modifyStr=modifyStr+' vlanid=\''+vlanid+'\'';
			}
			var AcctStartTime=$("#iAcctStartTime").val();
			if(AcctStartTime!=""&&modifySet=="set"){
			modifySet=modifySet+" AcctStartTime=\'"+AcctStartTime+'\'';	
			modifyStr=modifyStr+" AcctStartTime=\'"+AcctStartTime+'\'';	
			}else if(AcctStartTime!=""&&modifySet!="set"){
			modifySet=modifySet+", AcctStartTime=\'"+AcctStartTime+'\'';	
			modifyStr=modifyStr+" AcctStartTime=\'"+AcctStartTime+'\'';	
			}		
			var AcctStopTime=$("#iAcctStopTime").val();	
			if(AcctStopTime!=""&&modifySet=="set"){
			modifySet=modifySet+" AcctStopTime=\'"+AcctStopTime+'\'';	
			modifyStr=modifyStr+" AcctStopTime=\'"+AcctStopTime+'\'';	
			}else if(AcctStopTime!=""&&modifySet!="set"){
			modifySet=modifySet+", AcctStopTime=\'"+AcctStopTime+'\'';	
			modifyStr=modifyStr+" AcctStopTime=\'"+AcctStopTime+'\'';	
			}
			var PauseStartTime=$("#iPauseStartTime").val();
			
			if(PauseStartTime!=""&&modifySet=="set"){
			modifySet=modifySet+" PauseStartTime=\'"+PauseStartTime+'\'';	
			modifyStr=modifyStr+" PauseStartTime=\'"+PauseStartTime+'\'';	
			}else if(PauseStartTime!=""&&modifySet!="set"){
			modifySet=modifySet+", PauseStartTime=\'"+PauseStartTime+'\'';	
			modifyStr=modifyStr+" PauseStartTime=\'"+PauseStartTime+'\'';	
			}
			var PauseStopTime=$("#iPauseStopTime").val();
			if(PauseStopTime!=""&&modifySet=="set"){
			modifySet=modifySet+" PauseStopTime=\'"+PauseStopTime+'\'';	
			modifyStr=modifyStr+" PauseStopTime=\'"+PauseStopTime+'\'';	
			}else if(PauseStopTime!=""&&modifySet!="set"){
			modifySet=modifySet+", PauseStopTime=\'"+PauseStopTime+'\'';	
			modifyStr=modifyStr+" PauseStopTime=\'"+PauseStopTime+'\'';	
			}				
			var RemainFee=$("#iRemainFee").val();
			if(RemainFee!=""&&modifySet=="set"){
			modifySet=modifySet+" RemainFee=\'"+RemainFee+'\'';	
			modifyStr=modifyStr+" RemainFee=\'"+RemainFee+'\'';	
			}else if(RemainFee!=""&&modifySet!="set"){
			modifySet=modifySet+", RemainFee=\'"+RemainFee+'\'';	
			modifyStr=modifyStr+" RemainFee=\'"+RemainFee+'\'';	
			}	
			var PayType=$("#iPayType").val();	
			if(PayType!=""&&modifySet=="set"){
			modifySet=modifySet+' PayType=\''+tsd.encodeURIComponent(PayType)+'\'';
			modifyStr=modifyStr+' PayType=\''+PayType+'\'';
			}else if(PayType!=""&&modifySet!="set"){
			modifySet=modifySet+', PayType=\''+tsd.encodeURIComponent(PayType)+'\'';
			modifyStr=modifyStr+' PayType=\''+PayType+'\'';
			}					
			var iFeeType=$("#iiFeeType").val();	
			if(iFeeType!=""&&modifySet=="set"&&iFeeType!=-1){
			modifySet=modifySet+" iFeeType="+iFeeType+'';	
			modifyStr=modifyStr+" iFeeType=\'"+iFeeType+'\'';	
			}else if(iFeeType!=""&&modifySet!="set"){
			modifySet=modifySet+", iFeeType="+iFeeType+'';	
			modifyStr=modifyStr+" iFeeType=\'"+iFeeType+'\'';	
			}
			var sDh=$("#isDh").val();
			if(sDh!=""&&modifySet=="set"){
			modifySet=modifySet+' sDh=\''+tsd.encodeURIComponent(sDh)+'\'';
			modifyStr=modifyStr+' sDh=\''+sDh+'\'';
			}else if(sDh!=""&&modifySet!="set"){
			modifySet=modifySet+', sDh=\''+tsd.encodeURIComponent(sDh)+'\'';
			modifyStr=modifyStr+' sDh=\''+sDh+'\'';
			}	
			var sRegDate=$("#isRegDate").val();
			if(sRegDate!=""&&modifySet=="set"){
			modifySet=modifySet+" sRegDate=\'"+sRegDate+'\'';	
			modifyStr=modifyStr+" sRegDate=\'"+sRegDate+'\'';	
			}else if(sRegDate!=""&&modifySet!="set"){
			modifySet=modifySet+", sRegDate=\'"+sRegDate+'\'';	
			modifyStr=modifyStr+" sRegDate=\'"+sRegDate+'\'';	
			}
			var sRealName=$("#isRealName").val();
			if(sRealName!=""&&modifySet=="set"){
			modifySet=modifySet+' sRealName=\''+tsd.encodeURIComponent(sRealName)+'\'';
			modifyStr=modifyStr+' sRealName=\''+sRealName+'\'';
			}else if(sRealName!=""&&modifySet!="set"){
			modifySet=modifySet+', sRealName=\''+tsd.encodeURIComponent(sRealName)+'\'';
			modifyStr=modifyStr+' sRealName=\''+sRealName+'\'';
			}	
			var sBm=$("#isBm option[selected]").text();
			if($("#isBm option[selected]").val()!=""&&modifySet=="set"){
			modifySet=modifySet+' sBm=\''+tsd.encodeURIComponent(sBm)+'\'';
			modifyStr=modifyStr+' sBm=\''+sBm+'\'';
			}else if($("#isBm option[selected]").val()!=""&&modifySet!="set"){
			modifySet=modifySet+', sBm=\''+tsd.encodeURIComponent(sBm)+'\'';
			modifyStr=modifyStr+' sBm=\''+sBm+'\'';
			}
			var hth=$("#ihth").val();
			if(hth!=""&&modifySet=="set"){
			modifySet=modifySet+' hth=\''+tsd.encodeURIComponent(hth)+'\'';
			modifyStr=modifyStr+' hth=\''+hth+'\'';
			}else if(hth!=""&&modifySet!="set"){
			modifySet=modifySet+', hth=\''+tsd.encodeURIComponent(hth)+'\'';
			modifyStr=modifyStr+' hth=\''+hth+'\'';
			}	
			
			var sAddress=$("#isAddress").val();
			if(sAddress!=""&&modifySet=="set"){
			modifySet=modifySet+' sAddress=\''+tsd.encodeURIComponent(sAddress)+'\'';
			modifyStr=modifyStr+' sAddress=\''+sAddress+'\'';
			}else if(sAddress!=""&&modifySet!="set"){
			modifySet=modifySet+', sAddress=\''+tsd.encodeURIComponent(sAddress)+'\'';
			modifyStr=modifyStr+' sAddress=\''+sAddress+'\'';
			}	
			var iStatus=$("#iiStatus").val();
			if(iStatus!=""&&modifySet=="set"){
			modifySet=modifySet+' iStatus=\''+tsd.encodeURIComponent(iStatus)+'\'';
			modifyStr=modifyStr+' iStatus=\''+iStatus+'\'';
			}else if(iStatus!=""&&modifySet!="set"){
			modifySet=modifySet+', iStatus=\''+tsd.encodeURIComponent(iStatus)+'\'';
			modifyStr=modifyStr+' iStatus=\''+iStatus+'\'';
			}	
			var iSimultaneous=$("#iiSimultaneous").val();	
			if(iSimultaneous!=""&&modifySet=="set"){
			modifySet=modifySet+' iSimultaneous='+tsd.encodeURIComponent(iSimultaneous);
			modifyStr=modifyStr+' iSimultaneous=\''+iSimultaneous+'\'';
			}else if(iSimultaneous!=""&&modifySet!="set"){
			modifySet=modifySet+', iSimultaneous='+tsd.encodeURIComponent(iSimultaneous);
			modifyStr=modifyStr+' iSimultaneous=\''+iSimultaneous+'\'';
			}	
			var feeendtime=$("#ifeeendtime").val();
			if(feeendtime!=""&&modifySet=="set"){
			modifySet=modifySet+' feeendtime=\''+tsd.encodeURIComponent(feeendtime)+'\'';
			modifyStr=modifyStr+' feeendtime=\''+feeendtime+'\'';
			}else if(feeendtime!=""&&modifySet!="set"){
			modifySet=modifySet+', feeendtime=\''+tsd.encodeURIComponent(feeendtime)+'\'';
			modifyStr=modifyStr+' feeendtime=\''+feeendtime+'\'';
			}
			var iFeeTypeTime=$("#iiFeeTypeTime").val();
			if(iFeeTypeTime!=""&&modifySet=="set"){
			modifySet=modifySet+' iFeeTypeTime=\''+tsd.encodeURIComponent(iFeeTypeTime)+'\'';
			modifyStr=modifyStr+' iFeeTypeTime=\''+iFeeTypeTime+'\'';
			}else if(iFeeTypeTime!=""&&modifySet!="set"){
			modifySet=modifySet+', iFeeTypeTime=\''+tsd.encodeURIComponent(iFeeTypeTime)+'\'';
			modifyStr=modifyStr+' iFeeTypeTime=\''+iFeeTypeTime+'\'';
			}
			var sDh1=$("#isDh1").val();
			if(sDh1!=""&&modifySet=="set"){
			modifySet=modifySet+' sDh1=\''+tsd.encodeURIComponent(sDh1)+'\'';
			modifyStr=modifyStr+' sDh1=\''+sDh1+'\'';
			}else if(sDh1!=""&&modifySet!="set"){
			modifySet=modifySet+', sDh1=\''+tsd.encodeURIComponent(sDh1)+'\'';
			modifyStr=modifyStr+' sDh1=\''+sDh1+'\'';
			}			
			var sDh2=$("#isDh2").val();
			if(sDh2!=""&&modifySet=="set"){
			modifySet=modifySet+' sDh2=\''+tsd.encodeURIComponent(sDh2)+'\'';
			modifyStr=modifyStr+' sDh2=\''+sDh2+'\'';
			}else if(sDh2!=""&&modifySet!="set"){
			modifySet=modifySet+', sDh2=\''+tsd.encodeURIComponent(sDh2)+'\'';
			modifyStr=modifyStr+' sDh2=\''+sDh2+'\'';
			}	
			var UserName1=$("#iUserName1").val();	
			if(UserName1!=""&&modifySet=="set"){
			modifySet=modifySet+' UserName1=\''+tsd.encodeURIComponent(UserName1)+'\'';
			modifyStr=modifyStr+' UserName1=\''+UserName1+'\'';
			}else if(UserName1!=""&&modifySet!="set"){
			modifySet=modifySet+', UserName1=\''+tsd.encodeURIComponent(UserName1)+'\'';
			modifyStr=modifyStr+' UserName1=\''+UserName1+'\'';
			}		
			var idtype=$("#iidtype").val();
			if(idtype!=""&&modifySet=="set"){
			modifySet=modifySet+' idtype=\''+tsd.encodeURIComponent(idtype)+'\'';
			modifyStr=modifyStr+' idtype=\''+idtype+'\'';
			}else if(idtype!=""&&modifySet!="set"){
			modifySet=modifySet+', idtype=\''+tsd.encodeURIComponent(idtype)+'\'';
			modifyStr=modifyStr+' idtype=\''+idtype+'\'';
			}	
			var idcard=$("#iidcard").val();
			if(idcard!=""&&modifySet=="set"){
			modifySet=modifySet+' idcard=\''+tsd.encodeURIComponent(idcard)+'\'';
			modifyStr=modifyStr+' idcard=\''+idcard+'\'';
			}else if(idcard!=""&&modifySet!="set"){
			modifySet=modifySet+', idcard=\''+tsd.encodeURIComponent(idcard)+'\'';
			modifyStr=modifyStr+' idcard=\''+idcard+'\'';
			}	
			var speed=$("#ispeed").val();
			if(speed!=""&&(speed.indexOf('M')!=-1)){	
					speed=MCoversion(speed);//显示(将M数转化成数字)						
			}
			if(speed!=""&&modifySet=="set"){
			modifySet=modifySet+' speed=\''+tsd.encodeURIComponent(speed)+'\'';
			modifyStr=modifyStr+' speed=\''+speed+'\'';
			}else if(speed!=""&&modifySet!="set"){
			modifySet=modifySet+', speed=\''+tsd.encodeURIComponent(speed)+'\'';
			modifyStr=modifyStr+' speed=\''+speed+'\'';
			}	
			var linkman=$("#ilinkman").val();	
			if(linkman!=""&&modifySet=="set"){
			modifySet=modifySet+' linkman=\''+tsd.encodeURIComponent(linkman)+'\'';
			modifyStr=modifyStr+' linkman=\''+linkman+'\'';
			}else if(linkman!=""&&modifySet!="set"){
			modifySet=modifySet+', linkman=\''+tsd.encodeURIComponent(linkman)+'\'';
			modifyStr=modifyStr+' linkman=\''+linkman+'\'';
			}
			var linkphone=$("#ilinkphone").val();
			if(linkphone!=""&&modifySet=="set"){
			modifySet=modifySet+' linkphone=\''+tsd.encodeURIComponent(linkphone)+'\'';
			modifyStr=modifyStr+' linkphone=\''+linkphone+'\'';
			}else if(linkphone!=""&&modifySet!="set"){
			modifySet=modifySet+', linkphone=\''+tsd.encodeURIComponent(linkphone)+'\'';
			modifyStr=modifyStr+' linkphone=\''+linkphone+'\'';
			}
			var mobile=$("#imobile").val();
			if(mobile!=""&&modifySet=="set"){
			modifySet=modifySet+' mobile=\''+tsd.encodeURIComponent(mobile)+'\'';
			modifyStr=modifyStr+' mobile=\''+mobile+'\'';
			}else if(mobile!=""&&modifySet!="set"){
			modifySet=modifySet+', mobile=\''+tsd.encodeURIComponent(mobile)+'\'';
			modifyStr=modifyStr+' mobile=\''+mobile+'\'';
			}
			var Fee5=$("#iFee5").val();
			if(Fee5!=""&&modifySet=="set"){
			modifySet=modifySet+' Fee5=\''+tsd.encodeURIComponent(Fee5)+'\'';
			modifyStr=modifyStr+' Fee5=\''+Fee5+'\'';
			}else if(Fee5!=""&&modifySet!="set"){
			modifySet=modifySet+', Fee5=\''+tsd.encodeURIComponent(Fee5)+'\'';
			modifyStr=modifyStr+' Fee5=\''+mobile+'\'';
			}
			var sBm2=$("#isBm2 option[selected]").text();
			if(sBm2!=null&&sBm2!=""&&modifySet=="set"){
			modifySet=modifySet+' sBm2=\''+tsd.encodeURIComponent(sBm2)+'\'';
			modifyStr=modifyStr+' sBm2=\''+sBm2+'\'';
			}else if(sBm2!=null&&sBm2!=""&&modifySet!="set"){
			modifySet=modifySet+', sBm2=\''+tsd.encodeURIComponent(sBm2)+'\'';
			modifyStr=modifyStr+' sBm2=\''+sBm2+'\'';
			}
			var sBm3=$("#isBm3 option[selected]").text();
			if(sBm3!=null&&sBm3!=""&&modifySet=="set"){
			modifySet=modifySet+' sBm3=\''+tsd.encodeURIComponent(sBm3)+'\'';
			modifyStr=modifyStr+' sBm3=\''+sBm3+'\'';
			}else if(sBm3!=null&&sBm3!=""&&modifySet!="set"){
			modifySet=modifySet+', sBm3=\''+tsd.encodeURIComponent(sBm3)+'\'';
			modifyStr=modifyStr+' sBm3=\''+sBm3+'\'';
			}
			var sBm4=$("#isBm4 option[selected]").text();
			if(sBm4!=null&&sBm4!=""&&modifySet=="set"){
			modifySet=modifySet+' sBm4=\''+tsd.encodeURIComponent(sBm4)+'\'';
			modifyStr=modifyStr+' sBm4=\''+sBm4+'\'';
			}else if(sBm4!=null&&sBm4!=""&&modifySet!="set"){
			modifySet=modifySet+', sBm4=\''+tsd.encodeURIComponent(sBm4)+'\'';
			modifyStr=modifyStr+' sBm4=\''+sBm2+'\'';
			}
		  	$("#logoldstr").val(modifyStr); 	
		  		
			 	params+="&modifySet="+modifySet;
			 ////验证
		/**
		 	if(ipaddr!=""&&!isIP(ipaddr)){
		  		alert($("#ipaddr").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
		  	}
		  	 if(vlanid!=""&&!isIP(vlanid)){
		  		alert($("#vlanid").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
		  	}
		  	**/
		 
		 
			
		  	//if(!getMaxonline()) return false;//验证同时在线数
		  		/**if(mobile!=""&&!checkTel(mobile)){
		  		alert($("#mobile").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
		  	}
		  
		  	if(linkphone!=""&&!checkTel(linkphone)){
		  		alert($("#linkphone").html()+"<fmt:message key="global.invalid"/>");
		  			return false;
		  	}**/
		  
		  	if(modifySet=="set"){			 		
			 			//var operationtips = $("#operationtips").val();
						//jAlert("请输入修改内容!","操作提示")	
			 			///jAlert('<fmt:message key="tariff.modifyinfo"/>','<fmt:message key="global.operationtips"/>');
			 			alert('<fmt:message key="tariff.modifyinfo"/>');
			 			return false;
			 	}	
			 	   ///注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
			 	    
				///每次拼接参数必须添加此判断
				if(tsd.Qualified()==false){return false;}
					
				return params;
		  		
		  	
           		}
           	/**
			 * 关闭面板
			 * @param 无参数
			 * @return 无返回值
			 */ 
  		 	function closeo(){  		 		
					$("#iUserName").removeAttr("disabled");
  		 			setTimeout($.unblockUI, 15);//关闭面板
					
  		 	}
  		 	function resett(){
  		 	queryByAccount();	
  		 	}
		/**
		 * 详细操作的有关操作
		 * @param 无参数
		 * @return 无返回值
		 */ 
		function infopan(){
		//用户地址
		$("#address_tab").hide();
		$("#UserName1").css("display","");
		autoBlockFormAndSetWH('add',10,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板		
		$("#modify").hide();$("#save").hide();$("#modifyB").hide();$("#reset").hide();
		//关闭下拉列表，打开隐藏的text
		document.getElementById("iiStatus2").style.display="";
		document.getElementById("iiStatus").style.display = 'none';
		document.getElementById("iPayType2").style.display="";
		document.getElementById("iPayType").style.display = 'none';
		document.getElementById("isDh12").style.display="";
		document.getElementById("isDh1").style.display = 'none';
		document.getElementById("iiFeeType2").style.display="";
		document.getElementById("iiFeeType").style.display = 'none';
		document.getElementById("iidtype2").style.display="";
		document.getElementById("iidtype").style.display = 'none';
		document.getElementById("isDh22").style.display="";
		document.getElementById("isDh2").style.display = 'none';
		document.getElementById("isBmm").style.display="";
		document.getElementById("isBm").style.display = 'none';
		document.getElementById("isBm22").style.display="";
		document.getElementById("isBm2").style.display = 'none';
		document.getElementById("isBm32").style.display="";
		document.getElementById("isBm3").style.display = 'none';
		document.getElementById("isBm42").style.display="";
		document.getElementById("isBm4").style.display = 'none';
		document.getElementById("iiSimultaneous2").style.display="";
		document.getElementById("iiSimultaneous").style.display = 'none';
		
		//把三个下拉列表中选种项的text赋给input[type:text],
		if($("#iidtype").val()==""){
			$("#iidtype2").val("");
		}else{
			$("#iidtype2").val($("#iidtype option[selected]").text());
		}
		if($("#iPayType").val()==""){
			$("#iPayType2").val("");
		}else{
			$("#iPayType2").val($("#iPayType option[selected]").text());
		}
		if($("#isDh1").val()==""){
			$("#isDh12").val("");
		}else{
			$("#isDh12").val($("#isDh1 option[selected]").text());
		}
		if($("#iiFeeType").val()==""){
			$("#iiFeeType2").val("");
		}else{
			$("#iiFeeType2").val($("#iiFeeType option[selected]").text());
		}
		if($("#isDh2").val()==""){
			$("#isDh22").val("");
		}else{
			$("#isDh22").val($("#isDh2 option[selected]").text());
		}
		if($("#isBm").val()==""){
			$("#isBmm").val("");
		}else{
			$("#isBmm").val($("#isBm option[selected]").text());
		}
		if($("#isBm2").val()==""){
			$("#isBm22").val("");
		}else{
			$("#isBm22").val($("#isBm2 option[selected]").text());
		}
		if($("#isBm3").val()==""){
			$("#isBm32").val("");
		}else{
			$("#isBm32").val($("#isBm3 option[selected]").text());
		}
		if($("#isBm4").val()==""){
			$("#isBm42").val("");
		}else{
			$("#isBm42").val($("#isBm4 option[selected]").text());
		}
		if($("#iiSimultaneous").val()==""){
			$("#iiSimultaneous2").val("");
		}else{
			$("#iiSimultaneous2").val($("#iiSimultaneous option[selected]").text());
		}
		
		timechange();
		if($("#iiStatus").val()==""){
			$("#iiStatus2").val("");
		}else{
			$("#iiStatus2").val($("#iiStatus option[selected]").text());
		}
		}
			/**
			 * 修改的有关面板操作
			 * @param 无参数
			 * @return 无返回值
			 */ 
			function modifypan(){
				//用户地址
				$("#address_tab").hide();
				$("#UserName1").css("display","");
				autoBlockFormAndSetWH('add',10,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板	
				$("#modify").hide();
				$("#save").hide();	
				$("#modifyB").hide();	
				$("#reset").hide();
				//关闭每个下来列表对应的input[type:text]	
				document.getElementById("iiStatus2").style.display="none";
				document.getElementById("iiStatus").style.display = '';
				document.getElementById("iPayType2").style.display="none";
				document.getElementById("iPayType").style.display = '';
				document.getElementById("isDh12").style.display="none";
				document.getElementById("isDh1").style.display = '';
				document.getElementById("iiFeeType2").style.display="none";
				document.getElementById("iiFeeType").style.display = '';
				document.getElementById("iidtype2").style.display="none";
				document.getElementById("iidtype").style.display = '';
				document.getElementById("isDh22").style.display="none";
				document.getElementById("isDh2").style.display = '';
				document.getElementById("isBmm").style.display="none";
				document.getElementById("isBm").style.display = '';
				document.getElementById("isBm22").style.display="none";
				document.getElementById("isBm2").style.display = '';
				document.getElementById("isBm32").style.display="none";
				document.getElementById("isBm3").style.display = '';
				document.getElementById("isBm42").style.display="none";
				document.getElementById("isBm4").style.display = '';
				document.getElementById("iiSimultaneous2").style.display="none";
				document.getElementById("iiSimultaneous").style.display = '';
				
			}
			/**
			 * 清空操作
			 * @param 无参数
			 * @return 无返回值
			 */ 
			function clear(){
				batchmodifylist();//给每个下拉列表添加一个“请选择”的空项。
				$("#iUserName").val("");$("#iiFeeType").val("");$("#iValue").val("");$("#iipaddr").val("");$("#ivlanid").val("");$("#iAcctStartTime").val("");
				$("#iAcctStopTime").val("");$("#iPauseStartTime").val("");$("#iPauseStopTime").val("");$("#iRemainFee").val("");$("#iPayType").val("");					
				$("#isDh").val("");$("#isRegDate").val("");$("#isRealName").val("");$("#isBm").val("");$("#ihth").val("");$("#isAddress").val("");$("#iiStatus").val("");
				$("#iiSimultaneous").val("");$("#ifeeendtime").val("");$("#iiFeeTypeTime").val("");$("#isDh1").val("");$("#isDh2").val("");
				$("#iUserName1").val("");$("#iidtype").val("");$("#iidcard").val("");$("#ispeed").val("");$("#imobile").val("");$("#ilinkphone").val("");
				$("#ilinkman").val("");	$("#iFee5").val("");	$("#isBm2").empty();	$("#isBm3").empty();	$("#isBm4").empty();	
			}
        var notchange=true;//用户状态能否修改,true:能修改；false：不能修改
       /**
		* 申停时间和复机时间的变化引起用户状态的下列列表的变化
		* @param 无参数
		* @return boolean
		*/ 
        function timechange(){
        		//用户状态
			$("#iiStatus").empty();
			var nowtime=$("#nowtime").val()+" ";//当前时间				
			var PauseStartTime=$("#iPauseStartTime").val();//申停时间
			var PauseStopTime=$("#iPauseStopTime").val();//复机时间
			if(PauseStartTime==''||PauseStartTime==null){
				PauseStartTime='1990-01-01 00:00:00';
			}
			if(PauseStopTime==''||PauseStopTime==null){
				PauseStopTime='1990-01-01 00:00:00';
			}	
				
			var r=bijiao(nowtime,PauseStartTime);
			var q=bijiao(PauseStopTime,nowtime);
			var iStatus=$("#iStatushidden").val();
			//alert("PauseStartTime="+PauseStartTime+"PauseStopTime="+PauseStopTime+"nowtime="+nowtime+"rq="+r+":"+q);//测试		
			if(r==1&&q==1){//当前时间在申停时间和复机时间之间
						document.getElementById("iiStatus").options.add(new Option("申请停机",""));
						notchange=false;
			}else{
				if(iStatus=='1'){//锁定状态
				document.getElementById("iiStatus").options.add(new Option("锁定","1"));
				document.getElementById("iiStatus").options.add(new Option("解锁","0"));
				notchange=true;
				$("#iiStatus").val(iStatus);
				}
				if(iStatus=='0'){//正常
				document.getElementById("iiStatus").options.add(new Option("正常","0"));
				document.getElementById("iiStatus").options.add(new Option("锁定","1"));			
				$("#iiStatus").val(iStatus);
				notchange=true;
				}
				if(iStatus=='2'){//欠费
				document.getElementById("iiStatus").options.add(new Option("欠费","2"));
				notchange=false;
				}
				if(iStatus==''){
					//document.getElementById("iiStatus").options.add(new Option("<fmt:message key='global.select'/>",""));
					document.getElementById("iiStatus").options.add(new Option("正常","0"));
					document.getElementById("iiStatus").options.add(new Option("锁定","1"));	
					notchange=true;
				}
				
			}		 			
			
				
				
        }
        /**
		* 计费规则引起宽带变化
		* @param 无参数
		* @return boolean
		*/ 
        function feetypechange(){
        var iiFeeType=$("#iiFeeType option[selected]").text();
        tsd.QualifiedVal=true;  
		if(iiFeeType!=null&&iiFeeType!="")  iiFeeType=tsd.encodeURIComponent(iiFeeType);
		if(tsd.Qualified()==false){return false;}
		if(iiFeeType!=null&&iiFeeType!=""){
	        $.ajax({
						url:'mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=broadband&tsdcf=mysql&tsdoper=query&datatype=xmlattr&tsdpk=danganM.speed&FeeName='+iiFeeType,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							/////////////////////////////
							//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
							$(xml).find('row').each(function(){	
								var sNote	=$(this).attr("speed");	
								if(sNote!=null&&sNote!=""){
									sNote=speedConversion(sNote);
								}else{
									sNote="0M";
								}
								
								$("#ispeed").val(sNote);	//赋值给宽带										
							});
							
						}
					});
		}else{
			$("#ispeed").val("");
		}
        }
			/**
			 * 下拉列表内容的改变,显示计费规则列表
			 * @param 无参数
			 * @return 无返回值
			 */ 
			function getfeetype(){
			$("#iiFeeType").empty();
			
			$.ajax({
					url:'mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=broadband&tsdcf=mysql&tsdoper=query&datatype=xmlattr&tsdpk=danganM.isplist',
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						/////////////////////////////
						//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
						$(xml).find('row').each(function(){	
							var FeeCode	=$(this).attr("feecode");				
							var FeeName = $(this).attr("feename");
							document.getElementById("iiFeeType").options.add(new Option(FeeName,FeeCode));	
								
												
						});
						
					}
				});
			}
			/**
			 * 用户类型isDh1
			 * @param 无参数
			 * @return 无返回值
			 */ 
			function getsdh(){
			$("#isDh1").empty();
			
			$.ajax({
					url:'mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=broadband&tsdcf=mysql&tsdoper=query&datatype=xmlattr&tsdpk=danganM.usertype',
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						/////////////////////////////
						//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
						$(xml).find('row').each(function(){
						var TypeID	=$(this).attr("typeid");
						var UserType=$(this).attr("usertype");
							document.getElementById("isDh1").options.add(new Option(UserType,TypeID));	
						});
						
					}
				});
				
			}
			/**
			 * 用户类别
			 * @param 无参数
			 * @return 无返回值
			 */ 
			function getpaytype(){
			$("#iPayType").empty();
			
			document.getElementById("iPayType").options.add(new Option('<fmt:message key="dangan.paytype1" />',"0"));
			document.getElementById("iPayType").options.add(new Option('小区网用户',"2"));
			document.getElementById("iPayType").options.add(new Option('<fmt:message key="dangan.paytype4" />',"10"));
			
			}
			/**
			 * 证据类型
			 * @param 无参数
			 * @return 无返回值
			 */ 
			function getidtype(){
			$("#iidtype").empty();
			
			document.getElementById("iidtype").options.add(new Option('<fmt:message key="AddUser.ID" />',"7"));//身份证
			document.getElementById("iidtype").options.add(new Option('<fmt:message key="AddUser.Faculty" />',"1"));//教职工 
			document.getElementById("iidtype").options.add(new Option('<fmt:message key="AddUser.Undergraduate" />',"2"));//本科生 
			document.getElementById("iidtype").options.add(new Option('<fmt:message key="AddUser.Graduate" />',"3"));//研究生 
			document.getElementById("iidtype").options.add(new Option('<fmt:message key="AddUser.Retired" />',"4"));//离退休 
			document.getElementById("iidtype").options.add(new Option('<fmt:message key="AddUser.Passport" />',"5"));//护照 
			document.getElementById("iidtype").options.add(new Option('<fmt:message key="AddUser.MilitaryID" />',"6"));//军官证 
			document.getElementById("iidtype").options.add(new Option('<fmt:message key="AddUser.other" />',"8"));	//其它 
			
			}
		 /**
		  * 显示在线
		  * @param 无参数
		  * @return 无返回值
		  */ 
	     function getMaxonline(){	 
	     $("#iiSimultaneous").empty();
	      
	     var  sValue=0;
	     	$.ajax({
					url:"mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=broadband&tsdcf=mysql&tsdoper=query&datatype=xmlattr&tsdpk=danganM.queryconfig",
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){	
								  sValue=$(this).attr("svalue");								  	
																	
					});}});
				for(var i=0;i<parseInt(sValue,10)+1;i++){
					document.getElementById("iiSimultaneous").options.add(new Option(i,i));
				}	
	     }
			/**
			 * 显示全部一级部门
			 * @param 无参数
			 * @return 无返回值
			 */ 
			function getbmen(){
			$("#isBm").empty();$("#isBm2").empty();$("#isBm3").empty();$("#isBm4").empty();
			
			$.ajax({
					url:'mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=tsdBilling&tsdcf=mssql&tsdoper=query&datatype=xmlattr&tsdpk=danganM.querydepart',
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						/////////////////////////////
						//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
						$(xml).find('row').each(function(){
						var DeptName=$(this).attr("deptname");
						var DeptCode=$(this).attr("deptcode");
						if(DeptCode.length==3){						
							document.getElementById("isBm").options.add(new Option(DeptName,DeptCode));							
							}
							
												
						});
						
					}
				});
				
			}
			/**
			  * 弹出修改面板，用到的函数
			  * @param s1(部门一)
			  * @param s2(部门二)
			  * @param s3(部门三)
			  * @param s4(部门四)
			  * @return 无返回值
			  */
			function querybyaccountBumen(s1,s2,s3,s4){		
					var option1=$("#isBm").find("option[text="+s1+"]");
					var s1val=option1.val();
					if(s1val=='undefined'||s1val==undefined){						
						document.getElementById("isBm").options.add(new Option(s1,'undefined'));
						document.getElementById("isBm2").options.add(new Option(s2,'undefined'));
						document.getElementById("isBm3").options.add(new Option(s3,'undefined'));
						document.getElementById("isBm4").options.add(new Option(s4,'undefined'));
						$("#isBm").val(s1);
						$("#isBm2").val(s2);
						$("#isBm3").val(s3);
						$("#isBm4").val(s4);
					}else{						
						$("#isBm").val(s1val);	
						querybumen(2);
						var option2=$("#isBm2").find("option[text="+s2+"]");									
						$("#isBm2").val(option2.val());
						querybumen(3);
						var option3=$("#isBm3").find("option[text="+s3+"]");	
						$("#isBm3").val(option3.val());
						querybumen(4);	
						var option4=$("#isBm4").find("option[text="+s4+"]");						
						$("#isBm4").val(option4.val());	
						
					}
			
			}
		/**
		 * 查询部门
		 * @param jibie(级别)
		 * @return 无返回值
		 */
		function querybumen(jibie){
			//部门关联
			var len=7;var reg;var s1=$("#isBm").val();var s2=$("#isBm2").val();var s3=$("#isBm3").val();	
			var strlike="";		
			if(jibie==2){//二级部门
				$("#isBm2").empty();
				$("#isBm3").empty();
				$("#isBm4").empty();				
				$("#isBm2").attr("disabled","disabled");
				$("#isBm3").attr("disabled","disabled");
				$("#isBm4").attr("disabled","disabled");			
				len=7;
				reg=eval("/^"+s1+"\./");
				strlike=s1+".";
			}else if(jibie==3){
				$("#isBm3").empty();
				$("#isBm4").empty();
				$("#isBm3").attr("disabled","disabled");
				$("#isBm4").attr("disabled","disabled");	
				reg=eval("/^"+s2+"\./");
				len=11;
				strlike=s2+".";
			}else if(jibie==4){
				$("#isBm4").empty();
				$("#isBm4").attr("disabled","disabled");	
				reg=eval("/^"+s3+"\./");
				len=15;
				strlike=s3+".";
			}		
			if(strlike.indexOf('null')=="-1"){
			$.ajax({
					url:'mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=tsdBilling&tsdcf=mssql&tsdoper=query&datatype=xmlattr&tsdpk=danganM.querydepart2&strlike='+strlike,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
						/////////////////////////////
						//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
						$(xml).find('row').each(function(){
						var DeptName	=$(this).attr("deptname");
						var DeptCode=$(this).attr("deptcode");
						if(DeptCode!=undefined&&DeptCode.length==len&&reg.test(DeptCode)){					
							document.getElementById("isBm"+jibie).options.add(new Option(DeptName,DeptCode));
								if(jibie==2){
								$("#isBm2").removeAttr("disabled");	
								}else if(jibie==3){								
								$("#isBm3").removeAttr("disabled");	
								
								}else if(jibie==4){
								$("#isBm42").val(DeptName);
								$("#isBm4").removeAttr("disabled");	
								}				
							}				
						});
						
					}
				});
			}
			
			}
			/**
			 * 页面中部门的onchange方法
			 * @param jibie(级别)
			 * @return 无返回值
			 */
			function changebumen(jibie){
				if(jibie==2){
					tsd.QualifiedVal=true; 
					var sBm=tsd.encodeURIComponent($("#isBm option[selected]").html());
					 if(tsd.Qualified()==false){return false;}
					var hth="";
					$.ajax({
						url:'mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=tsdBilling&tsdcf=mssql&tsdoper=query&datatype=xmlattr&tsdpk=danganM.qhyt_hth&bm='+sBm,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
								 hth=$(this).attr("hth");		
							
							});
						}
					});
					$("#ihth").val(hth);	
					querybumen(2);querybumen(3);querybumen(4);
					
				}else if(jibie==3){			
					querybumen(3);querybumen(4);
				}else if(jibie==4){			
					querybumen(4);
				}
			}
			/**
			 * 得到所有列表的所有内容
			 * @param 无参数
			 * @return boolean(0:有空（选择）一项，用来批量修改,其他:没有空（选择）一项)
			 */
			function getalllist(){
				getuserareato();
				getfeetype();
				getsdh();
				getpaytype();
				getidtype();
				getbmen();
				getMaxonline();
				$("#selsDh1").val($("select[id='isDh1']").html());
				$("#selPayType").val($("select[id='iPayType']").html());
				$("#selsDh2").val($("select[id='isDh2']").html());
				$("#seliFeeType").val($("select[id='iiFeeType']").html());
				$("#selidtype").val($("select[id='iidtype']").html());
				$("#selisBm").val($("select[id='isBm']").html());
				$("#seliSimultaneous").val($("select[id='iiSimultaneous']").html());
				
			}
			/**
			 * 修改下拉列表的内容
			 * @param 无参数
			 * @return 无返回值
			 */
			function modifylist(){
				$("select[id='isDh1']").html($("#selsDh1").val());							
				$("select[id='iPayType']").html($("#selPayType").val());								
				$("select[id='isDh2']").html($("#selsDh2").val());								
				$("select[id='iiFeeType']").html($("#seliFeeType").val());								
				$("select[id='iidtype']").html($("#selidtype").val());								
				$("select[id='isBm']").html($("#selisBm").val());				 				
				$("select[id='iiSimultaneous']").html($("#seliSimultaneous").val());
				timechange();//用户状态的下列列表的变化
				
			}
			/**
			 * 批量修改下拉列表的内容
			 * @param 无参数
			 * @return 无返回值
			 */
			function batchmodifylist(){
				var select="<option value=''>--<fmt:message key="gjh.select"/>--</option>";							
				$("select[id='isDh1']").html(select+$("#selsDh1").val());							
				$("select[id='iPayType']").html(select+$("#selPayType").val());								
				$("select[id='isDh2']").html(select+$("#selsDh2").val());								
				$("select[id='iiFeeType']").html(select+$("#seliFeeType").val());								
				$("select[id='iidtype']").html(select+$("#selidtype").val());								
				$("select[id='isBm']").html(select+$("#selisBm").val());
							 				
				$("select[id='iiSimultaneous']").html(select+$("#seliSimultaneous").val());
				timechange();//用户状态的下列列表的变化
				$("select[id='iiStatus']").html(select+$("select[id='iiStatus']").html());
			}
		 /**
		  * 带宽转换（将数字转换成M数）
		  * @param params(需要转换的参数)
		  * @return String
		  */
	     function speedConversion(params){
	         var speed = (parseInt(params,10)/1024000)+'M';
	         return speed;
	     } 
	     //显示(将M数转化成数字)
	     function MCoversion(params){
	     	var s=params.replace('M','');
	     	var re=parseFloat(s,10)*1024000;
	     	
	     	return re;
	     }
	   /**
		* 绑定电话sDh
		* @param params(需要转换的参数)
		* @return boolean
		*/
	    function checksDh(){
	    var sDh=$("#isDh").val();//参数 id=1:修改; id=2:批量修改
	    var id=$("#id").val();
	    var flag=true;
	    var strurl="mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=broadband&tsdcf=mysql&tsdoper=query&datatype=xmlattr&tsdpk=";
	   
	    strurl=strurl+"danganM.queryradcheckid&sDh="+sDh+"&id="+id;
	    $.ajax({
					url:strurl,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){	
								  var ss=$(this).attr("username");
								  	
								if(ss!=undefined){flag=false;$("#isDh").focus();alert("电话已被绑定，不能绑定该电话");}									
					});}});
		 $.ajax({
					url:"mainServlet.html?packgname=service&clsname=ExecuteSql&method=exeSqlData&ds=tsdBilling&tsdcf=mssql&tsdoper=query&datatype=xmlattr&tsdpk=danganM.queryyhdang&Dh="+sDh,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){	
								  var ss=$(this).attr("jxh"); 	
								if(ss==undefined){flag=false;$("#isDh").focus();alert("电话不存在，不能绑定该电话");}									
					});}});
					return flag;
	    }
	   		/**
			 * 验证demail(m,n)类型
			 * @param id
			 * @param m
			 * @param n
			 * @return boolean
			 */
	   		function subFF(id,m,n){
	   		var str=$("#i"+id).val();var name=$("#"+id).html();
	   		var flag=true;
	   		var v=vDemail(str,m,n);
	   		if(v==0){flag=false;alert(name+":不是数字");}
	   		else if(v==1){flag=false;alert(name+":超过范围");}
			else{ return flag;}
			}
		
	    </script>


		<script type="text/javascript">
			  /**
			   * 拼接要显示的数据列main.js中有关导出数据的函数是 thisDataDownload,checkedAllFields,getTheCheckedField
			   * @param tablename(表名)
			   * @return String
			   */    
				function displayFields(tablename){
					var thearr = new Array();
						 var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'roleManager.gettheeditfields'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&tablename='+tablename,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								$(xml).find('row').each(function(){
										var thefieldname = $(this).attr("field_name") ;
										var thefieldalias = getCaption($(this).attr("field_alias"),'<%=languageType%>','');
										if(thefieldalias!=''){
											var disvalue = thefieldname + ' as ' + tsd.encodeURIComponent(thefieldalias);
											thearr.push(disvalue);
										}
								 });
							 }
						 });
					return thearr;
				}
				
				
	</script>
		<script type="text/javascript">     
	     
	  /**
	   * 地址
	   * @param 无参数
	   * @return 无返回值
	   */   
	  function addnewinfo(){
			var groupid = $('#zid').val();
			window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/addressManage.jsp&imenuid=1085&pmenuname=号线管理 &imenuname=地址库管理 &groupid='+groupid,window,"dialogWidth:820px; dialogHeight:650px; center:yes; scroll:yes");
	  } 
  /**
	* 选择user时onchang事件
	* @param 无参数
	* @return 无返回值
	*/ 
  function seluser(){
         $("#isAddress").val("");
         $("#isAddress").removeAttr("disabled");
      } 
    /**
	* 地址选择
	* @param 无参数
	* @return 无返回值
	*/ 
	function c_p_address_fun()
	{
		
		if($("#c_p_address").size()<1)
		{
			$("#dizhi").html("<td colspan='6' id='c_p_address'><td>");
		}
		var left = $("#isAddress").offset().left - $("#isAddress").parent().prev().width()-350;
		var top = $("#isAddress").offset().top + 20;
		//alert($("#address").parent().offset().left);
		//$("#c_p_address").css({'left':left,'top':top,'background-color':'#FFFFFF','border':'#99ccff 1px solid','height':'112px','width':'450px'});
		$("#c_p_address").empty();
		var address_tab='<table id="address_tab" width="500" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#f0f0f0" style="margin-top:8px; margin-bottom:8px;">';
        address_tab=address_tab+'<tr><td colspan="4" align="center" bgcolor="#F8F9FA"><strong style="font-size:14px; color:#2D2D2D;">用户地址</strong></td> </tr>';
        address_tab=address_tab+'<tr><td width="83" align="right" bgcolor="#FFFFFF">小区号</td> <td width="164" align="center" bgcolor="#FFFFFF"><label style="width:80px;"> <select id="c_p_address_xq" style="width:100px"> <option value=>请选择</option> </select> </label></td><td width="96" align="right" bgcolor="#FFFFFF">楼栋号</td> <td width="157" align="center" bgcolor="#FFFFFF"><label style="width:80px;"><select id="c_p_address_ld" style="width:100px"> <option>请选择</option> </select> </label></td> </tr>';
        address_tab=address_tab+'<tr> <td align="right" bgcolor="#FFFFFF">单元号</td> <td align="center" bgcolor="#FFFFFF"><span style="width:80px;"> <select id="c_p_address_dy" style="width:100px"> <option>请选择</option> </select></span></td> <td align="right" bgcolor="#FFFFFF">门牌号</td> <td align="center" bgcolor="#FFFFFF"><span style="width:80px;"> <select id="c_p_address_mp" style="width:100px"> <option>请选择</option></select></span></td></tr>';
        address_tab=address_tab+' <tr > <td colspan="4" align="center" bgcolor="#FFFFFF"><label>'+"<button style=\"line-height:20px\" id=\"c_p_address_bnok\" class=\"tsdbutton\">确定</button><button id=\"c_p_address_add\" onclick=\"addnewinfo()\" class=\"tsdbutton\" style=\"line-height:20px\" >添加新地址</button><button id=\"c_p_address_bncancel\" class=\"tsdbutton\" style=\"line-height:20px\" >取消</button>"+'</label></td> </tr>';
        address_tab=address_tab+  '</table>';
		
		$("#c_p_address").append(address_tab);
		var cpad = $("#c_p_address_addright").val();
		if(cpad=="true"){
		  $("#c_p_address_add").removeAttr("disabled");		  	  
		}
		c_p_bindToAddr(1,"c_p_address_xq","");
		
		/**
		* 获得焦点时显示
		* @param 无参数
		* @return 无返回值
		*/ 
		$("#c_p_address").show();
		
		$(document).one("click",function(event){
			//$("#c_p_address").hide('slow');
			//event.stopPropagation();
		});
		
		$("#c_p_address_xq").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("#c_p_address_xq").val();
			if(addr!="")
			{
				c_p_bindToAddr(2,"c_p_address_ld","&addr=" + $("#c_p_address_xq").val());
			}
		});
		
		$("#c_p_address_ld").change(function(){
			//alert($("#c_p_address_xq").val());
			var addr = $("#c_p_address_ld").val();
			if(addr!="")
			{
				c_p_bindToAddr(3,"c_p_address_dy","&addr=" + $("#c_p_address_ld").val());
			}
		});
		
		$("#c_p_address_dy").change(function(){
			//alert($("#c_p_address_xq").val()); 
			var addr = $("#c_p_address_dy").val();
			if(addr!="")
			{
				c_p_bindToAddr(4,"c_p_address_mp","&addr=" + addr);
			}
		});
		
		$("#c_p_address_bnok").click(function(){
			
			var info = "";
			var errinfo = "";
			
			var elems = ['xq','ld','dy','mp'];
			var infoo = ['小区号','楼栋号','单元号','门牌号'];
			
			for(var j=0;j<4;j++)
			{
				if($("#c_p_address_"+elems[j]).val() != "")
				{
					info += $("select[id='c_p_address_"+elems[j]+"'] :selected").html();
					info += ",";
				}else if(resto!=undefined){
				    errinfo += infoo[j];
					errinfo += ",";
				}	
			}
			if(errinfo.length!=0)
			{
				alert("请继续选择下一级地址","操作提示");
			}
			else
			{
				info = info.replace(new RegExp(",","g"),"");
				if(checkAddress(info))
				{
					alert("地址 " + info + " 已经存在，不能重复添加");
					return false;
				}
				$("#isAddress").val(info);
				$("#c_p_address").hide();
				//$("#c_p_address").css("dispay","none");
				
			}
			//alert($("select[id^='c_p_address']").size());
		});
		
		$("#c_p_address_bncancel").click(function(){
			
			
		   $("#c_p_address").hide();
			//$("#c_p_address").css('display','none');
			//$("#UserName1").css("display","block");
		});
	}
		var resto="";
	/**
	 * 组装地址下拉选
	 * @param idx(序列)
	 * @param selid(下拉选的索引)
	 * @param param(内容)
	 * @return 无返回值
	 */ 
	function c_p_bindToAddr(idx,selid,param)
	{
	    var area = $("select[id='isDh2'] :selected").html();
	   //alert(idx+"--"+area+"----");
		var res = fetchMultiArrayValue("AddressBox.query"+idx,6,param+"&addrarea="+tsd.encodeURIComponent(area));
		var elems = ['xq','ld','dy','mp'];
		//alert(res[0] == undefined + ":" + res[0][0] == undefined);
		resto=res[0][0];
		if(res[0] == undefined || res[0][0] == undefined || res[0] == "")
		{
			for(var j=idx;j<=4;j++)
			{
				$("#c_p_address_"+elems[j-1]).empty();
				$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--请选择--</option>");
			}
			
			return false;
		}
		$("#"+selid).empty();
		$("#"+selid).append("<option value=\"\">--请选择--</option>");
		
		var quanju="";
		for(var i=0;i<res.length;i++)
		{
		    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
		    quanju+=ee					
		}
		 $("#"+selid).html($("#"+selid).html()+quanju);		
		
		//重置索引  > idx + 1 的下拉框
		for(var j=idx + 1;j<=4;j++)
		{
			$("#c_p_address_"+elems[j-1]).empty();
			$("#c_p_address_"+elems[j-1]).append("<option value=\"\">--请选择--</option>");
		}
	}
	/**
	 * 选择地址触发事件
	 * @param addr(地址)
	 * @return boolean
	 */
	function checkAddress(addr)
        	{
        	    var addrto = $("#c_p_address_mp").val();
        	    if(addrto!=null&&addrto!=""){
				var res = fetchSingleValue("Address.Check",0,"&address="+tsd.encodeURIComponent(addr));
					 if(res==undefined||res=='0')
					{
						return false;
					}
					else
					{
						return true;
					}
				}				
     }
    /**
	 * 节点选择
	 * @param addr(地址)
	 * @return 无返回值
	 */
	function notecheck(){
			 	var notecheck = $("#isAddress").val();
			    if(notecheck.length>0){
			    	 $("#isAddress").val(notecheck.substr(0,0));
			    	 alert(notecheck.substr(0,0));
			    }
	}
		/**
		 * 选择用户所在区域
		 * @param 无参数
		 * @return 无返回值
		 */
        var uareato="";
        function getuserareato(){
        var userid=$("#userid").val();//当前用户
         var userarea=new Array();
         userarea=$("#userarea").val().split("~");
		
            var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.getuserarea'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              uareato="";
					            
					              $("#area").empty();			       
					                $(xml).find('row').each(function(){	
					                  var xuhao = $(this).attr("xuhao");
					                  var ywarea = $(this).attr("ywarea");
					                  if(ywarea!=undefined){
					                  		var ee="<option value='"+ywarea+"'>"+ywarea+"</option>";
						                   if(userid=="admin"){
									            uareato=uareato+ee;	
									       }else{
									       		var flag=false;
									      		 for(var i=0;i<userarea.length;i++){									      		
								                  	if(ywarea==userarea[i]){flag=true;break;}								                  	
								                 }
								                 if(flag){
										            uareato=uareato+ee;	
									           	 }
									       }							       
								      }
							        });	
							         
							        $("#isDh2").html(uareato);							       
							      }
							});
        }  
  
	  
		</script>
		<script>
	/**
	 * 打开简单查询面板
	 * @param 无参数
	 * @return 无返回值
	 */
	function openQuery(){
		 	$(".top_03").html('<fmt:message key="global.query" />');//标题		
		 	autoBlockFormAndSetWH('pan2',60,5,'closeoq',"#ffffff",true,1000,'');//弹出查询面板
		 	 $("#c_p_addressq").hide();
		 	$("#iUserNameq").val("");
		 	$("#isRealNameq").val("");
		 	$("#isDhq").val("");
		 	$("#isAddressq").val("");
		 	
	}
/**
 * 通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
 * @param 无参数
 * @return 无返回值
 */
function QbuildParams(){		 	
	 	var UserName = $("#iUserNameq").val();
	 	var sRealName = $("#isRealNameq").val();
	 	var sDh = $("#isDhq").val();
	 	var sAddress = $("#isAddressq").val();
	 	
	 	var paramsStr='1=1 ';
	 	if(UserName!=''){
	 	 	paramsStr+="and UserName like '%"+UserName+"%' ";
	 	}
	 	if(sRealName!=''){
	 		paramsStr+="and sRealName like '%"+sRealName+"%' " ;
	 	}
	 	if(sDh!=''){
	 	 	paramsStr+="and sDh like '%"+sDh+"%' ";
	 	}
	 	if(sAddress!=''){
	 		paramsStr+="and sAddress like '%"+sAddress+"%' " ;
	 	}
	 		 	
	 	$("#fusearchsql").val(paramsStr);
	 	fuheQuery();		
}
	
 	/**
	 * 地址选择
	 * @param 无参数
	 * @return 无返回值
	 */
	function c_p_address_funq()
	{
		
		if($("#c_p_addressq").size()<1)
		{
			$("#dizhiq").html("<td colspan='6' id='c_p_addressq'><td>");
		}
		var left = $("#isAddressq").offset().left - $("#isAddressq").parent().prev().width()-350;
		var top = $("#isAddressq").offset().top + 20;
		//alert($("#address").parent().offset().left);
		//$("#c_p_addressq").css({'left':left,'top':top,'background-color':'#FFFFFF','border':'#99ccff 1px solid','height':'112px','width':'450px'});
		$("#c_p_addressq").empty();
		var address_tab='<table id="address_tab" width="500" border="0" align="center" cellpadding="1" cellspacing="1" bgcolor="#f0f0f0" style="margin-top:8px; margin-bottom:8px;">';
      	address_tab=address_tab+'<tr><td colspan="4" align="center" bgcolor="#F8F9FA"><strong style="font-size:14px; color:#2D2D2D;">用户地址</strong></td> </tr>';
      	address_tab=address_tab+'<tr><td width="83" align="right" bgcolor="#FFFFFF">小区号</td> <td width="164" align="center" bgcolor="#FFFFFF"><label style="width:80px;"> <select id="c_p_addressq_xq" style="width:100px"> <option value=>请选择</option> </select> </label></td><td width="96" align="right" bgcolor="#FFFFFF">楼栋号</td> <td width="157" align="center" bgcolor="#FFFFFF"><label style="width:80px;"><select id="c_p_addressq_ld" style="width:100px"> <option>请选择</option> </select> </label></td> </tr>';
        address_tab=address_tab+'<tr> <td align="right" bgcolor="#FFFFFF">单元号</td> <td align="center" bgcolor="#FFFFFF"><span style="width:80px;"> <select id="c_p_addressq_dy" style="width:100px"> <option>请选择</option> </select></span></td> <td align="right" bgcolor="#FFFFFF">门牌号</td> <td align="center" bgcolor="#FFFFFF"><span style="width:80px;"> <select id="c_p_addressq_mp" style="width:100px"> <option>请选择</option></select></span></td></tr>';
        address_tab=address_tab+' <tr > <td colspan="4" align="center" bgcolor="#FFFFFF"><label>'+"<button style=\"line-height:20px\" id=\"c_p_addressq_bnok\" class=\"tsdbutton\">确定</button><button id=\"c_p_addressq_add\" onclick=\"addnewinfo()\" class=\"tsdbutton\" style=\"line-height:20px\" >添加新地址</button><button id=\"c_p_addressq_bncancel\" class=\"tsdbutton\" style=\"line-height:20px\" >取消</button>"+'</label></td> </tr>';
        address_tab=address_tab+  '</table>';
		
		$("#c_p_addressq").append(address_tab);
		var cpad = $("#c_p_addressq_addright").val();
		if(cpad=="true"){
		  $("#c_p_addressq_add").removeAttr("disabled");		  	  
		}

		c_p_bindToAddrq(1,"c_p_addressq_xq","");
		
		//获得焦点时显示
		$("#c_p_addressq").show();
		
		$(document).one("click",function(event){
			//$("#c_p_addressq").hide('slow');
			//event.stopPropagation();
		});
		
		$("#c_p_addressq_xq").change(function(){
			//alert($("#c_p_addressq_xq").val()); 
			var addr = $("#c_p_addressq_xq").val();
			if(addr!="")
			{
				c_p_bindToAddrq(2,"c_p_addressq_ld","&addr=" + $("#c_p_addressq_xq").val());
			}
		});
		
		$("#c_p_addressq_ld").change(function(){
			//alert($("#c_p_addressq_xq").val());
			var addr = $("#c_p_addressq_ld").val();
			if(addr!="")
			{
				c_p_bindToAddrq(3,"c_p_addressq_dy","&addr=" + $("#c_p_addressq_ld").val());
			}
		});
		
		$("#c_p_addressq_dy").change(function(){
			//alert($("#c_p_addressq_xq").val()); 
			var addr = $("#c_p_addressq_dy").val();
			if(addr!="")
			{
				c_p_bindToAddrq(4,"c_p_addressq_mp","&addr=" + addr);
			}
		});
		
		$("#c_p_addressq_bnok").click(function(){
			
			var info = "";
			var errinfo = "";
			
			var elems = ['xq','ld','dy','mp'];
			var infoo = ['小区号','楼栋号','单元号','门牌号'];
			
			for(var j=0;j<4;j++)
			{
				if($("#c_p_addressq_"+elems[j]).val() != "")
				{
					info += $("select[id='c_p_addressq_"+elems[j]+"'] :selected").html();
					info += ",";
				}else if(resto!=undefined){
				    errinfo += infoo[j];
					errinfo += ",";
				}	
			}
			if(errinfo.length!=0)
			{
				alert("请继续选择下一级地址","操作提示");
			}
			else
			{
				info = info.replace(new RegExp(",","g"),"");
				if(checkAddressq(info))
				{
					alert("地址 " + info + " 已经存在，不能重复添加");
					return false;
				}
				$("#isAddressq").val(info);
				$("#c_p_addressq").hide();
				//$("#c_p_addressq").css("dispay","none");
				
			}
			//alert($("select[id^='c_p_addressq']").size());
		});
		
		$("#c_p_addressq_bncancel").click(function(){
			
			
		   $("#c_p_addressq").hide();
			//$("#c_p_addressq").css('display','none');
			//$("#UserName1").css("display","block");
		});
	}
	var resto="";
	/**
	 * 组装地址下拉选
	 * @param idx(序列)
	 * @param selid(下拉选的索引)
	 * @param param(内容)
	 * @return 无返回值
	 */ 
	function c_p_bindToAddrq(idx,selid,param)
	{
	    //var area = $("select[id='isDh2'] :selected").html();
	    var area = '';
	    if(idx==1){
	    	area = $("#userarea").val();
	    }else{
	    	area = $("select[id='isDh2'] :selected").html();
	    }
	   // alert("idx"+idx);
		var res = fetchMultiArrayValue("AddressBox.query"+idx,6,param+"&addrarea="+tsd.encodeURIComponent(area));
		var elems = ['xq','ld','dy','mp'];
		//alert(res[0] == undefined + ":" + res[0][0] == undefined);
		resto=res[0][0];
		if(res[0] == undefined || res[0][0] == undefined || res[0] == "")
		{
			for(var j=idx;j<=4;j++)
			{
				$("#c_p_addressq_"+elems[j-1]).empty();
				$("#c_p_addressq_"+elems[j-1]).append("<option value=\"\">--请选择--</option>");
			}
			
			return false;
		}
		$("#"+selid).empty();
		$("#"+selid).append("<option value=\"\">--请选择--</option>");
		
		var quanju="";
		for(var i=0;i<res.length;i++)
		{
		    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
		    quanju+=ee					
		}
		 $("#"+selid).html($("#"+selid).html()+quanju);		
		
		//重置索引  > idx + 1 的下拉框
		for(var j=idx + 1;j<=4;j++)
		{
			$("#c_p_addressq_"+elems[j-1]).empty();
			$("#c_p_addressq_"+elems[j-1]).append("<option value=\"\">--请选择--</option>");
		}
	}
	/**
	 * 选择地址
	 * @param addr(地址)
	 * @return boolean
	 */ 
	function checkAddressq(addr)
        	{
        	    var addrto = $("#c_p_addressq_mp").val();
        	    if(addrto!=null&&addrto!=""){
				var res = fetchSingleValue("AddressBox.Check",0,"&address="+tsd.encodeURIComponent(addr));
					 if(res==undefined||res=='0')
					{
						return false;
					}
					else
					{
						return true;
					}
				}				
     }
     /**
	 * 节点选择
	 * @param 无参数
	 * @return 无返回值
	 */ 
	function notecheckq(){
			 	var notecheck = $("#isAddressq").val();
			    if(notecheck.length>0){
			    	 $("#isAddressq").val(notecheck.substr(0,0));
			    	 alert(notecheck.substr(0,0));
			    }
	}
	</script>
		<style type="text/css">
.style1 {
	background-color: #A9C3E8;
	padding: 4px;
}

.spanstyle {
	display: -moz-inline-box;
	display: inline-block;
	width: 115px
}
</style>
	</head>

	<body>
		<form name="childform" id="childform">
			<input type="text" id="queryName" name="queryName" value=""
				style="display: none" />
			<input type="text" id="fusearchsql" name="fusearchsql"
				style="display: none" />
		</form>

		<!-- 用户操作导航-->
		<div id="navBar">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"><fmt:message
									key="gjh.houtuei" /> </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div id="zong">
			<!-- 用户操作标题以及放一些快捷按钮-->
			<div id="buttons">

				<button type="button" id="order1" onclick="openDiaO('vw_radcheck');">
					<!--组合排序-->
					<fmt:message key="order.title" />
				</button>

				<button type="button" onclick="openQuery();">
					<!--查询-->
					<fmt:message key="global.query" />
				</button>
				<button onclick='openQueryM(1);'>
					<fmt:message key="oper.mod" />
				</button>
				<button type="button" id='gjquery1'
					onclick="openDiaQueryG('query','vw_radcheck');" disabled="disabled">
					<!--高级查询-->
					<fmt:message key="oper.queryA" />
				</button>
				<button type="button" id='savequery1' onclick="openModT();"
					disabled="disabled">
					<!-- 将本查询保存为模板  -->
					<fmt:message key="oper.modSave" />
				</button>
				<button type="button" id="opendel"
					onclick="openDiaQueryG('delete','vw_radcheck');"
					disabled="disabled">
					<!--批量删除-->
					<fmt:message key="tariff.deleteb" />
				</button>
				<button type="button" id="openmod"
					onclick="openDiaQueryG('modify','vw_radcheck');"
					disabled="disabled">
					<!--批量修改-->
					<fmt:message key="tariff.modifyb" />
				</button>
				<button type="button" id="export"
					onclick="thisDownLoad('tsdBilling','mssql','vw_radcheck','<%=languageType%>');"
					disabled="disabled">
					<!--导出-->
					<fmt:message key="global.exportdata" />
				</button>
				<button type="button" id="print" onclick="print()"
					disabled="disabled">
					<!--打印-->
					<fmt:message key="tariff.printer" />
				</button>


			</div>
			<div style="float: left">
				<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
				<div id="pagered" class="scroll" style="text-align: left;"></div>
			</div>
			<!-- 用户操作标题以及放一些快捷按钮-->
			<div id="buttons">
				<button type="button" id="order1" onclick="openDiaO('vw_radcheck');">
					<!--组合排序-->
					<fmt:message key="order.title" />
				</button>

				<button type="button" onclick="openQuery();">
					<!--查询-->
					<fmt:message key="global.query" />
				</button>
				<button onclick='openQueryM(1);'>
					<fmt:message key="oper.mod" />
				</button>
				<button type="button" id='gjquery2'
					onclick="openDiaQueryG('query','vw_radcheck');" disabled="disabled">
					<!--高级查询-->
					<fmt:message key="oper.queryA" />
				</button>
				<button type="button" id='savequery2' onclick="openModT();"
					disabled="disabled">
					<!-- 将本查询保存为模板  -->
					<fmt:message key="oper.modSave" />
				</button>
				<button type="button" id="opendelf"
					onclick="openDiaQueryG('delete','vw_radcheck');"
					disabled="disabled">
					<!--批量删除-->
					<fmt:message key="tariff.deleteb" />
				</button>
				<button type="button" id="openmodf"
					onclick="openDiaQueryG('modify','vw_radcheck');"
					disabled="disabled">
					<!--批量修改-->
					<fmt:message key="tariff.modifyb" />
				</button>
				<button type="button" id="exportf"
					onclick="thisDownLoad('tsdBilling','mssql','vw_radcheck','<%=languageType%>');"
					disabled="disabled">
					<!--导出-->
					<fmt:message key="global.exportdata" />
				</button>
				<button type="button" id="printf" onclick="print()"
					disabled="disabled">
					<!--打印-->
					<fmt:message key="tariff.printer" />
				</button>

			</div>


		</div>
		<div class="neirong" id="add" style="display: none">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							项目名称
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="closeo()"><span style="margin-left: 5px;">关闭</span>
						</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd">
				<table width="100%" id="tdiv" border="0" cellspacing="0"
					cellpadding="0" style="line-height: 33px; font-size: 12px;">
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="lUserName"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iUserName" class="textclass"
								maxlength="64" />
							<label class="addred"></label>
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="sRealName"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="isRealName" maxlength="50"
								class="textclass" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="Value"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iValue" maxlength="50" class="textclass" />
						</td>
					</tr>

					<tr>
						<td colspan="6" align="left" bgcolor="#FFFFFF">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="12%" align="right" class="labelclass">
										<label id="sDh2"></label>
									</td>
									<td colspan="2" align="left"
										style="border-bottom: 1px solid #A9C8D9;">
										<select name="selname" id="isDh2" class="textclass"
											onchange="seluser()"></select>
										<input type="text" id="isDh22" />
									</td>
									<td width="12%" align="right" class="labelclass">
										<label id="sAddress"></label>
									</td>

									<td width="42%" style="border-bottom: 1px solid #A9C8D9;">
										<input type="text" id="isAddress" onfocus="c_p_address_fun()"
											class="textclass" style="width: 90%;" onKeyUp="notecheck()"
											class="input_2" />
									</td>
									<td width="12%" style="border-bottom: 1px solid #A9C8D9;">
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr id="dizhi">
						<td colspan="6">
						<td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="sDh"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="isDh" maxlength="20"
								onkeypress="var k=event.keyCode;   return  (k==45)||(k>=48&&k<=57)"
								style="ime-mode: Disabled" class="textclass" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="sRegDate"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="isRegDate"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								class="textclass" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="feeendtime"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="ifeeendtime"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								class="textclass" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="iFeeTypeTime"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iiFeeTypeTime"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								class="textclass" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="iStatus">
							</label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="iiStatus" id="iiStatus" class="textclass"></select>
							<input type="text" id="iiStatus2" class="textclass2" />
						</td>


						<td width="12%" align="right" class="labelclass">
							<label id="PayType"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select id="iPayType" class="textclass"></select>
							<input type="text" id="iPayType2" class="textclass2" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="sDh1"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="iPayType" id="isDh1" class="textclass">
							</select>
							<input type="text" id="isDh12" class="textclass2" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="iFeeType"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="iiFeeType" id="iiFeeType" class="textclass"
								onchange="feetypechange()">
							</select>
							<input type="text" id="iiFeeType2" class="textclass2" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="speed"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="ispeed" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="RemainFee"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iRemainFee" maxlength="12"
								onkeypress="var   k=event.keyCode;   return   (k==46)||(k>=48&&k<=57)"
								class="textclass" style="ime-mode: disabled" />
						</td>


						<td width="12%" align="right" class="labelclass">
							<label id="Fee5"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iFee5" class="textclass" maxlength="12"
								style="ime-mode: disabled"
								onkeypress="var   k=event.keyCode;   return   (k==46)||(k>=48&&k<=57)" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="PauseStartTime"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iPauseStartTime"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								class="textclass" onchange="timechange()" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="PauseStopTime"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iPauseStopTime"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								class="textclass" onchange="timechange()" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="AcctStartTime"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iAcctStartTime"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								class="textclass" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="AcctStopTime"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iAcctStopTime"
								onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"
								class="textclass" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="vlanid"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="ivlanid" maxlength="32" class="textclass" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="UserName1"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iUserName1" maxlength="64"
								class="textclass" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="iSimultaneous"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select id="iiSimultaneous" class="textclass"></select>
							<input type="text" id="iiSimultaneous2" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="ipaddr"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iipaddr" maxlength="20"
								onkeypress="var   k=event.keyCode;   return   (k==46)||(k>=48&&k<=57)"
								class="textclass" style="ime-mode: disabled" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="sBm"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="seluserarea" id="isBm" class="textclass"
								onchange="changebumen(2)"></select>
							<input type="text" id="isBmm" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="hth"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="ihth" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="sBm2"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="seluserarea" id="isBm2" class="textclass"
								onchange="changebumen(3)"></select>
							<input type="text" id="isBm22" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="sBm3"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="seluserarea" id="isBm3" class="textclass"
								onchange="changebumen(4)"></select>
							<input type="text" id="isBm32" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="sBm4"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="seluserarea" id="isBm4" class="textclass"></select>
							<input type="text" id="isBm42" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="idtype"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<select name="iidtype" id="iidtype" class="textclass">

							</select>
							<input type="text" id="iidtype2" class="textclass2" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="idcard"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iidcard" maxlength="32" class="textclass" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="mobile"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="imobile" maxlength="16"
								onkeypress="var k=event.keyCode;   return  (k==45)||(k>=48&&k<=57)"
								class="textclass" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="linkman"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="ilinkman" maxlength="32" class="textclass" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="linkphone"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="ilinkphone" maxlength="32"
								onkeypress="var k=event.keyCode;   return  (k==45)||(k>=48&&k<=57)"
								class="textclass" />
						</td>
						<td width="12%" class="labelclass"></td>
						<td width="20%" style="border-bottom: 1px solid #A9C8D9;"></td>
					</tr>
				</table>

				<div class="midd_butt">
					<!-- 修改 -->
					<button class="tsdbutton" id="modify"
						style="width: 63px; heigth: 27px;" onclick="modify1()">
						<fmt:message key="global.edit" />
					</button>
					&nbsp;
					<!-- 批量修改 -->
					<button class="tsdbutton" id="modifyB"
						style="width: 79px; heigth: 33px;" onclick="fuheModify()">
						<fmt:message key="tariff.modifyb" />
					</button>
					&nbsp;
					<!-- 取消-->
					<button class="tsdbutton" id="reset"
						style="width: 63px; heigth: 27px;" onclick="resett()">
						取消
					</button>
					&nbsp;
					<!-- 关闭 -->
					<button class="tsdbutton" id="closeo"
						style="width: 63px; heigth: 27px;" onclick="closeo()">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>


		<div class="neirong" id="pan2" style="display: none">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							项目名称
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="$('#closeoq').click()"><span
							style="margin-left: 5px;">关闭</span> </a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>

			<div class="midd">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					style="line-height: 33px; font-size: 12px;">
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="UserNameq"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iUserNameq" class="textclass"
								maxlength="64" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="sRealNameq"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="isRealNameq" maxlength="50"
								class="textclass" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="sDhq"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="isDhq" style="ime-mode: disabled"
								maxlength="20"
								onkeypress="var k=event.keyCode;   return  (k==45)||(k>=48&&k<=57)"
								class="textclass" />
						</td>
					</tr>

					<tr>
						<td colspan="6" align="left" bgcolor="#FFFFFF">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="12%" align="right" class="labelclass">
										<label id="sAddressq"></label>
									</td>

									<td width="42%" style="border-bottom: 1px solid #A9C8D9;">
										<input type="text" id="isAddressq"
											onfocus="c_p_address_funq()" class="textclass"
											style="width: 90%;" onKeyUp="notecheckq()" class="input_2" />
									</td>

									<td width="46%" style="border-bottom: 1px solid #A9C8D9;">
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr id="dizhiq">
						<td colspan="6">
						<td>
					</tr>
				</table>

				<div class="midd_butt">
					<!-- 查询     -->
					<button class="tsdbutton" id="jdquery" onclick="QbuildParams();">
						<fmt:message key="global.query" />
					</button>
					<!-- 关闭 -->
					<button class="tsdbutton" id="closeoq"
						style="width: 63px; heigth: 27px;" onclick="closeo()">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>

<!-- 导出数据 -->
		<div class="neirong" id="thefieldsform" style="display: none;width:800px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">选择您要导出的数据字段</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				<div class="midd" >
					   <form action="#" onsubmit="return false;">
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<div id="thelistform" style="margin-left: 10px;max-height: 200px;overflow-y: auto;overflow-x: hidden;">
								
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query"
					onclick="checkedAllFields()">
					全选
				</button>
				<button type="submit" class="tsdbutton" id="query"
					onclick="getTheCheckedFieldstwo('broadband','mssql','radcheck','vw_radcheck')">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>
					
				</div>
		</div>	
		


		<!-- 添加模板面板 -->
		<div id="modT" style="display: none" class="neirong">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							功能名称
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="closeoMod()"><span
							style="margin-left: 5px;"><fmt:message key="global.close" />
						</span> </a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form id='addquery' name="addquery" onsubmit="return false;"
					action="#">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0" style="line-height: 33px; font-size: 12px;">

						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="nameg_mod">
									<fmt:message key="oper.modName" />
								</label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" name="name_mod" id="name_mod"
									onpropertychange="TextUtil.NotMax(this)" maxlength="50"
									class="textclass" />
								<font style="color: #ff0000;">*</font>
							</td>

							<td width="12%" align="right" class="labelclass">
								<label id=''></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;"></td>

							<td width="12%" align="right" class="labelclass"></td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;"></td>
						</tr>
					</table>
				</form>
				<div class="midd_butt">
					<!-- 保存 -->
					<button class="tsdbutton" id="saveModB"
						style="width: 80px; heigth: 27px;" onclick="saveModQuery(1);">
						<fmt:message key="global.save" />
					</button>
					<!-- 关闭 -->
					<button class="tsdbutton" id="closeModB"
						style="width: 63px; heigth: 27px;" onclick="closeoMod();">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>


		<!-- 不动的部分 -->
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
			<input type="hidden" id="management"
				value="<fmt:message key="ip.management"/>" />
			<input type="hidden" id="worninfo"
				value="<fmt:message key="ip.worn"/>" />
			<input type="hidden" id="worntips"
				value="<fmt:message key="ip.worntips"/>" />
			<input type="hidden" id="deletepower"
				value="<fmt:message key="global.deleteright"/>" />
			<input type="hidden" id="editpower"
				value="<fmt:message key="global.editright"/>" />

			<input type="hidden" id="deletefailed"
				value="<fmt:message key="ip.deletefailed"/>" />
			<input type="hidden" id="selectarea"
				value="<fmt:message key="ip.select"/>" />
			<input type="hidden" id="inputip"
				value="<fmt:message key="ip.inputip"/>" />
			<input type="hidden" id="selectarea"
				value="<fmt:message key="ip.selectarea"/>" />
			<input type="hidden" id="addmemo"
				value="<fmt:message key="ip.addmemo"/>" />



			<input type="hidden" id="addright" />
			<input type="hidden" id="addBright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="delBright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="editBright" />
			<input type="hidden" id="exportright" />
			<input type="hidden" id="printright" />
			<input type="hidden" id="editfields" />
			<input type="hidden" id="userid" value="<%=userid%>" />
			<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
			<input type="hidden" id="nowtime" value="<%=nowTime%>" />

			<!-- 国际化保存表字段名 46个-->

			<input type="hidden" id="id" />
			<input type="hidden" id="UserName" />


			<!-- /****日志*** -->
			<input type='hidden' id='userloginip'
				value='<%=Log.getIpAddr(request)%>' />
			<input type='hidden' id='userloginid'
				value='<%=session.getAttribute("userid")%>' />
			<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
			<!-- 批量修改操作 -->
			<input type="hidden" id="logoldstr" />
			<input type='hidden' id='oldh' />
			<input type='hidden' id='areah' />
			<input type="hidden" id="addh" />
			<input type="hidden" id="edith" />
			<!-- 日志修改操作时，保存旧数据46个记录 -->
			<input type="hidden" id="UserNameoh" />
			<input type="hidden" id="idoh" />
			<input type="hidden" id="Valueoh" />
			<input type="hidden" id="ipaddroh" />
			<input type="hidden" id="vlanidoh" />
			<input type="hidden" id="sRealNameoh" />
			<input type="hidden" id="iStatushidden" value='' />
			<!-- 存放用户状态 -->
			<!-- 选择框   -->
			<input type="hidden" id="selsDh1" />
			<input type="hidden" id="selPayType" />
			<input type="hidden" id="selsDh2" />
			<input type="hidden" id="seliFeeType" />
			<input type="hidden" id="selidtype" />
			<input type="hidden" id="selisBm" />
			<input type="hidden" id="seliSimultaneous" />
			<input type="hidden" id="seliStatus" />


			<input type="hidden" id="fuheid" />

			<!-- jqGrid可以显示的字段 -->
			<input type="hidden" id="ziduans" />
			<!-- 高级查询 模板隐藏域 -->
			<input type="hidden" id="queryright" />
			<input type="hidden" id="saveQueryMright" />
			<!-- 查询树信息存放 -->
			<input type="hidden" id='treepid' />
			<input type="hidden" id='treecid' />
			<input type="hidden" id='treestr' />
			<input type="hidden" id='treepic' />
			<input type="hidden" id="useridd" value="<%=userid%>" />

			<input type="hidden" id="userarea"
				value="<%=request.getSession().getAttribute("userarea")%>" />


		</div>

	</body>
</html>