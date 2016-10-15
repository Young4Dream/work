<%----------------------------------------
	name: hdjk.jsp
	author: 陈泽
	version: 1.0, 2010-11-04
	description: 话单告警
	modify: 
		2010-11-04 youhongyu 注释
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
	<title>话单告警</title>	
	
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
		<script type="text/javascript" src="plug-in/jquery/ui/jquery-ui-1.7.1.custom.js"></script>
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
				
		
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
		
	
	

	<script type="text/javascript" language="javascript">
	/**
	 *页面初始化
	 * @param
	 * @return 
	 */
	$(function(){
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			
			Dat = loadData("hdmx_warn",$("#lanType").val(),2);
			$("#tabs").tabs();
			initialGrid();//初始化话单告警jqgrid
			genTab();//生成业务类型复选框
	});
	
	//存放从别名表获取信息
	var Dat = "";
	
	/**
	 * 初始化话单告警jqgrid
	 * @param type：sqls数组下标，
	 * @return 
	 */	
	function initialGrid(type)
	{
			$("#gridd").empty();
			$("#gridd").append("<table id=\"editgrid\" class=\"scroll\" cellpadding=\"0\" cellspacing=\"0\"></table>");
			$("#gridd").append("<div id=\"pagered\" class=\"scroll\" style=\"text-align: left;\"></div>");
			
			/*
			var sqls = [["Hdgj.trans","Hdgj.del"],["Hdgj.q.trans","Hdgj.q.del"]];
			if(type!=1)
			{
				type=0;
			}
			
			var checkedWType = $("#tdiv input[type='checkbox'][id^='chk_auto_'][checked]");
			var checkedType = [];
			$(checkedWType).each(function(){
				checkedType.push(tsd.encodeURIComponent($(this).val()));
			});
			//alert(checkedType);
			var chartype = checkedType.join("','");
			chartype = "'" + chartype + "'";
			
			//判断HDMX_WARN_TMPC表是否存在，如果存在的话将其删除，
			//executeNoQuery("Hdgj.drop",2,"");
			var resexisted = fetchSingleValue("Hdgj.existd",2,"");
			if(resexisted!=undefined && resexisted!="" && resexisted!="0"){
				executeNoQuery("Hdgj.drop",2,"");
			}
			
			executeNoQuery(sqls[type][0],2,"&warn_type=" + chartype);//根据监控类型，将监控信息从Hdmx_warn放入到Hdmx_warn_tmpc表中
			//executeNoQuery(sqls[type][1],2,"&warn_type=" + chartype);//清空Hdmx_warn表的数据
			*/
			
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:"Hdgj.queryWarnAll",//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:"Hdgj.queryWarnAllCount"//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
									
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr + "&cols=" + Dat.FieldName.join(","),
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				       	rowNum:10, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Hssj', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'话单告警信息',//"宽带业务流水", 
				       	height:290, //高
				       	//width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
						},
						ondblClickRow:function(idx){
						}
						
				}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		
		
		function reloadData(){
			var cols = $("#column_hidden").val();
		    var urlstr=tsd.buildParams({ 
		    	packgname:'service',//java包
				clsname:'ExecuteSql',//类名
				method:'exeSqlData',//方法名
				ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
				tsdcf:'mssql',//指向配置文件名称
				tsdoper:'query',//操作类型 
				datatype:'xml',//返回数据格式 
				tsdpk:'Hdgj.queryWarnAll',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
				tsdpkpagesql:'Hdgj.queryWarnAllCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			var cols = Dat.FieldName.join(",");
		    $("#editgrid").setGridParam({
		        url:'mainServlet.html?'+urlstr +"&cols="+cols
		    }).trigger("reloadGrid");
		}
		
		
		/**
		 *打开告警类型设置
		 * @param 
		 * @return 
		 */
		function openConfig()
		{
			autoBlockForm('kjForm',20,'kjFormclose',"#ffffff",false);//弹出查询面板
		}
		
		
		function loadWarnHis(){
			var column  = '';
			var languageType = $("#languageType").val();
			var thisdata = loadData('hdmx_warn_his',$("#lanType").val(),1,'删除');
			thisdata.colModels[0].width = 50;
			column = thisdata.FieldName.join(',');
			$("#columnHidden").val(column);
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdBilling',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'hdgj.loadWarnHis',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'hdgj.loadWarnHisCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			var cols = Dat.FieldName.join(",");
			jQuery("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr +"&cols="+column,
				datatype: 'xml',
				colNames:thisdata.colNames,
				colModel:thisdata.colModels,
		       	rowNum:30, //默认分页行数
		       	rowList:[30,50,100], //可选分页行数
		       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
		       	pager: jQuery('#pagered'), 
		       	sortname: 'wdate', //默认排序字段
		       	viewrecords: true,
		       	sortorder: 'asc',//默认排序方式 
		       	caption:'历史告警话单信息', 
		       	height:290, //高
		        loadComplete:function(){
				       		//总行数
				       		//var total = jQuery("#editgrid").jqGrid('getGridParam', 'records'); //获取查询得到的总记录数量
				       		var total = jQuery("#editgrid").getGridParam('records');
				       		if($("#editgrid tr.jqgrow[id='1']").html()==""){
				       			return false;
				       		}
							$("#editgrid").setSelection('0', true);
							$("#editgrid").focus();
							addRowOperBtnimage('editgrid','deleteResortHis','ID','click',1,"style/images/public/ltubiao_02.gif",'删除',"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");//删除
							executeAddBtn('editgrid',1);
						},
				ondblClickRow: function(rowid){
				}
			}).navGrid('#pagered',  {edit: false, add: false, add: false, del: false, search: false}, //options 
				{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
				{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
				{reloadAfterSubmit:false}, // del options 
				{} // search options 
			); 
		}
		
	/**
	 *生成业务类型复选框
	 * @param 
	 * @return 
	 */
	function genTab()
	{
		var lineLen = 3;
		
		var result = fetchMultiValue("Hdgj.warntype",6,"");
		if(result[0]==undefined)
		{
			return false;
		}
		var tabHtml = "";
		for(var i=0;i<result.length;i++)
		{
			if((i+1)%lineLen==1)
			{
				tabHtml += "<tr>";
			}
			tabHtml += "<td>";
			
			tabHtml += "<label for=\"chk_auto_";
			tabHtml += i;
			tabHtml += "\">";
			tabHtml += result[i];				
			tabHtml += "</label>";
			tabHtml += "<input type=\"checkbox\" id=\"chk_auto_";
			tabHtml += i;
			tabHtml += "\" value=\"";
			tabHtml += result[i]
			tabHtml += "\" checked=\"checked\">";
			tabHtml += "<td>";
			if((i+1)%lineLen==0)
			{
				tabHtml += "<tr>";				
			}
		}
		//alert(tabHtml);
		$("#tdiv").html(tabHtml);
	}
		
	/**
	 *显示话单详细信息
	 * @param 
	 * @return 
	 */
	function thisInfo(id){
           	///设置命令参数
			 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
						 					clsname:'ExecuteSql',//类名
						 					method:'exeSqlData',//方法名
						 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 					tsdcf:'mssql',//指向配置文件名称
						 					tsdoper:'query',//操作类型 
						 					datatype:'xmlattr',//返回数据格式 
						 					tsdpk:'Hdjk.detail' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&ID='+id+'&tsdtemp='+Math.random(),
				datatype:'xml',
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(xml){
					$(xml).find('row').each(function(){
												
						for(var i=0;i<fields.length;i++)
						{
							var tmp = $(this).attr(fields[i].toLowerCase());
							
							if(tmp==undefined) tmp="";
							
							$("#val_"+fields[i]).html(tmp);
						}
						
					});
				}
			});
			
			autoBlockForm('detailInfo',20,'detailinfoclose',"#ffffff",false);//弹出查询面板		
	}
	/**
	 *获取选择值的真实值
	 * @param 
	 * @return 
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
	 * 选项卡切换事件，用于切换时执行相应的事件
	 * @param id 选项卡的编号
	 * @return 
	 */
	var tabStatus = 0;
	function tabsChg(id){
		$("#gridd").empty();
		$("#gridd").append('<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>');
		$("#gridd").append('<div id="pagered" class="scroll" style="text-align: left;"></div>');
		
		switch(id){
			case 1:
				$("#queryWarnHis").hide();
				$("#queryWarn").show();
				$("#clearWarn").show();
				initialGrid();
				$("#editgrid").trigger("reloadGrid");
				break;
			case 2:
				$("#queryWarn").hide();
				$("#clearWarn").hide();
				$("#queryWarnHis").show();
				loadWarnHis();
				$("#editgrid").trigger("reloadGrid");
				break;
			default:
				initialGrid();
		}
	}
	
	/************
	
	************/
	function openWarnPanel(){
		clearText('querywarnform');
		$("#warntype").val('0');
	    //弹出面板
	    autoBlockForm('querywarnform', 60, 'querywarnclose', "#ffffff", true);
	}
	
	function openWarnHisPanel(){
		clearText('querywarnhisform');
		$("#warnTypeHis").val('0');
	    //弹出面板
	    autoBlockForm('querywarnhisform', 60, 'querywarnhisclose', "#ffffff", true);
	}
	
	function queryWarn(){
		var thisdata = loadData('hdmx_warn',$("#lanType").val());
		column = thisdata.FieldName.join(',');
		
		var phone_num = $("#phoneNum").val();
	    var call_ee = $("#callee").val();
	    var h_th = $("#hth").val();
	    var warn_type = $("#warntype").val();
	    var start_time = $("#startTime").val();
	    var file_name = $("#fileName").val();
	    
	    var params = '';
	    params += '&phoneNum=' + tsd.encodeURIComponent(phone_num);
	    params += '&callee=' + tsd.encodeURIComponent(call_ee);
	    params += '&hth=' + tsd.encodeURIComponent(h_th);
	    params += '&warnType=' + tsd.encodeURIComponent(warn_type);
	    params += '&startTime=' + tsd.encodeURIComponent(start_time);
	    params += '&fileName=' + tsd.encodeURIComponent(file_name);
	    
	    var expparams = ' 1=1 ';
	    if (phone_num != '') {
	        expparams += " and dh like '%25" +tsd.encodeURIComponent(phone_num)+ "%25'";
	    }
	    if (call_ee != '') {
	        expparams += " and bjhm like '%25" +tsd.encodeURIComponent(call_ee)+ "%25'";
	    }
	    if (h_th != '') {
	        expparams += " and hth like '%25" +tsd.encodeURIComponent(h_th)+ "%25'";
	    }
	    if (warn_type != '0') {
	    	var warnTypeText = $('#warntype option:selected').text();
	        expparams += " and warn_type = '" +tsd.encodeURIComponent(warnTypeText)+ "'";
	    }
	    if (start_time != '') {
	        expparams += " and to_date(to_char(hssj,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('" + start_time + "','yyyy-mm-dd')";
	    }
	    if (file_name != '') {
	        expparams += " and filename like '%25" +tsd.encodeURIComponent(file_name)+ "%25'";
	    }
	    
	    var urlstr = tsd.buildParams({
	        packgname : 'service', //java包
	        clsname : 'ExecuteSql', //类名
	        method : 'exeSqlData', //方法名
	        datatype : 'xml', //返回数据格式 
	        ds : 'tsdLog', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	        tsdcf : 'mssql', //指向配置文件名称
	        tsdoper : 'query', //操作类型 
	        tsdpk : 'hdgj.queryWarn', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	        tsdpkpagesql : 'hdgj.queryWarnCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	    });
	    
	    $("#editgrid").setGridParam({
	        url : 'mainServlet.html?'+urlstr+'&cols='+column+'&expparams='+expparams
	    }).trigger("reloadGrid");
	    setTimeout($.unblockUI, 15);
	}
	
	
	function queryWarnHis(){
		var thisdata = loadData('hdmx_warn_his',$("#lanType").val());
		column = thisdata.FieldName.join(',');
		
		var phone_num = $("#phoneNumHis").val();
	    var call_ee = $("#calleeHis").val();
	    var h_th = $("#hthHis").val();
	    var warn_type = $("#warnTypeHis").val();
	    var start_time = $("#startTimeHis").val();
	    var file_name = $("#fileNameHis").val();
	    
	    var params = '';
	    params += '&phoneNum=' + tsd.encodeURIComponent(phone_num);
	    params += '&callee=' + tsd.encodeURIComponent(call_ee);
	    params += '&hth=' + tsd.encodeURIComponent(h_th);
	    params += '&warnType=' + tsd.encodeURIComponent(warn_type);
	    params += '&startTime=' + tsd.encodeURIComponent(start_time);
	    params += '&fileName=' + tsd.encodeURIComponent(file_name);
	    
	    var expparams = ' 1=1 ';
	    if (phone_num != '') {
	        expparams += " and dh like '%25" +tsd.encodeURIComponent(phone_num)+ "%25'";
	    }
	    if (call_ee != '') {
	        expparams += " and bjhm like '%25" +tsd.encodeURIComponent(call_ee)+ "%25'";
	    }
	    if (h_th != '') {
	        expparams += " and hth like '%25" +tsd.encodeURIComponent(h_th)+ "%25'";
	    }
	    if (warn_type != '0') {
	    	var warnTypeText = $('#warnTypeHis option:selected').text();
	        expparams += " and warn_type = '" +tsd.encodeURIComponent(warnTypeText)+ "'";
	    }
	    if (start_time != '') {
	        expparams += " and to_date(to_char(hssj,'yyyy-mm-dd'),'yyyy-mm-dd') = to_date('" + start_time + "','yyyy-mm-dd')";
	    }
	    if (file_name != '') {
	        expparams += " and filename like '%25" +tsd.encodeURIComponent(file_name)+ "%25'";
	    }
	    
	    var urlstr = tsd.buildParams({
	        packgname : 'service', //java包
	        clsname : 'ExecuteSql', //类名
	        method : 'exeSqlData', //方法名
	        datatype : 'xml', //返回数据格式 
	        ds : 'tsdLog', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	        tsdcf : 'mssql', //指向配置文件名称
	        tsdoper : 'query', //操作类型 
	        tsdpk : 'hdgj.queryWarnHis', //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	        tsdpkpagesql : 'hdgj.queryWarnHisCount'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
	    });
	    
	    $("#editgrid").setGridParam({
	        url : 'mainServlet.html?'+urlstr+'&cols='+column+'&expparams='+expparams
	    }).trigger("reloadGrid");
	    setTimeout($.unblockUI, 15);
	}
	
	
	function clearWarn(){
		var insertResult = false;
		var urlstr=tsd.buildParams({ 	
					packgname:'service',//java包
 					clsname:'ExecuteSql',//类名
 					method:'exeSqlData',//方法名
 					ds:'tsdLog',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
 					tsdcf:'mysql',//指向配置文件名称
 					tsdoper:'exe',//操作类型
 					tsdpk: 'hdgj.insertWarnHis'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
 		});	
 		$.ajax({
			url:'mainServlet.html?'+urlstr,
			cache:false,//如果值变化可能性比较大 一定要将缓存设成false
			timeout: 1000,
			async: false ,//同步方式
			success:function(msg){
				if(msg=="true"){
					insertResult = true;
				}
			}
		});
		if(insertResult){
			var urlstr=tsd.buildParams({ 	
						packgname:'service',//java包
	 					clsname:'ExecuteSql',//类名
	 					method:'exeSqlData',//方法名
	 					ds:'tsdLog',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
	 					tsdcf:'mysql',//指向配置文件名称
	 					tsdoper:'exe',//操作类型
	 					tsdpk: 'hdgj.deleteWarn'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
	 				});	
	 		$.ajax({
				url:'mainServlet.html?'+urlstr,
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						//重新加载表格
						reloadData();
					}
				}
			});
		}
	}
	</script>
  </head>
  
  <body>
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<!-- 用户操作标题以及放一些快捷按钮-->
	<div id="buttons">
		<button type="button" id="queryWarn" style="margin-left: 20px;" onclick="openWarnPanel()">
			查询
		</button>
		<button type="button" id="clearWarn" style="margin-left: 20px;" onclick="clearWarn()">
			清空告警
		</button>
		<button type="button" id="queryWarnHis" style="margin-left: 20px;display: none;" onclick="openWarnHisPanel()">
			查询
		</button>
	</div>
	
	<!-- Tabs -->
	<div id="tabs" style="overflow-x: scroll;" >	
		<ul>
			<li><a href="#gridd" onclick="tabsChg(1)"><span>话单告警信息</span></a></li>
			<li><a href="#gridd" onclick="tabsChg(2)"><span>话单告警历史信息</span></a></li>
		</ul>
		<div id="gridd">
		    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>
	</div>
	
	<div class="neirong" id="kjForm" style="display: none;width: 800px;">
		<div class="top">
			<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="titlediv">告警监控类型设置</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="javascritp:$('#kjFormclose').click();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>		
		</div>

		<div class="midd" >
		   <form action="#" name="operform" id="operform" onsubmit="return false;">
			<table width="100%" id="tdiv" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;" cellspacing="0" cellpadding="0">
			</table>
			</form>
		</div>	
		
		<div class="midd_butt">
			<button type="button" class="btn_2k3 tsdbutton" id="kjFormSave" style="width:100px;margin-left: 10px" onclick="initialGrid(1);$('#kjFormclose').click()">
				开始新监控
			</button>
			<button type="button" class="btn_2k3 tsdbutton" id="kjFormclose" style="width:100px;margin-left: 10px">
				<fmt:message key="global.close" />
			</button>
		</div>
	</div>
	
	<!-- 查询告警信息面板 -->
	<div class="neirong" id="querywarnform" style="display: none;width:670px">
			<div class="top">
				<div class="top_01" id="thisdrag">
						<div class="top_01left">
							<div class="top_02">
								<img src="style/images/public/neibut01.gif" />
							</div>
							<div class="top_03" id="titlediv">
								<!-- 查询 -->
								<fmt:message key="logManager.query" />
							</div>
							<div class="top_04">
								<img src="style/images/public/neibut03.gif" />
							</div>
						</div>
						<div class="top_01right"><a href="#" onclick="javascript:$('#querywarnclose').click();">
						<!-- 关闭 -->
						<fmt:message key="logManager.close" />
						</a></div>
				</div>
				<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
			<div class="midd" >
				   <form action="#" name="querylogforms" id="querylogforms" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
						<tr>	
							<td class="labelclass">
								<label id="phoneNumLabel">电话号码</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="phoneNum" style="width:180px" class="textclass"/>
							</td>
							<td class="labelclass">
								<label id="calleeLabel">被叫号码</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="callee" class="textclass"; style="width:180px"/>
							</td>
						</tr>
						<tr>	
							<td class="labelclass">
								<label id="hthLabel">合同号</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="hth" class="textclass"; style="width:180px"/>
							</td>
							<td class="labelclass">
								<label id="warnTypeLabel">告警类型</label>
							</td>
							<td class="tdstyle">
								<select name="seluserarea"  id="warntype" class="textclass" style="width:180px">
									<option value="0">请选择</option>
									<option value="1">无档主叫</option>
									<option value="2">无档被叫</option>
									<option value="3">超长话单</option>
									<option value="4">未定义中继局向</option>
									<option value="5">未定义呼叫类型</option>
									<option value="6">未定义被叫字冠</option>
									<option value="7">停机用户有话单</option>
									<option value="8">实时欠费用户有话单</option>
									<option value="9">越权话单</option>
									<option value="10">无效话单</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label id="startTimeLabel">话始时间</label>
							</td>
							<td class="tdstyle">
								<input type="text" class="textclass" style="width: 180px;" readonly="readonly" 
								name="stopdate" id="startTime" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
							</td>	
							<td class="labelclass">
								<label id="fileNameLabel">文件名称</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="fileName" style="width:180px" class="textclass"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="queryWarn()">
					<fmt:message key="global.query" />
				</button>
				<button type="button" class="tsdbutton" id="querywarnclose" style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
			</div>
	</div>
	
	
	<!-- 查询告警历史信息面板 -->
	<div class="neirong" id="querywarnhisform" style="display: none;width:670px">
			<div class="top">
				<div class="top_01" id="thisdrag">
						<div class="top_01left">
							<div class="top_02">
								<img src="style/images/public/neibut01.gif" />
							</div>
							<div class="top_03" id="titlediv">
								<!-- 查询 -->
								<fmt:message key="logManager.query" />
							</div>
							<div class="top_04">
								<img src="style/images/public/neibut03.gif" />
							</div>
						</div>
						<div class="top_01right"><a href="#" onclick="javascript:$('#querywarnhisclose').click();">
						<!-- 关闭 -->
						<fmt:message key="logManager.close" />
						</a></div>
				</div>
				<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
			</div>
			<div class="midd" >
				   <form action="#" name="querylogforms" id="querylogforms" onsubmit="return false;">
					<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
						<tr>	
							<td class="labelclass">
								<label id="phoneNumLabel">电话号码</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="phoneNumHis" style="width:180px" class="textclass"/>
							</td>
							<td class="labelclass">
								<label id="calleeLabel">被叫号码</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="calleeHis" class="textclass"; style="width:180px"/>
							</td>
						</tr>
						<tr>	
							<td class="labelclass">
								<label id="hthLabel">合同号</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="hthHis" class="textclass"; style="width:180px"/>
							</td>
							<td class="labelclass">
								<label id="warnTypeLabel">告警类型</label>
							</td>
							<td class="tdstyle">
								<select name="seluserarea" id="warnTypeHis" class="textclass" style="width:180px">
									<option value="0">请选择</option>
									<option value="1">无档主叫</option>
									<option value="2">无档被叫</option>
									<option value="3">超长话单</option>
									<option value="4">未定义中继局向</option>
									<option value="5">未定义呼叫类型</option>
									<option value="6">未定义被叫字冠</option>
									<option value="7">停机用户有话单</option>
									<option value="8">实时欠费用户有话单</option>
									<option value="9">越权话单</option>
									<option value="10">无效话单</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="labelclass">
								<label id="startTimeLabel">话始时间</label>
							</td>
							<td class="tdstyle">
								<input type="text" class="textclass" style="width: 180px;" readonly="readonly" 
								name="stopdate" id="startTimeHis" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
							</td>	
							<td class="labelclass">
								<label id="fileNameLabel">文件名称</label>
							</td>
							<td class="tdstyle">
								<input type="text" id="fileNameHis" style="width:180px" class="textclass"/>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" onclick="queryWarnHis()">
					<fmt:message key="global.query" />
				</button>
				<button type="button" class="tsdbutton" id="querywarnhisclose" style="margin-left: 10px">
					<fmt:message key="global.close" />
				</button>
			</div>
	</div>
	
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' /> 
  </body>
</html>
