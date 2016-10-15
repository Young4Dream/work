<%----------------------------------------
	name: teljobHistoryReview.jsp
	author: cz
	version: 1.0, 2011-03-16
	description: 工单历史查询
	modify: 
			
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");	
%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title>电话工单查询</title>
	
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
	
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<script src="plug-in/jquery/jquery.alerts/jquery.alerts.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jquery.alerts/jquery.alerts.css" />
	<!-- dtree需要导入文件 -->
	<script type="text/javascript" src="plug-in/dtree/dtree.js"></script>
	<link rel="stylesheet" type="text/css" href="plug-in/dtree/dtree.css" />

	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 新的面板样式 -->
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<!-- 验证框架需要导入的js文件 -->
	<script src="plug-in/jquery/validate/jquery.validate.js" type="text/javascript"></script>
  	<!-- 操作列样式 -->
	<script src="script/public/public.js" type="text/javascript"></script>
	<!-- 验证数据长度附 -->
	<script type="text/javascript" src="script/telephone/sysdataset/infotest.js"></script>
	<script src="script/public/datalength.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- 时间插件 -->
	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	
	<style type="text/css">
		.textclass{border:#FFF 1px none;}
	</style>
	
	<style type="text/css">
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
		#gdlc td{border:1px solid #A9C8D9;}
		#gdlc{border-collapse:collapse;}
		.btn_2k3 {
			BORDER-RIGHT: #87CEFA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #87CEFA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0,StartColorStr=#FFFFFF, EndColorStr=#87CEFA); BORDER-LEFT: #87CEFA 1px solid; CURSOR: hand;COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #87CEFA 1px solid
		}
	</style>

	<script type="text/javascript" language="javascript">
	
	/**
	 * 初始化
	 * @param 无参数
	 * @return 无返回值
	 */
	$(function(){
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			setUserRight();
			Dat = loadData("vw_teljobhistory",$("#lanType").val(),1,'查看详细');
			Dat.setHidden(["ID"]);
			Dat.colModels[0].width=70;
			
			// 添加历时时间列begin	donglei 2015-10-10
			var temp = "{name:'lssj',index:'Sgrq',width:100}";
			Dat.colModels.push(eval("(" + temp + ")"));
			Dat.colNames.push("历时(小时)");
			// 添加历时时间列end
			
			var userid_username=["userid","username"];
			users = fetchMultiKVValue("Duty.fetchUserId",6,"",userid_username);
			
			initialGrid();
			
			thisDetailField();
			initialFieldAlias();
		});
		
		var Dat = "";
		var users = "";
		
		function initialFieldAlias()
		{
		
		}
		
///设置权限
	function setUserRight()
	{
		var allRi = fetchMultiPValue("Duty.getPower",6,"&userid="+$("#skrid").val()+"&menuid="+$("#imenuid").val() + "&groupid="+$("#zid").val());
		if(typeof allRi == 'undefined' || allRi.length == 0)
		{
			//alert("取权限失败");
			$("#rightgroup").val("3");
			return false;
		}
		if(allRi[0][0]=="all")
		{
			$("#rightgroup").val('10');	
			return true;
		}
		var Interregional = 3;
		
		for(var i = 0;i<allRi.length;i++){
			if(getCaption(allRi[i][0],'RightsGroup','0')>Interregional)
				Interregional = getCaption(allRi[i][0],'PowerGroup','0');
		}
		
		$("#rightgroup").val(Interregional);
	}
function thisDetailField()
{
    var column = '';
    var thisdata = loadData('TelJob', '<%=languageType %>', 1);
    column = thisdata.FieldName.join(',');
    //ID,Sgnr,Mqbm,IfCancel,Ydh,Xdh,Nxm,Xm,Sgrq,Jlry,Area,Slbm,Dhlx,IDD,IsPay,Dhgn,BeginYwArea,Bm1,Bm2,Bm3,Bm4,Ydz,Xdz,Wgbm,Yhxz,Ywarea,CardID,IsComplete,jobstatus,Lsh,Lxdh,LinkMan,value1,value2,value3,value4,value5,value6,value7,value8,value9,Bz,Zwbz,YHth,Pgrq,Hth
    $("#thisJobID").html(thisdata.getFieldAliasByFieldName('ID'));
    $("#thisJobType").html(thisdata.getFieldAliasByFieldName('Sgnr'));
    $("#thismqbm").html(thisdata.getFieldAliasByFieldName('Mqbm'));
    $("#thisIfCancel").html(thisdata.getFieldAliasByFieldName('IfCancel'));
    $("#thisjobstatus").html(thisdata.getFieldAliasByFieldName('Ydh'));
    $("#thisUserName").html(thisdata.getFieldAliasByFieldName('Xdh'));
    $("#thisoldsRealName").html(thisdata.getFieldAliasByFieldName('Nxm'));
    $("#thissRealName").html(thisdata.getFieldAliasByFieldName('Xm'));
    $("#thisJobRecTime").html(thisdata.getFieldAliasByFieldName('Sgrq'));
    $("#thisUserID").html(thisdata.getFieldAliasByFieldName('Jlry'));
    $("#thisArea").html(thisdata.getFieldAliasByFieldName('Area'));
    $("#thisDepart").html(thisdata.getFieldAliasByFieldName('Slbm'));
    //$("#thisValue").html(thisdata.getFieldAliasByFieldName('Dhlx'));
    //$("#thisvlanid").html(thisdata.getFieldAliasByFieldName('IDD'));
    $("#thisPayType").html(thisdata.getFieldAliasByFieldName('IsPay'));
    $("#thisiFeeType").html(thisdata.getFieldAliasByFieldName('Dhgn'));
    //$("#thissDh").html(thisdata.getFieldAliasByFieldName('BeginYwArea'));
    //$("#thisValue").html(thisdata.getFieldAliasByFieldName('Dhgn'));
    $("#thissRegDate").html(thisdata.getFieldAliasByFieldName('Bm1'));
    $("#thisfeedendtime").html(thisdata.getFieldAliasByFieldName('Bm2'));
    $("#thisiFeeTypeTime").html(thisdata.getFieldAliasByFieldName('Bm3'));
    $("#thisoldsAddress").html(thisdata.getFieldAliasByFieldName('Bm4'));
    $("#thissAddress").html(thisdata.getFieldAliasByFieldName('Ydz'));
    $("#thisiStatus").html(thisdata.getFieldAliasByFieldName('Xdz'));
    $("#thissDh1").html(thisdata.getFieldAliasByFieldName('Wgbm'));
    $("#thissDh2").html(thisdata.getFieldAliasByFieldName('Yhxz'));
    $("#thisiSimultaneous").html(thisdata.getFieldAliasByFieldName('Ywarea'));
    $("#thisUserName1").html(thisdata.getFieldAliasByFieldName('CardID'));
    $("#thisidtype").html(thisdata.getFieldAliasByFieldName('IsComplete'));
    $("#thisidcard").html(thisdata.getFieldAliasByFieldName('jobstatus'));
    $("#thisoldspeed").html(thisdata.getFieldAliasByFieldName('Lxdh'));
    $("#thisspeed").html(thisdata.getFieldAliasByFieldName('LinkMan'));
    //号线配置信息
    $("#thismobile").html(thisdata.getFieldAliasByFieldName('value1'));
    $("#thislinkphone").html(thisdata.getFieldAliasByFieldName('value2'));
    $("#thislinkman").html(thisdata.getFieldAliasByFieldName('value3'));
    $("#thisFee").html(thisdata.getFieldAliasByFieldName('value4'));
    $("#thisFeeName").html(thisdata.getFieldAliasByFieldName('value5'));
    $("#thissBm").html(thisdata.getFieldAliasByFieldName('value6'));
    $("#thissBm2").html(thisdata.getFieldAliasByFieldName('value7'));
    $("#thissBm3").html(thisdata.getFieldAliasByFieldName('value8'));
    $("#thissBm4").html(thisdata.getFieldAliasByFieldName('value9'));
    $("#thisifurgent").html(thisdata.getFieldAliasByFieldName('Bz'));
    $("#thismemo").html(thisdata.getFieldAliasByFieldName('Zwbz'));
    $("#thisPayMode").html(thisdata.getFieldAliasByFieldName('Hth'));
    $("#thisisPay").html(thisdata.getFieldAliasByFieldName('Pgrq'));
    $("#thisHth").html(thisdata.getFieldAliasByFieldName('value15'));
    $("#thisdevno").html(thisdata.getFieldAliasByFieldName('Lsh'));
    $("#thisjobstate").html(thisdata.getFieldAliasByFieldName('dJhwcsj'));
    
}
		/**
		 * 初始化显示结果集
		 * @param 无参数
		 * @return 无返回值
		 */
		function initialGrid()
		{
			var sqlextend = "";
			var powerflag = $("#rightgroup").val();
			if(powerflag=="0"){
				sqlextend = "sale";
			}else if(powerflag=="3"){
			  sqlextend = "monitor";
			}
			var keystr="";
			if($("#getshowvalue").val()==""){
				keystr="1=1";
			}else{
				keystr="sgrq>ADD_MONTHS(sysdate,-2)"
			}
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'TelJobHisReview.query' + sqlextend,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'TelJobHisReview.querypage' + sqlextend//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});					
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&cols=" + Dat.FieldName.join(",") + "&area=" + tsd.encodeURIComponent($("#area").val()) + "&jlry=" + encodeURIComponent($("#skrid").val())+"&key="+keystr,
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Sgrq', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'工单记录',//"宽带业务流水", 
				       	height : document.documentElement.clientHeight-185, //高
        				width : document.documentElement.clientWidth - 75,
				       	loadComplete:function(){
							addRowOperBtn('editgrid',"&nbsp;&nbsp;&nbsp;&nbsp;<img src=\"style/images/public/ltubiao_03.gif\" title=\"<fmt:message key='jobflowdefine.details' />\" />",'thisInfo','ID','click',1,'MQBM');
						    /****执行行按钮添加********
							*@1 表格ID
							*@2 操作按钮数量 等于定义数量
							*依赖于addRowOperBtn(,,,,,)函数 顺序不可调换*/
							executeAddBtn('editgrid',1);
						},
						ondblClickRow:function(rowid){
							
							var jobid = $("#editgrid").getCell(rowid,"ID");
							var mqbm = $("#editgrid").getCell(rowid,"MQBM");
							
							thisInfo(jobid,mqbm);
							
							autoBlockForm('detailInfo',20,'detailinfoclose',"#FFFFFF",false);
						}
				}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		/**
		 * 直接打印工单
		 * @param key
		 * @param type
		 * @return 无返回值
		 */
		function theprint(key,type){
				if((key!='undefined'&&type=='开户')||(key!='undefined'&&type=='移机')){
					//var printfile = 'usercat/jobgongdan';
					var printfile = getReportName('<%=request.getParameter("imenuid")%>','radjob');
					printfile = printfile.substring(0, printfile.indexOf("."));  //去掉文件名后面.cpt后缀
					printWithoutPreview(printfile,"JobID_"+key);
				}else{
					alert('['+type+']类型的工单暂不开放打印!');
				}
		}
			
		/**
		 * 打印预览
		 * @param key
		 * @param type
		 * @return 无返回值
		 */
		function theviewprint(key,type){
				//var printfile = "usercat/jobgongdan";
				//var printfile = getReportName('<%=request.getParameter("imenuid")%>','radjob');
				//printfile = printfile.substring(0, printfile.indexOf("."));  //去掉文件名后面.cpt后缀
				if((key!='undefined'&&type=='开户')||(key!='undefined'&&type=='移机')){
					//var theurl = "<%=path%>/ReportServer?reportlet=/com/tsdreport/"+printfile+".cpt&JobID="+key;
					//window.showModalDialog(theurl,window,"dialogWidth:760px; dialogHeight:580px; center:yes; scroll:no");
					printThisReport1('<%=request.getParameter("imenuid")%>','radjob',"&JobID="+encodeURIComponent(cjkEncode(key)),'<%=(String)session.getAttribute("userid")%>','<%=request.getParameter("groupid").replaceAll("~", ",")%>','<%=(String)session.getAttribute("departname")%>', 1);
				}else{
					alert('['+type+']类型的工单暂不开放打印!');
				}
		}
		

		/**
		 * 复合查询操作
		 * @param 无参数
		 * @return 无返回值
		 */
		function fuheQuery()
		{	
			var sqlextend = "";
			var powerflag = $("#rightgroup").val();
			if(powerflag=="0")
				sqlextend = "sale";
			else if(powerflag=="3")
			  sqlextend = "monitor";
			
			var params = fuheQbuildParams();						
			if(params=='&fusearchsql='){
				params +='1=1';
			}	
					
		 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
		 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'TelJobHisReview.queryF' + sqlextend,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'TelJobHisReview.queryFpage' + sqlextend
										});
			var link = urlstr1 + params + "&area=" + tsd.encodeURIComponent($("#area").val()) + "&jlry=" + encodeURIComponent($("#skrid").val());
			link = link + "&cols=" + Dat.FieldName.join(",");
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
		 	setTimeout($.unblockUI, 15);//关闭面板			
		}
		
		/**
		 * 组合排序
		 * @param sqlstr
		 * @return 无返回值
		 */
		function zhOrderExe(sqlstr)
		{			
			var sqlextend = "";
			var powerflag = $("#rightgroup").val();
			if(powerflag=="0")
				sqlextend = "sale";
			else if(powerflag=="3")
			  sqlextend = "monitor";
			
			var params = fuheQbuildParams();			
				if(params=='&fusearchsql=')
				{
					params +='1=1';
				}
			 params =params+'&orderby='+sqlstr;		    
			 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
											  clsname:'ExecuteSql',//类名
											  method:'exeSqlData',//方法名
											  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
											  tsdcf:'mssql',//指向配置文件名称
											  tsdoper:'query',//操作类型 
											  datatype:'xml',//返回数据格式 
											  tsdpk:'TelJobHisReview.queryO' + sqlextend,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
											  tsdpkpagesql:'TelJobHisReview.queryOpage' + sqlextend
											});
				var link = urlstr1 + params + "&area=" + tsd.encodeURIComponent($("#area").val()) + "&jlry=" + encodeURIComponent($("#skrid").val());
				link = link + "&cols=" + Dat.FieldName.join(",");
			 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link}).trigger("reloadGrid");
			 	
		}
		/**
		 * 批量删除或批量修改
		 * @param 无参数
		 * @return 无返回值
		 */
		function fuheExe()
		{
			var queryName= document.getElementById("queryName").value;
			if(queryName=="delete")
			{
				//fuheDel();
			}
			else if(queryName=="modify")
			{
				//fuheOpenModify();
			}
			else
			{
				fuheQuery();
			}
		}
		/**
		 * 显示明细
		 * @param jobid
		 * @param mqbm
		 * @return 无返回值
		 */
function thisInfo(jobid, mqbm, key)
{
	 
    clearText('detailInfoform');
    ///设置命令参数
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdReport', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljob.querydetail' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    
    $.ajax(
    {
        url : 'mainServlet.html?jobid=' + jobid + '&'+urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', 
        cache : false, //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        error:function(x){alert(x);},
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                var tmp_id = $(this).attr('id'.toLowerCase());
                if (tmp_id != undefined)
                {
                    $("#thisJobIDvalue").html(tmp_id);
                    var tmp_Sgnr = $(this).attr('sgnr'.toLowerCase());
                    
                    if (tmp_Sgnr != '' && tmp_Sgnr != undefined)
                    {
                        tmp_Sgnr = getTrueValue('tsdBilling', 'ywsl_code', 'showname', 'ywlx', tmp_Sgnr, 
                        '1', '1');
                    }
                    else {
                        tmp_Sgnr = '';
                    }
                    if(tmp_Sgnr==undefined)
                    	tmp_Sgnr = "";
                    $("#thisJobTypevalue").html(tmp_Sgnr);
                    //var tmp_Mqbm = $(this).attr('Mqbm');
                    //if(tmp_Mqbm=='null'||tmp_Mqbm==undefined){
                    // tmp_Mqbm = '';
                    //}
                    $("#thismqbmvalue").html(mqbm);
                    
                    var tmp_IfCancel = $(this).attr('IfCancel'.toLowerCase());
                    //是否撤销
                    if (tmp_IfCancel == 'null' || tmp_IfCancel == undefined) {
                        tmp_IfCancel = '';
                    }
                    else if (tmp_IfCancel == 0) {
                        tmp_IfCancel = '否';
                    }
                    else if (tmp_IfCancel == 1) {
                        tmp_IfCancel = '是';
                    }
                    $("#thisIfCancelvalue").html(tmp_IfCancel);
                    var tmp_Ydh = $(this).attr('Ydh'.toLowerCase());
                    if (tmp_Ydh == 'null' || tmp_Ydh == undefined) {
                        tmp_Ydh = '';
                    }
                    $("#thisjobstatusvalue").html(tmp_Ydh);
                    var tmp_Xdh = $(this).attr('Xdh'.toLowerCase());
                    if (tmp_Xdh == 'null' || tmp_Xdh == undefined) {
                        tmp_Xdh = '';
                    }
                    $("#thisUserNamevalue").html(tmp_Xdh);
                    var tmp_Nxm = $(this).attr('Nxm'.toLowerCase());
                    if (tmp_Nxm == 'null' || tmp_Nxm == undefined) {
                        tmp_Nxm = '';
                    }
                    $("#thisoldsRealNamevalue").html(tmp_Nxm);
                    var tmp_xm = $(this).attr('Xm'.toLowerCase());
                    if (tmp_xm == 'null' || tmp_xm == undefined) {
                        tmp_xm = '';
                    }
                    $("#thissRealNamevalue").html(tmp_xm);
                    var sgrq = $(this).attr('Sgrq'.toLowerCase());
                    if (sgrq == 'null' || sgrq == undefined) {
                        sgrq = '';
                    }
                    else {
                        sgrq = sgrq.substring(0, 19);
                    }
                    $("#thisJobRecTimevalue").html(sgrq);
                    var theuserid = $(this).attr('Jlry'.toLowerCase());
                    if (theuserid != '' && theuserid != undefined)
                    {
                        theuserid = getTrueValue('tsdBilling', 'sys_user', 'username', 'userid', theuserid, 
                        '1', '1');
                    }
                    else {
                        theuserid = '';
                    }
                    $("#thisUserIDvalue").html(theuserid);
                    var tmp_Area = $(this).attr('Area'.toLowerCase());
                    if (tmp_Area == 'null' || tmp_Area == undefined) {
                        tmp_Area = '';
                    }
                    $("#thisAreavalue").html(tmp_Area);
                    var tmp_Slbm = $(this).attr('Slbm'.toLowerCase());
                    if (tmp_Slbm == 'null' || tmp_Slbm == undefined) {
                        tmp_Slbm = '';
                    }
                    $("#thisDepartvalue").html(tmp_Slbm);
                    //var tmp_Dhlx = $(this).attr('Dhlx');
                    //if(tmp_Dhlx=='null'||tmp_Dhlx==undefined){
                    // tmp_Dhlx = '';
                    //}
                    //$("#thisValuevalue").html(tmp_Dhlx);
                    //var tmp_IDD = $(this).attr('IDD');
                    //if(tmp_IDD=='null'||tmp_IDD==undefined){
                    // tmp_IDD = '';
                    //}
                    //$("#thisvlanidvalue").html(tmp_IDD);
                    var ispay = $(this).attr('ispay'.toLowerCase());
                    /*
                    if (ispay == 'cash') {
                        ispay = '现金';
                         
                    }
                    else if (ispay == 'transfer') {
                        ispay = '转账';
                    }
                    else {
                        ispay = '';
                    }*/
                    ispay = getTrueValue('tsdBilling', 'tsd_Ini', 'TValues', 'TIDent', ispay,'TSection', 'payitem');
                    if(ispay==undefined)
                    	ispay = "";
                    $("#thisPayTypevalue").html(ispay);
                    //var tmp_Dhgn = $(this).attr('Dhgn');
                    //if(tmp_Dhgn=='null'||tmp_Dhgn==undefined){
                    // tmp_Dhgn = '';
                    //}
                    //$("#thisiFeeTypevalue").html(tmp_Dhgn);
                    //var tmp_BeginYwArea = $(this).attr('BeginYwArea');
                    //if(tmp_BeginYwArea=='null'||tmp_BeginYwArea==undefined){
                    // tmp_BeginYwArea = '';
                    //}
                    //$("#thissDhvalue").html(tmp_BeginYwArea);
                    //$("#thisValue").html($(this).attr('Dhgn'));
                    var tmp_Bm1 = $(this).attr('Bm1'.toLowerCase());
                    if (tmp_Bm1 == 'null' || tmp_Bm1 == undefined) {
                        tmp_Bm1 = '';
                    }
                    var tmp_Bm2 = $(this).attr('Bm2'.toLowerCase());
                    if (tmp_Bm2 == 'null' || tmp_Bm2 == undefined) {
                        tmp_Bm2 = '';
                    }
                    var tmp_Bm3 = $(this).attr('Bm3'.toLowerCase());
                    if (tmp_Bm3 == 'null' || tmp_Bm3 == undefined) {
                        tmp_Bm3 = '';
                    }
                    var tmp_Bm4 = $(this).attr('Bm4'.toLowerCase());
                    if (tmp_Bm4 == 'null' || tmp_Bm4 == undefined) {
                        tmp_Bm4 = '';
                    }
                    $("#thissRegDatevalue").html(tmp_Bm1);
                    $("#thisfeedendtimevalue").html(tmp_Bm2);
                    $("#thisiFeeTypeTimevalue").html(tmp_Bm3);
                    $("#thisoldsAddressvalue").html(tmp_Bm4);
                    var tmp_Ydz = $(this).attr('Ydz'.toLowerCase());
                    if (tmp_Ydz == 'null' || tmp_Ydz == undefined) {
                        tmp_Ydz = '';
                    }
                    $("#thissAddressvalue").html(tmp_Ydz);
                    var tmp_Xdz = $(this).attr('Xdz'.toLowerCase());
                    if (tmp_Xdz == 'null' || tmp_Xdz == undefined) {
                        tmp_Xdz = '';
                    }
                    $("#thisiStatusvalue").html(tmp_Xdz);
                    var tmp_Wgbm = $(this).attr('Wgbm'.toLowerCase());
                    if (tmp_Wgbm == 'null' || tmp_Wgbm == undefined) {
                        tmp_Wgbm = '';
                    }
                    $("#thissDh1value").html(tmp_Wgbm);
                    var tmp_Yhxz = $(this).attr('Yhxz'.toLowerCase());
                    if (tmp_Yhxz == 'null' || tmp_Yhxz == undefined) {
                        tmp_Yhxz = '';
                    }
                    $("#thissDh2value").html(tmp_Yhxz);
                    var tmp_Ywarea = $(this).attr('Ywarea'.toLowerCase());
                    if (tmp_Ywarea == 'null' || tmp_Ywarea == undefined) {
                        tmp_Ywarea = '';
                    }
                    $("#thisiSimultaneousvalue").html(tmp_Ywarea);
                    var tmp_CardID = $(this).attr('CardID'.toLowerCase());
                    if (tmp_CardID == 'null' || tmp_CardID == undefined) {
                        tmp_CardID = '';
                    }
                    $("#thisUserName1value").html(tmp_CardID);
                    var tmp_IsComplete = $(this).attr('IsComplete'.toLowerCase());
                    if(tmp_IsComplete=="N")
                    	tmp_IsComplete = "未完工";
                    else if(tmp_IsComplete=="Y")
                    	tmp_IsComplete = "已完工";
                    	
                    if (tmp_IsComplete == 'null' || tmp_IsComplete == undefined) {
                        tmp_IsComplete = '';
                    }
                    $("#thisidtypevalue").html(tmp_IsComplete);
                    var thejobstatus = $(this).attr('jobstatus');
                    
                    if (thejobstatus != '' && thejobstatus != undefined)
                    {
                        thejobstatus = getTrueValue('tsdBilling', 'tsd_Ini', 'TIDent', 'TValues', thejobstatus, 
                        'TSection', 'canacceptjobtype');
                    }
                    if (thejobstatus == undefined) {
                        thejobstatus = '';
                    }
                    
                    $("#thisidcardvalue").html(thejobstatus);
                    var tmp_Lsh = $(this).attr('Lsh'.toLowerCase());
                    if (tmp_Lsh == 'null' || tmp_Lsh == undefined) {
                        tmp_Lsh = '';
                    }
                    $("#thisdevnovalue").html(tmp_Lsh);
                    var tmp_Lxdh = $(this).attr('Lxdh'.toLowerCase());
                    if (tmp_Lxdh == 'null' || tmp_Lxdh == undefined) {
                        tmp_Lxdh = '';
                    }
                    $("#thisoldspeedvalue").html(tmp_Lxdh);
                    var tmp_LinkMan = $(this).attr('LinkMan'.toLowerCase());
                    if (tmp_LinkMan == 'null' || tmp_LinkMan == undefined) {
                        tmp_LinkMan = '';
                    }
                    $("#thisspeedvalue").html(tmp_LinkMan);
                    
                    //获取号线资料信息
                    var datatmp = $(this);
                    $("span[id^='hd_cell_']").each(function(){
                    	var idd = $(this).attr("id");
                    	idd = idd.replace("hd_cell_","");
                    	var tmpp = $(datatmp).attr(idd.toLowerCase());
                    	if(tmpp=="null" || tmpp==undefined)
                    		tmpp = "";
                    	$("#" + idd).val(tmpp);
                    });
                    
                    var tmp_Bz = $(this).attr('Bz'.toLowerCase());
                    if (tmp_Bz == 'null' || tmp_Bz == undefined) {
                        tmp_Bz = '';
                    }
                    $("#thisifurgentvalue").html(tmp_Bz);
                    var tmp_Zwbz = $(this).attr('Zwbz'.toLowerCase());
                    if (tmp_Zwbz == 'null' || tmp_Zwbz == undefined) {
                        tmp_Zwbz = '';
                    }
                    $("#thismemovalue").html(tmp_Zwbz);
                    var tmp_YHth = $(this).attr('Hth');
                    if (tmp_YHth == 'null' || tmp_YHth == undefined) {
                        tmp_YHth = '';
                    }
                    $("#thisPayModevalue").html(tmp_YHth);
                    var tmp_Pgrq = $(this).attr('Pgrq'.toLowerCase());
                    if (tmp_Pgrq == 'null' || tmp_Pgrq == undefined) {
                        tmp_Pgrq = '';
                    }
                    else {
                        tmp_Pgrq = tmp_Pgrq.substring(0, 19);
                    }
                    $("#thisisPayvalue").html(tmp_Pgrq);
                    var tmp_Hth = $(this).attr('Hth'.toLowerCase());
                    if (tmp_Hth == 'null' || tmp_Hth == undefined) {
                        tmp_Hth = '';
                    }
                    $("#thisHthvalue").html(tmp_Hth);
                    var tmp_JobState = $(this).attr('dJhwcsj'.toLowerCase());
                    if (tmp_JobState == 'null' || tmp_JobState == undefined) {
                        tmp_JobState = '';
                    }
                    else {
                        tmp_JobState = tmp_JobState.substring(0, 19);
                    }
                    $("#thisjobstatevalue").html(tmp_JobState);
                    
                    //用户电缆
                    //$("#thisiFeeTypevalue").html(tmp_Dhgn);//thisnewyw
                    //alert(tmp_Xdh);
                    //$('#thisiFeeTypevalue').html(getDhgn(tmp_Xdh));
                     $('#thisiFeeTypevalue').html($(this).attr('Dhgn'.toLowerCase()));
                    $('#thisnewyw').html(getNewYw(tmp_Xdh));
                }
            });
        }
    });
    readThisJob(jobid);
    autoBlockForm('detailInfo', 20, 'detailinfoclose', "#ffffff", false);
    //弹出查询面板  
}
		/**
		 * 获取选择值的真实值
		 * @param ds
		 * @param tablename
		 * @param code
		 * @param thelimit
		 * @param limitvalue
		 * @param theif
		 * @param theend
		 * @return String
		 */
           function getTrueValue(ds,tablename,code,thelimit,limitvalue,theif,theend){
           	var realvalue = '';
           	 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:ds,//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mysql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'broadbandjob.querytruevalue' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 					});
			if(limitvalue==''||limitvalue==null){
				thelimit = 1;
				limitvalue = 1;
			}
			$.ajax({
						url:'mainServlet.html?'+urlstr+'&tablename='+tablename+'&code='+code+'&thelimit='+thelimit+'&theif='+theif+'&theend='+theend+'&limitvalue='+limitvalue+'&tsdtemp='+Math.random(),
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){
							$(xml).find('row').each(function(){
								realvalue += $(this).attr(code.toLowerCase());//是否已接收
							});
						}
					});
			return realvalue;
       }
       
       /**
		 * 取工单流程
		 * @param jobid
		 * @return 无返回值
		 */
       function readThisJob(jobid){
			//清除现在工单流程信息
			$("#detailInfo .midd table tr.dynamicadd").remove();
			//变量 标识是否有流程信息
			var hasvalue = false;
			
			var info = "<tr style=\"background-color:#A9C8D9\"><td>发送部门</td><td>发送人员</td><td>发送时间</td><td>接收部门</td><td>接收人员</td><td>接收时间</td><td>备注</td></tr>";
			//完工人员
			var wgry = "";
			
			var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdReport',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'TelJobHisReview.queryflow' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});
				$.ajax({
							url:'mainServlet.html?'+urlstr+'&jobid='+jobid+'&tsdtemp='+Math.random(),
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 5000,
							async: false ,//同步方式
							success:function(xml){
								//var info = '<div id="midd_butt"><button class="tsdbutton" style="float: left; margin-left: 18px">接收工单</button></div>';
								info = '<tr class=\"dynamicadd\"><td class=\"labelclass\" colspan=\"7\" width=\"100%\" height=\"32\" style=\"text-align:left;\"><b><span>工单流程信息</span></b></td></tr>' + info;
								
								var i = 1;
								$(xml).find('row').each(function(){
									if($(this).attr("jobid")!=undefined){
										//有返回值
										hasvalue = true;
										
										//info += '<tr height="20px" id="trd'+i+'" onmouseover=colorchange(this,1,"trd") onmouseout=colorchange(this,2,"trd") onclick=colorchange(this,3,"trd") >';
										var jobid = $(this).attr("jobid");
										var PgID = $(this).attr("pgid");
										var Fsbm = $(this).attr("fsbm");
										if(Fsbm==undefined){
											Fsbm = '';
										}
										var Fsry = $(this).attr("fsry");
										if(Fsry==undefined){
											Fsry = '';
										}
										//Fsry = getTrueValue('tsdBilling','sys_user','username','userid',Fsry,'1','1');
										
										var Fsrq = $(this).attr("fsrq");
										if(Fsrq==undefined){
											Fsrq = '';
										}
										var Bm = $(this).attr("bm");
										
										var Rw = $(this).attr("rw");
										if(Rw=='N'){
											Rw = '未接收';
										}else if(Rw=='Y'){
											Rw = '已接收';
										}
										var Wcqk = $(this).attr("wcqk");
										
										/*
										if(Wcqk=='N'){
											Wcqk = '未完成';
										}else if(Wcqk=='Y'){
											Wcqk = '已完成';
										}*/
										var Ry = $(this).attr("ry");
										if(Ry==undefined){
											Ry = '';
										}
										if(Ry!="")
										{
											//Ry = getTrueValue('tsdBilling','sys_user','username','userid',Ry,'1','1');
										}
										
										var OperTime = $(this).attr("opertime");
										if(OperTime.indexOf("1990-01-01")==0)
										{
											OperTime = "";
										}
										var Bz = $(this).attr("cbz");
										if(Bz=='null'){
											Bz = '';
										}
										var dtwaringtime = $(this).attr("dtwaringtime");
										var dttimeout = $(this).attr("dttimeout");
										var dtjobtimeout = $(this).attr("dtjobtimeout");
										var Wcry = $(this).attr("wcry");
										if(Wcry==undefined){
											Wcry = '';
										}
										//记录完工人员
										//wgry = Wcry;
										
										var Wcrq = $(this).attr("wcrq");
										if(Wcrq==undefined){
											Wcrq = '';
										}
										
										info += "<tr>";
										//1
										//info += "<tr class=\"dynamicadd\"><td class=\"labelclass\" style=\"width:7%\"><span>";
										//info += "发送部门";
										//info += "</span></td>";
										info += "<td  class=\"tdstyle\"><div>";
										info += Fsbm;
										info += "</div></td>";
										
										//info += "<td class=\"labelclass\" style=\"width:7%\"><span>";
										//info += "发送人员";
										//info += "</span></td>";																
										info += "<td>";
										info += Fsry;
										info += "</td>";
																
										//info += "<td class=\"labelclass\" style=\"width:7%\"><span>";
										//info += "发送时间";
										//info += "</span></td>";										
										info += "<td class=\"tdstyle\" style='width:160px'>";
										info += Fsrq;
										info += "</td>";
										
										//3
										//info += "<td class=\"labelclass\" style=\"width:7%\"><span>";
										//info += "接收部门";
										//info += "</span></td>";
										info += "<td class=\"tdstyle\"><div>";
										info += Bm;
										info += "</div></td>";
										
										//info += "<td class=\"labelclass\" style=\"width:7%\"><span>";
										//info += "接收人员";
										//info += "</span></td>";																
										info += "<td class=\"tdstyle\"><div>";
										info += Ry;
										info += "</div></td>";
																
										//info += "<td class=\"labelclass\" style=\"width:7%\"><span>";
										//info += "接收时间";
										//info += "</span></td>";										
										info += "<td class=\"tdstyle\"><div>";
										info += OperTime;
										info += "</div></td>";
										
										
										//info += "<td class=\"labelclass\" height=\"32\"><span>";
										//info += "备注";
										//info += "</span></td>";
										info += "<td class=\"tdstyle\"><div>";
										info += Bz;
										info += "</div></td>";
										
										info += "</tr>";
										
										
										
									}else{
										//得判断
										//alert('对不起,暂无此类型的工单!');
										//return false;
										
										
									}
									i++;
								});
								
							}
						});
						
					if(!hasvalue)
					{
						info = '<tr class=\"dynamicadd\"><td class=\"labelclass\" colspan=\"7\"  height=\"32\" style=\"text-align:left;\"><b><span>工单流程信息</span></b></td></tr>';
						info += "<tr class=\"dynamicadd\"><td class=\"labelclass\"><span>";
						info += "流程信息";
						info += "</span></td>";
						info += "<td width=\"20%\" class=\"tdstyle\" colspan=\"6\"><div>";
						info += "直接完工";
						info += "</div></td>";
					}
					else
					{
						/**
						var res = fetchMultiArrayValue("TelJobHisReview.isWG",0,"&jobid="+jobid);
						if(res[0] != undefined && res[0][0]=="Y")
						{
							info += "<tr class=\"dynamicadd\"><td class=\"labelclass\"><span>";
							info += "完工部门";
							info += "</span></td>";
							info += "<td width=\"10%\" class=\"tdstyle\"><div>";
							info += res[0][1];
							info += "</div></td>";
							
							info += "<td class=\"labelclass\" style=\"width:100px\">";
							info += "完工人员";
							info += "</td>";																
							info += "<td class=\"tdstyle\"><div>";
							//if(wgry=="")
							//	wgry = "+!";
								//var tmpp = getTrueValue('tsdBilling','sys_user','username','userid',wgry,'1','1');
							
							//info += ((tmpp==undefined||tmpp=='undefined')?"":tmpp);
							
							info += "</div></td>";
													
							info += "<td class=\"labelclass\"><span>";
							info += "完工时间";
							info += "</span></td>";										
							info += "<td width=\"20%\" class=\"tdstyle\"  colspan=\"2\"><div>";
							info += res[0][2];
							info += "</div></td></tr>";
							
							//已完工
							info += "<tr class=\"dynamicadd\"><td class=\"labelclass\"><span>";
							info += "流程信息";
							info += "</span></td>";
							info += "<td width=\"20%\" class=\"tdstyle\" colspan=\"6\"><div><b>";
							info += "已完工";
							info += "</b></div></td>";
						}
						else
						{
							info += "<tr class=\"dynamicadd\"><td class=\"labelclass\"><span>";
							info += "流程信息";
							info += "</span></td>";
							info += "<td width=\"20%\" class=\"tdstyle\" colspan=\"6\"><div><b>";
							info += "未完工";
							info += "</b></div></td>";
						}
						*/
						
					}
					
					//$("#detailInfo .midd table").prepend(info);
					$("#gdlc").html(info);
		}
		
		/**
 * 获取用户的电话功能信息
 * @param dh
 * @return String
 */
function getDhgn(dh)
{
    var res = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.getuserdhgn'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?dh=' + dh +'&'+ urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        success : function (xml)
        {
            $(xml).find('row').each(function ()
            {
                //取不到部门时间则按默认时间计算工单超时时间
                var str = $(this).attr("bz");
                if (str != undefined) {
                    res = str;
                }
            });
        }
    });
    return res;
}
/**
 * 获取用户新业务信息
 * @param dh
 * @return String
 */
function getNewYw(dh)
{
    var res = '';
    var urlstr = tsd.buildParams(
    {
        packgname : 'service', //java包
        clsname : 'ExecuteSql', //类名
        method : 'exeSqlData', //方法名
        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
        tsdcf : 'mssql', //指向配置文件名称
        tsdoper : 'query', //操作类型 
        datatype : 'xmlattr', //返回数据格式 
        tsdpk : 'teljobmanager.getusernewyw'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
    });
    $.ajax(
    {
        url : 'mainServlet.html?dh=' + dh +'&'+ urlstr + '&tsdtemp=' + Math.random(), datatype : 'xml', cache : false, 
        //如果值变化可能性比较大 一定要将缓存设成false
        timeout : 5000, async : false , //同步方式
        success : function (xml)
        {
            var infos = '';
            $(xml).find('row').each(function ()
            {
                //取不到部门时间则按默认时间计算工单超时时间
                var str = $(this).attr("FeeType".toLowerCase());
                if (str != undefined) {
                    infos += str + ',';
                }
            });
            infos = infos.substring(0, infos.lastIndexOf(','));
            res = infos;
        }
    });
    return res;
}
       

		function getTimefun(key){
			var keystr="";
			if($("#getshowvalue").val()==""){
				keystr='1=1';
			}else{
				keystr="sgrq>ADD_MONTHS(sysdate,-2)";
			}				
			//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
			var urlstr1=tsd.buildParams({  packgname:'service',//java包
										  clsname:'ExecuteSql',//类名
										  method:'exeSqlData',//方法名
										  ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
										  tsdcf:'mssql',//指向配置文件名称
										  tsdoper:'query',//操作类型 
										  datatype:'xml',//返回数据格式 
										  tsdpk:'TelJobHisReview.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
										  tsdpkpagesql:'TelJobHisReview.querypage'
										});
			var link = "&cols=" + Dat.FieldName.join(",") + "&area=" + tsd.encodeURIComponent($("#area").val()) + "&jlry=" + encodeURIComponent($("#skrid").val())+"&key="+keystr;
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr1+link}).trigger("reloadGrid");
		}
	</script>

  </head>
  
  <body>
    <form name="childform" id="childform">
		<input type="text" id="queryName" name="queryName" value=""  style="display: none"/>
		<input type="text" id="fusearchsql" name="fusearchsql" style="display: none"/>
	</form>
	
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="order1" onclick="openDiaO('vw_teljobhistory');">
			<!--组合排序--><fmt:message key="order.title" />
		</button>					   
		<button type="button" onclick="openDiaQueryG('query','vw_teljobhistory');">
			<!--查询--><fmt:message key="global.query" />
		</button>
		<!--导出-->
		<button type="button" id="export1"
			onclick="thisDownLoad('tsdBilling','mssql','vw_teljobhistory','<%=languageType%>')">					
			<fmt:message key="global.exportdata" />
		</button>
		<!-- 这里的按钮可以自由更换 但格式要对 -->
		<button type="button" id="openadd2"
			onclick="thisDownLoad('broadband','mysql','radjiaofei','<%=languageType %>')"
			style="display:none;">
			<fmt:message key="global.exportdata" />
		</button>&nbsp;&nbsp;&nbsp;&nbsp;
		查询过滤<select type="checkbos" id="getshowvalue" onchange="getTimefun()">
					<option value="two">俩个月前完工工单不在显示</option>
					<option value="">--显示全部--</option>					
			   </select>
	</div>	
    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
		<button type="button" id="order1" onclick="openDiaO('vw_teljobhistory');">
			<!--组合排序--><fmt:message key="order.title" />
		</button>					   
		<button type="button" onclick="openDiaQueryG('query','vw_teljobhistory');">
			<!--查询--><fmt:message key="global.query" />
		</button>					   
	</div>
	
	<!-- 显示工单详细信息的面板 -->
		<div class="neirong" id="detailInfo"
			style="display: none; width: 850px;">
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							工单详细信息
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascritp:$('#detailinfoclose').click();">关闭</a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>

			</div>

			<div class="midd" style="height:350px;overflow-y: auto;overflow-x: hidden;">
				<form action="#" name="detailInfoform" id="detailInfoform"
					onsubmit="return false;">
					<table width="100%" id="tdiv" border="0"
						style="border: 1px; border-style: solid; border-color: #87CEFA;"
						cellspacing="0" cellpadding="0">
						
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>工单基本信息</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<input type="text"
										style="width: 0px; height: 0px; margin-left: -1000px"
										id="ian-tsd" />
									<!-- 转移焦点用的 -->
									<span id="thisJobID"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisJobIDvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisJobType"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisJobTypevalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thismqbm"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thismqbmvalue"></div>
							</td>
						</tr>

						<tr>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisUserID"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisUserIDvalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisArea"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisAreavalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisDepart"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisDepartvalue"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisidtype"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisidtypevalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisidcard"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisidcardvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisjobstate"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisjobstatevalue"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisIfCancel"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisIfCancelvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisisPay"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisisPayvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisPayMode"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisPayModevalue"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thissDh1"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissDh1value"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisiSimultaneous"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisiSimultaneousvalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisHth"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisHthvalue"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisJobRecTime"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisJobRecTimevalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisdevno"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisdevnovalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisPayType"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisPayTypevalue"></div>
							</td>
						</tr>
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>用户基本信息</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisoldsRealName"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisoldsRealNamevalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thissRealName"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissRealNamevalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thissDh2"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissDh2value"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thissRegDate"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissRegDatevalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisfeedendtime"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisfeedendtimevalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisiFeeTypeTime"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisiFeeTypeTimevalue"></div>
							</td>
						</tr>

						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisoldsAddress"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisoldsAddressvalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisoldspeed"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisoldspeedvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisspeed"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisspeedvalue"></div>
							</td>
						</tr>

						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisjobstatus"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisjobstatusvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisUserName"></span>
								</label>
							</td>
							<td width="20%" class="tdstyle">
								<div id="thisUserNamevalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisUserName1"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisUserName1value"></div>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thissAddress"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thissAddressvalue"></div>
							</td>

							<td class="labelclass">
								<label for="sarea">
									<span id="thisiStatus"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle" colspan="5">
								<div id="thisiStatusvalue"></div>
							</td>

						</tr>
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>电话业务基本信息</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisiFeeType"></span>
								</label>
							</td>

							<td class="tdstyle" colspan="5">
								<div id="thisiFeeTypevalue"></div>
							</td>
						</tr>
						<tr>
							
							<td class="labelclass">
								<label for="sarea">
									<span>新业务</span>
								</label>
							</td>

							<td class="tdstyle" colspan="5">
								<div id="thisnewyw"></div>
							</td>
							
						</tr>
						<tr>
							<td colspan="6">
								<table id="gdlc" width="98%" style="line-height: 30px"></table>
							</td>
						</tr>
						<tr>
							<td colspan="6" style="text-align: left" class="labelclass">
								<b>其他</b>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label for="sarea">
									<span id="thisifurgent"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle">
								<div id="thisifurgentvalue"></div>
							</td>
							<td class="labelclass">
								<label for="sarea">
									<span id="thismemo"></span>
								</label>
							</td>

							<td width="20%" class="tdstyle" colspan="5">
								<textarea disabled="disabled" rows="5" cols="70"
									style="margin-top: 2px" id="thismemovalue"></textarea>
							</td>
						</tr>
						
					</table>
				</form>
			</div>

			<div class="midd_butt">
				<button type="button" class="btn_2k3" id="detailinfoclose"
					style="width: 100px; margin-left: 10px">
					<fmt:message key="global.close" />
				</button>

			</div>
			
			<br />
			<br />
			<br />
			<br />
			
		</div>
	
	<div class="neirong" id="jobListDetailPanel" style="display:none;width:660px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						工单历史详细信息
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#jobListDetailPanelClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:660px;font-size:14px;">
			<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0" style="line-height: 33px; font-size: 12px;">
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lUserName"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="UserName" class="textclass" maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lJobType"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="JobType" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lJobRecTime"></label>
					</td>
					<td width="22%" align="left"
						style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="JobRecTime" class="textclass" maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lLsz"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="Lsz" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lUserID"></label>
					</td>
					<td width="22%" align="left"
						style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="UserID" class="textclass"
							maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lSdh"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="Sdh" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lsRealName"></label>
					</td>
					<td width="22%" align="left"
						style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="sRealName" class="textclass" maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lFee"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="Fee" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lFeeName"></label>
					</td>
					<td width="22%" align="left"
						style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="FeeName" class="textclass" maxlength="64" />
					</td>
					<td width="12%" align="right" class="labelclass">
						<label id="lPayMode"></label>
					</td>
					<td width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<input type="text" id="PayMode" maxlength="50" class="textclass" />
					</td>
				</tr>
				<tr>
					<td width="12%" align="right" class="labelclass">
						<label id="lmemo"></label>
					</td>
					<td colspan="3" width="22%" align="left" style="border-bottom: 1px solid #A9C8D9;">
						<textarea name="memo" id="memo" class="textclass" style="margin-left:5px;width:500px;height:100px;"></textarea>
					</td>
				</tr>
			</table>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="jobListDetailPanelClose">
				关闭
			</button>
		</div>
		
	</div>
	
	<!-- 导出数据 开始-->
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
								style="margin-left: 10px; max-height: 200px">

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
				onclick="getTheCheckedFieldstwo('tsdBilling','mssql','vw_teljobhistory','vw_teljobhistory');">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo">
				<fmt:message key="global.close" />
			</button>

		</div>
	</div>
	<input type="hidden" id="whickOper" />
			<input type="hidden" id="whickOper" />
		<input type="hidden" id="lanType" name="lanType"
			value='<%=languageType%>' />
		<input type="hidden" id="languageType" name="languageType"
			value='<%=languageType%>' />
	
	<!-- 导出数据 结束-->
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type='hidden' id='thisbasePath' value='<%=basePath %>' /> 
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
	<input type="hidden" id="rightgroup" />
		
  </body>
</html>