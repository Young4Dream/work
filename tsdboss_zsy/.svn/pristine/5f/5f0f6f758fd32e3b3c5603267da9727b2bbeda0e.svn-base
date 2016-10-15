<%----------------------------------------
	name: cReport.jsp
	author: chenze
	version: 1.0, 2010-11-15
	description: 通用报表配置
	modify: 
		sunlin 2010-11-15 添加报表配置功能
	 	2010-12-14 youhongyu 报表配置功能上传验证更新、上传面板样式更新，更新信息之后右侧面板信息
	 	2010-12-20 youhongyu 通用报表配置页面添加报表备注出现乱码问题更正
	 	2010-12-21 youhongyu 页面报表配置兼容多个页面使用同一个报表
	 	2010-12-21 cz        修正上传已有报表时文件名改变的问题
---------------------------------------------%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<title></title>
	
<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/basic/grid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/jquery/jqgrid/themes/jqModal.css" />
		<script src="plug-in/jquery/jquery.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/jquery.jqGrid.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqModal.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jqgrid/js/jqDnR.js" type="text/javascript"></script>
		<link href="style/css/public/tsd-css.css" rel="stylesheet" type="text/css" />
		<script src="script/public/mainStyle.js" type="text/javascript"></script>
		<!-- 
		<link rel="stylesheet" type="text/css" media="screen" href="plug-in/ajaxfileupload/ajaxfileupload.css" />
		-->
		<!-- 文件上传 -->
		<script src="script/system/ajaxfileupload.js" type="text/javascript"></script>
				
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
		<!-- tab滑动门需要导入的包 *注意路径 -->
		<script src="plug-in/jquery/jquery.tabs/jquery.history_remote.pack.js" type="text/javascript"></script>
		<script src="plug-in/jquery/jquery.tabs/jquery.tabs.pack.js" type="text/javascript"></script>
		<!-- tab滑动门 需要导入的样式表 *注意路径-->
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs.css" type="text/css" media="print,projection,screen" />
		<link rel="stylesheet" href="plug-in/jquery/jquery.tabs/jquery.tabs-ie.css" type="text/css" media="projection, screen" />
		<!-- 收费结账专用js -->
		<script src="script/public/revenue.js" type="text/javascript" language="javascript"></script>
		
		<script type="text/javascript" src="plug-in/extjs/ext-base.js"></script>
		<script type="text/javascript" src="plug-in/extjs/ext-all.js"></script>

		<link rel="stylesheet" type="text/css" href="style/css/system/tsdtree.css" />
		<script type="text/javascript" src="script/system/tsdtree.js"></script>
	<style type="text/css">
		#reportconfig tr{line-height:36px;}
		#reportmemo{margin-left:20px;height:60px;width:200px;}
		
		#reportfile_upload,#reportfile_download,#reportfile_addsub{cursor:pointer;text-decoration:underline;display:none;}
		.uploadSubRep,.downSubRep,.delSubRep{cursor:pointer;text-decoration:underline;}
	</style>

	<script type="text/javascript">
	/**
	 * 页面加载
	 * @param 无参数
	 * @return 无返回值
	 */
	$(function(){
		//初始化添加修改按钮
		var innerhtml = '';
		innerhtml += '<button id="report_save" class="tsdbutton" onclick="addConfig()">添加配置</button><button id="report_modify" class="tsdbutton" onclick="addConfig()">修改配置</button><button id="report_cancel" class="tsdbutton" style="margin-left:16px;display:none;">取消</button>';
		$("#buttons").append(innerhtml);
		//通用报表添加修改面板隐藏
		$("#cont_right").show();
		//报表配置添加修改面板显示
		$("#reportpage").hide();
		
		dtree = new dTree("dtree");
		initialBar();
		//showReportMenu();  原有dtree菜单 树方式，已替换为Ext菜单方式
		//加载报表菜单
		Ext.app.tsd.treeRender('report_menu','report');
	});
	
	var dtree;
	
	/**
	 * 初始化导航栏
	 * @param 无参数
	 * @return 无返回值
	 */
	function initialBar()
	{
		$("#navBar").append(genNavv());		
		gobackInNavbar("navBar");
	}

	/**
	 * 菜单树节点事件
	 * @param menuid
	 * @param mununame
	 * @param commonFlag
	 * @return 无返回值
	 */
	function menuChecked(menuid,mununame,commonFlag){
		//更改通用报表标志位
		$("#commonFlag").val(commonFlag);	
		//清空按钮元素
		$("#buttons").empty(); 	
		//判断是否为通用报表配置
		if(commonFlag == 'N'){
			//通用报表添加修改面板隐藏
		    $("#cont_right").hide();
		    //报表配置添加修改面板显示
		    $("#reportpage").show();
		    //向页面中放入菜单名称以及菜单id
		    $("#menuid2").val(menuid);
			$("#menuname2").val(mununame);
		    //去数据库中查询是否有此报表数据，如果有数据将数据显示在页面中以供修改操作，如果没有数据页面显示添加框以供添加数据
			var urlstr = tsd.buildParams({
        		packgname : 'service', //java包
		        clsname : 'ExecuteSql', //类名
		        method : 'exeSqlData', //方法名
		        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		        tsdoper : 'query', //操作类型 
		        datatype : 'xmlattr', //返回数据格式 
		        tsdpk : 'cReport.content' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		    });
		    $.ajax({
		        url : 'mainServlet.html?' + urlstr + '&menuid=' + menuid + '&tsdtemp=' + Math.random(), 
		        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
		        timeout : 1000, async : false , //同步方式
		        success : function (xml){
		        	//上传信息
					$("#ruserid2").text("");
					$("#ruptime2").text("");
					$("#rupip2").text("");
					//修改信息
					$("#reditor2").text("");
					$("#redittime2").text("");
					$("#reditip2").text("");
		        	//清空元素 
		        	$("#addReport").empty(); 
		        	$("#addMany").empty(); 
		        	/*
		        	//后台数据不返回数据信息时使用此方法判断
		        	//判断数据库中是否有此条记录,size() == 0代表数据库中无此记录为添加操作，有记录为修改操作
		        	if($(xml).find('row').size() == 0){
		        		//初始化报表配置添加按钮
					    var innerhtml = '';
					    innerhtml += '<button id="report_save" class="tsdbutton" onclick=addOrUpdateReportt("save")>添加配置</button><button id="report_modify" class="tsdbutton" disabled="disabled" onclick=addOrUpdateReportt("update")>修改配置</button><button id="report_modify" class="tsdbutton" onclick=deleteReportt() disabled="disabled">删除配置</button>';
					    $("#buttons").append(innerhtml);
		        		//向页面中初始化添加框
		        		var innerhtml = '';
		        		innerhtml += '<tr id="r0"><td colspan="3"><hr></td></tr>';
		        		innerhtml += '<tr id="a0"><td>报表标识:</td><td><input type="text" id="tablename" name="tablename2"/></td><td><a href="#" onclick="addReportMany()">添加多个报表</a></td></tr>';
		        		innerhtml += '<tr id="b0"><td width="80">报表文件:</td><td width="240"><input type="text" id="reportfile0" name="reportfile2" disabled="disabled" /><span id="reportfile_l" style="display:none;"></span></td><td width="180"><a href="#" onclick="openUploadDialog(0)">上传新文件</a></td></tr>';
		        		innerhtml += '<tr id="c0"><td>报表备注:</td><td colspan="2"><textarea id="reportmemo" name="reportmemo2"></textarea></td></tr>';
		        		innerhtml += '<tr id="r1"><td colspan="3"><hr></td></tr>';
		        		$("#addReport").append(innerhtml);
		        	}else{
		        		var i = 0;
		        		//初始化报表配置修改按钮
					    var innerhtml = '';
					    innerhtml += '<button id="report_save" class="tsdbutton" onclick=addOrUpdateReportt("save") disabled="disabled">添加配置</button><button id="report_modify" class="tsdbutton" onclick=addOrUpdateReportt("update")>修改配置</button><button id="report_modify" class="tsdbutton" onclick=deleteReportt()>删除配置</button>';
					    $("#buttons").append(innerhtml);
					    //拼接页面显示数据
					    var i = 0;
					    var innerhtml = '';
		        		//解析数据
		        		$(xml).find('row').each(function (){
		        			innerhtml += '<tr id="r'+i+'"><td colspan="3"><hr></td></tr>';
		        			if(i == 0){
		        				innerhtml += '<tr id="a0"><td>报表标识:</td><td><input type="text" id="tablename" name="tablename2" value="'+$(this).attr("reportflag")+'"/></td><td><a href="#" onclick="addReportMany()">添加多个报表</a></td></tr>';
				        		innerhtml += '<tr id="b0"><td width="80">报表文件:</td><td width="240"><input type="text" id="reportfile0" name="reportfile2" disabled="disabled" value="'+$(this).attr("reportname")+'"/><span id="reportfile_l" style="display:none;"></span></td><td width="180"><a href="#" onclick="downloadFile1(0)">下载</a>&nbsp;&nbsp;<a href="#" onclick="openUploadDialog(0)">上传新文件</a></td></tr>';
				        		innerhtml += '<tr id="c0"><td>报表备注:</td><td colspan="2"><textarea id="reportmemo" name="reportmemo2" >'+$(this).attr("description")+'</textarea></td></tr>';
		        			}else{
		        				innerhtml += '<tr id="a'+i+'"><td>报表标识:</td><td><input type="text" id="tablename" name="tablename2" value="'+$(this).attr("reportflag")+'"/></td><td><a href="#" onclick="deleteReportMany('+i+')">删除</a></td></tr>';
				        		innerhtml += '<tr id="b'+i+'"><td width="80">报表文件:</td><td width="240"><input type="text" id="reportfile'+i+'" name="reportfile2" disabled="disabled" value="'+$(this).attr("reportname")+'"/><span id="reportfile_l" style="display:none;"></span></td><td width="180"><a href="#" onclick="downloadFile1('+i+')">下载</a>&nbsp;&nbsp;<a href="#" onclick="openUploadDialog('+i+')">上传新文件</a></td></tr>';
				        		innerhtml += '<tr id="c'+i+'"><td>报表备注:</td><td colspan="2"><textarea id="reportmemo" name="reportmemo2" >'+$(this).attr("description")+'</textarea></td></tr>';
		        			}
			        		i++;
			        		//上传信息
							$("#ruserid2").text($(this).attr("userid"));
							$("#ruptime2").text($(this).attr("uptime"));
							$("#rupip2").text($(this).attr("upip"));
							//修改信息
							$("#reditor2").text($(this).attr("editor"));
							$("#redittime2").text($(this).attr("edittime"));
							$("#reditip2").text($(this).attr("editip"));
			            });
			            innerhtml += '<tr id="r'+i+'"><td colspan="3"><hr></td></tr>';
			            //在页面中显示数据
			            $("#addReport").append(innerhtml);
		        	}
		        	*/
		        	var flag = false;		//用来记录是增加操作还是修改操作  true为增加操作  false为修改操作 
		        	//判断数据库中是否有此条记录
		        	$(xml).find('row').each(function (){
		        		if($(this).attr("reportflag") == undefined){
		        			//初始化报表配置添加按钮
						    var innerhtml = '';
						    innerhtml += '<button id="report_save" class="tsdbutton" onclick=addOrUpdateReportt("save")>添加配置</button><button id="report_modify" class="tsdbutton" disabled="disabled" onclick=addOrUpdateReportt("update")>修改配置</button><button id="report_modify" class="tsdbutton" onclick=deleteReportt() disabled="disabled">删除配置</button>';
						    $("#buttons").append(innerhtml);
			        		//向页面中初始化添加框
			        		var innerhtml = '';
			        		innerhtml += '<tr id="r0"><td colspan="3"><hr></td></tr>';
			        		innerhtml += '<tr id="a0"><td>报表标识:</td><td><input type="text" id="tablename" name="tablename2"/></td><td><a href="#" onclick="addReportMany()">添加多个报表</a></td></tr>';
			        		innerhtml += '<tr id="b0"><td width="80">报表文件:</td><td width="240"><input type="text" id="reportfile0" name="reportfile2" disabled="disabled" /><span id="reportfile_l" style="display:none;"></span></td><td width="180"><a href="#" onclick="openUploadDialog(0)">上传新文件</a></td></tr>';
			        		innerhtml += '<tr id="c0"><td>报表备注:</td><td colspan="2"><textarea id="reportmemo" name="reportmemo2"></textarea></td></tr>';
			        		innerhtml += '<tr id="r1"><td colspan="3"><hr></td></tr>';
			        		$("#addReport").append(innerhtml);
			        		//将flag改为增加标志状态
			        		flag = true;
						}
		        	});
		        	//判断为增加操作退出程序，为修改操作继续程序运行
		        	if(flag){
		        		return false;
		        	}else{
		        		var i = 0;
			        	//初始化报表配置修改按钮
						var innerhtml = '';
						innerhtml += '<button id="report_save" class="tsdbutton" onclick=addOrUpdateReportt("save") disabled="disabled">添加配置</button><button id="report_modify" class="tsdbutton" onclick=addOrUpdateReportt("update")>修改配置</button><button id="report_modify" class="tsdbutton" onclick=deleteReportt()>删除配置</button>';
						$("#buttons").append(innerhtml);
						//拼接页面显示数据
						var i = 0;
						var innerhtml = '';
			        	//解析数据
			        	$(xml).find('row').each(function (){
			        		innerhtml += '<tr id="r'+i+'"><td colspan="3"><hr></td></tr>';
			        		if(i == 0){
			        			innerhtml += '<tr id="a0"><td>报表标识:</td><td><input type="text" id="tablename" name="tablename2" value="'+$(this).attr("reportflag")+'"/></td><td><a href="#" onclick="addReportMany()">添加多个报表</a></td></tr>';
					        	innerhtml += '<tr id="b0"><td width="80">报表文件:</td><td width="240"><input type="text" id="reportfile0" name="reportfile2" disabled="disabled" value="'+$(this).attr("reportname")+'"/><span id="reportfile_l" style="display:none;"></span></td><td width="180"><a href="#" onclick="downloadFile1(0)">下载</a>&nbsp;&nbsp;<a href="#" onclick="openUploadDialog(0)">上传新文件</a></td></tr>';
					        	innerhtml += '<tr id="c0"><td>报表备注:</td><td colspan="2"><textarea id="reportmemo" name="reportmemo2" >'+$(this).attr("description")+'</textarea></td></tr>';
			        		}else{
			        			innerhtml += '<tr id="a'+i+'"><td>报表标识:</td><td><input type="text" id="tablename" name="tablename2" value="'+$(this).attr("reportflag")+'"/></td><td><a href="#" onclick="deleteReportMany('+i+')">删除</a></td></tr>';
					        	innerhtml += '<tr id="b'+i+'"><td width="80">报表文件:</td><td width="240"><input type="text" id="reportfile'+i+'" name="reportfile2" disabled="disabled" value="'+$(this).attr("reportname")+'"/><span id="reportfile_l" style="display:none;"></span></td><td width="180"><a href="#" onclick="downloadFile1('+i+')">下载</a>&nbsp;&nbsp;<a href="#" onclick="openUploadDialog('+i+')">上传新文件</a></td></tr>';
					        	innerhtml += '<tr id="c'+i+'"><td>报表备注:</td><td colspan="2"><textarea id="reportmemo" name="reportmemo2" >'+$(this).attr("description")+'</textarea></td></tr>';
			        		}
				        	i++;
				        	//上传信息
							$("#ruserid2").text($(this).attr("userid"));
							$("#ruptime2").text($(this).attr("uptime"));
							$("#rupip2").text($(this).attr("upip"));
							//修改信息
							$("#reditor2").text($(this).attr("editor"));
							$("#redittime2").text($(this).attr("edittime"));
							$("#reditip2").text($(this).attr("editip"));
				         });
				         innerhtml += '<tr id="r'+i+'"><td colspan="3"><hr></td></tr>';
				         //在页面中显示数据
				         $("#addReport").append(innerhtml);
		        	}
		        }
		    });
		}else{
			//初始化添加修改按钮
			var innerhtml = '';
			innerhtml += '<button id="report_save" class="tsdbutton" onclick="addConfig()">添加配置</button><button id="report_modify" class="tsdbutton" onclick="addConfig()">修改配置</button><button id="report_cancel" class="tsdbutton" style="margin-left:16px;display:none;">取消</button>';
			$("#buttons").append(innerhtml);
			//通用报表添加修改面板显示
			$("#cont_right").show();
		    //报表配置添加修改面板隐藏
		    $("#reportpage").hide();
			if($("#reportfile").val()!=$("#reportfile_l").text() || $("#reportparam").val()!=$("#reportparam_l").text() ||$("#reportmemo").val()!=$("#reportmemo_l").text())
			{
				if(confirm("部分配置信息已被修改，是否保存?"))
				{
					//$("#report_save").click();
					addConfig();
				}
			}
			
			$("#menuid").val(menuid);
			$("#menuname").val(mununame);
			
			
			readConfig(menuid);
			$("#sub_report_").empty();
			subReportManage(1,menuid);
		}
	}
	
	/**
	 * 添加指定页面中需要多报表文本输入框
	 * @param 无参数
	 * @return 无返回值
	 */
	var i=1;//用来区分多报表文本输入框
	function addReportMany(){
		var innerhtml = '';
		innerhtml += '<tr id="a100'+i+'"><td>报表标识:</td><td><input type="text" name="tablename2"/></td><td><a href="#" onclick="deleteReportMany(100'+i+')">删除</a></td></tr>';
		innerhtml += '<tr id="b100'+i+'"><td width="80">报表文件:</td><td width="240"><input type="text" id="reportfile100'+i+'" name="reportfile2" disabled="disabled" /><span id="reportfile_l" style="display:none;"></span></td><td width="180"><a href="#" onclick="openUploadDialog(100'+i+')">上传新文件</a></td></tr>';
		innerhtml += '<tr id="c100'+i+'"><td>报表备注:</td><td colspan="2"><textarea id="reportmemo" name="reportmemo2"></textarea></td></tr>';
		i++;
		innerhtml += '<tr id="r100'+i+'"><td colspan="3"><hr></td></tr>';
		$("#addMany").append(innerhtml);
	}

	/**
	 * 删除添加的指定多报表文本输入框
	 * @param i(tr的唯一标识)
	 * @return 无返回值
	 */
	function deleteReportMany(i){
		//分别删除addMany追加的tr 
		$("#r"+(i+1)).remove(); 
		$("#a"+i).remove(); 
		$("#b"+i).remove();
		$("#c"+i).remove();
	}
	
	/**
	 * 添加修改报表
	 * @param i(tr的唯一标识)
	 * @return 无返回值
	 */
	function addOrUpdateReportt(str){
	/************   	验证   	******************/
		if($.trim($("#menuname2").val())==""){
			alert("请选择要配置的报表菜单");
			return false;
		}
		//获取报表标识集合
		var tablenameArray = document.getElementsByName("tablename2");
		//获取报表文件名集合
		var reportfileArray = document.getElementsByName("reportfile2");
		//循环判断验证文本框中是否有值
		for(j=0;j<tablenameArray.length;j++){
			if($.trim(tablenameArray[j].value)==""){
				alert("请先输入报表标识");
				tablenameArray[j].focus();
				return false;
			}
			if($.trim(reportfileArray[j].value)==""){
				alert("请先上传报表文件");
				return false;
			}
		}
		//获取菜单id
		var menuid = $("#menuid2").val();
		//获取报表备注集合
		var reportmemoArray = document.getElementsByName("reportmemo2");
		//拼接插入语句
		var insertReport ="begin   ";
		//如果为修改操作，首先删除掉此菜单下的所有记录，然后再向数据库中插入数据
		if(str == 'update'){
			insertReport = insertReport+" delete from REPORTMANAGE where menuid="+menuid+"; ";
		}
		for(j=0;j<tablenameArray.length;j++){
			var bzstr = tsd.encodeURIComponent(reportmemoArray[j].value);
			insertReport += "insert into REPORTMANAGE(menuid,reportname,description,upip,userid,editor,editip,reportflag,edittime) values("+menuid+",'"+reportfileArray[j].value+"','"+bzstr+"','"+$("#userloginip").val()+"','"+$("#userid").val()+"','"+$("#userid").val()+"','"+$("#userloginip").val()+"','"+tablenameArray[j].value+"',(select sysdate from dual) );";
		}
		insertReport = insertReport+" end; ";
		//向数据库中插入数据
		var urlstr = tsd.buildParams({
        		packgname : 'service', //java包
		        clsname : 'ExecuteSql', //类名
		        method : 'exeSqlData', //方法名
		        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		        tsdoper : 'exe', //操作类型 
		        datatype : 'xmlattr', //返回数据格式 
		        tsdpk : 'cReport.add' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});
		$.ajax({
		        url : 'mainServlet.html?' + urlstr + '&insertReport=' + insertReport + '&tsdtemp=' + Math.random(), 
		        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
		        timeout : 1000, async : false , //同步方式
		        success : function (xml){
		        	alert("报表配置成功");
		        },
			    error:function(data, status, e){
			   		//报表配置添加失败
			   		alert("报表配置失败");
			    }
		});
		
		//与数据库交互后页面刷新//location.reload();
		var menuname2=$("#menuname2").val();
		menuChecked(menuid,menuname2,'N');
	}
	
	/**
	 * 删除配置
	 * @param 无参数
	 * @return 无返回值
	 */
	function deleteReportt(){
		var urlstr = tsd.buildParams({
        		packgname : 'service', //java包
		        clsname : 'ExecuteSql', //类名
		        method : 'exeSqlData', //方法名
		        ds : 'tsdBilling', //数据源名称 对应的WEB-INF/classes/ApplicationContent.xml中配置的数据源
		        tsdoper : 'exe', //操作类型 
		        datatype : 'xmlattr', //返回数据格式 
		        tsdpk : 'cReport.delete' //执行的主Sql语句的配置名，应选取tsdcf中配置的文件里指定
		});
		$.ajax({
		        url : 'mainServlet.html?' + urlstr + '&menuid=' + $("#menuid2").val() + '&tsdtemp=' + Math.random(), 
		        datatype : 'xml', cache : false, //如果值变化可能性比较大 一定要将缓存设成false
		        timeout : 1000, async : false , //同步方式
		        success : function (xml){
		        	alert("删除配置成功");
		        },
			    error:function(data, status, e){
			   		//报表配置添加失败
			   		alert("删除配置失败");
			    }
		});
		location.reload();//与数据库交互后页面刷新
	}
	/**
	 * 报表配置文件下载
	 * @param i唯一标识
	 * @return 无返回值
	 */
	function downloadFile1(i)
	{
		if($("#reportdownload").size()<1)
		{
			$("body").append("<iframe id=\"reportdownload\" width=\"0\" height=\"0\"></iframe>");
		}
		$("#reportdownload").attr("src","mainServlet.html?packgname=service&clsname=FileDownLoad&method=download&tsdfilename=WEB-INF/reportlets/com/tsdreport/" + $("#reportfile"+i).val());
	}
	
	/**
	 * 添加或修改配置信息
	 * @param 无参数
	 * @return 无返回值
	 */
	function addConfig()
	{
		if($.trim($("#menuname").val())=="")
		{
			alert("请选择要配置的报表菜单");
			return false;
		}
		if($.trim($("#reportfile").val())=="")
		{
			alert("请先上传报表文件");
			$("#reportfile").focus();
			return false;
		}
		var menuid = $("#menuid").val();
		var rname=$("#reportfile").val();
		var rparam=$("#reportparam").val();
		var rdesc=$("#reportmemo").val();
		
		tsd.QualifiedVal=true;
		rname = tsd.encodeURIComponent(rname);
		rparam = tsd.encodeURIComponent(rparam);
		rdesc = tsd.encodeURIComponent(rdesc);
		if(tsd.Qualified()==false){return false;}
		
		var paramstr = "&menuid="+menuid+"&reportname="+rname+"&pparameterss="+rparam+"&description="+rdesc+"&upip="+$("#userloginip").val()+"&userid="+$("#userid").val()+"&editor="+$("#userid").val()+"&editip="+$("#userloginip").val();
		if($("#commonFlag").val()=="Y")
			paramstr += "&flag=w";
		else paramstr += "&flag=fw";
		
		var res = executeNoQueryProc("reportmanage.update",7,paramstr);
		
		if(res==true || res == "true")
		{
			alert("报表菜单 \""+$("#menuname").val()+"\" 添加配置成功");
			$("#reportfile_l").text($("#reportfile").val());
			$("#reportparam_l").text($("#reportparam").val());
			$("#reportmemo_l").text($("#reportmemo").val());
			readConfig($("#menuid").val());
		}
		else
		{
			alert("报表菜单 \""+$("#menuname").val()+"\" 添加配置失败");
		}
	}
	/**
	 * 读取指定菜单的配置信息
	 * @param imenuid(唯一标识)
	 * @return 无返回值
	 */
	function readConfig(imenuid)
	{
		//
		var res = fetchMultiPValue("reportmanage.update",7,"&flag=r&menuid="+imenuid);
		if(res[0]==undefined || res[0][0]==undefined)
		{
			$("#reportlist").empty();
			$("#reportfile").val("");
			$("#reportparam").val("");
			$("#reportmemo").val("");
			$("#reportfile_l").text($("#reportfile").val());
			$("#reportparam_l").text($("#reportparam").val());
			$("#reportmemo_l").text($("#reportmemo").val());
			
			//上传信息
			$("#ruserid").text("");
			$("#ruptime").text("");
			$("#rupip").text("");
			//修改信息
			$("#reditor").text("");
			$("#redittime").text("");
			$("#reditip").text("");
		
			//当前无报表配置
			$("#reportfile_download").css("display","none");
			$("#reportfile_upload").css("display","inline");
			$("#reportfile_addsub").css("display","none");
			//$("#report_save").val("添加配置");当前无报表配置，可以添加配置
			
			//当前无配置信息，如果是通用报表，则允许添加配置
			if($("#commonFlag").val()=="Y")
				$("#report_save").removeAttr("disabled");
			else
				$("#report_save").attr("disabled","disabled");
			$("#report_modify").attr("disabled","disabled");
			return false;
		}
		else
		{
			$("#reportlist").empty();
			var optiontmp = "";
			for(var k=0;k<res.length;k++)
			{
				optiontmp = "";
				optiontmp += "<option reportparam=\"";
				optiontmp += res[k][2];
				optiontmp += "\" reportmemo=\"";
				optiontmp += res[k][9];
				optiontmp += "\" userid=\"";
				optiontmp += res[k][3];
				optiontmp += "\" uptime=\"";
				optiontmp += res[k][4];
				optiontmp += "\" upip=\"";
				optiontmp += res[k][5];
				optiontmp += "\" editor=\"";
				optiontmp += res[k][6];
				optiontmp += "\" edittime=\"";
				optiontmp += res[k][7];
				optiontmp += "\" editip=\"";
				optiontmp += res[k][8];
				optiontmp += "\" value=\"";
				optiontmp += res[k][1];
				optiontmp += "\">" + res[k][1] + "</option>"
				$("#reportlist").append(optiontmp);
			}
			
			
			$("#reportfile").val(res[0][1]);
			$("#reportparam").val(res[0][2]);
			$("#reportmemo").val(res[0][9]);
			$("#reportfile_l").text($("#reportfile").val());
			$("#reportparam_l").text($("#reportparam").val());
			$("#reportmemo_l").text($("#reportmemo").val());
			//上传信息
			$("#ruserid").text(res[0][3]);
			$("#ruptime").text(res[0][4]);
			$("#rupip").text(res[0][5]);
			//修改信息
			$("#reditor").text(res[0][6]);
			$("#redittime").text(res[0][7]);
			$("#reditip").text(res[0][8]);
			
			//当前已有报表配置 只能修改
			$("#reportfile_download").css("display","inline");
			$("#reportfile_upload").css("display","inline");
			$("#reportfile_addsub").css("display","inline");
			//$("#report_save").val("修改配置");
			
			$("#report_save").attr("disabled","disabled");
			
			$("#report_modify").removeAttr("disabled");
		}
	}
	
	/**
	 * 报表名称下拉框更改事件
	 * @param 无参数
	 * @return 无返回值
	 */
	function reportListDropDown()
	{
		var selList = $("#reportlist option[selected]");
		$("#reportfile").val($(selList).attr("value"));
		$("#reportparam").val($(selList).attr("reportparam"));
		$("#reportmemo").val($(selList).attr("reportmemo"));
		
		//上传信息
		$("#ruserid").text($(selList).attr("userid"));
		$("#ruptime").text($(selList).attr("uptime"));
		$("#rupip").text($(selList).attr("upip"));
		//修改信息
		$("#reditor").text($(selList).attr("editor"));
		$("#redittime").text($(selList).attr("edittime"));
		$("#reditip").text($(selList).attr("editip"));
		
		$("#reportfile_l").text($("#reportfile").val());
		$("#reportparam_l").text($("#reportparam").val());
		$("#reportmemo_l").text($("#reportmemo").val());
	}
	/**
	 * 显示子菜单
	 * @param type
	 * @param menuid
	 * @param subid
	 * @param fname
	 * @return 无返回值
	 */
	function subReportManage(type,menuid,subid,fname)
	{
		var params = "";
		var res;
		
		var tmp1 = "";
		var tmp2 = "";
		
		if(type==1)
		{
			params = "&flag=r&imenuid=" + menuid;
			res = fetchMultiPValue("reportmanage.getSubMenu",7,params);
			if(res[0]==undefined || res[0][0]==undefined)
			{
				return false;
			}
			
			for(var i=0;i<res.length;i++)
			{
				tmp1 = res[i][0];
				tmp2 = res[i][1];
				//显示子菜单
				showSubReport(tmp1,tmp2);
			}
		}
		else if(type==2)
		{
			params = "&flag=w&imenuid=" + menuid + "&subid=" + subid + "&filename=" + tsd.encodeURIComponent(fname);
			res = executeNoQueryProc("reportmanage.getSubMenu",7,params);
			
		}
		else if(type==3)
		{
			params = "&flag=d&imenuid=" + menuid + "&subid="+subid;
			res = executeNoQueryProc("reportmanage.getSubMenu",7,params);
		}
	}
	/**
	 * 打开报表文件上传下载面板
	 * @param i(上传文本框标识)
	 * @return 无返回值
	 */
	 var obj = null;
	function openUploadDialog(i)
	{
		//向隐藏域中放入当前上传文本框的标识
		$("#identify").val(i);
		autoBlockForm('reportFileUploadPanel',20,'reportFileUploadClose',"#FFFFFF",false);
	}
	
	
	/**
	 * 打开子报表上传面板
	 * @param subid(唯一标识)
	 * @return 无返回值
	 */
	function uploadSubReport(subid)
	{
		$("#subid").val(subid);
		autoBlockForm('subReportFileUploadPanel',20,'subReportFileUploadClose',"#FFFFFF",false);
	}
	
	
	/**
	 * 删除子报表
	 * @param idx(序号)
	 * @return 无返回值
	 */
	function delSubReport(idx)
	{
		if($("#Sub_Rep_" + idx).val()!="")
		{
			if(confirm("你确定要删除报表文件么?"))
			{
				$("#Sub_Rep_" + idx).parent().parent().remove();
				//删除报表
				subReportManage(3,$("#menuid").val(),idx);
			}
		}
		else
		{
			$("#Sub_Rep_" + idx).parent().parent().remove();
		}
	}
	
	/**
	 * 显示指定子报表ID和报表名称的子报表
	 * @param subid
	 * @param pname
	 * @return 无返回值
	 */
	function showSubReport(subid,pname)
	{
		var innerhtml = "<tr><td align=\"right\" width=\"80\">{id}、</td><td width=\"60\">报表文件</td><td><input disabled type=\"text\" value=\"{val}\" id=\"Sub_Rep_{id}\" /></td><td><span class=\"delSubRep\" onclick=\"delSubReport({id})\">删除</span> &nbsp;&nbsp; <span class=\"downSubRep\" onclick=\"downSubReport({id})\">下载</span> &nbsp;&nbsp; <span class=\"uploadSubRep\" onclick=\"uploadSubReport({id})\">上传文件</span></td></tr>";
		//innerhtml += "<tr><td></td><td width=\"60\">备注</td><td><textarea type=\"text\" id=\"Sub_Rep_Memo_{id}\" style=\"margin-left:20px;width:220px;height:40px;\"></textarea></td></tr>";
				
		innerhtml = innerhtml.replace(/\{id\}/g,subid);
		
		innerhtml = innerhtml.replace(/\{val\}/g,pname);
		
		$("#sub_report_").append(innerhtml);
	}
	/**
	 * 添加指定子报表ID和报表名称的子报表
	 * @param 无参数
	 * @return 无返回值
	 */
	function addSubReport()
	{
		var innerhtml = "<tr><td align=\"right\" width=\"80\">{id}、</td><td width=\"60\">报表文件</td><td><input disabled type=\"text\" id=\"Sub_Rep_{id}\" /></td><td><span class=\"delSubRep\" onclick=\"delSubReport({id})\">删除</span> &nbsp;&nbsp; <span class=\"downSubRep\" onclick=\"downSubReport({id})\">下载</span> &nbsp;&nbsp; <span class=\"uploadSubRep\" onclick=\"uploadSubReport({id})\">上传文件</span></td></tr>";
		//innerhtml += "<tr><td></td><td width=\"60\">备注</td><td><textarea type=\"text\" id=\"Sub_Rep_Memo_{id}\" style=\"margin-left:20px;width:220px;height:40px;\"></textarea></td></tr>";
		
		var existObjIDs = $("input[id^='Sub_Rep_']");
		var existIDs = [];
		$(existObjIDs).each(function(i,n){
			existIDs.push($(n).attr("id").replace("Sub_Rep_",""));
		});
		
		var lax = 0;
		for(var i=0;i<existIDs.length;i++)
		{
			var tmp = parseInt(existIDs[i]);
			if(tmp>lax)
				lax = tmp;
		}
		
		innerhtml = innerhtml.replace(/\{id\}/g,lax+1);
		
		$("#sub_report_").append(innerhtml);
	}
	
	/**
	 * 文件下载
	 * @param 无参数
	 * @return 无返回值
	 */
	function downloadFile()
	{
		if($("#reportdownload").size()<1)
		{
			$("body").append("<iframe id=\"reportdownload\" width=\"0\" height=\"0\"></iframe>");
		}
		$("#reportdownload").attr("src","mainServlet.html?packgname=service&clsname=FileDownLoad&method=download&tsdfilename=WEB-INF/reportlets/com/tsdreport/" + $("#reportfile").val());
	}
	
	/**
	 * 子报表文件下载
	 * @param idx(序号)
	 * @return 无返回值
	 */
	function downSubReport(idx)
	{
		if($("#Sub_Rep_" + idx).val()=="")
		{
			return false;
		}
		if($("#reportdownload").size()<1)
		{
			$("body").append("<iframe id=\"reportdownload\" width=\"0\" height=\"0\"></iframe>");
		}
		$("#reportdownload").attr("src","mainServlet.html?packgname=service&clsname=FileDownLoad&method=download&tsdfilename=WEB-INF/reportlets/com/tsdreport/" + $("#Sub_Rep_" + idx).val());
	}
	
	
	/**
	 * 文件上传处理，查询文件是否已经存在
	 * @param fn
	 * @return boolean
	 */
	function fileExisted(fn)
	{
		var res = fetchSingleValue("cReport.reportExisted",7,"&reportname="+fn);
		if(parseInt(res,10)>0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	/**
	 * 文件上传处理，查询文件是否已经存在；查询数据库，看改报表是否在数据库中，已经被使用
	 * @param fn
	 * @return boolean
	 	为被使用返回true
	 	否则返回字符串，提示正在使用的菜单。
	 */
	function ComFileExisted(fn)
	{
		var res = fetchMultiArrayValue("cReport.ComreportExisted",7,"&reportname="+fn);
		var ify='该报表已经在';
		if(res==""||res=="null"||res==undefined||res==null){
			return true;
		}else{				
			for(var i=0;i<res.length;i++){
				var strtype = res[i][1];
				var lanType = "<%=languageType%>";
				strtype = getCaption(strtype,lanType,'');
				//alert(strtype);
				ify +="【"+strtype+"】";					
			}
			ify+="菜单中使用，请确定是否要与该页面共用一份报表。<br/>“是”点击确定；“否”取消上传文件操作，请重命名您的报表再上传！";
			return ify;
		}	
	}
	/**
	 * 判断文件类型
	 * @param 无参数
	 * @return boolean
	 */
	function checkFile()
	{
		var fileName = $("#upfile").val();
		var pattern = /[a-zA-Z]:\\[^\:\*\?\/\|\"\<\>]+\.cpt/;
		
		//           /\w:\\(\w+\\){0,}\w+\.cpt/i;
		if(!pattern.test(fileName))
		{
			alert("请选择正确的报表文件进行上传。支持文件为(*.cpt)");
			return false;
		}
		else return true;
	}
	/**
	 * 上传面板中的 上传确定按钮 用于上传文件
	 * @param 无参数
	 * @return 无返回值
	 */
	function uploadFile()
	{
		if(checkFile())
		{
			
			var filename = $("#upfile").val();
			var indexOfX = filename.lastIndexOf("\\");
			filename = filename.substring(indexOfX + 1);
			
			//根据commonFlag判断该页面是通用报表页面或是一般页面，区分处理判断文件是否存在
			var commonFlag =$("#commonFlag").val();			
			if(commonFlag=='Y'){
				if($("#reportfile").val()=="" && fileExisted("commonreport/" + filename))
				{
					alert("文件" + filename + "已经存在");
					return false;
				}
				else{
					sumbitUpdate(filename);//上传报表方法
				}
			}
			else if(commonFlag=='N'){
				var identify = $("#identify").val();
				if($("#reportfile"+identify).val()==""){
					//查询数据库，看改报表是否在数据库中，已经被使用
					var existflag = ComFileExisted("commonreport/" + filename);	
					if(existflag==true){
						 sumbitUpdate(filename);//上传报表方法
					}else{						
						jConfirm(existflag,'提示',function(x){
							if(x==true){
						 		sumbitUpdate(filename);//上传报表方法
						 	}else{						 		
						 		$("#reportfile_download").css("display","inline");//将下载按钮置为不可见
			     				$("#reportFileUploadClose").click();//关闭上传面板
						 	}
						});
					}					
				}
				else{
					sumbitUpdate(filename);//上传报表方法
				}
			}  
	}

	/**
	 * 上传报表方法
	 * @param filename ： 报表名称
	 * @return 无返回值
	 */
	function sumbitUpdate(filename){
			var urll = 'upfiles?tsdcf=mssql&fileStartName=Report&upDirKey=cReport.upDirKey';
			if($("#reportfile").val()!="")
			{
				var tmp = $("#reportfile").val();
				//tmp = tmp.replace(new RegExp("\\","g"),"\\\\");
				tmp = "&ufilename=" + tmp;
				urll = urll + tmp;
			}
			else
			{
				var tmp = "&ufilename=commonreport/" + filename;
				urll = urll + tmp;
			}
			
			$("#start").ajaxStart(function(){
		     //文件上传中..."
		    });
		    //2.上传
		    $.ajaxFileUpload({
			    url: urll,//servlet路径 可携带参数
			    secureuri:false,
			    fileElementId:'upfile',
			    success:function(data, status)
			    {
			     	//如果文件上传成功
			     	alert("报表文件上传成功");
			     	if($("#commonFlag").val()=="Y"){
			     		if($("#reportfile").val()=="")
			     			$("#reportfile").val("commonreport/" + filename);
			     	}
			     	else{
			     		//向获取报表名文件文本框中放入报表名称
			     		document.getElementById('reportfile'+$("#identify").val()).value="commonreport/" + filename;	
			     	}
			     	$("#reportfile_download").css("display","inline");
			     	$("#reportFileUploadClose").click();
			    },
			    error:function(data, status, e)
			    {
			   		//文件上失败
			   		alert("文件上传失败");
			   		alert(e);
			   		alert(status);
			    }
			});
		}
	
	}
	/**
	 * 检测子报表文件是否存在
	 * @param fn
	 * @return boolean
	 */
	function subfileExisted(fn)
	{
		var res = fetchSingleValue("cReport.s.reportExisted",7,"&reportname="+fn);
		if(parseInt(res,10)>0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	/**
	 * 判断文件类型
	 * @param 无参数
	 * @return boolean
	 */
	function subcheckFile()
	{
		var fileName = $("#subupfile").val();
		
		var pattern = /[a-zA-Z]:\\[^\:\*\?\/\|\"\<\>]+\.cpt/;
		
		//           /\w:\\(\w+\\){0,}\w+\.cpt/i;
		if(!pattern.test(fileName))
		{
			alert("请选择正确的报表文件进行上传。支持文件为(*.cpt)");
			return false;
		}
		else return true;
	}
	/**
	 * 上传文件
	 * @param 无参数
	 * @return 无返回值
	 */
	function uploadSubFile()
	{
		if(subcheckFile())
		{
			var CtrName = "Sub_Rep_" + $("#subid").val();
			
			var filename = $("#subupfile").val();
			
			var indexOfX = filename.lastIndexOf("\\");
			filename = filename.substring(indexOfX + 1);
			
			
			
			var urll = 'upfiles?tsdcf=mssql&fileStartName=Report&upDirKey=cReport.upDirKey';
			if($("#" + CtrName).val()!="")
			{
				var tmp = $("#" + CtrName).val();
				//tmp = tmp.replace(new RegExp("\\","g"),"\\\\");
				tmp = "&ufilename=" + tmp;
				urll = urll + tmp;				
			}
			else
			{
				var tmp = "&ufilename=subreport/" + filename;
				urll = urll + tmp;
				
				if(subfileExisted("subreport/" + filename))
				{
					alert("文件" + filename + "已经存在");
					return false;
				}
			}
			//alert(urll);
			$("#start").ajaxStart(function(){
		     //文件上传中..."
		    });
		    //2.上传
		    $.ajaxFileUpload({
			    url: urll,//servlet路径 可携带参数
			    secureuri:false,
			    fileElementId:'subupfile',
			    success:function(data, status)
			    {
			     	//如果文件上传成功
			     	alert("报表文件上传成功");
			     	if($("#" + CtrName).val()=="")
			     		$("#" + CtrName).val("subreport/" + filename);
			     	subReportManage(2,$("#menuid").val(),$("#subid").val(),"subreport/" + filename);
			     	//$("#reportfile_download").css("display","inline");
			     	$("#subReportFileUploadClose").click();
			    },
			    error:function(data, status, e)
			    {
			   		//文件上失败
			   		alert("文件上传失败");
			   		alert(e);
			   		alert(status);
			    }
			});
		}
  
	}
	
	</script>
  </head>
  
  <body style="text-align:left;">
    <div id="navBar">
		<img src="style/icon/dot11.gif" />
		<fmt:message key="global.location" />:		
	</div>
	<!-- 功能按钮 -->
	<div id="buttons">
	</div>
	
	<div id="container" style="width:900px;margin-left:20px;margin-top:2px;">
		<div id="cont_left" style="float:left;width:29%;border:#99ccff 1px solid;background-color: #F5FCFE;">
			<h4 style="font-size:18px;">报表菜单</h4>
			<div id="report_menu"></div>
		</div>
		<!-- 通用报表模板 -->
		<div id="cont_right" style="float:right;width:69%;border:#99ccff 1px solid;background-color: #F5FCFE;">		
			<div id="inputs">
				<div id="input-Unit">
					<div class="title" style="width:95%;text-align:center;">
						<h4 style="font-size:24px;">报表配置</h4>
					</div>
					<form action="#" id="menuinfo" onsubmit="return false;">
						<div id="inputtext">
						<table align="center" id="reportconfig" style="width:500px;">
							<tr style="display:none;">
								<td>可选报表:</td>
								<td colspan="2"><select name="reportlist" id="reportlist" onchange="reportListDropDown()"></select></td>
							</tr>
							<tr>
								<td>菜单名称:</td>
								<td colspan="2"><input type="hidden" id="commonFlag" style="display:none" /><input type="hidden" id="menuid" style="display:none" /><input type="text" id="menuname" disabled="disabled" /></td>
							</tr>
							<tr>
								<td width="80">报表文件:</td>
								<td width="240"><input type="text" id="reportfile" disabled="disabled" /><span id="reportfile_l" style="display:none;"></span></td>
								<td width="180">
									<span id="reportfile_download" onclick="downloadFile()">下载</span>&nbsp;&nbsp;
									<span id="reportfile_upload" onclick="openUploadDialog()">上传新文件</span>
									<span id="reportfile_addsub" onclick="addSubReport()">添加子报表</span>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table id="sub_report_">
										<tr></tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>报表参数:</td>
								<td colspan="2"><input type="text" id="reportparam" /><span id="reportparam_l" style="display:none;"></span>(格式:参数1~值1~参数2~值2)</td>
							</tr>							
							<tr>
								<td>报表备注:</td>
								<td colspan="2"><textarea id="reportmemo"></textarea><span id="reportmemo_l" style="display:none;"></span></td>
							</tr>
							
							<tr>
								<td colspan="3">
									<table>
										<tr>
											<td width="100">上传工号:<span id="ruserid" style="width:50px;"></span>&nbsp;&nbsp;</td>
											<td width="200">上传时间:<span id="ruptime" style="width:50px;"></span>&nbsp;&nbsp;</td>							
											<td width="200">上传IP:<span id="rupip" style="width:50px;"></span>&nbsp;&nbsp;</td>
										</tr>
										<tr>
											<td>最后修改:<span id="reditor"></span></td>
											<td>修改时间:<span id="redittime"></span></td>
											<td>修改IP:<span id="reditip"></span></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						</div>
					</form>
				</div>
			</div>
		</div>
		
		<!-- 报表配置 -->
		<div id="reportpage" style="float:right;width:69%;border:#99ccff 1px solid;background-color: #F5FCFE;">		
			<div id="inputs">
				<div id="input-Unit">
					<div class="title" style="width:95%;text-align:center;">
						<h4 style="font-size:24px;">报表配置</h4>
					</div>
					<form action="#" id="menuinfo2" onsubmit="return false;">
						<div id="inputtext">
						
						<table align="center" id="reportconfig" style="width:500px;">
							<tr>
								<td>菜单名称:</td>
								<td colspan="2"><input type="hidden" id="menuid2" style="display:none" /><input type="text" id="menuname2" disabled="disabled" /></td>
							
							</tr>
							<tr>
								<td colspan="3">
									<table id="addReport" align="center" style="width:500px;">
										<tr></tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<table id="addMany">
										<tr></tr>
									</table>
								</td>
							</tr>			
							<tr>
								<td colspan="3">
									<table>
										<tr>
											<td width="100">上传工号:<span id="ruserid2" style="width:50px;"></span>&nbsp;&nbsp;</td>
											<td width="200">上传时间:<span id="ruptime2" style="width:50px;"></span>&nbsp;&nbsp;</td>							
											<td width="200">上传IP:<span id="rupip2" style="width:50px;"></span>&nbsp;&nbsp;</td>
										</tr>
										<tr>
											<td>最后修改:<span id="reditor2"></span></td>
											<td>修改时间:<span id="redittime2"></span></td>
											<td>修改IP:<span id="reditip2"></span></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 报表文件上传下载 -->
	<div class="neirong" id="reportFileUploadPanel" style="display:none;width:500px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						报表文件上传下载
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#reportFileUploadClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:498px;height:80px;font-size:14px;padding-top: 30px;">
			
			<form action="upfile" method="post"	enctype="multipart/form-data">
				<table id="reportFileUploadTab" width="80%" border="0" bordercolor="#eeeeee" cellspacing="0" cellpadding="1" align="center" style="font-size:14px;">
					<tr>
						<td style="text-align: 25px;">浏览文件：</td>
						<td><input name="upfile" type="file" id="upfile" onkeydown="return false" size="30" style="height: 25px;line-height: 22px;"/></td>
					</tr>					
				</table>
			</form>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="reportFileUploadUpload" onclick="uploadFile()">
				上传
			</button>
			<button type="button" class="tsdbutton" id="reportFileUploadClose">
				关闭
			</button>
		</div>
	</div>
	
	<!-- 报表文件上传下载 -->
	<div class="neirong" id="subReportFileUploadPanel" style="display:none;width:560px;">
		<div class="top">
			<div class="top_01" id="thisdrag">
				<div class="top_01left">
					<div class="top_02">
						<img src="style/images/public/neibut01.gif" />
					</div>
					<div class="top_03" id="titlediv">
						子报表文件上传下载
					</div>
					<div class="top_04">
						<img src="style/images/public/neibut03.gif" />
					</div>
				</div>
				<div class="top_01right">
					<a href="javascript:;" onclick="javascript:$('#subReportFileUploadClose').click();">关闭</a>
				</div>
			</div>
			<div class="top02right">
				<img src="style/images/public/toptiaoright.gif" />
			</div>	
		</div>
	
		<div class="midd" style="background-color:#FFFFFF;text-align:left;width:558px;height:200px;font-size:14px;">
			
			<form action="upfile" method="post"	enctype="multipart/form-data">
				<table id="subReportFileUploadTab" width="60%" border="0" bordercolor="#eeeeee" cellspacing="0" cellpadding="1" align="center" style="font-size:14px;">
					<tr>
						<td>浏览文件：</td>
						<td><input name="subupfile" type="file" id="subupfile" onkeydown="return false" size="30" /></td>
					</tr>
					<tr></tr>
				</table>
			</form>
		</div>
	
		<div class="midd_butt">
			<button type="button" class="tsdbutton" id="subReportFileUploadUpload" onclick="uploadSubFile()">
				上传
			</button>
			<button type="button" class="tsdbutton" id="subReportFileUploadClose">
				关闭
			</button>
		</div>
	</div>
	

	
	<!-- 菜单ID -->
	<input type="hidden" id="iimenuid" name="iimenuid" value='<%=imenuid %>' />
	<input type="hidden" id="zid" name="zid"  value='<%=zid %>' />
	<!-- 语言 -->
	<input type="hidden" id="lanType" name="lanType" value='<%=languageType %>' />
	
	<input type="hidden" id="subid" name="subid" />
	
	<input type="hidden" id="area" name="area" value='<%=session.getAttribute("chargearea") %>' />
	<input type="hidden" id="userarea" name="userarea" value='<%=session.getAttribute("userarea") %>' />
	<input type="hidden" id="userid" name="userid" value='<%=session.getAttribute("userid") %>' />
	
	<input type='hidden' id='userloginip' value='<%=Log.getIpAddr(request) %>' /> 
	<input type='hidden' id='userloginid' value='<%=session.getAttribute("userid") %>' /> 
	<!-- 上传标识 -->
	<input type="hidden" id="identify"/>
	
  </body>
</html>
