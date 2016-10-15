<%----------------------------------------
	name: addUser.jsp
	author: huoshuai
	version: 1.0, 
	description: 宽带账号开户。
	modify: 
		2009-12-09 霍帅 
---------------------------------------------%>


<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="com.tsd.service.util.Log"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String area = (String) session.getAttribute("chargearea");
	String userareaid = (String) session.getAttribute("userarea");
	String depart = (String) session.getAttribute("departname");
	/////////////////Java取当前时间
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
	String initValue = "2999-01-01 00:00:00";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><fmt:message key="AddUser.kaihu" />
		</title>
<!-- 导入的js文件 -->
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<script src="style/js/mainStyle.js" type="text/javascript"></script>
		<!-- 弹出对话框需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<script type="text/javascript" src="css/tree/dtree.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<!-- 页面国际化 -->
		<script type="text/javascript" src="script/broadband/usercat/Internationalization.js"></script>
		<!-- 调用接口js -->
		<script type="text/javascript" src="script/broadband/business/tsd_interface.js"></script>
		<!-- 导入js文件结束 -->
		<!-- 导入css文件开始 -->
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="js/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="css/tree/dtree.css" />		
        <!-- 导入css文件结束 -->
		<!-- 新的面板样式 -->			
        <style type="text/css">
		#input-Unit .title{width:100%; height:32px; background:url(style/images/public/kuangbg.jpg); border-bottom:1px solid #C8D8E5;  text-align:left; color:#3C3C3C; }
		</style>
		<!-- 对导航栏异常处理 -->
		<style type="text/css">
#navBar1 {
	height: 26px;
	background: url(style/images/public/daohangbg.jpg);
	line-height: 28px;
}

#navBar1 .navBar {
	
}

#navBar1 .d2back {
	float: right
}
</style>
		<style type="text/css">
#navBardd {
	height: 26px;
	background: url(style/images/public/daohangbg.jpg);
	line-height: 28px;
}

cas {
	float: left;
	width: 100%;
	height: 26px;
	background: url(style/images/public/daohangbg.jpg) repeat-x;
	line-height: 28px;
}
</style>

		<style type="text/css">
#inputtext input,#inputtext select {
	width: 130px;
	margin-left: 0px;
	a margin-right: 3px;
}

#inputtext table td {
	margin-left: 5px;
	padding: 3px;
}

#submitButton,#phoneSubmitButton {
	height: 30px;
	background: url(style/images/public/buttonbg.jpg) repeat-x;
	border: #CCCCCC 1px solid;
	cursor: pointer;
	width: 100%;
	float: left; *
	float: none;
	border-top: #CCCCCC 1px solid;
	border-bottom: #CCCCCC 1px solid;
}

#cbox {
	width: 15px;
	height: 15px;
}
body {
	text-align: left
}
.neirong .midd #grid table{line-height:18px;}
.neirong .midd #queryHTHdw tr{line-height:18px;}
</style>
<script type="text/javascript">
		 $(function(){
		  $("tbody>tr:odd").addClass("odd"); //先排除第一行,然后给奇数行添加样式
		  $("tbody>tr:even").addClass("even"); //先排除第一行,然后给偶数行添加样式
		 })
		</script>
		<script language="javascript">
			/******************************************
			**  查看当前用户的扩展权限，对spower字段进行解析 *
			*****************************************/
				function getUserPower(){
				 var urlstr=tsd.buildParams({packgname:'service',
							 			     clsname:'Procedure',
										     method:'exequery',
							 				 ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
							 				 tsdpname:'adduser.getPower',//存储过程的映射名称
							 				 tsdExeType:'query',
							 				 datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = "<%=userid%>";//$('#userid').val();	
				var groupid = $('#zid').val();
				var imenuid = $('#imenuid').val();
				/****************
				*   拼接权限参数 *
				**************/
				var addright = '';
				var addBright='';
				var deleteright = '';
				var delBright='';
				var editright = '';
				var editBright = '';
				var exportright='';
				var printright='';
				var saveright='';
				var checkright='';
				var BroadbandBusinessright='';//选择宽带业务复选框权限
				var TelphoneBusinessright='';//选择电话业务复选框权限
				var PrivatelyZFright='';//私费用户杂费权限
				var PublicZFright='';//公费用户杂费权限
				var c_p_address_addright='';//添加新地址
				var addressinputright='';//地址是否可以选择
				var flag = false;				
				//是否可以不选一次性费用项
				var ableForNoChoose = false;				
				var spower = '';				
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

				if(spower=='all@'){
						addright = 'true';
						addBright='true';
						deleteright = 'true';
						delBright = 'true';
						editright = 'true';
						editBright = 'true';
						exportright='true';
						printright='true';
						saveright='true';
						checkright='true';
						BroadbandBusinessright='true';//选择宽带业务复选框权限
						TelphoneBusinessright='true';//选择电话业务复选框权限
						PrivatelyZFright='true';//私费用户杂费权限
				        PublicZFright='true';//公费用户杂费权限
						c_p_address_addright='true';//添加新地址
						addressinputright='true';
						flag = true;
						
						//是否可以不选一次性费用项
						ableForNoChoose = true;
						
				}else if(spower!=''&&spower!='all@'){
						var spowerarr = spower.split('@');						
						for(var i = 0;i<spowerarr.length-1;i++){
							addright += getCaption(spowerarr[i],'add','')+'|';							
							addBright += getCaption(spowerarr[i],'addB','')+'|';														
							deleteright += getCaption(spowerarr[i],'delete','')+'|';							
							delBright += getCaption(spowerarr[i],'delB','')+'|';							
							editright += getCaption(spowerarr[i],'edit','')+'|';								
							editBright += getCaption(spowerarr[i],'editB','')+'|';								
							exportright += getCaption(spowerarr[i],'export','')+'|';								
							printright += getCaption(spowerarr[i],'print','')+'|';								
							saveright += getCaption(spowerarr[i],'save','')+'|';						
							checkright += getCaption(spowerarr[i],'check','')+'|';
							BroadbandBusinessright += getCaption(spowerarr[i],'broadYW','')+'|';						
							TelphoneBusinessright += getCaption(spowerarr[i],'telphoneYW','')+'|';
							c_p_address_addright += getCaption(spowerarr[i],'addnewAddress','')+'|';
							PrivatelyZFright += getCaption(spowerarr[i],'PrivatelyZF','')+'|';
							PublicZFright += getCaption(spowerarr[i],'PublicZF','')+'|';	
							addressinputright += getCaption(spowerarr[i],'addressinput','')+'|';							
							//是否可以不选
							if(getCaption(spowerarr[i],'ableForNoChoose','')=="true")
							{
								ableForNoChoose = true;
							}							
						}
				}
				
				var hasadd = addright.split('|');
				var hasaddB = addBright.split('|');
				var hasdelete = deleteright.split('|');
				var hasdelB = delBright.split('|');
				var hasedit = editright.split('|');
				var haseditB = editBright.split('|');
				var hasexport = exportright.split('|');
				var hasprint = printright.split('|');
				var hassave = saveright.split('|');
				var hascheck = checkright.split('|');
				var hasBroadbandBusiness = BroadbandBusinessright.split('|');
				var hasTelphoneBusiness = TelphoneBusinessright.split('|');
				var hasc_p_address_add = c_p_address_addright.split('|');
				var hasPrivatelyZF = PrivatelyZFright.split('|');
				var hasPublicZF = PublicZFright.split('|');
				var hasaddressinput = addressinputright.split('|');
				var str = 'true';

				if(flag==true){
					$("#addright").val(addright);
					$("#addBright").val(addBright);
					$("#deleteright").val(deleteright);
					$("#delBright").val(delBright);
					$("#editright").val(editright);
					$("#editBright").val(editright);
					$("#exportright").val(exportright);
					$("#printright").val(printright);
					$("#saveright").val(saveright);
					$("#checkright").val(checkright);
					$("#BroadbandBusinessright").val(BroadbandBusinessright);
					$("#TelphoneBusinessright").val(TelphoneBusinessright);
					$("#c_p_address_addright").val(c_p_address_addright);
					$("#PrivatelyZFright").val(PrivatelyZFright);
					$("#PublicZFright").val(PublicZFright);
					$("#addressinputright").val(addressinputright);
				}else{
					for(var i = 0;i<hasadd.length;i++){
						if(hasadd[i]=='true'){
							$("#addright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasaddB.length;i++){
						if(hasaddB[i]=='true'){
							$("#addBright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelete.length;i++){
						if(hasdelete[i]=='true'){
							$("#deleteright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasdelB.length;i++){
						if(hasdelB[i]=='true'){
							$("#delBright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasedit.length;i++){
						if(hasedit[i]=='true'){
							$("#editright").val(str);
							break;
						}
					}
					for(var i = 0;i<haseditB.length;i++){
						if(haseditB[i]=='true'){
							$("#editBright").val(str);
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
					for(var i = 0;i<hassave.length;i++){
						if(hassave[i]=='true'){
							$("#saveright").val(str);
							break;
						}
					}
					for(var i = 0;i<hascheck.length;i++){
						if(hascheck[i]=='true'){
							$("#checkright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasBroadbandBusiness.length;i++){
						if(hasBroadbandBusiness[i]=='true'){
							$("#BroadbandBusinessright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasTelphoneBusiness.length;i++){
						if(hasTelphoneBusiness[i]=='true'){
							$("#TelphoneBusinessright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasc_p_address_add.length;i++){
						if(hasc_p_address_add[i]=='true'){
							$("#c_p_address_addright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasPrivatelyZF.length;i++){
						if(hasPrivatelyZF[i]=='true'){
							$("#PrivatelyZFright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasPublicZF.length;i++){
						if(hasPublicZF[i]=='true'){
							$("#PublicZFright").val(str);
							break;
						}
					}
					for(var i = 0;i<hasaddressinput.length;i++){
						if(hasaddressinput[i]=='true'){
							$("#addressinputright").val(str);
							break;
						}
					}
				}
				//隐藏域赋值 设置是否可以不选
				$("#ableForNoChoose").val(ableForNoChoose?"true":"false");						
			}
		</script>
		<script type="text/javascript">		
		//方法的封装
		/*
		*DataSource数据源
		*SQLQuery查询主语句（非分页）
		*SQLQueryPage查询分页
		*Operator:操作类型（1.exe执行）（2.query查询）
		*DataType常用的两种（1.xml(<row><cell>))(2.xmlattr(<row id='' username=''>))
		*DataArrayType有两种 'many'为两维数组如array[1]['sss'] 'single'为单数组
		*AjaxParams用在AJAX中请求的参数
		*QueryFields要查询的字段，用Array表示
		*/
		var SQLTool={
			exeTsdQuery:function(DataSource,SQLQuery,SQLQueryPage,Operator,DataType,DataArrayType,AjaxParams,QueryFields)
				{	
					var urlstr='';
					var result;
					if(SQLQueryPage!='')
					{
						urlstr=tsd.buildParams(
							{ 					
								packgname:'service',//java包
							 	clsname:'ExecuteSql',//类名
							 	method:'exeSqlData',//方法名
							 	//0是tsd(mssql) 1是broadband
								ds:DataSource?'broadband':'tsdBilling',
							 	tsdcf:DataSource?'mysql':'mssql',
							 	tsdoper:Operator, 
							 	datatype:DataType, 
							 	tsdpk:SQLQuery,
							 	tsdpkpagesql:SQLQueryPage
							 });
					}else{
						urlstr=tsd.buildParams({
								packgname:'service',
							 	clsname:'ExecuteSql',
							 	method:'exeSqlData',
							 	//0是tsd(mssql) 1是broadband
								ds:DataSource?'broadband':'tsdBilling',
							 	tsdcf:DataSource?'mysql':'mssql',
							 	tsdoper:Operator, 
							 	datatype:DataType, 
							 	tsdpk:SQLQuery
						});
					}
														
					//alert('mainServlet.html?'+urlstr+AjaxParams);
					//execute ajax
					$.ajax(
					{
						url:'mainServlet.html?'+urlstr+AjaxParams,
						datatype:'xml',
						cache:false,
						timeout: 1000,
						async: false ,
						success:function(xml)
						{	
							//$(xml).find('row').size();
							if(DataArrayType=='single')
							{
								result=new Array();
								$(xml).find('row').each(function()
								{
									//设置this为当前xml循环
									var handle=$(this);
									$.each(QueryFields,function(i,n)
									{
										result[n]=handle.attr(n);
									});
								});
							}
							else
							{
								result=new Array();
								var array1length=$(xml).find('row').size();
								//给一个初始的index
								var index=0;
								$(xml).find('row').each(function(){									
									//this转接
									var handle=$(this);
									var result2=new Array();
									$.each(QueryFields,function(i,n)
									{
										var value=handle.attr(QueryFields[i]);
										result2[QueryFields[i]]=value;
										result[index]=result2;
									});									
									index++;																		
								});
							}
						}
					});						
						return result; //返回请求结果
					},
										
				//一个取grid中一行数据的标准方法
				//gridid为grid的ID号，row为哪一行,cell为哪一列
				getGridSelRowData:function(gridid,rowid,cellid)
				{
						var rowData;
						if($.browser.mozilla)
						{
							rowData = document.getElementById(gridid).rows[rowid].cells[cellid].textContent;
						}
						if($.browser.msie)
						{
							rowData = document.getElementById(gridid).rows[rowid].cells[cellid].innerText;
						}						
						return rowData;						
					}					
				}
		
			//此处定义的都是全局变量
			//全局设置宽带中是否可读
			var GlobalBroadbandIsRead=false;
			//此处定义的一个数组是存储查询杂费类型时保存的，如GlobalzafeeArray['1']='更换入户光纤及熔接费'
			var GlobalzafeeArray=new Array();
			//保存当前用户域
			var GlobalUserArea='';
			//保存当前用户输入的用户前缀
			var GlobalUserNamePre='';
			//选择可用空帐号时grid的列名
			var GridFieldName='';
			//用户类型  0是小区网用户 1是外网用户，默认是0
			var GlobalUserClass=0;
			//当前用户有没选择计费规则
			var GlobalFeeTypeIsCheck=false;			
			var broadbandtotalfeeto;
			
			function setBroadbandIsRead()
			{
				if(GlobalBroadbandIsRead==false)
				{   
				    /*
					$("#broadband_frame").find("input").attr("readonly","readonly");
					$("#broadband_frame").find("select").not($("select[id='UserClass']")).attr("disabled","disabled");
					$("#broadband_frame").find("input[type='checkbox']").attr("disabled","disabled");
					$("#broadband_frame").find("input[type='radio']").attr("disabled","disabled");
					$("button[id='save']").attr("disabled","disabled");
					$("#feetypelist input[type='radio']").attr("dispabled","disabled");
					*/
				}
				else
				{
				    /*
					$("#broadband_frame").find("input").attr("readonly","");
					$("#broadband_frame").find("input[type='checkbox']").attr("disabled","");
					$("#broadband_frame").find("select").not($("select[id='UserClass']")).attr("disabled","");
					$("#broadband_frame").find("input[type='radio']").attr("disabled","");
					//费用总计一直只读
					$("#broadbandtotalfee").attr("readonly","readonly");
					$("button[id='close']").attr("disabled","");
					$("#feetypelist input[type='radio']").attr("dispabled","disabled");
					*/
				}
				//有几个需要一直只读
				$("#UserName").attr("readonly","");
				$("#telphoneB").attr("readonly","");
				//$("#broadbandtotalfee").attr("readonly","");
			}
			
			//判断两个业务选中与否，如果电话选中则基本信息中的电话是不能输入的，如果电话没有被选中的话则用户基本信息处的电话是可以输入的
			//在这里判断用户的杂费项获取宽带业务杂费，从表radywsl(mysql数据库)里读取该业务所涉及的杂费项目，
			//再根据这些杂费项目从表tbl_IspList1(mysql数据库)里取出每项的费用，页面默认是选择所有的项目。营业员根据权限来定是否可选择。
			function setBasicInfoPhoneInput(flag)
			{
				//现在统一设置为只读
				$("#sDh").attr("readonly","readonly");
			}			
		</script>

		<script type="text/javascript">
					//给宽带用户开户表单输入帐号增加个键盘事件
        //********************************					
			$(document).ready(function(){
				$("input[id='UserName']").keypress(function(e)
    				{
    					if(e.keyCode==13)
    					{
    						isExist();
    					}
    				});    			
			});
    		$(function(){
    				LoadPage();
    				//setBroadbandIsRead();
    				$("#UserName").select();
			 	    $("#UserName").focus();
    				//权限
    				getUserPower();
    				var BroadbandBusinessright =　$("#BroadbandBusinessright").val();
	                var TelphoneBusinessright = $("#TelphoneBusinessright").val();
	                var c_p_address_addright = $("#c_p_address_addright").val();
	                var PrivatelyZFright = $("#PrivatelyZFright").val();
			 	    var PublicZFright = $("#PublicZFright").val();
	                if(BroadbandBusinessright=="true"){
	                 $("#BroadbandBusiness").attr("disabled","");
	                }
	                if(TelphoneBusinessright=="true"){
	                 $("#TelphoneBusiness").attr("disabled","");
	                }
	                if(c_p_address_addright=="true"){
	                 $("#c_p_address_add").removeAttr("disabled");
	                }
    				//页面加载完后才能取到session中的区域值
    				GlobalUserArea=$("#HiddenUserArea").val();
    				//alert(GlobalUserArea);
    				var checkright=$("checkright").val();
    				if(checkright==undefined)
    				{
    					//alert(1);
    					//$("")
    				}
    				if($("#addressinputright").val()=="true"){
				    	$("#sAddress").focus(function(){c_p_address_fun();});
						$("#sAddress").keyup(function(){notecheck();});
					}
    			});
    		function LoadPage()
    		{
    		
    			//给获取空帐号取别名
    			var languageType = $("#languageType").val();
				var strr1 = getI18n(languageType,'radaccount');
				var strarr1 = strr1.split(",");
				GridFieldName=strarr1[0];	
    		}
    			
    
    	//计费规则变更时动态更新带宽
    	
        /**************现在让用户自己改动***************/
        var feenameto="";//这个全局变量是当前选择的宽带计费，提速中使用
        var baseFeeto="";//这个全局变量是当前选择的宽带计费，提速中使用
        var ifeecodeto="";
    	function setspeed(params){
    	 var selectRow =  parseInt($("#feetypelist input[type='radio'][checked]").attr("id").substring(4,5));
		 //取到feecode的值
		 var selData = SQLTool.getGridSelRowData('feetypeeditgrid',selectRow,2);
		 var FeeNameto=new Array('feename','basefee','speed','speed_iag');
		 var feenametoto =SQLTool.exeTsdQuery(1,'tbl_IspList.totoquery','','query','xmlattr','single','&FeeCode='+selData,FeeNameto);
		 var feename=feenametoto[FeeNameto[0]];
		 var baseFee = feenametoto[FeeNameto[1]];
		 var speed = feenametoto[FeeNameto[2]];
		 var speed_iag = feenametoto[FeeNameto[3]];
		 ifeecodeto=selData;
		 var UserType = $("#UserType").val();
		 if(UserType==2||UserType==4){
		   baseFeeto=baseFee;
		   addSpeed();
		 }
		 
		 var devno = $("#devno").val();//得到BAS数据进行判断，如果为1就通过转换成M来显示，如果是2就直接显示并替换前面的PPPOE
		 if(devno==""){alert("<fmt:message key="broadband.qxzBASsb"/>");$("#devno").select();$("#devno").focus();getdevno();return false;}
		 feenameto=feename;
		 if(confirm("<fmt:message key="broadband.qdxzJFGZ"/>["+feename+"]<fmt:message key="broadband.dfwfsm"/>","操作提示")){
		    //如果用户类型为公费的时候就可以选择带宽提速计费规则
		    var usertype = $("select[id='UserType'] option[selected]").val();
		      $("#tishispeed").empty();
		      memoto="";
		      youhueije="";
		      getIFeeType();//加载杂费
		      isnotifurgent();//得到是否紧急下拉框值f
    	      $("#ifurgent").val("普通");    	          	      
    	      $('#speed').val("");//每次查询前清空
    	      $("#ispeed").val("");//每次查询前清空
    	        
    	      if(devno=='1'){
    	         var ispeed = speedConversion(speed);//将带宽转换成M数
    		     $('#speed').val(ispeed);//得到的带框加载到页面上显示几M
    		     $("#ispeed").val(speed);//记载到隐藏欲里等待插入到数据库中
    	      }else if(devno=='2'){
    	         $("#ispeed").val(speed_iag);//记载到隐藏欲里等待插入到数据库中
    	         speed_iag=speed_iag.replace('pppoe',"");
    	         $('#speed').val(speed_iag);//得到的带框加载到页面上显示几M    	             	        
    	      }else{
    	         $('#speed').val("");//清空
    	         $("#ispeed").val("");//清空  
    	      }
    	     $("#payitem").removeAttr("disabled");
    	     $("#transferHTH").val(""); 
			 $("#transferHTHbox").attr("checked","");
			 $("#transferHTHbox").attr("disabled","disabled"); 		      
		  }else{
			      $(":radio[name='feetype']").removeAttr("checked");
			      ifeecodeto="";
			      $("#tishispeed").empty();
			      $("#speed").val("");
			      getIFeeType();//加载杂费
			      isnotifurgent();//得到是否紧急下拉框值
    	          $("#ifurgent").val("普通");
		  } 
	   }
       
       //每次选择BAS设备是要做清空 
       function getdevno(){
          $('#speed').val("");//每次查询前清空
    	  $("#ispeed").val("");//每次查询前清空  
    	  $(":radio[name='feetype']").removeAttr("checked");
    	  ifeecodeto="";
	      $("#tishispeed").empty();
	      baseFeeto=100000;
		  addSpeed();	
		  getpayitem();	  
		  $("#transferHTH").val(""); 
		  $("#transferHTHbox").attr("checked","");
		  $("#transferHTHbox").attr("disabled","disabled"); 
       }
        
    	///////////////页面初始化调用信息
    	jQuery(document).ready(function(){
    	
    	var languageType = $("#languageType").val();
    	brodbandinter(languageType);//页面字段国际化    	
    	jiesuo();
    	$("#navBar").append(genNavv());
    	setBroadbandIsRead();
    	//页面表头当前位置显示
    	/*var  aaa=document.getElementsByTagName("i")
		for(var  i=0;i <aaa.length;i++){
    		if(aaa[i].id=="bar"){    //加个判断，subStr用法没查 
    		alert(aaa[i].id);
      		aaa[i].innerText="dddd";
      		break;
    	}
    	}*/
        //$("#navBar").$("#bar").value="ddddddd";        
    	});
    	
    	function jiesuo(){
	        $(window).unload(function(){
			kdunLock();
		    });
	    }
    	
    	//////////////初始化取数据
    	function getIFeeType(){
    						
					 
				//在加载杂费项之前先从数据库Mysql中取出radywsl中bname对应的feename
				var FeeItem='';
				var FeenameResult=SQLTool.exeTsdQuery(1,'adduser.queryBusinessZaFeiItem','','query','xmlattr','single','&BusinessName='+tsd.encodeURIComponent('setup'),['feename']);				
				//if(FeenameResult!=""){				
				var FeenameString=FeenameResult['feename'];
						
				if(FeenameString==undefined){
				  FeenameString="";
				}
				var FeenameArray=FeenameString.split('~');
				$.each(FeenameArray,function(i,n)
				{
					if(i==0)
					{
						FeeItem+="'"+tsd.encodeURIComponent(n)+"'";
					}
					else
					{
						FeeItem+=",'"+tsd.encodeURIComponent(n)+"'";
					}
				});
			
			var getarea = $("select[id='seluserarea'] :selected").html();			
			//返回杂费数组
			var manyZFResult=SQLTool.exeTsdQuery(1,'adduser.querySectionto','','query','xmlattr','many','&FeeItem='+FeeItem+'&area='+tsd.encodeURIComponent(getarea),['id','ssection','sitem','svalue']);
			
    		//拼<option>
    		//alert('sdfsdf '+manyZFResult[1]['sSection']);
    		var totalFee=0;
    		$("#zafeilist").empty();
    		$.each(manyZFResult,function(i,n)
    		{
    			var Sid=manyZFResult[i]['id'];
				var SsSection=manyZFResult[i]['ssection'];
				var sltem = manyZFResult[i]['sitem'];
				var SsValue=manyZFResult[i]['svalue'];
				//将查询出的杂费类型以GlobalzafeeArray['1']='杂费'
				GlobalzafeeArray[Sid]=SsValue;
				
				if(SsValue=='')
				{
					SsValue=0;
				}
				totalFee=parseFloat(totalFee)+parseFloat(SsValue);
				if(sltem!=undefined){				
				var checkBox="<div style='margin-left:10px;width:100%;text-align:left; height:25px; float:left;'><input type='checkbox' name='checkbox' id='checkbox' style='width:25;height=25' onclick='javascript:ChangeValue(this,$(this).val());' value='"+Sid+ "' scval='" + sltem + "' style='width:15px; height:15px; border:0px;float:left; line-height:'/><span style='line-height:20px; padding-left:5px; float:left;'>"+sltem+"</span></div>";
				$("#zafeilist").html($("#zafeilist").html()+checkBox);		
				$("#broadbandtotalfee").val("0");
				ifnotpayitem(sltem);
				}
    		});
	    	//}
	        }
	        
    		function ChangeValue(handle,id)
    		{
    			var sItemDom = $("input[type='checkbox'][name='checkbox'][checked]");
    			var sitem_tmp = "";
    			if($(sItemDom).size()>1)
    			{
    				for(var ii=0;ii<sItemDom.size();ii++)
    				{
    					sitem_tmp += $(sItemDom[ii]).attr("scval");
    					sitem_tmp += ","
    				}
    				sitem_tmp = sitem_tmp.substring(0,sitem_tmp.length-1);
    				sitem_tmp = "当前已选取多个费用项：" + sitem_tmp;
    				alert(sitem_tmp);
    			}
    		    var zafeilist = $("#zafeilist").val();
    			var value=GlobalzafeeArray[id];
    			var oldFee=$("#broadbandtotalfee").val();    			
    			if(value=="")
    			{
    				return;
    			}
    			if($(handle).attr("checked")==true)
    			{	
    				var total=parseFloat(oldFee)+parseFloat(value);
    				$("#broadbandtotalfee").val(total);
    			}
    			else
    		    {
	    			if(oldFee==0)
	    			{
	    				return;
	    			}
    				var total=parseFloat(oldFee)-parseFloat(value);
    				$("#broadbandtotalfee").val(total);
    			}
    		 }
    		
	    	  ///////取数据库中杂费表中的杂费金额
	    	  function getsValue(){
    			var urlstr=tsd.buildParams({ 
    										packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'adduser.querySectionById'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});
					var sId = $("#zafei").val();
					$.ajax({
						url:'mainServlet.html?'+urlstr+'&Id='+sId,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							/////////////////////////////
							//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
							$(xml).find('row').each(function(){
								$("#sValue").attr("value",$(this).attr("svalue"));//给金额赋值
							 });
						 }
					 });
    		}
    		////////检测开户帐号是否存在
    		function isExist(){
    			//判断当前按钮
    			//取出下拉列表中的值
    			var selectedUserClass = $("#UserClass option:selected ").val();
    			kdunLock();//解锁用户
    			//如果是小区网用户
    			if(selectedUserClass=="StreetUser")
    			{   
					if($("#UserName").val()!=""&&$("#UserName").val()!=null){
						 ////////////设置命令参数						 
						 var UserName=$("#UserName").val();
						 var pwdReg = /^\w+$/;					 
						    if(!pwdReg.test(UserName)){
						    alert("<fmt:message key="broadband.bcsrffzf"/>");
						    $("#UserName").focus();
						    return false;
						    }
						 var patrng=/^(dh|gem|htg)(\d|\w)+$/i;
						   if(!patrng.test(UserName)){
						      alert("<fmt:message key="broadband.accountKT"/>");
						      clernull();
						      return false;
						   }						 
					     getAccessmethods();//得到接入方式	   			    
						 if(kdLock(UserName)==true)
						 {
						 		var urlstr=tsd.buildParams({ packgname:'service',
								 					  clsname:'Procedure',
													  method:'exequery',
								 					  ds:'broadband',//数据源名称 对应的spring配置的数据源
								 					  tsdpname:'adduser.queryIsExist',//存储过程的映射名称
								 					  tsdExeType:'query',
								 					  datatype:'xmlattr'
								 					});
						 		var uInputValue = $("#UserName").val();
								 uInputValue=uInputValue.replace(/(^\s*)|(\s*$)/g,"");
							 //验证帐号不可为中文
							 for(i=0;i<document.getElementsByName("UserName")[0].value.length;i++){
	                            var c = document.getElementsByName("UserName")[0].value.substr(i,1);
	                            var ts = escape(c);
	                            if(ts.substring(0,2) == "%u"){
	                            document.getElementsByName("UserName")[0].value = "";
	                            //帐号不能输入中文/全角字符
	                            alert("<fmt:message key="AddUser.zhbnsrzw"/>");
	                            return false;
	                            }
	                         }	                        							 
							$.ajax({
								url:'mainServlet.html?'+urlstr+'&UserName='+uInputValue,
								datatype:'xml',
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(xml){
									/////////////////////////////
									///////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
									////////////////////////////
									$(xml).find('row').each(function(){
										
										var result = $(this).attr("result");
										
										if(result=="0"){
										    yijisBm();	
										    getBASsb();//得到BAS设备
										    $("#jobmemo").removeAttr("disabled");
										    $("#payitem").removeAttr("disabled");
										    $("#zafeilist").removeAttr("disabled");											       							    
											//jAlert("恭喜您，可以用此帐号进行开户!","消息提示框");
											var areakt = $("#userareaid").val();										
											 var strjq = UserName.substring(0,1);
											 if(areakt=="敦煌地区"&&strjq=="d"||areakt=="敦煌地区"&&strjq=="D"||areakt=="格尔木地区"&&strjq=="g"||areakt=="格尔木地区"&&strjq=="G"||areakt=="花土沟地区"&&strjq=="h"||areakt=="花土沟地区"&&strjq=="H"){
											 	alert('<fmt:message key="AddUser.AccountUsed" />');
											 	//在用户基本信息中显示要保存到数据库中的用户名
												$("#TrueUserName").val(uInputValue);
												//设置宽带相关表单取消只读
												//执行函数取消表单的只读
												$("#Values").val("666");
												$("#Valuess").val("666");
												disabledget();
												UserTypeSelect();//得到用户类型下拉单
												iSimultaneoustype();//得到同时在线数下拉单
												$("#telphoneB").select();
						                        $("#telphoneB").focus();	
						                        getuserareato();//的到用户区域下拉框
						                        var userareaid = $("#userareaid").val();
						                        $("#seluserarea").val(userareaid);				                        
						                        isnotifurgent();//得到是否紧急下拉框值f
		    	                                $("#ifurgent").val("普通");
											 }else{
											    alert("您选择的帐号开头与区域不符合,<fmt:message key="AddUser.AccountUsed" />");
											    //在用户基本信息中显示要保存到数据库中的用户名
												$("#TrueUserName").val(uInputValue);
												//设置宽带相关表单取消只读
												//执行函数取消表单的只读
												$("#Values").val("666");
												$("#Valuess").val("666");
												disabledget();
												UserTypeSelect();//得到用户类型下拉单
												iSimultaneoustype();//得到同时在线数下拉单
												$("#telphoneB").select();
						                        $("#telphoneB").focus();	
						                        getuserareato();//的到用户区域下拉框
						                        var userareaid = $("#userareaid").val();
						                        $("#seluserarea").val(userareaid);				                        
						                        isnotifurgent();//得到是否紧急下拉框值f
		    	                                $("#ifurgent").val("普通");
											 }
												    	                                    	                                                                 	                                				
										}else if(result=="1"){
											//jAlert("对不起，此开户帐号已存在!","消息提示框");
											alert("<fmt:message key="AddUser.UserIsExist" />");
											form1.UserName.focus();
											//每次判断前清空以前的帐号
	    			                        clernull();
											//设置宽带相关表单只读
											//disabledget();
											return false;
										}
									 });
								 }
							 });
						 }
					}else{
						//jAlert('请输入开户帐号!','消息提示框');
						alert("<fmt:message key="AddUser.mustInputAccount" />");
						form1.UserName.focus();
						return false;
					}
				}
				//如果是外网用户,弹出框供选择
				else
				{
				
					var result;
					var tsdpkSQL;
					var tsdpkpageSQL;
					var isPre;
					GlobalUserNamePre=tsd.encodeURIComponent($("#UserName").val());
					
					if(GlobalUserNamePre=='')
					{
						result = 
							SQLTool.exeTsdQuery(1,'adduser.queryAllEmptyAccountPage','','query','xmlattr','single','&sarea='+tsd.encodeURIComponent(GlobalUserArea),['result']);
						tsdpkSQL='adduser.queryAllEmptyAccount';
						tsdpkpageSQL='adduser.queryAllEmptyAccountPage';
						isPre=0;
					}
					else
					{
						result = 
							SQLTool.exeTsdQuery(1,'adduser.queryEmptyAccountPage','','query','xmlattr','single','&sarea='+tsd.encodeURIComponent(GlobalUserArea)+'&UserNamePre='+GlobalUserNamePre,['result']);
						tsdpkSQL='adduser.queryEmptyAccount';
						tsdpkpageSQL='adduser.queryEmptyAccountPage';
						isPre=1;
					}
					if(result['result']==0)
					{
						//jAlert("没有可用空帐号！","提示");
						alert('<fmt:message key="AddUser.NoEmptyAccount" />');
						return false;
					}
					else
					{
						var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:tsdpkSQL,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:tsdpkpageSQL//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
						if(isPre==0)
						{
							urlstr+='&sarea='+tsd.encodeURIComponent(GlobalUserArea);
						}
						if(isPre==1)
						{
							urlstr+='&sarea='+tsd.encodeURIComponent(GlobalUserArea)+'&UserNamePre='+GlobalUserNamePre;
						}
						$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr}).trigger("reloadGrid");
						autoBlockFormAndSetWH('SearchEmpty',15,200,'Qclose','#ffffff',true,305,400);
					}
					
				}
			 }			 
			 
			 var UserNameto="";
			 ///////添加开户信息
			 function isValiableddd(){
			        //autoBlockForm("choosePrintJob","150","close","#FFFFFF",false);			
				 	/////////调用存储过程添加开户信息
				 	/////设置命令参数
				 	var TUN = $("#TrueUserName").val();
				 	if($("#UserName").val()!=""&&$("#UserName").val()!=null){
					 		
					 		var params=buildParams();
					 		
					 		if(params==false){return false;} 		
						if(confirm("<fmt:message key="broadband.qddxzh"/>["+TUN+"]<fmt:message key="broadband.jxkhm"/>")){								
						 	var iSimultaneous = $("#iSimultaneous").val();
							/*调用接口，如果返回为true则继续执行下列的开户超做，如果返回false则提示遇到异常开户失败*/	 
							var vlid = $("#vlanid").val();
							var smacd = $("#smacaddr").val();
							var ipa = $("#ipaddr").val();
							vlid=vlid.replace(/(^\s*)|(\s*$)/g,"");	
							if(vlid.length==0){vlid='NO';}
							smacd=smacd.replace(/(^\s*)|(\s*$)/g,"");
							if(smacd.length==0){smacd='NO';}
							ipa=ipa.replace(/(^\s*)|(\s*$)/g,"");
							if(ipa.length==0){ipa='NO';}
							if(getinterface()=='YES'){
							 	var jkres=TSDInterface.ZXISAM.open($("#UserName").val(),$("#Values").val(),parseInt(iSimultaneous, 10),parseInt(1,10),'',[feenameto,vlid,smacd,ipa]);
								 	jkres = eval("("+jkres+")");
								 	if(jkres.info!="true"&&jkres.info!=true){
								 		alert("接口出现["+jkres.resultInfo.infoStr+"]异常，无法执行开户过程！");
								 		return false;
								 	}
						 	}
							var urlstr=tsd.buildParams({ packgname:'service',
									 					  clsname:'Procedure',
														  method:'exequery',
									 					  ds:'broadband',//数据源名称 对应的spring配置的数据源
									 					  tsdpname:'adduser.adduser',//存储过程的映射名称
									 					  tsdExeType:'query',
									 					  datatype:'xmlattr',
									 					  tsdUserId:'true'
									 					});
									 					
							///////////调用拼接的参数
							urlstr+=params;
							$.ajax({
								url:'mainServlet.html?'+urlstr,
								type:'post',
								datatype:'xml',
								cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								timeout: 1000,
								async: false ,//同步方式
								success:function(xml){
									/////////////////////////////
									////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
									$(xml).find('row').each(function(){
										var result = $(this).attr("result");
									
										if(result=="-1"){
											//jAlert("帐号已存在!","消息提示框");
											alert('<fmt:message key="stopkeepnumber.czhywqtxzc"/>');//此帐号以为其他用户抢先注册，请另行跟换其它帐号！
											GlobalBroadbandIsRead=false;
											 setBroadbandIsRead();
										}else{
										    var payitem = $("#payitem").val();//得到数据加载到隐藏域中
										    $("#payitemYCY").val(payitem);
										    
										    $("#jobidid").val(result);										    
										    var params = addrizhi();
										    //往日志表里插入日志 
										    writeLogInfo("","add",params);
										    //把得到的结果集传入到serlvet里面去
										    $.ajax({
								             url:'jobcode.html?'+"&telJobType="+'setup'+"&docId="+result+"&userid="+$("#userloginid").val()+"&transitionName=",
								             datatype:'xml',
								             cache:false,//如果值变化可能性比较大 一定要将缓存设成false
								             timeout: 1000,
								             async: false ,//同步方式
								             success:function(xml){								            
								             }});				
								          
								             //操作成功后往号线表里添加一条数据
								             infoairusers();											 
											 UserName = $("#UserName").val();
											 //设置为只读
											 GlobalBroadbandIsRead=false;
											 setBroadbandIsRead();
											 
											autoBlockForm("choosePrintJob","150","close","#FFFFFF",false); 
											clernull();//调用清空表单
											$("#UserName").select();
						                    $("#UserName").focus();						                    
						                    kdunLock();//解锁用户											
										}
									 });
								 }								 
							 });
							} 
				 	}else{
				 		alert('<fmt:message key="AddUser.mustInputAccount" />');
				 		//jAlert('请输入开户帐号!','消息提示框');
				 		clernull();
						$("#UserName").select();
						$("#UserName").focus();
						return false;    
				 	}
			}
			
			//开户天信息日志
			function addrizhi(){
			  var params="";
			  var userid = "<%=userid%>";
			  var area = $("#area").val();
			  var depart = $("#depart").val();
	          var UserName = $("#TrueUserName").val();
			  var sDh = $("#sDh").val();
	          var sAddress = $("#sAddress").val();
			  //var PayType = $("#PayType").val();
			  params+=tsd.encodeURIComponent('宽带开户 存储过程名：radywsl_zj ')
			  params+=tsd.encodeURIComponent(' 操作员:')+tsd.encodeURIComponent(userid);
			  params+=tsd.encodeURIComponent(' 工号区域:')+tsd.encodeURIComponent(area);
			  params+=tsd.encodeURIComponent(' 工号部门:')+tsd.encodeURIComponent(depart);
			  params+=tsd.encodeURIComponent(' 帐号:')+tsd.encodeURIComponent(UserName);
			  params+=tsd.encodeURIComponent(' 电话:')+sDh;
			  params+=tsd.encodeURIComponent(' 地址:')+tsd.encodeURIComponent(sAddress);
			  return params;
			}
			
			//开户成功后往号线插入一条数据日志
			function addairuser(){
			 var params="";
			 var UserName = $("#TrueUserName").val(); 
			 var sDh = $("#sDh").val();
			 var sRealName = $("#sRealName").val();
			 var sBm = $("#sBm").val();
			 var sAddress = $("#sAddress").val();		
			 var ssDh1 = $("#sDh0").val(); //联系电话			 
			 var linkman = $("#linkman").val();//联系人			 
			 var area = $("#area").val();//工号区域	
			 params+=tsd.encodeURIComponent('宽带开户 号线表：Air_users');
			 params+=tsd.encodeURIComponent(' 用户帐号:')+UserName;
			 params+=tsd.encodeURIComponent(' 电话:')+sDh;
			 params+=tsd.encodeURIComponent(' 姓名:')+tsd.encodeURIComponent(sRealName);
			 params+=tsd.encodeURIComponent(' 地址:')+tsd.encodeURIComponent(sAddress);
			 params+=tsd.encodeURIComponent(' 联系电话:')+tsd.encodeURIComponent(ssDh1);
			 params+=tsd.encodeURIComponent(' 联系人:')+tsd.encodeURIComponent(linkman);
			 params+=tsd.encodeURIComponent(' 工号区域:')+tsd.encodeURIComponent(area);	 
			 return params;
			}
			
			//操作成功后往号线表里添加一条数据
			function infoairusers(){
			   	var UserName = $("#TrueUserName").val(); 
			   	var sDh = $("#sDh").val();
			   	var sRealName = $("#sRealName").val();
			   	var sBm = $("#sBm").val();
			   	var sAddress = $("#sAddress").val();
			   	//联系电话
			 	var ssDh1 = $("#sDh0").val();
			 	//联系人
			 	var linkman = $("#linkman").val();
			 	//工号区域
			 	var area = $("#area").val();
			 	UserName = tsd.encodeURIComponent(UserName);
			 	sDh = tsd.encodeURIComponent(sDh);
			 	sRealName = tsd.encodeURIComponent(sRealName);
			 	sBm = tsd.encodeURIComponent(sBm);
			 	sAddress = tsd.encodeURIComponent(sAddress);
			 	linkphone = tsd.encodeURIComponent(ssDh1);
			 	linkman = tsd.encodeURIComponent(linkman);
			 	area = tsd.encodeURIComponent(area);
				var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'exe',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.airusersinfo',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdUserID:'ture'
						 				});	
					$.ajax({
					url:'mainServlet.html?'+urlstr+'&username='+UserName+'&sDh='+sDh+'&sRealName='+sRealName+'&sBm='+sBm+'&sAddress='+sAddress+'&linkphone='+linkphone+'&linkman='+linkman+'&area='+area,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false,//同步方式
					success:function(msg){
					    if(msg=="true"){
					     //往日志表里插入日志 
					     var params=addairuser();
						 writeLogInfo("","add",params);
					    }
					} 
				});	 	
			}
			
			//
			//
			/////////////////拼参数
			
			 /********************************
			 **通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
			 ************************************/
			 var fee="";			
			 function buildParams(){
				//每次拼接参数必须初始化此参数
				tsd.QualifiedVal=true;
				var params="";
			 	var UserName = $("#TrueUserName").val();   //用户输入的用户名UserName
			 	UserName=UserName.replace(/(^\s*)|(\s*$)/g,"");
			 	UserNameto=UserName;
			 	var pwd1 = $("#Values").val();     //用户密码
			 	pwd1=pwd1.replace(/(^\s*)|(\s*$)/g,"");
			 	var pwd2 = $("#Valuess").val();
			 	pwd2=pwd2.replace(/(^\s*)|(\s*$)/g,"");
			 	var userid = $("#usser_L").val();   //取得当前登录的用户ID
			 	var iSimultaneous = $("#iSimultaneous").val();
			 	iSimultaneous=iSimultaneous.replace(/(^\s*)|(\s*$)/g,"");
			 	var speed = $("#ispeed").val();
			 	speed=speed.replace(/(^\s*)|(\s*$)/g,"");
			 	var zafei = $("#zafei").val();  //杂费是哪些项
			 	var ipaddr = $("#ipaddr").val();
			 	ipaddr=ipaddr.replace(/(^\s*)|(\s*$)/g,"");
			 	if(ipaddr!=null&&ipaddr!=""){
				var ree=/^\ {0,}(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$\ {0,}/;				
				if(!ree.test(ipaddr)&&ipaddr.length!=0){
				//绑定IP不合法，请重新输入！
			    alert("<fmt:message key="gjh.bdIPbhf"/>");
			    $("#ipaddr").select();
			 	$("#ipaddr").focus();
			    return false;
			      }
			    }
			 	var vlanid = $("#vlanid").val();
			 	vlanid=vlanid.replace(/(^\s*)|(\s*$)/g,"");
			    var sRealName = $("#sRealName").val();
			 	if(sRealName.length==0){
			 	alert('<fmt:message key="AddUser.namenotnull"/>');
			 	$("#sRealName").select();
			 	$("#sRealName").focus();
			 	return false;
			 	}
			 	//var rname=/[^\u4E00-\u9FA5]/; 
			 	var sDh = $("#sDh").val();
			 	if(sDh!=null&&sDh!=""){
			 	sDh=sDh.replace(/(^\s*)|(\s*$)/g,"");
			 	 var reb =/^\ {0,}[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+\ {0,}$/;
				     if(!reb.test(sDh)){
				     //联系电话不合法，请重新输入！
					    alert('<fmt:message key="AddUser.phonenothefa"/>');
					    return false;
					 } 
				}
				
				var sBm = $("select[id='sBm'] :selected").html();
			 	var sBm2 = $("select[id='sBm2'] :selected").html();
			 	var sBm3 = $("select[id='sBm3'] :selected").html();
			 	var sBm4 = $("select[id='sBm4'] :selected").html();
			 	 
			 	var seluserarea = $("select[id='seluserarea'] :selected").html();
			 	var selectuserarea = $("#seluserarea").val();
			 	if(selectuserarea==""){alert("<fmt:message key="broadband.selectarea"/>");$("#seluserarea").focus();return false;}
			 	var sAddress = $("#sAddress").val();
			 	if(sAddress.length==0){alert("<fmt:message key="AddUser.mustInputAddress" />");$("#sAddress").select();$("#sAddress").focus();return false;}
			 	var idtype = $("#UserName1").val();
			 	if(idtype=="100"){alert('<fmt:message key="AddUser.qxzzjlx"/>');$("#UserName1").focus();return false}  
			 	var idcard = $("#UserName2").val();
			 	if(idcard.length==0){alert("<fmt:message key="AddUser.zjnumbernotnull"/>");$("#UserName2").select();$("#UserName2").focus();return false;}
			 	idcard=idcard.replace(/(^\s*)|(\s*$)/g,"");
			 	var rer =/^\ {0,}[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+\ {0,}$/;
					 if(!rer.test(idcard)){
					 //证件号码不合法，请重新输入！
					    alert("<fmt:message key="gjh.zjhmbhf"/>");
					    return false;
					 }
			 	
			 	//var PayType = $("#PayType").val();     //用户类型			 	
			 	var feei = $("#broadbandtotalfee").val();
			 	
			 	 //安装宽带时从表qhyt_bytc_type里获取ys的数据，看是否大于零
			 	 if(sDh!=""&&sDh!=null){
			        var qhytarrayys=new Array('ys');
			        var qhytquery = SQLTool.exeTsdQuery(0,'adduser.qhyt_bytc_typequery','','query','xmlattr','single','',qhytarrayys);
			        var qhytys=qhytquery[qhytarrayys[0]];
			        if(qhytys>0){
			           var yhdangarraybz=new Array('bz10');
			           var hydangquery = SQLTool.exeTsdQuery(0,'adduser.yhdangYS','','query','xmlattr','single','&sDh='+sDh,yhdangarraybz);
			           var yhdangbz=hydangquery[yhdangarraybz[0]];
			           if(yhdangbz!=null){
			              var feei = feei - qhytys;
			              if(feei<0){
			                 feei=0;
			              }
			           }
			         }
			       }
			 	fee=feei;//全局变量等于此数值			 	
			 	//var port = $("#idtype").val();
			 	//port=port.replace(/(^\s*)|(\s*$)/g,"");
			 	//var spostalcode = $("#sDh2").val();
			 	//spostalcode=spostalcode.replace(/(^\s*)|(\s*$)/g,"");
			 	var sMobilePhone = $("#sDh1").val();
			 	sMobilePhone=sMobilePhone.replace(/(^\s*)|(\s*$)/g,"");
			 	//联系电话
			 	var ssDh1 = $("#sDh0").val();
			 	ssDh1=ssDh1.replace(/(^\s*)|(\s*$)/g,"");
			 	if(ssDh1.length==0){
			 	  alert("<fmt:message key="broadband.lxphonenotnull"/>","<fmt:message key="global.operationtips"/>");
			 	  $("#sDh0").select();
			 	  $("#sDh0").focus();
			 	  return false;
			 	}
			 	//联系人
			 	var linkman = $("#linkman").val();
			 	linkman=linkman.replace(/(^\s*)|(\s*$)/g,"");
			 	if(linkman.length==0){
			 	  alert("<fmt:message key="broadband.linkmannotnull"/>","<fmt:message key="global.operationtips"/>");
			 	  $("#linkman").select();
			 	  $("#linkman").focus();
			 	  return false;
			 	}
			 	//用户类型
			 	var usertype = $("select[id='UserType'] option[selected]").val();
			 	if(usertype==""){
			 	  alert("<fmt:message key="AddUser.mustInputUserType" />");
			 	  $("#UserType").focus();
			 	  return false;
			 	}
			 	//用户MAC地址
			 	var smacaddr = $("#smacaddr").val();
			 	//取所有选中的杂费项
			 	
			 	//工号区域
			 	var area = $("#area").val();
			 	
			 	//工号部门
			 	var depart = $("#depart").val();
			 	
			 	//验证密码
			 	if(UserName!=""&&UserName!=null){
			 	    
			 	   //验证帐号不可为中文
			 	   for(i=0;i<document.getElementsByName("UserName")[0].value.length;i++){
                      var c = document.getElementsByName("UserName")[0].value.substr(i,1);
                      var ts = escape(c);
                      if(ts.substring(0,2) == "%u"){
                      document.getElementsByName("UserName")[0].value = "";
                      alert("<fmt:message key="AddUser.zhbnsrzw"/>");
                      return false;
                      }
                    }
			 	    
			 		var pwd1= $("#Values").val();	
				 	var pwd2= $("#Valuess").val();
				 
				 	if(pwd1.length!=0){
				 		if(pwd1!=pwd2){
				 			//jAlert('两次输入密码不一致!','消息提示框');
				 			alert('<fmt:message key="AddUser.PasswordExNot" />');
				 			$("#Valuess").select();
							$("#Valuess").focus();
							return false;
				 		}
					}else{
						alert('<fmt:message key="AddUser.mustInputPassword" />');
				 		//jAlert('请输入开户密码!','消息提示框');
						$("#Values").select();
						$("#Values").focus();
						return false;
				 	}
				 	
				 	//付费类型，如果是小区网用户者为2（公费），如果是外部网用户者为10
				 	var userclass = $("#UserClass").val();
				 	if(userclass=='StreetUser'){
				 	   var PayType='2';
				 	}else{
				 	   var PayType='10';
				 	}
				 	
				 	//付费方式
				 	var payitem = $("#payitem").val();
				 	if(payitem==null){payitem='';}
				 	payitem=payitem.replace(/(^\s*)|(\s*$)/g,"");
				 	var ispay;//是否付费（Y/N）
				 	//根据付费方式来判断是否付费的类型
				 	if(payitem=='cash'){
				 	   ispay='Y';
				 	   $("#transferHTH").val("");
				 	}else if(payitem=='transfer'){
				 	   ispay='N';
				 	}else{
				 	   ispay='';
				 	}				 	
				 	
				 	var zzhth = $("#transferHTH").val();
				 	if(payitem=='transfer'&&zzhth==""){
				 	   alert("<fmt:message key="broadband.zzhthnotnull"/>");
				 	   return false;
				 	}				 	
				 	
				 	var devno = $("#devno").val();//BAS设备
				 	var ifurgent = $("#ifurgent").val();//工单是否紧急				 	
				 	var jobmemo = $("#jobmemo").val();//工单备注
				 	jobmemo = jobmemo.replace(/(^\s*)|(\s*$)/g,'');
				 	if(jobmemo.length=0){alert("请输入装机备注；");return false;};
				 	var hth = $("#hth").val();
				 	var accessmethods = $("#accessmethods").val();
				 	if(accessmethods==""){
				 		alert("请选择接入方式！");
				 		$("#accessmethods").select();
				 		$("#accessmethods").focus();
				 		return false;
				 	}
				 	if(iSimultaneous>1){				 	
				 	params+="&afee="+svalueSimto;//增加多个同时在线数的金额(同时在线数大于1的时候才增加同时在线数金额)
				 	params+="&ameno="+tsd.encodeURIComponent("<fmt:message key="broadband.addtszxs"/>")+iSimultaneous;//增加同时在线数备注
				 	}else{
				 	params+="&afee=";//否则传空
				 	}				 	
				 	params+="&sfee="+youhueije;//带宽提速金额
				 	params+="&smemo="+tsd.encodeURIComponent(memoto);
				 	//var zhfee = fee+youhueije+svalueSimto;
				 	$("#printfeeee").val(fee);
				 	params+="&PayType="+PayType;
				 	params+="&userid="+userid;
				 	params+="&username="+UserName;
				 	params+="&password="+pwd1;				 	
				 	params+="&iSimultaneous="+iSimultaneous;
				 	params+="&idtype="+idtype;
				 	params+="&idcard="+idcard;
				 	params+="&speed="+speed;
			 	 	//杂费类型
			 	 	queryFeeInfo();
			 	 	    if(zffeenameto!=undefined){
			 	 	    
			 	 	    //当checkbox的name值一样的话来区分checkbox那个是否选中状态
			 	 	    var checkedBox = "";
						$("input[type='checkbox'][name='checkbox'][checked]").each(function(i,n){
							checkedBox += $(n).val();
						});
						//是否可以不选
						if(checkedBox=="" && $("input[type='checkbox'][name='checkbox']").size()>0)
						{
							if($("#ableForNoChoose").val()=="false")
							{
								alert("<fmt:message key="broadband.qxzzsyxycxfy"/>");
								return false;
							}
							else if($("#ableForNoChoose").val()=="true")
							{
								if(confirm("<fmt:message key="broadband.sfqrbxycxfy"/>"))
								{
									//确认不选
								}
								else
								{
									//
									return false;
								}
							}
						}
						
			 			params+="&feename="+zffeenameto;
			 		}		
			 		
			 		var sItemDom = $("input[type='checkbox'][name='checkbox'][checked]");
    			var sitem_tmp = "";
    			if($(sItemDom).size()>1)
    			{
    				for(var ii=0;ii<sItemDom.size();ii++)
    				{
    					sitem_tmp += $(sItemDom[ii]).attr("scval");
    					sitem_tmp += ","
    				}
    				sitem_tmp = sitem_tmp.substring(0,sitem_tmp.length-1);
    				sitem_tmp = "当前已选取多个费用项：" + sitem_tmp + "，是否确认？";
    				if(confirm(sitem_tmp))
    				{
    					//确定要多选
    				}
    				else
    				{
    					return false;
    				}
    			}	 		
					
			 		params+="&sDh="+tsd.encodeURIComponent(sDh);
			 		
			 		if(ifeecodeto!=""){
			 			params+="&iFeeType="+tsd.encodeURIComponent(ifeecodeto);//没提速前的计费规则
			 			var param=getitype(ifeecodeto);
			 			if(param=='1'){
			 			   if(iSimultaneous>1||memoto.length!=0){
			 			   alert("<fmt:message key="broadband.jsgzbnblxyw"/>");
			 			   iSimultaneous="";
			 			   memoto="";
			 			   return false;
			 			   }
			 			 }
			 		 }else{
			 			alert('<fmt:message key="AddUser.mustInputFeeType" />');
			 			//jAlert("请选择计费规则!","消息提示框");
			 			return false;
			 		 }
	 		
			 			params+="&ipaddr="+tsd.encodeURIComponent(ipaddr); 		
			 			params+="&vlanid="+tsd.encodeURIComponent(vlanid);	
			 			params+="&sRealName="+tsd.encodeURIComponent(sRealName);		
			 			params+="&sBm="+tsd.encodeURIComponent(sBm);
			 			params+="&sBm2="+tsd.encodeURIComponent(sBm2);
			 			params+="&sBm3="+tsd.encodeURIComponent(sBm3);
			 			params+="&sBm4="+tsd.encodeURIComponent(sBm4);
			 			params+="&userarea="+tsd.encodeURIComponent(seluserarea);			 		
			 			params+="&sAddress="+tsd.encodeURIComponent(sAddress);	 				 		
			 			params+="&sMobilePhone="+tsd.encodeURIComponent(sMobilePhone);
			 			//params+="&spostalcode="+tsd.encodeURIComponent(spostalcode);
			 		
			 			//params+="&port="+tsd.encodeURIComponent(port);			 		
			 			params+="&idcard="+tsd.encodeURIComponent(idcard);			 		
				 		params+="&fee="+tsd.encodeURIComponent(feei);				 		
				 		params+="&linkphone="+tsd.encodeURIComponent(ssDh1);
				 		params+="&linkman="+tsd.encodeURIComponent(linkman);
				 		params+="&usertype="+tsd.encodeURIComponent(usertype);
				 		params+="&smacaddr="+tsd.encodeURIComponent(smacaddr);
				 		params+="&area="+tsd.encodeURIComponent(area);
				 		params+="&depart="+tsd.encodeURIComponent(depart);
				 		params+="&ifurgent="+tsd.encodeURIComponent(ifurgent);
				 		params+="&devno="+tsd.encodeURIComponent(devno);
				 		params+="&paymode="+tsd.encodeURIComponent(payitem);
				 		params+="&ispay="+tsd.encodeURIComponent(ispay);
				 		params+="&hth="+tsd.encodeURIComponent(zzhth);
				 		params+="&descrpt="+tsd.encodeURIComponent(jobmemo);
				 		params+="&bmhth="+tsd.encodeURIComponent(hth);
				 		params+="&linkinmode="+tsd.encodeURIComponent(accessmethods);
						//每次拼接参数必须添加此判断
						if(tsd.Qualified()==false){return false;}
						return params;
				 	
				}else{
			 		isExist();
			 	}
			 }
			 function print(UserName){
			 	
			 	var params='UserName='+tsd.encodeURIComponent(UserName);
  		  	    window.open ('printAdduser.jsp?'+params) ;
			 }
			 
			 //根据计费代码或的计费分类
			 function getitype(ifeecodeto){
			    var itype;
			    var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'tbl_IspList.totoquery'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});						
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&FeeCode='+ifeecodeto,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					                $(xml).find('row').each(function(){	
					                itype = $(this).attr("itype");
							        });
							      }
							});
				  return itype;			
			 }
			 
			 //后来新增的
			 //选择用户类别后执行的函数
			 //定义个全局变量保存当前选中的项
			 //-------------------------------------
			 var selectUserType='StreetUser';
			 function UserClassChange(selectedValue)
			 {
			   $("#TrueUserName").val("");   //用户输入的用户名UserName
			   $("#Values").val("");     //用户密码
			   $("#Valuess").val("");
			   $("#iSimultaneous").val("");   
			 	$("#speed").val("");
			 	$("#zafei").val("");  //杂费是哪些项		 	
			 	$("#sDh").val("");
			 	$("#PayType").val("");     //用户类型
			 	$("#ipaddr").val("");
			 	$("#vlanid").val("");
			 	$("#sRealName").val("");
			 	$("#sBm").val("");
			 	$("#sAddress").val("");
			 	$("#UserName1").val("");   
			 	$("#UserName2").val("");
			    $("#idtype").val("");
			 	$("#sDh2").val("");
			 	$("#sDh1").val("");
			 	//联系电话
			 	$("#sDh0").val("");
			 	$("#telphoneB").val("");
			 	//联系人
			 	$("#linkman").val("");
			 	//清空计费规则和check的选中状态
			    $(":radio[name='feetype']").removeAttr("checked");
			 
			 	//selectedValue 有两种情况 StreetUser小区网用户(用户检测) WWWUser 外网用户(获取空帐号)
			 	//第一次打开应该是StreetUser
			 	if(selectedValue!=selectUserType)
			 	{
			 		$("#UserName").val("");
			 	}
			 	if(selectedValue=='StreetUser')
			 	{		
			 	    $("#UserName").removeAttr("disabled");
			 		GlobalUserClass=0;
			 		//$("#submitButton").html("帐号检测");
			 		$("#submitButton").html('<fmt:message key="AddUser.AccountDetection" />');
			 		selectUserType='StreetUser';
			 		$("select[id='PayType']").empty();
			 		//$("select[id='PayType']").html('<option value="100">'+<fmt:message key="AddUser.PleaseSelect" />+'</option><option value="0">'+免费'+</option><option value="1">后付</option><option value="2">预付</option>');
			 		$("select[id='PayType']").html('<option value="100">'+'<fmt:message key="AddUser.PleaseSelect" />'+
			 		'</option><option value="0">'+'<fmt:message key="AddUser.Free" />'+
			 		'</option><option value="1">'+'<fmt:message key="AddUser.Postpaid" />'+
			 		'</option><option value="2">'+'<fmt:message key="AddUser.Prepaid" />'+'</option>');
			 		
			 		//alert($("select[id='PayType']").html());
			 	}
			 	else
			 	{
			 	    $("#UserName").attr("disabled","disabled");
			 		GlobalUserClass=1;
			 		//$("#submitButton").html("获取空帐号"); AddUser.getEmptyAccount
			 		$("#submitButton").html('<fmt:message key="AddUser.getEmptyAccount" />');
			 		selectUserType='WWWUser';
			 		$("select[id='PayType']").empty();
			 		//$("select[id='PayType']").html('<option value="100">'+'<fmt:message key="AddUser.PleaseSelect" />'+'</option><option value="10">外网用户</option>');
			 		$("select[id='PayType']").html('<option value="100">'+'<fmt:message key="AddUser.PleaseSelect" />'+
			 		'</option><option value="10">'+'<fmt:message key="AddUser.ExternalUser" />'+'</option>');
			 	}
			 }
			 
			 
			
			 //grid相关
			 jQuery(document).ready(function () {
				/////设置命令参数
				 var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'adduser.queryEmptyAccount',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'adduser.queryEmptyAccountPage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});
											
			   jQuery("#editgrid").jqGrid({
				//url:'mainServlet.html?'+urlstr+'&sarea='+tsd.encodeURIComponent(GlobalUserArea)+'&UserNamePre=b',
				//url:"mainServlet.html?"+urlstr+"&sarea=a&UserNamePre=b",
				datatype: 'xml', 
				colNames:[GridFieldName,'<fmt:message key="global.operation" />'],  
				colModel:[ {name:'id',index:'account', width:170},
				{name:'viewOperation',index:'viewOperation',sortable:false}], 
				       	rowNum:5, //默认分页行数
				       	rowList:[5,10], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'account', //默认排序字段
				       	viewrecords: true, 
				       	hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式  
				       	height:210, //高
				       	width:289,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										addRowOperBtn('editgrid','<fmt:message key="AddUser.Select" />','openRowModify','id','click',1);
										executeAddBtn('editgrid',1);
										},
						ondblClickRow:function(rowid)
						{
							//用户选择某一行时
							//此时仅针对IE
							var UserName='';
							
							if($.browser.msie){
								UserName=document.getElementById('editgrid').rows[rowid].cells[0].innerText;
							} 
							if($.browser.mozilla)
							{   
								UserName=document.getElementById('editgrid').rows[rowid].cells[0].textContent;
							}
							$("#UserName").attr("value",UserName);
							$("#TrueUserName").val(UserName);
							setTimeout($.unblockUI,15);
							//可以取号时设置下面东西可读
							GlobalBroadbandIsRead=true;
							setBroadbandIsRead();
						}
				}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
			
			
			///////根据用户类型来显示计费类型信息
			var loadTime=0;
			//取得当前body的宽度
			var bodyWidth = $("body").width()*0.9;		
			var languageType = $("#languageType").val();
			var strr1 = getI18n(languageType,'tbl_IspList');
			var strarr1 = strr1.split(",");		
				
			jQuery("#feetypeeditgrid").jqGrid({
				//url:'mainServlet.html?'+urlstr+'&usertype='+usertype, 
				datatype: 'xml', 
				colNames:['id','计费代码','计费名称','金额'],
				//colNames:title, 
			    colModel:[ 
			    		   {name:'id',index:'id',hidden:true,width:0},
			    		   {name:'FeeCode',index:'FeeCode',width:bodyWidth*0.2}, 
				           {name:'FeeName',index:'FeeName',width:bodyWidth*0.5},
				           {name:'BaseFee',index:'BaseFee',hidden:true,width:0},
				       	], 
				       	rowNum:10, //默认分页行数
				       	//rowList:[10,15,20], //可选分页行数
				        imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager:jQuery('#feetypepagered'), 
				       	sortname:'FeeCode', //默认排序字段
				       	viewrecords:true, 
				       	//hidegrid: false, 
				       	sortorder:'asc',//默认排序方式  
				      	//multiselect: true,
				       	height:115, //高
				       	width:$("body").width()*0.3,
						loadComplete:function(){
											//alert($("body").width());
											$("table[class='Header']").remove();
											$("#feetypepagered select").css("display","none");
											//$("#feetypepagered input").css("width","20px");
											$("#feetypelist #lui_feetypeeditgrid").remove();
											if(loadTime==0)
											{
												$("#feetypelist table tr:first th:first").before('<th style="width: 28px;"><span style="cursor: default;">&nbsp;</span><div id="jqgh_cb"><fmt:message key="global.operation" /></div></th>');
												$("#feetypelist #feetypeeditgrid tr:first td:first").before('<td style="width: 25px; height: 0px;"></td>');
											}
											loadTime++;
											$("#feetypelist #feetypeeditgrid tr").each(function(j)
											{
												if(j!=0)
												{    
													$(this).find("td:first").before('<td><input id="jqg_'+j+'" class="cbox1" type="radio" name="feetype" style="width:15px;height:15px;" onclick="javascript:GlobalFeeTypeIsCheck=true;setspeed('+j+')"/></td>');
												}
											});
											$("#feetypelist .GridHeader").remove();
											//根据当前是否可读来设置Radio是否可操作
											setBroadbandIsRead();
											 var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
											 setAutoGridHeight("editgrid",reduceHeight);
											},
						ondblClickRow:function(rowid){
											var id ;
						}
				});
			$("#feetypelist").wrap("<form action='#' ></form>");
			
			//带宽提速计费规则显示表格
			//alert('mainServlet.html?'+urlstr+"&basefee="+baseFeeto);	 					
			jQuery("#feetypeeditgrid1").jqGrid({
				//url:'mainServlet.html?'+urlstr+"&basefee="+baseFeeto, 
				datatype: 'xml', 
				colNames:['id','计费代码','带宽提速计费规则','金额','带宽','BAS设备'],
				//colNames:title, 
			    colModel:[ 
			    		   {name:'id',index:'id',hidden:true,width:0},
			    		   {name:'FeeCode',index:'FeeCode',hidden:true,width:0},
			    		   {name:'FeeName',index:'FeeName',width:bodyWidth*0.5},
				           {name:'BaseFee',index:'BaseFee',hidden:true,width:0},
				           {name:'speed',index:'speed',hidden:true,width:0},
				           {name:'speed_iag',index:'speed_iag',hidden:true,width:0}
				       	], 
				        rowNum:10, //默认分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered1'), 
				       	sortname: 'FeeCode', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:'', 
				       	height:115, //高
				       	width:200,
				       	//multiboxonly:true,
				       	//multiselect:true,
				       	//multikey:'shiftKey',
				       	//ondblClickRow,			       	
				       	ondblClickRow:function(ids){  	        
            		        	var addiFeeType = $("#feetypeeditgrid1").getRowData(ids).FeeName;
            		        	var basefee = $("#feetypeeditgrid1").getRowData(ids).BaseFee;
            		        	var iifeecode = $("#feetypeeditgrid1").getRowData(ids).FeeCode;
            		        	var ispeed = $("#feetypeeditgrid1").getRowData(ids).speed;
            		        	var speed_iag = $("#feetypeeditgrid1").getRowData(ids).speed_iag;
            		        	addiFeeTypeto(addiFeeType,basefee,iifeecode,ispeed,speed_iag);            		        	
            		    }           		    
				});	
			});
		
		//grid中选择按钮的事件
		function openRowModify(id)
		{   
			$("#UserName").attr("value",id);
			$("#TrueUserName").val(id);
			setTimeout($.unblockUI,15);
			GlobalBroadbandIsRead=true;
			setBroadbandIsRead();
			
		}
		
		//查询电话用户状态
		function querysDh(){
		    var result;
		    var telphone = $("#telphoneB").val();
		    var urlstr=tsd.buildParams({ packgname:'service',
									  clsname:'Procedure',
									  method:'exequery',
									  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
									  tsdpname:'adduser.getTelUserType',//存储过程的映射名称
									  tsdExeType:'query',
									  datatype:'xmlattr',
									  tsdUserId:'true'
						 			});		 					
			$.ajax({
					url:'mainServlet.html?'+urlstr+"&tel="+telphone,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){						
						$(xml).find('row').each(function(){
						     result = $(this).attr("usertype");
						})
					}
			 });
			 return result;			
		}
		
		//电话在可输入状态下改变后判断
		function sDhCheck()
		{   
			var telphone = $("#telphoneB").val();
			if(telphone=="")
			{
				alert("<fmt:message key="AddUser.mustInputPhone" />");
				//jAlert("请输入电话号码！","提示");
				$("#telphoneB").select();
				$("#telphoneB").focus();
				return;
			}
			var shownemae = 'adduser.getTelUserType';
			//根据输入电话从电弧档案表里提取该电话信息（提取的信息没有办公电话的）
			var urlstr=tsd.buildParams({packgname:'service',
									    clsname:'Procedure',
									    method:'exequery',
									    ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
									    tsdpname:shownemae,//存储过程的映射名称
									    tsdExeType:'query',
									    datatype:'xmlattr',
									    tsdUserId:'true'
						 			});
				$.ajax({
						url:'mainServlet.html?'+urlstr+"&tel="+telphone+"&business="+'setup',
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
							     var res = $(this).attr("res");
							     var usertype = $(this).attr("usertype");
							     var tag = $(this).attr("tag");
							     if(res=='SUCCEED'){
							        //查询该电话是否在radcheck表里，如果子就提示用户此电话已经和宽带绑定，不能再次绑定！并清空电话信息
								    var radcheckquery=SQLTool.exeTsdQuery(1,'adduser.radcheckquerysDh','','query','xmlattr','single','&sDh='+telphone,['result']);
									    if(radcheckquery['result']!=0){
									         alert("<fmt:message key="AddUser.phonebdband"/>");
										     $("#telphoneB").val("");
										     $("#telphoneB").select();
											 $("#telphoneB").focus();
											 resutnull();
										     return false;
									    }
							        var dh = $(this).attr("dh");
							        var yhmc = $(this).attr("yhmc");
							        var yhdz = $(this).attr("yhdz");
							        var bz6 = $(this).attr("bz6");
							        var bz7 = $(this).attr("bz7");							    
							        var bm1 = $(this).attr("bm1");							        
							        var bm2 = $(this).attr("bm2");							     
							        var bm3 = $(this).attr("bm3");
							        var bm4 = $(this).attr("bm4");							        
							        if(confirm("<fmt:message key="broadband.cdhkysfbdh"/>["+telphone+"]<fmt:message key="broadband.zwgzhddhxx"/>","操作提示")){
							            yijisBm();					          
										$('#sDh').val(dh);
										$('#sRealName').val(yhmc);	
										$("#sBm").val(bm1);
										$("#sBm2").val(bm2);
										$("#sBm3").val(bm3);
										$("#sBm4").val(bm4);			
										$("#sAddress").val(yhdz);
										$("#UserName1").val(bz6);
										$("#UserName2").val(bz7);										
							            //选择电话后查看是否选择用户帐号，如果没选择将光标移到帐号检测那里
										var UserNameto = $("#UserName").val();
										if(UserNameto.length==0){
										   $("#UserName").select();
										   $("#UserName").focus();
										}
										disabledget();
								     }else{
									  resutnull();
									  $("#telphoneB").select();
									  $("#telphoneB").focus();
									 }							        
							     }else{
							        var getpro=getProcedures(shownemae);
							        //params:存储过程名，paramss:返回标识,byparm：被替换的字符串变量,parmto：要替换的字符串变量
							        var languageType = $("#languageType").val();
				                    var getee = getretdescript(getpro,tag,'[FusertypeF]',usertype,languageType);
				                    getee=getee.replace('[?dh?]',telphone);				                    
				                    alert(getee);//提示信息
							        resutnull();
									$("#telphoneB").select();
									$("#telphoneB").focus();
									return false;
							     }
							})
						}
				 });
				 shownemae="";    			   							
		}
		
		 //通过存储过程展现名称得到存储过程名
	 	  function getProcedures(shownemae){
	 	       var result;
	 	       var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'backstore.getProcedures'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});						
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&getsprooname='+shownemae,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					                 $(xml).find('row').each(function(){
					                    result = $(this).attr("sproname");					                    					                    				    
							         });
							      }
							});
				return result;			
	 	  }
		
		
		//清空checkbox的选中状态
		function clearCheckbox()
		{
		     
			//alert($("#zafeilist").find("input"));
			$("#zafeilist").find("input").each(function()
				{
					if($(this).attr("checked")==true)
					{
						$(this).attr("checked","");
					}
				});
			$("#broadbandtotalfee").val(0);			
		}		
		
		//清空所有信息，也就是重置
		function isClear()
		{
			clearText('form1');
			clearText('BasicUserInfo');
			//clearText('radiusinfo');	
		}
		
		//判断如果用户没有选择证件类型的话就让证件号码只读
		function idcardChange(value)
		{
			//this.options[this.options.selectedIndex].value
			//100为默认的请选择的value
			if(value!=100)
			{
				$("input[id='UserName2']").attr("readonly","");
			}
			else
			{
				$("input[id='UserName2']").attr("readonly","readonly");
			}
		}
		
		//计费规则grid
		function getfeetype(usertype)
        {
	        //$("#feetypeeditgrid").remove();
	        //$("#feetypepagered").empty();
	   	    //计费规则列表
	   		var urlstr=tsd.buildParams({ packgname:'service',//java包
							 			 clsname:'ExecuteSql',//类名
							 			 method:'exeSqlData',//方法名
							 			 ds:'broadband',
							 			 tsdcf:'mysql',//指向配置文件名称
							 			 tsdoper:'query',//操作类型 
							 			 datatype:'xml',//返回数据格式 
							 			 tsdpk:'adduser.feetypeQuery',
							 			 tsdpkpagesql:'adduser.feetypeQueryPage'
							 		 });
										 		 
	   		$("#feetypeeditgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&usertype='+usertype}).trigger("reloadGrid"); 
	   }
		
		//根据地址模块窗口传过来的值赋给地址栏并关闭地址栏选择窗口
		 function addnewinfo(){
				var groupid = $('#zid').val();
				//window.showModalDialog('mainServlet.html?pagename=line/addressManage.jsp&imenuid=1085&pmenuname=号线管理 &imenuname=地址库管理 &groupid='+groupid,window,"dialogWidth:820px; dialogHeight:650px; center:yes; scroll:yes");
				var ret = window.showModalDialog('mainServlet.html?pagename=telephone/linemanagement/addressManage.jsp&imenuid=1085&pmenuname=号线管理&imenuname=地址库管理&yemiantype=addusertype&groupid='+groupid+"435435",null,"dialogWidth:820px;dialogHeight:650px;help:no;status:no");							
				if(ret!=undefined){
				   $("#sAddress").val(ret);
				   $("#c_p_address").hide('slow');
				   //恢复显示
				   $("#UserName1").css("display","block");
				}
		 }
		 	 
	     //带宽转换（将数字转换成M数）
	     function speedConversion(params){
	         var speed = (parseInt(params,10)/1024000)+'M';
	         return speed;
	     }
    </script>

	<!-- 从地址库里得到地址选项卡 -->
	<script language="javascript">	
	
     /////地址选择
	function c_p_address()
	{
		var ctrr = $("#sAddress");
		$(ctrr).focus(function(){c_p_address_fun();});
	}
	
	/////地址选择
	function c_p_address_fun()
	{
		
		if($("#c_p_address").size()<1)
		{
			$("#sAddress").after("<div id=\"c_p_address\"></div>");
		}
		var left = $("#sAddress").offset().left - $("#sAddress").parent().prev().width()-200;
		var top = $("#sAddress").offset().top + 20;
		//alert($("#sAddress").parent().offset().left);
		$("#c_p_address").css({'position':'absolute','left':left,'top':top,'background-color':'#FFFFFF','border':'#99ccff 1px solid','height':'112px','width':'750px'});
		$("#c_p_address").empty();
		var address_tab="<table id=\"address_tab\" style=\"\">";
		address_tab += "<tr><td colspan=\"6\"><h4>添加地址</h4></td></tr>";
		address_tab += "<tr><td>小区号</td><td><select id=\"c_p_address_xq\"><option value=\"\">--请选择--</option></select></td><td>楼栋号</td><td><select id=\"c_p_address_ld\"><option value=\"\">--请选择--</option></select></td><td>单元号</td><td><select id=\"c_p_address_dy\"><option value=\"\">--请选择--</option></select></td><td>门牌号</td><td><select id=\"c_p_address_mp\"><option value=\"\">--请选择--</option></select></td></tr>";
		address_tab += "<tr><td><button id=\"c_p_address_bnok\" class=\"tsdbutton\">确定</button></td><td colspan='2'><button id=\"c_p_address_add\" onclick=\"addnewinfo()\" class=\"tsdbutton\" disabled=\"disabled\">添加新地址</button></td><td><button id=\"c_p_address_bncancel\" class=\"tsdbutton\">取消</button></td><td></td><td></td><td></td><td></td></tr>";
		address_tab += "</table>";
		$("#c_p_address").append(address_tab);
		var cpad = $("#c_p_address_addright").val();
		if(cpad=="true"){
		  $("#c_p_address_add").removeAttr("disabled");			  	  
		}
		c_p_bindToAddr(1,"c_p_address_xq","");
		//隐藏证件类型下拉框
		$("#UserName1").css("display","none");		
		//获得焦点时显示
		$("#c_p_address").show('slow');
		
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
				alert("请继续选择下一级地址","<fmt:message key="global.operationtips"/>");
			}
			else
			{
				info = info.replace(new RegExp(",","g"),"");
				if(checkAddress(info))
				{
					alert("地址 " + info + " 已经被用户"+addressusername+"占用，不能重复添加");
					addressusername="";
					return false;
				}
				$("#sAddress").val(info);
				$("#c_p_address").hide('slow');
				//恢复显示
				$("#UserName1").css("display","block");
			}
			//alert($("select[id^='c_p_address']").size());
		});
		
		$("#c_p_address_bncancel").click(function(){
			$("#c_p_address").hide('slow');
			//恢复显示
			$("#UserName1").css("display","block");
		});
	}
	
	var resto="";
	function c_p_bindToAddr(idx,selid,param)
	{
		    var seluserarea = $("select[id='seluserarea'] :selected").html();
			var res = fetchMultiArrayValue("AddressBox.query"+idx,6,param+"&addrarea="+tsd.encodeURIComponent(seluserarea));
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
			
			var addressusername="";
			function checkAddress(addr)
        	{
        	    var addrto = $("#c_p_address_mp").val();
        	    var userareaadress = $("#userareaid").val();
        	    if(addrto!=null&&addrto!=""){
				var res = fetchSingleValue("Address.Check",0,"&sAddress="+tsd.encodeURIComponent(addr)+"&userarea="+tsd.encodeURIComponent(userareaadress));
					 if(res==undefined||res=='0')
					{
						return false;
					}
					else
					{	
						addressusername=res;					
						return true;
					}
				}				
        	}
        	
        //锁定账号 true可办理 false 不可办理
		function kdLock(UserName)
		{
			var rel = fetchSingleValue("processingdistory.queryuseridname",6,"&userid="+$("#userid").val());
			var res = fetchMultiPValue("kd.Lock",0,"&userid="+$("#userid").val()+"&account="+UserName+"&businesstype=setup&flag=in"+"&realname="+tsd.encodeURIComponent(rel));
			if(res[0]==undefined||res[0][0]==undefined||res[0][0]=="")
			{
				return true;
			}
			else
			{
				var info = "";
				info += "账号";
				info += UserName;
				info += "正被";
				info += res[0][0];
				info += "受理，请稍等...";
				alert(info);
				return false;
			}
		}
		//解锁账号
		function kdunLock()
		{
			var res = fetchMultiPValue("kd.Lock",0,"&userid="+$("#userid").val()+"&flag=out");
		}	
    </script>

		<!-- 从部门库里得到一级，二级，三级，四级部门 -->
		<script language="javascript">
      function yijisBm(){
      //得到部门库中的第一级部门
            var sBM="";
            var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.addsBm1'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});									
			                $.ajax({
					              url:'mainServlet.html?'+urlstr,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              sBM="";				              
					              $(xml).find('row').each(function(){
					              var DeptName = $(this).attr("deptname");
					              var DeptCode = $(this).attr("deptcode");
							      var ee="<option value='"+DeptCode+"'>"+DeptName+"</option>";								  
								  sBM = sBM +ee;
							      });
							      $("#sBm").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
							      $("#sBm").html($("#sBm").html()+sBM);
							      }
							});		
        }
        
        							
		//得到部门库第二级部门
        function addsBmer(){          
          var sBm = $("#sBm").val();
          getsbmhth(sBm);//根据部门一得到该部门的合同号
          //为空时SQL语句替换会出错
          if (sBm=="")
          {
        	$("#sBm2").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
        	return false;
          }
          $("#sBm3").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
          $("#sBm4").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
        //alert(sBm);
          var sBM="";
          var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.addsBm2'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&sjbmbh='+sBm,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              sBM="";						      
					                $(xml).find('row').each(function(){
					                  var DeptCode = $(this).attr("deptcode");
					                  var DeptName = $(this).attr("deptname");
					                  if(DeptName!=undefined){
							            var ee="<option value='"+DeptCode+"'>"+DeptName+"</option>";
							            sBM = sBM+ee;								        
								      }
								    });
								    $("#sBm2").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
								    $("#sBm2").html($("#sBm2").html()+sBM);
							      }
							   });
        }	 
        //得到部门库第三级部门
        function addsBmsan(){
          var sBm2 = $("#sBm2").val();
          //为空时SQL语句替换会出错
          if (sBm2=="")
          {
        	$("#sBm3").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
        	return false;
          }        
          $("#sBm4").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
          var sBm="";
          var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.addsBm3'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&sjbmbh='+sBm2,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){
					              sBm="";					       
					                $(xml).find('row').each(function(){	
					                  var DeptCode = $(this).attr("deptcode");
					                  var DeptName = $(this).attr("deptname");
					                  if(DeptName!=undefined){
							            var ee="<option value='"+DeptCode+"'>"+DeptName+"</option>";
							            sBm=sBm+ee;								        
								      }
							        });
							        $("#sBm3").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
							        $("#sBm3").html($("#sBm3").html()+sBm);
							      }
							});
        }	 
         //得到部门库第四级部门
        function addsBmsi(){
          var sBm3 = $("#sBm3").val();
         //为空时SQL语句替换会出错
          if (sBm3=="")
          {
        	$("#sBm4").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
        	return false;
          }
          var sBm="";
          var urlstr=tsd.buildParams({packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.addsBm4'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});										
			                $.ajax({
					              url:'mainServlet.html?'+urlstr+'&sjbmbh='+sBm3,
					              datatype:'xml',
					              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					              timeout: 1000,
					              async: false ,//同步方式
					              success:function(xml){	
					              sBm="";				       
					                $(xml).find('row').each(function(){	
					                  var DeptCode = $(this).attr("deptcode");
					                  var DeptName = $(this).attr("deptname");
					                  if(DeptName!=undefined){
							            var ee="<option value='"+DeptCode+"'>"+DeptName+"</option>";
							            sBm=sBm+ee;								       
								      }
							        });
							        $("#sBm4").html("<option value='' selected=true><fmt:message key="gjh.select"/></option>");
							        $("#sBm4").html($("#sBm4").html()+sBm);
							      }
							});
        }	
        
        //选择用户所在区域
        var uareato="";
        function getuserareato(){
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
					              $("#seluserarea").empty();			       
					                $(xml).find('row').each(function(){	
					                  var xuhao = $(this).attr("xuhao");
					                  var ywarea = $(this).attr("ywarea");
					                  if(ywarea!=undefined){
							            var ee="<option value='"+xuhao+"'>"+ywarea+"</option>";
							            uareato=uareato+ee;								       
								      }
							        });	
							        $("#seluserarea").html("<option value='' selected=true>--<fmt:message key="gjh.select"/>--</option>");					       						        
							        $("#seluserarea").html($("#seluserarea").html()+uareato);							       
							      }
							});
        }
        
        //后退事件
        function backwin(){
          history.back();
        } 
        //清空表单
        function clernull(){
                $("#TrueUserName").val("");
                $("#UserName").val("");
			 	$("#Values").val("");     //用户密码
			 	$("#Valuess").val("");
			 	$("#iSimultaneous").empty();
			 	$("#speed").val("");
			 	$("#zafeilist").attr("disabled","disabled");  //杂费是哪些项		 	
			 	$("#sDh").val("");
			 	$("#sAddress").val("");
			 	$("#UserName2").val("");
			 	$("#PayType").empty();     //用户类型
			 	$("#UserType").empty();
			 	$("#ipaddr").attr("disabled","disabled");
			 	$("#vlanid").val("");
			 	$("#sRealName").val("");
			 	$("#broadbandtotalfee").val(0);
			 	$("#idtype").val("");
			 	$("#sDh2").val("");
			 	$("#sDh1").val("");
			 	$("#sDh0").val("");
			 	$("#linkman").val("");
			 	$("select[id='UserType'] option[selected]").val("私费用户");
			 	$("#macautoband").val("未锁定");
			 	$(":radio[name='feetype']").removeAttr("checked");
			 	$("#sBm").empty();
			 	$("#sBm2").empty();
			 	$("#sBm3").empty();
			 	$("#sBm4").empty();
			 	$("#smacaddr").val('');
			 	$("#telphoneB").val("");
			 	$("#feetypeeditgrid1").val("");
			 	$("#ispeed").val("");
			 	$("#tishispeed").empty();
			 	$("#seluserarea").empty();
			 	$("#iSimultaneous").empty();
			 	$("#ifurgent").empty;
			 	$("#jobmemo").val("");
			 	$("#UserName1").val('7');
			 	ifeecodeto="";
			 	youhueije="";
			 	memoto="";
			 	zffeenameto="";
			 	svalueSimto="";			 	
    	        $("#ifurgent").empty();
			 	//清空表单时，清空提示计费规则信息;
			 	baseFeeto=100000;
			 	addSpeed();	
			 	kdunLock();//解锁用户	
			 	$("#jobmemo").attr("disabled","disabled");		 	
			 	$("#devno").empty();
			 	$("#payitem").empty();
			 	$("#transferHTHbox").attr("checked","");
                $("#transferHTH").val("");
			 	getIFeeType();
			 	$("#hth").val("");
			 	$("#accessmethods").empty();
			 	getfeetype("''");
			 	$("#ipaddr").val("");
        }
        
        
        //判断基本信息是否为空，如果不为空就将显示为只读，为空可操作
        function disabledget(){
		  var sRealName = $("#sRealName").val();
		  if(sRealName.length==0){
		    $("#sRealName").removeAttr("disabled");
		  }else{
		    $("#sRealName").attr("disabled","disabled");
		  }
		  var sAddress = $("#sAddress").val();
		  if(sAddress.length==0){
		     $("#sAddress").removeAttr("disabled");
		  }else{
		     $("#sAddress").attr("disabled","disabled");
		  }
		  var sBm = $("#sBm").val;
		  if(sBm==""){
		    //$("#sBm").removeAttr("disabled");
		  }else{
		    //$("#sBm").attr("disabled","disabled");
		  }
		  var linkman = $("#linkman").val();
		  if(linkman.length==0){
		    $("#linkman").removeAttr("disabled");
		  }else{
		    $("#linkman").attr("disabled","disabled");
		  }
		  var UserName1 = $("#UserName1").val();
		  /*
		  if(UserName1==100){
		    $("#UserName1").removeAttr("disabled");
		  }else{
		    $("#UserName1").attr("disabled","disabled");
		  }*/
		  $("#UserName1").removeAttr("disabled");
		  var UserName2 = $("#UserName2").val();
		  if(UserName2.length==0){
		    $("#UserName2").removeAttr("disabled");
		  }else{
		    $("#UserName2").attr("disabled","disabled");
		  }
		  var sDh1 = $("#sDh1").val();
		  if(sDh1.length==0){
		    $("#sDh1").removeAttr("disabled");
		  }else{
		    $("#sDh1").attr("disabled","disabled");
		  }
		  var sdh0 = $("#sDh0").val();
		  if(sdh0.length==0){
		    $("#sDh0").removeAttr("disabled");
		  }else{
		    $("#sdh0").attr("disabled","disabled");
		  }
		  var TrueUserName = $("#TrueUserName").val();
		  if(TrueUserName.length!=0){
		     $("#save").removeAttr("disabled");
		  }else{
		     $("#save").attr("disabled","disabled");
		  }
        }
        
        //重置
        function resutnull(){
          $("#telphoneB").val("");
          $("#sDh").val("");
          $("#sRealName").val("");
          $("#sBm").val('');
          $("#sBm2").val('');
          $("#sBm3").val('');
          $("#sBm4").val('');
          $("#seluserarea").val("");
          $("#sAddress").val("");
          $("#sDh1").val("");
          $("#UserName1").val('7');
          $("#UserName2").val("");
          $("#sDh0").val("");
          $("#linkman").val("");
          disabledget();
        }
        
        //从配置表里取到用户类型的下拉值
          var iftt="";
		  function UserTypeSelect(){
	      var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'radusertype.usertype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});				 							
			$.ajax({
					url:'mainServlet.html?'+urlstr,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
								///////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
								iftt="";
								$(xml).find('row').each(function(){
								//////////给下拉框进行赋值操作、5
								
								var TypeID = $(this).attr("typeid");
								var UserType = $(this).attr("usertype");
							    var ee="<option value='"+TypeID+"'>"+UserType+"</option>"; 
							    iftt = iftt+ee;     
							});					
						    $("#UserType").html("<option value=''>--<fmt:message key="gjh.select"/>--</option>");
						    $("#UserType").html($("#UserType").html()+iftt);
						}
					});
				} 
				
		//从配置表里取到同时在线数的下拉值
		var sim="";
		function iSimultaneoustype(){
		  var systemtype='broadbandsetup';//代表的系统项
		  var propertytype='iSimultaneous';//属性值
	      var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.tblconfit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});				 							
			$.ajax({
					url:'mainServlet.html?'+urlstr+'&ssection='+systemtype+'&sltem='+propertytype,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					            sim="";
					            $("#iSimultaneous").empty();
								///////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
								$(xml).find('row').each(function(){
								//////////给下拉框进行赋值操作、5
								var svalue = $(this).attr("svalue");
								  for(i=1;i<=svalue;i++){				
								     var ee="<option value='"+i+"'>"+i+"</option>";
								     sim=sim+ee;  
								  }																	
							});					
						    $("#iSimultaneous").html($("#iSimultaneous").html()+sim);
						}
					});
		} 
		
		//往工号里插入杂费项
		var zffeenameto="";
		function queryFeeInfo()
            {
                var i=0;
			 	var feename='';
			 	$("#zafeilist").find("input").each(function()
			 	{
			 		if($(this).attr("checked")==true)
			 		{
			 			if(i==0)
			 			{    
			 				feename+=$(this).next('span').text();
			 			}
			 			else
			 			{
			 				feename+='~'+$(this).next('span').text()
			 			}
			 			i++;
			 		}
			 	});
			 	
			 	if(feename!=undefined){
			 	var broadbandtotalfee = $("#broadbandtotalfee").val();
				var param = feename;
				//if(broadbandtotalfee==0){
				//  param="";
				//}
				
				$("#reportparam").val(param);
				
				var arr = tsd.encodeURIComponent(param).split("~");
				var sqlparam = arr.join("','");
				sqlparam = "'" + sqlparam + "'";
				var res = fetchMultiArrayValue("yiji.queryFee",0,"&itemss="+sqlparam);
				if(res[0]==undefined||res[0][0]==undefined||res[0][0]==""||res[0]=="")
				{
					return "";
				}
				else
				{   
					var temp = "";
					for(var j=0;j<res.length;j++)
					{
						temp += ",";
						temp += tsd.encodeURIComponent(res[j][0]);
						temp += tsd.encodeURIComponent("：");
						temp += res[j][1];
						temp += tsd.encodeURIComponent("元");
					}
					//alert(temp);
					temp = temp.replace(",","");
					zffeenameto=temp;
					//alert(zffeenameto);
					return temp;
				}
			   }
            }				            
    </script>
		<!-- 回车事件 -->
		<script language="javascript">
                function useryzKey(event){
                    if(event.keyCode==13){
                        isExist();
                        return false;
                    }
                }
                function phoneKey(event){
                    if(event.keyCode==13){
                        sDhCheck();
                        return false;
                    }
                }
    </script>
		<!--新业务代码区 -->
		<script language="javascript">   
      var svalueSimto="";//选择同时在线数，取出每天加一个同时在线数所需要的金额
      function chooseiSimultaneous(){
         var ssection = 'newfee';
         var sltem ='add a Simultaneous';
         var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'adduser.tblconfit'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				});	
			$.ajax({
					url:'mainServlet.html?'+urlstr+"&ssection="+ssection+"&sltem="+sltem,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
					     var svalueSim="";
					     var svalues="";
					     $(xml).find('row').each(function(){
					      svalueSim = $(this).attr("svalue");
					     });
					    var Simultaneous = $("#iSimultaneous").val();
					    var Sim = parseInt(Simultaneous,10);
					    for(i=1;i<Sim;i++){
					       svalues = svalueSim*i;
					    }
					    svalueSimto=svalues;
					    if(Simultaneous>1){
					    alert("<fmt:message key="broadband.tszxsxzw"/>["+Simultaneous+"]<fmt:message key="broadband.xbjje"/>["+svalues+"]元！");
					    }
					  }  
				  });			 				
      }
      
      //带宽提速，当用户费公费用户时可以选择要提速的计费规则，选择的提速计费费用规则必须大于当前的计费规则费用
      function addSpeed(){
         var urlstr=tsd.buildParams({ packgname:'service',//java包
						 			 clsname:'ExecuteSql',//类名
						 			 method:'exeSqlData',//方法名
						 			 ds:'broadband',
						 			 tsdcf:'mysql',//指向配置文件名称
						 			 tsdoper:'query',//操作类型 
						 			 datatype:'xml',//返回数据格式 
						 			 tsdpk:'adduser.ifeetypeaddquery',
						 			 tsdpkpagesql:'adduser.iFeetypeaddqueryPage'
						 		 });
			var usertype = $("#UserType").val();
			$("#feetypeeditgrid1").setGridParam({url:'mainServlet.html?'+urlstr+"&basefee="+baseFeeto+'&usertype='+usertype}).trigger("reloadGrid");
			   		
	}
	 //对带宽提升进行操作		
	 var youhueije="";
	 var addspeed="";
	 var memoto="";//带宽提速备注插入到表里		
	 function addiFeeTypeto(addiFeeType,basefee,iifeecode,ispeed,speed_iag){
        if(confirm("<fmt:message key="broadband.nqdjdkjfgz"/>["+feenameto+"]<fmt:message key="broadband.tsw"/>["+addiFeeType+"]的吗？")){
           var devno = $("#devno").val();
           if(devno=='1'){
    	         var speed = speedConversion(ispeed);//将带宽转换成M数
    		     $('#speed').val(speed);//得到的带框加载到页面上显示几M
    		     $("#ispeed").val(ispeed);//记载到隐藏欲里等待插入到数据库中
    	      }else if(devno=='2'){
    	         $("#ispeed").val(speed_iag);//记载到隐藏欲里等待插入到数据库中
    	         speed_iag=speed_iag.replace('pppoe',"");
    	         $('#speed').val(speed_iag);//得到的带框加载到页面上显示几M    	             	        
    	      }else{
    	         $('#speed').val("");//清空
    	         $("#ispeed").val("");//清空  
    	      }     
           youhueije = basefee-baseFeeto;
           memoto="带宽由"+feenameto+"提升为"+addiFeeType;
           $("#tishispeed").text("带宽由"+feenameto+"提升为"+addiFeeType+"需要每月收取带宽提速费用"+youhueije+"元")
        }
     }				
     
     //往radattachfee表里插入同时在线数
     function insertRadattachfeeiSm(){
       var UserName = $("#TrueUserName").val();
       var Simultaneous = $("#iSimultaneous").val();
       var feename = 'addSimultaneous';
       var fee=svalueSimto;
       var memo="同时在线数增加为："+Simultaneous;
       var usertype = $("#UserType").val();
       //alert(usertype);
       var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mysql',//指向配置文件名称
						 					tsdoper:'exe',//操作类型 
						 					datatype:'xmlattr',
						 					tsdpk:'radattachfee.inseriSm',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					tsdUserID:'ture'
						 				});		 				
	                //alert('mainServlet.html?'+urlstr+'&UserName='+UserName+"&feename="+feename+"&fee="+fee+"&memo="+memo);
					$.ajax({
					url:'mainServlet.html?'+urlstr+'&UserName='+UserName+"&feename="+feename+"&fee="+fee+"&memo="+tsd.encodeURIComponent(memo),
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
					   if(msg=="true"){
					     var loginfo = "";
					      loginfo += tsd.encodeURIComponent("表名：radattachfee");
						  loginfo += tsd.encodeURIComponent(" 帐号:");
						  loginfo += UserName;
						  loginfo += ";";
						  loginfo += tsd.encodeURIComponent(" 业务名称:");
						  loginfo += feename;
						  loginfo += ";";
						  loginfo += tsd.encodeURIComponent(" 月基本费:");
						  loginfo += fee;
						  loginfo += tsd.encodeURIComponent(" 备注:");
						  loginfo += tsd.encodeURIComponent(memo);
						  loginfo += ";";						  
						  writeLogInfo("","add",loginfo);
					   }
					 }
					});
     
     }
     
     //往radattachfee表里插入带宽提速在线数
     function insertRadattachfeespeed(){
       var UserName = $("#TrueUserName").val();
       var feename = 'addSpeed';
       var fee=youhueije;
       var memo=memoto;
       var urlstr=tsd.buildParams({ packgname:'service',//java包
						 			clsname:'ExecuteSql',//类名
						 			method:'exeSqlData',//方法名
						 			ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 			tsdcf:'mysql',//指向配置文件名称
						 			tsdoper:'exe',//操作类型 
						 			datatype:'xmlattr',
						 			tsdpk:'radattachfee.inseriSm',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 			tsdUserID:'ture'
						 		 });
	                //alert('mainServlet.html?'+urlstr+'&UserName='+UserName+"&feename="+feename+"&fee="+fee+"&memo="+memo);
					$.ajax({
					url:'mainServlet.html?'+urlstr+'&UserName='+UserName+"&feename="+feename+"&fee="+fee+"&memo="+tsd.encodeURIComponent(memo),
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(msg){
					   if(msg=="true"){
					     var loginfo = "";
					      loginfo += tsd.encodeURIComponent("表名：radattachfee");
						  loginfo += tsd.encodeURIComponent(" 帐号:");
						  loginfo += UserName;
						  loginfo += ";";
						  loginfo += tsd.encodeURIComponent(" 业务名称:");
						  loginfo += feename;
						  loginfo += ";";
						  loginfo += tsd.encodeURIComponent(" 月基本费:");
						  loginfo += fee;
						  loginfo += tsd.encodeURIComponent(" 备注:");
						  loginfo += tsd.encodeURIComponent(memo);
						  loginfo += ";";
						  writeLogInfo("","add",loginfo);
					    }
					 }
					});
     
     }
   </script>
   <!-- 打印 -->
   <script language="javascript">
            
           /////工单打印
        	function jobPrint(flag)
        	{
        		var jobid= $("#jobidid").val();
				var params = "&JobID="+jobid;
        		
        		if(flag=="1")
        		{
        			printWithoutPreview("broadband_jobadduser","JobID_"+jobid);
        		}
        		else if(flag=="2")
        		{
        			printThisReport1('<%=request.getParameter("imenuid")%>',
					'jobadduser',params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
        		}
        		else
        		{
            		
        		}        		
        		
        		if(parseFloat($("#printfeeee").val(),10)!=0&&$("#payitemYCY").val()!="transfer")
        		{
        			setTimeout(autoBlockForm("choosePrint","150","close","#FFFFFF",false),15);
        			$("#payitemYCY").val("")
        		}
        		else
        		{
        			setTimeout($.unblockUI,1);
        			$("#payitemYCY").val("")
        		}
        		
        	}

        	function cjkEncode(text) {   
        	    if (text == null) {   
        	        return "";   
        	    }   
        	 var newText = "";   
        	    for (var i = 0; i < text.length; i++) {   
        	        var code = text.charCodeAt (i);    
        	        if (code >= 128 || code == 91 || code == 93) {//91 is "[", 93 is "]".   
        	            newText += "[" + code.toString(16) + "]";   
        	        } else {   
        	            newText += text.charAt(i);   
        	        }   
        	    }   
        	 return newText;   
        	}  
        	
        	/////收费打印
        	function lsPrint(flag)
        	{
        		var param = $("#reportparam").val();
				var arr = tsd.encodeURIComponent(param).split("~");
				var sqlparam = arr.join("','");
				var feeinfoooo = "";
				sqlparam = "'" + sqlparam + "'";
				//取费用项目信息
				var res = fetchMultiArrayValue("yiji.queryFee",0,"&itemss="+sqlparam);
				
				if(res[0]==undefined||res[0][0]==undefined)
				{
					for(var k=1;k<=12;k++)
					{
						feeinfoooo += "&fee";
						feeinfoooo += k;
						feeinfoooo += "=";
						feeinfoooo += "";
						feeinfoooo += "&val";
						feeinfoooo += k;
						feeinfoooo += "=";
						feeinfoooo += "";
					}
				}
				else
				{
					var j = 1;
					for(j=1;j<res.length+1;j++)
					{
						feeinfoooo += "&fee";
						feeinfoooo += j;
						feeinfoooo += "=";
						feeinfoooo += cjkEncode(res[j-1][0]);
						feeinfoooo += "&val";
						feeinfoooo += j;
						feeinfoooo += "=";
						feeinfoooo += cjkEncode(res[j-1][1]);
					}
					while(j<=12)
					{
						feeinfoooo += "&fee";
						feeinfoooo += j;
						feeinfoooo += "=";
						feeinfoooo += "";
						feeinfoooo += "&val";
						feeinfoooo += j;
						feeinfoooo += "=";
						feeinfoooo += "";
						j++;
					}
				}
				
        		var params = "&JobID="+$("#jobidid").val() + feeinfoooo;
        		if(flag=="1")
        		{
        			printWithoutPreview("broadband_sf",params);
        		}
        		else
        		{
        			printThisReport1('<%=request.getParameter("imenuid")%>',
					'broadband_sf',params,
					'<%=(String)session.getAttribute("userid")%>',
					'<%=request.getParameter("groupid").replaceAll("~", ",")%>',
					'<%=(String)session.getAttribute("departname")%>',1);
        		}
        		setTimeout($.unblockUI,15);        		
        	}
        	
        	function notecheck(){
			 	var notecheck = $("#sAddress").val();
			    if(notecheck.length>0){
			    	 $("#sAddress").val(notecheck.substr(0,0));
			    }
			 }
			
			/*选择用户类型的时候，其它关联的去改变值*/ 
			function zfxzqx(){
			    ifeecodeto="";
			    baseFeeto=100000;
			 	addSpeed();
			 	$("#speed").val(""); 
			 	$("#tishispeed").empty();
			 	$(":radio[name='feetype']").removeAttr("checked");
			 	$("#transferHTH").val("");
			 	$("#transferHTHbox").attr("disabled","disabled");  
			 	$("#transferHTHbox").attr("checked","");
			 	getIFeeType();
			 	isnotifurgent();//得到是否紧急下拉框值
    	        $("#ifurgent").val("普通");
			 	var UserType = $("#UserType").val();
			 	if(UserType=="")
			 	{
			 		UserType="''";
			 	}
			 	var PrivatelyZFright = $("#PrivatelyZFright").val();
			 	var PublicZFright = $("#PublicZFright").val();		 	
			 	getfeetype(UserType);
			 	getsBm(UserType); //从配置表里得到部门一是否为必选项			 				 				 
			 }
			 
			 /*从配置表里得到部门一是否为必选项*/
			 function getsBm(UserType){			 	
			 	var res = fetchMultiArrayValue("adduser.tblconfit",0,"&ssection="+'sBmRequired'+"&sltem="+UserType);
			 	if(res!=""){
			 		$("#sBmRequired").val(res[0][0]);
			 		//如果为必选，则给部门一加上必选×号
			 		if(res[0][0]=="true"){
			 			$("#Required").text("*");
			 		}else{
			 			$("#Required").empty();
			 		}
			 	}else{
			 		$("#Required").empty();
			 		$("#sBmRequired").val("");
			 	}
			 	$("#sBm").val("");
			 	$("#sBm2").empty();
			 	$("#sBm3").empty();
			 	$("#sBm4").empty();			 	
			 }

		     function seluser(){
		         getIFeeType();
		         var seluserarea = $("#seluserarea").val();
		         if(seluserarea==""){$("#zafeilist").empty();}
		         $("#sAddress").val("");
		         $("#sAddress").removeAttr("disabled");
		     }

             //取出是否紧急状态             
             function isnotifurgent(){
                 var isf;
                 var ifurgent = 'ifurgent';
                 var urlstr=tsd.buildParams({packgname:'service',//java包
						 					 clsname:'ExecuteSql',//类名
						 					 method:'exeSqlData',//方法名
						 					 ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					 tsdcf:'mysql',//指向配置文件名称
						 					 tsdoper:'query',//操作类型 
						 					 datatype:'xmlattr',
						 					 tsdpk:'adduser.tblconfitifurgent'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 				   });				 							
				 $.ajax({
						url:'mainServlet.html?'+urlstr+'&ssection='+ifurgent,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
						            isf="";
						            $("#ifurgent").empty();
									///////////只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值////
									$(xml).find('row').each(function(){
									//////////给下拉框进行赋值操作、5
									var sitem = $(this).attr("sitem");
									var svalue = $(this).attr("svalue");
									var ee="<option value='"+sitem+"'>"+svalue+"</option>";
								    isf = isf+ee																
								});					
							    $("#ifurgent").html($("#ifurgent").html()+isf);
							}
					 });                 
             }
           
           //得到BAS设备数据
           function getBASsb(){
             $("#devno").empty();
             var res = fetchMultiArrayValue("adduser.queryBASsb",0,"");
             var queryBASsel="";
               if(res[0][0]!=undefined){
				   for(var i=0;i<res.length;i++)
				   {
				    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
				    queryBASsel+=ee					
				   }
				   $("#devno").append("<option value=\"\">--<fmt:message key="global.select" />--</option>");
			       $("#devno").html($("#devno").html()+queryBASsel);
			   }			   
           }
      </script>
      <script language="JavaScript" type="text/javascript">     
            var TextUtil = new Object(); 
            TextUtil.NotMax = function(oTextArea){ 
                var maxText = oTextArea.getAttribute("maxlength"); 
                if(oTextArea.value.length > maxText){ 
                        oTextArea.value = oTextArea.value.substring(0,maxText); 
                        alert("<fmt:message key="broadband.ccxz"/>"); 
                } 
            } 
      </script>
      <script language="JavaScript" type="text/javascript">           
         function ifnotpayitem(sltem){          
             if(sltem!=""){
              getpayitem();
             }
         }
         //从数据库中获取付费类型     
         function getpayitem(){
            $("#payitem").empty();
            var res = fetchMultiArrayValue("adduser.getpayitem",6,"");
            var querypayitemsel="";
               if(res[0][0]!=undefined){
				   for(var i=0;i<res.length;i++)
				   {
				    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
				    querypayitemsel+=ee					
				   }
			       $("#payitem").append($("#payitem").html()+querypayitemsel);
			   }
			 $("#transferHTHbox").attr("disabled","disabled");
             $("#transferHTHbox").attr("checked","");
             $("#transferHTH").val("");  
         }
         
         //选择付费类型时触发的事件
         function onchangehth(){
             var payitem = $("#payitem").val();
             if(payitem=='transfer'){
               $("#transferHTHbox").removeAttr("disabled");
             }else{
               $("#transferHTHbox").attr("disabled","disabled");
               $("#transferHTHbox").attr("checked","");
               $("#transferHTH").val("");
             }
         }
         
        //根据部门一得到合同号
        function getsbmhth(sbm){
           if(sbm==""){sbm=null;}
           var res = fetchMultiArrayValue("adduser.getsbmhth",6,"&sbm="+tsd.encodeURIComponent(sbm));
		   if(res==""){
             $("#hth").val("");
	       }else{
	         var hth = res[0][0];
	         $("#hth").val(hth);
	       }
         }
         
         //查看是否选择单位合同号，如果选择者弹出窗口显示单位同好和单位名称进行选择
         function isnotdanwei(){
            $("#queryHTHdw").empty();//每次查询前将以前的数据清空
            var transferHTHbox = $("#transferHTHbox").attr("checked");//查看是否被选择
            if(transferHTHbox==true){
               autoBlockForm('operform',5,'close',"#ffffff",false);//弹出查询框
               var res = fetchMultiArrayValue("phonelnstalled.isnotdanweiHTH",6,"");
               var ify="";
               ify += "<tr><td width=\"200\"><center><h4><fmt:message key="phoneyewu.dwHTH" /></h4></center></td><td width=\"400\"><center><h4>单位名称</h4></center></td></tr>";
               for(var i=0;i<res.length;i++){
                    ify += "<tr onClick=\"getHTHdanwei('"+res[i][0]+"')\" onDblClick=\"getinputHTH('"+res[i][0]+"')\" id=\""+res[i][0]+"\">";					
					ify += "<td style=\"width: 200px;height: 18px\"><center>";
					ify += res[i][0];
					ify += "</center></td>";
					ify += "<td width=\"400\"><center>";
					ify += res[i][1];
					ify += "</center></td>";
					ify +="</tr>";
               }
               $("#queryHTHdw").append(ify);
            }else{
               $("#transferHTHbox").attr("checked","");
               $("#transferHTH").val("");
               $("#inputDWHTH").val("");//将隐藏域中的清空
            }
        }
        
        //得到弹出单位合同号信息选择后的合同号
		function getHTHdanwei(params){
		      var inputDWHTH = params; 
		      $("#inputDWHTH").val(inputDWHTH);//把得到的单位合同号添加到隐藏域中点击确定的时候在从隐藏域中取
		      $("#queryHTHdw tr").css('background-color','#ffffff');
		      document.getElementById(params).style.background='#00ffff';
		 }
		 
		//点击弹出合同号狂窗口保存
		function getinputHTH(inputDWHTH){
		     var inputDWHTH = $("#inputDWHTH").val();//从隐藏域中得到单位合同号付给页面显示
		     if(inputDWHTH==""){$("#transferHTHbox").attr("checked","");}
		     $("#queryHTHdw tr").css('background-color','#ffffff');
		     $("#transferHTH").val(inputDWHTH);
		     $("#inputDWHTH").val("");//获取后将隐藏域中的清空		     
		     setTimeout($.unblockUI,15);
		}
		
		function closeGB(){
		   setTimeout($.unblockUI,15);
		   $("#queryHTHdw tr").css('background-color','#ffffff');
		   $("#transferHTHbox").attr("checked","");
		   $("#inputDWHTH").val("");//将隐藏域中的清空		   
		}
		
		//得到宽带接入方式
		function getAccessmethods(){
		   var sSection = '接入方式';
		   $("#accessmethods").empty();
		   var res = fetchMultiArrayValue("adduser.getAccessmethods",0,"&sSection="+tsd.encodeURIComponent(sSection));
		   var getaccess="";		   
               if(res[0][0]!=undefined){              
				   for(var i=0;i<res.length;i++)
				   {
				    var ee="<option value='"+res[i][0]+"'>"+res[i][1]+"</option>";	
				    getaccess+=ee
				   }
				   $("#accessmethods").append("<option value=\"\">--<fmt:message key="global.select" />--</option>");
			       $("#accessmethods").html($("#accessmethods").html()+getaccess);			       
			   }
		}
      </script> 
      <script language="javascript">
		///////////////////////////////////////////////////////////////////////////////
		// 功能：这个类使得被附加的表格可以支持行点击高亮
		// 参数：
		// tbl:                要附加样式的 table.
		// selectedRowIndex:    初始高亮的行的索引(从 0 开始). 此参数可省。
		// hilightColor:        高亮颜色。可省（默认为绿色）
		///////////////////////////////////////////////////////////////////////////////
		function TableRowHilighter(tbl, selectedRowIndex, hilightColor) {
		    this.currentRow = null;
		    this.hilightColor = hilightColor ? hilightColor : 'green';
		
		    if (selectedRowIndex != null 
		        && selectedRowIndex >= 0 
		        && selectedRowIndex < tbl.rows.length) 
		    {
		        this.currentRow = tbl.rows[selectedRowIndex];        
		        tbl.rows[selectedRowIndex].runtimeStyle.backgroundColor = this.hilightColor;
		    }
		
		    var _this = this;
		    tbl.attachEvent("onmouseover", table_onclick);   
		
		    function table_onclick(){
		        var e = event.srcElement;
		        if (e.tagName == 'TD')
		            e = e.parentElement;           
		        if (e.tagName != 'TR') return;
		        if (e == _this.currentRow) return;
		        if (_this.currentRow)
		            _this.currentRow.runtimeStyle.backgroundColor = '';
		            
		        e.runtimeStyle.backgroundColor = _this.hilightColor;
		        _this.currentRow = e;
		    }
		}
       </script>       
	</head>
	<body>
		<input type="hidden" id="queryName" name="queryName" value="" />
		<input type="hidden" id="fusearchsql" name="fusearchsql" style="display: block" />
		<input style="display: none;" type="button" onclick="javascript:window.showModalDialog('/tsd2009/queryServlet?tablename=Zhji_Code&url=/search.jsp',window,'dialogWidth:690px; dialogHeight:600px; center:yes; scroll:no');" />
		<input type="hidden" id="area" name="area" value='<%=area%>' />
		<!-- 工号所在区域 -->
		<input type="hidden" id="depart" name="depart" value='<%=depart%>' />
		<!-- 工号所在部门 -->
		<input type="hidden" id="usser_L" name="usser_L"
			value='<%=request.getSession().getAttribute("userid")%>' />
		<!-- 菜单ID -->
		<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
		<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
		<!-- 语言 -->
		<input type="hidden" id="languageType" name="languageType" value='<%=languageType%>'/>
		<!--用户区域-->
		<input type="hidden" id="HiddenUserArea" value="<%=area%>" />
		<!-- 用户操作导航-->
		
		<div id="navBar1">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							：
						</div>
					</td>
					<td width="20%" align="right" valign="top">
						<div id="d2back">
							<a href="javascript:void(0);"
								onclick="parent.history.back(); return false;"> <fmt:message
									key="gjh.houtuei" />
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div>
			<div id="broadband_frame">
				<form name="form1" method="post" onsubmit="return false;">
						<div id="input-Unit">
						    <div class="title">
									<img src="style/icon/45.gif" />
									<!-- 开户帐号填写: -->
									<fmt:message key="AddUser.BroadbandAccountFill" />
						    </div>
							<div id="inputtext">						
								<table style="" cellpadding="0px" cellspacing="2px">
									<tr>
										<td align="right">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<!-- 用户类别： -->
											<span id="spanPayType"></span>
										</td>
										<td>
											<select name="UserClass" id="UserClass" onchange="UserClassChange(this.options[this.options.selectedIndex].value)">
												<option value="StreetUser" selected>
													<!-- 小区网用户 -->
													<fmt:message key="AddUser.DistrictUser"/>
												</option>
												<!-- 
												<option value="WWWUser">													
													<fmt:message key="AddUser.ExternalUser"/>
												</option> --><!-- 外部网用户 -->
											</select>
										</td>
										<td align="right">
											<!-- 用户帐号： -->
											<span id="spangetUserName"></span>
										</td>
										<td>
											<input type="text" name="UserName" id="UserName" onkeydown="return useryzKey(event)" />
										</td>
										<td width="70px">
											<button id="submitButton" onclick="isExist()"
												style="height: 28px; margin-top: 3px; padding: 0px;">
												<fmt:message key="AddUser.AccountDetection" />
											</button>
										</td>
									</tr>
								</table>
							</div>
							<div class="title">
								<img src="style/icon/45.gif" />
								<!-- 电话信息填写: -->
								<fmt:message key="AddUser.TelephoneInformationFill" />
							</div>
							<div id="inputtext">
								<table border="0px" cellpadding="0px" cellspacing="2px">
									<tr>
										<td align="right" width="80">
											<!-- 电话号码： -->
											<span id="spangetsDh"></span>
										</td>
										<td>
											<input type="text" name="telphoneB" id="telphoneB" onkeydown="return phoneKey(event)"
												style="ime-mode: Disabled" onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57"
												maxlength="11" onpaste="return   !clipboardData.getData('text').match(/\D/)"
												ondragenter="return   false"/>
										</td>
										<td width="50px">
											<button id="phoneSubmitButton" onclick="sDhCheck()"
												style="height: 28px; margin-top: 3px; padding: 0px; width: 50px;">
												<!-- 查找 -->
												<fmt:message key="AddUser.Search"/>
											</button>
										</td>
										<td width="50px">
											<button id="phoneSubmitButton" onclick="resutnull()"
												style="height: 28px; margin-top: 3px; padding: 0px; width: 50px;">
												<!-- 重置 --><fmt:message key="tariff.reset" />
											</button>
										</td>
									</tr>
								</table>
							</div>
							<div class="title">
								<img src="style/icon/45.gif" />
								<!-- 认证信息填写: -->
								<fmt:message key="AddUser.AuthenticationInformationFill" />
							</div>
							<div id="inputtext">
								<table border="0px" cellpadding="0px" cellspacing="2px">
									<tr>
										<td align="right" width="80">
											<!-- 用户帐号： -->
											<span id="spanUserName"></span>
										</td>
										<td width="150">
											<input type="text" name="TrueUserName" id="TrueUserName"
												disabled="disabled" />
											<font color="red">*</font>
										</td>
										<td align="right" width="80">
											<!-- 输入密码： -->
											<span id="spanValue"></span>
										</td>
										<td width="150">
											<input type="text" name="Values" id="Values" />
											<font color="red">*</font>
										</td>
										<td align="right" width="80">
											<!-- 确认密码： -->
											<fmt:message key="AddUser.RepeatPassword" />
										</td>
										<td width="150">
											<input type="text" name="Valuess" id="Valuess" />
											<font color="red">*</font>
										</td>
									</tr>
									<tr>
										<td align="right">
											<!-- 绑定IP： -->
											<span id="spanidaddr"></span>
										</td>
										<td>
											<input type=text name="ipaddr" id="ipaddr" />
										</td>
										<td align="right">
											<!-- 绑定VLANID： -->
											<span id="spanvlanid"></span>
										</td>
										<td>
											<input type="text" name="vlanid" id="vlanid"/>
										</td>
										<td align="right">
											<!-- 同时在线数： -->
											<span id="spaniSimultaneous"></span>
										</td>
										<td>
											<select name="iSimultaneous" id="iSimultaneous"
												onchange="chooseiSimultaneous()">
												<option value="1"></option>
											</select>
										</td>
									</tr>
									<tr>										
										<td align="right">
											<!-- 用户类型： -->
											<span id="spansDh1"></span>
										</td>
										<td>
											<select name="UserType" id="UserType" onchange="zfxzqx()">
												<option value=""></option>
											</select>
											<font color="red">*</font>
										</td>
										<td align="right">
											<span id="spandevno"></span><!-- BAS设备 -->
										</td>
										<td>											
											<select name="devno" id="devno" onchange="getdevno()">
											</select><font color="red">*</font> 							
										</td>
										<td align="right">
											<span id="spanUserName1"></span><!-- MAC地址 -->
										</td>
										<td>											
											<input type="text" name="smacaddr" id="smacaddr"/>																		
										</td>
									</tr>
									<tr>
									   <td align="right"><span id="spaniFeeTypeS"></span><!-- 接入方式 --></td>
									   <td>
									      <select name="accessmethods" id="accessmethods">
									      </select><font color="red">*</font>
									   </td>
									</tr>							
								</table>
							</div>
							<div class="title">
								&nbsp;&nbsp;
								<img src="style/icon/45.gif" />
								<!-- 65 -->
								<!--  基本信息填写:-->
								<fmt:message key="AddUser.inputBasicUserInfo" />
							</div>
							<div id="inputtext">
								<table border="0px" cellpadding="0px" cellspacing="2px">
									<tr>
										<td align="right" width="80">
											<!-- 电话-->
											<span id="spansDh"></span>
										</td>
										<td align="left" width="150">
											<input type="text" name="sDh" id="sDh" disabled="disabled" />
										</td>
										<td align="right" width="80">
											<!-- 姓名： -->
											<span id="spansRealName"></span>
										</td>
										<td align="right" width="150">
											<input type="text" name="sRealName" id="sRealName"
												disabled="disabled"/>
											<font color="red">*</font>
										</td>
										<td align="right" width="80">
											<!--  部门1：-->
											<span id="spansBm"></span>
										</td>
										<!-- <td><input type="text" name="sBm" id="sBm" /></td> -->
										<td width="150">
											<select name="sBm" id="sBm" onchange="addsBmer()">
												<option value=""></option>
											</select><font color="red"><span id="Required"></span></font>
										</td>
									</tr>
									<tr>
										<td align="right">
											<!--  部门2：-->
											<span id="spansBm2"></span>
										</td>
										<td>
											<select name="sBm2" id="sBm2" onchange="addsBmsan()">
												<option value="">
													<fmt:message key="gjh.select" />
												</option>
											</select>
										</td>
										<td align="right">
											<!--  部门3：-->
											<span id="spansBm3"></span>
										</td>
										<td>
											<select name="sBm3" id="sBm3" onchange="addsBmsi()">
												<option value="">
													<fmt:message key="gjh.select" />
												</option>
											</select>
										</td>
										<td align="right">
											<!--  部门4：-->
											<span id="spansBm4"></span>
										</td>
										<td>
											<select name="sBm4" id="sBm4">
												<option value="">
													<fmt:message key="gjh.select" />
												</option>
											</select>
										</td>
									</tr>
									<tr>
									    <td align="right">
											 <span id="spansDh2"></span><!-- 用户区域： -->											
										</td>
										<td>
											<select name="seluserarea" id="seluserarea" onchange="seluser()">
												<option value="">
													<fmt:message key="gjh.select" />
												</option>
											</select><font color="red">*</font>  											
										</td>
										<td align="right" width="80">
											<!-- 用户地址: -->	
											<span id="spansAddress"></span>
										</td>
										<td width="150">
											<input type="text" id="sAddress" disabled="disabled" onpaste="return false"/>
											<font color="red">*</font>
										</td>
										<td align="right">
											<!-- 移动电话： -->
											<span id="spanmobile"></span>
										</td>
										<td>
											<input type="text" name="sDh1" id="sDh1"
												style="ime-mode: Disabled"
												onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57"
												maxlength="11"
												onpaste="return   !clipboardData.getData('text').match(/\D/)"
												ondragenter="return   false" disabled="disabled" />
										</td>
									</tr>
									<tr>
										<td align="right">
											<!-- 证件类型： -->
											<span id="spanidtype"></span>
										</td>
										<td>
											<select name="UserName1" id="UserName1"	onchange="idcardChange(this.options[this.options.selectedIndex].value)" disabled="disabled">
												<option value="7">
													<!--身份证 -->
													<fmt:message key="AddUser.ID" />
												</option>
												<option value="1">
													<!-- 教职工 -->
													<fmt:message key="AddUser.Faculty" />
												</option>
												<option value="2">
													<!--本科生 -->
													<fmt:message key="AddUser.Undergraduate" />
												</option>
												<option value="3">
													<!--研究生 -->
													<fmt:message key="AddUser.Graduate" />
												</option>
												<option value="4">
													<!--离退休 -->
													<fmt:message key="AddUser.Retired" />
												</option>
												<option value="5">
													<!--护照 -->
													<fmt:message key="AddUser.Passport" />
												</option>
												<option value="6">
													<!--军官证 -->
													<fmt:message key="AddUser.MilitaryID" />
												</option>										
												<option value="8">
													<!--其它 -->
													<fmt:message key="AddUser.other" />
												</option>
											</select>
											<font color="red">*</font>
										</td>				
										<td align="right">
											<!-- 证件号码： -->
											<span id="spanidcard"></span>
										</td>
										<td>
											<input type="text" name="UserName2" id="UserName2"
												style="ime-mode: Disabled"
												onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57"
												maxlength="18"
												onpaste="return   !clipboardData.getData('text').match(/\D/)"
												ondragenter="return   false" disabled="disabled" />
											<font color="red">*</font>
										</td>
										<td align="right">
											<!-- 联系电话： -->
											<span id="spanlinkphone"></span>
										</td>
										<td align="left">
											<input type="text" name="sDh0" id="sDh0"
												style="ime-mode: Disabled"
												onkeypress="var   k=event.keyCode;   return   k>=48&&k<=57"
												maxlength="11"
												onpaste="return   !clipboardData.getData('text').match(/\D/)"
												ondragenter="return   false" disabled="disabled" />
											<font color="red">*</font>
										</td>
									</tr>
									<tr>	
										<td align="right">
											<!-- 联系人： -->
											<span id="spanlinkman"></span>
										</td>
										<td>
											<input type="text" name="linkman" id="linkman"
												disabled="disabled" />
											<font color="red">*</font>
										</td>
										<td align="right">
											<!-- 带宽： -->
											<span id="spanspeed"></span>
										</td>
										<td>
											<input type="text" value="0" name="speed" id="speed"
												disabled="disabled" />
											<font color="red">*</font>
											<!-- <input type=text name=speed value ="" onblur="if (!(/^[\d]+\.?\d*$/.test(this.value)) ){jAlert('输入带宽非法!','消息提示框');this.value=''}"/>  -->
										</td>
										<td align="right">
										  <span id="spanhth"></span><!-- 合同号 -->
										</td>
										<td>
										  <input type="text" name="hth" id="hth" disabled="disabled"/>
										</td>
									</tr>
								</table>
							</div>

							<div class="title">
								<img src="style/icon/45.gif" />
								<!-- 计费信息填写: -->
								<fmt:message key="AddUser.FillBill" />
							</div>

							<div id="inputtext1">
								<table border="0px" cellpadding="0px" cellspacing="2px"
									width="760">
									<tr>
										<td align="left" width="33%">
											<div style="float: left; margin-top: 3px; margin-left: 5px;">
												<!-- 计费规则 -->
												<span id="spaniFeeType"></span>
											</div>
										</td>
										<td align="left" width="28%">
											<div style="float: left; margin-top: 3px; margin-left: 5px;">
												<!-- 杂费类型 -->
												<fmt:message key="broadband.kdtsjfgz"/><!-- 带宽提速计费规则 -->
											</div>
										</td>
										<td align="left" width="45%">
											<div style="float: left; margin-top: 3px; margin-left: 5px;">
												<fmt:message key="phoneyewu.yicixingfee" />
								                <!-- 一次性费用 -->
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<div style="width: 100%;" id="feetypelist">
												<table id="feetypeeditgrid" class="scroll" cellpadding="0"
													cellspacing="0"></table>
												<div id="feetypepagered" class="scroll"
													style="text-align: left;"></div>
											</div>
										</td>
										<td>
										<div style="width: 100%;" id="feetypelist1">
												<table id="feetypeeditgrid1" class="scroll" cellpadding="0"
													cellspacing="0"></table>
												<div id="pagered1" class="scroll"
													style="text-align: left;"></div>											
											</div>
										</td>
										<td>
											<div
												style="width: 100%; height: 165px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">
												<div id="zafeilist"
													style="width: 98%; float: left; margin: 3px 0 3px 0;" disabled="disabled">
												</div>
											</div>											
										</td>										
									</tr>																		
								</table>
								<table>
								   <tr>
									   <td>
									      <span id="tishispeed" style="color:red">
									   </td>
									</tr>
								</table>
							<hr style="border: 1px dotted #CCCCCC;"/>
							<table cellspacing="5px">
							   <tr>
							    <td><fmt:message key="AddUser.TotalCostOfBroadband" /></td>
								<td><input id="broadbandtotalfee" type="text" value="0" readonly /></td>
							    <td><fmt:message key="broadband.paytype" /><!-- 付费类型 --></td>
							    <td>
							       <select name="payitem" id="payitem" style="width:100px" onchange="onchangehth()"></select>
							    </td>
							    <td><fmt:message key="broadband.ZZhth" /><!-- 转账合同号 --></td>
								<td>
									<input type="text" name="transferHTH" id="transferHTH" style="width:150" disabled="disabled" />
								</td>
								<td>
								  <input type='checkbox' name="transferHTHbox" id="transferHTHbox"
												style="width: 22px; padding: 0px;" onclick="isnotdanwei()" disabled="disabled"/>
								</td>
								<td><fmt:message key="broadband.selectHTH" /><!-- 选择合同号 --></td>
							   </tr>
							</table>	
							<hr style="border: 1px dotted #CCCCCC;"/>
							<table cellspacing="2px">
							  <tr>
							    <td>
							      <fmt:message key="broadband.isurgent" /><!-- 是否紧急 -->
							    </td>
							    <td>
							     <select name="ifurgent" id="ifurgent" style="width: 100px">
							     </select> 
							    </td>
							    <td>
							      <fmt:message key="phoneyewu.memo" />
							    </td>
							    <td>
	         	                 <textarea id="jobmemo" name="jobmemo" rows="4" cols="80" maxlength="60"  onpropertychange="TextUtil.NotMax(this)" disabled="disabled"></textarea>
							    </td>
							  </tr>							  
							</table>									
							</div>
							<div>							
							</div>
							<!-- 缺省值,没有也必须传到后台-->
							<div style="display: none">
								<input type="hidden" name="PauseStartTime" id="PauseStartTime"
									value="1990-01-01 00:00:00" />
								;
								<input type="hidden" name="PauseStopTime" id="PauseStopTime"
									value="1990-01-01 00:00:00" />
								;
								<input type="hidden" name="AcctStartMonth" id="AcctStartMonth"
									value="0" />
								;
								<input type="hidden" name="AcctEndMonth" id="AcctEndMonth"
									value="0" />
								;
								<input type="hidden" name="PauseStartMonth" id="PauseStartMonth"
									value="0" />
								;
								<input type="hidden" name="PauseEndMonth" id="PauseEndMonth"
									value="0" />
								;
								<!-- <input type="hidden" name="UserID" id="UserID" value="0"/>; -->
								<input type="hidden" name="iFeeStopType" id="iFeeStopType"
									value="-1" />
								;
								<input type="hidden" name="iAutoSessiontimeout"
									id="iAutoSessiontimeout" value="0" />
								;
								<input type="hidden" name="RemainTime" id="RemainTime" value="0" />
								;
								<input type="hidden" name="thismonthtime" id="thismonthtime"
									value="0" />
								;
								<input type="hidden" name="nextmonthtime" id="nextmonthtime"
									value="0" />
								;
								<input type="hidden" name="totaltime" id="totaltime" value="0" />
								;
								<input type="hidden" name="feeendtime" id="feeendtime"
									value="1990-01-01 00:00:00" />
								;
								<input type="hidden" name="iFeeTypeTime" id="iFeeTypeTime"
									value="1990-01-01 00:00:00" />
								;
								<input type="hidden" name="iFeeType1" id="iFeeType1" value="-1" />
								;
								<input type="hidden" name="iFeeTypeS" id="iFeeTypeS" value="-1" />
								;
								<input type="hidden" name="Fee5" id="Fee5" value="0.00" />
								;
								<input type="hidden" name="selcode" id="selcode" />
								;
						</div>
					</div>
				</form>
			</div>
		</div>
		<div id="buttons">
			<center>				
				<button id="save" onclick="isValiableddd()"
					style="margin-left: 20px;">
					<!-- 确定 -->
					<fmt:message key="Revenue.Save"/>
				</button>
				<button id="reset" onclick="clernull()" style="margin-left: 20px;">
					<!-- 重置 -->
					<fmt:message key="AddUser.Reset" />
				</button>				
			</center>
		</div>
		<div style="display: none" id="SearchEmpty">
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
			<input id="Qclose" type="button"
				value="<fmt:message key="global.close"/>" />
		</div>

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
		<input type="hidden" id="addright" />
		<input type="hidden" id="deleteright" />
		<input type="hidden" id="editright" />
		<input type="hidden" id="editfields" />
		<input type="hidden" id="delBright" />
		<input type="hidden" id="editBright" />
		<input type="hidden" id="exportright" />
		<input type="hidden" id="printright" />
		<input type="hidden" id="PrivatelyZFright"/>
		<input type="hidden" id="PublicZFright"/>		
		<input type="hidden" id="ordertable" />
		<input type="hidden" id="meetid" />
		<input type="hidden" id="userareaid" value="<%=userareaid %>"/>
		<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request)%>' />
		<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid")%>' />
		<!-- 自己要用的用的 -->
		<input type="hidden" id="checkright" />
		<!-- 权限 -->
		<input type="hidden" id="BroadbandBusinessright"/>
		<input type="hidden" id="TelphoneBusinessright"/>
		<input type="hidden" id="c_p_address_addright"/>
		<!-- 打印报表 -->
		<input type="hidden" name="printfeeee" id="printfeeee" value="0" />
		<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
		<iframe id="p_i_f"
			style="width: 0px; height: 0px; visibility: visible"></iframe>
		<input type="hidden" name="reportparam" id="reportparam" />
		<input type="hidden" name="jobidid" id="jobidid" />
		<input type="hidden" id="userid" value="<%=userid %>"/>
		<input type="hidden" id="ispeed" name="ispeed"/>
		<input type="hidden" id="inputDWHTH" name="inputDWHTH"/>
		<input type="hidden" id="payitemYCY" name="payitemYCY"/>		
		<!-- 是否可以不选一次性费用项 -->
		<input type="hidden" id="ableForNoChoose" name="ableForNoChoose" />		
		<div class="neirong" id="operform"
			style="display: none;width:528px">
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
						<a href="#" onclick="closeGB();"><fmt:message key="global.close" /><!-- 关闭 --></a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:left;">
			<div id="inputtext">
			<div style="width: 525px; height: 250px; overflow-y: scroll; overflow-x: scroll; border-top: 1px solid gray; border-left: 1px solid gray;">			   						
						<table border="1" cellpadding="0" bordercolor="#9AC0CD"
							id="queryHTHdw" style="width: 507px;">												
						</table>
			</div>										
				<div id="buttons">  
				<center>
					<button id="save" onclick="getinputHTH()"
						style="margin-left: 20px;">
						<!-- 确定 -->
						<fmt:message key="Revenue.Save" />
					</button>
					<button id="reset" onclick="closeGB();" style="margin-left: 20px;">
						<fmt:message key="global.close" />
						<!-- 关闭 -->
					</button>
				</center>	
				</div>
			  </div>	 
			</div>
		</div>
		<!-- 打印表报 -->	
		<div class="neirong" id="choosePrintJob"
			style="display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif"/>
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="broadband.printmethod" /><!-- 打印方式 -->
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif"/>
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:center;">
				<h4><fmt:message key="broadband.sjbcaccouncc" /> :</h4> 
				<button id="printDirect" class="tsdbutton" onclick="jobPrint(1)"><fmt:message key="broadband.zhijiePrint" /><!-- 直接打印 --></button>	
				<button id="printInDirect" class="tsdbutton" onclick="jobPrint(2)"><fmt:message key="broadband.yulanPrint" /><!-- 预览打印 --></button>
				<button id="printInDirect" class="tsdbutton" onclick="jobPrint(0)"><fmt:message key="broadband.notprint" /><!-- 不打印 --></button>
		    </div>	
		    <div class="midd_butt"></div>
		</div>
		<div class="neirong" id="choosePrint" style="display: none">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="broadband.printmethod" /><!-- 打印方式 -->
						</div>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif"/>
				</div>
			</div>
			<div class="midd" style="background-color:#FFFFFF;text-align:center;">
						<h4><fmt:message key="broadband.jobpiaojuprintwanbi" />:</h4>
						<button id="printDirect" class="tsdbutton" onclick="lsPrint(1)"><fmt:message key="broadband.zhijiePrint" /></button>
						<button id="printInDirect" class="tsdbutton" onclick="lsPrint(0)"><fmt:message key="broadband.yulanPrint" /></button>
		    </div>
		    <div class="midd_butt"></div>
		</div>
		<iframe id="printReportDirect" style="width:120px;height:0px;visibility:visible" src="print.jsp"></iframe>
	    <script>
		var hilighter2 = new TableRowHilighter(document.getElementById('queryHTHdw'), 0, 'lightsteelblue');
	  </script>
	  <input type="hidden" name="adduserflag" id="adduserflag" value="true"/>
	 <!-- 得到一级部门是否必选 -->
	  <input type="hidden" name="sBmRequired" id="sBmRequired"/>
	  <input type="hidden" id="addressinputright"/>
	</body>
</html>