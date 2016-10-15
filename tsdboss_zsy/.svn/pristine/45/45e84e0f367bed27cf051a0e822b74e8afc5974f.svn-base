<%----------------------------------------
	name: broadband/usercat/raddelUserQ.jsp
	Function:  宽带销户日志查询 Broadband households log sales inquiries
	author: 吴长龙
	version: 1.0, 2010-11-3
	description:   
	modify: 
		2010-11-3 吴长龙 添加注释
		2010-11-08  chenze  添加方法参数
		2010-11-29  chenze  修改数据导出数据来源为视图v_radcheck_del
		
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
    <title>Broadband households log sales inquiries</title>
  		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script type="text/javascript" src="plug-in/jquery/jquery.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/jquery.jqGrid.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/js/jqModal.js" ></script>
		<script type="text/javascript" src="plug-in/jquery/jqgrid/js/jqDnR.js" ></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="script/public/mainStyle.js" ></script>
		<!-- 验证框架需要导入的js文件 -->
		<script type="text/javascript" src="plug-in/jquery/validate/jquery.validate.js" ></script>
		<link rel="stylesheet" type="text/css" media="screen" href="../../js/validate/css/screen.css" />
		<!-- 弹出面板需要导入js文件 -->
		<script type="text/javascript" src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" ></script>
		
		<!-- 弹出对话框需要导入的js文件 -->			
		<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
		<script type="text/javascript" src="plug-in/jquery/jquery.alerts/jquery.alerts.js" ></script>
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
		<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
		<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />
			
		<!-- 本项目引入 -->
		<script type="text/javascript" src="script/usercat/main.js"></script>
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/public.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<!-- 日志 
		<script src="js/split/main.js" type="text/javascript"></script> -->
		<!-- 验证数据长度 -->
		<script src="plug-in/jquery/validate/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script type="text/javascript" src="script/public/infotest.js"></script>
		
		<!-- 导航 -->
		<script src="script/public/revenue.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="plug-in/jquery/validate/public.js" type="text/javascript"></script>
		<!-- 新的面板样式 -->
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />			
		
		<style type="text/css">
			#navBar1{  height:26px;background:url(style/imgs/daohangbg.jpg); line-height:28px;}
			cas{float:left; width:100%; height:26px;background:url(../imgs/daohangbg.jpg) repeat-x; line-height:28px;}
		</style>
		
<script type="text/javascript">

	/**
	 * 获取用户权限
	 * @param
	 * @return
	 */
	function getUserPower(){
				var urlstr=buildParamsPro("raddelUserQ.getPower","query");				
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
						editfields = getFields('vw_radhuizong');
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


//对 getRb_Field 方法中生成的sql查询内容的时间不分的替换。
	/**
	 * 获取用户权限
	 * @param
	 * @return
	 */
function changeColumn(column){
	var columnsql=[];
	var columnA = column.split(",");
	for(var i=0;i<columnA.length;i++){
	
		//iFeeTypeTime,feeendtime,sRegDate,PauseStopTime,PauseStartTime,AcctStopTime,AcctStartTime,DelTime
		if('DelTime'==columnA[i]||'AcctStartTime'==columnA[i]||'AcctStopTime'==columnA[i]||'PauseStartTime'==columnA[i]||'PauseStopTime'==columnA[i]||'sRegDate'==columnA[i]||'feeendtime'==columnA[i]||columnA[i]=='iFeeTypeTime'){
			columnA[i]="to_char("+columnA[i]+",'yyyy-mm-dd hh24:mi:ss') as "+columnA[i];
		}	
		//从表radusertype中获取用户类型(usertype)
		if('sDh1'==columnA[i])
		{
			columnA[i]='usertype';
		}
		///从表tbl_isplist中获取计费规则(feename)
		if('iFeeType'==columnA[i])
		{
			columnA[i]='feename';
		}
		columnsql.push(columnA[i]);
	}	
 	return columnsql;
}
</script>	
<script type="text/javascript">
	/**
	 * 初始化计费规则
	 * @param
	 * @return
	 */
	 function getFeeName(){
				//var urlstr=buildParamsSqlByS('tsdBilling','query','xmlattr','raddelUserQ.getFeeName','');
				//计费规则列表
 						var urlstr=tsd.buildParams({ packgname:'service',//java包
								 			 clsname:'ExecuteSql',//类名
								 			 method:'exeSqlData',//方法名
								 			 ds:'broadband',
								 			 tsdcf:'mysql',//指向配置文件名称
								 			 tsdoper:'query',//操作类型 
								 			 datatype:'xmlattr',//返回数据格式 
								 			 tsdpk:'dbsql_raddelUserQ.getFeeName'
				 		 });
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
                   				var area="<option value='"+$(this).attr("feecode")+"'>"+$(this).attr("feename")+"</option>";
								$("#iFeeType").html($("#iFeeType").html()+area);
								$("#iFeeType1").html($("#iFeeType1").html()+area);
								$("#iFeeStopType").html($("#iFeeStopType").html()+area);
							});
					}
				});
		}
				
	/**
	 * 初始化用户类型
	 * @param
	 * @return
	 */
	 function getUserType(){
				//var urlstr=buildParamsSqlByS('tsdBilling','query','xmlattr','dbsql_raddelUserQ.getUserType','');
				//计费规则列表
 						var urlstr=tsd.buildParams({ packgname:'service',//java包
								 			 clsname:'ExecuteSql',//类名
								 			 method:'exeSqlData',//方法名
								 			 ds:'broadband',
								 			 tsdcf:'mysql',//指向配置文件名称
								 			 tsdoper:'query',//操作类型 
								 			 datatype:'xmlattr',//返回数据格式 
								 			 tsdpk:'dbsql_raddelUserQ.getUserType'
				 		 });
				$.ajax({
					url:'mainServlet.html?'+urlstr,
					datatype:'xml',
					cache:false,//如果值变化可能性比较大 一定要将缓存设成false
					timeout: 1000,
					async: false ,//同步方式
					success:function(xml){
							$(xml).find('row').each(function(){
                   				var area="<option value='"+$(this).attr("typeid")+"'>"+$(this).attr("usertype")+"</option>";
								$("#sDh1").html($("#sDh1").html()+area);
							});
					}
				});
		}
	/**
	 * 根据工号取用户姓名
	 * @param
	 * @return
	 */
	function getUserName(userid){
			var urlstr=buildParamsSqlByS('tsdBilling','query','xmlattr','dbsql_raddelUserQ.getUserName','');
			var username ='';
			$.ajax({
				url:'mainServlet.html?'+urlstr+"&userid="+userid,
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
						$(xml).find('row').each(function(){
								username = $(this).attr("username")+"("+$(this).attr("userid")+")";		
						 });
				}
			});
			return username;
	}	

		/**
		 * 查询用户是否处于停机保号状态
		 * @param
		 * @return
		 */
       function quereyshiftj(){
	        var result;
	        var UserName = $("#UserName").val();           
	           var urlstr=tsd.buildParams({packgname:'service',//java包
			 					clsname:'ExecuteSql',//类名
			 					method:'exeSqlData',//方法名
			 					ds:'broadband',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			 					tsdcf:'mysql',//指向配置文件名称
			 					tsdoper:'query',//操作类型 
			 					datatype:'xmlattr',
			 					tsdpk:'UserChanager.shifoubanli'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 				});						
	               $.ajax({
		              url:'mainServlet.html?'+urlstr+'&UserName='+UserName,
		              datatype:'xml',
		              cache:false,//如果值变化可能性比较大 一定要将缓存设成false
		              timeout: 1000,
		              async: false ,//同步方式
		              success:function(xml){
		              $(xml).find('row').each(function(){	
							result=$(this).attr("result");								    
				      });
				      }
				});
			return result;		
      }	
</script>	
<script type="text/javascript">
	
	/**
	 * 页面加载时执行
	 * @param
	 * @return
	 */
jQuery(document).ready(function () {
		//页面表头当前位置显示
		$("#navBar1").append(genNavv());
		getFeeName();//初始化计费规则
		getUserType();//初始化用户类型
		/**********************
		**   取得当前用户的权限  *
		**********************/
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
		
		if(exportright=="true"){
			document.getElementById("export1").disabled=false;
			document.getElementById("export2").disabled=false;
		}
		if(printright=="true"){
			document.getElementById("print1").disabled=false;
			document.getElementById("print2").disabled=false;
		}
		/////设置命令参数
		 var urlstr=tsd.buildParams({ packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mysql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
												tsdpk:'dbsql_raddelUserQ.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'dbsql_raddelUserQ.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
											});											
												
			//对jgGrid的操作符进行国际化
			var opr = $("#operation").val();
			var cloumn  = '';
			var thisdata = loadData('radcheck_del','<%=languageType %>',1);	
			cloumn = thisdata.FieldName.join(',');	
			
			$("#thecloumn").val(cloumn);
			var col=[[],[]];
			col=getRb_Field('radcheck_del','id',"详细",'70','ziduansF','DelTime','UserName');//得到jqGrid要显示的字段
			var column = $("#ziduansF").val();
		
			column= changeColumn(column);
			$("#ziduansF").val(column);

			var UserNameg=thisdata.getFieldAliasByFieldName('UserName');$("#UserNameg").html(UserNameg);
			var Valueg=thisdata.getFieldAliasByFieldName('Value');$("#Valueg").html(Valueg);
			var ipaddrg=thisdata.getFieldAliasByFieldName('ipaddr');$("#ipaddrg").html(ipaddrg);
			var vlanidg=thisdata.getFieldAliasByFieldName('vlanid');$("#vlanidg").html(vlanidg);
			var AcctStartTimeg=thisdata.getFieldAliasByFieldName('AcctStartTime');$("#AcctStartTimeg").html(AcctStartTimeg);
			var AcctStopTimeg=thisdata.getFieldAliasByFieldName('AcctStopTime');$("#AcctStopTimeg").html(AcctStopTimeg);
			var PauseStartTimeg=thisdata.getFieldAliasByFieldName('PauseStartTime');$("#PauseStartTimeg").html(PauseStartTimeg);
			var PauseStopTimeg=thisdata.getFieldAliasByFieldName('PauseStopTime');$("#PauseStopTimeg").html(PauseStopTimeg);
			var linkphoneg=thisdata.getFieldAliasByFieldName('linkphone');$("#linkphoneg").html(linkphoneg);
			var linkmang=thisdata.getFieldAliasByFieldName('linkman');$("#linkmang").html(linkmang);
			var PayTypeg=thisdata.getFieldAliasByFieldName('PayType');$("#PayTypeg").html(PayTypeg);
			var iFeeTypeg=thisdata.getFieldAliasByFieldName('iFeeType');$("#iFeeTypeg").html(iFeeTypeg);
			var iFeeStopTypeg=thisdata.getFieldAliasByFieldName('iFeeStopType');$("#iFeeStopTypeg").html(iFeeStopTypeg);
			var sDhg=thisdata.getFieldAliasByFieldName('sDh');$("#sDhg").html(sDhg);
			var sRegDateg=thisdata.getFieldAliasByFieldName('sRegDate');$("#sRegDateg").html(sRegDateg);
			var sRealNameg=thisdata.getFieldAliasByFieldName('sRealName');$("#sRealNameg").html(sRealNameg);
			var sBmg=thisdata.getFieldAliasByFieldName('sBm');$("#sBmg").html(sBmg);
			var sAddressg=thisdata.getFieldAliasByFieldName('sAddress');$("#sAddressg").html(sAddressg);
			var iStatusg=thisdata.getFieldAliasByFieldName('iStatus');$("#iStatusg").html(iStatusg);
			var iMacAutoBandg=thisdata.getFieldAliasByFieldName('iMacAutoBand');$("#iMacAutoBandg").html(iMacAutoBandg);
			var iSimultaneousg=thisdata.getFieldAliasByFieldName('iSimultaneous');$("#iSimultaneousg").html(iSimultaneousg);
			var RemainTimeg=thisdata.getFieldAliasByFieldName('RemainTime');$("#RemainTimeg").html(RemainTimeg);
			var thismonthtimeg=thisdata.getFieldAliasByFieldName('thismonthtime');$("#thismonthtimeg").html(thismonthtimeg);
			var nextmonthtimeg=thisdata.getFieldAliasByFieldName('nextmonthtime');$("#nextmonthtimeg").html(nextmonthtimeg);
			var totaltimeg=thisdata.getFieldAliasByFieldName('totaltime');$("#totaltimeg").html(totaltimeg);
			var feeendtimeg=thisdata.getFieldAliasByFieldName('feeendtime');$("#feeendtimeg").html(feeendtimeg);
			var iFeeTypeTimeg=thisdata.getFieldAliasByFieldName('iFeeTypeTime');$("#iFeeTypeTimeg").html(iFeeTypeTimeg);
			var iFeeType1g=thisdata.getFieldAliasByFieldName('iFeeType1');$("#iFeeType1g").html(iFeeType1g);
			var sDh1g=thisdata.getFieldAliasByFieldName('sDh1');$("#sDh1g").html(sDh1g);
			var sDh2g=thisdata.getFieldAliasByFieldName('sDh2');$("#sDh2g").html(sDh2g);
			var UserName1g=thisdata.getFieldAliasByFieldName('UserName1');$("#UserName1g").html(UserName1g);
			var RemainFeeg=thisdata.getFieldAliasByFieldName('RemainFee');$("#RemainFeeg").html(RemainFeeg);
			var speedg=thisdata.getFieldAliasByFieldName('speed');$("#speedg").html(speedg);
			var idcardg=thisdata.getFieldAliasByFieldName('idcard');$("#idcardg").html(idcardg);
			var idtypeg=thisdata.getFieldAliasByFieldName('idtype');$("#idtypeg").html(idtypeg);
			var mobileg=thisdata.getFieldAliasByFieldName('mobile');$("#mobileg").html(mobileg);
			var DelTimeg=thisdata.getFieldAliasByFieldName('DelTime');$("#DelTimeg").html(DelTimeg);
			var sUserIDg=thisdata.getFieldAliasByFieldName('sUserID');	$("#sUserIDg").html(sUserIDg);
			//memog	销户原因
			var memog=thisdata.getFieldAliasByFieldName('memo');	
			$("#memog").html(memog);
			
			$("#sAddressg_a").html(sAddressg);
			$("#UserNameg_a").html(UserNameg);
			$("#sRealNameg_a").html(sRealNameg);
			$("#sDhg_a").html(sDhg);
		
			//grid标题获取
			var navv = document.location.search;
			var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));
			//$("#123").val(thisdata.colNames);
			//$("#124").val(thisdata.colModels);
			//$("#125").val(cloumn);
			
		jQuery("#editgrid").jqGrid({		
				/*执行存储过程---------------- 
				tsdpname：可以调用其他存储过程，
				注意：tsdpname不是真正对应存储过程名称 而是通过系统进行映射，查看映射名请参照 存储过程维护页
				ds：对应applicationContent.xml里配置的数据源 
				*/
				
				url:'mainServlet.html?'+urlstr+'&column='+encodeURIComponent(column),
				datatype:'xml', 
				//colNames:thisdata.colNames, 
				//colModel:thisdata.colModels,				
				colNames:col[0],
				colModel:col[1],				 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'UserName', //默认排序字段
				       	viewrecords: true, 
				       	//hidegrid: false, 
				       	sortorder: 'asc',//默认排序方式 
				       	caption:infoo, 
				       	height:300, //高
				       	//width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
										$("#editgrid").setSelection('0', true);
										$("#editgrid").focus();
									
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
									
										
										///自动适应 工作空间
										 var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
										 setAutoGridHeight("editgrid",reduceHeight);
										 
										addRowOperBtnimage('editgrid','openRowInfo','id','click',1,'style/images/public/ltubiao_03.gif',"详细","&nbsp;&nbsp;&nbsp;",'DelTime','UserName');//详细
										executeAddBtn('editgrid',1);
										},
										ondblClickRow: function(ids) {
												if(ids != null) {
													var id =$("#editgrid").getCell(ids,"id");
													var DelTime =$("#editgrid").getCell(ids,"DelTime");
													var UserName =$("#editgrid").getCell(ids,"UserName");
													openRowInfo(id,DelTime,UserName);
												}
										}
				}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
			});
	/**
	 * 显示详细信息
	 * @param
	 * @return
	 */
	function openRowInfo(key1,key2,key3){
			markTable(1);//显示红色*号
			//设置编辑框的标题
			$(".top_03").html("详细信息");//标题
		 	//将修改面板的输入框全部	置为不可用
			isDisabledN('radcheck_del','',''); 
			clearText('operformT1');
			queryByID(key1,key2,key3);
			openpan();
	}
 
		

	/**
	 * 修改时取数据
	 * @param key1  ID
 	 * @param key2  拆机日期
 	 * @param key3  用户账号
	 * @return
	 */
	function queryByID(key1,key2,key3){
 			
		var urlstr=tsd.buildParams({  
							  packgname:'service',//java包
							  clsname:'ExecuteSql',//类名
							  method:'exeSqlData',//方法名
							  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							  tsdcf:'mysql',//指向配置文件名称							 
							  tsdoper:'query',//操作类型 
							  datatype:'xmlattr',//返回数据格式 
							  tsdpk:'dbsql_raddelUserQ.queryByKey'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							});	
		$.ajax({
			url:'mainServlet.html?'+urlstr+'&id='+key1+'&DelTime='+key2+'&UserName='+key3,
			datatype:'xml',
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(xml){
				//只有 url参数中 datatype="xmlattr"时才可以这样通过属性取值
				$(xml).find('row').each(function(){
				
					//$(this).attr(参数) 参数对应的数据库中的列名 默认小写 
					///如果sql语句中指定列名 则按指定名称给参数	
					var sAddress = $(this).attr("ssddress");							
					$("#sAddress").val(sAddress);					
					var sBm = $(this).attr("sbm");
					$("#sBm").val(sBm);					
					var sDh = $(this).attr("sdh");
					$("#sDh").val(sDh);
					
					var sDh1 = $(this).attr("sdh1");							
					$("#sDh1").val(sDh1);					
					var sDh2 = $(this).attr("sdh2");
					$("#sDh2").val(sDh2);					
					var UserName = $(this).attr("username");
					$("#UserName").val(UserName);
					
					var sRealName = $(this).attr("srealname");							
					$("#sRealName").val(sRealName);					
					var sRegDate = $(this).attr("sregdate");
					$("#sRegDate").val(sRegDate);					
					var sUserID = $(this).attr("suserid");
					var sUserName = getUserName(sUserID);
					$("#sUserID").val(sUserName);

					var AcctStartTime = $(this).attr("acctstarttime");							
					$("#AcctStartTime").val(AcctStartTime);					
					var AcctStopTime = $(this).attr("acctstoptime");
					$("#AcctStopTime").val(AcctStopTime);					
					var DelTime = $(this).attr("seltime");
					$("#DelTime").val(DelTime);
					
					var feeendtime = $(this).attr("feeendtime");							
					$("#feeendtime").val(feeendtime);					
					var idcard = $(this).attr("idcard");
					$("#idcard").val(idcard);					
					var idtype = $(this).attr("idtype");
					$("#idtype").val(idtype);

					var iFeeStopType = $(this).attr("ifeestoptype");							
					$("#iFeeStopType").val(iFeeStopType);					
					var iFeeType = $(this).attr("ifeetype");
					$("#iFeeType").val(iFeeType);					
					var iFeeType1 = $(this).attr("ifeetype1");
					$("#iFeeType1").val(iFeeType1);
					
					var iFeeTypeTime = $(this).attr("ifeetypetime");							
					$("#iFeeTypeTime").val(iFeeTypeTime);					
					var iMacAutoBand = $(this).attr("imacautoband");
					$("#iMacAutoBand").val(iMacAutoBand);					
					var ipaddr = $(this).attr("ipaddr");
					$("#ipaddr").val(ipaddr);
					
					var iSimultaneous = $(this).attr("isimultaneous");							
					$("#iSimultaneous").val(iSimultaneous+'人');					
					var iStatus = $(this).attr("istatus");
					//$("#iStatus").val(iStatus);		
					var iStatusname='';
					if(iStatus==0){
					//正常
					 var result=quereyshiftj();
					  if(result>0){
					    iStatusname='申请停机';
					   // $("#iStatus").html("<option value='"+iStatus+"' selected=true>"+iStatusname+"</option>");
					  }else{
					    iStatusname='正常';
					    //$("#iStatus").html("<option value='"+iStatus+"' selected=true>"+iStatusname+"</option>");					    
					  }
					}
					if(iStatus==1){
						//锁定
						iStatusname='锁定';
						//$("#iStatus").html("<option value='"+iStatus+"' selected=true>"+iStatusname+"</option>");						
					}
					if(iStatus==2){
						iStatusname='欠费';
						//$("#iStatus").html("<option value='"+iStatus+"' selected=true>"+iStatusname+"</option>");
					}
					$("#iStatus").val(iStatusname);
										
					var linkman = $(this).attr("linkman");
					$("#linkman").val(linkman);
					
					var linkphone = $(this).attr("linkphone");							
					$("#linkphone").val(linkphone);					
					var mobile = $(this).attr("mobile");
					$("#mobile").val(mobile);					
					var nextmonthtime = $(this).attr("nextmonthtime");
					$("#nextmonthtime").val(nextmonthtime+'秒');
					
									
					var PauseStartTime = $(this).attr("pausestarttime");
					$("#PauseStartTime").val(PauseStartTime);					
					var PauseStopTime = $(this).attr("pausestoptime");
					$("#PauseStopTime").val(PauseStopTime);
					
					//var PayType = $(this).attr("PayType");							
					//$("#PayType").val(PayType);					
					var RemainFee = $(this).attr("remainfee");
					$("#RemainFee").val(RemainFee+'元');					
					var RemainTime = $(this).attr("remaintime");
					$("#RemainTime").val(RemainTime+'秒');
					
					var thismonthtime = $(this).attr("thismonthtime");							
					$("#thismonthtime").val(thismonthtime+'秒');					
					var totaltime = $(this).attr("totaltime");
					$("#totaltime").val(totaltime+'秒');					
					var speed = $(this).attr("speed");
					var speedM = calBSpeed(speed);
					$("#speed").val(speedM);
					
					var UserName1 = $(this).attr("username1");							
					$("#UserName1").val(UserName1);					
					var Value = $(this).attr("value");
					$("#Value").val(Value);					
					var vlanid = $(this).attr("vlanid");
					$("#vlanid").val(vlanid);
					
					var memo = $(this).attr("memo");
					$("#memo").val(memo);
					//memog					
				});
			}
		});
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
	 * 在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
	 * @param key 
	 * @return
	 */
	function querylist(key){	
		//在调用此方法是清空符合查询的查询条件，避免导出或打印时显示信息有误
		$("#fusearchsql").val("");
				
		urlstr=tsd.buildParams({  packgname:'service',//java包
												  clsname:'ExecuteSql',//类名
												  method:'exeSqlData',//方法名
												  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												  tsdcf:'mysql',//指向配置文件名称
												  tsdoper:'query',//操作类型 
												  datatype:'xml',//返回数据格式 
												  tsdpk:'dbsql_raddelUserQ.queryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												  tsdpkpagesql:'dbsql_raddelUserQ.queryByWherepage'
												});
			
			var column = $("#ziduansF").val();
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&column='+encodeURIComponent(column)}).trigger("reloadGrid");
			setTimeout($.unblockUI, 15);//关闭面板	
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
			var thecloumn =$("#thecloumn").val();		
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mysql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'dbsql_raddelUserQ.fuheQueryByWhere',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'dbsql_raddelUserQ.fuheQueryByWherepage'
										});
			var column = $("#ziduansF").val();
			var link = urlstr1 + params+'&column='+encodeURIComponent(column);	
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
		 	setTimeout($.unblockUI, 15);//关闭面板			
	}
           
	/**
	 * 组合排序操作
	 * @param
	 * @return
	 */
	function zhOrderExe(sqlstr){
			var thecloumn =$("#thecloumn").val();
			var params = fuheQbuildParams();			
			if(params=='&fusearchsql='){
				params +='1=1';
			}
			 params =params+'&orderby='+sqlstr;		    
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mysql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'dbsql_raddelUserQ.queryByOrder',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'dbsql_raddelUserQ.queryByOrderpage'
										});
			var column = $("#ziduansF").val();
			var link = urlstr1 + params+'&column='+encodeURIComponent(column);						
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
		 	//setTimeout($.unblockUI, 15);//关闭面板	 	
	}

			
	/**
	 * 获取复合查询参数
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
	 * 打开简单查询面板
	 * @param
	 * @return
	 */
	function openQuery(){		
		 	$(".top_03").html('<fmt:message key="global.query" />');//标题		
		 	openQueryT();
			clearText('queryform');
	} 
	
	/**
	 * 拼接参数
	 * @param
	 * @return
	 */
	 function QbuildParams(){ 
		 	var UserName = delTrim($("#UserName_a").val());
		 	var sRealName = delTrim($("#sRealName_a").val());
		 	var sDh = delTrim($("#sDh_a").val());
		 	var sAddress = delTrim($("#sAddress_a").val());
				
			var paramsStr='1=1 ';
		 	if(UserName!=''){
		 	 	paramsStr+="and UserName = '"+UserName+"' ";
		 	}
		 	if(sRealName!=''){
		 		paramsStr+="and sRealName = '"+sRealName+"' " ;
		 	}
		 	if(sDh!=''){
		 		paramsStr+="and sDh = '"+sDh+"' " ;
		 	}
		 	if(sAddress!=''){
		 		paramsStr+="and sAddress = '"+sAddress+"' " ;
		 	}
		 	
		 	$("#fusearchsql").val(paramsStr);
		 	fuheQuery();
	}

	/**
	 * 根据表名显示可导出的数据列 
	 * @param tablename 表名称
	 * @return
	 */
	function displayFields(tablename){
			var thearr = [];
			var  languageType = $("#languageType").val();
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
	
	/**
	 * 数据导出
	 * @param 
	 * @return 
	 */
	function getTheCheckedFields(ds,tsdcf,table,table2,flagfield){
		var thename=document.getElementsByName('thefields');  					
		var thevalue = '';
		var theclos = '';
		var atable = table;
		if(table2!=undefined){
			atable = table2;
		}
		var arr = displayFields(atable);
		
		var limitarr = thename.length;
		//如果字段较多则只取前20个
		var limitflag = false;
		var disi = 0;
		for(var i = 0 ; i < limitarr;i++){
			if(thename[i].checked==true){
		    	disi++;
		    }
		}
		if(disi>20){
			limitarr = 20;
			limitflag = true;
		}
		
		for(var i=0;i<limitarr;i++){
			if(thename[i].checked==true){
				theclos += arr[i] + ',';
			}
		}
		theclos = theclos.substring(0,theclos.lastIndexOf(','));
		
		theclos = theclos.replace("memo","to_char(memo)");
				
		thisDataDownload(ds,tsdcf,theclos,table,flagfield,limitflag);
		
		//将面板关闭
		setTimeout($.unblockUI, 15);
	}
</script>
<script type="text/javascript">
	/**
	 * 关闭面板
	 * @param
	 * @return
	 */
	function closeo(){		
			clearText('operformT1');
			setTimeout($.unblockUI, 15);//关闭面板
				
	}
	/**
	 * 打开表格面板
	 * @param
	 * @return
	 */
	function openpan(){		
			autoBlockFormAndSetWH('pan',60,5,'closeo',"#ffffff",true,1000,'');//弹出查询面板		
	}

	/**
	 * 关闭表格页板
	 * @param
	 * @return
	 */
	function closeoQuery(){	
			setTimeout($.unblockUI, 15);//关闭面板		
	}

	/**
	 * 打开模板查询面板
	 * @param
	 * @return
	 */
	function openQueryT(){		
			autoBlockFormAndSetWH('queryT',60,5,'closeoT',"#ffffff",true,1000,'');//弹出查询面板	
	}
</script>
<script type="text/javascript">
 

</script>
</head>
<style type="text/css"> 
 .style1 {
	background-color:#A9C3E8;
	padding: 4px;		
	}
</style>
  <body>   
   <form name="childform" id="childform">
  <input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
  <input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
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
									key="gjh.houtuei" />
							</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</td>
				</tr>
			</table>
		</div>
  	
		
		<!-- 用户操作标题以及放一些快捷按钮-->		
		<div id="buttons">
			<button type="button" id="order1" onclick="openDiaO('radcheck_del');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>		  	
			<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button id='mbquery1' onclick='openQueryM(1);' >
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery1' onclick="openDiaQueryG('query','radcheck_del');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery1' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 		
			<button type="button" id="export1" onclick="thisDownLoad('tsdBilling','mssql','v_radcheck_del','<%=languageType %>')" disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>	
			<button type="button" id="print1" onclick="printThisReport1('<%=request.getParameter("imenuid")%>','v_radcheck_del',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');" disabled="disabled">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>   
	</div>	
    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
			<button type="button" id="order2" onclick="openDiaO('radcheck_del');">
				<!--组合排序--><fmt:message key="order.title" />
			</button>
			<button type="button" onclick="openQuery();">
				<!--查询-->
				<fmt:message key="global.query" />
			</button>
			<button id='mbquery2' onclick='openQueryM(1);' >
				<!--模板查询--><fmt:message key="oper.mod"/>
			</button>
			<button id='gjquery2' onclick="openDiaQueryG('query','radcheck_del');" disabled="disabled">
				<!--高级查询-->
				<fmt:message key="oper.queryA"/>
			</button>
			<button id='savequery2' onclick="openModT();" disabled="disabled">
				<!--保存本次查询--><fmt:message key="oper.modSave"/>
			</button> 		
			<button type="button" id="export2" onclick="thisDownLoad('tsdBilling','mssql','v_radcheck_del','<%=languageType %>')" disabled="disabled"> 
				<!--导出--><fmt:message key="global.exportdata" />
			</button>	
			<button type="button" id="print2" onclick="printThisReport1('<%=request.getParameter("imenuid")%>','v_radcheck_del',getPriParams(),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>');" disabled="disabled">
				<!--打印--><fmt:message key="tariff.printer" />
			</button>		   
	</div>
		
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
			<div style="max-height:315px;overflow-y: auto;overflow-x: hidden;">
		<form id='operformT1' name="operformT1" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
	
			  <tr>		
			   <td width="12%" align="right"  class="labelclass"><label  id="UserNameg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" id="UserName" name="UserName" class="textclass"  />	
			    </td>		   
			   
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="sBmg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="sBm" id="sBm" class="textclass"></input></td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="sDhg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="sDh" id="sDh" class="textclass"/></td>
			</tr>
			
			<tr id='addressTR'>			   
			    <td width="12%" align="right" class="labelclass"><label id="sDh1g" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	
			    	<select name="sDh1" id="sDh1" class="textclass">
								<option value="" >
									<!-- 请选择 -->
								</option>
				 	</select>						
				</td>
			   
			   <td width="12%" align="right" class="labelclass"><label id="sDh2g" ></label></td>							
			   <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">			    	
			    	<input type="text" name="sDh2" id="sDh2"  class="textclass"></input>
			   </td>
			    	
			   	<td width="12%" align="right" class="labelclass"><label id="sAddressg" ></label></td>							
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="sAddress" id="sAddress" class="textclass"></input></td>	  	
				
			</tr>
		 
		 	<tr>	
		 		 <td width="12%" align="right"  class="labelclass"><label id="sRealNameg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="sRealName" id="sRealName" class="textclass"/>
				  	<label class="addred" ></label></td>			   
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="sRegDateg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="sRegDate" id="sRegDate" class="textclass"></input></td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="sUserIDg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="sUserID" id="sUserID" class="textclass"/></td>
			</tr>

			<tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="AcctStartTimeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="AcctStartTime" id="AcctStartTime" class="textclass"></input>							
					<label class="addred"></label></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="AcctStopTimeg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="AcctStopTime" id="AcctStopTime" class="textclass"></input></td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="DelTimeg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="DelTime" id="DelTime" class="textclass"/></td>
			</tr>
			
			<tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="feeendtimeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="feeendtime" id="feeendtime" class="textclass"></input>
			    	<label class="addred"></label></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="idcardg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="idcard" id="idcard"  class="textclass"></input>
			    	</td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="idtypeg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">				 	
				 	<select name="idtype" id="idtype" class="textclass">
				 								<option value="" >
				 									<!-- 请选择 -->
				 									
				 								</option>
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
				 
				 </td>
			</tr>

			<tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="iFeeStopTypeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<select name="iFeeStopType" id="iFeeStopType" class="textclass">
								<option value="" >
									<!-- 请选择 -->
								</option>
				 	</select>
			    	</td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="iFeeTypeg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<select name="iFeeType" id="iFeeType" class="textclass">
								<option value="" >
									<!-- 请选择 -->
								</option>
				 	</select>
			    </td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="iFeeType1g"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			   		<select name="iFeeType1" id="iFeeType1" class="textclass">
								<option value="" >
									<!-- 请选择 -->									
								</option>
				 	</select>
				</td>
			</tr>
			<tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="iFeeTypeTimeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="iFeeTypeTime" id="iFeeTypeTime"  class="textclass"></input>
			    	</td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="iMacAutoBandg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<!-- <input type="text" name="iMacAutoBand" id="iMacAutoBand"  class="textclass"></input> -->
			    	<select name="iMacAutoBand" id="iMacAutoBand" class="textclass">
												<option value="100"></option>
												<option value="0">
													<fmt:message key="gjh.DoesNotBind" />
													<!-- 不绑定 -->
												</option>
												<option value="1">
													<fmt:message key="gjh.Binding" />
													<!-- 绑定 -->
												</option>
					</select>
											
			    	</td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="ipaddrg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="ipaddr" id="ipaddr" class="textclass"/></td>
			</tr>

			<tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="iSimultaneousg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="iSimultaneous" id="iSimultaneous" class="textclass"></input>
			    	</td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="iStatusg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="iStatus" id="iStatus"  class="textclass"></input>
			    	</td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="linkmang"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="linkman" id="linkman" class="textclass"/></td>
			</tr>
			
			<tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="linkphoneg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="linkphone" id="linkphone" class="textclass"></input>
			    	</td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="mobileg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="mobile" id="mobile"  class="textclass"></input>
			    	</td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="nextmonthtimeg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="nextmonthtime" id="nextmonthtime" class="textclass"/></td>
			</tr>
							
			<tr>			    	
			    <td width="12%" align="right"  class="labelclass"><label id="vlanidg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="vlanid" id="vlanid" class="textclass"/></td>
			   
			    <td width="12%" align="right" class="labelclass"><label id="PauseStartTimeg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="PauseStartTime" id="PauseStartTime" class="textclass"></input></td>		
			
			    <td width="12%" align="right" class="labelclass"><label id="PauseStopTimeg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="PauseStopTime" id="PauseStopTime" class="textclass"/></td>
			</tr>
			
			<tr>			   
			    <td width="12%" align="right" class="labelclass"><label id="UserName1g" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="UserName1" id="UserName1" class="textclass"></input>							
					<label class="addred" ></label></td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="RemainFeeg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="RemainFee" id="RemainFee" class="textclass"></input></td>		
			
			    <td width="12%" align="right"  class="labelclass"><label id="RemainTimeg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="RemainTime" id="RemainTime" class="textclass"/></td>
			</tr>
			
			<tr>			   
			   	<td width="12%" align="right" class="labelclass"><label id="thismonthtimeg" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="thismonthtime" id="thismonthtime" class="textclass"></input>							
					</td>
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="Valueg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="Value" id="Value" class="textclass"/></td>		
			
			     <td width="12%" align="right"  class="labelclass"><label id="speedg"></label></td>
			    <td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
				  	<input type="text" name="speed" id="speed" class="textclass"/></td>
			</tr> 
			
			<tr>			   	
			   
			    <td width="12%" align="right"  class="labelclass"><label  id="totaltimeg"></label></td>
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	<input type="text" name="totaltime" id="totaltime" class="textclass"/></td>		
				
				<td width="12%" align="right" class="labelclass"><label id="memog" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    	 <input type="text" name="memo" id="memo" class="textclass"></input>
			    	<!-- <input type="text" name="PayType" id="PayType" class="textclass"></input> -->
			    	</td>
			    	
			     <td width="12%" align="right" class="labelclass"><label id="" ></label></td>							
			    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    </td>
			    
			</tr> 		
			
		</table>
		</form>	
		</div>
		<div class="midd_butt">
			<!-- 关闭 --><button class="tsdbutton" id="closeo" style="width:63px;heigth:27px;" onclick="closeo();" ><fmt:message key="global.close" /></button>
		</div>	
	</div>
</div>




	
<!-- 简单查询面板 -->
<div id="queryT" name='queryT' style="display: none"  class="neirong">
	<br/>
	<div class="top">
	<div class="top_01">
			<div class="top_01left">
				<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
				<div class="top_03" >功能名称</div>
				<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
			</div>
			<div class="top_01right"><a href="#" onclick="closeoQuery();"><span style="margin-left:5px;"><fmt:message key="global.close"/></span></a></div>
		</div>
	<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
	</div>
		<div class="midd" >
		<form id='queryform' name="queryform" onsubmit="return false;" action="#" >
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">
			
			  	<tr >
				    <td width="12%" align="right" class="labelclass"><label id="UserNameg_a"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="UserName_a" id="UserName_a" class="textclass"/></td>
				    
				    <td width="12%" align="right"  class="labelclass"><label id='sRealNameg_a'></label></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="sRealName_a" id="sRealName_a" class="textclass"/></td>
									    
				     <td width="12%" align="right" class="labelclass"><label id='sAddressg_a'></label></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;">
			    		<input type="text" name="sAddress_a" id="sAddress_a" class="textclass"/></td>
			    	
			 	 </tr>
			 	 <tr >
				    <td width="12%" align="right" class="labelclass"><label id="sDhg_a"></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="sDh_a" id="sDh_a" class="textclass" /></td>
				    
				    <td width="12%" align="right"  class="labelclass"></td>
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
									    
				     <td width="12%" align="right"  class="labelclass"></td>
			    	<td width="20%" align="left" style="border-bottom:1px solid #A9C8D9;"></td>
			    	
			 	 </tr>		  
			</table>
		</form>	
		<div class="midd_butt">
		<!-- 查询 --><button class="tsdbutton" style="width:63px;heigth:27px;" id="jdquery" onclick="QbuildParams();"><fmt:message key="global.query" /></button>
	 	<!-- 关闭 --><button class="tsdbutton" style="width:63px;heigth:27px;" id="closeoT" onclick="closeoQuery();" ><fmt:message key="global.close" /></button>
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
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height:33px; font-size:12px;">			
			  	<tr>
				    <td width="12%" align="right" class="labelclass"><label id="nameg_mod"><fmt:message key="oper.modName"/></label></td>							
				    <td width="22%" align="left" style="border-bottom:1px solid #A9C8D9;">
				    	<input type="text" name="name_mod" id="name_mod" onpropertychange="TextUtil.NotMax(this)" maxlength="50" class="textclass"/>
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
		
			<!-- 不动的部分 -->
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
				
					<input type="hidden" id="addright"/>	
					<input type="hidden" id="addBright"/>			
					<input type="hidden" id="deleteright"/>
					<input type="hidden" id="delBright"/>
					<input type="hidden" id="editright"/>	
					<input type="hidden" id="editBright"/>								
					<input type="hidden" id="exportright" />
					<input type="hidden" id="printright" />		
					<input type="hidden" id="userid" value="<%=userid %>"/>
					
					<!-- 国际化保存表字段名 -->	
					<input type="hidden" id="id" />						
					
					<!-- /****日志*** -->	
					<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>'/> 
				   	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
				   	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 			  
				    <input type='hidden' id='oldh'  /> 				   	
				    <input type='hidden' id='areah'  />
				    <input type="hidden" id="addh"/>
				    <input type="hidden" id="edith"/>
				    <input type="hidden" id="thecloumn"/>
				    	<!-- 打印报表 -->	 
				   	<input type='hidden' id='thisbasePath' value='<%=basePath %>' />
				   		 
					</div>	
					<input type="hidden" id="123"/> 
					<input type="hidden" id="124"/> 
					<input type="hidden" id="125"/> 
				
					<!-- 高级查询 模板隐藏域 -->
					<input type="hidden" id="queryright"/>
					<input type="hidden" id="queryMright"/>
					<input type="hidden" id="saveQueryMright"/>	
					<!-- 查询树信息存放 -->
					<input type="hidden" id='treepid'/>	
					<input type="hidden" id='treecid'/>	
					<input type="hidden" id='treestr'/>	
					<input type="hidden" id='treepic'/>
					<input type="hidden" id="useridd" value="<%=userid %>"/>
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
									<div id="thelistform" style="margin-left: 10px;max-height: 200px;overflow-y: auto;overflow-x: hidden;">
								
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
					<button type="submit" class="tsdbutton" id="query" onclick="getTheCheckedFields('broadband','mysql','v_radcheck_del');">
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