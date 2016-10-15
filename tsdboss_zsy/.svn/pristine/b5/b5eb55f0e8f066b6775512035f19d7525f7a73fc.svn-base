<%----------------------------------------
	name: weblog.jsp
	author: chenliang
	version: 1.0, 2010-11-04
	description: WEB用户日志查询
	modify: 
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String iconpath = basePath + "style/icon/";
	String userid = (String) session.getAttribute("userid");
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String languageType = (String) session.getAttribute("languageType");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title>weblog</title>
    
	<meta http-equiv="pragma" content="no-cache"/>
	<meta http-equiv="cache-control" content="no-cache"/>
	<meta http-equiv="expires" content="0" />    
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
<script type="text/javascript">
/**
 * 查看当前用户的扩展权限，对spower字段进行解析
 * @param 无参数
 * @return 无返回值
 */
function getUserPower(){
	 var urlstr=tsd.buildParams({ 	  packgname:'service',
				 					  clsname:'Procedure',
									  method:'exequery',
				 					  ds:'tsdBilling',//数据源名称 对应的spring配置的数据源
				 					  tsdpname:'weblog.getPower',//存储过程的映射名称
				 					  tsdExeType:'query',
				 					  datatype:'xmlattr'
			 					});
	/************************
	*   调用存储过程需要的参数 *
	**********************/
	var userid = '<%=userid %>';	
	var groupid = '<%=zid %>';
	var imenuid = '<%=imenuid %>';
	
	/****************
	*   拼接权限参数 *
	**************/
	var deleteright = '';
	var queryright = '';
	var exportright = '';
	
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
	
	var str = 'true';
	if(spower!=''&&spower!='all@'){
			var spowerarr = spower.split('@');
			for(var i = 0;i<spowerarr.length-1;i++){
				deleteright += getCaption(spower,'delete','')+'|';
				queryright += getCaption(spower,'query','')+'|';
				exportright += getCaption(spower,'export','')+'|';
			}
	}else if(spower=='all@'){
			$("#deleteright").val(str);
			$("#queryright").val(str);
			$("#exportright").val(str);
			flag = true;
	}	
	var hasdelete = deleteright.split('|');
	var hasquery = queryright.split('|');
	var hasexport = exportright.split('|');
	
	if(flag==false){
		for(var i = 0;i<hasdelete.length;i++){
			if(hasdelete[i]=='true'){
				$("#deleteright").val(str);
				break;
			}
		}
		for(var i = 0;i<hasquery.length;i++){
			if(hasquery[i]=='true'){
				$("#queryright").val(str);
				break;
			}
		}
		for(var i = 0;i<hasexport.length;i++){
			if(hasexport[i]=='true'){
				$("#exportright").val(str);
				break;
			}
		}
	}
}
</script>
<script type="text/javascript">
/**
 * 初始化数据
 * @param 无参数
 * @return 无返回值
 */
jQuery(document).ready(function () { 
//=====================显示导航菜单=================//
$("#navBar1").append(genNavv());
//解析用户权限
getUserPower();
 ///设置命令参数
 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
			 					clsname:'ExecuteSql',//类名
			 					method:'exeSqlData',//方法名
			 					ds:'tsdLog',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
			 					tsdcf:'mssql',//指向配置文件名称
			 					tsdoper:'query',//操作类型 
			 					datatype:'xml',//返回数据格式 
			 					tsdpk:'weblog.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 					tsdpkpagesql:'weblog.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
			 					});
var column  = '';
var thisdata = loadData('web_log','<%=languageType%>',2);
column = thisdata.FieldName.join(',');			 					
$('#thecolumn').val(column);

var delright = $("#deleteright").val();
if(delright=="true"){
	document.getElementById("opendel1").disabled=false;
	document.getElementById("opendel2").disabled=false;
}
var queryright = $("#queryright").val();
if(queryright=="true"){
	document.getElementById("query1").disabled=false;
	document.getElementById("query2").disabled=false;
}
var exportright = $("#exportright").val();
if(exportright=="true"){
	document.getElementById("exp1").disabled=false;
	document.getElementById("exp2").disabled=false;
}
var dislid = thisdata.getFieldAliasByFieldName('lid');
var dislogtime = thisdata.getFieldAliasByFieldName('logtime');
var disuserid = thisdata.getFieldAliasByFieldName('userid');
var dislogtype = thisdata.getFieldAliasByFieldName('logtype');
var disloginfo = thisdata.getFieldAliasByFieldName('loginfo');
var disipaddress = thisdata.getFieldAliasByFieldName('ipaddress');
var dismacaddress = thisdata.getFieldAliasByFieldName('macaddress');

//jqgrid隐藏某一列的值
thisdata.colModels[0].hidden=true;
thisdata.setWidth({Operation:20});		
jQuery("#editgrid").jqGrid({
	url:'mainServlet.html?cloumn='+column+urlstr, 
	datatype: 'xml', 
	colNames:thisdata.colNames, 
	colModel:thisdata.colModels, 
	       	rowNum:10, //默认分页行数
	       	rowList:[10,15,20], //可选分页行数
	       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
	       	pager: jQuery('#pagered'), 
	       	sortname: 'lid', //默认排序字段
	       	viewrecords: true, 
	       	//hidegrid: false, 
	       	sortorder: 'desc',//默认排序方式 
	       	caption:'web'+'<fmt:message key="weblog.userlogseek" />', 
	       	height:300, //高
	       	multiselect: true,
			multiselectWidth: 10,
	       	width:document.documentElement.clientWidth-52,
	       	loadComplete:function(){
							$("#editgrid").setSelection('0', true);
							$("#editgrid").focus();
							///自动适应 工作空间
							var reduceHeight=$("#navBar").height()+$("#operTitle").height()+$("#buttons").height()+$("#pagered").height();
							setAutoGridHeight("editgrid",reduceHeight);
							
							//addRowOperBtn('editgrid','<img src="style/images/public/ltubiao_01.gif" alt="删除"/>','deleteRow','lid','click',1);
							//executeAddBtn('editgrid',1);
			}
	}).navGrid('#pagered', {edit: false, add: false, add: false, del: false, search: false}, //options 
		{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
		{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
		{reloadAfterSubmit:false}, // del options 
		{} // search options 
		); 
});
</script>
<script type="text/javascript">
/**
 * 勾选记录
 * @param 无参数
 * @return 无返回值
 */
function deleteRows(){
	var arr = $('#editgrid').getGridParam('selarrrow');
	if(arr.length==0){
		//alert('请勾选您要删除的记录!');
		alert("<fmt:message key='weblog.checkrecordwilldelete' />");
		return false;
	}
	var str = '';
	if(arr.length>1){
		//str = '这些';
		str = "<fmt:message key='weblog.these' />"
	}else{
		//str = '这条';
		str = "<fmt:message key='weblog.this' />"
	}
	
	//if(confirm('您确定要删除'+str+'信息吗?')){
	if(confirm('<fmt:message key="weblog.willdelete" />'+str+'<fmt:message key="weblog.message" />')){
		var idarr = new Array();
		for(var i = 0 ; i < arr.length  ; i++){
			idarr.push($('#editgrid').getCell(arr[i],'lid'));
		}
		deleteRow(idarr);							
	}
}
/**
 * 删除记录
 * @param key(唯一标识)
 * @return 无返回值
 */
function deleteRow(key){
 	var deleteright = $("#deleteright").val();
	if(deleteright=="true"){
	 	//jConfirm('您确定要删除', operationtips, function(x) { if(x==true){ 
 		 var urlstr=tsd.buildParams({ 	packgname:'service',//java包
					 					clsname:'ExecuteSql',//类名
					 					method:'exeSqlData',//方法名
					 					ds:'tsdLog',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
					 					tsdcf:'mssql',//指向配置文件名称
					 					tsdoper:'exe',//操作类型 
					 					tsdpk:'weblog.delete'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
					 				});
			$.ajax({
				url:'mainServlet.html?'+urlstr+'&lid='+key,
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						//alert('删除成功!');
						alert("<fmt:message key='weblog.deletesuccess' />");
						reloadData();
					}	
				}
			});
		//}});
	}else{
		//alert('对不起，您无删除权限!');
		alert("<fmt:message key='weblog.nodeleteright' />");
	}
}
/**
 * 重载信息
 * @param 无参数
 * @return 无返回值
 */
function reloadData(){
	var urlstr=tsd.buildParams({ 	
		 					packgname:'service',//java包
		 					clsname:'ExecuteSql',//类名
		 					method:'exeSqlData',//方法名
		 					datatype:'xml',//返回数据格式 
		 					ds:'tsdLog',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		 					tsdcf:'mssql',//指向配置文件名称
		 					tsdoper:'query',//操作类型 
		 					tsdpk:'weblog.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		 					tsdpkpagesql:'weblog.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
		 				});
	var thecolumn = $('#thecolumn').val();
 	$("#editgrid").setGridParam({url:'mainServlet.html?'+urlstr+'&cloumn='+thecolumn}).trigger("reloadGrid");
 	setTimeout($.unblockUI, 15);//关闭面板
}
	
/**
 * 简单查询
 * @param 无参数
 * @return 无返回值
 */
function fuheExe(){
	var queryName= $('#queryName').val();
	if(queryName=="query"){
		fuheQuery('weblog.queryByWhere','weblog.queryByWherepage');
	}
}
/**
 * 查询模块
 * @param querysql(查询语句)
 * @param querypagesql(分页语句)
 * @return 无返回值
 */
function fuheQuery(querysql,querypagesql)
{
	var params = fuheQbuildParams();			
	if(params=='&fusearchsql='){
		params +='1=1';
	}	
			
 	//此处的url参数主要修改tsdpname（对应存储过程的名称）、tsdExeType(操作类型)			 	
 	var urlstr1=tsd.buildParams({  packgname:'service',//java包
								  clsname:'ExecuteSql',//类名
								  method:'exeSqlData',//方法名
								  ds:'tsdLog',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
								  tsdcf:'mssql',//指向配置文件名称
								  tsdoper:'query',//操作类型 
								  datatype:'xml',//返回数据格式 
								  tsdpk:querysql,//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								  tsdpkpagesql:querypagesql
								});
	var languageType = $('#languageType').val();					
	var link = urlstr1 + params+'&lang='+languageType;	
	var column = $('#thecolumn').val();
 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&cloumn='+column}).trigger("reloadGrid");
 	setTimeout($.unblockUI, 15);//关闭面板			
}

/**
 * 拼接要显示的数据列
 * @param tablename(表名)
 * @return 数组
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
						var thefieldalias = getCaption($(this).attr("field_alias"),'<%=languageType %>','');
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
<style type="text/css">
	.tdstyle{border-bottom:1px solid #A9C8D9;}
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
		<!-- 用户操作按钮 -->
		<div id="buttons" style="text-align: left">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="query1" disabled="disabled" onclick="openDiaQueryG('query','web_log')">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="opendel1" onclick="deleteRows()" 
				disabled="disabled">
				<fmt:message key="global.delete" />
			</button>
			<button type="button" id="exp1"
				onclick="thisDownLoad('tsdLog','mssql','web_log','<%=languageType %>',6)"
				disabled="disabled">
				<!--导出-->
				<fmt:message key="global.exportdata" />
			</button>
		</div>
		<!-- jqgrid显示区域 -->
		<div style="text-align: left">
			<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
			<div id="pagered" class="scroll" style="text-align: left;"></div>
		</div>
		<!-- 下方显示操作按钮 -->
		<div id="buttons" style="text-align: left">
			<!-- 这里的按钮可以自由更换 但格式要对 -->
			<button type="button" id="query2" disabled="disabled" onclick="openDiaQueryG('query','web_log')">
				<fmt:message key="global.query" />
			</button>
			<button type="button" id="opendel2" onclick="deleteRows()"
				disabled="disabled">
				<fmt:message key="global.delete" />
			</button>
			<button type="button" id="exp2"
				onclick="thisDownLoad('tsdLog','mssql','web_log','<%=languageType %>',6)"
				disabled="disabled">
				<!--导出-->
				<fmt:message key="global.exportdata" />
			</button>
		</div>

		<div class="neirong" id="thefieldsform"
			style="display: none; width: 800px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<!-- 选择您要导出的数据字段 -->
							<fmt:message key="weblog.chooseexportdata" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closethisinfo').click();">
						<!-- 关闭 -->
						<fmt:message key="weblog.close" />
						</a>
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
					<!-- 全选 -->
					<fmt:message key="weblog.selectall" />
				</button>
				<button type="submit" class="tsdbutton" id="query"
					onclick="getTheCheckedFields('tsdLog','mssql','web_log')">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>

		<input type='hidden' id="deleteright"/>
		<input type='hidden' id="queryright"/>
		<input type='hidden' id="exportright"/>
		<input type='hidden' id="thecolumn"/>
	</body>
</html>
