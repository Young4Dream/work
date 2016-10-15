<%----------------------------------------
	name: broadband/usercat/radalarmQ.jsp
	Function:  宽带告警详单查询
	author: 吴长龙
	version: 1.0, 2010-11-3
	description:   
	modify: 
		2010-11-3 吴长龙 添加注释
		2010-11-08  chenze  添加方法参数
		2010-12-14  youhongyu  导出查询sql语句拼接
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
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String languageType = (String) session.getAttribute("languageType");
	
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date now = new Date();
	String nowTime = format.format(now);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Definition relay Bureau to Group</title>
		<!--定义中继局向组-->
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 验证框架需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/validate/jquery.validate.js" ></script>
		<!-- 弹出面板需要导入js文件 -->
		<script type="text/javascript" src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" ></script>
		
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
		<script type="text/javascript" src="script/public/public.js"></script>
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" /><!-- 新的面板样式 -->
		<!-- 验证数据长度 -->
		<script src="plug-in/jqueryf/validate/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script type="text/javascript" src="script/public/infotest.js"></script>
		<!-- 操作列样式 -->
		<script src="plug-in/jquery/validate/public.js" type="text/javascript"></script>
		
		<script type="text/javascript">
		
		/**
		 * 获取用户权限
		 * @param
		 * @return
		 */
		function getUserPower()
		{
			var urlstr=tsd.buildParams({ packgname:'service',
					 					  clsname:'Procedure',
										  method:'exequery',
					 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
					 					  tsdpname:'radalarmQ.getPower',//存储过程的映射名称
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
			var deleteright = '';
			var editright = '';
			var editfields = '';				
			var exportright = '';
			var printright ='';
			
			/**
			添加模板查询
			queryright queryMright saveQueryMright
			hasquery hasqueryM hassaveQueryM 
			**/
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
					
					
					editfields = getFields('radacct_alarm');
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
		}
	</script>
<script type="text/javascript">	

	var closeflash = false;//用于判断是添加新增、添加保存
			
	/**
	 * 页面加载时执行
	 * @param
	 * @return
	 */
	jQuery(document).ready(function ()
	{
		//头部当前所在位置
		$("#navBar").append(genNavv());	
		// 用户权限判定，初始化用户可操作权限 			
		getUserPower();		
		var exportright = $("#exportright").val();
		var printright = $("#printright").val();
		
		//queryright queryMright saveQueryMright
		var queryright = $("#queryright").val();
		//var queryMright = $("#queryMright").val();
		var saveQueryMright = $("#saveQueryMright").val();
		
		
		if(exportright=="true"){
			document.getElementById("export1").disabled=false;
			document.getElementById("export2").disabled=false;
		}
		if(printright=="true"){
			document.getElementById("print1").disabled=false;
			document.getElementById("print2").disabled=false;
		}
		
		if(queryright=="true"){
			document.getElementById("gjquery1").disabled=false;
			document.getElementById("gjquery2").disabled=false;
		}	
		if(saveQueryMright=="true"){
			document.getElementById("savequery1").disabled=false;
			document.getElementById("savequery2").disabled=false;
		}
	
		/////设置命令参数
		var urlstr=tsd.buildParams({ 	  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mysql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'dbsql_radalarmQ.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'dbsql_radalarmQ.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		});
		//对jgGrid的操作符进行国际化
		var opr = $("#operation").val();
		//获取数据表对应字段国际化信息			
		var column  = '';
		var thisdata = loadData('radacct_alarm','<%=languageType %>',1);
		 
		column = thisdata.FieldName.join(',');			 					
		 
		var UserNameg=thisdata.getFieldAliasByFieldName('UserName');			 
		var AcctStartTimeg=thisdata.getFieldAliasByFieldName('AcctStartTime');
		var AcctStopTimeg=thisdata.getFieldAliasByFieldName('AcctStopTime');
		var AcctSessionTimeg=thisdata.getFieldAliasByFieldName('AcctSessionTime');
		var FramedIPAddressg=thisdata.getFieldAliasByFieldName('FramedIPAddress');
		
		var CallingStationIdg=thisdata.getFieldAliasByFieldName('CallingStationId');
		var NASIPAddressg=thisdata.getFieldAliasByFieldName('NASIPAddress');
		var NASPortIdg=thisdata.getFieldAliasByFieldName('NASPortId');
		var Realmg=thisdata.getFieldAliasByFieldName('Realm');
		var NASPortTypeg=thisdata.getFieldAliasByFieldName('NASPortType');
		
		var AcctInputOctetsg=thisdata.getFieldAliasByFieldName('AcctInputOctets');
		var AcctOutputOctetsg=thisdata.getFieldAliasByFieldName('AcctOutputOctets');
		var AcctTerminateCauseg=thisdata.getFieldAliasByFieldName('AcctTerminateCause');
		var ServiceTypeg=thisdata.getFieldAliasByFieldName('ServiceType');
		var FramedProtocolg=thisdata.getFieldAliasByFieldName('FramedProtocol');
		
		var FramedIPAddressg=thisdata.getFieldAliasByFieldName('FramedIPAddress');
		 
		$("#UserNameg").html(UserNameg);
		$("#AcctStartTimeg").html(AcctStartTimeg);
		$("#AcctStopTimeg").html(AcctStopTimeg);
		$("#AcctSessionTimeg").html(AcctSessionTimeg);
		$("#FramedIPAddressg").html(FramedIPAddressg);
		
		$("#CallingStationIdg").html(CallingStationIdg);
		$("#NASIPAddressg").html(NASIPAddressg);
		$("#NASPortIdg").html(NASPortIdg);
		$("#Realmg").html(Realmg); 
		$("#NASPortTypeg").html(NASPortTypeg);
		
		$("#AcctInputOctetsg").html(AcctInputOctetsg);  
		$("#AcctOutputOctetsg").html(AcctOutputOctetsg);
		$("#AcctTerminateCauseg").html(AcctTerminateCauseg); 
		$("#ServiceTypeg").html(ServiceTypeg);
		$("#FramedProtocolg").html(FramedProtocolg); 
		
		$("#FramedIPAddressg").html(FramedIPAddressg);
		//查询表单
		$("#UserNameg_a").html(UserNameg);
		$("#Realmg_a").html(Realmg); 
		
		var navv = document.location.search;
		var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));
		
		var col=[[],[]];
		 
		col=getRb_Field('radacct_alarm','RadAcctId',"详细",'97','ziduansF');//得到jqGrid要显示的字段
		 
		//获取查询字段信息
		var ziduan = $("#ziduansF").val();	
		//对待查询字段中的时间字段，进行处理，避免当其为'0000-00-00'的时候出错
		ziduan = ziduan.replace(new RegExp('AcctStartTime',"g"),"to_char(AcctStartTime,'yyyy-mm-dd hh24:mi:ss') as AcctStartTime");		
		ziduan = ziduan.replace(new RegExp('AcctStopTime',"g"),"to_char(AcctStopTime,'yyyy-mm-dd hh24:mi:ss') as AcctStopTime");
		//ziduan中包含特殊字符，需要对其进行转码
		tsd.QualifiedVal=true;		
		ziduan=tsd.encodeURIComponent(ziduan);
		if(tsd.Qualified()==false){return false;}
		$("#ziduansF").val(ziduan);	
		var column = $("#ziduansF").val();	
		 
		jQuery("#editgrid").jqGrid({
			url:'mainServlet.html?'+urlstr+'&column='+column,
			datatype: 'xml', 
			colNames:col[0], 
			colModel:col[1],
			       	rowNum:10, //默认分页行数
			       	rowList:[10,15,20], //可选分页行数
			       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
			       	pager: jQuery('#pagered'), 
			       	sortname: 'AcctStartTime', //默认排序字段
			       	viewrecords: true, 
			       	//hidegrid: false, 
			       	sortorder: 'desc',//默认排序方式 
			       	caption:infoo,				       	
			       	height:300, //高
			       //	width:document.documentElement.clientWidth-27,
			       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
										///自动适应 工作空间
										 var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										setAutoGridHeight("editgrid",reduceHeight);
										//setAutoGridWidth("editgrid",'0');
										/*********定义需要的行链接按钮************
										////@1  表格的id
										////@2  链接名称
										////@3  链接地址或者函数名称
										////@4  行主键列的名称 可以是隐藏列
										////@5  链接激活方式 枚举类型 href：为跳转页面 ，click：事件激活方式
										////@6  按钮的位置，，，不允许重复，不允许跳跃 范围 1+	
										//addRowOperBtn('editgrid',editinfo,'openRowModify','Zjjx','click',1);
										//addRowOperBtn('editgrid',deleteinfo,'deleteRow','Zjjx','click',2);
										*/
										var editinfo = $("#editinfo").val();
										var deleteinfo = $("#deleteinfo").val();
										//addRowOperBtnimage('editgrid','openRowModify','RadAcctId','click',1,"style/images/public/ltubiao_01.gif",editinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//修改
										//addRowOperBtnimage('editgrid','deleteRow','RadAcctId','click',2,"style/images/public/ltubiao_02.gif",deleteinfo,"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
										addRowOperBtnimage('editgrid','openRowInfo','RadAcctId','click',1,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;");//详细
																			
									   	/****执行行按钮添加********
										*@1 表格ID
										*@2 操作按钮数量 等于定义数量
										*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换
										*/																				
										executeAddBtn('editgrid',1);
									},
									ondblClickRow: function(ids) {
											if(ids != null) {
												var RadAcctId =$("#editgrid").getCell(ids,"RadAcctId");
												openRowInfo(RadAcctId);
											}
									}
			}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
				); 
	});
	/**
	 * 显示详细信息面板
	 * @param
	 * @return
	 */
	function openRowInfo(key){
			markTable(1);//显示红色*号	
			//设置编辑框的标题
			$(".top_03").html("详细信息");//标题
		 	//将修改面板的输入框全部	置为不可用	
			isDisabledN('radacct_alarm','','');
			clearText('operformT1');
			queryByID(key);
			openpan();
	}
		
	/**
	 * 修改面板显示数据
	 * @param
	 * @return
	 */
	function queryByID(key){ 	
		var urlstr=tsd.buildParams({  
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdcf:'mysql',//指向配置文件名称
							  tsdoper:'query',//操作类型 
							  datatype:'xmlattr',//返回数据格式 
							  tsdpk:'dbsql_radalarmQ.querybyid'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							});	
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&RadAcctId='+key,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
				$(xml).find('row').each(function(){
				
					//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
					///如果sql语句中指定列名 则按指定名称给参数
					
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
								//var Realm=$(this).attr("realm");
								 
								var ServiceType=$(this).attr("servicetype");
								var UserName=$(this).attr("username");
							/***************
								 UserNameg	AcctStartTimeg  AcctStopTimeg AcctSessionTimeg FramedIPAddressg
		CallingStationIdg NASIPAddressg  NASPortIdg Realmg  NASPortTypeg
		AcctInputOctetsg AcctOutputOctetsg AcctTerminateCauseg ServiceTypeg FramedProtocolg
		FramedIPAddressg
		**********************/	
								
								$("#AcctInputOctets").val(AcctInputOctets+'KB');
								$("#AcctOutputOctets").val(AcctOutputOctets+'KB');
								if(AcctSessionId!=null){
								$("#iAcctSessionId").val(AcctSessionId);
								}else{
								$("#iAcctSessionId").val("");
								
								}
								$("#AcctSessionTime").val(AcctSessionTime+'秒');
								if(AcctStartTime=='1990-01-01 00:00:00'){
								$("#AcctStartTime").val("");
								}else{
								$("#AcctStartTime").val(AcctStartTime);
								}
								if(AcctStopTime=='1990-01-01 00:00:00'){
								$("#AcctStopTime").val("");
								}else{
								$("#AcctStopTime").val(AcctStopTime);
								}
								if(AcctTerminateCause==null){
								$("#AcctTerminateCause").val("");
								}else{
								$("#AcctTerminateCause").val(AcctTerminateCause);
								}
								if(AcctUniqueId==null){
								$("#iAcctUniqueId").val("");
								}else{
								$("#iAcctUniqueId").val(AcctUniqueId);
								}
								if(CallingStationId==null){
								$("#CallingStationId").val("");
								}else{
								$("#CallingStationId").val(CallingStationId);
								}
								if(FramedIPAddress==null){
								$("#FramedIPAddress").val("");
								}else{
								$("#FramedIPAddress").val(FramedIPAddress);
								}
								if(FramedProtocol==null||FramedProtocol=='null'){
								$("#FramedProtocol").val("");
								}else{
								$("#FramedProtocol").val(FramedProtocol);
								}
								if(NASIPAddress==null){
								$("#NASIPAddress").val("");
								}else{
								$("#NASIPAddress").val(NASIPAddress);
								}
								if(NASPortId==null){
								$("#NASPortId").val("");
								}else{
								$("#NASPortId").val(NASPortId);
								}
								if(NASPortType==null){
								$("#NASPortType").val("");
								}else{
								$("#NASPortType").val(NASPortType);
								}
								/**
								if(Realm==null){
								$("#Realm").val("");
								}else{
								$("#Realm").val(Realm);
								}
								*/
								if(ServiceType==null||ServiceType=="null"){
								$("#ServiceType").val("");
								}else{
								$("#ServiceType").val(ServiceType);
								}
								if(UserName==null){
								$("#UserName").val("");
								}else{
								$("#UserName").val(UserName);
								}
				});
			}
		});
	}


	/**
	 * 执行复合操作
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
	 * 复合查询操作
	 * @param
	 * @return
	 */
	function fuheQuery()
	{
			var params = fuheQbuildParams();			
			if(params=='&fusearchsql='){
				params +='1=1';
			}	
			var column = $("#ziduansF").val();			
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mysql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'dbsql_radalarmQ.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'dbsql_radalarmQ.fuheQueryByWherepage'
										});
			var link = urlstr1 + params;	
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column+"&table=radacct_alarm"}).trigger("reloadGrid");
		 	setTimeout($.unblockUI, 15);//关闭面板	
		 	closeo();
	}


 
	/**
	 * 排序操作
	 * @param
	 * @return
	 */
	function zhOrderExe(sqlstr){
			var params = fuheQbuildParams();			
			if(params=='&fusearchsql='){
				params +='1=1';
			}
			params =params+'&orderby='+sqlstr;	
			var column = $("#ziduansF").val();			    
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mysql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'dbsql_radalarmQ.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'dbsql_radalarmQ.queryByOrderpage'
										});
			var link = urlstr1 + params;						
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column+"&table=radacct_alarm"}).trigger("reloadGrid");
		 	//jAlert("操作成功","操作提示");
			setTimeout($.unblockUI, 15);
	}  				
 
	/**
	 * 打开查询面板
	 * @param
	 * @return
	 */
	function openQuery(){
		 	$(".top_03").html('<fmt:message key="global.query" />');//标题		
		 	autoBlockFormAndSetWH('queryT',60,5,'closeoq',"#ffffff",true,1000,'');//弹出查询面板
			clearText('queryform');		
	}

	/**
	 * 拼接查询参数
	 * @param
	 * @return
	 */
	function QbuildParams()
	{	
		var UserName = $("#UserName_a").val().replace(/(^\s*)|(\s*$)/g,"");
	 	
	 	var paramsStr='1=1 ';
	 	if(UserName!=''){
	 	 	paramsStr+="and UserName = '"+UserName+"' ";
	 	}
	 	
	 	/**
	 	var Realm = $("#Realm_a").val().replace(/(^\s*)|(\s*$)/g,"");	 	
	 	if(Realm!=''){
	 		paramsStr+="and Realm like '%"+Realm+"%' " ;
	 	}
	 	**/	 	
	 	$("#fusearchsql").val(paramsStr);
	 	fuheQuery();	 
	}

	/**
	 * 拼接复合查询参数
	 * @param
	 * @return
	 */
	function fuheQbuildParams(){
		 	//每次拼接参数必须初始化此参数
			tsd.QualifiedVal=true;
		 	var params='';
		 	
		 	//如果有可能值是汉字 请使用encodeURI()函数转码
		 	var fusearchsql = encodeURIComponent($("#fusearchsql").val());			 	
		 	params+='&fusearchsql='+fusearchsql;
		 			 	
		 	//注意：不要在此做空的判断 即使为空 也必须放入请求中			 	
		 	//每次拼接参数必须添加此判断
			if(tsd.Qualified()==false){return false;}
			return params;
	}	
	
</script>
 <script type="text/javascript">    
		/**
		拼接要显示的数据列main.js中有关导出数据的函数是
		thisDataDownload,checkedAllFields,getTheCheckedFields,
		***/
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
										var thefieldalias = getCaption($(this).attr("field_alias"),'<%=languageType %>','');
										
										if(thefieldalias!=''){
											thefieldalias=thefieldalias.replace(new RegExp(" ","g"),"");											
											if(thefieldname=='AcctStartTime'||thefieldname=='AcctStopTime'){
												thefieldname = "to_char("+thefieldname+",'YYYY-MM-DD HH24:MI:SS') ";	
												thefieldname=tsd.encodeURIComponent(thefieldname);											
											}
											var disvalue='';
											if(thefieldalias=='' || thefieldalias==undefined){
												disvalue = thefieldname ;
											}
											else{
												disvalue = thefieldname + ' as ' + tsd.encodeURIComponent(thefieldalias);
											}
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
	 * 关闭面板
	 * @param
	 * @return
	 */
	function closeo(){		
		setTimeout($.unblockUI, 15);//关闭面板		
		clearText('operformT1');
	}

	/**
	 * 打开详细面板
	 * @param
	 * @return
	 */
	function openpan(){		
			autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板			
	}


</script>

<script type="text/javascript">
	/**
	 * 页面加载时执行
	 * @param
	 * @return
	 */
	jQuery(document).ready(function(){
		/***********************
		//获取系统语言标识
		var languageType = $("#languageType").val();
		//获取本菜单id
		var imenuid = $('#imenuid').val();
		//获取组信息
		var groupid = $('#zid').val();
		//获取菜单并解析		
		getTariffBar(languageType,imenuid,'Repeaters.getNavigator',groupid);
		**********************/						
	});	


</script>

</head>
<style type="text/css">
		.style1 {
			background-color: #A9C3E8;
			padding: 4px;
		}
		#navBar1{  height:26px;background:url(style/imgs/daohangbg.jpg); line-height:28px;}
		cas{float:left; width:100%; height:26px;background:url(../imgs/daohangbg.jpg) repeat-x; line-height:28px;}
</style>
 
	<body >	
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
			
		<!-- 用户操作标题以及放一些快捷按钮-->
		<div id="buttons">			
			<button type="button" id="order1" onclick="openDiaO('radacct_alarm');" >
				<!-- 组合排序 -->	<fmt:message key="order.title" />
			</button>
			
			<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='openQueryM(1);' id='mbquery1'>
			<!-- 模板查询 -->	<fmt:message key="oper.mod"/>
			</button>			
			<button type="button" id='gjquery1' onclick="openDiaQueryG('query','radacct_alarm');" disabled="disabled">
				<!--高级查询-->	<fmt:message key="oper.queryA"/>			
			</button>
			<button type="button" id='savequery1' onclick="openModT();" disabled="disabled">
				<!-- 将本查询保存为模板  --> <fmt:message key="oper.modSave"/>
			</button>			
			
			<button type="button" id="export1"  onclick="thisDownLoad('tsdBilling','mssql','radacct_alarm','<%=languageType %>')" 
				disabled="disabled">
				<!--导出-->
				<fmt:message key="global.exportdata" />
			</button>
			<button type="button" id="print1" onclick="printThisReport1('<%=request.getParameter("imenuid")%>','radacct_alarm',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');"  disabled="disabled">
				<!--打印-->
				<fmt:message key="tariff.printer" />
			</button>
		</div>
		
		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>
		<!-- 用户操作标题以及放一些快捷按钮-->
		<div id="buttons">
			<button type="button" id="order1" onclick="openDiaO('radacct_alarm');">
				<!--组合排序-->
				<fmt:message key="order.title" />
			</button>
			
			<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button onclick='openQueryM(1);' id='mbquery2'><fmt:message key="oper.mod"/></button>
			<button type="button" id='gjquery2' onclick="openDiaQ('query','radacct_alarm');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button type="button" id='savequery2' onclick="openModT();" disabled="disabled">
				<fmt:message key="oper.modSave"/>
			</button>			
			<button type="button" id="export2" onclick="thisDownLoad('tsdBilling','mssql','radacct_alarm','<%=languageType %>')" 
				disabled="disabled">
				<!--导出-->
				<fmt:message key="global.exportdata" />
			</button>
			<button type="button" id="print2" onclick="printThisReport1('<%=request.getParameter("imenuid")%>','radacct_alarm',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');"  disabled="disabled">
				<!--打印-->
				<fmt:message key="tariff.printer" />
			</button>
		</div>	
	</div>
	
	 <!-- 简单查询表单 -->

		<div class="neirong" id="queryT" style="display: none">
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
				<form id="queryform" name="queryform" onsubmit="return false;" action="#" >
					<table width="100%" border="0" cellspacing="0" cellpadding="0"
						style="line-height: 33px; font-size: 12px;">
						<tr>
							<td width="12%" align="right" class="labelclass">
								<label id="UserNameg_a"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" id="UserName_a" class="textclass" />
							</td>
							<!-- 
							<td width="12%" align="right" class="labelclass">
								<label id="Realmg_a"></label>
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
								<input type="text" id="Realm_a" class="textclass" />
							</td>
							 -->
							 <td width="12%" align="right" class="labelclass">
							</td>
							<td width="22%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
							</td>
							
							<td width="12%" align="right" class="labelclass">
							</td>
							<td width="20%" align="left"
								style="border-bottom: 1px solid #A9C8D9;">
							</td>
						</tr>
					</table>
				</form>

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



		<!-- 显示详细信息表单 -->
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
			<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
				<input type="hidden" ></input>
				<table width="100%" id="tdiv" border="0" cellspacing="0"
					cellpadding="0" style="line-height: 33px; font-size: 12px;">
					<tr>
						<td width="12%" align="right" class="labelclass"><label id="UserNameg"></label></td>
						<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="UserName" class="textclass2" disabled="disabled" />
						</td>						
						<td width="12%" align="right" class="labelclass">
							<label id="FramedIPAddressg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="FramedIPAddress" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="NASIPAddressg"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="NASIPAddress" class="textclass2"
								disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="NASPortIdg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="NASPortId" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="NASPortTypeg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="NASPortType" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="AcctStartTimeg"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="AcctStartTime" class="textclass2"
								disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="AcctStopTimeg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="AcctStopTime" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="AcctSessionTimeg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="AcctSessionTime" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="AcctInputOctetsg"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="AcctInputOctets" class="textclass2"
								disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="AcctOutputOctetsg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="AcctOutputOctets" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="CallingStationIdg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="CallingStationId" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="AcctTerminateCauseg"></label>
						</td>
						<td width="20%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="AcctTerminateCause" class="textclass2"
								disabled="disabled" />
						</td>
					</tr>
					<tr>
						<td width="12%" align="right" class="labelclass">
							<label id="ServiceTypeg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="ServiceType" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id="FramedProtocolg"></label>
						</td>
						<td width="22%" align="left"
							style="border-bottom: 1px solid #A9C8D9;">
							<input type="text" id="FramedProtocol" class="textclass2"
								disabled="disabled" />
						</td>
						<td width="12%" align="right" class="labelclass">
							<label id=""></label>
						</td>
						<td width="20%" align="left"style="border-bottom: 1px solid #A9C8D9;">
						</td>
					</tr>



				</table>
				</form>
				<div class="midd_butt">
					<!-- 关闭 -->
					<button class="tsdbutton" id="closeo"
						style="width: 63px; heigth: 27px;" onclick="closeo()">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>



		<!-- 添加模板面板 -->
<div id="modT" name='modT' style="display: none"  class="neirong">
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
		<input type="hidden" ></input>
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr>
				    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="name_mod" id="name_mod" maxlength="50" onpropertychange="TextUtil.NotMax(this)" class="textclass" />
				    	<font style="color: #ff0000;">*</font></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id=''></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
					
				    <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			 	 </tr>	  
			</table>
		</form>
		<div class="midd_butt">
		<!-- 保存 --><button class="tsdbutton" id="saveModB" style="width:80px;heigth:27px;" onclick="saveModQuery(1);" ><fmt:message key="global.save" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" id="closeModB" style="width:63px;heigth:27px;" onclick="closeoMod();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>			
			
<div style="display: none">
			<form name="childform" id="childform">
				<input type="text" id="queryName" name="queryName" value="" style="display: none" />
				<input type="text" id="fusearchsql" name="fusearchsql" style="display: none" />
			</form>
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

			<input type="hidden" id="addright" />
			<input type="hidden" id="deleteright" />
			<input type="hidden" id="editright" />
			<input type="hidden" id="editfields" />
			<input type="hidden" id="delBright" />
			<input type="hidden" id="editBright" />
			<input type="hidden" id="exportright" />
			<input type="hidden" id="printright" />
			
			
			<!-- 用于写入日志 -->
			<input type="hidden" id="userloginip" value="<%=Log.getIpAddr(request)%>" />
			<input type="hidden" id="userloginid" value="<%=session.getAttribute("userid")%>" />
			<input type="hidden" id="thislogtime" value="<%=Log.getThisTime()%>" />
			<!-- 修改时保存原来数据的隐藏域 -->
			<input type="hidden" id="logoldstr" />
			<input type="hidden" id="useridd" value="<%=userid %>"/>	
			
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
			<input type="hidden" id='ziduansF' />
			<input type='hidden' id='thecolumn'/>		
		

		
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
									<div id="thelistform" style="margin-left: 10px;max-height: 200px: overflow-y:scroll;">
								
									</div>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields()">
						全选
					</button>
					<button type="submit" class="tsdbutton" id="query" onclick="getTheCheckedFields('broadband','mysql','radacct_alarm');">
						<fmt:message key="global.ok" />
					</button>
					<button type="button" class="tsdbutton" id="closethisinfo" >
						<fmt:message key="global.close" />
					</button>
					
				</div>
		</div>	
		
		<input type="hidden" id="whickOper"/>
	</body>
</html>
