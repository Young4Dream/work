<%----------------------------------------
	name: noticeModify.jsp
	author: chenliang
	version: 1.0, 2010-03-16
	description: 修改通知通告的信息
	modify: 
		2010-12-13 fck图片上传不了问题更正
---------------------------------------------%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/fck" prefix="FCK"%>
<%@ page language="java" import="java.util.*,com.tsd.javabean.NoticeBean" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String iconpath = basePath + "style/icon/";

	String userid = (String) session.getAttribute("userid");
	
	NoticeBean nb = (NoticeBean)request.getAttribute("noticeinfo");
	boolean ismodify = false;
	if(null!=nb&&!"".equals(ismodify)){
		ismodify = true;
	}
%>
<%
	String imenuid = request.getParameter("imenuid");
	String zid = request.getParameter("groupid");
	String pmenuname = request.getParameter("pmenuname");
	String imenuname = request.getParameter("imenuname");
	String nid = request.getParameter("nid");
	
	String languageType = (String) session.getAttribute("languageType");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Group-Manager</title>
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
							 					  tsdpname:'noticeModify.getPower',//存储过程的映射名称
							 					  tsdExeType:'query',
							 					  datatype:'xmlattr'
						 					});
				/************************
				*   调用存储过程需要的参数 *
				**********************/
				var userid = '<%=userid %>';	
				var groupid = '<%=zid %>';
				var imenuid = '<%=imenuid %>';
				
				var editfields = '';
				
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
							editfields += getCaption(spower,'editfields','');
						}
						
						if(editfields.indexOf(',')!=-1){
							var fieldarr = editfields.split(",");
							for(var j = 0 ; j <fieldarr.length-1;j++){
								if(document.getElementById(fieldarr[j])!=''&&document.getElementById(fieldarr[j])!=undefined){
									document.getElementById(fieldarr[j]).disabled = false;
								}
							}
						}else{
							if(document.getElementById(editfields)!=''&&document.getElementById(editfields)!=undefined){
									document.getElementById(editfields).disabled = false;
							}
						}
				}else if(spower=='all@'){
					isReadonly(false);
				}
				
				
			}
		</script>
		
		
		<script type="text/javascript">
			/**
			 * 初始化
			 * @param 无参数
			 * @return 无返回值
			 */
			jQuery(document).ready(function () { 
				getUserPower();//判断权限
				openRowUpdate(); //显示要修改的信息
				var column  = '';
				var thisdata = loadData('notices','<%=languageType %>',1,'修改');
				column = thisdata.FieldName.join(',');			 					
				$('#thecolumn').val(column);
				
				$("#qnid").html(thisdata.getFieldAliasByFieldName('nid'));
				$("#qtitle").html(thisdata.getFieldAliasByFieldName('title'));
				$("#qmemo").html(thisdata.getFieldAliasByFieldName('memo'));
				$("#qtype").html(thisdata.getFieldAliasByFieldName('type'));
				$("#quptime").html(thisdata.getFieldAliasByFieldName('uptime'));
				$("#qupman").html(thisdata.getFieldAliasByFieldName('upman'));
				$("#qflag").html(thisdata.getFieldAliasByFieldName('flag'));
				$("#qtopinfo").html(thisdata.getFieldAliasByFieldName('topinfo'));
				$("#qnews").html(thisdata.getFieldAliasByFieldName('news'));
				$("#qisread").html(thisdata.getFieldAliasByFieldName('isread'));
				$("#qhots").html(thisdata.getFieldAliasByFieldName('hots'));
				$('#title').focus();
			});
			</script>

		<script type="text/javascript">
				/**
				 * 获取编辑器中内容
				 * @param 无参数
				 * @return 无返回值
				 */
				function getFckValue(){
					var editor = FCKeditorAPI.GetInstance("EditorAccessibility");
 					//alert(editor.EditorDocument.body.innerHTML);
					//document.getElementById("news_content").value = editor.EditorDocument.body.innerHTML;
					$('#memo').val(editor.EditorDocument.body.innerHTML);
				}
				
				/**
				 * 设置编辑器中内容
				 * @param str
				 * @return 无返回值
				 */
				function SetEditorContents(str)
				{ 
				    var oEditor = FCKeditorAPI.GetInstance("EditorAccessibility") ; 
				    oEditor.SetHTML(str) ; 
				} 
				
				/**
				 * 先将所有系统营业区域取出
				 * @param 无参数
				 * @return 无返回值
				 */
				function getTypeName(){
					var urlstr=tsd.buildParams({ 	
						 		 						packgname:'service',//java包
									 					clsname:'ExecuteSql',//类名
									 					method:'exeSqlData',//方法名
									 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
									 					tsdcf:'mssql',//指向配置文件名称
									 					tsdoper:'query',//操作类型 
									 					datatype:'xmlattr',//返回数据格式 
									 					tsdpk:'notices.querynoticetype'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
									 				});
					$.ajax({
							url:'mainServlet.html?'+urlstr,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
								var thisarea = '';
								$(xml).find('row').each(function(){
									thisarea += "<option value='"+$(this).attr('typename')+"'>"+$(this).attr('typename')+"</option>";
								});
								$("#type").html(thisarea);
							}
						});
				}
				
				/**
				 * 阅读权限控制
				 * @param 无参数
				 * @return 无返回值
				 */
				function getTheRead(){
					var isread = $('#isread').val();
					//var isreadvalue = '';//全局阅读权限为空
					if(isread!=0){	
						var isvalue = '';
						var name = '';
						var disinfo = '';
						var num=6;
						var spanwidth='110px';
						if(isread==1){//业务区域
							isvalue = 'YwArea';
							name = 'Area_Ywsl';
							disinfo = '业务区域';
							
						}else if(isread==2){//营业区域
							isvalue = 'Area';
							name = 'Asys_Area';
							disinfo = '营业区域';
							num=3;
							spanwidth='150px';
						}else if(isread==3){//部门
							isvalue = 'Bm';
							name = 'ScddBm';
							disinfo = '部门';
						}else if(isread==4){//工号
							isvalue = 'username';
							name = 'sys_user';
							disinfo = '工号';
						}	
						
						$('#disinfo').html(disinfo);
						var urlstr=tsd.buildParams({ 	
					 		 						packgname:'service',//java包
								 					clsname:'ExecuteSql',//类名
								 					method:'exeSqlData',//方法名
								 					ds:'tsdBilling',//数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
								 					tsdcf:'mssql',//指向配置文件名称
								 					tsdoper:'query',//操作类型 
								 					datatype:'xmlattr',//返回数据格式 
								 					tsdpk:'notices.displayinfo'//执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
								 				});
						$.ajax({
							url:'mainServlet.html?'+urlstr+'&isvalue='+isvalue+'&name='+name,
							datatype:'xml',
							cache:false,//如果值变化可能性比较大 一定要将缓存设成false
							timeout: 1000,
							async: false ,//同步方式
							success:function(xml){
									 var thevalue = "";
										var i = 1;
										$(xml).find('row').each(function(){
											var thebr = '';
											if(i*1%num==0){
												thebr = '<br/>';
											}
											thevalue += "<span class='spanstyle' style='width:"+spanwidth+"'><input type='checkbox' name='values' value='"+$(this).attr(isvalue.toLowerCase())+"' style='width:15px;height:15px;'><label style='text-align: left;margin-left:5px'>"+$(this).attr(isvalue.toLowerCase())+"</label></span>"+thebr;
										 	i++;
										});
										var disbutton = "<div style='margin-left:230px'><button type='button' id='ischeck' class='tsdbutton' onclick='checkedAll()' style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'>全选</button><button type='button' class='tsdbutton' onclick='checkedOK()' style='margin-top: 0px;padding:0px 8px 0px 8px;line-height: 20px'>确定</button></div>";
										
										$('#displayinfos').html(thevalue+'<hr/>'+disbutton);
										$('#displayinfos').show('slow');
										$('#displaychk').hide('slow');
										$('#readers').show();
							}
						});
					}else{
						$('#readers').hide();						
					}
					//$('#isreadvalue').val(isread);
				}
				
				var x = 0;
				/**
				 * 全选
				 * @param 无参数
				 * @return 无返回值
				 */
				function checkedAll(){
					var tagname=document.getElementsByName('values');
					for(var i = 0 ; i < tagname.length;i++){
						if(x==0){
							tagname[i].checked = true;
						}else if(x==1){
							tagname[i].checked = false;
						}
					}
					if(x==0){
						$('#ischeck').val('不选');
						x = 1;
					}else if(x==1){
						$('#ischeck').val('全选');
						x = 0;
					}
				}
				
				/**
				 * 获取被选中的值
				 * @param name(需要判断的name值)
				 * @return String
				 */
				function getTheChecked(name){
					var thename=document.getElementsByName(name);  
				    
				    var thevalue = '';
				    for(var i=0;i<thename.length;i++){
				    	if(thename[i].checked==true){
				    		thevalue += thename[i].value + '~';
				    	}
				    }
				    var num = thevalue.lastIndexOf('~');
					thevalue = thevalue.substring(0,num);	
					
					$('#thecheckedvalue').val(thevalue);
					if(thevalue.indexOf('~')==0){
						thevalue = thevalue.substring(1,thevalue.length);
					}
				    return thevalue;
				}
				
				/**
				 * 将值标记为选中的
				 * @param name(需要处理的name值)
				 * @param thisvalue(需要处理的value值)
				 * @return 无返回值
				 */
				function forChecked(name,thisvalue){
					if(''!=thisvalue&&null!=thisvalue){
						var thenum = thisvalue.lastIndexOf('~');
						var m = 0;
						if(thenum==-1){
							thisvalue += '~';
							m = 1;
						}
						var thearr = thisvalue.split('~');
						var tagname=document.getElementsByName(name);
						  
						//获取name的所有的值
						for(var i = 0 ; i < tagname.length;i++){
							//获取以前的记录选中值
							for(var j = 0;j<thearr.length-m;j++){
								if(tagname[i].value==thearr[j]){
							        tagname[i].checked = true;
							        break;
							    }
							}
						}
					}
				}
				
				
				/**
				 * 确认选择
				 * @param 无参数
				 * @return 无返回值
				 */
				function checkedOK(){
					var checkedvalue = getTheChecked('values');
					$('#disinfo').html('阅读范围');
					$('#displayinfos').hide('slow');
					$('#displaychk').html(checkedvalue);
					$('#displaychk').show('slow');
				}
				
				/**
				 * 替换字符串中全部的知道字符串
				 * @param replacestr
				 * @param replacevalue
				 * @param str
				 * @return String
				 */
				function replaceStr(replacestr,replacevalue,str){
					var displayStr = str.replace(/replacestr/g, replacevalue);
					alert(displayStr);
					return displayStr;
				}
				
				/**
				 * 显示要修改信息
				 * @param 无参数
				 * @return 无返回值
				 */
				function openRowUpdate(){
						<%
							if(ismodify==true){
						%>
							$('#titlediv').html('<fmt:message key="global.edit" />');
							$("#modify").show();
							$("#saveinfo").hide();
							$("#title").val('<%=nb.getTitle() %>');
							getTypeName();//初始化公告类型
							$("#type").val('<%=nb.getType() %>');
							$("#flag").val('<%=nb.getFlag() %>');
							$('#topinfo').val('<%=nb.getTopinfo() %>');
							$('#news').val('<%=nb.getNews() %>');
							var isreadvalue = '<%=nb.getIsread() %>';
							
							if(isreadvalue.indexOf('@')!=-1){
								var arrstr = isreadvalue.split('@');
								
								$('#isread').val(arrstr[1]);//初始化值
								if(arrstr[1]!=0){
									$('#disinfo').html('阅读范围');
									$('#displaychk').html(arrstr[0]);
									getTheRead();//初始化复选框显示
									forChecked('values',arrstr[0]);//显示选中值	
									$('#readers').show();
									$('#displaychk').show('show');
									$('#displayinfos').hide();
								}else{
									
								}
								//getTheRead();//初始化复选框显示
								//forChecked('values',arrstr[0]);//显示选中值	
							}
						<%
							}
						%>
				}
				
				/**
				 * 点击关闭
				 * @param 无参数
				 * @return 无返回值
				 */
				function willclose(){
					if(confirm('您要修改的数据尚未保存，确定要退出吗?')){
						window.location.href = "mainServlet.html?pagename=notice/notices.jsp?imenuid=<%=imenuid %>&pmenuname=<%=pmenuname %>&imenuname=<%=imenuname %>&groupid=<%=zid %>";
					}else{
						$('#title').focus();
					}
				}
				
				/**
				 * 将受限字段复原
				 * @param status(状态)
				 * @return 无返回值
				 */
				function isReadonly(status){
					var fields = getFields('notices');
					var fieldarr = fields.split(",");
					for(var j = 0 ; j <fieldarr.length-1;j++){
						if(document.getElementById(fieldarr[j])!=''&&document.getElementById(fieldarr[j])!=undefined){
							document.getElementById(fieldarr[j]).disabled = status;
						}
					}
				}
				
			</script>
		<style type="text/css">
			.tdstyle{border-bottom:1px solid #A9C8D9;}
			.spanstyle{display:-moz-inline-box; display:inline-block;}
			hr {margin:2px 0 2px 0;border:0;border-top:1px dashed #CCCCCC;height:0;}
		</style>
	</head>

	<body>
		<!-- 用户操作导航-->
		<div id="navBar">
			<table width="100%" height="26px">
				<tr>
					<td width="80%" valign="middle">
						<div id="navBar1" style="float: left">
							<img src="<%=iconpath%>dot11.gif" style="margin-left: 10px" />
							<fmt:message key="global.location" />
							:
							<%=pmenuname %> >>> 修改通知通告信息
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
		
		<!-- 添加内容区域 -->
		<div class="neirong" id="add" style="width: 800px;margin-top: 30px">
				<div class="top">
					<div class="top_01" id="thisdrag">
							<div class="top_01left">
								<div class="top_02"><img src="style/images/public/neibut01.gif" /></div>
								<div class="top_03" id="titlediv">修改</div>
								<div class="top_04"><img src="style/images/public/neibut03.gif" /></div>
							</div>
							<div class="top_01right"><a href="#" onclick="javascript:$('#close').click();">关闭</a></div>
					</div>
					<div class="top02right"><img src="style/images/public/toptiaoright.gif" /></div>	
				</div>
				
				
					<div class="midd" >
					   <form action="notices" name="operform" method="post" id="operform" onsubmit="getFckValue();">
						<!-- <form action="#" name="operform" method="post" id="operform" onsubmit="return false;"> -->
						<input type='hidden' name="nmenuid" value="<%=imenuid %>"/>
						<input type='hidden' name="npmenuname" value="<%=pmenuname %>"/>
						<input type='hidden' name="ngroupid" value="<%=zid %>"/>
						<input type='hidden' name="nimenuname" value="<%=imenuname %>"/>
						<input type='hidden' name="nid" value="<%=nid %>"/>
						<input type='hidden' name="willmodify"/>
						
						<table width="100%" id="tdiv" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="labelclass">
										<label for="title">
											<span id="qtitle"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<input type="text" name="title" id="title" disabled="disabled" class="textclass" style="width: 88%"/>
										<font style="color:red;">*</font>
									</td>
									
									<td class="labelclass">
										<label for="type">
											<span id="qtype"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="type" name="type" style="width: 150px" disabled="disabled" class="textclass"></select>
										<font style="color:red;">*</font>
									</td>
									
									<td class="labelclass">
										<label for="flag">
											<span id="qflag"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="flag" name="flag" style="width: 150px" disabled="disabled" class="textclass">
											<option value="0" selected="selected">已审核</option>
											<option value="1">未审核</option>
										</select>
										<font style="color:red;">*</font>
									</td>
								</tr>
								
								
								<tr>
									<td class="labelclass">
										<label for="topinfo">
											<span id="qtopinfo"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="topinfo" name="topinfo" style="width: 150px" disabled="disabled" class="textclass">
											<option value="0" selected="selected">不置顶</option>
											<option value="1">置顶</option>
										</select>
										<font style="color:red;">*</font>
									</td>
									<td class="labelclass">
										<label for="news">
											<span id="qnews"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="news" name="news" style="width: 150px" disabled="disabled" class="textclass">
											<option value="0" selected="selected">不推荐</option>
											<option value="1">推荐</option>
										</select>
										<font style="color:red;">*</font>
									</td>
									<td class="labelclass">
										<label for="isread">
											<span id="qisread"></span>
										</label>
									</td>
									<td width="20%" class="tdstyle">
										<select id="isread" name="isread" disabled="disabled" style="width: 150px" class="textclass" onchange="getTheRead()">
											<option value="0" selected="selected">全局</option>
											<option value="1">业务区域</option>
											<option value="2">营业区域</option>
											<option value="3">部门</option>
											<option value="4">个人</option>
										</select>
										<font style="color:red;">*</font>
									</td>
								</tr>
								
								
								<tr id="readers" style="display: none">
									<td class="labelclass" id="disinfo">
									</td>
									<td width="20%" colspan="5" class="tdstyle">
										<div id="displayinfos" style="max-height:200px;overflow-y: auto;overflow-x: hidden;"></div>
										<div id="displaychk" style="display: none;max-height:200px;overflow-y: auto;overflow-x: hidden;"></div>
									</td>
								</tr>
								
								<tr>
									<td class="dflabelclass">
										<label for="memo">
											<span id="qmemo"></span>
										</label>
									</td>
									<td colspan="5" width="80%" style="text-align: left;">
										<FCK:editor id="EditorAccessibility" width="100%" height="230"
											fontNames="宋体;黑体;隶书;楷体_GB2312;Arial;Comic Sans MS;Courier New;Tahoma;Times New Roman;Verdana"
											imageBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/jsp/connector"
											linkBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Connector=connectors/jsp/connector"
											flashBrowserURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/browser/default/browser.html?Type=Flash&Connector=connectors/jsp/connector"
											imageUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Image"
											linkUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=File"
											flashUploadURL="${pageContext.request.contextPath}/plug-in/FCKeditor/editor/filemanager/upload/simpleuploader?Type=Flash">
											
											<%=nb.getMemo() %>
										</FCK:editor>
										
										<input type="hidden" name="memo" id="memo"/>
									</td>
								</tr>
							</table>
							
							<div class="midd_butt">
								<!-- 
								<button type="submit" class="tsdbutton" id="saveadd" onclick="saveInfo(1)">
									保存添加
								</button>
								<button type="submit" class="tsdbutton" id="saveexit" onclick="saveInfo(2)" style="margin-left: 10px">
									保存退出
								</button>
								 -->
								<button type="submit" class="tsdbutton" id="modify">
									<fmt:message key="global.edit" />
								</button>
								<button type="button" class="tsdbutton" id="close" style="margin-left: 10px" onclick="willclose()">
									<fmt:message key="global.close" />
								</button>
							</div>
					
	<%
		String theIE = request.getHeader("User-Agent");
		int theflag = 0;
		if(theIE.indexOf("MSIE 6.0")!=-1){
			theflag = 1;
		}else if(theIE.indexOf("MSIE 7.0")!=-1||theIE.indexOf("MSIE 8.0")!=-1){
			theflag = 2;
		}
	%>		
	<%
		if(theflag==1){
	%>
		<br/>
		<br/>
		<br/>
		<br/>
	<%		
		}else if(theflag==2){
	%>
		<br/>
	<%		
		}
	%>
							
						</form>
					</div>	
		</div>
		
		<input type="hidden" id="isreadvalue"/>
	</body>
</html>
