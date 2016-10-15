<%----------------------------------------
	name: hdjk.jsp
	author: 陈泽
	version: 1.0, 2010-11-04
	description: 实时话单监控
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
	<title>实时话单监控</title>	
	
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
		<!-- 日期插件 -->	
		<script src="plug-in/My97DatePicker/WdatePicker.js" type="text/javascript"></script>		
		
		<!-- 验证数据长度 -->
		<script src="script/public/datalength.js" type="text/javascript"></script>
		<!-- 验证数据长度附 -->
		<script  src="script/public/infotest.js" type="text/javascript"></script>
		<!-- 操作列样式 -->
		<script src="script/public/public.js" type="text/javascript"></script>
		
		<!-- 分项卡 
		<script src="plug-in/jquery.tabs/jquery.tabs.js" type="text/javascript"></script>	
		-->		
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs.css" type="text/css" media="print, projection, screen" />
		<link rel="stylesheet" href="plug-in/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen"/>
				
		
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>

	
	<style type="text/css">
		.textclass{border:#FFF 1px none;}
	</style>
	
	<style type="text/css">
		hr {border:1px #A9C8D9 dotted;}
		.tdstyle{border-bottom:1px solid #A9C8D9;}
	</style>

	<script type="text/javascript" language="javascript">
	/**
	 *页面初始化
	 * @param
	 * @return 
	 */
	$(function(){
			//显示头部菜单
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			
				
			Dat = loadData("mxhdfj_tmp",$("#lanType").val(),2);
			Dat.setHidden(["ID"]);
						
			initialGrid();//初始化实时详单监控jqgrid
			
			autoRefresh();//定时刷新话单
			
			getField();//获取显示详单面板中的输入框的id
			
			thisDetailField();//给显示详单面板中的标签做国际化
		});
		
		var Dat = ""; 
		var users = "";
		var fields = [];
		
		/**
		 * 定时刷新话单
		 * @param name 
		 * @return 
		 */
		function autoRefresh()
		{
			var pl = 5;
			//从数据库中获取定时刷新时间
			var result = fetchSingleValue("Hdjk.time",6,"");
			if(result!="" && result!=undefined)
			{
				result = parseInt(result,10);
				if(isNaN(result))
				{
					result = 5;
				}
				pl = result;
			}
			
			if(pl<=0) pl = 1;
			
			pl = pl*60*1000;
			
			setInterval("refresh()",pl);//定时刷新jqgrid
			//setInterval("refresh()",60000);
		}
		
		/**
		 * 刷新jqgrid		 * 
		 * @param 
		 * @return 
		 */
		function refresh()
		{
			$("#editgrid").trigger("reloadGrid");
		}
		
		/**
		 * 立即分拣 
		 * @param 
		 * @return 
		 */
		function immedSort(){
			var urlstr=tsd.buildParams({ 
  								packgname:'service',//java包
						 		clsname:'ExecuteSql',//类名
						 		method:'exeSqlData',//方法名
						 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 		tsdcf:'mssql',//指向配置文件名称
						 		tsdoper:'exe',//操作类型 
						 		tsdpk:'hdjk.immedSort'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 });
			 $.ajax({
			 	url:'mainServlet.html?'+urlstr,
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						alert("命令执行成功！");
					}	
				}
						
			});
		}
		
		
		/**
		 * 重新分拣 
		 * @param 
		 * @return 
		 */
		function anewSort(){
			var startdate = $("#startdate").val();
			var stopdate = $("#stopdate").val();
			if(startdate==""){
				alert("起始日期不能为空！");
				$("#startdate").focus();
				return false;
			}
			if(null ==  stopdate){
				stopdate = "";
			}
			var urlstr=tsd.buildParams({ 
  								packgname:'service',//java包
						 		clsname:'ExecuteSql',//类名
						 		method:'exeSqlData',//方法名
						 		ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
						 		tsdcf:'mssql',//指向配置文件名称
						 		tsdoper:'exe',//操作类型 
						 		tsdpk:'hdjk.anewSort'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
			 });
			 $.ajax({
			 	url:'mainServlet.html?'+urlstr+"&startDate="+startdate+"&stopDate="+stopdate,
				cache:false,//如果值变化可能性比较大 一定要将缓存设成false
				timeout: 1000,
				async: false ,//同步方式
				success:function(msg){
					if(msg=="true"){
						alert("命令执行成功！");
					}	
				}
						
			});
		}
		
		/**
		 * 获取显示详单面板中的输入框的id
		 * @param name 
		 * @return 
		 */
		function getField()
		{
			var lbldom = $("#tdiv td label");
			
			$(lbldom).each(function(){
				var tmp = $(this).attr("for");
				tmp = tmp.replace("lb_","");
				fields.push(tmp);
			});
			return fields;
		}
		
		/**
		 * 初始化实时详单监控jqgrid
		 * @param
		 * @return 
		 */
		function initialGrid()
		{
			var urlstr=tsd.buildParams({ packgname:'service',//java包
									clsname:'ExecuteSql',//类名
									method:'exeSqlData',//方法名
									ds:'tsdCDR',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
									tsdcf:'mssql',//指向配置文件名称
									tsdoper:'query',//操作类型 
									datatype:'xml',//返回数据格式 
									tsdpk:'Hdjk.page',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									tsdpkpagesql:'Hdjk.pagec'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
									});
			
			var cols = Dat.FieldName.join(",");
			$("#editgrid").jqGrid({
				url:'mainServlet.html?'+urlstr +"&cols="+cols,
				datatype: 'xml', 
				colNames:Dat.colNames, 
				colModel:Dat.colModels, 
				       	rowNum:30, //默认分页行数
				       	rowList:[10,15,20], //可选分页行数
				       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
				       	pager: jQuery('#pagered'), 
				       	sortname: 'Hssj', //默认排序字段
				       	viewrecords: true, 
				       	sortorder: 'desc',//默认排序方式 
				       	caption:'实时详单监控',//"宽带业务流水", 
				       	height:350, //高
				       	//width:document.documentElement.clientWidth-27,
				       	loadComplete:function(){
							//var ids = $("#editgrid").getDataIDs();
							//alert(ids);
							//for(var i=0;i<ids.length;i++)
							//{
								//alert($("#editgrid").getRowData(ids[i]).UserID);
								//alert(users[$("#editgrid").getRowData(ids[i]).UserID]);
							//	$("#editgrid").setRowData(ids[i],{"UserID":users[$("#editgrid").getRowData(ids[i]).UserID]});
							//}
						},
						ondblClickRow:function(idx){
							//alert(idx);
							var id = $("#editgrid").getRowData(idx).ID;
							//alert(id);
							thisInfo(id);
						}
						
				}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false}, //options 
					{height:280,reloadAfterSubmit:true,closeAfterEdit:true}, // edit options 
					{height:280,reloadAfterSubmit:true,closeAfterAdd:true}, // add options 
					{reloadAfterSubmit:false}, // del options 
					{} // search options 
					); 
		}
		
		/**
		 * 显示话单详细信息
		 * @param name  id 话单对应的id值
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
		 * 获取选择值的真实值
		 * @param name 
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
		 * 给显示详单面板中的标签做国际化
		 * @param name 
		 * @return 
		 */       
      function thisDetailField(){
          	var thisdata = loadData('mxhdfj_tmp','<%=languageType %>',1);			
			for(var i=0;i<fields.length;i++)
			{
				$("#lbl_"+fields[i]).html(thisdata.getFieldAliasByFieldName(fields[i]));
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
	<div id="buttons" style="margin-bottom: 0px">
		<button type="button" onclick="refresh()">
			手动刷新
		</button>
		<button type="button" onclick="immedSort()" style="display: none;">
			立即分拣
		</button>
		<!--
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		起始时间
		<input type="text" style="padding-bottom: 5px;margin-bottom: 5px; width: 120px;" readonly="readonly" name="startdate" id="startdate" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" />
		截止时间
		<input type="text" style="padding-bottom: 5px;margin-bottom: 5px; width: 120px;" readonly="readonly" name="stopdate" id="stopdate" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /> 
		 -->
		<button type="button" onclick="anewSort()" style="display: none;">
			重新分拣
		</button>
	</div>
    <table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
	<div id="pagered" class="scroll" style="text-align: left;"></div>
	<!-- 用户操作标题以及放一些快捷按钮-->		
	<div id="buttons" style="display: none">
		<button type="button" onclick="refresh()">
			手动刷新
		</button>
	</div>
	
	<div class="neirong" id="detailInfo" style="display: none;width: 800px;">
		<div class="top">
			<div class="top_01">
				<div class="top_01left">
					<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
					<div class="top_03" id="titlediv">话单详细信息</div>
					<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
				</div>
				<div class="top_01right"><a href="#" onclick="javascritp:$('#detailinfoclose').click();">关闭</a></div>
			</div>
			<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>		
		</div>

		<div class="midd" >
		   <form action="#" name="operform" id="operform" onsubmit="return false;">
			<table width="100%" id="tdiv" border="0" style="border: 1px; border-style: solid; border-color: #87CEFA;" cellspacing="0" cellpadding="0">
					
					<tr>
						<td class="labelclass">
							<label for="lb_ID">
								<span id="lbl_ID"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="val_ID"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_Yhmc">
								<span id="lbl_Yhmc"></span>
							</label>
						</td>						
						<td width="20%" class="tdstyle">
							<div id="val_Yhmc"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_ServiceType">
								<span id="lbl_ServiceType"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="val_ServiceType"></div>
						</td>
					</tr>
					
					<tr>
						<td class="labelclass">
							<label for="lb_Dh">
								<span id="lbl_Dh"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="val_Dh"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_Thlx">
								<span id="lbl_Thlx"></span>
							</label>
						</td>						
						<td width="20%" class="tdstyle">
							<div id="val_Thlx"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_Hssj">
								<span id="lbl_Hssj"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="val_Hssj"></div>
						</td>
					</tr>
					
					<tr>
						<td class="labelclass">
							<label for="lb_Hzsj">
								<span id="lbl_Hzsj"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="val_Hzsj"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_Thsc">
								<span id="lbl_Thsc"></span>
							</label>
						</td>						
						<td width="20%" class="tdstyle">
							<div id="val_Thsc"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_iThsc">
								<span id="lbl_iThsc"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="val_iThsc"></div>
						</td>
					</tr>
					
					<tr>
						<td class="labelclass">
							<label for="lb_wThlx">
								<span id="lbl_wThlx"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="val_wThlx"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_Zjjx">
								<span id="lbl_Zjjx"></span>
							</label>
						</td>						
						<td width="20%" class="tdstyle">
							<div id="val_Zjjx"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_ZjjxZu">
								<span id="lbl_ZjjxZu"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="val_ZjjxZu"></div>
						</td>
					</tr>
					
					<tr>
						<td class="labelclass">
							<label for="lb_ZjMkj">
								<span id="lbl_ZjMkj"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="val_ZjMkj"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_CallerDevID">
								<span id="lbl_CallerDevID"></span>
							</label>
						</td>						
						<td width="20%" class="tdstyle">
							<div id="val_CallerDevID"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_CallerDevIP">
								<span id="lbl_CallerDevIP"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="val_CallerDevIP"></div>
						</td>
					</tr>
					
					<tr>
						<td class="labelclass">
							<label for="lb_IsRedup">
								<span id="lbl_IsRedup"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="val_IsRedup"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_Tfcs">
								<span id="lbl_Tfcs"></span>
							</label>
						</td>						
						<td width="20%" class="tdstyle">
							<div id="val_Tfcs"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_Tfhf">
								<span id="lbl_Tfhf"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="val_Tfhf"></div>
						</td>
					</tr>
					
					<tr>
						<td class="labelclass">
							<label for="lb_NetName">
								<span id="lbl_NetName"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="val_NetName"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_SessionType">
								<span id="lbl_SessionType"></span>
							</label>
						</td>						
						<td width="20%" class="tdstyle">
							<div id="val_SessionType"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_Fuf">
								<span id="lbl_Fuf"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="val_Fuf"></div>
						</td>
					</tr>
					
					<tr>
						<td class="labelclass">
							<label for="lb_Fjf">
								<span id="lbl_Fjf"></span>
							</label>
						</td>
						<td width="20%" class="tdstyle">
							<div id="val_Fjf"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_ReceivedBytes">
								<span id="lbl_ReceivedBytes"></span>
							</label>
						</td>						
						<td width="20%" class="tdstyle">
							<div id="val_ReceivedBytes"></div>
						</td>
						
						<td class="labelclass">
							<label for="lb_AccountsNumber">
								<span id="lbl_AccountsNumber"></span>
							</label>
						</td>
						
						<td width="20%" class="tdstyle">
							<div id="val_AccountsNumber"></div>
						</td>
					</tr>
								
				</table>
			</form>
		</div>	
		
		<div class="midd_butt">
			<button type="button" class="btn_2k3 tsdbutton" id="detailinfoclose" style="width: 100px;margin-left: 10px">
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
