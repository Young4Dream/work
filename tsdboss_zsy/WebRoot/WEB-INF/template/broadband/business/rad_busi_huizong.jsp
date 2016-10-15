<%----------------------------------------
	name: 宽带账单汇总
	author: huoshuai
	version: 1.0, 2012-10-22
	description: 
	modify: 
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.tsd.service.util.Log" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
	if (!languageType.equals("en")) {
			languageType = "zh";
	}	

	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

  <head>    
	<title>账单汇总</title>
<!-- 导入的js文件 -->
	<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
	<script src="script/public/mainStyle.js" type="text/javascript"></script>
	<script src="style/js/mainStyle.js" type="text/javascript"></script>
	<!-- 弹出对话框需要导入的js文件 -->
	<script type="text/javascript" src="plug-in/jquery/ui/jquery.ui.draggable.js"></script>
	<!-- tab滑动门需要导入的包 *注意路径 -->
	<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
	<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
	<script type="text/javascript" src="script/public/transfer.js"></script>
	<!-- 弹出面板需要导入js文件 -->
	<script src="plug-in/jquery/jqueryblockUI/jquery.blockUI.js" type="text/javascript"></script>
	<!-- 关于字符串需要用到的js -->
	<script type="text/javascript" src="script/public/main.js"></script>
	<!-- 收费结账专用js -->
	<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
	<!-- 页面国际化 -->
	<script type="text/javascript" src="script/broadband/usercat/Internationalization.js"></script>
	<script src="script/pubMode/SingleTabE.js" type="text/javascript"></script>
<!-- 导入js文件结束 -->
<!-- 导入css文件开始 -->
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
	<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
	<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
	<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
	<!-- 分项卡 -->
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
	<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css"	type="text/css" media="projection, screen" />
<!-- 导入css文件结束 -->

	<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
	<script src="script/public/equery.js" type="text/javascript" language="javascript"></script>

	<style type="text/css">
		body{text-align:left;}
	</style>

	<script type="text/javascript">
		var Dat = "";
		var Clerks = "";
		var Sys_Config = "";
		var tablealiasName="vw_radhuizong";
		var languageType = '<%=languageType %>';//国际化标签
		var dataSource = 'broadband';
		var tablename='vw_radhuizong';
		var tabStatus = 1;
		$(function(){
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			
			Dat = loadData(tablealiasName,$("#languageType").val(),2);
			
			initialGrid();
		});
		
		/**
		 * 初始化页面宽带Grid
		 * @param  
		 * @return 
		 */
		function initialGrid()
		{
			var hzdate1=trim($("#HZ_date").val());
     		var hzname1=trim($("#HZ_name").val());
			
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mysql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'radhuizongQ.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'radhuizongQ.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			var params = fuheQbuildParams();			
			if(params=='&fusearchsql='){
					params +='1=1 ';
			}	
			if(hzname1!=null && hzname1!="" && hzname1!="undefined"){params+='and UserName=\''+hzname1+'\' '}
			if(hzdate1!=null && hzdate1!="" && hzdate1!="undefined"){params+='and hzyf=\''+hzdate1+'\' '}
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr+'&col='+Dat.FieldName.join(',') + params,
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				       	rowNum:30, //默认分页行数
				       	rowList:[30,50,100], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'hzsj', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'<fmt:message key="payList.kdjfgridtitle"/>',//"宽带缴费流水", 
				       	height:document.documentElement.clientHeight-140, //高
				       	width:document.documentElement.clientWidth-65,
				       	autowidth: true,
				       	shrinkToFit:false,
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
		//等待加载面板
		function loadBlockForm(){
				 //autoBlockForm("chooseJob","150","close","#FFFFFF",false); 
				 HZmethod();//账单汇总
        }
		/***********************************集成操作**********************
        **********************************************************************************/  
        ///汇总             
        function HZmethod(){
           		var hzdate=trim($("#HZ_date").val());
           		var hzname=trim($("#HZ_name").val());
           		
           		var urlstr=tsd.buildParams({ packgname:'service',//java包
						clsname:'Procedure',//类名
						method:'exequery',//方法名
						ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
						tsdExeType:'query',//操作类型 
						datatype:'xmlattr',//返回数据格式 
						tsdpname:'rad_busi_huizong.hzmethod'
				});	
				 $.ajax({
						url:'mainServlet.html?'+urlstr+'&a_username='+hzname+'&a_foot_month='+hzdate,
						datatype:'xml',
						cache:false,//如果值变化可能性比较大 一定要将缓存设成false
						timeout: 1000,
						async: false ,//同步方式
						success:function(xml){	
							$(xml).find('row').each(function(){
								var res = $(this).attr("result");
								if(res=='0'){
									alert('汇总程序成功执行完成！');
									var str='';
									if(hzname!=null && hzname!="" && hzname!="undefined"){
										str+='and UserName=\''+hzname+'\' '
									}
									if(hzdate!=null && hzdate!="" && hzdate!="undefined"){
										str+='and hzyf=\''+hzdate+'\' '
									}
									reloadDataHZ(str);
								}else if(res=='1'){
									setTimeout("alert(\'汇总程序已在运行,请稍后再试！\')",15);
								}else{
									var errinfo=$(this).attr("tag");
									alert('汇总程序执行错误'+errinfo+'！汇总失败。');
								}
								//$.unblockUI();
							});
						}
					});
           }
           
        function reloadDataHZ(str){
        	var urlstr=tsd.buildParams({ packgname:'service',//java包
					clsname:'ExecuteSql',//类名
					method:'exeSqlData',//方法名
					ds:'broadband',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
					tsdcf:'mysql',//指向配置文件名称
					tsdoper:'query',//操作类型 
					datatype:'xml',//返回数据格式 
					tsdpk:'radhuizongQ.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					tsdpkpagesql:'radhuizongQ.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			});
			var params = fuheQbuildParams();			
			if(params=='&fusearchsql='){
					params +='1=1 ';
			}	
			params += str;
			$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&col='+Dat.FieldName.join(',')+params}).trigger("reloadGrid");
        }
        
		/**
		 * 导出文件按钮执行方法
		 * @param 
		 * @return 
		 */
		function DownFile()
		{
			thisDownLoad('tsdBilling','mssql',tabStatus==2?"cz_JiaoFei":"radjiaofei",$("#languageType").val(),5);
		}
		/**
		 * 确认导出
		 * @param
		 * @return 
		 */
		function DownSure()
		{
			getTheCheckedFields(tabStatus==2?"tsdCharge":"broadband",tabStatus==2?"mssql":"mysql",tabStatus==2?"cz_JiaoFei":"radjiaofei");
		}
	</script>

  </head>
  
  <body>
	<form name="childform" id="childform" style="display: none">
		<input type="text" id="queryName" name="queryName" value="" />
		<input type="text" id="fusearchsql" name="fusearchsql" />
	</form>
	
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons">
			<label>汇总账号：</label>
			<input type="text" name="HZ_name" id="HZ_name" style="width: 80px;"/>
			<label>汇总月份：</label>
			<input type="text" name="HZ_date" id="HZ_date"  class="Wdate"  style="width: 80px;" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
			 onClick="WdatePicker({startDate:'yyyyMM',maxDate:'yyyyMM',readOnly:'true',dateFmt:'yyyyMM',alwaysUseStartDate:true});"/>
			<button type="button" id="HZ" onclick="loadBlockForm();">汇总</button>	
			<label></label>
			<button type="button" style="display: none;" onclick="openwinQ();">查询历史汇总账单</button>
			<label>导出月份：</label>
			<input type="text" name="download_date" id="download_date" class="Wdate" style="width: 80px;" onkeyup="value=value.replace(/[^\d]/g,'') "onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"
			 onClick="WdatePicker({startDate:'yyyyMM',maxDate:'yyyy{MM-1}',dateFmt:'yyyyMM',alwaysUseStartDate:true});"/>
			<button type="button" id="btndownload" onclick="openDiaDownLoad();" >导出汇总数据</button>
	</div>	
		<div id="gridd">
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>	
		</div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons" style="display: none">
		<button type="button" id="order1" onclick="openDiaO(tabStatus==2?'cz_JiaoFei':'v_radjiaofei');">
			<!--组合排序--><fmt:message key="order.title" />
		</button>					   
		<button type="button" onclick="openDiaQueryG('query',tabStatus==2?'cz_JiaoFei':'v_radjiaofei');">
			<!--查询--><fmt:message key="global.query" />
		</button>					   
	</div>
	<!-- 菜单ID -->
	<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="languageType" name="languageType" value='<%=languageType %>' />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="skrid" name="skrid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<input type='hidden' id='thislogtime' value='<%=Log.getThisTime() %>' />
	
	<form action="#" name="chooseJob" style="display: none;" id="chooseJob" onsubmit="return false;">
		<div id="input-Unit1"  align="center">
			<br />
			<div class="title" align="center">
				<h3>请稍等.数据正在汇总......</h3>
			</div>
		</div>
	</form>
	<div class="neirong" id="squeryform" style="display: none; width: 680px">
			
	</div>
	
	<!-- 导出数据 -->
	<div class="neirong" id="thefieldsform" style="display: none;width:700px">
		<div class="top">
			<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
						<div class="top_03" id="titlediv"><fmt:message key="SingleTabE.selField" /></div>
						<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
					</div>
					<div class="top_01right"><a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message key="global.close"/></a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
		</div>
		<div class="midd" >
			<form action="#" onsubmit="return false;">
				<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<div id="thelistform" style="margin-left: 10px;max-height: 200px;overflow-y: scroll;" >				
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div class="midd_butt">
			<button type="submit" class="tsdbutton" id="query" onclick="checkedAllFields();">
				<fmt:message key="SingleTabE.selectAll" />
			</button>
			<button type="submit" class="tsdbutton" id="query" onclick="exeDownLoad();">
				<fmt:message key="global.ok" />
			</button>
			<button type="button" class="tsdbutton" id="closethisinfo" >
				<fmt:message key="global.close" />
			</button>			
		</div>
	</div>	
	
  </body>
</html>
