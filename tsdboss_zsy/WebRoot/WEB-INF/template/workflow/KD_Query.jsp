<%----------------------------------------
	name: KD_Query.jsp
	author: wxm
	version: 1.0, 2013-01-25
	description: 宽带工单查询
	modify: 
			
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
	String languageType = (String) session.getAttribute("languageType");
	String deptname = (String) session.getAttribute("departname");//当前工号所在部门
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>KD_query</title>
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
		<script type="text/javascript"
			src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<!-- 关于字符串需要用到的js -->
		<script type="text/javascript" src="script/public/main.js"></script>
		<script type="text/javascript" src="script/public/transfer.js"></script>
		<script src="script/public/revenue.js" type="text/javascript"
			language="javascript"></script>
		<script src="script/public/phoneservice.js" type="text/javascript"
			language="javascript"></script>
		<script src="script/public/phoneservicenew.js" type="text/javascript"
			language="javascript"></script>
		<script src="script/public/public.js" type=text/javascript
			language="javascript"></script>
		<link href="style/css/public/xin.css" rel="stylesheet" type="text/css" />
		<!-- 新的面板样式 -->
		<style type="text/css">
hr {
	border: 1px #A9C8D9 dotted;
}

.tdstyle {
	border-bottom: 1px solid #A9C8D9;
}

#gdlc td {
	border: 1px solid #A9C8D9;
}

#gdlc {
	border-collapse: collapse;
}

.btn_2k3 {
	BORDER-RIGHT: #87CEFA 1px solid;
	PADDING-RIGHT: 2px;
	BORDER-TOP: #87CEFA 1px solid;
	PADDING-LEFT: 2px;
	FONT-SIZE: 12px;
	FILTER: progid :     DXImageTransform.Microsoft.Gradient (    
		GradientType =     0, StartColorStr =     #FFFFFF, EndColorStr =    
		#87CEFA );
	BORDER-LEFT: #87CEFA 1px solid;
	CURSOR: hand;
	COLOR: black;
	PADDING-TOP: 2px;
	BORDER-BOTTOM: #87CEFA 1px solid
}
</style>
		<script language="javascript" type="text/javascript">
		/**
	 * 初始化
	 * @param 无参数
	 * @return 无返回值
	 */
	$(function(){
			$("#navBar").append(genNavv());		
			gobackInNavbar("navBar");
			loadJqgrid();
			$("#tdiv :text").attr("disabled","disabled");
		});
		
	/*********
			* 加载jqgrid
			* @param;
			* @return;
		    **********/
			function loadJqgrid(){						
					var fusearchsql = $("#fusearchsql").val();
					if(fusearchsql=='')
					{
						var params ='&fusearchsql=1=1';
					}		
					/////设置命令参数 用于初始化jqgrid
					var urlstr=tsd.buildParams({ 	  
												packgname:'service',//java包
												clsname:'ExecuteSql',//类名
												method:'exeSqlData',//方法名
												ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
												tsdcf:'mssql',//指向配置文件名称
												tsdoper:'query',//操作类型 
												datatype:'xml',//返回数据格式 
												tsdpk:'KDJOB.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
												tsdpkpagesql:'KDJOB.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});
					var column = "JobID,JobID,INTERNETACCT,BUSITYPE,(select showname from ywsl_code where ywlx=BUSITYPE),decode(CANCEL,'N',"+tsd.encodeURIComponent("'否'")+","+tsd.encodeURIComponent("'是'")+") as ywls,decode(COMPLETE,'N',"+tsd.encodeURIComponent("'否'")+","+tsd.encodeURIComponent("'是'")+"),COMPLETEDATE,UserID,JOBDATE";
					var navv = document.location.search;
					//获取url中变量为imenuname的属性值
					var infoo = decodeURIComponent(parseUrl(navv,"imenuname",""));	
					jQuery("#editgrid").jqGrid({
						url:'mainServlet.html?'+urlstr+'&column='+column+params,
						datatype: 'xml', 
						//colNames:col[0],
						colNames:['JobID','查看','宽带账号','ywlx','业务类型','是否撤销','是否完工','完工日期','受理人员','受理时间','历时时间（小时）'],
						colModel:[{name:'JobID',index:'JobID',hidden:true,width:0},
									{name:'viewOperation',index:'viewOperation',width:50},
			    		   			{name:'INTERNETACCT',index:'INTERNETACCT',width:100},
									{name:'BUSITYPE',index:'BUSITYPE',hidden:true,width:0},
				           			{name:'ywlx',index:'ywlx',width:150},
				           			{name:'CANCEL',index:'CANCEL',width:100},
				           			{name:'COMPLETE',index:'COMPLETE',width:100},
				           			{name:'COMPLETEDATE',index:'COMPLETEDATE',width:150},
				           			{name:'UserID',index:'UserID',width:150},
									{name:'JOBDATE',index:'JOBDATE',width:150},
				           			{name:'lssj',index:'lssj',width:150}
				           		],
						       	rowNum:10, //默认分页行数
						       	rowList:[10,15,20], //可选分页行数
						       	imgpath:'plug-in/jquery/jqgrid/themes/basic/images/', 
						       	pager: jQuery('#pagered'), 
						       	sortname: 'JOBDATE', //默认排序字段
						       	viewrecords: true,
						       	sortorder: 'desc',//默认排序方式 
						       	caption:infoo,
						       	height:300, //高
						        //width:document.documentElement.clientWidth-27,
						       	loadComplete:function(){
											addRowOperBtn('editgrid','<img src=\"style/images/public/ltubiao_03.gif\"/>','queryJob','JobID','click',1,'BUSITYPE');
										    executeAddBtn('editgrid',1);
								}
						}).navGrid('#pagered',{edit: false, add: false, add: false, del: false, search: false},
							{height:280,reloadAfterSubmit:true,closeAfterEdit:true},
							{height:280,reloadAfterSubmit:true,closeAfterAdd:true},
							{reloadAfterSubmit:false},
							{}
							); 
			}
			
			function queryJob(jobid,BUSITYPE){
					$.ajax(
					{
						url : 'workflow?jobid=' + jobid + '&opertype=2&tsdtemp=' + Math.random(), 
					  cache : false,timeout : 3000, async : false , //同步方式
					success : function (msg){
								//kdsetup
								if(msg!='' ){
									var valarr = msg.split('~');
									if(valarr[0]!='FAILED'){
										//$('#kdmqbm').text(mqbm);
										var thisYwlx = BUSITYPE;
										var kdinfoarr = valarr[0].split('@');
										var kdbusiarr = valarr[1].split('@');
										for(var i = 0 ; i < kdinfoarr.length;i++){
											$('#kdjobinfo'+i).text('null'==kdinfoarr[i]?'':kdinfoarr[i]);
										}
										for(var i = 0 ; i < kdbusiarr.length;i++){
											$('#kd'+thisYwlx+''+i).html('null'==kdbusiarr[i]?'':kdbusiarr[i]);
										}
										if(BUSITYPE!=''){
											$('#tdiv_'+BUSITYPE).hide();
										}
										$('#tdiv_'+thisYwlx+'').show();
										if(thisYwlx=='setup'){
											$('#kdsetup221').val($('#kdsetup22').text());
											$('#kdsetup232').val($('#kdsetup23').text());
										}
									}else{
										alert(valarr[1]);
									}
								}
							  }
					});
					if('<%=deptname%>'=='宽带机房' || '<%=deptname%>'=='宽带归档' || '<%=deptname%>'=='系统管理员'){
						$('#editfeedate').show();
					}else{
						$('#editfeedate').hide();
					}
				query112Job_pglc(jobid);
				autoBlockForm('detailInfo', 20, 'detailinfoclose', "#ffffff", false);
			}
			
			 /**
		 * 取工单流程
		 * @param jobid
		 * @return 无返回值
		 */
       function query112Job_pglc(jobid){
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
						 					tsdpk:'KDJob.queryflow' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
						 					});
				$.ajax({
							url:'mainServlet.html?'+urlstr+'&jobid='+jobid+'&tsdtemp='+Math.random(),
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 5000,
							async: false ,//同步方式
							success:function(xml){
								info = '<tr class=\"dynamicadd\"><td class=\"labelclass\" colspan=\"7\" width=\"100%\" height=\"32\" style=\"text-align:left;\"><b><span>工单流程信息</span></b></td></tr>' + info;								
								var i = 1;
								$(xml).find('row').each(function(){
									if($(this).attr("id")!=undefined){
										//有返回值
										hasvalue = true;
										var jobid = $(this).attr("id");
										var PgID = $(this).attr("pgid");
										var Fsbm = $(this).attr("fsbm");
										if(Fsbm==undefined){
											Fsbm = '';
										}
										var Fsry = $(this).attr("fsry");
										if(Fsry==undefined){
											Fsry = '';
										}
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
										var Ry = $(this).attr("ry");
										if(Ry==undefined){
											Ry = '';
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
										var Wcrq = $(this).attr("wcrq");
										if(Wcrq==undefined){
											Wcrq = '';
										}
										info += "<tr>";
										info += "<td  class=\"tdstyle\"><div>";
										info += Fsbm;
										info += "</div></td>";															
										info += "<td>";
										info += Fsry;
										info += "</td>";									
										info += "<td class=\"tdstyle\" style='width:160px'>";
										info += Fsrq;
										info += "</td>";
										info += "<td class=\"tdstyle\"><div>";
										info += Bm;
										info += "</div></td>";															
										info += "<td class=\"tdstyle\"><div>";
										info += Ry;
										info += "</div></td>";								
										info += "<td class=\"tdstyle\"><div>";
										info += OperTime;
										info += "</div></td>";										
										info += "<td class=\"tdstyle\"><div>";
										info += Bz;
										info += "</div></td>";							
										info += "</tr>";
									}else{

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
					}
					$("#gdlc").html(info);
		}
		
		/**
		 * 复合查询操作
		 * @param 无参数
		 * @return 无返回值
		 */
		function fuheQuery()
		{
		 	var urlstr=tsd.buildParams({ 	  
							packgname:'service',//java包
							clsname:'ExecuteSql',//类名
							method:'exeSqlData',//方法名
							ds:'tsdReport',//数据源名称 对应的 WEB-INF/classes/ApplicationContent.xml中配置的数据源
							tsdcf:'mssql',//指向配置文件名称
							tsdoper:'query',//操作类型 
							datatype:'xml',//返回数据格式 
							tsdpk:'KDJOB.query',//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
							tsdpkpagesql:'KDJOB.querypage'//依赖tsdpk 用于计算分页的sql配置名称应在tsdcf配置的文件中指定
					});				
			var params = fuheQbuildParams();			
			if(params=='&fusearchsql='){
				params +='1=1';
			}
			var link = urlstr + params;
			var column = "JobID,JobID,INTERNETACCT,(select showname from ywsl_code where ywlx=BUSITYPE),decode(CANCEL,'N',"+tsd.encodeURIComponent("'否'")+","+tsd.encodeURIComponent("'是'")+"),decode(COMPLETE,'N',"+tsd.encodeURIComponent("'否'")+","+tsd.encodeURIComponent("'是'")+"),COMPLETEDATE,UserID,JOBDATE";
		 	$("#editgrid").setGridParam({url:'mainServlet.html?'+link+'&column='+column}).trigger("reloadGrid");
			//$("#fusearchsql").val("");
			setTimeout($.unblockUI, 15);//关闭面板	
		}
		/********************************
			 **复合查询参数获取
			 **@oper 操作类型 fuhe 
			************************************/	
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

			/*********
			* 执行复合查询出提交过来的相应操作
			* @param;
			* @return;
		    **********/
			function fuheExe()
			{
					fuheQuery();					
			}
			
			
			function exeDownLoad(){	
				getTheCheckedFields('tsdBilling','mssql','radjob','radjob');
			}
			
			
			
		</script>
	</head>
	<body>
		<div id="navBar">
			<img src="style/icon/dot11.gif" />
			<fmt:message key="global.location" />
			:
		</div>
		</div>
		<!-- 用户操作标题以及放一些快捷按钮 头部-->
		<div id="buttons">
			<!--高级查询-->
			<button type="button" id='gjquery1'
				onclick="openDiaQueryG('query','radjob');">
				<fmt:message key="oper.queryA" />
			</button>
			<button type="button" id="export1"
				onclick="thisDownLoad('tsdBilling','mssql','radjob','<%=languageType%>',4);">
				<!--导出-->
				<fmt:message key="global.exportdata" />
			</button>
		</div>

		<table id="editgrid" class="scroll" cellpadding="0" cellspacing="0"></table>
		<div id="pagered" class="scroll" style="text-align: left;"></div>


		<!-- 导出数据 -->
		<input type="hidden" id="whickOper" />
		<input type="hidden" id="lanType" name="lanType"
			value='<%=languageType%>' />
		<input type="hidden" id="lanType" name="languageType"
			value='<%=languageType%>' />

		<!-- 导出面板 开始 -->
		<div class="neirong" id="thefieldsform"
			style="display: none; width: 700px">
			<div class="top">
				<div class="top_01" id="thisdrag">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03" id="titlediv">
							<fmt:message key="SingleTabE.selField" />
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="javascript:$('#closethisinfo').click();"><fmt:message
								key="global.close" /> </a>
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
									style="margin-left: 10px; max-height: 200px; overflow-y: scroll;">
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
			<div class="midd_butt">
				<button type="submit" class="tsdbutton" id="query"
					onclick="checkedAllFields();">
					<fmt:message key="SingleTabE.selectAll" />
				</button>
				<button type="submit" class="tsdbutton" id="query"
					onclick="exeDownLoad();">
					<fmt:message key="global.ok" />
				</button>
				<button type="button" class="tsdbutton" id="closethisinfo">
					<fmt:message key="global.close" />
				</button>
			</div>
		</div>



		<!-- 添加修改面板 开始-->
		<div class="neirong" id="detailInfo" style="display: none"
			style="width:900px;">
			<br />
			<div class="top">
				<div class="top_01">
					<div class="top_01left">
						<div class="top_02">
							<img src="style/images/public/neibut01.gif" />
						</div>
						<div class="top_03">
							查看详细
						</div>
						<div class="top_04">
							<img src="style/images/public/neibut03.gif" />
						</div>
					</div>
					<div class="top_01right">
						<a href="#" onclick="setTimeout($.unblockUI, 15);"><span
							style="margin-left: 5px;"><fmt:message key="global.close" />
						</span> </a>
					</div>
				</div>
				<div class="top02right">
					<img src="style/images/public/toptiaoright.gif" />
				</div>
			</div>
			<div class="midd">
				<div
					style="max-height: 315px; overflow-y: auto; overflow-x: hidden;">
					<form id='operformT1' name="operformT1" onsubmit="return false;"
						action="#">
						<input type="hidden"></input>
						<table width="100%" id="tdiv_ywjb" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA;"
							cellspacing="0" cellpadding="0">
							<tr>
								<td colspan="6" style="text-align: left" class="labelclass">
									<b>业务基本信息<input type="text"
											style="width: 1px; height: 1px; margin-left: -100px" /> </b>
								</td>
							</tr>
						</table>

						<!-- 装机显示业务信息 -->
						<table width="100%" id="tdiv_setup" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr height="35px" id="editfeedate">
								<td class="labelclass">
									计费开始日期
								</td>
								<td width="20%" class="tdstyle">
									<input type="text" class="textclass" id="kdsetup221"
										style="width: 145px; height: 22px; line-height: 22px; margin-left: 5px"
										onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
									<label id="kdsetup22" style="display: none"></label>
								</td>
								<td class="labelclass">
									计费截止日期
								</td>
								<td width="20%" class="tdstyle">
									<input type="text" class="textclass" id="kdsetup232"
										style="width: 145px; height: 22px; line-height: 22px; margin-left: 5px"
										onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
									<label id="kdsetup23" style="display: none"></label>
								</td>
								<td class="labelclass" colspan="2">
								</td>
							</tr>
							<tr>
								<td class="labelclass">
									用户姓名
								</td>
								<td width="20%" class="tdstyle" id="kdsetup0"></td>
								<td class="labelclass">
									用户地址
								</td>
								<td width="20%" class="tdstyle" id="kdsetup1" colspan="3">
									123
								</td>
							</tr>
							<tr>
								<td class="labelclass">
									用户类型
								</td>
								<td width="20%" class="tdstyle" id="kdsetup2"></td>
								<td class="labelclass">
									用户性质
								</td>
								<td width="20%" class="tdstyle" id="kdsetup3"></td>
								<td class="labelclass">
									装机日期
								</td>
								<td width="20%" class="tdstyle" id="kdsetup4"></td>
							</tr>
							<tr>
								<td class="labelclass">
									用户套餐
								</td>
								<td width="20%" class="tdstyle" id="kdsetup5"></td>
								<td class="labelclass">
									用户部门
								</td>
								<td width="20%" class="tdstyle" id="kdsetup6"></td>
								<td class="labelclass">
									二级部门
								</td>
								<td width="20%" class="tdstyle" id="kdsetup7"></td>
							</tr>
							<tr>
								<td class="labelclass">
									三级部门
								</td>
								<td width="20%" class="tdstyle" id="kdsetup8"></td>
								<td class="labelclass">
									四级部门
								</td>
								<td width="20%" class="tdstyle" id="kdsetup9"></td>
								<td class="labelclass">
									接入类型
								</td>
								<td width="20%" class="tdstyle" id="kdsetup10"></td>
							</tr>
							<tr>
								<td class="labelclass">
									证件类型
								</td>
								<td width="20%" class="tdstyle" id="kdsetup11"></td>
								<td class="labelclass">
									证件号码
								</td>
								<td width="20%" class="tdstyle" id="kdsetup12"></td>
								<td class="labelclass">
									移动电话
								</td>
								<td width="20%" class="tdstyle" id="kdsetup13"></td>
							</tr>
							<tr>
								<td class="labelclass">
									联系人
								</td>
								<td width="20%" class="tdstyle" id="kdsetup14"></td>
								<td class="labelclass">
									联系电话
								</td>
								<td width="20%" class="tdstyle" id="kdsetup15"></td>
								<td class="labelclass">
									绑定电话
								</td>
								<td width="20%" class="tdstyle" id="kdsetup16"></td>
							</tr>
							<tr>
								<td class="labelclass">
									付费类型
								</td>
								<td width="20%" class="tdstyle" id="kdsetup17"></td>
								<td class="labelclass">
									合同号
								</td>
								<td width="20%" class="tdstyle" id="kdsetup18"></td>
								<td class="labelclass">
									密码
								</td>
								<td width="20%" class="tdstyle" id="kdsetup19"></td>
							</tr>
							<tr>
								<td class="labelclass">
									备注
								</td>
								<td width="20%" class="tdstyle" id="kdsetup20" colspan="5"></td>
							</tr>
						</table>

						<!-- 移机显示业务信息 -->
						<table width="100%" id="tdiv_move" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									用户原地址
								</td>
								<td width="84%" class="tdstyle" id="kdmove0" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									用户新地址
								</td>
								<td width="84%" class="tdstyle" id="kdmove1" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									备注
								</td>
								<td width="84%" class="tdstyle" id="kdmove3" colspan="5"></td>
							</tr>
						</table>

						<!-- 拆机显示业务信息 -->
						<table width="100%" id="tdiv_delete" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									拆机日期
								</td>
								<td width="84%" class="tdstyle" id="kddelete0" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									备注
								</td>
								<td width="84%" class="tdstyle" id="kddelete1" colspan="5"></td>
							</tr>
						</table>
						<!-- 过户显示业务信息 -->
						<table width="100%" id="tdiv_transfer" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									用户原名称
								</td>
								<td width="84%" class="tdstyle" id="kdtransfer0" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									用户新名称
								</td>
								<td width="84%" class="tdstyle" id="kdtransfer1" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									备注
								</td>
								<td width="84%" class="tdstyle" id="kdtransfer2" colspan="5"></td>
							</tr>
						</table>
						<!-- 暂停显示业务信息 -->
						<table width="100%" id="tdiv_pause" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									用户原状态
								</td>
								<td width="84%" class="tdstyle" id="kdpause0" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									用户新状态
								</td>
								<td width="84%" class="tdstyle" id="kdpause1" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									备注
								</td>
								<td width="84%" class="tdstyle" id="kdpause2" colspan="5"></td>
							</tr>
						</table>

						<!-- 恢复显示业务信息 -->
						<table width="100%" id="tdiv_restore" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									用户原状态
								</td>
								<td width="84%" class="tdstyle" id="kdrestore0" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									用户新状态
								</td>
								<td width="84%" class="tdstyle" id="kdrestore1" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									备注
								</td>
								<td width="84%" class="tdstyle" id="kdrestore2" colspan="5"></td>
							</tr>
						</table>
						<!-- 一端双口业务信息 -->
						<table width="100%" id="tdiv_addport" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									主帐号到期日期
								</td>
								<td width="84%" class="tdstyle" id="kdaddport0" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									绑定帐号密码修改
								</td>
								<td width="84%" class="tdstyle" id="kdaddport1" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									开通绑定帐号
								</td>
								<td width="84%" class="tdstyle" id="kdaddport2" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									拆除绑定帐号
								</td>
								<td width="84%" class="tdstyle" id="kdaddport3" colspan="5"></td>
							</tr>
						</table>
						<!-- 宽带返销账 -->
						<table width="100%" id="tdiv_crossfee" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									原套餐信息
								</td>
								<td width="84%" class="tdstyle" id="kdcrossfee0" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									返销账套餐信息
								</td>
								<td width="84%" class="tdstyle" id="kdcrossfee1" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									绑定一端爽口信息
								</td>
								<td width="84%" class="tdstyle" id="kdcrossfee2" colspan="5"></td>
							</tr>
						</table>
						<!-- 宽带续费显示业务信息 -->
						<table width="100%" id="tdiv_payfee" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									用户原套餐
								</td>
								<td width="84%" class="tdstyle" id="kdpayfee0" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									原套餐到期日期
								</td>
								<td class="tdstyle" id="kdpayfee1" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									用户新套餐
								</td>
								<td width="84%" class="tdstyle" id="kdpayfee2" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									新套餐到期日期
								</td>
								<td class="tdstyle" id="kdpayfee3" colspan="5"></td>
							</tr>
							<tr>
								<td class="labelclass">
									备注
								</td>
								<td width="84%" class="tdstyle" id="kdpayfee4" colspan="5"></td>
							</tr>
						</table>
						<!-- 宽带修改属性显示业务信息 -->
						<table width="100%" id="tdiv_modify" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA; display: none"
							cellspacing="0" cellpadding="0">
							<tr>
								<td class="labelclass">
									业务修改信息
								</td>
								<td width="84%" class="tdstyle" colspan="5">
									<div id="kdmodify0"
										style="max-height: 100px; overflow-y: auto; overflow-x: hidden; line-height: 25px"></div>
								</td>
							</tr>
						</table>
						<table width="100%" id="tdiv_kdhx" border="0"
							style="border: 1px; border-style: solid; border-color: #87CEFA;"
							cellspacing="0" cellpadding="0">
						</table>
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
									宽带账号
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo0"></td>
								<td class="labelclass">
									工单类型
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo1"></td>
								<td class="labelclass">
									目前部门
								</td>
								<td width="20%" class="tdstyle" id="kdmqbm"></td>
							</tr>
							<tr>
								<td class="labelclass">
									工单状态
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo2"></td>
								<td class="labelclass">
									受理日期
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo3"></td>
								<td class="labelclass">
									受理人员
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo4"></td>
							</tr>
							<tr>
								<td class="labelclass">
									受理区域
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo5"></td>
								<td class="labelclass">
									受理部门
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo6"></td>
								<td class="labelclass">
									受理费
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo7"></td>
							</tr>
							<tr>
								<td class="labelclass" style="line-height: 30px">
									备注
								</td>
								<td width="20%" class="tdstyle" id="kdjobinfo8" colspan="5"></td>
							</tr>
						</table>
						<table width="99%" id="tdiv" border="0" cellspacing="0"
							cellpadding="0" style="line-height: 33px; font-size: 12px;">
							<tr>
								<td colspan="6">
									<table id="gdlc" width="98%" style="line-height: 30px"></table>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div class="midd_butt">
					<!-- 关闭 	 -->
					<button class="tsdbutton" id="closeo"
						style="width: 63px; heigth: 27px;"
						onclick="setTimeout($.unblockUI, 15);">
						<fmt:message key="global.close" />
					</button>
				</div>
			</div>
		</div>

		<!-- 页面通用隐藏域 开始-->
		<div style="display: none;">
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
			<input type="hidden" id="userloginip"
				value="<%=Log.getIpAddr(request)%>" />
			<input type="hidden" id="userloginid"
				value="<%=session.getAttribute("userid")%>" />
			<input type="hidden" id="thislogtime" value="<%=Log.getThisTime()%>" />
			<!-- 修改时保存原来数据的隐藏域 -->
			<input type="hidden" id="logoldstr" />
			<input type="hidden" id="useridd" value="<%=userid%>" />

			<!-- 打印报表 -->
			<input type='hidden' id='thisbasePath' value='<%=basePath%>' />
			<!-- 高级查询 模板隐藏域 -->
			<input type="hidden" id="queryright" />
			<input type="hidden" id="queryMright" />
			<input type="hidden" id="saveQueryMright" />
			<!-- 查询树信息存放 -->
			<input type="hidden" id='treepid' />
			<input type="hidden" id='treecid' />
			<input type="hidden" id='treestr' />
			<input type="hidden" id='treepic' />

			<!-- grid自动 -->
			<input type="hidden" id='ziduansF' />
			<input type='hidden' id='thecolumn' />


			<form name="childform" id="childform">
				<input type="text" id="queryName" name="queryName" value=""
					style="display: none" />
				<input type="text" id="fusearchsql" name="fusearchsql"
					style="display: none;"/>
			</form>

			<input type="hidden" id="skrid" name="skrid"
				value='<%=request.getSession().getAttribute("userid")%>' />
			<input type="hidden" id="area" name="area"
				value='<%=request.getSession().getAttribute("chargearea")%>' />
			<!-- 菜单ID -->
			<input type="hidden" id="imenuid" name="imenuid" value='<%=imenuid%>' />
			<input type="hidden" id="zid" name="zid" value='<%=zid%>' />
			<!-- 语言 -->
			<input type="hidden" id="lanType" name="lanType"
				value='<%=languageType%>' />

			<!-- 权限组 -->
			<input type="hidden" id="RightGroup" name="RightGroup" />

			<input type='hidden' id='userloginip'
				value='<%=Log.getIpAddr(request)%>' />
			<input type='hidden' id='userloginid'
				value='<%=session.getAttribute("userid")%>' />
			<input type='hidden' id='thislogtime' value='<%=Log.getThisTime()%>' />
			<input type="hidden" id="thisshowywlx" />
			<!-- 页面通用隐藏域 结束-->
			<input type="hidden" name="printt" id="printt" />
	</body>
</html>
