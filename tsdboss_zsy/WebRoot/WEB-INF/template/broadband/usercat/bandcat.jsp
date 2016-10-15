<%----------------------------------------
	name: broadband/usercat/bandcat.jsp
	Function: 宽带用户上网详单查询 Broadband online user
	author: 吴长龙
	version: 1.0, 2010-11-3
	description:  
	modify: 
		2010-11-3 吴长龙 添加注释
		2010-11-08  chenze  添加方法注释
		2010-12-13  youhongyu 导出数据字段别名为空报错，更正为字段别名为空时显示为字段名；
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	String languageType = (String) session.getAttribute("languageType");
%>

<%
	SimpleDateFormat format = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
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
		<!-- 验证框架需要导入的js文件 -->
		<script type="text/javascript"
			src="plug-in/jquery/validate/jquery.validate.js"></script>
		<!-- 弹出面板需要导入js文件 -->
		<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js"
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

		<!-- 本项目引入 -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<script type="text/javascript" src="script/public/public.js"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 新的面板样式 -->
		<style type="text/css">
		#navBar1 {
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

	<script type="text/javascript">
		/**
		 * 取用户权限
		 * @param
		 * @return
		 */
		function getUserPower(){
		 var urlstr=tsd.buildParams({ 	  packgname:'service',
					 					  clsname:'Procedure',
										  method:'exequery',
					 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
					 					  tsdpname:'bandcat.getPower',//存储过程的映射名称
					 					  tsdExeType:'query',
					 					  datatype:'xmlattr'
				 					});
		/************************
		*   调用存储过程需要的参数 *
		**********************/
		var userid = $('#userid').val();	
		var groupid = $('#zid').val();
		var imenuid = $('#imenuid').val();
		
		/****************
		*   拼接权限参数 *
		**************/
		
		var exportright='';
		var printright='';
		var queryright = '';	
		var saveQueryMright ='';
		
		var flag = false;
		
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
				exportright='true';
				printright='true';
				queryright='true';
				saveQueryMright='true';
				flag = true;
		}else if(spower!=''&&spower!='all@'){
				var spowerarr = spower.split('@');
				
				for(var i = 0;i<spowerarr.length-1;i++){
					
					exportright += getCaption(spowerarr[i],'export','')+'|';	
					
					printright += getCaption(spowerarr[i],'print','')+'|';
					
					saveQueryMright += getCaption(spowerarr[i],'saveQueryM','')+'|';
					queryright += getCaption(spowerarr[i],'query','')+'|';	
					
				}
		}	
		var hasexport = exportright.split('|');
		var hasprint = printright.split('|');
		var hasquery = queryright.split('|');
		var hassaveQueryM = saveQueryMright.split('|');
		var str = 'true';
		
		if(flag==true){
			$("#exportright").val(exportright);
			$("#printright").val(printright);
				$("#queryright").val(str);	
				$("#saveQueryMright").val(str);

		}else{
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
		
	
	}
			
	/**
	 * 页面加载时执行
	 * @param
	 * @return
	 */
	jQuery(document).ready(function () {
	//页面表头当前位置显示
	$("#navBar1").append(genNavv());
		zuiDa();//显示最大显示月份
		setLabel();
		/**********************
		**   取得当前用户的权限  *
		**********************/
		getUserPower();	
			
		var maxmonth=$("#maxcount").html();//最大显示月份
		var  nowtime=$("#nowtime").html();//系统时间
		 
		$("#table").val('radacct_'+nowtime.substr(0,4)+nowtime.substr(5,2));//取当月		
		var month=nowtime.substr(5,2);var year=nowtime.substr(0,4);
			
		var yearcount=(parseInt(maxmonth,10)-parseInt(month,10))/12;
		yearcount=parseInt(yearcount,10);
		var monthcount=(parseInt(maxmonth,10)-parseInt(month,10)-12*yearcount)%12;
	
		if(yearcount==0&&monthcount<=0){//只有当前年
			document.getElementById("year").options.add(new Option(year,year));			
			var count=parseInt(maxmonth,10);
			var m=parseInt(month,10);
			while(count>0){
				if(m>9){
					document.getElementById("month").options.add(new Option(m,m));
				}else{
					document.getElementById("month").options.add(new Option('0'+m,'0'+m));
				}
				m--;
				count--;
			}			
		}else{
			while(yearcount+2>0){//yearcount如果是0，就是两年；如果是1，就是三年；如果是2，就是四年。
				document.getElementById("year").options.add(new Option(year,year));
				year--;
				yearcount--;
			}
			for(var i=parseInt(month,10);i>0;i--){
				if(i>9){
					document.getElementById("month").options.add(new Option(i,i));
					}else{
					document.getElementById("month").options.add(new Option('0'+i,'0'+i));
				}
			}
		}
		
		//alert(nowtime.substr(5,2));
		$("#month").val(nowtime.substr(5,2));//显示当前的月
		if(!tableisE($("#table").val())){
			$("#gridd").empty();
			$("#gridd").append("<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>");
			buttondisable();//表名不存在时，查询，排序，导出，打印，都不能用了
			alert("<fmt:message key='broadcat.alertnotbiao'/>");
			return false;
		}//alert("数据库中不存在当前月的记录")
		buttonenable();//表名存在时，查询，排序，导出，打印，能用了
		catlist();//显示指定表的所有数据列表,分页显示
		});

		/**
		 * 国际化信息 ，根据别名表所取出的数据设置相应的label
		 * @param
		 * @return
		 */
		function setLabel(){
			//对jgGrid的操作符进行国际化
			var opr = $("#operation").val();
			var thisdata = loadData('radacct','<%=languageType%>',1);	
			
			var UserName=thisdata.getFieldAliasByFieldName('UserName');			 
			var acctstarttime=thisdata.getFieldAliasByFieldName('AcctStartTime');
			var acctstoptime=thisdata.getFieldAliasByFieldName('AcctStopTime');
			var acctsessiontime=thisdata.getFieldAliasByFieldName('AcctSessionTime');
			var FramedIpAddress=thisdata.getFieldAliasByFieldName('FramedIPAddress');
			var CallingStationId=thisdata.getFieldAliasByFieldName('CallingStationId');
			var NASIPAddress=thisdata.getFieldAliasByFieldName('NASIPAddress');
			var NASPortId=thisdata.getFieldAliasByFieldName('NASPortId');
			var Realm=thisdata.getFieldAliasByFieldName('Realm');
			var NASPortType=thisdata.getFieldAliasByFieldName('NASPortType');
			var AcctInputOctets=thisdata.getFieldAliasByFieldName('AcctInputOctets');
			var AcctOutputOctets=thisdata.getFieldAliasByFieldName('AcctOutputOctets');
			var AcctTerminateCause=thisdata.getFieldAliasByFieldName('AcctTerminateCause');
			var ServiceType=thisdata.getFieldAliasByFieldName('ServiceType');
			var FramedProtocol=thisdata.getFieldAliasByFieldName('FramedProtocol');
			var FramedIPAddress=thisdata.getFieldAliasByFieldName('FramedIPAddress');
			$("#lUserName").html(UserName);$("#starttime").html(acctstarttime);
			$("#stoptime").html(acctstoptime);$("#sessiontime").html(acctsessiontime);
			$("#lFramedIpAddress").html(FramedIpAddress);$("#lCallingStationId").html(CallingStationId);
			$("#lNASIPAddress").html(NASIPAddress);$("#lNASPortId").html(NASPortId);
			$("#lRealm").html(Realm);  $("#lNASPortType").html(NASPortType);
			$("#lAcctInputOctets").html(AcctInputOctets); $("#lAcctOutputOctets").html(AcctOutputOctets);
			$("#lAcctTerminateCause").html(AcctTerminateCause); $("#lServiceType").html(ServiceType);
			$("#lFramedProtocol").html(FramedProtocol); $("#lFramedIPAddress").html(FramedIPAddress);
			
			
			
			$("#lUserNameq").html(UserName);$("#lRealmq").html(Realm); 
		
		
		}

		/**
		 * 初始化jqGrid参数 显示数据
		 * @param
		 * @return
		 */
		function catlist()
		{
			$("#gridd").empty();
			$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
			$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
								
			//设置命令参数
		 	var urlstr=tsd.buildParams({ packgname:'service',//java包
										 clsname:'ExecuteSql',//类名
										 method:'exeSqlData',//方法名
										 ds:'tsdradius',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										 tsdcf:'mysql',//指向配置文件名称
										 tsdoper:'query',//操作类型 
										 datatype:'xml',//返回数据格式 
										 tsdpk:'dbsql_bandcat.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										 tsdpkpagesql:'dbsql_bandcat.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
							});
					
			var col=[[],[]];
			//col=getRb_Field('radacct','','','','ziduans');
			col=getRb_Field('radacct','RadAcctId',"详细",'20','ziduans');//得到jqGrid要显示的字段
			 
			var ziduan=$("#ziduans").val();			
			ziduan = ziduan.replace(new RegExp('AcctStartTime',"g"),"AcctStartTime as AcctStartTime");		
		    ziduan = ziduan.replace(new RegExp('AcctStopTime',"g"),"AcctStopTime as AcctStopTime");
		    tsd.QualifiedVal=true;
		   
		  // ziduan=tsd.encodeURIComponent(ziduan);
		   if(tsd.Qualified()==false){return false;}
		
			$("#ziduans").val(ziduan);
			jQuery("#editgrid").jqGrid({
					
					url:'mainServlet.html?'+urlstr+"&table="+$("#table").val()+"&ziduans="+$("#ziduans").val(),
					datatype: 'xml', 
					colNames:col[0], 
					colModel:col[1],
				       	rowNum:30, //默认分页行数
				       	rowList:[30,50,100], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'acctstarttime', //默认排序字段
				       	viewrecords: true,
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'<fmt:message key="bandcat.title"/>', 
				       	height:document.documentElement.clientHeight-210, //高
				        width:document.documentElement.clientWidth-35,
				       	loadComplete:function(){
								$("#editgrid").setSelection('0', true);
								$("#editgrid").focus();
								var editinfo = $("#editinfo").val();
								var deleteinfo = $("#deleteinfo").val();
								addRowOperBtnimage('editgrid','openInfo','RadAcctId','click',1,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;");//详细
								executeAddBtn('editgrid',1);
								},
							ondblClickRow:function(rowid){
							var id=$("#editgrid").getCell(rowid,"RadAcctId");
							openInfo(id);//详细
						}
				}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
			}
			
			/**
			 * 设置页面按钮不可用
			 * @param
			 * @return
			 */
			function buttondisable()
			{	
				$("#gjquery1").attr("disabled","disabled");
				$("#gjquery2").attr("disabled","disabled");
				$("#savequery1").attr("disabled","disabled");
				$("#savequery2").attr("disabled","disabled");				
				$("#order").attr("disabled","disabled");
				$("#orderf").attr("disabled","disabled");
				$("#cat").attr("disabled","disabled");
				$("#catf").attr("disabled","disabled");
				$("#cat2").attr("disabled","disabled");
				$("#cat2f").attr("disabled","disabled");
				$("#export").attr("disabled","disabled");
				$("#exportf").attr("disabled","disabled");
				$("#print").attr("disabled","disabled");
				$("#printf").attr("disabled","disabled");
			}
			/**
			 * 根据相应的权限值，设置页面按钮的可用状态
			 * @param
			 * @return
			 */
			function buttonenable()
			{
				var queryright = $("#queryright").val();
				var saveQueryMright = $("#saveQueryMright").val();
				if(queryright=="true"){
						$("#gjquery1").removeAttr("disabled");	$("#gjquery2").removeAttr("disabled");
				}
				if(saveQueryMright=="true"){
					document.getElementById("savequery1").disabled=false;
					document.getElementById("savequery2").disabled=false;
				}
				var exportright = $("#exportright").val();
				if(exportright=="true"){
					$("#export").removeAttr("disabled");	$("#exportf").removeAttr("disabled");
				}else{
					$("#export").attr("disabled","disabled");$("#exportf").attr("disabled","disabled");
				}
			 	var printf11 = $("#printright").val();
				if(printf11=="true"){
					$("#print").removeAttr("disabled");	$("#printf").removeAttr("disabled");
				}else{
					$("#print").attr("disabled","disabled");$("#printf").attr("disabled","disabled");
				}
				
				$("#order").removeAttr("disabled"); $("#orderf").removeAttr("disabled");
				$("#cat").removeAttr("disabled"); $("#catf").removeAttr("disabled");
				$("#cat2").removeAttr("disabled"); $("#cat2f").removeAttr("disabled");
			
			}
			/**
			 * 获取可查询最大月数
			 * @param
			 * @return
			 */
           function zuiDa(){ 
	  		 var ss="";		
	  		 var urlstr=tsd.buildParams({packgname:'service',
							 					clsname:'ExecuteSql',
							 					method:'exeSqlData',
							 					ds:'tsdBilling',
							 					tsdcf:'oracle',
							 					tsdoper:'query',
							 					datatype:'xmlattr',				 	
												tsdpk:'dbsql_bandcat.queryconfig'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									});
					$.ajax({
						url:'mainServlet.html?'+urlstr,
						type:'post',
						datatype:'exe',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式					
						success:function(xml){
						$(xml).find('row').each(function(){	
									$("#maxcount").html($(this).attr("svalue"));													
							});						
					
						}});
						
						return ss;
	  		 }
	  		
			/**
			 * 年月下拉列表的change事件
			 * @param
			 * @return
			 */
			function yearchange()
			{		
				$("#month").empty();
				var  nowtime=$("#nowtime").html();//系统时间
				var maxmonth=$("#maxcount").html();//最大显示月份
				
				
				var month=nowtime.substr(5,2);var year=nowtime.substr(0,4);
				var yearcount=(parseInt(maxmonth,10)-parseInt(month,10))/12;
				yearcount=parseInt(yearcount,10);
				var monthcount=(parseInt(maxmonth,10)-parseInt(month,10)-12*yearcount)%12;
				if(yearcount==0&&monthcount<=0){
				//只有当前年，不会触发此事件				
				}else{
					var count=yearcount+2;//总共几年
					var cyear=$("#year").val();//当前选中的年
					var m=12;
					
					if(cyear==parseInt(year,10)){//当前年
							for(var i=parseInt(month,10);i>0;i--){
								if(i>9){
									document.getElementById("month").options.add(new Option(i,i));
									}else{
									document.getElementById("month").options.add(new Option('0'+i,'0'+i));
								}
							}					
						}else if(cyear<parseInt(year,10)&&cyear>parseInt(year,10)-count+1){//中间年
							for(var i=12;i>0;i--){
								if(i>9){
									document.getElementById("month").options.add(new Option(i,i));
									}else{
									document.getElementById("month").options.add(new Option('0'+i,'0'+i));
								}
							}
						}else{//最后一年
							while(monthcount>0){
							if(m>9){
								document.getElementById("month").options.add(new Option(m,m));
							}else{
								document.getElementById("month").options.add(new Option('0'+m,'0'+m));
							}
							m--;
							monthcount--;
						}
					}				
				}
		
			}
		
		///显示按钮操作
		/**
		 * 取用户权限
		 * @param
		 * @return
		 */
		function opencat()
		{
			$("#table").val('radacct_'+$("#year").val()+$("#month").val());
			if(!tableisE($("#table").val())){
				$("#gridd").empty();
				$("#gridd").append("<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>");
				buttondisable();//表名不存在时，查询，排序，导出，打印，都不能用了			
				alert("<fmt:message key='broadcat.alertnotbiao'/>");
				return false;
			}//alert("数据库中不存在当前月的记录")
			buttonenable();//表名存在时，查询，排序，导出，打印，能用了
			catlist();
		}
		
		/**
		 * 查询指定月份的详单表是否存在
		 * @param table  表名
		 * @return
		 */
		function tableisE(table)
		{
			var flag=true;		
			var urlstr=tsd.buildParams({packgname:'service',
				 					clsname:'ExecuteSql',
				 					method:'exeSqlData',
				 					ds:'tsdradius',
				 					tsdcf:'mysql',
				 					tsdoper:'query',
				 					datatype:'xmlattr',				 	
									tsdpk:'dbsql_bandcat.isExisttable'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						});
				$.ajax({
					url:'mainServlet.html?'+urlstr+'&table='+table,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){	
								var f=$(this).attr("table_name");
								if(f==undefined) 	flag=false;											
						});
				
					}
				});
				 
				return flag;
			}	    
               
            /**
			 * 复合操作
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
			 * 组合排序
			 * @param
			 * @return
			 */
			function zhOrderExe(sqlstr)
			{
				var params = fuheQbuildParams();			
					if(params=='&fusearchsql='){
						params +='1=1';
					}
				 params =params+'&orderby='+sqlstr;		    
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdradius',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'dbsql_bandcat.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'dbsql_bandcat.queryByOrderpage'
											});
				var link = urlstr1 + params;						
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+"&table="+$("#table").val()+"&ziduans="+$("#ziduans").val()}).trigger("reloadGrid");
			 	//setTimeout($.unblockUI, 15);//关闭面板				 	
			}
		
			/**
			 * 复合查询
			 * @param
			 * @return
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
											  ds:'tsdradius',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'dbsql_bandcat.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'dbsql_bandcat.fuheQueryByWherepage'
											});
				var link = urlstr1 + params;
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+"&table="+$("#table").val()+"&ziduans="+$("#ziduans").val()}).trigger("reloadGrid");
			 	setTimeout($.unblockUI, 15);//关闭面板	
			}
		
            /**
			 * 获取复合查询参数
			 * @param
			 * @return
			 */
			 function fuheQbuildParams()
			 {
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
		 * 打印
		 * @param
		 * @return
		 */
		function print(){
			 var exportright = $("#printright").val();
				if(exportright=="true"){
						var params='';
						var fusearchsql = encodeURIComponent(cjkEncode($("#fusearchsql").val()));
					 	//如果有可能值是汉字 请使用encodeURI()函数转码
					 	params+='&fusearchsql='+fusearchsql;			 	
					 	if(params=='&fusearchsql='){
							params +='1=1';
						}
						params+="&table="+$("#table").val();
					  //printThisReport("usercat/broadbandcat",params);
					    printThisReport1('<%=request.getParameter("imenuid")%>','broadbandcat',params,'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');
				
			}else{
		  		var operationtips = $("#operationtips").val();						
				jAlert("<fmt:message key="global.printright"/>",operationtips);
	  		}
		}
		/**  打开详细信息面板
		 * 
		 * @param
		 * @return
		 */
		 function openInfo(id){
	  		 	$("#id").val(id);
				$(".top_03").html('详细');//标题
				queryByAccount();//显示当前数据
				openpan();
	  	 }
	   /**
		 * 根据账号查询
		 * @param
		 * @return
		 */
	 	function queryByAccount(){    
  		var id=$("#id").val();			   		 	
  		var info="";	
  		 var urlstr=tsd.buildParams({packgname:'service',
						 				clsname:'ExecuteSql',
						 			method:'exeSqlData',
						 				ds:'tsdradius',
						 				tsdcf:'mysql',
						 				tsdoper:'query',
						 				datatype:'xmlattr',				 	
										tsdpk:'dbsql_bandcat.querybyid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								});
		
			urlstr=urlstr+"&table="+$("#table").val()+"&RadAcctId="+id;
		
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					type:'post',
					datatype:'exe',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式					
					success:function(xml){
					$(xml).find('row').each(function(){						
								var AcctInputOctets=$(this).attr("acctinputoctets");								
								var AcctOutputOctets=$(this).attr("acctoutputoctets");
								var AcctSessionId=$(this).attr("acctsessionid");
								var AcctSessionTime=$(this).attr("acctsessiontime");								
								var AcctStartTime=$(this).attr("acctstarttime");
								var AcctStopTime=$(this).attr("acctstoptime");
								var AcctTerminateCause=$(this).attr("acctterminatecause");								
								var AcctUniqueId=$(this).attr("acctuniqueid");
								var CallingStationId=$(this).attr("callingstationid");
								var FramedIPAddress=$(this).attr("framedipaddress");								
								var FramedProtocol=$(this).attr("framedprotocol");
								var NASIPAddress=$(this).attr("nasipaddress");
								var NASPortId=$(this).attr("nasportid");
								var NASPortType=$(this).attr("nasporttype");
								var Realm=$(this).attr("realm");
								var ServiceType=$(this).attr("servicetype");
								var UserName=$(this).attr("username");
								$("#iAcctInputOctets").val(AcctInputOctets+'KB');
								$("#iAcctOutputOctets").val(AcctOutputOctets+'KB');
								if(AcctSessionId!=null){
								$("#iAcctSessionId").val(AcctSessionId);
								}else{
								$("#iAcctSessionId").val("");
								
								}
								$("#iAcctSessionTime").val(AcctSessionTime+'秒');
								if(AcctStartTime=='1990-01-01 00:00:00'){
								$("#iAcctStartTime").val("");
								}else{
								$("#iAcctStartTime").val(AcctStartTime);
								}
								if(AcctStopTime=='1990-01-01 00:00:00'){
								$("#iAcctStopTime").val("");
								}else{
								$("#iAcctStopTime").val(AcctStopTime);
								}
								if(AcctTerminateCause==null){
								$("#iAcctTerminateCause").val("");
								}else{
								$("#iAcctTerminateCause").val(AcctTerminateCause);
								}
								if(AcctUniqueId==null){
								$("#iAcctUniqueId").val("");
								}else{
								$("#iAcctUniqueId").val(AcctUniqueId);
								}
								if(CallingStationId==null){
								$("#iCallingStationId").val("");
								}else{
								$("#iCallingStationId").val(CallingStationId);
								}
								if(FramedIPAddress==null){
								$("#iFramedIPAddress").val("");
								}else{
								$("#iFramedIPAddress").val(FramedIPAddress);
								}
								if(FramedProtocol==null||FramedProtocol=='null'){
								$("#iFramedProtocol").val("");
								}else{
								$("#iFramedProtocol").val(FramedProtocol);
								}
								if(NASIPAddress==null){
								$("#iNASIPAddress").val("");
								}else{
								$("#iNASIPAddress").val(NASIPAddress);
								}
								if(NASPortId==null){
								$("#iNASPortId").val("");
								}else{
								$("#iNASPortId").val(NASPortId);
								}
								if(NASPortType==null){
								$("#iNASPortType").val("");
								}else{
								$("#iNASPortType").val(NASPortType);
								}
								/**
								if(Realm==null){
								$("#iRealm").val("");
								}else{
								$("#iRealm").val(Realm);
								}
								*/
								if(ServiceType==null||ServiceType=="null"){
								$("#iServiceType").val("");
								}else{
								$("#iServiceType").val(ServiceType);
								}
								if(UserName==null){
								$("#iUserName").val("");
								}else{
								$("#iUserName").val(UserName);
								}
																												
								
						});						
				
					}});
					
					return info;
  		 }
	 	/**关闭面板
		 * @param
		 * @return
		 */
  		function closeo(){
			setTimeout($.unblockUI, 15);//关闭面板
		
		}
		/**
		 * 打开面板
		 * @param
		 * @return
		 */
      	function openpan(){
			autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板			
		}
		</script>
		<script type="text/javascript">    

		/**
		 * 拼接要显示的数据列main.js中有关导出数据的函数是 thisDataDownload,checkedAllFields,getTheCheckedFields,
		 * @param tablename 表名称
		 * @return
		 */
		function displayFields(tablename){
			var thearr = new Array();
				 var urlstr=tsd.buildParams({ 
  									packgname:'service',//java包
				 					clsname:'ExecuteSql',//类名
				 					method:'exeSqlData',//方法名
				 					ds:'tsdradius',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
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
								thefieldalias=thefieldalias.replace(new RegExp(" ","g"),"");
								var disvalue ='';
								if(thefieldalias==''||thefieldalias==undefined){
									disvalue = thefieldname ;
								}
								else{
									disvalue = thefieldname + ' as ' + tsd.encodeURIComponent(thefieldalias);
								}
								thearr.push(disvalue);
								
						 });
					 }
				 });
			return thearr;
		}
				
				
		</script>
		<script>
	
		/**
		 * 打开简单查询面板
		 * @param
		 * @return
		 */
		function openQuery(){
				setLabel();
			 	$(".top_03").html('<fmt:message key="global.query" />');//标题		
			 	autoBlockFormAndSetWH('panq',60,5,'closeoq',"#ffffff",true,1000,'');//弹出查询面板
			 	$("#iUserNameq").val("");
			 	//$("#iRealmq").val("");
		}
	
 		/**
		 * 通过表单值构造数据操作参数 请根据业务参数的多少和属性进行修改
		 * @param
		 * @return
		 */
		function QbuildParams()
		{		 	
		 	var UserName = $("#iUserNameq").val();
		 	
		 	var paramsStr='1=1 ';
		 	if(UserName!=''){
		 	 	paramsStr+="and UserName = '"+UserName+"' ";
	 		}
		 	/**
		 	var Realm = $("#iRealmq").val();
		 	if(Realm!=''){
		 		paramsStr+="and Realm like '%"+Realm+"%' " ;
		 	}
		 	**/
		 		 	
		 	$("#fusearchsql").val(paramsStr);
		 	fuheQuery();		
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
			<div id="navBar" style="text-align: left;">
				&nbsp;&nbsp;&nbsp;
				<fmt:message key='broadcat.time' />
				:
				<label id="nowtime"><%=new SimpleDateFormat("yyyy-MM").format(new Date())%></label>
				<!-- 当前年月是: -->
				&nbsp;&nbsp;&nbsp;
				<fmt:message key='broadcat.max' />
				:
				<label id="maxcount"></label>
				<!-- 设置最大查询月数 -->
				<br />

			</div>
			&nbsp;&nbsp;&nbsp;
			<fmt:message key='broadcat.selecttime' />
			:
			<select id="year" onchange="yearchange()"></select>
			<fmt:message key='broadcat.year' />
			<select id="month"></select>
			<fmt:message key='broadcat.month' />
			<!-- 选择显示时间:年 -->
			<button type="button" class="tsdbutton" onclick="opencat();">
				&gt;&gt;
				<fmt:message key='broadcat.cat' />
			</button>

			<!-- 用户操作标题以及放一些快捷按钮-->
			<div id="buttons" style="text-align: left;">

				<button type="button" id="order" onclick="openDiaO('radacct');">
					<!--组合排序-->
					<fmt:message key="order.title" />
				</button>
				<button type="button" id="cat" onclick='openQuery();'>
					<!--查询-->
					<fmt:message key="global.query" />
				</button>
				<button id="cat2" onclick='openQueryM(1);' style="display: none;">
					<fmt:message key="oper.mod" />
				</button>
				<button type="button" id='gjquery1'
					onclick="openDiaQ(query,'radacct');" disabled="disabled">
					<!--高级查询-->
					<fmt:message key="oper.queryA" />
				</button>
				<button type="button" id='savequery1' onclick="openModT();" style="display: none;"
					disabled="disabled">
					<!-- 将本查询保存为模板  -->
					<fmt:message key="oper.modSave" />
				</button>
				<button type="button" id="export"  style="display: none;"
					onclick="thisDownLoad('tsdBilling','mssql','radacct','<%=languageType%>');"
					disabled="disabled">
					<!--导出-->
					<fmt:message key="global.exportdata" />
				</button>
				<button type="button" id="print" onclick="print()" style="display: none;"
					disabled="disabled">
					<!--打印-->
					<fmt:message key="tariff.printer" />
				</button>



			</div>
			<div id="gridd">
				<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
				<div id="pagered" class="scroll" style="text-align: left;"></div>
			</div>
			<!-- 用户操作标题以及放一些快捷按钮-->
			<div id="buttons" style="text-align: left;display: none;">

				<button type="button" id="orderf" onclick="openDiaO('radacct');">
					<!--组合排序-->
					<fmt:message key="order.title" />
				</button>
				<button type="button" id="catf" onclick="openQuery();">
					<!--查询-->
					<fmt:message key="global.query" />
				</button>
				<button id="cat2f" onclick='openQueryM(1);'>
					<fmt:message key="oper.mod" />
				</button>
				<button type="button" id='gjquery2'
					onclick="openDiaQ('query','radacct');" disabled="disabled">
					<!--高级查询-->
					<fmt:message key="oper.queryA" />
				</button>
				<button type="button" id='savequery2' onclick="openModT();"
					disabled="disabled">
					<!-- 将本查询保存为模板  -->
					<fmt:message key="oper.modSave" />
				</button>
				<button type="button" id="exportf"
					onclick="thisDownLoad('tsdBilling','mssql','radacct','<%=languageType%>');"
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
		<div class="neirong" id="pan" style="display: none">
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
							<input type="text" id="iUserName" class="textclass2"
								disabled="disabled" />
						</td>
						<!-- 
		    <td width="12%" align="right"  class="labelclass"><label  id="lRealm"  ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		   <input type="text" id="iRealm"  class="textclass2" disabled="disabled"/></td>
		    -->
						<td width="12%" align="right" class="labelclass">
							<label id="lFramedIPAddress"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iFramedIPAddress" class="textclass2"
								disabled="disabled" />
						</td>

						<td width="12%" align="right" class="labelclass">
							<label id="lNASIPAddress"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iNASIPAddress" class="textclass2"
								disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="lNASPortId"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iNASPortId" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="lNASPortType"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iNASPortType" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="starttime"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iAcctStartTime" class="textclass2"
								disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="stoptime"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iAcctStopTime" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="sessiontime"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iAcctSessionTime" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="lAcctInputOctets"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iAcctInputOctets" class="textclass2"
								disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="lAcctOutputOctets"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iAcctOutputOctets" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="lCallingStationId"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iCallingStationId" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="lAcctTerminateCause"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iAcctTerminateCause" class="textclass2"
								disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="lServiceType"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iServiceType" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="lFramedProtocol"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iFramedProtocol" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id=""></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
						</td>
					</tr>



				</table>

				<div class="midd_butt">
					<!-- 关闭 -->
					<button class="tsdbutton" id="closeo"
						style="width: 63px; heigth: 27px;" onclick="closeo()">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>

		<div class="neirong" id="panq" style="display: none">
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
							style="margin-left: 5px;">关闭</span>
						</a>
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
							<label id="lUserNameq"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="iUserNameq" class="textclass" />
						</td>
						<!-- 
		    <td width="12%" align="right"  class="labelclass"><label  id="lRealmq"  ></label></td>
		    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
		  	 <input type="text" id="iRealmq"  class="textclass"/></td>
		  	 -->
						<td width="12%" align="right" class="labelclass">
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
						<td width="12%" align="right" class="labelclass">
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
						</td>
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
		<div class="neirong" id="thefieldsform"
			style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							选择您要导出的数据字段
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closethisinfo').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<form action="#" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0"
						cellpadding="0">
						<tr>
							<td>
								<div id="thelistform"
									style="margin-left: 10px; max-height: 200px;overflow-y: scroll;">

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
					onclick="getTheCheckedFieldstwo('broadband','mssql','radacct',$('#table').val())">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>

			</div>
		</div>



		<!-- 添加模板面板 -->
		<div id="modT" name='modT' style="display: none" class="neirong">
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
						</span>
						</a>
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
									onkeyup="this.value=replaceStrsql(this.value,80)"
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




			<input type="hidden" id="exportright" />
			<input type="hidden" id="printright" />
			<input type="hidden" id="userid" value="<%=userid%>" />
			<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
			<!-- 国际化保存表字段名 -->
			<input type="hidden" id="id" />

			<input type="hidden" id="table" />
			<!-- 保存表名 -->
			<!-- /****日志*** -->
			<input type='hidden' id='userloginip'
				value='<%=Log.getIpAddr(request)%>' />
			<input type='hidden' id='userloginid'
				value='<%=session.getAttribute("userid")%>' />
			<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
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



		</div>

	</body>
</html>